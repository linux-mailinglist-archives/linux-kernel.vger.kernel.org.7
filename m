Return-Path: <linux-kernel+bounces-853967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C77BDD2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81E2118896EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F88E248F57;
	Wed, 15 Oct 2025 07:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QTC9K8fR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0DA74502F
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760514031; cv=none; b=RfSN9wyO+v9mjRwc69vX0PSsaNq/ebwmeutZRBSG9uxuJ8i1S8U4ceZrpzonIhLVdsRHnBauEUhPX/mDFVk+kOe5hOkT1Va9bEI/49oqKvNiSHd7tkyk/P45gsaOWn15DjpxqAQqnIy2nTGmZFfDAy2wzq5CSTSBK05VvTbLdGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760514031; c=relaxed/simple;
	bh=0iqg0r3CKm+9fZX5FCNGS5Li/4R84BcErbaCIeRJVJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ntu0ibAUNa//mT9/jTV6R/59FfsGbugdpWCkBPB1HzMBkIL6zF/SmFp61FVE9w/ASROGz5MzxR/b7WmikmPsGR+keU80yflWEywaqZb7ktfHOQlzO+dLHfWhP9ldks/AP1H6puRTwBjmQLbONwJ6Dtw5cEg37nxnABPL21uxYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QTC9K8fR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760514028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ujTOKpW4+kTHAHvK2HOwXbMj2GJWfrBWrxqkTtniSz8=;
	b=QTC9K8fR1Q5ClXeM/j07tNiszA7bFoOAeXAMyqdDWrlO/GHOHOgZVEBFU7l0tECIK/ir3d
	mM0fXI9Tm4xxOVmTQFqO6Y0kAckPUbrSqu7VJ41QlB6yFjWzyBUn/ZDqDdTQSyTyHJ8NaW
	K2SS6hr6LM5ZJRcSbCGwFiTSS6qJIy0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-wafzF0XONxmr9kXS3zGmkw-1; Wed, 15 Oct 2025 03:40:27 -0400
X-MC-Unique: wafzF0XONxmr9kXS3zGmkw-1
X-Mimecast-MFC-AGG-ID: wafzF0XONxmr9kXS3zGmkw_1760514026
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f384f10762so5313599f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 00:40:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760514026; x=1761118826;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ujTOKpW4+kTHAHvK2HOwXbMj2GJWfrBWrxqkTtniSz8=;
        b=K89FtW7vCJFT5QsY6TFBwN+5jxgfcjcezVVFZ17lyOKsgR6Jq/zTcIJqNLtkdCyau6
         dtv6OB2AU8EYzRY9XAQePJsZbxjVWfs7yOVMhPR22zZUxHOxA/3InpQVmLG0Q6rKyDuq
         lAqCNFLX2s2xLCkH3JR28CmV1UvES6GD2V3YgMAH1n1E6oCxhN/clfmp0FH+L5NyzyDS
         TxZPJNKvv6jNBrgRdOYokJPl2+BDSJWUGIWg4AbRvT8FaNKoWWTufdsn3i4IOgINk5Py
         WbngSRwPuCkVhrTYODFGyQiHIXQCZ58+pFi1Yogji1gctMzZ1b/w+PwlA3amZWZNa6sa
         ZdeA==
X-Forwarded-Encrypted: i=1; AJvYcCXi4gH5rQIMdeWhV4tfpYbQseMg3qaj8UL7a2sur9oV7omuRsEtFPFeTLFnjs2HPiL2i4r9vGS/KeuF/K0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywt/rSgzAp2YOu0Aa4Aq+DUWD3EDF9wluebLQOmJv663wgS/SO
	ClbxBe17+vI2QDRYYM/r2YUpb6bYEoy4bCbboeGjQPWp8Hl1QUee8gtf4bmSxlbeJ0YLeTb1GXp
	D3gs5Wyl3gEF5Nz1WpiVu4wBDVAZs+MZaVM+qIntM1n8UZxuyrOZsXPJrXZW5PXeg4Q==
X-Gm-Gg: ASbGncsDbuPSiEwkw1/s7WIeaYR/oq6jGddathT8BpCU8O2rflV4iYPCkCkiU0Qpijn
	PFA2HaGZ1wbg7JFfKxqrlqqxbJrdg2gtmvZQxP+PDfXSaEexmBNfmGJAQQD9N1Tqofh0VikHlYH
	C3hJBIykg6u4dWkIQ5fiEaUDTQeidoLru0XD+Qdgz+vDHbynEAJE999YqH7HOviPZNaslCkHM8p
	fPe0Efl67UXkYcqxDM5CqzSCb3CTVolBGfkBVihAOhTV4BmpobXh4Nsw5W4CbcDeskL6tnM6oaU
	V95GzYpc9JoaC7h+F4Ruruj7bCp1JkDzh3Twlyvre3qW4/BNOKG1sGa9ls/L0DJZBelDGiXMNEF
	doUcW
X-Received: by 2002:a05:600c:a4a:b0:471:672:3486 with SMTP id 5b1f17b1804b1-471067234b4mr3484435e9.15.1760514025918;
        Wed, 15 Oct 2025 00:40:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHELt2IvsOdxF5qtPebQELtoGEEK7IQ3SKyT74C+N+nJQNpZFsZIZnrEjv2umUEVDTOP4080g==
X-Received: by 2002:a05:600c:a4a:b0:471:672:3486 with SMTP id 5b1f17b1804b1-471067234b4mr3484245e9.15.1760514025488;
        Wed, 15 Oct 2025 00:40:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:c:37e0:8998:e0cf:68cc:1b62? ([2a01:e0a:c:37e0:8998:e0cf:68cc:1b62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab524f92sm166882235e9.7.2025.10.15.00.40.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 00:40:25 -0700 (PDT)
Message-ID: <46f046a6-0d51-45b0-8af1-61b4cc2c8127@redhat.com>
Date: Wed, 15 Oct 2025 09:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] drm/panic: avoid WARN when checking format support
To: Francesco Valla <francesco@valla.it>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20251014-drm_draw_conv_check-v2-0-05bef3eb06fb@valla.it>
 <20251014-drm_draw_conv_check-v2-3-05bef3eb06fb@valla.it>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20251014-drm_draw_conv_check-v2-3-05bef3eb06fb@valla.it>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/10/2025 22:08, Francesco Valla wrote:
> Use drm_draw_can_convert_from_xrgb8888() instead of
> drm_draw_color_from_xrgb8888() while checking if a color format is
> usable. This avoids a WARN in case the first format is not usable.
> 

Thanks, it looks good to me.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>   drivers/gpu/drm/drm_panic.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_panic.c b/drivers/gpu/drm/drm_panic.c
> index 1d6312fa142935fcf763381920ad889ca4cf4b27..4ba961e445e576d03cfb58953eead90d32b40151 100644
> --- a/drivers/gpu/drm/drm_panic.c
> +++ b/drivers/gpu/drm/drm_panic.c
> @@ -785,7 +785,7 @@ static bool drm_panic_is_format_supported(const struct drm_format_info *format)
>   {
>   	if (format->num_planes != 1)
>   		return false;
> -	return drm_draw_color_from_xrgb8888(0xffffff, format->format) != 0;
> +	return drm_draw_can_convert_from_xrgb8888(format->format);
>   }
>   
>   static void draw_panic_dispatch(struct drm_scanout_buffer *sb)
> 


