Return-Path: <linux-kernel+bounces-811379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 477F7B52844
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F31B1BC81F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DE4255F3F;
	Thu, 11 Sep 2025 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b="LnFIe4Ix"
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B051547EE;
	Thu, 11 Sep 2025 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757569674; cv=none; b=ODL6n9hOZmt0IHHXIH+q/Qj3gAM56xQ5zl8QKIL3fJwEDasl5/s4b1t2fCBKpcuKRZQHBr/Cn3crEpIPDqCZemipd+k6xj35u+ct9cGFgsax5+Hm4IK1Dt1epLBmD38KsnWOe3xKdbmUGqU0m1H29+e1rdb/xgvAToRPxnIm8Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757569674; c=relaxed/simple;
	bh=zK8LMmHbIkTY2CxWFVEckzWhjuSEBhp0hFGvp9BouSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UZfg8mdTCB5VyHGUwQrAe2nlE1mMrLO/s1ssumS7M41nGyFURxRq+Ii9xdl4IOejxHYhxmfBKSSM7pxhlPXLb6t6a61UxeY4wicgbsQGEEcoWsrlR3gnE5DGz+gqTQL4XUYvLhIMgMqMO8qj2R8QWCP4ZpsubEjZ+FhioHCOwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com; spf=none smtp.mailfrom=linux.spacemit.com; dkim=pass (1024-bit key) header.d=linux.spacemit.com header.i=@linux.spacemit.com header.b=LnFIe4Ix; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.spacemit.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.spacemit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
	s=mxsw2412; t=1757569654;
	bh=ncwgHCcAhrlegs4GgjUefcgixGpNnD5+gsnZBPYmo0c=;
	h=From:Date:Subject:MIME-Version:Message-Id:To;
	b=LnFIe4IxQNQg5pqhJ2Nm7JSej/oRSE/xfStVCBM+QY+OceALgjCyflXW40HNxQJMo
	 gY6oAtEviV17a3X88twZQdvHwW0I6Jsv/UAm2R+LwiFfv8ApDfDhn9n0MLPY+Gcuey
	 bXFfYaX631O27xS9ihqd5i2tQ2GmlnxTH/rptjUY=
X-QQ-mid: zesmtpsz1t1757569648ta7f41e22
X-QQ-Originating-IP: Vja+2/xRh6ptXbvrjpjcQe7X9DVN6iu3VNss6D1uFv4=
Received: from = ( [61.145.255.150])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 11 Sep 2025 13:47:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9312944315426298178
EX-QQ-RecipientCnt: 16
From: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Date: Thu, 11 Sep 2025 13:47:11 +0800
Subject: [PATCH v3 2/2] ASoC: spacemit: add i2s support for K1 SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-k1-i2s-v3-2-57f173732f9c@linux.spacemit.com>
References: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
In-Reply-To: <20250911-k1-i2s-v3-0-57f173732f9c@linux.spacemit.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Jinmei Wei <weijinmei@linux.spacemit.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757569637; l=16194;
 i=troy.mitchell@linux.spacemit.com; s=20250710; h=from:subject:message-id;
 bh=zK8LMmHbIkTY2CxWFVEckzWhjuSEBhp0hFGvp9BouSo=;
 b=uiV7AwrekF7p/xZPofxHkZ2DLiv/LIzAJcnc2dGfd01VkmYk032bwNzAWveXowP1TVxbRxbDz
 q+0A3G6G0baAqRwa7Erz/b7oFkwK4U03/CrYkFsQWAtyGZMxcmSlWNg
