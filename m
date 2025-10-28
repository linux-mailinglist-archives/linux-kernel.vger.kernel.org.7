Return-Path: <linux-kernel+bounces-874065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C4CC1575F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9E5F504098
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BD7340A57;
	Tue, 28 Oct 2025 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="WxK09PmZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F11233FE2F;
	Tue, 28 Oct 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761665156; cv=none; b=km+k5DKbAYHamcPg/x/h799LD2Ate07Hv71RYdIeOyiiqy9ZWa8zydFxupWixi4IQQi6DolS5gnFQN+HMxzYJLAhhiSLJxbZUwz8ZD40/Y6tfO03MtPrueaZW6vN0/BkCpTj2cO0ZKa8s2AZqQmgzqBKutMzVM7znljlI52Uz+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761665156; c=relaxed/simple;
	bh=gg9i2hciml/HV7u/I8sN8l/x4tegWO7Evfv2kHCOLUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1s6L2eYb4V2eDcN26JNalLSv31ev6KfZyiqwHHQWqRsvFjs6Wgk4TgR/qjQyjMSHlZextblxHnSP0tjRavxZ7KUIVx2zL2n70RwokI3JZ3tI+6Gi23gmbdpyWaQRcvL9biyxXqsV5KWFXKdwR0xgplfC0kF9/ZKAj2Iv0bS//w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=WxK09PmZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761665137; x=1762269937; i=w_armin@gmx.de;
	bh=OpWD4msn0uB1TiOOKimqHcpG2iJycjatx4mjPpjDTMc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=WxK09PmZ1/rhO0kZXc8lC5KhnxYhd1Ylo563lA8TclZ+HshLrUrWzuVoyFZKvam6
	 JQsWWKSqIcz7CrLBr8j38b4ICy4aRLNw7yHCO5/pIlJXsNoN3c+XkxQWeiKSPznIV
	 CkcHMNXzE004273ci1tr+jWuqtiTShnaEHqz8FZFKSp4Ic9K038JbeuF+DxTZTcjs
	 EQZK0jOZrqappPNAIknV1UWv9bZphE/hpU2Ho7Iu7jUY9tEbJi1+KudbEBIwz1Sx5
	 lgviVfwR8OR0CDl6De+R8ipvto7Cy8fOjcNy8orYpOZCrW5KvfHde0y4j5TFAxQZo
	 RjMrmwSLziB9EuiqUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.127.102] ([141.76.8.166]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MgNct-1vvNvS1NgV-00gZrr; Tue, 28
 Oct 2025 16:25:37 +0100
Message-ID: <b8f94bcd-fec3-4755-9179-044fd0aef36d@gmx.de>
Date: Tue, 28 Oct 2025 16:25:35 +0100
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAGwozwHACMJdbgcJgS-iOLpK_mQfcfHcF3Sci=XJJDiehbu7Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NKVYvuKZUtsblRzl+RYr6QRe/AlA3vutbpc3/lK+a5Zhx559+0F
 gvHU6+mgDdCZKcR8WtrwtJVCBkOpe8kzHBxI6iwxBHL6Cf/7vLD2kXjxYUfF+3VfDkKLhUI
 T4iyayFcnSurcKwcDb+fbgqr14IS/fW9Rl31ws/TSYq8TRkVT6RtAzFcIjh6zk7rBpIbQbD
 UYesW4p0vcfKo9wXAyl/Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Ba7bRfF6fw=;o/tB4EXLiERfC8u0zW6fS5JNJYw
 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
 mWW3g==

Am 28.10.25 um 16:20 schrieb Antheas Kapenekakis:

> On Tue, 28 Oct 2025 at 14:50, Armin Wolf <W_Armin@gmx.de> wrote:
>> Am 27.10.25 um 00:17 schrieb Antheas Kapenekakis:
>>
>>> On Sun, 26 Oct 2025 at 23:50, Armin Wolf <W_Armin@gmx.de> wrote:
>>>> Am 15.10.25 um 10:44 schrieb Antheas Kapenekakis:
>>>>
>>>>> The Ayaneo EC resets after hibernation, losing the charge control state.
>>>>> Add a small PM hook to restore this state on hibernation resume.
>>>>>
>>>>> The fan speed is also lost during hibernation, but since hibernation
>>>>> failures are common with this class of devices, setting a low fan speed
>>>>> when the userspace program controlling the fan will potentially not
>>>>> take over could cause the device to overheat, so it is not restored.
>>>> I am still not happy with potentially breaking fancontrol on this device.
>>>> Most users expect fancontrol to continue working after hibernation, so not
>>>> restoring the fan speed configuration seems risky to me. Would it be enough
>>>> to warn users about his inside the documentation?
>>> This device features two modes of operation: a factory fan curve
>>> managed by the EC and a fixed speed set via override of the EC.
>>>
>>> The factory curve is tuned by the manufacturer to result in safe
>>> operation in all conditions by monitoring the CPU temperature and is
>>> not adjustable.
>>>
>>> The fixed speed, on its own when set manually, is not use-able,
>>> because this device has a fluctuating temperature based on workload.
>>> So to meet the varying conditions, its speed would either have to be
>>> set too high, leading to excess noise, or too low, potentially
>>> overheating. Therefore, users of this interface control it via a
>>> userspace program, e.g., hhd, coolercontrol, which allows creating a
>>> custom fan curve based on measurements of temperature sensors.
>>>
>>> When entering hibernation, the userspace program that controls the fan
>>> speed is frozen, so the fan remains at its previous speed regardless
>>> of temperature readings and there are no safety checks.
>>>
>>> When resuming from hibernation, the EC takes over and monitors the
>>> temperature, so it is safe until the userspace program is thawed. If
>>> we introduce a resume hook, we take over from the EC before the
>>> program is ready, introducing a gap where the device can potentially
>>> overheat. If anything, the freeze hook should remove the fan speed
>>> override instead, because suspend-then-hibernate is more of a
>>> liability for overheating if hibernation hangs.
>> Understandable, how about introducing a module_param_unsafe() for enabling
>> write access to the fan settings? The fan settings would be read-only by default,
>> so no suspend handling would be necessary. Said suspend handling would only be
>> necessary when the user _explicitly_ requests write access to the fan settings.
>>
>> What i am trying to say is that we should either expose a fully working feature
>> (fan control with suspend support) or none at all (fan speed monitoring only).
>>
>> What do you thing about that?
> It is a safe parameter and it works during suspend. It has parity with
> current hwmon drivers for other manufacturers.
>
> Hibernation hooks for hwmon are unprecedented, in addition to
> compromising the safety of the device. They _could_ be justified for
> EC managed curves, since a minority of users might opt to set them via
> systemd udev rules and the EC manages the temperature. But this is not
> the case here.
>
> Where does the need for these hooks stem from?
>
> Antheas

I agree that most hwmon drivers sadly do not restore the fan control settings during
resume from hibernation. This however is an error inside the drivers themself, as device
drivers are normally expected to restore such settings during resume. Without this the
fancontrol software will suddenly stop working after hibernation, something users do no
expect.

Copying the faulty behavior of existing drivers is not a good idea here.

Thanks,
Armin Wolf

>> Thanks,
>> Armin Wolf
>>
>>> Other devices feature adjustable EC fan curves (e.g., Lenovo, Asus,
>>> AYN, MSI). Since the EC monitors the temperature there, it is fine to
>>> restore the fan curve. Speaking of, I am having quite a few issues
>>> with MSI Claws, so that series is a bit on the back burner, so I plan
>>> to push these series first.
>>>
>>> I will try to tend to this series in the next days. I wanted to push
>>> the Asus stuff first though.
>>>
>>>
>>> Antheas
>>>
>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>> ---
>>>>>     drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
>>>>>     1 file changed, 42 insertions(+)
>>>>>
>>>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
>>>>> index 73e9dd39c703..8529f6f8dc69 100644
>>>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>>>> @@ -37,6 +37,8 @@
>>>>>     #define AYANEO_MODULE_LEFT  BIT(0)
>>>>>     #define AYANEO_MODULE_RIGHT BIT(1)
>>>>>
>>>>> +#define AYANEO_CACHE_LEN     1
>>>>> +
>>>>>     struct ayaneo_ec_quirk {
>>>>>         bool has_fan_control;
>>>>>         bool has_charge_control;
>>>>> @@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
>>>>>         struct platform_device *pdev;
>>>>>         struct ayaneo_ec_quirk *quirks;
>>>>>         struct acpi_battery_hook battery_hook;
>>>>> +
>>>>> +     u8 cache[AYANEO_CACHE_LEN];
>>>>>     };
>>>>>
>>>>>     static const struct ayaneo_ec_quirk quirk_fan = {
>>>>> @@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
>>>>>         return 0;
>>>>>     }
>>>>>
>>>>> +static int ayaneo_freeze(struct device *dev)
>>>>> +{
>>>>> +     struct platform_device *pdev = to_platform_device(dev);
>>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>>>> +     int ret, i = 0;
>>>>> +
>>>>> +     if (data->quirks->has_charge_control) {
>>>>> +             ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +             i++;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static int ayaneo_thaw(struct device *dev)
>>>>> +{
>>>>> +     struct platform_device *pdev = to_platform_device(dev);
>>>>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
>>>>> +     int ret, i = 0;
>>>>> +
>>>>> +     if (data->quirks->has_charge_control) {
>>>>> +             ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
>>>>> +             if (ret)
>>>>> +                     return ret;
>>>>> +             i++;
>>>>> +     }
>>>>> +
>>>>> +     return 0;
>>>>> +}
>>>>> +
>>>>> +static const struct dev_pm_ops ayaneo_pm_ops = {
>>>>> +     .freeze = ayaneo_freeze,
>>>>> +     .thaw = ayaneo_thaw,
>>>>> +};
>>>>> +
>>>>>     static struct platform_driver ayaneo_platform_driver = {
>>>>>         .driver = {
>>>>>                 .name = "ayaneo-ec",
>>>>>                 .dev_groups = ayaneo_ec_groups,
>>>>> +             .pm = &ayaneo_pm_ops,
>>>> Please use pm_sleep_ptr() here.
>>>>
>>>> Thanks,
>>>> Armin Wolf
>>>>
>>>>>         },
>>>>>         .probe = ayaneo_ec_probe,
>>>>>     };

