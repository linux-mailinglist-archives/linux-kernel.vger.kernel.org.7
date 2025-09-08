Return-Path: <linux-kernel+bounces-806803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDFB49C05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B073A4E7F6D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902AA30594F;
	Mon,  8 Sep 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aqPcr7Yd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8HXkL4OD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D42F83A3
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 21:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757367117; cv=none; b=jYZ967DGmDheq36xuxYvNQym9WhbOvY40dwQ+vyyJb4K9qxV6TBwMjJFGFukjgxCSg8ULq+hBe33mLn75rM5OZqK2dPrF5QA8z6h6u0ZvepVeO7H0yl7E6s+u2EA1goFyushPaOPQzf4uOItBihBQqr3cFvgk5QhiRSec5jM8Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757367117; c=relaxed/simple;
	bh=us0lJZSi0YdJzMmY/+wIan8gMOec2mmLO/0F5c4BWRQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MJCQgzNb/1W8Z+FOmFHkcopGHGLmHtFDeqjtFI+sYUPvsLODIcGwCfDvyuvx8A07d/9c67eZ26xSNv+f6upmXfG9fd9QxO5Cv88uDYFkOVHEHY76W7dlbIuM8BuBXFZ/YAaZG3GP7QqVemTbwOYTbceA7rgT6UzQ+bo168vtcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aqPcr7Yd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8HXkL4OD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250908212926.161186107@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757367114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PRK871eknx0DnqW47zmO1iP6FTT6gf2pRp0/yzQ3CF4=;
	b=aqPcr7YdxS7Tjp6UeMrhg0ImveigVLTRIGj/gWUY+2VZxItmhTPmClpIZKT9lPq3YZc1U2
	y0yG5bMPoatZd4ZrLRJSahscqxnKZQ4YC8lHy/YRleH7B07OzMt01MRlZbaVzJSAZtBvyW
	su5btTAUlQrTv5qCOOPT2j8p1jI7Txo9+/ROZWx7M+ib4m2HCQbtRS2ywrwIC0R75hh1pJ
	9YKrYTtOunRcJIABXG2eaYPy0xsONoD8E96pLpp9CabdR4K9LUAMcoBBGa8AefTYUwTqY4
	EhcwkE9cdtkoExE6buwPpyMTQ+sAzFhelclt8LAYjrDWBfeA2fmcaHYI/kskQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757367114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=PRK871eknx0DnqW47zmO1iP6FTT6gf2pRp0/yzQ3CF4=;
	b=8HXkL4ODE/QQ/FD3wYPfzBon1f1PuvtbKBVV64x85QisU+neezkvqL30eJbbaQrOfebVyQ
	AYmXTbRJZlbY/0Bw==
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
Subject: [patch V4 14/36] rseq: Cache CPU ID and MM CID values
References: <20250908212737.353775467@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  8 Sep 2025 23:31:53 +0200 (CEST)

In preparation for rewriting RSEQ exit to user space handling provide
storage to cache the CPU ID and MM CID values which were written to user
space. That prepares for a quick check, which avoids the update when
nothing changed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/linux/rseq.h        |    7 +++++--
 include/linux/rseq_types.h  |   21 +++++++++++++++++++++
 include/trace/events/rseq.h |    4 ++--
 kernel/rseq.c               |    4 ++++
 4 files changed, 32 insertions(+), 4 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -57,6 +57,7 @@ static inline void rseq_virt_userspace_e
 static inline void rseq_reset(struct task_struct *t)
 {
 	memset(&t->rseq, 0, sizeof(t->rseq));
+	t->rseq.ids.cpu_cid = ~0ULL;
 }
 
 static inline void rseq_execve(struct task_struct *t)
@@ -70,10 +71,12 @@ static inline void rseq_execve(struct ta
  */
 static inline void rseq_fork(struct task_struct *t, unsigned long clone_flags)
 {
-	if (clone_flags & CLONE_VM)
+	if (clone_flags & CLONE_VM) {
 		rseq_reset(t);
-	else
+	} else {
 		t->rseq = current->rseq;
+		t->rseq.ids.cpu_cid = ~0ULL;
+	}
 }
 
 #else /* CONFIG_RSEQ */
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -31,17 +31,38 @@ struct rseq_event {
 };
 
 /**
+ * struct rseq_ids - Cache for ids, which need to be updated
+ * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
+ *		compiler emit a single compare on 64-bit
+ * @cpu_id:	The CPU ID which was written last to user space
+ * @mm_cid:	The MM CID which was written last to user space
+ *
+ * @cpu_id and @mm_cid are updated when the data is written to user space.
+ */
+struct rseq_ids {
+	union {
+		u64		cpu_cid;
+		struct {
+			u32	cpu_id;
+			u32	mm_cid;
+		};
+	};
+};
+
+/**
  * struct rseq_data - Storage for all rseq related data
  * @usrptr:	Pointer to the registered user space RSEQ memory
  * @len:	Length of the RSEQ region
  * @sig:	Signature of critial section abort IPs
  * @event:	Storage for event management
+ * @ids:	Storage for cached CPU ID and MM CID
  */
 struct rseq_data {
 	struct rseq __user		*usrptr;
 	u32				len;
 	u32				sig;
 	struct rseq_event		event;
+	struct rseq_ids			ids;
 };
 
 #else /* CONFIG_RSEQ */
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
 	),
 
 	TP_fast_assign(
-		__entry->cpu_id = raw_smp_processor_id();
+		__entry->cpu_id = t->rseq.ids.cpu_id;
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
-		__entry->mm_cid = task_mm_cid(t);
+		__entry->mm_cid = t->rseq.ids.mm_cid;
 	),
 
 	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -184,6 +184,10 @@ static int rseq_update_cpu_node_id(struc
 	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
 	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
 
+	/* Cache the user space values */
+	t->rseq.ids.cpu_id = cpu_id;
+	t->rseq.ids.mm_cid = mm_cid;
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if


