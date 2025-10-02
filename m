Return-Path: <linux-kernel+bounces-840686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88A9BB4F8F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE18325F95
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A679280A5C;
	Thu,  2 Oct 2025 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iVCmkBAj"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7702270542;
	Thu,  2 Oct 2025 19:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759432613; cv=none; b=pYMo3Cnxcy3WuA7MqVSweT7kAvs6reI35azg1UbJ3M/HyUAjDaRfOWHzrndSDzK1h4XPOm+gJ88dDMHPNILg1HnMfqltes+qgb70TeZ+wzfI1pDZNfDCjtgT/JEbckiw7CUYqt7R1OCYtKIAdqqjHzjyMCnAhoLFnVcYam56D2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759432613; c=relaxed/simple;
	bh=yUmlbSxQ9XD4QzlKQx1o1znCo9y7q3J5G5i/8hlTy+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzk8mko/65PKqw3mi9qQ0Z30QTlf3Hi+QAPbC6IZLFgx4XfKHIdKcBWuOCUmxuiJpe7M/2uxMsopkKmCsCIckOC9ROxOrUFaPTgkknPfuOwU/9Sd4sIu91Gq1ylZNome64mZ3zgKHsmKloj8f5pVY/p4a3MvA+XWLGIJTyYqBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iVCmkBAj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1759432599; x=1760037399; i=w_armin@gmx.de;
	bh=n5jv54VlSuShCn+GGb1sW8SnCErwFbM59ueVDRNTxkM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iVCmkBAjgHlA3QWY4hLOZYR11ev2oHfcuJl4lo4Unv4UquR+S5QB6KDaifrfTCtH
	 slYOM3AQZCetqAFA7wh3yUw9LHTR2RUVfbtkJkAloM8kb19VlWnCMZ8l4WpZ5QZ1M
	 sUcV3TsW14kjAEgBKIjAVhD3jQbk1VmmwRKA+TqRK25za2gD2pHP6NIKd2QF1F9pD
	 +KKVFA3M1edZ9DkFsSPkOiV3Fdnv0jDmpqMmwLwRpsqVyuOgfIjN01yRBMMdyM8NC
	 OF+XdhSTIeIFZrtfcqF7RyZQDsGuW4HL9jPUQcpfQBKeTUrrUjbH4DnejjhrJO6Ms
	 PW4pe8DqQchUSD9sQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([5.61.150.13]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1ulcx83A96-00NWJD; Thu, 02
 Oct 2025 21:16:38 +0200
Message-ID: <04969cb2-3b59-4232-bada-a69d138005fa@gmx.de>
Date: Thu, 2 Oct 2025 21:16:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] platform/x86: acer-wmi: Fix setting of fan
 behavior
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: jlee@suse.com, basak.sb2006@gmail.com, rayanmargham4@gmail.com,
 kuurtb@gmail.com, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20250923215205.326367-1-W_Armin@gmx.de>
 <20250923215205.326367-2-W_Armin@gmx.de>
 <f1be3296-4cae-3c0e-3b5f-23774f20f37a@linux.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <f1be3296-4cae-3c0e-3b5f-23774f20f37a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FYfe1niWoFy80E0jrE3q8X4yn3xXO7lein2BD2hgR6IBwF14Sg5
 U1LuXdXjukTAe8+x0GLtpG3YPrlRmk3pyq2ksklELs4Gu6YW3vtxOSP/MuXUpr+xRaxP5PY
 EtHh5Bhb3T7/EZISZtB/FJsaUBaFmHJjLyaV+lqN18AqfcxGY/UBi+fhDFIBq9JUWTVAeVE
 fMY6SqSSPeqy4CGls8pww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/lE54pjvIo8=;Er3hW2UCaxBsQmVkG8P6FyZ84sI
 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
 W+/EWkPKfMeGiPBS0=

Am 24.09.25 um 13:00 schrieb Ilpo J=C3=A4rvinen:

> On Tue, 23 Sep 2025, Armin Wolf wrote:
>
>> After studying the linuwu_sense driver
>> (https://github.com/0x7375646F/Linuwu-Sense) i was able to understand
>> the meaning of the SetGamingFanBehavior() WMI method:
>>
>> - the first 16-bit are a bitmap of all fans affected by a fan behavior
>>    change request.
>>
>> - the next 8 bits contain four fan mode fields (2-bit), each being
>>    associated with a bit inside the fan bitmap.
>>
>> There are three fan modes: auto, turbo and custom.
>>
>> Use this newfound knowledge to fix the turbo fan handling by setting
>> the correct bits before calling SetGamingFanBehavior(). Also check
>> the result of the WMI method call and return an error should the ACPI
>> firmware signal failure.
>>
>> Reviewed-by: Kurt Borja <kuurtb@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/acer-wmi.c | 76 +++++++++++++++++++++++---------=
-
>>   1 file changed, 53 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/ace=
r-wmi.c
>> index 69336bd778ee..a41555ee8589 100644
>> --- a/drivers/platform/x86/acer-wmi.c
>> +++ b/drivers/platform/x86/acer-wmi.c
>> @@ -68,10 +68,19 @@ MODULE_LICENSE("GPL");
>>   #define ACER_WMID_SET_GAMING_LED_METHODID 2
>>   #define ACER_WMID_GET_GAMING_LED_METHODID 4
>>   #define ACER_WMID_GET_GAMING_SYS_INFO_METHODID 5
>> -#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR 14
>> +#define ACER_WMID_SET_GAMING_FAN_BEHAVIOR_METHODID 14
>>   #define ACER_WMID_SET_GAMING_MISC_SETTING_METHODID 22
>>   #define ACER_WMID_GET_GAMING_MISC_SETTING_METHODID 23
>>  =20
>> +#define ACER_GAMING_FAN_BEHAVIOR_ID_MASK GENMASK_ULL(15, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK GENMASK_ULL(23, 16)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU BIT(0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU BIT(3)
>> +
>> +#define ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK GENMASK(1, 0)
>> +#define ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK GENMASK(7, 6)
>> +
>>   #define ACER_GAMING_MISC_SETTING_STATUS_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_INDEX_MASK GENMASK_ULL(7, 0)
>>   #define ACER_GAMING_MISC_SETTING_VALUE_MASK GENMASK_ULL(15, 8)
>> @@ -121,6 +130,12 @@ enum acer_wmi_predator_v4_sensor_id {
>>   	ACER_WMID_SENSOR_GPU_TEMPERATURE	=3D 0x0A,
>>   };
>>  =20
>> +enum acer_wmi_gaming_fan_mode {
>> +	ACER_WMID_FAN_MODE_AUTO		=3D 0x01,
>> +	ACER_WMID_FAN_MODE_TURBO	=3D 0x02,
>> +	ACER_WMID_FAN_MODE_CUSTOM	=3D 0x03,
>> +};
>> +
>>   enum acer_wmi_predator_v4_oc {
>>   	ACER_WMID_OC_NORMAL			=3D 0x0000,
>>   	ACER_WMID_OC_TURBO			=3D 0x0002,
>> @@ -1565,9 +1580,6 @@ static acpi_status WMID_gaming_set_u64(u64 value,=
 u32 cap)
>>   	case ACER_CAP_TURBO_LED:
>>   		method_id =3D ACER_WMID_SET_GAMING_LED_METHODID;
>>   		break;
>> -	case ACER_CAP_TURBO_FAN:
>> -		method_id =3D ACER_WMID_SET_GAMING_FAN_BEHAVIOR;
>> -		break;
>>   	default:
>>   		return AE_BAD_PARAMETER;
>>   	}
>> @@ -1618,25 +1630,43 @@ static int WMID_gaming_get_sys_info(u32 command=
, u64 *out)
>>   	return 0;
>>   }
>>  =20
>> +static int WMID_gaming_set_fan_behavior(u16 fan_bitmap, u8 mode_bitmap=
)
> Should the name be in plural as this sets all fans?

I don't think so, as this functions can also be used to control each fan
individually.

