$regfile = "m8def.dat"
$crystal = 16000000                                         'taktowanie 16MHz - trzeba koniecznie wlaczyc odpowiednie fusebity!

Config Portd = &B10111111 : Portd = &B00000000              'konfiguracja portow
Config Portb = &B11111111 : Portb = &B00000000
Config Portc = &B00000000 : Portc = &B00000000

Config Timer1 = Pwm , Pwm = 8 , Prescale = 1 , Compare A Pwm = Clear Up , Compare B Pwm = Clear Up       'konfiguracja timera - PWM
Config Adc = Single , Prescaler = Auto , Reference = Avcc   'konfiguracja ADC

Dioda Alias Portd.2
Mset1b Alias Portd.1
Mset1a Alias Portd.0
Mset2a Alias Portb.0
Mset2b Alias Portd.7                                        'przypisanie nazw do portow - dla ulatwienia
Przycisk Alias Pind.6

  Reset Dioda
Set Mset1a : Reset Mset1b                                   'silnik prawy (patrzac na tyl robota) - robot jedzie naprzod
Set Mset2a : Reset Mset2b                                   'silnik lewy (patrzac na tyl robota) - robot jedzie naprzod

Dim Linia1 As Word                                          'prawy czujnik linii (patrzac na tyl robota)
Dim Linia2 As Word                                          'lewy czujnik linii (patrzac na tyl robota)
Dim Linia3 As Word
Dim Linia4 As Word
Dim I As Integer
Dim Lewo As Byte

Set Lewo

Const Granicalinii = 500                                    'te wartosc zmieniamy tak, zeby czujniki wykrywaly linie
Const Makspredkosc = 190                                    'maksymalna wartosc PWM z zakresu 0-255 (silniki Pololu ruszaja od ok. 140)
Const Minpredkosc = 160                                     'minimalna wartosc PWM przy ktorej ruszaja silniki

Pwm1a = 0                                                   'silnik prawy (patrz¹c na tyl robota) - wypelnienie PWM
Pwm1b = 0                                                   'silnik lewy (patrzac na tyl robota) - wypelnienie PWM

   Do
      While Przycisk > 0                                    'czekaj na wcisniecie przycisku
         Waitms 100
      Wend

      For I = 1 To 4 Step 1                                 'odliczanie 5 sekund (4 zapalenia diody krotkie, 1 dlugie)
         Set Dioda
         Waitms 100
         Reset Dioda
         Waitms 900
      Next
         Set Dioda
         Waitms 1000
         Reset Dioda



      While Przycisk > 0                                    'wykonuje petle programu dopoki znow nie wcisniemy przycisku

         Gosub Odczytadc
         If Linia1 > Granicalinii Then                      'jesli prawy czujnik wykryje linie
            Gosub Lukprawo

                While Linia2 > Granicalinii
                  If Linia3 > Granicalinii Then
                     Gosub Skretprawo
                  End If
             Wend
         Elseif Linia2 > Granicalinii Then
            Gosub Luklewo

              While Linia1 > Granicalinii
                  If Linia4 > Granicalinii Then
                      Gosub Skretlewo
                  End If
            Wend
         Elseif Linia2 > Granicalinii And Linia1 > Granicalinii Then
              Gosub Jazdaprzod
         Elseif Linia3 > Granicalinii And Linia4 > Granicalinii Then
               Gosub Jazdaprzod
         Else
            Gosub Jazdaprzod

         End If


      Wend

      Set Dioda                                             'sygnalizacja konca pracy
      Pwm1a = 0
      Pwm1b = 0
      Set Mset1a : Reset Mset1b                             'silnik prawy (patrzac na tyl robota) - robot jedzie naprzod
      Set Mset2a : Reset Mset2b
      Waitms 2000
      Reset Dioda

   Loop

End



Odczytadc:
   Start Adc

   Linia1 = Getadc(0)                                       'prawy górny
   Linia2 = Getadc(1)                                       'lewy górny
   Linia3 = Getadc(2)                                       'prawy dolny
   Linia4 = Getadc(3)
                                          'lewy dolny
   Stop Adc
Return


Jazdaprzod:
   Set Mset1a : Reset Mset1b
   Set Mset2a : Reset Mset2b
   Pwm1a = Makspredkosc
   Pwm1b = Makspredkosc
Return

Luklewo:
   Set Mset1a : Reset Mset1b
   Set Mset2a : Reset Mset2b
   Pwm1a = Makspredkosc - 10
   Pwm1b = 0
Return

Lukprawo:
   Set Mset1a : Reset Mset1b
   Set Mset2a : Reset Mset2b
   Pwm1a = 0
   Pwm1b = Makspredkosc - 10
Return

Skretprawo:
   Set Mset1a : Reset Mset1b
   Set Mset2a : Reset Mset2b
   Pwm1a = 0
   Pwm1b = Minpredkosc
Return

Skretlewo:
   Set Mset1a : Reset Mset1b
   Set Mset2a : Reset Mset2b
   Pwm1a = Minpredkosc
   Pwm1b = 0
Return