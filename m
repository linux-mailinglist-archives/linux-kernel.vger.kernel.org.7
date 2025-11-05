Return-Path: <linux-kernel+bounces-886941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC6C37033
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1E45660A28
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6D93009DD;
	Wed,  5 Nov 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jDCjcipF"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A590F32E13D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360760; cv=none; b=Un+nYGd0F3kxMgToamjC034PiTvTA6BuEwJvwtKLQlj3exUY653+LdncDf49wR0xXhEJtioJYv4YYL0ZWEwZ5a71hPs9TxEc8HypZskGh3aG42BPgw/sORreFcZ4q/aa0wuATP+2kWnGyyZlRqs0bKRQY7I132lLd90iIIQ1+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360760; c=relaxed/simple;
	bh=RtdcZleg562HB1IKBfzH1CRAYXHe+ayzn3QiyTSYBgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tnHxh6PCZSf+ymxqoMb71tgJpFt/DxZbaa+HOflLPK+0IsIj6yEon18tDtjJN/6mDvvO8g35g/yU8V+8ZZhjcq8jYKrDDNmJmGEy6M+szRz0kJGAcSa7R3/YNHPTxkpBlTGQmMB6zwQ7TxloSt6bi4JPUZBNrjx1JxJxQL8eSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jDCjcipF; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4710665e7deso32325485e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360757; x=1762965557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6coJB5FIrKoPs69WVrPxR7daBhZI0zVIi12O0/0kVm4=;
        b=jDCjcipFDmsdp3g/k4gfsx2xGHUuKxsZRx6WJBlXRitQb/6QxkXCcFfdwKwFUHrbPJ
         qeSzyS3VhvNy+p00GUk7JK3OqHk4909tYXSMD54HtYwFhFNtdoZTYtWJZ/ylFRxrPO3M
         /aul8I+mINYVsGPFPgMpzolMNbI5lJyaWTqd2lTNW+PjQ1/T5+xreee6v77FIklauHw+
         /zyLqBdceHHuN7n3FSqqpkh4YFEROYzNheQTXxf/0Hd/h1Cw+oD6+XvNYdfOt1B7cdMR
         ze9MmTe4Fr6CseTCVIQyvpW+tT9XAOGb+E5b17QxVa7mAkW96ZCp05kVhC7NyHRO6aBQ
         vc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360757; x=1762965557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6coJB5FIrKoPs69WVrPxR7daBhZI0zVIi12O0/0kVm4=;
        b=LlJqdKegVgc8ix6s9BuLYdg00bcFBfswQsdi24O/a78RlZWmmTodE1EpcAQyugEoML
         uZDmtUAEiOFKk76NFHyzINBoM9/0kyyfU8WUdRa4baAtOjRouBNPXDWK7/I9sejZPnG9
         3LKsMKjQBMgcCIoGpQgU7a7YV/eQNwmYHRh+ENLK+UruGxgMk7egb/RC1UWY5U1nFeYM
         2X0qbQrbTdU20pq3xiF3DU+qyou+MTVKOMNFUHl3ecB55cwRsZpqgdptPcfCOU1c23DK
         r7OegTiUAlfNWqpNRPYBR3GDkc+FqljozVn4mm9RjMp+V3BWSJ/cVZFQKSOOulzItfP9
         9xug==
X-Forwarded-Encrypted: i=1; AJvYcCWcivuMHALcZimJ47zhzI1brJIEgeUARMqjBfyKz0pkawGmqvU2e1iFp3Ul2CNm22rweGxmBM4jc/pixbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBajfK5Cr7PV/+FKvFIEwVkSM4vRf4El92GKYUoh/niEaLkRyx
	Lm6EvlkDm5YC6iF126bETv+7BSEk5P7I+27CO6Oc1nEYkcQE5DTwTpRNu0hABGHjU88=
