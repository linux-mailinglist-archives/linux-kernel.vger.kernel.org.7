Return-Path: <linux-kernel+bounces-779465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22902B2F475
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72483AA5BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE27278146;
	Thu, 21 Aug 2025 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgze4+pD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36B4287266
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769515; cv=none; b=Ofaun4H022gbd6xfXqksTxFJSopoXoBcPymOdEbXe3jezwubzxi/RndtjKVBeF8Gd5Nacg/h0JK44GsE9XtH7C6INkcK0HZxXdobVjWvqkDSpnYsr5v22drNulowcSDEEsfT/BJIXVnid7alFUKgyUc8pwBKeQseaFKy3lY4KhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769515; c=relaxed/simple;
	bh=AfcV+NZmIM1SEdPm2QzlQXN6D48i2MUGRsGfgZaaNZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+Xq8h40X1buXD3unakGB/Qvz9jqJq7WOa8uH8umKKOuPO0tGNmCmJsZkLbSrOaMyFw9k9wByTawtNygK0EZvrSy92k4kel0mzp+XNbU5iL0jz6LO7FM7k8SIDZ8YH0pHbzvKi+88O4fpM+OX+7APYON/1qmru7w7NtLCLk5Imc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgze4+pD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso6103385e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755769512; x=1756374312; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PhNC2STjjirOesaI9d1eJ9GZDJ/V751PcyAhgMqnsOQ=;
        b=mgze4+pD8Q45odekCnPZBbtsqGgO5ZpMxCjEhWhpVHdrOrvhhSIhKDQHuiY8sMa+bD
         24RH4vUIVHsPbHNPZqKu8VVCPPPmjqOmG+l3BJl73wzxAppCI9pQanSuLcf+qxysVZDO
         Xro+O9A97CId+myYF5TDbf61bTmzV8txue6F6Kqnmgbbfc5+3bqfCV5DT+G13A6B6WOV
         MGpm8vxl3ZQ5yjRI4FE8yVanETkZcSwaUOatRsAmCYzufgI6EivyTpy168uL4t+vQ1HI
         igC20rU9UaFkfzLeFUZcX1/nB6T4e0vbtVSpU3CU8oTPIvzpPK8NgRJrlFf98QBFXpIo
         9Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769512; x=1756374312;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhNC2STjjirOesaI9d1eJ9GZDJ/V751PcyAhgMqnsOQ=;
        b=X7UqrwivqGQnmD4fTsGvtvewLRQ91jTTTeTLJ+zZKRKl8cj7ZbMj+XV8WGeobfAiS6
         g3JfuAS4vTbxXDoRIwHQynbuFwLdC//vXYuezusJ/RtsbR+8LPh7viIq6EkEXJbdRiww
         m9VPOqv2cuE3/eRnCb8Q9//hlSoOPUuPUH2IF5Q6laU9qWiBN7zzXDMFxhUdP/QO3yGe
         did+hf8KE1M3RXgGck5LQ+je5CQ8wyZmoyq9/HNyagQQoA3fHRAUXme4aT9QG8e3crqN
         wpXgcg1BEGn8dia9bh/3kssHkPnzQNBHep0vAHspdqON1zLYSpm4UIKPMMwKvh30DS1b
         vaEw==
X-Forwarded-Encrypted: i=1; AJvYcCWx6QGP1/716vA71roKZkGUH56q3XKzJcgw+CptnZe7tg8Khx9KzJoEA/FeBnNheWH0KNCS9yxx1fjJ7SY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfjftXTpTv0IswATvLl3aGF6/lxBZ/bY/0HlohgJfkfAb973Ru
	TWSxwLU49oUrqimhxjdSLxYJXUfVBtOM7ndpa2JQM23diJx78zQB6tGNsmGyFM7+uCY=
X-Gm-Gg: ASbGnctBoSI226+qjYj6Z0OJUJRCRrR6VfvgqmLaExy+bfy7uUUIkygADv9TkljctVV
	i3WTr9CMnD2FEL9eZt9eOybOYd3yZTBue+8z9/lqbQIigER5G8CaXzOr5vUr4fcCqFHMHhS2yVJ
	jedj15UsYjyahl3ucx9dG+FsgC+il/HD1wKzjHjOTOD+P6zfLDS3L8ikCpUeMHklYaQGn5zmWuM
	GVRGytzTbfIfTayazs8oKKR0XqTMNU9sWCc3J/Z3VohWDcN7Q2DmgLqxbbxqWq0KDVJ3rwa/G5D
	bFajgNgztqPowwACFC/X0Be9KK4zIMPHoEzS9gCizW18aLNvbju8PnC0VbpKb5dmFNuLuhiDP9t
	Lawy/x+dvpOxv4HLVtVZm7X+Y7lM=
