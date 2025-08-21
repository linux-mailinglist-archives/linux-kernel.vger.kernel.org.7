Return-Path: <linux-kernel+bounces-780026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1670B2FCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6F71BA4397
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8DD2D640D;
	Thu, 21 Aug 2025 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtlkHiPL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D5280328;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786099; cv=none; b=ABGjkJfWcFCtJRMJC61nv+RnJoYCQewFgV63JAPNDYKI9PlBDpcLGXAw+xFoEMSqz1ulZpz4gb++gRk/lDDKru7ApNON6FmAVySIfnlgMAEM/fj9FjPcGVbwQElXgcz43b+rTDRdrlIgKLBy+Bqlqf0o78CIm8WxrDDF08hjub8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786099; c=relaxed/simple;
	bh=uE8fFpGnhMJcK5GXfCzqeiiea156Y1/8xBUIdOSHKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV/tR9p0d1Bxz+WPEsp+Mj6qNKd1SyHi/I06GUSSf8xQulczhIsevLi+FapxvTlHOQS23u57gw+fyeIOsfe9hZvy+AdJfCQGIm9clCRJswZKqRPxm9JmOwJCVW2fy6Bnz2t4kAUNteeJyo3fniz4WTyNtGERWQIkHaeI08YEnN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BtlkHiPL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C2FC19422;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=uE8fFpGnhMJcK5GXfCzqeiiea156Y1/8xBUIdOSHKgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BtlkHiPLBRNfXYO9ys83tffbtgIgbT6sHMOnthh2f9Mpm3nG/fSOkKLxnm+5bs3fR
	 l63JoB1qK0FXSZQKP9aW/H/YcdjiXdX+ILuST7FEZx+bGmblHEX5HpoSB3YNH+zaT9
	 AQtNNGsxssIMfql2DSJypEYL+UyYqPJ89fGfpZY3rzM1ZtfUgsjUUrnYnwlAFF+xU9
	 UPsSy+xSmA1OJJf3TfemoBl86gFY21BqEfZaCbawAznJG2l99M5aGglgrSMFXyqZ2u
	 CN2yefe9E4B2zIG6VoPz3rg2rdSB51PTzXrp8okl42jHIlADDPlMMLzCu3qd9YyOwH
	 mxuBU5dEEc7kA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT8S-0gsH;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 07/24] tools: docs: parse_data_structs.py: add methods to return output
Date: Thu, 21 Aug 2025 16:21:13 +0200
Message-ID: <1588eefd164040e5b2d946201705459d36f273de.1755784930.git.mchehab+huawei@kernel.org>
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

When running it from command line, we want to write an output
file, but when used as a class, one may just want the output
content returned as a string.

Split write_output() on two methods to allow both usecases.

Also add an extra method to produce a TOC.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/lib/parse_data_structs.py | 62 ++++++++++++++++++++++++++--
 tools/docs/parse-headers.py          |  5 ++-
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/tools/docs/lib/parse_data_structs.py b/tools/docs/lib/parse_data_structs.py
index 2b7fa6bd8321..a5aa2e182052 100755
--- a/tools/docs/lib/parse_data_structs.py
+++ b/tools/docs/lib/parse_data_structs.py
@@ -97,33 +97,39 @@ class ParseDataStructs:
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":ref",
+            "description": "IOCTL Commands",
         },
         "define": {
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":ref",
+            "description": "Macros and Definitions",
         },
         # We're calling each definition inside an enum as "symbol"
         "symbol": {
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":ref",
+            "description": "Enumeration values",
         },
         "typedef": {
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":c:type",
+            "description": "Type Definitions",
         },
-        # This is the name of the enum itself
+        # This is the description of the enum itself
         "enum": {
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":c:type",
+            "description": "Enumerations",
         },
         "struct": {
             "prefix": "\\ ",
             "suffix": "\\ ",
             "ref_type": ":c:type",
+            "description": "Structures",
         },
     }
 
@@ -359,7 +365,7 @@ class ParseDataStructs:
 
             print()
 
-    def write_output(self, file_in: str, file_out: str):
+    def gen_output(self):
         """Write the formatted output to a file."""
 
         # Avoid extra blank lines
@@ -387,12 +393,60 @@ class ParseDataStructs:
         text = re.sub(r"\\ ([\n ])", r"\1", text)
         text = re.sub(r" \\ ", " ", text)
 
+        return text
 
+    def gen_toc(self):
+        """
+        Create a TOC table pointing to each symbol from the header
+        """
+        text = []
+
+        # Add header
+        text.append(".. contents:: Table of Contents")
+        text.append("   :depth: 2")
+        text.append("   :local:")
+        text.append("")
+
+        # Sort symbol types per description
+        symbol_descriptions = []
+        for k, v in self.DEF_SYMBOL_TYPES.items():
+            symbol_descriptions.append((v['description'], k))
+
+        symbol_descriptions.sort()
+
+        # Process each category
+        for description, c_type in symbol_descriptions:
+
+            refs = self.symbols[c_type]
+            if not refs:  # Skip empty categories
+                continue
+
+            text.append(f"{description}")
+            text.append("-" * len(description))
+            text.append("")
+
+            # Sort symbols alphabetically
+            for symbol, ref in sorted(refs.items()):
+                text.append(f"* :{ref}:")
+
+            text.append("")  # Add empty line between categories
+
+        return "\n".join(text)
+
+    def write_output(self, file_in: str, file_out: str, toc: bool):
         title = os.path.basename(file_in)
 
+        if toc:
+            text = self.gen_toc()
+        else:
+            text = self.gen_output()
+
         with open(file_out, "w", encoding="utf-8", errors="backslashreplace") as f:
             f.write(".. -*- coding: utf-8; mode: rst -*-\n\n")
             f.write(f"{title}\n")
-            f.write("=" * len(title))
-            f.write("\n\n.. parsed-literal::\n\n")
+            f.write("=" * len(title) + "\n\n")
+
+            if not toc:
+                f.write(".. parsed-literal::\n\n")
+
             f.write(text)
diff --git a/tools/docs/parse-headers.py b/tools/docs/parse-headers.py
index 07d3b47c4834..bfa4e46a53e3 100755
--- a/tools/docs/parse-headers.py
+++ b/tools/docs/parse-headers.py
@@ -36,6 +36,9 @@ def main():
 
     parser.add_argument("-d", "--debug", action="count", default=0,
                         help="Increase debug level. Can be used multiple times")
+    parser.add_argument("-t", "--toc", action="store_true",
+                        help="instead of a literal block, outputs a TOC table at the RST file")
+
     parser.add_argument("file_in", help="Input C file")
     parser.add_argument("file_out", help="Output RST file")
     parser.add_argument("file_rules", nargs="?",
@@ -50,7 +53,7 @@ def main():
         parser.process_exceptions(args.file_rules)
 
     parser.debug_print()
-    parser.write_output(args.file_in, args.file_out)
+    parser.write_output(args.file_in, args.file_out, args.toc)
 
 
 if __name__ == "__main__":
-- 
2.50.1


