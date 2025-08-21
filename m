Return-Path: <linux-kernel+bounces-779356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F3AB2F303
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AB68B4E5ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428601AE844;
	Thu, 21 Aug 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ka18AQYl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GrQ80cyk"
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAC92D9EDA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755766607; cv=none; b=udUjSf/O1oRDda1uZp2U/CKxXyJ8cI/7n43EjmQ37N92rlBNirMEInXO6mgxXjDwMhlilbr72Z4meKx/qGgSmEUCCLn0BVWItk9XVY7vZRGVxMNFfjVESXGOdoUEicNocheKgkQKdrP3sw38F+an20GhmEVCKSJmzdvta9mDdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755766607; c=relaxed/simple;
	bh=a1gg61GveMK37Vgat4p5xGihJXs2sVoy0t3OQ7BH/2A=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=PKoaP9nBwLps4cfJsuv64FKUgcUVq/xFHfCeL1dOmCdYNSdtB9Lw8QzBNfrCRLvD61ddhQD8VAErgojHxzOE5GiG81V8ekbTqO7LvlwmTPxtAlq8oqxSr5JDK+oTTViPVon2U/if8BLkFFQt4eE4nFNNZhfROEGORFhwf14H9lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ka18AQYl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GrQ80cyk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id D49E1EC007C;
	Thu, 21 Aug 2025 04:56:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 04:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755766603;
	 x=1755853003; bh=PWUJOpVst/YmMMRlLpZwMEFvROh86/hNVtmyCtTvurw=; b=
	ka18AQYlhBDAu0f0gGvasfnP7Gx4ZkscfHtofGo7wXTdZRpCy212fX5SWsewEwo4
	qSDcO/DoohtC1kUngNakGflIf9cJIF+dr4bm9OON2PZ7zPf0Oswc4kbw8obrEW18
	ZJ/a+Y8RsFi7ywGioMhP6n3f//aNLc8+sUV6ByI8rCZJsEE0iQLLmzhlqDmmbRGU
	jIk3VRK/as38x6mGilROBeHX4dRwB8/ivy4QgtHeFk0xe3ThA05hU2uZrOiJtbys
	ezvMKztRmzk07vAdQn2YDnW9sfvUBiF3m6BecZ84FskqbRf99L5EJO/FgARKhDBM
	XrOTAJ33R69+RLRBr2IxLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755766603; x=
	1755853003; bh=PWUJOpVst/YmMMRlLpZwMEFvROh86/hNVtmyCtTvurw=; b=G
	rQ80cykBTpscz+0cte7aixSEKdpEleELfCJbR+AOsCZyBws8Zvol3u1fZ8Was10c
	4qbmNp6MqUp0ZufnVJJW8P6A983ErEgyTVKYyYeqAWF+qoXaMOrxMvso6L+60aap
	VwH/6f6zyg6qoUzp1P0gj2MK9sWyr9n53E/hpioHusgDpZyUdPqGPjDNa0dRZPxd
	OyD89ri6upLpZ4GGRMHwkESrZ2Rlw9l5A26CfRPYLZeNKiDHgTHkIaN/IhpLUzl/
	tS4/nasrMe66ZOhWaQqckaYLembyaFH9yTIYZY0mQ7g/NikG97RFKnZU7Vzar6d/
	1OemTpBIjip+JV1WkyZAQ==
