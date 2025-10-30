Return-Path: <linux-kernel+bounces-877480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B51EC1E32F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA313402DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5AB24BBEE;
	Thu, 30 Oct 2025 03:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bqH9SAvQ"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF0822D792
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761794899; cv=none; b=iB262lpsohUX5vLsA0O0mOOU53ZR+uYPkCVviLqnYCbenwo966yCsIFit3ZktBHxMoOL7qNd5ASRFaPz1XNtg6PsBVV8YojVcR/IqcG0WoSNEliwPQ3wNvwCt3W+I80x8wkXeEwqOsiLTxAHWPvuGNriEDEi5glDGoClXo7WWjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761794899; c=relaxed/simple;
	bh=SkDWpYKu1nSOnKsbCTQKuFVAC2RnvnNp8vUYxn7+YxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G6Dxa44SLFcdyz/kgXgOEZAuQcLGVb3bkPhr5wsfnH2GTYFIpomiZpIo7yikQpP2sJ/64ehHGN+bfaRs+1zMA7VRvmW4TC47w2xEJ34MmNYCILCD8LSkqkoyzmIS7GZL+XQLleQplJTbGCahcoAGGzDQlcXM0mnaqnuIHsnmHpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bqH9SAvQ; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b6329b6e3b0so1447711a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1761794896; x=1762399696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nYlMPBv2BDKY22nRrXTeqvpEz+VH951iigjkXd5EgVU=;
        b=bqH9SAvQMe5Y48897t9WPf1SkfNY/YeoPjkdDkTL/p0QXvvjRSVfV1Op607hnkc1Vg
         zGZMjrn0g5Fej7cH1zHzwjAI69DPhhyQkz+N+paUYZ5Y1elT1KKuFfdV69hpRBX9jgUw
         duI0Ld5NredXZTbDnwH8GGRuxMuauLvTmCsYTcUCsEK7rptrSy6k2cguAlkY46RD5O+v
         Rl98+f7F9VYU40bQQqThipcQFo1uz53/HfBYJPhQb+EvuV9wXDX8hlo52yWvqaPGjuOl
         w/lBM/4KMchfMvD6sxYSpmCfy0ef/MLT1E9zc6J6v5GUPTAHSZ9O32COVn1i36tojK4g
         TX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761794896; x=1762399696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYlMPBv2BDKY22nRrXTeqvpEz+VH951iigjkXd5EgVU=;
        b=LHDsEul+PKiECa7YJ2IKZ+bhM8ExPx+jk1zeHuGzVgmpO3Bb80IZF6vBmqPIHIqc5i
         YmMntW5k8rNhL73EGCIYFHGw54yfVnF7w0XyOJGdH+P+GM6Jm7SKNcWiZV0QIqEkkJTd
         +yCSZw8mJdm5Abd9tf6BTQ9RcMPPFmfCp5H4jGQAsdxOfRV2d9Q19y973mXlp97BoYaA
         IFUKz8SBVgASSQILdfDfpsdfI+LH9Xi/VQYK5DZnNZdREgNMMpqZaBF9ymGFdPojUgSh
         q7djFEqQfELmlLnET2/1knturUUMp+TECtu6XuQcNosKfhphvyuuk7YrgAnDW00ub7sM
         fDbQ==
X-Gm-Message-State: AOJu0YzVamD+/O4Qtgufq67EVZ0e7i5J9xFtzOTd/XzE3oPAZcXm3js5
	eEdZSrS16Ij7AYs7ZeSBFPkVcvmHeTLXvyAjabflcj+i5I/uWFozD821SXXIzpR+hg==
