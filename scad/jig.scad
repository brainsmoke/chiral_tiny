e=.001;

b=.8;
m=.2;

include <lib/utils.scad>


module svg(name)
{
	translate([-34,-12,0])
	import(name);
}

plate_dim = [68,24,2.6];

echo(plate_dim+[b,b,b]);

module jig()
{

	difference()
	{
		union()
		{
			translate([0,0,1-e])
			linear_extrude(3+e)
			difference()
			{
				offset(delta=m+b,chamfer=false)
				svg("border.svg");

				offset(delta=m,chamfer=false)
				svg("border.svg");

				offset(delta=m,chamfer=false)
				svg("cutouts.svg");
			}


			difference()
			{
				chamfer_block_z(plate_dim,[0,0,-1],2);

				translate([0,0,.8])
				chamfer_block_z(plate_dim+[-b*2,-b*2,e],[0,0,-1],2-b/sqrt(2));
			}

			translate([0,0,e])
			linear_extrude(2-e)
			offset(1)
			svg("pogo_holes.svg");
		}

		union()
		{
			translate([0,0,-e])
			linear_extrude(2+2*e)
			offset(m)
			svg("pogo_holes.svg");

			translate([0,0,2])
			linear_extrude(2+e)
			offset(.5)
			svg("pogo_holes.svg");
		}
	}
}

module jig_bottom()
{
	difference()
	{
		chamfer_block_z(plate_dim+[2*m+2*b,2*m+2*b,3.8],[0,0,-1],2);

		translate([0,0,.8])
		chamfer_block_z(plate_dim+[2*m,2*m,10],[0,0,-1],2);

		translate([-plate_dim[0]/2,0,.8])
		block([2,15,10],[0,0,-1]);
	}
}

jig();

