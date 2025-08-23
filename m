Return-Path: <linux-kernel+bounces-783244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 730C5B32AF1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 18:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F85B1BC7EDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 16:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412182EE5FF;
	Sat, 23 Aug 2025 16:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bbdom8VJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H2xj6sca"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FB82EDD6D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755967184; cv=none; b=W13gNa9di0SwH5P3NnaAKcs/7+gezvJwt6eXd7n60+5tLLJFTweFagu33vbEv0Iny0uwfepNN3XJP6uRKVmCfJvGLohDDqlydpgFKOKeWppOuzimpxLsvUJ//iyB1oWEPsMEOtVqENaQMmvyc7Vc59Z+iyzVEDYaGB512heA1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755967184; c=relaxed/simple;
	bh=LKdUwV0PZYbYQja2MqsQSsVCNFQ1JIsTbnynWYyH5pQ=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=OdUgxT9iQGrib+00XPWAZP0QaeXFpfZddIaIveOH6Y/Vj2QrgyNtT5mC1Kkkgt4cOUt3CzMylfKsfTvI6sdPjKz+auFJqhgxMn5nOxuGjzWtI8SVHqrNadzt/F1U8wT3/lCVrY5Yg7127mGdanfrHXU15IXl44PWCYlVhr1Gfls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bbdom8VJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H2xj6sca; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250823161654.164761547@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755967181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XVVGR1r2cZfwA6qxDUSc18qdJmphQ9nAFOcoxmtwUmU=;
	b=Bbdom8VJifpIgcJDGe1rAfYwxNEo2zBLKqR3S3F24XzWSQVcgl9v4jTNe9f3bAlWLQLieH
	KhMqnqRLFaDH+/MROdvFTrWm+tDHqxJ1ejR2+owb8dZa02gIU3grPtHcNqx3HQAd9njHcs
	dj29qFp8wKT/ryIrZ4FDKfPd6Ti781QaFCmqCtDgUHY98+SNwFJ+PaeXMns3lRL5xzygUC
	Kap+4zQS4Fw3aWjn4uIpjWI/f4qPAtbIbhNpHgteHXia3o6RwwgNSUu0jpuWeoUMxMlnJY
	nmFiayQlvwjLfRgjA/5SVYmO4Fe3g+uqVko7jtNAGIc5V1Tn1zrrUeu5v3USjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755967181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=XVVGR1r2cZfwA6qxDUSc18qdJmphQ9nAFOcoxmtwUmU=;
	b=H2xj6scaPNlVMdThe6/Q1cejRAGRkMOn5iDY8pz1HPBjh4+SB/tuBEi40q5JBEaIbphb+D
	j9VLyL1umApSD9Aw==
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
Subject: [patch V2 14/37] rseq: Cache CPU ID and MM CID values
References: <20250823161326.635281786@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 18:39:39 +0200 (CEST)

In preparation for rewriting RSEQ exit to user space handling provide
storage to cache the CPU ID and MM CID values which were written to user
space. That prepares for a quick check, which avoids the update when
nothing changed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rseq.h        |    3 +++
 include/linux/rseq_types.h  |   19 +++++++++++++++++++
 include/linux/sched.h       |    1 +
 include/trace/events/rseq.h |    4 ++--
 kernel/rseq.c               |    4 ++++
 5 files changed, 29 insertions(+), 2 deletions(-)

--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -64,11 +64,13 @@ static inline void rseq_fork(struct task
 		t->rseq = NULL;
 		t->rseq_len = 0;
 		t->rseq_sig = 0;
+		t->rseq_ids.cpu_cid = ~0ULL;
 		t->rseq_event.all = 0;
 	} else {
 		t->rseq = current->rseq;
 		t->rseq_len = current->rseq_len;
 		t->rseq_sig = current->rseq_sig;
+		t->rseq_ids.cpu_cid = ~0ULL;
 		t->rseq_event = current->rseq_event;
 	}
 }
@@ -78,6 +80,7 @@ static inline void rseq_execve(struct ta
 	t->rseq = NULL;
 	t->rseq_len = 0;
 	t->rseq_sig = 0;
+	t->rseq_ids.cpu_cid = ~0ULL;
 	t->rseq_event.all = 0;
 }
 
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -27,4 +27,23 @@ struct rseq_event {
 	};
 };
 
+/*
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
 #endif
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1406,6 +1406,7 @@ struct task_struct {
 	u32				rseq_len;
 	u32				rseq_sig;
 	struct rseq_event		rseq_event;
+	struct rseq_ids			rseq_ids;
 # ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * This is a place holder to save a copy of the rseq fields for
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
 	),
 
 	TP_fast_assign(
-		__entry->cpu_id = raw_smp_processor_id();
+		__entry->cpu_id = t->rseq_ids.cpu_id;
 		__entry->node_id = cpu_to_node(__entry->cpu_id);
-		__entry->mm_cid = task_mm_cid(t);
+		__entry->mm_cid = t->rseq_ids.mm_cid;
 	),
 
 	TP_printk("cpu_id=%d node_id=%d mm_cid=%d", __entry->cpu_id,
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -184,6 +184,10 @@ static int rseq_update_cpu_node_id(struc
 	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
 	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
 
+	/* Cache the user space values */
+	t->rseq_ids.cpu_id = cpu_id;
+	t->rseq_ids.mm_cid = mm_cid;
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if


