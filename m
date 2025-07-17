Return-Path: <linux-kernel+bounces-735874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1EFB094CD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDC31C46EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10576301134;
	Thu, 17 Jul 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUxHxEVk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BDE2F8C58
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779876; cv=none; b=nWBgUDpwpxvoOLdnNCu/2n3Hg4T1Zc+n39fa8U3gAICXqRlbi78B7Tr41W7AhLlFlDN4pJGDuazLQtXNo/O51OXAD7q9jobXWjlIuxV6DNayifImXZO/aXaFIzGoXFfQ56qg6Sd9YZYIAgK1rEDG4jhC9tWN5gOrB4Qk045NawE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779876; c=relaxed/simple;
	bh=Juup3Iy80PNBriXiJDhA4waXin68jIqW+NnKsBxMw2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7+K+cUXJUmc4QiM6wiWo+2EtORqELK3So4rHUMfagZ+SB4+r1n85is38Ta87bTkKJFHjkbN+xwpy7JfM6qJkFV1FDAb+r5eorGiRUdaeCu1Je2yq+wtjS4KD0eZnsHLCzxQzNoG9J74s0nPQd6ZPNz2aAH/RXH4vs/Ax2HFNvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUxHxEVk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752779873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/ErB1o3KrcLUhhcUQAItr8h6DRh4MqC+kuaiTNg6gbc=;
	b=CUxHxEVkQAVzOJHM1rW+ML9VfkO60tJAB7HBtRzFQlNyCIyV2UjRaBJ0VMyJtFOgcS9otz
	XeGuzy7/iK7fbIZjZZaGFKaoFdFuss9bTdEEElqpq323cM+aSBrems7kk7zf9XhvwrhB6m
	Xb74BNKcser6AwCEoGOzyXXlHgvfo2Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-5bkgsS_NO2CPPEflUmyOGA-1; Thu,
 17 Jul 2025 15:17:51 -0400
X-MC-Unique: 5bkgsS_NO2CPPEflUmyOGA-1
X-Mimecast-MFC-AGG-ID: 5bkgsS_NO2CPPEflUmyOGA_1752779867
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EEA91800365;
	Thu, 17 Jul 2025 19:17:47 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 42DE81956089;
	Thu, 17 Jul 2025 19:17:42 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	NeilBrown <neil@brown.name>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v12 03/15] irq & spin_lock: Add counted interrupt disabling/enabling
Date: Thu, 17 Jul 2025 15:15:42 -0400
Message-ID: <20250717191719.2076270-4-lyude@redhat.com>
In-Reply-To: <20250717191719.2076270-1-lyude@redhat.com>
References: <20250717191719.2076270-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

From: Boqun Feng <boqun.feng@gmail.com>

Currently the nested interrupt disabling and enabling is present by
_irqsave() and _irqrestore() APIs, which are relatively unsafe, for
example:

	<interrupts are enabled as beginning>
	spin_lock_irqsave(l1, flag1);
	spin_lock_irqsave(l2, flag2);
	spin_unlock_irqrestore(l1, flags1);
	<l2 is still held but interrupts are enabled>
	// accesses to interrupt-disable protect data will cause races.

This is even easier to triggered with guard facilities:

	unsigned long flag2;

	scoped_guard(spin_lock_irqsave, l1) {
		spin_lock_irqsave(l2, flag2);
	}
	// l2 locked but interrupts are enabled.
	spin_unlock_irqrestore(l2, flag2);

(Hand-to-hand locking critical sections are not uncommon for a
fine-grained lock design)

And because this unsafety, Rust cannot easily wrap the
interrupt-disabling locks in a safe API, which complicates the design.

To resolve this, introduce a new set of interrupt disabling APIs:

*	local_interrupt_disable();
*	local_interrupt_enable();

They work like local_irq_save() and local_irq_restore() except that 1)
the outermost local_interrupt_disable() call save the interrupt state
into a percpu variable, so that the outermost local_interrupt_enable()
can restore the state, and 2) a percpu counter is added to record the
nest level of these calls, so that interrupts are not accidentally
enabled inside the outermost critical section.

Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
and spin_unlock_irq_enable(), as a result, code as follow:

	spin_lock_irq_disable(l1);
	spin_lock_irq_disable(l2);
	spin_unlock_irq_enable(l1);
	// Interrupts are still disabled.
	spin_unlock_irq_enable(l2);

doesn't have the issue that interrupts are accidentally enabled.

This also makes the wrapper of interrupt-disabling locks on Rust easier
to design.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

