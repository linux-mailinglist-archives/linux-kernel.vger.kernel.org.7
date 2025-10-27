Return-Path: <linux-kernel+bounces-872294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C272C0FD66
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A4973419AA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50E3128DC;
	Mon, 27 Oct 2025 18:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRMh1we2"
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEE3128CF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761588265; cv=none; b=kYcF18OKGjzanRi3befbYC5IX5rvaKSvux4ddeC0GQfh68e09b3FAo7NKkZ0Ng7eLD1dDVBXJGmS5NOow5dfRJel9xTe2MrcYGU5jVtXlBDyc0Pw/rF/a/mspIqniDjZD+LExtuAPUK5SwgaSc5J5UVIIMI41yN3qE3SpwJoucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761588265; c=relaxed/simple;
	bh=6gWdTMfQ/SknYRion7bPpp9wf5wuCuXCY4S7nMleIbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cnt1xwrjULH9sHIGyrt9m4cTMY73D3kUeCwoH+O93OZ88BGDo45EDtHcoFhFRK9E40Gd4coJ40URTfmDK6UBNyF+FDpkik6+q0S9DQvIJuDl97hfP/RHf8chwarUHAYBA+fApCg8UEzCWa+HeFmgWOKyd83RIfaTOZuo0ggEBVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZRMh1we2; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5db469a92f7so1211514137.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588262; x=1762193062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gXv3hz0xqp/f7k2sKRT8AGUrr1BgpZqId67aBhRxKc=;
        b=ZRMh1we2uCRPWuz+8AHISTgGaBpgUmyKjdOtc7U/4gzMPYeZuxupmkcWrsVH4bwhk9
         FIuZc+twamwI/N7qvyPw+CSZ+BRuZ1HW0NhZHGQHTptwJ/Cub3GkevUisM6KE9s3pV4g
         y1eWqgLcOFMA+m4qyC5+9GKHxzJMyVUbcY7/GOyh1ms9wHYo/bGcMZVC0tRulpBngDYM
         SVLOFeTkt84czVrFF6aZj4eNonIlzmKF3mbjgH8xFdzgM+Z6z+GJu9AOGlQ3FFRYjV2W
         7Cn5RE3ZFHbLw2rfSG126iZvM2cgZUL8UB3ESbbtbjBwvZjqXi2C1ZwfnUZl1xPouS0k
         yCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588262; x=1762193062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7gXv3hz0xqp/f7k2sKRT8AGUrr1BgpZqId67aBhRxKc=;
        b=scgAhaTW+O0aCs3Co5yszArRcByplyhIurIpkVbjLshiq5x/3hYnA1R2i0xRE33sTM
         fgKKk6/Fwna/6RrgxzmP+t9kM1k0mKC8NrGNQkoY16FSAEVaue1MplC8N+8mj+Z6GOXy
         ukUuCRIGrvm3MR1aqT9RXjxNZ1USdDUBiLSNxXQYcpByKXLsi8lzoZQm9qzR3fNz5cc9
         TZrhMDHna8qxeXCQu0Xr3QeO2bRcMdt6GC9vDs4FJQsT/xxrsuob9rY5vBO18LouuXDE
         2raIT2xis0C0x8+QJt+a3UhtxCiiGl998cVwwzE3hF9gHjWfCCJkSCPMg2A/KWENNFNe
         +BUg==
X-Forwarded-Encrypted: i=1; AJvYcCVEMYeA+1cRiP6uI04k2MU4HHEuQ/sBmK661xOkkcoUzg/tW012WXRJbNHv9WHbStsXHr/cmiGVscYQcX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUCDAnV+t0F5lmIKJb0qtLEc2sVQcS+rP9YouC689MJc1FLMwk
	SpOe3xS2B26etjbbNIu014j6QyCd+OUNaEIk85Gr3zCOTZ1bP0+0+gga
X-Gm-Gg: ASbGncuwhZtKyjlnWd0YJsCs0vd/2FTJypvGbwIDSiJaR7S5E+4a31oPuzwsbi77/2Z
	8SgtOboF7mR70mhG+Mg9jR7ywczRyCbGK97PrVWnCmDS46aYu2GSQekEpy8oOvK9Y1JxTuApxlj
	as3jRafWfEzeiVddPH+5gUNKM66iDRUtQL9dxiKzhuv8smTCLruI8lZfD5wlTbmIFqs6o8Y/esi
	hzIEOY0LK2ZXLhP8rd+rlqFgki8AitxNcLzQVKulvOQcwie7OnzMHN6d6rMA8PxOSnHCTbuKyvD
	E0g5x8J6k22k45xaZPaH+33YSykdCyOK6KLWhuo82PYCAejH2bMDg55RSlrkGrW+VtFeVPFCp5H
	ijJTycc/Qi1qZQWUtJ/DpLupjVAGJCQld70q+Iwea24CWI+jyJrdyIIsUyvBHeYZLazppTMu2sR
	lSEKER8BkXr0i04eqSG+d8AIcE/EEUJOsAzCoevw==
