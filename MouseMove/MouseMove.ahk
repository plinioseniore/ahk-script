#Persistent
SetTimer, MoveMouse

MoveMouse:
If ( A_TimeIdle > 10000 ) {
  MouseMove, 10 , 10,, R
  MouseMove, -10,-10,, R
}
Return