Return-Path: <linux-kernel+bounces-826995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE72B8FD98
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0646A2A0881
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E6B2F657A;
	Mon, 22 Sep 2025 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="OKwHWU7Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hy6krAsS"
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2F21C163
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758534703; cv=none; b=DurRxF8H5Xjl73/Dpqo54xFRStA1MdE/qpoD/cfSZVCD4t9d19aXzRj3jjeOabLCukQB+gCtEqlltY4hFUwc1h7beagV7G4TpydDsLlXelQH+oBMTu2GmehxH+nTyUQTFUWu6lN7A2w5Lj3faPpGuet6qxRo0YcQ+v2SuDhTucU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758534703; c=relaxed/simple;
	bh=M/9Yft2ysOKGoB9IbiTWmHXJAM3lPSv01CKWnRhW40E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FW6QaDvaUejSlZlShb6OMn4weR9Hv9xac6ZCNLKqTdVzARdilHMlk58Bqg7KRwAxhafiaHyVGw8IvEgGoLVa6NES6+CkSdo4xxEJJ9K/xcnm9Ivhz/m38Le/dBMtDJWBkBzz6KFI1z+0zi/zU6O2AQTPFz6nOzTJLKX7tw0XfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=OKwHWU7Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hy6krAsS; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 7BA5E1300084;
	Mon, 22 Sep 2025 05:51:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 22 Sep 2025 05:51:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758534699; x=
	1758541899; bh=SdMGCj84qIt/JChf77XrYGp40awzcdDLugRw8vVBx3I=; b=O
	KwHWU7Yv3q4NhrBceIs+ljHL9m9t5pYdT8oJ2owXs4HM3Rcn8PoyU8w0Bw+1OlLn
	mcKEC/nWCmE1OJf8YUAxwuPMc2zIGuUHY3TNLoIogSPxfb9bSwvb8+b6mhQD8epi
	xB2fncLIOGHmlUh+bQj2zC+4dAys7ij8N4Dz0hHgPcqxaInr4MzqLAaQf3kRZKHm
	BDSE9h1yKsOZU8c9Sn+hOSZ7OF3tcUtnLkVxwJ4qzRCCWA1OvxNhgKWvJHCK7HwM
	UEho5roG7S7Hjb177+mVZq5jw1X2Hc6QdwvtLXdm90GnmlpE0si/4ck5Xc7zL6Ny
	daeE3zuolTXIgQvsqVXiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758534699; x=1758541899; bh=SdMGCj84qIt/JChf77XrYGp40awzcdDLugR
	w8vVBx3I=; b=hy6krAsSQz+QbWjUjh2u+fBZKCCKZXJoufUwakmN1qHpqr7HnsL
	URGGBNRCis7Blg/VOM4Ik6npB7lTxPL9/vpbjMZ8ueDhGjzNyAjRQbuDPqWm9SWn
	wjUYs0KjUfA1ZBBSzZMzTHeLbahlkZneqHxYu9WvIPWydyVEqPvSfS6KJdFxHTXE
	QqlYcOcksyVwH5/16qtvQ1m4BJLRT7QdIG3vD8KTK4vVrEtqw0BkCR2KSp0etb8j
	++q+AfsBG85dcEjj8W0Qyf+d8qabUbcnnOfQkS+TL2LT2e/5SWCckU6S5S8JzKL4
	5O7XSPOeTkJ0th+nxAeIESgtO23/V5wMD8Q==
X-ME-Sender: <xms:KRzRaEm5MjBNqrH-4I75aOOGk1lVDVVoIVnNI8itTy9dLSl7cY3ARg>
    <xme:KRzRaOoLlQQGIuHDj3r9qUcOyUDuto1tcGm9yMpGEt4mdn-nHnjYod9F3wSZyfo1e
    eS1tt5SF9ZlMGRZoVI>
X-ME-Received: <xmr:KRzRaA4bCpaabTvh5_m4ipP88LgOxGW6uMb-5DINMQIuebdHXZzYf4_vdC8DDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgrkhgvvghlrdgsuhhttheslh
    hinhhugidruggvvhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhi
    ohhnrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpth
    htohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhn
    fhhrrgguvggrugdrohhrghdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghsse
    horhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggt
    lhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhrtghpthhtoh
    eprhhpphhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:KRzRaALRaxUp4xgtzHmSZaoU8wLIl3No_gCku-i-PryXC2p8phYJSw>
    <xmx:KRzRaMlKF0rngRFI45tr-db7KlFX6tamt2928VGI67stg2z26a9erg>
    <xmx:KRzRaH-4RcPROMMtruqVE_MyiZLdfmZ1qEe3b5xvVHI_cErHNQQaLA>
    <xmx:KRzRaD7E2rxEce7e0tXPKoNwnyz_gdiwgFeKM1iHkFDiTbV0pKAkNw>
    <xmx:KxzRaAuGGx0mjKDpCyfLpwsUIqAAUgs-iGY2dLFxjxH3XijEEf565K8F>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 05:51:37 -0400 (EDT)
Date: Mon, 22 Sep 2025 10:51:35 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/5] mm/rmap: mlock large folios in try_to_unmap_one()
Message-ID: <pdorb325r7fatuclbaw4zriieve4tphlrox6w36fo4mlmzgcx7@kdsf4pwqs2wy>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-4-kirill@shutemov.name>
 <27wxlfhnkxaat57lzyzlpo66vse3jjhp422ziswbl4oyjnamif@2jx25dwgkame>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27wxlfhnkxaat57lzyzlpo66vse3jjhp422ziswbl4oyjnamif@2jx25dwgkame>

On Fri, Sep 19, 2025 at 02:27:40PM -0700, Shakeel Butt wrote:
> On Fri, Sep 19, 2025 at 01:40:34PM +0100, Kiryl Shutsemau wrote:
> > From: Kiryl Shutsemau <kas@kernel.org>
> > 
> > Currently, try_to_unmap_once() only tries to mlock small folios.
> > 
> > Use logic similar to folio_referenced_one() to mlock large folios:
> > only do this for fully mapped folios and under page table lock that
> > protects all page table entries.
> > 
> > Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> > ---
> >  mm/rmap.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/rmap.c b/mm/rmap.c
> > index 3d0235f332de..482e6504fa88 100644
> > --- a/mm/rmap.c
> > +++ b/mm/rmap.c
> > @@ -1870,6 +1870,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >  	unsigned long nr_pages = 1, end_addr;
> >  	unsigned long pfn;
> >  	unsigned long hsz = 0;
> > +	int ptes = 0;
> >  
> >  	/*
> >  	 * When racing against e.g. zap_pte_range() on another cpu,
> > @@ -1910,10 +1911,26 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
> >  		 */
> >  		if (!(flags & TTU_IGNORE_MLOCK) &&
> >  		    (vma->vm_flags & VM_LOCKED)) {
> > +			ptes++;
> > +			ret = false;
> > +
> > +			/* Only mlock fully mapped pages */
> > +			if (pvmw.pte && ptes != pvmw.nr_pages)
> > +				continue;
> > +
> > +			/*
> > +			 * All PTEs must be protected by page table lock in
> > +			 * order to mlock the page.
> > +			 *
> > +			 * If page table boundary has been cross, current ptl
> > +			 * only protect part of ptes.
> > +			 */
> > +			if (pvmw.flags & PVMW_PGTABLE_CROSSSED)
> > +				goto walk_done;
> 
> Should it be goto walk_abort?

I already have to set ret to false above to make it work for partially
mapped large folios. So walk_done is enough here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

