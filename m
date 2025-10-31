Return-Path: <linux-kernel+bounces-879364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD4C22EFB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B8F1A22534
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE5723183B;
	Fri, 31 Oct 2025 02:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ24Teyq"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EDD16FF37
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761876026; cv=none; b=BBk9BoVXAlzAtzd2cYtZs7KpoRXxB/d1DudjgYg7DB6K7bqTeqfwJlLQmwnKV1PfOhPrUW0iJ6//mT73Tx2N3usrNmgsqrDQ1li4Ezm6MzPWQ+A7gRM+xyL6CdnEh/+TJv4W/osmLKhXLLM//o6q/8YZwH+wUkM5f9YIvYtBerM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761876026; c=relaxed/simple;
	bh=Ak3awO6psgIlgthxtJs7GNj074bsW5I8h4dtKECroBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2bQoFN4MBdasmbNRT1wXil9j/qqbzit85oiBRtcqMuTd578tSa/urrMN7Blw8zx0cuTezazD3XJSyhaXSAaVy0V6AIriBmf2rvocRsd9gyLwUzut1UuTxaL2urfvLHLbVI1dHNjHzwiHxkS/qFBG2m3bs6rp++h1YgtiD85CtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZ24Teyq; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-879b99b7ca8so18339796d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761876023; x=1762480823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxMmwiZKnK2JjjkATp2XrWzdi6NYbOM2YmYpZZccq98=;
        b=MZ24TeyqTDnf22LR9tZZZ07QylVmULb28un9JP8Gu5nyB6pm1ux92FRBpKYFaStEgx
         opjQPQgtOAyXQHlVa/MVgKXr9nAJIgofxDK1o+IOT9nQPmThMznYp8WV0x7wfqXN6ID8
         RWiLb+jA4/o8wjdmwOdMLLMwPUkwdF2rEQSp5goqyYiAr0I0jfWsSksIi0Px8MARrMjr
         V5MgDypdwoEyAhjP6txWjWbjtXTP4am14MeMVMV9dFj1j5jiFL2nxxI281BhGSP3LuOH
         CTwF22YiY+Jv0MlzWbMy5Ix8vW/PQH6yb17HyxHhBCazKc5GtIwyckNtpVGvYhRiQD+n
         hzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761876023; x=1762480823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxMmwiZKnK2JjjkATp2XrWzdi6NYbOM2YmYpZZccq98=;
        b=oytAXAaGZ8MLtscsI6QaNhTZ9zBHONX+Y6tEiyD8OGtaIGLTGdyupbCO24RCv20Nh8
         W+1hABOokLjVvp30MkBqHC5PxrqWZiXmF7mwdoSwq3KsW3hoSgegZNofKxAb+FAZKErN
         S4avZAIJc55O8wUWUyC3hDG+GaKkxZQG9clIEkNG7WU8xHthIs5mjCCkG7KJSRnPUiia
         Cc6J/SVDmc1Tq5Ww9EkBroVAKB6BUYoEXkaC6TwrUrkDuUpy/tsVU/XDCqz/cZE4DaYL
         wjqECWVK9oU1TOr0ff3U75q72kuqwNVQoK4Z+SLk0KXPgy3uwEJMkjJY4FG2FN4ITtBP
         +kuw==
X-Forwarded-Encrypted: i=1; AJvYcCVM+/XRDRGtMrW+MFK/akGh99bs0ArU64cBd5xhbz3YQU7RgyPXl7jP/7Mm+w0LIaCwXeITsvsNsvRyCJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdwfCZq/ERwolmBVrhrME2d1b3GJlwlv1ac1uHIuq74sCjns+Z
	8j56E6xwxZjPrOicitfB6wVkICQIjqUa/RQpZDP2RjdvW2d6Rwp32xtqstVA3yLSm9nVy3hbvSZ
	OXhTOCmEwSfYKIR7MIEQQrZBH/VXm1fc=
X-Gm-Gg: ASbGncvf2C60KyMcCiAnCBCj5Vo1qJvDb4K4QBaQN+SS8E95ZeWrTha6hq72PJTpSD1
	o6EZ5JDmarF6WUULZ1tOvnQ8yXWpk8Ktml8lK1I8XO7LbVIK9SyIuGE9cTu3c7Dch5etsSBvjgy
	0/S+Jgzi9BXku0tqAuOHA3feJEisNRWKUY9OIWo8/Cs68eAcghlnLBDJIcYduMOSyFY+cRAu63a
	u2f/KwJkM9qVn/6x+xobcScTcJWyo1xJmsH6xcJ3uD6IyPBlcftCO0V1VYQ7MU3Urkn5w7d
