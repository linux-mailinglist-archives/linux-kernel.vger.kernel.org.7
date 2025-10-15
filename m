Return-Path: <linux-kernel+bounces-854620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 95416BDEDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E046735761F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B01523AE87;
	Wed, 15 Oct 2025 13:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QPT2zZct"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F723770A;
	Wed, 15 Oct 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536599; cv=none; b=Iwufo+U3S62TyAPK6A+kCckbGP9OxmG09+YDJN6Qx13s4lWZzS7q4B5VDGCi3xjxQLwvkMoFPId24XHWYh2JhL3hNVYqxIXL2jkI/efE3iIZP/RdWwwxsOt6QJjtZ3/4cwsrwzhWWvTxHfD3VD1oD5jDpfD7f8XgzKCJ1LI3JXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536599; c=relaxed/simple;
	bh=aEgiaj/4yyxj6bxLFg+XhhYsJ4NQSZoEcVUYM7Xl0lA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qACJoWNkwS9WgDqxZYZJCTD9/ZfCo3Lxnp8G/020whmiLLECSySS/OGQOPeX5vbKwo7NEAN57jn7vaaYw7BwQaerrs7ZivSFCxOGFWZBpXmwS3+GsJT1X4B6CvdGRHSpWKScDQ1Tcva6qzLOaL7m113Xhpq3agFB4+81t5CG1+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QPT2zZct; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760536597; x=1792072597;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=aEgiaj/4yyxj6bxLFg+XhhYsJ4NQSZoEcVUYM7Xl0lA=;
  b=QPT2zZctt1s0cF4y8pNE+4FUrUFvVi7iElyZSfnG6gfbT5Q6xPktUkkT
   UdxymMS7kgL99ZIPiH7uSQBtoLD99yjKA5ldWODePXLDzcTYbZ5Outckv
   HII1SvhtzaoB/pm3OUme0M+uZtBuq7CkpWwPEa0+IFj33vPpVD8MqHUBO
   QUH7TwMF7hHUMRNbF8C4W1GKQRwg9/PPEuKaF2vhOSbE5wVjeDs3viChQ
   NMBfIYdHJvbIX6AMyGsuXXK+iy1L1oK65/zA/BvwvgYFKVbQwp5e5Znz6
   vt8+C3ak5Ej2BdO+POBDwURT8lavimrlQZKrxL7N6SMmGXqM+bbFkDpXZ
   g==;
X-CSE-ConnectionGUID: GLFnOJDPREut2miQPc6yiw==
X-CSE-MsgGUID: vIfp1pVvRayndMcPGpp25A==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="80148610"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="80148610"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:56:36 -0700
X-CSE-ConnectionGUID: 7f4hflSqQV+C2TliJYG2zQ==
X-CSE-MsgGUID: itbN9hDLR2yqW7oNgW3EiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; 
   d="scan'208";a="181852710"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 06:56:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 16:56:27 +0300 (EEST)
To: Denis Benato <benato.denis96@gmail.com>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
Subject: Re: [PATCH v14 2/9] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
In-Reply-To: <20251015014736.1402045-3-benato.denis96@gmail.com>
Message-ID: <eb8f01d9-9250-4916-3e65-40aef04cff6b@linux.intel.com>
References: <20251015014736.1402045-1-benato.denis96@gmail.com> <20251015014736.1402045-3-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-497199432-1760534907=:957"
Content-ID: <fed57e4b-3586-f920-15fb-faa74b43bd89@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-497199432-1760534907=:957
Content-Type: text/plain; CHARSET=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <a9fd3899-4937-0420-0c4d-eef080a3da7e@linux.intel.com>

On Wed, 15 Oct 2025, Denis Benato wrote:

> From: "Luke D. Jones" <luke@ljones.dev>
>=20
> The fw_attributes_class provides a much cleaner interface to all of the
> attributes introduced to asus-wmi. This patch moves all of these extra
> attributes over to fw_attributes_class, and shifts the bulk of these
> definitions to a new kernel module to reduce the clutter of asus-wmi
> with the intention of deprecating the asus-wmi attributes in future.
>=20
> The work applies only to WMI methods which don't have a clearly defined
> place within the sysfs and as a result ended up lumped together in
> /sys/devices/platform/asus-nb-wmi/ with no standard API.
>=20
> Where possible the fw attrs now implement defaults, min, max, scalar,
> choices, etc. As en example dgpu_disable becomes:
>=20
> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
> =86=80=80 current_value
> =86=80=80 display_name
> =86=80=80 possible_values
> =84=80=80 type
>=20
> as do other attributes.
>=20
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/hid/hid-asus.c                        |   1 +
>  drivers/platform/x86/Kconfig                  |  12 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/asus-armoury.c           | 545 ++++++++++++++++++
>  drivers/platform/x86/asus-armoury.h           | 164 ++++++
>  drivers/platform/x86/asus-wmi.c               |   5 +-
>  .../platform_data/x86/asus-wmi-leds-ids.h     |  50 ++
>  include/linux/platform_data/x86/asus-wmi.h    |  43 +-
>  8 files changed, 777 insertions(+), 44 deletions(-)
>  create mode 100644 drivers/platform/x86/asus-armoury.c
>  create mode 100644 drivers/platform/x86/asus-armoury.h
>  create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h
>=20
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index a444d41e53b6..472bca54642b 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -27,6 +27,7 @@
>  #include <linux/hid.h>
>  #include <linux/module.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/platform_data/x86/asus-wmi-leds-ids.h>
>  #include <linux/input/mt.h>
>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf ch=
eck */
>  #include <linux/power_supply.h>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..8b827680754c 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -262,6 +262,18 @@ config ASUS_WIRELESS
>  =09  If you choose to compile this driver as a module the module will be
>  =09  called asus-wireless.
> =20
> +config ASUS_ARMOURY
> +=09tristate "ASUS Armoury driver"
> +=09depends on ASUS_WMI
> +=09select FW_ATTR_CLASS
> +=09help
> +=09  Say Y here if you have a WMI aware Asus machine and would like to u=
se the
> +=09  firmware_attributes API to control various settings typically expos=
ed in
> +=09  the ASUS Armoury Crate application available on Windows.
> +
> +=09  To compile this driver as a module, choose M here: the module will
> +=09  be called asus-armoury.
> +
>  config ASUS_WMI
>  =09tristate "ASUS WMI Driver"
>  =09depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index c7db2a88c11a..4b1220f9b194 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -33,6 +33,7 @@ obj-$(CONFIG_APPLE_GMUX)=09+=3D apple-gmux.o
>  # ASUS
>  obj-$(CONFIG_ASUS_LAPTOP)=09+=3D asus-laptop.o
>  obj-$(CONFIG_ASUS_WIRELESS)=09+=3D asus-wireless.o
> +obj-$(CONFIG_ASUS_ARMOURY)=09+=3D asus-armoury.o
>  obj-$(CONFIG_ASUS_WMI)=09=09+=3D asus-wmi.o
>  obj-$(CONFIG_ASUS_NB_WMI)=09+=3D asus-nb-wmi.o
>  obj-$(CONFIG_ASUS_TF103C_DOCK)=09+=3D asus-tf103c-dock.o
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/a=
sus-armoury.c
> new file mode 100644
> index 000000000000..57ed9449ec5f
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -0,0 +1,545 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Asus Armoury (WMI) attributes driver.
> + *
> + * This driver uses the fw_attributes class to expose various WMI functi=
ons
> + * that are present in many gaming and some non-gaming ASUS laptops.
> + *
> + * These typically don't fit anywhere else in the sysfs such as under LE=
D class,
> + * hwmon or others, and are set in Windows using the ASUS Armoury Crate =
tool.
> + *
> + * Copyright(C) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/kmod.h>
> +#include <linux/kobject.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +
> +#include "asus-armoury.h"
> +#include "firmware_attributes_class.h"
> +
> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +#define ASUS_MINI_LED_MODE_MASK   0x03

GENMASK() + add its include. Consider if _MASK is necessary as it doesn't=
=20
provide much value and results in just longer lines.

BTW, before I go further, with my reviews there's no need to "ack" each=20
and every feedback item you're going to apply to your patches, I trust you=
=20
make those changes you don't contest. That way we can both save some time=
=20
by focusing on parts that need further discussion. :-)

> +/* Standard modes for devices with only on/off */
> +#define ASUS_MINI_LED_OFF         0x00
> +#define ASUS_MINI_LED_ON          0x01
> +/* Like "on" but the effect is more vibrant or brighter */
> +#define ASUS_MINI_LED_STRONG_MODE 0x02
> +/* New modes for devices with 3 mini-led mode types */
> +#define ASUS_MINI_LED_2024_WEAK   0x00
> +#define ASUS_MINI_LED_2024_STRONG 0x01
> +#define ASUS_MINI_LED_2024_OFF    0x02
> +
> +static struct asus_armoury_priv {
> +=09struct device *fw_attr_dev;
> +=09struct kset *fw_attr_kset;
> +
> +=09u32 mini_led_dev_id;
> +=09u32 gpu_mux_dev_id;
> +} asus_armoury;