X-Google-Smtp-Source: AGHT+IGfuNL47CB8BqWQlli2IWxIwUYM0B0XFQwY9e9lve8a3B49aif6vcJ8NDckDpi0OWKRSm19Xg==
X-Received: by 2002:a05:6102:f09:b0:5d5:f6ae:38c4 with SMTP id ada2fe7eead31-5db7cc4fd8cmr279495137.45.1761588260294;
        Mon, 27 Oct 2025 11:04:20 -0700 (PDT)
Received: from [192.168.1.145] ([104.203.11.126])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-934c404f64dsm3120082241.11.2025.10.27.11.04.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 11:04:19 -0700 (PDT)
Message-ID: <2efb85cb-5373-4da6-972b-8e79952cbc33@gmail.com>
Date: Mon, 27 Oct 2025 14:04:16 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt_bindings: sound: ti,pcm186x: convert to dtschema
To: Ranganath V N <vnranganath.20@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, khalid@kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20251026-dtbs-v2-1-cd3b713a288e@gmail.com>
Content-Language: en-US
From: David Hunter <david.hunter.linux@gmail.com>
In-Reply-To: <20251026-dtbs-v2-1-cd3b713a288e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/26/25 13:26, Ranganath V N wrote:
> convert the Texas Instruments PCM186x Universal audio ADC bindings to DT schema.
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>
> ---
> Convert the Texas Instruments PCM186x audio ADC bindings to DT schema.
> ---
> Changes in v2:
> - Fixes as per the reviews suggested for the v1.

It's better to list out the actual changes instead of only making
developers go to v1 to see which feedback you actually brought into
version 2. > - Link to v1:
https://lore.kernel.org/r/20251021-dtbs-v1-1-493c1aa253bc@gmail.com
> ---
>  .../devicetree/bindings/sound/pcm186x.txt          | 42 ---------------
>  .../devicetree/bindings/sound/ti,pcm186x.yaml      | 61 ++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 42 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/pcm186x.txt b/Documentation/devicetree/bindings/sound/pcm186x.txt
> deleted file mode 100644
> index 1087f4855980..000000000000
> --- a/Documentation/devicetree/bindings/sound/pcm186x.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Texas Instruments PCM186x Universal Audio ADC
> -
> -These devices support both I2C and SPI (configured with pin strapping
> -on the board).
> -
> -Required properties:
> -
> - - compatible : "ti,pcm1862",
> -                "ti,pcm1863",
> -                "ti,pcm1864",
> -                "ti,pcm1865"
> -
> - - reg : The I2C address of the device for I2C, the chip select
> -         number for SPI.
> -
> - - avdd-supply: Analog core power supply (3.3v)
> - - dvdd-supply: Digital core power supply
> - - iovdd-supply: Digital IO power supply
> -        See regulator/regulator.txt for more information
> -
> -CODEC input pins:
> - * VINL1
> - * VINR1
> - * VINL2
> - * VINR2
> - * VINL3
> - * VINR3
> - * VINL4
> - * VINR4
> -
> -The pins can be used in referring sound node's audio-routing property.
> -
> -Example:
> -
> -	pcm186x: audio-codec@4a {
> -		compatible = "ti,pcm1865";
> -		reg = <0x4a>;
> -
> -		avdd-supply = <&reg_3v3_analog>;
> -		dvdd-supply = <&reg_3v3>;
> -		iovdd-supply = <&reg_1v8>;
> -	};
> diff --git a/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
> new file mode 100644
> index 000000000000..306905eebd68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ti,pcm186x.yaml
> @@ -0,0 +1,61 @@
> +﻿# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ti,pcm186x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments PCM186x Universal Audio ADC
> +
> +maintainers:
> +  - Ranganath V N <vnranganath.20@gmail.com>
> +
> +description:
> +  The Texas Instruments PCM186x family are multi-channel audio ADCs
> +  that support both I2C and SPI control interfaces, selected by
> +  pin strapping. These devices include on-chip programmable gain
> +  amplifiers and support differential or single-ended analog inputs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,pcm1862
> +      - ti,pcm1863
> +      - ti,pcm1864
> +      - ti,pcm1865
> +
> +  reg:
> +    maxItems: 1
> +
> +  avdd-supply: true
> +
> +  dvdd-supply: true
> +
> +  iovdd-supply: true
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - avdd-supply
> +  - dvdd-supply
> +  - iovdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        audio-codec@4a {
> +            compatible = "ti,pcm1865";
> +            reg = <0x4a>;
> +
> +            avdd-supply = <&reg_3v3_analog>;
> +            dvdd-supply = <&reg_3v3>;
> +            iovdd-supply = <&reg_1v8>;
> +        };
> +    };
> 
> ---
> base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
> change-id: 20251021-dtbs-3a31f699c461
> 
> Best regards,


