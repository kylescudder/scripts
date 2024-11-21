#!/bin/bash
song_info=$(playerctl metadata --format '{{title}}      {{artist}}' | sed 's/&/\&amp;/g')
echo "$song_info"
