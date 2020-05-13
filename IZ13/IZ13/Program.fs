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

let rec remove list i =
    match i, list with
    |0, _ -> list
    |_, head::tail -> remove (tail) (i-1)

let rec new_sublist list1 list2 new_list =
    if (List.isEmpty list1 || List.isEmpty list2) then new_list
    else
    match List.tryHead list1 = List.tryHead list2 with
    |false -> new_list
    |true -> new_sublist (List.tail list1) (List.tail list2) ((List.head list1)::new_list)

let sublist list1 list2 =
    let firstListIndex = List.mapi (fun i x -> i) list1
    let secondListIndex = List.mapi (fun i x -> i) list2
    List.fold2 (fun acc f_elem index1 -> 
                                (List.fold2 (fun acc2 s_elem index2 -> 
                                                                    if (f_elem = s_elem) then let new_list = new_sublist (remove list1 index1) (remove list2 index2) []
                                                                                              if (List.length new_list > List.length acc2) then new_list
                                                                                              else acc2
                                                                    else acc2
                                ) [] list2 secondListIndex)::acc
                                ) [] list1 firstListIndex

let max_sublist list = 
    List.fold (fun acc elem ->if (List.length elem > List.length acc) then elem
                               else acc) [] list 

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
                               let list_list = sublist list1 list2
                               let rezList = max_sublist list_list
                               List.iter (fun x -> answer.AppendText(x.ToString() + " ")) rezList
                               |> ignore)

do Application.Run(form)