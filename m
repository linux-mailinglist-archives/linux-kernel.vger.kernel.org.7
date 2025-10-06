Return-Path: <linux-kernel+bounces-843497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3849BBBF969
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 23:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E69BE4E46C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 21:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96EF260580;
	Mon,  6 Oct 2025 21:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="Jye4z8DV";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="sldXbi6F"
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D79E184524
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 21:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759786763; cv=pass; b=hSPiVqrCsyFJS3hehIt6m8H/Mn/Xp1Tn5pPsUnfu8EozXVKmQvJoAOFVyeiqfZ/NxbVvuqAwpjnl0jFASjPcEyjuY/bhBa0CyscRxcPMpzW3YuDeh0yAh2tPaqlnD06mH2yVYu6Xc59Xuq7vpM3EEhyyMcyyCv6WkbkKrczc8uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759786763; c=relaxed/simple;
	bh=XhrALn6AwmqC48kyNP42LuQeYtcpkiuuaVWHS05VQrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwTRv9w4i9AqIVbrQZwliHBEPFJ1e1ZgG3wVLWRMte2N/8lWfKjZ462dA6mPghaFB2FOKCOZ8uEfVrqZmAVDxRUFItK8NCj9SK+EgqK3m5++J5QPOAgZ9Rl/QWSjAwnG7qwbgMMEWSYOvuzkAT4oxxNmhtZSzMTj34oOUtPPkgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=Jye4z8DV; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=sldXbi6F; arc=pass smtp.client-ip=185.56.87.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-47m8.prod.antispam.mailspamprotection.com; s=arckey; t=1759786761;
	 b=Pny7+FaOFFMYgKfHnji83DuZhEMBkqvLSmTUI7EaZe7hxQ2P2ZOkQHxPvSw6eOpK/u1zpw+XDf
	  x6wj8rUNoluxMsnVQ/0CzoeT+lrhAHszY5p2kLJ/f2cUI3pVkMNzEEf+oshi6TJ9rkrgyT0mSi
	  gx3bRoVh3MhPWEbs23gnjYtOfFyzNy97vzHR/d2QD/o3MaBN+6I1AiUnstHwKmrkbq7digivTq
	  N328OFMNktmeJf/eooroW5Z5z7l0zpQHjOMMgIaD/HpG/lP9MnCBpPK7hYDvbloGWhs9fJ1VZA
	  G1zHmrkG7iLjwVxdkvsoggMtFtUp6qbupEN3doq48UXZzQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-47m8.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-47m8.prod.antispam.mailspamprotection.com; s=arckey; t=1759786761;
	bh=XhrALn6AwmqC48kyNP42LuQeYtcpkiuuaVWHS05VQrA=;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	  Message-ID:Date:Subject:Cc:To:From:DKIM-Signature:DKIM-Signature;
	b=UjkTS0j0uRSX8I5uJdfWtf4K5VbSzJG43bVoZxJJ4Ov71QVU6paKzjMQkhe/i5znkyWqGwPxu/
	  /QZh9//+Q3pyZhhuYBA4rgzf9J1y/GM0S/8as65fD/qG0V/KzmnNSVWQZvFIje6RpG/2YqSv9H
	  1nAJCTRg/4zHdjkt6NXQX2RLxL9EtrtN/raX09ffqZD6IxKr8tG2a3ixXDf2XCKybyTaSEWqpn
	  7ptik+4uYH5reFcTTKYzY9NUhNvdfX2zZQXKUxIUBg3ygaGkaUs4emuO2BXo42PVuP68GshWe8
	  5iax0uE2A8QiB1xfSFxsA+BJ4vgspIUfeY6Ev8KbhHS5hw==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Reply-To:List-Unsubscribe;
	bh=a9wOeHQ4Zw5QzXxBPYZnpfS9fOrFf4Gmv/aSZxidpZI=; b=Jye4z8DVKD5sr6dNdzBub1oqc+
	KpJxCXzzDpRKMy8sYdJnIcCVwguuw5G3v+fzUAr/9uGppxnYx/fHFvpbbpromqCZc1pte/nrTq4X/
	YM80u/iIoCXBc2RdunjyTgvkqZ6JKzpgQv58bb3De8z9QzZg7dpeDruGGJZD7Znb1YSg=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-47m8.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5svG-000000093S0-2qIh
	for linux-kernel@vger.kernel.org;
	Mon, 06 Oct 2025 21:39:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Date:Subject:Cc:To:From:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=a9wOeHQ4Zw5QzXxBPYZnpfS9fOrFf4Gmv/aSZxidpZI=; b=sldXbi6FfeiI0WohjK6gQzMjAB
	YznkPBpu/WnBECEvv8r+aS4aejXZB/dmMYGYAjaRqwOQqo/EiXUFI5zvtH7D5PQNRD+dhcn7lqtLs
	XZbK7TEvK8WAEoBDA75U5pOakP6He0m4UTXktb5tQpil88vcDwi7E+Jp7A8tny/LxXX4=;
