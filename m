Return-Path: <linux-kernel+bounces-879728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BCC23D38
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F3D1A252A3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4B42BE646;
	Fri, 31 Oct 2025 08:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZrmssfVq"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3222172E
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761899605; cv=none; b=f7ATlx657V55AAKhNSqnyn5IvlIqFzXWp6ub5glxdzMYS0/AE5jdljUlVF8xvr/7Fo8HPeNR0+tHvgvtMaAekD7Gr2xoCCIhy3txYPT9oreai+AsoL9C1o2wKynQkowd5wt58+7UHd/UY4olYZBXnTE79GE5tBgDRjDq8Ex8t0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761899605; c=relaxed/simple;
	bh=WSvD4GxmfFd+tajUhRwYg9HAN6s/4JQ4rCG6KCJLdls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PioTJcUHriBo/sSZcJ8G6/kZA20cF0RmfLDj4UlQfaEgE054uQ3UOW/amMBkZrOIsOZ8tQMXKm/HPycV4YWYynQeyIZ3pEnT0H9VnXXVlKdXG5KXq52zfATTKBWaarlJqircDrvk1gMly4L1McuQkLw9FDkzEHRp4HuMTeIgqaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZrmssfVq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CE1B24E4142B;
	Fri, 31 Oct 2025 08:33:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 923CD60704;
	Fri, 31 Oct 2025 08:33:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5A6C11180FE55;
	Fri, 31 Oct 2025 09:33:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761899600; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=E+isSm0tESAECMiu4x/HWPUg/HqD5qUnglPjpGg08t4=;
	b=ZrmssfVqvhNe04qAMQHnanzo8UqXJm0eBpIBMo4B0K2KSgv3M6ae422uEQPY5+QOOrARAA
	DISItDSoi//vNkuJETrUDYbD194s/hTQpA/IYjgNVyil6qZc1zSYJdfr9Bm2IqqlBh+fhg
	SX7yOxKnR5+pWTZLADqProCI7CKc3bmE3/NywA7fp84frjGE1vgIGe+j3G5Gcacs8AF3xA
	NfDhvaauNITCEBu5L+cQ0WVygrpC+Fl9D/Y7ux7vH9ZK0Dz5yrTs/u1/rwJ8ie4dfkhmPw
	P0r33uZ+NWlfSlSLVWHh4LU22t7aJmVjPmhFn3u8uLCrwOdkCc9qp+Y5P0FCrw==
Message-ID: <da18cd22-9f9e-4166-8a91-d5b19470c693@bootlin.com>
Date: Fri, 31 Oct 2025 09:33:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: ti_sci: replace ifdeffery by pm_sleep_ptr()
 macro
To: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, Udit Kumar <u-kumar1@ti.com>,
 Prasanth Mantena <p-mantena@ti.com>, Abhash Kumar <a-kumar2@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251014-ti-sci-pm-ops-cleanup-v1-1-70b50b73ac85@bootlin.com>
 <20251031041131.3qmqfitiertc7vdp@scotch>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20251031041131.3qmqfitiertc7vdp@scotch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Nishanth,

On 10/31/25 5:11 AM, Nishanth Menon wrote:
> On 10:35-20251014, Thomas Richard (TI.com) wrote:
>> Using pm_sleep_ptr() macro allows to remove ifdeffery and '__maybe_unused'
>> annotations.
>>
>> Signed-off-by: Thomas Richard (TI.com) <thomas.richard@bootlin.com>
>> ---
>>  drivers/firmware/ti_sci.c | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>> index 49fd2ae01055d0f425062147422471f0fd49e4bd..99a2e0e2960f463918950fef8829409ec365ce70 100644
>> --- a/drivers/firmware/ti_sci.c
>> +++ b/drivers/firmware/ti_sci.c
>> @@ -3706,7 +3706,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
>>  	}
>>  }
>>  
>> -static int __maybe_unused ti_sci_suspend(struct device *dev)
>> +static int ti_sci_suspend(struct device *dev)
>>  {
>>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>>  	struct device *cpu_dev, *cpu_dev_max = NULL;
>> @@ -3746,7 +3746,7 @@ static int __maybe_unused ti_sci_suspend(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
>> +static int ti_sci_suspend_noirq(struct device *dev)
>>  {
>>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>>  	int ret = 0;
>> @@ -3758,7 +3758,7 @@ static int __maybe_unused ti_sci_suspend_noirq(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
>> +static int ti_sci_resume_noirq(struct device *dev)
>>  {
>>  	struct ti_sci_info *info = dev_get_drvdata(dev);
>>  	int ret = 0;
>> @@ -3780,7 +3780,7 @@ static int __maybe_unused ti_sci_resume_noirq(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static void __maybe_unused ti_sci_pm_complete(struct device *dev)
>> +static void ti_sci_pm_complete(struct device *dev)
> 
> PTR_IF when CONFIG_PM_SLEEP is disabled will result in these static
> functions unused, no? should we leave __maybe_unused as is?

PTR_IF is ((cond) ? ptr : NULL)

If CONFIG_PM_SLEEP is disabled, after preprocessor step you will have

	.suspend = 0 ? ti_sci_suspend : NULL,

So ti_sci_suspend() is still used. But as the condition is always false,
the compiler can do some optimization by removing ti_sci_suspend().

PTR_IF macro has a great documentation [1] which describes this use case.

[1]
https://elixir.bootlin.com/linux/v6.17.5/source/include/linux/util_macros.h#L85-L136

Best Regards,
Thomas