I suggest put this to own line:

static struct asus_armoury_priv asus_armoury;

=2E..as the current arrangement awkwardly separates things far away (e.g.=
=20
the "static").

> +struct fw_attrs_group {
> +=09bool pending_reboot;
> +};
> +
> +static struct fw_attrs_group fw_attrs =3D {
> +=09.pending_reboot =3D false,
> +};
> +
> +struct asus_attr_group {
> +=09const struct attribute_group *attr_group;
> +=09u32 wmi_devid;
> +};
> +
> +static bool asus_wmi_is_present(u32 dev_id)
> +{
> +=09u32 retval;
> +=09int status;
> +
> +=09status =3D asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0=
, &retval);
> +=09pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, re=
tval);
> +
> +=09return status =3D=3D 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
> +}
> +
> +static void asus_set_reboot_and_signal_event(void)
> +{
> +=09fw_attrs.pending_reboot =3D true;
> +=09kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
> +}
> +
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_att=
ribute *attr, char *buf)
> +{
> +=09return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);

Add include.

> +}
> +
> +static struct kobj_attribute pending_reboot =3D __ATTR_RO(pending_reboot=
);
> +
> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
> +{
> +=09return !strcmp(attr->attr.name, "gpu_mux_mode");
> +}
> +
> +static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 val=
ue, u32 wmi_dev)
> +{
> +=09u32 result;
> +=09int err;
> +
> +=09err =3D asus_wmi_set_devstate(wmi_dev, value, &result);
> +=09if (err) {
> +=09=09pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +=09=09return err;
> +=09}
> +=09/*
> +=09 * !1 is usually considered a fail by ASUS, but some WMI methods do u=
se > 1
> +=09 * to return a status code or similar.
> +=09 */
> +=09if (result < 1) {

=3D=3D 0 ?

> +=09=09pr_err("Failed to set %s: (result): 0x%x\n", attr->attr.name, resu=
lt);
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +}
> +
> +/**
> + * attr_uint_store() - Send an uint to wmi method, checks if within min/=
max exclusive.
> + * @kobj: Pointer to the driver object.
> + * @attr: Pointer to the attribute calling this function.
> + * @buf: The buffer to read from, this is parsed to `uint` type.
> + * @count: Required by sysfs attribute macros, pass in from the callee a=
ttr.
> + * @min: Minimum accepted value. Below this returns -EINVAL.
> + * @max: Maximum accepted value. Above this returns -EINVAL.
> + * @store_value: Pointer to where the parsed value should be stored.
> + * @wmi_dev: The WMI function ID to use.
> + *
> + * This function is intended to be generic so it can be called from any =
"_store"
> + * attribute which works only with integers. The integer to be sent to t=
he WMI method
> + * is range checked and an error returned if out of range.
> + *
> + * If the value is valid and WMI is success, then the sysfs attribute is=
 notified
> + * and if asus_bios_requires_reboot() is true then reboot attribute is a=
lso notified.

In general, please fold comment text to 80 characters as it's easier to=20
read shorter lines of text (long lines do require eye movement).

Also note this 80 character limits is only meant for comments, in code=20
exceeding 80 is fine where it makes sense.

> + *
> + * Returns: Either count, or an error.
> + */
> +static ssize_t attr_uint_store(struct kobject *kobj, struct kobj_attribu=
te *attr, const char *buf,
> +=09=09=09      size_t count, u32 min, u32 max, u32 *store_value, u32 wmi=
_dev)
> +{
> +=09u32 value;
> +=09int err;
> +
> +=09err =3D kstrtouint(buf, 10, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (value < min || value > max)
> +=09=09return -EINVAL;
> +
> +=09err =3D armoury_wmi_set_devstate(attr, value, wmi_dev);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (store_value !=3D NULL)
> +=09=09*store_value =3D value;
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09if (asus_bios_requires_reboot(attr))
> +=09=09asus_set_reboot_and_signal_event();
> +
> +=09return count;
> +}
> +
> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribut=
e *attr,
> +=09=09=09      char *buf)
> +{
> +=09return sysfs_emit(buf, "enumeration\n");
> +}
> +
> +/* Mini-LED mode *******************************************************=
*******/
> +static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, char *buf)
> +{
> +=09u32 value;
> +=09int err;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &val=
ue);
> +=09if (err)
> +=09=09return err;
> +
> +=09value &=3D ASUS_MINI_LED_MODE_MASK;

