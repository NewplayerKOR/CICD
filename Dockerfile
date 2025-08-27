# 기존 파일 내용을 모두 삭제하고 아래 내용으로 교체
FROM nginx:1.25-alpine

LABEL maintainer="NewplayerKOR"
LABEL description="CICD Practice Nginx Server"
LABEL version="1.0"

WORKDIR /usr/share/nginx/html

RUN rm -rf /usr/share/nginx/html/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost/health || exit 1

CMD ["nginx", "-g", "daemon off;"]