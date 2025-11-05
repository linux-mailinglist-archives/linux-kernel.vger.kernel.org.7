Return-Path: <linux-kernel+bounces-886598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3A8C360AF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 300724F6E8F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24408326D42;
	Wed,  5 Nov 2025 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJp4djmW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFXvyqis"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7B322A1F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352635; cv=none; b=DLtk9zb+DrsWQ6IO1FQFCzDXykegLEUYRUWR66lCX1u9AlgCkV2PQgxbLMkO85+JcgOhdXuZ/8XhAFNgyrBIIYVON2PRdODF5IVNfyY0iPAmn8Qe4XJ6/r8Dd2+cYnizMvYTIJ4a8WExhJ2HmV9uGz8/675xHVqzy/ETurvGqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352635; c=relaxed/simple;
	bh=ORa2mc535ki4VMcqM25iJIzQMzqPwUPst2CgyjSCA9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CdPHpjuT7/yXpj92r8ZT5ivSvKzD5vFysH+4sTpATOuwAD3I6LB7902K1sXKLeWx02Vk2aqhgipicSHW26dqWgS0CaLDnkt6ONfO6DLV0/eMprszq4g9BR+DiIa2PDX0Fs5ZcQwf8Vg/ulOloIoase/dmKKDYmqdZwDfekCJCqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJp4djmW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFXvyqis; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 5 Nov 2025 15:23:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762352631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+juK1+gRSqfbuSXsQTPBdpEKeJJQ3k7UNEjWqXNTIcM=;
	b=HJp4djmW5iRlZBVpPJHJx6Eu/jzjLq+gk75Qs6XZKavssYsXAQgIfOhKumQjqlmaTX/3fN
	5nVTwBlqOjoQpjajyXr/kv8BNE7mcxDSIcWiej8aWm0XVznTjl/qtuhb0n2cUxeLxvKjPa
	HygRJTMXGv1RtZS5uTZ+znsMnwapehDZSmZIxoHNGCsh/T88ceNYagkvpmJbAkGGc5BCQU
	f9KXEZJkIyzQNKveh/Zew3o+piC/1sVCZnsHC2OuF/ujDqBjaC1RHgkpGTR4F8UcYThJ7D
	mqTejTBLdm0332AwqLkSg6s2veOtertzMBponFBiCfYGtGezol8JWAFyq38NYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762352631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+juK1+gRSqfbuSXsQTPBdpEKeJJQ3k7UNEjWqXNTIcM=;
	b=nFXvyqisiUNtbl00k/3i3smaai3wygnP+kWYhqDuRY5ggUIUZwESfB9OQ4d5AeKzfjBe9G
	p9zod+Jrl9118wAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Waiman Long <llong@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v2] locking/mutex: Redo __mutex_init()
Message-ID: <20251105142350.Tfeevs2N@linutronix.de>
References: <20251104140023.jV9j77ld@linutronix.de>
 <4207482b-fc63-4db7-ab98-36b31a600173@redhat.com>
 <20251105075729.SJ4cL1rz@linutronix.de>
 <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <10899bd0-09ca-4fcf-8142-3d5cd6e4fedf@redhat.com>

mutex_init() invokes __mutex_init() providing the name of the lock and
a pointer to a the lock class. With LOCKDEP enabled this information is
useful but without LOCKDEP it not used at all. Passing the pointer
information of the lock class might be considered negligible but the
name of the lock is passed as well and the string is stored. This
information is wasting storage.

Split __mutex_init() into a _genereic() variant doing the initialisation
of the lock and a _lockdep() version which does _genereic() plus the
lockdep bits. Restrict the lockdep version to lockdep enabled builds
allowing the compiler to remove the unused parameter.

This results in the following size reduction:

      text     data       bss        dec  filename
| 30237599  8161430   1176624   39575653  vmlinux.defconfig
| 30233269  8149142   1176560   39558971  vmlinux.defconfig.patched
   -4.2KiB   -12KiB

| 32455099  8471098  12934684   53860881  vmlinux.defconfig.lockdep
| 32455100  8471098  12934684   53860882  vmlinux.defconfig.patched.lockdep

| 27152407  7191822   2068040   36412269  vmlinux.defconfig.preempt_rt
| 27145937  7183630   2067976   36397543  vmlinux.defconfig.patched.preempt=
_rt
   -6.3KiB    -8KiB

