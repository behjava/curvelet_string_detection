clear

load g_4e-7
load gs_4e-7
%load gs1e-8.txt

g=g_4e_7;
gs=gs_4e_7;
%gs=gs1e_8;

num=size(g,1);

summm=sum(sum(g));
average=summm/(num^2);
g=g-average;

summm=0;
summm=sum(sum(gs));
average=summm/(num^2);
gs=gs-average;


variance=0;
for i=1:num
    for j=1:num
        variance=variance+(g(i,j))^2;
    end
end
variance=sqrt(variance/(num^2));

g=g/variance;


variance=0;
for i=1:num
    for j=1:num
        variance=variance+(gs(i,j))^2;
    end
end
variance=sqrt(variance/(num^2));

gs=gs/variance;

% moment2=0;
% moment4=0;
% for i=1:num
%     for j=1:num
%         moment2=moment2+(gs(i,j))^2;
%     end
% end
% moment2=moment2/(num^2);
% 
% for i=1:num
%     for j=1:num
%         moment4=moment4+(gs(i,j))^4;
%     end
% end
% moment4=moment4/(num^2);
% 
% kurtosis=moment4/(moment2)^2;




number_of_scales=6;

Cg = fdct_wrapping(g,1,1,number_of_scales,16);     %performing foeward curvelet transfrom
Cgs = fdct_wrapping(gs,1,1,number_of_scales,16);




Eg = cell(size(Cg));
Egs = cell(size(Cgs));



kurtosis_g=zeros(1,number_of_scales);
kurtosis_gs=zeros(1,number_of_scales);

for k=1:number_of_scales
    for s=1:length(Cg)
  Eg{s} = cell(size(Cg{s}));
  for w=1:length(Cg{s})
    Eg{s}{w} = zeros(size(Cg{s}{w}));
  end
    end

    for s=1:length(Cgs)
  Egs{s} = cell(size(Cgs{s}));
  for w=1:length(Cgs{s})
    Egs{s}{w} = zeros(size(Cgs{s}{w}));
  end
end
    
    
    for w=1:length(Cg{k});
    
    Eg{k}{w} =Cg{k}{w};
    end
    
     for w=1:length(Cgs{k});
    
    Egs{k}{w} =Cgs{k}{w};
    end

restored_g = real(ifdct_wrapping(Eg,1,num,num));
restored_gs = real(ifdct_wrapping(Egs,1,num,num));
%eval(['gs_scale_' num2str(k) '=restored_gs;']);

average=0;
summ=sum(sum(restored_g));
average=summ/(num^2);
restored_g=restored_g - average;

average=0;
summ=0;
summ=sum(sum(restored_gs));
average=summ/(num^2);
restored_gs=restored_gs - average;

moment2_g=0;
moment4_g=0;
moment2_gs=0;
moment4_gs=0;

for i=1:num
    for j=1:num
        moment2_g=moment2_g+(restored_g(i,j))^2;
        moment2_gs=moment2_gs+(restored_gs(i,j))^2;
    end
end

moment2_g=moment2_g/(num^2);
moment2_gs=moment2_gs/(num^2);

for i=1:num
    for j=1:num
        moment4_g=moment4_g+(restored_g(i,j))^4;
        moment4_gs=moment4_gs+(restored_gs(i,j))^4;
    end
end
moment4_g=moment4_g/(num^2);
moment4_gs=moment4_gs/(num^2);

kurtosis_g(k)=moment4_g/(moment2_g)^2;
kurtosis_gs(k)=moment4_gs/(moment2_gs)^2;
end


plot(kurtosis_g,'b');figure(gcf)
hold
plot(kurtosis_gs,'r');figure(gcf)





