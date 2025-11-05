Return-Path: <linux-kernel+bounces-887416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67121C382CF
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD0CE4EF780
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34952F12DE;
	Wed,  5 Nov 2025 22:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="cwj5iL0E"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95DE2E888C;
	Wed,  5 Nov 2025 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762381269; cv=none; b=svSVCVlEYHAMPTr7zfqxjqD5yyjuLPSZ07NJ3ZCcoNG60SvpbGTcw6JvWFrqVAi5IhrEQ9ag9n0cFYhw6qAFgclgvPinZcKbZCt6dFBAyBVu+WpwumI+eKKa0W/eOIew74vAZBwRedDRF54CNv5hcgQ0dG7xauennb2u9ZnMH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762381269; c=relaxed/simple;
	bh=Wau9DK+UY0fgJloYvKM6SkAh6w6ox1MDLjJUYa9ZZMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OqGp6rchWWYiIMX/1BNJzmY4xwOyr4EnAsNotluq68rMfKqc8eIg2Zu6CQgFyKhXkhC+PeghYlY33yDBRTfSKz79VrC41v6XGjTXnep4MtjgcKokM1QGAmvbA2nopPgYfWlxL1xow3zZHloK1OHByOP8I+fExxsfH2CQV1ZBLe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=cwj5iL0E; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1762381261; x=1762986061; i=w_armin@gmx.de;
	bh=a4e1CnNRuF2By+5iyO5V0+ebMHTptj5jsiZ3lkCXCFg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cwj5iL0EwvivifSjcVQY6IBXmIPx08qLnBj2CuujZDSWatStJdik8TFy5glXkSCW
	 qfKeoWRvhVFlih99PfvtI/3/Dfmhy/bRX7hvzUdOo5QAc3w6iJVldBR9aC8PlKjGQ
	 zvuZgfAtba0C5FjYcpaYPE8SuZdqKIFrDIK+whqTWa88jsWbJfhlpGgr9UdGd/zRp
	 2ELHzpppXrU3gv2iKAKsmajSSY764Bu97rHSUroNQInwkaHtBi39D/94XR/p0c1L4
	 BPM+npAYM7N0r8Gr5IRMhEwonygf1PkisZ69LRiXsu/fd5KyOnbDe+89vU84x5tuL
	 dRa0B1uXkirR1cncAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95eJ-1wKspe1NZf-00xTvb; Wed, 05
 Nov 2025 23:21:01 +0100
Message-ID: <09b21404-2788-463b-966a-fe3f35fe661a@gmx.de>
Date: Wed, 5 Nov 2025 23:20:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power and
 modules attributes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Antheas Kapenekakis <lkml@antheas.dev>
Cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= <samsagax@gmail.com>,
 Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
References: <20251031163651.1465981-1-lkml@antheas.dev>
 <20251031163651.1465981-5-lkml@antheas.dev>
 <7c521e72-1b32-4172-90ec-6e793941a8ed@gmx.de>
 <CAGwozwFRF11dH02SRRNCyiYW7dNuoYoGWfPdEWPoim2r-KoZ0g@mail.gmail.com>
 <e0b29b59-b37d-4c44-ab97-9527b0f959b1@gmx.de>
 <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
 <1e9d5311-45f9-15fa-ce3e-8098c288acbd@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <1e9d5311-45f9-15fa-ce3e-8098c288acbd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jnusnYP+zMKi8ZJrX9BblSHHrl5fiVpOV8cp0cyLJhtzg6ehXjm
 9CMT49MDlwch1jflCvPb+8Z8imzzbtX9mJGMFoQ/lhxtdw6SIkcHurYhh+V5l2hf1B8GfO4
 gAwUCfs6hi3ocMlt6lUl7FsaPb26UK2xjwg61jR8RQuVJlKexapl05rehUB8y2pthfJGwTp
 Wg8bYcmsETj+TywrPisRw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XaUG/YRKmJI=;cHRW29S9Rh93bjnxH8caQlk3hv1
 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
 Iz7Q1M/pUsiQ/OEtL6JRTjFhdFj+h

Am 05.11.25 um 14:24 schrieb Ilpo J=C3=A4rvinen:

