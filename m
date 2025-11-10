Return-Path: <linux-kernel+bounces-894208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD2C497A5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 93B6034BC13
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53612FF662;
	Mon, 10 Nov 2025 22:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="LYBwJ6GX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E622D6605;
	Mon, 10 Nov 2025 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812287; cv=none; b=oi/eJjYG0RRoTv3FT3hhuPHMXBqpzezQgJ7C2mfToJBPWav3v1C9o875Vm55WTbbtSohTjv35JWYkeBECKrHlKTsQcUAWIVZ3OJJw9S7He5ven1Y1a+3ER5IAH3VjDeMcSI8elBJyN7GhoaidV/J9LeAPnKpu2zg03eYaLZCIUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812287; c=relaxed/simple;
	bh=Lbx9JmEmR09cc/ilz7Gv/CqdmqJZ8/Y8xhwqhQl2yys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U21g4tdn3UHXmsNjnNO+xJezIki6WWLAe1j78feKvq8lcinLdh47vULVLFGjk4Uyok+Xc+SskpMo3FfQT3SjZaPG22qu/tCmh9UevMTGTnNxSTakBE+PODvwnq6WilOAJvKZuHELzFAaMG8QAwEMEIeDG3zCer7t5CREnZwO+fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=LYBwJ6GX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1858D40C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762812285; bh=MfTr2z0mo+rHbQuRrzQyznwn2KXS04ZCfpHQ2Wn6Ykc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYBwJ6GXJcyHdYheVjuclFc7WnxyuUhbHre0CDm7yRy80x251vtVBPDIhjJpo9D1K
	 yBwGBCbZHN9DIAX+gUHSYT5qM0LQB1Z9tNiQOjnwNGb34gumlJNozLeAu4eq/RdP82
	 2CEKWRR3G3JcIY8KIUY2tVUr5r4DEcGjcNxEiHD/3MqOToZtubY4e0BH7E1obtgKhN
	 71deAzvEUupGt6BCV/SahogjJcpUl2A8mzxnRm8qMP6xXn5M+g/haFfA/2KwSwG0N0
	 Qw0ggwgVFQUCRXzTpc9Z4svrnKUAoHPu/ExYPRo4NaR6lj+cF7SH22oOgwuo/Wsgi/
	 XCc6Om0rhlJeQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 1858D40C39;
	Mon, 10 Nov 2025 22:04:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/2] docs: Move the python libraries to tools/lib/python
Date: Mon, 10 Nov 2025 15:04:29 -0700
Message-ID: <20251110220430.726665-2-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251110220430.726665-1-corbet@lwn.net>
References: <20251110220430.726665-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"scripts/lib" was always a bit of an awkward place for Python modules.  We
already have tools/lib; create a tools/lib/python, move the libraries
there, and update the users accordingly.

While at it, move the contents of tools/docs/lib.  Rather than make another
directory, just put these documentation-oriented modules under "kdoc".

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 .pylintrc                                                | 2 +-
 Documentation/Makefile                                   | 2 +-
 Documentation/sphinx/kernel_abi.py                       | 2 +-
 Documentation/sphinx/kernel_include.py                   | 2 +-
 Documentation/sphinx/kerneldoc.py                        | 2 +-
 MAINTAINERS                                              | 3 +--
 scripts/jobserver-exec                                   | 2 +-
 scripts/kernel-doc.py                                    | 2 +-
 tools/docs/check-variable-fonts.py                       | 8 ++++++--
 tools/docs/get_abi.py                                    | 2 +-
 tools/docs/lib/__init__.py                               | 0
 tools/docs/parse-headers.py                              | 9 ++++++---
 tools/docs/sphinx-build-wrapper                          | 7 ++++---
 tools/docs/sphinx-pre-install                            | 5 ++++-
 {scripts/lib => tools/lib/python}/abi/abi_parser.py      | 0
 {scripts/lib => tools/lib/python}/abi/abi_regex.py       | 0
 {scripts/lib => tools/lib/python}/abi/helpers.py         | 0
 {scripts/lib => tools/lib/python}/abi/system_symbols.py  | 0
 {scripts/lib => tools/lib/python}/jobserver.py           | 0
 tools/{docs/lib => lib/python/kdoc}/enrich_formatter.py  | 0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_files.py     | 0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_item.py      | 0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_output.py    | 0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_parser.py    | 0
 {scripts/lib => tools/lib/python}/kdoc/kdoc_re.py        | 0
 tools/{docs/lib => lib/python/kdoc}/latex_fonts.py       | 0
 .../{docs/lib => lib/python/kdoc}/parse_data_structs.py  | 0
 tools/{docs/lib => lib/python/kdoc}/python_version.py    | 0
 28 files changed, 29 insertions(+), 19 deletions(-)
 delete mode 100644 tools/docs/lib/__init__.py
 rename {scripts/lib => tools/lib/python}/abi/abi_parser.py (100%)
 rename {scripts/lib => tools/lib/python}/abi/abi_regex.py (100%)
 rename {scripts/lib => tools/lib/python}/abi/helpers.py (100%)
 rename {scripts/lib => tools/lib/python}/abi/system_symbols.py (100%)
 rename {scripts/lib => tools/lib/python}/jobserver.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/enrich_formatter.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_files.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_item.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_output.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_parser.py (100%)
 rename {scripts/lib => tools/lib/python}/kdoc/kdoc_re.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/latex_fonts.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/parse_data_structs.py (100%)
 rename tools/{docs/lib => lib/python/kdoc}/python_version.py (100%)

