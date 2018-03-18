$regfile = "m8def.dat"
$crystal = 16000000

Config Portd = &B10111111 : Portd = &B00000000
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Dioda Alias Portd.2
Przycisk Alias Pind.6

   Do

    If Przycisk = 0 Then
      Set Dioda
    Else
      Reset Dioda
    End If

   Loop

End