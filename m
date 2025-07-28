Return-Path: <linux-kernel+bounces-747684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0195B136C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1C56188B855
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9509423535A;
	Mon, 28 Jul 2025 08:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmpKUwyj"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBC71A23AC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691523; cv=none; b=koN3/n7lERUtyc81qwMxX1kEhQc72WPtFWn/T9tQhl9xOUUag49sTgRhxxIBVVrziJ72pjkElPl5ZeId7Y6QWW7L9jMOUek0xm5d8BJWlPZmtLDmawwNQ7Gl7Gsnct+b6WxucHgFosJWxGY22062wV+P01iNU2xxPlKbHta4Z78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691523; c=relaxed/simple;
	bh=D7pfw83HKjmeYSbCg9q/HWCeeMtzQpB4wfkfixOnxIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJANZimbvfOQzlr1B54e4NnakXj+d1w4mMf0ILnFGWFRVLeoydvS8aE6vDWAK1cQ1z1M0QPAkDfYkfs1qbylvrjpqt6lShPDyG20wHMt1cljATjDG/wRobx+A3eOaNyj6+6SPUgX+V5wiIzToOTI9tgV5yutvqEAVfEOalUZBwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PmpKUwyj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4563cfac2d2so44091305e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753691520; x=1754296320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CTRs1zuaDG/eDPc9Bkp/G1YcBLDCJtrXRmfR3K8EioE=;
        b=PmpKUwyjECz1rqv2LSUqjCjb1wF9aCQvT2/udzDmOhlizQ6pLsCYzUtAzUYGGSnnKX
         LTetmfDHgrpGoXyOOw9GPR2y4u8zHUpciw48yX5DGFin+LansiGwiHtt+k0WrZAFmNK2
         EnaKxRZBNlWbPd+uVILyiVoIWJFOgwKgGOaTEy4tz0kEr27zBBtq3V5zqVC9pmo32Irr
         UOaNBqrNxTmAsF2zGZUZLgFyGz0NMzSh5DhlxmQvW2bvh12xjAc7ij2HoYMerImIQiuq
         MxIE1QV9vOnYCMh/+9UcMZSu44Acq3jQ0ufCD298SQtvOsJ5iB1eFGzsZI/vtmIHKE2w
         ISrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753691520; x=1754296320;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CTRs1zuaDG/eDPc9Bkp/G1YcBLDCJtrXRmfR3K8EioE=;
        b=pDs9CKM7X8cuGj+HwKeC9a7FfSumW5lM16B7G5fgYSa7phQ3U/JnKUQ23qCo7pINGr
         tHoZJaK9RxyHhdmym7v82FfmwGXLRWIPwH3FFrw6p2q3KRTICST8AESYPrXt39FXUXE2
         QQ4lmLuOAs62/kNs3B04NMpE/Z+ey+Ih6aRCgRmRTzGW9bCXZSu/bDnWHcHJdV/d/kaQ
         Yw/xaxx4gsNNd3LmHDQIBjLsLIHmrwIUor6OyZRtSzJqxqumLueQjzr6iZHw4C4OCsfs
         z4j3uCe3a3QHJVDASoPQ70bwkuXNiYWKyd4wokfEw/u82NhM/9n7JpAFd+nMJLA9nD/W
         8clg==
X-Forwarded-Encrypted: i=1; AJvYcCUP6l2JdEX4AGXFVww2n5r5pcJWOLFUCUbEaEs7VT5giBWOSP38enRXsTrqE4tCaoIAfpkbXIQcnZpTIdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JOodx8w5uwinuHCxL9Gcg3QuNw3Jg9k96yD+kd8015N+XyLN
	4RPwAnE8rBL+ilM0VKFiazWwhsWWfYO9RvYHn4j4lE4ogL0XCq4GR88D1PUwfCp74b8=
X-Gm-Gg: ASbGncvN/3dLtNKlodNeIKA/D9Sj9vVZRRIudIPWI7QPGxDr77F6XLum4C8icCHbDdf
	7zuyLfNKkBgyAaPUYKE0kIREtmOo307jbJUo5hFGTTmnudBqBUPb1gNW0sshtpCbN5esALtxjZW
	2S9yuTEnIozN9z/9znYIjgijoIDPj8147ckpH0k0dfZxYvq2sEMV840Gej/K/Ny2cPTPIt7bFTV
	qx1XO7zuxcOS3uxdidbp8bvsPdAZoFItR9hGgG7vNOiLzdunGwj21/CYHa7/ettrzWSzmgwrpsB
	ZtKhHuuiG/NB2dtpIEug5Tzq8Dj33sc08IYa1VTwjXAmsbUMqijouVbEDY4hVViJdJjSRCLJKJt
	BYln3BFGFYtzbb9NeMsvTKcuHenc2lWH1rhUcGxj3YZw1/xbl6BtAdy7b6BcqRQ==
