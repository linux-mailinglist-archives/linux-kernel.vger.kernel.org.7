Return-Path: <linux-kernel+bounces-848823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95012BCEA4B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39797544135
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 21:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D342303C8D;
	Fri, 10 Oct 2025 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VEm1OyRV"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364FC263F5F
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760133283; cv=none; b=W5m/U4BnPaOhoZoHq7+5aG7W+WtorOGF99L6RP+H3OyVFxyPloHAUi2sslRgE8BtqWgqlBDsBm6Ido4Fe7zA4sYlWhGP4wmJ8EAWtKfB8w3IertiUCxld6+dJxSEuyppwxLVsh4AfSbnsZcFHKSolhiX4UE4E85rknq46wXuW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760133283; c=relaxed/simple;
	bh=TQhN5+VBAldqzha0yZZbUznpZu+Wfy02Ms1cw1wu/14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=anjY9RkXeC4zR54JNs1HA5ixvRUJBbGa3fuav+XVKS59JwdNAdqce0f+lxQRmUrr5GxIQpRp5ZCriLUB0+BWhGixkq5G9NHCD1wVRlrxEpDHwUmYYa0E9cYFYLeztu6iize1svCCrPYrdtZ6ciI535YKGIerK4SKD7In0ecICyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VEm1OyRV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C2A8540B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1760133273; bh=hRrb34XD5dxoecrJ/PIbMxd3WSJmNZn5QPlxXsYVJTA=;
	h=From:To:Cc:Subject:Date:From;
	b=VEm1OyRVV7NdRb3aQq7uF0+uN0LSSPBPbH2YTtZVLVxiNSDybB0Zb22Ecx0z09djk
	 8TDZ2stdHBtpYxSGDuZ3vFMVu3ZqFOc6Kmuo7qfF/fX//lIWmI3DsGB9dCNylr5Jd3
	 dhJQcpM8kSK08YmJVAVBG61lhe/nwhyHyHFw/G5rCWJpJbVwgrpn3TC2N6Xa1qc06k
	 aUW0CM0nDdO5oCVEUGqr4f9bqrCNzI2j9LGuzu87GKNk+zqy+DgZ46q1GYFEQtN6K4
	 iiPTXte8tnTXXGOOXQoQvK6XaNJxRg6wcOxE7Ep2RwloXcvYqjvEMrgceaUscPZSQC
	 vKzOSNURVWKMg==
Received: from lwn.net (c-76-118-42-142.hsd1.nh.comcast.net [76.118.42.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C2A8540B1C;
	Fri, 10 Oct 2025 21:54:32 +0000 (UTC)
From: Daroc Alden <daroc@lwn.net>
To: corbet@lwn.net,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org (open list:LOCKING PRIMITIVES)
Cc: Daroc Alden <daroc@lwn.net>
Subject: [PATCH] lock: Add doc comments for spin_lock_irq()
Date: Fri, 10 Oct 2025 17:53:58 -0400
Message-ID: <20251010215403.743811-1-daroc@lwn.net>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The commonly used spin_lock_irq(), spin_lock_irqsave(),
spin_unlock_irq(), and spin_unlock_irqrestore() functions do not
currently have any documentation; this commit adds kerneldoc comments
to these four functions describing when their behavior and when they are
appropriate to use.

Signed-off-by: Daroc Alden <daroc@lwn.net>
---
 include/linux/spinlock.h | 53 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index d3561c4a080e..35bd55605319 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -371,11 +371,47 @@ do {									\
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
+ * This function disables interrupts on the local CPU if they are enabled, and
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
@@ -396,11 +432,28 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
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


