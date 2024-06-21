function out = sllmax( a )
pv1 = find(round(a,3) == 1,1,'first');
pv2 = find(round(a,3) == 1,1,'last');

    
        maxpoint1 = second_max(a(1:pv1));
        maxpoint2 = second_max(a(pv2:length(a)));
        out =   max(maxpoint1,maxpoint2);



end

