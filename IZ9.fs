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

let f x =
    x = true

let check1 x =
    let k = false
    for i in (x-1) .. -1 .. 2 do
        if pr i then let b : double = Math.Sqrt(Convert.ToDouble(x-i)/2.0)
                     if (Convert.ToDouble(Convert.ToInt32(b))=b && k=false) then f k
                                                                      //System.Console.Write(x)
                                                                      //System.Console.Write("=")
                                                                      //System.Console.Write(i)
                                                                      //System.Console.Write("+2*")
                                                                      //System.Console.Write(b)
                                                                      //System.Console.WriteLine("^2")
                                                                                 System.Console.WriteLine(x)
                                                                                 
    if k = false then false
    else true

let check x = 
    let mutable k = false
    for i in (x-1) .. -1 .. 2 do
        if pr i then let b : double = Math.Sqrt(Convert.ToDouble(x-i)/2.0)
                     if (Convert.ToDouble(Convert.ToInt32(b))=b && k=false) then k <- true
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
    for i in 2..6000 do
        if (i%2<>0) && not(pr i) then
            if not(check i) then System.Console.WriteLine(i)

    0 // return an integer exit code
