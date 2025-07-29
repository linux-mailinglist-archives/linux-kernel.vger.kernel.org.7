Return-Path: <linux-kernel+bounces-748975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6BB14847
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31B67541944
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980DE259CBB;
	Tue, 29 Jul 2025 06:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMC7daFE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27125392C;
	Tue, 29 Jul 2025 06:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753770821; cv=none; b=Zk1GN1jvDElauohV4Z6Iy6+z6eXla/stSR+F6L4hI58gOTOa5ivbEjY7UIvVNG8uI2Ast2j5iYVZthFa3aFWoyyDwJK3OHzS23SZRHSaUHf+0PJYcqS5q4xip8AJeTzyj4muTkuwkVvbuYo8K4FoUyUy2TJCQ5+VQsTihMqFjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753770821; c=relaxed/simple;
	bh=WrQ2nB0abIjOpvaWc2St+mpbK4kQYiovaRgN58t+nE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1RWmFluGMHizFB+FibFnBdfg7qwnv3Mu5yXY515yBOIUcxqGMDsccnSdRRwMOrwjS3OiusS5eQooPaCc7rMjVxNUKuXr7lU+zZSvv2hyO8fqkNFctDjQf+i57Q+3NcerPZiVESMIAdXsWRlshe996nl7yeon4lO6PBi7IFePnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMC7daFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E19C4CEEF;
	Tue, 29 Jul 2025 06:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753770821;
	bh=WrQ2nB0abIjOpvaWc2St+mpbK4kQYiovaRgN58t+nE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bMC7daFEPhL8AWb7yVN+Jaa+fkVHbHXsaiF/bWgrKQn7Gbevmm77A30ruqtTdM0Xh
	 YdfTpvCykEDjAEk+3hlRa+bvgvzTaCfiE8PIqXXE89eUikY90pGKOeNOG+FLlCsDol
	 QaEloMqQPTLBnfijzPDUyX5bgwF1TcQbC5GHAppCMaQA5hoBMU1k5SfXe7vgs90OWv
	 oKZHCVn/hx/YQoAMnwrBMZZmYI3NA1xajwb5pYQ9UyrT4bwyq5A+46daiW/qjFUfSu
	 Bgz3RZEUDsIkSEhDxrgL+K02GQTQhDb3Mqgww1D23GZ2O1mP2FSDwrbYfaM6kPoXdi
	 XQDEcZH3DPTcQ==
Message-ID: <67c98aa0-575d-4c04-a4e8-fe0df0d1a3ef@kernel.org>
Date: Tue, 29 Jul 2025 08:33:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/5] misc: amd-sbi: Add support for SB-RMI over I3C
To: Akshay Gupta <akshay.gupta@amd.com>, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net,
 Anand.Umarji@amd.com,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-2-akshay.gupta@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250728061033.1604169-2-akshay.gupta@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/07/2025 08:10, Akshay Gupta wrote:
