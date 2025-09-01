Return-Path: <linux-kernel+bounces-795057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2BDB3EC5D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F647A3544
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57153064BA;
	Mon,  1 Sep 2025 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="la4CeuZU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1odyhZO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A9A2EC09B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744698; cv=none; b=BAmjFd433Vnyt9Nm6LnbRKAa7yNVT7wQ7lTuN0YatNG3mC13WS4zpH/X641p2Mg7H3tkxGhGp0heDCmuoeNK4BKd7T5885pd7xS6FKBqLo+N7pN60cyh7UUSYKe7UV+Wn6oMBLyHALuKmKykw4APc7HWmdgmvb3JTYt/wFvQo/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744698; c=relaxed/simple;
	bh=pGIEPFpqD8aJXuWO8M8k8R4+XpO5MMzeNMBpiSL1EeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvjcTqaZ55lp8TUcsMrTXtqNGAQA28ln2Ch8HK2SK7xhnccRxUHFMTstJzZLIvpSyLFrBk19hZb/7ke4IV37NaAdl0q9EHIphbib0qKEcBNw8237TtmlAaEKY2caCaqBmrfWUPco+fJsU9qSHUrb3ZD56UmUVblUvfpRJYjwL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=la4CeuZU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1odyhZO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymF0vFVlA69uj5EXxsImbalEDu3PQoiy0nTiLc6jf3o=;
	b=la4CeuZUUc92TRevR56KZnJpxqhBUGgbV1cfL0FpkGbnAQBGEFmuixoO7Y4whQKN5tWCnp
	WxczrMtVIugFADB1dtoQaM83P6AOqRY2OBzbd8hCdOkYtSP8Dz+Uf1YEllBzL3fjriiykN
	cE+tBLhGnxgg1zxqXsDuceOE094szbjem5SA+9/D9ykguRDjP6J0PA/dZjjSYgGDKlfi9K
	IjulKYdmKOy3DbP3HL7BK9o+kn8+MQOGEchFip8OcFM8U2TkA9Dd3Gx4aTyyNVO6OivrZp
	Uzw2WeSb1eCR82jogl7pDeTuTmQCRG+r7Qr619pWMC362EaTV8noEi9khZxzDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymF0vFVlA69uj5EXxsImbalEDu3PQoiy0nTiLc6jf3o=;
	b=R1odyhZOBI6iI9xFGriL5sD/jN6R9hqg1yBTzABwCgqYVXtTOWfHVyXLUE/kpKOBlT3s3T
	emeFDdO+Qx3BuhAg==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH workers
Date: Mon,  1 Sep 2025 18:38:09 +0200
Message-ID: <20250901163811.963326-2-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-1-bigeasy@linutronix.de>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

While a BH work item is canceled, the core code spins until it
determines that the item completed. On PREEMPT_RT the spinning relies on
a lock in local_bh_disable() to avoid a live lock if the canceling
thread has higher priority than the BH-worker and preempts it. This lock
ensures that the BH-worker makes progress by PI-boosting it.

This lock in local_bh_disable() is a central per-CPU BKL and about to be
removed.

To provide the required synchronisation add a per pool lock. The lock is
acquired by the bh_worker at the begin while the individual callbacks
are invoked. To enforce progress in case of interruption, __flush_work()
needs to acquire the lock.
This will flush all BH-work items assigned to that pool.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c31..94e226f637992 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -222,7 +222,9 @@ struct worker_pool {
 	struct workqueue_attrs	*attrs;		/* I: worker attributes */
 	struct hlist_node	hash_node;	/* PL: unbound_pool_hash node */
 	int			refcnt;		/* PL: refcnt for unbound pools */
-
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		cb_lock;	/* BH worker cancel lock */
+#endif
 	/*
 	 * Destruction of pool is RCU protected to allow dereferences
 	 * from get_work_pool().
@@ -3078,6 +3080,31 @@ __acquires(&pool->lock)
 		goto restart;
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+static void worker_lock_callback(struct worker_pool *pool)
+{
+	spin_lock(&pool->cb_lock);
+}
+
+static void worker_unlock_callback(struct worker_pool *pool)
+{
+	spin_unlock(&pool->cb_lock);
+}
+
+static void workqueue_callback_cancel_wait_running(struct worker_pool *poo=
l)
+{
+	spin_lock(&pool->cb_lock);
+	spin_unlock(&pool->cb_lock);
+}
+
+#else
+
+static void worker_lock_callback(struct worker_pool *pool) { }
+static void worker_unlock_callback(struct worker_pool *pool) { }
+static void workqueue_callback_cancel_wait_running(struct worker_pool *poo=
l) { }
+
+#endif
+
 /**
  * manage_workers - manage worker pool
  * @worker: self
@@ -3557,6 +3584,7 @@ static void bh_worker(struct worker *worker)
 	int nr_restarts =3D BH_WORKER_RESTARTS;
 	unsigned long end =3D jiffies + BH_WORKER_JIFFIES;
=20
+	worker_lock_callback(pool);
 	raw_spin_lock_irq(&pool->lock);
 	worker_leave_idle(worker);
=20
@@ -3585,6 +3613,7 @@ static void bh_worker(struct worker *worker)
 	worker_enter_idle(worker);
 	kick_pool(pool);
 	raw_spin_unlock_irq(&pool->lock);
+	worker_unlock_callback(pool);
 }
=20
 /*
@@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work, =
bool from_cancel)
 		    (data & WORK_OFFQ_BH)) {
 			/*
 			 * On RT, prevent a live lock when %current preempted
-			 * soft interrupt processing or prevents ksoftirqd from
-			 * running by keeping flipping BH. If the BH work item
-			 * runs on a different CPU then this has no effect other
-			 * than doing the BH disable/enable dance for nothing.
-			 * This is copied from
-			 * kernel/softirq.c::tasklet_unlock_spin_wait().
+			 * soft interrupt processing by blocking on lock which
+			 * is owned by the thread invoking the callback.
 			 */
 			while (!try_wait_for_completion(&barr.done)) {
 				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-					local_bh_disable();
-					local_bh_enable();
+					struct worker_pool *pool;
+
+					mutex_lock(&wq_pool_mutex);
+					pool =3D get_work_pool(work);
+					if (pool)
+						workqueue_callback_cancel_wait_running(pool);
+					mutex_unlock(&wq_pool_mutex);
 				} else {
 					cpu_relax();
 				}
@@ -4782,6 +4812,9 @@ static int init_worker_pool(struct worker_pool *pool)
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
 	pool->refcnt =3D 1;
+#ifdef CONFIG_PREEMPT_RT
+	spin_lock_init(&pool->cb_lock);
+#endif
=20
 	/* shouldn't fail above this point */
 	pool->attrs =3D alloc_workqueue_attrs();
--=20
2.51.0


