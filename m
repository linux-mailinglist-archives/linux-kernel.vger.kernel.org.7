Return-Path: <linux-kernel+bounces-884873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF238C315E6
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 407643A59C0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99F523957D;
	Tue,  4 Nov 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xzkyk9ai";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XY08L3au"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C874176ADE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264831; cv=none; b=AhVqqL6Be4PDPnnutjd3umRYgvHrRouW0+woPmqTH3RwIAQbO3lN5CEOnU2WB1JVdZAgZ4Aok9H7buweDnQRTIby+193gPoYGWrLPi7JNw5cnMY7XRx//x0zPneyVRxdWa1TMclTuTKFp973mlUb6U6vhgR4Qd7pjGGi508x2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264831; c=relaxed/simple;
	bh=QabnL+Mv9bzmVidWIHwC4eXr6/3IlqWFvu4Hz7QmdEM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=InQmBJzQPMUw9Rl5YXVdeITS5ozFuG1ZHBmBE+IAbHR9d1KvjgV2K1wZxZKwPHmtMylutc5a+zbAZUYVshmlYG6okm2awxCkcqAVkKU9Z8H7AuSwLD0k+bJ9JTbDIUkUUWnjsaJGSem8VfU0g52qexIIyEd2yuvguIzeXqIsQH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xzkyk9ai; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XY08L3au; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 4 Nov 2025 15:00:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762264825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZxK9s3GCxPTuzBYPudki95JBbm95126WkXlLNOyy3pc=;
	b=Xzkyk9ai2VUBvd1oV8hAoizoAAKykIf/linC67FlQxcGd+z0SouRjibo+02J+Yg5OyJrZJ
	ggCxETFg9KxFXkTt+tneP+w0gUhALGCyYvvE+THY53NKPWkyf8EsznHbd/s+4vWrs+aNU/
	oyLfL9hM6tZGxJ65oBhR22gffR1mfrlypWfhJE5ZTVi4mgFVSQ0YAFeGRfDBDoYskJKT9T
	XelbF0lkqxelPWPjT4iDfAbK4TSjtorLAbpbTRub6kzvbDGwKGTfBVisqL/BBB/EW6cGyA
	qcowbar3WMOl5dWfARnM659laitmGxYtt20+vpOcanmiJJz7pF1eRe8fNz4xXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762264825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=ZxK9s3GCxPTuzBYPudki95JBbm95126WkXlLNOyy3pc=;
	b=XY08L3aufODJ3ahVeO56DMAH7usM+cxFlNOtmEP6/6HFzN0jRllW26yiDxUyzqkozh3Lfg
	44q8C366+ot7SUBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking/mutex: Redo __mutex_init()
Message-ID: <20251104140023.jV9j77ld@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

mutex_init() invokes __mutex_init() providing the name of the lock and
a pointer to a the lock class. With LOCKDEP enabled this information is
useful but without LOCKDEP it not used at all. Passing the pointer
information of the lock class might be considered negligible but the
name of the lock is passed as well and the string is stored. This
information is wasting storage.

Split __mutex_init() into a _plain() variant doing the initialisation of
the lock and a _ld() version which does _plain() plus the lockdep bits.
Restrict the lockdep version to lockdep enabled builds allowing the
compiler to remove the unused parameter.

This results in the following size reduction:

      text     data       bss        dec  filename
| 30237599  8161430   1176624   39575653  vmlinux.defconfig
| 30233269  8149142   1176560   39558971  vmlinux.defconfig.patched
   -4.2KiB   -12KiB

| 32455099  8471098  12934684   53860881  vmlinux.defconfig.lockdep
| 32455100  8471098  12934684   53860882  vmlinux.defconfig.patched.lockdep

| 27152407  7191822   2068040   36412269  vmlinux.defconfig.preempt_rt
| 27145937  7183630   2067976   36397543  vmlinux.defconfig.patched.preempt_rt
   -6.3KiB    -8KiB

