Return-Path: <linux-kernel+bounces-870208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE06C0A305
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 06:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17B0B3AEC57
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 05:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1797F26ED37;
	Sun, 26 Oct 2025 05:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RipUPe0v"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56538129E6E
	for <linux-kernel@vger.kernel.org>; Sun, 26 Oct 2025 05:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761456228; cv=none; b=UoLBh4SIS0Ca/7phdWJJRS0tn8K0F9VLSue65SZ2O6j+V86BuTm31Lp/2mSch+qv/6CPtI17cCGc3/TTlalTG/2nK/X+ThwhHbKI3cnD8aFu0/jX7MJnXfnEsy4Hu4YYaFZ7ePs2V++vFLSIM/gock5iapHp3WxSnZSBPM6W2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761456228; c=relaxed/simple;
	bh=H178qUZInsBtrkESOvF/abD3qPY+rqQRpkwhIu6spXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uB2JC+rK4tZhPcC9finORBqg60KyD3+syFdBRExC0SHF9zu2OsGdrSAT8Iqce/5qJiG/btb+nHUrWHUvPjTOn40L0qB/OhMrtMj/J7KVy2Y9u3z6nLm1RztnAmq2WohXo/rhOUqneK3ibxoYlaihSMPZAcu82fCjjmOt2Rjjfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RipUPe0v; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-7f7835f4478so25279856d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 22:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761456224; x=1762061024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t9GfWzEvIoEXEGcuVkIOvEZrNaz4FPnRT0XdP41wHOQ=;
        b=RipUPe0vL/33GAco7+oX23F+bMlp6rk0t2xhngndbQjE2CpyaKU9RRjmKt9juypTaD
         5MuNmzebjenguAnX8Y9pBy5l8U+6ew+MJzPNotzksoqwOpp5ABbxtLcbpGd2iAQibsk2
         FSw9IjsPdhWBlokn3QnDGMkppnTvxLXd+pEBRIQT9p5AcXHX/WGOeUPP3kp1StAlC5YB
         fc21rwe8Jlbw6Tf+OWMveP14WG3amxkBNas0sqfrOcWBYc2DMTbJzGX+wdkA7J3M8s3l
         twHb/khZcSAC42iy6yyXebZ903rRrpLhx8KCf0nZDa/WUMkQL5g/o63tblJIb/cEsskS
         TbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761456224; x=1762061024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9GfWzEvIoEXEGcuVkIOvEZrNaz4FPnRT0XdP41wHOQ=;
        b=RiYUYbW2jnPe7BpuKPRaiSHxyOk58oeQFegy1c+ZX39kq27wJm9pzVd1Co77M6CINr
         nE6rEjYbrjOzIkbtehZjXqEDPdkWBsENydg2tMSdFx/on4A2GDqCFhdKgrMV4jcuRZGP
         4DYNDOzgM+1GOa2Tecz8hpbFC78sAo6U1sW+OeTmLK3JcebdV32GFziVOCJAVQoClPXy
         q4MYKLdi5u40h75KvyU0m+piCYIbvcXtc++A5VwzHWOuASqjGEPV0ldBEikR6tKjMSR7
         k/K+Q/doqV53FQSIe4BcggOQk8+RYVjnZNtHWYTMIFv1q/TrokThzwBUZrs7TlHsg0fA
         eapQ==
X-Forwarded-Encrypted: i=1; AJvYcCWbv0sQ3WZDy0nbUJKhSQLfFFjRzi5DCQtOTit2CYRe0ADDVi1PxmlZaSYLqRseJGksuiQjBm13HdH1QnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMZKi0T7KxQJxnjq77aeMRTflj20tla2bjI7hLk5ATeZhHq2Hu
	YVBu97ra6VsrkQeESOeDkrwOmf6a01SoP+TxMRjGrgMCJrX23hjgAlzFsGyifnS52yw+sGJVdGO
	LPGIwzN1ZbY2TdxnwnubDi/NLfX97M+0=
X-Gm-Gg: ASbGnctnCx6jr7qZzYGGh+Eh281ZfLJAjydcf5YRhnZbjutS/qRioTBXVmhPs6iha/M
	nJRwErWk7FP0wWfMkq9Db0W0iQ6lor7boCtNhSWXdnrWRsHVptqoIPFdk4zqOBezawVNd23QCOM
	Im6DUcXE22CMKpOLYXIwT+O+kmdIOuY6acZlJ0EQqDgVXj6RaxepzBMwlpXWQcH8d1tbl86mMLD
	FTeq1YL4BBEla2xtXZ+cZVSKBq4KVz527Y1YjRSyz1JZmhlHc4YzPMLMcGwpI0J6FdLsKIW
X-Google-Smtp-Source: AGHT+IHPEQm0rq05tRTMwvDASFAt6Df1XGp1UMoWKroqr69TxFb+UJjaUsJ4HmtXCInY2o1bHmF2fMBe41YxKCetKEo=
X-Received: by 2002:a05:6214:508f:b0:87c:27c2:2c0b with SMTP id
 6a1803df08f44-87c27c22f02mr304117946d6.51.1761456223942; Sat, 25 Oct 2025
 22:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019210450.88830-1-i@rong.moe> <20251019210450.88830-5-i@rong.moe>
