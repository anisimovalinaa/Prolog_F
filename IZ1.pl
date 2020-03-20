pr:-kolvo_friends(2,0,K),K1 is K/2,write('Количество дружественных пар: '),write(K1).

kolvo_friends(10000,K,K):-!.
kolvo_friends(X,Kol,K):-X1 is X+1,(friends(X)->K1 is Kol+1,kolvo_friends(X1,K1,K);kolvo_friends(X1,Kol,K)).

friends(X):-sum_del(X,Y),sum_del(Y,Z),X=Z,X\=Y.

sum_del(X,S):-s_d(X,1,0,S).
s_d(X,X,S,S):-!.
s_d(X,D,Sum,S):-D1 is D+1,R is X mod D,(R=0 -> Sum1 is Sum+D,s_d(X,D1,Sum1,S);s_d(X,D1,Sum,S)).
