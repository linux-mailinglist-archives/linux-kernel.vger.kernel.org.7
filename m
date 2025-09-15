Return-Path: <linux-kernel+bounces-817142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1BBB57E6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603C318952E4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B2130F813;
	Mon, 15 Sep 2025 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPNNM2K5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8752F998B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945288; cv=none; b=CdcdoVVe3jxWD8gs++AuT1+ItCM5b7BBpPyde2aOULcNk81euGSGGWEZjU/RG31WfFWBLpmFPUITrwmXYJzSTSzE9nmVTEqJnHTjhpVNipEpEeArTJfEtuEM1BFUXXAWNp1aXp2NAFBeg4S8vsfXlerFaXLScE83SNhAC9ps40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945288; c=relaxed/simple;
	bh=h50qQh38duU1m6UIFJf7kQKicDE1Q8M4KDLHwbgBOf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gl8f6YDuMundZdfaI5hkdMV0xVdS3djRsmgpEmr+CIM7QM36XiHlfuVYwUy+4WyNwezbn8WF/5F5CuIppIT2DqLCWuCPYH7zXdh4jl02T6kLMomB9FoZvVmsQuPg65/BFLcummlYdMOMiniMWeT0Lu/MJ60LPYDcO1XwmYGSxos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPNNM2K5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B3BC4CEF1;
	Mon, 15 Sep 2025 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757945288;
	bh=h50qQh38duU1m6UIFJf7kQKicDE1Q8M4KDLHwbgBOf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NPNNM2K5+B1b/SGk0biF3/sOCzrwdCGam8qGKQHN+sks0w9l8kVUKoPjqOjSLiFWS
	 2Kr+U43tOamkUeEMzbHOtI4pmdBkDOAjZ1TIi0djoYjB3zPh6LyuRjqwO7ZwrBJFqA
	 /Gj13YwN9YfxvmHRe412aU6eX2AsYpzT5f5WMy/7jNaL9tvMUllEfmqj3TY74AqKpz
	 oi3AEtwgKPN1k2cUpXB+CCBwz9fNLonEJvXs3vZ50hYxlESkNOp9tbnNyUyZ4ksghJ
	 Rchlx7gZR8ShmyvcSHwDa5Fw6FKvXyMxd1GTSQe+POyeTUnhCdELwE/nLGFz2pcduw
	 M8mwbbGO9VV3A==
Date: Mon, 15 Sep 2025 17:08:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMgdwE83dKdT1K7L@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <mafs0ldmon784.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmon784.fsf@kernel.org>

On Mon, Sep 08, 2025 at 08:12:59PM +0200, Pratyush Yadav wrote:
> On Mon, Sep 08 2025, Mike Rapoport wrote:
> 
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > A vmalloc allocation is preserved using binary structure similar to
> > global KHO memory tracker. It's a linked list of pages where each page
> > is an array of physical address of pages in vmalloc area.
> >
> > kho_preserve_vmalloc() hands out the physical address of the head page
> > to the caller. This address is used as the argument to
> > kho_vmalloc_restore() to restore the mapping in the vmalloc address
> > space and populate it with the preserved pages.
> >
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

...

> > @@ -742,6 +743,205 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
> >  }
> >  EXPORT_SYMBOL_GPL(kho_preserve_phys);
> >  
> > +struct kho_vmalloc_chunk;
> > +
> > +struct kho_vmalloc_hdr {
> > +	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> > +	unsigned int total_pages;	/* only valid in the first chunk */
> > +	unsigned int flags;		/* only valid in the first chunk */
> > +	unsigned short order;		/* only valid in the first chunk */
> > +	unsigned short num_elms;
> 
> I think it the serialization format would be cleaner if these were
> defined in a separate structure that holds the metadata instead of being
> defined in each page and then ignored in most of them.
> 
> If the caller can save 8 bytes (phys addr of first page), it might as
> well save 16 instead. Something like the below perhaps?
> 
> struct kho_vmalloc {
> 	DECLARE_KHOSER_PTR(first, struct kho_vmalloc_chunk *);
> 	unsigned int total_pages;
> 	unsigned short flags;
> 	unsigned short order;
> };
> 
> And then kho_vmalloc_hdr becomes simply:
> 
> struct kho_vmalloc_hdr {
> 	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
> };
> 
> You don't even need num_elms since you have the list be zero-terminated.

Agree, thanks. 

> > +#define KHO_VMALLOC_FLAGS_MASK	(VM_ALLOC | VM_ALLOW_HUGE_VMAP)
> 
> I don't think it is a good idea to re-use VM flags. This can make adding
> more flags later down the line ugly. I think it would be better to
> define KHO_VMALLOC_FL* instead.

Ok.
 
> > +static void kho_vmalloc_free_chunks(struct kho_vmalloc_chunk *first_chunk)
> > +{
> > +	struct kho_mem_track *track = &kho_out.ser.track;
> > +	struct kho_vmalloc_chunk *chunk = first_chunk;
> > +
> > +	while (chunk) {
> > +		unsigned long pfn = PHYS_PFN(virt_to_phys(chunk));
> > +		struct kho_vmalloc_chunk *tmp = chunk;
> > +
> > +		__kho_unpreserve(track, pfn, pfn + 1);
> 
> This doesn't unpreserve the pages contained in the chunk, which
> kho_preserve_vmalloc() preserved.

Will fix. 

> > +	while (chunk) {
> > +		struct page *page;
> > +
> > +		for (int i = 0; i < chunk->hdr.num_elms; i++) {
> > +			phys_addr_t phys = chunk->phys[i];
> > +
> > +			for (int j = 0; j < (1 << order); j++) {
> > +				page = phys_to_page(phys);
> > +				kho_restore_page(page, 0);
> > +				pages[idx++] = page;
> 
> This can buffer-overflow if the previous kernel was buggy and added too
> many pages. Perhaps keep check for this?

You mean it added more than total_pages?
But the preserve part adds exactly vm->nr_pages, so once we get it right
what bugs do you expect here? 
 
> > +				phys += PAGE_SIZE;
> > +			}
> > +		}
> > +
> > +		page = virt_to_page(chunk);
> > +		chunk = KHOSER_LOAD_PTR(chunk->hdr.next);
> > +		kho_restore_page(page, 0);
> > +		__free_page(page);
> > +	}
> > +
> > +	area = __get_vm_area_node(nr * PAGE_SIZE, align, shift, flags,
> > +				  VMALLOC_START, VMALLOC_END, NUMA_NO_NODE,
> > +				  GFP_KERNEL, __builtin_return_address(0));
> > +	if (!area)
> > +		goto err_free_pages_array;
> > +
> > +	addr = (unsigned long)area->addr;
> > +	size = get_vm_area_size(area);
> > +	err = vmap_pages_range(addr, addr + size, PAGE_KERNEL, pages, shift);
> > +	if (err)
> > +		goto err_free_vm_area;
> > +
> > +	return area->addr;
> 
> You should free the pages array before returning here.

Why? They get into vm->pages.

-- 
Sincerely yours,
Mike.

