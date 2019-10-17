{sinh bo do r-contiguous toi uu}
{them ca bai 2011}
uses sysutils;
const fi='DataFor1stExperiment.inp';
fo='Result.out';

type node=^anode;
anode=record
l,r:node;
flag:byte;
end;
nodep=record
    e:node;
    st:longint;{co the thay bang longint}
    end;
var q:array[0..1060000,0..1]of node;
        p1,p:array[1..1060000]of nodep;
        s:array[1..106000,1..101]of byte;
		s_num:array[1..106000]of longint;
		f:text;
		lmax:integer;
		n,dem,dem1:longint;
	l,r,i,j,r2,k:longint;
	st:string;
        ss:string;
	tree,pt:node;
	start,stop: ttimestamp;
	Tr,Tl,mangtree:array[1..91] of node;
        non:array[0..1049000]of string;
		ii:byte;
procedure docdl;
begin
	assign(f,fi);
	reset(f);
	readln(f,n,l,r);
	for i:=1 to n do
	begin
		readln(f,st);
		for j:=1 to length(st)do
		if st[j]='1' then
		s[i,j]:=1
		else s[i,j]:=0;
	end;
        r2:=1;
	for i:=1 to r-2 do r2:=r2*2;
	for i:=0 to 4*r2 do
	begin q[i,0]:=nil;q[i,1]:=nil;end;

        close(f);
		lmax:=0;
end;
procedure init1;{sinh cay dau tien}
var t:longint;tem:node;
begin
	tree:=new(node);tree^.l:=nil;tree^.r:=nil;
	dem1:=0;
	for i:=0 to dem do
	if non[i]<>'' then
	begin
		t:=0;
		if  non[i][1]='1' then
			if tree^.r = nil then
				Begin
				tree^.r:=new(node);
				tem:=tree^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tree^.r
		else
			if tree^.l = nil then
				Begin
				tree^.l:=new(node);
				tem:=tree^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tree^.l;
		for j:=2 to r do
		begin
			t:=t*2;
			if non[i][j]='1' then
			Begin t:=t+1;
			if tem^.r = nil then
				Begin
				tem^.r:=new(node);
				tem:=tem^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.r
			end
			else
			if tem^.l = nil then
				Begin
				tem^.l:=new(node);
				tem:=tem^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.l;
		end;
		dem1:=dem1+1;
		p[dem1].st:=t;
		p[dem1].e:=tem;
	end;
	dem:=dem1;

end;
procedure try(i:integer);
var j:char;
begin
 for j:='0' to '1' do
 begin
    ss[i]:=j;
    if i = r then
	begin dem:=dem+1;non[dem]:=ss ; end
      else try(i+1);
 end;
end;
procedure FirstNonselfGen;
var i:longint;
Begin
    dem:=-1;
     ss:='';
     for i:=1 to r do ss:=ss+' ';
     try(1);
End;
Procedure xoaself;
var j,i,r2,r3:longint;
Begin
FirstNonselfGen;
for i:=1 to n do
	Begin
		r2:=s[i,1];r3:=0;
		for j:=2 to r do
		Begin r2:=r2 shl 1 + s[i,j];
		r3:=r3 shl 1 + s[i,j];
		end;
		non[r2]:='';
		s_num[i]:=r3;
	end;
end;
procedure duyet(t:node;s:string);
begin
	if (t^.l = nil) and (t^.r = nil) then Begin writeln(s);  end

	else
	begin
		if (t^.l <> nil) then
		begin
			s:=s+'0';
			duyet(t^.l,s);
            delete(s,length(s),1);
		end;
		if (t^.r <> nil) then
		begin
			s:=s+'1';
			duyet(t^.r,s);
            delete(s,length(s),1);
		end;
	end;
end;

