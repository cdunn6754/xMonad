import System.IO
import System.Exit
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.Fullscreen
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = do
    xmproc <- spawnPipe "xmobar ++ xmobarrc"
    xmonad $ myConfig {
      manageHook = manageDocks <+> manageHook defaultConfig
      , layoutHook = avoidStruts $ layoutHook defaultConfig
      , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor xmobarTitleColor "" . shorten 30
                        , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor ""
                        , ppSep = "   "
                        }
      , startupHook = setWMName "LG3D"                        
      , handleEventHook = docksEventHook
    }

myKeys =
  [
    -- ((modMask .|. controlMask, xK_z),
    --   spawn slock)
  ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [1,0,0] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]


-- xMobar
xmobarTitleColor = "#FFB6B0"
xmobarCurrentWorkspaceColor = "#CEFFAC"
myXmobarrc = "~/.xmonad/xmobar.hs"

-- Workspaces
myWorkspaces = ["1:code/term","2:web","3:code","4:vm","5:media"] ++ map show [6..9]

-- General
myBorderWidth = 4
myFocusedBorderColor = "#ffff00"
myModMask = mod3Mask -- use xmodmap to change mod keys if necessary
myTerminal = "urxvt"

myConfig = defaultConfig {
     borderWidth = myBorderWidth
--     , terminal = myTerminal
     , focusedBorderColor = myFocusedBorderColor
     , modMask = myModMask
     , workspaces = myWorkspaces
     } `additionalKeysP` myKeys
