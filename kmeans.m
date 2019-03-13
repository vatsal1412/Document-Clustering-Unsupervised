%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This function implements K-means clustering for a set of input
%  vectors, and an *initial* set of cluster centers.
%
% function [centers,labels]=kmeans(data,cent_init,k)
%
% Example calls (assuming data contains vectors of length 3 in each row)
%
% [centers,labels]=kmeans(data,[1 2 3; 4 5 6],2);  % use initial centers
%                                                  % [1 2 3] and [4 5 6]
%
%
% Inputs: data - an array of input data points size n x d, with n
%                input points (one per row), each of length d.
%         k - number of clusters
%         cent_init - an array of size k x d, with k initial cluster centers
%
% Outputs: centers - Final cluster centers
%          labels - An array of size n x 1, with labels indicating
%                   which cluster each input point belongs to.
%                   e.g. if data point i belongs to cluster j,
%                   then labels(i)=j
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [centers,labels]=kmeans(data,cent_init,k)

centers=zeros(k,size(data,2));
labels=zeros(size(data,1),1);

if (size(cent_init,1)~=k | size(cent_init,2)~=size(data,2) | isempty(cent_init))
  fprintf(2,'Initial centers array has wrong dimensions.\n');
  return;
end;

centers=cent_init;


while 1
  old_labels = labels;

  dist = zeros(size(centers,1), size(data,1));
  for i = 1:size(centers,1)
     dist(i,:) = pdist2(centers(i,:),data,'squaredeuclidean');
  end
  [~,in] = min(dist);
  labels = in';


  for j = 1:size(centers,1)
    ind = find(labels == j);
    centers(j,:) = sum(data(ind,:),1)./sum(labels == j);
  end

  if (old_labels == labels)
      break;
  end
end
