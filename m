Return-Path: <linux-kernel+bounces-702152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818ECAE7EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 12:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE6B1705FF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 10:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22DB29E0EB;
	Wed, 25 Jun 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUJ8xRxC"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652B2BCF7F
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750846136; cv=none; b=qQbOV+dWmkW4NT5tWdCTUwXeeZPeJlhc+/mMcVsSXSTr9ZvqX/YwX+RCNYS2qzJuBMeOMh2KyVACLmChSXRLmiMkFJDlElmVuKiSGpTTxRw2ezeYFjkZar6pwJNXEzQqyFZLqM3pZErBCOOgrH5ejRcQQICIkzDygAvqDRTJTwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750846136; c=relaxed/simple;
	bh=mibwjvXWkICAj+vwkb1PpjhKmioX5JKsmZ6lo8UyaBs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=DBbT+JooqtOn4teMcv70AdPjpGED4bx2V7IAisTgnbHpXV2zg7MiS5gqVxgWssjxdrsRmoOKZEwfqdkZxY9gzrbk8J1Beds1MVD1JbRY/h7C7uLTIVu8KsstilhpGEn4keNaIsCErTwizsp1wgsdfIbxvV9mYMdPNa8AUKdS1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XUJ8xRxC; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-453608ed113so56109315e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 03:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750846132; x=1751450932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2a8kk6PcZkE03rGmBEJWejxQtEjJ7yXfgEnoE7M2mA=;
        b=XUJ8xRxCTAvOqsfssmT7WH+ikFnFRqDhsSZsQmbGiDkNl3rJkLU4VZ7dPHhZmkA7NV
         Ma0URgGv+6/HueM7M302frj3Li2nKOqrP2gds512MyhdWnbNCO4aEDolTA4HdxzYIfNq
         09OJ27d/AiJ/Dd/UOKx5xB6e/SuNeHfE1w0/ChIx6ojIGvm/eu26sCe5HJWb9tlW5XqZ
         toguA6D9Zq9GG4hS0a0qLLfs9yqWH7Nw1q5ijtHdO/QRiAiRGzQ1ebBQczMBLGc4GUT3
         nqL5TiSujTRleoZcA4UOcz+glKIBH/8xY6S4PhUTLbEWGdWmZcBlDksGcDhIIWrgQELD
         znsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750846132; x=1751450932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J2a8kk6PcZkE03rGmBEJWejxQtEjJ7yXfgEnoE7M2mA=;
        b=Oih2QTDH/rtiYAMT/Eh1WThxZA2P/PqqVI9oK7e13GA+bXcvhseME6rvV/dfq+lcb/
         rJtPviqAjEHCdEp1GM3jhCmpCuYqg2LpNIsBdnbI975n2ccdO7o1Sx5u/TyBjAxDXifM
         aqOrHK9AhdC+2ez4MrolWXZRVIvMNsGBsm7pXRrqiAgnOtj25LlfDLgY1sf5oQUVeJS3
         zTFUghQDsxvY26B/H0rsVRxPLiCRxEzbcOD0HQ2SoGqiyMaJk8Cw2HLH0ihbx3FNNZfc
         aRStVH1eVJ6FMSFx5znsIZtZSK3hwCPHJkBGjrE1jzH2u8jYoKgCsHpaPlyiIqEx90qH
         3NiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpTI8H4HYkhvl/dc42LA17aatI5ITQm1aanLu7ung08pABEuSDn0hDz5nL3PD0CSBG2+rdeAvnXq4mn08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnjV8y0ebF/aQ8YZqptGA6oZfREoQ8Iv7R1Q/8dd6AGV/MgWrz
	hh3VQIuqWXEzlv5/bbdXfin41zCeQ48cWBAWkbWgvmvXHaJ6asZ6iS2H5SQdKHb/LJ4=
X-Gm-Gg: ASbGncu36ty5CLKjsqWgaETjfEFZzVi64lSJLpP1Chmru0mgPnebzp0dmHXQ3/cTgYc
	AsUEDsy/GiqDlv4uGcMgwMjuqhELx2oaLEX78H2osMj/4Hr7Wr1CEq8pf3mCUCx4d7v8xMejLMn
	1PsGiD2+OI1Ug+rWUHzEu57XPGIc0ferQh+CyoIVDePYjviBufw/LvWeAe6V4NHgU1WCGLhYSi9
	znT91tDP6ErTpbZETtCaNEjUbyk8SjDYoFrs4u8hWhXN90kiDvEaBOrwnlvAeJVKbWU2iZR+JuT
	c52acbaQPyi7ju9gLsXtQyUpjFaoyzzKpmkIPLRmMIyLDwM5d7DHRZc62WHX9erxtIu1wKuh6h8
	mUf3UUTYqPLOhdDyBHEuhX4V1rMrKh/7wCVdp
X-Google-Smtp-Source: AGHT+IFJiC0S9QOgaQ2ScQ4U+1EQS39LaD4dPukyAK+89YpzNHu/8nXo31VXa8/vKLOYfbh15deE2A==
X-Received: by 2002:a05:600c:154e:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-45381ae3576mr25646825e9.17.1750846132470;
        Wed, 25 Jun 2025 03:08:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:b3df:bee7:215:e1a4? ([2a01:e0a:3d9:2080:b3df:bee7:215:e1a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e8068fd0sm4309576f8f.38.2025.06.25.03.08.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 03:08:52 -0700 (PDT)
Message-ID: <d923b289-1e4b-4c7c-9bec-7d0c2cbf8b86@linaro.org>
Date: Wed, 25 Jun 2025 12:08:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/4] phy: qualcomm: phy-qcom-eusb2-repeater: Support
 tune-res-fsdif prop
To: Luca Weiss <luca.weiss@fairphone.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250625-sm7635-eusb-repeater-v1-0-19d85541eb4c@fairphone.com>
 <20250625-sm7635-eusb-repeater-v1-2-19d85541eb4c@fairphone.com>
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
In-Reply-To: <20250625-sm7635-eusb-repeater-v1-2-19d85541eb4c@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2025 11:14, Luca Weiss wrote:
> Support reading the FS Differential TX Output Resistance Tuning from
> devicetree and writing the register, as required on some boards.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> index d7493c2294ef23e37e484019a49ddf7b3d6a6a46..61594739e5b12706775622e1f76af6ad5d2d29bf 100644
> --- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> +++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
> @@ -136,6 +136,9 @@ static int eusb2_repeater_init(struct phy *phy)
>   	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &val))
>   		regmap_write(regmap, base + EUSB2_TUNE_IUSB2, val);
>   
> +	if (!of_property_read_u8(np, "qcom,tune-res-fsdif", &val))
> +		regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, val);
> +
>   	/* Wait for status OK */
>   	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, poll_val,
>   				       poll_val & RPTR_OK, 10, 5);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

