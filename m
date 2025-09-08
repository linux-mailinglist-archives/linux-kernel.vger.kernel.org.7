Return-Path: <linux-kernel+bounces-806521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0560EB49807
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 470B57AE120
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E317717;
	Mon,  8 Sep 2025 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="W92hAt8z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MIyhvqRj"
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D093164CD;
	Mon,  8 Sep 2025 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355186; cv=none; b=QBYS8YyuPxF09xCFHPo1jJ7H973ScJ+SzA+mHUatFfRfwIdFK9ztjXLzTga3h5uuvzkQr4htqLm3tui6lILhwfykZ/y4fcTipoa/b340stzM9PuIFVh41/9BBshavyLQKU3yijqsSfmkNsf4ACwmcaNyBUqSC4iJ4BX+j8aJRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355186; c=relaxed/simple;
	bh=S/qIFkbE6NWMThaebjnBbzrG7hfvN4q9LxfI84fWnS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPpZFDIoowuiqY6RCqWslTgvvcC7B/JxlJWnAw+5kcxrMmK0bFhBKL3o471kcvoqt2Z09dxZbymf0l4VyWNCBbGvZHTjHmaVdSBXreSPUqROZSmrskeGdpoo5OcViM2ffknuj/AgbslhtHBBkMJuLq8GsIEQnaywVYSzIlLjKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=W92hAt8z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MIyhvqRj; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 952921400182;
	Mon,  8 Sep 2025 14:13:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 08 Sep 2025 14:13:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757355183; x=1757441583; bh=2cuatXLabl
	uJ3CkaEx442uHgntV1NQobYjc7F765Bzw=; b=W92hAt8zipaNUv9cn+SrTvTrzC
	NJOgJzI0vFRPYjQC0AqqzSRUc5/lpz4lxaiMxA/lEUcwhlPM9GoPMWa6BSpysJbn
	APX/lZB6GECks6Rvn+XTrq6ScDnqxa2tGkch66numKlCfbnJ4bLyMOM7IC+QvcCW
	VNTbIeN7dHqbH/IS6L4zH6/bAI4FeMtzGGXapbDK8lzVFKGWz0vK70CtXNfomwaS
	cd/IVW8nrJKxVV/fhaM1VcuWSPQQMWONR39/FJxOFVCEYL8sDdH2VYWSQSelV4xf
	2/JxFf+NoFOq5Cgsci2Z01ulcAzSi0mI0HgfAIfnsriF3xOfmkP3+s1QC7Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757355183; x=1757441583; bh=2cuatXLabluJ3CkaEx442uHgntV1NQobYjc
	7F765Bzw=; b=MIyhvqRjBUNSOm4wZlJKcDOjSu8kP13qHkI8HYpMx7iV24aUAkb
	zMwQzv5dRQ7Pe5djmfH5doAFTRotxOKsbgDKYG7/MqU53yqb3E7rwhdlF25qNltE
	cgMhiR+RZW6JlUfKDUOIwdcJmIeDVFObVxCd80nM2e3i6D0v5QB53i3U5SkytbOg
	jzcyo+ngdUWAdaOxQiL2lzT7yosc8vd6M2HZJrksfnhNgY97+ViR630Pz9VLQMan
	nnIGpLBmzob7B+dGiTpPZYiQ3RxtDSOUGhCt/xhBqxjMN5TknkTgH0FFLU+KYRS0
	ML4f1Dv+l0mTQf+z3RI5E0GSDo6nbUbVvdg==
X-ME-Sender: <xms:rRy_aCckTFKGj3UqR-_A4nAshhxmeBvKRrsXOKpXRzciK99eU_gihg>
    <xme:rRy_aIGul-HuK25gId0D9zFT3dU6eJNh5MjwY6PkjdYV8_jgSnRq8WK4Qte5Dm5qn
    5TA83p6nDA6afu0iu8>
X-ME-Received: <xmr:rRy_aMVDJYMCXZ7F7u3T1dvxz20yYbiCdpGkr_GBmUKUU7JK3mOmqJGPPzJDFMWtEzF-AsdnrIpNX7nIvhGwthTB-t7JkqjhrJ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpeflrghnnhgvucfi
    rhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqnecuggftrfgrthhtvghrnhepgfdvff
    evleegudejfeefheehkeehleehfefgjefffeetudegtefhuedufeehfeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhesjhgrnhhnrghurd
    hnvghtpdhnsggprhgtphhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshhvvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinh
    hugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehrohgshheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrghlsghi
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhihshhsrgesrhhoshgvnhiifigvih
    hgrdhiohdprhgtphhtthhopehnvggrlhesghhomhhprgdruggvvhdprhgtphhtthhopehv
    khhouhhlsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rRy_aIwrJXCWtJE7suPMpRh1ic3XAezkLHTPqNk5dVvUumuVHPHmog>
    <xmx:rRy_aHtkTLHmEb9hd72tiUpEswVJ4suy93U5PZkJR-P98ZPkfM6B1Q>
    <xmx:rRy_aJBwIruCU49cyHDLKYgdLGTOQwQAkxFBHX7_SEII8mCAbQf7dw>
    <xmx:rRy_aDp8LZwOolKR9BCGZ5aeyU9LY80VikcIZTMyymJyBvXGLNdylA>
    <xmx:rxy_aLzHpswtNQp2E782Qjvm7pd021tNXj-BRacdJ6CrKoRTtr8UsX05>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 14:13:01 -0400 (EDT)
