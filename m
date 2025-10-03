Return-Path: <linux-kernel+bounces-841270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C8BBB6AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 14:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5214E559F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 12:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EDB194A59;
	Fri,  3 Oct 2025 12:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iLODcttI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2917D146D45
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759495693; cv=none; b=Q70X+T37qXDECLpM1AikLt9MCUukH9gr9bd1ZT9Ig4e46vyips3a+1PXGBSFQ+mbU3fXYaR8a9vuzlsAYE/Aecvm0gQs12kO82phIxiCeaFu1OKk3tTx5qiUqfMFh25ayrdRLGhDBN0Qik6JezxcDcZseMcXcZFJ27SWILnojto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759495693; c=relaxed/simple;
	bh=0NfLNHHSBRU3lzOSE2zXjgBawygwACv30CriwjLeliI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbjSwfw1R2fjB2rbeUHTz3D+2sW0WbqDGCZfvtHQI4vc27lbgCyrMYOd9eb0MyiBYY0S/60nPVCXXKqZ424Y4qAWB0krXfuuxdImj6OhNf/wmb1E2ftLy88TSjy27dumQ9ouxExqkNW/muyQ1ifuMtjfDkGXmE1Ln0CWDD825nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iLODcttI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759495690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abOFXlVOsAnsDhhRvwRDxbQbFD2KxrGohKy2z4xStxQ=;
	b=iLODcttIHvcsoNCyR5smqjvgGvxuSm//7rHmOY6rmA+2IIin3xA52WlnzEqejoyi3bfWX1
	Rb5wHRIIgpQmAZwr2vXth5bBYY0CDkttEzRkNrHVuA+v4+7Q/06p00Z+B2vYL6y6SVZy/Z
	MTLNR8dMM8Kq8yH010LnayIWMh6OddQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-YtfX2xV_OeuSvN2U5_qFzg-1; Fri, 03 Oct 2025 08:48:08 -0400
X-MC-Unique: YtfX2xV_OeuSvN2U5_qFzg-1
X-Mimecast-MFC-AGG-ID: YtfX2xV_OeuSvN2U5_qFzg_1759495687
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-46e375dab7dso9220935e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 05:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759495687; x=1760100487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abOFXlVOsAnsDhhRvwRDxbQbFD2KxrGohKy2z4xStxQ=;
        b=K8cMTbrpDLPhCbJfY67M4b4Eir5uQqwxww6KJEG3EBuRiHXbXTwgzRlagP18YfRDEi
         Tx4i8hErbl7r8eTDV6qzGdD9wW4j1rtDgT2nUpfnbVsYJ39Zk9+LMGIxPKtcOlkwavTM
         SnRWDznw3r6JLMs18ra0z2gTZgDpFEaNRMZQ9zMNwM5T5UH9j6Kn7Jt//ZzhgZKooi86
         QB9MJdN4vI7tpscZ9iY9SdHMOaUvRQ+/5nTQQDXLOWRMyDolug7gtwKz+dMXEvFwggIn
         X2gjJmKeLOvrdbUQL2eq7acYJyYI6KRZCNQS8dR7Qo7pcNph4mIq67E38gJ1VkQlcjbi
         qFig==
X-Forwarded-Encrypted: i=1; AJvYcCV2MIf6aewhwu2SOaUSK/NwQ8wLDNtEVCYQT84X5HsxGmoNnTUd/kytLKxffxPKuQtpKY/ARDz9nNUAgwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo3fW6hO/1l06YTM5YvpxzpQX5mHLjzwEZuRpafn1vjBG+D7D9
	HBnnTKxhe18LwabFFnvp/ZVx2ZV/h0mAez+hvOff4Kap4HDmtmmJf0JulMmqRNwxzXP4SCBkS4p
	ADyMRrKCKQmymD3yPplrLFDLTVb0uLuJR5bb3DXS35NN8M3sBctnszRmxphFWpiMqNg==
