Return-Path: <linux-kernel+bounces-839784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54268BB267A
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08BB03B557F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FBA28D8CC;
	Thu,  2 Oct 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CAN9zvYd"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99CF2877DF
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373854; cv=none; b=VsGa7tSXwuL4dmngIs7iFG1M93BgHn1JpQh8gTqee7cEmyKBm8/VNPuX1eQHqhuvj4JHl2jWaK94QdtrgxJenckfin/PH7cPsgZ0lg/c974hsmrkpFWlX8MaZqmdmSGWvZoHOTx+4NfQASaN4Ckr95aCJqLEBkO05nfI0Xb3fGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373854; c=relaxed/simple;
	bh=m8irqQQrWS/AppJmzBHn9/1/BqdXLBMn02Dh6cMBMkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f4pynWLXhiYN7RzpxrgdBFCYCOeHVnw+mSm8a8/VB3eZntzCXJ8bsOKJPGU0y6qWBm++Tn2dpSjQtrAfQEuM3ql4MBWHWNhqD6ru/8uDkFmxSJ14V4bkyu1ThEa2IFojPN97oQM5zy1WXslv21ogbfOzBCCeJnqISDTTUB4rC8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CAN9zvYd; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-42d8ad71a51so7100365ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373851; x=1759978651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRRc4K6LmuroEV6vB89FwgV28B/ksAOPI2h8bfGG5Gg=;
        b=CAN9zvYd3S1N+gK8J0jX3/Oin7S1irHlXO5eMHz/ArQcB2yT0bpGnMBfNHhoxgjSXl
         Yh8uDhgyox911TPZvlWFqG8eLXiBVge5GfeJ1xcbEdL2nqvdeoUiKA4xdYR/QIrpcjgo
         PJCo1L3ISZxLgX/bYNVRFVKWknsG8PFYL8YX7bRey3lkChMbxLUCUdrBn2Omjbiki657
         dfOUR6SXw/sHbU23xwLoHWvuuTJIzg7akkOn/+joXQFGxkb59PzeAfySQiDll71KOeeS
         ybbL3ZuA/xQNSenl3E3Yn2Z+bq7wWdpFEEzOGQ8ZE/WOWVbaHXtx84zfchqFiFtbuAwb
         d4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373851; x=1759978651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRRc4K6LmuroEV6vB89FwgV28B/ksAOPI2h8bfGG5Gg=;
        b=oowJ7n7qHlYk23VM8GSbRVxL5z9pveteXTgz4jO5MfnmiBww7thwuHQ6vLFoDgzKUC
         vVyNBVJlOnbGTuVk7JvnFU59ohWtIMP5T6HgwJp62tKrwHxBRGN0xuy1ALaSd5NV7UK6
         KbjjpZKzOEeQhlRzOfe1FS9dbt5psiwG6YEDIEa7n9xjqta4bNqaHD+4iJr6KN+Eq0B/
         N4yX2E5vGngcUJnEkhrCE4wnJwyRdw4vThs5OTf3CHknWujyI8hjSBFhTn8MX0T2JcuJ
         wa2w+S2UehURB2cO/GAWnXzTwjkZPouotImYaQtAJpslgX6PYNHvN4cro16d4SSa/QQD
         dkiA==
X-Gm-Message-State: AOJu0Yzt4ppvRy696S+Vx7oWQUMboM7e13V0NeCtX15HmgWN+cnGfwdW
	/qsonSJ2aC8GpOD2X5hTelSlfq5kiNTwEpyDDxgSbQnsEMpAtnIEdtR8pHQaJKoB
