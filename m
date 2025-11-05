Return-Path: <linux-kernel+bounces-886523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 295ADC35D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2CA024F1952
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A26B31D390;
	Wed,  5 Nov 2025 13:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGEydwKI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011E73168EF;
	Wed,  5 Nov 2025 13:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349106; cv=none; b=ms4d/sFBsgDIe3AY6kSyB01fUiMbMvMNXFqwumFzVv2v9ZgMXUEhbP7AOqFqR5os4YDpkE9vBBNuK3pgaIOsLHmQgxvR59Mw5iTBKVmUcunlOQlx8K26G9XHxasJie8bHUyGdZYjf7XEZojOdMdSPwVoNfvgdh9+nxVXniWiByg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349106; c=relaxed/simple;
	bh=JwNKRV+eYYREgTQ+7TUVEnascJq7tOfFsvwot3B459s=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EpwrnjUA7Ygbj7t6lwiRMTwzbRsSapWLv2EwlA6FQJGC6zWmm3A5kYOHDzj3Eks+zkkYm4DEyrgBwXvpuGlXyW0RgI9jLf39xxd8ysCBxvEI2v09s+4psJCkFmUqgrt4CA0H5xx+6Uj26HbKzXJoEb4we3AfVIO5Ll39az1DlGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGEydwKI; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762349104; x=1793885104;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JwNKRV+eYYREgTQ+7TUVEnascJq7tOfFsvwot3B459s=;
  b=JGEydwKIZObH3mkHLuLvDViXn5PxdtGKgk6nEPBdqPoyTKsVqRIJlnqh
   RZqsm+f+yshZZhwP/5uJ+tBc4l8KGo8CbaJWMF/FemW7ZjiX4yjvfcQxt
   8JHhRi29U3EiIRheRuf9k25vT+77EUnV+RH2JDORdtzGQJua/M+aa/wiJ
   1y8ZQt5ue65FoeFBRumCbtilCbg4OxEu6+MyOggL4JeJ2nI773l2QLWmX
   YKfuLyNg/ohVCtitygAJfb1bojvm3mgE8Et2VY0OimHfipdSDkUL+J6yT
   CJ6QTWWExUyL/UJcm2d5gfY9Kfqcknwn0I1yD0qQQ0VqWWe3J6DRPEt0T
   w==;
X-CSE-ConnectionGUID: jZ3Ebjn5QfCau+BH2tw+qA==
X-CSE-MsgGUID: cKURAofZTxKe0GGfccbO/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="52031549"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="52031549"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:25:03 -0800
X-CSE-ConnectionGUID: E2KV6fg7RReHc/SlDi4dXQ==
X-CSE-MsgGUID: IEvAoTW1Sq6Ns9GAT3hptw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="186704655"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.252])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 05:24:59 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 5 Nov 2025 15:24:56 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: Armin Wolf <W_Armin@gmx.de>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org, 
    Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3 4/6] platform/x86: ayaneo-ec: Add controller power
 and modules attributes
In-Reply-To: <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
Message-ID: <1e9d5311-45f9-15fa-ce3e-8098c288acbd@linux.intel.com>
References: <20251031163651.1465981-1-lkml@antheas.dev> <20251031163651.1465981-5-lkml@antheas.dev> <7c521e72-1b32-4172-90ec-6e793941a8ed@gmx.de> <CAGwozwFRF11dH02SRRNCyiYW7dNuoYoGWfPdEWPoim2r-KoZ0g@mail.gmail.com> <e0b29b59-b37d-4c44-ab97-9527b0f959b1@gmx.de>
 <CAGwozwFJiQeD3kCd-=vkkt4wcjwhL=ETaY7br+7+B7KdNXSL2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 5 Nov 2025, Antheas Kapenekakis wrote:

> On Tue, 4 Nov 2025 at 21:04, Armin Wolf <W_Armin@gmx.de> wrote:
> >
> > Am 02.11.25 um 19:46 schrieb Antheas Kapenekakis:
> >
> > > On Sun, 2 Nov 2025 at 19:30, Armin Wolf <W_Armin@gmx.de> wrote:
> > >> Am 31.10.25 um 17:36 schrieb Antheas Kapenekakis:
> > >>
> > >>> The Ayaneo 3 features hot-swappable controller modules. The ejection
> > >>> and management is done through HID. However, after ejecting the modules,
> > >>> the controller needs to be power cycled via the EC to re-initialize.
> > >>>
> > >>> For this, the EC provides a variable that holds whether the left or
> > >>> right modules are connected, and a power control register to turn
> > >>> the controller on or off. After ejecting the modules, the controller
> > >>> should be turned off. Then, after both modules are reinserted,
> > >>> the controller may be powered on again to re-initialize.
> > >>>
> > >>> This patch introduces two new sysfs attributes:
> > >>>    - `controller_modules`: a read-only attribute that indicates whether
> > >>>      the left and right modules are connected (none, left, right, both).
> > >>>    - `controller_power`: a read-write attribute that allows the user
> > >>>      to turn the controller on or off (with '1'/'0').
> > >>>
> > >>> Therefore, after ejection is complete, userspace can power off the
> > >>> controller, then wait until both modules have been reinserted
> > >>> (`controller_modules` will return 'both') to turn on the controller.
> > >>>
> > >>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > >>> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > >>> ---
> > >>>    .../ABI/testing/sysfs-platform-ayaneo-ec      |  19 ++++
> > >>>    MAINTAINERS                                   |   1 +
> > >>>    drivers/platform/x86/ayaneo-ec.c              | 106 ++++++++++++++++++
> > >>>    3 files changed, 126 insertions(+)
> > >>>    create mode 100644 Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > >>>
> > >>> diff --git a/Documentation/ABI/testing/sysfs-platform-ayaneo-ec b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > >>> new file mode 100644
> > >>> index 000000000000..3c9c3580c685
> > >>> --- /dev/null
> > >>> +++ b/Documentation/ABI/testing/sysfs-platform-ayaneo-ec
> > >>> @@ -0,0 +1,19 @@
> > >>> +What:                /sys/devices/platform/ayaneo-ec/controller_power
> > >>> +Date:                Oct 2025
> > >> I think you need to update those dates.
> > >>
> > >>> +KernelVersion:       6.19
> > >>> +Contact:     "Antheas Kapenekakis" <lkml@antheas.dev>
> > >>> +Description:
> > >>> +             Current controller power state. Allows turning on and off
> > >>> +             the controller power (e.g. for power savings). Write 1 to
> > >>> +             turn on, 0 to turn off. File is readable and writable.
> > >>> +
> > >>> +What:                /sys/devices/platform/ayaneo-ec/controller_modules
> > >>> +Date:                Oct 2025
> > >>> +KernelVersion:       6.19
> > >>> +Contact:     "Antheas Kapenekakis"  <lkml@antheas.dev>
> > >>> +Description:
> > >>> +             Shows which controller modules are currently connected to
> > >>> +             the device. Possible values are "left", "right" and "both".
> > >>> +             File is read-only. The Windows software for this device
> > >>> +             will only set controller power to 1 if both module sides
> > >>> +             are connected (i.e. this file returns "both").
> > >>> diff --git a/MAINTAINERS b/MAINTAINERS
> > >>> index da9498d8cc89..b4d62ea9a926 100644
> > >>> --- a/MAINTAINERS
> > >>> +++ b/MAINTAINERS
> > >>> @@ -4191,6 +4191,7 @@ AYANEO PLATFORM EC DRIVER
> > >>>    M:  Antheas Kapenekakis <lkml@antheas.dev>
> > >>>    L:  platform-driver-x86@vger.kernel.org
> > >>>    S:  Maintained
> > >>> +F:   Documentation/ABI/testing/sysfs-platform-ayaneo
> > >>>    F:  drivers/platform/x86/ayaneo-ec.c
> > >>>
> > >>>    AZ6007 DVB DRIVER
> > >>> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> > >>> index 697bb053a7d6..0652c044ad76 100644
> > >>> --- a/drivers/platform/x86/ayaneo-ec.c
> > >>> +++ b/drivers/platform/x86/ayaneo-ec.c
> > >>> @@ -8,6 +8,7 @@
> > >>>     */
> > >>>
> > >>>    #include <linux/acpi.h>
> > >>> +#include <linux/bits.h>
> > >>>    #include <linux/dmi.h>
> > >>>    #include <linux/err.h>
> > >>>    #include <linux/hwmon.h>
> > >>> @@ -16,6 +17,7 @@
> > >>>    #include <linux/module.h>
> > >>>    #include <linux/platform_device.h>
> > >>>    #include <linux/power_supply.h>
> > >>> +#include <linux/sysfs.h>
> > >>>    #include <acpi/battery.h>
> > >>>
> > >>>    #define AYANEO_PWM_ENABLE_REG        0x4A
> > >>> @@ -32,9 +34,17 @@
> > >>>    #define AYANEO_CHARGE_VAL_AUTO              0xaa
> > >>>    #define AYANEO_CHARGE_VAL_INHIBIT   0x55
> > >>>
> > >>> +#define AYANEO_POWER_REG     0x2d
> > >>> +#define AYANEO_POWER_OFF     0xfe
> > >>> +#define AYANEO_POWER_ON              0xff
> > >>> +#define AYANEO_MODULE_REG    0x2f
> > >>> +#define AYANEO_MODULE_LEFT   BIT(0)
> > >>> +#define AYANEO_MODULE_RIGHT  BIT(1)
> > >> Using GENMASK() would make sense here.
> > > Only a single bit is being used though? GENMASK is used for a contiguous series?
> >
> > I was thinking of using GENMASK() for both bits:
> >
> > #define AYANEO_MODULE_MASK      GENMASK(1, 0)
> >
> > You can then retrieve both bits using FIELD_GET() and simply use a switch statement
> > together with an enum in controller_modules_show().
> 
> I will look at it closer if I revise the first 5 patches. The logic of
> the register is complicated due to the flip, so I would not be eager
> to.
> 
> I could do #define AYANEO_MODULE_MASK (AYANEO_MODULE_LEFT |
> AYANEO_MODULE_RIGHT) for stylistic reasons.

