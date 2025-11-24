# Timesheet API

A Rails API for managing timesheets and tracking billable hours. This is only for demonstration purposes. This can run localy if Ruby is installed.   

## Setup

```bash
bundle install
rails db:create
rails db:migrate
rails s
```

## Authentication

The API uses JWT (JSON Web Tokens) for authentication.

### Sign Up
```bash
POST /api/v1/auth/sign_up
{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```

### Login
```bash
POST /api/v1/auth/login
{
  "email": "user@example.com",
  "password": "password123"
}
```

Response includes `token` - use this in subsequent requests.

## Authenticated Endpoints

Add `Authorization: Bearer <token>` header to all requests.

### Timesheets
```bash
GET    /api/v1/timesheets              # List all timesheets
POST   /api/v1/timesheets              # Create timesheet
GET    /api/v1/timesheets/:id          # Get timesheet
PUT    /api/v1/timesheets/:id          # Update timesheet
DELETE /api/v1/timesheets/:id          # Delete timesheet
```

### Line Items (nested under timesheets)
```bash
POST   /api/v1/timesheets/:timesheet_id/line_items     # Add line item
PUT    /api/v1/timesheets/:timesheet_id/line_items/:id # Update line item
DELETE /api/v1/timesheets/:timesheet_id/line_items/:id # Delete line item
```

## Models

- **User**: Email, password (via bcrypt)
- **TimeSheet**: Description, rate (decimal), belongs_to user, has_many line_items
- **LineItem**: Date, minutes, belongs_to timesheet

Totals calculated automatically:
- `total_time`: Sum of all line item minutes
- `total_cost`: total_time × rate

## ID Encoding

IDs for timesheets and line items are encoded using Hashids to provide obfuscated, non-sequential identifiers in API responses and URLs.

## Testing

```bash
rspec --format documentation
```

Test files in `spec/models/` and `spec/requests/`
