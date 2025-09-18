Return-Path: <linux-kernel+bounces-823076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79101B8578B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F2F5801D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D425B22A4F8;
	Thu, 18 Sep 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="N/ylL9vB"
Received: from fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com [18.197.217.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCC460B8A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.197.217.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758207971; cv=none; b=PvET1eLa8T7v9OmJn2msD38eDYiGSghA01mgbnid8Bl2ZWlSjTEi6XcBZw9IYDpRg1UofQtdfmjxQBvsyx/io6tICW660tGlxnnVKTdZfRs+JYXbavhhTg5DRMN5vAFLzl/MTjGhPVTK/0wTBklSUH3NpqzfaoWHFXi9CWtcgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758207971; c=relaxed/simple;
	bh=jRY3s7R2/dFoTTa33wY5pCHRFzF4xmrhuhFuvBXXO1Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5jHvAJ8y97/cHyi5IgkXS562W1ombOoVri19qQuCpTko1HFEuQPNmI/lVWdh6ZzrapYwNC6e6yFigHn+neCOxHwxsScbkglfnB14lljj4iSWBdo4Le/JSd7ix7hAsNt8geZx34q3HW5GO6iOQTNqZN6h7y6+opp9lfAPd/VdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=N/ylL9vB; arc=none smtp.client-ip=18.197.217.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758207969; x=1789743969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VzhdDxALGRKx/BdjlWmEb6uqVGMeAwn6O+mNTwJ3zXM=;
  b=N/ylL9vBAp4ZZxholgSeFlFLHIn9ODFfoWhcEpe0/2bl323OxRUpincs
   J2PLx0cvqKSDEIHgeBsUhsz3rCK6Qx4DBgX/eJIn5EcYKG0gzLWr39tLD
   ExIhPCdLZAN+O94jgAUNV7mDWiP+W0750Wb/cCeTa4EDu41mLWsDBM7YN
   44GxQmA6y6qLKxZ8agKy1VWBYYFx7Yj4UKfN9y83gtYG5PNa41r5Uu+ba
   XGF36HXKYcDbxjt3Nsjouwm7utAGIS8WL6q2tj/Z0fL8i/+2dd5LCfqIE
   v6/GmYH0p0zmk/7qFTvVJGeTTHbCBcAJQFe/cdvdH/MhoRwKA1sD1qSM8
   Q==;
X-CSE-ConnectionGUID: l8J6YDMfS52h8Vsro374OA==
X-CSE-MsgGUID: ZA5qf1+1RcqCI8wu1w4KVg==
X-IronPort-AV: E=Sophos;i="6.18,275,1751241600"; 
   d="scan'208";a="2330931"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-006.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 15:05:58 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.232:2328]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.64:2525] with esmtp (Farcaster)
 id 8871dd8e-47b0-4fde-9b1a-ed9dcc1b5470; Thu, 18 Sep 2025 15:05:58 +0000 (UTC)
X-Farcaster-Flow-ID: 8871dd8e-47b0-4fde-9b1a-ed9dcc1b5470
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 18 Sep 2025 15:05:58 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.226) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 18 Sep 2025 15:05:50 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <dwmw@amazon.co.uk>,
	<graf@amazon.com>, <jschoenh@amazon.de>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>, <sieberf@amazon.com>,
	<tanghui20@huawei.com>, <vincent.guittot@linaro.org>,
	<vineethr@linux.ibm.com>, <wangtao554@huawei.com>, <zhangqiao22@huawei.com>
Subject: [PATCH v3] sched/fair: Forfeit vruntime on yield
Date: Thu, 18 Sep 2025 17:05:28 +0200
Message-ID: <20250918150528.292620-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250918102159.GH1386988@noisy.programming.kicks-ass.net>
References: <20250918102159.GH1386988@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
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

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  policy")
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
Signed-off-by: Fernand Sieber <sieberf@amazon.com>

Changes in v2:
- Implement vruntime forfeiting approach suggested by Peter Zijlstra
- Updated commit name
- Previous Reviewed-by tags removed due to algorithm change

Changes in v3:
- Only increase vruntime for eligible tasks to avoid runaway vruntime with
  core scheduling

Link: https://lore.kernel.org/r/20250916140228.452231-1-sieberf@amazon.com
---
 kernel/sched/fair.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..46e5a976f402 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8921,7 +8921,19 @@ static void yield_task_fair(struct rq *rq)
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
+		se->vruntime = se->deadline;
+		se->deadline += calc_delta_fair(se->slice, se);
+		update_min_vruntime(cfs_rq);
+	}
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
-- 
2.34.1




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


