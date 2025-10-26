Return-Path: <linux-kernel+bounces-870555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0273CC0B1EE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 21:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 332853B6413
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B6A274658;
	Sun, 26 Oct 2025 20:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NxNU71Zk"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F65240604
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510003; cv=none; b=hMMVmAFeVwBLuSPTLYlzL+6eWqsrx4KuH16n0VHJyL0i4LIMj8JoCpfHAhVPOODeqBiV/jxMyrpf8tm8W+pnoBssMlbSu9a3N8sAvFA3tFWWGJdLcmTFrroWopMMIqqZ1G2vtp/4CVb8aABdgnCahCJDe/ueEbqekAFVc11Kzt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510003; c=relaxed/simple;
	bh=UdVg5bwevzfmUxxds+aM7yktOX6v5J4qUV/nqokGMgU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=hDeokZIjYUnQfYA/CHEH8rCono0zHsVkalfVGtPNC6bgvFFEHfJKds+5B1KkM3DW5Zk0d5rx0QKSuKoFvzOLRisRLZtLjMQO6syMazbnJW5QbVAORLTrbsAftDDeiEwnXFqpzwo+wrcNwTXCB5JM34jD85OU/Nk9A2B8uZvNg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NxNU71Zk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7833765433cso4952890b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 13:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761510000; x=1762114800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+u0kxNNR2IrwhPCJWToOGxwAA455c15jWZGcSEvCSuw=;
        b=NxNU71ZkOrEoe0q8JfOxay81oSk1cHFaRQXU6RVoubOmCWYNPJjxMKiVkQESZfpx95
         2vhI1AU3Bmg3qENiutzCCZXU/lSIiFFwEC0qK7JObUCGuL8lapQBv6omL9Gy/uvUl1kE
         59pJVOhGDtRTSsaKvWWAzJisCZELsTK+bvCEoC3EijwgxpY6s6RUrxveAkP5U4buS987
         Zzmsf5VHKRLlNDLU1NukezqkLVp+vdCsPHqDIsXyH1PYk7+8YkMml3jBJYp2szJMjnML
         icXtpA2uuMiDayBsMu51hwO1fr3IRlPFpi8I86v2W7p+5BHkyAWRcgedxfj06Q2N9mmC
         iSCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761510000; x=1762114800;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+u0kxNNR2IrwhPCJWToOGxwAA455c15jWZGcSEvCSuw=;
        b=A/Ia619hVqT93NwOp6lD2wU451djTiuw2reNX3CEJ4OX0gxGbNW/wzfkRjIUaihe0Q
         NMhXObjmmrov7yrKIv/RM++UlRWuz2ABp+NI8zj0XrCS8loVPd6kJBnkR3qHWKT90wFZ
         O3EQFkqykJnaTsSlEmHtJ9BmWO2onNQM0tFJE9tnVn/G74QVH6Ak2lpbmwTqgh2VSORW
         l9axyD8giz2IN3pLDJUhFHZjNN08IpmgO+pt2zXDd32Bk6qD0GxXP4Xh2Lr+RiiGpjQU
         LZTk0oBqa8U+LU29Yp8iLkyg48ZuScVM8ifBzVXK5nSU0Y3fNcBkUk+rbcA2ewWMEV95
         Gb7A==
X-Forwarded-Encrypted: i=1; AJvYcCUkpRtKcLXUXH0aH66e+SGMVGqGook3FmPcSSPNLsn7yAHuw+imm1nuvkKI3b2pAqKGSQbsM03FjVMj6W4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZGn5LC6mgjwJfvsRvbIuXidaFzxDK3b09WLGP4TdohgZ3Ajn
	hApKnitpbaeK8wCTz0UByNoiUOxjfKM1SZfFDF/5FiiVuiEve/R/Mm8T