X-Google-Smtp-Source: AGHT+IFBAWAQzIxIIqZLeuNMhNYzn6IhjTil4uFNk2bFcRvuZfM5FkdCztS5WVoTu7Aa1nrkRi7MKy4AxSgO/S5Utc8=
X-Received: by 2002:a05:6214:f02:b0:880:2368:2e70 with SMTP id
 6a1803df08f44-8802f43e997mr24060576d6.39.1761876022561; Thu, 30 Oct 2025
 19:00:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251030193955.107148-1-i@rong.moe> <20251030193955.107148-7-i@rong.moe>
In-Reply-To: <20251030193955.107148-7-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 30 Oct 2025 19:00:11 -0700
X-Gm-Features: AWmQ_bnGqgjJQTGneibOH5q81LK641_JZ6aZK89TCTMuWwcRqBeYC_witsjOsXE
Message-ID: <CAFqHKTn1R+go5zcUdqRqsQgdXO=esne7vOT4QuiMd4kPx8Yqpw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] platform/x86: lenovo-wmi-other: Add HWMON for fan
 speed RPM
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 12:40=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Register an HWMON device for fan spped RPM according to Capability Data
> 00 and Fan Test Data provided by lenovo-wmi-capdata. The corresponding
> HWMON nodes are:
>
>  - fanX_enable: enable/disable the fan (tunable)
>  - fanX_input: current RPM
>  - fanX_max: maximum RPM
>  - fanX_min: minimum RPM
>  - fanX_target: target RPM (tunable)
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
> Changes in v2:
> - Define 4 fan channels instead of 2 (thanks Derek J. Clark)
> - Squash min/max reporting patch into this one (ditto)
> - Query 0x04050000 for interface availability (ditto)
>   - New parameter "expose_all_fans" to skip this check
> - Enforce min/max RPM constraint on set (ditto)
>   - New parameter "relax_fan_constraint" to disable this behavior
>   - Drop parameter "ignore_fan_cap", superseded by the next one
>   - New parameter "expose_all_fans" to expose fans w/o such data
> - Assume auto mode on probe (ditto)
> - Reword documentation (ditto)
> - Do not register HWMON device if no fan can be exposed
> - fanX_target: Return -EBUSY instead of raw target value when fan stops
> ---
>  .../wmi/devices/lenovo-wmi-other.rst          |  11 +
>  drivers/platform/x86/lenovo/Kconfig           |   1 +
>  drivers/platform/x86/lenovo/wmi-other.c       | 467 +++++++++++++++++-
>  3 files changed, 467 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentati=
on/wmi/devices/lenovo-wmi-other.rst
> index 821282e07d93c..10e47c60982e5 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> @@ -31,6 +31,8 @@ under the following path:
>
>    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
>
> +Besides, this driver also exports attributes to HWMON.
> +

The word besides seems grammatically odd here. Perhaps "Additionally",
or simply start with "This">
>  LENOVO_CAPABILITY_DATA_00
>  -------------------------
>
> @@ -39,6 +41,11 @@ WMI GUID ``362A3AFE-3D96-4665-8530-96DAD5BB300E``
>  The LENOVO_CAPABILITY_DATA_00 interface provides various information tha=
t
>  does not rely on the gamezone thermal mode.
>
> +The following HWMON attributes are implemented:
> + - fanX_enable: enable/disable the fan (tunable)
> + - fanX_input: current RPM
> + - fanX_target: target RPM (tunable)
> +
>  LENOVO_CAPABILITY_DATA_01
>  -------------------------
>
> @@ -70,6 +77,10 @@ WMI GUID ``B642801B-3D21-45DE-90AE-6E86F164FB21``
>  The LENOVO_FAN_TEST_DATA interface provides reference data for self-test=
 of
