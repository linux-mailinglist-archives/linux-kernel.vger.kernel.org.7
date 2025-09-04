Return-Path: <linux-kernel+bounces-801408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510EB444AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B91DA5A68C6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293EE31A564;
	Thu,  4 Sep 2025 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="AmP6AcG7"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D203126DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008167; cv=none; b=Y4W2w+USz5BH5woX0A7p6m5Err5EM9hanGwKjklu+OtTLHSXCbWLblhh05Su0jCPwzow8Ukdu0aFT9N6PlUGdlAxSSRA7/TJHhey5xlJy2U3ldHHsLBaOmhAMsQfALKy3CLkJ5K7JBCA8wS/sinzpgJcOfa31qvOydm0LtuPqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008167; c=relaxed/simple;
	bh=YwNRepnk0GFRdhlc/QTbxMz71IwoSOYVL7SZjUS5WVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRMldT5Y4fUE209yrcn3eQIazZD0ii/zGUX1pw7Wdxi0vIqMWnwgOSSbJyNMMaCzj5s6efYbjG96T3CwShSlL9r1dfH940iQe5fUYMcGL1HXZyl/6EBQDUIg2gp//JqCitXGHYIjIb0uoC6tbAdY5wMfCYdetl9g35Gvy+12PSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=AmP6AcG7; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-61e4c824615so580779eaf.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757008163; x=1757612963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Ku4I0S3yP4ilH2tbjLZ7dKmCGzXQqH2zGJl3FpJ6pk=;
        b=AmP6AcG7ZwAzGdBtncriwXevjwKuCoBd0vn1EMQcWY1JFAhtt7IGPXUZrMWqNqJDrT
         Wu0rvhO3+DRglGxjwxwHr0jLeEiK9JwaJvyRcK+7443/JatE77ECXrJPlfzcBQxF0Kbg
         0nuSkEno+5CTgpMYdmqozrs69wHSgjIgy1J72H2AB1stsPuprZH3bOK75/smLeajtU6H
         SGMFefwUl3jMx2d0/4dR92WmtGTZG2xR/cJKOC+JElRtuKi1AEKyTooCDUzPYhhdQ8Di
         Wwsyb3pEiFIrNZbDr4uIylPXPTDjQnWCTiD4UXLCCN/Uoftk1GkdZeG/o6RHpnF2JrYy
         vmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008163; x=1757612963;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ku4I0S3yP4ilH2tbjLZ7dKmCGzXQqH2zGJl3FpJ6pk=;
        b=qqVRDSDDiT2LQaYQW0Pi2MDNzm3YFiaGykQaNZ4yHJbZU9pkHArT98rSti+gKiY5Df
         XKQZB3aKLfl5Qw1Hn23djAUiUC8QF3EMZFHotqInXBhD3g7Ukb2CxA3ed5etZ9hAB7+k
         LN9BSnlTBOvrIEAYSqnTg4skM4plZ3yoj29xFGW7dFq3Vo+uOdmobRaPjijdZlVoiFra
         t/wKwpeyMrwOjFwmoqDO3AnoyL7+037sWTKei3FTHpUAaao+SkShvPutq3JXdsfEFYCG
         mIHC1p38e0jr/rKX+hdmKTlucylUUUcwqIt/jIVlGyLvGJTbUSyFhKPk/EbM/V+/MfMz
         xNlg==
X-Forwarded-Encrypted: i=1; AJvYcCURs5AUwtuYBuV4qTLEXeDQUMkfgcllaX/tJ1VHpdnI6rEUyG3HVcJRzch0UhnWaZwKphRwLZRuMPqlAS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2nG3a8txc8BHOtiry5AAKICgvRY44oiImx8ku0RGGq2ty7Cx
	oN+utkXjt63UM2Oaex71wnQszJULXixAfIMNeQwuX4UuEdLFgvKenFSVutxlnPsLMUc=
X-Gm-Gg: ASbGnctEo9tY5OxD5iYpJifXc5nzF+pdaAsZQO962IOC9obLJ18AD/Uifg87rIMarrp
	SgeqhLUSMW8JAPTVlP+TcMNfmRc4omO12oLydZfhd2UQzpDUUIDth1Bvr0qWK/XV+REoEsGztZf
	AQwQ/qfS8KO9wG0Dm8BQElTez+S/DFxjv0XKmndLswhTgufflaPPcLuWvu2ECPRuCVCmhdlynjt
	ANlZn+K9gTx/lrJEI6mvaGf+O7REkdGsLjsWJbGdracHpob9QZM5yT+49JbhCGbpxOttLLTFq8m
	ZHJkS5jUdbDHifavq39s12e/sQP/Rz6pIzc5FKW5jXRBXL8TLHRBYlUtVr45ROUtKw7MD7IrjNT
	hZRLH7KcyzaWcGimgLyC1Sh3Ea30BYl5A1bBqyoXPY2zBval9Xql96L3E67eowl9vvgiPEA/MEk
	aSWzGzHVZjNg==
X-Google-Smtp-Source: AGHT+IG4zBVlQRBxkma8GUNTG+C+W7SjfIE1L5FExVYDiBWoAchwsg2P9JCvYg0TiAjz/2GSVk2Rlg==
X-Received: by 2002:a05:6820:60f:b0:61e:2de0:4bba with SMTP id 006d021491bc7-61e335b37b7mr8977098eaf.2.1757008163249;
        Thu, 04 Sep 2025 10:49:23 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:a178:aa1c:68f0:444a? ([2600:8803:e7e4:1d00:a178:aa1c:68f0:444a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61e36e549a1sm1893178eaf.0.2025.09.04.10.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Sep 2025 10:49:22 -0700 (PDT)
Message-ID: <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
Date: Thu, 4 Sep 2025 12:49:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
 krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/4/25 12:40 PM, Daniel Lezcano wrote:
> 
> Hi Nuno,
> 
> On 03/09/2025 13:20, Nuno Sá wrote:
>> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>
>>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>>> register (SAR) ADC. Two instances are available, each providing 8
>>> multiplexed input channels with 12-bit resolution. The conversion rate
>>> is up to 1 Msps depending on the configuration and sampling window.
>>>
>>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>>> in both single-shot and continuous conversion modes, with optional
>>> hardware triggering through the cross-trigger unit (CTU) or external
>>> events. An internal prescaler allows adjusting the sampling clock,
>>> while per-channel programmable sampling times provide fine-grained
>>> trade-offs between accuracy and latency. Automatic calibration is
>>> performed at probe time to minimize offset and gain errors.
>>>
>>> The driver is derived from the BSP implementation and has been partly
>>> rewritten to comply with upstream requirements. For this reason, all
>>> contributors are listed as co-developers, while the author refers to
>>> the initial BSP driver file creator.
>>>
>>> All modes have been validated on the S32G274-RDB2 platform using an
>>> externally generated square wave captured by the ADC. Tests covered
>>> buffered streaming via IIO, trigger synchronization, and accuracy
>>> verification against a precision laboratory signal source.
>>>
>>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
> 
> [ ... ]
> 
>> The above needs some discussion at the very least. Have you considered the IIO
>> DMA buffer interface? It should be extendable to accommodate any particularity
>> of your usecase (or we should at least discuss it).
>>
>> With it, you also gain a userspace interface where you can actually share DMA
>> buffers in a zero copy fashion. You can also share these buffers with USB
>> gadgets. For instance, with libiio, you would be able to fetch samples from your
>> host machine (through USB) in a very fast way (zero copy between IIO and USB).
>>
>> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
>> to retrieve the data seems counter-productive.
> 
> I've read a bit about the DMA engine. It is unclear how to use it and there are very few examples in the different drivers to refer to.
> 
> This proposed driver supports the RAW, BUFFER and TRIGGERED.
> 
> Shall I create an IIO device with the modes:
> 
> indio_dev->modes =
>     INDIO_DIRECT_MODE |

Only INDIO_DIRECT_MODE needs to be set here.

>     INDIO_BUFFER_HARDWARE |
>     INDIO_BUFFER_TRIGGERED
> 
> And then use:
> 
> devm_iio_triggered_buffer_setup()

Yes, use this and it will add INDIO_BUFFER_TRIGGERED to the flags.

> 
> and
> 
> devm_iio_dmaengine_buffer_setup_with_handle

Likewise, this will add INDIO_BUFFER_HARDWARE.

And you likely only need to call devm_iio_dmaengine_buffer_setup() which will
save some boilerplate code.

> 
> ?
> 
> 
> 


