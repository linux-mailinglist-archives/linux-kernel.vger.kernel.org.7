Return-Path: <linux-kernel+bounces-853608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 35175BDC16A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 864D94FB7CB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CD30BF66;
	Wed, 15 Oct 2025 01:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgUkzgJo"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45BD3090D0
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493447; cv=none; b=K0CxfzHBnr3O2xxf+eUOp3HkILTrEKbNpphkL2abafB2veIIzpsqeIrhmr7g+GA698V1v6I3V6JicYvlzDmUKbKEcXw22DrzedNYW5gFx8muofbjiyc3QNF5LLW8SsUyqCPUqLrdVtdP5+KGiF/YQzYTzvQrDAgCFAwV0+wdqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493447; c=relaxed/simple;
	bh=AGVEwgAxw9PZ3K0QB6om9+1OxXQU5jAObifyBN7dCHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGezyulONzhNge3TvenErPCSLlXJWGqHpLHQqz4v4okeafIVqTBjFCMZCyIny6wsrgmuUuOmFY55vToEew3NOZHgoHn8Llnbb2mDmgKxviS1hKAnXlHcd9dGRsHyLRVy7PN2qNz+xyHMBc+OoMVcP8/g3O2tyqBx+dJ9h8QcU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgUkzgJo; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-912d4135379so246644839f.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493444; x=1761098244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18Hn4CAq2FpBNTkC8INCXhCkdRwJu5aFP3uAHNnh2tg=;
        b=GgUkzgJoBolSatV30jGTm/MOVPOAR0FzAplOyIznV/9681Ugp/RAgYPYAxPc6cwFet
         hIS+v7VUjkQ11voJJPPGpPkrYoWMoi/n3/aQ5LCgeGBQKStcyyHxpbEBh7YmXKjBblVY
         8z514QnJeMTT+EdMMWxpK1tqU91eNatrPjsW3gpzObccyKGoEeqECZM7ZWdTB9eUnk4L
         +RvJcYLnhNj6/dEh5tzSiAx0V+vKt2e/w81mMVJtkcbQlFGy2E7YBb2s3QmZQzqZhkIn
         qQMXcRDX1UgWVDPQ2Cajh5LXwsHLGPUHG/jgJLZzd+Tfk1O4bEHGC9bo1n1FfnMXp+ey
         5H6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493444; x=1761098244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18Hn4CAq2FpBNTkC8INCXhCkdRwJu5aFP3uAHNnh2tg=;
        b=PzAOdh7c/ZX8Pojcan+mNJnMIy0YB0f+uPgkSu6FJ5Fwrd2Jwt0Y7M3SxWRNTJFbpa
         ASGCgEfhE9yZmucdZyKumQuNXcsbV5vmlYtXqcAkeTG3zMrOfDrFKmYCsbn99K0DCXej
         AnNYqRoTloTkFiNElaOi43Mo5BqRNxASaujD326M8MykPHnz2xLdJNSit+yYrSqThoDx
         7bBpCnuLkgPKpPzLF/sm8jEWvaNNYLgziA9f6ftkCG/uq/p6XJbgj/DmEpG0kk2HLYMe
         EmT/szHqUQ9RECVLQBFw9ISUwvlU0SYGe+cy0BaaYfDvaKMesCZx1JCEg7iaByjZd/Td
         bFag==
X-Gm-Message-State: AOJu0YzzaearU3XY5f3SP6MlubZ2xv+2kngJFeM3emrPfVET7jZSRnw5
	gt5UFZbLFHqeyB8AeSLvpPnoF0EZS2aBU3iOlTjU7G8NT5oXm1BSgcZ38Zq+bVJi
X-Gm-Gg: ASbGncsPuHAhf+P7BFCaG2Lepw1t3ezM3jIAt2uvfZB15sKn9/QNT+aIFYDEPWTuyW/
	fizWC2rIeAvd/qabO2gfjAX8mLmD7yw3rZwS0joN98LwpSSJE+WAgLJUnCaYURT1O8pr6GxrYi5
	KiJ2UB9E+S/KwixHnJRgtTPfnW9b5EkoXqfadPj7rDKYGPlRH9Mkhl4bBuf5oALZIKI0mYl8w8U
	KJ53NVHk2+0XJ5ypjbiRl8jbLc8tnhOEB41wF0yVFmSTIIhevqmfC/JlIfmLMk5hGyVFuw89Olz
	zjqY5O3MUg7HdWt9HM/IZkNc+UjzIh7CHc2uEBCOwqqspPcPfIG5uayaGZinILECt1gX6gQBHng
	numUmgrQ1FsV1xuWorRnKNkde5whKpl3gc3yGvzNUHVIaTq2qw2su6amia0XV8bB2BE/HfnQUfW
	QvTHRu665zmhhxLzgjCcc/Oj9yLPXGfuq2gUqrK0uDRvPy8t8Ec+U=
