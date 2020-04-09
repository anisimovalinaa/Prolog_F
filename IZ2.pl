read_list(A,N):-r_l([],A,0,N).
r_l(A,A,N,N):-!.
r_l(B,A,I,N):-I1 is I+1,read(X),append(B,[X],B1),r_l(B1,A,I1,N).

pr:-read(N),read_list(A,N),new_list(A,[],C),write(C).

find([H|_],H).
find([_|T],E):-find(T,E).

del(X,X,D,D):-!.
del(X,Y,C,D):-Y1 is Y+1,not(find(C,Y1)),R is X mod Y1,R=0,append(C,[Y1],C1),del(X,Y1,C1,D).
del(X,Y,C,D):-Y1 is Y+1,del(X,Y1,C,D).

new_list([],B,B):-!.
new_list([H|T],B,C):-del(H,0,B,B1),new_list(T,B1,C).
