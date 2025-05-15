<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/images/favicon.ico">
    <title>Edit Property</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Rajdhani:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-glow: #0ea5e9;
            --secondary-glow: #6366f1;
            --accent-color: #10b981;
            --dark-bg: rgba(15, 23, 42, 0.8);
            --border-glow: rgba(14, 165, 233, 0.3);

            /* Keep original colors for components */
            --primary: #2c6e49;
            --primary-hover: #1e5631;
            --secondary: #4d6a6d;
            --light: #f8fafc;
            --dark: #1e293b;
            --success: #10b981;
            --warning: #f59e0b;
            --danger: #ef4444;
            --border: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Rajdhani', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #0f172a;
            color: rgba(255, 255, 255, 0.9);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            position: relative;
            padding-bottom: 2rem;
        }

        /* Geometric background elements */
        .geometric-bg {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: 0;
            opacity: 0.1;
            pointer-events: none;
        }

        .geometric-shape {
            position: absolute;
            border: 1px solid rgba(255, 255, 255, 0.2);
            pointer-events: none;
        }

        .shape-1 {
            width: 300px;
            height: 300px;
            top: 10%;
            left: 5%;
            border-color: var(--primary-glow);
            border-radius: 50%;
        }

        .shape-2 {
            width: 200px;
            height: 200px;
            bottom: 20%;
            right: 10%;
            border-color: var(--secondary-glow);
            transform: rotate(45deg);
        }

        .shape-3 {
            width: 150px;
            height: 150px;
            top: 40%;
            right: 20%;
            border-color: var(--accent-color);
            border-radius: 10px;
            transform: rotate(30deg);
        }

        .page-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 2rem 1rem;
            animation: fadeIn 0.6s ease-in-out;
            position: relative;
            z-index: 1;
        }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            position: relative;
        }

        .header-section::before {
            content: "";
            position: absolute;
            top: 0;
            left: -20px;
            width: 5px;
            height: 40px;
            background: linear-gradient(to bottom, var(--primary-glow), var(--secondary-glow));
            border-radius: 0 4px 4px 0;
        }

        .page-title {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 0;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 600;
            font-family: 'Orbitron', sans-serif;
        }

        .page-title i {
            color: var(--primary-glow);
            font-size: 1.75rem;
            filter: drop-shadow(0 0 8px var(--primary-glow));
        }

        .page-title::after {
            content: "";
            display: block;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-glow), var(--secondary-glow), transparent);
            margin-top: 0.5rem;
        }

        .card {
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background: rgba(30, 41, 59, 0.5);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            margin-bottom: 2rem;
        }

        .card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 30px rgba(14, 165, 233, 0.2);
            border-color: var(--primary-glow);
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 1px;
            background: linear-gradient(90deg, transparent, var(--primary-glow), transparent);
            z-index: 1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .card:hover::before {
            opacity: 1;
        }

        .card-body {
            padding: 2rem;
        }

        .property-id-display {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: rgba(14, 165, 233, 0.1);
            color: var(--primary-glow);
            border-radius: 8px;
            font-weight: 600;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(14, 165, 233, 0.3);
            text-shadow: 0 0 10px rgba(14, 165, 233, 0.3);
        }

        .form-label {
            font-weight: 500;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 0.5rem;
            display: block;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid rgba(255, 255, 255, 0.1);
            padding: 0.625rem 1rem;
            font-size: 0.95rem;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            background-color: rgba(30, 41, 59, 0.3);
            color: rgba(255, 255, 255, 0.9);
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }

        .form-control:focus {
            border-color: var(--primary-glow);
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
            outline: none;
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .input-group {
            position: relative;
        }

        .input-group-text {
            background-color: rgba(15, 23, 42, 0.7);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-right: none;
            color: rgba(255, 255, 255, 0.6);
        }

        .btn {
            padding: 0.625rem 1.25rem;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-glow), var(--secondary-glow));
            border: none;
            color: white;
            position: relative;
            overflow: hidden;
        }

        .btn-primary:hover {
            box-shadow: 0 0 20px rgba(14, 165, 233, 0.4);
            transform: translateY(-2px);
        }

        .btn-primary::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0));
            transform: rotate(30deg);
            transition: transform 0.5s ease;
            opacity: 0;
        }

        .btn-primary:hover::after {
            transform: rotate(30deg) translate(10%, 10%);
            opacity: 1;
        }

        .btn-secondary {
            background-color: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: white;
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
        }

        .btn-secondary:hover {
            background-color: rgba(255, 255, 255, 0.15);
            border-color: var(--primary-glow);
            transform: translateY(-2px);
            box-shadow: 0 0 15px rgba(14, 165, 233, 0.2);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .form-text {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.75rem;
            font-weight: 500;
            text-transform: capitalize;
            margin-left: 0.5rem;
        }

        .status-badge.pending {
            background-color: rgba(245, 158, 11, 0.1);
            color: var(--warning);
            border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .status-badge.approved {
            background-color: rgba(16, 185, 129, 0.1);
            color: var(--accent-color);
            border: 1px solid rgba(16, 185, 129, 0.3);
        }

        .status-badge.rejected {
            background-color: rgba(239, 68, 68, 0.1);
            color: var(--danger);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .price-input {
            position: relative;
        }

        .price-input::before {
            content: "$";
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.6);
            z-index: 10;
        }

        .price-input input {
            padding-left: 2rem;
        }

        select.form-control {
            background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='24' height='24' viewBox='0 0 24 24' fill='none' stroke='white' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
            background-repeat: no-repeat;
            background-position: right 10px center;
            background-size: 16px;
            appearance: none;
            -webkit-appearance: none;
            -moz-appearance: none;
            padding-right: 40px;
        }

        select.form-control option {
            background-color: #1e293b;
            color: white;
        }

        .animate-form-field {
            animation: slideIn 0.4s ease-out forwards;
            opacity: 0;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        /* Responsive adjustments */
        @media (max-width: 768px) {
            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="geometric-bg">
    <div class="geometric-shape shape-1"></div>
    <div class="geometric-shape shape-2"></div>
    <div class="geometric-shape shape-3"></div>
</div>

<div class="page-container">
    <div class="header-section">
        <h1 class="page-title">
            <i class="fas fa-edit"></i>
            Edit Property
        </h1>
    </div>

    <div class="card">
        <div class="card-body">
            <div class="property-id-display">
                <i class="fas fa-home me-2"></i>Property ID: ${property.id}
            </div>

            <form action="${pageContext.request.contextPath}/admin/property/edit" method="post" id="editPropertyForm">
                <input type="hidden" name="id" value="${property.id}">

                <div class="mb-4 animate-form-field" style="animation-delay: 0.1s;">
                    <label for="title" class="form-label">Property Title</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-heading"></i></span>
                        <input type="text" class="form-control" id="title" name="title" value="${property.title}" required placeholder="Enter property title">
                    </div>
                    <div class="form-text">The main title of the property listing</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.2s;">
                    <label for="description" class="form-label">Property Description</label>
                    <textarea class="form-control" id="description" name="description" required placeholder="Enter detailed property description">${property.description}</textarea>
                    <div class="form-text">Detailed description of the property features and amenities</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.3s;">
                    <label for="price" class="form-label">Property Price</label>
                    <div class="price-input">
                        <input type="number" step="0.01" class="form-control" id="price" name="price" value="${property.price}" required placeholder="0.00">
                    </div>
                    <div class="form-text">The listing price of the property</div>
                </div>

                <div class="mb-4 animate-form-field" style="animation-delay: 0.4s;">
                    <label for="status" class="form-label">
                        Property Status
                        <span class="status-badge ${property.status}" id="statusBadge">${property.status}</span>
                    </label>
                    <select class="form-control" id="status" name="status" required>
                        <option value="pending" ${property.status == 'pending' ? 'selected' : ''}>Pending</option>
                        <option value="approved" ${property.status == 'approved' ? 'selected' : ''}>Approved</option>
                        <option value="rejected" ${property.status == 'rejected' ? 'selected' : ''}>Rejected</option>
                    </select>
                    <div class="form-text">Current approval status of the property listing</div>
                </div>

                <div class="form-actions animate-form-field" style="animation-delay: 0.5s;">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/admin/manage-properties" class="btn btn-secondary">
                        <i class="fas fa-times"></i>
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Update status badge when status changes
        const statusSelect = document.getElementById('status');
        const statusBadge = document.getElementById('statusBadge');

        if (statusSelect && statusBadge) {
            statusSelect.addEventListener('change', function() {
                // Update badge text
                statusBadge.textContent = this.value;

                // Remove all status classes
                statusBadge.classList.remove('pending', 'approved', 'rejected');

                // Add the appropriate class
                statusBadge.classList.add(this.value);
            });
        }

        // Form validation enhancement
        const editPropertyForm = document.getElementById('editPropertyForm');

        if (editPropertyForm) {
            editPropertyForm.addEventListener('submit', function(event) {
                const titleField = document.getElementById('title');
                const descriptionField = document.getElementById('description');
                const priceField = document.getElementById('price');

                let isValid = true;

                // Simple validation - this doesn't change functionality, just enhances UX
                if (titleField && titleField.value.trim() === '') {
                    isValid = false;
                    highlightField(titleField);
                }

                if (descriptionField && descriptionField.value.trim() === '') {
                    isValid = false;
                    highlightField(descriptionField);
                }

                if (priceField && (priceField.value.trim() === '' || parseFloat(priceField.value) <= 0)) {
                    isValid = false;
                    highlightField(priceField);
                }

                // The form will still submit normally if valid
                // This just provides visual feedback
            });
        }

        function highlightField(field) {
            field.style.borderColor = 'var(--danger)';
            field.style.boxShadow = '0 0 0 3px rgba(239, 68, 68, 0.2)';

            field.addEventListener('input', function() {
                if (field.value.trim() !== '') {
                    field.style.borderColor = 'var(--primary-glow)';
                    field.style.boxShadow = '0 0 15px rgba(14, 165, 233, 0.2)';
                }
            });
        }
    });
</script>
</body>
</html>