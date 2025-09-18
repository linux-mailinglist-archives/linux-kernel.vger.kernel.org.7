Return-Path: <linux-kernel+bounces-821957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54723B82B15
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09ABC62191F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8123C4F1;
	Thu, 18 Sep 2025 02:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdwlPeqV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D350922D7A1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164207; cv=none; b=mMDSMn+1gVqnw6uuB3+kYX5a6gLw4624BsD+VLhdLCDj3/wJt8N/1PCQ6D339DQkaoR7ytcNCwO6Re1G4xToIdopH6rGxYMzUGlQgbUHWZ8HvwZ5HuUKxu8S9DXmvSBt7jtL+8q/C1MamGHgFiVgOQD5XohyE1RdKAzlVXpcwk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164207; c=relaxed/simple;
	bh=+EMiM4llLdOoJeufXmSX/4wSF3vMrKuTktW/zGv56CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kx/jWJZzo9ZwYN+mTJNBDb8yw9H1Zbpjob9nH+JpoaTECqna9vDpL4gy3rpFsrXAr92XYGbpXtn1Uagt03GZIUV2gg6U4TguEZzq6Bkh5/5FQFck62F2W4iKFx+tsJTgxNTamT1P8BkpiyZyQD+FJQg69lRLiNBG15aoh7g6aH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdwlPeqV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758164204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=G+LtIQpgc290vPRQOhAQlDUbtf58jv7H8SakHmLcEEA=;
	b=CdwlPeqV9DVNzYZw0Y9JI3AJb2IxzGaYpr+DaZlpcORLHJilVOyut+Za1zFWN9GRdcjVah
	FRMi6QaFdBVa1pI7ptGqlglRYeJNYoQwh9dcQeM2WHt5gP9UdV7jmA8fWwaNZx3sY/exXt
	YQlGKLr0wWxX71+TH0QsmsUZJtm36uA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-ZFTlBNNGPc-z9rkq6G2ROA-1; Wed,
 17 Sep 2025 22:56:42 -0400
X-MC-Unique: ZFTlBNNGPc-z9rkq6G2ROA-1
X-Mimecast-MFC-AGG-ID: ZFTlBNNGPc-z9rkq6G2ROA_1758164200
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 694F2180034C;
	Thu, 18 Sep 2025 02:56:40 +0000 (UTC)
Received: from localhost (unknown [10.72.112.180])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4C4E61800446;
	Thu, 18 Sep 2025 02:56:38 +0000 (UTC)
Date: Thu, 18 Sep 2025 10:56:35 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 03/10] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aMt045ZaEma6qokF@MiWiFi-R3L-srv>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-4-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-4-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/15/25 at 03:40pm, Uladzislau Rezki (Sony) wrote:
> alloc_vmap_area() currently assumes that sleeping is allowed during
> allocation. This is not true for callers which pass non-blocking
> GFP flags, such as GFP_ATOMIC or GFP_NOWAIT.
> 
> This patch adds logic to detect whether the given gfp_mask permits
> blocking. It avoids invoking might_sleep() or falling back to reclaim
> path if blocking is not allowed.
> 
> This makes alloc_vmap_area() safer for use in non-sleeping contexts,
> where previously it could hit unexpected sleeps, trigger warnings.
> 
> It is a preparation and adjustment step to later allow both GFP_ATOMIC
> and GFP_NOWAIT allocations in this series.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5edd536ba9d2..49a0f81930a8 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2017,6 +2017,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	unsigned long freed;
>  	unsigned long addr;
>  	unsigned int vn_id;
> +	bool allow_block;
>  	int purged = 0;
>  	int ret;
>  
> @@ -2028,7 +2029,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  	/* Only reclaim behaviour flags are relevant. */
>  	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> -	might_sleep();
> +	allow_block = gfpflags_allow_blocking(gfp_mask);
> +	might_sleep_if(allow_block);
>  
>  	/*
>  	 * If a VA is obtained from a global heap(if it fails here)
> @@ -2065,8 +2067,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	 * If an allocation fails, the error value is
>  	 * returned. Therefore trigger the overflow path.
>  	 */
> -	if (IS_ERR_VALUE(addr))
> -		goto overflow;
> +	if (IS_ERR_VALUE(addr)) {
> +		if (allow_block)
> +			goto overflow;
> +
> +		/*
> +		 * We can not trigger any reclaim logic because
> +		 * sleeping is not allowed, thus fail an allocation.
> +		 */
> +		goto out_free_va;
> +	}
>  
>  	va->va_start = addr;
>  	va->va_end = addr + size;
> @@ -2116,6 +2126,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
>  				size, vstart, vend);
>  
> +out_free_va:
>  	kmem_cache_free(vmap_area_cachep, va);
>  	return ERR_PTR(-EBUSY);
>  }
> -- 
> 2.47.3
> 


