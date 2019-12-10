function rect_sign = rectangular( eta,t,T )
    for i=1:length(t)
        current_sample=t(i);
        if mod(current_sample,T)<=eta*T
            rect_sign(i)=1;
        else
            rect_sign(i)=0;
        end
    end
end

