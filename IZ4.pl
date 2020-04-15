in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

pr:- Coupe=[_,_,_,_],

    in_list(Coupe,[alekseev,_,_]),
    in_list(Coupe,[borisov,_,_]),
    in_list(Coupe,[konstantinov,_,_]),
    in_list(Coupe,[dmitriev,_,_]),

    in_list(Coupe,[_,_,astronomia]),
    in_list(Coupe,[_,_,proza]),
    in_list(Coupe,[_,_,poetry]),
    in_list(Coupe,[_,poet,play]),

    in_list(Coupe,[_,prozaik,_]),
    in_list(Coupe,[_,astronom,_]),
    in_list(Coupe,[_,dramaturg,_]),

    (in_list(Coupe,[dmitriev,poet,_]),
    (in_list(Coupe,[alekseev,astronom,poetry]),not(in_list(Coupe,[borisov,_,astronomia]));
    in_list(Coupe,[alekseev,prozaik,poetry]),not(in_list(Coupe,[borisov,_,proza]));
    in_list(Coupe,[alekseev,dramaturg,poetry]),not(in_list(Coupe,[borisov,_,play])));

    in_list(Coupe,[dmitriev,astronom,_]),
   (in_list(Coupe,[alekseev,poet,astronomia]),not(in_list(Coupe,[borisov,_,poetry]));
    in_list(Coupe,[alekseev,prozaik,astronomia]),not(in_list(Coupe,[borisov,_,proza]));
    in_list(Coupe,[alekseev,dramaturg,astronomia]),not(in_list(Coupe,[borisov,_,play])));

    in_list(Coupe,[dmitriev,dramaturg,_]),
   (in_list(Coupe,[alekseev,poet,play]),not(in_list(Coupe,[borisov,_,poetry]));
    in_list(Coupe,[alekseev,prozaik,play]),not(in_list(Coupe,[borisov,_,proza]));
    in_list(Coupe,[alekseev,astronom,play]),not(in_list(Coupe,[borisov,_,astronomia])))),

    not(in_list(Coupe,[_,prozaik,astronomia])),
    not(in_list(Coupe,[_,prozaik,proza])),
    not(in_list(Coupe,[_,astronom,astronomia])),
    not(in_list(Coupe,[alekseev,_,proza])),
    not(in_list(Coupe,[dmitriev,prozaik,_])),

    write(Coupe).

