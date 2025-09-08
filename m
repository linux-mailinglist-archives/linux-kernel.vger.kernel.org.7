Return-Path: <linux-kernel+bounces-806802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC3AB49C03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 395654E7F19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D842F0C6C;
	Mon,  8 Sep 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqRtt6cN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7KkUfEjB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212652EDD4D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367115; cv=none; b=EvSTQ2gz+mtNWSm9W94Rzt5WDpTPYHM+9o3VHWXErFysAdQKz6LYFpgi5p9KGyAQBON0GlDyFb1RQibwIORDnP+P521TjaqKBh0OvejvhvUqWR2aN1zZFihamC51LXm0UB3yQ6Kij5k8oxNNv+lfyMvdlEZPGsqjEnswIX5Z3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367115; c=relaxed/simple;
	bh=vInnzMqPybK1ummHrFjfcHfjGf4VkT8rfq8nLfrp05o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=I46D0bxXP8RwHgji2mkm50sjkAIB0A1ae+L5vhAk3rym3BnJRFgUaks93D/E7BGQySB3qLh9qn5k64LHSiBmmsNHC8+u9Uw/hmZkJxP5mQ57VczzwoEKEgGvYBU0PNIt20kV37UobJ5VrcIlywRjd2iUmB+k8RHjPqnCuOOSDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqRtt6cN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7KkUfEjB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.097283837@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=n0r2FmgCsW3ZWm0L9APTnFmRENA25P03CAT4E+VOv08=;
	b=aqRtt6cN4/2ftVKixH9jfHAQL+C4O1+gd7uDCcDQoiiE3up4yZfT76hDDBMM5eZdjJJnM+
	73t1o5LhDoGEAE6l2FwBisuHa3pE8Q/U27uYtN/x60xvouMSZv3eq2vx5kUHJzzLp61xVS
	wAS78gDKkmFwYQn5Z/BPXgP4o8BcKTu24V9NAI/Fnb4LqwYYH+UXpF66601GS9P29SGpIh
	v12kIriFAxKJcx5k9G8bqab6cFna1gNOtdfF0FddpCtseukodzVUCkaEPdJS9DXox1oeuG
	ti/YNKuRi3y99LFTaGp0blJx5VgY4id8fEOxIJ5vR/kEOyHQhpPQn5mVi1xRtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=n0r2FmgCsW3ZWm0L9APTnFmRENA25P03CAT4E+VOv08=;
	b=7KkUfEjBSrDEBozkiGfgEe6Ppn6sPF50FfuDY1HrZUXz7LgWed+AzLK411T6jnHPJGtuOH
	nlOhnjPxOIduVXBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>,
 Jens Axboe <axboe@kernel.dk>,
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
Subject: [patch V4 13/36] sched: Move MM CID related functions to sched.h
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:51 +0200 (CEST)

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
@@ -2304,4 +2304,30 @@ static __always_inline void alloc_tag_re
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


