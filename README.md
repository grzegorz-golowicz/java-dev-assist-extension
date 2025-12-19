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

## 📂 Project Structure

*   `GEMINI.md`: System instructions and agent persona.
*   `gemini-extension.json`: Extension manifest.
*   `commands/`: TOML definitions for each command.
