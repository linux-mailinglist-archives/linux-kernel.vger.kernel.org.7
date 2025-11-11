Return-Path: <linux-kernel+bounces-895135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5DCC4D035
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5949424A1F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF6D3346B1;
	Tue, 11 Nov 2025 10:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7igPbjG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F072874F1;
	Tue, 11 Nov 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856337; cv=none; b=UBXMyyC5YFnrAIVJTUVxCDXK052jmrISxWhUa4zUrZ4zVb90sHZNrb5LlYkl2pURBwBJu0EWFlka2X4rXat9Kw3hrfqf7itHIxdoiuE0XAlEClyq6k1eVGEwMZYEs3SNHZmHHQJyEs8W1bPH20WENtIVSS8j0yra+mvtTnkkCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856337; c=relaxed/simple;
	bh=Ab6z6hbQyhT6bFlYZpXwDkTrdaTugZt6viUsE0ipBhw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=AkDQleZ9J51GA3H6ApyMrpnlQ/clc1iT7/I8KPVEW/5dcG5Nl7NrCpTgPnWxkgus1ew6aJkLR6kbhFKHHOG0BSeZDYVG/O7ZGQ35NJA97TYXQooBeNkVIQvkWzKdhaJ9TxW+knR1JqA6NOQ+CqYZuU7xNeyAZbdPplc2GcKKR3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7igPbjG; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762856336; x=1794392336;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ab6z6hbQyhT6bFlYZpXwDkTrdaTugZt6viUsE0ipBhw=;
  b=C7igPbjG6XMrBMPonUzliUg3TYZohejEuqENeliS4UqbHrYz8hCDK80G
   ETgP9r9mijbTbBR2eMQXFV1Bypj6+NnKBIYuS5HCWgioSTPj2H4vOC6Kq
   eZ9Bw1bYhG5i4RO3LSZYoSs3VnlpegTyDRFUFOiRVKmiJiqvcPRSVqp+Z
   SfbzAYjA5KxUN+HyZGBrJegmzmcjDLMsasaCbsaXvwZxRrdX/IEF/hFte
   1yaSjvCsN2P7OTie/CiC3+QRSMnK4hYD7zJzn98Pg9fZtQ1AJch7NW7Lh
   gx64tpGQYb6zRWbx2wAk1QLNki7mWaNrgZwJYUcUCHBOSJphwgo1P1Xi5
   A==;
X-CSE-ConnectionGUID: 1dbekOXpQjyAzsDcwH4knA==
X-CSE-MsgGUID: P6wjFq6ISfC3RD+Y35Fdaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="64957168"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="64957168"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:18:55 -0800
X-CSE-ConnectionGUID: bubkQKWKQImzpGwRu6xzWw==
X-CSE-MsgGUID: I6DQQc0XSxifr+A+X+x5FQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="188250651"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.132])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 02:18:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Nov 2025 12:18:48 +0200 (EET)
To: Antheas Kapenekakis <lkml@antheas.dev>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-hwmon@vger.kernel.org, Hans de Goede <hansg@kernel.org>, 
    Derek John Clark <derekjohn.clark@gmail.com>, 
    =?ISO-8859-15?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>, 
    Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v4 1/6] platform/x86: ayaneo-ec: Add Ayaneo Embedded
 Controller platform driver
In-Reply-To: <20251110180846.1490726-2-lkml@antheas.dev>
Message-ID: <35f12e9a-a36e-f052-c913-3f21515ab148@linux.intel.com>
References: <20251110180846.1490726-1-lkml@antheas.dev> <20251110180846.1490726-2-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 10 Nov 2025, Antheas Kapenekakis wrote:

> Recent Ayaneo devices feature an ACPI mapped Embedded Controller (EC)
> with standard addresses across models that provides access to fan
> speed, fan control, battery charge limits, and controller power
> controls. Introduce a new driver stub that will handle these driver
> features.
> 
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  MAINTAINERS                      |  6 +++
>  drivers/platform/x86/Kconfig     |  9 ++++
>  drivers/platform/x86/Makefile    |  3 ++
>  drivers/platform/x86/ayaneo-ec.c | 90 ++++++++++++++++++++++++++++++++
>  4 files changed, 108 insertions(+)
>  create mode 100644 drivers/platform/x86/ayaneo-ec.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddecf1ef3bed..c5bf7207c45f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4192,6 +4192,12 @@ W:	https://ez.analog.com/linux-software-drivers
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
> index c122016d82f1..1a7f8ae793ba 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -316,6 +316,15 @@ config ASUS_TF103C_DOCK
>  	  If you have an Asus TF103C tablet say Y or M here, for a generic x86
>  	  distro config say M here.
>  
> +config AYANEO_EC
> +	tristate "Ayaneo EC platform control"
> +	help
> +	  Enables support for the platform EC of Ayaneo devices. This
> +	  includes fan control, fan speed, charge limit, magic
> +	  module detection, and controller power control.
> +
> +	  If you have an Ayaneo device, say Y or M here.
> +

It seems you've missed Armin's comment on v3 that this needs
depends on DMI.

-- 
 i.

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
> index 000000000000..2fe66c8a89f4
> --- /dev/null
> +++ b/drivers/platform/x86/ayaneo-ec.c
> @@ -0,0 +1,90 @@
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
> +#include <linux/err.h>
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
> +static const struct ayaneo_ec_quirk quirk_ayaneo3 = {
> +};
> +
> +static const struct dmi_system_id dmi_table[] = {
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +		},
> +		.driver_data = (void *)&quirk_ayaneo3,
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