Received: from [87.16.13.60] (port=59816 helo=fedora.fritz.box)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1v5sv0-000000006H2-1h3j;
	Mon, 06 Oct 2025 21:38:54 +0000
From: Francesco Valla <francesco@valla.it>
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
Date: Mon, 06 Oct 2025 23:38:53 +0200
Message-ID: <2764907.vuYhMxLoTh@fedora.fritz.box>
In-Reply-To: <a669b2ee89865e9150efd38e181cdc838c2ac522@intel.com>
References:
 <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
 <20251005-drm_draw_conv_check-v1-1-9c814d9362f6@valla.it>
 <a669b2ee89865e9150efd38e181cdc838c2ac522@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 52738f2336bf3cf8a62a4610e4c3911f
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1v5svG-000000093S0-2qIh-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-47m8.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Monday, 6 October 2025 at 08:48:51 Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Sun, 05 Oct 2025, Francesco Valla <francesco@valla.it> wrote:
> > Add drm_draw_can_convert_from_xrgb8888() function that can be used to
> > determine if a XRGB8888 color can be converted to the specified format.
> >
> > Signed-off-by: Francesco Valla <francesco@valla.it>
> > ---
> >  drivers/gpu/drm/drm_draw.c          | 84 +++++++++++++++++++++++++++----------
> >  drivers/gpu/drm/drm_draw_internal.h |  2 +
> >  2 files changed, 63 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> > index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..2641026a103d3b28cab9f5d378604b0604520fe4 100644
> > --- a/drivers/gpu/drm/drm_draw.c
> > +++ b/drivers/gpu/drm/drm_draw.c
> > @@ -15,45 +15,83 @@
> >  #include "drm_draw_internal.h"
> >  #include "drm_format_internal.h"
> >  
> > -/**
> > - * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
> > - * @color: input color, in xrgb8888 format
> > - * @format: output format
> > - *
> > - * Returns:
> > - * Color in the format specified, casted to u32.
> > - * Or 0 if the format is not supported.
> > - */
> > -u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
> > +static int __drm_draw_color_from_xrgb8888(u32 color, u32 format, u32 *out_color)
> 
> Is there any reason to change the return value of this function and
> return the result via out_color? It already returns 0 if the format is
> not supported. If there's a reason, it needs to be in the commit
> message.
> 

Is because 0 might be a valid color (e.g black for RGB888), as Jocelyn
correctly pointed out in another thread. I'll add this detail to the
commit message for the V2.

