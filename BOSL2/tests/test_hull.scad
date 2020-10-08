include <../std.scad>
include <../hull.scad>

module test_hull() {
    assert_equal(hull([[3,4],[5,5]]), [0,1]);
    assert_equal(hull([[3,4,1],[5,5,3]]), [0,1]);

    test_collinear_2d = let(u = unit([5,3]))    [ for(i = [9,2,3,4,5,7,12,15,13]) i * u ];
    assert_equal(hull(test_collinear_2d), [7,1]);
    test_collinear_3d = let(u = unit([5,3,2]))    [ for(i = [9,2,3,4,5,7,12,15,13]) i * u ];
    assert_equal(hull(test_collinear_3d), [7,1]);

    /*    // produces some extra points along edges
    test_square_2d = [for(x=[1:5], y=[2:6]) [x,y]];
    echo(test_square_2d);
    move_copies(test_square_2d) circle(r=.1,$fn=16);
    color("red")move_copies(select(test_square_2d,hull(test_square_2d))) circle(r=.1,$fn=16);
    */

    /*  // also produces extra points along edges
    test_square_2d = rot(22,p=[for(x=[1:5], y=[2:6]) [x,y]]);
    echo(test_square_2d);
    move_copies(test_square_2d) circle(r=.1,$fn=16);
    color("red")move_copies(select(test_square_2d,hull(test_square_2d))) circle(r=.1,$fn=16);
    */

    rand10_2d = [[1.55356, -1.98965], [4.23157, -0.947788], [-4.06193, -1.55463],
                 [1.23889, -3.73133], [-1.02637, -4.0155], [4.26806, -4.61909],
                 [3.59556, -3.1574], [-2.77776, -4.21857], [-3.66253,-4.34458], [1.82324, 0.102025]];
    assert_equal(sort(hull(rand10_2d)), [1,2,5,8,9]);

    rand75_2d = [[-3.14743, -3.28139], [0.15343, -0.370249], [0.082565, 3.95939], [-2.56925, -3.16262], [-1.59463, 4.20893],
                 [-4.90744, -1.21374], [-1.0819, -1.93703], [-3.72723, -3.0744], [-3.34339, 1.53535], [3.15803, -0.307388], [4.23289,
                 4.46259], [1.73624, 1.38918], [3.72087, -1.55028], [1.2604, 2.30502], [-0.966431, 1.673], [-3.26866, -0.531443], [1.52605,
                 0.991804], [-1.26305, 1.0737], [-4.31943, 4.11932], [0.488101, 0.0425981], [1.0233, -0.723037], [-4.73406, 2.14568],
                 [-4.75915, 3.83262], [4.90999, -2.76668], [1.91971, -3.8604], [4.38594, -0.761767], [-0.352984, 1.55291], [2.02714,
                 -0.340099], [1.76052, 2.09196], [-1.27485, -4.39477], [4.36364, 3.84964], [0.593612, -4.00028], [3.06833, -3.67117],
                 [4.26834, -4.21213], [4.60226, -0.120432], [-2.45646, 2.60327], [-4.79461, 3.83724], [-3.29755, 0.760159], [0.218423,
                 4.1687], [-0.115829, -2.06242], [-3.96188, 3.21568], [4.3018, -2.5299], [-4.41694, 4.75173], [-3.8393, 2.82212], [-1.14268,
                 1.80751], [2.05805, 1.68593], [-3.0159, -2.91139], [-1.44828, -1.93564], [-0.265887, 0.519893], [-0.457361, -0.610096],
                 [-0.426359, -2.37315], [-3.1018, 2.31141], [0.179141, -3.56242], [-0.491786, 0.813055], [-3.28502, -1.18933], [0.0914813,
                 2.16122], [4.5777, 4.83972], [-1.07096, 2.74992], [-0.698689, 3.9032], [-1.21809, -1.54434], [3.14457, 4.92302], [-4.63176,
                 2.81952], [4.84414, 4.63699], [2.4259, -0.747268], [-1.52088, -4.58305], [1.6961, -3.73678], [-0.483003, -3.67283],
                 [-3.72746, -0.284265], [2.07629, 1.99902], [-3.12698, -0.96353], [4.02254, 3.41521], [-0.963391, -3.2143], [0.315255,
                 0.593049], [1.57006, 1.80436], [4.60957, -2.86325]];
    assert_equal(sort(hull(rand75_2d)),[5,7,23,33,36,42,56,60,62,64]);

    rand10_2d_rot = rot([22,44,12], p=path3d(rand10_2d));
    assert_equal(sort(hull(rand10_2d_rot)), [1,2,5,8,9]);

    rand75_2d_rot = rot([122,-44,32], p=path3d(rand75_2d));
    assert_equal(sort(hull(rand75_2d_rot)), [5,7,23,33,36,42,56,60,62,64]);

    testpoints_on_sphere = [ for(p = 
        [
            [1,PHI,0], [-1,PHI,0], [1,-PHI,0], [-1,-PHI,0],
            [0,1,PHI], [0,-1,PHI], [0,1,-PHI], [0,-1,-PHI],
            [PHI,0,1], [-PHI,0,1], [PHI,0,-1], [-PHI,0,-1]
        ])
        unit(p)
    ];
    assert_equal(hull(testpoints_on_sphere),  [[8, 4, 0], [0, 4, 1], [4, 8, 5], [8, 2, 5], [2, 3, 5], [0, 1, 6], [3, 2, 7], [1, 4, 9], [4, 5, 9],
                 [5, 3, 9], [8, 0, 10], [2, 8, 10], [0, 6, 10], [6, 7, 10], [7, 2, 10], [6, 1, 11], [3, 7, 11], [7, 6, 11], [1, 9, 11], [9, 3, 11]]);

