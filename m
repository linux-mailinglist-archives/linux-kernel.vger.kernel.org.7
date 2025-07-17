Return-Path: <linux-kernel+bounces-735388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA52B08E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C78F1886749
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00092F5C55;
	Thu, 17 Jul 2025 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="G6eeNa8b"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C783597A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752760632; cv=none; b=pdAx5KuUsP++R6CeD2pen4iGQTURYz0bWSEuC9UuFXpyK41oAFGt6VpAy5+J5fZHqAKbGw7gC3v313BwgRps2EJEtACNN3Pi/nVp3cccZTS/b2GP6cqt+cKHmOs7DdnKwCbtJ1SOUXhvjqmpolgM2Q0oJktq1tgsxO6gG/8JpEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752760632; c=relaxed/simple;
	bh=JY3u97UlFeucEdDokuQX8N1GR0fp0fNphQBC0cbus6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEIzTcp6y1QElxj8Pu5sy1rJNAqvxgA4cQrAkiHSOq3P8/L1du+VGmDc0/U0Pba/ibZQaHlktz8mxlbcWkpAdurOq8SU2wUNLDhbdsNwhJnB1gwKs58Sw/jpG/NIAT2p3zCNA0gkvREd2xHLkMDi/ZB6pjqQCYg/MO5/KGDylnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=G6eeNa8b; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E627B205B2;
	Thu, 17 Jul 2025 13:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752760622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2275GPVcwLTpmJUdVpObNcbF/MPydXKP4lwgHDAh/50=;
	b=G6eeNa8bfZ3sH7PALjjL6f4NVxtt0RGEsjafdIYFZi806KLKVXWwf5Vj3ic4A03Zqyi3+g
	aDNRPKIGBIchAJunIXi9PF4SBoraBQNM5CiVS/1weri8xQtdTpgDadWdao6njuBfKZWGUb
	fHuPLemZTEHiZ84u8tpNoFmCeIe1XgZS2C3AFUpEIo5f8Sj8+NsBRj1rIHIyQmSRosE7Jm
	pDcWjmlCA4xerpb/7YN+a8Wgxw+NDhhKwRWIKinB60lZAlnuFlMPyPjZ1lfhNi4zoQqPQj
	5aUKpHqZzn9DzcPfkonCWulJbCY3jjal5rwi/uJXuxuaElG626oUYxTEEdmx6A==
Date: Thu, 17 Jul 2025 15:56:59 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: "Michael Walle" <mwalle@kernel.org>, "Jyri Sarha" <jyri.sarha@iki.fi>,
 "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>
Cc: "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/tidss: encoder: convert to devm_drm_bridge_alloc()
Message-ID: <20250717155659.000eb000@booty>
In-Reply-To: <DBE5Z1SRJ086.NA0KUAWX1MS3@kernel.org>
References: <20250716134107.4084945-1-mwalle@kernel.org>
	<20250717094153.35f854b7@booty>
	<DBE5Z1SRJ086.NA0KUAWX1MS3@kernel.org>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhihrhhirdhsrghrhhgrsehikhhirdhfihdprhgtphhtthhopehtohhmihdrvhgrlhhkvghinhgvnhesihguvggrshhonhgsohgrrhgur
 dgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Jyri, Tomi, Michael,

On Thu, 17 Jul 2025 09:49:44 +0200
"Michael Walle" <mwalle@kernel.org> wrote:

> Hi,
> 
> thanks for taking a look!
> 
> > However allocating an encoder using a bridge alloc function (while we
> > used to call an encoder allocation function) looks counter-intuitive.
> >
> > We had discussed on IRC a different idea, adding a wrapper structure
> > around the bridge. Quoting your proposal:
> >
> >   struct tidss_encoder_bridge {
> >     struct drm_bridge bridge;
> >     struct tidss_encoder *encoder
> >   }
> >
> > and then in the bridge funcs go from drm_bridge to tidss_encoder_brigde
> > and use the pointer to get the original private struct.  
> 
> I was doing that until I've realized that meson/meson_encoder_* is
> doing it the way this patch does it.

Which was done by, er, myself. O:-)

To my excuse, meson was using *_encoder_alloc() but rather
devm_kzalloc() + drm_simple_encoder_init(), and the change was
semi-automated via a coccinelle script, so I didn't fully realize that.

> > That would be cleaner and more intuitive, but use a bit more memory and
> > have an additional pointer deref, thus I think we can live with the
> > patch you just sent, at least for now.  
> 
> I'm fine with changing it to the wrapper struct. It's your/the
> maintainers call :)

I think the driver maintainers opinion is more relevant, but in lack of
one I think we can take the patch as is, given it's already written.

Jyri, Tomi?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

