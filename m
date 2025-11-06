Return-Path: <linux-kernel+bounces-888556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939CCC3B2DC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC19D563CDD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B32632A3EB;
	Thu,  6 Nov 2025 13:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srfdnJ+2"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78FC30F7F0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434479; cv=none; b=KzX28Ndplx0B3Dk/ibD11FG/jD+QDsWuG8+jIGxg+rvynWt2uDC+MKwgUht1FuU4EEisJv6rkyLbacLYdZtWgrD3+ha8fIFaTx2ExtvhY7v73WM4h4Begi29zIXdVeNfNvucxtHSFnOYFctg22wPcVs8fhcZwOrpgdnGGuhopxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434479; c=relaxed/simple;
	bh=M4QT5Dzf9GjJafEiQfiyy2fY/ikWWsQVry7YuWSnjEA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=VlxBYgxXw3tOOdbXwo39Hk453TXg1PurZZOUaoAVo0+bI6pa0WXARDNkgZeKSD3Rpzhs7wBlVEYKs0UVf40EZg/2TnWpmiAP2RUoqW0nxmAhYX12dhEex1zTItcRa2FwASuLw5cLabsBFOQaZieo9MgePe2ZAoce/tYxz4W4DLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srfdnJ+2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775895d69cso4766405e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434476; x=1763039276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QvPSUGb//zRFPRLtsCtC5iw3J3piVlBv6zJlWuYiB0=;
        b=srfdnJ+2SHO7DxHG+320ita1djRjzlDffOXD8kbzdLn4yuD6Fr+OJeAXlG5EiVveDz
         JS1wPYxQp02DV7sNdODGsXeYBHqNG+VQ8TrJs53eOsyj+Cg8ntBTXeuGCEzLb+tRpUgH
         HbnxR3gZEMBVFdNBgrjRTPYIgdwkEiYMqQBW3XEEikF2wTJjArlmKRb/KerplSIFth7x
         kHmAYTmJjpiRKb1AL1EScGhD/xTqUroBwXmzcackFBbkikN5Ma2j8R/3+xs0iqP0CFAQ
         JElOv42/w6T7pOlmzwGflj5nqwJBMw+JSn8LILZm1JA8pmUYDTadmNAP6ZKcmZrmC4l5
         mTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434476; x=1763039276;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5QvPSUGb//zRFPRLtsCtC5iw3J3piVlBv6zJlWuYiB0=;
        b=q+BHbur/zJiDk2y+yxXDSJteIl5uIglz3kTbu6zum5BtCMTyDS+oB201XsRrDc/347
         4tEdJgmiBnXCnTiEXJShOuO2fNPIHLKAzFaSPu4lPr9RJyJxKFunqTMWsRzADtTRd44k
         t9ICc8RHftTB9HbnDSYXFJPNYFV+W7XaXCACwtMhqgQQb88qJlvdsZrQFFLttsDjkqpd
         slvvkDysonZ+0efjmVZHADP+b1FsF9JuC5ELsoAeYuiYQyEPoY6yoJ0+dy2D0KNhgQEA
         T+UuSVZDRv0JFn9/S+g4sPYp2HUsFO7Ct0tklJ1pWsxlojpgsdisrlbxXGR5bToEytNi
         9XWg==
X-Gm-Message-State: AOJu0YzH8aLTwcFxMbuXNeMTp81W5REwAEYStJfgDbfKSKQ9olsVbAkt
	KwMDPQJ/Yqz8gM9wzlkQmtSEShV49uSdhCQZxOrTk4Bu6Rd/PhkzSG311Ww6Rnma6no=
X-Gm-Gg: ASbGnctlthU+q0WjJXtV7obcWL0dLsVGSOSxiWTjhnjCPr5mPjCW6h/0Fmh4aPb+1Nk
	Jl4VaXVvQBT0BbLpqvlJTMdln1a1QtO4L2MH3c5+Ke3zAssykubuNb91SXvHHaM+rC8U8GfvlV2
	Llzlf22goCXWEegP08t02LjMLqz8ZyjSVzo059ZK+evqEvJ1UwofkGhnZ87Lky9JIJV9NcU0K/R
	eHzcb21ItELzluZ9an/SKHl7aeSjYZDrxODSIaRROf+/RtfYZuq3QcnMKS200mPkWMbtCDUpocH
	Quh8VWwTpRr71Tw/PbQbQ/n32WjfKR46oGl2spT4cw1nlURSgwwbPyuFnPqJqOjgSYH51QJ/Fn3
	zVSesFD4p9Wvh+i1pQAo8BnWatAShMP5edfrzHRmWeTLGH8KAZprq2AO7LC5O7p9SMprbkfG49x
	Cn18vIdM5wbwlkA+/VlExiGgif3APlubfu/w==
X-Google-Smtp-Source: AGHT+IEcA0Q2m/qVvATLPTcfnYahR6FSKXQ5pQBy1S1Zf1wyKWuv6GZxoL1JXLz9q2/EUWawAmfXkQ==
X-Received: by 2002:a05:600c:190a:b0:45d:d97c:236c with SMTP id 5b1f17b1804b1-47769d50827mr12690725e9.21.1762434472702;
        Thu, 06 Nov 2025 05:07:52 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47767749916sm25485755e9.4.2025.11.06.05.07.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 05:07:52 -0800 (PST)
Message-ID: <73e4c1d0-f6a5-4989-a918-ba0d5cc69878@linaro.org>
Date: Thu, 6 Nov 2025 14:07:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/5] arm64: dts: Add gpio_intc node for Amlogic S6 SoCs
To: xianwei.zhao@amlogic.com, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
 <20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe4781c1@amlogic.com>
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
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-3-b4d1fe4781c1@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 10:45, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add GPIO interrupt controller device.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> index 0dca64a2ef9e..3ee1b563a34a 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi
> @@ -199,6 +199,16 @@ gpiocc: gpio@300 {
>   					gpio-ranges = <&periphs_pinctrl 0 (AMLOGIC_GPIO_CC<<8) 2>;
>   				};
>   			};
> +
> +			gpio_intc: interrupt-controller@4080 {
> +				compatible = "amlogic,s6-gpio-intc",
> +					     "amlogic,meson-gpio-intc";
> +				reg = <0x0 0x4080 0x0 0x20>;
> +				interrupt-controller;
> +				#interrupt-cells = <2>;
> +				amlogic,channel-interrupts =
> +					<10 11 12 13 14 15 16 17 18 19 20 21>;
> +			};
>   		};
>   	};
>   };
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

