%计算distForGroup
%distForGroup{1,1}是patch分配元胞,{1,2}是patch相似度矩阵,{2,1}是人分配元胞,{2,2}是人相似度矩阵
%option='hungarian';
input='imgSet2(wlcf).mat';
option='eig';


distForGroup=cell(2);
distForGroup{1,2}=zeros(162,162);
distForGroup{2,2}=zeros(162,162);
distForGroup{1,1}=cell(162,162);
distForGroup{2,1}=cell(162,162);
%pN=input('please input the number of patch:');
load(['./data/',input]);
for i=1:162
    for j=1:162
        [distForGroup{1,1}{i,j},distForGroup{2,1}{i,j},distForGroup{1,2}(i,j),distForGroup{2,2}(i,j)]=calcuMatch( imgSetA{1,i}.feature,imgSetB{1,j}.feature,imgSetA{1,i}.edgefeat,imgSetB{1,j}.edgefeat,imgSetA{1,i}.wN,imgSetA{1,i}.wE,1,option,imgSetA{1,1}.person.patchNum);
        disp(['present: ',num2str(i),' ',num2str(j)]);
    end
end
save(['./data/distForGroup+',input],'distForGroup');