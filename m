Return-Path: <linux-kernel+bounces-864978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFE9BFBFC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629665085A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E3734B40F;
	Wed, 22 Oct 2025 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4+TVdQJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y5rjh0R6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250D3491C9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761137546; cv=none; b=b+UNWSiFz2BWWrOm1B7R+UWcK2V0yct8tHNy1MiQ6T+48YBaEaQlH5Zf5vUNvhDUvKzTGaWvOcx2teraNYwwGn+nOK4qj7CHh2eUtcZCZ3cKsAVnGkJhGsyfRcOEkPy9AX2bCTakDE900OE+WTs/YU/pi/XOX57if9/7ue32JNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761137546; c=relaxed/simple;
	bh=WGDqby2sqkwgvULx3HGAainFv6gztqVnqcLqL+xhWdA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=tenVpuy1IJAoZnjxL9SnrZOK7miQw3mUDLTwDTjTPpIS/LOC9pYqmSupsSj5NPoWM+QXm5lN3litICTjPAq2XIJ0ghNi3RRAB8xmUQE6F/fZhTEFENWmvIVDJG4Oy8Vm+uQnUXO6AHNeIUhRvP5j1oZffKrdDLSKmL6GsEsKfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4+TVdQJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y5rjh0R6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251022121942.213854365@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761137537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HN07IaFgPRsBdcqOPnZoi/IbPDXu/kN5yAfZuOw92y0=;
	b=r4+TVdQJz0DCzjIDOaTKToGvzEh1zhQfyhh2j6v6NyxhobpBlRzqECcBox73S+2exvx2s9
	qKwfmHwHkArVUf2uxSFVuPcLUrttkpWJj5EC0UgMHG1VN4tL/zK2820MrlYJMjTPqrGNeb
	4flCIUnHktLCwwcLlgDajlkTzgezo5vcSK5dOHasP55tLsAM7OdP0rjWwkZ0l0lwWDS6vD
	iCEQOGF0B6Dn7URHS9xp1cpaRviirDskz/WtdC7vVsvZIpd1Zp6p775m8Wpy7PaPysgMzA
	vzLzI4gxqIg/W67R6vvdW6HsphVc7eGqaTMm/SRldPl4AyOpei1tGBG8RLUvMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761137537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HN07IaFgPRsBdcqOPnZoi/IbPDXu/kN5yAfZuOw92y0=;
	b=y5rjh0R6G+dgvmZoWzVTb08/gjEJL02AnT0dkfNyof5QXLl93nXNTPz6hBSnVe577U8Fw/
	lTOy0jh6hHMNiDDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 x86@kernel.org,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V5 13/31] sched: Move MM CID related functions to sched.h
References: <20251022121836.019469732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Oct 2025 14:52:17 +0200 (CEST)

There is nothing mm specific in that and including mm.h can cause header
recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

---
 include/linux/mm.h    |   25 -------------------------
 include/linux/sched.h |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2401,31 +2401,6 @@ struct zap_details {
 /* Set in unmap_vmas() to indicate a final unmap call.  Only used by hugetlb */
 #define  ZAP_FLAG_UNMAP              ((__force zap_flags_t) BIT(1))
 
-#ifdef CONFIG_SCHED_MM_CID
-void sched_mm_cid_before_execve(struct task_struct *t);
-void sched_mm_cid_after_execve(struct task_struct *t);
-void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
-static inline int task_mm_cid(struct task_struct *t)
-{
-	return t->mm_cid;
-}
-#else
-static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
-static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
-static inline void sched_mm_cid_fork(struct task_struct *t) { }
-static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
-static inline int task_mm_cid(struct task_struct *t)
-{
-	/*
-	 * Use the processor id as a fall-back when the mm cid feature is
-	 * disabled. This provides functional per-cpu data structure accesses
-	 * in user-space, althrough it won't provide the memory usage benefits.
-	 */
-	return raw_smp_processor_id();
-}
-#endif
-
 #ifdef CONFIG_MMU
 extern bool can_do_mlock(void);
 #else
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2310,6 +2310,32 @@ static __always_inline void alloc_tag_re
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
 
+/* Avoids recursive inclusion hell */
+#ifdef CONFIG_SCHED_MM_CID
+void sched_mm_cid_before_execve(struct task_struct *t);
+void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_fork(struct task_struct *t);
+void sched_mm_cid_exit_signals(struct task_struct *t);
+static inline int task_mm_cid(struct task_struct *t)
+{
+	return t->mm_cid;
+}
+#else
+static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_fork(struct task_struct *t) { }
+static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline int task_mm_cid(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the mm cid feature is
+	 * disabled. This provides functional per-cpu data structure accesses
+	 * in user-space, althrough it won't provide the memory usage benefits.
+	 */
+	return task_cpu(t);
+}
+#endif
+
 #ifndef MODULE
 #ifndef COMPILE_OFFSETS
 