FIELD_GET() (mainly for consistency as shift is 0 here anyway)

> +
> +=09/*
> +=09 * Remap the mode values to match previous generation mini-LED. The l=
ast gen
> +=09 * WMI 0 =3D=3D off, while on this version WMI 2 =3D=3D off (flipped)=
=2E
> +=09 */
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
) {
> +=09=09switch (value) {
> +=09=09case ASUS_MINI_LED_2024_WEAK:
> +=09=09=09value =3D ASUS_MINI_LED_ON;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_STRONG:
> +=09=09=09value =3D ASUS_MINI_LED_STRONG_MODE;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_2024_OFF:
> +=09=09=09value =3D ASUS_MINI_LED_OFF;
> +=09=09=09break;
> +=09=09}
> +=09}
> +
> +=09return sysfs_emit(buf, "%u\n", value);
> +}
> +
> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09 struct kobj_attribute *attr,
> +=09=09=09=09=09=09const char *buf, size_t count)
> +{
> +=09u32 mode;
> +=09int err;
> +
> +=09err =3D kstrtou32(buf, 10, &mode);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE =
&&
> +=09    mode > ASUS_MINI_LED_ON)
> +=09=09return -EINVAL;
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
 &&
> +=09    mode > ASUS_MINI_LED_STRONG_MODE)
> +=09=09return -EINVAL;
> +
> +=09/*
> +=09 * Remap the mode values so expected behaviour is the same as the las=
t
> +=09 * generation of mini-LED with 0 =3D=3D off, 1 =3D=3D on.
> +=09 */
> +=09if (asus_armoury.mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2=
) {
> +=09=09switch (mode) {
> +=09=09case ASUS_MINI_LED_OFF:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_OFF;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_ON:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_WEAK;
> +=09=09=09break;
> +=09=09case ASUS_MINI_LED_STRONG_MODE:
> +=09=09=09mode =3D ASUS_MINI_LED_2024_STRONG;
> +=09=09=09break;
> +=09=09}
> +=09}

Combine these into a single switch/case.

> +
> +=09err =3D armoury_wmi_set_devstate(attr, mode, asus_armoury.mini_led_de=
v_id);
> +=09if (err)
> +=09=09return err;
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +
> +static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
> +=09=09=09=09=09=09  struct kobj_attribute *attr, char *buf)
> +{
> +=09switch (asus_armoury.mini_led_dev_id) {
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE:
> +=09=09return sysfs_emit(buf, "0;1\n");
> +=09case ASUS_WMI_DEVID_MINI_LED_MODE2:
> +=09=09return sysfs_emit(buf, "0;1;2\n");
> +=09default:
> +=09=09return -ENODEV;
> +=09}
> +}
> +
> +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED=
 backlight mode");

Remove the empty line before this.

I'm little worried about using such a generic names in macros specific=20
to this driver. Maybe the use of "CUSTOM" will save you from collisions=20
but a prefix also helps when reading code to know what is driver specific=
=20
and what is provided by the core. Maybe changing it to:

I think ASUS_ATTR_GROUP_ENUM() already indicates it's "custom" thing, I=20
don't know to which aspect the customness exactly tries to refer to in=20
this macro.

> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09int result, err;
> +=09u32 optimus;
> +
> +=09err =3D kstrtou32(buf, 10, &optimus);

Why the other function used kstrtouint and this kstrtou32 ?? Please check=
=20
all these.

> +=09if (err)
> +=09=09return err;
> +
> +=09if (optimus > 1)
> +=09=09return -EINVAL;
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled:=
 %02X %02X\n",
> +=09=09=09=09result, optimus);
> +=09=09=09return -ENODEV;
> +=09=09}
> +=09}
> +
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled\n=
");
> +=09=09=09return -EBUSY;
> +=09=09}
> +=09}
> +
> +=09err =3D armoury_wmi_set_devstate(attr, optimus, asus_armoury.gpu_mux_=
dev_id);
> +=09if (err)
> +=09=09return err;
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +=09asus_set_reboot_and_signal_event();
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%u\n", asus_armoury.gpu_mux_de=
v_id);
> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU displa=
y MUX mode");
> +
> +/*
> + * A user may be required to store the value twice, typical store first,=
 then
> + * rescan PCI bus to activate power, then store a second time to save co=
rrectly.

Could this be automated?

> + */
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09int result, err;
> +=09u32 disable;
> +
> +=09err =3D kstrtou32(buf, 10, &disable);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (disable > 1)

