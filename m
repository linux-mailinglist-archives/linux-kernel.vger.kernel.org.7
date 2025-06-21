Return-Path: <linux-kernel+bounces-696821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451BAE2C0F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428503BD352
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 19:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59F3275B08;
	Sat, 21 Jun 2025 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxXFEcru"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79077271444;
	Sat, 21 Jun 2025 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750535761; cv=none; b=t4VjhCI2mKvqi6RtV0CPJ6N45VLIF7NrIbQr7nDqL+2DRUiEEY8Yiq+5nwNsJGv+flSdI0Uk117nZCA+c+ZBfyFI0vllvcXhhI0tsLG4nNBWacp+RKOQmNb1exOsgs6zVEhqPHFo8OSeu7Qw36RlyDV/jwPMGJswKX0PvR6ANXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750535761; c=relaxed/simple;
	bh=DJWn2NdXSfYMasLzdx/Yi+SRy9LroDQ3ca9CsyiDFIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9EzdDq7+Ng/eZpT+AZUebk9VasFujhuOsJc8wFl9AA0M5apxlNsQkgBBNPQ7Cowr8wylrLB1a5OJSKyCQk4ag5Cd5RFRfRA6oxs4Twg2jlhI76rJgTt8VDNMB0EGkE9mUIllrFEmfu2S+rzGyjWXHEVnjXD1CB4tX+v77QWcXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxXFEcru; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E7CC4AF0F;
	Sat, 21 Jun 2025 19:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750535761;
	bh=DJWn2NdXSfYMasLzdx/Yi+SRy9LroDQ3ca9CsyiDFIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jxXFEcrugy1YL8nO4LprIAPvIGOTHSsE4W8YhBNZNBFdAqHcnlzV/KwTNleFa2R62
	 soRWcHtyqG+Psy/L9r8EVnS0VUz/lArjD9wCcM4L71XehQYBSn8r2bLke6qpQS4Q4I
	 OJpisPFUAk+UK6ZGZqAP1P4VsYbpXpTHTyK8jw3ao7JDzMkMf3HqB9+1hrXwuZNa0s
	 fk73T1XxAQ80RCvXWNIP+LjBnyJOC0t43P9tb2w3qrPjBSuvcnHwZFxEKVVLxo6srm
	 i34Kb+gx6/By/QB0jBkdrdY/uCVxGAFYAurV2nW8NUNUuuAZx2tBpsByXfLBnUihZz
	 +owtG1foQ2SyQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uT4Ji-00000000e4S-3pCG;
	Sat, 21 Jun 2025 21:55:58 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/15] docs: conf.py: several coding style fixes
Date: Sat, 21 Jun 2025 21:55:53 +0200
Message-ID: <9b642e7063eff6a1d1a6a24bddcabee1fab97a2a.1750535171.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750535171.git.mchehab+huawei@kernel.org>
References: <cover.1750535171.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

conf.py is missing a SPDX header and doesn't really have
a proper python coding style. It also has an obsolete
commented LaTeX syntax that doesn't work anymore.

Clean it up a little bit with some help from autolints
and manual adjustments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 354 +++++++++++++++++++++---------------------
 1 file changed, 174 insertions(+), 180 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 4ba4ee45e599..e4dde5aa4559 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -1,24 +1,28 @@
-# -*- coding: utf-8 -*-
-#
-# The Linux Kernel documentation build configuration file, created by
-# sphinx-quickstart on Fri Feb 12 13:51:46 2016.
-#
-# This file is execfile()d with the current directory set to its
-# containing dir.
-#
-# Note that not all possible configuration values are present in this
-# autogenerated file.
-#
-# All configuration values have a default; values that are commented out
-# serve to show the default.
+# SPDX-License-Identifier: GPL-2.0-only
+# pylint: disable=C0103,C0209
+
+"""
+The Linux Kernel documentation build configuration file.
+"""
 
-import sys
 import os
-import sphinx
 import shutil
+import sys
+
+import sphinx
+
+# If extensions (or modules to document with autodoc) are in another directory,
+# add these directories to sys.path here. If the directory is relative to the
+# documentation root, use os.path.abspath to make it absolute, like shown here.
+sys.path.insert(0, os.path.abspath("sphinx"))
+
+from load_config import loadConfig               # pylint: disable=C0413,E0401
+
+# Minimal supported version
+needs_sphinx = "3.4.3"
 
 # Get Sphinx version
