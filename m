Return-Path: <linux-kernel+bounces-866535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B352FC00096
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2211892507
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919423043CB;
	Thu, 23 Oct 2025 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EsbvViYe"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9602DCF69
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761209788; cv=none; b=H7RRSmlcN7HEyntCYthM0T7PM4DgpNtuCIyuYouxwhPtULsNXBnH9ZA1uPM8FXlhkqWDRbx5b2nPCADS/Aw05KAIHYhWAlEWB1O64O5MPvjuvOv+qWu+lGU0QsulmZjCqn4rPWGxoQIy4DNDKOwaIo4IsWe87STUzInNN6XLjHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761209788; c=relaxed/simple;
	bh=YtE19ebYkqgdF+fN5Fww0ETu/QAqTE7cPCVXsYBa1TY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sfcLigITOG9a4R1vGBRSypAPq++SLID67F5hMNUHY01ZnYbCihcgt3hhx8ifSf0c812l6nyQ5HcksGSB3oRXsdXBCz9fstRBwhocJC7FV0Rj2g1qvJaf6hZk+yo+h3uHdTHGIfopHRnocb5D+VgTWGqkJYZY1SIA36q6VEg4VBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EsbvViYe; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2897522a1dfso5548855ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761209785; x=1761814585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VQ8Y6jEyc4dyX1qTw6bUcPgLQL2phfNVx7aCil9/gNI=;
        b=EsbvViYe/jRunLDW1dhIVXcQbPjqJYLgZlKhFICV568GM9B0VNpUQeBRerrmB2a0gt
         6l+UC0JHUbfShcsuZEyULm4+IOy6mt7UcguymB7TRpVTZRKpfoLJPVxz7RbbJ0OLdaZ7
         Z/ezKGd08KJ+2h3XrH9SuLw0lWKCGPopogwxDGwWf65vGqPAaj4Jjj3HQ63Ah85A65QK
         u7OqvEGW5tB1REGdTUNY96hcnZ4c7X0KkDZGCZljHGBUfGV7YprU2cvriovfrDw5spcc
         UiiV/+I7NP7k9MqNNKxizQc1uB4dRuJGXTTdEzftLCKdZ3sjoKTysXAdA5pvDlOAdT9h
         30QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761209785; x=1761814585;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VQ8Y6jEyc4dyX1qTw6bUcPgLQL2phfNVx7aCil9/gNI=;
        b=YDiZNuCURvM9skLqWf7vt4e06smDAeWK9kd6KTHAEUgiGBk5KkXQaOY8LNw0H4yY1D
         CRlElBXiIlYd8vpJ9rHzI9Kl3qgvZOMRhv7pkopI67uTRohbpRXOcrzo4Hzjbzt8BLaG
         RuXl7z+HqLXYEUk2BhUlPp+KHLDToX9ipqPsCSsHIXTNbGlQn26Y3OBPDF/4g6O1n3TY
         5RGucomkxgr/bEr1ZuVsVWG7NxDFDUEOHyPs22GCM6t0ms8ZLOgWOTCI2kabvDBk4aPY
         TbAo7L3lE8YzDEDbTWHPx/wwc3Aq59iFiWXCrRgecG4IDHt7a/L+MNMnbxofH4jn6j/A
         EVtg==
X-Gm-Message-State: AOJu0YzRC/KjMJLPNMndBUGblKTtyE468yJqa+YjPQxFQcNm+aeb8Gbr
	yTe/6CsOEb38T0xNKEX3P5nnCU0+fBNU2fdrgBwervdDCVdiWuhVlhhNIs3WLP6SaFO+pSUrxdT
	xGCuciQ==
X-Gm-Gg: ASbGncuTQMVSMmQC14Q9vm9pe3H/QZ8CYVXeqhgINTtrS5ICFHaK+EJrIeGGh7+9xQJ
	TsMn6SwU2Kf8+cA6GLRMxpA05MeuCA6WyGMz3uxiTwjQiRlbSIGUK53P5+4FP9JN3plE9xjPrJ/
	SuMrbgCvmuIMGZI6M3b93y4+ej5V3JiHDIUVZL2TngY79UKddfhe5lJcN9Kmkv2fgKQeMZg1p9i
	flJ2ajqKDBcfhtKsFImG4HQTDhbMlKchQDkry1sG2qb+piZ9CvoUhFw9wds/4k2Ao7fd0nETD27
	uMuHmwzWMYGneHrkClTzLF9KkD2nrScz6N3PuT7eV8wMEwYdnVzuRwJJS6NfhLKM2+QZzYuPwpQ
	mLcUHU9B/wYsYkGYJAWo9vRIMBruFOtQOvhI9y9Fvc1srhSGYNfPV1vIr+w8ZQr/qe14XVySDGC
	xbjzSgwRx9LK+W/d4kurQfa7vBWbJXJhgn62KWoWWPi2s1lg==
