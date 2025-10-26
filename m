Return-Path: <linux-kernel+bounces-870539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C0220C0B169
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 20:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2EF44E5518
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 19:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE41270EAB;
	Sun, 26 Oct 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="fn9tinKz"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D71E1E00;
	Sun, 26 Oct 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761508076; cv=pass; b=jjbHY2fbSe5SQU/8yHhoHw3n2wdDR7NVtRW5HvekbX0MyTi/WrHjCqYkdWN0egO3rzZogZ/7oCqpvVpwF5dxKmPAmKiLmQ9BLrN3L5H9BMZmb4AEXK46QTF2bgVKLyGpXol9B88nwx4p+rT+3BHIW2Z13oYRCLQvV1/leZQF4C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761508076; c=relaxed/simple;
	bh=+RNCyXa5w52X8C1BWZy7t/36pktAzlYxyCCeQSo9o7g=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=IISiLWnXluOBL7bRC661XRNI9oAEU3ZNYUKPee1FSCjVvwqoaNnO/Pjwg264c4yNa7xZ5tKyuM+kEBJr/XYkpPmUnYABVY5GYFK5yDU5BgTM35Z/EuqzyUb1DULLQNnoDpzKjY2ZDgPd+dt3+2Uize5bbV9XcjBPBG7OmpPtPPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=fn9tinKz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761508049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hwps+Xaqiy/QZ3SQku9ZGY/3Xf0gtkBQCkIHTFufNpB67I5Uzk/oyU4yWIEmBAYsHRZvULYLmkmhDQ0fQcmonmgjMxlBS4uKG3a4F/YF5Z9fMUGfSdP2GDrjTQdoxm+6xgWSgZzYM5uzGYK/ccLFFnIVuXbNyQodeMG9hSSfELo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761508049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=HApt658oQSNyaovbOlP+uq9k8sXD7EqjmkusPmFYdGY=; 
	b=gxDd4NclScBl6DCvy3ptmyrHAh6gLdwtMEuBZaeuEny0FIMbu88LEd/m8/wTrPHs9nn4Sf/Xi7q9xi/fS6PcDF4jZNyxWM28W7uC+0IdZy0wM4r9t2OuQZw7c8UMlp/v/Tq3CouVsRxqxBb9Wqe8N+2Kc1qiUKs0Ps2tsP/qBT8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761508049;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=HApt658oQSNyaovbOlP+uq9k8sXD7EqjmkusPmFYdGY=;
	b=fn9tinKzIrRcIZcqSGl1036XQETjGIQ5YsWm9VSWGgZ1GKtRwZaQjPha1bbtqBEe
	DVdWI2pUQ9SW5UShToNuFSO0ZC7vANMrffSWL8FHzX/uCnCjGkOr40A+UbVty2jhuzI
	G6Djrlg1VMww17PCF7mbnD2Gpp8iRKdwS8YPPNFo=
Received: by mx.zohomail.com with SMTPS id 1761508048425502.2006898630765;
	Sun, 26 Oct 2025 12:47:28 -0700 (PDT)
Message-ID: <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
Subject: Re: [PATCH 4/6] platform/x86: lenovo-wmi-other: Add HWMON for fan
 speed RPM
From: Rong Zhang <i@rong.moe>
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf <W_Armin@gmx.de>, 
 Hans de Goede <hansg@kernel.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,  Guenter Roeck <linux@roeck-us.net>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
In-Reply-To: <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com>
References: <20251019210450.88830-1-i@rong.moe>
	 <20251019210450.88830-5-i@rong.moe>
	 <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 03:42:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Derek,

