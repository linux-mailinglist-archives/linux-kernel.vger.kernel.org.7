Return-Path: <linux-kernel+bounces-878418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E501C2089A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA3FD34F258
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744862528FD;
	Thu, 30 Oct 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WVXDDe19"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A7A155333;
	Thu, 30 Oct 2025 14:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761833830; cv=none; b=bGzYl5hE71+RcfWgGq7uBW1X/PyL0/GbPShi28qhideoG7ap3P9LVKO5UvsSGanX1P+lR4V0FzeB/pX9G5hOXzvOYvDzQQa7Ed415A7B7QPHNrY7nNyF7+4wkKgs/Al5TinSe2rxRyT8cDA8AM3/dOrWtJX/SRpwXSI7XUBStQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761833830; c=relaxed/simple;
	bh=o8diXu/+x2w+PgGAHBoBGFqwn4+XbthaMOWUeEmAdI0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jawuor/pvRxQavnnMcp2EgKdMrMkcjEmz6+lsx07V7I08dnc7/zxT17zJxbrJBWvoJ8cS0weHsiQEY6WQO8aBev+P+F02Ybdftd5R6+AgFU/JaVeeyUWSTnX12prCNN0GG4BQFGJyfVGVJ0GEOkJWFymOcbHEp74H0J53DIedTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WVXDDe19; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761833827; x=1793369827;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=o8diXu/+x2w+PgGAHBoBGFqwn4+XbthaMOWUeEmAdI0=;
  b=WVXDDe19ZgbPA1znnMoYAybzRX0lTbpD98AcfoWsoT2wg1Ipt85H4t6E
   6Fsd5HtFhfv6cZCXtEzPhatpxyxsge36UOJSNAvBzu/HDvW0QftWaTVSV
   OforSdcUwXSA5HBvlN27ehHdOnIsb7cO31IRrAlQfnd/7cPvfQ7ZWb1CE
   N/t6DgWNa8KvZvE7qZrI+s+z2fbpNK5qa2yRuGHjhylED2+9BLNiHcQY+
   2a/5sp0fu1oVlRV1Up7NALx5hS68NKqV8e5nqknbsz44W3dW6i0fNzKw9
   Aq7OAQaDfZthDdkU43n9oLuGQXj0dyztuA64jxPWeJ1mmOGkDvicInhin
   g==;
X-CSE-ConnectionGUID: AmmO463STNWzj7peqXo5mw==
X-CSE-MsgGUID: oFDU8I5wSVKEaBHIHNszgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11598"; a="89442791"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="89442791"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:17:06 -0700
X-CSE-ConnectionGUID: rFhe6OLZQXCi9Bdi6s3xmA==
X-CSE-MsgGUID: e7i6rV1xSly9nrHR/UL5Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="186060494"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.175])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 07:17:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 30 Oct 2025 16:16:57 +0200 (EET)
To: Denis Benato <denis.benato@linux.dev>
cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, 
    Hans de Goede <hdegoede@redhat.com>, 
    "Limonciello, Mario" <mario.limonciello@amd.com>, 
    "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    Mateusz Schyboll <dragonn@op.pl>, Denis Benato <benato.denis96@gmail.com>, 
    porfet828@gmail.com
