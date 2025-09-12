Return-Path: <linux-kernel+bounces-814277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE253B551ED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1F80587A40
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66996313E39;
	Fri, 12 Sep 2025 14:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvDvHAON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D3313535
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687734; cv=none; b=ZUoBSHvyTDQZwGoPDztjK7O3+Wn9FlPfmT6iITrorotqBAge6dKu5Cbj4DlebhB7HeEqswJIrkLxcnffMHbUKxCaQ5O1NJunHsy0LhjFxwVCSsxdbuoyx0EOAMa/3HAYVOjhXa2/c+ZeRWJoafIOiplT4QiEPMzVwzjJzfgL72o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687734; c=relaxed/simple;
	bh=ZS7rP4uNGEsC6E4oWHILrKqyLsgRXKFtB76mAodhYY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tHBvL1NwdpViEEVzEIC7uF0LAcrLT2IZyfgYpwPc2kY0ycHlN7na/fBxebvmWudAsuZljSlOwc+RDid7hlD4BmOAYUAPa503rQYBGyqedulmuEbKaACbe2YukmCMslsLXVDcLV/+ffRxH3nvSfMHP1AJBgTlkrzSVh3HkCXEdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvDvHAON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D93C4CEFC;
	Fri, 12 Sep 2025 14:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757687734;
	bh=ZS7rP4uNGEsC6E4oWHILrKqyLsgRXKFtB76mAodhYY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvDvHAON2qhhpTtNm4cLZ/qjALTvAXwPoELKCBLQ9osYbWLqELlI9L/W5guiu9ysT
	 Bzu+pALpNnx7Gpx540xIDpm70XTlKzsMhsEcWS5iczEGni5LxIc4Q4Mwc5xFTTN1BY
	 JR9gkD4IRHT1Tr/Wcvnv2TEgnx7DKTvcIoT+IwsypT2ODztwGBSly5SyP8qjjP5dA4
	 RZeVgpjgkgGCG0iZpitwdR96YqEP5DXLwI/zkoG7jbRj6MQJaXE/EXRONJzX1qKacm
	 8KCIK0Tf4RTbv5usJNMHAt+PFnQPXZl9NSR1mNHP5rQDjktKVLteOhSBXSFlekWOMC
	 9QXE+259h65ug==
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id D1459F40067;
	Fri, 12 Sep 2025 10:35:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 12 Sep 2025 10:35:31 -0400
X-ME-Sender: <xms:sy_EaIOFVP8TFbUVTr3M1hLM62MVAOKgDByS_aczWYuKrY66etkvQA>
    <xme:sy_EaMw-CYop6ykTCd7xbwny6NtaPItW2sfRBJsD2AqEeyBakCiyiq9sSD4I2ZrZ8
    0EOX8rSQyNgOwk0O90>
X-ME-Received: <xmr:sy_EaNEE_dt9BsbRhcSnetlFx8viyIF2X-cR9O_4RQejA7BzgjEZNxGcPjXMeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvleeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeelkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhhprggthhgvsehrvg
    guhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrghdp
    rhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
    sggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtth
    hopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:sy_EaAmxvA8o9_BHxY-OQnobzIiZhPsKsPuNtnqReZ5bOGcvwh474g>
    <xmx:sy_EaKp3BAE6_gjy-zS7AYs7Bj7CZV5N_FJtGJNQVJ9t5qw1AikzVA>
    <xmx:sy_EaDLqBIhr9fE2udYB0c4LPnib3YjCh9yEomGSqm0hV0dg8fzlNQ>
    <xmx:sy_EaAVLrTry_swTdUTik2eWBdy0SXF2Of3dstHY8M8jzbt4H_u2oQ>
    <xmx:sy_EaIpOoTWlPsROLlgNbu1iSSSKPIivBreFLf3igkQmOpWorIzzL6ol>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 10:35:30 -0400 (EDT)
Date: Fri, 12 Sep 2025 15:35:28 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, 	ziy@nvidia.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, 	rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 	akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, 	vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, 	jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, 	zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 	pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <rapl4xr55zv2nq3jh5ulk4wvfyxa2kmbnnb4uram6q43y4cbwn@dv5m52ocyqne>
References: <20250912032810.197475-1-npache@redhat.com>
 <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
 <43f42d9d-f814-4b54-91a6-3073f7c7cedf@redhat.com>
 <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab8c2e03-53fb-402c-a674-c2c6ab11f54e@redhat.com>

On Fri, Sep 12, 2025 at 04:28:09PM +0200, David Hildenbrand wrote:
> On 12.09.25 15:47, David Hildenbrand wrote:
> > On 12.09.25 14:19, Kiryl Shutsemau wrote:
> > > On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> > > > The following series provides khugepaged with the capability to collapse
> > > > anonymous memory regions to mTHPs.
> > > > 
> > > > To achieve this we generalize the khugepaged functions to no longer depend
> > > > on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> > > > pages that are occupied (!none/zero). After the PMD scan is done, we do
> > > > binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> > > > range. The restriction on max_ptes_none is removed during the scan, to make
> > > > sure we account for the whole PMD range. When no mTHP size is enabled, the
> > > > legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> > > > by the attempted collapse order to determine how full a mTHP must be to be
> > > > eligible for the collapse to occur. If a mTHP collapse is attempted, but
> > > > contains swapped out, or shared pages, we don't perform the collapse. It is
> > > > now also possible to collapse to mTHPs without requiring the PMD THP size
> > > > to be enabled.
> > > > 
> > > > When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> > > > 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> > > > mTHP collapses to prevent collapse "creep" behavior. This prevents
> > > > constantly promoting mTHPs to the next available size, which would occur
> > > > because a collapse introduces more non-zero pages that would satisfy the
> > > > promotion condition on subsequent scans.
> > > 
> > > Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
> > > all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.
> > 
> > BTW, I thought further about this and I agree: if we count zero-filled
> > pages towards none_or_zero one we can avoid the "creep" problem.
> > 
> > The scanning-for-zero part is rather nasty, though.
> 
> Aaand, thinking again from the other direction, this would mean that just
> because pages became zero after some time that we would no longer collapse
> because none_or_zero would then be higher. Hm ....
> 
> How I hate all of this so very very much :)

This is not new. Shrinker has the same problem: it cannot distinguish
between hot 4k that happened to be zero from the 4k that is there just
because of we faulted in 2M a time.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

