Return-Path: <linux-kernel+bounces-729984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD30B03EA2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6191E1894499
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D8D2475CF;
	Mon, 14 Jul 2025 12:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="hudZHDyB"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173E24728F
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752496029; cv=none; b=nHtkRUFJOhTBzYzBJMEEvNDP+UZHDFmBy0ePOYJ/SmNt3D2dC5092fFCPQ9pApj1ZMtD1z9pD2uwzdUWbxNGPlwW8/i9822DGy9PBdK5CuR3Mi5CN2mAPkNcVyuEsXppZVkj/U4seVCD+tRjHOU8FTupbtV08sYbiNzMyysQkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752496029; c=relaxed/simple;
	bh=NMQvIxYvJko9EFDgUZV5kWanzrSIKkaOOfpKb1elhlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNLfuqGo7uR9NbsAPc/CHu4KAmP3SoBK1MaxgVaXc0NXpjdmnn7ogCZuuAqeFvhflEelyGdBqbuoiuRkiwtm+i3/WX4LxLAokjdMrWQtI328pJUXVWtZSgYWYXbV0mqhpnXLLIHf9tENwE2Ze4klKtACJZgpoIVG1NuBQgT1J9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=hudZHDyB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2222022f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1752496024; x=1753100824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYz8ZEiEw3/21Djvjk4LGP+bxxwIEaZ6IhqRw9leJZk=;
        b=hudZHDyBuqruJ7o8sUQ+1p8/PgaPVOCoWLH74nk3U5pazQc5eD2bSKzKkMbcQfaPy9
         B6pruWeaSaTHFLLJZkfgVlJJY6C/35E3zsK8HyHtrMpm2S+zmlOwsfiQrBZ4SB6XjtBr
         JpG0TmMBRbD6OklGTxogYW8dWgY99El6qEe30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752496024; x=1753100824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYz8ZEiEw3/21Djvjk4LGP+bxxwIEaZ6IhqRw9leJZk=;
        b=G+sdZ4JAJFTkP2Yox3kVMdmHacqrQqOhXIkHZrM66KE3mjCN3tOE1ONrjnOxrlhoyI
         IiXP9t3PtSFSDslimnw5OsutalSrfHdg7uhBMLV7YtJVqKVkSeqGS2KnoM7NA9bDw5c2
         nWL7I4aF0567MRYeJPe6ckz7M1EgAU62o4dI9T/Q1XkrljvMEDh5kaGXtxfnrw623ntV
         pmcr0ZmBqMtbvQvCk0K2IxRTT0afYrfkyrieWE6+Uz+MRLSq2o6wzBcF/jvNP9F8ZNJV
         ZyE8BBlnjK48O4qEvwdA6ErG1S2IlpXPNqmSy6NABjsVCtkYk6U/LpHGDtD+gqVUS1JZ
         baNw==
X-Forwarded-Encrypted: i=1; AJvYcCVGKcL+faAHBC00NVaGWjsRoSc2yOWy7A6dv8wDy93yHRIhfe/OywM0z19ZMcUixArrkNrcRTjdNlx8Icg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFYDP9fzXCX1xmFU8QXg8KdFLIY6bqTeZz3knC+EqTYFTVZCJ
	RNGPpj7ZCw+E2VMfwkuHEUth1SZoywVFMTMgbYKejNqwL4rq5W3xGdNGxo8jHbMNVkM=
X-Gm-Gg: ASbGnctqxPxRmqoRvhk+10byP807Jl+DZ3Xg6bE7xOX8KEy3yKFLKP1P439UgK6ilJZ
	euY0DZsA5vVd/jxwYGUyEyNvgd0j7RViQe/m5/7jBH7Ol/7V8mW+c/52CjoJN6XKfv4EhjA4d4b
	11uCFGNqSLSBb/iz+GOVX0xzAKs2zO2QpvfDl9x8QgSNsiF0U+4kvUcgr7R3W11+V3YQiO5lsaq
	teCg0dEcujOKhrT3UYILH3YO5Y71pITZjtkMbVcYeIj+kvAOYabkT+w4G4m2NXvOoyv6CZI52m2
	z+2EUHXHcsmzAq9pAMY5NCxvIJIsvbqoxtQhC5152yLhAtN79w2JqtLONf5vitzwqYLH97dab4o
	Qrjs1JT7udXUNv/Q1jAwKqWw6a/ZarV3M7A==
X-Google-Smtp-Source: AGHT+IFgiWckt0UTvX15h+un8PmkUe2XQAidXXBzA1B8yBk733OOvVGyJyRrZYszy+MQWV+guTIVeA==
X-Received: by 2002:a05:6000:4b1a:b0:3b6:1e6:c9fb with SMTP id ffacd0b85a97d-3b601e6d607mr3702667f8f.11.1752496024322;
        Mon, 14 Jul 2025 05:27:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e26f7bsm12473925f8f.95.2025.07.14.05.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 05:27:03 -0700 (PDT)
Date: Mon, 14 Jul 2025 14:27:01 +0200
From: Simona Vetter <simona.vetter@ffwll.ch>
To: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: of: fix documentation reference
Message-ID: <aHT3lW9WlM-fB_Nb@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250609-drm-misc-next-v1-1-a17b11a06940@gmail.com>
 <11d29a7e-d36b-42e4-abe0-9f72a478c5c6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11d29a7e-d36b-42e4-abe0-9f72a478c5c6@gmail.com>
X-Operating-System: Linux phenom 6.12.30-amd64 

On Sun, Jul 13, 2025 at 03:51:56PM +0200, Raphaël Gallais-Pou wrote:
> 
> Le 09/06/2025 à 15:35, Raphael Gallais-Pou a écrit :
> > Documentation/devicetree/bindings/graph.txt content has move directly to
> > the dt-schema repo.
> > 
> > Point to the YAML of the official repo instead of the old file.
> > 
> > Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> 
> Hi,
> 
> Gentle ping !

Applied to drm-misc-next, thanks for your patch. For next time around
might help if you include a reference to the upstream commit that moved
the dt file out-of-tree.

Thanks, Sima

> 
> Best regards,
> Raphaël
> > ---
> >   drivers/gpu/drm/drm_of.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index d0183dea770308e77f05da364ffe087d53f3be36..4f65ce729a473ec372bd76a60ac11a40ffb5df97 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -55,7 +55,8 @@ EXPORT_SYMBOL(drm_of_crtc_port_mask);
> >    * and generate the DRM mask of CRTCs which may be attached to this
> >    * encoder.
> >    *
> > - * See Documentation/devicetree/bindings/graph.txt for the bindings.
> > + * See https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml
> > + * for the bindings.
> >    */
> >   uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
> >   				    struct device_node *port)
> > @@ -106,7 +107,9 @@ EXPORT_SYMBOL_GPL(drm_of_component_match_add);
> >    * Parse the platform device OF node and bind all the components associated
> >    * with the master. Interface ports are added before the encoders in order to
> >    * satisfy their .bind requirements
> > - * See Documentation/devicetree/bindings/graph.txt for the bindings.
> > + *
> > + * See https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/graph.yaml
> > + * for the bindings.
> >    *
> >    * Returns zero if successful, or one of the standard error codes if it fails.
> >    */
> > 
> > ---
> > base-commit: 6f392f37165008cfb3f89d723aa019e372ee79b9
> > change-id: 20250609-drm-misc-next-2f4dd8f88bb9
> > 
> > Best regards,
> 

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

