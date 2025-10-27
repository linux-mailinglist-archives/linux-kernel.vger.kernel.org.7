Return-Path: <linux-kernel+bounces-871908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4397C0ECC1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79DD9424ECE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E3230AAA9;
	Mon, 27 Oct 2025 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="osLnZf5y"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05C22EC096
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577169; cv=none; b=RfUpl/tPoFrMp8W8DRVTAmlYI3wQpfGY1CLy1ngCKkMICG2FFhmwFNj6aFoiw7Q3ml/cjrNoPhcx4xpwya23opjRiKyRUi1OZ9jAsP+O9FguBkbolNgdFwXHWD+b2ZJwN71TokEMTsvTrGJ4wEKED6YxI23AksagttxIFs5Jpbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577169; c=relaxed/simple;
	bh=dsIofV2hg8J/vd9r6puEBMQ1q589TPT1cMJ02OTgt8U=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D/QWrEpyLoDVTG0kCdJer1sJkA6EV5UybNAUnqiHF4aLwjVCPWHXz2Sj1/T8kVI1shNDN7GcQMe53v8W3eBIBIc0qPq560VLqOmytinuij42726i1Plq/j16P3sQO6NoYvg0TgEysjXWCFHNy0t7j4kNbRkkyumfsrXnYux6RQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=osLnZf5y; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso13067055e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577165; x=1762181965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=laKL0Cr/PvBcX2XD9BKXgno90RHOh9IUPRrWnIXmsZ8=;
        b=osLnZf5yWEDLCq86m0xSYnEwPYXL9Ba2h5fXLTTG+ySWdYwqtfuO6fVHz/nkzhfa+r
         Db+8ahyQpu9jdT56LkNJC4vLBaGTf+Rs4O2MkiqQjbH1dRWG3GFa1j+gpKJrU2q2Phxl
         HM1zBVIOreyB0mxjU2a8XY5mF9sE+VZQXK2gydd2iSTVydy9auHgH4OudNMK0z316+Yf
         okf6PdtsDMOs33tDI73iAL93UKRwl/VkrKGRYDT/HTxCORFH+SIuf2Ed8Ut4MBEIyL/A
         W44CEt3fqrz5dXXyAiDD2R9nckRn82QwEhxYTqcEvRI0Vla3LcoyegZirQG2d1oLGpBY
         v+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577165; x=1762181965;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=laKL0Cr/PvBcX2XD9BKXgno90RHOh9IUPRrWnIXmsZ8=;
        b=MfIGBGjkdnmhn29t6O86HlskG7cD+OqVyqcE6vq+FCuuaB1/fXd8cuIxly0sQENY1h
         2Z4KXO3OqXZjm8tr17g5O0gOVheOtTffdkYYDTgXRiZOsUoH8cEE9i9rFolWMoQ5Ud6D
         yTTI25UwNzdC/7BmdaSCzPgwt6w/u4u/slJk8m8LsklzfIV2SKl+kVB+Eu4jG4TaUNGv
         C4Yg3gLtlVW7PUDHrGRg1VkOgWvd7/okW1PCe3MWCFB5ghKblOMIAF6jX0M6kpPX9vpQ
         4bvK52cg/XDNE9pUlQ25ITeHLqYsZfID1AiEPHTcN/H3LeaIb5HOL251chxxeWnBKq24
         tQUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtlQMQVogoHlH+daGEu74OIEsAAHcwGm0sZXhumqeFenNkbxOl9Mb1Jhfg6cprtiuDQkAynOV8NIwtaJs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeXiGL3wh65x8x5MwKUD292WP0QS5RLWIro2NAo+gxLyYz87y
	KUauBC0AxEZU6SqRkSJyEprNyS/2qcAFKx/6Nvmu1IB9bLN4KjFr6swFXc8+YW4+prw=
