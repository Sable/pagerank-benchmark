function runner(n, iter, thresh, divisor)
% Example: runner(3000,10,0.00000001,100000);
    if divisor < 1
        error('ERROR: Invalid divisor %d for random initialization, divisor should be greater or equal to 1\n', divisor);
    end

    fprintf(2, 'Creating random page matrix\n');
    [pages,noutlinks] = createRandomPageMatrices(n, divisor);
    fprintf(2, 'The matrix has been created successfully\n');

    fprintf(2, 'nb of links: %d/%d\n', sum(sum(pages)), n*n);
    fprintf(2, 'links checksum: %d\n', fletcherSum(pages));

    % Initialize pages weight uniformly at the beginning
    pageRanks = zeros(n,1);
    pageRanks(:) = 1/n;

    tic;
    [pageRanks,t,maxDiff] = pagerank(iter,thresh,pages,noutlinks,pageRanks,n);
    elapsedTime = toc;
    fprintf(2,'Threshold reached %d with max diff %f\n', t, maxDiff);

    fprintf(1, '{ \"status\": %d, \"options\": \"-n %d -i %d -t %f -d %f\", \"time\": %f, \"output\": %d }\n', 1, n, iter, thresh, divisor, elapsedTime, fletcherSum(floor(pageRanks*1000000000)));
end
