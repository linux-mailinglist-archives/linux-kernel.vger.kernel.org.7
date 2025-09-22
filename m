Return-Path: <linux-kernel+bounces-827594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A8B922B5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 250027ABC13
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC5931077A;
	Mon, 22 Sep 2025 16:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Iz96PxW4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CM1i1Kow"
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20CD30CB26
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758557803; cv=none; b=g2bDPgkaNqdKI+4xPcdxwLIq/G1B6MKLblCD31tf74d5/RiX2ICZyK8HjX3hGURklMMrvzB/eEK2LSQoaCDGFkYXrcsACfIeyqEOw/noPM5D1CrleUuE9dvueI5YppYR+uh5cAj28blPqFZQXzXjgPoXM3DPGQQcqvFmb+asOX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758557803; c=relaxed/simple;
	bh=wkJMmCXEMvAL/nxj0so67LeywLW62dz+DtEIN4ixFu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJPp4Pu7zZXIxwGRAyyzawDOihX8mkao6h8LndkdI4Snx46S/CHDx79euLfpn7sUzReW0e9JqCS1lbBszGxcpdLI07n9bVkfgQnahjwigx0QQP0J1ZXdy0ir3ItEbP8NkBKIkyoorc1t+rWeX9TZWaaSzNhGCfDkBWwoos7Dq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Iz96PxW4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CM1i1Kow; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 0DA291300360;
	Mon, 22 Sep 2025 12:16:39 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Mon, 22 Sep 2025 12:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1758557798; x=
	1758564998; bh=INmHqpS8XOyU8EfGphccX7Ljpp6ELUOxylIKJQ8Yn6w=; b=I
	z96PxW4Yw+8OnYsKB1avCOzDJAGNbTsCLR4kPQNmHK60qvqYXXlOI8C4Jcl/sbzg
	gai9/XcDc14CGTwsChiQgE6DktBZWUwUf3CblNclDkL/Qf7hs3s2YizhNom4+KtN
	ulIZ85BbmMfqMYF7HIWPSp8zudOpCSiLxoaca+D6wuWqzGx8Cxnj6CcT8aFYmKzR
	dPbyMU3jhTaQUEVAhhXZ5XEXtqPSNHcuyac/o0+93TroHfrChLnfnmh+02uVjAxs
	mXpdAqPaUaJWBvpFVCQBN9fz1LjrWLss3y4sLuAAsaMVw04JTPttJqssXTZ2jO26
	BBExHAwPcGB/tgbTT1eRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758557798; x=1758564998; bh=INmHqpS8XOyU8EfGphccX7Ljpp6ELUOxylI
	KJQ8Yn6w=; b=CM1i1KowqsrEYJZhezg7fdaxN2W6f8+uafjcx41etkzDbW/7XUM
	v7v6YvZO9orSHMFY2lYTz92x1ML2EMO5aLtnnE/+7gqDUcDTCeMJgB9XC61B81vh
	ZeDhLXnCIjyyzh12eda7XqzVghzY5G2hVozPC/nmrmMhCQHhMWOotm5167EqdXzm
	XU+n3FdYWXltDDFXsm6GagrkVeZRNda5z6E7ysva0MZ7oDHw/+6hrNqCGfiDI/4N
	I4aokKLfBX0OrzOvkb33vj7h6wjunlcoZzah0aybBkYW2XjTgr0FdjnYT8tDmxlv
	xtl833PeBF/n/WTZY+LwMFkmMpRiySijhsw==
X-ME-Sender: <xms:ZnbRaE7LQUF2JMsM9INnfAbzQt8VY0zj_dmw-YId-5i9PTkJ1lQJcg>
    <xme:ZnbRaDhfM0OX2Lq5WpyB3tJfll4w5I-Qn5l0eKv_K3_22gzBOuUnNcJnWHhUUZ5Ia
    _ZlqlJBnxds5_jqiInaGLOVhVJd2hBicJKaObPehly35rVLM7uT648>
X-ME-Received: <xmr:ZnbRaK1sROvbF70OTTbKLHbMICS-QTEm69yIqxEBOQTyT5ISznXVdicPEjLkQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrg
    gurdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdr
    ohhrghdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopehlohhrvghniihordhsthho
    rghkvghssehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihgrmhdrhhhofihlvghtth
    esohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvhgsrggskhgrsehsuhhsvgdrtgiipdhr
    tghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhrvghnsg
    esghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:ZnbRaBWAaa3ZvlckATo-PS4VYNmwipKYxGLBltIUst2gHDGckhBA7Q>
    <xmx:ZnbRaP0eQvImVuLJ8CbwviL4F5DNFyUgr5yjPd4oAAkHc7XQ7AVM_Q>
    <xmx:ZnbRaKgAymiCdrCd6eN25Dner05D4l4QHlFjrXSpC2gUbXLHJ1ZFpQ>
    <xmx:ZnbRaHKCV3DdAJTY82PxaYlJUvJJRj12FLcBTlreC9FaJDoNwfYLYg>
    <xmx:ZnbRaIsnq0pVBi34uUBmBtRE32EFwoaipSoqwycNigdPUkP93iQLd7kS>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:16:37 -0400 (EDT)
Date: Mon, 22 Sep 2025 17:16:36 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/5] mm/fault: Try to map the entire file folio in
 finish_fault()
Message-ID: <n7dly3zxv3wyixmq5yqjijgqjaxzl62ebmsne3tq2zjfqeztgl@ews6hof3zvco>
References: <20250919124036.455709-1-kirill@shutemov.name>
 <20250919124036.455709-5-kirill@shutemov.name>
 <aM5ZwWiFDOuSl6C5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aM5ZwWiFDOuSl6C5@casper.infradead.org>

On Sat, Sep 20, 2025 at 08:37:37AM +0100, Matthew Wilcox wrote:
> On Fri, Sep 19, 2025 at 01:40:35PM +0100, Kiryl Shutsemau wrote:
> > The finish_fault() function uses per-page fault for file folios. This
> > only occurs for file folios smaller than PMD_SIZE.
> > 
> > The comment suggests that this approach prevents RSS inflation.
> > However, it only prevents RSS accounting. The folio is still mapped to
> > the process, and the fact that it is mapped by a single PTE does not
> > affect memory pressure. Additionally, the kernel's ability to map
> > large folios as PMD if they are large enough does not support this
> > argument.
> > 
> > When possible, map large folios in one shot. This reduces the number of
> > minor page faults and allows for TLB coalescing.
> > 
> > Mapping large folios at once will allow the rmap code to mlock it on
> > add, as it will recognize that it is fully mapped and mlocking is safe.
> 
> Does this patch have any measurable effect?  Almost all folios are
> mapped through do_fault_around().  I'm not objecting to the patch,
> but the commit message maybe makes this sound more important than it is.

You are right. My test cases used write faults to populate the VMA.
Mlock accounting is still broken with faultaround.

I will look into this.

I think we would need to rethink how we handle large folios in the
faultaround. 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

