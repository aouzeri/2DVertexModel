function Area = getApicalArea(celldata)
%% get polygonal area of cellID

vertices       = celldata.connec{1};
vertexcoords   = celldata.r;
Area               = 0;

% find mean of vertex coordinates
meanCoord = zeros(1,2);
for k = 1:length(vertices)
	meanCoord = meanCoord + vertexcoords(vertices(k),:);
end
meanCoord = meanCoord/length(vertices);

for j = 1:length(vertices)
	if j < length(vertices)
		p1 = vertices(j);
		p2 = vertices(j+1);
	else % Final edge
		p1 = vertices(j);
		p2 = vertices(1);
	end
	
	vecp1 = [vertexcoords(p1,1),vertexcoords(p1,2),0.0];
	vecp2 = [vertexcoords(p2,1),vertexcoords(p2,2),0.0];
	vecp3 = [meanCoord(1),meanCoord(2),0.0];
	
	% 1,2,3 in counterclockwise order
	Area = Area + getTriangleArea(vecp1,vecp2,vecp3);
end