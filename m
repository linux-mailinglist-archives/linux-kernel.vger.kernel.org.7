Return-Path: <linux-kernel+bounces-884952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A353C318FF
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D16974FC4DE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F386732E694;
	Tue,  4 Nov 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnaL4sZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E81DB13A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266721; cv=none; b=lGr43sg7JiBCdJvaeaibXYxuR5kADZab+IUypGZL/XiZl9cGzdK+g2JtmfA2QIJILQnP18ca1aXD30SpP6sooz8d7AWiby813UJgQZD07uCu004h1sd+Flzmx8X7lIHNFnZmWK2y22xriLHO3LKr0EbI6zcLi0P98Z2tlYX38CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266721; c=relaxed/simple;
	bh=8W4axGtzep0PSa+t2A3pgDKAtbFw4XdyrfNDp7pGJnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roEpK538RlrWvkNzk51YSpQPIYeqB7elFu3k9MJPOXeClY1Cmgcq36Ox5GKRSEVS6n5FH3uQmrNPWasdpVbvfCiqhJ8NBN3EXxDj0XQe7X6pQG3CsxsIcBSylxVvB5hUld43GxNA8pYGxrgYtfhPYB2LOrULTOlA1LJcyTzDbRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnaL4sZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD56C116B1;
	Tue,  4 Nov 2025 14:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762266721;
	bh=8W4axGtzep0PSa+t2A3pgDKAtbFw4XdyrfNDp7pGJnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jnaL4sZQvfUoDwrR8UBqQ5So4v/ALu+u4JJclBYQEgXnbBy1fQMQxod8h80BQRPux
	 YWEvy3nrChwSkoq1bXsoyPkyl0so63krb67i2xL5N7xeslpYw7ok8e0IQvANfsGUiL
	 S+cK8pbsHqL0La+kI9pQgqUW4kS2a/2Re1Q9NIawUGMEYUVwvj/Wvrlp66w/gtF4//
	 opsJTg6nCMLJd96BsYddpZW1PyYxrqkaTBcFGvynSnd9elqBWbyjPG6Gz+otq57fK5
	 bwk8+LWv7a3zghpNBuu4fse44vxjAkY0KhdEaJfsA7gICwvoGA30Ezvc/ekZwkgpKL
	 6KEN/WRMMJtfA==
Date: Tue, 4 Nov 2025 16:31:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: fix unpreservation of higher-order vmalloc
 preservations
Message-ID: <aQoOWtjJWjr81lBj@kernel.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
 <20251103180235.71409-2-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103180235.71409-2-pratyush@kernel.org>

On Mon, Nov 03, 2025 at 07:02:31PM +0100, Pratyush Yadav wrote:
> kho_vmalloc_unpreserve_chunk() calls __kho_unpreserve() with end_pfn as
> pfn + 1. This happens to work for 0-order pages, but leaks higher order
> pages.
> 
> For example, say order 2 pages back the allocation. During preservation,
> they get preserved in the order 2 bitmaps, but
> kho_vmalloc_unpreserve_chunk() would try to unpreserve them from the
> order 0 bitmaps, which should not have these bits set anyway, leaving
> the order 2 bitmaps untouched. This results in the pages being carried
> over to the next kernel. Nothing will free those pages in the next boot,
> leaking them.
> 
> Fix this by taking the order into account when calculating the end PFN
> for __kho_unpreserve().
> 
> Fixes: a667300bd53f2 ("kho: add support for preserving vmalloc allocations")
> Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
> 
> Notes:
>     When Pasha's patch [0] to add kho_unpreserve_pages() is merged, maybe it
>     would be a better idea to use kho_unpreserve_pages() here? But that is
>     something for later I suppose.
>     
>     [0] https://lore.kernel.org/linux-mm/20251101142325.1326536-4-pasha.tatashin@soleen.com/
> 
>  kernel/kexec_handover.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
> index cc5aaa738bc50..c2bcbb10918ce 100644
> --- a/kernel/kexec_handover.c
> +++ b/kernel/kexec_handover.c
> @@ -862,7 +862,8 @@ static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur
>  	return NULL;
>  }
>  
> -static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
> +static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk,
> +					 unsigned short order)
>  {
>  	struct kho_mem_track *track = &kho_out.ser.track;
>  	unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> @@ -871,7 +872,7 @@ static void kho_vmalloc_unpreserve_chunk(struct kho_vmalloc_chunk *chunk)
>  
>  	for (int i = 0; i < ARRAY_SIZE(chunk->phys) && chunk->phys[i]; i++) {
>  		pfn = PHYS_PFN(chunk->phys[i]);
> -		__kho_unpreserve(track, pfn, pfn + 1);
> +		__kho_unpreserve(track, pfn, pfn + (1 << order));
>  	}
>  }
>  
> @@ -882,7 +883,7 @@ static void kho_vmalloc_free_chunks(struct kho_vmalloc *kho_vmalloc)
>  	while (chunk) {
>  		struct kho_vmalloc_chunk *tmp = chunk;
>  
> -		kho_vmalloc_unpreserve_chunk(chunk);
> +		kho_vmalloc_unpreserve_chunk(chunk, kho_vmalloc->order);
>  
>  		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
>  		free_page((unsigned long)tmp);
> -- 
> 2.47.3
> 

-- 
Sincerely yours,
Mike.

