module.exports = function(grunt) {

  // Grunt configuration
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),

    clean: ['.tmp'],

    sass: {
      options: {
        sourceMap: false,
        outputStyle: 'compressed'
      },
      dist: {
        files: {
          'public/css/quivel.css': 'scss/quivel.scss',
          'public/css/quivel-browser.css': 'scss/quivel-browser.scss',
          'public/css/quivel-options.css': 'scss/quivel-options.scss'
        }
      }
    },

    coffeelint: {
      app: [
        'coffee/*.coffee',
        'coffee/**/*.coffee'
      ],
      tests: {
        files: {
          src: ['spec/coffee/*.coffee']
        },
      },
      options: {
        'no_trailing_whitespace': {
          level: 'ignore'
        },'max_line_length': {
          value: 200,
          level: 'ignore'
        }
      }
    },

    concat: {
      options: {
        separator: '\n',
      },
      libjs: {
        src: [
          'node_modules/jquery/dist/jquery.min.js',
          'node_modules/angular/angular.min.js',
          'node_modules/angular-sanitize/angular-sanitize.min.js'
        ],
        dest: 'public/js/lib/lib.min.js',
      },
      quiveljs: {
        src: [
          'public/js/lib/lib.min.js',
          'public/js/app.js',
          'public/js/service/*.js',
          'public/js/directive/*.js',
          'public/js/controller/*.js'
        ],
        dest: 'public/js/quivel.js'
      },
      quivelBrowserjs: {
        src: [
          'public/js/lib/lib.min.js',
          'public/js/localstorage.js',
          'public/js/browser.js'
        ],
        dest: 'public/js/quivel-browser.js'
      },
      quivelOptionsjs: {
        src: [
          'public/js/lib/lib.min.js',
          'public/js/localstorage.js',
          'public/js/options.js'
        ],
        dest: 'public/js/quivel-options.js'
      }
    },

    coffee: {
      glob_to_multiple: {
        expand: true,
        flatten: false,
        cwd: 'coffee',
        src: ['*.coffee', '**/*.coffee'],
        dest: 'public/js/',
        ext: '.js'
      }
    },

    watch: {
      sass: {
        files: ['scss/**/*.{scss,sass}', 'scss/*.scss'],
        tasks: ['sass:dist'],
      },
      coffee: {
        files: [
          'coffee/*.coffee',
          'coffee/**/*.coffee'
        ],
        tasks: ['coffeelint', 'coffee:glob_to_multiple', 'concat:quiveljs', 'concat:quivelBrowserjs', 'concat:quivelOptionsjs'],
      },
      gruntfile: {
        files: [
          'Gruntfile.js',
        ],
        tasks: ['concat:libjs', 'concat:quiveljs', 'concat:quivelBrowserjs', 'concat:quivelOptionsjs'],
      }
    }

  });

  // Load Grunt tasks
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-sass');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-contrib-concat');

  // Run "grunt" to start the go server and watch scss files for recompilation
  grunt.registerTask('default', [
    'coffeelint',
    'coffee:glob_to_multiple',
    'concat:libjs',
    'concat:quiveljs',
    'concat:quivelBrowserjs',
    'concat:quivelOptionsjs',
    'sass',
    'watch',
  ]);

};
