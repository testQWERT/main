%首先把得到的imgSet文件存到data文件夹中
filename='imgSet2(w=1).mat';%按照你上一步存入的文件名修改此处的读取文件名，注意带后缀mat
calDist;%运行这个的时候命令行会有不断刷新的数字出现
%此时data文件夹内会出现一个名叫distForGroup+filename的mat文件。
%最后一步是进入KISSME文件夹，在KISSME\workflows\CVPR中找到demo_viper.m运行之，注意在这个m文件中的74行需要改成与以上的filename相一致

