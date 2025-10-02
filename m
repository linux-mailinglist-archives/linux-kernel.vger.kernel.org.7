Return-Path: <linux-kernel+bounces-839785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17907BB267D
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B59519E094D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B161A9FAB;
	Thu,  2 Oct 2025 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN8eEqrV"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF228C00C
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373856; cv=none; b=dBXRTHJZjKDI4ya6l2EO2o4KQDDcsGcKnLDzDbFagaNetqw6sDR8ERoBAPcFrJ5tb8ZDVyE9qdF0+TlMdQSTwAd5Uglymc+sS5Fi4iYL4f6eJ4pPXlFEfEz8YtPbkdN5CuXQh69Eq2JWNb2zbKM1jY/UUeg1MvSxD8/PCQeLeUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373856; c=relaxed/simple;
	bh=y3ipr8m9u67gmE4hZu7xPVTPdtoye4u5ez1ARduQHRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o+8+IGzLmZ3tFOqY7f4xU78hNZDVWcccnjcZZylploGV45lqX954DX7E2v4T4W11ncQGcFPwHPj/WpTiQOPocQmZ3kiPuln7n5bq4y9Cj5e4auONNrXNkPxPGmSDSO5aXN/ZfOdhnvX3pfNuywU3Ar+rb0mbSfBaDGbIEvVmff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN8eEqrV; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42791510fe3so1715485ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373853; x=1759978653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0BGFl3iaVg20wY/A9rj2Ykarg4EVcq5v3jqlKvBxJUM=;
        b=lN8eEqrVO1xhNSL15GjOb1jwf/BEUMcfo6ToTTIUKygCVdCcVrkfL2yK57JkJv2L3k
         ScEMSspGcF238y4Jb4Zgo/Yn0IfarescyqacvFg254L7JCGBpMMhxhVaZHKB3KhA+cUp
         ci7x0pOnPdKadY7MAJjMovdG1hY/ZWSgFxguNfT+9pDI4FxMgYwzPXxs6K/CL+YqbjCe
         05Hz4UUsqtdw/ytCp0eqB/SA9fF8kHf/3D08g60dfqfM7sRtiIbcUBrwqIxQ7XzmN9x0
         LTvfYQ8D7Uih9kf9YB+R6K3fJ72n4+L/HZaHyk9weHcIDHCUkZWEvvBBwqucj7uSReYU
         DIvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373853; x=1759978653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0BGFl3iaVg20wY/A9rj2Ykarg4EVcq5v3jqlKvBxJUM=;
        b=cItgpGYD53bwHw8mqGQ5/iN2TsOF3yJJBye8V6njf3kCIgIF61nHpkC+Eh97HH3w09
         z9bSoJeS208IYRAKfs48RysHIqTcNVLqEDbyW0tGqF/TtPXnGfnZPdfSPC/k63OXu/Er
         Sz0buQ7VyMfAWE+OUeWFqoS9tXi0uyx35+SL3GR2SLdGOESJAAHDeXFt8HNpr3z3QVmt
         H/4DvRuwHBRfy992XIKgwGue4YwoPM3hydylIIRtSQ+goSSxxIlrtJkuvD6KNAyzjj+/
         bi3uyFz8zcixoKO+wrm8NiELcLIMTvVNVospxe3NoviPXFZxAgZ3EGBU5GJSF8bbU7tX
         eO9w==
X-Gm-Message-State: AOJu0YwBLLzVmnj0vo6EtHJdczC/0QUI1qInxYfU1vIEH3Psy8G6cCwZ
	KtLs+pSXM6uo6RGKc/BNBEVSJFNRcKzSPoYVJc0+5orUqKe3VeKRVddE2Q0w9iAL
X-Gm-Gg: ASbGncvqNzaSsthZzxbqUOsiOOaPzf1sZ9WEELSxUaAv3fR9JpVH6s8WwWMik7bgnRi
	+lpVzM3/EL6eenQ672ZBFfFYm5Yv/ApjIo7Z77xim/jLOiCTry1E7+uwZZuZaj084v+hEnzKhHF
	taqiofBUKXst98tmLMSE0iDwjXiehivsVsLPlXRHQjv3Etl6J9QpnienX8VwkdnUH56DQvjBgbq
	l3rcDT1Nw1F0l0aFj+C4yN1axl5J2R0icLpexFXBFPaNBc3j9GcfaYKelYLmgN6/WbtskLuvgJD
	V54ZmApaCWw+BRxu8xqGQC4j6XCfHjiBoFKVtpD6D5DY3aFrAXF+8v23ppdHZAOEiXC9gwywBJu
	XlUUy4M1e4GL25pizzhiIowven+4qu5qTy3RWFXdkolQgCpLzrLhsj8RyRcmMO7oWVaWDRD1xyc
	T1c3ADxXtS0mn0Tp1jN4qvYKlWMg+t5jK6sZNxY1f1GAQ2wg==
