global all_row_ind all_col_ind  all_row_ind2 all_col_ind2 ELEM_NUM_max Elem_num;

%% ˆÚ—¬€ESUPGŠµ«/ˆÚ—¬€
all_row_ind = zeros(ELEM_NUM_max,36);
all_col_ind = zeros(ELEM_NUM_max,36);

%% SUPGˆ³—Í€
all_row_ind2 = zeros(ELEM_NUM_max,18);
all_col_ind2 = zeros(ELEM_NUM_max,18);

for i=1:ELEM_NUM_max    

	%%%%%%%%%%%%%%%%%%%%% ˆÚ—¬€ESUPGŠµ«/ˆÚ—¬€
    
	% insert your 1x36 array of row indexes
	all_row_ind(i,:) = reshape(repmat(Elem_num(i,:)',1,6)',1,36);

	% insert your 1x36 array of column indexes
	all_col_ind(i,:) = repmat(Elem_num(i,:),1,6);
    
    %%%%%%%%%%%%%%%%%%%%% SUPGˆ³—Í€
	% insert your 1x36 array of row indexes
	all_row_ind2(i,:) = reshape(repmat(Elem_num(i,1:6)',1,3)',1,18);

	% insert your 1x36 array of column indexes
	all_col_ind2(i,:) = repmat(Elem_num(i,1:3),1,6);
    
end

%% ˆÚ—¬€ESUPGŠµ«/ˆÚ—¬€
all_row_ind = reshape(all_row_ind',1,36*ELEM_NUM_max);
all_col_ind = reshape(all_col_ind',1,36*ELEM_NUM_max);
%% SUPGˆ³—Í€
all_row_ind2 = reshape(all_row_ind2',1,18*ELEM_NUM_max);
all_col_ind2 = reshape(all_col_ind2',1,18*ELEM_NUM_max);