> Please also consider what I noted to patch 2 about this nesting of
> FIELD_PREP()s. Getting rid of that effectively means the caller ORs all
> bits together but I don't think that would make the code harder to read.

Alright, i will try to get rid of the nesting.

Thanks,
Armin Wolf

>> +{
>> +	acpi_status status;
>> +	u64 input =3D 0;
>> +	u64 result;
>> +
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_ID_MASK, fan_bitmap);
>> +	input |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_SET_MODE_MASK, mode_bi=
tmap);
>> +
>> +	status =3D WMI_gaming_execute_u64(ACER_WMID_SET_GAMING_FAN_BEHAVIOR_M=
ETHODID, input,
>> +					&result);
>> +	if (ACPI_FAILURE(status))
>> +		return -EIO;
>> +
>> +	/* The return status must be zero for the operation to have succeeded=
 */
>> +	if (FIELD_GET(ACER_GAMING_FAN_BEHAVIOR_STATUS_MASK, result))
>> +		return -EIO;
>> +
>> +	return 0;
>> +}
>> +
>>   static void WMID_gaming_set_fan_mode(u8 fan_mode)
>>   {
>> -	/* fan_mode =3D 1 is used for auto, fan_mode =3D 2 used for turbo*/
>> -	u64 gpu_fan_config1 =3D 0, gpu_fan_config2 =3D 0;
>> -	int i;
>> -
>> -	if (quirks->cpu_fans > 0)
>> -		gpu_fan_config2 |=3D 1;
>> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>> -		gpu_fan_config2 |=3D 1 << (i + 1);
>> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
>> -		gpu_fan_config2 |=3D 1 << (i + 3);
>> -	if (quirks->cpu_fans > 0)
>> -		gpu_fan_config1 |=3D fan_mode;
>> -	for (i =3D 0; i < (quirks->cpu_fans + quirks->gpu_fans); ++i)
>> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 2);
>> -	for (i =3D 0; i < quirks->gpu_fans; ++i)
>> -		gpu_fan_config1 |=3D fan_mode << (2 * i + 6);
>> -	WMID_gaming_set_u64(gpu_fan_config2 | gpu_fan_config1 << 16, ACER_CAP=
_TURBO_FAN);
>> +	u16 mode_bitmap =3D 0;
>> +	u16 fan_bitmap =3D 0;
>> +
>> +	if (quirks->cpu_fans > 0) {
>> +		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_CPU;
>> +		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_CPU_MODE_MASK, =
fan_mode);
>> +	}
>> +
>> +	if (quirks->gpu_fans > 0) {
>> +		fan_bitmap |=3D ACER_GAMING_FAN_BEHAVIOR_GPU;
>> +		mode_bitmap |=3D FIELD_PREP(ACER_GAMING_FAN_BEHAVIOR_GPU_MODE_MASK, =
fan_mode);
>> +	}
>> +
>> +	WMID_gaming_set_fan_behavior(fan_bitmap, mode_bitmap);
>>   }
>>  =20
>>   static int WMID_gaming_set_misc_setting(enum acer_wmi_gaming_misc_set=
ting setting, u8 value)
>> @@ -1923,7 +1953,7 @@ static int acer_toggle_turbo(void)
>>   		WMID_gaming_set_u64(0x1, ACER_CAP_TURBO_LED);
>>  =20
>>   		/* Set FAN mode to auto */
>> -		WMID_gaming_set_fan_mode(0x1);
>> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_AUTO);
>>  =20
>>   		/* Set OC to normal */
>>   		if (has_cap(ACER_CAP_TURBO_OC)) {
>> @@ -1937,7 +1967,7 @@ static int acer_toggle_turbo(void)
>>   		WMID_gaming_set_u64(0x10001, ACER_CAP_TURBO_LED);
>>  =20
>>   		/* Set FAN mode to turbo */
>> -		WMID_gaming_set_fan_mode(0x2);
>> +		WMID_gaming_set_fan_mode(ACER_WMID_FAN_MODE_TURBO);
>>  =20
>>   		/* Set OC to turbo mode */
>>   		if (has_cap(ACER_CAP_TURBO_OC)) {
>>

