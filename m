Return-Path: <linux-kernel+bounces-755552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 512C6B1A849
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32103AAB80
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DCB28B417;
	Mon,  4 Aug 2025 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ITL9NUOE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W8x+UTxp"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3B28B3ED
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754326822; cv=none; b=uXnrI19E2yvN+lWhGg8m42y9zJvh0ePU9NkPHzeuP1DchEYUfgv8EyTSKuH056TPr9iEH1xBD3DiwZ6+dzOxq7pqGo7MDrr8uad5gwP92rSBS3+/m3ikFxOX9Y4QlSJY/wijfqg8FYjQ4jLoJPV9VQb9EnzuMM8qfvJOu1nRO/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754326822; c=relaxed/simple;
	bh=OfzG6LeTdCVME0Qj2QTFkwguygfCKOag9eBQL74RbyQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ugbQD3WKzBJZBPl5ta7SKtv67+hSDm7GPyH1LV1KCHp+RvN2dwKZfQXRMfQ3uWDCEJdp5RXpvBpvNa0LdJxf9S/UQCJsOxPL3wWMChuooWE9q4y9/NV6RSy/bQ1IZEvLXfADwGiJNpIorbe63NiW18xMH1t92S4gECu/vFMYyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ITL9NUOE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W8x+UTxp; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41B9E1400172;
	Mon,  4 Aug 2025 13:00:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 04 Aug 2025 13:00:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754326819;
	 x=1754413219; bh=OfzG6LeTdCVME0Qj2QTFkwguygfCKOag9eBQL74RbyQ=; b=
	ITL9NUOE+4ACU5bQiHHDAHt4IQMSljNMtOlgpEAjRfsD5K58bbjpHwDLcCaHJgSf
	CiHWHKL+T1WFjR6roXVjSgq2PKOnFKVKQ95zYXtz5TmENwrdOTKX/I21mtSH3jY2
	9XdrmemHfxR8wt4EH3AXNmi8rmaMMYOe5RUoTmlSZMdFUHy3iCeVzpA5LJH+0DBg
	Mixts30Pp8trKEeUQT5Mua5rlpa+ucy3ECckJCgi33AfJkexHS+SKlJiuzEGoLiS
	hQUWObAjVp+pv2iFgGVyhRtCX0VPt8sUnzDU/t+SbpSKD1G9ssBbPhcl6oXOVrtx
	TP5wy+FcuxnBx3TvhCEW3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754326819; x=
	1754413219; bh=OfzG6LeTdCVME0Qj2QTFkwguygfCKOag9eBQL74RbyQ=; b=W
	8x+UTxpD5muhvZJtIJxyV8nn/icoxVABzTYfItj9DXJzNaip6h0mlxkCXFAqgqvC
	jwawdJORoVO1cmQ7salpPs3Zv7l9LKsQkb9NLVfwfEujUbf4ysm6oO2cIXvD2xQM
	hBRaoL+z4ef6SuPSNBP/eICXHWb9l064ZjzGqxWT21QB15rjlMRZO5cX0gcCNbKA
	KoVa+XIexx+EryKIJmCR+RCm6yEWqSB1RhkgL1jOq/3Wg+GZdgtUDxsp9mkTbtW1
	NIT6thpgMoawFBxripfVNEPdbmN87A669k/QOpkaJPhx5uFKDrxiJpGFbTKGTN14
	Dhm5FKpc6dybwZU/oT4Yg==
X-ME-Sender: <xms:IueQaAwDBJ0xMq3xrlqTq8n-JEpjBAnlQZ-UAGQT4JLLFJNG7kFS_A>
    <xme:IueQaEQwePQBdGKWMfzsLO74eOeYrAVGJTBY-cN8LCnVERQZRbj7XVRfXnhI2n8Ly
    kEnb7djsEBr1pBM7Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuggrnhhivghlrdhlvgiitggrnhhosehlihhnrghrohdrohhrghdprh
    gtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprhgtphhtthhopehsfedv
    sehngihprdgtohhmpdhrtghpthhtohepghhhvghnnhgrughirdhprhhotghophgtihhutg
    esohhsshdrnhigphdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IueQaLgEXpKrTbnQUm9oX7QLLd99577186zlfsy8t7itEk9LS0Q-fQ>
    <xmx:IueQaLuTVqtIOMRDgImPqnS4L7CIyHldf3jAUBR-AwEn3C9w0h7YwA>
    <xmx:IueQaE5Dvl9NbUwZfUaErpsWHJ-oxupdGtgB89pehoKM23IrdRKQTg>
    <xmx:IueQaPMrUEg6vFslDdtlsJjqp0ChnFeuG0sT7Aa5POOYC_vpRNCT1A>
    <xmx:I-eQaDw9j-fJ8Vdt9FMktb5IHeBtPp1UUfjny_TMkk_jfcyU6EPS2kLq>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id C00AF700068; Mon,  4 Aug 2025 13:00:18 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T6c1424fc1c0c8d2b
Date: Mon, 04 Aug 2025 18:59:58 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Daniel Lezcano" <daniel.lezcano@linaro.org>,
 "Thomas Gleixner" <tglx@linutronix.de>
Cc: "NXP S32 Linux Team" <S32@nxp.com>, linux-kernel@vger.kernel.org,
 "Ghennadi Procopciuc" <ghennadi.procopciuc@oss.nxp.com>
Message-Id: <3a37ec10-e247-42fe-b3b3-94d298da3655@app.fastmail.com>
In-Reply-To: <20250804152344.1109310-2-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
 <20250804152344.1109310-2-daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3 01/20] clocksource/drivers/vf-pit: Replace raw_readl/writel to
 reald/writel
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 4, 2025, at 17:23, Daniel Lezcano wrote:
> The driver uses the raw_readl() and raw_writel() functions. Those are
> not for MMIO devices. Replace them with readl() and writel()
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

