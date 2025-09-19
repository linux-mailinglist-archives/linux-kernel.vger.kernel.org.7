Return-Path: <linux-kernel+bounces-825180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFFB8B2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7A767E3B49
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 20:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6A289E30;
	Fri, 19 Sep 2025 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LLMYRkHR"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BAB1DEFE8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758313547; cv=none; b=EpZpz6fBSkI4tKebV1euW3K46CejPgGF2BUSYD76mWdIz/1ANXFhn27hdEHAaXfanjRkqpBL251Ol0jyY6pvyFLpISFkDHUWVLlaD6baDfHcNQyumBWaYIdBPtKkjUJVjE0lF04MlEDnPdxdHoRLjRpxBryMwgRIPL4Gmoo4sQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758313547; c=relaxed/simple;
	bh=MLBAvqNYShoxP1EwO8A6CzrlrrIN3Kz0r/q59+Yfg7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZo5fKW55MsVbCvK1NvrnvNxxodMnbrhy72mfZLTMlyj9aHRjb6kTear09RgugPvywfxaKwwfcTn44cnU0yTG+BtNQszg0KmxD2RdNUlqlKYEQQnklKATclwCi2O2t2i30gI3c+YutyG/QWMZpiTMNOWHCHwZK4vISFbU5CRU+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LLMYRkHR; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 13:25:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758313542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/81rz7H4kqTaEJg0yrE1nrKWbw0pt0losxc3+BVs8Lc=;
	b=LLMYRkHR5n7vXVAXvJV9hjvFVosmqxbsqFx+Fod17CetTBxu6rA1oalNfEzGU8mnyI2EQT
	1mQdFOvMyEw16EGrH5WucNVGz9a6dEFHl/hswH58yiZALYaMvWiQ12v+SvzBAqtWDJzNym
	C6M+WdHy0QcyYv0sibpKNKcsViJYB1A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 1/5] mm/page_vma_mapped: Track if the page is mapped
 across page table boundary
Message-ID: <7qkpt4ia3qryjp2xo2ywy7qydav6nijghasr7biwctd5ah7dat@t3epq5dzt2sd>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-2-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124036.455709-2-kirill@shutemov.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 01:40:32PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Add a PVMW_PGTABLE_CROSSSED flag that page_vma_mapped_walk() will set if
> the page is mapped across page table boundary. Unlike other PVMW_*
> flags, this one is result of page_vma_mapped_walk() and not set by the
> caller.
> 
> folio_referenced_one() will use it detect if it safe to mlock the folio.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

> ---
>  include/linux/rmap.h | 5 +++++
>  mm/page_vma_mapped.c | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index 6cd020eea37a..04797cea3205 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -928,6 +928,11 @@ struct page *make_device_exclusive(struct mm_struct *mm, unsigned long addr,
>  /* Look for migration entries rather than present PTEs */
>  #define PVMW_MIGRATION		(1 << 1)
>  
> +/* Result flags */
> +
> +/* The page is mapped across page boundary */

I think you meant "page table boundary" in above comment.

> +#define PVMW_PGTABLE_CROSSSED	(1 << 16)
> +
>  struct page_vma_mapped_walk {
>  	unsigned long pfn;
>  	unsigned long nr_pages;
> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
> index e981a1a292d2..a184b88743c3 100644
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -309,6 +309,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  				}
>  				pte_unmap(pvmw->pte);
>  				pvmw->pte = NULL;
> +				pvmw->flags |= PVMW_PGTABLE_CROSSSED;
>  				goto restart;
>  			}
>  			pvmw->pte++;
> -- 
> 2.50.1
> 

