Return-Path: <linux-kernel+bounces-739074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B757B0C173
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3CF018C202B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C8291889;
	Mon, 21 Jul 2025 10:40:08 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C64128BA90;
	Mon, 21 Jul 2025 10:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753094406; cv=none; b=JJ728n4I6ajokBXHlcoRtl7UvzE6ifkjTxzAJNG+LMiRDRwDnGqGh97P5HHKf0GG4h2i+nL0qz7wj6Q/URwPiy2hh3X+Conw0GEA3rmCc0/FpM6+LvZgdHYBt/FfeC99x/XIDgMWF+F+th+DMANlBszr/3ZLQjfrkpDHwrTulgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753094406; c=relaxed/simple;
	bh=GiJ++c1IUnTgpf9XPc3jfMz1mLrexfJfwt3Ejlcccr8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mzZMUU7jDi+kNC0nTH2NK2C009YdwPaScV/s2Ge8tVvnDOds92o0UtYu9Rk6mNLV6z6bQAMQRWaDUyeXeTR0YQOccmQ2Q+R5gbtBYrjUlPsweuvzXTgvPDORM0JKGEsbkkiY2GK3zz9bZyU2YJKGWIiGQM2oZ+LUVuZ9LSZ7a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpgz7t1753094358t5b7561e5
X-QQ-Originating-IP: es8aAQggiEPof53fTRima4OQEaIjevoA5EmgNHYE+rs=
Received: from localhost.localdomain ( [113.89.235.49])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 18:39:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13082089297988604839
EX-QQ-RecipientCnt: 14
From: Nick <nick.li@foursemi.com>
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
Subject: [PATCH v4 4/4] ASoC: codecs: Add FourSemi FS2104/5S audio amplifier driver
Date: Mon, 21 Jul 2025 18:38:05 +0800
Message-Id: <20250721103805.531758-5-nick.li@foursemi.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721103805.531758-1-nick.li@foursemi.com>
References: <20250721103805.531758-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: OB+T84+MLdZDrz5hQSC8iulDIJ07mIW9woR5HhL4dAMKAaT86Ir8p+Ht
	HGwD281KrHAIwq2k8HeJTe2+aZgzEcio7Q+tfJ8wkHd+grNWh6Dxd/6wMS/fD+WlRC4guoy
	VFmw03odwpI7Dc2kL4T8X9bSjufx2ljgEoXMuKvJ2OL8YlUyerthdB+XqdjVvLoVxKazgRo
	OcfqYiSrWxAzi/YKyyBy9osIGBUUsUXPRyA3pelcI6sSP7sMcXJWoW2ngprZ6NNc/oialW0
	1cEm6X/Ti2DYb3YyXuDF21Sz+RNR7eu2KeSRMx80QuXmioytpSmAcuARoNc/Q5HuYxLl6fX
	2sJsfFcUjUABnGYrQPzV8Cmi2Aws+fs9McymmrEmw3zakHdZI8MU3hXYfgPwEO9+IpsZ1yh
	QO+LRs9whOciXcFZQRB6YMvQ14tsRKQlsBTVZD/ZjnfAfZsSQd75uBNCiqvTe18t23t0sRJ
	ebYX5UfgrE45nLHJ8Xjp3JPdxwVkJ46GhpRlD9wfga2/561nVs42HhnSlX+0bzf/vRlAuDz
	YtpaIWZnz3thqhVLT3XH2NYydSOHd2tbk7yVOpHX1gVXCRfgxBmEJC8XJANU4s+iOBZz8/t
	/xuWFAcRozSbIyEK6ENQ/6xYV2hTzFS31oKmHm/6fHLLaUVeFbECEHZ0tdA8vWjJDXzAbkd
	33fYtPcqrykwEPZFzn2qIghSnE1fWgf90hj11P8LSxu1QzfEKT9bBtjJipeWuvJlDSaOZM1
	0G4c9dJXdywmo2pQoZ20g55tdtT4BwOXSTHoQHG9Pk/N1rwooegAxUY2B3RTbeOKiDawfrz
	PI1lkiPZv8hPvHu1uKP/EeLMi1Juydyf0kHIyeS0tsGCALdG8fZ5XwKqhaEe0Eg1b3EDFIQ
	/tEnSabIdSHTUCKLRzpJ7DA9u7fF1wqrdpG4jj1bFbpeLhIQSzg2ki8e4CWvevgb/cDbiZU
	inWpfj5FAJSo3lC1VTXYWNJMWL/IbL/ORJ13dgedLSWobHjIAuNYciUBoBWtcDpol7FuACQ
	gOpavtsfRPlv9hZaaCsR7/Z581gcrcSRYoL/JWAeL9fH8WiwsKfnWYMRTDKfB+Wtg2HLxk4
	abwPKkEuCWy
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Nick Li <nick.li@foursemi.com>

