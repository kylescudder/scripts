#!/bin/bash

# Enable debug logging for the script
set -e  # Exit on any error
exec 1> >(tee "plex_update_$(date +%Y%m%d_%H%M%S).log")
exec 2>&1

echo "=== Starting Plex Update Script ==="
echo "Timestamp: $(date)"

# Configuration
HOST="192.168.0.8"
USER="root"
SOURCE_PATH="$HOME/Downloads/plexmediaserver"
DEST_PATH="/mnt/tank/iocage/jails/plex/root/usr/local/share"

# Function to log with timestamp
log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1"
}

# Debug information about execution context
log "=== Execution Context ==="
log "Script running as user: $(whoami)"
log "User home directory: $HOME"
log "Current working directory: $(pwd)"
log "Full path to script: $(readlink -f "$0")"
log "Effective user ID: $(id -u)"
log "Effective group ID: $(id -g)"
log "Groups membership: $(groups)"

# Debug information about the target file and directory
log "=== File Location Debugging ==="
log "Looking for source file at: $(readlink -f "$SOURCE_PATH")"
log "Parent directory contents:"
ls -la "$(dirname "$(readlink -f "$SOURCE_PATH")")" 2>/dev/null || log "Cannot access parent directory"

# Check if the file exists and show its permissions
if [ -e "$SOURCE_PATH" ]; then
    log "File exists! Permissions:"
    ls -l "$SOURCE_PATH"
    
    if [ -r "$SOURCE_PATH" ]; then
        log "File is readable by current user"
    else
        log "ERROR: File is not readable by current user"
    fi
    
    # Show file attributes
    log "File attributes:"
    lsattr "$SOURCE_PATH" 2>/dev/null || log "Cannot get file attributes"
else
    log "File does not exist at specified path"
    
    # Try to find the file using find
    log "Searching for file in current directory and subdirectories:"
    find . -name "plexmediaserver" -type f 2>/dev/null | while read -r file; do
        log "Found potential match: $file"
        ls -l "$file"
    done
fi

# Show the actual commands that would be executed
log "=== Commands that would be executed ==="
log "SCP command: scp -v \"$SOURCE_PATH\" \"${USER}@${HOST}:${DEST_PATH}\""

# Ask for confirmation before proceeding
read -p "Would you like to proceed with the file copy? (y/n) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    log "Operation cancelled by user"
    exit 1
fi


# Test SSH connection
log "Testing SSH connection..."
if ! ssh -q "${USER}@${HOST}" exit; then
    log "ERROR: SSH connection failed. Please check your SSH key configuration"
    log "Try running: ssh-copy-id ${USER}@${HOST}"
    exit 1
else
    log "SSH connection successful"
fi

# Copy the Plex Media Server files
log "Copying Plex Media Server files..."
if scp -v -r "$SOURCE_PATH" "${USER}@${HOST}:${DEST_PATH}"; then
    log "File copy successful"
else
    log "ERROR: File copy failed"
    exit 1
fi

# Execute commands on remote server
log "Configuring permissions and symlinks..."
if ssh "${USER}@${HOST}" "
    set -e
    cd '${DEST_PATH}' || {
        echo 'Failed to change to destination directory'
        exit 1
    }
    echo 'Setting permissions on plexmediaserver directory...'
    chmod -R 755 plexmediaserver || {
        echo 'Failed to set permissions'
        exit 1
    }
    cd plexmediaserver || {
        echo 'Failed to enter plexmediaserver directory'
        exit 1
    }
    echo 'Creating symlink...'
    ln -sf 'Plex Media Server' Plex_Media_Server || {
        echo 'Failed to create symlink'
        exit 1
    }
    echo 'Setting symlink permissions...'
    chmod -h 775 Plex_Media_Server || {
        echo 'Failed to set symlink permissions'
        exit 1
    }
    echo 'All commands completed successfully'
"; then
    log "Remote configuration successful"
else
    log "ERROR: Remote configuration failed"
    exit 1
fi

log "=== Plex Update Completed Successfully ==="