X-Google-Smtp-Source: AGHT+IFKmw7v+ViT8cC8n71RStzPIt3fAok0oSUJk+oz7azFYymuB/3CTMgTbPUStv8Rn2xHhfsY5Q==
X-Received: by 2002:a05:600c:4fcd:b0:459:dfde:3329 with SMTP id 5b1f17b1804b1-45b4d854105mr19045205e9.31.1755769511864;
        Thu, 21 Aug 2025 02:45:11 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4dba004bsm22126335e9.24.2025.08.21.02.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 02:45:11 -0700 (PDT)
Message-ID: <751030d7-444e-46e6-b56f-0b72206969fc@linaro.org>
Date: Thu, 21 Aug 2025 10:45:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/28] coresight: etm4x: Always set tracer's device
 mode on target CPU
To: Leo Yan <leo.yan@arm.com>, Levi Yun <yeoreum.yun@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Yabin Cui <yabinc@google.com>, Keita Morisaki <keyz@google.com>,
 Yuanfang Zhang <quic_yuanfang@quicinc.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>
References: <20250701-arm_cs_pm_fix_v3-v2-0-23ebb864fcc1@arm.com>
 <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250701-arm_cs_pm_fix_v3-v2-2-23ebb864fcc1@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 01/07/2025 3:53 pm, Leo Yan wrote:
> When enabling a tracer via SysFS interface, the device mode may be set
> by any CPU - not necessarily the target CPU. This can lead to race
> condition in SMP, and may result in incorrect mode values being read.
> 
> Consider the following example, where CPU0 attempts to enable the tracer
> on CPU1 (the target CPU):
> 
>   CPU0                                    CPU1
>   etm4_enable()
>    ` coresight_take_mode(SYSFS)
>    ` etm4_enable_sysfs()
>       ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
>       			                /
>                                         /  CPU idle:
>                                        /   etm4_cpu_save()
>                                       /     ` coresight_get_mode()
> 	       Failed to enable h/w /         ^^^
>    ` coresight_set_mode(DISABLED) <-'          Read the intermediate SYSFS mode
> 


> In this case, CPU0 initiates the operation by taking the SYSFS mode to
> avoid conflicts with the Perf mode. It then sends an IPI to CPU1 to
> configure the tracer registers. If any error occurs during this process,
> CPU0 rolls back by setting the mode to DISABLED.
> 
> However, if CPU1 enters an idle state during this time, it might read
> the intermediate SYSFS mode. As a result, the CPU PM flow could wrongly
> save and restore tracer context that is actually disabled.
> 
> To resolve the issue, this commit moves the device mode setting logic on
> the target CPU. This ensures that the device mode is only modified by
> the target CPU, eliminating race condition between mode writes and reads
> across CPUs.
> 
> An additional change introduces the etm4_disable_hw_smp_call() function
> for SMP calls, which disables the tracer and explicitly set the mode to
> DISABLED during SysFS operations.
> 
> The flow is updated with this change:
> 
>   CPU0                                    CPU1
>   etm4_enable()
>    ` etm4_enable_sysfs()
>       ` smp_call_function_single() ---->  etm4_enable_hw_smp_call()
>                                            ` coresight_take_mode(SYSFS)
> 	                                    Failed, set back to DISABLED
>                                            ` coresight_set_mode(DISABLED)
> 
>                                            CPU idle:
>                                            etm4_cpu_save()
>                                             ` coresight_get_mode()
>                                                ^^^
>                                                Read out the DISABLED mode

There's no lock though, so can't it do this:

  CPU0                                    CPU1
  etm4_enable()
    ` etm4_enable_sysfs()
       ` smp_call_function_single() --->  etm4_enable_hw_smp_call()
                                              `coresight_take_mode(SYSFS)

                                          CPU idle:
                                          etm4_cpu_save()
                                            ` coresight_get_mode()
                                           ^^ Intermediate SYSFS mode

This is why I was voting for changing the compare and swap mode stuff to 
spinlocks so we can be sure it's correct. The lock shouldn't be released 
until the mode is at its final value.


