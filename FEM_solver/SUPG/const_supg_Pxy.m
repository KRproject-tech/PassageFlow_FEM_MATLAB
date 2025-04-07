%% SUPGà≥óÕçÄÉeÉìÉ\ÉãçÏê¨

global FEM_P_xb FEM_P_xc FEM_P_yb FEM_P_yc


%%çÇë¨âªÇÃÇΩÇﬂÇÃó\îıêÈåæ
FEM_P_xb = zeros(6,6,3,ELEM_NUM_max);
FEM_P_xc = zeros(6,6,3,ELEM_NUM_max);
FEM_P_yb = zeros(6,6,3,ELEM_NUM_max);
FEM_P_yc = zeros(6,6,3,ELEM_NUM_max);


h = waitbar(0,'Creating SUPG Pressure term...'); 
for n=1:ELEM_NUM_max

    t_tens = tensor(squeeze(T_tensor(:,:,n)))/(2*S(n));
    fem_f_mat = FEM_F_mat ;
    fem_b_mat = squeeze(FEM_B_mat(:,:,n)) ;
    fem_c_mat = squeeze(FEM_C_mat(:,:,n)) ;
    fem_b_vec = tensor(squeeze(FEM_b_vec(:,n))) ;
    fem_c_vec = tensor(squeeze(FEM_c_vec(:,n))) ;
    
    %%ttt:outer product, a_ij*b_kl = c_ijkl
    FEM_P_xb(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_b_mat'}, [ 1 2]),fem_b_vec));
    FEM_P_xc(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_c_mat'}, [ 1 2]),fem_b_vec));
    FEM_P_yb(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_b_mat'}, [ 1 2]),fem_c_vec));
    FEM_P_yc(:,:,:,n) = squeeze(ttt(ttm( t_tens, {fem_f_mat, fem_c_mat'}, [ 1 2]),fem_c_vec));
    
    if mod(n,100) == 0
        waitbar(n/ELEM_NUM_max); 
    end
end


close(h);