X-Gm-Gg: ASbGncsgMzCBB9GENosRSkxLNWocrEz8HuDBawHrRLb19+roErzc7TnTHDiPdJdyohi
	C6DPyRUUqv+7+prSSIo19jI5GlnoVzYzsCCy0SHlwumR4Zy9HJBFzpA56csqmCusUS4UTRsfRK3
	Iaw3qx6bwz9LisLZUp0jgmpLf/w/eYKfmap69Oys/jZbM1wA/5jCwyNft7qfr3dz61gfQwM01pV
	WXPagpC62oZNjXQi/pvAldHRvHZhAGnDY49vbjmvrZRxk0voTVKpdPkzh9TVAIzoQwIqrn3S/zH
	mP/Jz0/yRv4zNIWXDN3EfYTQrARfEzygDhWKhRNqUUJMrQAOAuRfg3EEpTtUoDxSyQWzdI69mF6
	eLM2VcCWDy5M5vrUTTzPHcafwd2IpehWCv+8sdh9Svln+0iHFDvHcYi+ggUjlyb+YYgzdiOH54p
	kCDW0NSnEgSgj/RG7ME3g7yGIZIcl1KaowSyw2/fL+ss1mKHcmRsLZF2S5pgw1wWbqUiTe2F9R3
	JmXmYL+ag==
X-Google-Smtp-Source: AGHT+IHtNVq0PO/FhU/YgWQN7GrulZp3ql2/SxHdPL+cjTjdLcywCo2o4b4goy3zJDtBDDokBLkEXQ==
X-Received: by 2002:a05:6a00:22c8:b0:7a2:8529:259 with SMTP id d2e1a72fcca58-7a285294df3mr10371477b3a.9.1761509999558;
        Sun, 26 Oct 2025 13:19:59 -0700 (PDT)
Received: from ehlo.thunderbird.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409c703sm5645226b3a.70.2025.10.26.13.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Oct 2025 13:19:59 -0700 (PDT)
Date: Sun, 26 Oct 2025 13:19:57 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Rong Zhang <i@rong.moe>
CC: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>,
 Hans de Goede <hansg@kernel.org>,
 =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_4/6=5D_platform/x86=3A_lenovo-?=
 =?US-ASCII?Q?wmi-other=3A_Add_HWMON_for_fan_speed_RPM?=
