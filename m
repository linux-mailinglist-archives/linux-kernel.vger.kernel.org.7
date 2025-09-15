Return-Path: <linux-kernel+bounces-817130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81ABDB57E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA93A28AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAAA20B800;
	Mon, 15 Sep 2025 14:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P+u9tdzp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB481F3B96
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944871; cv=none; b=QljrwIvvXI/Gf01tnlO0m89Myh9CFeOU2Pslens7g4FXvfhovLMJJgWEP1EQUIdaMBVIqMKFIulYhwy8xnmrhepvK0YX+7UlHq+1zgCOSNzmJNrXwXNJU8DBAeqBPlhfHDsX1moAoa9/fY32Fbat0FKm7DVW+w1FUxspOkjP3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944871; c=relaxed/simple;
	bh=8olvie8tLQ2mhtW55gwpyxifDR7KCERuklBIHTYWwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VybfwR92YaYwp1Qa3G/L6qkmpafCds2sqC/voT5BCnQHAjC+hCdfaU27p9dKgnrMkGqpiY2WFk/+ttRcr2rVWSkJdrtynNAa0IMKhvFRFvFE1pyS5Vi+jYxTsfo5GsGPVi5zNQmyC1dasxmMTVw752Kg9wO8Qy1LaS8qunOCbPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P+u9tdzp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AE7C4CEF1;
	Mon, 15 Sep 2025 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944870;
	bh=8olvie8tLQ2mhtW55gwpyxifDR7KCERuklBIHTYWwxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P+u9tdzpymz6xsyciaB6n3rt32DVJ8+TkdA7u70VzV72+k5dfIPdjeJj4BiAV+zKq
	 JwdqgqXiaXa9ZOFhYxBmdHIQQ1J+YbxXvkezAfMpAbWdM/v3gmNMLZr4DryGCc0xuJ
	 4aGtt9LYRSI+K270uEvon56jV/zEAzOjadorNAY2R31CCG0DUgHOcjSy7qVwIID+VC
	 FOYjTJhwajK4xIOdABSmdLMyKmZWIKZweFortDGA/PR7vnLLl2lleaO2D2wJAckTYY
	 KoaZWXsO7U5wdxe+NIb4cIKw8/UmhlyUFgs2mOlYNKMzs9veniITYpVrrQbm2szDQ1
	 Y4K+eoPfacPAg==
Date: Mon, 15 Sep 2025 17:01:01 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMgcHWxsEWnKzzcN@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <20250908141423.GJ616306@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908141423.GJ616306@nvidia.com>

On Mon, Sep 08, 2025 at 11:14:23AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 08, 2025 at 01:35:27PM +0300, Mike Rapoport wrote:
> > +static struct kho_vmalloc_chunk *new_vmalloc_chunk(struct kho_vmalloc_chunk *cur)
> > +{
> > +	struct kho_vmalloc_chunk *chunk;
> > +	int err;
> > +
> > +	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!chunk)
> > +		return NULL;
> > +
> > +	err = kho_preserve_phys(virt_to_phys(chunk), PAGE_SIZE);
> > +	if (err)
> > +		goto err_free;
> 
> kzalloc() cannot be preserved, the only thing we support today is
> alloc_page(), so this code pattern shouldn't exist.
 
kzalloc(PAGE_SIZE) can be preserved, it's page aligned and we don't have to
restore it into a slab cache. But this maybe indeed confusing for those who
copy paste the code, so I'll change it.

> Call alloc_page() and use a kho_preserve_page/folio() like the luo
> patches were doing. The pattern seems common it probably needs a small
> alloc/free helper.
> 
> > +	for (int i = 0; i < vm->nr_pages; i += (1 << order)) {
> > +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> > +
> > +		err = __kho_preserve_order(track, PHYS_PFN(phys), order);
> > +		if (err)
> > +			goto err_free;
> 
> I think you should make a helper inline to document what is happening here:
> 
> /*
>  * Preserve a contiguous aligned list of order 0 pages that aggregate
>  * to a higher order allocation. Must be restored using
>  * kho_restore_page() on each order 0 page.
>  */
> kho_preserve_pages(page, order);

Maybe.
 
> Jason

-- 
Sincerely yours,
Mike.

