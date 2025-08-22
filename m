Return-Path: <linux-kernel+bounces-782122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F64B31B7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3131C86032
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B03128B6;
	Fri, 22 Aug 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J28/AtaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601B1301476;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=Zlk7+8MiYc/WhiUjxEdKcVkaE2R5bgg1KAHEM5pqbVOwf5puNYGn8EPF0OnS6DtM2HqeCujamulb3gHUFmvskfUHDv5nhLQZ+Wo6+LfAykmwEyqHg7W8thRju2lCROieGO/qIDsyC6gKSLwC0gFRPsNKR+BBeB84+a8C56QaXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=uE8fFpGnhMJcK5GXfCzqeiiea156Y1/8xBUIdOSHKgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gu9U4mGr9QKzPrkygxrpVUyAW/4tbVVaeLhq+1CRPKX9acEs6lRGvk0Z8TLoG6zd24Hm6T9k4p4EDoDbifrJNSphwuiuy3BVPT4iLhuJrFLu8Ja30Sdon/4UKkxDAOvJ1eqIZpOVTCVhPE8hnH+Qq/QVEgz0m5soGqwIKVjeSpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J28/AtaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167CAC16AAE;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=uE8fFpGnhMJcK5GXfCzqeiiea156Y1/8xBUIdOSHKgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J28/AtaWZHBdvAsacEffPQkK3sB0xJ44okSEHhpklKZ1OEurf+d1Ea+nOq4pAqdfQ
	 vVSkW29ZSAjAcAIW/vA2nkXj9DRmpKuc33i01NSOI0OzudhcRQghmYKNZEqKurBgbJ
	 fKwNviSheveADFSW8WTdbweDzWDMqlois6fhBnRY+Wap+kTqIRQW+kTtAS4yFoh/Cp
	 QbkNwCksg/zDJK8PTOxfzDu0EVEZ7buAbKO46+Tn/pTyjRGXEl90KJ0Tr7+rPRje6I
	 QORkTU1EJ2R1yWv39/E+6xbLkfyIVMmz5SU9fN3x+y7e/AfcrvxbfhtAdsWkxxhy3m
	 TkgwRQDz/TUpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrJ-1DXT;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/24] tools: docs: parse_data_structs.py: add methods to return output
Date: Fri, 22 Aug 2025 16:19:19 +0200
Message-ID: <c98bdec3380aad54178baf2751a2f1fcd128576b.1755872208.git.mchehab+huawei@kernel.org>
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


