Return-Path: <linux-kernel+bounces-728315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C7DB02679
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714DD7B797E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C2B1F418B;
	Fri, 11 Jul 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="ruTa1Aq0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVOiPQYC"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C1B1991C9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 21:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752270064; cv=none; b=jMLG/+qI21JxPslhxQmuTeVi5kGZjPPGWC0IjppPIHLDmeUO9TRT2HnFeZAsrCtG/fJRwUWeF2BgPO9Gt0iFLAkkhoc5teOPJ2aA226ampMxZVLshzYZD+yu0Y7dOu5U/t3TeNsjpBMQ3I+v2MymQIMq5IyGpAXF7UrjF5Cgmu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752270064; c=relaxed/simple;
	bh=4CCFk6chKoOI9NWxgfWtvu7qw+0Haj5dkeP1Z3js3zg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oA51ZZoaQZtwWXnv6iBXZYurTssaEzRjYuRMMr4J1fieVVt5vdRJqqL2UlEHVaRJJWZIh5lj8gNZAMm2w+QZk0iT66a6PPh2IBzAC+TwHRPkxk24+iYET2SFkErLOFFEYO2rQWS09lARFyqeHUfRY3ZeYShfWYR78vJ8KEB2+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (2048-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=ruTa1Aq0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVOiPQYC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 6C8E2EC01FA;
	Fri, 11 Jul 2025 17:41:00 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 11 Jul 2025 17:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fluxnic.net; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1752270060; x=1752356460; bh=18BS4D7br3
	SvAMyROMtvfMJVLmteV9w1671vK/Gd6Ng=; b=ruTa1Aq0XB4mS4Gx2W+a8bZoKC
	gBfTQyFk04QnnEQFY5CiSCj/iD8qP+NLKaHnrIJGnJBatQGzAPBvV5Jk/aPR//sq
	acB0P0xgM6D+vXLF8jG/mW2AR3VxsrngmypjyRhmI4dGo0qlXWD3J0JFBf8IbPmc
	L6+j+9V6jJmKM3rnamt6ewlg8DaBK0tGvzhDBQ/WURT5hgbZd4OauLf4mPMBz8/X
	URaAjMwF6C8rilnrJHRPOnO+XzymkSMFWTqlVR6Aiik8WROs8gYbhs7cjyFkQQ2K
	3RLig0InfD+gx1ObdFBJgZsngQi5EUK6GHB6RHK3ojZIUr9XPTzbCddcFgBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752270060; x=1752356460; bh=18BS4D7br3SvAMyROMtvfMJVLmteV9w1671
	vK/Gd6Ng=; b=GVOiPQYCTVYbFQafW+lWp9HYl+xMYPndWu4uSvimNfgSisnnobm
	ut1WH11cFb+7vKmFMe5DhybAxGCUJo+Cl+aB9HWokC1w5qlSfg46P3U020ElEdgD
	VYjTQLxv6oyQOz7TxOC3mb3izF19LX2GbJ4oATHw2fw53KB6Eu6jUkkM92PNZqDl
	vQoniRMdZ/KBN/D4ZspWbNf6K92bebojji/YH8zCV/jRbvi0MoWj/AWxlO8P/d/j
	8gxZ15XldQ4UlgPLLT6FhbyBHBojESXXaPNwAEU8YiJ+LHOTEqYuBu9QDuhNj3K5
	trzheVsQ9j8u7lth6uu4SrX/7avpPAVFhwg==
X-ME-Sender: <xms:6oRxaP4kmi1DeDN1Klcp7FQ0gb9rmFXKWID3i7A_oODryaWf-MM7Kw>
    <xme:6oRxaPgjhsdmSm7qm_-hNsaUvhoEdnT24Xkauet0YQaJhmDmXE-N9SRGOFYd41oMs
    Sc8MeBV968IIFlqssQ>
X-ME-Received: <xmr:6oRxaMfWr8J7BV4MsNgcwnlYAmq61Ne6bNR243xsHTfRv3TzbNOxyAIFo4QJpKJIzRnKcPNekba0VGumgjlVxzMM6xDEW0FVcZg2QlAk5NF_P-Gv_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeggeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefujgfkfhggtgesthdtredttddtvdenucfhrhhomheppfhitgholhgrshcu
    rfhithhrvgcuoehnihgtohesfhhluhignhhitgdrnhgvtheqnecuggftrfgrthhtvghrnh
    epkeevleegteevkeelgeekleffveelfeelvdeljedugfekgfehffffieefleffgfdtnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehnihgtohesfhhluhignhhitgdrnhgvthdpnhgspghr
    tghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhirhhonhhgqh
    hinhhgsegsrghiughurdgtohhmpdhrtghpthhtohepuhdrkhhlvghinhgvqdhkohgvnhhi
    ghessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepsghijhhurdgurghsrdhjiiessg
    hprdhrvghnvghsrghsrdgtohhmpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhl
    ihhnuhigsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumh
    hishdrohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtg
    hpthhtohepohhlvghgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhk
    vghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:6oRxaPw4UDp7HGzpCgbhBb5C3XVrscMiYsy2nh-d2xYlD6cHltpGQg>
    <xmx:6oRxaD2Sdm_AdV0ugoaWPblPSCiLcoCvmtBZiVjz6Tnfgfs1Xjeupg>
    <xmx:6oRxaNxKwSZW3M-yembRIBF6_YgI25Oycj7uWNAcvQbKV115bF4AWA>
    <xmx:6oRxaAWJ0yQ74hrvqJJiurlzF-TlWy1vfdYZFdp0qwbcziflIJ_LCQ>
    <xmx:7IRxaGUr48P9nK8mm2YykJjbwod9lwG1Z2AXdmXrIIM6lKAon2PW5yMP>
Feedback-ID: i58514971:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 17:40:58 -0400 (EDT)
Received: from xanadu (xanadu.lan [192.168.1.120])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 94B59124AC34;
	Fri, 11 Jul 2025 17:40:57 -0400 (EDT)
Date: Fri, 11 Jul 2025 17:40:57 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: David Laight <david.laight.linux@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
    u.kleine-koenig@baylibre.com, Oleg Nesterov <oleg@redhat.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Biju Das <biju.das.jz@bp.renesas.com>, rostedt@goodmis.org, 
    lirongqing@baidu.com
Subject: Re: [PATCH v3 next 09/10] lib: mul_u64_u64_div_u64() Optimise the
 divide code
In-Reply-To: <20250711221715.37b0384b@pumpkin>
Message-ID: <n544n0n5-7r7p-n3o6-67s7-q03r026qo1r4@syhkavp.arg>
References: <20250614095346.69130-1-david.laight.linux@gmail.com> <20250614095346.69130-10-david.laight.linux@gmail.com> <20250709152420.4c95c22d@pumpkin> <20250711221715.37b0384b@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Jul 2025, David Laight wrote:

> On Wed, 9 Jul 2025 15:24:20 +0100
> David Laight <david.laight.linux@gmail.com> wrote:
> 
> > On Sat, 14 Jun 2025 10:53:45 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > > Replace the bit by bit algorithm with one that generates 16 bits
> > > per iteration on 32bit architectures and 32 bits on 64bit ones.  
> > 
> > I've spent far too long doing some clock counting exercises on this code.
> > This is the latest version with some conditional compiles and comments
> > explaining the various optimisation.
> > I think the 'best' version is with -DMULDIV_OPT=0xc3
> > 
> >....
> > Some measurements on an ivy bridge.
> > These are the test vectors from the test module with a few extra values on the
> > end that pick different paths through this implementatoin.
> > The numbers are 'performance counter' deltas for 10 consecutive calls with the
> > same values.
> > So the latter values are with the branch predictor 'trained' to the test case.
> > The first few (larger) values show the cost of mispredicted branches.
> 
> I should have included the values for the sames tests with the existing code.
> Added here, but this is includes the change to test for overflow and divide
> by zero after the multiply (no ilog2 calls - which make the 32bit code worse).
> About the only cases where the old code it better are when the quotient
> only has two bits set.

Kudos to you.

I don't think it is necessary to go deeper than this without going crazy.

Given you have your brain wrapped around all the variants at this point, 
I'm deferring to you to create a version for the kernel representing the 
best compromise between performance and  maintainability.

Please consider including the following at the start of your next patch 
series version as this is headed for mainline already:
https://lkml.kernel.org/r/q246p466-1453-qon9-29so-37105116009q@onlyvoer.pbz


Nicolas

