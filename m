Return-Path: <linux-kernel+bounces-767531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB58B255A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E1F3BB58B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905703009DB;
	Wed, 13 Aug 2025 21:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XM6yJV9B"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353843009C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120928; cv=none; b=nX8eS0dckjIcWUYmMff1ilmd1z3RCXUnF8f25vvpRcFVkSNltFXdzYwNN/A5KAVfy+B/OHCdtHtpxCerS5B8F4kWAD/jT7TIc0N7wYEw1yRov59zeao79jqm8xfhyEz7Dh0HQs/WlCfOPRamdXBxtJK/uLtPNUbJWdjkJgZG6cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120928; c=relaxed/simple;
	bh=JGDu2T4AA+CwFqW1EWB3SqKUF4ftHO3YFhNGuUoTrXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI2WCRR3Gkxk51pduUZE0V61SKS/Ts0ymm+Zn70ptjq1ZDTXFXU83Sxe1dL15PIBGGUMlGr43HiVgPNPJDrjcvpa+FOhB1d5oUpBDVqTrOQyvPKoLVSCoE4ztUalysoGKdv3GgeNCDcdk3qBtO34m+CspnSQxgvZetyzN6yYrJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XM6yJV9B; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1b001f55so1270075e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 14:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755120925; x=1755725725; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1XmXvWLJhlSpXOiiF4u4DdYe3hF2nbQcNLrAb9SCIeY=;
        b=XM6yJV9BoOnoRAkb5h86O8AqyjJ0vfzee/TziE2sAtZcEQi7STm390P1mSz5eCs8CO
         /LYLBDbAneeruufG9ECE0OHRq2T8riYy+Oh3PCtVcdalXsKzF+V4/nC469rs+ICActbw
         bI4/UiU4wXFdd7znphMoNbzv5/yBDedA+YdR+cweWw66w5FXc1CSXeMluDdrFB8tJAsh
         x+3MkJX3+r43WGJJsSORTiOQJtpe4NsmDwLv+f0kwEvNQeLmV6TQls/abr6bBVCAhHOz
         wmYjKrcMnwOed80/aeIvTeAIxLRN5vy2FpdiPnqfBTQBxXfI0BAL8ECWLNwXZP9E+71+
         9xIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755120925; x=1755725725;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1XmXvWLJhlSpXOiiF4u4DdYe3hF2nbQcNLrAb9SCIeY=;
        b=iSu8pNo5eMAqfHztjSWEZs2qMteRvLy7XY6B9pRAOCnaMBqek9HHRAJw3lDCza0w8o
         IgJyYousLeA+IJn+Zu6xQynVzS64Itk74thwb98DWXgV3PDwVkhaKbibhablZoSlwNTB
         J4gvS45aN6EmixgBG/1c/PiURXdxWVSz3N241HynOX2sWuWg65yvMZ120GAgr8AU2B9H
         LEdZSb9fWyvfygvD4SgOdaxgOycPxj0rI2+EZBn8qLTSKR0lDCXkg31FlWqU1qX4T+WK
         0nY2owBSZ72EyujZKCuqLlQofYdGbHuInc1/V//YTqKo/DCCXjb0kTBS9k0NYXt4gydY
         YKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0b/+CwiDNshbIA1J9en2yb8uB88hawj0sZoVY4bCdBa0oohVZdiT0vYSzQik8dsCgmYI7T+049QKL57E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/WDyAG1Y1bI13W5ySqkBWzPOcXpSyQeLgfilRPZnOoM465fvu
	KkV/7I8tjjcK3KaoEM2o4HUsd0SXNV6K3ZLsCo0fa2WlyjZthysxI8ZhIt2HCxq74pk=
