Return-Path: <linux-kernel+bounces-851278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BDFBD6020
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15032406F22
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67A02D97AF;
	Mon, 13 Oct 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBGmc0ng"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A98E2264D9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385051; cv=none; b=dY3RoYy2sG1TgOl07W/Ko2sgWU9JoC5gXyYKwZHwxZEa8p2Hsl658wBX/VqLwUzLms/0yI3htS7cWd6UwzDvXWEYg+igC8/hM/JQ8vtrDaPMv8Ee5wWWjzNyPmwMuTxu0pAeOUfaJ4Q3HVRk/uUEa6Lj8oufEV55lp+c9VMW+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385051; c=relaxed/simple;
	bh=IpZ2LIfLn7br50AFqR+GMS2OYYPOPmfz3siYSEd3Veo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=isnfs47eCM1eZb14uSAKFMtnuVx8khfRzEr7VThTMMlQfz4mE0kc8rIqtvcV+K3N4m/Y0HfKTXTK7pE42OAFarWC+/PVuGqgCRbtX6lXelN7Mx8T47OsZDjrX9bD0rnAj3L3Oo+dRf0JgKaHIgMDyWpL2RW7YSMIAPanJYpUeNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBGmc0ng; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so5068847f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760385048; x=1760989848; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IpZ2LIfLn7br50AFqR+GMS2OYYPOPmfz3siYSEd3Veo=;
        b=hBGmc0ngXnpGdTYGl4I/w0AJCFkOVzquNgnoNyHSHr4KJ0XFmb7S/jzQOfY+3AK/+k
         4R0CL/tAnGPp4AnuAxX4x7I4OlHq/dKqTLbrZiK0kpzYuXCZ0q150FO9ItWRiiETVi1U
         TP8DNCX5bcCiKUlaljhyJ0DbzTo9XXeWiu+cIiq/7oqBeWsa4uf1USKfemyIBrLRFYkP
         IUmJvEMPMP2PN2MylgH3v3zAKMQz7RdhGI9EFLlBscGKTo+VDFrbA4zZUXWyo65CPS5g
         WGTCMdOiu9QZawmHNTX/28Pdn+f/ckagIyWiaKU2DUQBNyhuWt2n1+kSMnP7I+HuazUE
         XW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760385048; x=1760989848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IpZ2LIfLn7br50AFqR+GMS2OYYPOPmfz3siYSEd3Veo=;
        b=YStaJyK/XRACOmlr3mBw8Xl7q27ByaXG0JvamFIqsJBncqGCSDB20olpF4XCbxkYNI
         1khJqk8ZENTSG8BM7M49W+ew7DRpWEXvSemOn5n62l3qkAsS77BpuuNVlV24PPizf0tK
         /DYwLheGtMyBt3901nGJM8ExD+1jwzxhZ0sEdg8eCMznbJTMOI4+xrd/hnX9jbrHS7GK
         q67f/IyYTZmkaU7eirRxcjHbPbkeDYN6dwasVjLbNLT0tVvLWl7BHgCsG7MZM6C3xgkK
         mlfaoCSWnMrxDBBdGDD/7cdvFMr4iGXALuCELV2c7Yn/jvTie6mzu6ShJYLecgi8um5A
         ep6A==
X-Forwarded-Encrypted: i=1; AJvYcCXdEoKV1gxVBS8ryqFhPJMXa0/37RCWOZ6KoXmpdfMgErdpmadUHFl1oh9VCyaIkYsl7DxbagoWY/WAOBk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1e9SFo8oF+U5f3DlG+ykHVLqkftiXMj3fy6NU/pYkMgPIPDHZ
	UdwMGdRtAqSgR/MiD7d6BrMm0Sw4PoI05/Zvo34kjgo71ELxa1nwrgtX
