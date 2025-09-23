Return-Path: <linux-kernel+bounces-828710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A51CB9540F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5609E485106
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6B92F3C23;
	Tue, 23 Sep 2025 09:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="GG3ffdip"
Received: from fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com [3.64.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4AE2AD13
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.64.237.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619867; cv=none; b=ajg1VW3xmE/IPUDGAyAY0JHbxB+SF3zS7ZSdCrvYV7De+TuHHUaXRIOXMIsp2tXd7fZLZO+K46yZ47roZ4Xt9B9vrMOGNsqZGNWR0ZkdU+zy7QX9pCkcXa1stpVJfXTIAsLWMuwcKRHB6cG32aVhbm2DwwWI5mTfW4y3yVhw3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619867; c=relaxed/simple;
	bh=6CVDiZGbneDIBg7ydESwnYFddOUSkGMFy7QmurGQaVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=libprrf///9nmQGFUrgRmzujcV3WGOJRcP6jn3p8oe5eepppNl1JkEUEqTEXDBK5jOL6UGQvTPlCPk2gDQn9y/t5gTEm4JpeKNzSEOPOAOCSDTfI7PGFRCa2AJyFVKj6LYpGW03+Z1EB0tBHRprBvgKesrVBJ5DiEe5+ZadR5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=GG3ffdip; arc=none smtp.client-ip=3.64.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758619864; x=1790155864;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rUxApQS5pvIzoR+rejlEoF4fBpZbgtQZWl+zAH6eupw=;
  b=GG3ffdipR29vYAGCexFF2+h6lYIYzRsXkSzYfs1gCAhfzzHYBT2F0dYs
   4n13HysaJFig/mWt8KnwNGrC90aDMOXYHSgrxKm/FgrCB4JtpjlgmCqXX
   aCqkDE0LHOD1A19+m582VPKs/BZcpDK/m+BPqZWW0BEs0wDOk+AHr8jCj
   ZTnD9xOeVxPTyL8mnUrKTexCGDPZHqFk92nEiZCGAFoujWs/RzyZluQZ3
   hHmfnuxbM9ohPUnSRyJ9O1uqg2qPiEvJ0+oHf5G8tHIJeqXlZ5f2d/wZz
   1A+bFMRCB/tjikngF8nKqxfWC29hOhREaATPIAGisT28LEgwEhvkUqCM/
   A==;
X-CSE-ConnectionGUID: LDWS2kOtTOart8kfBAqyBQ==
X-CSE-MsgGUID: 2omzy+6rSTyhKif6wrqmuw==
X-IronPort-AV: E=Sophos;i="6.18,287,1751241600"; 
   d="scan'208";a="2431964"
Received: from ip-10-6-11-83.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.11.83])
  by internal-fra-out-009.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 09:30:53 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:25590]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.230:2525] with esmtp (Farcaster)
 id 54271866-6c4a-443e-8b89-6675b1b3b7db; Tue, 23 Sep 2025 09:30:53 +0000 (UTC)
X-Farcaster-Flow-ID: 54271866-6c4a-443e-8b89-6675b1b3b7db
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 09:30:52 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.223) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 23 Sep 2025 09:30:45 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>
CC: <mingo@redhat.com>, <peterz@infradead.org>,
	<linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <dwmw@amazon.co.uk>,
	<jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: Re: [PATCH 4/4] sched/fair: Add more core cookie check in wake up fast path
Date: Tue, 23 Sep 2025 11:30:00 +0200
Message-ID: <20250923093001.1218488-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <a1ff6b87-48a9-436a-9b62-8664d5207884@amd.com>
References: <cover.1758543008.git.sieberf@amazon.com> <a68bf0acdad9995fab15105cb26bd25f7d0edc8b.1758543008.git.sieberf@amazon.com> <a1ff6b87-48a9-436a-9b62-8664d5207884@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWA002.ant.amazon.com (10.13.139.39) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Prateek,

On 9/23/2025 2:25 PM, K Prateek Nayak wrote:
> So with Patch 1, you already check for cookie matching while entering
> select_idle_smt() and now, each pass of the loop again does a
> sched_core_cookie_match() which internally loops through the smt mask
> again! Seems wasteful.

Right. The change in select_idle_smt() is unnecessary.

> On an SMT-8 system, all the looping over smt mask per wakeup will add
> up. Is that not a concern? A single task with core cookie enabled will
> add massive overhead for all wakeup in the system.

In such a scenario there should generally be no looping because I introduced an
early return in patch 3 in __sched_core_cookie_match(). Perhaps it's worth
extracting this early return as standalone optimization patch? Something like
this:

@@ -1404,10 +1404,12 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
        if (!sched_core_enabled(rq))
                return true;

+       if (rq->core->core_cookie == p->core_cookie)
+               return true;
+
        for_each_cpu(cpu, cpu_smt_mask(cpu_of(rq))) {
                if (!available_idle_cpu(cpu)) {
-                       idle_core = false;
-                       break;
+                       return false;
                }
        }

@@ -1415,7 +1417,7 @@ static inline bool sched_core_cookie_match(struct rq *rq, struct task_struct *p)
         * A CPU in an idle core is always the best choice for tasks with
         * cookies.
         */
-       return idle_core || rq->core->core_cookie == p->core_cookie;
+       return true;
 }

Thanks,
Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


