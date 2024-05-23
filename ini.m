clear;close all;clc

% Initilaization of folders
addpath('util');  % utility 
addpath('algo');  % algo
addpath('algo/NMF');  % algo
addpath('data');  % data
% addpath('data/Browser_images'); % data
addpath('data/Browser_images'); % new data cloud
% addpath('data/Browser_images/JPG_2024-01-04_Sentinel-2_L2A_cloudless/'); % new data no cloud
addpath('exp');   % exp codes

% reset random seed
rng('default');

% string output
format shortG

% figure gray color 
set(0,'DefaultFigureColormap',feval('gray'));

disp('Code initialization done!');