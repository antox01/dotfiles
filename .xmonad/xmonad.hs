import XMonad
import Data.Monoid
import System.Exit
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.WorkspaceHistory
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "alacritty"

myWebBrowser :: String
myWebBrowser    = "firefox"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth   = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = [" DEV "," WWW "," CHAT "," GFX "," DOC "," MUS "," VID "]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#d0d0d0"
myFocusedBorderColor = "#ac4142"


windowCount :: X (Maybe String)
windowCount = gets $ Just . show . length . W.integrate' . W.stack . W.workspace . W.current . windowset

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
ezKeys :: [(String, X ())]
ezKeys =
    [ ("M-w", spawn myWebBrowser)

    -- Launch the terminal emulator
    , ("M-<Return>", spawn myTerminal)

    -- launch dmenu
    , ("M-d", spawn "dmenu_run")

    -- close focused window
    , ("M-q", kill)

     -- Rotate through the available layout algorithms
    , ("M-<Space>", sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    -- , ("M-S-<Space>", setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ("M-n", refresh)

    -- Move focus to the next window
    , ("M-<Tab>", windows W.focusDown)

    -- Move focus to the next window
    , ("M-j", windows W.focusDown)

    -- Move focus to the previous window
    , ("M-k", windows W.focusUp  )

    -- Move focus to the master window
    , ("M-m", windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ("M-S-<Return>", windows W.swapMaster)

    -- Swap the focused window with the next window
    , ("M-S-j", windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ("M-S-k", windows W.swapUp    )

    -- Shrink the master area
    , ("M-h", sendMessage Shrink)

    -- Expand the master area
    , ("M-l", sendMessage Expand)

    -- Push window back into tiling
    , ("M-t", withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ("M-,", sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ("M-.", sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ("M-S-q", io (exitWith ExitSuccess))

    -- Restart xmonad
    , ("M-S-r", spawn "xmonad --recompile; xmonad --restart")

    -- Take a screenshot of the current screen
    , ("<Print>", spawn "scrot ~/Immagini/screenshot/scrot-$(date -I'minutes').png -m e 'xclip -selection c -t image/png < $f'")

    -- Media keys configuration
    -- Mute the speaker
    , ("<XF86AudioMute>", spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")

    -- Raise the volume of the speaker
    , ("<XF86AudioRaiseVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ +5%")

    -- Lower the volume of the speaker
    , ("<XF86AudioLowerVolume>", spawn "pactl set-sink-volume @DEFAULT_SINK@ -5%")

    -- Mute the microphone
    , ("<XF86AudioMicMute>", spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    ]
    ++
    [ (otherModMasks ++ "M-" ++ key, action tag)
        | (tag, key)  <- zip myWorkspaces (map (\x -> "" ++ show x) [1..7])
        , (otherModMasks, action) <- [ ("", windows . W.greedyView) -- or W.view
                                     , ("S-", windows . W.shift)]
    ]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = docksEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = return ()
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
        spawnOnce "nitrogen --restore &"
        spawnOnce "picom &"
        -- spawnOnce "nm-applet &"
        spawnOnce "xsetroot -cursor_name left_ptr"
        setWMName "LG3D"

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmproc <- spawnPipe "xmobar ~/.config/xmobar/xmobar.config"
    xmonad $ ewmh def {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        --manageHook         = myManageHook,
        handleEventHook    = myEventHook <+> fullscreenEventHook,
        --logHook            = myLogHook,
     -- this adds Xmobar to Xmonad
        logHook = workspaceHistoryHook <+> dynamicLogWithPP xmobarPP {
                            ppOutput = hPutStrLn xmproc
                            , ppCurrent = xmobarColor "#151515" "#98be65"
                            , ppVisible = xmobarColor "#151515" "#98be65"
                            , ppHidden = xmobarColor "#6a9fb5" ""
                            , ppHiddenNoWindows = xmobarColor "#f4bf75" ""
                            , ppUrgent = xmobarColor "#151515" "#d0d0d0"
                            , ppTitle = xmobarColor "#d0d0d0" "" . shorten 40
                            , ppSep = " | " -- "<fc=#666666> <fn=1>|</fn> </fc>"
                            , ppExtras = [windowCount]
                            , ppOrder = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                            },

    -- this adds a second fixup for docks
        manageHook = manageDocks <+> manageHook def,
        startupHook        = myStartupHook
    } `additionalKeysP` ezKeys