On Sat, 2025-10-25 at 22:23 -0700, Derek John Clark wrote:
> On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote:
> >=20
> > Register an HWMON device for fan spped RPM according to Capability Data
> > 00 provided by lenovo-wmi-capdata. The corresponding HWMON nodes are:
> >=20
> >  - fanX_enable: enable/disable the fan (tunable)
> >  - fanX_input: current RPM
> >  - fanX_target: target RPM (tunable)
> >=20
> > Signed-off-by: Rong Zhang <i@rong.moe>
> > ---
> >  .../wmi/devices/lenovo-wmi-other.rst          |   5 +
> >  drivers/platform/x86/lenovo/Kconfig           |   1 +
> >  drivers/platform/x86/lenovo/wmi-other.c       | 324 +++++++++++++++++-
> >  3 files changed, 317 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Documenta=
tion/wmi/devices/lenovo-wmi-other.rst
> > index adbd7943c6756..cb6a9bfe5a79e 100644
> > --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> > +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> > @@ -31,6 +31,11 @@ under the following path:
> >=20
> >    /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<attribut=
e>/
> >=20
> > +Besides, this driver also exports fan speed RPM to HWMON:
> > + - fanX_enable: enable/disable the fan (tunable)
> > + - fanX_input: current RPM
> > + - fanX_target: target RPM (tunable)
> > +
> >  LENOVO_CAPABILITY_DATA_00
> >  -------------------------
> >=20
> > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86=
/lenovo/Kconfig
> > index fb96a0f908f03..be9af04511462 100644
> > --- a/drivers/platform/x86/lenovo/Kconfig
> > +++ b/drivers/platform/x86/lenovo/Kconfig
> > @@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
> >  config LENOVO_WMI_TUNING
> >         tristate "Lenovo Other Mode WMI Driver"
> >         depends on ACPI_WMI
> > +       select HWMON
> >         select FW_ATTR_CLASS
> >         select LENOVO_WMI_DATA
> >         select LENOVO_WMI_EVENTS
> > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform=
/x86/lenovo/wmi-other.c
> > index 20c6ff0be37a1..f8771ed3c6642 100644
> > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > @@ -14,7 +14,15 @@
> >   * These attributes typically don't fit anywhere else in the sysfs and=
 are set
> >   * in Windows using one of Lenovo's multiple user applications.
> >   *
> > + * Besides, this driver also exports tunable fan speed RPM to HWMON.
> > + *
> >   * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> > + *   - fw_attributes
> > + *   - binding to Capability Data 01
> > + *
> > + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> > + *   - HWMON
> > + *   - binding to Capability Data 00
> >   */
> >=20
> >  #include <linux/acpi.h>
> > @@ -25,6 +33,7 @@
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/gfp_types.h>
> > +#include <linux/hwmon.h>
> >  #include <linux/idr.h>
> >  #include <linux/kdev_t.h>
> >  #include <linux/kobject.h>
> > @@ -43,12 +52,20 @@
> >=20
> >  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
> >=20
> > +#define LWMI_SUPP_VALID BIT(0)
> > +#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
> > +#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
> > +
> >  #define LWMI_DEVICE_ID_CPU 0x01
> >=20
> >  #define LWMI_FEATURE_ID_CPU_SPPT 0x01
> >  #define LWMI_FEATURE_ID_CPU_SPL 0x02
> >  #define LWMI_FEATURE_ID_CPU_FPPT 0x03
> >=20
> > +#define LWMI_DEVICE_ID_FAN 0x04
> > +
> > +#define LWMI_FEATURE_ID_FAN_RPM 0x03
> > +
> >  #define LWMI_TYPE_ID_NONE 0x00
> >=20
> >  #define LWMI_FEATURE_VALUE_GET 17
> > @@ -59,7 +76,18 @@
> >  #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
> >  #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
> >=20
> > +/* Only fan1 and fan2 are present on supported devices. */
> > +#define LWMI_FAN_ID_BASE 1
> > +#define LWMI_FAN_NR 2
> > +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
> > +
> > +#define LWMI_ATTR_ID_FAN_RPM(x)                                       =
         \
> > +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |       =
 \
> > +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM) | =
 \
