notify-send "recording with no sound..." "now it's recording the whole screen" -i /usr/share/icons/Papirus-Dark/16x16/actions/record.svg
ffmpeg -video_size 1366x768 -r 30 -f x11grab -i $DISPLAY $HOME/FIX_WIN_COMPATIBILITY_NO_SOUND-$(date '+%Y-%m-%d_%R').mp4; notify-send "recording stoped" "the video saved in your home dir" -i /usr/share/icons/Papirus-Dark/16x16/actions/checkbox.svg
