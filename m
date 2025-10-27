Return-Path: <linux-kernel+bounces-871509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF83C0D873
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575813B5B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5D12FF654;
	Mon, 27 Oct 2025 12:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="1iio2noM"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757422F7AD6;
	Mon, 27 Oct 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567670; cv=pass; b=JRgqaRlT/atFg+dfRJHx4mxqyob1hvgf3GIKaxeug3F5wrhQQMT1PMIFeQQH2Fjh5bIrigKyqtHoAFFp8DKMZ7YkjGPxB71/s38uUTMYYkKgDh4TwpvTglZsgxZPmM/qLoZ4gvCIZbV2ikBx/opGmIT2lG9LN8mtCXyEPInLsAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567670; c=relaxed/simple;
	bh=Y+MZoVQoSqS21ns+PYlKNC61d0JgCzp03I2C/hypWYw=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=BicOksTjIAj3oAwz1lOv4PbFVQ1zMnakthlEAMGWTQvtjOWeT+MZcTJ8r5D6Yhd9EKJBbk0LrIcsOfKawPeOnV1Tm4nB4orUoHQqNGQGC8gMbLs/4NurfAMh5DY5lIRdLLdGvc185iXM9Wy9XxIVVbAtsoCzHvQgIZ0A3vKFWRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=1iio2noM; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1761567643; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Py1Rg2Y6J6S32Z+NU1zlg4klEdnJ3tPn+189cwx9Li2UCFgDuHLJCopWLHcHS5/V/4zj5C+WnptXAn6h6TUcnkcM0tks1EIorgGgAQzUgA0FXNErkcMZhxmWeN2DmIMdmySslCV2PgmOstSOsdy8AZiBYBvx89hpuSfEWz0/TzA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761567643; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=YhK48QOvklg+RldbADZzuKm3SyNGbpH/4giGH5fB+iQ=; 
	b=M9mWW1Ui30AJBhtQsxb8Duq8eu3XCU59yF5ohVZtFH3Lo8z4KfOkr1+DKVmjxA2zKe2xhJax1hhBTw0hju6PG7is7EVMTbpXClRRpkmPgaSM/MS/CMeBeAIJwBTPNGKzoEofSkfzsQYtJmQl4zgzeq7hRrrPzWkbSZQ1fvifngI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761567643;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=YhK48QOvklg+RldbADZzuKm3SyNGbpH/4giGH5fB+iQ=;
	b=1iio2noM539eaE1LgcEgnfMss8Imv1t1nNZHMx9BGr0rH5B3EaK/SEYAo22YnCHU
	FROTXsXuA0eP6q+Xi5YUqQxSJtdxhO1k84hoZeAiucK9x0WkHayFMWZfW/aitvWWZJh
	BgSlJNT3pR4qtz75K7J38gt1lc4Wreha2UcBt8gE=
Received: by mx.zohomail.com with SMTPS id 1761567640879236.50051229609403;
	Mon, 27 Oct 2025 05:20:40 -0700 (PDT)
Message-ID: <d925730a3c11c9b1b6a76c9be9f61287c64fa329.camel@rong.moe>
Subject: Re: [PATCH 4/6] platform/x86: lenovo-wmi-other: Add HWMON for fan
 speed RPM
From: Rong Zhang <i@rong.moe>
To: Armin Wolf <W_Armin@gmx.de>, Derek John Clark
 <derekjohn.clark@gmail.com>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Hans de Goede
 <hansg@kernel.org>,  Ilpo =?ISO-8859-1?Q?J=E4rvinen?=	
 <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hwmon@vger.kernel.org
In-Reply-To: <4ed5435a-a35f-4794-8d05-2cc0e34538d7@gmx.de>
References: <20251019210450.88830-1-i@rong.moe>
		 <20251019210450.88830-5-i@rong.moe>
		 <CAFqHKTkOZUfDb8cGbGnVPCS9wNbOBsiyOk_MkZR-2_Za6ZPMng@mail.gmail.com>
		 <d498a1ca58eac5689dae68fffc29440ba75a5faf.camel@rong.moe>
		 <4ed5435a-a35f-4794-8d05-2cc0e34538d7@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Oct 2025 20:15:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-5 
