Return-Path: <linux-kernel+bounces-855419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E25EBE12A2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 03:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92ED8541FFD
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 01:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77331E5207;
	Thu, 16 Oct 2025 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYnlgBq+"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E618FDDB
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 01:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578138; cv=none; b=ZSfCuWb3KqnD/TVnKoqq0cVV2uQt3Qt625HLl4qwWVCczr9p7/zSpqNwnlDMoVptjNGO+6JMAZwoVlAaq4Km4NapY8kFeWQCLUMDcrwW98KKg+jhZDNKevTWDuP/9LQMS8kQZFpnxchtBafMWblIE33lzn/d6VhJlHCox5T9Ny4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578138; c=relaxed/simple;
	bh=E+sgGLwFdMF/i3DgRoYsUcjuJ325OoEPNgTZcM0/5ds=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWv/5UGLfr6ioPtuWlhK29pi369rdB9JxyTzHhc+IKdTGEObuOz2GZN7lCldkegq8bh/Mgc8nRfdcjO4XYnpF0aQ21ChbiefKY9au9ao5Yhv7B7lCPHIQS5pyedk2nmkDuVVOCDgeMOz6V1ZCB2AN74ZqB36mPCWQAUBqFp1SoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYnlgBq+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso161040f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760578133; x=1761182933; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pa+XfaK9u7quw3l0UX/gsxX2HcP3aoidEYDHMUoUHmk=;
        b=DYnlgBq+RXvXkpLdqv8ifvGMKXoeTZUlSDc+82lQlrtw+y1iiwDbY8qZf39Vwk8vPl
         SohlOd/1wEL9BUDg/SjQe6BtM+WeAW7kNm7ABGEoV6Wg+xv9/ATXFCcGm6IjkSmosFJC
         2Yu4n+kV1TQFzwfW+qDd54DtozqO6MQuRgfkS9RptT530GkFmBpJnzpZSWunJ6CQvBW2
         9rGT5IN0lx4etZZJq2ydVZosLnrNxFpxoPcm2HkcyBaL6196IXMDce+lxsb0CMn708JG
         jlbWoEAfywsPkRafIRPmNUZE51hfLi7uAYSHbR55pU+E8rhDNa+Jw4EoC2PTCNbivZq0
         y6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760578133; x=1761182933;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pa+XfaK9u7quw3l0UX/gsxX2HcP3aoidEYDHMUoUHmk=;
        b=HoEUC1KtsvfThF001gEtUwSqS8z2Gn1I0L++B4Hj1A++Bg87DSc0di6t/1wsxS/w0U
         hirUunpzQE4FItnK9XQRdz9tbCtdmJkk76Onk9bYWoIt7KiECgLfT9rIRjAtmvcj9FZV
         uGPCzVJu0UQbZp6apm3kqhR663JVqhDzt5ceV0gUHRVojYyQNQr7yHtgbtUceDPCiwO9
         NzicWcmJrJY+Al0j72FzPBmTICjOVhksuThc04/bn2M9aBIfJtwuJqB4atfKTddBR/QI
         PI7MDUeyj2Hs3FhWCAOLJQK7bQMPHkI0t6QvBW8EsStQ93HH8+SzaTXoBNJ0bClYJGjV
         S6Ew==
X-Gm-Message-State: AOJu0YwsXjR2UAGKQ2CPK1cO9D9konGJEs3Tafqq67kq0ZYA74lyVe2c
	eqB3B4tl6gqoFvwZVVUPKbZ0jl2VJJL7O0q85tMISnObSKyYf8BEpo59
X-Gm-Gg: ASbGncvG2KI6zIguWnOlJTz5AHsQ8Xwnt7gj5UJwq7OhpRwmbijq/FeFFoX8YAzsM/r
	lFMK8jrLZy7koUi0pXrt9Y3E/Yj/qOhv8RKg0SXYljhp9cs2VcrlXKsjTXiaqtnuaqE5Zs1TF7W
	jhuwksxpCVkYwEHHtqV1NJsdi8LNRfKKpVP+eE09e3F3Kz5XlgBBu2aBvdMbDN9I1KhR0XsIuBF
	lvYs1W46JjtoRg2HsND096gb5n7/aoDnWk6M77xHE/C0ZlX25o6fVknSHRIU3XKIf+eUfEAIHp7
	gVTnv+lQJsMJdgJx71X5LpmQVTyZ/sIU9/6d8+Bwi71HU3yE+tAE3nalbfqutVD6CbkAIZRxAAO
	yAP2FEvJcEWcnit6iL5kZsDkeoEE6VVaANXIs80HyiZdDohgHm4yHtQNYPWq1+gECyWp2jOcilC
	OGk9M/uVqdvbd7Nw==
X-Google-Smtp-Source: AGHT+IGFMHh+2pFt94mvEx5UJDzW3rVv3NBHaBjFrsQlpchSPalM2sbNeWHILN2OTIks9oLXIMXU2Q==
X-Received: by 2002:a05:6000:2285:b0:3ec:8c8:7b79 with SMTP id ffacd0b85a97d-4266e8e0bdfmr21482533f8f.61.1760578132624;
        Wed, 15 Oct 2025 18:28:52 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427013f9b58sm7167f8f.51.2025.10.15.18.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 18:28:52 -0700 (PDT)
Message-ID: <4d660ca5-fa98-481f-be74-1103f1e483d4@gmail.com>
Date: Thu, 16 Oct 2025 03:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/9] platform/x86: asus-armoury: move existing tunings
 to asus-armoury module
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Hans de Goede <hdegoede@redhat.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>, Alok Tiwari <alok.a.tiwari@oracle.com>,
 Derek John Clark <derekjohn.clark@gmail.com>,
 Mateusz Schyboll <dragonn@op.pl>, porfet828@gmail.com
References: <20251015014736.1402045-1-benato.denis96@gmail.com>
 <20251015014736.1402045-3-benato.denis96@gmail.com>
 <eb8f01d9-9250-4916-3e65-40aef04cff6b@linux.intel.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <eb8f01d9-9250-4916-3e65-40aef04cff6b@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/15/25 15:56, Ilpo Järvinen wrote:
> On Wed, 15 Oct 2025, Denis Benato wrote:
>
>> From: "Luke D. Jones" <luke@ljones.dev>
>>
>> The fw_attributes_class provides a much cleaner interface to all of the
>> attributes introduced to asus-wmi. This patch moves all of these extra
>> attributes over to fw_attributes_class, and shifts the bulk of these
>> definitions to a new kernel module to reduce the clutter of asus-wmi
>> with the intention of deprecating the asus-wmi attributes in future.
>>
>> The work applies only to WMI methods which don't have a clearly defined
>> place within the sysfs and as a result ended up lumped together in
>> /sys/devices/platform/asus-nb-wmi/ with no standard API.
>>
>> Where possible the fw attrs now implement defaults, min, max, scalar,
>> choices, etc. As en example dgpu_disable becomes:
>>
>> /sys/class/firmware-attributes/asus-armoury/attributes/dgpu_disable/
>> ├── current_value
>> ├── display_name
>> ├── possible_values
>> └── type
>>
>> as do other attributes.
>>
>> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> ---
>>  drivers/hid/hid-asus.c                        |   1 +
>>  drivers/platform/x86/Kconfig                  |  12 +
>>  drivers/platform/x86/Makefile                 |   1 +
>>  drivers/platform/x86/asus-armoury.c           | 545 ++++++++++++++++++
>>  drivers/platform/x86/asus-armoury.h           | 164 ++++++
>>  drivers/platform/x86/asus-wmi.c               |   5 +-
>>  .../platform_data/x86/asus-wmi-leds-ids.h     |  50 ++
>>  include/linux/platform_data/x86/asus-wmi.h    |  43 +-
>>  8 files changed, 777 insertions(+), 44 deletions(-)
>>  create mode 100644 drivers/platform/x86/asus-armoury.c
>>  create mode 100644 drivers/platform/x86/asus-armoury.h
>>  create mode 100644 include/linux/platform_data/x86/asus-wmi-leds-ids.h
>>
>> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
>> index a444d41e53b6..472bca54642b 100644
>> --- a/drivers/hid/hid-asus.c
>> +++ b/drivers/hid/hid-asus.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/hid.h>
>>  #include <linux/module.h>
>>  #include <linux/platform_data/x86/asus-wmi.h>
>> +#include <linux/platform_data/x86/asus-wmi-leds-ids.h>
>>  #include <linux/input/mt.h>
>>  #include <linux/usb.h> /* For to_usb_interface for T100 touchpad intf check */
>>  #include <linux/power_supply.h>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 46e62feeda3c..8b827680754c 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -262,6 +262,18 @@ config ASUS_WIRELESS
>>  	  If you choose to compile this driver as a module the module will be
>>  	  called asus-wireless.
>>  
>> +config ASUS_ARMOURY
>> +	tristate "ASUS Armoury driver"
>> +	depends on ASUS_WMI
>> +	select FW_ATTR_CLASS
>> +	help
>> +	  Say Y here if you have a WMI aware Asus machine and would like to use the
>> +	  firmware_attributes API to control various settings typically exposed in
>> +	  the ASUS Armoury Crate application available on Windows.
>> +
>> +	  To compile this driver as a module, choose M here: the module will
>> +	  be called asus-armoury.
>> +
>>  config ASUS_WMI
>>  	tristate "ASUS WMI Driver"
>>  	depends on ACPI_WMI
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index c7db2a88c11a..4b1220f9b194 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -33,6 +33,7 @@ obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>>  # ASUS
>>  obj-$(CONFIG_ASUS_LAPTOP)	+= asus-laptop.o
>>  obj-$(CONFIG_ASUS_WIRELESS)	+= asus-wireless.o
>> +obj-$(CONFIG_ASUS_ARMOURY)	+= asus-armoury.o
>>  obj-$(CONFIG_ASUS_WMI)		+= asus-wmi.o
>>  obj-$(CONFIG_ASUS_NB_WMI)	+= asus-nb-wmi.o
>>  obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
>> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
>> new file mode 100644
>> index 000000000000..57ed9449ec5f
>> --- /dev/null
>> +++ b/drivers/platform/x86/asus-armoury.c
>> @@ -0,0 +1,545 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Asus Armoury (WMI) attributes driver.
>> + *
>> + * This driver uses the fw_attributes class to expose various WMI functions
>> + * that are present in many gaming and some non-gaming ASUS laptops.
>> + *
>> + * These typically don't fit anywhere else in the sysfs such as under LED class,
>> + * hwmon or others, and are set in Windows using the ASUS Armoury Crate tool.
>> + *
>> + * Copyright(C) 2024 Luke Jones <luke@ljones.dev>
>> + */
>> +
>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/device.h>
>> +#include <linux/dmi.h>
>> +#include <linux/errno.h>
>> +#include <linux/fs.h>
>> +#include <linux/kernel.h>
>> +#include <linux/kmod.h>
>> +#include <linux/kobject.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/platform_data/x86/asus-wmi.h>
>> +#include <linux/printk.h>
>> +#include <linux/types.h>
>> +
>> +#include "asus-armoury.h"
>> +#include "firmware_attributes_class.h"
>> +
>> +#define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
>> +
>> +#define ASUS_MINI_LED_MODE_MASK   0x03
> GENMASK() + add its include. Consider if _MASK is necessary as it doesn't 
> provide much value and results in just longer lines.
>
> BTW, before I go further, with my reviews there's no need to "ack" each 
> and every feedback item you're going to apply to your patches, I trust you 
> make those changes you don't contest. That way we can both save some time 
> by focusing on parts that need further discussion. :-)
unironically ack :)

I will mention things that change a fair bit of code or logic/runtime changes.

