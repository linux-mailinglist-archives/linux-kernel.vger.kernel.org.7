Return-Path: <linux-kernel+bounces-849748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB937BD0CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65FE44E2B46
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D06B23D7EC;
	Sun, 12 Oct 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oSKmYwHf"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654931A5BA2
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304269; cv=none; b=ZzqKiSGChfRMoIIXFV9xtqU2GBsD6gVLLt1F162NgcHTSiCFhX87ksjq6Ly6CamZ8Sqf4eU98bX+1LYJB4l64RcoId2Jxb2GUqMgR5K8xOYdHDC6TG5odpEVzYMk9nUbQqmA6eisaw7aIq0qLGnJ3CnQQ9Pg7DPuqegl7cYec9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304269; c=relaxed/simple;
	bh=mX/hl98PUS0ab9cB7TcvhKPHENndP8MazQbLOij4Aow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sy1e3Af45minY6Je7T5X6gmeuGbkzN9o195kPcxn36Rb6rBSDXHrxlxWsganZuC/9DAxUH7AQfh/mCSq3AIXRMuaWub7xg/afNgPWC69uT7Kh3TQQ3f5gYqRnwVukaDlqkb/BiaaC64OinR2Rht3wjL45gb3NDp8fpRhbEQc7Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oSKmYwHf; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNiDE729JY73QUQVdhCZ0AfYtP+HlTQfQJFdiqUEqdU=;
	b=oSKmYwHf4CBk5a2AVp34iRvshjTH6CccZBByednp0UQp9LfWB58QlaCoWIqOcbwlYLL3JV
	AaUs/WbAJj/VYxYW0sE/Tg1lYoz9VwuPn/iaw5IRO64vHW98ZUWSm24KS3dUkGbrW65kJk
	nhx2A4Y59mj7/K+Yle6/VZiKbM3CqSM=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 1/8] closures: Improve closure_put_after_sub_checks
Date: Sun, 12 Oct 2025 17:24:04 -0400
Message-ID: <20251012212414.3225948-2-kent.overstreet@linux.dev>
In-Reply-To: <20251012212414.3225948-1-kent.overstreet@linux.dev>
References: <20251012212414.3225948-1-kent.overstreet@linux.dev>
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


