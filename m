Return-Path: <linux-kernel+bounces-890211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B2CC3F7D3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 11:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 936394F41AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 10:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3457D326D6F;
	Fri,  7 Nov 2025 10:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W46CrsFF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D29321F20
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762511438; cv=none; b=ANR9qyjiEULPiMSr5fOGcx4yUYidoi1G0oz5C4wW5ZRSGhMQu43avqDr3gwlD5EkyPQV+DsEgWOBtlPs1ksGvRDeoZwbaV4M5Yb2YES0oAwaBcAVHL1eoVe5ZGiEQ2xjM9T5X+cH9AKQRqXlx85hrKK6xiaHFajnqEJ2Df+37dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762511438; c=relaxed/simple;
	bh=uBd7OWZIQZwA0teWIseEIoU/S7sDMB9spsfmesIaCQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CMArGLWqJ7YIDnVgme33CgsrEW+n+gGQDDUIMTyRvFYkkHG/y3+m3r6y+IZSIT4wPFs6rEEAxSb9cu4xGP7MRMmxzdWskjZR1hoOf6XY2ooGK7XQ0w8bBp4Dg6IhWvvn0ZLdWlPrXAaXOULsqTvCxCMbXni9Eg/VIsAY5mgOtZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W46CrsFF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4711810948aso3916565e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 02:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762511429; x=1763116229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdXi1VUn5WnebblzEeFtNSpH8JjcIBHUGIXhJ5CQTgk=;
        b=W46CrsFF2DzHCCQnc/ve5Hwrr+zw2n+pr/HQzutiIHHGl4jee0onbqf/SZYbVLiTU5
         m2iO2yGQUWEWnbjqCbUEy6aNpnSSv6f88Sik3aFsQJbk1xmgyt/sAFMt+1zrW80glZHR
         MYoJqYk4jRdw70+qsI8U6CWy5z/nrvHydnm8h/C0rExcmPfWvKolZYLoHuHlIwg0sFi2
         SA2W8C6D8bDoPPQsUB8AioN5H+M37TIzS3An9LllTmnpzcCrgMcQXBG+jlC4RkCMJ384
         FP0KupYBWzb3Y4Os4v4SImKJavzTBarFGnEErzC+UW9YaawuGwUym+Eqpq3GbUuo71E0
         Pq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762511429; x=1763116229;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdXi1VUn5WnebblzEeFtNSpH8JjcIBHUGIXhJ5CQTgk=;
        b=FXFrhx5el7L3qinTmkFHVVfOx6xuHXfhWyKkMvmxN3ZuY3yA6ZAGJefb6IxZudd6Kw
         bywVIwVY0gX8NGAhmgpa9Oc6wCy8jHPeczW28/KpKwqhUacj4eDPwvuopXoq0RW/9dZt
         ix/s/843wP9osnNn59U9VG5qYpvnkGBovPVDMmz5DVpg07q4BN3ZQ0vG3Ojz1Di6ZWWj
         0J1R5aayCRH4XGr/hDrYhg/8wFh+xmZtvMUQ2U6pF5uqESmy79IBDh1oxaok6coh/fq5
         3R12su4B2+F5vWjXbmVHbFXo4W9pgU+v9WG7pSd7a3h85anByruGuNeMjF3tCyqJOhSX
         lSgg==
X-Forwarded-Encrypted: i=1; AJvYcCXRclm//QC7PXs49WZGqQ1n+mxqP4vhU2KZwb+xvkVqj7FpdCMPnZ6iAaPB3sHQ9Jyxml3x4gaFN/ssI0c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5PWINgD2t//K8BxMEfsDeqzhooZ7idPCsfk7OFYsYAMmqp99N
	4w1L1E2o6H62cGpadL2zmeqUvaZcrIRwVmSZqiujp/xXTeALyIVeTmvPO4aUxVFtsl4=
X-Gm-Gg: ASbGncvGSzmCFlRRNMlBuuP/C0ArfbA3mJpPza0V2vSrR7ST3Qwmzlm35r0ZhR1CIgP
	v5XUDDdvSDQLmokkWd44P5jQA74kjvfjZ1OZ68boFeKsJnCfxKj/E6t5CQnyyHjG0mHQUwH3hoo
	/i6mRR4Sdba0oZ6CnDfYS1pWN0PGqq98MbbukZo1sqSSQpXY6u4plkOHFsGedq5xpTRTZPLmWzz
	UljdnuZi0JVCWXtbtJBRKFotyWFxemcO8iH2x4eHzzjOh8lcLSi4adUhWsvQRuEipPWxYyz9lRI
	ZwQjyVA/0khUOdFodxK+Opd5DHNOWczF6TI8KN+I3M9gEwGR/rOLZTjyV4scHqeBjaGD6Leq29w
	fHWA8upAAzzgbJQcAM9a8gHVJ02ggkPdz155QFLPP61JUbHsPAhdXWEZnyPMT9tTGw46gn0j3v4
	b3KZjkX8XVf3gnLidSNtfEZTCbRX78lhae1Q==
X-Google-Smtp-Source: AGHT+IE6wGGrTa2Of4J6WHqQuB5miuumaX9005ll7uHOZgbpYuJ46LLqftJ0moP7xlPSeD3ujFGq5g==
X-Received: by 2002:a05:600c:35d0:b0:477:6d96:b3e7 with SMTP id 5b1f17b1804b1-4776d96b678mr16427785e9.33.1762511429427;
        Fri, 07 Nov 2025 02:30:29 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776bcdd8e3sm39799555e9.10.2025.11.07.02.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 02:30:29 -0800 (PST)
Message-ID: <e928b078-ad35-461e-8aaf-d5ec036ac4db@linaro.org>
Date: Fri, 7 Nov 2025 11:30:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Add Akhil as a reviewer for the Adreno
 driver
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20251104220245.240480-1-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/25 23:02, Rob Clark wrote:
> Akhil should be getting tagged to review GPU patches.
> 
> Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1083598bb2b6..033675aab0d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7880,6 +7880,7 @@ DRM DRIVER for Qualcomm Adreno GPUs
>   M:	Rob Clark <robin.clark@oss.qualcomm.com>
>   R:	Sean Paul <sean@poorly.run>
>   R:	Konrad Dybcio <konradybcio@kernel.org>
> +R:	Akhil P Oommen <akhilpo@oss.qualcomm.com>
>   L:	linux-arm-msm@vger.kernel.org
>   L:	dri-devel@lists.freedesktop.org
>   L:	freedreno@lists.freedesktop.org

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