diff --git a/.pylintrc b/.pylintrc
index 89eaf2100edd..8c6fc2b628b3 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -1,2 +1,2 @@
 [MASTER]
-init-hook='import sys; sys.path += ["scripts/lib/kdoc", "scripts/lib/abi", "tools/docs/lib"]'
+init-hook='import sys; sys.path += ["tools/lib/python"]'
diff --git a/Documentation/Makefile b/Documentation/Makefile
index d514ab6761dc..69aee1cb1f74 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -113,6 +113,6 @@ dochelp:
 	@echo  '  make PAPER={a4|letter} Specifies the paper size used for LaTeX/PDF output.'
 	@echo
 	@echo  '  make FONTS_CONF_DENY_VF={path} sets a deny list to block variable Noto CJK fonts'
-	@echo  '  for PDF build. See tools/docs/lib/latex_fonts.py for more details'
+	@echo  '  for PDF build. See tools/lib/python/kdoc/latex_fonts.py for more details'
 	@echo
 	@echo  '  Default location for the generated documents is Documentation/output'
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 32e39fb8bc3b..7ec832da8444 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -43,7 +43,7 @@ from sphinx.util.docutils import switch_source_input
 from sphinx.util import logging
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "scripts/lib/abi"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python/abi"))
 
 from abi_parser import AbiParser
 
diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 75e139287d50..a12455daa6d7 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -97,7 +97,7 @@ from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from sphinx.util import logging
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/docs/lib"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python/kdoc"))
 
 from parse_data_structs import ParseDataStructs
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 2586b4d4e494..56f382a6bdf1 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -42,7 +42,7 @@ from sphinx.util import logging
 from pprint import pformat
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "scripts/lib/kdoc"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python/kdoc"))
 
 from kdoc_files import KernelFiles
 from kdoc_output import RestFormat
diff --git a/MAINTAINERS b/MAINTAINERS
index 8a9411e5c1e1..efe98e680c14 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7412,8 +7412,7 @@ P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
 F:	scripts/kernel-doc*
