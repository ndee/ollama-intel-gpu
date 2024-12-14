FROM intelanalytics/ipex-llm-inference-cpp-xpu:latest

ENV ZES_ENABLE_SYSMAN=1
ENV OLLAMA_HOST=0.0.0.0:11434
ENV LD_LIBRARY_PATH=/usr/local/lib/python3.11/dist-packages/bigdl/cpp/libs:$LD_LIBRARY_PATH

RUN mkdir -p /llm/ollama

RUN cd /llm/ollama && \
    init-ollama || echo "Initialization may have failed, verify setup"

RUN echo "/usr/local/lib/python3.11/dist-packages/bigdl/cpp/libs" > /etc/ld.so.conf.d/bigdl-libs.conf && ldconfig

WORKDIR /llm/ollama

ENTRYPOINT ["./ollama", "serve"]
