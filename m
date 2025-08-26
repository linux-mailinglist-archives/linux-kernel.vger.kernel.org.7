Return-Path: <linux-kernel+bounces-785882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43BB35225
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F5F74E369F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25222279795;
	Tue, 26 Aug 2025 03:17:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A77F1E5201
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756178223; cv=none; b=nMGGQm+4D6mZymezIDdYnHPIWpo85v2+V2dZMxoRuTPJ7YGSeiiyqAhvVhqsOa1IpLwxXupZqRL14RIhotbeWXPa0GogfPe/33/9+iHmqAA1e0GQ6zkPMU1+1bhvDAP2TI1PgkDi/WlIiJaJtq4rGfFwGYBVHW/PuEDiLaTViC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756178223; c=relaxed/simple;
	bh=GAyM1LoajksuZparup3o+5P64P9FAbX1KRZY//y2WbA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qqQmv93QEamtLp5QTwMwHnOGrrV1Pbg0VLTQqp9ZitEkVqw5A1GHlPoeisZWAo/ZBxSKQNEIHREh/bpNC1v6Oh+elKgg5hk4Wzc7uL1C5j1KtNb6psQsNE9zFr53NBG7HQtYOQn2GtA1X3Vw5qBrq0Unb+1sxKibeKGuZ1Tr3UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4c9t6f3GlDz1R998;
	Tue, 26 Aug 2025 11:14:02 +0800 (CST)
Received: from dggpemf200018.china.huawei.com (unknown [7.185.36.31])
	by mail.maildlp.com (Postfix) with ESMTPS id 23ED1140278;
	Tue, 26 Aug 2025 11:16:58 +0800 (CST)
Received: from [10.174.176.250] (10.174.176.250) by
 dggpemf200018.china.huawei.com (7.185.36.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 26 Aug 2025 11:16:57 +0800
Message-ID: <7de69c95-bbf7-4dd0-91e9-640da8b8cd5c@huawei.com>
Date: Tue, 26 Aug 2025 11:16:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] mm/damon/paddr: support addr_unit for
 DAMOS_PAGEOUT
To: SeongJae Park <sj@kernel.org>
CC: <akpm@linux-foundation.org>, <damon@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<wangkefeng.wang@huawei.com>, <zuoze1@huawei.com>, <kernel-team@meta.com>,
	kernel test robot <lkp@intel.com>
References: <20250825151205.36288-1-sj@kernel.org>
From: Quanmin Yan <yanquanmin1@huawei.com>
In-Reply-To: <20250825151205.36288-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200018.china.huawei.com (7.185.36.31)


在 2025/8/25 23:12, SeongJae Park 写道:
> On Fri, 22 Aug 2025 17:34:11 +0800 Quanmin Yan <yanquanmin1@huawei.com> wrote:
>
>> From: SeongJae Park <sj@kernel.org>
>>
>> Add support of addr_unit for DAMOS_PAGEOUT action handling from the
>> DAMOS operation implementation for the physical address space.
> [...]
>> -	return applied * PAGE_SIZE;
>> +	return applied * PAGE_SIZE / addr_unit;
>>   }
> Kernel test robot [1] found this can cause __udivdi3 linking issue.  Andrew,
> could you please add the below attached fixup?
>
> [1] https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
>
>
> Thanks,
> SJ
>
> [...]
>
> ==== Attachment 0 (0001-mm-damon-paddr-use-do_div-on-i386-for-damon_pa_pageo.patch) ====
>  From hackermail Thu Jan  1 00:00:00 1970
> From: SeongJae Park <sj@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: damon@lists.linux.dev
> Cc: kernel-team@meta.com
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Date: Mon, 25 Aug 2025 07:41:33 -0700
> Subject: [PATCH 1/3] mm/damon/paddr: use do_div() on i386 for damon_pa_pageout()
>           return value
>
> Otherwise, __udidi3 linking problem happens on certain configs.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508241831.EKwdwXZL-lkp@intel.com/
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>   mm/damon/paddr.c | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 5fad2f9a99a0..09c87583af6c 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -135,6 +135,18 @@ static bool damon_pa_invalid_damos_folio(struct folio *folio, struct damos *s)
>   	return false;
>   }
>   
> +/* convert physical address to core-layer address */
> +static unsigned long damon_pa_core_addr(phys_addr_t pa,
> +		unsigned long addr_unit)
> +{
> +#ifdef __i386__

Can we use the following condition instead?

#if !defined(CONFIG_64BIT) && defined(CONFIG_PHYS_ADDR_T_64BIT)

Thanks,
Quanmin Yan

> +	do_div(pa, addr_unit);
> +	return pa;
> +#else
> +	return pa / addr_unit;
> +#endif
> +}
> +
>   static unsigned long damon_pa_pageout(struct damon_region *r,
>   		unsigned long addr_unit, struct damos *s,
>   		unsigned long *sz_filter_passed)
> @@ -190,7 +202,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
>   	applied = reclaim_pages(&folio_list);
>   	cond_resched();
>   	s->last_applied = folio;
> -	return applied * PAGE_SIZE / addr_unit;
> +	return damon_pa_core_addr(applied * PAGE_SIZE, addr_unit);
>   }
>   
>   static inline unsigned long damon_pa_mark_accessed_or_deactivate(

