Return-Path: <linux-kernel+bounces-688049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC89ADAD00
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 12:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9CE7AA4EE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A182264BC;
	Mon, 16 Jun 2025 10:05:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908F27F001
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750068342; cv=none; b=QtWrujQzfkbV8MG5GRJgNA9LMbUt28P8PQe3/rj6x3KOxQDjr+CUudrEoEyK5JQKd7JCYdCAvqYgMdtjMu9nHUcSuOlO3uNrGk31fmHNuaIwXmim5OwhCeOhXv6hsFMWSgUw1/glkE5INMNndLjb/R7F8lEdNjS441pQ/8VLwKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750068342; c=relaxed/simple;
	bh=K5ZyQ77aDKtscOMkjMS4b1nCdU/hnoiOTCcV27+ejFI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KKxfZY1xH/JXaoai1aRJckh4EFx3jaDLbjzPHTEjzCj5xxdXsv+My3SO3d6IhO59i61EnYUkvFtZtX2hKg/VNzDebOEewNHPBeQObMfoTy97LhyjtVC0knucML2Bbzt/Pv1LFWCmzNo/4jXhpLupNMlEFcxbiA1xRDW4uPnocF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bLQW308QJz6L5fj;
	Mon, 16 Jun 2025 18:01:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 68C94140157;
	Mon, 16 Jun 2025 18:05:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 16 Jun
 2025 12:05:35 +0200
Date: Mon, 16 Jun 2025 11:05:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Qinxin Xia <xiaqinxin@huawei.com>
CC: <21cnbao@gmail.com>, <m.szyprowski@samsung.com>, <robin.murphy@arm.com>,
	<yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [RESEND PATCH v4 2/4] dma-mapping: benchmark: modify the
 framework to adapt to more map modes
Message-ID: <20250616110534.000022b0@huawei.com>
In-Reply-To: <20250614143454.2927363-3-xiaqinxin@huawei.com>
References: <20250614143454.2927363-1-xiaqinxin@huawei.com>
	<20250614143454.2927363-3-xiaqinxin@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sat, 14 Jun 2025 22:34:52 +0800
Qinxin Xia <xiaqinxin@huawei.com> wrote:

> In some service scenarios, the performance of dma_map_sg needs to be
> tested to support different map modes for benchmarks. This patch adjusts
> the DMA map benchmark framework to make the DMA map benchmark framework
> more flexible and adaptable to other mapping modes in the future.
> By abstracting the framework into four interfaces:prepare, unprepare,
> do_map, and do_unmap.The new map schema can be introduced more easily
> without major modifications to the existing code structure.
> 
> Reviewed-by: Barry Song <baohua@kernel.org>
> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>

There is what looks like an accidental change in behavior for loops
after the first one.  I think the cache lines will end up clean so
any flush will be just dropping them.  Prior to this patch they
were probably dirty.

Jonathan

>  #endif /* _KERNEL_DMA_BENCHMARK_H */
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index cc19a3efea89..05f85cf00c35 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -5,6 +5,7 @@

> +static void *dma_single_map_benchmark_prepare(struct map_benchmark_data *map)
> +{
> +	struct dma_single_map_param *params __free(kfree) = kzalloc(sizeof(*params),
> +								    GFP_KERNEL);
Trivial: I'd split this slightly differently.

	struct dma_single_map_param *params __free(kfree) =
		kzalloc(sizeof(*params), GFP_KERNEL);


> +}

> +
> +static int dma_single_map_benchmark_do_map(void *mparam)
> +{
> +	struct dma_single_map_param *params = mparam;
> +	int ret = 0;
> +
> +	params->addr = dma_map_single(params->dev, params->xbuf,
> +				      params->npages * PAGE_SIZE, params->dma_dir);
> +	if (unlikely(dma_mapping_error(params->dev, params->addr))) {
> +		pr_err("dma_map_single failed on %s\n", dev_name(params->dev));

dev_err() seems more appropriate than passing in the dev to a pr_err.

> +		ret = -ENOMEM;
		return -ENOMEM;
Or better still don't assume the error return of dma_mapping_error()
(even though it is currently only -ENOMEM)

> +	}
> +
	return 0;


would be neater and avoid need for the local variable.
If you add stuff here later in the series then fine to ignore this comment.


> +	return ret;
> +}

>  static int map_benchmark_thread(void *data)
>  {
> -	void *buf;
> -	dma_addr_t dma_addr;
>  	struct map_benchmark_data *map = data;
> -	int npages = map->bparam.granule;
> -	u64 size = npages * PAGE_SIZE;
> +	__u8 map_mode = map->bparam.map_mode;
>  	int ret = 0;
>  
> -	buf = alloc_pages_exact(size, GFP_KERNEL);
> -	if (!buf)
> +	struct map_benchmark_ops *mb_ops = dma_map_benchmark_ops[map_mode];
> +	void *mparam = mb_ops->prepare(map);
> +
> +	if (!mparam)
>  		return -ENOMEM;
>  
>  	while (!kthread_should_stop())  {
> @@ -49,23 +132,10 @@ static int map_benchmark_thread(void *data)
>  		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
>  		ktime_t map_delta, unmap_delta;
>  
> -		/*
> -		 * for a non-coherent device, if we don't stain them in the
> -		 * cache, this will give an underestimate of the real-world
> -		 * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
> -		 * 66 means evertything goes well! 66 is lucky.
> -		 */
> -		if (map->dir != DMA_FROM_DEVICE)
> -			memset(buf, 0x66, size);

This seems to change the behavior form memset every time to only once
in the prepare call above.  If that has no affect on what is being benchmarked,
then add a comment on it to the patch description.


> -
>  		map_stime = ktime_get();
> -		dma_addr = dma_map_single(map->dev, buf, size, map->dir);
> -		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> -			pr_err("dma_map_single failed on %s\n",
> -				dev_name(map->dev));
> -			ret = -ENOMEM;
> +		ret = mb_ops->do_map(mparam);
> +		if (ret)
>  			goto out;
> -		}
>  		map_etime = ktime_get();
>  		map_delta = ktime_sub(map_etime, map_stime);
>  
> @@ -73,7 +143,8 @@ static int map_benchmark_thread(void *data)
>  		ndelay(map->bparam.dma_trans_ns);
>  
>  		unmap_stime = ktime_get();
> -		dma_unmap_single(map->dev, dma_addr, size, map->dir);
> +		mb_ops->do_unmap(mparam);
> +
>  		unmap_etime = ktime_get();
>  		unmap_delta = ktime_sub(unmap_etime, unmap_stime);
>  
> @@ -108,7 +179,7 @@ static int map_benchmark_thread(void *data)
>  	}
>  
>  out:
> -	free_pages_exact(buf, size);
> +	mb_ops->unprepare(mparam);
>  	return ret;
>  }