---
V10:
* Add missing __raw_spin_lock_irq_disable() definition in spinlock.c
V11
* Move definition of spin_trylock_irq_disable() into this commit
* Get rid of leftover space
* Remove unneeded preempt_disable()/preempt_enable()

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/linux/irqflags_types.h   |  6 ++++
 include/linux/preempt.h          |  4 +++
 include/linux/spinlock.h         | 62 ++++++++++++++++++++++++++++++++
 include/linux/spinlock_api_smp.h | 27 ++++++++++++++
 include/linux/spinlock_api_up.h  |  8 +++++
 include/linux/spinlock_rt.h      | 15 ++++++++
 kernel/locking/spinlock.c        | 29 +++++++++++++++
 kernel/softirq.c                 |  3 ++
 8 files changed, 154 insertions(+)

diff --git a/include/linux/irqflags_types.h b/include/linux/irqflags_types.h
index c13f0d915097a..277433f7f53eb 100644
--- a/include/linux/irqflags_types.h
+++ b/include/linux/irqflags_types.h
@@ -19,4 +19,10 @@ struct irqtrace_events {
 
 #endif
 
+/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
+struct interrupt_disable_state {
+	unsigned long flags;
+	long count;
+};
+
 #endif /* _LINUX_IRQFLAGS_TYPES_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 809af7b57470a..c1c5795be5d0f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -148,6 +148,10 @@ static __always_inline unsigned char interrupt_context_level(void)
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
 
+#define hardirq_disable_count()	((preempt_count() & HARDIRQ_DISABLE_MASK) >> HARDIRQ_DISABLE_SHIFT)
+#define hardirq_disable_enter()	__preempt_count_add_return(HARDIRQ_DISABLE_OFFSET)
+#define hardirq_disable_exit()	__preempt_count_sub_return(HARDIRQ_DISABLE_OFFSET)
+
 /*
  * The preempt_count offset after preempt_disable();
  */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e2..b21da4bd51a42 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -272,9 +272,11 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 #endif
 
 #define raw_spin_lock_irq(lock)		_raw_spin_lock_irq(lock)
+#define raw_spin_lock_irq_disable(lock)	_raw_spin_lock_irq_disable(lock)
 #define raw_spin_lock_bh(lock)		_raw_spin_lock_bh(lock)
 #define raw_spin_unlock(lock)		_raw_spin_unlock(lock)
 #define raw_spin_unlock_irq(lock)	_raw_spin_unlock_irq(lock)
+#define raw_spin_unlock_irq_enable(lock)	_raw_spin_unlock_irq_enable(lock)
 
 #define raw_spin_unlock_irqrestore(lock, flags)		\
 	do {							\
@@ -300,11 +302,56 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 	1 : ({ local_irq_restore(flags); 0; }); \
 })
 
+#define raw_spin_trylock_irq_disable(lock) \
+({ \
+	local_interrupt_disable(); \
+	raw_spin_trylock(lock) ? \
+	1 : ({ local_interrupt_enable(); 0; }); \
+})
+
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
 #include <linux/rwlock.h>
 #endif
 
+DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+
+static inline void local_interrupt_disable(void)
+{
+	unsigned long flags;
+	int new_count;
+
+	new_count = hardirq_disable_enter();
+
+	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
+		local_irq_save(flags);
+		raw_cpu_write(local_interrupt_disable_state.flags, flags);
+	}
+}
+
+static inline void local_interrupt_enable(void)
+{
+	int new_count;
+
+	new_count = hardirq_disable_exit();
+
+	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
+		unsigned long flags;
+
+		flags = raw_cpu_read(local_interrupt_disable_state.flags);
+		local_irq_restore(flags);
+		/*
+		 * TODO: re-read preempt count can be avoided, but it needs
+		 * should_resched() taking another parameter as the current
+		 * preempt count
+		 */
+#ifdef PREEMPTION
+		if (should_resched(0))
+			__preempt_schedule();
+#endif
+	}
+}
+
 /*
  * Pull the _spin_*()/_read_*()/_write_*() functions/declarations:
  */
@@ -376,6 +423,11 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	raw_spin_lock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	raw_spin_lock_irq_disable(&lock->rlock);
+}
+
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
@@ -401,6 +453,11 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	raw_spin_unlock_irq_enable(&lock->rlock);
+}
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	raw_spin_unlock_irqrestore(&lock->rlock, flags);
@@ -421,6 +478,11 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	raw_spin_trylock_irqsave(spinlock_check(lock), flags); \
 })
 
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return raw_spin_trylock_irq_disable(&lock->rlock);
+}
+
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
  * @lock: Pointer to the spinlock.
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 9ecb0ab504e32..92532103b9eaa 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -28,6 +28,8 @@ _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 								__acquires(lock);
+void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+								__acquires(lock);
 
 unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 								__acquires(lock);
