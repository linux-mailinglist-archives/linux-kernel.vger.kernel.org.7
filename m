Return-Path: <linux-kernel+bounces-749116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A262EB14A59
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 10:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5FC16EFDB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6388E285C95;
	Tue, 29 Jul 2025 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XPLhQHLW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MkrjXzjv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDB1285404
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753778771; cv=none; b=rXA+qcxVR602cjswfelk8AN5dn4Seylh/OmwAVSTQ/OcxaSSXNMJavDLzOjPmeCYP1vjt6iL+IckGGoKj0P+/Ar4iIL7LfwBBPrHSqBvzBjKHL6ulefU6T8yMPmguRSkIX/hGI8gwR8IcQCfK75xy3uzT6lvVKutGF5w96TR8+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753778771; c=relaxed/simple;
	bh=AwZ3C6Hn3wsqsRPryI7D+ZyqIu/L0yvRnqdhTaiPiyQ=;
	h=From:To:Cc:Subject:References:Message-ID:Content-Type:
	 MIME-Version:Date; b=mbZX1awgxWE47ZPc8108ap6O5dPKHUr4rtWqrGT0RpXSFEZMRINL3UsWkjuSLWzxPovqDrg01egBN1OgI/pFVYV6H11nCRkDMyzYL0fEuYYwzgYr2ilWPfEkkkjJ7Tlz2DO4r5toqEEYWNtsdR1IP0+qrmuDn0OMGHa5V7TDU9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XPLhQHLW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MkrjXzjv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753778767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=zas7P80JGNmdFWgKU8tnIEuth5BAFgv17a3Y09x2mPw=;
	b=XPLhQHLWPzgdX43TO9EVluZZzUKgqVj2wJolQZjZ4tTTy+2WqN82zYSAX92mP3F49gIpLJ
	Vf3dkYrgpzfnKbsD4M61aMf7QuBU9PHt/V+A/T/neo3OAkjAfKJ+8YlDz95eWOW7k2dEs8
	Y3OCVxmOaNurq4JzqZU4NXAa8cgqtMP7NgfG5M/NrQy4ZdPFkO/DLG31Dyv/dhrAQQAByJ
	IEqE4yOb9ArC4/u4Tvvt000lNk812JjwmOu+wBZDFvubBa0iG7JxmYGJkK5E7mbgp0eqZO
	e4Ox47VnkLsCwGlakcUCeQWpxSuSWxtatWkhgwNL8snbzo0t4ZtiX/9vcetNmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753778767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  references:references;
	bh=zas7P80JGNmdFWgKU8tnIEuth5BAFgv17a3Y09x2mPw=;
	b=MkrjXzjv7c6T59b0A9OlXr+1jcTMc89negSfGjTRN47QH44LeJf3pW0dJTNrIm/JM286Vv
	H6V3ouG+2waLX/Bg==
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] locking/futex for v6.17-rc1
References: 
 <175377875455.620102.9417697212609201411.tglx@xen13.tec.linutronix.de>
Message-ID: 
 <175377875605.620102.13731137828469256924.tglx@xen13.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Jul 2025 10:46:06 +0200 (CEST)

Linus,

please pull the latest locking/futex branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-futex-20=
25-07-29

up to:  e40892214b45: selftests/futex: Fix spelling mistake "Succeffuly" -> "=
Successfully"


Update for the futex subsystem:

   - Switch the reference counting to a RCU based per-CPU reference to
     address a performance bottleneck vs. the single instance rcuref
     variant.

   - Make the futex selftest build on 32-bit architectures which only
     support 64-bit time_t, e.g. RISCV-32.

   - Cleanups and improvements in selftests and futex bench

Thanks,

	tglx

------------------>
Colin Ian King (1):
      selftests/futex: Fix spelling mistake "Succeffuly" -> "Successfully"

Cynthia Huang (1):
      selftests/futex: Define SYS_futex on 32-bit architectures with 64-bit t=
