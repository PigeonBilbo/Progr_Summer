program Spisok3;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

type
  TPElem = ^TRElem;
  TRElem = record
    value: integer;
    next: TPElem;
    prov: integer;
  end;

  procedure InsertFirst (val:integer; var SP:TPElem);
  var
  NewElem:TPElem;
  begin
    new(NewElem);
    NewElem^.value:=val;
    NewElem^.next:=SP;
    NewElem^.prov:=0;
    SP:=NewElem;
  end;

  procedure InsertAfter (val:integer; var elem:TPElem);
  var
  NewElem:TPElem;
  begin
  new(NewElem);
  NewElem^.value:=val;
  NewElem^.next:=elem^.next;
  NewElem^.prov:=0;
  elem^.next:=NewElem;
  end;



  var
 List,ukaz,ukaz2:TPElem;
 f1,f2:text;
 vdoh,vydoh:string;
 x,n,k,i:integer;
 t:boolean;

 begin

 vdoh:=paramstr(1);
 vydoh:=paramstr(2);
 assignfile(f1,vdoh);
 reset(f1);
 assignfile (f2,vydoh);
 rewrite(f2);

 t:=true;
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
 ukaz^.next:=list;

 end;

 ukaz:=List;
{Дан односвязный список. Определить существует ли петля в нем.}

while (ukaz^.next<>NIL) and (ukaz^.prov<=1) do
begin
ukaz^.next^.prov:=ukaz^.next^.prov+1;
if ukaz^.next^.prov>1 then
t:=false;
ukaz:=ukaz^.next;
end;

 if t=true then
 writeln (f2,'NO')
 else
 writeln (f2,'YES');

 closefile (f1);
 closefile (f2);
end.
