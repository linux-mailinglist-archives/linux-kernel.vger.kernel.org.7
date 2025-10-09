Return-Path: <linux-kernel+bounces-846612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8674BBC8886
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 12:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FA3189385E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 10:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55742C15B0;
	Thu,  9 Oct 2025 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HQ/8/MG1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQbllLXV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738D1EB5FD
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 10:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760006346; cv=none; b=ofbX+zuMO/QgpFwUHm6ecHMMiR9OBoyhzOo8wuHfOrMee2UyzUOI4v0VvPI0pj9kCLFrKKb0dHrb0juFrz8q34LGVHCFIwDjgV4Mv+VxNcX5PxBzX3TwU8E3pogJQpECx1pY1M5Xf/r1qhQyZUA0dXHDGKUiduBd8mJDox0dSOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760006346; c=relaxed/simple;
	bh=4xDv7N+CYbwm99C9G/8SF6Q0gcHMxRfLUr1Je0meFiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fQUlXUkq51d+R8jv8HrXm8zntmfFrz+5EhLMP5fzLqApa4ujQNZIG1+GRtYncP7YJnV2RadwTDir0cKdjxX0NKkWzUrwyJVT4UPlYY+L3zkVnXphzxXtekawYF6VUCjnJ5swcIbyvHeNKjRvutxnEa/wYNhOmOQCX6H1hJTfTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HQ/8/MG1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQbllLXV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 9 Oct 2025 12:39:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760006342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKn+7wyUeKezSPce2OBY20sWcPd+oUaE40PB5KQBzy0=;
	b=HQ/8/MG1hfi8Je6ueqe44S1o8JHUkEi45lsqO2fjPu07daSZEYUkQ5KlgvydI/HM38r/8I
	+MlQnczNCewVxEzGDvT5UMRZAu+M2FJlgoc4jIaKJ6KucFZYfTcxzNiwEuAejQ4/iBykUV
	/aOvkVvCyPpfTZoO0nONNNl+gAEjhgU7tJiJIF8JPVWBEVnCJT3X9Z6yMn7lMTCI8IWo5b
	bAmhIrm1aGU3SDbo6BMBzRKMXY/ixb7LjmC2xabgkREc9L91g+GlHd3JpIuXZAoQTZwgCM
	DuwjVhmMAKDxqaAtpo11rjLLYRSWpvm8nCsXfhKcJLDptmbkuUitqmFMpH7+eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760006342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iKn+7wyUeKezSPce2OBY20sWcPd+oUaE40PB5KQBzy0=;
	b=kQbllLXVwOwsftp5vatyykKf1MG0yLo0iPPYn3rUYgXUuPCuyxYJKC3kb+1/14WpDz355g
	Yz2DvSovIcs6j/Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v3] locking/local_lock: s/l/__l/ and s/tl/__tl/ to reduce
 risk of shadowing
Message-ID: <20251009103900.2Fk8stnM@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Vincent Mailhol <mailhol@kernel.org>

The Linux kernel coding style advises to avoid common variable
names in function-like macros to reduce the risk of collisions.

Throughout local_lock_internal.h, several macros use the rather common
variable names 'l' and 'tl'. This already resulted in an actual
collision: the __local_lock_acquire() function like macro is currently
shadowing the parameter 'l' of the:

  class_##_name##_t class_##_name##_constructor(_type *l)

function factory from linux/cleanup.h.

Rename the variable 'l' to '__l' and the variable 'tl' to '__tl'
throughout the file to fix the current name collision and to prevent
future ones.

[ bigeasy: Rebase, update all l and tl instances in macros ]

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Looks harmless enough to make everyone happy.

v2=E2=80=A6v3:=20
  - Rebase

