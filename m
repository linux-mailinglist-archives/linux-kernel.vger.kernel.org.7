Return-Path: <linux-kernel+bounces-762415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F89FB20648
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079F43B2327
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D1280CFB;
	Mon, 11 Aug 2025 10:47:18 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543012820BF;
	Mon, 11 Aug 2025 10:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909237; cv=none; b=maxSE4fwogMUHuZmRnjPJFHtXhPUAbilm0mwIpvtVk1QK+PN/pW29X6WgVFKRG9kykm+mnxRghWnxAKFXXlI1O93179s3VQbFofad9a9sIA7Zwtp83vHo6dVkvzoSs8QcT09PLHyRJPbhpdUPuPpqe9cs+g+IkogdoZkPZfd0gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909237; c=relaxed/simple;
	bh=/v7fpTkX+Ta5MyUgpVSiRHxuMgpEQwDreBoLBP43Vpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9Ijm6prIPGfFxoUppTwhOi9uupT6byJBSRCVBV7Crahf+x5SJU1cRQrATRb68q22bLdUyRsBMuCEp7RuV75QxLhey+rRtU/AKW5znK0aFjh496bwZzA0gL7h3NwqRpo+Sp5TVY59T37mG/ielykzovfdRT2v0STT+E6OXjV7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com; spf=pass smtp.mailfrom=foursemi.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foursemi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foursemi.com
X-QQ-mid: zesmtpsz6t1754909180t3609caf1
X-QQ-Originating-IP: JKT3unE6PnQZgOZRbANpdhPKgUWm1sA0Zlsg2fUEVPA=
Received: from buildhost ( [183.17.229.251])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 11 Aug 2025 18:46:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10375292104618824567
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
Subject: [PATCH v6 3/5] ASoC: codecs: Add library for FourSemi audio amplifiers
Date: Mon, 11 Aug 2025 18:46:08 +0800
Message-ID: <77822D0108CCC1D0+20250811104610.8993-4-nick.li@foursemi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811104610.8993-1-nick.li@foursemi.com>
References: <20250811104610.8993-1-nick.li@foursemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:foursemi.com:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MF/ak9VXHA945XApBNAoYMyi4QohWieKSH/xnatRuJJM8BXViF7rYcr5
	67aM1viLApKFdAw/60P+fUdNeV6ZWiR11rr20FIjXX/3B7UCw109rR0frZFaizPI/P/9t1h
	NDvaLRD1AiZO2cpoxtWXEt6SGE0l9ijpi5/rrOP/xFA+9yTEGmO/HbH2Tzua0geI3eQQOIp
	TDFfjleVUalkvVh2aqw8pey7LuLJCcMRe2liu0JQErNU3RUNdZEQVtcpyh6iu63VIxxipL1
	jrX4UTgkMbKCS0lo+vbh5DFMaKGqtBM3fqdq9Dkn4x96nASFvGHfy/n4PmMYiUbI6gr6nMp
	f52ny/VfSxCfKS/Mn1Qu1CFCiJ/cniPDnXccGrVvPqQaIVjYlh4OVYDN+IgZl00lVqCePY6
	QDkgKX+Q/j3wVXUzqt/JKGEaiI8KHpnQOSKKW9N3sLIkJQ6vEoYu1T1ffLHY0r+qj6desmC
	+dnPUT9aXEjalsBK5ujnnlIe6g1rcw6xyV9J+/C5FgyprGxf1UuItckAbqkMNLCHOA70N0x
	n/pwsYKJ7R7M+2YMHN8rhKgh06IU6TmWSZF0agQyC7758qj59zkjmvT9devcmS3aGOXCF+p
	k9oDMU4gPyn35lUgGfysm//meEKn+VvIw/o2BItN/XTuhChTX8S3iCX8fs56kyQWwiU4hV+
	Sng9PhcSvLrqKotNZ2kDkYBSjxVvi/sgWqqVv3er38VWDlFiEgyCaVzYh8LZr4y0X2Q9Cnt
	d6pFd+kqyqTQd1hhVWj190Fn40FDeDLmBHksEc/daWVwWxvfDfCJAJDJJDMfYcJzpqBhI70
	PjbDzV8vGpHTAxrBP6TpaVlJPgMnREdzrQ6u9OeqRAuCrSFV1gpFyvt5OZ5en6xOcKlngzU
	afr17o/Oh8DD/KjxBf/kcPyEnonER8v4gyNswtx966iNpaRra8um1hEU4c3g+MyoCqJ1rSo
	CYU/O9td3TTAyXdahgHd/sQ+iT+8PKxdPU/DpHNCOaM8zRqiY2mBcYUAVSG3Qvwc98yZozi
	14PsXh5Xb1b2mvA2pNwPJcXjYj739dtd6YVZH3Ox0khwyTgQvV0CYnaCNc2336uACBwGhDM
	QCBTgP/X0oVbCBBYWg6yPYqbGyWQ+P3VCGaTP+c4K2Ori84pCo0E1ETm8A22bJKU1S7oZqA
	cP+W
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

