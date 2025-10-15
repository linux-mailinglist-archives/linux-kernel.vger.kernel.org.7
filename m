Return-Path: <linux-kernel+bounces-853965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0112BBDD2D7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C3D964E72B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BB5304976;
	Wed, 15 Oct 2025 07:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c9/iYvO8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D369275809
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760513979; cv=none; b=oSTsnsbWlFmz7VzCq+fMHkCCYCN01YgSUrPj5ilG/b+E4pcRb/nUsjhWW7aBcWIYebkqcM6kTRXbbLeLHRPT+N7xhLLuAYjmbrJvgTdpGhrhKO1d/Fzthw81mf1J5me6Qqjc1b4vL3Bbglyi7OgY7/F0u3QRt1tp7zL5inU3DW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760513979; c=relaxed/simple;
	bh=dd3PChjTXuhRRYfDpIDVAlHDmm4gU3lYSV3rLnkEBC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CH2NOV2IXoZ1lDTpfz0C5CgMgRX+0kJArL414mBEcnSo0UHWH9JgtSSyJWx0J7Sfbua7hQkik2P99pGC0z6yhKrASDKXDi2XggPIoRsy1n6pNHCLaPJS64avmYJG3qejOlQJc1qToqfITXg1oQYLsjYNnf8V+ruBr2sTf9iTyFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c9/iYvO8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760513976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c9mzBaSG1ymUZW4j7v8Uap9BTxNpS6prV1CapjmX+dQ=;
	b=c9/iYvO8lywRPypYOHRL/k1loF8zMs7lSZyvrZT3Jhrurdy8+5BG6T5pm1tnAfoexn312g
	EBUm+xrul6LvAWTTT3HjC1ICNWggXgYymlcYpawLRiLWSpIRwv67bPd6qEQjx/6P1wPibM
	p7auKk/W7HljEUv0pb1E5BAFwOXcwvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-cSuuSQvHOmWZ803xfIlVCg-1; Wed, 15 Oct 2025 03:39:35 -0400
X-MC-Unique: cSuuSQvHOmWZ803xfIlVCg-1
X-Mimecast-MFC-AGG-ID: cSuuSQvHOmWZ803xfIlVCg_1760513974
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426c4d733c4so2898506f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760513974; x=1761118774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9mzBaSG1ymUZW4j7v8Uap9BTxNpS6prV1CapjmX+dQ=;
        b=t14oULU1obDhT1xv1rlTwWk+y6T2nRrtnyjtCC8n5s/Utbaagu3XGDAzMJllT8zr1t
         aLAijgOCoI83W3a54YSqqX7YrEO+FFsOC1+5Ovm5VHrxFm3PSHqs0gYpG5CQpXithXPC
         qeo9wd5mQ2agPlVH6prk/Ds/ouHOqqVo7VhJsodhsf3JSABJ+DYAdnoQKqkv/YRKkN80
         RjJ0BI9KpYtqX0xd1St/JxliNe2Tk1lvMv2pvFaQh9g6/438lzHCHhL9H0WTmRRM4nrU
         tW8BSUYswd8z+4UBm4EBke+TpzMC/GbhI4LPq7rBAIB+dtWffJClPgeFb9+aDfIP64Nx
         OTNw==
X-Forwarded-Encrypted: i=1; AJvYcCWMiIAyVT5p/faS4YEWHhQvVD3QAbX9kyKbTxQs8GqF2R2LAHunT4qRxk9QPpIjglaLuIdCYWJJ4uCfLOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOWdGqckK7znNUioXHaYXVO7GuBTiWlmgwaZS/6MjOrpS0s0b
	9KAUJf9pM85NDye4mhaPfzn8eEsHgIrljRHAZrP6imh2SdNBDOpAkxY486P1w7kMuAj5s8rkB9Y
	m9QUI5aBVP5tjj2sr0sl4+b+PUFXjv3GRc45ju0RsD86TzRFnZkncsBVLX4r+uljuGA==
