num_images = size(gTruth.LabelData, 1);

% Fixed image dimensions
img_width = 720;
img_height = 576;

for i = 1:num_images
    % Retrieve the coordinates for the current frame
    multiple_folds_coordinates = cell2mat(gTruth.LabelData(i,:).Multiple_Folds(1,:));
    center_coordinates = cell2mat(gTruth.LabelData(i,:).Center(1,:));
    
    % Generate the corresponding .txt file path
    txt_file_path = sprintf('multiplefolds1---%d.txt', i);
    
    % Open the file for writing
    fid = fopen(txt_file_path, 'w');
    
    % Combine coordinates and class labels
    if isempty(multiple_folds_coordinates) && isempty(center_coordinates)
        % If both coordinates are empty, close the file and continue
        fclose(fid);
        continue;
    end
    
    % Combine the coordinates and assign class labels
    coordinates = [multiple_folds_coordinates, ones(size(multiple_folds_coordinates, 1), 1); ...
                   center_coordinates, zeros(size(center_coordinates, 1), 1)];
    
    % Loop over each bounding box
    for j = 1:size(coordinates, 1)
        % Extract the current bounding box and class label
        bbox = coordinates(j, 1:4);
        class_label = coordinates(j, 5);
        
        % Check for NaN values
        if any(isnan(bbox))
            continue;
        end
        
        % Calculate x_center and y_center
        x_center = bbox(1) + bbox(3) / 2;
        y_center = bbox(2) + bbox(4) / 2;
        
        % Normalize coordinates
        x_center = x_center / img_width;
        y_center = y_center / img_height;
        width = bbox(3) / img_width;
        height = bbox(4) / img_height;
        
        % Write the class number and normalized coordinates to the .txt file
        fprintf(fid, '%d %f %f %f %f\n', class_label, x_center, y_center, width, height);
    end
    
    % Close the file
    fclose(fid);
end
