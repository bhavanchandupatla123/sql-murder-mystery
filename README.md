# SQL Murder Mystery

A portfolio investigation completed in MySQL by following clues across a relational database.

## Project objective

The goal of this project was to investigate a fictional murder reported in **SQL City on 15 January 2018** and identify both the person who carried out the crime and the person who hired them.

Rather than treating this as a simple query exercise, I approached it like an analyst: translating narrative clues into data conditions, validating evidence across related tables, and narrowing candidates step by step.

## Skills demonstrated

- SQL filtering and sorting
- INNER JOINs across multiple tables
- Pattern matching with `LIKE`
- Aggregation with `GROUP BY` and `HAVING`
- Relational data investigation
- Candidate elimination and evidence validation
- Translating business-style clues into query logic

## Investigation process

1. Queried the crime-scene report for the murder in SQL City.
2. Identified the two witnesses from address and name clues.
3. Read their interview transcripts.
4. Used gym membership and check-in records to narrow the suspect list.
5. Matched the vehicle plate clue to the remaining candidates.
6. Read the suspect interviews and identified the murderer.
7. Combined gala attendance, driver characteristics and income information to identify the mastermind.

## Final result

**Murderer:** Daniel Reed  
**Mastermind:** Olivia Sterling

## Repository structure

```text
sql-murder-mystery/
├── README.md
└── queries/
    └── investigation.sql
```

The complete step-by-step SQL investigation is available in [`queries/investigation.sql`](queries/investigation.sql).

## What this project shows

This project demonstrates how I use SQL for more than retrieving rows. The investigation required combining information from separate tables, checking assumptions against evidence, and progressively reducing a large dataset into a defensible conclusion.

That same workflow is relevant to real analytical work such as data-quality investigations, customer analysis, operational troubleshooting and root-cause analysis.

---

**Portfolio:** [bhavananalyst.com](https://bhavananalyst.com)  
**GitHub:** [bhavanchandupatla123](https://github.com/bhavanchandupatla123)
