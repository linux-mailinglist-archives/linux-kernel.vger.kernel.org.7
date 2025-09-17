Return-Path: <linux-kernel+bounces-820677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D88B7D7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F793A772E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6CA2F999F;
	Wed, 17 Sep 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Pa4K39w4"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0795F337E95;
	Wed, 17 Sep 2025 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112122; cv=none; b=TGtXElpqNkqkOk/MdE8lV6Chns5lPVeqR9u6zqhv7shlQnYwheyLx8vkm9AGLUSc0vCAANnJ2dcYh6sV3cKlVoCdoHOyOSAMCUkMYiTf6FBg5/UoW6UOBXWBgBZIDswkCPJi/WSq6rwyFlMa/OEjHjUKIopdJli4xT5Tju4wCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112122; c=relaxed/simple;
	bh=kG6GEcVZ0l9kvUrfy3YcmAI4g+04kyI1HBaezqj5omQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7X7HQLBOulLqUuL+tteLlQLBeEpgJOCfgQakWXEFPXuUCW1C6T4zfdYvaoqcNFMGJt/9YmAANQvnyt1Z11tMdf19nyYYxU7btaIPTrCDERnVeZ40VC/D95Cef/dYD9eWdZ4dMqSDLYYHDM5dMAoXv3JOOV2AA8ia8d2ZvN9SVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Pa4K39w4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758112118;
	bh=kG6GEcVZ0l9kvUrfy3YcmAI4g+04kyI1HBaezqj5omQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pa4K39w4HrlTH97Ku3lyQMPNerlSMiN9bY2A5q7EJvLGZhmDEHYPuZFhFO73mKNb1
	 w5nr8j9SZnIhDUi2N+6r/dIsEnGKfzgqdq3luBo9oOx0EWzVK2xKNI9zVQIQpmSCC8
	 oPKGA7sIS3O5VgUXruDrHuaiNBkcNSvK94K/SFCjwRvrnKoTrrP3Nxzlesh/VSL4xp
	 fkQEB56l0iKzAa2aovxFYZmJrSWv9pY1dd23dMYUPq6YR9v6iyV+SrsuH+l7OZfccx
	 9+3HIKDO1A9j/CKqJjFj+BOn3+b5L83xZUpU7VzhaXs2gifHqLp0Rm+/VasAHHL3Y+
	 W8cI6KqTC6BBw==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9795517E0AC3;
	Wed, 17 Sep 2025 14:28:37 +0200 (CEST)
Message-ID: <ff2ef2b2-2f20-4b07-a1d3-f73cb7fae77c@collabora.com>
Date: Wed, 17 Sep 2025 14:28:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] ASoC: SOF: MediaTek: Add mt8196 hardware support
To: "hailong.fan" <hailong.fan@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20250917075336.5985-1-hailong.fan@mediatek.com>
 <20250917075336.5985-3-hailong.fan@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250917075336.5985-3-hailong.fan@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/09/25 09:53, hailong.fan ha scritto:
> From: Hailong Fan <hailong.fan@mediatek.com>
> 
> Add support of SOF on MediaTek mt8196 SoC.
> MT8196 has a Cadence HiFi-5 DSP core that is responsible for running the
> operating system and application programs. The IPC communication between
> the AP and DSP is based on shared DRAM and mailbox interrupt.
> 
> Signed-off-by: Hailong Fan <hailong.fan@mediatek.com>
> ---
>   sound/soc/sof/mediatek/Kconfig                |   9 +
>   sound/soc/sof/mediatek/Makefile               |   1 +
>   sound/soc/sof/mediatek/mt8196/Makefile        |   3 +
>   sound/soc/sof/mediatek/mt8196/mt8196-clk.c    |  98 +++
>   sound/soc/sof/mediatek/mt8196/mt8196-clk.h    |  23 +
>   sound/soc/sof/mediatek/mt8196/mt8196-loader.c |  60 ++
>   sound/soc/sof/mediatek/mt8196/mt8196.c        | 556 ++++++++++++++++++
>   sound/soc/sof/mediatek/mt8196/mt8196.h        | 124 ++++
>   8 files changed, 874 insertions(+)
>   create mode 100644 sound/soc/sof/mediatek/mt8196/Makefile
>   create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.c
>   create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-clk.h
>   create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196-loader.c
>   create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.c
>   create mode 100644 sound/soc/sof/mediatek/mt8196/mt8196.h
> 
> diff --git a/sound/soc/sof/mediatek/Kconfig b/sound/soc/sof/mediatek/Kconfig
> index 4a2eddf6009a..36eb6f5c080b 100644
> --- a/sound/soc/sof/mediatek/Kconfig
> +++ b/sound/soc/sof/mediatek/Kconfig
> @@ -42,4 +42,13 @@ config SND_SOC_SOF_MT8195
>   	  Say Y if you have such a device.
>   	  If unsure select "N".
>   
> +config SND_SOC_SOF_MT8196
> +	tristate "SOF support for MT8196 audio DSP"
> +	select SND_SOC_SOF_MTK_COMMON
> +	depends on MTK_ADSP_IPC
> +	help
> +	  This adds support for Sound Open Firmware for MediaTek platforms
> +	  using the mt8196 processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
>   endif ## SND_SOC_SOF_MTK_TOPLEVEL
> diff --git a/sound/soc/sof/mediatek/Makefile b/sound/soc/sof/mediatek/Makefile
> index 29c5afb2f3d6..3e36d538679e 100644
> --- a/sound/soc/sof/mediatek/Makefile
> +++ b/sound/soc/sof/mediatek/Makefile
> @@ -2,3 +2,4 @@
>   obj-$(CONFIG_SND_SOC_SOF_MTK_COMMON) += mtk-adsp-common.o
>   obj-$(CONFIG_SND_SOC_SOF_MT8195) += mt8195/
>   obj-$(CONFIG_SND_SOC_SOF_MT8186) += mt8186/
> +obj-$(CONFIG_SND_SOC_SOF_MT8196) += mt8196/

..snip..

> diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.c b/sound/soc/sof/mediatek/mt8196/mt8196.c
> new file mode 100644
> index 000000000000..079a0b303780
> --- /dev/null
> +++ b/sound/soc/sof/mediatek/mt8196/mt8196.c
> @@ -0,0 +1,556 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Copyright(c) 2025 MediaTek Inc. All rights reserved.
> + * Author: Hailong Fan <hailong.fan@mediatek.com>
> + */
> +
> +/*
> + * Hardware interface for audio DSP on mt8196
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/firmware.h>
> +#include <linux/io.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/module.h>
> +
> +#include <sound/sof.h>
> +#include <sound/sof/xtensa.h>
> +#include "../../ops.h"
> +#include "../../sof-of-dev.h"
> +#include "../adsp_helper.h"
> +#include "../mtk-adsp-common.h"
> +#include "mt8196.h"
> +#include "mt8196-clk.h"
> +
> +static void sof_reg_write_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset, u32 value,
> +			       u8 bits, u8 len)
> +{
> +	u32 mask, val;
> +	int ret;
> +
> +	mask = GENMASK(len + bits - 1, bits);
> +	val = (value << bits) & mask;
> +
> +	ret = snd_sof_dsp_update_bits(sdev, bar, offset, mask, val);
> +	if (ret < 0)
> +		dev_err(sdev->dev, "Failed to update DSP register: %d\n", ret);
> +}
> +
> +static u32 reg_read_bits(struct snd_sof_dev *sdev, u32 bar, u32 offset, u8 bits, u8 len)

For consistency, sof_reg_read_bits()

> +{
> +	u32 target_bit_field, curr_value;
> +
> +	target_bit_field = GENMASK(len + bits - 1, bits);
> +	curr_value = snd_sof_dsp_read(sdev, bar, offset);
> +
> +	return (curr_value & target_bit_field) >> bits;
> +}
> +
> +static int mt8196_get_mailbox_offset(struct snd_sof_dev *sdev)
> +{
> +	return MBOX_OFFSET;
> +}
> +
> +static int mt8196_get_window_offset(struct snd_sof_dev *sdev, u32 id)
> +{
> +	return MBOX_OFFSET;
> +}
> +
> +static const struct mtk_adsp_ipc_ops dsp_ops = {
> +	.handle_reply		= mtk_adsp_handle_reply,
> +	.handle_request		= mtk_adsp_handle_request,
> +};
> +
> +static int platform_parse_resource(struct platform_device *pdev, void *data)
> +{
> +	struct resource *mmio;
> +	struct resource res;
> +	struct device_node *mem_region;
> +	struct device *dev = &pdev->dev;
> +	struct mtk_adsp_chip_info *adsp = data;
> +	int ret;
> +
> +	ret = of_reserved_mem_device_init(dev);
> +	if (ret) {
> +		dev_err(dev, "of_reserved_mem_device_init failed\n");
> +		return ret;
> +	}
> +
> +	mem_region = of_parse_phandle(dev->of_node, "memory-region", 1);
> +	if (!mem_region) {
> +		dev_err(dev, "no memory-region sysmem phandle\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = of_address_to_resource(mem_region, 0, &res);
> +	of_node_put(mem_region);
> +	if (ret) {
> +		dev_err(dev, "of_address_to_resource sysmem failed\n");
> +		return ret;
> +	}
> +
> +	adsp->pa_dram = (phys_addr_t)res.start;
> +	if (adsp->pa_dram & DRAM_REMAP_MASK) {
> +		dev_err(dev, "adsp memory(%#x) is not 4K-aligned\n",
> +			(u32)adsp->pa_dram);
> +		return -EINVAL;
> +	}
> +
> +	adsp->dramsize = resource_size(&res);
> +	if (adsp->dramsize < TOTAL_SIZE_SHARED_DRAM_FROM_TAIL) {
> +		dev_err(dev, "adsp memory(%#x) is not enough for share\n",
> +			adsp->dramsize);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "dram pbase=%pa size=%#x\n", &adsp->pa_dram, adsp->dramsize);
> +
> +	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!mmio) {
> +		dev_err(dev, "no ADSP-CFG register resource\n");
> +		return -ENXIO;
> +	}
> +
> +	adsp->va_cfgreg = devm_ioremap_resource(dev, mmio);
> +	if (IS_ERR(adsp->va_cfgreg))
> +		return PTR_ERR(adsp->va_cfgreg);
> +
> +	adsp->pa_cfgreg = (phys_addr_t)mmio->start;
> +	adsp->cfgregsize = resource_size(mmio);
> +
> +	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sram");
> +	if (!mmio) {
> +		dev_err(dev, "no SRAM resource\n");
> +		return -ENXIO;
> +	}
> +
> +	adsp->pa_sram = (phys_addr_t)mmio->start;
> +	adsp->sramsize = resource_size(mmio);
> +

Until there, this function is exactly the same as the one found in mt8195/mt8195.c
except the one in mt8195 is better.....

> +	dev_dbg(dev, "sram pbase=%pa size=%#x\n", &adsp->pa_sram, adsp->sramsize);
> +
> +	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "sec");
> +	if (!mmio) {
> +		dev_err(dev, "no SEC register resource\n");
> +		return -ENXIO;
> +	}
> +
> +	adsp->va_secreg = devm_ioremap_resource(dev, mmio);
> +	if (IS_ERR(adsp->va_secreg))
> +		return PTR_ERR(adsp->va_secreg);
> +
> +	adsp->pa_secreg = (phys_addr_t)mmio->start;
> +	adsp->secregsize = resource_size(mmio);
> +
> +	dev_dbg(dev, "secreg pbase=%pa size=%#x\n", &adsp->pa_secreg, adsp->secregsize);
> +
> +	mmio = platform_get_resource_byname(pdev, IORESOURCE_MEM, "bus");
> +	if (!mmio) {
> +		dev_err(dev, "no BUS register resource\n");
> +		return -ENXIO;
> +	}
> +
> +	adsp->va_busreg = devm_ioremap_resource(dev, mmio);
> +	if (IS_ERR(adsp->va_busreg))
> +		return PTR_ERR(adsp->va_busreg);
> +
> +	adsp->pa_busreg = (phys_addr_t)mmio->start;
> +	adsp->busregsize = resource_size(mmio);
> +
> +	dev_dbg(dev, "busreg pbase=%pa, vbase=%pa, size=%#x\n", &adsp->pa_busreg,
> +		&adsp->va_busreg, adsp->busregsize);
> +

...and until there, this function is exactly the same as the one found in mt8186.c

So, please commonize the two and remove duplication from mt8186, mt8195 and mt8196.

> +	return 0;
> +}
> +
> +static void adsp_sram_power_on(struct snd_sof_dev *sdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ADSP_SRAM_CHANNEL_NUM; i++) {
> +		sof_reg_write_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_CON, 0, i, 1);
> +		while (1) {
> +			if (reg_read_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_ACK, i, 1) == 0)
> +				break;
> +		}
> +	}
> +}
> +
> +static void adsp_sram_power_off(struct snd_sof_dev *sdev)
> +{
> +	int i;
> +
> +	for (i = 0; i < ADSP_SRAM_CHANNEL_NUM; i++) {
> +		sof_reg_write_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_CON, 1, i, 1);
> +		while (1) {
> +			if (reg_read_bits(sdev, DSP_BUSREG_BAR, ADSP_SRAM_POOL_ACK, i, 1) == 1)
> +				break;
> +		}
> +	}
> +}
> +
> +/*  Init the basic DSP DRAM address */
> +static int adsp_memory_remap_init(struct snd_sof_dev *sdev, struct mtk_adsp_chip_info *adsp)
> +{
> +	u32 from, to;
> +
> +	from = adsp_remap_region_from(DRAM_PHYS_BASE_FROM_DSP_VIEW, DSP_DRAM_SIZE);
> +	to = (u32)ADSP_REMAP_REGION_TO(adsp->pa_dram);
> +
> +	snd_sof_dsp_write(sdev, DSP_BUSREG_BAR, AUDIO_BUS_CFG_RSV_10, from);
> +	snd_sof_dsp_write(sdev, DSP_BUSREG_BAR, DSP_C0_EMI_MAP_ADDR, to);
> +
> +	snd_sof_dsp_update_bits(sdev, DSP_BUSREG_BAR, AUDIO_BUS_CFG_BUS_REMAP_CTRL, 1, 1);
> +
> +	return 0;
> +}
> +
> +static int mt8196_run(struct snd_sof_dev *sdev)
> +{
> +	u32 adsp_bootup_addr;
> +
> +	adsp_bootup_addr = SRAM_PHYS_BASE_FROM_DSP_VIEW;
> +	dev_dbg(sdev->dev, "HIFIxDSP boot from base : 0x%08X\n", adsp_bootup_addr);
> +	mt8196_sof_hifixdsp_boot_sequence(sdev, adsp_bootup_addr);
> +
> +	return 0;
> +}
> +
> +static int mt8196_dsp_probe(struct snd_sof_dev *sdev)
> +{

This function is also duplicated between all of the currently supported mediatek
platforms (mt8186, 8195 and 8196).

> +	struct platform_device *pdev = to_platform_device(sdev->dev);
> +	struct adsp_priv *priv;
> +	int ret;
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	sdev->pdata->hw_pdata = priv;
> +	priv->dev = sdev->dev;
> +	priv->sdev = sdev;
> +
> +	priv->adsp = devm_kzalloc(&pdev->dev, sizeof(struct mtk_adsp_chip_info), GFP_KERNEL);
> +	if (!priv->adsp)
> +		return -ENOMEM;
> +
> +	ret = platform_parse_resource(pdev, priv->adsp);
> +	if (ret)
> +		return ret;
> +
> +	sdev->bar[SOF_FW_BLK_TYPE_IRAM] = devm_ioremap(sdev->dev,
> +						       priv->adsp->pa_sram,
> +						       priv->adsp->sramsize);
> +	if (!sdev->bar[SOF_FW_BLK_TYPE_IRAM]) {
> +		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
> +			&priv->adsp->pa_sram, priv->adsp->sramsize);
> +		return -ENOMEM;
> +	}
> +
> +	priv->adsp->va_sram = sdev->bar[SOF_FW_BLK_TYPE_IRAM];
> +	dev_dbg(sdev->dev, "pa_sram %pa,va: %pa, size %#x\n",
> +		&priv->adsp->pa_sram, &priv->adsp->va_sram, priv->adsp->sramsize);
> +
> +	sdev->bar[SOF_FW_BLK_TYPE_SRAM] = devm_ioremap(sdev->dev,
> +						       priv->adsp->pa_dram,
> +						       priv->adsp->dramsize);
> +
> +	if (!sdev->bar[SOF_FW_BLK_TYPE_SRAM]) {
> +		dev_err(sdev->dev, "failed to ioremap base %pa size %#x\n",
> +			&priv->adsp->pa_dram, priv->adsp->dramsize);
> +		return -ENOMEM;
> +	}
> +
> +	priv->adsp->va_dram = sdev->bar[SOF_FW_BLK_TYPE_SRAM];
> +
> +	dev_dbg(sdev->dev, "pa_dram %pa, va: %pa, size %#x\n",
> +		&priv->adsp->pa_dram, &priv->adsp->va_dram, priv->adsp->dramsize);
> +
> +	sdev->bar[DSP_REG_BAR] = priv->adsp->va_cfgreg;
> +	sdev->bar[DSP_SECREG_BAR] = priv->adsp->va_secreg;
> +	sdev->bar[DSP_BUSREG_BAR] = priv->adsp->va_busreg;
> +
> +	sdev->mmio_bar = SOF_FW_BLK_TYPE_SRAM;
> +	sdev->mailbox_bar = SOF_FW_BLK_TYPE_SRAM;
> +
> +	/* set default mailbox offset for FW ready message */
> +	sdev->dsp_box.offset = mt8196_get_mailbox_offset(sdev);
> +
> +	/* enable adsp clock before touching registers */
> +	ret = mt8196_adsp_init_clock(sdev);
> +	if (ret) {
> +		dev_err(sdev->dev, "mt8196_adsp_init_clock failed\n");
> +		return ret;
> +	}
> +
> +	ret = mt8196_adsp_clock_on(sdev);
> +	if (ret) {
> +		dev_err(sdev->dev, "mt8196_adsp_clock_on fail!\n");
> +		return ret;
> +	}
> +
> +	ret = adsp_memory_remap_init(sdev, priv->adsp);
> +	if (ret) {
> +		dev_err(sdev->dev, "adsp_memory_remap_init fail!\n");
> +		return ret;
> +	}
> +
> +	adsp_sram_power_on(sdev);
> +
> +	priv->ipc_dev = platform_device_register_data(&pdev->dev, "mtk-adsp-ipc",
> +						      PLATFORM_DEVID_NONE,
> +						      pdev, sizeof(*pdev));
> +	if (IS_ERR(priv->ipc_dev)) {
> +		ret = PTR_ERR(priv->ipc_dev);
> +		dev_err(sdev->dev, "failed to create mtk-adsp-ipc device\n");
> +		goto err_adsp_off;
> +	}
> +
> +	priv->dsp_ipc = dev_get_drvdata(&priv->ipc_dev->dev);
> +	if (!priv->dsp_ipc) {
> +		ret = -EPROBE_DEFER;
> +		dev_err(sdev->dev, "failed to get drvdata\n");
> +		goto exit_pdev_unregister;
> +	}
> +
> +	mtk_adsp_ipc_set_data(priv->dsp_ipc, priv);
> +	priv->dsp_ipc->ops = &dsp_ops;
> +
> +	return 0;
> +
> +exit_pdev_unregister:
> +	platform_device_unregister(priv->ipc_dev);
> +err_adsp_off:
> +	adsp_sram_power_off(sdev);
> +	mt8196_adsp_clock_off(sdev);
> +
> +	return ret;
> +}
> +
> +static void mt8196_dsp_remove(struct snd_sof_dev *sdev)
> +{
> +	struct adsp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	platform_device_unregister(priv->ipc_dev);
> +	mt8196_sof_hifixdsp_shutdown(sdev);
> +	adsp_sram_power_off(sdev);
> +	mt8196_adsp_clock_off(sdev);
> +}
> +
> +static int mt8196_dsp_shutdown(struct snd_sof_dev *sdev)
> +{

exactly the same as mt8186, 8195

> +	return snd_sof_suspend(sdev->dev);
> +}
> +
> +static int mt8196_dsp_suspend(struct snd_sof_dev *sdev, u32 target_state)
> +{
> +	struct adsp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_IO_CONFIG, ADSP_CLK_SEL, 0);
> +	clk_set_parent(priv->clk[CLK_TOP_AUDIODSP], priv->clk[CLK_TOP_SYS_CLK]);
> +	mt8196_sof_hifixdsp_shutdown(sdev);
> +	adsp_sram_power_off(sdev);
> +	mt8196_adsp_clock_off(sdev);
> +
> +	return 0;
> +}
> +
> +static int mt8196_dsp_resume(struct snd_sof_dev *sdev)
> +{
> +	int ret;
> +	struct adsp_priv *priv = sdev->pdata->hw_pdata;
> +
> +	ret = mt8196_adsp_clock_on(sdev);
> +	if (ret) {
> +		dev_err(sdev->dev, "mt8196_adsp_clock_on fail!");
> +		return ret;
> +	}
> +
> +	clk_set_parent(priv->clk[CLK_TOP_AUDIODSP], priv->clk[CLK_TOP_ADSPPLL]);
> +	snd_sof_dsp_update_bits(sdev, DSP_REG_BAR, ADSP_IO_CONFIG, ADSP_CLK_SEL, BIT(31));
> +	adsp_sram_power_on(sdev);
> +
> +	return 0;
> +}
> +
> +static void mt8196_adsp_dump(struct snd_sof_dev *sdev, u32 flags)
> +{
> +	u32 dbg_pc, dbg_data, dbg_inst, dbg_ls0stat, dbg_status, faultinfo;
> +
> +	/* dump debug registers */
> +	dbg_pc = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGPC);
> +	dbg_data = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGDATA);
> +	dbg_inst = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGINST);
> +	dbg_ls0stat = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGLS0STAT);
> +	dbg_status = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PDEBUGSTATUS);
> +	faultinfo = snd_sof_dsp_read(sdev, DSP_REG_BAR, DSP_PFAULTINFO);
> +
> +	dev_info(sdev->dev, "adsp dump : pc %#x, data %#x, dbg_inst %#x,",
> +		 dbg_pc, dbg_data, dbg_inst);
> +	dev_info(sdev->dev, "ls0stat %#x, status %#x, faultinfo %#x",
> +		 dbg_ls0stat, dbg_status, faultinfo);
> +
> +	mtk_adsp_dump(sdev, flags);
> +}
> +
> +/*
> + * DL_24CH, DL1, UL0, UL1, UL2 are registered as SOF FE, so creating the corresponding
> + * SOF BE to complete the pipeline.
> + */
> +static struct snd_soc_dai_driver mt8196_dai[] = {
> +{
> +	.name = "SOF_DL_24CH",
> +	.playback = {
> +		.channels_min = CHAN_MIN,

Just write 1 and 2 and remove that CHAN_MIN/CHAN_MAX definition from the header.
Alternatively, always use the definition.

Having a definition though is not worth it in this case imo.

> +		.channels_max = CHAN_MAX,
> +	},
> +},
> +{
> +	.name = "SOF_DL1",
> +	.playback = {
> +		.channels_min = CHAN_MIN,
> +		.channels_max = CHAN_MAX,
> +	},
> +},
> +{
> +	.name = "SOF_UL0",
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 2,
> +	},
> +},
> +{
> +	.name = "SOF_UL1",
> +	.capture = {
> +		.channels_min = CHAN_MIN,
> +		.channels_max = CHAN_MAX,
> +	},
> +},
> +{
> +	.name = "SOF_UL2",
> +	.capture = {
> +		.channels_min = CHAN_MIN,
> +		.channels_max = CHAN_MAX,
> +	},
> +},
> +};
> +
> +/* mt8196 ops */
> +static const struct snd_sof_dsp_ops sof_mt8196_ops = {
> +	/* probe and remove */
> +	.probe		= mt8196_dsp_probe,
> +	.remove		= mt8196_dsp_remove,
> +	.shutdown	= mt8196_dsp_shutdown,
> +
> +	/* DSP core boot */
> +	.run		= mt8196_run,
> +
> +	/* Block IO */
> +	.block_read	= sof_block_read,
> +	.block_write	= sof_block_write,
> +
> +	/* Mailbox IO */
> +	.mailbox_read	= sof_mailbox_read,
> +	.mailbox_write	= sof_mailbox_write,
> +
> +	/* Register IO */
> +	.write		= sof_io_write,
> +	.read		= sof_io_read,
> +	.write64	= sof_io_write64,
> +	.read64		= sof_io_read64,
> +
> +	/* ipc */
> +	.send_msg		= mtk_adsp_send_msg,
> +	.get_mailbox_offset	= mt8196_get_mailbox_offset,
> +	.get_window_offset	= mt8196_get_window_offset,
> +	.ipc_msg_data		= sof_ipc_msg_data,
> +	.set_stream_data_offset = sof_set_stream_data_offset,
> +
> +	/* misc */
> +	.get_bar_index	= mtk_adsp_get_bar_index,
> +
> +	/* stream callbacks */
> +	.pcm_open	= sof_stream_pcm_open,
> +	.pcm_hw_params	= mtk_adsp_stream_pcm_hw_params,
> +	.pcm_pointer	= mtk_adsp_stream_pcm_pointer,
> +	.pcm_close	= sof_stream_pcm_close,
> +
> +	/* firmware loading */
> +	.load_firmware	= snd_sof_load_firmware_memcpy,
> +
> +	/* Firmware ops */
> +	.dsp_arch_ops = &sof_xtensa_arch_ops,
> +
> +	/* DAI drivers */
> +	.drv		= mt8196_dai,
> +	.num_drv	= ARRAY_SIZE(mt8196_dai),
> +
> +	/* Debug information */
> +	.dbg_dump = mt8196_adsp_dump,
> +	.debugfs_add_region_item = snd_sof_debugfs_add_region_item_iomem,
> +
> +	/* PM */
> +	.suspend	= mt8196_dsp_suspend,
> +	.resume		= mt8196_dsp_resume,
> +
> +	/* ALSA HW info flags */
> +	.hw_info =	SNDRV_PCM_INFO_MMAP |
> +			SNDRV_PCM_INFO_MMAP_VALID |
> +			SNDRV_PCM_INFO_INTERLEAVED |
> +			SNDRV_PCM_INFO_PAUSE |
> +			SNDRV_PCM_INFO_NO_PERIOD_WAKEUP,
> +};
> +
> +static struct snd_sof_of_mach sof_mt8196_machs[] = {
> +	{
> +		.compatible = "mediatek,mt8196",
> +		.sof_tplg_filename = "sof-mt8196.tplg",
> +	},
> +	{}
> +};
> +
> +static const struct sof_dev_desc sof_of_mt8196_desc = {
> +	.of_machines = sof_mt8196_machs,
> +	.ipc_supported_mask	= BIT(SOF_IPC_TYPE_3),
> +	.ipc_default		= SOF_IPC_TYPE_3,
> +	.default_fw_path = {
> +		[SOF_IPC_TYPE_3] = "mediatek/sof",
> +	},
> +	.default_tplg_path = {
> +		[SOF_IPC_TYPE_3] = "mediatek/sof-tplg",
> +	},
> +	.default_fw_filename = {
> +		[SOF_IPC_TYPE_3] = "sof-mt8196.ri",
> +	},
> +	.nocodec_tplg_filename = "sof-mt8196-nocodec.tplg",
> +	.ops = &sof_mt8196_ops,
> +};
> +
> +static const struct of_device_id sof_of_mt8196_ids[] = {
> +	{ .compatible = "mediatek,mt8196-dsp", .data = &sof_of_mt8196_desc},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sof_of_mt8196_ids);
> +
> +/* DT driver definition */
> +static struct platform_driver snd_sof_of_mt8196_driver = {
> +	.probe = sof_of_probe,
> +	.remove = sof_of_remove,
> +	.shutdown = sof_of_shutdown,
> +	.driver = {
> +	.name = "sof-audio-of-mt8196",
> +		.pm = pm_ptr(&sof_of_pm),
> +		.of_match_table = sof_of_mt8196_ids,
> +	},
> +};
> +module_platform_driver(snd_sof_of_mt8196_driver);
> +
> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_DESCRIPTION("SOF support for MT8196 platforms");
> +MODULE_IMPORT_NS("SND_SOC_SOF_XTENSA");
> +MODULE_IMPORT_NS("SND_SOC_SOF_MTK_COMMON");
> diff --git a/sound/soc/sof/mediatek/mt8196/mt8196.h b/sound/soc/sof/mediatek/mt8196/mt8196.h
> new file mode 100644
> index 000000000000..5d2e14827bc2
> --- /dev/null
> +++ b/sound/soc/sof/mediatek/mt8196/mt8196.h
> @@ -0,0 +1,124 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> +/*
> + * Copyright(c) 2025 MediaTek Inc. All rights reserved.
> + * Author: Hailong Fan <hailong.fan@mediatek.com>
> + */
> +
> +#ifndef __MT8196_H
> +#define __MT8196_H

Let's start using better definitions for those headers.

#ifndef __SOF_MEDIATEK_MT8196_H
#define __SOF_MEDIATEK_MT8196_H

> +
> +struct mtk_adsp_chip_info;
> +struct snd_sof_dev;

Regards,
Angelo

