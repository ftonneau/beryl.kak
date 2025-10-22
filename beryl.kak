# A color theme for Kakoune.
# Author: François Tonneau

# This theme has been designed with a dark background in mind. Optional commands
# allow you to highlight a column range or to change insert-mode cursor colors.

# COLOR DEFINITIONS

declare-option -hidden str beryl_band      rgb:6c6c6c       # xterm color 242

declare-option -hidden str beryl_black     rgb:080808       # xterm color 232
declare-option -hidden str beryl_gray_15   rgb:262626       # xterm color 235
declare-option -hidden str beryl_gray_42   rgb:6c6c6c       # xterm color 242
declare-option -hidden str beryl_gray_54   rgb:8a8a8a       # xterm color 245
declare-option -hidden str beryl_gray_62   rgb:9e9e9e       # xterm color 247
declare-option -hidden str beryl_gray_82   rgb:d0d0d0       # xterm color 252
declare-option -hidden str beryl_gray_93   rgb:eeeeee       # xterm color 255
declare-option -hidden str beryl_white     rgb:ffffff       # xterm color 231

declare-option -hidden str beryl_alice     rgb:afd7d7       # xterm color 152
declare-option -hidden str beryl_azure     rgb:00d7ff       # xterm color 045
declare-option -hidden str beryl_blue      rgb:0087af       # xterm color 031
declare-option -hidden str beryl_blueish   rgb:87afaf       # xterm color 111
declare-option -hidden str beryl_bronze    rgb:afaf87       # xterm color 144
declare-option -hidden str beryl_brown     rgb:5f0000       # xterm color 052
declare-option -hidden str beryl_green     rgb:afd7af       # xterm color 151
declare-option -hidden str beryl_mauve     rgb:af87af       # xterm color 139
declare-option -hidden str beryl_orange    rgb:ffd7af       # xterm color 223
declare-option -hidden str beryl_red       rgb:af5f5f       # xterm color 131
declare-option -hidden str beryl_ruby      rgb:ff8787       # xterm color 210
declare-option -hidden str beryl_yellow    rgb:ffffd7       # xterm color 230

# COLORS FOR BUILTINS

set-face global Default            "default,default"

set-face global PrimarySelection   "%opt(beryl_white),%opt(beryl_red)"
set-face global SecondarySelection "%opt(beryl_black),%opt(beryl_bronze)"
set-face global PrimaryCursor      "%opt(beryl_black),%opt(beryl_white)"
set-face global SecondaryCursor    "%opt(beryl_black),%opt(beryl_gray_82)"
set-face global PrimaryCursorEol   "%opt(beryl_black),%opt(beryl_gray_82)"
set-face global SecondaryCursorEol "%opt(beryl_black),%opt(beryl_gray_54)"

set-face global MenuForeground     "%opt(beryl_black),%opt(beryl_blueish)"
set-face global MenuBackground     "%opt(beryl_black),%opt(beryl_gray_93)"
set-face global MenuInfo           "%opt(beryl_brown),%opt(beryl_gray_93)"
set-face global Information        "%opt(beryl_white)"
set-face global Error              "%opt(beryl_yellow),default+b"

set-face global StatusLine         "%opt(beryl_white)"
set-face global StatusLineMode     "%opt(beryl_black),%opt(beryl_yellow)"
set-face global StatusLineInfo     "%opt(beryl_black),%opt(beryl_gray_93)"
set-face global StatusLineValue    "%opt(beryl_black),%opt(beryl_blueish)"
set-face global StatusCursor       "%opt(beryl_black),%opt(beryl_gray_93)"
set-face global Prompt             "%opt(beryl_black),%opt(beryl_gray_93)"

set-face global LineNumbers        "%opt(beryl_gray_62)"
set-face global LineNumberCursor   "%opt(beryl_yellow)"
set-face global LineNumbersWrapped "%opt(beryl_gray_15)"

