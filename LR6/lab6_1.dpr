program lab6_1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  a, b, c, d,y2 :longint;
  y1 : Real;

begin
 Writeln('����� Delphi');

   Write('������� �:');
   Readln(a);
   Write('������� b:');
   Readln(b);
   Write('������� c:');
   Readln(c);
   Write('������� d:');
   Readln(d);

{
   a:=3;
   b:=2;
   d:=3;
   c:=1;
}
 y1 := ((b+4)*a+d)/(c*3);
 Writeln('Y = ', y1:0:0);


 Writeln('����� ������������ �������');
 asm
   mov eax, b
   add eax, 4
   imul a
   add eax, d
   mov ebx, c
   imul ebx, 3
   idiv ebx
   mov y2, eax
 end;
 Writeln('Y = ',y2);

 Readln;
 Readln;
end.
