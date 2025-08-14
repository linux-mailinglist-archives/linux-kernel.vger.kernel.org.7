Return-Path: <linux-kernel+bounces-769301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B55B26CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1D31B6303A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05AB2E2654;
	Thu, 14 Aug 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fil2lwKc"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3881E522
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755189384; cv=none; b=dEsbdPPBSFv7MRrGkxJ5trtvwMZc+PS8O0WeMP1EyQSu7u9Eq+tzPD9lno2qrVDG4EDenUlch0fOQmuoC2EIKdQFEAJOJzzZRYdrxiRRKJZwoyR20pFMdw2Ag/Iqwnr2+H5L1Hd9oUrN6FMb4+XpyTxv2N6BI+3SeiQoIt0r0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755189384; c=relaxed/simple;
	bh=CFdKnyzpzwBoDnj4ib6nLUyy5sJS4YX30JIF6lBYW0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUF1Tw7BW6xWPejkvKaIhVToHM1dsGY64nDFEHEv9HjNYXDOte8DFFyt/0+36up68sVb6MMzTcM49DVAUqbWNTotCM6X2OjDHak1e1drHf1ojASUUR2AF7eiFkGeS4i5O693JmZ+N6cmlBwP3zWdWeTZaA6m2wmZj49ztycxja8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fil2lwKc; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB4DF43A06;
	Thu, 14 Aug 2025 16:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755189374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+qSVE3SwQ792/4br6sISUrWbZrX+XAotNnnG0P/uc2c=;
	b=Fil2lwKcZvkJnUIrNLb7xsfihOlI7DqqQxNFJOkQ0xH3gpZHu0cVwZSXht9sajqdrjqfDH
	d1PooQ+SSOT154pyVu4DogeHzxHjZoDsSHNMTPwfFeOWYH0LpaTJ/lNS+EUWbimgit74H6
	R4WlmjWsy6kygiuixo+o1pFqhdB9TsxflJS8PCLLOShOgzCyGsUHsmw9EUBse3RErBzrlD
	xR+Xi9ahXCavsudbNN+XNLd0yTn3eTOPKxot2YffshmbecgkD4XFSOnu/RBKByjQuR5Hsn
	dioTRGuuk+PtSC8+yWNWlkNvr1ViaWndIWBJI1QR7ebMuHHvRgAr5t7WGAPUsA==
Date: Thu, 14 Aug 2025 18:36:09 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Liu Ying
 <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Tomi Valkeinen
 <tomi.valkeinen@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 Hui Pu <Hui.Pu@gehealthcare.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Andrew Morton
 <akpm@linux-foundation.org>, Zijun Hu <quic_zijuhu@quicinc.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/9] list: add list_last_entry_or_null()
Message-ID: <20250814183609.3788a6df@booty>
In-Reply-To: <aJJ9ttmL7wiw41fY@smile.fi.intel.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
	<20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
	<aJJ9ttmL7wiw41fY@smile.fi.intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtjeertdertddvnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgeelffefgfehhfdtvdefueefieevkefggfelkeeiudetkeektedvhedukefgvddvnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdekpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlr
 dgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello relevant maintainers,

On Wed, 6 Aug 2025 00:55:02 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Aug 01, 2025 at 07:05:23PM +0200, Luca Ceresoli wrote:
> > Add an equivalent of list_first_entry_or_null() to obtain the last element
> > of a list.  
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks Andy!

However I'm not sure when and where this should be applied.

Except for this one patch, all patches in the series are for
drm-misc-next. Also, patch 1 is currently not needed by any other
series AFAIK.

Based on the above, is it correct to assume that the whole series can
be applied on drm-misc-next? (when other patches will have a
R-by/Ack-by of course)

Also, is Andy's A-by enough to apply this patch?

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

