Return-Path: <linux-kernel+bounces-849750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2DCBD0CA7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 23:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD5934E4B5F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 21:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426BF2459E7;
	Sun, 12 Oct 2025 21:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jGF/byNR"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FF6235041
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760304270; cv=none; b=BKi1joPoBDHcaCqApNr7W0mFPY47TMTdL1hDfBd1yG7D3MqpWiYAQAQx85d7PNWwpfkGzDK1F1b7HCkEQMITmQEXREOHhmJZgsKFthdx7MH3saYh55UHlCWSpfI2EznvGGx/kFxRK94inXU/F7JNsmuqlZNaM4uLGhC8Z+irT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760304270; c=relaxed/simple;
	bh=3FHL8eEuvGz/X2WWUy2G3HLnzD6gSjidjDrX08OPteg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVzZelN3kVtWJOmRMKjquSKwxvIyj3s/HoyxCTCzpfHMqIkXNsxLA8QmzeQe/+mRqjZm7RJUGDt2KijQJJXWNXq9UYGZcwdRTiTa8V5AzTWnKs7xMTk30qjoGSGH6DEHtEoCt0iqNzkIzT/PW92YeuMJsYTr4whNlBXHLyT6iXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jGF/byNR; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760304266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ruc5ohiAFaPupk6sasT1+CEuUEGK2Z9wdZI/6H5//wk=;
	b=jGF/byNRiAB1RuuKPNtPa0YRSHYEjKHyOgcJ1lta5yPs1NjayGk60XF7RmsQrjAuRqVbgG
	KIbn+t6YqXlXmzrQzQdbL9iLcPIRUOvIqOafY37EVlzXe+ZzthcIY+QS1bJshZ4UTdLwKo
	Bkc+f5XtrRs5cfaMDOlV50tQ5BhXa2s=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v2 3/8] closures: CLOSURE_SLEEPING
Date: Sun, 12 Oct 2025 17:24:06 -0400
Message-ID: <20251012212414.3225948-4-kent.overstreet@linux.dev>
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

Part two of fixing __closure_sync_timeout().

Add a bit in cl->remaining (protected by cmpxchg()) for indicating
whether a closure has a sleeper that should be woken up after the final
put; we can now read the pointer to the waiting task_struct before the
final put

This elimating accesses to another thread's closure after the final put,
which are racy because it may be unwinding after the timeout elapses.

Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/closure.h |   9 +--
 lib/closure.c           | 118 +++++++++++++++++++---------------------
 2 files changed, 62 insertions(+), 65 deletions(-)

diff --git a/include/linux/closure.h b/include/linux/closure.h
index f626044d6ca2..d0195570514a 100644
--- a/include/linux/closure.h
+++ b/include/linux/closure.h
@@ -128,14 +128,15 @@ enum closure_state {
 	 * annotate where references are being transferred.
 	 */
 
-	CLOSURE_BITS_START	= (1U << 26),
-	CLOSURE_DESTRUCTOR	= (1U << 26),
+	CLOSURE_BITS_START	= (1U << 24),
+	CLOSURE_DESTRUCTOR	= (1U << 24),
+	CLOSURE_SLEEPING	= (1U << 26),
 	CLOSURE_WAITING		= (1U << 28),
 	CLOSURE_RUNNING		= (1U << 30),
 };
 
 #define CLOSURE_GUARD_MASK					\
-	(((CLOSURE_DESTRUCTOR|CLOSURE_WAITING|CLOSURE_RUNNING) << 1)|(CLOSURE_BITS_START >> 1))
+	(((CLOSURE_DESTRUCTOR|CLOSURE_SLEEPING|CLOSURE_WAITING|CLOSURE_RUNNING) << 1)|(CLOSURE_BITS_START >> 1))
 
 #define CLOSURE_REMAINING_MASK		(CLOSURE_BITS_START - 1)
 #define CLOSURE_REMAINING_INITIALIZER	(1|CLOSURE_RUNNING)
