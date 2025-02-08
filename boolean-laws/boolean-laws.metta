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

 ; Laws for Boolean Algebra
 ;       Law	         OR form	                      AND form
 ; Identity Law	       P + 0 = P 	                    P.1 = P
 ; Idempotent Law	   P + P = P	                    P.P = P
 ; Commutative Law	   P + Q = Q + P	                P.Q = Q.P
 ; Associative Law	   P + (Q + R) = (P + Q) + R	    P.(Q.R) = (P.Q).R
 ; Distributive Law	   P + QR = (P + Q).(P + R)	        P.(Q + R) = P.Q + P.R
 ; Inversion Law	   (A’)’ = A	                    (A’)’ = A
 ; De Morgan’s Law	   (P + Q)’ = (P)’.(Q)’	            (P.Q)’ = (P)’ + (Q)’

 ; I had to use :: for it to not excecute the input and output expression.
 ; I haven't found another way to input or output expressions without it executing them other than adding a random symbol(::)

 ; Identity Law OR form:- P + 0 = P
(= (identity_law (:: OR $x False))
    (:: $x)
)

 ; Identity Law AND form:- P.1 = P
(= (identity_law (:: AND $x True))
    (:: $x)
)

 ;! (identity_law (:: OR P False)) ; [(:: P)]
 ;! (identity_law (:: AND P True)) ; [(:: P)]

 ; Idempotent Law OR form:- P + P = P
(= (idempotent_law (:: OR $x $x))
    (:: $x)
)

 ; Idempotent Law AND form:- P.P = P
(= (idempotent_law (:: AND $x $x))
    (:: $x)
)

 ;! (idempotent_law (:: OR P P)) ; [(:: P)]
 ;! (idempotent_law (:: AND P P)) ; [(:: P)]

 ; Commutative Law OR form:- P + Q = Q + P
(= (commutative_law (:: OR $x $y))
    (:: OR $y $x)
)

 ; Commutative Law AND form :- P.Q = Q.P
(= (commutative_law (:: AND $x $y))
    (:: AND $y $x)
)

; ! (commutative_law (:: OR P Q)) ; [(:: OR Q P)]
; ! (commutative_law (:: AND P Q)) ; [(:: AND Q P)]

 ; Associative Law OR form :- P + (Q + R) = (P + Q) + R
(= (associative_law (:: OR $x (:: OR $y $z)))
    (:: OR (:: OR $x $y) $z)
)

 ; Associative Law AND form :- P.(Q.R) = (P.Q).R
(= (associative_law (:: AND $x (:: AND $y $z)))
    (:: AND (:: AND $x $y) $z)
)

! (associative_law (:: OR P (:: OR Q R))) ; [(:: OR (:: OR P Q) R)]
! (associative_law (:: AND P (:: AND Q R))) ; [(:: AND (:: AND P Q) R)]
