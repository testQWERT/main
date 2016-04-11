function [ match ] = graphMatching( V,D,n,siz )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
assitC=0;
match=zeros(size(V,1),1);
for i=1:size(D,2)
    [c,b]=find(D==max(max(D)));
    sum=V(:,b);
    [~,loc]=sort(sum,'descend');
    for j=1:size(sum,1)
        if assitC>=n
            break;
        end
        if match(loc(j))==0 && sum(loc(j))>0;
            match(loc(j))=1;
            match=check(match,loc(j),siz);
            assitC=assitC+1;
        end
    end
    D(c,b)=-10000;
    if assitC>=n
        break;
    end
end
%[x,y]=find(D==max(max(D)));
% for i=1:n
%     if assitC>n
%         break;
%     end
%     [x,y]=find(D==max(max(D)));
%     for k=1:size(y,1)
%         sum=sum+V(:,y(k));
%         assitC=assitC+1;
%     end
%     D(x,y)=-10000;
% end
% sum=V(:,y);
% match=zeros(size(V,1),1);
% sum=abs(sum);
% assitC=1;
% for i=1:n
%     if assitC>n
%         break;
%     end
%     [x,~]=find(sum==max(sum));
%     for k=1:size(x,1)
%         match(x(k))=1;
%         sum=check(sum,x(k),siz);
%         assitC=assitC+1;
%         sum(x(k))=-10000;
%     end
% end
match=reshape(match,siz,length(match)/siz);
[x,y]=find(match==-10);
for i=1:length(x)
    match(x(i),y(i))=0;
end
end

function [tmp]=check(V,tar,siz)
cc=size(V,1);
from=ceil(tar/siz)*siz-siz+1;
to=ceil(tar/siz)*siz;
for j=from:to
    if j==tar
        continue;
    else
        V(j)=-10;
    end
end
from=rem(tar,siz);
if from==0
    from=siz;
end
to=cc-siz+rem(tar,siz);
if rem(tar,siz)==0
    to=to+siz;
end
for j=from:siz:to 
    if j==tar
        continue;
    else
        V(j)=-10;
    end
end
tmp=V;
end