>> +/* Standard modes for devices with only on/off */
>> +#define ASUS_MINI_LED_OFF         0x00
>> +#define ASUS_MINI_LED_ON          0x01
>> +/* Like "on" but the effect is more vibrant or brighter */
>> +#define ASUS_MINI_LED_STRONG_MODE 0x02
>> +/* New modes for devices with 3 mini-led mode types */
>> +#define ASUS_MINI_LED_2024_WEAK   0x00
>> +#define ASUS_MINI_LED_2024_STRONG 0x01
>> +#define ASUS_MINI_LED_2024_OFF    0x02
>> +
>> +static struct asus_armoury_priv {
>> +	struct device *fw_attr_dev;
>> +	struct kset *fw_attr_kset;
>> +
>> +	u32 mini_led_dev_id;
>> +	u32 gpu_mux_dev_id;
>> +} asus_armoury;
> I suggest put this to own line:
>
> static struct asus_armoury_priv asus_armoury;
>
> ...as the current arrangement awkwardly separates things far away (e.g. 
> the "static").
>
>> +struct fw_attrs_group {
>> +	bool pending_reboot;
>> +};
>> +
>> +static struct fw_attrs_group fw_attrs = {
>> +	.pending_reboot = false,
>> +};
>> +
>> +struct asus_attr_group {
>> +	const struct attribute_group *attr_group;
>> +	u32 wmi_devid;
>> +};
>> +
>> +static bool asus_wmi_is_present(u32 dev_id)
>> +{
>> +	u32 retval;
>> +	int status;
>> +
>> +	status = asus_wmi_evaluate_method(ASUS_WMI_METHODID_DSTS, dev_id, 0, &retval);
>> +	pr_debug("%s called (0x%08x), retval: 0x%08x\n", __func__, dev_id, retval);
>> +
>> +	return status == 0 && (retval & ASUS_WMI_DSTS_PRESENCE_BIT);
>> +}
>> +
>> +static void asus_set_reboot_and_signal_event(void)
>> +{
>> +	fw_attrs.pending_reboot = true;
>> +	kobject_uevent(&asus_armoury.fw_attr_dev->kobj, KOBJ_CHANGE);
>> +}
>> +
>> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
>> +{
>> +	return sysfs_emit(buf, "%d\n", fw_attrs.pending_reboot);
> Add include.
>
>> +}
>> +
>> +static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
>> +
>> +static bool asus_bios_requires_reboot(struct kobj_attribute *attr)
>> +{
>> +	return !strcmp(attr->attr.name, "gpu_mux_mode");
>> +}
>> +
>> +static int armoury_wmi_set_devstate(struct kobj_attribute *attr, u32 value, u32 wmi_dev)
>> +{
>> +	u32 result;
>> +	int err;
>> +
>> +	err = asus_wmi_set_devstate(wmi_dev, value, &result);
>> +	if (err) {
>> +		pr_err("Failed to set %s: %d\n", attr->attr.name, err);
>> +		return err;
>> +	}
>> +	/*
>> +	 * !1 is usually considered a fail by ASUS, but some WMI methods do use > 1
>> +	 * to return a status code or similar.
>> +	 */
>> +	if (result < 1) {
> == 0 ?
>
>> +		pr_err("Failed to set %s: (result): 0x%x\n", attr->attr.name, result);
>> +		return -EIO;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * attr_uint_store() - Send an uint to wmi method, checks if within min/max exclusive.
>> + * @kobj: Pointer to the driver object.
>> + * @attr: Pointer to the attribute calling this function.
>> + * @buf: The buffer to read from, this is parsed to `uint` type.
>> + * @count: Required by sysfs attribute macros, pass in from the callee attr.
>> + * @min: Minimum accepted value. Below this returns -EINVAL.
>> + * @max: Maximum accepted value. Above this returns -EINVAL.
>> + * @store_value: Pointer to where the parsed value should be stored.
>> + * @wmi_dev: The WMI function ID to use.
>> + *
>> + * This function is intended to be generic so it can be called from any "_store"
>> + * attribute which works only with integers. The integer to be sent to the WMI method
>> + * is range checked and an error returned if out of range.
>> + *
>> + * If the value is valid and WMI is success, then the sysfs attribute is notified
>> + * and if asus_bios_requires_reboot() is true then reboot attribute is also notified.
> In general, please fold comment text to 80 characters as it's easier to 
> read shorter lines of text (long lines do require eye movement).
>
> Also note this 80 character limits is only meant for comments, in code 
> exceeding 80 is fine where it makes sense.
>
>> + *
>> + * Returns: Either count, or an error.
>> + */
>> +static ssize_t attr_uint_store(struct kobject *kobj, struct kobj_attribute *attr, const char *buf,
>> +			      size_t count, u32 min, u32 max, u32 *store_value, u32 wmi_dev)
>> +{
>> +	u32 value;
>> +	int err;
>> +
>> +	err = kstrtouint(buf, 10, &value);
>> +	if (err)
>> +		return err;
>> +
>> +	if (value < min || value > max)
>> +		return -EINVAL;
>> +
>> +	err = armoury_wmi_set_devstate(attr, value, wmi_dev);
>> +	if (err)
>> +		return err;
>> +
>> +	if (store_value != NULL)
>> +		*store_value = value;
>> +	sysfs_notify(kobj, NULL, attr->attr.name);
>> +
>> +	if (asus_bios_requires_reboot(attr))
>> +		asus_set_reboot_and_signal_event();
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t enum_type_show(struct kobject *kobj, struct kobj_attribute *attr,
>> +			      char *buf)
>> +{
>> +	return sysfs_emit(buf, "enumeration\n");
>> +}
>> +
>> +/* Mini-LED mode **************************************************************/
>> +static ssize_t mini_led_mode_current_value_show(struct kobject *kobj,
>> +						struct kobj_attribute *attr, char *buf)
>> +{
>> +	u32 value;
>> +	int err;
>> +
>> +	err = asus_wmi_get_devstate_dsts(asus_armoury.mini_led_dev_id, &value);
>> +	if (err)
>> +		return err;
>> +
>> +	value &= ASUS_MINI_LED_MODE_MASK;
> FIELD_GET() (mainly for consistency as shift is 0 here anyway)
>
>> +
>> +	/*
>> +	 * Remap the mode values to match previous generation mini-LED. The last gen
>> +	 * WMI 0 == off, while on this version WMI 2 == off (flipped).
>> +	 */
>> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
>> +		switch (value) {
>> +		case ASUS_MINI_LED_2024_WEAK:
>> +			value = ASUS_MINI_LED_ON;
>> +			break;
>> +		case ASUS_MINI_LED_2024_STRONG:
>> +			value = ASUS_MINI_LED_STRONG_MODE;
>> +			break;
>> +		case ASUS_MINI_LED_2024_OFF:
>> +			value = ASUS_MINI_LED_OFF;
>> +			break;
>> +		}
>> +	}
>> +
>> +	return sysfs_emit(buf, "%u\n", value);
>> +}
>> +
>> +static ssize_t mini_led_mode_current_value_store(struct kobject *kobj,
>> +						 struct kobj_attribute *attr,
>> +						const char *buf, size_t count)
>> +{
>> +	u32 mode;
>> +	int err;
>> +
>> +	err = kstrtou32(buf, 10, &mode);
>> +	if (err)
>> +		return err;
>> +
>> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE &&
>> +	    mode > ASUS_MINI_LED_ON)
>> +		return -EINVAL;
>> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2 &&
>> +	    mode > ASUS_MINI_LED_STRONG_MODE)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Remap the mode values so expected behaviour is the same as the last
>> +	 * generation of mini-LED with 0 == off, 1 == on.
>> +	 */
>> +	if (asus_armoury.mini_led_dev_id == ASUS_WMI_DEVID_MINI_LED_MODE2) {
>> +		switch (mode) {
>> +		case ASUS_MINI_LED_OFF:
>> +			mode = ASUS_MINI_LED_2024_OFF;
>> +			break;
>> +		case ASUS_MINI_LED_ON:
>> +			mode = ASUS_MINI_LED_2024_WEAK;
>> +			break;
>> +		case ASUS_MINI_LED_STRONG_MODE:
>> +			mode = ASUS_MINI_LED_2024_STRONG;
>> +			break;
>> +		}
>> +	}
> Combine these into a single switch/case.
>
>> +
>> +	err = armoury_wmi_set_devstate(attr, mode, asus_armoury.mini_led_dev_id);
>> +	if (err)
>> +		return err;
>> +
>> +	sysfs_notify(kobj, NULL, attr->attr.name);
>> +
>> +	return count;
>> +}
>> +
>> +static ssize_t mini_led_mode_possible_values_show(struct kobject *kobj,
>> +						  struct kobj_attribute *attr, char *buf)
>> +{
>> +	switch (asus_armoury.mini_led_dev_id) {
>> +	case ASUS_WMI_DEVID_MINI_LED_MODE:
>> +		return sysfs_emit(buf, "0;1\n");
>> +	case ASUS_WMI_DEVID_MINI_LED_MODE2:
>> +		return sysfs_emit(buf, "0;1;2\n");
>> +	default:
>> +		return -ENODEV;
>> +	}
>> +}
>> +
>> +ATTR_GROUP_ENUM_CUSTOM(mini_led_mode, "mini_led_mode", "Set the mini-LED backlight mode");
> Remove the empty line before this.
>
> I'm little worried about using such a generic names in macros specific 
> to this driver. Maybe the use of "CUSTOM" will save you from collisions 
> but a prefix also helps when reading code to know what is driver specific 
> and what is provided by the core. Maybe changing it to:
>
> I think ASUS_ATTR_GROUP_ENUM() already indicates it's "custom" thing, I 
> don't know to which aspect the customness exactly tries to refer to in 
> this macro.
>
>> +static ssize_t gpu_mux_mode_current_value_store(struct kobject *kobj,
>> +						struct kobj_attribute *attr, const char *buf,
>> +						size_t count)
>> +{
>> +	int result, err;
>> +	u32 optimus;
>> +
>> +	err = kstrtou32(buf, 10, &optimus);
> Why the other function used kstrtouint and this kstrtou32 ?? Please check 
> all these.
>
>> +	if (err)
>> +		return err;
>> +
>> +	if (optimus > 1)
>> +		return -EINVAL;
>> +
>> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_DGPU)) {
>> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_DGPU, &result);
>> +		if (err)
>> +			return err;
>> +		if (result && !optimus) {
>> +			pr_warn("Can not switch MUX to dGPU mode when dGPU is disabled: %02X %02X\n",
>> +				result, optimus);
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_EGPU)) {
>> +		err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU, &result);
>> +		if (err)
>> +			return err;
>> +		if (result && !optimus) {
>> +			pr_warn("Can not switch MUX to dGPU mode when eGPU is enabled\n");
>> +			return -EBUSY;
>> +		}
>> +	}
>> +
>> +	err = armoury_wmi_set_devstate(attr, optimus, asus_armoury.gpu_mux_dev_id);
>> +	if (err)
>> +		return err;
>> +
>> +	sysfs_notify(kobj, NULL, attr->attr.name);
>> +	asus_set_reboot_and_signal_event();
>> +
>> +	return count;
>> +}
>> +WMI_SHOW_INT(gpu_mux_mode_current_value, "%u\n", asus_armoury.gpu_mux_dev_id);
>> +ATTR_GROUP_BOOL_CUSTOM(gpu_mux_mode, "gpu_mux_mode", "Set the GPU display MUX mode");
>> +
>> +/*
>> + * A user may be required to store the value twice, typical store first, then
>> + * rescan PCI bus to activate power, then store a second time to save correctly.
> Could this be automated?
this can (have developed already) a way to automate this, including the pci rescan,
and it is what I was referring when I said "xg mobile" here:

https://lore.kernel.org/all/8128cd6b-50e3-464c-90c2-781f61c3963e@gmail.com/

that code has never been reviewed before and I was hoping to postpone it to avoid
holding back this series, but given the fact there is now a request for it and
that in this patch egpu can only be on/off (like a bool) but there are three distinct
ways to activate the egpu and I don't want to make this a bool or having to deal with
said property changing from bool to int later on I think I will blend in that other patch.

>
>> + */
>> +static ssize_t dgpu_disable_current_value_store(struct kobject *kobj,
>> +						struct kobj_attribute *attr, const char *buf,
>> +						size_t count)
>> +{
>> +	int result, err;
>> +	u32 disable;
>> +
>> +	err = kstrtou32(buf, 10, &disable);
>> +	if (err)
>> +		return err;
>> +
>> +	if (disable > 1)
> "disable" sounds like it is boolean for which there's kstrtobool ? 
> Also, I was not sure about optimus > 1 thing above if it too would 
> actually be bool.
basically see considerations in the previous paragraph.

The acpi can take in three different values to activate the xg mobile.
I think those corresponds to the three different xg mobile docks asus
has released over the years because for example nv_dynamic_boost
(and others) exposed via WMI can instead be used to control the egpu.

But one model was AMD and nv_dynamic_boost won't work on that,
hence the need to diversify commands used to activate the egpu
(an operation that can take about a minute) and also certain models
appears to have the physical bus (?) in common between the soldered
dgpu and the egpu, so here things gets difficult because those accessories
are hard to find (at least where I live), costs a fair amount of money and
are not common.

Samples of laptop+xgm I have seen are about 6 at most, so there is a
demand of having this working well, but little pool of device to extract
info from.

Most of what I know is pure observation, ACPI guesswork, testing one myself
(I have one at my disposal, but only one specific model) and trial and
errors with some user over a chat for the models I don't have.

>
>> +		return -EINVAL;
>> +
>> +	if (asus_armoury.gpu_mux_dev_id) {
>> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
>> +		if (err)
>> +			return err;
>> +		if (!result && disable) {
>> +			pr_warn("Can not disable dGPU when the MUX is in dGPU mode\n");
>> +			return -EBUSY;
>> +		}
>> +	}
>> +
>> +	err = armoury_wmi_set_devstate(attr, disable, ASUS_WMI_DEVID_DGPU);
>> +	if (err)
>> +		return err;
>> +
>> +	sysfs_notify(kobj, NULL, attr->attr.name);
>> +
>> +	return count;
>> +}
>> +WMI_SHOW_INT(dgpu_disable_current_value, "%d\n", ASUS_WMI_DEVID_DGPU);
> ASUS_WMI_SHOW_INT()
>
>> +ATTR_GROUP_BOOL_CUSTOM(dgpu_disable, "dgpu_disable", "Disable the dGPU");
>> +
>> +/* The ACPI call to enable the eGPU also disables the internal dGPU */
>> +static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
>> +					       const char *buf, size_t count)
>> +{
>> +	int result, err;
>> +	u32 enable;
>> +
>> +	err = kstrtou32(buf, 10, &enable);
>> +	if (err)
>> +		return err;
>> +
>> +	if (enable > 1)
> kstrtobool() ?
>
>> +		return -EINVAL;
>> +
>> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_EGPU_CONNECTED, &result);
>> +	if (err) {
>> +		pr_warn("Failed to get eGPU connection status: %d\n", err);
>> +		return err;
>> +	}
>> +
>> +	if (asus_armoury.gpu_mux_dev_id) {
>> +		err = asus_wmi_get_devstate_dsts(asus_armoury.gpu_mux_dev_id, &result);
>> +		if (err) {
>> +			pr_warn("Failed to get GPU MUX status: %d\n", result);
>> +			return err;
>> +		}
>> +		if (!result && enable) {
>> +			pr_warn("Can not enable eGPU when the MUX is in dGPU mode\n");
>> +			return -ENODEV;
>> +		}
>> +	}
>> +
>> +	err = armoury_wmi_set_devstate(attr, enable, ASUS_WMI_DEVID_EGPU);
>> +	if (err)
>> +		return err;
>> +
>> +	sysfs_notify(kobj, NULL, attr->attr.name);
>> +
>> +	return count;
>> +}
>> +WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
>> +ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
>> +
>> +/* Simple attribute creation */
>> +ATTR_GROUP_ENUM_INT_RO(charge_mode, "charge_mode", ASUS_WMI_DEVID_CHARGE_MODE, "0;1;2",
>> +		       "Show the current mode of charging");
>> +
>> +ATTR_GROUP_BOOL_RW(boot_sound, "boot_sound", ASUS_WMI_DEVID_BOOT_SOUND,
>> +		   "Set the boot POST sound");
>> +ATTR_GROUP_BOOL_RW(mcu_powersave, "mcu_powersave", ASUS_WMI_DEVID_MCU_POWERSAVE,
>> +		   "Set MCU powersaving mode");
>> +ATTR_GROUP_BOOL_RW(panel_od, "panel_overdrive", ASUS_WMI_DEVID_PANEL_OD,
>> +		   "Set the panel refresh overdrive");
>> +ATTR_GROUP_BOOL_RO(egpu_connected, "egpu_connected", ASUS_WMI_DEVID_EGPU_CONNECTED,
>> +		   "Show the eGPU connection status");
>> +
>> +/* If an attribute does not require any special case handling add it here */
>> +static const struct asus_attr_group armoury_attr_groups[] = {
>> +	{ &egpu_connected_attr_group, ASUS_WMI_DEVID_EGPU_CONNECTED },
>> +	{ &egpu_enable_attr_group, ASUS_WMI_DEVID_EGPU },
>> +	{ &dgpu_disable_attr_group, ASUS_WMI_DEVID_DGPU },
>> +
>> +	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>> +	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
>> +	{ &mcu_powersave_attr_group, ASUS_WMI_DEVID_MCU_POWERSAVE },
>> +	{ &panel_od_attr_group, ASUS_WMI_DEVID_PANEL_OD },
>> +};
>> +
>> +static int asus_fw_attr_add(void)
>> +{
>> +	int err, i;
>> +
>> +	asus_armoury.fw_attr_dev = device_create(&firmware_attributes_class, NULL, MKDEV(0, 0),
>> +						NULL, "%s", DRIVER_NAME);
>> +	if (IS_ERR(asus_armoury.fw_attr_dev)) {
> Add include.
>
>> +		err = PTR_ERR(asus_armoury.fw_attr_dev);
>> +		goto fail_class_get;
>> +	}
>> +
>> +	asus_armoury.fw_attr_kset = kset_create_and_add("attributes", NULL,
>> +						&asus_armoury.fw_attr_dev->kobj);
>> +	if (!asus_armoury.fw_attr_kset) {
>> +		err = -ENOMEM;
>> +		goto err_destroy_classdev;
>> +	}
>> +
>> +	err = sysfs_create_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
>> +	if (err) {
>> +		pr_err("Failed to create sysfs level attributes\n");
>> +		goto err_destroy_kset;
>> +	}
>> +
>> +	asus_armoury.mini_led_dev_id = 0;
>> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE))
>> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE;
>> +	else if (asus_wmi_is_present(ASUS_WMI_DEVID_MINI_LED_MODE2))
>> +		asus_armoury.mini_led_dev_id = ASUS_WMI_DEVID_MINI_LED_MODE2;
>> +
>> +	if (asus_armoury.mini_led_dev_id) {
>> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> +					 &mini_led_mode_attr_group);
>> +		if (err) {
>> +			pr_err("Failed to create sysfs-group for mini_led\n");
>> +			goto err_remove_file;
>> +		}
>> +	}
>> +
>> +	asus_armoury.gpu_mux_dev_id = 0;
>> +	if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX))
>> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX;
>> +	else if (asus_wmi_is_present(ASUS_WMI_DEVID_GPU_MUX_VIVO))
>> +		asus_armoury.gpu_mux_dev_id = ASUS_WMI_DEVID_GPU_MUX_VIVO;
>> +
>> +	if (asus_armoury.gpu_mux_dev_id) {
>> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> +					 &gpu_mux_mode_attr_group);
>> +		if (err) {
>> +			pr_err("Failed to create sysfs-group for gpu_mux\n");
>> +			goto err_remove_mini_led_group;
>> +		}
>> +	}
>> +
>> +	for (i = 0; i < ARRAY_SIZE(armoury_attr_groups); i++) {
>> +		if (!asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>> +			continue;
>> +
>> +		err = sysfs_create_group(&asus_armoury.fw_attr_kset->kobj,
>> +					 armoury_attr_groups[i].attr_group);
>> +		if (err) {
>> +			pr_err("Failed to create sysfs-group for %s\n",
>> +			       armoury_attr_groups[i].attr_group->name);
>> +			goto err_remove_groups;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +err_remove_groups:
>> +	while (i--) {
>> +		if (asus_wmi_is_present(armoury_attr_groups[i].wmi_devid))
>> +			sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj,
>> +					   armoury_attr_groups[i].attr_group);
>> +	}
>> +	if (asus_armoury.gpu_mux_dev_id)
>> +		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &gpu_mux_mode_attr_group);
>> +err_remove_mini_led_group:
>> +	if (asus_armoury.mini_led_dev_id)
>> +		sysfs_remove_group(&asus_armoury.fw_attr_kset->kobj, &mini_led_mode_attr_group);
>> +err_remove_file:
>> +	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
>> +err_destroy_kset:
>> +	kset_unregister(asus_armoury.fw_attr_kset);
>> +err_destroy_classdev:
>> +fail_class_get:
>> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
>> +	return err;
>> +}
>> +
>> +/* Init / exit ****************************************************************/
>> +
>> +static int __init asus_fw_init(void)
>> +{
>> +	char *wmi_uid;
>> +
>> +	wmi_uid = wmi_get_acpi_device_uid(ASUS_WMI_MGMT_GUID);
>> +	if (!wmi_uid)
>> +		return -ENODEV;
>> +
>> +	/*
>> +	 * if equal to "ASUSWMI" then it's DCTS that can't be used for this
>> +	 * driver, DSTS is required.
>> +	 */
>> +	if (!strcmp(wmi_uid, ASUS_ACPI_UID_ASUSWMI))
>> +		return -ENODEV;
>> +
>> +	return asus_fw_attr_add();
>> +}
>> +
>> +static void __exit asus_fw_exit(void)
>> +{
>> +	sysfs_remove_file(&asus_armoury.fw_attr_kset->kobj, &pending_reboot.attr);
> Why does the rollback path in asus_fw_attr_add() differ from these?
I don't see and am not aware of any particular reason.

From what I can gather every added sysfs attribute had its own rollback
because on previous iterations the flow to loading certain attributes
and rolling back (without failing) was different from how it is now.

It is my understanding that kset_unregister will unregister the whole
set of registered sysfs, so I guess I can issue just one kset_unregister
in a single err_sysfs_attr and avoid mentioning specific sysfs one by one,
correct?

>> +	kset_unregister(asus_armoury.fw_attr_kset);
>> +	device_destroy(&firmware_attributes_class, MKDEV(0, 0));
>> +}
>> +
>> +module_init(asus_fw_init);
>> +module_exit(asus_fw_exit);
>> +
>> +MODULE_IMPORT_NS("ASUS_WMI");
>> +MODULE_AUTHOR("Luke Jones <luke@ljones.dev>");
>> +MODULE_DESCRIPTION("ASUS BIOS Configuration Driver");
>> +MODULE_LICENSE("GPL");
>> +MODULE_ALIAS("wmi:" ASUS_NB_WMI_EVENT_GUID);
>> diff --git a/drivers/platform/x86/asus-armoury.h b/drivers/platform/x86/asus-armoury.h
>> new file mode 100644
>> index 000000000000..61675e7b5a60
>> --- /dev/null
>> +++ b/drivers/platform/x86/asus-armoury.h
>> @@ -0,0 +1,164 @@
>> +/* SPDX-License-Identifier: GPL-2.0
>> + *
>> + * Definitions for kernel modules using asus-armoury driver
>> + *
>> + *  Copyright (c) 2024 Luke Jones <luke@ljones.dev>
>> + */
>> +
>> +#ifndef _ASUS_ARMOURY_H_
>> +#define _ASUS_ARMOURY_H_
>> +
>> +#include <linux/types.h>
>> +#include <linux/platform_device.h>
>> +
>> +#define DRIVER_NAME "asus-armoury"
>> +
>> +#define __ASUS_ATTR_RO(_func, _name)					\
>> +	{								\
>> +		.attr = { .name = __stringify(_name), .mode = 0444 },	\
>> +		.show = _func##_##_name##_show,				\
>> +	}
>> +
>> +#define __ASUS_ATTR_RO_AS(_name, _show)					\
>> +	{								\
>> +		.attr = { .name = __stringify(_name), .mode = 0444 },	\
>> +		.show = _show,						\
>> +	}
>> +
>> +#define __ASUS_ATTR_RW(_func, _name) \
>> +	__ATTR(_name, 0644, _func##_##_name##_show, _func##_##_name##_store)
>> +
>> +#define __WMI_STORE_INT(_attr, _min, _max, _wmi)			\
>> +	static ssize_t _attr##_store(struct kobject *kobj,		\
>> +				     struct kobj_attribute *attr,	\
>> +				     const char *buf, size_t count)	\
>> +	{								\
>> +		return attr_uint_store(kobj, attr, buf, count, _min,	\
>> +					_max, NULL, _wmi);		\
>> +	}
>> +
>> +#define WMI_SHOW_INT(_attr, _fmt, _wmi)						\
>> +	static ssize_t _attr##_show(struct kobject *kobj,			\
>> +				    struct kobj_attribute *attr, char *buf)	\
>> +	{									\
>> +		u32 result;							\
>> +		int err;							\
>> +										\
>> +		err = asus_wmi_get_devstate_dsts(_wmi, &result);		\
>> +		if (err)							\
>> +			return err;						\
>> +		return sysfs_emit(buf, _fmt,					\
>> +				  result & ~ASUS_WMI_DSTS_PRESENCE_BIT);	\
>> +	}
>> +
>> +/* Create functions and attributes for use in other macros or on their own */
>> +
>> +/* Shows a formatted static variable */
>> +#define __ATTR_SHOW_FMT(_prop, _attrname, _fmt, _val)				\
>> +	static ssize_t _attrname##_##_prop##_show(				\
>> +		struct kobject *kobj, struct kobj_attribute *attr, char *buf)	\
>> +	{									\
>> +		return sysfs_emit(buf, _fmt, _val);				\
>> +	}									\
>> +	static struct kobj_attribute attr_##_attrname##_##_prop =		\
>> +		__ASUS_ATTR_RO(_attrname, _prop)
>> +
>> +#define __ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)\
>> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);			\
>> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
>> +		__ASUS_ATTR_RO(_attrname, current_value);			\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
>> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);		\
>> +	static struct kobj_attribute attr_##_attrname##_type =			\
>> +		__ASUS_ATTR_RO_AS(type, enum_type_show);			\
>> +	static struct attribute *_attrname##_attrs[] = {			\
>> +		&attr_##_attrname##_current_value.attr,				\
>> +		&attr_##_attrname##_display_name.attr,				\
>> +		&attr_##_attrname##_possible_values.attr,			\
>> +		&attr_##_attrname##_type.attr,					\
>> +		NULL								\
>> +	};									\
>> +	static const struct attribute_group _attrname##_attr_group = {		\
>> +		.name = _fsname, .attrs = _attrname##_attrs			\
>> +	}
>> +
>> +#define __ATTR_RW_INT_GROUP_ENUM(_attrname, _minv, _maxv, _wmi, _fsname,\
>> +				 _possible, _dispname)			\
>> +	__WMI_STORE_INT(_attrname##_current_value, _minv, _maxv, _wmi);	\
>> +	WMI_SHOW_INT(_attrname##_current_value, "%d\n", _wmi);		\
>> +	static struct kobj_attribute attr_##_attrname##_current_value =	\
>> +		__ASUS_ATTR_RW(_attrname, current_value);		\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
>> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);	\
>> +	static struct kobj_attribute attr_##_attrname##_type =		\
>> +		__ASUS_ATTR_RO_AS(type, enum_type_show);		\
>> +	static struct attribute *_attrname##_attrs[] = {		\
>> +		&attr_##_attrname##_current_value.attr,			\
>> +		&attr_##_attrname##_display_name.attr,			\
>> +		&attr_##_attrname##_possible_values.attr,		\
>> +		&attr_##_attrname##_type.attr,				\
>> +		NULL							\
>> +	};								\
>> +	static const struct attribute_group _attrname##_attr_group = {	\
>> +		.name = _fsname, .attrs = _attrname##_attrs		\
>> +	}
>> +
>> +/* Boolean style enumeration, base macro. Requires adding show/store */
>> +#define __ATTR_GROUP_ENUM(_attrname, _fsname, _possible, _dispname)	\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);	\
>> +	__ATTR_SHOW_FMT(possible_values, _attrname, "%s\n", _possible);	\
>> +	static struct kobj_attribute attr_##_attrname##_type =		\
>> +		__ASUS_ATTR_RO_AS(type, enum_type_show);		\
>> +	static struct attribute *_attrname##_attrs[] = {		\
>> +		&attr_##_attrname##_current_value.attr,			\
>> +		&attr_##_attrname##_display_name.attr,			\
>> +		&attr_##_attrname##_possible_values.attr,		\
>> +		&attr_##_attrname##_type.attr,				\
>> +		NULL							\
>> +	};								\
>> +	static const struct attribute_group _attrname##_attr_group = {	\
>> +		.name = _fsname, .attrs = _attrname##_attrs		\
>> +	}
>> +
>> +#define ATTR_GROUP_BOOL_RO(_attrname, _fsname, _wmi, _dispname)	\
>> +	__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, "0;1", _dispname)
>> +
>> +
>> +#define ATTR_GROUP_BOOL_RW(_attrname, _fsname, _wmi, _dispname)	\
>> +	__ATTR_RW_INT_GROUP_ENUM(_attrname, 0, 1, _wmi, _fsname, "0;1", _dispname)
>> +
>> +#define ATTR_GROUP_ENUM_INT_RO(_attrname, _fsname, _wmi, _possible, _dispname)	\
>> +	__ATTR_RO_INT_GROUP_ENUM(_attrname, _wmi, _fsname, _possible, _dispname)
>> +
>> +/*
>> + * Requires <name>_current_value_show(), <name>_current_value_show()
>> + */
>> +#define ATTR_GROUP_BOOL_CUSTOM(_attrname, _fsname, _dispname)		\
>> +	static struct kobj_attribute attr_##_attrname##_current_value =	\
>> +		__ASUS_ATTR_RW(_attrname, current_value);		\
>> +	__ATTR_GROUP_ENUM(_attrname, _fsname, "0;1", _dispname)
>> +
>> +/*
>> + * Requires <name>_current_value_show(), <name>_current_value_show()
>> + * and <name>_possible_values_show()
>> + */
>> +#define ATTR_GROUP_ENUM_CUSTOM(_attrname, _fsname, _dispname)			\
>> +	__ATTR_SHOW_FMT(display_name, _attrname, "%s\n", _dispname);		\
>> +	static struct kobj_attribute attr_##_attrname##_current_value =		\
>> +		__ASUS_ATTR_RW(_attrname, current_value);			\
>> +	static struct kobj_attribute attr_##_attrname##_possible_values =	\
>> +		__ASUS_ATTR_RO(_attrname, possible_values);			\
>> +	static struct kobj_attribute attr_##_attrname##_type =			\
>> +		__ASUS_ATTR_RO_AS(type, enum_type_show);			\
>> +	static struct attribute *_attrname##_attrs[] = {			\
>> +		&attr_##_attrname##_current_value.attr,				\
>> +		&attr_##_attrname##_display_name.attr,				\
>> +		&attr_##_attrname##_possible_values.attr,			\
>> +		&attr_##_attrname##_type.attr,					\
>> +		NULL								\
>> +	};									\
>> +	static const struct attribute_group _attrname##_attr_group = {		\
>> +		.name = _fsname, .attrs = _attrname##_attrs			\
>> +	}
>> +
>> +#endif /* _ASUS_ARMOURY_H_ */
>> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>> index 38ab5306e05a..0d0c84a37ad8 100644
>> --- a/drivers/platform/x86/asus-wmi.c
>> +++ b/drivers/platform/x86/asus-wmi.c
>> @@ -30,6 +30,7 @@
>>  #include <linux/pci.h>
>>  #include <linux/pci_hotplug.h>
>>  #include <linux/platform_data/x86/asus-wmi.h>
>> +#include <linux/platform_data/x86/asus-wmi-leds-ids.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/platform_profile.h>
>>  #include <linux/power_supply.h>
>> @@ -55,8 +56,6 @@ module_param(fnlock_default, bool, 0444);
>>  #define to_asus_wmi_driver(pdrv)					\
>>  	(container_of((pdrv), struct asus_wmi_driver, platform_driver))
>>  
>> -#define ASUS_WMI_MGMT_GUID	"97845ED0-4E6D-11DE-8A39-0800200C9A66"
>> -
>>  #define NOTIFY_BRNUP_MIN		0x11
>>  #define NOTIFY_BRNUP_MAX		0x1f
>>  #define NOTIFY_BRNDOWN_MIN		0x20
>> @@ -105,8 +104,6 @@ module_param(fnlock_default, bool, 0444);
>>  #define USB_INTEL_XUSB2PR		0xD0
>>  #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI	0x9c31
>>  
>> -#define ASUS_ACPI_UID_ASUSWMI		"ASUSWMI"
>> -
>>  #define WMI_EVENT_MASK			0xFFFF
>>  
>>  #define FAN_CURVE_POINTS		8
>> diff --git a/include/linux/platform_data/x86/asus-wmi-leds-ids.h b/include/linux/platform_data/x86/asus-wmi-leds-ids.h
>> new file mode 100644
>> index 000000000000..281b98ba0ca7
>> --- /dev/null
>> +++ b/include/linux/platform_data/x86/asus-wmi-leds-ids.h
>> @@ -0,0 +1,50 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
>> +#define __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H
>> +
>> +#include <linux/types.h>
> Unnecessary, AFAICT.
>
>> +#include <linux/dmi.h>
>> +
>> +/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
>> +#if IS_REACHABLE(CONFIG_ASUS_WMI) || IS_REACHABLE(CONFIG_HID_ASUS)
>> +static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
> Are you aware that by placing this into a header file it ends up 
> getting duplicated to anything including this file? I suppose there's no 
> good way around it without some pretty complex trickery and it doesn't 
> look very large so I guess we can leave it here for now.
I am well aware given the fact I had to move around that table to avoid
compiler warnings with certain configurations and it took me two revisions
to make those go away.