X-ZohoMailClient: External

Hi Armin and Derek,

On Mon, 2025-10-27 at 00:04 +0100, Armin Wolf wrote:
> Am 26.10.25 um 20:42 schrieb Rong Zhang:
>=20
> > Hi Derek,
> >=20
> > On Sat, 2025-10-25 at 22:23 -0700, Derek John Clark wrote:
> > > On Sun, Oct 19, 2025 at 2:05=E2=80=AFPM Rong Zhang <i@rong.moe> wrote=
:
> > > > Register an HWMON device for fan spped RPM according to Capability =
Data
> > > > 00 provided by lenovo-wmi-capdata. The corresponding HWMON nodes ar=
e:
> > > >=20
> > > >   - fanX_enable: enable/disable the fan (tunable)
> > > >   - fanX_input: current RPM
> > > >   - fanX_target: target RPM (tunable)
> > > >=20
> > > > Signed-off-by: Rong Zhang <i@rong.moe>
> > > > ---
> > > >   .../wmi/devices/lenovo-wmi-other.rst          |   5 +
> > > >   drivers/platform/x86/lenovo/Kconfig           |   1 +
> > > >   drivers/platform/x86/lenovo/wmi-other.c       | 324 +++++++++++++=
++++-
> > > >   3 files changed, 317 insertions(+), 13 deletions(-)
> > > >=20
> > > > diff --git a/Documentation/wmi/devices/lenovo-wmi-other.rst b/Docum=
entation/wmi/devices/lenovo-wmi-other.rst
> > > > index adbd7943c6756..cb6a9bfe5a79e 100644
> > > > --- a/Documentation/wmi/devices/lenovo-wmi-other.rst
> > > > +++ b/Documentation/wmi/devices/lenovo-wmi-other.rst
> > > > @@ -31,6 +31,11 @@ under the following path:
> > > >=20
> > > >     /sys/class/firmware-attributes/lenovo-wmi-other/attributes/<att=
ribute>/
> > > >=20
> > > > +Besides, this driver also exports fan speed RPM to HWMON:
> > > > + - fanX_enable: enable/disable the fan (tunable)
> > > > + - fanX_input: current RPM
> > > > + - fanX_target: target RPM (tunable)
> > > > +
> > > >   LENOVO_CAPABILITY_DATA_00
> > > >   -------------------------
> > > >=20
> > > > diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform=
/x86/lenovo/Kconfig
> > > > index fb96a0f908f03..be9af04511462 100644
> > > > --- a/drivers/platform/x86/lenovo/Kconfig
> > > > +++ b/drivers/platform/x86/lenovo/Kconfig
> > > > @@ -263,6 +263,7 @@ config LENOVO_WMI_GAMEZONE
> > > >   config LENOVO_WMI_TUNING
> > > >          tristate "Lenovo Other Mode WMI Driver"
> > > >          depends on ACPI_WMI
> > > > +       select HWMON
> > > >          select FW_ATTR_CLASS
> > > >          select LENOVO_WMI_DATA
> > > >          select LENOVO_WMI_EVENTS
> > > > diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/plat=
form/x86/lenovo/wmi-other.c
> > > > index 20c6ff0be37a1..f8771ed3c6642 100644
> > > > --- a/drivers/platform/x86/lenovo/wmi-other.c
> > > > +++ b/drivers/platform/x86/lenovo/wmi-other.c
> > > > @@ -14,7 +14,15 @@
> > > >    * These attributes typically don't fit anywhere else in the sysf=
s and are set
> > > >    * in Windows using one of Lenovo's multiple user applications.
> > > >    *
> > > > + * Besides, this driver also exports tunable fan speed RPM to HWMO=
N.
> > > > + *
> > > >    * Copyright (C) 2025 Derek J. Clark <derekjohn.clark@gmail.com>
> > > > + *   - fw_attributes
> > > > + *   - binding to Capability Data 01
> > > > + *
> > > > + * Copyright (C) 2025 Rong Zhang <i@rong.moe>
> > > > + *   - HWMON
> > > > + *   - binding to Capability Data 00
> > > >    */
> > > >=20
> > > >   #include <linux/acpi.h>
> > > > @@ -25,6 +33,7 @@
> > > >   #include <linux/device.h>
> > > >   #include <linux/export.h>
> > > >   #include <linux/gfp_types.h>
> > > > +#include <linux/hwmon.h>
> > > >   #include <linux/idr.h>
> > > >   #include <linux/kdev_t.h>
> > > >   #include <linux/kobject.h>
> > > > @@ -43,12 +52,20 @@
> > > >=20
> > > >   #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089C=
D3B"
> > > >=20
> > > > +#define LWMI_SUPP_VALID BIT(0)
> > > > +#define LWMI_SUPP_MAY_GET (LWMI_SUPP_VALID | BIT(1))
> > > > +#define LWMI_SUPP_MAY_SET (LWMI_SUPP_VALID | BIT(2))
> > > > +
> > > >   #define LWMI_DEVICE_ID_CPU 0x01
> > > >=20
> > > >   #define LWMI_FEATURE_ID_CPU_SPPT 0x01
> > > >   #define LWMI_FEATURE_ID_CPU_SPL 0x02
> > > >   #define LWMI_FEATURE_ID_CPU_FPPT 0x03
> > > >=20
> > > > +#define LWMI_DEVICE_ID_FAN 0x04
> > > > +
> > > > +#define LWMI_FEATURE_ID_FAN_RPM 0x03
> > > > +
> > > >   #define LWMI_TYPE_ID_NONE 0x00
> > > >=20
> > > >   #define LWMI_FEATURE_VALUE_GET 17
> > > > @@ -59,7 +76,18 @@
> > > >   #define LWMI_ATTR_MODE_ID_MASK GENMASK(15, 8)
> > > >   #define LWMI_ATTR_TYPE_ID_MASK GENMASK(7, 0)
> > > >=20
> > > > +/* Only fan1 and fan2 are present on supported devices. */
> > > > +#define LWMI_FAN_ID_BASE 1
> > > > +#define LWMI_FAN_NR 2
> > > > +#define LWMI_FAN_ID(x) ((x) + LWMI_FAN_ID_BASE)
> > > > +
> > > > +#define LWMI_ATTR_ID_FAN_RPM(x)                                   =
             \
