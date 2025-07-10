Return-Path: <linux-kernel+bounces-726634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26FCB00FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00D941CA7D93
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66C2E5B1B;
	Thu, 10 Jul 2025 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="naJMHLFD"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85C1FF1C4;
	Thu, 10 Jul 2025 23:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190315; cv=none; b=azY1EBITw5ENnbUcylVuZ1DP6vaOdLOoK3Gw5rdx3RnnUWBql+j4J8KG95b6q/HZJWyTxAf0Xxl/c5SBJEr5aUZheQ45G/NFHETjBPl6HvSoi7WaJa0lQQPFUtVy0Ta2z4MTtQW8x8KHDjQF5JgX2xvlnbjTbhr/HGcegt4dOGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190315; c=relaxed/simple;
	bh=SKv7WuVd34Kw+59dLBPWsq0YXFvKu18KsiExoJYXPeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl7D9scxwM6tYec8MBpByTisTuz1Ki/xYlsVgnXcNcmx3k/OCtrIWruXVu8AzReE1CPk9dzNjBU1UUuHfTgcajqEO9Y5K7hiaJfAIXe3ibWl8+wn5+4rv12DUcB8G0ml0jdnrFuqoqT2bXrtk/oKjV1JGzjWDfGCMQ2Bq9cEa+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=naJMHLFD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7167540AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752190313; bh=XyiS4t2j2GRbyuM73we2cc8sYm2VrL8GXB9npdvoq8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=naJMHLFDr9O/pzTUo2Tw8NVGXjWwFMNHzs1coXfdlrRQREnvHFZqHEvlqm0CqoN7P
	 R5JiAEqTzdQy3wzB3SzTlZ7LwnnYYcxV2wa9U5ba1GzmNiSGfgwUAtnNAMzNHBOcVB
	 G0HsFSkG3mMBN71aBkhQmWJVGhCo5HxVdIrAMREy+x6WL9lsN6KdrcqOBU90W9AuBQ
	 xGpuT3676nK4LTw0QWM03JI0Q4ENswVOFPo0CkMm4I6CmW7YmmlbzNF+0J/6r2rCit
	 GfrtIlovpqoGkuQ+roUREqA2KOdAEdHG/oCCSn3B+ZB32L6X6BrPVaILPeDJUxVPcc
	 96PlyIJkBsbXw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 7167540AD8;
	Thu, 10 Jul 2025 23:31:53 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 02/12] docs: kdoc: simplify the output-item passing
Date: Thu, 10 Jul 2025 17:31:32 -0600
Message-ID: <20250710233142.246524-3-corbet@lwn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250710233142.246524-1-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since our output items contain their name, we don't need to pass it
separately.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_files.py  | 4 ++--
 scripts/lib/kdoc/kdoc_parser.py | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 9be4a64df71d..9e09b45b02fa 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -275,8 +275,8 @@ class KernelFiles():
                 self.config.log.warning("No kernel-doc for file %s", fname)
                 continue
 
-            for name, arg in self.results[fname]:
-                m = self.out_msg(fname, name, arg)
+            for arg in self.results[fname]:
+                m = self.out_msg(fname, arg.name, arg)
 
                 if m is None:
                     ln = arg.get("ln", 0)
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index a5a59b97a444..97380ff30a0d 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -284,7 +284,7 @@ class KernelDoc:
                 del sections[section]
                 sectionlist.remove(section)
 
-        self.entries.append((name, item))
+        self.entries.append(item)
 
         self.config.log.debug("Output: %s:%s = %s", dtype, name, pformat(args))
 
-- 
2.49.0


