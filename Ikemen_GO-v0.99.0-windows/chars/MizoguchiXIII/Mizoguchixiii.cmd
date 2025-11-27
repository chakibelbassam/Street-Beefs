; The CMD file.
;
; Two parts: 1. Command definition and  2. State entry
; (state entry is after the commands def section)
;
; 1. Command definition
; ---------------------
; Note: The commands are CASE-SENSITIVE, and so are the command names.
; The eight directions are:
;   B, DB, D, F, UF, U, UB     (all CAPS)
;   corresponding to back, down-back, down, downforward, etc.
; The six buttons are:
;   a, b, c, x, y, z               (all lower case)
;   In default key config, abc are are the bottom, and xyz are on the
;   top row. For 2 button characters, we recommend you use a and b.
;   For 6 button characters, use abc for kicks and xyz for punches.
;
; Each [Command] section defines a command that you can use for
; state entry, as well as in the CNS file.
; The command section should look like:
;
;   [Command]
;   name = some_name
;   command = the_command
;   time = time (optional -- defaults to 15 if omitted)
;
; - some_name
;   A name to give that command. You'll use this name to refer to
;   that command in the state entry, as well as the CNS. It is case-
;   sensitive (QCB_a is NOT the same as Qcb_a or QCB_A).
;
; - command
;   list of buttons or directions, separated by commas.
;   Directions and buttons can be preceded by special characters:
;   slash (/) - means the key must be held down
;          egs. command = /D       ;hold the down direction
;               command = /DB, a   ;hold down-back while you press a
;   tilde (~) - to detect key releases
;          egs. command = ~a       ;release the a button
;               command = ~D, F, a ;release down, press fwd, then a
;          If you want to detect "charge moves", you can specify
;          the time the key must be held down for (in game-ticks)
;          egs. command = ~30a     ;hold a for at least 30 ticks, then release
;   dollar ($) - Direction-only: detect as 4-way
;          egs. command = $D       ;will detect if D, DB or DF is held
;               command = $B       ;will detect if B, DB or UB is held
;   plus (+) - Buttons only: simultaneous press
;          egs. command = a+b      ;press a and b at the same time
;               command = x+y+z    ;press x, y and z at the same time
;   You can combine them:
;     eg. command = ~30$D, a+b     ;hold D, DB or DF for 30 ticks, release,
;                                  ;then press a and b together
;   It's recommended that for most "motion" commads, eg. quarter-circle-fwd,
;   you start off with a "release direction". This matches the way most
;   popular fighting games implement their command detection.
;
; - time (optional)
;   Time allowed to do the command, given in game-ticks. Defaults to 15
;   if omitted
;
; If you have two or more commands with the same name, all of them will
; work. You can use it to allow multiple motions for the same move.
;
; Some common commands examples are given below.
;
; [Command] ;Quarter circle forward + x
; name = "QCF_x"
; command = ~D, F, x
;
; [Command] ;Half circle back + a
; name = "HCB_a"
; command = ~F, DF, D,B, a
;
; [Command] ;Two quarter circles forward + y
; name = "2QCF_y"
; command = ~D, F, D, F, y
;
; [Command] ;Tap b rapidly
; name = "5b"
; command = b, b, b, b, b
; time = 30
;
; [Command] ;Charge back, then forward + z
; name = "charge_B_F_z"
; command = ~60$B, F, z
; time = 10
;
; [Command] ;Charge down, then up + c
; name = "charge_D_U_c"
; command = ~60$D, U, c
; time = 10
;

;-| Super Motions |--------------------------------------------------------
;The following two have the same name, but different motion.
;Either one will be detected by a "command = TripleKFPalm" trigger.
;Time is set to 20 (instead of default of 15) to make the move
;easier to do.
;

[Command]
name = "superkickEX"
command = ~D,B, D,B,b+a
time = 30
buffer.time=3
[Command]
name = "SGS"
command = ~x,x,F,a,y
time = 40
buffer.time=3
[Command]
name = "KKZ"
command = ~D, D,D, x+y
time = 30
buffer.time=3
[Command]
name = "Misogi"
command = ~D, F, D,B, x+y
time = 30
buffer.time=3
[Command]
name = "shinshoryuken"
command = ~D, F, D, F, x
time = 30
buffer.time=3
[Command]
name = "shinshoryuken"
command = ~D, F, D, F, y
time = 30
buffer.time=3
[Command]
name = "superkickB"
command = ~D,B, D,B, a
time = 30
buffer.time=3
[Command]
name = "superkickD"
command = ~D,B, D,B,b
time = 30
buffer.time=3
;-| Special Motions |------------------------------------------------------
[Command]
name = "ASKF"
command = F,D, DF, a+x
time=20
buffer.time=3
[Command]
name = "ASPF"
command = F,D, DF, b+y
time=20
buffer.time=3
[Command]
name = "ASKB"
command = ~F,D, DF, a+x
time=20
buffer.time=3
[Command]
name = "ASPB"
command = B,D,B+y
time=20
buffer.time=3
[Command]
name = "shoryuEX"
command = ~B, D, x+y
time=20
buffer.time=3
[Command]
name = "shoryuEX"
command = ~B, DB,D, x+y
time=20
buffer.time=3
[Command]
name = "joudanEX"
command = ~D,B,a+b
time=15
buffer.time=3
[Command]
name = "hadouEX"
command = ~D, F, x+y
[Command]
name = "shakuEX"
command = ~F, D, B, x+y
time=20

[Command]
name = "shoryux"
command = ~B, D, x
time=20
[Command]
name = "shoryux"
command = ~B, DB,D, x
time=20
[Command]
name = "shoryuy"
command = ~B, D, y
time=20

[Command]
name = "shoryuy"
command = ~B, DB,D, y
time=20

[Command]
name = "joudana"
command = ~D,B,a
time=15
buffer.time=3
[Command]
name = "joudanb"
command = ~D,B,b
time=15
buffer.time=3

[Command]
name = "shakuy"
command = ~F, D, B, y
time=20

[Command]
name = "shakux"
command = ~F, D, B, x
time=20



[Command]
name = "tatsua"
command = ~D, F, a
buffer.time=3
[Command]
name = "tatsuEX"
command = ~D, F,a+b
buffer.time=3
[Command]
name = "tatsub"
command = ~D, F, b
buffer.time=3
[Command]
name = "hadoux"
command = ~D, F, x

[Command]
name = "hadouy"
command = ~D, F, y

[Command]
name = "countera"
command = ~D, D, a
time=15
buffer.time=3
[Command]
name = "counterb"
command = ~D, D, b
time=15
buffer.time=3
[Command]
name = "counterex"
command = ~D, D, a+b
time=15
buffer.time=3
;-| Double Tap |-----------------------------------------------------------
[Command]
name = "FF"     ;Required (do not remove)
command = ~F, F
time = 5

[Command]
name = "BB"     ;Required (do not remove)
command = ~B, B
time = 5



;-| 2/3 Button Combination |-----------------------------------------------
[Command]
name = "recovery";Required (do not remove)
command = x+y
time = 1

[Command]
name = "evade"
command = a+x
time = 1

[Command]
name = "charge"
command = /$b+y
time = 1
[Command]
name = "CD"
command = y+b
time = 1
[Command]
name = "burst"
command = c+z
time = 1

;-| Dir + Button |---------------------------------------------------------
[Command]
name = "down_a"
command = /$D,a
time = 1

[Command]
name = "down_b"
command = /$D,b
time = 1

;-| Single Button |---------------------------------------------------------
[Command]
name = "up"
command = U
time = 1

[Command]
name = "up"
command = UB
time = 1

[Command]
name = "up"
command = UF
time = 1

[Command]
name = "a"
command = a
time = 1
buffer.time=2
[Command]
name = "b"
command = b
time = 1
buffer.time=2
[Command]
name = "c"
command = c
time = 1

[Command]
name = "x"
command = x
time = 1
buffer.time=2
[Command]
name = "y"
command = y
time = 1
buffer.time=2
[Command]
name = "z"
command = z
time = 1

[Command]
name = "start"
command = s
time = 1
;-| ?????????? |-----------------------------------------------------
[Command]
name = "holdfwd"   ;???? (?????????????????????????????)
command = /$F
time = 1
[Command]
name = "holdDfwd"   ;???? (?????????????????????????????)
command = /$DF
time = 1

[Command]
name = "holdback"  ;???? (?????????????????????????????)
command = /$B
time = 1

[Command]
name = "holdup"    ;???? (?????????????????????????????)
command = /$U
time = 1

[Command]
name = "holddown"  ;???? (?????????????????????????????)
command = /$D
time = 1

[Command]
name = "holdxy"
command = /$x+y
time = 1

[Command]
name = "holdc"
command = /$c
time = 1

[Command]
name = "holdx"
command = /$x
time = 1

[Command]
name = "holdy"
command = /$y
time = 1
[Command]
name = "MAX"
command = a+y
time = 1

[Command]
name = "MAX"
command = c
time = 1
;
;--------------------------------------------------------------------------

[Command]
name = "hijump"
command = ~$D, $U
time = 18

[Command]
name = "chargedhijump"
command = ~13$D, $U
[command]
name="fwd"
command=F
time=1
[command]
name="back"
command=B
time=1

[command]
name="down"
command=D
time=1
[command]
name="downf"
command=DF
time=1

