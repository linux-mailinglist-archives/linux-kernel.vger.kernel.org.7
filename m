Return-Path: <linux-kernel+bounces-744734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2586B1105F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B731CE771B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B7C2EBB83;
	Thu, 24 Jul 2025 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bCk4oPMd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0977080E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378221; cv=none; b=rlDWp9ywCMyYDVPdFc2vYuGzVYmrP3NmQgZVmTzY1Bbtx1FQhvxIyyfKdublVgTdDk9CB0cH06xJarrrk1bOhezoVabu23usyWXFya6Ru9gf9UIKnleDOAVriWcXb992irL1bSV/A5oeme/eNISnfRqUlLV3YefgTN8tHbR21bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378221; c=relaxed/simple;
	bh=n/yRoMBVruiSoYoCK/U33ZBz7igHyVL8eOotNuQwIGU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PknOwLU4tsmqsn6LSQ+xBSfzrJRwL/wkeEPNNIgwIysGvIIOr9VcSmq4jCRqzAHzJB8a6Jvy1bX74TFShWccl2Z2tLIjCY1ddeYBv+rsGgvw/R1+o1JupVyuVhGmM0Y/8YayiJCJMJUAVsNBAnlU8BMYJLxhaPyE8RMJN/PuVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bCk4oPMd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so13019995e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 10:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753378218; x=1753983018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRDmkY9eGDwzxZV/LM8RreRMUJLj0ybpp+/mfsooieA=;
        b=bCk4oPMdhwZM+4w0gFNRc9NXnffv0lw5jc4jMtXg/vUHdzkzaEovSYo5+AtwKYnl0Y
         mfw205QJZxF4CHw6Has/tCAwzMFhVamBP7yeTof3m+2F3GzLE1LU4OhXDHZ2huzdXlo+
         WM5fQ0yaJfVb6vRr/jWG/+h06FKp1QD/08GriRuxqjsCeGz0ica20kL8s3lpJvNkysjD
         ASOyqMp8hzRUA65BsMZzF+qbxaOn0XIGmv8XnozgQNY3pUR7uSSeXmlM4ai7Brl3/jkL
         uLrdv4wZKSA0BA6cKk210QhVq7K/7NvUmcSfpYJOW0Fj0/abFdsDN4LEH1nYilueTB8b
         LIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753378218; x=1753983018;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRDmkY9eGDwzxZV/LM8RreRMUJLj0ybpp+/mfsooieA=;
        b=gcphVaOO6W53AaXaPmrLLJxGYh8K6eV/DzOzei9xpa5wArdCeeLG3x8bdSF3V22l+H
         H8HZRv1bHwuoFVhu6fVbN2rjwGLC/R11qFEDwWo/1nId3k/rrQnslyFax3jkqdfHc4P0
         aarnRLoAn3m3nQuM1tbfHtwDDsKhD+N2WMlcySPSE3SCVlxdwps5k/V+aP8m19TY4kap
         lb6MFnaniGQkrQaeoa+zthbc66SK+G+/PN9t1yLkcrRMSjo61gBjHN2agvSvBScjlbiP
         g1SrRqjvFw3VHzb2pk/1+io7WxdVVtSKwCy1YSVMsVFe7oxbK5R2IcYITPoKdrowTCqj
         SKtg==
X-Forwarded-Encrypted: i=1; AJvYcCVTryJDWIswtb/MY1QMkzCrFRQm8kMpe3Oy+wszB6kYLfgnJlyeEMen3VuY558Be4651U8aLUuWS3xTz/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHMElgyi1X+y2zHisLENIZAQ5mg790yUYDFGz4ispAwmNppJhq
	YvInLYVJ1Bbpty8VUX63BbTX+v2bh96oJ2iQqshaB/HSNs83sm6Fe5vacU3+wEZG71A=
X-Gm-Gg: ASbGncvOgMivnMgW27b+GE0m7aU20J2JK1hj3pBkSl7eVGWF8JwT2WCTyeudUs7Adk+
	ZbIbTy7WLBONu+JRHppmKOI4okNFRMhZIXx0SBEWTzyvb87QW1RWKrSHy8IOLa7/qcdM2kVy8iZ
	vjVpZBqy0Xzesfe+IcUd+G1M9zgiSMCKbmWOcXyeCYZumiY8vQD7MaiTGKT3YMHceXtgAZ9Ktrn
	CZ72gTrA5Fh0y0FgdjXahkKJ8u6EQbQ7h+OCow9Kuw3yGkI3o++e+46cIU5V43pTcM4glWFC7fE
	rrxErNdINTggcExJL/BKuEDwPWzKARriw8y247sxeM5zrHIzn53VKPlmCO9mus2t0yaL1oaJZTO
	VLL0LSRMltKhZYGlAISkM2ocvHumem6PBLqWl+gvJCmfLWQLmUWZtuL+Kg7uokyh/iZobrh3E
X-Google-Smtp-Source: AGHT+IFWlcMFfRwLg0htN2DFOU/gpc+GQiYzgY939RL3SLCeRxPvmEY0SsYa2PMw5oDXQ/77GFCR4Q==
X-Received: by 2002:a05:6000:2dca:b0:3b5:f7a3:3960 with SMTP id ffacd0b85a97d-3b768ef9510mr6621943f8f.33.1753378217647;
        Thu, 24 Jul 2025 10:30:17 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b76fcad156sm2737477f8f.40.2025.07.24.10.30.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 10:30:17 -0700 (PDT)
Message-ID: <a2924ca4-81e7-4234-9c6e-aaf04c35fe55@linaro.org>
Date: Thu, 24 Jul 2025 19:30:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] clocksource/drivers/vf_pit: Pass the cpu number as
 parameter
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-5-daniel.lezcano@linaro.org>
 <5b096078-dea2-4136-b9a5-61d03ff89414@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5b096078-dea2-4136-b9a5-61d03ff89414@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 11:33, Ghennadi Procopciuc wrote:
> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
>> In order to initialize the timer with a cpumask tied to a cpu, let's
>> pass it as a parameter instead of hardwiring it in the init function.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/clocksource/timer-vf-pit.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-vf-pit.c
>> index 34edb23194c5..20f637c8e856 100644
>> --- a/drivers/clocksource/timer-vf-pit.c
>> +++ b/drivers/clocksource/timer-vf-pit.c
>> @@ -147,7 +147,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev_id)
>>   }
>>   
>>   static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *base,
>> -				      unsigned long rate, int irq)
>> +				      unsigned long rate, int irq, int cpu)
> 
> I noticed that cpumask_of() and get_cpu_mask() expect an 'unsigned int cpu' rather than an 'int cpu'. Would you consider updating the type of the cpu parameter accordingly?

Yes, sure



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

