%% B.C.ŒvZ

%% B.C.(’è”•”•ª)
GLOBAL_MATRIX_NUM = 2*NEW_NODE_NUM_max + NODE_NUM_max;

%% „«s—ñ‚Ì‘ÎŠp¬•ª
hG_K = sparse(1,GLOBAL_MATRIX_NUM);
diag_elem = [hold_num_v(:); NEW_NODE_NUM_max+hold_num_v(:);
            hold_num_v2(:); NEW_NODE_NUM_max+hold_num_v2(:);
            2*NEW_NODE_NUM_max+hold_num(:)];
hG_K(1,diag_elem') = 1;  
hG_K = diag(hG_K);


%%%%%%%%%%%%%%%%%%%%%%—¬“ü‚Ì‹«ŠEğŒ
G_M(hold_num_v(:),:) = 0;%u
G_M(NEW_NODE_NUM_max+hold_num_v(:),:) = 0;%v

G_KL(hold_num_v(:),:) = 0;%u
G_KL(NEW_NODE_NUM_max+hold_num_v(:),:) = 0;%v

G_F(hold_num_v(:),1) = u_w;%u
G_F(NEW_NODE_NUM_max + hold_num_v(:),1) = v_w;%v

%%%%%%%%%%%%%%%%%%%%%%“à•”•¨‘Ì‚Ì‘¬“x‹«ŠEğŒ
G_M(hold_num_v2(:),:) = 0;%u
G_M(NEW_NODE_NUM_max+hold_num_v2(:),:) = 0;%v

G_KL(hold_num_v2(:),:) = 0;%u
G_KL(NEW_NODE_NUM_max+hold_num_v2(:),:) = 0;%v 

G_F(hold_num_v2(:),1) = u_w_obj;%u
G_F(NEW_NODE_NUM_max + hold_num_v2(:),1) = v_w_obj;%v

%%%%%%%%%%%%%%%%%%%%%%—¬o‚Ì‹«ŠEğŒ(p=0)
G_M(2*NEW_NODE_NUM_max + hold_num(:),:) = 0;

G_KL(2*NEW_NODE_NUM_max + hold_num(:),:) = 0;

G_KL = G_KL + hG_K;  

G_F(2*NEW_NODE_NUM_max + hold_num(:),1) = 0;

