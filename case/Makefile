# Makefile for Lathe Controller Case
# Generates STL and all rendering views

SCAD = openscad
SCAD_FILE = controller-case.scad
STL_FILE = controller-case.stl
RENDER_SCAD = render-views.scad

# All PNG files to generate
RENDERS = front-view.png \
          back-straight.png \
          iso-view.png \
          back-detail.png \
          back-detail-1.png \
          back-detail-2.png \
          back-panel-view.png \
          full-assembly.png \
          top-view.png \
          mounting-post-close-1.png \
          mounting-post-close-2.png \
          mounting-post-bottom.png \
          mounting-post-angle-1.png \
          mounting-post-angle-2.png \
          mounting-post-inside.png \
          mounting-all-posts.png

.PHONY: all clean stl renders

all: stl renders

stl: $(STL_FILE)

renders: $(RENDERS)

# Generate STL from SCAD
$(STL_FILE): $(SCAD_FILE)
	$(SCAD) -o $@ $<

# Create render SCAD file if it doesn't exist
$(RENDER_SCAD):
	echo '// Import the STL file for rendering' > $@
	echo 'import("$(STL_FILE)");' >> $@

# Render rules for each view
front-view.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=60,-200,100,60,0,90,800 --imgsize=800,600 $(RENDER_SCAD)

back-straight.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=60,200,100,60,0,90,800 --imgsize=800,600 $(RENDER_SCAD)

iso-view.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=150,-150,200,60,0,90,1000 --imgsize=800,600 $(RENDER_SCAD)

back-detail.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=-150,150,150,0,0,0,800 --imgsize=800,600 $(RENDER_SCAD)

back-detail-1.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=100,150,120,60,0,90,800 --imgsize=800,600 $(RENDER_SCAD)

back-detail-2.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=20,150,120,60,0,90,800 --imgsize=800,600 $(RENDER_SCAD)

back-panel-view.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=200,0,100,200,0,90,400 --imgsize=800,600 $(RENDER_SCAD)

full-assembly.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=120,-120,150,100,0,90,1500 --imgsize=800,600 $(RENDER_SCAD)

top-view.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=0,0,300,0,0,0,600 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-close-1.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=20,70,170,20,40,170,300 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-close-2.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=100,70,170,100,40,170,300 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-bottom.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=60,70,10,60,40,10,300 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-angle-1.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=30,100,150,50,60,90,500 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-angle-2.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=90,100,150,70,60,90,500 --imgsize=800,600 $(RENDER_SCAD)

mounting-post-inside.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=60,50,90,60,70,90,400 --imgsize=800,600 $(RENDER_SCAD)

mounting-all-posts.png: $(STL_FILE) $(RENDER_SCAD)
	$(SCAD) -o $@ --camera=60,120,90,60,40,90,600 --imgsize=800,600 $(RENDER_SCAD)

clean:
	rm -f $(STL_FILE) $(RENDERS) $(RENDER_SCAD)