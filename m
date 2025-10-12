Return-Path: <linux-kernel+bounces-849749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F6ABD0CA4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29DC818917F2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E811E242D97;
	Sun, 12 Oct 2025 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JQn4VLWn"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBB622CBD9
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304270; cv=none; b=dSYPNQzagMsKZ5dkMevrW9OtXhiYu9OiudLNslP7k54+W2TIPpw3sV8SmFn0ufGbkccaSsAtn9g6j1eERNkVjX5bbIr+hQzFfAq+Zf5Fa19Q0wMCALIfsjE8xAbbzwVN0kwp6bgOqy8DEWC4ZPdTjXqLezUfqnbQxlvhBpdCpks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304270; c=relaxed/simple;
	bh=KoAm2saD7kfuW5yN0J71ngCyAbYwzOe7QtEeq809yes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYkQ1eR9hDRrjUP2i1GG+zh6kGt+VbhINO9Sbvi+2cbi3o/GqiPC6LOOuEFHyYZNTPRG7/WAKYAOFyAJ2nTZbb4p5unJR2Lx1ICXq15RRTayZjBnSUtl+oc6zDIeMngQm3nISVytZM6kL6HAw7GQmy7g6Czh7Ml2VQX+8gX3fPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JQn4VLWn; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdLf9ksaW/ExPQ+mYz9EpqCEmK6bAhu602u9/qlr3zc=;
	b=JQn4VLWnVpFz8Xpp1qOSWwXycEZw+GAX15MLjbbKkpwigj3HfNYm4W1jCS0JHnAgliERU7
	v83jobdJsektZEhZWTOidCDac5DLd/aXFlsFEXHeCykTw+tcZDCBs4lfkHOs4HqgeUxDE7
	P/DSipg/bJldEfcDubpFVJpl7Asmt44=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 2/8] closures: closure_sub() uses cmpxchg
Date: Sun, 12 Oct 2025 17:24:05 -0400
Message-ID: <20251012212414.3225948-3-kent.overstreet@linux.dev>
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

Part one of fixing a race in __closure_sync_timeout().

lib/closure.c was initially designed with the assumption that refs only
hit 0 once, and when they hit 0 the thread that caused it to hit 0 now
owns it - which avoids many races without the need for cmpxchg.

But __closure_sync_timeout() broke this, because the timeout may elapse
and the thread doing the sync may race with the final put.

Switch to cmpxchg for manipulating cl->remaining; the next patch will
fix some issues with the other thread's closure_put() accessing
variables in struct closure after that final put.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/closure.h |  9 ++++-
 lib/closure.c           | 79 ++++++++++++++++++++++-------------------
 2 files changed, 50 insertions(+), 38 deletions(-)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index a6fcc33fafce..f626044d6ca2 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -169,11 +169,18 @@ struct closure {
 };
 
 void closure_sub(struct closure *cl, int v);
-void closure_put(struct closure *cl);
 void __closure_wake_up(struct closure_waitlist *list);
 bool closure_wait(struct closure_waitlist *list, struct closure *cl);
 void __closure_sync(struct closure *cl);
 
+/*
+ * closure_put - decrement a closure's refcount
+ */
+static inline void closure_put(struct closure *cl)
+{
+	closure_sub(cl, 1);
+}
+
 static inline unsigned closure_nr_remaining(struct closure *cl)
 {
 	return atomic_read(&cl->remaining) & CLOSURE_REMAINING_MASK;
diff --git a/lib/closure.c b/lib/closure.c
index 5fafc8b0e99d..21fadd12093c 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -13,14 +13,14 @@
 #include <linux/seq_file.h>
 #include <linux/sched/debug.h>
 
-static void closure_val_checks(struct closure *cl, unsigned new)
+static void closure_val_checks(struct closure *cl, unsigned new, int d)
 {
 	unsigned count = new & CLOSURE_REMAINING_MASK;
 
 	if (WARN(new & CLOSURE_GUARD_MASK,
-		 "closure %ps has guard bits set: %x (%u)",
+		 "closure %ps has guard bits set: %x (%u), delta %i",
 		 cl->fn,
-		 new, (unsigned) __fls(new & CLOSURE_GUARD_MASK)))
+		 new, (unsigned) __fls(new & CLOSURE_GUARD_MASK), d))
 		new &= ~CLOSURE_GUARD_MASK;
 
 	WARN(!count && (new & ~CLOSURE_DESTRUCTOR),
@@ -29,49 +29,54 @@ static void closure_val_checks(struct closure *cl, unsigned new)
 	     new, (unsigned) __fls(new));
 }
 
