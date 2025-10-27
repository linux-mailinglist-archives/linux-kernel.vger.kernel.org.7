Return-Path: <linux-kernel+bounces-871100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BCFC0C739
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20CE14F1D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC59130FF3B;
	Mon, 27 Oct 2025 08:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kg9yAJCX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FFs6yROI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E542F12C5
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554687; cv=none; b=Gp5YcnnYzBosVwJdPl5OYPF00XuSghdfLJQ8x7m3brUQAXXKn++R7HtUAcxMHOK72A/TbJa2XEWjlm1KjdeCsFc2YADnjZy0ZTYdpQcdSNHbDsNXfa3GisSvb8mPbHgP0H/GVDwH5GrMiPDc/YPSR6THUgNmftWLo3PspToSsng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554687; c=relaxed/simple;
	bh=WGDqby2sqkwgvULx3HGAainFv6gztqVnqcLqL+xhWdA=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=PLi3F4o9foYLKus+s1e/jeRxICgVLJPZd5Tt9KI96NhWWrIcM5pFxLLEduEILi0crYUxJ8eZ0vacXLc3f5dsDvW5hhtxcfsSiuOSumsSrwt7mT2+p6aIfFdICgGWgkTj2UlSFB/qMutR8ItaydDeqZeyeLCMTjIRsrYnl2TVlgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kg9yAJCX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FFs6yROI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.778457951@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HN07IaFgPRsBdcqOPnZoi/IbPDXu/kN5yAfZuOw92y0=;
	b=Kg9yAJCXbTFeZedIyxcY15p/uTlkhRZ0c/T2axPzGuF3a8d4D84wFgV4Q38qVBsGyFjvcl
	FRS89g8EvCx/pB4BlDVglHIYLyubRjP5mxknU//gPi7G9BG3R5wthR9CTgJ3lmitJZPJMX
	TMM35lzfr4cgQfls56wkcGvGY2SluhpxQBjY/9SF3ng/bIuRQlbSk004USffozPtP0CBM7
	IzYklXJNSQG/GpmcH8Su9bCPmQY4g+bu7LGvz4FKRYfN9ioyHHQNRkgOVbhyP+biPRGhOL
	JOItz/NEfdB1cllSekJ/MGsMnQuUPX4x4HWg5UPKFoa/bRf6pgWxomLfWC5Uxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HN07IaFgPRsBdcqOPnZoi/IbPDXu/kN5yAfZuOw92y0=;
	b=FFs6yROI6egPXN8nWOiGawcwL6lmdLlQJrsgVgFmt6EdJZmH1Xrkish0Qgp632Q1FEhjX+
	Jpff3RP21axzZIAw==
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
Subject: [patch V6 13/31] sched: Move MM CID related functions to sched.h
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:42 +0100 (CET)

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
 