| 29382020  7505742  13784608   50672370  vmlinux.defconfig.preempt_rt.lock=
dep
| 29376229  7505742  13784544   50666515  vmlinux.defconfig.patched.preempt=
_rt.lockdep
   -5.6KiB

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2:
  - s/_init_ld/_init_lockep/
  - s/_init_plain/_init_generic/

 include/linux/mutex.h        | 45 ++++++++++++++++++++++++++++--------
 kernel/locking/mutex.c       | 22 +++++++++++++-----
 kernel/locking/rtmutex_api.c | 19 +++++++++++----
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 847b81ca64368..bf535f0118bb8 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -86,8 +86,23 @@ do {									\
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
=20
-extern void __mutex_init(struct mutex *lock, const char *name,
-			 struct lock_class_key *key);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_c=
lass_key *key);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_lockep(lock, name, key);
+}
+#else
+extern void mutex_init_generic(struct mutex *lock);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_generic(lock);
+}
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 /**
  * mutex_is_locked - is the mutex locked
@@ -111,17 +126,27 @@ extern bool mutex_is_locked(struct mutex *lock);
 #define DEFINE_MUTEX(mutexname)						\
 	struct mutex mutexname =3D __MUTEX_INITIALIZER(mutexname)
=20
-extern void __mutex_rt_init(struct mutex *lock, const char *name,
-			    struct lock_class_key *key);
-
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
=20
-#define __mutex_init(mutex, name, key)			\
-do {							\
-	rt_mutex_base_init(&(mutex)->rtmutex);		\
-	__mutex_rt_init((mutex), name, key);		\
-} while (0)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void mutex_rt_init_lockdep(struct mutex *mutex, const char *name,
+			     struct lock_class_key *key);
=20
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_lockdep(lock, name, key);
+}
+
+#else
+extern void mutex_rt_init_generic(struct mutex *mutex);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_generic(lock);
+}
+#endif /* !CONFIG_LOCKDEP */
 #endif /* CONFIG_PREEMPT_RT */
=20
 #ifdef CONFIG_DEBUG_MUTEXES
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d6702cd96c..f3bb352a368d9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -43,8 +43,7 @@
 # define MUTEX_WARN_ON(cond)
 #endif
=20
-void
-__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *=
key)
+static void __mutex_init_generic(struct mutex *lock)
 {
 	atomic_long_set(&lock->owner, 0);
 	raw_spin_lock_init(&lock->wait_lock);
@@ -52,10 +51,7 @@ __mutex_init(struct mutex *lock, const char *name, struc=
t lock_class_key *key)
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
-
-	debug_mutex_init(lock, name, key);
 }
-EXPORT_SYMBOL(__mutex_init);
=20
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
@@ -142,6 +138,11 @@ static inline bool __mutex_trylock(struct mutex *lock)
  * There is nothing that would stop spreading the lockdep annotations outw=
ards
  * except more code.
  */
+void mutex_init_generic(struct mutex *lock)
+{
+	__mutex_init_generic(lock);
+}
+EXPORT_SYMBOL(mutex_init_generic);
=20
 /*
  * Optimistic trylock that only works in the uncontended case. Make sure to
@@ -166,7 +167,16 @@ static __always_inline bool __mutex_unlock_fast(struct=
 mutex *lock)
=20
 	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
-#endif
+
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+void mutex_init_lockep(struct mutex *lock, const char *name, struct lock_c=
lass_key *key)
+{
+	__mutex_init_generic(lock);
+	debug_mutex_init(lock, name, key);
+}
+EXPORT_SYMBOL(mutex_init_lockep);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
=20
 static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
 {
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index bafd5af98eaec..59dbd29cb219b 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -515,13 +515,11 @@ void rt_mutex_debug_task_free(struct task_struct *tas=
k)
=20
 #ifdef CONFIG_PREEMPT_RT
 /* Mutexes */
-void __mutex_rt_init(struct mutex *mutex, const char *name,
-		     struct lock_class_key *key)
+static void __mutex_rt_init_generic(struct mutex *mutex)
 {
+	rt_mutex_base_init(&mutex->rtmutex);
 	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
-	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
-EXPORT_SYMBOL(__mutex_rt_init);
=20
 static __always_inline int __mutex_lock_common(struct mutex *lock,
 					       unsigned int state,
@@ -542,6 +540,13 @@ static __always_inline int __mutex_lock_common(struct =
mutex *lock,
 }
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_rt_init_lockdep(struct mutex *mutex, const char *name, struct l=
ock_class_key *key)
+{
+	__mutex_rt_init_generic(mutex);
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(mutex_rt_init_lockdep);
+
 void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
@@ -598,6 +603,12 @@ int __sched _mutex_trylock_nest_lock(struct mutex *loc=
k,
 EXPORT_SYMBOL_GPL(_mutex_trylock_nest_lock);
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
=20
+void mutex_rt_init_generic(struct mutex *mutex)
+{
+	__mutex_rt_init_generic(mutex);
+}
+EXPORT_SYMBOL(mutex_rt_init_generic);
+
 void __sched mutex_lock(struct mutex *lock)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
--=20
2.51.0


