function xf = Newton_Unid(x0, f, epsilon)
    % f es una funcion simbolica de lambda
    syms lmd
    p = [x0];
    k = 1;
    f_p = diff(f, lmd);
    f_pp = diff(f_p, lmd);
    p(k + 1) = p(k) - double(subs(f_p, lmd, p(k))) / double(subs(f_pp, lmd, p(k)));
    while(abs(p(k+1) - p(k)) > epsilon)
        k = k + 1;
        p(k + 1) = p(k) - double(subs(f_p, lmd, p(k))) / double(subs(f_pp, lmd, p(k)));
    end
    xf = p(k+1);
end