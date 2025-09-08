Return-Path: <linux-kernel+bounces-805821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2710CB48DE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07339189698D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E8530147E;
	Mon,  8 Sep 2025 12:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="Pq++my64";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ANIgYuVP"
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDA53002DE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335511; cv=none; b=lLVNznMBF5rnPzFiAkN8Taix6qJNZWzTGKrVG6HUiQScWx3xHFz4y06Q2/1pMOWVqduYyhP7xN9wZZ1LbjWdJK8FoJBno4oTs8PNyqlqI5yFqeHXeoBhLm7w5eJAzhN7b4AkkQaMX2ZMC7/rILO8bevpGrjffWcz7lx1/MNygIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335511; c=relaxed/simple;
	bh=LXkv08yNy+RKMq+nXws12TQyPfa6mtAHsWYnGgQdRJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=he4MXWnynSnsj+6PmUQ+fsmR97NvlHXoL1xMJeely/Y+VdquY7S8l0azxz3qwgphh7JhXPtTzu4ayNFbz0QfpUo9hXPOpRuc7fzcIXVPjr0QFLosf3+CqFiOlBcHny/Scljvu11oqnml+QVxgTCJpcOj8vEeToQcExUcoUeGYTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=Pq++my64; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ANIgYuVP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C76641400013;
	Mon,  8 Sep 2025 08:45:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 08 Sep 2025 08:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757335506; x=
	1757421906; bh=IqcaLM9lUeWqenvd7sIQuIZg09LqmvNIOrji/77fcJ4=; b=P
	q++my64etQX214uWp+G4KUJPfhRX2mudBXuepuWd/8d4Io4tELzDEeXADwbN2qWA
	KFOh8INDTB6wj5YwQ0KZ/x44X+vi7R5g1yri5XgOiZw+zyxn8ff3oXi5rBCV6PRO
	yyNqpD9BozaysJWLIOrLpZCZ14UIik4m8J9uH0+tEqPtsvIJSBdW+JqBbICxV5K9
	DtVI86rDYqPo8+eSWV6C5jTb7hyRCTPuoQmrZI1KfgLO+OfV9/1Z4vJbuADArYAL
	0NpBGRDsxfKVyspEuq/R8FzxpBECNSZVvo0UTGUbg6gRriXO+U2a+NurfgyewWWp
	/DPSZYG3x2vBYasIDGVUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757335506; x=1757421906; bh=IqcaLM9lUeWqenvd7sIQuIZg09LqmvNIOrj
	i/77fcJ4=; b=ANIgYuVPVufOGB762X/PSRKxT/um2lVE4qhiGkHcDme3NiCep7L
	+jnn9W098wUANQEdIwdp8LXY9VPGiPk5SerN9PL4s/Ss0+MLyKslKPzSYwtvYsi+
	Xt5wUAoKlRZ1ihTwTn5Jb8r1hIYoWFHGeBhUue6BHcYvsRsFINoqm5vdzJafPJ+0
	Zakoc224Uh+yHbtItJcXuVCWCQARyvltgqOh3N7UjAfAEn5+q66FonfFJsNplQiY
	j9s94F4My49C9/WfGB4PxyJ3RdZkUzkwlDSG9dH57S5jbMpUrOU762NZ07ZqRjXB
	kGxnlLqvG6y4HDUq0Ya9eW3k1BktJqIjEuQ==
X-ME-Sender: <xms:0s--aFBjwkyO9L3uVP-U6xYv5JBXbFD7yKy6BTYo3Bz9QUXIRpGs5Q>
    <xme:0s--aIo_YsvXsCUGx1HCetFlF3fcN8chc7HCm5Xrc--Z2XO93hO6rGzdX_yeFxc5U
    nKJC_nobMsWB9EQWWo>
X-ME-Received: <xmr:0s--aH0T1GwWKu9_DptJlTYTH4Mhk0QLHw77gthE_hhvSjRVFo5kf4WmFcQsjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvqeenucggtf
    frrghtthgvrhhnpeejheeufeduvdfgjeekiedvjedvgeejgfefieetveffhfdtvddtledu
    hfeffeffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvgdpnhgspghrtghpthhtohepvdek
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopehlrghntggvrdihrghngheslhhinhhugidruggvvhdprhgtphht
    thhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoh
    eplhhirghmrdhhohiflhgvthhtsehorhgrtghlvgdrtghomhdprhgtphhtthhopegsrgho
    hhhurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrohhlihhnrdifrghngheslh
    hinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopeguvghvrdhjrghinhesrghr
    mhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkhdrohhrgh
X-ME-Proxy: <xmx:0s--aHV7uDq_25bKGkKHChSd0o8dvwm4yy2eb7naesuSPVA_twmGuQ>
    <xmx:0s--aAwCd0Iq6umDBH5Rw-wSgA2gdLdvcjnTHHb6AskE8tXbxow4OA>
    <xmx:0s--aD2RTWgd0eJEFprSbO8S4yCvmH9koz4Wy7PgoGZz9y7lnLsWYg>
    <xmx:0s--aLsoC2D3OMeg7ewfPRLe6o4KJaBwHmhbHgYra7kir2s4-hpV6w>
    <xmx:0s--aKQapvKOzdVy5CAvCZ1bA8hq3emL9ArmsLWtYRVR9juCqzwjdzEk>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 08:45:05 -0400 (EDT)
Date: Mon, 8 Sep 2025 13:45:03 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	dev.jain@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com, usamaarif642@gmail.com, 
	ziy@nvidia.com
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Message-ID: <7pmksyuurzi2df5r7d2lpku63rbimjy5e3dzmleb63ik4257ge@2sm7yqfqvolf>
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
 <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>
 <5j6i2o6umqwxabdfncbrdytmvdma4yrraxe6hu4csckcniduya@sm3mlablwbad>
 <f58a472f-4a36-40e7-94d2-229125ae7373@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58a472f-4a36-40e7-94d2-229125ae7373@redhat.com>

On Mon, Sep 08, 2025 at 02:04:05PM +0200, David Hildenbrand wrote:
> On 08.09.25 13:44, Kiryl Shutsemau wrote:
> > On Mon, Sep 08, 2025 at 01:32:05PM +0200, David Hildenbrand wrote:
> > > On 08.09.25 12:38, Kiryl Shutsemau wrote:
> > > > On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
> > > > > From: Lance Yang <lance.yang@linux.dev>
> > > > > 
> > > > > When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> > > > > it does not make sense to try to detect whether it is underused, because
> > > > > try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> > > > > actually replace any zeroed pages by the shared zeropage.
> > > > 
> > > > It makes me think, does KSM follows the same logic as
> > > > try_to_map_unused_to_zeropage()?
> > > > 
> > > > I cannot immediately find what prevents KSM from replacing zeroed mlocked
> > > > folio with ZERO_PAGE().
> > > > 
> > > > Hm?
> > > 
> > > I assume if you're using mlock and at the same time enable KSM for a
> > > process/VMA, you're doing something wrong.
> > > 
> > > In contrast, THP is supposed to be transparent (yeah, I know ...).
> > 
> > Yeah, I guess it is user error.
> > 
> > Maybe we should make ksm_compatible() return false for VM_LOCKED?
> > KSM breaks mlock() contract.
> 
> I was thinking the same and falsely remembered that we would already be
> checking for that.
> 
> > 
> > But it can be risky if someone already relies on this broken behaviour.
> 
> Could be.
> 
> Staring at QEMU, we have the following parameters:
> 
> 	mem-merge=on|off
> 
>     	Enables or disables memory merge support. This feature, when 	
>         supported by the host, de-duplicates identical memory pages
>         among VMs instances (enabled by default).
> 
> And
> 
> 	-overcommit mem-lock=on|off|on-fault
> 
> 	"Run qemu with hints about host resource overcommit. The default
> 	 is to assume that host overcommits all resources."
> 
> 
> Now, I would assume that anybody who sets "-overcommit mem-lock=on" either
> 
> (a) Has KSM disabled on that machine.
> 
> (b) Sets mem-merge=off
> 
> as well. But QEMU would allow for configuring it.

ksm_madvise(MADV_MERGEABLE) succeeds on !vma_ksm_compatible(), so it
wouldn't be functional breakage, but may result in unexpected increase
of memory consumption.

> Interestingly, mm_populate()->populate_vma_page_range() wants to break COW.
> [*]
> 
> But if the app later calls fork(), we still allow for cow-sharing pages with
> the child. (another case of "don't do it", like KSM I guess)

CoW has bunch of these "don't do it". :P

> [*] it doesn't do it for mappings that start out R/O. I think we might end
> up with sharedzero pages in that case, but not sure if worth fixing.
> 
> -- 
> Cheers
> 
> David / dhildenb
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

