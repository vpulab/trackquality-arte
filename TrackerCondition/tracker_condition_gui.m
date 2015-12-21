function varargout = tracker_condition_gui(varargin)
% tracker_condition_gui()
%
% GUI for estimating the performance of single-object particle filter 
% tracker without using ground-truth data. Specifically, the performance 
% is estimated in terms of tracking condition {LOCKED-ON, LOCKING-IN, SCANNING} 
% and temporal segmentation {SUCCESSFUL, UNSUCCESSFULL} by analyzing the 
% uncertainty of the filter and the time-reversibility property. A
% description of the algorithm is available in:
%       "Adaptive on-line performance evaluation of video trackers"
%       J. SanMiguel, A. Cavallaro and J. Martínez
%       Submitted to IEEE Transactions on Image Processing 
%
% To run the algorithm, you have to fill the textboxes of the 'input data' 
% and 'settings' panels. Tracking data is displayed in the 'tracking data' 
% panel and it has to be previously generated using the function 
% 'pf_colortracker' available in:
% http://www-vpu.eps.uam.es/publications/TrackQuality
% The results of the tracking analysis is stored in a mat file that contains 
% a structure (named 'result'). It contains the following fields:
%           +'videofile': path of the input videofile
%           +'gtruthfile': path of the associated ground-truth
%           +'start_frame': start frame of the analyzed frames
%           +'end_frame': end frame o of the analyzed frames
%           +'N': number of samples (particles) used in the tracker
%           +'Q': target model used during the tracking process
%           +'Ck': noise of the motion model used in the prediction phase
%           +'w_par_N': weights of the particles
%           +'w_par_NN': particles likelihood (no normalized weights)
%           +'state_par': state of particles
%           +'state_est': state estimation for the target
%           +'der': ground-truth error (ellipse overlap)
%           +'OL': Observation likelihood statistic of the particles
%           +'SU': Spatial uncertainty statistic of the particles
%
% The obtained results are displayed in the 'tracker_performance' panel and
% consists of the uncertainty signals, tracker condition and temporal
% segmentation.
%
% The GUI doesn't have a return values. Tracker condition analysis are
% stored as a mat file using the 'Output File' textbox. This mat file has a
% structure (named 'result_pe') that contains all the information generated. 
% It has the following fields:
%           +'filename':path of the input videofile
%           +'gtruthfile':path of the associated ground-truth
%           +'N':number of particles used in the tracker
%           +'start_frame': start frame of the analyzed frames
%           +'end_frame': end frame o of the analyzed frames
%           +'error': ground-truth error (dice coefficient)
%           +'analysis': structure 'result' with the tracking data
%           +'config':parameter configuration
%           +'OL':observation likelihood statistic
%           +'SU':spatial uncertainty statistic
%           +'SU_ps: uncertainty signal maximized for detecting sudden increases
%           +'SU_pl: uncertainty signal maximized for detecting slow increases
%           +'SU_ns: uncertainty signal maximized for detecting sudden decreases
%           +'SU_ps: uncertainty signal maximized for detecting slow decreases
%           +'trk_cond':tracker condition vector {LOCKED-ON (1),LOCKING-IN(0.5), SCANNING(0)}
%           +'tracker_status': status of the tracker {SUCCESSFULL(1),UNSUCCESSFULL(0)}
%           +'RefP_upd':ignal that indicates the attemps to detect tracker
%            recovery after error {successful recovery (=1), wrong recovery
%           (=0.5)}.
%
% For further documentation please see the readme file.
%
%
% Author:   Juan C. San Miguel (Video Processing and Understanding Lab)
% E-mail:   juancarlos.sanmiguel@uam.es
% URL:      http://www-vpu.ii.uam.es/~jcs
% Date:     December 2010
% Version:  1.2
%
%| Modification/redistribution granted only for the purposes
%| of teaching, non-commercial research or study.
%
%| Copyright 2010 Juan Carlos San Miguel
%| University Autonoma of Madrid, Video Processing and Understanding Lab