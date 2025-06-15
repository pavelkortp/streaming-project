# Makefile for NestJS Project (using Yarn)

# Use bash for all shell commands
SHELL := /bin/bash

# Define the node_modules binary directory
NODE_MODULES_BIN := ./node_modules/.bin

# Define the TypeORM command using ts-node for TypeScript compatibility
TYPEORM := $(NODE_MODULES_BIN)/typeorm-ts-node-commonjs

# Default command to run when 'make' is called without arguments
.DEFAULT_GOAL := help

## --------------------------------------
## 📦 Dependency Management
## --------------------------------------

.PHONY: install
install:
	@echo "--- 📦 Installing yarn dependencies..."
	yarn install

.PHONY: reinstall
reinstall: clean install
	@echo "--- ✅ Dependencies reinstalled."

## --------------------------------------
## 🛠️ Application Lifecycle
## --------------------------------------

.PHONY: build
build:
	@echo "--- 🛠️ Building the application for production..."
	yarn build

.PHONY: start
start:
	@echo "--- ▶️  Starting application in development mode (with watch)..."
	yarn start:dev

.PHONY: start-prod
start-prod: build
	@echo "--- ▶️  Starting application in production mode..."
	yarn start:prod

.PHONY: start-debug
start-debug:
	@echo "--- 🐞 Starting application in debug mode (with watch)..."
	yarn start:debug

## --------------------------------------
## ✨ Code Quality
## --------------------------------------

.PHONY: lint
lint:
	@echo "--- 🎨 Checking code with ESLint..."
	yarn lint

.PHONY: format
format:
	@echo "--- 🎨 Formatting code with Prettier..."
	yarn format

## --------------------------------------
## 🧪 Testing
## --------------------------------------

.PHONY: test
test:
	@echo "--- 🧪 Running all unit tests..."
	yarn test

.PHONY: test-watch
test-watch:
	@echo "--- 🧪 Running all unit tests in watch mode..."
	yarn test:watch

.PHONY: test-cov
test-cov:
	@echo "--- 🧪 Running all unit tests with coverage report..."
	yarn test:cov

.PHONY: test-e2e
test-e2e:
	@echo "--- 🧪 Running all end-to-end tests..."
	yarn test:e2e

## --------------------------------------
## 🗄️ Database Migrations (TypeORM)
## --------------------------------------

# Usage: make migration-generate name=CreateUserTable
.PHONY: migration-generate
migration-generate:
	@echo "--- 🗄️ Generating new migration: $(name)..."
	@if [ -z "$(name)" ]; then \
		echo "🚨 Error: Please provide a migration name. Usage: make migration-generate name=YourMigrationName"; \
		exit 1; \
	fi
	 npx typeorm-ts-node-commonjs migration:generate -d ormconfig.ts migrations/$(name)

.PHONY: migration-run
migration-run:
	@echo "--- 🗄️ Running pending database migrations..."
	$(TYPEORM) migration:run -d ormconfig.ts

.PHONY: migration-revert
migration-revert:
	@echo "--- 🗄️ Reverting the last applied migration..."
	npx typeorm-ts-node-commonjs migration:revert -d ormconfig.ts


## --------------------------------------
## 🧹 Housekeeping
## --------------------------------------

.PHONY: clean
clean:
	@echo "--- 🧹 Cleaning up project (removing node_modules, dist, and coverage)..."
	rm -rf node_modules
	rm -rf dist
	rm -rf coverage

## --------------------------------------
## ℹ️ Help
## --------------------------------------

.PHONY: help
help:
	@echo "--- 📖 Available commands ---"
	@echo "install          -> Install yarn dependencies"
	@echo "reinstall        -> Clean all generated files and reinstall dependencies"
	@echo ""
	@echo "build            -> Build the application for production"
	@echo "start            -> Start the app in development mode with watch"
	@echo "start-prod       -> Build and start the app in production mode"
	@echo "start-debug      -> Start the app in debug mode"
	@echo ""
	@echo "lint             -> Lint the codebase"
	@echo "format           -> Format the codebase with Prettier"
	@echo ""
	@echo "test             -> Run unit tests"
	@echo "test-watch       -> Run unit tests in watch mode"
	@echo "test-cov         -> Run unit tests and generate a coverage report"
	@echo "test-e2e         -> Run end-to-end tests"
	@echo ""
	@echo "migration-generate name=<MigrationName>"
	@echo "                 -> Generate a new TypeORM migration file"
	@echo "migration-run    -> Apply all pending migrations"
	@echo "migration-revert -> Revert the last applied migration"
	@echo ""
	@echo "clean            -> Remove node_modules, dist, and coverage folders"
	@echo "---------------------------"
