Return-Path: <linux-kernel+bounces-729970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A97EAB03E70
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1031A61869
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B6247DE1;
	Mon, 14 Jul 2025 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v2wYO0fN"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEAE246BB3
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495302; cv=none; b=hKl7s21YzRwEDDxaMGWQl4Pmbm69Zl2eF0aj1p1S2C8zk2fA5aMBSICUCrUZg1eH3EDjh0rkhyF8AIaGaNax0EsVOAlaZcvb5BbbwaoRdM7qDjL7CSMtUBi+LBHmCDE4hb/4b3XLN27W0YAHLKqmo9bBxehmWLBRlL8rkSERBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495302; c=relaxed/simple;
	bh=BYzBPfh/ytviOirTkWz4504u4O0RE0FqexEQaYlECV4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NFXopRAKZDATqgDgWwUeH5jhZqp1Ha1wXhaHFST4eBHYC3dHfHXJXMB3AxOFgsAR1kg74Q0HNLevGAVZSzoOvV2i+L6ztL9Th28dvg/2qseFJiOwB7thgj5Bux+pc7DIsNjbsgnuAfOSXnn5yZb5Siris4TxcwYcp0SB3j0LdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v2wYO0fN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae401ebcbc4so753811666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 05:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752495298; x=1753100098; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KsBsNedKx8xGt4I6WaKkCB8jsWquCjMbNNOAEnJdX54=;
        b=v2wYO0fNllNinMF0JVTpFgsGwXhvAhLR61DG4MT/u45zZNwrxwuB60jlY4wLD/fj3n
         ZvWFEkCJ4B1nkN4dKfkN/fwsZq8nslmSVj2IfFDXhA8LSlYZpVwZY9O6raWY9f8MJqXL
         hsdbC7DvQ7Xuk2anEUL5Y6ct9g/WgjVUI+8mx2nXe6VwdZcVDHp4B7nyCYjKM3OnrIzW
         Z28LHVrZsA55p/l+Ut10S9olhI83ypopN8AZxRS7zLYm9A41yaCqaIXpqX6i3gmegcon
         rAnYlX8zZVYW4W2S/cEZ7ilhmgKGxMWByOldsLVuOLU8pmW0+hiGKjFhuUP4ArfBOn2H
         VuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752495298; x=1753100098;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KsBsNedKx8xGt4I6WaKkCB8jsWquCjMbNNOAEnJdX54=;
        b=mYnpYlxHDuDycN8/ngReRwM65rIK/DwR63Cr6BnWZo+6r1vwGBz1K1+YifnVENgkvE
         Ig/fe35ysPbxLSFHVDhD3ScOyUXnK1lte2DvFvu0ZSzAIWuLHDCVns9N1AoU28A1s9XU
         KwLwh91ngkrl1BpnxVT9dNcHeylEdIGVpRT2O1S4zi3wplNybnFWfiq4iGHztXC9XYFG
         wp02GONyMetBc8GvdvblITWIvOrDcU/EXi5AM1bpJ5eCiPr03zye4eqVO5SW/8ZbpTar
         XxFDakFObY+mlRaHBx/xlpnw36EkOG3rkXhzEoBQXGGo6tT0QQj8qY3I6BVP0mxw/wln
         9UTg==
X-Forwarded-Encrypted: i=1; AJvYcCW+w/Phh/FwArx30hGXaKsdf8uAm57z0kkRrHqBF9pZSrsNtIGl7PtD/bsdc7jFmI04ROCNgWCkZCz2AQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwokWrHAFDzuHQlrBT7Irv3/tyP0/OPyP8QQ5JnuI4uBF85A0Wb
	sRHVFvkRV9b+IeV8KkNxQ39EAtC2zrDUzrEdukxjhKpHxNwbEf2iOlk0U+3IkcySW4g=
