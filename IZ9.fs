// Learn more about F# at http://fsharp.org

open System

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

let rec Check x y f = 
    match f with
    | false -> if y>1 then if (pr y) then let b : double = Math.Sqrt(Convert.ToDouble(x-y)/2.0)
                                          if (Convert.ToDouble(Convert.ToInt32(b))=b) then Check x (y-1) true
                                          else Check x (y-1) f
                           else Check x (y-1) f
               else false
    | true -> true

let rec FindNumber n f =
    match f with
    | false -> if (n%2<>0) && not(pr n) then if not(Check n (n-1) false) then FindNumber (n+1) true
                                             else FindNumber (n+1) f
               else FindNumber (n+1) f
    | true -> System.Console.WriteLine(n-1)

[<EntryPoint>]
let main argv =
    FindNumber 2 false

    0 // return an integer exit code