v1=E2=80=A6v2: https://lore.kernel.org/all/20250925-local_lock_internal_fix=
_shadow-v2-1-d3b85ee775a4@kernel.org/

  - __lock conflicted with an existing definition in lockdep.c. Use
    instead __l (and also, to keep things consistent, use __tl instead
    of tl for the trylock).

  - Apply the renaming to the entire file and not just to
    __local_lock_acquire().

  - Rewrite the patch description accordingly.

v1: https://lore.kernel.org/r/20250923-local_lock_internal_fix_shadow-v1-1-=
14e313c88a46@kernel.org

 include/linux/local_lock_internal.h | 62 ++++++++++++++---------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock=
_internal.h
index a4dc479157b5c..8f82b4eb542f2 100644
--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -99,18 +99,18 @@ do {								\
=20
 #define __local_lock_acquire(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 0);	\
-				WRITE_ONCE(tl->acquired, 1);		\
+				lockdep_assert(__tl->acquired =3D=3D 0);	\
+				WRITE_ONCE(__tl->acquired, 1);		\
 			}),						\
 			local_lock_t *: (void)0);			\
-		local_lock_acquire(l);					\
+		local_lock_acquire(__l);				\
 	} while (0)
=20
 #define __local_lock(lock)					\
@@ -133,36 +133,36 @@ do {								\
=20
 #define __local_trylock(lock)					\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		preempt_disable();				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			preempt_enable();			\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 #define __local_trylock_irqsave(lock, flags)			\
 	({							\
-		local_trylock_t *tl;				\
+		local_trylock_t *__tl;				\
 								\
 		local_irq_save(flags);				\
-		tl =3D (lock);					\
-		if (READ_ONCE(tl->acquired)) {			\
+		__tl =3D (lock);					\
+		if (READ_ONCE(__tl->acquired)) {		\
 			local_irq_restore(flags);		\
-			tl =3D NULL;				\
+			__tl =3D NULL;				\
 		} else {					\
-			WRITE_ONCE(tl->acquired, 1);		\
+			WRITE_ONCE(__tl->acquired, 1);		\
 			local_trylock_acquire(			\
-				(local_lock_t *)tl);		\
+				(local_lock_t *)__tl);		\
 		}						\
-		!!tl;						\
+		!!__tl;						\
 	})
=20
 /* preemption or migration must be disabled before calling __local_lock_is=
_locked */
@@ -170,16 +170,16 @@ do {								\
=20
 #define __local_lock_release(lock)					\
 	do {								\
-		local_trylock_t *tl;					\
-		local_lock_t *l;					\
+		local_trylock_t *__tl;					\
+		local_lock_t *__l;					\
 									\
-		l =3D (local_lock_t *)(lock);				\
-		tl =3D (local_trylock_t *)l;				\
-		local_lock_release(l);					\
+		__l =3D (local_lock_t *)(lock);				\
+		__tl =3D (local_trylock_t *)__l;				\
+		local_lock_release(__l);				\
 		_Generic((lock),					\
 			local_trylock_t *: ({				\
-				lockdep_assert(tl->acquired =3D=3D 1);	\
-				WRITE_ONCE(tl->acquired, 0);		\
+				lockdep_assert(__tl->acquired =3D=3D 1);	\
+				WRITE_ONCE(__tl->acquired, 0);		\
 			}),						\
 			local_lock_t *: (void)0);			\
 	} while (0)
@@ -223,12 +223,12 @@ typedef spinlock_t local_trylock_t;
 #define INIT_LOCAL_LOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
 #define INIT_LOCAL_TRYLOCK(lockname) __LOCAL_SPIN_LOCK_UNLOCKED((lockname))
=20
-#define __local_lock_init(l)					\
+#define __local_lock_init(__l)					\
 	do {							\
-		local_spin_lock_init((l));			\
+		local_spin_lock_init((__l));			\
 	} while (0)
=20
-#define __local_trylock_init(l)			__local_lock_init(l)
+#define __local_trylock_init(__l)			__local_lock_init(__l)
=20
 #define __local_lock(__lock)					\
 	do {							\
--=20
2.51.0


