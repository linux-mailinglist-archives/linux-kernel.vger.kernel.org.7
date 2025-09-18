Return-Path: <linux-kernel+bounces-821960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04D7B82B24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4344E1895618
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 03:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803B23C38C;
	Thu, 18 Sep 2025 02:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQS7kXDu"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA921E1A17
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758164392; cv=none; b=mu9LOX3bm8rNS93AvwhuNTzD9uBZyRc6zeUfXo5VLtC6uIpQddNlwWYqv8VunXi9QcpIVTUQ+ThBxrb4Or1h/+KdsSlTfAmyTxfv3pNY8hpB6LzKz5kPMHyfk4ZgI9hQrvf5If1yfw2VUIvsRKmJvZ7FVB15SQ79IlF1Re7pFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758164392; c=relaxed/simple;
	bh=IRvSw2Dx3BviezEMqUHIj7NKGUdxC/8LoBdFA3kIPKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C7toMz+Zc/HF5DrkXHXBJrbhfxBBz6xafhc8UNUil8P5Re5fHrKz3tw0/Zqy4LZFfZ+on2/ktyam2z6cb7KxbSR6qKszteqHiJBnDTbaXfovwNqPuepLdAdcgIITB7IjnmyDHYFUHgUJB7pbeWnZIXp3/0S4/XLz5ZKWeY1DShQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KQS7kXDu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758164389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OcKW5Vz9+O4NXqO35+tX18KtIiANJDc+I7FuiS+m58c=;
	b=KQS7kXDu55Hb4wh9ITY4xrOcPnCJA/m8XJ28XXu/bNJX3xHsPsugJDOXXgxEtUBLzxLGhF
	vI8lHyLd9pKCba9wJNoS7Ra6vt8It2lJrwrnL1w+/jSPS/mAumJKPWd8xXBvH0r8gRVluz
	5PhPzu/MbMhCJp/0YR6gMOzVwllWJWw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-Ki7YPC2oNNW4rsY61BHysA-1; Wed,
 17 Sep 2025 22:59:46 -0400
X-MC-Unique: Ki7YPC2oNNW4rsY61BHysA-1
X-Mimecast-MFC-AGG-ID: Ki7YPC2oNNW4rsY61BHysA_1758164384
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 970491800366;
	Thu, 18 Sep 2025 02:59:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.180])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B2A91800447;
	Thu, 18 Sep 2025 02:59:43 +0000 (UTC)
Date: Thu, 18 Sep 2025 10:59:39 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 05/10] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aMt1myQHpxit3Zbo@MiWiFi-R3L-srv>
References: <20250915134041.151462-1-urezki@gmail.com>
 <20250915134041.151462-6-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915134041.151462-6-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/15/25 at 03:40pm, Uladzislau Rezki (Sony) wrote:
> __vmalloc_area_node() may call free_vmap_area() or vfree() on
> error paths, both of which can sleep. This becomes problematic
> if the function is invoked from an atomic context, such as when
> GFP_ATOMIC or GFP_NOWAIT is passed via gfp_mask.
> 
> To fix this, unify error paths and defer the cleanup of partly
> initialized vm_struct objects to a workqueue. This ensures that
> freeing happens in a process context and avoids invalid sleeps
> in atomic regions.
> 
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/vmalloc.h |  6 +++++-
>  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 2759dac6be44..97252078a3dc 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -50,7 +50,11 @@ struct iov_iter;		/* in uio.h */
>  #endif
>  
>  struct vm_struct {
> -	struct vm_struct	*next;
> +	union {
> +		struct vm_struct *next;	  /* Early registration of vm_areas. */
> +		struct llist_node llnode; /* Asynchronous freeing on error paths. */
> +	};
> +
>  	void			*addr;
>  	unsigned long		size;
>  	unsigned long		flags;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index b77e8be75f10..e61e62872372 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3686,6 +3686,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
>  	return nr_allocated;
>  }
>  
> +static LLIST_HEAD(pending_vm_area_cleanup);
> +static void cleanup_vm_area_work(struct work_struct *work)
> +{
> +	struct vm_struct *area, *tmp;
> +	struct llist_node *head;
> +
> +	head = llist_del_all(&pending_vm_area_cleanup);
> +	if (!head)
> +		return;
> +
> +	llist_for_each_entry_safe(area, tmp, head, llnode) {
> +		if (!area->pages)
> +			free_vm_area(area);
> +		else
> +			vfree(area->addr);
> +	}
> +}
> +
> +/*
> + * Helper for __vmalloc_area_node() to defer cleanup
> + * of partially initialized vm_struct in error paths.
> + */
> +static DECLARE_WORK(cleanup_vm_area, cleanup_vm_area_work);
> +static void defer_vm_area_cleanup(struct vm_struct *area)
> +{
> +	if (llist_add(&area->llnode, &pending_vm_area_cleanup))
> +		schedule_work(&cleanup_vm_area);
> +}
> +
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				 pgprot_t prot, unsigned int page_shift,
>  				 int node)
> @@ -3717,8 +3746,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
> -		return NULL;
> +		goto fail;
>  	}
>  
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> @@ -3795,7 +3823,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return area->addr;
>  
>  fail:
> -	vfree(area->addr);
> +	defer_vm_area_cleanup(area);
>  	return NULL;
>  }
>  
> -- 
> 2.47.3
> 


