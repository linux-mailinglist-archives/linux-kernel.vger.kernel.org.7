Return-Path: <linux-kernel+bounces-841695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A87B7BB8024
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 21:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C334347495
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 19:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48F22CBC6;
	Fri,  3 Oct 2025 19:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mTZ0nuGH"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA51F4190
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 19:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759521259; cv=none; b=vDMBmE/pYi8ytZQW/jQ0xU+atZwi7FQfANtuWTseikBNdqNRKX4PJ8fxw7NLZn76EPRemutai5Q7UyhEmyXzQtMptcOjgkt+WAnF0tWKYv8MFTIgu3Z/DlOWri7kO7vhn1TK1+JmsA6A60Ys8GHHhrGAOiC3qAaY3//5fqIZ9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759521259; c=relaxed/simple;
	bh=aZW+03fLX/wTJ3rnXWszKeAlBNdbOHEE1U9BRDzjScU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9IIKtQyHrs74VAwdSjEfPRnpr16sYyREMBhu0b6LTlm6V545k0Vln2/z+2ZbOXYzR2Sb1vYxGfcMqbh938hmV72jJ0+lAZpHLBxcZPO1XNn3ouAEVS/es6S20PIrKebsWmV0r052XTAM35VP3ntk8boPmvzaB52KrVzPXEign0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mTZ0nuGH; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-91179e3fe34so131986939f.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 12:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759521256; x=1760126056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ad/eDbLq2Wo/mrB8DJqKuZpped5NxFhJJkxQWW7iwws=;
        b=mTZ0nuGHP/w7QjfzlVfmF79xU7CNxu+PKWnz1WlUvwhRymi2VsG4QTVX1lMj5hXWMY
         sFD+neT85ZAn8HVLkrfyyzOPSZ27h7Ss1ZeEmVkE4vxm2RKRhy2VoGk+6+KshPU+z7C0
         Gd9ubHS+dT15ukPZt5pISUDh7rsrBnJ8bz3FL4cRkvaIJLoDkzdL2LTTPM+uwJmk9h2s
         fRwnat+lLZJMGkTshLwejzTm6lqry2tAX4UsZLN68Fbzw1pdSxuzbaUakHzwQdTqa47I
         hYSo03pLCoSo55s7OAgSbNBT8fj45rKor0IKNj9m2KFcCPIYUeEpEGeoBH0Z+fJhQlIW
         jV1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759521256; x=1760126056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ad/eDbLq2Wo/mrB8DJqKuZpped5NxFhJJkxQWW7iwws=;
        b=WN2qi1Lf3pGVrPwxc1tG7eritKx8j3GI5zwofHkGNZLWKdF5gY4uq48XuLz0Gyp954
         lEFAQWOg4gQmTetgOg9dRoouIfFp9pVutdXurSFXpx0ms94Uh8DiFdwKQj2wGXhsi0B2
         MVHm5fTHAf2P6O71KzMpkvRBjzeSHY1A0jiepRJmaTn1131/5zc9VAWkdu913OS/XrRO
         VAnLuLDHGF77Dgj+9mQ6mSMyvXLVOk6vmq1W3SWCSsz92lDkE7egjccp9qeZhqWJWL6H
         L6FqOGAsiUsm9Yk45YJaFNlLBzjqhMuk7xXB+OuAkTpTp3iOQb4fXSMopIdnIAAJK7yP
         kj5g==
X-Gm-Message-State: AOJu0YyNm5NSLCkVyT40nma50PFbcTs+c1T0OUXGbo8WI4oqjAYJPcxl
	mXe5NICIkyEmBA7uNDKdKikQhTs0IlOd+c9qaRT47oTlsdarJ+DBkbLdMJNev1l4
X-Gm-Gg: ASbGnctjuZuhm2lLQr30c4K9uj60Ho+NSPhV7+QuQRxE1bYwIRFVtwUepRVlvSVjUiH
	huLU11I5EP4xkwJ4+wDhUGL6oge+n5wg2ed/NO+bvAdhWqM81QyyT2t2i5t/Vyam5sueTmszKFy
	3JPpCqvIAwtMbPQ7xD4Ip1377Dal+iraZYpsphJicH7dXTifc8A1dHEf1zD53MWHA+nNEuGddRJ
	2g10tK0omLh95M5C+xVSZ9C/bc/S4sX3RSatwlVGzel78Fz+riEyIaCiaDk7ef9ngGtIGtjQnhF
	h7Sn9wSZvXIM/KQ2l/IsctHJD7951guyxKsT2WacqazpMJQ/Geca7rAyeZwgtm3GHv9gETrdafC
	BuZVV+82e3h/0Vab6CCtusMVOEHDD8bvax5CLlJrzqCkXxYdgmkPZzSJTozg0wbmkT2urAmomdN
	W5VcFdg+EL4G8CsC6onR1P1QwvdpYF6XSF34OOGU+QQUcvANaf1GGua3C/