-major, minor, patch = sphinx.version_info[:3]
+major, minor, patch = sphinx.version_info[:3]          # pylint: disable=I1101
 
 # Include_patterns were added on Sphinx 5.1
 if (major < 5) or (major == 5 and minor < 1):
@@ -26,23 +30,23 @@ if (major < 5) or (major == 5 and minor < 1):
 else:
     has_include_patterns = True
     # Include patterns that don't contain directory names, in glob format
-    include_patterns = ['**.rst']
+    include_patterns = ["**.rst"]
 
 # Location of Documentation/ directory
-doctree = os.path.abspath('.')
+doctree = os.path.abspath(".")
 
 # Exclude of patterns that don't contain directory names, in glob format.
 exclude_patterns = []
 
 # List of patterns that contain directory names in glob format.
 dyn_include_patterns = []
-dyn_exclude_patterns = ['output']
+dyn_exclude_patterns = ["output"]
 
 # Properly handle include/exclude patterns
 # ----------------------------------------
 
+
 def update_patterns(app):
-
     """
     On Sphinx, all directories are relative to what it is passed as
     SOURCEDIR parameter for sphinx-build. Due to that, all patterns
@@ -53,15 +57,12 @@ def update_patterns(app):
     exclude relative patterns that start with "../".
     """
 
-    sourcedir = app.srcdir  # full path to the source directory
-    builddir = os.environ.get("BUILDDIR")
-
     # setup include_patterns dynamically
     if has_include_patterns:
         for p in dyn_include_patterns:
             full = os.path.join(doctree, p)
 
-            rel_path = os.path.relpath(full, start = app.srcdir)
+            rel_path = os.path.relpath(full, start=app.srcdir)
             if rel_path.startswith("../"):
                 continue
 
@@ -71,15 +72,17 @@ def update_patterns(app):
     for p in dyn_exclude_patterns:
         full = os.path.join(doctree, p)
 
-        rel_path = os.path.relpath(full, start = app.srcdir)
+        rel_path = os.path.relpath(full, start=app.srcdir)
         if rel_path.startswith("../"):
             continue
 
         app.config.exclude_patterns.append(rel_path)
 
+
 # helper
 # ------
 
+
 def have_command(cmd):
     """Search ``cmd`` in the ``PATH`` environment.
 
@@ -88,24 +91,23 @@ def have_command(cmd):
     """
     return shutil.which(cmd) is not None
 
-# If extensions (or modules to document with autodoc) are in another directory,
-# add these directories to sys.path here. If the directory is relative to the
-# documentation root, use os.path.abspath to make it absolute, like shown here.
-sys.path.insert(0, os.path.abspath('sphinx'))
-from load_config import loadConfig
 
 # -- General configuration ------------------------------------------------
 
-# If your documentation needs a minimal Sphinx version, state it here.
-needs_sphinx = '3.4.3'
-
-# Add any Sphinx extension module names here, as strings. They can be
-# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
-# ones.
-extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include',
-              'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
-              'maintainers_include', 'sphinx.ext.autosectionlabel',
-              'kernel_abi', 'kernel_feat', 'translations']
+# Add any Sphinx extensions in alphabetic order
+extensions = [
+    "automarkup",
+    "kernel_abi",
+    "kerneldoc",
+    "kernel_feat",
+    "kernel_include",
+    "kfigure",
+    "maintainers_include",
+    "rstFlatTable",
+    "sphinx.ext.autosectionlabel",
+    "sphinx.ext.ifconfig",
+    "translations",
+]
 
 # Since Sphinx version 3, the C function parser is more pedantic with regards
 # to type checking. Due to that, having macros at c:function cause problems.
@@ -180,28 +182,28 @@ autosectionlabel_maxdepth = 2
 # Load math renderer:
 # For html builder, load imgmath only when its dependencies are met.
 # mathjax is the default math renderer since Sphinx 1.8.
-have_latex =  have_command('latex')
-have_dvipng = have_command('dvipng')
+have_latex = have_command("latex")
+have_dvipng = have_command("dvipng")
 load_imgmath = have_latex and have_dvipng
 
 # Respect SPHINX_IMGMATH (for html docs only)
