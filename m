Return-Path: <linux-kernel+bounces-796580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623FAB402C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99144175073
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F1543054E7;
	Tue,  2 Sep 2025 13:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="krjuJKed";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kv7tc5Zl"
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9527B305057
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756819296; cv=none; b=e4LQCgpycFpgwkBQJP4t0dr9IOnUUlKXWUrZfxMzmRyuU27o+gvdbwR3VBDG4MqVdcEW2SV0Yunqdh9h8N+ktJN/UYNfwlO2e1+b11+BvX7we/8GHm493snBawJeDhUOo/bQWmUfQXxFttWh9xJqreQFmAvXjn3efNMu+GVjX2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756819296; c=relaxed/simple;
	bh=4/Fjff2cjH92o3ZuNQmlWkEvWmmi75J/xPgut/CQq2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZT+82qn35ULYYzsbCszW2vk/h05fJidtipblp8paJOdgGP771LUo+4P8/oC1Fqp7vLJmW4hSvQ0aWNpkaUwPOseqCNuI8SpnA0o5umCmBARzg+RjNdKi4qVIUpJtoEk0YIFtFaMfabNkHB8+9M3rLQET8YoB8l1uNk5FPel7Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=krjuJKed; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kv7tc5Zl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id BD37DEC0462;
	Tue,  2 Sep 2025 09:21:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 09:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756819293; x=
	1756905693; bh=nJeUVlALNdS28seLiy00VvLxk+MhX14VjWVeCWs5TeE=; b=k
	rjuJKedvnaeNqhn4Kmqjwnwtd96NVNwXtHdov0Udh6nASk5Jgy9g6owJbgMkKp5x
	AGGDn4PwvzvHoVLJg8pJHAN/zSk9MSodwJAAlXxzZTG5UnagoG7ByvAU8h8TFZFf
	KM3UuKhT0K2nmd9XdRA5p0Tee68WromgZ5rwdoo89/FIYBfJBT4OqEDq2pK91xon
	nG5BZW+w+LVEnEtlf8rcwPFag2rgAW6tAwCHKGJKfEOfM3EH17AsIP7wCvBgwtQO
	qfJ1iXLD35HEqSPNd9fbcXY1pmmb02NBk2usBmIycT1dnS1W8r7CjMDGgKP8DM29
	5n1oN16Y2gao3NxjEQw6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756819293; x=1756905693; bh=nJeUVlALNdS28seLiy00VvLxk+MhX14VjWV
	eCWs5TeE=; b=Kv7tc5ZlsT/vS4+f+LAOEtlMomwc8TPylM+i36u17BukeMBjM5i
	fu6gg/A8n6qzwQm3kpaRbr6xTqAZE4jlifNYV81wwkkeI9Bn1M7fGIadUUAxuWgi
	mi8aonUx2qSLldmeFaPQ5lsF0WKBy5n1hNCOOd71Scn2GXfFgymo4dyOkv4bMfZw
	zkHnwYWX/ZzSmRWvcsSViXc9M5I9Zv08ZGLEAw/OlxQP972FH0FNB73U9X57fgBC
	a7BlbtY4CuFIiZoKu6Y3OuFx0GiQi6ETThh9wlxboSNjI5cFNMpaC9NcD04GCtZa
	gyqF6mvxswKx4db4dYkcuNsSZ89dW/6hHLA==
X-ME-Sender: <xms:XO-2aCNU_Fxda-TrRptuSpIMIbgBIKL-6zZKdfcTpAXtjor3TmTHqg>
    <xme:XO-2aLzWgwRfCZiqhXddAp2QhyfYd58usf-F2KQTXWVDIqWUPWl3_Fym2ffbKDJzS
    LdTk-M2YQiB1WIFZm0>
X-ME-Received: <xmr:XO-2aHgihy4R2mKQig-rV6-mdWuixFAXgmpq4FuxN6jIzf1ECN5TEwh0T3xH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    ffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfuhhhu
    thhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrg
    htthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtleduhfef
    feffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepfeegpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehkvghrnhgvlhesphgrnhhkrghjrhgrgh
    hhrghvrdgtohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghp
    thhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtoheplhhorh
    gvnhiiohdrshhtohgrkhgvshesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepsggrohhl
    ihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguvg
    hvrdhjrghinhesrghrmhdrtghomhdprhgtphhtthhopegsrghohhhurgeskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheprghkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdroh
    hrghdprhgtphhtthhopehnphgrtghhvgesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:XO-2aCQ1CRmyNf7IJSOz8SfvlJfJ4glq7nMIEC-QhiFbIPEHofWZoA>
    <xmx:XO-2aEN5aQdKvgQj8sPeSophDhTeyzKBO5bQf6mt0yxgxw9iyyGIjA>
    <xmx:XO-2aHEefdlTziFsvPcBkhW9aW1UZNL-xh-p1gLTICBAW4--s3_ciw>
    <xmx:XO-2aEiYIM_kwTObNz8DEqQWcG7Yxbh8JfrWB603WzF5K63b1xYUcA>
    <xmx:Xe-2aFqkMbENbYRl7810LXgoMO-OJERlGvRYplzs4Y2Af-4uOtPuv87J>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 09:21:31 -0400 (EDT)
Date: Tue, 2 Sep 2025 14:21:28 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: David Hildenbrand <david@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, mcgrof@kernel.org, gost.dev@samsung.com, 
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Message-ID: <h7pqst5vvkahposrvf2iy5qz53t4crrujold2ky4ssrpawaefv@yaqaj3so2hxi>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
 <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
 <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
 <519df8fd-b02d-4b4b-bf47-79070e3d2c9e@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <519df8fd-b02d-4b4b-bf47-79070e3d2c9e@pankajraghav.com>

On Tue, Sep 02, 2025 at 03:02:23PM +0200, Pankaj Raghav wrote:
> >> I was hitting a weird stale content read error and finally ended up with this fix.
> >>
> >> I thought this is a self-contained patch that can already be upstream. My argument is not that this
> >> should not be reachable, but returning -EINVAL will do the right thing instead of returning 0, which
> >> means success.
> > 
> > Okay, makes sense.
> > 
> > In THP=y case, __folio_split() also returns -EINVAL for !large folios,
> > but it is not very explicit:
> > 
> > 	if (new_order >= folio_order(folio))
> > 		return -EINVAL;
> > 
> > In THP=y, we also issue warning:
> > 
> > 	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);
> > 
> You mean:
> 
> VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);

Yeah, copied wrong line.

> > Makes sense to do the same here for THP=n. It might help to catch cases
> > we do not see with THP=y, like getting non-THP large folios here.
> > 
> 
> Yeah, I think that is a good idea. Something like this:
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 48c4f91c5b13..4ddf9e87db91 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -588,21 +588,29 @@ static inline int
>  split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>                 unsigned int new_order)
>  {
> +       struct folio *folio = page_folio(page);
> +
> +       VM_WARN_ON_ONCE_FOLIO(!folio_test_large(folio), folio);

No. Make it unconditional. The point is we don't expect to see any
splitable folios, so no reason to get here at all.

You can try to use BUILD_BUG(), but it can be too messy.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

