Return-Path: <linux-kernel+bounces-851484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D806BBD69C4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CCFB04E3B44
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854332FD1B2;
	Mon, 13 Oct 2025 22:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLYtQ7Ys"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348912FB968
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760394384; cv=none; b=SjjHL5VoyQWvxk7aEYwc+L51poJ4b5ITvjtpJnmpXjPwDxe//pdCVdc6oftJv+wpZpg3kqnB4CEzspF0AxkKu76R+WVcUAlwowtjxJZuX0IOx66xvf2PF+Q9UM7rHp1YQf533AITDsDUdZ4dBjzoQN6eSK5Ne/dJBCvSq3ma/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760394384; c=relaxed/simple;
	bh=PkgHu5j/+WZC8dxxMvvQgGA0OUwb3WA2z17XJVpa4xs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dxSLdBlCFdm6dPgGHRHNjZguGOC6L0zN9M8c64w7jtqOfUw95LtduxCG4ESvxilVPGYoBjTADI4waGIk2XyWfhxOjw/oxD/pPvwwxmRZCK8FGcDEOiQxjFZVaXapAHvzHXSsxv6U3t5+7grGoEvzmOZmkxOqumX1hAUkY3fC9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLYtQ7Ys; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46b303f755aso40658645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760394380; x=1760999180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PkgHu5j/+WZC8dxxMvvQgGA0OUwb3WA2z17XJVpa4xs=;
        b=gLYtQ7YsBo7AzYUCkXmoBeItwzG1NhP3leRiPI516P2Y1s0/X4xOk0//Y6R1wqDHWS
         S6UGpbI25AShjZHc6WsPVoHQ8jO5EPOvxc38WFJJqY0vaEFyHJPMHdN0K4ehWGg/OVz+
         icWfGlYInyQQvREwU18eK5ELCdmmB3H4lvysvN9Pw47MOlqOu73C6nIOfMt/2luagNCW
         mWc6ZnMwhqe8hl3ekKrJO2R2Sjzp1UuJ9MyHZcHuxPFYcLt0RuTr5Sb4eo0G02Y/9el6
         0qb9oZkJhF1NycJEsHbqDb6XuqXYXnW023eC4UEP4r+CYfnW/nH0LgoV/gdS1zTwwmxj
         h/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760394380; x=1760999180;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkgHu5j/+WZC8dxxMvvQgGA0OUwb3WA2z17XJVpa4xs=;
        b=DxVIsGVzPf6QY68jWJejrkvpboHTjGP/qHqGOAcz8CoulU0T6IsZJixRtNCvwhNatn
         oRzdVDj0NDp07ddTK73Dq+k8onnXKfd3h2UGru5nn6Sgp5a6VHnGnFs1wvfnxd5mgbQi
         5biKCtywf+E2NJX07AWGa+lgL4MLv2o3TX+MYUrRweN888iQy6Mof5LKHjkLX86h+OUU
         IgQIwA5NcrN2pzgler8ISxhcUEtyhtD1buy4NDsty2Bh2LuQoxYxw2RLg+Jy9WZvN9sO
         ceaJlmuf8E3snTbz4tefBxJd6Nea48qEMTB+FN0/JajkdTrOlFhiLwFs96w0gFKuCrQl
         GUKg==
X-Forwarded-Encrypted: i=1; AJvYcCX2Bl75SjmhufNXzQ/zEIwpfiHG9ETsC1rizf6sc4P3p9YNvv8xTIfNRdTMLQIuZa3pkmpLU4hIFHjFBwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfI6eTVi72vw5hIn6Rhih8tiw6VK9AZuGE8aw6h2TIJZ2PNaZN
	ZrErJGn8DOQ0yWkyTZ2Cl0ek9kJekfBmNnk8WZMmW9ZzPnoLIseZPpyo
