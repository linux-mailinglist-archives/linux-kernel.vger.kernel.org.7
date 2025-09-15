Return-Path: <linux-kernel+bounces-816744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A46B577DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8252A162CD9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8192FE581;
	Mon, 15 Sep 2025 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="hC44NQlc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k3XJlKRf"
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54802FFDF8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757934944; cv=none; b=grh71BM+5WxOu35gCA56fbmT3gzvdDGPsnTvfXpWpgCCbWBnBs76TA/hReByIuapgNL/hjqlSOqyeLUuxJ0+dukO0lxN1MSzD/gAONOeDcUhVzpSmIdWSGb7H9GkSM1/MZwlmmMJ9kRi45xvnyibaUh4lNDQP1r3QEGAuzfxtGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757934944; c=relaxed/simple;
	bh=+v9vtWddxxoPrWmSwq+YPSZb80cwYRi99XZ+J3PHKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgkmfTodD25SrywslNayhjRokJYkhRhDQzmwGRe73YBGsl9gTwyGG/JFJ5J3mP8Qx2NNZT30SKWgjDiVmVx88/jDQVEoRe0diDJQn5nMV+xP8MFcm2jkqlpLOaML6XKuFgrvybGHoZ2TpPagAl82f1PjPb9gF4yKF/vZeFg6ru0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=hC44NQlc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k3XJlKRf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 145651D00125;
	Mon, 15 Sep 2025 07:15:41 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 15 Sep 2025 07:15:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1757934940; x=
	1758021340; bh=IAndtAUsCCZ4OZ0O3J2t17ZV8RyUxpOpU+beMolgAwA=; b=h
	C44NQlcRgaO5C1gbFzTIB/cQATSaNmnUyYFHKP3zUvKw500CbP0GKAOHBsPanR8Z
	7BfVp1uc8BnszR7lz14CoV3NodQE5UGZrHdxHJZD/t6Hg/pJO5JFYAkdbPyGyWj0
	cNDmtpTzT0/O2qVzadbRtYr3Q068S7Y+6UGm6ayRKF7Q4APLDXg0/UB29lYPDjdW
	BRNPTyJq3B17H3enK5djdnZUEgOBWvz7m15yq0unGYru9fecqFfiuemoyzsQpLrH
	vYeDn9qCNTeKTOdOAMWHxyUKvPYRWynt2ElAVUSOniDqxEY6hJEQ0vYKEsr7foAd
	nqPTqDd3Gjo/fgfcEbVDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757934940; x=1758021340; bh=IAndtAUsCCZ4OZ0O3J2t17ZV8RyUxpOpU+b
	eMolgAwA=; b=k3XJlKRfvMlMnloZhUcGIiFOqwEzPSP3h96gDL9U0DdZUAoe7wA
	ds6pq+2umkMUVOVQPuR7P736pHGVkVHOrj6OU/TF4CfYlDWcbIE4E8Z/hUwICG2I
	CWJM8msxG+EDadSrb19BqHSWm0mI6tyaZsqq4nJkNyDhd3FjXkVmUZpXuy6pebX5
	jg+K/rzUH5acyxT2vtGrmcaH8/35Pz9S976F40/nLHMCgp7H7wAN5X5CRFqDc/Pq
	ArREyf4Cpqhkxi0VTck/8eWIsB/jHRVPGm1ehVZBNceMn3uL9vIXM75xaRfxlsLY
	aE+KAUxmQiX8N1zwA8BKFiBeQ2Lu2bwC/9w==
X-ME-Sender: <xms:W_XHaIiDK23ijgrb8XDIb1ol2dJAWnNIS7N-u-87wEwVtZGsG3VGhQ>
    <xme:W_XHaM5w0A3MlWeOJp6gvUrmAKoDDR3sN2vqvzhTplckPcs0xRHxnk8OFy5xG0pFX
    mRbAnsB1NVxO_1EONw>
X-ME-Received: <xmr:W_XHaI4s3TpC-L1ijhL35lCkJJPYGskiUisdFjnnMyyWhxNNzLcBqicB-WDSCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvrdhjrghinhesrghrmhdrtg
    homhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhorh
    gvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepiihihies
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhinhhugi
    drrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhr
    rggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomhdprh
    gtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomh
X-ME-Proxy: <xmx:W_XHaCHf48sToTGooULKQeoQMfXVYDFtvwqxTwsjhtuZkcYRDyiYYQ>
    <xmx:W_XHaOy4Mtreqw7ddoygYcWtbOAYX8rM5s-am4F-OBLk4FeBn4rGTw>
    <xmx:W_XHaK3qPesJv7xVvmvf16sMr-9pXxDUxoZLQldewGkCRN__H3bI2w>
    <xmx:W_XHaJOIUoAkR5WzlYktBzuHpb58CYeYtAclOrLSJMepA2xYoWCTuQ>
    <xmx:XPXHaNy3nS20Asj_b-1W3W2gegClHfquAwM2V7rlds2kCnZVaZyCxUMA>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 07:15:38 -0400 (EDT)
