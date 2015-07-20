program Spisok2;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TPElem = ^TRElem;
  TRElem = record
    value: integer;
    next: TPElem;
    num: integer;
  end;

  procedure InsertFirst (val:integer; var SP:TPElem);
  var
  NewElem:TPElem;
  begin
    new(NewElem);
    NewElem^.value:=val;
    NewElem^.next:=SP;
    NewElem^.num:=1;
    SP:=NewElem;
  end;

  procedure InsertAfter (val,n:integer; var elem:TPElem);
  var
  NewElem:TPElem;
  begin
  new(NewElem);
  NewElem^.value:=val;
  NewElem^.next:=elem^.next;
  NewElem^.num:=n;
  elem^.next:=NewElem;
  end;



  var
 List,ukaz,ukaz2:TPElem;
 f1,f2:text;
 vdoh,vydoh:string;
 x,n,k,poisk:integer;

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


 readln(f1,k);

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
 n:=n+1;
 insertafter (x,n,ukaz);
 ukaz:=ukaz^.next;
 end;

 end;

 ukaz:=List;
{Дан односвязный список. Найти K-ый элемент с конца.}

while (ukaz^.next<>NIL) do
begin
if (ukaz^.num=n-k+1) then
poisk:=ukaz^.value;
ukaz:=ukaz^.next;
end;


 writeln (f2,poisk);

 closefile (f1);
 closefile (f2);
end.