X-Gm-Gg: ASbGncvOb2AmRLxZTrzI3GYLnaPKbWIDpS02oZyTaDNM7mC1FdmvEgKlhJ9A+LlxjOy
	ZrcUBs9E1AcUK8RLzzPby0zPwnj1G+tEIPO5gXYxut0xxbBAdAPezYZNDN6HtVGLAFo1my6jJ4U
	2uSRxlsMXJatfxuY5Kz6cIYT6+74Wt1U2gT7vRx9Y5iFlczVtHLTPoAsFRYXGarJgjQT/fpkiRs
	zov5OxOB3bGMG9BCbX92uGuiKxYtofKJdiN403KR3h2f1WHqklWJwANhrN3BqavE4ApAPICufuh
	198eJN8pPbxyVUnDoDXGcpKSsq67vB9GVLZTil/yVDhhu1I5xkt9fTIdNHM1ZGfS+HvBVVYGAxh
	iD3pcwmMmMaIUj2vbZYXWKlhe0283cjCLZiIcV2hrMcxPDdgt2L6Uls8=
X-Google-Smtp-Source: AGHT+IGuUeoawOT146YOKXJgt5RbjivzmbTwl+3N5kXPEcIIaQOuDmRFFng2/OfEvI724Fv9KUKwFw==
X-Received: by 2002:a05:600c:c162:b0:45f:2cb5:ecff with SMTP id 5b1f17b1804b1-46fa9b02fa3mr181040145e9.31.1760394380232;
        Mon, 13 Oct 2025 15:26:20 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab500706sm139925205e9.3.2025.10.13.15.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 15:26:19 -0700 (PDT)
Message-ID: <c2b86d8f-d148-4ad8-aa46-f94b9598be80@gmail.com>
Date: Tue, 14 Oct 2025 00:26:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v13 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
From: Denis Benato <benato.denis96@gmail.com>
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
 <f352e00c-50d9-4c13-941c-d6e254c44072@gmail.com>