-if 'SPHINX_IMGMATH' in os.environ:
-    env_sphinx_imgmath = os.environ['SPHINX_IMGMATH']
-    if 'yes' in env_sphinx_imgmath:
+if "SPHINX_IMGMATH" in os.environ:
+    env_sphinx_imgmath = os.environ["SPHINX_IMGMATH"]
+    if "yes" in env_sphinx_imgmath:
         load_imgmath = True
-    elif 'no' in env_sphinx_imgmath:
+    elif "no" in env_sphinx_imgmath:
         load_imgmath = False
     else:
         sys.stderr.write("Unknown env SPHINX_IMGMATH=%s ignored.\n" % env_sphinx_imgmath)
 
 if load_imgmath:
     extensions.append("sphinx.ext.imgmath")
-    math_renderer = 'imgmath'
+    math_renderer = "imgmath"
 else:
-    math_renderer = 'mathjax'
+    math_renderer = "mathjax"
 
 # Add any paths that contain templates here, relative to this directory.
-templates_path = ['sphinx/templates']
+templates_path = ["sphinx/templates"]
 
 # The suffix(es) of source filenames.
 # You can specify multiple suffix as a list of string:
@@ -209,15 +211,15 @@ templates_path = ['sphinx/templates']
 source_suffix = '.rst'
 
 # The encoding of source files.
-#source_encoding = 'utf-8-sig'
+# source_encoding = 'utf-8-sig'
 
 # The master toctree document.
-master_doc = 'index'
+master_doc = "index"
 
 # General information about the project.
-project = 'The Linux Kernel'
-copyright = 'The kernel development community'
-author = 'The kernel development community'
+project = "The Linux Kernel"
+copyright = "The kernel development community"         # pylint: disable=W0622
+author = "The kernel development community"
 
 # The version info for the project you're documenting, acts as replacement for
 # |version| and |release|, also used in various other places throughout the
@@ -232,82 +234,86 @@ author = 'The kernel development community'
 try:
     makefile_version = None
     makefile_patchlevel = None
-    for line in open('../Makefile'):
-        key, val = [x.strip() for x in line.split('=', 2)]
-        if key == 'VERSION':
-            makefile_version = val
-        elif key == 'PATCHLEVEL':
-            makefile_patchlevel = val
-        if makefile_version and makefile_patchlevel:
-            break
-except:
+    with open("../Makefile", encoding="utf=8") as fp:
+        for line in fp:
+            key, val = [x.strip() for x in line.split("=", 2)]
+            if key == "VERSION":
+                makefile_version = val
+            elif key == "PATCHLEVEL":
+                makefile_patchlevel = val
+            if makefile_version and makefile_patchlevel:
+                break
+except Exception:
     pass
 finally:
     if makefile_version and makefile_patchlevel:
-        version = release = makefile_version + '.' + makefile_patchlevel
+        version = release = makefile_version + "." + makefile_patchlevel
     else:
         version = release = "unknown version"
 
-#
-# HACK: there seems to be no easy way for us to get at the version and
-# release information passed in from the makefile...so go pawing through the
-# command-line options and find it for ourselves.
-#
+
 def get_cline_version():
-    c_version = c_release = ''
+    """
+    HACK: There seems to be no easy way for us to get at the version and
+    release information passed in from the makefile...so go pawing through the
+    command-line options and find it for ourselves.
+    """
+
+    c_version = c_release = ""
     for arg in sys.argv:
-        if arg.startswith('version='):
+        if arg.startswith("version="):
             c_version = arg[8:]
-        elif arg.startswith('release='):
+        elif arg.startswith("release="):
             c_release = arg[8:]
     if c_version:
         if c_release:
-            return c_version + '-' + c_release
+            return c_version + "-" + c_release
         return c_version
-    return version # Whatever we came up with before
+    return version  # Whatever we came up with before
+
 
 # The language for content autogenerated by Sphinx. Refer to documentation
 # for a list of supported languages.
 #
 # This is also used if you do content translation via gettext catalogs.
 # Usually you set "language" from the command line for these cases.
-language = 'en'
+language = "en"
 
 # There are two options for replacing |today|: either, you set today to some
 # non-false value, then it is used:
-#today = ''
+# today = ''
 # Else, today_fmt is used as the format for a strftime call.
-#today_fmt = '%B %d, %Y'
+# today_fmt = '%B %d, %Y'
 
 # The reST default role (used for this markup: `text`) to use for all
 # documents.
-#default_role = None
+# default_role = None
 
 # If true, '()' will be appended to :func: etc. cross-reference text.
