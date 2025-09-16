Return-Path: <linux-kernel+bounces-818962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11C7B598F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DAD1C0376C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B685F335BAF;
	Tue, 16 Sep 2025 14:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SuXOcAbL"
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3717B505
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758031386; cv=none; b=aEyeDKuiqelViO4FWx8VZ5L7ERo8pxPLwqnCDHiYU9dZ23C/QkZ9VAWLwKQKhOpr+9ZzvnhV66mB09RHWAMIyDY7P8+JsRAaAUzNudWgmrfjYJke3CQ5RtztgqDwKPCucn3CvwjNCsWIHBRiQ/BMDYactXB2LhK5fQskDc5LICk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758031386; c=relaxed/simple;
	bh=jGx/Yw223g22/u19/WDb3LAhoaall0qC9TKyMGM8Gv0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIaHiHmb9rW4XPAybcJvaHTGL0mIJ+DPYKNjxSC9vPe0cmMCTgZtm7WslggRW9DfuQIUQbhpQesP+/QvhM/H7E3FyN1snakBPVQN5c94v41wFgVbJqx+S1kxfj1x0cellvfsaaMUEW+xUOdn4aTC9B9ri5ANRz+gSAPycghfjeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SuXOcAbL; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758031384; x=1789567384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yXWJn+oefsllBzSrWFdG2E5Pn0uf2RzuWYH2maZwKuo=;
  b=SuXOcAbL6UxlQwl8WCgGnQQ/7JZSRpt0j3Q2Y6jX1e1pPoJ+11HX9MEF
   Rlxk/ZnAZWh0qGqsbfnaOjYYaUK8QQyH0LpB74RyNrq6PqggSo5dEeOYZ
   VKspLKt+Xr5VFMbZ7T68Be8ORYcyIwR/Ew1QcMer6yz3OZwAgAVBzusz+
   wB4V/LDkJRUQRWguJcArr9ToWur1oteDt1/SWDRiciUv7h0GeMnxVciQ6
   tOkrzM268J81WWuy20aQUeZy5GK2DcHVHqzFfxYhKRyUMAgrlDQppJ3rz
   o1oS91BTr4zxlt5XdzkLiVzJTQqdUnOTKxUBbCz1ofAp+W8cdLzaE7l7X
   g==;
X-CSE-ConnectionGUID: u1Wy0rsxTS20oyEQLrs05Q==
X-CSE-MsgGUID: qLEzx/aERB2Tapzm9dqbKA==
X-IronPort-AV: E=Sophos;i="6.18,269,1751241600"; 
   d="scan'208";a="2092820"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 14:02:53 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:14199]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.0.240:2525] with esmtp (Farcaster)
 id d22f9d81-188b-4362-acd2-884bd29253a8; Tue, 16 Sep 2025 14:02:53 +0000 (UTC)
X-Farcaster-Flow-ID: d22f9d81-188b-4362-acd2-884bd29253a8
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 14:02:51 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.108) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 14:02:44 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <mingo@redhat.com>, <vincent.guittot@linaro.org>, <juri.lelli@redhat.com>,
	<dietmar.eggemann@arm.com>, <bsegall@google.com>, <graf@amazon.com>,
	<jschoenh@amazon.de>, <dwmw@amazon.co.uk>, <wangtao554@huawei.com>,
	<tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>, <vineethr@linux.ibm.com>
Subject: [PATCH v2] sched/fair: Forfeit vruntime on yield
Date: Tue, 16 Sep 2025 16:02:28 +0200
Message-ID: <20250916140228.452231-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911095113.203439-1-sieberf@amazon.com>
References: <20250911095113.203439-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
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

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  policy")
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
Link: https://lore.kernel.org/r/20250911095113.203439-1-sieberf@amazon.com
Signed-off-by: Fernand Sieber <sieberf@amazon.com>

Changes in v2:
- Implement vruntime forfeiting approach suggested by Peter Zijlstra
- Updated commit name
- Previous Reviewed-by tags removed due to algorithm change
---
 kernel/sched/fair.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7a14da5396fb..cc4ef7213d43 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9036,6 +9036,7 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);

+	se->vruntime = se->deadline;
 	se->deadline += calc_delta_fair(se->slice, se);
 }

--
2.34.1




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


