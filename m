Return-Path: <linux-kernel+bounces-754736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDB6B19B9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B137175B93
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 06:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D61EDA0E;
	Mon,  4 Aug 2025 06:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eDvTaZk3"
Received: from relay15.mail.gandi.net (relay15.mail.gandi.net [217.70.178.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CED19882B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 06:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289117; cv=none; b=KWWVBqT/XQH93gbfZIFfGGCdojf1s/tBbp0UpMLlO+Ys7jzeUkEY6CRV0Cs/L4/YMpP/K71ZV9Z0xZAp1xeA6wKLOlO07JxybhL9CgAlmr5rv9LnA7YWVxGD7sSewQ3EoFMPpdSauBfzPFGmBb2n8ixsEaPK+2RFlywIlhVHJOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289117; c=relaxed/simple;
	bh=GG99R7gLN4sGgR6J/q3H71APfiBbCI3EPW3gOJKxino=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BF2SbhdKZvXbaynUMd7Z0Ne9Wl2gZ7+dnYM9AdXVFX11GcrvbklaZLn089X6Et2kn2+W1UkyEW/WEwBOSNExJ3tn1INrodKHV+UwmKqh4XMamNMPdlokOgNB12dTld/yu+WV7ja2TrCDcj6e1oTz/hYH0OViDIMHE6vBemP7gcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eDvTaZk3; arc=none smtp.client-ip=217.70.178.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E239144281;
	Mon,  4 Aug 2025 06:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754289105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gLDlLSD9fZLuz5Yso1GjOxmc4NefvSELVejvScgC8Ko=;
	b=eDvTaZk3bkqgx1n26ovQ3mqqbNX48z5Xp6NQ1a7MgNuxqX8QJhrSPC/rmQaI8cPdTeWUVj
	QtapNMe49PdRGEGnjJwPFju/rfQp2DnB3X5CcRau27QdUxQ3LrZEff5bL10NbtmKrnYqGI
	PsgDXOxmYeZa39beHABjv6ByeKqoO9cwQzg3wOe7jcKE+Crdl/sLT6zMFeWSglChBiX+l1
	/XfCBMx0wh62iVS/2RJmQ9AI/9o1hLJ9btsv2MkPtQ2jMWDi1EbBgE0gLk4dsRgqoRlENV
	GiJZ2ju9VAVOs8cquXBs6ylBKq46ohHbekB6aQlPkgIkbkPhnIeErKS+PQTGEg==
Date: Mon, 4 Aug 2025 08:31:36 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Liu Ying <victor.liu@nxp.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Hui Pu <Hui.Pu@gehealthcare.com>, Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, Zijun Hu <quic_zijuhu@quicinc.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/9] drm/bridge: get/put the bridge returned by
 drm_bridge_get_next_bridge()
Message-ID: <20250804083136.058353f9@booty>
In-Reply-To: <1ebad5ca-26f3-4a5f-a812-8211129c764a@nxp.com>
References: <20250801-drm-bridge-alloc-getput-drm_bridge_get_next_bridge-v2-0-888912b0be13@bootlin.com>
	<1ebad5ca-26f3-4a5f-a812-8211129c764a@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdegjeejveehhfeigffftefhtdeiffehfeevtdegkeetjefftdevudegiefhvdeknecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgpdhkvghrnhgvlhdrohhrghdpsghoohhtlhhinhdrtghomhenucfkphepfeejrdduiedurdekiedrieehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepfeejrdduiedurdekiedrieehpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvkedprhgtphhtthhopehvihgtthhorhdrlhhiuhesnhigphdrtghomhdprhgtphhtthhopegrnhgurhiivghjrdhhrghjuggrsehinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhgtphhtthhopehrfhhoshhssehkvghrn
 hgvlhdrohhrghdprhgtphhtthhopefnrghurhgvnhhtrdhpihhntghhrghrthesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepjhhonhgrsheskhifihgsohhordhsvgdprhgtphhtthhopehjvghrnhgvjhdrshhkrhgrsggvtgesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhinhhtvghlrdgtohhm

Hello Liu,

thanks for having reviewed this series.

On Mon, 4 Aug 2025 12:02:48 +0800
Liu Ying <victor.liu@nxp.com> wrote:

> Hi Luca,
>=20
> On 08/01/2025, Luca Ceresoli wrote:
> > Note: the cover in v1 was mentioning by mistake
> > drm_bridge_get_last_bridge() instead of drm_bridge_get_next_bridge().
> >                ^^^^
> >=20
> > This series adds drm_bridge_get/put() calls for DRM bridges returned by
> > drm_bridge_get_next_bridge().
> >=20
> > This is part of the work towards removal of bridges from a still existi=
ng
> > DRM pipeline without use-after-free. The grand plan was discussed in [1=
].
> > Here's the work breakdown (=E2=9E=9C marks the current series):
> >=20
> >  1. =E2=9E=9C add refcounting to DRM bridges (struct drm_bridge)
> >     (based on devm_drm_bridge_alloc() [0])
> >     A. =E2=9C=94 add new alloc API and refcounting (in v6.16-rc1)
> >     B. =E2=9C=94 convert all bridge drivers to new API (now in drm-misc=
-next)
> >     C. =E2=9C=94 kunit tests (now in drm-misc-next)
> >     D. =E2=9C=94 add get/put to drm_bridge_add/remove() + attach/detach=
()
> >          and warn on old allocation pattern (now in drm-misc-next)
> >     E. =E2=9E=9C add get/put on drm_bridge accessors
> >        1. =E2=9C=94 drm_bridge_chain_get_first_bridge() + add a cleanup=
 action
> >        2. =E2=9C=94 drm_bridge_get_prev_bridge()
> >        3. =E2=9E=9C drm_bridge_get_next_bridge()
> >        4. =E2=80=A6 drm_for_each_bridge_in_chain()
> >        5. drm_bridge_connector_init
> >        6. of_drm_find_bridge
> >        7. drm_of_find_panel_or_bridge, *_of_get_bridge
> >     F. debugfs improvements
> >  2. handle gracefully atomic updates during bridge removal
> >  3. =E2=80=A6 avoid DSI host drivers to have dangling pointers to DSI d=
evices
> >  4. finish the hotplug bridge work, removing the "always-disconnected"
> >     connector, moving code to the core and potentially removing the
> >     hotplug-bridge itself (this needs to be clarified as points 1-3 are
> >     developed)
> >=20
> > There are various users of drm_bridge_get_next_bridge() which cannot be
> > converted easily. Luckily they are not really looking for the next brid=
ge,
> > but for something else, such as getting the last bridge in the encoder
> > chain or checking whether a bridge is the last in the encoder chain. So
> > introduce better functions for those users and use them instead of
> > drm_bridge_get_next_bridge(), making the code cleaner at the same time.
> >=20
> > Finally add a drm_bridge_get() to drm_bridge_get_next_bridge() and
> > drm_bridge_put() to the remaining, and legitimate, calls.
> >=20
> > [0] https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/0cc6aadd7fc=
1e629b715ea3d1ba537ef2da95eec
> > [1] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2=
c9c3058@bootlin.com/t/#u
> >=20
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > ---
> > Changes in v2:
> > - Use cleanup action in patches 4, 8 and 9
> > - Fix: replace get_last -> get_next in cover
> > - Link to v1: https://lore.kernel.org/r/20250709-drm-bridge-alloc-getpu=
t-drm_bridge_get_next_bridge-v1-0-48920b9cf369@bootlin.com
> >=20
> > ---
> > Luca Ceresoli (9):
> >       list: add list_last_entry_or_null()
> >       drm/bridge: add drm_bridge_chain_get_last_bridge()
> >       drm/bridge: imx93-mipi-dsi: use drm_bridge_chain_get_last_bridge()
> >       drm/omapdrm: use drm_bridge_chain_get_last_bridge()
> >       drm/bridge: add drm_bridge_is_last()
> >       drm/display: bridge_connector: use drm_bridge_is_last()
> >       drm/bridge: get the bridge returned by drm_bridge_get_next_bridge=
()
> >       drm/bridge: put the bridge returned by drm_bridge_get_next_bridge=
()
> >       drm/imx: parallel-display: put the bridge returned by drm_bridge_=
get_next_bridge()
> >=20
> >  drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c    | 12 ++++------
> >  drivers/gpu/drm/display/drm_bridge_connector.c |  5 ++--
> >  drivers/gpu/drm/drm_bridge.c                   |  3 +--
> >  drivers/gpu/drm/imx/ipuv3/parallel-display.c   |  4 ++--
> >  drivers/gpu/drm/omapdrm/omap_drv.c             |  6 ++---
> >  include/drm/drm_bridge.h                       | 32 ++++++++++++++++++=
+++++++-
> >  include/linux/list.h                           | 14 +++++++++++
> >  7 files changed, 57 insertions(+), 19 deletions(-) =20
>=20
> Looks like this one needs to be handled by this patch series?
>=20
> drivers/gpu/drm/omapdrm/omap_encoder.c:101:
> bridge =3D drm_bridge_get_next_bridge(bridge)) {

This is handled in a better way in a separate series, converting the
for_each loops around the bridges in an encoder chain:

https://lore.kernel.org/all/20250723-drm-bridge-alloc-getput-for_each_bridg=
e-v1-9-be8f4ae006e9@bootlin.com/

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

