$regfile = "m8def.dat"
$crystal = 16000000

Config Portd = &B10111111 : Portd = &B00000000
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Config Adc = Single , Prescaler = Auto , Reference = Avcc

Dioda Alias Portd.2

Dim Czujnik1 As Word
Dim Czujnik2 As Word
Dim Czujnik3 As Word
Dim Czujnik4 As Word
Const Linia = 900                                           't¹ liczbê zmieniamy w zakresie 0 - 1024

Start Adc

   Do

    Czujnik1 = Getadc(0)                                    'kana³ 0 to prawy czujnik linii
    Czujnik2 = Getadc(1)                                    'kana³ 1 to lewy czujnik linii
    Czujnik3 = Getadc(2)                                    'kana³ 0 to prawy czujnik linii
    Czujnik4 = Getadc(3)
    If Czujnik1 > Linia Or Czujnik2 > Linia Or Czujnik2 > Linia Or Czujnik3 > Linia Or Czujnik4 > Linia Then
      Set Dioda
    Else
      Reset Dioda
    End If

   Loop

End