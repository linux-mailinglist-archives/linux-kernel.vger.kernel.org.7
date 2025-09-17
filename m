Return-Path: <linux-kernel+bounces-821699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8CDB82024
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D70C62800A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0256E30DEC8;
	Wed, 17 Sep 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aPYcJuS1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF0E29ACEE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758145460; cv=none; b=OnRtTesU++XXyq1KcV7odkAQuSdM9gI29phhnclDwKjzH03QgYohmyBBxdG4CbTJL3CTpGkORHOIMnWrVLEoMqwGPleqRIsX4pt7TGFDwh3Yf+tX0akHylT/hzxxT0i/5KnZKRDrhBWLaik5fnvLoF4fZvaPqHzR6m58oQVNT8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758145460; c=relaxed/simple;
	bh=Y/JCpR1xXuoBkwljLMibP0v4lm/i2uaaBybKIFHkiFI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=fu0JS8BqGKA33tFtij9VqjDaf2EtmvJXtM/yjnNFWD02Yi4+nMdg5noyK7m/1CxrEKFQPdCGR7DOMwPoGxRCt7a96+LoVjgOceKX5rD7hi2LREFGxJsuKZpZNs7z+XnWNkt7gawdNcljwQJhmwva5csPDYUS+DP5Ujcuuei4Srg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aPYcJuS1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D692BC4CEE7;
	Wed, 17 Sep 2025 21:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758145459;
	bh=Y/JCpR1xXuoBkwljLMibP0v4lm/i2uaaBybKIFHkiFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aPYcJuS14avROKNJKvC5vVXubfl0lbQC93Dl8gbsR6nw1YWYh2GRbNGWKNRDA5FYD
	 c2qpMAHwc9MpBCw13voMdBlmJpmhcrCbzC8cSqgsPJWGJhoGQou0RXoQEsRY+D/fIT
	 ujpQjQg2UNq4OTHkNSX30wpJRmzuB4CJB7HxQyAU=
Date: Wed, 17 Sep 2025 14:44:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 david@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org, peterz@infradead.org,
 acme@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
 willy@infradead.org, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
 konrad.wilk@oracle.com
Subject: Re: [PATCH v7 13/16] mm: memory: support clearing page ranges
Message-Id: <20250917144418.25cb9117d64b32cb0c7908d9@linux-foundation.org>
In-Reply-To: <20250917152418.4077386-14-ankur.a.arora@oracle.com>
References: <20250917152418.4077386-1-ankur.a.arora@oracle.com>
	<20250917152418.4077386-14-ankur.a.arora@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Sep 2025 08:24:15 -0700 Ankur Arora <ankur.a.arora@oracle.com> wrote:

> Change folio_zero_user() to clear contiguous page ranges instead of
> clearing using the current page-at-a-time approach. Exposing the largest
> feasible length can be useful in enabling processors to optimize based
> on extent.

This patch is something which MM developers might care to take a closer
look at.

> However, clearing in large chunks can have two problems:
> 
>  - cache locality when clearing small folios (< MAX_ORDER_NR_PAGES)
>    (larger folios don't have any expectation of cache locality).
> 
>  - preemption latency when clearing large folios.
> 
> Handle the first by splitting the clearing in three parts: the
> faulting page and its immediate locality, its left and right
> regions; with the local neighbourhood cleared last.

Has this optimization been shown to be beneficial?

If so, are you able to share some measurements?

If not, maybe it should be removed?

> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -7021,40 +7021,80 @@ static inline int process_huge_page(
>  	return 0;
>  }
>  
> -static void clear_gigantic_page(struct folio *folio, unsigned long addr_hint,
> -				unsigned int nr_pages)
> +/*
> + * Clear contiguous pages chunking them up when running under
> + * non-preemptible models.
> + */
> +static void clear_contig_highpages(struct page *page, unsigned long addr,
> +				   unsigned int npages)

Called "_highpages" because it wraps clear_user_highpages().  It really
should be called clear_contig_user_highpages() ;)  (Not serious)

>  {
> -	unsigned long addr = ALIGN_DOWN(addr_hint, folio_size(folio));
> -	int i;
> +	unsigned int i, count, unit;
>  
> -	might_sleep();
> -	for (i = 0; i < nr_pages; i++) {
> +	unit = preempt_model_preemptible() ? npages : PAGE_CONTIG_NR;

Almost nothing uses preempt_model_preemptible() and I'm not usefully
familiar with it.  Will this check avoid all softlockup/rcu/etc
detections in all situations (ie, configs)?

> +	for (i = 0; i < npages; ) {
> +		count = min(unit, npages - i);
> +		clear_user_highpages(nth_page(page, i),
> +				     addr + i * PAGE_SIZE, count);
> +		i += count;
>  		cond_resched();
> -		clear_user_highpage(folio_page(folio, i), addr + i * PAGE_SIZE);
>  	}
>  }


