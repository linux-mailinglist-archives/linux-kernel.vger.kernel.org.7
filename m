Return-Path: <linux-kernel+bounces-809889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9833B51332
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB3517367E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1D53115B8;
	Wed, 10 Sep 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VOGutj54"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BE525A320
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497890; cv=none; b=ea5TwnVS3Cw3+xpdBwZb1jhyEiIz0siuap9VcAIXJs+iHxEo6Dt2g6JFvR9eCrQK0WYTm9JJS187OsrUui4XQmulXGorQlTXxUkMcKCD0WLVpjyh/rWR3XzF2jlZUATHO1EJVgBtaVNqk667CYEdbk4O+3ukmsQAPgWyxJl0kDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497890; c=relaxed/simple;
	bh=PPdJKbt+QhiatobW0HNneeEsuS7d4F+Tqh3a3V4pt/4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SA2r98ADt9T2WITjOBAYwrwJ2pB1/kZdvUXj/Yk1fNAcoDdLAYOMPTXx6wJicuyKpZvZiZbkbDFaBh2x9fHGunknHT5CPDnRvciBGht1Xb3A7m6O4o6YHNSU7RHrXx+FfJOoe48iHngd4Zu8teXzyK2ygUIQCgTgeJsenZBkjlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VOGutj54; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so3976657a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757497888; x=1758102688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN62zYWns9T3iEXjB0mMzeReZa6lZpakq/cZfsDQ4jU=;
        b=VOGutj54gh6sQCICTO8xC9AoHPJdhtxJp0h6C0XJU5VZa5FGNUGfGNOwBQJqdjB2Gz
         Wa2099nc+nN+z8pQKpFpmmJzDr1JM7pNleoxZge3/AOFnchS15VTwtAKDxo2r8tcStRb
         hTYzv05tHl0J3pRr+BLiXfhSXbLTPwgMloCjF/LFs8Zg5vYCZ/Tdkcb7g7Nk6y+7OQAi
         60blSxp0KUC2r+YWO5KQ0czGgxBVgKJgpIiVqxZzLjywTEhX/UnYFQ4iQ3irluEJRdD+
         UbEr+NMA+sJZbST2vLjCE8q778D/ihcDOl8SnSgVQuLc9uSPRqBSNidye5YnesDD2BNW
         Hjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497888; x=1758102688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN62zYWns9T3iEXjB0mMzeReZa6lZpakq/cZfsDQ4jU=;
        b=YHDXHFQUGv96YTxq7Xr0ScvppDudfC3dOy04NKpIib3AykJq3ExET9TOAG+dUcvR1T
         x1STZEB6UEJkDqxDcZ7HJMAG1lOLbXUyVKFDCMMc1iprN4am77wClG/vQr6m9h4WFXKx
         UilGPyZQW6KWDu6n0+qW5gUJAJlthWnn+5SBcuJYV+9VmwuqDp5dU3ANzi1l8v1/I0Tk
         8jHiDkyTuoWc6ILinnvmOVqZbVRx0drUP1hsrFzEIMInGCe4AuXnQttBeflIxRywWzi7
         yS7MDaToHG5X0C+E6nAey01EtSRDa09U1n1muEAqDxYmIEmnWpSMJClL5rQY487FDRig
         D9zg==
X-Gm-Message-State: AOJu0Yx6IVcatllMiP2tNdw16l87xp8ou+T2zW7Ugch5hxmL45+3VYtB
	0x83bNf83Vrd6sGRdPDdJ7nATKdINN9vJW6qCTCGQFEmYo3RMILVc2WH4ahGOqI6Nw==
X-Gm-Gg: ASbGncuueYQ2CZDV4Ve4n4EX2S2fS6QW13EbKJNhBQdKxDGC+0WMScS1IcigeOe4A4T
	Nl9wbjZXQJ6HdVa9KV8l4B7ByTvH76pHyi42nX2vWjDuva7mt9XWhSD0/yfre8KFnf3m1m6h36L
	NKc/hLCATdCorxTPnJBAocXtWh67on4kSOUACkRzRaVgyecORXY6PJ6uKuuFd8ZbMuNJL8V56Nx
	bxSqL1cVWQMxPNHaag6oIliUdMTsGxLEO1cm/+nHxGnQbF1DRst5lgKI3JLSHHyM5Pq32HcYNXI
	mc7LnDVrJ+8WtNlbK+Ts9QfrhoxtWQSuHvJVRRxKGn7TaIKw2Ko5k0SAf5CKgSkLEaLtBZg8/1z
	qNyybiVbIR4saMZVq/01x/DaoEdErvoXhJv8TCnuVYwdFejmu337QRdrO66R/VgTO31EAMVwPVy
	E/R9bqDWmmBfJal0khzE63
X-Google-Smtp-Source: AGHT+IGz+PRsKft1Xi0RyAaFtraod4QzmZBMZyBBJczolHAPHmi+z2xaTTuNMkiWdUulhNc1qSHVGA==
X-Received: by 2002:a05:6a20:1596:b0:24b:bae4:9c7f with SMTP id adf61e73a8af0-25341e68162mr21656234637.39.1757497887544;
        Wed, 10 Sep 2025 02:51:27 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b548b81f5acsm1850623a12.1.2025.09.10.02.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:51:27 -0700 (PDT)
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
Subject: [PATCH 3/4] sched/fair: Do not special case tasks in throttled hierarchy
Date: Wed, 10 Sep 2025 17:50:43 +0800
Message-Id: <20250910095044.278-4-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250910095044.278-1-ziqianlu@bytedance.com>
References: <20250910095044.278-1-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the introduction of task based throttle model, task in a throttled
hierarchy is allowed to continue to run till it gets throttled on its
ret2user path.

For this reason, remove those throttled_hierarchy() checks in the
following functions so that those tasks can get their turn as normal
tasks: dequeue_entities(), check_preempt_wakeup_fair() and
yield_to_task_fair().

The benefit of doing it this way is: if those tasks gets the chance to
run earlier and if they hold any kernel resources, they can release
those resources earlier. The downside is, if they don't hold any kernel
resouces, all they can do is to throttle themselves on their way back to
user space so the favor to let them run seems not that useful and for
check_preempt_wakeup_fair(), that favor may be bad for curr.

K Prateek Nayak pointed out prio_changed_fair() can send a throttled
task to check_preempt_wakeup_fair(), further tests showed the affinity
change path from move_queued_task() can also send a throttled task to
check_preempt_wakeup_fair(), that's why the check of task_is_throttled()
in that function.

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 58f5349d37256..3dbdfaa697477 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7081,7 +7081,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			 * Bias pick_next to pick a task from this cfs_rq, as
 			 * p is sleeping when it is within its sched_slice.
 			 */
-			if (task_sleep && se && !throttled_hierarchy(cfs_rq))
+			if (task_sleep && se)
 				set_next_buddy(se);
 			break;
 		}
@@ -8735,7 +8735,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 * lead to a throttle).  This both saves work and prevents false
 	 * next-buddy nomination below.
 	 */
-	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
+	if (task_is_throttled(p))
 		return;
 
 	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK) && !pse->sched_delayed) {
@@ -9009,8 +9009,8 @@ static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
 
-	/* throttled hierarchies are not runnable */
-	if (!se->on_rq || throttled_hierarchy(cfs_rq_of(se)))
+	/* !se->on_rq also covers throttled task */
+	if (!se->on_rq)
 		return false;
 
 	/* Tell the scheduler that we'd really like se to run next. */
-- 
2.39.5


