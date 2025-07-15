Return-Path: <linux-kernel+bounces-731331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70513B052AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96BE24E3990
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A82E262D0B;
	Tue, 15 Jul 2025 07:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fJgtAhtY"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3484E2749C0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563850; cv=none; b=HRKAoz0/hOM+iPBHxTiiomfw74efIl0yopbHtLlZjiTQ2glq0Vdwmyw/aJ9rE0/7Q4hpq2N8Al+nZekqvz4G/dQgECUSCIQR/lmAnCerFgylrSUdqUFgcdHU2nHdblbE8MHqK4R62aJONnhRPdxaDTXSX7oTozNWZq/4AscUUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563850; c=relaxed/simple;
	bh=rptweIyw/NRNiRqKRKKVpvw+BcWwy7ff0JBJo9uuJTo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cCkeWyzWgR4RXCTa6djE5M0tDPGykZLaQmveaPw1rZA47DrGJYmMzPqV3qGEBVNj26S/Sle6H8gxmpooIRLITnFJdsgLTDFiF25s8MULZLXzu0V+pMe1FHNEBW0QtP98sEbUp0pNXozBQDfQV/NHMpGLe/mOJzDHKRvXhKgLnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fJgtAhtY; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31d578e774so5149021a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563848; x=1753168648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6ciipY/2CcI3D5MilhNzIQovP73zwUUwEnia6Ju3vQ=;
        b=fJgtAhtYgKpsyAbGkHRp65guXx05qXk2c4E8mK9F2piGqWGQcjdxm7yc5NSj7TXrRm
         q9iRbyFpjA+dep7ffsubaQRyGfjgvRnSAIW5YvQ4pZMzCDwTONPEE5vFGvttz9NmOt0S
         xSYVAhI7QY38/1SGRwtiK7nCss10pVeOQTwB+RpO27VpaUzpZuOnEofBl2MNn41Q39L2
         rwjn+1XOn8+5GR0CnboUReVlqzysuwx0R+RCYqlbx9w1BG6ntx7GZeUiWJljk5rzRqkc
         EsyG/axzivC7EDWNvliHD3HtzH7NHMlEsamqTpAKk+bF2kICODECKVto7PnxDMBkUfU3
         XG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563848; x=1753168648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6ciipY/2CcI3D5MilhNzIQovP73zwUUwEnia6Ju3vQ=;
        b=SJb5WaE7t9dXVQX251sJoEV070d673/YsjpFdR0HQqSGtwOdY4chZ0yH4qK5XijYR3
         mLdMPq5WZC2tzLGRssXXeHCw0Ro50V+a9LtYY9zRfUXTiANAM7i8Vj2QZvscyYy3wNVC
         Xiy6hbR9NqWGs+M5t/SnDZe+kFyeeHJGARJ1GX1SakXWSPd0FITEm21Kwmkeg1ofpujP
         mLLMAS53A8TWYf+kJiA0v5dMDRhBz4xOQWbjXBr8FCgzKdR6Hmk72gTDkGQmdz2DR5cj
         gXvSe/BPNNXFBSthjMQAcm89r6KmsdvTAcsuaOt7a+gUVzfP/V6k4BuK4AYGjsQ7NGA/
         yMJg==
X-Gm-Message-State: AOJu0Yy3T4OAACkxOEj8Gpn7a7fo7WwGPDUc0u8TIlXvQVJa8WJ3nBRW
	fVbuueOtdrYweE6jZONQnZdYpd8Y2l1HLSA2E+4EARtJvAcjF7yMHIS7D94DYd+bvA==
X-Gm-Gg: ASbGncvlsk/9rvcw6KxEo1lHS1WwhXvFWRwKilifpYhWr/POnKxg0MIkGdCS2/oKz/W
	s3ab4ufLkpI+8Ftv9D0uTtagNp4rrILaarR0v2+jricawXX3nX+H0ysKZ0D4JP9zx6kic7CtPMp
	JcppZrHWR+Gnrh3ShValFudg9n3maR6v5w4jl1LNhbXbs7TZnri1Dq8/fH1RE5HFbnkHvbf7V1N
	E0SHbY36XPrdqocLA+EZnos71s97KONcDaRxHuD+7cMahhUFGj0wnaVwMBhgfbL+M7CHecZ4N5r
	JpCEMFRLsspEY77r0CUvlFQUWbmFfd9dn+BsLuBgLl+zeREe6V0cqy3L6g5WYLE3sQQgO+ssUIH
	A+g1IH4Jn3d/BaN/1WvCnvXtNDEf3OvlSS6idquOI4TFIPqNn7wCR+23X4X45+DMl9Gsb
X-Google-Smtp-Source: AGHT+IFedT46DgA5ze04v+deQqrmROgZV3DFwKIlx5WfmpHKQ7zMe9WnqNhy/1b7VP+7NhOOjx6AGA==
X-Received: by 2002:a17:90b:4c8f:b0:313:d361:73d7 with SMTP id 98e67ed59e1d1-31c8f88e440mr4456583a91.13.1752563848169;
        Tue, 15 Jul 2025 00:17:28 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:27 -0700 (PDT)
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
	Songtang Liu <liusongtang@bytedance.com>
Subject: [PATCH v3 1/5] sched/fair: Add related data structure for task based throttle
Date: Tue, 15 Jul 2025 15:16:54 +0800
Message-Id: <20250715071658.267-2-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250715071658.267-1-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Valentin Schneider <vschneid@redhat.com>

Add related data structures for this new throttle functionality.

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
index 55921385927d8..ec4b54540c244 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -883,6 +883,11 @@ struct task_struct {
 
 #ifdef CONFIG_CGROUP_SCHED
 	struct task_group		*sched_task_group;
+#ifdef CONFIG_CFS_BANDWIDTH
+	struct callback_head		sched_throttle_work;
+	struct list_head		throttle_node;
+	bool				throttled;
+#endif
 #endif
 
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2f8caa9db78d5..410acc7435e86 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4446,6 +4446,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
+#ifdef CONFIG_CFS_BANDWIDTH
+	init_cfs_throttle_work(p);
+#endif
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20a845697c1dc..c072e87c5bd9f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5742,6 +5742,18 @@ static inline int throttled_lb_pair(struct task_group *tg,
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
@@ -6466,6 +6478,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
+	INIT_LIST_HEAD(&cfs_rq->throttled_limbo_list);
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 105190b180203..b0c9559992d8a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -741,6 +741,7 @@ struct cfs_rq {
 	int			throttle_count;
 	struct list_head	throttled_list;
 	struct list_head	throttled_csd_list;
+	struct list_head        throttled_limbo_list;
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
@@ -2640,6 +2641,8 @@ extern bool sched_rt_bandwidth_account(struct rt_rq *rt_rq);
 
 extern void init_dl_entity(struct sched_dl_entity *dl_se);
 
+extern void init_cfs_throttle_work(struct task_struct *p);
+
 #define BW_SHIFT		20
 #define BW_UNIT			(1 << BW_SHIFT)
 #define RATIO_SHIFT		8
-- 
2.39.5