X-Gm-Gg: ASbGncuWy9Q9vomWh8jvCIfiC3IvrPK8EKjTx37oxgLwGrwPGxzzt2QrQDxQ46YbYEt
	MLcjYPNq4AoOrEeVDuOlSQ1wH9x1Re23UsDTYU1WENWEHClqou7kl7LqpmEqWIBo0FYwn66+sQp
	H5nvf6DmcTf4D8FqO8Pv6/kR51TQwUhkz8gaDKUMjW57NzkL9w/0raoq4OiNS2aaBpZAOqNXR4Z
	bBoHmRT7aCxsO5yftrB/dcqq5pBA3hruCDeLmPmUkCtqQ7dXCigtnxWVzsd/NVFn78wWuwy3Tco
	tOqINoz+6/41/RZ5WbkZcbtzPESvSzbjLmgetZBarik++j3iaa+HOHFjRdhGMGRDwoIGNjTowGh
	bUVEP
X-Received: by 2002:a05:600c:8586:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46fab89b7abmr164581775e9.34.1760513974288;
        Wed, 15 Oct 2025 00:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMcAsDbQx0qDg/8QUAJOASON1OERYluoiMz5ii+dtcdthx8c6ZL7HWlOcBtR2Zy/YKw6Ew7Q==
X-Received: by 2002:a05:600c:8586:b0:46e:37a7:48d1 with SMTP id 5b1f17b1804b1-46fab89b7abmr164581645e9.34.1760513973938;
        Wed, 15 Oct 2025 00:39:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm27419889f8f.42.2025.10.15.00.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:39:33 -0700 (PDT)
Message-ID: <13f1e073-8333-4dc8-adf6-54261e1a0fe0@redhat.com>
Date: Wed, 15 Oct 2025 09:39:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
To: Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
 <20251014-drm_draw_conv_check-v2-1-05bef3eb06fb@valla.it>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251014-drm_draw_conv_check-v2-1-05bef3eb06fb@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 22:08, Francesco Valla wrote:
> Add drm_draw_can_convert_from_xrgb8888() function that can be used to
> determine if a XRGB8888 color can be converted to the specified format.

Thanks for the v2, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   drivers/gpu/drm/drm_draw.c          | 29 +++++++++++++++++++++++++++++
>   drivers/gpu/drm/drm_draw_internal.h |  2 ++
>   2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..ccdd6b16e73fc01d58f45759cf3824be7aac155b 100644
> --- a/drivers/gpu/drm/drm_draw.c
> +++ b/drivers/gpu/drm/drm_draw.c
> @@ -15,6 +15,35 @@
>   #include "drm_draw_internal.h"
>   #include "drm_format_internal.h"
>   
> +/**
> + * drm_draw_can_convert_from_xrgb8888 - check if xrgb8888 can be converted to the desired format
> + * @format: format
> + *
> + * Returns:
> + * True if XRGB8888 can be converted to the specified format, false otherwise.
> + */
> +bool drm_draw_can_convert_from_xrgb8888(u32 format)
> +{
> +	switch (format) {
> +	case DRM_FORMAT_RGB565:
> +	case DRM_FORMAT_RGBA5551:
> +	case DRM_FORMAT_XRGB1555:
> +	case DRM_FORMAT_ARGB1555:
> +	case DRM_FORMAT_RGB888:
> +	case DRM_FORMAT_XRGB8888:
> +	case DRM_FORMAT_ARGB8888:
> +	case DRM_FORMAT_XBGR8888:
> +	case DRM_FORMAT_ABGR8888:
> +	case DRM_FORMAT_XRGB2101010:
> +	case DRM_FORMAT_ARGB2101010:
> +	case DRM_FORMAT_ABGR2101010:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +EXPORT_SYMBOL(drm_draw_can_convert_from_xrgb8888);
> +
>   /**
>    * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
>    * @color: input color, in xrgb8888 format
> diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
> index f121ee7339dc11537f677c833f0ee94fe0e799cd..2ab4cb341df94fc4173dd6f5e7a512bdcfa5e55c 100644
> --- a/drivers/gpu/drm/drm_draw_internal.h
> +++ b/drivers/gpu/drm/drm_draw_internal.h
> @@ -24,6 +24,8 @@ static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
>   	return font->data + (c * font->height) * font_pitch;
>   }
>   
> +bool drm_draw_can_convert_from_xrgb8888(u32 format);
> +
>   u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
>   
>   void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
> 


