Return-Path: <linux-kernel+bounces-812790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE94FB53CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 22:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 924B57BBA2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA1324337B;
	Thu, 11 Sep 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eqkfWOnW"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555D2F5B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757620891; cv=none; b=ppzL+hHZwa2IQSKNcf8M+k3yixiuD8APfAloqTCQGJ3/jMsKcMIevS8WCRIvwLDQ3hKYK/jUdIiVM2UkpnmA6X3OT31LLfoSB6tyc7fwyUmSXMUYax1xKAlFnkdFHJS750TNHT/79gD+bo0YH2VX3ZdgTr+k/e348OLkFvuSBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757620891; c=relaxed/simple;
	bh=GggL/uSSVUKTETlzISu0jBfS/kl3zglyhc3OVU/83/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/qwX47ubm1dKslILNp6Wv51xVrKdAs1LWCFdZiWQZ2hGf7Nroaljr+Q7//bWfKlqYSZ6opbHd+1AVxjZucdOXHu95VtM9F0ewoex0S9djQfCKieChcWBiInIpDXbkx8FKlDNYeoMjlMq+O8+wxWKRsNxthD1NQdc/MbL0MmhLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eqkfWOnW; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Sep 2025 13:01:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757620886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/tO27DlleKvDpEy0vh0IUHnG6TXTGPEvg43VFxXxxfA=;
	b=eqkfWOnWBt11D/7ixqsJHWm4D0QwESMmg0yfjPVTIPNMvNvU0pTy+02ughBeOz9BMg3Ti0
	DLJJeRbSD8D5eNy7v6c3RTjFERoBQtSLZc6lDsdxuRkXOQ4WlEwfwWwqGIqtBpWfTMLq3r
	SgsdWMfZb54CoVt8iLZgpv30b3rnYA0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, vbabka@suse.cz, 
	mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com, 
	usamaarif642@gmail.com, 00107082@163.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] alloc_tag: avoid warnings when freeing non-compound
 "tail" pages
Message-ID: <zxbgiqf4d3nlww2xxoea7rud3q4oj2osk657xnhu6r7du4lf3p@es7mqt7joo7b>
References: <20250909233409.1013367-1-surenb@google.com>
 <20250909233409.1013367-4-surenb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909233409.1013367-4-surenb@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 09, 2025 at 04:34:09PM -0700, Suren Baghdasaryan wrote:
> When freeing "tail" pages of a non-compount high-order page, we properly
> subtract the allocation tag counters, however later when these pages are
> released, alloc_tag_sub() will issue warnings because tags for these pages
> are NULL.
> This issue was originally anticipated by Vlastimil in his review [1] and
> then recently reported by David.
> Prevent warnings by marking the tags empty.
> 
> [1] https://lore.kernel.org/all/6db0f0c8-81cb-4d04-9560-ba73d63db4b8@suse.cz/
> 
> Suggested-by: David Wang <00107082@163.com>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/page_alloc.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 1760346bbd24..d21a411e807e 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5240,9 +5240,16 @@ static void ___free_pages(struct page *page, unsigned int order,
>  		__free_frozen_pages(page, order, fpi_flags);
>  	else if (!head) {
>  		pgalloc_tag_sub_pages(tag, (1 << order) - 1);
> -		while (order-- > 0)
> +		while (order-- > 0) {
> +			/*
> +			 * The "tail" pages of this non-compound high-order
> +			 * page will have no code tags, so to avoid warnings
> +			 * mark them as empty.
> +			 */
> +			clear_page_tag_ref(page + (1 << order));

Do we need something similar for the release_pages() code path or is it
happening already?

>  			__free_frozen_pages(page + (1 << order), order,
>  					    fpi_flags);
> +		}
>  	}
>  }
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 