X-Google-Smtp-Source: AGHT+IFPhZtdVdLJel3t88WCEO3asXsrDVJYl9mqICvuB+Hm3gN/emrZ2Z88Cw7UMZ50UMkXEpDZug==
X-Received: by 2002:a05:6602:6b12:b0:92e:298e:eeac with SMTP id ca18e2360f4ac-93bd1891211mr3135130739f.2.1760493444445;
        Tue, 14 Oct 2025 18:57:24 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c496ed8sm5254772173.13.2025.10.14.18.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:57:23 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v4 1/2] sched_ext: Add lockless peek operation for DSQs
Date: Tue, 14 Oct 2025 21:57:11 -0400
Message-ID: <20251015015712.3996346-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015015712.3996346-1-rrnewton@gmail.com>
References: <20251015015712.3996346-1-rrnewton@gmail.com>
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
Reviewed-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext.c                       | 56 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++
 4 files changed, 74 insertions(+), 2 deletions(-)

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
index 4b1467d3541a..430eaa7cfbbe 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -965,8 +965,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 				container_of(rbp, struct task_struct,
 					     scx.dsq_priq);
 			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
+			/* first task unchanged - no update needed */
 		} else {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
+			/* not builtin and new task is at head - use fastpath */
+			rcu_assign_pointer(dsq->first_task, p);
 		}
 	} else {
 		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
@@ -974,10 +977,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
-		else
+			/* new task inserted at head - use fastpath */
+			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+				rcu_assign_pointer(dsq->first_task, p);
+		} else {
+			bool was_empty;
+
+			was_empty = list_empty(&dsq->list);
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
+			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+				rcu_assign_pointer(dsq->first_task, p);
+		}
 	}
 
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
@@ -1032,6 +1044,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
+	if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN) && dsq->first_task == p) {
+		struct task_struct *first_task;
+
+		first_task = nldsq_next_task(dsq, NULL, false);
+		rcu_assign_pointer(dsq->first_task, first_task);
+	}
+
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
 }
@@ -6278,6 +6297,38 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
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
+	if (unlikely(!sch))
+		return NULL;
+
+	if (unlikely(dsq_id & SCX_DSQ_FLAG_BUILTIN)) {
+		scx_error(sch, "peek disallowed on builtin DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+
+	dsq = find_user_dsq(sch, dsq_id);
+	if (unlikely(!dsq)) {
+		scx_error(sch, "peek on non-existent DSQ 0x%llx", dsq_id);
+		return NULL;
+	}
+
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6837,6 +6888,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
 BTF_ID_FLAGS(func, scx_bpf_kick_cpu)
 BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued)
 BTF_ID_FLAGS(func, scx_bpf_destroy_dsq)
+BTF_ID_FLAGS(func, scx_bpf_dsq_peek, KF_RCU_PROTECTED | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_new, KF_ITER_NEW | KF_RCU_PROTECTED)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_scx_dsq_destroy, KF_ITER_DESTROY)
diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index eb3c99445cb3..e65b1eb668ea 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -74,6 +74,7 @@ u32 scx_bpf_reenqueue_local(void) __ksym;
 void scx_bpf_kick_cpu(s32 cpu, u64 flags) __ksym;
 s32 scx_bpf_dsq_nr_queued(u64 dsq_id) __ksym;
 void scx_bpf_destroy_dsq(u64 dsq_id) __ksym;
+struct task_struct *scx_bpf_dsq_peek(u64 dsq_id) __ksym __weak;
 int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id, u64 flags) __ksym __weak;
 struct task_struct *bpf_iter_scx_dsq_next(struct bpf_iter_scx_dsq *it) __ksym __weak;
 void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it) __ksym __weak;
diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index e487c10b5e07..619a16f0d39a 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -26,6 +26,24 @@ int bpf_cpumask_populate(struct cpumask *dst, void *src, size_t src__sz) __ksym
 	(bpf_ksym_exists(bpf_cpumask_populate) ?			\
 	 (bpf_cpumask_populate(cpumask, src, size__sz)) : -EOPNOTSUPP)
 
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


