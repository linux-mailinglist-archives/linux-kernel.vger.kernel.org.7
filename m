Return-Path: <linux-kernel+bounces-740625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F164B0D6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362C25639A9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52BDC2E0919;
	Tue, 22 Jul 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiZIeG6f"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D9E2E040C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178721; cv=none; b=u1LODjZTxFAuXtoWy2+tBxnXM0B5AeAxa6bFkL8SLSnaTEOl3305cLq0y6e8ir3PYrjRN6+yIHX5bSgSnvqrnQM122AOy1QyvnCaSiIVHDv5arTvEBOmGJXCbRxHf1EkuzuytV6SXeuoaGdLvqRQ7aRYuAEc7mN7Ai4s4AXNli4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178721; c=relaxed/simple;
	bh=CzlgOk5IV5cLTyLvTOjZpyhrA7PFnTxC8JSq1EdM4/U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Lc0t7LTUL1/QKh6fYVvlSKGks9v0NfAZsVuvb90OkWwPzOcGp2JrauuALKlBTSInIpCxJizR8oyo/TBf8QyaUGbW61B8k++q4j7O6pPzbGnGcjOoXGhegvPI3cp4sGOuZ1l3KOihpBXJiEz8pBNQ1EYV0RDru2y8wF7dZw89gec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TiZIeG6f; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b611665b96so2966807f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753178718; x=1753783518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eACVn/AeNUkJSj6fqs1SPdUKZxcJXedSP1FDf4UsU+0=;
        b=TiZIeG6fzsvLv7dqU8mWL5HBnR1LR+h3em+XLazGLi/sb5eEP3XqP8wEKgsgyms5NA
         MtaZBUsn7E/bGVL46hFtqtzPXdQvXKXSBoiNY4NuzI7c1eRoU15nekGd23lpdNRvtw6j
         /HUK9NKuhNxa3fT5aWVYNPhHH3VDLAnPtklzUBG7Qc8izNgDHy8Dx0x5sY6Pq1U8FCaM
         JbFsAHgC+nCSJAtIEnTIPfFW228ARWfCRxGZCD/TR5QvjyTM33HzvJK/3p87oxTbcsm8
         kr6ZAUVUK0uzgC1Igjvo6tBa6ZsXf1CMPf+/6XA1TJ5LVeycrd5YP3LXO89bjCFEfSnW
         p2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178718; x=1753783518;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eACVn/AeNUkJSj6fqs1SPdUKZxcJXedSP1FDf4UsU+0=;
        b=aInIP3AT2fkBJ0Scaw4YjGNIp8revWOpkklhkKpBKSPK3b3DFSiYa5c9bxvM2izlMC
         HrlA/86vELixzYEbd+XsLtXW9sr4aXbq6kQAWyt+FtEvXq/CwdzdVlvUnz0q1dI2rljz
         QcZF00iuqO57yFjGeIW0aRSk98R29zOZk6WnE9zMH5KewMDgp+tQhk9fm38OD+4MUoHI
         5PQg/sIeKu822VUbfC+NgRzLJuJNLwKRHGle1R5ackNkKFjQHEwTnUnuItLMoeVmvm2z
         UpPP6K/cavLB/pnpdUBlSpf6t3ATPQfMQn8iF2BIcofdyN7CmfgZuOWI34Os4yZvkpM8
         +qmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFeAkOdj5+th5CGlak3tjhNiu+3OHT7hshIQy+8nXAkBlplY7mTa24qakttGmXrAtI7DXPzZXRoh+f418=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2J1uwRpu81kU6z2LZW/lvfj4Mc8asqfgk26b0ZaQ+5ezQCLgH
	vVOaV26/kXeIPpZ/7uic0WyH/9uYG/YY/3M8eJ9hvFZD89jcONkKt9RZ1RfquAwGTaM=
X-Gm-Gg: ASbGncuj2yf8diP5s5OGVeotEUc1STeUl9g1H66HggBesrkYovwWtXEATPdBBuJhgM/
	kYDJEbApR0Pai5dsw9ZwPMiD7m17AwGsZK0ItVCZVdchQ265NclwVq5nCAGqu5G6U6iBJP6QVed
	p683apDj5c24IqeWHRwjLF/vl7sdLv9F6oDrF6WYnUCcl487N/4oAvyWtHCrVPQKDVnV5xTU2gG
	qto5O6EHhsau0WjaqbIHOJVvaz5hCFQthn4qXmsqLBBscGDC7jNOFP/0biB9r+90D2Hu5MIRCWt
	FV3CmJmWTmSYxDPHtyeqCOzJyCUprpkqwz8SzThX7Uk/p9pRC0H3s40Rn/BNfz82JCfXPgp93OK
	ajMCfwmi970e6HbRpQhlBffmA26nqMojbV9GMy2rfhX/78wO4GyhTu3kA0kPGVPITzzqsxzi5kr
	k=
X-Google-Smtp-Source: AGHT+IGRKY81gkhXWhMn/9LTWKt4F1bWwxEHclEpgsQnRjAMZGrMWAwlAapyO/AgjZWzNQLVWrBoIw==
X-Received: by 2002:a5d:5f46:0:b0:3a5:2d42:aa17 with SMTP id ffacd0b85a97d-3b60e5127efmr20108404f8f.31.1753178718150;
        Tue, 22 Jul 2025 03:05:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bce4:725d:6922:d1ba? ([2a01:e0a:3d9:2080:bce4:725d:6922:d1ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa7072sm6012611f8f.2.2025.07.22.03.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:05:17 -0700 (PDT)
Message-ID: <6692f1e4-978e-4138-9d76-ac2b80613a65@linaro.org>
Date: Tue, 22 Jul 2025 12:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] arm64: dts: amlogic: c3: Add tempsensor controller
 node
To: xianwei.zhao@amlogic.com, Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Liming Xue <liming.xue@amlogic.com>
References: <20250718-c3-thermal-v1-0-674f9a991690@amlogic.com>
 <20250718-c3-thermal-v1-3-674f9a991690@amlogic.com>
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
In-Reply-To: <20250718-c3-thermal-v1-3-674f9a991690@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2025 08:37, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add the Tempsensor controller node for C3 SoC family.
> 
> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> index cb9ea3ca6ee0..c853390eca6c 100644
> --- a/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/amlogic-c3.dtsi
> @@ -727,6 +727,17 @@ clkc_pll: clock-controller@8000 {
>   					      "fix";
>   			};
>   
> +			temperature-sensor@20000 {
> +				compatible = "amlogic,c3-cpu-thermal";
> +				reg = <0x0 0x20000 0x0 0x50>;
> +				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&clkc_periphs CLKID_TS>;
> +				assigned-clocks = <&clkc_periphs CLKID_TS>;
> +				assigned-clock-rates = <500000>;
> +				amlogic,ao-secure = <&sec_ao>;
> +				#thermal-sensor-cells = <0>;
> +			};
> +
>   			eth_phy: mdio-multiplexer@28000 {
>   				compatible = "amlogic,g12a-mdio-mux";
>   				reg = <0x0 0x28000 0x0 0xa4>;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