;---------------------------------------------------------------------------
; 2. State entry
; --------------
; This is where you define what commands bring you to what states.
;
; Each state entry block looks like:
;   [State -1, Label]           ;Change Label to any name you want to use to
;                               ;identify the state with.
;   type = ChangeState          ;Don't change this
;   value = new_state_number
;   trigger1 = command = command_name
;   . . .  (any additional triggers)
;
; - new_state_number is the number of the state to change to
; - command_name is the name of the command (from the section above)
; - Useful triggers to know:
;   - statetype
;       S, C or A : current state-type of player (stand, crouch, air)
;   - ctrl
;       0 or 1 : 1 if player has control. Unless "interrupting" another
;                move, you'll want ctrl = 1
;   - stateno
;       number of state player is in - useful for "move interrupts"
;   - movecontact
;       0 or 1 : 1 if player's last attack touched the opponent
;                useful for "move interrupts"
;
; Note: The order of state entry is important.
;   State entry with a certain command must come before another state
;   entry with a command that is the subset of the first.
;   For example, command "fwd_a" must be listed before "a", and
;   "fwd_ab" should come before both of the others.
;
; For reference on triggers, see CNS documentation.
;
; Just for your information (skip if you're not interested):
; This part is an extension of the CNS. "State -1" is a special state
; that is executed once every game-tick, regardless of what other state
; you are in.


; Don't remove the following line. It's required by the CMD standard.
[Statedef -1]
[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit=1 
triggerall = p2stateno!=5120	
triggerall = AILevel >6
triggerall = ((var(57)=[500,999]) && power<1000)&&(enemy,backedgebodydist <30 && var(41)=0) || var(41)=[1,5]
trigger1= ((stateno=1025||stateno=1030)) && (var(41)=0)
trigger1 =var(41):=1
trigger1 =var(44):=1051
trigger2= (stateno=1051)&& (var(41)=1)
trigger2 =var(41):=2
trigger2 =var(44):=1025
trigger3= (stateno=1025)&& (var(41)=2)
trigger3 =var(41):=cond(p2life <150&&power>=1000,5,3)
trigger3 =var(44):=cond(p2life <150&&power>=1000,1031,1030)
trigger4= (stateno=1030)&& (var(41)=3)
trigger4 =var(41):=0
trigger4 =var(44):=0
trigger5= (stateno=1030)&& (var(41)=5)
trigger5 =var(41):=0
trigger5 =var(44):=0
ignorehitpause=0
[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit=1 
triggerall = p2stateno!=5120	
triggerall = AILevel >6
triggerall = ((var(57)=[500,999]) && power<1000)&&(enemy,backedgebodydist <30 && var(41)=0) || var(41)=[6,11]
trigger1= (stateno=650&&var(8)) && (var(41)=0)
trigger1 =var(41):=6
trigger1 =var(44):=1005
trigger2= (stateno=1005)&& (var(41)=6)
trigger2 =var(41):=7
trigger2 =var(44):=1025
trigger3= (stateno=1025)&& (var(41)=7 ||var(41)=10)
trigger3 =var(41):=cond(var(41)=10,11,8)
trigger3 =var(44):=cond(var(41)=11,1030,1051)
trigger4= (stateno=1051)&& (var(41)=8)
trigger4 =var(41):=9
trigger4 =var(44):=1050
trigger5= (stateno=1050)&& (var(41)=9)
trigger5 =var(41):=10
trigger5 =var(44):=1025
trigger6= (stateno=1030)&& (var(41)=11)
trigger6 =var(41):=0
trigger6 =var(44):=0
ignorehitpause=0

[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit=1 
triggerall = p2stateno!=5120	
triggerall = AILevel >6 
triggerall = ((var(57)=[500,999]) && power>=1000)&&(enemy,backedgebodydist <25 && var(41)=0) && random>=499|| var(41)=[15,17]
trigger1= (stateno=1036&&var(1)=3 && p2statetype!=C) && (var(41)=0)
trigger1 =var(41):=15
trigger1 =var(44):=1051
trigger2= (stateno=1051)&& (var(41)=15)
trigger2 =var(41):=16
trigger2 =var(44):=1025
trigger3= (stateno=1025)&& (var(41)=16 ||var(41)=10)
trigger3 =var(41):=17
trigger3 =var(44):=2010
trigger4= (stateno=2010)&& (var(41)=17)
trigger4 =var(41):=0
trigger4 =var(44):=0
ignorehitpause=1
[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit=1 
triggerall = p2stateno!=5120	
triggerall = AILevel >6 
triggerall = ((var(57)=[500,999]) && power>=1000)&&(enemy,backedgebodydist <30 && var(41)=0) && random<499 || var(41)=[40,47]
trigger1= (stateno=1037&&var(1)=4) && (var(41)=0)
trigger1 =var(41):=40
trigger1 =var(44):=400
trigger2= (stateno=400)&& (var(41)=41)
trigger2 =var(41):=42
trigger2 =var(44):=410
trigger3= (stateno=410)&& (var(41)=42)
trigger3 =var(41):=43
trigger3 =var(44):=1040
trigger4= (stateno=1036&&var(1)=3) && (var(41)=43)
trigger4 =var(41):=44
trigger4 =var(44):=1051
trigger5= (stateno=1051)&& (var(41)=44)
trigger5 =var(41):=45
trigger5 =var(44):=1025
trigger6= (stateno=1025)&& (var(41)=45)
trigger6 =var(41):=46
trigger6 =var(44):=cond(power>=1000,2010,1030)
trigger7= (stateno=2010)&& (var(41)=46)
trigger7 =var(41):=0
trigger7 =var(44):=0
trigger8= (stateno=1030)&& (var(41)=46)
trigger8 =var(41):=0
trigger8 =var(44):=0
ignorehitpause=1
[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit || stateno=900 
triggerall = p2stateno!=5120	
triggerall = AILevel >6 && (((power=[1000,1999])&&p2life=[400,550])&&power>=2000&&p2life= [450,750])
triggerall = ((var(10)=1) && power=[1000,2999]) || var(41)=[20,27]
trigger1= (stateno=900) && (var(41)=0)
trigger1 =var(41):=20
trigger1 =var(44):=215
trigger2= (stateno=215)&& (var(41)=20)
trigger2 =var(41):=21
trigger2 =var(44):=1040
trigger3= (stateno=1036&&var(1)=3)&& (var(41)=21)
trigger3 =var(41):=22
trigger3 =var(44):=1051
trigger4= (stateno=1051)&& (var(41)=22)
trigger4 =var(41):=23
trigger4 =var(44):=1025
trigger5= (stateno=1025)&& (var(41)=23)
trigger5 =var(41):=24
trigger5 =var(44):=1030
trigger6= (stateno=1030 && animelemtime(6)>0)&& (var(41)=24)
trigger6 =var(41):=25
trigger6 =var(44):=1005
trigger7= (stateno=1030)&& (var(41)=26)
trigger7 =var(41):=27
trigger7 =var(44):=cond(power <2000,2000,2030)
trigger8= (stateno=2030)
trigger8 =var(41):=0
trigger8 =var(44):=0
ignorehitpause=1

[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = movehit || stateno=900 
triggerall = p2stateno!=5120	
triggerall = AILevel >6 && p2life =[350,850]
triggerall = ((var(10)=1) && power>=3000) || var(41)=[30,39]
trigger1= (stateno=900) && (var(41)=0)
trigger1 =var(41):=30
trigger1 =var(44):=215
trigger2= (stateno=215)&& (var(41)=30)
trigger2 =var(41):=31
trigger2 =var(44):=1040
trigger3= (stateno=1036&&var(1)=3)&& (var(41)=31)
trigger3 =var(41):=32
trigger3 =var(44):=1051
trigger4= (stateno=1051)&& (var(41)=32)
trigger4 =var(41):=33
trigger4 =var(44):=1025
trigger5= (stateno=1025)&& (var(41)=33)
trigger5 =var(41):=34
trigger5 =var(44):=1030
trigger6= (stateno=1030 && animelemtime(6)>0)&& (var(41)=34)
trigger6 =var(41):=cond(power>=4000&& var(57)<350,37,35)
trigger6 =var(44):=cond(power>=4000&& var(57)<350,2011,1005)
trigger7= (stateno=1030)&& (var(41)=36)
trigger7 =var(41):=37
trigger7 =var(44):=cond(power>=4000,2011,2000)
trigger8= (stateno=2030)
trigger8 =var(41):=0
trigger8 =var(44):=0
trigger9= (stateno=2012)&& (var(41)=37)
trigger9 =var(41):=38
trigger9 =var(44):=2030
ignorehitpause=1

[State -1, Null]
type = Null
triggerall = !helper(10003),var(37)
triggerall = numhelper(1001)
triggerall = helper(1001),movecontact=1	
triggerall = AILevel >6
trigger1=var(41)=6;||var(40)=9||
trigger1 =var(41):=7
trigger1 =var(44):=1030
trigger2=var(41)=25;||var(40)=9||
trigger2 =var(41):=cond(var(57)>150,24,26)
trigger2 =var(44):=cond(var(57)<70,2030,1030)
trigger3=var(41)=35;||var(40)=9||
trigger3 =var(41):=cond(var(57)>cond(power>=4000,350,250),34,36)
trigger3 =var(44):=1030

[State -1, Null]
type = Null
triggerall = numhelper(2001)
triggerall = helper(2001),movecontact=1	
triggerall = AILevel >6
trigger1=var(41)=37;||var(40)=9||
trigger1 =var(41):=38
trigger1 =var(44):=2030


[State -1, AIgh4]
type = ChangeState
value = var(44)
triggerall = var(44)>0
triggerall = var(44)!=var(45) 
triggerall = roundstate=2
triggerall = var(43)=0
triggerall = stateno!=var(44)
triggerall = stateno!=[1037,1038]
trigger1 = (ctrl&& statetype!=A) 
trigger1=var(41)=2||var(41)=3||var(41)=6||var(41)=7||var(41)=9||var(41)=10||var(41)=16||var(41)=17||var(41)=20||var(41)=23||var(41)=26||var(41)=27||var(41)=40||var(41)=44||var(41)=45
trigger2=(movehit) && (statetype!=A || var(1)=3)
trigger2=var(41)=1||var(41)=8||var(41)=11||var(41)=15||var(41)=21||var(41)=22||var(41)=25||var(41)=26||var(41)=27||var(41)=41||var(41)=42||var(41)=43
trigger3=(movehit && var(57)<150) && statetype!=A
trigger3=var(41)=26
trigger4=(stateno=2000 ) && statetype!=A
trigger4=var(41)=38
trigger5=(movehit) && (statetype!=A || var(1)=3)
trigger5=var(41)=31||var(41)=32||var(41)=35||var(41)=36||var(41)=37 || var(47)=38||var(41)=38
trigger6 = (ctrl&& statetype!=A) 
trigger6=var(41)=30||var(41)=33||var(41)=36||var(41)=37
trigger7 = (ctrl&& statetype!=A) && p2bodydist y >-45
trigger7=var(41)=24||var(41)=34
trigger8 = (animelemtime(6)>0&&animelemtime(8)<0) && stateno=2000
trigger8=var(41)=38
;trigger4= (ctrl&& statetype!=A) && p2bodydist y >-55 
;trigger4=var(41)=2||var(41)=3||var(41)=6||var(41)=7||var(41)=9||var(41)=10||var(41)=16||var(41)=17||var(41)=20||var(41)=23||var(41)=24
;==============================================================================
;MAX???????????
[State -1, MAX GS]
type = ChangeState
value = 2030
triggerall = AILevel >0
triggerall = (random = [0,449])||var(10)=1 && var(57)<50
triggerall = statetype != A
triggerall = stateno != [800,899]
triggerall = enemy,anim!=5120
triggerall = stateno!=900
triggerall=var(5)=0
triggerall = statetype!=L
Triggerall = (RoundState = 2) && p2life <420
triggerall = enemy, anim !=5070
triggerall = (p2bodydist X = [-50,50]) && ((p2movetype=A||p2movetype=H))
trigger1 = ctrl&&(p2statetype=A||p2movetype=A)&&var(10)=0
triggerall = power >= ifelse(var(10)=1,2000,3000)
triggerall = var(57)>=1000 
trigger2= stateno = 300 && (movecontact&&AILevel<5||movehit&&AILevel>=5) && var(8)=1 && var(9)=1
trigger3=var(37)=1
[State -1, L LTAI]
type = ChangeState
value = 2011
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = (random = [0,399])
triggerall=power>=2000
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (P2BodyDist X = [0,170]) || enemy,hitfall || enemy,backedgedist <30 
triggerall =(p2bodydist y =[-70,-15]) ||(p2statetype!=A)
triggerall = p2statetype !=L
triggerall = statetype!=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = var(10)=0
triggerall = helper(10003),var(8)=0
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =  (p2movetype=A||enemy,hitfall) && ctrl
trigger2 = (StateNo = 210)  &&movehit&& p2life <350
trigger3 = (StateNo = 215) &&movehit && p2life <350
trigger4 = StateNo = 235&&animelemtime(2)>0&& p2life <350
trigger5 =StateNo = 400&& animelemtime(2)>0&& p2life <350
trigger6 = (StateNo = 410)&& animelemtime(3)>0 &&movehit&& p2life <350
trigger7=stateno=240 && animelemtime(5)>0 &&movehit && p2life <350
trigger8=stateno=245 && animelemtime(4)>0 &&movehit && p2life <350
trigger9= StateNo = 1025 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) &&movehit&& p2life <350&& animelemtime(8)<0
trigger10= StateNo = 1030  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))  &&movehit&& p2life <350&& animelemtime(8)<0
trigger11=stateno=220 && var(10)=1&&movecontact
trigger12=stateno=300 && (movecontact) && var(8)
trigger13= StateNo = 1000 &&animelemtime(5)>0&&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250  && p2stateno!=[120,155]
trigger14= StateNo = 1005 &&animelemtime(5)>0&&animelemtime(8)<0  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250  && p2stateno!=[120,155]
trigger15= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250  && p2stateno!=[120,155]
;;------------------------------------------------------------------------------
;;?????????
[State -1, L LTAI]
type = ChangeState
value = 2010
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = (random = [0,199])
triggerall=power>=1000
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (P2BodyDist X = [35,170]) || enemy,hitfall || frontedgedist <40
triggerall =(p2bodydist y =[-90,-20]) ||(p2statetype!=A)
triggerall = p2statetype !=L
triggerall = statetype!=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = var(10)=0
triggerall = helper(10003),var(8)=0
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 = p2statetype=A && (p2movetype=A || enemy,hitfall) && ctrl
trigger2 = (StateNo = 210)  &&movehit && p2life <220
trigger3 = (StateNo = 215) &&movehit && p2life <220
trigger4 = StateNo = 235&&animelemtime(2)>0&& p2life <220
trigger5 =StateNo = 400&& animelemtime(2)>0&& p2life <220
trigger6 = (StateNo = 410)&& animelemtime(3)>0 &&movehit && p2life <220
trigger7=stateno=240 && animelemtime(5)>0 &&movehit && p2life <220
trigger8=stateno=245 && animelemtime(4)>0 &&movehit && p2life <220
trigger9= StateNo = 1025 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) &&movehit && p2life <250&& animelemtime(8)<0
trigger10= StateNo = 1030  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))  &&movehit && p2life <250&& animelemtime(8)<0
trigger11=stateno=220 && var(10)=1&&movecontact
trigger12=stateno=300 && (movecontact) && var(8)
trigger13= StateNo = 1000 &&animelemtime(5)>0&&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250 && p2stateno!=[120,155]
trigger14= StateNo = 1005 &&animelemtime(5)>0&&animelemtime(8)<0  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250 && p2stateno!=[120,155]
trigger15= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250 && p2stateno!=[120,155]
trigger16= (StateNo = [1036,1037]) &&movehit&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && p2life <250
;;------------------------------------------------------------------------------
;?????????
[State -1, L KW]
type = ChangeState
value = 2000
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = power >= ifelse(var(10)=1,3000,1000)
Triggerall = (P2BodyDist X >= 70) || movehit || enemy,hitfall && p2bodydist y <-25
triggerall =(p2bodydist y =[-85,0]) 
triggerall = statetype != A
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
triggerall = statetype!=L
triggerall = (random = [0,149])
triggerall = p2statetype !=L
triggerall = helper(10003),var(8)=0
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = var(10)=0 || (var(57)<100&&var(10)=1)||(var(57)<300&&var(10)=1 &&p2life<600)
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =ctrl&&(p2statetype=A||p2movetype=A) ||stateno=101
trigger2 = (StateNo = 210)  &&movehit && p2life <250
trigger3 = (StateNo = 215) &&movehit && p2life <250
trigger4 = StateNo = 235&&animelemtime(2)>0&& p2life <250
trigger5 =StateNo = 400&& animelemtime(2)>0&& p2life <250
trigger6 = (StateNo = 410)&& animelemtime(3)>0 &&movehit && p2life <250
trigger7=stateno=240 && animelemtime(5)>0 &&movehit && p2life <250
trigger8=stateno=245 && animelemtime(4)>0 &&movehit && p2life <250
trigger9= StateNo = 1025 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) &&movehit && p2life <250&& animelemtime(8)<0
trigger10= StateNo = 1030  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))  &&movehit && p2life <250 && animelemtime(6)>0
trigger11=stateno=220 && var(10)=1&&movecontact
trigger12=stateno=300 && (movecontact) && var(8)

