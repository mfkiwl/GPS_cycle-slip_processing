% ======================================
% Cycle-slip detection
%
% zhen.dai@dlr.de
%
% last modified: 2011.Oct
% ======================================

% display the dual-freq. residual
function GUI_Results_DispDualFreqResidual(ps,status_record,diff_record,upper_bound_value,vTimeStr)
%inputs:
% ps                            --> sat id
% status_record         -->status generated by the associated method (cycle-slip free, cycle-slip detected, incomplete, interrupted)
% diff_record              --> dual-freq. residual for each satellite and each epoch
% vTimeStr                  --> string regarding the UTC datum and time
% upper_bound_value --> the threshold to identify the cycle-slips

Constants;

totalepoch=size(status_record,2);
upper_bound_value=ones(1,totalepoch)*upper_bound_value;

% show the result of each epoch using different symbols
for j=1:1:totalepoch,
    % check the status of each epoch in order to determine the symbols to
    % be shown
    switch status_record(ps,j)
        case const_interrupt
            plot(j,diff_record(ps,j),'co', 'MarkerEdgeColor','k', 'MarkerFaceColor','c', 'MarkerSize',12); hold on
        case const_incomplete
            plot(j,diff_record(ps,j),'r+'); hold on
        case const_cycleclipfree
            plot(j,diff_record(ps,j),'k.','LineWidth',3); hold on
        case const_detected
            plot(j,diff_record(ps,j),'rp', 'MarkerEdgeColor','r', 'MarkerFaceColor','r', 'MarkerSize',12); hold on

    end
end
plot(1:totalepoch,-upper_bound_value,'g','LineWidth',2); hold on
plot(1:totalepoch,+upper_bound_value,'g','LineWidth',2); hold on

xlim([1 totalepoch])
aa=get(gca,'XTick')  ;
clear strs
for i=1:1:length(aa),
    if aa(i)==0, aa(i)=1; end
    epoch_str=vTimeStr{aa(i)};
    datumstr=epoch_str(1:10);
    timestr=epoch_str(11:20);
    strs{i}=timestr;
end
set(gca,'XTickLabel',strs )
xlabel('Time')
ylabel('Residuals of dual-frequency phase combination [cycles]')