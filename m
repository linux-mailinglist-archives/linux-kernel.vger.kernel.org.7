Return-Path: <linux-kernel+bounces-797243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 957F3B40DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 21:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381651B62D3E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 19:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B12DEA89;
	Tue,  2 Sep 2025 19:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UNLXeJ8A"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148B2E3B03
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756841419; cv=none; b=U4xNVbIuyLoIneoxBb7bit/8a33Hfz36A4X/a8TntYbD5r5/yV6UPDP8RMyY3/cqEkerwChS15o7xMZBs3+bYevJC3fvHwAF9SCK77ciArs2m14WechSRcURc4cmVpmtQheo466Bubno/KhAynl8p/1vOW3fRa5z0+Q3NMtp0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756841419; c=relaxed/simple;
	bh=fupBjZxcq5Zwt5Fq9rMIabW0si1G+l/BpGDW7io9e3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCG2IxPAjBK7dEVp+unSos3ht+jCPD7Z6d1x3r0tkKaiD8W3t83IsAtcxwXWivAwjSvIRQMknidS+xdw8zujlT+YYt+yaqolwVUgWvcW+ptnftl3U/8DitV4TcICa0Nr0j81MPWHsfa5N8g3Ep1vZV2WFhtD1TwO4/FhVM5HrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UNLXeJ8A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wQ2JYDet53gdK0aqEOI2kBipw8oqUhM8TH52wl6cYD0=; b=UNLXeJ8ArAZy7uMSnPyVoaF1Ek
	mCL8GV2ut+oh1T7sQtvboBDBsn+LMMJOqJZKimoRw57ZVqBeAz6YMbAff97eN/cD2NoDw52AITl7W
	UeeHw7xJwms28rMEDtKiHDNMkGMHLzBthUWqJYRSMpQVtJdy0MfWB5NHXTCpDMw8Ph8+eIyZSmmmb
	hN8oX8ebXTsRqkBy/jjK5E7D2lDcwpHHQu0SEh6kNglayorSQfjedLgli/KRvCpyIbXQYyQ2EUHJ4
	E5fIOYaV7bSw6BJqgmowlorP5lz8YD3spV4yBnb1ZulNjxq8u12yeBi2iY8osQZfhYQvX8feUHqta
	3OMJToJA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWhr-0000000Abl6-0Qho;
	Tue, 02 Sep 2025 19:30:15 +0000
Date: Tue, 2 Sep 2025 20:30:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH] mm: Fix kernel stack tagging for certain configs
Message-ID: <aLdFxtVpOX-qf0qc@casper.infradead.org>
References: <20250902175903.1124555-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902175903.1124555-1-vishal.moola@gmail.com>

On Tue, Sep 02, 2025 at 10:59:03AM -0700, Vishal Moola (Oracle) wrote:
> There are 3 cases where kernel pages are allocated for kernel stacks:
> CONFIG_VMAP_STACK, THREAD_SIZE >= PAGE_SIZE, THREAD_SIZE < PAGE_SIZE.
> These cases use vmalloc(), alloc_pages() and kmem_cache_alloc()
> respectively.

I missed that the third case existed ...

> In the first 2 cases, THREAD_SIZE / PAGE_SIZE will always be greater
> than 0, and pages are tagged as expected. In the third case,
> THREAD_SIZE / PAGE_SIZE evaluates to 0 and doesn't tag any pages at all.
> This meant that in those configs, the stack tagging was a no-op, and led
> to smatch build warnings.

I didn't see those smatch warnings.  Were they cc'd to the mailing list?

> We definitely have at least 1 page we want tagged at this point, so fix
> it by using a do {} while loop instead of a for loop.

We can't do this.  Pages can only have one type at a time.  Since
they're allocated from slab, they have PGTY_slab.  This will lead to
a warning at runtime:

        VM_BUG_ON_PAGE(data_race(page->page_type) != UINT_MAX, page);   \

But for our purposes (trying to figure out how fragmented the vmap
stack is making the memmap), we don't need to do this accounting.
These pages are already being allocated from slab, and slab allocates
naturally aligned, so we can skip all of this for these configurations.

(now I'll go back and reply to David's mail from the 21st which I
missed)