>  cooling fans.
>
> +The following HWMON attributes are implemented:
> + - fanX_max: maximum RPM
> + - fanX_min: minimum RPM
> +
>  WMI interface description
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/l=
enovo/Kconfig
> index fb96a0f908f03..be9af04511462 100644
> --- a/drivers/platform/x86/lenovo/Kconfig
> +++ b/drivers/platform/x86/lenovo/Kconfig
> @@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
>  config LENOVO_WMI_TUNING
>         tristate "Lenovo Other Mode WMI Driver"
>         depends on ACPI_WMI
> +       select HWMON
>         select FW_ATTR_CLASS
>         select LENOVO_WMI_DATA
>         select LENOVO_WMI_EVENTS
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x=
86/lenovo/wmi-other.c
> index 20c6ff0be37a1..e067e55e95562 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -14,7 +14,16 @@
>   * These attributes typically don't fit anywhere else in the sysfs and a=
re set
>   * in Windows using one of Lenovo's multiple user applications.
>   *
> + * Besides, this driver also exports tunable fan speed RPM to HWMON. Min=
/max RPM
> + * are also provided for reference.
> + *
Here as well.

With those being fixed.
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>

Thanks,
Derek

>   * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *   - fw_attributes
> + *   - binding to Capability Data 01
> + *
> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> + *   - HWMON
> + *   - binding to Capability Data 00 and Fan
>   */
>
>  #include <linux/acpi.h>
> @@ -25,6 +34,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/gfp_types.h>
> +#include <linux/hwmon.h>
>  #include <linux/idr.h>
>  #include <linux/kdev_t.h>
>  #include <linux/kobject.h>
> @@ -43,12 +53,21 @@
>
>  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
>
> +#define LWMI_SUPP_VALID BIT(0)
> +#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
> +#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
> +
>  #define LWMI_DEVICE_ID_CPU 0x01
>
>  #define LWMI_FEATURE_ID_CPU_SPPT 0x01
>  #define LWMI_FEATURE_ID_CPU_SPL 0x02
>  #define LWMI_FEATURE_ID_CPU_FPPT 0x03
>
> +#define LWMI_DEVICE_ID_FAN 0x04
> +
> +#define LWMI_FEATURE_ID_FAN_RPM 0x03
> +#define LWMI_FEATURE_ID_FAN_TEST 0x05
> +
>  #define LWMI_TYPE_ID_NONE 0x00
>
>  #define LWMI_FEATURE_VALUE_GET 17
> @@ -59,7 +78,24 @@
>  #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
>  #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
>
> +#define LWMI_FAN_ID_BASE 1
> +#define LWMI_FAN_NR 4
> +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
> +
> +#define LWMI_ATTR_ID_FAN_RPM(x)                                         =
       \
> +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |        \
> +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |  \
> +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
> +
> +#define LWMI_ATTR_ID_FAN_TEST                                           =
       \
> +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |         =
       \
> +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_TEST) |  =
       \