In-Reply-To: <20251019210450.88830-5-i@rong.moe>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Sat, 25 Oct 2025 22:23:33 -0700
X-Gm-Features: AWmQ_bni8T3SLKMFs4TG_MDXsSNQnnVbOiitLMEAw9ozcubE_AaHFULus3iQiQw
Message-ID: <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com>
Subject: Re: [PATCH 4/6] platform/x86: lenovo-wmi-other: Add HWMON for fan
 speed RPM
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Guenter Roeck <linux@roeck-us.net>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
>
> Register an HWMON device for fan spped RPM according to Capability Data
> 00 provided by lenovo-wmi-capdata. The corresponding HWMON nodes are:
>
>  - fanX_enable: enable/disable the fan (tunable)
>  - fanX_input: current RPM
>  - fanX_target: target RPM (tunable)
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  .../wmi/devices/lenovo-wmi-other.rst          |   5 +
>  drivers/platform/x86/lenovo/Kconfig           |   1 +
>  drivers/platform/x86/lenovo/wmi-other.c       | 324 +++++++++++++++++-
>  3 files changed, 317 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documentati=
on/wmi/devices/lenovo-wmi-other.rst
> index adbd7943c6756..cb6a9bfe5a79e 100644
> --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> @@ -31,6 +31,11 @@ under the following path:
>
>    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribute>=
/
>
> +Besides, this driver also exports fan speed RPM to HWMON:
> + - fanX_enable: enable/disable the fan (tunable)
> + - fanX_input: current RPM
> + - fanX_target: target RPM (tunable)
> +
>  LENOVO_CAPABILITY_DATA_00
>  -------------------------
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
> index 20c6ff0be37a1..f8771ed3c6642 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -14,7 +14,15 @@
>   * These attributes typically don't fit anywhere else in the sysfs and a=
re set
>   * in Windows using one of Lenovo's multiple user applications.
>   *
> + * Besides, this driver also exports tunable fan speed RPM to HWMON.
> + *
>   * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> + *   - fw_attributes
> + *   - binding to Capability Data 01
> + *
> + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> + *   - HWMON
> + *   - binding to Capability Data 00
>   */
>
>  #include <linux/acpi.h>
> @@ -25,6 +33,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/gfp_types.h>
> +#include <linux/hwmon.h>
>  #include <linux/idr.h>
>  #include <linux/kdev_t.h>
>  #include <linux/kobject.h>
> @@ -43,12 +52,20 @@
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
> +
>  #define LWMI_TYPE_ID_NONE 0x00
>
>  #define LWMI_FEATURE_VALUE_GET 17
> @@ -59,7 +76,18 @@
>  #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
>  #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
>
> +/* Only fan1 and fan2 are present on supported devices. */
> +#define LWMI_FAN_ID_BASE 1
> +#define LWMI_FAN_NR 2
> +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
> +
> +#define LWMI_ATTR_ID_FAN_RPM(x)                                         =
       \
> +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |        \
> +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) |  \
> +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
> +
>  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
> +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
>
>  static BLOCKING_NOTIFIER_HEAD(om_chain_head);
>  static DEFINE_IDA(lwmi_om_ida);
> @@ -76,15 +104,256 @@ struct lwmi_om_priv {
>         struct component_master_ops *ops;
>
>         /* only valid after capdata bind */
> +       struct cd_list *cd00_list;
>         struct cd_list *cd01_list;
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
> +               long target;
> +       } fan_info[LWMI_FAN_NR];
>  };
>
> +/* =3D=3D=3D=3D=3D=3D=3D=3D HWMON (component: lenovo-wmi-capdata 00) =3D=
=3D=3D=3D=3D=3D=3D=3D */
> +
> +/**
> + * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
> + * @priv: Driver private data structure
> + * @channel: Fan channel index (0-based)
> + * @val: Pointer to value (input for set, output for get)
> + * @set: True to set value, false to get value
> + *
> + * Communicates with WMI interface to either retrieve current fan RPM
> + * or set target fan speed.
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
> +       bool r =3D false, w =3D false;
> +
> +       if (type =3D=3D hwmon_fan) {
> +               switch (attr) {
> +               case hwmon_fan_enable:
> +               case hwmon_fan_target:
> +                       r =3D w =3D priv->fan_info[channel].supported & L=
WMI_SUPP_MAY_SET;
> +                       break;
> +               case hwmon_fan_input:
> +                       r =3D priv->fan_info[channel].supported & LWMI_SU=
PP_MAY_GET;
> +                       break;
> +               }
> +       }
> +

There is another method in capdata00 that could be useful here

Fan Test For Diagnostic Software
uint32 IDs //0x04050000
uint32 Capability //9:by project
bit 3: 0: not support LENOVO_FAN_TEST_DATA, 1 support LENOVO_FAN_TEST_DATA
bit 2: 0: not support SetFeatureValue(), 1: support SetFeatureValue()
bit 1: 0: not support GetFeatureValue(), 1: support GetFeatureValue()
bit 0: 0: not support fan test for diagnostic software, 1: support an
test for diagnostic software

I'll discuss below, but it seems like knowing min/max is a good idea
before making the sysfs visible.

> +       if (!r)
> +               return 0;
> +
> +       return w ? 0644 : 0444;
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
> +               case hwmon_fan_target:
> +                       /* -ENODATA before first set. */

