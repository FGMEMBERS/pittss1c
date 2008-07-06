# G-Meter code copied form the Grob-g115

gmeterUpdate = func {

	GCurrent = props.globals.getNode("/accelerations/pilot-g[0]").getValue();
	
	GMin = props.globals.getNode("/accelerations/pilot-gmin[0]").getValue();
	GMax = props.globals.getNode("/accelerations/pilot-gmax[0]").getValue();

	if(GCurrent < 1 and GCurrent < GMin){setprop("/accelerations/pilot-gmin[0]", GCurrent);}
	else {if(GCurrent > GMax){setprop("/accelerations/pilot-gmax[0]", GCurrent);}}
	
    settimer(gmeterUpdate, 0.2);
}

setlistener("/sim/signals/fdm-initialized",gmeterUpdate);

aircraft.livery.init("Aircraft/pittss1c/Models/Liveries/");