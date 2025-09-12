Return-Path: <linux-kernel+bounces-814256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76199B55193
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB161B625BE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BF2320CBA;
	Fri, 12 Sep 2025 14:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e9fjZeHk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341D242930;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687250; cv=none; b=Ce0kWjR4OVq89+xWZT3N08ziTEBFjXIwC78Nke+t6ENSgiXg+DIyp27EFuG1eGFc8JynazWY70HuGyorPZJxwu2OFU/s/0wS+noHNPYDyKeFOYNsYzo+KMTcG8P3Dg5QSaMwmzBBuHd6IqUeYinAQqBsttnJMM6Ap1mJoPf0wDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687250; c=relaxed/simple;
	bh=bRXD+/xhUmvs2LfVdiulK3PDsb6VybJ4BlQnxqAQJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AdxM3uwxF3Z8t7w0rtafvOJbDuxWvlIWn2kZTAP+FA9U/0ISRf29sODtT6Pv42pTn9/bCF5hF2xO93H0kprmS8hi1JkOh4KGYM7wE6lfZDWsFhCHSMFcZXb3x6XvQ62Ibb7EKIPHg0Iok3rU4o4sClI2YtAxYiUXI76M3ZejjVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9fjZeHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED7C4CEF1;
	Fri, 12 Sep 2025 14:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687250;
	bh=bRXD+/xhUmvs2LfVdiulK3PDsb6VybJ4BlQnxqAQJ/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e9fjZeHkLc5HM4tsY0h/6H67VrhZ82/c/A2yWZyRKVQ+mu3KiLng75ufn1DUgkEvo
	 VDTR3g+GivAu99+zEM4RM12+fBKghnfiQqoDSy8/EI1Ff1VWQcwZI/iwn/FjbiYuRa
	 BcrLhCfL4bXKI1/caXtmddvUWswiJP3HMMIoHtNCJfntivkxMLepwvoI/VzfOXcJXY
	 MAI5FN5WpnKFiuamYsbel/cNmsOwlATfXx5mChXS+RFt2TDl4pLb4GjvXnQgGX+aY+
	 7M7wpzwWaWcrgT0QwtfkEWtCUdnrGGU9sBEcqAFVoG+OFI3qbABIj6eosH7WcfMKz0
	 pRFfOlVYs84Aw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux4kK-00000008VrN-1KU9;
	Fri, 12 Sep 2025 16:27:28 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] scripts: check-variable-fonts.py: split into a lib and an exec file
Date: Fri, 12 Sep 2025 16:27:21 +0200
Message-ID: <82746b6ff491fe8a07d4b0511dc28615b5b3fde4.1757685692.git.mchehab+huawei@kernel.org>
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

As we'll be using the actual code inside sphinx-build-wrapper,
split the library from the executable, placing the exec at
the new place we've been using:

	tools/docs

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS                        |   1 -
 scripts/check-variable-fonts.py    | 165 -----------------------------
 tools/docs/check-variable-fonts.py |  23 ++++
 tools/docs/lib/latex_fonts.py      | 162 ++++++++++++++++++++++++++++
 4 files changed, 185 insertions(+), 166 deletions(-)
 delete mode 100755 scripts/check-variable-fonts.py
 create mode 100755 tools/docs/check-variable-fonts.py
 create mode 100755 tools/docs/lib/latex_fonts.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8cc14c85fdf5..16a5d6ab627d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7301,7 +7301,6 @@ S:	Maintained
 P:	Documentation/doc-guide/maintainer-profile.rst
 T:	git git://git.lwn.net/linux.git docs-next
 F:	Documentation/
-F:	scripts/check-variable-fonts.py
 F:	scripts/checktransupdate.py
 F:	scripts/documentation-file-ref-check
 F:	scripts/get_abi.py
