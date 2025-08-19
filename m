Return-Path: <linux-kernel+bounces-775589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD1B2C10C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C025861DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2591E32A3E2;
	Tue, 19 Aug 2025 11:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTxGDyR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BD1E4AB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755604024; cv=none; b=SmmSW1t/W1GCg3HaWIhZD9V65QasrUedNjki+nGbCSsynkyO+yKcslzbgClVAzhRQf2VR1Tr4oUj4+T7PClwdhqYnf6GAgXZMVf/LZUGucHN5WRjf72nbdO1X5m+naIGQaLDHGtB7Pfjp1cc7CJzMQjdqmAhLoDL5BW9ySYHr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755604024; c=relaxed/simple;
	bh=6U2Rg5LmJXqhRnNkGxZf+eWaD5s7DR7T3ETF0Ln/Vek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kiS27a6tYvXWgpuWO3csL/lbTsHwC079UMpJmRqoO9sLYWS5Hg/K1GXGEYr7GlBLA1de4COcTNYcRWufU3yXMbzuhFNErC6QdY0Bj/rDTyvnwwQfDBBv53ywz5FQge2hEwAlstnd9B1m9BnsU3OKbL1RLOh+MlMCEddmlOFqSLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTxGDyR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD37C116B1;
	Tue, 19 Aug 2025 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755604023;
	bh=6U2Rg5LmJXqhRnNkGxZf+eWaD5s7DR7T3ETF0Ln/Vek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTxGDyR7ATSUXnStkc/urLe3P/1HoC/9YG0XL78Fe7tdZVWD5ra/Dp9B5qOmo4IPr
	 qzSSLR3CFLJs0CMdyRMwo/2rTQQYfo3IOpogYxtWbPdnVxiw91QSOTP/6Wxy071khl
	 /gjfE+ayLnLPPvkpS9raDf+Rr77F0ZyTV+zr1wnu8mBHjFh1GvOzjvy9hCJT09fAmU
	 tz2k85wXcmhOG+AB/43LHB6na2n+KeSygOrsLe1aBI1u/LzkQWcRAK8+RBFNR1z7jD
	 wJ6zNbeS5N/ACxY8RIC9baXzH8iGv1m54j8635m/nHANem1QuRVs2p/ZwSKhTeGbja
	 oqnd3RhgKxDRA==
Message-ID: <28867f10-aa68-449e-bd1c-2e69a26b5f96@kernel.org>
Date: Tue, 19 Aug 2025 12:47:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvmem: s32g-ocotp: Add driver for S32G OCOTP
To: Ciprian Costea <dan.carpenter@linaro.org>,
 Srinivas Kandagatla <srini@kernel.org>
Cc: linaro-s32@linaro.org, NXP S32 Linux Team <s32@nxp.com>,
 linux-kernel@vger.kernel.org
References: <cover.1755341000.git.dan.carpenter@linaro.org>
 <7e1f16bf09e77afef4cc5fa609a6c3ad820bb14c.1755341000.git.dan.carpenter@linaro.org>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <7e1f16bf09e77afef4cc5fa609a6c3ad820bb14c.1755341000.git.dan.carpenter@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/25 11:47 AM, Ciprian Costea wrote:
> Provide access to the On Chip One-Time Programmable Controller (OCOTP)
> pages on the NXP S32G platform.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> Co-developed-by: Larisa Grigore <larisa.grigore@nxp.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/nvmem/Kconfig            |  10 ++
>  drivers/nvmem/Makefile           |   2 +
>  drivers/nvmem/s32g-ocotp-nvmem.c | 171 +++++++++++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>  create mode 100644 drivers/nvmem/s32g-ocotp-nvmem.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index edd811444ce5..6a1cafa74e36 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -314,6 +314,16 @@ config NVMEM_ROCKCHIP_OTP
>  	  This driver can also be built as a module. If so, the module
>  	  will be called nvmem_rockchip_otp.
>  
> +config NVMEM_S32G_OCOTP
> +	tristate "S32G SoC OCOTP support"
> +	depends on ARCH_S32
> +	help
> +	  This is a driver for the On Chip One-Time Programmable controller
> +	  (OCOTP) available on S32G platforms.
> +
> +	  If you say Y here, you will get support for the One Time
> +	  Programmable memory pages.
> +
>  config NVMEM_SC27XX_EFUSE
>  	tristate "Spreadtrum SC27XX eFuse Support"
>  	depends on MFD_SC27XX_PMIC || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index 2021d59688db..b7bfa78af8f3 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -64,6 +64,8 @@ obj-$(CONFIG_NVMEM_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
>  nvmem_rockchip_efuse-y			:= rockchip-efuse.o
>  obj-$(CONFIG_NVMEM_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
>  nvmem-rockchip-otp-y			:= rockchip-otp.o
> +obj-$(CONFIG_NVMEM_S32G_OCOTP)		+= nvmem-s32g-ocotp-nvmem.o
> +nvmem-s32g-ocotp-nvmem-y		:= s32g-ocotp-nvmem.o
>  obj-$(CONFIG_NVMEM_SC27XX_EFUSE)	+= nvmem-sc27xx-efuse.o
>  nvmem-sc27xx-efuse-y			:= sc27xx-efuse.o
>  obj-$(CONFIG_NVMEM_SNVS_LPGPR)		+= nvmem_snvs_lpgpr.o
> diff --git a/drivers/nvmem/s32g-ocotp-nvmem.c b/drivers/nvmem/s32g-ocotp-nvmem.c
> new file mode 100644
> index 000000000000..37355bd83b17
> --- /dev/null
> +++ b/drivers/nvmem/s32g-ocotp-nvmem.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2023-2025 NXP
> + */
> +
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#define S32G_OCOTP_BANK_OFFSET	512u
> +#define S32G_OCOTP_BANK_SIZE	32u
> +#define S32G_OCOTP_WORD_SIZE	4u
> +
> +struct s32g_fuse {
> +	u8 bank;
> +	u8 words_mask;
> +};
> +
> +struct s32g_fuse_map {
> +	const struct s32g_fuse *map;
> +	size_t n_entries;
> +};
> +
> +struct s32g_ocotp_priv {
> +	struct device *dev;
> +	void __iomem *base;
> +	const struct s32g_fuse_map *fuse;
> +};
> +
> +static const struct s32g_fuse s32g_map[] = {
> +	{ .bank = 0,  .words_mask = GENMASK(6, 2) },
> +	{ .bank = 1,  .words_mask = GENMASK(7, 5) },
> +	{ .bank = 2,  .words_mask = GENMASK(1, 0) },
> +	{ .bank = 2,  .words_mask = GENMASK(4, 2) },
> +	{ .bank = 4,  .words_mask = BIT(6) },
> +	{ .bank = 5,  .words_mask = BIT(1) },
> +	{ .bank = 5,  .words_mask = BIT(2) },
> +	{ .bank = 6,  .words_mask = BIT(7) },
> +	{ .bank = 7,  .words_mask = GENMASK(1, 0) },
> +	{ .bank = 11, .words_mask = GENMASK(5, 0) },
> +	{ .bank = 11, .words_mask = GENMASK(7, 6) },
> +	{ .bank = 12, .words_mask = GENMASK(2, 0) },
> +	{ .bank = 12, .words_mask = BIT(7) },
> +	{ .bank = 13, .words_mask = GENMASK(4, 2) },
> +	{ .bank = 14, .words_mask = BIT(1) | BIT(4) | BIT(5) },
> +	{ .bank = 15, .words_mask = GENMASK(7, 5) },
> +};
> +
> +static const struct s32g_fuse_map s32g_fuse_map = {
> +	.map = s32g_map,
> +	.n_entries = ARRAY_SIZE(s32g_map),
> +};
> +
> +static const struct of_device_id ocotp_of_match[] = {
> +	{ .compatible = "nxp,s32g2-ocotp", .data = &s32g_fuse_map},
> +	{ /* sentinel */ }
> +};
> +
> +static u32 get_bank_index(unsigned int offset)
> +{
> +	return (offset - S32G_OCOTP_BANK_OFFSET) / S32G_OCOTP_BANK_SIZE;
> +}
> +
> +static u32 get_word_index(unsigned int offset)
> +{
> +	return offset % S32G_OCOTP_BANK_SIZE / S32G_OCOTP_WORD_SIZE;
> +}
> +
> +static bool is_valid_word(struct s32g_ocotp_priv *s32g_data,
> +			  unsigned int offset, int bytes)
> +{
> +	const struct s32g_fuse_map *fuse = s32g_data->fuse;
> +	u32 bank, word;
> +	size_t i;
> +
> +	if (offset < S32G_OCOTP_BANK_OFFSET)
> +		return false;
If you do not want to allow reading below S32G_OCOTP_BANK_OFFSET, Please
take a look at keepouts for such things.

> +
> +	if (bytes != S32G_OCOTP_WORD_SIZE)
> +		return false;
> +
Why one word at a time? reading for sysfs will not guarantee that it
will be S32G_OCOTP_WORD_SIZE.

> +	bank = get_bank_index(offset);
> +	word = get_word_index(offset);
> +	if (bank >= fuse->n_entries)
> +		return false;
> +
> +	for (i = 0; i < fuse->n_entries; i++) {
> +		if (fuse->map[i].bank == bank &&
> +		    fuse->map[i].words_mask & BIT(word))
> +			return true;

May be we can do something in keepout areas?

--srini
> +	}

> +	return false;
> +}
> +
> +static int s32g_ocotp_read(void *context, unsigned int offset,
> +			    void *val, size_t bytes)
> +{
> +	struct s32g_ocotp_priv *s32g_data = context;
> +
> +	if (!is_valid_word(s32g_data, offset, bytes))
> +		return -EINVAL;

> +
> +	/* Read from Fuse OCOTP Shadow registers */
> +	*(u32 *)val = ioread32(s32g_data->base + offset);
> +
> +	return 0;
> +}
> +
> +static struct nvmem_config s32g_ocotp_nvmem_config = {
> +	.name = "s32g-ocotp",
> +	.add_legacy_fixed_of_cells = true,
> +	.read_only = true,
> +	.word_size = S32G_OCOTP_WORD_SIZE,
> +	.reg_read = s32g_ocotp_read,
> +};
> +
> +static int s32g_ocotp_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_matched_dt_id;
> +	struct s32g_ocotp_priv *s32g_data;
> +	struct device *dev = &pdev->dev;
> +	struct nvmem_device *nvmem;
> +	struct resource *res;
> +
> +	of_matched_dt_id = of_match_device(ocotp_of_match, dev);
> +	if (!of_matched_dt_id) {
> +		dev_err(dev, "Unable to find driver data.\n");
> +		return -ENODEV;
> +	}
> +
> +	s32g_data = devm_kzalloc(dev, sizeof(*s32g_data), GFP_KERNEL);
> +	if (!s32g_data)
> +		return -ENOMEM;
> +
> +	s32g_data->fuse = of_device_get_match_data(dev);
> +	if (!s32g_data->fuse) {
> +		dev_err(dev, "Cannot find platform device data.\n");
> +		return -ENODEV;
> +	}
> +
> +	s32g_data->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(s32g_data->base)) {
> +		dev_err(dev, "Cannot map OCOTP device.\n");
> +		return PTR_ERR(s32g_data->base);
> +	}
> +
> +	s32g_data->dev = dev;
> +	s32g_ocotp_nvmem_config.dev = dev;
> +	s32g_ocotp_nvmem_config.priv = s32g_data;
> +	s32g_ocotp_nvmem_config.size = resource_size(res);
> +
> +	nvmem = devm_nvmem_register(dev, &s32g_ocotp_nvmem_config);
> +
> +	return PTR_ERR_OR_ZERO(nvmem);
> +}
> +
> +static struct platform_driver s32g_ocotp_driver = {
> +	.probe = s32g_ocotp_probe,
> +	.driver = {
> +		.name = "s32g-ocotp",
> +		.of_match_table = ocotp_of_match,
> +	},
> +};
> +module_platform_driver(s32g_ocotp_driver);
> +MODULE_AUTHOR("NXP");
> +MODULE_DESCRIPTION("S32G OCOTP driver");
> +MODULE_LICENSE("GPL");