> > +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
> > +
> >  #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
> > +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
> >=20
> >  static BLOCKING_NOTIFIER_HEAD(om_chain_head);
> >  static DEFINE_IDA(lwmi_om_ida);
> > @@ -76,15 +104,256 @@ struct lwmi_om_priv {
> >         struct component_master_ops *ops;
> >=20
> >         /* only valid after capdata bind */
> > +       struct cd_list *cd00_list;
> >         struct cd_list *cd01_list;
> >=20
> > +       struct device *hwmon_dev;
> >         struct device *fw_attr_dev;
> >         struct kset *fw_attr_kset;
> >         struct notifier_block nb;
> >         struct wmi_device *wdev;
> >         int ida_id;
> > +
> > +       struct fan_info {
> > +               u32 supported;
> > +               long target;
> > +       } fan_info[LWMI_FAN_NR];
> >  };
> >=20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D HWMON (component: lenovo-wmi-capdata 00) =
=3D=3D=3D=3D=3D=3D=3D=3D */
> > +
> > +/**
> > + * lwmi_om_fan_get_set() - Get or set fan RPM value of specified fan
> > + * @priv: Driver private data structure
> > + * @channel: Fan channel index (0-based)
> > + * @val: Pointer to value (input for set, output for get)
> > + * @set: True to set value, false to get value
> > + *
> > + * Communicates with WMI interface to either retrieve current fan RPM
> > + * or set target fan speed.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +static int lwmi_om_fan_get_set(struct lwmi_om_priv *priv, int channel,=
 u32 *val, bool set)
> > +{
> > +       struct wmi_method_args_32 args;
> > +       u32 method_id, retval;
> > +       int err;
> > +
> > +       method_id =3D set ? LWMI_FEATURE_VALUE_SET : LWMI_FEATURE_VALUE=
_GET;
> > +       args.arg0 =3D LWMI_ATTR_ID_FAN_RPM(channel);
> > +       args.arg1 =3D set ? *val : 0;
> > +
> > +       err =3D lwmi_dev_evaluate_int(priv->wdev, 0x0, method_id,
> > +                                   (unsigned char *)&args, sizeof(args=
), &retval);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!set)
> > +               *val =3D retval;
> > +       else if (retval !=3D 1)
> > +               return -EIO;
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * lwmi_om_hwmon_is_visible() - Determine visibility of HWMON attribut=
es
> > + * @drvdata: Driver private data
> > + * @type: Sensor type
> > + * @attr: Attribute identifier
> > + * @channel: Channel index
> > + *
> > + * Determines whether a HWMON attribute should be visible in sysfs
> > + * based on hardware capabilities and current configuration.
> > + *
> > + * Return: permission mode, or 0 if invisible.
> > + */
> > +static umode_t lwmi_om_hwmon_is_visible(const void *drvdata, enum hwmo=
n_sensor_types type,
> > +                                       u32 attr, int channel)
> > +{
> > +       struct lwmi_om_priv *priv =3D (struct lwmi_om_priv *)drvdata;
> > +       bool r =3D false, w =3D false;
> > +
> > +       if (type =3D=3D hwmon_fan) {
> > +               switch (attr) {
> > +               case hwmon_fan_enable:
> > +               case hwmon_fan_target:
> > +                       r =3D w =3D priv->fan_info[channel].supported &=
 LWMI_SUPP_MAY_SET;
> > +                       break;
> > +               case hwmon_fan_input:
> > +                       r =3D priv->fan_info[channel].supported & LWMI_=
SUPP_MAY_GET;
> > +                       break;
> > +               }
> > +       }
> > +
>=20
> There is another method in capdata00 that could be useful here
>=20
> Fan Test For Diagnostic Software
> uint32 IDs //0x04050000
> uint32 Capability //9:by project
> bit 3: 0: not support LENOVO_FAN_TEST_DATA, 1 support LENOVO_FAN_TEST_DAT=
A
> bit 2: 0: not support SetFeatureValue(), 1: support SetFeatureValue()
> bit 1: 0: not support GetFeatureValue(), 1: support GetFeatureValue()
> bit 0: 0: not support fan test for diagnostic software, 1: support an
> test for diagnostic software

The information is useful, thanks for that!

A quick look at the decompiled ASL code of my device's ACPI tables:

   Package (0x03)
   {
       0x04050000,
       0x07,
       One
   },

I've confirmed that the corresponding ACPI method didn't modify the
return value of 0x04050000.

0x07 means my device supports this interface, GetFeatureValue() and
SetFeatureValue(); but does not support LENOVO_FAN_TEST_DATA. Is BIT(3)
only defined in some models (but not on my device)? The data returned
by LENOVO_FAN_TEST_DATA seems correct and is probably the min/max auto
points.

My device didn't implement {Get,Set}FeatureValue(0x04050000). What will
it do when it's implemented?

> I'll discuss below, but it seems like knowing min/max is a good idea
> before making the sysfs visible.
>=20
> > +       if (!r)
> > +               return 0;
> > +
> > +       return w ? 0644 : 0444;
> > +}
> > +
> > +/**
> > + * lwmi_om_hwmon_read() - Read HWMON sensor data
> > + * @dev: Device pointer
> > + * @type: Sensor type
> > + * @attr: Attribute identifier
> > + * @channel: Channel index
> > + * @val: Pointer to store value
> > + *
> > + * Reads current sensor values from hardware through WMI interface.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +static int lwmi_om_hwmon_read(struct device *dev, enum hwmon_sensor_ty=
pes type,
> > +                             u32 attr, int channel, long *val)
> > +{
> > +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> > +       u32 retval =3D 0;
> > +       int err;
> > +
> > +       if (type =3D=3D hwmon_fan) {
> > +               switch (attr) {
> > +               case hwmon_fan_input:
> > +                       err =3D lwmi_om_fan_get_set(priv, channel, &ret=
val, false);
> > +                       if (err)
> > +                               return err;
> > +
> > +                       *val =3D retval;
> > +                       return 0;
> > +               case hwmon_fan_enable:
> > +               case hwmon_fan_target:
> > +                       /* -ENODATA before first set. */
>=20
> Why not query the interface in realtime to know the system state? That
> would avoid this problem.

