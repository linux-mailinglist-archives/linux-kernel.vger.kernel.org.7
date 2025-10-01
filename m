Return-Path: <linux-kernel+bounces-839024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E2DBB0A90
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 16:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE2517A337
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 14:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4684F30215A;
	Wed,  1 Oct 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joGdI/dS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A371547F2;
	Wed,  1 Oct 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759328051; cv=none; b=YrPKqVbwutVmnLt+51Ih+xHJK2euwBbqzhMAB0oy68bpLUawswkNvpQ161F2CATh0+W0sIql1dNMrZpLg4YfFW71eWdZvMuh8JWyld3WnD+pd1Gv0WJY1p0HjNsJz6mGHMvihkh8BOEnyMD8a3dxljYo335EI5ulTfkML168nuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759328051; c=relaxed/simple;
	bh=Ppriek2YTc3QCt8FnFa4m0alyepaDOHdU9HDlS4iDgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8hUeYJPubxe3xD7bLrV3GH5HtlkVwliFYcgCTUoGrEJhA8rV9Qk8/Fai/DBcHfjztEWxYKKpcVygdV2Vvb6rY+i30IVSWNSrzU4G9sufHuadPq7nAUJULQcrGXLkelFjGp35TneKndpcK68FkxdpHQViYeeRB0Rcq2f5hwlRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joGdI/dS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B68CC4CEF5;
	Wed,  1 Oct 2025 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759328051;
	bh=Ppriek2YTc3QCt8FnFa4m0alyepaDOHdU9HDlS4iDgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joGdI/dSfNiZBsQMvjhbrUh8nJW2X/UuvIE3kTF9z4cZMpAbrtZ612XVdcr9Ki5r+
	 qAZRaN4Jy+5pvvBsxJ3gU/EbbdTXsP6otIiITxJd95x9G0gztNsHCAWc6ozfho/2iC
	 1VApspfpbbEIGOO8APXj+DHj2G3XtrKzfcCRL4D0lgwzQGTrWmatKx31oOKSagn+vm
	 xtaCOdTl0JRkYE+Oz6KqiJPD/mn+rNKx6wiw5UVntvzGXc5o7doo4vWTx0yLV+68vv
	 LO34glROxX0x+tAhcv+KjevUgiHNqtb740t37uBNVJjjLtNGm605hJ1wwAS1C0cCyL
	 87EuJb9Dcyflg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3xar-0000000BJ5Z-2Bgj;
	Wed, 01 Oct 2025 16:14:09 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Jonathan Corbet" <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] kernel-doc: output source file name at SEE ALSO
Date: Wed,  1 Oct 2025 16:13:59 +0200
Message-ID: <ac25496a27a0c90494a634d342207ef1ff6216e9.1759327966.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759327966.git.mchehab+huawei@kernel.org>
References: <cover.1759327966.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

for man pages, it is helpful to know from where the man page
were generated.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_item.py   | 3 ++-
 scripts/lib/kdoc/kdoc_output.py | 3 ++-
 scripts/lib/kdoc/kdoc_parser.py | 8 +++++---
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
index b3b225764550..19805301cb2c 100644
--- a/scripts/lib/kdoc/kdoc_item.py
+++ b/scripts/lib/kdoc/kdoc_item.py
@@ -5,8 +5,9 @@
 #
 
 class KdocItem:
-    def __init__(self, name, type, start_line, **other_stuff):
+    def __init__(self, name, fname, type, start_line, **other_stuff):
         self.name = name
+        self.fname = fname
         self.type = type
         self.declaration_start_line = start_line
         self.sections = {}
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index 1eca9a918558..58f115059e93 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -630,10 +630,11 @@ class ManFormat(OutputFormat):
         """Adds a tail for all man pages"""
 
         # SEE ALSO section
+        self.data += f'.SH "SEE ALSO"' + "\n.PP\n"
+        self.data += (f"Kernel file \\fB{args.fname}\\fR\n")
         if len(self.symbols) >= 2:
             cur_name = self.arg_name(args, name)
 
-            self.data += f'.SH "SEE ALSO"' + "\n.PP\n"
             related = []
             for arg in self.symbols:
                 out_name = self.arg_name(arg, arg.name)
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 89d920e0b65c..6e5c115cbdf3 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -254,8 +254,9 @@ SECTION_DEFAULT = "Description"  # default section
 
 class KernelEntry:
 
-    def __init__(self, config, ln):
+    def __init__(self, config, fname, ln):
         self.config = config
+        self.fname = fname
 
         self._contents = []
         self.prototype = ""
@@ -422,7 +423,8 @@ class KernelDoc:
         The actual output and output filters will be handled elsewhere
         """
 
-        item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
+        item = KdocItem(name, self.fname, dtype,
+                        self.entry.declaration_start_line, **args)
         item.warnings = self.entry.warnings
 
         # Drop empty sections
@@ -445,7 +447,7 @@ class KernelDoc:
         variables used by the state machine.
         """
 
-        self.entry = KernelEntry(self.config, ln)
+        self.entry = KernelEntry(self.config, self.fname, ln)
 
         # State flags
         self.state = state.NORMAL
-- 
2.51.0


