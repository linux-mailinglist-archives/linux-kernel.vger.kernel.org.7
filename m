Return-Path: <linux-kernel+bounces-777849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B1ACB2DE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B799E172960
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEF11EB5E1;
	Wed, 20 Aug 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="luK0T24I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdJCO9FG"
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0111E9B37
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698145; cv=none; b=BsqCuHL8z/1b2Hm8gLJpe5QbSvVfmmErS2Zswc++piRPtgAL42IdThLlKm3sCwwujrCTwvEa1nGk3GKNGFBLY4QOzx2Vu3dsnYTgAZ2/gjkNr+2f4C3tz4oVBOzhO+m3ADaX0Qt/MPcqifPRMnlpBxTOq2/fdFaDNQaidPT5AXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698145; c=relaxed/simple;
	bh=rLBJ4js3PcrnHyZMZb2wko0u44OW6C3b/1LbOOIWi3Q=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=FXs1KnSPApax/xqVJkm98jFh3ljbon/CHbLrPhGkm93Zs2uaGQoUrJdemdyNEPvpJ649sxae7aBS9cfSxGu8LUP0nV2XC7iiJFAHHWo7xgZR/e2P9U6axqMpoFTScD1D9hjuAPS/aFetQGbZMWgAYuL9x9R/W49PCQSXudtTtjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=luK0T24I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdJCO9FG; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D62E714003B5;
	Wed, 20 Aug 2025 09:55:41 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 20 Aug 2025 09:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755698141;
	 x=1755784541; bh=fuL07DRJO79zA2iBNSloCcbrQR7X9zT3dVlz/w8Hr0A=; b=
	luK0T24IvqvWu4t0RgdNcMaVI4vQICLNzlHEqzGzR71KZDaSFf2eKG+/3zHHSSzl
	IW0oTNCdyo+oAoM8v0F1QLs0Boyj2Cyd2ZInaMh/Rzw7No4AZcp3hEeaNc1n/tny
	nnEkJMCNKKaKEARW6qUE+38UCODGXOmWr3s99LULlbTriPf+zDNqlndsbv6fpCBF
	zCaCCDZA0Ftkm3iXuiLDkIatM1a9n0s1uwGpYaATuYEzd5hHfjPu3u17Yj1Nehzz
	ZavT95XQBwtw1p5sM1WWkE0jpJXdwL5ihtvbXUEC2zLt21zUKMJwu5TZDkB+7NFq
	ZFEzVC1A/qO+wYt5rMz5Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755698141; x=
	1755784541; bh=fuL07DRJO79zA2iBNSloCcbrQR7X9zT3dVlz/w8Hr0A=; b=R
	dJCO9FGdE/G1X8z8Ffy6zaMhgDAbwWpVCLbIgc1QRVT/sCG4aQxQKHq2NkLa2F64
	Hi/Xe01bDoTi2v0DAp1hezu5v510QE7VRl7APF9UhJFvsrDTJGUgyh1iZ8M9OuZ/
	wbPv1CouOsXUZpGvZw7ja1RIWJ23gkrXey91M1VTtPYiCc+7TJ68pIX7u/yImIAm
	qKgy36XINDSjsMgNQmulCznFKlGq0+KHDUc7pdutzPgLoa6jU99sjJqcrgwv+qnj
	o2p/FTYEuO9F8BWcRaU63Bnkrz9wQLXy1nxhINQyb/QiDxCy4jwX2R3EHcnmkT/f
	JSp9zjAGb+i8vN80mzHVg==
X-ME-Sender: <xms:3dOlaC12QBmR8HOZbmnydAT7i3OzhAwDPz-DIbIDOI2rQJC_UrV-Dw>
    <xme:3dOlaFHbEOq8RNK6O0eLthVhVepbV-UjAMxvWtSwdtySdiWV9dZ3s1q0QyEkG3dMK
    _ki7ofR_qjByp67pBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekheegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrhhishhtihgrnhdrmhgrrhhushhsihesrghrmhdrtghomhdprh
    gtphhtthhopehsuhguvggvphdrhhholhhlrgesrghrmhdrtghomhdprhgtphhtthhopehf
    vghsthgvvhgrmhesghhmrghilhdrtghomhdprhgtphhtthhopehshhgrfihnghhuoheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehl
    ihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepihhmgieslhhishhtsh
    drlhhinhhugidruggvvhdprhgtphhtthhopehpvghnghdrfhgrnhesnhigphdrtghomhdp
    rhgtphhtthhopehkvghrnhgvlhesphgvnhhguhhtrhhonhhigidruggvpdhrtghpthhtoh
    epshdrhhgruhgvrhesphgvnhhguhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:3dOlaMgm8Rx40rQo-fHuLR_nYeJRhd-Z074yzDQqUEJiqxXwq-HExQ>
    <xmx:3dOlaEv1X7VS52qV4C7Qck3weUhbeXo4JOYwp0H8FH78-52p3dZ0iQ>
    <xmx:3dOlaPtY2f3hhBovMMn94Vq0LQx22CJWQFa8eq2w8GDJspbgK7fJWw>
    <xmx:3dOlaJGoLgRoyRePbEX6yKtRuxeH5adOa9bHNDp8ShHnNGL2l4yK5A>
    <xmx:3dOlaP7lRSGUGWmvzpFeTgZvAUkILUMg5UPaiGKMsKqP4IUuQVFHKV-I>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 2F60F700068; Wed, 20 Aug 2025 09:55:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6YapAphagno
Date: Wed, 20 Aug 2025 15:55:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Peng Fan" <peng.fan@nxp.com>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "Sudeep Holla" <sudeep.holla@arm.com>,
 "Cristian Marussi" <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Message-Id: <2ff85fec-b571-4423-9161-674f88a32e18@app.fastmail.com>
In-Reply-To: <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
 <20250807-imx9-sm-v1-1-3489e41a6fda@nxp.com>
Subject: Re: [PATCH 1/3] firmware: imx: Add stub functions for SCMI MISC API
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Aug 7, 2025, at 03:47, Peng Fan wrote:
> To ensure successful builds when CONFIG_IMX_SCMI_MISC_DRV is not enabled,
> this patch adds static inline stub implementations for the following
> functions:
>
>   - scmi_imx_misc_ctrl_get()
>   - scmi_imx_misc_ctrl_set()
>
> These stubs return -EOPNOTSUPP to indicate that the functionality is not
> supported in the current configuration. This avoids potential build or
> link errors in code that conditionally calls these functions based on
> feature availability.
>
> Fixes: 540c830212ed ("firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()")
> Fixes: 0b4f8a68b292 ("firmware: imx: Add i.MX95 MISC driver")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

I don't think this does what you describe, at least not reliably:
 
> +#if IS_ENABLED(CONFIG_IMX_SCMI_MISC_DRV)
>  int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val);
>  int scmi_imx_misc_ctrl_set(u32 id, u32 val);
> +#else
> +static inline int scmi_imx_misc_ctrl_get(u32 id, u32 *num, u32 *val)
> +{
> +	return -EOPNOTSUPP;
> +}

When a caller of this function is in a built-in driver but the
IMX_SCMI_MISC_DRV code is in a loadable module, you still
get a link failure, see 514b2262ade4 ("firmware: arm_scmi:
Fix i.MX build dependency") for an example.

As you still need the correct Kconfig dependencies, I
think your patch here is not helpful.

     Arnd

