Return-Path: <linux-kernel+bounces-827820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D048DB93328
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 22:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989AF2A678B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2342D77EF;
	Mon, 22 Sep 2025 20:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vHd0iS2j"
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38884369A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 20:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758572185; cv=none; b=P0A4GijokBi/4g7y3rvZyFKlSwonDHChG8wHaCdpebNfFJlmhpaNcDcoqeLLklhpIt5T8yjb+kyWZhnd9XDitk4bxvLIpacCzE0IDKFj+b9ZauRR043GLdPZq7IzwoSaAEHO8mZt3Yo8IqtDMWezI+PYyJHSBM9BfxvX/FkWI9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758572185; c=relaxed/simple;
	bh=ny6Gpk4xEzckUhsyWX45ioKt9Tl3vIfc8NfEwD01two=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHc7b/Ruk99vVVWgFSbVhaEus8MZRzSwK2/KZ4RGmh2SWE5EZBuFIUWCQlFMljVpSo+yGoTugkwLH9r8g8plQVjjhpaf2JTBXR0yLuyIZPF/lTKlFtPBb/lRqk5YVtJvYPAbQ6MZrbywXNR52pO2q9d3Rva3kS3zJINtKIEauvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vHd0iS2j; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Sep 2025 13:16:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758572180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cfbpfmf+u0YSkEaM2WaewkLs4L853hup/SL8tvoIOj0=;
	b=vHd0iS2jU6HG03fy54QFIns8EroOG0GUm3MOmM2EfzIXbyIG1QRsCPmCmxD0gLIv7YbQdj
	i9vh9Q2luRZ6bRYF7FQ3p3fhhwn5D7baz9n0IOvs97ZKzgJKYGx6zDNJx9Vf3Tx2z4rw0r
	SDbf0uocHppdWX1klC6XiS5cbzOz38U=
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
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/5] mm/rmap: mlock large folios in try_to_unmap_one()
Message-ID: <z3yzhd3c7qw4ig4ekh3mq665zws5aafab7lgqpvytzg5wxv363@ojmp7qdsl5vc>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-4-kirill@shutemov.name>
 <27wxlfhnkxaat57lzyzlpo66vse3jjhp422ziswbl4oyjnamif@2jx25dwgkame>
 <pdorb325r7fatuclbaw4zriieve4tphlrox6w36fo4mlmzgcx7@kdsf4pwqs2wy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pdorb325r7fatuclbaw4zriieve4tphlrox6w36fo4mlmzgcx7@kdsf4pwqs2wy>
X-Migadu-Flow: FLOW_OUT

On Mon, Sep 22, 2025 at 10:51:35AM +0100, Kiryl Shutsemau wrote:
> On Fri, Sep 19, 2025 at 02:27:40PM -0700, Shakeel Butt wrote:
> > On Fri, Sep 19, 2025 at 01:40:34PM +0100, Kiryl Shutsemau wrote:
> > > From: Kiryl Shutsemau <kas@kernel.org>
> > > 
> > > Currently, try_to_unmap_once() only tries to mlock small folios.
> > > 
> > > Use logic similar to folio_referenced_one() to mlock large folios:
> > > only do this for fully mapped folios and under page table lock that
> > > protects all page table entries.
> > > 
> > > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > > ---
> > >  mm/rmap.c | 23 ++++++++++++++++++++---
> > >  1 file changed, 20 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/mm/rmap.c b/mm/rmap.c
> > > index 3d0235f332de..482e6504fa88 100644
> > > --- a/mm/rmap.c
> > > +++ b/mm/rmap.c
> > > @@ -1870,6 +1870,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> > >  	unsigned long nr_pages = 1, end_addr;
> > >  	unsigned long pfn;
> > >  	unsigned long hsz = 0;
> > > +	int ptes = 0;
> > >  
> > >  	/*
> > >  	 * When racing against e.g. zap_pte_range() on another cpu,
> > > @@ -1910,10 +1911,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> > >  		 */
> > >  		if (!(flags & TTU_IGNORE_MLOCK) &&
> > >  		    (vma->vm_flags & VM_LOCKED)) {
> > > +			ptes++;
> > > +			ret = false;
> > > +
> > > +			/* Only mlock fully mapped pages */
> > > +			if (pvmw.pte && ptes != pvmw.nr_pages)
> > > +				continue;
> > > +
> > > +			/*
> > > +			 * All PTEs must be protected by page table lock in
> > > +			 * order to mlock the page.
> > > +			 *
> > > +			 * If page table boundary has been cross, current ptl
> > > +			 * only protect part of ptes.
> > > +			 */
> > > +			if (pvmw.flags & PVMW_PGTABLE_CROSSSED)
> > > +				goto walk_done;
> > 
> > Should it be goto walk_abort?
> 
> I already have to set ret to false above to make it work for partially
> mapped large folios. So walk_done is enough here.

Indeed and I missed that. What do you think about adding a comment when
setting ret to false? Everywhere else we are jumping to abort for
scenarios which needs to break the rmap walk loop but here we need to
keep counting the ptes for mlock handling. Anyways it's just a nit.

Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>

