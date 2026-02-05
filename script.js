// Mobile Menu Toggle
const mobileMenuToggle = document.getElementById('mobileMenuToggle');
const nav = document.querySelector('.nav');

if (mobileMenuToggle) {
    mobileMenuToggle.addEventListener('click', () => {
        nav.classList.toggle('active');
        mobileMenuToggle.classList.toggle('active');
    });
}

// Close mobile menu when clicking on a link
document.querySelectorAll('.nav-link').forEach(link => {
    link.addEventListener('click', () => {
        nav.classList.remove('active');
        mobileMenuToggle.classList.remove('active');
    });
});

// Header Scroll Effect
const header = document.getElementById('header');
let lastScroll = 0;

window.addEventListener('scroll', () => {
    const currentScroll = window.pageYOffset;
    
    if (currentScroll > 100) {
        header.style.boxShadow = '0 2px 20px rgba(0, 166, 81, 0.3)';
        header.style.backgroundColor = 'rgba(0, 0, 0, 0.98)';
    } else {
        header.style.boxShadow = '0 2px 20px rgba(0, 166, 81, 0.2)';
        header.style.backgroundColor = 'rgba(0, 0, 0, 0.95)';
    }
    
    lastScroll = currentScroll;
});

// Smooth Scroll for Navigation Links
document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();
        const target = document.querySelector(this.getAttribute('href'));
        if (target) {
            const headerHeight = header.offsetHeight;
            const targetPosition = target.offsetTop - headerHeight;
            window.scrollTo({
                top: targetPosition,
                behavior: 'smooth'
            });
        }
    });
});

// Contact Form Handler
const contactForm = document.getElementById('contactForm');

if (contactForm) {
    contactForm.addEventListener('submit', (e) => {
        e.preventDefault();
        
        // Get form data
        const formData = new FormData(contactForm);
        const inputs = contactForm.querySelectorAll('input, textarea');
        const formValues = {};
        
        inputs.forEach(input => {
            if (input.type !== 'checkbox') {
                formValues[input.placeholder || input.name] = input.value;
            }
        });
        
        // Here you would typically send the data to a server
        console.log('Form submitted:', formValues);
        
        // Show success message
        const successMessage = document.createElement('div');
        successMessage.style.cssText = `
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: linear-gradient(135deg, #00a651 0%, #00d084 100%);
            color: white;
            padding: 30px 50px;
            border-radius: 10px;
            box-shadow: 0 10px 40px rgba(0, 166, 81, 0.4);
            z-index: 10000;
            text-align: center;
            font-size: 18px;
            font-weight: 600;
        `;
        successMessage.textContent = 'Спасибо! Мы свяжемся с вами в течение 24 часов.';
        document.body.appendChild(successMessage);
        
        // Reset form
        contactForm.reset();
        
        // Remove success message after 3 seconds
        setTimeout(() => {
            successMessage.remove();
        }, 3000);
    });
}

// Intersection Observer for Animations
const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
};

const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting) {
            entry.target.style.opacity = '1';
            entry.target.style.transform = 'translateY(0)';
        }
    });
}, observerOptions);

// Observe elements for animation
document.addEventListener('DOMContentLoaded', () => {
    const animateElements = document.querySelectorAll(
        '.advantage-item, .number-card, .testimonial-card, .feature-item, .process-step'
    );
    
    animateElements.forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        observer.observe(el);
    });
});

// Number Counter Animation
function animateCounter(element, target, duration = 2000) {
    const start = 0;
    const increment = target / (duration / 16);
    let current = start;
    
    const timer = setInterval(() => {
        current += increment;
        if (current >= target) {
            element.textContent = target + (element.textContent.includes('+') ? '+' : '') + 
                                 (element.textContent.includes('%') ? '%' : '') +
                                 (element.textContent.includes('К') ? 'К' : '') +
                                 (element.textContent.includes('М') ? 'М' : '') +
                                 (element.textContent.includes('₽') ? ' ₽' : '');
            clearInterval(timer);
        } else {
            const value = Math.floor(current);
            element.textContent = value + (element.textContent.includes('+') ? '+' : '') + 
                                 (element.textContent.includes('%') ? '%' : '') +
                                 (element.textContent.includes('К') ? 'К' : '') +
                                 (element.textContent.includes('М') ? 'М' : '') +
                                 (element.textContent.includes('₽') ? ' ₽' : '');
        }
    }, 16);
}

// Observe number cards for counter animation
const numberObserver = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
        if (entry.isIntersecting && !entry.target.classList.contains('counted')) {
            entry.target.classList.add('counted');
            const numberValue = entry.target.querySelector('.number-value');
            if (numberValue) {
                const text = numberValue.textContent;
                const number = parseInt(text.replace(/\D/g, ''));
                if (number) {
                    numberValue.textContent = text; // Preserve original format
                    // Uncomment to enable counter animation
                    // animateCounter(numberValue, number);
                }
            }
        }
    });
}, { threshold: 0.5 });

document.querySelectorAll('.number-card').forEach(card => {
    numberObserver.observe(card);
});

// Add smooth scroll behavior for buttons
document.querySelectorAll('.btn').forEach(btn => {
    btn.addEventListener('click', function(e) {
        const href = this.getAttribute('onclick');
        if (href && href.includes('scrollIntoView')) {
            // Already handled by onclick
            return;
        }
    });
});

// Form validation enhancement
document.querySelectorAll('.form-input').forEach(input => {
    input.addEventListener('blur', function() {
        if (this.value.trim() === '' && this.hasAttribute('required')) {
            this.style.borderColor = 'rgba(255, 0, 0, 0.5)';
        } else {
            this.style.borderColor = 'rgba(255, 255, 255, 0.3)';
        }
    });
    
    input.addEventListener('input', function() {
        if (this.value.trim() !== '') {
            this.style.borderColor = 'rgba(255, 255, 255, 0.5)';
        }
    });
});

// Phone input formatting
const phoneInputs = document.querySelectorAll('input[type="tel"]');
phoneInputs.forEach(input => {
    input.addEventListener('input', function(e) {
        let value = e.target.value.replace(/\D/g, '');
        if (value.length > 0) {
            if (value.length <= 1) {
                value = '+7 (' + value;
            } else if (value.length <= 4) {
                value = '+7 (' + value.substring(1);
            } else if (value.length <= 7) {
                value = '+7 (' + value.substring(1, 4) + ') ' + value.substring(4);
            } else if (value.length <= 9) {
                value = '+7 (' + value.substring(1, 4) + ') ' + value.substring(4, 7) + '-' + value.substring(7);
            } else {
                value = '+7 (' + value.substring(1, 4) + ') ' + value.substring(4, 7) + '-' + value.substring(7, 9) + '-' + value.substring(9, 11);
            }
        }
        e.target.value = value;
    });
});
