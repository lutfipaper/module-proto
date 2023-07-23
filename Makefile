# Build
help:
	@echo "See Makefile"
go-proto-gen-docker:
	@scripts/docker.sh
go-proto-gen:
	@bash -c "source ./scripts/before.sh && ./scripts/go-proto.sh"