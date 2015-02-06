(**************************************************************************
* *
* Módulo:Mis programas Nombre: 3enraya
* Fichero: () Programa (X) Espec. TAD () Impl. TAD () Otros *
* Autor(es): Abel Serrano Juste
* Fecha: 23/Aug/2011
* *
* Descripción: *
* Juego del tres en raya.
* 
* License: GPL-v2.0
* *
**************************************************************************)

PROGRAM tresenraya;
USES
CRT;
LABEL
Principio,OtraPartida,FIN;
CONST
mgizq=30;
mgalt=6;
MgizqRes=Mgizq+28;
MgaltRes=Mgalt-1;
numfilas=3;
numcolum=3;
TYPE
TipoTablaResultados=ARRAY [1..3] OF integer;
filas= 1..numfilas;
columnas= 1..numcolum;
TipoTabla= ARRAY [filas,columnas] OF char;
VAR
TablaResultados:TipoTablaResultados;
tabla:TipoTabla;
posi,posj,cont,contparti:byte;
ganado,TABLAS,TurnoCruz:boolean;
resp:char;
PROCEDURE IniciarTablaResultados(VAR TablaResultados:TipoTablaResultados);
VAR i:integer;
BEGIN
FOR i:=1 TO 3 DO TablaResultados[i]:=0
END;

PROCEDURE DibujarResultados(TablaResultados:TipoTablaResultados);
VAR
x,y,n,m,c:byte;
BEGIN
{Encabezado}
x:=mgizqRes;
y:=mgaltRes;
GOTOXY(X,Y);
write('     |     |');
y:=y+1;
GOTOXY(X,Y);
write('     |     |');
{Titulos encabezado}
 {X}
 x:=mgizqRes+2;
 GOTOXY(x,y);
 Textcolor(green);
 write('X');
 {O}
 x:=mgizqRes+8;
 GOTOXY(x,y);
 Textcolor(blue);
 write('O');
 {TABLAS}
 x:=mgizqRes+14;
 GOTOXY(x,y);
 Textcolor(yellow);
 write('TABLAS');
{Borde encabezado}
NormVideo;
x:=MgizqRes+1;
y:=y+1;
GOTOXY(X,Y);
FOR c:=1 TO 20 DO
write('-');
{Bordes internos}
y:=y+1;
FOR n:=1 TO 3 DO BEGIN
x:=mgizqRes+5;
 FOR m:=1 TO 2 DO BEGIN
  GOTOXY(x,y);
  write('|');
  x:=x+6;
 end;
y:=y+1;
end;
{Resultados}
y:=y-2;
 {X}
 x:=mgizqRes+2;
 GOTOXY(x,y);
 write(TablaResultados[1]);
 {O}
 x:=mgizqRes+8;
 GOTOXY(x,y);
 write(TablaResultados[2]);
 {TABLAS}
 x:=mgizqRes+16;
 GOTOXY(x,y);
 write(TablaResultados[3]);
END;

PROCEDURE VictoriaX(VAR TablaResultados:TipoTablaResultados);
VAR
x,y:byte;
BEGIN
TablaResultados[1]:=succ(TablaResultados[1]);
x:=MgizqRes+2;
y:=MgaltRes+4;
GOTOXY(x,y);
write(TablaResultados[1]);
END;

PROCEDURE VictoriaO(VAR TablaResultados:TipoTablaResultados);
VAR
X,Y:BYTE;
BEGIN
TablaResultados[2]:=succ(TablaResultados[2]);
 x:=mgizqRes+8;
 y:=mgaltres+4;
 GOTOXY(x,y);
 write(TablaResultados[2]);
END;

PROCEDURE VictoriaNadie(VAR TablaResultados:TipoTablaResultados);
VAR
X,Y:BYTE;
BEGIN
TablaResultados[3]:=succ(TablaResultados[3]);
 x:=mgizqRes+16;
 y:=mgaltres+4;
 GOTOXY(x,y);
 write(TablaResultados[3]);
END;

PROCEDURE DibujarTabla;
VAR
i,j,n,m:byte;
BEGIN
{lineas verticales}
i:=mgizq;
j:=mgalt;
FOR n:=1 TO 2 DO BEGIN
i:=i+1;
GOTOXY(i,j);
write('|');
i:=i+1;
end;
for m:=1 TO 2 DO BEGIN
{lineas horizontalesX2}
i:=mgizq-1;
j:=j+1;
GOTOXY(i,j);
FOR n:=1 TO 7 DO
write('-');
{lineas verticalesX2}
i:=mgizq;
j:=j+1;
FOR n:=1 TO 2 DO BEGIN
i:=i+1;
GOTOXY(i,j);
write('|');
i:=i+1;
end;

