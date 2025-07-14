Return-Path: <linux-kernel+bounces-729821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A36B03BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5323F1884D14
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9CE244697;
	Mon, 14 Jul 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e82JNUsr"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B651C5D46
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489363; cv=none; b=Zo7PGmhUjYInWQTvCJvSkCE/0gJ3Bkbk5In6QacThT4gBIYvsS/kiStKnSRxidKd9GY2Evj4RgIuN/m0f74kx0GZdsc6/z4XUj3UMaXEM6Lk6qLpENnc5ehRYodTxyqbbb0qpxBMiqaeSgpPZGfzfXFJnT3AYhbMnFB2z4LK7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489363; c=relaxed/simple;
	bh=94R/CNsAvVceT58hWwVo0TxguwEZWGooqC6rD1XcJVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZcR3bZQjv1aXnfGFokHOYsAuwCp0jZ3NmbKGKBVgkeXbEisHx5c418eF9hQRch6ACE6EKdqgGKg+6GkVOHGiLB1QP39aeaR8vF4QRVmquMRIY9+111CmAWaW8py3ODMIFD1U+9/Fk+GH9lmxJ0kVz2KfLDavOrKyZwfZW3+vIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e82JNUsr; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-607ec30df2bso8149973a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752489359; x=1753094159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHzOD3RpVjOUZUSkinK31z2xmSemdrgPuSeEWTG+rT8=;
        b=e82JNUsrJr5PDc1OQrZ8q2mDHNHx5creZmzb68VkyK1B5PCPI0aHh2g011fQHiwI4U
         bGH8bpn/MAFtN3W/qrdbPNP9BwF0QC7S3EeB9df1wF2LMnt1FxkqI7kGnXkzsNumKfDU
         uOglbSHy5iIKrGDLwXb7QtsfSAwkDUzNFlHXQrdrRBhgJGU74GKSEJbCL3CyYGajVyUY
         OBm+EL9zI9inl7Dh9yW0VWjdzBTzIpTh1M/uLUwoZsS3io/qOes7DkicKtFKv1h0wky1
         11Rdkq871dujp+p4FCQgEsuHhURvGSPfUE4rr1/lqVVNsX37W1oOuygZ2qxafA4uxj0h
         kWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752489359; x=1753094159;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHzOD3RpVjOUZUSkinK31z2xmSemdrgPuSeEWTG+rT8=;
        b=LY7w3SmvhnsT4kNbhbqj+FKMjmF2aDfkqgEZ2FmmCTpc1iOyHPiFgHli4/njYVK6+2
         44PgedE/q115XzOn1yc5UdMmTsD7vREnpV4yaeH1rbsdCQwJTIbFGfAETP19MtX44mHo
         Z+HbVScoHvl06dmIEtW9KHW7O9001AMc4YlkISNcNycP9c/PTBhSSOeIxOdMW0XX1F4b
         B3mD0W/BG79tUE8MBFkyDDUGl/NqRJL9Rl3t3VB9lwq6n6d86cqOPtraJOfd6Fvnjhu5
         zZ9Njk7FHteMAec0ue2IAmvSLNQ60QlONjxKM9YI7oRGOEllP17rgG6kl6t8x9ot+znO
         DV7g==
X-Forwarded-Encrypted: i=1; AJvYcCW0aXwUcym3iUwmcQdLCP307/hYb12JSnr1NVnVmDnFmpHGLKuWKuTmA7/1Ge0hnrrs8/PMnU3gJ++oX9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq/L0vP9l+CXKLh3r2laDvFdFKXafGkxLTJry4v/W8EaajzH5j
	tvO3y2Av8l0ZvZBrQ+BWD/6RiYY3Nxa2/z+ZvUxVYiK1blKzSs6WW3u9I/jpI7c9Xb4=
X-Gm-Gg: ASbGncuAyxWIKLbyOdTjxfwUiEfMKzXPAWJWiFd1aQELZugAmww1BRQ92GDsnIAsoGG
	6ATQRquPJ3rRCz9T67KKur+at1cd8kNwXDTYOhluEHuk+Fw5h0cNQBsrmzsSkTJi+V3Lm21UV8x
	Qc0RtjzfwJi0eCODJM7SEG6gKrHfxZxO70gWTa5qF9Fj0b3kcKlyAR7Ina+7vkiLW1Lka8LeDp9
	r13MMrJkoNCYCd7AC0+EH0/vAXbMmbnJI4O7E1zVVFFdsipxmrfHw/O6ft7bnTUtwlFXJ1ptVJb
	FmymQ2HkXfURAAO8SlsliZfLWAcv3U5RZC6K9VtJP3ZyjPDGJYAH+u+3o4KM/q133q6H/TaRq/P
	Ton3M18zk6lXUScQFfi0foRYidvKWIwkt