"disable" sounds like it is boolean for which there's kstrtobool ?=20
Also, I was not sure about optimus > 1 thing above if it too would=20
actually be bool.

> +=09=09return -EINVAL;
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
esult);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (!result && disable) {
> +=09=09=09pr_warn("Can not disable dGPU when the MUX is in dGPU mode\n");
> +=09=09=09return -EBUSY;
> +=09=09}
> +=09}
> +
> +=09err =3D armoury_wmi_set_devstate(attr, disable, ASUS_WMI_DEVID_DGPU);
> +=09if (err)
> +=09=09return err;
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);

ASUS_WMI_SHOW_INT()

> +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU")=
;
> +
> +/* The ACPI call to enable the eGPU also disables the internal dGPU */
> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
> +=09=09=09=09=09       const char *buf, size_t count)
> +{
> +=09int result, err;
> +=09u32 enable;
> +
> +=09err =3D kstrtou32(buf, 10, &enable);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (enable > 1)

kstrtobool() ?

> +=09=09return -EINVAL;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &re=
sult);
> +=09if (err) {
> +=09=09pr_warn("Failed to get eGPU connection status: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &r=
esult);
> +=09=09if (err) {
> +=09=09=09pr_warn("Failed to get GPU MUX status: %d\n", result);
> +=09=09=09return err;
> +=09=09}
> +=09=09if (!result && enable) {
> +=09=09=09pr_warn("Can not enable eGPU when the MUX is in dGPU mode\n");
> +=09=09=09return -ENODEV;
> +=09=09}
> +=09}
> +
> +=09err =3D armoury_wmi_set_devstate(attr, enable, ASUS_WMI_DEVID_EGPU);
> +=09if (err)
> +=09=09return err;
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
> +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (als=
o disables dGPU)");
> +
> +/* Simple attribute creation */
> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE=
_MODE, "0;1;2",
> +=09=09       "Show the current mode of charging");
> +
> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
> +=09=09   "Set the boot POST sound");
> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_PO=
WERSAVE,
> +=09=09   "Set MCU powersaving mode");
> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
> +=09=09   "Set the panel refresh overdrive");
> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU=
_CONNECTED,
> +=09=09   "Show the eGPU connection status");
> +
> +/* If an attribute does not require any special case handling add it her=
e */
> +static const struct asus_attr_group armoury_attr_groups[] =3D {
> +=09{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
> +=09{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
> +=09{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
> +
> +=09{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
> +=09{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> +=09{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
> +=09{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
> +};
> +
> +static int asus_fw_attr_add(void)
> +{
> +=09int err, i;
> +
> +=09asus_armoury.fw_attr_dev =3D device_create(&firmware_attributes_class=
, NULL, MKDEV(0, 0),
> +=09=09=09=09=09=09NULL, "%s", DRIVER_NAME);
> +=09if (IS_ERR(asus_armoury.fw_attr_dev)) {

Add include.

> +=09=09err =3D PTR_ERR(asus_armoury.fw_attr_dev);
> +=09=09goto fail_class_get;
> +=09}
> +
> +=09asus_armoury.fw_attr_kset =3D kset_create_and_add("attributes", NULL,
> +=09=09=09=09=09=09&asus_armoury.fw_attr_dev->kobj);
> +=09if (!asus_armoury.fw_attr_kset) {
> +=09=09err =3D -ENOMEM;
> +=09=09goto err_destroy_classdev;
> +=09}
> +
> +=09err =3D sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_=
reboot.attr);
> +=09if (err) {
> +=09=09pr_err("Failed to create sysfs level attributes\n");
> +=09=09goto err_destroy_kset;
> +=09}
> +
> +=09asus_armoury.mini_led_dev_id =3D 0;
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE))
> +=09=09asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> +=09else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2))
> +=09=09asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE2;
> +
> +=09if (asus_armoury.mini_led_dev_id) {
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &mini_led_mode_attr_group);
> +=09=09if (err) {
> +=09=09=09pr_err("Failed to create sysfs-group for mini_led\n");
> +=09=09=09goto err_remove_file;
> +=09=09}
> +=09}
> +
> +=09asus_armoury.gpu_mux_dev_id =3D 0;
> +=09if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX))
> +=09=09asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> +=09else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO))
> +=09=09asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX_VIVO;
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 &gpu_mux_mode_attr_group);
> +=09=09if (err) {
> +=09=09=09pr_err("Failed to create sysfs-group for gpu_mux\n");
> +=09=09=09goto err_remove_mini_led_group;
> +=09=09}
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
> +=09=09if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +=09=09=09continue;
> +
> +=09=09err =3D sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09 armoury_attr_groups[i].attr_group);
> +=09=09if (err) {
> +=09=09=09pr_err("Failed to create sysfs-group for %s\n",
> +=09=09=09       armoury_attr_groups[i].attr_group->name);
> +=09=09=09goto err_remove_groups;
> +=09=09}
> +=09}
> +
> +=09return 0;
> +
> +err_remove_groups:
> +=09while (i--) {
> +=09=09if (asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
> +=09=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09   armoury_attr_groups[i].attr_group);
> +=09}
> +=09if (asus_armoury.gpu_mux_dev_id)
> +=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> +err_remove_mini_led_group:
> +=09if (asus_armoury.mini_led_dev_id)
> +=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> +err_remove_file:
> +=09sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.a=
ttr);
> +err_destroy_kset:
> +=09kset_unregister(asus_armoury.fw_attr_kset);
> +err_destroy_classdev:
> +fail_class_get:
> +=09device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +=09return err;
> +}
> +
> +/* Init / exit *********************************************************=
*******/
> +
> +static int __init asus_fw_init(void)
> +{
> +=09char *wmi_uid;
> +
> +=09wmi_uid =3D wmi_get_acpi_device_uid(ASUS_WMI_MGMT_GUID);
> +=09if (!wmi_uid)
> +=09=09return -ENODEV;
> +
> +=09/*
> +=09 * if equal to "ASUSWMI" then it's DCTS that can't be used for this
> +=09 * driver, DSTS is required.
> +=09 */
> +=09if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI))
> +=09=09return -ENODEV;
> +
> +=09return asus_fw_attr_add();
> +}
> +
> +static void __exit asus_fw_exit(void)
> +{
> +=09sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.a=
ttr);

