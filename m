Return-Path: <linux-kernel+bounces-886120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BADEC34BCA
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 10:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2848034CA19
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 09:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A1230C35C;
	Wed,  5 Nov 2025 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="igi/fcA2"
Received: from fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.132.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B5302CCD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 09:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.132.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334131; cv=none; b=c3ZBpSGjGu4F1LW//p67yKkAVqE4r3tiwU/22tuLXH2XdKgbT7U9ZzvlKc2bJ3ezk73XWj4Mc25oCIIAjmmknfxYGgd6Gsx2vBj/mlFpehjucjTUMAVEdPBZr6KPhcmnhuCmKNHBaYZe/lhqUUmskURkzhQbyfpmv5v3E2yAuWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334131; c=relaxed/simple;
	bh=+4wjSNsGsraben5B6RgCiIrIJmfwiTepmm7RTMQE78s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ndm5VdFIyPK/GBtlfqHXuNzQ2XwcRtzNNL4223PfMWvgIfubw+6yREiVdcsE29fibOzfPre/XAtK2GDaet2Pe2cauS0jDx3z7STIM8FEPv/ES6ZHYWaepxoMOs/HGwFTKA1SvMRYViKu52QWwYDYH1KTnoKf8A7SrKvZv9lWSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=igi/fcA2; arc=none smtp.client-ip=63.178.132.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762334129; x=1793870129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n4sbWJpGvn2fw9EQ1+WoQbXpN5F4CUL+hpYXN7zaJXs=;
  b=igi/fcA2x9ZlN3/putAdknLjv7Mw3MJdFVrCBpr7LTjjlJo0nEIUYVbZ
   lYfvd5BH0B+yMxfKpZxCmXNp8C55qN104yzw/hAKHiah1T6GnFD1hgLJV
   3MFrbevULHFLQ/iZQjx36EKs8Li2YHUt1ob6mqGpBdArvuICFP2VFdYey
   BN1nloIOzgbjRK5BlPbkSnoNG/WRG2bR8sdRUGhZWJnMVjFR0FWnyVETn
   Y9iaREQcZkqxaHgYosakdOPscx8k3r/IipwDzcR+fBRKEZc5ab1XB5RbO
   hho5nqk/hqTlswE2TV+q9VeCuXaqW0ZN6jEWB1rvC2S6lT11Sw8W8YZUd
   w==;
X-CSE-ConnectionGUID: ubPYmedJQcG5AHEDfkk1KA==
X-CSE-MsgGUID: I8IL4iQ5Sd2ptaexGhq0QQ==
X-IronPort-AV: E=Sophos;i="6.19,281,1754956800"; 
   d="scan'208";a="4593339"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-013.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 09:15:10 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:19815]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.30:2525] with esmtp (Farcaster)
 id 6d8bd803-b198-468e-9dfc-86aa1889e214; Wed, 5 Nov 2025 09:15:10 +0000 (UTC)
X-Farcaster-Flow-ID: 6d8bd803-b198-468e-9dfc-86aa1889e214
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 09:15:09 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.223) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Wed, 5 Nov 2025 09:15:02 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <dwmw@amazon.co.uk>,
	<graf@amazon.com>, <jschoenh@amazon.de>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <sieberf@amazon.com>,
	<tanghui20@huawei.com>, <vincent.guittot@linaro.org>,
	<vineethr@linux.ibm.com>, <wangtao554@huawei.com>, <zhangqiao22@huawei.com>
Subject: [PATCH v4] sched/fair: Forfeit vruntime on yield
Date: Wed, 5 Nov 2025 11:13:52 +0200
Message-ID: <20251105091355.206240-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918150528.292620-1-sieberf@amazon.com>
References: <20250918150528.292620-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If a task yields, the scheduler may decide to pick it again. The task in
turn may decide to yield immediately or shortly after, leading to a tight
loop of yields.

If there's another runnable task as this point, the deadline will be
increased by the slice at each loop. This can cause the deadline to runaway
pretty quickly, and subsequent elevated run delays later on as the task
doesn't get picked again. The reason the scheduler can pick the same task
again and again despite its deadline increasing is because it may be the
only eligible task at that point.

Fix this by making the task forfeiting its remaining vruntime and pushing
the deadline one slice ahead. This implements yield behavior more
authentically.

We limit the forfeiting to eligible tasks. This is because core scheduling
prefers running ineligible tasks rather than force idling. As such, without
the condition, we can end up on a yield loop which makes the vruntime
increase rapidly, leading to anomalous run delays later down the line.

Fixes: 147f3efaa241 ("sched/fair: Implement an EEVDF-like scheduling policy")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250916140228.452231-1-sieberf@amazon.com
Signed-off-by: Fernand Sieber <sieberf@amazon.com>

Changes in v2:
- Implement vruntime forfeiting approach suggested by Peter Zijlstra
- Updated commit name
- Previous Reviewed-by tags removed due to algorithm change

Changes in v3:
- Only increase vruntime for eligible tasks to avoid runaway vruntime with
  core scheduling

Changes in v4:
- Handle proxy tasks by dequeuing/enqueuing entities when modifying vruntime
  to maintain RB-tree consistency

Link: https://lore.kernel.org/r/20250916140228.452231-1-sieberf@amazon.com
---
 kernel/sched/fair.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25970dbbb279..dd68605cb8af 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8993,9 +8993,10 @@ static void put_prev_task_fair(struct rq *rq, struct task_struct *prev, struct t
  */
 static void yield_task_fair(struct rq *rq)
 {
-	struct task_struct *curr = rq->curr;
-	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	struct sched_entity *se = &curr->se;
+	struct task_struct *rq_curr = rq->curr;
+	struct cfs_rq *cfs_rq = task_cfs_rq(rq_curr);
+	struct sched_entity *se = &rq_curr->se;
+	bool curr = cfs_rq->curr == se;
 
 	/*
 	 * Are we the only task in the tree?
@@ -9017,7 +9018,23 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);
 
-	se->deadline += calc_delta_fair(se->slice, se);
+	/*
+	 * Forfeit the remaining vruntime, only if the entity is eligible. This
+	 * condition is necessary because in core scheduling we prefer to run
+	 * ineligible tasks rather than force idling. If this happens we may
+	 * end up in a loop where the core scheduler picks the yielding task,
+	 * which yields immediately again; without the condition the vruntime
+	 * ends up quickly running away.
+	 */
+	if (entity_eligible(cfs_rq, se)) {
+		if (!curr)
+			__dequeue_entity(cfs_rq, se);
+		se->vruntime = se->deadline;
+		se->deadline += calc_delta_fair(se->slice, se);
+		if (!curr)
+			__enqueue_entity(cfs_rq, se);
+		update_min_vruntime(cfs_rq);
+	}
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
-- 
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


