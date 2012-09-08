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
