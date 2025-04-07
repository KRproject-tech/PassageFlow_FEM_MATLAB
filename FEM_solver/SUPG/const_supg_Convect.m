%% SUPGëŒó¨çÄÇÃëgóß

global FEM_R_bb FEM_R_bc FEM_R_cb FEM_R_cc

%%çÇë¨âªÇÃÇΩÇﬂÇÃó\îıêÈåæ
FEM_R_bb = zeros(6,6,6,6,ELEM_NUM_max);
FEM_R_bc = zeros(6,6,6,6,ELEM_NUM_max);
FEM_R_cb = zeros(6,6,6,6,ELEM_NUM_max);
FEM_R_cc = zeros(6,6,6,6,ELEM_NUM_max);


h = waitbar(0,'Creating SUPG Convective term...'); 
for n=1:ELEM_NUM_max

    r_tens = tensor(squeeze(R_tensor(:,:,:,:,n)));
    fem_f_mat = FEM_F_mat ;
    fem_b_mat = squeeze(FEM_B_mat(:,:,n)) ;
    fem_c_mat = squeeze(FEM_C_mat(:,:,n)) ;
    
    FEM_R_bb(:,:,:,:,n) = ttm( r_tens, {fem_f_mat, fem_f_mat, fem_b_mat', fem_b_mat'}, [ 1 2 3 4]);
    FEM_R_bc(:,:,:,:,n) = ttm( r_tens, {fem_f_mat, fem_f_mat, fem_b_mat', fem_c_mat'}, [ 1 2 3 4]);
    FEM_R_cb(:,:,:,:,n) = ttm( r_tens, {fem_f_mat, fem_f_mat, fem_c_mat', fem_b_mat'}, [ 1 2 3 4]);
    FEM_R_cc(:,:,:,:,n) = ttm( r_tens, {fem_f_mat, fem_f_mat, fem_c_mat', fem_c_mat'}, [ 1 2 3 4]);
    
    if mod(n,100) == 0
        waitbar(n/ELEM_NUM_max); 
    end
end


close(h);

clear R_tensor