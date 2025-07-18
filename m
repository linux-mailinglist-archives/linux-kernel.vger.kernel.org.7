Return-Path: <linux-kernel+bounces-737003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90104B0A686
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D998916F887
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CCE2DCC03;
	Fri, 18 Jul 2025 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EUNfaqc3"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE486352
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849883; cv=none; b=jfoDfRf7hKhKCicA0vVxqbV0isRXuHtNZf/pqhtxaVxkAXP6iQtXnaI99HxLEAEJI+mSVWHbtH5QpFj4LbCk6+FI9gzo53+9gcukPqjpkeLw9dwYpoECuJnPUCPK7+BSU7ab12N6n8dMya43SaXf0LEdINhak65okfZWsMUULm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849883; c=relaxed/simple;
	bh=JMSkxfrVGFdcMNDQRBcg4B7Mttz9XM7i8ZNBw0tEhaw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a8VJEg/2VOxv/DuccNQ65aU/rPCotuJ6rRboXArpWNd1QbF9L25vj75DBjbvz8sbTdZWSmiGP2KwdIquhOZXhvvDpZ08HLXMMYFcgWjVihUQP1hJigBjd5t8nre2VWI9rZyXwgn7Uo+xsSsWXUX27wBEi7xsmcqHSPIi+9Orqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EUNfaqc3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4E91544318;
	Fri, 18 Jul 2025 14:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752849872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPoXDQSyaVU8ZBQ/QdzHcX0KKdp3rlumZBvZA08cAv0=;
	b=EUNfaqc3sMuZx4jtogKN1gtnWpL4SOkr5pkGQ+gT63f5PrD8EtFWnbaQS6wjx3s0lCRFSw
	D+PLPPHwABPgM5YJX5VxgcQqgvUCqgg76vnVa7DDjDcdcC7DkAL45jEEQsxJPLMGVXwCCf
	HXl3C06posjdxbC+cWdLQTRWzbdrVOB+DFyFGSLAoHY8ElplxfxEAkyYYkxmgIM5DvqxgF
	awqKL+FOj7Vud2z54G/EAGRdd1a8naQOxgqLvjtzoI8E3XZsVN9rq7mdEADfRH/4cUolzX
	4wWFtmlUjvr3F8Y3P6yac1UYN/reYTi/c6VkZk5tLO/VSAFhpt7NchXAd1g9Tw==
Date: Fri, 18 Jul 2025 16:44:29 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michael Walle <mwalle@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/tidss: encoder: convert to devm_drm_bridge_alloc()
Message-ID: <20250718164429.090a4712@booty>
In-Reply-To: <93ab2ae3-46f4-4245-8d2b-e87700372ba6@ideasonboard.com>
References: <20250716134107.4084945-1-mwalle@kernel.org>
	<20250717094153.35f854b7@booty>
	<DBE5Z1SRJ086.NA0KUAWX1MS3@kernel.org>
	<20250717155659.000eb000@booty>
	<93ab2ae3-46f4-4245-8d2b-e87700372ba6@ideasonboard.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehtohhmihdrvhgrlhhkvghinhgvnhesihguvggrshhonhgsohgrrhgurdgtohhmpdhrtghpthhtohepmhifrghllhgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjhihrihdrshgrrhhhrgesihhki
 hdrfhhipdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghh
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Tomi,

On Fri, 18 Jul 2025 14:13:03 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> Hi,
> 
> On 17/07/2025 16:56, Luca Ceresoli wrote:
> > Hello Jyri, Tomi, Michael,
> > 
> > On Thu, 17 Jul 2025 09:49:44 +0200
> > "Michael Walle" <mwalle@kernel.org> wrote:
> >   
> >> Hi,
> >>
> >> thanks for taking a look!
> >>  
> >>> However allocating an encoder using a bridge alloc function (while we
> >>> used to call an encoder allocation function) looks counter-intuitive.
> >>>
> >>> We had discussed on IRC a different idea, adding a wrapper structure
> >>> around the bridge. Quoting your proposal:
> >>>
> >>>   struct tidss_encoder_bridge {
> >>>     struct drm_bridge bridge;
> >>>     struct tidss_encoder *encoder
> >>>   }
> >>>
> >>> and then in the bridge funcs go from drm_bridge to tidss_encoder_brigde
> >>> and use the pointer to get the original private struct.    
> >>
> >> I was doing that until I've realized that meson/meson_encoder_* is
> >> doing it the way this patch does it.  
> > 
> > Which was done by, er, myself. O:-)
> > 
> > To my excuse, meson was using *_encoder_alloc() but rather
> > devm_kzalloc() + drm_simple_encoder_init(), and the change was
> > semi-automated via a coccinelle script, so I didn't fully realize that.
> >   
> >>> That would be cleaner and more intuitive, but use a bit more memory and
> >>> have an additional pointer deref, thus I think we can live with the
> >>> patch you just sent, at least for now.    
> >>
> >> I'm fine with changing it to the wrapper struct. It's your/the
> >> maintainers call :)  
> > 
> > I think the driver maintainers opinion is more relevant, but in lack of
> > one I think we can take the patch as is, given it's already written.
> > 
> > Jyri, Tomi?  
> 
> I think this is fine, even though I do agree the tidss_encoder.c is very
> confusing.
> 
> I'll pick this up. I think drm-misc-next-fixes is the correct branch here.

Looks like to correct branch to me.

Thanks for handling this!

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

