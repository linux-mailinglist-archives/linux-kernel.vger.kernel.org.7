Return-Path: <linux-kernel+bounces-778761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E33DB2EAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98FF5C2EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAA2229B18;
	Thu, 21 Aug 2025 01:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tftl5mEg"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3118421A43B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755739783; cv=none; b=RYHZdC9KCxcKc46cn9B9xx39a/+cf4wixTs+xpD58EkolKuUEm/NGeR8pYYH9lvDOd7IG0IHK/7K8bYlrm5dqGiufyOPnHwHH/feM+ADzKxFRRx1s1oQhcF+06gPpy2v0AXSxiF9ZCYDKat3O5+i0tfFqVMEjQJPKQoLLAJglfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755739783; c=relaxed/simple;
	bh=e10SbWCMoETMH3pPxsIwRdmXQgN63e98cpuLujyrvek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XyIdDVMhPBmD0vXblCwlZFIUDc6V5f79vSzDPnTUQqMABoCdfylj52AYHr3R22i6pedOuVaeHvAdh6FbMn7Cieh10aQekS7+GtcbOVVth/6NtaqaYjtLss1d/QGz3tEONIi79HDKL771CXqDrCL7vwL1y+G0zF+mHeei5Sn7GhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tftl5mEg; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e2eb4a171so638748b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755739781; x=1756344581; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qB3jMA9nyR5VDq12DEWdcvkghIiM/hajb+LZQ1DXaUM=;
        b=Tftl5mEghCWHLEGi1mm/tumkwFza4wqka5lEt5974DWbqw1Df4yUQIoBrk2xj1I3tS
         cQxZvs0r7gj5ZqSS+dd3OUQ4/BP1f39+ORUcc/bb7ZTIqxOFZRnmudnv3y7zvZJFzhYJ
         MDNZlUsL9xxVFVPalxP6Qiy6ggXWIe32yMX7Jxlmy3RfeCXJRiEu9yvuBZ9a171vesHq
         YEUSaC0mfWj8BrKvxyAC1XQfA+hZsQeK+3eTQ586mSrZlJTapkK3mb3+LMpCTyXulTPX
         uVdi2sNB/gNBTq7Jn5HH1LMS6phxDO6da3Kv8OB8R2JyrumrKV+IzfQ21htyhUEY9I42
         m2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755739781; x=1756344581;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qB3jMA9nyR5VDq12DEWdcvkghIiM/hajb+LZQ1DXaUM=;
        b=qBoVcVQ+w4lxN/R+egQ8/QY6YvFD0dtE01leHhdmYnNnurwkRDEf3He+0RosheB5Xc
         8ByQ8M/lA0GeJAviPPhoKC8sNW58U6/+GW2CUQ0p8QGMqNiLBBSkz1JnvwWswoBcyxkY
         fQX/MgB6cV2D5Yle3VDmtvb8RyLyTWjGmEx4b0xPLCvnFK+O6o0TXe/irWMgqiJixENJ
         sw4ukaihe6XQd+yMBBqTnn3uCmueYFY0iT5uisqDkdPsMnjKJUKzm07Kr6ta+ZDsNcTO
         6LQCMDbYQ+0A7fI0HhOjKtPXY3YgExN8RLMyB6qG2JYtNLIlCZmc+7VXBImqoF4Fd1/l
         Ubvg==
X-Forwarded-Encrypted: i=1; AJvYcCXBjDXC2AM4UvSUZJ1wdYyf7URCMijpNa1QW4ebB75KYzPOaeDqf0pZLDXGvt/8PArTPCo/Y46gNQnSBjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLcL3ZVsXkMKpnZBmfkFYw54TlQVauHuYui1oAw2iAcsTMfM3s
	dHwUy0CRvBBVn9xCPeoiFs3GZjdZ4i/EqNHJyynsjpW0cpk8T47EB+XN
X-Gm-Gg: ASbGncsBpyI6aZSWxWU6TxmVSa5JDeDu7X6onl4c9vyQYE4zh2jrm3PYXZErJjVbcbs
	Zsaqvjka5B4/bK+IrquGAbddDBbjy12wsjOAY+LFounaCcvwH71USurjl4KeeQbC+c4oxRCiQsH
	FX7sTjWylvVVrPZKYzHH3vHRqFcbnVwkIlzQfndE8jpLduPxTn6NpjZ/q8y57+0lYOLtQAhdpNp
	cwyH27hYpdsIiURUdST0zXap03+h+E7sOPSR3hEydGh7IDNgUB/t5FI0qCkuvFrfn4YUK8I4oiv
	X0Oak9yy4pk0iS2HPF9W0iLZdFFuNsZiFKKK0umnzPosU8NBzuQPBF2V0ImjPdI2ae4bb4Am3ad
	OJCON4FCrwOjGoELpgea9
