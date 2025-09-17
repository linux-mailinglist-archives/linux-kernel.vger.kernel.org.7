Return-Path: <linux-kernel+bounces-820512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E03CDB7CDDD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F362A5C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5B2D6E4A;
	Wed, 17 Sep 2025 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="MxSUImwO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BK4HU+yh"
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4D320E005
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758106360; cv=none; b=KvQRAPCsSkiE7J5X/Lwty6oEhVpZwTsL6mS9HZtbCFVQAqXcmmXyuM4Ne5dVRsMXMMVlmvGVVux86YQ33zdeyCp3Lk4a+zdfPbeUWwsFGF2qpG706Cob43Xmt9LRMDJho+7EQxOtoEElx8Be/9wB/kVuC4X7X76oBVt72cOVRfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758106360; c=relaxed/simple;
	bh=1GxHaNSfuxm/HtNES5i1Gy70Z85LkIKgqxtwM4Cdstg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oiqR0JZm6OdXxh0WwOKrnddDXVOI7PL/YN4zPWLMEZBy1D4wX66/WCU0+Axew8zcolCoU3r3By6enQ8VuwDn4q3Y/GhS+qY1r+eCvmNgb34XEkSso21FGVrUlpkInteptgPaMjswimASdGYjBc2iEGVYcwlaJSOXjShcPUry/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=MxSUImwO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BK4HU+yh; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 43DBB14001E4;
	Wed, 17 Sep 2025 06:52:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 06:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758106358; x=
	1758192758; bh=YuT1HrKV0CHpGc0kdRXUpXx/IGQAnMRz3CF881BaPOk=; b=M
	xSUImwOgerRqD7q0HpqWJb+BsKpsErRDlVA+hznG+y2DZso/dLo8MvRw9y4PFEL2
	RgYd8RbqjLka+CevfiB/uEqDOmG/BRgWYP0fnNFGKl+2xM7WXTwFT793Ohs8INHe
	hfNBkaDSpfs38T6v5W9i9J4GeZ5YF8wJjcCq4ad4lrUOk2rt9uXX781nc5ZwuVN9
	LOuIHyp/Af9tKa6d9EyS1EyOUyRl5A/3am+fwsgtZCE4ccyTOQwIZXezKt+pSq/b
	UQ+chYUPaxVI3phR2Zid0f6kPlFcafGAb+2/NHtvx0ZsCjmmpvxcT6Kia9u/2/hg
	drOIKKdAYjP8JP08yW4Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758106358; x=1758192758; bh=YuT1HrKV0CHpGc0kdRXUpXx/IGQAnMRz3CF
	881BaPOk=; b=BK4HU+yhkUtEByUJVOss8GPApInhcClbyBm5ild0hLIvAZoD0wW
	FRaJUyyTuc7n7roqyzfQy2bL0P1O3zYt2E7g46rtbMe97/fjoHTrqKpkEjQCWept
	BZE0Z1yhmfa6YvRGGTe65eTKcgiwq2LTuhYRuqr+f5IeUm+EKeDV3Mrq4hUafvTA
	9c5qKg8r+mvJ7Rwp+IyKwKDsEBl/Nx9vYlIIpgutXyQnOifJ86I0ijVlUfgqji9R
	6ZbQrNSrnsVgMFyNwCtmXC2S7H6URky6NCMYMaZhy4N15zYkwIXGmNLfONFYEkM/
	GCJJMtJMH5q3llAHlXgZfXj6qzCept0wzXA==
X-ME-Sender: <xms:9JLKaB-24Pd6ExhgxTc3fgErBlQKNXCfF49C2wryNbNiQQk-Oq8E6A>
    <xme:9JLKaBNsuYu39MJDlVv3PT_Rhkd7HhaKkxgCgCp3tqlj2zRZlS9GE1EhzV2SixWgP
    Qy8j7dn3Vz9xh3_7B0>
X-ME-Received: <xmr:9JLKaFDNQBgj-9Pv7rZaQ9Bl427XnCnRPalym7hxh2urzEl5w4WByFLqh0PpCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegfedvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiiohhkvggvfhgvsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdr
    tghomhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorh
    hgpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepiihi
    hiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhinh
    hugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthes
    ohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomh
    dprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtghomh
X-ME-Proxy: <xmx:9JLKaDMgVWjjHMj4ydXii4HjOLe6Mgyd_Ud90lUiTActOCsxhhyeuw>
    <xmx:9JLKaLbNCiNKsbuHCI3PnAVAUQfT3Sp4_nx9zUNJJjk1czNxI7Hy9g>
    <xmx:9JLKaCPWgzZtZtcRuuzctIYMOk8oJRAPfdnCw7Fb7nsG8k2UQXb4-A>
    <xmx:9JLKaJU3DtUdU5tO6_-cm80Fi49QE8FCoNEFUcY7YBRe6Zh6l-Vbqw>
    <xmx:9pLKaBLufn2pT4kQCyiLZfHX8hqjNJbkw2nzuXoxw-tHqK9xGEEO3Xcy>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 06:52:36 -0400 (EDT)
Date: Wed, 17 Sep 2025 11:52:34 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Zach O'Keefe <zokeefe@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] mm/khugepaged: Do not fail collapse_pte_mapped_thp()
 on SCAN_PMD_NULL
Message-ID: <j5pf6l745hp4r56fndlshzcjpyi3nttgywouowhmfiewx6p56j@b64l6tmupykt>
References: <v5ivpub6z2n2uyemlnxgbilzs52ep4lrary7lm7o6axxoneb75@yfacfl5rkzeh>
 <ecac1e7f-1709-4348-b8ff-fa1c0f087548@lucifer.local>
 <CAAa6QmRaiKB2OOpZYjRx3EAQ+d8_G=MsVmV=9cc_MmHOYsikow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAa6QmRaiKB2OOpZYjRx3EAQ+d8_G=MsVmV=9cc_MmHOYsikow@mail.gmail.com>

On Tue, Sep 16, 2025 at 11:06:30AM -0700, Zach O'Keefe wrote:
> So, since we are trying to aim for consistency here, I think we ought
> to also support the anonymous case.
> 
> I don't have a patch, but can spot at least two things we'd need to adjust:
> 
> First, we are defeated by the check in __thp_vma_allowable_orders();
> 
>         /*
>          * THPeligible bit of smaps should show 1 for proper VMAs even
>          * though anon_vma is not initialized yet.
>          *
>          * Allow page fault since anon_vma may be not initialized until
>          * the first page fault.
>          */
>         if (!vma->anon_vma)
>                 return (smaps || in_pf) ? orders : 0;
> 
> I think we can probably just delete that check, but would need to confirm.

Do you want MADV_COLLAPSE to work on VMAs that never got a page fault?

I think it should be fine as long as we agree that MADV_COLLAPSE implies
memory population. I think it should, but I want to be sure we are on
the same page.

I also brings a question on holes in the files on MADV_COLLAPSE. We
might want to populate them too. But it means the logic between
MADV_COLLAPSE and khugepaged will diverge. It requires larger
refactoring.

> And second, madvise_collapse() doesn't route SCAN_PMD_NULL to
> collapse_pte_mapped_thp(). I think we just need to audit places where
> we return this code, to make sure it's faithfully describing a
> situation where we can go ahead and install a new pmd. As a hasty
> check, the return codes in check_pmd_state() don't look to follow
> that, with !present and pmd_bad() returning SCAN_PMD_NULL. Likewise,
> there are many underlying failure reasons for
> pte_offset_map_ro_nolock()=>___pte_offset_map() that aren't "no PMD
> entry".

Sounds like a plan :)

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

