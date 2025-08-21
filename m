Return-Path: <linux-kernel+bounces-780040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C3DB2FCCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D17221D25099
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78528467D;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPvniHZH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90732857DA;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=cMwJLAjEv1vq3k7mFMiwL3Bcza6kWRKrrLFE0HcD382KDaaNL8dzS3jDFZ9EA3QYTim0itdZcffarkg2N0DdRtnzZUPJej1tZ3SL0Z4tUB+JZletwuSg3JlydlsFblv6rOiH/4qUjB3FAYTiEtaO9a39pt151KqpWy6exArHIcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=RcaqdZwLfefMvyrZbcNpDpPDg5fNh39ClTRYBACxEw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgK6PM/DnMR59h/oCD+amoqeHD9er5lGVwbuE9My6z74rL346KTVpFJLgFIgBhgoO7algsl4Kn1jEiLKhEbpniFGu8/zrq//+bQkg6qGxOarH/AxuYl21DlbTSnyaoPXD/G5hmOSiL9d1GD0WIMthwLqzSmguVr+H3DbEJVHqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPvniHZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2761FC19424;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=RcaqdZwLfefMvyrZbcNpDpPDg5fNh39ClTRYBACxEw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPvniHZHCg+vn/mYW+ke9xN7gioni/R3dB7XDYnyFN1EZAjMKckMLYhN3qeSrhicc
	 N85vgcLuNSQsfHI0YQG9fiFeUKFtB7suMPDsNYi7okinQ7QNPLtKXMmTnzGS1/q3/R
	 sgyVe2geQlowjhFHnTLm5gPVLdwkxNxSPAu3McYLWPO+yMShuHy7RC3GMWSTDPgSEB
	 SYmfNrTK55S4/42ZlrP4FD6LD8NFM2XgP/kqIJyP18VcFIoQSxJIcl/jXz41sI0gNH
	 ee/0TYo3zS4wItAFYgDSFfRdNlRlaYRvIuy98/h+lDw3gY21i9mq8KcfutK76Vqu6/
	 zw6w0OBRKnYfg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8O-0a5b;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <mchehab+huawei@kernel.org>,
	Jan Stancek <jstancek@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/24] tools: docs: parse-headers.py: move it from sphinx dir
Date: Thu, 21 Aug 2025 16:21:12 +0200
Message-ID: <bef6a26663a9c7f7e515f36078432ee7a2a4330e.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As suggested by Jon, we should start having a tools/docs
directory, instead of placing everything under scripts.

In the specific case of parse-headers.py, the previous
location is where we're placing Sphinx extensions, which is
not the right place for execs.

Move it to tools/docs/parse-headers.py.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .pylintrc                                     |  2 +-
 tools/docs/lib/__init__.py                    |  0
 tools/docs/lib/enrich_formatter.py            | 70 ++++++++++++++
 .../docs/lib/parse_data_structs.py            | 95 ++-----------------
 tools/docs/parse-headers.py                   | 57 +++++++++++
 5 files changed, 135 insertions(+), 89 deletions(-)
 create mode 100644 tools/docs/lib/__init__.py
 create mode 100644 tools/docs/lib/enrich_formatter.py
 rename Documentation/sphinx/parse-headers.py => tools/docs/lib/parse_data_structs.py (80%)
 create mode 100755 tools/docs/parse-headers.py

diff --git a/.pylintrc b/.pylintrc
index f1d21379254b..ad2476751f80 100644
--- a/.pylintrc
+++ b/.pylintrc
@@ -1,2 +1,2 @@
 [MASTER]
