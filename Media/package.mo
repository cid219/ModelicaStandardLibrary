package Media "Property models of media"
extends Modelica.Icons.Library;
import SI = Modelica.SIunits;


annotation (
  version="0.95",
  versionDate="2005-01-24",
  preferedView="info",
  Settings(NewStateSelection=true),
  uses(Modelica(version="2.1")),
  Documentation(info="<HTML>
<p>
This library contains <a href=\"Modelica:Modelica.Media.Interfaces\">interface</a> 
definitions for media and the following <b>property</b> models for
single and multiple substance fluids with one and multiple phases:
</p>
<ul>
<li> <a href=\"Modelica:Modelica.Media.IdealGases\">Ideal gases:</a><br>
     1241 high precision gas models based on the
     NASA Glenn coefficients, plus ideal gas mixture models based 
     on the same data.</li>
<li> <a href=\"Modelica:Modelica.Media.Water\">Water models:</a><br>
     ConstantPropertyLiquidWater, WaterIF97 (high precision
     water model according to the IAPWS/IF97 standard)</li>
<li> <a href=\"Modelica:Modelica.Media.Air\">Air models:</a><br>
     SimpleAir, DryAirNasa, and MoistAir</li>
<li> <a href=\"Modelica:Modelica.Media.Incompressible\">
     Incompressible media:</a><br>
     TableBased (template medium for user defined properties from tables rho(T),
     HeatCapacity_cp(T), etc.)</li>
</ul>
<p>
The following parts are useful, when newly starting with this library:
<ul>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide\">Modelica.Media.UsersGuide</a>.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage\">Modelica.Media.UsersGuide.MediumUsage</a> 
     describes how to use a medium model in a component model.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition\">
     Modelica.Media.UsersGuide.MediumDefinition</a> 
     describes how a new fluid medium model has to be implemented.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.ReleaseNotes\">Modelica.Media.UsersGuide.ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li> <a href=\"Modelica:Modelica.Media.Examples\">Modelica.Media.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>

<p>
Copyright &copy; 1998-2005, Modelica Association.
</p>
<p>
<i>The Modelica package is <b>free</b> software; it can be redistributed and/or modified
under the terms of the <b>Modelica license</b>, see the license conditions
and the accompanying <b>disclaimer</b> 
<a href=\"Modelica://Modelica.UsersGuide.ModelicaLicense\">here</a>.</i>
</p><br>

</HTML>"),
  conversion(from(version="0.795", script=
          "../ConvertFromModelica.Media_0.795.mos")));


package UsersGuide "User's Guide" 
  annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>User's Guide of package Modelica.Media</font></h3>
<p>
Library <b>Modelica.Media</b> is a <b>free</b> Modelica package providing
a standardized interface to fluid media models and specific
media models based on this interface.
A fluid medium model defines <b>algebraic</b> equations
for the intensive thermodynamic variables used in the <b>mass</b>
and <b>energy</b> balance of component models. Optionally, additional
medium properties can be computed such as dynamic viscosity or thermal
conductivity. Medium models are defined for <b>single</b> and 
<b>multiple substance</b> fluids with <b>one</b> and 
<b>multiple phases</b>. 
</p>
<p>
A large part of the library provides specific medium models
that can be directly utilized. This library can be used in
all types of Modelica fluid libraries that may have different connectors
and design philosophies. It is particularily utilized
in the Modelica_Fluid library (the Modelica_Fluid library is currently
under development to provide 1D thermo-fluid flow components for
single and multiple substance flow with one and multiple phases). 
The Modelica.Media library has the following
main features:
</p>
<ul>
<li> Balance equations and media model equations
     are decoupled.
     This means that the used medium model does usually not have an
     influence on how the balance equations are formulated.
     For example, the same balance equations are used for media
     that use pressure and temperature, or pressure and specific
     enthalpy as independent variables, as well as for
     incompressible and compressible media models.
     A Modelica tool will have enough information to
     generate as efficient code as a traditional
     (coupled) definition. This feature is described in more
     detail in section 
     <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">Static State Selection</a>.</li>
<li> Optional variables, such as dynamic viscosity, are only computed if
     needed in the corresponding component.</li>
<li> The independent variables of a medium model do not
     influence the definition of a fluid connector port.
     Especially, the media models are implemented in such a way
     that a connector may have the minimum number of independent
     medium variables in a connector and still get the same
     efficiency as if all medium variables are passed by the
     connector from one component to the next one (the latter
     approach has the restriction that a fluid port can only
     connect two components and not more). Note, the Modelica_Fluid
     library uses the first approach, i.e., having a set of
     independent medium variables in a connector.</li>
<li> The medium models are implemented with regards to
     efficient dynamic simulation. For example, two phase
     medium models trigger state events at phase boundaries
     (because the medium variables are not differentiable
     at this point).</li>
</ul>
<p>
This Users Guide has the following main parts:
</p>
<ul>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage\">Medium usage</a> 
     describes how to use a medium model from
     this library in a component model.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition\">Medium definition</a> 
     describes how a new fluid medium
     model has to be implemented.</li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.ReleaseNotes\">ReleaseNotes</a>
     summarizes the changes of the library releases.</li>
<li><a href=\"Modelica://Modelica.Media.UsersGuide.Contact\">Contact</a> 
    provides information about the authors of the library as well as
    acknowledgements.</li>
</ul>
</HTML>"));
  
  package MediumUsage "Medium usage" 
    annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Using a fluid medium model</font></h3>
<p>
Content:
</p>
<ol>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.BasicUsage\">
      Basic usage of medium model</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.BalanceVolume\">
      Medium model for a balance volume</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.ShortPipe\">
      Medium model for a pressure loss</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.OptionalProperties\">
     Optional medium properties</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.TwoPhase\">
     Two-phase media</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.BoundaryConditions\">
     Medium boundary conditions</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumUsage.Constants\">
     Constants provided by medium model</a></li>
</ol>

<p>
A good demonstration how to use the media from Modelica.Media is
given in package Modelica.Media.Examples.Tests. Under Tests.Components
the most basic components of a Fluid library are defined. Under
Tests.MediaTestModels these basic components are used to test
all media models with some very simple piping networks.
</p>
</HTML>"));
    
    class BasicUsage "Basic usage" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic usage of medium model</font></h3>
<p>
Media models in Modelica.Media are provided by packages, inheriting from the
partial package Modelica.Media.Interfaces.PartialMedium. Every package defines:
<ul>
<li> Medium <b>constants</b> (such as the number of chemical substances, 
     molecular data, critical properties, etc.).
<li> A BaseProperties <b>model</b>, to compute the basic thermodynamic 
     properties of the fluid;
<li> <b>Functions</b> to compute additional properties (such as saturation 
     properties, viscosity, thermal conductivity, etc.).
</ul>
Every instance of BaseProperties for any medium model provides <b>3+nX_i 
equations</b> for the following <b>5+nX_i variables</b> that are declared in 
the medium model (nX_i is the number of independent mass fractions, see
explanation below):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy (h = u + p/d)</td></tr>
  <tr><td>X_i[nX_i]</td>
      <td>kg/kg</td>
      <td>independent mass fractions m_i/m</td></tr>
</table>
<p>
<b>Two</b> variables out of p, d, h, or u, as well as the
<b>mass fractions</b> X_i are the <b>independent</b> variables and the
medium model basically provides equations to compute
the remaining variables. 
<p>
If a fluid consists of a single
substance, <b>nX_i = 0</b> and the vector of mass fractions X_i is not
present. If a fluid consists of nS substances,
the medium model may either define the number of independent
mass fractions <b>nX_i</b> to be <b>nS</b> or to be <b>nS-1</b>. 
In both cases, balance equations for nX_i substances have to be
given in the corresponding component (see discussion below).
Note, that if nX_i = nS, the constraint \"sum(X_i)=1\" between the mass 
fractions is <b>not</b> present in the model; in that case, it is necessary to 
provide consistent start values for X_i such that sum(X_i) = 1.
</p>
<p>
The full vector of mass fractions <b>X[nX]</b> is also provided by the medium 
model. For single-substance media, nX = 0, so there's also no X vector. For 
multiple-substance media, nX = nS, and X always contains the full vector of 
mass fractions.
</p>
<p>
In a component, the most basic usage of a medium model is as follows
</p>
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
    Medium.BaseProperties medium_a \"Medium properties at location a (e.g. port_a)\";
    // Use medium variables (medium_a.p, medium_a.T, medium_a.h, ...)
     ...
  <b>end</b> Pump;
</pre>
<p>
All media models are directly or indirectly a subpackage of package
Modelica.Media.Interfaces.PartialMedium. Therefore,
a medium model in a component should inherit from this
partial package. Via the annotation \"choicesAllMatching = true\" it
is defined that the tool should display a selection box with
all loaded packages that inherit from PartialMedium. An example
is given in the next figure:
</p>
<IMG SRC=\"../Images/Media/UsersGuide/mediumMenu.png\" ALT=\"medium selection menu\">
<p>
A selected medium model leads, e.g., to the following equation:
</p>
<pre>
  Pump pump(<b>redeclare package</b> Medium = Modelica.Media.Water.SimpleLiquidWater);
</pre>
<p>
Usually, a medium model is associated with the variables of a
fluid connector. Therefore, equations have to be defined in a model
that relate the variables in the connector with the variables
in the medium model:
</p>
<pre>
  <b>model</b> Pump
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);
    Medium.BaseProperties medium_a \"Medium properties of port_a\";
    // definition of the fluid port port_a
     ...
  <b>equation</b>
    medium.p = port_a.p;
    medium.h = port_a.h;
    medium.X_i = port_a.X_i;
     ...
  <b>end</b> Pump;
</pre>
<p>
If a component model shall treat both single and multiple
substance fluids, equations for the mass fractions have to be
present (above: medium.X_i = port_a.X_i) in the model. According
to the Modelica semantics, the equations of the mass fractions
are ignored, if the dimension of X_i is zero, i.e., for a single-component
medium. Note, by specific techniques sketched in section
\"Medium definition\", the independent variables in the medium model
need not to be the same as the variables in the connector and still
get the same efficiency, as if the same variables would be used.
</p>
</HTML>"));
    end BasicUsage;
    
    class BalanceVolume "Balance volume" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Medium model for a balance volume</font></h3>
<p>
Fluid libraries usually have balance volume components with one fluid connector
port that fulfill the mass and energy balance and on a different grid components that
fulfill the momentum balance. A balance volume component, called junction
volume below, should be primarily implemented in the following way
(see also the implementation in 
<a href=\"Modelica:Modelica.Media.Examples.Tests.Components.PortVolume\">
Modelica.Media.Examples.Tests.Components.PortVolume</a>):
</p>
<pre>
  <b>model</b> JunctionVolume
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components.FluidPort_a;

    <b>parameter</b> SI.Volume V = 1e-6 \"Fixed size of junction volume\";
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);

    FluidPort_a port(<b>redeclare package</b> Medium = Medium);
    Medium.BaseProperties medium(preferredMediumStates = <b>true</b>);

    SI.Energy U               \"Internal energy of junction volume\";
    SI.Mass   M               \"Mass of junction volume\";
    SI.Mass   MX[Medium.nX_i] \"Independent substance masses of junction volume\";
  <b>equation</b>
    medium.p   = port.p;
    medium.h   = port.h;
    medium.X_i = port.X_i;

    M  = V*medium.d;                  // mass of JunctionVolume
    MX = M*medium.X_i;                // mass fractions in JunctionVolume
    U  = M*medium.u;                  // internal energy in JunctionVolume

    <b>der</b>(M)  = port.m_flow;    // mass balance
    <b>der</b>(MX) = port.mX_flow;   // substance mass balance
    <b>der</b>(U)  = port.H_flow;    // energy balance
  <b>end</b> JunctionVolume;
</pre>
<p>
Assume the Modelica.Media.Air.SimpleAir medium model is used with
the JunctionVolume model above. This medium model uses pressure p
and temperature T as independent variables. If the flag
\"preferredMediumStates\" is set to <b>true</b> in the declaration
of \"medium\", then the independent variables of this medium model
get the attribute \"stateSelect = StateSelect.prefer\", i.e., the
Modelica translator should use these variables as states, if this
is possible. Basically, this means that
constraints between the
potential states p,T and the potential states U,M are present.
A Modelica tool will therefore <b>automatically</b>
differentiate medium equations and will use the following
equations for code generation (note the equations related to X are
removed, because SimpleAir consists of a single substance only):
</p>
<pre>
    M  = V*medium.d;
    U  = M*medium.u;

    // balance equations
    <b>der</b>(M)  = port.m_flow;
    <b>der</b>(U)  = port.H_flow;

    // abbreviations introduced to get simpler terms
    p = medium.p;
    T = medium.T;
    d = medium.d;
    u = medium.u;
    h = medium.h;

    // medium equations
    d = fd(p,T);
    h = fh(p,T);
    u = h - p/d;

    // equations derived <b>automatically</b> by a Modelica tool due to index reduction
    <b>der</b>(U) = <b>der</b>(M)*u + M*<b>der</b>(u);
    <b>der</b>(M) = V*<b>der</b>(d);
    <b>der</b>(u) = <b>der</b>(h) - <b>der</b>(p)/d - p/<b>der</b>(d);
    <b>der</b>(d) = <b>der</b>(fd,p)*<b>der</b>(p) + <b>der</b>(fd,T)*<b>der</b>(T);
    <b>der</b>(h) = <b>der</b>(fh,p)*<b>der</b>(p) + <b>der</b>(fd,T)*<b>der</b>(T);
</pre>
<p>
Note, that \"der(y,x)\" is an operator that characterizes
in the example above the partial derivative of y with respect to x
(this operator will be included in one of the next Modelica language
releases).
All media models in this library are written in such a way that
at least the partial derivatives of the medium variables with
respect to the independent variables are provided, either because
the equations are directly given (= symbolic differentiation is possible)
or because the derivative of the corresponding function (such as fd above)
is provided. A Modelica tool will transform the equations above
in differential equations with p and T as states, i.e., will
generate equations to compute <b>der</b>(p) and <b>der</b>(T) as function of p and T.
</p>

<p>
Note, when preferredMediumStates = <b>false</b>, no differentiation
will take place and the Modelica translator will use the variables
appearing differentiated as states, i.e., M and U. This has the
disadvantage that for many media non-linear systems of equations are
present to compute the intrinsic properties p, d, T, u, h from
M and U.
</p>
</HTML>"));
    end BalanceVolume;
    
    class ShortPipe "Short pipe" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Medium model for a short pipe</font></h3>
<p>
Fluid libraries have components with two ports that store
neither mass nor energy and fulfill the
momentum equation between their two ports, e.g., a short pipe. In most
cases this means that an equation is present relating the pressure
drop between the two ports and the mass flow rate from one to the
other port. Since no mass or energy is stored, no differential
equations for thermodynamic variables are present. A component model of this type
has therefore usually the following structure
(see also the implementation in 
<a href=\"Modelica:Modelica.Media.Examples.Tests.Components.ShortPipe\">
Modelica.Media.Examples.Tests.Components.ShortPipe</a>):
</p>
<pre>
  <b>model</b> ShortPipe
    <b>import</b> SI=Modelica.SIunits;
    <b>import</b> Modelica.Media.Examples.Tests.Components;

    // parameters defining the pressure drop equation

    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                           \"Medium model\" <b>annotation</b> (choicesAllMatching = <b>true</b>);

    Component.FluidPort_a port_a (<b>redeclare package</b> Medium = Medium);
    Component.FluidPort_b port_b (<b>redeclare package</b> Medium = Medium);

    SI.Pressure dp = port_a.p - port_b.p \"Pressure drop\";
    Medium.BaseProperties medium_a \"Medium properties in port_a\";
    Medium.BasePropreties medium_b \"Medium properties in port_b\";
  <b>equation</b>
    // define media models of the ports
    medium_a.p   = port_a.p;
    medium_a.h   = port_a.h;
    medium_a.X_i = port_a.X_i;

    medium_b.p   = port_b.p;
    medium_b.h   = port_b.h;
    medium_b.X_i = port_b.X_i;

    // Handle reverse and zero flow (semiLinear is a built-in Modelica operator)
    port_a.H_flow   = <b>semiLinear</b>(port_a.m_flow, port_a.h, port_b.h);
    port_a.mXi_flow = <b>semiLinear</b>(port_a.m_flow, port_a.X_i, port_b.X_i);

    // Energy, mass and substance mass balance
    port_a.H_flow + port_b.H_flow = 0;
    port_a.m_flow + port_b.m_flow = 0;
    port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nX_i);

    // Provide equation: port_a.m_flow = f(dp)
  <b>end</b> ShortPipe;
</pre>

<p>
The <b>semiLinear</b>(..) operator is basically defined as:
</p>
<pre>
    semiLinear(m_flow, ha, hb) = if m_flow &ge; 0 then m_flow*ha else m_flow*hb;
</pre>

<p>
that is, it computes the enthalpy flow rate either from the port_a or
from the port_b properties, depending on flow direction. The exact
details of this operator are given in
<a href=\"Modelica:ModelicaReference.Operators.SemiLinear\">
ModelicaReference.Operators.SemiLinear</a>. Especially, rules
are defined in the Modelica specification that m_flow = 0 can be treated 
in a \"meaningful way\". Especially, if n fluid components (such as pipes)
are connected together and the fluid connector from above is used, 
a linear system of equations appear between 
medium1.h, medium2.h, medium3.h, ..., port1.h, port2.h, port3.h, ...,
port1.H_flow, port2.H_flow, port3.H_flow, .... The rules for the
semiLinear(..) operator allow the following solution of this
linear system of equations:
</p>

<ul>
<li> n = 2 (two components are connected):<br>
     The linear system of equations can be analytically solved
     with the result
     <pre>
     medium1.h = medium2.h = port1.h = port2.h
     0 = port1.H_flow + port2.H_flow
     </pre>
     Therefore, no problems with zero mass flow rate are present.</li>