X-Gm-Gg: ASbGncu6SVsvcihCYs1W4hZhEbY2iJrVaYrif0V+KPcjgb4uxE/eYB0tSYSqY4/eLRj
	7ZjlRfLPLodekOhezTTbPTdEtfm/mxScE7K+fVDRIu0nm9PsWNZ0reOSGbDLY65zc4LNCWW0TRk
	mRTf8HdI0BK89AvrLjL7+lB/qIQlfJi9YsqI6kbBWFyBlfsRWvuZS8Y1KhbFlqFQ/CLE+veGt6b
	Tn0zngFeJQsWynV5lg1crdBYsqeipBgv8/hBDHkG5pmDZUVOKi7I6Eo9IiEm2matUHLjf8dgZhx
	IDYIEq/uDBpcbHikvGcOKAlTtbeN9CN0QTYII+cbatnBs/ToJPb8k83mlwjKgzAo3SUZjre+OQP
	rgXnUPzju3tTu8LIJ71A+bHaVbG6WApt+eimH+Ln6X1iUgPMb7TjOG0RScvSPqNqHgyijP8ZnD/
	BHiWe9bqu7Bnm4zrGsRYfYpKI+tuY0tCdy7nbpzhXX7CLD6qcn1tK/6/O0
X-Google-Smtp-Source: AGHT+IHod9HShDFHtXl45kRZhfQ2iuWNmcX7V08Eo581zjASSLepAjNEYaNgYu5TPBCq5xLIfaHLdw==
X-Received: by 2002:a05:6e02:3105:b0:42d:8a3f:ec97 with SMTP id e9e14a558f8ab-42d8a3ff12emr29217695ab.7.1759373851351;
        Wed, 01 Oct 2025 19:57:31 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm5250255ab.2.2025.10.01.19.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:57:28 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	newton@meta.com
Subject: [PATCH 1/3] sched_ext: Add lockless peek operation for DSQs
Date: Wed,  1 Oct 2025 22:57:19 -0400
Message-ID: <20251002025722.3420916-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002025722.3420916-1-rrnewton@gmail.com>
References: <20251002025722.3420916-1-rrnewton@gmail.com>
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
 kernel/sched/ext.c                       | 37 ++++++++++++++++++++++++
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 ++++++++++++
 4 files changed, 58 insertions(+)

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
index 2b0e88206d07..fd0121c03311 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -885,6 +885,15 @@ static void refill_task_slice_dfl(struct scx_sched *sch, struct task_struct *p)
 	__scx_add_event(sch, SCX_EV_REFILL_SLICE_DFL, 1);
 }
 
+/* while holding dsq->lock */
+static void dsq_update_first_task(struct scx_dispatch_q *dsq)
+{
+	struct task_struct *first_task;
+
+	first_task = nldsq_next_task(dsq, NULL, false);
+	rcu_assign_pointer(dsq->first_task, first_task);
+}
+
 static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			     struct task_struct *p, u64 enq_flags)
 {
@@ -959,6 +968,9 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
 	}
 
+	/* even the add_tail code path may have changed the first element */
+	dsq_update_first_task(dsq);
+
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
 	dsq->seq++;
 	p->scx.dsq_seq = dsq->seq;
@@ -1013,6 +1025,7 @@ static void task_unlink_from_dsq(struct task_struct *p,
 
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
+	dsq_update_first_task(dsq);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
@@ -6084,6 +6097,29 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	kit->dsq = NULL;
 }
 
+/**
+ * scx_bpf_dsq_peek - Lockless peek at the first element.
+ * @dsq_id: DSQ to examine.
+ *
+ * Read the first element in the DSQ. This is semantically equivalent to using
+ * the DSQ iterator, but is lockfree.
+ *
+ * Returns the pointer, or uses ERR_PTR() to encode an error as the pointer.
+ */
+__bpf_kfunc struct task_struct *scx_bpf_dsq_peek(u64 dsq_id)
+{
+	struct scx_sched *sch;
+	struct scx_dispatch_q *dsq;
+
+	/* KF_RCU_PROTECTED means no need to guard(rcu)() */
+	sch = rcu_dereference(scx_root);
+
+	if (unlikely(!sch))
+		return ERR_PTR(-ENODEV);
+	dsq = find_user_dsq(sch, dsq_id);
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6641,6 +6677,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
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
index dd9144624dc9..0af1922d66a8 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -130,6 +130,25 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	false;									\
 })
 
+
+/*
+ * v6.19: Introduce lockless peek API for user DSQs.
+ *
+ * Preserve the following macro until v6.20.
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


