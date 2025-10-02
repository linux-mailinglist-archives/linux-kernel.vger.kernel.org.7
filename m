Return-Path: <linux-kernel+bounces-840691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FDDBB4FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA93E7A17C6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2727C28369A;
	Thu,  2 Oct 2025 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ak6cdtqF"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED412741BC;
	Thu,  2 Oct 2025 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433033; cv=none; b=mMl3MKnP4d7n/Iz3SsCYisTwnQzKjNPrhJ7k9tylU+K43nKqkfajxjyazKkwDE6NChWgUoztMy4T5UnAh1SNZon6IN5+WxW+uAO2YbF+0J85pxZ5JDfqJ+MAR7DVSV3PkL9s9tVlvrDel20IuuAirfZ1jSir9p5DwUGRIJ3UxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433033; c=relaxed/simple;
	bh=96XzcRBV73V2NNJLhnvddDOm4sOgz0tQIumiLKyeUEg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNs86hBltBWI9BlFM2sZRYG6S+E0RbQU2+OKY63zgcnjgvGaD4R3kJnNVqDH/1GLtmi1DP3UBtnEiErr73o/WwNK/DK6wVPLgxLW5Nf6oEhO7XbEcQqOuuqdNA1BzcfeHHoTS3pFtq+Cmrnivpgwgo5qEXsH41ou8A+ozyvj+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ak6cdtqF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759433027; x=1760037827; i=w_armin@gmx.de;
	bh=beQ03b7X46i8G8OfOnUPeW+b/FQQwNys8zEumGGK4cY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ak6cdtqFIIBNLdzP/du/Y8FFyxX/s6CTaaM2XW8oxKYy3RtVZepYVq9UPcmQ19I8
	 sbIicco59BjX/winhTq0QBcoRNFIiRPT3/QdkCzupniNp05NtBHcWueOT05UyK2wH
	 3I+4g96JkqsN835QUBlaUUK7HexCZGb/8rH/PHPSBmKolaAvfH+iQHVxhKP+u2rvz
	 LNPi7Jf5BElIMCUgRX3HoHM4rIaCLiQmYtTUtrfwU8m6zfTViHKkdHr7Z0kcIJCea
	 01w+twQ1aodA469yWfwKbATNIeiPrps7EwdtsPxl6iMx4XTUhH2XWx18/cz8fqFwn
	 pVKsG3EK+gDiqyS65Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.150.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wq3-1uKJZb3ior-016EZ9; Thu, 02
 Oct 2025 21:23:47 +0200
Message-ID: <2e942b2e-e697-4298-8328-2dd773a8cb4a@gmx.de>
Date: Thu, 2 Oct 2025 21:23:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] platform/x86: acer-wmi: Add fan control support
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com,
 kuurtb@gmail.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250923215205.326367-1-W_Armin@gmx.de>
 <20250923215205.326367-3-W_Armin@gmx.de>
 <3e5a0387-9850-c85e-8636-71590133117d@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3e5a0387-9850-c85e-8636-71590133117d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zMllVIGHZNi4SKTpWdiyPqDVGtF71BFK8udnP9zM4iERjfULTLO
 HzP06vHPCRMHsBLTlY+yk34gRID2DzarnZX5E07PqdN0X3mxVHNG8/0rMze1ITgr/ZEWsHF
 WR5YVSoF9RE6iM6P7ymiJf9pRPJpieDyJPXrra5pgLOjIEGM+X/ts+iMbyBoUCjFJ2vUxOH
 V0qSrenuykEKB+oyqfSLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XKp8kasLJaQ=;NlYMZ3v09sv/r5TgN8/Zv0iWhdK
 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