User-Agent: Thunderbird for Android
In-Reply-To: <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
References: <20251019210450.88830-1-i@rong.moe> <20251019210450.88830-5-i@rong.moe> <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com> <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
Message-ID: <9945A704-7D4B-4ECE-81CD-8D99F30733BF@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On October 26, 2025 12:42:22 PM PDT, Rong Zhang <i@rong=2Emoe> wrote:
>Hi Derek,
>
>On Sat, 2025-10-25 at 22:23 -0700, Derek John Clark wrote:
>> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong=2Emoe> wrote=
:
>> >=20
>> > Register an HWMON device for fan spped RPM according to Capability Da=
ta
>> > 00 provided by lenovo-wmi-capdata=2E The corresponding HWMON nodes ar=
e:
>> >=20
>> >  - fanX_enable: enable/disable the fan (tunable)
>> >  - fanX_input: current RPM
>> >  - fanX_target: target RPM (tunable)
>> >=20
>> > Signed-off-by: Rong Zhang <i@rong=2Emoe>
>> > ---
>> >  =2E=2E=2E/wmi/devices/lenovo-wmi-other=2Erst          |   5 +
>> >  drivers/platform/x86/lenovo/Kconfig           |   1 +
>> >  drivers/platform/x86/lenovo/wmi-other=2Ec       | 324 ++++++++++++++=
+++-
>> >  3 files changed, 317 insertions(+), 13 deletions(-)
>> >=20
>> > diff --git a/Documentation/wmi/devices/lenovo-wmi-other=2Erst b/Docum=
entation/wmi/devices/lenovo-wmi-other=2Erst
>> > index adbd7943c6756=2E=2Ecb6a9bfe5a79e 100644
>> > --- a/Documentation/wmi/devices/lenovo-wmi-other=2Erst
>> > +++ b/Documentation/wmi/devices/lenovo-wmi-other=2Erst
>> > @@ -31,6 +31,11 @@ under the following path:
>> >=20
>> >    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attrib=
ute>/
>> >=20
>> > +Besides, this driver also exports fan speed RPM to HWMON:
>> > + - fanX_enable: enable/disable the fan (tunable)
>> > + - fanX_input: current RPM
>> > + - fanX_target: target RPM (tunable)
>> > +
>> >  LENOVO_CAPABILITY_DATA_00
>> >  -------------------------
>> >=20
>> > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x=
86/lenovo/Kconfig
>> > index fb96a0f908f03=2E=2Ebe9af04511462 100644
>> > --- a/drivers/platform/x86/lenovo/Kconfig
>> > +++ b/drivers/platform/x86/lenovo/Kconfig
>> > @@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
>> >  config LENOVO_WMI_TUNING
>> >         tristate "Lenovo Other Mode WMI Driver"
>> >         depends on ACPI_WMI
>> > +       select HWMON
>> >         select FW_ATTR_CLASS
>> >         select LENOVO_WMI_DATA
>> >         select LENOVO_WMI_EVENTS
>> > diff --git a/drivers/platform/x86/lenovo/wmi-other=2Ec b/drivers/plat=
form/x86/lenovo/wmi-other=2Ec
>> > index 20c6ff0be37a1=2E=2Ef8771ed3c6642 100644
>> > --- a/drivers/platform/x86/lenovo/wmi-other=2Ec
>> > +++ b/drivers/platform/x86/lenovo/wmi-other=2Ec
>> > @@ -14,7 +14,15 @@
>> >   * These attributes typically don't fit anywhere else in the sysfs a=
nd are set
>> >   * in Windows using one of Lenovo's multiple user applications=2E
>> >   *
>> > + * Besides, this driver also exports tunable fan speed RPM to HWMON=
=2E
>> > + *
>> >   * Copyright (C) 2025 Derek J=2E Clark <derekjohn=2Eclark@gmail=2Eco=
m>
>> > + *   - fw_attributes
>> > + *   - binding to Capability Data 01
>> > + *
>> > + * Copyright (C) 2025 Rong Zhang <i@rong=2Emoe>
>> > + *   - HWMON
>> > + *   - binding to Capability Data 00
>> >   */
>> >=20
>> >  #include <linux/acpi=2Eh>
>> > @@ -25,6 +33,7 @@
>> >  #include <linux/device=2Eh>
>> >  #include <linux/export=2Eh>
>> >  #include <linux/gfp_types=2Eh>
>> > +#include <linux/hwmon=2Eh>
>> >  #include <linux/idr=2Eh>
>> >  #include <linux/kdev_t=2Eh>
>> >  #include <linux/kobject=2Eh>
>> > @@ -43,12 +52,20 @@
>> >=20
>> >  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B=
"
>> >=20
>> > +#define LWMI_SUPP_VALID BIT(0)
>> > +#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
>> > +#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
>> > +
>> >  #define LWMI_DEVICE_ID_CPU 0x01
>> >=20
>> >  #define LWMI_FEATURE_ID_CPU_SPPT 0x01
>> >  #define LWMI_FEATURE_ID_CPU_SPL 0x02
>> >  #define LWMI_FEATURE_ID_CPU_FPPT 0x03
>> >=20
>> > +#define LWMI_DEVICE_ID_FAN 0x04
>> > +
>> > +#define LWMI_FEATURE_ID_FAN_RPM 0x03
>> > +
>> >  #define LWMI_TYPE_ID_NONE 0x00
>> >=20
>> >  #define LWMI_FEATURE_VALUE_GET 17
>> > @@ -59,7 +76,18 @@
>> >  #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
>> >  #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
>> >=20
>> > +/* Only fan1 and fan2 are present on supported devices=2E */
>> > +#define LWMI_FAN_ID_BASE 1
>> > +#define LWMI_FAN_NR 2
>> > +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
>> > +
>> > +#define LWMI_ATTR_ID_FAN_RPM(x)                                     =
           \
>> > +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |     =
   \
>> > +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) =
|  \
>> > +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
>> > +
>> >  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
>> > +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>> >=20
>> >  static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>> >  static DEFINE_IDA(lwmi_om_ida);
>> > @@ -76,15 +104,256 @@ struct lwmi_om_priv {
>> >         struct component_master_ops *ops;
>> >=20
>> >         /* only valid after capdata bind */
>> > +       struct cd_list *cd00_list;
>> >         struct cd_list *cd01_list;
>> >=20
>> > +       struct device *hwmon_dev;
>> >         struct device *fw_attr_dev;
>> >         struct kset *fw_attr_kset;
>> >         struct notifier_block nb;
>> >         struct wmi_device *wdev;
>> >         int ida_id;
>> > +
>> > +       struct fan_info {
>> > +               u32 supported;
>> > +               long target;
>> > +       } fan_info[LWMI_FAN_NR];
>> >  };
>> >=20
>> > +/* =3D=3D=3D=3D=3D=3D=3D=3D HWMON (component: lenovo-wmi-capdata 00)=
 =3D=3D=3D=3D=3D=3D=3D=3D */
