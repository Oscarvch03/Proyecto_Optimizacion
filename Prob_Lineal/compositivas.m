function [wpos, indpos] = compositivas(w)
    wp = [];
    ind= [];
    for i=1:length(w)
        if w(i) > 0
            wp = [wp, w(i)]; % valor positivo del vector w
            ind = [ind, i];  % indice del valor positivo del valor w
        end
    end
    wpos = wp';
    indpos = ind';
end