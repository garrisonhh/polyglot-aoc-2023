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

: next-char ( str u -- str' u' ch ) 1- swap 1+ tuck 1- c@ ;

: soln1 ( filename u -- )
    open-input

    begin
        line-buffer max-line fd-in read-line throw
    while
        >r line-buffer r>
        -1 first-digit !

        begin
            dup 0<>
        while
            next-char ( str len ch )

            dup '0' >= over '9' <= and if
                '0' -

                -1 first-digit @ = if
                    dup first-digit !
                then
                last-digit !
            else
                drop
            then
        repeat

        2drop

        first-digit @ 10 * last-digit @ + total @ + total !
    repeat

    s" TOTAL: " type total @ . cr

    close-input
;

s" input.txt" soln1