Return-Path: <linux-kernel+bounces-808994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48F0B50740
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70F34E54E0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39F435E4D3;
	Tue,  9 Sep 2025 20:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ps5b0S0u"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB452350D79;
	Tue,  9 Sep 2025 20:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450649; cv=none; b=q4BfYi8T1WkBlO+q3GXsof+zv72ZNHrj8y3tyLKxFekw0R6pG+sNGd7vt1WwrxD+n2ECREXUkiZxwrgzp8eCtuijbX5S/urWQwZCXhl/V6AzYXjsj/YtW99QDnaeMPG41D3RTJzWGjiE6Hdb6xUu485i2ZXT5eDx8+UnfbP1QAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450649; c=relaxed/simple;
	bh=SFo3P+DFPQ/PbtARAg0L61NmxcdgAaF5r71CrGjFQLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fa+TmOIUwlYLEnFTXY3RUj3Gx/SHex5O8WvCxtDNBn5itrJJK1BfOPqR2S3EsqOcGgMgVFBXrh2vGXc858WWtAqJkvnxph+nU6zxI8l7Q1XkPg7QaX1v2IGTyldSGVwjxOZcB3NVS0W+XyFkVZl4to8Kr0yqYaNwSo7qNORveSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ps5b0S0u; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D6A9240B0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1757450647; bh=rDpxipI8EI5OEDh5p749/x1weU3Phuf2YfP4ttB8VO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ps5b0S0uBIfuXkU3GkwZiRn57a0m9kRolwbpKaAoSK8vHJBysyld3IugS/t1z1nH1
	 CdEZrEqVmXhgEAXPU3Qi6++1qUcPMaY0Nqrrz8R9ZNzMedit40+Pc/dEdZV5joWJ8t
	 VV7gwZWEs122xvLMEyyqjGMeo+PPs4+9SpYf4X+tiZODSiSJrBUa9D3aU5Kio1QZIN
	 4Y5Bf82LLQOLgODBURuXYV/o+rKLeOXa+S1yfk/orEl+BN8VyT06BOeKrVtDJjEaGI
	 9qnrJrXuyZ3YlwLb7aVfIdmocNvUxrk7S07oVk/pbLUhRWJ581u6LcYYXrTvVO3CJU
	 3MCFvl3WyBk6Q==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D6A9240B0A;
	Tue,  9 Sep 2025 20:44:06 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/13] docs: kdoc: tighten up the push_parameter() no-type case
Date: Tue,  9 Sep 2025 14:43:38 -0600
Message-ID: <20250909204349.123680-3-corbet@lwn.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909204349.123680-1-corbet@lwn.net>
References: <20250909204349.123680-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The handling of untyped parameters involved a number of redundant tests;
restructure the code to remove them and be more compact.

No output changes.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 44 +++++++++++++++------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index a90f77d6b669..2118c20b3056 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -423,30 +423,26 @@ class KernelDoc:
 
         param = KernRe(r'[\[\)].*').sub('', param, count=1)
 
-        if dtype == "" and param.endswith("..."):
-            if KernRe(r'\w\.\.\.$').search(param):
-                # For named variable parameters of the form `x...`,
-                # remove the dots
-                param = param[:-3]
-            else:
-                # Handles unnamed variable parameters
-                param = "..."
-
-            if param not in self.entry.parameterdescs or \
-                not self.entry.parameterdescs[param]:
-
-                self.entry.parameterdescs[param] = "variable arguments"
-
-        elif dtype == "" and (not param or param == "void"):
-            param = "void"
-            self.entry.parameterdescs[param] = "no arguments"
-
-        elif dtype == "" and param in ["struct", "union"]:
-            # Handle unnamed (anonymous) union or struct
-            dtype = param
-            param = "{unnamed_" + param + "}"
-            self.entry.parameterdescs[param] = "anonymous\n"
-            self.entry.anon_struct_union = True
+        #
+        # Look at various "anonymous type" cases.
+        #
+        if dtype == '':
+            if param.endswith("..."):
+                if len(param) > 3: # there is a name provided, use that
+                    param = param[:-3]
+                if not self.entry.parameterdescs.get(param):
+                    self.entry.parameterdescs[param] = "variable arguments"
+
+            elif (not param) or param == "void":
+                param = "void"
+                self.entry.parameterdescs[param] = "no arguments"
+
+            elif param in ["struct", "union"]:
+                # Handle unnamed (anonymous) union or struct
+                dtype = param
+                param = "{unnamed_" + param + "}"
+                self.entry.parameterdescs[param] = "anonymous\n"
+                self.entry.anon_struct_union = True
 
         # Warn if parameter has no description
         # (but ignore ones starting with # as these are not parameters
-- 
2.51.0


