Return-Path: <linux-kernel+bounces-830323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B4BB9965E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69C7322B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2472DE6ED;
	Wed, 24 Sep 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="nT0Sarpa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JldBqo5T"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A662DD60E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758709030; cv=none; b=vD9PDr2q7mGC+4CskB1l/DmSAorlnWfheBGoDBSHm/UCXoySdzivD0lebkwioHYCVlga9Spmg4TSabj/sUJbEQHQKCQYYJZwT0ecBaAaffEKhZMUIGstGrrCQbdY0g3ZWKvGLUwA2hztZVIM7trdUoUpw7YZ2ugvN5iIAf8uSkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758709030; c=relaxed/simple;
	bh=tgxvA+YW+h3B4D+x7Bo2FWC+EpKnnMYPSIJY/Pwfwg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCoIqyB/ZozpoGKLYgUHon8ORs5oHZLImq0bsdQJnBweJuQWPTBAXJmmUEQ1HLar6qrC7cHG1xMPfOHk8z0VH0dt7MKZXQJ1gyXmixtWxMhUxkPYl2Pz3OuCp0TRJjM5Bk4S+1H880wFXWfDT9AbGNl8lzA5WGcq/5q6+IuYu2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=nT0Sarpa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JldBqo5T; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B033EEC0183;
	Wed, 24 Sep 2025 06:17:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 24 Sep 2025 06:17:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758709023; x=
	1758795423; bh=JDTtAbQOmZtZk8z1Mcd5kf03E8S/F8hNJ0v+YQG+MwE=; b=n
	T0Sarpa/KG1+uAkBBQqbXY4rEH/R2AorxuNHbF0W558Z4sbBbe0Z0+rZF8OYQsZK
	BU+mCgZFhEOq7OntNt+IksY1Vx9bkdnsFIavtxbpntIGjMNPBMYCZUSnu8/ep4aP
	7DQ9ogy7n/M3zv3OcTbQLrMxjVteBUcqU+eXf/NsGWj+ARXx0Mu+ZDXTn6KDBnWT
	AzyMEwpVKQWae2P6ZSnjxG6ydKd0vHoSxcwW3qJ9GDGTTYTF1aAv0vEcPPorpfd6
	wKV+ezp0sWgtqlot/6kGFxkoozo5mPCGDJeU6HKobCO2Aegu4x52bpWiXW9vc3f0
	qPL9SNjH/oThyUZaO1Jyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758709023; x=1758795423; bh=JDTtAbQOmZtZk8z1Mcd5kf03E8S/F8hNJ0v
	+YQG+MwE=; b=JldBqo5TO55HJf2/UnRQWnRhe5UJYTVIDlVKXKfbfdFTDbdejoL
	DCSH9xcw8jrDOn82r//G6rIotADGSWUQQkm48dIzfNjfKlFVr5KEHKflvRrNzg9N
	suvcs53R0h1iGMV6IcWSgoB9YOES7uPePyzOGabU3RFp2Dw14oSCZpRV3/auKtjZ
	amxi4JHd1KrMxMq3e+k4/WnRBlPbf7SDp4Ky1YQsRGDDZZQHWsDj+XguAtTbJ6dJ
	kG9RkaE6s+l1j//gRfVIb25dKx3GttQblSiYzwyHW9iD+nFMLej3lRpvZRyTaA+f
	0+hIEqFDURGCSkT2R3bGnhl9gt+yanpJ/eQ==
X-ME-Sender: <xms:H8XTaGGdBKmDLwL8l8Syo9qC6GNAyyrH6pRH1EQLYLwqh-dQh776RQ>
    <xme:H8XTaE_jZ51a-AoPPsU73w0AwDU3jz1Tfg2-7gFsezGxUyauG9Wt_I_1qqVNjHFaO
    ziGcD88gtDBzB282dnSiQuUkNvYRBot18MZyFJlOaZvBm4tpMofBmNY>
X-ME-Received: <xmr:H8XTaHhUgTkXh7FsUx97x1ij0ymi8FMEXeRiBYLorV48iYiCYvQuQ_DwnyS3Mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeifeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohep
    lhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegsrghohh
    hurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrohhlihhnrdifrghngheslhhi
    nhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguvghvrdhjrghinhesrghrmh
    drtghomhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:H8XTaISTvG4b3JkljYyYanWghsQ4CeXpHgOJvgqXm1dsCx6-8Z78NQ>
    <xmx:H8XTaEAfaxIgpR_50G_AoUmiSrRTKSvo4e-G7nnT-RhDE0K7KSZbUQ>
    <xmx:H8XTaC9PP0gPhVI_IzpB_VI5dR-uVXnR1CTTabcXNBwlBo_5uoQLcA>
    <xmx:H8XTaO07S3C9iemYfZQB6v5XV81GaRnlIWtWUbZGz5QGxZ2n3c4ziQ>
    <xmx:H8XTaOxgtZpX59qH382vwNfECxNqEQUeW0miHTVU5pUtEdsl9OiAcefK>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 06:17:02 -0400 (EDT)
Date: Wed, 24 Sep 2025 11:17:00 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, hughd@google.com, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mpenttil@redhat.com, npache@redhat.com, 
	ryan.roberts@arm.com, ziy@nvidia.com, richard.weiyang@gmail.com
Subject: Re: [PATCH mm-new 1/1] mm/khugepaged: abort collapse scan on
 non-swap entries
Message-ID: <2i5t62obfweid2zrt33vo3boviw4okha4d3gglw76eqv43ofky@pdv3evw5yjmh>
References: <20250924100207.28332-1-lance.yang@linux.dev>
 <1282de5a-3dce-443d-91d1-111103140973@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1282de5a-3dce-443d-91d1-111103140973@redhat.com>

On Wed, Sep 24, 2025 at 12:10:47PM +0200, David Hildenbrand wrote:
> On 24.09.25 12:02, Lance Yang wrote:
> > From: Lance Yang <lance.yang@linux.dev>
> > 
> > The existing check in hpage_collapse_scan_pmd() is specific to uffd-wp
> > markers. Other special markers (e.g., GUARD, POISONED) would not be caught
> > early, leading to failures deeper in the swap-in logic.
> > 
> > hpage_collapse_scan_pmd()
> >   `- collapse_huge_page()
> >       `- __collapse_huge_page_swapin() -> fails!
> > 
> > As David suggested[1], this patch skips any such non-swap entries early.
> > If a special marker is found, the scan is aborted immediately with the
> > SCAN_PTE_NON_PRESENT result, as Lorenzo suggested[2], avoiding wasted
> > work.
> 
> Note that I suggested to skip all non-present entries except swap entries,
> which includes migration entries, hwpoisoned entries etc.

Hm. So swap in is fine, but wait for migration to complete is not?
Seems odd.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

