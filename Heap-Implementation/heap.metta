;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (append $list-name $x)(
    add-atom &self (list $list-name $x)
))

! (append x (12 19 7 25 6 33 2 15 27 3 41))

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

; ! (getByIndex (2 19 7 25 6 33 2 15 27 3 41) 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; returns the elements before an index
(= (slice $exp $x)
    (if (or (>= $x (length $exp)) (< $x 0))
        (println! (index out of bound))
        (if (== $x 0)
            ()
            (let*
                (
                    ($item (car-atom $exp))
                    ($rest (cdr-atom $exp))
                    ($newIndex (- $x 1))
                    ($next
                        (if (== $newIndex 0)
                            ()
                            (slice $rest $newIndex)
                        )
                    )
                )
                (cons-atom $item $next)
            )
        )

    )
)

;! (slice (0 1 2 3 4 5 6 7 8 9) 5)  ; [(0 1 2 3 4)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; returns the item at an index and the rest of the list after that index
(= (get-item-and-list $exp $ind)
    (if (== 0 $ind)
        ((car-atom $exp) (cdr-atom $exp))
        (get-item-and-list (cdr-atom $exp) (- $ind 1))
    )
)

;! (get_item (2 19 7 25 6 33 15 27 3 41) 5 0)  ; [(33 (15 27 3 41))]


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; reutrns a combination of two lists
(= (combine-lists $list1 $list2)
    (let*
        (
            ($head
                (if (== $list1 ())
                    ()
                    (car-atom $list1)
                )
            )
            ($new-list
                (if (== $list1 ())
                    $list2
                    (combine-lists (cdr-atom $list1) $list2)
                )
            )
            ($reconstruction
                (if (== $head ())
                    $new-list
                    (cons-atom $head $new-list)
                )
            )
        )
        $reconstruction
    )
)

;! (combine-lists (1 2 3 4) (5 6 7 8))  [(1 2 3 4 5 6 7 8)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; returns the item at an index and the rest of the list
(= (take-item-out $list $ind)
    (let*
        (
            ($before-item (slice $list $ind))
            (($item $after-item) (get-item-and-list $list $ind 0))
            ($rest (combine-lists $before-item $after-item))
        )
        ($item $rest)
    )
)

! (take-item-out (2 19 7 25 6 33 15 27 3 41) 5)  ; [(33 (2 19 7 25 6 15 27 3 41))]