> +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_TYPE_ID_NONE))
> +
> +#define LWMI_FAN_STOP_RPM 1
> +
>  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
> +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>
>  static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>  static DEFINE_IDA(lwmi_om_ida);
> @@ -76,15 +112,391 @@ struct lwmi_om_priv {
>         struct component_master_ops *ops;
>
>         /* only valid after capdata bind */
> +       struct cd_list *cd00_list;
>         struct cd_list *cd01_list;
> +       struct cd_list *cd_fan_list;
>
> +       struct device *hwmon_dev;
>         struct device *fw_attr_dev;
>         struct kset *fw_attr_kset;
>         struct notifier_block nb;
>         struct wmi_device *wdev;
>         int ida_id;
> +
> +       struct fan_info {
> +               u32 supported;
> +               u32 last_target;
> +               long min_rpm;
> +               long max_rpm;
> +       } fan_info[LWMI_FAN_NR];
> +};
> +
> +/*
> + * Visibility of fan channels:
> + *
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + * |                     | default | +expose_all_fans | +relax_fan_const=
raint | +both      |
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + * | canonical           | RW      | RW               | RW+relaxed      =
      | RW+relaxed |
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + * | -capdata_fan        | N       | RO               | N               =
      | RW+relaxed |
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + * | -FAN_TEST.supported | N       | RW               | N               =
      | RW+relaxed |
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + * | -both               | N       | RO               | N               =
      | RW+relaxed |
> + * +---------------------+---------+------------------+-----------------=
------+------------+
> + *
> + * Note: LWMI_ATTR_ID_FAN_RPM[idx].supported is always checked before ex=
posing a channel.
> + */
> +static bool expose_all_fans;
> +module_param(expose_all_fans, bool, 0444);
> +MODULE_PARM_DESC(expose_all_fans,
> +       "This option skips some capability checks and solely relies on pe=
r-channel ones "
> +       "to expose fan attributes. Use with caution.");
> +
> +static bool relax_fan_constraint;
> +module_param(relax_fan_constraint, bool, 0444);
> +MODULE_PARM_DESC(relax_fan_constraint,
> +       "Do not enforce fan RPM constraint (min/max RPM) "
> +       "and enables fan tuning when such data is missing. "
> +       "Enabling this may results in HWMON attributes being out-of-sync.=
 Use with caution.");
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D HWMON (component: lenovo-wmi-capdata 00 & fa=
n) =3D=3D=3D=3D=3D=3D=3D=3D */
> +
> +/**
> + * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
> + * @priv: Driver private data structure
> + * @channel: Fan channel index (0-based)
> + * @val: Pointer to value (input for set, output for get)
> + * @set: True to set value, false to get value
> + *
> + * Communicates with WMI interface to either retrieve current fan RPM
> + * or set target fan RPM.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel, u=
32 *val, bool set)
> +{
> +       struct wmi_method_args_32 args;
> +       u32 method_id, retval;
> +       int err;
> +
> +       method_id =3D set ? LWMI_FEATURE_VALUE_SET : LWMI_FEATURE_VALUE_G=
ET;
> +       args.arg0 =3D LWMI_ATTR_ID_FAN_RPM(channel);
> +       args.arg1 =3D set ? *val : 0;
> +
> +       err =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, method_id,
> +                                   (unsigned char *)&args, sizeof(args),=
 &retval);
> +       if (err)
> +               return err;
> +
> +       if (!set)
> +               *val =3D retval;
> +       else if (retval !=3D 1)
> +               return -EIO;
> +
> +       return 0;
> +}
> +
> +/**
> + * lwmi_om_hwmon_is_visible() - Determine visibility of HWMON attributes
> + * @drvdata: Driver private data
> + * @type: Sensor type
> + * @attr: Attribute identifier
> + * @channel: Channel index
> + *
> + * Determines whether a HWMON attribute should be visible in sysfs
> + * based on hardware capabilities and current configuration.
> + *
> + * Return: permission mode, or 0 if invisible.
> + */
> +static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hwmon_=
sensor_types type,
> +                                       u32 attr, int channel)
> +{
> +       struct lwmi_om_priv *priv =3D (struct lwmi_om_priv *)drvdata;
> +       bool visible =3D false;
> +
> +       if (type =3D=3D hwmon_fan) {
> +               switch (attr) {
> +               case hwmon_fan_enable:
> +               case hwmon_fan_target:
> +                       if (!(priv->fan_info[channel].supported & LWMI_SU=
PP_MAY_SET))
> +                               return 0;
> +
> +                       if (relax_fan_constraint ||
> +                           (priv->fan_info[channel].min_rpm >=3D 0 &&
> +                            priv->fan_info[channel].max_rpm >=3D 0))
> +                               return 0644;
> +
> +                       /*
> +                        * Reaching here implies expose_all_fans is set.
> +                        * See lwmi_om_hwmon_add().
> +                        */
> +                       dev_warn_once(&priv->wdev->dev,
> +                                     "fan tuning disabled due to missing=
 RPM constraint\n");
> +                       return 0;
> +               case hwmon_fan_input:
> +                       visible =3D priv->fan_info[channel].supported & L=
WMI_SUPP_MAY_GET;
> +                       break;
> +               case hwmon_fan_min:
> +                       visible =3D priv->fan_info[channel].min_rpm >=3D =
0;
> +                       break;
> +               case hwmon_fan_max:
> +                       visible =3D priv->fan_info[channel].max_rpm >=3D =
0;
> +                       break;
> +               }
> +       }
> +
> +       return visible ? 0444 : 0;
> +}
> +
> +/**
> + * lwmi_om_hwmon_read() - Read HWMON sensor data
> + * @dev: Device pointer
> + * @type: Sensor type
> + * @attr: Attribute identifier
> + * @channel: Channel index
> + * @val: Pointer to store value
> + *
> + * Reads current sensor values from hardware through WMI interface.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_type=
s type,
> +                             u32 attr, int channel, long *val)
> +{
> +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> +       u32 retval =3D 0;
> +       int err;
> +
> +       if (type =3D=3D hwmon_fan) {
> +               switch (attr) {
> +               case hwmon_fan_input:
> +                       err =3D lwmi_om_fan_get_set(priv, channel, &retva=
l, false);
> +                       if (err)
> +                               return err;
> +
> +                       *val =3D retval;
> +                       return 0;
> +               case hwmon_fan_enable:
> +                       *val =3D priv->fan_info[channel].last_target !=3D=
 LWMI_FAN_STOP_RPM;
> +                       return 0;
> +               case hwmon_fan_target:
> +                       if (priv->fan_info[channel].last_target =3D=3D LW=
MI_FAN_STOP_RPM)
> +                               return -EBUSY;
> +
> +                       *val =3D priv->fan_info[channel].last_target;
> +                       return 0;
> +               case hwmon_fan_min:
> +                       *val =3D priv->fan_info[channel].min_rpm;
> +                       return 0;
> +               case hwmon_fan_max:
> +                       *val =3D priv->fan_info[channel].max_rpm;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +/**
> + * lwmi_om_hwmon_write() - Write HWMON sensor data
> + * @dev: Device pointer
> + * @type: Sensor type
> + * @attr: Attribute identifier
> + * @channel: Channel index
> + * @val: Value to write
> + *
> + * Writes configuration values to hardware through WMI interface.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_typ=
es type,
> +                              u32 attr, int channel, long val)
> +{
> +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> +       u32 raw, min_rpm, max_rpm;
> +       int err;
> +
> +       if (type =3D=3D hwmon_fan) {
> +               switch (attr) {
> +               case hwmon_fan_enable:
> +                       if (val =3D=3D 0)
> +                               raw =3D LWMI_FAN_STOP_RPM;
> +                       else if (val =3D=3D 1)
> +                               raw =3D 0; /* auto */
> +                       else
> +                               return -EINVAL;
> +
> +                       goto fan_set;
> +               case hwmon_fan_target:
> +                       if (val =3D=3D 0) {
> +                               raw =3D 0;
> +                               goto fan_set;
> +                       }
> +
> +                       min_rpm =3D relax_fan_constraint
> +                                       ? LWMI_FAN_STOP_RPM + 1
> +                                       : priv->fan_info[channel].min_rpm=
;
> +                       max_rpm =3D relax_fan_constraint
> +                                       ? U16_MAX
> +                                       : priv->fan_info[channel].max_rpm=
;
> +
> +                       if (val < min_rpm || val > max_rpm)
> +                               return -EDOM;
> +
> +                       raw =3D val;
> +fan_set:
> +                       err =3D lwmi_om_fan_get_set(priv, channel, &raw, =
true);
> +                       if (err)
> +                               return err;
> +
> +                       priv->fan_info[channel].last_target =3D raw;
> +                       return 0;
> +               }
> +       }
> +
> +       return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] =3D =
{
> +       /* Must match LWMI_FAN_NR. */
> +       HWMON_CHANNEL_INFO(fan,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T |
> +                          HWMON_F_MIN | HWMON_F_MAX,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T |
> +                          HWMON_F_MIN | HWMON_F_MAX,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T |
> +                          HWMON_F_MIN | HWMON_F_MAX,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T |
> +                          HWMON_F_MIN | HWMON_F_MAX),
> +       NULL
>  };
>
> +static const struct hwmon_ops lwmi_om_hwmon_ops =3D {
> +       .is_visible =3D lwmi_om_hwmon_is_visible,
> +       .read =3D lwmi_om_hwmon_read,
> +       .write =3D lwmi_om_hwmon_write,
> +};
> +
> +static const struct hwmon_chip_info lwmi_om_hwmon_chip_info =3D {
> +       .ops =3D &lwmi_om_hwmon_ops,
> +       .info =3D lwmi_om_hwmon_info,
> +};
> +
> +/**
> + * lwmi_om_hwmon_add() - Register HWMON device
> + * @priv: Driver private data
> + *
> + * Initializes capability data and registers the HWMON device.
> + *
> + * Return: 0 on success, or an error code.
> + */
> +static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
> +{
> +       struct capdata_fan capdata_fan;
> +       struct capdata00 capdata00;
> +       int i, err, valid;
> +
> +       if (expose_all_fans) {
> +               dev_warn(&priv->wdev->dev, "all fans exposed. Use with ca=
ution\n");
> +       } else if (!priv->cd_fan_list) {
> +               goto unsupported;
> +       } else {
> +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_=
FAN_TEST, &capdata00);
> +               if (err || !(capdata00.supported & LWMI_SUPP_VALID))
> +                       goto unsupported;
> +       }
> +
> +       if (relax_fan_constraint)
> +               dev_warn(&priv->wdev->dev, "fan RPM constraint relaxed. U=
se with caution\n");
> +
> +       valid =3D 0;
> +       for (i =3D 0; i < LWMI_FAN_NR; i++) {
> +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_=
FAN_RPM(i), &capdata00);
> +
> +               priv->fan_info[i] =3D (struct fan_info) {
> +                       .supported =3D err ? 0 : capdata00.supported,
> +                       /*
> +                        * Assume 0 on probe as the EC resets all fans to=
 auto mode on (re)boot.
> +                        *
> +                        * Note that S0ix (s2idle) preserves the RPM targ=
et, so we
> +                        * don't need suspend/resume callbacks. This beha=
vior has not
> +                        * been tested on S3-capable devices, but I doubt=
 if such devices
> +                        * even have this interface.
> +                        */
> +                       .last_target =3D 0,
> +                       .min_rpm =3D -ENODATA,
> +                       .max_rpm =3D -ENODATA,
> +               };
> +
> +               if (!(priv->fan_info[i].supported & LWMI_SUPP_VALID))
> +                       continue;
> +
> +               valid++;
> +
> +               if (!priv->cd_fan_list)
> +                       /*
> +                        * Reaching here implies expose_all_fans is set.
> +                        * fanX_{target,enable} will be gated by lwmi_om_=
hwmon_is_visible(),
> +                        * unless relax_fan_constraint is also set.
> +                        */
> +                       continue;
> +
> +               err =3D lwmi_cd_fan_get_data(priv->cd_fan_list, LWMI_FAN_=
ID(i), &capdata_fan);
> +               if (!err) {
> +                       priv->fan_info[i].min_rpm =3D capdata_fan.min_rpm=
;
> +                       priv->fan_info[i].max_rpm =3D capdata_fan.max_rpm=
;
> +                       continue;
> +               }
> +
> +               if (!expose_all_fans) {
> +                       /*
> +                        * Fan attribute from capdata00 may be dummy (i.e=
.,
> +                        * get: constant dummy RPM, set: no-op with retva=
l =3D=3D 0).
> +                        *
> +                        * If fan capdata is available and a fan is missi=
ng from it,
> +                        * make the fan invisible.
> +                        */
> +                       dev_dbg(&priv->wdev->dev, "missing RPM constraint=
 for fan%d, hiding\n",
> +                               LWMI_FAN_ID(i));
> +                       priv->fan_info[i].supported =3D 0;
> +                       valid--;
> +               }
> +       }
> +
> +       if (valid =3D=3D 0)
> +               goto unsupported;
> +
> +       priv->hwmon_dev =3D hwmon_device_register_with_info(&priv->wdev->=
dev, LWMI_OM_HWMON_NAME,
> +                                                         priv, &lwmi_om_=
hwmon_chip_info, NULL);
> +       if (IS_ERR(priv->hwmon_dev)) {
> +               err =3D PTR_ERR(priv->hwmon_dev);
> +               priv->hwmon_dev =3D NULL;
> +               return err;
> +       }
> +       return 0;
> +
> +unsupported:
> +       dev_warn(&priv->wdev->dev, "fan reporting/tuning is unsupported o=
n this device\n");
> +       return 0;
> +}
> +
> +/**
> + * lwmi_om_hwmon_remove() - Unregister HWMON device
> + * @priv: Driver private data
> + *
> + * Unregisters the HWMON device and resets all fans to automatic mode.
> + * Ensures hardware doesn't remain in manual mode after driver removal.
> + */
> +static void lwmi_om_hwmon_remove(struct lwmi_om_priv *priv)
> +{
> +       if (priv->hwmon_dev)
> +               hwmon_device_unregister(priv->hwmon_dev);
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D fw_attributes (component: lenovo-wmi-capdata=
 01) =3D=3D=3D=3D=3D=3D=3D=3D */
> +
>  struct tunable_attr_01 {
>         struct capdata01 *capdata;
>         struct device *dev;
> @@ -547,6 +959,7 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *p=
riv)
>
>  err_free_ida:
>         ida_free(&lwmi_om_ida, priv->ida_id);
> +       priv->fw_attr_dev =3D NULL;
>         return err;
>  }
>
> @@ -556,6 +969,9 @@ static int lwmi_om_fw_attr_add(struct lwmi_om_priv *p=
riv)
>   */
>  static void lwmi_om_fw_attr_remove(struct lwmi_om_priv *priv)
>  {
> +       if (!priv->fw_attr_dev)
> +               return;
> +
>         for (unsigned int i =3D 0; i < ARRAY_SIZE(cd01_attr_groups) - 1; =
i++)
>                 sysfs_remove_group(&priv->fw_attr_kset->kobj,
>                                    cd01_attr_groups[i].attr_group);
> @@ -564,15 +980,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_p=
riv *priv)
>         device_unregister(priv->fw_attr_dev);
>  }
>
> +/* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=3D=3D=
=3D=3D=3D=3D */
> +
>  /**
>   * lwmi_om_master_bind() - Bind all components of the other mode driver
>   * @dev: The lenovo-wmi-other driver basic device.
>   *
> - * Call component_bind_all to bind the lenovo-wmi-capdata01 driver to th=
e
> - * lenovo-wmi-other master driver. On success, assign the capability dat=
a 01
> - * list pointer to the driver data struct for later access. This pointer
> - * is only valid while the capdata01 interface exists. Finally, register=
 all
> - * firmware attribute groups.
> + * Call component_bind_all to bind the lenovo-wmi-capdata devices to the
> + * lenovo-wmi-other master driver. On success, assign the capability dat=
a
> + * list pointers to the driver data struct for later access. These point=
ers
> + * are only valid while the capdata interfaces exist. Finally, register =
the
> + * HWMON device and all firmware attribute groups.
>   *
>   * Return: 0 on success, or an error code.
>   */
> @@ -586,26 +1004,45 @@ static int lwmi_om_master_bind(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       priv->cd01_list =3D binder.cd01_list;
> -       if (!priv->cd01_list)
> +       if (!binder.cd00_list && !binder.cd01_list)
>                 return -ENODEV;
>
> -       return lwmi_om_fw_attr_add(priv);
> +       priv->cd00_list =3D binder.cd00_list;
> +       if (priv->cd00_list) {
> +               priv->cd_fan_list =3D binder.cd_fan_list;
> +               ret =3D lwmi_om_hwmon_add(priv);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       priv->cd01_list =3D binder.cd01_list;
> +       if (priv->cd01_list) {
> +               ret =3D lwmi_om_fw_attr_add(priv);
> +               if (ret) {
> +                       if (priv->cd00_list)
> +                               lwmi_om_hwmon_remove(priv);
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
>  }
>
>  /**
>   * lwmi_om_master_unbind() - Unbind all components of the other mode dri=
ver
>   * @dev: The lenovo-wmi-other driver basic device
>   *
> - * Unregister all capability data attribute groups. Then call
> - * component_unbind_all to unbind the lenovo-wmi-capdata01 driver from t=
he
> - * lenovo-wmi-other master driver. Finally, free the IDA for this device=
.
> + * Unregister the HWMON device and all capability data attribute groups.=
 Then
> + * call component_unbind_all to unbind the lenovo-wmi-capdata driver fro=
m the
> + * lenovo-wmi-other master driver.
>   */
>  static void lwmi_om_master_unbind(struct device *dev)
>  {
>         struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
>
> +       lwmi_om_hwmon_remove(priv);
>         lwmi_om_fw_attr_remove(priv);
> +
>         component_unbind_all(dev, NULL);
>  }
>
> @@ -624,6 +1061,9 @@ static int lwmi_other_probe(struct wmi_device *wdev,=
 const void *context)
>         if (!priv)
>                 return -ENOMEM;
>
> +       /* Sentinel for on-demand ida_free(). */
> +       priv->ida_id =3D -EIDRM;
> +
>         priv->wdev =3D wdev;
>         dev_set_drvdata(&wdev->dev, priv);
>
> @@ -654,7 +1094,9 @@ static void lwmi_other_remove(struct wmi_device *wde=
v)
>         struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
>
>         component_master_del(&wdev->dev, &lwmi_om_master_ops);
> -       ida_free(&lwmi_om_ida, priv->ida_id);
> +
> +       if (priv->ida_id >=3D 0)
> +               ida_free(&lwmi_om_ida, priv->ida_id);
>  }
>
>  static const struct wmi_device_id lwmi_other_id_table[] =3D {
> @@ -679,5 +1121,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
>  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
>  MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>  MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
>  MODULE_LICENSE("GPL");
> --
> 2.51.0
>

