%% 対流項の組立

global FEM_phi_b FEM_phi_c

%%高速化のための予備宣言
FEM_phi_b = zeros(6,6,6,ELEM_NUM_max);
FEM_phi_c = zeros(6,6,6,ELEM_NUM_max);


h = waitbar(0,'Creating Convective term...'); 
for n=1:ELEM_NUM_max

    slmn_tens = tensor(squeeze(FEM_Slmn_mat(:,:,:,n)));
    fem_f_mat = FEM_F_mat(:,:) ;
    fem_b_mat = squeeze(FEM_B_mat(:,:,n)) ;
    fem_c_mat = squeeze(FEM_C_mat(:,:,n)) ;
    FEM_phi_b(:,:,:,n) = ttm( slmn_tens, {fem_f_mat, fem_f_mat, fem_b_mat'}, [ 1 2 3]);
    FEM_phi_c(:,:,:,n) = ttm( slmn_tens, {fem_f_mat, fem_f_mat, fem_c_mat'}, [ 1 2 3]);
    
    if mod(n,100) == 0
        waitbar(n/ELEM_NUM_max); 
    end
end


close(h);

clear FEM_Slmn_mat