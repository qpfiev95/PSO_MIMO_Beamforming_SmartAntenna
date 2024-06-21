function out = func_extrems(in,varargin)
%EXTREMS - Returns structure with local extrema places and values
%
%in is input vector
%Options:
% 'ysort': short the extremas by value (global max and min are the first) -
%          by default values are sorted in time
% 'strict': strict monotonity is desired, plateaus filtered out.
%           if not specified: first element for plateaus is given
% 'minmax': pairs, begin with a min
% 'maxmin': pairs, begin with a max
%
%Elements of output structure:
%   minx: minima places
%   miny: minima values
%   maxx: maxima places
%   maxy: maxima values
%
%
%
%Example:
%
% v=[1 3 5 5 2 -2 -2 -1 8  -10 5];
% o1=extrems(v)
% o2=extrems(v,'ysort')
% o3=extrems(v,'strict')
%
% Outputs:
% o1 = 
%     minx: [6 10]
%     miny: [-2 -10]
%     maxx: [3 9]
%     maxy: [5 8]
% o2 = 
%     minx: [10 6]
%     miny: [-10 -2]
%     maxx: [9 3]
%     maxy: [8 5]
% o3 = 
%     minx: 10
%     miny: -10
%     maxx: 9
%     maxy: 8
esign=diff(in); %derivative: + (changes to -): local maximum, 0: plateau, -: local minimum
if ismember('strict',varargin)
    idx=(1:length(esign));
else
    idx=find(esign);
    esign=esign(idx);
end
idx=idx+1; %now: it is used for indexing the input
eloc=(esign(2:end).*esign(1:end-1))<0; %derivative must change sign in every extrema
eloc(end+1)=false;
esignl=(esign>0); %logical for local maxima 
% assign outputs
out.minx=idx(eloc & (~esignl));
out.miny=in(out.minx);
out.maxx=idx(eloc & esignl);
out.maxy=in(out.maxx);
%matching - omit values if needed
if(ismember('minmax',varargin))
    if (out.maxx(1) < out.minx(1))
        out.maxx = out.maxx(2:end);
        out.maxy = out.maxy(2:end);
    end
    if length(out.minx) > length(out.maxx)
        out.minx = out.minx(1:end-1);
        out.miny = out.miny(1:end-1);
    end
end
        
if(ismember('maxmin',varargin))
    if (out.maxx(1) > out.minx(1))
        out.minx = out.minx(2:end);
        out.miny = out.miny(2:end);
    end
    if length(out.minx) < length(out.maxx)
        out.maxx = out.maxx(1:end-1);
        out.maxy = out.maxy(1:end-1);
    end
end
        
% sort if desired
if(ismember('ysort',varargin))
    [out.miny,idx]=sort(out.miny); out.minx=out.minx(idx);
    [out.maxy,idx]=sort(out.maxy); out.maxx=out.maxx(idx);
    out.maxx=fliplr(out.maxx); out.maxy=fliplr(out.maxy);
end
