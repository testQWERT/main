function [ result1,result2 ] = differ( relaT,rela,groupNum,pN,distForGroup)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
bottom=0;
result1=0;
result2=0;
for i=1:groupNum
    %for j=1:groupNum
    tmpT=relaT{i,i};
    tmp=rela{i,i};
    for k=1:size(tmpT,1)
        [~,b]=find(tmpT(k,:)==1);
        if size(b,1)>0
            bottom=bottom+pN;
            for x=(k-1)*pN+1:k*pN
                [~,y]=find(tmp(x,:)==1);
                if y<=(b*pN)
                    if y>=((b-1)*pN+1)
                        result1=result1+1;
                    end
                end
            end
        end
    end
    %end
end
result1=result1/bottom;
for i=1:groupNum
    tmp=distForGroup(i,:);
    [~,tmp]=sort(tmp,'ascend');
    [~,a]=find(tmp==i);
    result2=result2+a;
end
result2=result2/groupNum;
end

