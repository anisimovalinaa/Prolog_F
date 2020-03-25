max(X,Y,X):-X>Y.
max(X,Y,Y):-Y>X.
max1(X,Y,Z,X):-X>Y,X>Z.
max1(X,Y,Z,Y):-Y>Z.
max1(X,Y,Z,Z).


fact(0,1):-!.
fact(N,X):-N1 is N-1,fact(N1,X1),X is X1*N.

fact1(N,X):-fact2(1,N,1,X).
fact2(N,N,X,X):-!.
fact2(I,N,Y,X):-I1 is I+1,Y1 is Y*I1, fact2(I1,N,Y1,X).

fib(1,1):-!.
fib(2,1):-!.
fib(N,X):-N1 is N-1,N2 is N-2,fib(N1,X1),fib(N2,X2),X is X1+X2.

pr(2):-!.
pr(X):-pr1(2,X).
pr1(X,X):-!.
pr1(I,X):-R is X mod I,R=0,!,fail.
pr1(I,X):-I1 is I+1,pr1(I1,X).

nprdel(A,X):-n_pr(A,A,X).
n_pr(I,A,I):-pr(I),R is A mod I,R=0,!.
n_pr(I,A,X):-I1 is I-1,n_pr(I1,A,X).

sum(X,S):-sum1(X,X,0,S).
sum1(_,0,S,S):-!.
sum1(X,A,Sm,S):-R is A mod 10,Sm1 is Sm+R,D is A div 10,sum1(X,D,Sm1,S).

nod(X,Y,X):-X=Y,!.
nod(X,Y,N):-(X>Y -> R is X-Y,nod(R,Y,N);R is Y-X,nod(X,R,N)).

eiler(X,E):-eiler1(X,X,E,0).
eiler1(_,1,K,K):-!.
eiler1(X,Y,E,K):-Y1 is Y-1,nod(X,Y1,N),(N=1 -> K1 is K+1,eiler1(X,Y1,E,K1);eiler1(X,Y1,E,K)).