Why does the rollback path in asus_fw_attr_add() differ from these?

> +=09kset_unregister(asus_armoury.fw_attr_kset);
> +=09device_destroy(&firmware_attributes_class, MKDEV(0, 0));
> +}
> +
> +module_init(asus_fw_init);
> +module_exit(asus_fw_exit);
> +
> +MODULE_IMPORT_NS("ASUS_WMI");
> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/a=
sus-armoury.h
> new file mode 100644
> index 000000000000..61675e7b5a60
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -0,0 +1,164 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-armoury driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
> + */
> +
> +#ifndef _ASUS_ARMOURY_H_
> +#define _ASUS_ARMOURY_H_
> +
> +#include <linux/types.h>
> +#include <linux/platform_device.h>
> +
> +#define DRIVER_NAME "asus-armoury"
> +
> +#define __ASUS_ATTR_RO(_func, _name)=09=09=09=09=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0444 },=09\
> +=09=09.show =3D _func##_##_name##_show,=09=09=09=09\
> +=09}
> +
> +#define __ASUS_ATTR_RO_AS(_name, _show)=09=09=09=09=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09.attr =3D { .name =3D __stringify(_name), .mode =3D 0444 },=09\
> +=09=09.show =3D _show,=09=09=09=09=09=09\
> +=09}
> +
> +#define __ASUS_ATTR_RW(_func, _name) \
> +=09__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
> +
> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)=09=09=09\
> +=09static ssize_t _attr##_store(struct kobject *kobj,=09=09\
> +=09=09=09=09     struct kobj_attribute *attr,=09\
> +=09=09=09=09     const char *buf, size_t count)=09\
> +=09{=09=09=09=09=09=09=09=09\
> +=09=09return attr_uint_store(kobj, attr, buf, count, _min,=09\
> +=09=09=09=09=09_max, NULL, _wmi);=09=09\
> +=09}
> +
> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)=09=09=09=09=09=09\
> +=09static ssize_t _attr##_show(struct kobject *kobj,=09=09=09\
> +=09=09=09=09    struct kobj_attribute *attr, char *buf)=09\
> +=09{=09=09=09=09=09=09=09=09=09\
> +=09=09u32 result;=09=09=09=09=09=09=09\
> +=09=09int err;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09\
> +=09=09err =3D asus_wmi_get_devstate_dsts(_wmi, &result);=09=09\
> +=09=09if (err)=09=09=09=09=09=09=09\
> +=09=09=09return err;=09=09=09=09=09=09\
> +=09=09return sysfs_emit(buf, _fmt,=09=09=09=09=09\
> +=09=09=09=09  result & ~ASUS_WMI_DSTS_PRESENCE_BIT);=09\
> +=09}
> +
> +/* Create functions and attributes for use in other macros or on their o=
wn */
> +
> +/* Shows a formatted static variable */
> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)=09=09=09=09\
> +=09static ssize_t _attrname##_##_prop##_show(=09=09=09=09\
> +=09=09struct kobject *kobj, struct kobj_attribute *attr, char *buf)=09\
> +=09{=09=09=09=09=09=09=09=09=09\
> +=09=09return sysfs_emit(buf, _fmt, _val);=09=09=09=09\
> +=09}=09=09=09=09=09=09=09=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_##_prop =3D=09=09\
> +=09=09__ASUS_ATTR_RO(_attrname, _prop)
> +
> +#define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _d=
ispname)\
> +=09WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);=09=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D=09=
=09\
> +=09=09__ASUS_ATTR_RO(_attrname, current_value);=09=09=09\
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09=09\
> +=09__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);=09=09=
\
> +=09static struct kobj_attribute attr_##_attrname##_type =3D=09=09=09\
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09=09\
> +=09static struct attribute *_attrname##_attrs[] =3D {=09=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09=09=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09=09=09\
> +=09=09&attr_##_attrname##_possible_values.attr,=09=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09=09=09\
> +=09=09NULL=09=09=09=09=09=09=09=09\
> +=09};=09=09=09=09=09=09=09=09=09\
> +=09static const struct attribute_group _attrname##_attr_group =3D {=09=
=09\
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs=09=09=09\
> +=09}
> +
> +#define __ATTR_RW_INT_GROUP_ENUM(_attrname, _minv, _maxv, _wmi, _fsname,=
\
> +=09=09=09=09 _possible, _dispname)=09=09=09\
> +=09__WMI_STORE_INT(_attrname##_current_value, _minv, _maxv, _wmi);=09\
> +=09WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D=09\
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);=09=09\
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09\
> +=09__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);=09\
> +=09static struct kobj_attribute attr_##_attrname##_type =3D=09=09\
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09\
> +=09static struct attribute *_attrname##_attrs[] =3D {=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09=09\
> +=09=09&attr_##_attrname##_possible_values.attr,=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09=09\
> +=09=09NULL=09=09=09=09=09=09=09\
> +=09};=09=09=09=09=09=09=09=09\
> +=09static const struct attribute_group _attrname##_attr_group =3D {=09\
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs=09=09\
> +=09}
> +
> +/* Boolean style enumeration, base macro. Requires adding show/store */
> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)=09\
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09\
> +=09__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);=09\
> +=09static struct kobj_attribute attr_##_attrname##_type =3D=09=09\
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09\
> +=09static struct attribute *_attrname##_attrs[] =3D {=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09=09\
> +=09=09&attr_##_attrname##_possible_values.attr,=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09=09\
> +=09=09NULL=09=09=09=09=09=09=09\
> +=09};=09=09=09=09=09=09=09=09\
> +=09static const struct attribute_group _attrname##_attr_group =3D {=09\
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs=09=09\
> +=09}
> +
> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)=09\
> +=09__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, "0;1", _dispname)
> +
> +
> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)=09\
> +=09__ATTR_RW_INT_GROUP_ENUM(_attrname, 0, 1, _wmi, _fsname, "0;1", _disp=
name)
> +
> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dis=
pname)=09\
> +=09__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispna=
me)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D=09\
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)=09=09=09\
> +=09__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D=09=
=09\
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);=09=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_possible_values =3D=
=09\
> +=09=09__ASUS_ATTR_RO(_attrname, possible_values);=09=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_type =3D=09=09=09\
> +=09=09__ASUS_ATTR_RO_AS(type, enum_type_show);=09=09=09\
> +=09static struct attribute *_attrname##_attrs[] =3D {=09=09=09\
> +=09=09&attr_##_attrname##_current_value.attr,=09=09=09=09\
> +=09=09&attr_##_attrname##_display_name.attr,=09=09=09=09\
> +=09=09&attr_##_attrname##_possible_values.attr,=09=09=09\
> +=09=09&attr_##_attrname##_type.attr,=09=09=09=09=09\
> +=09=09NULL=09=09=09=09=09=09=09=09\
> +=09};=09=09=09=09=09=09=09=09=09\
> +=09static const struct attribute_group _attrname##_attr_group =3D {=09=
=09\
> +=09=09.name =3D _fsname, .attrs =3D _attrname##_attrs=09=09=09\
> +=09}
> +
> +#endif /* _ASUS_ARMOURY_H_ */
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-=
wmi.c
> index 38ab5306e05a..0d0c84a37ad8 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -30,6 +30,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/platform_data/x86/asus-wmi-leds-ids.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_profile.h>
>  #include <linux/power_supply.h>
> @@ -55,8 +56,6 @@ module_param(fnlock_default, bool, 0444);
>  #define to_asus_wmi_driver(pdrv)=09=09=09=09=09\
>  =09(container_of((pdrv), struct asus_wmi_driver, platform_driver))
> =20
> -#define ASUS_WMI_MGMT_GUID=09"97845ED0-4E6D-11DE-8A39-0800200C9A66"
> -
>  #define NOTIFY_BRNUP_MIN=09=090x11
>  #define NOTIFY_BRNUP_MAX=09=090x1f
>  #define NOTIFY_BRNDOWN_MIN=09=090x20
> @@ -105,8 +104,6 @@ module_param(fnlock_default, bool, 0444);
>  #define USB_INTEL_XUSB2PR=09=090xD0
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI=090x9c31
> =20
> -#define ASUS_ACPI_UID_ASUSWMI=09=09"ASUSWMI"
> -
>  #define WMI_EVENT_MASK=09=09=090xFFFF
> =20
>  #define FAN_CURVE_POINTS=09=098
> diff --git a/include/linux/platform_data/x86/asus-wmi-leds-ids.h b/includ=
e/linux/platform_data/x86/asus-wmi-leds-ids.h
> new file mode 100644
> index 000000000000..281b98ba0ca7
> --- /dev/null
> +++ b/include/linux/platform_data/x86/asus-wmi-leds-ids.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
> +#define __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
> +
> +#include <linux/types.h>