X-ME-Sender: <xms:S9-maL8pmu64l9nEtKTGP1Z_c2z0MECdFrFst-KkU7KjxuL0AlDG6A>
    <xme:S9-maHt8L3-tFafCR_g7iRdWVuNiM1B2lLTMiziKlOxVdhyK07o7yfTkLR9cIKIjv
    NEvqF09S39XK_mY-gU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrhhishhtihgrnhdrmhgrrhhushhsihesrghrmhdrtghomhdprh
    gtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehf
    vghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepihhmgieslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehpvghnghdrfhgrnhesnhigphdrtghomhdp
    rhgtphhtthhopehpvghnghdrfhgrnhesohhsshdrnhigphdrtghomhdprhgtphhtthhope
    hkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:S9-maOCrP5OE2BCPwQrHUwLMCXuy82-ITAilNRTItJOIwLDeSlthvA>
    <xmx:S9-maOAEkt86365ksOCQbqB8S3f5ZAsbj15tdoOhHEycoWaDomj20w>
    <xmx:S9-maAolDEsGL_wpYjXy7a8YjvVcy8EKHPz8hLy7ixr4CcuRsD0jAQ>
    <xmx:S9-maBHPQ3gnUyk7DSxjdL98zBCCfH7l4UV_om2sWqnuwh_dOKrkFg>
    <xmx:S9-maOXTQFC_sPO9vJCFBxjut-TQnhsM8RCraBoVTttupZ4j0wxVELf5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FF34700068; Thu, 21 Aug 2025 04:56:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6YapAphagno
Date: Thu, 21 Aug 2025 10:56:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Fan" <peng.fan@oss.nxp.com>
Cc: "Peng Fan" <peng.fan@nxp.com>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Sudeep Holla" <sudeep.holla@arm.com>,
 "Cristian Marussi" <cristian.marussi@arm.com>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <b92218a6-e30c-4163-b441-1187d2e429d0@app.fastmail.com>
In-Reply-To: <20250821095657.GB19763@nxa18884-linux.ap.freescale.net>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
 <2ff85fec-b571-4423-9161-674f88a32e18@app.fastmail.com>
 <20250821095657.GB19763@nxa18884-linux.ap.freescale.net>
Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI MISC API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 21, 2025, at 11:56, Peng Fan wrote:
> On Wed, Aug 20, 2025 at 03:55:20PM +0200, Arnd Bergmann wrote:
>>On Thu, Aug 7, 2025, at 03:47, Peng Fan wrote:
>>
>>
>>When a caller of this function is in a built-in driver but the
>>IMX_SCMI_MISC_DRV code is in a loadable module, you still
>>get a link failure, see 514b2262ade4 ("firmware: arm_scmi:
>>Fix i.MX build dependency") for an example.
>>
>>As you still need the correct Kconfig dependencies, I
>>think your patch here is not helpful.
>
> The consumer driver still needs Kconfig dependcies, such as
>   depends on IMX_SCMI_MISC_DRV || !IMX_SCMI_MISC_DRV
>
> So when IMX_SCMI_MISC_DRV is module built, the consumer driver will
> also be module built.
>
> But if IMX_SCMI_MISC_DRV is n, the consumer driver is y, there will be
> link error.
>
> The consumer driver is to support platform A and platform B.
>
> Platform A does not require the real API in IMX_SCMI_MISC_DRV.
> Platform B requires the real API in IMX_SCMI_MISC_DRV.
>
> So when producing an image for platform A, IMX_SCMI_MISC_DRV could set
> to n to make Image smaller. Introducing the stub API is mainly for this
> case.
>
> Hope this is clear

I see. In this case the stub helpers are not wrong, but I
still find them more error-prone than not having them and
using IS_ENABLED() checks as in commit 101c9023594a
("ASoC: fsl_mqs: Support accessing registers by scmi interface"):

+static int fsl_mqs_sm_read(void *context, unsigned int reg, unsigned int *val)
+{
+       struct fsl_mqs *mqs_priv = context;
+       int num = 1;
+
+       if (IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV) &&
+           mqs_priv->soc->ctrl_off == reg)
+               return scmi_imx_misc_ctrl_get(SCMI_IMX_CTRL_MQS1_SETTINGS, &num, val);
+
+       return -EINVAL;
+};

The logic is the same here in the end, but the link failure
is easier to trigger and repair if someone gets it wrong.

Also, for drivers that actually need the exported interface,
the dependency becomes the simpler 'depends on IMX_SCMI_MISC_DRV'.

Which driver using this symbol are you actually looking
at? I see you have three similar patches for a couple of
interfaces, and want to make sure the added complexity is
really needed here. I do a lot of randconfig build tests,
so quite often I end up being the one that runs into
the subtle link failures from these.

      Arnd

