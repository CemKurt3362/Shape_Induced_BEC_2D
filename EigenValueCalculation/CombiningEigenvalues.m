% Load the eigenvalue data from the CSV files
eigList1 = readmatrix('eigList.csv');
eigList2 = readmatrix('eigList2.csv');

% Preallocate the array for the final eigenvalues for each system
eigList3 = zeros(size(eigList1, 1), 5000);

for i = 1:size(eigList1, 1)
    % Use the first 3000 eigenvalues from the first list
    eigList3(i, 1:3000) = eigList1(i, :);

    % Find the starting index in eigList2 that aligns with the end of eigList1
    lastValue = eigList1(i, end); % Last eigenvalue from eigList1 for the ith system
    startIndex2 = find(eigList2(i, :) > lastValue, 1, 'first'); % Find where to start in eigList2
    
    % Determine the range to take from eigList2, ensuring we do not exceed 5000 eigenvalues in total
    if ~isempty(startIndex2)
        endIndex2 = startIndex2 + (5000 - 3000 - 1);
        endIndex2 = min(endIndex2, size(eigList2, 2)); % Ensure we do not go beyond eigList2's size
        range2 = startIndex2:endIndex2;

        % Append the selected eigenvalues from eigList2 to eigList3
        eigList3(i, 3001:(3000 + length(range2))) = eigList2(i, range2);
    end
end

% Write the combined eigenvalues to a new CSV file
writematrix(eigList3, 'eigList3.csv');