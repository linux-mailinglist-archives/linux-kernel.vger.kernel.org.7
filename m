Return-Path: <linux-kernel+bounces-822667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54567B846FC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07E17460414
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB785305076;
	Thu, 18 Sep 2025 11:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxHhn/GM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2129E221F29;
	Thu, 18 Sep 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758196506; cv=none; b=PhD8AOCHW8MjDEebM9Jz9Sph+wwsZ5rXilDP9CExAZXnvs4lwh/+v7FRyIq3tODTT1RZrvvLp3h8D7WtiG0njTbkw0Wpgq4hCZCCPo1OP11gSHAqOAN/jVKMY+VzKOHMOFkunPPF7a13GFGlfBxydtFTjVAGIM+PgwZoKYgsaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758196506; c=relaxed/simple;
	bh=fJpsAtJ92MxZvD5oc+zobQhN2JKwDEF9zPLyP1fCyLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b9nY3aIQyG4cPDMExpsS+DGZ/Im6gKanU3o62HOJrnwqLgqCESq7gTfITcR7Er5MKSLhs4LXgLjaVNtTmMNcsK8Yawc3r3zBTqLQJanyOCM7b06XGtEftNCcgG3kFmPUQcK1YkJEQLsaba9dMaw2Q+VSkc7I1UM/HKFKzJ1k1xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxHhn/GM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B832EC4AF09;
	Thu, 18 Sep 2025 11:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758196505;
	bh=fJpsAtJ92MxZvD5oc+zobQhN2JKwDEF9zPLyP1fCyLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MxHhn/GMdKawhvKBilWREK7SzxI9E/gmHlQ5j0punTXANvW5i2dAMFgVSlCwKEDI4
	 D3OpMA1rrVqwG+w5+98l7VYi/PBOTjH2vunSMsNrMaK2UfVVLOV/yyhO+ViQm7Gjhq
	 E2LA8RYfkojG07Dhw/+Rnof/7yraKMyWfep0ir5VyDh+X/WdtixRwZgyE5pN1Jf+SV
	 FRlheAdgCymEAwPmf6YvgG0+HNMekeoiv1plvCNESVTf3dVd7Ib2qtpsf4qSi148SF
	 mrnDjW15k+DV+wAMJibKb9gTTweanZucv6X1S8pBMEDkma1M/al8kn8waLgKp0V5bI
	 tMOG8QDRzhXDA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzDE7-0000000Crlw-3QCk;
	Thu, 18 Sep 2025 13:55:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 04/24] scripts: check-variable-fonts.sh: convert to Python
Date: Thu, 18 Sep 2025 13:54:38 +0200
Message-ID: <d438fb01d2c00e2c2b4ac16f999d9a8ce848251b.1758196090.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758196090.git.mchehab+huawei@kernel.org>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This script handle errors when trying to build translations
with make pdfdocs.

