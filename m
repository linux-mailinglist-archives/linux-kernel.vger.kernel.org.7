Return-Path: <linux-kernel+bounces-796340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6A4B3FF1A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B189B4E67EA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94972FFDF7;
	Tue,  2 Sep 2025 11:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mSGou2m3"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8E30DED0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814241; cv=none; b=hX1iZQ+OQ/tp30hLsg50MAahquYZNNmpQTHknCQ9uKPVhtsmPsFxQlWNv21cdnjc1q1H3KbJVDmGQX9RIenL7JJDp4Ipd8XyHhLcMAARr5musRnlWQ0ySSsjSrYT0QZ8mdNWb/mxdwxjtlMVxf+qSnDuGnAmyiPD769X/E9e85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814241; c=relaxed/simple;
	bh=s0JV7tHWQykzSOFu0UchIDXn4q96KyoKVDdZVRBBq6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaL/ZGWFDNVLl8rD8W4dEyBc5tv08ciPGmh+Y9gKedNpryPeGSFKqzjP9MsP9e//06oUhbF29jWsxnTntIN4a1SdVklqjhm0C7+DHUe7ZxQw5TOfNwpeG5o3xyjMNubD7SdYWI44NSDVxcmZcv5GM+k1sE3aGwM7EKFZaYNag4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mSGou2m3; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1F4E1F748;
	Tue,  2 Sep 2025 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1756814235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yfvmzc8qZmjMW4mhkIuHV/6a4hUMeSIVMoLiNUvK0Jk=;
	b=mSGou2m35QWKjYxVcVxQArlWxxMr6rCzPkBdM5epuolTdmwUn/CGj7/YzLOTl95SXL+rdW
	Qmd3zGWZxrgIIbKW+mP6eKYSh2nkdGGx6786bF2vat3cXwuFxalz19AWFtfU8BwLF7FqIb
	HwEk5o3aJ50JovfkLIaBcFPq6JbztM0XfPdvlM/XHM36dfzFSkWl4W5peWJIk4uv7J7mzE
	B4HnnnfW76VCNH6Op4IzHvCpnvsjzC1zrXXa2zqwc7EAjwhGIDfULGU/C/B2OzZzo4Qfiw
	0KqG+//FWeBZMHA88sTqW0lzVIhMgY0wWTGwFuhxHIhocwckKSxb5PZl2e22Cg==
Date: Tue, 2 Sep 2025 13:57:09 +0200
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
Message-ID: <20250902135709.19e1ef54@booty>
In-Reply-To: <aKXRHAyfPHPpZmMs@smile.fi.intel.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
	<20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-1-888912b0be13@bootlin.com>
	<aJJ9ttmL7wiw41fY@smile.fi.intel.com>
	<20250814183609.3788a6df@booty>
	<aKXRHAyfPHPpZmMs@smile.fi.intel.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtoheprghnughriigvjhdrhhgrjhgurgesihhnthgvlhdrtghomhdprhgtphhtthhopehnvghilhdrrghrm
 hhsthhrohhngheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhfohhssheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnfgruhhrvghnthdrphhinhgthhgrrhhtsehiuggvrghsohhnsghorghrugdrtghomhdprhgtphhtthhopehjohhnrghssehkfihisghoohdrshgvpdhrtghpthhtohepjhgvrhhnvghjrdhskhhrrggsvggtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello DRM maintainers,

On Wed, 20 Aug 2025 16:43:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Thu, Aug 14, 2025 at 06:36:09PM +0200, Luca Ceresoli wrote:
> > On Wed, 6 Aug 2025 00:55:02 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> > > On Fri, Aug 01, 2025 at 07:05:23PM +0200, Luca Ceresoli wrote:  
> > > > Add an equivalent of list_first_entry_or_null() to obtain the last element
> > > > of a list.    
> > > 
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>  
> > 
> > Thanks Andy!
> > 
> > However I'm not sure when and where this should be applied.
> > 
> > Except for this one patch, all patches in the series are for
> > drm-misc-next. Also, patch 1 is currently not needed by any other
> > series AFAIK.
> > 
> > Based on the above, is it correct to assume that the whole series can
> > be applied on drm-misc-next? (when other patches will have a
> > R-by/Ack-by of course)
> > 
> > Also, is Andy's A-by enough to apply this patch?  
> 
> The list.h is common for many, I think going via DRM with my Ack is enough
> based on the Git history of my changes in this file. But if you want more
> reliable source, get an Ack from Andrew Morton.

While applying this patch with dim on drm-misc-next, dim push-branch
failed because:

  dim: ERROR: cb86408b1fc2 ("list: add list_last_entry_or_null()"): Mandatory Maintainer Acked-by missing., aborting

Looking at the dim code, it is looking for a Reviewed- or Acked-by from
people listed by `scripts/get_maintainer.pl --no-git-fallback -m --nol
--norolestats`. but that command returns an empty string, so it will
never allow me to push.

How can I get that commit pushed to drm-misc-next?

I think `dim push-branch -f` would work: am I supposed to use it?

(not sure my committer rights allow that)

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