-init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi"]'
+init-hook='import sys; sys.path += ["scripts/lib", "scripts/lib/kdoc", "scripts/lib/abi", "tools/docs/lib"]'
diff --git a/tools/docs/lib/__init__.py b/tools/docs/lib/__init__.py
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/docs/lib/enrich_formatter.py b/tools/docs/lib/enrich_formatter.py
new file mode 100644
index 000000000000..bb171567a4ca
--- /dev/null
+++ b/tools/docs/lib/enrich_formatter.py
@@ -0,0 +1,70 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+"""
+Ancillary argparse HelpFormatter class that works on a similar way as
+argparse.RawDescriptionHelpFormatter, e.g. description maintains line
+breaks, but it also implement transformations to the help text. The
+actual transformations ar given by enrich_text(), if the output is tty.
+
+Currently, the follow transformations are done:
+
+    - Positional arguments are shown in upper cases;
+    - if output is TTY, ``var`` and positional arguments are shown prepended
+      by an ANSI SGR code. This is usually translated to bold. On some
+      terminals, like, konsole, this is translated into a colored bold text.
+"""
+
+import argparse
+import re
+import sys
+
+class EnrichFormatter(argparse.HelpFormatter):
+    """
+    Better format the output, making easier to identify the positional args
+    and how they're used at the __doc__ description.
+    """
+    def __init__(self, *args, **kwargs):
+        """Initialize class and check if is TTY"""
+        super().__init__(*args, **kwargs)
+        self._tty = sys.stdout.isatty()
+
+    def enrich_text(self, text):
+        """Handle ReST markups (currently, only ``foo``)"""
+        if self._tty and text:
+            # Replace ``text`` with ANSI SGR (bold)
+            return re.sub(r'\`\`(.+?)\`\`',
+                          lambda m: f'\033[1m{m.group(1)}\033[0m', text)
+        return text
+
+    def _fill_text(self, text, width, indent):
+        """Enrich descriptions with markups on it"""
+        enriched = self.enrich_text(text)
+        return "\n".join(indent + line for line in enriched.splitlines())
+
+    def _format_usage(self, usage, actions, groups, prefix):
+        """Enrich positional arguments at usage: line"""
+
+        prog = self._prog
+        parts = []
+
+        for action in actions:
+            if action.option_strings:
+                opt = action.option_strings[0]
+                if action.nargs != 0:
+                    opt += f" {action.dest.upper()}"
+                parts.append(f"[{opt}]")
+            else:
+                # Positional argument
+                parts.append(self.enrich_text(f"``{action.dest.upper()}``"))
+
+        usage_text = f"{prefix or 'usage: '} {prog} {' '.join(parts)}\n"
+        return usage_text
+
+    def _format_action_invocation(self, action):
+        """Enrich argument names"""
+        if not action.option_strings:
+            return self.enrich_text(f"``{action.dest.upper()}``")
+
+        return ", ".join(action.option_strings)
diff --git a/Documentation/sphinx/parse-headers.py b/tools/docs/lib/parse_data_structs.py
similarity index 80%
rename from Documentation/sphinx/parse-headers.py
rename to tools/docs/lib/parse_data_structs.py
index 344090ef259c..2b7fa6bd8321 100755
--- a/Documentation/sphinx/parse-headers.py
+++ b/tools/docs/lib/parse_data_structs.py
@@ -1,36 +1,32 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2016 by Mauro Carvalho Chehab <mchehab@kernel.org>.
-# pylint: disable=C0103,R0902,R0912,R0914,R0915
+# Copyright (c) 2016-2025 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+# pylint: disable=R0912,R0915
 
 """
-Convert a C header or source file ``FILE_IN``, into a ReStructured Text
-included via ..parsed-literal block with cross-references for the
-documentation files that describe the API. It accepts an optional
-``FILE_RULES`` file to describes what elements will be either ignored or
-be pointed to a non-default reference type/name.
+Parse a source file or header, creating ReStructured Text cross references.
 
-The output is written at ``FILE_OUT``.
+It accepts an optional file to change the default symbol reference or to
+suppress symbols from the output.
 
 It is capable of identifying defines, functions, structs, typedefs,
 enums and enum symbols and create cross-references for all of them.
 It is also capable of distinguish #define used for specifying a Linux
 ioctl.
 
-The optional ``FILE_RULES`` contains a set of rules like:
+The optional rules file contains a set of rules like:
 
     ignore ioctl VIDIOC_ENUM_FMT
     replace ioctl VIDIOC_DQBUF vidioc_qbuf
     replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
 """
 
-import argparse
 import os
 import re
 import sys
 
 
