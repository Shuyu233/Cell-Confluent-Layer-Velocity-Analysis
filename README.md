# Cell-Confluent-Layer-Velocity-Analysis
After getting several movies of monolayer movement, use this series of program to get the correlation functions, mean-square-displacement, and velocity distribution etc.
## File Function Discription
- Preprocess of movies

 > _AdjustContrast.m_ Enhance Contrast of the original movies.
 
 > _MovieCut.m_ Reduce several frames in the movie

- Calculation of velocity field (Optical Flow Package)

 > _DIC_ROI.m_, _DriveOF.m_, _OpticalFlow.m_
 
- Postprocess of velocity field

 > _CorrelationNew.m_ Calculate the spatial correlation function of the velocity field averaged over all the frames.
 
 > _PositionInfo.mat_ Contains mapping info of data and distance(Map) and the distance of every point(R_Set)
 
 > _SubOdd.m_ A function to eliminate the velocity points caused by pollutions out of the monolayer
 
 > _StatisticalAnaysis.m_ Calculate the velocity distributiion of the monolayer
 
 > _PlotCorrelationCurve.m_ Plot the Correlation Function using data got from the _CorrelationNew.m_
 
- Other files
 
 > _FoldedProgram0215_filter.m_ A program to run the programs simutanously.
 
 > _Ellipse.m_ Drawing a ellipse to the plot.
 
 > _MSD.m_ Calculated the mean square displacement (need poisition data of the cells)

 > _GeneratePositionInfo.m_ Generate PositionInfo.mat