Hi,

Quickly looking at the code below, a mask define certainly be useful to 
avoid having to embed that into the switch itself below.

> @Ilpo: for the first 5 of this series is there something missing other
> than perhaps the month? If not, I can respin the last patch on its own
> later today. I would like this driver + the asus stuff to go into 6.19
> if possible (there: i dealt with the asusctl bug by skipping the
> quirk), I am unsure for the timeline for that. I want to say merge
> window starts in two weeks?

I've been sick for almost a week so I'm a bit lost with all the progress 
and status with various series so it takes time to catch up until can 
say something when it comes to any particular series (I'm sorry).

However, we're only at -rc4 (since Nov 2) so there's 4 or 5 weeks until 
the merge window. And this is new driver so no regression potential other 
than build failures so I don't see big schedule pressure yet, tbh.

I try to take it into the consideration with my review scheduling even 
under normal circumstances that submitters have the opportunity to make it 
assuming one makes suggested changes (if any) in a reasonable time frame.

It generally helps to pay attention to the kernel cycle as closer to the 
merge window we get, it usually helps to prioritize things right, e.g., 
sending a series on the last week or close to it, getting trivial 
feedback, and not addressing it timely with an update will result in 
missing that kernel cycle; honestly, I always get a bit sad when I see 
people do that.


> Antheas
> 
> > Thanks,
> > Armin Wolf
> >
> > >> With those issues being fixed:
> > >> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> > >>
> > >>> +
> > >>>    struct ayaneo_ec_quirk {
> > >>>        bool has_fan_control;
> > >>>        bool has_charge_control;
> > >>> +     bool has_magic_modules;
> > >>>    };
> > >>>
> > >>>    struct ayaneo_ec_platform_data {
> > >>> @@ -46,6 +56,7 @@ struct ayaneo_ec_platform_data {
> > >>>    static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
> > >>>        .has_fan_control = true,
> > >>>        .has_charge_control = true,
> > >>> +     .has_magic_modules = true,
> > >>>    };
> > >>>
> > >>>    static const struct dmi_system_id dmi_table[] = {
> > >>> @@ -266,6 +277,100 @@ static int ayaneo_remove_battery(struct power_supply *battery,
> > >>>        return 0;
> > >>>    }
> > >>>
> > >>> +static ssize_t controller_power_store(struct device *dev,
> > >>> +                                   struct device_attribute *attr,
> > >>> +                                   const char *buf,
> > >>> +                                   size_t count)
> > >>> +{
> > >>> +     bool value;
> > >>> +     int ret;
> > >>> +
> > >>> +     ret = kstrtobool(buf, &value);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     ret = ec_write(AYANEO_POWER_REG, value ? AYANEO_POWER_ON : AYANEO_POWER_OFF);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     return count;
> > >>> +}
> > >>> +
> > >>> +static ssize_t controller_power_show(struct device *dev,
> > >>> +                                  struct device_attribute *attr,
> > >>> +                                  char *buf)
> > >>> +{
> > >>> +     int ret;
> > >>> +     u8 val;
> > >>> +
> > >>> +     ret = ec_read(AYANEO_POWER_REG, &val);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     return sysfs_emit(buf, "%d\n", val == AYANEO_POWER_ON);
> > >>> +}
> > >>> +
> > >>> +static DEVICE_ATTR_RW(controller_power);
> > >>> +
> > >>> +static ssize_t controller_modules_show(struct device *dev,
> > >>> +                                    struct device_attribute *attr, char *buf)
> > >>> +{
> > >>> +     char *out;
> > >>> +     int ret;
> > >>> +     u8 val;
> > >>> +
> > >>> +     ret = ec_read(AYANEO_MODULE_REG, &val);
> > >>> +     if (ret)
> > >>> +             return ret;
> > >>> +
> > >>> +     switch (~val & (AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT)) {

Why's the extra inversion here? Do those bits actually have the opposite 
meaning compared with their names?

--
 i.

> > >>> +     case AYANEO_MODULE_LEFT | AYANEO_MODULE_RIGHT:
> > >>> +             out = "both";
> > >>> +             break;
> > >>> +     case AYANEO_MODULE_LEFT:
> > >>> +             out = "left";
> > >>> +             break;
> > >>> +     case AYANEO_MODULE_RIGHT:
> > >>> +             out = "right";
> > >>> +             break;
> > >>> +     default:
> > >>> +             out = "none";
> > >>> +             break;
> > >>> +     }
> > >>> +
> > >>> +     return sysfs_emit(buf, "%s\n", out);
> > >>> +}
> > >>> +
> > >>> +static DEVICE_ATTR_RO(controller_modules);
> > >>> +
> > >>> +static struct attribute *aya_mm_attrs[] = {
> > >>> +     &dev_attr_controller_power.attr,
> > >>> +     &dev_attr_controller_modules.attr,
> > >>> +     NULL
> > >>> +};
> > >>> +
> > >>> +static umode_t aya_mm_is_visible(struct kobject *kobj,
> > >>> +                              struct attribute *attr, int n)
> > >>> +{
> > >>> +     struct device *dev = kobj_to_dev(kobj);
> > >>> +     struct platform_device *pdev = to_platform_device(dev);
> > >>> +     struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
> > >>> +
> > >>> +     if (data->quirks->has_magic_modules)
> > >>> +             return attr->mode;
> > >>> +     return 0;
> > >>> +}
> > >>> +
> > >>> +static const struct attribute_group aya_mm_attribute_group = {
> > >>> +     .is_visible = aya_mm_is_visible,
> > >>> +     .attrs = aya_mm_attrs,
> > >>> +};
> > >>> +
> > >>> +static const struct attribute_group *ayaneo_ec_groups[] = {
> > >>> +     &aya_mm_attribute_group,
> > >>> +     NULL
> > >>> +};
> > >>> +
> > >>>    static int ayaneo_ec_probe(struct platform_device *pdev)
> > >>>    {
> > >>>        const struct dmi_system_id *dmi_entry;
> > >>> @@ -307,6 +412,7 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
> > >>>    static struct platform_driver ayaneo_platform_driver = {
> > >>>        .driver = {
> > >>>                .name = "ayaneo-ec",
> > >>> +             .dev_groups = ayaneo_ec_groups,
> > >>>        },
> > >>>        .probe = ayaneo_ec_probe,
> > >>>    };
> >
> 

