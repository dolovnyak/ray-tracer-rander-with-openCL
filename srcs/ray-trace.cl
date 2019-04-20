#include "config_cl.h"

int     get_intersect(t_object3d obj, t_vector3d camera, t_vector3d cam_ray, float *intersect_dist)
{
	int a;
//	printf("AAA\n");
//	if (obj.type == 1)
//		a += 1;
//		printf("AAA\n");
//		printf ("%f\n", obj.sphere.radius);
//	if (obj.type == 1)
//		return (get_intersect_sphere(obj.sphere, camera, cam_ray, intersect_dist));
	return (0);
}

float       find_intersect(t_conf *conf, t_object3d *closest_obj)
{
	int         i;
	int         intersection_flag;
	float       intersect_dist;

	intersection_flag = 0;
	intersect_dist = conf->canvas.far_distance;
	i = -1;
	while (++i < conf->objects_num)
	{
//		printf("AAA\n");
		if (get_intersect(conf->objects[i], conf->canvas.camera, conf->cam_ray, &intersect_dist))
		{
			intersection_flag = 1;
			*closest_obj = conf->objects[i];
		}
	}
	if (intersect_dist > conf->canvas.nigh_distance && intersect_dist < conf->canvas.far_distance)
		return (intersect_dist);
	else
		return (0);
}

t_color     ray_trace(t_conf *conf)
{
	t_color     color;
	t_vector3d  intersect_point;
	float       intersect_dist;
	t_object3d  closest_obj;

//	printf("AAA\n");
	if ((intersect_dist = find_intersect(conf, &closest_obj)))
	{
		intersect_point = mv_plus(conf->canvas.camera, mv_mult_num(conf->cam_ray, intersect_dist));
		color = rgb_mult_num(closest_obj.color, get_light_intensity(&closest_obj, intersect_point, conf));
		return (color);
	}
	return (get_rgb(0, 0, 0));
}
