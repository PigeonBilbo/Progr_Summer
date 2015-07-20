program Spisok1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TPElem = ^TRElem;
  TRElem = record
    value: integer;
    next: TPElem;
  end;
  zn = array of integer;
  log = array of boolean;

  procedure InsertFirst (val:integer; var SP:TPElem);
  var
  NewElem:TPElem;
  begin
    new(NewElem);
    NewElem^.value:=val;
    NewElem^.next:=SP;
    SP:=NewElem;
  end;

  procedure DeleteFirst (var SP:TPElem);
  var
  tmp:TPElem;
  begin
    tmp:=SP;
    SP:=SP^.next;
    dispose (tmp);
  end;

  procedure InsertAfter (val:integer; var elem:TPElem);
  var
  NewElem:TPElem;
  begin
  new(NewElem);
  NewElem^.value:=val;
  NewElem^.next:=elem^.next;
  elem^.next:=NewElem;
  end;

  procedure DeleteAfter (var elem:TPElem);
  var
  tmp:TPElem;
  begin
    tmp:=elem^.next;
    elem^.next:=tmp^.next;
    dispose (tmp);
  end;

  procedure PrintList (SP:TPElem; var f:text);
  var
  elem:TPElem;
  begin
    elem:=SP;
    while elem^.next<>NIL do
    begin
    write (f,elem^.value,' ');
    elem:=elem^.next;
    end;
  end;

   procedure QuickSort(var a: zn);
    procedure sort(L, R: integer);
    var
      i, j: integer;
      w, x: integer;
    begin
      i := L;
      j := R;
      x := a[(L + R) div 2];
      repeat
        while a[i] < x do
          i := i + 1;
        while x < a[j] do
          j := j - 1;
        if i <= j then
        begin
          w := a[i];
          a[i] := a[j];
          a[j] := w;
          i := i + 1;
          j := j - 1;
        end;
      until i > j;
      if L < j then
        sort(L, j);
      if i < R then
        sort(i, R);
    end  ;
    var n:integer;
 begin
 n:=length(a)-1;
   sort(0,n);
 end;


  var
 List,ukaz,ukaz2:TPElem;
 f1,f2:text;
 vdoh,vydoh:string;
 x,n,k,i:integer;
 bool:log;
 znach,povt:zn;

 begin

 vdoh:=paramstr(1);
 vydoh:=paramstr(2);
 assignfile(f1,vdoh);
 reset(f1);
 assignfile (f2,vydoh);
 rewrite(f2);

 new (list);
 List^.value:=0;
 List^.next:=NIL;

 while not(eof(f1)) do begin
 read(f1,x);
 if List^.next=NIL then
 begin
 insertfirst(x,list);
 ukaz:=list;
 n:=1;
 end
 else
 begin
 insertafter (x,ukaz);
 ukaz:=ukaz^.next;
 n:=n+1;
 end;

 end;

 setlength (bool,n+1);
 setlength (znach,n+1);
 setlength (povt,1);

 ukaz:=List;
 k:=1;
{Дан односвязный список. Удалить из него повторяющиеся элементы.}

while ukaz^.next<>NIL do
begin
znach[k]:=ukaz^.value;
ukaz:=ukaz^.next;
k:=k+1;
end;

QuickSort(znach);
i:=1;

for k := 1 to n-1 do
if znach[k]=znach[k+1] then
begin
setlength(povt,i+1);
povt[i]:=znach[k];
i:=i+1;
end;



for k := 1 to i-1 do
begin

if List^.value=povt[k] then
    deletefirst(List);
    ukaz:=list;

while ukaz^.next<>NIL do
  begin
    if ukaz^.next^.value=povt[k] then
    deleteafter(ukaz);
    ukaz:=ukaz^.next;
  end;

ukaz:=List;
end;

PrintList(List,f2);
 closefile (f1);
 closefile (f2);
end.