;------------------------------------------------------------------------------
;?????
[State -1, MAXACTIVATE]
type = ChangeState
value = ifelse(statetype=A&&var(8)=1,901,900)
triggerall = var(57)>=1000
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = P2BodyDist X = [0,170]
Triggerall = p2movetype=H || var(8)=1
triggerall = p2stateno!=[120,155]
triggerall = p2statetype !=L &&enemy,backedgedist <25
triggerall =  (power>=2000 ) || power>=4000
trigger1 = (stateno = [210,215]) && movehit
trigger2 = (stateno = [240,245]) && movehit
trigger3 = (StateNo = 410) && movehit
trigger4 = stateno = 300 && movehit && var(8)=1 && (prevstateno!=[120,155])
trigger5= stateno=430 && movehit
;trigger7 = statetype=A && ctrl&& var(8)=1

;------------------------------------------------------------------------------
;?????????
[State -1, S LTAI]
type = ChangeState
value = 1030
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (P2BodyDist X = [-15,45]) || (p2statetype=A && p2bodydist x =[0,55])
triggerall =p2bodydist y =[-55,18]
Triggerall = Random < 30*AIlevel||(p2movetype=H&&p2stateno!=[120,155])
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = var(15)=0 ||var(20)||var(10)
triggerall = var(27)<5
triggerall = p2stateno!=1220
triggerall = p2statetype=A||p2stateno!=[120,155]
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =(ctrl&&(p2movetype=A||p2movetype=H) ||stateno=101) &&  (helper(10003),var(10)=0&&helper(10003),var(11)=0)
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1025
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (P2BodyDist X = [-15,30]) || (p2statetype=A && p2bodydist x =[0,45])
triggerall =(!enemy,hitfall&&p2bodydist y =[-55,0])||enemy,hitfall&&p2bodydist y =[-55,-15]
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = p2statetype=A||p2stateno!=[120,155]
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =(ctrl&&(p2movetype=A) ||stateno=101)&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0)