X-Developer-Key: i=troy.mitchell@linux.spacemit.com; a=ed25519;
 pk=lQa7BzLrq8DfZnChqmwJ5qQk8fP2USmY/4xZ2/MSsXc=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:linux.spacemit.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: NeEWVnpZ66Aw75s349msFNTZRioK1z9Q6N8O8vtJbLNe6kyGZUdUrnok
	NqQRl9RysnKHWvEjVk5uHHHVsqNJ08y+Z9du9JHnIyKsMtAEK0MBVuyom48xFYRoNqvrGXt
	1tkqANDzdWhskhtZn4fbvwIY/sUTfacjqFgZWsFR9oG5a0KxXKDMxj9k7oRxNExgHyvp7wZ
	FmpNv2SD8IPF6DPx/YBib7diOhRvC/Xa8FXNPrblosWv2Ih8BcMMNCyVmQFoqksmECW+TnK
	vo7rsbxeIdYUkF3s0dPvz1wgFDvLbXm17mzgoDM6oy8t1GK0PcE+gMh1bxrKeSkHOC5WYKW
	DL2FDQwQy6rireXKFKXzKf+f17Z/prqU8r91B4EaWjPnuV+WV86nEgrX75FOQC1d5zYg8VL
	ES5X6vAnsOGaeFckJl3pp7UU7Y/RXqwSq8ZcMEpR5MA1n/szE+/thBi0+2tKsVJf51HrZEM
	jh4Z36/l9PcJxwJRzeINZ0euEQt7dChQ7yj1rq3VrxEfp4kXWU6tWXV8V+t7YwBb/P0vs25
	W9oUU8kXdziLwQKLRRNZm+MKlTkvMPzHZIydAEpTFnld4L7XmVhd5w6CuuqgJyRN+HQ2DAr
	iZ9u6esOgwXQCXh1p00rmeiOAESQQGVjDaucV57dsnEs6VmMPC8lHo+p79XqRkyjgmVgUoD
	B41N6WyrHEU5jPsJdx+vIWSzXuELxvgee4+TtqwRVN0IUyL6fbnOFrcAfX02LRpUXNhQac+
	n9d2oWuK2ArspwyJVc7CH2HlFEXGHmIPw5nvehiJDq53r8fOGSNgYMloawAMOseV3lojgD2
	UHamnff6MR26FAXPVwwuMbLluZStylOzXWT4VHP1QgKmeL0Sq5SYgYNJ2tFm6MaDc3ELuxR
	nyhCFHI48h3zcer10bEC5cuR5bncJs0lC54uwIX7OkYYVAUwtL3sOBp/Vkoc6Hz+koxcsdx
	buymjoQhuXL2eFY2UWJlENg6hKfpERpytgTRPrCTZURNtG9yXYGxyajyuRBhCJaCet4q0cy
	ZuLNKYs03nzSDXLALgbXugmGOa6fN+7QOTsFuXdyVfoyua1pZBtsWujsmNrIka4vDdlH1k7
	g/ALnMcOcdhH79CLQUWCHXkSZGG3HRCOg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Add ASoC platform driver for the SpacemiT K1 SoC full-duplex I2S
controller.

Co-developer: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Jinmei Wei <weijinmei@linux.spacemit.com>
Signed-off-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
---
 sound/soc/Kconfig           |   1 +
 sound/soc/Makefile          |   1 +
 sound/soc/spacemit/Kconfig  |  16 ++
 sound/soc/spacemit/Makefile |   5 +
 sound/soc/spacemit/k1_i2s.c | 444 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 467 insertions(+)

diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index ce74818bd7152dbe110b9fff7d908b0ddf34a9f5..36e0d443ba0ebe584ffe797c378c838f448ffcb9 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -127,6 +127,7 @@ source "sound/soc/renesas/Kconfig"
 source "sound/soc/rockchip/Kconfig"
 source "sound/soc/samsung/Kconfig"
 source "sound/soc/sdca/Kconfig"
+source "sound/soc/spacemit/Kconfig"
 source "sound/soc/spear/Kconfig"
 source "sound/soc/sprd/Kconfig"
 source "sound/soc/starfive/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 462322c38aa42d4c394736239de0317d5918d5a7..8c0480e6484e75eb0b6db306630ba77d259ba8e3 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_SND_SOC)	+= rockchip/
 obj-$(CONFIG_SND_SOC)	+= samsung/
 obj-$(CONFIG_SND_SOC)	+= sdca/
 obj-$(CONFIG_SND_SOC)	+= sof/
+obj-$(CONFIG_SND_SOC)	+= spacemit/
 obj-$(CONFIG_SND_SOC)	+= spear/
 obj-$(CONFIG_SND_SOC)	+= sprd/
 obj-$(CONFIG_SND_SOC)	+= starfive/