-#add_function_parentheses = True
+# add_function_parentheses = True
 
 # If true, the current module name will be prepended to all description
 # unit titles (such as .. function::).
-#add_module_names = True
+# add_module_names = True
 
 # If true, sectionauthor and moduleauthor directives will be shown in the
 # output. They are ignored by default.
-#show_authors = False
+# show_authors = False
 
 # The name of the Pygments (syntax highlighting) style to use.
-pygments_style = 'sphinx'
+pygments_style = "sphinx"
 
 # A list of ignored prefixes for module index sorting.
-#modindex_common_prefix = []
+# modindex_common_prefix = []
 
 # If true, keep warnings as "system message" paragraphs in the built documents.
-#keep_warnings = False
+# keep_warnings = False
 
 # If true, `todo` and `todoList` produce output, else they produce nothing.
 todo_include_todos = False
 
-primary_domain = 'c'
-highlight_language = 'none'
+primary_domain = "c"
+highlight_language = "none"
 
 # -- Options for HTML output ----------------------------------------------
 
@@ -315,43 +321,45 @@ highlight_language = 'none'
 # a list of builtin themes.
 
 # Default theme
-html_theme = 'alabaster'
+html_theme = "alabaster"
 html_css_files = []
 
 if "DOCS_THEME" in os.environ:
     html_theme = os.environ["DOCS_THEME"]
 
-if html_theme == 'sphinx_rtd_theme' or html_theme == 'sphinx_rtd_dark_mode':
+if html_theme in ["sphinx_rtd_theme", "sphinx_rtd_dark_mode"]:
     # Read the Docs theme
     try:
         import sphinx_rtd_theme
+
         html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
 
         # Add any paths that contain custom static files (such as style sheets) here,
         # relative to this directory. They are copied after the builtin static files,
         # so a file named "default.css" will overwrite the builtin "default.css".
         html_css_files = [
-            'theme_overrides.css',
+            "theme_overrides.css",
         ]
 
         # Read the Docs dark mode override theme
-        if html_theme == 'sphinx_rtd_dark_mode':
+        if html_theme == "sphinx_rtd_dark_mode":
             try:
-                import sphinx_rtd_dark_mode
-                extensions.append('sphinx_rtd_dark_mode')
+                import sphinx_rtd_dark_mode            # pylint: disable=W0611
+
+                extensions.append("sphinx_rtd_dark_mode")
             except ImportError:
-                html_theme == 'sphinx_rtd_theme'
+                html_theme = "sphinx_rtd_theme"
 
-        if html_theme == 'sphinx_rtd_theme':
-                # Add color-specific RTD normal mode
-                html_css_files.append('theme_rtd_colors.css')
+        if html_theme == "sphinx_rtd_theme":
+            # Add color-specific RTD normal mode
+            html_css_files.append("theme_rtd_colors.css")
 
         html_theme_options = {
-            'navigation_depth': -1,
+            "navigation_depth": -1,
         }
 
     except ImportError:
-        html_theme = 'alabaster'
+        html_theme = "alabaster"
 
 if "DOCS_CSS" in os.environ:
     css = os.environ["DOCS_CSS"].split(" ")
@@ -359,14 +367,14 @@ if "DOCS_CSS" in os.environ:
     for l in css:
         html_css_files.append(l)
 
-if  html_theme == 'alabaster':
+if html_theme == "alabaster":
     html_theme_options = {
-        'description': get_cline_version(),
-        'page_width': '65em',
-        'sidebar_width': '15em',
-        'fixed_sidebar': 'true',
-        'font_size': 'inherit',
-        'font_family': 'serif',
+        "description": get_cline_version(),
+        "page_width": "65em",
+        "sidebar_width": "15em",
+        "fixed_sidebar": "true",
+        "font_size": "inherit",
+        "font_family": "serif",
     }
 
 sys.stderr.write("Using %s theme\n" % html_theme)
@@ -374,104 +382,79 @@ sys.stderr.write("Using %s theme\n" % html_theme)
 # Add any paths that contain custom static files (such as style sheets) here,
 # relative to this directory. They are copied after the builtin static files,
 # so a file named "default.css" will overwrite the builtin "default.css".
-html_static_path = ['sphinx-static']
+html_static_path = ["sphinx-static"]
 
 # If true, Docutils "smart quotes" will be used to convert quotes and dashes
 # to typographically correct entities.  However, conversion of "--" to "—"
 # is not always what we want, so enable only quotes.
