Return-Path: <linux-kernel+bounces-743794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34920B1036C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB011C84EF6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECF32749F4;
	Thu, 24 Jul 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGl/Eee1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4412749CF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345259; cv=none; b=gcOufNtIh+3ILvlwEMx78htVv4rcmAdrZyeVYlhksd906RBKJ2+VcN5bR1GzXiklIsCj9hgmK2Wj2FRUqbB/5VQ/OitNuA+badBe8cSawYQO8bJnnzY2MaeQEgtnPf6nxhvOpryFvCvisvrx8+Jzjt/rhFRhSr9vz8/ilmYV9Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345259; c=relaxed/simple;
	bh=gEpeomgBJz7dPXlwhD8ZqTisu/lE6eJjZrvqZUUAtck=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ab1mYbJhsDRZrKXYd/vREMVYHSuv7yhiBfGsUqktc35llJr/1pzmKlOYbRwKz4XPxpYvj/g9oet79JtXzmPj3C/5KnB4utIr3cKqMz89Txrvhe87/HR121ihSuV/Tm0tcR4pAd50r7UQX+Le2E9Vq436EQMzPdxvhMYBdCjgZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YGl/Eee1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455b00283a5so4132725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753345256; x=1753950056; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=llqwfCBH/rOpSuEI1LSG4OQG1ctPOqLKtO/RbPasBQw=;
        b=YGl/Eee1spnaFvBub77bmbbFIrYSzqVwE8Q7FhJ9IbAr/CEZhaf5D9sSWVXmNrXUKa
         fB/J6NBodVeTT8AJl+sl5kjGR6JHyKvagDrQ/5EYoPjM6zDIJLCxzgEh/tUwKyawuvFQ
         NyFhYnn87CICGGYrPR7oKIk7xn/bDLr2T+y98Pl14/JCOd8qEuwgvM3GNOvRhthAYngc
         bX4qUllHWxzAhx1AxzUJHgpwYADMSRYoNs2PSV8DjMqa28ODqUveb8kwzlq8w/MUb6ll
         H61hUCqpz0/XZ5y/qWPraqQN/hhhcIOseWI8f2GeFn7qiLfnp5t79m692Te5V65c6hWY
         HKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345256; x=1753950056;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=llqwfCBH/rOpSuEI1LSG4OQG1ctPOqLKtO/RbPasBQw=;
        b=jYX/GJ4FZdIwzgMpQZNdPGTJLBxuXgQfIOlKSsHA5npKVJctHbM5PFDwxt0rCIHKwz
         MQ/qfnR3dOr9KyqMcojjWekbdf9vDzZU8epTXfEWL9mnQ8EatF5Oo5R8SylU9CmU6yqZ
         ax8Fx/9kmR6r8Gw7NXYiT68GoGCAjDAw89vMEgCKuvSwfAZtVdRFXn/C80Am2bKDUdl5
         8/nB+ycLRo3hc6pe1Pae/4qvhJI2rF/DtfW/f5DapjyuItFDESCV0T1L6gQL/IEwFC7i
         hOAuTm3gVpYGK02dKtUaZve0T4e37a8jbmuIyArMqJn7yDzOhW1QtpSIvkXMZVSLy+SD
         +DfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV50e+gJ2CiB7RgA+wFixrw9QB25PbP+DqYnXZ74qYtDmg/QXkbCuW1IE8Fvht09tI2EY3qu/nV2im3qlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7/pDPiOz48+EqmP1RvTM5vpoH0RT39CS3a0LXlmoLgKA0fNGp
	/ww6esxOCfj31O3WLrwdkYlChEWf1Ws9y2hz2GjMNTpA/dbqkxUraqgzgyKNhp/t8bk=
X-Gm-Gg: ASbGncvMMuBlMBn6Zo0ovOgJMyBqo/ZKC3qqPfPaftbCOpu7NS0Q2rgyK0IFWhef+Ed
	cqp3EFhi0PzQaPOvoqoeSydDAYvKabLYjLxhgAYyNtPkYS8XRMtkSskryWelH9ZGURIzZ6Lapty
	+RoAPFZBuWjTBSB0fwogbij5QeaP6yTTBdJMqdqOPyK7McUBL9ssrAfgiNojTYrs7xodx8rzVRR
	04XetfsAJ+xHgn6bGvM+6SpUy0EF7sEnTp1n0MjEnwDlPvrL7KVAboEqjaJ0f7/BI9vUwl2Gt1c
	y3ZP1dWrRZi8oW1Q/9A3qMaW5jTtTfqwpe0dcpB0xBdv8tP6Clr4KlClWpVuNz/3ecqDD7XfCVH
	EdOmG9M3Vs6bo71PmGh1KBnYXHpsokqyX
X-Google-Smtp-Source: AGHT+IH5+0vhACN4BLyT/2/N2LzEwkUNdrpvA250ZFmSyIiC12TjUMW4rdL6PBFGZFpbMyKBwN81zg==
X-Received: by 2002:a05:6000:1a8c:b0:3b5:f168:5e60 with SMTP id ffacd0b85a97d-3b768ee098emr4827297f8f.19.1753345256311;
        Thu, 24 Jul 2025 01:20:56 -0700 (PDT)
Received: from [172.20.10.3] ([78.246.240.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b77078e537sm1141636f8f.12.2025.07.24.01.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 01:20:56 -0700 (PDT)
Message-ID: <cc8a805a-2bb7-4fb5-8e53-59b44caf8438@linaro.org>
Date: Thu, 24 Jul 2025 10:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 23/23] arm64: dts: qcom: sm8650: add sound prefix for wsa2
To: srinivas.kandagatla@oss.qualcomm.com, andersson@kernel.org,
 konradybcio@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250723222737.35561-1-srinivas.kandagatla@oss.qualcomm.com>
 <20250723222737.35561-24-srinivas.kandagatla@oss.qualcomm.com>
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
In-Reply-To: <20250723222737.35561-24-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/07/2025 00:27, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> WSA and WSA2 are two instances of WSA codec macro, this can lead
> dupicate dapm widgets and mixers resulting in failing to probe

duplicate

> soundcard if both of these instances are part of the dai-link.
> 
> Correct way to address this is to add sound-name-prefix to WSA2
> instances to avoid such confilcting mixers and dapm widgets.

conflicting

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> ---
>   arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> index 5212000bf34c..8b43ded297c8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
> @@ -4526,6 +4526,7 @@ lpass_wsa2macro: codec@6aa0000 {
>   			#clock-cells = <0>;
>   			clock-output-names = "wsa2-mclk";
>   			#sound-dai-cells = <1>;
> +			sound-name-prefix = "WSA2";
>   		};
>   
>   		swr3: soundwire@6ab0000 {

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

