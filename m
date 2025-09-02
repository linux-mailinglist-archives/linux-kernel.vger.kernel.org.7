Return-Path: <linux-kernel+bounces-796433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D15B400BF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C72C93AFE21
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE7B21FF44;
	Tue,  2 Sep 2025 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="gDjAI6uy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A9R1ALHL"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC2721B905
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756816362; cv=none; b=b38Ia3KAYQqh0ZO371owXgzlSBCZxSErMwiq0L9yJ8E6g+HtVWwggm6oqBvF1HPlHd93tHOtZga+VXuQr+pMYOVoWHsD+jWujPT5kmczuEpZF1lCSKyfpJ8yre2pnRrjW6etD1YKiU7teiqTA0IBR/+JCgUGGKd27B/sAPCzJ44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756816362; c=relaxed/simple;
	bh=qPFXZMmmHXzxjNaWtNUzPAOpCImIBk49qd5iQpJ5ytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZeIsK9mDvRuNtUGFmRML+J6kYxoTp0jeoVmSaCCkzMgeHYf+Ur8F+0rxyoJ005mfOSxr/p2eEM27EygVhOKu32Cpu55SGY3vvWIsKTI5DQow+W5tga6tz5C4mKsacUMgOJpMTnHXvzlaVRzwXUI4Qahucg/XEJhU12kxcFalkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=gDjAI6uy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A9R1ALHL; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 15A6E14001E3;
	Tue,  2 Sep 2025 08:32:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 02 Sep 2025 08:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1756816359; x=
	1756902759; bh=+FtZglCWUX4HE6q7QPlc7pf6zeTQT7t5TN4Mt+TpGxQ=; b=g
	DjAI6uy4tOZAnFg6ywGVrNbZtovdWrTb9GA/kYsSmyTuKMx4O72CJPJGG4WUD1Gh
	v+E+2DIqAOp9k1AEseg0pMP9ItMBtzc7zt+LUdng06++4CeIguUfZAI6H5F8LQnn
	YjwV5NieZtzPvUFjhW5mxDBKhrpqMqqFRmgnYBTg7QnGXrsmAV8+egtYg9P7EFgE
	vzPbzd76HwmBHP7fDdrM4AhYx1AuRYObtJxQCrwCCkaQDVZHH6j95CIOcfV9EbCx
	SVqtLkujYnCjbBJqQMAlfqPY7l8cG4GfInkeIZtYb+GGWIdwvzBdvggF1LfkQm5i
	5C990IapVvjBWFst8xB0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756816359; x=1756902759; bh=+FtZglCWUX4HE6q7QPlc7pf6zeTQT7t5TN4
	Mt+TpGxQ=; b=A9R1ALHLw5BMAc22+yvrl1UsjkuHI0XttiKSsVNSWHgiCvKWcdd
	CMM9P1vFA6OfXbG1SHjq3pnDytLxoeSKdlqB0ago1TW8LPRbojRLwNInJ4g5+e10
	lv4qJsM3+pcD34kA76YMe1dyAT1fJbotsZfTnF71FmN55nFd5ne4Frf4AJp1Xf6e
	xW67Mh7yW2/ekIwihKDdzYbnAh4OLKUyzfV8yddGXESbXhipO6cctoCn5u/ntW2E
	JhgOgqUs1EQ6HPyx6quuvxSTbnu80ZP9HndaY3KqHYu+UmJcSaRjnT51vT25hOvZ
	bvRQatEsW/Fpez3gZMOfsdWXNxXeBw8fLVA==
X-ME-Sender: <xms:5eO2aAx-bc5MVSpEeiZs0d8m01MOh8DtWGc2IWPYIghd9EHZ69kxPA>
    <xme:5eO2aPEEJq5xbYbjB98iOSvOnK-xKRKkQLA_7SZXV1hDw2ciaIu3-5uQZomTxZWrm
    t4lJx463DGCpE6YrCg>
X-ME-Received: <xmr:5eO2aAlt9Kx0YB2yyn7TRJzwIV4oDxhV_m6SsHS1iPO4-0ewiEDwtaU806DH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvjecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:5eO2aOE6PJp4_Bc5G-nV6nFNA_UDXPzOgRuu07cAZCWMx2x9qMh5pQ>
    <xmx:5eO2aLy4hhF5Ut-29bvuurfp2q6EjmhZUsBMvvwQxd50CdcNHGoowA>
    <xmx:5eO2aPbag-AFmTw9IEC9R8mmnD6gwOZGDBYlImOqrQp4HK90Hd-oCQ>
    <xmx:5eO2aOla-vqKICj0ACORsiltZ_3PKgjqQSIBzy-2f8lxng6Nti5BFA>
    <xmx:5-O2aHW3cAmiLoOPv2T5qnWuUzxLYlWfKI6oEKs3cOg6Jsdi3yfmR50g>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 08:32:37 -0400 (EDT)
Date: Tue, 2 Sep 2025 13:32:34 +0100
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
Message-ID: <6l6f5idkqebpai6qn6n3phbnydz55typdwmvp3eexwnhk4qr54@otcgssegyqke>
References: <20250902084036.208921-1-kernel@pankajraghav.com>
 <qh7s3j26aac3hyzgnr2ee6byjenstxhjnlwn4qxbvz2l32ohqc@qbhdxvpnuhtp>
 <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90cd5be7-cbe6-42c5-b0eb-bf9613047097@pankajraghav.com>

On Tue, Sep 02, 2025 at 02:15:42PM +0200, Pankaj Raghav wrote:
> 
> On 9/2/25 13:22, Kiryl Shutsemau wrote:
> > On Tue, Sep 02, 2025 at 10:40:36AM +0200, Pankaj Raghav (Samsung) wrote:
> >> From: Pankaj Raghav <p.raghav@samsung.com>
> >>
> >> split_huge_page_to_list_[to_order](), split_huge_page() and
> >> try_folio_split() return 0 on success and error codes on failure.
> >>
> >> When THP is disabled, these functions return 0 indicating success even
> >> though an error code should be returned as it is not possible to split a
> >> folio when THP is disabled.
> > 
> > Other view is that the page is already split therefore nop.
> > 
> >> Make all these functions return -EINVAL to indicate failure instead of
> >> 0.
> >>
> >> This issue was discovered while experimenting enabling large folios
> >> without THP and found that returning 0 in these functions is resulting in
> >> undefined behavior in truncate operations. This change fixes the issue.
> > 
> > Could you elaborate on the undefined behaviour? I don't see it.
> > 
> > If you argue that this code should not be reachable on !THP config, add
> > WARN() there. But I don't see a value.
> 
> Little bit of context:
> 
> I started investigating what it takes to remove large folio dependency on THP[1][2]
> 
> I have some non-upstream changes which enables Large block size (therefore it uses large folios) on
> systems with !CONFIG_THP.
> 
> I was hitting a weird stale content read error and finally ended up with this fix.
> 
> I thought this is a self-contained patch that can already be upstream. My argument is not that this
> should not be reachable, but returning -EINVAL will do the right thing instead of returning 0, which
> means success.

Okay, makes sense.

In THP=y case, __folio_split() also returns -EINVAL for !large folios,
but it is not very explicit:

	if (new_order >= folio_order(folio))
		return -EINVAL;

In THP=y, we also issue warning:

	VM_WARN_ON_ONCE_FOLIO(!folio_test_locked(folio), folio);

Makes sense to do the same here for THP=n. It might help to catch cases
we do not see with THP=y, like getting non-THP large folios here.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