X-Gm-Gg: ASbGnctPN3yz/3Kbe7gxZEbLXgs/Y+57cbSVXvM2ghby7CHiSczesBJDPYp8v98nr0e
	ivCaFhXvkeQiet53yekAMX89rN/a/8vjY/YoxdLV3bV6h3zQ1ju8AxYsgcZLOFHy9mtDjXkW/AT
	ZHc3BKhlLxCsk/1JuMyDwDQc1blZZGRguDZxeO0m8r9Z0tIbL191o0XErCKl8fm+plJDRvaYP0j
	Q44dQFSnapuVR6GwfxUEEmjLPh+GV6H9WRp8QGwZrwhniLzEzyWim16g78Nl+Xo22TQDF317YwD
	AYaZ8GLAlgbnY0d48xPcIJ4IAxCMilVu24HTRq1xPW9LSOsLHDxh7/rCg7D279ORQ15WxqjmA1y
	eAGn/V/QNq9ObWILnwckQwm48oDWoj/qylVmBt+i/jXelUJI/EoF3yuoKr2wyRRxYgwe9HwwN5r
	TUiEZ14Egff+/Hd6IAUyfgH/0Roa3e6+NN8ijomkHkIspC0WFE9Ec0VMiJpIG1
X-Google-Smtp-Source: AGHT+IElF8SC2vVdQK/QFZgy2NHu5E0/X0JUE+sv3DRcp+JfPQbQgA4erKf68h2HmmDBO0TizuxmTw==
X-Received: by 2002:a05:600d:41d0:b0:45b:47e1:ef6d with SMTP id 5b1f17b1804b1-4711792590bmr289777715e9.36.1761577165046;
        Mon, 27 Oct 2025 07:59:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:9a4:ec5a:4022:b507? ([2a01:e0a:cad:2140:9a4:ec5a:4022:b507])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47794asm158313935e9.1.2025.10.27.07.59.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 07:59:24 -0700 (PDT)
Message-ID: <4a22b05d-24f8-44dc-affa-5cc28201fb53@linaro.org>
Date: Mon, 27 Oct 2025 15:59:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC 0/3] Input: add initial support for Goodix GTX8
 touchscreen ICs
To: Jens Reidel <adrian@mainlining.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hans de Goede <hansg@kernel.org>,
 Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@mainlining.org,
 phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20250918-gtx8-v1-0-cba879c84775@mainlining.org>
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
In-Reply-To: <20250918-gtx8-v1-0-cba879c84775@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 9/18/25 16:02, Jens Reidel wrote:
> These ICs support SPI and I2C interfaces, up to 10 finger touch, stylus
> and gesture events.
> 
> This driver is derived from the Goodix gtx8_driver_linux available at
> [1] and only supports the GT9886 and GT9896 ICs present in the Xiaomi
> Mi 9T and Xiaomi Redmi Note 10 Pro smartphones.
> 
> The current implementation only supports Normandy and Yellowstone type
> ICs, aka only GT9886 and GT9896. It is also limited to I2C only, since I
> don't have a device with GTX8 over SPI at hand. Adding support for SPI
> should be fairly easy in the future, since the code uses a regmap.

You didn't explain why you didn't integrate with goodix_berlin or at least
try to reuse part of the code.

Neil

> 
> Support for advanced features like:
> - Firmware updates
> - Stylus events
> - Gesture events
> - Nanjing IC support
> is not included in current version.
> 
> The current support requires a previously flashed firmware to be
> present.
> 
> As I did not have access to datasheets for these ICs, I extracted the
> addresses from a couple of config files using a small tool [2]. The
> addresses are identical for the same IC families in all configs I
> observed, however not all of them make sense and I stubbed out firmware
> request support due to this.
> 
> [1] https://github.com/goodix/gtx8_driver_linux
> [2] https://github.com/sm7150-mainline/goodix-cfg-bin
> 
> Signed-off-by: Jens Reidel <adrian@mainlining.org>
> ---
> Jens Reidel (3):
>        dt-bindings: input: document Goodix GTX8 Touchscreen ICs
>        Input: add support for Goodix GTX8 Touchscreen ICs
>        MAINTAINERS: add an entry for Goodix GTX8 Touchscreen driver
> 
>   .../bindings/input/touchscreen/goodix,gt9886.yaml  |  71 +++
>   MAINTAINERS                                        |   7 +
>   drivers/input/touchscreen/Kconfig                  |  15 +
>   drivers/input/touchscreen/Makefile                 |   1 +
>   drivers/input/touchscreen/goodix_gtx8.c            | 562 +++++++++++++++++++++
>   drivers/input/touchscreen/goodix_gtx8.h            | 137 +++++
>   6 files changed, 793 insertions(+)
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250918-gtx8-59a50ccd78a5
> 
> Best regards,


