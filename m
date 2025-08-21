Return-Path: <linux-kernel+bounces-779537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C142B2F558
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D81CA7BE648
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AA42FE586;
	Thu, 21 Aug 2025 10:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Q8VCuR+K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y74xPArQ"
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFB22FDC35;
	Thu, 21 Aug 2025 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772191; cv=none; b=EG8s4RBWNGhca6ecIEWrH0T9xKgxdTEfUmDU0GJSfXf4vPtdlEF0zHshLklIJQcTUjczHFhkf8MnHrdhEwCu8WqS3HHzdVvmYeIqtQSt97W+JC2I3fTcI/gAK9IrmRzC4uHBcqNCl/VPv1v+LoW8qMQZth8ybcyexd/Pj5EKrUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772191; c=relaxed/simple;
	bh=C7wjz4BwJV9CcGIgSF+vqU0ftPSJPo3Om2kEWzpbDSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdEqljugjjnAI4V6bdhmehxm4HGHMdRyKSyWsVoocTXtLFbsf2NcIc3BCWmLSbNi7WRP6C9g/VKAQrsYuQmHyGryvvALXTev6O2JHgQhPsy9g3K0Geand0YVHquoENU8OGO0FebmCtobfqYktEPajab/aht/H5Wqy3aOLSKXacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Q8VCuR+K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y74xPArQ; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 34071EC0184;
	Thu, 21 Aug 2025 06:29:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 21 Aug 2025 06:29:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755772189; x=1755858589; bh=EX+OmVsHAL
	FhoO6Ww9SWkxQEx3YLEuoLuDxeJ73Y/hc=; b=Q8VCuR+KJ2eU2Yj1L1IqI6xcvV
	a6S5ZBAtp38yxO6dvPAYK0aKoZpOEzsSmlIIkSuT3gihDHGUiqQsgj8acIpCHXW/
	uF5pgp6XhfT2+RlyjppbxG5zSK6asRHvtGhfoceevnR6PiuFj/AGWRA4Yo9cG0n1
	5AoNAop7iSInUJWyi+hL8U4yG+JPu+9WQX4+UjL8G/v9BJGo2HE9N49CYelOP6fL
	Jrxum0Realj5n0XkwZC4ooC7yTrPVDS6Imc+Y+TXrB2EXehZOFRg8LpfcD2iUeda
	VjrTQHPE6H42Ify9RhZi9wMy6IhNDW6l5UfT1s1Xk31KxAiBSZDU11hXIiZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755772189; x=1755858589; bh=EX+OmVsHALFhoO6Ww9SWkxQEx3YLEuoLuDx
	eJ73Y/hc=; b=Y74xPArQQXGdcaVLCR17ShYvusmgrHJOtbQwJ8XTc7iHo9h327/
	i/vQddq+26nn+N+/Kz1nV6L9PKtXCyaUWcJaWIpr7Cm/84eZPLanA4xmlaljxRZ3
	wZuRtb/KJzwqCMhEGBTR6IseAs5H8ekGt+H2IJcvf45VxjuiXTrDFIml8mFxDit/
	uuoa3dYRcuuRJWSEXT+rga3ZxXBjtEUvYLIi8oO5lSACnTSmrVH5g1n6K7EdeyBX
	Qs7wul+ykCrgANQSvnqdP0BHPfUhMEaWk2afXNsVykJqUUIVwoy+6PMS2Wo19qmS
	hWQ0QaGLXw1U0qIYpc8RlRZxnsiB9u85tYg==
X-ME-Sender: <xms:HPWmaFez2AGDrRjdszOhOSakiWSAhAloVVhAzowPrmhlL8oNZI21OQ>
    <xme:HPWmaJKniL0VFApnlQIx7o6WNpgeLXQHgggbjoszXhacpB57vyheUJjPMUH4bLCpu
    cVm-ozyGcDlfa77CIQ>
X-ME-Received: <xmr:HPWmaLokwvX_7qc-jY8mgvLEbOGSh0cKjnfc56aOToT6AnxomfAMzhhPu4M5dK2sOt5435T1ZURVpu0JTmEwudh7cwPLvszbQgk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhvvghnsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvihhgrdhiohdp
    rhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehkrhiikhdoug
    htsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhgvthhtvghnihhssehophgvnhgsshgurdhorhhgpdhrtg
    hpthhtohepmhgrrhgtrghnsehmrghrtggrnhdrshhtpdhrtghpthhtoheprghsrghhihes
    lhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:HPWmaPvJCtGmjZVJzcl60pjY8Xh26Y-Ckbw7HmSKOeEgo33EsynQNQ>
    <xmx:HPWmaNLNHZ6aR7dav9V4dKFchmF7fh61NcF3dMJiZM7Cvqy-XQfVjg>
    <xmx:HPWmaGoxIW3WLxmleh77I5Y0miTht3-iPmyjJ4iIi-5Umaxej6U2TQ>
    <xmx:HPWmaIU5BWEs5chvI0neYUHlDpaIG-M7aKXmcfxZoy-oDkZBtmCIxw>
    <xmx:HfWmaE93QrR0D0nTe9rnjifrOMaLPReJP1q1595nUIXfIxZ2bdEziFzR>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:29:48 -0400 (EDT)
Date: Thu, 21 Aug 2025 12:29:47 +0200
From: Janne Grunau <j@jannau.net>
To: Rob Herring <robh@kernel.org>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Kettenis <kettenis@openbsd.org>,
	Hector Martin <marcan@marcan.st>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] arm64: dts: apple: t600x: Comple WiFi properties
Message-ID: <20250821102947.GC1270980@robin.jannau.net>
References: <20250813-apple-dt-sync-6-17-v1-0-209f15d10aa0@jannau.net>
 <20250813-apple-dt-sync-6-17-v1-2-209f15d10aa0@jannau.net>
 <20250820190920.GB538860-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250820190920.GB538860-robh@kernel.org>

On Wed, Aug 20, 2025 at 02:09:20PM -0500, Rob Herring wrote:
> On Wed, Aug 13, 2025 at 11:53:34AM +0200, Janne Grunau wrote:
> > From: Hector Martin <marcan@marcan.st>
> 
> What does 'Comple' in the subject mean?

'Complete'. I've changed it locally to
"arm64: dts: apple: t600x: Add missing WiFi properties" and removed
stray words from the end of the commit message.

Janne