X-Gm-Gg: ASbGncvVDbHEEVjDtw76X9yHPUPTuSv4t/9RIu1voKpo+4Bu4rc2c7BsmHiAxH2yxMy
	o+ZHF5m37wAwKwk6zrFSz5wXVA8xe8B7KRHKqPMlqT7hj7ibTdVxm/nPZYruVzXWwT7fJxkuss4
	CJUIuldbtUctBzspvXYcleIjk5rmiPrHalFFnJaVxH4hOR7IyPXZjjMKNlUnjKxexjr/YRdwZnT
	+Vk5SOaTvywsDn7hTY1gGHcPBftOXWIy+duEUbtZ56e6IcgdNedxKgR+a+wbv5BWfbNSo8zcTMO
	cABCcl4TavGv+Z0CU318Qqpc9pwm+ElhaHGoSwLRmAucuVa8YpNDnzMyW5XFmxDKsfe8pvpI+mj
	y8l+ZkFNk849w5Inuhe109VoosGO3k4NsZB3Ph/jNvcWdoe525HcPH3uXNcBYjVILTw==
X-Google-Smtp-Source: AGHT+IFDkKfdXGMGrKifIat9/ZijU4iS6Co0IGdbV24nvBNnMccEyqzWqFXt0aEBxuJ3Vdj28WiFFA==
X-Received: by 2002:a05:6000:26c9:b0:425:74e1:25f7 with SMTP id ffacd0b85a97d-4266e8e6d0amr14586408f8f.62.1760385047378;
        Mon, 13 Oct 2025 12:50:47 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cf70fsm19148619f8f.27.2025.10.13.12.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 12:50:46 -0700 (PDT)
Message-ID: <f352e00c-50d9-4c13-941c-d6e254c44072@gmail.com>
Date: Mon, 13 Oct 2025 21:50:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v13 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251013180534.1222432-1-benato.denis96@gmail.com>
 <20251013180534.1222432-9-benato.denis96@gmail.com>
 <cad7b458-5a7a-4975-94a1-d0c74f6f3de5@oracle.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <cad7b458-5a7a-4975-94a1-d0c74f6f3de5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/25 20:25, ALOK TIWARI wrote:
