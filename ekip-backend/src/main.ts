import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as cookieParser from 'cookie-parser';
import * as bodyParser from 'body-parser';
async function bootstrap() {
  console.log(process.env.DB_HOST);
  console.log(process.env.DB_PORT);
  const app = await NestFactory.create(AppModule, { cors: true });
  app.use(cookieParser());
  app.use(bodyParser.json({ limit: '5mb' }));
  app.useGlobalPipes(new ValidationPipe());
  app.enableCors({ credentials: true, origin: '*' });
  await app.listen(8000);
}
bootstrap();
