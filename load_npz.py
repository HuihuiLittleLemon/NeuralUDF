import numpy as np
aa = np.load('dataset/deepfashion_rendering_fov60/bird_-1_sample_orth_mask_0.1/cameras_sphere.npz')
print(aa['world_mat_2'])
# np.savez('cameras_sphere.npz', world_mat_0 = aa['world_mat_0'], scale_mat_0 = aa['scale_mat_0'],world_mat_1 = aa['world_mat_27'], scale_mat_1 = aa['scale_mat_27'])

K= np.array([[512, 0, 512],[0, 512, 512],[0, 0, 1]],dtype=float)
rr=-1.0
R0=np.eye(3)
t0=np.array([[0,0,rr]])
arr0 = np.concatenate((np.concatenate((K@R0,K@t0.T),axis=1),np.array([[0,0,0,1]])),axis=0)

theta = np.pi/2.0
R1=np.array([[np.cos(theta), 0, -np.sin(theta)],[0, 1, 0],[np.sin(theta), 0, np.cos(theta)]],dtype=float)
t1=np.array([[rr,0,0]])
arr1 = np.concatenate((np.concatenate((K@R1,K@t1.T),axis=1),np.array([[0,0,0,1]])),axis=0)

theta = -np.pi/2.0
R2=np.array([[1, 0, 0],[0,np.cos(theta), -np.sin(theta)],[0, np.sin(theta), np.cos(theta)]],dtype=float)
t2=np.array([[0,rr,0]])
arr2 = np.concatenate((np.concatenate((K@R2,K@t2.T),axis=1),np.array([[0,0,0,1]])),axis=0)
print(arr2)
# theta = np.pi/4.0
# R2=np.array([[np.cos(theta), 0, -np.sin(theta)],[0, 1, 0],[np.sin(theta), 0, np.cos(theta)]],dtype=float)
# t2=np.array([[1,0,0]])
# arr2 = np.concatenate((K@R2,-K@R2@t2.T),axis=1)

np.savez('cameras_sphere.npz', world_mat_0 = arr0, scale_mat_0 = np.eye(4),world_mat_1 = arr1, scale_mat_1 = np.eye(4),world_mat_2 = arr2, scale_mat_2 = np.eye(4))