X-Google-Smtp-Source: AGHT+IESlhixk+ONq5iC5HkGOQdHzCtFO5kX32r4lwZDwmyrvjJpCGlfDn3g+ZcKEM3F7zkV90jd4A==
X-Received: by 2002:a17:902:d2c6:b0:290:d0fb:55ab with SMTP id d9443c01a7336-2946e24822bmr21260025ad.50.1761209785155;
        Thu, 23 Oct 2025 01:56:25 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946de0c894sm16415895ad.47.2025.10.23.01.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:56:24 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Hao Jia <jiahao.kernel@gmail.com>,
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
Subject: [PATCH v2] sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining
Date: Thu, 23 Oct 2025 16:56:04 +0800
Message-Id: <20251023085604.244-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a cfs_rq is to be throttled, its limbo list should be empty and
that's why there is a warn in tg_throttle_down() for non empty
cfs_rq->throttled_limbo_list.

When running a test with the following hierarchy:

          root
        /      \
        A*     ...
     /  |  \   ...
        B
       /  \
      C*

where both A and C have quota settings, that warn on non empty limbo list
is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
part of the cfs_rq for the sake of simpler representation).

Debug showed it happened like this:
Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
*multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
these throttled tasks are directly placed into cfs_rq_c's limbo list by
enqueue_throttled_task().

Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
can't get more runtime and enters tg_throttle_down(), where the warning
is hit due to remaining tasks in the limbo list.

I think it's a chaos to trigger throttle on unthrottle path, the status
of a being unthrottled cfs_rq can be in a mixed state at the end, so fix
this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth() immediately
after enabling bandwidth and setting runtime_remaining = 0. This ensures
cfs_rq_c is throttled upfront and cannot enter tg_unthrottle_up() with
zero runtime_remaining.

Also, update outdated comments in tg_throttle_down() since
unthrottle_cfs_rq() is no longer called with zero runtime_remaining.

While at it, remove a redundant assignment to se in tg_throttle_down().

Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
v2: add update_rq_clock() before throttle_cfs_rq() as reported by Hao
    Jia, or a warn on outdated rq clock is trigged in tg_throttle_down().
    This can happen when user specified a tiny quota.

Note that Hao Jia also proposed another solution by using a special flag
when doing enqueue_task_fair() in unthrottle path to avoid doing
check_enqueue_throttle() [0]. I think that approach is fine too and it
also has the benefit of not needing to worry about any other potential
cases where a cfs_rq is unthrottled with <=0 runtime_remaining. Thoughts
on which approach to go is welcome, thanks.
[0]: https://lore.kernel.org/lkml/c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com/

 kernel/sched/core.c  | 11 ++++++++++-
 kernel/sched/fair.c  | 16 +++++++---------
 kernel/sched/sched.h |  1 +
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e21..58185ec5b8efd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9608,7 +9608,16 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
-		if (cfs_rq->throttled)
+		/*
+		 * Throttle cfs_rq now or it can be unthrottled with zero
+		 * runtime_remaining and gets throttled on its unthrottle path.
+		 */
+		if (cfs_rq->runtime_enabled && !cfs_rq->throttled) {
+			update_rq_clock(rq);
+			throttle_cfs_rq(cfs_rq);
+		}
+
+		if (!cfs_rq->runtime_enabled && cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb2795..ddf405497b828 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5976,7 +5976,7 @@ static int tg_throttle_down(struct task_group *tg, void *data)
 	return 0;
 }
 
-static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
+bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 {
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
@@ -6025,19 +6025,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 
 	/*
 	 * It's possible we are called with !runtime_remaining due to things
-	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
-	 * unthrottled us with a positive runtime_remaining but other still
-	 * running entities consumed those runtime before we reached here.
+	 * like async unthrottled us with a positive runtime_remaining but
+	 * other still running entities consumed those runtime before we
+	 * reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
-	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
-	 * throttle, which is not supposed to happen on unthrottle path.
+	 * We can't unthrottle this cfs_rq without any runtime remaining
+	 * because any enqueue in tg_unthrottle_up() will immediately trigger
+	 * a throttle, which is not supposed to happen on unthrottle path.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f5d07067f60a..c70a833ac9a24 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -583,6 +583,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern bool throttle_cfs_rq(struct cfs_rq *cfs_rq);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-- 
2.39.5


