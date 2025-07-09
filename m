Return-Path: <linux-kernel+bounces-724626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AED7AFF503
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0BCD1C83594
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80917223DF1;
	Wed,  9 Jul 2025 22:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMyI7iuo"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56534801;
	Wed,  9 Jul 2025 22:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752101576; cv=none; b=QyCmEDNuz7wyo8K639/5bkQpp9m70hkg86s5NCcidhYlEPN4uBf6RXMVHBX7+vEeAm9OqNUQQwQZmSq3IicEfz239KpqiKb1/DAa5GqW2MKLAAoZwcRn2L1TvZpMv64G+vfYf+sDJ3ZTTPQVGnjcS3Cpp6ctsN3WVkHw7sY8QS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752101576; c=relaxed/simple;
	bh=mduGN1yJiHucUotgWYDElpYHrjHdAOSNb8vAqPrzkHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nxVaIBhsfkC8cOWTpV0L2BJ/cTBIPXMiDie3V0VwH/PlalgA6+TkH/nePX1n6ifmFS24H7YbZlNQyx1lfgbG+gLeMSAgb+7/p27ydzeiSaLoy6hGPhVxZZAu0v9EN9tyrtZsPGDu0AV1y1kkHCzwWwSqFJyWJQ5WrSb+UbxINwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMyI7iuo; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74924255af4so366225b3a.1;
        Wed, 09 Jul 2025 15:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752101574; x=1752706374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pGyJ74sJAHPwSq0M5kKX3Ley3GiaOjrmlTbO8aXVCI=;
        b=nMyI7iuo01uwF5wT4Q8EMp/UtCjEGR2eq/kfFUhs68pqZZzNsfJJl+Ry9XicTDAo9I
         8DIBCzwreDGC/PEwovhcMW220gtWnaE2E3k5GZQ+qcm0xwg9aC1JiEPMUba+vy/PZ3Q4
         AsP45v0LL4g2whmzEYvsxH1/FyTuRJx9tsHvtiF8M830k8CFlnSzaiZViG5pKOcQSQ16
         SVBd+rIL61jWXujV5/uaLxy08gCqKZ3pGe++PQ1gkgqH84h3mr05eZiwGoQl92/Y10Ui
         t0yrScdrYboTi05m0y8dq7/v2LWfUwqMdcB0F1vv1rYKBGmrahu+rvPVoQahYLQb14/P
         WaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752101574; x=1752706374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pGyJ74sJAHPwSq0M5kKX3Ley3GiaOjrmlTbO8aXVCI=;
        b=AYnjcyggX+ZOLh9CGit5ssQQ/fop0CuQSGMuwF3OSSFYTU51DIM4JdHLXIKBBkyOnD
         howO7pNbHY2j9fBpcTdqTjWtQFRJCy5JT9T7kLz7/RDcjirxqzqbaR0mPMP0LWP1OWdQ
         jIEHo83+m0qltjxYCB1LPMZoOI/k03XpsRaTgazP4/9CnbquFbAmFyCr5aHu22/eUPtm
         trSbLJ88ZgSbMKzwU2howccd9CZwxrj9JQzj5Ly8rHyyuwjVG5RDMFXclU08e14fDhGD
         HI6tZebg1MVhcxt3UBR/tpYJ0vNEeErI+RKdD8N/dLpL77GyvqwE5/bXspIaNEXUSOMi
         mnPg==
X-Forwarded-Encrypted: i=1; AJvYcCVP2Mp0NW3iE5ukrFWlF1b2bbDFYJD4/2HksizMfaUFgKxdvJw9ZRJbZjdIiKmhTBZTkX4OUW7xM0swJrRk@vger.kernel.org, AJvYcCVQIkkZQ7ozPWgrC26i/OmUwkFHEUxCvwOV/k6zuE/r9LKVKrRewYO2uI9YVPFWqgOlowuRyENHvWAF@vger.kernel.org, AJvYcCVYD/052tjNDUYxPpQth11gd1Avj8/2TBAzRW6cITRqNYbQ0hi+eZZxmelcAQVX/KwPyXw7UdAIkXgc@vger.kernel.org
X-Gm-Message-State: AOJu0YyHM44SkpkpF/kOiE4fsLIZEz3ug0StsiprQ5fCp6vsGTx2CMR0
	KiRNMl0egNXUtYU8e04RfXgf+qADcjbMmFuJaminDL0ZaEAnQTvF/BEv
X-Gm-Gg: ASbGncuJonsA+gSjPQn9gj0+IuaZmq4L+vuac48nNC+7/E+nRLNjYZ2CBnQY7yBMWMi
	QOV+HKhVKerImBP2NbuIVow/hu8j7JAVcsTA3xyjNcbOaGDQzoo565409Fo3H+IrFTzvH97ksfS
	UJdhaXljLBuhijgKOvhr5fWY6IjFGS57jjndIvbsMPDWYezFMgwTVYd75iWqUm52oI5P1znygNn
	iPJCknsyozEQ8pbr7OBCyY1IkdMOxf7KoPjooNAIJXmYqjxQBz9FvDs7iottjnlwM9BQRh6KH0j
	rzI5uc05CK3J1v72BMCazp+vwlQ38NaJnM7rK7u+sLqQzg1ILSJwVnWpYkezCRsch4BWLA1vbMI
	=
