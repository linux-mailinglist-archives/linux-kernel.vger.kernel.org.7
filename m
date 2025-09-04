Return-Path: <linux-kernel+bounces-801749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF88B44982
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2013189C589
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 444AF2E8B91;
	Thu,  4 Sep 2025 22:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fJGgmo4m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AICHyGuU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E662EB5C8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024462; cv=none; b=MPk5lW/jIWG0LyRlzWkYI+YcQWceo83zJ+h/bPaXYnJfSIah1HWUwr3Pp2iD3AE+22lkEYuQ5FNVZ5o8Owa6abQImpeofOwPojmnOI5pI4eZ2vzxbICZb8Ecad14CLuVov0k+DePFAQenT1MZwl1idg1Neqd3KdnyZY0eJxgUrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024462; c=relaxed/simple;
	bh=4TMu2/9nFpnTKORzAtnnCpoXWjuB3AFXtUp5tIvzPiE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gcAsFnZlq7nzA8lQWIpjq8yrHxnvtFcYYa0RGCLe2CVFexC7ttkzqOj5sCyathTDziti1vp12O+EMZQFI79+iTRncJvEBC6kiJ5u88gbOlOtmNT0BmtheXCwaNdrr7m51wDQ3ex0ox9YF4/wBcKFv7rXyd9uzhHm12/MYbdCyis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fJGgmo4m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AICHyGuU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185719.961863321@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kqOSMq0vTbhzwxvAZcikdoYPb7eg08iBhWKSet1Kk4E=;
	b=fJGgmo4mOhyp1Gz0BY8eEftN4DwQa0KEGYAu4vQyU6yp8UTburKTTuRweLwxKVYA7SDKR2
	Omp/lNtrptpjWwNCR+juufsPZTtgjJXNl3rYSQQBVr1YxHXurwyX9waS/xEKAG/6e0CayZ
	kRYk9orD7VdDkkcKgg0ZcAE0P4+21aznTF/ZEtmQW/i8M2+tLWIyABqwaA9KMgjxbbMILC
	nsMqmsZpkgl3iXcZXHrQsOSyHrhK87HjMYlNzGM6AanRIwjHWX9JyRxmdQYKl6PjKnV4VF
	Doi2l0A/K3l/k5DRsRizasifWoACPQahdRfmRnP/6lWYrC+UZExswNpH/IJTNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=kqOSMq0vTbhzwxvAZcikdoYPb7eg08iBhWKSet1Kk4E=;
	b=AICHyGuUiF60gObq3NT/2tC6IA2zJdmUuw3Pei79qPyQBAn85wZ5AYImY3Zb8OURfpx9BW
	Zx8Jf+LmZKejaWCw==
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
Subject: [patch V3 13/37] sched: Move MM CID related functions to sched.h
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:20:58 +0200 (CEST)

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



