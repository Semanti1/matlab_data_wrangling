function [error] = calcError3d(orig,recon)
x = (orig(:,1)-recon(:,1)).^2;
y = (orig(:,2)-recon(:,2)).^2;
z = (orig(:,3)-recon(:,3)).^2;
d = x + y + z;
dist = sqrt(d);
error = mean(dist);
end