> AMD EPYC platforms with zen5 and later support APML(SB-RMI)
> connection to the BMC over I3C bus for improved efficiency.
> Add the same functionality supported by rmi-i2c.c over I3C bus.
> 
> Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
> Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
> ---
>  drivers/misc/amd-sbi/Kconfig   |  15 +++-
>  drivers/misc/amd-sbi/Makefile  |   2 +
>  drivers/misc/amd-sbi/rmi-i3c.c | 133 +++++++++++++++++++++++++++++++++
>  3 files changed, 148 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/misc/amd-sbi/rmi-i3c.c
> 
> diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
> index 9b1abeb6ab1a..838cf98805d9 100644
> --- a/drivers/misc/amd-sbi/Kconfig
> +++ b/drivers/misc/amd-sbi/Kconfig
> @@ -15,10 +15,21 @@ config AMD_SBRMI_I2C
>  	  This driver can also be built as a module. If so, the module will
>  	  be called sbrmi-i2c.
>  
> +config AMD_SBRMI_I3C
> +	tristate "AMD side band RMI support over I3C"
> +	depends on I3C
> +	select AMD_SBRMI
> +	select REGMAP_I3C
> +	help
> +	  Side band RMI over I3C support for AMD out of band management.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called sbrmi-i3c.
> +
>  config AMD_SBRMI_HWMON
>  	bool "SBRMI hardware monitoring"
> -	depends on AMD_SBRMI_I2C && HWMON
> -	depends on !(AMD_SBRMI_I2C=y && HWMON=m)
> +	depends on (AMD_SBRMI_I2C || AMD_SBRMI_I3C) && HWMON
> +	depends on !(AMD_SBRMI_I2C=y && HWMON=m) || !(AMD_SBRMI_I3C=y && HWMON=m)
>  	help
>  	  This provides support for RMI device hardware monitoring. If enabled,
>  	  a hardware monitoring device will be created for each socket in
> diff --git a/drivers/misc/amd-sbi/Makefile b/drivers/misc/amd-sbi/Makefile
> index 6f3090fb9ff3..e43d4058a0f0 100644
> --- a/drivers/misc/amd-sbi/Makefile
> +++ b/drivers/misc/amd-sbi/Makefile
> @@ -4,3 +4,5 @@ sbrmi_core-y			:= rmi-core.o
>  obj-$(CONFIG_AMD_SBRMI_HWMON)	+= rmi-hwmon.o
>  sbrmi-i2c-y			:= rmi-i2c.o
>  obj-$(CONFIG_AMD_SBRMI_I2C)	+= sbrmi-i2c.o
> +sbrmi-i3c-y  			:= rmi-i3c.o
> +obj-$(CONFIG_AMD_SBRMI_I3C)	+= sbrmi-i3c.o
> diff --git a/drivers/misc/amd-sbi/rmi-i3c.c b/drivers/misc/amd-sbi/rmi-i3c.c
> new file mode 100644
> index 000000000000..b960743afad1
> --- /dev/null
> +++ b/drivers/misc/amd-sbi/rmi-i3c.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * rmi-i3c.c - Side band RMI over I3C support for AMD out
> + *             of band management
> + *
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>

Where do you use it?

> +#include <linux/regmap.h>
> +#include "rmi-core.h"


...

> +static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = &i3cdev->dev;
> +	struct sbrmi_data *data;
> +	struct regmap_config sbrmi_i3c_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +	};
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);

sizeof(*). Use recent coding style, not some old, downstream code.

> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);
> +
> +	data->regmap = devm_regmap_init_i3c(i3cdev, &sbrmi_i3c_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return PTR_ERR(data->regmap);
> +
> +	/* Enable alert for SB-RMI sequence */
> +	ret = sbrmi_enable_alert(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Cache maximum power limit */
> +	ret = sbrmi_get_max_pwr_limit(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * AMD APML I3C devices support static address
> +	 */
> +	if (i3cdev->desc->info.static_addr)
> +		data->dev_static_addr = i3cdev->desc->info.static_addr;
> +	else
> +		data->dev_static_addr = i3cdev->desc->info.dyn_addr;
> +
> +	dev_set_drvdata(dev, data);
> +
> +	ret = create_hwmon_sensor_device(dev, data);
> +	if (ret < 0)
> +		return ret;
> +	return create_misc_rmi_device(data, dev);
> +}
> +
> +static void sbrmi_i3c_remove(struct i3c_device *i3cdev)
> +{
> +	struct sbrmi_data *data = dev_get_drvdata(&i3cdev->dev);
> +
> +	misc_deregister(&data->sbrmi_misc_dev);
> +	/* Assign fops and parent of misc dev to NULL */
> +	data->sbrmi_misc_dev.fops = NULL;
> +	data->sbrmi_misc_dev.parent = NULL;
> +	dev_info(&i3cdev->dev, "Removed sbrmi-i3c driver\n");

No, drop. This is useless.



Best regards,
Krzysztof

