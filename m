Return-Path: <linux-kernel+bounces-874885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1147C1752D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 00:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63F274F741A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 23:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E23E374AC9;
	Tue, 28 Oct 2025 23:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="TAN8H2/n"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CEE36A60E;
	Tue, 28 Oct 2025 23:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761693254; cv=none; b=XrPgtfonf1J1Rvay33WYg2ZKKfJZ6YKBqjNqqBZh8gWgNd05woGxBIrgbtpDNxCuw5fK9Oide8iKFKbYIjoNt9bOnp1ct41YZVurT8eRMEXLCnaadc+nWydIH27Fj23e0Gttie0D2+/ivaqnWqqVfQwDFIg0ga5IRVswSw41s8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761693254; c=relaxed/simple;
	bh=jwZTGLCCRf3wXUQdBVZBS5m2gDcTFCulzI1URj8LPEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eORP9lgHQQeQpb9F8oHE/3/NDsGLVYCxxCQkxU+4tyhpv9OIalxO7N/CO75orzOBNqTRZTR1otq7wKcwzi+Y4WtlSMUtYp5w3iNkfANI2roIwTbABiCAgcxc0Kuu+Zugr5anbpUgKElgkqBPUcc8SgPCVDe6c956YDquwbvyQ7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=TAN8H2/n; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761693249; x=1762298049; i=w_armin@gmx.de;
	bh=G8iT1txXZ0RCH88oFiUiVJK+S/2SbLPoemiTFHcjZ+w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TAN8H2/nR49+nRqi7NyfqzH0Pue5cr5Wm194aYLXuJ37LcRnJs5/8G2qlnbEpUrR
	 W7PrqU/0h2Ts1TZ5vYDqm8u6tCswdExVEwgLzY0ywEmTACHyAH9QRpTyni1s6TGkU
	 Ru1jzVYT10YhoMUEk1prwZldsvD1Q5Glwq7oPymjTwTvHa35Sl9oJ22b4tqCKBNXw
	 ktID29LY3El8zVAJw48Fb3OwnlvFlsAIxmX5icFWHAJKqbD8DA/jt8TeEdaA6CcqK
	 75+1T3sZi9wf6eA916x2rD4fTFbcGq1mqdkGsQDR5C8YQSmWEZY+1VO5Bw6PzWNiP
	 tI5qiJmMcEXblxgKSw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8mV-1vsSVZ4AZJ-00b7lO; Wed, 29
 Oct 2025 00:14:09 +0100
Message-ID: <3a3f7625-81ab-4cdf-b406-4b83a4494700@gmx.de>
Date: Wed, 29 Oct 2025 00:14:06 +0100
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
 <e41bb0b3-9c79-4d01-8510-4a60999e238b@gmx.de>
 <CAGwozwHACMJdbgcJgS-iOLpK_mQfcfHcF3Sci=XJJDiehbu7Bw@mail.gmail.com>
 <b8f94bcd-fec3-4755-9179-044fd0aef36d@gmx.de>
 <CAGwozwGAkgXE0zSPLLAPvWmwsRDgRnTLUi5X4zqYCnG3ot0exw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwGAkgXE0zSPLLAPvWmwsRDgRnTLUi5X4zqYCnG3ot0exw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:B2hmD0QSUx5ORieWaLshnEsl0mweR47o9iNIt/W8r8vwWBYBIf3
 Gndb3YtNcKIexIpBwGTt/jNF5x8kcuB4G8AvazldzMHMKpaVkhVWK6PstfdPmmLD8g4TIt6
 KMX3o/sWJmNPWTroZeaU0YeTIrqum4aRDwyOm0Dc3E+4xA34HxijbIQHm7/KatXJJUmqjS2
 3h7OcFpuAgAyz21XYkcvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9V/bGTUYAqA=;8PMYZCtFSJJL1grjtUL0dT+kZmp
 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

Am 28.10.25 um 18:49 schrieb Antheas Kapenekakis:

> On Tue, 28 Oct 2025 at 16:26, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 28.10.25 um 16:20 schrieb Antheas Kapenekakis:
>>
>>> On Tue, 28 Oct 2025 at 14:50, Armin Wolf <W_Armin@gmx.de> wrote:
>>>> Am 27.10.25 um 00:17 schrieb Antheas Kapenekakis:
>>>>
>>>>> On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
>>>>>> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
>>>>>>
>>>>>>> The Ayaneo EC resets after hibernation, losing the charge control state.
>>>>>>> Add a small PM hook to restore this state on hibernation resume.
>>>>>>>
>>>>>>> The fan speed is also lost during hibernation, but since hibernation
>>>>>>> failures are common with this class of devices, setting a low fan speed
>>>>>>> when the userspace program controlling the fan will potentially not
>>>>>>> take over could cause the device to overheat, so it is not restored.
>>>>>> I am still not happy with potentially breaking fancontrol on this device.
>>>>>> Most users expect fancontrol to continue working after hibernation, so not
>>>>>> restoring the fan speed configuration seems risky to me. Would it be enough
>>>>>> to warn users about his inside the documentation?
>>>>> This device features two modes of operation: a factory fan curve
>>>>> managed by the EC and a fixed speed set via override of the EC.
>>>>>
>>>>> The factory curve is tuned by the manufacturer to result in safe
>>>>> operation in all conditions by monitoring the CPU temperature and is
>>>>> not adjustable.
>>>>>
>>>>> The fixed speed, on its own when set manually, is not use-able,
>>>>> because this device has a fluctuating temperature based on workload.
>>>>> So to meet the varying conditions, its speed would either have to be
>>>>> set too high, leading to excess noise, or too low, potentially
>>>>> overheating. Therefore, users of this interface control it via a
>>>>> userspace program, e.g., hhd, coolercontrol, which allows creating a
>>>>> custom fan curve based on measurements of temperature sensors.
>>>>>
>>>>> When entering hibernation, the userspace program that controls the fan
>>>>> speed is frozen, so the fan remains at its previous speed regardless
>>>>> of temperature readings and there are no safety checks.
>>>>>
>>>>> When resuming from hibernation, the EC takes over and monitors the
>>>>> temperature, so it is safe until the userspace program is thawed. If
>>>>> we introduce a resume hook, we take over from the EC before the
>>>>> program is ready, introducing a gap where the device can potentially
>>>>> overheat. If anything, the freeze hook should remove the fan speed
>>>>> override instead, because suspend-then-hibernate is more of a
>>>>> liability for overheating if hibernation hangs.
>>>> Understandable, how about introducing a module_param_unsafe() for enabling
>>>> write access to the fan settings? The fan settings would be read-only by default,
>>>> so no suspend handling would be necessary. Said suspend handling would only be
>>>> necessary when the user _explicitly_ requests write access to the fan settings.
>>>>
>>>> What i am trying to say is that we should either expose a fully working feature
>>>> (fan control with suspend support) or none at all (fan speed monitoring only).
>>>>
>>>> What do you thing about that?
>>> It is a safe parameter and it works during suspend. It has parity with
>>> current hwmon drivers for other manufacturers.
>>>
>>> Hibernation hooks for hwmon are unprecedented, in addition to
>>> compromising the safety of the device. They _could_ be justified for
>>> EC managed curves, since a minority of users might opt to set them via
>>> systemd udev rules and the EC manages the temperature. But this is not
>>> the case here.
>>>
>>> Where does the need for these hooks stem from?
>>>
>>> Antheas
>> I agree that most hwmon drivers sadly do not restore the fan control settings during
>> resume from hibernation. This however is an error inside the drivers themself, as device
>> drivers are normally expected to restore such settings during resume. Without this the
>> fancontrol software will suddenly stop working after hibernation, something users do no
>> expect.
>>
>> Copying the faulty behavior of existing drivers is not a good idea here.
> Well, unless you can solve the case of hibernation failing and what
> happens to the fan speed I cannot sign off on it. These devices are
> very expensive.
>
> Controlling the fan is basic functionality, it cannot be marked or be
> made an unsafe feature.
>
> I am aware of the issue post hibernation, but thats easy to solve
> through software, and as a maintainer of fan control software, which
> also happens to be the main consumer of this module, I already have a
> hook there. As it is needed by the other manufacturers as well.
>
> Antheas

