Return-Path: <linux-kernel+bounces-889953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85194C3EE7B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 318044EAB4B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F296630FC20;
	Fri,  7 Nov 2025 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="WCrHPElf"
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA1830F938
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762503218; cv=none; b=iNJ4PRSE+NSmfktc2PPI93sWgKAXCgjIRyTNbFkqk3QEBXniuFeKC6hjR705B4NFFPB2aGYK3PntwosDiA/YXEBJwMh4z6bxQod2QSuIWLJFUMBMt9/YGuBUSVd+gFnDiZuqYTPKZ5AWhW2Zd7xQpbRpi7CTI+eEXXCopDQi+nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762503218; c=relaxed/simple;
	bh=4drWl5oVKFuHl+xuGskNxzBylciVz8x2T3SKUA2S0FE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=INlWIWavQkXobVltUFjDN0C9/kE4dLMH421aNVDJ2V/GsMKrBCgTYJLtG6Dyv7GSbOrYE299w1teUYqBLkanYgYkkf+O0GumNXwOD19ztu0Rfjj8ByG3mmM5eRTRuBvBqOKYADhZEC/BrPrSaQ6oM6KhJSKZn5kAZBwqldhsfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=WCrHPElf; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1762503216; x=1794039216;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6t2bOWhqRFGRHDboXfRasxJuQqR5SKfxvlginqnwOjY=;
  b=WCrHPElfccFih/Fum/tCuo4mnsP7MZLfkZqVOVeUhYK27ak1oep6vXtT
   dEOqcVo9LN1yF37CazmH3RV9bsa/cBcwLjCBFvyByZ5Mf1/DEsq3KSE6x
   690xDhRiyUxCMex/7r83ZQGjswriAkNllukow15uVYUjsE3u3pM2zUJ+D
   h9Vu3LjTInCC2X1pWYQpHDei66pOA4u5Bd2mPiSqA/hYNWgxDetJE6B6R
   X9ODfcennc4NkRK+xsdBsGHpsd1RakxS70AJfCJBmdYLfpvjiaXGIsqQ7
   yBYdX/loRDYZ5LQ6iGHP/4aZC2etZ4tnluFngv8jIz3PxY9obUskaPQLt
   w==;
X-CSE-ConnectionGUID: f6dI5ghBR+asn7PzWqp2kg==
X-CSE-MsgGUID: jh4Yrn5OT0SwgNQA4jDeYA==
X-IronPort-AV: E=Sophos;i="6.19,286,1754956800"; 
   d="scan'208";a="4714418"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2025 08:13:18 +0000
Received: from EX19MTAEUA002.ant.amazon.com [54.240.197.232:11665]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.18.231:2525] with esmtp (Farcaster)
 id a18729ee-b55f-4e0f-9a07-b1edd40c21df; Fri, 7 Nov 2025 08:13:18 +0000 (UTC)
X-Farcaster-Flow-ID: a18729ee-b55f-4e0f-9a07-b1edd40c21df
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 08:13:17 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.223) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Fri, 7 Nov 2025 08:13:10 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: kernel test robot <lkp@intel.com>, <mingo@redhat.com>,
	<peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<dwmw@amazon.co.uk>, <jschoenh@amazon.de>, <liuyuxua@amazon.com>
Subject: Re: [PATCH] sched: Proxy yields to donor tasks
Date: Fri, 7 Nov 2025 10:12:53 +0200
Message-ID: <20251107081254.110947-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202511071431.9PLsHNo5-lkp@intel.com>
References: <20251106104022.195157-1-sieberf@amazon.com> <202511071431.9PLsHNo5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Nov 07, 2025 at 02:31:16PM +0800, kernel test robot wrote:
> sparse warnings: (new ones prefixed by >>)
>
>>> kernel/sched/rt.c:529:55: sparse: warning: incorrect type in initializer (different address spaces)
>>> kernel/sched/rt.c:976:39: sparse: warning: incorrect type in initializer (different address spaces)

Thank you for the report.

The warnings occur because my patch changes scheduler yield functions from
accessing rq->curr to rq->donor, both of which have identical __rcu annotations.
These are pre-existing annotation issues in the scheduler code, which has been
directly accessing RCU-annotated pointers without proper dereferencing, relying
on runqueue lock protection instead.

If we do want to address these sparse warnings, I can make modifications like:

-               curr = rq->donor;
+               curr = rcu_dereference_protected(rq->donor, lockdep_is_held(&rq->__lock));

This would have zero runtime overhead while satisfying sparse's RCU checking.

Peter, let me know if these warnings should be addressed.

Thanks,
Fernand



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


