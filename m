Return-Path: <linux-kernel+bounces-807206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEBAB4A198
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9A741898C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C22FB99D;
	Tue,  9 Sep 2025 05:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fPhkyUoY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92AF2F0689;
	Tue,  9 Sep 2025 05:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397067; cv=none; b=IAsy4af60Fhoq+yhbZRbE4FP5s7qn0ZgFkukIA1aPx+dRfWIJ8wKov1cYH8u6UuWK/28r9AeIdF7qk99JaqQnJZTOk2bH5Jswl3FrWJx1Rr1vT5jfG0veS0OqON8syicQJWRapK5a4juF4E0ky1SVVhFVu/KAqnDRtkjO60JJA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397067; c=relaxed/simple;
	bh=4ClH8r7bC0JOKGCMPRcDPYFFBIvvSZRrJbhpcBSDmIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Arp+Hz9oIl3B8y6tEZ6ROxs4+RKfalXYmCGJODvDaoCHE/zOqjWdzZ8fzcZwmiGQ+vUQBYKY1R4/DsdzysRVbLZ8jXj2XiaGXkc4DfSJ6vRH3muR88nMsd5ovCY+C4Ofqc7cdw5tCUGUNt1S+/To0lwhVEYQepWcGyIS+QouRhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fPhkyUoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF43C4CEF4;
	Tue,  9 Sep 2025 05:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757397066;
	bh=4ClH8r7bC0JOKGCMPRcDPYFFBIvvSZRrJbhpcBSDmIA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fPhkyUoYXYXREgVUkbNdwoB7wXj2kqFLL9Z60nVajeNDUZ9QUNhjoDyITL9sRBipI
	 l0jlMiLP4awsvUs2tgLqxSjZJmTmyQXoiauOs9490BYHIdkUuqAR9QqDZwFNnfh0fE
	 OvwGSIdxco8JTdIE4STwjsFkS9Mq+MncEUOTIUxY5TL+ao9cKH3i0vDEhlDhjyYJoE
	 Qc6te6V0hTvi6TwT+2+rnUd1JpewAwC9YaZ1q7oAi55iTH0ZQLluVwCOM2ePYFa/5J
	 /SsMc3M/pGWP74slzV7NSWxzB/LZTveZoZionoef9h40zxHzRmLpI0zpQS23U49gO7
	 jPDFyGRiTMcWA==
Message-ID: <8721df1d-d8db-4b05-b450-107d936d8715@kernel.org>
Date: Tue, 9 Sep 2025 06:51:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmem: add driver for the eeprom in qnap-mcu
 controllers
To: Heiko Stuebner <heiko@sntech.de>, lee@kernel.org, srini@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250730172248.1875122-1-heiko@sntech.de>
 <20250730172248.1875122-3-heiko@sntech.de>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20250730172248.1875122-3-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/30/25 6:22 PM, Heiko Stuebner wrote:
> The qnap-mcu also has an eeprom connected to it, that contains some
> specific product-information like the mac addresses for the network
> interfaces.
> 
> Add a nvmem driver for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mfd/qnap-mcu.c          |   1 +
>  drivers/nvmem/Kconfig           |   9 +++
>  drivers/nvmem/Makefile          |   2 +
>  drivers/nvmem/qnap-mcu-eeprom.c | 110 ++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)
>  create mode 100644 drivers/nvmem/qnap-mcu-eeprom.c
> 
In case Lee you want to take this via MFD,

Acked-by: Srinivas Kandagatla <srini@kernel.org>


--srini