procedure addtree;
begin
	for i:=r+1 to l do
	Begin
        for j:=1 to n do
            if q[s_num[j],s[j,i]]=nil then
			begin pt:=new(node);pt^.l:=nil;pt^.r:=nil;pt^.flag:=1;
				q[s_num[j],s[j,i]]:=pt;
			end;
			{in ra thu}
		{for j:=1 to dem do
					writeln(j,':',p[j].st);
			for j:=1 to n do
			Begin
			write(j,': ',s_num[j],' : ');
            if q[s_num[j],0]<>nil then write('0 ');
			if q[s_num[j],1]<>nil then write('1 ');
			writeln
			end;}
			{write(i,' ',dem,' ');}

					{----------}
		dem1:=0;
		for j:=1 to dem do
		begin
			if(q[p[j].st,0]=nil) then
			begin
				pt:=new(node);pt^.l:=nil;pt^.r:=nil;pt^.flag:=2;
				q[p[j].st,0]:=pt;
				dem1:=dem1+1;
				p[j].e^.l:=pt;
				p1[dem1].e:=pt;
				p1[dem1].st:=p[j].st;

				if p1[dem1].st>=r2 then p1[dem1].st:=p1[dem1].st-r2;
				p1[dem1].st:=p1[dem1].st shl 1;

			end
			else
			if q[p[j].st,0]^.flag=2 then
			begin
				{dem1:=dem1+1;}
				p[j].e^.l:=q[p[j].st,0];
				{p1[dem1].e:=q[p[j].st,0];
				p1[dem1].st:=p[j].st;

				if p1[dem1].st>=r2 then p1[dem1].st:=p1[dem1].st-r2;
				p1[dem1].st:=(p1[dem1].st shl 1);}

			end;

			if(q[p[j].st,1]=nil) then
			begin
				pt:=new(node);pt^.l:=nil;pt^.r:=nil;pt^.flag:=2;
				q[p[j].st,1]:=pt;
				dem1:=dem1+1;
				p[j].e^.r:=pt;
				p1[dem1].e:=pt;
				p1[dem1].st:=p[j].st;
				if p1[dem1].st>=r2 then p1[dem1].st:=p1[dem1].st-r2;
				p1[dem1].st:=(p1[dem1].st shl 1) +1;

			end
			else
			if q[p[j].st,1]^.flag=2 then
			begin
				{dem1:=dem1+1;}
				p[j].e^.r:=q[p[j].st,1];
				{p1[dem1].e:=q[p[j].st,1];
				p1[dem1].st:=p[j].st;
				if p1[dem1].st>=r2 then p1[dem1].st:=p1[dem1].st-r2;
				p1[dem1].st:=(p1[dem1].st shl 1)+1;}


			end;

		end;

		for j:=1 to n do
			begin
				q[s_num[j],1]:=nil;
				q[s_num[j],0]:=nil;
				if s_num[j]>=r2 then s_num[j]:=s_num[j]-r2;
				s_num[j]:=(s_num[j] shl 1) +s[j,i];
			end;
		dem:=dem1;
		p:=p1;
		end;

end;

procedure psa;
begin
        start := datetimetotimestamp(now);
	xoaself;
	init1;

        addtree;
	stop:=datetimetotimestamp(now);
        write(f,stop.time-start.time,',');
	ss:='';
	{duyet(tree,ss);
	readln}
end;
procedure init(k:byte);
var t:longint;tem:node;
begin
	tree:=new(node);tree^.l:=nil;tree^.r:=nil;
	for i:=1 to n do
	begin
		t:=0;
		if s[i,k]=1 then
			if tree^.r = nil then
				Begin
				tree^.r:=new(node);
				tem:=tree^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tree^.r
		else
			if tree^.l = nil then
				Begin
				tree^.l:=new(node);
				tem:=tree^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tree^.l;
		for j:=k+1 to K+r-1 do
		begin
			t:=t*2+s[i,j];
			if s[i,j]=1 then
			if tem^.r = nil then
				Begin
				tem^.r:=new(node);
				tem:=tem^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.r
			else
			if tem^.l = nil then
				Begin
				tem^.l:=new(node);
				tem:=tem^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.l;
		end;
		p[i].st:=t;
		p[i].e:=tem;
	end;
