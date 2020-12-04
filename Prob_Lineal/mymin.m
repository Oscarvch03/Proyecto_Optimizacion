function [vmin,indmin] = mymin(v)
    m = length(v);
    indmin = 0;
    i = 1;
    flag = 0;
    while(flag == 0 && i <= m)
        if(v(i) < 0)
            flag = 1;
            indmin = i;
            vmin = v(i);
            i = m + 1;
        else
            i = i + 1;
        end
    end
    if(flag == 0)
        vmin = 0;
        indmin = 1;
        % disp('no tiene componentes negativas')
    end
end