> diff --git a/drivers/mfd/qnap-mcu.c b/drivers/mfd/qnap-mcu.c
> index 6ed020206e55..e942ead9e515 100644
> --- a/drivers/mfd/qnap-mcu.c
> +++ b/drivers/mfd/qnap-mcu.c
> @@ -346,6 +346,7 @@ static const struct qnap_mcu_variant qnap_ts433_mcu = {
>  };
>  
>  static struct mfd_cell qnap_mcu_cells[] = {
> +	{ .name = "qnap-mcu-eeprom", },
>  	{ .name = "qnap-mcu-input", },
>  	{ .name = "qnap-mcu-leds", },
>  	{ .name = "qnap-mcu-hwmon", }
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d370b2ad11e7..b3975488a5aa 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -265,6 +265,15 @@ config NVMEM_QCOM_SEC_QFPROM
>            This driver can also be built as a module. If so, the module will be called
>            nvmem_sec_qfprom.
>  
> +config NVMEM_QNAP_MCU_EEPROM
> +	tristate "QNAP MCU EEPROM Support"
> +	depends on MFD_QNAP_MCU
> +	help
> +	  Say y here to enable support for accessing the EEPROM attached to
> +	  QNAP MCU devices. This EEPROM contains additional runtime device
> +	  information, like MAC addresses for ethernet devices that do not
> +	  contain their own mac storage.
> +
>  config NVMEM_RAVE_SP_EEPROM
>  	tristate "Rave SP EEPROM Support"
>  	depends on RAVE_SP_CORE
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 2021d59688db..21b3ae1c57e8 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -54,6 +54,8 @@ obj-$(CONFIG_NVMEM_QCOM_QFPROM)		+= nvmem_qfprom.o
>  nvmem_qfprom-y				:= qfprom.o
>  obj-$(CONFIG_NVMEM_QCOM_SEC_QFPROM)	+= nvmem_sec_qfprom.o
>  nvmem_sec_qfprom-y			:= sec-qfprom.o
> +obj-$(CONFIG_NVMEM_QNAP_MCU_EEPROM)	+= nvmem-qnap-mcu-eeprom.o
> +nvmem-qnap-mcu-eeprom-y			:= qnap-mcu-eeprom.o
>  obj-$(CONFIG_NVMEM_RAVE_SP_EEPROM)	+= nvmem-rave-sp-eeprom.o
>  nvmem-rave-sp-eeprom-y			:= rave-sp-eeprom.o
>  obj-$(CONFIG_NVMEM_RCAR_EFUSE)		+= nvmem-rcar-efuse.o
> diff --git a/drivers/nvmem/qnap-mcu-eeprom.c b/drivers/nvmem/qnap-mcu-eeprom.c
> new file mode 100644
> index 000000000000..fea1e7b91764
> --- /dev/null
> +++ b/drivers/nvmem/qnap-mcu-eeprom.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * ee1004 - driver for DDR4 SPD EEPROMs
> + *
> + * Copyright (C) 2017-2019 Jean Delvare
> + *
> + * Based on the at24 driver:
> + * Copyright (C) 2005-2007 David Brownell
> + * Copyright (C) 2008 Wolfram Sang, Pengutronix
> + */
> +
> +#include <linux/mfd/qnap-mcu.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/platform_device.h>
> +
> +/* Determined by trial and error until read anomalies appeared */
> +#define QNAP_MCU_EEPROM_SIZE		256
> +#define QNAP_MCU_EEPROM_BLOCK_SIZE	32
> +
> +static int qnap_mcu_eeprom_read_block(struct qnap_mcu *mcu, unsigned int offset,
> +				      void *val, size_t bytes)
> +{
> +	const u8 cmd[] = { 0xf7, 0xa1, offset, bytes };
> +	u8 *reply;
> +	int ret = 0;
> +
> +	reply = kzalloc(bytes + sizeof(cmd), GFP_KERNEL);
> +	if (!reply)
> +		return -ENOMEM;
> +
> +	ret = qnap_mcu_exec(mcu, cmd, sizeof(cmd), reply, bytes + sizeof(cmd));
> +	if (ret)
> +		goto out;
> +
> +	/* First bytes must mirror the sent command */
> +	if (memcmp(cmd, reply, sizeof(cmd))) {
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	memcpy(val, reply + sizeof(cmd), bytes);
> +
> +out:
> +	kfree(reply);
> +	return ret;
> +}
> +
> +static int qnap_mcu_eeprom_read(void *priv, unsigned int offset, void *val, size_t bytes)
> +{
> +	struct qnap_mcu *mcu = priv;
> +	int pos = 0, ret;
> +	u8 *buf = val;
> +
> +	if (unlikely(!bytes))
> +		return 0;
> +
> +	while (bytes > 0) {
> +		size_t to_read = (bytes > QNAP_MCU_EEPROM_BLOCK_SIZE) ?
> +						QNAP_MCU_EEPROM_BLOCK_SIZE : bytes;
> +
> +		ret = qnap_mcu_eeprom_read_block(mcu, offset + pos, &buf[pos], to_read);
> +		if (ret < 0)
> +			return ret;
> +
> +		pos += to_read;
> +		bytes -= to_read;
> +	}
> +
> +	return 0;
> +}
> +
> +static int qnap_mcu_eeprom_probe(struct platform_device *pdev)
> +{
> +	struct qnap_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
> +	struct nvmem_config nvcfg = {};
> +	struct nvmem_device *ndev;
> +
> +	nvcfg.dev = &pdev->dev;
> +	nvcfg.of_node = pdev->dev.parent->of_node;
> +	nvcfg.name = dev_name(&pdev->dev);
> +	nvcfg.id = NVMEM_DEVID_NONE;
> +	nvcfg.owner = THIS_MODULE;
> +	nvcfg.type = NVMEM_TYPE_EEPROM;
> +	nvcfg.read_only = true;
> +	nvcfg.root_only = false;
> +	nvcfg.reg_read = qnap_mcu_eeprom_read;
> +	nvcfg.size = QNAP_MCU_EEPROM_SIZE,
> +	nvcfg.word_size = 1,
> +	nvcfg.stride = 1,
> +	nvcfg.priv = mcu,
> +
> +	ndev = devm_nvmem_register(&pdev->dev, &nvcfg);
> +	if (IS_ERR(ndev))
> +		return PTR_ERR(ndev);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver qnap_mcu_eeprom_driver = {
> +	.probe = qnap_mcu_eeprom_probe,
> +	.driver = {
> +		.name = "qnap-mcu-eeprom",
> +	},
> +};
> +module_platform_driver(qnap_mcu_eeprom_driver);
> +
> +MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
> +MODULE_DESCRIPTION("QNAP MCU EEPROM driver");
> +MODULE_LICENSE("GPL");