>
>
> On 10/13/2025 11:35 PM, Denis Benato wrote:
>> From: "Luke D. Jones" <luke@ljones.dev>
>>
>> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
>> and adds proper min/max levels plus defaults.
>>
>> The min/max are defined by ASUS and typically gained by looking at what
>> they allow in the ASUS Armoury Crate application - ASUS does not share
>> the values outside of this. It could also be possible to gain the AMD
>> values by use of ryzenadj and testing for the minimum stable value.
>>
>> The general rule of thumb for adding to the match table is that if the
>> model range has a single CPU used throughout, then the DMI match can
>> omit the last letter of the model number as this is the GPU model.
>>
>> If a min or max value is not provided it is assumed that the particular
>> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
>> If a <ppt_setting>_def is not set then the default is assumed to be
>> <ppt_setting>_max
>>
>> It is assumed that at least AC settings are available so that the
>> firmware attributes will be created - if no DC table is available
>> and power is on DC, then reading the attributes is -ENODEV.
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Tested-by: Mateusz Schyboll <dragonn@op.pl>
>> ---
>>   drivers/platform/x86/asus-armoury.c        |  296 ++++-
>>   drivers/platform/x86/asus-armoury.h        | 1210 ++++++++++++++++++++
>>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>>   3 files changed, 1503 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>> index e27f964aebf8..918aea6fba1e 100644
>> --- a/drivers/platform/x86/asus-armoury.c
>> +++ b/drivers/platform/x86/asus-armoury.c
>> @@ -27,6 +27,7 @@
>>   #include <linux/mutex.h>
>>   #include <linux/platform_data/x86/asus-wmi.h>
>>   #include <linux/printk.h>
>> +#include <linux/power_supply.h>
>>   #include <linux/types.h>
>>     #include "asus-armoury.h"
>> @@ -45,6 +46,17 @@
>>   #define ASUS_MINI_LED_2024_STRONG 0x01
>>   #define ASUS_MINI_LED_2024_OFF    0x02
>>   +/* Power tunable attribute name defines */
>> +#define ATTR_PPT_PL1_SPL        "ppt_pl1_spl"
>> +#define ATTR_PPT_PL2_SPPT       "ppt_pl2_sppt"
>> +#define ATTR_PPT_PL3_FPPT       "ppt_pl3_fppt"
>> +#define ATTR_PPT_APU_SPPT       "ppt_apu_sppt"
>> +#define ATTR_PPT_PLATFORM_SPPT  "ppt_platform_sppt"
>> +#define ATTR_NV_DYNAMIC_BOOST   "nv_dynamic_boost"
>> +#define ATTR_NV_TEMP_TARGET     "nv_temp_target"
>> +#define ATTR_NV_BASE_TGP        "nv_base_tgp"
>> +#define ATTR_NV_TGP             "nv_tgp"
>> +
>>   #define ASUS_POWER_CORE_MASK    GENMASK(15, 8)
>>   #define ASUS_PERF_CORE_MASK        GENMASK(7, 0)
>>   @@ -73,11 +85,26 @@ struct cpu_cores {
>>       u32 max_power_cores;
>>   };
>>   +struct rog_tunables {
>> +    const struct power_limits *power_limits;
>> +    u32 ppt_pl1_spl;            // cpu
>> +    u32 ppt_pl2_sppt;            // cpu
>> +    u32 ppt_pl3_fppt;            // cpu
>> +    u32 ppt_apu_sppt;            // plat
>> +    u32 ppt_platform_sppt;        // plat
>> +
>> +    u32 nv_dynamic_boost;
>> +    u32 nv_temp_target;
>> +    u32 nv_tgp;
>> +};
>> +
>>   static struct asus_armoury_priv {
>>       struct device *fw_attr_dev;
>>       struct kset *fw_attr_kset;
>>         struct cpu_cores *cpu_cores;
>> +    /* Index 0 for DC, 1 for AC */
>> +    struct rog_tunables *rog_tunables[2];
>>       u32 mini_led_dev_id;
>>       u32 gpu_mux_dev_id;
>>       /*
>> @@ -719,7 +746,34 @@ static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
>>   ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>>               "Set the max available efficiency cores");
>>   +/* Define helper to access the current power mode tunable values */
>> +static inline struct rog_tunables *get_current_tunables(void)
>> +{
>> +    return asus_armoury
>> +        .rog_tunables[power_supply_is_system_supplied() ? 1 : 0];
>> +}
>> +
>>   /* Simple attribute creation */
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID_PPT_PL1_SPL,
>> +               "Set the CPU slow package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEVID_PPT_PL2_SPPT,
>> +               "Set the CPU fast package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEVID_PPT_FPPT,
>
> why not ASUS_WMI_DEVID_PPT_PL3_FPPT ? 
>
I simply didn't touch anything that was not brought up, but I see that it appears to be a more consistent name.

Will use that name for v14, thanks!

>> +               "Set the CPU fastest package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, ATTR_PPT_APU_SPPT, ASUS_WMI_DEVID_PPT_APU_SPPT,
>> +               "Set the APU package limit");
>> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, ATTR_PPT_PLATFORM_SPPT, ASUS_WMI_DEVID_PPT_PLAT_SPPT,
>> +               "Set the platform package limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, ATTR_NV_DYNAMIC_BOOST, ASUS_WMI_DEVID_NV_DYN_BOOST,
>> +               "Set the Nvidia dynamic boost limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, ATTR_NV_TEMP_TARGET, ASUS_WMI_DEVID_NV_THERM_TARGET,
>> +               "Set the Nvidia max thermal limit");
>> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
>> +               "Set the additional TGP on top of the base TGP");
>> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
>> +                 "Read the base TGP value");
>> +
>> +
>>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>>                  "Show the current mode of charging");
>>   @@ -746,6 +800,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>       { &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>       { &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>   +    { &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
>> +    { &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
>> +    { &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
>> +    { &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
>> +    { &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
>> +    { &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
>> +    { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
>> +    { &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>> +    { &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>> +
>>       { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>>       { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>>       { &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
>> @@ -754,8 +818,75 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>       { &screen_auto_brightness_attr_group, ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS },
>>   };
>>   +/**
>> + * is_power_tunable_attr - Determines if an attribute is a power-related tunable
>> + * @name: The name of the attribute to check
>> + *
>> + * This function checks if the given attribute name is related to power tuning.
>> + *
>> + * Return: true if the attribute is a power-related tunable, false otherwise
>> + */
>> +static bool is_power_tunable_attr(const char *name)
>> +{
>> +    static const char * const power_tunable_attrs[] = {
>> +        ATTR_PPT_PL1_SPL,    ATTR_PPT_PL2_SPPT,
>> +        ATTR_PPT_PL3_FPPT,    ATTR_PPT_APU_SPPT,
>> +        ATTR_PPT_PLATFORM_SPPT, ATTR_NV_DYNAMIC_BOOST,
>> +        ATTR_NV_TEMP_TARGET,    ATTR_NV_BASE_TGP,
>> +        ATTR_NV_TGP
>> +    };
>> +
>> +    for (unsigned int i = 0; i < ARRAY_SIZE(power_tunable_attrs); i++) {
>> +        if (!strcmp(name, power_tunable_attrs[i]))
>> +            return true;
>> +    }
>> +
>> +    return false;
>> +}
>> +
>> +/**
>> + * has_valid_limit - Checks if a power-related attribute has a valid limit value
>> + * @name: The name of the attribute to check
>> + * @limits: Pointer to the power_limits structure containing limit values
>> + *
>> + * This function checks if a power-related attribute has a valid limit value.
>> + * It returns false if limits is NULL or if the corresponding limit value is zero.
>> + *
>> + * Return: true if the attribute has a valid limit value, false otherwise
>> + */
>> +static bool has_valid_limit(const char *name, const struct power_limits *limits)
>> +{
>> +    u32 limit_value = 0;
>> +
>> +    if (!limits)
>> +        return false;
>> +
>> +    if (!strcmp(name, ATTR_PPT_PL1_SPL))
>> +        limit_value = limits->ppt_pl1_spl_max;
>> +    else if (!strcmp(name, ATTR_PPT_PL2_SPPT))
>> +        limit_value = limits->ppt_pl2_sppt_max;
>> +    else if (!strcmp(name, ATTR_PPT_PL3_FPPT))
>> +        limit_value = limits->ppt_pl3_fppt_max;
>> +    else if (!strcmp(name, ATTR_PPT_APU_SPPT))
>> +        limit_value = limits->ppt_apu_sppt_max;
>> +    else if (!strcmp(name, ATTR_PPT_PLATFORM_SPPT))
>> +        limit_value = limits->ppt_platform_sppt_max;
>> +    else if (!strcmp(name, ATTR_NV_DYNAMIC_BOOST))
>> +        limit_value = limits->nv_dynamic_boost_max;
>> +    else if (!strcmp(name, ATTR_NV_TEMP_TARGET))
>> +        limit_value = limits->nv_temp_target_max;
>> +    else if (!strcmp(name, ATTR_NV_BASE_TGP) ||
>> +         !strcmp(name, ATTR_NV_TGP))
>> +        limit_value = limits->nv_tgp_max;
>> +
>> +    return limit_value > 0;
>> +}
>> +
>>   static int asus_fw_attr_add(void)
>>   {
>> +    const struct power_limits *limits;
>> +    bool should_create;
>> +    const char *name;
>>       int err, i;
>>         asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
>> @@ -812,12 +943,30 @@ static int asus_fw_attr_add(void)
>>           if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>>               continue;
>>   -        err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> -                     armoury_attr_groups[i].attr_group);
>> -        if (err) {
>> -            pr_err("Failed to create sysfs-group for %s\n",
>> -                   armoury_attr_groups[i].attr_group->name);
>> -            goto err_remove_groups;
>> +        /* Always create by default, unless PPT is not present */
>> +        should_create = true;
>> +        name = armoury_attr_groups[i].attr_group->name;
>> +
>> +        /* Check if this is a power-related tunable requiring limits */
>> +        if (asus_armoury.rog_tunables[1] && asus_armoury.rog_tunables[1]->power_limits &&
>> +            is_power_tunable_attr(name)) {
>> +            limits = asus_armoury.rog_tunables[1]->power_limits;
>> +            /* Check only AC, if DC is not present then AC won't be either */
>> +            should_create = has_valid_limit(name, limits);
>> +            if (!should_create) {
>> +                pr_debug("Missing max value on %s for tunable: %s\n",
>> +                     dmi_get_system_info(DMI_BOARD_NAME), name);
>
> dmi_get_system_info can return NULL 
ouch! v14 here I come.
>
>> +            }
>> +        }
>> +
>> +        if (should_create) {
>> +            err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> +                armoury_attr_groups[i].attr_group);
>> +            if (err) {
>> +                pr_err("Failed to create sysfs-group for %s\n",
>> +                       armoury_attr_groups[i].attr_group->name);
>> +                goto err_remove_groups;
>> +            }
>>           }
>>       }
>>  
> Thanks,
> Alok 
Thanks,
Denis B.

