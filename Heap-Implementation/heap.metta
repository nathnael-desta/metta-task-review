;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (append $list-name $x)(
    add-atom &self (list $list-name $x)
))

;! (append x (2 19 7 25 6 33 2 15 27 3 41))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(=(return-list $list-name)(
    match &self (list $list-name $y) $y
))
; !(return-list x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (length $list)
    (if (== $list ())
        0
        (+ 1 (length (cdr-atom $list)))
    )
)
; !(length (2 19 7 25 6 33 2 15 27 3 41))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (getByIndex $list $n)
    (if (== $n 0)
        (car-atom $list)
        (getByIndex (cdr-atom $list) (- $n 1))
    )
)

; ! (getByIndex (2 19 7 25 6 33 2 15 27 3 41) 5)

