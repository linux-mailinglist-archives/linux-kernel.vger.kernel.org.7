Return-Path: <linux-kernel+bounces-818510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADAB592B2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D5832362A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3BE29BDB4;
	Tue, 16 Sep 2025 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="D2aQFVUe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DUfuwFWZ"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D17E29A300
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758016109; cv=none; b=G6Mm72IAv4OmgINdXsKvarTNShD0lsc2Cx6OZrE/alEGa1Z9BfFAms7P0F2MBlqc+wx20hSLmOk3sGbEF3BT61WMfbJLe5N1Ehd3Vxza0VY2JBm1y6QcL3bPNfGupFAozeSzB1x4phcF0oT2npCU5pFF90a1DUvbrFehJj3aO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758016109; c=relaxed/simple;
	bh=sf8yRzij3Byk034STuY6WRNg54sfP9ukiW+diw4wzes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ugaalFnI60S3XC3l86y7e1hSFJl5dIBW+czcrtibYAPs5+2mmxj4us0VE5tY5E8driQD/oyY14QJ+sUwNVIlPRfsFpyZTpDLc6NCg48hPxOWMtMpaSqHeN9Vo5dv61Jf9tT3+NlBgBb1Jyt8ISKm6d5dCCW7vCRxnIga/1vH3sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=D2aQFVUe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DUfuwFWZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69BA11400247;
	Tue, 16 Sep 2025 05:48:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 16 Sep 2025 05:48:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758016106; x=
	1758102506; bh=GIaDJagR+QktkPtVev8A7bap6/nPosyyx9BTZ75Hhq4=; b=D
	2aQFVUenZpmlwWbkc0BJn/KiocA4/a+alB8S3HR6Z9KCMRYB7LJuy+uoe+XPMwDL
	3v31LW0uHKJ20mGCykVe1f+UJ6eG4UZmqxiiZZue3BkUCIuv4g0wd+v+fG5cMjcY
	h7g2JtuqcG+cob2UKy0/8gdEixQw85txfrczK6yoldfJNF2MSvHiJbNITooJbcMx
	N8sjZ2PM2Yc7fcTkCGUn9xDq63YY1VRe9s1mftE6WZ9z80ng5A+tXzbTYGha1Xsk
	/3Y+juLJ+bQ1KLhQJG9dYGbX3VOPJsvtOoWzGFWc5vITaIFrVyhIW0IduGRhI7X5
	n5n4XBAaCKoWtZfoymWiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758016106; x=1758102506; bh=GIaDJagR+QktkPtVev8A7bap6/nPosyyx9B
	TZ75Hhq4=; b=DUfuwFWZbgU0msmOXJcIntKzo+CZrLWDhyFsK3jIvYe8gpsjy7O
	mD/zEojNTom33aPZawg36Sv4o2/OFeioVKEeAOVhq/+Lqe/HaR8+H2kygdyIPeCD
	iD0mvJYEGlv1vC3sXXKAaOPSGwDfzM14BhFkelJypR4vkedExqivdwQhXTSbhyTp
	6EprMoYXvJqnVlUvbpzqhOzJ3e71IySOh9wzfZu38zlUs5MUWj13hEp03KOLdvUm
	dwRGNCtSRxpUY8/uIblNDlI3p1E5Zonj02uNm25oubaNfaJ5stwpl+X+OAUk27LI
	4PVDwG/LWK7W6ZzlQ7Mtx/UsEYsQdSclCKA==
X-ME-Sender: <xms:aDLJaEptfJoy9XmdVyQ0uJxuTQfTlJ2BQQuJmEWK28l3U2kuf0OyuQ>
    <xme:aDLJaNAq1WD4onJ4VzC1tdPZ9-WoT8OgxBqFcfdkz4In5HKypHcDMY4zvDKgcuv5N
    prIt39rzMsc2shwuQ4>
X-ME-Received: <xmr:aDLJaCccjZDvgiY47XMhRiDcGjU3mTenhChvfLfO6gWIeCppjwlyyu2Hfn3CRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegtddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfedt
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhrvghniihordhsthhorghkvg
    hssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlrghntggvrdihrghngheslhhinhhu
    gidruggvvhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtth
    hopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    uggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrd
    gtohhmpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggs
    rgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtthesohhrrggtlhgvrdgtoh
    hmpdhrtghpthhtohepnhhprggthhgvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:aDLJaPCxFKUa12RfE1NOwYjTnezmw4poFf59dpCupkv7sRhcpDB6Xw>
    <xmx:aDLJaGRsYEyege5ZT3Zl7jn3BpoAT3JOt_WNWE0wAkVKDiiRY5yx6Q>
    <xmx:aDLJaDcuZfi9cHeEfwu-pT7mwlyM4g7bYCG7GuodzK8FdEIogUUD_g>
    <xmx:aDLJaJqt7DzRFnDmwrRSMvZRbAb5qlH91D_ybdKczOQMggYlWyzn6g>
    <xmx:ajLJaDrbttBV36_C69McZ_6b1L3IHMGBKmod78-rby2a5NzTrsKnbnK4>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 05:48:24 -0400 (EDT)
Date: Tue, 16 Sep 2025 10:48:22 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Lance Yang <lance.yang@linux.dev>, Hugh Dickins <hughd@google.com>, 
	akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, ioworker0@gmail.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier
 in khugepaged_scan_mm_slot()
Message-ID: <3az7vzkhpa2pup3td5pbrek6ti2fij574qimtnbpecums7ixyl@upabkyqmtiaf>
References: <20250914143547.27687-1-lance.yang@linux.dev>
 <20250914143547.27687-2-lance.yang@linux.dev>
 <bc86d5f7-5b23-14fb-0365-b47f5a6f13c9@google.com>
 <a0ec4014-384b-4c04-bf0b-777c989eabcb@linux.dev>
 <ol447ofo44vwtyfwg3zrdtcdlkfzzmx4rre6qhyotmwvecnec4@usa3nonuk2sn>
 <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2466c068-ccd7-41a1-bef7-6f3fefc6ff55@lucifer.local>

On Tue, Sep 16, 2025 at 10:39:53AM +0100, Lorenzo Stoakes wrote:
> On Tue, Sep 16, 2025 at 10:29:11AM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 16, 2025 at 02:21:26PM +0800, Lance Yang wrote:
> > > Users of mlock() expect low and predictable latency. THP collapse is a
> > > heavy operation that introduces exactly the kind of unpredictable delays
> > > they want to avoid. It has to unmap PTEs, copy data from the small folios
> > > to a new THP, and then remap the THP back to the PMD ;)
> >
> > Generally, we allow minor page faults into mlocked VMAs and avoid major.
> > This is minor page fault territory in my view.
> 
> Hm, but we won't be causing minor faults via reclaim right, since they're
> not on any LRU?

PTEs are still present when we do THP allocation. No reclaim while the
access is blocked. We only block the access on copy and PTEs->PMD
collapse.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

