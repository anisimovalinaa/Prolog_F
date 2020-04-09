in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

pr:- Coupe=[_,_,_,_],

    in_list(Coupe,[_,poet,play]),
    in_list(Coupe,[alekseev,_,_]),
    in_list(Coupe,[borisov,_,_]),
    in_list(Coupe,[konst,_,_]),
    in_list(Coupe,[dmitr,_,_]),
    not(in_list(Coupe,[_,astr,astro])),
    not(in_list(Coupe,[_,prozaik,proza])),
    not(in_list(Coupe,[_,prozaik,astro])),
    not(in_list(Coupe,[_,prozaik,play])),
    in_list(Coupe,[_,prozaik,poetry]),
    in_list(Coupe,[_,astr,proza]),
    in_list(Coupe,[_,drama,astro]),
    not(in_list(Coupe,[dmitr,prozaik,_])),
    not(in_list(Coupe,[alekseev,_,proza])),
    not(in_list(Coupe,[dmitr,_,poetry])),

    write(Coupe).