This patch adds firmware loading and parsing support for FourSemi audio
amplifiers. The library handles firmware file (*.bin) generated by the
FourSemi tuning tool, which contains:
- Register initialization settings
- DSP effect parameters
- Multi-scene sound effect switching configurations(optional)

The firmware is required for proper initialization and configuration
of FourSemi amplifier devices.

Signed-off-by: Nick Li <nick.li@foursemi.com>
---
 sound/soc/codecs/Kconfig      |   3 +
 sound/soc/codecs/Makefile     |   2 +
 sound/soc/codecs/fs-amp-lib.c | 265 ++++++++++++++++++++++++++++++++++
 sound/soc/codecs/fs-amp-lib.h | 150 +++++++++++++++++++
 4 files changed, 420 insertions(+)
 create mode 100644 sound/soc/codecs/fs-amp-lib.c
 create mode 100644 sound/soc/codecs/fs-amp-lib.h

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 6d7e4725d..ecdc05ef3 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1232,6 +1232,9 @@ config SND_SOC_FRAMER
 	  To compile this driver as a module, choose M here: the module
 	  will be called snd-soc-framer.
 
+config SND_SOC_FS_AMP_LIB
+	select CRC16
+	tristate
 
 config SND_SOC_GTM601
 	tristate 'GTM601 UMTS modem audio codec'
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index a68c3d192..646e017a8 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -137,6 +137,7 @@ snd-soc-es8328-spi-y := es8328-spi.o
 snd-soc-es8375-y := es8375.o
 snd-soc-es8389-y := es8389.o
 snd-soc-framer-y := framer-codec.o
+snd-soc-fs-amp-lib-y := fs-amp-lib.o
 snd-soc-gtm601-y := gtm601.o
 snd-soc-hdac-hdmi-y := hdac_hdmi.o
 snd-soc-hdac-hda-y := hdac_hda.o
@@ -562,6 +563,7 @@ obj-$(CONFIG_SND_SOC_ES8328_SPI)+= snd-soc-es8328-spi.o
 obj-$(CONFIG_SND_SOC_ES8375)    += snd-soc-es8375.o
 obj-$(CONFIG_SND_SOC_ES8389)    += snd-soc-es8389.o
 obj-$(CONFIG_SND_SOC_FRAMER)	+= snd-soc-framer.o
+obj-$(CONFIG_SND_SOC_FS_AMP_LIB)+= snd-soc-fs-amp-lib.o
 obj-$(CONFIG_SND_SOC_GTM601)    += snd-soc-gtm601.o
 obj-$(CONFIG_SND_SOC_HDAC_HDMI) += snd-soc-hdac-hdmi.o
 obj-$(CONFIG_SND_SOC_HDAC_HDA) += snd-soc-hdac-hda.o
