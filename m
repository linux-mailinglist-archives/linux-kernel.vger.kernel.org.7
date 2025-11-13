Return-Path: <linux-kernel+bounces-899123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 372F0C56D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 54129351D20
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C482329C45;
	Thu, 13 Nov 2025 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dpl7fpkX"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6579B320CAE
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029599; cv=none; b=BXzy9Gf/F2zuMLNs+GAGM9+39HZK/nRMrLMwPh9+Q1WmTXbg5xeQwUg+tUxtYyIREKqEtL4A6emoF4OF5lzNwacK3aQ7ONEyvOPWXeInbmkLUtDk3z0vv+52IV/XRAybFXc62tjf679ok6JqbrneTrGf7s+pV3w3Iu2ShQ3Q1js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029599; c=relaxed/simple;
	bh=ZCFF04RJ9CJCCxVRA1yz9U8VC4BnDMiI7a/ozJ4Gsyw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=brv2xS8gqY65/xFmv/GWQWne33LKkgNjTWTUAxvfPfP5pKxC+bOcFiOdasQSX2zyXyWb/xVLhtgI7KLHZHSd6L3RqhbS4E+AWlhwwp6nybbFh7YADNJPWScyl1sJvQowpCB9LAMfMEQIBY3WmfF+9be2btUXwTj0cnJ1GEw+XRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dpl7fpkX; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so415181f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763029596; x=1763634396; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v8GhrcAyMh3A+V43CTkvvT8Jy87HXinsSZJMcVDG3s0=;
        b=Dpl7fpkXF0gkobSFHf7scS5hTiYA3Phb2KISMxQhISZdJwWqpX4PR5Y5rcSmmfMLo+
         l6HO1l4GiuSmzym5hv+H7QXd362GlKGj/AP/N/TGPD/crZYyIvzvZ/1am8Cu0NyWlwUg
         7k/xgszsuJKLy55vRK0M0WIe/eUbtbCsRNC8BC/GB3Wsd28mWqtisUeKPFNQ60lprpce
         xHK1RtURMlL+ZJb+SWH5vfrA8ts2Dhj2pho/SNvLW+Jdz9Yoeab4hC5InmXnqJFqbCRS
         XHw7BJl4RADFY3sm4ldIjewGF3OdMFfdcdcAcbnSQu+onp8G9brFGBrMFwyEKdecIl5q
         Wbzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029596; x=1763634396;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v8GhrcAyMh3A+V43CTkvvT8Jy87HXinsSZJMcVDG3s0=;
        b=cWaqnIZRLJ13AAI41VAPN/ryv5C1GUqHLs6R0f5jDDwQdGnsttvwmIy5qLwc6II1Ij
         iNfm0Dr2IC2v6r782dJ7N+UxIjpB/szhRSUjG/Gi+o2LsQPuV5KyMuinbc6R3nlJ2FcD
         og9sNus3L9Sct21pa5qR0QuNwKiJuZanuqzrCScwBQwE4hrRlkJgnXE5E1mARHeMUmE1
         RF81pvIn9rsgJOP6gNCt+AXa/92HGq9XMMPT8ZRkDAsBtEhKmA0NcZDFc2E61qgHfZwx
         RH73jsVLAUvNN0iBQRZ03tEYM9c85flDmnmR/ytWKSt5yZWcRAPMy6mD4qns4avzPVtF
         5Z1A==
X-Forwarded-Encrypted: i=1; AJvYcCVGXOUdnZWRhGTf0ANa3bFe04k1+F6qAD3lAwMiSPlKJBzn8tLqQ3V1rp4B0Y8m3jNE5++Fbtadaa1RyIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNoM1z1NtIZcC3aLxzhYNGEiiaMT/9zcN5t9xfQ7pdRqitznEG
	1t51OcFYNnd6+Aa0am9Pdv0WA5Hshz8qBVxkaqWj/yVH1+aaGDESjy8fALy0XleFG7M=
X-Gm-Gg: ASbGncsP003DQK8bAl4mFFdM7lCR5FLJFgZfcDJdD8c9PEvG3vdIeGCuR3BrDtW9FLC
	CzhdRAkvK7vBANnx6BswKotialka0IEn47EndD6/x2I1pdPAlQUt0gNd4zZsthmoZcl8mM0H1+f
	byLj5gElCkGjfkDnchY05SEq+CuP3SfBblIjj6PRzBjDB3HloxdWkqXir1Pem88ARYUxOmd7N7E
	vTc8ItZwl3CjJnABtpmHR0qffEKdzVhnRzq7tZty75D7vq6wJtCCGmoqrAuMRXlFjc4UdsgEgkf
	tHOW0E7XV7pkIIJJL7O8ujs9i51bzYJEPywWwUdIa7X13AAmJ07tYjN13YES9+o/wBS0GV0Y3Zz
	dWgR0hWPbNqqrAphhifUyjQJBgfpY4Ynx5PCfP41ATCyy1xy+g60TcPdWKj2Bj4xyXfEf4AjY/K
	njFhyqVg==
X-Google-Smtp-Source: AGHT+IFappH0cJvSx4iLsRJxGuedr9FOAfOnQi4qZr3vNlHJHTAAZOTa3M8ohns19ObiXS0otCFe/Q==
X-Received: by 2002:a5d:5848:0:b0:42b:3dfb:6436 with SMTP id ffacd0b85a97d-42b4bdaeacbmr6137389f8f.60.1763029595613;
        Thu, 13 Nov 2025 02:26:35 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b57asm3088931f8f.27.2025.11.13.02.26.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:26:35 -0800 (PST)
Message-ID: <62bb6c08-a1d0-4dba-a431-0d6ce49d66b2@linaro.org>
Date: Thu, 13 Nov 2025 12:26:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] nvmem: add Samsung Exynos OTP support
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 semen.protsenko@linaro.org, willmcvicker@google.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251112-gs101-otp-v2-0-bff2eb020c95@linaro.org>
 <20251112-gs101-otp-v2-2-bff2eb020c95@linaro.org>
 <20251113-benign-macaw-of-development-dbd1f8@kuoka>
 <9d77461c-4487-4719-98db-1c5c5025c87e@linaro.org>
 <725ea727-d488-40aa-b36d-04d6d44a8ec5@kernel.org>
 <1af37451-1f66-4b6b-8b36-846cbd2ca1e8@linaro.org>
Content-Language: en-US
In-Reply-To: <1af37451-1f66-4b6b-8b36-846cbd2ca1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 11:51 AM, Tudor Ambarus wrote:
> 
> 
> On 11/13/25 11:35 AM, Krzysztof Kozlowski wrote:
>> On 13/11/2025 10:28, Tudor Ambarus wrote:
>>>
>>>
>>> On 11/13/25 10:30 AM, Krzysztof Kozlowski wrote:
>>>> On Wed, Nov 12, 2025 at 08:29:06AM +0000, Tudor Ambarus wrote:
>>>>> Add initial support for the Samsung Exynos OTP controller. Read the
>>>>> product and chip IDs from the OTP controller registers space and
>>>>> register the SoC info to the SoC interface.
>>>>>
>>>>> The driver can be extended to empower the controller become nvmem
>>>>> provider. This is not in the scope of this patch because it seems the
>>>>> OTP memory space is not yet used by any consumer, even downstream.
>>>>
>>>> Quick look tells me you just duplicated existing Samsung ChipID driver.
>>>> Even actual product ID registers and masks are the same, with one
>>>> difference - you read CHIPID3... which is the same as in newer Exynos,
>>>> e.g. Exynos8895.
>>>
>>> Yes, that's correct. It's very similar with the Samsung ChipID driver.
>>>
>>>>
>>>> What is exactly the point of having this as separate driver? I think
>>>
>>> The difference is that for gs101 the chipid info is part of the OTP
>>> registers. GS101 OTP has a clock, an interrupt line, a register space 
>>> (that contains product and chip ID, TMU data, ASV, etc) and a 32Kbit
>>> memory space that can be read/program/locked with specific commands.
>>>
>>> The ChipID driver handles older exynos platforms that have a dedicated
>>> chipid device that references a SFR register space to get the product
>>> and chip ID. On GS101 (but also for e850 and autov9 I assume) the
>>> "ChipID block" is just an abstraction, it's not a physical device. The
>>> ChipID info is from OTP. When the power-on sequence progresses, the OTP
>>> chipid values are loaded to the OTP registers. We need the OTP clock to
>>> be on in order to read them. So GS101 has an OTP device that also happens
>>> to have chip ID info.
>>>
>>> For now I just got the chipid info and registered it to the SoC interface
>>> (which is very similar to that the exynos-chipid driver does), but this
>>> driver can be extended to export both its memory space and register space
>>
>>
>> There is no code for that now and possibility of extension is not a
>> reason to duplicate yet.
>>
>>> as nvmem devices, if any consumer needs them. Downstream GS101 drivers
>>> seem to use just the chip id info and a dvfs version from the OTP
>>> registers. DVFS version is not going to be used upstream as we're defining
>>> the OPPs in DT. So I was not interested in extending the driver with nvmem
>>> provider support, because it seems we don't need it for GS101.
>>>
>>> Do the above justify the point of having a dedicated driver?
>> Only partially, I asked about driver. I did not spot previously the
>> clock, so we have two differences - CHIPID3 register and clock - right?
> 
> clock and interrupts, but I don't use the interrupts because I just need
> to read the OTP registers to get the chip id info.
> 
>> I wonder why Exynos8895 and others, which are already supported, do not
>> use CHIPID3, but nevertheless these two differences can be easily
>> integrated into existing driver.
> 
> they can be integrated, but I want to make sure we're making the best
> decision.
> 
>>>> this can easily be just customized chipid driver - with different
>>>> implementation of exynos_chipid_get_chipid_info().
>>>
>>> If the answer is no to my question above, how shall I model the device
>>> that binds to the existing exynos-chipid driver?
>> Just extend the existing driver.
>>
> So you mean I shall have something like that in DT:
> 
> +		chipid@10000000 {
> +			compatible = "google,gs101-chipid";
> +			reg = <0x10000000 0xf084>;
> +			clocks = <&cmu_misc CLK_GOUT_MISC_OTP_CON_TOP_PCLK>;
> +			interrupts = <GIC_SPI 752 IRQ_TYPE_LEVEL_HIGH 0>;
> +		};
> 
> Maybe remove the interrupts because I don't need them for reading OTP regs.
> 
> What happens in the maybe unlikely case we do want to add support for OTP
> for GS101? How will we describe that in DT?
> 

Ah, I guess you meant to keep the node as I described it in patch 3/5,
an efuse node with a google,gs101-otp compatible, that will bind to the
existing exynos-chipid driver. Then if/when we add OTP support, move
everything to a new OTP driver. That can work, yes. Unless I add some
OTP support now, to justify the new driver. Both shall be okay, right?

Thanks,
ta