-F:	scripts/lib/abi/*
-F:	scripts/lib/kdoc/*
+F:	tools/lib/python/*
 F:	tools/docs/
 F:	tools/net/ynl/pyynl/lib/doc_generator.py
 X:	Documentation/ABI/
diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index ae23afd344ec..758e947a6fb9 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -13,7 +13,7 @@ See:
 import os
 import sys
 
-LIB_DIR = "lib"
+LIB_DIR = "../tools/lib/python"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index d9fe2bcbd39c..bb24bbf73167 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -111,7 +111,7 @@ import sys
 
 # Import Python modules
 
-LIB_DIR = "lib/kdoc"
+LIB_DIR = "../tools/lib/python/kdoc"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
diff --git a/tools/docs/check-variable-fonts.py b/tools/docs/check-variable-fonts.py
index c0997d6861dc..c48bb05dad82 100755
--- a/tools/docs/check-variable-fonts.py
+++ b/tools/docs/check-variable-fonts.py
@@ -9,13 +9,17 @@
 """
 Detect problematic Noto CJK variable fonts.
 
-or more details, see lib/latex_fonts.py.
+or more details, see .../tools/lib/python/kdoc/latex_fonts.py.
 """
 
 import argparse
 import sys
+import os.path
 
-from lib.latex_fonts import LatexFontChecker
+src_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
+
+from latex_fonts import LatexFontChecker
 
 checker = LatexFontChecker()
 
diff --git a/tools/docs/get_abi.py b/tools/docs/get_abi.py
index da69e77559cc..e0abfe12fac7 100755
--- a/tools/docs/get_abi.py
+++ b/tools/docs/get_abi.py
@@ -14,7 +14,7 @@ import sys
 
 # Import Python modules
 
-LIB_DIR = "../../scripts/lib/abi"
+LIB_DIR = "../lib/python/abi"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
diff --git a/tools/docs/lib/__init__.py b/tools/docs/lib/__init__.py
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/tools/docs/parse-headers.py b/tools/docs/parse-headers.py
index 6716c7300258..ed9cf2bf22de 100755
--- a/tools/docs/parse-headers.py
+++ b/tools/docs/parse-headers.py
@@ -24,10 +24,13 @@ The optional ``FILE_RULES`` contains a set of rules like:
     replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
 """
 
-import argparse
+import argparse, sys
+import os.path
 
-from lib.parse_data_structs import ParseDataStructs
-from lib.enrich_formatter import EnrichFormatter
+src_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
+from parse_data_structs import ParseDataStructs
+from enrich_formatter import EnrichFormatter
 
 def main():
     """Main function"""
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index 1efaca3d16aa..ce0b1b5292da 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -56,14 +56,15 @@ import sys
 from concurrent import futures
 from glob import glob
 
-from lib.python_version import PythonVersion
-from lib.latex_fonts import LatexFontChecker
 
-LIB_DIR = "../../scripts/lib"
+LIB_DIR = "../lib/python"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
+sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR + '/kdoc'))  # temporary
 
+from python_version import PythonVersion
+from latex_fonts import LatexFontChecker
 from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 
 #
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index 647e1f60357f..d8c9fb76948d 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -32,8 +32,11 @@ import re
 import subprocess
 import sys
 from glob import glob
+import os.path
 
-from lib.python_version import PythonVersion
+src_dir = os.path.dirname(os.path.realpath(__file__))
+sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
+from python_version import PythonVersion
 
 RECOMMENDED_VERSION = PythonVersion("3.4.3").version
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
diff --git a/scripts/lib/abi/abi_parser.py b/tools/lib/python/abi/abi_parser.py
similarity index 100%
rename from scripts/lib/abi/abi_parser.py
rename to tools/lib/python/abi/abi_parser.py
diff --git a/scripts/lib/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
similarity index 100%
rename from scripts/lib/abi/abi_regex.py
rename to tools/lib/python/abi/abi_regex.py
diff --git a/scripts/lib/abi/helpers.py b/tools/lib/python/abi/helpers.py
similarity index 100%
rename from scripts/lib/abi/helpers.py
rename to tools/lib/python/abi/helpers.py
diff --git a/scripts/lib/abi/system_symbols.py b/tools/lib/python/abi/system_symbols.py
similarity index 100%
rename from scripts/lib/abi/system_symbols.py
rename to tools/lib/python/abi/system_symbols.py
diff --git a/scripts/lib/jobserver.py b/tools/lib/python/jobserver.py
similarity index 100%
rename from scripts/lib/jobserver.py
rename to tools/lib/python/jobserver.py
diff --git a/tools/docs/lib/enrich_formatter.py b/tools/lib/python/kdoc/enrich_formatter.py
similarity index 100%
rename from tools/docs/lib/enrich_formatter.py
rename to tools/lib/python/kdoc/enrich_formatter.py
diff --git a/scripts/lib/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
similarity index 100%
rename from scripts/lib/kdoc/kdoc_files.py
rename to tools/lib/python/kdoc/kdoc_files.py
diff --git a/scripts/lib/kdoc/kdoc_item.py b/tools/lib/python/kdoc/kdoc_item.py
similarity index 100%
rename from scripts/lib/kdoc/kdoc_item.py
rename to tools/lib/python/kdoc/kdoc_item.py
diff --git a/scripts/lib/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
similarity index 100%
rename from scripts/lib/kdoc/kdoc_output.py
rename to tools/lib/python/kdoc/kdoc_output.py
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
similarity index 100%
rename from scripts/lib/kdoc/kdoc_parser.py
rename to tools/lib/python/kdoc/kdoc_parser.py
diff --git a/scripts/lib/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
similarity index 100%
rename from scripts/lib/kdoc/kdoc_re.py
rename to tools/lib/python/kdoc/kdoc_re.py
diff --git a/tools/docs/lib/latex_fonts.py b/tools/lib/python/kdoc/latex_fonts.py
similarity index 100%
rename from tools/docs/lib/latex_fonts.py
rename to tools/lib/python/kdoc/latex_fonts.py
diff --git a/tools/docs/lib/parse_data_structs.py b/tools/lib/python/kdoc/parse_data_structs.py
similarity index 100%
rename from tools/docs/lib/parse_data_structs.py
rename to tools/lib/python/kdoc/parse_data_structs.py
diff --git a/tools/docs/lib/python_version.py b/tools/lib/python/kdoc/python_version.py
similarity index 100%
rename from tools/docs/lib/python_version.py
rename to tools/lib/python/kdoc/python_version.py
-- 
2.51.0


