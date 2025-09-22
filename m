Return-Path: <linux-kernel+bounces-827244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFEB9142F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D86521893723
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7BD309DDF;
	Mon, 22 Sep 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Byx+4gU0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H0IPFaD0"
Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2A530AADA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758545700; cv=none; b=a5pqLPGp+4uDK/eC83XO3YoaQUJ+wW3JA/DCgLuqu31bQfw2tskC5UnanZIf2UYRuLxgnsRMIcMJjjqk0nSDF11+aiuaWi3mH2Oz6X6Eu5K4aebpVx1Ht3MdBb3MAUP7pJ/oxUEJayIPM2u4/Evzz+p3I/krFUkBrxKRz7RCECM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758545700; c=relaxed/simple;
	bh=6bhiT9mkGiHIxyKAIy5xJM5rxL4wlxNGm9Smq3GZIGg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WM+jSAUClOsmjIFN+wvy3rjgLyhoPipRfoOblXN52KeaIlQD74Uf2dVxmIeOhNujnI2umj89SHxGz+or+B59z83sesCH0gSy0MTOC8T/2KwDTZ0dZ7PnW7YW4m9NQzCJwN8/YJSCeZlIQzxPuBSHsSyZ/CW9RhZCrk89YMYq32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Byx+4gU0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H0IPFaD0; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id B4DF41380189;
	Mon, 22 Sep 2025 08:54:55 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 22 Sep 2025 08:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758545695;
	 x=1758552895; bh=t36qDepR8M2DCIZbR0pCgjLUAnazHFDPHVI50t3UlR0=; b=
	Byx+4gU0eym5kWVlcDXwUEDI2l9mrErWD5C903u60dnEyaLum9cP1ZuS5KIp+xgV
	ZPhoSR2eD/GkgL674LQAABX9NWS2vtfKwaGvmIMh7dn5zMpqei4YDaKF6Sg1lPqM
	/QYUc0VveyM9znhOFNe0I0Peulxx/MpOzCUQKlSEgPHlsEhuUOD2y6mRk3lDEj02
	VonOHqKY3rqz628mNujxcDBLfdikoS4DkYJFuSM7iVjrVgPyCF1G4xzwHAbC28ak
	vvUqx1uImSJZ0/2d1CaWpImUIRc3GyUcfQGlUAGQNOWn2gPJHn5TvlH9sflGdsBd
	Q080PKF/+Wx2IOzfgFAq3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758545695; x=
	1758552895; bh=t36qDepR8M2DCIZbR0pCgjLUAnazHFDPHVI50t3UlR0=; b=H
	0IPFaD0Bba71iIapHDtSV1s5vKNTmSWg76ZWGgJDWMeMe2uVZv93YLpC6F+3M7WS
	7WR8RZqD6IX9RfHdr78aWjw7DCVCJJDQQAyQV579FYFi5N053564JuPCiuOaoK7E
	jCNWhlk6xzOLMU//k4yHk7ANSniWbtRW6bN+QjnKeFTwCD651tkhjiL2UZK6FT4a
	N+e/Yd+67opM9BzKp4zMCF1uEB2IdBcU4BDnt7dF2IYQtXXKkU2s8zbUPCs7FRgT
	esVXVJWVpb7ki7wYLCkfM9rz4wm7rTHNen16vLJGDFL/xHUUzNYiuVSL2AtqWUoo
	LzUsfYTN6qltg5PEeMddw==
X-ME-Sender: <xms:HkfRaIhwl2BmHC6VY4isyWFya-k04jD6ylI2zmgaqD6hV2yhCcrcAw>
    <xme:HkfRaBA26ySSRAPgSQvT1XYEaaJYts20E0XhpKyqZSIXJCR2OE9jzNtNSAFz8UVQR
    HSJ4LKxnkBuSkZFk1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheplhhinhhugiesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtth
    hopehrmhhkodhkvghrnhgvlhesrghrmhhlihhnuhigrdhorhhgrdhukhdprhgtphhtthho
    pehnrghordhhohhrihhguhgthhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhhosh
    htvgguthesghhoohgumhhishdrohhrghdprhgtphhtthhopehsuhhrvghnsgesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtoheplhhirghohhhurgegsehhuhgrfigvihdrtghomhdprh
    gtphhtthhopehlihhlihhnjhhivgeksehhuhgrfigvihdrtghomhdprhgtphhtthhopehl
    ihhnmhhirghohhgvsehhuhgrfigvihdrtghomhdprhgtphhtthhopeigihgvhihurghnsg
    hinhdusehhuhgrfigvihdrtghomh