@@ -144,7 +145,7 @@ struct closure {
 	union {
 		struct {
 			struct workqueue_struct *wq;
-			struct closure_syncer	*s;
+			struct task_struct	*sleeper;
 			struct llist_node	list;
 			closure_fn		*fn;
 		};
diff --git a/lib/closure.c b/lib/closure.c
index 21fadd12093c..c49d49916788 100644
--- a/lib/closure.c
+++ b/lib/closure.c
@@ -23,7 +23,7 @@ static void closure_val_checks(struct closure *cl, unsigned new, int d)
 		 new, (unsigned) __fls(new & CLOSURE_GUARD_MASK), d))
 		new &= ~CLOSURE_GUARD_MASK;
 
-	WARN(!count && (new & ~CLOSURE_DESTRUCTOR),
+	WARN(!count && (new & ~(CLOSURE_DESTRUCTOR|CLOSURE_SLEEPING)),
 	     "closure %ps ref hit 0 with incorrect flags set: %x (%u)",
 	     cl->fn,
 	     new, (unsigned) __fls(new));
@@ -39,19 +39,27 @@ enum new_closure_state {
 void closure_sub(struct closure *cl, int v)
 {
 	enum new_closure_state s;
+	struct task_struct *sleeper;
 
-	int old = atomic_read(&cl->remaining), new;
+	/* rcu_read_lock, atomic_read_acquire() are both for cl->sleeper: */
+	guard(rcu)();
+
+	int old = atomic_read_acquire(&cl->remaining), new;
 	do {
 		new = old - v;
 
 		if (new & CLOSURE_REMAINING_MASK) {
 			s = CLOSURE_normal_put;
 		} else {
-			if (cl->fn && !(new & CLOSURE_DESTRUCTOR)) {
+			if ((cl->fn || (new & CLOSURE_SLEEPING)) &&
+			    !(new & CLOSURE_DESTRUCTOR)) {
 				s = CLOSURE_requeue;
 				new += CLOSURE_REMAINING_INITIALIZER;
 			} else
 				s = CLOSURE_done;
+
+			sleeper = new & CLOSURE_SLEEPING ? cl->sleeper : NULL;
+			new &= ~CLOSURE_SLEEPING;
 		}
 
 		closure_val_checks(cl, new, -v);
@@ -60,6 +68,12 @@ void closure_sub(struct closure *cl, int v)
 	if (s == CLOSURE_normal_put)
 		return;
 
+	if (sleeper) {
+		smp_mb();
+		wake_up_process(sleeper);
+		return;
+	}
+
 	if (s == CLOSURE_requeue) {
 		cl->closure_get_happened = false;
 		closure_queue(cl);
@@ -114,41 +128,25 @@ bool closure_wait(struct closure_waitlist *waitlist, struct closure *cl)
 
 	cl->closure_get_happened = true;
 	closure_set_waiting(cl, _RET_IP_);
-	atomic_add(CLOSURE_WAITING + 1, &cl->remaining);
+	unsigned r = atomic_add_return(CLOSURE_WAITING + 1, &cl->remaining);
+	closure_val_checks(cl, r, CLOSURE_WAITING + 1);
+
 	llist_add(&cl->list, &waitlist->list);
 
 	return true;
 }
 EXPORT_SYMBOL(closure_wait);
 
-struct closure_syncer {
-	struct task_struct	*task;
-	int			done;
-};
-
-static CLOSURE_CALLBACK(closure_sync_fn)
-{
-	struct closure *cl = container_of(ws, struct closure, work);
-	struct closure_syncer *s = cl->s;
-	struct task_struct *p;
-
-	rcu_read_lock();
-	p = READ_ONCE(s->task);
-	s->done = 1;
-	wake_up_process(p);
-	rcu_read_unlock();
-}
-
 void __sched __closure_sync(struct closure *cl)
 {
-	struct closure_syncer s = { .task = current };
-
-	cl->s = &s;
-	continue_at(cl, closure_sync_fn, NULL);
+	cl->sleeper = current;
+	closure_sub(cl,
+		    CLOSURE_REMAINING_INITIALIZER -
+		    CLOSURE_SLEEPING);
 
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (s.done)
+		if (!(atomic_read(&cl->remaining) & CLOSURE_SLEEPING))
 			break;
 		schedule();
 	}
@@ -162,31 +160,25 @@ EXPORT_SYMBOL(__closure_sync);
  * for outstanding get()s to finish) and returning once closure refcount is 0.
  *
  * Unlike closure_sync() this doesn't reinit the ref to 1; subsequent
- * closure_get_not_zero() calls waill fail.
+ * closure_get_not_zero() calls will fail.
  */
 void __sched closure_return_sync(struct closure *cl)
 {
-	struct closure_syncer s = { .task = current };
-
-	cl->s = &s;
-	set_closure_fn(cl, closure_sync_fn, NULL);
-
-	unsigned flags = atomic_sub_return_release(1 + CLOSURE_RUNNING - CLOSURE_DESTRUCTOR,
-						   &cl->remaining);
+	cl->sleeper = current;
+	closure_sub(cl,
+		    CLOSURE_REMAINING_INITIALIZER -
+		    CLOSURE_DESTRUCTOR -
+		    CLOSURE_SLEEPING);
 
-	closure_val_checks(cl, flags, 1 + CLOSURE_RUNNING - CLOSURE_DESTRUCTOR);
-
-	if (unlikely(flags & CLOSURE_REMAINING_MASK)) {
-		while (1) {
-			set_current_state(TASK_UNINTERRUPTIBLE);
-			if (s.done)
-				break;
-			schedule();
-		}
-
-		__set_current_state(TASK_RUNNING);
+	while (1) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		if (!(atomic_read(&cl->remaining) & CLOSURE_SLEEPING))
+			break;
+		schedule();
 	}
 
+	__set_current_state(TASK_RUNNING);
+
 	if (cl->parent)
 		closure_put(cl->parent);
 }
@@ -194,31 +186,35 @@ EXPORT_SYMBOL(closure_return_sync);
 
 int __sched __closure_sync_timeout(struct closure *cl, unsigned long timeout)
 {
-	struct closure_syncer s = { .task = current };
 	int ret = 0;
 
-	cl->s = &s;
-	continue_at(cl, closure_sync_fn, NULL);
+	cl->sleeper = current;
+	closure_sub(cl,
+		    CLOSURE_REMAINING_INITIALIZER -
+		    CLOSURE_SLEEPING);
 
 	while (1) {
 		set_current_state(TASK_UNINTERRUPTIBLE);
-		if (s.done)
-			break;
+		/*
+		 * Carefully undo the continue_at() - but only if it
+		 * hasn't completed, i.e. the final closure_put() hasn't
+		 * happened yet:
+		 */
+		unsigned old = atomic_read(&cl->remaining), new;
+		if (!(old & CLOSURE_SLEEPING))
+			goto success;
+
 		if (!timeout) {
-			/*
-			 * Carefully undo the continue_at() - but only if it
-			 * hasn't completed, i.e. the final closure_put() hasn't
-			 * happened yet:
-			 */
-			unsigned old, new, v = atomic_read(&cl->remaining);
 			do {
-				old = v;
-				if (!old || (old & CLOSURE_RUNNING))
+				if (!(old & CLOSURE_SLEEPING))
 					goto success;
 
-				new = old + CLOSURE_REMAINING_INITIALIZER;
-			} while ((v = atomic_cmpxchg(&cl->remaining, old, new)) != old);
+				new = old + CLOSURE_REMAINING_INITIALIZER - CLOSURE_SLEEPING;
+				closure_val_checks(cl, new, CLOSURE_REMAINING_INITIALIZER - CLOSURE_SLEEPING);
+			} while (!atomic_try_cmpxchg(&cl->remaining, &old, new));
+
 			ret = -ETIME;
+			break;
 		}
 
 		timeout = schedule_timeout(timeout);
-- 
2.51.0