<li> n &gt; 2 (more than two components are connected together):<br>
     The linear system of equations is solved numerically during simulation. 
     For m_flow = 0, the linear system becomes singular and has an 
     infinite number of solutions. The simulator could use the solution t
     that is closest to the solution in the previous time step 
     (\"least squares solution\"). Physically, the solution is determined 
     by diffusion which is usually neglected. If diffusion is included,
     the linear system is regular.</li>
</ul>
     
</HTML>"));
    end ShortPipe;
    
    class OptionalProperties "Optional properties" 
      
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Optional medium properties</font></h3>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in the following table. They are
defined as partial functions within package 
<a href=\"Modelica:Modelica.Media.Interfaces.PartialMedium\">PartialMedium</a>,
and then (optionally) implemented in actual medium packages.
If a component calls such an optional function and the
medium package does not provide a new implementation for this
function, an error message is printed at translation time,
since the function is \"partial\", i.e., incomplete.
The argument of all functions is the <b>state</b> record,
automatically defined by the BaseProperties model, which contains the 
minimum number of thermodynamic variables needed to compute all the additional
properties. In the table it is assumed that there is a declaration of the
form:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
   Medium.BaseProperties medium;
</pre>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Medium.dynamicViscosity(medium.state)</b></td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>Medium.thermalConductivity(medium.state)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>Medium.prandtlNumber(medium.state)</td>
      <td>1</td>
      <td>Prandtl number</td></tr>
  <tr><td>Medium.specificEntropy(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>Medium.heatCapacity_cp(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant pressure</td></tr>
  <tr><td>Medium.heatCapacity_cv(medium.state)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant density</td></tr>
  <tr><td>Medium.isentropicExponent(medium.state)</td>
      <td>1</td>
      <td>isentropic exponent</td></tr>
  <tr><td>Medium.isentropicEnthatlpy(pressure, medium.state)</td>
      <td>J/kg</td>
      <td>isentropic enthalpy</td></tr>
  <tr><td>Medium.velocityOfSound(medium.state)</td>
      <td>m/s</td>
      <td>velocity of sound</td></tr>
  <tr><td>Medium.isobaricExpansionCoefficient(medium.state)</td>
      <td>1/K</td>
      <td>isobaric expansion coefficient</td></tr>
  <tr><td>Medium.isothermalCompressibility(medium.state)</td>
      <td>1/Pa</td>
      <td>isothermal compressibility</td></tr>
  <tr><td>Medium.density_derp_h(medium.state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant enthalpy</td></tr>
  <tr><td>Medium.density_derh_p(medium.state)</td>
      <td>kg2/(m3.J)</td>
      <td>derivative of density by enthalpy at constant pressure</td></tr>
  <tr><td>Medium.density_derp_T(medium.state)</td>
      <td>kg/(m3.Pa)</td>
      <td>derivative of density by pressure at constant temperature</td></tr>
  <tr><td>Medium.density_derT_p(medium.state)</td>
      <td>kg/(m3.K)</td>
      <td>derivative of density by temperature at constant pressure</td></tr>
  <tr><td>Medium.density_derX(medium.state)</td>
      <td>kg/m3</td>
      <td>derivative of density by mass fraction</td></tr>
  <tr><td>Medium.molarMass(medium.state)</td>
      <td>kg/mol</td>
      <td>molar mass</td></tr>
</table>
<p>
Assume for example that the dynamic viscosity eta is needed in
the pressure drop equation of a short pipe. Then, the
model of a short pipe has to be changed to:
</p>
<pre>
  <b>model</b> ShortPipe
      ...
    Medium.BaseProperties medium_a \"Medium properties in port_a\";
    Medium.BaseProperties medium_b \"Medium properties in port_b\";
      ...
    Medium.DynamicViscosity eta;
      ...
    eta = <b>if</b> port_a.m_flow &gt; 0 <b>then</b>
               Medium.dynamicViscosity(medium_a.state)
          <b>else</b>
               Medium.dynamicViscosity(medium_b.state);
    // use eta in the pressure drop equation: port_a.m_flow = f(dp, eta)
  <b>end</b> ShortPipe;
</pre>

<p>
Note, \"Medium.DynamicViscosity\" is type defined as
</p>

<pre>
  import SI = Modelica.SIunits;
  type DynamicViscosity = SI.DynamicViscosity (
                                     min=0,
                                     max=1.e8,
                                     nominal=1.e-3,
                                     start=1.e-3);
</pre>

<p>
Every medium model may modify the attributes, to provide
min, max, nominal, and start values
</p>

</pre>

</HTML>"));
    end OptionalProperties;
    
    class TwoPhase "Two-phase media" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Two-phase Media</font></h3>
<p>
Models for media which can exist in one-phase or two-phase conditions inherit
from Modelica.Media.Interfaces.PartialTwoPhaseMedium. The basic usage of these
media models is the same described in the previous sections. However, additional
functionalities are provided, which apply only to potentially two-phase media.
</p>
<p>
The following additional medium <b>constants</b> are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>Boolean</td>
      <td>smoothModel</b></td>
      <td>If this flag is false (default value), then events are triggered
          whenever the saturation boundary is crossed; otherwise, no events
	  are generated.</td></tr>
  <tr><td>Boolean</td>
      <td>onePhase</b></td>
      <td>If this flag is true, then the medium model assumes it will be never
          called in the two-phase region. This can be useful to speed up
	  the computations in a two-phase medium, when the user is sure it will
	  always work in the one-phase region. Default value: false.</td></tr>
</table>
</p>
<p>
Many additional optional functions are defined to compute properties of 
saturated media, either liquid (bubble point) or vapour (dew point). 
The argument to such functions is a SaturationProperties record, which can be
set starting from either the saturation pressure or the saturation pressure,
as shown in the following example.
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
   Medium.SaturationProperties sat_p;
   Medium.SaturationProperties sat_T;
 equation
   // Set sat_p to saturation properties at pressure p
   sat_p.psat = p;
   sat_p.Tsat = Medium.saturationTemperature(p);
   // Compute saturation properties at pressure p
   bubble_density_p = Medium.bubbleDensity(sat_p);
   dew_enthalpy_p = Medium.dewEnthalpy(sat_p);
   // Set sat_T to saturation properties at temperature T
   sat_T.Tsat = T;
   sat_T.psat = Medium.saturationPressure(T);
   // Compute saturation properties at temperature T
   bubble_density_T = Medium.bubbleDensity(sat_T);
   dew_enthalpy_T = Medium.dewEnthalpy(sat_T);
</pre>
</p>
<p>With reference to a model defining a pressure p, a temperature T, and a 
SaturationProperties record sat, the following functions are provided:
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>= Medium.saturationPressure(T)</b></td>
      <td>Pa</td>
      <td>Saturation pressure at temperature T</td></tr>
  <tr><td>= Medium.saturationTemperature(p)</b></td>
      <td>K</td>
      <td>Saturation temperature at pressure p</td></tr>
  <tr><td>= Medium.saturationTemperature_derp(p)</b></td>
      <td>K/Pa</td>
      <td>Derivative of saturation temperature with respect to pressure</td></tr>
  <tr><td>= Medium.bubbleEnthalpy(sat)</b></td>
      <td>J/kg</td>
      <td>Specific enthalpy at bubble point</td></tr>
  <tr><td>= Medium.dewEnthalpy(sat)</b></td>
      <td>J/kg</td>
      <td>Specific enthalpy at dew point</td></tr>
  <tr><td>= Medium.bubbleEntropy(sat)</b></td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at bubble point</td></tr>
  <tr><td>= Medium.dewEntropy(sat)</b></td>
      <td>J/(kg.K)</td>
      <td>Specific entropy at dew point</td></tr>
  <tr><td>= Medium.bubbleDensity(sat)</b></td>
      <td>kg/m3</td>
      <td>Density at bubble point</td></tr>
  <tr><td>= Medium.dewDensity(sat)</b></td>
      <td>kg/m3</td>
      <td>Density at dew point</td></tr>
  <tr><td>= Medium.dBubbleDensity_dPressure(sat)</b></td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at bubble point with respect to pressure</td></tr>
  <tr><td>= Medium.dDewDensity_dPressure(sat)</b></td>
      <td>kg/(m3.Pa)</td>
      <td>Derivative of density at dew point with respect to pressure</td></tr>
  <tr><td>= Medium.dBubbleEnthalpy_dPressure(sat)</b></td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at bubble point with respect to pressure</td></tr>
  <tr><td>= Medium.dDewEnthalpy_dPressure(sat)</b></td>
      <td>J/(kg.Pa)</td>
      <td>Derivative of specific enthalpy at dew point with respect to pressure</td></tr>
  <tr><td>= Medium.surfaceTension(sat)</b></td>
      <td>N/m</td>
      <td>Surface tension between liquid and vapour phase</td></tr>
</table>
</p>
<p>
Sometimes it can be necessary to compute fluid properties in the thermodynamic 
plane, just inside or outside the saturation dome. In this case, it is possible
to obtain an instance of a ThermodynamicState state vector, and then use it
to call the additional functions already defined for one-phase media.
</p>
<p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Function call</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>= Medium.setBubbleState(sat, phase)</b></td>
      <td>Obtain the thermodynamic state vector 
          corresponding to the bubble point. If phase==1 (default), the state is
	  on the one-phase side; if phase==2, the state is on the two-phase 
	  side </td></tr>
  <tr><td>= Medium.setDewState(sat, phase)</b></td>
      <td>Obtain the thermodynamic state vector 
          corresponding to the dew point. If phase==1 (default), the state is
	  on the one-phase side; if phase==2, the state is on the two-phase 
	  side </td></tr>
  </table>
</p>
<p>
Here are some examples:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialTwoPhaseMedium;
   Medium.SaturationProperties sat;
   Medium.ThermodynamicState dew_1;    // dew point, one-phase side
   Medium.ThermodynamicState bubble_2; // bubble point, two phase side
 equation
   // Set sat to saturation properties at pressure p
   sat.psat = p;
   sat.Tsat = Medium.saturationTemperature(p);
   // Compute dew point properties, one-phase side
   dew_1 = setDewState(sat);
   cpDew = Medium.heatCapacity_cp(dew_1);
   drho_dp_h_1 = Medium.density_derp_h(dew_1);
   // Compute bubble point properties, two-phase side
   bubble_2 = setBubbleState(sat, 2);
   drho_dp_h_2 = Medium.density_derp_h(bubble_2);
</pre>
</p>
</HTML>
"));
    end TwoPhase;
    
    class BoundaryConditions "Boundary conditions" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Medium boundary conditions</font></h3>
<p>
In some components, such as \"Ambient\", explicit equations for
medium variables are provided as \"boundary conditions\".
For example, the \"Ambient\" component may define a temperature
T_ambient. If the medium model uses specific enthalpy as independent
variable and not temperature, a non-linear system of equations may
occur. In the medium model
(e.g., in the example case, the medium model might compute the
specific enthalpy h = fh(T) from the temperature T):
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Values</b></td></tr>
  <tr><td>Integer</td><td>known_pd</td>
      <td>= Medium.Choices.pd.default: no special handling<br>
          = Medium.Choices.pd.p_known: an equation for pressure p is provided<br>
          = Medium.Choices.pd.d_known: an equation for density d is provided</td></tr>
  <tr><td>Integer</td><td>known_Th</td>
      <td>= Medium.Choices.Th.default: no special handling<br>
          = Medium.Choices.Th.p_known: an equation for temperature T is provided<br>
          = Medium.Choices.Th.d_known: an equation for specific enthalpy h is provided</td></tr>
</table>
<p>
An ambient component should therefore be essentially implemented as:
</p>
<pre>
  <b>model</b> FixedAmbient \"Ambient temperature and pressure source\"
    <b>parameter</b> Boolean use_p_ambient = <b>true</b> \"= true, if p_ambient is used\";
    <b>parameter</b> Medium.AbsolutePressure p_ambient \"Ambient pressure, if use_p_ambient = true\";
      ...
    <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium
                         <b>annotation</b> (choicesAllMatching=true);
    Medium medium(
      known_pd = <b>if</b> use_p_ambient <b>or</b> Medium.singleState <b>then</b>
                    Medium.Choices.pd.p_known <b>else</b> Medium.Choices.pd.d_known,
      known_Th = <b>if</b> use_T_ambient <b>then</b>
                    Medium.Choices.Th.T_known <b>else</b> Medium.Choices.Th.h_known
    ) \"Medium in the source\";
      ...
  <b>end</b> FixedAmbient;
</pre>
</HTML>"));
    end BoundaryConditions;
    
    class Constants "Constants" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Constants provided by medium model</font></h3>
<p>
Every medium model provides the following <b>constants</b>. For example,
if a medium is declared as:
</p>
<pre>
   <b>replaceable package</b> Medium = Modelica.Media.Interfaces.PartialMedium;
</pre>
<p>
then constants \"Medium.mediumName\", \"Medium.nX\", etc. are defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (is usually used to check whether
          two media in a model are the same)</td></tr>
  <tr><td>String</td><td>substanceNames[nS]</td>
      <td>Names of the substances that make up the medium.</td></tr>
  <tr><td>String</td><td>extraPropertiesNames[nC]</td>
      <td>Names of the extra transported substances, outside of standard mass 
          balance.</td></tr>
  <tr><td>Boolean</td><td>singleState</td>
      <td>= true, if u and d are not a function of pressure, and thus only
          a function of a single thermal variable (temperature or enthalpy).</td></tr>
  <tr><td>AbsolutePressure</td><td>reference_p</td>
      <td>Reference pressure for the medium.</td></tr>
  <tr><td>MassFraction</td><td>reference_X[nX]</td>
      <td>Reference composition for the medium.</td></tr>
  <tr><td>Integer</td><td>nS</td>
      <td>number of substances contained in the medium.</td></tr>
  <tr><td>Integer</td><td>nX</td>
      <td>Size of the full mass fraction vector X. If there is a single 
          substance, then nX = 0, else nX=nS.</td></tr>
  <tr><td>Integer</td><td>nX_i</td>
      <td>Number of independent mass fractions. If there is a single substance,
          then nX_i = 0.</td></tr>
  <tr><td>Boolean</td><td>reducedX</td>
      <td>= true if the medium has a single substance, or if the medium model 
          contains the equation sum(X) = 1. In both cases, nX_i = nS - 1.
</table>
</HTML>
"));
    end Constants;
    
  end MediumUsage;
  
  package MediumDefinition "Medium definition" 
    annotation (DocumentationClass=true, Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Defining a fluid medium model</font></h3>
<p>
If a new medium model shall be introduced, copy package
<a href=\"Modelica:Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to the desired
location, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
A more detailed description for the different parts of the
TemplateMedium package is given here:
</p>
<ol>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.BasicStructure\">
      Basic structure of medium interface</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.BasicDefinition\">
      Basic definition of medium model</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.MultipleSubstances\">
      Multiple Substances</a></li>
<li> <a href=\"Modelica:Modelica.Media.UsersGuide.MediumDefinition.StaticStateSelection\">
      Static State Selection</a></li>
</ol>
</HTML>"));
    
    class BasicStructure "Basic structure" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic structure of medium interface</font></h3>
<p>
A medium model of Modelica.Media is essentially a <b>package</b>
that contains the following definitions:
</p>
<ul>
<li>
Definition of <b>constants</b>, such as the medium name.</li>
<li>
A <b>model</b> in the package that contains the 3 basic
thermodynamic equations that relate the 5+nX_i primary medium variables.</li>
<li><b>Optional functions</b> to compute medium properties that are
only needed in certain circumstances, such as dynamic viscosity. These optional
functions need not be provided by every medium model.</li>
<li>
<b>Type</b> definitions, which are adapted to the particular
medium. For example, a type <b>Temperature</b> is defined where the attributes 
<b>min</b>
and <b>max</b> define the validity region of the medium, and a suitable default
start value is given. In a device model, it is advisable to use these type 
definitions, e.g., for parameters, in order that medium limits are checked as 
early as possible, and nonlinear sover iterations always get reasonable start 
values.</li>
</ul>
<p>
Note, although we use the term <b>medium model</b>, it
is actually a Modelica <b>package</b> that contains all the constants and
definitions required for a complete <b>medium model</b>. The basic interface to a
medium is defined by Modelica.Media.Interfaces.PartialMedium that has the
following structure:</p>
<pre>
partial package PartialMedium
  import SI = Modelica.SIunits;
  constant String mediumName;
  constant String substanceNames[:]; 
  constant String extraPropertiesNames[:]; 
  constant Boolean singleState;
  constant AbsolutePressure reference_p = 101325; 
  constant MassFraction reference_X[nX]=fill(1/nX,nX); 
  constant Boolean reducedX;
  final constant Integer nS = size(substanceNames,1); 
  final constant Integer nX = if nS==1 then 0 else nS; 
  final constant Integer nX_i = if reducedX then nS-1 else nS; 
  final constant Integer nC = size(extraPropertiesNames,1);

  replaceable record BasePropertiesRecord 
    AbsolutePressure p;
    Density d;
    Temperature T;
    SpecificEnthalpy h;
    SpecificInternalEnergy u;
    MassFraction[nX] X;
    MassFraction[nX_i] X_i;
    SpecificHeatCapacity R;
    MolarMass MM;
  end BasePropertiesRecord;
  
  replaceable partial model BaseProperties 
    extends BasePropertiesRecord;
    ThermodynamicState state; 
    parameter Boolean preferredMediumStates=false;
    SI.Conversions.NonSIunits.Temperature_degC T_degC = 
       Modelica.SIunits.Conversions.to_degC(T) 
    SI.Conversions.NonSIunits.Pressure_bar p_bar = 
       Modelica.SIunits.Conversions.to_bar(p) 
  equation 
    X_i = X[1:nX_i];
    if nX > 1 then
       if reducedX then
          X[nX] = 1 - sum(X_i);
       end if;
    end if;
    // equation such as 
    // state.p = p;
    // state.T = T;
    // will go here in actual media implementations, but are not present
    // in the base class since the ThermodynamicState record is still empty
   end BaseProperties
 
  replaceable record ThermodynamicState 
     // there are no \"standard\" thermodynamic variables in the base class
     // but they will be defined here in actual media extending PartialMedium
  end ThermodynamicState;

  // optional medium properties
  replaceable partial function dynamicViscosity
    input  ThermodynamicState state;
    output DynamicViscosity eta;
  end dynamicViscosity;

  // other optional functions
  // medium specific types
  type AbsolutePressure = SI.AbsolutePressure (
                               min     = 0,
                               max     = 1.e8,
                               nominal = 1.e5,
                               start   = 1.e5);
  type DynamicViscosity = ...;
  // other type definitions
end PartialMedium;
</pre>
<p>
We will discuss all parts of this package in the
following paragraphs. An actual medium model should extend from PartialMedium
and has to provide implementations of the various parts.</p>
<p>The constants at the beginning of the package do not have a value yet  
(this is valid in Modelica), but a value has to be provided when extending from
package PartialMedium. Once a value is given, it cannot be changed any more. 
The reason to use constants instead of parameters in the model BaseProperties 
is that some of these constants have to be used in connector definitions 
(such as the number of independent mass fractions nX_i). When defining the 
connector, only <i>constants</i> in packages can be accessed, but not 
<i>parameters</i> in a model, because a connector cannot contain an instance 
of BaseProperties.</p>
<p>The record BasePropertiesRecord contains the variables
primarily used in balance equations. Three equations for these variables have
to be provided by every medium in model BaseProperties, plus two equations
for the gas constant and the molar mass. </p>
<p>Optional medium properties are defined by functions, such as the function 
dynamicViscosity (see code Section above) to compute the dynamic viscosity. 
The argument of those functions is the ThermodynamicState record state, defined
in BaseProperties, which contain the minimum number of thermodynamic variables
needed as an input to compute all the optional properties.
This construction simplifies the usage
considerably as demonstrated in the following code fragment:</p>
<pre>
  replaceable package Medium = Interfaces.PartialMedium;
  Medium.BaseProperties  medium;
  Medium.DynamicViscosity eta;
  ...
  U = m*medium.u; //Internal energy
  eta = Medium.dynamicViscosity(medium.state);
</pre> </p>
<p>Medium is the medium package that satisfies the
requirements of a PartialMedium (when using the model above, a value for
Medium has to be provided by a redeclaration). The medium component is an
instance of the model Medium.BaseProperties and contains the core medium
equations. Variables in this model can be accessed just by dot-notation, such
as medium.u or medium.T. If an optional medium variable has to be computed, the
corresponding function from the actual Medium package is called, such as 
Medium.dynamicViscosity. The medium.state vector can be given as input argument 
to this function, and its fields are kept consistent to those of BaseProperties
by suitable equations, contained in BaseProperties itself (see above).</p>
<p>If a medium model does not provide implementations of all
optional functions and one of these functions is called in a model, an error
occurs during translation since the optional functions which have not been
redeclared have the <i>partial</i> attribute. For example, if function 
dynamicViscosity is not provided in the medium model when it is used, only 
simple pressure drop loss models without a reference to the viscosity can be 
used and not the sophisticated ones.</p>
<p>At the bottom of the PartialMedium package type declarations
are present, that are used in all other parts of the PartialMedium package and
that should be used in all models and connectors where a medium model is
accessed. The reason is that minimum, maximum, nominal, and start
values are defined and these values can be adapted to the particular medium at
hand. For example, the nominal value of AbsolutePressure is 1.0e<sup>5</sup>
Pa. If a simple model of water steam is used that is only valid above 100 &deg;C,
then the minimum value in the Temperature type should be set to this value. The
minimum and maximum values are also important for parameters in order to get an
early message if data outside of the validity region is given. The nominal
attribute is important as a scaling value if the variable is used as a state in
a differential equation or as an iteration variable in a non-linear system of
equations. The start attribute can be very useful to provide a meaningful 
default start or guess value if the variable is used, e.g., as iteration 
variable in a non-linear system of equations. Note that all these attributes 
can be set specifically for a medium in the following way:</p>
<p>
<pre>
package MyMedium 
  extends Interfaces.PartialMedium(
     ...
     Temperature(min=373));
end MyMedium;
</pre>
</p>
<p>
The type PartialMedium.MassFlowRate is defined as</p>
<p>
<pre>
type MassFlowRate = SI.MassFlowRate
     (quantity = \"MassFlowRate.\" + mediumName);
</pre></p>
<p>Note that the constant mediumName, that has to be
defined in every medium model, is used in the quantity attribute. For example,
if mediumName = SimpleLiquidWater, then the quantity attribute has the value
MassFlowRate.SimpleLiquidWater. This type should be used in a connector
definition of a fluid library:</p>
<p>
<pre>
connector FluidPort
  replaceable package Medium = PartialMedium;
  flow Medium.MassFlowRate m_flow;
  ...
end FluidPort;
</pre></p>
<p>In the model where this connector is used, the actual
Medium has to be defined. Connectors can only be connected together, if the
corresponding attributes are either not defined or have identical values. Since
mediumName is part of the quantity attribute of MassFlowRate, it is not
possible to connect connectors with different media models together. In Dymola
this is already checked when models are connected together in the diagram layer
of the graphical user interface.</p>
</HTML>
"));
    end BasicStructure;
    
    class BasicDefinition "Basic definition" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Basic definition of a medium model</font></h3>
<p>
Let's now walk through the definition of a new medium model. Please refer to 
<a href=\"Modelica:Modelica.Media.Interfaces.TemplateMedium\">
Modelica.Media.Interfaces.TemplateMedium</a> to obtain a template of the new
medium model code. For the moment being, consider a single-substance medium
model.
<p>
The new medium model is obtained by extending Interfaces.PartialMedium, and
setting the following package constants:
<ul>
<li>mediumName is a String containing the name of the medium.
<li>substancesNames is a vector of strings containing the name of the substances
    that make up the medium. In this case, it will contain only mediumName.
<li>singleState can be set to true if u and d in BaseProperties do not depend
    on pressure. In other words, density does not depend on pressure
    (incompressible fluid), and it is assumed that also u does not depend on 
    pressure. This setting can be useful for fluids having high density and
    low compressibility (e.g., liquids at moderate pressure); fast states 
    resulting from the low compressibility effects are automatically avoided.
<li>reducedX = true for single-substance media, which do not need mass 
    fractions at all.
</ul>
It is also possible to change the default min, max, nominal, and start
attributes of Medium-defined types (see TemplateMedium).</p>
<p>
All other package constants, such as nX, nX_i, nS, are automatically set
by the declarations of the base package Interfaces.PartialMedium. </p>
<p>
The second step is to provide an implementation to the BaseProperties model,
partially defined in the base class Interfaces.PartialMedium. In the case of
single-substance media, two independent state variables must be selected among
p, T, d, u, h, and three equations must be written to provide the values of 
the remaining variables. Two equations must then be added to compute the molar 
mass MM and the gas constant R. <p>
<p>
The third step is to consider the optional functions that are going to be 
implemented, among the partial functions defined by the base class PartialMedium.
A minimal set of state variables that could be provided as an input to 
<i>all</i> those functions must be selected, and included in the redeclaration
of the ThermodynamicState record. Subsequently, equations must be added to 
BaseProperties in order that the instance of that record inside BaseProperties
(named \"state\") is kept updated. For example, assume that all additional 
properties can be computed as a function of p and T. Then, ThermodynamicState
should be redclared as follows: </p>
<p><pre>
  redeclare replaceable record ThermodynamicState 
    AbsolutePressure p \"Absolute pressure of medium\";
    Temperature T \"Temperature of medium\";
  end ThermodynamicState;
</pre></p>
and the following equations should be added to BaseProperties:
<p><pre>
  state.p = p;
  state.T = T;
</pre></p>
The additional functions can now be implemented by redeclaring the functions
defined in the base class and adding their algorithms, e.g.:
</p>
<p><pre>
    redeclare function extends dynamicViscosity \"Return dynamic viscosity\" 
    algorithm 
      eta := 10 - state.T*0.3 + state.p*0.2;
    end dynamicViscosity;
</pre></p>
</HTML>
"));
    end BasicDefinition;
    
    class MultipleSubstances "Multiple Substances" 
      annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\">Models of multiple-substance media</font></h3>
<p>
When writing the model of a multiple-substance medium, a fundamental issue
concerns how to consider the mass fractions of the fluid. If there are nS 
substances, there are also nS mass fractions; however, one of them is redundant,
as sum(X) = 1. Therefore there are basically two options, concerning the number 
of independent mass fractions nX_i:
<ul>
<li> <i>Reduced-state models</i>: reducedX = true and nX_i = nS - 1. In this
case, the number of independent mass fractions nX_i is the minimum possible. 
The full state vector X is provided by equations declared in the base class
Interfaces.PartialMedium.BaseProperties: the first nX_i elements are equal to
X_i, and the last one is 1 - sum(X_i).
<li> <i>Full-state models</i>: reducedX = false and nX_i = nS. In this case,
X_i = X, i.e., all the elements of the composition vector are considered as
independent variables, and the constraint sum(X) = 1 is never written explicitly.
Although this kind of model is heavier, as it provides one extra state variable,
it can be less prone to numerical and/or symbolic problems, which can be 
caused by that constraint.
</ul>
<p> The medium implementor can declare the value reducedX as <b>final</b>. In
this way only one implementation must be given. For instance, 
Modelica.Media.IdealGases models declare final reducedX = false, so that the
implementation can always assume nX_i = nX. The same is true for Air.MoistAir,
which declares final reducedX = true, and always assumes nX_i = nX - 1 = 1.</p>
<p>It is also possible to leave reducedX modifiable. In this case, the 
BaseProperties model and all additional functions should check for the actual
value of reducedX, and provide the corresponding implementation.</p>
<p>Fluid connectors should always use composition vectors of size X_i, such as
in the Modelica_Fluid library: </p>
<p><pre>
connector FluidPort 
  replaceable package Medium = Modelica.Media.Interfaces.PartialMedium; 
  Medium.AbsolutePressure p;
  flow Medium.MassFlowRate m_flow;
  Medium.SpecificEnthalpy h;
  flow Medium.EnthalpyFlowRate H_flow; 
  Medium.MassFraction X_i[Medium.nX_i](quantity=Medium.substanceNames); 
  flow Medium.MassFlowRate mX_flow[Medium.nX_i](quantity=Medium.substanceNames); 
end FluidPort;
</pre></p>
<p>
For further details, refer to the implementation of 
<a href=\"Modelica:Modelica.Media.IdealGases.Common.MixtureGasNasa\">
      MixtureGasNasa model</a> and
<a href=\"Modelica:Modelica.Media.Air.MoistAir\">
      MoistAir model</a>.
</p>
</HTML>
"));
    end MultipleSubstances;
    
    model StaticStateSelection "Static State Selection" 
      annotation (Documentation(info="<html>
<h3><font color=\"#008000\">Static State Selection</font></h3>
<p>
Without pre-caution when implementing a medium model, 
it is very easy that non-linear algebraic
systems of equations occur when using the medium model.
In this section it is explained how to avoid non-linear
systems of equations that result from unnecessary
dynamic state selections.
</p>
<p>
A medium model should be implemented in such a way that
a tool is able to select states of a medium in a balance volume
statically (during translation). This is only possible if the
medium equations are written in a specific way. Otherwise,
a tool has to dynamically select states during simulation.
Since medium equations are usually non-linear, this means that
non-linear algebraic systems of equations would occur in every
balance volume.
</p>
<p>
It is assumed that medium equations in a balance volume
are defined in the following way:
</p>
<pre>
    <b>package</b> Medium = Modelica.Media.Air.DryAirNasa; 
    Medium.BaseProperties medium;
  <b>equation</b> 
     // mass balance
              <b>der</b>(M) = port_a.m_flow + port_b.m_flow;
     <b>der</b>(MX) = port_a_mX_flow + port_b_mX_flow;
                  M = V*medium.d;
                 MX = M*medium.X;
  
     // Energy balance
     U = M*medium.u;
     <b>der</b>(U) = port_a.H_flow+port_b.H_flow;
</pre>
<p>
<b>Single Substance Media</b>
</p>
<p>
A medium consisting of a single substance
has to define two of \"p,T,d,u,h\" with 
stateSelect=StateSelect.prefer and has to provide
the other three variables as function of these 
states. This results in:
</p>
<ul>
<li> static state selection (no dynamic choices).</li>
<li> a linear system of equations in the two 
     state derivatives.</li>
</ul>
<p>
<b>Example for a single substance medium:</b>
</p>
<p>
p, T are preferred states (i.e. StateSelect.prefer is set)
and there are three equations written in the form:
</p>
<pre>
   d = fd(p,T)
   u = fu(p,T)
   h = fh(p,T)
</pre>
<p>
Index reduction leads to the equations:
</p>
<pre>
   der(M) = V*der(d)
   der(U) = der(M)*u + M*der(u)
   der(d) = pder(fd,p)*der(p) + pder(fd,T)*der(T)
   der(u) = pder(fu,p)*der(p) + pder(fu,T)*der(T)
</pre>
<p>
in other words, if p,T are provided from the
integrator as states, all functions, such as fd(p,T) 
or pder(fd,p) can be evaluated as function of the states.
The overall system results in a linear system
of equations in der(p) and der(T) after eliminating
der(M), der(U), der(d), der(u) via tearing.
</p>
<p>
<b>Counter Example for a single substance medium:</b>
</p>
<p>
An ideal gas with one substance is written in the form
</p>
<pre>
  <b>redeclare model extends</b> BaseProperties(
     T(stateSelect=StateSelect.prefer),
     p(stateSelect=StateSelect.prefer) 
  <b>equation</b>
     h = h(T);
     u = h - R*T;
     p = d*R*T;      
      ...
  <b>end</b> BaseProperties;
</pre>
<p>
If p, T are preferred states, these equations are <b>not</b>
written in the recommended form, because d is not a
function of p and T. If p,T would be states, it would be 
necessary to solve for the density:
</p>
<pre>
   d = p/(R*T)
</pre>
<p>
If T or R are zero, this results in a division by zero.
A tool does not know that R or T cannot become zero. 
Therefore, a tool must assume that p, T <b>cannot</b> always be
selected as states and has to either use another static
state selection or use dynamic state selection. The only
other choice for static state selection is d,T, because
h,u,p are given as functions of d,T.
However, as potential states only variables appearing differentiated and variables
declared with StateSelect.prefer or StateSelect.always
are used. Since \"d\" does not appear differentiated and has
StateSelect.default, it cannot be selected as a state.
As a result, the tool has to select states dynamically
during simulation. Since the equations above are non-linear
and they are utilized in the dynamic state
selection, a non-linear system of equations is present
in every balance volume. 
</p>
<p>
To summarize, for single substance ideal gas media there
are the following two possibilities to get static
state selection and linear systems of equations:
</p>
<ol>
<li> Use p,T as preferred states and write the equation
     for d in the form: d = p/(T*R)</li>
<li> Use d,T as preferred states and write the equation
     for p in the form: p = d*T*R</li>
</ol>
<p>
All other settings (other/no preferred states etc.) lead
to dynamic state selection and non-linear systems of 
equations for a balance volume.
</p>
<p>
<b>Multiple Substance Media</b>
</p>
<p>
A medium consisting of multiple substance
has to define two of \"p,T,d,u,h\" as well
as the mass fractions X_i with 
stateSelect=StateSelect.prefer and has to provide
the other three variables as function of these 
states. Only then, static selection is possible 
for a tool.
</p>
<p>
<b>Example for a multiple substance medium:</p>
</p>
<p>
p, T and X_i are defined as preferred state and 
the equations are written in the form:
</p>
<pre>
   d = fp(p,T,X_i);
   u = fu(p,T,X_i);
   h = fh(p,T,X_i);
</p>
<p>
Since the balance equations are written in the form:
</p>
<pre>
            M = V*medium.d;
            MX = M*medium.X_i;
</pre>
<p>
The variables M and MX appearing differentiated in the
balance equations are provided as functions of d and X_i
and since d is given as a function of p, T and X_i it 
is possible to compute M and MX directly from the desired
states. This means that static state selection is possible.
</p>
<p>
Assume the balance equations would have been written in the form
</p>
<pre>
  <b>der</b>(MX) = port_a_mX_flow + port_b_mX_flow
        M = sum(MX);
  medium.d = M/V;
  medium.X_i = MX/M;
</pre>
<p>
If MX would be selected as states, then d and X
are computed from the equations. As a result, the
medium equations have to be written as function of
d, X_i and one of p, T, u, h, in order that
static state selection is possible.
</p>
        
</html>"));
    equation 
      
    end StaticStateSelection;
    
  end MediumDefinition;
  
  model ReleaseNotes "Release notes" 
    annotation (Documentation(info="<HTML>
<h3><font color=\"#008000\" size=5>Release notes</font></h3>
<h3><font color=\"#008000\">Version 0.900, 2004-10-18</font></h3>
<ul>
<li> Changed the redeclaration/extends within packages from the
     experimental feature to the language keywords introduced
     in Modelica 2.1.</li>
<li> Re-introduced package \"Water.SaltWater\" in order to test
     substance mixtures (this medium model does not describe
     real mixing of water and salt). </li>
<li> Started to improve the documentation in
     Modelica.Media.UsersGuide.MediumDefinition.BasicStructure</li>
</ul>
<h3><font color=\"#008000\">Version 0.792, 2003-10-28</font></h3>
<p>
This is the first version made available for the public
for the Modelica'2003 conference (for evaluation).
</p>
</HTML>
"));
  equation 
    
  end ReleaseNotes;
  
class Contact "Contact" 
    
    annotation (Documentation(info="<html>
<dl>
<dt><b>Main author and maintainer:</b>
<dd>Hubertus Tummescheit<br>
    Scynamics HB<br>
    Bokbindaregatan 4, SE-22736 Lund, Sweden<br>
    email: <A HREF=\"mailto:Hubertus.Tummescheit@Scynamics.com\">Hubertus.Tummescheit@Scynamics.com</A><br>
</dl>
<p><b>Acknowledgements:</b></p>
<p>
The development of this library has been a collaborative effort 
and many have contributed:
</p>
<ul>
<li> The essential parts of the media models have been implemented
     in the ThermoFluid library by Hubertus Tummescheit with
     help from Jonas Eborn and Falko Jens Wagner. These media models
     have been converted to the Modelica.Media interface definition
     and have been improved by Hubertus Tummescheit. </li>
<li> The effort for the development of the Modelica.Media library has been
     organized by Martin Otter who also contributed to the design
     and implemented most of the generic models.</li>
<li> The basic idea for the medium model interface based on packages
     is from Michael Tiller who also contributed to the design.</li>
<li> The first design of the medium model interface is from
     Hilding Elmqvist. This design has been further improved at the
     two Modelica design meetings in Detroit, U.S.A., Nov. 20-22, 2002
     and Sept. 2-4, 2003.</li>
<li> Hans Olsson, Sven Erik Mattsson and Hilding Elmqvist developed
     symbolic transformation algorithms and implemented them in Dymola
     to improve the efficiency considerably (e.g., to avoid non-linear
        systems of equations).</li>
<li>Katrin Pr&ouml;&szlig; implemented the moist air model</li>     
<li> R&uuml;diger Franke performed the first realistic tests of the Modelica.Media
        and Modelica_Fluid libraries and gave valuable feedback.</li>
<li>Francesco Casella has been the most relentless bug-hunter and tester of the 
water and ideal gas properties. He's also contributed to the final documentation
of the package.</li>      
<li> John Batteh, Daniel Bouskela, Jonas Eborn, Andreas Idebrant, Charles Newman, 
     Gerhart Schmitz, and the users of the ThermoFluid library provided
     many useful comments and feedback.</li>
</ul>
</html>"));
end Contact;
  
end UsersGuide;


package Examples 
  "Demonstrate usage of property models (currently: simple tests)" 
  
  extends Modelica.Icons.Library;
  
  model SimpleLiquidWater "Example for Water.SimpleLiquidWater medium model" 
    annotation (experiment(StopTime=100));
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Example;
    parameter SI.Volume V=1 "Volume";
    parameter SI.EnthalpyFlowRate H_flow_ext=1.e6 
      "Constant enthalpy flow rate into the volume";
    
    package Medium = Water.ConstantPropertyLiquidWater (SpecificEnthalpy(max=1e6));
    Medium.BaseProperties medium(
      T(start=300,fixed=true));
    
    SI.Mass m(start = 1.0);
    SI.InternalEnergy U;
    
    // Use type declarations from the Medium
    Medium.MassFlowRate m_flow_ext;
    Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium);
    Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(medium);
  equation 
    medium.p = 1.e5;
    
    m = medium.d*V;
    U = m*medium.u;
    
    // Mass balance
    der(m) = m_flow_ext;
    
    // Energy balance
    der(U) = H_flow_ext;
  end SimpleLiquidWater;
  
  model IdealGasH2O "IdealGas H20 medium model" 
    extends Modelica.Icons.Example;
    package Medium = IdealGases.SingleGases.H2O;
    Medium.ThermodynamicState state;
    Medium.ThermodynamicState state2;
    Medium.SpecificHeatCapacity cp=Medium.heatCapacity_cp(state);
    Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(state);
    Medium.IsentropicExponent k=Medium.isentropicExponent(state);
    Medium.SpecificEntropy s=Medium.specificEntropy(state);
    //  Medium.SpecificEntropy s2=Medium.specificEntropy(state2);
    Medium.VelocityOfSound a=Medium.velocityOfSound(state);
    Real beta = Medium.isobaricExpansionCoefficient(state);
    Real gamma = Medium.isothermalCompressibility(state);
    Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0, state);
  equation 
    state.p = 100000.0;
    state.T = 200 + 1000*time;
    state2.p = 2.0e5;
    state2.T = 500.0;
    //  s2 = s;
    annotation (Documentation(info="<html>
                  <body>
                  <p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
                  The function that is implemented is approximate, but usually very good: the second medium record medium2
                  is given to compare the approximation.
                  </p>
                  </body>
                  </html>"));
  end IdealGasH2O;
  
  model WaterIF97 "WaterIF97 medium model" 
    extends Modelica.Icons.Example;
    package Medium = Water.StandardWater;
    Medium.BaseProperties medium(
      p(start=1.e5, stateSelect=StateSelect.prefer),
      h(start=1.0e5, stateSelect=StateSelect.prefer),
      T(start = 275.0),
      d(start = 999.0));
    Real V(start = 0.1);
    parameter Real dV = 0.0;
    parameter Medium.MassFlowRate m_flow_ext=0;
    parameter Real H_flow_ext=10000;
    Real m;
    Real U;
  equation 
    der(V) = dV;
    m = medium.d*V;
    U = m*medium.u;
    
    // Mass balance
    der(m) = m_flow_ext;
    
    // Energy balance
    der(U) = H_flow_ext;
  end WaterIF97;
  
  model MixtureGases "Test gas mixtures" 
    extends Modelica.Icons.Example;
    
    parameter Real V=1;
    parameter Real m_flow_ext=0.01;
    parameter Real H_flow_ext=5000;
    
    package Medium1 = Modelica.Media.IdealGases.MixtureGases.CombustionAir;
    Medium1.BaseProperties medium1(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.8,0.2}));
    Real m1(quantity=Medium1.mediumName, start = 1.0);
    SI.InternalEnergy U1;
    Medium1.SpecificHeatCapacity cp1=Medium1.heatCapacity_cp(medium1.state);
    Medium1.DynamicViscosity eta1= Medium1.dynamicViscosity(medium1.state);
    Medium1.ThermalConductivity lambda1= Medium1.thermalConductivity(medium1.state);
    
    package Medium2 = Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas;
    Medium2.BaseProperties medium2(p(start=1.e5, stateSelect=StateSelect.prefer),
       T(start=300, stateSelect=StateSelect.prefer),
       X(start={0.1,0.1,0.1,0.2,0.2,0.3}));
    Real m2(quantity=Medium2.mediumName, start = 1.0);
    SI.InternalEnergy U2;
    Medium2.SpecificHeatCapacity cp2=Medium2.heatCapacity_cp(medium2.state);
    Medium2.DynamicViscosity eta2= Medium2.dynamicViscosity(medium2.state);
    Medium2.ThermalConductivity lambda2= Medium2.thermalConductivity(medium2.state);
    
  equation 
    medium1.X = {0.8,0.2};
    m1 = medium1.d*V;
    U1 = m1*medium1.u;
    der(m1) = m_flow_ext;
    der(U1) = H_flow_ext;
    
    medium2.X ={0.1,0.1,0.1,0.2,0.2,0.3};
    m2 = medium2.d*V;
    U2 = m2*medium2.u;
    der(m2) = m_flow_ext;
    der(U2) = H_flow_ext;
  end MixtureGases;
  
model MoistAir "Ideal gas flue gas  model" 
    extends Modelica.Icons.Example;
    package Medium = Air.MoistAir;
    Medium.BaseProperties medium(
       T(start = 274.0),
       X(start = {0.95,0.05}),
       p(start = 1.0e5));
  //  Medium.SpecificEntropy s=Medium.specificEntropy(medium);
  //  Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(medium, 2.0e5);
    parameter Real[2] MMx = {Medium.dryair.MM,Medium.steam.MM};
    Real MM = 1/((1-medium.X[1])/MMx[1]+medium.X[1]/MMx[2]) 
      "molar mass of gas part of mixture";
  //  Real[4] dddX=Medium.density_derX(medium,MM);
    annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"),
      experiment(Tolerance=1e-005),
      experimentSetupOutput);
equation 
    der(medium.p) = 0.0;
    der(medium.T) = 90;
    medium.X[Medium.Air] = 0.95;
    //    medium.X[Medium.Water] = 0.05;
    // one simple assumption only for quick testing:
  //  medium.X_liquidWater = if medium.X_sat < medium.X[2] then medium.X[2] - medium.X_sat else 0.0;
end MoistAir;
  
  package TwoPhaseWater "extension of the StabdardWater package" 
    extends Modelica.Media.Water.StandardWater;
    
    model ExtendedProperties "plenty of two-phase properties" 
      extends BaseProperties;
      ThermodynamicState dew "dew line Properties";
      ThermodynamicState bubble "bubble line Properties";
      ThermodynamicState bubble2 "bubble line Properties, on the 2-phase side";
      DynamicViscosity eta "viscosity (McAdams mixture rules if in 2-phase)";
      DynamicViscosity eta_d "dew line viscosity";
      DynamicViscosity eta_b "bubble line viscosity";
      ThermalConductivity lambda_d "dew line thermal conductivity";
      ThermalConductivity lambda_b "bubble line thermal conductivity";
      SpecificHeatCapacity cp_d "dew line Specific heat capacity";
      SpecificHeatCapacity cp_b "bubble line Specific heat capacity";
      Real ddhp;
      Real ddhp_d;
      Real ddhp_b "derivatives";
      Real ddph;
      Real ddph_d;
      Real ddph_b "derivatives";
      Real ddhp_b2;
      Real ddph_b2 "derivatives";
      // no derivatives yet, ... sat should be temporary
      MassFraction x "steam mass fraction";
      Real dTp;
      Real dTp2;
      SpecificEntropy s_b;
      SpecificEntropy s_d;
    equation 
      eta = if phase == 1 then dynamicViscosity(state) else 1/(x/eta_d + (1 - x)
        /eta_b);
      dew =  setDewState(sat);
      bubble =  setBubbleState(sat);
      bubble2 =  setBubbleState(sat,2);
      x = (h - bubble.h)/max(dew.h - bubble.h,1e-6);
      eta_d = dynamicViscosity(dew);
      eta_b = dynamicViscosity(bubble);
      lambda_d = thermalConductivity(dew);
      lambda_b = thermalConductivity(bubble);
      cp_d = heatCapacity_cp(dew);
      cp_b = heatCapacity_cp(bubble);
      s_d = specificEntropy(dew);
      s_b = specificEntropy(bubble);
      ddph = density_derp_h(state);
      ddph_d = density_derp_h(dew);
      ddph_b = density_derp_h(bubble);
      ddhp = density_derh_p(state);
      ddhp_d = density_derh_p(dew);
      ddhp_b = density_derh_p(bubble);
      ddhp_b2 = density_derh_p(bubble2);
      ddph_b2 = density_derp_h(bubble2);
      dTp = saturationTemperature_derp(p);
      dTp2 = (1/dew.d - 1/bubble.d)/max(s_d - s_b,1e-6);
      annotation (Documentation(info=""));
    end ExtendedProperties;
    
    annotation (Documentation(info="<html>
<body>
<h3>Example: TwoPhaseWater</h3>
The TwoPhaseWater package demonstrates how to extend the parsimonius
BaseProperties with a minimal set of properties from the standard water
package with most properties that are needed in two-phase situations.
The model also demonstrates how to compute additional&nbsp; properties
for the medium model. In this scenario, that builds a new medium model
with many more properties than the default, the standard BaseProperties
is used as a basis. For additional properties, a user has to:<br>
<ol>
<li>Declare a new variable of the wanted type, e.g. <span
style=\"color: rgb(0, 0, 153);\">\"<span style=\"color: rgb(51, 51, 255);\">DynamicViscosity
eta</span>\"</span>.</li>
<li>Compute that variable by calling the function form the package,
e.g. <span style=\"color: rgb(51, 51, 255);\">eta =
dynamicViscosity(state)</span>. Note that the instance of
ThermodynamicState is used as an input to the function. This instance
\"state\" is declared in PartialMedium and thus available in every medium
model. A user does not have to know what actual variables are required
to compute the dynamic viscosity, because the state instance is
guaranteed to contain what is needed.&nbsp;<span
style=\"color: rgb(255, 0, 0);\"></span></li>
<li><span style=\"color: rgb(255, 0, 0);\">Attention</span>: Many
properties are not well defined in the two phase region and the
functions might return undesired values if called there. It is the
users responsibility&nbsp; to take care of such ituations. The example
uses one of several possible models to compute an averaged viscosity
for two-phase flows. </li>
</ol>
In two phase models, properties are often needed on the phase boundary
just outside the two phase dome, right on the border.. To compute the
thermodynamic state there, two auxiliary functions are provided: <b>setDewState(sat)</b> and <b>setBubbleState(sat)</b>. They take an
instance of SaturationProperties as input. By default they are in
one-phase, but with the optional phase argument set to 2, the output is
forced to be just inside the phase boundary. This is only needed when
derivatives like cv are computed with are different on both sides of
the boundaries. The ususal steps to compute properties on the phase
boundary are: <br>
<ol>
<li>Declare an instance of ThermodynamicState, e.g. \"ThermodynamicState&nbsp; dew\".</li>
<li>Compute the state, using an instance of SaturationProperties,
e.g. dew = setDewState(sat)</li>
<li>Compute properties on the phase boundary to your full desire,
e.g. \"cp_d = heatCapacity_cp(dew)\". <br>
</li>
</ol>
<p>The sample model TestTwoPhaseStates test the extended properties</p>
The same procedure can be used to compute properties at other state
points, e.g. when an isentropic reference state is computed.<br>
<br>
</body>
</html>
"));
    model TestTwoPhaseStates "test the above model" 
      ExtendedProperties medium(p(start = 700.0),
       h(start = 8.0e5));
      parameter Real dh = 80000.0 "80 kJ/second";
      parameter Real dp = 1.0e6 "10 bars per second";
    equation 
      der(medium.p) = dp;
      der(medium.h) = dh;
      annotation (experiment(StopTime=22, NumberOfIntervals=2500),
          experimentSetupOutput,
        Documentation(info="<html>
<body>
<h3>Example:TestTwoPhaseStates</h3>
</p> For details see the documentation of the example package TwoPhaseWater<p>
</body>
</html>
"));
    end TestTwoPhaseStates;
  end TwoPhaseWater;
  
  package TestOnly "examples for testing purposes: move for final version " 
    extends Modelica.Icons.Library;
    model MixIdealGasAir "Ideal gas air medium model" 
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.CombustionAir;
      Medium.BaseProperties medium(
         T(start = 200.0),
         X(start = {0.2,0.8}),
         p(start = 1.0e5));
      Medium.BaseProperties medium2(
         T(start = 300.0),
         X(start = {0.2,0.8}),
         p(start = 2.0e5));
      Medium.SpecificHeatCapacity cp=Medium.heatCapacity_cp(medium.state);
      Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(medium.state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium.state);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium.state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium.state);
      Medium.DynamicViscosity eta= Medium.dynamicViscosity(medium.state);
      Medium.ThermalConductivity lambda= Medium.thermalConductivity(medium.state);
      Real beta = Medium.isobaricExpansionCoefficient(medium.state);
      Real gamma2 = Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0e5, medium);
      annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"));
    equation 
      der(medium.p) = 1000.0;
      der(medium.T) = 1000;
      medium.X = {0.2,0.8};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X[1]) = {0.0,0.0};
    //  s2 = s;
    end MixIdealGasAir;
    
    model FlueGas "Ideal gas flue gas  model" 
      extends Modelica.Icons.Example;
      package Medium = IdealGases.MixtureGases.FlueGasLambdaOnePlus;
      Medium.ThermodynamicState state(
         T(start = 200.0),
         X(start = {0.2,0.3,0.4,0.1}),
         p(start = 1.0e5));
      Medium.BaseProperties medium2(
         T(start = 300.0),
         X(start = {0.2,0.1,0.3,0.4}),
         p(start = 2.0e5));
      Medium.SpecificHeatCapacity cp=Medium.heatCapacity_cp(state);
      Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(state);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(state);
      Medium.SpecificEntropy s=Medium.specificEntropy(state);
      Medium.SpecificEntropy s2=Medium.specificEntropy(medium2.state);
      Medium.VelocityOfSound a=Medium.velocityOfSound(state);
      Real beta = Medium.isobaricExpansionCoefficient(state);
      Real gamma2 = Medium.isothermalCompressibility(medium2.state);
      Medium.SpecificEnthalpy h_is = Medium.isentropicEnthalpyApproximation(2.0e5, medium2);
      parameter Real[4] MMx = Medium.data.MM;
      Real MM =  1/sum(state.X[j]/MMx[j] for j in 1:4) "molar mass";
      Real[4] dddX=Medium.density_derX(medium2.state);
      annotation (Documentation(info="<html>
<body>
<p>An example for using ideal gas properties and how to compute isentropic enthalpy changes.
The function that is implemented is approximate, but usually very good: the second medium record medium2
is given to compare the approximation.
</p>
</body>
</html>"));
    equation 
      der(state.p) = 1000.0;
      der(state.T) = 1000;
      state.X = {0.2,0.2,0.4,0.2};
      der(medium2.p) = 1.0e3;
      der(medium2.T) = 0.0;
      der(medium2.X[1:Medium.nX]) = {0.0,0.0,0.0,0.0};
    end FlueGas;
    
    package TestMedia 
      extends Modelica.Icons.Library;
      model TemplateMedium "Test Interfaces.TemplateMedium" 
        extends Modelica.Icons.Example;
        package Medium = Interfaces.TemplateMedium;
        Medium.ThermodynamicState medium;
        
        Medium.DynamicViscosity eta=Medium.dynamicViscosity(medium);
        Medium.ThermalConductivity lambda=Medium.thermalConductivity(medium);
        Medium.SpecificEntropy s=Medium.specificEntropy(medium);
        Medium.SpecificHeatCapacity cp=Medium.heatCapacity_cp(medium);
        Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(medium);
        Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium);
        Medium.VelocityOfSound a=Medium.velocityOfSound(medium);
      equation 
        medium.p = 1.0e5;
        medium.T = 300 + time/1000;
      end TemplateMedium;
      
    end TestMedia;
    
    model IdealGasAir "Test IdealGas.SingleMedia.Air medium model" 
      extends Modelica.Icons.Example;
      
      parameter Real V=1;
      parameter Real m_flow_ext=0.01;
      parameter Real H_flow_ext=5000;
      
      package Medium = IdealGases.SingleGases.Air;
      // initType=Medium.Choices.Init.SteadyState,
      
      Medium.BaseProperties medium(
        p(start=1.e5),
        T(start=300));
      
      Real m(quantity=Medium.mediumName, start = 1.0);
      SI.InternalEnergy U;
      
      Medium.SpecificHeatCapacity cp=Medium.heatCapacity_cp(medium);
      Medium.SpecificHeatCapacity cv=Medium.heatCapacity_cv(medium);
      Medium.IsentropicExponent gamma=Medium.isentropicExponent(medium);
      Medium.SpecificEntropy s=Medium.specificEntropy(medium);
      Medium.VelocityOfSound a=Medium.velocityOfSound(medium);
    equation 
      
      m = medium.d*V;
      U = m*medium.u;
      
      // Mass balance
      der(m) = m_flow_ext;
      
      // Energy balance
      der(U) = H_flow_ext;
    end IdealGasAir;
  end TestOnly;
  annotation (Documentation(info="<html>
<body>
<h3>Examples</h3>
Physical properties for fluids are needed in so many different variants
that a library can only provide models for the most common situations.
With the following examples we are going to demonstrate how to use the
existing packages and functions in Modelica.Media to customize these
models for advanced applications. The high level functions try to
abstract as much as possible form the fact that different media are
based on different variables, e.g. ideal gases need pressure and
temperature, while many refrigerants are based on Helmholtz functions
of density and temperature, and many water proeprties are based on
pressure and specific enthalpy. Medium properties are needed in control
volumes in the dynamic state equations and in many thermodynamic state
locations that are independent of the dynamic states of a control
volume, e.g. at a wall temperature, an isentropic reference state or at
a phase boundary. The general struxture of the library is such that:<br>
<ul>
<li>Each medium has a model called BaseProperties. BaseProperties
contains the minimum set of medium properties needed in a dynamic
control volume model.</li>
<li>Each instance of BaseProperties contains a \"state\" record that is
an input to all the functions to compute properties. If these functions
need further inputs, like e.g. the molarMass, these are accessible as
constants in the package.</li>
<li>The simplest way to compute properties at any other reference
point is to declare an instance of ThermodynamicState and use that as
input to arbitrary property functions.<br>
</li>
</ul>
</body>
</html>
"));
  
  package Tests 
    "Library to test that all media models simulate and fulfill the expected structural properties" 
    
    extends Modelica.Icons.Library;
    
    package Components 
      "Functions, connectors and models needed for the media model tests" 
      
       extends Modelica.Icons.Library;
      
      connector FluidPort 
        "Interface for quasi one-dimensional fluid flow in a piping network (incompressible or compressible, one or more phases, one or more substances)" 
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model" annotation (choicesAllMatching=true);
        
        Medium.AbsolutePressure p "Pressure in the connection point";
        flow Medium.MassFlowRate m_flow(quantity=Medium.mediumName) 
          "Mass flow rate from the connection point into the component";
        
        Medium.SpecificEnthalpy h 
          "Specific mixture enthalpy in the connection point";
        flow Medium.EnthalpyFlowRate H_flow 
          "Enthalpy flow rate into the component (if m_flow > 0, H_flow = m_flow*h)";
        
        Medium.MassFraction X_i[Medium.nX_i] 
          "Independent mixture mass fractions m_i/m in the connection point";
        flow Medium.MassFlowRate mXi_flow[Medium.nX_i] 
          "Mass flow rates of the independent substances from the connection point into the component (if m_flow > 0, mX_flow = m_flow*X)";
        
        Medium.ExtraProperty C[Medium.nC] 
          "properties c_i/m in the connection point";
        flow Medium.ExtraPropertyFlowRate mC_flow[Medium.nC] 
          "Flow rates of auxiliary properties from the connection point into the component (if m_flow > 0, mC_flow = m_flow*C)";
        
      end FluidPort;
      
      connector FluidPort_a "Fluid connector with filled icon" 
        extends FluidPort;
        annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                   fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                   fillColor=69)), Text(extent=[-88, 206; 112, 112], string="%name")),
             Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                  fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                  fillColor=69))));
      end FluidPort_a;
      
      connector FluidPort_b "Fluid connector with outlined icon" 
        extends FluidPort;
        annotation (Diagram(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                   fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                   fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                   fillColor=7)), Text(extent=[-88, 192; 112, 98], string="%name")),
             Icon(Ellipse(extent=[-100, 100; 100, -100], style(color=69,
                  fillColor=69)), Ellipse(extent=[-100, 100; 100, -100], style(color=16,
                  fillColor=69)), Ellipse(extent=[-80, 80; 80, -80], style(color=69,
                   fillColor=7))));
      end FluidPort_b;
      
      model PortVolume 
        "Fixed volume associated with a port by the finite volume method" 
        import SI = Modelica.SIunits;
        
        replaceable package Medium = Modelica.Media.Air.SimpleAir extends 
          Modelica.Media.Interfaces.PartialMedium "Medium model" 
           annotation (choicesAllMatching=true);
        
        parameter SI.Volume V=1e-6 "Fixed size of junction volume";
        
        parameter Boolean use_p_start=true "select p_start or d_start" 
          annotation (Evaluate=true, Dialog(group="Initial pressure or initial density"));
        parameter Medium.AbsolutePressure p_start = 101325 "Initial pressure" 
          annotation (Dialog(group="Initial pressure or initial density", enable=use_p_start));
        parameter Medium.Density d_start=1 "Initial density" 
          annotation (Dialog(group="Initial pressure or initial density", enable=not use_p_start));
        parameter Boolean use_T_start=true "select T_start or h_start" 
          annotation (Evaluate=true, Dialog(group="Initial temperature or initial specific enthalpy"));
        parameter Medium.Temperature T_start = Modelica.SIunits.Conversions.from_degC(20) 
          "Initial temperature" 
          annotation (Dialog(group="Initial temperature or initial specific enthalpy", enable=use_T_start));
        parameter Medium.SpecificEnthalpy h_start = 1.e4 
          "Initial specific enthalpy" 
          annotation (Dialog(group="Initial temperature or initial specific enthalpy", enable=not use_T_start));
        parameter Medium.MassFraction X_start[Medium.nX] 
          "Initial mass fractions m_i/m" 
          annotation (Dialog(group="Only for multi-substance flow", enable=Medium.nX > 0));
        
        FluidPort_a port(redeclare package Medium = Medium) annotation (extent=[-10, -10; 10, 10], rotation=0);
        Medium.BaseProperties medium(p=port.p, h=port.h, X_i=port.X_i,
                                     preferredMediumStates=true);
        SI.Energy U "Internal energy of port volume";
        SI.Mass m "Mass of junction volume";
        SI.Mass mX_i[Medium.nX_i] 
          "Independent substance masses of junction volume";
        
        annotation (
         Icon(
            Ellipse(extent=[-100, 100; 100, -100], style(
                color=0,
                rgbcolor={0,0,0},
                gradient=3,
                fillColor=68,
                rgbfillColor={170,213,255})),
            Text(extent=[-144, 178; 146, 116], string="%name"),
            Text(
              extent=[-130, -108; 144, -150],
              style(color=0),
              string="V=%V")), Documentation(info="<html>
<p>
This component models the <b>volume</b> of <b>fixed size</b> that is
associated with the <b>fluid port</b> to which it is connected.
This means that all medium properties inside the volume, are identical
to the port medium properties. In particular, the specific enthalpy
inside the volume (= medium.h) is always identical to the specific enthalpy
in the port (port.h = medium.h). Usually, this model is used when
discretizing a component according to the finite volume method into
volumes in internal ports that only store energy and mass and into
transport elements that just transport energy, mass and momentum
between the internal ports without storing these quantities during the
transport.
</p>
</html>"),Diagram);
        
      initial equation 
        if not Medium.singleState then
          if use_p_start then
             medium.p = p_start;
          else
             medium.d = d_start;
          end if;
        end if;
        
        if use_T_start then
           medium.T = T_start;
        else
           medium.h = h_start;
        end if;
        
        medium.X_i = X_start[1:Medium.nX_i];
      equation 
        // Total quantities
           m    = V*medium.d;
           mX_i = m*medium.X_i;
           U    = m*medium.u;
        
        // Mass and energy balance
           der(m)    = port.m_flow;
           der(mX_i) = port.mXi_flow;
           der(U)    = port.H_flow;
      end PortVolume;
      
      model FixedMassFlowRate 
        "Ideal pump that produces a constant mass flow rate from a large reservoir at fixed temperature and mass fraction" 
        
        parameter Medium.MassFlowRate m_flow 
          "Fixed mass flow rate from an infinite reservoir to the fluid port";
        
        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient" 
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature" 
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=
            1.e4 "Ambient specific enthalpy" 
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=not 
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX] 
          "Ambient mass fractions m_i/m of reservoir";
        
        replaceable package Medium = Modelica.Media.Air.SimpleAir extends 
          Modelica.Media.Interfaces.PartialMedium "Medium model" 
           annotation (choicesAllMatching=true);
        
        Medium.BaseProperties medium(p=port.p, X_i=X_ambient[1:Medium.nX_i]) 
          "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(
            Rectangle(extent=[20, 60; 100, -60], style(
                color=0,
                gradient=2,
                fillColor=8)),
            Rectangle(extent=[38, 40; 100, -40], style(
                color=69,
                gradient=2,
                fillColor=69)),
            Ellipse(extent=[-100, 80; 60, -80], style(fillColor=7)),
            Polygon(points=[-60, 70; 60, 0; -60, -68; -60, 70], style(color=73,
                  fillColor=73)),
            Text(
              extent=[-54, 32; 16, -30],
              style(color=41, fillColor=41),
              string="m"),
            Text(extent=[-142, 142; 156, 88], string="%name"),
            Text(
              extent=[-154,-88; 150,-132],
              style(color=0),
              string="%m_flow"),
            Ellipse(extent=[-26, 30; -18, 22], style(color=1, fillColor=1))),
          Window(
            x=0.45,
            y=0.01,
            width=0.44,
            height=0.65),
          Diagram);
      equation 
         if use_T_ambient then
           medium.T = T_ambient;
         else
           medium.h = h_ambient;
         end if;
        
         port.m_flow   = -m_flow;
         port.mXi_flow = semiLinear(port.m_flow, port.X_i, medium.X_i);
         port.H_flow   = semiLinear(port.m_flow, port.h, medium.h);
      end FixedMassFlowRate;
      
      model FixedAmbient 
        "Ambient pressure, temperature and mass fraction source" 
        replaceable package Medium = Modelica.Media.Air.SimpleAir extends 
          Modelica.Media.Interfaces.PartialMedium "Medium model" 
           annotation (choicesAllMatching=true);
        
        parameter Boolean use_p_ambient=true "select p_ambient or d_ambient" 
          annotation (Evaluate=true, Dialog(group=
                "Ambient pressure or ambient density"));
        parameter Medium.AbsolutePressure p_ambient= 101325 "Ambient pressure"          annotation (
           Dialog(group="Ambient pressure or ambient density", enable=use_p_ambient));
        parameter Medium.Density d_ambient=1 "Ambient density" 
                             annotation (Dialog(group=
                "Ambient pressure or ambient density", enable=not use_p_ambient));
        parameter Boolean use_T_ambient=true "select T_ambient or h_ambient" 
          annotation (Evaluate=true, Dialog(group=
                "Ambient temperature or ambient specific enthalpy"));
        parameter Medium.Temperature T_ambient=
            Modelica.SIunits.Conversions.from_degC(20) "Ambient temperature" 
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=
                use_T_ambient));
        parameter Medium.SpecificEnthalpy h_ambient=
            1.e4 "Ambient specific enthalpy" 
          annotation (Dialog(group="Ambient temperature or ambient specific enthalpy",
                                                                    enable=not 
                use_T_ambient));
        parameter Medium.MassFraction X_ambient[Medium.nX] 
          "Ambient mass fractions m_i/m"                                                   annotation (Dialog(group=
                "Only for multi-substance flow", enable=Medium.nX > 0));
        
        Medium.BaseProperties medium "Medium in the source";
        FluidPort_b port(redeclare package Medium = Medium) 
          annotation (extent=[100, -10; 120, 10], rotation=0);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Icon(Ellipse(extent=[-100, 80; 100, -80], style(
                color=69,
                gradient=3,
                fillColor=69)), Text(extent=[-136, 144; 132, 82], string="%name")),
          Documentation(info="<html>
<p>
Model <b>FixedAmbient_pt</b> defines constant values for ambient conditions:
</p>
<ul>
<li> Ambient pressure.</li>
<li> Ambient temperature.</li>
<li> Ambient mass fractions (only for multi-substance flow).</li>
</ul>
<p>
Note, that ambient temperature
and mass fractions have only an effect if the mass flow
is from the ambient into the port. If mass is flowing from
the port into the ambient, the ambient definitions,
with exception of ambient pressure, do not have an effect.
</p>
</html>"));
        
      equation 
        if use_p_ambient or Medium.singleState then
          medium.p = p_ambient;
        else
          medium.d = d_ambient;
        end if;
        
        if use_T_ambient then
          medium.T = T_ambient;
        else
          medium.h = h_ambient;
        end if;
        
        medium.X_i = X_ambient[1:Medium.nX_i];
        
        port.p = medium.p;
        port.H_flow   = semiLinear(port.m_flow, port.h, medium.h);
        port.mXi_flow = semiLinear(port.m_flow, port.X_i, medium.X_i);
      end FixedAmbient;
      
      model ShortPipe "Simple pressure loss in pipe" 
         replaceable package Medium = Modelica.Media.Air.SimpleAir extends 
          Modelica.Media.Interfaces.PartialMedium "Medium model" 
           annotation (choicesAllMatching=true);
        
        parameter Medium.AbsolutePressure dp_nominal(min=1.e-10) 
          "Nominal pressure drop";
        parameter Medium.MassFlowRate m_flow_nominal(min=1.e-10) 
          "Nominal mass flow rate at nominal pressure drop";
        
        FluidPort_a port_a(redeclare package Medium = Medium) 
          annotation (extent=[-120, -10; -100, 10]);
        FluidPort_b port_b(redeclare package Medium = Medium) 
          annotation (extent=[120, -10; 100, 10]);
        // Medium.BaseProperties medium_a(p=port_a.p, h=port_a.h, X_i=port_a.X_i) 
        //   "Medium properties in port_a";
        // Medium.BaseProperties medium_b(p=port_b.p, h=port_b.h, X_i=port_b.X_i) 
        //   "Medium properties in port_b";
        Medium.MassFlowRate m_flow 
          "Mass flow rate from port_a to port_b (m_flow > 0 is design flow direction)";
        Modelica.SIunits.Pressure dp "Pressure drop from port_a to port_b";
                                                                                         annotation (Icon(
            Rectangle(extent=[-100,60; 100,-60],   style(
                color=0,
                gradient=2,
                fillColor=8)),
            Rectangle(extent=[-100,34; 100,-36],   style(
                color=69,
                gradient=2,
                fillColor=69)),
            Text(
              extent=[-150,140; 150,80],
              string="%name",
              style(gradient=2, fillColor=69)),
            Text(
              extent=[-136,-62; 122,-108],
              style(color=0, rgbcolor={0,0,0}),
              string="k=%m_flow_nominal/%dp_nominal")),
                                                 Documentation(info="<html>
<p>
Model <b>ShortPipe</b> defines a simple pipe model 
with pressure loss due to friction. It is assumed that
no mass or energy is stored in the pipe. 
The details of the pipe friction model are described
<a href=\"Modelica://Modelica_Fluid.Utilities.PipeFriction\">here</a>.
</p>
</html>"));
      equation 
        /* Handle reverse and zero flow */
        port_a.H_flow   = semiLinear(port_a.m_flow, port_a.h,   port_b.h);
        port_a.mXi_flow = semiLinear(port_a.m_flow, port_a.X_i, port_b.X_i);
        
        /* Energy, mass and substance mass balance */
        port_a.H_flow + port_b.H_flow = 0;
        port_a.m_flow + port_b.m_flow = 0;
        port_a.mXi_flow + port_b.mXi_flow = zeros(Medium.nX_i);
        
        // Design direction of mass flow rate
        m_flow = port_a.m_flow;
        
        // Pressure drop
        dp = port_a.p - port_b.p;
        m_flow = (m_flow_nominal/dp_nominal)*dp;
      end ShortPipe;
      
      package DummyFunctionMedium 
        "Fictitious liquid mixture with function-computed properties - emulates externally supplied media models" 
        
        extends Modelica.Media.Interfaces.PartialMixtureMedium(
           mediumName="Fictitous Liquid Mixture",
           substanceNames={"Kryptene","Simulene","Hysteric Acid"},
           final singleState=true,
           final reducedX=true,
           reference_X={0.3, 0.3, 0.4},
           SpecificEnthalpy(start=1.0e5, nominal=5.0e5),
           Density(start=1000, nominal=1000),
           AbsolutePressure(start=50e5, nominal=10e5),
           Temperature(start=300, nominal=300));
        
        constant SI.Pressure p0=1e5 "Reference pressure";
        constant Modelica.SIunits.Temperature T0=293.15 "Reference temperature";
        constant Modelica.SIunits.SpecificHeatCapacity cp0[nX]={4000,2500,2000};
        constant Modelica.SIunits.Density rho0[nX]={1000,500,700};
        constant SI.RelativePressureCoefficient beta[nX]={1e-3,3e-3,5e-3};
        constant Modelica.SIunits.SpecificEnthalpy h0[nX]=fill(0, nX);
        redeclare record extends ThermodynamicState 
          Modelica.SIunits.Temperature T(start=300);
          Modelica.SIunits.MassFraction X[nX];
        end ThermodynamicState;
        
        redeclare model extends BaseProperties(
          T(stateSelect=if preferredMediumStates then StateSelect.default else StateSelect.default),
          X_i(each stateSelect=if preferredMediumStates then StateSelect.prefer else StateSelect.default)) 
        equation 
          d = f_density(T,X);
          h = f_enthalpy(T,X_i);
          u = h;
          R=1;
          state.p=p;
          state.T=T;
          state.X=X;
          MM=0.1;
        end BaseProperties;
        
        redeclare function extends heatCapacity_cp 
          "Return specific heat capacity at constant pressure" 
        algorithm 
          cp := sum(cp0[i]*state.X[i] for i in 1:nX);
        end heatCapacity_cp;
        
        redeclare function extends heatCapacity_cv 
          "Return specific heat capacity at constant volume" 
        algorithm 
          cv := sum(cp0[i]*state.X[i] for i in 1:nX);
        end heatCapacity_cv;
        
        redeclare function extends density_derT_p 
          "density derivative by specific enthalpy at const pressure" 
        algorithm 
          ddTp:=sum(-rho0[i]*beta[i]/cp0[i]*state.X[i] for i in 1:nX);
        end density_derT_p;
        
        redeclare function extends density_derp_T 
          "density derivative by pressure at const specific enthalpy" 
        algorithm 
          ddpT:=0;
        end density_derp_T;
        
        redeclare function extends density_derX 
          "density derivative by pressure at const specific enthalpy" 
        protected 
          Modelica.SIunits.Density dX[nX];
          Modelica.SIunits.Density d;
        algorithm 
          for i in 1:nX loop
            dX[i] := rho0[i]*(1-beta[i]*(state.T-T0));
          end for;
          d :=1/sum(state.X[i]/dX[i] for i in 1:nX);
          for i in 1:nX loop
            dddX[i]:=-d^2/dX[i];
          end for;
        end density_derX;
        
        function f_density 
          annotation(derivative=f_density_der);
          input Modelica.SIunits.Temperature T;
          input Modelica.SIunits.MassFraction X[nX];
          output Modelica.SIunits.Density d;
        algorithm 
          d := 1/sum(X[i]/(rho0[i]*(1-beta[i]*(T-T0))) for i in 1:nX);
        end f_density;
        
        function f_density_der 
          input Modelica.SIunits.Temperature T;
          input Modelica.SIunits.MassFraction X[nX];
          input Real T_der;
          input Real X_der[nX];
          output Modelica.SIunits.Density d_der;
        protected 
                    ThermodynamicState state;
        algorithm 
          state.T:=T;
          state.X:=X;
          state.p:=1e5;
          d_der := density_derT_p(state)*T_der+density_derX(state)*X_der;
        end f_density_der;
        
        function f_enthalpy 
          input Modelica.SIunits.Temperature T;
          input Modelica.SIunits.MassFraction X_i[nX_i];
          output Modelica.SIunits.SpecificEnthalpy h;
        protected 
          SI.SpecificEnthalpy h_component[nX];
          annotation(derivative=f_enthalpy_der);
        algorithm 
          for i in 1:nX loop
            h_component[i] :=(cp0[i]*(T - T0) + h0[i]);
          end for;
          h:= sum(h_component[1:nX-1]*X_i)+ h_component[nX]*(1-sum(X_i));
        end f_enthalpy;
        
        function f_enthalpy_der 
          input Modelica.SIunits.Temperature T;
          input Modelica.SIunits.MassFraction X_i[nX_i];
          input Real T_der;
          input Real X_i_der[nX_i];
          output Modelica.SIunits.SpecificEnthalpy h_der;
          annotation(derivative=f_enthalpy_der);
        algorithm 
          h_der := sum((cp0[i]*(T-T0)+h0[i])*X_i_der[i] for i in 1:nX-1)+
                   sum(cp0[i]*X_i[i]*T_der for i in 1:nX-1)+
                       (cp0[nX]*(T-T0)+h0[nX])*(1-sum(X_i_der)) +
                        cp0[nX]*(1-sum(X_i))*T_der;
        end f_enthalpy_der;
        
      end DummyFunctionMedium;
      
      partial model PartialTestModel "Basic test model to test a medium" 
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter SI.AbsolutePressure p_start = 1.0e5 
          "Initial value of pressure";
        parameter SI.Temperature T_start = 300 "Initial value of temperature";
        parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.reference_X 
          "Initial value of mass fractions";
        PortVolume volume(redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1) 
                 annotation (extent=[-40,0; -20,20]);
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) 
                                annotation (extent=[-80,0; -60,20]);
        annotation (Diagram);
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (extent=[60,0; 40,20]);
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[0,0; 20,20]);
      equation 
        connect(fixedMassFlowRate.port, volume.port) annotation (points=[-59,10; -30,
              10],     style(color=69, rgbcolor={0,127,255}));
        connect(volume.port, shortPipe.port_a) 
          annotation (points=[-30,10; -1,10], style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe.port_b, ambient.port) 
          annotation (points=[21,10; 39,10], style(color=69, rgbcolor={0,127,255}));
      end PartialTestModel;
      
      partial model PartialTestModel2 
        "slightly larger test model to test a medium" 
        import SI = Modelica.SIunits;
        extends Modelica.Icons.Example;
        
        replaceable package Medium = Modelica.Media.Interfaces.PartialMedium 
          "Medium model";
        parameter SI.AbsolutePressure p_start = 1.0e5 
          "Initial value of pressure";
        parameter SI.Temperature T_start = 300 "Initial value of temperature";
        parameter SI.Density h_start = 1 "Initial value of specific enthalpy";
        parameter Real X_start[Medium.nX] = Medium.reference_X 
          "Initial value of mass fractions";
        PortVolume volume(redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1) 
                 annotation (extent=[-60,0; -40,20]);
        FixedMassFlowRate fixedMassFlowRate(redeclare package Medium = Medium,
          T_ambient=1.2*T_start,
          h_ambient=1.2*h_start,
          m_flow=1,
          X_ambient=0.5*X_start) 
                                annotation (extent=[-100,0; -80,20]);
        annotation (Diagram);
        FixedAmbient ambient(
          redeclare package Medium = Medium,
          T_ambient=T_start,
          h_ambient=h_start,
          X_ambient=X_start,
          p_ambient=p_start) annotation (extent=[92,0; 72,20]);
        ShortPipe shortPipe(redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[-30,0; -10,20]);
        PortVolume volume1(
                          redeclare package Medium = Medium,
                          p_start=p_start,
                          T_start=T_start,
                          h_start=h_start,
                          X_start = X_start,
                          V=0.1) 
                 annotation (extent=[0,0; 20,20]);
        ShortPipe shortPipe1(
                            redeclare package Medium = Medium,
          m_flow_nominal=1,
          dp_nominal=0.1e5) 
          annotation (extent=[36,0; 56,20]);
      equation 
        connect(fixedMassFlowRate.port, volume.port) annotation (points=[-79,10; -50,
              10],     style(color=69, rgbcolor={0,127,255}));
        connect(volume.port, shortPipe.port_a) 
          annotation (points=[-50,10; -31,10],style(color=69, rgbcolor={0,127,255}));
        connect(volume1.port, shortPipe1.port_a) 
          annotation (points=[10,10; 35,10],  style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe.port_b, volume1.port) 
          annotation (points=[-9,10; 10,10], style(color=69, rgbcolor={0,127,255}));
        connect(shortPipe1.port_b, ambient.port) 
          annotation (points=[57,10; 71,10], style(color=69, rgbcolor={0,127,255}));
      end PartialTestModel2;
    end Components;
    
    package MediaTestModels "Test models to test all media" 
      extends Modelica.Icons.Library;
      package Air "Test models of library Modelica.Media.Air" 
        extends Modelica.Icons.Library;
        model SimpleAir "Test Modelica.Media.Air.SimpleAir" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.SimpleAir);
        end SimpleAir;
        
        model DryAirNasa "Test Modelica.Media.Air.DryAirNasa" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.DryAirNasa);
        end DryAirNasa;
        
        model MoistAir "Test Modelica.Media.Air.MoistAir" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Air.MoistAir);
        end MoistAir;
      end Air;
      
      package IdealGases "Test models of library Modelica.Media.IdealGases" 
        extends Modelica.Icons.Library;
        
        model Air "Test single gas Modelica.Media.IdealGases.SingleGases.Air" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.IdealGases.SingleGases.Air);
        end Air;
        
        model SimpleNaturalGas 
          "Test mixture gas Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.IdealGases.MixtureGases.SimpleNaturalGas);
        end SimpleNaturalGas;
        
      end IdealGases;
      
      package Incompressible 
        "Test models of library Modelica.Media.Incompressible" 
        extends Modelica.Icons.Library;
        model Glycol47 "Test Modelica.Media.Incompressible.Examples.Glycol47" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.Incompressible.Examples.Glycol47(final 
                  singleState =                                                   true,
                  final enthalpyOfT =                                                              true));
        end Glycol47;
        
        model Glycol47_old 
          "Test Modelica.Media.Incompressible.Examples.Glycol47_old" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.Incompressible.Examples.Glycol47_old);
        end Glycol47_old;
        
        model Essotherm650 
          "Test Modelica.Media.Incompressible.Examples.Essotherm65" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.Incompressible.Examples.Essotherm650);
        end Essotherm650;
      end Incompressible;
      
      package Water "Test models of library Modelica.Media.Water" 
        extends Modelica.Icons.Library;
        model ConstantPropertyLiquidWater 
          "Test Modelica.Media.Water.ConstantPropertyLiquidWater" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.Water.ConstantPropertyLiquidWater);
        end ConstantPropertyLiquidWater;
        
        model IdealSteam "Test Modelica.Media.Water.IdealSteam" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.IdealSteam);
        end IdealSteam;
        
        model WaterIF97OnePhase_ph 
          "Test Modelica.Media.Water.WaterIF97OnePhase_ph" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = 
                Modelica.Media.Water.WaterIF97OnePhase_ph,
            fixedMassFlowRate(use_T_ambient=false, h_ambient=363755),
            ambient(use_T_ambient=false, h_ambient=112570));
        end WaterIF97OnePhase_ph;
        
        model WaterIF97_pT "Test Modelica.Media.Water.WaterIF97_pT" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_pT);
        end WaterIF97_pT;
        
        model WaterIF97_ph "Test Modelica.Media.Water.WaterIF97_ph" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_ph,
            ambient(use_T_ambient=false, h_ambient=112570),
            fixedMassFlowRate(use_T_ambient=false, h_ambient=363755));
        end WaterIF97_ph;
        /*        
        model WaterIF97_dT "Test Modelica.Media.Water.WaterIF97_dT" 
          extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
             redeclare package Medium = Modelica.Media.Water.WaterIF97_dT,
              ambient(use_p_ambient=false, d_ambient=996.557));
        end WaterIF97_dT;
*/
      end Water;
      
      model TestDummyFunctionMedium 
        "Test Modelica.Media.Examples.Tests.Components.DummyFunctionMedium" 
        extends Modelica.Media.Examples.Tests.Components.PartialTestModel(
           redeclare package Medium = 
              Modelica.Media.Examples.Tests.Components.DummyFunctionMedium);
      end TestDummyFunctionMedium;
    end MediaTestModels;
  end Tests;
