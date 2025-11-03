Return-Path: <linux-kernel+bounces-883709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE1AC2E2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 22:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28FD54E2C95
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 21:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB66D2D23BD;
	Mon,  3 Nov 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmwOHNow"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D731917FB;
	Mon,  3 Nov 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205642; cv=none; b=S1kt0dEXsl6DAhESxwtkK1JjSA7STtC7iYoMfz0Q1fu92L85IkeLl/13KM3mHppaHhWmyZ+2J0W+XWpWFX8up+KqiIhqyxUOGHo/GFqimJ5tF7wkZSmBwbeuLX8RgnlhC5JuPFXy5lhlNhdyc5TPwEFDyqhgdHDicjupxA8vPY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205642; c=relaxed/simple;
	bh=dBZ1X+74OSnYW9dKKms80y/IUcM9ZTWsFY4KfbA4xqI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srZ1Bk9OqMJjKTrgi7XSZ7KgHS3wd7W3iensQn3nhP4uSH3cVHxqZeoY1UmB3daC5wQunFiT1tHIxfBc1wkQGSczFlnvfMjLItkmFsHq91Kv0nQHaruaOXnMA4Db77U0GYoXnmpDATIKCki64bH2y08IVcg3tn/nnvnzOgD91ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmwOHNow; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DEDCC4CEF8;
	Mon,  3 Nov 2025 21:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762205641;
	bh=dBZ1X+74OSnYW9dKKms80y/IUcM9ZTWsFY4KfbA4xqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PmwOHNow3+oequucqLKkTmM7QVu7hjrzWDlYj+HI6anpNJGOV4A2hxw/pgiinPtLU
	 REHvv36VObEdE5iJHYNSH1UoXFDRoQEVOkk1ra47sNSY4fOMy4isJo1bZILbeWLRfZ
	 fMa/cDkTEJExDpRn0JEqG48WpX5ytRHFTI4+EMpM/X0qDKPuQOSUbkmlCHTwSpATOL
	 t3KXt7nsAwdQvgPY5VYI3BZE6LU4IsQQDIum74pShYtA/EZlsj0YEnJTCln3//bcmN
	 aNbxcGLIxCyPcCMcC7zr+DP6X7pBLDdlyR9VtuS96oSCBBi9qI3iheK9Gfk5p4C1/9
	 iuaIRJDb4Obkw==
Message-ID: <6eeaf114-14bd-4fe2-9359-6b953dcd8bb5@kernel.org>
Date: Mon, 3 Nov 2025 15:33:59 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-7-lkml@antheas.dev>
 <4c06dc85-9b16-47b3-9622-58e699c700c0@kernel.org>
 <CAGwozwFZoKm4Bj785-HwpbNdjHwswWWY8dwX_vLHPwsUxC52Yg@mail.gmail.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <CAGwozwFZoKm4Bj785-HwpbNdjHwswWWY8dwX_vLHPwsUxC52Yg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/3/2025 3:20 PM, Antheas Kapenekakis wrote:
> On Mon, 3 Nov 2025 at 17:51, Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 10/31/2025 11:36 AM, Antheas Kapenekakis wrote:
>>> The Ayaneo EC resets after hibernation, losing the charge control state.
>>> Add a small PM hook to restore this state on hibernation resume.
>>>
>>> The fan speed is also lost during hibernation, but since hibernation
>>> failures are common with this class of devices, setting a low fan speed
>>> when the userspace program controlling the fan will potentially not
>>> take over could cause the device to overheat, so it is not restored.
>>>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/ayaneo-ec.c | 73 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 73 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 9548e3d22093..e1ad5968d3b4 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -41,6 +41,8 @@
>>>    #define AYANEO_MODULE_LEFT  BIT(0)
>>>    #define AYANEO_MODULE_RIGHT BIT(1)
>>>
>>> +#define AYANEO_CACHE_LEN     1
>>> +
>>>    struct ayaneo_ec_quirk {
>>>        bool has_fan_control;
>>>        bool has_charge_control;
>>> @@ -51,6 +53,9 @@ struct ayaneo_ec_platform_data {
>>>        struct platform_device *pdev;
>>>        struct ayaneo_ec_quirk *quirks;
>>>        struct acpi_battery_hook battery_hook;
>>> +
>>> +     bool restore_charge_limit;
>>> +     bool restore_pwm;
>>>    };
>>>
>>>    static const struct ayaneo_ec_quirk quirk_fan = {
>>> @@ -207,10 +212,14 @@ static int ayaneo_ec_read(struct device *dev, enum hwmon_sensor_types type,
>>>    static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
>>>                           u32 attr, int channel, long val)
>>>    {
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(
>>> +             to_platform_device(dev));
>>> +     int ret;
>>>        switch (type) {
>>>        case hwmon_pwm:
>>>                switch (attr) {
>>>                case hwmon_pwm_enable:
>>> +                     data->restore_pwm = false;
>>>                        switch (val) {
>>>                        case 1:
>>>                                return ec_write(AYANEO_PWM_ENABLE_REG,
>>> @@ -224,6 +233,15 @@ static int ayaneo_ec_write(struct device *dev, enum hwmon_sensor_types type,
>>>                case hwmon_pwm_input:
>>>                        if (val < 0 || val > 255)
>>>                                return -EINVAL;
>>> +                     if (data->restore_pwm) {
>>> +                             // Defer restoring PWM control to after
>>> +                             // userspace resumes successfully
>>> +                             ret = ec_write(AYANEO_PWM_ENABLE_REG,
>>> +                                            AYANEO_PWM_MODE_MANUAL);
>>> +                             if (ret)
>>> +                                     return ret;
>>> +                             data->restore_pwm = false;
>>> +                     }
>>>                        return ec_write(AYANEO_PWM_REG, (val * 100) / 255);
>>>                default:
>>>                        break;
>>> @@ -474,10 +492,65 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>        return 0;
>>>    }
>>>
>>> +static int ayaneo_freeze(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>> +     int ret;
>>> +     u8 tmp;
>>> +
>>> +     if (data->quirks->has_charge_control) {
>>> +             ret = ec_read(AYANEO_CHARGE_REG, &tmp);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             data->restore_charge_limit = tmp == AYANEO_CHARGE_VAL_INHIBIT;
>>> +     }
>>> +
>>> +     if (data->quirks->has_fan_control) {
>>> +             ret = ec_read(AYANEO_PWM_ENABLE_REG, &tmp);
>>> +             if (ret)
>>> +                     return ret;
>>> +
>>> +             data->restore_pwm = tmp == AYANEO_PWM_MODE_MANUAL;
>>
>> Why bother with the temp variable in the first place?
>>
>> You could just make the data type of restore_pwm a u8 and then:
>>
>> ec_read(AYANEO_PWM_ENABLE_REG, data->restore_pwm);
> 
> For restore_pwm it needs to be a bool because it is applied lazily on
> resume only if manual. charge limit could be a u8 (it was on the
> previous patch) but I chose to do a bool to match restore_pwm and so
> that I also only apply it selectively.

But you can interpret a u8 as a boolean as well was my point.  If it's 0 
it's false, if it's anything else it's true.

But I'm not gonna die on this hill, just wanted to point it out.

> 
>>
>>> +
>>> +             // Release the fan when entering hibernation to avoid
>>> +             // overheating if hibernation fails and hangs
>>
>> Multi-line comments should be done with /* */
>>
>>> +             if (data->restore_pwm) {
>>> +                     ret = ec_write(AYANEO_PWM_ENABLE_REG, AYANEO_PWM_MODE_AUTO);
>>> +                     if (ret)
>>> +                             return ret;
>>> +             }
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int ayaneo_restore(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>> +     int ret;
>>> +
>>> +     if (data->quirks->has_charge_control && data->restore_charge_limit) {
>>> +             ret = ec_write(AYANEO_CHARGE_REG, AYANEO_CHARGE_VAL_INHIBIT);
>>> +             if (ret)
>>> +                     return ret;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops ayaneo_pm_ops = {
>>> +     .freeze = ayaneo_freeze,
>>> +     .restore = ayaneo_restore,
>>> +};
>>
>> Why are freeze and restore special?  Userspace is frozen for the suspend
>> sequence of any flow.  Hangs could happen in suspend just like they can
>> in hibernate.  If you're going to protect users from this I would expect
>> parity for "regular" suspend/resume.
>>
>> Can you just use SIMPLE_DEV_PM_OPS and rename the functions accordingly?
> 
> Well, the ops here do two functions. First, they restore fan and
> charge limiting state, which is only required for hibernation (both
> are maintained during sleep).
> 
> Second, they ensure from entry to exit there is an automatic fan
> curve. For hibernation, the failure rate is 30%-80% depending on
> kernel version and userspace load (incl. which devices such as GPU are
> loaded and how much). Both entry and exit can fail equally. In which
> case the device may be stuck with an inappropriate fan speed for
> minutes. Moreover, even without a failure, hibernation entry and exit
> take around 1-2 minutes to complete so it is a nice touch to release
> the manual speed for entry to maintain a reasonable fan speed.
> 
> For sleep, it is different. It always works, 

Having spent enough time looking at sleep problems I would never make a 
statement like that.  I try really hard to stay on on top of it, but the 
reality is regressions happen all the time.

> so there is no failure
> rate. Then, it requires around 3 seconds for entry and 2 seconds for
> exit, so for successful entry and exit using an automatic fan speed is
> not needed. Introducing restoring auto speed a failsafe risks
> introducing a user-visible flaw where the fan would spike before and
> after sleep. It could potentially introduce other bugs as it does
> unnecessary writes. So this is not a good reason for introducing this.

The other thing to keep in mind is that regressions can happen in 
firmware too, and this is why I generally feel it's best to be 
conservative around sleep states in this area.

I would never tell someone to do it, but technically you can unbind the 
lps0 device.  If this happens what happens to this fan curve stuff? 
Userspace will be frozen and the hardware won't got to a hardware sleep 
state.
> 
> So ops are not required for sleep for either reason they were
> implemented for hibernation
> 
> Ack on the rest
> 
> Antheas
> 
>>> +
>>>    static struct platform_driver ayaneo_platform_driver = {
>>>        .driver = {
>>>                .name = "ayaneo-ec",
>>>                .dev_groups = ayaneo_ec_groups,
>>> +             .pm = &ayaneo_pm_ops,
>>>        },
>>>        .probe = ayaneo_ec_probe,
>>>    };
>>
>>
> 