;-----------
[State -1, S LT EX]
type = ChangeState
value = 1031
triggerall = power >=1500
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (P2BodyDist X = [0,30]) || (p2statetype=A && p2bodydist x =[0,65])
triggerall =p2bodydist y =[-75,-5]
Triggerall = Random < ifelse((p2movetype=H&&p2stateno!=[120,155]),60,40)
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = power>=1000
triggerall = p2statetype=A||p2stateno!=[120,155]
triggerall = var(27)<5
triggerall = p2statetype!=A || p2movetype=H
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =ctrl&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0)
trigger2 =stateno=215 && movehit && p2life <200
trigger3 = stateno = 235 && (movecontact&&AILevel<5||movehit&&AILevel>=5)&&movetype=A&& p2life <200
trigger4 = StateNo = 400 && (time=[4,5]) && random<45&&movetype=A&& p2life <200
trigger5 = StateNo = 205 && animelemtime(2)>0 && random<45&&movetype=A&& p2life <200
;==============================================================================
[State -1, Guard]
type = ChangeState
value = 120
triggerall = movetype !=H
triggerall = roundstate = 2
triggerall = stateno!=[120,155]
triggerall=AILevel>0
triggerall = (statetype!=A)
triggerall =(StateNo !=[200,3999])&&(StateNo != 105)
Triggerall =  Random < (113*AILevel)
triggerall =InGuardDist || enemynear,hitdefattr=SCA,NP,SP,HP || enemynear,hitdefattr = SCA,AA
triggerall =((EnemyNear, movetype=A&& enemynear,hitdefattr!=SCA,AA)||( enemynear,hitdefattr=SCA,NP,SP,HP || enemynear,hitdefattr = SCA,AA))|| enemy,numproj >0
trigger1 = (ctrl ||stateno=20) 
trigger2= prevstateno=5120 && p2movetype=A && p2bodydist x <70
trigger3= stateno=5129 && ctrl&& p2movetype=A && p2bodydist x <70
;????????
;------------------------------------------------------------------------
[State -1, AI Throw]
type = ChangeState
value = ifelse(backedgebodydist <40,805,800)
triggerall = AILevel >0
triggerall = random <=15*AIlevel
triggerall = statetype = S
triggerall = p2statetype != A
triggerall = ctrl 
triggerall = var(10)=0|| p2movetype!=H
triggerall = p2statetype!=L
triggerall = (stateno!=[900,901])
triggerall = stateno != [200,9999]
Triggerall = (RoundState = 2)
triggerall = (p2MoveType != H)
trigger1 = p2bodydist X < 25 && p2dist y <= 0
trigger2 = (p2stateno =[120,150]) &&(p2bodydist X < 25 && p2dist y <= 0)

