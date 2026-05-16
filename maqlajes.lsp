(vl-load-com)

(defun c:MAQLAJES ( / ss i ent ed tipo lay alt txt)

  ;; ================================
  ;; CRIAR ESTILO ROMANS
  ;; ================================
  (if (not (tblsearch "STYLE" "ROMANS"))
    (command "-STYLE" "ROMANS" "romans.shx" "0" "1" "0" "N" "N" "N")
  )

  ;; ================================
  ;; SELE��O MANUAL
  ;; ================================
  (princ "\nSelecione os objetos da laje...")
  (setq ss (ssget))
  (if (not ss)
    (progn (princ "\nNada selecionado.") (princ) (exit))
  )

  ;; ================================
  ;; FASE 1 � DELETAR LAYERS
  ;; ================================
  (command "_.ERASE"
           (ssget "X" '((8 . "PA_DIV_BLO")))
           ""
  )

  ;; ================================
  ;; FASE 1 � MOVIMENTA��ES (EM LOTE)
  ;; ================================
  (if (ssget "X" '((-4 . "<AND>")
                   (8 . "ARR_LONG_INF_TXT")
                   (-4 . "<NOT>") (40 . 10.0) (-4 . "NOT>")
                   (-4 . "AND>")))
    (command "_.MOVE"
             (ssget "X" '((-4 . "<AND>")
                          (8 . "ARR_LONG_INF_TXT")
                          (-4 . "<NOT>") (40 . 10.0) (-4 . "NOT>")
                          (-4 . "AND>")))
             ""
             '(0 0 0)
             '(0 25 0))
  )

  (if (ssget "X" '((-4 . "<AND>")
                   (8 . "ARR_TRANS_INF_TXT")
                   (-4 . "<NOT>") (40 . 10.0) (-4 . "NOT>")
                   (-4 . "AND>")))
    (command "_.MOVE"
             (ssget "X" '((-4 . "<AND>")
                          (8 . "ARR_TRANS_INF_TXT")
                          (-4 . "<NOT>") (40 . 10.0) (-4 . "NOT>")
                          (-4 . "AND>")))
             ""
             '(0 0 0)
             '(-25 0 0))
  )

  ;; ================================
  ;; FASE 2 � EDI��O DE TEXTOS
  ;; ================================
  (setq i 0)
  (repeat (sslength ss)

    (setq ent (ssname ss i))
    (setq ed  (entget ent))
    (setq tipo (cdr (assoc 0 ed)))
    (setq lay  (cdr (assoc 8 ed)))

    (if (member tipo '("TEXT" "MTEXT"))
      (progn

        ;; ---------- ESTILO ----------
        (if (assoc 7 ed)
          (setq ed (subst (cons 7 "ROMANS") (assoc 7 ed) ed))
          (setq ed (append ed (list (cons 7 "ROMANS"))))
        )

        ;; ---------- ALTURA ----------
        (setq alt (cdr (assoc 40 ed)))
        (cond
          ((equal alt 13.333 0.001)
           (setq ed (subst (cons 40 12.5) (assoc 40 ed) ed)))
          ((equal alt 16.667 0.001)
           (setq ed (subst (cons 40 15.0) (assoc 40 ed) ed)))
        )

        ;; ---------- LARGURA ----------
        (if (= lay "TEXTO_TABELAS")
          (setq ed (subst (cons 41 0.95) (assoc 41 ed) ed))
          (setq ed (subst (cons 41 1.0) (assoc 41 ed) ed))
        )

        ;; ---------- TEXTO ----------
        (setq txt (cdr (assoc 1 ed)))
        (setq txt (vl-string-subst " c/" "c/" txt))
        (setq txt (vl-string-subst " c=" "c=" txt))
        (setq ed (subst (cons 1 txt) (assoc 1 ed) ed))

        (entmod ed)
      )
    )

    (setq i (1+ i))
  )

  (princ "\nMAQLAJES conclu�do com sucesso.")
  (princ)
)
