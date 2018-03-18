$regfile = "m8def.dat"
$crystal = 8000000

Config Portd = &B10111111 : Portd = &B00000000
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Dioda Alias Portd.2
Przycisk Alias Pind.6

   Do


      Set Dioda
      Wait 300

   Loop

End