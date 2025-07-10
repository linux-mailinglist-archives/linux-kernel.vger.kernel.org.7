Return-Path: <linux-kernel+bounces-725501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5709AFFFFC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372313A26E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9E52E7BBC;
	Thu, 10 Jul 2025 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jIBN3tUF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XRUggE+q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885442E54D9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 11:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752145225; cv=none; b=W38fJw1JdyfgThLV2+jToKTSTK4pfO3Ty374W39KCzC/PQdDJw2cnmtejs9VMSiJCu1KlUqnDrV3ZTWchfPAFhHN3ZdoL+eWj9Uui2KPOCV/KUVyiOLJaJdin351z4uUXpHJv0pjDCxqNIUjbkXIcYhxYzXOLoAl/JZu3RseaRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752145225; c=relaxed/simple;
	bh=S2fvBzXEckMv4p1um/LwQcwfL+o45XktE5tkQI0Cfog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtdARZ6ymsekSV4Ctpb7XW1Sxu70/haJUlu7WEZpSn9xOd4nDlPm3MtUh/416xK3FsrmPLe40DVdtqWyVNbobkNoSwM5Y2eoPvNKDJUiD+LTY59QWFFQT/A7kFkBsLlLGDHXGLzddTQZnFvu7UhExKC4AIe3DvMQkdNU2qifrew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jIBN3tUF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XRUggE+q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qagTk1kJMZ+DqvXnSmCpd8s99hTvT9ehk44SIIdec=;
	b=jIBN3tUFZ9k+AyuYOq7VOkmrTkGWoAUrYm4u5s6JHp9l0GDldP4r+8sungxgktr3Fk5UJD
	EXDboCP5ulbkij+8/Yv500mSUVR51U+VYnXazSvjrOP851prYW9s9wUZkfWaK4v0ILoTJR
	w00nkF9zP4mZrUKKNRi9vBkOi8qsDiN/LJSXz3evUdLthcMBhASEjEKnBtqTPoMB66RCEu
	4KVmyu8wJoQEWGDqoRo+pTD3cAWRnkfKXLq5FzR+NkBVNhZ8XKRrin4L4kHZmPp+kg/3IG
	FeKfB8Qdtud4vpMrau/LVKz6O7MkKgSO+LacqjNbOmAz5hOMKkKIifOuAskFdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752145217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=73qagTk1kJMZ+DqvXnSmCpd8s99hTvT9ehk44SIIdec=;
	b=XRUggE+qWScL8dBM3ok7sAUUU57dzTthP39Xx3v9E1lRMKOuiEwApc2LO57W/fN8GNCtR+
	Ib46bmEw8hLAjrBw==
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
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	linux-mm@kvack.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/6] futex: Use RCU-based per-CPU reference counting instead of rcuref_t
Date: Thu, 10 Jul 2025 13:00:07 +0200
Message-ID: <20250710110011.384614-3-bigeasy@linutronix.de>
In-Reply-To: <20250710110011.384614-1-bigeasy@linutronix.de>
References: <20250710110011.384614-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Peter Zijlstra <peterz@infradead.org>

The use of rcuref_t for reference counting introduces a performance bottlen=
eck
when accessed concurrently by multiple threads during futex operations.

Replace rcuref_t with special crafted per-CPU reference counters. The
lifetime logic remains the same.

The newly allocate private hash starts in FR_PERCPU state. In this state, e=
ach
futex operation that requires the private hash uses a per-CPU counter (an
unsigned int) for incrementing or decrementing the reference count.

When the private hash is about to be replaced, the per-CPU counters are
migrated to a atomic_t counter mm_struct::futex_atomic.
The migration process:
- Waiting for one RCU grace period to ensure all users observe the
  current private hash. This can be skipped if a grace period elapsed
  since the private hash was assigned.

- futex_private_hash::state is set to FR_ATOMIC, forcing all users to
  use mm_struct::futex_atomic for reference counting.

- After a RCU grace period, all users are guaranteed to be using the
  atomic counter. The per-CPU counters can now be summed up and added to
  the atomic_t counter. If the resulting count is zero, the hash can be
  safely replaced. Otherwise, active users still hold a valid reference.

- Once the atomic reference count drops to zero, the next futex
  operation will switch to the new private hash.

call_rcu_hurry() is used to speed up transition which otherwise might be
delay with RCU_LAZY. There is nothing wrong with using call_rcu(). The
side effects would be that on auto scaling the new hash is used later
and the SET_SLOTS prctl() will block longer.

