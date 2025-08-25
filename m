Return-Path: <linux-kernel+bounces-785144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB93B34699
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D44F47AB4D9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013BE2FAC02;
	Mon, 25 Aug 2025 16:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="e+aZLe/D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8xAx12V"
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAAD2F0694;
	Mon, 25 Aug 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137692; cv=none; b=KQQ174xf1jfBVyGFyde8mQXluIuVmoaO8XE88O80P0fm/T3x3JOQDHNq65BNeuCWRdrcAuTZY709gTURw5wn4m6CRKbTC2b2DLSVK/4eNNtqwLHTX9U+5KTO5l+4iAHUmlFL9xCnT1Yb9N9ZV32rEnCRSHgs3j5dgmbEt/NXrYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137692; c=relaxed/simple;
	bh=RcK/LTYohFtxhRLXoxsNlDp9lcoVpoPktWnOwvHEx44=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=NmyBWj/K0XBhg9dLHgOQjUsEOA1sQYoJZjTfCfgHQ15jdpJi3S1uLu0mNl/0Z8zbspdBVl/qwnCXzZOAQ7OMsTNBcnc7V7AxN3LWaYTLezxXZvYFfHF2h5VAVWK1t5jfu25nuraLhPX3p41/CuZU31O9oVswURvFfaDP54gIM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=e+aZLe/D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8xAx12V; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 539F81D00061;
	Mon, 25 Aug 2025 12:01:23 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Mon, 25 Aug 2025 12:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756137683;
	 x=1756224083; bh=RcK/LTYohFtxhRLXoxsNlDp9lcoVpoPktWnOwvHEx44=; b=
	e+aZLe/DAVbHygByt+EzlyrGto1kihLj/hWt4fipKxZ7UGbFfEwDPQ4INPRO03cg
	fpsKof5SWIIIYnor0ASipjnIJBsCEJThV4jhUf9pMbQZwC7DdX+xoHyktBw+bF/1
	sNUFo/8dshdILysxBmTbS/InPY46GSCwpcyxQdJyDjo6ZWG3ms1fTh49+sJKxRSd
	MumWTZlPyf/RCzn8dS7+U5/ij0/hO9w3iiAOx1qYozK7pye+wjOxPs7cEr88VB0h
	2dSe3Nw0qvM2QoxJRQO/u4YLh0GPW7zhHn7GDukTOUQqqNBqSpuIP0CNPsZRDLed
	kzEi6iXDIO7HeI58rhadcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756137683; x=
	1756224083; bh=RcK/LTYohFtxhRLXoxsNlDp9lcoVpoPktWnOwvHEx44=; b=P
	8xAx12V3Xth+HP/dkyAOuIp2iEY+OVKN3x1FaHakkY0t6x8pl3s0NnCOpYH3EzIK
	aWcRW/5dVH0HyRHeQdumiJH5a0wXZ4D/2c2w1osx+li3fWPpmLc4PnxuqHVLlnKH
	WrjYtwvVwNjw+HvpwaTn2fzuihAAirf2G0qCtsA9FZBLR8CiiwxxshEcyKIEGdvh
	zAFqk4lHCCUhhWLK7S/y8RLD8n/y0zMKPSz6wtEUtQGp1FBZFBHZ+7oh6XB5eui9
	hT92BcWaWyvcN/7TuY8tfyyvdV33Pp5Rl5BwzFSEcwg8/ozFuOfZgLTeffDQjMdW
	LT7WQ0CqifsSzZfGALy4A==
X-ME-Sender: <xms:0oisaMmJILOXtDDDINCFu53-uIUUg_3zDJt8BZ-BqUOp2yVI5-v6Fg>
    <xme:0oisaL1c5xtrn-p-tQL6TOEPaZa0vJyP5R1MfKrNTEgfszaWSTfkfZAnpNBbqrSx8
    A2S1rOos8BLiMcioo4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedvkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpedtffevgfethfevteduvdefleevkedtuddvlefghefg
    ieekffejteejveffkedthfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhn
    qdhlvghnohhvohesshhquhgvsggsrdgtrgdpnhgspghrtghpthhtohepiedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepkhgvrghntddtgeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepihhlphhord
    hjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplh
    grthhfohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepmhgrrhhkuhhsrdgvlhhfrhhinhhgseifvggsrdguvg
X-ME-Proxy: <xmx:0oisaFXiOWgLRUFjk-PAZdWeLgAX5_eFdtsODmogQlpvB5HIvVtfHQ>
    <xmx:0oisaDKYnak1qaqwLWUnEfhqQvHjNJ0fbwXwRSP2df6rG-lS_a04pg>
    <xmx:0oisaH0nngfUwVtDBU-b4FeClhimbjLJWffDfypgNGAMxB4KZEzUgg>
    <xmx:0oisaJ7ywWqsAiukMfu8aO7CTFl6--VO_BnAy8Bqv4zACz0jjh0oig>
    <xmx:04isaEFogNO1n1_RXJm4TzzH7GGTJb0QoZjSL7aqDwwXfj7Qw_rHlbjz>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8FF712CE0071; Mon, 25 Aug 2025 12:01:22 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxLiYJmP0NXg
Date: Mon, 25 Aug 2025 12:01:02 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Markus Elfring" <Markus.Elfring@web.de>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 RenHai <kean0048@gmail.com>
Message-Id: <22906b4c-7811-4a6b-975b-ba7a73e6ed23@app.fastmail.com>
In-Reply-To: <813948c1-e534-49f8-951a-0b81ae543c7b@web.de>
References: <20250822152549.4077684-1-mpearson-lenovo@squebb.ca>
 <813948c1-e534-49f8-951a-0b81ae543c7b@web.de>
Subject: Re: [PATCH v2 1/3] platform/x86: think-lmi: Add certificate GUID structure
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Markus

On Mon, Aug 25, 2025, at 9:36 AM, Markus Elfring wrote:
>> Add a certificate GUID structure to make it easier to add different
>> options for other platforms that need different GUIDs.
>
> Would a cover letter become helpful for such a patch series?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc3#n310
>
Yep - I'll add that (good timing - I was just about to push v3)

Thanks for the review
Mark