set-face global BufferPadding      "%opt(beryl_gray_15)"
set-face global MatchingChar       "%opt(beryl_black),%opt(beryl_mauve)"
set-face global Whitespace         "%opt(beryl_gray_62)"

# COLORS FOR CODE

set-face global type               "%opt(beryl_orange)"
set-face global value              "%opt(beryl_yellow)"
set-face global variable           "%opt(beryl_alice)"

set-face global attribute          "%opt(beryl_mauve)"
set-face global builtin            "%opt(beryl_mauve)"
set-face global comment            "%opt(beryl_gray_62),default+i"
set-face global function           "%opt(beryl_white)"
set-face global identifier         "default,default"
set-face global keyword            "%opt(beryl_blueish)"
set-face global meta               "%opt(beryl_ruby)"
set-face global module             "%opt(beryl_blueish)"
set-face global operator           "%opt(beryl_orange)"
set-face global string             "%opt(beryl_green)"

# COLORS FOR MARKUP

set-face global header             "%opt(beryl_blueish),default+b"
set-face global title              "%opt(beryl_blueish),default+b"

set-face global block              "%opt(beryl_bronze)"
set-face global bullet             "%opt(beryl_green),default+b"
set-face global list               "%opt(beryl_green)"
set-face global link               "%opt(beryl_yellow),default+b"

set-face global mono               "%opt(beryl_blueish),default+b"
set-face global bold               "%opt(beryl_yellow),default+b"
set-face global italic             "%opt(beryl_yellow),default"
set-face global subscript          "%opt(beryl_orange)"
set-face global superscript        "%opt(beryl_orange)"

# COMMANDS FOR COLOR BAND AND CURSOR

define-command \
-docstring \
'beryl-add-band <column> <width>: colorize a column range' \
-override \
-params 1..2 \
beryl-add-band %{
    try %{
        remove-highlighter window/beryl-band
    }
    add-highlighter window/beryl-band group
    evaluate-commands %sh{
        start=$1
        width=${2:-1}
        stop=$((start + width))
        color=$kak_opt_beryl_band
        column=$start
        while [ $column -lt $stop ]; do
            printf %s    "add-highlighter window/beryl-band/$column "
            printf %s\\n "column $column default,$color"
            column=$((column + 1))
        done
    }
}

define-command \
-docstring \
'Remove colored column range' \
-override \
beryl-remove-band %{
    remove-highlighter window/beryl-band
}

define-command \
-docstring \
'Make cursor colors more vidid' \
-override \
beryl-vivify-cursor %{
    set-face global PrimaryCursor      "%opt(beryl_black),%opt(beryl_azure)"
    set-face global SecondaryCursor    "%opt(beryl_black),%opt(beryl_alice)"
    set-face global PrimaryCursorEol   "%opt(beryl_black),%opt(beryl_blue)"
    set-face global SecondaryCursorEol "%opt(beryl_black),%opt(beryl_blueish)"
}

define-command \
-docstring \
'Make cursor colors less vidid' \
-override \
beryl-dampen-cursor %{
    set-face global PrimaryCursor      "%opt(beryl_black),%opt(beryl_white)"
    set-face global SecondaryCursor    "%opt(beryl_black),%opt(beryl_gray_82)"
    set-face global PrimaryCursorEol   "%opt(beryl_black),%opt(beryl_gray_82)"
    set-face global SecondaryCursorEol "%opt(beryl_black),%opt(beryl_gray_54)"
}

define-command \
-docstring \
'Make cursor change color in Insert mode' \
-override \
beryl-enable-changing-cursor %{
    try %{
        remove-hooks window beryl-cursor
    }
    hook -group beryl-cursor window ModeChange .*:.*:insert beryl-vivify-cursor
    hook -group beryl-cursor window ModeChange .*:insert:.* beryl-dampen-cursor
}

define-command \
-docstring \
'Disable changes in cursor color' \
-override \
beryl-disable-changing-cursor %{
    remove-hooks window beryl-cursor
}

