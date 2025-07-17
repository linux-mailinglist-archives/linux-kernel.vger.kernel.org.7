Return-Path: <linux-kernel+bounces-734546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C18F2B082FE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976264A1CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3F1C5F13;
	Thu, 17 Jul 2025 02:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAFnEx39"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF0101FF;
	Thu, 17 Jul 2025 02:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719563; cv=none; b=q9m59teQvDDbbe1yHOrXn2sDxNlbFIfy8oFopEr9tAqtF9c47GIAGK2LebND3c+9aDy+Jyv8XPMrpPF6cFjETJpS49vphTJiZ/IsaMlFS8IOJcF6kM8z99dE525VdWH6T1PwM72bQIhaKVkbJqcnsZNESUFCSEFweO5froFIhHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719563; c=relaxed/simple;
	bh=BnhzXxjqPTw28ZDaa1TvYuU3P+yIIrVS86lI8zKauFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvlSWPCOTFrXEMXcUdavE9UVjE9paClK7eIEohX8lk/NkTT4P/xCt5x26oJIMreX07HMkeOU62ig53mQx76lI4Z9C/TsjwOa55QFFxZdVaI3LJu5/TfIsKybtBtQB9OJdBtL6p/vWJ2dz0GkNqS842iDni4XCmfAA/TEqoHRUpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAFnEx39; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74801bc6dc5so564930b3a.1;
        Wed, 16 Jul 2025 19:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752719561; x=1753324361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gKnrC9Fo8qh6o6JGObWzuAK2E04dMEhKOAnr+GWgHiQ=;
        b=TAFnEx39Wued7jkd5e9iFQGsLlp9RPrnri890P4VCBvfrEdouSmE63r9UGkKC8iKJ4
         +3usNXZtaWPwzXlffUiTxOKqFxzcQpdNLONPmn78doPHUqivyZsVQd9lQCazW0AL/r4Z
         N8+dBjXAXKXgrLUe+GdEomcQ57OWy8X1nOMpooaMZnrhdIPZdR6m/pxounO1YtVjdPEs
         XQvp+1WPvCWaKDDmaASXOyu4KaK4uglINwgH7rBJKPEBNrQB7NRMr8mpfz3I9SzFfPYq
         wvqCLWPdnOJ4ooeBltTBn/eB5WqZpmF8Yv+hQDRof5ppk0NM9v2CSKnW9YJufagHK7uB
         oWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752719561; x=1753324361;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKnrC9Fo8qh6o6JGObWzuAK2E04dMEhKOAnr+GWgHiQ=;
        b=ZGMULdySPUbGX7A5m3bKb6zHBPqkx76dog0Px4ijrMUmcZjcH7HyBaoJoJadovETyh
         A820UiGespWec/cD3knINBYShqgqJVVcuswwo6v/KARQgBwOffVLrMGsEJnuwpEk8nKz
         T0a508cz6+Qd//lzPmO0ObF1hieVCVnA8m1pd/oXDczzuFdb39FzSoeIv5tknphpewUa
         d8ielxS9nFwEr/ce+qufKtndOo6p6Ginhd0ucbFlnG94r8a0eDNKjdOd7raf1QTLfvms
         +OFNK+ChiaO+pJ6PKA//mM42ILgTOySQPgQPEeqvbtJ6XpjkKfy5an3YMIg7DKYalfKm
         HgfA==
X-Forwarded-Encrypted: i=1; AJvYcCUlImefE0YRRq+4ukafwVGCeecJSUesXc3bexYwW3YPwSLjpMeWmwCCaTwX3j+veg0GKm7dQXHtEqhfN8g=@vger.kernel.org, AJvYcCWVj8G2044bYtVuSp8fiCYGe8VEnvRbWGHREvEL50qkG5oJU6OcO4zDTHsm6cB1MO4ntRkvoiNEgmI=@vger.kernel.org, AJvYcCXbeionPMTYVMvxfW5YKY7O4pth1DY4qfFTKwFkhX/XSZ1960asVpUS+WSsObvVa075BDiXSySr67tKwUsk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1qqELT2imBhOVuHCEzKTJGrZqEv6XxkR6aAXgBVUwfbLtP9dy
	0bpUS4u5vFmMvfzyX4XXzSJ61cHbwQaxbdaNPGNmZqbxz9u8YhbDwmUV
