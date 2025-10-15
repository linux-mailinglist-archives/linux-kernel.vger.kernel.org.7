Return-Path: <linux-kernel+bounces-854122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E049BDD988
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 11:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DAC3E256D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3043090D7;
	Wed, 15 Oct 2025 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jcc7Wkw0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E770A30648B;
	Wed, 15 Oct 2025 09:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760519074; cv=none; b=rM5VmNbqdX4l6aRMS6115Qwcp7HXIyiR7/X2hMFaPN9jw3tpvUFQ8KDVrSlKYpdiIPA31rolXDBcwUdP5RYu28s23gQGIzmlgAm460yqLASOwO/nF9u6/FfYI27xYMP6oYHJ5/CQjmPLHztCls+2Hac4/vT8wcsvUz+kSP7ENMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760519074; c=relaxed/simple;
	bh=d++6MHwAGD+KgVnZhjSK1AbYBSvKbkEvvbW38OEJCxY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=us30QDzPDrKogGcFU+ANsh+xk83RvmQ6brIDpEbefjowgIkp67g/b3rAX9D8nYcb8finBXE4wKkpovHD8xQXjh7JEMWwHnOE/pmHSTQ3NAknNWEYBDMyIXL0YG5XTatmR8uwf1GZ8lpBnTiGxOANhrSJtYDbNTgjUmcZCKKQdVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jcc7Wkw0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760519073; x=1792055073;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d++6MHwAGD+KgVnZhjSK1AbYBSvKbkEvvbW38OEJCxY=;
  b=jcc7Wkw0ZZfA9c/lVR9KrBtkM26kFoptW6Hpz5NwTUWkh0GnIQzRe9jw
   1ARtSife/NQ4VGaYpnx0tQuQLEjYBd99Hji0O8xBwZmAi4HXFsghba7t6
   vOgFE4jqAwLX3fhsv8CtIgoQiQy1aFsYvjQ4rn7Y7WsxjWIIIUiinybDh
   JLc4wMFUnqHk0PSg9R3P6YffgESzHlMI1bD9LBq2qzzXw3NXV1Lcqu/k2
   gHDuyEQ1bK0pQmcbXtsVGaDGxxkuS6CqUjowDM1CaS/53BCc8xQz290Ck
   jmM/Bics806AptRXSBCewTH8tRm2FbLXAwcUg1Jh6HJmA9DMIQZZXOIsK
   Q==;
X-CSE-ConnectionGUID: /PxpKfeaTUu8jH+1C9iXAg==
X-CSE-MsgGUID: CfiW6VKjT6CL6sJueI34ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="65309693"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="65309693"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:04:32 -0700
X-CSE-ConnectionGUID: Spi6wYbmRB+UM9OD5M+Vwg==
X-CSE-MsgGUID: 2+FjcwEMT9iDp0o82bIUjw==
X-ExtLoop1: 1
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.75])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 02:04:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 15 Oct 2025 12:04:24 +0300 (EEST)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
In-Reply-To: <20251015084414.1391595-2-lkml@antheas.dev>
Message-ID: <d909afef-a47b-83c9-b935-f5b06034fcab@linux.intel.com>
References: <20251015084414.1391595-1-lkml@antheas.dev> <20251015084414.1391595-2-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 15 Oct 2025, Antheas Kapenekakis wrote:

> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
> with standard addresses across models that provides access to fan
> speed, fan control, battery charge limits, and controller power
> controls. Introduce a new driver stub that will handle these driver
> features.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  MAINTAINERS                      |  6 +++
>  drivers/platform/x86/Kconfig     | 10 ++++
>  drivers/platform/x86/Makefile    |  3 ++
>  drivers/platform/x86/ayaneo-ec.c | 89 ++++++++++++++++++++++++++++++++
>  4 files changed, 108 insertions(+)
>  create mode 100644 drivers/platform/x86/ayaneo-ec.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 46126ce2f968..8c4d0c26ca77 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4187,6 +4187,12 @@ W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/devicetree/bindings/pwm/adi,axi-pwmgen.yaml
>  F:	drivers/pwm/pwm-axi-pwmgen.c
>  
> +AYANEO PLATFORM EC DRIVER
> +M:	Antheas Kapenekakis <lkml@antheas.dev>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/ayaneo-ec.c
> +
>  AZ6007 DVB DRIVER
>  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 46e62feeda3c..ff2678927696 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -316,6 +316,16 @@ config ASUS_TF103C_DOCK
>  	  If you have an Asus TF103C tablet say Y or M here, for a generic x86
>  	  distro config say M here.
>  
> +config AYANEO_EC
> +	tristate "Ayaneo EC platform control"
> +	depends on X86
> +	help
> +	  Enables support for the platform EC of Ayaneo devices. This
> +	  includes fan control, fan speed, charge limit, magic
> +	  module detection, and controller power control.
> +
> +	  If you have an Ayaneo device, say Y or M here.
> +
>  config MERAKI_MX100
>  	tristate "Cisco Meraki MX100 Platform Driver"
>  	depends on GPIOLIB
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index c7db2a88c11a..274a685eb92d 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -39,6 +39,9 @@ obj-$(CONFIG_ASUS_TF103C_DOCK)	+= asus-tf103c-dock.o
>  obj-$(CONFIG_EEEPC_LAPTOP)	+= eeepc-laptop.o
>  obj-$(CONFIG_EEEPC_WMI)		+= eeepc-wmi.o
>  
> +# Ayaneo
> +obj-$(CONFIG_AYANEO_EC)		+= ayaneo-ec.o
> +
>  # Cisco/Meraki
>  obj-$(CONFIG_MERAKI_MX100)	+= meraki-mx100.o
>  
> diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
> new file mode 100644
> index 000000000000..90b86527ab0d
> --- /dev/null
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Platform driver for the Embedded Controller (EC) of Ayaneo devices. Handles
> + * hwmon (fan speed, fan control), battery charge limits, and magic module
> + * control (connected modules, controller disconnection).
> + *
> + * Copyright (C) 2025 Antheas Kapenekakis <lkml@antheas.dev>
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +struct ayaneo_ec_quirk {
> +};
> +
> +struct ayaneo_ec_platform_data {
> +	struct platform_device *pdev;
> +	struct ayaneo_ec_quirk *quirks;
> +};
> +
> +static const struct ayaneo_ec_quirk ayaneo3 = {
> +};

I suggest including quirks in the name.

> +
> +static const struct dmi_system_id dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +		},
> +		.driver_data = (void *)&ayaneo3,
> +	},
> +	{},
> +};
> +
> +static int ayaneo_ec_probe(struct platform_device *pdev)
> +{
> +	const struct dmi_system_id *dmi_entry;
> +	struct ayaneo_ec_platform_data *data;
> +
> +	dmi_entry = dmi_first_match(dmi_table);
> +	if (!dmi_entry)
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->pdev = pdev;
> +	data->quirks = dmi_entry->driver_data;
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ayaneo_platform_driver = {
> +	.driver = {
> +		.name = "ayaneo-ec",
> +	},
> +	.probe = ayaneo_ec_probe,
> +};
> +
> +static struct platform_device *ayaneo_platform_device;
> +
> +static int __init ayaneo_ec_init(void)
> +{
> +	ayaneo_platform_device =
> +		platform_create_bundle(&ayaneo_platform_driver,
> +				       ayaneo_ec_probe, NULL, 0, NULL, 0);
> +
> +	return PTR_ERR_OR_ZERO(ayaneo_platform_device);

Please add include for this.

> +}
> +
> +static void __exit ayaneo_ec_exit(void)
> +{
> +	platform_device_unregister(ayaneo_platform_device);
> +	platform_driver_unregister(&ayaneo_platform_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(dmi, dmi_table);
> +
> +module_init(ayaneo_ec_init);
> +module_exit(ayaneo_ec_exit);
> +
> +MODULE_AUTHOR("Antheas Kapenekakis <lkml@antheas.dev>");
> +MODULE_DESCRIPTION("Ayaneo Embedded Controller (EC) platform features");
> +MODULE_LICENSE("GPL");
> 

-- 
 i.


