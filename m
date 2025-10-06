Return-Path: <linux-kernel+bounces-842686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AA755BBD4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F0953494BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579C25B1FC;
	Mon,  6 Oct 2025 08:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7PwosfW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57550191F84
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738020; cv=none; b=d5iBa2s/S258L0kI1W9wlYtKRdw0sisjIzpe7JnGdDwM+iitQraldehorDHDBOcbwURhajtujRwZQHht2bzFABRz4B6ciH3PAfIeFqHX53+gM2ZVQGqAl5QfVx9G0Q/etuRGjGkiHQwpou5t7zP6N6NPljIfBubB1/pYEU2vQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738020; c=relaxed/simple;
	bh=vVeRJm8UDSO9AWtwpYnx3PnPUFTE+jd44Kf565yOC3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLNbp6c5lJoyYQmDO3FsoRA4Q+6tn6JrKWvGi2LFK+Nji2wtb8r8qVNNDEnyXmNmo42Dxb0JnhLwll7E/cYwEVq49LFsxWozK5LNvcePbEmBfwvOXJLpFNVUTtCL6iCUgeUt64VH4mU5oOTi0otDs8UbvUuhOJViQhALeoORc6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L7PwosfW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759738017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wpLOO/RlbSV+v+FkGVukdBUWowalJplYfx2koVcYQzM=;
	b=L7PwosfW0EiH0YoEJhrZZGMf83NiUOIrRG018rFyc52I0/F1LcZ/DsrBK5T5xPLUzdoa8n
	sjhkip8tMb7u9+MhhOv85VIJlheDsYWgbmG8ZESqnsL1hjswhl91qN7GYOxwnCIwZUmoK/
	OyzwlIfNNFBfeUClIORlBLBJZPHEhF8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-fJ5MX3H5NgS0bsumh8M4hw-1; Mon, 06 Oct 2025 04:06:55 -0400
X-MC-Unique: fJ5MX3H5NgS0bsumh8M4hw-1
X-Mimecast-MFC-AGG-ID: fJ5MX3H5NgS0bsumh8M4hw_1759738015
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f6b44ab789so2333349f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738014; x=1760342814;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wpLOO/RlbSV+v+FkGVukdBUWowalJplYfx2koVcYQzM=;
        b=c1sTMP5ngdArTNAFrNAwfuDn9paZ7VS1r/Fbs1TEb0HEQdUGzPGfVoyxOk7qxl7I6Q
         cG9oXJjOhZr07QTuYuQcaJptAUq8LBJiAVYIguJT/qEp0wfFPyR13bCDmYxCqAM5unj0
         HaioWVcmLS1Up8XaDOksoC9XlT08axgvZOUixYz44N8/AmDLWvi8nw8EkMVHLA9umr/n
         yH3oq+YQYJFuLyRtjcKFYnkhBVMove3NRtsuJv8MW9n8Di7z9Nbb54Gl/rK+74+oLwGp
         zKqDAh1VEhwBuF99XNPMPuFNa7UncadROUeSC5OQcVD3tyG+tC6Bu5VqcZvr9xROREoN
         D+MA==
X-Forwarded-Encrypted: i=1; AJvYcCVgEJK6whOm1wep4W1UTJEDDvL6f6zhUz5KEH9rS+iWVti1CYU/SQa+eZnvhffaS21Dy58H7+FlGqwR6eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHs8Lj3VWuLgxM3IrxdnHH8g1p374Ci2413qs20gayFF+fukxg
	M/xo1gYQc6EQSd1HtUK+BYpvJKiP6Y/31o2eken14G0I6Bw5ouUJ7r2A8lwhQAj2xErnfdc/TZ9
	z4sAPc5rgRzqNblQM9CmHNXfk1aT63icDaYSvdGyzy+/6Xz0KTUFSQToifceaw63qux6lk509GA
	==
X-Gm-Gg: ASbGncvdvU6aa3tQOihtxx3/D90mbnnJQ4bchT+XZQbNBchGrNsU6RMSy5yi7wWKevp
	9bymrDTNG+LF1tNnJczkuQ9tIV8ahP5jUzK+QWImU/fNJ2I7FpB5eGf1cwguXOi6TK8v3c5QHwF
	X9Ak88UNxRVDHDhCyGt/GNRezJvcdg+UjmO97bg82ttX0MZJtmjNH95tXKopJoEADfD9o0j8XN7
	Go+eL39NGmbibOAd1CFaf6n1txJ6rEcBvYy5obj6HDieffYHbXeBXxCWEtiwfJztxOtr+Qvnzl2
	6V1rLUEBItODKqOps782k8kGU4wwTKsvCVsDAgkVOkWeEa8mSNaRWoHXSsNccFmf1zkmlJSVI1i
	OjDtVo4rsOw==
