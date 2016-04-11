function [ matchPa,matchPe,SimPa,SimPe ] = calcuMatch( featIm1,featIm2,edge1,edge2,wN,wE,beta,option,pN,numCoeffs )
%n1��n2�ֱ���ͼ�е�patch����,a�ǵ�����δ֪
%   featIm1ÿһ�д���һ������
% imA����pic,no,person,feature,edgefeat,wN,wE��person����patchNum,data{n,2}��num��patch{n,pN,2},patchfeature{n,pN},feature{n}
%addpath('./feature')
n=min(size(featIm1,2),size(featIm2,2));
featIm1=double(featIm1);
featIm2=double(featIm2);
edge1=double(edge1);
edge2=double(edge2);
if strcmp(option,'hungarian')
    flag=1;%��ʱ��sqdist�������Ǿ��룬ԽСԽ��
elseif strcmp(option,'eig')
    flag=2;%��ʱ��sqdist�����������ƶȣ�Խ��Խ��
end
if nargin==9
    %featIm1=wN'.*featIm1;   %����ڵ��Ȩ��
    distNode=sqdist(featIm1, featIm2,flag);
    distEdge=0.15*sqdist(edge1(3:end,:), edge2(3:end,:),flag);
else
    distNode=sqdist(featIm1(1:numCoeffs,:), featIm2(1:numCoeffs,:),flag);
    distEdge=0.15*sqdist(edge1(3:numCoeffs,:), edge2(3:numCoeffs,:),flag);
end
for i=1:size(distNode,1)
    distNode(i,:)=distNode(i,:)*wN(i)-mean(distNode(i,:))*(wN(i)-1);%����������ʵ��õĴ���ʽӦ����ϡ�軯��Ȼ����Ϊ̫�鷳�����ó˷�������Ŀ����Ҫ�������ƶ�֮��Ĳ�����
end
for i=1:size(distEdge,1)
    distEdge(i,:)=wE(i)*distEdge(i,:)-mean(distEdge(i,:))*(wE(i)-1);
    %distEdge(i,:)=0*distEdge(i,:);
end
diagData=reshape(distNode,1,size(featIm1,2)*size(featIm2,2));
M=diag(diagData);
siz=size(featIm1,2);
%%�������ʼ�ӱ�
for iForES1=1:size(edge1,2)
    a1=edge1(1,iForES1);a2=edge1(2,iForES1);
    for iForES2=1:size(edge2,2)
        b1=edge2(1,iForES2);b2=edge2(2,iForES2);
        %%��һ��a1b1-a2b2
        i=help(a1,b1,siz);
        j=help(a2,b2,siz);
        M(i,j)=0.5*distEdge(iForES1,iForES2);
        %M(i,j)=15;
        M(j,i)=M(i,j);
        %%�ڶ���a1b2-a2b1
        i=help(a1,b2,siz);
        j=help(a2,b1,siz);
        M(i,j)=0.5*distEdge(iForES1,iForES2);
        %M(i,j)=15;
        M(j,i)=M(i,j);
    end
end
%�ӱߵ���Ϊֹ
if strcmp(option,'eig')
    [V,D]=eig(M);
    match=graphMatching(V,D,n,siz);
    matchPa=match;
    match=reshape(match,size(M,1),1);
    SimPa=1000-((match'*M*match)/n);
elseif strcmp(option,'hungarian')
    [matchPa,SimPa]=Hungarian(distNode);
    SimPa=SimPa/n;
end
%%�����ǰ��˷���
m=size(featIm1,2)/pN;
n=size(featIm2,2)/pN;
match=zeros(m,n);
blank=zeros(size(M,1),1);
for i=1:m
    for j=1:n
        match(i,j)=sum(sum(matchPa((i-1)*pN+1:i*pN,(j-1)*pN+1:j*pN)));
    end
end
match=2*max(max(match))-match;
[matchPe,~]=Hungarian(match);
for j=1:size(matchPe,2)
    for i=1:size(matchPe,1)
        if matchPe(i,j)==1
            blank(size(matchPe,1)*pN*(j-1)+(i-1)*pN+1:size(matchPe,1)*pN*(j-1)+i*pN)=ones(pN,1);
        end
    end
end
SimPe=1000-((blank'*M*blank)/n);
%%%
% [relationNode,~]=Hungarian(distNode);
% [relationEdge,~]=Hungarian(distEdge);
% for i=1:n1
%     for j=1:n2
%         if relationNode(i,j)==1
%             sim1=sim1+w1(i)*(b-distNode(i,j))*w2(j)/(a+abs(w1(i)-w2(j)));
%         end
%     end
% end
% sim1=sim1/min(n1,n2);
% m1=size(featIm1,2)-n1;
% m2=size(featIm2,2)-n2;
% for i=1:m1
%     for j=1:m2
%         if relationEdge(i,j)==1
%             sim2=sim2+w1(n1+i)*(b-distEdge(i,j))*w2(n2+j)/(a+abs(w1(n1+i)-w2(n2+j)));
%         end
%     end
% end
% sim2=sim2/min(m1,m2);
% sim=sim1+beta*sim2;
end
function [ re ] = help( a,b,siz )
re=(b-1)*siz+a;
end

