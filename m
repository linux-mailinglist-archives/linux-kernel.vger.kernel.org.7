Return-Path: <linux-kernel+bounces-898852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97354C5625A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48BA73AE714
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C29331235;
	Thu, 13 Nov 2025 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GnK9AE/y"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30833120B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763020898; cv=none; b=gXqkZWmrpS/W7MqKm3iSwUuj0z9eIhCwQXxAuBmZnLhoXg5pUB7UHUpiw22QnCDNztMthTLT986t7aMP+c+Tj8oJTtzE7GkN9udorhM+UFu7OulrTab9Qao3cqtP5bl48JVG9cIHm05Vd5rO7L3Oma78OXJyyV32W6wee4UqJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763020898; c=relaxed/simple;
	bh=YFib5AM2YDHpEw3Y828tvstnd7oYrzk80+0Tk/DHGHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ayh/YPNVJdWk3DJP2zE2lVRLztWsf3s9Z8wb18xBAU6V08MgieSh3JjM0pV1wvi7PkA94Aj9NysGwPuhXjgfkJ2A9s2byLC88eCl1K1KbNOSR98zry5ZsV9/8r0ingn0r4kIPNcP84Usmgagsp+0RoizV5jRK6Jp2dvlGiRrPXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GnK9AE/y; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710022571cso4723655e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763020894; x=1763625694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TKXpPbxSNO2sVb7821pvM7dsyeC1CYdB5v9NlDTIXY=;
        b=GnK9AE/yOlq31IrwUr8Vrm9oQLaZbAhQ3HT+wHlUWAvsHikrzB4Sr8SfgndNeqcAKF
         PUo/f0SjdqIhYggqwFQ4uOn6hKR+CXkLZdmT0b9t7QqENiB14YkUBXIyMkXweYiZOjS2
         ryKnp5q5lbBYce+9ONtjjbV+zxsH+oQYBHX9JXG3dQFp6rBfxU74a/bRDmJeIf3Iyf3s
         nwu8WSXdudeEKYS6X1Si4hBEHXDiXlN0HQtfQcgZ73Rh2elvKyy1VdVKDaFWJWesccie
         YXPfvee9+i9IwyRHWjVvN5dSYgefN2qmyRQxGcR4fmuVEyh3MIz0hwNHVSfmRWOtYzXt
         8QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763020894; x=1763625694;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+TKXpPbxSNO2sVb7821pvM7dsyeC1CYdB5v9NlDTIXY=;
        b=bOEOQXD6W1zB8KSnQpbd60aiFBwO8dgT6jQvgYZ/HTBDDfaV1+dW7MvULjvLCkfkh3
         7l8XxUrCfr7Oz3Uk3cYC1O2T9mfqvFUzUF36SXKuhDLxytsItt49IcWKWMNlD99ndojw
         udx58DocEBorBzERQHvksD4HZTsS1uy47uaCrHZGgCgiN8psz1b5tHPvgnj0vilqm1ud
         tm5rRjIOq1GGGEwcE8adNVNX7qSpl25Us/KDjWalthA3OSHiD8O5NVTl63SUHeAgIbpF
         4oK7Y/t3QvbYEH+vXEa2wJJ2N45O+CmgrWhWxbuEw7YhV9CvPoFPtIe9SSsRQSYXlqrF
         S2qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU20fhI6bLbxVi+52GKW6NWrJMAws55EOTh5PA96/12X6Ne8C4TzDkVYSeMQ8UrLLC31VO7iqvxDXJ2Lv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH7dAtckfxFlHkItIXw7VcA5GVqQFtyRwYtvOx8O3rxiwwJj88
	X7/jPpsczwsEplFs3uoQgCO0VaTeg7Nh8QwlABkj+hEjYSWkgBLk1VbD/9r69NptJSo=
X-Gm-Gg: ASbGncvyMXQYs3h/obAZfkC5X7FepOS42s18UqpxIWC/INguiELLP+9LqWCWVhuJ4XF
	MFYPUY1f+rPnP32W0jBuLjBnhJRlhpQwZF/8klB4jbhHWegmHHSgqT8PwXnBsbt8QMtS+MvoW6H
	s/fp39hEwsE7IGUAFfGZg3VyZHSlhu0wZ2cZNJtAO6RmNifQ2D2usQQoG5ORIueVStYQQ3P2KBW
	FBihW0oynskyQtWuFdmnIpujZCHtyyqWHb/X8OYREk/b7BvtpROFYtTbIX1R4WS60rzjZ9NTvjA
	jlyZaLCUqIGEcO86/4qNYE7b9fQakP794tcfCTnXevdkO8BuNAl5lX7IvnndKAFZicETzQ2phYm
	6bb3AohIF1nERxBlFVUbvT5UTSIvJK+2AEKumAB9DO1yMeO+i70/+0N/B4XkM6AwtJcNuJps454
	9mgIRbwbvC
