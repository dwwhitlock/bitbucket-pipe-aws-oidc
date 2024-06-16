FROM amazon/aws-cli:2.16.9
COPY README.md LICENSE /
COPY pipe /pipe
ENTRYPOINT ["/pipe/pipe.sh"]