Subject: Re: [PATCH v16 2/9] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
In-Reply-To: <20251030130320.1287122-3-denis.benato@linux.dev>
Message-ID: <96e06599-982a-8891-b12d-97f18f8ffb67@linux.intel.com>
References: <20251030130320.1287122-1-denis.benato@linux.dev> <20251030130320.1287122-3-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-542187111-1761833817=:975"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-542187111-1761833817=:975
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 30 Oct 2025, Denis Benato wrote:

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
> =E2=94=9C=E2=94=80=E2=94=80 current_value
> =E2=94=9C=E2=94=80=E2=94=80 display_name
> =E2=94=9C=E2=94=80=E2=94=80 possible_values
> =E2=94=94=E2=94=80=E2=94=80 type
>=20
> as do other attributes.
>=20
> Co-developed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>  drivers/hid/hid-asus.c                        |   1 +
>  drivers/platform/x86/Kconfig                  |  12 +
>  drivers/platform/x86/Makefile                 |   1 +
>  drivers/platform/x86/asus-armoury.c           | 756 ++++++++++++++++++
>  drivers/platform/x86/asus-armoury.h           | 163 ++++
>  drivers/platform/x86/asus-wmi.c               |  10 +-
>  .../platform_data/x86/asus-wmi-leds-ids.h     |  50 ++
>  include/linux/platform_data/x86/asus-wmi.h    |  43 +-
>  8 files changed, 990 insertions(+), 46 deletions(-)
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
> index 000000000000..c5fe61557582
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -0,0 +1,756 @@
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
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/fs.h>
> +#include <linux/kernel.h>
> +#include <linux/kmod.h>
> +#include <linux/kobject.h>
> +#include <linux/kstrtox.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/printk.h>
> +#include <linux/sysfs.h>
> +
> +#include "asus-armoury.h"
> +#include "firmware_attributes_class.h"
> +
> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> +
> +#define ASUS_MINI_LED_MODE_MASK   GENMASK(1, 0)
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
> +struct asus_armoury_priv {
> +=09struct device *fw_attr_dev;
> +=09struct kset *fw_attr_kset;
> +
> +=09/*
> +=09 * Mutex to protect eGPU activation/deactivation
> +=09 * sequences and dGPU connection status:
> +=09 * do not allow concurrent changes or changes
> +=09 * before a reboot if dGPU got disabled.
> +=09 */
> +=09struct mutex egpu_mutex;
> +
> +=09u32 mini_led_dev_id;
> +=09u32 gpu_mux_dev_id;
> +};
> +
> +static struct asus_armoury_priv asus_armoury =3D {
> +=09.egpu_mutex =3D __MUTEX_INITIALIZER(asus_armoury.egpu_mutex),
> +};
> +
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
> +/**
> + * armoury_has_devstate() - Check presence of the WMI function state.
> + *
> + * @dev_id: The WMI method ID to check for presence.
> + *
> + * Returns: true iif method is supported.
> + */
> +static bool armoury_has_devstate(u32 dev_id)
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
> +/**
> + * armoury_get_devstate() - Get the WMI function state.
> + * @attr: NULL or the kobj_attribute associated to called WMI function.
> + * @dev_id: The WMI method ID to call.
> + * @retval:
> + * * non-NULL pointer to where to store the value returned from WMI
> + * * with the function presence bit cleared.
> + *
> + * Intended usage is from sysfs attribute checking associated WMI functi=
on.
> + *
> + * Returns:
> + * * %-ENODEV=09- method ID is unsupported.
> + * * %0=09=09- successful and retval is filled.
> + * * %other=09- error from WMI call.
> + */
> +static int armoury_get_devstate(struct kobj_attribute *attr, u32 *retval=
, u32 dev_id)
> +{
> +=09int err;
> +
> +=09err =3D asus_wmi_get_devstate_dsts(dev_id, retval);
> +=09if (err) {
> +=09=09if (attr)
> +=09=09=09pr_err("Failed to get %s: %d\n", attr->attr.name, err);
> +=09=09else
> +=09=09=09pr_err("Failed to get devstate for 0x%x: %d\n", dev_id, err);
> +
> +=09=09return err;
> +=09}
> +
> +=09/*
> +=09 * asus_wmi_get_devstate_dsts will populate retval with WMI return, b=
ut
> +=09 * the true value is expressed when ASUS_WMI_DSTS_PRESENCE_BIT is cle=
ar.
> +=09 */
> +=09*retval &=3D ~ASUS_WMI_DSTS_PRESENCE_BIT;
> +
> +=09return 0;
> +}
> +
> +/**
> + * armoury_set_devstate() - Set the WMI function state.
> + * @attr: The kobj_attribute associated to called WMI function.
> + * @dev_id: The WMI method ID to call.
> + * @retval:
> + * * Pointer to where to store the value returned from WMI or NULL.
> + *
> + * Intended usage is from sysfs attribute setting associated WMI functio=
n.
> + * Before calling set the presence of the function should be checked.
> + *
> + * Results !1 is usually considered a fail by ASUS, but some WMI methods
> + * (like eGPU or CPU cores) do use > 1 to return a status code or simila=
r:
> + * in these cases caller is interested in the actual return value
> + * and should perform relevant checks.
> + *
> + * Returns:
> + * * %-EIO=09- WMI function returned an error.
> + * * %0=09=09- successful and retval is filled.
> + * * %other=09- error from WMI call.
> + */
> +static int armoury_set_devstate(struct kobj_attribute *attr,
> +=09=09=09=09     u32 value, u32 *retval, u32 dev_id)
> +{
> +=09u32 result;
> +=09int err;
> +
> +=09err =3D asus_wmi_set_devstate(dev_id, value, retval ? retval : &resul=
t);
> +=09if (err) {
> +=09=09if (attr)
> +=09=09=09pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +=09=09else
> +=09=09=09pr_err("Failed to set devstate for 0x%x: %d\n", dev_id, err);
> +
> +=09=09return err;
> +=09}
> +
> +=09/*
> +=09 * If retval =3D=3D NULL caller is uninterested in return value:
> +=09 * perform the most common result check here.
> +=09 */
> +=09if ((retval =3D=3D NULL) && (result =3D=3D 0)) {
> +=09=09pr_err("Failed to set %s: (result): 0x%x\n", attr->attr.name, resu=
lt);
> +=09=09return -EIO;
> +=09}
> +
> +=09return 0;
> +}
> +
> +static int attr_enum_list(char *buf, size_t enum_values)
> +{
> +=09size_t i;
> +=09int len =3D 0;
> +
> +=09for (i =3D 0; i < enum_values; i++) {
> +=09=09if (i =3D=3D 0)
> +=09=09=09len +=3D sysfs_emit_at(buf, len, "%zu", i);
> +=09=09else
> +=09=09=09len +=3D sysfs_emit_at(buf, len, ";%zu", i);
> +=09}
> +=09len +=3D sysfs_emit_at(buf, len, "\n");
> +
> +=09return len;
> +}
> +
> +/**
> + * attr_uint_store() - Send an uint to WMI method if within min/max incl=
usive.
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
> + * attribute which works only with integers.
> + * Integer to be sent to the WMI method is range checked and
> + * an error returned if out of range.
> + *
> + * If the value is valid and WMI is success then the sysfs attribute is =
notified
> + * and if asus_bios_requires_reboot() is true then reboot attribute
> + * is also notified.
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
> +=09err =3D kstrtou32(buf, 10, &value);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (value < min || value > max)
> +=09=09return -EINVAL;
> +
> +=09err =3D armoury_set_devstate(attr, value, NULL, wmi_dev);
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
> +=09err =3D armoury_get_devstate(attr, &value, asus_armoury.mini_led_dev_=
id);
> +=09if (err)
> +=09=09return err;
> +
> +=09value =3D FIELD_GET(ASUS_MINI_LED_MODE_MASK, 0);
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
> +=09=09=09=09=09=09 const char *buf, size_t count)
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
> +=09=09default:
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
> +=09err =3D armoury_set_devstate(attr, mode, NULL, asus_armoury.mini_led_=
dev_id);
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

These could have used the code in attr_enum_list() as well?

> +=09default:
> +=09=09return -ENODEV;
> +=09}
> +}
> +ASUS_ATTR_GROUP_ENUM(mini_led_mode, "mini_led_mode", "Set the mini-LED b=
acklight mode");
> +
> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr,
> +=09=09=09=09=09=09const char *buf, size_t count)
> +{
> +=09int result, err;
> +=09bool optimus;
> +
> +=09err =3D kstrtobool(buf, &optimus);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (armoury_has_devstate(ASUS_WMI_DEVID_DGPU)) {
> +=09=09err =3D armoury_get_devstate(NULL, &result, ASUS_WMI_DEVID_DGPU);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09pr_warn("Cannot switch MUX to dGPU mode when dGPU is disabled: =
%02X\n",
> +=09=09=09=09result);
> +=09=09=09return -ENODEV;
> +=09=09}
> +=09}
> +
> +=09if (armoury_has_devstate(ASUS_WMI_DEVID_EGPU)) {
> +=09=09err =3D armoury_get_devstate(NULL, &result, ASUS_WMI_DEVID_EGPU);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (result && !optimus) {
> +=09=09=09pr_warn("Cannot switch MUX to dGPU mode when eGPU is enabled\n"=
);
> +=09=09=09return -EBUSY;
> +=09=09}
> +=09}
> +
> +=09err =3D armoury_set_devstate(attr, optimus ? 1 : 0, NULL, asus_armour=
y.gpu_mux_dev_id);
> +=09if (err)
> +=09=09return err;
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +=09asus_set_reboot_and_signal_event();
> +
> +=09return count;
> +}
> +ASUS_WMI_SHOW_INT(gpu_mux_mode_current_value, "%u\n", asus_armoury.gpu_m=
ux_dev_id);
> +ASUS_ATTR_GROUP_BOOL(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display =
MUX mode");
> +
> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
> +=09=09=09=09=09=09struct kobj_attribute *attr, const char *buf,
> +=09=09=09=09=09=09size_t count)
> +{
> +=09int result, err;
> +=09bool disable;
> +
> +=09err =3D kstrtobool(buf, &disable);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09err =3D armoury_get_devstate(NULL, &result, asus_armoury.gpu_mux_d=
ev_id);
> +=09=09if (err)
> +=09=09=09return err;
> +=09=09if (!result && disable) {
> +=09=09=09pr_warn("Cannot disable dGPU when the MUX is in dGPU mode\n");
> +=09=09=09return -EBUSY;
> +=09=09}
> +=09}
> +
> +=09scoped_guard(mutex, &asus_armoury.egpu_mutex) {
> +=09=09err =3D armoury_set_devstate(attr, disable ? 1 : 0, NULL, ASUS_WMI=
_DEVID_DGPU);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +ASUS_WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGP=
U);
> +ASUS_ATTR_GROUP_BOOL(dgpu_disable, "dgpu_disable", "Disable the dGPU");
> +
> +/* Values map for eGPU activation requests. */
> +static u32 egpu_status_map[] =3D {
> +=09[0] =3D 0x00000000U,
> +=09[1] =3D 0x00000001U,
> +=09[2] =3D 0x00000101U,
> +=09[3] =3D 0x00000201U,
> +};
> +
> +/*
> + * armoury_pci_rescan() - Performs a PCI rescan
> + *
> + * Bring up any GPU that has been hotplugged in the system.
> + */
> +static void armoury_pci_rescan(void)
> +{
> +=09struct pci_bus *b =3D NULL;
> +
> +=09pci_lock_rescan_remove();
> +=09while ((b =3D pci_find_next_bus(b)) !=3D NULL)
> +=09=09pci_rescan_bus(b);
> +=09pci_unlock_rescan_remove();
> +}
> +
> +/*
> + * The ACPI call to enable the eGPU might also disable the internal dGPU=
,
> + * but this is not always the case and on certain models enabling the eG=
PU
> + * when the dGPU is either still active or has been disabled without reb=
ooting
> + * will make both GPUs malfunction and the kernel will detect many
> + * PCI AER unrecoverable errors.
> + */
> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj, str=
uct kobj_attribute *attr,
> +=09=09=09=09=09=09=09const char *buf, size_t count)
> +{
> +=09int err;
> +=09u32 requested, enable, result;
> +
> +=09err =3D kstrtou32(buf, 10, &requested);
> +=09if (err)
> +=09=09return err;
> +
> +=09if (requested >=3D ARRAY_SIZE(egpu_status_map))
> +=09=09return -EINVAL;
> +=09enable =3D egpu_status_map[requested];
> +
> +=09scoped_guard(mutex, &asus_armoury.egpu_mutex) {
> +=09=09/* Ensure the eGPU is connected before attempting to activate it. =
*/
> +=09=09if (enable) {
> +=09=09=09err =3D armoury_get_devstate(NULL, &result, ASUS_WMI_DEVID_EGPU=
_CONNECTED);
> +=09=09=09if (err) {
> +=09=09=09=09pr_warn("Failed to get eGPU connection status: %d\n", err);
> +=09=09=09=09return err;
> +=09=09=09}
> +=09=09=09if (!result) {
> +=09=09=09=09pr_warn("Cannot activate eGPU while undetected\n");
> +=09=09=09=09return -ENOENT;
> +=09=09=09}
> +=09=09}
> +
> +=09=09if (asus_armoury.gpu_mux_dev_id) {
> +=09=09=09err =3D armoury_get_devstate(NULL, &result, asus_armoury.gpu_mu=
x_dev_id);
> +=09=09=09if (err)
> +=09=09=09=09return err;
> +
> +=09=09=09if (!result && enable) {
> +=09=09=09=09pr_warn("Cannot enable eGPU when the MUX is in dGPU mode\n")=
;
> +=09=09=09=09return -ENODEV;
> +=09=09=09}
> +=09=09}
> +
> +=09=09err =3D armoury_set_devstate(attr, enable, &result, ASUS_WMI_DEVID=
_EGPU);
> +=09=09if (err) {
> +=09=09=09pr_err("Failed to set %s: %d\n", attr->attr.name, err);
> +=09=09=09return err;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * ACPI returns value 0x01 on success and 0x02 on a partial activa=
tion:
> +=09=09 * performing a pci rescan will bring up the device in pci-e 3.0 s=
peed,
> +=09=09 * after a reboot the device will work at full speed.
> +=09=09 */
> +=09=09switch (result) {
> +=09=09case 0x01:
> +=09=09=09/*
> +=09=09=09 * When a GPU is in use it does not get disconnected even if
> +=09=09=09 * the ACPI call returns a success.
> +=09=09=09 */
> +=09=09=09if (!enable) {
> +=09=09=09=09err =3D armoury_get_devstate(attr, &result, ASUS_WMI_DEVID_E=
GPU);
> +=09=09=09=09if (err) {
> +=09=09=09=09=09pr_warn("Failed to ensure eGPU is deactivated: %d\n", err=
);
> +=09=09=09=09=09return err;
> +=09=09=09=09}
> +
> +=09=09=09=09if (result !=3D 0)
> +=09=09=09=09=09return -EBUSY;
> +=09=09=09}
> +
> +=09=09=09pr_debug("Success changing the eGPU status\n");
> +=09=09=09break;
> +=09=09case 0x02:
> +=09=09=09pr_info("Success changing the eGPU status, a reboot is strongly=
 advised\n");
> +=09=09=09asus_set_reboot_and_signal_event();
> +=09=09=09break;
> +=09=09default:
> +=09=09=09pr_err("Failed to change the eGPU status: wmi result is 0x%x\n"=
, result);
> +=09=09=09return -EIO;
> +=09=09}
> +=09}
> +
> +=09/*
> +=09 * Perform a PCI rescan: on every tested model this is necessary
> +=09 * to make the eGPU visible on the bus without rebooting.
> +=09 */
> +=09armoury_pci_rescan();
> +
> +=09sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +=09return count;
> +}
> +
> +static ssize_t egpu_enable_current_value_show(struct kobject *kobj, stru=
ct kobj_attribute *attr,
> +=09=09=09=09=09=09char *buf)
> +{
> +=09int i, err;
> +=09u32 status;
> +
> +=09scoped_guard(mutex, &asus_armoury.egpu_mutex) {
> +=09=09err =3D armoury_get_devstate(attr, &status, ASUS_WMI_DEVID_EGPU);
> +=09=09if (err)
> +=09=09=09return err;
> +=09}
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(egpu_status_map); i++) {
> +=09=09if (egpu_status_map[i] =3D=3D status)
> +=09=09=09return sysfs_emit(buf, "%u\n", i);
> +=09}
> +
> +=09return -EIO;
> +}
> +
> +static ssize_t egpu_enable_possible_values_show(struct kobject *kobj, st=
ruct kobj_attribute *attr,
> +=09=09=09=09=09=09char *buf)
> +{
> +=09return attr_enum_list(buf, ARRAY_SIZE(egpu_status_map));
> +}
> +ASUS_ATTR_GROUP_ENUM(egpu_enable, "egpu_enable", "Enable the eGPU (also =
disables dGPU)");
> +
> +/* Simple attribute creation */
> +ASUS_ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_C=
HARGE_MODE, "0;1;2",
> +=09=09=09    "Show the current mode of charging");
> +ASUS_ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SO=
UND,
> +=09=09=09"Set the boot POST sound");
> +ASUS_ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_M=
CU_POWERSAVE,
> +=09=09=09"Set MCU powersaving mode");
> +ASUS_ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANE=
L_OD,
> +=09=09=09"Set the panel refresh overdrive");
> +ASUS_ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID=
_EGPU_CONNECTED,
> +=09=09=09"Show the eGPU connection status");
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
> +=09if (armoury_has_devstate(ASUS_WMI_DEVID_MINI_LED_MODE))
> +=09=09asus_armoury.mini_led_dev_id =3D ASUS_WMI_DEVID_MINI_LED_MODE;
> +=09else if (armoury_has_devstate(ASUS_WMI_DEVID_MINI_LED_MODE2))
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
> +=09if (armoury_has_devstate(ASUS_WMI_DEVID_GPU_MUX))
> +=09=09asus_armoury.gpu_mux_dev_id =3D ASUS_WMI_DEVID_GPU_MUX;
> +=09else if (armoury_has_devstate(ASUS_WMI_DEVID_GPU_MUX_VIVO))
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
> +=09=09if (!armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
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
> +=09=09if (armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
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
> +=09int i;
> +
> +=09for (i =3D ARRAY_SIZE(armoury_attr_groups) - 1; i >=3D 0; i--) {
> +=09=09if (armoury_has_devstate(armoury_attr_groups[i].wmi_devid))
> +=09=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
> +=09=09=09=09=09   armoury_attr_groups[i].attr_group);
> +=09}
> +
> +=09if (asus_armoury.gpu_mux_dev_id)
> +=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode=
_attr_group);
> +
> +=09if (asus_armoury.mini_led_dev_id)
> +=09=09sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mod=
e_attr_group);
> +
> +=09sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.a=
ttr);
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
> index 000000000000..9f2c98df5fd7
> --- /dev/null
> +++ b/drivers/platform/x86/asus-armoury.h
> @@ -0,0 +1,163 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * Definitions for kernel modules using asus-armoury driver
> + *
> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>