X-Google-Smtp-Source: AGHT+IE8qQ+nj44APGWUeQOkc3VUh3xrQcYOiNRiBBkMDO6sDGxE8imI7u/StM+te/EnuRU4DeBwhQ==
X-Received: by 2002:a05:600c:3b11:b0:477:79c7:8994 with SMTP id 5b1f17b1804b1-477871c472dmr55301215e9.30.1763020893741;
        Thu, 13 Nov 2025 00:01:33 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm53136525e9.13.2025.11.13.00.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:01:32 -0800 (PST)
Message-ID: <5ead50cd-2855-4e46-8e9a-f0d7a16cc0ef@tuxon.dev>
Date: Thu, 13 Nov 2025 10:01:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Switch to
 SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: wsa+renesas@sang-engineering.com, p.zabel@pengutronix.de,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
 <20251008042526.3312597-3-claudiu.beznea.uj@bp.renesas.com>
 <CAPDyKFpFYeD9tLA+w4NARKq-Wj-7O2Caa3y8i2Z9NX6J4XLahA@mail.gmail.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <CAPDyKFpFYeD9tLA+w4NARKq-Wj-7O2Caa3y8i2Z9NX6J4XLahA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Uffe,

On 11/11/25 18:22, Ulf Hansson wrote:
> On Wed, 8 Oct 2025 at 06:25, Claudiu <claudiu.beznea@tuxon.dev> wrote:
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
>> and require __maybe_unused protection against unused function warnings.
> 
> I don't see them marked deprecated, is that really the case?

You're right, I got confused myself by some comments on pm.h. I'll update
it in the next version.

Thank you,
Claudiu

> 
>> The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
>> the compiler to see the functions, thus suppressing the warning. Thus
>> drop the __maybe_unused markings.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Other than the above, this looks fine to me!
> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 11 +++++------
>>  drivers/mmc/host/tmio_mmc.h                   |  2 --
>>  drivers/mmc/host/tmio_mmc_core.c              |  2 --
>>  3 files changed, 5 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> index 9e3ed0bcddd6..7ceb7b977a0b 100644
>> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
>> @@ -599,18 +599,17 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
>>  }
>>
>>  static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
>> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
>> -                               pm_runtime_force_resume)
>> -       SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
>> -                          tmio_mmc_host_runtime_resume,
>> -                          NULL)
>> +       SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>> +       RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
>> +                      tmio_mmc_host_runtime_resume,
>> +                      NULL)
>>  };
>>
>>  static struct platform_driver renesas_internal_dmac_sdhi_driver = {
>>         .driver         = {
>>                 .name   = "renesas_sdhi_internal_dmac",
>>                 .probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> -               .pm     = &renesas_sdhi_internal_dmac_dev_pm_ops,
>> +               .pm     = pm_ptr(&renesas_sdhi_internal_dmac_dev_pm_ops),
>>                 .of_match_table = renesas_sdhi_internal_dmac_of_match,
>>         },
>>         .probe          = renesas_sdhi_internal_dmac_probe,
>> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
>> index c8cdb1c0722e..b9de03325c58 100644
>> --- a/drivers/mmc/host/tmio_mmc.h
>> +++ b/drivers/mmc/host/tmio_mmc.h
>> @@ -209,10 +209,8 @@ void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>>  void tmio_mmc_disable_mmc_irqs(struct tmio_mmc_host *host, u32 i);
>>  irqreturn_t tmio_mmc_irq(int irq, void *devid);
>>
>> -#ifdef CONFIG_PM
>>  int tmio_mmc_host_runtime_suspend(struct device *dev);
>>  int tmio_mmc_host_runtime_resume(struct device *dev);
>> -#endif
>>
>>  static inline u16 sd_ctrl_read16(struct tmio_mmc_host *host, int addr)
>>  {
>> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
>> index 775e0d9353d5..8be642f737c7 100644
>> --- a/drivers/mmc/host/tmio_mmc_core.c
>> +++ b/drivers/mmc/host/tmio_mmc_core.c
>> @@ -1286,7 +1286,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>>  }
>>  EXPORT_SYMBOL_GPL(tmio_mmc_host_remove);
>>
>> -#ifdef CONFIG_PM
>>  static int tmio_mmc_clk_enable(struct tmio_mmc_host *host)
>>  {
>>         if (!host->clk_enable)
>> @@ -1331,7 +1330,6 @@ int tmio_mmc_host_runtime_resume(struct device *dev)
>>         return 0;
>>  }
>>  EXPORT_SYMBOL_GPL(tmio_mmc_host_runtime_resume);
>> -#endif
>>
>>  MODULE_DESCRIPTION("TMIO MMC core driver");
>>  MODULE_LICENSE("GPL v2");
>> --
>> 2.43.0
>>


