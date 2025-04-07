%% Mesh Boundary

if ( elem_y_max(1) - Node_xy(Elem_num(i,1),2) < dz || elem_y_max(1) - Node_xy(Elem_num(i,2),2) < dz || elem_y_max(1) - Node_xy(Elem_num(i,3),2) < dz )...
        || ( Node_xy(Elem_num(i,1),2) - elem_y_min(1) < dz || Node_xy(Elem_num(i,2),2) - elem_y_min(1) < dz || Node_xy(Elem_num(i,3),2) - elem_y_min(1) < dz )...
        || ( Node_xy(Elem_num(i,1),1) + 50e-3 < dz || Node_xy(Elem_num(i,2),1) + 50e-3 < dz || Node_xy(Elem_num(i,3),1) + 50e-3 < dz )
	inlet = 1;           
elseif  ( 100e-3 - Node_xy(Elem_num(i,1),1) < dz || 100e-3 - Node_xy(Elem_num(i,2),1) < dz || 100e-3 - Node_xy(Elem_num(i,3),1) < dz )
	outlet = 1;
end