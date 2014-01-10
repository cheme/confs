--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import XMonad
import Data.Monoid
import System.Exit
import XMonad.Actions.SimpleDate
import XMonad.Actions.NoBorders
import XMonad.Hooks.ManageHelpers
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Layout.Tabbed
import XMonad.Layout.Accordion
import XMonad.Layout.TwoPane
import XMonad.Layout.Combo
import XMonad.Layout.WindowNavigation
import qualified XMonad.StackSet as W
import qualified Data.Map        as M
import XMonad.Util.Replace

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal      = "urxvtcl"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

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
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#dddddd"
myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)
    -- TODO change binding or replace by layout alternative
    , ((modm,               xK_d ), withFocused toggleBorder)
    -- launch dmenu
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"")
    -- disable primary mouse (touchpad)
    , ((modm .|. shiftMask, xK_k     ), spawn "tmpvar=$(xinput | grep PS/2 | sed '1 s/.*id=\\([0-9]*\\).*/\\1/') && xinput --enable $tmpvar")
    , ((modm              , xK_k     ), spawn "tmpvar=$(xinput | grep PS/2 | sed '1 s/.*id=\\([0-9]*\\).*/\\1/') && xinput --disable $tmpvar")
    -- launch openbox
    , ((modm .|. shiftMask, xK_o     ), restart "/home/emeric/bin/obtoxmd" True)
    -- launch gmrun
    --    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun")
    -- switch wall
    , ((modm,               xK_w     ), spawn "sh /home/emeric/.chwall.sh")
    
    -- mpc controlls
     -- next
    , ((modm,               xK_Page_Down), spawn "mpc next")
    -- prev 
    , ((modm,               xK_Page_Up  ), spawn "mpc prev")
    -- fw
    , ((modm .|. shiftMask, xK_Page_Down), spawn "mpc seek +1%")
    -- bw 
    , ((modm .|. shiftMask, xK_Page_Up  ), spawn "mpc seek -1%")
    -- pause 
    , ((modm              , xK_End  ), spawn "mpc toggle")
    -- XF86_AudioMute code get with xev (ou xev  | sed -ne '/^KeyPress/,/^$/p')  
    , ((modm              , 0x1008ff12), spawn "mpc volume 0")

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_h     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_t     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_s     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_t     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_s     ), windows W.swapUp    )
    , ((modm          , xK_Up     ), sendMessage $ Move U    )
    , ((modm, xK_Down     ),sendMessage $ Move  D    )
    , ((modm, xK_Right     ),sendMessage $ Move R    )
    , ((modm, xK_Left     ), sendMessage $ Move L    )

    -- Shrink the master area
    , ((modm,               xK_c     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_r     ), sendMessage Expand)

    -- Push window float 
    , ((modm,               xK_f     ), withFocused float)

    -- Push window back into tiling
    , ((modm .|. shiftMask, xK_f     ), withFocused $ windows . W.sink)

    , ((modm .|. shiftMask, xK_Delete), spawn "sudo shutdown -h now")
    
    , ((modm,               xK_Delete), spawn "sudo pm-suspend")

    -- Increment the number of windows in the master area
    , ((modm .|. shiftMask, xK_c ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm .|. shiftMask, xK_r ), sendMessage (IncMasterN (-1)))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_q     ), io exitSuccess)

    -- close focused window
    , ((modm              , xK_q     ), kill)

    -- Restart xmonad
    , ((modm .|. shiftMask, xK_h     ), spawn "xmonad --recompile; xmonad --restart")

    -- Prompt
    , ((modm,               xK_h     ), shellPrompt defaultXPConfig)
    
    -- simple clock 
    , ((modm .|. shiftMask, xK_b     ), date)
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_quotedbl, xK_guillemotleft, xK_guillemotright, xK_parenleft, xK_parenright, xK_at, xK_plus, xK_minus, xK_slash]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_eacute, xK_p, xK_o] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), \w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster)

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), \w -> focus w >> windows W.shiftMaster)

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), \w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster)

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
myLayout = tiled ||| Mirror tiled ||| myTabbed ||| myComboTabbed ||| Full ||| Accordion
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100

     myTabbed  = simpleTabbed 
     
     myComboTabbed  = windowNavigation $ combineTwo (TwoPane 0.03 0.7) simpleTabbed (Mirror $ Tall 1 0.03 0.5)

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
    , className =? "mpv"            --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Xarchiver"      --> doFloat
    , className =? "UE4-Linux-Test"  --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore 
    , isFullscreen --> doFullFloat -- fullscreen flash and stuff
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = mempty

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
  replace
  xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = defaultConfig {
      -- simple stuff
        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }
