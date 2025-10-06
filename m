Return-Path: <linux-kernel+bounces-843255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121FBBEC55
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6988E4E2938
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A8C229B1F;
	Mon,  6 Oct 2025 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGRc2JTz"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6B2236EE
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 17:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759770255; cv=none; b=ANy/vb8+nKaPUbK0g+aHR28H4Zda8zvBObBmgRBaMAzHNEvUNgqrmQIA83jHof3evneqPK0EL0yPbi4sU/AMZGf7chKoUi6wajeIcy0cFppIka5qiOZ41QNyTRvaUEWWwJaC+AlQca+YtwpZdr3l91WDSYf0+wrecxEtBTUjIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759770255; c=relaxed/simple;
	bh=WSOhLCP47bTTI2G1Dx59qp5+Llml7tOV3z6rZZ0BA6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7Gahney4YgnHATdNlroW69Tejc7RihoPzJc8bIZHskEW//vUdxKPf3IqnW+6JN/h849rx22/zVv7ql+ZNdJUFXSnAXMxYeJLyqbUXl7q1q2OfSZRXbLzzCB4G1++9RBq3LR02kG7uObgW9RaZlgd7IOc5TKcQPx7M4k9u01Kv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGRc2JTz; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso462176239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759770252; x=1760375052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hP5lbLel6FeQQkI2Vhrf17nln8NYIgCIUzjg9SwJbmA=;
        b=PGRc2JTz4/uwn9Snt+morS+HXTKzi4ghcClcysJmClJsJQI0YI/i7AcdBqByvR7EgR
         6+mw4O+4Ixk13SH0YZTVA/xjtM1Fx3Go8vG9xxcWJAgIqBC7Scq9yUzCZz+/7TLJX2uu
         ltSJ2eCJ0phfYWlcRI1kHVQ+N4colNNqI6yE9YiCs+KOTpCXRVVM0p3/6eusEzuA4zk9
         fJdd2CANPSSPdupY4E+BCJMaW6ZfFrXNJ4DZQeVQtLlrCIpVHOSTKsVinNDoT8ye1BBZ
         LSbOWIhqUpF2xUOVhMVcw7fCw5MFmKeT5aFoxilLdnZ0GjFhzaMfawcGs87JduJxYoww
         aOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759770252; x=1760375052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP5lbLel6FeQQkI2Vhrf17nln8NYIgCIUzjg9SwJbmA=;
        b=nnWSYu1fMJ6/7qMIc4WGuI6y5yL60hv7JkDsgahxybf/WkT1mXm8uBlLmjuvDCU3jh
         l9DYVQpSve0rbQpEZ077fZsfYGhfpNFETpu4ZthOzoGb2nqqc8OTRvtRdh/Rve2dpGVg
         M+oW+5bpp6V0a5xVPJEiHHO1ESsgrfHvszGWjzmYRtIsYAcumQycr+WtgWHSf3jUDkpV
         nsFD3t17g2tMzUBkMtwTH0yuJCbCjO+pSVTsBoBnmTiih092MNpZq1ijuXjgX4nuSEy7
         mdC5yxKYuPt/fD/fSGaN3r7lKgQB3cpav4ocP2YPEc+buAnJDKiJzMtA5IwD+ZQ5D04T
         fMdg==
X-Gm-Message-State: AOJu0Yyi6gsL2gBIGE/yFFMALzh2GTjkdaUCIaz6utZRNd7/bv9Y2Ne2
	jKPNkRY7k5cij5GO0LOlaMvuyu6qPQcd83wJk2ebMq9OsXU0uuYA1pE+HyUuBiNx
X-Gm-Gg: ASbGncugOB0zKsgjPIfXSSpX9fk+xnTHAgY/Pn73w7i8VldJwG9ju9zB9hlUQafJJRn
	N2pzO+XherQIu4WH5ytJiRLwWsS94zqaaHCRPA1NdyTDGzsHHq2d2Rq03aiE6febYeuFBwrbm5o
	1gPdZqzn2NtwxIp4t3nYx3PMtKiRog8D17CVQdvu/6sMX9+bIr/7MRFPwily4h8q/8PIpYb+r7C
	LCa8+AThOliROF5JSQF24kcapfRFJtj53p3wzldiSLSc/BWHkamt/qBzmD5STB/zxkFzr+9FrRd
	B6wJAepejdQJDpe2mJlqKJNLayAbEU+ljmkoi+zRu45gxzizFqOavTPlE+GcUqZyj35TqqCUV1i
	R5g1Zhc2VSIKto4NsLHpODJTLuXmnjIPFSH1vGRrcb+UoJFqXIVKvITm5H1mFSpUbbeShgKHOet
	MBybkBKnAtwLuezGg0pTf9rZbQpII6H55pUB9kk5E9tgMyqPXjI7tK2IJ0
X-Google-Smtp-Source: AGHT+IHtXrzkafzb/xJHKEdIZvSUMa4i5nvKxN/qFCoBRPJYFlRlsqk1i6a2OetdRygINP8sROrbkw==
X-Received: by 2002:a05:6602:740e:b0:937:6516:62e9 with SMTP id ca18e2360f4ac-93b96a4fba2mr1685764439f.9.1759770251943;
        Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-93a87bb84b4sm488589539f.18.2025.10.06.10.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 10:04:11 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	arighi@nvidia.com,
	rrnewton@gmail.com,
	newton@meta.com
Subject: [PATCH v3 1/2] sched_ext: Add lockless peek operation for DSQs
Date: Mon,  6 Oct 2025 13:04:02 -0400
Message-ID: <20251006170403.3584204-2-rrnewton@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006170403.3584204-1-rrnewton@gmail.com>
References: <20251006170403.3584204-1-rrnewton@gmail.com>
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
 kernel/sched/ext.c                       | 54 +++++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h |  1 +
 tools/sched_ext/include/scx/compat.bpf.h | 19 +++++++++
 4 files changed, 73 insertions(+), 2 deletions(-)

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
index 2b0e88206d07..6d3537e65001 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -944,8 +944,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
@@ -953,10 +956,19 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
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
@@ -1011,6 +1023,13 @@ static void task_unlink_from_dsq(struct task_struct *p,
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
@@ -6084,6 +6103,36 @@ __bpf_kfunc void bpf_iter_scx_dsq_destroy(struct bpf_iter_scx_dsq *it)
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
+	return rcu_dereference(dsq->first_task);
+}
+
 __bpf_kfunc_end_defs();
 
 static s32 __bstr_format(struct scx_sched *sch, u64 *data_buf, char *line_buf,
@@ -6641,6 +6690,7 @@ BTF_KFUNCS_START(scx_kfunc_ids_any)
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


