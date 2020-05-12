// Learn more about F# at http://fsharp.org

open System
open System.Windows.Forms
open System.Drawing

let form = new Form(Width= 350, Height = 400, Text = "Индивидуальное задание 13", Menu = new MainMenu())

let label1 = new Label(Text = "Введите списки:")
label1.Location <- new Point(30, 60)

let label2 = new Label(Text = "Первый список =")
label2.Location <- new Point(20, 90)

let label3 = new Label(Text = "Второй список =")
label3.Location <- new Point(20, 120)

let posled1 = new RichTextBox(Height = 20, Width = 190)
posled1.Location <- new Point(120, 90)

let posled2 = new RichTextBox(Height = 20, Width = 190)
posled2.Location <- new Point(120, 120)

let button = new Button(Text = "Ответ")
button.Location <- new Point(115, 160)

let answer = new RichTextBox(Height = 20, Width = 190)
answer.Location <- new Point(65, 200)

let rec createList a b list = 
    match a with 
    | "" -> if (b = "") then list
            else Convert.ToInt32(b)::list
    | _ -> if (a.[0] = ' ') then createList (a.Remove(0,1)) "" (Convert.ToInt32(b)::list)
           else createList (a.Remove(0,1)) (b+(a.[0].ToString())) list

let rec function1 l1 l2 subList (subList1: 'a list) rezList max = 
    match l1, l2 with  
    | _, [] -> if (max < subList1.Length) then subList1
               else rezList
    | [], _ -> if (max < subList1.Length) then function1 subList l2.Tail subList [] subList1 subList1.Length
               else function1 subList l2.Tail subList [] rezList max
    | _, _ -> if (l1.Head = l2.Head) then function1 l1.Tail l2.Tail subList (l1.Head::subList1) rezList max
              else if (max < subList1.Length) then function1 subList l2.Tail subList [] subList1 subList1.Length
                   else function1 subList l2.Tail subList [] rezList max

let rec function2 listF (listS: 'a list) resultList max = 
    match listF with
    | [] -> resultList
    | _ -> let listR = function1 listF listS listF [] [] max
           if (listR.Length>max) then function2 listF.Tail listS listR listR.Length
           else function2 listF.Tail listS resultList max

let f1 list1 list2 = 
    let r = List.map (fun x -> function1 list1 list2 list1 [] [] 0) list1
    //let r = List.fold (fun acc x -> x::acc) [] list1
    r

let new_list list1 list2 =
    match list1, list2 with
    | [], [] -> []
    | [], _ -> []
    | _, [] -> []
    | _, _ -> function2 list1 list2 [] 0

form.Controls.Add(label1)
form.Controls.Add(label2)
form.Controls.Add(label3)
form.Controls.Add(posled1)
form.Controls.Add(posled2)
form.Controls.Add(button)
form.Controls.Add(answer)

button.Click.Add(fun evArgs -> let a = posled1.Text
                               let b = posled2.Text
                               let list1 = createList a "" []
                               let list2 = createList b "" []
                               let rezList = f1 list1 list2
                               List.iter (fun x -> answer.AppendText(x.ToString() + " ")) rezList
                               |> ignore)

do Application.Run(form)