Return-Path: <linux-kernel+bounces-851995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C09BD7E42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A3418A2E20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FF630E0C7;
	Tue, 14 Oct 2025 07:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUliR8ml"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C1F30E0E7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426948; cv=none; b=WdwUb791vTYBz9Za3Ao2pPefit12VhRRDo4PXmZRuWfzI2HEqd6vAsCaoqt6KNOtyLmIdMAkZDQ+7lRF2oEAT8dBEjrIgvR+FQxNMs6DQseP3pkAlVr8m/lTQPi26L44NXxtwhLQXegj93UrnZyG/jWxNlrhYhpNnGA7BKXiMJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426948; c=relaxed/simple;
	bh=JNuhmQpLyHp4WKhXVh+NWQJYhWa7lt7g2fgI78A18lk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEL1D0ChhOLxkGE9Ic7SNj6JcdBYvpqKyjr3vlIi8p+2hHy+zbBoa5BL0Q3RUWTFx8z/DcrvKyEkvABAcDdXZlnvuuTHyql0+4UmnJdckXrr94HtF0aFFAxvNJGDy76maLeV90Tu2BRHCIzTJKvWpqM/faN3KdocFuVfEZyMNtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUliR8ml; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760426940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RksJCWcE518u9BgQ05Pnya764wbR3ztonK23iFG2Arc=;
	b=UUliR8ml7Z9+85UFn2Yu//vQLQC0CBPSsVvrPNl3xbKRVxthzIElem0zeV5+vTqXPPEBWY
	8oXVs3Y8AXJAm3221SQAl9BJ6WyM20sBQAYEY1QuJ2GKNLPmvLm1hZwTfvxBiO8D6Woqfs
	elAJcWNRF323MeFzer6mvfkYPxU8pnM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-ByqCRlS6PV2vVo7CF5__jQ-1; Tue, 14 Oct 2025 03:28:59 -0400
X-MC-Unique: ByqCRlS6PV2vVo7CF5__jQ-1
X-Mimecast-MFC-AGG-ID: ByqCRlS6PV2vVo7CF5__jQ_1760426938
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e32eb4798so25554375e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760426938; x=1761031738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RksJCWcE518u9BgQ05Pnya764wbR3ztonK23iFG2Arc=;
        b=rTxOy7LcsxIwf6EAoWv997FEEuOnaIiuHo0rGzD2OfZTNEKGivf2jBUbmkmyDTgMaz
         s6/Pacy6kPd/u8sY1e4nJRyqSiCFQOw82U2mME/TaV8Ff8uFih77Z8EGXqgq2PtKaUVY
         YTZD0NsdEtEiov3qlhcNFGpvniGLuPBj5ECasYnIYVXux/ND1vUK2j3C7r4Hsv9l1pyJ
         +dHCJZzwlPFoRtUA74m4DHILC94VcRl5cwdGeg1NRu6O3gzRvGR+M0ylimcSYLibrq61
         qT8eW6Sjb946VaCTIZo+yshZZe1Ah9kmV74fHnDkjqEWZ8jEoqzrEVRFPrMiNxujgo6R
         7IRg==
X-Forwarded-Encrypted: i=1; AJvYcCV+hT4+pKhNkwZhtazBPTqpeBbxPCtOf/Y9nPNQTGrBmeu/ern6dxwZEppKgkEtFKBHFMdTQqBXeJyV8mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZtCbx3iWw7keHFkJFWrKMDykQKkiFQqYAibLoH4mMlDzwtg1p
	yXXDHVxJXSRl4tgyZNDxgE4wLrO++PlTwW1Q6VmQymBRZqtPWaCuk3tOmz51nkIz+pydWnMWrKK
	nmPeWiWERLEEYcBUkpKERCOgjpX/1iAQh9humUc1XHQvKk6OdTEnIB7YhcKt21sGp2Q==
X-Gm-Gg: ASbGnctjslAi6c/HDaFsJYF7XKsX0M5YR4yr65OvfrHMDGoUAqE5QgH7xZ3ELG2R0bq
	pU2yGGwVkcrdPjWf7W0O4cdIUno5JyChTN1f6WpYQQsHNhTw+V6yqlbB/S4ErCswVy9w/fijo50
	ImWUwgOTf6ABCKiVvHf0uoyeCPDiZ3v8xeDihtd7h/Z/Cg+oNbMFqTFlQfy11I0QmoiTQ2ZM3G/
	C0N5g78KGuP3OygHPmDNpT2dXFJFmutyWWdsr7L2t89Lh2Ldi9gBhBoAao5HbXz9b+0d8utWtue
	5xBPZgJM9WVHktI4vDJpP1Nu7+ARJ44Uz4qa4Lc3PLrVH56J88Ql+QlPiBx81yqGf3b5f9jFVYi
	Vqaku
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46fa9a8638dmr171107435e9.2.1760426938081;
        Tue, 14 Oct 2025 00:28:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPr+Tuwu+hIBP/9A/MtGnkGPTpr2HNYr7jhZYylqwePWeGRerNFPNHp1Rv8vI/VkWXky412w==
X-Received: by 2002:a05:600c:4506:b0:45b:8a0e:cda9 with SMTP id 5b1f17b1804b1-46fa9a8638dmr171107285e9.2.1760426937724;
        Tue, 14 Oct 2025 00:28:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc57530b3sm107980145e9.12.2025.10.14.00.28.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 00:28:57 -0700 (PDT)
Message-ID: <95cc648b-ebec-479a-ba8f-b663f39bc516@redhat.com>
Date: Tue, 14 Oct 2025 09:28:55 +0200
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

On 03/10/2025 12:33, Francesco Valla wrote:
> The color parameter passed to drm_draw_fill24() was truncated to 16
> bits, leading to an incorrect color drawn to the target iosys_map.
> Fix this behavior, widening the parameter to 32 bits.

Merged to drm-misc-fixes.

Thanks for your contribution.

-- 

Jocelyn

> 
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



