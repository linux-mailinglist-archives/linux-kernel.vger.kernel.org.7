Return-Path: <linux-kernel+bounces-821546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9A4B81994
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9555B58300C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C162FCBF3;
	Wed, 17 Sep 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="h6VbFdwn"
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5F772614
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136993; cv=none; b=dQ6bKw8YW07Tl6+fMbAZyVvsSevmttBTUQJLnBGG8Orhtv5Su2iK0Xj225jqSB1tmNCpVyW0NspHOBCg3WfxCOoMSWz9LZSC2UyQnLrNxYJPHTq/Ly1FF/iLdi3Y1fGBKAunBspX4mxhyie6Rxzg2HBQthk7xxg1ehv2BvLlgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136993; c=relaxed/simple;
	bh=JX9Ffh7Pf+hfk5UB6RHkGxi+gZ55byfAqIitgK2AQ28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKEJnv1Aqgkb7huPE9xRbL5GlkPNL1xETZaoAeIWWZMbriZfVY4ZAIF5zu1UCLKQZQwuni+QJZRMw67yRMYR7XenHBf8dXflj62WqZ4fNlVnmFtjW9lGp/7TiFbg277AkagublxNgJaQfRefP8lG9bv8JYoZV+SPdzRb1fsiW5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=h6VbFdwn; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758136992; x=1789672992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JX9Ffh7Pf+hfk5UB6RHkGxi+gZ55byfAqIitgK2AQ28=;
  b=h6VbFdwn7ru297hcyIMuz4+upuX6Gg0TVPKi1UL9IaaDpRQ81bSbPivx
   4d9TwQoSkWvegLzXRdxY8dEJ+PBH4LaP2/etcJSRQSekmLlA3TLMXDsYE
   puyqi+Z9ApFiA/nIGmU0SmAcdYBLvHAizWGuXZ5uYe5U8pCnWDuQ4ypIR
   HKjXUb8z+x7YWSfYcTl5q5+8YY6NI4xLndoors6Aw946JqkIrjvs5vLeK
   za8yRZdc7ojZSOxuIRSGEwdiWTldLTOFaf4aMNBXDhFRRv/uYSd2ZKzD2
   zY3rc76FzjgDx9p/YvewTd+Jdja93dV/O48WpFLBD/R6+V8tlcwVsOm6p
   Q==;
X-CSE-ConnectionGUID: CcJrk2DuSU2CcODOPrEeWg==
X-CSE-MsgGUID: f1CS0OuBT5eB7gjJjNsuuQ==
X-IronPort-AV: E=Sophos;i="6.18,272,1751241600"; 
   d="scan'208";a="2172547"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 19:23:01 +0000
Received: from EX19MTAEUA001.ant.amazon.com [54.240.197.233:4376]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.23.64:2525] with esmtp (Farcaster)
 id f3d28215-c9b9-4b1d-ac3e-07ff16a4cc00; Wed, 17 Sep 2025 19:23:01 +0000 (UTC)
X-Farcaster-Flow-ID: f3d28215-c9b9-4b1d-ac3e-07ff16a4cc00
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 19:22:53 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.227) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 17 Sep 2025 19:22:45 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <sieberf@amazon.com>, <bsegall@google.com>, <dietmar.eggemann@arm.com>,
	<dwmw@amazon.co.uk>, <graf@amazon.com>, <jschoenh@amazon.de>,
	<juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<tanghui20@huawei.com>, <vincent.guittot@linaro.org>,
	<vineethr@linux.ibm.com>, <wangtao554@huawei.com>, <zhangqiao22@huawei.com>
Subject: Re: [PATCH v2] sched/fair: Forfeit vruntime on yield
Date: Wed, 17 Sep 2025 21:22:05 +0200
Message-ID: <20250917192205.2306162-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916140228.452231-1-sieberf@amazon.com>
References: <20250916140228.452231-1-sieberf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Peter,

I noticed you have pulled the change in sched/urgent.
https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=78f8764d34c0a1912ce209bb2a428a94d062707f

However, I'd appreciate if you could weigh in on my concern regarding this
iteration not working well with core scheduling. Since the scheduler prefers to
run the yielding task again regardless of its eligibility rather than putting
the task in force idle, it can cause the yielding task vruntime to runaway
quickly. This scenario causes severe run delays later on. Please see my
previous reply with data supporting this concern. I think, the best approach to
address it would be to clamp vruntime. I'm not sure how exactly, a simple
approach would be to increment the vruntime by one slice until the task becomes
ineligible, if you have any suggestions let me know. I'll run some testing soon
when I get a chance.

Thanks, Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


