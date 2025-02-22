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
; swaps the first index with the second index
(= (swap $list $first $second)
    (let*
        (
            ($up-to-first (slice $list $first))
            (($first-item $after-first) (get-item-and-list $list $first))
            ($after-first-up-to-second (slice $after-first (- (- $second $first) 1)))
            (($second-item $after-second) (get-item-and-list $after-first (- (- $second $first) 1)))
            ($step1 (combine-lists $up-to-first ($second-item)))
            ($step2 (combine-lists $step1 $after-first-up-to-second))
            ($step3 (combine-lists $step2 ($first-item)))
            ($step4 (combine-lists $step3 $after-second))
        )
        $step4
    )
)

;! (swap (0 1 2 3 4 5 6) 2 5) ; [(0 1 5 3 4 2 6)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; given a list and two indexes, returns the index of the smaller
; index value or () if neither of the indexes are in the list
(= (get-smaller-child $list $left $right)
    (let*
        (
            ($list-length (length $list))
            ($left-item
                (if (>= $left $list-length)
                    ()
                    (getByIndex $list $left)
                )
            )
            ($right-item
                (if (>= $right $list-length)
                    ()
                    (getByIndex $list $right)
                )
            )
            ($smaller-child
                (if (== (get-type $left-item) Number)
                    (if (== (get-type $right-item) Number)
                        (if (> $left-item $right-item)
                            $right
                            $left
                        )
                        $left
                    )
                    (if (== (get-type $right-item) Number)
                        $right
                        ()
                    )
                )
            )
        )
        $smaller-child
    )
)

;! (get-smaller-child (2 19 7 25 6 33 2 15 27 3 41) 9 10)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Starting at the index, swap with the smallest child
; if the min-heap property is violated, repeating until valid.
(= (min-heap $list-name $index)
    (let*
        (
            ($list (return-list $list-name))
            ($left (+ 1 (* 2 $index)))
            ($right (+ 2 (* 2 $index)))
            ($index-item (getByIndex $list $index))
            ($smaller-child-index (get-smaller-child $list $left $right))
            ($smaller-child-item
                (if (== (get-type $smaller-child-index) Number)
                    (getByIndex $list $smaller-child-index)
                    ()
                )
            )
            ($smaller
                (if (== (get-type $smaller-child-item) Number)
                    (if (> $index-item $smaller-child-item)
                        $smaller-child-index
                        $index-item
                    )
                    $index
                )
            )
        )
        (
            if (== $smaller $index)
                ()
                (let*
                    (
                        ($new-list (swap $list $index $smaller))
                        (() (remove-atom &self (list $list-name $list)))
                        (() (add-atom &self (list $list-name $new-list)))
                    )
                    (min-heap $list-name $smaller)
                )
        )
    )
)

;! (return-list x)
;!(min-heap x 0) ; (12 19 7 25 6 33 2 15 27 3 41) -> [(7 19 2 25 6 33 12 15 27 3 41)]
;! (return-list x)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; implementation of floor division by 2
(= (floor-division-by-two $x)
    (let*
        (
            ($divisible-number
                (if (== (% $x 2) 0)
                    $x
                    (- $x 1)
                )
            )
            ($answer (/ $divisible-number 2))
        )
        $answer
    )
)

; ! (floor-division-by-two 6)  ; 3
; ! (floor-division-by-two 7)  ; 3

(= (heapify-items $list-name $index)
    (if (< $index 0)
        ()
        (let () (min-heap $list-name $index)
            (heapify-items $list-name (- $index 1))
        )
    )
)

(= (heapify $list-name)
    (let*
        (
            ($list (return-list $list-name))
            ($list-length (length $list))
        )
        (heapify-items $list-name (- (floor-division-by-two $list-length) 1))
    )
)

; ! (return-list x) ; [(12 19 7 25 6 33 2 15 27 3 41)]
; !(heapify x)
; ! (return-list x) ; [(2 3 7 15 6 33 12 25 27 19 41)]

