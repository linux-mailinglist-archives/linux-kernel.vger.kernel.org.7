Return-Path: <linux-kernel+bounces-818899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97740B597C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6990F4E75EA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788FF1E51FA;
	Tue, 16 Sep 2025 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="jb15ZYFa"
Received: from fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com [63.178.143.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28ED3164D9
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.178.143.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758029761; cv=none; b=cwTqRRtPKFoD+AXqfg+jgWu0EVZqw+zYgQdh98vFSlx6pEBYqG0oiZHI4Zp5wefdN7FwIRyDzl2avVST59xBryTFT1kh1JTxMiqfa2eVMPzTzvZkErJPTk/pVVUrwag4V7q+TOaseNQiDdoXpWlMRvhviDvsvKSzg0YWYr8K/AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758029761; c=relaxed/simple;
	bh=bUD/AkR9T2PUtEhbKhlKxU0utdtZABNk1JWWVDp/S8k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n/jcobZ1SwsBwTI2ryK3H7jEk04URAQkLCWtJItLmxSPQaIuF5ySfMx41JM7jxuXTrjvv4A9OezLTF8yye8f75JubXRqOYyRzC8fFkYvu80U0ag33vVFuovxGQoES/mMZhoWmf+8BijC13cOrPEl4ZeUPalSVWUHyLXLiCi4P08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=jb15ZYFa; arc=none smtp.client-ip=63.178.143.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1758029760; x=1789565760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=57Bd+wSbxPZ/drslpqLNIeKOK3XKX907coD9GIF7Fyk=;
  b=jb15ZYFadGDGg/lg/R3C9KpHPUl+Sm025h0voT6czzkFGc35Q//1NT4p
   OlgqOnvCaGdHRLbPWKdrcYjILtM8UKoAashJsZlJRHszs94sPwYQhoiK+
   hczpQx86iPTv+o7uCKkGDrTQUdOOCrcxhnoptkdsEalkBs7EkQiS5ZtMU
   yTJhBXyoohtAj8LXN1F80r8qTqA3ToJlycWqfZdcDWcuSDlSxNPN1OmmY
   CzvUnco1P5XjwfflQ/xM9ADrbHTT2e/uQT/yL+TCKg85JbSSt8X/IpCV7
   +P9VAPOa9AQ09XunjASMZ/Gqk4qH0F9vzIKGIdXbo/EqdJvRp5j13pi9w
   g==;
X-CSE-ConnectionGUID: E4mLI2TJQP2TLtgrWS5Z9g==
X-CSE-MsgGUID: z05VWDOiQRiZGvudMHtLYQ==
X-IronPort-AV: E=Sophos;i="6.18,269,1751241600"; 
   d="scan'208";a="2084586"
Received: from ip-10-6-3-216.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.3.216])
  by internal-fra-out-010.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2025 13:35:49 +0000
Received: from EX19MTAEUB002.ant.amazon.com [54.240.197.224:18082]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.21.238:2525] with esmtp (Farcaster)
 id ef26d34f-2666-46f1-8426-8b392356bc11; Tue, 16 Sep 2025 13:35:49 +0000 (UTC)
X-Farcaster-Flow-ID: ef26d34f-2666-46f1-8426-8b392356bc11
Received: from EX19D003EUB001.ant.amazon.com (10.252.51.97) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.79) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 13:35:48 +0000
Received: from u5934974a1cdd59.ant.amazon.com (10.146.13.225) by
 EX19D003EUB001.ant.amazon.com (10.252.51.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 16 Sep 2025 13:35:42 +0000
From: Fernand Sieber <sieberf@amazon.com>
To: <peterz@infradead.org>
CC: <bsegall@google.com>, <dietmar.eggemann@arm.com>, <graf@amazon.com>,
	<juri.lelli@redhat.com>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<sieberf@amazon.com>, <tanghui20@huawei.com>, <vincent.guittot@linaro.org>,
	<vineethr@linux.ibm.com>, <wangtao554@huawei.com>, <zhangqiao22@huawei.com>
Subject: Re: [PATCH RESEND] sched/fair: Only increment deadline once on yield
Date: Tue, 16 Sep 2025 15:35:20 +0200
Message-ID: <20250916133520.406318-1-sieberf@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911113746.GO4067720@noisy.programming.kicks-ass.net>
References: <20250911113746.GO4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D003EUB001.ant.amazon.com (10.252.51.97)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 11, 2025 at 01:37:46PM +0200, Peter Zijlstra wrote:
> Have you tried:
>
>       se->vruntime = se->deadline;
>       se->deadline += calc_delta_fair(se->slice, se);
>
> instead?

Thanks, that is better, see results below.
Forfeiting the vruntime allows competing tasks to make more progress.
Both approaches eliminate the problematic run delays.
I'll send out an updated version of the patch.

Repro:
taskset -c 1 yield_loop &
taskset -c 1 stress --cpu 1 --timeout 30s &

With yield loop:
int main() {
    time_t start = time(NULL);
    while (time(NULL) - start < 5) {
        sched_yield();
    }
    while (1) {}
    return 0;
}

Results (perf sched latency):
vanilla:
  stress:      2368ms runtime, max delay 25268ms (!)
  yield_loop: 27637ms runtime, max delay 2ms

deadline clamping:
  stress:      4629ms runtime, max delay 2ms
  yield_loop:  4632ms runtime, max delay 2ms

vruntime forfeiting:
  stress:      7117ms runtime, max delay 2ms
  yield_loop:  2144ms runtime, max delay 2ms



Amazon Development Centre (South Africa) (Proprietary) Limited
29 Gogosoa Street, Observatory, Cape Town, Western Cape, 7925, South Africa
Registration Number: 2004 / 034463 / 07


