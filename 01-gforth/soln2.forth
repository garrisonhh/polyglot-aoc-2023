0 Value fd-in
0 Value fd-out
256 Constant max-line
Create line-buffer max-line 2 + allot
Create total 0 ,
Create first-digit 1 cells allot
Create last-digit 1 cells allot

: show-stack s" STACK: " type ... cr ;

: open-input ( filename u ) r/o open-file throw to fd-in ;
: close-input ( -- ) fd-in close-file throw ;

: skip-char ( str u -- str' u' ) 1- swap 1+ swap ;

: soln2 ( filename u -- )
    open-input

    begin
        line-buffer max-line fd-in read-line throw
    while
        >r line-buffer r>
        -1 first-digit !

        begin
            dup 0<>
        while
            \ test for digit or digit name, pushing digit on the stack.
            \ if there is no digit, push -1
            case
                2dup s" one" string-prefix? ?of 1 endof
                2dup s" two" string-prefix? ?of 2 endof
                2dup s" three" string-prefix? ?of 3 endof
                2dup s" four" string-prefix? ?of 4 endof
                2dup s" five" string-prefix? ?of 5 endof
                2dup s" six" string-prefix? ?of 6 endof
                2dup s" seven" string-prefix? ?of 7 endof
                2dup s" eight" string-prefix? ?of 8 endof
                2dup s" nine" string-prefix? ?of 9 endof

                \ default; test for digit char
                over c@
                dup '0' >= over '9' <= and if
                    '0' -
                else
                    drop -1
                then
            0 endcase

            \ store digit if it isn't -1
            dup -1 <> if
                -1 first-digit @ = if
                    dup first-digit !
                then
                last-digit !
            else
                drop
            then

            \ iterate
            skip-char
        repeat

        2drop

        first-digit @ 10 * last-digit @ + total @ + total !
    repeat

    s" TOTAL: " type total @ . cr

    close-input
;

s" input.txt" soln2