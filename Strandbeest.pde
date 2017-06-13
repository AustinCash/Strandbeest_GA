// A Strandbeest
//Should the golden Ratios be a there own subclass or a HashMap like a library?
//Golden Ratios should just be called genes or DNA maybe just a list
/*Shortcuts
Run: Ctrl + R

*/

class Strandbeest {
  // gene or the golden ratios
  // ToDo: gene[12] = 150 is m the crank and should not mutate or evolve 
  int[] gene = {380, 415, 393, 401, 558, 394, 367, 657, 490, 500, 619, 78, 150};
  // rna are the resulting intersecting points
  PVector[] rna = new PVector[15];
  // Theta is the current angle of crank arm m
  float theta = 0; 
  // Omega is rotational speed
  float omega = PI/128;
  ArrayList<PVector> footprint = new ArrayList<PVector>();
  int i;
  
  Strandbeest() {
    grow();
  }
  
  void grow(){
    // Replace with when done
    //rna[0] = new PVector(0, 0);
    for (int i=0; i < rna.length; i++) {
      rna[i] = new PVector(0, 0);
    }
    
    rna[1] = PVector.sub(rna[0], new PVector(gene[0], 0));
    rna[2] = PVector.add(rna[0], new PVector(gene[0], 0));
    rna[3] = PVector.sub(rna[0], new PVector(0, gene[11]));
    rna[4] = PVector.sub(rna[3], new PVector(0, gene[12]).rotate(theta));
    rna[5] = intersect(rna[4], gene[9], rna[1], gene[1]);
    rna[6] = intersect(rna[2], gene[1], rna[4], gene[9]);
    rna[7] = intersect(rna[5], gene[4], rna[1], gene[3]);
    rna[8] = intersect(rna[2], gene[3], rna[6], gene[4]);
    rna[9] = intersect(rna[1], gene[2], rna[4], gene[10]);
    rna[10] = intersect(rna[4], gene[10], rna[2], gene[2]);
    rna[11] = intersect(rna[7], gene[5], rna[9], gene[6]);
    rna[12] = intersect(rna[10], gene[6], rna[8], gene[5]);
    rna[13] = intersect(rna[11], gene[7], rna[9], gene[8]);
    rna[14] = intersect(rna[10], gene[8], rna[12], gene[7]);
  }
  
  void display() {
    grow();
    theta += omega;
    
    translate(width/2, height/2); // move 0, 0 to center
    scale(0.3);  // fit to workspace
    stroke(0);
    
    footprint.add(rna[13]);
    
    fill (255, 0, 0);
    for (int i=0; i < footprint.size(); i++) {
      ellipse(footprint.get(i).x, footprint.get(i).y, 10, 10);
    }
    
    line(rna[0].x, rna[0].y, rna[1].x, rna[1].y);  // L frame a
    line(rna[0].x, rna[0].y, rna[2].x, rna[2].y);  // R frame a
    line(rna[0].x, rna[0].y, rna[3].x, rna[3].y);  // center frame l
    line(rna[1].x, rna[1].y, rna[3].x, rna[3].y);  // L frame upper
    line(rna[2].x, rna[2].y, rna[3].x, rna[3].y);  // R frame upper
    line(rna[3].x, rna[3].y, rna[4].x, rna[4].y);  // Crank arm m
    line(rna[5].x, rna[5].y, rna[4].x, rna[4].y);  // L U link j
    line(rna[5].x, rna[5].y, rna[1].x, rna[1].y);  // L U tri b
    line(rna[6].x, rna[6].y, rna[4].x, rna[4].y);  // R U link j
    line(rna[6].x, rna[6].y, rna[2].x, rna[2].y);  // R U tri b
    line(rna[1].x, rna[1].y, rna[7].x, rna[7].y);  // L U tri d
    line(rna[5].x, rna[5].y, rna[7].x, rna[7].y);  // L U tri e
    line(rna[2].x, rna[2].y, rna[8].x, rna[8].y);
    line(rna[6].x, rna[6].y, rna[8].x, rna[8].y);
    line(rna[1].x, rna[1].y, rna[9].x, rna[9].y);
    line(rna[4].x, rna[4].y, rna[9].x, rna[9].y);
    line(rna[4].x, rna[4].y, rna[10].x, rna[10].y);
    line(rna[2].x, rna[2].y, rna[10].x, rna[10].y);
    line(rna[9].x, rna[9].y, rna[11].x, rna[11].y);
    line(rna[7].x, rna[7].y, rna[11].x, rna[11].y);
    line(rna[10].x, rna[10].y, rna[12].x, rna[12].y);
    line(rna[8].x, rna[8].y, rna[12].x, rna[12].y);
    line(rna[11].x, rna[11].y, rna[13].x, rna[13].y);
    line(rna[9].x, rna[9].y, rna[13].x, rna[13].y);
    line(rna[10].x, rna[10].y, rna[14].x, rna[14].y);
    line(rna[12].x, rna[12].y, rna[14].x, rna[14].y);
    
    // Dot at each point
    noStroke();
    fill(0, 0, 255);
    for (int i=0; i < rna.length; i++) {
      ellipse(rna[i].x, rna[i].y, 10, 10);
    }
    
    
    //print("j:", PVector.sub(rna[5], rna[4]).mag());
    //println(" b:", PVector.sub(rna[5], rna[1]).mag());
    //println(rna[4]);
    //println(theta);
  }
  
  void track() {
    footprint.add(rna[13]);
    
    fill (255, 0, 0);
    for (int i=0; i < footprint.size(); i++) {
      ellipse(footprint.get(i).x, footprint.get(i).y, 20, 20);
    }
  }
  
  // Given the length of two linkages and a vector for one end of each, where do they meet up?
  PVector intersect(PVector a, int ar, PVector b, int br) {
    PVector c = PVector.sub(b, a);
    float cr = c.mag();
    // Law of cos
    float b_ang = acos((pow(ar, 2) + pow(cr, 2) - pow(br, 2))/(2*ar*cr));
    float ar_ang = c.heading() + b_ang;
    PVector d = PVector.fromAngle(ar_ang);
    d.setMag(ar);
    d.add(a);
    return d;
  }
  /* 
  PVector intersect(PVector a, PVector b, int ar, int br, boolean up) {
    PVector c = PVector.sub(a, b);
    float cr = c.mag();
    // Law of cos
    float a_ang = acos((pow(br, 2) + pow(cr, 2) - pow(ar, 2)) / (2 * br * cr));
    // if up == true, not c + a
    PVector d = PVector.fromAngle(c.heading() - a_ang);
    d.setMag(ar); 
    d.add(b);
    return d;
  }
  */
}