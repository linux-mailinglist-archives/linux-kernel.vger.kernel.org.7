Return-Path: <linux-kernel+bounces-841066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E62F1BB62E1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 09:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0DA3AF241
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 07:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CA9A2376FC;
	Fri,  3 Oct 2025 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMqyCqBy"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B3724A051
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 07:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759476814; cv=none; b=hs17JDIE9ijZG7pQ08bZ9E12oQbakFq0trTkAd8pTfGNd2UCPzGIK/L19ZpSu66f4LffUAFdYNPrQgWxjaVI9TQzCq7fm1JEC+lLMj97drZyPisWCNK3GGSTrzRqFWzxKG1Tc/R9hVYMRZ+AKwG9hjPWpmOmmMzvZiMPtgkNXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759476814; c=relaxed/simple;
	bh=IxHI9oZKexr2YZ8a277fL0eG5BkjOZVsjcZA5qaSKIg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ASVp/dfngESMbLjjQY6+t1ThqKDLwDiE/s0eJvicRhIYtuaeW0RL94Ev0REvjT+9Bda0nQ9kCoYMq+dvKPwEecHUlVaODhjs+6v+rmg1CgXvaNKk7XmMG/fWxYtMNUTRU1ld2sXxoihJYM3YaHPYS4W3QPV9eWgghURqwezUX2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GMqyCqBy; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2e6a708fso12310905e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 00:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759476810; x=1760081610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5grRFMX+2MrPypsgKycA1aZd8AJQaqdGLD/iYz7bwBc=;
        b=GMqyCqByLpZwSGHy76HGNP8qE3V9eZZjuIXzRbjhSCGNrI7bjHR+9qnqzK+ETwySBS
         eTmpurDmYRKOH5unq18W9Ykc17GuSeozwaxBWoval+Yzni8pjNVje0iDjsBwCweieYlG
         Z14x2RiYgG9Wmdq2KkSdRretyc0SUW3PpGAoG+fjr8iLhB/dsF/BFYmluddP9TaPovlI
         BHmeEXtJ69+DEVQYBa5uJ5zMhnkq+XqM3lbzYwIbZXW8bCerG8/4vSO7Ohq5agQKSMYJ
         D7+Vexnn1fCoXezRTZnDjT0JnvjD7tQJhL9ykxJX0H3LxxGfIZfu2xi9hcxHzxj1zzlu
         A4jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759476810; x=1760081610;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5grRFMX+2MrPypsgKycA1aZd8AJQaqdGLD/iYz7bwBc=;
        b=shjljj71tzxQURfY1I85QIQw+wEGRDTiHf7MOaJ8T9HUybA/Pfl3Rph061Mq4OlZQ3
         ygLfvgWDVq+WcEBIW85hAc+U0OyeHUCkBGVct0r8/7HE6mAB83nno8SkuoG7/2v5VG/j
         M47KPrONOptuLeeQ4K28JRWhWPTITjbS8hzolVJqUpBpMXmGWAiihEMOdp6x57ZArfWZ
         vMV8TWV/nG/6cXURypz72U12ZUxoN/CwHhTEI97qStPo9tKg2hkXdhXvD1/AbdZGorXU
         hfBGkDwcaq92LF1B8yWXA7wqT2Vcrdv2feYvAnlPzMvaDK+gdVZYcryWjp7IPzZOy9As
         zSSQ==
X-Gm-Message-State: AOJu0YzZgNSHIERzIbSEzLJvX47PRZJ4wkvkwYMxbV4zEV/nMCYPqoV+
	eMmONJ9LHwEaQiH5o3GrgEvavCwnXndjADz/bQTHOThtvLrWID3X1u+dj2T6fSWxHAA=
X-Gm-Gg: ASbGnct/43V31/Acg6KWbT1hUXrgk0QFM44syd9qtXjRU/EeXSP/2kUgO0RGC68jtTz
	0a3raAILaMYpl53vBrQtdeNYANA8HwEAHbou87hDTzxaVshODnQ9/nhqPoGZlm080/d4eFO2mCT
	nqnM885tGIm1UlltVffRmPN1awk573zdsmEURvl8cxt30FM73+my5Js6+xHhC9eCDzWuPOuAHyX
	lTDw2SBGT32/t5q1kZXOmLy59O0155UwcGLkdr9E52RHg9f7j+mbVQ45BfPqKbCfjzzV7NtveI5
	pyDTbX3cF/fBXhvTpDRMRiwlGNYs6a+GaKrVGOPlQZqDzXsRmqho1RUBbN/3AmqWXby8Ad1bZ+n
	zXv+xkSB4SGMatN8aD8zQ8ROynLUdvaJ5mGlkohlhjA88K+KCrWwyBycnTw94PD/lukfpcPYEyr
	ZbFzz3C0XIgd7zK7T+Khe4qLArFB8=
X-Google-Smtp-Source: AGHT+IE3WIkcpTDGTYbL1KkTG7og5gmapvp+rB9slPdpJDq+7fpgXOqr+o6R0DGbS0j/8Ti8nPucHg==
X-Received: by 2002:a05:600c:6094:b0:46e:39e1:fc3c with SMTP id 5b1f17b1804b1-46e710fff73mr14591685e9.5.1759476809742;
        Fri, 03 Oct 2025 00:33:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1516:b5be:def8:9a0b? ([2a01:e0a:3d9:2080:1516:b5be:def8:9a0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e675b557fsm96132185e9.0.2025.10.03.00.33.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 00:33:29 -0700 (PDT)
Message-ID: <3ccc3649-dbb6-406a-bec4-fb3d4068bad1@linaro.org>
Date: Fri, 3 Oct 2025 09:33:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Update Jessica Zhang's email address
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Rob Clark <robin.clark@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
References: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
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
In-Reply-To: <20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/3/25 01:57, Jessica Zhang wrote:
> My current email will stop working soon. Update my email address to
> jesszhan0024@gmail.com
> 
> Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7e7515a412e9..7a712ded8f9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7652,7 +7652,7 @@ DRM DRIVER for Qualcomm display hardware
>   M:	Rob Clark <robin.clark@oss.qualcomm.com>
>   M:	Dmitry Baryshkov <lumag@kernel.org>
>   R:	Abhinav Kumar <abhinav.kumar@linux.dev>
> -R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> +R:	Jessica Zhang <jesszhan0024@gmail.com>
>   R:	Sean Paul <sean@poorly.run>
>   R:	Marijn Suijten <marijn.suijten@somainline.org>
>   L:	linux-arm-msm@vger.kernel.org
> @@ -8325,7 +8325,7 @@ F:	drivers/gpu/drm/clients/drm_log.c
>   
>   DRM PANEL DRIVERS
>   M:	Neil Armstrong <neil.armstrong@linaro.org>
> -R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> +R:	Jessica Zhang <jesszhan0024@gmail.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
> 
> ---
> base-commit: b5bad77e1e3c7249e4c0c88f98477e1ee7669b63
> change-id: 20251002-quit-qcom-5125b64a86aa
> 
> Best regards,
> --
> Jessica Zhang <jessica.zhang@oss.qualcomm.com>
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