X-Google-Smtp-Source: AGHT+IEWM7xpTjyIWJctw5C17VQ6g2wMjwiF1ZUkbDf1k366SzU3jICj63GNJpd/07+BLZ85FDqxnw==
X-Received: by 2002:a05:6402:24c9:b0:608:176c:f139 with SMTP id 4fb4d7f45d1cf-611e760e496mr9464977a12.5.1752489358729;
        Mon, 14 Jul 2025 03:35:58 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-611c9528ae0sm5815303a12.29.2025.07.14.03.35.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 03:35:58 -0700 (PDT)
Message-ID: <7186da1f-4d16-48f5-bdc0-cb04942b3a5e@linaro.org>
Date: Mon, 14 Jul 2025 11:35:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>,
 William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
 <4677865.LvFx2qVVIh@rjwysocki.net>
 <ae6d65f7-990a-4145-9865-63f23518405c@linaro.org>
 <CAJZ5v0hatwNn_Qh7n7wjDyXDZK=L4vkB+aotZRfn4Zi21sGKxw@mail.gmail.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <CAJZ5v0hatwNn_Qh7n7wjDyXDZK=L4vkB+aotZRfn4Zi21sGKxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/25 8:29 AM, Rafael J. Wysocki wrote:
>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>> index d9d4fc58bc5a..0e186bc38a00 100644
>> --- a/drivers/base/power/main.c
>> +++ b/drivers/base/power/main.c
>> @@ -1281,6 +1281,27 @@ static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
>>                 dpm_async_with_cleanup(dev->parent, func);
>>  }
>>
>> +static void dpm_async_suspend_complete_all(struct list_head *device_list)
>> +{
>> +       struct device *dev;
>> +
>> +
>> +       pr_err("tudor: %s: enter\n", __func__);
>> +       guard(mutex)(&async_wip_mtx);
>> +
>> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
>> +               /*
>> +                * In case the device is being waited for and async processing
>> +                * has not started for it yet, let the waiters make progress.
>> +                */
>> +               pr_err("tudor: %s: in device list\n", __func__);
>> +               if (!dev->power.work_in_progress) {
>> +                       pr_err("tudor: %s: call complete_all\n", __func__);
>> +                       complete_all(&dev->power.completion);
>> +               }
>> +       }
>> +}
>> +
>>  /**
>>   * resume_event - Return a "resume" message for given "suspend" sleep state.
>>   * @sleep_state: PM message representing a sleep state.
>> @@ -1459,6 +1480,7 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
>>                 mutex_lock(&dpm_list_mtx);
>>
>>                 if (error || async_error) {
>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>                         /*
>>                          * Move all devices to the target list to resume them
>>                          * properly.
>> @@ -1663,6 +1685,7 @@ int dpm_suspend_late(pm_message_t state)
>>                 mutex_lock(&dpm_list_mtx);
>>
>>                 if (error || async_error) {
>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>                         /*
>>                          * Move all devices to the target list to resume them
>>                          * properly.
>> @@ -1959,6 +1982,7 @@ int dpm_suspend(pm_message_t state)
>>                 mutex_lock(&dpm_list_mtx);
>>
>>                 if (error || async_error) {
>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
> -> There is a bug here which is not present in the patch I've sent.

My bad, I edited by hand, sorry.

> 
> It should be
> 
>         dpm_async_suspend_complete_all(&dpm_prepared_list);


Wonderful, it seems this makes suspend happy on downstream pixel6!
I'm running some more tests and get back to you in a few hours.

> 
> It is also there in dpm_noirq_suspend_devices() above, but it probably
> doesn't matter.
> 
>>                         /*
>>                          * Move all devices to the target list to resume them
>>                          * properly.
>> @@ -1970,9 +1994,12 @@ int dpm_suspend(pm_message_t state)
>>
>>         mutex_unlock(&dpm_list_mtx);
>>
>> +       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
>>         async_synchronize_full();
>>         if (!error)
>>                 error = async_error;
>> +       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
>> +
>>
>>         if (error)
>>                 dpm_save_failed_step(SUSPEND_SUSPEND);


