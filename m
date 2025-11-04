Return-Path: <linux-kernel+bounces-885471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECE7C33009
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B113D3A48F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 21:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576262E92B3;
	Tue,  4 Nov 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="k5G6h3Yq"
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAED27E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762290337; cv=none; b=l+xeFgoDojhDx7rh3m8tPRwrYiI8bUGkz6XU2LlIKVygmsP5LQN7tz5U6j3RgbCMdj5zDIw5ZoblmULDtr6mfBtd6OZknXWBf1CF8aixK8hRqVLoYYgcu8JYViuRo7ZVKZponbOf9sMf2pEccj2EePmXVq/fx7dG0amJ0HYhiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762290337; c=relaxed/simple;
	bh=GH18lwwYtCKq866HjM9UdFupw9yNx9rOTZY1n71DgQ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaiN7WV/O2/W7GHqyuakAh8sCoEbo6VFdjeWubNbRosQYIBHQX+WxUrGZAy9eMCHfv5qpUGWSkWfkb8dqUE0zGSMEt8JL0lDy1BnEy8pI+gXJzd/hRL/zBhIpn+QuKAcEO5xBgyIDkzWfGkLLWvOsmxV7DlsnK7ZHfqZs+Y/dHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=k5G6h3Yq; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762290336; x=1793826336;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GBVtyKVdeWeCdJHd/Z3Byw+JnZ+6jxftwA94Z83YXP8=;
  b=k5G6h3YqxqH7oMm7h42Fcx9bu90JUdwChEk/RXjkLPoGmvMVw4fBjnGX
   6UPVOlAFXld9LVwCc/90vXPqPxFDu0kuPVBQkHAaJv0nbX707e6rJwKKe
   9MkxseUmhQyjeAt3hFEfDUYorf236QaU7c/fObNJiOHDAVsmCr9ZAxdiH
   e9lrA02a47y3bFF8sSJ+f27GvJHQ/ovOX7fq21SxnhBumRqLjn9i7saRT
   +fbZJfBduuWO0+aPAoRJHRvFx0NoqR2aEpd6TSIkn3lnK0GEclOxEz3xI
   UBE7sZTU0aAGgtv5JEFymc8jMMK7SKRpHWpdSjl1abcue03bDgSRkg5jX
   Q==;
X-CSE-ConnectionGUID: 33JROTSMR7u3ZKHb+J2ADA==
X-CSE-MsgGUID: uldWNatgQoCVaTWxi/4Hiw==
X-IronPort-AV: E=Sophos;i="6.19,280,1754956800"; 
   d="scan'208";a="4578549"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 21:05:18 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:21123]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.26.203:2525] with esmtp (Farcaster)
 id a34df2cf-195e-4b65-8eaa-ce12a1e249ce; Tue, 4 Nov 2025 21:05:18 +0000 (UTC)
X-Farcaster-Flow-ID: a34df2cf-195e-4b65-8eaa-ce12a1e249ce
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 4 Nov 2025 21:05:17 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.221) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Tue, 4 Nov 2025 21:05:13 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: kernel test robot <oliver.sang@intel.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>
Subject: Re: [tip:sched/core] [sched/fair] 79104becf4: BUG:kernel_NULL_pointer_dereference,address
Date: Tue, 4 Nov 2025 23:04:55 +0200
Message-ID: <20251104210456.652800-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202510211205.1e0f5223-lkp@intel.com>
References: <202510211205.1e0f5223-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

I spent some time today investigating this report. The crash happens when 
a proxy task yields.

Since it probably doesn't make sense that a task blocking the best pick 
yields, a simple workaround is to ignore the yield in this case:

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8993,6 +8993,11 @@ static void yield_task_fair(struct rq *rq)
 	if (unlikely(rq->nr_running == 1))
 		return;
 
+	/* Don't yield if we're running a proxy task */
+	if (rq->donor && rq->donor != curr) {
+		return;
+	}
+
 
However, more generally, I am not sure that the logic in update_min_vruntime() 
is sound when we are running a proxy task, which I suspect is the ultimate 
root cause of the problem. It seems to assume that cfs_rq->curr is the 
running task, which is not the case.

In my troubleshooting I have seen inconsistent calculations with underflows 
of cfs_rq->avg_vruntime and avg_vruntime(cfs_rq) being lower than 
min_vruntime. I'll see if I can invest more time diving into this, in the 
meantime do you have any thoughts?

Thanks,
--Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


