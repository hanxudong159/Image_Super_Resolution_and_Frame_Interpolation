function [output_img] = bicubic(input_img, height, width)
[m, n] = size(input_img);
im = double(input_img);
x_rate = height / m;
y_rate = width / n;
output_img = zeros(height,width);
for i = 1 : height
    for j = 1 : width
    	sx = i / x_rate;
        sy = j / y_rate;
        si = floor(sx);
        sj = floor(sy);
        u = sx - si;
        v = sy - sj;
        if (si + 1) > m
            si = m - 2;
        end
        if (si + 2) > m
            si = m - 2;
        end
        if (si - 1) < 1
            si = 2;
        end
        if (sj + 1) > n
            sj = n - 2;
        end
        if (sj + 2) > n
            sj = n - 2;
        end
        if (sj - 1) < 1
            sj = 2;
        end
        A = [W(1 + u) W(u) W(1 - u) W(2 - u)];
        C = [W(1 + v);W(v);W(1 - v);W(2 - v)];
        B = [im(si - 1, sj - 1) im(si - 1, sj) im(si - 1, sj + 1) im(si - 1, sj + 2);
        im(si, sj - 1) im(si, sj) im(si, sj + 1) im(si, sj + 2);
        im(si + 1, sj - 1) im(si + 1, sj) im(si + 1, sj + 1) im(si + 1, sj + 2);
        im(si + 2, sj - 1) im(si + 2, sj) im(si + 2, sj + 1) im(si + 2, sj + 2);];
        output_img(i,j) = (A * B * C);
    end
end
output_img = uint8(output_img);
end

