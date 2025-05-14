Return-Path: <linux-kernel+bounces-648103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47754AB71A6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 18:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C57A162ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC55927D791;
	Wed, 14 May 2025 16:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sW83iroB"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2617827E7FC
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747240732; cv=none; b=ExpXSfvP4AXtLTKPrGkiFjExKdqq6plXy1BdHd3pcJBGVJG1UNYsM0t+kye3oNboQ0umBDe/TI/O8Dd60fjuZl+cjM3//7vSxRpyFfhekGG9GF+d03+DgkT+dDO518Bb1dhDrDRfjYhlP/gD+iMZcbL4fEvFTi/EIpmlNxZgf6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747240732; c=relaxed/simple;
	bh=dXpnZ6HRybe9ZHnb0gl+9DoZpwf4gIs/LTIwEUxBnN8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ulbuw6Kd9IzjzyVM6tP5UHn2dJzDdFfPyAOvlWkZ1eG2Fgy8GfT+upm1d0EQDYzbMkKJEES91EH3zAP+8NKvR96XgWqWJ2e56c6B15oHiqgjjfKrxLUXVSXv5h+PgLv+J4M6az2dUP07ZalTmRIiXPCR1vVbUmRyzcBmSPHP3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sW83iroB; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ccf0e1b3so163145e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 09:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747240728; x=1747845528; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dP5YcbeqpFYvCKe+8FnH1GIVDVz3AECYHXjeJJujU4=;
        b=sW83iroBO8TwjntS6U4g1IxbESl/D/U+yIzc7tCwt/esnNt5gAshkN4sFQESAg/lot
         b9LpVGGKMH3QYIel09Vb1W//cERBSDvzgxe3oz/u2+AS9uFY8Ydz7mMn2RWYEIPWLobp
         SeeKj2+MEREODg/0EeAiCDyGrdCvJW7zItqnLXlukzgBZunGCUsFGL8psYiacwcfawz9
         3T/efd6oE2Ay3or+cBzYyyuGMucbHxLgG1yuSejODhj5rtUTMkT9ojS6EjwLRkM7pZ1M
         xPnTAeVKjRqpZ3R4+dyyhBhkCrHF/WrwaPo14lYpD3qIkEgiDP9N/4Fq9iBGzZBMBiwa
         KS2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747240728; x=1747845528;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+dP5YcbeqpFYvCKe+8FnH1GIVDVz3AECYHXjeJJujU4=;
        b=tFEB4FMjUbnOMqVI1HPobepovvHHTXrf0y/EghYqxvpS9W7kY421X3wDSYuyEVsJnR
         eODsbaNQyP9HZJpHPh2iwsR+uForDyLiYhAip3Vjx4/HWgvNek7OyZhDSYiyJFlkTHj5
         iYwrAOXNBRfS2I8fK3gWcfEYGzn8uWK3O0lgH+vW0A8jFJqrFWsCacESRW8/GOjdgUe3
         IKo/HpdBJEhC/3bMU61EXtJwpWGTw07Tkly59GLAVLO/kdB2RWZo0TW0ZgSWzmvp1FWT
         gpm275w2hV3hxNGk6WRMPF+OPVMhGDte5M0OENLscM4aIh/7RSmpMk7U/J5pCVTQpUGg
         suQg==
X-Gm-Message-State: AOJu0YyEO22cpGmLnrotlxJx8coUHwloJhJhYSnHE9Vlv9Qige1AU/Rx
	hVwDh6Md++e/Qf4oUXGSyBjipfOtmUFt1Uqt+tC7T/GGo/O5Oo5748XAWbNZCpo=
X-Gm-Gg: ASbGncvBFPmimztM+lMhxMCZBYrt5ZFdnR2H1UfbZ68rk1HjRAc76xpkFmANvq9KxDl
	dTz6BXSESt3XpgGL8TdDt/aBwDGwfcRgJg90Es3PtgA22vnqLsRm5tkZ0ipu+9BqfQ8+e4Frfzb
	xXGGZeuTBQ1CsLorHASBWxAqm1S72vQUMoyreejswIbFtNMybyQ5oXyPuMO4m8w3F6kBKRcaX4V
	d0n7QDI1EptDnZJfGFN2qDMZR6XJ58T2OMq7mwH4hWgIBkILPdYtMoO8Lv/GVPYjwy0Rgpyo9Bs
	+1vDgnBr4X5Cm6oWH6uLK2581KvTrtWxDKl0FC0e72P48VLw0hVoib9YfhANRoMkeSjzAMdHWO1
	BlwGYowBX8eES
X-Google-Smtp-Source: AGHT+IEAkwKKEEQ70f0VyhVcMUc6RQxJdEmZDC90di0ICcfqr62LT/lvi+L8lcGRQvc66pK/aI2j2Q==
X-Received: by 2002:a05:600c:1385:b0:43d:b32:40aa with SMTP id 5b1f17b1804b1-442f20baa06mr44937335e9.3.1747240728450;
        Wed, 14 May 2025 09:38:48 -0700 (PDT)
Received: from [10.61.1.139] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c76dsm20425558f8f.92.2025.05.14.09.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 09:38:48 -0700 (PDT)
Message-ID: <8ba99df8-012b-4883-af6a-970dd9f877f6@linaro.org>
Date: Wed, 14 May 2025 18:38:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8775p: Remove max link speed
 property for PCIe EP
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 krishna.chundru@oss.qualcomm.com, quic_vbadigan@quicinc.com,
 quic_nayiluri@quicinc.com, quic_ramkri@quicinc.com,
 quic_nitegupt@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>
References: <20250514-update_phy-v2-0-d4f319221474@quicinc.com>
 <20250514-update_phy-v2-2-d4f319221474@quicinc.com>
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
In-Reply-To: <20250514-update_phy-v2-2-d4f319221474@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/05/2025 13:37, Mrinmay Sarkar wrote:
> From: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> 
> The maximum link speed was previously restricted to Gen3 due to the
> absence of Gen4 equalization support in the driver.
> 
> Add change to remove max link speed property, Since Gen4 equalization
> support has already been added into the driver.

Which driver, PHY or Controller ? does this change depends on the patch 1 PHY settings update ?

> 
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sa8775p.dtsi | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> index 5bd0c03476b143444543c68cd1c1d475c3302555..b001e9a30e863d8964219c8bd61bc328be71b256 100644
> --- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
> @@ -6462,7 +6462,6 @@ pcie0_ep: pcie-ep@1c00000 {
>   		power-domains = <&gcc PCIE_0_GDSC>;
>   		phys = <&pcie0_phy>;
>   		phy-names = "pciephy";
> -		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
>   		num-lanes = <2>;
>   		linux,pci-domain = <0>;
>   
> @@ -6620,7 +6619,6 @@ pcie1_ep: pcie-ep@1c10000 {
>   		power-domains = <&gcc PCIE_1_GDSC>;
>   		phys = <&pcie1_phy>;
>   		phy-names = "pciephy";
> -		max-link-speed = <3>; /* FIXME: Limiting the Gen speed due to stability issues */
>   		num-lanes = <4>;
>   		linux,pci-domain = <1>;
>   
> 