X-Gm-Gg: ASbGncspDnnfBgaMFyDkLJ2Qkwx0Tc3zED9rlUZaOJkUxQzZnxIm7tlGTbiChFPYh5x
	c7MEwoSV+JhiMmaId4E400ELGQPoeDw9+5vjbtzfh790kVe3Hk6GzaTGQgcEsIxfTlBRgi7HaT9
	3RvNyTulWNbTx7pfgTvqCtO8Z6dlm9uobK+mfmVYCmRB3Sg2pek1eVICMBLhUyc6ZVu+2FPbFKO
	8IJEHr/uyUQQQPFTYbiIesp5LRY7I3tGSHxDr8K0mdY8W0qdz778YwyjO4g391WDoBGyT/Imas/
	CT3cph0JqUbQodlsQQSBRbeu9rrLK9Av9n5eC24YKOuP5Y9c2Vw4g+pP/554nGLnib8kwDcuTqF
	QqPN6fdh+9T5D4J04II9f6MCCGbnEMkE8Ium+8C6eqg6yu8bQ2FQf19zWTFWVxny6GSh7MpM=
X-Google-Smtp-Source: AGHT+IEqHLbbc4rcqT9l1Mu4JPob7fiw4TMnrTIkSL/RpOnpYugU/SRDkY1wLYXHH+dV9KFw4fJ5Tg==
X-Received: by 2002:a05:6a20:12c4:b0:234:97af:40b9 with SMTP id adf61e73a8af0-2390c4027bbmr2817838637.2.1752719560930;
        Wed, 16 Jul 2025 19:32:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52cbcasm14444997a12.4.2025.07.16.19.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 19:32:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <bb57fe1d-fde9-45f8-9f5c-0836a6e557ff@roeck-us.net>
Date: Wed, 16 Jul 2025 19:32:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] hwmon: add GPD devices sensor driver
To: Antheas Kapenekakis <lkml@antheas.dev>, Cryolitia@gmail.com
Cc: Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Marcin_Str=C4=85gowski?= <marcin@stragowski.com>,
 someone5678 <someone5678.dev@gmail.com>,
 Justin Weiss <justin@justinweiss.com>, command_block <mtf@ik.me>
References: <20250314-gpd_fan-v6-0-1dc992050e42@gmail.com>
 <20250314-gpd_fan-v6-1-1dc992050e42@gmail.com>
 <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <CAGwozwENLOOS5q1Bs5SEh3FFJAY-=kcVimf5U+tWzy6HaiGd=g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/25 13:58, Antheas Kapenekakis wrote:
> On Thu, 13 Mar 2025 at 21:10, Cryolitia PukNgae via B4 Relay
> <devnull+Cryolitia.gmail.com@kernel.org> wrote:
>>
>> From: Cryolitia PukNgae <Cryolitia@gmail.com>
>>
>> Sensors driver for GPD Handhelds that expose fan reading and control via
>> hwmon sysfs.
>>
>> Shenzhen GPD Technology Co., Ltd. manufactures a series of handheld
>> devices. This driver implements these functions through x86 port-mapped IO.
>>
>> Signed-off-by: Cryolitia PukNgae <Cryolitia@gmail.com>
>> ---
>>   MAINTAINERS             |   6 +
>>   drivers/hwmon/Kconfig   |  10 +
>>   drivers/hwmon/Makefile  |   1 +
>>   drivers/hwmon/gpd-fan.c | 681 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 698 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0fa7c5728f1e64d031f4a47b6fce1db484ce0fc2..777ba74ccb07ccc0840c3cd34e7b4d98d726f964 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -9762,6 +9762,12 @@ F:       drivers/phy/samsung/phy-gs101-ufs.c
>>   F:     include/dt-bindings/clock/google,gs101.h
>>   K:     [gG]oogle.?[tT]ensor
>>
>> +GPD FAN DRIVER
>> +M:     Cryolitia PukNgae <Cryolitia@gmail.com>
>> +L:     linux-hwmon@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/hwmon/gpd-fan.c
> 
> A problem we had with oxp sensors is that once OneXPlayer expanded
> their EC to include e.g., battery capacity limits, it was no longer
> appropriate for it to reside in hwmon. I expect GPD to do the same
> sometime in the near future. If that is the case, should we
> futureproof the driver by moving it to platform-x86 right away?
> 

My problem with platform drivers, especially with x86 platform drivers,
including the OneXPlayer driver, is that the developers responsible for
those drivers refrain from implementing the client drivers as auxiliary
drivers but instead like to bundle everything into a non-subsystem
directory. I have always wondered why that is the case. My best guess
is that it is to limit and/or avoid subsystem maintainer oversight.
Does that work out for you ?

Not objecting, I am just curious.

Guenter


