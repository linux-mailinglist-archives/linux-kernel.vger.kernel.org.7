Return-Path: <linux-kernel+bounces-814559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F12ECB55590
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 19:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1623AE2B37
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F70D324B35;
	Fri, 12 Sep 2025 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ClQV0HTI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="im51tb+C"
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583D8324B22
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699091; cv=none; b=hzWB6uVmE99r6JM4uSBLHPyMTVELJFtgEEWTnjZcArvSpewvO88VjM7ydtesnHOIUsAGR6BDJ37Wozz05NJCCkjY7UIkKpx57+/pP77KvV52NgcgNaiYWXOji1pSeaQop461ZrRzMkpxaalLzPQZ+N7haQ5X40SkLGqdlCsMs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699091; c=relaxed/simple;
	bh=9uzYh+n2Ll+EZEmlcCMqOmvBB6teSdCPbHnDLm3/rk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NS3ft126m1HzXW+woFsApR2umkHbppTq/hIPHrHq8y0mjUzJoiAEdzfyA80r0HROR7oL4Us6qmA2UyYKJqT6BCpTGsKnT/Jf8m2W744tEWq2S9ysKt/laWmQied2vE8xvuDf+S7uOE6MO0BJ9CKqwk5ijqIYTqY4liazWaW0CK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ClQV0HTI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=im51tb+C; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B77937A014C;
	Fri, 12 Sep 2025 13:44:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 12 Sep 2025 13:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757699086; x=
	1757785486; bh=UbXOseeNnaP83dMYePU0k6b7ZDIfNAE/7Jdsl7Ac4sk=; b=C
	lQV0HTId9nSrky+AZyRVP6KYEATXi3LI2X3MH1EKxhekzxJptQPKhSRwtr0nFi0D
	qEqgqtXj9mKLK1L+i0QAajauX/Ee0j/OQeVlnnIuoU/D/g9iR27vQOkBnUVceFBq
	/fW5nZCXO/yEL7wCN1jNkkQUkiChOyUgqgE8Man/Pj49Y9wkX8Mn/uy9pumaHknp
	GGtLlzoEcfR0XZ/4cQAiO0HMxC5IQQzkvcrgL8THEFXpfS0g7u9+VYb3vNxMOopv
	zpLK8opf+6sAS7H58t97ncAqDZyyIn97GBjNjFE2X96H4+1nxhoEHXYb+Ia8ssyt
	lJXJ3CyGFn5IudSqqQVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757699086; x=1757785486; bh=UbXOseeNnaP83dMYePU0k6b7ZDIfNAE/7Jd
	sl7Ac4sk=; b=im51tb+Cxc9Wf3P9QHBTtqrLu4rPtozC6R2oFl+yniN2rBzHA1N
	sERVMcZv6I+ZvcgjX3uo3M2RxUZKvck4epBQ1ESR8jLG98+0hmZe8kMnO9iGp+gj
	VrQlEthRCh2jQ9vzDZCYp10JbwFjB2p4G6lescKIMpMy45VFSa+gptcc+58g3Cvv
	5WAcgLAR/AYqgv3+PIlR4kKLJp+uON8BWBvm8AymfEiFGNA2txXh1mfyvYMPmf2s
	jYRW3t2y6vLDEdxSlqi+HyehpCIPUC74lkiFJxzv9rB2qEqb4zOwPCzO1MhtqBe8
	rKuc+chegJ9jJ9A/vmXvpbG/NteWp3JXaGQ==
X-ME-Sender: <xms:DVzEaDlSoyTdClnPKHNq_iKBQHeosJ1uFtNg-5H8GgHyp4xlIJ_v8A>
    <xme:DVzEaCt4stj4bo245syo5toimrJAm8oWqoe8zTcuPqMz2Uk4dKk0o_mYjPzxXE9Ig
    PiY6OCeX3dQwa4OSP8>
X-ME-Received: <xmr:DVzEaCfdcx_95HunODtaZRKSeQ5hWu94jJE370DO-LEmJGSDj5nJQ4eKSH7IjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtoheplhhorhgvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpd
    hrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohepsggrohhlihhn
    rdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopehlihgrmh
    drhhhofihlvghtthesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtg
    homhdprhgtphhtthhopeguvghvrdhjrghinhesrghrmhdrtghomh
X-ME-Proxy: <xmx:DVzEaEaGwv2OwHz4xSZo8qNskgJ435vmbHuXJZd7RhbxWdL6yuCjEA>
    <xmx:DVzEaK0hR0wItz6tDK741-KZNaADkjRugK7IrzvSaJVnWvPQiOOEaQ>
    <xmx:DVzEaNrq98OX_y_swKPEMos7hZTf3KQfNq3T8PcOoMjxt0PQPJdNIA>
    <xmx:DVzEaLwJKRMt6gJyMlHTa0s3AK9A3JfBYscahY6m9rRIJdNZYIxEvg>
    <xmx:DlzEaB45ZF3zCnnB4Ev4Y8vQA_MjYTBHMcj6KSUxfR1hVLJJ5LCXBqO3>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 13:44:45 -0400 (EDT)
Date: Fri, 12 Sep 2025 18:44:43 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: Do not fail collapse_pte_mapped_thp() on
 SCAN_PMD_NULL
Message-ID: <5n3vzdmdmeyicqf5dji2vo5hsfupigq7nl44cog7vwm6nchtqo@so5mvct4fwhn>
References: <xhan2av3fyl7qpsl4bhjtds2zeegrl57ehtc5grtkua3c3v3nz@vain5s6gpycl>
 <36bf71ea-f6aa-42fa-9fa2-53d00f351777@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36bf71ea-f6aa-42fa-9fa2-53d00f351777@redhat.com>

On Fri, Sep 12, 2025 at 07:13:48PM +0200, David Hildenbrand wrote:
> On 12.09.25 18:58, Kiryl Shutsemau wrote:
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
> > ---
> 
> Makes sense to me.
> 
> Is this something we want a Fixes: or even Cc: stable for?

I am not sure if it is stable@ matter.

I believe it is there from the start:

Fixes: 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

