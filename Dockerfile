FROM continuumio/miniconda3:latest

# 创建 conda 环境并安装 python 和 uwsgi
RUN conda create -n xhs_sipder_backend python=3.11.7 -y && \
    /bin/bash -c "source activate xhs_sipder_backend && conda install -c conda-forge uwsgi=2.0.28 -y"

# 激活环境
ENV PATH /opt/conda/envs/xhs_sipder_backend/bin:$PATH
ENV CONDA_DEFAULT_ENV=xhs_sipder_backend

# 复制代码
WORKDIR /app
COPY . .

# 安装依赖
RUN /opt/conda/envs/xhs_sipder_backend/bin/pip install --no-cache-dir -r requirements.txt

# 启动 uwsgi 改为脚本启动
CMD ["/app/setup.sh"]