X-Google-Smtp-Source: AGHT+IHahCIpZmuEf3/YdV/SH/U9HkJCe0XpP5p5h+uSRbD71aZLs5Ns93G8nOL7yh7fSlnp+bdYaQ==
X-Received: by 2002:a05:6a20:7291:b0:220:8ce7:d6b8 with SMTP id adf61e73a8af0-2300656f034mr602815637.37.1752101574383;
        Wed, 09 Jul 2025 15:52:54 -0700 (PDT)
Received: from [192.168.0.13] ([172.92.174.142])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe7297bcsm261744a12.73.2025.07.09.15.52.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 15:52:53 -0700 (PDT)
Message-ID: <97c55ec2-500b-476e-b99c-a4065b6ba574@gmail.com>
Date: Wed, 9 Jul 2025 15:52:26 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] clock: eswin: Add eic7700 clock driver
To: Xuyang Dong <dongxuyang@eswincomputing.com>, mturquette@baylibre.com,
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 huangyifeng@eswincomputing.com, pinkesh.vaghela@einfochips.com
References: <20250624103212.287-1-dongxuyang@eswincomputing.com>
 <20250624103314.400-1-dongxuyang@eswincomputing.com>
 <0f3aff5b-ff54-48a2-ae95-b344d311c3a1@gmail.com>
 <7a325b0b.2de1.197e94c605b.Coremail.dongxuyang@eswincomputing.com>
Content-Language: en-US
From: Bo Gan <ganboing@gmail.com>
In-Reply-To: <7a325b0b.2de1.197e94c605b.Coremail.dongxuyang@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Xuyang

On 7/8/25 02:09, Xuyang Dong wrote:
> Hi Bo,
> 
> Thank you for your suggestion, it improves our driver development efforts.
> Per your recommendations, we will optimize the driver program.
> 
>> On 6/24/25 03:33, dongxuyang@eswincomputing.com wrote:
>> This is totally wrong I think. Why does the clock driver have to care about
>> CPU voltage? This functionality belongs to cpufreq. You can take JH7110 as
>> reference and see how it's done: https://lore.kernel.org/all/20230606105656.124355-4-mason.huo@starfivetech.com/
>> Looking at eswin vendor u-boot, it seems you have some SoC that can operate
>> at 1.6Ghz without bumping the voltage. Why not do it via operating-points-v2,
>> like the other SoCs? It can then be overridden by board device-tree and u-boot
>> Also the logic of switching clock before changing PLL should be done using
>> notifier: https://lore.kernel.org/r/20240826080430.179788-2-xingyu.wu@starfivetech.com
>> Remove undocumented parameters such as "cpu_no_boost_1_6ghz" and
>> "cpu-default-frequency".
> 
> When higher cpu frequency is applied, the higher voltage must be
> configured accordingly. So, from my perspective, it's better to
> implement the clk, regulator and cpu frequency separately.
> clk.c and clk-eic7700.c are responsible for setting clk only.
> regulator-eic7700.c is for voltage configuration.
> cpufreq-eic7700.c is for cpu frequency configuration, and it will call
> the APIs of clk and regulator.
> 
> Is this the right approach?
> 

Some context for people not familiar with this SoC/Board. The regulator is not
part of the SoC, but on the board. The GPIO pin is controlling the ratio of a
DC/DC converter to select between 0.8V and 0.9V. I think there's no need for
regulator-eic7700.c, and it actually would be wrong if you do it this way,
because per your datasheet, CPU voltage can be any value within a supported
range, and it's up to the board vendor to determine the voltage. Thus, better
to model it with a "regulator-gpio" in the device-tree. No code change needed.
(Assuming you have GPIO/pinctrl merged, which think you already did?)

For cpufreq, I don't see why it can't be just modeled by "operating-points-v2"
just like other SoC/boards. Once complication is the 0.8/0.9 voltage selection
I see two potential ways to solve it (assuming using opp):

1. Extend the opp to dynamically choose 0.8/0.9 based on your OTP settings
2. Isolate this logic in u-boot to patch the opp-table in device-tree before
    boot, or in grub boot scenario, also hook the EFI_DT_FIXUP protocol in
    u-boot to patch device-tree before grub hands off to Linux

For 1, you probably need to have a stable OTP layout, which doesn't vary from
chip to chip and board to board. It also requires you to have a OTP driver in
Linux kernel to read from OTP.

2 is probably simpler and a lot easier to implement. There's also very minimal
or virtually no code change to Linux. It's perhaps easier to do board specific
stuff in u-boot. You can use 0.9V by default in opp-table in device-tree and
u-boot can do the work of adjusting it down to 0.8 based on some OTP settings.
There's also no harm if something went wrong, e.g., OTP is empty or u-boot
doesn't implement the patching logic. In that case, you just waste some power.
It's also possible to remove some frequencies in u-boot if that freq can't be
achieved no matter how high the voltage.

>> Overall I think you better do some real cleanup and refactor of this patch
>> before sending it out again. The driver is quite long, and I suggest you should
>> consider optimizing/condensing the logic. I guess you probably carried over the
>> same code and hacks you made for the vendor tree (eswincomputing/linux-stable)
>> There's no way they can be accepted by upstream. Take a look at other clk tree
>> implementations and spend some real effort fixing the code. Don't let the
>> reviewers grow impatient by only changing something superficially.
> 
> We'll improve the quality of our responses.
> 
> Best regards,
> Xuyang
Bo

