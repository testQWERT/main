load('peopleNum.mat');
addpath('./feature');
orientalPatchNum=input('please input the orientalPatchNum:');
peopleNumA2=peopleNumA;peopleNumA2(1)=0;
peopleNumB2=peopleNumB;peopleNumB2(1)=0;
for i=2:size(peopleNumA,2)
    peopleNumA2(i)=peopleNumA2(i-1)+peopleNumA(i-1);%peopleNumA2中每个元素储存的是前面已经有了多少个人
    peopleNumB2(i)=peopleNumB2(i-1)+peopleNumB(i-1);
end
root='D:\research301\crowd tracking\视频数据库\newSet\Origin\group\';
filesGroup=dir([root,'*.png']);
filesPersonA=dir('D:\research301\crowd tracking\视频数据库\11-20manulExtract-Person\resize\cam_a\*.bmp');
filesPersonB=dir('D:\research301\crowd tracking\视频数据库\11-20manulExtract-Person\resize\cam_b\*.bmp');
imgSetA=cell(1,length(peopleNumA));
imgSetB=cell(1,length(peopleNumB));
for i=1:length(peopleNumA)
    [imgSetA{1,i},imgSetB{1,i}]=featureExtract( filesGroup(i*2-1).name,filesGroup(i*2).name,peopleNumA,peopleNumB,peopleNumA2,peopleNumB2,root,filesPersonA,filesPersonB,orientalPatchNum);
    disp(['present: ',num2str(i)]);
end
addpath('./calcuW');
groupNum=162;
%pN=input('please input the number of patch:');
pN=imgSetA{1,1}.person.patchNum;
for i=1:groupNum
    imgSetA{1,i}.wN=[];
    imgSetA{1,i}.wE=[];
    [imgSetA{1,i}.wN,imgSetA{1,i}.wE]=calcuW(imgSetA{1,i});
end
save(['./data/imgSet',num2str(pN),'(w=1).mat'],'imgSetA','imgSetB');