Why not query the interface in realtime to know the system state? That
would avoid this problem.

> +                       err =3D (int)priv->fan_info[channel].target;
> +                       if (err < 0)
> +                               return err;
> +
> +                       if (attr =3D=3D hwmon_fan_enable)
> +                               *val =3D priv->fan_info[channel].target !=
=3D 1;
> +                       else
> +                               *val =3D priv->fan_info[channel].target;
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
> +       u32 raw;
> +       int err;
> +
> +       if (type =3D=3D hwmon_fan) {
> +               switch (attr) {
> +               case hwmon_fan_enable:
> +               case hwmon_fan_target:
> +                       if (attr =3D=3D hwmon_fan_enable) {
> +                               if (val =3D=3D 0)
> +                                       raw =3D 1; /* stop */
> +                               else if (val =3D=3D 1)
> +                                       raw =3D 0; /* auto */
> +                               else
> +                                       return -EINVAL;
> +                       } else {
> +                               /*
> +                                * val > U16_MAX seems safe but meaningle=
ss.
> +                                */
> +                               if (val < 0 || val > U16_MAX)

I think it might be prudent to only permit these settings if fan speed
params can't be known. Pragmatically it ensures userspace is aware of
the range of the interface. Per the documentation it should be "safe"
as is, but setting below the min fan speed will return it to "auto"
mode and the hwmon will be out of sync. Anything above should just be
set to the max, if the BIOS is working properly.

IMO the fan speed data is essential to ensuring the hwmon interface is
usable and synced. I'd move that patch before this one in the series
and make the 0x04050000 method reporting IsSupported required for any
of the attributes to be visible, with value checks against the min/max
when setting a given fan.


> +                                       return -EINVAL;
> +                               raw =3D val;
> +                       }
> +
> +                       err =3D lwmi_om_fan_get_set(priv, channel, &raw, =
true);
> +                       if (err)
> +                               return err;
> +
> +                       priv->fan_info[channel].target =3D raw;
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
T,
> +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TARGE=
T),
> +       NULL
> +};
> +
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
> +       struct capdata00 capdata00;
> +       int i, err;
> +
> +       for (i =3D 0; i < LWMI_FAN_NR; i++) {

There is an assumption here that isn't accurate. Each fan ID
corresponds to a specific fan functionality. 01 is CPU Fan, 02 is GPU
Fan, 02 is GPU Power Fan, and 04 is System Fan. Not every fan needs to
exist, so an ID table might look like this (example from docs):

illustrate=EF=BC=9A
UINT32 NumOfFans =3D 3;
NoteBook:
1: CPU Fan ID
2: GPU Fan ID
3: GPU Power Fan ID
4: System Fan ID
UINT32 FanId [1,2,4]
UINT32 FanMaxSpeed[5400, 5400, 9000];
UINT32 FanMinSpeed[1900, 1900, 2000];

In such a case, "count" would be 3, but the idx should be 4 going to
the hardware because the GPU Power Fan isn't present, while the case
fan is.

Thanks,
Derek
> +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_ID_=
FAN_RPM(i),
> +                                        &capdata00);
> +               if (err)
> +                       continue;
> +
> +               priv->fan_info[i] =3D (struct fan_info) {
> +                       .supported =3D capdata00.supported,
> +                       .target =3D -ENODATA,
> +               };
> +       }
> +
> +       priv->hwmon_dev =3D hwmon_device_register_with_info(&priv->wdev->=
dev, LWMI_OM_HWMON_NAME,
> +                                                         priv, &lwmi_om_=
hwmon_chip_info, NULL);
> +
> +       return PTR_ERR_OR_ZERO(priv->hwmon_dev);
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
> +       hwmon_device_unregister(priv->hwmon_dev);
> +}
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D fw_attributes (component: lenovo-wmi-capdata=
 01) =3D=3D=3D=3D=3D=3D=3D=3D */
> +
>  struct tunable_attr_01 {
>         struct capdata01 *capdata;
>         struct device *dev;
> @@ -564,15 +833,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om_p=
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
> @@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device *dev)
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
> -       lwmi_om_fw_attr_remove(priv);
> +       if (priv->cd00_list)
> +               lwmi_om_hwmon_remove(priv);
> +
> +       if (priv->cd01_list)
> +               lwmi_om_fw_attr_remove(priv);
> +
>         component_unbind_all(dev, NULL);
>  }
>
> @@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *wdev, =
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
> @@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device *wdev=
)
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
> @@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
>  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
>  MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
>  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
>  MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
>  MODULE_LICENSE("GPL");
> --
> 2.51.0
>