> > > > +       (FIELD_PREP(LWMI_ATTR_DEV_ID_MASK, LWMI_DEVICE_ID_FAN) |   =
     \
> > > > +        FIELD_PREP(LWMI_ATTR_FEAT_ID_MASK, LWMI_FEATURE_ID_FAN_RPM=
) |  \
> > > > +        FIELD_PREP(LWMI_ATTR_TYPE_ID_MASK, LWMI_FAN_ID(x)))
> > > > +
> > > >   #define LWMI_OM_FW_ATTR_BASE_PATH "lenovo-wmi-other"
> > > > +#define LWMI_OM_HWMON_NAME "lenovo_wmi_other"
> > > >=20
> > > >   static BLOCKING_NOTIFIER_HEAD(om_chain_head);
> > > >   static DEFINE_IDA(lwmi_om_ida);
> > > > @@ -76,15 +104,256 @@ struct lwmi_om_priv {
> > > >          struct component_master_ops *ops;
> > > >=20
> > > >          /* only valid after capdata bind */
> > > > +       struct cd_list *cd00_list;
> > > >          struct cd_list *cd01_list;
> > > >=20
> > > > +       struct device *hwmon_dev;
> > > >          struct device *fw_attr_dev;
> > > >          struct kset *fw_attr_kset;
> > > >          struct notifier_block nb;
> > > >          struct wmi_device *wdev;
> > > >          int ida_id;
> > > > +
> > > > +       struct fan_info {
> > > > +               u32 supported;
> > > > +               long target;
> > > > +       } fan_info[LWMI_FAN_NR];
> > > >   };

[...snip...]

