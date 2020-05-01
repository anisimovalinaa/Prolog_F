// Learn more about F# at http://fsharp.org

open System
open System.Windows.Forms
open System.Drawing

let form1 = new Form(Width= 400, Height = 300, Text = "Индивидуальное задание 11. Главная Форма", Menu = new MainMenu())
let button1 = new Button(Text = "Перейти на дочернюю форму №1", Width=100, Height=50)
let button2 = new Button(Text = "Перейти на дочернюю форму №2", Width=100, Height=50)
button1.Location <- new Point(75, 100)
button2.Location <- new Point(200, 100)

let text = new Label(Text = "MainMenu")
text.Location <- new Point(155,50)

form1.Controls.Add(button1)
form1.Controls.Add(button2)
form1.Controls.Add(text)

let form2 = new Form(Width= 400, Height = 300,Text = "Индивидуальное задание 11. Дочерняя форма №1.")
let form3 = new Form(Width= 400, Height = 300,Text = "Индивидуальное задание 11. Дочерняя форма №2.")

let opForm2 _ = do form2.ShowDialog()
let opForm3 _ = do form3.ShowDialog()

let _ = button1.Click.Add(opForm2)
let _ = button2.Click.Add(opForm3)

do Application.Run(form1)