X-Gm-Gg: ASbGncs0CTfoGKwLy0VFFi27LXQps6f2NsrOMb5acOm0RbJjPj5trMaDg5ZkoY3T52z
	FibeQ4mV+h1hHb0dS/LTCGvqchbrIkiZ2nRNWi2kuTOukrzsITr5Oh2XRjdBxCXIH9o4+V51ffT
	7mt/+itgKrpAtyMzuhMa71Q+IOENoXBQiHYYSUOICJOp5bE1+MZJFftyrQUaDbkyVl6kyIYT1+g
	ZXyWHYPpFwKfHU44kPPL2lKWAdefH61nccqo1CJiC0YVeWjn5nqz7jhzCFRJih81gzwIJrpS8Xy
	niIHaDllT683roC2yguXDB2alDTToBlaNcwAzGQ1ODOctH7Su2v8rbCmYbYxIrEKvVQlEQi8jdw
	H7ar6pt6FDZmnkfEWlAeTThutTS8qcmyu
X-Google-Smtp-Source: AGHT+IG5VtsLFvFUDT520ex2RKhAB9eBro+IUiGxHRhjbk7jTorQ4ULKI2K0vvCF0z4O054xQO9Yxw==
X-Received: by 2002:a17:906:9c82:b0:ae3:6bb4:2741 with SMTP id a640c23a62f3a-ae6fbfa7d75mr1203346566b.38.1752495298018;
        Mon, 14 Jul 2025 05:14:58 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7ee4607sm827250566b.57.2025.07.14.05.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 05:14:57 -0700 (PDT)
Message-ID: <30a08478-824b-4ac5-91e7-c985adcf4d09@linaro.org>
Date: Mon, 14 Jul 2025 13:14:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
From: Tudor Ambarus <tudor.ambarus@linaro.org>
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
 <7186da1f-4d16-48f5-bdc0-cb04942b3a5e@linaro.org>
Content-Language: en-US
In-Reply-To: <7186da1f-4d16-48f5-bdc0-cb04942b3a5e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/14/25 11:35 AM, Tudor Ambarus wrote:
> 
> 
> On 7/14/25 8:29 AM, Rafael J. Wysocki wrote:
>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>> index d9d4fc58bc5a..0e186bc38a00 100644
>>> --- a/drivers/base/power/main.c
>>> +++ b/drivers/base/power/main.c
>>> @@ -1281,6 +1281,27 @@ static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
>>>                 dpm_async_with_cleanup(dev->parent, func);
>>>  }
>>>
>>> +static void dpm_async_suspend_complete_all(struct list_head *device_list)
>>> +{
>>> +       struct device *dev;
>>> +
>>> +
>>> +       pr_err("tudor: %s: enter\n", __func__);
>>> +       guard(mutex)(&async_wip_mtx);
>>> +
>>> +       list_for_each_entry_reverse(dev, device_list, power.entry) {
>>> +               /*
>>> +                * In case the device is being waited for and async processing
>>> +                * has not started for it yet, let the waiters make progress.
>>> +                */
>>> +               pr_err("tudor: %s: in device list\n", __func__);
>>> +               if (!dev->power.work_in_progress) {
>>> +                       pr_err("tudor: %s: call complete_all\n", __func__);
>>> +                       complete_all(&dev->power.completion);
>>> +               }
>>> +       }
>>> +}
>>> +
>>>  /**
>>>   * resume_event - Return a "resume" message for given "suspend" sleep state.
>>>   * @sleep_state: PM message representing a sleep state.
>>> @@ -1459,6 +1480,7 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>>                         /*
>>>                          * Move all devices to the target list to resume them
>>>                          * properly.
>>> @@ -1663,6 +1685,7 @@ int dpm_suspend_late(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>>>                         /*
>>>                          * Move all devices to the target list to resume them
>>>                          * properly.
>>> @@ -1959,6 +1982,7 @@ int dpm_suspend(pm_message_t state)
>>>                 mutex_lock(&dpm_list_mtx);
>>>
>>>                 if (error || async_error) {
>>> +                       dpm_async_suspend_complete_all(&dpm_late_early_list);
>> -> There is a bug here which is not present in the patch I've sent.
> 
> My bad, I edited by hand, sorry.
> 
>>
>> It should be
>>
>>         dpm_async_suspend_complete_all(&dpm_prepared_list);
> 
> 
> Wonderful, it seems this makes suspend happy on downstream pixel6!
> I'm running some more tests and get back to you in a few hours.
> 

Solves failures on pixel6 downstream:
Reported-and-tested-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Thanks!

