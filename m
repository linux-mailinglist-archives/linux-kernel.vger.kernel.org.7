Return-Path: <linux-kernel+bounces-853966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96008BDD29B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 434383536AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386E2C3768;
	Wed, 15 Oct 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YV0izV6H"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9C2153E7
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514009; cv=none; b=o2Kd7nKS/qGH5THKETOC85Q6Vn1gwcsGML1oL+eQbD/kIG9+WcmsaHzk4zCb20H7FJbzNqyPhHgQLgA3ARMJnaWNy6JhJLtCqEEYLYVK+vaxLpj0YCF8E2qRq/4uWpFg2zqzTrRjHLC5RMs3N+08J1aMmFSCd5bVEz3b8R7Nek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514009; c=relaxed/simple;
	bh=0vmbSg+hE3Hp/Z1Ly3jn1A9HMso9xFH6t7mcGr5uMTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s49Mn0c44mXs6/3D7yIzWkFLOhPyqO/3y/CC3RZrN0aRcTr5LGL8htlssdnX2zs2TtfpIPPX1E//vhKk56RWSRuj82pin2GxUcgSTszacHQNs5LWH6RQy8kdADrapZMopb4XzKfLiC062x33twxBDD9vMix5EK+zGU6G2lOOXXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YV0izV6H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760514007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LzkTXYTmCKGCvfwK3/ry/lapzrBc89yPKu36xwanEYc=;
	b=YV0izV6HoekOs57BwHfMWB7l4aE3wikwc8cospaIJQl6utPGnST/q/GBDfJ5Uc3U+peYNn
	JIHor2Bm2UecpnYHnp5QtRtiLK54D4RwVIdK4zSrKAce4OSO2IZ7yXvtRsug7GyO697HHG
	4Q8iviqZu+lQ8yqtAprL22W+e470wRw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-g8ZcP8RxNkGAHARKZWmnXA-1; Wed, 15 Oct 2025 03:40:05 -0400
X-MC-Unique: g8ZcP8RxNkGAHARKZWmnXA-1
X-Mimecast-MFC-AGG-ID: g8ZcP8RxNkGAHARKZWmnXA_1760514004
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e3e177893so44901745e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514004; x=1761118804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzkTXYTmCKGCvfwK3/ry/lapzrBc89yPKu36xwanEYc=;
        b=alx5nY8jRY8H5iuyyzOjmkHmikd5kGL+6uLXgcg8TsPZC7oUhaEMpGhmc9GgwgbDw+
         trRcooZjAbKHRCU0Cf9rUNQNFBY5ir/LaLfv6xCPKSpMwc4glT0wS4Hah34HyhvtLq5U
         0A1vr73hITuUNrl7+aPOrVC48vd9Eyuyn1QzYi+/sWoQhhoJRWLKYvHLTL/It+9EjY6M
         uu0f9BTAbQQBHq27vaf2yw+Rk+Wie7NubNVT1w5HM2bpEwp3jEsy4TtDnSDroa+/ILRM
         3eV/iPlx1mTJZit0jB23sMeEma0NYjjU7qXdqO2gQNcbu6JokQvQx5SqGyhb3TPnbV9B
         H0TQ==
X-Forwarded-Encrypted: i=1; AJvYcCVObXI2Zk08A1xX+QT8H+xcJO59PP5qxaktc3a26kvWoRT7mavfeZQ/IzlB9DZUkTSuOVlumqJ1bbf4Jv8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Jn86rHt/+KhCOyUChW53HwvKmMbqfZOsLBuOdrSuh3t4Mh6h
	Nhw6q5ovjfRNlyVFmUMVCFUZ11GsVJG/jRaimuSb2gZQD6tXioWGpVQ1RgPk818yYXjSOm8c69d
	N/oNfJhL7W3JfAQnZwKdnhTruTd8krxZX2Hf231UFuFtGcQQeE9b+zwoMpINCPLFus4Nk/hFcPg
	==
X-Gm-Gg: ASbGncsXV0iS9hI4p76UPfKyIhEi91tCAw/Hd9rJuyuaG2aK4KDMDvNP3vbo3gl3i/n
	gypfvYr0HP38Z6d3FpFjcwaiUVWTs48Xjj++gANnrjUKuphq2cGpmtqqeInUtsBt0lG/Yhi5oLI
	aWQ9/NKXUygtDbLLvpLCgw8XPC1/1G0N7Xo6NVINlsw5GBEOgiEBGlp0SwsGeG3jvRJDf/qAm2S
	2QbnJq9Dv/5/LPQpg6uEdF8dcCdb/nLmbZwOFAVkJ0l/ZzRdh+Y8sgnJsSyFgooynN+e0jBXCTU
	VWmP09+hDVHvwGpjbIGWJGrseh3IdHIGg2Ydc+nUd12Aw0wgxoZ2xfJ9Ng69XGpkFyYmqvbc8Bx
	0muMk
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr185977705e9.24.1760514002645;
        Wed, 15 Oct 2025 00:40:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdNerwfF0vb00/yeioQpjHawgZwt2BrniqNsLyL5p25Diqv6C20yihqIBJqWVMUSkW+ExgFQ==
X-Received: by 2002:a05:600c:529a:b0:46e:37a3:3ec1 with SMTP id 5b1f17b1804b1-46fa9af1797mr185977465e9.24.1760514002238;
        Wed, 15 Oct 2025 00:40:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc1c5227fsm227745845e9.9.2025.10.15.00.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:40:01 -0700 (PDT)
Message-ID: <2eb79263-58cb-4a30-9cef-8d3f60b2782f@redhat.com>
Date: Wed, 15 Oct 2025 09:40:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/log: avoid WARN when searching for usable
 format
To: Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
 <20251014-drm_draw_conv_check-v2-2-05bef3eb06fb@valla.it>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251014-drm_draw_conv_check-v2-2-05bef3eb06fb@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 22:08, Francesco Valla wrote:
> Use drm_draw_can_convert_from_xrgb8888() instead of
> drm_draw_color_from_xrgb8888() while searching for a usable color
> format. This avoids a WARN in case the first format is not usable.

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> 
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   drivers/gpu/drm/clients/drm_log.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/clients/drm_log.c b/drivers/gpu/drm/clients/drm_log.c
> index d239f1e3c456397ad64007b20dde716f5d3d0881..c0150f0c3b4b395e6e2126cf0d9660c967c182ec 100644
> --- a/drivers/gpu/drm/clients/drm_log.c
> +++ b/drivers/gpu/drm/clients/drm_log.c
> @@ -182,7 +182,7 @@ static u32 drm_log_find_usable_format(struct drm_plane *plane)
>   	int i;
>   
>   	for (i = 0; i < plane->format_count; i++)
> -		if (drm_draw_color_from_xrgb8888(0xffffff, plane->format_types[i]) != 0)
> +		if (drm_draw_can_convert_from_xrgb8888(plane->format_types[i]))
>   			return plane->format_types[i];
>   	return DRM_FORMAT_INVALID;
>   }
> 


