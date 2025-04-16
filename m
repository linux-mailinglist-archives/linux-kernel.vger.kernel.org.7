Return-Path: <linux-kernel+bounces-607649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A18AA9090B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 18:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA185A3AD6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 16:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8746F21ADD6;
	Wed, 16 Apr 2025 16:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rpq7mQy+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EQFskdHA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C1217657
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744820974; cv=none; b=S+WzAbnla0mJzPsy6s7ZSuu67J97i3t/C6NvT5KS42KomuC/0xU/yNl4kCOaietgfHWocWTO8Usg+GfDNiVO8b+He28pRPx8XdOgzG9ooODlZhCERD716Y3gnVMyLvqq8bBbFjphMFT0u5GmvRKOMwi5Uy+S9oC9HKMxlMFyBAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744820974; c=relaxed/simple;
	bh=1wEU3kqWniX4oeLgQyszFiXMvT6lV0eU4OnN68ez7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+AxsXK58liiqoC0WJ88TR5s0uWlFiLgUEkuxcKPEfWd9Vr+19L25KUQIy/QtFSs//hzq8QI4yBxkA7bM01kwdVtHWvXHL6qVhcTn1a0fcQP9CWOhhcgk1biGYZDgk3hGcOdBFzbXxgXfR3vssQD0bkq4fX6xC4oJV8pQMLW9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rpq7mQy+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EQFskdHA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744820970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHrIMWrBknhDvpUrvZqL2/sWbWTxrgQvEOQEnBSnNUI=;
	b=rpq7mQy+FNjD250HeJIsiGVEwU6Ppgm6SaiD5cssohBe22fkDVoQaN7Ctf6kQ3hpZxeaVp
	P0bZZOTbmn1yzB9fESL6iSgCBFjycjWC2Xd/XYCQXVbD9GsKiAy5fD+4WQEQP9C2IYvTVE
	yNxkEXVAt2a3zT6UweLywPwNQvCWiaHbGihRLX5huSFyDkmF5jIxmqMIhHMgdnbGYKooBp
	6uC5I5exjgxaUI9+mDIFD6HpVAeePX+d9I6ivNVde/LWlsV5pGU7D8sTj6A1xoHrf4baSr
	tv7QAI8akRCufofyNzbrolceQnXKnjunOcZBw7l3U00/TW5t4FB5zr8wY5JfKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744820970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MHrIMWrBknhDvpUrvZqL2/sWbWTxrgQvEOQEnBSnNUI=;
	b=EQFskdHAnM/Mepfx+GilASw8dX/aCyIdUdA7ytOii8lBcXJfZnqO8xtBcRknUssEZiFs3C
	3tR9x7DL7/k+8GBQ==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v12 10/21] futex: Introduce futex_q_lockptr_lock()
Date: Wed, 16 Apr 2025 18:29:10 +0200
Message-ID: <20250416162921.513656-11-bigeasy@linutronix.de>
In-Reply-To: <20250416162921.513656-1-bigeasy@linutronix.de>
References: <20250416162921.513656-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_lock_pi() and __fixup_pi_state_owner() acquire the
futex_q::lock_ptr without holding a reference assuming the previously
obtained hash bucket and the assigned lock_ptr are still valid. This
isn't the case once the private hash can be resized and becomes invalid
after the reference drop.

Introduce futex_q_lockptr_lock() to lock the hash bucket recorded in
futex_q::lock_ptr. The lock pointer is read in a RCU section to ensure
that it does not go away if the hash bucket has been replaced and the
old pointer has been observed. After locking the pointer needs to be
compared to check if it changed. If so then the hash bucket has been
replaced and the user has been moved to the new one and lock_ptr has
been updated. The lock operation needs to be redone in this case.

The locked hash bucket is not returned.

A special case is an early return in futex_lock_pi() (due to signal or
timeout) and a successful futex_wait_requeue_pi(). In both cases a valid
futex_q::lock_ptr is expected (and its matching hash bucket) but since
the waiter has been removed from the hash this can no longer be
guaranteed. Therefore before the waiter is removed and a reference is
acquired which is later dropped by the waiter to avoid a resize.

Add futex_q_lockptr_lock() and use it.
Acquire an additional reference in requeue_pi_wake_futex() and
futex_unlock_pi() while the futex_q is removed, denote this extra
reference in futex_q::drop_hb_ref and let the waiter drop the reference
in this case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c    | 25 +++++++++++++++++++++++++
 kernel/futex/futex.h   |  3 ++-
 kernel/futex/pi.c      | 15 +++++++++++++--
 kernel/futex/requeue.c | 16 +++++++++++++---
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 5e70cb8eb2507..1443a98dfa7fa 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -134,6 +134,13 @@ struct futex_hash_bucket *futex_hash(union futex_key *=
key)
 	return &futex_queues[hash & futex_hashmask];
 }