-class ParseHeader:
+class ParseDataStructs:
     """
     Creates an enriched version of a Kernel header file with cross-links
     to each C data structure type.
@@ -400,80 +396,3 @@ class ParseHeader:
             f.write("=" * len(title))
             f.write("\n\n.. parsed-literal::\n\n")
             f.write(text)
-
-class EnrichFormatter(argparse.HelpFormatter):
-    """
-    Better format the output, making easier to identify the positional args
-    and how they're used at the __doc__ description.
-    """
-    def __init__(self, *args, **kwargs):
-        """Initialize class and check if is TTY"""
-        super().__init__(*args, **kwargs)
-        self._tty = sys.stdout.isatty()
-
-    def enrich_text(self, text):
-        """Handle ReST markups (currently, only ``foo``)"""
-        if self._tty and text:
-            # Replace ``text`` with ANSI bold
-            return re.sub(r'\`\`(.+?)\`\`',
-                          lambda m: f'\033[1m{m.group(1)}\033[0m', text)
-        return text
-
-    def _fill_text(self, text, width, indent):
-        """Enrich descriptions with markups on it"""
-        enriched = self.enrich_text(text)
-        return "\n".join(indent + line for line in enriched.splitlines())
-
-    def _format_usage(self, usage, actions, groups, prefix):
-        """Enrich positional arguments at usage: line"""
-
-        prog = self._prog
-        parts = []
-
-        for action in actions:
-            if action.option_strings:
-                opt = action.option_strings[0]
-                if action.nargs != 0:
-                    opt += f" {action.dest.upper()}"
-                parts.append(f"[{opt}]")
-            else:
-                # Positional argument
-                parts.append(self.enrich_text(f"``{action.dest.upper()}``"))
-
-        usage_text = f"{prefix or 'usage: '} {prog} {' '.join(parts)}\n"
-        return usage_text
-
-    def _format_action_invocation(self, action):
-        """Enrich argument names"""
-        if not action.option_strings:
-            return self.enrich_text(f"``{action.dest.upper()}``")
-        else:
-            return ", ".join(action.option_strings)
-
-
-def main():
-    """Main function"""
-    parser = argparse.ArgumentParser(description=__doc__,
-                                     formatter_class=EnrichFormatter)
-
-    parser.add_argument("-d", "--debug", action="count", default=0,
-                        help="Increase debug level. Can be used multiple times")
-    parser.add_argument("file_in", help="Input C file")
-    parser.add_argument("file_out", help="Output RST file")
-    parser.add_argument("file_rules", nargs="?",
-                        help="Exceptions file (optional)")
-
-    args = parser.parse_args()
-
-    parser = ParseHeader(debug=args.debug)
-    parser.parse_file(args.file_in)
-
-    if args.file_rules:
-        parser.process_exceptions(args.file_rules)
-
-    parser.debug_print()
-    parser.write_output(args.file_in, args.file_out)
-
-
-if __name__ == "__main__":
-    main()
diff --git a/tools/docs/parse-headers.py b/tools/docs/parse-headers.py
new file mode 100755
index 000000000000..07d3b47c4834
--- /dev/null
+++ b/tools/docs/parse-headers.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2016, 2025 by Mauro Carvalho Chehab <mchehab@kernel.org>.
+# pylint: disable=C0103
+
+"""
+Convert a C header or source file ``FILE_IN``, into a ReStructured Text
+included via ..parsed-literal block with cross-references for the
+documentation files that describe the API. It accepts an optional
+``FILE_RULES`` file to describes what elements will be either ignored or
+be pointed to a non-default reference type/name.
+
+The output is written at ``FILE_OUT``.
+
+It is capable of identifying defines, functions, structs, typedefs,
+enums and enum symbols and create cross-references for all of them.
+It is also capable of distinguish #define used for specifying a Linux
+ioctl.
+
+The optional ``FILE_RULES`` contains a set of rules like:
+
+    ignore ioctl VIDIOC_ENUM_FMT
+    replace ioctl VIDIOC_DQBUF vidioc_qbuf
+    replace define V4L2_EVENT_MD_FL_HAVE_FRAME_SEQ :c:type:`v4l2_event_motion_det`
+"""
+
+import argparse
+
+from lib.parse_data_structs import ParseDataStructs
+from lib.enrich_formatter import EnrichFormatter
+
+def main():
+    """Main function"""
+    parser = argparse.ArgumentParser(description=__doc__,
+                                     formatter_class=EnrichFormatter)
+
+    parser.add_argument("-d", "--debug", action="count", default=0,
+                        help="Increase debug level. Can be used multiple times")
+    parser.add_argument("file_in", help="Input C file")
+    parser.add_argument("file_out", help="Output RST file")
+    parser.add_argument("file_rules", nargs="?",
+                        help="Exceptions file (optional)")
+
+    args = parser.parse_args()
+
+    parser = ParseDataStructs(debug=args.debug)
+    parser.parse_file(args.file_in)
+
+    if args.file_rules:
+        parser.process_exceptions(args.file_rules)
+
+    parser.debug_print()
+    parser.write_output(args.file_in, args.file_out)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.50.1


