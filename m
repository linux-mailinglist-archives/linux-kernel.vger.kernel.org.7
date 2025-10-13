Return-Path: <linux-kernel+bounces-850516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 413ACBD30F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 314DA4E1787
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416692737E1;
	Mon, 13 Oct 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cbxvzdiS"
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FF426E709
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359760; cv=none; b=ddFWBRokrLReGepOofEjSMH/PkqD8QeW3dflPnccD2glUY4xDPWfag3bFTO9ob2QnFX4YwvDttPQ5VxUH3gzM9P3aoIPhAVGbvWtPx5KZxKaAxg8rTIUMRssw+A4fYWWLyZyd6AiL0Jr4ScMwXRZGgBiZ1FZfsQr+Eqio2lRqqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359760; c=relaxed/simple;
	bh=QxvMcBP783QDIQ1gdc0hDsN7vSyynWYFvLRAPrrfmFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qvcPNszkdQTwGYxJMjebAamse7IOjJIPBZk9b7Q9UBC/3yAyJxsmjL8HdxL7jqn4guuaBcd9TnmQylSzfZNWIgTv2oWz3/GCe48B8HG9kynyY9Q0XrNUJSRvKPMSpo5FcbL9zEXFbqWHSTfMBVhSOPoSyWUbRzA0/T3t+0oud6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cbxvzdiS; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NPpxy6AvW2cQPybZQNUIFruqP5j+LHTJaagWB0GFvTc=;
	b=cbxvzdiSgDBBMJHt2rjFnoPvB9dq3BLBlVZCQeYHxJSMISjXQtz0bNyN0jZ3X2zSFNjrQySoN
	ixJgsZxi0noaF268+Do0VqUJKomNRq5bZdGihYlzXUKvBfO6hNVurYN8OoFHqCDarPCmI7fbF+O
	B0vREHECmdXAEXaJTUzq5gw=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4clcbh1Nrtz1prKv;
	Mon, 13 Oct 2025 20:48:48 +0800 (CST)
Received: from dggpemf100008.china.huawei.com (unknown [7.185.36.138])
	by mail.maildlp.com (Postfix) with ESMTPS id A88611800EB;
	Mon, 13 Oct 2025 20:49:07 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemf100008.china.huawei.com (7.185.36.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 20:49:06 +0800
Message-ID: <2740dc95-d6a4-4eaf-9ac0-651cad13e13a@huawei.com>
Date: Mon, 13 Oct 2025 20:49:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/hugetlb: create hstate_is_gigantic_no_runtime
 helper
To: Usama Arif <usamaarif642@gmail.com>, <muchun.song@linux.dev>,
	<osalvador@suse.de>, <david@redhat.com>, Andrew Morton
	<akpm@linux-foundation.org>
CC: <shakeel.butt@linux.dev>, <linux-mm@kvack.org>, <hannes@cmpxchg.org>,
	<riel@surriel.com>, <kas@kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel-team@meta.com>
References: <20251009172433.4158118-1-usamaarif642@gmail.com>
Content-Language: en-US
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20251009172433.4158118-1-usamaarif642@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf100008.china.huawei.com (7.185.36.138)



On 2025/10/10 1:24, Usama Arif wrote:
> This is a common condition used to skip operations that cannot
> be performed on gigantic pages when runtime support is disabled.
> This helper is introduced as the condition will exist even more
> when allowing "overcommit" of gigantic hugepages.
> No functional change intended with this patch.
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

> ---
>   mm/hugetlb.c | 21 ++++++++++++++++-----
>   1 file changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c07b7192aff26..e74e41386b100 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -134,6 +134,17 @@ static void hugetlb_free_folio(struct folio *folio)
>   	folio_put(folio);
>   }
>   
> +/*
> + * Check if the hstate represents gigantic pages but gigantic page
> + * runtime support is not available. This is a common condition used to
> + * skip operations that cannot be performed on gigantic pages when runtime
> + * support is disabled.
> + */
> +static inline bool hstate_is_gigantic_no_runtime(struct hstate *h)
> +{
> +	return hstate_is_gigantic(h) && !gigantic_page_runtime_supported();
> +}
> +
>   static inline bool subpool_is_free(struct hugepage_subpool *spool)
>   {
>   	if (spool->count)
> @@ -1555,7 +1566,7 @@ static void remove_hugetlb_folio(struct hstate *h, struct folio *folio,
>   	VM_BUG_ON_FOLIO(hugetlb_cgroup_from_folio_rsvd(folio), folio);
>   
>   	lockdep_assert_held(&hugetlb_lock);
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>   		return;
>   
>   	list_del(&folio->lru);
> @@ -1617,7 +1628,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
>   {
>   	bool clear_flag = folio_test_hugetlb_vmemmap_optimized(folio);
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>   		return;
>   
>   	/*
> @@ -2511,7 +2522,7 @@ static void return_unused_surplus_pages(struct hstate *h,
>   	/* Uncommit the reservation */
>   	h->resv_huge_pages -= unused_resv_pages;
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>   		goto out;
>   
>   	/*
> @@ -3725,7 +3736,7 @@ static void __init hugetlb_init_hstates(void)
>   		 * - If CMA allocation is possible, we can not demote
>   		 *   HUGETLB_PAGE_ORDER or smaller size pages.
>   		 */
> -		if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +		if (hstate_is_gigantic_no_runtime(h))
>   			continue;
>   		if (hugetlb_cma_total_size() && h->order <= HUGETLB_PAGE_ORDER)
>   			continue;
> @@ -4202,7 +4213,7 @@ static ssize_t __nr_hugepages_store_common(bool obey_mempolicy,
>   	int err;
>   	nodemask_t nodes_allowed, *n_mask;
>   
> -	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
> +	if (hstate_is_gigantic_no_runtime(h))
>   		return -EINVAL;
>   
>   	if (nid == NUMA_NO_NODE) {


