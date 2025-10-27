Return-Path: <linux-kernel+bounces-871101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F842C0C6F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3292334B925
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9A32F1FD0;
	Mon, 27 Oct 2025 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ip6vB+oQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0EJj9wPZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07A3101B4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554689; cv=none; b=K5+9NoZYq+XNK/iG6DVyQKaP6afXsEtdH1ckfjDqKJDhm9SnY0X61MnllWgYjsdvjCQQIoGWOORn3eS0yXtYEGu7N3H/KxDOTfe4svTEUHf1Axq/eCDN0L1v1SMr2xhpmi8sPaMN2VB1l9DkzDk5IofwZ8VmQeMmYfu0ScxxS0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554689; c=relaxed/simple;
	bh=GG5Bv0Y2h1NKF25hTLaz2kxBPCflNHAcQQRA1XAgEwg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=elxXEpQjWQzzRwyhbsYRVC3yOH2GCtRwq452TIDRO+ZK+4GIXJ9dq1j3FUQhT28vaVBm/5uqA4GlniJfyHKLMzlEKGYMzx56I1lem8hlkRuZRpqRd1fh2sibzxKlraamZrm8AqszxTuHiIhUfaNUROwAYHYyC6r6D+CMaxPqb4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ip6vB+oQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0EJj9wPZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20251027084306.841964081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zCmxAB/ZIVgxIt9ekfQ3JOgTrp6uLH4pflx9bdIF0b4=;
	b=Ip6vB+oQjQmq5iVlFrJjE0zFOpB2ec3WSLDIqcEiN5K695uaQRmzJM7EWunISswmPoi3R7
	3Qk8yBYmUYZjIzSjBCB3FBtEyxtzCXpmQPC2C7S4QCz/WaDJx8y6I47pB6lFadTCUqtdzR
	0kLdgegsaLeToAR5+PnuH8jhLELxeINCqFwkiSIqTkFZUJAswJzm6SpHYUWMT8vBSQ2KVr
	3uXlWWE61hMZ0R9aTsoKarCpG5ZbIbXUrzi0GZZkeyvN2lmO5+FaHPN786tPDUeqMpB+pu
	ZZKyaOoqrZB+KWd0VOoRvqheRiBnfDrs1wboaF4VnZ2HV3OlHgqhfY8EEYnqiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=zCmxAB/ZIVgxIt9ekfQ3JOgTrp6uLH4pflx9bdIF0b4=;
	b=0EJj9wPZdhshATLHn5uDDHmj3z/gaaK98xEzoV3v86zApzXYNXQY4dAMZOMaBtoE17W9EG
	dpmz/Ym8snfupvBg==
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
Subject: [patch V6 14/31] rseq: Cache CPU ID and MM CID values
References: <20251027084220.785525188@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Oct 2025 09:44:45 +0100 (CET)

In preparation for rewriting RSEQ exit to user space handling provide
storage to cache the CPU ID and MM CID values which were written to user
space. That prepares for a quick check, which avoids the update when
nothing changed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

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
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
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