X-Google-Smtp-Source: AGHT+IE/l+b3Sl9MkR7vAc6b+0igSxttuvanyaCpevYeUwXmM+kpMYtDx4mO1eB0Mn2+ddSPIIpRfw==
X-Received: by 2002:a05:6e02:3108:b0:42d:89d8:20ad with SMTP id e9e14a558f8ab-42d8b1d6a26mr22991445ab.14.1759373853197;
        Wed, 01 Oct 2025 19:57:33 -0700 (PDT)
Received: from newton-fedora-MZ01GC9H (c-68-45-22-229.hsd1.in.comcast.net. [68.45.22.229])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42d8b1f4f0asm5250255ab.2.2025.10.01.19.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:57:31 -0700 (PDT)
From: Ryan Newton <rrnewton@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: tj@kernel.org,
	arighi@nvidia.com,
	newton@meta.com
Subject: [PATCH 2/3] sched_ext: optimize first_task update logic
Date: Wed,  1 Oct 2025 22:57:20 -0400
Message-ID: <20251002025722.3420916-3-rrnewton@gmail.com>
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

This is a follow-on optimization to the prior commit which added a
lockless peek operation on DSQs. That implementation is correct and
simple, but elides several optimizations.

Previously, we read the first_task using the same slowpath, irrespective
of where we enqueue the task. With this change, we instead base the
update on what we know about the calling context. On both insert and
removal we can break down whether the change (1) definitely, (2) never,
or (3) sometimes changes first task. In some cases we know what the new
first task will be, and can set it more directly.

Signed-off-by: Ryan Newton <newton@meta.com>
---
 kernel/sched/ext.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fd0121c03311..1cb10aa9913a 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -953,8 +953,11 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 				container_of(rbp, struct task_struct,
 					     scx.dsq_priq);
 			list_add(&p->scx.dsq_list.node, &prev->scx.dsq_list.node);
+			/* first task unchanged - no update needed */
 		} else {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
+			/* new task is at head - use fastpath */
+			rcu_assign_pointer(dsq->first_task, p);
 		}
 	} else {
 		/* a FIFO DSQ shouldn't be using PRIQ enqueuing */
@@ -962,15 +965,20 @@ static void dispatch_enqueue(struct scx_sched *sch, struct scx_dispatch_q *dsq,
 			scx_error(sch, "DSQ ID 0x%016llx already had PRIQ-enqueued tasks",
 				  dsq->id);
 
-		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT))
+		if (enq_flags & (SCX_ENQ_HEAD | SCX_ENQ_PREEMPT)) {
 			list_add(&p->scx.dsq_list.node, &dsq->list);
-		else
+			/* new task inserted at head - use fastpath */
+			rcu_assign_pointer(dsq->first_task, p);
+		} else {
+			bool was_empty;
+
+			was_empty = list_empty(&dsq->list);
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
+			if (was_empty)
+				rcu_assign_pointer(dsq->first_task, p);
+		}
 	}
 
-	/* even the add_tail code path may have changed the first element */
-	dsq_update_first_task(dsq);
-
 	/* seq records the order tasks are queued, used by BPF DSQ iterator */
 	dsq->seq++;
 	p->scx.dsq_seq = dsq->seq;
@@ -1023,9 +1031,15 @@ static void task_unlink_from_dsq(struct task_struct *p,
 		p->scx.dsq_flags &= ~SCX_TASK_DSQ_ON_PRIQ;
 	}
 
+	if (dsq->first_task == p) {
+		if (dsq->id & SCX_DSQ_FLAG_BUILTIN)
+			rcu_assign_pointer(dsq->first_task,
+			  list_next_entry(p, scx.dsq_list.node));
+		else
+			dsq_update_first_task(dsq);
+	}
 	list_del_init(&p->scx.dsq_list.node);
 	dsq_mod_nr(dsq, -1);
-	dsq_update_first_task(dsq);
 }
 
 static void dispatch_dequeue(struct rq *rq, struct task_struct *p)
-- 
2.51.0


