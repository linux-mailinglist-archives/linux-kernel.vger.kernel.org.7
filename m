Return-Path: <linux-kernel+bounces-724011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C749AFED8C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E591C826AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB882E6D12;
	Wed,  9 Jul 2025 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jmrfOYDf"
Received: from relay16.mail.gandi.net (relay16.mail.gandi.net [217.70.178.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EB02E8DF2
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752074265; cv=none; b=dUPh8/hLrtlubXOuKFSF6DED2coqrP4PH2DFQDWmeOCLcQaXdzQXF+jh22UcH0iuTtffo3n4/NkU+XcUzj2rYq9hP3sNOjVuL4jFDwuWZVjprmUASUuK1qrrZ3Abn7UABV6m6yppatCSWRF9PHlfplWFAeimCZDV5nB9QFWV3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752074265; c=relaxed/simple;
	bh=9U3k8vUz958riCVpNfQGHZc8BgezlTwiW8f8yz5jLEs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nESUYVept6JoZga36qHfBCCab9DhaBZunhLsA8XuGWz9EYjbR67VW6wo3NEzUi/TAbClT+dG9k/nMqI4MHgI0gDEsUDoTn5JARG6iawLg1QqaABlUwdOzUcdGU5n2GoutZ1Gdis592DhUw8cjeLQHvwUIUHQFLso6tOyOT2VmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jmrfOYDf; arc=none smtp.client-ip=217.70.178.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A68644A15;
	Wed,  9 Jul 2025 15:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752074260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfLLLC/coJUNS4s3ydMc+7GREukJb5AW44xl+9So/eM=;
	b=jmrfOYDfcslyHG3NucOxWlhR3RZLY5SFKDG/7Qsvjdnd/YC3pMIqTjWI2cXaRNhQYAApH8
	FtoRF3l9Q9s+NOnDMDdgkFIpnMsv18LGDCo7OwVe05xlJyQYKR4kaLJDAy5NEPUEjqPlA/
	uuavvcYDn+Zf8ykKcU1+85mbK3f0p5mAiz4l44N+z6UySPcuUY59OtaUbuTg9hguM9/zbS
	yJJPhgQzJ7WmF2G4vW89UzLnAe3myMfK/aYeIcCRbd5xNq0oXloA4WY02EfvC9S721nUKG
	y7UVcA+MIMB9kiH2tJRUIfOUqk1Ox3/ErfaOszfUGohyxrEnKnmDyYCjZkZSEw==
Date: Wed, 9 Jul 2025 17:17:12 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Alain Volmat <alain.volmat@foss.st.com>, Raphael Gallais-Pou
 <rgallaispou@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Marek Szyprowski <m.szyprowski@samsung.com>, Hui Pu
 <Hui.Pu@gehealthcare.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] drm: fix missing conversions of bridge drivers to
 devm_drm_bridge_alloc()
Message-ID: <20250709171712.768c8985@booty>
In-Reply-To: <20250709-rebel-jackdaw-of-promise-8bf5d3@houat>
References: <20250708-drm-bridge-convert-to-alloc-api-leftovers-v1-0-6285de8c3759@bootlin.com>
	<175205374260.60140.13824257782987722025.b4-ty@bootlin.com>
	<20250709-rebel-jackdaw-of-promise-8bf5d3@houat>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeeklecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfohfogggtgfesthejredtredtvdenucfhrhhomhepnfhutggrucevvghrvghsohhlihcuoehluhgtrgdrtggvrhgvshholhhisegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtleejjeduvddutefftdduleefudfgudeltdeuffeuudefgfdugeekgedtieehudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdgsohhothhlihhnrdgtohhmnecukfhppeekjedruddvtddrvddukedrvddtjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeekjedruddvtddrvddukedrvddtjedphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepuddvpdhrtghpthhtohepmhhrihhprghrugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlrghinhdrvhholhhmrghtsehfohhsshdrshhtrdgtohhmpdhrtghpthhtoheprhhgrghllhgrihhsphhouhesghhmrghilhdrtghomhdprhgtphhtthhopehmrggrrhhtvghnrdhlrghnkhhhohhrshhtsehlihhnuhigrdhin
 hhtvghlrdgtohhmpdhrtghpthhtohepthiiihhmmhgvrhhmrghnnhesshhushgvrdguvgdprhgtphhtthhopegrihhrlhhivggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhimhhonhgrsehffhiflhhlrdgthhdprhgtphhtthhopehmrdhsiiihphhrohifshhkihesshgrmhhsuhhnghdrtghomh

On Wed, 9 Jul 2025 14:05:51 +0200
Maxime Ripard <mripard@kernel.org> wrote:

> On Wed, Jul 09, 2025 at 11:35:42AM +0200, Luca Ceresoli wrote:
> > 
> > On Tue, 08 Jul 2025 17:24:41 +0200, Luca Ceresoli wrote:  
> > > Most DRM bridge drivers have been converted to devm_drm_bridge_alloc() by
> > > [0], but a few drivers were missed. One got converted by [1], this series
> > > converts all the (known) remaining ones.
> > > 
> > > Thanks Marek for having found and reported them!
> > > 
> > > [0] https://lore.kernel.org/all/20250528-drm-bridge-convert-to-alloc-api-v4-1-f04e698c9a77@bootlin.com/
> > > [1] https://lore.kernel.org/all/20250627165652.580798-1-m.szyprowski@samsung.com/
> > > 
> > > [...]  
> > 
> > Applied, thanks!
> > 
> > [1/2] drm/sti: hdmi: convert to devm_drm_bridge_alloc() API
> >       commit: ac4531424d907f3983e919a7bda2b90ea0cede4f
> > [2/2] drm/sti: hda: convert to devm_drm_bridge_alloc() API
> >       commit: 602d565d3c10dfb2dfd397f65078cb603a26a513  
> 
> You sent the patches yesterday, it would have been nice to wait a few
> days for the maintainers to answer.

Apologies. Being a fix, I thought it would make sense to apply them
quickly. Note taken.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