;------------------------------------------------------------------------------
;Stand Light Punch
;?§?????p?“?`
[State -1, Stand Light Punch]
type = ChangeState
value =ifelse(p2bodydist x<20,205,200)
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [0,45]
triggerall = var(27)<5
triggerall = (p2bodydist y= [-55,0]) && enemy,vel y >=0 && p2movetype!=A
Triggerall = Random < ifelse(p2statetype=A,150,ifelse(p2bodydist x<30,500,100))
triggerall = p2statetype !=L
triggerall = movetype!=H
triggerall = var(41)=0
triggerall = enemy, statetype != C
triggerall  =var(10)=0|| p2movetype!=H
triggerall = stateno!=900
triggerall = p2movetype!=H 
trigger1= ( ctrl||stateno=20 ||stateno=[101,102])&& helper(10003),var(10)>0&& p2bodydist x <=20
trigger2=animelemtime(2)>0&& stateno=[200,205]
trigger3=animelemtime(2)>0&&stateno=400
;----------------------------------------------------------------------------
;?????????
[State -1, Stand Strong Punch]
type = ChangeState
value = ifelse(p2bodydist x<25,215,210)
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
triggerall = var(27)<5
Triggerall = P2BodyDist X = [0,70]
triggerall = p2statetype!=A
triggerall = helper(10003),var(8)=0
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(41)=0
triggerall = movetype!=H
triggerall = enemy, statetype != C
trigger1= ( ctrl||stateno=20 ||stateno=[101,102])&& helper(10003),var(11)>0&& p2bodydist x <=25
trigger2 = ctrl&& stateno=900 && p2bodydist x<60
trigger3=( ctrl||stateno=20 ||stateno=[101,102]) && (p2bodydist x=[45,75]) && p2statetype!=A &&random <199&&helper(10003),var(11)=0&&helper(10003),var(10)=0
trigger4=movecontact&& stateno=[200,205]
trigger5=movecontact&& stateno=400

;------------------------------------------------------------------------------
;?????????
[State -1, Stand Light Kick]
type = ChangeState
value = ifelse(p2bodydist x<25,235,230)
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [0,55]
triggerall = p2statetype!=A ||p2bodydist y =[-55,-15]
Triggerall = Random <ifelse(p2bodydist x<25,350,75)
triggerall = p2statetype !=L
triggerall = var(41)=0
triggerall = helper(10003),var(8)=0
triggerall = movetype!=H
triggerall  =var(10)=0|| p2movetype!=H
triggerall = stateno!=900
trigger1= ( ctrl||stateno=20 ||stateno=[101,102])&& (helper(10003),var(10)>0||helper(10003),var(11)>0)&& p2bodydist x <=25
trigger2=( ctrl||stateno=20 ||stateno=[101,102]) && (p2bodydist x=[21,40]) && p2statetype=A && p2movetype=I&&random <199&&helper(10003),var(11)=0&&helper(10003),var(10)=0
;---------------------------------------------------------------------------

;?????????
[State -1, Standing Strong Kick]
type = ChangeState
value = ifelse(p2bodydist x<=25,245,240)
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [0, 65]
triggerall = var(27)<5 
triggerall = movetype!=H
triggerall = (p2bodydist y= [-45,0]) && enemy,vel y >=0 && p2movetype!=A
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(41)=0
triggerall = helper(10003),var(8)=0
triggerall = p2movetype!=A || (enemy,hitdefattr!=SCA,AA,AT)
triggerall = enemy, statetype != C || (p2bodydist x <25) || movehit
triggerall  =var(10)=0
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1=( ctrl||stateno=20 ||stateno=[101,102]) && ((p2statetype=A && p2bodydist x =[35,65])||p2bodydist x=[55,65]) &&random <199&&helper(10003),var(11)=0&&helper(10003),var(10)=0
trigger2=movecontact&& stateno=430 && (p2bodydist x>25 || p2bodydist x <15)
trigger3 = StateNo = 235&& movecontact


[State -1, Taunt]
type = ChangeState
value = 195
triggerall = AILevel >0
triggerall = winko
triggerall = random<299
triggerall = gametime%30=0
triggerall = enemy,life < (enemy,lifemax/2.25) ||winko
triggerall = life >700 ||winko
triggerall = p2statetype = L
triggerall = p2bodydist x >120
triggerall = statetype != A
trigger1 = ctrl
;?????????


;------------------------------------------------------------------------------
;????????
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [0,40]
triggerall = p2statetype!=A
triggerall = movetype!=H
Triggerall = Random < ifelse(p2bodydist x <35,350,150)
triggerall = var(27)<5 
triggerall = p2movetype!=A || (enemy,hitdefattr!=SC,AA,AT)
triggerall = p2statetype !=L
triggerall = stateno!=900
triggerall = var(34)=0
triggerall = var(41)=0
triggerall = p2stateno!=[120,155]
triggerall = helper(10003),var(8)=0
triggerall = movetype!=H
triggerall  =var(10)=0|| (p2movetype=H && (p2stateno!=[120,155]))
trigger1 =  ( ctrl||stateno=20 ||stateno=[101,102])&& helper(10003),var(10)>0&& p2bodydist x <=30
trigger2 =  ( ctrl||stateno=20 ||stateno=[101,102])&& helper(10003),var(10)=0&& p2bodydist x <=35
;????????
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [-10,20]
triggerall = p2statetype!=A
triggerall = movetype!=H
Triggerall = Random < ifelse(p2statetype=A,300,100)
triggerall = p2statetype !=L
triggerall = var(27)<5 
triggerall = var(41)=0
triggerall  =var(10)=0|| p2movetype!=H
triggerall = p2bodydist y =[-25,-50]
triggerall = helper(10003),var(8)=0||p2statetype=A 
triggerall = p2movetype!=A || (enemy,hitdefattr!=SC,AA,AT)
triggerall = statetype != A
trigger1 = ctrl&& p2statetype=A

;------------------------------------------------------------------------------
;????????
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [-7,45]
triggerall = p2statetype!=A
triggerall = var(41)=0
triggerall = var(27)<5 || p2statetype=S
Triggerall = Random < 35*AILevel
triggerall = p2statetype !=L
triggerall = movetype!=H
triggerall = p2movetype!=A || (enemy,hitdefattr!=CA,AA,AT)
triggerall  =var(10)=0 || (p2movetype=H && (p2stateno!=[120,155]))
trigger1= ( ctrl||stateno=20 ||stateno=[101,102])&& helper(10003),var(10)>0&& p2bodydist x <=40
trigger2= p2statetype=S && ctrl && p2bodydist x <40&& (helper(10003),var(10)=0 && helper(10003),var(11)=0)

;????????
[State -1, Crouching Strong Kick]
type = ChangeState
value =  440
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType != A)
triggerall = stateno != [800,3999]
Triggerall = P2BodyDist X = [0,80]
triggerall = p2statetype!=A
triggerall = var(27)<5 || p2statetype=S
Triggerall = Random <ifelse(p2bodydist x >40,150,100)
triggerall = p2statetype !=L
triggerall = stateno!=900
triggerall = var(41)=0
triggerall = movetype!=H
triggerall = helper(10003),var(8)=0
triggerall = p2movetype!=A || (enemy,hitdefattr!=CA,AA,AT)
triggerall  =var(10)=0|| p2movetype!=H
trigger1=( ctrl||stateno=20 ||stateno=[101,102]) && (p2bodydist x=[55,80]) && p2statetype!=A &&random <199&&helper(10003),var(11)=0&&helper(10003),var(10)=0
trigger2=movecontact&& stateno=430
trigger3 = StateNo = 235&& moveguarded && p2statetype=S

;------------------------------------------------------------------------------
;????????
[State -1, Jump Light Punch]
type = ChangeState
value = 600
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType = A)
triggerall = stateno != [800,3999]
triggerall = vel y>0 || p2statetype=A
triggerall = ((((p2bodydist y=[-30,40])&&p2movetype!=A)||((p2bodydist y=[-30,65])&&p2movetype=A))&&var(3)!=2)||((((p2bodydist y=[20,25])&&p2movetype!=A)||((p2bodydist y=[20,35])&&p2movetype=A))&&var(3)=2) 
triggerall = p2bodydist x = [0,40]
Triggerall = Random < 450
triggerall =p2statetype!=C
triggerall = stateno!=50|| stateno=57
triggerall = stateno!=901
triggerall = p2statetype !=L
trigger1 = ctrl

;??????????
[State -1, Jump Strong Punch]
type = ChangeState
value = 610
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType = A)
triggerall = vel y>0
triggerall = stateno!=901
triggerall = stateno != [800,3999]
triggerall =p2statetype!=C
triggerall = ((p2bodydist y=[55,75])&&var(3)!=2)|| ((p2bodydist y=[30,45])&&var(3)=2)
triggerall = p2bodydist x = [-0,60]
Triggerall = Random < 500
trigger1 = ctrl




;------------------------------------------------------------------------------
;????????
[State -1, Jump Light Kick]
type = ChangeState
value = 630
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType = A)
triggerall = stateno != [800,3999]
triggerall = stateno!=901
triggerall = vel y>0 || p2statetype=A
triggerall = ((p2bodydist y=[-30,40])&&var(3)!=2)|| ((p2bodydist y=[20,25])&&var(3)=2)
triggerall = p2bodydist x = [-30,40]
Triggerall = Random < 450
triggerall = stateno=50|| stateno=57
triggerall = p2statetype !=L
trigger1 = ctrl

;??????????
[State -1, Jump Strong Kick]
type = ChangeState
value = 640
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType = A)
triggerall = vel y>0
triggerall = stateno!=901
triggerall = stateno != [800,3999]
triggerall = ((p2bodydist y=[45,85])&&var(3)!=2)|| ((p2bodydist y=[30,55])&&var(3)=2)
triggerall = p2bodydist x <55 && enemy,backedgebodydist <30 ||p2bodydist x = [-40,60]
Triggerall = Random < 500
trigger1 = ctrl

;------------------------------------------------------------------------------
;???????
[State -1, CD]
type = ChangeState
value = 650
Triggerall = (RoundState = 2) && (AILevel>0)
Triggerall = (StateType = A)
triggerall = stateno != [800,3999]
triggerall = ((p2bodydist y=[-25,75])&&var(3)!=2 && vel y >0)|| ((p2bodydist y=[-10,45])&&var(3)=2)
triggerall = p2bodydist x = [5,85]
Triggerall = Random < ifelse(p2movetype=A,300,185)
triggerall = p2statetype !=L
trigger1 = ctrl
;------------------------------------------------------------------------------
;???????
[State -1, DK]
type = ChangeState
value = 660
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = stateno != [800,3999]
triggerall = (p2bodydist y>=-20)
triggerall = p2bodydist x = [-65,85]
Triggerall = Random <250&& statetype=A && (p2movetype=A || movecontact)
triggerall = stateno != 105 &&var(3)!=2
trigger1 = ctrl && enemy,numproj > 0&& pos y <-10
trigger2 = moveguarded&& (stateno=[600,640]) && p2bodydist x <0
[State -1, change]
type = ChangeState
value = 1055
triggerall = Ailevel>0  && movehit
triggerall = roundstate=2 && var(10)=0&& var(41)=0
trigger1 =animelemtime(8)>0 &&animelemtime(10)<0  && (anim=1200||anim=1202)
trigger2 =animelemtime(9)>0 &&animelemtime(11)<0  && (anim=1201) && prevstateno!=[1025,1030]
trigger3 =animelemtime(7)>0 &&animelemtime(9)<0  && (anim=[1210,1212])
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1051
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (p2statetype=A && p2bodydist x =[0,50])
triggerall = movehit&&p2statetype=A||p2bodydist y =[-70,-30]
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =(ctrl&&(p2movetype=A) ||stateno=101)&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0)
trigger2 = stateno=1025 &&movehit && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& random <3*AIlevel&& animelemtime(8)<0
trigger3 = stateno=1030 &&movehit && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& random <3*AIlevel&& animelemtime(8)<0
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1050
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (p2statetype=A && p2bodydist x =[-15,45])
triggerall =p2bodydist y =[-70,-20]
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =(ctrl&&(p2movetype=A) ||stateno=101)&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0)
trigger2 = stateno=1025 &&movehit && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && random <3*AIlevel&& animelemtime(8)<0

;------------------------------------------------------------------------------
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1052
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
triggerall = power>=1000
Triggerall = p2bodydist y =[-60,10]
Triggerall = Random < 27*AIlevel
Triggerall = (p2statetype=A && p2bodydist x =[-10,35])
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = var(27)<5
triggerall = p2movetype=A
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =ctrl&&(enemy,numproj>0 ||p2movetype=A) ||stateno=101

[State -1, change]
type = ChangeState
value = cond(var(1)=4,1039,cond(var(1)=3,1038,cond(var(1)=0||var(1)=2,1036,1037)))
triggerall = var(11)=1
triggerall = AILevel>0 
triggerall = roundstate=2
triggerall = random <149 || movecontact
trigger1 =animelemtime(5)>1 &&animelemtime(7)<2 && (anim=1100 || anim=1102)
trigger2 =animelemtime(3)>1 &&animelemtime(6)<2&&  (anim=1105||anim=1110)
trigger3 =animelemtime(6)>1 &&animelemtime(8)<2  && (anim=1101)
;--------------------------------------------------------------------
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1035
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = (p2statetype=A && p2bodydist x =[0,55])
triggerall =p2bodydist y =[-60,-30]
Triggerall = Random < 30*AIlevel
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = p2statetype!=A
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1=movecontact&& stateno=410
trigger2 = StateNo = 215&& movecontact
trigger3 = StateNo = 210&& movecontact
trigger4 = StateNo = 245&& movecontact&& (animelemtime(7)>0 || p2bodydist x>50)
trigger5 = StateNo = 240&& movehit
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1040
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = ( p2bodydist x =[0,65])
triggerall =p2statetype!=A
Triggerall = Random < 45*AIlevel
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = p2statetype!=A
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
trigger1 =(ctrl ||stateno=101)&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0) && (p2statetype=C || enemy,numproj >0)
trigger2=movecontact&& stateno=410
trigger3 = StateNo = 215&& (movecontact && p2statetype=C || movehit)
trigger4 = StateNo = 210&& (movecontact && p2statetype=C || movehit)
trigger5 = StateNo = 245&& (movecontact && p2statetype=C || movehit)&& (animelemtime(7)>0 || p2bodydist x>50)
trigger6 = StateNo = 240&& (movecontact && p2statetype=C || movehit)
;------------------------------------------------------------------------------
;?????????
[State -1, L LTAI]
type = ChangeState
value = 1041
Triggerall = (RoundState = 2) && (AILevel>0) 
Triggerall = (StateType != A)
triggerall = stateno != [800,899]
triggerall = p2stateno != [800,899]
triggerall = stateno != [2000,3999]
Triggerall = ( p2bodydist x =[0,53])
triggerall =p2statetype!=A
Triggerall = Random < 15*AIlevel && enemy,backedgebodydist <30
triggerall = p2statetype !=L
triggerall = var(5)=0
triggerall = var(41)=0
triggerall = p2stateno!=1220
triggerall = p2statetype!=A
triggerall = var(27)<5
triggerall = ((p2stateno!=[1151,1153])&&(p2stateno!=[1360,1361]))
triggerall = power>=1000
trigger1 =(ctrl ||stateno=101)&&  (helper(10003),var(10)=0&&helper(10003),var(11)=0) && (p2statetype=C)
trigger2=movecontact&& stateno=410
trigger3 = StateNo = 215&& movecontact
trigger4 = StateNo = 210&& movecontact
trigger5 = StateNo = 245&& movecontact&& animelemtime(7)>0
trigger6 = StateNo = 240&& movecontact

;------------------------------------------------------
;??????????
[State -1, L BB AI]
type = ChangeState
value =  1000
triggerall = random<  6*AIlevel
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = numhelper(1001)<=0
triggerall = (statetype!=A &&p2bodydist y =[-55,0])
triggerall = var(15)=0
triggerall = stateno!=[1000,1006]
triggerall = statetype!=A
triggerall = p2bodydist x >70 || movecontact && p2bodydist x >45
triggerall = (p2stateno!=1151&&(p2stateno!=[1360,1361]) &&(p2stateno!=[1290,1292]))
trigger1 = helper(10003),var(20)&& (ctrl || movecontact)
trigger2 = StateNo = 215 && moveguarded
trigger3 = StateNo = 210 && moveguarded
trigger4 = StateNo = 410&& moveguarded
trigger5 = stateno=440 &&moveguarded
trigger6= StateNo = 245 && movecontact
;??????????
[State -1, S BB AI]
type = ChangeState
value = 1005
triggerall =  random< 6*AIlevel
triggerall = (statetype!=A &&p2bodydist y =[-55,0])
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = numhelper(1001)<=0
triggerall = var(15)=0
triggerall = stateno!=[1000,1006]
triggerall = statetype!=A
triggerall = p2bodydist x >70|| enemy,hitfall && p2bodydist x <50
triggerall = !movehit || stateno=[1025,1030]
triggerall = (p2stateno!=1151&&(p2stateno!=[1360,1361]) &&(p2stateno!=[1290,1292]))
trigger1 = helper(10003),var(21)&& (ctrl || movecontact)
trigger2 = StateNo = 215 && moveguarded
trigger3 = StateNo = 210 && moveguarded
trigger4 = StateNo = 410&& moveguarded
trigger5 = stateno=440 &&moveguarded
trigger6= StateNo = 245 && movecontact
;??????????
[State -1, S BB AI]
type = ChangeState
value = 1006
triggerall = random< ifelse(p2bodydist x<100&&var(9)=1,15,0)
triggerall = (p2bodydist x <40 && var(9)=0) ||  (p2bodydist x >70 && var(9)=1)
triggerall = (statetype!=A &&p2bodydist y =[-55,0])
Triggerall = (RoundState = 2) && (AILevel>0)&&power>=1000&&var(20)
triggerall = numhelper(1001)<=0
triggerall = stateno!=[1000,1006]
triggerall = statetype!=A
triggerall =p2bodydist x >70 || movehit && p2bodydist x <40
triggerall = (p2stateno!=1151&&(p2stateno!=[1360,1361]) &&(p2stateno!=[1290,1292]))
trigger1 = StateNo = 215 && movehit
trigger2 = StateNo = 210 && movehit
trigger3 = StateNo = 240 && movehit
trigger4 = StateNo = 245 && movehit
trigger5 = StateNo = 410&& movehit

;---------------------------------------------------------------------------
;?????
[State -1, T S]
type = ChangeState
value = 710
triggerall = random <ifelse(((p2bodydist x <40)||numproj >0),150,99)
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = backedgebodydist >100
triggerall = statetype != A
triggerall = var(41)=0&&helper(10003),var(11)=0&&helper(10003),var(10)=0
trigger1 = (p2movetype=A&&enemy,numproj =0)&&ctrl
trigger2 = power >= 1000
trigger2 = (stateno = 150||stateno=152) && p2bodydist x <75&& p2bodydist x <60&& (p2stateno=[1000,4999])
trigger3 = (stateno = [100,102]) && p2movetype=A
;---------------------------------------------------------------------------
;?????
[State -1, T S]
type = ChangeState
value = 700
triggerall = random <ifelse(((p2bodydist x <40)||numproj >0),150,99)
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = backedgebodydist <50 || enemy,numproj >0
triggerall = statetype != A
triggerall = var(41)=0&&helper(10003),var(11)=0&&helper(10003),var(10)=0
trigger1 = (p2movetype=A || enemy,numproj >0)&&ctrl
trigger2 = power >= 1000
trigger2 = (stateno = 150||stateno=152) && p2bodydist x <75&& p2bodydist x <60&& (p2stateno=[1000,4999])
trigger3 = (stateno = [100,102]) && p2movetype=A

;---------------------------------------------------------------------------
;??
[State -1, UKEMI]
type = ChangeState
value = 52000
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall= random <ifelse((enemy,hitdefattr=SCA,SA,HA),75,700)
triggerall = alive = 1
trigger1 = stateno = 5050
trigger1 = pos y > -5
trigger1 = vel y > 0 && vel y < 9

;------------------------------------------------------------------------------
;?????
[State -1, BLOWBACKAI]
type = ChangeState
value = 300
triggerall = random <ifelse((enemy,hitdefattr=SCA,SA,HA),500,49)
Triggerall = (RoundState = 2) && (AILevel>0)
triggerall = p2bodydist x<50
triggerall = p2statetype!=L
triggerall =life <= (lifemax/2.25)
trigger1 = statetype != A
trigger1 = (ctrl ||stateno=101) && p2statetype=A &&( p2bodydist x =[35,55])&&enemy,vel x >4
trigger2 = power >= 1000
trigger2 = (stateno = [150,153])&& p2bodydist x <60&& (p2stateno=[1000,4999])

;-------------------------------------------------
[state -1, AI jump]
type = changestate
triggerall = stateno!=[40,51]
triggerall = statetype!=A
triggerall = roundstate = 2
triggerall = AILevel>0
triggerall = var(10)=0|| p2movetype!=H
trigger1= var(30)=1&&ctrl
value = 40


[State -1, AI run]
type=changestate
value=100
triggerall = roundstate = 2
triggerall = var(58)!=2
triggerall=AILevel>0 && statetype!=A && ctrl
triggerall = (stateno!=[100,105])
triggerall = p2bodydist y =[-150,0]
triggerall = var(41)=0
triggerall = var(10)=0 || p2movetype!=H
triggerall = p2stateno!=834 || p2bodydist x >80
trigger1= (p2movetype!=A&&p2statetype!=L||numproj>0) && (p2bodydist x=[150,788])&& random < 99
trigger2= ((p2stateno=[1360,1361])||stateno=1151)&& p2bodydist x >65&& random < 149
trigger3 = p2bodydist x >50 && p2statetype=A && enemy,hitfall && ctrl && p2bodydist y <-15

[State -1, AI run]
type=changestate
value=20
triggerall = roundstate = 2
triggerall = p2stateno!=834 || p2bodydist x >50 || p2bodydist x <20
triggerall=AILevel>0 && statetype=S && ctrl && random < 249
triggerall = var(10)=0 || p2movetype!=H
triggerall=p2statetype!=L
trigger1= (stateno!=[20,105]) && p2movetype!=A && (p2bodydist x=[40,149])

[State -1, AIRun Back]
type = ChangeState
value = 105
triggerall = AILevel>0
triggerall = stateno !=105
triggerall = statetype != A
triggerall = (p2stateno!=1151&& p2stateno!=1360&&p2stateno!=1361&&(p2stateno!=[1290,1292]))
triggerall = random < 79
triggerall = roundstate = 2
triggerall = p2statetype!=A||p2movetype=A
triggerall = ctrl
trigger1 = (p2movetype=A) && (p2bodydist x=[-99,15])
trigger2 = p2statetype=L && p2bodydist x <15
;---------------------------------------------------------------------------

;Shin Shouryuu Ken LDM
[State -1, Misogi/KKZ]
type = ChangeState
value = 2030
triggerall = (command = "Misogi") 
triggerall = power >= ifelse(var(10)=1,2000,3000)
triggerall = var(57)>=1000 || (var(10)=1 && var(57)>0)
triggerall = AILevel=0
triggerall = roundstate=2
triggerall= statetype != A
trigger1 = ctrl ||(stateno=101)
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&movecontact && (var(57)>0 && var(10)=1)&& animelemtime(8)<0
trigger14= StateNo = 1030 &&movecontact  && (var(57)>0 && var(10)=1)&& animelemtime(8)<0
trigger15= StateNo = 1031 &&movecontact && (var(57)>0 && var(10)=1)
trigger16=stateno=210 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger18=(stateno=2012) && movecontact&& (var(57)>0 && var(10)=1) && animelemtime(12)<0
trigger19=(stateno=2000) &&(var(57)>0 && var(10)=1) && animelemtime(6)>0&& animelemtime(8)<0
trigger20= StateNo = 1000 &&animelemtime(5)>0 &&animelemtime(8)<0&& (var(57)>0 && var(10)=1)
trigger21= StateNo = 1005 &&animelemtime(5)>0&&animelemtime(8)<0  && (var(57)>0 && var(10)=1)
trigger22= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& (var(57)>0 && var(10)=1)
;---------------------------------------------------------------------------
;Shin Shouryuu Ken LDM
[State -1, SGS]
type = ChangeState
value = 2011
triggerall = command = "superkickEX" && Power >= 2000
triggerall = roundstate=2
triggerall = AILevel=0
trigger1 = ctrl ||(stateno=101)
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16= StateNo = 1050 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger17= StateNo = 1051 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger18= StateNo = 1052 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger19=stateno=220 && var(10)=1&&movecontact
trigger20=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger21= (StateNo = [1031,1037]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger22= StateNo = 1000 &&animelemtime(5)>0 &&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger23= StateNo = 1005 &&animelemtime(5)>0 &&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger24= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
;---------------------------------------------------------------------------
;Shin Shouryuu Ken LDM
[State -1, Shin Shouryuu Ken]
type = ChangeState
value = 2010
triggerall = (command = "superkickB"||command = "superkickD") && Power >= 1000
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101)
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16= StateNo = 1050 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger17= StateNo = 1051 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger18= StateNo = 1052 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger19=stateno=220 && var(10)=1&&movecontact
trigger20=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger21= (StateNo = [1031,1037]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger22= StateNo = 1000 &&animelemtime(5)>0&&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger23= StateNo = 1005 &&animelemtime(5)>0 &&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger24= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
;---------------------------------------------------------------------------
;Shin Shouryuu Ken LDM
[State -1, Shin Shouryuu Ken]
type = ChangeState
value = 2000
triggerall = command = "shinshoryuken" && Power >= 1000
triggerall = statetype!=A
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101)
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&movecontact && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&movecontact  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&movecontact && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger18 = movecontact&&stateno=[600,645]
trigger19= StateNo = 1000 &&animelemtime(5)>0&&animelemtime(8)<0 && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger20= StateNo = 1005 &&animelemtime(5)>0&&animelemtime(8)<0  && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger21= StateNo = 1006 &&animelemtime(5)>0&&animelemtime(8)<0&& ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))

;===========================================================================



;---------------------------------------------------------------------------
;EX Tatsumaki Senpuu Kyaku
[State -1, EX Tatsumaki Senpuu Kyaku]
type = ChangeState
value = 1041
triggerall = command = "tatsuEX"
triggerall = power>=1000
triggerall =  stateno!=41
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger18 = movecontact&&stateno=[600,645]
;---------------------------------------------------------------------------
;Weak Shakunetsu Hadou Ken
[State -1,EX Shoryuken]
type = ChangeState
value = 1031
triggerall = command = "shoryuEX" && command!="holdfwd"
triggerall = statetype != A
triggerall = AILevel=0
triggerall = roundstate=2
triggerall = power>=1000
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15=stateno=220 && var(10)=1&&movecontact
trigger16=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)

;---------------------------------------------------------------------------
;EX Hadou Ken
[State -1, EX Hadou Ken]
type = ChangeState
value =1006
triggerall = command = "hadouEX" 
triggerall = AILevel=0
triggerall = numhelper(1001)=0
triggerall = roundstate=2
triggerall = statetype!=A
triggerall = power>=1000
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;---------------------------------------------------------------------------
;weak Joudan Sokutou Geri
[State -1, EX demon flip]
type = ChangeState
value =1052
triggerall = (command = "joudanEX" )
triggerall = AILevel=0
triggerall = power>=1000

triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = StateNo = 205 &&animelemtime(2)>0
trigger3 = StateNo = 215 &&((animelemtime(3)>0)||(animelemtime(2)>0&&var(9)=1))
trigger4 = StateNo = 235&&animelemtime(2)>0
trigger5 =StateNo = 400&& animelemtime(2)>0
trigger6 = (StateNo = 410+var(9))&& animelemtime(ifelse(var(9)=1,3,5))>0
trigger7 = StateNo = 430&& animelemtime(2)>0
trigger8 = stateno=440 && animelemtime(5)>0
trigger9 = StateNo = 450&& animelemtime(3)>0&&movetype=A
trigger10=stateno=200 && var(10)=1&&movecontact
trigger11=stateno=210 && var(10)=1&&movecontact
trigger12=stateno=230 && var(10)=1&&movecontact
trigger13=stateno=240 && var(10)=1&&movecontact
trigger14=stateno=245 && ((var(9)=1&&var(10)=1)||var(9)=0)&&((var(9)=1&&movecontact)||(var(9)=0&&animelemtime(3)>0))
trigger15= (stateno=1025&&movetype=A) && ((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger16= (stateno=1030&&movetype=A) && ((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger17= (stateno=1031) && ((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger18= (StateNo = [1050,1051]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger19=stateno=220 && var(10)=1&&movecontact
trigger20=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger21= (StateNo = [1031,1037]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
;---------------------------------------------------------------------------
;Weak Shouryuu Ken
[State -1, Weak Shouryuu Ken]
type = ChangeState
value = 1025
triggerall = command = "shoryux";&& command!="holdfwd"
triggerall = statetype != A
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1050 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger14=stateno=220 && var(10)=1&&movecontact
trigger15=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;---------------------------------------------------------------------------
;Strong Shouryuu Ken
[State -1, Strong Shouryuu Ken]
type = ChangeState
value = 1030
triggerall = command = "shoryuy"  ;&& command!="holdfwd"
triggerall = statetype != A
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1050 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger14=stateno=220 && var(10)=1&&movecontact
trigger15=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;---------------------------------------------------------------------------
;weak Joudan Sokutou Geri
[State -1, strong demon flip]
type = ChangeState
value = 1051
triggerall = (command = "joudanb" )
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16= StateNo = 1035 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger17= StateNo = 1040 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger18= StateNo = 1041 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger19= (StateNo = [1031,1037]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger20=stateno=220 && var(10)=1&&movecontact
trigger21=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;---------------------------------------------------------------------------
;weak Joudan Sokutou Geri
[State -1, weak demon flip]
type = ChangeState
value = 1050
triggerall = (command = "joudana" )
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16= StateNo = 1035 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger17= StateNo = 1040 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger18= StateNo = 1041 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger19= (StateNo = [1031,1037]) &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger20=stateno=220 && var(10)=1&&movecontact
trigger21=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
[State -1, change]
type = ChangeState
value = 1055
triggerall = command = "joudana" ||command ="joudanb"|| command = "joudanEX" 
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 =animelemtime(8)>0 &&animelemtime(10)<0  && (anim=1200||anim=1202)
trigger2 =animelemtime(9)>0 &&animelemtime(11)<0  && (anim=1201)
trigger3 =animelemtime(7)>0 &&animelemtime(9)<0  && (anim=[1210,1212])
;---------------------------------------------------------------------------
;Weak Tatsumaki Senpuu Kyaku
[State -1, Weak Tatsumaki Senpuu Kyaku]
type = ChangeState
value = 1035
triggerall = command = "tatsua"
triggerall = AILevel=0
triggerall = statetype!=A || movecontact
triggerall =  stateno!=41
triggerall = roundstate=2
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1)) && animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger18 = movecontact&&stateno=[600,645]
[State -1, change]
type = ChangeState
value = cond(var(1)=4,1039,cond(var(1)=3,1038,cond(var(1)=0||var(1)=2,1036,1037)))
triggerall = command = "tatsua" ||command = "tatsub"|| command = "tatsuEX" || var(11)=1
triggerall = AILevel=0
triggerall = roundstate=2
trigger1 =animelemtime(5)>1 &&animelemtime(7)<1 && (anim=1100 || anim=1102)
trigger2 =animelemtime(3)>1 &&animelemtime(6)<1&&  (anim=1105||anim=1110)
trigger3 =animelemtime(6)>1 &&animelemtime(8)<1  && (anim=1101)
;---------------------------------------------------------------------------
;Strong Tatsumaki Senpuu Kyaku
[State -1, Strong Tatsumaki Senpuu Kyaku]
type = ChangeState
value = 1040
triggerall = command = "tatsub"
triggerall = AILevel=0
triggerall = roundstate=2
triggerall =  stateno!=41
triggerall = statetype!=A || movecontact
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
trigger18 = movecontact&&stateno=[600,645]
;---------------------------------------------------------------------------
;Weak Hadou Ken
[State -1, Weak Hadou Ken]
type = ChangeState
value = 1000
triggerall = command = "hadoux"
triggerall = AILevel=0
triggerall = roundstate=2
triggerall = statetype!=A
triggerall = numhelper(1001)=0
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;---------------------------------------------------------------------------
;Strong Hadou Ken
[State -1, Weak Hadou Ken]
type = ChangeState
value = 1005
triggerall = command = "hadouy" 
triggerall = AILevel=0
triggerall = statetype!=A
triggerall = roundstate=2
triggerall = numhelper(1001)=0
trigger1 = ctrl ||(stateno=101) 
trigger2 = (StateNo = [200,205]) &&animelemtime(2)>0
trigger3 = (StateNo = 210) &&(animelemtime(3)>0)
trigger4 = (StateNo = 215) &&(animelemtime(5)>0)
trigger5 = StateNo = 235&&animelemtime(2)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410)&& animelemtime(3)>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10=stateno=230 && var(10)=1&&movecontact
trigger11=stateno=240 && animelemtime(5)>0
trigger12=stateno=245 && animelemtime(4)>0
trigger13= StateNo = 1025 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger14= StateNo = 1030 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))&& animelemtime(8)<0
trigger15= StateNo = 1031 &&((movehit&&var(10)=0) || (movecontact&&var(10)=1)) && ((var(57)>=500 && var(10)=0)||(var(57)>0 && var(10)=1))
trigger16=stateno=220 && var(10)=1&&movecontact
trigger17=stateno=300 && ((movetype=A && animelemtime(ifelse(var(9)=0,3,5))>0)||movecontact)
;===========================================================================
;---------------------------------------------------------------------------
;?????
[State -1, T S]
type = ChangeState
value = 710
triggerall = command = "evade" && command = "holdback"
triggerall = AILevel=0
trigger1 = statetype = S
trigger1 = ctrl ||stateno=101
trigger2 = power >= 1000
trigger2 = stateno = [150,151]

;---------------------------------------------------------------------------
;?????
[State -1, T S]
type = ChangeState
value = 700
triggerall = command = "evade"
triggerall = AILevel=0
trigger1 = statetype = S
trigger1 = ctrl ||stateno=101
trigger2 = power >= 1000
trigger2 = stateno = [150,151]
trigger3 = stateno = 100

;---------------------------------------------------------------------------
;??
[State -1, UKEMI]
type = ChangeState
value = 52000
triggerall = command = "evade"
triggerall = AILevel=0
triggerall = alive = 1
trigger1 = stateno = 5050
trigger1 = pos y > -30
trigger1 = vel y > 0 && vel y < 9


;---------------------------------------------------------------------------
;Run Fwd
[State -1, Run Fwd]
type = ChangeState
value = 100
triggerall = AILevel=0
trigger1 = command = "FF"
trigger1 = statetype = S
trigger1 = ctrl

;---------------------------------------------------------------------------
;Run Back
[State -1, Run Back]
type = ChangeState
value = 105
triggerall = AILevel=0
trigger1 = command = "BB"
trigger1 = statetype = S
trigger1 = ctrl
;---------------------------------------------------------------------------
;Punch Throw
[State -1, Punch Throw]
type = ChangeState
value = 805
triggerall = command = "b" 
triggerall = statetype = S
triggerall = ctrl
triggerall = AILevel=0
triggerall = stateno != 100
trigger1 = command = "holdfwd" || command="holdback"
trigger1 = p2bodydist X < 25
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H || p2stateno=120
;---------------------------------------------------------------------------
;Punch Throw
[State -1, Punch Throw]
type = ChangeState
value = 800
triggerall =  command = "y"
triggerall = statetype = S
triggerall = ctrl
triggerall = AILevel=0
triggerall = stateno != 100
trigger1 = command = "holdfwd" || command="holdback"
trigger1 = p2bodydist X < 25
trigger1 = (p2statetype = S) || (p2statetype = C)
trigger1 = p2movetype != H || p2stateno=120

;---------------------------------------------------------------------------
;Kick Throw
;[State -1, Kick Throw]
;type = ChangeState
;value = 805
;triggerall = command = "b"
;triggerall = statetype = S
;triggerall = ctrl
;triggerall = stateno != 100
;trigger1 = command = "holdfwd"
;trigger1 = p2bodydist X < 25
;trigger1 = (p2statetype = S) || (p2statetype = C)
;trigger1 = p2movetype != H

;------------------------------------------------------------------------------
;?????
[State -1, MAXACTIVATE]
type = ChangeState
value = ifelse(statetype=A,901,900)
triggerall = command = "MAX"
triggerall = var(57)>=1000
triggerall = AILevel=0
trigger1 = ctrl ||stateno=101
trigger2 = StateNo = 205 && animelemtime(2)>0
trigger3 = StateNo = 215 &&(animelemtime(3)>0)
trigger4 = StateNo = 235&&animelemtime(2)>0
trigger5 = StateNo = 245 &&animelemtime(7)>0
trigger6 =StateNo = 400&& animelemtime(2)>0
trigger7 = (StateNo = 410+var(9))&& animelemtime(ifelse(var(9)=1,3,5))>0
trigger8 = StateNo = 430&& animelemtime(2)>0
trigger9 = stateno=440 && animelemtime(5)>0
trigger10 = stateno = 300 && movecontact
trigger11 = stateno = 310 && movecontact
trigger12=StateNo = 200 && animelemtime(2)>0
trigger13=StateNo = 210 && animelemtime(3)>0
trigger14=StateNo = 230 && animelemtime(2)>0
trigger15=StateNo = 240 && animelemtime(3)>0
trigger16= StateNo = 220 && animelemtime(6)>0
trigger17= StateNo = 450 && animelemtime(3)>0


;===========================================================================
;?????
[State -1, Throw]
type = ChangeState
value = 300
triggerall = command = "CD" || command="z"
triggerall = statetype = S
triggerall = stateno != 100
triggerall = AILevel=0
trigger1 = ctrl ||stateno=101
trigger2 = power >= 1000
trigger2 = stateno = [150,151]
[State -1, Throw]
type = ChangeState
value = 650
triggerall = command = "CD"|| command="z"
triggerall = statetype = A
triggerall = stateno != 100
triggerall = AILevel=0
trigger1 = ctrl ||stateno=101
trigger2 = power >= 1000
trigger2 = stateno = [150,151]


;---------------------------------------------------------------------------
;?????????
[State -1, Stand Light Punch]
type = ChangeState
value = ifelse(p2bodydist x<15,205,200)
triggerall = command = "x"
triggerall = AILevel=0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl ||stateno=[100,101]
trigger2=animelemtime(2)>0&& stateno=[200,205]
trigger3=animelemtime(2)>0&&stateno=400
;?????????
[State -1, Stand Strong Punch]
type = ChangeState
value = ifelse(p2bodydist x<20,215,210)
triggerall = command = "y"
triggerall = AILevel=0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl ||stateno=101
trigger2=movecontact&& stateno=[200,205]
trigger3=movecontact&& stateno=400


;------------------------------------------------------------------------------
;?????????
[State -1, Stand Light Kick]
type = ChangeState
value = ifelse(p2bodydist x<20,235,230)
triggerall = command = "a"
triggerall = AILevel=0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl ||stateno=101
trigger2 = StateNo = 430&& animelemtime(2)>0 &&p2bodydist x<=20

;?????????


;?????????
[State -1, Standing Strong Kick]
type = ChangeState
value = ifelse(p2bodydist x<=25,245,240)
triggerall = command = "b"
triggerall = AILevel=0
triggerall = command != "holddown"
triggerall = statetype != A
trigger1 = ctrl ||stateno=101
trigger2=movecontact&& stateno=430
trigger3 = StateNo = 235&& movecontact



;------------------------------------------------------------------------------
;??
[State -1, Taunt]
type = ChangeState
value = 195
triggerall = command = "start"

triggerall = AILevel=0
trigger1 = statetype != A
trigger1 = ctrl ||stateno=101

;------------------------------------------------------------------------------
;????????
[State -1, Crouching Light Punch]
type = ChangeState
value = 400
triggerall = command = "x"
triggerall = command = "holddown"
triggerall = statetype != A
triggerall = AILevel=0
trigger1 = ctrl ||stateno=101
trigger2 = animelemtime(2)>0&& stateno=[200,205]
trigger3 = animelemtime(2)>0&&stateno=400 
;????????
[State -1, Crouching Strong Punch]
type = ChangeState
value = 410
triggerall = command = "y"
triggerall = AILevel=0
triggerall = command = "holddown"
trigger1 = statetype != A
trigger1 = ctrl ||stateno=101
trigger2 = movecontact&& stateno=[200,205]
trigger3 = movecontact&&stateno=400 


;------------------------------------------------------------------------------
;????????
[State -1, Crouching Light Kick]
type = ChangeState
value = 430
triggerall = command = "a"
triggerall = command = "holddown"
triggerall = AILevel=0
triggerall = statetype != A
trigger1 = ctrl ||stateno=101
trigger2 = StateNo = 430&& animelemtime(2)>0
;????????
[State -1, Crouching Strong Kick]
type = ChangeState
value = 440
triggerall = command = "b"
triggerall = command = "holddown"
triggerall = AILevel=0
triggerall = statetype != A
trigger1 = ctrl ||stateno=101
trigger2 = StateNo = 430&& movecontact
trigger3 = StateNo = 235&& movecontact

;------------------------------------------------------------------------------
;????????
[State -1, Jump Light Punch]
type = ChangeState
value = 600
triggerall = command = "x"
triggerall = AILevel=0
triggerall = stateno != 105
trigger1 = statetype = A
trigger1 = ctrl

;??????????
[State -1, Jump Strong Punch]
type = ChangeState
value =610
triggerall = AILevel=0
triggerall = command = "y"
triggerall = stateno != 105
trigger1 = statetype = A
trigger1 = ctrl 
;------------------------------------------------------------------------------
;divekick
[State -1, Divekick]
type = ChangeState
value = 660
triggerall = command = "b" && command="holddown" && command!="holdback" && command!="holdfwd"
triggerall = AILevel=0
triggerall = vel x !=0
trigger1 = statetype = A
trigger1 = ctrl
trigger2 = stateno=600 && movecontact
trigger3 = stateno=610 && movecontact
trigger4 = stateno=630 && movecontact
trigger5 = stateno=640 && movecontact

;------------------------------------------------------------------------------
;????????
[State -1, Jump Light Kick]
type = ChangeState
value = 630
triggerall = command = "a"
triggerall = AILevel=0
triggerall = stateno != 105
trigger1 = statetype = A
trigger1 = ctrl

;??????????
[State -1, Jump Strong Kick]
type = ChangeState
value = 640
triggerall = AILevel=0
triggerall = command = "b"
triggerall = stateno != 105
trigger1 = statetype = A
trigger1 = ctrl 