>> > +
>> > +/**
>> > + * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
>> > + * @priv: Driver private data structure
>> > + * @channel: Fan channel index (0-based)
>> > + * @val: Pointer to value (input for set, output for get)
>> > + * @set: True to set value, false to get value
>> > + *
>> > + * Communicates with WMI interface to either retrieve current fan RP=
M
>> > + * or set target fan speed=2E
>> > + *
>> > + * Return: 0 on success, or an error code=2E
>> > + */
>> > +static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channe=
l, u32 *val, bool set)
>> > +{
>> > +       struct wmi_method_args_32 args;
>> > +       u32 method_id, retval;
>> > +       int err;
>> > +
>> > +       method_id =3D set ? LWMI_FEATURE_VALUE_SET : LWMI_FEATURE_VAL=
UE_GET;
>> > +       args=2Earg0 =3D LWMI_ATTR_ID_FAN_RPM(channel);
>> > +       args=2Earg1 =3D set ? *val : 0;
>> > +
>> > +       err =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, method_id,
>> > +                                   (unsigned char *)&args, sizeof(ar=
gs), &retval);
>> > +       if (err)
>> > +               return err;
>> > +
>> > +       if (!set)
>> > +               *val =3D retval;
>> > +       else if (retval !=3D 1)
>> > +               return -EIO;
>> > +
>> > +       return 0;
>> > +}
>> > +
>> > +/**
>> > + * lwmi_om_hwmon_is_visible() - Determine visibility of HWMON attrib=
utes
>> > + * @drvdata: Driver private data
>> > + * @type: Sensor type
>> > + * @attr: Attribute identifier
>> > + * @channel: Channel index
>> > + *
>> > + * Determines whether a HWMON attribute should be visible in sysfs
>> > + * based on hardware capabilities and current configuration=2E
>> > + *
>> > + * Return: permission mode, or 0 if invisible=2E
>> > + */
>> > +static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hw=
mon_sensor_types type,
>> > +                                       u32 attr, int channel)
>> > +{
>> > +       struct lwmi_om_priv *priv =3D (struct lwmi_om_priv *)drvdata;
>> > +       bool r =3D false, w =3D false;
>> > +
>> > +       if (type =3D=3D hwmon_fan) {
>> > +               switch (attr) {
>> > +               case hwmon_fan_enable:
>> > +               case hwmon_fan_target:
>> > +                       r =3D w =3D priv->fan_info[channel]=2Esupport=
ed & LWMI_SUPP_MAY_SET;
>> > +                       break;
>> > +               case hwmon_fan_input:
>> > +                       r =3D priv->fan_info[channel]=2Esupported & L=
WMI_SUPP_MAY_GET;
>> > +                       break;
>> > +               }
>> > +       }
>> > +
>>=20
>> There is another method in capdata00 that could be useful here
>>=20
>> Fan Test For Diagnostic Software
>> uint32 IDs //0x04050000
>> uint32 Capability //9:by project
>> bit 3: 0: not support LENOVO_FAN_TEST_DATA, 1 support LENOVO_FAN_TEST_D=
ATA
>> bit 2: 0: not support SetFeatureValue(), 1: support SetFeatureValue()
>> bit 1: 0: not support GetFeatureValue(), 1: support GetFeatureValue()
>> bit 0: 0: not support fan test for diagnostic software, 1: support an
>> test for diagnostic software
>
>The information is useful, thanks for that!
>
>A quick look at the decompiled ASL code of my device's ACPI tables:
>
>   Package (0x03)
>   {
>       0x04050000,
>       0x07,
>       One
>   },
>
>I've confirmed that the corresponding ACPI method didn't modify the
>return value of 0x04050000=2E
>
>0x07 means my device supports this interface, GetFeatureValue() and
>SetFeatureValue(); but does not support LENOVO_FAN_TEST_DATA=2E Is BIT(3)
>only defined in some models (but not on my device)? The data returned
>by LENOVO_FAN_TEST_DATA seems correct and is probably the min/max auto
>points=2E
>
Bah, of course not=2E I suppose it wouldn't be a Lenovo BIOS if everything=
 was consistent with their spec=2E=2E=2E=20

>My device didn't implement {Get,Set}FeatureValue(0x04050000)=2E What will
>it do when it's implemented?

I doubt anything=2E It seems like get/set is generally enabled for most at=
tributes even if they are stubbed=2E It's probably why I get the attributes=
 are available with v1 even when my device has stubbed methods=2E=20

>> I'll discuss below, but it seems like knowing min/max is a good idea
>> before making the sysfs visible=2E
>>=20
>> > +       if (!r)
>> > +               return 0;
>> > +
>> > +       return w ? 0644 : 0444;
>> > +}
>> > +
>> > +/**
>> > + * lwmi_om_hwmon_read() - Read HWMON sensor data
>> > + * @dev: Device pointer
>> > + * @type: Sensor type
>> > + * @attr: Attribute identifier
>> > + * @channel: Channel index
>> > + * @val: Pointer to store value
>> > + *
>> > + * Reads current sensor values from hardware through WMI interface=
=2E
>> > + *
>> > + * Return: 0 on success, or an error code=2E
>> > + */
>> > +static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_=
types type,
>> > +                             u32 attr, int channel, long *val)
>> > +{
>> > +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>> > +       u32 retval =3D 0;
>> > +       int err;
>> > +
>> > +       if (type =3D=3D hwmon_fan) {
>> > +               switch (attr) {
>> > +               case hwmon_fan_input:
>> > +                       err =3D lwmi_om_fan_get_set(priv, channel, &r=
etval, false);
>> > +                       if (err)
>> > +                               return err;
>> > +
>> > +                       *val =3D retval;
>> > +                       return 0;
>> > +               case hwmon_fan_enable:
>> > +               case hwmon_fan_target:
>> > +                       /* -ENODATA before first set=2E */
>>=20
>> Why not query the interface in realtime to know the system state? That
>> would avoid this problem=2E
>
>My implementation follows the approach of corsair-cpro
>(drivers/hwmon/corsair-cpro=2Ec)=2E hwmon_fan_target is about "how much R=
PM
>*should* the fan reach?", while hwmon_fan_input is about "how much RPM
>does the fan *really* reach?"
>
>Calling SetFeatureValue(0x040300*) sets the former, while calling
>GetFeatureValue(0x040300*) queries the latter=2E IIUC, using
>GetFeatureValue(0x040300*) for hwmon_fan_target violates the
>definition, especially when the fan is in auto mode=2E
>

My interpretation was that we could at least determine enable=2E I'm not s=
o worried about determining target as that makes sense it wouldn't be anyth=
ing=2E Based on your below data it seems the documentation is not consisten=
t with real world data so it might not be possible even for enable, which i=
s annoying=2E=20

Is the last setting retained on boot, or does it reset after restarting (o=
r suspend/resume for that matter)? If it's reset, we can probably safely as=
sume auto mode on init? I'll defer to your judgement here since you have a =
device in hand=2E

>> > +                       err =3D (int)priv->fan_info[channel]=2Etarget=
;
>> > +                       if (err < 0)
>> > +                               return err;
>> > +
>> > +                       if (attr =3D=3D hwmon_fan_enable)
>> > +                               *val =3D priv->fan_info[channel]=2Eta=
rget !=3D 1;
>> > +                       else
>> > +                               *val =3D priv->fan_info[channel]=2Eta=
rget;
>> > +                       return 0;
>> > +               }
>> > +       }
>> > +
>> > +       return -EOPNOTSUPP;
>> > +}
>> > +
>> > +/**
>> > + * lwmi_om_hwmon_write() - Write HWMON sensor data
>> > + * @dev: Device pointer
>> > + * @type: Sensor type
>> > + * @attr: Attribute identifier
>> > + * @channel: Channel index
>> > + * @val: Value to write
>> > + *
>> > + * Writes configuration values to hardware through WMI interface=2E
>> > + *
>> > + * Return: 0 on success, or an error code=2E
>> > + */
>> > +static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor=
_types type,
>> > +                              u32 attr, int channel, long val)
>> > +{
>> > +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>> > +       u32 raw;
>> > +       int err;
>> > +
>> > +       if (type =3D=3D hwmon_fan) {
>> > +               switch (attr) {
>> > +               case hwmon_fan_enable:
>> > +               case hwmon_fan_target:
>> > +                       if (attr =3D=3D hwmon_fan_enable) {
>> > +                               if (val =3D=3D 0)
>> > +                                       raw =3D 1; /* stop */
>> > +                               else if (val =3D=3D 1)
>> > +                                       raw =3D 0; /* auto */
>> > +                               else
>> > +                                       return -EINVAL;
>> > +                       } else {
>> > +                               /*
>> > +                                * val > U16_MAX seems safe but meani=
ngless=2E
>> > +                                */
>> > +                               if (val < 0 || val > U16_MAX)
>>=20
>> I think it might be prudent to only permit these settings if fan speed
>> params can't be known=2E Pragmatically it ensures userspace is aware of
>> the range of the interface=2E Per the documentation it should be "safe"
>> as is, but setting below the min fan speed will return it to "auto"
>> mode and the hwmon will be out of sync=2E Anything above should just be
>> set to the max, if the BIOS is working properly=2E
>
>On my device, the data returned by LENOVO_FAN_TEST_DATA seems to be the
>min/max auto points=2E The fan can spin much slower/faster than the
>min/max RPM=2E Setting below the "real" min RPM stops the fan - setting 0
>is the only way to return it to auto mode=2E
>
Okay=2E I'm not surprised at this point when real world data contradicts t=
he spec=2E=20

Thanks,
Derek

>   # grep =2E fan1_*
>   grep: fan1_enable: No data available
>   fan1_input:2200
>   fan1_max:5000
>   fan1_min:2200
>   grep: fan1_target: No data available
>   # echo 800 >fan1_target
>   # cat fan1_input
>   800
>   # echo 700 >fan1_target
>   # cat fan1_input
>   700
>   # echo 10000 >fan1_target
>   # cat fan1_input
>   6500
>   # echo 100 >fan1_target
>   # cat fan1_input
>   0
>   # taskset -c 2 stress-ng -c 1 >/dev/null &
>   [1] 37967
>   # cat fan1_input
>   0
>   # echo 0 >fan1_target
>   # cat fan1_input
>   2200
>   # cat fan1_input
>   2600
>
>> IMO the fan speed data is essential to ensuring the hwmon interface is
>> usable and synced=2E I'd move that patch before this one in the series
>> and make the 0x04050000 method reporting IsSupported required for any
>> of the attributes to be visible, with value checks against the min/max
>> when setting a given fan=2E
>
>I agree that setting the RPM too low/high may results in HWMON being
>out of sync, which is usually not desired=2E Will=C2=A0do these in v2=2E
>
>My extra idea:
>- drop the parameter "ignore_fan_cap"=2E
>- new parameter "expose_all_fans": does not hide fans when missing from
>  LENOVO_FAN_TEST_DATA or when 0x04050000 reports unsupported=2E
>  0x040300* is always checked to hide missing fans=2E
>- new parameter "enforce_fan_rpm_range": defaults to true, checks
>  against the min/max RPM from LENOVO_FAN_TEST_DATA while setting
>  target RPM=2E dev_warn_once() when it exceeds min/max RPM=2E
>
>> > +                                       return -EINVAL;
>> > +                               raw =3D val;
>> > +                       }
>> > +
>> > +                       err =3D lwmi_om_fan_get_set(priv, channel, &r=
aw, true);
>> > +                       if (err)
>> > +                               return err;
>> > +
>> > +                       priv->fan_info[channel]=2Etarget =3D raw;
>> > +                       return 0;
>> > +               }
>> > +       }
>> > +
>> > +       return -EOPNOTSUPP;
>> > +}
>> > +
>> > +static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] =
=3D {
>> > +       /* Must match LWMI_FAN_NR=2E */
>> > +       HWMON_CHANNEL_INFO(fan,
>> > +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_T=
ARGET,
>> > +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_T=
ARGET),
>> > +       NULL
>> > +};
>> > +
>> > +static const struct hwmon_ops lwmi_om_hwmon_ops =3D {
>> > +       =2Eis_visible =3D lwmi_om_hwmon_is_visible,
>> > +       =2Eread =3D lwmi_om_hwmon_read,
>> > +       =2Ewrite =3D lwmi_om_hwmon_write,
>> > +};
>> > +
>> > +static const struct hwmon_chip_info lwmi_om_hwmon_chip_info =3D {
>> > +       =2Eops =3D &lwmi_om_hwmon_ops,
>> > +       =2Einfo =3D lwmi_om_hwmon_info,
>> > +};
>> > +
>> > +/**
>> > + * lwmi_om_hwmon_add() - Register HWMON device
>> > + * @priv: Driver private data
>> > + *
>> > + * Initializes capability data and registers the HWMON device=2E
>> > + *
>> > + * Return: 0 on success, or an error code=2E
>> > + */
>> > +static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
>> > +{
>> > +       struct capdata00 capdata00;
>> > +       int i, err;
>> > +
>> > +       for (i =3D 0; i < LWMI_FAN_NR; i++) {
>>=20
>> There is an assumption here that isn't accurate=2E Each fan ID
>> corresponds to a specific fan functionality=2E 01 is CPU Fan, 02 is GPU
>> Fan, 02 is GPU Power Fan, and 04 is System Fan=2E Not every fan needs t=
o
>> exist, so an ID table might look like this (example from docs):
>>=20
>> illustrate=EF=BC=9A
>> UINT32 NumOfFans =3D 3;
>> NoteBook:
>> 1: CPU Fan ID
>> 2: GPU Fan ID
>> 3: GPU Power Fan ID
>> 4: System Fan ID
>> UINT32 FanId [1,2,4]
>> UINT32 FanMaxSpeed[5400, 5400, 9000];
>> UINT32 FanMinSpeed[1900, 1900, 2000];
>
>Thanks for the information=2E My device only defines 0x0403000{1,2} in
>LENOVO_CAPABILITY_DATA_00, so I assumed LWMI_FAN_NR =3D=3D 2=2E
>
>> In such a case, "count" would be 3, but the idx should be 4 going to
>> the hardware because the GPU Power Fan isn't present, while the case
>> fan is=2E
>
>LWMI_FAN_NR has nothing to do with the actual "count"=2E It is about "how
>many HWMON fan channels are defined?" It exists because HWMON channels
>are defined statically - we hide defined channels when they are missing
>from LENOVO_CAPABILITY_DATA_00 (and LENOVO_FAN_TEST_DATA, if
>available)=2E
>
>The implementation of lenovo-wmi-other doesn't use NumOfFans either -
>it queries LENOVO_FAN_TEST_DATA using fan ID directly=2E NumOfFans is
>only used when lenovo-wmi-capdata retrieves the data=2E
>
>This implementation has another advantage: the X in fanX_* is always
>the same as the fan ID in
>LENOVO_CAPABILITY_DATA_00/LENOVO_FAN_TEST_DATA even in your example
>where fan 3 is missing - fan3_* is invisible, fan{1,2,4}_* are exposed=2E
>
>Given the information, I will define 4 fan channels in v2=2E
>
>> Thanks,
>> Derek
>
>Thanks,
>Rong
>
>> > +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR=
_ID_FAN_RPM(i),
>> > +                                        &capdata00);
>> > +               if (err)
>> > +                       continue;
>> > +
>> > +               priv->fan_info[i] =3D (struct fan_info) {
>> > +                       =2Esupported =3D capdata00=2Esupported,
>> > +                       =2Etarget =3D -ENODATA,
>> > +               };
>> > +       }
>> > +
>> > +       priv->hwmon_dev =3D hwmon_device_register_with_info(&priv->wd=
ev->dev, LWMI_OM_HWMON_NAME,
>> > +                                                         priv, &lwmi=
_om_hwmon_chip_info, NULL);
>> > +
>> > +       return PTR_ERR_OR_ZERO(priv->hwmon_dev);
>> > +}
>> > +
>> > +/**
>> > + * lwmi_om_hwmon_remove() - Unregister HWMON device
>> > + * @priv: Driver private data
>> > + *
>> > + * Unregisters the HWMON device and resets all fans to automatic mod=
e=2E
>> > + * Ensures hardware doesn't remain in manual mode after driver remov=
al=2E
>> > + */
>> > +static void lwmi_om_hwmon_remove(struct lwmi_om_priv *priv)
>> > +{
>> > +       hwmon_device_unregister(priv->hwmon_dev);
>> > +}
>> > +
>> > +/* =3D=3D=3D=3D=3D=3D=3D=3D fw_attributes (component: lenovo-wmi-cap=
data 01) =3D=3D=3D=3D=3D=3D=3D=3D */
>> > +
>> >  struct tunable_attr_01 {
>> >         struct capdata01 *capdata;
>> >         struct device *dev;
>> > @@ -564,15 +833,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_=
om_priv *priv)
>> >         device_unregister(priv->fw_attr_dev);
>> >  }
>> >=20
>> > +/* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=
=3D=3D=3D=3D=3D=3D */
>> > +
>> >  /**
>> >   * lwmi_om_master_bind() - Bind all components of the other mode dri=
ver
>> >   * @dev: The lenovo-wmi-other driver basic device=2E
>> >   *
>> > - * Call component_bind_all to bind the lenovo-wmi-capdata01 driver t=
o the
>> > - * lenovo-wmi-other master driver=2E On success, assign the capabili=
ty data 01
>> > - * list pointer to the driver data struct for later access=2E This p=
ointer
>> > - * is only valid while the capdata01 interface exists=2E Finally, re=
gister all
>> > - * firmware attribute groups=2E
>> > + * Call component_bind_all to bind the lenovo-wmi-capdata devices to=
 the
>> > + * lenovo-wmi-other master driver=2E On success, assign the capabili=
ty data
>> > + * list pointers to the driver data struct for later access=2E These=
 pointers
>> > + * are only valid while the capdata interfaces exist=2E Finally, reg=
ister the
>> > + * HWMON device and all firmware attribute groups=2E
>> >   *
>> >   * Return: 0 on success, or an error code=2E
>> >   */
>> > @@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device *d=
ev)
>> >         if (ret)
>> >                 return ret;
>> >=20
>> > -       priv->cd01_list =3D binder=2Ecd01_list;
>> > -       if (!priv->cd01_list)
>> > +       if (!binder=2Ecd00_list && !binder=2Ecd01_list)
>> >                 return -ENODEV;
>> >=20
>> > -       return lwmi_om_fw_attr_add(priv);
>> > +       priv->cd00_list =3D binder=2Ecd00_list;
>> > +       if (priv->cd00_list) {
>> > +               ret =3D lwmi_om_hwmon_add(priv);
>> > +               if (ret)
>> > +                       return ret;
>> > +       }
>> > +
>> > +       priv->cd01_list =3D binder=2Ecd01_list;
>> > +       if (priv->cd01_list) {
>> > +               ret =3D lwmi_om_fw_attr_add(priv);
>> > +               if (ret) {
>> > +                       if (priv->cd00_list)
>> > +                               lwmi_om_hwmon_remove(priv);
>> > +                       return ret;
>> > +               }
>> > +       }
>> > +
>> > +       return 0;
>> >  }
>> >=20
>> >  /**
>> >   * lwmi_om_master_unbind() - Unbind all components of the other mode=
 driver
>> >   * @dev: The lenovo-wmi-other driver basic device
>> >   *
>> > - * Unregister all capability data attribute groups=2E Then call
>> > - * component_unbind_all to unbind the lenovo-wmi-capdata01 driver fr=
om the
>> > - * lenovo-wmi-other master driver=2E Finally, free the IDA for this =
device=2E
>> > + * Unregister the HWMON device and all capability data attribute gro=
ups=2E Then
>> > + * call component_unbind_all to unbind the lenovo-wmi-capdata driver=
 from the
>> > + * lenovo-wmi-other master driver=2E
>> >   */
>> >  static void lwmi_om_master_unbind(struct device *dev)
>> >  {
>> >         struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>> >=20
>> > -       lwmi_om_fw_attr_remove(priv);
>> > +       if (priv->cd00_list)
>> > +               lwmi_om_hwmon_remove(priv);
>> > +
>> > +       if (priv->cd01_list)
>> > +               lwmi_om_fw_attr_remove(priv);
>> > +
>> >         component_unbind_all(dev, NULL);
>> >  }
>> >=20
>> > @@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *wd=
ev, const void *context)
>> >         if (!priv)
>> >                 return -ENOMEM;
>> >=20
>> > +       /* Sentinel for on-demand ida_free()=2E */
>> > +       priv->ida_id =3D -EIDRM;
>> > +
>> >         priv->wdev =3D wdev;
>> >         dev_set_drvdata(&wdev->dev, priv);
>> >=20
>> > @@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device *=
wdev)
>> >         struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
>> >=20
>> >         component_master_del(&wdev->dev, &lwmi_om_master_ops);
>> > -       ida_free(&lwmi_om_ida, priv->ida_id);
>> > +
>> > +       if (priv->ida_id >=3D 0)
>> > +               ida_free(&lwmi_om_ida, priv->ida_id);
>> >  }
>> >=20
>> >  static const struct wmi_device_id lwmi_other_id_table[] =3D {
>> > @@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
>> >  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
>> >  MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
>> >  MODULE_AUTHOR("Derek J=2E Clark <derekjohn=2Eclark@gmail=2Ecom>");
>> > +MODULE_AUTHOR("Rong Zhang <i@rong=2Emoe>");
>> >  MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
>> >  MODULE_LICENSE("GPL");
>> > --
>> > 2=2E51=2E0
>> >=20


