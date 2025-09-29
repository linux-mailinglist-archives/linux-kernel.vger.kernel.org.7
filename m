Return-Path: <linux-kernel+bounces-835901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1047BA84A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6672A3C1FF0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B98A2116F6;
	Mon, 29 Sep 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VfCp2oio"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C921EEE6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759132025; cv=none; b=EGku47CH9s2sDi1nN43xMiZVl2V7Sb4/NwNYkIIfq8EIkYL6TiuROOb3uKTydfAiVQvbAZL2K0lLkazqIuijoJdg9bO8Vg4bpQQsl5vm64cQ5uq8yvKwn6u/w3NtvD/A9MElxVA5aqVDrvRYw82zRm+ouywIa9yESa8V0U9b6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759132025; c=relaxed/simple;
	bh=hHaKN9BmmrGTnqnegKyr+mInFP+y2cDrwBloAI8C5QE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QROsC0HKcmTsHw6KLVswyzTUM95rpecAQ7BU/7l493q460RjskqVVqJKz0lN4VNfL5Q6aJo884pyqKXfRWXsV0C0EoHPp0keTZNEdc9QWiKonynQBtiODZoqai19MTOjlLd9IKxQh+B32/0sEidaztaPg9Owb/JUtomGJ7WYAaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VfCp2oio; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so969711b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1759132023; x=1759736823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGQ9oR0Tdd0oe1jWlKmG4p4FpQMJSYOO7NfHqpie1Lg=;
        b=VfCp2oioH1W3ZqeLp/0xq0pSxK0u3czYluel8CV05IQuRxJx+ZcNnd+NTVSYre73oM
         Eix8J1tYiNw40yN9mweAOLlr1DQh72uBSzeb0YVIzyGDgZM01hi0XREIHVsZZAu17do0
         HSoBcvdTkVPjKB+TeDoniW5aALk8jHOWUFjiMFBOWYKNTZ5X9GXzRxn1XxblN8/NvwiB
         ticK8PjAHjFTitOHyKeaJU9jeZJYuPMbSdEifvVtjmCJuqv9ukmurNp1fAHmlw7vg1/G
         wLpO4qdFSTOBLL/lR/ArDqbxlk/MezNW9doNUyx4kJI5YhW8CtyDXUSxYzh5OEgnFuDo
         i4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759132023; x=1759736823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGQ9oR0Tdd0oe1jWlKmG4p4FpQMJSYOO7NfHqpie1Lg=;
        b=cghYdQcpxUPhnrc38PA4TYN9d2n/2KF3Pfkeuq5WaoLeT3UARne/7TirGxvqSn+vs/
         n3UxycaxgJzdqlv0RGrMbEVaa7RAOFmdplkGuNEopdwDasajMqXQUtU3JLObN/9FiB9Y
         QWOQVYLHvM5v0xgb/Cj7VNkPO2MF1gKTX5noEr3Vt1cdxj3LUDVdoFb+GmfxG5tndahF
         VzPZOuhFMtY1KVoBk76rSQCZowH3+Ikgwsyewx934F5wboGsWQI4jxdPNCB+Q5atGZPH
         U9qc5gKYyr6bWi7XapA0t/M3T9JCBkUAft2V14mFYYJ/PaC6RxeqG+aBVdpU/4arF0Qk
         Q78Q==
X-Gm-Message-State: AOJu0YxQUd6oaYPLCRu4MFH4WoQhdr8T4WUu9C8MTmK6kY5C3+7mi07R
	5DgrdKDsbkzFBvAFuFR3DNyhRcsY0fnjyjkFMmQuVuBOotvjREDO6Uut0MjoETlckA==