> > > There is another method in capdata00 that could be useful here
> > >=20
> > > Fan Test For Diagnostic Software
> > > uint32 IDs //0x04050000
> > > uint32 Capability //9:by project
> > > bit 3: 0: not support LENOVO_FAN_TEST_DATA, 1 support LENOVO_FAN_TEST=
_DATA
> > > bit 2: 0: not support SetFeatureValue(), 1: support SetFeatureValue()
> > > bit 1: 0: not support GetFeatureValue(), 1: support GetFeatureValue()
> > > bit 0: 0: not support fan test for diagnostic software, 1: support an
> > > test for diagnostic software
> > The information is useful, thanks for that!
> >=20
> > A quick look at the decompiled ASL code of my device's ACPI tables:
> >=20
> >     Package (0x03)
> >     {
> >         0x04050000,
> >         0x07,
> >         One
> >     },
> >=20
> > I've confirmed that the corresponding ACPI method didn't modify the
> > return value of 0x04050000.
> >=20
> > 0x07 means my device supports this interface, GetFeatureValue() and
> > SetFeatureValue(); but does not support LENOVO_FAN_TEST_DATA. Is BIT(3)
> > only defined in some models (but not on my device)? The data returned
> > by LENOVO_FAN_TEST_DATA seems correct and is probably the min/max auto
> > points.
>=20
> Can you please use this information instead of wmi_has_guid() when matchi=
ng the
> components? I would prefer if we can phase out wmi_has_guid() eventually.

Doing so leads to a chicken-or-the-egg paradox as long as we use the
component helper:

- Calling lwmi_cd00_get_data() from wmi-other requires wmi-capdata
being bound to get a reference to cd00_list. Binding wmi-capdata again
to get a reference to cd_fan_list implies that the HWMON device can
only be registered in the driver probe callback instead of the master
bind callback, but the unbind callback still needs to check and
unregister it, which is really ugly.

- Calling lwmi_cd00_get_data() from wmi-capdata requires variables in
the module-level global scope to store references to cd_list. Doing so
completely makes the component helper meaningless for our use case.
Meanwhile, if we did't use the component helper at all, we would need
neither this information nor wmi_has_guid().

This information itself may also be inconsistent, e.g., it says my
device does not support LENOVO_FAN_TEST_DATA, but the GUID actually
exists and its data makes sense.

Moreover, capdata00 and capdata01 are irrelevant to each other. My
implementation is capable to work properly on devices with only one of
them (I am not sure if such devices exist, though). This again requires
wmi_has_guid() as it's the only way to determine their existence.

Do you think it's a good idea to drop the component approach? If so, I
will implement this in v2 (or v3, if I finish and send out v2 soon).

Thanks,
Rong

> Thanks,
> Armin Wolf
>=20
> >=20
> > My device didn't implement {Get,Set}FeatureValue(0x04050000). What will
> > it do when it's implemented?

[...snip...]