X-Gm-Gg: ASbGnctAhBtbcG/VnrO/z7ZFe0yq3B7QgSHULM4zUvE+1uBkSgvWMElTbxnBhFEI28p
	AOc1PcPWW4LATS8ia3oLJqvb/75L3fZC/yjzbUgoZ6IRkNmsbpvigNQWuIlaOEC5Bb3NYLf7L6d
	jkcwGuv5yS1OWVuv4v57odnWTr4qG2QIIRqGPY69CXwV9FQwPVjPehwghaskw6mfqnqvHDbZAHH
	ChOV3y0MGc/yPW9GRO9ypD6slON9qNgiNqvF7OtL4kz8XxUFSPMht7kW+tA/wCEUPmZ4sN5F4FP
	nuXVUohY1F1mKzZ3W+XuLKFe4eUJAecgDyt2jJQ56nurFCH5D0dvvdq6V6dOaLLZ9qbnhYQbBK0
	i1YRhGGHWHL/MfJ9KH6fJy4f2GZdFXtra1UBkWNO5Mjd4yBGWRkvP39o0Ylqf6Si+
X-Google-Smtp-Source: AGHT+IEXpcW7O5Udyxtt77HddjjtyRdwKlGTXAk1h299MQ76Ljg2rx6jkkZiaE782uOxs2v38udmMg==
X-Received: by 2002:a05:6000:25c6:b0:3a4:dc2a:924e with SMTP id ffacd0b85a97d-3b9e7438457mr554485f8f.6.1755120925461;
        Wed, 13 Aug 2025 14:35:25 -0700 (PDT)
Received: from [192.168.0.13] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm48738067f8f.39.2025.08.13.14.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 14:35:24 -0700 (PDT)
Message-ID: <0a049417-6545-4cdb-95cb-cf41c810b57c@linaro.org>
Date: Wed, 13 Aug 2025 22:35:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] media: qcom: camss: enable vfe 690 for qcs8300
To: Vikram Sharma <quic_vikramsa@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
 konradybcio@kernel.org, hverkuil-cisco@xs4all.nl,
 cros-qcom-dts-watchers@chromium.org, catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813053724.232494-1-quic_vikramsa@quicinc.com>
 <20250813053724.232494-6-quic_vikramsa@quicinc.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20250813053724.232494-6-quic_vikramsa@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:37, Vikram Sharma wrote:
> The vfe in qcs8300 is version 690, it is same as vfe used in
> lemans(sa8775p). vfe gen3 have support for vfe 690.
> 
> Signed-off-by: Vikram Sharma <quic_vikramsa@quicinc.com>
> ---
>   drivers/media/platform/qcom/camss/camss-vfe-gen3.c | 3 ++-
>   drivers/media/platform/qcom/camss/camss-vfe.c      | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe-gen3.c b/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
> index f2001140ead1..22579617def7 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe-gen3.c
> @@ -13,7 +13,8 @@
>   #include "camss-vfe.h"
>   
>   #define IS_VFE_690(vfe) \
> -	    (vfe->camss->res->version == CAMSS_8775P)
> +	    ((vfe->camss->res->version == CAMSS_8775P) \
> +	    || (vfe->camss->res->version == CAMSS_8300))

I'd really prefer a patch setting the CSID and VFE versions as 
properties of their respective data-structures.

BUT, again this will do for now.

>   
>   #define BUS_REG_BASE_690 \
>   	    (vfe_is_lite(vfe) ? 0x480 : 0x400)
> diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
> index 99cbe09343f2..1d40184d7d04 100644
> --- a/drivers/media/platform/qcom/camss/camss-vfe.c
> +++ b/drivers/media/platform/qcom/camss/camss-vfe.c
> @@ -344,6 +344,7 @@ static u32 vfe_src_pad_code(struct vfe_line *line, u32 sink_code,
>   	case CAMSS_8x96:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
> +	case CAMSS_8300:
>   	case CAMSS_845:
>   	case CAMSS_8550:
>   	case CAMSS_8775P:
> @@ -1974,6 +1975,7 @@ static int vfe_bpl_align(struct vfe_device *vfe)
>   	case CAMSS_7280:
>   	case CAMSS_8250:
>   	case CAMSS_8280XP:
> +	case CAMSS_8300:
>   	case CAMSS_845:
>   	case CAMSS_8550:
>   	case CAMSS_8775P:

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

