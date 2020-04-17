// Learn more about F# at http://fsharp.org

open System

let max x y =
    if x>y then x
    else y

let max2 f x y z =
    let a = f x y
    f a z

//let p1_1 = 
//    let a = System.Convert.ToInt32(System.Console.ReadLine())
//    let b = System.Convert.ToInt32(System.Console.ReadLine())

//    let A = max a b
//    System.Console.WriteLine(A)

//let p1_2 =
//    let a = System.Convert.ToInt32(System.Console.ReadLine())
//    let b = System.Convert.ToInt32(System.Console.ReadLine())
//    let c = System.Convert.ToInt32(System.Console.ReadLine())    

//    let A = max2 max a b c
//    System.Console.WriteLine(A)


let rec fact N = 
    match N with 
        | 1 -> 1
        | _ -> N*fact(N-1)

//let p1_3 = 
//    let N = System.Convert.ToInt32(System.Console.ReadLine())

//    let A = fact N
//    System.Console.WriteLine(A)

let rec fib N = 
    match N with
    | 1 -> 1
    | 2 -> 1
    | _ -> fib(N-1)+fib(N-2)

//let p1_4 =
//    let N = System.Convert.ToInt32(System.Console.ReadLine())
    
//    let A = fib N
//    System.Console.WriteLine(A)

let del x y =
    if x % y = 0 then true
                 else false

let rec pr1 x y = 
    if x = y then true 
    else not(del x y) && (pr1 x (y+1))

let pr x = 
    match x with
    | 2 -> true
    | _ -> pr1 x 2

//let p1_5 = 
//    let n = System.Convert.ToInt32(System.Console.ReadLine())

//    let a = pr n
//    System.Console.WriteLine(a)

let rec sumDigit x =
    match x with
        | 0 -> 0
        | _ -> x%10 + sumDigit(x/10)

//let p1_7 = 
//    let n = System.Convert.ToInt32(System.Console.ReadLine())
    
//    let A = sumDigit n
//    System.Console.WriteLine(A)

let rec npd1 x y =
    if (del x y) && (pr y) then y
    else npd1 x (y-1)

let npd x =
    if pr x then x
    else npd1 x (x-1)

//let p1_8 =
//    let n = System.Convert.ToInt32(System.Console.ReadLine())

//    let A = npd n
//    System.Console.WriteLine(A)

let min x y =
    if x<y then x
    else y

let rec nod a b = 
    let min1 = min a b
    let c = max a b - min1
    if c=0 then a
    else nod min1 c 

//let p1_9 = 
//    let a = System.Convert.ToInt32(System.Console.ReadLine())
//    let b = System.Convert.ToInt32(System.Console.ReadLine())

//    let A = nod a b
//    System.Console.WriteLine(A)

let rec eiler1 x y k =
    match y with
        | 0 -> k
        | _ -> if nod x y = 1 then eiler1 x (y-1) (k+1)
               else eiler1 x (y-1) k

let eiler x =
    if pr x then (x-1)
    else eiler1 x (x-1) 0

let p1_10 =
    let a = System.Convert.ToInt32(System.Console.ReadLine())

    let A = eiler a
    System.Console.WriteLine(A)

[<EntryPoint>]
let main argv =
    p1_10

    0 // return an integer exit code
