Return-Path: <linux-kernel+bounces-721472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB8AFC9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CBC11BC49C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 11:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8537F2153FB;
	Tue,  8 Jul 2025 11:31:24 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B48285C87;
	Tue,  8 Jul 2025 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974282; cv=none; b=nnesmF3JSxlH4QqUyrB3PsDP/+l2EeefJS21AtmlrjXDo8eemGWTow8ET8GoTOajfQtyoaXRttZ4QBF4hyBMj0GHcNbys3HX8guV1E9kO4Hy5m7gcZLxUUZ/o9W8qvMQaatI40HnRS+EKXz3RgqaZr8GVUAYmUOgm/CXc2e4GDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974282; c=relaxed/simple;
	bh=BRTjxPBImRecMrvZAylOg6ZzjVtShpqDlxqntWJ/NE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=foD3O6mzEZoMsjulC7NOX+GriuQmcGq8Z9E+dPFI8EFGzkV/lE9pszWqr7cekpuh1Dhfg7gr/14T4JjPkZjxwZMzeqhSKfpF1YCZYRI+jO6sDEOJ6C10ITsXKq+2AQMuzhQbhPhC3TI80/wYtipVO6nGanpHr3jDhI9ChTX96Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: esmtpgz15t1751974225t15677a54
X-QQ-Originating-IP: moFb2QHdrDEZnOtIx0ClQc2keOuy9EWsUQEnjuEAxMA=
Received: from localhost.localdomain ( [113.89.234.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Jul 2025 19:30:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16297108865135854922
EX-QQ-RecipientCnt: 14
From: Nick Li <nick.li@foursemi.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	nick.li@foursemi.com
Cc: xiaoming.yang@foursemi.com,
	danyang.zheng@foursemi.com,
	like.xy@foxmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
Date: Tue,  8 Jul 2025 19:29:01 +0800
Message-Id: <20250708112901.25228-5-nick.li@foursemi.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250708112901.25228-1-nick.li@foursemi.com>
References: <20250703035639.7252-1-nick.li@foursemi.com>
 <20250708112901.25228-1-nick.li@foursemi.com>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OO2wLqYBHUeB/+ciUlmwvPmdv8DG31RJgHTrvaGxnMhJ+X4D1JvzLXxY
	q+AUX3XraOk1g+8yguE6kggB3qTNhvMh32BZofp8Za566tKFbup3O7NBqfEZCNzfuDCW/5J
	i8HzygukqGj7nmZxSe+zrrzj8PrShs+SGz4LJKmJcdzhWO0yKH+1cPTMSJLaCTPnoH7EtLq
	b5z/FjMbNuYeK9nKZqz02RstKCZ2FdKynRinjF6g/B/PTxRmly2kDZrOcEL0x7uSZGtHH8L
	kDgxgfSdxAXVMhmPpJuOZWAVwt/yGw0TlHy5NiHeGqX3jnPo7mtd06hMFcuWtljY0PBUHIY
	9eckhe9z2G3i6b7J2tkD3ktiXkgZlhthtFNz/C3veIq8eBR431HU4zRt0ORtUASHQzQIIv5
	AN4KQbHpXdJiUFIJ4M35CvXg6BGMa0RFCLQJfCuE5KuOHYtxaBwAfascn79oMBZNQxa8oS4
	qzBmnQvhkBRVGFIa5drKgZhNBDfT8V7TPpnDracor1ZD/lxoFsSUFClLfwO6vO+8ytgDrgo
	Pm7pQT9F1yppt8fZz8kk6N4ycXWU0gF5nVojhktFESkJqXZ8ZpMy11diZyRuNYZxF3mUN4A
	Kq2v5dTNBdH6uZwNQCwL3mc99MrTTaG0nOf6X/4bcHHubXBk8Uf+bTTeTLl1Ex0dEy4g3Xq
	FXICX5ugO/ZQ0d9fbGUSIuHHO5m7tgDNVSnOfyKLvedsTE65FF+BOI0PHh6mJfte4Ge9b+1
	EKiEPsjuQ/7T5C2pyIjOJgqabRS7UA9T4mbjJqygtbzyZNtRL66kXMKFVXKpysGR+PrXSwO
	zWR5wPFhBpwEfAiJ1xQlkxe2Cm8PX3vnzdVTEuKave8/DAxsckGrt8ZsJDda72G6OEeJ2jq
	TWC0PQj3ufb1A6kJiplDvupaQw86lmqmSFDdyp65lrwaMI7XeSebptWzowFNji4+BVCz51G
	kq9k+sIw9mGlE7dM3lz8ywdpTcCRDNr9C7LZEon/9ZmhhQJMPNGh/geKEhDVwOWlqJ1n6YD
	aGpjHw3h3tfHssA6L9Q4hXSfw0WFYJrhoKzHzvIg==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The FS2104/5S are FourSemi digital audio amplifiers
with I2C control. They are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 sound/soc/codecs/Kconfig  |   11 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/fs210x.c | 1610 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/fs210x.h |   79 ++
 4 files changed, 1702 insertions(+)
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index ecdc05ef3..43fe512a5 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -125,6 +125,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_ES7134
 	imply SND_SOC_ES7241
 	imply SND_SOC_FRAMER
+	imply SND_SOC_FS210X
 	imply SND_SOC_GTM601
 	imply SND_SOC_HDAC_HDMI
 	imply SND_SOC_HDAC_HDA
@@ -1236,6 +1237,16 @@ config SND_SOC_FS_AMP_LIB
 	select CRC16
 	tristate
 
+config SND_SOC_FS210X
+	tristate 'FourSemi FS2104/5S digital audio amplifier'
+	depends on I2C
+	select GPIOLIB
+	select REGMAP_I2C
+	select SND_SOC_FS_AMP_LIB
+	help
+	  Enable support for FourSemi FS2104/5S digital audio amplifier
+	  with I2C control.
+
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 646e017a8..3f97afaaa 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -138,6 +138,7 @@ snd-soc-es8375-y := es8375.o
 snd-soc-es8389-y := es8389.o
 snd-soc-framer-y := framer-codec.o
 snd-soc-fs-amp-lib-y := fs-amp-lib.o
+snd-soc-fs210x-y := fs210x.o
 snd-soc-gtm601-y := gtm601.o
 snd-soc-hdac-hdmi-y := hdac_hdmi.o
 snd-soc-hdac-hda-y := hdac_hda.o
@@ -564,6 +565,7 @@ obj-$(CONFIG_SND_SOC_ES8375)    += snd-soc-es8375.o
 obj-$(CONFIG_SND_SOC_ES8389)    += snd-soc-es8389.o
 obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
 obj-$(CONFIG_SND_SOC_FS_AMP_LIB)+= snd-soc-fs-amp-lib.o
+obj-$(CONFIG_SND_SOC_FS210X)	+= snd-soc-fs210x.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
diff --git a/sound/soc/codecs/fs210x.c b/sound/soc/codecs/fs210x.c
new file mode 100644
index 000000000..5176b3399
--- /dev/null
+++ b/sound/soc/codecs/fs210x.c
@@ -0,0 +1,1610 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * fs210x.c -- Driver for the FS2104/5S Audio Amplifier
+ *
+ * Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "fs210x.h"
+#include "fs-amp-lib.h"
+
+#define FS210X_DRV_VERSION		"v1.0.6"
+#define FS210X_DEFAULT_FWM_NAME		"fs210x_fwm.bin"
+#define FS210X_DEFAULT_DAI_NAME		"fs210x-aif"
+#define FS2105S_DEVICE_ID		0x20 /* FS2105S */
+#define FS210X_DEVICE_ID		0x45 /* FS2104 */
+#define FS210X_REG_MAX			0xF8
+#define FS210X_VOLUME_MIN		0
+#define FS210X_VOLUME_MAX		511
+#define FS210X_INIT_SCENE		0
+#define FS210X_DEFAULT_SCENE		1
+#define FS210X_START_DELAY_MS		5
+#define FS210X_FAULT_CHECK_INTERVAL_MS	2000
+#define FS2105S_RATES			(SNDRV_PCM_RATE_32000 | \
+					 SNDRV_PCM_RATE_44100 | \
+					 SNDRV_PCM_RATE_48000 | \
+					 SNDRV_PCM_RATE_88200 | \
+					 SNDRV_PCM_RATE_96000)
+#define FS210X_RATES			(SNDRV_PCM_RATE_16000 | FS2105S_RATES)
+#define FS210X_FORMATS			(SNDRV_PCM_FMTBIT_S16_LE | \
+					 SNDRV_PCM_FMTBIT_S24_LE | \
+					 SNDRV_PCM_FMTBIT_S24_3LE | \
+					 SNDRV_PCM_FMTBIT_S32_LE)
+#define FS210X_NUM_SUPPLIES		ARRAY_SIZE(fs210x_supply_names)
+
+static const char *const fs210x_supply_names[] = {
+	"pvdd",
+	"dvdd",
+};
+
+struct fs210x_platform_data {
+	const char *fwm_name;
+};
+
+struct fs210x_priv {
+	struct i2c_client *i2c;
+	struct device *dev;
+	struct regmap *regmap;
+	struct fs210x_platform_data pdata;
+	struct regulator_bulk_data supplies[FS210X_NUM_SUPPLIES];
+	struct gpio_desc *gpio_sdz;
+	struct delayed_work start_work;
+	struct delayed_work fault_check_work;
+	struct fs_amp_lib amp_lib;
+	const struct fs_amp_scene *cur_scene;
+	struct clk *clk_bclk;
+	unsigned int bclk;
+	unsigned int srate;
+	int scene_id;
+	u16 devid;
+	u16 vol[2]; /* L/R channels volume */
+	bool is_inited;
+	bool is_suspended;
+	bool is_bclk_on;
+	bool is_playing;
+};
+
+static DEFINE_MUTEX(fs210x_mutex);
+
+static const struct fs_pll_div fs210x_pll_div[] = {
+	/*    bclk,   pll1,   pll2,   pll3 */
+	{   512000, 0x006C, 0x0120, 0x0001 },
+	{   768000, 0x016C, 0x00C0, 0x0001 },
+	{  1024000, 0x016C, 0x0090, 0x0001 },
+	{  1536000, 0x016C, 0x0060, 0x0001 },
+	{  2048000, 0x016C, 0x0090, 0x0002 },
+	{  2304000, 0x016C, 0x0080, 0x0002 },
+	{  3072000, 0x016C, 0x0090, 0x0003 },
+	{  4096000, 0x016C, 0x0090, 0x0004 },
+	{  4608000, 0x016C, 0x0080, 0x0004 },
+	{  6144000, 0x016C, 0x0090, 0x0006 },
+	{  8192000, 0x016C, 0x0090, 0x0008 },
+	{  9216000, 0x016C, 0x0090, 0x0009 },
+	{ 12288000, 0x016C, 0x0090, 0x000C },
+	{ 16384000, 0x016C, 0x0090, 0x0010 },
+	{ 18432000, 0x016C, 0x0090, 0x0012 },
+	{ 24576000, 0x016C, 0x0090, 0x0018 },
+	{  1411200, 0x016C, 0x0060, 0x0001 },
+	{  2116800, 0x016C, 0x0080, 0x0002 },
+	{  2822400, 0x016C, 0x0090, 0x0003 },
+	{  4233600, 0x016C, 0x0080, 0x0004 },
+	{  5644800, 0x016C, 0x0090, 0x0006 },
+	{  8467200, 0x016C, 0x0090, 0x0009 },
+	{ 11289600, 0x016C, 0x0090, 0x000C },
+	{ 16934400, 0x016C, 0x0090, 0x0012 },
+	{ 22579200, 0x016C, 0x0090, 0x0018 },
+	{  2000000, 0x017C, 0x0093, 0x0002 },
+};
+
+static int fs210x_bclk_set(struct fs210x_priv *fs210x, bool on)
+{
+	int ret = 0;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	if (!fs210x->clk_bclk)
+		return 0;
+
+	if ((fs210x->is_bclk_on ^ on) == 0)
+		return 0;
+
+	dev_dbg(fs210x->dev, "bclk switch %s\n", on ? "on" : "off");
+
+	if (on) {
+		clk_set_rate(fs210x->clk_bclk, fs210x->bclk);
+		ret = clk_prepare_enable(fs210x->clk_bclk);
+		fs210x->is_bclk_on = true;
+		usleep_range(2000, 2050); /* >= 2ms */
+	} else {
+		clk_disable_unprepare(fs210x->clk_bclk);
+		fs210x->is_bclk_on = false;
+	}
+
+	return ret;
+}
+
+static int fs210x_reg_write(struct fs210x_priv *fs210x,
+			    u8 reg, u16 val)
+{
+	int ret;
+
+	ret = regmap_write(fs210x->regmap, reg, val);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to write %02Xh: %d\n", reg, ret);
+		return ret;
+	}
+
+	dev_dbg(fs210x->dev, "RW: %02x %04x\n", reg, val);
+
+	return 0;
+}
+
+static int fs210x_reg_read(struct fs210x_priv *fs210x,
+			   u8 reg, u16 *pval)
+{
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(fs210x->regmap, reg, &val);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to read %02Xh: %d\n", reg, ret);
+		return ret;
+	}
+
+	if (pval)
+		*pval = (u16)val;
+
+	dev_dbg(fs210x->dev, "RR: %02x %04x\n", reg, val);
+
+	return 0;
+}
+
+static int fs210x_reg_update_bits(struct fs210x_priv *fs210x,
+				  u8 reg, u16 mask, u16 val)
+{
+	int ret;
+
+	ret = regmap_update_bits(fs210x->regmap, reg, mask, val);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to update %02Xh: %d\n", reg, ret);
+		return ret;
+	}
+
+	dev_dbg(fs210x->dev, "RU: %02x %04x %04x\n", reg, mask, val);
+
+	return 0;
+}
+
+static int fs210x_reg_bulk_write(struct fs210x_priv *fs210x,
+				 u8 reg, const void *val, u32 size)
+{
+	int ret;
+
+	ret = regmap_bulk_write(fs210x->regmap, reg, val, size / 2);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to bulk write %02Xh: %d\n",
+			reg, ret);
+		return ret;
+	}
+
+	dev_dbg(fs210x->dev, "BW: %02x %d\n", reg, size);
+
+	return 0;
+}
+
+static int fs210x_reg_dump(struct fs210x_priv *fs210x)
+{
+	u16 val[8]; /* 8 registers per line */
+	u8 idx, reg;
+	int ret;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+#define FS210X_REG_DUMP_MAX 0xCF
+	for (reg = 0x00; reg <= FS210X_REG_DUMP_MAX; reg++) {
+		/* Print 8 register values per line */
+		idx = (reg & 0x7);
+		ret = fs210x_reg_read(fs210x, reg, val + idx);
+		if (ret)
+			break;
+		if (idx != 0x7 && reg != FS210X_REG_DUMP_MAX)
+			continue;
+		dev_info(fs210x->dev,
+			 "%02Xh: %04x %04x %04x %04x %04x %04x %04x %04x\n",
+			 (reg & 0xF8), val[0], val[1], val[2],
+			 val[3], val[4], val[5], val[6], val[7]);
+	}
+
+	return ret;
+}
+
+static inline int fs210x_write_reg_val(struct fs210x_priv *fs210x,
+				       const struct fs_reg_val *regv)
+{
+	return fs210x_reg_write(fs210x, regv->reg, regv->val);
+}
+
+static inline int fs210x_write_reg_bits(struct fs210x_priv *fs210x,
+					const struct fs_reg_bits *regu)
+{
+	return fs210x_reg_update_bits(fs210x,
+				      regu->reg,
+				      regu->mask,
+				      regu->val);
+}
+
+static inline int fs210x_set_cmd_pkg(struct fs210x_priv *fs210x,
+				     const struct fs_cmd_pkg *pkg,
+				     unsigned int *offset)
+{
+	int delay_us;
+
+	if (pkg->cmd >= 0x00 && pkg->cmd <= FS210X_REG_MAX) {
+		*offset = sizeof(pkg->regv);
+		return fs210x_write_reg_val(fs210x, &pkg->regv);
+	} else if (pkg->cmd == FS_CMD_UPDATE) {
+		*offset = sizeof(pkg->regb);
+		return fs210x_write_reg_bits(fs210x, &pkg->regb);
+	} else if (pkg->cmd == FS_CMD_DELAY) {
+		if (pkg->regv.val > FS_CMD_DELAY_MS_MAX)
+			return -EOPNOTSUPP;
+		delay_us = pkg->regv.val * 1000;
+		usleep_range(delay_us, delay_us + 50);
+		*offset = sizeof(pkg->regv);
+		return 0;
+	}
+
+	dev_err(fs210x->dev, "Invalid pkg cmd: %d\n", pkg->cmd);
+
+	return -EOPNOTSUPP;
+}
+
+static int fs210x_reg_write_table(struct fs210x_priv *fs210x,
+				  const struct fs_reg_table *reg)
+{
+	const struct fs_cmd_pkg *pkg;
+	unsigned int index, offset;
+	int ret;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	if (!reg || reg->size == 0)
+		return -EFAULT;
+
+	for (index = 0; index < reg->size; index += offset) {
+		pkg = (struct fs_cmd_pkg *)(reg->buf + index);
+		ret = fs210x_set_cmd_pkg(fs210x, pkg, &offset);
+		if (ret) {
+			dev_err(fs210x->dev, "Failed to set cmd pkg: %02X-%d\n",
+				pkg->cmd, ret);
+			return ret;
+		}
+	}
+
+	if (index != reg->size) {
+		dev_err(fs210x->dev, "Invalid reg table size: %d-%d\n",
+			index, reg->size);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int fs210x_dev_play(struct fs210x_priv *fs210x)
+{
+	int ret;
+
+	if (!fs210x->is_inited)
+		return -EFAULT;
+
+	if (fs210x->is_playing)
+		return 0;
+
+	ret = fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+			       FS210X_11H_DPS_PLAY);
+	if (!ret)
+		fs210x->is_playing = true;
+
+	usleep_range(10000, 10050); /* >= 10ms */
+
+	return ret;
+}
+
+static int fs210x_dev_stop(struct fs210x_priv *fs210x)
+{
+	int ret;
+
+	if (!fs210x->is_inited)
+		return -EFAULT;
+
+	if (!fs210x->is_playing)
+		return 0;
+
+	ret = fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+			       FS210X_11H_DPS_PWDN);
+	fs210x->is_playing = false;
+
+	usleep_range(30000, 30050); /* >= 30ms */
+
+	return ret;
+}
+
+static int fs210x_set_reg_table(struct fs210x_priv *fs210x,
+				const struct fs_amp_scene *scene)
+{
+	const struct fs_amp_scene *cur_scene;
+	const struct fs_reg_table *reg;
+
+	if (!fs210x || !fs210x->dev || !scene)
+		return -EINVAL;
+
+	cur_scene = fs210x->cur_scene;
+	if (!scene->reg || cur_scene == scene) {
+		dev_dbg(fs210x->dev, "Skip writing reg table\n");
+		return 0;
+	}
+
+	reg = scene->reg;
+	dev_dbg(fs210x->dev, "reg table size: %d\n", reg->size);
+
+	return fs210x_reg_write_table(fs210x, reg);
+}
+
+static int fs210x_set_woofer_table(struct fs210x_priv *fs210x)
+{
+	const struct fs_file_table *woofer;
+	const struct fs_fwm_table *table;
+	int ret;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	/* NOTE: fs2105s has woofer ram only */
+	if (fs210x->devid != FS2105S_DEVICE_ID)
+		return 0;
+
+	table = fs210x->amp_lib.table[FS_INDEX_WOOFER];
+	if (!table) {
+		dev_dbg(fs210x->dev, "Skip writing woofer table\n");
+		return 0;
+	}
+
+	woofer = (struct fs_file_table *)table->buf;
+	dev_dbg(fs210x->dev, "woofer table size: %d\n", woofer->size);
+	/* Unit of woofer data is u32(4 bytes) */
+	if (woofer->size == 0 || (woofer->size & 0x3)) {
+		dev_err(fs210x->dev, "Invalid woofer size: %d\n",
+			woofer->size);
+		return -EINVAL;
+	}
+
+	ret = fs210x_reg_write(fs210x, FS210X_46H_DACEQA,
+			       FS2105S_46H_CAM_BURST_W);
+	ret |= fs210x_reg_bulk_write(fs210x, FS210X_42H_DACEQWL,
+				     woofer->buf, woofer->size);
+
+	return ret;
+}
+
+static int fs210x_set_effect_table(struct fs210x_priv *fs210x,
+				   const struct fs_amp_scene *scene)
+{
+	const struct fs_amp_scene *cur_scene;
+	const struct fs_file_table *effect;
+	int half_size;
+	int ret;
+
+	if (!fs210x || !fs210x->dev || !scene)
+		return -EINVAL;
+
+	cur_scene = fs210x->cur_scene;
+	if (!scene->effect || cur_scene == scene) {
+		dev_dbg(fs210x->dev, "Skip writing effect table\n");
+		return 0;
+	}
+
+	effect = scene->effect;
+	dev_dbg(fs210x->dev, "effect table size: %d\n", effect->size);
+
+	/* Unit of effect data is u32(4 bytes), 2 channels */
+	if (effect->size == 0 || (effect->size & 0x7)) {
+		dev_err(fs210x->dev, "Invalid effect size: %d\n",
+			effect->size);
+		return -EINVAL;
+	}
+
+	half_size = effect->size / 2;
+
+	/* Left channel */
+	ret = fs210x_reg_write(fs210x, FS210X_46H_DACEQA,
+			       FS210X_46H_CAM_BURST_L);
+	ret |= fs210x_reg_bulk_write(fs210x, FS210X_42H_DACEQWL,
+				     effect->buf, half_size);
+	if (ret)
+		return ret;
+
+	/* Right channel */
+	ret = fs210x_reg_write(fs210x, FS210X_46H_DACEQA,
+			       FS210X_46H_CAM_BURST_R);
+	ret |= fs210x_reg_bulk_write(fs210x, FS210X_42H_DACEQWL,
+				     effect->buf + half_size, half_size);
+
+	return ret;
+}
+
+static int fs210x_access_dsp_ram(struct fs210x_priv *fs210x, bool enable)
+{
+	int ret;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	if (enable) {
+		ret = fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+				       FS210X_11H_DPS_HIZ);
+		ret |= fs210x_reg_write(fs210x, FS210X_0BH_ACCKEY,
+					FS210X_0BH_ACCKEY_ON);
+	} else {
+		ret = fs210x_reg_write(fs210x, FS210X_0BH_ACCKEY,
+				       FS210X_0BH_ACCKEY_OFF);
+		ret |= fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+					FS210X_11H_DPS_PWDN);
+	}
+
+	usleep_range(10000, 10050); /* >= 10ms */
+
+	return ret;
+}
+
+static int fs210x_write_dsp_effect(struct fs210x_priv *fs210x,
+				   const struct fs_amp_scene *scene,
+				   int scene_id)
+{
+	int ret;
+
+	if (!fs210x || !scene)
+		return -EINVAL;
+
+	ret = fs210x_access_dsp_ram(fs210x, true);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to access dsp: %d\n", ret);
+		goto tag_exit;
+	}
+
+	ret = fs210x_set_effect_table(fs210x, scene);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to set effect: %d\n", ret);
+		goto tag_exit;
+	}
+
+	if (scene_id == FS210X_INIT_SCENE)
+		ret = fs210x_set_woofer_table(fs210x);
+
+tag_exit:
+	fs210x_reg_write(fs210x, FS210X_46H_DACEQA,
+			 FS210X_46H_CAM_CLEAR);
+	fs210x_access_dsp_ram(fs210x, false);
+
+	return ret;
+}
+
+static int fs210x_check_scene(struct fs210x_priv *fs210x,
+			      int scene_id, bool *skip_set)
+{
+	struct fs_amp_lib *amp_lib;
+
+	if (!fs210x || !skip_set)
+		return -EINVAL;
+
+	amp_lib = &fs210x->amp_lib;
+	if (amp_lib->scene_count == 0 || !amp_lib->scene) {
+		dev_err(fs210x->dev, "There's no scene data\n");
+		return -EINVAL;
+	}
+
+	if (scene_id < 0 || scene_id >= amp_lib->scene_count) {
+		dev_err(fs210x->dev, "Invalid scene_id: %d\n", scene_id);
+		return -EINVAL;
+	}
+
+	if (fs210x->scene_id == scene_id) {
+		dev_dbg(fs210x->dev, "Skip to set same scene\n");
+		return 0;
+	}
+
+	*skip_set = false;
+
+	return 0;
+}
+
+static int fs210x_set_scene(struct fs210x_priv *fs210x, int scene_id)
+{
+	const struct fs_amp_scene *scene;
+	bool skip_set = true;
+	bool is_playing;
+	int ret;
+
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	ret = fs210x_check_scene(fs210x, scene_id, &skip_set);
+	if (ret || skip_set)
+		return ret;
+
+	scene = fs210x->amp_lib.scene + scene_id;
+	dev_info(fs210x->dev, "Switch scene.%d: %s\n",
+		 scene_id, scene->name);
+
+	is_playing = fs210x->is_playing;
+	if (is_playing)
+		fs210x_dev_stop(fs210x);
+
+	ret = fs210x_set_reg_table(fs210x, scene);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to set reg: %d\n", ret);
+		return ret;
+	}
+
+	ret = fs210x_write_dsp_effect(fs210x, scene, scene_id);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to write ram: %d\n", ret);
+		return ret;
+	}
+
+	fs210x->cur_scene = scene;
+	fs210x->scene_id  = scene_id;
+
+	if (is_playing)
+		fs210x_dev_play(fs210x);
+
+	return 0;
+}
+
+static inline int volume_is_valid(u16 vol)
+{
+	return (vol <= FS210X_VOLUME_MAX);
+}
+
+static int fs210x_set_pcm_volume(struct fs210x_priv *fs210x)
+{
+	u16 vol[2];
+	int ret;
+
+	if (fs210x->devid == FS2105S_DEVICE_ID) {
+		/*
+		 * FS2105SE volume registers: 39h(Left)/3Ah(Right):
+		 * VOL[15:7]: 0 dB to -95.8125dB in steps of -0.1875dB
+		 * 1FFh: 0dB
+		 * 000h: -95.8125dB
+		 */
+		vol[0] = fs210x->vol[0] << FS2105S_39H_VOL_SHIFT;
+		vol[1] = fs210x->vol[1] << FS2105S_3AH_VOL_SHIFT;
+	} else {
+		/*
+		 * FS2104 volume registers: 39h(Left)/3Ah(Right):
+		 * VOL[15:6]: 0 dB to -131.8125dB in steps of -0.1875dB
+		 * 2BFh: 0dB
+		 * 0C0h: -95.8125dB
+		 * 000h: -131.8125dB
+		 * Offset between FS2104 and FS2105S: 2BFh-1FFh=0C0h
+		 */
+#define VOL_OFFSET (0x2BF - 0x1FF)
+		vol[0] = (fs210x->vol[0] + VOL_OFFSET) << FS210X_39H_VOL_SHIFT;
+		vol[1] = (fs210x->vol[1] + VOL_OFFSET) << FS210X_3AH_VOL_SHIFT;
+	}
+
+	ret  = fs210x_reg_write(fs210x, FS210X_39H_LVOLCTRL, vol[0]);
+	ret |= fs210x_reg_write(fs210x, FS210X_3AH_RVOLCTRL, vol[1]);
+
+	return ret;
+}
+
+static int fs210x_init_chip(struct fs210x_priv *fs210x)
+{
+	int scene_id;
+	int ret;
+
+	/* i2c reset */
+	ret = fs210x_reg_write(fs210x, FS210X_10H_PWRCTRL,
+			       FS210X_10H_I2C_RESET);
+	if (ret)
+		goto tag_power_down;
+
+	/* Wait >= 10ms for i2c resetting */
+	usleep_range(10000, 10050);
+
+	/* Backup scene id */
+	scene_id = fs210x->scene_id;
+	fs210x->scene_id = -1;
+
+	/* Init registers/RAM by init scene */
+	ret = fs210x_set_scene(fs210x, FS210X_INIT_SCENE);
+	if (ret)
+		goto tag_power_down;
+
+	/*
+	 * If the firmware has effect scene(s),
+	 * we load effect scene by default scene or scene_id
+	 */
+	if (fs210x->amp_lib.scene_count > 1) {
+		if (scene_id < FS210X_DEFAULT_SCENE)
+			scene_id = FS210X_DEFAULT_SCENE;
+		ret = fs210x_set_scene(fs210x, scene_id);
+		if (ret)
+			goto tag_power_down;
+	}
+
+	ret = fs210x_set_pcm_volume(fs210x);
+
+tag_power_down:
+	/* Power down the device */
+	ret |= fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+				FS210X_11H_DPS_PWDN);
+	if (!ret)
+		fs210x->is_inited = true;
+
+	return ret;
+}
+
+static void fs210x_sdz_pin_set(struct fs210x_priv *fs210x, bool active)
+{
+	if (!fs210x || !fs210x->gpio_sdz)
+		return;
+
+	/*
+	 * The SDZ pin(Shut Down) is active low, when it is pulled low,
+	 * it will trigger two procedures sequentially:
+	 * - Power down the chip;
+	 * - Reset the chip to shut down state.
+	 * NOTE:
+	 * The I2C communication is nack until the SDZ pin
+	 * is pulled up and wait 10ms at least.
+	 */
+	if (active) {
+		gpiod_set_value_cansleep(fs210x->gpio_sdz, 1);
+		dev_dbg(fs210x->dev, "SDZ pin is OFF\n");
+		usleep_range(30000, 30050); /* >= 30ms */
+	} else {
+		gpiod_set_value_cansleep(fs210x->gpio_sdz, 0);
+		dev_dbg(fs210x->dev, "SDZ pin is ON\n");
+		usleep_range(10000, 10050); /* >= 10ms */
+	}
+}
+
+static int fs210x_set_i2s_params(struct fs210x_priv *fs210x)
+{
+	const struct fs_i2s_srate params[] = {
+		{ 16000, 0x3 },
+		{ 32000, 0x7 },
+		{ 44100, 0x8 },
+		{ 48000, 0x9 },
+		{ 88200, 0xA },
+		{ 96000, 0xB },
+	};
+	u16 val;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(params); i++) {
+		if (params[i].srate != fs210x->srate)
+			continue;
+		val = params[i].i2ssr << FS210X_17H_I2SSR_SHIFT;
+		ret = fs210x_reg_update_bits(fs210x,
+					     FS210X_17H_I2SCTRL,
+					     FS210X_17H_I2SSR_MASK,
+					     val);
+		return ret;
+	}
+
+	dev_err(fs210x->dev, "Invalid sample rate: %d\n", fs210x->srate);
+
+	return -EINVAL;
+}
+
+static int fs210x_get_pll_div(struct fs210x_priv *fs210x,
+			      const struct fs_pll_div **pll_div)
+{
+	int i;
+
+	if (!fs210x || !pll_div)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(fs210x_pll_div); i++) {
+		if (fs210x_pll_div[i].bclk != fs210x->bclk)
+			continue;
+		*pll_div = fs210x_pll_div + i;
+		return 0;
+	}
+
+	dev_err(fs210x->dev, "No PLL table for bclk: %d\n", fs210x->bclk);
+
+	return -EFAULT;
+}
+
+static int fs210x_set_hw_params(struct fs210x_priv *fs210x)
+{
+	const struct fs_pll_div *pll_div;
+	int ret;
+
+	ret = fs210x_set_i2s_params(fs210x);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to set i2s params: %d\n", ret);
+		return ret;
+	}
+
+	/* Set pll params */
+	ret = fs210x_get_pll_div(fs210x, &pll_div);
+	if (ret)
+		return ret;
+
+	ret  = fs210x_reg_write(fs210x, FS210X_A1H_PLLCTRL1, pll_div->pll1);
+	ret |= fs210x_reg_write(fs210x, FS210X_A2H_PLLCTRL2, pll_div->pll2);
+	ret |= fs210x_reg_write(fs210x, FS210X_A3H_PLLCTRL3, pll_div->pll3);
+
+	return ret;
+}
+
+static int fs210x_mute(struct fs210x_priv *fs210x, bool mute)
+{
+	int ret;
+
+	if (mute) {
+		cancel_delayed_work_sync(&fs210x->fault_check_work);
+		cancel_delayed_work_sync(&fs210x->start_work);
+		mutex_lock(&fs210x_mutex);
+		ret = fs210x_dev_stop(fs210x);
+		mutex_unlock(&fs210x_mutex);
+		return ret;
+	}
+
+	/*
+	 * According to the power up/down sequence of FS210x,
+	 * the FS210x requests the I2S clock has been present
+	 * and stable(>= 2ms) before it playing.
+	 */
+	if (fs210x->clk_bclk) {
+		mutex_lock(&fs210x_mutex);
+		ret = fs210x_dev_play(fs210x);
+		mutex_unlock(&fs210x_mutex);
+	} else {
+		schedule_delayed_work(&fs210x->start_work,
+				      msecs_to_jiffies(FS210X_START_DELAY_MS));
+		ret = 0;
+	}
+
+	schedule_delayed_work(&fs210x->fault_check_work,
+			      msecs_to_jiffies(FS210X_FAULT_CHECK_INTERVAL_MS));
+
+	return ret;
+}
+
+static int fs210x_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct fs210x_priv *fs210x;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	dev_dbg(fs210x->dev, "fmt: %x\n", fmt);
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		/* Only supports slave mode */
+		break;
+	default:
+		dev_err(fs210x->dev, "Only supports slave mode\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int fs210x_dai_hw_params(struct snd_pcm_substream *substream,
+				struct snd_pcm_hw_params *params,
+				struct snd_soc_dai *dai)
+{
+	struct fs210x_priv *fs210x;
+	int chn_num;
+	int ret;
+
+	if (substream->stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	fs210x->srate = params_rate(params);
+	fs210x->bclk  = snd_soc_params_to_bclk(params);
+	chn_num = params_channels(params);
+	if (chn_num == 1) /* mono */
+		fs210x->bclk *= 2; /* I2S bus has 2 channels */
+
+	dev_info(fs210x->dev, "hw params: %d-%d-%d\n",
+		 fs210x->srate, chn_num, fs210x->bclk);
+
+	/* The FS2105S can't support 16kHz sample rate. */
+	if (fs210x->devid == FS2105S_DEVICE_ID && fs210x->srate == 16000)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&fs210x_mutex);
+	ret = fs210x_set_hw_params(fs210x);
+	mutex_unlock(&fs210x_mutex);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to set hw params: %d\n", ret);
+
+	return ret;
+}
+
+static int fs210x_dai_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	if (!fs210x->is_inited)
+		return -EFAULT;
+
+	if (mute) {
+		ret = fs210x_mute(fs210x, true);
+		fs210x_bclk_set(fs210x, false);
+		dev_info(fs210x->dev, "playback mute\n");
+	} else {
+		fs210x_bclk_set(fs210x, true);
+		ret = fs210x_mute(fs210x, false);
+		dev_info(fs210x->dev, "playback unmute\n");
+	}
+
+	return ret;
+}
+
+static void fs210x_start_work(struct work_struct *work)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = container_of(work, struct fs210x_priv, start_work.work);
+
+	mutex_lock(&fs210x_mutex);
+
+	ret = fs210x_dev_play(fs210x);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to start playing: %d\n", ret);
+
+	mutex_unlock(&fs210x_mutex);
+}
+
+static void fs210x_fault_check_work(struct work_struct *work)
+{
+	struct fs210x_priv *fs210x;
+	u16 status;
+	int ret;
+
+	fs210x = container_of(work, struct fs210x_priv, fault_check_work.work);
+
+	mutex_lock(&fs210x_mutex);
+	if (!fs210x->is_inited || !fs210x->is_playing) {
+		mutex_unlock(&fs210x_mutex);
+		return;
+	}
+
+	ret = fs210x_reg_read(fs210x, FS210X_05H_ANASTAT, &status);
+	mutex_unlock(&fs210x_mutex);
+	if (ret)
+		return;
+
+	if (!(status & FS210X_05H_PVDD_MASK))
+		dev_err(fs210x->dev, "PVDD fault\n");
+	if (status & FS210X_05H_OCDL_MASK)
+		dev_err(fs210x->dev, "OC detected\n");
+	if (status & FS210X_05H_UVDL_MASK)
+		dev_err(fs210x->dev, "UV detected\n");
+	if (status & FS210X_05H_OVDL_MASK)
+		dev_err(fs210x->dev, "OV detected\n");
+	if (status & FS210X_05H_OTPDL_MASK)
+		dev_err(fs210x->dev, "OT detected\n");
+	if (status & FS210X_05H_OCRDL_MASK)
+		dev_err(fs210x->dev, "OCR detected\n");
+	if (status & FS210X_05H_OCLDL_MASK)
+		dev_err(fs210x->dev, "OCL detected\n");
+	if (status & FS210X_05H_DCRDL_MASK)
+		dev_err(fs210x->dev, "DCR detected\n");
+	if (status & FS210X_05H_DCLDL_MASK)
+		dev_err(fs210x->dev, "DCL detected\n");
+	if (status & FS210X_05H_SRDL_MASK)
+		dev_err(fs210x->dev, "SR detected\n");
+	if (status & FS210X_05H_OTWDL_MASK)
+		dev_err(fs210x->dev, "OTW detected\n");
+	if (!(status & FS210X_05H_AMPS_MASK))
+		dev_err(fs210x->dev, "Amplifier unready\n");
+	if (!(status & FS210X_05H_PLLS_MASK))
+		dev_err(fs210x->dev, "PLL unlock\n");
+	if (!(status & FS210X_05H_ANAS_MASK))
+		dev_err(fs210x->dev, "Analog power fault\n");
+
+	if (status != FS210X_05H_ANASTAT_OK)
+		fs210x_reg_dump(fs210x);
+
+	schedule_delayed_work(&fs210x->fault_check_work,
+			      msecs_to_jiffies(FS210X_FAULT_CHECK_INTERVAL_MS));
+}
+
+static int fs210x_get_drvdata_from_kctrl(struct snd_kcontrol *kctrl,
+					 struct fs210x_priv **fs210x)
+{
+	struct snd_soc_component *cmpnt;
+
+	if (!kctrl) {
+		pr_err("fs210x: kcontrol is null\n");
+		return -EINVAL;
+	}
+
+	cmpnt = snd_soc_kcontrol_component(kctrl);
+	if (!cmpnt) {
+		pr_err("fs210x: component is null\n");
+		return -EINVAL;
+	}
+
+	*fs210x = snd_soc_component_get_drvdata(cmpnt);
+
+	return 0;
+}
+
+static int fs210x_pcm_volume_info(struct snd_kcontrol *kcontrol,
+				  struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+
+	uinfo->value.integer.min = FS210X_VOLUME_MIN;
+	uinfo->value.integer.max = FS210X_VOLUME_MAX;
+
+	return 0;
+}
+
+static int fs210x_pcm_volume_get(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret) {
+		pr_err("pcm_volume_get: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&fs210x_mutex);
+	ucontrol->value.integer.value[0] = fs210x->vol[0];
+	ucontrol->value.integer.value[1] = fs210x->vol[1];
+	mutex_unlock(&fs210x_mutex);
+
+	return 0;
+}
+
+static int fs210x_pcm_volume_put(struct snd_kcontrol *kcontrol,
+				 struct snd_ctl_elem_value *ucontrol)
+{
+	struct fs210x_priv *fs210x;
+	long *pval;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret || !fs210x->dev) {
+		pr_err("pcm_volume_put: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	pval = ucontrol->value.integer.value;
+	if (!volume_is_valid(*pval) || !volume_is_valid(*(pval + 1))) {
+		dev_err(fs210x->dev, "Invalid volume: %ld-%ld\n",
+			*pval, *(pval + 1));
+		return -EINVAL;
+	}
+
+	fs210x->vol[0] = (u16)*pval;
+	fs210x->vol[1] = (u16)*(pval + 1);
+	dev_dbg(fs210x->dev, "Set volume: %d-%d\n",
+		fs210x->vol[0], fs210x->vol[1]);
+
+	mutex_lock(&fs210x_mutex);
+
+	if (fs210x->is_suspended) {
+		mutex_unlock(&fs210x_mutex);
+		return 0;
+	}
+
+	ret = fs210x_set_pcm_volume(fs210x);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to set volume: %d\n", ret);
+
+	mutex_unlock(&fs210x_mutex);
+
+	return ret;
+}
+
+static int fs210x_effect_scene_info(struct snd_kcontrol *kcontrol,
+				    struct snd_ctl_elem_info *uinfo)
+{
+	const struct fs_amp_scene *scene;
+	struct fs210x_priv *fs210x;
+	const char *name = "N/A";
+	int idx, count;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret || !fs210x->dev) {
+		pr_err("scene_effect_info: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+
+	count = fs210x->amp_lib.scene_count - 1; /* Skip init scene */
+	if (count < 1) {
+		uinfo->value.enumerated.items = 0;
+		return 0;
+	}
+
+	uinfo->value.enumerated.items = count;
+	if (uinfo->value.enumerated.item >= count)
+		uinfo->value.enumerated.item = count - 1;
+
+	idx = uinfo->value.enumerated.item;
+	scene = fs210x->amp_lib.scene + idx + 1;
+	if (scene->name)
+		name = scene->name;
+
+	strscpy(uinfo->value.enumerated.name, name, strlen(name) + 1);
+	dev_dbg(fs210x->dev, "Scene name.%d: %s\n", idx, name);
+
+	return 0;
+}
+
+static int fs210x_effect_scene_get(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct fs210x_priv *fs210x;
+	int index;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret || !fs210x->dev) {
+		pr_err("scene_effect_get: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	/* The id of effect scene is from 1 to N. */
+	if (fs210x->scene_id < 1)
+		return -EINVAL;
+
+	mutex_lock(&fs210x_mutex);
+	/*
+	 * FS210x has scene(s) as below:
+	 * init scene: id = 0
+	 * effect scene(s): id = 1~N (optional)
+	 * effect_index = scene_id - 1
+	 */
+	index = fs210x->scene_id - 1;
+	ucontrol->value.integer.value[0] = index;
+	dev_dbg(fs210x->dev, "Get scene index: %d\n", index);
+	mutex_unlock(&fs210x_mutex);
+
+	return 0;
+}
+
+static int fs210x_effect_scene_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct fs210x_priv *fs210x;
+	int scene_id;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret || !fs210x->dev) {
+		pr_err("scene_effect_put: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&fs210x_mutex);
+
+	/*
+	 * FS210x has scene(s) as below:
+	 * init scene: id = 0(It's set in fs210x_init_chip() only)
+	 * effect scene(s): id = 1~N (optional)
+	 * scene_id = effect_index + 1.
+	 */
+	scene_id = ucontrol->value.integer.value[0] + 1;
+	if (fs210x->is_suspended) {
+		fs210x->scene_id = scene_id;
+		mutex_unlock(&fs210x_mutex);
+		return 0;
+	}
+
+	ret = fs210x_set_scene(fs210x, scene_id);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to set scene: %d\n", ret);
+
+	mutex_unlock(&fs210x_mutex);
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops fs210x_dai_ops = {
+	.set_fmt		= fs210x_dai_set_fmt,
+	.hw_params		= fs210x_dai_hw_params,
+	.mute_stream		= fs210x_dai_mute,
+};
+
+static const struct snd_soc_dai_driver fs210x_dai = {
+	.name = FS210X_DEFAULT_DAI_NAME,
+	.playback = {
+		.stream_name = "Playback",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = FS210X_RATES,
+		.formats = FS210X_FORMATS,
+	},
+	.capture = {
+		.stream_name = "Capture",
+		.channels_min = 1,
+		.channels_max = 2,
+		.rates = FS210X_RATES,
+		.formats = FS210X_FORMATS,
+	},
+	.ops = &fs210x_dai_ops,
+	.symmetric_rate = 1,
+	.symmetric_sample_bits = 1,
+};
+
+static const struct snd_kcontrol_new fs210x_controls[] = {
+	FS_SOC_ENUM_EXT("PCM Playback Volume",
+			fs210x_pcm_volume_info,
+			fs210x_pcm_volume_get,
+			fs210x_pcm_volume_put),
+};
+
+static const struct snd_kcontrol_new fs210x_scene_control[] = {
+	FS_SOC_ENUM_EXT("Effect Scene",
+			fs210x_effect_scene_info,
+			fs210x_effect_scene_get,
+			fs210x_effect_scene_put),
+};
+
+static const struct snd_soc_dapm_widget fs210x_dapm_widgets[] = {
+	SND_SOC_DAPM_AIF_IN("AIF IN", "Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("AIF OUT", "Capture", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_OUTPUT("OUTL"),
+	SND_SOC_DAPM_OUTPUT("OUTR"),
+	SND_SOC_DAPM_INPUT("SDO"),
+};
+
+static const struct snd_soc_dapm_route fs210x_dapm_routes[] = {
+	{ "OUTL", NULL, "AIF IN" },
+	{ "OUTR", NULL, "AIF IN" },
+	{ "AIF OUT", NULL, "SDO" },
+};
+
+static int fs210x_add_optional_controls(struct fs210x_priv *fs210x,
+					struct snd_soc_component *cmpnt)
+{
+	int count;
+
+	if (!fs210x || !cmpnt)
+		return -EINVAL;
+
+	/*
+	 * If the firmware has no scene or only init scene,
+	 * we skip adding this mixer control.
+	 */
+	if (fs210x->amp_lib.scene_count < 2)
+		return 0;
+
+	count = ARRAY_SIZE(fs210x_scene_control);
+
+	return snd_soc_add_component_controls(cmpnt,
+					      fs210x_scene_control,
+					      count);
+}
+
+static int fs210x_get_bclk(struct fs210x_priv *fs210x,
+			   struct snd_soc_component *cmpnt)
+{
+	struct clk *bclk;
+	int ret;
+
+	bclk = devm_clk_get(fs210x->dev, "bclk");
+	if (IS_ERR_OR_NULL(bclk)) {
+		ret = bclk ? PTR_ERR(bclk) : -ENODATA;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		/*
+		 * If the SOC doesn't have the bclk clock source,
+		 * we skip setting the bclk clock.
+		 */
+		return 0;
+	}
+
+	fs210x->clk_bclk = bclk;
+	dev_dbg(fs210x->dev, "Got I2S bclk clock\n");
+
+	return 0;
+}
+
+static int fs210x_probe(struct snd_soc_component *cmpnt)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = snd_soc_component_get_drvdata(cmpnt);
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	fs210x->amp_lib.dev   = fs210x->dev;
+	fs210x->amp_lib.devid = fs210x->devid;
+
+	ret = fs_amp_load_firmware(&fs210x->amp_lib, fs210x->pdata.fwm_name);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to load firmware: %d\n", ret);
+		return ret;
+	}
+
+	ret = fs210x_add_optional_controls(fs210x, cmpnt);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to add opt-ctrl: %d\n", ret);
+		return ret;
+	}
+
+	INIT_DELAYED_WORK(&fs210x->fault_check_work, fs210x_fault_check_work);
+	INIT_DELAYED_WORK(&fs210x->start_work, fs210x_start_work);
+
+	fs210x_get_bclk(fs210x, cmpnt);
+
+	mutex_lock(&fs210x_mutex);
+	ret = fs210x_init_chip(fs210x);
+	mutex_unlock(&fs210x_mutex);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to probe: %d\n", ret);
+
+	return ret;
+}
+
+static void fs210x_remove(struct snd_soc_component *cmpnt)
+{
+	struct fs210x_priv *fs210x;
+
+	fs210x = snd_soc_component_get_drvdata(cmpnt);
+	if (!fs210x || !fs210x->dev)
+		return;
+
+	cancel_delayed_work_sync(&fs210x->start_work);
+	cancel_delayed_work_sync(&fs210x->fault_check_work);
+
+	dev_dbg(fs210x->dev, "Codec removed\n");
+}
+
+#ifdef CONFIG_PM
+static int fs210x_suspend(struct snd_soc_component *cmpnt)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = snd_soc_component_get_drvdata(cmpnt);
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	cancel_delayed_work_sync(&fs210x->start_work);
+	cancel_delayed_work_sync(&fs210x->fault_check_work);
+
+	mutex_lock(&fs210x_mutex);
+	fs210x->cur_scene = NULL;
+	fs210x->is_inited = false;
+	fs210x->is_playing = false;
+	fs210x->is_suspended = true;
+
+	fs210x_sdz_pin_set(fs210x, true);
+	mutex_unlock(&fs210x_mutex);
+
+	ret = regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to suspend: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(fs210x->dev, "pm suspended\n");
+
+	return 0;
+}
+
+static int fs210x_resume(struct snd_soc_component *cmpnt)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = snd_soc_component_get_drvdata(cmpnt);
+	if (!fs210x || !fs210x->dev)
+		return -EINVAL;
+
+	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	mutex_lock(&fs210x_mutex);
+	fs210x_sdz_pin_set(fs210x, false);
+
+	fs210x->is_suspended = false;
+	ret = fs210x_init_chip(fs210x);
+	mutex_unlock(&fs210x_mutex);
+
+	dev_info(fs210x->dev, "pm resumed\n");
+
+	return ret;
+}
+#else
+#define fs210x_suspend NULL
+#define fs210x_resume NULL
+#endif // CONFIG_PM
+
+static const struct snd_soc_component_driver fs210x_soc_component_dev = {
+	.probe			= fs210x_probe,
+	.remove			= fs210x_remove,
+	.suspend		= fs210x_suspend,
+	.resume			= fs210x_resume,
+	.controls		= fs210x_controls,
+	.num_controls		= ARRAY_SIZE(fs210x_controls),
+	.dapm_widgets		= fs210x_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(fs210x_dapm_widgets),
+	.dapm_routes		= fs210x_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(fs210x_dapm_routes),
+	.use_pmdown_time	= 1,
+};
+
+static const struct regmap_config fs210x_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 16,
+	.max_register		= FS210X_REG_MAX,
+	.val_format_endian	= REGMAP_ENDIAN_BIG,
+	.cache_type		= REGCACHE_NONE,
+};
+
+static int fs210x_detect_device(struct fs210x_priv *fs210x)
+{
+	u16 devid;
+	int ret;
+
+	ret = fs210x_reg_read(fs210x, FS210X_03H_DEVID, &devid);
+	if (ret)
+		return ret;
+
+	fs210x->devid = HI_U16(devid);
+
+	switch (fs210x->devid) {
+	case FS210X_DEVICE_ID:
+		dev_info(fs210x->dev, "FS2104 detected\n");
+		break;
+	case FS2105S_DEVICE_ID:
+		dev_info(fs210x->dev, "FS2105S detected\n");
+		break;
+	default:
+		dev_err(fs210x->dev, "DEVID: 0x%04X dismatch\n", devid);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int fs210x_parse_dts(struct fs210x_priv *fs210x,
+			    struct fs210x_platform_data *pdata)
+{
+	struct device_node *node = fs210x->dev->of_node;
+	int i, ret;
+
+	if (!node)
+		return 0;
+
+	ret = of_property_read_string(node, "firmware-name", &pdata->fwm_name);
+	if (ret)
+		pdata->fwm_name = FS210X_DEFAULT_FWM_NAME;
+
+	fs210x->gpio_sdz = devm_gpiod_get_optional(fs210x->dev,
+						   "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR_OR_NULL(fs210x->gpio_sdz)) {
+		ret = fs210x->gpio_sdz ? PTR_ERR(fs210x->gpio_sdz) : -ENODATA;
+		fs210x->gpio_sdz = NULL;
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_dbg(fs210x->dev, "Assuming reset-gpios is unused\n");
+	} else {
+		dev_dbg(fs210x->dev, "reset-gpios: %d\n",
+			desc_to_gpio(fs210x->gpio_sdz));
+	}
+
+	for (i = 0; i < FS210X_NUM_SUPPLIES; i++)
+		fs210x->supplies[i].supply = fs210x_supply_names[i];
+
+	ret = devm_regulator_bulk_get(fs210x->dev,
+				      ARRAY_SIZE(fs210x->supplies),
+				      fs210x->supplies);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to get supplies: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fs210x_parse_platdata(struct fs210x_priv *fs210x)
+{
+	struct fs210x_platform_data *pdata;
+	int ret;
+
+	pdata = &fs210x->pdata;
+	ret = fs210x_parse_dts(fs210x, pdata);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to parse dts: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void fs210x_deinit(struct fs210x_priv *fs210x)
+{
+	fs210x_sdz_pin_set(fs210x, true);
+	regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+}
+
+static int fs210x_init(struct fs210x_priv *fs210x)
+{
+	int ret;
+
+	ret = fs210x_parse_platdata(fs210x);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to parse platdata: %d\n", ret);
+		return ret;
+	}
+
+	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to enable supplies: %d\n", ret);
+		return ret;
+	}
+
+	/* Make sure the SDZ pin is pulled down enough time. */
+	usleep_range(10000, 10050); /* >= 10ms */
+	fs210x_sdz_pin_set(fs210x, false);
+
+	ret = fs210x_detect_device(fs210x);
+	if (ret) {
+		fs210x_deinit(fs210x);
+		return ret;
+	}
+
+	fs210x->scene_id     = -1; /* Invalid scene */
+	fs210x->cur_scene    = NULL;
+	fs210x->is_playing   = false;
+	fs210x->is_inited    = false;
+	fs210x->is_suspended = false;
+	fs210x->vol[0]       = FS210X_VOLUME_MAX;
+	fs210x->vol[1]       = FS210X_VOLUME_MAX;
+
+	return 0;
+}
+
+static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	int ret;
+
+	dai_drv = devm_kmemdup(fs210x->dev, &fs210x_dai,
+			       sizeof(fs210x_dai), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	if (fs210x->devid == FS2105S_DEVICE_ID) {
+		dai_drv->playback.rates = FS2105S_RATES;
+		dai_drv->capture.rates  = FS2105S_RATES;
+	}
+
+	ret = snd_soc_register_component(fs210x->dev,
+					 &fs210x_soc_component_dev,
+					 dai_drv, 1);
+	return ret;
+}
+
+static int fs210x_i2c_probe(struct i2c_client *client)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	dev_info(&client->dev, "version: %s\n", FS210X_DRV_VERSION);
+
+	fs210x = devm_kzalloc(&client->dev, sizeof(*fs210x), GFP_KERNEL);
+	if (!fs210x)
+		return -ENOMEM;
+
+	fs210x->i2c = client;
+	fs210x->dev = &client->dev;
+	i2c_set_clientdata(client, fs210x);
+
+	fs210x->regmap = devm_regmap_init_i2c(client, &fs210x_regmap);
+	if (IS_ERR_OR_NULL(fs210x->regmap)) {
+		dev_err(fs210x->dev, "Failed to get regmap\n");
+		ret = fs210x->regmap ? PTR_ERR(fs210x->regmap) : -ENODATA;
+		return ret;
+	}
+
+	mutex_lock(&fs210x_mutex);
+	ret = fs210x_init(fs210x);
+	mutex_unlock(&fs210x_mutex);
+	if (ret)
+		return ret;
+
+	ret = fs210x_register_snd_component(fs210x);
+	if (ret) {
+		fs210x_deinit(fs210x);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void fs210x_i2c_remove(struct i2c_client *client)
+{
+	struct fs210x_priv *fs210x = i2c_get_clientdata(client);
+
+	snd_soc_unregister_component(fs210x->dev);
+	fs210x_deinit(fs210x);
+}
+
+static const struct i2c_device_id fs210x_i2c_id[] = {
+	{ "fs2104" },
+	{ "fs2105s" },
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, fs210x_i2c_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id fs210x_of_match[] = {
+	{ .compatible = "foursemi,fs2104", },
+	{ .compatible = "foursemi,fs2105s", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fs210x_of_match);
+#endif // CONFIG_OF
+
+static struct i2c_driver fs210x_i2c_driver = {
+	.driver = {
+		.name = "fs210x",
+		.of_match_table = of_match_ptr(fs210x_of_match),
+	},
+	.id_table = fs210x_i2c_id,
+	.probe    = fs210x_i2c_probe,
+	.remove   = fs210x_i2c_remove,
+};
+
+module_i2c_driver(fs210x_i2c_driver);
+
+MODULE_AUTHOR("Nick Li <nick.li@foursemi.com>");
+MODULE_DESCRIPTION("FS2104/5S Audio Amplifier Driver");
+MODULE_VERSION(FS210X_DRV_VERSION);
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/fs210x.h b/sound/soc/codecs/fs210x.h
new file mode 100644
index 000000000..a64f8d37f
--- /dev/null
+++ b/sound/soc/codecs/fs210x.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * fs210x.h -- Driver for the FS2104/5S Audio Amplifier
+ *
+ * Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
+ */
+
+#ifndef __FS210X_H__
+#define __FS210X_H__
+
+#define FS210X_00H_STATUS		0x00
+#define FS210X_03H_DEVID		0x03
+#define FS210X_05H_ANASTAT		0x05
+#define FS210X_06H_DIGSTAT		0x06
+#define FS210X_0BH_ACCKEY		0x0B
+#define FS210X_10H_PWRCTRL		0x10
+#define FS210X_11H_SYSCTRL		0x11
+#define FS210X_17H_I2SCTRL		0x17
+#define FS210X_30H_DACCTRL		0x30
+#define FS210X_39H_LVOLCTRL		0x39
+#define FS210X_3AH_RVOLCTRL		0x3A
+#define FS210X_42H_DACEQWL		0x42
+#define FS210X_46H_DACEQA		0x46
+#define FS210X_A1H_PLLCTRL1		0xA1
+#define FS210X_A2H_PLLCTRL2		0xA2
+#define FS210X_A3H_PLLCTRL3		0xA3
+#define FS210X_ABH_INTSTAT		0xAB
+#define FS210X_ACH_INTSTATR		0xAC
+
+#define FS210X_05H_PVDD_SHIFT		14
+#define FS210X_05H_PVDD_MASK		BIT(14)
+#define FS210X_05H_OCDL_SHIFT		13
+#define FS210X_05H_OCDL_MASK		BIT(13)
+#define FS210X_05H_UVDL_SHIFT		12
+#define FS210X_05H_UVDL_MASK		BIT(12)
+#define FS210X_05H_OVDL_SHIFT		11
+#define FS210X_05H_OVDL_MASK		BIT(11)
+#define FS210X_05H_OTPDL_SHIFT		10
+#define FS210X_05H_OTPDL_MASK		BIT(10)
+#define FS210X_05H_OCRDL_SHIFT		9
+#define FS210X_05H_OCRDL_MASK		BIT(9)
+#define FS210X_05H_OCLDL_SHIFT		8
+#define FS210X_05H_OCLDL_MASK		BIT(8)
+#define FS210X_05H_DCRDL_SHIFT		7
+#define FS210X_05H_DCRDL_MASK		BIT(7)
+#define FS210X_05H_DCLDL_SHIFT		6
+#define FS210X_05H_DCLDL_MASK		BIT(6)
+#define FS210X_05H_SRDL_SHIFT		5
+#define FS210X_05H_SRDL_MASK		BIT(5)
+#define FS210X_05H_OTWDL_SHIFT		4
+#define FS210X_05H_OTWDL_MASK		BIT(4)
+#define FS210X_05H_AMPS_SHIFT		3
+#define FS210X_05H_AMPS_MASK		BIT(3)
+#define FS210X_05H_PLLS_SHIFT		1
+#define FS210X_05H_PLLS_MASK		BIT(1)
+#define FS210X_05H_ANAS_SHIFT		0
+#define FS210X_05H_ANAS_MASK		BIT(0)
+#define FS210X_17H_I2SSR_SHIFT		12
+#define FS210X_17H_I2SSR_MASK		GENMASK(15, 12)
+#define FS210X_30H_RMUTE_SHIFT		8
+#define FS210X_30H_LMUTE_SHIFT		4
+#define FS210X_39H_VOL_SHIFT		6
+#define FS210X_3AH_VOL_SHIFT		6
+#define FS2105S_39H_VOL_SHIFT		7
+#define FS2105S_3AH_VOL_SHIFT		7
+
+#define FS210X_05H_ANASTAT_OK		0x400B
+#define FS210X_0BH_ACCKEY_ON		0x0091
+#define FS210X_0BH_ACCKEY_OFF		0x0000
+#define FS210X_10H_I2C_RESET		0x0002
+#define FS210X_11H_DPS_HIZ		0x0100
+#define FS210X_11H_DPS_PWDN		0x0000
+#define FS210X_11H_DPS_PLAY		0x0300
+#define FS210X_46H_CAM_BURST_L		0x8000
+#define FS210X_46H_CAM_BURST_R		0x8200
+#define FS2105S_46H_CAM_BURST_W		0x8400
+#define FS210X_46H_CAM_CLEAR		0x0000
+
+#endif /* __FS210X_H__ */
-- 
2.17.1


