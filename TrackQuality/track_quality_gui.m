function varargout = track_quality_gui(varargin)
% track_quality_gui()
%
% GUI for estimating the track quality of single-object particle filter 
% tracker without using ground-truth data. Specifically, the performance 
% is estimated using a time-reversed tracker (the time-reversibility
% property) and comparing the tracking data between the forward and reverse
% trackers in terms of spatial and feature distances. A description of the 
% algorithm is available in:
%       "Adaptive on-line performance evaluation of video trackers"
%       J. SanMiguel, A. Cavallaro and J. Martínez
%       Submitted to IEEE Transactions on Image Processing 
%
% To run the algorithm, you have to fill the textboxes of the 'input data' 
% and 'settings' panels. Tracking condition is displayed in the 'tracking 
% condition'  panel and it has to be previously generated using the tracker 
% condition estimator tool available in the webpage:
% http://www-vpu.eps.uam.es/publications/TrackQuality
% The results of the previous tracker condition analysis is stored in a mat 
% file that contains a structure (named 'result_pe'). It contains the 
% following fields:
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
% The obtained results are displayed in the 'tracker quality' panel and
% consists of the distances applied and their combination.
%
% The GUI doesn't have a return values. Track quality analysis are
% stored as a mat file using the 'Output File' textbox. This mat file has a
% structure (named 'result_pe_q') that contains all the information generated. 
% It has the following fields:
%           +'filename':path of the input videofile
%           +'gtruthfile':path of the associated ground-truth
%           +'N':number of particles used in the tracker
%           +'start_frame': start frame of the analyzed frames
%           +'end_frame': end frame o of the analyzed frames
%           +'error': ground-truth error (dice coefficient)
%           +'analysis': structure 'result' with the tracking data
%           +'analysis_cond': structure 'result_pe' with the tracker
%           condition
%           +'config_trk_cond': configuration of the tracker condition
%           estimation
%           +'config_trk_q': configuration of the track quality estimation
%           +'QTRK': structure that contains the track quality analysis
%           performed for each frame. It contains:
%               - 'StatFB1': spatial distance at the reference frame
%               - 'StatFB2': mean spatial distance between the
%               forward-reverse trackers
%               - 'StatOL': feature distance
%
% For further documentation please see the readme file.
%
% Author:   Juan C. San Miguel (Video Processing and Understanding Lab)
% E-mail:   juancarlos.sanmiguel@uam.es
% URL:      http://www-vpu.ii.uam.es/~jcs
% Date:     December 2010
% Version:  1.0
%
%| Modification/redistribution granted only for the purposes
%| of teaching, non-commercial research or study.
%
%| Copyright 2010 Juan Carlos San Miguel
%| University Autonoma of Madrid, Video Processing and Understanding Lab