| 29382020  7505742  13784608   50672370  vmlinux.defconfig.preempt_rt.lockdep
| 29376229  7505742  13784544   50666515  vmlinux.defconfig.patched.preempt_rt.lockdep
   -5.6KiB

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/mutex.h        | 45 ++++++++++++++++++++++++++++--------
 kernel/locking/mutex.c       | 22 +++++++++++++-----
 kernel/locking/rtmutex_api.c | 19 +++++++++++----
 3 files changed, 66 insertions(+), 20 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 847b81ca64368..e731ef82aa0a0 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -86,8 +86,23 @@ do {									\
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
-extern void __mutex_init(struct mutex *lock, const char *name,
-			 struct lock_class_key *key);
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_init_ld(struct mutex *lock, const char *name, struct lock_class_key *key);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_ld(lock, name, key);
+}
+#else
+extern void mutex_init_plain(struct mutex *lock);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_init_plain(lock);
+}
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 /**
  * mutex_is_locked - is the mutex locked
@@ -111,17 +126,27 @@ extern bool mutex_is_locked(struct mutex *lock);
 #define DEFINE_MUTEX(mutexname)						\
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
-extern void __mutex_rt_init(struct mutex *lock, const char *name,
-			    struct lock_class_key *key);
-
 #define mutex_is_locked(l)	rt_mutex_base_is_locked(&(l)->rtmutex)
 
-#define __mutex_init(mutex, name, key)			\
-do {							\
-	rt_mutex_base_init(&(mutex)->rtmutex);		\
-	__mutex_rt_init((mutex), name, key);		\
-} while (0)
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+extern void mutex_rt_init_ld(struct mutex *mutex, const char *name,
+			     struct lock_class_key *key);
 
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_ld(lock, name, key);
+}
+
+#else
+extern void mutex_rt_init_plain(struct mutex *mutex);
+
+static inline void __mutex_init(struct mutex *lock, const char *name,
+				struct lock_class_key *key)
+{
+	mutex_rt_init_plain(lock);
+}
+#endif /* !CONFIG_LOCKDEP */
 #endif /* CONFIG_PREEMPT_RT */
 
 #ifdef CONFIG_DEBUG_MUTEXES
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index de7d6702cd96c..5a69d2bd44069 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -43,8 +43,7 @@
 # define MUTEX_WARN_ON(cond)
 #endif
 
-void
-__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
+static void __mutex_init_plain(struct mutex *lock)
 {
 	atomic_long_set(&lock->owner, 0);
 	raw_spin_lock_init(&lock->wait_lock);
@@ -52,10 +51,7 @@ __mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
 	osq_lock_init(&lock->osq);
 #endif
-
-	debug_mutex_init(lock, name, key);
 }
-EXPORT_SYMBOL(__mutex_init);
 
 static inline struct task_struct *__owner_task(unsigned long owner)
 {
@@ -142,6 +138,11 @@ static inline bool __mutex_trylock(struct mutex *lock)
  * There is nothing that would stop spreading the lockdep annotations outwards
  * except more code.
  */
+void mutex_init_plain(struct mutex *lock)
+{
+	__mutex_init_plain(lock);
+}
+EXPORT_SYMBOL(mutex_init_plain);
 
 /*
  * Optimistic trylock that only works in the uncontended case. Make sure to
@@ -166,7 +167,16 @@ static __always_inline bool __mutex_unlock_fast(struct mutex *lock)
 
 	return atomic_long_try_cmpxchg_release(&lock->owner, &curr, 0UL);
 }
-#endif
+
+#else /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+void mutex_init_ld(struct mutex *lock, const char *name, struct lock_class_key *key)
+{
+	__mutex_init_plain(lock);
+	debug_mutex_init(lock, name, key);
+}
+EXPORT_SYMBOL(mutex_init_ld);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 static inline void __mutex_set_flag(struct mutex *lock, unsigned long flag)
 {
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index bafd5af98eaec..43d62b29739fc 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -515,13 +515,11 @@ void rt_mutex_debug_task_free(struct task_struct *task)
 
 #ifdef CONFIG_PREEMPT_RT
 /* Mutexes */
-void __mutex_rt_init(struct mutex *mutex, const char *name,
-		     struct lock_class_key *key)
+static void __mutex_rt_init_plain(struct mutex *mutex)
 {
+	rt_mutex_base_init(&mutex->rtmutex);
 	debug_check_no_locks_freed((void *)mutex, sizeof(*mutex));
-	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
 }
-EXPORT_SYMBOL(__mutex_rt_init);
 
 static __always_inline int __mutex_lock_common(struct mutex *lock,
 					       unsigned int state,
@@ -542,6 +540,13 @@ static __always_inline int __mutex_lock_common(struct mutex *lock,
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
+void mutex_rt_init_ld(struct mutex *mutex, const char *name, struct lock_class_key *key)
+{
+	__mutex_rt_init_plain(mutex);
+	lockdep_init_map_wait(&mutex->dep_map, name, key, 0, LD_WAIT_SLEEP);
+}
+EXPORT_SYMBOL(mutex_rt_init_ld);
+
 void __sched mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
@@ -598,6 +603,12 @@ int __sched _mutex_trylock_nest_lock(struct mutex *lock,
 EXPORT_SYMBOL_GPL(_mutex_trylock_nest_lock);
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 
+void mutex_rt_init_plain(struct mutex *mutex)
+{
+	__mutex_rt_init_plain(mutex);
+}
+EXPORT_SYMBOL(mutex_rt_init_plain);
+
 void __sched mutex_lock(struct mutex *lock)
 {
 	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
-- 
2.51.0


