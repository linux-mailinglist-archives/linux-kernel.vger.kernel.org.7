Return-Path: <linux-kernel+bounces-791335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5FFB3B596
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CA5A7B4BF9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC88286D77;
	Fri, 29 Aug 2025 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="BW2SmmI2"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D88B262FC7
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455119; cv=none; b=ZY5TkRzrVIH8H38NAd6Vugw0na6jKQjZLX16xqPGV6toxvZuaVO333c7fxhtjsDjh8kq4NjTpQM2hHPyOAgEoguliD/TqFTZ/pz33pDfUW0LKxYxKS9TIm+UtlRj/RDD567tumM4fc3g/GIgt5ego8NxmWK6uWhja5qE9nB4Z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455119; c=relaxed/simple;
	bh=ZUYSxlUF7qKLvXuv6cbQk1iZzvwFSgo/Qu0caO5dBEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uPuf38K00JmxJR59g0OglQOoqVURMb4LoBFdfO5ANW5DW5sD+hSJx6zQN2X9+V3IEbg0qw5MEim9SWFq4MNpke2cxB29tz8nu05+K2m3yLwNkdH0WzbvbtnXogdYG7rFTtYctntS8qPE1EjbG+xkAfRdaBfBfqgh0rGB3mYSjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=BW2SmmI2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1667002b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455116; x=1757059916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6eabj27DX8zdCQcARk0zTIS/c8ApMN/doeFLRhhkp1M=;
        b=BW2SmmI2ca64Lu850fdrjKMq27KS5H7u/wMst2dPLgw2Efl5iYjs/gRqUOfGpVHBkU
         /JRbENO1c9QrxW7NtaQlUu41QxqKRdfXafpeSqWb/BzY9CZSAINqzR2XXwUmVBkmj8nP
         ntQewJ04euL2XMAxaNhSkBrYikRPdAAs7zP2+NmC5c62VRTQMrL9f5pS7hanj81aC58m
         LSujjyn6FTjEt6Ef79VlV+mELlsuqeFUI1kEvLv3R5ZsoSkIoSQEnTB4Gp3NMj3I3TmI
         2ZFOiBnV6xC65NFHLsy8cIvx9FrMc4/v7iXYEY3OCD2zdWp7ZWwniJ7Q5dYoc+zQmgG+
         f2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455116; x=1757059916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6eabj27DX8zdCQcARk0zTIS/c8ApMN/doeFLRhhkp1M=;
        b=jZS4kjWICa2n2cN+GmmIeSC1sBCWxo6cuq5Yxu9xz7r5alFS3dppYcoqLAJHQQ2LQ2
         hQAY6D929CQiLQGCoErybWXZet6T4+xBKNmE/Kayt8KZMJG4P/i8wVpt9plDoxj/O8h+
         iGSay9E/g36wlAseDp6OCCR5TRO1pxN5CUiWOBAvZvEDRYs42YY/nOOM8gI5IdZZLbmJ
         1+c6BvZ2JWaHJUNi1mXv+v2Dicfr3QXKVrIziz76v6/PCcAr0EGXsMyyELUgF6oJLDjz
         5MpDgCF0d8PEeaCBdJRjaTJtN/fuuM1LmZG0y2cqeoQSZO9SiPg1o8CVfYsU1RUbuiEb
         aKlg==
X-Gm-Message-State: AOJu0Ywb5mxe5rf2gMHAzic1YWFEKsOU5Qe3tlw+p3Iuewgc3tvZQi4f
	jMUMZlrdXKXfM5r3VeW6YsrOcU6KMGSGqAnBnh/W5/kvRy1PHIqmf2xKT2NOgMo+6g==
X-Gm-Gg: ASbGncupnLPF6sI6CNrZpD8e2X6aKP0yfRvU9afQ0FfeI5rlbNATegnQy0B7B451Lkf
	jNKbUyE2A02PwKNIxPCvvYjwnOw3g4vIoXoPM4oPOCkLEKcm1KzmoF+5Ny7WeCoFhDy/xTqCAbS
	jwNfyF7q02czFE5F/qNFzshBx95VTCuojCFtR7GhkU44+S7f3dJ5wetMdwF540i3OhBWMTOh9ZG
	ByPTmXdEeXDGR/3zaCSiZHkpVjRSEVHBqWDOqN+7wZL0D9MwPXLOugwFjMOuuuDLdI3aV+GYCUm
	pLAByz0bGuMngwlDUIhtQuVtx5yr7NIWTFzUP0a0DsmQhwjXHjUJKoVVknax0Uks+KUisQ7Lj5K
	6KTtmHMuWPc7eTmYPcP/el5WuYGCXexmQnxJ2Dl50zADGidcmIF5MvmDeC0Kbta2Wzmwj
X-Google-Smtp-Source: AGHT+IEk5+0icej1GKS7ldwjM8iNlE0toZfC28/3mzJrnL3tTxhHNSdeCeNEs8V5Xx9L2Q0j2f0SJQ==
X-Received: by 2002:a05:6a21:32a5:b0:222:ca3f:199 with SMTP id adf61e73a8af0-2438fad2e7fmr18134003637.18.1756455116359;
        Fri, 29 Aug 2025 01:11:56 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:11:55 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 1/5] sched/fair: Add related data structure for task based throttle
Date: Fri, 29 Aug 2025 16:11:16 +0800
Message-Id: <20250829081120.806-2-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829081120.806-1-ziqianlu@bytedance.com>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

Add related data structures for this new throttle functionality.

Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tesed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 include/linux/sched.h |  5 +++++
 kernel/sched/core.c   |  3 +++
 kernel/sched/fair.c   | 13 +++++++++++++
 kernel/sched/sched.h  |  3 +++
 4 files changed, 24 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5b4e1cd52e27a..e0cc1d6df8122 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -880,6 +880,11 @@ struct task_struct {
 
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct callback_head		sched_throttle_work;
+	struct list_head		throttle_node;
+	bool				throttled;
+#endif
 #endif
 
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f7f576ad9b223..3f7925b216911 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4484,6 +4484,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c2..8fff40fcbc425 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5748,6 +5748,18 @@ static inline int throttled_lb_pair(struct task_group *tg,
 	       throttled_hierarchy(dest_cfs_rq);
 }
 
+static void throttle_cfs_rq_work(struct callback_head *work)
+{
+}
+
+void init_cfs_throttle_work(struct task_struct *p)
+{
+	init_task_work(&p->sched_throttle_work, throttle_cfs_rq_work);
+	/* Protect against double add, see throttle_cfs_rq() and throttle_cfs_rq_work() */
+	p->sched_throttle_work.next = &p->sched_throttle_work;
+	INIT_LIST_HEAD(&p->throttle_node);
+}
+
 static int tg_unthrottle_up(struct task_group *tg, void *data)
 {
 	struct rq *rq = data;
@@ -6472,6 +6484,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d3f33d10c58c9..06cc7722226b4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -742,6 +742,7 @@ struct cfs_rq {
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head        throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -2661,6 +2662,8 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
+extern void init_cfs_throttle_work(struct task_struct *p);
+
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
-- 
2.39.5