-smartquotes_action = 'q'
+smartquotes_action = "q"
 
 # Custom sidebar templates, maps document names to template names.
 # Note that the RTD theme ignores this
-html_sidebars = { '**': ['searchbox.html', 'kernel-toc.html', 'sourcelink.html']}
+html_sidebars = {"**": ["searchbox.html",
+                        "kernel-toc.html",
+                        "sourcelink.html"]}
 
 # about.html is available for alabaster theme. Add it at the front.
-if html_theme == 'alabaster':
-    html_sidebars['**'].insert(0, 'about.html')
+if html_theme == "alabaster":
+    html_sidebars["**"].insert(0, "about.html")
 
 # The name of an image file (relative to this directory) to place at the top
 # of the sidebar.
-html_logo = 'images/logo.svg'
+html_logo = "images/logo.svg"
 
 # Output file base name for HTML help builder.
-htmlhelp_basename = 'TheLinuxKerneldoc'
+htmlhelp_basename = "TheLinuxKerneldoc"
 
 # -- Options for LaTeX output ---------------------------------------------
 
 latex_elements = {
     # The paper size ('letterpaper' or 'a4paper').
-    'papersize': 'a4paper',
-
+    "papersize": "a4paper",
     # The font size ('10pt', '11pt' or '12pt').
-    'pointsize': '11pt',
-
+    "pointsize": "11pt",
     # Latex figure (float) alignment
-    #'figure_align': 'htbp',
-
+    # 'figure_align': 'htbp',
     # Don't mangle with UTF-8 chars
-    'inputenc': '',
-    'utf8extra': '',
-
+    "inputenc": "",
+    "utf8extra": "",
     # Set document margins
-    'sphinxsetup': '''
+    "sphinxsetup": """
         hmargin=0.5in, vmargin=1in,
         parsedliteralwraps=true,
         verbatimhintsturnover=false,
-    ''',
-
+    """,
     #
     # Some of our authors are fond of deep nesting; tell latex to
     # cope.
     #
-    'maxlistdepth': '10',
-
+    "maxlistdepth": "10",
     # For CJK One-half spacing, need to be in front of hyperref
-    'extrapackages': r'\usepackage{setspace}',
-
+    "extrapackages": r"\usepackage{setspace}",
     # Additional stuff for the LaTeX preamble.
-    'preamble': '''
+    "preamble": """
         % Use some font with UTF-8 support with XeLaTeX
         \\usepackage{fontspec}
         \\setsansfont{DejaVu Sans}
         \\setromanfont{DejaVu Serif}
         \\setmonofont{DejaVu Sans Mono}
-    ''',
+    """,
 }
 
 # Load kerneldoc specific LaTeX settings
-latex_elements['preamble'] += '''
+latex_elements["preamble"] += """
         % Load kerneldoc specific LaTeX settings
-	\\input{kerneldoc-preamble.sty}
-'''
-
-# With Sphinx 1.6, it is possible to change the Bg color directly
-# by using:
-#	\definecolor{sphinxnoteBgColor}{RGB}{204,255,255}
-#	\definecolor{sphinxwarningBgColor}{RGB}{255,204,204}
-#	\definecolor{sphinxattentionBgColor}{RGB}{255,255,204}
-#	\definecolor{sphinximportantBgColor}{RGB}{192,255,204}
-#
-# However, it require to use sphinx heavy box with:
-#
-#	\renewenvironment{sphinxlightbox} {%
-#		\\begin{sphinxheavybox}
-#	}
-#		\\end{sphinxheavybox}
-#	}
-#
-# Unfortunately, the implementation is buggy: if a note is inside a
-# table, it isn't displayed well. So, for now, let's use boring
-# black and white notes.
+        \\input{kerneldoc-preamble.sty}
+"""
 
 # Grouping the document tree into LaTeX files. List of tuples
 # (source start file, target name, title,
 #  author, documentclass [howto, manual, or own class]).
 # Sorted in alphabetical order
-latex_documents = [
-]
+latex_documents = []
 
 # Add all other index files from Documentation/ subdirectories
-for fn in os.listdir('.'):
+for fn in os.listdir("."):
     doc = os.path.join(fn, "index")
     if os.path.exists(doc + ".rst"):
         has = False
@@ -480,34 +463,39 @@ for fn in os.listdir('.'):
                 has = True
                 break
         if not has:
-            latex_documents.append((doc, fn + '.tex',
-                                    'Linux %s Documentation' % fn.capitalize(),
-                                    'The kernel development community',
-                                    'manual'))
+            latex_documents.append(
+                (
+                    doc,
+                    fn + ".tex",
+                    "Linux %s Documentation" % fn.capitalize(),
+                    "The kernel development community",
+                    "manual",
+                )
+            )
 
 # The name of an image file (relative to this directory) to place at the top of
 # the title page.
-#latex_logo = None
+# latex_logo = None
 
 # For "manual" documents, if this is true, then toplevel headings are parts,
 # not chapters.
-#latex_use_parts = False
+# latex_use_parts = False
 
 # If true, show page references after internal links.
-#latex_show_pagerefs = False
+# latex_show_pagerefs = False
 
 # If true, show URL addresses after external links.
-#latex_show_urls = False
+# latex_show_urls = False
 
 # Documents to append as an appendix to all manuals.
-#latex_appendices = []
+# latex_appendices = []
 
 # If false, no module index is generated.
-#latex_domain_indices = True
+# latex_domain_indices = True
 
 # Additional LaTeX stuff to be copied to build directory
 latex_additional_files = [
-    'sphinx/kerneldoc-preamble.sty',
+    "sphinx/kerneldoc-preamble.sty",
 ]
 
 
@@ -516,12 +504,11 @@ latex_additional_files = [
 # One entry per manual page. List of tuples
 # (source start file, name, description, authors, manual section).
 man_pages = [
-    (master_doc, 'thelinuxkernel', 'The Linux Kernel Documentation',
-     [author], 1)
+    (master_doc, "thelinuxkernel", "The Linux Kernel Documentation", [author], 1)
 ]
 
 # If true, show URL addresses after external links.
-#man_show_urls = False
+# man_show_urls = False
 
 
 # -- Options for Texinfo output -------------------------------------------
@@ -529,11 +516,15 @@ man_pages = [
 # Grouping the document tree into Texinfo files. List of tuples
 # (source start file, target name, title, author,
 #  dir menu entry, description, category)
-texinfo_documents = [
-    (master_doc, 'TheLinuxKernel', 'The Linux Kernel Documentation',
-     author, 'TheLinuxKernel', 'One line description of project.',
-     'Miscellaneous'),
-]
+texinfo_documents = [(
+        master_doc,
+        "TheLinuxKernel",
+        "The Linux Kernel Documentation",
+        author,
+        "TheLinuxKernel",
+        "One line description of project.",
+        "Miscellaneous",
+    ),]
 
 # -- Options for Epub output ----------------------------------------------
 
@@ -544,9 +535,9 @@ epub_publisher = author
 epub_copyright = copyright
 
 # A list of files that should not be packed into the epub file.
-epub_exclude_files = ['search.html']
+epub_exclude_files = ["search.html"]
 
-#=======
+# =======
 # rst2pdf
 #
 # Grouping the document tree into PDF files. List of tuples
@@ -558,14 +549,14 @@ epub_exclude_files = ['search.html']
 # multiple PDF files here actually tries to get the cross-referencing right
 # *between* PDF files.
 pdf_documents = [
-    ('kernel-documentation', u'Kernel', u'Kernel', u'J. Random Bozo'),
+    ("kernel-documentation", "Kernel", "Kernel", "J. Random Bozo"),
 ]
 
 # kernel-doc extension configuration for running Sphinx directly (e.g. by Read
 # the Docs). In a normal build, these are supplied from the Makefile via command
 # line arguments.
-kerneldoc_bin = '../scripts/kernel-doc.py'
-kerneldoc_srctree = '..'
+kerneldoc_bin = "../scripts/kernel-doc.py"
+kerneldoc_srctree = ".."
 
 # ------------------------------------------------------------------------------
 # Since loadConfig overwrites settings from the global namespace, it has to be
@@ -573,5 +564,8 @@ kerneldoc_srctree = '..'
 # ------------------------------------------------------------------------------
 loadConfig(globals())
 
+
 def setup(app):
-	app.connect('builder-inited', update_patterns)
+    """Patterns need to be updated at init time on older Sphinx versions"""
+
+    app.connect("builder-inited", update_patterns)
-- 
2.49.0


