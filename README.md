# Java Dev Assist Extension

**Java Dev Assist** is an expert AI assistant extension for the Gemini CLI, specializing in **Java 17+**, **Quarkus**, and **Spring Boot** development. It assists developers with code reviews, debugging stack traces, managing dependencies, and enforcing architectural boundaries.

## 🚀 Features

*   **Stack Specialization**: Optimized for Modern Java (17+), Quarkus, and Spring Boot.
*   **Context Awareness**: Automatically detects build systems (Maven/Gradle) and project frameworks to provide relevant suggestions.
*   **Safety First**: Prioritizes non-destructive analysis and asks for confirmation before making changes.
*   **Architectural Guardrails**: Includes specific tools to enforce domain boundaries (e.g., keeping DTOs out of Service layers).

## 📦 Installation

To install this extension locally:

```bash
gemini extension install .
```

To update the extension after making changes:

```bash
gemini extension uninstall java-dev-assist-extension && gemini extension install .
```

## 🛠 Commands

### `/java`
**Description**: Displays the main help menu and index of available commands.
**Usage**:
```bash
/java
```

### `/java:readme`
**Description**: Creates or updates README.md for the analyzed Java project using either README.guidelines.md (if present) or the built-in defaults.
**Usage**:
```bash
/java:readme
```
**Notes**:
* Only AI-managed blocks wrapped by `<!-- AI:START -->` and `<!-- AI:END -->` are updated; manual content stays untouched.
* Output follows a neutral, technical tone and defaults to a conservative structure when no guidelines file exists.

### `/java:stacktrace`
**Description**: Analyzes Java stack traces to identify root causes and propose concrete fixes.
**Usage**:
```bash
/java:stacktrace <paste_your_stacktrace_here>
```
**Output**:
*   Root cause analysis.
*   Most likely failing component.
*   Recommended immediate checks and fixes.

### `/java:review`
**Description**: Smart code review assistant. Analyzes `git diff` for logical risks, security vulnerabilities, regressions, and missing tests. It avoids style nitpicks to focus on high-value feedback.
**Usage**:
```bash
# Review current unstaged changes
/java:review

# Review changes against the previous commit
/java:review HEAD~1
```
**Output**:
*   Risk assessment (High/Medium/Low).
*   Evidence from the code.
*   Recommended actions (Must-do, Should-do).

### `/java:deps`
**Description**: Analyzes project dependencies (Maven/Gradle). Checks for version conflicts, outdated libraries, and known security vulnerabilities.
**Usage**:
```bash
/java:deps
```

### `/java:boundary`
**Description**: Enforces architectural boundaries. Currently focuses on the rule that **DTO types must not appear in Service method signatures**.
**Why**: This ensures business logic remains agnostic to the transport layer (REST, gRPC, etc.).
**Usage**:
```bash
/java:boundary
```
**Output**:
*   Confirmed violations (Service methods accepting/returning DTOs).
*   Suspected violations.
*   Refactoring recommendations.

## ⚖️ Core Principles

1.  **Safety First**: We verify before we act. Destructive commands require user confirmation.
2.  **No "Magic"**: We explain *why* a change is suggested. We don't generate massive blocks of code without understanding the context.
3.  **Context Aware**: We read `pom.xml` or `build.gradle` first to tailor advice to your specific stack.

## README automation (java:readme)

The `java:readme` command determines whether a `README.guidelines.md` file is available and applies its structure. If not, it falls back to a default order: Project Overview, Tech Stack, Build & Run, Project Structure, Configuration, and optional Limitations/Notes. Only the AI-managed block below is updated automatically; anything outside remains manual.

<!-- AI:START -->
## Project Overview
TODO: Summarize the analyzed Java project's purpose based on build configuration and visible source layout.

## Tech Stack
TODO: Note the detected build tool (Maven/Gradle), Java version, and frameworks (e.g., Spring Boot, Quarkus) inferred from dependencies.

## Build & Run
TODO: Provide the exact build/run commands observed (e.g., `./mvnw spring-boot:run`, `./gradlew quarkusDev`). Leave TODO if not discoverable.

## Project Structure
TODO: Outline key modules or directories in the repository using visible paths.

## Configuration
TODO: List main configuration files (e.g., `application.properties`, `application.yml`) and any notable settings surfaced in the codebase.

## Limitations / Notes
TODO: Capture known constraints or gaps; if unknown, keep TODO.
<!-- AI:END -->

## Validation

To verify that `java:readme` produced an English README with non-empty AI-managed content and markers, run:

```bash
./scripts/readme-validation.sh
```

## 📂 Project Structure

*   `GEMINI.md`: System instructions and agent persona.
*   `gemini-extension.json`: Extension manifest.
*   `commands/`: TOML definitions for each command.
