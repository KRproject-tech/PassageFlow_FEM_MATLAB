%% SUPGŠgŽU€ŒW”ƒeƒ“ƒ\ƒ‹ì¬

global FEM_T_bb FEM_T_bc FEM_T_cb FEM_T_cc


%%‚‘¬‰»‚Ì‚½‚ß‚Ì—\”õéŒ¾
FEM_T_bb = zeros(6,6,6,ELEM_NUM_max);
FEM_T_bc = zeros(6,6,6,ELEM_NUM_max);
FEM_T_cb = zeros(6,6,6,ELEM_NUM_max);
FEM_T_cc = zeros(6,6,6,ELEM_NUM_max);


h = waitbar(0,'Creating SUPG Diffusive term...'); 
for n=1:ELEM_NUM_max

    t_tens = tensor(squeeze(T_tensor(:,:,n)))/(2*S(n));
    fem_f_mat = FEM_F_mat;
    fem_b_mat = squeeze(FEM_B_mat(:,:,n)) ;
    fem_c_mat = squeeze(FEM_C_mat(:,:,n)) ;
    fem_b_vec = squeeze(FEM_b_vec(:,n)) ;
    fem_c_vec = squeeze(FEM_c_vec(:,n)) ;
    
    fem_B_b = tensor(fem_b_mat'*fem_b_vec);
    fem_C_c = tensor(fem_c_mat'*fem_c_vec);
    
    %%ttt:outer product, a_ij*b_kl = c_ijkl
    FEM_T_bb(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_b_mat'}, [ 1 2]),fem_B_b));% a_1i*b_1j = c_1i1j -> squeeze(c_1i1j) = c_ij 
    FEM_T_bc(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_b_mat'}, [ 1 2]),fem_C_c));
    FEM_T_cb(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_c_mat'}, [ 1 2]),fem_B_b));
    FEM_T_cc(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_c_mat'}, [ 1 2]),fem_C_c));
    
    if mod(n,100) == 0
        waitbar(n/ELEM_NUM_max); 
    end
end


close(h);