ime_t

Peter Zijlstra (1):
      futex: Use RCU-based per-CPU reference counting instead of rcuref_t

Sebastian Andrzej Siewior (5):
      selftests/futex: Adapt the private hash test to RCU related changes
      futex: Make futex_private_hash_get() static
      futex: Remove support for IMMUTABLE
      selftests/futex: Remove support for IMMUTABLE
      perf bench futex: Remove support for IMMUTABLE


 include/linux/futex.h                              |  16 +-
 include/linux/mm_types.h                           |   5 +
 include/linux/sched/mm.h                           |   2 +-
 include/uapi/linux/prctl.h                         |   2 -
 init/Kconfig                                       |   4 -
 kernel/fork.c                                      |   8 +-
 kernel/futex/core.c                                | 281 +++++++++++++++++--=
--
 kernel/futex/futex.h                               |   2 -
 tools/include/uapi/linux/prctl.h                   |   2 -
 tools/perf/bench/futex-hash.c                      |   1 -
 tools/perf/bench/futex-lock-pi.c                   |   1 -
 tools/perf/bench/futex-requeue.c                   |   1 -
 tools/perf/bench/futex-wake-parallel.c             |   1 -
 tools/perf/bench/futex-wake.c                      |   1 -
 tools/perf/bench/futex.c                           |  21 +-
 tools/perf/bench/futex.h                           |   1 -
 tools/perf/trace/beauty/include/uapi/linux/prctl.h |   2 -
 .../selftests/futex/functional/futex_priv_hash.c   | 113 +++++----
 tools/testing/selftests/futex/include/futextest.h  |  11 +
 19 files changed, 326 insertions(+), 149 deletions(-)

diff --git a/include/linux/futex.h b/include/linux/futex.h
index b37193653e6b..9e9750f04980 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -85,18 +85,12 @@ int futex_hash_prctl(unsigned long arg2, unsigned long ar=
g3, unsigned long arg4)
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
index d6b91e8a66d6..0f0662157066 100644
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
index b13474825130..2201da0afecc 100644
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
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 43dec6eed559..3b93fb906e3c 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/init/Kconfig b/init/Kconfig
index 666783eb50ab..af4c2f085455 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1716,13 +1716,9 @@ config FUTEX_PI
 	depends on FUTEX && RT_MUTEXES
 	default y
=20
-#
-# marked broken for performance reasons; gives us one more cycle to sort thi=
ngs out.
-#
 config FUTEX_PRIVATE_HASH
 	bool
 	depends on FUTEX && !BASE_SMALL && MMU
-	depends on BROKEN
 	default y
=20
 config FUTEX_MPOL
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..0b885dcbde9a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1046,7 +1046,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm, =
struct task_struct *p,
 	RCU_INIT_POINTER(mm->exe_file, NULL);
 	mmu_notifier_subscriptions_init(mm);
 	init_tlb_flush_pending(mm);
-	futex_mm_init(mm);
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCK=
S)
 	mm->pmd_huge_pte =3D NULL;
 #endif
@@ -1061,6 +1060,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, =
struct task_struct *p,
 		mm->def_flags =3D 0;
 	}
=20
+	if (futex_mm_init(mm))
+		goto fail_mm_init;
+
 	if (mm_alloc_pgd(mm))
 		goto fail_nopgd;
=20
@@ -1090,6 +1092,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm, =
struct task_struct *p,
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
index 90d53fb0ee9e..d9bb5567af0c 100644
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
@@ -65,12 +64,11 @@ static struct {
 #define futex_queues	(__futex_data.queues)
=20
 struct futex_private_hash {
-	rcuref_t	users;
+	int		state;
 	unsigned int	hash_mask;
 	struct rcu_head	rcu;
 	void		*mm;
 	bool		custom;
-	bool		immutable;
 	struct futex_hash_bucket queues[];
 };
=20
@@ -129,6 +127,12 @@ static struct futex_hash_bucket *
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
@@ -138,19 +142,14 @@ static inline bool futex_key_is_private(union futex_key=
 *key)
 	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
 }
