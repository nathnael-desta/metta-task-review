 ; assuming 0 represents false and 1 represents true
 ; assuming "+" is "or" and "*" is "and"
 ; the zero's index shows the OR form and the first shows AND form
 ; The return being True shows that the Laws apply regardless of the input value.

 ; Identity Law:- 	P + 0 = P 	P.1 = P
(= (identity_law $P)
    ( (== (or $P False) $P) (== (and $P True) $P))
)

 ;! (identity_law True) ; [(True True)]
 ;! (identity_law False) ;[(False False)]

 ; Idempotent Law:-	P + P = P	P.P = P
(= (idempotent_law $P)
    ( (== (or $P $P) $P) (== (and $P $P) $P))
)

! (idempotent_law True) ; [(True True)]
! (idempotent_law False) ;[(False False)]