@@ -39,6 +41,7 @@ int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock);
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
+void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 								__releases(lock);
@@ -55,6 +58,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_lock_irq(lock) __raw_spin_lock_irq(lock)
 #endif
 
+/* Use the same config as spin_lock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_LOCK_IRQ
+#define _raw_spin_lock_irq_disable(lock) __raw_spin_lock_irq_disable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
 #define _raw_spin_lock_irqsave(lock) __raw_spin_lock_irqsave(lock)
 #endif
@@ -79,6 +87,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_unlock_irq(lock) __raw_spin_unlock_irq(lock)
 #endif
 
+/* Use the same config as spin_unlock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+#define _raw_spin_unlock_irq_enable(lock) __raw_spin_unlock_irq_enable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
 #define _raw_spin_unlock_irqrestore(lock, flags) __raw_spin_unlock_irqrestore(lock, flags)
 #endif
@@ -120,6 +133,13 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
+static inline void __raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	local_interrupt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+}
+
 static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
@@ -160,6 +180,13 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 	preempt_enable();
 }
 
+static inline void __raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+{
+	spin_release(&lock->dep_map, _RET_IP_);
+	do_raw_spin_unlock(lock);
+	local_interrupt_enable();
+}
+
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 819aeba1c87e6..d02a73671713b 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -36,6 +36,9 @@
 #define __LOCK_IRQ(lock) \
   do { local_irq_disable(); __LOCK(lock); } while (0)
 
+#define __LOCK_IRQ_DISABLE(lock) \
+  do { local_interrupt_disable(); __LOCK(lock); } while (0)
+
 #define __LOCK_IRQSAVE(lock, flags) \
   do { local_irq_save(flags); __LOCK(lock); } while (0)
 
@@ -52,6 +55,9 @@
 #define __UNLOCK_IRQ(lock) \
   do { local_irq_enable(); __UNLOCK(lock); } while (0)
 
+#define __UNLOCK_IRQ_ENABLE(lock) \
+  do { __UNLOCK(lock); local_interrupt_enable(); } while (0)
+
 #define __UNLOCK_IRQRESTORE(lock, flags) \
   do { local_irq_restore(flags); __UNLOCK(lock); } while (0)
 
@@ -64,6 +70,7 @@
 #define _raw_read_lock_bh(lock)			__LOCK_BH(lock)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
+#define _raw_spin_lock_irq_disable(lock)	__LOCK_IRQ_DISABLE(lock)
 #define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_write_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
@@ -80,6 +87,7 @@
 #define _raw_write_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_spin_unlock_irq(lock)		__UNLOCK_IRQ(lock)
+#define _raw_spin_unlock_irq_enable(lock)	__UNLOCK_IRQ_ENABLE(lock)
 #define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock)
 #define _raw_write_unlock_irq(lock)		__UNLOCK_IRQ(lock)
 #define _raw_spin_unlock_irqrestore(lock, flags) \
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f6499c37157df..074182f7cfeea 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -93,6 +93,11 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	rt_spin_lock(lock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+{
+	rt_spin_lock(lock);
+}
+
 #define spin_lock_irqsave(lock, flags)			 \
 	do {						 \
 		typecheck(unsigned long, flags);	 \
@@ -116,12 +121,22 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	rt_spin_unlock(lock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+{
+	rt_spin_unlock(lock);
+}
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
 {
 	rt_spin_unlock(lock);
 }
 
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return rt_spin_trylock(lock);
+}
+
 #define spin_trylock(lock)				\
 	__cond_lock(lock, rt_spin_trylock(lock))
 
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 7685defd7c526..da54b220b5a45 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -125,6 +125,19 @@ static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
  */
 BUILD_LOCK_OPS(spin, raw_spinlock);
 
+/* No rwlock_t variants for now, so just build this function by hand */
+static void __lockfunc __raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	for (;;) {
+		local_interrupt_disable();
+		if (likely(do_raw_spin_trylock(lock)))
+			break;
+		local_interrupt_enable();
+
+		arch_spin_relax(&lock->raw_lock);
+	}
+}
+
 #ifndef CONFIG_PREEMPT_RT
 BUILD_LOCK_OPS(read, rwlock);
 BUILD_LOCK_OPS(write, rwlock);
@@ -172,6 +185,14 @@ noinline void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
+noinline void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	__raw_spin_lock_irq_disable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_lock_irq_disable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
 noinline void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 {
@@ -204,6 +225,14 @@ noinline void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+noinline void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+{
+	__raw_spin_unlock_irq_enable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_unlock_irq_enable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
 noinline void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987cc..f7a2ff4d123be 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,9 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
+
 /*
  * SOFTIRQ_OFFSET usage:
  *
-- 
2.50.0