X-Gm-Gg: ASbGncub0s1rSLlqXumZkDN+/HH+ikqdUEiKFCXTkYZ/dGpAnjmsAyDshID7BXAKxQW
	arxn5YB2NzEs/uYydO5ljYBeX6CR5jFy5xqU/Pb1lp/MbWXUqj5Uom5skTDeBDw8h/QYLtz8c64
	K4Mvy6zdo1vyjhPmXAsXR99U+gclLCDE+KeuE4SoaXCwB9gH5Jamabz19xeD3pXiZ5tucRVQRrS
	I7ciTCDPzcCVodd7jXJpT8gLS7SmD4dLVpJr5cFQD1T037KdrK8QIbcUlSVW6qp3GHQS9r4uyM4
	ANlfOyfal7Y0bYmP7NgCMqa34iOCczD60Gij/Qaof7U3qAZ4/hsm+AQNsJkD5G7fyC1vbwALe0z
	BY3mFQ0mb9g==
X-Received: by 2002:a05:600c:46cf:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-46e71151b43mr21787235e9.31.1759495687374;
        Fri, 03 Oct 2025 05:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9DbUHceDY8z1q6O4kWeaJAo3ePV1gD/11rMzSARC8qCSa2CqMo/zyDL0nSycvtSJ152kLKQ==
X-Received: by 2002:a05:600c:46cf:b0:45d:e28c:875a with SMTP id 5b1f17b1804b1-46e71151b43mr21787095e9.31.1759495686995;
        Fri, 03 Oct 2025 05:48:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b7e37sm125640635e9.1.2025.10.03.05.48.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 05:48:06 -0700 (PDT)
Message-ID: <70cbbf88-7c1e-44f4-8091-ee76944d2f6b@redhat.com>
Date: Fri, 3 Oct 2025 14:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/draw: fix color truncation in drm_draw_fill24
To: Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251003-drm_draw_fill24_fix-v1-1-8fb7c1c2a893@valla.it>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251003-drm_draw_fill24_fix-v1-1-8fb7c1c2a893@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 12:33, Francesco Valla wrote:
> The color parameter passed to drm_draw_fill24() was truncated to 16
> bits, leading to an incorrect color drawn to the target iosys_map.
> Fix this behavior, widening the parameter to 32 bits.
> 
Oh, you're right, my mistake.
Did you find this by using a 24bit hardware, or by looking at the code?

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

Best regards,

-- 

Jocelyn

> Fixes: 31fa2c1ca0b2 ("drm/panic: Move drawing functions to drm_draw")
> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   drivers/gpu/drm/drm_draw.c          | 2 +-
>   drivers/gpu/drm/drm_draw_internal.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw.c
> index 9dc0408fbbeadbe8282a2d6b210e0bfb0672967f..5b956229c82fb6e232e3342705a226c8e14c8568 100644
> --- a/drivers/gpu/drm/drm_draw.c
> +++ b/drivers/gpu/drm/drm_draw.c
> @@ -127,7 +127,7 @@ EXPORT_SYMBOL(drm_draw_fill16);
>   
>   void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
>   		     unsigned int height, unsigned int width,
> -		     u16 color)
> +		     u32 color)
>   {
>   	unsigned int y, x;
>   
> diff --git a/drivers/gpu/drm/drm_draw_internal.h b/drivers/gpu/drm/drm_draw_internal.h
> index f121ee7339dc11537f677c833f0ee94fe0e799cd..20cb404e23ea6263b535ea2b81b25f84c37be8a2 100644
> --- a/drivers/gpu/drm/drm_draw_internal.h
> +++ b/drivers/gpu/drm/drm_draw_internal.h
> @@ -47,7 +47,7 @@ void drm_draw_fill16(struct iosys_map *dmap, unsigned int dpitch,
>   
>   void drm_draw_fill24(struct iosys_map *dmap, unsigned int dpitch,
>   		     unsigned int height, unsigned int width,
> -		     u16 color);
> +		     u32 color);
>   
>   void drm_draw_fill32(struct iosys_map *dmap, unsigned int dpitch,
>   		     unsigned int height, unsigned int width,
> 
> ---
> base-commit: e406d57be7bd2a4e73ea512c1ae36a40a44e499e
> change-id: 20251003-drm_draw_fill24_fix-ea52d32a933d
> 
> Best regards,