As part of our cleanup work to remove hacks from docs Makefile,
convert this to python, preparing it to be part of a library
to be called by sphinx-build-wrapper.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile                        |   2 +-
 MAINTAINERS                                   |   2 +-
 ...iable-fonts.sh => check-variable-fonts.py} | 104 +++++++++++++-----
 3 files changed, 79 insertions(+), 29 deletions(-)
 rename scripts/{check-variable-fonts.sh => check-variable-fonts.py} (61%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 5c20c68be89a..d5e436435eab 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -146,7 +146,7 @@ pdfdocs: DENY_VF = XDG_CONFIG_HOME=$(FONTS_CONF_DENY_VF)
 pdfdocs: latexdocs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
 	$(foreach var,$(SPHINXDIRS), \
-	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || sh $(srctree)/scripts/check-variable-fonts.sh || exit; \
+	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" $(DENY_VF) -C $(BUILDDIR)/$(var)/latex || $(PYTHON3) $(srctree)/scripts/check-variable-fonts.py || exit; \
 	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
 	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
 	)
diff --git a/MAINTAINERS b/MAINTAINERS
index ef87548b8f88..88d8f7435e6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7301,7 +7301,7 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/check-variable-fonts.sh
+F:	scripts/check-variable-fonts.py
 F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
diff --git a/scripts/check-variable-fonts.sh b/scripts/check-variable-fonts.py
similarity index 61%
rename from scripts/check-variable-fonts.sh
rename to scripts/check-variable-fonts.py
index ce63f0acea5f..8be1c0f39588 100755
--- a/scripts/check-variable-fonts.sh
+++ b/scripts/check-variable-fonts.py
@@ -1,7 +1,9 @@
-#!/bin/sh
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0-only
 # Copyright (C) Akira Yokosawa, 2024
 #
+# Ported to Python by (c) Mauro Carvalho Chehab, 2025
+#
 # For "make pdfdocs", reports of build errors of translations.pdf started
 # arriving early 2024 [1, 2].  It turned out that Fedora and openSUSE
 # tumbleweed have started deploying variable-font [3] format of "Noto CJK"
@@ -87,29 +89,77 @@
 #     Denylisting should be less invasive, as it is effective only while
 #     XeLaTeX runs in "make pdfdocs".
 
-# Default per-user fontconfig path (overridden by env variable)
-: ${FONTS_CONF_DENY_VF:=$HOME/deny-vf}
-
-export XDG_CONFIG_HOME=${FONTS_CONF_DENY_VF}
-
-notocjkvffonts=`fc-list : file family variable | \
-		grep 'variable=True' | \
-		grep -E -e 'Noto (Sans|Sans Mono|Serif) CJK' | \
-		sed -e 's/^/    /' -e 's/: Noto S.*$//' | sort | uniq`
-
-if [ "x$notocjkvffonts" != "x" ] ; then
-	echo '============================================================================='
-	echo 'XeTeX is confused by "variable font" files listed below:'
-	echo "$notocjkvffonts"
-	echo
-	echo 'For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.'
-	echo 'Or, CJK pages can be skipped by uninstalling texlive-xecjk.'
-	echo
-	echo 'For more info on denylisting, other options, and variable font, see header'
-	echo 'comments of scripts/check-variable-fonts.sh.'
-	echo '============================================================================='
-fi
-
-# As this script is invoked from Makefile's error path, always error exit
-# regardless of whether any variable font is discovered or not.
-exit 1
+import os
+import re
+import subprocess
+import sys
+import textwrap
+
+class LatexFontChecker:
+    """
+    Detect problems with CJK variable fonts that affect PDF builds for
+    translations.
+    """
+
+    def __init__(self):
+        deny_vf = os.environ.get('FONTS_CONF_DENY_VF', "~/deny-vf")
+
+        self.environ = os.environ.copy()
+        self.environ['XDG_CONFIG_HOME'] = os.path.expanduser(deny_vf)
+
+        self.re_cjk = re.compile(r"([^:]+):\s*Noto\s+(Sans|Sans Mono|Serif) CJK")
+
+    def get_noto_cjk_vf_fonts(self):
+        """Get Noto CJK fonts"""
+
+        cjk_fonts = set()
+        cmd = ["fc-list", ":", "file", "family", "variable"]
+        try:
+            result = subprocess.run(cmd,stdout=subprocess.PIPE,
+                                    stderr=subprocess.PIPE,
+                                    universal_newlines=True,
+                                    env=self.environ,
+                                    check=True)
+
+        except subprocess.CalledProcessError as exc:
+            sys.exit(f"Error running fc-list: {repr(exc)}")
+
+        for line in result.stdout.splitlines():
+            if 'variable=True' not in line:
+                continue
+
+            match = self.re_cjk.search(line)
+            if match:
+                cjk_fonts.add(match.group(1))
+
+        return sorted(cjk_fonts)
+
+    def check(self):
+        """Check for problems with CJK fonts"""
+
+        fonts = textwrap.indent("\n".join(self.get_noto_cjk_vf_fonts()), "    ")
+        if not fonts:
+            return None
+
+        rel_file = os.path.relpath(__file__, os.getcwd())
+
+        msg = "=" * 77 + "\n"
+        msg += 'XeTeX is confused by "variable font" files listed below:\n'
+        msg += fonts + "\n"
+        msg += textwrap.dedent(f"""
+                For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
+                Or, CJK pages can be skipped by uninstalling texlive-xecjk.
+
+                For more info on denylisting, other options, and variable font, see header
+                comments of {rel_file}.
+            """)
+        msg += "=" * 77
+
+        return msg
+
+if __name__ == "__main__":
+    msg = LatexFontChecker().check()
+    if msg:
+        print(msg)
+
+    sys.exit(1)
-- 
2.51.0