Nit, extra space.

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

So this function is static in the .c file and you're using it in this=20
header?

> +=09}
> +
> +#define ASUS_WMI_SHOW_INT(_attr, _fmt, _wmi)=09=09=09=09=09\
> +=09static ssize_t _attr##_show(struct kobject *kobj,=09=09=09\
> +=09=09=09=09    struct kobj_attribute *attr, char *buf)=09\
> +=09{=09=09=09=09=09=09=09=09=09\
> +=09=09u32 result;=09=09=09=09=09=09=09\
> +=09=09int err;=09=09=09=09=09=09=09\
> +=09=09=09=09=09=09=09=09=09=09\
> +=09=09err =3D armoury_get_devstate(attr, &result, _wmi);=09=09\

Include missing.

> +=09=09if (err)=09=09=09=09=09=09=09\
> +=09=09=09return err;=09=09=09=09=09=09\
> +=09=09return sysfs_emit(buf, _fmt, result);=09=09=09=09\

Include missing.

This is a header file so includes should be added for each used function.
For struct pointers which are not deferenced, you may forward-declare just=
=20
the struct without bringing in the whole include for it.

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
> +=09ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);=09=09\
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
> +=09ASUS_WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);=09\
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
> +#define ASUS_ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)=09\
> +=09__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, "0;1", _dispname)
> +
> +
> +#define ASUS_ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)=09\
> +=09__ATTR_RW_INT_GROUP_ENUM(_attrname, 0, 1, _wmi, _fsname, "0;1", _disp=
name)
> +
> +#define ASUS_ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible,=
 _dispname)=09\
