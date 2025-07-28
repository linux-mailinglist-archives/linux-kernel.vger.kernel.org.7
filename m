Return-Path: <linux-kernel+bounces-747543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A80B13500
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF9C189885F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E72221550;
	Mon, 28 Jul 2025 06:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="W2/ZGzn8"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8171411DE;
	Mon, 28 Jul 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753684686; cv=none; b=g59S+JPx1DXsgfnFzWhVkRRsif+UUXP4kSIgfOyZNfR6Sm1hEBIUCIpA1eqUnjRncGZwyW1N9hVf7ofHpOz4tfI9sH4b8JHm7hqDNJw1l0D4qlwW602kIuB3ZTXzqdvYitpGMLg8xtOF09Cid7ka8b+Zl7kza/wQUXPBresddTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753684686; c=relaxed/simple;
	bh=MV0+xDoir8VqL8d7w4br3Jq1WCP3bum7WCiNz/cycVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCSN25ivfmv8cExIkDEkEPk4Vy1BHoWkLQFzi8QdtWcAW4t8jzQBdRxGHTKQ72fHorz9z0wFm2WqPhKP/1uzoIaLaX3vCLpZFaZOnFRSjJ0qbYyjDGKGs+ypz8HbEdvc73XVWzCPvGK5tn+iCikdW7yv40KOkwVsH7X04ENUvKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=W2/ZGzn8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1753684675;
	bh=MV0+xDoir8VqL8d7w4br3Jq1WCP3bum7WCiNz/cycVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W2/ZGzn8ON6sJM/H+Mqu9y3VU5aVwUiX9xk6/mi1ET2ouUus2rgt4g8U9IzWzGIui
	 tYZ+VgxsVZhzSsnIB3ayfXMfgtSTGxuTfMU/LcW1YTGHrSwaE8MoF06mkqfTyert46
	 4mvD4SbkSGvodBjw29ddJ/D64fV9DmhafRKA4i/8=
Date: Mon, 28 Jul 2025 08:37:55 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	gregkh@linuxfoundation.org, arnd@arndb.de, linux@roeck-us.net, Anand.Umarji@amd.com, 
	Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Subject: Re: [PATCH v1 2/5] misc: amd-sbi: Add support for SB-RMI over I3C
Message-ID: <039f9a44-80df-4795-b18d-5fc9c488ca37@t-8ch.de>
References: <20250728061033.1604169-1-akshay.gupta@amd.com>
 <20250728061033.1604169-2-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728061033.1604169-2-akshay.gupta@amd.com>

On 2025-07-28 06:10:30+0000, Akshay Gupta wrote:
(...)

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

Unnecessary include.

> +#include <linux/err.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>

Ditto.

> +#include <linux/regmap.h>
> +#include "rmi-core.h"
> +
> +static int sbrmi_enable_alert(struct sbrmi_data *data)
> +{
> +	int ctrl, ret;
> +
> +	/*
> +	 * Enable the SB-RMI Software alert status
> +	 * by writing 0 to bit 4 of Control register(0x1)
> +	 */
> +	ret = regmap_read(data->regmap, SBRMI_CTRL, &ctrl);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ctrl & 0x10) {

Magic value? Use a define.

> +		ctrl &= ~0x10;
> +		return regmap_write(data->regmap, SBRMI_CTRL, ctrl);
> +	}
> +
> +	return 0;
> +}
> +
> +static int sbrmi_get_max_pwr_limit(struct sbrmi_data *data)
> +{
> +	struct apml_mbox_msg msg = { 0 };
> +	int ret;
> +
> +	msg.cmd = SBRMI_READ_PKG_MAX_PWR_LIMIT;
> +	ret = rmi_mailbox_xfer(data, &msg);
> +	if (ret < 0)
> +		return ret;
> +	data->pwr_limit_max = msg.mb_in_out;
> +
> +	return ret;
> +}
> +
> +static int sbrmi_i3c_probe(struct i3c_device *i3cdev)
> +{
> +	struct device *dev = &i3cdev->dev;

i3cdev_to_dev();

> +	struct sbrmi_data *data;
> +	struct regmap_config sbrmi_i3c_regmap_config = {
> +		.reg_bits = 8,
> +		.val_bits = 8,
> +	};
> +	int ret;
> +
> +	data = devm_kzalloc(dev, sizeof(struct sbrmi_data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	mutex_init(&data->lock);

devm_mutex_init().

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

If you get rid of _remove(), then this can go away.

> +
> +	ret = create_hwmon_sensor_device(dev, data);

That's a very generic name to have exported.

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

create_misc_rmi_device() could use devm_add_action_or_reset() for the
misc deregister, simplifying the drivers code.

> +	/* Assign fops and parent of misc dev to NULL */
> +	data->sbrmi_misc_dev.fops = NULL;
> +	data->sbrmi_misc_dev.parent = NULL;

Why are these two needed? The data is freed anyways right after.

> +	dev_info(&i3cdev->dev, "Removed sbrmi-i3c driver\n");

Unnecessary.

> +}
> +
> +static const struct i3c_device_id sbrmi_i3c_id[] = {
> +	/* PID for AMD SBRMI device */
> +	I3C_DEVICE_EXTRA_INFO(0x112, 0x0, 0x2, NULL),
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i3c, sbrmi_i3c_id);
> +
> +static struct i3c_driver sbrmi_i3c_driver = {
> +	.driver = {
> +		.name = "sbrmi-i3c",
> +	},
> +	.probe = sbrmi_i3c_probe,
> +	.remove = sbrmi_i3c_remove,
> +	.id_table = sbrmi_i3c_id,
> +};
> +
> +module_i3c_driver(sbrmi_i3c_driver);

You could have the i2c and i3c drivers in the same module using
module_i3c_i2c_driver().

> +
> +MODULE_IMPORT_NS("AMD_SBRMI");
> +MODULE_AUTHOR("Akshay Gupta <akshay.gupta@amd.com>");
> +MODULE_AUTHOR("Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>");
> +MODULE_DESCRIPTION("AMD SB-RMI driver over I3C");
> +MODULE_LICENSE("GPL");
> -- 
> 2.25.1
> 

