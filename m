Return-Path: <linux-kernel+bounces-841906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ED6BB8818
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 04:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B6A24C1A0D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 02:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017B427A454;
	Sat,  4 Oct 2025 02:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E/nK76lx"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A55279795
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543260; cv=none; b=r2scBZBmFAiyfST5pI5WobYvXaJYDDcI5QbF1/Zizs255bSTXFdBLJj/OCnxJQF3Afpw3k3oOBxqPl2+Kz2QO753vozdUsf/tdY9uPFuWfe8Yc9Tw/rbjpW0j8jH3Y0YEKGOBS2F8K1MmoT4/wcDojZY2tpzV4eI60Qv0la/7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543260; c=relaxed/simple;
	bh=mX/hl98PUS0ab9cB7TcvhKPHENndP8MazQbLOij4Aow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GylRtq1oNlh4OkWjwqCeje7qcTWgizmaYyuRfJLL4+n03nn4OOHQ5bnokYkjNAtmu9/n0EF0LCv1sOWivBSP2e/0BocFBj8r/q9aUHr3NvhUJmExEr0oRcSVvklMcMHkLCqOvCA1BZ5CgKf9EZwA1l/O7EGOaWewUIz5MdYKCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E/nK76lx; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759543256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNiDE729JY73QUQVdhCZ0AfYtP+HlTQfQJFdiqUEqdU=;
	b=E/nK76lxKVMBQP5lTMI2VwWJh+519PtOq1e6fe5xk2VX+QarDptYSf0TFEL8O6oN21RwL3
	X2RpMGtTYYUG2MgmjlFEKKmWKcVU6XyMfGtNX62AKm/moByRsuGCHPHc33e+Jclai37rOF
	dUsEMrM/Mwsm7OHn6tGOyyJuxVLOq+k=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 1/7] closures: Improve closure_put_after_sub_checks
Date: Fri,  3 Oct 2025 22:00:43 -0400
Message-ID: <20251004020049.918665-2-kent.overstreet@linux.dev>
In-Reply-To: <20251004020049.918665-1-kent.overstreet@linux.dev>
References: <20251004020049.918665-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add a guard bit for CLOSURE_DESTRUCTOR underflow, print the full
cl->remaining value, and rename variables for clarity.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/closure.h |  2 +-
 lib/closure.c           | 28 +++++++++++++++-------------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index 880fe85e35e9..a6fcc33fafce 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -135,7 +135,7 @@ enum closure_state {
 };
 
 #define CLOSURE_GUARD_MASK					\
-	((CLOSURE_DESTRUCTOR|CLOSURE_WAITING|CLOSURE_RUNNING) << 1)
+	(((CLOSURE_DESTRUCTOR|CLOSURE_WAITING|CLOSURE_RUNNING) << 1)|(CLOSURE_BITS_START >> 1))
 
 #define CLOSURE_REMAINING_MASK		(CLOSURE_BITS_START - 1)
 #define CLOSURE_REMAINING_INITIALIZER	(1|CLOSURE_RUNNING)
diff --git a/lib/closure.c b/lib/closure.c
index 2bfe7d2a0048..5fafc8b0e99d 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -13,23 +13,25 @@
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-static inline void closure_put_after_sub_checks(int flags)
+static void closure_val_checks(struct closure *cl, unsigned new)
 {
-	int r = flags & CLOSURE_REMAINING_MASK;
-
-	if (WARN(flags & CLOSURE_GUARD_MASK,
-		 "closure has guard bits set: %x (%u)",
-		 flags & CLOSURE_GUARD_MASK, (unsigned) __fls(r)))
-		r &= ~CLOSURE_GUARD_MASK;
-
-	WARN(!r && (flags & ~CLOSURE_DESTRUCTOR),
-	     "closure ref hit 0 with incorrect flags set: %x (%u)",
-	     flags & ~CLOSURE_DESTRUCTOR, (unsigned) __fls(flags));
+	unsigned count = new & CLOSURE_REMAINING_MASK;
+
+	if (WARN(new & CLOSURE_GUARD_MASK,
+		 "closure %ps has guard bits set: %x (%u)",
+		 cl->fn,
+		 new, (unsigned) __fls(new & CLOSURE_GUARD_MASK)))
+		new &= ~CLOSURE_GUARD_MASK;
+
+	WARN(!count && (new & ~CLOSURE_DESTRUCTOR),
+	     "closure %ps ref hit 0 with incorrect flags set: %x (%u)",
+	     cl->fn,
+	     new, (unsigned) __fls(new));
 }
 
 static inline void closure_put_after_sub(struct closure *cl, int flags)
 {
-	closure_put_after_sub_checks(flags);
+	closure_val_checks(cl, flags);
 
 	if (!(flags & CLOSURE_REMAINING_MASK)) {
 		smp_acquire__after_ctrl_dep();
@@ -167,7 +169,7 @@ void __sched closure_return_sync(struct closure *cl)
 	unsigned flags = atomic_sub_return_release(1 + CLOSURE_RUNNING - CLOSURE_DESTRUCTOR,
 						   &cl->remaining);
 
-	closure_put_after_sub_checks(flags);
+	closure_val_checks(cl, flags);
 
 	if (unlikely(flags & CLOSURE_REMAINING_MASK)) {
 		while (1) {
-- 
2.51.0