X-ME-Proxy: <xmx:HkfRaCigs8Fbeh9nddaAG96q7IyZQvw3aeIYEeOmKg-CRsa1QbL_6Q>
    <xmx:HkfRaCv2xmbmRFslevLLrkDTmmKL1-lKBkFUSXaessp7GPqBHtniAg>
    <xmx:HkfRaE64XxBzr53OG3J0xus2BYuY6_ti3fdW9pt59OdOalF9khdfew>
    <xmx:HkfRaNtIkKJV0zAg5uDGA1LBG8hBH_va0vo4RVrbVfhnUgCeeDvgOQ>
    <xmx:H0fRaKVMmb-oKkRydhvIG9b_njKCBCZyzUrTrxLNyaHqA221GeTlQIFn>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 3037D700065; Mon, 22 Sep 2025 08:54:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AFFCV0QGVXfF
Date: Mon, 22 Sep 2025 14:51:59 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Xie Yuanbin" <xieyuanbin1@huawei.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ard Biesheuvel" <ardb@kernel.org>, "Dave Vasilevsky" <dave@vasilevsky.ca>,
 "David Hildenbrand" <david@redhat.com>, "Eric Biggers" <ebiggers@kernel.org>,
 "Kees Cook" <kees@kernel.org>, liaohua4@huawei.com, lilinjie8@huawei.com,
 linmiaohe@huawei.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 "Russell King" <linux@armlinux.org.uk>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Michal Hocko" <mhocko@suse.com>, nao.horiguchi@gmail.com,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Will Deacon" <will@kernel.org>
Message-Id: <9c0cd24c-559b-4550-9fc8-5dc4bcc20bf7@app.fastmail.com>
In-Reply-To: <20250922082843.26722-1-xieyuanbin1@huawei.com>
References: <727caa4f-5be5-4b59-a10e-8dc9bbc384bf@app.fastmail.com>
 <20250922082843.26722-1-xieyuanbin1@huawei.com>
Subject: Re: [RFC PATCH 1/2] ARM: mm: support memory-failure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 22, 2025, at 10:28, Xie Yuanbin wrote:
>> It would be helpful to be more specific about what you
>> want to do with this.
>> 
>> Are you working on a driver that would actually make use of
>> the exported interface?
>
> Thanks for your reply.
>
> Yes, In fact, we have developed a hardware component to detect DDR bit
> transitions (software does not sense the detection behavior). Once a bit
> transition is detected, an interrupt is reported to the CPU.
>
> On the software side, we have developed a driver module ko to register
> the interrupt callback to perform soft page offline to the corresponding
> physical pages.
>
> In fact, we will export `soft_offline_page` for ko to use (we can ensure
> that it is not called in the interrupt context), but I have looked at the
> code and found that `memory_failure_queue` and `memory_failure` can also
> be used, which are already exported.

Ok

>> I see only a very small number of
>> drivers that call memory_failure(), and none of them are
>> usable on Arm.
>
> I think that not all drivers are in the open source kernel code.
> As far as I know, there should be similar third-party drivers in other
> architectures that use memory-failure functions, like x86 or arm64.
> I am not a specialist in drivers, so if I have made any mistakes,
> please correct me.

I'm not familiar with the memory-failure support, but this sounds
like something that is usually done with a drivers/edac/ driver.
There are many SoC specific drivers, including for 32-bit Arm
SoCs.

Have you considered adding an EDAC driver first? I don't know
how the other platforms that have EDAC drivers handle failures,
but I would assume that either that subsystem already contains
functionality for taking pages offline, or this is something
that should be done in a way that works for all of them without
requiring an extra driver.

      Arnd

