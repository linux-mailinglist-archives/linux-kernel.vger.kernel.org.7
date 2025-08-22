Return-Path: <linux-kernel+bounces-782124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02CDB31B84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45956435A9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0253128B5;
	Fri, 22 Aug 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkCJONWv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B0308F16;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=aTG0Mu8XNRb1RYKls8GIb2S/gu1p34zK1JOOAqemmPCqHkoAwYN1DbkkQZCj/IEEpf9AjOO6CHioskYllLnTz3nWyavfocSSH86HcW1U+XNKmIQeJY8HMJq1Y3xGDdOypTmPbJAhRPt4TALtrFXyaDsupRCLNXpFyuYIN8JgCw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=/wRz/bm5opGP5gUAlYf6YzB0TWc+kftZ82g5lfHklv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xg/owHZs2cG89HPf8+2cvJdp2QdgoHZL/a0A+EaB4h409T49zrktdxwkV1Sk+n2ue7hr1vlCG79gSn5RdBhfULgKPEpBbKJw7u/nBfCzE4KM7ngh1qE/cYpkpSXkBnw6zGjzlWO5uVPUFcq86mSRWo1v3MmE7wWZyyjLzrtPidM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkCJONWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C1C116C6;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=/wRz/bm5opGP5gUAlYf6YzB0TWc+kftZ82g5lfHklv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YkCJONWvnEedaT3kPPHzebvGJ3os/UfQ9WIWR9eJfOpKVgLKFAm5472X0mUGk/Wnj
	 ZVmVnuAqBzcunlqKGkjrzsO+sZKjWJSRIy38oBqS0c5T/XUUxlVVy7t9oiEnt/gyI7
	 o5RvrqFvdu7EG1y/DscD/BOVutxM/hmx+nOYn7A8+lQJI+7ZP+VODgauwY3R5R94/j
	 3QyPYJqgBG4qRRekMmLJDQuKzqggPt9iXTjphEtfjjJbqCjZlkrrx+nkA1sqdsRiFI
	 rFNHGc0AH0q1YRXuGOU+18sQCHGo7FMid1dAqYn+Zl+JG0uvSIpGVbd/Tep50p83Tq
	 DzrHHr9RuH+nA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCr3-0mR0;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/24] docs: parse-headers.py: improve --help logic
Date: Fri, 22 Aug 2025 16:19:15 +0200
Message-ID: <2c1e61d1fb1b2a2838b443beee89c1528831997f.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When printing --help, we'd like the name of the files
from __doc__ to match the displayed positional arguments at
both usage and argument description lines.

Use a custom formatter class to convert ``foo`` into ANSI SGR
code to bold the argument, if is TTY, and adjust the help
text to match the argument names.

Here on Plasma, that makes it display it colored, wich is
really cool. Yet, I opted for SGR, as the best is to follow
the terminal color schema for bold.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.py | 67 +++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/Documentation/sphinx/parse-headers.py b/Documentation/sphinx/parse-headers.py
index b39284d21090..650f9c9a68d1 100755
--- a/Documentation/sphinx/parse-headers.py
+++ b/Documentation/sphinx/parse-headers.py
@@ -4,20 +4,20 @@
 # pylint: disable=C0103,R0902,R0912,R0914,R0915
 
 """
-Convert a C header or source file (C_FILE), into a ReStructured Text
+Convert a C header or source file ``FILE_IN``, into a ReStructured Text
 included via ..parsed-literal block with cross-references for the
 documentation files that describe the API. It accepts an optional
-EXCEPTIONS_FILE with describes what elements will be either ignored or
-be pointed to a non-default reference.
+``FILE_RULES`` file to describes what elements will be either ignored or
+be pointed to a non-default reference type/name.
 
-The output is written at the (OUT_FILE).
+The output is written at ``FILE_OUT``.
 
 It is capable of identifying defines, functions, structs, typedefs,
 enums and enum symbols and create cross-references for all of them.
 It is also capable of distinguish #define used for specifying a Linux
 ioctl.
 
-The EXCEPTIONS_FILE contains a set of rules like:
+The optional ``FILE_RULES`` contains a set of rules like:
 
     ignore ioctl VIDIOC_ENUM_FMT
     replace ioctl VIDIOC_DQBUF vidioc_qbuf
@@ -400,17 +400,66 @@ class ParseHeader:
             f.write("\n\n.. parsed-literal::\n\n")
             f.write(text)
 
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
+            # Replace ``text`` with ANSI bold
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
+        else:
+            return ", ".join(action.option_strings)
+
 
 def main():
     """Main function"""
     parser = argparse.ArgumentParser(description=__doc__,
-                                     formatter_class=argparse.RawDescriptionHelpFormatter)
+                                     formatter_class=EnrichFormatter)
 
     parser.add_argument("-d", "--debug", action="count", default=0,
                         help="Increase debug level. Can be used multiple times")
     parser.add_argument("file_in", help="Input C file")
     parser.add_argument("file_out", help="Output RST file")
-    parser.add_argument("file_exceptions", nargs="?",
+    parser.add_argument("file_rules", nargs="?",
                         help="Exceptions file (optional)")
 
     args = parser.parse_args()
@@ -418,8 +467,8 @@ def main():
     parser = ParseHeader(debug=args.debug)
     parser.parse_file(args.file_in)
 
-    if args.file_exceptions:
-        parser.process_exceptions(args.file_exceptions)
+    if args.file_rules:
+        parser.process_exceptions(args.file_rules)
 
     parser.debug_print()
     parser.write_output(args.file_in, args.file_out)
-- 
2.50.1


