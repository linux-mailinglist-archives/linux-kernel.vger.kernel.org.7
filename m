Return-Path: <linux-kernel+bounces-804637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3559AB47AEC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 13:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D600A17E140
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 11:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91AA261586;
	Sun,  7 Sep 2025 11:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="gTHys59t";
	dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b="ljtiOSqf"
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDBD25FA3B;
	Sun,  7 Sep 2025 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.134.29.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757244192; cv=none; b=ulaFLN4yCi8R8YRk/70sfpsqRCi5yndebbvB8040PucgCTE0vM5qhkU1YZxgAI935vPX9QXilAsspm2N5ROAgIO65bXcNMFMO//Fnlxqqb9rQB2p64xh06VeCdK0gDgDk4cBknfVG8vSp0Lr92bb+uj78t/97pmWJJu91mQ5pBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757244192; c=relaxed/simple;
	bh=HigEj1cXFEUCAKS6b1IzogY9piyG2OdqelU9X709n7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMXJ7FbCUbmMhaYXTODefZN1fgiz3vVsRGwjGRvldUGY4yOceXMl4zZXsDTN7sRgRLS4Hr6Ys3IQMg++nY9z8Ukjpznhpr9Po8CKAeeOpGFXXkmsjtdSkFHcGQHN5+jEph+LgAmI1C+n1BsUh5jNBSm63xgOnyq74ezaBMC0PHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org; spf=pass smtp.mailfrom=sigxcpu.org; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=gTHys59t; dkim=pass (2048-bit key) header.d=sigxcpu.org header.i=@sigxcpu.org header.b=ljtiOSqf; arc=none smtp.client-ip=24.134.29.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigxcpu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigxcpu.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757244185; bh=HigEj1cXFEUCAKS6b1IzogY9piyG2OdqelU9X709n7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gTHys59taCZyg7omUl4ZHsFebUuKDaN2zPpJrtChsc5wEaI5UrRD7/vXef5h3hxD2
	 GBW6pHGsbLHws7hF5k71R3XvKAhkLaLIGgeByGP7G1mpSsHaA8/cZ7uEHI/hf+e+KW
	 z4RaTdj6Tn9ztSk58LPGtjPXdU6LFAXyoHQQEdX63OnHzKqgWfXzdJ8Tpj2zjgK4Te
	 XW1PYI/aWe7NEvS036upRY3jgY1R9xVoAo3PJhcf3MR/uvLCWjQqhxbHEDIEJCZ3Ur
	 /hYPeMEVxMvqHnJWGOlV4OvV4tFPeJCA92l+TLMB2jGvkvogedfTEnBICOStCXXbli
	 Y673alkYSN86Q==
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 57932FB04;
	Sun,  7 Sep 2025 13:23:05 +0200 (CEST)
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dJfWR9cpiJyv; Sun,  7 Sep 2025 13:23:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=sigxcpu.org; s=2024;
	t=1757244183; bh=HigEj1cXFEUCAKS6b1IzogY9piyG2OdqelU9X709n7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ljtiOSqfHUULLDkVc0ByzsACZCM9Zm4ajIY1JgU/gmytkFQce6+ZU8hJQyepPgxSx
	 Ie895IGzPJ1yl5+z6DT7of0XxwDAXpDO9L7niW1yxWU36vXnKrwr3fLylKiO+Et4xX
	 0zA3zUV3rTjC0H1ltNr8OyXF/szlgAjQfvxG1guQr6CjzsY+WLdO5nYvNEbgA+X4wq
	 NJRM1v62vIqjUeNIiPtrTDrOOtJaQIExWmR8y8lxLh0qdU9JLRRmVVzwLMzyB/Junf
	 bZs8QLaMQF5rRjwl20QJRm+Q1i1YSv7ZmNPqr2CPpBL0eQjn2evjLPIEZqvwhAJI8c
	 WtlXXLc7f+BLQ==
Date: Sun, 7 Sep 2025 13:23:01 +0200
From: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] drm/panel: visionox-rm69299: Fix clock frequency
 for SHIFT6mq
Message-ID: <aL1rFVaVCxIVaLWm@quark2.heme.sigxcpu.org>
References: <20250906-shift6mq-panel-v2-0-aa5e585d8717@sigxcpu.org>
 <20250906-shift6mq-panel-v2-1-aa5e585d8717@sigxcpu.org>
 <ba7y3qcuzkx7hinxraimuem6xnrrfxbj3giz56nq5qbmg76uno@kr6dezsumy2s>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba7y3qcuzkx7hinxraimuem6xnrrfxbj3giz56nq5qbmg76uno@kr6dezsumy2s>

Hi Dmitry,
On Sat, Sep 06, 2025 at 10:08:35PM +0300, Dmitry Baryshkov wrote:
> On Sat, Sep 06, 2025 at 05:17:25PM +0200, Guido Günther wrote:
> > Make the clock frequency match what the sdm845 downstream kernel
> > uses. Otherwise the panel stays black.
> > 
> > Fixes: 783334f366b18 ("drm/panel: visionox-rm69299: support the variant found in the SHIFT6mq")
> > Signed-off-by: Guido Günther <agx@sigxcpu.org>
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > ---
> >  drivers/gpu/drm/panel/panel-visionox-rm69299.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-visionox-rm69299.c b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> > index 909c280eab1fb408a713d84051a1afbb252c45e8..e65697ce6f51c7d64b786da18cf44b16de5d6919 100644
> > --- a/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> > +++ b/drivers/gpu/drm/panel/panel-visionox-rm69299.c
> > @@ -247,7 +247,7 @@ static const struct drm_display_mode visionox_rm69299_1080x2248_60hz = {
> >  };
> >  
> >  static const struct drm_display_mode visionox_rm69299_1080x2160_60hz = {
> > -	.clock = 158695,
> > +	.clock = 149360,
> 
> clock = (2160 + 8 + 4 + 4) * (1080 + 26 + 2 + 36) * 60 / 1000 ?

IIRC I was asked to use the resulting clock rather then the clock
formula in another driver a while back but I like that variant better
too, will change in v3.

Thanks,
 -- Guido

> 
> >  	.hdisplay = 1080,
> >  	.hsync_start = 1080 + 26,
> >  	.hsync_end = 1080 + 26 + 2,
> > 
> > -- 
> > 2.51.0
> > 
> 
> -- 
> With best wishes
> Dmitry
> 