> On Wed, 5 Nov 2025, Antheas Kapenekakis wrote:
>
>> On Tue, 4 Nov 2025 at 21:04, Armin Wolf <W_Armin@gmx.de> wrote:
>>> Am 02.11.25 um 19:46 schrieb Antheas Kapenekakis:
>>>
>>>> On Sun, 2 Nov 2025 at 19:30, Armin Wolf <W_Armin@gmx.de> wrote:
>>>>> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
>>>>>
>>>>>> The Ayaneo 3 features hot-swappable controller modules. The ejectio=
n
>>>>>> and management is done through HID. However, after ejecting the mod=
ules,
>>>>>> the controller needs to be power cycled via the EC to re-initialize=
.
>>>>>>
>>>>>> For this, the EC provides a variable that holds whether the left or
>>>>>> right modules are connected, and a power control register to turn
>>>>>> the controller on or off. After ejecting the modules, the controlle=
r
>>>>>> should be turned off. Then, after both modules are reinserted,
>>>>>> the controller may be powered on again to re-initialize.
>>>>>>
>>>>>> This patch introduces two new sysfs attributes:
>>>>>>     - `controller_modules`: a read-only attribute that indicates wh=
ether
>>>>>>       the left and right modules are connected (none, left, right, =
both).
>>>>>>     - `controller_power`: a read-write attribute that allows the us=
er
>>>>>>       to turn the controller on or off (with '1'/'0').
>>>>>>
>>>>>> Therefore, after ejection is complete, userspace can power off the
>>>>>> controller, then wait until both modules have been reinserted
>>>>>> (`controller_modules` will return 'both') to turn on the controller=
.
>>>>>>
>>>>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>>>>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
>>>>>> ---
>>>>>>     .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
>>>>>>     MAINTAINERS                                   |   1 +
>>>>>>     drivers/platform/x86/ayaneo-ec.c              | 106 +++++++++++=
+++++++
>>>>>>     3 files changed, 126 insertions(+)
>>>>>>     create mode 100644 Documentation/ABI/testing/sysfs-platform-aya=
neo-ec
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/D=
ocumentation/ABI/testing/sysfs-platform-ayaneo-ec
>>>>>> new file mode 100644
>>>>>> index 000000000000..3c9c3580c685
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
>>>>>> @@ -0,0 +1,19 @@
>>>>>> +What:                /sys/devices/platform/ayaneo-ec/controller_po=
wer
>>>>>> +Date:                Oct 2025
>>>>> I think you need to update those dates.
>>>>>
>>>>>> +KernelVersion:       6.19
>>>>>> +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
>>>>>> +Description:
>>>>>> +             Current controller power state. Allows turning on and=
 off
