program lab6_3;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

label metka, next;

var
  i, k: Integer;
  n, count: Integer;
  A, B: array of Integer;

begin
  randomize;
  Write('������� ����������� �������: ');
  Read(n);
  SetLength(A, n);

  Writeln('������� ', n, ' ��������� �������');
  for i := 0 to n - 1 do
  begin
    A[i] := random(10)-5;
    Writeln(i + 1, ' �������: ', A[i]);
    //Readln(A[i]);
  end;
  count:=0;

  Write('������� �����: ');
  Read(k);

  for i := 0 to n - 1 do
  begin
    if A[i] < k then
    begin
      Writeln(A[i]);
      inc(count);
    end;
  end;
  SetLength(B, count);

  asm
    mov esi,[A]
    mov edi,[B]
    mov ecx, n
    mov edx, k
    mov eax, 0
    mov ebx, 0

    metka:
    cmp [esi+ebx], edx
    jnl next            // ���� ��� �� ������, �� ����� �� �����
    mov edx, [esi+ebx]
    mov [edi+eax], edx
    mov edx, k
    add eax, 1*4

    next:
    add ebx, 1*4
    loopnz metka

  end;

  Writeln('����� ������������ �������: ');
  for i := 0 to High(B) do
    Writeln(B[i]);

  readln;
  readln;

end.