[bigeasy: commit description + mm get/ put_async]

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/futex.h    |  16 +--
 include/linux/mm_types.h |   5 +
 include/linux/sched/mm.h |   2 +-
 init/Kconfig             |   4 -
 kernel/fork.c            |   8 +-
 kernel/futex/core.c      | 243 ++++++++++++++++++++++++++++++++++++---
 6 files changed, 243 insertions(+), 35 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b37193653e6b5..9e9750f049805 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,18 +85,12 @@ int futex_hash_prctl(unsigned long arg2, unsigned long =
arg3, unsigned long arg4)
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
-
-static inline void futex_mm_init(struct mm_struct *mm)
-{
-	RCU_INIT_POINTER(mm->futex_phash, NULL);
-	mm->futex_phash_new =3D NULL;
-	mutex_init(&mm->futex_hash_lock);
-}
+int futex_mm_init(struct mm_struct *mm);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline int futex_hash_allocate_default(void) { return 0; }
-static inline void futex_hash_free(struct mm_struct *mm) { }
-static inline void futex_mm_init(struct mm_struct *mm) { }
+static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
+static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
=20
 #else /* !CONFIG_FUTEX */
@@ -118,8 +112,8 @@ static inline int futex_hash_allocate_default(void)
 {
 	return 0;
 }
-static inline void futex_hash_free(struct mm_struct *mm) { }
-static inline void futex_mm_init(struct mm_struct *mm) { }
+static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
+static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
=20
 #endif
=20
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index d6b91e8a66d6d..0f0662157066a 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1070,6 +1070,11 @@ struct mm_struct {
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
 		struct futex_private_hash	*futex_phash_new;
+		/* futex-ref */
+		unsigned long			futex_batches;
+		struct rcu_head			futex_rcu;
+		atomic_long_t			futex_atomic;
+		unsigned int			__percpu *futex_ref;
 #endif
=20
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index b13474825130f..2201da0afecc5 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -140,7 +140,7 @@ static inline bool mmget_not_zero(struct mm_struct *mm)
=20
 /* mmput gets rid of the mappings and all user-space */
 extern void mmput(struct mm_struct *);
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 /* same as above but performs the slow path from the async context. Can
  * be called from the atomic context as well
  */
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50abd..af4c2f0854554 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,13 +1716,9 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
=20
-#
-# marked broken for performance reasons; gives us one more cycle to sort t=
hings out.
-#
 config FUTEX_PRIVATE_HASH
 	bool
 	depends on FUTEX && !BASE_SMALL && MMU
-	depends on BROKEN
 	default y
=20
 config FUTEX_MPOL
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38ba..0b885dcbde9af 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1046,7 +1046,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLO=
CKS)
 	mm->pmd_huge_pte =3D NULL;
 #endif
@@ -1061,6 +1060,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 		mm->def_flags =3D 0;
 	}
=20
+	if (futex_mm_init(mm))
+		goto fail_mm_init;
+
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
=20
@@ -1090,6 +1092,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 fail_noid:
 	mm_free_pgd(mm);
 fail_nopgd:
+	futex_hash_free(mm);
+fail_mm_init:
 	free_mm(mm);
 	return NULL;
 }
