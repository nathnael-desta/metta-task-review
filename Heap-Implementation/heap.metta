;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (length $list)
    (if (== $list ())
        0
        (+ 1 (length (cdr-atom $list)))
    )
)
; !(length (2 19 7 25 6 33 2 15 27 3 41))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(= (get_item $exp $ind $curInd)
    (if (== $ind $curInd)
        (car-atom $exp)
        (get_item (cdr-atom $exp) $ind (+ 1 $curInd))
    )
)

;; Checks if the list is non-empty and index is valid, then retrieves the item.
(= (getByIndex $exp $ind)
    (let*
        (
            ($len (length $exp))
        )
        (
            if (or (== $len 0) (>= $ind $len))
                (println! (wrong inputs))
                (get_item $exp $ind 0)
        )
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
(= (min-heap $list $index)
    (let*
        (
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
                $list
                (let*
                    (
                        ($new-list (swap $list $index $smaller))
                    )
                    (min-heap $new-list $smaller)
                )
        )
    )
)

; !(min-heap (12 19 7 25 6 33 2 15 27 3 41) 0) ; [(7 19 2 25 6 33 12 15 27 3 41)]

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; starting from the last parent node calls min-heap
; until the 0th index, this inforces min-heap laws on all items
(= (heapify-items $list $index)
    (if (< $index 0)
        $list
        (let $new-list (min-heap $list $index)
            (heapify-items $new-list (- $index 1))
        )
    )
)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; starts heapify-items starting from the last parent node
(= (heapify $list)
    (let*
        (
            ($list-length (length $list))
        )
        (heapify-items $list (- (floor-division-by-two $list-length) 1))
    )
)

; !(heapify (12 19 7 25 6 33 2 15 27 3 41))  ;[(2 3 7 15 6 33 12 25 27 19 41)]


;;;;;;;;;;;;;;;;;;;;;;;;;;;
; returns the parent index of node index
(= (parent $index) (floor-division-by-two (- $index 1)))

; ! (parent 11) ; 5


;;;;;;;;;;;;;;;;;;;;;;;;;;;
; inserts an item at the end of the list
(= (push-item $list $item)
    (if (== (length $list) 0)
        ($item)
        (let*
            (
                ($head (car-atom $list))
                ($rest (cdr-atom $list))
                ($next
                    (if (== $rest ())
                        ($item)
                        (push-item $rest $item)
                    )
                )
                ($new-list (cons-atom $head $next))
            )
            $new-list
        )
    )
)

; ! (push-item (1 2 3 4 5) 6) ; (1 2 3 4 5 6)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; goes to the index of the appended item
; recursivly swaps parent and child if parent is smaller
(= (swap-up $list $index)
    (if (<= $index 0)
        $list
        (let*
            (
                ($parent (parent $index))
                ($index-item (getByIndex $list $index))
                ($parent-item (getByIndex $list $parent))
            )
            (
            if (>= $index-item $parent-item)
                $list
                (let*
                    (
                        ($new-list (swap $list $parent $index))
                    )
                    (swap-up $new-list $parent)
                )
            )
        )
    )

)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; pushs an item at the end of the heap
; calls swap-up to position the item according to heap laws
(= (heap-push $list $item)
    (let*
        (
            ($appended-list (push-item $list $item))
            ($pushed-list (swap-up $appended-list (- (length $appended-list) 1)))
        )
        $pushed-list
    )
)

; ! (heap-push (2 3 7 15 6 33 12 25 27 19 41) 1) ; ->  [(1 3 2 15 6 7 12 25 27 19 41 33)]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; returns the item at the last index of a list
(= (pop $list)
    (let*
        (
            ($head (car-atom $list))
            ($rest (cdr-atom $list))
            ($item
                (if (== $rest ())
                    $head
                    (pop $rest)
                )
            )
        )
        $item
    )
)

;! (pop (2 3 7 15 6 33 12 25 27 19 41 10)) ; [10]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; takes out the first item and returns it
; pops the last item, puts it in 0th index
; preforms min heap on the 0th index to apply heap law
(= (heap-pop $list)
    (let*
        (
            ($head (car-atom $list))
            ($rest (cdr-atom $list))
            ($popped-item (pop $rest))
            ($popped-list (slice $rest (- (length $rest) 1)))
            ($new-list (cons-atom $popped-item $popped-list))

        )
        (let*
            (
                ($heap (min-heap $new-list 0))
            )
            ($head $heap)
        )
    )
)


;! (heap-pop (2 3 7 15 6 33 12 25 27 19 41)) ; -> [(2 (3 6 7 15 19 33 12 25 27 41))]

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
; heap functions together
! (heapify (12 19 7 25 6 33 2 15 27 3 41))  ;[(2 3 7 15 6 33 12 25 27 19 41)]
! (heap-push (2 3 7 15 6 33 12 25 27 19 41) 1) ; ->  [(1 3 2 15 6 7 12 25 27 19 41 33)]
! (heap-pop (2 3 7 15 6 33 12 25 27 19 41)); -> [(2 (3 6 7 15 19 33 12 25 27 41))]