Am 24.09.25 um 12:52 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 23 Sep 2025, Armin Wolf wrote:
>
>> Add support for controlling the fan speed using the
>> SetGamingFanSpeed() and GetGamingFanSpeed() WMI methods.
>>
>> This feature is only enabled if the machine has ACER_CAP_PWM enabled
>> and depend on ACER_CAP_HWMON for detecting the number of available
>> fans.
>>
>> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 221 +++++++++++++++++++++++++++++++=
-
>>   1 file changed, 219 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
>> index a41555ee8589..345b6e24ae31 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -12,10 +12,12 @@
>>   #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>  =20
>>   #include <linux/kernel.h>
>> +#include <linux/minmax.h>
>>   #include <linux/module.h>
>>   #include <linux/init.h>
>>   #include <linux/types.h>
>>   #include <linux/dmi.h>
>> +#include <linux/fixp-arith.h>
>>   #include <linux/backlight.h>
>>   #include <linux/leds.h>
>>   #include <linux/platform_device.h>
>> @@ -69,11 +71,16 @@ MODULE_LICENSE("GPL");
>>   #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>>   #define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>> +#define ACER_WMID_GET_GAMING_FAN_BEHAVIOR_METHODID 15
>> +#define ACER_WMID_SET_GAMING_FAN_SPEED_METHODID 16
>> +#define ACER_WMID_GET_GAMING_FAN_SPEED_METHODID 17
>>   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>  =20
>> +#define ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>>   #define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK GENMASK_ULL(23, 8)
>>  =20
>>   #define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>>   #define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>> @@ -81,6 +88,10 @@ MODULE_LICENSE("GPL");
>>   #define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>>   #define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>>  =20
>> +#define ACER_GAMING_FAN_SPEED_STATUS_MASK GENMASK_ULL(7, 0)
>> +#define ACER_GAMING_FAN_SPEED_ID_MASK GENMASK_ULL(7, 0)
>> +#define ACER_GAMING_FAN_SPEED_VALUE_MASK GENMASK_ULL(15, 8)
>> +
>>   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>> @@ -130,6 +141,11 @@ enum acer_wmi_predator_v4_sensor_id {
>>   	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
>>   };
>>  =20
>> +enum acer_wmi_gaming_fan_id {
>> +	ACER_WMID_CPU_FAN	=3D 0x01,
>> +	ACER_WMID_GPU_FAN	=3D 0x04,
>> +};
> In patch 1 you added these:
>
> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
> ...
> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>
> Are these numbers related (you even called the field "ID mask")? Could w=
e
> do with less defines for the same thing if they're related?

I honestly don't know if those IDs are related. I would like to play it sa=
fe
and keep them separate for now.

