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
                               //List.iter (fun x -> answer.AppendText(x.ToString() + " ")) (createList b "" [])
                               |> ignore)

do Application.Run(form)