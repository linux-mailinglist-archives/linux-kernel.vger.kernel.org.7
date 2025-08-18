Return-Path: <linux-kernel+bounces-772718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 033F6B296C3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BDF7A89ED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF01124466C;
	Mon, 18 Aug 2025 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXWB7Ud1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF50173
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483106; cv=none; b=iOJ9YuvTt9rjyOGMnisiZV0Ga73rGAJLoCSsFYGZkUbyZK89f8DzzE2fT6YxfsmEPEMag4P4+1TzWor9bP2M9/9hBAAurXhag7jDWNI40dRDp3WCeScbQpV1e5XhvxmmNEru23Dt/MjkG+OeCVQZ5m9lndD60R8ZndtHCQmzbIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483106; c=relaxed/simple;
	bh=SenFREccRBQwuu5FcLoyKJL536sEWP4+IuB34wFrpwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7f7eUPb3Z6PO0tkZR3BkIKkpvwobTCjPVoNm3ZJCiU2yf8fwEZf8D4L1c0WUUtWG6JB2N8srzslTrVRUR1T12XhWj6ZNaFwtoAbiPGMlSxV1btENhBcSalPNd0xMqMKfv473not6VkHdLZERMsSNAokrRmI1vcOt/DBvBoCwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OXWB7Ud1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755483102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PvPEiL4l8R+WkwNrKmIb0X3D3X7fpJqzrNANmrqZWI=;
	b=OXWB7Ud17YoNnFb2vnrK9BABVS6YxB+0J6OkqPGWCuJXB612dzgCdFnjQEGtHOiCHx2hkM
	QccF5Vc0xAV4v2KBh8cm3QtB5vFAi84/qxrzz4tSard0q6jjlrMRuQ7u6tlyfgH4MGGUnS
	lqig1feWar4+LE+EAqVPkWiFUZ3upHQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-217-eOV7kcwiMBi0eXrB3VzXhg-1; Sun,
 17 Aug 2025 22:11:39 -0400
X-MC-Unique: eOV7kcwiMBi0eXrB3VzXhg-1
X-Mimecast-MFC-AGG-ID: eOV7kcwiMBi0eXrB3VzXhg_1755483098
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 383BE195608E;
	Mon, 18 Aug 2025 02:11:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.210])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EE9D719560AD;
	Mon, 18 Aug 2025 02:11:36 +0000 (UTC)
Date: Mon, 18 Aug 2025 10:11:32 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/8] mm/vmalloc: Support non-blocking GFP flags in
 alloc_vmap_area()
Message-ID: <aKKL1HFsJivaUSFE@MiWiFi-R3L-srv>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-4-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-4-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
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
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..81b6d3bde719 100644
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
> @@ -2026,7 +2027,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	if (unlikely(!vmap_initialized))
>  		return ERR_PTR(-EBUSY);
>  
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
> +		goto error;
> +	}
>  
>  	va->va_start = addr;
>  	va->va_end = addr + size;
> @@ -2116,6 +2126,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
>  				size, vstart, vend);
>  
> +error:
>  	kmem_cache_free(vmap_area_cachep, va);
>  	return ERR_PTR(-EBUSY);
>  }
> -- 
> 2.39.5
> 