My implementation follows the approach of corsair-cpro
(drivers/hwmon/corsair-cpro.c). hwmon_fan_target is about "how much RPM
*should* the fan reach?", while hwmon_fan_input is about "how much RPM
does the fan *really* reach?"

Calling SetFeatureValue(0x040300*) sets the former, while calling
GetFeatureValue(0x040300*) queries the latter. IIUC, using
GetFeatureValue(0x040300*) for hwmon_fan_target violates the
definition, especially when the fan is in auto mode.

> > +                       err =3D (int)priv->fan_info[channel].target;
> > +                       if (err < 0)
> > +                               return err;
> > +
> > +                       if (attr =3D=3D hwmon_fan_enable)
> > +                               *val =3D priv->fan_info[channel].target=
 !=3D 1;
> > +                       else
> > +                               *val =3D priv->fan_info[channel].target=
;
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +/**
> > + * lwmi_om_hwmon_write() - Write HWMON sensor data
> > + * @dev: Device pointer
> > + * @type: Sensor type
> > + * @attr: Attribute identifier
> > + * @channel: Channel index
> > + * @val: Value to write
> > + *
> > + * Writes configuration values to hardware through WMI interface.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +static int lwmi_om_hwmon_write(struct device *dev, enum hwmon_sensor_t=
ypes type,
> > +                              u32 attr, int channel, long val)
> > +{
> > +       struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> > +       u32 raw;
> > +       int err;
> > +
> > +       if (type =3D=3D hwmon_fan) {
> > +               switch (attr) {
> > +               case hwmon_fan_enable:
> > +               case hwmon_fan_target:
> > +                       if (attr =3D=3D hwmon_fan_enable) {
> > +                               if (val =3D=3D 0)
> > +                                       raw =3D 1; /* stop */
> > +                               else if (val =3D=3D 1)
> > +                                       raw =3D 0; /* auto */
> > +                               else
> > +                                       return -EINVAL;
> > +                       } else {
> > +                               /*
> > +                                * val > U16_MAX seems safe but meaning=
less.
> > +                                */
> > +                               if (val < 0 || val > U16_MAX)
>=20
> I think it might be prudent to only permit these settings if fan speed
> params can't be known. Pragmatically it ensures userspace is aware of
> the range of the interface. Per the documentation it should be "safe"
> as is, but setting below the min fan speed will return it to "auto"
> mode and the hwmon will be out of sync. Anything above should just be
> set to the max, if the BIOS is working properly.

On my device, the data returned by LENOVO_FAN_TEST_DATA seems to be the
min/max auto points. The fan can spin much slower/faster than the
min/max RPM. Setting below the "real" min RPM stops the fan - setting 0
is the only way to return it to auto mode.

   # grep . fan1_*
   grep: fan1_enable: No data available
   fan1_input:2200
   fan1_max:5000
   fan1_min:2200
   grep: fan1_target: No data available
   # echo 800 >fan1_target
   # cat fan1_input
   800
   # echo 700 >fan1_target
   # cat fan1_input
   700
   # echo 10000 >fan1_target
   # cat fan1_input
   6500
   # echo 100 >fan1_target
   # cat fan1_input
   0
   # taskset -c 2 stress-ng -c 1 >/dev/null &
   [1] 37967
   # cat fan1_input
   0
   # echo 0 >fan1_target
   # cat fan1_input
   2200
   # cat fan1_input
   2600

> IMO the fan speed data is essential to ensuring the hwmon interface is
> usable and synced. I'd move that patch before this one in the series
> and make the 0x04050000 method reporting IsSupported required for any
> of the attributes to be visible, with value checks against the min/max
> when setting a given fan.

I agree that setting the RPM too low/high may results in HWMON being
out of sync, which is usually not desired. Will=C2=A0do these in v2.

My extra idea:
- drop the parameter "ignore_fan_cap".
- new parameter "expose_all_fans": does not hide fans when missing from
  LENOVO_FAN_TEST_DATA or when 0x04050000 reports unsupported.
  0x040300* is always checked to hide missing fans.
- new parameter "enforce_fan_rpm_range": defaults to true, checks
  against the min/max RPM from LENOVO_FAN_TEST_DATA while setting
  target RPM. dev_warn_once() when it exceeds min/max RPM.

> > +                                       return -EINVAL;
> > +                               raw =3D val;
> > +                       }
> > +
> > +                       err =3D lwmi_om_fan_get_set(priv, channel, &raw=
, true);
> > +                       if (err)
> > +                               return err;
> > +
> > +                       priv->fan_info[channel].target =3D raw;
> > +                       return 0;
> > +               }
> > +       }
> > +
> > +       return -EOPNOTSUPP;
> > +}
> > +
> > +static const struct hwmon_channel_info * const lwmi_om_hwmon_info[] =
=3D {
> > +       /* Must match LWMI_FAN_NR. */
> > +       HWMON_CHANNEL_INFO(fan,
> > +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TAR=
GET,
> > +                          HWMON_F_ENABLE | HWMON_F_INPUT | HWMON_F_TAR=
GET),
> > +       NULL
> > +};
> > +
> > +static const struct hwmon_ops lwmi_om_hwmon_ops =3D {
> > +       .is_visible =3D lwmi_om_hwmon_is_visible,
> > +       .read =3D lwmi_om_hwmon_read,
> > +       .write =3D lwmi_om_hwmon_write,
> > +};
> > +
> > +static const struct hwmon_chip_info lwmi_om_hwmon_chip_info =3D {
> > +       .ops =3D &lwmi_om_hwmon_ops,
> > +       .info =3D lwmi_om_hwmon_info,
> > +};
> > +
> > +/**
> > + * lwmi_om_hwmon_add() - Register HWMON device
> > + * @priv: Driver private data
> > + *
> > + * Initializes capability data and registers the HWMON device.
> > + *
> > + * Return: 0 on success, or an error code.
> > + */
> > +static int lwmi_om_hwmon_add(struct lwmi_om_priv *priv)
> > +{
> > +       struct capdata00 capdata00;
> > +       int i, err;
> > +
> > +       for (i =3D 0; i < LWMI_FAN_NR; i++) {
>=20
> There is an assumption here that isn't accurate. Each fan ID
> corresponds to a specific fan functionality. 01 is CPU Fan, 02 is GPU
> Fan, 02 is GPU Power Fan, and 04 is System Fan. Not every fan needs to
> exist, so an ID table might look like this (example from docs):
>=20
> illustrate=EF=BC=9A
> UINT32 NumOfFans =3D 3;
> NoteBook:
> 1: CPU Fan ID
> 2: GPU Fan ID
> 3: GPU Power Fan ID
> 4: System Fan ID
> UINT32 FanId [1,2,4]
> UINT32 FanMaxSpeed[5400, 5400, 9000];
> UINT32 FanMinSpeed[1900, 1900, 2000];

Thanks for the information. My device only defines 0x0403000{1,2} in
LENOVO_CAPABILITY_DATA_00, so I assumed LWMI_FAN_NR =3D=3D 2.

> In such a case, "count" would be 3, but the idx should be 4 going to
> the hardware because the GPU Power Fan isn't present, while the case
> fan is.

LWMI_FAN_NR has nothing to do with the actual "count". It is about "how
many HWMON fan channels are defined?" It exists because HWMON channels
are defined statically - we hide defined channels when they are missing
from LENOVO_CAPABILITY_DATA_00 (and LENOVO_FAN_TEST_DATA, if
available).

The implementation of lenovo-wmi-other doesn't use NumOfFans either -
it queries LENOVO_FAN_TEST_DATA using fan ID directly. NumOfFans is
only used when lenovo-wmi-capdata retrieves the data.

This implementation has another advantage: the X in fanX_* is always
the same as the fan ID in
LENOVO_CAPABILITY_DATA_00/LENOVO_FAN_TEST_DATA even in your example
where fan 3 is missing - fan3_* is invisible, fan{1,2,4}_* are exposed.

Given the information, I will define 4 fan channels in v2.

> Thanks,
> Derek

Thanks,
Rong

> > +               err =3D lwmi_cd00_get_data(priv->cd00_list, LWMI_ATTR_I=
D_FAN_RPM(i),
> > +                                        &capdata00);
> > +               if (err)
> > +                       continue;
> > +
> > +               priv->fan_info[i] =3D (struct fan_info) {
> > +                       .supported =3D capdata00.supported,
> > +                       .target =3D -ENODATA,
> > +               };
> > +       }
> > +
> > +       priv->hwmon_dev =3D hwmon_device_register_with_info(&priv->wdev=
->dev, LWMI_OM_HWMON_NAME,
> > +                                                         priv, &lwmi_o=
m_hwmon_chip_info, NULL);
> > +
> > +       return PTR_ERR_OR_ZERO(priv->hwmon_dev);
> > +}
> > +
> > +/**
> > + * lwmi_om_hwmon_remove() - Unregister HWMON device
> > + * @priv: Driver private data
> > + *
> > + * Unregisters the HWMON device and resets all fans to automatic mode.
> > + * Ensures hardware doesn't remain in manual mode after driver removal=
.
> > + */
> > +static void lwmi_om_hwmon_remove(struct lwmi_om_priv *priv)
> > +{
> > +       hwmon_device_unregister(priv->hwmon_dev);
> > +}
> > +
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D fw_attributes (component: lenovo-wmi-capda=
ta 01) =3D=3D=3D=3D=3D=3D=3D=3D */
> > +
> >  struct tunable_attr_01 {
> >         struct capdata01 *capdata;
> >         struct device *dev;
> > @@ -564,15 +833,17 @@ static void lwmi_om_fw_attr_remove(struct lwmi_om=
_priv *priv)
> >         device_unregister(priv->fw_attr_dev);
> >  }
> >=20
> > +/* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=3D=
=3D=3D=3D=3D=3D */
> > +
> >  /**
> >   * lwmi_om_master_bind() - Bind all components of the other mode drive=
r
> >   * @dev: The lenovo-wmi-other driver basic device.
> >   *
> > - * Call component_bind_all to bind the lenovo-wmi-capdata01 driver to =
the
> > - * lenovo-wmi-other master driver. On success, assign the capability d=
ata 01
> > - * list pointer to the driver data struct for later access. This point=
er
> > - * is only valid while the capdata01 interface exists. Finally, regist=
er all
> > - * firmware attribute groups.
> > + * Call component_bind_all to bind the lenovo-wmi-capdata devices to t=
he
> > + * lenovo-wmi-other master driver. On success, assign the capability d=
ata
> > + * list pointers to the driver data struct for later access. These poi=
nters
> > + * are only valid while the capdata interfaces exist. Finally, registe=
r the
> > + * HWMON device and all firmware attribute groups.
> >   *
> >   * Return: 0 on success, or an error code.
> >   */
> > @@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device *dev=
)
> >         if (ret)
> >                 return ret;
> >=20
> > -       priv->cd01_list =3D binder.cd01_list;
> > -       if (!priv->cd01_list)
> > +       if (!binder.cd00_list && !binder.cd01_list)
> >                 return -ENODEV;
> >=20
> > -       return lwmi_om_fw_attr_add(priv);
> > +       priv->cd00_list =3D binder.cd00_list;
> > +       if (priv->cd00_list) {
> > +               ret =3D lwmi_om_hwmon_add(priv);
> > +               if (ret)
> > +                       return ret;
> > +       }
> > +
> > +       priv->cd01_list =3D binder.cd01_list;
> > +       if (priv->cd01_list) {
> > +               ret =3D lwmi_om_fw_attr_add(priv);
> > +               if (ret) {
> > +                       if (priv->cd00_list)
> > +                               lwmi_om_hwmon_remove(priv);
> > +                       return ret;
> > +               }
> > +       }
> > +
> > +       return 0;
> >  }
> >=20
> >  /**
> >   * lwmi_om_master_unbind() - Unbind all components of the other mode d=
river
> >   * @dev: The lenovo-wmi-other driver basic device
> >   *
> > - * Unregister all capability data attribute groups. Then call
> > - * component_unbind_all to unbind the lenovo-wmi-capdata01 driver from=
 the
> > - * lenovo-wmi-other master driver. Finally, free the IDA for this devi=
ce.
> > + * Unregister the HWMON device and all capability data attribute group=
s. Then
> > + * call component_unbind_all to unbind the lenovo-wmi-capdata driver f=
rom the
> > + * lenovo-wmi-other master driver.
> >   */
> >  static void lwmi_om_master_unbind(struct device *dev)
> >  {
> >         struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> >=20
> > -       lwmi_om_fw_attr_remove(priv);
> > +       if (priv->cd00_list)
> > +               lwmi_om_hwmon_remove(priv);
> > +
> > +       if (priv->cd01_list)
> > +               lwmi_om_fw_attr_remove(priv);
> > +
> >         component_unbind_all(dev, NULL);
> >  }
> >=20
> > @@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *wdev=
, const void *context)
> >         if (!priv)
> >                 return -ENOMEM;
> >=20
> > +       /* Sentinel for on-demand ida_free(). */
> > +       priv->ida_id =3D -EIDRM;
> > +
> >         priv->wdev =3D wdev;
> >         dev_set_drvdata(&wdev->dev, priv);
> >=20
> > @@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device *wd=
ev)
> >         struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
> >=20
> >         component_master_del(&wdev->dev, &lwmi_om_master_ops);
> > -       ida_free(&lwmi_om_ida, priv->ida_id);
> > +
> > +       if (priv->ida_id >=3D 0)
> > +               ida_free(&lwmi_om_ida, priv->ida_id);
> >  }
> >=20
> >  static const struct wmi_device_id lwmi_other_id_table[] =3D {
> > @@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
> >  MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> >  MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
> >  MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
> >  MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
> >  MODULE_LICENSE("GPL");
> > --
> > 2.51.0
> >=20

