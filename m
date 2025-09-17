Return-Path: <linux-kernel+bounces-820501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C36D3B7C6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4D616CAA3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1452345724;
	Wed, 17 Sep 2025 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hFl85Ne2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JdN24G+t"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BE954262
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758105795; cv=none; b=CBVRKpW9gLKMGB2IfXGDSlSmvzwO0f98mUQmVVzlfzsegJsn2VW4TqHOyge1XnWW/niH5rU3yXNE3/RPDJuJLNWgUPPtzt4kQn2UYeeooFky9aTvzD2PTByEsfht5uVUI7DR8bNlO7UXaNKX8vLd1H/+vHRKV5mXjR3mRtvsvJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758105795; c=relaxed/simple;
	bh=xVUHSQEV9R1i8qu4QCvBkFYy7lo2qBzQfwY2XYBsUJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boelGVFfc/MCeIT7dMPJ4LOwvN+xI1ivglrXLfoohrAviSvqnF2H4UmjwAfQw1uhdp/6WXQlX1unYwb/N0WPmQW93y7FRlaJJY0yVDR9UPAMk66Wmf7a7pemXJsjagSuvCYgQaAogxxZtGdMm8iSRlg+flyKKcP4ijCPrl8Ldn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hFl85Ne2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JdN24G+t; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F16C14001DE;
	Wed, 17 Sep 2025 06:43:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 17 Sep 2025 06:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758105792; x=
	1758192192; bh=74X70xzEhBM0tW2lzuA0ESFpEqnjRQx9KPWr7O/CNbQ=; b=h
	Fl85Ne2Dxf0+e1Zeyn7iSeFwbs1zURwloVh9+uV8sDF5i1ken+c3N4OhSMEE4fQg
	Rk73PcExtwPGu218/Bbyf4cmiYoD18pMdXqedlDABkGssmJ25oAEZutDusHh3cd3
	E70xlH9tnyS/RfTocqX1vNRl1qyvU+Yo/0o6ln4GwEZLstIPDTO2pavC5/kusANU
	xmRNJIutJ5xqpqXfENe6L+5llIO1dQfXBUQS+iPBiBeW83Q24RZ3sTWP6iHBWGDg
	Q4Z9fIv2mOejCKC3w7mjmAQnk5b8voSGGciJRpicNECWi/sgrtmHOsKNZkLuqS68
	29uBu41oNwNM7SHHE9kVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758105792; x=1758192192; bh=74X70xzEhBM0tW2lzuA0ESFpEqnjRQx9KPW
	r7O/CNbQ=; b=JdN24G+t3tAtKEaF3xy9/usv8GaFHeYOqrUsOtCLEG6H2AVjKO/
	z/ppztjGiIb2oTuLYhiWs+2ju8J1UsnTxCuiQbv9++JILxhJT7qoqX4OvGRKdCb5
	Y/x5WMYXYfptlZ4UZqJZmavoaPQUTghqltZ1eJ7Z05RxKczDbWUmy+O2UmTscZf/
	cemk+T/thmz/ZDwEygZ0gVZSVF9fWeC42+dv7O02TIlE7m5xdGmNmGuLP0AumUJu
	zI8cie3GJqgZ8AZ4daWsLEjU70a6WzrXYPOypYn8SScKkXCmbzhHw6Hu7VVFoWyS
	BFHPfaAgeYkkDxZQDF6SqlFVAC0zNDvbyRQ==
X-ME-Sender: <xms:v5DKaBRX0yS8FD8qt-AC-V9tRJXQSOqPMmBBXmawkd6AGirEwgFPOw>
    <xme:v5DKaGpLZXUvscnwH8ZoLoYQu60UwnreKcKWMpLjuSyhpIZUoznDQP5YKSEwe0M2I
    2plbZmz-0lK9T1uQCA>
X-ME-Received: <xmr:v5DKaPpoduEQ_2ZSaPZQhsv35CIYWOQYDw7kUpOzkkw_8FNKShG1wLRys9Qjjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghniihordhsthhorghkvg
    hssehorhgrtghlvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhn
    uggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpd
    hrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsggrohhlihhn
    rdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlihgrmh
    drhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtg
    homhdprhgtphhtthhopeguvghvrdhjrghinhesrghrmhdrtghomh