end;
procedure taonode(var p:node);
Begin
	p:=new(node);
	p^.l:=nil;p^.r:=nil;
End;
function ktnodela(p:node):boolean;
Begin
  if (p^.l=nil)and(p^.r=nil) then ktnodela:=true
  else ktnodela:=false;
end;
procedure changePotoNe(var t:node;i:byte);
begin
	if (t<>nil)then
	begin
        changePotoNe(t^.l,i+1);
     	changePotoNe(t^.r,i+1);
        if (t^.l<>nil)and(t^.r<>nil)and ktnodela(t^.l)and ktnodela(t^.r)
     	then begin
	
			t^.l:=nil;
			t^.r:=nil;
     	end
		else
	     	if (t^.l<>nil)and ktnodela(t^.l) then
			begin
	     	        if (t^.r=nil) then begin t^.r:=new(node);t^.r^.l:=nil;t^.r^.r:=nil;end;
					t^.l:=nil;
			end
			else
			    if (t^.r<>nil)and (ktnodela(t^.r)) then
			    begin
					t^.l:=new(node);t^.l^.l:=nil;t^.l^.r:=nil;
					t^.r:=nil;
			    end
			    else
			 if(t^.r<>nil)and(t^.l=nil)and not ktnodela(t^.r)
					          then Begin t^.l:=new(node);t^.l^.l:=nil;t^.l^.r:=nil; end
					else
					    if(t^.r=nil)and(t^.l<>nil)and(not ktnodela(t^.l))
					       then  begin t^.r:=new(node);t^.r^.l:=nil;t^.r^.r:=nil; end;
	end;
end;



procedure tim_RtoL;{ket noi cac cay tu phai sang trai}
var tem:node;st:string;
d,k,jj:longint;
Function thuoc_cay(st:string;t:node):boolean;
var j:byte;tem:node;
Begin j:=1;tem:=t;
	while j<=length(st) do
	begin
	if (st[j]='1')and(tem^.r<>nil) then tem:=tem^.r
		  else
		  if (st[j]='0')and(tem^.l<>nil) then tem:=tem^.l
		  else break;
		  j:=j+1;
	end;
	thuoc_cay:=j>length(st)
End;
procedure duyet_phai(t:node;s:string);
begin
	if (t^.l = nil) and (t^.r = nil) then
	Begin d:=d+1;non[d]:=s; end
	else
	begin
		if (t^.l <> nil) then
		begin
			s:=s+'0';
			duyet_phai(t^.l,s);
            delete(s,length(s),1);
		end;
		if (t^.r <> nil) then
		begin
			s:=s+'1';
			duyet_phai(t^.r,s);
            delete(s,length(s),1);
		end;
	end;
end;
procedure Chen_Phai(k:byte);
var i,j:longint;tem,tree:node;
begin
        tree:=new(node);tree^.l:=nil;tree^.r:=nil;
	for i:=1 to d do
	if thuoc_cay(copy(non[i],2,length(non[i])),tr[k+1]) then
	begin
                tem:=tree;
		for j:=1 to length(non[i]) do
		begin

			if non[i][j]='1' then
			if tem^.r = nil then
				Begin
				tem^.r:=new(node);
				tem:=tem^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.r
			else
			if tem^.l = nil then
				Begin
				tem^.l:=new(node);
				tem:=tem^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.l;
		end;
	end;
	tr[k]:=tree;
end;
begin
	tr[l-r+1]:=mangtree[l-r+1];
	for K:=l-r downto 1 do
	begin
		d:=0;
		tree:=mangtree[k];
		st:='';
		duyet_phai(tree,st);
		{writeln('------',k,'-----',d);
        	for jj:=1 to d do writeln(non[jj]);}
		st:='';
		chen_phai(k);
	end;
