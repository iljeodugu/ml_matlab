function [dummymat,dummyvarnames] = cattable2mat(data)
% Makes a matrix from a table, with categorical variables replaced by (numeric) dummy variables

vars = data.Properties.VariableNames;

% Note that overwriting table variables with a different type doesn't work
% with {} indexing, only with dot. Hence, indexing is all table.(varname),
% because variable names are stored as strings (cell array VARS).

% start keeping a list of variable names
dummyvarnames = {};

for k = 1:(numel(vars)-1)
    thisvar = data.(vars{k});
    if iscategorical(thisvar)
        % get list of categories and how many there are
        c = categories(thisvar);
        n = numel(c);
        % replace variable with matrix of dummy variables
        data.(vars{k}) = dummyvar(thisvar);
        % make variable names to match the dummy variables (by appending
        % the category value to the categorical variable name)
        c = strcat(repmat(vars(k),n,1),'_',c);
    else
        % for numeric variables, just keep the single variable name
        c = vars(k);
    end
    % add the variable name(s) to the list
    dummyvarnames = [dummyvarnames;c]; %#ok<AGROW>
end

% return the numeric values
dummymat = data{:,1:end-1};