> +=09__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispna=
me)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + */
> +#define ASUS_ATTR_GROUP_BOOL(_attrname, _fsname, _dispname)=09=09\
> +=09static struct kobj_attribute attr_##_attrname##_current_value =3D=09\
> +=09=09__ASUS_ATTR_RW(_attrname, current_value);=09=09\
> +=09__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
> +
> +/*
> + * Requires <name>_current_value_show(), <name>_current_value_show()
> + * and <name>_possible_values_show()
> + */
> +#define ASUS_ATTR_GROUP_ENUM(_attrname, _fsname, _dispname)=09=09=09\
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
> index c3e90517ce0f..ff98267e5981 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -15,6 +15,7 @@
> =20
>  #include <linux/acpi.h>
>  #include <linux/backlight.h>
> +#include <linux/bits.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
> @@ -30,6 +31,7 @@
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
>  #include <linux/platform_data/x86/asus-wmi.h>
> +#include <linux/platform_data/x86/asus-wmi-leds-ids.h>
>  #include <linux/platform_device.h>
>  #include <linux/platform_profile.h>
>  #include <linux/power_supply.h>
> @@ -55,8 +57,6 @@ module_param(fnlock_default, bool, 0444);
>  #define to_asus_wmi_driver(pdrv)=09=09=09=09=09\
>  =09(container_of((pdrv), struct asus_wmi_driver, platform_driver))
> =20
> -#define ASUS_WMI_MGMT_GUID=09"97845ED0-4E6D-11DE-8A39-0800200C9A66"
> -
>  #define NOTIFY_BRNUP_MIN=09=090x11
>  #define NOTIFY_BRNUP_MAX=09=090x1f
>  #define NOTIFY_BRNDOWN_MIN=09=090x20
> @@ -105,8 +105,6 @@ module_param(fnlock_default, bool, 0444);
>  #define USB_INTEL_XUSB2PR=09=090xD0
>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI=090x9c31
> =20
> -#define ASUS_ACPI_UID_ASUSWMI=09=09"ASUSWMI"
> -
>  #define WMI_EVENT_MASK=09=09=090xFFFF
> =20
>  #define FAN_CURVE_POINTS=09=098
> @@ -561,8 +559,8 @@ static int asus_wmi_get_devstate(struct asus_wmi *asu=
s, u32 dev_id, u32 *retval)
>   *
>   * Returns:
>   * * %-ENODEV=09- method ID is unsupported.
> - * * %0=09=09=09- successful and retval is filled.
> - * * %other=09=09- error from WMI call.
> + * * %0=09=09- successful and retval is filled.
> + * * %other=09- error from WMI call.
>   */
>  int asus_wmi_get_devstate_dsts(u32 dev_id, u32 *retval)
>  {
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
> +#include <linux/dmi.h>
> +
> +/* To be used by both hid-asus and asus-wmi to determine which controls =
kbd_brightness */
> +#if IS_REACHABLE(CONFIG_ASUS_WMI) || IS_REACHABLE(CONFIG_HID_ASUS)
> +static const struct dmi_system_id asus_use_hid_led_dmi_ids[] =3D {
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

After removing this, is dmi.h still necessary?

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

--=20
 i.

--8323328-542187111-1761833817=:975--