Unnecessary, AFAICT.

> +#include <linux/dmi.h>
> +
> +/* To be used by both hid-asus and asus-wmi to determine which controls =
kbd_brightness */
> +#if IS_REACHABLE(CONFIG_ASUS_WMI) || IS_REACHABLE(CONFIG_HID_ASUS)
> +static const struct dmi_system_id asus_use_hid_led_dmi_ids[] =3D {

Are you aware that by placing this into a header file it ends up=20
getting duplicated to anything including this file? I suppose there's no=20
good way around it without some pretty complex trickery and it doesn't=20
look very large so I guess we can leave it here for now.

> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
> +=09=09},
> +=09},
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> +=09=09},
> +=09},
> +=09{ },
> +};
> +#endif
> +
> +#endif=09/* __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H */
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/p=
latform_data/x86/asus-wmi.h
> index dbd44d9fbb6f..71c68425b3b9 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -6,6 +6,9 @@
>  #include <linux/types.h>
>  #include <linux/dmi.h>
> =20
> +#define ASUS_WMI_MGMT_GUID=09"97845ED0-4E6D-11DE-8A39-0800200C9A66"
> +#define ASUS_ACPI_UID_ASUSWMI=09"ASUSWMI"
> +
>  /* WMI Methods */
>  #define ASUS_WMI_METHODID_SPEC=09        0x43455053 /* BIOS SPECificatio=
n */
>  #define ASUS_WMI_METHODID_SFBD=09=090x44424653 /* Set First Boot Device =
*/
> @@ -191,44 +194,4 @@ static inline int asus_wmi_evaluate_method(u32 metho=
d_id, u32 arg0, u32 arg1,
>  }
>  #endif
> =20
> -/* To be used by both hid-asus and asus-wmi to determine which controls =
kbd_brightness */
> -static const struct dmi_system_id asus_use_hid_led_dmi_ids[] =3D {
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
> -=09=09},
> -=09},
> -=09{
> -=09=09.matches =3D {
> -=09=09=09DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
> -=09=09},
> -=09},
> -=09{ },
> -};
> -
>  #endif=09/* __PLATFORM_DATA_X86_ASUS_WMI_H */
>=20

I don't have more time for further reviews.

--=20
 i.
--8323328-497199432-1760534907=:957--

