Return-Path: <linux-kernel+bounces-841258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32874BB6AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C68AF4ED1EF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741172F6599;
	Fri,  3 Oct 2025 12:22:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B272139CE
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759494164; cv=none; b=QGae2eYbkTLxECrW7ZSjm5F7M8Cd/e2O/8wsIKR1G1KI0o86+5qJjbur3MUR0BBSxwDbuxTXixjLQG2q2xuwxnKQ3QMv0tmi1PYtkmjyxoL0dnIC2XApJcQCoEk7YuKdSv7Mrs/0LJpKKINyGxH3NtLijC2I6AbAeXsDKYUhQ3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759494164; c=relaxed/simple;
	bh=UVLFTZdgFA1B5iQqYPJ9x6kXTRprmkD3UGuWtUPMr7s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bRxBBpQc6QVecjrhW1BhXWYXKkOCtU4AIKC/T89lwH0Q48Uq4IgNica/8C6IDd2Lmdxc0hTzDvVZGfv5Dpjzs85s0Of5rSjY1b10F8L8KTrYxnFygueqHo59Tn90J1sf+HXobQQsdiDBbHBxFr/yjlCsKmO1qdyEYNEmL61C7QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cdSQS4xR6z6K8Xc;
	Fri,  3 Oct 2025 20:19:28 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 07A4E140372;
	Fri,  3 Oct 2025 20:22:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 3 Oct
 2025 13:22:38 +0100
Date: Fri, 3 Oct 2025 13:22:36 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Bharata B Rao <bharata@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<dave.hansen@intel.com>, <gourry@gourry.net>, <hannes@cmpxchg.org>,
	<mgorman@techsingularity.net>, <mingo@redhat.com>, <peterz@infradead.org>,
	<raghavendra.kt@amd.com>, <riel@surriel.com>, <rientjes@google.com>,
	<sj@kernel.org>, <weixugc@google.com>, <willy@infradead.org>,
	<ying.huang@linux.alibaba.com>, <ziy@nvidia.com>, <dave@stgolabs.net>,
	<nifan.cxl@gmail.com>, <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>,
	<akpm@linux-foundation.org>, <david@redhat.com>, <byungchul@sk.com>,
	<kinseyho@google.com>, <joshua.hahnjy@gmail.com>, <yuanchu@google.com>,
	<balbirs@nvidia.com>, <alok.rathore@samsung.com>
Subject: Re: [RFC PATCH v2 5/8] x86: ibs: Enable IBS profiling for memory
 accesses
Message-ID: <20251003132236.00002ecd@huawei.com>
In-Reply-To: <20250910144653.212066-6-bharata@amd.com>
References: <20250910144653.212066-1-bharata@amd.com>
	<20250910144653.212066-6-bharata@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 10 Sep 2025 20:16:50 +0530
Bharata B Rao <bharata@amd.com> wrote:

> Enable IBS memory access data collection for user memory
> accesses by programming the required MSRs. The profiling
> is turned ON only for user mode execution and turned OFF
> for kernel mode execution. Profiling is explicitly disabled
> for NMI handler too.
> 
> TODOs:
> 
> - IBS sampling rate is kept fixed for now.
> - Arch/vendor separation/isolation of the code needs relook.
> 
> Signed-off-by: Bharata B Rao <bharata@amd.com>
One "oops I misread it" wrt to review of previous patch.
+ a really trivial thing.

J
> ---
>  arch/x86/include/asm/entry-common.h |  3 +++
>  arch/x86/include/asm/hardirq.h      |  2 ++
>  arch/x86/include/asm/ibs.h          |  2 ++
>  arch/x86/mm/ibs.c                   | 32 +++++++++++++++++++++++++++++
>  4 files changed, 39 insertions(+)

> diff --git a/arch/x86/mm/ibs.c b/arch/x86/mm/ibs.c
> index 6669710dd35b..3128e8fa5f39 100644
> --- a/arch/x86/mm/ibs.c
> +++ b/arch/x86/mm/ibs.c
> @@ -16,6 +16,7 @@ static u64 ibs_config __read_mostly;
>  static u32 ibs_caps;
>  
>  #define IBS_NR_SAMPLES	150
> +#define IBS_SAMPLE_PERIOD      10000
>  
>  /*
>   * Basic access info captured for each memory access.
> @@ -98,6 +99,36 @@ static void ibs_irq_handler(struct irq_work *i)
>  	schedule_work_on(smp_processor_id(), &ibs_work);
>  }
>  
> +void hw_access_profiling_stop(void)
> +{
> +	u64 ops_ctl;
> +
> +	if (!arch_hw_access_profiling)
> +		return;
> +
> +	rdmsrl(MSR_AMD64_IBSOPCTL, ops_ctl);
> +	wrmsrl(MSR_AMD64_IBSOPCTL, ops_ctl & ~IBS_OP_ENABLE);
> +}
> +
> +void hw_access_profiling_start(void)
> +{
> +	u64 config = 0;
> +	unsigned int period = IBS_SAMPLE_PERIOD;
> +
> +	if (!arch_hw_access_profiling)
> +		return;
> +
> +	/* Disable IBS for kernel thread */
> +	if (!current->mm)
> +		goto out;
> +
> +	config = (period >> 4)  & IBS_OP_MAX_CNT;

Bonus space though before & that can go.

> +	config |= (period & IBS_OP_MAX_CNT_EXT_MASK);
> +	config |= ibs_config;

Ah. Ignore comment in previous patch on this not being global. Clearly it needs
to be. Oops I misread this earlier.

> +out:
> +	wrmsrl(MSR_AMD64_IBSOPCTL, config);
> +}
> +
>  /*
>   * IBS NMI handler: Process the memory access info reported by IBS.
>   *
> @@ -304,6 +335,7 @@ static int __init ibs_access_profiling_init(void)
>  			  x86_amd_ibs_access_profile_startup,
>  			  x86_amd_ibs_access_profile_teardown);
>  
> +	arch_hw_access_profiling = true;
>  	pr_info("IBS setup for memory access profiling\n");
>  	return 0;
>  }