diff --git a/sound/soc/codecs/fs-amp-lib.c b/sound/soc/codecs/fs-amp-lib.c
new file mode 100644
index 000000000..75d8d5082
--- /dev/null
+++ b/sound/soc/codecs/fs-amp-lib.c
@@ -0,0 +1,265 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// fs-amp-lib.c --- Common library for FourSemi Audio Amplifiers
+//
+// Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
+
+#include <linux/crc16.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+
+#include "fs-amp-lib.h"
+
+static int fs_get_scene_count(struct fs_amp_lib *amp_lib)
+{
+	const struct fs_fwm_table *table;
+	int count;
+
+	if (!amp_lib || !amp_lib->dev)
+		return -EINVAL;
+
+	table = amp_lib->table[FS_INDEX_SCENE];
+	if (!table)
+		return -EFAULT;
+
+	count = table->size / sizeof(struct fs_scene_index);
+	if (count < 1 || count > FS_SCENE_COUNT_MAX) {
+		dev_err(amp_lib->dev, "Invalid scene count: %d\n", count);
+		return -ERANGE;
+	}
+
+	return count;
+}
+
+static void fs_get_fwm_string(struct fs_amp_lib *amp_lib,
+			      int offset, const char **pstr)
+{
+	const struct fs_fwm_table *table;
+
+	if (!amp_lib || !amp_lib->dev || !pstr)
+		return;
+
+	table = amp_lib->table[FS_INDEX_STRING];
+	if (table && offset > 0 && offset < table->size + sizeof(*table))
+		*pstr = (char *)table + offset;
+	else
+		*pstr = NULL;
+}
+
+static void fs_get_scene_reg(struct fs_amp_lib *amp_lib,
+			     int offset, struct fs_amp_scene *scene)
+{
+	const struct fs_fwm_table *table;
+
+	if (!amp_lib || !amp_lib->dev || !scene)
+		return;
+
+	table = amp_lib->table[FS_INDEX_REG];
+	if (table && offset > 0 && offset < table->size + sizeof(*table))
+		scene->reg = (struct fs_reg_table *)((char *)table + offset);
+	else
+		scene->reg = NULL;
+}
+
+static void fs_get_scene_model(struct fs_amp_lib *amp_lib,
+			       int offset, struct fs_amp_scene *scene)
+{
+	const struct fs_fwm_table *table;
+	const char *ptr;
+
+	if (!amp_lib || !amp_lib->dev || !scene)
+		return;
+
+	table = amp_lib->table[FS_INDEX_MODEL];
+	ptr = (char *)table;
+	if (table && offset > 0 && offset < table->size + sizeof(*table))
+		scene->model = (struct fs_file_table *)(ptr + offset);
+	else
+		scene->model = NULL;
+}
+
+static void fs_get_scene_effect(struct fs_amp_lib *amp_lib,
+				int offset, struct fs_amp_scene *scene)
+{
+	const struct fs_fwm_table *table;
+	const char *ptr;
+
+	if (!amp_lib || !amp_lib->dev || !scene)
+		return;
+
+	table = amp_lib->table[FS_INDEX_EFFECT];
+	ptr = (char *)table;
+	if (table && offset > 0 && offset < table->size + sizeof(*table))
+		scene->effect = (struct fs_file_table *)(ptr + offset);
+	else
+		scene->effect = NULL;
+}
+
+static int fs_parse_scene_tables(struct fs_amp_lib *amp_lib)
+{
+	const struct fs_scene_index *scene_index;
+	const struct fs_fwm_table *table;
+	struct fs_amp_scene *scene;
+	int idx, count;
+
+	if (!amp_lib || !amp_lib->dev)
+		return -EINVAL;
+
+	count = fs_get_scene_count(amp_lib);
+	if (count <= 0)
+		return -EFAULT;
+
+	scene = devm_kzalloc(amp_lib->dev, count * sizeof(*scene), GFP_KERNEL);
+	if (!scene)
+		return -ENOMEM;
+
+	amp_lib->scene_count = count;
+	amp_lib->scene = scene;
+
+	table = amp_lib->table[FS_INDEX_SCENE];
+	scene_index = (struct fs_scene_index *)table->buf;
+
+	for (idx = 0; idx < count; idx++) {
+		fs_get_fwm_string(amp_lib, scene_index->name, &scene->name);
+		if (!scene->name)
+			scene->name = devm_kasprintf(amp_lib->dev,
+						     GFP_KERNEL, "S%d", idx);
+		dev_dbg(amp_lib->dev, "scene.%d name: %s\n", idx, scene->name);
+		fs_get_scene_reg(amp_lib, scene_index->reg, scene);
+		fs_get_scene_model(amp_lib, scene_index->model, scene);
+		fs_get_scene_effect(amp_lib, scene_index->effect, scene);
+		scene++;
+		scene_index++;
+	}
+
+	return 0;
+}
+
+static int fs_parse_all_tables(struct fs_amp_lib *amp_lib)
+{
+	const struct fs_fwm_table *table;
+	const struct fs_fwm_index *index;
+	const char *ptr;
+	int idx, count;
+	int ret;
+
+	if (!amp_lib || !amp_lib->dev || !amp_lib->hdr)
+		return -EINVAL;
+
+	/* Parse all fwm tables */
+	table = (struct fs_fwm_table *)amp_lib->hdr->params;
+	index = (struct fs_fwm_index *)table->buf;
+	count = table->size / sizeof(*index);
+
+	for (idx = 0; idx < count; idx++, index++) {
+		if (index->type >= FS_INDEX_MAX)
+			return -ERANGE;
+		ptr = (char *)table + (int)index->offset;
+		amp_lib->table[index->type] = (struct fs_fwm_table *)ptr;
+	}
+
+	/* Parse all scene tables */
+	ret = fs_parse_scene_tables(amp_lib);
+	if (ret)
+		dev_err(amp_lib->dev, "Failed to parse scene: %d\n", ret);
+
+	return ret;
+}
+
+static int fs_verify_firmware(struct fs_amp_lib *amp_lib)
+{
+	const struct fs_fwm_header *hdr;
+	int crcsum;
+
+	if (!amp_lib || !amp_lib->dev || !amp_lib->hdr)
+		return -EINVAL;
+
+	hdr = amp_lib->hdr;
+
+	/* Verify the crcsum code */
+	crcsum = crc16(0x0000, (const char *)&hdr->crc_size, hdr->crc_size);
+	if (crcsum != hdr->crc16) {
+		dev_err(amp_lib->dev, "Failed to checksum: %x-%x\n",
+			crcsum, hdr->crc16);
+		return -EFAULT;
+	}
+
+	/* Verify the devid(chip_type) */
+	if (amp_lib->devid != LO_U16(hdr->chip_type)) {
+		dev_err(amp_lib->dev, "DEVID dismatch: %04X#%04X\n",
+			amp_lib->devid, hdr->chip_type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void fs_print_firmware_info(struct fs_amp_lib *amp_lib)
+{
+	const struct fs_fwm_header *hdr;
+	const char *pro_name = NULL;
+	const char *dev_name = NULL;
+
+	if (!amp_lib || !amp_lib->dev || !amp_lib->hdr)
+		return;
+
+	hdr = amp_lib->hdr;
+
+	fs_get_fwm_string(amp_lib, hdr->project, &pro_name);
+	fs_get_fwm_string(amp_lib, hdr->device, &dev_name);
+
+	dev_info(amp_lib->dev, "Project: %s Device: %s\n",
+		 pro_name ? pro_name : "null",
+		 dev_name ? dev_name : "null");
+
+	dev_info(amp_lib->dev, "Date: %04d%02d%02d-%02d%02d\n",
+		 hdr->date.year, hdr->date.month, hdr->date.day,
+		 hdr->date.hour, hdr->date.minute);
+}
+
+int fs_amp_load_firmware(struct fs_amp_lib *amp_lib, const char *name)
+{
+	const struct firmware *cont;
+	struct fs_fwm_header *hdr;
+	int ret;
+
+	if (!amp_lib || !amp_lib->dev || !name)
+		return -EINVAL;
+
+	ret = request_firmware(&cont, name, amp_lib->dev);
+	if (ret) {
+		dev_err(amp_lib->dev, "Failed to request %s: %d\n", name, ret);
+		return ret;
+	}
+
+	dev_info(amp_lib->dev, "Loading %s - size: %zu\n", name, cont->size);
+
+	hdr = devm_kmemdup(amp_lib->dev, cont->data, cont->size, GFP_KERNEL);
+	release_firmware(cont);
+	if (!hdr)
+		return -ENOMEM;
+
+	amp_lib->hdr = hdr;
+	ret = fs_verify_firmware(amp_lib);
+	if (ret) {
+		amp_lib->hdr = NULL;
+		return ret;
+	}
+
+	ret = fs_parse_all_tables(amp_lib);
+	if (ret) {
+		amp_lib->hdr = NULL;
+		return ret;
+	}
+
+	fs_print_firmware_info(amp_lib);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fs_amp_load_firmware);
+
+MODULE_AUTHOR("Nick Li <nick.li@foursemi.com>");
+MODULE_DESCRIPTION("FourSemi audio amplifier library");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/codecs/fs-amp-lib.h b/sound/soc/codecs/fs-amp-lib.h
new file mode 100644
index 000000000..4a77c7b38
--- /dev/null
+++ b/sound/soc/codecs/fs-amp-lib.h
@@ -0,0 +1,150 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * fs-amp-lib.h --- Common library for FourSemi Audio Amplifiers
+ *
+ * Copyright (C) 2016-2025 Shanghai FourSemi Semiconductor Co.,Ltd.
+ */
+
+#ifndef __FS_AMP_LIB_H__
+#define __FS_AMP_LIB_H__
+
+#define HI_U16(a)		(((a) >> 8) & 0xFF)
+#define LO_U16(a)		((a) & 0xFF)
+#define FS_TABLE_NAME_LEN	(4)
+#define FS_SCENE_COUNT_MAX	(16)
+#define FS_CMD_DELAY_MS_MAX	(100) /* 100ms */
+
+#define FS_CMD_DELAY		(0xFF)
+#define FS_CMD_BURST		(0xFE)
+#define FS_CMD_UPDATE		(0xFD)
+
+#define FS_SOC_ENUM_EXT(xname, xhandler_info, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
+	.info = xhandler_info, \
+	.get = xhandler_get, .put = xhandler_put \
+}
+
+enum fs_index_type {
+	FS_INDEX_INFO = 0,
+	FS_INDEX_STCOEF,
+	FS_INDEX_SCENE,
+	FS_INDEX_MODEL,
+	FS_INDEX_REG,
+	FS_INDEX_EFFECT,
+	FS_INDEX_STRING,
+	FS_INDEX_WOOFER,
+	FS_INDEX_MAX,
+};
+
+#pragma pack(push, 1)
+
+struct fs_reg_val {
+	u8 reg;
+	u16 val;
+};
+
+struct fs_reg_bits {
+	u8 cmd; /* FS_CMD_UPDATE */
+	u8 reg;
+	u16 val;
+	u16 mask;
+};
+
+struct fs_cmd_pkg {
+	union {
+		u8 cmd;
+		struct fs_reg_val regv;
+		struct fs_reg_bits regb;
+	};
+};
+
+struct fs_fwm_index {
+	/* Index type */
+	u16 type;
+	/* Offset address starting from the end of header */
+	u16 offset;
+};
+
+struct fs_fwm_table {
+	char name[FS_TABLE_NAME_LEN];
+	u16 size; /* size of buf */
+	u8 buf[];
+};
+
+struct fs_scene_index {
+	/* Offset address(scene name) in string table */
+	u16 name;
+	/* Offset address(scene reg) in register table */
+	u16 reg;
+	/* Offset address(scene model) in model table */
+	u16 model;
+	/* Offset address(scene effect) in effect table */
+	u16 effect;
+};
+
+struct fs_reg_table {
+	u16 size; /* size of buf */
+	u8 buf[];
+};
+
+struct fs_file_table {
+	u16 name;
+	u16 size; /* size of buf */
+	u8 buf[];
+};
+
+struct fs_fwm_date {
+	u32 year:12;
+	u32 month:4;
+	u32 day:5;
+	u32 hour:5;
+	u32 minute:6;
+};
+
+struct fs_fwm_header {
+	u16 version;
+	u16 project; /* Offset address(project name) in string table */
+	u16 device; /* Offset address(device name) in string table */
+	struct fs_fwm_date date;
+	u16 crc16;
+	u16 crc_size; /* Starting position for CRC checking */
+	u16 chip_type;
+	u16 addr; /* 7-bit i2c address */
+	u16 spkid;
+	u16 rsvd[6];
+	u8 params[];
+};
+
+#pragma pack(pop)
+
+struct fs_i2s_srate {
+	u32 srate; /* Sample rate */
+	u16 i2ssr; /* Value of Bit field[I2SSR] */
+};
+
+struct fs_pll_div {
+	unsigned int bclk; /* Rate of bit clock */
+	u16 pll1;
+	u16 pll2;
+	u16 pll3;
+};
+
+struct fs_amp_scene {
+	const char *name;
+	const struct fs_reg_table  *reg;
+	const struct fs_file_table *model;
+	const struct fs_file_table *effect;
+};
+
+struct fs_amp_lib {
+	const struct fs_fwm_header *hdr;
+	const struct fs_fwm_table *table[FS_INDEX_MAX];
+	struct fs_amp_scene *scene;
+	struct device *dev;
+	int scene_count;
+	u16 devid;
+};
+
+int fs_amp_load_firmware(struct fs_amp_lib *amp_lib, const char *name);
+
+#endif // __FS_AMP_LIB_H__
-- 
2.50.1