Date: Mon, 8 Sep 2025 20:12:59 +0200
From: Janne Grunau <j@jannau.net>
To: Sven Peter <sven@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, Frank Li <Frank.Li@nxp.com>,
	Ran Wang <ran.wang_1@nxp.com>, Peter Chen <peter.chen@nxp.com>,
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
	Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 18/22] phy: apple: Add Apple Type-C PHY
Message-ID: <20250908181259.GC89417@robin.jannau.net>
References: <20250906-atcphy-6-17-v2-0-52c348623ef6@kernel.org>
 <20250906-atcphy-6-17-v2-18-52c348623ef6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250906-atcphy-6-17-v2-18-52c348623ef6@kernel.org>

On Sat, Sep 06, 2025 at 03:43:31PM +0000, Sven Peter wrote:
> The Apple Type-C PHY (ATCPHY) is a PHY for USB 2.0, USB 3.x,
> USB4/Thunderbolt, and DisplayPort connectivity found in Apple Silicon SoCs.
> The PHY handles muxing between these different protocols and also provides
> the reset controller for the attached dwc3 USB controller.
> 
> There is no documentation available for this PHY and the entire sequence
> of MMIO pokes has been figured out by tracing all MMIO access of Apple's
> driver under a thin hypervisor and correlating the register reads/writes
> to their kernel's debug output to find their names. Deviations from this
> sequence generally results in the port not working or, especially when
> the mode is switched to USB4 or Thunderbolt, to some watchdog resetting
> the entire SoC.
> 
> This initial commit already introduces support for Display Port and
> USB4/Thunderbolt but the drivers for these are not ready. We cannot
> control the alternate mode negotiation and are stuck with whatever Apple's
> firmware decides such that any DisplayPort or USB4/Thunderbolt device will
> result in a correctly setup PHY but not be usable until the other drivers
> are upstreamed as well.
> 
> Co-developed-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Janne Grunau <j@jannau.net>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  MAINTAINERS                |    1 +
>  drivers/phy/Kconfig        |    1 +
>  drivers/phy/Makefile       |    1 +
>  drivers/phy/apple/Kconfig  |   14 +
>  drivers/phy/apple/Makefile |    4 +
>  drivers/phy/apple/atc.c    | 2214 ++++++++++++++++++++++++++++++++++++++++++++
>  6 files changed, 2235 insertions(+)

[...]

> diff --git a/drivers/phy/apple/atc.c b/drivers/phy/apple/atc.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..9213485234873fcaafeb1d1d9de3ddf07767d552
> --- /dev/null
> +++ b/drivers/phy/apple/atc.c
> @@ -0,0 +1,2214 @@

[...]

> +static int atcphy_load_tunables(struct apple_atcphy *atcphy)
> +{
> +	int ret;
> +	struct {
> +		const char *dt_name;
> +		struct apple_tunable **tunable;
> +	} tunables[] = {
> +		{ "apple,tunable-fuses", &atcphy->tunables.fuses },
> +		{ "apple,tunable-axi2af", &atcphy->tunables.axi2af },
> +		{ "apple,tunable-common", &atcphy->tunables.common },
> +		{ "apple,tunable-lane0-usb", &atcphy->tunables.lane_usb3[0] },
> +		{ "apple,tunable-lane1-usb", &atcphy->tunables.lane_usb3[1] },
> +		{ "apple,tunable-lane0-cio", &atcphy->tunables.lane_usb4[0] },
> +		{ "apple,tunable-lane1-cio", &atcphy->tunables.lane_usb4[1] },
> +		{ "apple,tunable-lane0-dp", &atcphy->tunables.lane_displayport[0] },
> +		{ "apple,tunable-lane1-dp", &atcphy->tunables.lane_displayport[1] },
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(tunables); i++) {
> +		*tunables[i].tunable =
> +			devm_apple_tunable_parse(atcphy->dev, atcphy->np, tunables[i].dt_name);
> +		if (IS_ERR(tunables[i].tunable)) {
> +			dev_err(atcphy->dev, "Failed to read tunable %s: %ld\n",
> +				tunables[i].dt_name, PTR_ERR(tunables[i].tunable));
> +			return ret;

ret is unitialized here, could be `return PTR_ERR(tunables[i].tunable);`
instead

Janne

