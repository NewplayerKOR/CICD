# 1단계: 빌드 환경
FROM maven:3.9-openjdk-17 AS builder

# 작업 디렉터리 설정
WORKDIR /app

# pom.xml 복사 및 의존성 다운로드 (캐시 최적화)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# 소스코드 복사 및 빌드
COPY src ./src
RUN mvn clean package -DskipTests

# 2단계: 실행 환경
FROM openjdk:17-jre-slim

# 작업 디렉터리 설정
WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /app/target/*.jar app.jar

# 포트 노출
EXPOSE 8080

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]