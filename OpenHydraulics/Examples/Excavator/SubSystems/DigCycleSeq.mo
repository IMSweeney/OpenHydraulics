within OpenHydraulics.Examples.Excavator.SubSystems;

model DigCycleSeq
  import Modelica.Constants.pi;
  // the parameters
  parameter Modelica.SIunits.Frequency bandwidth = 10;
  parameter Modelica.SIunits.Time startTime = 1 "Time before excavator starts moving";
  parameter Real swingAmplitude = -1 "Amplitude of swing command";
  parameter Real boomAmplitude1 = -0.9 "Amplitude of first boom command";
  parameter Real boomAmplitude2 = 0.5 "Amplitude of second boom command";
  parameter Real armAmplitude1 = -1 "Amplitude of arm command";
  parameter Real armAmplitude2 = 0.3 "Amplitude of bucket command";
  //  parameter Real armAmplitude2 = 1 "Amplitude of bucket command";
  parameter Real bucketAmplitude1 = -0.7 "Amplitude of bucket command";
  parameter Real bucketAmplitude2 = 0.45 "Amplitude of bucket command";
  parameter Real bucketAmplitude3 = -1 "Amplitude of bucket command";
  // the components
  Modelica.Blocks.Tables.CombiTable1D swingTimeTable(table = [0, 0; 1, 0; 13, 0; 14, swingAmplitude; 17, swingAmplitude; 18, 0; 20, 0]) annotation(
    Placement(visible = true, transformation(origin = {-32, 84}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Continuous.SecondOrder swingFilter(w = 2 * pi * bandwidth) annotation(
    Placement(visible = true, transformation(extent = {{-2, 74}, {18, 94}}, rotation = 0)));
  Modelica.Blocks.Continuous.SecondOrder boomFilter(w = 2 * pi * bandwidth) annotation(
    Placement(visible = true, transformation(extent = {{2, 38}, {22, 58}}, rotation = 0)));
  Modelica.Blocks.Continuous.SecondOrder armFilter(w = 2 * pi * bandwidth) annotation(
    Placement(visible = true, transformation(extent = {{2, -84}, {22, -64}}, rotation = 0)));
  // auxiliary components
  Modelica.Blocks.Routing.Multiplex4 multiplex annotation(
    Placement(transformation(extent = {{54, -16}, {86, 16}})));
  Modelica.Blocks.Interfaces.RealOutput y1[4] "Connector of Real output signals" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{14, -14}, {-14, 14}}, rotation = 180)));
  Modelica.Blocks.Continuous.SecondOrder bucketFilter(w = 2 * pi * bandwidth) annotation(
    Placement(visible = true, transformation(extent = {{14, -138}, {34, -118}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1D boomTimeTable(table = [0, 0; 1, boomAmplitude1; 20, boomAmplitude1; 21, boomAmplitude2; 31, boomAmplitude2; 35, 0]) annotation(
    Placement(visible = true, transformation(origin = {132, 88}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Tables.CombiTable1D armTimeTable(table = [0, 0; 1, 0; 2, armAmplitude1; 30, armAmplitude1; 31, 0; 35, 0]) annotation(
    Placement(visible = true, transformation(origin = {132, 60}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Tables.CombiTable1D bucketTimeTable(table = [0, 0; 1, 0; 2, bucketAmplitude1; 30, bucketAmplitude1; 31, 0; 35, 0]) annotation(
    Placement(visible = true, transformation(origin = {132, 34}, extent = {{10, -10}, {-10, 10}}, rotation = 180)));
  Modelica.Blocks.Continuous.PID pid(Ti = 0.1, k = -1) annotation(
    Placement(visible = true, transformation(origin = {-6, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add err_bucketAngle(k2 = -1) annotation(
    Placement(visible = true, transformation(origin = {-36, -128}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput horizontalPos annotation(
    Placement(visible = true, transformation(origin = {-159, 7}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-102, 58}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput horizontalPosTip annotation(
    Placement(visible = true, transformation(origin = {-159, -131}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-98, 12}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput verticalPos annotation(
    Placement(visible = true, transformation(origin = {-159, -67}, extent = {{-13, -13}, {13, 13}}, rotation = 0), iconTransformation(origin = {-94, -44}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  Modelica.Blocks.Sources.Ramp ramp(duration = 30, height = -5, offset = 9, startTime = 1) annotation(
    Placement(visible = true, transformation(origin = {-206, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add err_horizontalPos(k1 = -1, k2 = +1) annotation(
    Placement(visible = true, transformation(origin = {-154, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = 0.2) annotation(
    Placement(visible = true, transformation(origin = {-81, -87}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain1(k = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-81, -63}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain2(k = -0.2) annotation(
    Placement(visible = true, transformation(origin = {-51, 29}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain3(k = 0.005) annotation(
    Placement(visible = true, transformation(origin = {-51, 55}, extent = {{-7, -7}, {7, 7}}, rotation = 0)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(visible = true, transformation(origin = {-16, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add1 annotation(
    Placement(visible = true, transformation(origin = {-16, -74}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant arm_vertical_switch(k = 7)  annotation(
    Placement(visible = true, transformation(origin = {-82, -20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Add add2(k2 = -1)  annotation(
    Placement(visible = true, transformation(origin = {-54, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Sign sign1 annotation(
    Placement(visible = true, transformation(origin = {-24, -14}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Product product annotation(
    Placement(visible = true, transformation(origin = {-46, -80}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Continuous.PID pid1(Ti = 0.1, k = 1)  annotation(
    Placement(visible = true, transformation(origin = {-122, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
protected
  SI.Time t "Input to tables";
equation
  t = if noEvent(time > startTime) then time - startTime else 0;
  swingTimeTable.u[1] = t;
  boomTimeTable.u[1] = t;
  armTimeTable.u[1] = t;
  bucketTimeTable.u[1] = t;
  connect(multiplex.y, y1) annotation(
    Line(points = {{87.6, 0}, {98, -3.1606e-021}, {98, 1.77636e-015}, {110, 1.77636e-015}}, color = {0, 0, 127}));
  connect(swingTimeTable.y[1], swingFilter.u) annotation(
    Line(points = {{-21, 84}, {-4, 84}}, color = {0, 0, 127}));
  connect(swingFilter.y, multiplex.u1[1]) annotation(
    Line(points = {{19, 84}, {34, 84}, {34, 14.4}, {50.8, 14.4}}, color = {0, 0, 127}));
  connect(armFilter.y, multiplex.u3[1]) annotation(
    Line(points = {{23, -74}, {28, -74}, {28, -4.8}, {50.8, -4.8}}, color = {0, 0, 127}));
  connect(boomFilter.y, multiplex.u2[1]) annotation(
    Line(points = {{23, 48}, {28, 48}, {28, 4.8}, {50.8, 4.8}}, color = {0, 0, 127}));
  connect(bucketFilter.y, multiplex.u4[1]) annotation(
    Line(points = {{35, -128}, {36, -128}, {36, -14.4}, {50.8, -14.4}}, color = {0, 0, 127}));
  connect(err_bucketAngle.y, pid.u) annotation(
    Line(points = {{-25, -128}, {-18, -128}}, color = {0, 0, 127}));
  connect(horizontalPosTip, err_bucketAngle.u2) annotation(
    Line(points = {{-159, -131}, {-114, -131}, {-114, -134}, {-48, -134}}, color = {0, 0, 127}));
  connect(horizontalPos, err_bucketAngle.u1) annotation(
    Line(points = {{-159, 7}, {-110, 7}, {-110, -122}, {-48, -122}}, color = {0, 0, 127}));
  connect(pid.y, bucketFilter.u) annotation(
    Line(points = {{5, -128}, {12, -128}}, color = {0, 0, 127}));
  connect(ramp.y, err_horizontalPos.u1) annotation(
    Line(points = {{-195, 54}, {-166, 54}}, color = {0, 0, 127}));
  connect(verticalPos, gain2.u) annotation(
    Line(points = {{-159, -67}, {-102, -67}, {-102, 29}, {-59, 29}}, color = {0, 0, 127}));
  connect(verticalPos, gain.u) annotation(
    Line(points = {{-159, -67}, {-123, -67}, {-123, -87}, {-89, -87}}, color = {0, 0, 127}));
  connect(add.u1, gain3.y) annotation(
    Line(points = {{-28, 54}, {-43, 54}, {-43, 55}}, color = {0, 0, 127}));
  connect(add.u2, gain2.y) annotation(
    Line(points = {{-28, 42}, {-43, 42}, {-43, 29}}, color = {0, 0, 127}));
  connect(add.y, boomFilter.u) annotation(
    Line(points = {{-5, 48}, {-1, 48}}, color = {0, 0, 127}));
  connect(gain1.y, add1.u1) annotation(
    Line(points = {{-73.3, -63}, {-28, -63}, {-28, -68}}, color = {0, 0, 127}));
  connect(horizontalPos, add2.u1) annotation(
    Line(points = {{-158, 8}, {-66, 8}, {-66, -8}}, color = {0, 0, 127}));
  connect(arm_vertical_switch.y, add2.u2) annotation(
    Line(points = {{-71, -20}, {-66, -20}}, color = {0, 0, 127}));
  connect(add2.y, sign1.u) annotation(
    Line(points = {{-42, -14}, {-36, -14}}, color = {0, 0, 127}));
  connect(add1.y, armFilter.u) annotation(
    Line(points = {{-4, -74}, {0, -74}}, color = {0, 0, 127}));
  connect(sign1.y, product.u1) annotation(
    Line(points = {{-12, -14}, {2, -14}, {2, -48}, {-68, -48}, {-68, -74}, {-58, -74}}, color = {0, 0, 127}));
  connect(gain.y, product.u2) annotation(
    Line(points = {{-74, -86}, {-58, -86}}, color = {0, 0, 127}));
  connect(product.y, add1.u2) annotation(
    Line(points = {{-34, -80}, {-28, -80}}, color = {0, 0, 127}));
  connect(horizontalPos, err_horizontalPos.u2) annotation(
    Line(points = {{-158, 8}, {-134, 8}, {-134, 28}, {-182, 28}, {-182, 42}, {-166, 42}}, color = {0, 0, 127}));
  connect(err_horizontalPos.y, pid1.u) annotation(
    Line(points = {{-142, 48}, {-134, 48}}, color = {0, 0, 127}));
  connect(pid1.y, gain3.u) annotation(
    Line(points = {{-110, 48}, {-108, 48}, {-108, 55}, {-59, 55}}, color = {0, 0, 127}));
  connect(pid1.y, gain1.u) annotation(
    Line(points = {{-110, 48}, {-106, 48}, {-106, -62}, {-90, -62}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics),
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}), Text(extent = {{-100, 60}, {10, 20}}, textString = "Dig "), Text(extent = {{-100, 20}, {10, -20}}, textString = "Cycle"), Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{0, -12}, {60, -28}}, textString = "Arm"), Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{60, 28}, {0, 12}}, textString = "Boom"), Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{60, 68}, {0, 52}}, textString = "Swing"), Text(fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{0, -52}, {60, -68}}, textString = "Bucket"), Text(extent = {{-100, -20}, {10, -60}}, textString = "Traj"), Line(points = {{60, 60}, {96, 0}}), Line(points = {{96, 0}, {60, 20}}), Line(points = {{96, 0}, {60, -20}}), Line(points = {{60, -60}, {96, 0}})}));
end DigCycleSeq;
