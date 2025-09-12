Return-Path: <linux-kernel+bounces-814255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BE9B5518A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFC53AA565
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBB2320A2D;
	Fri, 12 Sep 2025 14:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1i6e29N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D27531A554;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687250; cv=none; b=SaAXn13+mG2ArjaDdv/99fR24iWgy5FII+aiRMP8ytngwQ3M1pYbIh5Fg1D7KO1yrg/JT9XuVuJ9GjQrBe7B8wGhHnbft9Wul7aQb2vELqvs98wReJ3TSmtA/pEn6NSNSCHkB0AwX8Hl+HuhPMH2zHoS67YG5D2JcOP2MvKx9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687250; c=relaxed/simple;
	bh=klu+M+ZZ2Kd0Ga6TJk6qCeHC8u16TFHw6n/IkUvD2uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L45bs+Uvv0rDAWov8I/EZOkDwvtqRKMr+aFqRwHyXyQ41LJUG8ezcH8z8qTWVafalaF8huV6Hru+zNGZKZdg9ZJ060y+tGYprbefYYVp7e324ZSssFAwmX048TSxs8ZINahWyUs0P7lRsd6dAaUMm05+1uVXzBYF+UWbWPswOSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1i6e29N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8EC4CEF9;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687250;
	bh=klu+M+ZZ2Kd0Ga6TJk6qCeHC8u16TFHw6n/IkUvD2uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S1i6e29N3reelSH2BGrZTonAhkkJo0PiFXN4XhIttTCvCvINhVoqtExzhT/5oLuAr
	 E/Ey/SVd76q8Ezkol0KyLSREKKKKI+d7VfDQtLmubneoRPB2JPQ4ImGpry00YkfgIP
	 ojaUdZNDdc3rQ7aTxmZxG+iQwlVuDJoqo3QeoI33AwwNQwvgvrfEDi4Bvm8cXanvz2
	 D/3OeXNdowJrjILPI1z3FDlfhl0w1f4PEuT23RGRz5uQZTrCh7mNakeC3o0yO64dRG
	 sB6i67Xx8mYkXv2b+NxpNO/eBJhTOCI0ECMZ14i4eMMqRIgICIbIKsLbQ2sFom796h
	 M07yvrtVzxTtw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux4kK-00000008VrJ-1DkU;
	Fri, 12 Sep 2025 16:27:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] scripts/check-variable-fonts.sh: convert to Python
Date: Fri, 12 Sep 2025 16:27:20 +0200
Message-ID: <4fd882d4681f37f474aa771ecfea6e95df6be21c.1757685692.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757685692.git.mchehab+huawei@kernel.org>
References: <cover.1757685692.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
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
 MAINTAINERS                                   |   2 +-
 ...iable-fonts.sh => check-variable-fonts.py} | 104 +++++++++++++-----
 2 files changed, 78 insertions(+), 28 deletions(-)
 rename scripts/{check-variable-fonts.sh => check-variable-fonts.py} (61%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 06bbed30b788..8cc14c85fdf5 100644
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
index ce63f0acea5f..71b88b680a73 100755
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
+        self.environ['XDG_CONFIG_HOMEF'] = os.path.expanduser(deny_vf)
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
2.50.1


