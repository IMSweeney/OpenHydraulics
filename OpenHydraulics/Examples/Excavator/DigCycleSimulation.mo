within OpenHydraulics.Examples.Excavator;

model DigCycleSimulation
  extends Modelica.Icons.Example;
  OpenHydraulics.Examples.Excavator.SubSystems.MechanicsBody_noFriction mechanicsBody(swing_phi_start = 0, swing_initType = Modelica.Mechanics.MultiBody.Types.Init.PositionVelocity, boom_phi_start = 0.87266462599716, arm_phi_start = -1.3962634015955, bucket_phi_start = 0.34906585039887) annotation(
    Placement(visible = true, transformation(extent = {{10, -33}, {98, 46}}, rotation = 0)));
  OpenHydraulics.Examples.Excavator.SubSystems.HydraulicsSubSyst hydraulics(redeclare OpenHydraulics.Fluids.GenericOilSimple oil, arm_s_init = 0.15, boom_s_init = 0.25, bucket_s_init = 0.7) annotation(
    Placement(transformation(extent = {{-6, -18}, {-46, 22}})));
  inner Modelica.Mechanics.MultiBody.World world annotation(
    Placement(transformation(extent = {{10, -60}, {30, -40}})));
  OpenHydraulics.Examples.Excavator.SubSystems.DigCycleSeq digCycleSeq(armAmplitude1 = .03, armAmplitude2 = 0, boomAmplitude1 = 0.02, boomAmplitude2 = -0.02, bucketAmplitude1 = -0.025, bucketAmplitude2 = 0, bucketAmplitude3 = 0, swingAmplitude = 0) annotation(
    Placement(transformation(extent = {{-98, -18}, {-56, 22}})));
equation
  connect(hydraulics.ArmCylRod, mechanicsBody.cylArmRod) annotation(
    Line(points = {{-30.8, 22}, {-30, 22}, {-30, 50}, {48, 50}, {48, 34}, {51, 34}}, color = {0, 127, 0}));
  connect(hydraulics.ArmCylBase, mechanicsBody.cylArmBase) annotation(
    Line(points = {{-26.8, 22}, {-26, 22}, {-26, 46}, {44, 46}, {44, 34}, {47, 34}}, color = {0, 127, 0}));
  connect(world.frame_b, mechanicsBody.baseFrame) annotation(
    Line(points = {{30, -50}, {37, -50}, {37, -20}}, color = {95, 95, 95}, thickness = 0.5));
  connect(hydraulics.BoomCylRodL, mechanicsBody.cylBoomLeftRod) annotation(
    Line(points = {{-6, 14.8}, {12, 14.8}, {12, 16}}, color = {0, 127, 0}));
  connect(hydraulics.BoomCylBaseL, mechanicsBody.cylBoomLeftBase) annotation(
    Line(points = {{-6, 10.8}, {12, 10.8}, {12, 12}}, color = {0, 127, 0}));
  connect(hydraulics.BoomCylRodR, mechanicsBody.cylBoomRightRod) annotation(
    Line(points = {{-21.2, 22}, {-21.2, 38}, {2, 38}, {2, -26}, {53, -26}, {53, -21}}, color = {0, 127, 0}));
  connect(hydraulics.BoomCylBaseR, mechanicsBody.cylBoomRightBase) annotation(
    Line(points = {{-17.2, 22}, {-18, 22}, {-18, 34}, {0, 34}, {0, -30}, {46, -30}, {46, -21}, {49, -21}}, color = {0, 127, 0}));
  connect(digCycleSeq.y1, hydraulics.Command) annotation(
    Line(points = {{-53.9, 2}, {-50.85, 2}, {-47.8, 2}}, color = {0, 0, 127}));
  connect(hydraulics.BucketCylBase, mechanicsBody.cylBucketBase) annotation(
    Line(points = {{-37.2, 22}, {-38, 22}, {-38, 54}, {80, 54}, {80, 34}}, color = {0, 127, 0}));
  connect(hydraulics.BucketCylRod, mechanicsBody.cylBucketRod) annotation(
    Line(points = {{-41.2, 22}, {-42, 22}, {-42, 58}, {84, 58}, {84, 34}}, color = {0, 127, 0}));
  connect(hydraulics.SwingFlange, mechanicsBody.swingFlange) annotation(
    Line(points = {{-9.2, 22}, {-9.2, 30}, {4, 30}, {4, -18}, {12, -18}}));
  connect(mechanicsBody.horizontalPos, digCycleSeq.horizontalPos) annotation(
    Line(points = {{108, -22}, {118, -22}, {118, -94}, {-136, -94}, {-136, 14}, {-98, 14}}, color = {0, 0, 127}));
  connect(mechanicsBody.verticalPos, digCycleSeq.verticalPos) annotation(
    Line(points = {{108, -14}, {128, -14}, {128, -86}, {-128, -86}, {-128, -6}, {-96, -6}}, color = {0, 0, 127}));
  connect(mechanicsBody.horizontalPosTip, digCycleSeq.horizontalPosTip) annotation(
    Line(points = {{104, -10}, {138, -10}, {138, -76}, {-120, -76}, {-120, 4}, {-98, 4}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics),
    experiment(StopTime = 20, Tolerance = 1e-008),
  __OpenModelica_simulationFlags(lv = "LOG_STATS", s = "dassl"));
end DigCycleSimulation;