=20
+/**
+ * futex_hash_get - Get an additional reference for the local hash.
+ * @hb:                    ptr to the private local hash.
+ *
+ * Obtain an additional reference for the already obtained hash bucket. The
+ * caller must already own an reference.
+ */
 void futex_hash_get(struct futex_hash_bucket *hb) { }
 void futex_hash_put(struct futex_hash_bucket *hb) { }
=20
@@ -615,6 +622,24 @@ int futex_unqueue(struct futex_q *q)
 	return ret;
 }
=20
+void futex_q_lockptr_lock(struct futex_q *q)
+{
+	spinlock_t *lock_ptr;
+
+	/*
+	 * See futex_unqueue() why lock_ptr can change.
+	 */
+	guard(rcu)();
+retry:
+	lock_ptr =3D READ_ONCE(q->lock_ptr);
+	spin_lock(lock_ptr);
+
+	if (unlikely(lock_ptr !=3D q->lock_ptr)) {
+		spin_unlock(lock_ptr);
+		goto retry;
+	}
+}
+
 /*
  * PI futexes can not be requeued and must remove themselves from the hash
  * bucket. The hash bucket lock (i.e. lock_ptr) is held.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index bc76e366f9a77..26e69333cb745 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -183,6 +183,7 @@ struct futex_q {
 	union futex_key *requeue_pi_key;
 	u32 bitset;
 	atomic_t requeue_state;
+	bool drop_hb_ref;
 #ifdef CONFIG_PREEMPT_RT
 	struct rcuwait requeue_wait;
 #endif
@@ -197,7 +198,7 @@ enum futex_access {
=20
 extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union fute=
x_key *key,
 			 enum futex_access rw);
-
+extern void futex_q_lockptr_lock(struct futex_q *q);
 extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index e52f540e81b6a..dacb2330f1fbc 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -806,7 +806,7 @@ static int __fixup_pi_state_owner(u32 __user *uaddr, st=
ruct futex_q *q,
 		break;
 	}
=20
-	spin_lock(q->lock_ptr);
+	futex_q_lockptr_lock(q);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
=20
 	/*
@@ -1072,7 +1072,7 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fla=
gs, ktime_t *time, int tryl
 		 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
 		 * the
 		 */
-		spin_lock(q.lock_ptr);
+		futex_q_lockptr_lock(&q);
 		/*
 		 * Waiter is unqueued.
 		 */
@@ -1092,6 +1092,11 @@ int futex_lock_pi(u32 __user *uaddr, unsigned int fl=
ags, ktime_t *time, int tryl
=20
 		futex_unqueue_pi(&q);
 		spin_unlock(q.lock_ptr);
+		if (q.drop_hb_ref) {
+			CLASS(hb, hb)(&q.key);
+			/* Additional reference from futex_unlock_pi() */
+			futex_hash_put(hb);
+		}
 		goto out;
=20
 out_unlock_put_key:
@@ -1200,6 +1205,12 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int =
flags)
 		 */
 		rt_waiter =3D rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
+			/*
+			 * Acquire a reference for the leaving waiter to ensure
+			 * valid futex_q::lock_ptr.
+			 */
+			futex_hash_get(hb);
+			top_waiter->drop_hb_ref =3D true;
 			__futex_unqueue(top_waiter);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			goto retry_hb;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 023c028d2fce3..b0e64fd454d96 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -231,7 +231,12 @@ void requeue_pi_wake_futex(struct futex_q *q, union fu=
tex_key *key,
=20
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter =3D NULL;
-
+	/*
+	 * Acquire a reference for the waiter to ensure valid
+	 * futex_q::lock_ptr.
+	 */
+	futex_hash_get(hb);
+	q->drop_hb_ref =3D true;
 	q->lock_ptr =3D &hb->lock;
=20
 	/* Signal locked state to the waiter */
@@ -826,7 +831,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 	case Q_REQUEUE_PI_LOCKED:
 		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner !=3D current)) {
-			spin_lock(q.lock_ptr);
+			futex_q_lockptr_lock(&q);
 			ret =3D fixup_pi_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which the
@@ -853,7 +858,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned i=
nt flags,
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret =3D 0;
=20
-		spin_lock(q.lock_ptr);
+		futex_q_lockptr_lock(&q);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
@@ -885,6 +890,11 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned =
int flags,
 	default:
 		BUG();
 	}
+	if (q.drop_hb_ref) {
+		CLASS(hb, hb)(&q.key);
+		/* Additional reference from requeue_pi_wake_futex() */
+		futex_hash_put(hb);
+	}
=20
 out:
 	if (to) {
--=20
2.49.0


