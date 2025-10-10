Return-Path: <linux-kernel+bounces-848263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52DBCD0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 15:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F8E1A65A94
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 13:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DABB2F0C63;
	Fri, 10 Oct 2025 13:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Sw73Tyjl"
Received: from fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com (fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com [52.57.120.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C11F1538
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.57.120.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760101809; cv=none; b=LfpToOocpQ6ZAWbNUOPKxw1PKzZ+UXksVa05sHAIjTGfFT6ERi4WeNK7m6jelbITGCmr7tCzCIoCzIKu/myFWo9Tc3zkzVe3a9oDBkiCUsRrQmQNRn8vjXicUFVxa2IW+tSEDShNNBlXOuZlOG2caZNrDUCTaYTudHCUEM5VhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760101809; c=relaxed/simple;
	bh=LyTR9DtGywm23FUElXyBYi6OMxaV/1yL2eK31ENS4s0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4hzKicFSdakJpXNu9Ey8YwEwbP8/Aad2XRZezvvVwbKXVTALVcN8YhlEcPqT1zw279t3ihomjV3UDFHaemIjKLduUF6JkUZpauIbcZl1ENZq/gvBzdyj2IikSr9FD88PbeOuXToXDHcJnnKb7obRaRdUITVBsW0bP8gfAB9kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Sw73Tyjl; arc=none smtp.client-ip=52.57.120.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1760101808; x=1791637808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QSXdhuJElvACKoDk9jjk+dDHt2vVcqmKZsYu2gcSkyY=;
  b=Sw73Tyjl4sroglkUfsfya4M2nR2gYX7rnySIN9wz7qb0DNHQhRtaIDiL
   qx/ruQR9sZwnW++WgNyiQEJRbUygyycTrqSJ9kQVI8yK1DYDHlbGTR0mf
   koz3Q7HQjgxzn19mnx4FQg5lou6RJzvJn8W5f5UcQpWSVK34OhMqCL1RK
   LghChD2yziICbnprHSfgsPegpY3H7H3RWYD2Esz6OAdA1qxVLbdVNTPRh
   spUA3WclkHj55MPjP5tbtlA7ZKhR1yGVZaTlsaXWtcMV7vhLcT0W5yoje
   VkY2Bqf8Tah2l+H29HTcztCOsJf/9zN4GTpBvNVtAwwTBurdCXUCTzXI/
   Q==;
X-CSE-ConnectionGUID: RmYK/vrnRmOMiAlUxTUluw==
X-CSE-MsgGUID: /TWQkBlYQ1KHZqPjEdb4kw==
X-IronPort-AV: E=Sophos;i="6.19,219,1754956800"; 
   d="scan'208";a="3314556"
Received: from ip-10-6-6-97.eu-central-1.compute.internal (HELO smtpout.naws.eu-central-1.prod.farcaster.email.amazon.dev) ([10.6.6.97])
  by internal-fra-out-012.esa.eu-central-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 13:09:52 +0000
Received: from EX19MTAEUB001.ant.amazon.com [54.240.197.226:4083]
 by smtpin.naws.eu-central-1.prod.farcaster.email.amazon.dev [10.0.44.161:2525] with esmtp (Farcaster)
 id 3b800073-49ab-47e2-a2fb-f0357c5bdc55; Fri, 10 Oct 2025 13:09:52 +0000 (UTC)
X-Farcaster-Flow-ID: 3b800073-49ab-47e2-a2fb-f0357c5bdc55
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Fri, 10 Oct 2025 13:09:50 +0000
Received: from dev-dsk-abuehaze-1c-21d23c85.eu-west-1.amazon.com
 (10.13.244.41) by EX19D018EUA004.ant.amazon.com (10.252.50.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.2562.20; Fri, 10 Oct 2025 13:09:45 +0000
From: Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>
To: <clm@meta.com>
CC: <bsegall@google.com>, <clm@fb.com>, <dietmar.eggemann@arm.com>,
	<joseph.salisbury@oracle.com>, <juri.lelli@redhat.com>,
	<linux-kernel@vger.kernel.org>, <mgorman@suse.de>, <mingo@redhat.com>,
	<peterz@infradead.org>, <rostedt@goodmis.org>, <vincent.guittot@linaro.org>,
	<vschneid@redhat.com>, <abuehaze@amazon.com>, <cpru@amazon.com>
Subject: Re: [REGRESSION][v6.17-rc1]sched/fair: Bump sd->max_newidle_lb_cost when newidle balance fails
Date: Fri, 10 Oct 2025 13:09:32 +0000
Message-ID: <20251010130932.14768-1-abuehaze@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
References: <28340138-a00e-47bc-a36f-270a01ac83b4@meta.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB003.ant.amazon.com (10.13.139.135) To
 EX19D018EUA004.ant.amazon.com (10.252.50.85)

>> Hi Chris,
>> 
>> During testing, we are seeing a ~6% performance regression with the 
>> upstream stable v6.12.43 kernel (And Oracle UEK 
>> 6.12.0-104.43.4.el9uek.x86_64 kernel) when running the Phoronix 
>> pts/apache benchmark with 100 concurrent requests [0].  The regression 
>> is seen with the following hardware:
>> 
>> PROCESSOR: Intel Xeon Platinum 8167M Core Count: 8 Thread Count: 16 
>> Extensions: SSE 4.2 + AVX512CD + AVX2 + AVX + RDRAND + FSGSBASE Cache 
>> Size: 16 MB Microcode: 0x1 Core Family: Cascade Lake
>> 
>> After performing a bisect, we found that the performance regression was 
>> introduced by the following commit:
>> 
>> Stable v6.12.43: fc4289233e4b ("sched/fair: Bump sd->max_newidle_lb_cost 
>> when newidle balance fails")
>> Mainline v6.17-rc1: 155213a2aed4 ("sched/fair: Bump 
>> sd->max_newidle_lb_cost when newidle balance fails")
>> 
>> Reverting this commit causes the performance regression to not exist.
>> 
>> I was hoping to get your feedback, since you are the patch author.  Do 
>> you think gathering any additional data will help diagnose this issue?

> Hi everyone,

> Peter, we've had a collection of regression reports based on this
> change, so it sounds like we need to make it less aggressive, or maybe
> we need to make the degrading of the cost number more aggressive?

> Joe (and everyone else who has hit this), can I talk you into trying the
> drgn from
> https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.com/

> I'm curious if it degrades at all or just gets stuck up high.

Hi All,

We are also seeing 20-30% performance regression on Database workloads
specifically Cassandra & Mongodb across multiple hardware platforms. We
have seen the regression on v6.1.149 & v6.12.43 and we were able to
bisect the regression to 155213a2aed4 ("sched/fair: Bump 
> sd->max_newidle_lb_cost when newidle balance fails"). 

We were able to reproduce this regression on below AWS instance types:

- c7a.4xlarge (16 4th generation AMD EPYC processors + 32 GiB RAM)
- c7i.4xlarge (16 4th Generation Intel Xeon Scalable processors + 32GiB RAM)
- c7g.4xlarge (16 AWS Arm based Graviton3 processors + 32 GiB RAM)
- c8g.4xlarge (16 AWS Arm based Graviton4 processors + 32 GiB RAM)

We will try drgn from
https://lore.kernel.org/lkml/2fbf24bc-e895-40de-9ff6-5c18b74b4300@meta.com/
 and will let you know the results. Meanwhile and given the significant
impact, Should we revert this commit on latest mainline & on impacted stable 
branches to stop the bleeding until we have a permanent fix?

Thank you.

Hazem