X-ME-Proxy: <xmx:v5DKaB2h-8I5FINeZ6DBBIlYuR_mhdfk2nOhP7ciKrwWZxmBlZRgdw>
    <xmx:v5DKaDi56MNn6yD1nQTgCCscQozH7ovo2yNCKXIqJT2yUCfn6qO_Dw>
    <xmx:v5DKaAlTECDEQqK1XmSv90WalG12KPOQqFTlbRQzWHt-_cfNQyqAvA>
    <xmx:v5DKaL-fewQ-QpdswZuFxLosxSXD-E6n6etTZSaSiz37hzJuDd1vog>
    <xmx:wJDKaDk6zs0RS8-cvQBQ7seUyblylVYSAniu0Q5CbRWqR30Q8LGNwC2i>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 06:43:10 -0400 (EDT)
Date: Wed, 17 Sep 2025 11:43:08 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp()
 on SCAN_PMD_NULL
Message-ID: <l6yjv4b2xvcwgpq5q3esyat56jdfj7flcokbqptsxlzgesrwe2@sxxzcp477ldi>
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
 <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>

On Tue, Sep 16, 2025 at 10:54:12AM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 02:52:53PM +0100, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> >
> > MADV_COLLAPSE on a file mapping behaves inconsistently depending on if
> > PMD page table is installed or not.
> >
> > Consider following example:
> >
> > 	p = mmap(NULL, 2UL << 20, PROT_READ | PROT_WRITE,
> > 		 MAP_SHARED, fd, 0);
> > 	err = madvise(p, 2UL << 20, MADV_COLLAPSE);
> >
> > fd is a populated tmpfs file.
> >
> > The result depends on the address that the kernel returns on mmap().
> > If it is located in an existing PMD table, the madvise() will succeed.
> > However, if the table does not exist, it will fail with -EINVAL.
> >
> > This occurs because find_pmd_or_thp_or_none() returns SCAN_PMD_NULL when
> > a page table is missing, which causes collapse_pte_mapped_thp() to fail.
> >
> > SCAN_PMD_NULL and SCAN_PMD_NONE should be treated the same in
> > collapse_pte_mapped_thp(): install the PMD leaf entry and allocate page
> > tables as needed.
> >
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> 
> There was a v1 with tags, you've not propagated any of them? Did you feel
> the change was enough to remove them?

I moved code around and was not comfortable to carry tags over.

> Anyway, LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> > ---
> >
> > v2:
> >  - Modify set_huge_pmd() instead of introducing install_huge_pmd();
> >
> > ---
> >  mm/khugepaged.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b486c1d19b2d..986718599355 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
> >  static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> >  			pmd_t *pmdp, struct folio *folio, struct page *page)
> >  {
> > +	struct mm_struct *mm = vma->vm_mm;
> >  	struct vm_fault vmf = {
> >  		.vma = vma,
> >  		.address = addr,
> >  		.flags = 0,
> > -		.pmd = pmdp,
> >  	};
> > +	pgd_t *pgdp;
> > +	p4d_t *p4dp;
> > +	pud_t *pudp;
> >
> >  	mmap_assert_locked(vma->vm_mm);
> 
> NIT: you have mm as a local var should use here too. Not a big deal though
> obviously...

Do you want v3 for this?

> >
> > +	if (!pmdp) {
> > +		pgdp = pgd_offset(mm, addr);
> > +		p4dp = p4d_alloc(mm, pgdp, addr);
> > +		if (!p4dp)
> > +			return SCAN_FAIL;
> > +		pudp = pud_alloc(mm, p4dp, addr);
> > +		if (!pudp)
> > +			return SCAN_FAIL;
> > +		pmdp = pmd_alloc(mm, pudp, addr);
> > +		if (!pmdp)
> > +			return SCAN_FAIL;
> > +	}
> > +
> > +	vmf.pmd = pmdp;
> >  	if (do_set_pmd(&vmf, folio, page))
> >  		return SCAN_FAIL;
> >
> > @@ -1556,6 +1573,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
> >  	switch (result) {
> >  	case SCAN_SUCCEED:
> >  		break;
> > +	case SCAN_PMD_NULL:
> >  	case SCAN_PMD_NONE:
> >  		/*
> >  		 * All pte entries have been removed and pmd cleared.
> > --
> > 2.50.1
> >

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