X-Google-Smtp-Source: AGHT+IEePCnxqJFqkjx6e4uSVtDp4OTUjWx0mguKFsRGvJHjDPSeJqnrLiqm41F2WSktl+oKdl15iA==
X-Received: by 2002:a05:6a20:7fa8:b0:243:15b9:7662 with SMTP id adf61e73a8af0-24330b6b477mr820141637.60.1755739781103;
        Wed, 20 Aug 2025 18:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([2403:2c80:17::10:40f3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d1a44sm6642219b3a.1.2025.08.20.18.29.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 18:29:40 -0700 (PDT)
Message-ID: <05757005-b0c7-4475-88db-8d8b274c7600@gmail.com>
Date: Thu, 21 Aug 2025 09:29:29 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] watchdog: skip checks when panic is in progress
To: Yury Norov <yury.norov@gmail.com>
Cc: pmladek@suse.com, akpm@linux-foundation.org,
 Douglas Anderson <dianders@chromium.org>, Ingo Molnar <mingo@kernel.org>,
 Li Huafei <lihuafei1@huawei.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Thorsten Blum <thorsten.blum@linux.dev>, linux-kernel@vger.kernel.org,
 feng.tang@linux.alibaba.com, joel.granados@kernel.org,
 john.ogness@linutronix.de, namcao@linutronix.de, sravankumarlpu@gmail.com,
 Will Deacon <will@kernel.org>
References: <20250820091702.512524-1-wangjinchao600@gmail.com>
 <20250820091702.512524-2-wangjinchao600@gmail.com>
 <20250820091702.512524-3-wangjinchao600@gmail.com>
 <20250820091702.512524-4-wangjinchao600@gmail.com>
 <20250820091702.512524-5-wangjinchao600@gmail.com>
 <20250820091702.512524-6-wangjinchao600@gmail.com>
 <20250820091702.512524-7-wangjinchao600@gmail.com>
 <20250820091702.512524-8-wangjinchao600@gmail.com>
 <20250820091702.512524-9-wangjinchao600@gmail.com>
 <20250820091702.512524-10-wangjinchao600@gmail.com> <aKXnOTq9ZYeVYqH5@yury>
Content-Language: en-US
From: Jinchao Wang <wangjinchao600@gmail.com>
In-Reply-To: <aKXnOTq9ZYeVYqH5@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 23:18, Yury Norov wrote:
> On Wed, Aug 20, 2025 at 05:14:54PM +0800, Jinchao Wang wrote:
>> Both watchdog_buddy_check_hardlockup() and
>> watchdog_overflow_callback() may trigger
>> during a panic. This can lead to recursive
>> panic handling.
>>
>> Add panic_in_progress() checks so watchdog
>> activity is skipped once a panic has begun.
>>
>> This prevents recursive panic and keeps the
>> panic path more reliable.
>>
>> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
>> ---
>>   kernel/watchdog_buddy.c | 5 +++++
>>   kernel/watchdog_perf.c  | 3 +++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
>> index ee754d767c21..79a85623028c 100644
>> --- a/kernel/watchdog_buddy.c
>> +++ b/kernel/watchdog_buddy.c
>> @@ -93,6 +93,11 @@ void watchdog_buddy_check_hardlockup(int hrtimer_interrupts)
>>   	 */
>>   	if (hrtimer_interrupts % 3 != 0)
>>   		return;
>> +	/*
>> +	 * pass the buddy check if a panic is in process
>> +	 */
>> +	if (panic_in_progress())
>> +		return;
>>   
>>   	/* check for a hardlockup on the next CPU */
>>   	next_cpu = watchdog_next_cpu(smp_processor_id());
>> diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
>> index 9c58f5b4381d..7641de750ca5 100644
>> --- a/kernel/watchdog_perf.c
>> +++ b/kernel/watchdog_perf.c
>> @@ -12,6 +12,7 @@
>>   
>>   #define pr_fmt(fmt) "NMI watchdog: " fmt
>>   
>> +#include <linux/panic.h>
>>   #include <linux/nmi.h>
>>   #include <linux/atomic.h>
>>   #include <linux/module.h>
>> @@ -110,6 +111,8 @@ static void watchdog_overflow_callback(struct perf_event *event,
>>   
>>   	if (!watchdog_check_timestamp())
>>   		return;
>> +	if (panic_in_progress())
>> +		return;
> 
> It looks like watchdog_check_timestamp() does some real work, like
> updates last_timestamp and so on. Under the panic condition all this
> may be unreliable, right?
> 
> Maybe it's worth to make panic_in_progress() the first check in the
> chain?
> 
That's a good point. Thank you.
> With that,
> 
> Reviewed-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
>>   
>>   	watchdog_hardlockup_check(smp_processor_id(), regs);
>>   }
>> -- 
>> 2.43.0


-- 
Best regards,
Jinchao

