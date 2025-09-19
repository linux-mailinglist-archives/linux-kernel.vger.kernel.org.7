Return-Path: <linux-kernel+bounces-825229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD7FB8B547
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 23:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7709C560CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B182D0617;
	Fri, 19 Sep 2025 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fDz9MGq6"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3F825A2DE
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 21:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758317271; cv=none; b=sCGkglxifnTkT4INAHVMWJ+tUD46q3etO7ZGW+8nDP1XnHUowb8XCWgDvzrxmVjjfVIabaDZih9KyQbcvL6tjvtkrlVe9YfORA3JoFfhAZtunowHLk+YtoaKmrRq6i9DRcTCU+MjLIJQ9P+r0g/IAUT8Cf0FCiaIblmbUot1Q/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758317271; c=relaxed/simple;
	bh=ld0+Q7OHnWEopjLAR5wWMZaEnENWoqToq/kQT8d0EuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuWmtOZQLMTKJpdfOntPgExiFSxAKpF6fN3cdhLpyL1R1jQGLcrUAfkQmZUExtaIDt4rCI+++8OWCqqqP0XKUCQnqfU4WBBgoyYmYLdD0Su6N0lnSuafIji2e/2NioaZTMaqGd3pvBCSvdlThCzQEPPYOPgF0pk48VtnnsOn/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fDz9MGq6; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 19 Sep 2025 14:27:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758317267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8gyzPijsRQmycSlmSoB0622QIHLdkNIiCzOl4oHy+DM=;
	b=fDz9MGq6DnN1sSS2hVmApGdHwuv9k1E5krScublyJNvR3lORvZetxJil1pMfHTiPQApxQZ
	iIca+2QNrwk1IcuFVi0Nr6oNY0/MpgyrrEwZC3g2dlm9JwYrirRhzVl1p61F+WpeW1rdXk
	p2nlhkRmS4FkAL+i9WZ1IhPuwvCPoFc=
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
Subject: Re: [PATCHv2 3/5] mm/rmap: mlock large folios in try_to_unmap_one()
Message-ID: <27wxlfhnkxaat57lzyzlpo66vse3jjhp422ziswbl4oyjnamif@2jx25dwgkame>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-4-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919124036.455709-4-kirill@shutemov.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Sep 19, 2025 at 01:40:34PM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Currently, try_to_unmap_once() only tries to mlock small folios.
> 
> Use logic similar to folio_referenced_one() to mlock large folios:
> only do this for fully mapped folios and under page table lock that
> protects all page table entries.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> ---
>  mm/rmap.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 3d0235f332de..482e6504fa88 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1870,6 +1870,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	unsigned long nr_pages = 1, end_addr;
>  	unsigned long pfn;
>  	unsigned long hsz = 0;
> +	int ptes = 0;
>  
>  	/*
>  	 * When racing against e.g. zap_pte_range() on another cpu,
> @@ -1910,10 +1911,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  		 */
>  		if (!(flags & TTU_IGNORE_MLOCK) &&
>  		    (vma->vm_flags & VM_LOCKED)) {
> +			ptes++;
> +			ret = false;
> +
> +			/* Only mlock fully mapped pages */
> +			if (pvmw.pte && ptes != pvmw.nr_pages)
> +				continue;
> +
> +			/*
> +			 * All PTEs must be protected by page table lock in
> +			 * order to mlock the page.
> +			 *
> +			 * If page table boundary has been cross, current ptl
> +			 * only protect part of ptes.
> +			 */
> +			if (pvmw.flags & PVMW_PGTABLE_CROSSSED)
> +				goto walk_done;

Should it be goto walk_abort?

> +
>  			/* Restore the mlock which got missed */
> -			if (!folio_test_large(folio))
> -				mlock_vma_folio(folio, vma);
> -			goto walk_abort;
> +			mlock_vma_folio(folio, vma);
> +			goto walk_done;

Here too?

>  		}
>  
>  		if (!pvmw.pte) {
> -- 
> 2.50.1
> 

