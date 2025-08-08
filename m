Return-Path: <linux-kernel+bounces-759866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D1BB1E3B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C116CA00CCC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608022264B0;
	Fri,  8 Aug 2025 07:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hDtRN5GE"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E472253EF
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754638824; cv=none; b=qptnJwmrQxY15YEv2snvN1XqhedJVUMA5j6AUD4COwKyS1naftTVTjYEmpNp8J7Qh9f0QKWftQUnLlFFHt6GwrTDUfstdM1HPwSxreS9lJXc2/XKLV8vlgy+iYm6FMExeZzdImC9X53AuER7ljMIO7D+qnlxbvvyQRF92rAB5KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754638824; c=relaxed/simple;
	bh=0CJdrNdF/J7dSLaVVgjnZq9LY+7UMUxa0Z4f3duokl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RKBOeG7OuHTgh3BtESTVwBHExoaxlrGPY89lsQcNf81K4yW4Ft3dVUpmNTe2QNz0lTJfB3mzOOPWcjvyBg1Tgret4qupZV941rQAwvGLEZKnGLGX4QJwiY7eF15iZ8CCeHx4kHJfnM22hVkL30c/Kx40+Y5xyYzrPzBkwL6QqTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hDtRN5GE; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5787eJ6k993953;
	Fri, 8 Aug 2025 02:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1754638819;
	bh=fbq4GWB6PGw9ZLuAayT1AdJta3+LpobPBJuh8fSaS6o=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=hDtRN5GEzXjD2TPKaB2YvBneqHvLU+jxdEX4bp2DQtdV4S4e/q+TSOobnVb+AbwCy
	 MfYV6ao/I/BDrsJdyMvTcBKZFlql87PYzDdGqM5Tn1rhg2JkQ5FS0gVsd6X/PWnj6P
	 IHTTHajz8VzS8oZq6YWnmQMEN969pdrWtz3t94AI=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5787eJPA316641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Fri, 8 Aug 2025 02:40:19 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 8
 Aug 2025 02:40:18 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Fri, 8 Aug 2025 02:40:18 -0500
Received: from [10.24.68.171] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.68.171])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5787eGji2394998;
	Fri, 8 Aug 2025 02:40:17 -0500
Message-ID: <4eda7d2a-3e44-4278-88eb-3ffcc4c7081b@ti.com>
Date: Fri, 8 Aug 2025 13:10:16 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-ti-dm : Capture functionality for OMAP
 DM timer
To: Andrew Davis <afd@ti.com>, <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        Gokul Praveen
	<g-praveen@ti.com>
References: <20250807123229.232771-1-g-praveen@ti.com>
 <7c50613c-e48b-4e94-8fae-bf5d2227df0b@ti.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <7c50613c-e48b-4e94-8fae-bf5d2227df0b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Andrew,

