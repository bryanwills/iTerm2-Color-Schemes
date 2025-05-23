#!/bin/sh
# GruvboxLight

# source for these helper functions:
# https://github.com/chriskempson/base16-shell/blob/master/templates/default.mustache
if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  "fb/f1/c7"
put_template 1  "9d/00/06"
put_template 2  "79/74/0e"
put_template 3  "b5/76/14"
put_template 4  "07/66/78"
put_template 5  "8f/3f/71"
put_template 6  "42/7b/58"
put_template 7  "3c/38/36"
put_template 8  "9d/83/74"
put_template 9  "cc/24/1d"
put_template 10 "98/97/1a"
put_template 11 "d7/99/21"
put_template 12 "45/85/88"
put_template 13 "b1/61/86"
put_template 14 "68/9d/69"
put_template 15 "7c/6f/64"

color_foreground="28/28/28"
color_background="fb/f1/c7"

if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg "282828"
  put_template_custom Ph "fbf1c7"
  put_template_custom Pi "ffffff"
  put_template_custom Pj "d5c4a1"
  put_template_custom Pk "665c54"
  put_template_custom Pl "282828"
  put_template_custom Pm "fbf1c7"
else
  put_template_var 10 $color_foreground
  put_template_var 11 $color_background
  if [ "${TERM%%-*}" = "rxvt" ]; then
    put_template_var 708 $color_background # internal border (rxvt)
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom

unset color_foreground
unset color_background