X-Gm-Gg: ASbGncuuZnMY0o8hux6TMHxmYmZ7++3cSxtcqsDprfVUw1aoCjxG8zshbXalAZ5EyT1
	A7EYojjPTsBCyUvYdRGQa2OkmQIznjRmqjRHk3XcI/hy8ffEuG3yhfkPePLVh5MEL1wiu5aC8y1
	Pb1P+sJS6sYcQymcYSW1SDQ8HLAJ0hxpL8PB9Ifcxa50/0GRX6ZHUPV1kLuhburMFwK89AOueRR
	EmjvVMVJbInTEDmalAt3+SvO06p5arsLlje4j4h6D/VyQhrVZAV4rcVPW9eo4ThxpEo4NT5nCBw
	vvpykLRmDISyk+AS5CDK24GI0al5O2m7Zq6FtYxEDYPO3/0hDaUhnyRAuu0JVJYxUnOMEYIWJu+
	m/xighk6vnnKLXW2Z8QDWRnlbUGPeKgIc+/+9/qMqFu7ZAOLxWKoJbDJEgA3eogABOge9DIrYtd
	hpCg+i4l9NZijWdCz6C+D1DOjbZkKBNWgltd9c9OREwpy1hQ==
X-Google-Smtp-Source: AGHT+IFxGfHymDeRABDvSKaTcY7w23hP63TOF9MD98gnGy89jyB7ISq33O9vHsmh1XiG3yHlGeWm3Q==
X-Received: by 2002:a17:903:247:b0:266:57f7:25f5 with SMTP id d9443c01a7336-294ed098015mr19072475ad.7.1761794895852;
        Wed, 29 Oct 2025 20:28:15 -0700 (PDT)
Received: from 5CG4011XCS-JQI.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d47ffesm171501755ad.87.2025.10.29.20.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:28:15 -0700 (PDT)
From: Aaron Lu <ziqianlu@bytedance.com>
To: Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Hao Jia <jiahao.kernel@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
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
Subject: [PATCH v3] sched/fair: Prevent cfs_rq from being unthrottled with zero runtime_remaining
Date: Thu, 30 Oct 2025 11:27:55 +0800
Message-ID: <20251030032755.560-1-ziqianlu@bytedance.com>
X-Mailer: git-send-email 2.47.3
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
of a being unthrottled cfs_rq can be in a mixed state in the end, so fix
this by granting 1ns to cfs_rq in tg_set_cfs_bandwidth(). This ensures
cfs_rq_c has a positive runtime_remaining when initialized as unthrottled
and cannot enter tg_unthrottle_up() with zero runtime_remaining.

Also, update outdated comments in tg_throttle_down() since
unthrottle_cfs_rq() is no longer called with zero runtime_remaining.
While at it, remove a redundant assignment to se in tg_throttle_down().

Fixes: e1fad12dcb66 ("sched/fair: Switch to task based throttle model")
Suggested-by: Benjamin Segall <bsegall@google.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
v3: grant cfs_rq 1ns runtime on quota set as suggested by Ben, thanks!

 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 15 ++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f1ebf67b48e21..f754a60de8484 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9606,7 +9606,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg,
 
 		guard(rq_lock_irq)(rq);
 		cfs_rq->runtime_enabled = runtime_enabled;
-		cfs_rq->runtime_remaining = 0;
+		cfs_rq->runtime_remaining = 1;
 
 		if (cfs_rq->throttled)
 			unthrottle_cfs_rq(cfs_rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb2795..5b752324270b0 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6024,20 +6024,17 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct sched_entity *se = cfs_rq->tg->se[cpu_of(rq)];
 
 	/*
-	 * It's possible we are called with !runtime_remaining due to things
-	 * like user changed quota setting(see tg_set_cfs_bandwidth()) or async
-	 * unthrottled us with a positive runtime_remaining but other still
-	 * running entities consumed those runtime before we reached here.
+	 * It's possible we are called with runtime_remaining < 0 due to things
+	 * like async unthrottled us with a positive runtime_remaining but other
+	 * still running entities consumed those runtime before we reached here.
 	 *
-	 * Anyway, we can't unthrottle this cfs_rq without any runtime remaining
-	 * because any enqueue in tg_unthrottle_up() will immediately trigger a
-	 * throttle, which is not supposed to happen on unthrottle path.
+	 * We can't unthrottle this cfs_rq without any runtime remaining because
+	 * any enqueue in tg_unthrottle_up() will immediately trigger a throttle,
+	 * which is not supposed to happen on unthrottle path.
 	 */
 	if (cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0)
 		return;
 
-	se = cfs_rq->tg->se[cpu_of(rq)];
-
 	cfs_rq->throttled = 0;
 
 	update_rq_clock(rq);
-- 
2.39.5


