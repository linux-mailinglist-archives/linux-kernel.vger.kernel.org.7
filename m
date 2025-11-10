Return-Path: <linux-kernel+bounces-894209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F49C497A8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 806934EA706
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0BB2FFFB2;
	Mon, 10 Nov 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Y/lO37/i"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8CF273D81;
	Mon, 10 Nov 2025 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762812288; cv=none; b=l33KwvRiBXSzonoL+AJQsLBig8De0dJ26xZv05Da++g3QVVabAUTCvkNzdXGuZ1RvYR0mswLaTENgRwkIvh6XEpNrcyWarwv9BEr/36xpCDijn9bAO5JvNvQvQg4KH7RtiWuM3XHPEFWbZLXaOYqXhNWzzxOp6XpUHtayjluCzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762812288; c=relaxed/simple;
	bh=wi4eKj4SgGVKPEhjzHr8OhGZJBn2VGgibZO8T+gqAj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ugMc3BonP7pGL+v8tH6bkBLfzAa2baJgwpNcUAYQOs3GackaNdJtBbsbVYx7I32YVYifSwrVwlcGcoyEPAjmgSQOar0EDSQz2F2WrYRRB3twXur9ydgTGbT6upTbJ2ed5TS/qiH7/t0isFOPrXQbObRBXA62Nd7KcaP37Snn8D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Y/lO37/i; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A908840C3A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762812286; bh=ETTEAfV8AinSBTl/zGJPRd88A1tGp5WgYF+bJ+LN7vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y/lO37/i5KiE23pXSDahGzCkVLRZFdBgVaDuEH2mvKljubtnmDwEbUXXhuBWMo68T
	 RTw5uze/aeeJ3YAk17kQkpXkstqvJ0CDQsd0PrMEq7TNVrLHOS4Q4ZJEbLrfy89ZC7
	 fKqjPnkN73cT/3srrkTVLspMtJIs2KaN/q+zTlJeFkBUtSLwd+Lp6ZLZsEYbfjqNNM
	 /UCsxTNhyChKVr6hZ0W3gfxoZT9ojCQSC3JB2zE7/qCG70WmiwEAoZ+EYgq88lrKnr
	 5L2MEwKSIKjZJ+ZbeVP4+yHGT85c4ZFjHwUHwKlHO1qFXiNz6VYB8X5EvUYKvsvROb
	 IhUpHlFbsGGhQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id A908840C3A;
	Mon, 10 Nov 2025 22:04:45 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/2] docs: bring some order to our Python module hierarchy
Date: Mon, 10 Nov 2025 15:04:30 -0700
Message-ID: <20251110220430.726665-3-corbet@lwn.net>
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

Now that we have tools/lib/python for our Python modules, turn them into
proper packages with a single namespace so that everything can just use
tools/lib/python in sys.path.  No functional change.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/sphinx/kernel_abi.py     |  4 ++--
 Documentation/sphinx/kernel_include.py |  4 ++--
 Documentation/sphinx/kerneldoc.py      |  6 +++---
 scripts/kernel-doc.py                  |  6 +++---
 tools/docs/check-variable-fonts.py     |  4 ++--
 tools/docs/get_abi.py                  | 10 +++++-----
 tools/docs/parse-headers.py            |  6 +++---
 tools/docs/sphinx-build-wrapper        |  5 ++---
 tools/docs/sphinx-pre-install          |  4 ++--
 tools/lib/python/__init__.py           |  0
 tools/lib/python/abi/__init__.py       |  0
 tools/lib/python/abi/abi_parser.py     |  2 +-
 tools/lib/python/abi/abi_regex.py      |  4 ++--
 tools/lib/python/abi/system_symbols.py |  2 +-
 tools/lib/python/kdoc/__init__.py      |  0
 tools/lib/python/kdoc/kdoc_files.py    |  4 ++--
 tools/lib/python/kdoc/kdoc_output.py   |  4 ++--
 tools/lib/python/kdoc/kdoc_parser.py   |  4 ++--
 18 files changed, 34 insertions(+), 35 deletions(-)
 create mode 100644 tools/lib/python/__init__.py
 create mode 100644 tools/lib/python/abi/__init__.py
 create mode 100644 tools/lib/python/kdoc/__init__.py

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index 7ec832da8444..5667f207d175 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -43,9 +43,9 @@ from sphinx.util.docutils import switch_source_input
 from sphinx.util import logging
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/lib/python/abi"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python"))
 
-from abi_parser import AbiParser
+from abi.abi_parser import AbiParser
 
 __version__ = "1.0"
 
diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index a12455daa6d7..626762ff6af3 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -97,9 +97,9 @@ from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from sphinx.util import logging
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/lib/python/kdoc"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python"))
 
-from parse_data_structs import ParseDataStructs
+from kdoc.parse_data_structs import ParseDataStructs
 
 __version__ = "1.0"
 logger = logging.getLogger(__name__)
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 56f382a6bdf1..d8cdf068ef35 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -42,10 +42,10 @@ from sphinx.util import logging
 from pprint import pformat
 
 srctree = os.path.abspath(os.environ["srctree"])
-sys.path.insert(0, os.path.join(srctree, "tools/lib/python/kdoc"))
+sys.path.insert(0, os.path.join(srctree, "tools/lib/python"))
 
-from kdoc_files import KernelFiles
-from kdoc_output import RestFormat
+from kdoc.kdoc_files import KernelFiles
+from kdoc.kdoc_output import RestFormat
 
 __version__  = '1.0'
 kfiles = None
diff --git a/scripts/kernel-doc.py b/scripts/kernel-doc.py
index bb24bbf73167..7a1eaf986bcd 100755
--- a/scripts/kernel-doc.py
+++ b/scripts/kernel-doc.py
@@ -111,7 +111,7 @@ import sys
 
 # Import Python modules
 
-LIB_DIR = "../tools/lib/python/kdoc"
+LIB_DIR = "../tools/lib/python"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
@@ -292,8 +292,8 @@ def main():
         logger.warning("Python 3.7 or later is required for correct results")
 
     # Import kernel-doc libraries only after checking Python version
-    from kdoc_files import KernelFiles                  # pylint: disable=C0415
-    from kdoc_output import RestFormat, ManFormat       # pylint: disable=C0415
+    from kdoc.kdoc_files import KernelFiles             # pylint: disable=C0415
+    from kdoc.kdoc_output import RestFormat, ManFormat  # pylint: disable=C0415
 
     if args.man:
         out_style = ManFormat(modulename=args.modulename)
diff --git a/tools/docs/check-variable-fonts.py b/tools/docs/check-variable-fonts.py
index c48bb05dad82..958d5a745724 100755
--- a/tools/docs/check-variable-fonts.py
+++ b/tools/docs/check-variable-fonts.py
@@ -17,9 +17,9 @@ import sys
 import os.path
 
 src_dir = os.path.dirname(os.path.realpath(__file__))
-sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
+sys.path.insert(0, os.path.join(src_dir, '../lib/python'))
 
-from latex_fonts import LatexFontChecker
+from kdoc.latex_fonts import LatexFontChecker
 
 checker = LatexFontChecker()
 
diff --git a/tools/docs/get_abi.py b/tools/docs/get_abi.py
index e0abfe12fac7..2f0b99401f26 100755
--- a/tools/docs/get_abi.py
+++ b/tools/docs/get_abi.py
@@ -14,15 +14,15 @@ import sys
 
 # Import Python modules
 
-LIB_DIR = "../lib/python/abi"
+LIB_DIR = "../lib/python"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 
-from abi_parser import AbiParser                # pylint: disable=C0413
-from abi_regex import AbiRegex                  # pylint: disable=C0413
-from helpers import ABI_DIR, DEBUG_HELP         # pylint: disable=C0413
-from system_symbols import SystemSymbols        # pylint: disable=C0413
+from abi.abi_parser import AbiParser                # pylint: disable=C0413
+from abi.abi_regex import AbiRegex                  # pylint: disable=C0413
+from abi.helpers import ABI_DIR, DEBUG_HELP         # pylint: disable=C0413
+from abi.system_symbols import SystemSymbols        # pylint: disable=C0413
 
 # Command line classes
 
diff --git a/tools/docs/parse-headers.py b/tools/docs/parse-headers.py
index ed9cf2bf22de..436acea4c6ca 100755
--- a/tools/docs/parse-headers.py
+++ b/tools/docs/parse-headers.py
@@ -28,9 +28,9 @@ import argparse, sys
 import os.path
 
 src_dir = os.path.dirname(os.path.realpath(__file__))
-sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
-from parse_data_structs import ParseDataStructs
-from enrich_formatter import EnrichFormatter
+sys.path.insert(0, os.path.join(src_dir, '../lib/python'))
+from kdoc.parse_data_structs import ParseDataStructs
+from kdoc.enrich_formatter import EnrichFormatter
 
 def main():
     """Main function"""
diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index ce0b1b5292da..d4943d952e2a 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -61,10 +61,9 @@ LIB_DIR = "../lib/python"
 SRC_DIR = os.path.dirname(os.path.realpath(__file__))
 
 sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
-sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR + '/kdoc'))  # temporary
 
-from python_version import PythonVersion
-from latex_fonts import LatexFontChecker
+from kdoc.python_version import PythonVersion
+from kdoc.latex_fonts import LatexFontChecker
 from jobserver import JobserverExec         # pylint: disable=C0413,C0411,E0401
 
 #
diff --git a/tools/docs/sphinx-pre-install b/tools/docs/sphinx-pre-install
index d8c9fb76948d..965c9b093a41 100755
--- a/tools/docs/sphinx-pre-install
+++ b/tools/docs/sphinx-pre-install
@@ -35,8 +35,8 @@ from glob import glob
 import os.path
 
 src_dir = os.path.dirname(os.path.realpath(__file__))
-sys.path.insert(0, os.path.join(src_dir, '../lib/python/kdoc'))
-from python_version import PythonVersion
+sys.path.insert(0, os.path.join(src_dir, '../lib/python'))
+from kdoc.python_version import PythonVersion
 
 RECOMMENDED_VERSION = PythonVersion("3.4.3").version
 MIN_PYTHON_VERSION = PythonVersion("3.7").version
diff --git a/tools/lib/python/__init__.py b/tools/lib/python/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/lib/python/abi/__init__.py b/tools/lib/python/abi/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/lib/python/abi/abi_parser.py b/tools/lib/python/abi/abi_parser.py
index 66a738013ce1..9b8db70067ef 100644
--- a/tools/lib/python/abi/abi_parser.py
+++ b/tools/lib/python/abi/abi_parser.py
@@ -17,7 +17,7 @@ from random import randrange, seed
 
 # Import Python modules
 
-from helpers import AbiDebug, ABI_DIR
+from abi.helpers import AbiDebug, ABI_DIR
 
 
 class AbiParser:
diff --git a/tools/lib/python/abi/abi_regex.py b/tools/lib/python/abi/abi_regex.py
index 8a57846cbc69..d5553206de3c 100644
--- a/tools/lib/python/abi/abi_regex.py
+++ b/tools/lib/python/abi/abi_regex.py
@@ -12,8 +12,8 @@ import sys
 
 from pprint import pformat
 
-from abi_parser import AbiParser
-from helpers import AbiDebug
+from abi.abi_parser import AbiParser
+from abi.helpers import AbiDebug
 
 class AbiRegex(AbiParser):
     """Extends AbiParser to search ABI nodes with regular expressions"""
diff --git a/tools/lib/python/abi/system_symbols.py b/tools/lib/python/abi/system_symbols.py
index f15c94a6e33c..4a2554da217b 100644
--- a/tools/lib/python/abi/system_symbols.py
+++ b/tools/lib/python/abi/system_symbols.py
@@ -15,7 +15,7 @@ from concurrent import futures
 from datetime import datetime
 from random import shuffle
 
-from helpers import AbiDebug
+from abi.helpers import AbiDebug
 
 class SystemSymbols:
     """Stores arguments for the class and initialize class vars"""
diff --git a/tools/lib/python/kdoc/__init__.py b/tools/lib/python/kdoc/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index 061c033f32da..8170ab22e598 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -13,8 +13,8 @@ import logging
 import os
 import re
 
-from kdoc_parser import KernelDoc
-from kdoc_output import OutputFormat
+from kdoc.kdoc_parser import KernelDoc
+from kdoc.kdoc_output import OutputFormat
 
 
 class GlobSourceFiles:
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 58f115059e93..14378953301b 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -19,8 +19,8 @@ import os
 import re
 from datetime import datetime
 
-from kdoc_parser import KernelDoc, type_param
-from kdoc_re import KernRe
+from kdoc.kdoc_parser import KernelDoc, type_param
+from kdoc.kdoc_re import KernRe
 
 
 function_pointer = KernRe(r"([^\(]*\(\*)\s*\)\s*\(([^\)]*)\)", cache=False)
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index f7dbb0868367..c0cc714d4d6f 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -16,8 +16,8 @@ import sys
 import re
 from pprint import pformat
 
-from kdoc_re import NestedMatch, KernRe
-from kdoc_item import KdocItem
+from kdoc.kdoc_re import NestedMatch, KernRe
+from kdoc.kdoc_item import KdocItem
 
 #
 # Regular expressions used to parse kernel-doc markups at KernelDoc class.
-- 
2.51.0