    rand10_3d = [[14.0893, -15.2751, 21.0843], [-14.1564, 17.5751, 3.32094], [17.4966, 12.1717, 18.0607], [24.5489, 9.64591, 10.4738], [-12.0233, -24.4368, 13.1614],
                 [6.24019, -18.4135, 24.9554], [11.9438, -15.9724, -22.6454], [11.6147, 7.56059, 7.5667], [-19.7491, 9.42769, 15.3419], [-10.3726, 16.3559, 3.38503]];
    assert_equal(hull(rand10_3d),[[3, 6, 0], [1, 3, 2], [3, 0, 2], [6, 1, 4], [0, 6, 5], [6, 4, 5], [2, 0, 5], [1, 2, 8], [2, 5, 8], [4, 1, 8], [5, 4, 8], [6, 3, 9], [3, 1, 9], [1, 6, 9]]);

    rand25_3d = [[-20.5261, 14.5058, -11.6349], [16.4625, 20.1316, 12.9816], [-14.0268, 5.58802, 17.686], [-5.47944, 16.2501,
                 5.3086], [20.2168, -11.8466, 12.4598], [14.4633, -15.1479, 4.82151], [12.7897, 5.25704, 19.6205], [11.2456,
                 18.2794, -3.47074], [-1.87665, 22.9852, 1.99367], [-15.6052, -2.11009, 14.0096], [-10.7389, -14.569,
                 5.6121], [24.5965, 17.9039, 20.8313], [-13.7054, 13.3362, 1.50374], [10.1111, -23.1494, 19.9305], [14.154,
                 19.6682, -0.170182], [-22.6438, 22.7429, -0.776773], [-9.75056, 17.8896, -8.04152], [23.1746, 20.5475,
                 22.6957], [-10.5356, -4.32407, -7.0911], [2.20779, -8.30749, 6.87185], [23.2643, 2.64462, -19.0087],
                 [24.4055, 24.4504, 23.4777], [-3.84086, -6.98473, -10.2889], [0.178043, -16.07, 16.8081], [-8.86482,
                 -12.8256, 14.7418], [11.1759, -11.5614, -11.643], [7.16751, 13.9344, -19.1675], [2.26602, -10.5374,
                 0.125718], [-13.9053, 11.1143, -21.9289], [24.9018, -23.5307, -21.4684], [-13.6609, -19.6495, -8.91583],
                 [-16.5393, -22.4105, -6.91617], [-4.11378, -3.14362, -5.6881], [7.50883, -17.5284, -0.0615319], [-7.41739,
                 0.0721313, -7.47111], [22.6975, -7.99655, 14.0555], [-13.3644, 9.26993, 20.858], [-13.6889, 16.7462,
                 -14.5836], [16.5137, 3.90703, -5.49396], [-6.75614, -11.1444, -24.5309], [22.9868, 10.0028, 12.2866],
                 [-4.81079, -0.967785, -10.4726], [-0.949023, 23.1441, -2.08208], [16.1256, -8.2295, -24.0113], [6.45274,
                 -7.21416, 23.1409], [22.8274, 1.07038, 19.1756], [-10.6256, -10.0112, -6.12274], [6.29254, -7.81875,
                 -24.4037], [22.8538, 8.78163, -6.82567], [-1.96142, 19.1728, -1.726]];
    assert_equal(hull(rand25_3d),[[21, 29, 11], [29, 21, 20], [21, 14, 20], [20, 14, 26], [15, 0, 28], [13, 29, 31], [0, 15,
                                 31], [15, 9, 31], [9, 24, 31], [24, 13, 31], [28, 0, 31], [11, 29, 35], [29, 13, 35], [15,
                                 21, 36], [9, 15, 36], [24, 9, 36], [13, 24, 36], [15, 28, 37], [28, 26, 37], [28, 31, 39],
                                 [31, 29, 39], [14, 21, 42], [21, 15, 42], [26, 14, 42], [15, 37, 42], [37, 26, 42], [29, 20,
                                 43], [39, 29, 43], [20, 26, 43], [26, 28, 43], [21, 13, 44], [13, 36, 44], [36, 21, 44],
                                 [21, 11, 45], [11, 35, 45], [13, 21, 45], [35, 13, 45], [28, 39, 47], [39, 43, 47], [43, 28, 47]]);

    /*  // Inconsistently treats coplanar faces: sometimes face center vertex is included in output, sometimes not
    test_cube_3d = [for(x=[1:3], y=[1:3], z=[1:3]) [x,y,z]];
    assert_equal(hull(test_cube_3d),  [[3, 2, 0], [2, 3, 4], [26, 2, 5], [2, 4, 5], [4, 3, 6], [5, 4, 6], [5, 6, 7], [6, 26, 7], [26, 5, 8],
                                       [5, 7, 8], [7, 26, 8], [0, 2, 9], [3, 0, 9], [6, 3, 9], [9, 2, 10], [2, 26, 11], [10, 2, 11], [6, 9, 12],
                                       [26, 6, 15], [6, 12, 15], [9, 10, 18], [10, 11, 18], [12, 9, 18], [15, 12, 18], [26, 18, 19], [18, 11, 19],
                                       [11, 26, 20], [26, 19, 20], [19, 11, 20], [15, 18, 21], [18, 26, 21], [26, 15, 24], [15, 21, 24], [21, 26, 24]]);
                                       echo(len=len(hull(test_cube_3d)));
    */                                   
}
test_hull();
