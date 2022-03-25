module.exports = {
  content: [
    './app/views/**/*.{slim,erb,jbuilder,turbo_stream,js}',
    './app/decorators/**/*.rb',
    './app/helpers/**/*.rb',
    './app/inputs/**/*.rb',
    './app/assets/javascripts/**/*.js',
    './config/initializers/**/*.rb',
    './lib/components/**/*.rb'
  ],
  safelist: [
    {
      pattern: /bg-(red|green|blue|orange)-(100|200|400)/
    },
    {
      pattern: /text-(red|green|blue|orange)-(100|200|400)/
    },
    'pagy-*'
  ],
  variants: {
    extend: {
      overflow: ['hover']
    }
  },
  theme: {
    listStyleType: {
      none: 'none',
      disc: 'disc',
      decimal: 'decimal',
      square: 'square',
      roman: 'upper-roman'
    }
  },
  plugins: [
    require('@tailwindcss/typography'),
    require('daisyui')
  ],
  daisyui: {
    logs: false,
    themes: [
      {
        light: {
          primary: '#1A2280',
          'primary-focus': '#70266A',
          'primary-content': '#ffffff',
          secondary: '#b93456',
          'secondary-focus': '#f3cc30',
          'secondary-content': '#ffffff',
          accent: '#37cdbe',
          'accent-focus': '#2aa79b',
          'accent-content': '#ffffff',
          neutral: '#3d4451',
          'neutral-focus': '#2a2e37',
          'neutral-content': '#ffffff',
          'base-100': '#ffffff',
          'base-200': '#f9fafb',
          'base-300': '#d1d5db',
          'base-content': '#1f2937',
          info: '#2094f3',
          success: '#36D399',
          warning: '#ff9900',
          error: '#ff5724',
          '--border-color': 'var(--b3)',
          '--rounded-box': '1rem',
          '--rounded-btn': '0.5rem',
          '--rounded-badge': '1.9rem',
          '--animation-btn': '0.25s',
          '--animation-input': '.2s',
          '--btn-text-case': 'uppercase',
          '--btn-focus-scale': '0.95',
          '--navbar-padding': '.5rem',
          '--border-btn': '1px',
          '--tab-border': '1px',
          '--tab-radius': '0.5rem'
        }
      },
      {
        dark: {
          primary: '#1A2280',
          'primary-focus': '#70266A',
          'primary-content': '#ffffff',
          secondary: '#b93456',
          'secondary-focus': '#bd0091',
          'secondary-content': '#ffffff',
          accent: '#37cdbe',
          'accent-focus': '#2aa79b',
          'accent-content': '#ffffff',
          neutral: '#2a2e37',
          'neutral-focus': '#16181d',
          'neutral-content': '#ffffff',
          'base-100': '#3d4451',
          'base-200': '#2a2e37',
          'base-300': '#16181d',
          'base-content': '#ebecf0',
          info: '#66c6ff',
          success: '#87d039',
          warning: '#e2d562',
          error: '#ff6f6f',
          '--border-color': 'var(--b3)',
          '--rounded-box': '1rem',
          '--rounded-btn': '0.5rem',
          '--rounded-badge': '1.9rem',
          '--animation-btn': '0.25s',
          '--animation-input': '.2s',
          '--btn-text-case': 'uppercase',
          '--btn-focus-scale': '0.95',
          '--navbar-padding': '.5rem',
          '--border-btn': '1px',
          '--tab-border': '1px',
          '--tab-radius': '0.5rem'
        }
      }
    ]
  }
}