X-Google-Smtp-Source: AGHT+IGmBCvpjMes/urRtuq4upKfeVU6jjvOk5RpZhkKZnjMUdjkeQMnkRUGIBkdwvVR89mnD8GGJQ==
X-Received: by 2002:a05:600c:1c94:b0:456:1442:86e with SMTP id 5b1f17b1804b1-4587911e78amr65369135e9.21.1753691520025;
        Mon, 28 Jul 2025 01:32:00 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-458705bccc5sm146250205e9.22.2025.07.28.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 01:31:59 -0700 (PDT)
Message-ID: <52c93bb5-d114-4be2-864e-87e9efee3cec@linaro.org>
Date: Mon, 28 Jul 2025 10:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] clocksource/drivers/nxp-pit: Add NXP Automotive
 s32g2 / s32g3 support
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250705160129.3688026-1-daniel.lezcano@linaro.org>
 <20250705160129.3688026-19-daniel.lezcano@linaro.org>
 <9a16e06c-c96f-4a86-a017-b02e8f067498@oss.nxp.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <9a16e06c-c96f-4a86-a017-b02e8f067498@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/07/2025 14:02, Ghennadi Procopciuc wrote:
> On 7/5/2025 7:01 PM, Daniel Lezcano wrote:
>> The S32G platform has two Periodic Interrupt Timer (PIT). The IP is
>> exactly the same as the VF platform.
>>
>> The setup found for this platform is each timer instance is bound to
>> CPU0 and CPU1.
>>
>> The changes bring the support for multiple timer instances. When we
>> reach the maximum PIT instances for this platform, which is described
>> in the match table data, the hotplug callbacks are called where they
>> finish the per CPU setup.
>>
>> Tested on a s32g274a-rdb2.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
> 
> The current description does not clearly explain how the resources are used within the driver. It would be helpful to mention that channel 2 is used as the clocksource, while channel 3 is designated for clockevents.

The changes are to allow to support multiple instances of the PIT timer. 
The way the channels are used is unchanged. I can put a sentence to 
remind how they are used.

> Additionally, the S32G2 platform supports suspend and resume functionality. However, this capability is not yet implemented in the driver. Do you plan to include support for it in a future patch?

Yes, usually PM is added after.

> [...]
> 
>> -static int __init pit_timer_init(struct device_node *np)
>> +static int pit_timer_init(struct device_node *np)
>>   {
>>   	struct pit_timer *pit;
>>   	struct clk *pit_clk;
>> @@ -261,16 +296,31 @@ static int __init pit_timer_init(struct device_node *np)
>>   
>>   	clk_rate = clk_get_rate(pit_clk);
>>   
>> -	/* enable the pit module */
>> -	pit_module_enable(timer_base);
>> +	pit_module_disable(timer_base);
>>   
>>   	ret = pit_clocksource_init(pit, name, timer_base, clk_rate);
>> -	if (ret)
>> +	if (ret) {
>> +		pr_err("Failed to initialize clocksource '%pOF'\n", np);
>>   		goto out_pit_module_disable;
>> +	}
>>   
>> -	ret = pit_clockevent_init(pit, name, timer_base, clk_rate, irq, 0);
>> -	if (ret)
>> +	ret = pit_clockevent_per_cpu_init(pit, name, timer_base, clk_rate, irq, pit_instances);
>> +	if (ret) {
>> +		pr_err("Failed to initialize clockevent '%pOF'\n", np);
>>   		goto out_pit_clocksource_unregister;
>> +	}
> 
> This mechanism is very restrictive and will allow to assign the PIT0 and PIT1 to CPU0 and CPU1 only. Have you considered alternatives where the mapping is given as mask through early_param?

Yes, we can consider putting in place a mechanism to configure how the 
PIT are mapped to a CPU but that would be a separate feature to be added 
later.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