end;
{----------------------------------------------}
procedure tim_LtoR;{ket noi cac cay tu trai sang phai}
var tem:node;st:string;
d,k,jj:longint;
Function thuoc_cay_trai(st:string;t:node):boolean;
var j:byte;tem:node;
Begin
	
	j:=1;
	tem:=t^.l;
	if tem<>nil then
	Begin
	while j<=length(st) do
	begin
	if (st[j]='1')and(tem^.r<>nil) then tem:=tem^.r
		  else
		  if (st[j]='0')and(tem^.l<>nil) then tem:=tem^.l
		  else break;
		  j:=j+1;
	end;
	If ktnodela(tem) or (tem=nil) then
	Begin thuoc_cay_trai:=true; exit end;
	end;
	j:=1;
	tem:=t^.r;
	if tem<>nil then
	while j<=length(st) do
	begin
	if (st[j]='1')and(tem^.r<>nil) then tem:=tem^.r
		  else
		  if (st[j]='0')and(tem^.l<>nil) then tem:=tem^.l
		  else break;
		  j:=j+1;
	end;
	thuoc_cay_trai:=ktnodela(tem) or (tem=nil) ;
End;
procedure duyet_trai(t:node;s:string);
begin
	if (t^.l = nil) and (t^.r = nil) then
	Begin d:=d+1;non[d]:=s; end
	else
	begin
		if (t^.l <> nil) then
		begin
			s:=s+'0';
			duyet_trai(t^.l,s);
            delete(s,length(s),1);
		end;
		if (t^.r <> nil) then
		begin
			s:=s+'1';
			duyet_trai(t^.r,s);
            delete(s,length(s),1);
		end;
	end;
end;
procedure Chen_trai(k:byte);
var i,j:longint;tem,tree:node;
begin
        tree:=new(node);tree^.l:=nil;tree^.r:=nil;
	for i:=1 to d do
	if thuoc_cay_trai(non[i],tl[k-1]) then
	begin
                tem:=tree;
		for j:=1 to length(non[i]) do
		begin

			if non[i][j]='1' then
			if tem^.r = nil then
				Begin
				tem^.r:=new(node);
				tem:=tem^.r;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.r
			else
			if tem^.l = nil then
				Begin
				tem^.l:=new(node);
				tem:=tem^.l;tem^.l:=nil;tem^.r:=nil;
				end
			else tem:=tem^.l;
		end;
	end;
	tl[k]:=tree;
end;
begin
	tl[1]:=tr[1];
	for K:=2 to l-r+1 do
	begin
		d:=0;
		tree:=tr[k];
		st:='';
		duyet_trai(tree,st);
		{writeln('------',k,'-----',d);
        	for jj:=1 to d do writeln(non[jj]);}
		st:='';
		chen_trai(k);
	end;
end;
{-----------------------------------------------}
procedure nsa;
var k:integer;s:string;
begin
	start := datetimetotimestamp(now);
	for k:=1 to l-r+1 do
        Begin
        init(k);
        pt:=tree;
        ii:=0;
		changePotoNe(pt,ii);
		mangtree[k]:=tree;
        end;
		{writeln('mang tree');
	for k:=1 to l-r+1 do
		Begin
				s:='';
				writeln(k,':');
				duyet(mangtree[k],s);
		end;}
	st:='';
	tim_RtoL;

	{writeln('mang TR:');
        for k:=1 to l-r + 1 do
		Begin
				s:='';
				writeln(k,':');
				duyet(tr[k],s);
		end;}

		tim_LtoR;
		tim_LtoR;

		{writeln('mang TL:');
        for k:=1 to l-r+1 do
		Begin
				s:='';
				writeln(k,':');
				duyet(tL[k],s);
		end;}
		stop:=datetimetotimestamp(now);
	writeln(f,stop.time-start.time);
end;
begin
	docdl;
	{
	ss:='';
	duyet(tree,ss);}
        assign(f,fo);
        rewrite(f);
        {for r:=15 to 15 do
        r:=20;}
        begin
           psa;
           nsa;
        end;
        close(f);
end.