>>>>>> +             the controller power (e.g. for power savings). Write =
1 to
>>>>>> +             turn on, 0 to turn off. File is readable and writable=
.
>>>>>> +
>>>>>> +What:                /sys/devices/platform/ayaneo-ec/controller_mo=
dules
>>>>>> +Date:                Oct 2025
>>>>>> +KernelVersion:       6.19
>>>>>> +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
>>>>>> +Description:
>>>>>> +             Shows which controller modules are currently connecte=
d to
>>>>>> +             the device. Possible values are "left", "right" and "=
both".
>>>>>> +             File is read-only. The Windows software for this devi=
ce
>>>>>> +             will only set controller power to 1 if both module si=
des
>>>>>> +             are connected (i.e. this file returns "both").
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index da9498d8cc89..b4d62ea9a926 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
>>>>>>     M:  Antheas Kapenekakis <lkml@antheas.dev>
>>>>>>     L:  platform-driver-x86@vger.kernel.org
>>>>>>     S:  Maintained
>>>>>> +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
>>>>>>     F:  drivers/platform/x86/ayaneo-ec.c
>>>>>>
>>>>>>     AZ6007 DVB DRIVER
>>>>>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x8=
6/ayaneo-ec.c
>>>>>> index 697bb053a7d6..0652c044ad76 100644
>>>>>> --- a/drivers/platform/x86/ayaneo-ec.c
>>>>>> +++ b/drivers/platform/x86/ayaneo-ec.c
>>>>>> @@ -8,6 +8,7 @@
>>>>>>      */
>>>>>>
>>>>>>     #include <linux/acpi.h>
>>>>>> +#include <linux/bits.h>
>>>>>>     #include <linux/dmi.h>
>>>>>>     #include <linux/err.h>
>>>>>>     #include <linux/hwmon.h>
>>>>>> @@ -16,6 +17,7 @@
>>>>>>     #include <linux/module.h>
>>>>>>     #include <linux/platform_device.h>
>>>>>>     #include <linux/power_supply.h>
>>>>>> +#include <linux/sysfs.h>
>>>>>>     #include <acpi/battery.h>
>>>>>>
>>>>>>     #define AYANEO_PWM_ENABLE_REG        0x4A
>>>>>> @@ -32,9 +34,17 @@
>>>>>>     #define AYANEO_CHARGE_VAL_AUTO              0xaa
>>>>>>     #define AYANEO_CHARGE_VAL_INHIBIT   0x55
>>>>>>
>>>>>> +#define AYANEO_POWER_REG     0x2d
>>>>>> +#define AYANEO_POWER_OFF     0xfe
>>>>>> +#define AYANEO_POWER_ON              0xff
>>>>>> +#define AYANEO_MODULE_REG    0x2f
>>>>>> +#define AYANEO_MODULE_LEFT   BIT(0)
>>>>>> +#define AYANEO_MODULE_RIGHT  BIT(1)
>>>>> Using GENMASK() would make sense here.
>>>> Only a single bit is being used though? GENMASK is used for a contigu=
ous series?
>>> I was thinking of using GENMASK() for both bits:
>>>
>>> #define AYANEO_MODULE_MASK      GENMASK(1, 0)
>>>
>>> You can then retrieve both bits using FIELD_GET() and simply use a swi=
tch statement
>>> together with an enum in controller_modules_show().
>> I will look at it closer if I revise the first 5 patches. The logic of
>> the register is complicated due to the flip, so I would not be eager
>> to.
>>
>> I could do #define AYANEO_MODULE_MASK (AYANEO_MODULE_LEFT |
>> AYANEO_MODULE_RIGHT) for stylistic reasons.
> Hi,
>
> Quickly looking at the code below, a mask define certainly be useful to
> avoid having to embed that into the switch itself below.
>
>> @Ilpo: for the first 5 of this series is there something missing other
>> than perhaps the month? If not, I can respin the last patch on its own
>> later today. I would like this driver + the asus stuff to go into 6.19
>> if possible (there: i dealt with the asusctl bug by skipping the
>> quirk), I am unsure for the timeline for that. I want to say merge
>> window starts in two weeks?
> I've been sick for almost a week so I'm a bit lost with all the progress
> and status with various series so it takes time to catch up until can
> say something when it comes to any particular series (I'm sorry).

I wish you a speedy recovery :)

Thanks,
Armin Wolf

> However, we're only at -rc4 (since Nov 2) so there's 4 or 5 weeks until
> the merge window. And this is new driver so no regression potential othe=
r
> than build failures so I don't see big schedule pressure yet, tbh.
>
> I try to take it into the consideration with my review scheduling even
> under normal circumstances that submitters have the opportunity to make =
it
> assuming one makes suggested changes (if any) in a reasonable time frame=
.
>
> It generally helps to pay attention to the kernel cycle as closer to the
> merge window we get, it usually helps to prioritize things right, e.g.,
> sending a series on the last week or close to it, getting trivial
> feedback, and not addressing it timely with an update will result in
> missing that kernel cycle; honestly, I always get a bit sad when I see
> people do that.
>
>
>> Antheas
>>
>>> Thanks,
>>> Armin Wolf
>>>
>>>>> With those issues being fixed:
>>>>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>>>>>
>>>>>> +
>>>>>>     struct ayaneo_ec_quirk {
>>>>>>         bool has_fan_control;
>>>>>>         bool has_charge_control;
>>>>>> +     bool has_magic_modules;
>>>>>>     };
>>>>>>
>>>>>>     struct ayaneo_ec_platform_data {
>>>>>> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
>>>>>>     static const struct ayaneo_ec_quirk quirk_ayaneo3 =3D {
>>>>>>         .has_fan_control =3D true,
>>>>>>         .has_charge_control =3D true,
>>>>>> +     .has_magic_modules =3D true,
>>>>>>     };
>>>>>>
>>>>>>     static const struct dmi_system_id dmi_table[] =3D {
>>>>>> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power=
_supply *battery,
>>>>>>         return 0;
>>>>>>     }
>>>>>>
>>>>>> +static ssize_t controller_power_store(struct device *dev,
>>>>>> +                                   struct device_attribute *attr,
>>>>>> +                                   const char *buf,
>>>>>> +                                   size_t count)
>>>>>> +{
>>>>>> +     bool value;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     ret =3D kstrtobool(buf, &value);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     ret =3D ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : =
AYANEO_POWER_OFF);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     return count;
>>>>>> +}
>>>>>> +
>>>>>> +static ssize_t controller_power_show(struct device *dev,
>>>>>> +                                  struct device_attribute *attr,
>>>>>> +                                  char *buf)
>>>>>> +{
>>>>>> +     int ret;
>>>>>> +     u8 val;
>>>>>> +
>>>>>> +     ret =3D ec_read(AYANEO_POWER_REG, &val);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     return sysfs_emit(buf, "%d\n", val =3D=3D AYANEO_POWER_ON);
>>>>>> +}
>>>>>> +
>>>>>> +static DEVICE_ATTR_RW(controller_power);
>>>>>> +
>>>>>> +static ssize_t controller_modules_show(struct device *dev,
>>>>>> +                                    struct device_attribute *attr,=
 char *buf)