@@ -1145,7 +1149,7 @@ void mmput(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmput);
=20
-#ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) || defined(CONFIG_FUTEX_PRIVATE_HASH)
 static void mmput_async_fn(struct work_struct *work)
 {
 	struct mm_struct *mm =3D container_of(work, struct mm_struct,
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 90d53fb0ee9e1..1dcb4c8a2585d 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -42,7 +42,6 @@
 #include <linux/fault-inject.h>
 #include <linux/slab.h>
 #include <linux/prctl.h>
-#include <linux/rcuref.h>
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
=20
@@ -65,7 +64,7 @@ static struct {
 #define futex_queues	(__futex_data.queues)
=20
 struct futex_private_hash {
-	rcuref_t	users;
+	int		state;
 	unsigned int	hash_mask;
 	struct rcu_head	rcu;
 	void		*mm;
@@ -129,6 +128,12 @@ static struct futex_hash_bucket *
 __futex_hash(union futex_key *key, struct futex_private_hash *fph);
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+static bool futex_ref_get(struct futex_private_hash *fph);
+static bool futex_ref_put(struct futex_private_hash *fph);
+static bool futex_ref_is_dead(struct futex_private_hash *fph);
+
+enum { FR_PERCPU =3D 0, FR_ATOMIC };
+
 static inline bool futex_key_is_private(union futex_key *key)
 {
 	/*
@@ -142,15 +147,14 @@ bool futex_private_hash_get(struct futex_private_hash=
 *fph)
 {
 	if (fph->immutable)
 		return true;
-	return rcuref_get(&fph->users);
+	return futex_ref_get(fph);
 }
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	/* Ignore return value, last put is verified via rcuref_is_dead() */
 	if (fph->immutable)
 		return;
-	if (rcuref_put(&fph->users))
+	if (futex_ref_put(fph))
 		wake_up_var(fph->mm);
 }
=20
@@ -243,14 +247,18 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
 	fph =3D rcu_dereference_protected(mm->futex_phash,
 					lockdep_is_held(&mm->futex_hash_lock));
 	if (fph) {
-		if (!rcuref_is_dead(&fph->users)) {
+		if (!futex_ref_is_dead(fph)) {
 			mm->futex_phash_new =3D new;
 			return false;
 		}
=20
 		futex_rehash_private(fph, new);
 	}
-	rcu_assign_pointer(mm->futex_phash, new);
+	new->state =3D FR_PERCPU;
+	scoped_guard(rcu) {
+		mm->futex_batches =3D get_state_synchronize_rcu();
+		rcu_assign_pointer(mm->futex_phash, new);
+	}
 	kvfree_rcu(fph, rcu);
 	return true;
 }
@@ -289,9 +297,7 @@ struct futex_private_hash *futex_private_hash(void)
 		if (!fph)
 			return NULL;
=20
-		if (fph->immutable)
-			return fph;
-		if (rcuref_get(&fph->users))
+		if (futex_private_hash_get(fph))
 			return fph;
 	}
 	futex_pivot_hash(mm);
@@ -1527,16 +1533,219 @@ static void futex_hash_bucket_init(struct futex_ha=
sh_bucket *fhb,
 #define FH_IMMUTABLE	0x02
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+
+/*
+ * futex-ref
+ *
+ * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of th=
at
+ * code because it just doesn't fit right.
+ *
+ * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
+ * re-initializes the state automatically, such that the fph swizzle is al=
so a
+ * transition back to per-cpu.
+ */
+
+static void futex_ref_rcu(struct rcu_head *head);
+
+static void __futex_ref_atomic_begin(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+
+	/*
+	 * The counter we're about to switch to must have fully switched;
+	 * otherwise it would be impossible for it to have reported success
+	 * from futex_ref_is_dead().
+	 */
+	WARN_ON_ONCE(atomic_long_read(&mm->futex_atomic) !=3D 0);
+
+	/*
+	 * Set the atomic to the bias value such that futex_ref_{get,put}()
+	 * will never observe 0. Will be fixed up in __futex_ref_atomic_end()
+	 * when folding in the percpu count.
+	 */
+	atomic_long_set(&mm->futex_atomic, LONG_MAX);
+	smp_store_release(&fph->state, FR_ATOMIC);
+
+	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+}
+
+static void __futex_ref_atomic_end(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+	unsigned int count =3D 0;
+	long ret;
+	int cpu;
+
+	/*
+	 * Per __futex_ref_atomic_begin() the state of the fph must be ATOMIC
+	 * and per this RCU callback, everybody must now observe this state and
+	 * use the atomic variable.
+	 */
+	WARN_ON_ONCE(fph->state !=3D FR_ATOMIC);
+
+	/*
+	 * Therefore the per-cpu counter is now stable, sum and reset.
+	 */
+	for_each_possible_cpu(cpu) {
+		unsigned int *ptr =3D per_cpu_ptr(mm->futex_ref, cpu);
+		count +=3D *ptr;
+		*ptr =3D 0;
+	}
+
+	/*
+	 * Re-init for the next cycle.
+	 */
+	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+
+	/*
+	 * Add actual count, subtract bias and initial refcount.
+	 *
+	 * The moment this atomic operation happens, futex_ref_is_dead() can
+	 * become true.
+	 */
+	ret =3D atomic_long_add_return(count - LONG_MAX - 1, &mm->futex_atomic);
+	if (!ret)
+		wake_up_var(mm);
+
+	WARN_ON_ONCE(ret < 0);
+	mmput_async(mm);
+}
+
+static void futex_ref_rcu(struct rcu_head *head)
+{
+	struct mm_struct *mm =3D container_of(head, struct mm_struct, futex_rcu);
+	struct futex_private_hash *fph =3D rcu_dereference_raw(mm->futex_phash);
+
+	if (fph->state =3D=3D FR_PERCPU) {
+		/*
+		 * Per this extra grace-period, everybody must now observe
+		 * fph as the current fph and no previously observed fph's
+		 * are in-flight.
+		 *
+		 * Notably, nobody will now rely on the atomic
+		 * futex_ref_is_dead() state anymore so we can begin the
+		 * migration of the per-cpu counter into the atomic.
+		 */
+		__futex_ref_atomic_begin(fph);
+		return;
+	}
+
+	__futex_ref_atomic_end(fph);
+}
+
+/*
+ * Drop the initial refcount and transition to atomics.
+ */
+static void futex_ref_drop(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+
+	/*
+	 * Can only transition the current fph;
+	 */
+	WARN_ON_ONCE(rcu_dereference_raw(mm->futex_phash) !=3D fph);
+	/*
+	 * We enqueue at least one RCU callback. Ensure mm stays if the task
+	 * exits before the transition is completed.
+	 */
+	mmget(mm);
+
+	/*
+	 * In order to avoid the following scenario:
+	 *
+	 * futex_hash()			__futex_pivot_hash()
+	 *   guard(rcu);		  guard(mm->futex_hash_lock);
+	 *   fph =3D mm->futex_phash;
+	 *				  rcu_assign_pointer(&mm->futex_phash, new);
+	 *				futex_hash_allocate()
+	 *				  futex_ref_drop()
+	 *				    fph->state =3D FR_ATOMIC;
+	 *				    atomic_set(, BIAS);
+	 *
+	 *   futex_private_hash_get(fph); // OOPS
+	 *
+	 * Where an old fph (which is FR_ATOMIC) and should fail on
+	 * inc_not_zero, will succeed because a new transition is started and
+	 * the atomic is bias'ed away from 0.
+	 *
+	 * There must be at least one full grace-period between publishing a
+	 * new fph and trying to replace it.
+	 */
+	if (poll_state_synchronize_rcu(mm->futex_batches)) {
+		/*
+		 * There was a grace-period, we can begin now.
+		 */
+		__futex_ref_atomic_begin(fph);
+		return;
+	}
+
+	call_rcu_hurry(&mm->futex_rcu, futex_ref_rcu);
+}
+
+static bool futex_ref_get(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) =3D=3D FR_PERCPU) {
+		this_cpu_inc(*mm->futex_ref);
+		return true;
+	}
+
+	return atomic_long_inc_not_zero(&mm->futex_atomic);
+}
+
+static bool futex_ref_put(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) =3D=3D FR_PERCPU) {
+		this_cpu_dec(*mm->futex_ref);
+		return false;
+	}
+
+	return atomic_long_dec_and_test(&mm->futex_atomic);
+}
+
+static bool futex_ref_is_dead(struct futex_private_hash *fph)
+{
+	struct mm_struct *mm =3D fph->mm;
+
+	guard(rcu)();
+
+	if (smp_load_acquire(&fph->state) =3D=3D FR_PERCPU)
+		return false;
+
+	return atomic_long_read(&mm->futex_atomic) =3D=3D 0;
+}
+
+int futex_mm_init(struct mm_struct *mm)
+{
+	mutex_init(&mm->futex_hash_lock);
+	RCU_INIT_POINTER(mm->futex_phash, NULL);
+	mm->futex_phash_new =3D NULL;
+	/* futex-ref */
+	atomic_long_set(&mm->futex_atomic, 0);
+	mm->futex_batches =3D get_state_synchronize_rcu();
+	mm->futex_ref =3D alloc_percpu(unsigned int);
+	if (!mm->futex_ref)
+		return -ENOMEM;
+	this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+	return 0;
+}
+
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *fph;
=20
+	free_percpu(mm->futex_ref);
 	kvfree(mm->futex_phash_new);
 	fph =3D rcu_dereference_raw(mm->futex_phash);
