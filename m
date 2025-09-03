Return-Path: <linux-kernel+bounces-799309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A4FB429D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 144FA4E4913
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3846C362098;
	Wed,  3 Sep 2025 19:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adGL9oZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ED2352FF3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927510; cv=none; b=Xz2bV1dIBaegwlWnyDm8EWNdFwTIsxPn8zclEG2l3cscy4k8xhTeCZOtDEvBEUnu0EkSDpJ0A7vd+d3qtNC+QRe0Gsit25DQG+1dlO4I4VKzK13U4duuC6KExGlytALg6zQpDHY+mcx3sgdUmqXkoTQcCYU0BKtC6u76MZtIUzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927510; c=relaxed/simple;
	bh=NBbsDMjSKsI2AUxX91Gb4WbI92rKyuNDqjM76TYzfBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfuKySrLd1o8cw0o8ziTkA9oKjs6NKk/xfu3R3Ghotvcaat5tOa3gKFni15JT2kw0J6BEwJQo6ZEyFc2nXt9M9oaxNXPPJeiCckzeUbUVqhdW5G4V5H0DTq2PKqa2OglGuekykwm44orWwMFJle3EaXMv82IOvxFrj2m1ZgZeKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adGL9oZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA59EC4CEE7;
	Wed,  3 Sep 2025 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927510;
	bh=NBbsDMjSKsI2AUxX91Gb4WbI92rKyuNDqjM76TYzfBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=adGL9oZgYPs04NhMzOYDFe9H2zXCIScCmhp8FCYjAVCIaThHiJXOKPyFhhI426ebE
	 k1bk9ze6Ty/eCH+cYXBYDRWSUo2bNGShsPuDahO15R/7AM35F+xpGfrHCIEUgCqrzv
	 y0Iup37vzMUHfXI4vtdfimIlD1BKXSnwdfF5tBXXe7IVS/eBu8QkYieuXYB2jPNdOo
	 8w7+0baLFy4wDDUWyccec8EJ8oxOHuyWAvPfOxyAbH4GSxG0k+a+0AofpgoYzsaQtl
	 kzpeMlLyMrc6gOFAJBSyYLqQnrCguEuLzG10UvjAZxXT/sq8OUwW7bqAWeviAC5ejz
	 UFSY/7caqab2g==
Date: Wed, 3 Sep 2025 22:25:02 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aLiWDl3sq3RTkdfJ@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
 <20250903170631.GK470103@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903170631.GK470103@nvidia.com>

On Wed, Sep 03, 2025 at 02:06:31PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 06:38:00PM +0300, Mike Rapoport wrote:
> > > Don't call kho_preserve_phy if you already have a page!
>  
> > Now seriously, by no means this is a folio, 
> 
> It really is. The entire bitmap thing is about preserving folios/page
> which are basically the same thing ATM. folio is the prefered type for
> what used to be compound pages.
 
> As Matthew moves ahead it will effectively become preserving
> memdescs. This may even start to happen this year..
> 
> Every memdesc has a type, so when ever the physical pages are restored
> KHO will need to recreate the struct page and page->memdesc with the
> correct values, including the memdesc type code and any memdesc
> allocation that Matthew plans.
> 
> Meaning everything should be struct page or folio based at this API
> level, and restore functions should be logically paired with the
> allocation functions that created the memory in the first place.
> 
> vmalloc() is calling alloc_pages_bulk_node_noprof() to allocate the
> memory, so the restore of that memory should also have a 'kho restore
> page' type of name that clearly refers back to the allocator it pairs
> with.

I'm actually all for having a single entry point
kho_{preserve,restore}_page() that will do

	if (folio)
		do_folio()
	else if (vmalloc)
		do_vmalloc()

etc.

It seems that our major disagreement is about using 'folio' vs 'page' in
the naming.

In my view calling everything 'folio' is a bad idea as we are moving fast
from Ottawa interpretation to New York interpretation of folio.

I'd rather stick to the good old 'page' and when the time comes we can
's/page/memdesc/g' supposing Matthew actually plans for it.

This way we won't need to handle the fallback from divorce of folio from
page. This indeed is less relevant to KHO, but there are a lot of
folio_alloc() in LUO and PCI patches that will have to be changed to a
different allocation apparently this year.

> In the more general case this should be setting the cgroup and
> charging it as well.

Yes, eventually :)

> > How do you suggest to preserve memblock?
> 
> Does the memory have a struct page? Then it should be a preserved
> folio list so you get back struct pages in the right state for what

page list you mean ;-)

> memblock is doing. Someday that will turn into some specific memdesc
> type and so on.

> If it doesn't have a struct page then it shouldn't be in the bitmaps
> at all.

There is a struct page for everything that's memblock_alloc()ed. And we can
do page list, but for large  physically contiguous allocation it does not
make sense. 

I'd rather replace kho_preserve_phys() with kho_preserve_memblock() and add
a restore counterpart to properly set the struct pages for it which we lack
now.

> Jason

-- 
Sincerely yours,
Mike.