END;
END;

PROCEDURE IniciarTabla(VAR tabla:TipoTabla);
VAR
i,j:integer;
BEGIN
FOR i:=1 TO numfilas DO
FOR j:=1 TO numcolum DO
tabla[i,j]:='_';
END;

PROCEDURE Movimiento(var i:byte; var j:byte);
VAR
x,y:byte;
mov:char;
BEGIN
x:=mgizq+(i-1)*2;
y:=mgalt+(j-1)*2;
GOTOXY(X,Y);
REPEAT
mov:=readkey;
    IF mov=#0 THEN begin
            mov:=ReadKey; {Read ScanCode}
            case mov of
             #75{left} : BEGIN x:=x-2;i:=i-1;end;
             #77{right} : BEGIN x:=x+2;i:=i+1;end;
             #72{UP} : BEGIN y:=y-2;j:=j-1;end;
             #80{DOWN} : begin y:=y+2;j:=j+1;END;
            end;
          end;
 (*Caso especial por si el usuario se sale de los límites de la tabla*)
 (*Se pasará al otro extremo de la tabla*)
   IF i=0 THEN BEGIN
    i:=3;x:=mgizq+(i-1)*2;END
   ELSE IF j=0 THEN BEGIN
    J:=3;y:=mgalt+(j-1)*2;END
   ELSE IF i=4 THEN BEGIN
    i:=1;x:=mgizq+(i-1)*2;END
   ELSE IF j=4 THEN BEGIN
    J:=1;y:=mgalt+(j-1)*2;END;
  (*Hasta aquí*)
GOTOXY(x,y);
UNTIL mov=#13;
END;

PROCEDURE GanaO(VAR ganado:boolean;Tabla:TipoTabla);
FUNCTION EsO(hueco:char):boolean;
BEGIN
EsO:=(hueco='O');
END;
BEGIN
 IF EsO(tabla[2,2]) THEN BEGIN
 {1ª DIAGONAL}
  IF EsO(tabla[1,1]) THEN
   IF EsO(tabla[3,3]) THEN
    ganado:=TRUE;
 {2ª DIAGONAL}
  IF not(ganado) AND EsO(tabla[1,3]) THEN
   IF EsO(tabla[3,1]) THEN
    ganado:=TRUE;
 {1ª CRUZ}
  IF not(ganado) AND EsO(tabla[1,2]) THEN
   IF EsO(tabla[3,2]) THEN
    ganado:=TRUE;
 {2ª CRUZ}
  IF not(ganado) AND EsO(tabla[2,1]) THEN
   IF EsO(tabla[2,3]) THEN
    ganado:=TRUE;
  END;
{1ºS BORDES}
 IF EsO(tabla[1,1]) AND not (ganado) THEN BEGIN
   IF EsO(tabla[1,2]) THEN
    IF EsO(tabla[1,3]) THEN
    ganado:=TRUE;
   IF EsO(tabla[2,1]) AND not(ganado) THEN
    IF EsO(tabla[3,1]) THEN
    ganado:=TRUE;
 END;
{2ºS BORDES}
  IF EsO(tabla[3,3]) AND not (ganado) THEN BEGIN
   IF EsO(tabla[3,1]) THEN
    IF EsO(tabla[3,2]) THEN
    ganado:=TRUE;
   IF EsO(tabla[1,3]) AND not(ganado) THEN
    IF EsO(tabla[2,3]) THEN
    ganado:=TRUE;
 END;
 END;

PROCEDURE GanaX(VAR ganado:boolean;Tabla:TipoTabla);
FUNCTION EsX(hueco:char):boolean;
BEGIN
EsX:=(hueco='X');
END;
BEGIN
 IF EsX(tabla[2,2]) THEN BEGIN
 {1ª DIAGONAL}
  IF EsX(tabla[1,1]) THEN
   IF EsX(tabla[3,3]) THEN
    ganado:=TRUE;
 {2ª DIAGONAL}
  IF not(ganado) AND EsX(tabla[1,3]) THEN
   IF EsX(tabla[3,1]) THEN
    ganado:=TRUE;
 {1ª CRUZ}
  IF not(ganado) AND EsX(tabla[1,2]) THEN
   IF EsX(tabla[3,2]) THEN
    ganado:=TRUE;
 {2ª CRUZ}
  IF not(ganado) AND EsX(tabla[2,1]) THEN
   IF EsX(tabla[2,3]) THEN
    ganado:=TRUE;
   END;
{1ºS BORDES}
 IF EsX(tabla[1,1]) AND not (ganado) THEN BEGIN
   IF EsX(tabla[1,2]) THEN
    IF EsX(tabla[1,3]) THEN
    ganado:=TRUE;
   IF EsX(tabla[2,1]) AND not(ganado) THEN
    IF EsX(tabla[3,1]) THEN
    ganado:=TRUE;
 END;
{2ºS BORDES}
  IF EsX(tabla[3,3]) AND not (ganado) THEN BEGIN
   IF EsX(tabla[3,1]) THEN
    IF EsX(tabla[3,2]) THEN
    ganado:=TRUE;
   IF EsX(tabla[1,3]) AND not(ganado) THEN
    IF EsX(tabla[2,3]) THEN
    ganado:=TRUE;
 END;
 END;

