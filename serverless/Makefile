build:
	cd .. && bash build.sh && cd build/image && zip -qr ../image-resizer.zip .

deploy:
	make build
	sls deploy  --aws-profile XXXXX

clean:
	rm -rf ../build/*