>>   enum acer_wmi_gaming_fan_mode {
>>   	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
>>   	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
>> @@ -292,6 +308,7 @@ struct hotkey_function_type_aa {
>>   #define ACER_CAP_TURBO_FAN		BIT(9)
>>   #define ACER_CAP_PLATFORM_PROFILE	BIT(10)
>>   #define ACER_CAP_HWMON			BIT(11)
>> +#define ACER_CAP_PWM			BIT(12)
>>  =20
>>   /*
>>    * Interface type flags
>> @@ -386,6 +403,7 @@ struct quirk_entry {
>>   	u8 cpu_fans;
>>   	u8 gpu_fans;
>>   	u8 predator_v4;
>> +	u8 pwm;
>>   };
>>  =20
>>   static struct quirk_entry *quirks;
>> @@ -405,6 +423,9 @@ static void __init set_quirks(void)
>>   	if (quirks->predator_v4)
>>   		interface->capability |=3D ACER_CAP_PLATFORM_PROFILE |
>>   					 ACER_CAP_HWMON;
>> +
>> +	if (quirks->pwm)
>> +		interface->capability |=3D ACER_CAP_PWM;
>>   }
>>  =20
>>   static int __init dmi_matched(const struct dmi_system_id *dmi)
>> @@ -1651,6 +1672,27 @@ static int WMID_gaming_set_fan_behavior(u16 fan_=
bitmap, u8 mode_bitmap)
>>   	return 0;
>>   }
>>  =20
>> +static int WMID_gaming_get_fan_behavior(u16 fan_bitmap, u8 *mode_bitma=
p)
>> +{
>> +	acpi_status status;
>> +	u32 input =3D 0;
>> +	u64 result;
>> +
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>> +	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_BEHAVI=
OR_METHODID, input,
>> +					    &result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	/* The return status must be zero for the operation to have succeeded=
 */
>> +	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
>> +		return -EIO;
>> +
>> +	*mode_bitmap =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GET_MODE_MASK, re=
sult);
>> +
>> +	return 0;
>> +}
>> +
>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>   {
>>   	u16 mode_bitmap =3D 0;
>> @@ -1669,6 +1711,55 @@ static void WMID_gaming_set_fan_mode(u8 fan_mode=
)
>>   	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>>   }
>>  =20
>> +static int WMID_gaming_set_gaming_fan_speed(u8 fan, u8 speed)
>> +{
>> +	acpi_status status;
>> +	u64 input =3D 0;
>> +	u64 result;
>> +
>> +	if (speed > 100)
>> +		return -EINVAL;
>> +
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_VALUE_MASK, speed);
>> +
>> +	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_SPEED_METH=
ODID, input, &result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	switch (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result)) {
>> +	case 0x00:
>> +		return 0;
>> +	case 0x01:
>> +		return -ENODEV;
>> +	case 0x02:
>> +		return -EINVAL;
>> +	default:
>> +		return -ENXIO;
>> +	}
>> +}
>> +
>> +static int WMID_gaming_get_gaming_fan_speed(u8 fan, u8 *speed)
>> +{
>> +	acpi_status status;
>> +	u32 input =3D 0;
>> +	u64 result;
>> +
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_SPEED_ID_MASK, fan);
>> +
>> +	status =3D WMI_gaming_execute_u32_u64(ACER_WMID_GET_GAMING_FAN_SPEED_=
METHODID, input,
>> +					    &result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	if (FIELD_GET(ACER_GAMING_FAN_SPEED_STATUS_MASK, result))
>> +		return -ENODEV;
>> +
>> +	*speed =3D FIELD_GET(ACER_GAMING_FAN_SPEED_VALUE_MASK, result);
>> +
>> +	return 0;
>> +}
>> +
>>   static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_set=
ting setting, u8 value)
>>   {
>>   	acpi_status status;
>> @@ -2840,6 +2931,16 @@ static const enum acer_wmi_predator_v4_sensor_id=
 acer_wmi_fan_channel_to_sensor_
>>   	[1] =3D ACER_WMID_SENSOR_GPU_FAN_SPEED,
>>   };
>>  =20
>> +static const enum acer_wmi_gaming_fan_id acer_wmi_fan_channel_to_fan_i=
d[] =3D {
>> +	[0] =3D ACER_WMID_CPU_FAN,
>> +	[1] =3D ACER_WMID_GPU_FAN,
>> +};
>> +
>> +static const u16 acer_wmi_fan_channel_to_fan_bitmap[] =3D {
>> +	[0] =3D ACER_GAMING_FAN_BEHAVIOR_CPU,
>> +	[1] =3D ACER_GAMING_FAN_BEHAVIOR_GPU,
>> +};
>> +
>>   static umode_t acer_wmi_hwmon_is_visible(const void *data,
>>   					 enum hwmon_sensor_types type, u32 attr,
>>   					 int channel)
>> @@ -2851,6 +2952,11 @@ static umode_t acer_wmi_hwmon_is_visible(const v=
oid *data,
>>   	case hwmon_temp:
>>   		sensor_id =3D acer_wmi_temp_channel_to_sensor_id[channel];
>>   		break;
>> +	case hwmon_pwm:
>> +		if (!has_cap(ACER_CAP_PWM))
>> +			return 0;
>> +
>> +		fallthrough;
>>   	case hwmon_fan:
>>   		sensor_id =3D acer_wmi_fan_channel_to_sensor_id[channel];
>>   		break;
>> @@ -2858,8 +2964,12 @@ static umode_t acer_wmi_hwmon_is_visible(const v=
oid *data,
>>   		return 0;
>>   	}
>>  =20
>> -	if (*supported_sensors & BIT(sensor_id - 1))
>> +	if (*supported_sensors & BIT(sensor_id - 1)) {
>> +		if (type =3D=3D hwmon_pwm)
>> +			return 0644;
>> +
>>   		return 0444;
>> +	}
>>  =20
>>   	return 0;
>>   }
>> @@ -2868,8 +2978,10 @@ static int acer_wmi_hwmon_read(struct device *de=
v, enum hwmon_sensor_types type,
>>   			       u32 attr, int channel, long *val)
>>   {
>>   	u64 command =3D ACER_WMID_CMD_GET_PREDATOR_V4_SENSOR_READING;
>> +	u8 fan, speed, mode_bitmap;
>> +	u16 fan_bitmap;
>> +	int mode, ret;
>>   	u64 result;
>> -	int ret;
>>  =20
>>   	switch (type) {
>>   	case hwmon_temp:
>> @@ -2893,6 +3005,106 @@ static int acer_wmi_hwmon_read(struct device *d=
ev, enum hwmon_sensor_types type,
>>  =20
>>   		*val =3D FIELD_GET(ACER_PREDATOR_V4_SENSOR_READING_BIT_MASK, result=
);
>>   		return 0;
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_input:
>> +			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
>> +			ret =3D WMID_gaming_get_gaming_fan_speed(fan, &speed);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			*val =3D fixp_linear_interpolate(0, 0, 100, U8_MAX, speed);
>> +			return 0;
>> +		case hwmon_pwm_enable:
>> +			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
>> +			ret =3D WMID_gaming_get_fan_behavior(fan_bitmap, &mode_bitmap);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			switch (channel) {
>> +			case 0:
>> +				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
>> +						 mode_bitmap);
>> +				break;
>> +			case 1:
>> +				mode =3D FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
>> +						 mode_bitmap);
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
> You've managed to create an internal API that resembles the WMI method
> input by working in terms of fan_bitmap and mode_bitmap which makes thin=
gs
> complicated as then you have to build logic on top of it to do all the
> mapping in the caller...
>
> I suggest changing this so you make WMID_gaming_get_fan_behavior() to
> input ACER_GAMING_FAN_BEHAVIOR_CPU / GPU (or ACER_WMID_CPU_FAN / GPU_FAN
> depending on the question I asked above) and perform the output mapping
> within that function. I think it would be much cleaner.
>
> I didn't exactly like the internal API in patch 1 either and I'd prefer
> the field GENMASK()s to directly point to the correct bits instead of th=
e
> nested FIELD_GET/PREP()s.

Ok, will do.

>> +			switch (mode) {
>> +			case ACER_WMID_FAN_MODE_AUTO:
>> +				*val =3D 2;
>> +				return 0;
>> +			case ACER_WMID_FAN_MODE_TURBO:
>> +				*val =3D 0;
>> +				return 0;
>> +			case ACER_WMID_FAN_MODE_CUSTOM:
>> +				*val =3D 1;
>> +				return 0;
>> +			default:
>> +				return -ENXIO;
>> +			}
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +}
>> +
>> +static int acer_wmi_hwmon_write(struct device *dev, enum hwmon_sensor_=
types type,
>> +				u32 attr, int channel, long val)
>> +{
>> +	u8 fan, speed, mode_bitmap;
>> +	u16 fan_bitmap;
>> +	int mode;
>> +
>> +	switch (type) {
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_input:
>> +			fan =3D acer_wmi_fan_channel_to_fan_id[channel];
>> +			speed =3D fixp_linear_interpolate(0, 0, U8_MAX, 100,
>> +							clamp_val(val, 0, U8_MAX));
>> +
>> +			return WMID_gaming_set_gaming_fan_speed(fan, speed);
>> +		case hwmon_pwm_enable:
>> +			fan_bitmap =3D acer_wmi_fan_channel_to_fan_bitmap[channel];
>> +
>> +			switch (val) {
>> +			case 0:
>> +				mode =3D ACER_WMID_FAN_MODE_TURBO;
>> +				break;
>> +			case 1:
>> +				mode =3D ACER_WMID_FAN_MODE_CUSTOM;
>> +				break;
>> +			case 2:
>> +				mode =3D ACER_WMID_FAN_MODE_AUTO;
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
>> +
>> +			switch (channel) {
>> +			case 0:
>> +				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK,
>> +							 mode);
>> +				break;
>> +			case 1:
>> +				mode_bitmap =3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK,
>> +							 mode);
>> +				break;
>> +			default:
>> +				return -EINVAL;
>> +			}
> These too look they could be mapped inside WMID_gaming_set_fan_behavior(=
).

I don't think so, as the function also needs to handle the setting of mult=
iple fans
at once.

Thanks,
Armin Wolf

>> +
>> +			return WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>> +		default:
>> +			return -EOPNOTSUPP;
>> +		}
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>> @@ -2908,11 +3120,16 @@ static const struct hwmon_channel_info *const a=
cer_wmi_hwmon_info[] =3D {
>>   			   HWMON_F_INPUT,
>>   			   HWMON_F_INPUT
>>   			   ),
>> +	HWMON_CHANNEL_INFO(pwm,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE,
>> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE
>> +			   ),
>>   	NULL
>>   };
>>  =20
>>   static const struct hwmon_ops acer_wmi_hwmon_ops =3D {
>>   	.read =3D acer_wmi_hwmon_read,
>> +	.write =3D acer_wmi_hwmon_write,
>>   	.is_visible =3D acer_wmi_hwmon_is_visible,
>>   };
>>  =20
>>

