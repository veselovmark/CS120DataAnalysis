clear;
close all;

addpath('../Functions/');

save_bad_subjects = false;

load('features_sleepdetection.mat');

load('results_personal.mat');
acc_personal = out.performance(:,1);
load('results_global.mat');
acc_global = out.performance(:,1);

% only analyze features for which missing makes sense
features_to_analyze = [2 3 4 5 6 7 8 10 11 12 13 14 15];
features_to_analyze_labels = feature_label(features_to_analyze);

%% finding proportion of missing sensor features
for i=1:length(feature),
    if ~isempty(feature{i})
        p_nan(i) = sum(sum(isnan(feature{i}(:,features_to_analyze))))/(size(feature{i},1)*length(features_to_analyze));
    else
        p_nan(i) = nan;
    end
end

ind_bad = find(p_nan>.5);

%% global model accuracy vs missing sensor data
figure(1)
% mdl = fitlm(p_nan, acc_global);
% plot([0 1], mdl.Coefficients.Estimate(2)*[0 1]+mdl.Coefficients.Estimate(1),'color',[.5 .5 .5], 'linewidth', 3);
hold on
plot(p_nan, acc_global,'.','markersize',8,'color',[.2 .2 .7]);
xlabel('Proportion of Missing Sensor Data');
ylabel('Classification Accuracy');
[r,p] = mycorr(p_nan,acc_global,'spearman');
text(.6,.7, ['\rho = ', num2str(r,'%.2f'),'**'],'fontweight','bold','fontsize',14);
box off;
ylim([.55 1]);
title('Global Model','fontsize',12,'fontweight','normal');
set(gca, 'fontsize',12);
set(gca, 'Ticklength', [0 0])


%% personal model accuracy vs missing sensor data
figure(2)
% mdl = fitlm(p_nan, acc_personal);
% plot([0 1], mdl.Coefficients.Estimate(2)*[0 1]+mdl.Coefficients.Estimate(1),'color',[.5 .5 .5], 'linewidth', 3);
hold on
plot(p_nan, acc_personal,'.','markersize',8,'color',[.2 .2 .7])
xlabel('Proportion of Missing Sensor Data');
ylabel('Classification Accuracy');
[r,p] = mycorr(p_nan,acc_personal,'spearman');
text(.6,.7, ['\rho = ', num2str(r,'%.2f'),'*'],'fontweight','bold','fontsize',14);
box off;
ylim([.55 1]);
title('Personal Model','fontsize',12,'fontweight','normal');
set(gca, 'fontsize',12);
set(gca, 'Ticklength', [0 0])

% for i=1:length(feature)
%     cnt = 0;
%     if ~isempty(feature{i}),
%         for j=features_to_analyze,
%             cnt = cnt+1;
%             p_feature_nan(i,cnt) = sum(isnan(feature{i}(:,j)))/size(feature{i},1);
%         end
%     else
%         p_feature_nan = nan*ones(1,length(features_to_analyze));
%     end
% end
% 
% figure;
% for i=1:size(p_feature_nan,2),
%     subplot(ceil(sqrt(size(p_feature_nan,2))),ceil(sqrt(size(p_feature_nan,2))),i);
%     plot(p_feature_nan(:,i), acc,'.','markersize',12);
%     xlabel('proportion of missing data');
%     ylabel('accuracy');
%     title(sprintf('%s (r=%.3f)',features_to_analyze_labels{i},mycorr(p_feature_nan(:,i),acc,'pearson')));
%     box off;
% end

%% finding missing data in EMA
p_nan = [];
for i=1:length(state),
    if ~isempty(state{i})
        p_nan(i) = sum(isnan(state{i}))/length(state{i});
    else
        p_nan(i) = nan;
    end
end

%% global model accuracy vs missing data in EMA
figure(3)
hold on
% plot([0 1], mdl.Coefficients.Estimate(2)*[0 1]+mdl.Coefficients.Estimate(1),'color',[.5 .5 .5], 'linewidth', 3);
% mdl = fitlm(p_nan, acc_global, 'poly1');
% ezplot(sprintf('(%f)+(%f)*x',mdl.Coefficients.Estimate))
% mdl = fitlm(p_nan, acc_global, 'poly2');
% ezplot(sprintf('(%f)+(%f)*x+(%f)*x^2',mdl.Coefficients.Estimate))
% mdl = fitlm(p_nan, acc_global, 'poly3');
% ezplot(sprintf('(%f)+(%f)*x+(%f)*x^2+(%f)*x^3',mdl.Coefficients.Estimate))
% mdl = fitlm(p_nan, acc_global, 'poly4');
% ezplot(sprintf('(%f)+(%f)*x+(%f)*x^2+(%f)*x^3+(%f)*x^4',mdl.Coefficients.Estimate))
% mdl = fitlm(p_nan, acc_global, 'poly5');
% ezplot(sprintf('(%f)+(%f)*x+(%f)*x^2+(%f)*x^3+(%f)*x^4+(%f)*x^5',mdl.Coefficients.Estimate))
% mdl = fitlm(p_nan, acc_global, 'poly6');
% ezplot(sprintf('(%f)+(%f)*x+(%f)*x^2+(%f)*x^3+(%f)*x^4+(%f)*x^5+(%f)*x^6',mdl.Coefficients.Estimate))
plot(p_nan, acc_global,'.','markersize',8,'color',[.2 .2 .7]);
xlabel('Proportion of Missing EMA Data');
ylabel('Classification Accuracy');
[r,p] = mycorr(p_nan,acc_global,'spearman');
text(.6,.7, ['\rho = ', num2str(r,'%.2f'),'***'],'fontweight','bold','fontsize',14);
box off;
ylim([.55 1]);
xlim([0 1]);
title('Global Model','fontweight','normal','fontsize',12);
set(gca, 'fontsize',12);
set(gca, 'Ticklength', [0 0])

%% personal model accuracy vs missing data in EMA
figure(4)
% mdl = fitlm(p_nan, acc_personal);
% plot([0 1], mdl.Coefficients.Estimate(2)*[0 1]+mdl.Coefficients.Estimate(1),'color',[.5 .5 .5], 'linewidth', 3);
hold on
plot(p_nan, acc_personal,'.','markersize',8,'color',[.2 .2 .7]);
xlabel('Proportion of Missing EMA Data');
ylabel('Classification Accuracy');
[r,p] = mycorr(p_nan,acc_personal,'spearman');
text(.6,.7, ['\rho = ', num2str(r,'%.2f'), '***'],'fontweight','bold','fontsize',14);
box off;
ylim([.55 1]);
xlim([0 1]);
title('Personal Model','fontweight','normal','fontsize',12);
set(gca, 'fontsize',12);
set(gca, 'Ticklength', [0 0])

if save_bad_subjects
    save('bad_subjects','ind_bad');
end
