$regfile = "m8def.dat"
$crystal = 16000000

Config Portd = &B10111111 : Portd = &B00000000
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Config Adc = Single , Prescaler = Auto , Reference = Avcc

Dioda Alias Portd.2

Dim Pomiar As Word

Start Adc

   Do

    Pomiar = Getadc(2)                                      'ADC2 - kana³ ADC dalmierza

    If Pomiar > 100 Then
      Set Dioda
    Else
      Reset Dioda
    End If

   Loop

End