> >  {
> >  	switch (format) {
> >  	case DRM_FORMAT_RGB565:
> > -		return drm_pixel_xrgb8888_to_rgb565(color);
> > +		*out_color = drm_pixel_xrgb8888_to_rgb565(color);
> > +		break;
> >  	case DRM_FORMAT_RGBA5551:
> > -		return drm_pixel_xrgb8888_to_rgba5551(color);
> > +		*out_color = drm_pixel_xrgb8888_to_rgba5551(color);
> > +		break;
> >  	case DRM_FORMAT_XRGB1555:
> > -		return drm_pixel_xrgb8888_to_xrgb1555(color);
> > +		*out_color = drm_pixel_xrgb8888_to_xrgb1555(color);
> > +		break;
> >  	case DRM_FORMAT_ARGB1555:
> > -		return drm_pixel_xrgb8888_to_argb1555(color);
> > +		*out_color = drm_pixel_xrgb8888_to_argb1555(color);
> > +		break;
> >  	case DRM_FORMAT_RGB888:
> > +		fallthrough;
> 
> That's not necessary for back to back case labels. Please don't add it.
>

Noted.

> >  	case DRM_FORMAT_XRGB8888:
> > -		return color;
> > +		*out_color = color;
> > +		break;
> >  	case DRM_FORMAT_ARGB8888:
> > -		return drm_pixel_xrgb8888_to_argb8888(color);
> > +		*out_color = drm_pixel_xrgb8888_to_argb8888(color);
> > +		break;
> >  	case DRM_FORMAT_XBGR8888:
> > -		return drm_pixel_xrgb8888_to_xbgr8888(color);
> > +		*out_color = drm_pixel_xrgb8888_to_xbgr8888(color);
> > +		break;
> >  	case DRM_FORMAT_ABGR8888:
> > -		return drm_pixel_xrgb8888_to_abgr8888(color);
> > +		*out_color = drm_pixel_xrgb8888_to_abgr8888(color);
> > +		break;
> >  	case DRM_FORMAT_XRGB2101010:
> > -		return drm_pixel_xrgb8888_to_xrgb2101010(color);
> > +		*out_color = drm_pixel_xrgb8888_to_xrgb2101010(color);
> > +		break;
> >  	case DRM_FORMAT_ARGB2101010:
> > -		return drm_pixel_xrgb8888_to_argb2101010(color);
> > +		*out_color = drm_pixel_xrgb8888_to_argb2101010(color);
> > +		break;
> >  	case DRM_FORMAT_ABGR2101010:
> > -		return drm_pixel_xrgb8888_to_abgr2101010(color);
> > +		*out_color = drm_pixel_xrgb8888_to_abgr2101010(color);
> > +		break;
> >  	default:
> > -		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
> > -		return 0;
> > +		return -1;
> 
> Please don't use -1 as a generic error code. -1 is -EPERM.
> 

Whops, you're right. I'll return -ENOTSUPP.

> >  	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * drm_draw_can_convert_from_xrgb8888 - check if xrgb8888 can be converted to the desired format
> > + * @format: format
> > + *
> > + * Returns:
> > + * True if XRGB8888 can be converted to the specified format, false otherwise.
> > + */
> > +bool drm_draw_can_convert_from_xrgb8888(u32 format)
> > +{
> > +	u32 out_color;
> > +
> > +	return __drm_draw_color_from_xrgb8888(0, format, &out_color) == 0;
> > +}
> > +EXPORT_SYMBOL(drm_draw_can_convert_from_xrgb8888);
> > +
> > +/**
> > + * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
> > + * @color: input color, in xrgb8888 format
> > + * @format: output format
> > + *
> > + * Returns:
> > + * Color in the format specified, casted to u32.
> > + * Or 0 if the format is not supported.
> > + */
> > +u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
> > +{
> > +	u32 out_color = 0;
> > +
> > +	if (__drm_draw_color_from_xrgb8888(color, format, &out_color))
> > +		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
> > +
> > +	return out_color;
> >  }
> >  EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
> >  
> > diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
> > index f121ee7339dc11537f677c833f0ee94fe0e799cd..2ab4cb341df94fc4173dd6f5e7a512bdcfa5e55c 100644
> > --- a/drivers/gpu/drm/drm_draw_internal.h
> > +++ b/drivers/gpu/drm/drm_draw_internal.h
> > @@ -24,6 +24,8 @@ static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
> >  	return font->data + (c * font->height) * font_pitch;
> >  }
> >  
> > +bool drm_draw_can_convert_from_xrgb8888(u32 format);
> > +
> >  u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
> >  
> >  void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
> 
> 

Thank you.

Best regards,

--

Francesco





