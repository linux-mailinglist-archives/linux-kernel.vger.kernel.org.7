Return-Path: <linux-kernel+bounces-842692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD5BBD508
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C6A1349A50
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F4325BF15;
	Mon,  6 Oct 2025 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMi81qh9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE525B31B;
	Mon,  6 Oct 2025 08:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738327; cv=none; b=c5oZfxyP7eegShkYF0Dd1Oj8rGV+ECpXoVQKiiufzxMY0vIw6qmoxT7QAeyDmuOPhl0FbXMxZNAXJlOwnxYFJ0+Lu2IpSC8icRAcgodu4eU2WcPTcueS/mt9406NmaBb0N7a1uQCpW9UHoCcTlwavSoKFA9IYLsWqHZeUPknohA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738327; c=relaxed/simple;
	bh=vN8JDre0nmaGoiFscKqOTbXiqtUsvVmQRYFpHz2DVHc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cWYbK3bWJlv1noeo608GshAoAoevinqcwzUtZ1PHgP3HIo9JPccEHIFbZwftvG0woP+fPCoHwkJmskYA62MQba9X5GU+zEGC7xo0B/aZDO2tz7brII9GQMQeZIcYa+1sjIC9KysASKhVJOcvnLM0DVRgwNE5y/fq1mqaJxNbQHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMi81qh9; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759738325; x=1791274325;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vN8JDre0nmaGoiFscKqOTbXiqtUsvVmQRYFpHz2DVHc=;
  b=aMi81qh9HDLO3D3+nPe2DKHp0NlJbpZ6NIRu3LK6vS0VsBpHufEQJB2a
   iD8FSpyUweS0Pi1JlQmU6vzO+BvIHJ2BQ55eTkH/MFpRMiOe7sbqbLiSF
   yhvtSWYdw3cm9KJPIywhzKp7kOfxV/phYgvwH0m2lsNTcBJ+cnnLvCBqn
   J8J6rM6as74Rb5lZX0T/6o0fTmykIOP3LZ0jzoCacDmDUpUMR5RexvBVv
   V7PR1k/ApsRbXmUBAMaiBH435BA8+WgFrVTgJR0nutGMo2ETkbHDePJhb
   6MlT3xg9F3YYWYw4CnPHkilVK4VwMSAV9ebwbUOBCrEqtHRUuUfxRSqQX
   w==;
X-CSE-ConnectionGUID: ajEIN0lxShmwpaXr0yHcGA==
X-CSE-MsgGUID: 2dc/tqFtR564yRJFIS7wJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="61943273"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="61943273"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:12:04 -0700
X-CSE-ConnectionGUID: yLky3Q+oS5iD+W7fHD8k6w==
X-CSE-MsgGUID: TS4XMNmCQ+67cJ4t/Gi4Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="179492750"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 01:12:03 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 6 Oct 2025 11:11:59 +0300 (EEST)
To: Armin Wolf <W_Armin@gmx.de>
cc: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com, 
    kuurtb@gmail.com, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] platform/x86: acer-wmi: Add fan control support
In-Reply-To: <2e942b2e-e697-4298-8328-2dd773a8cb4a@gmx.de>
Message-ID: <04bffbcf-0520-d1d1-d3a5-b173976ff132@linux.intel.com>
References: <20250923215205.326367-1-W_Armin@gmx.de> <20250923215205.326367-3-W_Armin@gmx.de> <3e5a0387-9850-c85e-8636-71590133117d@linux.intel.com> <2e942b2e-e697-4298-8328-2dd773a8cb4a@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-91364725-1759738319=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-91364725-1759738319=:943
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 2 Oct 2025, Armin Wolf wrote:

