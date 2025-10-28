Return-Path: <linux-kernel+bounces-873881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB8CC14FF0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 14:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75F4462BA5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E011D63EF;
	Tue, 28 Oct 2025 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DSM94YZR"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E65239E7F;
	Tue, 28 Oct 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659442; cv=none; b=Ko4XqK06Qix5tpm6qkRXEkiZePXA18GfcpXK8Ny//+HOh5z785YFPHiv06fmyYjERRdFZT7QjDM1Jgos2BuRl3IEWhH2MqAfLGM4TFdbONT4BWxH97RT8fjr2Xk6TxNlfegKPsYdPBISMfuDIR5KvrNtB1+HQzeqZ8Youpmhyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659442; c=relaxed/simple;
	bh=ySfNUEYZFTZtSMSTyokNPrSh/iK/zSDPvSK3qQV6dMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QJZqTZrSwcRRf7z2EFnl+ibDGefpfqh4PJNFhWPAYfueB57kk8qJw6T2j1EfBH9w0up76NXZ6OjsifBkJD6hxDyuWBDXYLfcfVEZ7wKeG1S8xE8KD31rPtklIiZW9xDm4pGJXSUhqXLORP39BOiA4Yrs84HjQJQxBsbmVz0yIiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DSM94YZR; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761659417; x=1762264217; i=w_armin@gmx.de;
	bh=tBkx+8DTLrJvtTVeMjGiq62hn5aLnHPRB5Uk8324rGY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DSM94YZRmCVRuEnZ6513+RccaRUKrOcza+SWBXdo4Nl1MouPJ/SZhTuhyhhOxXGp
	 lu2AILxGPbRRJd3HHN11gA88Q0K8WF67SmogcYCKfoYLk8ffSDxrIjPLBinrBlZMa
	 yWWamv0BjPZa9OuaFdBNLZF4cLyhpK/3nxkvZ6PKQwzHDm/hcVY/iLl0ThVv9EBFh
	 xNLJAixop3lwuzgN6XNzbPXiMpx6rHWCZ3RnB3x+hC9BHnURI88mvjNKCFLtd/TRP
	 RADJlyivbOOoTr5bOlbJeSGkEs7BF3OoAvx8yeDJuz1RTq+qJxE3hTTuBJYiCdplc
	 7vW7Y6sPXvo4mHp70A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.127.102] ([141.76.8.166]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1vloqD1niO-00Mgc3; Tue, 28
 Oct 2025 14:50:17 +0100
Message-ID: <e41bb0b3-9c79-4d01-8510-4a60999e238b@gmx.de>
Date: Tue, 28 Oct 2025 14:50:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251015084414.1391595-1-lkml@antheas.dev>
 <20251015084414.1391595-7-lkml@antheas.dev>
 <63f0221d-4436-4d1e-a933-8b12f392cac6@gmx.de>
 <CAGwozwHsFEU1nZNe-7HEv86Oi8VTX=qHO-Tz76uRJVeFTUDv5g@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwHsFEU1nZNe-7HEv86Oi8VTX=qHO-Tz76uRJVeFTUDv5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gT1rqQH9Pc3f6CEkk7zr9rt+saEXpn8tTq+QpO4iPeMt6WUtNqx
 xvtSH3b1kZAyfk02h2OiKh9qG8U9fuOT2K40TJxaix4A7SZk5o5odHkLtg6wms1Yl8psthU
 T9DvFgs7GEha7fkHeAAqcbF+wUdjR2h7TLg/egsln66Zvue3fW1RB0954Kd97bfhmMlCYZ7
 srj67lpMUx8glERV9+ASA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6v0LoKwU2KI=;Ex9h5l/qeJ6IERYU/OHA9CbeXBs
 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
 vfzxbiHEBLZL298i16H5AHJaik=

Am 27.10.25 um 00:17 schrieb Antheas Kapenekakis:

> On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
>>
>>> The Ayaneo EC resets after hibernation, losing the charge control state.
>>> Add a small PM hook to restore this state on hibernation resume.
>>>
>>> The fan speed is also lost during hibernation, but since hibernation
>>> failures are common with this class of devices, setting a low fan speed
>>> when the userspace program controlling the fan will potentially not
>>> take over could cause the device to overheat, so it is not restored.
>> I am still not happy with potentially breaking fancontrol on this device.
>> Most users expect fancontrol to continue working after hibernation, so not
>> restoring the fan speed configuration seems risky to me. Would it be enough
>> to warn users about his inside the documentation?
> This device features two modes of operation: a factory fan curve
> managed by the EC and a fixed speed set via override of the EC.
>
> The factory curve is tuned by the manufacturer to result in safe
> operation in all conditions by monitoring the CPU temperature and is
> not adjustable.
>
> The fixed speed, on its own when set manually, is not use-able,
> because this device has a fluctuating temperature based on workload.
> So to meet the varying conditions, its speed would either have to be
> set too high, leading to excess noise, or too low, potentially
> overheating. Therefore, users of this interface control it via a
> userspace program, e.g., hhd, coolercontrol, which allows creating a
> custom fan curve based on measurements of temperature sensors.
>
> When entering hibernation, the userspace program that controls the fan
> speed is frozen, so the fan remains at its previous speed regardless
> of temperature readings and there are no safety checks.
>
> When resuming from hibernation, the EC takes over and monitors the
> temperature, so it is safe until the userspace program is thawed. If
> we introduce a resume hook, we take over from the EC before the
> program is ready, introducing a gap where the device can potentially
> overheat. If anything, the freeze hook should remove the fan speed
> override instead, because suspend-then-hibernate is more of a
> liability for overheating if hibernation hangs.

Understandable, how about introducing a module_param_unsafe() for enabling
write access to the fan settings? The fan settings would be read-only by default,
so no suspend handling would be necessary. Said suspend handling would only be
necessary when the user _explicitly_ requests write access to the fan settings.

What i am trying to say is that we should either expose a fully working feature
(fan control with suspend support) or none at all (fan speed monitoring only).

What do you thing about that?

Thanks,
Armin Wolf

>
> Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
> AYN, MSI). Since the EC monitors the temperature there, it is fine to
> restore the fan curve. Speaking of, I am having quite a few issues
> with MSI Claws, so that series is a bit on the back burner, so I plan
> to push these series first.
>
> I will try to tend to this series in the next days. I wanted to push
> the Asus stuff first though.
>
>
> Antheas
>
>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>> ---
>>>    drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>>>    1 file changed, 42 insertions(+)
>>>
>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>> index 73e9dd39c703..8529f6f8dc69 100644
>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>> @@ -37,6 +37,8 @@
>>>    #define AYANEO_MODULE_LEFT  BIT(0)
>>>    #define AYANEO_MODULE_RIGHT BIT(1)
>>>
>>> +#define AYANEO_CACHE_LEN     1
>>> +
>>>    struct ayaneo_ec_quirk {
>>>        bool has_fan_control;
>>>        bool has_charge_control;
>>> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>>>        struct platform_device *pdev;
>>>        struct ayaneo_ec_quirk *quirks;
>>>        struct acpi_battery_hook battery_hook;
>>> +
>>> +     u8 cache[AYANEO_CACHE_LEN];
>>>    };
>>>
>>>    static const struct ayaneo_ec_quirk quirk_fan = {
>>> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>        return 0;
>>>    }
>>>
>>> +static int ayaneo_freeze(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>> +     int ret, i = 0;
>>> +
>>> +     if (data->quirks->has_charge_control) {
>>> +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
>>> +             if (ret)
>>> +                     return ret;
>>> +             i++;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int ayaneo_thaw(struct device *dev)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>> +     int ret, i = 0;
>>> +
>>> +     if (data->quirks->has_charge_control) {
>>> +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
>>> +             if (ret)
>>> +                     return ret;
>>> +             i++;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct dev_pm_ops ayaneo_pm_ops = {
>>> +     .freeze = ayaneo_freeze,
>>> +     .thaw = ayaneo_thaw,
>>> +};
>>> +
>>>    static struct platform_driver ayaneo_platform_driver = {
>>>        .driver = {
>>>                .name = "ayaneo-ec",
>>>                .dev_groups = ayaneo_ec_groups,
>>> +             .pm = &ayaneo_pm_ops,
>> Please use pm_sleep_ptr() here.
>>
>> Thanks,
>> Armin Wolf
>>
>>>        },
>>>        .probe = ayaneo_ec_probe,
>>>    };
>

