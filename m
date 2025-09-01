Return-Path: <linux-kernel+bounces-795096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5DBB3ECC7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4F32067DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 16:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3C30F538;
	Mon,  1 Sep 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mlahX8tV"
Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF41FE451;
	Mon,  1 Sep 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756745860; cv=none; b=cjyLdBViTqk+2z/RTfFQJfDC++AczjHoWyJrnMWNI4zrmAGxoGTS+fGMq56JLTV9Ys/Dgglyy1L6CtY3ozitS74+Gjkjk0JVtzuMdHn5Lgr6UG3y0Uh1MUL3K+oGGNEBN8U1rMcQBwopDUJ3Rrz3SMW4o7u8chbXbLYbMc7Pbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756745860; c=relaxed/simple;
	bh=I86Vxz+FML6UJiiQQ07pUXa+Ht68ArmntE1FKGPSEkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8jZLpmhqdFfKGb6MsEH6DAQEskrJRnYdNePmo/guybqSlXIwwOAuCG3ni+uywOrS2u4TX3G1c4NVk2J5jKyPVWmFLoAcXgvlFqmvcop0hFcBlZzrv0PqoGyMe/1whv5AJn6CIef3wr0f2CGkJBFirEHF6R2YTtZJ/Kp6BqXi8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mlahX8tV; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id DD4965803BE;
	Mon,  1 Sep 2025 16:52:21 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id BE0E0439A1;
	Mon,  1 Sep 2025 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1756745534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QCTr3085Xa6hBKg6QXgP66qPB7i84eR07oEHAnEHSXQ=;
	b=mlahX8tV7/LXhSxxVsp63cubPC3xzgt2qkiUyKjidpy+LUSv8iuoYPjbQO+o2rNtS986m2
	IvBWBpDn1xt4Fimz8IMvijR7avZ5oImvLc2bECeC7rE4tw01mwzsvWWG4aEfP6XNW2YJZ0
	SYRrn+w/1Bry0X6s8aMlrbz5H/WRv8fndqC85XWibkQ42Hmq1Xm6G9PjMCRbBrp1hn9IIt
	dNQX3RGdOmQ1hPLmDpWf6q3xXaUFH2t3tQnPCzmtn2XfOD4IYLZORJwoWsPs+wI39bltyb
	yoIIbgF9sZMfr/gl8J96KFvetpa0TxBglLyNPSol2Q00y9cq592wzSIq0WlfJw==
Date: Mon, 1 Sep 2025 18:52:08 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org,
 cristian.ciocaltea@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, victor.liu@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 devicetree@vger.kernel.org, l.stach@pengutronix.de,
 shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v5 4/7] drm/bridge: dw-hdmi: Add API
 dw_hdmi_set_sample_iec958() for iec958 format
Message-ID: <20250901185208.394cd162@booty>
In-Reply-To: <20250821073131.2550798-5-shengjiu.wang@nxp.com>
References: <20250821073131.2550798-1-shengjiu.wang@nxp.com>
	<20250821073131.2550798-5-shengjiu.wang@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduledvieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeegpdhrtghpthhtohepshhhvghnghhjihhurdifrghnghesnhigphdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehli
 hhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Shengjiu,

On Thu, 21 Aug 2025 15:31:28 +0800
Shengjiu Wang <shengjiu.wang@nxp.com> wrote:

> Add API dw_hdmi_set_sample_iec958() for IEC958 format because audio device
> driver needs IEC958 information to configure this specific setting.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Acked-by: Liu Ying <victor.liu@nxp.com>

[...]

> +void dw_hdmi_set_sample_iec958(struct dw_hdmi *hdmi, unsigned int iec958)
> +{
> +	mutex_lock(&hdmi->audio_mutex);
> +	hdmi->sample_iec958 = iec958;
> +	mutex_unlock(&hdmi->audio_mutex);
> +}

Apologies for jumping in the discussion as late as in v5, but I noticed
this patch and I was wondering whether this mutex_lock/unlock() is
really needed, as you're copying an int.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