The FS2104/5S are FourSemi digital audio amplifiers
with I2C control. They are Inductor-Less, Stereo, Closed-Loop,
Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 sound/soc/codecs/Kconfig  |   13 +
 sound/soc/codecs/Makefile |    2 +
 sound/soc/codecs/fs210x.c | 1583 +++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/fs210x.h |   75 ++
 4 files changed, 1673 insertions(+)
 create mode 100644 sound/soc/codecs/fs210x.c
 create mode 100644 sound/soc/codecs/fs210x.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6265cc897..8c85f3dbb 100644
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
@@ -1242,6 +1243,18 @@ config SND_SOC_FS_AMP_LIB
 	select CRC16
 	tristate
 
+config SND_SOC_FS210X
+	tristate 'FourSemi FS2104/5S digital audio amplifier'
+	depends on I2C
+	select GPIOLIB
+	select REGMAP_I2C
+	select SND_SOC_FS_AMP_LIB
+	help
+	  Enable support for FourSemi FS2104/5S digital audio amplifier.
+	  The FS2104/5S are Inductor-Less, Stereo, Closed-Loop,
+	  Digital Input Class-D Power Amplifiers with Enhanced Signal Processing.
+	  The amplifiers support I2C and I2S/TDM.
+
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
 
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 9afce9aa6..967e939a4 100644
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
@@ -563,6 +564,7 @@ obj-$(CONFIG_SND_SOC_ES8375)    += snd-soc-es8375.o
 obj-$(CONFIG_SND_SOC_ES8389)    += snd-soc-es8389.o
 obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
 obj-$(CONFIG_SND_SOC_FS_AMP_LIB)+= snd-soc-fs-amp-lib.o
