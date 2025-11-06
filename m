Return-Path: <linux-kernel+bounces-888555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93FC3B237
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 924FE4FBEB2
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 13:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4F632ABF6;
	Thu,  6 Nov 2025 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rmuPyfyb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191F2E6CCE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 13:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762434463; cv=none; b=OlnW6yQTYvo18mvk3HYzjHHWKg9qe+vnDHf00lR116Dq1zyhLeqsE3IdnUfkoYDklhr9YH6S4npHSssqe9+Q/shmdNnr+67Zi3VzBF6aYQIbynJELrZdRJnJAlrBTyCJ+kCx13l4wytBnDdncQISdd/Fr1sGuaMBL+sxcHgYGR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762434463; c=relaxed/simple;
	bh=LRYrbPfj7iDywk6i5TpH4lu16qc/Q3uOnOAZZcr1P5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lA7Z8SrdL0CLMj+ZUaLyuVFvcU9u8N3t4QX0WHbZYXub/AkZY9AX9tkGSZ3kB9bd+lLWeaGkn0ryI7vJdMXHu3qmGKud7Jkey++E3ClKaYCZrPHPjxX2w69sEyCq1u8cP3O7mBdUmAT48F8vKEYCQkMl0UG4gG8CyZINbNbVQ7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rmuPyfyb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47112a73785so6131545e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 05:07:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762434460; x=1763039260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yLyeCjgls6cM1HvoV4Agizj+GB/rHC0r8rByuRqqxM=;
        b=rmuPyfybejU8CSesISW4TXUq35Zed2iFNGHyGPTDm7AvrRVmzbFSkSFqW/rKWCtJjg
         c7FTL5DZwYzEMdeIRZRSN5WRAcJnKwlT/9D4sFy2iCWWGS2oDjBaKuuIfkL93s+p75GI
         +Bw+DHg/jK+tbILL15FhwodMXpQ0ViGxt7IRwiIrtRg1xwKgwUgn0/DmQucLvQ9DhH+Q
         xBpaepkUJZPBr7xBgTbmgEwEgx4k8EmPZR2yFno4Rq+bGwip1hsGn9XnryyN3R/ZWxsE
         7bfvylCTh4SFRXjAGLhSB8AnPSIajMTOnBV7YRERl+xvD2WNplwt+8+z8qMdhbKI4OyO
         ooIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434460; x=1763039260;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2yLyeCjgls6cM1HvoV4Agizj+GB/rHC0r8rByuRqqxM=;
        b=EMlFYw4i2yEuhtt8ktdgAxhMnQ68JfXmFbbxc32rtbNpyMhZOOIIi6IMQWSZPaAYgA
         3OghtPl2kKU0eue7qJZTjsbVKT87hvk18FL4mDeGSxOpT1WEoVMlGPBagf1ckyHolDw4
         4yFW+mvAdpOWVrtudy/Z+0ESzjR1C7Z0xX+6+VLeqPrF5l9hdjuEqQ/cxlgye94rfBeM
         sbFTjP+mL5uP6dl1cMsQRDj0j6wPQ3rSRf8o5lcaPJKCZNjeOOhOgZOlzwkg46LTg23q
         FOIrStYoi0843hI8BuKNMKW5PGy9frwoezrEApdeIUoNj/dbrjfwsb5BdxwPw8wrj5mb
         8g2Q==
X-Gm-Message-State: AOJu0YwlobKuf45RmdjSfj9Y2OJQsSuEG30EXWOmocleioE5wkkrpSZr
	BhL/8JymAwEeZYhwaSMxHzdOrxgfB0ANfbiu88Js89oagXhrkzkgbw0tOwu0CFUMG7w=
X-Gm-Gg: ASbGnctKMnkx60s4Jw3UPhtVQfxJkQLkvi5MO1PNcp8v5Hu4Q28G9AUa/s38oD86ITQ
	40kyGpzBoQ+Hf/Dhq7gxHz7csF40ehSqbp/AmyGwSRTAVoIzhjfHD1bpQQAy1+/bDONlKGzl6u7
	q76FjyKUmKjUKaB6Fr275hwDrwfb+1PTMwbqmkAe16ZoGN6BchAGJe/L7erTnAk2WGy38Ppio93
	afDhh0SRuogAaJnPr1sUNtGQOOcbkapSDNFK52ZlYpgzBIYGXuJQ2c0shu62CKwdJ9AR0tTUVRu
	cz8FaqJE/n5+3kexrYajD46pRdUv0QViEtgeyqUjZreDFcWjgxz251jd5n716DkMl+jgsGU6Tbd
	2VSOgZcaR0qXV/CdCVBM5FpH24lXFNFS8BGV0Msl7j1y+xfXIA3wij0NVReMgnK7UtfnkEP9qMg
	VitdOLHd/OWtlNNNE1RYkix41I4sdsR5Y4Qg==
