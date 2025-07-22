Return-Path: <linux-kernel+bounces-740624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F7B0D6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB886C49A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BB2E2660;
	Tue, 22 Jul 2025 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caYdDcHz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849552E1C4E
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178677; cv=none; b=AFoOReIdyCk/BEGNscgH0y9hm+CxRd8a+L5aTTPaOPRlzVjbpeo/hYPquS9lxY4fIkuKbKN1VKCZKGLKWtsyrMHAvOQnOMqWzI48pXXdtI2yEdGL6ExJfUoJztBxkOWxxuFR3zT+3JB7/aWsosoAeafobn0memMbgrmEHBPKwsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178677; c=relaxed/simple;
	bh=cbUV/aoxPgUWCJZMY6VxKNUjXQckwm3iK0y+j5W/5Ho=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P0pT/oaJZBriPq/G1TMN+/yPgEsSZ4uFWjUIfW3In0b747xj6FkjTC/fqvz1ALwzmWhkeW8fA+MYuT74cQ3Knl2oOylCKXlXCSz5nA5ro9Nm+awK2c2HHfMx+rBDenSVOoCoJs0KxvjbKZYhwiOSG7fDuDFd8TnAbMsoQ7kX5qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caYdDcHz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4561ca74829so58264775e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753178674; x=1753783474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=th8LkjBfkv7nYvFuNNGaT8FWdqcCdRHWy+pWo6pVRT4=;
        b=caYdDcHz735mhJEx22QLAABDbV4/r2dcFCKK1RCBzAPqTIgOP/PsyIzQJcU4HAT6qd
         tVZ9lP5k0h6QxWDS3jBp5xvqtTzFoNhliGVwR55BD4W6Ram5ZrUzRT71OUEC0o95LHv4
         UDhXi7n+JHYNtJJ2MNcF6RRi5qCqWSwAyo+sQ+AxcBb41AUiXNaTddejXxSiZWMaK1Kh
         SBgr9Rhn3rfMqWhVsTyVOqUN52ebvb/XSDe5FBV4JTcC8MvhiGCG5F/ow479il9w5xJ9
         SiEsKtxZ3elbY6gaPqgqZ8xygOubn2Atwcr/Ot1YBx1e4Y1eS882vTWFp1iZpTu+K8sY
         6pcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753178674; x=1753783474;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=th8LkjBfkv7nYvFuNNGaT8FWdqcCdRHWy+pWo6pVRT4=;
        b=luqxjJyGkSxt/5jazbysYO6T+5ivOovf8TWOyJS0zqopVQlsWRp0xhcDefMF2NMA16
         zyYPBR3eRx9VW0FsyEpfeEaustyMHX2zT35dq6QfJmo7kzCGgIQgLNKb5c0WcnDEqbt1
         NQZNPSmvDpamgYsNEkyscvW9aLWQy+oqs/I+OgmY/jjI3XWdjjfG0fux7YCds8ImLduc
         ukKbwQ2JWc8iiGKRAeHEYzLsPAV7vfKcby6bmG23bdbUaeCi/8ghCo6zXVc2L9iUVose
         m4BYMUqVuS4FnAgg2SUHg4DnxfOD3I7TZeuCfb7mebBe12LHA34dUys6cDNnxhia2QzA
         OA2w==
X-Forwarded-Encrypted: i=1; AJvYcCUtjxhWY4LVKgvu4x+J8cFhhNwv7sUdcWR3Qrx+M8BBOEqmb1M0LC+FffmzFmFy2i737tb8YmuZ1VrVeUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVAIpnxj+RXJuiklabSYmUq/VcQXR6rsmfnyEDoQZhsLBrSIEk
	cVIkTmm220qnfUXr1DjLI6zRr2PDBj7vEby9yPogQrCJ6lsn3J4+/vqU14497Nz90cQ=
