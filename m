Return-Path: <linux-kernel+bounces-782667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC3EB32361
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00F61D62792
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0492D663B;
	Fri, 22 Aug 2025 20:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="SkgJhKiy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="crzqBWzn"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26224679A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755893293; cv=none; b=sYkjIb7rUmLB+6YEnn4TkLbASepQ0ta+6fnt/RuNiYVDcCsd1/HuH984YCZyu1QeUu/HcM6LLVqh3nJ33UIZ1ck6gUOkopjy1QYrGo3uQZT1MfwhebLb+Xwx/O7GtlUyFi2NhztNwBt1mADpUS4nGtqTPlzAIvSwSiX0hqaVhVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755893293; c=relaxed/simple;
	bh=30d6keUHKkdihh0y9ecvMo3ZMS55MF6bU2ikUKPPpHc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=noqXn+7HPsAcWhyZTx8qtHMjWcfepWZYhaToRgDGXCXWSGk+p+hmfnOBt0Y/whPqJZaHfXPsRzY8Bet+DhlYyajpu+V08/ysC9DxKKrtek81iR4xbawMbwAdl60iIZQXKZLcrQXHozZcaMn7ZdN/SGKTWViKt68f5473TCaqniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=SkgJhKiy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=crzqBWzn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5ADD5EC0104;
	Fri, 22 Aug 2025 16:08:11 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 22 Aug 2025 16:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755893291;
	 x=1755979691; bh=L91uMsaDKpRtyBiHE1yTuatucq2YwRavIJ94jAbMyGY=; b=
	SkgJhKiyB4B+PsjDhyiNsq9e2/kRVFTYMvskDKhqURhrtb+fNImZGkYluEepaZzU
	DyN5VeFSw2YiT+zxxeGoBGs3tok9H7V/N6y2CmmdzQbITGjXoeK/t5Rsp4bWK8BA
	iv18L1OvfQHnywx5klQ/0kAzCN6AITZUxB9giKozkaCb696mzSaErUORwdwbfOHM
	8rZJytcZRPhzF5KBqClzu8eVDOcA2eQyiSKziTl/CBh85/U1wNormV5qD6xQiIRy
	r/I1IOB3jW/NIAoSA2GoAAoA80u2T5RhqEaCIHAjstd1T3waklFRUQXU01CA8Wyp
	g78jooM1Hnjj9TnLqVgGBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755893291; x=
	1755979691; bh=L91uMsaDKpRtyBiHE1yTuatucq2YwRavIJ94jAbMyGY=; b=c
	rzqBWznctbZJ8SzELo6p5saEysjzsruFE79Mhb3QsnN5AeFK5vBPCBeqA+50vl6O
	UUC9H4s8o329fIhAnv1/WC6FHDVYOY0SeJsJNHoHXFEb6+XBVGyK5f8sqvEetXzd
	dJ3w2d62MwrSMczpezAN/+Sf58zYpJ0yFiuJXzSWzYl3k/iKCmkQBDcHYn1vqjqb
	tXaVd6LoaYNGlWjj3So5RYlfpt1bV8CQiLUllAI5rmXQJ42aXGgONZ19Wx0RpLqF
	Xe5QXewyRItvPR904h2JJHwpxTUT1J5VRKqRx2/Bqx/ln83ylQMfQnpybPyOp1Tl
	fQJEJ7TzmKsk94o+NYlkQ==
X-ME-Sender: <xms:Ks6oaJYFWmWnsyxZtBlHCzjpBJUGymeMYS7p0qL-o_WMU6AEbYAemQ>
    <xme:Ks6oaAZBl4pIaQu5iApEvtx3n0FeWfGpFCF5pTnuJz5lPoNAb1nhBrOpsnQt0MEc2
    U5frmoAGbgv-GAXiGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieegieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptghrihhsthhirg
    hnrdhmrghruhhsshhisegrrhhmrdgtohhmpdhrtghpthhtohepshhuuggvvghprdhhohhl
    lhgrsegrrhhmrdgtohhmpdhrtghpthhtohepfhgvshhtvghvrghmsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhrgifnhhguhhosehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdgrrhhmqdhkvghrnhgvlheslhhishhtshdrihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopehimhigsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthht
    ohepphgvnhhgrdhfrghnsehngihprdgtohhmpdhrtghpthhtohepphgvnhhgrdhfrghnse
    hoshhsrdhngihprdgtohhmpdhrtghpthhtohepkhgvrhhnvghlsehpvghnghhuthhrohhn
    ihigrdguvg
X-ME-Proxy: <xmx:Ks6oaAdvRXZSEL-H9_b97a3LRI-xs6S0VVB7g5nLNlxjgLIhScOC7g>
    <xmx:Ks6oaHsmT3AWaEkJTmuBv-5S4OXzc4GiJEk2KykIK6a7j43ruJr40w>
    <xmx:Ks6oaAm2qDzAptP9dHuEzlOoOLr0NqMLdtoFLNx8tN47WdzurD8Mbg>
    <xmx:Ks6oaKSlRs_g60_O4_dE_WBaLed1i1Zuq8KIf6AMnJwGtkjmjAQekA>
    <xmx:K86oaEBNwxtQ3SuUcK5hLmKcLkgu1sfUZWmGcByX5g6Yp_daFUl4SRMY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7A339700068; Fri, 22 Aug 2025 16:08:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6YapAphagno
Date: Fri, 22 Aug 2025 22:07:40 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Fan" <peng.fan@nxp.com>, "Peng Fan" <peng.fan@oss.nxp.com>
Cc: "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Sudeep Holla" <sudeep.holla@arm.com>,
 "Cristian Marussi" <cristian.marussi@arm.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <a93b2235-2a6d-4cb7-9054-10f878805002@app.fastmail.com>
In-Reply-To: 
 <PAXPR04MB8459FAD02E2530FAA21A568A883DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
 <2ff85fec-b571-4423-9161-674f88a32e18@app.fastmail.com>
 <20250821095657.GB19763@nxa18884-linux.ap.freescale.net>
 <b92218a6-e30c-4163-b441-1187d2e429d0@app.fastmail.com>
 <PAXPR04MB8459FAD02E2530FAA21A568A883DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI MISC API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 22, 2025, at 04:35, Peng Fan wrote:
>> Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI

>> The logic is the same here in the end, but the link failure is easier to
>> trigger and repair if someone gets it wrong.
>> 
>> Also, for drivers that actually need the exported interface, the
>> dependency becomes the simpler 'depends on IMX_SCMI_MISC_DRV'.
>
> Yeah, but since consumer drivers supports multiple platforms,
> if platform A not requires the real API in IMX_SCMI_MISC_DRV,
> no need to link the real API.
>
>> 
>> Which driver using this symbol are you actually looking at? I see you
>> have three similar patches for a couple of interfaces, and want to make
>> sure the added complexity is really needed here. I do a lot of
>> randconfig build tests, so quite often I end up being the one that runs
>> into the subtle link failures from these.
>
> The patch is here
> https://lore.kernel.org/linux-remoteproc/20250821-imx95-rproc-1-v5-0-e93191dfac51@nxp.com/T/#macc660f61873742de447ac8c20d34f2d494ff712
>
> Please help give a look.

Thanks for the pointer. Yes, I agree this makes sense then,
and seems harmless since there are only a few drivers that
use the interfaces. I still think that the use conditional
stubs for optional features is problematic when the definition
is in a loadable module, and want to make sure this
is not just done out of habit, but because of a specific
documented requirement.

Please clarify the changelog then, changing the 'Fixes' tags
to a description that explains why you choose to revert my
earlier patches.

      Arnd

