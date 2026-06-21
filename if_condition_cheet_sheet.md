Here is a complete, practical cheat sheet for GitHub Actions `if:` statements. You can bookmark this page or copy-paste these snippets directly into your workflow files.

---

## 1. Branch & Tag Conditions

| If you want to run a step ONLY... | Write this `if` statement |
| --- | --- |
| On the **`main`** branch | `if: github.ref_name == 'main'` |
| On any branch *except* `main` | `if: github.ref_name != 'main'` |
| On a specific feature branch | `if: github.ref_name == 'feature/login'` |
| On a **tag** release (e.g., `v1.0`) | `if: github.ref_type == 'tag'` |
| Only on standard code branches | `if: github.ref_type == 'branch'` |

---

## 2. Trigger Event Conditions

| If you want to run a step ONLY when... | Write this `if` statement |
| --- | --- |
| Code is **pushed** | `if: github.event_name == 'push'` |
| A **Pull Request** is interacted with | `if: github.event_name == 'pull_request'` |
| A user triggers it **manually** | `if: github.event_name == 'workflow_dispatch'` |
| The **cron schedule** fires | `if: github.event_name == 'schedule'` |

---

## 3. Step & Job Status Conditions

By default, steps only run if everything before them succeeded (`success()`). Use these to override that behavior.

| If you want to run a step ONLY if... | Write this `if` statement |
| --- | --- |
| A previous step **failed** (e.g., Send Alerts) | `if: failure()` |
| **No matter what** happens (even if cancelled) | `if: always()` |
| The run was **manually cancelled** | `if: cancelled()` |
| A *specific* step failed | `if: steps.step_id.outcome == 'failure'` |

---

## 4. Advanced String Matching (Functions)

GitHub Actions has built-in functions like `contains`, `startsWith`, and `endsWith` to evaluate text strings.

```yaml
# Run only if the commit message contains the word "[deploy]"
if: contains(github.event.head_commit.message, '[deploy]')

# Run only if the branch name starts with "feature/"
if: startsWith(github.ref_name, 'feature/')

# Run only if a Pull Request has the label "critical"
if: contains(github.event.pull_request.labels.*.name, 'critical')

```

---

## 5. Combining Multiple Conditions

You can chain conditions together using logical operators: **`&&` (AND)**, **`||` (OR)**, and **`!` (NOT)**.

```yaml
# Example A: Must be on 'main' AND triggered by a push
if: github.ref_name == 'main' && github.event_name == 'push'

# Example B: Must be on 'main' OR 'develop'
if: github.ref_name == 'main' || github.ref_name == 'develop'

# Example C: Must be on 'main' AND NOT triggered by a PR
if: github.ref_name == 'main' && github.event_name != 'pull_request'

```

---

##  Checklist: Avoiding the 2 Most Common Bugs

1. **Do NOT use `${{ }}` inside `if:` lines.**
* ❌ `if: ${{ github.ref_name == 'main' }}` (Redundant, prone to syntax breaking)
* `if: github.ref_name == 'main'` (Clean and correct)


2. **Always wrap your text strings in single quotes.**
* ❌ `if: github.ref_name == main` (GitHub thinks `main` is a variable name and crashes)
* `if: github.ref_name == 'main'` (Correct string comparison)