X-Gm-Gg: ASbGncvnc04Ke9BEbmyASdDx3LYhuajgDFhvqzVeUgrFaE2grj6//ifwdxnOJRxweja
	3YXU48dlt0Z2NBiYQ/LrLcV8cIRy3yuNGRxmnn8WSxjCavxjv3xqMNOXITihj2azeUihD2FWeP5
	S1tW4fMBU5Hxz9DJuTz5xlal5QWb8lWJkEt1AJZ3++wLPu6V2sHn3jMwfSp+yGdA/3Ot0fHa33D
	0U8p81VywPc96tjNmYCFeyXLeZHN/kFO/vG0I3cxgZXN8uD4mzySnvYCy3dCu9hPB9Q+wGrRNrY
	4rpn4cHVyrTAq62B7P4FYM9FP8Lga8DPg/2SMhaWnBCd4c/FzFSZn8i5+u7WdVhQV6f3EK1LQJH
	BAZRThQRgxETDSRcLvG/RwIcXIAqjb909w++Eybh4uBlXFXOJH2ia+EmWeVcwcW0mGzEgWeJXV9
	7UdGK/qoSqIQ==
X-Google-Smtp-Source: AGHT+IF5qIIhowcNC+GZ8eZiIlrMteROEUjhvdAck+mxtwHxEvvKBOBHMf2cajG1rxZozPNcGf8p7A==
X-Received: by 2002:a05:6a20:6a26:b0:251:a106:d96c with SMTP id adf61e73a8af0-2e7bf478c02mr20291385637.10.1759132022639;
        Mon, 29 Sep 2025 00:47:02 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238f11esm10430689b3a.19.2025.09.29.00.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 00:47:02 -0700 (PDT)
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
Subject: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining
Date: Mon, 29 Sep 2025 15:46:45 +0800
Message-Id: <20250929074645.416-1-ziqianlu@bytedance.com>
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

Debugging showed it happened like this:
Task group C is created and quota is set, so in tg_set_cfs_bandwidth(),
cfs_rq_c is initialized with runtime_enabled set, runtime_remaining
equals to 0 and *unthrottled*. Before any tasks are enqueued to cfs_rq_c,
*multiple* throttled tasks can migrate to cfs_rq_c (e.g., due to task
group changes). When enqueue_task_fair(cfs_rq_c, throttled_task) is
called and cfs_rq_c is in a throttled hierarchy (e.g., A is throttled),
these throttled tasks are placed into cfs_rq_c's limbo list by
enqueue_throttled_task().

Later, when A is unthrottled, tg_unthrottle_up(cfs_rq_c) enqueues these
tasks. The first enqueue triggers check_enqueue_throttle(), and with zero
runtime_remaining, cfs_rq_c can be throttled in throttle_cfs_rq() if it
can't get more runtime and enters tg_throttle_down(), where the warning
is hit due to remaining tasks in the limbo list.

Fix this by calling throttle_cfs_rq() in tg_set_cfs_bandwidth()
immediately after enabling bandwidth and setting runtime_remaining = 0.
This ensures cfs_rq_c is throttled upfront and cannot enter the enqueue
path in an unthrottled state with no runtime.

Also, update outdated comments in tg_throttle_down() since
unthrottle_cfs_rq() is no longer called with zero runtime_remaining.

While at it, remove a redundant assignment to se in tg_throttle_down().

Fixes: e1fad12dcb66("sched/fair: Switch to task based throttle model")
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/core.c  |  9 ++++++++-
 kernel/sched/fair.c  | 16 +++++++---------
 kernel/sched/sched.h |  1 +
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7f1e5cb94c536..421166d431fa7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9608,7 +9608,14 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 		cfs_rq->runtime_enabled = runtime_enabled;
 		cfs_rq->runtime_remaining = 0;
 
-		if (cfs_rq->throttled)
+		/*
+		 * Throttle cfs_rq now or it can be unthrottled with zero
+		 * runtime_remaining and gets throttled on its unthrottle path.
+		 */
+		if (cfs_rq->runtime_enabled && !cfs_rq->throttled)
+			throttle_cfs_rq(cfs_rq);
+
+		if (!cfs_rq->runtime_enabled && cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
 	}
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 22e6dd3af82fc..3ef11783369d7 100644
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
index b5367c514c143..359bb858cffd3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -558,6 +558,7 @@ extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth
 
 extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
 extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern bool throttle_cfs_rq(struct cfs_rq *cfs_rq);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 extern bool cfs_task_bw_constrained(struct task_struct *p);
 
-- 
2.39.5