Content-Language: en-US, it-IT, en-US-large
In-Reply-To: <f352e00c-50d9-4c13-941c-d6e254c44072@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/13/25 21:50, Denis Benato wrote:
> On 10/13/25 20:25, ALOK TIWARI wrote:
>>
>> On 10/13/2025 11:35 PM, Denis Benato wrote:
>>> From: "Luke D. Jones" <luke@ljones.dev>
>>>
>>> Adds the ppt_* and nv_* tuning knobs that are available via WMI methods
>>> and adds proper min/max levels plus defaults.
>>>
>>> The min/max are defined by ASUS and typically gained by looking at what
>>> they allow in the ASUS Armoury Crate application - ASUS does not share
>>> the values outside of this. It could also be possible to gain the AMD
>>> values by use of ryzenadj and testing for the minimum stable value.
>>>
>>> The general rule of thumb for adding to the match table is that if the
>>> model range has a single CPU used throughout, then the DMI match can
>>> omit the last letter of the model number as this is the GPU model.
>>>
>>> If a min or max value is not provided it is assumed that the particular
>>> setting is not supported. for example ppt_pl2_sppt_min/max is not set.
>>> If a <ppt_setting>_def is not set then the default is assumed to be
>>> <ppt_setting>_max
>>>
>>> It is assumed that at least AC settings are available so that the
>>> firmware attributes will be created - if no DC table is available
>>> and power is on DC, then reading the attributes is -ENODEV.
>>>
>>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>> Tested-by: Mateusz Schyboll <dragonn@op.pl>
>>> ---
>>>   drivers/platform/x86/asus-armoury.c        |  296 ++++-
>>>   drivers/platform/x86/asus-armoury.h        | 1210 ++++++++++++++++++++
>>>   include/linux/platform_data/x86/asus-wmi.h |    3 +
>>>   3 files changed, 1503 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>>> index e27f964aebf8..918aea6fba1e 100644
>>> --- a/drivers/platform/x86/asus-armoury.c
>>> +++ b/drivers/platform/x86/asus-armoury.c
>>> @@ -27,6 +27,7 @@
>>>   #include <linux/mutex.h>
>>>   #include <linux/platform_data/x86/asus-wmi.h>
>>>   #include <linux/printk.h>
>>> +#include <linux/power_supply.h>
>>>   #include <linux/types.h>
>>>     #include "asus-armoury.h"
>>> @@ -45,6 +46,17 @@
>>>   #define ASUS_MINI_LED_2024_STRONG 0x01
>>>   #define ASUS_MINI_LED_2024_OFF    0x02
>>>   +/* Power tunable attribute name defines */
>>> +#define ATTR_PPT_PL1_SPL        "ppt_pl1_spl"
>>> +#define ATTR_PPT_PL2_SPPT       "ppt_pl2_sppt"
>>> +#define ATTR_PPT_PL3_FPPT       "ppt_pl3_fppt"
>>> +#define ATTR_PPT_APU_SPPT       "ppt_apu_sppt"
>>> +#define ATTR_PPT_PLATFORM_SPPT  "ppt_platform_sppt"
>>> +#define ATTR_NV_DYNAMIC_BOOST   "nv_dynamic_boost"
>>> +#define ATTR_NV_TEMP_TARGET     "nv_temp_target"
>>> +#define ATTR_NV_BASE_TGP        "nv_base_tgp"
>>> +#define ATTR_NV_TGP             "nv_tgp"
>>> +
>>>   #define ASUS_POWER_CORE_MASK    GENMASK(15, 8)
>>>   #define ASUS_PERF_CORE_MASK        GENMASK(7, 0)
>>>   @@ -73,11 +85,26 @@ struct cpu_cores {
>>>       u32 max_power_cores;
>>>   };
>>>   +struct rog_tunables {
>>> +    const struct power_limits *power_limits;
>>> +    u32 ppt_pl1_spl;            // cpu
>>> +    u32 ppt_pl2_sppt;            // cpu
>>> +    u32 ppt_pl3_fppt;            // cpu
>>> +    u32 ppt_apu_sppt;            // plat
>>> +    u32 ppt_platform_sppt;        // plat
>>> +
>>> +    u32 nv_dynamic_boost;
>>> +    u32 nv_temp_target;
>>> +    u32 nv_tgp;
>>> +};
>>> +
>>>   static struct asus_armoury_priv {
>>>       struct device *fw_attr_dev;
>>>       struct kset *fw_attr_kset;
>>>         struct cpu_cores *cpu_cores;
>>> +    /* Index 0 for DC, 1 for AC */
>>> +    struct rog_tunables *rog_tunables[2];
>>>       u32 mini_led_dev_id;
>>>       u32 gpu_mux_dev_id;
>>>       /*
>>> @@ -719,7 +746,34 @@ static ssize_t cores_efficiency_current_value_store(struct kobject *kobj,
>>>   ATTR_GROUP_CORES_RW(cores_efficiency, "cores_efficiency",
>>>               "Set the max available efficiency cores");
>>>   +/* Define helper to access the current power mode tunable values */
>>> +static inline struct rog_tunables *get_current_tunables(void)
>>> +{
>>> +    return asus_armoury
>>> +        .rog_tunables[power_supply_is_system_supplied() ? 1 : 0];
>>> +}
>>> +
>>>   /* Simple attribute creation */
>>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, ATTR_PPT_PL1_SPL, ASUS_WMI_DEVID_PPT_PL1_SPL,
>>> +               "Set the CPU slow package limit");
>>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl2_sppt, ATTR_PPT_PL2_SPPT, ASUS_WMI_DEVID_PPT_PL2_SPPT,
>>> +               "Set the CPU fast package limit");
>>> +ATTR_GROUP_ROG_TUNABLE(ppt_pl3_fppt, ATTR_PPT_PL3_FPPT, ASUS_WMI_DEVID_PPT_FPPT,
>> why not ASUS_WMI_DEVID_PPT_PL3_FPPT ? 
>>
> I simply didn't touch anything that was not brought up, but I see that it appears to be a more consistent name.
>
> Will use that name for v14, thanks!
Unfortunately taking a closer look I discovered that macro has been introduced over
2 years ago in commit e0b278e7b5da62c3ebb156a8b7d76a739da2d953
"platform/x86: asus-wmi: expose dGPU and CPU tunables for ROG"
and it is not introduced as part of this commit series.

I think it would be best to create an ah-hoc commit when this driver is merged to change the name in both,
or do I send the name change now and rework this driver? what do you think?

Honestly given the large number of people already running this and the request of having it upstream
the road that will make it merge sooner is the one I would like to take.

Thanks,
Denis

>>> +               "Set the CPU fastest package limit");
>>> +ATTR_GROUP_ROG_TUNABLE(ppt_apu_sppt, ATTR_PPT_APU_SPPT, ASUS_WMI_DEVID_PPT_APU_SPPT,
>>> +               "Set the APU package limit");
>>> +ATTR_GROUP_ROG_TUNABLE(ppt_platform_sppt, ATTR_PPT_PLATFORM_SPPT, ASUS_WMI_DEVID_PPT_PLAT_SPPT,
>>> +               "Set the platform package limit");
>>> +ATTR_GROUP_ROG_TUNABLE(nv_dynamic_boost, ATTR_NV_DYNAMIC_BOOST, ASUS_WMI_DEVID_NV_DYN_BOOST,
>>> +               "Set the Nvidia dynamic boost limit");
>>> +ATTR_GROUP_ROG_TUNABLE(nv_temp_target, ATTR_NV_TEMP_TARGET, ASUS_WMI_DEVID_NV_THERM_TARGET,
>>> +               "Set the Nvidia max thermal limit");
>>> +ATTR_GROUP_ROG_TUNABLE(nv_tgp, "nv_tgp", ASUS_WMI_DEVID_DGPU_SET_TGP,
>>> +               "Set the additional TGP on top of the base TGP");
>>> +ATTR_GROUP_INT_VALUE_ONLY_RO(nv_base_tgp, ATTR_NV_BASE_TGP, ASUS_WMI_DEVID_DGPU_BASE_TGP,
>>> +                 "Read the base TGP value");
>>> +
>>> +
>>>   ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>>>                  "Show the current mode of charging");
>>>   @@ -746,6 +800,16 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>>       { &cores_efficiency_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>>       { &cores_performance_attr_group, ASUS_WMI_DEVID_CORES_MAX },
>>>   +    { &ppt_pl1_spl_attr_group, ASUS_WMI_DEVID_PPT_PL1_SPL },
>>> +    { &ppt_pl2_sppt_attr_group, ASUS_WMI_DEVID_PPT_PL2_SPPT },
>>> +    { &ppt_pl3_fppt_attr_group, ASUS_WMI_DEVID_PPT_FPPT },
>>> +    { &ppt_apu_sppt_attr_group, ASUS_WMI_DEVID_PPT_APU_SPPT },
>>> +    { &ppt_platform_sppt_attr_group, ASUS_WMI_DEVID_PPT_PLAT_SPPT },
>>> +    { &nv_dynamic_boost_attr_group, ASUS_WMI_DEVID_NV_DYN_BOOST },
>>> +    { &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
>>> +    { &nv_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>>> +    { &nv_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
>>> +
>>>       { &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>>>       { &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>>>       { &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
>>> @@ -754,8 +818,75 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>>>       { &screen_auto_brightness_attr_group, ASUS_WMI_DEVID_SCREEN_AUTO_BRIGHTNESS },
>>>   };
>>>   +/**
>>> + * is_power_tunable_attr - Determines if an attribute is a power-related tunable
>>> + * @name: The name of the attribute to check
>>> + *
>>> + * This function checks if the given attribute name is related to power tuning.
>>> + *
>>> + * Return: true if the attribute is a power-related tunable, false otherwise
>>> + */
>>> +static bool is_power_tunable_attr(const char *name)
>>> +{
>>> +    static const char * const power_tunable_attrs[] = {
>>> +        ATTR_PPT_PL1_SPL,    ATTR_PPT_PL2_SPPT,
>>> +        ATTR_PPT_PL3_FPPT,    ATTR_PPT_APU_SPPT,
>>> +        ATTR_PPT_PLATFORM_SPPT, ATTR_NV_DYNAMIC_BOOST,
>>> +        ATTR_NV_TEMP_TARGET,    ATTR_NV_BASE_TGP,
>>> +        ATTR_NV_TGP
>>> +    };
>>> +
>>> +    for (unsigned int i = 0; i < ARRAY_SIZE(power_tunable_attrs); i++) {
>>> +        if (!strcmp(name, power_tunable_attrs[i]))
>>> +            return true;
>>> +    }
>>> +
>>> +    return false;
>>> +}
>>> +
>>> +/**
>>> + * has_valid_limit - Checks if a power-related attribute has a valid limit value
>>> + * @name: The name of the attribute to check
>>> + * @limits: Pointer to the power_limits structure containing limit values
>>> + *
>>> + * This function checks if a power-related attribute has a valid limit value.
>>> + * It returns false if limits is NULL or if the corresponding limit value is zero.
>>> + *
>>> + * Return: true if the attribute has a valid limit value, false otherwise
>>> + */
>>> +static bool has_valid_limit(const char *name, const struct power_limits *limits)
>>> +{
>>> +    u32 limit_value = 0;
>>> +
>>> +    if (!limits)
>>> +        return false;
>>> +
>>> +    if (!strcmp(name, ATTR_PPT_PL1_SPL))
>>> +        limit_value = limits->ppt_pl1_spl_max;
>>> +    else if (!strcmp(name, ATTR_PPT_PL2_SPPT))
>>> +        limit_value = limits->ppt_pl2_sppt_max;
>>> +    else if (!strcmp(name, ATTR_PPT_PL3_FPPT))
>>> +        limit_value = limits->ppt_pl3_fppt_max;
>>> +    else if (!strcmp(name, ATTR_PPT_APU_SPPT))
>>> +        limit_value = limits->ppt_apu_sppt_max;
>>> +    else if (!strcmp(name, ATTR_PPT_PLATFORM_SPPT))
>>> +        limit_value = limits->ppt_platform_sppt_max;
>>> +    else if (!strcmp(name, ATTR_NV_DYNAMIC_BOOST))
>>> +        limit_value = limits->nv_dynamic_boost_max;
>>> +    else if (!strcmp(name, ATTR_NV_TEMP_TARGET))
>>> +        limit_value = limits->nv_temp_target_max;
>>> +    else if (!strcmp(name, ATTR_NV_BASE_TGP) ||
>>> +         !strcmp(name, ATTR_NV_TGP))
>>> +        limit_value = limits->nv_tgp_max;
>>> +
>>> +    return limit_value > 0;
>>> +}
>>> +
>>>   static int asus_fw_attr_add(void)
>>>   {
>>> +    const struct power_limits *limits;
>>> +    bool should_create;
>>> +    const char *name;
>>>       int err, i;
>>>         asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
>>> @@ -812,12 +943,30 @@ static int asus_fw_attr_add(void)
>>>           if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>>>               continue;
>>>   -        err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>>> -                     armoury_attr_groups[i].attr_group);
>>> -        if (err) {
>>> -            pr_err("Failed to create sysfs-group for %s\n",
>>> -                   armoury_attr_groups[i].attr_group->name);
>>> -            goto err_remove_groups;
>>> +        /* Always create by default, unless PPT is not present */
>>> +        should_create = true;
>>> +        name = armoury_attr_groups[i].attr_group->name;
>>> +
>>> +        /* Check if this is a power-related tunable requiring limits */
>>> +        if (asus_armoury.rog_tunables[1] && asus_armoury.rog_tunables[1]->power_limits &&
>>> +            is_power_tunable_attr(name)) {
>>> +            limits = asus_armoury.rog_tunables[1]->power_limits;
>>> +            /* Check only AC, if DC is not present then AC won't be either */
>>> +            should_create = has_valid_limit(name, limits);
>>> +            if (!should_create) {
>>> +                pr_debug("Missing max value on %s for tunable: %s\n",
>>> +                     dmi_get_system_info(DMI_BOARD_NAME), name);
>> dmi_get_system_info can return NULL 
> ouch! v14 here I come.
>>> +            }
>>> +        }
>>> +
>>> +        if (should_create) {
>>> +            err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>>> +                armoury_attr_groups[i].attr_group);
>>> +            if (err) {
>>> +                pr_err("Failed to create sysfs-group for %s\n",
>>> +                       armoury_attr_groups[i].attr_group->name);
>>> +                goto err_remove_groups;
>>> +            }
>>>           }
>>>       }
>>>  
>> Thanks,
>> Alok 
> Thanks,
> Denis B.

