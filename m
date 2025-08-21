Return-Path: <linux-kernel+bounces-780325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9847B30072
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461971C209B6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FEE2E427B;
	Thu, 21 Aug 2025 16:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="Ng7N4n9h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OSYTZMdM"
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE92E54BA;
	Thu, 21 Aug 2025 16:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794774; cv=none; b=ovCrO5WV5WulXZKoBcfuzlkW9zKzy6XY8+wUjb79woH8moAmPL7ZA2FHS0IM0eJxnwEFB4fqqevOHdF65ZpHS2dtNabAL/CnqITNWEEIl4cjBQnnf4AOreak7anQSuy4N0MjWJX6UMmPXlfRJ8LJENL5uaGCu1+fZ6YMvvw+ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794774; c=relaxed/simple;
	bh=DcrE6+JxXxbNj6GZ08XgNzzMqLYDnItWhUBIpf2DxRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2GJMttrqpyqmfByUaYwGPoI/+X2Z+Q6eZeFowKDqB8WTbQmx9f1qKnJlvLje93TQkOXxgw5/RsHKKxL+IJfyNzfEvk/EK9L3xuQtPKkuW51MWQO1G00DkTyJBGeaGX2V8a5WreL9t1MUKjFiruSUcIHfHEKO3iDQ8ov3HWkLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=Ng7N4n9h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OSYTZMdM; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 4A4F0EC0787;
	Thu, 21 Aug 2025 12:46:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 21 Aug 2025 12:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755794772; x=1755881172; bh=0L3vM6YLmg
	9pq/ypW1IqncbW6S6DkPhBxKBhDP3z0o0=; b=Ng7N4n9hWaKAXoCUELKodmIoji
	oDL3Zzpv7nQCCsaclA0XaLOjXCyXp5c6tn54FhoT3QrxEtGRpF/P4Z/CAcq14OJR
	/BLDh4Y5OVUvMxcE8qZnzEEjzq+hjmbbY8fMuyc6bCWqPpYWmYlpfeWZHXnAOWA8
	+Zt2E4RTMAbjOp1yReYdCwymgE2UXV1FQ8/a12O+RrQK3pjZMyxEnKQG6Gs2YJhs
	wWmw5COkxZzWq5tlC225WBY77NwedNmQJhZyTR0eFntmo7rBe7ANiHYI5t2Zn4vl
	SVLYkck3kIP1XfGIZRCRei4h5rfFtbqQ516kp5whyjPCnKlUD/q5EwXfdV/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755794772; x=1755881172; bh=0L3vM6YLmg9pq/ypW1IqncbW6S6DkPhBxKB
	hDP3z0o0=; b=OSYTZMdMAIaG24G5LpRZuVxYDMHEnqIZNPTIkiKpV/6nKgIx49S
	fGLl2phjvaJ+Bubu2ZbsSY2QBZk3KM0i4LCiwnRhsDjrEiW1pX93GFLxU69c0wWc
	IrgqarCbu5oyv4l2qFxIsRrg8ywScwMbubQZXMiOCJRL1yq9FpQmKjbyINYoB41a
	5CggNO9p9DkUw/qSm3Sd03LZhuSkvQU3KKlM97fvw44hNWQeJMaB9U53pUAiwm1v
	TIaNkV6sae5rNkwvfPDu/ujAOXX4cR5GFAZp4rvmcg9jP8dfeZhzk/X8iUH8Y3fJ
	1AbOkF2uDxu95rhV7uMbpbnbQ72PVesZM/w==
X-ME-Sender: <xms:U02naD1N0U4V6oV3luaKuJXxkv0zi0v6MnhWUXbm4UcDjFzVZxDjtA>
    <xme:U02naPyX0r1a-0rYWFWGTsV2EhBJAIpcy3nqA9cDzCFN1SB-DE0AjmF5g2KC2e_RB
    8kD-gYPmUflUcm_Iyw>
X-ME-Received: <xmr:U02naFoI-v70Z4EWn51BxGS4H7ZZec5W_gZOC-ALfJEclI_XWcD_ZE51OBloEypSOPEhYljIIoCGZ2YGgcF0HiW-zm2KGAWsSqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomheplfgrnhhnvgcu
    ifhruhhnrghuuceojhesjhgrnhhnrghurdhnvghtqeenucggtffrrghtthgvrhhnpefgvd
    ffveelgedujeeffeehheekheelheefgfejffeftedugeethfeuudefheefteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjsehjrghnnhgruh
    drnhgvthdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsvhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlih
    hnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggrlhgs
    iheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlhihsshgrsehrohhsvghniiifvg
    highdrihhopdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohep
    vhhkohhulheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U02naFUjWm7bqMbHMqhQOCBhCTseEZUUqtqp52JO8fKZz8P1qoCuSg>
    <xmx:U02naMr_1gCuchPPYb_lPU7gPd33-HA5ykGlwbhi5ub0OkizlWaajQ>
    <xmx:U02naJGGXIlio0tWiw2kv2dxlo_bRfyM7IUSQTIlc135VcoQnhlV6w>
    <xmx:U02naOtFBjO-D_11veXXRj35ifrFUX03GuGhNW1JFbdYuu5srvLD5A>
    <xmx:VE2naLhO1Uz_DBEYnjSUo92ko0qwruBAvn3Kka33EQIKTm_9aTB1P2JV>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 12:46:11 -0400 (EDT)
Date: Thu, 21 Aug 2025 18:46:10 +0200
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
	Philipp Zabel <p.zabel@pengutronix.de>, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH RFC 13/22] usb: typec: tipd: Read USB4, Thunderbolt and
 DisplayPort status for cd321x
Message-ID: <20250821164610.GF1270980@robin.jannau.net>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
 <20250821-atcphy-6-17-v1-13-172beda182b8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-atcphy-6-17-v1-13-172beda182b8@kernel.org>

On Thu, Aug 21, 2025 at 03:39:05PM +0000, Sven Peter wrote:
> CD321x supports various alternate modes and stores information once
> these are entered into separate status registers. Read those when they
> are active when reading TPS_DATA_STATUS to prepare supporting these.
> 
> Signed-off-by: Sven Peter <sven@kernel.org>
> ---
>  drivers/usb/typec/tipd/core.c | 81 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 77 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 51b0f3be8b66a743ddc3ea96c1b25f597a1e8f6c..59d270eb50ea3dc49ad32ff71f8354e23c1083c9 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -35,14 +35,19 @@
>  #define TPS_REG_INT_MASK2		0x17
>  #define TPS_REG_INT_CLEAR1		0x18
>  #define TPS_REG_INT_CLEAR2		0x19
> -#define TPS_REG_SYSTEM_POWER_STATE	0x20
>  #define TPS_REG_STATUS			0x1a
> +#define TPS_REG_SYSTEM_POWER_STATE	0x20
> +#define TPS_REG_USB4_STATUS		0x24
> +#define TPS_REG_DP_SID_STATUS		0x58

TPS_REG_DP_SID_STATUS is added twice, below in the correct order

>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
>  #define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_PD_STATUS		0x40
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
> +#define TPS_REG_CF_VID_STATUS		0x5e
> +#define TPS_REG_DP_SID_STATUS		0x58

here

Janne

