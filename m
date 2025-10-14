Return-Path: <linux-kernel+bounces-852624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77522BD97B1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 569174FCA21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BF313E0A;
	Tue, 14 Oct 2025 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fZfe/jKP"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665AA28C864
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 12:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760446691; cv=none; b=alAx6utCQ3WY/Q/UFqiAFkIpd9rDYmT1HmBddScNosHedBpMw+CUqCnfVssgtsiAqRiugbk5fr9n/2i3BOusjYDQwo1OCkhpEcGJHZUkhtn7th7BJU+lCVuaj8a2M7ex/P77uVtxeOloGJXDFjLb1bKoe8EDBh6mzx8ZRf94gdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760446691; c=relaxed/simple;
	bh=WG9xl8cvQx0aXoDBA5FaG/AoNHglRTxioB2O17zevds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E6XSZTRccKJ3BdWXfDQgRZsymKOUuA/qNtg+QkfwHjXu9T3rq7jWIOqVfqaZrerIejtayTsf6iMMPwBRooDD7vcziwAEgW6i9YfChkWjMSSED0gkMKbZEFqK7reo4oLJh8T5N3nix74FVuhZbKlsBsRDyrbzoTxY0Awm3pN4bsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fZfe/jKP; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ADE4740B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760446688; bh=6gQSLko4va3cKVQsVdws5JdhCBcMCp2GQ5EcSQlcB/8=;
	h=From:To:Cc:Subject:Date:From;
	b=fZfe/jKPaRdcwQMpimo6ibXOMCMqgD9zInjzoPUqRWn0yykAo0P7ZC9vyzhm43NvL
	 4nl7T4u0oyvlvPHiSjzzB83WnfucgEZ2GVY+dMbNPtjaZgx7mGGZ3D5hc4KUWKcKkt
	 7F6nA1vBNphxuIz6M6wPZLztHZtid056Mb9z4eJKYwYhOoRyF0ejJBzzke8tju9tbm
	 8m2GwSx22nDql7iWIFqffVeeucco/uiYC1M6lEHdKmLzOK3z3iH+B5EGZ+STKxYKDC
	 rpaXxVRN84BSDtWXdlDlBD+fr9GQdFGceBAzHndgSZ95V9LMZNtb5t9VCCwy9b8iuQ
	 3lYIM1fPNNPgQ==
