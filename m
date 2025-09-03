Return-Path: <linux-kernel+bounces-798999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CE3B425AD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35CE567A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA39027FD78;
	Wed,  3 Sep 2025 15:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0HiDuSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47F24679F
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913889; cv=none; b=ApN7X3K1CYCiZgH6t/pHDT7NNPfnpyWzMDKA4IsRtyK1iP3K+uE60SBPnzmaiNu8jWq+p2XMo1/qo7omSlJJFw3BhsnOzt4M9jUpjq4+s9bBCBtuMtwJ4ZsXZyCPXA8gH1l5BCvwBzSgvO4ky8mv+QVxEwz6+aj+hYI1DtWVses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913889; c=relaxed/simple;
	bh=kPZ/HOC3SKupxm3BQU2AcDhJjHorr5M7H7D+uIJksLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6cSXxcc/LBVkocvHWzapmndxCYnfQGQ8018wo4zOPIM2UM8w1VVVDq2sK9MmMo3aLZQ++AKK052sOpGcgc96ZTtgk+q33eValGOYgQb3EsHH4o8QdLJsFOs/OmZAzPPPkgTlfx1l6SH6Zu9AbICZ3P+B9YDtouQMD2GZtnOJi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0HiDuSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73FDC4CEE7;
	Wed,  3 Sep 2025 15:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756913888;
	bh=kPZ/HOC3SKupxm3BQU2AcDhJjHorr5M7H7D+uIJksLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0HiDuSBWD6RKvzMmsTgK0+L/QNoNUgURaef943FSpHKL181/qC/AAadQ1B+rFsgs
	 bwFMu4c8jwYCeyd+Fe+h2ZSm0HaPkWxMk850oIpz+Tn44thrU730jQE7Xup+QiRPXc
	 omi5lR254h3+m2tM/5haS2LtmkQi8QxwD+6XKlU81wmasOw6Gz7U6QCsG35fqnPCEA
	 FnH4Eqwg5SHGWjtKVULPk5EwlN0utT1jiOOKyQURj0czHTrIGS+iuhH+A4zeOB8tCl
	 rEwfZ1D3rZymmU/+l5QGmboLmcPDfdrmcafF6vaDmvA/bsnItmFaGjM7jVHmnRRObD
	 7J1vbX8rxRI9g==
Date: Wed, 3 Sep 2025 18:38:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aLhg2Jli0KUe-CXC@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903125620.GG470103@nvidia.com>

On Wed, Sep 03, 2025 at 09:56:20AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 09:30:17AM +0300, Mike Rapoport wrote:
> > +int kho_preserve_vmalloc(void *ptr, phys_addr_t *preservation)
> > +{
> > +	struct kho_vmalloc_chunk *chunk, *first_chunk;
> > +	struct vm_struct *vm = find_vm_area(ptr);
> > +	int err;
> > +
> > +	if (!vm)
> > +		return -EINVAL;
> > +
> > +	/* we don't support HUGE_VMAP yet */
> > +	if (get_vm_area_page_order(vm))
> > +		return -EOPNOTSUPP;
> 
> This is a compatability problem.. Should have some way to indicate
> that future kernels have an incompatible serialization so restore can
> fail..

We can add version or flags to kho_vmalloc_chunk, e.g. make it

struct kho_vmalloc_hdr {
	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
	unsigned int total_pages;	/* only valid in the first chunk */
	unsigned short version;		/* only valid in the first chunk */
	unsigned short num_elms;
};

I'm thinking about actually adding support for HUGE_VMAP for the next
resping, but version/flags seems useful anyway.

> > +	chunk = new_vmalloc_chunk(NULL);
> > +	if (!chunk)
> > +		return -ENOMEM;
> > +	first_chunk = chunk;
> > +	first_chunk->hdr.total_pages = vm->nr_pages;
> > +
> > +	for (int i = 0; i < vm->nr_pages; i++) {
> > +		phys_addr_t phys = page_to_phys(vm->pages[i]);
> > +
> > +		err = kho_preserve_phys(phys, PAGE_SIZE);
> 
> Don't call kho_preserve_phy if you already have a page!

Ok, I'll add kho_preserve_page() ;-P.

Now seriously, by no means this is a folio, so it's either
kho_preserve_phys() or __kho_preserve_order(). I don't mind switching to
latter, but I really see no point doing it.

> We should be getting rid of kho_preserve_phys() :(

How do you suggest to preserve memblock?

> Jason

-- 
Sincerely yours,
Mike.

