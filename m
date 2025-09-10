Return-Path: <linux-kernel+bounces-810149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE8B5169D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7CC93ACF80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E4E3009C8;
	Wed, 10 Sep 2025 12:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ol4bsgS0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBaSyUWb"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281D25BF18
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506523; cv=none; b=ls+Kq1aS/kB9SjmKc+X2p4Ce/SRH/rx/M8nN9n6cdpb5BcVQl6P34LbntwD5qXO1frWEgg6Hto1+JBSSHAhjKtFFBNl3BffOqrvEPAIJVgH9vdeG6cS77fem/ssDiHGi1k2gvNo6zr/S7za6XlJ0qftoMcJ539VbwWqtz6/naeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506523; c=relaxed/simple;
	bh=/8HVGOMh/sew85wjqfKlUxkrG0pb/Adyz9Sh3yP5MWY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=br6ilI8YePptKx7PC+IA1MtcnCgsw39jN3gnnt1sjiL2m0o+QQUdz0IKnG+ds9CbcBPrJepm0aThPvK3YSjq0VRguqKbVb7GmF8CXuY3ReT7m9S2m70achREiKQqhP60uoOYiNKkB8MkwvlQ1ecDeMNuVr4ANwEMGTQcS+LXHlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ol4bsgS0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBaSyUWb; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6397B140037D;
	Wed, 10 Sep 2025 08:15:19 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 10 Sep 2025 08:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757506519;
	 x=1757592919; bh=yRMyPUn85xb1e1aoe1yrRXBbPWGVjgqZhwJSFEvzvuU=; b=
	ol4bsgS0gAucAgfBetATpbUq1DVhq0A2msg3kRCmHRM0vTFnGsRZUZPgZUFcGvfa
	631bOzB2OkXKxaX3cQCjpccSlbZB9lgckWy0tpWCkRuRv26UBRkLF/DmFa6p1MlY
	Vtqek3+MfQLVn/lo/JWN6wB0+WuiiGWkqKxi77syWLPNDxWuRIAVyv5kCgkXZ60F
	wUHQMvfoOB/WYofWx2pL9lvlC2Vq+krEm6NiIHjUXAj3fHzLJnAHRlOXrdzpGlN3
	AP88BzohD9RWKWfsSDUjXBIXwWSRr87rJAcr/Ss06o+pMjHTBfgHpOckyuZUFwpu
	TfqjA+rHTj8qAwVWd9Mk4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757506519; x=
	1757592919; bh=yRMyPUn85xb1e1aoe1yrRXBbPWGVjgqZhwJSFEvzvuU=; b=P
	BaSyUWbdWQu9ZAWkwqfPRWgp/P1abbgbv0SFjh6zpd1KLfqDk78ZMdZy+8/B5xBt
	wBprAZETB/h/4BwCubAfKh4FrGVSvRYE0dsaJuIfjPSIwEKyLc687FTmz1JszerI
	UOMPhTkIYtA/UCOxIIAA0xSbeJSLhtBKlr0SltgXg9Tnv65zqyHOXVK8fcMgn2Nz
	nRmPBxMyaqtzJQYbfaO2ILlHJ6f4gAd2tYpNPS1YcVooGphIN8xFOAfMIH9d9g1+
	JA7SIasDCvq4i514LnTAVFlBs5taXLf4f6jWH7MBDmHg2Iizz6I0u3n/Rl6kOZ4M
	7kyEGKF0xG4K1n4fxlhxw==
X-ME-Sender: <xms:12vBaNkjCJkhVYlYIuUh4aAQdomTDth3b2lzocKO16-nUyTJlLVwJQ>
    <xme:12vBaI1VrvrgQPYFs0ysvFEs5SzYhnMyWi2ZcwyL1hF6eggdLpX8x2HVIWaBxFv-W
    MvpTBXG_m96b3uYdC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugiesrghrmh
    hlihhnuhigrdhorhhgrdhukhdprhgtphhtthhopehrmhhkodhkvghrnhgvlhesrghrmhhl
    ihhnuhigrdhorhhgrdhukhdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurd
    horhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhg
    pdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrh
    gruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:12vBaA0bSs0aAS17JI6OOHpLFmsToy_PTG6FzNdrpqgFPx_nrO1qgw>
    <xmx:12vBaO4GjHpAD52DyrxRnl-igKCZtpQGXkUTJXnt5HhymmKH8DV95g>
    <xmx:12vBaB8njhXySF2Q7xZx7AW59oxivJeIj7WxG4OmSXRqtGnF2yzMFA>
    <xmx:12vBaNXdGkvwLqYbufbueFeakBxwrqz7F8q5--Q0d9VGuMstw50ksg>
    <xmx:12vBaIvdIgi9uICef38tR01-COmscAgrLyeuaG_Z7RKoI9JwfM_HDe95>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0CFC270006A; Wed, 10 Sep 2025 08:15:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AdnDL2dhGsVg
Date: Wed, 10 Sep 2025 14:14:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 "Russell King" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "Russell King" <rmk+kernel@armlinux.org.uk>,
 "Matthew Wilcox" <willy@infradead.org>
Message-Id: <7dfbb373-fb44-48d1-9880-747faa47e079@app.fastmail.com>
In-Reply-To: <20250910-arm-remove-high-pte-v1-1-d0899882815f@linaro.org>
References: <20250910-arm-remove-high-pte-v1-1-d0899882815f@linaro.org>
Subject: Re: [PATCH] RFC: ARM: drop support for HIGHPTE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 10, 2025, at 11:47, Linus Walleij wrote:
> Matthew Wilcox suggests HIGHPTE is a burden for the
> kernel MM, and only one ARM system (vt8500) is currently
> using it.

I think the vt8500_v6_v7_defconfig entry is a historic leftover,
instead it is currently enabled by default on all configurations
that enable highmem.

> This deletes the use of HIGHPTE in ARM32 clearing the way
> to remove the feature altogether.
>
> It was introduced in commit 65cec8e3db60 "ARM: implement highpte"
> in 2009, so this RFC is intended as a discussion item to
> check if it is still a desired feature 16 years later
> or if we can get rid of it.

We discussed it last year in the context of the PREEMPT_RT patches, see
https://lore.kernel.org/linux-arm-kernel/20241210160556.2341497-4-arnd@kernel.org/
and Russell's reply to that.

I still think that dropping it is the sensible tradeoff here in
the end, as it should allow further simplifications in the
pgalloc code. Your version of this patch doesn't (like my
identical patch from December) actually do any of that though.

> -	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
> +	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
>  	if (!pte)
>  		return NULL;
>  	if (!PageHighMem(pte))

At the minimum, PageHighMem(pte) is now know to be false, so
this could be further simplified. I tried figuring out if we can
remove __HAVE_ARCH_PTE_ALLOC_ONE altogether, but I'm not sure
where else the clean_pte_table() call on arm would happen.

   Arnd