X-Google-Smtp-Source: AGHT+IFAsKArlrU067DkxQxwFDKfyGP6fHe4iUyS/Bdq+iRDMjLgKkS8gLp/s5Zpe2BQhezfS1P8SA==
X-Received: by 2002:a05:600c:1d88:b0:477:54cd:202e with SMTP id 5b1f17b1804b1-4775cdad6aamr62589075e9.2.1762434459994;
        Thu, 06 Nov 2025 05:07:39 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763e4d7f2sm15640615e9.4.2025.11.06.05.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 05:07:39 -0800 (PST)
Message-ID: <f324cafd-c466-4cb8-81ab-fbabac7bbca7@linaro.org>
Date: Thu, 6 Nov 2025 14:07:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/5] irqchip: Add support for Amlogic S6 S7 and S7D SoCs
To: xianwei.zhao@amlogic.com, Thomas Gleixner <tglx@linutronix.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20251105-irqchip-gpio-s6-s7-s7d-v1-0-b4d1fe4781c1@amlogic.com>
 <20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe4781c1@amlogic.com>
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
In-Reply-To: <20251105-irqchip-gpio-s6-s7-s7d-v1-2-b4d1fe4781c1@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/25 10:45, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> The Amlogic S6/S7/S7D SoCs support 12 GPIO IRQ lines,
> details are as below.
> 
>      S6 IRQ Number:
>      - 99:98    2 pins on bank CC
>      - 97       1 pin  on bank TESTN
>      - 96:81   16 pins on bank A
>      - 80:65   16 pins on bank Z
>      - 64:45   20 pins on bank X
>      - 44:37    8 pins on bank H offs H1
>      - 36:32    5 pins on bank F
>      - 31:25    7 pins on bank D
>      - 24:22    3 pins on bank E
>      - 21:14    8 pins on bank C
>      - 13:0    14 pins on bank B
> 
>      S7 IRQ Number:
>      - 83:82    2 pins on bank CC
>      - 81       1 pin  on bank TESTN
>      - 80:68   13 pins on bank Z
>      - 67:48   20 pins on bank X
>      - 47:36   12 pins on bank H
>      - 35:24   12 pins on bank D
>      - 23:22    2 pins on bank E
>      - 21:14    8 pins on bank C
>      - 13:0    14 pins on bank B
> 
>      S7D IRQ Number:
>      - 83:82    2 pins on bank CC
>      - 81:75    7 pins on bank DV
>      - 74       1 pin  on bank TESTN
>      - 73:61   13 pins on bank Z
>      - 60:41   20 pins on bank X
>      - 40:29   12 pins on bank H
>      - 28:24    5 pins on bank D
>      - 23:22    2 pins on bank E
>      - 21:14    8 pins on bank C
>      - 13:0    14 pins on bank B
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/irqchip/irq-meson-gpio.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-meson-gpio.c b/drivers/irqchip/irq-meson-gpio.c
> index 7d177626d64b..7e718b07e960 100644
> --- a/drivers/irqchip/irq-meson-gpio.c
> +++ b/drivers/irqchip/irq-meson-gpio.c
> @@ -174,6 +174,14 @@ static const struct meson_gpio_irq_params s4_params = {
>   	INIT_MESON_S4_COMMON_DATA(82)
>   };
>   
> +static const struct meson_gpio_irq_params s6_params = {
> +	INIT_MESON_S4_COMMON_DATA(100)
> +};
> +
> +static const struct meson_gpio_irq_params s7_params = {
> +	INIT_MESON_S4_COMMON_DATA(84)
> +};
> +
>   static const struct meson_gpio_irq_params c3_params = {
>   	INIT_MESON_S4_COMMON_DATA(55)
>   };
> @@ -195,6 +203,9 @@ static const struct of_device_id meson_irq_gpio_matches[] __maybe_unused = {
>   	{ .compatible = "amlogic,a4-gpio-ao-intc", .data = &a4_ao_params },
>   	{ .compatible = "amlogic,a4-gpio-intc", .data = &a4_params },
>   	{ .compatible = "amlogic,a5-gpio-intc", .data = &a5_params },
> +	{ .compatible = "amlogic,s6-gpio-intc", .data = &s6_params },
> +	{ .compatible = "amlogic,s7-gpio-intc", .data = &s7_params },
> +	{ .compatible = "amlogic,s7d-gpio-intc", .data = &s7_params },
>   	{ .compatible = "amlogic,c3-gpio-intc", .data = &c3_params },
>   	{ .compatible = "amlogic,t7-gpio-intc", .data = &t7_params },
>   	{ }
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

