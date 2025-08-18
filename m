Return-Path: <linux-kernel+bounces-772838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5B7B29837
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5EE4E6B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AF82627F9;
	Mon, 18 Aug 2025 04:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+XAX+S2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F276125F97C
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755491732; cv=none; b=LiY79LQtPEsRzL6gd7GTxvaaBi1UZf11Qcnm/9gQBPmUiq9KSPgg4gJl7lVOm00s6lYeZDlUUKAr2FFu3399WGVr4cgV69mEnVe4z6CqDLTXjzvITTiblIC1JTNZtHS/7CUNJpJAhz1Q4rAszUsE6JSWvhmubIQbG8oSoZzxAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755491732; c=relaxed/simple;
	bh=KciFTpXuSAsZ+o3vOeWfNg+7MtMXBhNG2HcImimrGhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njkvGauD+SsPup8f3yBgig4koGweO43DsCCAk3aoKcqqvg2hxyFDU2/akGuI3VYNHY7xD9hJYFLzHpdT7dFf2N8AZuyAaUekCCGLMMGrVxDwDaC9pYNeTijeR5VXVD1VhYdiCh0K+kfl2Z4R2Trj8U58IpSHWx90OeI6qxzXHHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L+XAX+S2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755491729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Qr7GKeY7iraK1JMYtgr9HkjBsEWy/WVlfeLC9I+VeY=;
	b=L+XAX+S2yXZVoa3TLfoFEtgcaP60x9BTNwKgCRpipfQRJr9W/L80fcUk+d8VRK/evLIU1u
	Ym98UowIZveuzAx86WE4OsrG3R3q3nizu6RZ3XFD5gwbALElqL+CM0cz6MeqJYImLl/jGt
	EFffsjVudBRQZZJWtd1Ybd+EpBqz9EE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-oewtGDdxN-6hnhgvIdtzNQ-1; Mon,
 18 Aug 2025 00:35:24 -0400
X-MC-Unique: oewtGDdxN-6hnhgvIdtzNQ-1
X-Mimecast-MFC-AGG-ID: oewtGDdxN-6hnhgvIdtzNQ_1755491723
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4EB9C1800289;
	Mon, 18 Aug 2025 04:35:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.210])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08347180047F;
	Mon, 18 Aug 2025 04:35:21 +0000 (UTC)
Date: Mon, 18 Aug 2025 12:35:16 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] mm/vmalloc: Support non-blocking GFP flags in
 __vmalloc_area_node()
Message-ID: <aKKthIZbD4oNywY4@MiWiFi-R3L-srv>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-8-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-8-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
> This patch makes __vmalloc_area_node() to correctly handle non-blocking
> allocation requests, such as GFP_ATOMIC and GFP_NOWAIT. Main changes:
> 
> - Add a __GFP_HIGHMEM to gfp_mask only for blocking requests
>   if there are no DMA constraints.
> 
> - vmap_page_range() is wrapped by memalloc_noreclaim_save/restore()
>   to avoid memory reclaim related operations that could sleep during
>   page table setup or mapping pages.
> 
> This is particularly important for page table allocations that
> internally use GFP_PGTABLE_KERNEL, which may sleep unless such
> scope restrictions are applied. For example:
> 
> <snip>
> __pte_alloc_kernel()
>     pte_alloc_one_kernel(&init_mm);
>         pagetable_alloc_noprof(GFP_PGTABLE_KERNEL & ~__GFP_HIGHMEM, 0);
> <snip>
> 
> Note: in most cases, PTE entries are established only up to the level
> required by current vmap space usage, meaning the page tables are typically
> fully populated during the mapping process.
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  mm/vmalloc.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 2424f80d524a..8a7eab810561 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3721,12 +3721,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	unsigned int nr_small_pages = size >> PAGE_SHIFT;
>  	unsigned int page_order;
>  	unsigned int flags;
> +	bool noblock;
>  	int ret;
>  
>  	array_size = (unsigned long)nr_small_pages * sizeof(struct page *);
> +	noblock = !gfpflags_allow_blocking(gfp_mask);
>  
> -	if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> -		gfp_mask |= __GFP_HIGHMEM;
> +	if (noblock) {
> +		/* __GFP_NOFAIL and "noblock" flags are mutually exclusive. */
> +		nofail = false;
> +	} else {
> +		/* Allow highmem allocations if there are no DMA constraints. */
> +		if (!(gfp_mask & (GFP_DMA | GFP_DMA32)))
> +			gfp_mask |= __GFP_HIGHMEM;
> +	}
>  
>  	/* Please note that the recursion is strictly bounded. */
>  	if (array_size > PAGE_SIZE) {
> @@ -3790,7 +3798,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	 * page tables allocations ignore external gfp mask, enforce it
>  	 * by the scope API
>  	 */
> -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +	if (noblock)
> +		flags = memalloc_noreclaim_save();
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		flags = memalloc_nofs_save();
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		flags = memalloc_noio_save();
> @@ -3802,7 +3812,9 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  			schedule_timeout_uninterruptible(1);
>  	} while (nofail && (ret < 0));
>  
> -	if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
> +	if (noblock)
> +		memalloc_noreclaim_restore(flags);
> +	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == __GFP_IO)
>  		memalloc_nofs_restore(flags);
>  	else if ((gfp_mask & (__GFP_FS | __GFP_IO)) == 0)
>  		memalloc_noio_restore(flags);

Can we use memalloc_flags_restore(flags) directly to replace above if
else checking? It can reduce LOC, might be not as readable as the change
in patch surely. Not strong opinion.

	memalloc_flags_restore(flags);