PROCEDURE ParpadeoOtraPartida;
BEGIN
GOTOXY(25,23);
delLine;
GOTOXY(25,22);
Textcolor(yellow);
write('¨Quereis volver a jugar? (s/n)');
delay(100);
GOTOXY(25,22);
Textcolor(lightred);
write('¨Quereis volver a jugar? (s/n)');
Delay(100);
GOTOXY(25,22);
Textcolor(yellow);
write('¨Quereis volver a jugar? (s/n)');
delay(100);
END;

(*
--Parpadeo con textattr+128, muy cutre--
PROCEDURE ParpadeoOtraPartida;
BEGIN
TextAttr:=(lightred+128);
GOTOXY(25,22);
write('¨Quereis volver a jugar? (s/n)');
END;
*)
BEGIN
{$GOTO ON}
IniciarTablaResultados(TablaResultados);
contparti:=1;
Principio:
Normvideo;
writeln('*************** TRES EN RAYA ********************BY AKRONIX');
GOTOXY(mgizq-10,3);
write('Esta es la Ronda numero ');
Highvideo;
writeln(contparti);
Normvideo;
DibujarResultados(TablaResultados);
DibujarTabla;
IniciarTabla(tabla);
Turnocruz:=odd(contparti);
ganado:=false;tablas:=False;
cont:=0;
posi:=1; posj:=1;
REPEAT
IF not TurnoCruz THEN BEGIN
 TextColor(blue);
 gotoXY(6,15);
 writeln('Es el turno de las O');
 Movimiento(posi,posj);
 IF (Tabla[posi,posj]='_') then BEGIN
  WRITE('O');
  Tabla[posi,posj]:='O';
  GanaO(ganado,Tabla);
  cont:=cont+1;
  Turnocruz:=not(TurnoCruz);
   IF ganado THEN BEGIN
    GOTOXY(30,20);
    HighVideo;
    write('­Los O han ganado!');
    Sound(25);
    VictoriaO(TablaResultados);
    END;
  END
 else begin
  TextColor(red);
  GOTOXY(8,20);
  write('­Error: Esa casilla ya est  ocupada!');
  Sound(1);
  readKEY;
  GOTOXY(8,20);
  delLine;
 end

END
ELSE BEGIN
 TextColor(green);
 gotoXY(6,15);
 write('Es el turno de las X');
 Movimiento(posi,posj);
 IF (Tabla[posi,posj]='_') then BEGIN
  WRITE('X');
  Tabla[posi,posj]:='X';
  GanaX(ganado,Tabla);
  cont:=cont+1;
  TurnoCruz:=not(TurnoCruz);
    IF ganado THEN BEGIN
    GOTOXY(30,20);
    HighVideo;
    write('­Las X han ganado!');
    sound(1000);
    VictoriaX(TablaResultados);
    END;
  END
 else begin
  TextColor(red);
  GOTOXY(8,20);
  write('­Error: Esa casilla ya est  ocupada!');
  Sound(800);
   readKEY;
   GOTOXY(8,20);
   delLine;
 end
END;
tablas:=(cont=numcolum*numfilas);
UNTIL ganado or tablas;
IF tablas and not ganado THEN BEGIN
TextColor(YELLOW);
GOTOXY(30,20);
write('La partida ha terminado en empate');
VictoriaNadie(TablaResultados);
END;
contparti:=contparti+1;

OtraPartida:
GOTOXY(25,22);
Textcolor(lightred);
write('¨Quereis volver a jugar? (s/n)');
GOTOXY(25,23);
readln(resp);
IF Upcase(resp)='S' THEN BEGIN
clrscr;
GOTO Principio;
END
ELSE IF (Upcase(resp)='N') THEN
GOTO FIN
ELSE BEGIN
ParpadeoOtraPartida();
GOTO OtraPartida;
END;
FIN:
GOTOXY(20,25);
Textcolor(Magenta);
writeln('Espero que hayais disfrutado con mi juego.');
READLN;
end.
