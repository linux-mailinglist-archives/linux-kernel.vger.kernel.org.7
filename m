Return-Path: <linux-kernel+bounces-818570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A979B59375
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99511BC6874
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E037305070;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shYzsQ8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00E43043B8;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018215; cv=none; b=hAWrKCxfeka5gErkFcgw3FLU7Sd9DKVv8KuwuwUlHAhJGMjRMMmwdLE4XFvTKGURxm8iV7RUaUF+hj2nXbFI0F/l5dGtBwHR0aEY63swEXsFMM4eFsF3w6CDmUFN5GeMXPeF2aR06YYEeWeYIs2CkaR6YEd5kwnUZx2IwC7EyzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018215; c=relaxed/simple;
	bh=IedbeYwhGQo/8+db2YoLieE5Rt2kNjiHQ4pk5A+mit8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gK6/neX68NXjWa8bjHDMTwGiQsoOxgeFkXfnyfFhyM5YReL3VRprULJm4Xy58Q7yAccdroDqTUruyB8X73wWiTg7yXA+HaBgAz8OTvZV1AwfVlDXmTF4Kl/YtgUU1KEvooNez6Miwn8nkEGJ1YLXs/NCgKhlMuAOoooFQWJ6jBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shYzsQ8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E53C4CEFC;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018215;
	bh=IedbeYwhGQo/8+db2YoLieE5Rt2kNjiHQ4pk5A+mit8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=shYzsQ8xouvLC1n6giYdpcusnEFM9/JqIjxZG0ctsxc/FyhJLkMLISucUFS+fjfwa
	 XLe+i9XJG+ZVxdq9+x89JbrrKKpUjQb+OOZdIGbfOh7zpsfZDOZBE3rlD6IWKIR2Mj
	 GBvCbmzxbyMhlGWjOl5zuyRw5bjXR4KiYVR5fADtR32CdJ+OtJ6gwTvoBN0KLDCld4
	 jItQoLPX/gqRHZbYsUy4qcuVj1R2CmNPVCqe4eZ65MUF3mtut6fnL4FwuqHbnJB6f6
	 SYQursWs9ut20DHy2nV8VNkgasbG/AxZQopJRZ0DCQSVavS5AyD2bsqfe7y5Qt6YRL
	 5lyP+QX48WgJA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBOm-2yTP;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/21] scripts: check-variable-fonts.sh: convert to Python
Date: Tue, 16 Sep 2025 12:22:40 +0200
Message-ID: <8a77212d5459eac2a98db442691930425a2cbefd.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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
2.51.0


