 ; assuming 0 represents false and 1 represents true
 ; the zero's index shows the OR form and the first shows AND form
 ; The return being True shows that the Laws apply regardless of the input value.

 ; Identity Law:- 	P + 0 = P 	P.1 = P
(= (identity_law $P)
    ( (== (or $P False) $P) (== (and $P True) $P))
)

 ;! (identity_law True) ; [(True True)]
 ;! (identity_law False) ;[(True True)]

 ; Idempotent Law:-	P + P = P	P.P = P
(= (idempotent_law $P)
    ( (== (or $P $P) $P) (== (and $P $P) $P))
)

 ;! (idempotent_law True) ; [(True True)]
 ;! (idempotent_law False) ;[(True True)]

 ; Commutative Law	P + Q = Q + P	P.Q = Q.P
(= (commutative_law $P $Q)
    ( (== (or $P $Q) (or $Q $P)) (== (and $P $Q ) (and $Q $P)))
)

 ;! (commutative_law True False) ; [(True True)]
 ;! (commutative_law False True) ; [(True True)]

 ; Associative Law	P + (Q + R) = (P + Q) + R	P.(Q.R) = (P.Q).R
(= (associative_law $P $Q $R)
    ( (== (or $P (or $Q $R)) (or (or $P $Q) $R)) (== (and $P (and $Q $R)) (and (and $P $Q) $R)))
)

 ;! (associative_law True False True) ; [(True True)]
 ;! (associative_law False True False) ; [(True True)]

 ; Distributive Law	P + QR = (P + Q).(P + R)	P.(Q + R) = P.Q + P.R
(= (distributive_law $P $Q $R)
    ( (== (or $P (and $Q $R)) (and (or $P $Q) (or $P $R))) (== (and $P (or $Q $R)) (or (and $P $Q) (and $P $R))))
)

 ;! (distributive_law True False True) ; [(True True)]
 ;! (distributive_law False True False) ; [(True True)]

 ; Inversion Law	(A’)’ = A	(A’)’ = A
(= (inversion_law $A)
    ( (== (not (not $A)) $A) (== (not (not $A)) $A))
)

 ;! (inversion_law True) ; [(True True)]
 ;! (inversion_law False) ;[(True True)]

 ; De Morgan’s Law	(P + Q)’ = (P)’.(Q)’	(P.Q)’ = (P)’ + (Q)’
(= (de_morgans_law $P $Q)
    ( (== (not (or $P $Q)) (and (not $P) (not $Q))) (== (not (and $P $Q)) (or (not $P) (not $Q))))
)

! (de_morgans_law True False ) ; [(True True)]
! (de_morgans_law False True ) ; [(True True)]
! (de_morgans_law True True ) ; [(True True)]
! (de_morgans_law False False ) ; [(True True)]