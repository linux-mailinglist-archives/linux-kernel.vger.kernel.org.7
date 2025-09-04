Return-Path: <linux-kernel+bounces-801750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9FBAB44983
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B637D566208
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 22:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AADE2F8BC9;
	Thu,  4 Sep 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GbzwCh4f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7HEMeyGZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212B22F747F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024465; cv=none; b=VZhZHD3vNm9TwWM0YQHDpj1BvYDKD/7PS63O9Zry0ukmt+rck5XIUTSnbSZ8rjkLLmOOD9vil0xvY2feUXmn8RRyV12pzy6XEfaZkin5VmGvd+p48N6PVwRxdrp508d6xbXNY8AP+DQ+kuS6+ccFJxZaARfmYfFbCIroLcS/WBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024465; c=relaxed/simple;
	bh=Y5REso+KSnmwUD2JETKPgWRc7DEBswiB+PqsPdnigFE=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=YzMwj+A2WwMIAQKLLxwhnqiZkgjdBF9Mk8tPRp9/meDDWyrB5bc1UA50FCsgCP1eKGbS4Cr3y22LFYU3yl7aicpLIiPD4ZuH6x09YJeCkx8kzUJwytmxjmiD057xOhhvZIIWaAmVocwSIyd6n7sCguUZiavHtuDCHUO/xU3Mp4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GbzwCh4f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7HEMeyGZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250904185720.024147389@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757024461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aKkyyN4uhKDxXcmqSEbRndqAKHsWbh2jI3o2XKOXuho=;
	b=GbzwCh4f8sEEj3e9agiDvfsF5fm/FaD9AG/1ELcBn6z5QUdvg5kpv0VETSnVvDWxS92pl1
	mnuJD+zi8wopUPoV91/vuZuoHhfoXUqwOqIlXTkx6hfJLm0mxvPtkdOnoKN+KFxF/aje4X
	QZkvi2l7zW0LOCFpOVY8CH0Q9IMKjlXcXIN3sPLbbwEbqWueJGbagcpR79TYRIitRCyKqj
	iShSvQHg9nPJJyPXf7PDQanfwdWHdBHyE3shEtXuTnhHScHblMl8sPUnOlipp4xB+MV4Ch
	DDINtkAfCXCJkBvcZYyazht7vfxT5327+E60X7YRcEtDYHUgzch7brf15UwG8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757024461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=aKkyyN4uhKDxXcmqSEbRndqAKHsWbh2jI3o2XKOXuho=;
	b=7HEMeyGZsD+lkF+cYy4Kz3DKd2oQeafl+oU2gwKEsX5B494jMCQ+BNAchhh/hN8pQyeyud
	BvBIDQip1nmZyTBA==
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
Subject: [patch V3 14/37] rseq: Cache CPU ID and MM CID values
References: <20250904185336.943880027@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri,  5 Sep 2025 00:21:00 +0200 (CEST)

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



