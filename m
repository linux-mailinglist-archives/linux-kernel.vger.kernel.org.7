Return-Path: <linux-kernel+bounces-800110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E41BB43382
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED9A1BC6ADB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4E128A704;
	Thu,  4 Sep 2025 07:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhgggBwm"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A6D288C81
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970009; cv=none; b=Z5agGBfk+waOkxzuSRGdZjRFOi0AnJ4CBuE9O5TsqvmfoslzlqPaM6XuUJh0F5H6h53B6y/ukWvmAwJwcBo66w+xSTmJHoQP7s8yBdLXcj17M4+BxXG+b+9RVy8AOapACbUKWX7av4xjatsW8mILknj0lRMbW5cLf4HN9vEbRS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970009; c=relaxed/simple;
	bh=Z6oVMvamvALbeWSeiu3YA/SgCjbLhboLt7zCNcJbNrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dh+V2iDbXaVl2FzOsjA0sQ0djxmPecQvfqdGlrtDwl350vgsg4lN5tq6Kmj7z9EGKyTLcso4bSF0iIbGje013Q1wTfp61v6dZnKwraQZiIQJjOD9c2MvP68SpbAB2wpjNl3M6K+qaR3Kry2elGLji5gmtLxloQ1l41Mrn10n0nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhgggBwm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45cb6428c46so4837435e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756970005; x=1757574805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fenp/X6RqR1DwQ+CRZ8K7U4zGb71u1QKHuWPuUkXtC4=;
        b=KhgggBwm2Fpi8KcxFt/0kk7XrDYXJJJlLby4/SJ1RubniOglZhUYwGNPFoTr3qAoKV
         lNPh6efabpAOGlTddDGetP975XKygSAF2AvzaAgApjchkykRoBVKhW86wyz8WoG+3Lcw
         IGhmyF6EMyb34aYi+4X3efJJF8KKaB8jnl56uEgKAXhM/KCyy2SYodonXA5S2LODgcnS
         OAQvmzwDUsEXV++jyNJG24sfEYwBx1thawDmkCxkD/Xz9760jh/8+eJhR2Y3kvZaUaOE
         PKgDoi2tXznz8559p5amKbd7OcDbZynuQYMbf063Z62gmdL0dfv5dax7kLnUdYyKHSwV
         1pcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970005; x=1757574805;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fenp/X6RqR1DwQ+CRZ8K7U4zGb71u1QKHuWPuUkXtC4=;
        b=YLdq8bHO0XZr1uxUKv/qk8RjoAbppeSOxth3TsY/+7PVFeTjdRWDSDEFz9t/6VkqyQ
         s/sAvEu3d+BsoiViJ8GOE+8+psYQyeLCVexr2FK7kYjSFPlhKByWGMJvlRqM2sQ6+tMJ
         BoQrDlQIKgEhiqWI9N8F6JgDrh1ztRcEqJ95Nfb8JEEbCsNZ6UrE2c5g1akmXB4zf3Nc
         HVkkZmA6uY7SKM6Zq79smgLTB1Hl3cq7pLuin09yNeZuuiHB0slEE1Uk0F+SEbxt0vKv
         4vRoobKK9XBMfZEP8NCkc4nKfJ86smTR4AagcjNMXj7poXiGHzFZU6yzCwrEvpgJico7
         5ALA==
X-Forwarded-Encrypted: i=1; AJvYcCUJSnmwQ1TYEWT42Fb8LGB+5jABL1bquIb9aGit2HhiOtBG3AngEHt614QSlDzFekqTe4ync/429Hs0+pY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ90Of/CSBAFBH3U8TqrPXshBo6wg8EESAKAAronEzeh6MScK8
	3t+QgYR5jgxYUZx/MOVrrwjli0Ofwi0hDf9DJfz8OVdMAZLtpSSUmHt3WXCQ7ri34DU=