X-Received: by 2002:a05:6000:610:b0:3fe:d6df:c679 with SMTP id ffacd0b85a97d-425671c1c62mr7390037f8f.55.1759738014244;
        Mon, 06 Oct 2025 01:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpwOMaIeKVt8usgBP9B8cskANRaaLPNti2Z/heEmw9fA6OvQl4UHwY/r85C4aCobj9vmHGCA==
X-Received: by 2002:a05:6000:610:b0:3fe:d6df:c679 with SMTP id ffacd0b85a97d-425671c1c62mr7390009f8f.55.1759738013823;
        Mon, 06 Oct 2025 01:06:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab960sm19681894f8f.13.2025.10.06.01.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 01:06:53 -0700 (PDT)
Message-ID: <b026d815-dd6e-48a6-8efa-4631ed7cca9c@redhat.com>
Date: Mon, 6 Oct 2025 10:06:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/draw: add drm_draw_can_convert_from_xrgb8888
To: Jani Nikula <jani.nikula@linux.intel.com>,
 Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251005-drm_draw_conv_check-v1-0-9c814d9362f6@valla.it>
 <20251005-drm_draw_conv_check-v1-1-9c814d9362f6@valla.it>
 <a669b2ee89865e9150efd38e181cdc838c2ac522@intel.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <a669b2ee89865e9150efd38e181cdc838c2ac522@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/25 08:48, Jani Nikula wrote:
> On Sun, 05 Oct 2025, Francesco Valla <francesco@valla.it> wrote:
>> Add drm_draw_can_convert_from_xrgb8888() function that can be used to
>> determine if a XRGB8888 color can be converted to the specified format.
>>
>> Signed-off-by: Francesco Valla <francesco@valla.it>
>> ---
>>   drivers/gpu/drm/drm_draw.c          | 84 +++++++++++++++++++++++++++----------
>>   drivers/gpu/drm/drm_draw_internal.h |  2 +
>>   2 files changed, 63 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
>> index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..2641026a103d3b28cab9f5d378604b0604520fe4 100644
>> --- a/drivers/gpu/drm/drm_draw.c
>> +++ b/drivers/gpu/drm/drm_draw.c
>> @@ -15,45 +15,83 @@
>>   #include "drm_draw_internal.h"
>>   #include "drm_format_internal.h"
>>   
>> -/**
>> - * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
>> - * @color: input color, in xrgb8888 format
>> - * @format: output format
>> - *
>> - * Returns:
>> - * Color in the format specified, casted to u32.
>> - * Or 0 if the format is not supported.
>> - */
>> -u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
>> +static int __drm_draw_color_from_xrgb8888(u32 color, u32 format, u32 *out_color)
> 
> Is there any reason to change the return value of this function and
> return the result via out_color? It already returns 0 if the format is
> not supported. If there's a reason, it needs to be in the commit
> message.

I think the problem is that 0, is also a valid color.

Maybe it would be better to split it into 2 functions, and duplicate the 
switch case.

ie:

u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
{
	switch(format) {
	case DRM_FORMAT_RGB565:
		return drm_pixel_xrgb8888_to_rgb565(color);

....


bool drm_draw_can_convert_from_xrgb8888(u32 format)
{

	switch(format) {
	case DRM_FORMAT_RGB565:
		return true;

....
	default:
		return false;


I didn't do it this way, because there is a risk to add a format to only 
one of the switch. But after more thinking, that would be simpler overall.

Best regards,

-- 

Jocelyn


> 
>>   {
>>   	switch (format) {
>>   	case DRM_FORMAT_RGB565:
>> -		return drm_pixel_xrgb8888_to_rgb565(color);
>> +		*out_color = drm_pixel_xrgb8888_to_rgb565(color);
>> +		break;
>>   	case DRM_FORMAT_RGBA5551:
>> -		return drm_pixel_xrgb8888_to_rgba5551(color);
>> +		*out_color = drm_pixel_xrgb8888_to_rgba5551(color);
>> +		break;
>>   	case DRM_FORMAT_XRGB1555:
>> -		return drm_pixel_xrgb8888_to_xrgb1555(color);
>> +		*out_color = drm_pixel_xrgb8888_to_xrgb1555(color);
>> +		break;
>>   	case DRM_FORMAT_ARGB1555:
>> -		return drm_pixel_xrgb8888_to_argb1555(color);
>> +		*out_color = drm_pixel_xrgb8888_to_argb1555(color);
>> +		break;
>>   	case DRM_FORMAT_RGB888:
>> +		fallthrough;
> 
> That's not necessary for back to back case labels. Please don't add it.
> 
>>   	case DRM_FORMAT_XRGB8888:
>> -		return color;
>> +		*out_color = color;
>> +		break;
>>   	case DRM_FORMAT_ARGB8888:
>> -		return drm_pixel_xrgb8888_to_argb8888(color);
>> +		*out_color = drm_pixel_xrgb8888_to_argb8888(color);
>> +		break;
>>   	case DRM_FORMAT_XBGR8888:
>> -		return drm_pixel_xrgb8888_to_xbgr8888(color);
>> +		*out_color = drm_pixel_xrgb8888_to_xbgr8888(color);
>> +		break;
>>   	case DRM_FORMAT_ABGR8888:
>> -		return drm_pixel_xrgb8888_to_abgr8888(color);
>> +		*out_color = drm_pixel_xrgb8888_to_abgr8888(color);
>> +		break;
>>   	case DRM_FORMAT_XRGB2101010:
>> -		return drm_pixel_xrgb8888_to_xrgb2101010(color);
>> +		*out_color = drm_pixel_xrgb8888_to_xrgb2101010(color);
>> +		break;
>>   	case DRM_FORMAT_ARGB2101010:
>> -		return drm_pixel_xrgb8888_to_argb2101010(color);
>> +		*out_color = drm_pixel_xrgb8888_to_argb2101010(color);
>> +		break;
>>   	case DRM_FORMAT_ABGR2101010:
>> -		return drm_pixel_xrgb8888_to_abgr2101010(color);
>> +		*out_color = drm_pixel_xrgb8888_to_abgr2101010(color);
>> +		break;
>>   	default:
>> -		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
>> -		return 0;
>> +		return -1;
> 
> Please don't use -1 as a generic error code. -1 is -EPERM.
> 
>>   	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * drm_draw_can_convert_from_xrgb8888 - check if xrgb8888 can be converted to the desired format
>> + * @format: format
>> + *
>> + * Returns:
>> + * True if XRGB8888 can be converted to the specified format, false otherwise.
>> + */
>> +bool drm_draw_can_convert_from_xrgb8888(u32 format)
>> +{
>> +	u32 out_color;
>> +
>> +	return __drm_draw_color_from_xrgb8888(0, format, &out_color) == 0;
>> +}
>> +EXPORT_SYMBOL(drm_draw_can_convert_from_xrgb8888);
>> +
>> +/**
>> + * drm_draw_color_from_xrgb8888 - convert one pixel from xrgb8888 to the desired format
>> + * @color: input color, in xrgb8888 format
>> + * @format: output format
>> + *
>> + * Returns:
>> + * Color in the format specified, casted to u32.
>> + * Or 0 if the format is not supported.
>> + */
>> +u32 drm_draw_color_from_xrgb8888(u32 color, u32 format)
>> +{
>> +	u32 out_color = 0;
>> +
>> +	if (__drm_draw_color_from_xrgb8888(color, format, &out_color))
>> +		WARN_ONCE(1, "Can't convert to %p4cc\n", &format);
>> +
>> +	return out_color;
>>   }
>>   EXPORT_SYMBOL(drm_draw_color_from_xrgb8888);
>>   
>> diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
>> index f121ee7339dc11537f677c833f0ee94fe0e799cd..2ab4cb341df94fc4173dd6f5e7a512bdcfa5e55c 100644
>> --- a/drivers/gpu/drm/drm_draw_internal.h
>> +++ b/drivers/gpu/drm/drm_draw_internal.h
>> @@ -24,6 +24,8 @@ static inline const u8 *drm_draw_get_char_bitmap(const struct font_desc *font,
>>   	return font->data + (c * font->height) * font_pitch;
>>   }
>>   
>> +bool drm_draw_can_convert_from_xrgb8888(u32 format);
>> +
>>   u32 drm_draw_color_from_xrgb8888(u32 color, u32 format);
>>   
>>   void drm_draw_blit16(struct iosys_map *dmap, unsigned int dpitch,
> 


