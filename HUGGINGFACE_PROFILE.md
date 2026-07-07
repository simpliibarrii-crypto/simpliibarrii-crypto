# Hugging Face Profile Copy Pack

Use this copy to refresh the `bclermo` Hugging Face profile and repo cards.

## Profile Bio

Clinical AI and biology AI builder working on the Raven AI ecosystem: local-first agent workflows, supervised healthcare tooling, signed model/runtime infrastructure, and practical demos for PSWs, nurses, researchers, and small teams.

Focus areas:

- Clinical AI workflow support
- Long-term-care and PSW documentation tools
- Biology AI and research automation
- Local-first agents and sovereign compute
- Consent, auditability, and signed model registries

GitHub: https://github.com/simpliibarrii-crypto

## Featured Projects

### Raven AI

Flagship agent platform for biology and healthcare workflows. Raven AI is the umbrella project for research automation, clinical evidence workflows, local-first agents, and practical agent orchestration.

Links:

- Model: https://hf.co/bclermo/raven-ai
- Space: https://hf.co/spaces/bclermo/raven-ai
- GitHub: https://github.com/simpliibarrii-crypto/raven-ai

### OpenClinical AI

Development-preview clinical AI runtime for PSW shift handoff workflows, signed model loading, tenant-aware APIs, consent checks, and audit logging.

Important scope note: OpenClinical AI is not a certified medical device and is not clinically validated. It is an MVP foundation for supervised workflow support and developer testing.

Links:

- Model: https://hf.co/bclermo/openclinical-ai
- Space: https://hf.co/spaces/bclermo/openclinical-ai
- GitHub: https://github.com/simpliibarrii-crypto/openclinical-ai

### Home for AI

Local-first orchestration layer for coordinating agent workflows across personal and small-team compute.

Links:

- Model: https://hf.co/bclermo/home-for-ai
- Space: https://hf.co/spaces/bclermo/home-for-ai
- GitHub: https://github.com/simpliibarrii-crypto/home-for-ai

## OpenClinical AI Model Card Replacement

```markdown
---
language:
- en
license: apache-2.0
tags:
- clinical-ai
- healthcare
- fhir
- audit-logging
- consent
- local-first
- signed-model-registry
library_name: custom
pipeline_tag: text-generation
---

# OpenClinical AI

OpenClinical AI is a development-preview runtime for supervised clinical AI workflows. The current MVP focuses on PSW shift handoff documentation, signed model manifests, tenant-aware request handling, consent checks, and audit logging.

## What Works Today

- FastAPI runtime for clinical workflow demos
- Signed `psw-shift-handoff` heuristic model manifest
- Tenant-aware APIs
- Consent token checks
- Append-only audit logging
- Static PSW UI surface
- Smoke tests for model loading and consent safety

## Intended Use

OpenClinical AI is intended for developer testing, supervised workflow demos, and clinical AI infrastructure research. It should not be used for autonomous diagnosis, treatment decisions, or unsupervised clinical deployment.

## Safety Scope

This project is not a certified medical device and is not clinically validated. Any production healthcare deployment requires formal privacy, security, clinical governance, and regulatory review.

## Links

- GitHub: https://github.com/simpliibarrii-crypto/openclinical-ai
- Demo Space: https://hf.co/spaces/bclermo/openclinical-ai
```

## Raven AI Model Card Replacement

```markdown
---
language:
- en
license: apache-2.0
tags:
- agentic-ai
- biology-ai
- healthcare-ai
- local-first
- research-automation
library_name: custom
pipeline_tag: text-generation
---

# Raven AI

Raven AI is the flagship project in the Raven ecosystem: an agent platform direction for biology, healthcare, and research workflows.

## Focus

- Agentic research workflows
- Biology AI orchestration
- Clinical evidence and workflow support
- Local-first execution paths
- Reproducible, auditable outputs

## Current Status

Active development. The project is being hardened around real runtime behavior, clear docs, and reliable demos.

## Links

- GitHub: https://github.com/simpliibarrii-crypto/raven-ai
- Demo Space: https://hf.co/spaces/bclermo/raven-ai
```

## Home for AI Model Card Replacement

```markdown
---
language:
- en
license: mit
tags:
- local-first
- ai-agents
- orchestration
- desktop-ai
- sovereign-computing
library_name: custom
pipeline_tag: text-generation
---

# Home for AI

Home for AI is the local-first orchestration layer for the Raven ecosystem. It is intended to coordinate agent workflows across personal and small-team compute environments.

## Focus

- Local agent orchestration
- Desktop and small-team workflows
- Secure runtime coordination
- Bridge layer for Raven AI and OpenClinical AI

## Current Status

Active development. The immediate goal is to make the project runnable, clearly scoped, and aligned with the Raven AI ecosystem.

## Links

- GitHub: https://github.com/simpliibarrii-crypto/home-for-ai
- Demo Space: https://hf.co/spaces/bclermo/home-for-ai
```
