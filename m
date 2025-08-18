Return-Path: <linux-kernel+bounces-772832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA36B29818
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 06:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE2D3BFC95
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA61262FE5;
	Mon, 18 Aug 2025 04:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U0AVjbq8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B267262FD2
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 04:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755490892; cv=none; b=r7XTfhzWlnizDrNHbBW+S1NG1PF89UCteD9U4lq+EEyzke93XsFKp3fxEQ7w0xVIViKrzEtjyImUk0YYW0SqICd6r9Unhjod87mBSoCB0ekADecEcARUOs5gSc7uZa8XqztqewnimB4fmEEs4EznGEOJF8dx9Fy0xsLW5NnYGS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755490892; c=relaxed/simple;
	bh=7p90cMbEL8ENr2hRMigPlDNSvLCCi4a4uaIkHCnyOSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfklbbwHZuGZaN5TubZkyJjANo5PlFnWGSE/DAhm8rgniW23AiloCZE3S28tIgpTgCA3WGA6dp7Q3pKeKSLIBRzA5UZh9F6ULDqcuLqhz5+29/u54NAfBBOEXuqy+B0/kd9sPG+DJBNIgaYyKneaVbZfJtwgMDu55L7WAdxTl1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U0AVjbq8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755490889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sgY9urGSsFiJ6C12Uuom1iR66x4tQT4kD42czaPA10c=;
	b=U0AVjbq8DcIBsOs9AWY7fyBAkNU0Tc243CWWL74AkErTUcmLxTMutrPl/JOEDlJg4NZLKM
	ADUhvZlWQgHPeWhhI1O5D+h/22gGlbMETHzOlfCGKHtoOgTNiiiWI3jCIOSlmKFZGIaToQ
	a4anbwK6PB74ki53kBxG5g8bN0bUuh4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-1A2YyQ2IP7Cg-M5bzkNbbA-1; Mon,
 18 Aug 2025 00:21:23 -0400
X-MC-Unique: 1A2YyQ2IP7Cg-M5bzkNbbA-1
X-Mimecast-MFC-AGG-ID: 1A2YyQ2IP7Cg-M5bzkNbbA_1755490882
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E768D180034D;
	Mon, 18 Aug 2025 04:21:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.210])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F75F1955F24;
	Mon, 18 Aug 2025 04:21:20 +0000 (UTC)
Date: Mon, 18 Aug 2025 12:21:15 +0800
From: Baoquan He <bhe@redhat.com>
To: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/8] mm/vmalloc: Defer freeing partly initialized
 vm_struct
Message-ID: <aKKqOzepmIkOJi3i@MiWiFi-R3L-srv>
References: <20250807075810.358714-1-urezki@gmail.com>
 <20250807075810.358714-7-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807075810.358714-7-urezki@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 08/07/25 at 09:58am, Uladzislau Rezki (Sony) wrote:
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
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  include/linux/vmalloc.h |  6 +++++-
>  mm/vmalloc.c            | 34 +++++++++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index fdc9aeb74a44..b1425fae8cbf 100644
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
> index 7f48a54ec108..2424f80d524a 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3680,6 +3680,35 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
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

Wondering why here we need call schudule_work() when
pending_vm_area_cleanup was empty before adding new entry. Shouldn't
it be as below to schedule the job? Not sure if I miss anything.

	if (!llist_add(&area->llnode, &pending_vm_area_cleanup))
		schedule_work(&cleanup_vm_area);

=====
/**
 * llist_add - add a new entry
 * @new:        new entry to be added
 * @head:       the head for your lock-less list
 *
 * Returns true if the list was empty prior to adding this entry.
 */
static inline bool llist_add(struct llist_node *new, struct llist_head *head)
{
        return llist_add_batch(new, new, head);
}
=====

> +
>  static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  				 pgprot_t prot, unsigned int page_shift,
>  				 int node)
> @@ -3711,8 +3740,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  		warn_alloc(gfp_mask, NULL,
>  			"vmalloc error: size %lu, failed to allocated page array size %lu",
>  			nr_small_pages * PAGE_SIZE, array_size);
> -		free_vm_area(area);
> -		return NULL;
> +		goto fail;
>  	}
>  
>  	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> @@ -3789,7 +3817,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	return area->addr;
>  
>  fail:
> -	vfree(area->addr);
> +	defer_vm_area_cleanup(area);
>  	return NULL;
>  }
>  
> -- 
> 2.39.5
> 


