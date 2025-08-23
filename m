Return-Path: <linux-kernel+bounces-783243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF7AB32AF4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422163AAE9F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656512EDD7B;
	Sat, 23 Aug 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bzoOKFvK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s04sxqff"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083E2ED86F
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967182; cv=none; b=J9zUePtByDvpFCisAtagkHU0XGTx7WaVQMMN4kPHBMXWnBhZKM07DDN2C5lY1JeJERYaZqEPsdnaKN8dCExDdu/4Z1ADK3OlsTkIHnrxetKnus4XpbYTuUlja1+mCd9ksmbUPOZ1Wska7xY7mKhwnHbjhCFOjBLSB4ED8EsLUjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967182; c=relaxed/simple;
	bh=zWogiLI32y56lyIiiKjVJfTGiLOGPR+uyhBbkbNIWZU=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=B9n3FBbVd7uYdQm6dtEqlKQO14jEeexnrqq/fFv2BIir+WowmMLI/o/Eym2CjViCmsdy4cWuBuYyKqhZi5rwDcdefxwdbA+uglKl16TCcak/z4TxgyZr9LplxryDLyr/OM0DkX2rRwmUAhs8AEjNvvUTlotAnPz4xCEhrCxDUmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bzoOKFvK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s04sxqff; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.102905434@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vB4qNxPbyFropiAHJLd8M6UT1xH4V1GwhPc78Lrvq8o=;
	b=bzoOKFvKS6x7oIJF2E8Zc1xUcD0AXATAT+E4ENkA66f1DYETeUKpxtL53H9Gx5/tlUhx4B
	UM1ckkI9CZhVVYSTzuihY9ajUgPnqsUdFu2h+Oihls27MX3PG1jCwojbt+nlUvpftvYuVp
	vOzVIdkh9OX6Ld38FFWAAMfDN4tGYyXbJcHPW2WpkbsCWZ91udIQlVtQq7sQJP84U61pVy
	1/30Im5sfTf5749rhaM28ndEDq7V6kcsJpQbqra+SNRiBg75OHEq3kq6y3EUK8h/IHD9w4
	QSERRQgbF4fse6oljCBKa2p08bnD8k+ib+uGN3GG8X3IGp5ZkFrpwZe4AAly9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=vB4qNxPbyFropiAHJLd8M6UT1xH4V1GwhPc78Lrvq8o=;
	b=s04sxqffLOX+qMiFotU4AoDHxscXxMxQthDN+rOaLSDCr5p6ZObTqk7hXmhCzmziPg6X1s
	+vrzWFulbcrNcPDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [patch V2 13/37] sched: Move MM CID related functions to sched.h
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:37 +0200 (CEST)

There is nothing mm specific in that and including mm.h can cause header
recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/mm.h    |   25 -------------------------
 include/linux/sched.h |   26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2310,31 +2310,6 @@ struct zap_details {
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
@@ -2309,4 +2309,30 @@ static __always_inline void alloc_tag_re
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
 #endif


