% This function implements K-Means++ center initialization algorithm
% for a set of input vectors, and an *initial* set of cluster centers.
%
% function [centers]=init_centers(data,k,init_algo)
%
% Inputs: data - an array of input data points size n x d, with n
%                input points (one per row), each of length d.
%         k - number of clusters
%         init_algo - the center initialization algorithm to use for
%                     the k centers. The default is random initialization,
%		      but when init_algo is "kmeans++" it returns initial
%                     centers based on the kmeans++ alg.
%
% Outputs: centers - Initial cluster centers


function [centers] = init_centers(data,k,init_algo)
  centers = zeros(k, size(data, 2));

  if (strcmpi(init_algo, "kmeans++"))

    indata = data;
    for i = 2:size(centers,1)
        if i == 2
            r_ind = randperm(size(data,1), 1);
            centers(1,:) = indata(r_ind,:);
            indata(r_ind,:) = [];
        end
        d = [];
        for j = 1:i-1
            if centers(j,:) ~= zeros(1, size(indata, 2))
                d = pdist2(centers(j,:),data,'squaredeuclidean');
            end
        end
        [min_i, min_j] = min(d, [], 2);
        dist = min_i.^2;

        p = cumsum((1/sum(dist)) * dist);
        random_option = rand();
        counter = 1;
        while random_option > p(counter)
            counter = counter + 1;
        end
        centers(i,:) = indata(counter,:);
        indata(counter,:) = [];
    end

  else
    % choose initial centers randomly
    random_permutation = randperm(size(data, 1), k);
    centers = data(random_permutation, :);
  end;
