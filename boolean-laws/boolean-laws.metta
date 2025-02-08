 ; variable expressions
(= (P) True)
(= (Q) False)
(= (R) True)

 ; expressions for "and" and "or"
(= (AND $x $y)
    (and $x $y)
)

(= (OR $x $y)
    (or $x $y)
)

 ; I had to use :: for it to not excecute the input and output expression.
 ; I haven't found another way to input or output expressions without it executing them other than adding a random symbol(::)

 ; Identity Law:- P + 0 = P
(= (identity_law (:: OR $x False))
    (:: $x)
)

 ; Identity Law:- P.1 = P
(= (identity_law (:: AND $x True))
    (:: $x)
)

 ;! (identity_law (:: OR P False)) ; [(:: P)]
 ;! (identity_law (:: AND P True)) ; [(:: P)]

 ; Idempotent Law:- P + P = P
(= (idempotent_law (:: OR $x $x))
    (:: $x)
)

 ; Idempotent Law:- P.P = P
(= (idempotent_law (:: AND $x $x))
    (:: $x)
)

! (idempotent_law (:: OR P P)) ; [(:: P)]
! (idempotent_law (:: AND P P)) ; [(:: P)]