>>>>>> +{
>>>>>> +     char *out;
>>>>>> +     int ret;
>>>>>> +     u8 val;
>>>>>> +
>>>>>> +     ret =3D ec_read(AYANEO_MODULE_REG, &val);
>>>>>> +     if (ret)
>>>>>> +             return ret;
>>>>>> +
>>>>>> +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {
> Why's the extra inversion here? Do those bits actually have the opposite
> meaning compared with their names?
>
> --
>   i.
>
>>>>>> +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
>>>>>> +             out =3D "both";
>>>>>> +             break;
>>>>>> +     case AYANEO_MODULE_LEFT:
>>>>>> +             out =3D "left";
>>>>>> +             break;
>>>>>> +     case AYANEO_MODULE_RIGHT:
>>>>>> +             out =3D "right";
>>>>>> +             break;
>>>>>> +     default:
>>>>>> +             out =3D "none";
>>>>>> +             break;
>>>>>> +     }
>>>>>> +
>>>>>> +     return sysfs_emit(buf, "%s\n", out);
>>>>>> +}
>>>>>> +
>>>>>> +static DEVICE_ATTR_RO(controller_modules);
>>>>>> +
>>>>>> +static struct attribute *aya_mm_attrs[] =3D {
>>>>>> +     &dev_attr_controller_power.attr,
>>>>>> +     &dev_attr_controller_modules.attr,
>>>>>> +     NULL
>>>>>> +};
>>>>>> +
>>>>>> +static umode_t aya_mm_is_visible(struct kobject *kobj,
>>>>>> +                              struct attribute *attr, int n)
>>>>>> +{
>>>>>> +     struct device *dev =3D kobj_to_dev(kobj);
>>>>>> +     struct platform_device *pdev =3D to_platform_device(dev);
>>>>>> +     struct ayaneo_ec_platform_data *data =3D platform_get_drvdata=
(pdev);
>>>>>> +
>>>>>> +     if (data->quirks->has_magic_modules)
>>>>>> +             return attr->mode;
>>>>>> +     return 0;
>>>>>> +}
>>>>>> +
>>>>>> +static const struct attribute_group aya_mm_attribute_group =3D {
>>>>>> +     .is_visible =3D aya_mm_is_visible,
>>>>>> +     .attrs =3D aya_mm_attrs,
>>>>>> +};
>>>>>> +
>>>>>> +static const struct attribute_group *ayaneo_ec_groups[] =3D {
>>>>>> +     &aya_mm_attribute_group,
>>>>>> +     NULL
>>>>>> +};
>>>>>> +
>>>>>>     static int ayaneo_ec_probe(struct platform_device *pdev)
>>>>>>     {
>>>>>>         const struct dmi_system_id *dmi_entry;
>>>>>> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_devi=
ce *pdev)
>>>>>>     static struct platform_driver ayaneo_platform_driver =3D {
>>>>>>         .driver =3D {
>>>>>>                 .name =3D "ayaneo-ec",
>>>>>> +             .dev_groups =3D ayaneo_ec_groups,
>>>>>>         },
>>>>>>         .probe =3D ayaneo_ec_probe,
>>>>>>     };