> > > >=20
> > > > +/* =3D=3D=3D=3D=3D=3D=3D=3D Self (master: lenovo-wmi-other) =3D=3D=
=3D=3D=3D=3D=3D=3D */
> > > > +
> > > >   /**
> > > >    * lwmi_om_master_bind() - Bind all components of the other mode =
driver
> > > >    * @dev: The lenovo-wmi-other driver basic device.
> > > >    *
> > > > - * Call component_bind_all to bind the lenovo-wmi-capdata01 driver=
 to the
> > > > - * lenovo-wmi-other master driver. On success, assign the capabili=
ty data 01
> > > > - * list pointer to the driver data struct for later access. This p=
ointer
> > > > - * is only valid while the capdata01 interface exists. Finally, re=
gister all
> > > > - * firmware attribute groups.
> > > > + * Call component_bind_all to bind the lenovo-wmi-capdata devices =
to the
> > > > + * lenovo-wmi-other master driver. On success, assign the capabili=
ty data
> > > > + * list pointers to the driver data struct for later access. These=
 pointers
> > > > + * are only valid while the capdata interfaces exist. Finally, reg=
ister the
> > > > + * HWMON device and all firmware attribute groups.
> > > >    *
> > > >    * Return: 0 on success, or an error code.
> > > >    */
> > > > @@ -586,26 +857,47 @@ static int lwmi_om_master_bind(struct device =
*dev)
> > > >          if (ret)
> > > >                  return ret;
> > > >=20
> > > > -       priv->cd01_list =3D binder.cd01_list;
> > > > -       if (!priv->cd01_list)
> > > > +       if (!binder.cd00_list && !binder.cd01_list)
> > > >                  return -ENODEV;
> > > >=20
> > > > -       return lwmi_om_fw_attr_add(priv);
> > > > +       priv->cd00_list =3D binder.cd00_list;
> > > > +       if (priv->cd00_list) {
> > > > +               ret =3D lwmi_om_hwmon_add(priv);
> > > > +               if (ret)
> > > > +                       return ret;
> > > > +       }
> > > > +
> > > > +       priv->cd01_list =3D binder.cd01_list;
> > > > +       if (priv->cd01_list) {
> > > > +               ret =3D lwmi_om_fw_attr_add(priv);
> > > > +               if (ret) {
> > > > +                       if (priv->cd00_list)
> > > > +                               lwmi_om_hwmon_remove(priv);
> > > > +                       return ret;
> > > > +               }
> > > > +       }
> > > > +
> > > > +       return 0;
> > > >   }
> > > >=20
> > > >   /**
> > > >    * lwmi_om_master_unbind() - Unbind all components of the other m=
ode driver
> > > >    * @dev: The lenovo-wmi-other driver basic device
> > > >    *
> > > > - * Unregister all capability data attribute groups. Then call
> > > > - * component_unbind_all to unbind the lenovo-wmi-capdata01 driver =
from the
> > > > - * lenovo-wmi-other master driver. Finally, free the IDA for this =
device.
> > > > + * Unregister the HWMON device and all capability data attribute g=
roups. Then
> > > > + * call component_unbind_all to unbind the lenovo-wmi-capdata driv=
er from the
> > > > + * lenovo-wmi-other master driver.
> > > >    */
> > > >   static void lwmi_om_master_unbind(struct device *dev)
> > > >   {
> > > >          struct lwmi_om_priv *priv =3D dev_get_drvdata(dev);
> > > >=20
> > > > -       lwmi_om_fw_attr_remove(priv);
> > > > +       if (priv->cd00_list)
> > > > +               lwmi_om_hwmon_remove(priv);
> > > > +
> > > > +       if (priv->cd01_list)
> > > > +               lwmi_om_fw_attr_remove(priv);
> > > > +
> > > >          component_unbind_all(dev, NULL);
> > > >   }
> > > >=20
> > > > @@ -624,6 +916,9 @@ static int lwmi_other_probe(struct wmi_device *=
wdev, const void *context)
> > > >          if (!priv)
> > > >                  return -ENOMEM;
> > > >=20
> > > > +       /* Sentinel for on-demand ida_free(). */
> > > > +       priv->ida_id =3D -EIDRM;
> > > > +
> > > >          priv->wdev =3D wdev;
> > > >          dev_set_drvdata(&wdev->dev, priv);
> > > >=20
> > > > @@ -654,7 +949,9 @@ static void lwmi_other_remove(struct wmi_device=
 *wdev)
> > > >          struct lwmi_om_priv *priv =3D dev_get_drvdata(&wdev->dev);
> > > >=20
> > > >          component_master_del(&wdev->dev, &lwmi_om_master_ops);
> > > > -       ida_free(&lwmi_om_ida, priv->ida_id);
> > > > +
> > > > +       if (priv->ida_id >=3D 0)
> > > > +               ida_free(&lwmi_om_ida, priv->ida_id);
> > > >   }
> > > >=20
> > > >   static const struct wmi_device_id lwmi_other_id_table[] =3D {
> > > > @@ -679,5 +976,6 @@ MODULE_IMPORT_NS("LENOVO_WMI_CD");
> > > >   MODULE_IMPORT_NS("LENOVO_WMI_HELPERS");
> > > >   MODULE_DEVICE_TABLE(wmi, lwmi_other_id_table);
> > > >   MODULE_AUTHOR("Derek J. Clark <derekjohn.clark@gmail.com>");
> > > > +MODULE_AUTHOR("Rong Zhang <i@rong.moe>");
> > > >   MODULE_DESCRIPTION("Lenovo Other Mode WMI Driver");
> > > >   MODULE_LICENSE("GPL");
> > > > --
> > > > 2.51.0
> > > >=20

