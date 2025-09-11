Return-Path: <linux-kernel+bounces-811776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45890B52DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010603B952A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB4C2EA72E;
	Thu, 11 Sep 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="MONhIo4u"
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10EB329F13
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757584308; cv=none; b=YvQgkPlUlSZ9CMs+2t6KasalJfgKl78HaYuXY7I5Lk/j+azjH6GM49YmvRZiFP2VWzN/xyDgOWWFVOXpVINWB/4rHjMhsA04RAT0kp/SBihm2I8+1ZtTfbBgWv8ePMciIp5dxrQ279ODtzg3HSYO2aqMmr5q7L3QZ9SfMFjT+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757584308; c=relaxed/simple;
	bh=vGE34vZ7tTXTgRuBa4AKYODCx1IvUM/qzINGZUJlWNc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UjW0PKCVvUyyn2AYW0/ofSt/mysm/+0IvXFlKCISjXdH2th6NHPOAJ+uk/E8OegAYAli3Xzw0nb5+hPS/thOaeBoGb98ffyOG/cSlyUPJRRe6WA3EwU5uaAKFb7+ATV6sOBsSYZvhfFU8Jqfuwpu2McxwNl2g+g36X1Z2GRrPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=MONhIo4u; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1757584306; x=1789120306;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aN4sKFu+3H/cvsyd2ZVVfFw+YTO3cJvewqGcPyrLPKk=;
  b=MONhIo4uXNykub//No5vyEMK69dKuMipbLbszJejtamjETwIsH1r6l91
   lxjMe2+20e/36KuKe+36c5Sh7ug5WFNUKH1n7/uhdK9DOnVsTbTjsdzOx
   aC7HkIYMWuGQjcW+5OsVm8jlf+1n2huJjA6tP3ajemCGqRAn1SrdKYSP7
   XHqmM7NPMve2vLjlThnMX0YNvN5ggUNPhjq8OwN+yN1U8otIvf434fqp3
   fsb2qYTGZL8bGba2jQvkpZaK8bwMazIW/7DHTdY6s4D6EhutipFQ5VC2g
   BDZg0p/OEEspc4VkgXqnVE/gUY/xnYnGLYTRWzSNVLTbcNmOkmMWbPU5w
   g==;
X-CSE-ConnectionGUID: Fl8rjXu/RMqalwfh11Mk6Q==
X-CSE-MsgGUID: hNa1ooatTlaRTb2U+l+i4g==
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="1851702"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2025 09:51:37 +0000
Received: from EX19MTAEUC001.ant.amazon.com [54.240.197.225:2412]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.10.48:2525] with esmtp (Farcaster)
 id 4b35774f-7d6f-43c1-b697-56e787cc8a3c; Thu, 11 Sep 2025 09:51:36 +0000 (UTC)
X-Farcaster-Flow-ID: 4b35774f-7d6f-43c1-b697-56e787cc8a3c
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 09:51:36 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.110) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Thu, 11 Sep 2025 09:51:29 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <vincent.guittot@linaro.org>,
	<juri.lelli@redhat.com>
CC: <dietmar.eggemann@arm.com>, <bsegall@google.com>, <graf@amazon.com>,
	<wangtao554@huawei.com>, <tanghui20@huawei.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>, <nh-open-source@amazon.com>, "Madadi Vineeth
 Reddy" <vineethr@linux.ibm.com>
Subject: [PATCH RESEND] sched/fair: Only increment deadline once on yield
Date: Thu, 11 Sep 2025 11:51:13 +0200
Message-ID: <20250911095113.203439-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
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

Fix this by updating the deadline only to one slice ahead.

Note, we might want to consider iterating on the implementation of yield as
follow up:
* the yielding task could be forfeiting its remaining slice by
  incrementing its vruntime correspondingly
* in case of yield_to the yielding task could be donating its remaining
  slice to the target task

Fixes: 147f3efaa24182 ("sched/fair: Implement an EEVDF-like scheduling  policy")
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Signed-off-by: Fernand Sieber <sieberf@amazon.com>
Link: https://lore.kernel.org/r/20250401123622.584018-1-sieberf@amazon.com
---
Resending it with no code changes.
Adding "fixes" tag as per Alex's suggestion on thread.
Adding a few more scheduler folks.
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..d6a0d22d08d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8921,7 +8921,7 @@ static void yield_task_fair(struct rq *rq)
 	 */
 	rq_clock_skip_update(rq);

-	se->deadline += calc_delta_fair(se->slice, se);
+	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
 }

 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
--
2.43.0




Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