Luckily for us if the hid-asus patchset from Antheas [1] will work without
surprises across all affected ASUS hardware this table will get removed,
and honestly that would make me quite happy. 

[1] https://lore.kernel.org/all/20251015014736.1402045-1-benato.denis96@gmail.com/

>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
>> +		},
>> +	},
>> +	{
>> +		.matches = {
>> +			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
>> +		},
>> +	},
>> +	{ },
>> +};
>> +#endif
>> +
>> +#endif	/* __PLATFORM_DATA_X86_ASUS_WMI_LEDS_IDS_H */
>> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
>> index dbd44d9fbb6f..71c68425b3b9 100644
>> --- a/include/linux/platform_data/x86/asus-wmi.h
>> +++ b/include/linux/platform_data/x86/asus-wmi.h
>> @@ -6,6 +6,9 @@
>>  #include <linux/types.h>
>>  #include <linux/dmi.h>
>>  
>> +#define ASUS_WMI_MGMT_GUID	"97845ED0-4E6D-11DE-8A39-0800200C9A66"
>> +#define ASUS_ACPI_UID_ASUSWMI	"ASUSWMI"
>> +
>>  /* WMI Methods */
>>  #define ASUS_WMI_METHODID_SPEC	        0x43455053 /* BIOS SPECification */
>>  #define ASUS_WMI_METHODID_SFBD		0x44424653 /* Set First Boot Device */
>> @@ -191,44 +194,4 @@ static inline int asus_wmi_evaluate_method(u32 method_id, u32 arg0, u32 arg1,
>>  }
>>  #endif
>>  
>> -/* To be used by both hid-asus and asus-wmi to determine which controls kbd_brightness */
>> -static const struct dmi_system_id asus_use_hid_led_dmi_ids[] = {
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Zephyrus"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Strix"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_PRODUCT_FAMILY, "ROG Flow"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_PRODUCT_FAMILY, "ProArt P16"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_BOARD_NAME, "GA403U"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_BOARD_NAME, "GU605M"),
>> -		},
>> -	},
>> -	{
>> -		.matches = {
>> -			DMI_MATCH(DMI_BOARD_NAME, "RC71L"),
>> -		},
>> -	},
>> -	{ },
>> -};
>> -
>>  #endif	/* __PLATFORM_DATA_X86_ASUS_WMI_H */
>>
> I don't have more time for further reviews.
>
The xgm new code will need a review. I am pretty new to all of this
and I need guidance: I have gone from average user to maintainer in
about three years and therefore don't have much experience.

Thanks for your time and understanding,
Denis