On 07/08/25 23:07, Andrew Davis wrote:
> On 8/7/25 7:32 AM, Gokul Praveen wrote:
>> Add PWM capture function in DM timer driver.
>>
>> OMAP DM timer hardware supports capture feature.It can be used to
>> timestamp events (falling/rising edges) detected on input signal.
>>
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>> ---
>> Precondition : Before calling driver API,it is assumed that the
>>                 capture signal is active else both duty cycle
>>                 and period returned by driver will not be valid.
>> ---
>>   drivers/clocksource/timer-ti-dm.c          | 127 ++++++++++++++++++++-
>>   include/linux/platform_data/dmtimer-omap.h |   4 +
>>   2 files changed, 129 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/ 
>> timer-ti-dm.c
>> index e9e32df6b566..a4bf72c850b5 100644
>> --- a/drivers/clocksource/timer-ti-dm.c
>> +++ b/drivers/clocksource/timer-ti-dm.c
>> @@ -31,6 +31,7 @@
>>   #include <linux/platform_data/dmtimer-omap.h>
>>   #include <clocksource/timer-ti-dm.h>
>> +#include <linux/delay.h>
>>   /*
>>    * timer errata flags
>> @@ -836,6 +837,49 @@ static int omap_dm_timer_set_match(struct 
>> omap_dm_timer *cookie, int enable,
>>       return 0;
>>   }
>> +static int omap_dm_timer_set_cap(struct omap_dm_timer *cookie,
>> +                    int autoreload, bool config_period)
>> +{
>> +    struct dmtimer *timer;
>> +    struct device *dev;
>> +    int rc;
>> +    u32 l;
>> +
>> +    timer = to_dmtimer(cookie);
>> +    if (unlikely(!timer))
>> +        return -EINVAL;
>> +
>> +    dev = &timer->pdev->dev;
> 
> Do this assignment up where the var is declared
> 
Actually the timer is initialized after that in the to_dmtimer function.

So wouldn't initializing the 'dev' variable before that cause issues.

>> +    rc = pm_runtime_resume_and_get(dev);
>> +
> 
> Extra newline, fix this everywhere
> 
>> +    if (rc)
>> +        return rc;
>> +    /*
>> +     *  1. Select autoreload mode. TIMER_TCLR[1] AR bit.
>> +     *  2. TIMER_TCLR[14]: Sets the functionality of the TIMER IO pin.
>> +     *  3. TIMER_TCLR[13] : Capture mode select bit.
>> +     *  3. TIMER_TCLR[9-8] : Select transition capture mode.
>> +     */
>> +
>> +    l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
>> +
>> +    if (autoreload)
>> +        l |= OMAP_TIMER_CTRL_AR;
>> +
>> +    l |= OMAP_TIMER_CTRL_CAPTMODE | OMAP_TIMER_CTRL_GPOCFG;
>> +
>> +    if (config_period == true)
>> +        l |= OMAP_TIMER_CTRL_TCM_LOWTOHIGH; /*Time Period config*/
> 
> Add space around /* xxx */ in your comments, do this everywhere
> 

Sure Andrew.

