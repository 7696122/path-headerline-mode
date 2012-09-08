;;; path-headerline-mode.el ---
;;
;; Filename: path-headerline-mode.el
;; Description:
;; Author: 7696122
;; Maintainer:
;; Created: Sat Sep  8 11:44:11 2012 (+0900)
;; Version: 0.1
;; Last-Updated: Sat Sep  8 11:44:33 2012 (+0900)
;;           By: 7696122
;;     Update #: 1
;; URL:
;; Keywords:
;; Compatibility:
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Change Log:
;;
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth
;; Floor, Boston, MA 02110-1301, USA.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Code:


;; -*- mode: Emacs-Lisp; coding: utf-8 -*-

(defmacro with-face (str &rest properties)
  `(propertize ,str 'face (list ,@properties)))

(defun ph/make-header ()
  ""
  (let* ((ph/full-header (abbreviate-file-name buffer-file-name))
         (ph/header (file-name-directory ph/full-header))
         (ph/drop-str "[...]"))
    (if (> (length ph/full-header)
           (window-body-width))
        (if (> (length ph/header)
               (window-body-width))
            (progn
              (concat (with-face ph/drop-str
                                 :background "blue"
                                 :weight 'bold
                                 )
                      (with-face (substring ph/header
                                            (+ (- (length ph/header)
                                                  (window-body-width))
                                               (length ph/drop-str))
                                            (length ph/header))
                                 ;; :background "red"
                                 :weight 'bold
                                 )))
          (concat (with-face ph/header
                             ;; :background "red"
                             :foreground "#8fb28f"
                             :weight 'bold
                             )))
      (concat (with-face ph/header
                         ;; :background "green"
                         ;; :foreground "black"
                         :weight 'bold
                         :foreground "#8fb28f"
                         )
              (with-face (file-name-nondirectory buffer-file-name)
                         :weight 'bold
                         ;; :background "red"
                         )))))

(defun ph/display-header ()
  (setq header-line-format
        '("" ;; invocation-name
          (:eval (if (buffer-file-name)
                     (ph/make-header)
                   "%b")))))



(add-hook 'buffer-list-update-hook
          'ph/display-header)

(provide 'path-headerline-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; path-headerline-mode.el ends here
