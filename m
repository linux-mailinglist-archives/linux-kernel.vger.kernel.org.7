Return-Path: <linux-kernel+bounces-804833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE51B48079
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61CCA189D556
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1394E217659;
	Sun,  7 Sep 2025 21:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmeGUa4y"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A6E1C6A3;
	Sun,  7 Sep 2025 21:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757281746; cv=none; b=OKJ7/KXnXSLHbAgHRR9fTAS1Rdw9ftvxW1hTC9KJr/WwrV5H0VyfVtCvqf/PuAa4Q8yxfC3S1bpdQpku6yY3g1Y7mTln6mpCL1swASqb1EAr4WQBcBDUIS7JDDZ3etV84mlI/RdQykwyDqf9gec1nNiHmoO/F+ngovpyVI0DD+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757281746; c=relaxed/simple;
	bh=sBpcJdvU4hr21gPuRrNNUuZM+z/vPr52Ok8sj+wwd/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tF57yisC2WDHGgwGOyszCC341e51ViC22+ly+jAvn3cNsKOyi6mCQJCOnvGnFVqehkjQ2CVVFCgzjk/DT6pLjEbftav4BET5swXT1Yl29chZ9het35/liDQW+m9lRQ62fSHin7BFkMxHs7eWb6AAxF1cR/XhnI9YBW6pSKrzkAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmeGUa4y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45de287cc11so2938415e9.1;
        Sun, 07 Sep 2025 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757281743; x=1757886543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Ge3mYYvanFf7VDYY5E620z5tgjBKFtjXT61OFvHXIQ=;
        b=fmeGUa4yRhAFWdZkAi1YILMNghvYj5lzQ/jkFZDX1Q4vRFXpXGzTAYZzVc+z3LFZZm
         qY8XttrPagC4R1L9oqWIBla20UjySgfCWPEMm2Ce40Q3Voax4DYrmWg/+SMX+WuGNDUD
         aJ3ErFuB4++IoUw2yu9aL0ip6y8+fvIs9QD+n4vgiFt0Yk9wpTcMmOZMF38tjjoJ8tZS
         GuNOK4clGebptR5iNx66uIuOszcrRH22s+VmK1/s5F6bsbcHBZa6MQxappwOoO3MoqCf
         blNkUjLijHQvaxYnkkepC+0ABfhmKICL2FAtEEqU+3N/4Gd+0oj22VfGDgViAVJCt4zY
         rEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757281743; x=1757886543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Ge3mYYvanFf7VDYY5E620z5tgjBKFtjXT61OFvHXIQ=;
        b=cLDkw4YB5PDs6zj9TDt86VFQmzsXaSer6VXIJz5GpKnqEbvz0xm1OprUFCqCw5Jci7
         M2A8PiYqDquQVQ2DCnCo4jTXxtZogFjB+BBbt36Tses86p1FC7TWTr6JatzCEA3YYJzs
         DLMgyo+PiAhqMwDQ2aFuV+dRPTkKc7hYfqV1PgtOqPi78iUKdqHkwo/uQMYRMntS9Z1X
         nbD+oRkU9NArfY2RZQ7NP8ZAbjXaQ1i7On4Sx0beOQedlXWsB+KKEn1BLrC2pzKeh+dV
         9foQEqSv6bUudIQTte+Od03ntZFd75Z3Q5AqmvFRouZNb2nMRqDGIe1VEG5KDKvMCXxV
         RdqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmq2AUgJ4Kxlm97lQpNMZvPn7O1cRu6ylREyRDnj5MtHjUnzqQCvzBoUWPFbEN8f+unRPIkj9jbHeNXFc1@vger.kernel.org, AJvYcCV6C39yAhJM3l7LG+tmeEOh1t5VCUZvk5V/rXXMmyfHo/HYyXhUxCPgclPbTLgW/szdV1qDyjSL2Jje@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2/HUmCgH/wIkP6k4kVSELMHVcU6+KVbnzoGio+ZbS/I44QhRa
	RXPufqzFr4AWbloyvgR9J3gSvSrebBTzBUCP849VIG8IuVN2RWfv2860cV+Tig==
X-Gm-Gg: ASbGncvRVry83blsS67b9JHXgFmS+z3+aKwpGiVzNe8GhUhfRo5fxedyGe4F8DdELjT
	CP8CB9uDoJ2yGqvVMM/DEpAXUCIuYQsB7xiAUzEGxCnrbvTUWLTwjcjCEepedkjtXozksoPARao
	RO/liKtFx5CI+Wcj9ZjtkE0hPOsrPR/KiaXGhlK07PsCFOQl1Gw6FmaCSieGTJPJ8RPx9UZ02Lw
	7mqVztDDVukyUxqfrOhiP3uEbo2wHPKr9Qg7zJYxGD/wOlPfMNx9E8J1ITODoPnd+2vgYDmmqSx
	jpQJxqqjgi9HydtFzy91w0r350RPzrMXTgkenYuU0PSOeQ+fQGA1n7Bo1PlwZn5Wj+plbyLxe2q
	7Zw71a25nKsbTJz8yEQv2WIowDMe2UV/dR02jmqRU2EwWqYDzMOLOELcq0iiHfmRn8/COW3bpxI
	hOWN8=
X-Google-Smtp-Source: AGHT+IGART8ckw/rGELA8KyB0cRV6LrY2FgEDmT8Z5h84zUWqCDLhM/f15gaQqI7S91xWlrnlxLxAg==
X-Received: by 2002:a05:6000:310f:b0:3e0:63dc:913c with SMTP id ffacd0b85a97d-3e2ffd7fb5emr8835207f8f.3.1757281742745;
        Sun, 07 Sep 2025 14:49:02 -0700 (PDT)
Received: from ?IPV6:2001:861:3385:e20:6384:4cf:52c5:3194? ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45ddf1765e8sm70766305e9.22.2025.09.07.14.49.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 14:49:02 -0700 (PDT)
Message-ID: <bdfef146-9daf-4f95-9314-f41e7352cbb3@gmail.com>
Date: Sun, 7 Sep 2025 23:49:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] ARM: sti: drop B2120 board support
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20250714-sti-rework-v2-0-f4274920858b@gmail.com>
 <20250714-sti-rework-v2-1-f4274920858b@gmail.com>
 <CAL_JsqJ0ckZ529gm781uF52yR3-gj2ctHR11hUK=4q8_Eq65EQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?Rapha=C3=ABl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <CAL_JsqJ0ckZ529gm781uF52yR3-gj2ctHR11hUK=4q8_Eq65EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/09/2025 à 01:37, Rob Herring a écrit :
> On Mon, Jul 14, 2025 at 8:54 AM Raphael Gallais-Pou
> <rgallaispou@gmail.com> wrote:
>>
>> B2120 boards are internal boards which never were commercialised.
>>
>> Drop them.
>>
>> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
>> ---
>>   arch/arm/boot/dts/st/Makefile           |   2 -
>>   arch/arm/boot/dts/st/stih407-b2120.dts  |  27 -----
>>   arch/arm/boot/dts/st/stih407.dtsi       | 145 ----------------------
>>   arch/arm/boot/dts/st/stih410-b2120.dts  |  66 ----------
>>   arch/arm/boot/dts/st/stihxxx-b2120.dtsi | 206 --------------------------------
>>   5 files changed, 446 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
>> index cc9948b9870f7f73629573149bfd342af75b07da..f57fc6dc48a00c9a9323b4508e5e4e161b197c47 100644
>> --- a/arch/arm/boot/dts/st/Makefile
>> +++ b/arch/arm/boot/dts/st/Makefile
>> @@ -13,8 +13,6 @@ dtb-$(CONFIG_ARCH_SPEAR3XX) += \
>>   dtb-$(CONFIG_ARCH_SPEAR6XX) += \
>>          spear600-evb.dtb
>>   dtb-$(CONFIG_ARCH_STI) += \
>> -       stih407-b2120.dtb \
>> -       stih410-b2120.dtb \
>>          stih410-b2260.dtb \
>>          stih418-b2199.dtb \
>>          stih418-b2264.dtb
>> diff --git a/arch/arm/boot/dts/st/stih407-b2120.dts b/arch/arm/boot/dts/st/stih407-b2120.dts
>> deleted file mode 100644
>> index 9c79982ee7ba8fadb1a2a92e732bf7f652b74c38..0000000000000000000000000000000000000000
>> --- a/arch/arm/boot/dts/st/stih407-b2120.dts
>> +++ /dev/null
>> @@ -1,27 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/*
>> - * Copyright (C) 2014 STMicroelectronics (R&D) Limited.
>> - * Author: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>> - */
>> -/dts-v1/;
>> -#include "stih407.dtsi"
>> -#include "stihxxx-b2120.dtsi"
>> -/ {
>> -       model = "STiH407 B2120";
>> -       compatible = "st,stih407-b2120", "st,stih407";
>> -
>> -       chosen {
>> -               stdout-path = &sbc_serial0;
>> -       };
>> -
>> -       memory@40000000 {
>> -               device_type = "memory";
>> -               reg = <0x40000000 0x80000000>;
>> -       };
>> -
>> -       aliases {
>> -               serial0 = &sbc_serial0;
>> -               ethernet0 = &ethernet0;
>> -       };
>> -
>> -};
>> diff --git a/arch/arm/boot/dts/st/stih407.dtsi b/arch/arm/boot/dts/st/stih407.dtsi
>> deleted file mode 100644
>> index aca43d2bdaad44ef2a0e8a120c679c217709af44..0000000000000000000000000000000000000000
>> --- a/arch/arm/boot/dts/st/stih407.dtsi
>> +++ /dev/null
>> @@ -1,145 +0,0 @@
>> -// SPDX-License-Identifier: GPL-2.0-only
>> -/*
>> - * Copyright (C) 2015 STMicroelectronics Limited.
>> - * Author: Gabriel Fernandez <gabriel.fernandez@linaro.org>
>> - */
>> -#include "stih407-clock.dtsi"
> 
> Looks like this file is unused now too and can be removed.
Good catch, I missed this one, and it seems also that several 
compatibles within the file won't be used either.

I'll fix this promptly, thanks.

Best regards,
Raphaël>
> Rob