-	if (fph) {
-		WARN_ON_ONCE(rcuref_read(&fph->users) > 1);
+	if (fph)
 		kvfree(fph);
-	}
 }
=20
 static bool futex_pivot_pending(struct mm_struct *mm)
@@ -1549,7 +1758,7 @@ static bool futex_pivot_pending(struct mm_struct *mm)
 		return true;
=20
 	fph =3D rcu_dereference(mm->futex_phash);
-	return rcuref_is_dead(&fph->users);
+	return futex_ref_is_dead(fph);
 }
=20
 static bool futex_hash_less(struct futex_private_hash *a,
@@ -1598,11 +1807,11 @@ static int futex_hash_allocate(unsigned int hash_sl=
ots, unsigned int flags)
 		}
 	}
=20
-	fph =3D kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT=
 | __GFP_NOWARN);
+	fph =3D kvzalloc(struct_size(fph, queues, hash_slots),
+		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
 		return -ENOMEM;
=20
-	rcuref_init(&fph->users, 1);
 	fph->hash_mask =3D hash_slots ? hash_slots - 1 : 0;
 	fph->custom =3D custom;
 	fph->immutable =3D !!(flags & FH_IMMUTABLE);
@@ -1645,7 +1854,7 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
 				 * allocated a replacement hash, drop the initial
 				 * reference on the existing hash.
 				 */
-				futex_private_hash_put(cur);
+				futex_ref_drop(cur);
 			}
=20
 			if (new) {
--=20
2.50.0