> Am 24.09.25 um 12:52 schrieb Ilpo J=C3=A4rvinen:
>=20
> > On Tue, 23 Sep 2025, Armin Wolf wrote:
> >=20
> > > Add support for controlling the fan speed using the
> > > SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.
> > >=20
> > > This feature is only enabled if the machine has ACER_CAP_PWM enabled
> > > and depend on ACER_CAP_HWMON for detecting the number of available
> > > fans.
> > >=20
> > > Reviewed-by: Kurt Borja <kuurtb@gmail.com>
> > > Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> > > ---
> > >   drivers/platform/x86/acer-wmi.c | 221 +++++++++++++++++++++++++++++=
++-
> > >   1 file changed, 219 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/acer-wmi.c
> > > b/drivers/platform/x86/acer-wmi.c
> > > index a41555ee8589..345b6e24ae31 100644
> > > --- a/drivers/platform/x86/acer-wmi.c
> > > +++ b/drivers/platform/x86/acer-wmi.c
> > > @@ -12,10 +12,12 @@
> > >   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> > >     #include <linux/kernel.h>
> > > +#include <linux/minmax.h>
> > >   #include <linux/module.h>
> > >   #include <linux/init.h>
> > >   #include <linux/types.h>
> > >   #include <linux/dmi.h>
> > > +#include <linux/fixp-arith.h>
> > >   #include <linux/backlight.h>
> > >   #include <linux/leds.h>
> > >   #include <linux/platform_device.h>
> > > @@ -69,11 +71,16 @@ MODULE_LICENSE("GPL");
> > >   #define ACER_WMID_GET_GAMING_LED_METHODID 4
> > >   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
> > >   #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
> > > +#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
> > > +#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
> > > +#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
> > >   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
> > >   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
> > >   +#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
> > >   #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
> > >   #define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
> > > +#define ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK GENMASK_ULL(23, 8)
> > >     #define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
> > >   #define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
> > > @@ -81,6 +88,10 @@ MODULE_LICENSE("GPL");
> > >   #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
> > >   #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
> > >   +#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
> > > +#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
> > > +#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
> > > +
> > >   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
> > >   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
> > >   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
> > > @@ -130,6 +141,11 @@ enum acer_wmi_predator_v4_sensor_id {
> > >   =09ACER_WMID_SENSOR_GPU_TEMPERATURE=09=3D 0x0A,
> > >   };
> > >   +enum acer_wmi_gaming_fan_id {
> > > +=09ACER_WMID_CPU_FAN=09=3D 0x01,
> > > +=09ACER_WMID_GPU_FAN=09=3D 0x04,
> > > +};
> > In patch 1 you added these:
> >=20
> > +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
> > ...
> > +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
> > +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
> >=20
> > Are these numbers related (you even called the field "ID mask")? Could =
we
> > do with less defines for the same thing if they're related?
>=20
> I honestly don't know if those IDs are related. I would like to play it s=
afe
> and keep them separate for now.
>=20
> > >   enum acer_wmi_gaming_fan_mode {
> > >   =09ACER_WMID_FAN_MODE_AUTO=09=09=3D 0x01,
> > >   =09ACER_WMID_FAN_MODE_TURBO=09=3D 0x02,
> > > @@ -292,6 +308,7 @@ struct hotkey_function_type_aa {
> > >   #define ACER_CAP_TURBO_FAN=09=09BIT(9)
> > >   #define ACER_CAP_PLATFORM_PROFILE=09BIT(10)
> > >   #define ACER_CAP_HWMON=09=09=09BIT(11)
> > > +#define ACER_CAP_PWM=09=09=09BIT(12)
> > >     /*
> > >    * Interface type flags
> > > @@ -386,6 +403,7 @@ struct quirk_entry {
> > >   =09u8 cpu_fans;
> > >   =09u8 gpu_fans;
> > >   =09u8 predator_v4;
> > > +=09u8 pwm;
> > >   };
> > >     static struct quirk_entry *quirks;
> > > @@ -405,6 +423,9 @@ static void __init set_quirks(void)
> > >   =09if (quirks->predator_v4)
> > >   =09=09interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
> > >   =09=09=09=09=09 ACER_CAP_HWMON;
> > > +
> > > +=09if (quirks->pwm)
> > > +=09=09interface->capability |=3D ACER_CAP_PWM;
> > >   }
> > >     static int __init dmi_matched(const struct dmi_system_id *dmi)
> > > @@ -1651,6 +1672,27 @@ static int WMID_gaming_set_fan_behavior(u16
> > > fan_bitmap, u8 mode_bitmap)
> > >   =09return 0;
> > >   }
> > >   +static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, u8
> > > *mode_bitmap)
> > > +{
> > > +=09acpi_status status;
> > > +=09u32 input =3D 0;
> > > +=09u64 result;
> > > +
> > > +=09input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitma=
p);
> > > +=09status =3D
> > > WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID=
,
> > > input,
> > > +=09=09=09=09=09    &result);
> > > +=09if (ACPI_FAILURE(status))
> > > +=09=09return -EIO;
> > > +
> > > +=09/* The return status must be zero for the operation to have succe=
eded
> > > */
> > > +=09if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
> > > +=09=09return -EIO;
> > > +
> > > +=09*mode_bitmap =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK=
,
> > > result);
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > >   static void WMID_gaming_set_fan_mode(u8 fan_mode)
> > >   {
> > >   =09u16 mode_bitmap =3D 0;
> > > @@ -1669,6 +1711,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mo=
de)
> > >   =09WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
> > >   }
> > >   +static int WMID_gaming_set_gaming_fan_speed(u8 fan, u8 speed)
> > > +{
> > > +=09acpi_status status;
> > > +=09u64 input =3D 0;
> > > +=09u64 result;
> > > +
> > > +=09if (speed > 100)
> > > +=09=09return -EINVAL;
> > > +
> > > +=09input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
> > > +=09input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_VALUE_MASK, speed);
> > > +
> > > +=09status =3D
> > > WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_SPEED_METHODID, input=
,
> > > &result);
> > > +=09if (ACPI_FAILURE(status))
> > > +=09=09return -EIO;
> > > +
> > > +=09switch (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result)) {
> > > +=09case 0x00:
> > > +=09=09return 0;
> > > +=09case 0x01:
> > > +=09=09return -ENODEV;
> > > +=09case 0x02:
> > > +=09=09return -EINVAL;
> > > +=09default:
> > > +=09=09return -ENXIO;
> > > +=09}
> > > +}
> > > +
> > > +static int WMID_gaming_get_gaming_fan_speed(u8 fan, u8 *speed)
> > > +{
> > > +=09acpi_status status;
> > > +=09u32 input =3D 0;
> > > +=09u64 result;
> > > +
> > > +=09input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
> > > +
> > > +=09status =3D
> > > WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_SPEED_METHODID, i=
nput,
> > > +=09=09=09=09=09    &result);
> > > +=09if (ACPI_FAILURE(status))
> > > +=09=09return -EIO;
> > > +
> > > +=09if (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result))
> > > +=09=09return -ENODEV;
> > > +
> > > +=09*speed =3D FIELD_GET(ACER_GAMING_FAN_SPEED_VALUE_MASK, result);
> > > +
> > > +=09return 0;
> > > +}
> > > +
> > >   static int WMID_gaming_set_misc_setting(enum
> > > acer_wmi_gaming_misc_setting setting, u8 value)
> > >   {
> > >   =09acpi_status status;
> > > @@ -2840,6 +2931,16 @@ static const enum acer_wmi_predator_v4_sensor_=
id
> > > acer_wmi_fan_channel_to_sensor_
> > >   =09[1] =3D ACER_WMID_SENSOR_GPU_FAN_SPEED,
> > >   };
> > >   +static const enum acer_wmi_gaming_fan_id
> > > acer_wmi_fan_channel_to_fan_id[] =3D {
> > > +=09[0] =3D ACER_WMID_CPU_FAN,
> > > +=09[1] =3D ACER_WMID_GPU_FAN,
> > > +};
> > > +
> > > +static const u16 acer_wmi_fan_channel_to_fan_bitmap[] =3D {
> > > +=09[0] =3D ACER_GAMING_FAN_BEHAVIOR_CPU,
> > > +=09[1] =3D ACER_GAMING_FAN_BEHAVIOR_GPU,
> > > +};
> > > +
> > >   static umode_t acer_wmi_hwmon_is_visible(const void *data,
> > >   =09=09=09=09=09 enum hwmon_sensor_types type, u32
> > > attr,
> > >   =09=09=09=09=09 int channel)
> > > @@ -2851,6 +2952,11 @@ static umode_t acer_wmi_hwmon_is_visible(const=
 void
> > > *data,
> > >   =09case hwmon_temp:
> > >   =09=09sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
> > >   =09=09break;
> > > +=09case hwmon_pwm:
> > > +=09=09if (!has_cap(ACER_CAP_PWM))
> > > +=09=09=09return 0;
> > > +
> > > +=09=09fallthrough;
> > >   =09case hwmon_fan:
> > >   =09=09sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
> > >   =09=09break;
> > > @@ -2858,8 +2964,12 @@ static umode_t acer_wmi_hwmon_is_visible(const=
 void
> > > *data,
> > >   =09=09return 0;
> > >   =09}
> > >   -=09if (*supported_sensors & BIT(sensor_id - 1))
> > > +=09if (*supported_sensors & BIT(sensor_id - 1)) {
> > > +=09=09if (type =3D=3D hwmon_pwm)
> > > +=09=09=09return 0644;
> > > +
> > >   =09=09return 0444;
> > > +=09}
> > >     =09return 0;
> > >   }
> > > @@ -2868,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *=
dev,
> > > enum hwmon_sensor_types type,
> > >   =09=09=09       u32 attr, int channel, long *val)
> > >   {
> > >   =09u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
> > > +=09u8 fan, speed, mode_bitmap;
> > > +=09u16 fan_bitmap;
> > > +=09int mode, ret;
> > >   =09u64 result;
> > > -=09int ret;
> > >     =09switch (type) {
> > >   =09case hwmon_temp:
> > > @@ -2893,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device =
*dev,
> > > enum hwmon_sensor_types type,
> > >     =09=09*val =3D
> > > FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result);
> > >   =09=09return 0;
> > > +=09case hwmon_pwm:
> > > +=09=09switch (attr) {
> > > +=09=09case hwmon_pwm_input:
> > > +=09=09=09fan =3D acer_wmi_fan_channel_to_fan_id[channel];
> > > +=09=09=09ret =3D WMID_gaming_get_gaming_fan_speed(fan, &speed);
> > > +=09=09=09if (ret < 0)
> > > +=09=09=09=09return ret;
> > > +
> > > +=09=09=09*val =3D fixp_linear_interpolate(0, 0, 100, U8_MAX,
> > > speed);
> > > +=09=09=09return 0;
> > > +=09=09case hwmon_pwm_enable:
> > > +=09=09=09fan_bitmap =3D
> > > acer_wmi_fan_channel_to_fan_bitmap[channel];
> > > +=09=09=09ret =3D WMID_gaming_get_fan_behavior(fan_bitmap,
> > > &mode_bitmap);
> > > +=09=09=09if (ret < 0)
> > > +=09=09=09=09return ret;
> > > +
> > > +=09=09=09switch (channel) {
> > > +=09=09=09case 0:
> > > +=09=09=09=09mode =3D
> > > FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
> > > +=09=09=09=09=09=09 mode_bitmap);
> > > +=09=09=09=09break;
> > > +=09=09=09case 1:
> > > +=09=09=09=09mode =3D
> > > FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
> > > +=09=09=09=09=09=09 mode_bitmap);
> > > +=09=09=09=09break;
> > > +=09=09=09default:
> > > +=09=09=09=09return -EINVAL;
> > > +=09=09=09}
> > You've managed to create an internal API that resembles the WMI method
> > input by working in terms of fan_bitmap and mode_bitmap which makes thi=
ngs
> > complicated as then you have to build logic on top of it to do all the
> > mapping in the caller...
> >=20
> > I suggest changing this so you make WMID_gaming_get_fan_behavior() to
> > input ACER_GAMING_FAN_BEHAVIOR_CPU / GPU (or ACER_WMID_CPU_FAN / GPU_FA=
N
> > depending on the question I asked above) and perform the output mapping
> > within that function. I think it would be much cleaner.
> >=20
> > I didn't exactly like the internal API in patch 1 either and I'd prefer
> > the field GENMASK()s to directly point to the correct bits instead of t=
he
> > nested FIELD_GET/PREP()s.
>=20
> Ok, will do.
>=20
> > > +=09=09=09switch (mode) {
> > > +=09=09=09case ACER_WMID_FAN_MODE_AUTO:
> > > +=09=09=09=09*val =3D 2;
> > > +=09=09=09=09return 0;
> > > +=09=09=09case ACER_WMID_FAN_MODE_TURBO:
> > > +=09=09=09=09*val =3D 0;
> > > +=09=09=09=09return 0;
> > > +=09=09=09case ACER_WMID_FAN_MODE_CUSTOM:
> > > +=09=09=09=09*val =3D 1;
> > > +=09=09=09=09return 0;
> > > +=09=09=09default:
> > > +=09=09=09=09return -ENXIO;
> > > +=09=09=09}
> > > +=09=09default:
> > > +=09=09=09return -EOPNOTSUPP;
> > > +=09=09}
> > > +=09default:
> > > +=09=09return -EOPNOTSUPP;
> > > +=09}
> > > +}
> > > +
> > > +static int acer_wmi_hwmon_write(struct device *dev, enum
> > > hwmon_sensor_types type,
> > > +=09=09=09=09u32 attr, int channel, long val)
> > > +{
> > > +=09u8 fan, speed, mode_bitmap;
> > > +=09u16 fan_bitmap;
> > > +=09int mode;
> > > +
> > > +=09switch (type) {
> > > +=09case hwmon_pwm:
> > > +=09=09switch (attr) {
> > > +=09=09case hwmon_pwm_input:
> > > +=09=09=09fan =3D acer_wmi_fan_channel_to_fan_id[channel];
> > > +=09=09=09speed =3D fixp_linear_interpolate(0, 0, U8_MAX, 100,
> > > +=09=09=09=09=09=09=09clamp_val(val, 0,
> > > U8_MAX));
> > > +
> > > +=09=09=09return WMID_gaming_set_gaming_fan_speed(fan, speed);
> > > +=09=09case hwmon_pwm_enable:
> > > +=09=09=09fan_bitmap =3D
> > > acer_wmi_fan_channel_to_fan_bitmap[channel];
> > > +
> > > +=09=09=09switch (val) {
> > > +=09=09=09case 0:
> > > +=09=09=09=09mode =3D ACER_WMID_FAN_MODE_TURBO;
> > > +=09=09=09=09break;
> > > +=09=09=09case 1:
> > > +=09=09=09=09mode =3D ACER_WMID_FAN_MODE_CUSTOM;
> > > +=09=09=09=09break;
> > > +=09=09=09case 2:
> > > +=09=09=09=09mode =3D ACER_WMID_FAN_MODE_AUTO;
> > > +=09=09=09=09break;
> > > +=09=09=09default:
> > > +=09=09=09=09return -EINVAL;
> > > +=09=09=09}
> > > +
> > > +=09=09=09switch (channel) {
> > > +=09=09=09case 0:
> > > +=09=09=09=09mode_bitmap =3D
> > > FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
> > > +=09=09=09=09=09=09=09 mode);
> > > +=09=09=09=09break;
> > > +=09=09=09case 1:
> > > +=09=09=09=09mode_bitmap =3D
> > > FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
> > > +=09=09=09=09=09=09=09 mode);
> > > +=09=09=09=09break;
> > > +=09=09=09default:
> > > +=09=09=09=09return -EINVAL;
> > > +=09=09=09}
> > These too look they could be mapped inside WMID_gaming_set_fan_behavior=
().
>=20
> I don't think so, as the function also needs to handle the setting of mul=
tiple
> fans
> at once.

Oh, right. How about making it two functions then, one which is called=20
from here to set one fan and which then internally calls into the=20
function that can set any fans?


--=20
 i.

--8323328-91364725-1759738319=:943--

