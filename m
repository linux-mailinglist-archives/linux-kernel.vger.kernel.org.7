Return-Path: <linux-kernel+bounces-731335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FC1B052B1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208E93AF725
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93168270EB9;
	Tue, 15 Jul 2025 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="STGbBMjs"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878ED27056F
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563879; cv=none; b=aj0hatEUIpPQ+jvgS5YYS6Rk4V5EStVAn/ubRjpDGDmqGhDanM4MEKR3Wp1Vk5HhFVzzfohyTPGsmnHifVVMQrIsjCsZxttxoNwEilqBuLQO0PvmLfc8FOkJ3NfSsyUnNgXc+zz/sz+EE82F9z4OGomPCXuyiozX8BPT1rzj/KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563879; c=relaxed/simple;
	bh=7S12Kx/+pu7va46srDHLwpoos5E7kNGOGKl3r3NNQYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZjKk4k90kvorCuJz8oVBFrE/aER++qFiAoTSJDO2bQKAbirjE2zTzJZxp2sizKK2fAPVzCxtvDMZz9LuUM+XsfGrm1+TYVJ86/zLQvq2+xkh9qhXIJvKQm0Qoq9sarecl9H3cDLHMahjDRzPIetsj4Y/TTwC9V8Kv6ncTjFh/80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=STGbBMjs; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-311bd8ce7e4so4439946a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1752563876; x=1753168676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qx22eCiTcsq4MxY3QAurLhlT/uXLzbG6OYMradToRYU=;
        b=STGbBMjsuBxqDBQLoJD4dwzh6kvbGiTGIMAh5x5CcNmbMww9NIezvTZWVyxBXC2YhT
         mzFGwGMIjIPt5uJ5jgID+Tnlvb4f9NLl98rPy2A+oHgf2CXwOQh5dL0jzNRDE611XMS6
         qvyHxURZNKpHJP7KsG10IMJxIPqc/iPqidwJyS7UZlxysg1ZBPQ3ST3I4irN7JWf6ZU0
         3iy8KLiSDV8liTCic5SePFrZ3mEgwKVxuBt2ed3+6fEWiU1VQ4trUwFYKKu7RbwjDnIG
         O58SmE8DETPXpNSrraffHBdweJn4EtGEgl54bj8sAO8/RX1BFK0TT5KYy33lqZIDsz9+
         QyxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752563876; x=1753168676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qx22eCiTcsq4MxY3QAurLhlT/uXLzbG6OYMradToRYU=;
        b=gO9NY1vKrMHuwsKccktAtShr5eH5mebB6XS6APJdkBZ/MzN3jYR/B/6At/hETW3Dn4
         OVIyvqH8+bNQPG3LYPO4rPXVPuH/ciqybrujNgGQPqKWCJE263xYR8hBtcEeO147CS2g
         q93IhWG9/oFjoirUgsfhci+fH3kTPdwk0OtcLLtCdShx1oLIEdODaylwe9W9ux/HpFP+
         HYKkO/Kvc9qXTdMdiORatlPyaQp4JKJVGIrbIDMeCxkRogyRoe3PQ3ckZAkzOFMnZqt0
         wavBFUM5GvK4ZVysGZL/iHSUj2/Gp04tTNkmGOQw7Kc47uGQm0gSaN8S5oraKXhS30oZ
         bWFg==
X-Gm-Message-State: AOJu0YwOEb+SMirMQy2PDLCippvL7UooZtyKUiUocK4JHmqiyCY8SruP
	jjapCPcYZzsJy7XL7JQdaPxer+G5ISY6y/KH9VJ2nOkpmeseQdEG6zjPh9+kZN/pIQ==
X-Gm-Gg: ASbGncsOnRIY605PrF9wW0FX5au4L1xqMKlCSzN7SS7NY5g6D9GOTsZ4FxC7LoCm3rc
	o9yhiNQiKY7poLfuePBQXZyRcMmbGEvDP3xWxHg+Y1m65FXeveACo1YAK9OgRjlMhklG89eWEvS
	u+3S5AhRtYP6pcvVU2Lrb9T2CNXcrOnZ9zlhZp1/H5KI8XSI6yZ9iq/n0KzpLbb2tEWjX/3EpNt
	VVoUHLVZ3phKAWHXm8ncpgwH4b6MvQnTaYf7cdjHfaLkV69PVfg3lOdrpn3xq6tFhzoODGXPueE
	T8FmJVjzRhgpr3t2SRamuPlsxsYpKX60d9/A3AOR9lEop21eXqK+VVrFF0N1dtOMvOSZL9mRVBR
	5NI2ytRpzbB3qJC/+l5mq2ZgTlbCHCoA2Dkm3lTTZ2Nm+nC3kfGgweJM/sHgy1azBXXiGfk2kkI
	UGNoQ=
X-Google-Smtp-Source: AGHT+IEPIx73XZCxGMmIDvVdsyoxwRZZttJSvyDIEDE848LozIB8uztqgF2wAlwMGCbUORYqxVrvXg==
X-Received: by 2002:a17:90a:da90:b0:31c:72d7:558b with SMTP id 98e67ed59e1d1-31c72d75601mr11721528a91.32.1752563875745;
        Tue, 15 Jul 2025 00:17:55 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017c9dasm15013418a91.25.2025.07.15.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 00:17:55 -0700 (PDT)
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
Subject: [PATCH v3 5/5] sched/fair: Get rid of throttled_lb_pair()
Date: Tue, 15 Jul 2025 15:16:58 +0800
Message-Id: <20250715071658.267-6-ziqianlu@bytedance.com>
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

Now that throttled tasks are dequeued and can not stay on rq's cfs_tasks
list, there is no need to take special care of these throttled tasks
anymore in load balance.

Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Suggested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 33 +++------------------------------
 1 file changed, 3 insertions(+), 30 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f534fbe89bcf..af33d107d8034 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5729,23 +5729,6 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
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
 	return p->throttled;
@@ -6732,12 +6715,6 @@ static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
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
@@ -9374,17 +9351,13 @@ int can_migrate_task(struct task_struct *p, struct lb_env *env)
 	/*
 	 * We do not migrate tasks that are:
 	 * 1) delayed dequeued unless we migrate load, or
-	 * 2) throttled_lb_pair, or
-	 * 3) cannot be migrated to this CPU due to cpus_ptr, or
-	 * 4) running (obviously), or
-	 * 5) are cache-hot on their current CPU.
+	 * 2) cannot be migrated to this CPU due to cpus_ptr, or
+	 * 3) running (obviously), or
+	 * 4) are cache-hot on their current CPU.
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


