Return-Path: <linux-kernel+bounces-805699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2B8B48C72
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E65734E143A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4A2EAD0D;
	Mon,  8 Sep 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="m9zkb6VF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PCN0wBrb"
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DB91C4A13
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757331877; cv=none; b=DnA/Yw1+tadnQTcIfp5lzuRhzlAHT9wHEKY7GZNft33/dt1alQcH3r+Bw3weA+Ut4W6LM+TtKL0aFQ9e4jn3BSYbZHSUFbSb/YcUH6OtOwcEjteq/5tiWP8ehGkKOTEhEGHUjCjIPto5tk6WH6wxWgUvnzx45yP1GpXNzM4OIbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757331877; c=relaxed/simple;
	bh=ztnAIztCBmv69HlVuR8tyu4Z+36QEqwTR6s9pJWf2Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+ja1tLILwIjIT3S9JdWP9PX9eS6Wb338kvV+C6f6I/taL+OqIM01r93qwHXrTcl6DPsHqF+6/2Oqr+AGMWiDF3EJlvrg60MqBADsC5i/gfcayYNFob5IU31CXCva8lxgO3OuBnZyuOjVRiF0pGbd1Z4qWkkrqssejHteFJEsBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=m9zkb6VF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PCN0wBrb; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id B79C71D00123;
	Mon,  8 Sep 2025 07:44:33 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 08 Sep 2025 07:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1757331873; x=
	1757418273; bh=1M6/UFGInIle7I4iejjoxiDU7Sww+aQnTkk7qcbEtU8=; b=m
	9zkb6VFOIq0HW4QIkQ1OJ3y/juJMppAKqe5MkfooPayKfZcHFlc+Sa2ojxMqlvaI
	fVAPWGDV8prgjieBmETpp+XB6QnzQUJVQfXeMTUo3UDrtdWDhGiicBdO9brB7ku0
	YiDQUnZAlgN5uB5CaPGHyNff57Zn14/XkSLDcm9qlDy2y6qJBaOjlZXL8329eCuF
	tTButgPMktWt/C6qN17SM3FltWsPwq8J9yIPATGOmQvsTd+1YsBLi41g32RFAnKR
	wlOTFWUyZWE+UioAoFg30dludY319KeltPBj8egoLw7ROtShuxFmLh2Hktf+e9F5
	zeAa1/8i3OfkqXu0aeckg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757331873; x=1757418273; bh=1M6/UFGInIle7I4iejjoxiDU7Sww+aQnTkk
	7qcbEtU8=; b=PCN0wBrbABxYccXGJZDikdONsTsC03ptoTDtm5uNHBlen0tfl1x
	ok73M03gjgP7uij9dXp9X1jN3x8UmGDf0okFVFXzKP0qZZZFRlqathoe+zIDOzL6
	yNwkF5u7b49jfWCbYBnhqfEwIfUEtEAk4lq9GKvq80RBWZi3+Xr6KKS1F0w3rkVg
	S26kmJOVL6KzyE54UqODJ6Ayyeh+G4XjKbN804v5gMCf7qb74eqQXTnvsaTCpnj5
	lkio0umhOUs/1+QyzrHBxrtzWwdxcnqXPRRX8e1QyWlsUZoJ6jp2L0A5yIanAQxO
	DL2BcO5TY2E2PBQ9aKpstx96xOOKz064stQ==
X-ME-Sender: <xms:oMG-aNR5aaou8QNKPZKjicpBepZMxlJYbNo0TS9-GkmleqWlHpchNg>
    <xme:oMG-aL5tcQMR9gRjS8zwH_AV9Mgko7E-ltq8HIDbiPLb0AHU4kAJVTvex-dCYQto0
    EVDMSgeEUSkroeQGuw>
X-ME-Received: <xmr:oMG-aKF3vZ7KEOaVbHzp25HLt5z-wkkMNXtd43p4Aa4fu4J549nL66re02jjlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeghecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:oMG-aMl2QLRT8ZCKU--qj0-QdPEwj103k9SI3BILRZJIVroYLPJvzw>
    <xmx:oMG-aNB8mrbAiLCv0uauz2C7hv8A5FS3JI_Wc9gns-YkR_B4h3R3Ig>
    <xmx:oMG-aLHuZODXafUej9Lqit4xCQpVYNStpthQ1prIXYzNwWWfkDYtDg>
    <xmx:oMG-aB8r5D4-6Rv8z1wzddUhfkKG6iyzOHMu_HeOBqV9_ZmTsfErxA>
    <xmx:ocG-aChYG45PeyLgXn5kT18rcrMPTTFisFnct8kCUi8mtMqhztdB1vci>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 07:44:31 -0400 (EDT)
Date: Mon, 8 Sep 2025 12:44:29 +0100
From: Kiryl Shutsemau <kirill@shutemov.name>
To: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	Liam.Howlett@oracle.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	dev.jain@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	lorenzo.stoakes@oracle.com, npache@redhat.com, ryan.roberts@arm.com, usamaarif642@gmail.com, 
	ziy@nvidia.com
Subject: Re: [PATCH v2 1/1] mm: skip mlocked THPs that are underused early in
 deferred_split_scan()
Message-ID: <5j6i2o6umqwxabdfncbrdytmvdma4yrraxe6hu4csckcniduya@sm3mlablwbad>
References: <20250908090741.61519-1-lance.yang@linux.dev>
 <niywtremc5kfhs3lenmfxvbiiizyexnaw3m25twedmzovfoeno@lk2o46tfdklk>
 <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0c07b9-5bf0-4251-8609-fbaf0ca75bf9@redhat.com>

On Mon, Sep 08, 2025 at 01:32:05PM +0200, David Hildenbrand wrote:
> On 08.09.25 12:38, Kiryl Shutsemau wrote:
> > On Mon, Sep 08, 2025 at 05:07:41PM +0800, Lance Yang wrote:
> > > From: Lance Yang <lance.yang@linux.dev>
> > > 
> > > When we stumble over a fully-mapped mlocked THP in the deferred shrinker,
> > > it does not make sense to try to detect whether it is underused, because
> > > try_to_map_unused_to_zeropage(), called while splitting the folio, will not
> > > actually replace any zeroed pages by the shared zeropage.
> > 
> > It makes me think, does KSM follows the same logic as
> > try_to_map_unused_to_zeropage()?
> > 
> > I cannot immediately find what prevents KSM from replacing zeroed mlocked
> > folio with ZERO_PAGE().
> > 
> > Hm?
> 
> I assume if you're using mlock and at the same time enable KSM for a
> process/VMA, you're doing something wrong.
> 
> In contrast, THP is supposed to be transparent (yeah, I know ...).

Yeah, I guess it is user error.

Maybe we should make ksm_compatible() return false for VM_LOCKED?
KSM breaks mlock() contract.

But it can be risky if someone already relies on this broken behaviour.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