X-Google-Smtp-Source: AGHT+IGFr9efqpMYqCprbETZ0Yb7JkhIg7HeNNKGgNjVXKbQQLh9AjIVsjgBAE2YkDQ0DBPhxlFa3A==
X-Received: by 2002:a05:6602:4f4f:b0:917:664e:c00b with SMTP id ca18e2360f4ac-93a8a55b4d9mr777270539f.9.1759521255965;
        Fri, 03 Oct 2025 12:54:15 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ebc8181sm2296390173.47.2025.10.03.12.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 12:54:15 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v2 1/3] sched_ext: Add lockless peek operation for DSQs
Date: Fri,  3 Oct 2025 15:54:06 -0400
Message-ID: <20251003195408.675527-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251003195408.675527-1-rrnewton@gmail.com>
References: <20251003195408.675527-1-rrnewton@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan Newton <newton@meta.com>

The builtin DSQ queue data structures are meant to be used by a wide
range of different sched_ext schedulers with different demands on these
data structures. They might be per-cpu with low-contention, or
high-contention shared queues. Unfortunately, DSQs have a coarse-grained
lock around the whole data structure. Without going all the way to a
lock-free, more scalable implementation, a small step we can take to
reduce lock contention is to allow a lockless, small-fixed-cost peek at
the head of the queue.

This change allows certain custom SCX schedulers to cheaply peek at
queues, e.g. during load balancing, before locking them. But it
represents a few extra memory operations to update the pointer each
time the DSQ is modified, including a memory barrier on ARM so the write
appears correctly ordered.

This commit adds a first_task pointer field which is updated
atomically when the DSQ is modified, and allows any thread to peek at
the head of the queue without holding the lock.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext.c                       | 59 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 ++++++++
 4 files changed, 80 insertions(+)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index d82b7a9b0658..81478d4ae782 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -58,6 +58,7 @@ enum scx_dsq_id_flags {
  */
 struct scx_dispatch_q {
 	raw_spinlock_t		lock;
+	struct task_struct __rcu *first_task; /* lockless peek at head */
 	struct list_head	list;	/* tasks in dispatch order */
 	struct rb_root		priq;	/* used to order by p->scx.dsq_vtime */
 	u32			nr;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2b0e88206d07..ea0fe4019eca 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -885,6 +885,27 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+/* while holding dsq->lock and does nothing on builtin DSQs */
+static inline void dsq_set_first_task(struct scx_dispatch_q *dsq,
+				      struct task_struct *p)
+{
+	if (dsq->id & SCX_DSQ_FLAG_BUILTIN)
+		return;
+	rcu_assign_pointer(dsq->first_task, p);
+}
+
+/* while holding dsq->lock and does nothing on builtin DSQs */
+static void dsq_update_first_task(struct scx_dispatch_q *dsq)
+{
+	struct task_struct *first_task;
+
+	if ((dsq->id & SCX_DSQ_FLAG_BUILTIN))
+		return;
+
+	first_task = nldsq_next_task(dsq, NULL, false);
+	rcu_assign_pointer(dsq->first_task, first_task);
+}
+
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
@@ -959,6 +980,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
+	/* even the add_tail code path may have changed the first element */
+	dsq_update_first_task(dsq);
+
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
 	dsq->seq++;
 	p->scx.dsq_seq = dsq->seq;
@@ -1013,6 +1037,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
+	dsq_update_first_task(dsq);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
@@ -6084,6 +6109,39 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	kit->dsq = NULL;
 }
 
+/**
+ * scx_bpf_dsq_peek - Lockless peek at the first element.
+ * @dsq_id: DSQ to examine.
+ *
+ * Read the first element in the DSQ. This is semantically equivalent to using
+ * the DSQ iterator, but is lockfree.
+ *
+ * Returns the pointer, or NULL indicates an empty queue OR internal error.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+
+	sch = rcu_dereference(scx_root);
+	/* Rather than return ERR_PTR(-ENODEV), we follow the precedent of
+	 * other functions and let the peek fail but we continue on.
+	 */
+	if (unlikely(!sch))
+		return NULL;
+
+	dsq = find_user_dsq(sch, dsq_id);
+	if (unlikely(!dsq)) {
+		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+	if (unlikely((dsq->id & SCX_DSQ_FLAG_BUILTIN))) {
+		scx_error(NULL, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6641,6 +6699,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 06e2551033cb..fbf3e7f9526c 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -75,6 +75,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index dd9144624dc9..97b10c184b2c 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	false;									\
 })
 
+
+/*
+ * v6.19: Introduce lockless peek API for user DSQs.
+ *
+ * Preserve the following macro until v6.21.
+ */
+static inline struct task_struct *__COMPAT_scx_bpf_dsq_peek(u64 dsq_id)
+{
+	struct task_struct *p = NULL;
+	struct bpf_iter_scx_dsq it;
+
+	if (bpf_ksym_exists(scx_bpf_dsq_peek))
+		return scx_bpf_dsq_peek(dsq_id);
+	if (!bpf_iter_scx_dsq_new(&it, dsq_id, 0))
+		p = bpf_iter_scx_dsq_next(&it);
+	bpf_iter_scx_dsq_destroy(&it);
+	return p;
+}
+
 /**
  * __COMPAT_is_enq_cpu_selected - Test if SCX_ENQ_CPU_SELECTED is on
  * in a compatible way. We will preserve this __COMPAT helper until v6.16.
-- 
2.51.0


