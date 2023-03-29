### Build 
```
docker build -t kaggle:latest .
```

### Run
```
docker run -it --privileged --runtime=nvidia \
-v "$HOME/workspace:/workspace" \
kaggle:latest \
/bin/bash
```
