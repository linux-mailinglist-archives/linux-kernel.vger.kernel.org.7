Return-Path: <linux-kernel+bounces-854825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC3BBDF7BC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C696519C3BD2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C2A33439B;
	Wed, 15 Oct 2025 15:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezLKIrcV"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF838334394
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543446; cv=none; b=alm6cJY6dDFre/HksAHl0VNDR3Fu1/Z/hpzvubviczFktfXkSbukfUfavHYNtlL8kOtnKplWN8Es/BjoAkO7GeoX+fqSTCLcv2Prpuo3OALRmLASqE+RR9m3/9dB/fiSoYVz6XjHV0aVsEyClLjnEYgUwx975/16X4wcScigTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543446; c=relaxed/simple;
	bh=RnHvzys4uJQqhoEI4QYtcs/hmY10zyRT368i9reWevk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgqVAKLzJxkUIWjgDXURIja/wKr7a8n8WmQo+Dd2/nstl607xKrN3wq7US8pwmRa4qU869EUjYX0mfVWPODQxCubWfTk6wV2pGaxnjGfNtq38ksE7bfzD1ItRUsL5dJAhaBRKhEtfMA0JfKFrBZAqsTq+xim/ysoUIBT5W2FXEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezLKIrcV; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-90a0b3ddebeso277708939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760543442; x=1761148242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdUqKoPzfH0SGw1iBPVZD7em5JOQyR55dqZlLIrI0Rw=;
        b=ezLKIrcVNJ/xD4RMgDGRlBjOr6dKvrGRwWye7PYWA0zZsI/QBkoYCO1U7s/5HlhcCR
         FkUaq9FVknxCb7bz7OjflKgvpKRslCsod9Ox2cSTfruSqsySMz0s72ART18kcBfPPCaK
         tqeTk07VUFFdUdBVT2aqLuU2oBOtrnLE7UzesAih7pjBcdwKpBjFPMRN6q4PUOKEe8yY
         BrKtry4IPkWmBxeSyi5EJqJMD9VtQa2FaC3PTFBDIstbHm43YzIX7fm8tdDCVQc6YakI
         utv9hD/B5lR/JZQFHx1McPfxI6I3N06hnaaJWtQZsR9kgMW0VDZ16S76K6nCRsUfk6lJ
         CGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760543442; x=1761148242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdUqKoPzfH0SGw1iBPVZD7em5JOQyR55dqZlLIrI0Rw=;
        b=YJd1Gbe/EoteyxxqV+Tv1fGhJa9hIMRif54nLEXcfEnCGlz/np5sZJixDSZ2mxyowP
         C5cS2jSgCecj1PvXCe2HdKREZtWXCRTam+2igr5iklKKa5hNYkHuDRM1egff2o+SL3GW
         HA5UL9fSmCNRD4M4Wov2xb+bmssJNMt8/4ihImhY256cbCUB5K3WS5Z/gIYEDd3QdPNW
         Hp9tb+Jei9CIaDKJcO6r2b2jKCG2R11SkqkhSUtPufRVDPyUQOy9T5XDpoWxkH4bhdq0
         QgDdFGYH5bxEOIgFJ4JoSPGL1WEfEt8zYAulqfoZ2Jt5B3pODaq7y3j8ea4rKq/5Fh1N
         pTHQ==
X-Gm-Message-State: AOJu0YytznqmpgIq8+BMFM+udsgoMH1qZgH7cxRlTjPaz4pUr0Hm20ca
	D5DfsGwHP+qws0ziyIlEJI8rOoqFU5SEW8m4YtBdPgZf9vKPEbJNhoOXPpzT08Oh
X-Gm-Gg: ASbGnctuf7b8BMR5XV/UvgVEf7Qj4ETWUIKRhFoePVM3i8XtJ4aNqhLMTU1CYUA18sc
	AVS8GvEpP4VXZEr+Uy5dLlBuJEeVJxo1T2oNTOLMKiUkZ90WWtpSPYGPdJNkRWJYSu6JPkT/QqT
	OUq14F7dcfNcE6lsxmQlK4rhdqsu3BcLPQBX6FcI78JSi5uUmYpCKbBOwVr3zays2zbi3Hvd4qi
	xyEmqXX4EGxd07iot2Cormu4hRsO4VpSjIouTMUw7NDhnVZCVmqKA/6ZyAl7Mr+OrMJl+qwIiHY
	BVxT4+N4BaQmGxKctMThd4nGfqz9wP0sdT3NPeroCVJ0lQtC8wvq3zoFgRJfgkjATHebVZYQR8t
	7tOt7n9d7a1FPj/hMaXbKOSA2IRGN+lc70OUZAuAl6beiL37PqA5TJ5IMGzBbpxVgYz0fxizZvg
	7gk1q64EPQ6tmBUb99S+DYhNM6Uvuzlkn7xt6dDXNllE87rFy3k3mwy54PBRTJ9A==
X-Google-Smtp-Source: AGHT+IF5PSGLY6efInvx8zBXdQYWj5DHd01ETNCWEaP6Qvxx9zbNYafZlxVTtMeV+WG0G8QZQkd6EA==
X-Received: by 2002:a05:6602:340d:b0:887:628c:7ff4 with SMTP id ca18e2360f4ac-93bd1851609mr3699273839f.1.1760543442018;
        Wed, 15 Oct 2025 08:50:42 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93e25a67790sm617361639f.21.2025.10.15.08.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 08:50:40 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	christian.loehle@arm.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v5 1/2] sched_ext: Add lockless peek operation for DSQs
Date: Wed, 15 Oct 2025 11:50:35 -0400
Message-ID: <20251015155036.420486-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015155036.420486-1-rrnewton@gmail.com>
References: <20251015155036.420486-1-rrnewton@gmail.com>
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
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
---
 include/linux/sched/ext.h                |  1 +
 kernel/sched/ext.c                       | 58 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 18 ++++++++
 4 files changed, 76 insertions(+), 2 deletions(-)

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
index 4b1467d3541a..925daf281d99 100644
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
@@ -6278,6 +6297,40 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
 	kit->dsq = NULL;
 }
 
+/**
+ * scx_bpf_dsq_peek - Lockless peek at the first element.
+ * @dsq_id: DSQ to examine.
+ *
+ * Read the first element in the DSQ. This is semantically equivalent to using
+ * the DSQ iterator, but is lockfree. Of course, like any lockless operation,
+ * this provides only a point-in-time snapshot, and the contents may change
+ * by the time any subsequent locking operation reads the queue.
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
@@ -6837,6 +6890,7 @@ BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_RCU);
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


