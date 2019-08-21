## Setup with Ubuntu

```
cd  ~
# git clone repo
ln -s xMonad .xmonad
ln -s .xmonad/xmonad-session-rc .xsessionrc
ln -s .xmonad/stalonetrarrc .stalonetrayrc
```

Put in bashrc for dual monitors
xrandr --output HDMI-0 --left-of LVDS --output LVDS --auto