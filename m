Return-Path: <linux-kernel+bounces-832676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497E6BA0126
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 16:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 737A619C26E9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9C02E0925;
	Thu, 25 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIupcSCT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C772DCF77
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811861; cv=none; b=FMxNInp0qUpuWEkr3ggTvfzC4fepoqamglJO2grpFuuKcxUN3DDMbztXyL6ALzMZMyB77pOwMQbMLhoSS4fTXuiZ8qxVQqOm8aeEHN78fLpwUgksp4YzSRlBlheqAxVFxqsmJX8A3c28FlUD0ZH5pXl1Byn2KaLJBJvLPIH2Wwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811861; c=relaxed/simple;
	bh=DG2szuPxxWOHgNT641pBDumcSqXth3pE37RvglgNcHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Je+2S42McetQrDKnJ7UDMtBtW0eeEoiUuRKqq1cSGKKuy3st+OHRAVE3W5NOyMzZB/EgefmZA3bUbVRo4ixa6tlQ4q5fvonxldG7uTFZ0Brx5nGYGNYbI2OXkCh5dSL2JMa1ScWRl/6nk2JlTyjtBEIU8HW3EyaY5hRgn9AO50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIupcSCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53405C4CEF0;
	Thu, 25 Sep 2025 14:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758811860;
	bh=DG2szuPxxWOHgNT641pBDumcSqXth3pE37RvglgNcHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIupcSCTrVT0YiVHqMeNRGIe/vr4LAnwufvWyVQeLdEWcQwSFVC2jTtzVOn3K9btF
	 omG8wlNRw5mDIWRVhKDd5bmAeX/nRPN++AytukjHVzHmIdqd3iMEzu4R1Y0ExOXnLF
	 VmFIdOmH7Kv35IVJgOShYC/JYj8b4MSf4HrmePnC8ywzvjZUj7oF5C5gBjVRDWCq73
	 N7uaKlPORfA0S9bpy4Tj+cBnOcNQut+e5rNeUMrzRCTdwzzCshobDgJDU1ila4SxrR
	 S+0w79fE1fKKhWzORLWq++nfH+8LE6kmOrCrP7CvqBMysOuua3P4TzzBNXj922B2d2
	 1yCq4SNlcdCMg==
Date: Thu, 25 Sep 2025 17:50:53 +0300
From: Mike Rapoport <rppt@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Alexander Potapenko <glider@google.com>, akpm@linux-foundation.org,
	david@redhat.com, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, elver@google.com, dvyukov@google.com,
	kasan-dev@googlegroups.com, Aleksandr Nogikh <nogikh@google.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Message-ID: <aNVWzaxq82UI3wWO@kernel.org>
References: <20250924100301.1558645-1-glider@google.com>
 <20250925123759.59479-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925123759.59479-1-sj@kernel.org>

On Thu, Sep 25, 2025 at 05:37:59AM -0700, SeongJae Park wrote:
> Hello,
> 
> On Wed, 24 Sep 2025 12:03:01 +0200 Alexander Potapenko <glider@google.com> wrote:
> 
> > When KMSAN is enabled, `kmsan_memblock_free_pages()` can hold back pages
> > for metadata instead of returning them to the early allocator. The callers,
> > however, would unconditionally increment `totalram_pages`, assuming the
> > pages were always freed. This resulted in an incorrect calculation of the
> > total available RAM, causing the kernel to believe it had more memory than
> > it actually did.
> > 
> > This patch refactors `memblock_free_pages()` to return the number of pages
> > it successfully frees. If KMSAN stashes the pages, the function now
> > returns 0; otherwise, it returns the number of pages in the block.
> > 
> > The callers in `memblock.c` have been updated to use this return value,
> > ensuring that `totalram_pages` is incremented only by the number of pages
> > actually returned to the allocator. This corrects the total RAM accounting
> > when KMSAN is active.
> > 
> > Cc: Aleksandr Nogikh <nogikh@google.com>
> > Fixes: 3c2065098260 ("init: kmsan: call KMSAN initialization routines")
> > Signed-off-by: Alexander Potapenko <glider@google.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> [...]
> > --- a/mm/mm_init.c
> > +++ b/mm/mm_init.c
> > @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char *tablename,
> >  	return table;
> >  }
> >  
> > -void __init memblock_free_pages(struct page *page, unsigned long pfn,
> > -							unsigned int order)
> > +unsigned long __init memblock_free_pages(struct page *page, unsigned long pfn,
> > +					 unsigned int order)
> >  {
> >  	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
> >  		int nid = early_pfn_to_nid(pfn);
> >  
> >  		if (!early_page_initialised(pfn, nid))
> > -			return;
> > +			return 0;
> >  	}
> 
> I found this patch on mm-new tree is making my test machine (QEMU) reports much
> less MemTotal even though KMSAN is disabled.  And modifying the above part to
> be considered as free success (returning '1UL << order') fixed my issue.
> Because the commit message says the purpose of this change is only for
> KMSAN-stashed memory, maybe the above behavior change is not really intended?
> 
> I'm not familiar with this code so I'm unsure if the workaround is the right
> fix.  But since I have no time to look this in deep for now, reporting first

With DEFERRED_STRUCT_PAGE_INIT we count totalram_pages in
memblock_free_all() but actually free them in deferred_init_memmap() and
deferred_grow_zone().

So returning '1UL << order' is a correct workaround, but the proper fix
should update totalram_pages in the deferred path IMHO.

-- 
Sincerely yours,
Mike.