+obj-$(CONFIG_SND_SOC_FS210X)	+= snd-soc-fs210x.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
diff --git a/sound/soc/codecs/fs210x.c b/sound/soc/codecs/fs210x.c
new file mode 100644
index 000000000..457590bea
--- /dev/null
+++ b/sound/soc/codecs/fs210x.c
@@ -0,0 +1,1583 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// fs210x.c -- Driver for the FS2104/5S Audio Amplifier
+//
+// Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
+#include <sound/soc.h>
+#include <sound/tlv.h>
+
+#include "fs210x.h"
+#include "fs-amp-lib.h"
+
+#define FS210X_DEFAULT_FWM_NAME		"fs210x_fwm.bin"
+#define FS210X_DEFAULT_DAI_NAME		"fs210x-aif"
+#define FS2105S_DEVICE_ID		0x20 /* FS2105S */
+#define FS210X_DEVICE_ID		0x45 /* FS2104 */
+#define FS210X_REG_MAX			0xF8
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
+	/*
+	 * @lock: Mutex ensuring exclusive access for critical device operations
+	 *
+	 * This lock serializes access between the following actions:
+	 *  - Device initialization procedures(probe)
+	 *  - Enable/disable device(DAPM event)
+	 *  - Suspend/resume device(PM)
+	 *  - Runtime scene switching(control)
+	 *  - Scheduling/execution of delayed works items(delayed works)
+	 */
+	struct mutex lock;
+	unsigned int check_interval_ms;
+	unsigned int bclk;
+	unsigned int srate;
+	int scene_id;
+	u16 devid;
+	bool is_inited;
+	bool is_suspended;
+	bool is_bclk_on;
+	bool is_playing;
+};
+
+static const unsigned int fs2105s_rates[] = {
+	32000, 44100, 48000, 88200, 96000
+};
+
+static const struct snd_pcm_hw_constraint_list fs2105s_constraints = {
+	.count = ARRAY_SIZE(fs2105s_rates),
+	.list  = fs2105s_rates,
+};
+
+static const unsigned int fs210x_rates[] = {
+	16000, 32000, 44100, 48000, 88200, 96000
+};
+
+static const struct snd_pcm_hw_constraint_list fs210x_constraints = {
+	.count = ARRAY_SIZE(fs210x_rates),
+	.list  = fs210x_rates,
+};
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
+	if ((fs210x->is_bclk_on ^ on) == 0)
+		return 0;
+
+	if (on) {
+		clk_set_rate(fs210x->clk_bclk, fs210x->bclk);
+		ret = clk_prepare_enable(fs210x->clk_bclk);
+		fs210x->is_bclk_on = true;
+		fsleep(2000); /* >= 2ms */
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
+	*pval = (u16)val;
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
+	return 0;
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
+		delay_us = pkg->regv.val * 1000; /* ms -> us */
+		fsleep(delay_us);
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
+	fsleep(10000); /* >= 10ms */
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
+	fsleep(30000); /* >= 30ms */
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
+	fsleep(10000); /* >= 10ms */
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
+static int fs210x_init_chip(struct fs210x_priv *fs210x)
+{
+	int scene_id;
+	int ret;
+
+	regcache_cache_bypass(fs210x->regmap, true);
+
+	if (!fs210x->gpio_sdz) {
+		/* Gpio is not found, i2c reset */
+		ret = fs210x_reg_write(fs210x, FS210X_10H_PWRCTRL,
+				       FS210X_10H_I2C_RESET);
+		if (ret)
+			goto tag_power_down;
+	} else {
+		/* gpio reset, deactivate */
+		gpiod_set_value_cansleep(fs210x->gpio_sdz, 0);
+	}
+
+	fsleep(10000); /* >= 10ms */
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
+tag_power_down:
+	/* Power down the device */
+	ret |= fs210x_reg_write(fs210x, FS210X_11H_SYSCTRL,
+				FS210X_11H_DPS_PWDN);
+	fsleep(10000); /* >= 10ms */
+
+	regcache_cache_bypass(fs210x->regmap, false);
+	if (!ret) {
+		regcache_mark_dirty(fs210x->regmap);
+		regcache_sync(fs210x->regmap);
+		fs210x->is_inited = true;
+	}
+
+	return ret;
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
+static int fs210x_dai_startup(struct snd_pcm_substream *substream,
+			      struct snd_soc_dai *dai)
+{
+	const struct snd_pcm_hw_constraint_list *list;
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+	if (!fs210x) {
+		pr_err("dai_startup: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	if (!substream->runtime)
+		return 0;
+
+	ret = snd_pcm_hw_constraint_mask64(substream->runtime,
+					   SNDRV_PCM_HW_PARAM_FORMAT,
+					   FS210X_FORMATS);
+	if (ret < 0) {
+		dev_err(fs210x->dev,
+			"Failed to set hw param format: %d\n", ret);
+		return ret;
+	}
+
+	if (fs210x->devid == FS2105S_DEVICE_ID)
+		list = &fs2105s_constraints;
+	else
+		list = &fs210x_constraints;
+
+	ret = snd_pcm_hw_constraint_list(substream->runtime, 0,
+					 SNDRV_PCM_HW_PARAM_RATE,
+					 list);
+	if (ret < 0) {
+		dev_err(fs210x->dev,
+			"Failed to set hw param rate: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int fs210x_dai_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct fs210x_priv *fs210x;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBC_CFC:
+		/* Only supports consumer mode */
+		break;
+	default:
+		dev_err(fs210x->dev, "Only supports consumer mode\n");
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
+	/* The FS2105S can't support 16kHz sample rate. */
+	if (fs210x->devid == FS2105S_DEVICE_ID && fs210x->srate == 16000)
+		return -EOPNOTSUPP;
+
+	mutex_lock(&fs210x->lock);
+	ret = fs210x_set_hw_params(fs210x);
+	mutex_unlock(&fs210x->lock);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to set hw params: %d\n", ret);
+
+	return ret;
+}
+
+static int fs210x_dai_mute(struct snd_soc_dai *dai, int mute, int stream)
+{
+	struct fs210x_priv *fs210x;
+	unsigned long delay;
+
+	if (stream != SNDRV_PCM_STREAM_PLAYBACK)
+		return 0;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	mutex_lock(&fs210x->lock);
+
+	if (!fs210x->is_inited || fs210x->is_suspended) {
+		mutex_unlock(&fs210x->lock);
+		return 0;
+	}
+
+	mutex_unlock(&fs210x->lock);
+
+	if (mute) {
+		cancel_delayed_work_sync(&fs210x->fault_check_work);
+		cancel_delayed_work_sync(&fs210x->start_work);
+	} else {
+		delay = msecs_to_jiffies(fs210x->check_interval_ms);
+		schedule_delayed_work(&fs210x->fault_check_work, delay);
+	}
+
+	return 0;
+}
+
+static int fs210x_dai_trigger(struct snd_pcm_substream *substream,
+			      int cmd, struct snd_soc_dai *dai)
+{
+	struct fs210x_priv *fs210x;
+
+	fs210x = snd_soc_component_get_drvdata(dai->component);
+
+	mutex_lock(&fs210x->lock);
+
+	if (!fs210x->is_inited || fs210x->is_suspended || fs210x->is_playing) {
+		mutex_unlock(&fs210x->lock);
+		return 0;
+	}
+
+	mutex_unlock(&fs210x->lock);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		/*
+		 * According to the power up/down sequence of FS210x,
+		 * it requests the I2S clock has been present
+		 * and stable(>= 2ms) before playing.
+		 */
+		schedule_delayed_work(&fs210x->start_work,
+				      msecs_to_jiffies(FS210X_START_DELAY_MS));
+		break;
+
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static void fs210x_start_work(struct work_struct *work)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
+
+	fs210x = container_of(work, struct fs210x_priv, start_work.work);
+
+	mutex_lock(&fs210x->lock);
+
+	ret = fs210x_dev_play(fs210x);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to start playing: %d\n", ret);
+
+	mutex_unlock(&fs210x->lock);
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
+	mutex_lock(&fs210x->lock);
+
+	if (!fs210x->is_inited || fs210x->is_suspended || !fs210x->is_playing) {
+		mutex_unlock(&fs210x->lock);
+		return;
+	}
+
+	ret = fs210x_reg_read(fs210x, FS210X_05H_ANASTAT, &status);
+	mutex_unlock(&fs210x->lock);
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
+		dev_dbg(fs210x->dev, "Amplifier unready\n");
+	if (!(status & FS210X_05H_PLLS_MASK))
+		dev_err(fs210x->dev, "PLL unlock\n");
+	if (!(status & FS210X_05H_ANAS_MASK))
+		dev_err(fs210x->dev, "Analog power fault\n");
+
+	schedule_delayed_work(&fs210x->fault_check_work,
+			      msecs_to_jiffies(fs210x->check_interval_ms));
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
+	mutex_lock(&fs210x->lock);
+	/*
+	 * FS210x has scene(s) as below:
+	 * init scene: id = 0
+	 * effect scene(s): id = 1~N (optional)
+	 * effect_index = scene_id - 1
+	 */
+	index = fs210x->scene_id - 1;
+	ucontrol->value.integer.value[0] = index;
+	mutex_unlock(&fs210x->lock);
+
+	return 0;
+}
+
+static int fs210x_effect_scene_put(struct snd_kcontrol *kcontrol,
+				   struct snd_ctl_elem_value *ucontrol)
+{
+	struct fs210x_priv *fs210x;
+	int scene_id, scene_count;
+	bool is_changed = false;
+	int ret;
+
+	ret = fs210x_get_drvdata_from_kctrl(kcontrol, &fs210x);
+	if (ret || !fs210x->dev) {
+		pr_err("scene_effect_put: fs210x is null\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&fs210x->lock);
+
+	/*
+	 * FS210x has scene(s) as below:
+	 * init scene: id = 0 (It's set in fs210x_init_chip() only)
+	 * effect scene(s): id = 1~N (optional)
+	 * scene_id = effect_index + 1.
+	 */
+	scene_id = ucontrol->value.integer.value[0] + 1;
+	scene_count = fs210x->amp_lib.scene_count - 1; /* Skip init scene */
+	if (scene_id < 1 || scene_id > scene_count) {
+		mutex_unlock(&fs210x->lock);
+		return -ERANGE;
+	}
+
+	if (scene_id != fs210x->scene_id)
+		is_changed = true;
+
+	if (fs210x->is_suspended) {
+		fs210x->scene_id = scene_id;
+		mutex_unlock(&fs210x->lock);
+		return is_changed;
+	}
+
+	ret = fs210x_set_scene(fs210x, scene_id);
+	if (ret)
+		dev_err(fs210x->dev, "Failed to set scene: %d\n", ret);
+
+	mutex_unlock(&fs210x->lock);
+
+	if (!ret && is_changed)
+		return 1;
+
+	return ret;
+}
+
+static int fs210x_playback_event(struct snd_soc_dapm_widget *w,
+				 struct snd_kcontrol *kc, int event)
+{
+	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
+	struct fs210x_priv *fs210x = snd_soc_component_get_drvdata(cmpnt);
+	int ret = 0;
+
+	mutex_lock(&fs210x->lock);
+
+	if (fs210x->is_suspended) {
+		mutex_unlock(&fs210x->lock);
+		return 0;
+	}
+
+	switch (event) {
+	case SND_SOC_DAPM_PRE_PMU:
+		/*
+		 * If there is no bclk for us to set the clock output,
+		 * we will enable the device(start_work) in dai trigger.
+		 */
+		if (!fs210x->clk_bclk)
+			break;
+		fs210x_bclk_set(fs210x, true);
+		ret = fs210x_dev_play(fs210x);
+		break;
+	case SND_SOC_DAPM_POST_PMD:
+		ret = fs210x_dev_stop(fs210x);
+		fs210x_bclk_set(fs210x, false);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&fs210x->lock);
+
+	return ret;
+}
+
+static const struct snd_soc_dai_ops fs210x_dai_ops = {
+	.startup		= fs210x_dai_startup,
+	.set_fmt		= fs210x_dai_set_fmt,
+	.hw_params		= fs210x_dai_hw_params,
+	.mute_stream		= fs210x_dai_mute,
+	.trigger		= fs210x_dai_trigger,
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
+static const DECLARE_TLV_DB_SCALE(fs2105s_vol_tlv, -9709, 19, 1);
+static const DECLARE_TLV_DB_SCALE(fs210x_vol_tlv, -13357, 19, 1);
+
+static const struct snd_kcontrol_new fs2105s_vol_control[] = {
+	SOC_DOUBLE_R_TLV("PCM Playback Volume",
+			 FS210X_39H_LVOLCTRL, FS210X_3AH_RVOLCTRL,
+			 7, 0x1FF, 0, fs2105s_vol_tlv),
+};
+
+static const struct snd_kcontrol_new fs210x_vol_control[] = {
+	SOC_DOUBLE_R_TLV("PCM Playback Volume",
+			 FS210X_39H_LVOLCTRL, FS210X_3AH_RVOLCTRL,
+			 6, 0x2BF, 0, fs210x_vol_tlv),
+};
+
+static const struct snd_kcontrol_new fs210x_controls[] = {
+	SOC_DOUBLE("DAC Mute Switch", FS210X_30H_DACCTRL, 4, 8, 1, 0),
+	SOC_DOUBLE("DAC Fade Switch", FS210X_30H_DACCTRL, 5, 9, 1, 0),
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
+	SND_SOC_DAPM_AIF_IN_E("AIF IN", "Playback", 0, SND_SOC_NOPM, 0, 0,
+			      fs210x_playback_event,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
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
+static int fs210x_add_mixer_controls(struct fs210x_priv *fs210x,
+				     struct snd_soc_component *cmpnt)
+{
+	const struct snd_kcontrol_new *kctrl;
+	int count;
+	int ret;
+
+	if (!fs210x || !cmpnt)
+		return -EINVAL;
+
+	if (fs210x->devid == FS2105S_DEVICE_ID) {
+		kctrl = fs2105s_vol_control;
+		count = ARRAY_SIZE(fs2105s_vol_control);
+	} else {
+		kctrl = fs210x_vol_control;
+		count = ARRAY_SIZE(fs210x_vol_control);
+	}
+
+	ret = snd_soc_add_component_controls(cmpnt, kctrl, count);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the firmware has no scene or only init scene,
+	 * we skip adding this mixer control.
+	 */
+	if (fs210x->amp_lib.scene_count < 2)
+		return 0;
+
+	kctrl = fs210x_scene_control;
+	count = ARRAY_SIZE(fs210x_scene_control);
+
+	return snd_soc_add_component_controls(cmpnt, kctrl, count);
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
+	if (ret)
+		return ret;
+
+	ret = fs210x_add_mixer_controls(fs210x, cmpnt);
+	if (ret)
+		return ret;
+
+	mutex_lock(&fs210x->lock);
+	ret = fs210x_init_chip(fs210x);
+	mutex_unlock(&fs210x->lock);
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
+	regcache_cache_only(fs210x->regmap, true);
+
+	mutex_lock(&fs210x->lock);
+	fs210x->cur_scene = NULL;
+	fs210x->is_inited = false;
+	fs210x->is_playing = false;
+	fs210x->is_suspended = true;
+
+	gpiod_set_value_cansleep(fs210x->gpio_sdz, 1); /* Active */
+	fsleep(30000); /* >= 30ms */
+	mutex_unlock(&fs210x->lock);
+
+	cancel_delayed_work_sync(&fs210x->start_work);
+	cancel_delayed_work_sync(&fs210x->fault_check_work);
+
+	ret = regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+	if (ret) {
+		dev_err(fs210x->dev, "Failed to suspend: %d\n", ret);
+		return ret;
+	}
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
+	mutex_lock(&fs210x->lock);
+
+	fs210x->is_suspended = false;
+	ret = fs210x_init_chip(fs210x);
+
+	mutex_unlock(&fs210x->lock);
+
+	return ret;
+}
+#else
+#define fs210x_suspend NULL
+#define fs210x_resume NULL
+#endif // CONFIG_PM
+
+static bool fs210x_volatile_registers(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case FS210X_00H_STATUS ... FS210X_0FH_I2CADDR:
+	case FS210X_ABH_INTSTAT:
+	case FS210X_ACH_INTSTATR:
+		return true;
+	default:
+		return false;
+	}
+}
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
+};
+
+static const struct regmap_config fs210x_regmap = {
+	.reg_bits		= 8,
+	.val_bits		= 16,
+	.max_register		= FS210X_REG_MAX,
+	.val_format_endian	= REGMAP_ENDIAN_BIG,
+	.cache_type		= REGCACHE_MAPLE,
+	.volatile_reg		= fs210x_volatile_registers,
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
+	if (IS_ERR(fs210x->gpio_sdz))
+		return dev_err_probe(fs210x->dev, PTR_ERR(fs210x->gpio_sdz),
+				     "Failed to get reset-gpios\n");
+
+	for (i = 0; i < FS210X_NUM_SUPPLIES; i++)
+		fs210x->supplies[i].supply = fs210x_supply_names[i];
+
+	ret = devm_regulator_bulk_get(fs210x->dev,
+				      ARRAY_SIZE(fs210x->supplies),
+				      fs210x->supplies);
+	if (ret)
+		return dev_err_probe(fs210x->dev, ret,
+				     "Failed to get supplies\n");
+
+	return 0;
+}
+
+static void fs210x_deinit(struct fs210x_priv *fs210x)
+{
+	gpiod_set_value_cansleep(fs210x->gpio_sdz, 1); /* Active */
+	fsleep(10000); /* >= 10ms */
+
+	regulator_bulk_disable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+}
+
+static int fs210x_init(struct fs210x_priv *fs210x)
+{
+	int ret;
+
+	ret = fs210x_parse_dts(fs210x, &fs210x->pdata);
+	if (ret)
+		return ret;
+
+	fs210x->clk_bclk = devm_clk_get_optional(fs210x->dev, "bclk");
+	if (IS_ERR(fs210x->clk_bclk))
+		return dev_err_probe(fs210x->dev, PTR_ERR(fs210x->clk_bclk),
+				     "Failed to get bclk\n");
+
+	ret = regulator_bulk_enable(FS210X_NUM_SUPPLIES, fs210x->supplies);
+	if (ret)
+		return dev_err_probe(fs210x->dev, ret,
+				     "Failed to enable supplies\n");
+
+	/* Make sure the SDZ pin is pulled down enough time. */
+	fsleep(10000); /* >= 10ms */
+	gpiod_set_value_cansleep(fs210x->gpio_sdz, 0); /* Deactivate */
+	fsleep(10000); /* >= 10ms */
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
+	fs210x->check_interval_ms = FS210X_FAULT_CHECK_INTERVAL_MS;
+
+	INIT_DELAYED_WORK(&fs210x->fault_check_work, fs210x_fault_check_work);
+	INIT_DELAYED_WORK(&fs210x->start_work, fs210x_start_work);
+	mutex_init(&fs210x->lock);
+
+	return 0;
+}
+
+static int fs210x_register_snd_component(struct fs210x_priv *fs210x)
+{
+	struct snd_soc_dai_driver *dai_drv;
+	static int instance_id;
+	int ret;
+
+	dai_drv = devm_kmemdup(fs210x->dev, &fs210x_dai,
+			       sizeof(fs210x_dai), GFP_KERNEL);
+	if (!dai_drv)
+		return -ENOMEM;
+
+	dai_drv->name = devm_kasprintf(fs210x->dev,
+				       GFP_KERNEL, "%s-%d",
+				       dai_drv->name, instance_id);
+	instance_id++;
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
+static ssize_t check_interval_ms_show(struct device *dev,
+				      struct device_attribute *devattr,
+				      char *buf)
+{
+	struct fs210x_priv *fs210x = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", fs210x->check_interval_ms);
+}
+
+static ssize_t check_interval_ms_store(struct device *dev,
+				       struct device_attribute *devattr,
+				       const char *buf,
+				       size_t count)
+{
+	struct fs210x_priv *fs210x = dev_get_drvdata(dev);
+	int ret;
+
+	ret = kstrtouint(buf, 10, &fs210x->check_interval_ms);
+	if (ret)
+		return -EINVAL;
+
+	return (ssize_t)count;
+}
+
+static DEVICE_ATTR_RW(check_interval_ms);
+
+static struct attribute *fs210x_attrs[] = {
+	&dev_attr_check_interval_ms.attr,
+	NULL,
+};
+
+static struct attribute_group fs210x_attr_group = {
+	.attrs = fs210x_attrs,
+};
+
+static int fs210x_i2c_probe(struct i2c_client *client)
+{
+	struct fs210x_priv *fs210x;
+	int ret;
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
+	if (IS_ERR(fs210x->regmap))
+		return dev_err_probe(fs210x->dev, PTR_ERR(fs210x->regmap),
+				     "Failed to get regmap\n");
+
+	ret = fs210x_init(fs210x);
+	if (ret)
+		return ret;
+
+	ret = devm_device_add_group(fs210x->dev, &fs210x_attr_group);
+	if (ret) {
+		fs210x_deinit(fs210x);
+		return dev_err_probe(fs210x->dev, ret,
+				     "Failed to create sysfs group\n");
+	}
+
+	ret = fs210x_register_snd_component(fs210x);
+	if (ret) {
+		fs210x_deinit(fs210x);
+		return dev_err_probe(fs210x->dev, ret,
+				     "Failed to register component\n");
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
+static const struct of_device_id fs210x_of_match[] = {
+	{ .compatible = "foursemi,fs2105s", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, fs210x_of_match);
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
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/fs210x.h b/sound/soc/codecs/fs210x.h
new file mode 100644
index 000000000..78e176033
--- /dev/null
+++ b/sound/soc/codecs/fs210x.h
@@ -0,0 +1,75 @@
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
+#define FS210X_0FH_I2CADDR		0x0F
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
+
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
2.39.5


