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

let check x = 
    let mutable k = false
    for i in (x-1) .. -1 .. 2 do
        if pr i && k=false then let b : double = Math.Sqrt(Convert.ToDouble(x-i)/2.0)
                                if (Convert.ToDouble(Convert.ToInt32(b))=b) then k <- true
                                                                      //System.Console.Write(x)
                                                                      //System.Console.Write("=")
                                                                      //System.Console.Write(i)
                                                                      //System.Console.Write("+2*")
                                                                      //System.Console.Write(b)
                                                                      //System.Console.WriteLine("^2")                                                                                     
    if k = false then false
    else true

[<EntryPoint>]
let main argv =
    //let x = System.Convert.ToInt32(System.Console.ReadLine())  
    let mutable f = false
    for i in 2..6000 do
        if (i%2<>0) && not(pr i) && f=false then
            if not(check i) then System.Console.WriteLine(i)
                                 f <- true

    0 // return an integer exit code