X-Gm-Gg: ASbGncso1vfWnBrh1Q+ZTDidVXdqEIYjQbq3zQ6bDIGHVPAMCwKIoOAOGxnuQx4kPNN
	Y8TIdEKEDKj3dfmteChgMAwSoJqgORRix5a62s7v0N5irXPMu4OKdQ30Vf3J4lXS0ZftzFC26GO
	l+jpD1Y668x+8ODPFrKpPXNB6SW1lDZRBl0wpRduCYZ4KiRLHkAzuRNkLd108At2pt3vpbUchSs
	p9kcxrbbH6OzyloKNU+0E1M8Jn/YK+KhhDZfuDgQ0A0xPeabnnTEDcNbHEUGzVusBYDa/jahrnn
	DB2cOavCOEAK3eJSSSsnYJqGm8d1fdTZj5JFYSFcyFpwjBd3XwOjxGowEy5KJI5kWevA9b99Pzp
	wHpypHeGwt8rhDsUoFs3/9/H0dS03aqzPdgJobuhZo8Jwjmn1X2u9jE+rC6SMO14Qp9JWa8J3Xv
	Na7kSLeknHNARBa+S3AQYw/ZrbiR7LlczgpKSwlOc+AWCmB3o=
X-Google-Smtp-Source: AGHT+IGKn9VjDmuchF50NhQmU9mYE2Yck3wWRt8JlnYOZfg/al72/4vJ9FLsGjEMxlxPqq49jUr7Xw==
X-Received: by 2002:a05:600c:821b:b0:471:b5d:2db9 with SMTP id 5b1f17b1804b1-4775cdf26edmr39700985e9.21.1762360756845;
        Wed, 05 Nov 2025 08:39:16 -0800 (PST)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc528sm57365575e9.7.2025.11.05.08.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:39:16 -0800 (PST)
Message-ID: <ae167c7f-c32f-422b-9eb2-72889cbafef0@linaro.org>
Date: Wed, 5 Nov 2025 17:39:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clocksource/drivers/sh_cmt: Always leave device
 running after probe
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <20251016182022.1837417-1-niklas.soderlund+renesas@ragnatech.se>
 <c07ae384-4042-43f4-b876-7207b72260f7@linaro.org>
 <20251105160627.GA3684509@ragnatech.se>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251105160627.GA3684509@ragnatech.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/25 17:06, Niklas Söderlund wrote:
> On 2025-11-05 16:36:15 +0100, Daniel Lezcano wrote:
>> On 10/16/25 20:20, Niklas Söderlund wrote:
>>> The CMT device can be used as both a clocksource and a clockevent
>>> provider. The driver tries to be smart and power itself on and off, as
>>> well as enabling and disabling its clock when it's not in operation.
>>> This behavior is slightly altered if the CMT is used as an early
>>> platform device in which case the device is left powered on after probe,
>>> but the clock is still enabled and disabled at runtime.
>>>
>>> This has worked for a long time, but recent improvements in PREEMPT_RT
>>> and PROVE_LOCKING have highlighted an issue. As the CMT registers itself
>>> as a clockevent provider, clockevents_register_device(), it needs to use
>>> raw spinlocks internally as this is the context of which the clockevent
>>> framework interacts with the CMT driver. However in the context of
>>> holding a raw spinlock the CMT driver can't really manage its power
>>> state or clock with calls to pm_runtime_*() and clk_*() as these calls
>>> end up in other platform drivers using regular spinlocks to control
>>> power and clocks.
>>
>> So the fix is to remove PM management in the driver ?
> 
> Yes. As I understand it we can't do runtime pm in these drivers as the
> core calls into the functions with the raw spinlock held. I hope we can
> improve this in future.


IIUC, the changes done for PREEMPT_RT prevent to use pm_runtime by 
functions running in atomic context because the spinlocks are actually 
mutexes.

But if PREEMPT_RT is not set, then everything is running as usual.

This change drops the PM while it should be working for kernel compiled 
without PREEMPT_RT.

I suggest to handle the case with/out PREEMPT_RT.

Hopefully pm_runtime will be fixed with PREEMPT_RT and you won't have to 
reintroduce pm_runtime in this driver but just remove the PREEMPT_RT case.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