=20
-bool futex_private_hash_get(struct futex_private_hash *fph)
+static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
-	if (fph->immutable)
-		return true;
-	return rcuref_get(&fph->users);
+	return futex_ref_get(fph);
 }
=20
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
-	/* Ignore return value, last put is verified via rcuref_is_dead() */
-	if (fph->immutable)
-		return;
-	if (rcuref_put(&fph->users))
+	if (futex_ref_put(fph))
 		wake_up_var(fph->mm);
 }
=20
@@ -243,14 +242,18 @@ static bool __futex_pivot_hash(struct mm_struct *mm,
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
@@ -289,9 +292,7 @@ struct futex_private_hash *futex_private_hash(void)
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
@@ -1524,19 +1525,221 @@ static void futex_hash_bucket_init(struct futex_hash=
_bucket *fhb,
 }
=20
 #define FH_CUSTOM	0x01
-#define FH_IMMUTABLE	0x02
=20
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
+
+/*
+ * futex-ref
+ *
+ * Heavily inspired by percpu-rwsem/percpu-refcount; not reusing any of that
+ * code because it just doesn't fit right.
+ *
+ * Dual counter, per-cpu / atomic approach like percpu-refcount, except it
+ * re-initializes the state automatically, such that the fph swizzle is also=
 a
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
@@ -1549,7 +1752,7 @@ static bool futex_pivot_pending(struct mm_struct *mm)
 		return true;
=20
 	fph =3D rcu_dereference(mm->futex_phash);
-	return rcuref_is_dead(&fph->users);
+	return futex_ref_is_dead(fph);
 }
=20
 static bool futex_hash_less(struct futex_private_hash *a,
@@ -1591,21 +1794,20 @@ static int futex_hash_allocate(unsigned int hash_slot=
s, unsigned int flags)
 	 */
 	scoped_guard(rcu) {
 		fph =3D rcu_dereference(mm->futex_phash);
-		if (fph && (!fph->hash_mask || fph->immutable)) {
+		if (fph && !fph->hash_mask) {
 			if (custom)
 				return -EBUSY;
 			return 0;
 		}
 	}
=20
-	fph =3D kvzalloc(struct_size(fph, queues, hash_slots), GFP_KERNEL_ACCOUNT |=
 __GFP_NOWARN);
+	fph =3D kvzalloc(struct_size(fph, queues, hash_slots),
+		       GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (!fph)
 		return -ENOMEM;
=20
-	rcuref_init(&fph->users, 1);
 	fph->hash_mask =3D hash_slots ? hash_slots - 1 : 0;
 	fph->custom =3D custom;
-	fph->immutable =3D !!(flags & FH_IMMUTABLE);
 	fph->mm =3D mm;
=20
 	for (i =3D 0; i < hash_slots; i++)
@@ -1629,7 +1831,7 @@ static int futex_hash_allocate(unsigned int hash_slots,=
 unsigned int flags)
 		mm->futex_phash_new =3D NULL;
=20
 		if (fph) {
-			if (cur && (!cur->hash_mask || cur->immutable)) {
+			if (cur && !cur->hash_mask) {
 				/*
 				 * If two threads simultaneously request the global
 				 * hash then the first one performs the switch,
@@ -1645,7 +1847,7 @@ static int futex_hash_allocate(unsigned int hash_slots,=
 unsigned int flags)
 				 * allocated a replacement hash, drop the initial
 				 * reference on the existing hash.
 				 */
-				futex_private_hash_put(cur);
+				futex_ref_drop(cur);
 			}
=20
 			if (new) {
@@ -1722,19 +1924,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
-static int futex_hash_get_immutable(void)
-{
-	struct futex_private_hash *fph;
-
-	guard(rcu)();
-	fph =3D rcu_dereference(current->mm->futex_phash);
-	if (fph && fph->immutable)
-		return 1;
-	if (fph && !fph->hash_mask)
-		return 1;
-	return 0;
-}
-
 #else
=20
 static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
@@ -1747,10 +1936,6 @@ static int futex_hash_get_slots(void)
 	return 0;
 }
=20
-static int futex_hash_get_immutable(void)
-{
-	return 0;
-}
 #endif
=20
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long a=
rg4)
@@ -1760,10 +1945,8 @@ int futex_hash_prctl(unsigned long arg2, unsigned long=
 arg3, unsigned long arg4)
=20
 	switch (arg2) {
 	case PR_FUTEX_HASH_SET_SLOTS:
-		if (arg4 & ~FH_FLAG_IMMUTABLE)
+		if (arg4)
 			return -EINVAL;
-		if (arg4 & FH_FLAG_IMMUTABLE)
-			flags |=3D FH_IMMUTABLE;
 		ret =3D futex_hash_allocate(arg3, flags);
 		break;
=20
@@ -1771,10 +1954,6 @@ int futex_hash_prctl(unsigned long arg2, unsigned long=
 arg3, unsigned long arg4)
 		ret =3D futex_hash_get_slots();
 		break;
=20
-	case PR_FUTEX_HASH_GET_IMMUTABLE:
-		ret =3D futex_hash_get_immutable();
-		break;
-
 	default:
 		ret =3D -EINVAL;
 		break;
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index fcd1617212ee..c74eac572acd 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -228,14 +228,12 @@ extern void futex_hash_get(struct futex_hash_bucket *hb=
);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
=20
 extern struct futex_private_hash *futex_private_hash(void);
-extern bool futex_private_hash_get(struct futex_private_hash *fph);
 extern void futex_private_hash_put(struct futex_private_hash *fph);
=20
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline void futex_hash_get(struct futex_hash_bucket *hb) { }
 static inline void futex_hash_put(struct futex_hash_bucket *hb) { }
 static inline struct futex_private_hash *futex_private_hash(void) { return N=
ULL; }
-static inline bool futex_private_hash_get(void) { return false; }
 static inline void futex_private_hash_put(struct futex_private_hash *fph) { }
 #endif
=20
diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prct=
l.h
index 43dec6eed559..3b93fb906e3c 100644
--- a/tools/include/uapi/linux/prctl.h
+++ b/tools/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index d2d6d7f3ea33..7e29f04da744 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -56,7 +56,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buck=
ets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash bu=
ckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)=
"),
 	OPT_UINTEGER('f', "futexes", &params.nfutexes, "Specify amount of futexes p=
er threads"),
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-p=
i.c
index 5144a158512c..40640b674427 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -47,7 +47,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buck=
ets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash bu=
ckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('r', "runtime", &params.runtime, "Specify runtime (in seconds)=
"),
 	OPT_BOOLEAN( 'M', "multi",   &params.multi, "Use multiple futexes"),
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeu=
e.c
index a2f91ee1950b..0748b0fd689e 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buck=
ets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash bu=
ckets immutable"),
 	OPT_UINTEGER('t', "threads",  &params.nthreads, "Specify amount of threads"=
),
 	OPT_UINTEGER('q', "nrequeue", &params.nrequeue, "Specify amount of threads =
to requeue at once"),
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display =
data/details"),
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-=
wake-parallel.c
index ee66482c29fd..6aede7c46b33 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -63,7 +63,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buck=
ets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash bu=
ckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakers", &params.nwakes, "Specify amount of waking thre=
ads"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display d=
ata/details"),
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 8d6107f7cd94..a31fc1563862 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -52,7 +52,6 @@ static struct bench_futex_parameters params =3D {
=20
 static const struct option options[] =3D {
 	OPT_INTEGER( 'b', "buckets", &params.nbuckets, "Specify amount of hash buck=
ets"),
-	OPT_BOOLEAN( 'I', "immutable", &params.buckets_immutable, "Make the hash bu=
ckets immutable"),
 	OPT_UINTEGER('t', "threads", &params.nthreads, "Specify amount of threads"),
 	OPT_UINTEGER('w', "nwakes",  &params.nwakes, "Specify amount of threads to =
wake at once"),
 	OPT_BOOLEAN( 's', "silent",  &params.silent, "Silent mode: do not display d=
ata/details"),
diff --git a/tools/perf/bench/futex.c b/tools/perf/bench/futex.c
index 4c4fee107e59..1481196a22f0 100644
--- a/tools/perf/bench/futex.c
+++ b/tools/perf/bench/futex.c
@@ -9,21 +9,17 @@
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH                   78
 # define PR_FUTEX_HASH_SET_SLOTS        1
-# define FH_FLAG_IMMUTABLE              (1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS        2
-# define PR_FUTEX_HASH_GET_IMMUTABLE    3
 #endif // PR_FUTEX_HASH
=20
 void futex_set_nbuckets_param(struct bench_futex_parameters *params)
 {
-	unsigned long flags;
 	int ret;
=20
 	if (params->nbuckets < 0)
 		return;
=20
-	flags =3D params->buckets_immutable ? FH_FLAG_IMMUTABLE : 0;
-	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, fla=
gs);
+	ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, params->nbuckets, 0);
 	if (ret) {
 		printf("Requesting %d hash buckets failed: %d/%m\n",
 		       params->nbuckets, ret);
@@ -47,18 +43,11 @@ void futex_print_nbuckets(struct bench_futex_parameters *=
params)
 			printf("Requested: %d in usage: %d\n", params->nbuckets, ret);
 			err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
 		}
-		if (params->nbuckets =3D=3D 0) {
+		if (params->nbuckets =3D=3D 0)
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
-		} else {
-			ret =3D prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-			if (ret < 0) {
-				printf("Can't check if the hash is immutable: %m\n");
-				err(EXIT_FAILURE, "prctl(PR_FUTEX_HASH)");
-			}
-			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets %s",
-				       params->nbuckets,
-				       ret =3D=3D 1 ? "(immutable)" : "");
-		}
+		else
+			ret =3D asprintf(&futex_hash_mode, "Futex hashing: %d hash buckets",
+				       params->nbuckets);
 	} else {
 		if (ret <=3D 0) {
 			ret =3D asprintf(&futex_hash_mode, "Futex hashing: global hash");
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 9c9a73f9d865..dd295d27044a 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -26,7 +26,6 @@ struct bench_futex_parameters {
 	unsigned int nwakes;
 	unsigned int nrequeue;
 	int nbuckets;
-	bool buckets_immutable;
 };
=20
 /**
diff --git a/tools/perf/trace/beauty/include/uapi/linux/prctl.h b/tools/perf/=
trace/beauty/include/uapi/linux/prctl.h
index 43dec6eed559..3b93fb906e3c 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/prctl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/prctl.h
@@ -367,8 +367,6 @@ struct prctl_mm_map {
 /* FUTEX hash management */
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
=20
 #endif /* _LINUX_PRCTL_H */
diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc94eb8..aea001ac4946 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -26,14 +26,12 @@ static int counter;
 #ifndef PR_FUTEX_HASH
 #define PR_FUTEX_HASH			78
 # define PR_FUTEX_HASH_SET_SLOTS	1
-# define FH_FLAG_IMMUTABLE		(1ULL << 0)
 # define PR_FUTEX_HASH_GET_SLOTS	2
-# define PR_FUTEX_HASH_GET_IMMUTABLE	3
 #endif
=20
-static int futex_hash_slots_set(unsigned int slots, int flags)
+static int futex_hash_slots_set(unsigned int slots)
 {
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, flags);
+	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_SET_SLOTS, slots, 0);
 }
=20
 static int futex_hash_slots_get(void)
@@ -41,16 +39,11 @@ static int futex_hash_slots_get(void)
 	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_SLOTS);
 }
=20
-static int futex_hash_immutable_get(void)
-{
-	return prctl(PR_FUTEX_HASH, PR_FUTEX_HASH_GET_IMMUTABLE);
-}
-
 static void futex_hash_slots_set_verify(int slots)
 {
 	int ret;
=20
-	ret =3D futex_hash_slots_set(slots, 0);
+	ret =3D futex_hash_slots_set(slots);
 	if (ret !=3D 0) {
 		ksft_test_result_fail("Failed to set slots to %d: %m\n", slots);
 		ksft_finished();
@@ -64,13 +57,13 @@ static void futex_hash_slots_set_verify(int slots)
 	ksft_test_result_pass("SET and GET slots %d passed\n", slots);
 }
=20
-static void futex_hash_slots_set_must_fail(int slots, int flags)
+static void futex_hash_slots_set_must_fail(int slots)
 {
 	int ret;
=20
-	ret =3D futex_hash_slots_set(slots, flags);
-	ksft_test_result(ret < 0, "futex_hash_slots_set(%d, %d)\n",
-			 slots, flags);
+	ret =3D futex_hash_slots_set(slots);
+	ksft_test_result(ret < 0, "futex_hash_slots_set(%d)\n",
+			 slots);
 }
=20
 static void *thread_return_fn(void *arg)
@@ -111,6 +104,30 @@ static void join_max_threads(void)
 	}
 }
=20
+#define SEC_IN_NSEC	1000000000
+#define MSEC_IN_NSEC	1000000
+
+static void futex_dummy_op(void)
+{
+	pthread_mutex_t lock =3D PTHREAD_MUTEX_INITIALIZER;
+	struct timespec timeout;
+	int ret;
+
+	pthread_mutex_lock(&lock);
+	clock_gettime(CLOCK_REALTIME, &timeout);
+	timeout.tv_nsec +=3D 100 * MSEC_IN_NSEC;
+	if (timeout.tv_nsec >=3D  SEC_IN_NSEC) {
+		timeout.tv_nsec -=3D SEC_IN_NSEC;
+		timeout.tv_sec++;
+	}
+	ret =3D pthread_mutex_timedlock(&lock, &timeout);
+	if (ret =3D=3D 0)
+		ksft_exit_fail_msg("Successfully locked an already locked mutex.\n");
+
+	if (ret !=3D ETIMEDOUT)
+		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret=
);
+}
+
 static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
@@ -128,18 +145,14 @@ int main(int argc, char *argv[])
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
-	int use_global_hash =3D 0;
-	int ret;
+	int ret, retry =3D 20;
 	int c;
=20
-	while ((c =3D getopt(argc, argv, "cghv:")) !=3D -1) {
+	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
 			break;
-		case 'g':
-			use_global_hash =3D 1;
-			break;
 		case 'h':
 			usage(basename(argv[0]));
 			exit(0);
@@ -154,7 +167,7 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(22);
+	ksft_set_plan(21);
=20
 	ret =3D pthread_mutexattr_init(&mutex_attr_pi);
 	ret |=3D pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT=
);
@@ -167,10 +180,6 @@ int main(int argc, char *argv[])
 	if (ret !=3D 0)
 		ksft_exit_fail_msg("futex_hash_slots_get() failed: %d, %m\n", ret);
=20
-	ret =3D futex_hash_immutable_get();
-	if (ret !=3D 0)
-		ksft_exit_fail_msg("futex_hash_immutable_get() failed: %d, %m\n", ret);
-
 	ksft_test_result_pass("Basic get slots and immutable status.\n");
 	ret =3D pthread_create(&threads[0], NULL, thread_return_fn, NULL);
 	if (ret !=3D 0)
@@ -208,8 +217,24 @@ int main(int argc, char *argv[])
 	 */
 	ksft_print_msg("Online CPUs: %d\n", online_cpus);
 	if (online_cpus > 16) {
+retry_getslots:
 		futex_slotsn =3D futex_hash_slots_get();
 		if (futex_slotsn < 0 || futex_slots1 =3D=3D futex_slotsn) {
+			retry--;
+			/*
+			 * Auto scaling on thread creation can be slightly delayed
+			 * because it waits for a RCU grace period twice. The new
+			 * private hash is assigned upon the first futex operation
+			 * after grace period.
+			 * To cover all this for testing purposes the function
+			 * below will acquire a lock and acquire it again with a
+			 * 100ms timeout which must timeout. This ensures we
+			 * sleep for 100ms and issue a futex operation.
+			 */
+			if (retry > 0) {
+				futex_dummy_op();
+				goto retry_getslots;
+			}
 			ksft_print_msg("Expected increase of hash buckets but got: %d -> %d\n",
 				       futex_slots1, futex_slotsn);
 			ksft_exit_fail_msg(test_msg_auto_inc);
@@ -227,7 +252,7 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_verify(32);
 	futex_hash_slots_set_verify(16);
=20
-	ret =3D futex_hash_slots_set(15, 0);
+	ret =3D futex_hash_slots_set(15);
 	ksft_test_result(ret < 0, "Use 15 slots\n");
=20
 	futex_hash_slots_set_verify(2);
@@ -245,28 +270,23 @@ int main(int argc, char *argv[])
 	ksft_test_result(ret =3D=3D 2, "No more auto-resize after manaul setting, g=
ot %d\n",
 			 ret);
=20
-	futex_hash_slots_set_must_fail(1 << 29, 0);
+	futex_hash_slots_set_must_fail(1 << 29);
+	futex_hash_slots_set_verify(4);
=20
 	/*
-	 * Once the private hash has been made immutable or global hash has been re=
quested,
-	 * then this requested can not be undone.
+	 * Once the global hash has been requested, then this requested can not
+	 * be undone.
 	 */
-	if (use_global_hash) {
-		ret =3D futex_hash_slots_set(0, 0);
-		ksft_test_result(ret =3D=3D 0, "Global hash request\n");
-	} else {
-		ret =3D futex_hash_slots_set(4, FH_FLAG_IMMUTABLE);
-		ksft_test_result(ret =3D=3D 0, "Immutable resize to 4\n");
-	}
+	ret =3D futex_hash_slots_set(0);
+	ksft_test_result(ret =3D=3D 0, "Global hash request\n");
 	if (ret !=3D 0)
 		goto out;
=20
-	futex_hash_slots_set_must_fail(4, 0);
-	futex_hash_slots_set_must_fail(4, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(8, 0);
-	futex_hash_slots_set_must_fail(8, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(0, FH_FLAG_IMMUTABLE);
-	futex_hash_slots_set_must_fail(6, FH_FLAG_IMMUTABLE);
+	futex_hash_slots_set_must_fail(4);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(8);
+	futex_hash_slots_set_must_fail(0);
+	futex_hash_slots_set_must_fail(6);
=20
 	ret =3D pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
 	if (ret !=3D 0) {
@@ -277,14 +297,7 @@ int main(int argc, char *argv[])
 	join_max_threads();
=20
 	ret =3D futex_hash_slots_get();
-	if (use_global_hash) {
-		ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
-	} else {
-		ksft_test_result(ret =3D=3D 4, "Continue to use the 4 hash buckets\n");
-	}
-
-	ret =3D futex_hash_immutable_get();
-	ksft_test_result(ret =3D=3D 1, "Hash reports to be immutable\n");
+	ksft_test_result(ret =3D=3D 0, "Continue to use global hash\n");
=20
 out:
 	ksft_finished();
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testin=
g/selftests/futex/include/futextest.h
index ddbcfc9b7bac..7a5fd1d5355e 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif
=20
+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't h=
ave
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex


