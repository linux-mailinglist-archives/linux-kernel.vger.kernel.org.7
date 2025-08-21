Return-Path: <linux-kernel+bounces-779233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62705B2F0C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE70B17072E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB8F2EA463;
	Thu, 21 Aug 2025 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="Lcgb10Eu"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7524DCF9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763939; cv=none; b=rvjx1IlNU3ww9VRjp6bvPh6/LWHvAEah2CdnpBSNO58QE3YRARZPqAE7UPxICNIuD9a9+H3Ebhjlc3O2jAmfBxgVLgbvKiEbjGVcRB+G/2z6hC0bP3kbmjw9a2p9+m6dMRUJKv4dqp1t614NLTfnsVBRg3LhyDkubrPsEu9RG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763939; c=relaxed/simple;
	bh=Ib5rwP8vabBmjTB2gHFRufvV/brLouRfcpTeVRXGdAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tagh1Qeq6bM7BngNJjfRWl+j3k3Ycuc7E5O45MX6M4iIMeBsPeuZ9BCW/SgJ7VPBMwoHA9A4cRXlh7g/t40/Hy4s4wugtI8hTtDmeJUhCSB/0b2lW5lZF4b7wkmCNoQKrg6rD5UwcIA4ClgEzsjPfzXL42Xu5g3hPyeJyiZrlHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=Lcgb10Eu; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so3335745e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755763933; x=1756368733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RnPqNwnRdJMIc37XxiVZSImeUH9HHnzjQda0KVcM9Yc=;
        b=Lcgb10EuZgGW7I8uqEwCl8dIpd6Z4YPnetNqsqTFatCSeCY/qyWcnQWCLLuENB+ieY
         1WRzWDKc+XrV7HaY5NsADM0kHuNWhnUL6pF5Akq3rldTEHchLMTsD3QjFpflZZQTok39
         kgYn+IDTyovJiS+s27E4qh4F6Bj+hJy6kGVeVSCg78ijYxCFOMxpb+2C9zIQDiE8jHDw
         Ic7muvar+UEGvMaXqqTjAFdbQFbHg/y1fHWGwqcSk0Eo9Wq3FAnTLPMAJsVRWnE1XP1z
         bV50S0nW+qNXyhFIo6GnXbhjL+MUjzFk1S1Cpyy90TXdcXP/0aTIlmznjhyppmVUnnTE
         HNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763933; x=1756368733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnPqNwnRdJMIc37XxiVZSImeUH9HHnzjQda0KVcM9Yc=;
        b=F5Vk1IYglsu8hRZvZi+lv1r8EQLeOP9/TBoKyVJ0GGaTUr7pee2bKl+E7yn7f5Z5DR
         lEZ3uGOrnJpYbVyrlTvRguvvSleK+aysXbBMSrTkt0wkMe4UY0pTcE7zs6rCVHzp+t0L
         k8f+aNFUsSkPI/6uwVPI3ilhjlCbHA6Yey3InrZJq3ySYkZpWyG6ufUWtk+oydB0ko8C
         jW7ZX5SOOjlwGAhd7YG1Qrpars1gviaA4tTNhq9WRoEpekOCu6x5Bo0asqIp55YuBhzb
         Y1ymV199smzgIBmoo9OY7IsRoHuQfZgOl71yZJ5ZnHg0dmUdV9Q6A+3+f2bEuDt9Edma
         DghA==
X-Forwarded-Encrypted: i=1; AJvYcCWW3X/kEz/T5fNP3AARZSm13oW/wV/x6k7EssE4pxPy5a24V+q1ig5L1sp4UQ0u1jm/hZMjGPK2Oz/LJ04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr7CnWF2pA9FO+fFjo6ls4Jwd+9/PXUu6FfyUVfGI3U4fD4poa
	NhJAFyH3JdQ2rxpHE0YTy6RP725hvfMgo9flMkPLaQZ5RosmoL17ckRraeu/Mz5UIbE=
X-Gm-Gg: ASbGncvkC43i9YkUL7LUGk5DYO008S8kWu68l0ZnUKI2FAdYLeAei53Y+dLN9XPa3+e
	x9NIxUCeP268VkI/EoUUCCEZTSwYZyBk90OT78d7qewKWA8gCfPMtlUyUW73Iw8vsS7OFHpjy+5
	3He3roMyMUIot/XM6eUu7IXZkF7x6QNBS+8ZiYPiszBJoUqJxJzqSGw78hBBYPVfYPqWIjhA6kL
	5Wmi1ju3a9USBJI0HrAX+cd2ix0i5DbI3vHJ8b5QBQQMmhcvyPVfsIm+N0lED6ZKRw/C9qzBlxL
	c+kuv1zJUAWmajmXMFGTR4Piim5WrdwLyfaHrQhfrW4jc2TJ4E9v2CcgkCW4PWkXwk1T4cNM6TD
	5OJEX8140kxc+mq++F/aH7ym0FIbpTflhR8hQMDRrI+BRpsU41bGKzM8ClMnx49u2yfUmC07Vyb
	64C88CSv38uN3Y
X-Google-Smtp-Source: AGHT+IHdhYS0MRSPzzW3UprEmG6p659Pq++hTQXcf3C6FUIxInpMAwyfL1/KDCaz5DbATd0JncFKyA==
X-Received: by 2002:a05:6000:4283:b0:3c3:8e05:f72d with SMTP id ffacd0b85a97d-3c496da8a46mr1312520f8f.33.1755763932852;
        Thu, 21 Aug 2025 01:12:12 -0700 (PDT)
Received: from ?IPV6:2a02:1807:2a00:3400:b63f:533e:fab7:5343? ([2a02:1807:2a00:3400:b63f:533e:fab7:5343])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c074879fe5sm10591690f8f.2.2025.08.21.01.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 01:12:12 -0700 (PDT)
Message-ID: <b98cfa73-c6ec-4006-bf84-febbbdea8804@hammernet.be>
Date: Thu, 21 Aug 2025 10:12:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: dts: spacemit: add UART resets for Soc K1
To: Yixun Lan <dlan@gentoo.org>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 alex@ghiti.fr, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250807191817.157494-1-hendrik.hamerlinck@hammernet.be>
 <20250820231917-GYB1065530@gentoo>
Content-Language: en-US
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
In-Reply-To: <20250820231917-GYB1065530@gentoo>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Yixun,

On 8/21/25 01:19, Yixun Lan wrote:
> Hi Hendrik, 
>
> On 21:18 Thu 07 Aug     , Hendrik Hamerlinck wrote:
>> Add reset control entries for all UARTs in the SpaceMIT K1 SoC Device Tree.
>> UART0 was functional as it did not need a reset. But the other UARTs were
>> unable to access their registers without the reset being applied.
>>
> ..
>> Although perhaps not needed I did add the reset for UART0 as well,
>> to ensure consistency across all UARTs. With the current-speed set to
>> 112500 baud rate, it matches the factory U-Boot settings.
>> This should not give issues with early console usage. But perhaps it could
>> be a good idea to let somebody else confirm this as well.
>>
> Adding reset to UART0 is just fine, so we don't need to presume it will
> rely on bootloader to de-assert the controller
>
> please write changelogs in imperative mood, you can follow
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
Ok, I’ll update the changelog accordingly in v2.
>
>> Tested this locally on both Orange Pi RV2 and Banana Pi BPI-F3 boards. 
>> I enabled the UART9 and was able to use it successfully.
>>
>> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
>> ---
>>  arch/riscv/boot/dts/spacemit/k1.dtsi | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> index abde8bb07c95..7a5196a98085 100644
>> --- a/arch/riscv/boot/dts/spacemit/k1.dtsi
>> +++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
>> @@ -667,6 +667,8 @@ uart0: serial@d4017000 {
>>  				clocks = <&syscon_apbc CLK_UART0>,
>>  					 <&syscon_apbc CLK_UART0_BUS>;
>>  				clock-names = "core", "bus";
> ..
>> +				current-speed = <115200>;
> please drop this property, dtsi file should contain generic info for SoC,
> even in real cases, all boards use UART0 as serial output and configured
> at baudrate 115200, it still be able to alter to different frequency..
>
> besides, if you really want to set baudrate, then I'd suggest to configure
> it at board specific dts file, 
>   stdout-path = "serial0:115200n8";
Understood, I’ll drop the `current-speed` property. It works without it.

Thanks for the review.

Kind regards,
Hendrik


