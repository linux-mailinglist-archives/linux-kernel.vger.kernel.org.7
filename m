Return-Path: <linux-kernel+bounces-869074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D76CFC06E3C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A313B709A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234442580E4;
	Fri, 24 Oct 2025 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fjSsMNSQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B82D31E0FB
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318725; cv=none; b=szZTuZXAfMTbGUxqqafxw0DnGPQG/ys6YqklvrJ6XKYBTxHV8uRjghoqd+cPi7sSlbf/dxOxq2IBZYrQxsBTskskG+A6WNq/v3emGxZ9G3qBJ5njS3JwFy7DXBSEncUTvhZ2b8FizeRhtQnQt07e90oibYz0ie6efSISaQwNnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318725; c=relaxed/simple;
	bh=QwgXU8uENG1NyIQ/HGUMFTRHNCKH2t2fKCl4sibpOS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVTsPgBOj5h3zO2dVA7Gq94aqp6VDgO2X4V09UZzAmvYpGJPS0KFDyycphc+2bLzBTBmsX7y5hoPPFMCu/15AJ8+bWUJqzRqoZvd1wHdom/QNXohq82wl/iJh728bVogXoHqiu3ORP4DcuBZhgWihx6PKBMIoZ2oUS0cV/ZRpWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fjSsMNSQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-474975af41dso14976075e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761318722; x=1761923522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pKXKa1r9FQp0EetqAb+WbXj1OlPLTljUDebvvRCMG5U=;
        b=fjSsMNSQyJioKTIMCU6A/e8gZ9L9Rb6Y9dIaLKc+0LJOAaIHO0F74BO8yunychAR1E
         53SBeu9PshIIH4n6feDkX/JBF5V4iCVR0hKKjlSI4XcuxXAx8j6/rstfui6Ar/eqY1RM
         e+cDAnKR131c9adyDkUMu29qldGNk1fQP/JbTKahPKk94PH/tviuFbDU8qaigfRm5CAV
         +IJgAQwzoHtSt3SGeVBZ33k+PbeF/RdkPQ8mE5mpXCFeUOwhhHPuMhMVWoxu63oOPAO3
         s5XgjnTQKGqeDNNgv+fVo6+65+1HWCAILbLgm/4NCoRgaZLuPZMDT7Cazcy4x0Q+VD+f
         Pd2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761318722; x=1761923522;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pKXKa1r9FQp0EetqAb+WbXj1OlPLTljUDebvvRCMG5U=;
        b=b60e1H/1f+oooAlGnvKMjoiYEE9oyBdP06W2KxPGrYmXvR4wfwpFAiquNKBqjNqMTz
         F5CsRNQnrhxtwds6zl/WRH1MbaNao6y7RDP+dwQdE2Vs+Lgi8zn643suc923UcWJyTc/
         z4oDG4QEnsPFjBrs2RIB4wS2bP1KubWGkziO7ia8hvX0wbwiZPtkYt55cfinDKAipyNN
         QjgRd3NzoK9UZJWcaHGS8hSAMC4L5fGfzaD94MvZ/8PAkImqSgSENpXg8Z4dbn2ueyHx
         y12JMajyEEr6Lc1KykJml7EwLuOVbQhya+JEwLSc88J02HuWu8AOQOX+XoH5x1Mcz2ir
         iSDw==
X-Forwarded-Encrypted: i=1; AJvYcCXXHGMW9uFBpyC56IhHyZDC0zfUIcjnwkt7kl62Mivftw5rVHE/zFBfxV0XAapnL1oXLfAE2cyXkdGZiPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZ7iw7HqDxs3YUqlg722h/yFYolKzp4EVe6dQx3EooB70QSqX
	w2vFQ6hBPUj5CwwicZvX3YmM9DpqvRdK7YYWM2AKLI8/u065Hrj0Mr5svOfqAdHdfXI=
X-Gm-Gg: ASbGncu3P+RhlPMCtgBHhRocA3RhPZa06ZiWZ8LzSQz69w0ns3yw/Cg4FwSe+EiiHII
	/XckY1NhEeLVGgl2DH1GIpkfMgP1Qu6EGuKI4SqNzaJ9eKOG5hZdqlxa7nZgKfCdbnFNWAfmUhT
	Xd5hptwoTo4xi17VWguCN3/b00uQ2rA4ctKf2tl5m+Gzj+78LfiPBkQ+Ok9R/PcPYIIlq/41SYB
	O6Ghn+b1QkwSAI4rPnNi+TNoZkv34mF6eDLW4wTilX174ZYbmxRAuHwEDHXeTHCiBSHL9Dj0Hsg
	YlpUzZlMvnTmZNPUKUMqcrxUPDXLe8ONV+fzNABehjXA/n+6i96LNXw+9btLSTPQuhlwyyCpc3p
	6C07IlIVZHM4no5MwP2jKhX/nc4cqP0zXLF6sKm/ZfGTE97FsmwvnIT5WLbqegIl0EdXFQa4r3Y
	eGHjU+pYvs7Iwj78jtdFVvLLhcuUXi1qeU49N9xetxFX3Od++/5FwQ
X-Google-Smtp-Source: AGHT+IEeYZZ1u4HY2vXbkSYScyAQKTH+8cdNSXByfKXc78Da0+wNoJJLRMMOc8tdqcg10A8rkudsJQ==
X-Received: by 2002:a05:600c:3e0a:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-4711791c522mr217452615e9.27.1761318721751;
        Fri, 24 Oct 2025 08:12:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b4ee:479d:354c:6970? ([2a01:e0a:3d9:2080:b4ee:479d:354c:6970])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm89873665e9.0.2025.10.24.08.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Oct 2025 08:12:00 -0700 (PDT)
Message-ID: <fe898b57-2b96-4f8a-8f27-58dca1c11ffa@linaro.org>
Date: Fri, 24 Oct 2025 17:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] MAINTAINERS: Remove Jessica from drm-msm reviewers
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <rob.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Rob Clark <robin.clark@oss.qualcomm.com>
References: <20251024-remove-jessica-v1-1-f1bb2dfc2e18@oss.qualcomm.com>
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
In-Reply-To: <20251024-remove-jessica-v1-1-f1bb2dfc2e18@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 10/24/25 16:56, Akhil P Oommen wrote:
> Jessica has left Qualcomm and her Qualcomm email address is bouncing.
> So remove Jessica from the reviewer list of drm-msm display driver for now.
> 
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>   MAINTAINERS | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 5889df9de210..064aecda38cf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7889,7 +7889,6 @@ DRM DRIVER for Qualcomm display hardware
>   M:	Rob Clark <robin.clark@oss.qualcomm.com>
>   M:	Dmitry Baryshkov <lumag@kernel.org>
>   R:	Abhinav Kumar <abhinav.kumar@linux.dev>
> -R:	Jessica Zhang <jessica.zhang@oss.qualcomm.com>

The email has already been updated in drm-misc-next, but .mailmap change
is needed now:
https://lore.kernel.org/all/20251002-quit-qcom-v1-1-0898a63ffddd@oss.qualcomm.com/

Neil

>   R:	Sean Paul <sean@poorly.run>
>   R:	Marijn Suijten <marijn.suijten@somainline.org>
>   L:	linux-arm-msm@vger.kernel.org
> 
> ---
> base-commit: 6fab32bb6508abbb8b7b1c5498e44f0c32320ed5
> change-id: 20251024-remove-jessica-1abd363a4647
> 
> Best regards,