X-Gm-Gg: ASbGncu75WkQuu3YzbAmaOu21HVpOo6ZlReWN8mjmdLDXK4zDdCc6UW19gYzfp4z6dc
	CqyGow2m5DnVBd2DJCfELEldzKzNedb79NpBfWkGHMz6zS70D4j6uFZltxQXSVd0CtMONZHsooT
	/pWR42Z8j3P994miTHDuCKWUjEP2VVDhAvxASfMeiHaDMP1mgeq/THOp+ytaJ3PQ9CyDgL4FHM1
	9LSI1eSzISfI7AYMeyzYZODvjCMK5QHyztiFm+RR4jmZlYN1kKkyhtLQuA6hqxG6w/s2MpWZBeu
	tEu24utX1IDApvmN0nnhuDaipbbQ1ko19ILw3NmtUW2rEH8k/1hNV8AHI+egAOq4pTcenBf6KvL
	egb1sRGwJUnNiVYDs1SX8fWdgSFYYUEHYRdQTb4OA4zybLViKqqHlIaRQyOKtD3lQatQxHeZgCf
	Y=
X-Google-Smtp-Source: AGHT+IFejVtWV8JytlClgGlAbQ/sASXBqbtoY0roVwh48A/QZMJB/xCFqE4nYCMj0t7+saAYfB6ttw==
X-Received: by 2002:a05:600c:4688:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-4562e3cbb03mr196476655e9.33.1753178673594;
        Tue, 22 Jul 2025 03:04:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:bce4:725d:6922:d1ba? ([2a01:e0a:3d9:2080:bce4:725d:6922:d1ba])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f33f0sm184133915e9.2.2025.07.22.03.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 03:04:33 -0700 (PDT)
Message-ID: <942aa300-fc49-47e8-93b7-85fd1e1fd123@linaro.org>
Date: Tue, 22 Jul 2025 12:04:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/3] thermal: amlogic: Support C3 thermal controller
 driver
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
 <20250718-c3-thermal-v1-2-674f9a991690@amlogic.com>
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
In-Reply-To: <20250718-c3-thermal-v1-2-674f9a991690@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2025 08:37, Xianwei Zhao via B4 Relay wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add the thermal controller driver for the C3 SoC family.
> 
> The main difference compared to other Amlogic chips lies in the
> offset of the sec_ao base (referred to as u_efuse_off), which is
> handled differently. Everything else remains consistent.
> 
> Signed-off-by: Liming Xue <liming.xue@amlogic.com>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>   drivers/thermal/amlogic_thermal.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
> index 5448d772db12..d1b08119c818 100644
> --- a/drivers/thermal/amlogic_thermal.c
> +++ b/drivers/thermal/amlogic_thermal.c
> @@ -226,6 +226,12 @@ static const struct amlogic_thermal_data amlogic_thermal_a1_cpu_param = {
>   	.regmap_config = &amlogic_thermal_regmap_config_g12a,
>   };
>   
> +static const struct amlogic_thermal_data amlogic_thermal_c3_cpu_param = {
> +	.u_efuse_off = 0x108,
> +	.calibration_parameters = &amlogic_thermal_g12a,
> +	.regmap_config = &amlogic_thermal_regmap_config_g12a,
> +};
> +
>   static const struct of_device_id of_amlogic_thermal_match[] = {
>   	{
>   		.compatible = "amlogic,g12a-ddr-thermal",
> @@ -239,6 +245,10 @@ static const struct of_device_id of_amlogic_thermal_match[] = {
>   		.compatible = "amlogic,a1-cpu-thermal",
>   		.data = &amlogic_thermal_a1_cpu_param,
>   	},
> +	{
> +		.compatible = "amlogic,c3-cpu-thermal",
> +		.data = &amlogic_thermal_c3_cpu_param,
> +	},
>   	{ /* sentinel */ }
>   };
>   MODULE_DEVICE_TABLE(of, of_amlogic_thermal_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

