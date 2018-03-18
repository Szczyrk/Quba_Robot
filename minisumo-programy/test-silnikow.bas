$regfile = "m8def.dat"
$crystal = 16000000

Config Portd = &B10111111 : Portd = &B00000000
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Config Timer1 = Pwm , Pwm = 8 , Prescale = 1 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up

Dioda Alias Portd.2
Mset1b Alias Portd.1
Mset1a Alias Portd.0
Mset2a Alias Portb.0
Mset2b Alias Portd.7

Set Mset1a : Reset Mset1b
Set Mset2a : Reset Mset2b

Pwm1a = 140
Pwm1b = 140

Dim Zwalnianie As Byte
Zwalnianie = 0

   Do

      If Zwalnianie = 0 Then
         Pwm1a = Pwm1a + 1
         Pwm1b = Pwm1b + 1
      Else
         Pwm1a = Pwm1a - 1
         Pwm1b = Pwm1b - 1
      End If

      If Pwm1a = 255 Then
         Zwalnianie = 1
      Elseif Pwm1a = 140 Then
         Zwalnianie = 0
      End If

      Waitms 50


   Loop

End