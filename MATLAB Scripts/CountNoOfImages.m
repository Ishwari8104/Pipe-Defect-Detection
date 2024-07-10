num_images = size(gTruth.LabelData, 1);

% Initialize the count of images with Multiple Folds class
num_images_with_multiple_folds = 0;

for i = 1:num_images
    % Retrieve the coordinates for the current frame
    multiple_folds_coordinates = cell2mat(gTruth.LabelData(i,:).Multiple_Folds(1,:));
    
    % Check if there are multiple folds coordinates
    if ~isempty(multiple_folds_coordinates)
        num_images_with_multiple_folds = num_images_with_multiple_folds + 1;
    end
end

% Display the number of images with Multiple Folds class
disp(['Number of images with Multiple Folds class: ', num2str(num_images_with_multiple_folds)]);
