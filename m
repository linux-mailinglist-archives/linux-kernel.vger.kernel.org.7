Return-Path: <linux-kernel+bounces-755379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF908B1A5A8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707733ABE3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550111F9F7A;
	Mon,  4 Aug 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rqYvz3fA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E781FDD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754320640; cv=none; b=sRTODfBG9JbhP8UUWJ2waLS6U+RbJlK8NFtPSpUG1Z9WnvUg9kX2HuBHn8PkHUSWE8mV+knBNZ+9UGbTTlJAFI/25qmZdvWHtZ/ESj+2tTUn7PRjbUuerUh53uW1AWh87Nq/raEZvBcajdDunsC00VB3mfVNso8V58JpveZvh3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754320640; c=relaxed/simple;
	bh=C9JuqfacuIWb2cF4/0Z3977hH6+VE2+Sv1PqDxgv3IQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N19OMmhifsGHwp0ObGMUjdlxdhMwrNf/x92i+NXYvO6fdMAjS0rfCoS6yroN/cf/hGBwb/OjyPqMUlJTujRigBnAFOh7shNcBd6xpnnxJyUMQpSsKs3vxRB5Ga2tMi7p0BBCgSwh6fnH332ptkfNi23jXDuRV5pMTxbpHvq7GI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rqYvz3fA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4563cfac19cso46569605e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754320636; x=1754925436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ygs3wS78PK+/30hvIGpvyt9rDvIj4U6l91GW/IBhVOM=;
        b=rqYvz3fAuefTizS74MsqNBwKSWYoDCnA8/IPH+F2x8hhWW6nAycmAzDGLXn52zZomQ
         uKxwL3kp5g2eQXCtTkeB3bK65c8BY4fPCF0K6ZYzNuSKwyp14bhVQbS3vv336BG5oztC
         yAMr/oUcjwmqKOrh7PTC9recMlqVEhehIpZ2S5UAxNLcZi6+sWlnNaEOTN85rcSg3VlC
         lmHjuyzZLgYo6oTX5wohEcTPM+cNeMhL/XhqE2uBZAcMvuHb590OiP+6/9E3Xhp3qh+a
         3oO7LTAY6kM0VnOXp8Mw23xnGNLDguDWkt45Hd7mG/gxsFl4+ndbsxHIeoiB3d4GneLL
         K7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754320636; x=1754925436;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ygs3wS78PK+/30hvIGpvyt9rDvIj4U6l91GW/IBhVOM=;
        b=S4qY/7qYrLRRvk0Q3+AY4jxN9XdZjtqGvpCSg/M6Lsn+O9xdJGNX4gJp7SOHh/wur0
         oDPQ/6CxepZnpKuajy9VM8LSOJxQoujeYKnYHQd8jR/sujRSqlWrqE0l/4mE7jbvbaKa
         T72Ge4AWxUdHK0p45bA5I1CuBcd+GRniZXIBzhC0hKDAg6MxkTduOINCKhNFEc9s4lD2
         aaPUtPBzx2hd1la1kGOIQqrWxkGjzmye4eZQKYQVlWyFkr1BYt85qtDVhpsU/lxjQHLu
         Uk293dX+a3RkAO1sD+IX3SadHYgMp9sR6cOaRNlOYhbMF1V+21Fqgvq7GPBRrzMGAY22
         fytQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLENXsEthDeLMogav8znjqm3onPlbnHOnvZo1nA5TyZetlU82WiSvO/cuE01boWU0hO6u8zLRMFv2g/D4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9gfK6z1P6rQjtKgJP9Lg37fXGmwiJW9/rSqQ/0rmqYp30/C5t
	S5aW2DPfrZiPtefH+ouusNyuQ+o1lc3gX9KNUX/YgXxLQ7+Axtf65ZzSlfmjygeUq14=
X-Gm-Gg: ASbGnculB1Jw++ygT+Ijf3sQHbmWdx4KudBqwPnNONZ1X4a+H+CzSkGSDhIl5oAWayW
	G4cAOmCvg90UJCRlopSvFJ5SVRAxqZMvbAlZ1xJGzoq6S/x3I9H+nMv5UBA1ku+AorYsy4BR9S3
	3w528FecOHLbTrzCOvI8QjNsuUHtMk8AYWnhM/QpqcHCaoadY0t39cHYVY+vfdrijnUC8gdig61
	AZALp/DWxXh8LGBp+r9pc/bJiqNrGPayh3CRQ3abB+MWg57pIfgAHMaYa9gAwDQmmD4DUO7OSbk
	mwRfqgn0ta/bxi7o0VXU9sMNaGVP2btQwesAllSd08yYDqKk751eTjNgwLdHRzFN+J4IxrC16hw
	pkvG8xfNhNppG+eTUdt9C7XUO12SOJZ2BCc+zZfKdH1EGxQyZYRP5dN2l4QwjAFnr8Vgvtrwr7h
	I=
X-Google-Smtp-Source: AGHT+IEZA+rLTJ+G6sYCCHHikTQcmm4lwICBpmhAo83VygtbN+DV7ESvaZKPYTCU3AYSF2ltuaTXsg==
X-Received: by 2002:a05:600c:35cc:b0:459:dfde:3324 with SMTP id 5b1f17b1804b1-459dfde3545mr10378085e9.29.1754320635920;
        Mon, 04 Aug 2025 08:17:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3030:f63e:fedd:700f? ([2a01:e0a:3d9:2080:3030:f63e:fedd:700f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bd5a1148sm56470755e9.0.2025.08.04.08.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 08:17:15 -0700 (PDT)
Message-ID: <6408ca9a-bf7b-45b4-982c-8a91d2ebf7d3@linaro.org>
Date: Mon, 4 Aug 2025 17:17:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] drm/bridge: panel: convert to use ERR_CAST()
To: zhang.enpei@zte.com.cn, andrzej.hajda@intel.com
Cc: rfoss@kernel.org, laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20250719164705961iryN2w6eDrp8KeLJMkI6-@zte.com.cn>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20250719164705961iryN2w6eDrp8KeLJMkI6-@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2025 10:47, zhang.enpei@zte.com.cn wrote:
> From: Zhang Enpei <zhang.enpei@zte.com.cn>
> 
> Use ERR_CAST() since the macro clearly indicates that this is a pointer
> to an error value and a type conversion was performed.
> 
> Signed-off-by: Zhang Enpei <zhang.enpei@zte.com.cn>
> ---
>   drivers/gpu/drm/bridge/panel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> index 184a8b7049a7..7d2d67e56cee 100644
> --- a/drivers/gpu/drm/bridge/panel.c
> +++ b/drivers/gpu/drm/bridge/panel.c
> @@ -291,7 +291,7 @@ struct drm_bridge *drm_panel_bridge_add_typed(struct drm_panel *panel,
>          panel_bridge = devm_drm_bridge_alloc(panel->dev, struct panel_bridge, bridge,
>                                               &panel_bridge_bridge_funcs);
>          if (IS_ERR(panel_bridge))
> -               return (void *)panel_bridge;
> +               return ERR_CAST(panel_bridge);
> 
>          panel_bridge->connector_type = connector_type;
>          panel_bridge->panel = panel;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