diff --git a/scripts/check-variable-fonts.py b/scripts/check-variable-fonts.py
deleted file mode 100755
index 71b88b680a73..000000000000
--- a/scripts/check-variable-fonts.py
+++ /dev/null
@@ -1,165 +0,0 @@
-#!/usr/bin/env python3
-# SPDX-License-Identifier: GPL-2.0-only
-# Copyright (C) Akira Yokosawa, 2024
-#
-# Ported to Python by (c) Mauro Carvalho Chehab, 2025
-#
-# For "make pdfdocs", reports of build errors of translations.pdf started
-# arriving early 2024 [1, 2].  It turned out that Fedora and openSUSE
-# tumbleweed have started deploying variable-font [3] format of "Noto CJK"
-# fonts [4, 5].  For PDF, a LaTeX package named xeCJK is used for CJK
-# (Chinese, Japanese, Korean) pages.  xeCJK requires XeLaTeX/XeTeX, which
-# does not (and likely never will) understand variable fonts for historical
-# reasons.
-#
-# The build error happens even when both of variable- and non-variable-format
-# fonts are found on the build system.  To make matters worse, Fedora enlists
-# variable "Noto CJK" fonts in the requirements of langpacks-ja, -ko, -zh_CN,
-# -zh_TW, etc.  Hence developers who have interest in CJK pages are more
-# likely to encounter the build errors.
-#
-# This script is invoked from the error path of "make pdfdocs" and emits
-# suggestions if variable-font files of "Noto CJK" fonts are in the list of
-# fonts accessible from XeTeX.
-#
-# References:
-# [1]: https://lore.kernel.org/r/8734tqsrt7.fsf@meer.lwn.net/
-# [2]: https://lore.kernel.org/r/1708585803.600323099@f111.i.mail.ru/
-# [3]: https://en.wikipedia.org/wiki/Variable_font
-# [4]: https://fedoraproject.org/wiki/Changes/Noto_CJK_Variable_Fonts
-# [5]: https://build.opensuse.org/request/show/1157217
-#
-#===========================================================================
-# Workarounds for building translations.pdf
-#===========================================================================
-#
-# * Denylist "variable font" Noto CJK fonts.
-#   - Create $HOME/deny-vf/fontconfig/fonts.conf from template below, with
-#     tweaks if necessary.  Remove leading "# ".
-#   - Path of fontconfig/fonts.conf can be overridden by setting an env
-#     variable FONTS_CONF_DENY_VF.
-#
-#     * Template:
-# -----------------------------------------------------------------
-# <?xml version="1.0"?>
-# <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
-# <fontconfig>
-# <!--
-#   Ignore variable-font glob (not to break xetex)
-# -->
-#     <selectfont>
-#         <rejectfont>
-#             <!--
-#                 for Fedora
-#             -->
-#             <glob>/usr/share/fonts/google-noto-*-cjk-vf-fonts</glob>
-#             <!--
-#                 for openSUSE tumbleweed
-#             -->
-#             <glob>/usr/share/fonts/truetype/Noto*CJK*-VF.otf</glob>
-#         </rejectfont>
-#     </selectfont>
-# </fontconfig>
-# -----------------------------------------------------------------
-#
-#     The denylisting is activated for "make pdfdocs".
-#
-# * For skipping CJK pages in PDF
-#   - Uninstall texlive-xecjk.
-#     Denylisting is not needed in this case.
-#
-# * For printing CJK pages in PDF
-#   - Need non-variable "Noto CJK" fonts.
-#     * Fedora
-#       - google-noto-sans-cjk-fonts
-#       - google-noto-serif-cjk-fonts
-#     * openSUSE tumbleweed
-#       - Non-variable "Noto CJK" fonts are not available as distro packages
-#         as of April, 2024.  Fetch a set of font files from upstream Noto
-#         CJK Font released at:
-#           https://github.com/notofonts/noto-cjk/tree/main/Sans#super-otc
-#         and at:
-#           https://github.com/notofonts/noto-cjk/tree/main/Serif#super-otc
-#         , then uncompress and deploy them.
-#       - Remember to update fontconfig cache by running fc-cache.
-#
-# !!! Caution !!!
-#     Uninstalling "variable font" packages can be dangerous.
-#     They might be depended upon by other packages important for your work.
-#     Denylisting should be less invasive, as it is effective only while
-#     XeLaTeX runs in "make pdfdocs".
-
-import os
-import re
-import subprocess
-import sys
-import textwrap
-
-class LatexFontChecker:
-    """
-    Detect problems with CJK variable fonts that affect PDF builds for
-    translations.
-    """
-
-    def __init__(self):
-        deny_vf = os.environ.get('FONTS_CONF_DENY_VF', "~/deny-vf")
-
-        self.environ = os.environ.copy()
-        self.environ['XDG_CONFIG_HOMEF'] = os.path.expanduser(deny_vf)
-
-        self.re_cjk = re.compile(r"([^:]+):\s*Noto\s+(Sans|Sans Mono|Serif) CJK")
-
-    def get_noto_cjk_vf_fonts(self):
-        """Get Noto CJK fonts"""
-
-        cjk_fonts = set()
-        cmd = ["fc-list", ":", "file", "family", "variable"]
-        try:
-            result = subprocess.run(cmd,stdout=subprocess.PIPE,
-                                    stderr=subprocess.PIPE,
-                                    universal_newlines=True,
-                                    env=self.environ,
-                                    check=True)
-
-        except subprocess.CalledProcessError as exc:
-            sys.exit(f"Error running fc-list: {repr(exc)}")
-
-        for line in result.stdout.splitlines():
-            if 'variable=True' not in line:
-                continue
-
-            match = self.re_cjk.search(line)
-            if match:
-                cjk_fonts.add(match.group(1))
-
-        return sorted(cjk_fonts)
-
-    def check(self):
-        """Check for problems with CJK fonts"""
-
-        fonts = textwrap.indent("\n".join(self.get_noto_cjk_vf_fonts()), "    ")
-        if not fonts:
-            return None
-
-        rel_file = os.path.relpath(__file__, os.getcwd())
-
-        msg = "=" * 77 + "\n"
-        msg += 'XeTeX is confused by "variable font" files listed below:\n'
-        msg += fonts + "\n"
-        msg += textwrap.dedent(f"""
-                For CJK pages in PDF, they need to be hidden from XeTeX by denylisting.
-                Or, CJK pages can be skipped by uninstalling texlive-xecjk.
-
-                For more info on denylisting, other options, and variable font, see header
-                comments of {rel_file}.
-            """)
-        msg += "=" * 77
-
-        return msg
-
-if __name__ == "__main__":
-    msg = LatexFontChecker().check()
-    if msg:
-        print(msg)
-
-    sys.exit(1)
diff --git a/tools/docs/check-variable-fonts.py b/tools/docs/check-variable-fonts.py
new file mode 100755
index 000000000000..79b28f0f7d85
--- /dev/null
+++ b/tools/docs/check-variable-fonts.py
@@ -0,0 +1,23 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) Akira Yokosawa, 2024
+#
+# Ported to Python by (c) Mauro Carvalho Chehab, 2025
+#
+# pylint: disable=C0103
+
+"""
+Detect problematic Noto CJK variable fonts.
+
+or more details, see lib/latex_fonts.py.
+"""
+
+import sys
+
+from lib.latex_fonts import LatexFontChecker
+
+msg = LatexFontChecker().check()
+if msg:
+    print(msg)
+
+sys.exit(1)
diff --git a/tools/docs/lib/latex_fonts.py b/tools/docs/lib/latex_fonts.py
new file mode 100755
index 000000000000..e03412e3947e
--- /dev/null
+++ b/tools/docs/lib/latex_fonts.py
@@ -0,0 +1,162 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) Akira Yokosawa, 2024
+#
+# Ported to Python by (c) Mauro Carvalho Chehab, 2025
+
+"""
+Detect problematic Noto CJK variable fonts.
+
+For "make pdfdocs", reports of build errors of translations.pdf started
+arriving early 2024 [1, 2].  It turned out that Fedora and openSUSE
+tumbleweed have started deploying variable-font [3] format of "Noto CJK"
+fonts [4, 5].  For PDF, a LaTeX package named xeCJK is used for CJK
+(Chinese, Japanese, Korean) pages.  xeCJK requires XeLaTeX/XeTeX, which
+does not (and likely never will) understand variable fonts for historical
+reasons.
+
+The build error happens even when both of variable- and non-variable-format
+fonts are found on the build system.  To make matters worse, Fedora enlists
+variable "Noto CJK" fonts in the requirements of langpacks-ja, -ko, -zh_CN,
+-zh_TW, etc.  Hence developers who have interest in CJK pages are more
+likely to encounter the build errors.
+
+This script is invoked from the error path of "make pdfdocs" and emits
+suggestions if variable-font files of "Noto CJK" fonts are in the list of
+fonts accessible from XeTeX.
+
+References:
+[1]: https://lore.kernel.org/r/8734tqsrt7.fsf@meer.lwn.net/
+[2]: https://lore.kernel.org/r/1708585803.600323099@f111.i.mail.ru/
+[3]: https://en.wikipedia.org/wiki/Variable_font
+[4]: https://fedoraproject.org/wiki/Changes/Noto_CJK_Variable_Fonts
+[5]: https://build.opensuse.org/request/show/1157217
+
+#===========================================================================
+Workarounds for building translations.pdf
+#===========================================================================
+
+* Denylist "variable font" Noto CJK fonts.
+  - Create $HOME/deny-vf/fontconfig/fonts.conf from template below, with
+    tweaks if necessary.  Remove leading "".
+  - Path of fontconfig/fonts.conf can be overridden by setting an env
+    variable FONTS_CONF_DENY_VF.
+
+    * Template:
+-----------------------------------------------------------------
+<?xml version="1.0"?>
+<!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
+<fontconfig>
+<!--
+  Ignore variable-font glob (not to break xetex)
+-->
+    <selectfont>
+        <rejectfont>
+            <!--
+                for Fedora
+            -->
+            <glob>/usr/share/fonts/google-noto-*-cjk-vf-fonts</glob>
+            <!--
+                for openSUSE tumbleweed
+            -->
+            <glob>/usr/share/fonts/truetype/Noto*CJK*-VF.otf</glob>
+        </rejectfont>
+    </selectfont>
+</fontconfig>
+-----------------------------------------------------------------
+
+    The denylisting is activated for "make pdfdocs".
+
+* For skipping CJK pages in PDF
+  - Uninstall texlive-xecjk.
+    Denylisting is not needed in this case.
+
+* For printing CJK pages in PDF
+  - Need non-variable "Noto CJK" fonts.
+    * Fedora
+      - google-noto-sans-cjk-fonts
+      - google-noto-serif-cjk-fonts
+    * openSUSE tumbleweed
+      - Non-variable "Noto CJK" fonts are not available as distro packages
+        as of April, 2024.  Fetch a set of font files from upstream Noto
+        CJK Font released at:
+          https://github.com/notofonts/noto-cjk/tree/main/Sans#super-otc
+        and at:
+          https://github.com/notofonts/noto-cjk/tree/main/Serif#super-otc
+        , then uncompress and deploy them.
+      - Remember to update fontconfig cache by running fc-cache.
+
+!!! Caution !!!
+    Uninstalling "variable font" packages can be dangerous.
+    They might be depended upon by other packages important for your work.
+    Denylisting should be less invasive, as it is effective only while
+    XeLaTeX runs in "make pdfdocs".
+"""
+
+import os
+import re
+import subprocess
+import textwrap
+import sys
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
-- 
2.50.1


