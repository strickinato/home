;;; strick-light-theme.el --- a minimalistic theme with lavender and teal highlights -*- lexical-binding: t; no-byte-compile: t; -*-
;;
;; Author: Aaron Strick
;; Maintainer: Aaron Strick
;; Source: Based on strick-theme, but flipped to be light
;;
;;; Commentary:
;;
;; This is based on some ideas in this blog post: https://tonsky.me/blog/syntax-highlighting/
;; 
;; A light theme with very light background, featuring darkened lavender and teal
;; highlights. Emphasize definitions, constants, strings, and comments
;; while keeping keywords, types, and common elements at default foreground.
;;
;;
;;; Code:

(require 'doom-themes)


;;
;;; Variables

(defgroup strick-theme nil
  "Options for the `strick' theme."
  :group 'doom-themes)

(defcustom strick-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'strick-theme
  :type '(choice integer boolean))


;;
;;; Theme definition

(def-doom-theme strick-light
    "A light theme with lavender and teal, following alabaster philosophy"
  :family 'strick
  :background-mode 'light

  ;; name        default   256       16
  ((bg         '("#fefefe" nil       nil            ))
   (bg-alt     '("#f8f8f9" nil       nil            ))
   (base0      '("#f0f0f0" "#f0f0f0" "white"        ))
   (base1      '("#e7e7e7" "#e7e7e7" "brightblack"  ))
   (base2      '("#dfdfdf" "#dfdfdf" "brightblack"  ))
   (base3      '("#c6c7c7" "#c6c7c7" "brightblack"  ))
   (base4      '("#9ca0a4" "#9ca0a4" "brightblack"  ))
   (base5      '("#5B6268" "#525252" "brightblack"  ))
   (base6      '("#3f444a" "#3f3f3f" "brightblack"  ))
   (base7      '("#202328" "#2e2e2e" "brightblack"  ))
   (base8      '("#1B2229" "black"   "black"        ))
   (fg         '("#383a42" "#424242" "black"        ))
   (fg-alt     '("#c6c7c7" "#c7c7c7" "brightblack"  ))

   (grey       base5)
   (red        '("#e45649" "#e45649" "red"          ))  ; From doom-homage-white
   (orange     '("#8a3b3c" "#dd8844" "brightred"    ))  ; From doom-homage-white
   (green      '("#556b2f" "#556b2f" "green"        ))  ; From doom-homage-white
   (teal       '("#008080" "#008080" "brightgreen"  ))  ; Darkened teal for light bg
   (yellow     '("#986801" "#986801" "yellow"       ))  ; From doom-homage-white
   (blue       '("#0170bf" "#0170bf" "brightblue"   ))
   (dark-blue  '("#014980" "#014980" "blue"         ))
   (magenta    '("#7c3aed" "#7c3aed" "brightmagenta"))  ; Darkened violet for light bg
   (violet     '("#7c3aed" "#7c3aed" "magenta"      ))  ; Darkened violet for light bg
   (cyan       '("#0184bc" "#0184bc" "brightcyan"   ))  ; Darker cyan for docs
   (dark-cyan  '("#005478" "#005478" "cyan"         ))  ; From doom-homage-white

   ;; face categories -- 4 main syntax colors:
   ;; 1. foreground (fg) - dark gray for keywords, operators, etc
   ;; 2. violet (darkened purple) - types and function declarations
   ;; 3. teal (darkened teal) - strings and numbers
   ;; 4. cyan (darker blue) - documentation
   (highlight      violet)
   (vertical-bar   (doom-darken base2 0.1))
   (selection      (doom-lighten teal 0.7))
   (builtin        fg)                    ; foreground
   (comments       cyan)                    ; foreground
   (doc-comments   cyan)                  ; bright light blue
   (constants      teal)                  ; bright teal
   (functions      violet)                ; lavender
   (keywords       fg)                    ; foreground
   (methods        fg)                    ; foreground
   (operators      fg)                    ; foreground
   (type           violet)                ; lavender
   (strings        teal)                  ; bright teal
   (variables      violet)                ; lavender
   (numbers        teal)                  ; bright teal
   (region         (doom-lighten teal 0.7))
   (error          red)                   ; Keep red for errors
   (warning        yellow)
   (success        green)                 ; Keep green for success
   (vc-modified    orange)
   (vc-added       green)                 ; Keep green for additions
   (vc-deleted     red)                   ; Keep red for deletions

   ;; custom categories
   (-modeline-bright t)
   (-modeline-pad
    (when strick-padded-modeline
      (if (integerp strick-padded-modeline) strick-padded-modeline 4)))

   (modeline-fg     'unspecified)
   (modeline-fg-alt (doom-blend violet base4 (if -modeline-bright 0.5 0.2)))

   (modeline-bg
    (if -modeline-bright
        (doom-darken base2 0.05)
      base1))
   (modeline-bg-l
    (if -modeline-bright
        (doom-darken base2 0.1)
      base2))
   (modeline-bg-inactive (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(doom-darken (car bg-alt) 0.05) ,@(cdr base1))))

  ;;;; Base theme face overrides
  ((font-lock-builtin-face       :inherit 'bold :foreground fg)
   (font-lock-function-name-face :inherit 'bold :foreground functions)
   (font-lock-keyword-face       :inherit 'bold :foreground fg)
   (font-lock-type-face          :inherit 'bold :foreground violet)
   ((hl-line &override) :background "#ffe6f0")
   ;; TEST: If you see this error when loading, the file IS being read
   ((test-face-to-verify-load &override) :foreground "#ff0000")
   ((line-number &override) :foreground (doom-lighten base4 0.15))
   ((line-number-current-line &override) :foreground base8)
   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis :foreground (if -modeline-bright base8 highlight))
   (tooltip :background base1 :foreground fg)
   ((secondary-selection &override) :background base0)

   ;;;; centaur-tabs
   (centaur-tabs-unselected :background bg-alt :foreground base4)
   ;;;; css-mode <built-in> / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)
   ;;;; doom-modeline
   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))
   ;;;; ediff <built-in>
   (ediff-current-diff-A        :foreground red   :background (doom-lighten red 0.8))
   (ediff-current-diff-B        :foreground green :background (doom-lighten green 0.8))
   (ediff-current-diff-C        :foreground blue  :background (doom-lighten blue 0.8))
   (ediff-current-diff-Ancestor :foreground teal  :background (doom-lighten teal 0.8))
   ;;;; magit
   ((magit-diff-hunk-heading           &override) :foreground fg    :background bg-alt :bold bold)
   ((magit-diff-hunk-heading-highlight &override) :foreground base8 :background bg-alt :bold bold)
   (magit-blame-heading     :foreground orange :background bg-alt)
   (magit-diff-removed :foreground (doom-darken red 0.2) :background (doom-blend red bg 0.1))
   (magit-diff-removed-highlight :foreground red :background (doom-blend red bg 0.2) :bold bold)
   ;;;; markdown-mode
   (markdown-markup-face     :foreground base5)
   (markdown-header-face     :inherit 'bold :foreground red)
   ((markdown-code-face &override)       :background base1)
   (mmm-default-submode-face :background base1)
   ;;;; mu4e
   (mu4e-highlight-face :background bg :inherit 'bold)
   ;;;; helm
   (helm-candidate-number :background blue :foreground bg)
   ;;;; ivy
   ;; bg/fg are too close
   ((ivy-minibuffer-match-face-1 &override) :foreground (doom-lighten grey 0.70))
   ;;;; ivy-posframe
   (ivy-posframe               :background base0)
   ;;;; lsp-mode
   (lsp-ui-doc-background      :background base0)
   (lsp-face-highlight-read    :background (doom-blend red bg 0.3))
   (lsp-face-highlight-textual :inherit 'lsp-face-highlight-read)
   (lsp-face-highlight-write   :inherit 'lsp-face-highlight-read)
   ;;;; outline <built-in>
   ((outline-1 &override) :foreground violet :inherit 'bold :height 1.3)
   ((outline-2 &override) :foreground (doom-darken violet 0.1) :inherit 'bold :height 1.2)
   ((outline-3 &override) :foreground (doom-darken violet 0.2) :inherit 'bold :height 1.1)
   ((outline-4 &override) :foreground (doom-darken violet 0.3) :inherit 'bold)
   ((outline-5 &override) :foreground (doom-darken violet 0.4))
   ((outline-6 &override) :foreground (doom-darken violet 0.5))
   ((outline-7 &override) :foreground (doom-darken violet 0.6))
   ((outline-8 &override) :foreground (doom-darken violet 0.65))
   ;;;; org <built-in>
   ;; make unfinished cookie & todo keywords bright to grab attention
   ((org-todo &override) :foreground red)
   ;; make tags and dates to have pretty box around them
   ((org-tag &override)   :foreground fg :background base1
    :box `(:line-width -1 :color ,base5 :style released-button))
   ((org-date &override)  :foreground fg :background base1
    :box `(:line-width -1 :color ,base5 :style released-button))
   ;; Make drawers and special keywords (like scheduled) to be very bleak
   ((org-special-keyword &override)  :foreground grey)
   ((org-drawer          &override)  :foreground grey)
   ;; Make ellipsis as bleak as possible and reset underlines/boxing
   (org-ellipsis :underline nil :box nil :foreground fg :background bg)
   ;; Make blocks have a slightly different background
   ((org-block &override) :background base1)
   ((org-block-begin-line &override) :foreground fg :slant 'italic)
   ((org-quote &override) :background base1)
   ((org-table &override) :foreground fg)
   ((org-verbatim &override) :foreground teal)
   ((org-code &override) :foreground teal)
   ;; org-agendamode: make "unimportant" things like distant deadlines and
   ;; things scheduled for today to be bleak.
   (org-upcoming-deadline         :foreground base8)
   (org-upcoming-distant-deadline :foreground fg)
   (org-scheduled                 :foreground fg)
   (org-scheduled-today           :foreground fg)
   (org-scheduled-previously      :foreground base8)
   ;;;; solaire-mode
   (solaire-hl-line-face :background "#ffe6f0")
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))
   ;;;; swiper
   ;; bg/fg are too close
   ((swiper-match-face-1 &override) :background fg        :foreground bg)
   ((swiper-line-face    &override) :background (doom-lighten teal 0.7) :foreground fg)
   ;;;; vertico
   ((vertico-current &override) :background "#ffe6f0" :foreground fg :weight 'bold :extend t)
   ;;;; completions
   (completions-highlight :background "#ffe6f0" :foreground fg)
   ((company-tooltip-selection &override) :background "#ffe6f0")
   ((corfu-current &override) :background "#ffe6f0")
   ;;;; web-mode
   (web-mode-current-element-highlight-face :background dark-blue :foreground bg)
   ;;;; wgrep <built-in>
   (wgrep-face :background base1))

  ;;;; Base theme variable overrides-
  ())

;;; strick-light-theme.el ends here