Alright, if Guenter is fine with this approach then i wont complain any longer.
However please document this non-standard behavior so people do not accidentally
"fix" it in the future.

Thank,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>> Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
>>>>> AYN, MSI). Since the EC monitors the temperature there, it is fine to
>>>>> restore the fan curve. Speaking of, I am having quite a few issues
>>>>> with MSI Claws, so that series is a bit on the back burner, so I plan
>>>>> to push these series first.
>>>>>
>>>>> I will try to tend to this series in the next days. I wanted to push
>>>>> the Asus stuff first though.
>>>>>
>>>>>
>>>>> Antheas
>>>>>
>>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>>> ---
>>>>>>>      drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>>>>>>>      1 file changed, 42 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>>>>>> index 73e9dd39c703..8529f6f8dc69 100644
>>>>>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>>>>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>>>>>> @@ -37,6 +37,8 @@
>>>>>>>      #define AYANEO_MODULE_LEFT  BIT(0)
>>>>>>>      #define AYANEO_MODULE_RIGHT BIT(1)
>>>>>>>
>>>>>>> +#define AYANEO_CACHE_LEN     1
>>>>>>> +
>>>>>>>      struct ayaneo_ec_quirk {
>>>>>>>          bool has_fan_control;
>>>>>>>          bool has_charge_control;
>>>>>>> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>>>>>>>          struct platform_device *pdev;
>>>>>>>          struct ayaneo_ec_quirk *quirks;
>>>>>>>          struct acpi_battery_hook battery_hook;
>>>>>>> +
>>>>>>> +     u8 cache[AYANEO_CACHE_LEN];
>>>>>>>      };
>>>>>>>
>>>>>>>      static const struct ayaneo_ec_quirk quirk_fan = {
>>>>>>> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>>>>>          return 0;
>>>>>>>      }
>>>>>>>
>>>>>>> +static int ayaneo_freeze(struct device *dev)
>>>>>>> +{
>>>>>>> +     struct platform_device *pdev = to_platform_device(dev);
>>>>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>>>>>> +     int ret, i = 0;
>>>>>>> +
>>>>>>> +     if (data->quirks->has_charge_control) {
>>>>>>> +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
>>>>>>> +             if (ret)
>>>>>>> +                     return ret;
>>>>>>> +             i++;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static int ayaneo_thaw(struct device *dev)
>>>>>>> +{
>>>>>>> +     struct platform_device *pdev = to_platform_device(dev);
>>>>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>>>>>> +     int ret, i = 0;
>>>>>>> +
>>>>>>> +     if (data->quirks->has_charge_control) {
>>>>>>> +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
>>>>>>> +             if (ret)
>>>>>>> +                     return ret;
>>>>>>> +             i++;
>>>>>>> +     }
>>>>>>> +
>>>>>>> +     return 0;
>>>>>>> +}
>>>>>>> +
>>>>>>> +static const struct dev_pm_ops ayaneo_pm_ops = {
>>>>>>> +     .freeze = ayaneo_freeze,
>>>>>>> +     .thaw = ayaneo_thaw,
>>>>>>> +};
>>>>>>> +
>>>>>>>      static struct platform_driver ayaneo_platform_driver = {
>>>>>>>          .driver = {
>>>>>>>                  .name = "ayaneo-ec",
>>>>>>>                  .dev_groups = ayaneo_ec_groups,
>>>>>>> +             .pm = &ayaneo_pm_ops,
>>>>>> Please use pm_sleep_ptr() here.
>>>>>>
>>>>>> Thanks,
>>>>>> Armin Wolf
>>>>>>
>>>>>>>          },
>>>>>>>          .probe = ayaneo_ec_probe,
>>>>>>>      };
>

