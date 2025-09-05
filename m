Return-Path: <linux-kernel+bounces-802552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0EAB453A8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDB5718939B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E28285057;
	Fri,  5 Sep 2025 09:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xiTfp4+Y"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC427B32C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757065489; cv=none; b=CHexgVDU0/vbzJMNtZCYdoXBcnCVkjEmmLuopCUAT1B+h36qfNQHRt9pQpZ4kzPAO3QrazQ369e1Anaqq/4KzC9NCCQq1ZEM/thBdocZAGUnLQ5LykcvgC7s1rh7YfZ+p0cu0yUqBOmWzT1XwrdvtAWVSiJp+Dhy6XtU1TtpPXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757065489; c=relaxed/simple;
	bh=6rMxYhDmqs/v7kj6WGuLgYVPHayU1LenJFACJct8AbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5o8CG+8jVc0jCNY0ucL0ammOljpxrgeJmHlPbHVREu/rUpKTEli49O+Eg+JdCdJ9rcylB9LIgM99aAYlrXKMQsp4MykcWENPKmoeYBgScFMaieb2P+cHXu8qCYIEGRkFSGCnm7MpgfqB3a3XwehsQ59D5jOjtE1fxJO1mHLYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xiTfp4+Y; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3d44d734cabso1365847f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757065485; x=1757670285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vg+TuI+bOQ+/K0B+1sySJ2VK4abRlS/VZd6mZadbe2g=;
        b=xiTfp4+YeasCu5odA010ly5KiKT9EEKcqYRTXMkgiaKb/FCblnUNXhZ0JhJ68h2n6a
         auuNVTjrRc/Ml9aIGBk+/Vkdwe3czPSBbuLJvBsAKrqqcK2sT8Vduyb5CIiWMfWCXR3H
         60SkkMbFQguQbuwydon7K7ZSTRQeigsdfwXkLPxGyQWrZe2tBdzE+IoBGTJLoTyT7czm
         J11wjX7fs4eu4QYyFNnyEPAShVwEwMpddAdN6eY0SJ+TORjvA8BKzXuQEO2taS8IATjN
         g7DdrKYdOrhCzcNh6H8JCxAIaKpl/VtjGeZviTetgBWQOyzLTerjXQTTZC/Ju2J7dVsi
         3DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757065485; x=1757670285;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vg+TuI+bOQ+/K0B+1sySJ2VK4abRlS/VZd6mZadbe2g=;
        b=nkfprzoVyrAsyVu409t3RZQ9aATtG1z+DRRR6Q5Zx6ZOg9O+S4KBjEOvu7z3Mqrd5A
         SxKV6aPzYBUfhLVg/UmFLw4R2qIfuQ8jxMNolQ/YEca5xaSkWKtpYPATMOVxIoiKQqVz
         Rr7VSqDIbMesVyXYBJ1qeqRHSWH1F4R9/rQXuXg9vhV/FsTPeAjNCjBdA4xBcEA9MG6M
         kYYdsszyQWk2NuHCkUg4E8neY4wU2VCzbeLrjP95Gd4lFl2qRhDvI8aOpUgO0a4bXqt9
         6rJW6MgGHiqZVN/SWuQU8gb2iBf5mkBIfCPiRzoLuGu5Z8pSgcr9IxMaJbP9fn6Nwutd
         ZFrg==
X-Forwarded-Encrypted: i=1; AJvYcCV3Q3+ww/CHYhMsnMDnOWApEMgkqDdRFzO1nkEKzSCBdQWXJACdHX13HXDcOANsIG5eXF2vjNaFWNp6+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAqkZmUi0ZlOSUSs0Z/DT1i/nbIPbHwn4XuQWHiGSk+Zmunlvt
	11fvBJgZzE9GcNSBX5xKcG9kif+H9Lbv++y46B0jvwQgQjYoJQszdff84Fz2Zhn86zk=
X-Gm-Gg: ASbGncscA4LyvOechOdKW1tHT2JPwCNS6VlvEBybfbF+o3puoa1k+5u1veQDadgofXS
	D3xY/6qPjZmjDdp0rF03z+F6aaqGwic3IFaJZX+GYg5fAWMDqe9nNly5rV2hjqDRffjUGWYn9H+
	4IuSY6aye90T0yGrXOQld6w33e2D7/83f+pBcCCTaGSjiPzCbIBaORuYpujGzG1mlP9Ij53XM+3
	qRWqQSH4sVaucb6llsQ74TkJ69V46zc8TEtL+qGwmCrP5a0PMmoRG/gue4H8yTGAWEJ4CdPnQ3d
	789JGXCuIVWAnoEqHA01dES4G+v+KKU5uMkSCtNsdXlF6EdD4q8Weum1rh/ZVSVdeFJJXlHSxYX
	ytTmxgKbVCrYtGGFo6i9wsjRLVrqNufjG581JU9yE2YSKNa6/5V5w0Tw1I6oA+HRCAdAnSK3d6E
	ny6E3WfxzWkkLy
X-Google-Smtp-Source: AGHT+IFodgj442lDLbVLMi4njhpRzF0c5s/MBO2AX5hxfzUKZQkDG+LP5IKBwiCAYGAM+uTD1n1Odw==
X-Received: by 2002:a05:6000:250d:b0:3d6:b35b:153b with SMTP id ffacd0b85a97d-3d6b35b2262mr15384906f8f.26.1757065485080;
        Fri, 05 Sep 2025 02:44:45 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992? ([2a05:6e02:1041:c10:43b0:7b3b:e0d9:6992])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e2f6af9791sm2928315f8f.26.2025.09.05.02.44.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 02:44:44 -0700 (PDT)
Message-ID: <edc8e024-e425-49de-bfa2-44218fe72e26@linaro.org>
Date: Fri, 5 Sep 2025 11:44:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
To: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <noname.nuno@gmail.com>, jic23@kernel.org, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org
Cc: linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com
References: <20250903102756.1748596-1-daniel.lezcano@linaro.org>
 <20250903102756.1748596-3-daniel.lezcano@linaro.org>
 <eedbfbfd1ba625b6750eb3ae20a69301b8bc3ef9.camel@gmail.com>
 <0bfce1eb-69f1-4dae-b461-234eb98ffce1@linaro.org>
 <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a3373804-08a4-4526-a432-c21a74ea3d6b@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/09/2025 19:49, David Lechner wrote:
> On 9/4/25 12:40 PM, Daniel Lezcano wrote:
>>
>> Hi Nuno,
>>
>> On 03/09/2025 13:20, Nuno Sá wrote:
>>> On Wed, 2025-09-03 at 12:27 +0200, Daniel Lezcano wrote:
>>>> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>>
>>>> The NXP S32G2 and S32G3 platforms integrate a successive approximation
>>>> register (SAR) ADC. Two instances are available, each providing 8
>>>> multiplexed input channels with 12-bit resolution. The conversion rate
>>>> is up to 1 Msps depending on the configuration and sampling window.
>>>>
>>>> The SAR ADC supports raw, buffer, and trigger modes. It can operate
>>>> in both single-shot and continuous conversion modes, with optional
>>>> hardware triggering through the cross-trigger unit (CTU) or external
>>>> events. An internal prescaler allows adjusting the sampling clock,
>>>> while per-channel programmable sampling times provide fine-grained
>>>> trade-offs between accuracy and latency. Automatic calibration is
>>>> performed at probe time to minimize offset and gain errors.
>>>>
>>>> The driver is derived from the BSP implementation and has been partly
>>>> rewritten to comply with upstream requirements. For this reason, all
>>>> contributors are listed as co-developers, while the author refers to
>>>> the initial BSP driver file creator.
>>>>
>>>> All modes have been validated on the S32G274-RDB2 platform using an
>>>> externally generated square wave captured by the ADC. Tests covered
>>>> buffered streaming via IIO, trigger synchronization, and accuracy
>>>> verification against a precision laboratory signal source.
>>>>
>>>> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
>>>> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
>>>> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
>>>> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
>>>> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>
>> [ ... ]
>>
>>> The above needs some discussion at the very least. Have you considered the IIO
>>> DMA buffer interface? It should be extendable to accommodate any particularity
>>> of your usecase (or we should at least discuss it).
>>>
>>> With it, you also gain a userspace interface where you can actually share DMA
>>> buffers in a zero copy fashion. You can also share these buffers with USB
>>> gadgets. For instance, with libiio, you would be able to fetch samples from your
>>> host machine (through USB) in a very fast way (zero copy between IIO and USB).
>>>
>>> Setting up DMA to then "having" to push it to a SW buffer and needing a syscall
>>> to retrieve the data seems counter-productive.
>>
>> I've read a bit about the DMA engine. It is unclear how to use it and there are very few examples in the different drivers to refer to.
>>
>> This proposed driver supports the RAW, BUFFER and TRIGGERED.
>>
>> Shall I create an IIO device with the modes:
>>
>> indio_dev->modes =
>>      INDIO_DIRECT_MODE |
> 
> Only INDIO_DIRECT_MODE needs to be set here.
> 
>>      INDIO_BUFFER_HARDWARE |
>>      INDIO_BUFFER_TRIGGERED
>>
>> And then use:
>>
>> devm_iio_triggered_buffer_setup()
> 
> Yes, use this and it will add INDIO_BUFFER_TRIGGERED to the flags.
> 
>>
>> and
>>
>> devm_iio_dmaengine_buffer_setup_with_handle
> 
> Likewise, this will add INDIO_BUFFER_HARDWARE.
> 
> And you likely only need to call devm_iio_dmaengine_buffer_setup() which will
> save some boilerplate code.

What is still unclear for me is the trigger and the dma modes.

If the dma engine is supported, I should use 
devm_iio_dmaengine_buffer_setup_with_handle(), but will the trigger mode 
be supported also automatically (I don't see a clear answer in the 
documentation neither in the drivers) ?

If not, shall I call devm_iio_triggered_buffer_setup() and 
devm_iio_dmaengine_buffer_setup_with_handle() ?






-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