diff --git a/sound/soc/spacemit/Kconfig b/sound/soc/spacemit/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..2179f94f3f179c54cd06e6ced5523ed3f5225cf4
--- /dev/null
+++ b/sound/soc/spacemit/Kconfig
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "SpacemiT"
+	depends on COMPILE_TEST || ARCH_SPACEMIT
+	depends on HAVE_CLK
+
+config SND_SOC_K1_I2S
+	tristate "K1 I2S Device Driver"
+	select SND_SOC_GENERIC_DMAENGINE_PCM
+	select CMA
+	select DMA_CMA
+	help
+	  Say Y or M if you want to add support for I2S driver for
+	  K1 I2S controller. The device supports up to maximum of
+	  2 channels each for play and record.
+
+endmenu
diff --git a/sound/soc/spacemit/Makefile b/sound/soc/spacemit/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..9069de8ef89c84db8cc7d3a4d3b154fff9bd7aff
--- /dev/null
+++ b/sound/soc/spacemit/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+# K1 Platform Support
+snd-soc-k1-i2s-y := k1_i2s.o
+
+obj-$(CONFIG_SND_SOC_K1_I2S) += snd-soc-k1-i2s.o
diff --git a/sound/soc/spacemit/k1_i2s.c b/sound/soc/spacemit/k1_i2s.c
new file mode 100644
index 0000000000000000000000000000000000000000..bd3eb178e51cb76f824d9960a093eae0af55bfac
--- /dev/null
+++ b/sound/soc/spacemit/k1_i2s.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Troy Mitchell <troy.mitchell@linux.spacemit.com> */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+#include <sound/dmaengine_pcm.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+
+#define SSCR			0x00	/* SPI/I2S top control register */
+#define SSFCR			0x04	/* SPI/I2S FIFO control register */
+#define SSINTEN			0x08	/* SPI/I2S interrupt enable register */
+#define SSDATR			0x10	/* SPI/I2S data register */
+#define SSPSP			0x18	/* SPI/I2S programmable serial protocol control register */
+#define SSRWT			0x24	/* SPI/I2S root control register */
+
+/* SPI/I2S Work data size, register bits value 0~31 indicated data size 1~32 bits */
+#define SSCR_FIELD_DSS		GENMASK(9, 5)
+#define SSCR_DW_8BYTE		FIELD_PREP(SSCR_FIELD_DSS, 0x7)
+#define SSCR_DW_16BYTE		FIELD_PREP(SSCR_FIELD_DSS, 0xf)
+#define SSCR_DW_18BYTE		FIELD_PREP(SSCR_FIELD_DSS, 0x11)
+#define SSCR_DW_32BYTE		FIELD_PREP(SSCR_FIELD_DSS, 0x1f)
+
+#define SSCR_SSE		BIT(0)		/* SPI/I2S Enable */
+#define SSCR_FRF_PSP		GENMASK(2, 1)	/* Frame Format*/
+#define SSCR_TRAIL		BIT(13)		/* Trailing Byte */
+
+#define SSFCR_FIELD_TFT		GENMASK(3, 0)   /* TXFIFO Trigger Threshold */
+#define SSFCR_FIELD_RFT		GENMASK(8, 5)   /* RXFIFO Trigger Threshold */
+#define SSFCR_TSRE		BIT(10)		/* Transmit Service Request Enable */
+#define SSFCR_RSRE		BIT(11)		/* Receive Service Request Enable */
+
+#define SSPSP_FSRT		BIT(3)		/* Frame Sync Relative Timing Bit */
+#define SSPSP_SFRMP		BIT(4)		/* Serial Frame Polarity */
+#define SSPSP_FIELD_SFRMWDTH	GENMASK(17, 12)	/* Serial Frame Width field  */
+
+#define SSRWT_RWOT		BIT(0)		/* Receive Without Transmit */
+
+#define SPACEMIT_PCM_RATES	SNDRV_PCM_RATE_8000_192000
+#define SPACEMIT_PCM_FORMATS	(SNDRV_PCM_FMTBIT_S8 | \
+				 SNDRV_PCM_FMTBIT_S16_LE | \
+				 SNDRV_PCM_FMTBIT_S24_LE | \
+				 SNDRV_PCM_FMTBIT_S32_LE)
+
+#define SPACEMIT_I2S_PERIOD_SIZE 1024
+
+struct spacemit_i2s_dev {
+	struct device *dev;
+
+	void __iomem *base;
+
+	struct reset_control *reset;
+
+	struct clk *sysclk;
+	struct clk *bclk;
+	struct clk *sspa_clk;
+
+	struct snd_dmaengine_dai_dma_data capture_dma_data;
+	struct snd_dmaengine_dai_dma_data playback_dma_data;
+
+	bool has_capture;
+	bool has_playback;
+
+	int dai_fmt;
+
+	int started_count;
+};
+
+static const struct snd_pcm_hardware spacemit_pcm_hardware = {
+	.info		  = SNDRV_PCM_INFO_INTERLEAVED |
+			    SNDRV_PCM_INFO_BATCH,
+	.formats          = SPACEMIT_PCM_FORMATS,
+	.rates		  = SPACEMIT_PCM_RATES,
+	.rate_min         = SNDRV_PCM_RATE_8000,
+	.rate_max         = SNDRV_PCM_RATE_192000,
+	.channels_min     = 1,
+	.channels_max     = 2,
+	.buffer_bytes_max = SPACEMIT_I2S_PERIOD_SIZE * 4 * 4,
+	.period_bytes_min = SPACEMIT_I2S_PERIOD_SIZE * 2,
+	.period_bytes_max = SPACEMIT_I2S_PERIOD_SIZE * 4,
+	.periods_min	  = 2,
+	.periods_max	  = 4,
+};
+
+static const struct snd_dmaengine_pcm_config spacemit_dmaengine_pcm_config = {
+	.pcm_hardware = &spacemit_pcm_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
+	.chan_names = {"tx", "rx"},
+	.prealloc_buffer_size = 32 * 1024,
+};
+
+static void spacemit_i2s_init(struct spacemit_i2s_dev *i2s)
+{
+	u32 sscr_val, sspsp_val, ssfcr_val, ssrwt_val;
+
+	sscr_val = SSCR_TRAIL | SSCR_FRF_PSP;
+	ssfcr_val = FIELD_PREP(SSFCR_FIELD_TFT, 5) |
+		    FIELD_PREP(SSFCR_FIELD_RFT, 5) |
+		    SSFCR_RSRE | SSFCR_TSRE;
+	ssrwt_val = SSRWT_RWOT;
+
+	/* SSPSP register was set by set_fmt */
+	sspsp_val = readl(i2s->base + SSPSP);
+	sspsp_val |= SSPSP_SFRMP;
+
+	writel(sscr_val, i2s->base + SSCR);
+	writel(ssfcr_val, i2s->base + SSFCR);
+	writel(sspsp_val, i2s->base + SSPSP);
+	writel(ssrwt_val, i2s->base + SSRWT);
+	writel(0, i2s->base + SSINTEN);
+}
+
+static int spacemit_i2s_hw_params(struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_soc_dai *dai)
+{
+	struct spacemit_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	struct snd_dmaengine_dai_dma_data *dma_data;
+	u32 data_width, data_bits;
+	unsigned long bclk_rate;
+	u32 val;
+	int ret;
+
+	val = readl(i2s->base + SSCR);
+	if (val & SSCR_SSE)
+		return 0;
+
+	dma_data = &i2s->playback_dma_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		dma_data = &i2s->capture_dma_data;
+
+	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		data_bits = 8;
+		data_width = SSCR_DW_8BYTE;
+		dma_data->maxburst = 8;
+		dma_data->addr_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+		break;
+	case SNDRV_PCM_FORMAT_S16_LE:
+		data_bits = 16;
+		data_width = SSCR_DW_16BYTE;
+		dma_data->maxburst = 16;
+		dma_data->addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		if ((i2s->dai_fmt & SND_SOC_DAIFMT_FORMAT_MASK) == SND_SOC_DAIFMT_I2S) {
+			data_width = SSCR_DW_32BYTE;
+			dma_data->maxburst = 32;
+			dma_data->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		}
+		break;
+	case SNDRV_PCM_FORMAT_S32_LE:
+		data_bits = 32;
+		data_width = SSCR_DW_32BYTE;
+		dma_data->maxburst = 32;
+		dma_data->addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
+	default:
+		dev_dbg(i2s->dev, "unexpected data width type");
+		return -EINVAL;
+	}
+
+	val = readl(i2s->base + SSCR);
+	val &= ~SSCR_DW_32BYTE;
+	val |= data_width;
+	writel(val, i2s->base + SSCR);
+
+	bclk_rate = params_channels(params) *
+		    params_rate(params) *
+		    data_bits;
+
+	ret = clk_set_rate(i2s->bclk, bclk_rate);
+	if (ret)
+		return ret;
+
+	return clk_set_rate(i2s->sspa_clk, bclk_rate);
+}
+
+static int spacemit_i2s_set_sysclk(struct snd_soc_dai *cpu_dai, int clk_id,
+				   unsigned int freq, int dir)
+{
+	struct spacemit_i2s_dev *i2s = dev_get_drvdata(cpu_dai->dev);
+
+	if (freq == 0)
+		return 0;
+
+	return clk_set_rate(i2s->sysclk, freq);
+}
+
+static int spacemit_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
+				unsigned int fmt)
+{
+	struct spacemit_i2s_dev *i2s = dev_get_drvdata(cpu_dai->dev);
+	u32 sspsp_val;
+
+	sspsp_val = readl(i2s->base + SSPSP);
+	sspsp_val &= ~SSPSP_FIELD_SFRMWDTH;
+
+	i2s->dai_fmt = fmt;
+
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		cpu_dai->driver->playback.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		cpu_dai->driver->capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
+		sspsp_val |= FIELD_PREP(SSPSP_FIELD_SFRMWDTH, 0x10) |
+			     SSPSP_FSRT;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		sspsp_val |= SSPSP_FSRT;
+	case SND_SOC_DAIFMT_DSP_B:
+		cpu_dai->driver->playback.channels_min = 1;
+		cpu_dai->driver->playback.channels_max = 1;
+		cpu_dai->driver->capture.channels_min = 1;
+		cpu_dai->driver->capture.channels_max = 1;
+		cpu_dai->driver->playback.formats = SNDRV_PCM_FMTBIT_S32_LE;
+		cpu_dai->driver->capture.formats = SNDRV_PCM_FMTBIT_S32_LE;
+		sspsp_val |= FIELD_PREP(SSPSP_FIELD_SFRMWDTH, 0x1);
+		break;
+	default:
+		dev_dbg(i2s->dev, "unexpected format type");
+		return -EINVAL;
+	}
+
+	writel(sspsp_val, i2s->base + SSPSP);
+
+	return 0;
+}
+
+static int spacemit_i2s_trigger(struct snd_pcm_substream *substream,
+				int cmd, struct snd_soc_dai *dai)
+{
+	struct spacemit_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+	u32 val;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (!i2s->started_count) {
+			val = readl(i2s->base + SSCR);
+			val |= SSCR_SSE;
+			writel(val, i2s->base + SSCR);
+		}
+		i2s->started_count++;
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (i2s->started_count)
+			i2s->started_count--;
+
+		if (!i2s->started_count) {
+			val = readl(i2s->base + SSCR);
+			val &= ~SSCR_SSE;
+			writel(val, i2s->base + SSCR);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int spacemit_i2s_dai_probe(struct snd_soc_dai *dai)
+{
+	struct spacemit_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+
+	snd_soc_dai_init_dma_data(dai,
+				  i2s->has_playback ? &i2s->playback_dma_data : NULL,
+				  i2s->has_capture ? &i2s->capture_dma_data : NULL);
+
+	reset_control_deassert(i2s->reset);
+
+	spacemit_i2s_init(i2s);
+
+	return 0;
+}
+
+static int spacemit_i2s_dai_remove(struct snd_soc_dai *dai)
+{
+	struct spacemit_i2s_dev *i2s = snd_soc_dai_get_drvdata(dai);
+
+	reset_control_assert(i2s->reset);
+
+	return 0;
+}
+
+static const struct snd_soc_dai_ops spacemit_i2s_dai_ops = {
+	.probe = spacemit_i2s_dai_probe,
+	.remove = spacemit_i2s_dai_remove,
+	.hw_params = spacemit_i2s_hw_params,
+	.set_sysclk = spacemit_i2s_set_sysclk,
+	.set_fmt = spacemit_i2s_set_fmt,
+	.trigger = spacemit_i2s_trigger,
+};
+
+static struct snd_soc_dai_driver spacemit_i2s_dai = {
+	.ops = &spacemit_i2s_dai_ops,
+	.playback = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SPACEMIT_PCM_RATES,
+		.rate_min = SNDRV_PCM_RATE_8000,
+		.rate_max = SNDRV_PCM_RATE_192000,
+		.formats = SPACEMIT_PCM_FORMATS,
+	},
+	.capture = {
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = SPACEMIT_PCM_RATES,
+		.rate_min = SNDRV_PCM_RATE_8000,
+		.rate_max = SNDRV_PCM_RATE_192000,
+		.formats = SPACEMIT_PCM_FORMATS,
+	},
+	.symmetric_rate = 1,
+};
+
+static int spacemit_i2s_init_dai(struct spacemit_i2s_dev *i2s,
+				 struct snd_soc_dai_driver **dp,
+				 dma_addr_t addr)
+{
+	struct device_node *node = i2s->dev->of_node;
+	struct snd_soc_dai_driver *dai;
+	struct property *dma_names;
+	const char *dma_name;
+
+	of_property_for_each_string(node, "dma-names", dma_names, dma_name) {
+		if (!strcmp(dma_name, "tx"))
+			i2s->has_playback = true;
+		if (!strcmp(dma_name, "rx"))
+			i2s->has_capture = true;
+	}
+
+	dai = devm_kmemdup(i2s->dev, &spacemit_i2s_dai,
+			   sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	if (i2s->has_playback) {
+		dai->playback.stream_name = "Playback";
+		dai->playback.channels_min = 1;
+		dai->playback.channels_max = 2;
+		dai->playback.rates = SPACEMIT_PCM_RATES;
+		dai->playback.formats = SPACEMIT_PCM_FORMATS;
+
+		i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		i2s->playback_dma_data.maxburst = 32;
+		i2s->playback_dma_data.addr = addr;
+	}
+
+	if (i2s->has_capture) {
+		dai->capture.stream_name = "Capture";
+		dai->capture.channels_min = 1;
+		dai->capture.channels_max = 2;
+		dai->capture.rates = SPACEMIT_PCM_RATES;
+		dai->capture.formats = SPACEMIT_PCM_FORMATS;
+
+		i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
+		i2s->capture_dma_data.maxburst = 32;
+		i2s->capture_dma_data.addr = addr;
+	}
+
+	if (dp)
+		*dp = dai;
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver spacemit_i2s_component = {
+	.name = "i2s-k1",
+	.legacy_dai_naming = 1,
+};
+
+static int spacemit_i2s_probe(struct platform_device *pdev)
+{
+	struct snd_soc_dai_driver *dai;
+	struct spacemit_i2s_dev *i2s;
+	struct resource *res;
+	struct clk *clk;
+	int ret;
+
+	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
+	if (!i2s)
+		return -ENOMEM;
+
+	i2s->dev = &pdev->dev;
+
+	i2s->sysclk = devm_clk_get_enabled(i2s->dev, "sysclk");
+	if (IS_ERR(i2s->sysclk))
+		return dev_err_probe(i2s->dev, PTR_ERR(i2s->sysclk),
+				     "failed to enable sysbase clock\n");
+
+	i2s->bclk = devm_clk_get_enabled(i2s->dev, "bclk");
+	if (IS_ERR(i2s->bclk))
+		return dev_err_probe(i2s->dev, PTR_ERR(i2s->bclk), "failed to enable bit clock\n");
+
+	clk = devm_clk_get_enabled(i2s->dev, "sspa_bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa_bus clock\n");
+
+	i2s->sspa_clk = devm_clk_get_enabled(i2s->dev, "sspa");
+	if (IS_ERR(clk))
+		return dev_err_probe(i2s->dev, PTR_ERR(clk), "failed to enable sspa clock\n");
+
+	i2s->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(i2s->base))
+		return dev_err_probe(i2s->dev, PTR_ERR(i2s->base), "failed to map registers\n");
+
+	i2s->reset = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(i2s->reset))
+		return dev_err_probe(i2s->dev, PTR_ERR(i2s->reset),
+				     "failed to get reset control");
+
+	dev_set_drvdata(i2s->dev, i2s);
+
+	spacemit_i2s_init_dai(i2s, &dai, res->start + SSDATR);
+
+	ret = devm_snd_soc_register_component(i2s->dev,
+					      &spacemit_i2s_component,
+					      dai, 1);
+	if (ret)
+		return dev_err_probe(i2s->dev, ret, "failed to register component");
+
+	return devm_snd_dmaengine_pcm_register(&pdev->dev, &spacemit_dmaengine_pcm_config, 0);
+}
+
+static const struct of_device_id spacemit_i2s_of_match[] = {
+	{ .compatible = "spacemit,k1-i2s", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, spacemit_i2s_of_match);
+
+static struct platform_driver spacemit_i2s_driver = {
+	.probe = spacemit_i2s_probe,
+	.driver = {
+		.name = "i2s-k1",
+		.of_match_table = spacemit_i2s_of_match,
+	},
+};
+module_platform_driver(spacemit_i2s_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("I2S bus driver for SpacemiT K1 SoC");

-- 
2.51.0