X-Gm-Gg: ASbGnctDkvaC5l3Gq4WgKUHMkQ1v9VF2N/obmKaU11OzaxzZhmFVHjJbZgd3zwYf1CR
	W8c1yE5FQwc2Ztjre4sq8PvyzovxmLMW5JoRkHd5qKvkbcVZRxXQAIZM5m+AGSVm8gOw4e7Djap
	7aNgmGMQrDVJ3tGFmIg+gzWucmcoffj4zWOArHVozaIy0iDrdmNSPA6LzxPlBXns10Ico3Sir7I
	IYKGuBUhzCcm4UhS7bvBmkRYN4XTPxIY71RSPU36C7eF0+i2ytSr/9mAZhA3te4q0jDnez8zQKs
	XfE+kL7SHtmbI+h808u35LPJLOp6vlwq0VgdWEwDBq32owz/lF3l8X2aDnZDJdlyFdzwYY77KTe
	SGZYzjdLvTnmM66DtDMOgaWjvByAB6hF3zGc71gPw0Pa+Hp8j9JIj7qAOOY/cxz4TtdsaDervnY
	YdhBvJxVR3TA==
X-Google-Smtp-Source: AGHT+IHu1KVv6buqQsAeYyC+dtdchIYeBk2biQaH2Sq8CbqeIix4PZZ4xQr9UmtL7cObG1OaNDoI0w==
X-Received: by 2002:a05:600c:45ce:b0:45b:8d8d:58b5 with SMTP id 5b1f17b1804b1-45b9ab8a216mr76402875e9.15.1756970004660;
        Thu, 04 Sep 2025 00:13:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:8c14:335d:24b1:fa98? ([2a01:e0a:3d9:2080:8c14:335d:24b1:fa98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b93fae643sm117882305e9.3.2025.09.04.00.13.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 00:13:24 -0700 (PDT)
Message-ID: <a3af076b-ca0b-4d5e-8294-2bf5a9814959@linaro.org>
Date: Thu, 4 Sep 2025 09:13:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 0/2] Add support for Gunyah Watchdog
To: hrishabh.rajput@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck
 <linux@roeck-us.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
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
In-Reply-To: <20250903-gunyah_watchdog-v1-0-3ae690530e4b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/09/2025 21:33, Hrishabh Rajput via B4 Relay wrote:
> Gunyah is a Type-I hypervisor which was introduced in the patch series
> [1]. It is an open source hypervisor. The source repo is available at
> [2].
> 
> The Gunyah Hypervisor doesn't allow its Virtual Machines to directly
> access the MMIO watchdog. It either provides the fully emulated MMIO
> based watchdog interface or the SMC-based watchdog interface depending
> on the hypervisor configuration.
> The SMC-based watchdog follows ARM's SMC Calling Convention (SMCCC)
> version 1.1 and uses Vendor Specific Hypervisor Service Calls space.
> 
> This patch series adds support for the SMC-based watchdog interface
> provided by the Gunyah Hypervisor. The driver supports start/stop
> operations, timeout and pretimeout configuration, pretimeout interrupt
> handling and system restart via watchdog.
> 
> This series is tested on SM8750 platform.

Would this driver work on older platforms like SM8550 & SM8650 ?

Thanks,
Neil

> 
> [1]
> https://lore.kernel.org/all/20240222-gunyah-v17-0-1e9da6763d38@quicinc.com/
> 
> [2]
> https://github.com/quic/gunyah-hypervisor
> 
> Signed-off-by: Hrishabh Rajput <hrishabh.rajput@oss.qualcomm.com>
> ---
> Hrishabh Rajput (2):
>        dt-bindings: Add binding for gunyah watchdog
>        watchdog: Add driver for Gunyah Watchdog
> 
>   .../bindings/watchdog/qcom,gh-watchdog.yaml        |  76 ++++++
>   MAINTAINERS                                        |   3 +
>   drivers/watchdog/Kconfig                           |  13 +
>   drivers/watchdog/Makefile                          |   1 +
>   drivers/watchdog/gunyah_wdt.c                      | 268 +++++++++++++++++++++
>   include/linux/gunyah_errno.h                       |  77 ++++++
>   6 files changed, 438 insertions(+)
> ---
> base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
> change-id: 20250903-gunyah_watchdog-2d2649438e29
> 
> Best regards,