end Examples;


package Interfaces "Interfaces for media models" 
  
  annotation (Documentation(info="<HTML>
<p>
This package provides basic interfaces definitions of media models for different
kind of media.
</p>
</HTML>"));
  
  extends Modelica.Icons.Library;
  import SI = Modelica.SIunits;
  
  partial package TemplateMedium "Template for media models" 
    /* For a new medium, make a copy of this package and remove
     the "partial" keyword from the package definition above.
     The statement below extends from PartialMedium and sets some
     package constants. Provide values for these constants
     that are appropriate for your medium model. Note that other 
     constants (such as nX, nX_i) are automatically defined by
     definitions given in the base class Interfaces.PartialMedium"
  */
    extends Modelica.Media.Interfaces.PartialMedium(
      mediumName="NameOfMedium",
      substanceNames={"NameOfMedium"},
      singleState=false,
      final reducedX = true,
      Temperature(min=273, max=450, start=323));
      /* The vector substanceNames is mandatory, as the number of 
         substances is determined based on its size. Here we assume
         a single-component medium. 
         singleState is true if u and d do not depend on pressure, but only
         on a thermal variable (temperature or enthalpy). Otherwise, set it
         to false.
         For a single-substance medium, just set reducedX to true, and there's
         no need to bother about medium compositions at all. Otherwise, set
         final reducedX = true if the medium model has nS-1 independent mass
         fraction, or reducedX = false if the medium model has nS independent
         mass fractions. 
	 It is also possible to redeclare the min, max, and start attributes of
	 Medium types, defined in the base class Interfaces.PartialMedium
	 (the example of Temperature is shown here). Min and max attributes 
	 should be set in accordance to the limits of validity of the medium 
	 model, while the start attribute should be a reasonable default value
	 for the initialization of nonlinear solver iterations */
    
    /* Provide an implementation of model BaseProperties,
     that is defined in PartialMedium. Select two independent
     variables from p, T, d, u, h. The other independent
     variables are the mass fractions "X_i", if there is more
     than one substance. Provide 3 equations to obtain the remaining
     variables as functions of the independent variables. 
     It is also necessary to provide two additional equations to set 
     the gas constant R and the molar mass MM of the medium.
     Finally, the thermodynamic state vector, defined in the base class
     Interfaces.PartialMedium.BaseProperties, should be set, according to
     its definition (see ThermodynamicState below).
     The computation of vector X[nX] from X_i[nX_i] is already included in 
     the base class Interfaces.PartialMedium.BaseProperties, so it should not
     be repeated here.
     The code fragment below is for a single-substance medium with
     p,T as independent variables.
  */
    
    redeclare model extends BaseProperties "Base properties of medium" 
    equation 
      d = 1;
      h = 0;
      u = h - p/d;
      p = state.p;
      T = state.T;
      MM = 0.024;
      R = 8.3144/MM;
      state.p = p;
      state.T = T;
    end BaseProperties;
    
    /* Provide implementations of the following optional properties.
     If not available, delete the corresponding function.
     The record "ThermodynamicState" contains the input arguments
     of all the function and is defined together with the used
     type definitions in PartialMedium. The record most often contains two of the
     variables "p, T, d, h" (e.g. medium.T)
  */
    redeclare replaceable record ThermodynamicState 
      "a selction of variables that uniquely defines the thermodynamic state" 
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
    end ThermodynamicState;
    
    redeclare function extends dynamicViscosity "Return dynamic viscosity" 
    algorithm 
      eta := 10 - state.T*0.3 + state.p*0.2;
    end dynamicViscosity;
    
    redeclare function extends thermalConductivity 
      "Return thermal conductivity" 
    algorithm 
      lambda := 0;
    end thermalConductivity;
    
    redeclare function extends specificEntropy "Return specific entropy" 
    algorithm 
      s := 0;
    end specificEntropy;
    
    redeclare function extends heatCapacity_cp 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      cp := 0;
    end heatCapacity_cp;
    
    redeclare function extends heatCapacity_cv 
      "Return specific heat capacity at constant volume" 
    algorithm 
      cv := 0;
    end heatCapacity_cv;
    
    redeclare function extends isentropicExponent "Return isentropic exponent" 
      extends Modelica.Icons.Function;
    algorithm 
       gamma := 0;
    end isentropicExponent;
    
    redeclare function extends velocityOfSound "Return velocity of sound" 
      extends Modelica.Icons.Function;
    algorithm 
      a := 0;
    end velocityOfSound;
    
    annotation (Documentation(info="<HTML>
<p>
This package is a <b>template</b> for <b>new medium</b> models. For a new
medium model just make a copy of this package, remove the
\"partial\" keyword from the package and provide
the information that is requested in the comments of the
Modelica source.
</p>
</HTML>"));
  end TemplateMedium;
  
  partial package PartialMedium 
    "Partial medium properties (base package of all media packages)" 
    
    import SI = Modelica.SIunits;
    extends Modelica.Icons.Library;
    
    // Constants to be set in Medium
    constant String mediumName "Name of the medium";
    constant String substanceNames[:] = {mediumName} 
      "Names of the mixture substances. Set substanceNames={mediumName} if only one substance.";
    constant String extraPropertiesNames[:]= fill("",0) 
      "Names of the additional (extra) transported properties. Set extraPropertiesNames=fill(\"\",0) if unused";
    constant Boolean singleState 
      "= true, if u and d are not a function of pressure";
    constant AbsolutePressure reference_p = 101325 
      "Reference pressure of Medium: default 1 atmosphere";
    constant MassFraction reference_X[nX]=fill(1/nX,nX) 
      "Default mass fractions of medium";
    constant Boolean reducedX = true 
      "= true if medium contains the equation sum(X) = 1.0; set reducedX=true if only one substance (see docu for details)";
    final constant Integer nS = size(substanceNames,1) "Number of substances" annotation(Evaluate=true);
    final constant Integer nX = if nS==1 then 0 else nS 
      "Number of mass fractions (= 0, if only one substance)"                                                   annotation(Evaluate=true);
    final constant Integer nX_i = if reducedX then nS-1 else nS 
      "Number of structurally independent mass fractions (see docu for details)"
                                                                                 annotation(Evaluate=true);
    final constant Integer nC = size(extraPropertiesNames,1) 
      "Number of extra (outside of standard mass-balance) transported properties"
                                                                                  annotation(Evaluate=true);
    constant FluidConstants[nS] fluidConstants "fluid constants";
    
    record FluidConstants 
      "critical, triple, molecular and other standard data of fluid" 
      extends Modelica.Icons.Record;
      String iupacName "complete IUPAC name";
      String casRegistryNumber "chemical abstracts sequencing number";
      String chemicalFormula "Chemical formula, (brutto, nomenclature according to Hill";
      String structureFormula "Chemical structure formula";
      MolarMass molarMass "molar mass";
      Temperature criticalTemperature "critical temperature";
      AbsolutePressure criticalPressure "critical pressure";
      MolarVolume criticalMolarVolume "critical molar Volume";
      Real acentricFactor "Pitzer acentric factor";
      Temperature triplePointTemperature "triple point temperature";
      AbsolutePressure triplePointPressure "triple point pressure";
      Temperature meltingPoint "melting point at 101325 Pa";
      Temperature normalBoilingPoint "normal boiling point (at 101325 Pa)";
      DipoleMoment dipoleMoment 
        "dipole moment of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
      constant Boolean hasIdealGasHeatCapacity=false 
        "true if ideal gas heat capacity is available";
      constant Boolean hasCriticalData=false "true if critical data are known";
      constant Boolean hasDipoleMoment=false "true if a dipole moment known";
      constant Boolean hasFundamentalEquation=false 
        "true if a fundamental equation";
      constant Boolean hasLiquidHeatCapacity=false 
        "true if liquid heat capacity is available";
      constant Boolean hasSolidHeatCapacity=false 
        "true if solid heat capacity is available";
      constant Boolean hasAccurateViscosityData=false 
        "true if accurate data for a viscosity function is available";
      constant Boolean hasAccurateConductivityData=false 
        "true if accurate data for thermal conductivity is available";
      constant Boolean hasVapourPressureCurve=false 
        "true if vapour pressure data, e.g. Antoine coefficents are known";
      constant Boolean hasAcentricFactor=false 
        "true if Pitzer accentric factor is known";
      //       constant String fundamentalEquationSource="none" "source of the fundamental equation model";
      //       constant String criticalDataSource="none" "source for critical data";
      //       constant String idealGasHeatCapacitySource="none" "data source for ideal gas heat capacity coefficients";
    end FluidConstants;
    
    replaceable record ThermodynamicState 
      "Minimal variable set that is available as input argument to every medium function" 
      extends Modelica.Icons.Record;
    end ThermodynamicState;
    
    replaceable record BasePropertiesRecord 
      "Variables contained in every instance of BaseProperties" 
      extends Modelica.Icons.Record;
      AbsolutePressure p "Absolute pressure of medium";
      Density d "Density of medium";
      Temperature T "Temperature of medium";
      MassFraction[nX] X(start=reference_X) 
        "Mass fractions (= (component mass)/total mass  m_i/m)";
      MassFraction[nX_i] X_i(start=reference_X[1:nX_i]) 
        "Structurally independent mass fractions"                                     annotation (Hide=true);
      SpecificEnthalpy h "Specific enthalpy of medium";
      SpecificInternalEnergy u "Specific internal energy of medium";
      SpecificHeatCapacity R "Gas constant (of mixture if applicable)";
      MolarMass MM "Molar mass (of mixture or single fluid)";
    end BasePropertiesRecord;
    
    replaceable partial model BaseProperties 
      "Base properties (p, d, T, h, u, R, MM and, if applicable, X) of a medium" 
      extends BasePropertiesRecord;
      ThermodynamicState state 
        "thermodynamic state variables for optional functions";
      parameter Boolean preferredMediumStates=false 
        "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
        annotation (Hide=true, Evaluate=true, Dialog(tab="Advanced"));
      
      annotation(structurallyIncomplete);
      SI.Conversions.NonSIunits.Temperature_degC T_degC=Modelica.SIunits.Conversions.to_degC(T) 
        "Temperature of medium in [degC]";
      SI.Conversions.NonSIunits.Pressure_bar p_bar=Modelica.SIunits.Conversions.to_bar(p) 
        "Absolute pressure of medium in [bar]";
      //       MassFraction X[nX](start=reference_X[1:nX]) 
      //         "Independent mass fractions" annotation(Hide=true);
      //         "= true if StateSelect.prefer shall be used for the independent property variables of the medium"
      //         annotation (Hide=true, Evaluate=true, Dialog(tab="Advanced"));
      annotation (Documentation(info="<html>
<p>
Model <b>BaseProperties</b> is a model within package <b>PartialMedium</b>
and contains the <b>declarations</b> of the minimum number of
variables that every medium model is supposed to support.
A specific medium inherits from model <b>BaseProperties</b> and provides
the equations for the basic properties. Note, that in package
PartialMedium the following constants are defined:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (used to check whether two media in a model
          are the same)</td></tr>
  <tr><td>String</td><td>substanceNames</td>
      <td>Names of the mixture substances that are treated
          as independent.
          If medium consists of a single substance, set substanceNames=fill(\"\",0).
          If medium consists of n substances, provide either n-1 or n
          substance names, depending whether mass fractions
          PartialMedium.BaseProperties.X shall have
          dimension PartialMedium.nX = n-1 or PartialMedium.nX = n</td></tr>
  <tr><td>Boolean</td><td>incompressible</td>
      <td>= true, if density is constant; otherwise set it to false</td></tr>
</table>
<p>
In every medium <b>3+nX equations</b> have to be defined that
provide relations between the following <b>5+nX variables</b>, declared
in model BaseProperties, where nX is the number of independent
mass fractions defined in package PartialMedium:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>T</td>
      <td>K</td>
      <td>temperature</td></tr>
  <tr><td>p</td>
      <td>Pa</td>
      <td>absolute pressure</td></tr>
  <tr><td>d</td>
      <td>kg/m^3</td>
      <td>density</td></tr>
  <tr><td>h</td>
      <td>J/kg</td>
      <td>specific enthalpy</td></tr>
  <tr><td>u</td>
      <td>J/kg</td>
      <td>specific internal energy</td></tr>
  <tr><td>X[nX]</td>
      <td>kg/kg</td>
      <td>independent mass fractions m_i/m</td></tr>
</table>
<p>
In some components, such as \"Ambient\", explicit equations for
medium variables are provided as \"boundary conditions\".
For example, the \"Ambient\" component may define a temperature
T_ambient.
</html>"), Icon(Rectangle(extent=[-100, 100; 100, -100], style(fillColor=7)),
            Text(extent=[-152, 164; 152, 102], string="%name")));
    equation 
      X_i = X[1:nX_i];
      if nX > 1 then
         if reducedX then
            X[nX] = 1 - sum(X_i);
         end if;
         for i in 1:nX loop
           assert(X[i] >= -1.e-5 and X[i] <= 1 + 1.e-5, "Mass fraction X[" +
             String(i) + "] = " + String(X[i]) + "of substance " +
             substanceNames[i] + "\nof medium " + mediumName +
             " is not in the range 0..1");
        end for;
      end if;
      
      assert(p >= 0.0, "Pressure (= " + String(p) + " Pa) of medium \"" + mediumName
             + "\" is negative\n(Temperature = " + String(T)+ " K)");
      
      /*  function checkParameters 
    "Checks the validity of the medium parameters" 
    extends Modelica.Icons.Function;
    input String mediumName;
    input Boolean incompressible;
    input Integer nX;
  algorithm 
    for i in 1:nX loop
      assertX_start[i] >= 0.0, "
         Wrong initialization in medium \""
         + mediumName + "\":
         The start value X_start("
         + integerString(i) + ") = " + String(X_start[i])
         + "
         is negative. It must be positive.
         ");
    end for;
    
    assert(nX == 0 or abs(sum(X_start) - 1.0) < 1.e-10, "
       Wrong initialization in medium \""
       + mediumName + "\":
       This medium requires that the start values X_start for the mass
       fractions sum up to 1. However, sum(X_start) = "
       + String(sum(X_start)) + ".
       ");
  end checkParameters; 
equation 
  checkParameters(mediumName, incompressible, nX);
*/
    end BaseProperties;
    
    replaceable partial function setState "Return thermodynamic state" 
      extends Modelica.Icons.Function;
      output ThermodynamicState state;
    end setState;
    
    replaceable partial function dynamicViscosity "Return dynamic viscosity" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DynamicViscosity eta "Dynamic viscosity";
    end dynamicViscosity;
    
    replaceable partial function thermalConductivity 
      "Return thermal conductivity" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output ThermalConductivity lambda "Thermal conductivity";
    end thermalConductivity;
    
    replaceable function prandtlNumber "Returns the Prandtl number" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output PrandtlNumber Pr "Prandtl number";
    algorithm 
      Pr := dynamicViscosity(state)*heatCapacity_cp(state)/
         thermalConductivity(state);
    end prandtlNumber;
    
    replaceable partial function specificEntropy "Return specific entropy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificEntropy s "Specific entropy";
    end specificEntropy;
    
    replaceable partial function heatCapacity_cp 
      "Return specific heat capacity at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificHeatCapacity cp 
        "Specific heat capacity at constant pressure";
    end heatCapacity_cp;
    
    replaceable partial function heatCapacity_cv 
      "Return specific heat capacity at constant volume" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SpecificHeatCapacity cv 
        "Specific heat capacity at constant volume";
    end heatCapacity_cv;
    
    replaceable partial function isentropicExponent 
      "Return isentropic exponent" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output IsentropicExponent gamma "Isentropic exponent";
    end isentropicExponent;
    
    replaceable partial function isentropicEnthalpy 
      "Return isentropic enthalpy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p_downstream "downstream pressure";
      input ThermodynamicState refState "reference state for entropy";
      output SpecificEnthalpy h_is "Isentropic enthalpy";
    end isentropicEnthalpy;
    
    replaceable partial function velocityOfSound "Return velocity of sound" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output VelocityOfSound a "Velocity of sound";
    end velocityOfSound;
    
    replaceable partial function isobaricExpansionCoefficient 
      "Returns overall the isobaric expansion coefficient beta" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output IsobaricExpansionCoefficient beta "isobaric expansion coefficient";
    end isobaricExpansionCoefficient;
    
    replaceable partial function isothermalCompressibility 
      "Returns overall the isothermal compressibility factor" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output SI.IsothermalCompressibility kappa "isothermal compressibility";
    end isothermalCompressibility;
    
    // explicit derivative functions for finite element models
    replaceable partial function density_derp_h 
      "density derivative by pressure at const specific enthalpy" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByPressure ddph "density derivative by pressure";
    end density_derp_h;
    
    replaceable partial function density_derh_p 
      "density derivative by specific enthalpy at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByEnthalpy ddhp 
        "density derivative by specific enthalpy";
    end density_derh_p;
    
    replaceable partial function density_derp_T 
      "density derivative by pressure at const temperature" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByPressure ddpT "density derivative by pressure";
    end density_derp_T;
    
    replaceable partial function density_derT_p 
      "density derivative by temperature at constant pressure" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state;
      output DerDensityByTemperature ddTp "density derivative by temperature";
    end density_derT_p;
    
  replaceable partial function density_derX 
      "density derivative by mass fraction" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output Density[nX] dddX "derivative of density by mass fraction";
  end density_derX;
    
  replaceable partial function molarMass "return the molar mass of the medium" 
    extends Modelica.Icons.Function;
    input ThermodynamicState state;
    output MolarMass MM "mixture molar mass";
  end molarMass;
    
  type AbsolutePressure = SI.AbsolutePressure (
        min=0,
        max=1.e8,
        nominal=1.e5,
        start=1.e5) "Absolute pressure with medium specific attributes";
    
    type Density = SI.Density (
        min=0,
        max=1.e5,
        nominal=1,
        start=1);
    type DynamicViscosity = SI.DynamicViscosity (
        min=0,
        max=1.e8,
        nominal=1.e-3,
        start=1.e-3);
    type EnthalpyFlowRate = Real (
         unit="J/(kg.s)",
         nominal=1000.0,
         min=-1.0e8,
         max=1.e8);
    type MassFlowRate = SI.MassFlowRate (
        quantity="MassFlowRate." + mediumName,
        min=-1.0e5,
        max=1.e5);
    type MassFraction = Real (
        quantity="MassFraction",
        final unit="kg/kg",
        min=0,
        max=1,
        nominal=0.1);
    type MoleFraction = Real (
        quantity="MoleFraction",
        final unit="mol/mol",
        min=0,
        max=1,
        nominal=0.1);
    type MolarMass = SI.MolarMass (
        min=0.001,
        max=0.25,
        nominal=0.032);
    type MolarVolume = SI.MolarVolume (
       min = 1e-6,
       max = 1.0e6,
       nominal = 1.0);
    type IsentropicExponent = SI.RatioOfSpecificHeatCapacities (
        min=1,
        max=1.7,
        nominal=1.2,
        start=1.2);
    type SpecificEnergy = SI.SpecificEnergy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6);
    type SpecificInternalEnergy = SpecificEnergy;
    type SpecificEnthalpy = SI.SpecificEnthalpy (
        min=-1.0e8,
        max=1.e8,
        nominal=1.e6);
    type SpecificEntropy = SI.SpecificEntropy (
        min=-1.e6,
        max=1.e6,
        nominal=1.e3);
    type SpecificHeatCapacity = SI.SpecificHeatCapacity (
        min=0,
        max=1.e6,
        nominal=1.e3,
        start=1.e3);
    type SurfaceTension = SI.SurfaceTension;
    type Temperature = SI.Temperature (
        min=1,
        max=1.e4,
        nominal=300,
        start=300);
    type ThermalConductivity = SI.ThermalConductivity (
        min=0,
        max=500,
        nominal=1,
        start=1);
    type PrandtlNumber = SI.PrandtlNumber (
       min = 1e-3,
       max = 1e5,
       nominal = 1.0);
    type VelocityOfSound = SI.Velocity (
        min=0,
        max=1.e5,
        nominal=1000,
        start=1000);
    type ExtraProperty = Real (
       min = 0.0,
       start = 1.0) "unspecified, mass-specific property transported by flow";
    type CumulativeExtraProperty = Real (
       min = 0.0,
       start = 1.0) "conserved integral of unspecified, mass specific property";
    type ExtraPropertyFlowRate = Real 
      "flow rate of unspecified, mass-specific property";
    type IsobaricExpansionCoefficient = Real (
       min = 1e-8,
       max = 1.0e8,
       unit = "1/K") "isobaric expansion coefficient";
  type DipoleMoment = Real (
     min = 0.0,
     max = 2.0,
     unit = "debye",
     quantity="ElectricDipoleMoment");
    
    type DerDensityByPressure = SI.DerDensityByPressure;
    type DerDensityByEnthalpy = SI.DerDensityByEnthalpy;
    type DerEnthalpyByPressure = SI.DerEnthalpyByPressure;
    type DerDensityByTemperature = SI.DerDensityByTemperature;
    
    package Choices "Types, constants to define menu choices" 
      package Init 
        "Type, constants and menu choices to define initialization, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer NoInit=1;
        constant Integer InitialStates=2;
        constant Integer SteadyState=3;
        constant Integer SteadyMass=4;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  NoInit "NoInit (no initialization)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  InitialStates "InitialStates (initialize medium states)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  SteadyState "SteadyState (initialize in steady state)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  SteadyMass 
                "SteadyMass (initialize density or pressure in steady state)"));
        end Temp;
      end Init;
      
      package ReferenceEnthalpy 
        "Type, constants and menu choices to define reference enthalpy, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer ZeroAt0K=1;
        constant Integer ZeroAt25C=2;
        constant Integer UserDefined=3;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0K 
                "The enthalpy is 0 at 0 K (default), if the enthalpy of formation is excluded",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt25C 
                "The enthalpy is 0 at 25 degC, if the enthalpy of formation is excluded",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  UserDefined 
                "The user-defined reference enthalpy is used at 293.15 K (25 degC)"));
          
        end Temp;
      end ReferenceEnthalpy;
      
      package ReferenceEntropy 
        "Type, constants and menu choices to define reference entropy, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer ZeroAt0K=1;
        constant Integer ZeroAt0C=2;
        constant Integer UserDefined=3;
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0K "The entropy is 0 at 0 K (default)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  ZeroAt0C "The entropy is 0 at 0 degC",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Init.
                  UserDefined 
                "The user-defined reference entropy is used at 293.15 K (25 degC)"));
          
        end Temp;
      end ReferenceEntropy;
      
      package pd 
        "Type, constants and menu choices to define whether p or d are known, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer default=1;
        constant Integer p_known=2;
        constant Integer d_known=3;
        
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.default 
                "default (no boundary condition for p or d)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.p_known 
                "p_known (pressure p is known)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.pd.d_known 
                "d_known (density d is known)"));
        end Temp;
      end pd;
      
      package Th 
        "Type, constants and menu choices to define whether T or h are known, as temporary solution until enumerations are available" 
        
        annotation (preferedView="text");
        
        extends Modelica.Icons.Library;
        constant Integer default=1;
        constant Integer T_known=2;
        constant Integer h_known=3;
        
        type Temp 
          "Temporary type with choices for menus (until enumerations are available)" 
          
          extends Integer;
          annotation (Evaluate=true, choices(
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.default 
                "default (no boundary condition for T or h)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.T_known 
                "T_known (temperature T is known)",
              choice=Modelica.Media.Interfaces.PartialMedium.Choices.Th.h_known 
                "h_known (specific enthalpy h is known)"));
        end Temp;
      end Th;
    end Choices;
    annotation (Documentation(info="<html>
<p>
<b>PartialMedium</b> is a package and contains all <b>declarations</b> for
a medium. This means that constants, models, and functions
are defined that every medium is supposed to support
(some of them are optional). A medium package
inherits from <b>PartialMedium</b> and provides the
equations for the medium.
Every medium that inherits from package PartialMedium, has to provide
values for the following <b>constants</b>:
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Type</b></td>
      <td><b>Name</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>String</td><td>mediumName</td>
      <td>Unique name of the medium (used to check whether two media in a model
          are the same)</td></tr>
  <tr><td>String</td><td>substanceNames</td>
      <td>Names of the mixture substances that are treated
          as independent.
          If medium consists of a single substance, set substanceNames=fill(\"\",0).
          If medium consists of n substances, provide either n-1 or n
          substance names, depending whether mass fractions
          PartialMedium.BaseProperties.X shall have
          dimension PartialMedium.nX = n-1 or PartialMedium.nX = n</td></tr>
  <tr><td>Boolean</td><td>incompressible</td>
      <td>= true, if density is constant; otherwise set it to false</td></tr>
</table>
<p>
The number of independent mass fractions nX = size(substanceNames,1),
where substanceNames are the names of the independent substance names
of the mixture that have to be defined for every medium (see example below).
If only one substance is present, set
substanceNames = fill(\"\",0),  i.e., give a zero dimension. In this
case the mass fractions X have also zero dimensions and do not show
up in the equations or in plots. If n substances are present,
the following possibilities exist:
</p>
<ul>
<li> Use nX = n-1 by defining n-1 substance names, i.e.,
     use the \"real\" independent number
     of n-1 mass fractions. The last mass fraction is then implicitly
     given by 1 - sum(X).</li>
<li> Use nX = n by defining n substance names, i.e.,
     use all mass fractions and interpret them
     as \"independent\" ones. In this case n (and not n-1) differential
     equations for the mass fractions are present in Modelica_Fluid.
     It is required
     that the start values for the mass fractions are consistent,
     i.e., that sum(X_start) = 1.</li>
</li>
<p>
In some cases additional medium properties are needed.
A component that needs these optional properties has to call
one of the functions listed in the following table. They are
defined as partial functions within package PartialMedium.
If a component calls such an optional function and the
medium package does not provide a new implementation for this
function, an error message is printed at translation time,
since the function is \"partial\", i.e., incomplete.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><td><b>Variable</b></td>
      <td><b>Function call</b></td>
      <td><b>Unit</b></td>
      <td><b>Description</b></td></tr>
  <tr><td>eta</td>
      <td>= dynamicViscosity(medium)</b></td>
      <td>Pa.s</td>
      <td>dynamic viscosity</td></tr>
  <tr><td>lambda</td>
      <td>= thermalConductivity(medium)</td>
      <td>W/(m.K)</td>
      <td>thermal conductivity</td></tr>
  <tr><td>s</td>
      <td>= specificEntropy(medium)</td>
      <td>J/(kg.K)</td>
      <td>specific entropy</td></tr>
  <tr><td>cp</td>
      <td>= heatCapacity_cp(medium)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant pressure</td></tr>
  <tr><td>cv</td>
      <td>= heatCapacity_cv(medium)</td>
      <td>J/(kg.K)</td>
      <td>specific heat capacity at constant density</td></tr>
  <tr><td>kappa</td>
      <td>= isentropicExponent(medium)</td>
      <td>1</td>
      <td>isentropic exponent</td></tr>
  <tr><td>a</td>
      <td>= velocityOfSound(medium)</td>
      <td>m/s</td>
      <td>velocity of sound</td></tr>
  <tr><td>sigma</td>
      <td>= surfaceTension(medium)</td>
      <td>N/m</td>
      <td>surface tension</td></tr>
</table>
<p>
A <b>medium model</b> is typically implemented in the following way
(it is assumed here that T and p are used as independent variables):
</p>
<pre>
  <b>package</b> MyMedium
    <b>extends</b> Modelica.Media.Interfaces.PartialMedium(
            mediumName     = \"MyMedium\",
            substanceNames = fill(\"\",0),
            incompressible = false,
            MassFlowRate(quantity = \"MassFlowRate.MyMedium\")),
    <b>redeclare model</b> BaseProperties
       <b>extends</b>(
          p(stateSelect=StateSelect.prefer),
          T(stateSelect=StateSelect.prefer)
       );
    <b>equation</b>
      // Properties that are always computed
      h = f1(p,T),
      d = f2(p,T),
      u  = h - p/d,
    <b>end</b> BaseProperties;
    // Properties that are optionally computed
       <b>redeclare function</b> dynamicViscosity
         <b>extends</b> ;
       <b>algorithm</b>
         eta := f3(medium.p, medium.T);
       <b>end</b> dynamicViscosity;
  <b>end</b> MyMedium;
</pre>
<p>
A <b>component</b> model using a medium model is typically implemented
in the following way:
</p>
<pre>
  <b>replaceable package</b> Medium = MyMedium <b>extends</b>
                             Modelica.Media.Interfaces.PartialMedium
                             <b>annotation</b> (choicesAllMatching = <b>true</b>);
  Medium medium_a(
    <b>final</b> p = port_a.p,
    <b>final</b> h = port_a.h,
    <b>final</b> X = port_a.X,
  Medium.DynamicViscosity eta_a = Medium.dynamicViscosity(medium_a);
</pre>
</html>
"));
  end PartialMedium;
  
  partial package PartialPureSubstance 
    "base class for pure substances of one chemical substance" 
    extends PartialMedium;
    // the following are parallel to the cape-open names
    
    replaceable partial function rho_ph 
      "compute density as a function of pressure and specific enthalpy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input SpecificEnthalpy h "specific enthalpy";
      input Integer phase =  0 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
      output Density d "density";
    end rho_ph;
    
    replaceable partial function T_ph 
      "compute temperature as a function of pressure and specific enthalpy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input SpecificEnthalpy h "specific enthalpy";
      input Integer phase =  0 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
      output Temperature T "temperature";
    end T_ph;
    
    replaceable partial function rho_pT 
      "compute density as a function of pressure and temperature" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input Temperature T "temperature";
      output Density d "density";
    end rho_pT;
    
    replaceable partial function h_pT 
      "compute specific enthalpy as a function of pressure and temperature" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input Temperature T "temperature";
      output SpecificEnthalpy h "specific enthalpy";
    end h_pT;
    
    replaceable partial function p_dT 
      "compute pressure as a function of density and temperature" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "temperature";
      input Integer phase =  0 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
      output AbsolutePressure p "pressure";
    end p_dT;
    
    replaceable partial function h_dT 
      "compute specific enthalpy as a function of density and temperature" 
      extends Modelica.Icons.Function;
      input Density d "density";
      input Temperature T "temperature";
      input Integer phase =  0 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
      output SpecificEnthalpy h "specific enthalpy";
    end h_dT;
    
  end PartialPureSubstance;
  
  partial package PartialMixtureMedium 
    "base class for pure substances of several chemical substances" 
    extends PartialMedium;
    
    //     record FluidConstants 
    //       "critical, triple, molecular and other standard data of fluid" 
    //       extends Modelica.Icons.Record;
    //       Temperature[nX] criticalTemperature "all critical temperatures";
    //       AbsolutePressure[nX] criticalPressure "all critical pressures";
    //       Density[nX] criticalDensity "all critical densities";
    //       Real[nX] omega "all Pitzer accentric factors";
    //       Temperature[nX] triplePointTemperature "all triple point temperatures";
    //       AbsolutePressure[nX] triplePointPressure "all triple point pressures";
    //       Temperature[nX] meltingPoint "all melting point temperatures at 101325 Pa";
    //       Temperature[nX] normalBoilingPoint "all normal boiling point temperatures (at 101325 Pa)";
    //       DipoleMoment[nX] dipoleMoment "all dipole moments of molecule in Debye (1 debye = 3.33564e10-30 C.m)";
    //     end FluidConstants;
    
    //     record DataSources "data availability and sources, only true if true for all components"
    //       constant Boolean hasIdealGasHeatCapacity=false "true if ideal gas heat capacity is available for all components";
    //       constant Boolean hasCriticalData=false "true if critical data are known for all components";
    //       constant Boolean hasFundamentalEquation=false "true if a fundamental equation for all components";
    //       constant Boolean hasLiquidHeatCapacity=false "true if liquid heat capacity is available for all components";
    //       constant Boolean hasSolidHeatCapacity=false "true if solid heat capacity is available for all components";
    //       constant Boolean hasAccurateViscosityData=false "true if accurate data for a viscosity function is available for all components";
    //       constant Boolean hasAccurateConductivityData=false "true if accurate data for thermal conductivity is available for all components";
    //       constant Boolean hasVapourPressureCurve=false "true if vapour pressure data, e.g. Antoine coefficents are known for all components";
    //       constant Boolean hasAccentricFactor=false "true if Pitzer accentric factor is known for all components";
    //       //       constant String fundamentalEquationSource="none" "source of the fundamental equation model";
    //       //       constant String criticalDataSource="none" "source for critical data";
    //       //       constant String idealGasHeatCapacitySource="none" "data source for ideal gas heat capacity coefficients";
    //     end DataSources;
    
    redeclare replaceable record extends ThermodynamicState 
      "thermodynamic state variables" 
      AbsolutePressure p "Absolute pressure of medium";
      Temperature T "Temperature of medium";
      MassFraction X[nX] 
        "Mass fractions (= (component mass)/total mass  m_i/m)";
    end ThermodynamicState;
    
  /* h_component cannot be used, because there must be ONE function h(T,X)
   in order that a tool can propagate computed medium data over a connector
   without recomputing it and solving a non-linear system of equations
  redeclare replaceable model extends BaseProperties 
    SpecificEnthalpy[nX] h_component 
      "specific enthalpies of the component fluids";
  end BaseProperties;
  */
    //     replaceable model EquilibriumProperties "medium properties for chemical equilibrium reactions"
    //       extends BaseProperties;
    //     end EquilibriumProperties;
    
    replaceable function gasConstant 
      "return the gas constant of the mixture (also for liquids)" 
      extends Modelica.Icons.Function;
      input ThermodynamicState state "thermodynamic state";
      output SI.SpecificHeatCapacity R "mixture gas constant";
    end gasConstant;
    
    function moleToMassFractions "Compute mass fractions X from mole fractions" 
      extends Modelica.Icons.Function;
      input SI.MoleFraction moleFractions[:] "Mole fractions of mixture";
      input MolarMass[:] MMX "molar masses of components";
      output SI.MassFraction X[size(moleFractions, 1)] 
        "Mass fractions of gas mixture";
    protected 
      MolarMass Mmix =  moleFractions*MMX "molar mass of mixture";
    algorithm 
      for i in 1:size(moleFractions, 1) loop
        X[i] := moleFractions[i]*MMX[i] /Mmix;
      end for;
    end moleToMassFractions;
    
  function massToMoleFractions "Compute mole fractions from mass fractions X" 
    extends Modelica.Icons.Function;
    //    input BasePropertiesRecord medium;
    input SI.MassFraction X[:] "Mass fractions of mixture";
    input SI.MolarMass[:] MMX "molar masses of components";
    output SI.MoleFraction moleFractions[size(X, 1)] 
        "Mole fractions of gas mixture";
    protected 
    SI.MolarMass Mmix =  0.0 "molar mass of mixture";
    //    Real invMM  "inverse mole fraction";
  algorithm 
    for i in 1:size(X, 1) loop
      Mmix := Mmix + 1/(X[i]/MMX[i]);
    end for;
    for i in 1:size(X, 1) loop
      moleFractions[i] := 1/Mmix*(X[i]/MMX[i]);
    end for;
  end massToMoleFractions;
    
  end PartialMixtureMedium;
  
  partial package PartialCondensingGases 
    "Base class for mixtures of condensing and non-condensing gases" 
    extends PartialMixtureMedium;
    
  replaceable partial function saturationPressure 
      "saturation pressure of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature Tsat "saturation temperature";
    output AbsolutePressure psat "saturation pressure";
  end saturationPressure;
    
  replaceable partial function enthalpyOfVaporization 
      "vaporization enthalpy of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy r0 "vaporization enthalpy";
  end enthalpyOfVaporization;
    
  replaceable partial function enthalpyOfLiquid 
      "liquid enthalpy of condensing fluid" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfLiquid;
    
  replaceable partial function enthalpyOfGas 
      "enthalpy of non-condensing gas mixture" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    input MassFraction[:] X "vector of mass fractions";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfGas;
    
  replaceable partial function enthalpyOfCondensingGas 
      "enthalpy of condensing gas (most often steam)" 
    extends Modelica.Icons.Function;
    input Temperature T "temperature";
    output SpecificEnthalpy h "liquid enthalpy";
  end enthalpyOfCondensingGas;
    
  end PartialCondensingGases;
  
  partial package PartialTwoPhaseMedium 
    extends PartialPureSubstance;
    
    record FluidLimits "validity limits for fluid model" 
      extends Modelica.Icons.Record;
      Temperature TMIN "minimum temperature";
      Temperature TMAX "maximum temperature";
      Density DMIN "minimum density";
      Density DMAX "maximum density";
      AbsolutePressure PMIN "minimum pressure";
      AbsolutePressure PMAX "maximum pressure";
      SpecificEnthalpy HMIN "minimum enthalpy";
      SpecificEnthalpy HMAX "maximum enthalpy";
      SpecificEntropy SMIN "minimum entropy";
      SpecificEntropy SMAX "maximum entropy";
      annotation(Documentation(
          info="<html><body>
          <p>The minimum pressure mostly applies to the liquid state only.
          The minimum density is also arbitrary, but is reasonable for techical
          applications to limit iterations in non-linear systems. The limits in
          enthalpy and entropy are used as safeguards in inverse iterations.</p>
          </body></html>"));
    end FluidLimits;
    
    //    constant FluidLimits limits "instance of data record";
    constant Boolean smoothModel 
      "true if the (derived) model should not generate state events";
    constant Boolean onePhase 
      "true if the (derived) model should never be called with two-phase inputs";
    
    redeclare replaceable record extends ThermodynamicState 
      Integer phase(min=0, max=2) 
        "phase of the fluid: 1 for 1-phase, 2 for two-phase, 0 for not known, e.g. interactive use";
    end ThermodynamicState;
    
    record SaturationProperties 
      extends Modelica.Icons.Record;
      AbsolutePressure psat "saturation pressure";
      Temperature Tsat "saturation temperature";
    end SaturationProperties;
    
    type FixedPhase = Integer(min = 1, max = 2) 
      "Integer between 1 and 2 for phase representation";
    
    replaceable partial function setDewState 
      "set the thermodynamic state on the dew line" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setDewState;
    
    replaceable partial function setBubbleState 
      "set the thermodynamic state on the bubble line" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation point";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setBubbleState;
    
    replaceable partial function setState_ph 
      "set thermodynamic state from pressure and specific enthalpy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input SpecificEnthalpy h "enthalpy";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setState_ph;
    
    replaceable partial function setState_ps 
      "set thermodynamic state from pressure and specific entropy" 
      extends Modelica.Icons.Function;
      input AbsolutePressure p "pressure";
      input SpecificEntropy h "entropy";
      input FixedPhase phase =  1 "phase: default is one phase";
      output ThermodynamicState state "complete thermodynamic state info";
    end setState_ps;
    
    replaceable partial function bubbleEnthalpy 
      "Returns bubble point specific enthalpy" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hl "boiling curve specific enthalpy";
    end bubbleEnthalpy;
    
      replaceable partial function dewEnthalpy 
      "Returns dew point specific enthalpy" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output SI.SpecificEnthalpy hv "dew curve specific enthalpy";
      end dewEnthalpy;
    
      replaceable partial function bubbleEntropy 
      "Returns bubble point specific entropy" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sl "boiling curve specific entropy";
      end bubbleEntropy;
    
      replaceable partial function dewEntropy 
      "Returns dew point specific entropy" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SI.SpecificEntropy sv "dew curve specific entropy";
      end dewEntropy;
    
      replaceable partial function bubbleDensity "Returns bubble point density" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dl "boiling curve density";
      end bubbleDensity;
    
      replaceable partial function dewDensity "Returns dew point density" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output Density dv "dew curve density";
      end dewDensity;
    
      replaceable partial function saturationPressure 
      "Returns saturation pressure" 
        extends Modelica.Icons.Function;
        input Temperature T "temperature";
        output AbsolutePressure p "saturation pressure";
      end saturationPressure;
    
      replaceable partial function saturationTemperature 
      "Returns saturation temperature" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Temperature T "saturation temperature";
      end saturationTemperature;
    
      replaceable partial function saturationTemperature_derp 
      "Returns derivatives of saturation temperature w.r.t pressure" 
        extends Modelica.Icons.Function;
        input AbsolutePressure p "pressure";
        output Real dTp "derivatives of saturation temperature w.r.t pressure";
      end saturationTemperature_derp;
      //       replaceable partial function dewPressure 
    
      //         "Returns dew line pressure, for (near)-azeotropic mixtures that can be treated as pseudo-components" 
    //         extends Modelica.Icons.Function;
    //         input SaturationProperties sat "saturation property record";
    //         output AbsolutePressure p "dew saturation pressure";
    //       end dewPressure;
    
    //       replaceable partial function bubblePressure 
    
      //         "Returns bubble line pressure, for (near)-azeotropic mixtures that can be treated as pseudo-components" 
    //         extends Modelica.Icons.Function;
    //         input SaturationProperties sat "saturation property record";
    //         output AbsolutePressure p "bubble saturation pressure";
    //       end bubblePressure;
    
      //note: for azeotropic mixtures, dewPressure and bubblePressure are needed
    
    //       replaceable partial function dewTemperature 
    
      //         "Returns dew line temperature, for (near)-azeotropic mixtures that can be treated as pseudo-components" 
    //         extends Modelica.Icons.Function;
    //         input SaturationProperties sat "saturation property record";
    //         output Temperature T "dew saturation temperature";
    //       end dewTemperature;
    
    //       replaceable partial function bubbleTemperature 
    
      //         "Returns bubble line temperature, for (near)-azeotropic mixtures that can be treated as pseudo-components" 
    //         extends Modelica.Icons.Function;
    //         input SaturationProperties sat "saturation property record";
    //         output Temperature T "bubble saturation temperature";
    //       end bubbleTemperature;
    
    replaceable partial function surfaceTension 
      "Return surface tension sigma in the two phase region" 
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output SurfaceTension sigma 
        "Surface tension sigma in the two phase region";
    end surfaceTension;
    
      replaceable partial function dBubbleDensity_dPressure 
      "Returns bubble point density derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByEnthalpy ddldp "boiling curve density derivative";
      end dBubbleDensity_dPressure;
    
      replaceable partial function dDewDensity_dPressure 
      "Returns dew point density derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerDensityByEnthalpy ddvdp "saturated steam density derivative";
      end dDewDensity_dPressure;
    
      replaceable partial function dBubbleEnthalpy_dPressure 
      "Returns bubble point specific enthalpy derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhldp 
        "boiling curve specific enthalpy derivative";
      end dBubbleEnthalpy_dPressure;
    
      replaceable partial function dDewEnthalpy_dPressure 
      "Returns dew point specific enthalpy derivative" 
        extends Modelica.Icons.Function;
        input SaturationProperties sat "saturation property record";
        output DerEnthalpyByPressure dhvdp 
        "saturated steam specific enthalpy derivative";
      end dDewEnthalpy_dPressure;
    
  end PartialTwoPhaseMedium;
  
  partial package PartialSimpleMedium 
    "Medium model with linear dependency of u, h from temperature. All other quantities, especially density, are constant." 
    
    extends Interfaces.PartialMedium(final singleState=true, final reducedX=true);
    
    import SI = Modelica.SIunits;
    constant SpecificHeatCapacity cp_const 
      "Constant specific heat capacity at constant pressure";
    constant SpecificHeatCapacity cv_const 
      "Constant specific heat capacity at constant volume";
    constant Density d_const "Constant density";
    constant DynamicViscosity eta_const "Constant dynamic viscosity";
    constant ThermalConductivity lambda_const "Constant thermal conductivity";
    constant VelocityOfSound a_const "Constant velocity of sound";
    constant Temperature T_min "Minimum temperature valid for medium model";
    constant Temperature T_max "Maximum temperature valid for medium model";
    constant Temperature T0 "Zero enthalpy temperature";
    constant MolarMass MM_const "Molar mass";
    
    redeclare model extends BaseProperties(
        T(stateSelect=StateSelect.prefer)) "Base properties" 
    equation 
      assert(T >= T_min and T <= T_max, "
Temperature T (= " + String(T) + " K) is not
in the allowed range (" + String(T_min) + " K <= T <= " + String(T_max)
         + " K)
required from medium model \"" + mediumName + "\".
");
      
      h = cp_const*(T-T0);
      u = cv_const*(T-T0);
      d = d_const;
      R = 0;
      MM = MM_const;
      
      annotation (Documentation(info="<HTML>
<p>
This is the most simple incompressible medium model, where
specific enthalpy h and specific internal energy u are only
a function of temperature T and all other provided medium
quantities are assumed to be constant.
</p>
</HTML>"));
    end BaseProperties;
    
    redeclare function extends dynamicViscosity "Return dynamic viscosity" 
    algorithm 
      eta := eta_const;
    end dynamicViscosity;
    
    redeclare function extends thermalConductivity 
      "Return thermal conductivity" 
    algorithm 
      lambda := lambda_const;
    end thermalConductivity;
    
    redeclare function extends heatCapacity_cp 
      "Return specific heat capacity at constant pressure" 
    algorithm 
      cp := cp_const;
    end heatCapacity_cp;
    
    redeclare function extends heatCapacity_cv 
      "Return specific heat capacity at constant volume" 
    algorithm 
      cv := cv_const;
    end heatCapacity_cv;
    
    redeclare function extends isentropicExponent "Return isentropic exponent" 
    algorithm 
      gamma := cp_const/cv_const;
    end isentropicExponent;
    
    redeclare function extends velocityOfSound "Velocity of sound " 
    algorithm 
      a := a_const;
    end velocityOfSound;
    
  end PartialSimpleMedium;
  
end Interfaces;


package Common "data structures and fundamental functions for fluid properties" 
  
  annotation (Documentation(info="<HTML><h4>Package description</h4>
      <p>Package Modelica.Media.Common provides records and functions shared by many of the property sub-packages.
      High accuracy fluid property models share a lot of common structure, even if the actual models are different.
      Common data structures and computations shared by these property models are collected in this library.
      </p>
      <h4>Version Info and Revision history
      </h4>
      <ul>
      <li>First implemented: <i>July, 2000</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>
      for the ThermoFluid Library with help from Jonas Eborn and Falko Jens Wagner
      </li>
      <li>Code reorganization, enhanced documentation, additional functions: <i>December, 2002</i>
      by <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a> and move to Modelica
                            properties library.</li>
      <li>Inclusion into Modelica.Media: September 2003 </li>
      </ul>
      <address>Author: Hubertus Tummescheit, <br>
      Lund University<br>
      Department of Automatic Control<br>
      Box 118, 22100 Lund, Sweden<br>
      email: hubertus@control.lth.se
      </address>
</HTML>
"));
  extends Modelica.Icons.Library;
protected 
  type Rate = Real (final quantity="Rate", final unit="s-1");
  type MolarFlowRate = Real (final quantity="MolarFlowRate", final unit="mol/s");
  type MolarReactionRate = Real (final quantity="MolarReactionRate", final unit
        ="mol/(m3.s)");
  type MolarEnthalpy = Real (final quantity="MolarEnthalpy", final unit="J/mol");
  type DerDensityByEntropy = Real (final quantity="DerDensityByEntropy", final unit
        =    "kg2.K/(m3.J)");
  type DerEnergyByPressure = Real (final quantity="DerEnergyByPressure", final unit
        =    "J/Pa");
  type DerEnergyByMoles = Real (final quantity="DerEnergyByMoles", final unit=
          "J/mol");
  type DerEntropyByTemperature = Real (final quantity="DerEntropyByTemperature",
         final unit="J/K2");
  type DerEntropyByPressure = Real (final quantity="DerEntropyByPressure",
        final unit="J/(K.Pa)");
  type DerEntropyByMoles = Real (final quantity="DerEntropyByMoles", final unit
        ="J/(mol.K)");
  type DerPressureByDensity = Real (final quantity="DerPressureByDensity",
        final unit="Pa.m3/kg");
  type DerPressureBySpecificVolume = Real (final quantity=
          "DerPressureBySpecificVolume", final unit="Pa.kg/m3");
  type DerPressureByTemperature = Real (final quantity=
          "DerPressureByTemperature", final unit="Pa/K");
  type DerVolumeByTemperature = Real (final quantity="DerVolumeByTemperature",
        final unit="m3/K");
  type DerVolumeByPressure = Real (final quantity="DerVolumeByPressure", final unit
        =    "m3/Pa");
  type DerVolumeByMoles = Real (final quantity="DerVolumeByMoles", final unit=
          "m3/mol");
  type IsenthalpicExponent = Real (final quantity="IsenthalpicExponent", unit=
          "1");
  type IsentropicExponent = Real (final quantity="IsentropicExponent", unit="1");
  type IsobaricVolumeExpansionCoefficient = Real (final quantity=
          "IsobaricVolumeExpansionCoefficient", unit="1/K");
  type IsochoricPressureCoefficient = Real (final quantity=
          "IsochoricPressureCoefficient", unit="1/Pa");
  type IsothermalCompressibility = Real (final quantity=
          "IsothermalCompressibility", unit="kg/m^3");
  type JouleThomsonCoefficient = Real (final quantity="JouleThomsonCoefficient",
         unit="K/Pa");
  // introduce min-manx-nominal values
  constant Real MINPOS=1.0e-9 
    "minimal value for physical variables which are always > 0.0";
  
  constant SI.Area AMIN=MINPOS "minimal init area";
  constant SI.Area AMAX=1.0e5 "maximal init area";
  constant SI.Area ANOM=1.0 "nominal init area";
  constant SI.AmountOfSubstance MOLMIN=-1.0*MINPOS "minimal Mole Number";
  constant SI.AmountOfSubstance MOLMAX=1.0e8 "maximal Mole Number";
  constant SI.AmountOfSubstance MOLNOM=1.0 "nominal Mole Number";
  constant SI.Density DMIN=MINPOS "minimal init density";
  constant SI.Density DMAX=1.0e5 "maximal init density";
  constant SI.Density DNOM=1.0 "nominal init density";
  constant SI.ThermalConductivity LAMMIN=MINPOS "minimal thermal conductivity";
  constant SI.ThermalConductivity LAMNOM=1.0 "nominal thermal conductivity";
  constant SI.ThermalConductivity LAMMAX=1000.0 "maximal thermal conductivity";
  constant SI.DynamicViscosity ETAMIN=MINPOS "minimal init dynamic viscosity";
  constant SI.DynamicViscosity ETAMAX=1.0e8 "maximal init dynamic viscosity";
  constant SI.DynamicViscosity ETANOM=100.0 "nominal init dynamic viscosity";
  constant SI.Energy EMIN=-1.0e10 "minimal init energy";
  constant SI.Energy EMAX=1.0e10 "maximal init energy";
  constant SI.Energy ENOM=1.0e3 "nominal init energy";
  constant SI.Entropy SMIN=-1.0e6 "minimal init entropy";
  constant SI.Entropy SMAX=1.0e6 "maximal init entropy";
  constant SI.Entropy SNOM=1.0e3 "nominal init entropy";
  constant SI.MassFlowRate MDOTMIN=-1.0e5 "minimal init mass flow rate";
  constant SI.MassFlowRate MDOTMAX=1.0e5 "maximal init mass flow rate";
  constant SI.MassFlowRate MDOTNOM=1.0 "nominal init mass flow rate";
  constant SI.MassFraction MASSXMIN=-1.0*MINPOS "minimal init mass fraction";
  constant SI.MassFraction MASSXMAX=1.0 "maximal init mass fraction";
  constant SI.MassFraction MASSXNOM=0.1 "nominal init mass fraction";
  constant SI.Mass MMIN=-1.0*MINPOS "minimal init mass";
  constant SI.Mass MMAX=1.0e8 "maximal init mass";
  constant SI.Mass MNOM=1.0 "nominal init mass";
  constant SI.MolarMass MMMIN=0.001 "minimal initial molar mass";
  constant SI.MolarMass MMMAX=250.0 "maximal initial molar mass";
  constant SI.MolarMass MMNOM=0.2 "nominal initial molar mass";
  constant SI.MoleFraction MOLEYMIN=-1.0*MINPOS "minimal init mole fraction";
  constant SI.MoleFraction MOLEYMAX=1.0 "maximal init mole fraction";
  constant SI.MoleFraction MOLEYNOM=0.1 "nominal init mole fraction";
  constant SI.MomentumFlux GMIN=-1.0e8 "minimal init momentum flux";
  constant SI.MomentumFlux GMAX=1.0e8 "maximal init momentum flux";
  constant SI.MomentumFlux GNOM=1.0 "nominal init momentum flux";
  constant SI.Power POWMIN=-1.0e8 "minimal init power or heat";
  constant SI.Power POWMAX=1.0e8 "maximal init power or heat";
  constant SI.Power POWNOM=1.0e3 "nominal init power or heat";
  constant SI.Pressure PMIN=1.0e4 "minimal init pressure";
  constant SI.Pressure PMAX=1.0e8 "maximal init pressure";
  constant SI.Pressure PNOM=1.0e5 "nominal init pressure";
  constant SI.Pressure COMPPMIN=-1.0*MINPOS "minimal init pressure";
  constant SI.Pressure COMPPMAX=1.0e8 "maximal init pressure";
  constant SI.Pressure COMPPNOM=1.0e5 "nominal init pressure";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMIN=1.0 
    "minimal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPAMAX=1.7 
    "maximal init isentropic exponent";
  constant SI.RatioOfSpecificHeatCapacities KAPPANOM=1.2 
    "nominal init isentropic exponent";
  constant SI.SpecificEnergy SEMIN=-1.0e8 "minimal init specific energy";
  constant SI.SpecificEnergy SEMAX=1.0e8 "maximal init specific energy";
  constant SI.SpecificEnergy SENOM=1.0e6 "nominal init specific energy";
  constant SI.SpecificEnthalpy SHMIN=-1.0e8 "minimal init specific enthalpy";
  constant SI.SpecificEnthalpy SHMAX=1.0e8 "maximal init specific enthalpy";
  constant SI.SpecificEnthalpy SHNOM=1.0e6 "nominal init specific enthalpy";
  constant SI.SpecificEntropy SSMIN=-1.0e6 "minimal init specific entropy";
  constant SI.SpecificEntropy SSMAX=1.0e6 "maximal init specific entropy";
  constant SI.SpecificEntropy SSNOM=1.0e3 "nominal init specific entropy";
  constant SI.SpecificHeatCapacity CPMIN=MINPOS 
    "minimal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPMAX=1.0e6 
    "maximal init specific heat capacity";
  constant SI.SpecificHeatCapacity CPNOM=1.0e3 
    "nominal init specific heat capacity";
  constant SI.Temperature TMIN=MINPOS "minimal init temperature";
  constant SI.Temperature TMAX=1.0e5 "maximal init temperature";
  constant SI.Temperature TNOM=320.0 "nominal init temperature";
  constant SI.ThermalConductivity LMIN=MINPOS 
    "minimal init thermal conductivity";
  constant SI.ThermalConductivity LMAX=500.0 
    "maximal init thermal conductivity";
  constant SI.ThermalConductivity LNOM=1.0 "nominal init thermal conductivity";
  constant SI.Velocity VELMIN=-1.0e5 "minimal init speed";
  constant SI.Velocity VELMAX=1.0e5 "maximal init speed";
  constant SI.Velocity VELNOM=1.0 "nominal init speed";
  constant SI.Volume VMIN=0.0 "minimal init volume";
  constant SI.Volume VMAX=1.0e5 "maximal init volume";
  constant SI.Volume VNOM=1.0e-3 "nominal init volume";
  
  package ThermoFluidSpecial "property records used by the ThermoFluid library" 
    
    record FixedIGProperties "constant properties for ideal gases" 
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "number of components";
      SI.MolarMass[nspecies] MM "molar mass of components";
      Real[nspecies] invMM "inverse of molar mass of components";
      SI.SpecificHeatCapacity[nspecies] R "gas constant";
      SI.SpecificEnthalpy[nspecies] Hf "enthalpy of formation at 298.15K";
      SI.SpecificEnthalpy[nspecies] H0 "H0(298.15K) - H0(0K)";
    end FixedIGProperties;
    
    record ThermoBaseVars 
      extends Modelica.Icons.Record;
      parameter Integer n(min=1) "discretization number";
      parameter Integer nspecies(min=1) "number of species";
      SI.Pressure[n] p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM,
        start=fill(1.0e5, n)) "Pressure";
      SI.Temperature[n] T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "temperature";
      SI.Density[n] d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "density";
      SI.SpecificEnthalpy[n] h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific enthalpy";
      SI.SpecificEntropy[n] s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "specific entropy";
      SI.RatioOfSpecificHeatCapacities[n] kappa "ratio of cp/cv";
      SI.Mass[n] M(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "Total mass";
      SI.Energy[n] U(
        min=EMIN,
        max=EMAX,
        nominal=ENOM) "Inner energy";
      SI.MassFlowRate[n] dM(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "Change in total mass";
      SI.Power[n] dU(
        min=POWMIN,
        max=POWMAX,
        nominal=POWNOM) "Change in inner energy";
      SI.Volume[n] V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.MassFraction[n, nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "mass fraction";
      SI.MoleFraction[n, nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "mole fraction";
      SI.Mass[n, nspecies] M_x(
        min=MMIN,
        max=MMAX,
        nominal=MNOM) "component mass";
      SI.MassFlowRate[n, nspecies] dM_x(
        min=MDOTMIN,
        max=MDOTMAX,
        nominal=MDOTNOM) "rate of change in component mass";
      MolarFlowRate[n, nspecies] dZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "rate of change in component moles";
      MolarFlowRate[n, nspecies] rZ(
        min=-1.0e6,
        max=1.0e6,
        nominal=0.0) "Reaction(source) mole rates";
      SI.MolarMass[n] MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "molar mass of mixture";
      SI.AmountOfSubstance[n] Moles(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "total moles";
      SI.AmountOfSubstance[n, nspecies] Moles_z(
        min=MOLMIN,
        max=MOLMAX,
        nominal=MOLNOM) "mole vector";
      annotation (Documentation(info="<HTML>
                         <h4>Model description</h4>
                              <p>
                              <b>ThermoBaseVars</b> is inherited by all medium property models
                              and by all models defining the dynamic states for the conservation
                              of mass and energy. Thus it is a good choice as a restricting class
                              for any medium model or dynamic state model.
                              </p>
                              </HTML>
                              "));
    end ThermoBaseVars;
    
    record ThermoProperties 
      "Thermodynamic base property data for all state models" 
      extends Modelica.Icons.Record;
      parameter Integer nspecies(min=1) "number of species";
      SI.Temperature T(
        min=TMIN,
        max=TMAX,
        nominal=TNOM) "temperature";
      SI.Density d(
        min=DMIN,
        max=DMAX,
        nominal=DNOM) "density";
      SI.Pressure p(
        min=PMIN,
        max=PMAX,
        nominal=PNOM) "pressure";
      SI.Volume V(
        min=VMIN,
        max=VMAX,
        nominal=VNOM) "Volume";
      SI.SpecificEnthalpy h(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific enthalpy";
      SI.SpecificEnergy u(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "specific inner energy";
      SI.SpecificEntropy s(
        min=SSMIN,
        max=SSMAX,
        nominal=SSNOM) "specific entropy";
      SI.SpecificGibbsFreeEnergy g(
        min=SHMIN,
        max=SHMAX,
        nominal=SHNOM) "specific Gibbs free energy";
      SI.SpecificHeatCapacity cp(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=CPMIN,
        max=CPMAX,
        nominal=CPNOM) "gas constant";
      SI.MolarMass MM(
        min=MMMIN,
        max=MMMAX,
        nominal=MMNOM) "molar mass of mixture";
      SI.MassFraction[nspecies] mass_x(
        min=MASSXMIN,
        max=MASSXMAX,
        nominal=MASSXNOM) "mass fraction";
      SI.MoleFraction[nspecies] mole_y(
        min=MOLEYMIN,
        max=MOLEYMAX,
        nominal=MOLEYNOM) "mole fraction";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.DerDensityByTemperature ddTp 
        "derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT 
        "derivative of density by pressure at constant temperature";
      SI.DerEnergyByPressure dupT 
        "derivative of inner energy by pressure at constant T";
      SI.DerEnergyByDensity dudT 
        "derivative of inner energy by density at constant T";
      SI.SpecificHeatCapacity duTp 
        "derivative of inner energy by temperature at constant p";
      SI.SpecificEnergy ddx[nspecies] 
        "derivative vector of density by change in mass composition";
      SI.SpecificEnergy[nspecies] compu(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) "inner energy of the components";
      SI.Pressure[nspecies] compp(
        min=COMPPMIN,
        max=COMPPMAX,
        nominal=COMPPNOM) "partial pressures of the components";
      SI.Velocity a(
        min=VELMIN,
        max=VELMAX,
        nominal=VELNOM) "speed of sound";
      SI.HeatCapacity dUTZ 
        "derivative of inner energy by temperature at constant moles";
      SI.MolarInternalEnergy[nspecies] dUZT 
        "derivative of inner energy by moles at constant temperature";
      SI.SpecificEnthalpy[nspecies] dHMxT(
        min=SEMIN,
        max=SEMAX,
        nominal=SENOM) 
        "derivative of total enthalpy wrt component mass at constant T";
      Real dpT "derivative of pressure w.r.t. temperature";
      Real dpZ[nspecies] "derivative of pressure w.r.t. moles";
      annotation (Documentation(info="<HTML>
        <h4>Model description</h4>
        <p>
        A base class for medium property models which work with most of the
        versions of dynamic states that are available in the ThermoFluid
        library. Currently used by all ideal gas models.
        </p>
        </HTML>
        "));
    end ThermoProperties;
    
    record ThermoProperties_ph 
      "Thermodynamic property data for pressure p and specific enthalpy h as dynamic states" 
      
      extends Modelica.Icons.Record;
      SI.Temperature T(
        min=1.0e-9,
        max=10000.0,
        nominal=298.15) "temperature";
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "density";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      SI.DerDensityByEnthalpy ddhp 
        "derivative of density by enthalpy at constant pressure";
      SI.DerDensityByPressure ddph 
        "derivative of density by pressure at constant enthalpy";
      SI.DerEnergyByPressure duph 
        "derivative of inner energy by pressure at constant enthalpy";
      Real duhp "derivative of inner energy by enthalpy at constant pressure";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which
use pressure and enthalpy as dynamic states.
This is the preferred model for fluids that can also be in the
two phase and liquid regions.
</p>
</HTML>
"));
    end ThermoProperties_ph;
    
    record ThermoProperties_pT 
      "Thermodynamic property data for pressure p and temperature T as dynamic states" 
      
      extends Modelica.Icons.Record;
      SI.Density d(
        min=1.0e-9,
        max=10000.0,
        nominal=10.0) "density";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      SI.DerDensityByTemperature ddTp 
        "derivative of density by temperature at constant pressure";
      SI.DerDensityByPressure ddpT 
        "derivative of density by pressure at constant temperature";
      SI.DerEnergyByPressure dupT 
        "derivative of inner energy by pressure at constant T";
      SI.SpecificHeatCapacity duTp 
        "derivative of inner energy by temperature at constant p";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use pressure and temperature as dynamic states.
This is a reasonable model for fluids that can also be in the gas and
liquid regions, but never in the two-phase region.
</p>
</HTML>
"));
    end ThermoProperties_pT;
    
    record ThermoProperties_dT 
      "Thermodynamic property data for density d and temperature T as dynamic states" 
      
      extends Modelica.Icons.Record;
      SI.Pressure p(
        min=1.0,
        max=1.0e9,
        nominal=1.0e5) "pressure";
      SI.SpecificEnthalpy h(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific enthalpy";
      SI.SpecificEnergy u(
        min=-1.0e8,
        max=1.0e8,
        nominal=1.0e6) "specific inner energy";
      SI.SpecificEntropy s(
        min=-1.0e6,
        max=1.0e6,
        nominal=1.0e3) "specific entropy";
      SI.SpecificHeatCapacity cp(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant pressure";
      SI.SpecificHeatCapacity cv(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "heat capacity at constant volume";
      SI.SpecificHeatCapacity R(
        min=1.0,
        max=1.0e6,
        nominal=1000.0) "gas constant";
      SI.RatioOfSpecificHeatCapacities kappa "ratio of cp/cv";
      SI.Velocity a(
        min=1.0,
        max=10000.0,
        nominal=300.0) "speed of sound";
      SI.DerEnergyByDensity dudT 
        "derivative of inner energy by density at constant T";
      annotation (Documentation(info="<HTML>
<h4>Model description</h4>
<p>
A base class for medium property models which use density and temperature as dynamic states.
This is a reasonable model for fluids that can be in the gas, liquid
and two-phase region. The model is numerically not well suited for
liquids except if the pressure is always above approx. 80% of the
critical pressure.
</p>
</HTML>
"));
    end ThermoProperties_dT;
    
    //   record GibbsDerivs
    
      //     "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature"
    //     extends Modelica.Icons.Record;
    //     Real pi "dimensionless pressure";
    //     Real tau "dimensionless temperature";
    //     Real g "dimensionless Gibbs-function";
    //     Real gpi "derivative of g w.r.t. pi";
    //     Real gpipi "2nd derivative of g w.r.t. pi";
    //     Real gtau "derivative of g w.r.t. tau";
    //     Real gtautau "2nd derivative of g w.r.t tau";
    //     Real gtaupi "mixed derivative of g w.r.t. pi and tau";
    //   end GibbsDerivs;
    
    //   record HelmholtzDerivs
    
      //     "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature"
    //     extends Modelica.Icons.Record;
    //     Real delta "dimensionless density";
    //     Real tau "dimensionless temperature";
    //     Real f "dimensionless Helmholtz-function";
    //     Real fdelta "derivative of f w.r.t. delta";
    //     Real fdeltadelta "2nd derivative of f w.r.t. delta";
    //     Real ftau "derivative of f w.r.t. tau";
    //     Real ftautau "2nd derivative of f w.r.t. tau";
    //     Real fdeltatau "mixed derivative of f w.r.t. delta and tau";
    //   end HelmholtzDerivs;
    
    record TransportProps "record with transport properties" 
      extends Modelica.Icons.Record;
      SI.DynamicViscosity eta;
      SI.ThermalConductivity lam;
    end TransportProps;
    
    function gibbsToProps_ph 
      "calulate property record for pressure and specific enthalpy as states from dimensionless Gibbs function" 
      
      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_ph pro 
        "property record for pressure and specific enthalpy as dynamic states";
    protected 
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
    algorithm 
      pro.T := g.T;
      pro.R := g.R;
      pro.d := g.p/(pro.R*pro.T*g.pi*g.gpi);
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.ddhp := -pro.d*pro.d*vt/(pro.cp);
      pro.ddph := -pro.d*pro.d*(vp*pro.cp - vt/pro.d + g.T*vt*vt)/pro.cp;
      pro.duph := -1/pro.d + g.p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + g.p/(pro.d*pro.d)*pro.ddhp;
    end gibbsToProps_ph;
    
    function gibbsToBoundaryProps 
      "calulate phase boundary property record from dimensionless Gibbs function" 
      
      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output PhaseBoundaryProperties sat "phase boundary properties";
    protected 
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
    algorithm 
      sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
      sat.h := g.R*g.T*g.tau*g.gtau;
      sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      sat.s := g.R*(g.tau*g.gtau - g.g);
      sat.cp := -g.R*g.tau*g.tau*g.gtautau;
      sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/(g.gpipi));
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
      sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
      sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
    end gibbsToBoundaryProps;
    
    function gibbsToProps_dT 
      "calulate property record for density and temperature as states from dimensionless Gibbs function" 
      
      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_dT pro 
        "property record for density and temperature as dynamic states";
    protected 
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
    algorithm 
      pro.R := g.R;
      pro.p := g.p;
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R*g.T*g.tau*g.gtau;
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/((g.p/(pro.R*g.T*g.pi*g.gpi))*g.p)*pro.cp/(vp*pro.cp + vt
        *vt*g.T);
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      
      pro.dudT := pro.cp + g.T*vt*vt/vp;
    end gibbsToProps_dT;
    
    function gibbsToProps_pT 
      "calulate property record for pressure and temperature as states from dimensionless Gibbs function" 
      
      extends Modelica.Icons.Function;
      input GibbsDerivs g "dimensionless derivatives of Gibbs function";
      output ThermoProperties_pT pro 
        "property record for pressure and temperature as dynamic states";
    protected 
      Real vt "derivative of specific volume w.r.t. temperature";
      Real vp "derivative of specific volume w.r.t. pressure";
    algorithm 
      pro.R := g.R;
      pro.d := g.p/(pro.R*g.T*g.pi*g.gpi);
      pro.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
      pro.h := g.R*g.T*g.tau*g.gtau;
      pro.s := pro.R*(g.tau*g.gtau - g.g);
      pro.cp := -pro.R*g.tau*g.tau*g.gtautau;
      pro.cv := pro.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi
         - g.tau*g.gtaupi)/g.gpipi);
      vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
      vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
      pro.kappa := -1/(pro.d*g.p)*pro.cp/(vp*pro.cp + vt*vt*g.T);
      pro.a := abs(g.R*g.T*(g.gpi*g.gpi/((g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
        tau*g.gtaupi)/(g.tau*g.tau*g.gtautau) - g.gpipi)))^0.5;
      pro.ddpT := -(pro.d*pro.d)*vp;
      pro.ddTp := -(pro.d*pro.d)*vt;
      pro.duTp := pro.cp - g.p*vt;
      pro.dupT := -g.T*vt - g.p*vp;
    end gibbsToProps_pT;
    
    function helmholtzToProps_ph 
      "calulate property record for pressure and specific enthalpy as states from dimensionless Helmholtz function" 
      
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_ph pro 
        "property record for pressure and specific enthalpy as dynamic states";
    protected 
      SI.Pressure p "pressure";
      DerPressureByDensity pd "derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv 
        "derivative of pressure w.r.t. specific volume";
    algorithm 
      pro.d := f.d;
      pro.T := f.T;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.u := f.R*f.T*f.tau*f.ftau;
      p := pro.d*pro.R*pro.T*f.delta*f.fdelta;
      pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)/pd;
      
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.
        T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddph := (f.d*(pro.cv*f.d + pt))/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.ddhp := -f.d*f.d*pt/(f.d*f.d*pd*pro.cv + f.T*pt*pt);
      pro.duph := -1/pro.d + p/(pro.d*pro.d)*pro.ddph;
      pro.duhp := 1 + p/(pro.d*pro.d)*pro.ddhp;
    end helmholtzToProps_ph;
    
    function helmholtzToProps_pT 
      "calulate property record for pressure and temperature as states from dimensionless Helmholtz function" 
      
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_pT pro 
        "property record for pressure and temperature as dynamic states";
    protected 
      DerPressureByDensity pd "derivative of pressure w.r.t. density";
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv 
        "derivative of pressure w.r.t. specific volume";
    algorithm 
      pro.d := f.d;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R*f.T*f.tau*f.ftau;
      pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      pv := -(f.d*f.d)/pd;
      
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*f.R*f.d*f.T*f.delta*f.fdelta)*((-pv*pro.cv + pt*pt*f.
        T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.ddTp := -pt/pd;
      pro.ddpT := 1/pd;
      pro.dupT := (f.d - f.T*pt)/(f.d*f.d*pd);
      pro.duTp := (-pro.cv*f.d*f.d*pd + pt*f.d - f.T*pt*pt)/(f.d*f.d*pd);
    end helmholtzToProps_pT;
    
    function helmholtzToProps_dT 
      "calulate property record for density and temperature as states from dimensionless Helmholtz function" 
      
      extends Modelica.Icons.Function;
      input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
      output ThermoProperties_dT pro 
        "property record for density and temperature as dynamic states";
    protected 
      DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
      DerPressureBySpecificVolume pv "derivative of pressure w.r.t. pressure";
    algorithm 
      pro.p := f.R*f.d*f.T*f.delta*f.fdelta;
      pro.R := f.R;
      pro.s := f.R*(f.tau*f.ftau - f.f);
      pro.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
      pro.u := f.R*f.T*f.tau*f.ftau;
      pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
      pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
      
      // calculating cp near the critical point may be troublesome (cp -> inf).
      pro.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau
        *f.fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
      pro.cv := f.R*(-f.tau*f.tau*f.ftautau);
      pro.kappa := 1/(f.d*pro.p)*((-pv*pro.cv + pt*pt*f.T)/(pro.cv));
      pro.a := abs(f.R*f.T*(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta
         - ((f.delta*f.fdelta - f.delta*f.tau*f.fdeltatau)*(f.delta*f.fdelta -
        f.delta*f.tau*f.fdeltatau))/(f.tau*f.tau*f.ftautau)))^0.5;
      pro.dudT := (pro.p - f.T*pt)/(f.d*f.d);
    end helmholtzToProps_dT;
    
    function TwoPhaseToProps_ph 
      "compute property record for pressure and specific enthalpy as states from saturation properties" 
      
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation property record";
      output ThermoProperties_ph pro 
        "property record for pressure and specific enthalpy as dynamic states";
    protected 
      Real dht "derivative of specific enthalpy w.r.t. temperature";
      Real dhd "derivative of specific enthalpy w.r.t. density";
      Real detph "thermodynamic determinant";
    algorithm 
      pro.d := sat.d;
      pro.T := sat.T;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.R := sat.R;
      pro.cp := Modelica.Constants.inf;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      dht := sat.cv + sat.dpT/sat.d;
      dhd := -sat.T*sat.dpT/(sat.d*sat.d);
      detph := -sat.dpT*dhd;
      pro.ddph := dht/detph;
      pro.ddhp := -sat.dpT/detph;
    end TwoPhaseToProps_ph;
    
    function TwoPhaseToProps_dT 
      "compute property record for density and temperature as states from saturation properties" 
      
      extends Modelica.Icons.Function;
      input SaturationProperties sat "saturation properties";
      output ThermoProperties_dT pro 
        "property record for density and temperature as dynamic states";
    algorithm 
      pro.p := sat.p;
      pro.h := sat.h;
      pro.u := sat.u;
      pro.s := sat.s;
      pro.cv := sat.cv;
      pro.cp := Modelica.Constants.inf;
      pro.R := sat.R;
      pro.kappa := -1/(sat.d*sat.p)*sat.dpT*sat.dpT*sat.T/sat.cv;
      pro.a := Modelica.Constants.inf;
      pro.dudT := (sat.p - sat.T*sat.dpT)/(sat.d*sat.d);
    end TwoPhaseToProps_dT;
    
  end ThermoFluidSpecial;
  
public 
  record SaturationProperties "properties in the two phase region" 
    extends Modelica.Icons.Record;
    SI.Temp_K T "temperature";
    SI.Density d "density";
    SI.Pressure p "pressure";
    SI.SpecificEnergy u "specific inner energy";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    SI.SpecificHeatCapacity R "gas constant";
    SI.RatioOfSpecificHeatCapacities kappa "isentropic expansion coefficient";
    PhaseBoundaryProperties liq 
      "thermodynamic base properties on the boiling curve";
    PhaseBoundaryProperties vap 
      "thermodynamic base properties on the dew curve";
    Real dpT "derivative of saturation pressure wrt temperature";
    SI.MassFraction x "vapour mass fraction";
  end SaturationProperties;
  
  record SaturationBoundaryProperties 
    "properties on both phase boundaries, including some derivatives" 
    
    extends Modelica.Icons.Record;
    SI.Temp_K T "Saturation temperature";
    SI.Density dl "Liquid density";
    SI.Density dv "Vapour density";
    SI.SpecificEnthalpy hl "Liquid specific enthalpy";
    SI.SpecificEnthalpy hv "Vapour specific enthalpy";
    Real dTp "derivative of temperature wrt saturation pressure";
    Real ddldp "derivative of density along boiling curve";
    Real ddvdp "derivative of density along dew curve";
    Real dhldp "derivative of specific enthalpy along boiling curve";
    Real dhvdp "derivative of specific enthalpy along dew curve";
    SI.MassFraction x "vapour mass fraction";
  end SaturationBoundaryProperties;
  
  record IF97BaseTwoPhase "Intermediate property data record for IF 97" 
    extends Modelica.Icons.Record;
    Integer phase= 0 "phase: 2 for two-phase, 1 for one phase, 0 if unknown";
    Integer region(min=1, max=5) "IF 97 region";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificHeatCapacity R "gas constant";
    SI.SpecificHeatCapacity cp "specific heat capacity";
    SI.SpecificHeatCapacity cv "specific heat capacity";
    SI.Density rho "density";
    SI.SpecificEntropy s "specific entropy";
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    Real x "dryness fraction";
    Real dpT "dp/dT derivative of saturation curve";
  end IF97BaseTwoPhase;
  
  record IF97PhaseBoundaryProperties 
    "thermodynamic base properties on the phase boundary for IF97 steam tables" 
    
    extends Modelica.Icons.Record;
    Boolean region3boundary "true if boundary between 2-phase and region 3";
    SI.SpecificHeatCapacity R "specific heat capacity";
    SI.Temperature T "temperature";
    SI.Density d "density";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    DerPressureByTemperature dpT "dp/dT derivative of saturation curve";
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  end IF97PhaseBoundaryProperties;
  
  record GibbsDerivs 
    "derivatives of dimensionless Gibbs-function w.r.t dimensionless pressure and temperature" 
    
    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real pi "dimensionless pressure";
    Real tau "dimensionless temperature";
    Real g "dimensionless Gibbs-function";
    Real gpi "derivative of g w.r.t. pi";
    Real gpipi "2nd derivative of g w.r.t. pi";
    Real gtau "derivative of g w.r.t. tau";
    Real gtautau "2nd derivative of g w.r.t tau";
    Real gtaupi "mixed derivative of g w.r.t. pi and tau";
  end GibbsDerivs;
  
  record HelmholtzDerivs 
    "derivatives of dimensionless Helmholtz-function w.r.t dimensionless pressuredensity and temperature" 
    extends Modelica.Icons.Record;
    SI.Density d "density";
    SI.Temperature T "temperature";
    SI.SpecificHeatCapacity R "specific heat capacity";
    Real delta "dimensionless density";
    Real tau "dimensionless temperature";
    Real f "dimensionless Helmholtz-function";
    Real fdelta "derivative of f w.r.t. delta";
    Real fdeltadelta "2nd derivative of f w.r.t. delta";
    Real ftau "derivative of f w.r.t. tau";
    Real ftautau "2nd derivative of f w.r.t. tau";
    Real fdeltatau "mixed derivative of f w.r.t. delta and tau";
  end HelmholtzDerivs;
  
  record TwoPhaseTransportProps 
    "defines properties on both phase boundaries, needed in the two phase region" 
    extends Modelica.Icons.Record;
    SI.Density d_vap "density on the dew line";
    SI.Density d_liq "density on the bubble line";
    SI.DynamicViscosity eta_vap "dynamic viscosity on the dew line";
    SI.DynamicViscosity eta_liq "dynamic viscosity on the bubble line";
    SI.ThermalConductivity lam_vap "thermal conductivity on the dew line";
    SI.ThermalConductivity lam_liq "thermal conductivity on the bubble line";
    SI.SpecificHeatCapacity cp_vap "cp on the dew line";
    SI.SpecificHeatCapacity cp_liq "cp on the bubble line";
    SI.MassFraction x "steam quality";
  end TwoPhaseTransportProps;
  
  record PhaseBoundaryProperties 
    "thermodynamic base properties on the phase boundary" 
    extends Modelica.Icons.Record;
    SI.Density d "density";
    SI.SpecificEnthalpy h "specific enthalpy";
    SI.SpecificEnergy u "inner energy";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capacity at constant pressure";
    SI.SpecificHeatCapacity cv "heat capacity at constant volume";
    DerPressureByTemperature pt "derivative of pressure wrt temperature";
    DerPressureByDensity pd "derivative of pressure wrt density";
  end PhaseBoundaryProperties;
  
  record NewtonDerivatives_ph 
    "derivatives for fast inverse calculations of Helmholtz functions: p & h" 
    
    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.SpecificEnthalpy h "specific enthalpy";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    Real hd "derivative of specific enthalpy w.r.t. density";
    Real ht "derivative of specific enthalpy w.r.t. temperature";
  end NewtonDerivatives_ph;
  
  record NewtonDerivatives_ps 
    "derivatives for fast inverse calculation of Helmholtz functions: p & s" 
    
    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    SI.SpecificEntropy s "specific entropy";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    Real sd "derivative of specific entropy w.r.t. density";
    Real st "derivative of specific entropy w.r.t. temperature";
  end NewtonDerivatives_ps;
  
  record NewtonDerivatives_pT 
    "derivatives for fast inverse calculations of Helmholtz functions:p & T" 
    
    extends Modelica.Icons.Record;
    SI.Pressure p "pressure";
    DerPressureByDensity pd "derivative of pressure w.r.t. density";
  end NewtonDerivatives_pT;
  
  record ExtraDerivatives "additional thermodynamic derivatives" 
    extends Modelica.Icons.Record;
    IsentropicExponent kappa "isentropic expansion coefficient";
    // k in Bejan
    IsenthalpicExponent theta "isenthalpic exponent";
    // same as kappa, except derivative at const h
    IsobaricVolumeExpansionCoefficient alpha 
      "isobaric volume expansion coefficient";
    // beta in Bejan
    IsochoricPressureCoefficient beta "isochoric pressure coefficient";
    // kT in Bejan
    IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
    JouleThomsonCoefficient mu "Joule-Thomson coefficient";
    // mu_J in Bejan
  end ExtraDerivatives;
  
  record BridgmansTables 
    "Calculates all entries in Bridgmans tables if first seven variables given" 
    extends Modelica.Icons.Record;
    // the first 7 need to calculated in a function!
    SI.SpecificVolume v "specific volume";
    SI.Pressure p "pressure";
    SI.Temperature T "temperature";
    SI.SpecificEntropy s "specific entropy";
    SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
    IsobaricVolumeExpansionCoefficient alpha 
      "isobaric volume expansion coefficient";
    // beta in Bejan
    IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
    // Derivatives at constant pressure
    Real dTp=1 "coefficient in Bridgmans table, see info for usage";
    Real dpT=-dTp "coefficient in Bridgmans table, see info for usage";
    Real dvp=alpha*v "coefficient in Bridgmans table, see info for usage";
    Real dpv=-dvp "coefficient in Bridgmans table, see info for usage";
    Real dsp=cp/T "coefficient in Bridgmans table, see info for usage";
    Real dps=-dsp "coefficient in Bridgmans table, see info for usage";
    Real dup=cp - alpha*p*v 
      "coefficient in Bridgmans table, see info for usage";
    Real dpu=-dup "coefficient in Bridgmans table, see info for usage";
    Real dhp=cp "coefficient in Bridgmans table, see info for usage";
    Real dph=-dhp "coefficient in Bridgmans table, see info for usage";
    Real dfp=-s - alpha*p*v 
      "coefficient in Bridgmans table, see info for usage";
    Real dpf=-dfp "coefficient in Bridgmans table, see info for usage";
    Real dgp=-s "coefficient in Bridgmans table, see info for usage";
    Real dpg=-dgp "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant Temperature
    Real dvT=gamma*v "coefficient in Bridgmans table, see info for usage";
    Real dTv=-dvT "coefficient in Bridgmans table, see info for usage";
    Real dsT=alpha*v "coefficient in Bridgmans table, see info for usage";
    Real dTs=-dsT "coefficient in Bridgmans table, see info for usage";
    Real duT=alpha*T*v - gamma*p*v 
      "coefficient in Bridgmans table, see info for usage";
    Real dTu=-duT "coefficient in Bridgmans table, see info for usage";
    Real dhT=-v + alpha*T*v 
      "coefficient in Bridgmans table, see info for usage";
    Real dTh=-dhT "coefficient in Bridgmans table, see info for usage";
    Real dfT=-gamma*p*v "coefficient in Bridgmans table, see info for usage";
    Real dTf=-dfT "coefficient in Bridgmans table, see info for usage";
    Real dgT=-v "coefficient in Bridgmans table, see info for usage";
    Real dTg=-dgT "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant v
    Real dsv=alpha*alpha*v*v - gamma*v*cp/T 
      "coefficient in Bridgmans table, see info for usage";
    Real dvs=-dsv "coefficient in Bridgmans table, see info for usage";
    Real duv=T*alpha*alpha*v*v - gamma*v*cp 
      "coefficient in Bridgmans table, see info for usage";
    Real dvu=-duv "coefficient in Bridgmans table, see info for usage";
    Real dhv=T*alpha*alpha*v*v - alpha*v*v - gamma*v*cp 
      "coefficient in Bridgmans table, see info for usage";
    Real dvh=-dhv "coefficient in Bridgmans table, see info for usage";
    Real dfv=gamma*v*s "coefficient in Bridgmans table, see info for usage";
    Real dvf=-dfv "coefficient in Bridgmans table, see info for usage";
    Real dgv=gamma*v*s - alpha*v*v 
      "coefficient in Bridgmans table, see info for usage";
    Real dvg=-dgv "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant s
    Real dus=dsv*p "coefficient in Bridgmans table, see info for usage";
    Real dsu=-dus "coefficient in Bridgmans table, see info for usage";
    Real dhs=-v*cp/T "coefficient in Bridgmans table, see info for usage";
    Real dsh=-dhs "coefficient in Bridgmans table, see info for usage";
    Real dfs=gamma*v*s + dus 
      "coefficient in Bridgmans table, see info for usage";
    Real dsf=-dfs "coefficient in Bridgmans table, see info for usage";
    Real dgs=gamma*v*s - v*cp/T 
      "coefficient in Bridgmans table, see info for usage";
    Real dsg=-dgs "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant u
    Real dhu=p*alpha*v*v + gamma*v*cp*p - v*cp - p*T*alpha*alpha*v*v 
      "coefficient in Bridgmans table, see info for usage";
    Real duh=-dhu "coefficient in Bridgmans table, see info for usage";
    Real dfu=s*T*alpha*v - gamma*v*cp*p - gamma*v*s*p + p*T*alpha*alpha*v*v 
      "coefficient in Bridgmans table, see info for usage";
    Real duf=-dfu "coefficient in Bridgmans table, see info for usage";
    Real dgu=alpha*v*v*p + alpha*v*s*T - v*cp - gamma*v*s*p 
      "coefficient in Bridgmans table, see info for usage";
    Real dug=-dgu "coefficient in Bridgmans table, see info for usage";
    //  Derivatives at constant h
    Real dfh=(s - v*alpha*p)*(v - v*alpha*T) - gamma*v*cp*p 
      "coefficient in Bridgmans table, see info for usage";
    Real dhf=-dfh "coefficient in Bridgmans table, see info for usage";
    Real dgh=alpha*v*s*T - v*(s + cp) 
      "coefficient in Bridgmans table, see info for usage";
    Real dhg=-dgh "coefficient in Bridgmans table, see info for usage";
    // Derivatives at constant g
    Real dfg=gamma*v*s*p - v*s - alpha*v*v*p 
      "coefficient in Bridgmans table, see info for usage";
    Real dgf=-dfg "coefficient in Bridgmans table, see info for usage";
    annotation (Documentation(info="
                <HTML>
                <p>
                <pre>
Important: the phase equilibrium conditions are not yet considered.
this means that bridgemans tables do not yet work in the two phase region
some derivatives are 0 or infinity anyways
Idea: don't use the values in Bridgmans table directly, all
derivatives are calculated as the quotient of two entries in the
table. The last letter indicates which variable is held constant in
taking the derivative. The second letters are the two variables
involved in the derivative and the first letter is alwys a d to remind
of differentiation.
Example 1: Get the derivative of specific entropy s wrt Temperature at
constant specific volume (btw identical to constant density)
constant volume  --> last letter v
Temperature      --> second letter T
Specific entropy --> second letter s
--> the needed value is dsv/dTv
Known variables:
Temperature T
pressure p
specific volume v
specific inner energy u
specific enthalpy h
specific entropy s
specific helmholtz energy f
specific gibbs enthalpy g
Not included but useful:
density d
In order to convert derivatives involving density use the following
rules:
at constant density == at constant specific volume
ddx/dyx = -d*d*dvx/dyx with y,x any of T,p,u,h,s,f,g
dyx/ddx = -1/(d*d)dyx/dvx with y,x any of T,p,u,h,s,f,g
Usage example assuming water as the medium:
model BridgmansTablesForWater
extends ThermoFluid.BaseClasses.MediumModels.Water.WaterSteamMedium_ph;
Real derOfsByTAtConstantv \"derivative of sp. entropy by temperature at constant sp. volume\"
ThermoFluid.BaseClasses.MediumModels.Common.ExtraDerivatives dpro;
ThermoFluid.BaseClasses.MediumModels.Common.BridgmansTables bt;
equation
dpro = ThermoFluid.BaseClasses.MediumModels.SteamIF97.extraDerivs_pT(p[1],T[1]);
bt.p = p[1];
bt.T = T[1];
bt.v = 1/pro[1].d;
bt.s = pro[1].s;
bt.cp = pro[1].cp;
bt.alpha = dpro.alpha;
bt.gamma = dpro.gamma;
derOfsByTAtConstantv =  bt.dsv/bt.dTv;
                ...
end BridgmansTablesForWater;
                </pre>
                </p>
                </HTML>
                "));
  end BridgmansTables;
  
  function gibbsToBridgmansTables 
    "calculates base coefficients for bridgemans tables from gibbs enthalpy" 
    
    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output SI.SpecificVolume v "specific volume";
    output SI.Pressure p=g.p "pressure";
    output SI.Temperature T=g.T "temperature";
    output SI.SpecificEntropy s "specific entropy";
    output SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha 
      "isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
  protected 
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  algorithm 
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    v := (g.R*g.T*g.pi*g.gpi)/g.p;
    s := g.R*(g.tau*g.gtau - g.g);
    cp := -g.R*g.tau*g.tau*g.gtautau;
    alpha := vt/v;
    gamma := -vp/v;
  end gibbsToBridgmansTables;
  
  function helmholtzToBridgmansTables 
    "calculates base coefficients for Bridgmans tables from helmholtz energy" 
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output SI.SpecificVolume v=1/f.d "specific volume";
    output SI.Pressure p "pressure";
    output SI.Temperature T=f.T "temperature";
    output SI.SpecificEntropy s "specific entropy";
    output SI.SpecificHeatCapacity cp "heat capaccity at constant pressure";
    output IsobaricVolumeExpansionCoefficient alpha 
      "isobaric volume expansion coefficient";
    // beta in Bejan
    output IsothermalCompressibility gamma "isothermal compressibility";
    // kappa in Bejan
  protected 
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv 
      "derivative of pressure w.r.t. specific volume ";
    SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  algorithm 
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    s := f.R*(f.tau*f.ftau - f.f);
    alpha := -f.d*pt/pv;
    gamma := -f.d/pv;
    cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
      fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
  end helmholtzToBridgmansTables;
  
  function gibbsToBoundaryProps 
    "calulate phase boundary property record from dimensionless Gibbs function" 
    
    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output PhaseBoundaryProperties sat "phase boundary properties";
  protected 
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
  algorithm 
    sat.d := g.p/(g.R*g.T*g.pi*g.gpi);
    sat.h := g.R*g.T*g.tau*g.gtau;
    sat.u := g.T*g.R*(g.tau*g.gtau - g.pi*g.gpi);
    sat.s := g.R*(g.tau*g.gtau - g.g);
    sat.cp := -g.R*g.tau*g.tau*g.gtautau;
    sat.cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.
       tau*g.gtaupi)/(g.gpipi));
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    // sat.kappa := -1/(sat.d*g.p)*sat.cp/(vp*sat.cp + vt*vt*g.T);
    sat.pt := -g.p/g.T*(g.gpi - g.tau*g.gtaupi)/(g.gpipi*g.pi);
    sat.pd := -g.R*g.T*g.gpi*g.gpi/(g.gpipi);
  end gibbsToBoundaryProps;
  
  function helmholtzToBoundaryProps 
    "calulate phase boundary property record from dimensionless Helmholtz function" 
    
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output PhaseBoundaryProperties sat "phase boundary property record";
  protected 
    SI.Pressure p "pressure";
  algorithm 
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    sat.d := f.d;
    sat.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    sat.s := f.R*(f.tau*f.ftau - f.f);
    sat.u := f.R*f.T*f.tau*f.ftau;
    sat.cp := f.R*(-f.tau*f.tau*f.ftautau + (f.delta*f.fdelta - f.delta*f.tau*f.
       fdeltatau)^2/(2*f.delta*f.fdelta + f.delta*f.delta*f.fdeltadelta));
    sat.cv := f.R*(-f.tau*f.tau*f.ftautau);
    sat.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    sat.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    //     sat.kappa := 1/(f.d*p)*((sat.pd*sat.cv/(f.d*f.d) + sat.pt*sat.pt*f.T)/(sat.
    //       cv));
  end helmholtzToBoundaryProps;
  
  function cv2Phase 
    "compute isochoric specific heat capacity inside the two-phase region" 
    
    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "properties on the boiling curve";
    input PhaseBoundaryProperties vap "properties on the condensation curve";
    input SI.MassFraction x "vapour mass fraction";
    input SI.Temperature T "temperature";
    input SI.Pressure p "preoperties";
    output SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  protected 
    Real dpT "derivative of pressure w.r.t. temperature";
    Real dxv "derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "derivative of vapour specific volume w.r.t. temperature";
    Real duTl "derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "derivative of vapour mass fraction w.r.t. temperature";
  algorithm 
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cv2Phase;
  
  function cvdpT2Phase 
    "compute isochoric specific heat capacity inside the two-phase region and derivative of pressure w.r.t. temperature" 
    
    extends Modelica.Icons.Function;
    input PhaseBoundaryProperties liq "properties on the boiling curve";
    input PhaseBoundaryProperties vap "properties on the condensation curve";
    input SI.MassFraction x "vapour mass fraction";
    input SI.Temperature T "temperature";
    input SI.Pressure p "preoperties";
    output SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
    output Real dpT "derivative of pressure w.r.t. temperature";
  protected 
    Real dxv "derivative of vapour mass fraction w.r.t. specific volume";
    Real dvTl "derivative of liquid specific volume w.r.t. temperature";
    Real dvTv "derivative of vapour specific volume w.r.t. temperature";
    Real duTl "derivative of liquid specific inner energy w.r.t. temperature";
    Real duTv "derivative of vapour specific inner energy w.r.t. temperature";
    Real dxt "derivative of vapour mass fraction w.r.t. temperature";
  algorithm 
    dxv := if (liq.d <> vap.d) then liq.d*vap.d/(liq.d - vap.d) else 0.0;
    dpT := (vap.s - liq.s)*dxv;
    // wrong at critical point
    dvTl := (liq.pt - dpT)/liq.pd/liq.d/liq.d;
    dvTv := (vap.pt - dpT)/vap.pd/vap.d/vap.d;
    dxt := -dxv*(dvTl + x*(dvTv - dvTl));
    duTl := liq.cv + (T*liq.pt - p)*dvTl;
    duTv := vap.cv + (T*vap.pt - p)*dvTv;
    cv := duTl + x*(duTv - duTl) + dxt*(vap.u - liq.u);
  end cvdpT2Phase;
  
  function gibbsToExtraDerivs 
    "compute additional thermodynamic derivatives from dimensionless Gibbs function" 
    
    extends Modelica.Icons.Function;
    input GibbsDerivs g "dimensionless derivatives of Gibbs function";
    output ExtraDerivatives dpro "additional property derivatives";
  protected 
    Real vt "derivative of specific volume w.r.t. temperature";
    Real vp "derivative of specific volume w.r.t. pressure";
    SI.Density d "density";
    SI.SpecificVolume v "specific volume";
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
    SI.SpecificHeatCapacity cp "isobaric heat capacity";
  algorithm 
    d := g.p/(g.R*g.T*g.pi*g.gpi);
    v := 1/d;
    vt := g.R/g.p*(g.pi*g.gpi - g.tau*g.pi*g.gtaupi);
    vp := g.R*g.T/(g.p*g.p)*g.pi*g.pi*g.gpipi;
    cp := -g.R*g.tau*g.tau*g.gtautau;
    cv := g.R*(-g.tau*g.tau*g.gtautau + (g.gpi - g.tau*g.gtaupi)*(g.gpi - g.tau
      *g.gtaupi)/g.gpipi);
    dpro.kappa := -1/(d*g.p)*cp/(vp*cp + vt*vt*g.T);
    dpro.theta := cp/(d*g.p*(-vp*cp + vt*v - g.T*vt*vt));
    dpro.alpha := d*vt;
    dpro.beta := -vt/(g.p*vp);
    dpro.gamma := -d*vp;
    dpro.mu := -(v - g.T*vt)/cp;
  end gibbsToExtraDerivs;
  
  function helmholtzToExtraDerivs 
    "compute additional thermodynamic derivatives from dimensionless Helmholtz function" 
    
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output ExtraDerivatives dpro "additional property derivatives";
  protected 
    SI.Pressure p "pressure";
    SI.SpecificVolume v "specific volume";
    DerPressureByTemperature pt "derivative of pressure w.r.t. temperature";
    DerPressureBySpecificVolume pv 
      "derivative of pressure w.r.t. specific volume";
    SI.SpecificHeatCapacity cv "isochoric specific heat capacity";
  algorithm 
    v := 1/f.d;
    p := f.R*f.d*f.T*f.delta*f.fdelta;
    pv := -1/(f.d*f.d)*f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    cv := f.R*(-f.tau*f.tau*f.ftautau);
    dpro.kappa := 1/(f.d*p)*((-pv*cv + pt*pt*f.T)/(cv));
    dpro.theta := -1/(f.d*p)*((-pv*cv + f.T*pt*pt)/(cv + pt*v));
    dpro.alpha := -f.d*pt/pv;
    dpro.beta := pt/p;
    dpro.gamma := -f.d/pv;
    dpro.mu := (v*pv + f.T*pt)/(pt*pt*f.T - pv*cv);
  end helmholtzToExtraDerivs;
  
  function Helmholtz_ph 
    "function to calculate analytic derivatives for computing d and t given p and h" 
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ph nderivs 
      "derivatives for Newton iteration to calculate d and t from p and h";
  protected 
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
  algorithm 
    cv := -f.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.h := f.R*f.T*(f.tau*f.ftau + f.delta*f.fdelta);
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.ht := cv + nderivs.pt/f.d;
    nderivs.hd := (nderivs.pd - f.T*nderivs.pt/f.d)/f.d;
  end Helmholtz_ph;
  
  function Helmholtz_pT 
    "function to calculate analytic derivatives for computing d and t given p and t" 
    
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_pT nderivs 
      "derivatives for Newton iteration to compute d and t from p and t";
  algorithm 
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
  end Helmholtz_pT;
  
  function Helmholtz_ps 
    "function to calculate analytic derivatives for computing d and t given p and s" 
    
    extends Modelica.Icons.Function;
    input HelmholtzDerivs f "dimensionless derivatives of Helmholtz function";
    output NewtonDerivatives_ps nderivs 
      "derivatives for Newton iteration to compute d and t from p and s";
  protected 
    SI.SpecificHeatCapacity cv "isochoric heat capacity";
  algorithm 
    cv := -f.R*(f.tau*f.tau*f.ftautau);
    nderivs.p := f.d*f.R*f.T*f.delta*f.fdelta;
    nderivs.s := f.R*(f.tau*f.ftau - f.f);
    nderivs.pd := f.R*f.T*f.delta*(2.0*f.fdelta + f.delta*f.fdeltadelta);
    nderivs.pt := f.R*f.d*f.delta*(f.fdelta - f.tau*f.fdeltatau);
    nderivs.st := cv/f.T;
    nderivs.sd := -nderivs.pt/(f.d*f.d);
  end Helmholtz_ps;
  
end Common;
end Media;