Date: Mon, 15 Sep 2025 12:15:36 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Barry Song <baohua@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
Message-ID: <3zfpaowb4owhpyseoiqj3vxo2e2nszynoun2ubsm2oqw67i6sr@hxtogb4t3npl>
References: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
 <a3ee891f-a025-4a71-8e7c-af5b52a8484f@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ee891f-a025-4a71-8e7c-af5b52a8484f@arm.com>

On Sun, Sep 14, 2025 at 12:56:13PM +0530, Dev Jain wrote:
> 
> On 12/09/25 10:28 pm, Kiryl Shutsemau wrote:
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
> 
> Thanks.
> 
> Besides this patch, the label maybe_install_pmd is misleading -
> SCAN_PMD_NONE means that the pmd table exists, just that the pmd
> entry is none, so the pmd is already installed.

That's never ending confusion between PTE/PMD/P?D entry and table.
Addressing it is out of scope of the patch :P

> Along with this,
> the argument bool install_pmd should likewise be install_huge_pmd.

Well, if you rename install_pmd to install_huge_pmd it will overshadow
the install_huge_pmd() function. And the label name is not a problem in
my view.

> 
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > ---
> >   mm/khugepaged.c | 25 ++++++++++++++++++++++++-
> >   1 file changed, 24 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index b486c1d19b2d..9e76a4f46df9 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1488,6 +1488,28 @@ static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
> >   	return SCAN_SUCCEED;
> >   }
> > +static int install_huge_pmd(struct vm_area_struct *vma, unsigned long haddr,
> > +			    pmd_t *pmd, struct folio *folio)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	pgd_t *pgd;
> > +	p4d_t *p4d;
> > +	pud_t *pud;
> > +
> > +	pgd = pgd_offset(mm, haddr);
> > +	p4d = p4d_alloc(mm, pgd, haddr);
> > +	if (!p4d)
> > +		return SCAN_FAIL;
> > +	pud = pud_alloc(mm, p4d, haddr);
> > +	if (!pud)
> > +		return SCAN_FAIL;
> > +	pmd = pmd_alloc(mm, pud, haddr);
> > +	if (!pmd)
> > +		return SCAN_FAIL;
> > +
> > +	return set_huge_pmd(vma, haddr, pmd, folio, &folio->page);
> > +}
> > +
> 
> For the SCAN_PMD_NONE case, we are unconditionally traversing the pagetables
> now which is not needed. How about, in set_huge_pmd(), we pass a boolean install_pmd,
> and at the start of the function, call install_pmd() which will do the traversal
> and the pmd_alloc()? That will also make it crystal clear that in the SCAN_PMD_NULL
> case, we are first installing the PMD table and then setting it to huge. Right now
> the distinction between the two cases is not clear.

I just realized that my install_huge_pmd() doesn't use pmd that is pass
in. And looking at code again, I think it is better to integrate the
page table allocation directly into set_huge_pmd().

See the patch below. I will submit it as v2, if there's no objections.

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b486c1d19b2d..986718599355 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1472,15 +1472,32 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
 static int set_huge_pmd(struct vm_area_struct *vma, unsigned long addr,
 			pmd_t *pmdp, struct folio *folio, struct page *page)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	struct vm_fault vmf = {
 		.vma = vma,
 		.address = addr,
 		.flags = 0,
-		.pmd = pmdp,
 	};
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pud_t *pudp;
 
 	mmap_assert_locked(vma->vm_mm);
 
+	if (!pmdp) {
+		pgdp = pgd_offset(mm, addr);
+		p4dp = p4d_alloc(mm, pgdp, addr);
+		if (!p4dp)
+			return SCAN_FAIL;
+		pudp = pud_alloc(mm, p4dp, addr);
+		if (!pudp)
+			return SCAN_FAIL;
+		pmdp = pmd_alloc(mm, pudp, addr);
+		if (!pmdp)
+			return SCAN_FAIL;
+	}
+
+	vmf.pmd = pmdp;
 	if (do_set_pmd(&vmf, folio, page))
 		return SCAN_FAIL;
 
@@ -1556,6 +1573,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	switch (result) {
 	case SCAN_SUCCEED:
 		break;
+	case SCAN_PMD_NULL:
 	case SCAN_PMD_NONE:
 		/*
 		 * All pte entries have been removed and pmd cleared.
-- 
  Kiryl Shutsemau / Kirill A. Shutemov

