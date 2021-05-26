// ����� ����� ������������� ���������
program lab6_2;

uses
  System.SysUtils;

Label next, metka;

var
  A: array [1 .. 10] of integer;
  i, Sum1, Sum2,count: integer;

begin
  randomize;
  Writeln('������� 10 ��������� �������:');
  for i := 1 to 10 do
  begin
    // Write(i,' �������: ');
    // Readln(A[i]);
    A[i] := random(10) - 5;
    Writeln(A[i]);
  end;

  i := 1;
  count:=0;
  while i <= 10 do
  begin
    if A[i] < 0 then
      inc(count);
    inc(i);
  end;

  Writeln('���������� ������������� ��������� ����� Delphi: ', count);

  asm
    //����� �������
    lea esi,A
    mov eax, 0
    mov ebx, 0
    mov ecx, 10
    mov dl,0
    metka:
    cmp dl, [esi+ebx] // ���������� ��� �����
    jle next // ����  dl <= [esi+ebx]
    inc eax
    next:
    add ebx, 1*4 // ������� ����� �� 4 ����� ��� ��� ��������
    loopnz metka // ���� ��� ���
    mov count, eax
  end;

  Writeln('���������� ������������� ��������� ����� ������������ �������:', count);
  Readln;

end.