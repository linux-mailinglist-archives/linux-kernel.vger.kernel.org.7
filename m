Return-Path: <linux-kernel+bounces-723173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C019CAFE403
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00271899D8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CED928466C;
	Wed,  9 Jul 2025 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EzxlljvA"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA9E2836B5
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052981; cv=none; b=bwb55dcQfw0uN6ontDJMyupZWXdc4yufPYT/RZjtKizidLdD+XICZCk996NRzqYDU0yIMnODc1UEVbR0Ga9NFit6t96jWtpzTeOk5Tkyew5VTAp9xxkDq+eA7r8aQdD6UYKWbpNGdbvnDy7uWTAnWHWyrzX3ehwqzb6N/rxxmgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052981; c=relaxed/simple;
	bh=BVeqXy6NCtvrV/AwaVVbS7KbsdDCOdTKhf8iDBzR744=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UcNqAvRjLzZmsAb0n5E0NwSoNQfI+KT4ySvl5KYn3SxOKs6GKeZwjjv9W+5ToMZU+j39Bt/P4nDIXzFK06O6vHpsyJAo/h01TH5ICXJeD0LyD2z93kZNVuBvURSnkWDI2uXrV+DyE9Y2lSt31NAkK+Ctf01KpXzBfBuP8bQ7Kkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EzxlljvA; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F20F343295;
	Wed,  9 Jul 2025 09:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752052977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IyzA1qG8ea4Vn/tEOSB1hFQNopWYEwcryzJ/5h8sQ1g=;
	b=EzxlljvAv8uWoRdGFXnEvEBumb1iiwgdAiuGQwWzXyezwkPOaS9kv+oRpMont6qiiOTnH4
	WhhpJM4h2RE5zbIPkygC3enhAeUVqim+g3kdqC+VPndTXiyER7kcKWehAfE5uPir3UjM5e
	KydoUFFlRGWGSOi9XApotEp1rSQYjq/GGUrctxZb9RG0hZ4eVRp4oMec97wXD684WGpRvq
	VkA1qhKgq9+fK2h7Xc2KM9tKxsmFhQpJNbbMLdG/j+ID9Jwjpvvei2YdqSPxsY1j0bXMEg
	OfeLTprxMkZSAN0ttysvlpzQ6drbsZ4FZM+1GoixiwG9CxO2WeWvmiZn2kr3zg==
Date: Wed, 9 Jul 2025 11:22:31 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou
 <rgallaispou@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Marek Szyprowski <m.szyprowski@samsung.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/sti: hda: convert to devm_drm_bridge_alloc()
 API
Message-ID: <20250709112231.05aa90bc@booty>
In-Reply-To: <20250709-foamy-neon-woodpecker-eea693@houat>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
	<20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-2-6285de8c3759@bootlin.com>
	<20250709-foamy-neon-woodpecker-eea693@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjedukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeglefffefghefhtddvfeeufeeiveekgffgleekieduteekkeetvdehudekgfdvvdenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepkeejrdduvddtrddvudekrddvtdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepkeejrdduvddtrddvudekrddvtdejpdhhvghlohepsghoohhthidpmhgrihhlfhhrohhmpehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehmrhhiphgrrhgusehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgrihhnrdhvohhlmhgrthesfhhoshhsrdhsthdrtghomhdprhgtphhtthhopehrghgrlhhlrghishhpohhusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrghrthgvnhdrlhgrnhhkhhhorhhstheslhhinhhugidrihhnthgvlhdrtghomhdprhgtp
 hhtthhopehtiihimhhmvghrmhgrnhhnsehsuhhsvgdruggvpdhrtghpthhtoheprghirhhlihgvugesghhmrghilhdrtghomhdprhgtphhtthhopehsihhmohhnrgesfhhffihllhdrtghhpdhrtghpthhtohepmhdrshiihihprhhofihskhhisehsrghmshhunhhgrdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Maxime,

On Wed, 9 Jul 2025 09:32:28 +0200
Maxime Ripard <mripard@kernel.org> wrote:

...

> > @@ -677,7 +683,6 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
> >  	struct drm_encoder *encoder;
> >  	struct sti_hda_connector *connector;
> >  	struct drm_connector *drm_connector;
> > -	struct drm_bridge *bridge;
> >  	int err;
> >  
> >  	/* Set the drm device handle */
> > @@ -693,13 +698,7 @@ static int sti_hda_bind(struct device *dev, struct device *master, void *data)
> >  
> >  	connector->hda = hda;
> >  
> > -	bridge = devm_kzalloc(dev, sizeof(*bridge), GFP_KERNEL);
> > -	if (!bridge)
> > -		return -ENOMEM;
> > -
> > -	bridge->driver_private = hda;
> > -	bridge->funcs = &sti_hda_bridge_funcs;
> > -	drm_bridge_attach(encoder, bridge, NULL, 0);
> > +	drm_bridge_attach(encoder, &hda->bridge, NULL, 0);  
> 
> It's not entirely related, but the connector is also allocated right
> before and could be moved into the structure instead of storing a
> pointer.
> 
> Either way,
> Reviewed-by: Maxime Ripard <mripard@kernel.org>

Given this patch as-is is fixing a (potentially invisible) bug due to
using the old bridge allocation policy, and the connector allocation
change is an improvements but not a fix, I'll apply as is.

BTW, as a side effect, this series is removing two users of
bridge->driver_private :)

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

