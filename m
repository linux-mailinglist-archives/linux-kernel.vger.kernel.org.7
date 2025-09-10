Return-Path: <linux-kernel+bounces-810553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C997B51C3E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FE8562940
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DBB32A801;
	Wed, 10 Sep 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FSMyqJWa"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCA30F800
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757519105; cv=none; b=OI7BwYAJJgnkfp6ttZdMKlAGn3SLf9I3O74lzON2JhC0crUnpYO2ksjHkvHwlIWNKk0mu0Q6ueuIveL3X8vF4PGHP/OZ/aNs9UsVjZnfDVGzyigjXt5vsp7EUTN1B/TIc/jL9mc0m6lw/7hHN7muc4zwYTkxmxa09EjuSrMOPFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757519105; c=relaxed/simple;
	bh=zewXLSYfzCeumuh+Q+V1RN2hyJcYMhDnIzg74cwIGZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PbaLt7f/z9N+/N2BhvNempOsMUhCw6j6nBxpBJMmdF09lN1Tv+X5fmg2RkwBqq3zN5o/TRrI71t3s+nkXulEglvFV0wFhyY7fUeNhHcdWl/AJO9oUXea2R+uEsK8YH5lruuz/K7e+/a51RNubo3MwFqCdD+Ry3lXUwkzGYe9Ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FSMyqJWa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=R4SFRua4tQ0Gijz9/yISvfIst143Bm6fRH6N/9ViY+I=; b=FSMyqJWavJW0jS2IPwJx7uChbi
	cZ/019mkqwHp/YhwTm1qRUdfMyJY9tfXzu0mC/NzBeOJFfIA59vSJAdJxdqLJK6oDI6Id4Qw5shm+
	EGZiLadAf3XGfTFRCJCKeMVaFYgWw+XMUP5m5Si0tifUSxC0YG9mbTVuIIXqPeaemUgEpx2D1C17z
	BwwCct5LxRl8l6L81FM8dFyJjfrfcRIyripTxvuwz4DynYz9Ue6lWf+I1/ZBlIDye77tvLB4H+dBC
	LLhp11tT9dma8uO8uhPwbRFjSv9IalKx2GOEyK6UfkQhuF6KeLuHFr4msk8nsTEaAULjpxK14OTXr
	omP5A99g==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwN0C-0000000BKmy-3NsY;
	Wed, 10 Sep 2025 15:44:56 +0000
Date: Wed, 10 Sep 2025 16:44:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Chris Li <chrisl@kernel.org>,
	Jason Miu <jasonmiu@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] kho: make sure folio being restored is actually from KHO
Message-ID: <aMGc-ExhkqwAyY_C@casper.infradead.org>
References: <20250910153443.95049-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910153443.95049-1-pratyush@kernel.org>

On Wed, Sep 10, 2025 at 05:34:40PM +0200, Pratyush Yadav wrote:
> +#define KHO_PAGE_MAGIC 0x4b484f50U /* ASCII for 'KHOP' */
> +
> +/*
> + * KHO uses page->private, which is an unsigned long, to store page metadata.
> + * Use it to store both the magic and the order.
> + */
> +union kho_page_info {
> +	unsigned long page_private;
> +	struct {
> +		unsigned int order;
> +		unsigned int magic;
> +	};

KHO is only supported on 64-bit?

> @@ -210,16 +226,16 @@ static void kho_restore_page(struct page *page, unsigned int order)
>  struct folio *kho_restore_folio(phys_addr_t phys)
>  {
>  	struct page *page = pfn_to_online_page(PHYS_PFN(phys));
> -	unsigned long order;
> +	union kho_page_info info;
>  
>  	if (!page)
>  		return NULL;
>  
> -	order = page->private;
> -	if (order > MAX_PAGE_ORDER)
> +	info.page_private = page->private;
> +	if (info.magic != KHO_PAGE_MAGIC || info.order > MAX_PAGE_ORDER)
>  		return NULL;
>  
> -	kho_restore_page(page, order);
> +	kho_restore_page(page, info.order);
>  	return page_folio(page);

This all looks very confused.  Before your patch as well as after it.
I don't see anything in the current KHO code that requires the
phys_addr_t to be order-aligned.


