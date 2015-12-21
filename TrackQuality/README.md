# Software implementation for Track quality estimation

## Overview 

GUI for estimating the track quality of single-object particle filter tracker without using ground-truth data. Specifically, the performance  is estimated by using a time-reversed tracker (the time-reversibility property) and comparing the tracking data between the forward and reverse trackers in terms of spatial and feature distances

## License and Citation

This software is released under the [Academic Public License](https://github.com/vpulab/trackquality-arte/blob/master/TrackQuality/LICENSE).

Please cite the following publication if this software helps your research:


    @article{sanmiguel2012TIP,
      Author = {J. SanMiguel and A. Cavallaro and J. Martínez},
      Journal = {IEEE Transactions on Image Processing },
      Title = {Adaptive on-line performance evaluation of video trackers},
      Year = {2012},
      number = {21},
      issue = {5},
      pages = {2812-2823},
      Month = {May}
    }
    

## Requirements

This tool was successfully tested under MS Windows (32-bit and 64-bit) and linux (32-bit).
It requires the MATLAB image processing toolbox.

## Installation

Make sure MATLAB can find all of the scripts that are
included by either making their directory the current directory
or including it in the MATLAB path.

## Running the GUI

Run the GUI by executing the following command in MATLAB:

	track_quality_gui();

See 'help track_quality_gui' for explanation of the usage of the interface.
Additionally, a 'help' button is included in the interface.

## User Interface

After starting the GUI (see above), you have four interactive areas:
 - Input/output data panel: path to the files with the data to be used by the 
							application and the files where the result will be stored.
 - Settings panel: parameters of the implemented algorithm. Controls of processing (start and stop)
 - Tracker data panel: shows the preloaded tracking data results (single-target tracking)
 - Tracker performance panel: shows the tracker condition estimated and the uncertainty analysis.
 - Track quality panel: shows the estimated quality of the current track.

## Input specifications

The data used by the application is the following: 
		- Test sequence: uncompressed video vile in AVI format with all the sequence frames
		- Ground-truth annotation: text file with the annotations of the target in the format:	
			<FRAME ID_OBJECT CENTER_X CENTER_Y A B O> where CENTER_X, CENTER_Y, A, B and O represent, 
			respectively, the center coordinates, the major semiaxes, the minor semiaxes and the orientation 
			of the annotated ellipse.
		- Datafile: path to the *.mat file that contains the structure with
		the tracking condition data (named 'result_pe') obtained with the tracker condition estimation tool 
		available in http://www-vpu.eps.uam.es/publications/TrackQuality.
		The structure contains the following fields:
           +'filename':path of the input videofile
           +'gtruthfile':path of the associated ground-truth
           +'N':number of particles used in the tracker
           +'start_frame': start frame of the analyzed frames
           +'end_frame': end frame o of the analyzed frames
           +'error': ground-truth error (dice coefficient)
           +'analysis': structure 'result' with the tracking data
           +'config':parameter configuration
           +'OL':observation likelihood statistic
           +'SU':spatial uncertainty statistic
           +'SU_ps: uncertainty signal maximized for detecting sudden increases
           +'SU_pl: uncertainty signal maximized for detecting slow increases
           +'SU_ns: uncertainty signal maximized for detecting sudden decreases
           +'SU_ps: uncertainty signal maximized for detecting slow decreases
           +'trk_cond':tracker condition vector {LOCKED-ON (1),LOCKING-IN(0.5), SCANNING(0)}
           +'tracker_status': status of the tracker {SUCCESSFULL(1),UNSUCCESSFULL(0)}
           +'RefP_upd':ignal that indicates the attemps to detect tracker
            recovery after error {successful recovery (=1), wrong recovery (=0.5)}.

## Output specifications

 The GUI doesn't have a return values. Track quality analysis are
 stored as a mat file using the 'Output File' textbox. This mat file has a
 structure (named 'result_pe_q') that contains all the information generated. 
 It has the following fields:
           +'filename':path of the input videofile
           +'gtruthfile':path of the associated ground-truth
           +'N':number of particles used in the tracker
           +'start_frame': start frame of the analyzed frames
           +'end_frame': end frame o of the analyzed frames
           +'error': ground-truth error (dice coefficient)
           +'analysis': structure 'result' with the tracking data
           +'analysis_cond': structure 'result_pe' with the tracker
           condition
           +'config_trk_cond': configuration of the tracker condition
           estimation
           +'config_trk_q': configuration of the track quality estimation
           +'QTRK': structure that contains the track quality analysis
           performed for each frame. It contains:
               - 'StatFB1': spatial distance at the reference frame
               - 'StatFB2': mean spatial distance between the
               forward-reverse trackers
               - 'StatOL': feature distance