-static inline void closure_put_after_sub(struct closure *cl, int flags)
-{
-	closure_val_checks(cl, flags);
+enum new_closure_state {
+	CLOSURE_normal_put,
+	CLOSURE_requeue,
+	CLOSURE_done,
+};
 
-	if (!(flags & CLOSURE_REMAINING_MASK)) {
-		smp_acquire__after_ctrl_dep();
+/* For clearing flags with the same atomic op as a put */
+void closure_sub(struct closure *cl, int v)
+{
+	enum new_closure_state s;
 
-		cl->closure_get_happened = false;
+	int old = atomic_read(&cl->remaining), new;
+	do {
+		new = old - v;
 
-		if (cl->fn && !(flags & CLOSURE_DESTRUCTOR)) {
-			atomic_set(&cl->remaining,
-				   CLOSURE_REMAINING_INITIALIZER);
-			closure_queue(cl);
+		if (new & CLOSURE_REMAINING_MASK) {
+			s = CLOSURE_normal_put;
 		} else {
-			struct closure *parent = cl->parent;
-			closure_fn *destructor = cl->fn;
+			if (cl->fn && !(new & CLOSURE_DESTRUCTOR)) {
+				s = CLOSURE_requeue;
+				new += CLOSURE_REMAINING_INITIALIZER;
+			} else
+				s = CLOSURE_done;
+		}
 
-			closure_debug_destroy(cl);
+		closure_val_checks(cl, new, -v);
+	} while (!atomic_try_cmpxchg_release(&cl->remaining, &old, new));
 
-			if (destructor)
-				destructor(&cl->work);
+	if (s == CLOSURE_normal_put)
+		return;
 
-			if (parent)
-				closure_put(parent);
-		}
-	}
-}
+	if (s == CLOSURE_requeue) {
+		cl->closure_get_happened = false;
+		closure_queue(cl);
+	} else {
+		struct closure *parent = cl->parent;
+		closure_fn *destructor = cl->fn;
 
-/* For clearing flags with the same atomic op as a put */
-void closure_sub(struct closure *cl, int v)
-{
-	closure_put_after_sub(cl, atomic_sub_return_release(v, &cl->remaining));
-}
-EXPORT_SYMBOL(closure_sub);
+		closure_debug_destroy(cl);
 
-/*
- * closure_put - decrement a closure's refcount
- */
-void closure_put(struct closure *cl)
-{
-	closure_put_after_sub(cl, atomic_dec_return_release(&cl->remaining));
+		if (destructor)
+			destructor(&cl->work);
+
+		if (parent)
+			closure_put(parent);
+	}
 }
-EXPORT_SYMBOL(closure_put);
+EXPORT_SYMBOL(closure_sub);
 
 /*
  * closure_wake_up - wake up all closures on a wait list, without memory barrier
@@ -169,7 +174,7 @@ void __sched closure_return_sync(struct closure *cl)
 	unsigned flags = atomic_sub_return_release(1 + CLOSURE_RUNNING - CLOSURE_DESTRUCTOR,
 						   &cl->remaining);
 
-	closure_val_checks(cl, flags);
+	closure_val_checks(cl, flags, 1 + CLOSURE_RUNNING - CLOSURE_DESTRUCTOR);
 
 	if (unlikely(flags & CLOSURE_REMAINING_MASK)) {
 		while (1) {
-- 
2.51.0