Received: from lwn.net (unknown [IPv6:2601:18c:4300:1ed0::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id ADE4740B1C;
	Tue, 14 Oct 2025 12:58:07 +0000 (UTC)
From: Daroc Alden <daroc@lwn.net>
To: corbet@lwn.net,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Cc: Daroc Alden <daroc@lwn.net>
Subject: [PATCH v2] lock: Add doc comments for spin_lock_*()
Date: Tue, 14 Oct 2025 08:57:08 -0400
Message-ID: <20251014125743.211615-1-daroc@lwn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commonly used spin_lock_*() functions do not currently have any
documentation; this commit adds kerneldoc comments to these functions
describing their behavior and when they are appropriate to use.

Signed-off-by: Daroc Alden <daroc@lwn.net>
---

v1 -> v2: Add documentation for spin_lock() and spin_lock_bh()

---
 include/linux/spinlock.h | 99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e..fd484fb2d310 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -346,11 +346,42 @@ do {						\
 
 #endif
 
+/**
+ * spin_lock() - Lock the provided spinlock.
+ * @lock: The spinlock to acquire.
+ *
+ * This function locks the provided spinlock. It should typically be paired with
+ * a call to spin_unlock().
+ *
+ * If the lock is used by both code running in process context and code running
+ * in interrupt context, spin_lock() should only be called with interrupts
+ * disabled. If in doubt, use spin_lock_irqsave() instead.
+ */
 static __always_inline void spin_lock(spinlock_t *lock)
 {
 	raw_spin_lock(&lock->rlock);
 }
 
+/**
+ * spin_lock_bh() - Disable softIRQs and take the provided spinlock.
+ * @lock: The spinlock to acquire.
+ *
+ * When data is shared between code that can run in process context and code
+ * that can run in a softIRQ, if the softIRQ tries to acquire a spinlock that is
+ * already held, the system could deadlock. This function disables softIRQs
+ * before taking the provided spinlock. It should typically be paired with a
+ * call to spin_unlock_bh() in order to reenable softIRQs when the lock is
+ * released.
+ *
+ * If the interrupt code can run as a hard interrupt instead of a soft
+ * interrupt, this is the wrong function: use spin_lock_irqsave(). If in doubt,
+ * using spin_lock_irqsave() instead of spin_lock_bh() is always permissible,
+ * since the former is a superset of the latter.
+ *
+ * Since tasklets and timers run in softIRQ context already, synchronizing
+ * between a softIRQ and a tasklet or timer can use the plain spin_lock()
+ * function.
+ */
 static __always_inline void spin_lock_bh(spinlock_t *lock)
 {
 	raw_spin_lock_bh(&lock->rlock);
@@ -371,11 +402,47 @@ do {									\
 	raw_spin_lock_nest_lock(spinlock_check(lock), nest_lock);	\
 } while (0)
 
+/**
+ * spin_lock_irq() - Lock a spinlock while disabling interrupts.
+ * @lock: The spinlock that will be locked.
+ *
+ * When a spinlock is shared by code running in interrupt context and process
+ * context, it is important to ensure that interrupts are disabled while the
+ * lock is held. Otherwise, an interrupt handler might attempt to take the lock
+ * while it is already held, leading to a deadlock.
+ *
+ * This function unconditionally disables interrupts on the local CPU, and then
+ * locks the provided spinlock. It is suitable for use in contexts where
+ * interrupts are known to be enabled — because the corresponding unlock
+ * function, spin_unlock_irq(), unconditionally enables interrupts.
+ *
+ * When code can be called with interrupts either enabled or disabled, prefer
+ * spin_lock_irqsave(), which preserves the current state so that it can be
+ * restored when the spinlock is released.
+ */
 static __always_inline void spin_lock_irq(spinlock_t *lock)
 {
 	raw_spin_lock_irq(&lock->rlock);
 }
 
+/**
+ * spin_lock_irqsave() - Lock a lock, disable interrupts, and save current state.
+ * @lock: The spinlock that will be locked.
+ * @flags: An unsigned long to store the current interrupt state.
+ *
+ * When a spinlock is shared by code running in interrupt context and process
+ * context, it is important to ensure that interrupts are disabled while the
+ * lock is held. Otherwise, an interrupt handler might attempt to take the lock
+ * while it is already held, leading to a deadlock.
+ *
+ * This macro disables interrupts on the local CPU if they are enabled, and
+ * then locks the provided spinlock. The previous state of interrupts (enabled
+ * or disabled) is saved in the @flags argument so that it can be restored by
+ * the corresponding call to spin_unlock_irqrestore().
+ *
+ * When code will only be run with interrupts enabled, using spin_lock_irq() can
+ * avoid the need to create a local variable to save the state.
+ */
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
@@ -386,21 +453,53 @@ do {									\
 	raw_spin_lock_irqsave_nested(spinlock_check(lock), flags, subclass); \
 } while (0)
 
+/**
+ * spin_unlock() - Unlock a spinlock.
+ * @lock: The spinlock that will be unlocked.
+ *
+ * This function unlocks the provided spinlock, and is typically paired with a
+ * previous call to spin_lock().
+ */
 static __always_inline void spin_unlock(spinlock_t *lock)
 {
 	raw_spin_unlock(&lock->rlock);
 }
 
+/**
+ * spin_unlock_bh() - Unlock a spinlock and enable softIRQs.
+ * @lock: The spinlock that will be unlocked.
+ *
+ * This function unlocks the provided lock, and then enables softIRQ handling on
+ * the current CPU. It should typically correspond to a previous call to
+ * spin_lock_bh().
+ */
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
 {
 	raw_spin_unlock_bh(&lock->rlock);
 }
 
+/**
+ * spin_unlock_irq() - Unlock a spinlock and enable interrupts.
+ * @lock: The spinlock that will be unlocked.
+ *
+ * This function unlocks the provided lock, and then unconditionally enables
+ * interrupts on the current CPU. It should typically correspond to a previous
+ * call to spin_lock_irq().
+ */
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
 {
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
+/**
+ * spin_unlock_irqrestore() - Unlock a spinlock and restore interrupt state.
+ * @lock: The spinlock that will be unlocked.
+ * @flags: The previously saved interrupt state to restore.
+ *
+ * This function unlocks the provided lock, and then restores interrupts to
+ * whichever state (enabled or disabled) is indicated by @flags. @flags should
+ * come from a previous call to spin_lock_irqsave().
+ */
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 {
 	raw_spin_unlock_irqrestore(&lock->rlock, flags);
-- 
2.51.0