>> +    else
>> +        l |= OMAP_TIMER_CTRL_TCM_BOTHEDGES; /*Duty Cycle config*/
>> +
>> +    dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
>> +
>> +    pm_runtime_put_sync(dev);
>> +
>> +    return 0;
>> +}
>> +
>>   static int omap_dm_timer_set_pwm(struct omap_dm_timer *cookie, int 
>> def_on,
>>                    int toggle, int trigger, int autoreload)
>>   {
>> @@ -1023,23 +1067,99 @@ static unsigned int 
>> omap_dm_timer_read_counter(struct omap_dm_timer *cookie)
>>       return __omap_dm_timer_read_counter(timer);
>>   }
>> +static inline unsigned int __omap_dm_timer_cap(struct dmtimer *timer, 
>> int idx)
>> +{
>> +    return idx == 0 ? dmtimer_read(timer, OMAP_TIMER_CAPTURE_REG) :
>> +              dmtimer_read(timer, OMAP_TIMER_CAPTURE2_REG);
>> +}
>> +
>>   static int omap_dm_timer_write_counter(struct omap_dm_timer *cookie, 
>> unsigned int value)
>>   {
>>       struct dmtimer *timer;
>> +    struct device *dev;
>>       timer = to_dmtimer(cookie);
>> -    if (unlikely(!timer || !atomic_read(&timer->enabled))) {
>> -        pr_err("%s: timer not available or enabled.\n", __func__);
>> +    if (unlikely(!timer)) {
>> +        pr_err("%s: timer not available.\n", __func__);
>>           return -EINVAL;
>>       }
>> +    dev = &timer->pdev->dev;
>> +
>> +    pm_runtime_resume_and_get(dev);
>>       dmtimer_write(timer, OMAP_TIMER_COUNTER_REG, value);
>> +    pm_runtime_put_sync(dev);
>>       /* Save the context */
>>       timer->context.tcrr = value;
>>       return 0;
>>   }
>> +/**
>> + * omap_dm_timer_cap_counter() - Calculate the high count or period 
>> count depending on the
>> + * configuration.
>> + * @cookie:Pointer to OMAP DM timer
>> + * @is_period:Whether to configure timer in period or duty cycle mode
>> + *
>> + * Return high count or period count if timer is enabled else 
>> appropriate error.
>> + */
>> +static unsigned int omap_dm_timer_cap_counter(struct omap_dm_timer 
>> *cookie,    bool is_period)
>> +{
>> +    struct dmtimer *timer;
>> +    unsigned int cap1 = 0;
>> +    unsigned int cap2 = 0;
>> +    u32 l, ret;
>> +
>> +    timer = to_dmtimer(cookie);
>> +    if (unlikely(!timer || !atomic_read(&timer->enabled))) {
>> +        pr_err("%s:timer is not available or enabled.%p\n", __func__, 
>> (void *)timer);
>> +        return -EINVAL;
>> +    }
>> +
>> +    /*Stop the timer*/
>> +    omap_dm_timer_stop(cookie);
>> +
>> +    /* Clear the timer counter value to 0 */
>> +    ret = omap_dm_timer_write_counter(cookie, 0);
>> +
>> +    if (ret)
>> +        return ret;
>> +
>> +    /*Sets the timer capture configuration for duty cycle calculation*/
>> +    if (is_period == false)
>> +        ret = omap_dm_timer_set_cap(cookie, true, false);
>> +
>> +    /*Sets the timer capture configuration for period calculation*/
>> +    else
>> +        ret = omap_dm_timer_set_cap(cookie, true, true);
>> +
> 
> The above 8 lines could just be:
> 
> ret = omap_dm_timer_set_cap(cookie, true, is_period);
> 
> Andrew
> 

Sure Andrew.

Regards
Gokul
>> +    if (ret) {
>> +        pr_err("%s: Failed to set timer capture configuration.\n", 
>> __func__);
>> +        return ret;
>> +    }
>> +    /*Start the timer*/
>> +    omap_dm_timer_start(cookie);
>> +
>> +    /*
>> +     * 1 sec delay is given so as to provide
>> +     * enough time to capture low frequency signals.
>> +     */
>> +    msleep(1000);
>> +
>> +    cap1 = __omap_dm_timer_cap(timer, 0);
>> +    cap2 = __omap_dm_timer_cap(timer, 1);
>> +
>> +    /*
>> +     *    Clears the TCLR configuration.
>> +     *  The start bit must be set to 1 as the timer is already in 
>> start mode.
>> +     */
>> +    l = dmtimer_read(timer, OMAP_TIMER_CTRL_REG);
>> +    l &= ~(0xffff) | 0x1;
>> +    dmtimer_write(timer, OMAP_TIMER_CTRL_REG, l);
>> +
>> +    return (cap2-cap1);
>> +}
>> +
>>   static int __maybe_unused omap_dm_timer_runtime_suspend(struct 
>> device *dev)
>>   {
>>       struct dmtimer *timer = dev_get_drvdata(dev);
>> @@ -1246,6 +1366,9 @@ static const struct omap_dm_timer_ops 
>> dmtimer_ops = {
>>       .write_counter = omap_dm_timer_write_counter,
>>       .read_status = omap_dm_timer_read_status,
>>       .write_status = omap_dm_timer_write_status,
>> +    .set_cap = omap_dm_timer_set_cap,
>> +    .get_cap_status = omap_dm_timer_get_pwm_status,
>> +    .read_cap = omap_dm_timer_cap_counter,
>>   };
>>   static const struct dmtimer_platform_data omap3plus_pdata = {
>> diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/ 
>> linux/platform_data/dmtimer-omap.h
>> index 95d852aef130..726d89143842 100644
>> --- a/include/linux/platform_data/dmtimer-omap.h
>> +++ b/include/linux/platform_data/dmtimer-omap.h
>> @@ -36,9 +36,13 @@ struct omap_dm_timer_ops {
>>       int    (*set_pwm)(struct omap_dm_timer *timer, int def_on,
>>                  int toggle, int trigger, int autoreload);
>>       int    (*get_pwm_status)(struct omap_dm_timer *timer);
>> +    int    (*set_cap)(struct omap_dm_timer *timer,
>> +               int autoreload, bool config_period);
>> +    int    (*get_cap_status)(struct omap_dm_timer *timer);
>>       int    (*set_prescaler)(struct omap_dm_timer *timer, int 
>> prescaler);
>>       unsigned int (*read_counter)(struct omap_dm_timer *timer);
>> +    unsigned int (*read_cap)(struct omap_dm_timer *timer, bool 
>> is_period);
>>       int    (*write_counter)(struct omap_dm_timer *timer,
>>                    unsigned int value);
>>       unsigned int (*read_status)(struct omap_dm_timer *timer);
> 


