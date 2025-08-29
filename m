Return-Path: <linux-kernel+bounces-791339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40616B3B59A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B06E564B07
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FE529BD97;
	Fri, 29 Aug 2025 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hfwTQH+C"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA229B22F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756455156; cv=none; b=BcgyfX1DqSfm7H4Kmy8q1woCpf072pjwa8rmzcsthXu0IAvurfkg3KuOHq56HZtwrYtClfCHpVZVaTI3DweOy3elr5/GPN1C0UA2UDPQuldklBcavCc5J/BVHxBU+nBRWj4RahfsG4tkeuZcwWEAyg1FTyq9rPemj5tf456cDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756455156; c=relaxed/simple;
	bh=0dsieZFmfNAaOeFpRnn2Afkk1eYQS//XaaJ2HNWocj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MM29pL82WrQhsH8C1k8wiOUIm3ihYeOFxTHbm9thKvIJC517j8Yv+E+g8s83D5mPBrtp8fEBIwI40vJTQbBT4kMVxoNWOYV/WWfRzPGCUkpzustjE/N4GxWLH136A8BErp/lvtc9iNY441J00wBSdgZdOjT7f4U5gyLdNqs1vPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hfwTQH+C; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7718408baf7so1794272b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 01:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756455154; x=1757059954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KQR4M7tUNbRaMAh3tA6D7ogxNR4dZwXQrOX0NUoHXHI=;
        b=hfwTQH+CF5zttLWHYJvKZbE6ndq94/RUliFIePfbcS+I5792DjWpPB4SZ3E5Hfrogv
         d24wk2JOADKY9iJSnQIOudJXOCC2OHRCxj5D9vm3XCaor1Q1ROpvuEzYWTDqvMD8RCgG
         L8/Jm6P7tIn9rAZcv2yu4QMuDHmqsivJbsXkxY1AYcQpwfRN6kT6VprO0MMPcikinH00
         qe0DGjeGMhAIODeeZj+RZrZUL2C03i49qgYMaT5hYoQ6Pw1VreD1i585EN1+i3tfLtBp
         KCvggiU+zb2DFK7PDiuTbdfGz3QQ2+VaHr9A5RFxSPQC8V/5Qmx8YDrMX4P6FduvcCW/
         FOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756455154; x=1757059954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KQR4M7tUNbRaMAh3tA6D7ogxNR4dZwXQrOX0NUoHXHI=;
        b=k2J2MtKAZVyG7YVWDsD4nrPlO8SegVge4dTHL9K7q9Yjwvt0ALsjQevUhSKNSqH0ZX
         FWgeLDPJXl8cv+95/aYC/iRrJbdTrhmfUkTSwlTBdOPrpWvoTTA5pE/pI1iTdrU33uL5
         JEpJnNyhNkdlwDykR/Jeh+Nz3QUkiwnYqNkVgErulmUriPuc3yNYl+JZg6G/p+MjvtQY
         9JKwSx4c7SKe9jovIuAcSYsNzfD66HvIeOSeSso9hhsRMdGqy741B/5wAmL7KdRaPXZk
         s2sNMPazulrY4q/lq4siYjmSiFTQTXh+N3QB9mKVUV2Zoot2DEHy5H0hf8BdMLFchlSK
         al/g==
X-Gm-Message-State: AOJu0Ywkuza3DDGZnTcw/jWiByEb0kW1kiZpBLJamLwjFhc1t1/gWa4A
	yhxiRQlx22weHF9EtlUOkf+XMoiEj4u4MGOQV9e2PIS30yI9BDIeBeChF5zEdc61oA==
X-Gm-Gg: ASbGncsSyUj9pyGXPwrPglM4K/3I8cA767ro3yaeFzN0QxOBX8uk/tzfp+Dm3HLKFy5
	PHGeiRpVjA+lapJH7pcPKyuQtFsCyUUZ1SofA7sNb+oB6taHtkIpDMeVk0M23V4qFBTRzImpFgA
	Y7smhQH1Eu4YYYrnLR3mu8f2e+/sqQapjYMzpFUCnCU+A5aICs88z9v2vOLGD5jtMwKwgYbVXAP
	H/5QIiVMak7/vXmDGeGMUBtLPsYigpmwQve72fLfaji+b35Ofvdw5wKX+7sU07ck8p6r5fZlOi+
	o1EMRwq96YlRIiIphnBuvXYTmZOi4f++rFcaQNt1u6lZxEKPv614stOaSsvs4bC3UH0ARUMh8ha
	oqMLrBA3DdVHe62Xhf8r2tq1D5tVZQBY3/1ypE+CGkwoRH9A4pmAx/M647ynVrnZ+/WPNwAD2Vz
	Yz4QM=
X-Google-Smtp-Source: AGHT+IGnO806GjGlKUlXdFb9K9bbQqcCMBinu/O1LdIGX6ZYPdDYwRK6h/QGXCjJrkEIeoqh/gTGNQ==
X-Received: by 2002:a05:6a00:a1b:b0:771:e414:276b with SMTP id d2e1a72fcca58-771e4142d38mr22668289b3a.31.1756455153677;
        Fri, 29 Aug 2025 01:12:33 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2da9c6sm1601419b3a.42.2025.08.29.01.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:12:33 -0700 (PDT)
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
Subject: [PATCH v4 5/5] sched/fair: Get rid of throttled_lb_pair()
Date: Fri, 29 Aug 2025 16:11:20 +0800
Message-Id: <20250829081120.806-6-ziqianlu@bytedance.com>
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

Now that throttled tasks are dequeued and can not stay on rq's cfs_tasks
list, there is no need to take special care of these throttled tasks
anymore in load balance.

Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 35 ++++-------------------------------
 1 file changed, 4 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bdc9bfa0b9efa..df8dc389af8e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5735,23 +5735,6 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttle_count;
 }
 
-/*
- * Ensure that neither of the group entities corresponding to src_cpu or
- * dest_cpu are members of a throttled hierarchy when performing group
- * load-balance operations.
- */
-static inline int throttled_lb_pair(struct task_group *tg,
-				    int src_cpu, int dest_cpu)
-{
-	struct cfs_rq *src_cfs_rq, *dest_cfs_rq;
-
-	src_cfs_rq = tg->cfs_rq[src_cpu];
-	dest_cfs_rq = tg->cfs_rq[dest_cpu];
-
-	return throttled_hierarchy(src_cfs_rq) ||
-	       throttled_hierarchy(dest_cfs_rq);
-}
-
 static inline bool task_is_throttled(struct task_struct *p)
 {
 	return cfs_bandwidth_used() && p->throttled;
@@ -6743,12 +6726,6 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
-static inline int throttled_lb_pair(struct task_group *tg,
-				    int src_cpu, int dest_cpu)
-{
-	return 0;
-}
-
 #ifdef CONFIG_FAIR_GROUP_SCHED
 void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent) {}
 static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq) {}
@@ -9385,18 +9362,14 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) throttled_lb_pair, or
-	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 4) running (obviously), or
-	 * 5) are cache-hot on their current CPU, or
-	 * 6) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
+	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 3) running (obviously), or
+	 * 4) are cache-hot on their current CPU, or
+	 * 5) are blocked on mutexes (if SCHED_PROXY_EXEC is enabled)
 	 */
 	if ((p->se.sched_delayed) && (env->migration_type != migrate_load))
 		return 0;
 
-	if (throttled_lb_pair(task_group(p), env->src_cpu, env->dst_cpu))
-		return 0;
-
 	/*
 	 * We want to prioritize the migration of eligible tasks.
 	 * For ineligible tasks we soft-limit them and only allow
-- 
2.39.5


