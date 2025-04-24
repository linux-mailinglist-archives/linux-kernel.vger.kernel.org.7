Return-Path: <linux-kernel+bounces-618503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7865A9AF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA619A4686
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 13:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66AF19F47E;
	Thu, 24 Apr 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eLnRvMYb"
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DB9187FE4
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 13:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745501943; cv=none; b=fmRSFV7M41ovTpO1ZAOcnexoaa9Rrnot0I6uTv7Au/muP+G9Y5Vub7Z7D5H1OLy8X64oPJTdMfrIE3JpFoXKLh+AARdqbbd8tg0x7Mn6xHYogbJThXeRdEz67J0+v6VFQi2QWArs6Qlb2rJk+M70LaazZCYR3l4PBsE/OOIunoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745501943; c=relaxed/simple;
	bh=GzFFdc3CtWq5cVjn/JdaPwAU/RmLGEc2mTvg8/Cg6xw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kN+VcA00K1Ohdu2LGKqlcZwc13KBjA1b/F+8eN4FQJo+A0HsVJ1+/92XQmSXFVYWJQtzGgVuzRQPmvvDCYS0TSduy5CvhtlCZDMfWL1zJhaHoWlRsPOimiNyud6lrejZl6S+tZup+5xtnnGMkCSSHPs3GATJ4QbMC9MxlaojrQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eLnRvMYb; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53ODcSZO2504938
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 08:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1745501908;
	bh=1j+CwbS7H4gWYoWR1YjsakFLpzi8Th/NmvJJcY0US08=;
	h=From:To:CC:Subject:Date;
	b=eLnRvMYbPcqDvLtGKWw+0wnD8gPrzj6X3iLOpoZP8f4EvOFb4DZUXBAjBuu8RVCJK
	 WHR9SlcBhFOVAvJ/HARAhU2HFgTORjjKCIdH8DJjI4piKE8/wpyU2B2f8CeBYIZ/iW
	 Zz6PdpMPoZpXcvwFSWJM78a7DlEM52T28cbepe2U=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53ODcS0B078369
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Apr 2025 08:38:28 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Apr 2025 08:38:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Apr 2025 08:38:28 -0500
Received: from LT5CG31242FY.dhcp.ti.com ([10.250.162.23])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53ODcIPN012135;
	Thu, 24 Apr 2025 08:38:19 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <robinchen@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ALSA: hda/tas2781: Remove tas2781_spi_fwlib.c and leverage SND_SOC_TAS2781_FMWLIB
Date: Thu, 24 Apr 2025 21:38:14 +0800
Message-ID: <20250424133814.216-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Most codes in tas2781_spi_fwlib.c are same as tas2781-fmwlib.c, mainly for
firmware parsing, only differece is the register reading, bit update and
book switching in i2c and spi. The main purpose of this patch is for code
cleaup and arrange the shared part for i2c and spi.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v1:
 - Move the definition of TASDEVICE_CRC8_POLYNOMIAL to tas2781.h for both
   SPI use.
 - Add isspi flag in the struct tasdevice_priv to distinguish SPI or I2C.
 - Define three register-read related methods due to the difference between
   SPI and I2C. For SPI-based TAS2781, it will have one-byte delay to read
   memory-mapped registers. During init, these three method will be
   initialized as spi or i2c register-read methods.
 - Define book-switching method due to the difference between SPI and I2C.
 - Add select SND_SOC_TAS2781_COMLIB & SND_SOC_TAS2781_FMWLIB for
   tas2781 hda spi driver in Kconfig.
 - remove tas2781-spi.h & tas2781_spi_fwlib.c.
 - remove tas2781_spi_fwlib.o in Makefile
 - Move the definition of TASDEVICE_CALIBRATION_DATA_NAME.
 - Remove the useless calib_data definition for code cleanup.
 - Define the TASDEV_CALIB_N definition in tas2781_hda.h for hda driver
   calibration.
 - Use TASDEV_CALIB_N instead of TAS2563_CAL_N.
 - Include tas2781.h instead of tas2781-dsp.h in tas2781_hda_spi.c.
 - Remove #include "tas2781-spi.h" in tas2781_hda_spi.c.
 - Move the macro definitions only for hda spi tas2781 driver into
   tas2781_hda_spi.c.
 - Add read_flag_mask and reg_shift setting in tasdevice_regmap.
---
 include/sound/tas2781.h           |   13 +
 sound/pci/hda/Kconfig             |    2 +
 sound/pci/hda/Makefile            |    2 +-
 sound/pci/hda/tas2781-spi.h       |  157 ---
 sound/pci/hda/tas2781_hda.h       |    3 +
 sound/pci/hda/tas2781_hda_i2c.c   |   25 +-
 sound/pci/hda/tas2781_hda_spi.c   |  540 ++++----
 sound/pci/hda/tas2781_spi_fwlib.c | 2006 -----------------------------
 sound/soc/codecs/tas2781-comlib.c |   18 +-
 sound/soc/codecs/tas2781-fmwlib.c |   17 +-
 10 files changed, 320 insertions(+), 2463 deletions(-)
 delete mode 100644 sound/pci/hda/tas2781-spi.h
 delete mode 100644 sound/pci/hda/tas2781_spi_fwlib.c

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index eff011444cc8..a86a82f4c544 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -32,6 +32,8 @@
 	SNDRV_PCM_FMTBIT_S24_LE | \
 	SNDRV_PCM_FMTBIT_S32_LE)
 
+#define TASDEVICE_CRC8_POLYNOMIAL		0x4d
+
 /* PAGE Control Register (available in page0 of each book) */
 #define TASDEVICE_PAGE_SELECT		0x00
 #define TASDEVICE_BOOKCTL_PAGE		0x00
@@ -193,6 +195,7 @@ struct tasdevice_priv {
 	bool force_fwload_status;
 	bool playback_started;
 	bool isacpi;
+	bool isspi;
 	bool is_user_space_calidata;
 	unsigned int global_addr;
 
@@ -210,6 +213,16 @@ struct tasdevice_priv {
 	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
 		struct tasdev_blk *block);
 
+	int (*change_chn_book)(struct tasdevice_priv *tas_priv,
+		unsigned short chn, int book);
+	int (*update_bits)(struct tasdevice_priv *tas_priv,
+		unsigned short chn, unsigned int reg, unsigned int mask,
+		unsigned int value);
+	int (*dev_read)(struct tasdevice_priv *tas_priv,
+		unsigned short chn, unsigned int reg, unsigned int *value);
+	int (*dev_bulk_read)(struct tasdevice_priv *tas_priv,
+		unsigned short chn, unsigned int reg, unsigned char *p_data,
+		unsigned int n_length);
 	int (*save_calibration)(struct tasdevice_priv *tas_priv);
 	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
 };
diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 9c427270ff4f..90f12e0227eb 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -210,6 +210,8 @@ config SND_HDA_SCODEC_TAS2781_SPI
 	depends on ACPI
 	depends on EFI
 	depends on SND_SOC
+	select SND_SOC_TAS2781_COMLIB
+	select SND_SOC_TAS2781_FMWLIB
 	select CRC32
 	help
 	  Say Y or M here to include TAS2781 SPI HD-audio side codec support
diff --git a/sound/pci/hda/Makefile b/sound/pci/hda/Makefile
index 210c406dfbc5..72ef3a64d9db 100644
--- a/sound/pci/hda/Makefile
+++ b/sound/pci/hda/Makefile
@@ -40,7 +40,7 @@ snd-hda-scodec-cs35l56-spi-y :=	cs35l56_hda_spi.o
 snd-hda-cs-dsp-ctls-y :=	hda_cs_dsp_ctl.o
 snd-hda-scodec-component-y :=	hda_component.o
 snd-hda-scodec-tas2781-i2c-y :=	tas2781_hda_i2c.o
-snd-hda-scodec-tas2781-spi-y :=	tas2781_hda_spi.o tas2781_spi_fwlib.o
+snd-hda-scodec-tas2781-spi-y :=	tas2781_hda_spi.o
 
 # common driver
 obj-$(CONFIG_SND_HDA) := snd-hda-codec.o
diff --git a/sound/pci/hda/tas2781-spi.h b/sound/pci/hda/tas2781-spi.h
deleted file mode 100644
index 7a0faceeb675..000000000000
--- a/sound/pci/hda/tas2781-spi.h
+++ /dev/null
@@ -1,157 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-//
-// ALSA SoC Texas Instruments TAS2781 Audio Smart Amplifier
-//
-// Copyright (C) 2024 Texas Instruments Incorporated
-// https://www.ti.com
-//
-// The TAS2781 driver implements a flexible and configurable
-// algo coefficient setting for TAS2781 chips.
-//
-// Author: Baojun Xu <baojun.xu@ti.com>
-//
-
-#ifndef __TAS2781_SPI_H__
-#define __TAS2781_SPI_H__
-
-#define TASDEVICE_RATES			\
-	(SNDRV_PCM_RATE_44100 |	SNDRV_PCM_RATE_48000 | \
-	SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_88200)
-
-#define TASDEVICE_FORMATS		\
-	(SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE | \
-	SNDRV_PCM_FMTBIT_S32_LE)
-
-#define TASDEVICE_MAX_BOOK_NUM		256
-#define TASDEVICE_MAX_PAGE		256
-
-#define TASDEVICE_MAX_SIZE	(TASDEVICE_MAX_BOOK_NUM * TASDEVICE_MAX_PAGE)
-
-/* PAGE Control Register (available in page0 of each book) */
-#define TASDEVICE_PAGE_SELECT		0x00
-#define TASDEVICE_BOOKCTL_PAGE		0x00
-#define TASDEVICE_BOOKCTL_REG		GENMASK(7, 1)
-#define TASDEVICE_BOOK_ID(reg)		(((reg) & GENMASK(24, 16)) >> 16)
-#define TASDEVICE_PAGE_ID(reg)		(((reg) & GENMASK(15, 8)) >> 8)
-#define TASDEVICE_REG_ID(reg)		(((reg) & GENMASK(7, 1)) >> 1)
-#define TASDEVICE_PAGE_REG(reg)		((reg) & GENMASK(15, 1))
-#define TASDEVICE_REG(book, page, reg)	\
-	(((book) << 16) | ((page) << 8) | ((reg) << 1))
-
-/* Software Reset */
-#define TAS2781_REG_SWRESET		TASDEVICE_REG(0x0, 0x0, 0x01)
-#define TAS2781_REG_SWRESET_RESET	BIT(0)
-
-/* System Reset Check Register */
-#define TAS2781_REG_CLK_CONFIG		TASDEVICE_REG(0x0, 0x0, 0x5c)
-#define TAS2781_REG_CLK_CONFIG_RESET	(0x19)
-#define TAS2781_PRE_POST_RESET_CFG	3
-
-/* Block Checksum */
-#define TASDEVICE_CHECKSUM		TASDEVICE_REG(0x0, 0x0, 0x7e)
-
-/* Volume control */
-#define TAS2781_DVC_LVL			TASDEVICE_REG(0x0, 0x0, 0x1a)
-#define TAS2781_AMP_LEVEL		TASDEVICE_REG(0x0, 0x0, 0x03)
-#define TAS2781_AMP_LEVEL_MASK		GENMASK(5, 1)
-
-#define TASDEVICE_CMD_SING_W		0x1
-#define TASDEVICE_CMD_BURST		0x2
-#define TASDEVICE_CMD_DELAY		0x3
-#define TASDEVICE_CMD_FIELD_W		0x4
-
-#define TAS2781_SPI_MAX_FREQ		(4 * HZ_PER_MHZ)
-
-#define TASDEVICE_CRC8_POLYNOMIAL		0x4d
-#define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
-
-/* Flag of calibration registers address. */
-#define TASDEVICE_CALIBRATION_REG_ADDRESS	BIT(7)
-
-#define TASDEVICE_CALIBRATION_DATA_NAME	L"CALI_DATA"
-#define TASDEVICE_CALIBRATION_DATA_SIZE	256
-
-enum calib_data {
-	R0_VAL = 0,
-	INV_R0,
-	R0LOW,
-	POWER,
-	TLIM,
-	CALIB_MAX
-};
-
-struct tasdevice_priv {
-	struct tasdevice_fw *cali_data_fmw;
-	struct tasdevice_rca rcabin;
-	struct tasdevice_fw *fmw;
-	struct gpio_desc *reset;
-	struct mutex codec_lock;
-	struct regmap *regmap;
-	struct device *dev;
-
-	unsigned char crc8_lkp_tbl[CRC8_TABLE_SIZE];
-	unsigned char coef_binaryname[64];
-	unsigned char rca_binaryname[64];
-	unsigned char dev_name[32];
-
-	bool force_fwload_status;
-	bool playback_started;
-	bool is_loading;
-	bool is_loaderr;
-	unsigned int cali_reg_array[CALIB_MAX];
-	unsigned int cali_data[CALIB_MAX];
-	unsigned int err_code;
-	void *codec;
-	int cur_book;
-	int cur_prog;
-	int cur_conf;
-	int fw_state;
-	int index;
-	int irq;
-
-	int (*fw_parse_variable_header)(struct tasdevice_priv *tas_priv,
-					const struct firmware *fmw,
-					int offset);
-	int (*fw_parse_program_data)(struct tasdevice_priv *tas_priv,
-				     struct tasdevice_fw *tas_fmw,
-				     const struct firmware *fmw, int offset);
-	int (*fw_parse_configuration_data)(struct tasdevice_priv *tas_priv,
-					   struct tasdevice_fw *tas_fmw,
-					   const struct firmware *fmw,
-					   int offset);
-	int (*tasdevice_load_block)(struct tasdevice_priv *tas_priv,
-				    struct tasdev_blk *block);
-
-	int (*save_calibration)(struct tasdevice_priv *tas_priv);
-	void (*apply_calibration)(struct tasdevice_priv *tas_priv);
-};
-
-int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
-			   unsigned int reg, unsigned int *value);
-int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
-			    unsigned int reg, unsigned int value);
-int tasdevice_spi_dev_bulk_write(struct tasdevice_priv *tas_priv,
-				 unsigned int reg, unsigned char *p_data,
-				 unsigned int n_length);
-int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
-				unsigned int reg, unsigned char *p_data,
-				unsigned int n_length);
-int tasdevice_spi_dev_update_bits(struct tasdevice_priv *tasdevice,
-				  unsigned int reg, unsigned int mask,
-				  unsigned int value);
-
-void tasdevice_spi_select_cfg_blk(void *context, int conf_no,
-				  unsigned char block_type);
-void tasdevice_spi_config_info_remove(void *context);
-int tasdevice_spi_dsp_parser(void *context);
-int tasdevice_spi_rca_parser(void *context, const struct firmware *fmw);
-void tasdevice_spi_dsp_remove(void *context);
-void tasdevice_spi_calbin_remove(void *context);
-int tasdevice_spi_select_tuningprm_cfg(void *context, int prm, int cfg_no,
-				       int rca_conf_no);
-int tasdevice_spi_prmg_load(void *context, int prm_no);
-int tasdevice_spi_prmg_calibdata_load(void *context, int prm_no);
-void tasdevice_spi_tuning_switch(void *context, int state);
-int tas2781_spi_load_calibration(void *context, char *file_name,
-				 unsigned short i);
-#endif /* __TAS2781_SPI_H__ */
diff --git a/sound/pci/hda/tas2781_hda.h b/sound/pci/hda/tas2781_hda.h
index 32d27b202591..444231f87e53 100644
--- a/sound/pci/hda/tas2781_hda.h
+++ b/sound/pci/hda/tas2781_hda.h
@@ -9,6 +9,9 @@
 
 #include <sound/asound.h>
 
+#define TASDEVICE_CALIBRATION_DATA_NAME	L"CALI_DATA"
+#define TASDEV_CALIB_N			5
+
 /*
  * No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
  * Define two controls, one is Volume control callbacks, the other is
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2c.c
index 9d94ae5fcfe0..1be86d1b4a53 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -34,15 +34,6 @@
 
 #define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
 
-enum calib_data {
-	R0_VAL = 0,
-	INV_R0,
-	R0LOW,
-	POWER,
-	TLIM,
-	CALIB_MAX
-};
-
 #define TAS2563_MAX_CHANNELS	4
 
 #define TAS2563_CAL_POWER	TASDEVICE_REG(0, 0x0d, 0x3c)
@@ -50,17 +41,15 @@ enum calib_data {
 #define TAS2563_CAL_INVR0	TASDEVICE_REG(0, 0x0f, 0x40)
 #define TAS2563_CAL_R0_LOW	TASDEVICE_REG(0, 0x0f, 0x48)
 #define TAS2563_CAL_TLIM	TASDEVICE_REG(0, 0x10, 0x14)
-#define TAS2563_CAL_N		5
 #define TAS2563_CAL_DATA_SIZE	4
 #define TAS2563_CAL_CH_SIZE	20
 #define TAS2563_CAL_ARRAY_SIZE	80
 
-static unsigned int cal_regs[TAS2563_CAL_N] = {
+static unsigned int cal_regs[TASDEV_CALIB_N] = {
 	TAS2563_CAL_POWER, TAS2563_CAL_R0, TAS2563_CAL_INVR0,
 	TAS2563_CAL_R0_LOW, TAS2563_CAL_TLIM,
 };
 
-
 struct tas2781_hda {
 	struct device *dev;
 	struct tasdevice_priv *priv;
@@ -475,7 +464,7 @@ static void tas2563_apply_calib(struct tasdevice_priv *tas_priv)
 	int ret;
 
 	for (int i = 0; i < tas_priv->ndev; i++) {
-		for (int j = 0; j < TAS2563_CAL_N; ++j) {
+		for (int j = 0; j < TASDEV_CALIB_N; ++j) {
 			data = cpu_to_be32(
 				*(uint32_t *)&tas_priv->cali_data.data[offset]);
 			ret = tasdevice_dev_bulk_write(tas_priv, i, cal_regs[j],
@@ -493,7 +482,7 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
 	static efi_guid_t efi_guid = EFI_GUID(0x1f52d2a1, 0xbb3a, 0x457d, 0xbc,
 		0x09, 0x43, 0xa3, 0xf4, 0x31, 0x0a, 0x92);
 
-	static efi_char16_t *efi_vars[TAS2563_MAX_CHANNELS][TAS2563_CAL_N] = {
+	static efi_char16_t *efi_vars[TAS2563_MAX_CHANNELS][TASDEV_CALIB_N] = {
 		{ L"Power_1", L"R0_1", L"InvR0_1", L"R0_Low_1", L"TLim_1" },
 		{ L"Power_2", L"R0_2", L"InvR0_2", L"R0_Low_2", L"TLim_2" },
 		{ L"Power_3", L"R0_3", L"InvR0_3", L"R0_Low_3", L"TLim_3" },
@@ -511,7 +500,7 @@ static int tas2563_save_calibration(struct tasdevice_priv *tas_priv)
 		return -ENOMEM;
 
 	for (int i = 0; i < tas_priv->ndev; ++i) {
-		for (int j = 0; j < TAS2563_CAL_N; ++j) {
+		for (int j = 0; j < TASDEV_CALIB_N; ++j) {
 			status = efi.get_variable(efi_vars[i][j],
 				&efi_guid, &attr, &max_size,
 				&tas_priv->cali_data.data[offset]);
@@ -535,7 +524,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 {
 	struct calidata *cali_data = &tas_priv->cali_data;
 	struct cali_reg *r = &cali_data->cali_reg_array;
-	unsigned int cali_reg[CALIB_MAX] = {
+	unsigned int cali_reg[TASDEV_CALIB_N] = {
 		TASDEVICE_REG(0, 0x17, 0x74),
 		TASDEVICE_REG(0, 0x18, 0x0c),
 		TASDEVICE_REG(0, 0x18, 0x14),
@@ -555,7 +544,7 @@ static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 	}
 
 	for (i = 0; i < tas_priv->ndev; i++) {
-		for (j = 0; j < CALIB_MAX; j++) {
+		for (j = 0; j < TASDEV_CALIB_N; j++) {
 			data = cpu_to_be32(
 				*(uint32_t *)&tas_priv->cali_data.data[oft]);
 			rc = tasdevice_dev_bulk_write(tas_priv, i,
@@ -578,7 +567,7 @@ static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
 {
 	efi_guid_t efi_guid = EFI_GUID(0x02f9af02, 0x7734, 0x4233, 0xb4, 0x3d,
 		0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
-	static efi_char16_t efi_name[] = L"CALI_DATA";
+	static efi_char16_t efi_name[] = TASDEVICE_CALIBRATION_DATA_NAME;
 	unsigned int attr, crc;
 	unsigned int *tmp_val;
 	efi_status_t status;
diff --git a/sound/pci/hda/tas2781_hda_spi.c b/sound/pci/hda/tas2781_hda_spi.c
index 92be591c6bfe..977569ee4652 100644
--- a/sound/pci/hda/tas2781_hda_spi.c
+++ b/sound/pci/hda/tas2781_hda_spi.c
@@ -27,12 +27,10 @@
 
 #include <sound/hda_codec.h>
 #include <sound/soc.h>
-#include <sound/tas2781-dsp.h>
+#include <sound/tas2781.h>
 #include <sound/tlv.h>
 #include <sound/tas2781-tlv.h>
 
-#include "tas2781-spi.h"
-
 #include "hda_local.h"
 #include "hda_auto_parser.h"
 #include "hda_component.h"
@@ -40,6 +38,17 @@
 #include "hda_generic.h"
 #include "tas2781_hda.h"
 
+#define TASDEVICE_RANGE_MAX_SIZE	(256 * 128)
+#define TASDEVICE_WIN_LEN		128
+#define TAS2781_SPI_MAX_FREQ		(4 * HZ_PER_MHZ)
+/* Flag of calibration registers address. */
+#define TASDEVICE_CALIBRATION_REG_ADDRESS	BIT(7)
+#define TASDEV_UEFI_CALI_REG_ADDR_FLG	BIT(7)
+
+/* System Reset Check Register */
+#define TAS2781_REG_CLK_CONFIG		TASDEVICE_REG(0x0, 0x0, 0x5c)
+#define TAS2781_REG_CLK_CONFIG_RESET	0x19
+
 struct tas2781_hda {
 	struct tasdevice_priv *priv;
 	struct acpi_device *dacpi;
@@ -52,12 +61,12 @@ struct tas2781_hda {
 static const struct regmap_range_cfg tasdevice_ranges[] = {
 	{
 		.range_min = 0,
-		.range_max = TASDEVICE_MAX_SIZE,
+		.range_max = TASDEVICE_RANGE_MAX_SIZE,
 		.selector_reg = TASDEVICE_PAGE_SELECT,
 		.selector_mask = GENMASK(7, 0),
 		.selector_shift = 0,
 		.window_start = 0,
-		.window_len = TASDEVICE_MAX_PAGE,
+		.window_len = TASDEVICE_WIN_LEN,
 	},
 };
 
@@ -65,39 +74,19 @@ static const struct regmap_config tasdevice_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.zero_flag_mask = true,
+	.read_flag_mask = 0x01,
+	.reg_shift = -1,
 	.cache_type = REGCACHE_NONE,
 	.ranges = tasdevice_ranges,
 	.num_ranges = ARRAY_SIZE(tasdevice_ranges),
-	.max_register = TASDEVICE_MAX_SIZE,
+	.max_register = TASDEVICE_RANGE_MAX_SIZE,
 };
 
-static int tasdevice_spi_switch_book(struct tasdevice_priv *tas_priv, int reg)
+static int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int *val)
 {
-	struct regmap *map = tas_priv->regmap;
-
-	if (tas_priv->cur_book != TASDEVICE_BOOK_ID(reg)) {
-		int ret = regmap_write(map, TASDEVICE_BOOKCTL_REG,
-				       TASDEVICE_BOOK_ID(reg));
-		if (ret < 0) {
-			dev_err(tas_priv->dev, "Switch Book E=%d\n", ret);
-			return ret;
-		}
-		tas_priv->cur_book = TASDEVICE_BOOK_ID(reg);
-	}
-	return 0;
-}
-
-int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
-			   unsigned int reg,
-			   unsigned int *val)
-{
-	struct regmap *map = tas_priv->regmap;
 	int ret;
 
-	ret = tasdevice_spi_switch_book(tas_priv, reg);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * In our TAS2781 SPI mode, if read from other book (not book 0),
 	 * or read from page number larger than 1 in book 0, one more byte
@@ -106,11 +95,11 @@ int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
 	if ((TASDEVICE_BOOK_ID(reg) > 0) || (TASDEVICE_PAGE_ID(reg) > 1)) {
 		unsigned char data[2];
 
-		ret = regmap_bulk_read(map, TASDEVICE_PAGE_REG(reg) | 1,
+		ret = tasdevice_dev_bulk_read(tas_priv, chn, reg,
 			data, sizeof(data));
 		*val = data[1];
 	} else {
-		ret = regmap_read(map, TASDEVICE_PAGE_REG(reg) | 1, val);
+		ret = tasdevice_dev_read(tas_priv, chn, reg, val);
 	}
 	if (ret < 0)
 		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
@@ -118,71 +107,25 @@ int tasdevice_spi_dev_read(struct tasdevice_priv *tas_priv,
 	return ret;
 }
 
-int tasdevice_spi_dev_write(struct tasdevice_priv *tas_priv,
-			    unsigned int reg,
-			    unsigned int value)
-{
-	struct regmap *map = tas_priv->regmap;
-	int ret;
-
-	ret = tasdevice_spi_switch_book(tas_priv, reg);
-	if (ret < 0)
-		return ret;
-
-	ret = regmap_write(map, TASDEVICE_PAGE_REG(reg), value);
-	if (ret < 0)
-		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
-
-	return ret;
-}
-
-int tasdevice_spi_dev_bulk_write(struct tasdevice_priv *tas_priv,
-				 unsigned int reg,
-				 unsigned char *data,
-				 unsigned int len)
-{
-	struct regmap *map = tas_priv->regmap;
-	int ret;
-
-	ret = tasdevice_spi_switch_book(tas_priv, reg);
-	if (ret < 0)
-		return ret;
-
-	ret = regmap_bulk_write(map, TASDEVICE_PAGE_REG(reg), data, len);
-	if (ret < 0)
-		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
-
-	return ret;
-}
-
-int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
-				unsigned int reg,
-				unsigned char *data,
-				unsigned int len)
+static int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned char *data,
+	unsigned int len)
 {
-	struct regmap *map = tas_priv->regmap;
 	int ret;
 
-	ret = tasdevice_spi_switch_book(tas_priv, reg);
-	if (ret < 0)
-		return ret;
-
-	if (len > TASDEVICE_MAX_PAGE)
-		len = TASDEVICE_MAX_PAGE;
 	/*
 	 * In our TAS2781 SPI mode, if read from other book (not book 0),
 	 * or read from page number larger than 1 in book 0, one more byte
 	 * read is needed, and first byte is a dummy byte, need to be ignored.
 	 */
 	if ((TASDEVICE_BOOK_ID(reg) > 0) || (TASDEVICE_PAGE_ID(reg) > 1)) {
-		unsigned char buf[TASDEVICE_MAX_PAGE+1];
+		unsigned char buf[TASDEVICE_WIN_LEN + 1];
 
-		ret = regmap_bulk_read(map, TASDEVICE_PAGE_REG(reg) | 1, buf,
-				      len + 1);
+		ret = tasdevice_dev_bulk_read(tas_priv, chn, reg,
+			buf, len + 1);
 		memcpy(data, buf + 1, len);
 	} else {
-		ret = regmap_bulk_read(map, TASDEVICE_PAGE_REG(reg) | 1, data,
-				      len);
+		ret = tasdevice_dev_bulk_read(tas_priv, chn, reg, data, len);
 	}
 	if (ret < 0)
 		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
@@ -190,31 +133,55 @@ int tasdevice_spi_dev_bulk_read(struct tasdevice_priv *tas_priv,
 	return ret;
 }
 
-int tasdevice_spi_dev_update_bits(struct tasdevice_priv *tas_priv,
-				  unsigned int reg,
-				  unsigned int mask,
-				  unsigned int value)
+static int tasdevice_spi_dev_update_bits(struct tasdevice_priv *tas_priv,
+	unsigned short chn, unsigned int reg, unsigned int mask,
+	unsigned int value)
 {
-	struct regmap *map = tas_priv->regmap;
 	int ret, val;
 
 	/*
 	 * In our TAS2781 SPI mode, read/write was masked in last bit of
 	 * address, it cause regmap_update_bits() not work as expected.
 	 */
-	ret = tasdevice_spi_dev_read(tas_priv, reg, &val);
+	ret = tasdevice_dev_read(tas_priv, chn, reg, &val);
 	if (ret < 0) {
 		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
 		return ret;
 	}
-	ret = regmap_write(map, TASDEVICE_PAGE_REG(reg),
-			  (val & ~mask) | (mask & value));
+
+	ret = tasdevice_dev_write(tas_priv, chn, TASDEVICE_PAGE_REG(reg),
+		(val & ~mask) | (mask & value));
 	if (ret < 0)
 		dev_err(tas_priv->dev, "%s, E=%d\n", __func__, ret);
 
 	return ret;
 }
 
+static int tasdevice_spi_change_chn_book(struct tasdevice_priv *p,
+	unsigned short chn, int book)
+{
+	int ret = 0;
+
+	if (chn == p->index) {
+		struct tasdevice *tasdev = &p->tasdevice[chn];
+		struct regmap *map = p->regmap;
+
+		if (tasdev->cur_book != book) {
+			ret = regmap_write(map, TASDEVICE_BOOKCTL_REG, book);
+			if (ret < 0)
+				dev_err(p->dev, "%s, E=%d\n", __func__, ret);
+			else
+				tasdev->cur_book = book;
+		}
+	} else {
+		ret = -EXDEV;
+		dev_dbg(p->dev, "Not error, %s ignore channel(%d)\n",
+			__func__, chn);
+	}
+
+	return ret;
+}
+
 static void tas2781_spi_reset(struct tasdevice_priv *tas_dev)
 {
 	int ret;
@@ -223,12 +190,13 @@ static void tas2781_spi_reset(struct tasdevice_priv *tas_dev)
 		gpiod_set_value_cansleep(tas_dev->reset, 0);
 		fsleep(800);
 		gpiod_set_value_cansleep(tas_dev->reset, 1);
+	} else {
+		ret = tasdevice_dev_write(tas_dev, tas_dev->index,
+			TASDEVICE_REG_SWRESET, TASDEVICE_REG_SWRESET_RESET);
+		if (ret < 0)
+			dev_err(tas_dev->dev, "dev sw-reset fail, %d\n", ret);
+		fsleep(1000);
 	}
-	ret = tasdevice_spi_dev_write(tas_dev, TAS2781_REG_SWRESET,
-		TAS2781_REG_SWRESET_RESET);
-	if (ret < 0)
-		dev_err(tas_dev->dev, "dev sw-reset fail, %d\n", ret);
-	fsleep(1000);
 }
 
 static int tascodec_spi_init(struct tasdevice_priv *tas_priv,
@@ -245,7 +213,7 @@ static int tascodec_spi_init(struct tasdevice_priv *tas_priv,
 
 	scnprintf(tas_priv->rca_binaryname,
 		sizeof(tas_priv->rca_binaryname), "%sRCA%d.bin",
-		tas_priv->dev_name, tas_priv->index);
+		tas_priv->dev_name, tas_priv->ndev);
 	crc8_populate_msb(tas_priv->crc8_lkp_tbl, TASDEVICE_CRC8_POLYNOMIAL);
 	tas_priv->codec = codec;
 	ret = request_firmware_nowait(module, FW_ACTION_UEVENT,
@@ -260,26 +228,22 @@ static int tascodec_spi_init(struct tasdevice_priv *tas_priv,
 
 static void tasdevice_spi_init(struct tasdevice_priv *tas_priv)
 {
-	tas_priv->cur_prog = -1;
-	tas_priv->cur_conf = -1;
+	tas_priv->tasdevice[tas_priv->index].cur_book = -1;
+	tas_priv->tasdevice[tas_priv->index].cur_conf = -1;
+	tas_priv->tasdevice[tas_priv->index].cur_prog = -1;
 
-	tas_priv->cur_book = -1;
-	tas_priv->cur_prog = -1;
-	tas_priv->cur_conf = -1;
+	tas_priv->isspi = true;
 
-	/* Store default registers address for calibration data. */
-	tas_priv->cali_reg_array[0] = TASDEVICE_REG(0, 0x17, 0x74);
-	tas_priv->cali_reg_array[1] = TASDEVICE_REG(0, 0x18, 0x0c);
-	tas_priv->cali_reg_array[2] = TASDEVICE_REG(0, 0x18, 0x14);
-	tas_priv->cali_reg_array[3] = TASDEVICE_REG(0, 0x13, 0x70);
-	tas_priv->cali_reg_array[4] = TASDEVICE_REG(0, 0x18, 0x7c);
+	tas_priv->update_bits = tasdevice_spi_dev_update_bits;
+	tas_priv->change_chn_book = tasdevice_spi_change_chn_book;
+	tas_priv->dev_read = tasdevice_spi_dev_read;
+	tas_priv->dev_bulk_read = tasdevice_spi_dev_bulk_read;
 
 	mutex_init(&tas_priv->codec_lock);
 }
 
 static int tasdevice_spi_amp_putvol(struct tasdevice_priv *tas_priv,
-				    struct snd_ctl_elem_value *ucontrol,
-				    struct soc_mixer_control *mc)
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
 {
 	unsigned int invert = mc->invert;
 	unsigned char mask;
@@ -290,7 +254,8 @@ static int tasdevice_spi_amp_putvol(struct tasdevice_priv *tas_priv,
 	mask <<= mc->shift;
 	val =  clamp(invert ? max - ucontrol->value.integer.value[0] :
 		ucontrol->value.integer.value[0], 0, max);
-	ret = tasdevice_spi_dev_update_bits(tas_priv,
+
+	ret = tasdevice_spi_dev_update_bits(tas_priv, tas_priv->index,
 		mc->reg, mask, (unsigned int)(val << mc->shift));
 	if (ret)
 		dev_err(tas_priv->dev, "set AMP vol error in dev %d\n",
@@ -300,16 +265,14 @@ static int tasdevice_spi_amp_putvol(struct tasdevice_priv *tas_priv,
 }
 
 static int tasdevice_spi_amp_getvol(struct tasdevice_priv *tas_priv,
-				    struct snd_ctl_elem_value *ucontrol,
-				    struct soc_mixer_control *mc)
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
 {
 	unsigned int invert = mc->invert;
 	unsigned char mask = 0;
 	int max = mc->max;
 	int ret, val;
 
-	/* Read the primary device */
-	ret = tasdevice_spi_dev_read(tas_priv, mc->reg, &val);
+	ret = tasdevice_spi_dev_read(tas_priv, tas_priv->index, mc->reg, &val);
 	if (ret) {
 		dev_err(tas_priv->dev, "%s, get AMP vol error\n", __func__);
 		return ret;
@@ -324,9 +287,8 @@ static int tasdevice_spi_amp_getvol(struct tasdevice_priv *tas_priv,
 	return ret;
 }
 
-static int tasdevice_spi_digital_putvol(struct tasdevice_priv *tas_priv,
-					struct snd_ctl_elem_value *ucontrol,
-					struct soc_mixer_control *mc)
+static int tasdevice_spi_digital_putvol(struct tasdevice_priv *p,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
 {
 	unsigned int invert = mc->invert;
 	int max = mc->max;
@@ -334,26 +296,23 @@ static int tasdevice_spi_digital_putvol(struct tasdevice_priv *tas_priv,
 
 	val = clamp(invert ? max - ucontrol->value.integer.value[0] :
 		ucontrol->value.integer.value[0], 0, max);
-	ret = tasdevice_spi_dev_write(tas_priv, mc->reg, (unsigned int)val);
+	ret = tasdevice_dev_write(p, p->index, mc->reg, (unsigned int)val);
 	if (ret)
-		dev_err(tas_priv->dev, "set digital vol err in dev %d\n",
-			tas_priv->index);
+		dev_err(p->dev, "set digital vol err in dev %d\n", p->index);
 
 	return ret;
 }
 
-static int tasdevice_spi_digital_getvol(struct tasdevice_priv *tas_priv,
-					struct snd_ctl_elem_value *ucontrol,
-					struct soc_mixer_control *mc)
+static int tasdevice_spi_digital_getvol(struct tasdevice_priv *p,
+	struct snd_ctl_elem_value *ucontrol, struct soc_mixer_control *mc)
 {
 	unsigned int invert = mc->invert;
 	int max = mc->max;
 	int ret, val;
 
-	/* Read the primary device as the whole */
-	ret = tasdevice_spi_dev_read(tas_priv, mc->reg, &val);
+	ret = tasdevice_spi_dev_read(p, p->index, mc->reg, &val);
 	if (ret) {
-		dev_err(tas_priv->dev, "%s, get digital vol err\n", __func__);
+		dev_err(p->dev, "%s, get digital vol err\n", __func__);
 		return ret;
 	}
 
@@ -392,7 +351,7 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
 		ret = -EINVAL;
 		goto err;
 	}
-	nval = ret;
+	p->ndev = nval = ret;
 
 	ret = device_property_read_u32_array(physdev, property, values, nval);
 	if (ret)
@@ -435,14 +394,17 @@ static int tas2781_read_acpi(struct tas2781_hda *tas_hda,
 static void tas2781_hda_playback_hook(struct device *dev, int action)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 
 	if (action == HDA_GEN_PCM_ACT_OPEN) {
 		pm_runtime_get_sync(dev);
-		guard(mutex)(&tas_hda->priv->codec_lock);
-		tasdevice_spi_tuning_switch(tas_hda->priv, 0);
+		guard(mutex)(&tas_priv->codec_lock);
+		if (tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK)
+			tasdevice_tuning_switch(tas_hda->priv, 0);
 	} else if (action == HDA_GEN_PCM_ACT_CLOSE) {
-		guard(mutex)(&tas_hda->priv->codec_lock);
-		tasdevice_spi_tuning_switch(tas_hda->priv, 1);
+		guard(mutex)(&tas_priv->codec_lock);
+		if (tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK)
+			tasdevice_tuning_switch(tas_priv, 1);
 		pm_runtime_mark_last_busy(dev);
 		pm_runtime_put_autosuspend(dev);
 	}
@@ -589,6 +551,7 @@ static int tas2781_digital_getvol(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 
+	guard(mutex)(&tas_priv->codec_lock);
 	return tasdevice_spi_digital_getvol(tas_priv, ucontrol, mc);
 }
 
@@ -599,6 +562,7 @@ static int tas2781_amp_getvol(struct snd_kcontrol *kcontrol,
 	struct soc_mixer_control *mc =
 		(struct soc_mixer_control *)kcontrol->private_value;
 
+	guard(mutex)(&tas_priv->codec_lock);
 	return tasdevice_spi_amp_getvol(tas_priv, ucontrol, mc);
 }
 
@@ -610,6 +574,7 @@ static int tas2781_digital_putvol(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 
 	/* The check of the given value is in tasdevice_digital_putvol. */
+	guard(mutex)(&tas_priv->codec_lock);
 	return tasdevice_spi_digital_putvol(tas_priv, ucontrol, mc);
 }
 
@@ -621,6 +586,7 @@ static int tas2781_amp_putvol(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 
 	/* The check of the given value is in tasdevice_amp_putvol. */
+	guard(mutex)(&tas_priv->codec_lock);
 	return tasdevice_spi_amp_putvol(tas_priv, ucontrol, mc);
 }
 
@@ -725,137 +691,164 @@ static const struct snd_kcontrol_new tas2781_dsp_conf_ctrl[] = {
 
 static void tas2781_apply_calib(struct tasdevice_priv *tas_priv)
 {
-	int i, rc;
-
-	/*
-	 * If no calibration data exist in tasdevice_priv *tas_priv,
-	 * calibration apply will be ignored, and use default values
-	 * in firmware binary, which was loaded during firmware download.
-	 */
-	if (tas_priv->cali_data[0] == 0)
-		return;
-	/*
-	 * Calibration data was saved in tasdevice_priv *tas_priv as:
-	 * unsigned int cali_data[CALIB_MAX];
-	 * and every data (in 4 bytes) will be saved in register which in
-	 * book 0, and page number in page_array[], offset was saved in
-	 * rgno_array[].
-	 */
-	for (i = 0; i < CALIB_MAX; i++) {
-		rc = tasdevice_spi_dev_bulk_write(tas_priv,
-			tas_priv->cali_reg_array[i],
-			(unsigned char *)&tas_priv->cali_data[i], 4);
-		if (rc < 0)
-			dev_err(tas_priv->dev,
-				"chn %d calib %d bulk_wr err = %d\n",
-				tas_priv->index, i, rc);
-	}
-}
-
-/*
- * Update the calibration data, including speaker impedance, f0, etc,
- * into algo. Calibrate data is done by manufacturer in the factory.
- * These data are used by Algo for calculating the speaker temperature,
- * speaker membrane excursion and f0 in real time during playback.
- * Calibration data format in EFI is V2, since 2024.
- */
-static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
-{
-	/*
-	 * GUID was used for data access in BIOS, it was provided by board
-	 * manufactory, like HP: "{02f9af02-7734-4233-b43d-93fe5aa35db3}"
-	 */
-	efi_guid_t efi_guid =
-		EFI_GUID(0x02f9af02, 0x7734, 0x4233,
-			 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
-	static efi_char16_t efi_name[] = TASDEVICE_CALIBRATION_DATA_NAME;
-	unsigned char data[TASDEVICE_CALIBRATION_DATA_SIZE], *buf;
-	unsigned int attr, crc, offset, *tmp_val;
-	unsigned long total_sz = 0;
-	efi_status_t status;
+	struct calidata *cali_data = &tas_priv->cali_data;
+	struct cali_reg *r = &cali_data->cali_reg_array;
+	unsigned char *data = cali_data->data;
+	unsigned int *tmp_val = (unsigned int *)data;
+	unsigned int cali_reg[TASDEV_CALIB_N] = {
+		TASDEVICE_REG(0, 0x17, 0x74),
+		TASDEVICE_REG(0, 0x18, 0x0c),
+		TASDEVICE_REG(0, 0x18, 0x14),
+		TASDEVICE_REG(0, 0x13, 0x70),
+		TASDEVICE_REG(0, 0x18, 0x7c),
+	};
+	unsigned int crc, oft;
+	unsigned char *buf;
+	int i, j, k, l;
 
-	tas_priv->cali_data[0] = 0;
-	status = efi.get_variable(efi_name, &efi_guid, &attr, &total_sz, data);
-	if (status == EFI_BUFFER_TOO_SMALL) {
-		if (total_sz > TASDEVICE_CALIBRATION_DATA_SIZE)
-			return -ENOMEM;
-		/* Get variable contents into buffer */
-		status = efi.get_variable(efi_name, &efi_guid, &attr,
-			&total_sz, data);
-	}
-	if (status != EFI_SUCCESS)
-		return status;
-
-	tmp_val = (unsigned int *)data;
 	if (tmp_val[0] == 2781) {
 		/*
 		 * New features were added in calibrated Data V3:
 		 *     1. Added calibration registers address define in
-		 *     a node, marked as Device id == 0x80.
+		 *	    a node, marked as Device id == 0x80.
 		 * New features were added in calibrated Data V2:
 		 *     1. Added some the fields to store the link_id and
-		 *     uniqie_id for multi-link solutions
+		 *	    uniqie_id for multi-link solutions
 		 *     2. Support flexible number of devices instead of
-		 *     fixed one in V1.
+		 *	    fixed one in V1.
 		 * Layout of calibrated data V2 in UEFI(total 256 bytes):
 		 *     ChipID (2781, 4 bytes)
-		 *     Device-Sum (4 bytes)
+		 *     Data-Group-Sum (4 bytes)
 		 *     TimeStamp of Calibration (4 bytes)
-		 *     for (i = 0; i < Device-Sum; i++) {
-		 *             Device #i index_info () {
-		 *                     SDW link id (2bytes)
-		 *                     SDW unique_id (2bytes)
-		 *             } // if Device number is 0x80, mean it's
-		 *                  calibration registers address.
-		 *             Calibrated Data of Device #i (20 bytes)
+		 *     for (i = 0; i < Data-Group-Sum; i++) {
+		 *	    if (Data type != 0x80) (4 bytes)
+		 *		 Calibrated Data of Device #i (20 bytes)
+		 *	    else
+		 *		 Calibration registers address (5*4 = 20 bytes)
+		 *		 # V2: No reg addr in data grp section.
+		 *		 # V3: Normally the last grp is the reg addr.
 		 *     }
 		 *     CRC (4 bytes)
 		 *     Reserved (the rest)
 		 */
 		crc = crc32(~0, data, (3 + tmp_val[1] * 6) * 4) ^ ~0;
 
-		if (crc != tmp_val[3 + tmp_val[1] * 6])
-			return 0;
-
-		for (int j = 0; j < tmp_val[1]; j++) {
-			offset = j * 6 + 3;
-			if (tmp_val[offset] == tas_priv->index) {
-				for (int i = 0; i < CALIB_MAX; i++)
-					tas_priv->cali_data[i] =
-					tmp_val[offset + i + 1];
-			} else if (tmp_val[offset] ==
-				   TASDEVICE_CALIBRATION_REG_ADDRESS) {
-				for (int i = 0; i < CALIB_MAX; i++) {
-					buf = &data[(offset + i + 1) * 4];
-					tas_priv->cali_reg_array[i] =
-						TASDEVICE_REG(buf[1], buf[2],
-						      buf[3]);
+		if (crc != tmp_val[3 + tmp_val[1] * 6]) {
+			cali_data->total_sz = 0;
+			dev_err(tas_priv->dev, "%s: CRC error\n", __func__);
+			return;
+		}
+
+		for (j = 0, k = 0; j < tmp_val[1]; j++) {
+			oft = j * 6 + 3;
+			if (tmp_val[oft] == TASDEV_UEFI_CALI_REG_ADDR_FLG) {
+				for (i = 0; i < TASDEV_CALIB_N; i++) {
+					buf = &data[(oft + i + 1) * 4];
+					cali_reg[i] = TASDEVICE_REG(buf[1],
+						buf[2], buf[3]);
+				}
+			} else {
+				l = j * (cali_data->cali_dat_sz_per_dev + 1);
+				if (k >= tas_priv->ndev || l > oft * 4) {
+					dev_err(tas_priv->dev,
+						"%s: dev sum error\n",
+						__func__);
+					cali_data->total_sz = 0;
+					return;
 				}
+
+				data[l] = k;
+				for (i = 0; i < TASDEV_CALIB_N * 4; i++)
+					data[l + i] = data[4 * oft + i];
+				k++;
 			}
-			tas_priv->apply_calibration(tas_priv);
 		}
 	} else {
 		/*
 		 * Calibration data is in V1 format.
 		 * struct cali_data {
-		 *      char cali_data[20];
+		 *     char cali_data[20];
 		 * }
 		 *
 		 * struct {
-		 *      struct cali_data cali_data[4];
-		 *      int  TimeStamp of Calibration (4 bytes)
-		 *      int CRC (4 bytes)
+		 *     struct cali_data cali_data[4];
+		 *     int  TimeStamp of Calibration (4 bytes)
+		 *     int CRC (4 bytes)
 		 * } ueft;
 		 */
 		crc = crc32(~0, data, 84) ^ ~0;
-		if (crc == tmp_val[21]) {
-			for (int i = 0; i < CALIB_MAX; i++)
-				tas_priv->cali_data[i] =
-					tmp_val[tas_priv->index * 5 + i];
-			tas_priv->apply_calibration(tas_priv);
+		if (crc != tmp_val[21]) {
+			cali_data->total_sz = 0;
+			dev_err(tas_priv->dev, "%s: V1 CRC error\n", __func__);
+			return;
+		}
+
+		for (j = tas_priv->ndev - 1; j >= 0; j--) {
+			l = j * (cali_data->cali_dat_sz_per_dev + 1);
+			for (i = TASDEV_CALIB_N * 4; i > 0 ; i--)
+				data[l + i] = data[tas_priv->index * 5 + i];
+			data[l+i] = j;
+		}
+	}
+
+	if (tas_priv->dspbin_typ == TASDEV_BASIC) {
+		r->r0_reg = cali_reg[0];
+		r->invr0_reg = cali_reg[1];
+		r->r0_low_reg = cali_reg[2];
+		r->pow_reg = cali_reg[3];
+		r->tlimit_reg = cali_reg[4];
+	}
+
+	tas_priv->is_user_space_calidata = true;
+	cali_data->total_sz =
+		tas_priv->ndev * (cali_data->cali_dat_sz_per_dev + 1);
+}
+
+/*
+ * Update the calibration data, including speaker impedance, f0, etc,
+ * into algo. Calibrate data is done by manufacturer in the factory.
+ * These data are used by Algo for calculating the speaker temperature,
+ * speaker membrane excursion and f0 in real time during playback.
+ * Calibration data format in EFI is V2, since 2024.
+ */
+static int tas2781_save_calibration(struct tasdevice_priv *tas_priv)
+{
+	/*
+	 * GUID was used for data access in BIOS, it was provided by board
+	 * manufactory, like HP: "{02f9af02-7734-4233-b43d-93fe5aa35db3}"
+	 */
+	efi_guid_t efi_guid =
+		EFI_GUID(0x02f9af02, 0x7734, 0x4233,
+			 0xb4, 0x3d, 0x93, 0xfe, 0x5a, 0xa3, 0x5d, 0xb3);
+	static efi_char16_t efi_name[] = TASDEVICE_CALIBRATION_DATA_NAME;
+	struct calidata *cali_data = &tas_priv->cali_data;
+	unsigned long total_sz = 0;
+	unsigned int attr, size;
+	efi_status_t status;
+	unsigned char *data;
+
+	cali_data->cali_dat_sz_per_dev = 20;
+	size = tas_priv->ndev * (cali_data->cali_dat_sz_per_dev + 1);
+	status = efi.get_variable(efi_name, &efi_guid, &attr, &total_sz, NULL);
+	cali_data->total_sz = total_sz > size ? total_sz : size;
+	if (status == EFI_BUFFER_TOO_SMALL) {
+		/* Allocate data buffer of data_size bytes */
+		data = tas_priv->cali_data.data = devm_kzalloc(tas_priv->dev,
+			tas_priv->cali_data.total_sz, GFP_KERNEL);
+		if (!data) {
+			tas_priv->cali_data.total_sz = 0;
+			return -ENOMEM;
 		}
+		/* Get variable contents into buffer */
+		status = efi.get_variable(efi_name, &efi_guid, &attr,
+			&tas_priv->cali_data.total_sz, data);
+	}
+	if (status != EFI_SUCCESS) {
+		tas_priv->cali_data.total_sz = 0;
+		return status;
 	}
 
+	tas_priv->apply_calibration(tas_priv);
 	return 0;
 }
 
@@ -883,7 +876,7 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 	pm_runtime_get_sync(tas_priv->dev);
 	guard(mutex)(&tas_priv->codec_lock);
 
-	ret = tasdevice_spi_rca_parser(tas_priv, fmw);
+	ret = tasdevice_rca_parser(tas_priv, fmw);
 	if (ret)
 		goto out;
 
@@ -910,12 +903,12 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 		}
 	}
 
-	tasdevice_spi_dsp_remove(tas_priv);
+	tasdevice_dsp_remove(tas_priv);
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_PENDING;
 	scnprintf(tas_priv->coef_binaryname, 64, "TAS2XXX%08X-%01d.bin",
 		codec->core.subsystem_id, tas_priv->index);
-	ret = tasdevice_spi_dsp_parser(tas_priv);
+	ret = tasdevice_dsp_parser(tas_priv);
 	if (ret) {
 		dev_err(tas_priv->dev, "dspfw load %s error\n",
 			tas_priv->coef_binaryname);
@@ -945,26 +938,27 @@ static void tasdev_fw_ready(const struct firmware *fmw, void *context)
 		goto out;
 	}
 
-	/* Perform AMP reset before firmware download. */
-	tas_priv->rcabin.profile_cfg_id = TAS2781_PRE_POST_RESET_CFG;
 	tas2781_spi_reset(tas_priv);
 	tas_priv->rcabin.profile_cfg_id = 0;
 
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
-	ret = tasdevice_spi_dev_read(tas_priv, TAS2781_REG_CLK_CONFIG, &val);
+	ret = tas_priv->dev_read(tas_priv, tas_priv->index,
+		TAS2781_REG_CLK_CONFIG, &val);
 	if (ret < 0)
 		goto out;
 
-	if (val == TAS2781_REG_CLK_CONFIG_RESET)
-		ret = tasdevice_spi_prmg_load(tas_priv, 0);
-	if (ret < 0) {
-		dev_err(tas_priv->dev, "FW download failed = %d\n", ret);
-		goto out;
+	if (val == TAS2781_REG_CLK_CONFIG_RESET) {
+		ret = tasdevice_prmg_load(tas_priv, 0);
+		if (ret < 0) {
+			dev_err(tas_priv->dev, "FW download failed = %d\n",
+				ret);
+			goto out;
+		}
 	}
 	if (tas_priv->fmw->nr_programs > 0)
-		tas_priv->cur_prog = 0;
+		tas_priv->tasdevice[tas_priv->index].cur_prog = 0;
 	if (tas_priv->fmw->nr_configurations > 0)
-		tas_priv->cur_conf = 0;
+		tas_priv->tasdevice[tas_priv->index].cur_conf = 0;
 
 	/*
 	 * If calibrated data occurs error, dsp will still works with default
@@ -1017,9 +1011,10 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
 	struct hda_component_parent *parent = master_data;
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 	struct hda_component *comp;
 
-	comp = hda_component_from_index(parent, tas_hda->priv->index);
+	comp = hda_component_from_index(parent, tas_priv->index);
 	if (comp && (comp->dev == dev)) {
 		comp->dev = NULL;
 		memset(comp->name, 0, sizeof(comp->name));
@@ -1028,8 +1023,8 @@ static void tas2781_hda_unbind(struct device *dev, struct device *master,
 
 	tas2781_hda_remove_controls(tas_hda);
 
-	tasdevice_spi_config_info_remove(tas_hda->priv);
-	tasdevice_spi_dsp_remove(tas_hda->priv);
+	tasdevice_config_info_remove(tas_priv);
+	tasdevice_dsp_remove(tas_priv);
 
 	tas_hda->priv->fw_state = TASDEVICE_DSP_FW_PENDING;
 }
@@ -1124,14 +1119,16 @@ static void tas2781_hda_spi_remove(struct spi_device *spi)
 static int tas2781_runtime_suspend(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 
-	guard(mutex)(&tas_hda->priv->codec_lock);
+	guard(mutex)(&tas_priv->codec_lock);
 
-	if (tas_hda->priv->playback_started)
-		tasdevice_spi_tuning_switch(tas_hda->priv, 1);
+	if (tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK
+		&& tas_priv->playback_started)
+		tasdevice_tuning_switch(tas_priv, 1);
 
-	tas_hda->priv->cur_book = -1;
-	tas_hda->priv->cur_conf = -1;
+	tas_priv->tasdevice[tas_priv->index].cur_book = -1;
+	tas_priv->tasdevice[tas_priv->index].cur_conf = -1;
 
 	return 0;
 }
@@ -1139,11 +1136,13 @@ static int tas2781_runtime_suspend(struct device *dev)
 static int tas2781_runtime_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 
-	guard(mutex)(&tas_hda->priv->codec_lock);
+	guard(mutex)(&tas_priv->codec_lock);
 
-	if (tas_hda->priv->playback_started)
-		tasdevice_spi_tuning_switch(tas_hda->priv, 0);
+	if (tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK
+		&& tas_priv->playback_started)
+		tasdevice_tuning_switch(tas_priv, 0);
 
 	return 0;
 }
@@ -1151,6 +1150,7 @@ static int tas2781_runtime_resume(struct device *dev)
 static int tas2781_system_suspend(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 	int ret;
 
 	ret = pm_runtime_force_suspend(dev);
@@ -1158,8 +1158,9 @@ static int tas2781_system_suspend(struct device *dev)
 		return ret;
 
 	/* Shutdown chip before system suspend */
-	if (tas_hda->priv->playback_started)
-		tasdevice_spi_tuning_switch(tas_hda->priv, 1);
+	if (tas_priv->fw_state == TASDEVICE_DSP_FW_ALL_OK
+		&& tas_priv->playback_started)
+		tasdevice_tuning_switch(tas_priv, 1);
 
 	return 0;
 }
@@ -1167,32 +1168,34 @@ static int tas2781_system_suspend(struct device *dev)
 static int tas2781_system_resume(struct device *dev)
 {
 	struct tas2781_hda *tas_hda = dev_get_drvdata(dev);
+	struct tasdevice_priv *tas_priv = tas_hda->priv;
 	int ret, val;
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
 		return ret;
 
-	guard(mutex)(&tas_hda->priv->codec_lock);
-	ret = tasdevice_spi_dev_read(tas_hda->priv, TAS2781_REG_CLK_CONFIG,
-				     &val);
+	guard(mutex)(&tas_priv->codec_lock);
+	ret = tas_priv->dev_read(tas_priv, tas_priv->index,
+		TAS2781_REG_CLK_CONFIG, &val);
 	if (ret < 0)
 		return ret;
 
 	if (val == TAS2781_REG_CLK_CONFIG_RESET) {
-		tas_hda->priv->cur_book = -1;
-		tas_hda->priv->cur_conf = -1;
-		tas_hda->priv->cur_prog = -1;
+		tas_priv->tasdevice[tas_priv->index].cur_book = -1;
+		tas_priv->tasdevice[tas_priv->index].cur_conf = -1;
+		tas_priv->tasdevice[tas_priv->index].cur_prog = -1;
 
-		ret = tasdevice_spi_prmg_load(tas_hda->priv, 0);
+		ret = tasdevice_prmg_load(tas_priv, 0);
 		if (ret < 0) {
-			dev_err(tas_hda->priv->dev,
+			dev_err(tas_priv->dev,
 				"FW download failed = %d\n", ret);
 			return ret;
 		}
+		tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
-		if (tas_hda->priv->playback_started)
-			tasdevice_spi_tuning_switch(tas_hda->priv, 0);
+		if (tas_priv->playback_started)
+			tasdevice_tuning_switch(tas_priv, 0);
 	}
 
 	return ret;
@@ -1229,3 +1232,4 @@ module_spi_driver(tas2781_hda_spi_driver);
 MODULE_DESCRIPTION("TAS2781 HDA SPI Driver");
 MODULE_AUTHOR("Baojun, Xu, <baojun.xug@ti.com>");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("SND_SOC_TAS2781_FMWLIB");
diff --git a/sound/pci/hda/tas2781_spi_fwlib.c b/sound/pci/hda/tas2781_spi_fwlib.c
deleted file mode 100644
index d90d022d8449..000000000000
--- a/sound/pci/hda/tas2781_spi_fwlib.c
+++ /dev/null
@@ -1,2006 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-//
-// TAS2781 HDA SPI driver
-//
-// Copyright 2024 - 2025 Texas Instruments, Inc.
-//
-// Author: Baojun Xu <baojun.xu@ti.com>
-
-#include <linux/crc8.h>
-#include <linux/firmware.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include <linux/unaligned.h>
-#include <sound/pcm_params.h>
-#include <sound/soc.h>
-#include <sound/tas2781-dsp.h>
-#include <sound/tlv.h>
-
-#include "tas2781-spi.h"
-
-#define OFFSET_ERROR_BIT			BIT(31)
-
-#define ERROR_PRAM_CRCCHK			0x0000000
-#define ERROR_YRAM_CRCCHK			0x0000001
-#define PPC_DRIVER_CRCCHK			0x00000200
-
-#define TAS2781_SA_COEFF_SWAP_REG		TASDEVICE_REG(0, 0x35, 0x2c)
-#define TAS2781_YRAM_BOOK1			140
-#define TAS2781_YRAM1_PAGE			42
-#define TAS2781_YRAM1_START_REG			88
-
-#define TAS2781_YRAM2_START_PAGE		43
-#define TAS2781_YRAM2_END_PAGE			49
-#define TAS2781_YRAM2_START_REG			8
-#define TAS2781_YRAM2_END_REG			127
-
-#define TAS2781_YRAM3_PAGE			50
-#define TAS2781_YRAM3_START_REG			8
-#define TAS2781_YRAM3_END_REG			27
-
-/* should not include B0_P53_R44-R47 */
-#define TAS2781_YRAM_BOOK2			0
-#define TAS2781_YRAM4_START_PAGE		50
-#define TAS2781_YRAM4_END_PAGE			60
-
-#define TAS2781_YRAM5_PAGE			61
-#define TAS2781_YRAM5_START_REG			TAS2781_YRAM3_START_REG
-#define TAS2781_YRAM5_END_REG			TAS2781_YRAM3_END_REG
-
-#define TASDEVICE_MAXPROGRAM_NUM_KERNEL			5
-#define TASDEVICE_MAXCONFIG_NUM_KERNEL_MULTIPLE_AMPS	64
-#define TASDEVICE_MAXCONFIG_NUM_KERNEL			10
-#define MAIN_ALL_DEVICES_1X				0x01
-#define MAIN_DEVICE_A_1X				0x02
-#define MAIN_DEVICE_B_1X				0x03
-#define MAIN_DEVICE_C_1X				0x04
-#define MAIN_DEVICE_D_1X				0x05
-#define COEFF_DEVICE_A_1X				0x12
-#define COEFF_DEVICE_B_1X				0x13
-#define COEFF_DEVICE_C_1X				0x14
-#define COEFF_DEVICE_D_1X				0x15
-#define PRE_DEVICE_A_1X					0x22
-#define PRE_DEVICE_B_1X					0x23
-#define PRE_DEVICE_C_1X					0x24
-#define PRE_DEVICE_D_1X					0x25
-#define PRE_SOFTWARE_RESET_DEVICE_A			0x41
-#define PRE_SOFTWARE_RESET_DEVICE_B			0x42
-#define PRE_SOFTWARE_RESET_DEVICE_C			0x43
-#define PRE_SOFTWARE_RESET_DEVICE_D			0x44
-#define POST_SOFTWARE_RESET_DEVICE_A			0x45
-#define POST_SOFTWARE_RESET_DEVICE_B			0x46
-#define POST_SOFTWARE_RESET_DEVICE_C			0x47
-#define POST_SOFTWARE_RESET_DEVICE_D			0x48
-
-struct tas_crc {
-	unsigned char offset;
-	unsigned char len;
-};
-
-struct blktyp_devidx_map {
-	unsigned char blktyp;
-	unsigned char dev_idx;
-};
-
-/* fixed m68k compiling issue: mapping table can save code field */
-static const struct blktyp_devidx_map ppc3_tas2781_mapping_table[] = {
-	{ MAIN_ALL_DEVICES_1X, 0x80 },
-	{ MAIN_DEVICE_A_1X, 0x81 },
-	{ COEFF_DEVICE_A_1X, 0x81 },
-	{ PRE_DEVICE_A_1X, 0x81 },
-	{ PRE_SOFTWARE_RESET_DEVICE_A, 0xC1 },
-	{ POST_SOFTWARE_RESET_DEVICE_A, 0xC1 },
-	{ MAIN_DEVICE_B_1X, 0x82 },
-	{ COEFF_DEVICE_B_1X, 0x82 },
-	{ PRE_DEVICE_B_1X, 0x82 },
-	{ PRE_SOFTWARE_RESET_DEVICE_B, 0xC2 },
-	{ POST_SOFTWARE_RESET_DEVICE_B, 0xC2 },
-	{ MAIN_DEVICE_C_1X, 0x83 },
-	{ COEFF_DEVICE_C_1X, 0x83 },
-	{ PRE_DEVICE_C_1X, 0x83 },
-	{ PRE_SOFTWARE_RESET_DEVICE_C, 0xC3 },
-	{ POST_SOFTWARE_RESET_DEVICE_C, 0xC3 },
-	{ MAIN_DEVICE_D_1X, 0x84 },
-	{ COEFF_DEVICE_D_1X, 0x84 },
-	{ PRE_DEVICE_D_1X, 0x84 },
-	{ PRE_SOFTWARE_RESET_DEVICE_D, 0xC4 },
-	{ POST_SOFTWARE_RESET_DEVICE_D, 0xC4 },
-};
-
-static const struct blktyp_devidx_map ppc3_mapping_table[] = {
-	{ MAIN_ALL_DEVICES_1X, 0x80 },
-	{ MAIN_DEVICE_A_1X, 0x81 },
-	{ COEFF_DEVICE_A_1X, 0xC1 },
-	{ PRE_DEVICE_A_1X, 0xC1 },
-	{ MAIN_DEVICE_B_1X, 0x82 },
-	{ COEFF_DEVICE_B_1X, 0xC2 },
-	{ PRE_DEVICE_B_1X, 0xC2 },
-	{ MAIN_DEVICE_C_1X, 0x83 },
-	{ COEFF_DEVICE_C_1X, 0xC3 },
-	{ PRE_DEVICE_C_1X, 0xC3 },
-	{ MAIN_DEVICE_D_1X, 0x84 },
-	{ COEFF_DEVICE_D_1X, 0xC4 },
-	{ PRE_DEVICE_D_1X, 0xC4 },
-};
-
-static const struct blktyp_devidx_map non_ppc3_mapping_table[] = {
-	{ MAIN_ALL_DEVICES, 0x80 },
-	{ MAIN_DEVICE_A, 0x81 },
-	{ COEFF_DEVICE_A, 0xC1 },
-	{ PRE_DEVICE_A, 0xC1 },
-	{ MAIN_DEVICE_B, 0x82 },
-	{ COEFF_DEVICE_B, 0xC2 },
-	{ PRE_DEVICE_B, 0xC2 },
-	{ MAIN_DEVICE_C, 0x83 },
-	{ COEFF_DEVICE_C, 0xC3 },
-	{ PRE_DEVICE_C, 0xC3 },
-	{ MAIN_DEVICE_D, 0x84 },
-	{ COEFF_DEVICE_D, 0xC4 },
-	{ PRE_DEVICE_D, 0xC4 },
-};
-
-/*
- * Device support different configurations for different scene,
- * like voice, music, calibration, was write in regbin file.
- * Will be stored into tas_priv after regbin was loaded.
- */
-static struct tasdevice_config_info *tasdevice_add_config(
-	struct tasdevice_priv *tas_priv, unsigned char *config_data,
-	unsigned int config_size, int *status)
-{
-	struct tasdevice_config_info *cfg_info;
-	struct tasdev_blk_data **bk_da;
-	unsigned int config_offset = 0;
-	unsigned int i;
-
-	/*
-	 * In most projects are many audio cases, such as music, handfree,
-	 * receiver, games, audio-to-haptics, PMIC record, bypass mode,
-	 * portrait, landscape, etc. Even in multiple audios, one or
-	 * two of the chips will work for the special case, such as
-	 * ultrasonic application. In order to support these variable-numbers
-	 * of audio cases, flexible configs have been introduced in the
-	 * DSP firmware.
-	 */
-	cfg_info = kzalloc(sizeof(*cfg_info), GFP_KERNEL);
-	if (!cfg_info) {
-		*status = -ENOMEM;
-		return NULL;
-	}
-
-	if (tas_priv->rcabin.fw_hdr.binary_version_num >= 0x105) {
-		if ((config_offset + 64) > config_size) {
-			*status = -EINVAL;
-			dev_err(tas_priv->dev, "add conf: Out of boundary\n");
-			goto config_err;
-		}
-		config_offset += 64;
-	}
-
-	if ((config_offset + 4) > config_size) {
-		*status = -EINVAL;
-		dev_err(tas_priv->dev, "add config: Out of boundary\n");
-		goto config_err;
-	}
-
-	/*
-	 * convert data[offset], data[offset + 1], data[offset + 2] and
-	 * data[offset + 3] into host
-	 */
-	cfg_info->nblocks = get_unaligned_be32(&config_data[config_offset]);
-	config_offset += 4;
-
-	/*
-	 * Several kinds of dsp/algorithm firmwares can run on tas2781,
-	 * the number and size of blk are not fixed and different among
-	 * these firmwares.
-	 */
-	bk_da = cfg_info->blk_data = kcalloc(cfg_info->nblocks,
-		sizeof(*bk_da), GFP_KERNEL);
-	if (!bk_da) {
-		*status = -ENOMEM;
-		goto config_err;
-	}
-	cfg_info->real_nblocks = 0;
-	for (i = 0; i < cfg_info->nblocks; i++) {
-		if (config_offset + 12 > config_size) {
-			*status = -EINVAL;
-			dev_err(tas_priv->dev,
-				"%s: Out of boundary: i = %d nblocks = %u!\n",
-				__func__, i, cfg_info->nblocks);
-			goto block_err;
-		}
-		bk_da[i] = kzalloc(sizeof(*bk_da[i]), GFP_KERNEL);
-		if (!bk_da[i]) {
-			*status = -ENOMEM;
-			goto block_err;
-		}
-
-		bk_da[i]->dev_idx = config_data[config_offset];
-		config_offset++;
-
-		bk_da[i]->block_type = config_data[config_offset];
-		config_offset++;
-
-		bk_da[i]->yram_checksum =
-			get_unaligned_be16(&config_data[config_offset]);
-		config_offset += 2;
-		bk_da[i]->block_size =
-			get_unaligned_be32(&config_data[config_offset]);
-		config_offset += 4;
-
-		bk_da[i]->n_subblks =
-			get_unaligned_be32(&config_data[config_offset]);
-
-		config_offset += 4;
-
-		if (config_offset + bk_da[i]->block_size > config_size) {
-			*status = -EINVAL;
-			dev_err(tas_priv->dev,
-				"%s: Out of boundary: i = %d blks = %u!\n",
-				__func__, i, cfg_info->nblocks);
-			goto block_err;
-		}
-		/* instead of kzalloc+memcpy */
-		bk_da[i]->regdata = kmemdup(&config_data[config_offset],
-			bk_da[i]->block_size, GFP_KERNEL);
-		if (!bk_da[i]->regdata) {
-			*status = -ENOMEM;
-			i++;
-			goto block_err;
-		}
-
-		config_offset += bk_da[i]->block_size;
-		cfg_info->real_nblocks += 1;
-	}
-
-	return cfg_info;
-block_err:
-	for (int j = 0; j < i; j++)
-		kfree(bk_da[j]);
-	kfree(bk_da);
-config_err:
-	kfree(cfg_info);
-	return NULL;
-}
-
-/* Regbin file parser function. */
-int tasdevice_spi_rca_parser(void *context, const struct firmware *fmw)
-{
-	struct tasdevice_priv *tas_priv = context;
-	struct tasdevice_config_info **cfg_info;
-	struct tasdevice_rca_hdr *fw_hdr;
-	struct tasdevice_rca *rca;
-	unsigned int total_config_sz = 0;
-	int offset = 0, ret = 0, i;
-	unsigned char *buf;
-
-	rca = &tas_priv->rcabin;
-	fw_hdr = &rca->fw_hdr;
-	if (!fmw || !fmw->data) {
-		dev_err(tas_priv->dev, "Failed to read %s\n",
-			tas_priv->rca_binaryname);
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -EINVAL;
-	}
-	buf = (unsigned char *)fmw->data;
-	fw_hdr->img_sz = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-	if (fw_hdr->img_sz != fmw->size) {
-		dev_err(tas_priv->dev,
-			"File size not match, %d %u", (int)fmw->size,
-			fw_hdr->img_sz);
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -EINVAL;
-	}
-
-	fw_hdr->checksum = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-	fw_hdr->binary_version_num = get_unaligned_be32(&buf[offset]);
-	if (fw_hdr->binary_version_num < 0x103) {
-		dev_err(tas_priv->dev, "File version 0x%04x is too low",
-			fw_hdr->binary_version_num);
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -EINVAL;
-	}
-	offset += 4;
-	fw_hdr->drv_fw_version = get_unaligned_be32(&buf[offset]);
-	offset += 8;
-	fw_hdr->plat_type = buf[offset++];
-	fw_hdr->dev_family = buf[offset++];
-	fw_hdr->reserve = buf[offset++];
-	fw_hdr->ndev = buf[offset++];
-	if (offset + TASDEVICE_DEVICE_SUM > fw_hdr->img_sz) {
-		dev_err(tas_priv->dev, "rca_ready: Out of boundary!\n");
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -EINVAL;
-	}
-
-	for (i = 0; i < TASDEVICE_DEVICE_SUM; i++, offset++)
-		fw_hdr->devs[i] = buf[offset];
-
-	fw_hdr->nconfig = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-
-	for (i = 0; i < TASDEVICE_CONFIG_SUM; i++) {
-		fw_hdr->config_size[i] = get_unaligned_be32(&buf[offset]);
-		offset += 4;
-		total_config_sz += fw_hdr->config_size[i];
-	}
-
-	if (fw_hdr->img_sz - total_config_sz != (unsigned int)offset) {
-		dev_err(tas_priv->dev, "Bin file err %d - %d != %d!\n",
-			fw_hdr->img_sz, total_config_sz, (int)offset);
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -EINVAL;
-	}
-
-	cfg_info = kcalloc(fw_hdr->nconfig, sizeof(*cfg_info), GFP_KERNEL);
-	if (!cfg_info) {
-		tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-		return -ENOMEM;
-	}
-	rca->cfg_info = cfg_info;
-	rca->ncfgs = 0;
-	for (i = 0; i < (int)fw_hdr->nconfig; i++) {
-		rca->ncfgs += 1;
-		cfg_info[i] = tasdevice_add_config(tas_priv, &buf[offset],
-			fw_hdr->config_size[i], &ret);
-		if (ret) {
-			tas_priv->fw_state = TASDEVICE_DSP_FW_FAIL;
-			return ret;
-		}
-		offset += (int)fw_hdr->config_size[i];
-	}
-
-	return ret;
-}
-
-/* fixed m68k compiling issue: mapping table can save code field */
-static unsigned char map_dev_idx(struct tasdevice_fw *tas_fmw,
-	struct tasdev_blk *block)
-{
-	struct blktyp_devidx_map *p =
-		(struct blktyp_devidx_map *)non_ppc3_mapping_table;
-	struct tasdevice_dspfw_hdr *fw_hdr = &tas_fmw->fw_hdr;
-	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &fw_hdr->fixed_hdr;
-	int i, n = ARRAY_SIZE(non_ppc3_mapping_table);
-	unsigned char dev_idx = 0;
-
-	if (fw_fixed_hdr->ppcver >= PPC3_VERSION_TAS2781_BASIC_MIN) {
-		p = (struct blktyp_devidx_map *)ppc3_tas2781_mapping_table;
-		n = ARRAY_SIZE(ppc3_tas2781_mapping_table);
-	} else if (fw_fixed_hdr->ppcver >= PPC3_VERSION_BASE) {
-		p = (struct blktyp_devidx_map *)ppc3_mapping_table;
-		n = ARRAY_SIZE(ppc3_mapping_table);
-	}
-
-	for (i = 0; i < n; i++) {
-		if (block->type == p[i].blktyp) {
-			dev_idx = p[i].dev_idx;
-			break;
-		}
-	}
-
-	return dev_idx;
-}
-
-/* Block parser function. */
-static int fw_parse_block_data_kernel(struct tasdevice_fw *tas_fmw,
-	struct tasdev_blk *block, const struct firmware *fmw, int offset)
-{
-	const unsigned char *data = fmw->data;
-
-	if (offset + 16 > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-
-	/*
-	 * Convert data[offset], data[offset + 1], data[offset + 2] and
-	 * data[offset + 3] into host.
-	 */
-	block->type = get_unaligned_be32(&data[offset]);
-	offset += 4;
-
-	block->is_pchksum_present = data[offset++];
-	block->pchksum = data[offset++];
-	block->is_ychksum_present = data[offset++];
-	block->ychksum = data[offset++];
-	block->blk_size = get_unaligned_be32(&data[offset]);
-	offset += 4;
-	block->nr_subblocks = get_unaligned_be32(&data[offset]);
-	offset += 4;
-
-	/*
-	 * Fixed m68k compiling issue:
-	 * 1. mapping table can save code field.
-	 * 2. storing the dev_idx as a member of block can reduce unnecessary
-	 *    time and system resource comsumption of dev_idx mapping every
-	 *    time the block data writing to the dsp.
-	 */
-	block->dev_idx = map_dev_idx(tas_fmw, block);
-
-	if (offset + block->blk_size > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: nSublocks error\n", __func__);
-		return -EINVAL;
-	}
-	/* instead of kzalloc+memcpy */
-	block->data = kmemdup(&data[offset], block->blk_size, GFP_KERNEL);
-	if (!block->data)
-		return -ENOMEM;
-
-	offset += block->blk_size;
-
-	return offset;
-}
-
-/* Data of block parser function. */
-static int fw_parse_data_kernel(struct tasdevice_fw *tas_fmw,
-	struct tasdevice_data *img_data, const struct firmware *fmw,
-	int offset)
-{
-	const unsigned char *data = fmw->data;
-	struct tasdev_blk *blk;
-	unsigned int i;
-
-	if (offset + 4 > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-	img_data->nr_blk = get_unaligned_be32(&data[offset]);
-	offset += 4;
-
-	img_data->dev_blks = kcalloc(img_data->nr_blk,
-		sizeof(struct tasdev_blk), GFP_KERNEL);
-	if (!img_data->dev_blks)
-		return -ENOMEM;
-
-	for (i = 0; i < img_data->nr_blk; i++) {
-		blk = &img_data->dev_blks[i];
-		offset = fw_parse_block_data_kernel(
-			tas_fmw, blk, fmw, offset);
-		if (offset < 0) {
-			kfree(img_data->dev_blks);
-			return -EINVAL;
-		}
-	}
-
-	return offset;
-}
-
-/* Data of DSP program parser function. */
-static int fw_parse_program_data_kernel(
-	struct tasdevice_priv *tas_priv, struct tasdevice_fw *tas_fmw,
-	const struct firmware *fmw, int offset)
-{
-	struct tasdevice_prog *program;
-	unsigned int i;
-
-	for (i = 0; i < tas_fmw->nr_programs; i++) {
-		program = &tas_fmw->programs[i];
-		if (offset + 72 > fmw->size) {
-			dev_err(tas_priv->dev, "%s: mpName error\n", __func__);
-			return -EINVAL;
-		}
-		/* skip 72 unused byts */
-		offset += 72;
-
-		offset = fw_parse_data_kernel(tas_fmw, &program->dev_data,
-			fmw, offset);
-		if (offset < 0)
-			break;
-	}
-
-	return offset;
-}
-
-/* Data of DSP configurations parser function. */
-static int fw_parse_configuration_data_kernel(struct tasdevice_priv *tas_priv,
-	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
-{
-	const unsigned char *data = fmw->data;
-	struct tasdevice_config *config;
-	unsigned int i;
-
-	for (i = 0; i < tas_fmw->nr_configurations; i++) {
-		config = &tas_fmw->configs[i];
-		if (offset + 80 > fmw->size) {
-			dev_err(tas_priv->dev, "%s: mpName error\n", __func__);
-			return -EINVAL;
-		}
-		memcpy(config->name, &data[offset], 64);
-		/* skip extra 16 bytes */
-		offset += 80;
-
-		offset = fw_parse_data_kernel(tas_fmw, &config->dev_data,
-			fmw, offset);
-		if (offset < 0)
-			break;
-	}
-
-	return offset;
-}
-
-/* DSP firmware file header parser function for early PPC3 firmware binary. */
-static int fw_parse_variable_header_kernel(struct tasdevice_priv *tas_priv,
-	const struct firmware *fmw, int offset)
-{
-	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
-	struct tasdevice_dspfw_hdr *fw_hdr = &tas_fmw->fw_hdr;
-	struct tasdevice_config *config;
-	struct tasdevice_prog *program;
-	const unsigned char *buf = fmw->data;
-	unsigned short max_confs;
-	unsigned int i;
-
-	if (offset + 12 + 4 * TASDEVICE_MAXPROGRAM_NUM_KERNEL > fmw->size) {
-		dev_err(tas_priv->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-	fw_hdr->device_family = get_unaligned_be16(&buf[offset]);
-	if (fw_hdr->device_family != 0) {
-		dev_err(tas_priv->dev, "%s:not TAS device\n", __func__);
-		return -EINVAL;
-	}
-	offset += 2;
-	fw_hdr->device = get_unaligned_be16(&buf[offset]);
-	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
-	    fw_hdr->device == 6) {
-		dev_err(tas_priv->dev, "Unsupported dev %d\n", fw_hdr->device);
-		return -EINVAL;
-	}
-	offset += 2;
-
-	tas_fmw->nr_programs = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-
-	if (tas_fmw->nr_programs == 0 ||
-	    tas_fmw->nr_programs > TASDEVICE_MAXPROGRAM_NUM_KERNEL) {
-		dev_err(tas_priv->dev, "mnPrograms is invalid\n");
-		return -EINVAL;
-	}
-
-	tas_fmw->programs = kcalloc(tas_fmw->nr_programs,
-		sizeof(*tas_fmw->programs), GFP_KERNEL);
-	if (!tas_fmw->programs)
-		return -ENOMEM;
-
-	for (i = 0; i < tas_fmw->nr_programs; i++) {
-		program = &tas_fmw->programs[i];
-		program->prog_size = get_unaligned_be32(&buf[offset]);
-		offset += 4;
-	}
-
-	/* Skip the unused prog_size */
-	offset += 4 * (TASDEVICE_MAXPROGRAM_NUM_KERNEL - tas_fmw->nr_programs);
-
-	tas_fmw->nr_configurations = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-
-	/*
-	 * The max number of config in firmware greater than 4 pieces of
-	 * tas2781s is different from the one lower than 4 pieces of
-	 * tas2781s.
-	 */
-	max_confs = TASDEVICE_MAXCONFIG_NUM_KERNEL;
-	if (tas_fmw->nr_configurations == 0 ||
-	    tas_fmw->nr_configurations > max_confs) {
-		dev_err(tas_priv->dev, "%s: Conf is invalid\n", __func__);
-		kfree(tas_fmw->programs);
-		return -EINVAL;
-	}
-
-	if (offset + 4 * max_confs > fmw->size) {
-		dev_err(tas_priv->dev, "%s: mpConfigurations err\n", __func__);
-		kfree(tas_fmw->programs);
-		return -EINVAL;
-	}
-
-	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
-		sizeof(*tas_fmw->configs), GFP_KERNEL);
-	if (!tas_fmw->configs) {
-		kfree(tas_fmw->programs);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < tas_fmw->nr_programs; i++) {
-		config = &tas_fmw->configs[i];
-		config->cfg_size = get_unaligned_be32(&buf[offset]);
-		offset += 4;
-	}
-
-	/* Skip the unused configs */
-	offset += 4 * (max_confs - tas_fmw->nr_programs);
-
-	return offset;
-}
-
-/*
- * In sub-block data, have three type sub-block:
- * 1. Single byte write.
- * 2. Multi-byte write.
- * 3. Delay.
- * 4. Bits update.
- * This function perform single byte write to device.
- */
-static int tasdevice_single_byte_wr(void *context, int dev_idx,
-				    unsigned char *data, int sublocksize)
-{
-	struct tasdevice_priv *tas_priv = context;
-	unsigned short len = get_unaligned_be16(&data[2]);
-	int i, subblk_offset, rc;
-
-	subblk_offset = 4;
-	if (subblk_offset + 4 * len > sublocksize) {
-		dev_err(tas_priv->dev, "process_block: Out of boundary\n");
-		return 0;
-	}
-
-	for (i = 0; i < len; i++) {
-		if (dev_idx == (tas_priv->index + 1) || dev_idx == 0) {
-			rc = tasdevice_spi_dev_write(tas_priv,
-				TASDEVICE_REG(data[subblk_offset],
-				data[subblk_offset + 1],
-				data[subblk_offset + 2]),
-				data[subblk_offset + 3]);
-			if (rc < 0) {
-				dev_err(tas_priv->dev,
-					"process_block: single write error\n");
-				subblk_offset |= OFFSET_ERROR_BIT;
-			}
-		}
-		subblk_offset += 4;
-	}
-
-	return subblk_offset;
-}
-
-/*
- * In sub-block data, have three type sub-block:
- * 1. Single byte write.
- * 2. Multi-byte write.
- * 3. Delay.
- * 4. Bits update.
- * This function perform multi-write to device.
- */
-static int tasdevice_burst_wr(void *context, int dev_idx, unsigned char *data,
-	int sublocksize)
-{
-	struct tasdevice_priv *tas_priv = context;
-	unsigned short len = get_unaligned_be16(&data[2]);
-	int subblk_offset, rc;
-
-	subblk_offset = 4;
-	if (subblk_offset + 4 + len > sublocksize) {
-		dev_err(tas_priv->dev, "%s: BST Out of boundary\n", __func__);
-		subblk_offset |= OFFSET_ERROR_BIT;
-	}
-	if (len % 4) {
-		dev_err(tas_priv->dev, "%s:Bst-len(%u)not div by 4\n",
-			__func__, len);
-		subblk_offset |= OFFSET_ERROR_BIT;
-	}
-
-	if (dev_idx == (tas_priv->index + 1) || dev_idx == 0) {
-		rc = tasdevice_spi_dev_bulk_write(tas_priv,
-			TASDEVICE_REG(data[subblk_offset],
-				      data[subblk_offset + 1],
-				      data[subblk_offset + 2]),
-				      &data[subblk_offset + 4], len);
-		if (rc < 0) {
-			dev_err(tas_priv->dev, "%s: bulk_write error = %d\n",
-				__func__, rc);
-			subblk_offset |= OFFSET_ERROR_BIT;
-		}
-	}
-	subblk_offset += (len + 4);
-
-	return subblk_offset;
-}
-
-/* Just delay for ms.*/
-static int tasdevice_delay(void *context, int dev_idx, unsigned char *data,
-	int sublocksize)
-{
-	struct tasdevice_priv *tas_priv = context;
-	unsigned int sleep_time, subblk_offset = 2;
-
-	if (subblk_offset + 2 > sublocksize) {
-		dev_err(tas_priv->dev, "%s: delay Out of boundary\n",
-			__func__);
-		subblk_offset |= OFFSET_ERROR_BIT;
-	}
-	if (dev_idx == (tas_priv->index + 1) || dev_idx == 0) {
-		sleep_time = get_unaligned_be16(&data[2]) * 1000;
-		fsleep(sleep_time);
-	}
-	subblk_offset += 2;
-
-	return subblk_offset;
-}
-
-/*
- * In sub-block data, have three type sub-block:
- * 1. Single byte write.
- * 2. Multi-byte write.
- * 3. Delay.
- * 4. Bits update.
- * This function perform bits update.
- */
-static int tasdevice_field_wr(void *context, int dev_idx, unsigned char *data,
-	int sublocksize)
-{
-	struct tasdevice_priv *tas_priv = context;
-	int rc, subblk_offset = 2;
-
-	if (subblk_offset + 6 > sublocksize) {
-		dev_err(tas_priv->dev, "%s: bit write Out of boundary\n",
-			__func__);
-		subblk_offset |= OFFSET_ERROR_BIT;
-	}
-	if (dev_idx == (tas_priv->index + 1) || dev_idx == 0) {
-		rc = tasdevice_spi_dev_update_bits(tas_priv,
-			TASDEVICE_REG(data[subblk_offset + 2],
-			data[subblk_offset + 3],
-			data[subblk_offset + 4]),
-			data[subblk_offset + 1],
-			data[subblk_offset + 5]);
-		if (rc < 0) {
-			dev_err(tas_priv->dev, "%s: update_bits error = %d\n",
-				__func__, rc);
-			subblk_offset |= OFFSET_ERROR_BIT;
-		}
-	}
-	subblk_offset += 6;
-
-	return subblk_offset;
-}
-
-/* Data block process function. */
-static int tasdevice_process_block(void *context, unsigned char *data,
-	unsigned char dev_idx, int sublocksize)
-{
-	struct tasdevice_priv *tas_priv = context;
-	int blktyp = dev_idx & 0xC0, subblk_offset;
-	unsigned char subblk_typ = data[1];
-
-	switch (subblk_typ) {
-	case TASDEVICE_CMD_SING_W:
-		subblk_offset = tasdevice_single_byte_wr(tas_priv,
-			dev_idx & 0x3f, data, sublocksize);
-		break;
-	case TASDEVICE_CMD_BURST:
-		subblk_offset = tasdevice_burst_wr(tas_priv,
-			dev_idx & 0x3f, data, sublocksize);
-		break;
-	case TASDEVICE_CMD_DELAY:
-		subblk_offset = tasdevice_delay(tas_priv,
-			dev_idx & 0x3f, data, sublocksize);
-		break;
-	case TASDEVICE_CMD_FIELD_W:
-		subblk_offset = tasdevice_field_wr(tas_priv,
-			dev_idx & 0x3f, data, sublocksize);
-		break;
-	default:
-		subblk_offset = 2;
-		break;
-	}
-	if (((subblk_offset & OFFSET_ERROR_BIT) != 0) && blktyp != 0) {
-		if (blktyp == 0x80) {
-			tas_priv->cur_prog = -1;
-			tas_priv->cur_conf = -1;
-		} else
-			tas_priv->cur_conf = -1;
-	}
-	subblk_offset &= ~OFFSET_ERROR_BIT;
-
-	return subblk_offset;
-}
-
-/*
- * Device support different configurations for different scene,
- * this function was used for choose different config.
- */
-void tasdevice_spi_select_cfg_blk(void *pContext, int conf_no,
-	unsigned char block_type)
-{
-	struct tasdevice_priv *tas_priv = pContext;
-	struct tasdevice_rca *rca = &tas_priv->rcabin;
-	struct tasdevice_config_info **cfg_info = rca->cfg_info;
-	struct tasdev_blk_data **blk_data;
-	unsigned int j, k;
-
-	if (conf_no >= rca->ncfgs || conf_no < 0 || !cfg_info) {
-		dev_err(tas_priv->dev, "conf_no should be not more than %u\n",
-			rca->ncfgs);
-		return;
-	}
-	blk_data = cfg_info[conf_no]->blk_data;
-
-	for (j = 0; j < cfg_info[conf_no]->real_nblocks; j++) {
-		unsigned int length = 0, rc = 0;
-
-		if (block_type > 5 || block_type < 2) {
-			dev_err(tas_priv->dev,
-				"block_type should be in range from 2 to 5\n");
-			break;
-		}
-		if (block_type != blk_data[j]->block_type)
-			continue;
-
-		for (k = 0; k < blk_data[j]->n_subblks; k++) {
-			tas_priv->is_loading = true;
-
-			rc = tasdevice_process_block(tas_priv,
-				blk_data[j]->regdata + length,
-				blk_data[j]->dev_idx,
-				blk_data[j]->block_size - length);
-			length += rc;
-			if (blk_data[j]->block_size < length) {
-				dev_err(tas_priv->dev,
-					"%s: %u %u out of boundary\n",
-					__func__, length,
-					blk_data[j]->block_size);
-				break;
-			}
-		}
-		if (length != blk_data[j]->block_size)
-			dev_err(tas_priv->dev, "%s: %u %u size is not same\n",
-				__func__, length, blk_data[j]->block_size);
-	}
-}
-
-/* Block process function. */
-static int tasdevice_load_block_kernel(
-	struct tasdevice_priv *tasdevice, struct tasdev_blk *block)
-{
-	const unsigned int blk_size = block->blk_size;
-	unsigned char *data = block->data;
-	unsigned int i, length;
-
-	for (i = 0, length = 0; i < block->nr_subblocks; i++) {
-		int rc = tasdevice_process_block(tasdevice, data + length,
-			block->dev_idx, blk_size - length);
-		if (rc < 0) {
-			dev_err(tasdevice->dev,
-				"%s: %u %u sublock write error\n",
-				__func__, length, blk_size);
-			return rc;
-		}
-		length += rc;
-		if (blk_size < length) {
-			dev_err(tasdevice->dev, "%s: %u %u out of boundary\n",
-				__func__, length, blk_size);
-			rc = -ENOMEM;
-			return rc;
-		}
-	}
-
-	return 0;
-}
-
-/* DSP firmware file header parser function. */
-static int fw_parse_variable_hdr(struct tasdevice_priv *tas_priv,
-	struct tasdevice_dspfw_hdr *fw_hdr,
-	const struct firmware *fmw, int offset)
-{
-	const unsigned char *buf = fmw->data;
-	int len = strlen((char *)&buf[offset]);
-
-	len++;
-
-	if (offset + len + 8 > fmw->size) {
-		dev_err(tas_priv->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-
-	offset += len;
-
-	fw_hdr->device_family = get_unaligned_be32(&buf[offset]);
-	if (fw_hdr->device_family != 0) {
-		dev_err(tas_priv->dev, "%s: not TAS device\n", __func__);
-		return -EINVAL;
-	}
-	offset += 4;
-
-	fw_hdr->device = get_unaligned_be32(&buf[offset]);
-	if (fw_hdr->device >= TASDEVICE_DSP_TAS_MAX_DEVICE ||
-	    fw_hdr->device == 6) {
-		dev_err(tas_priv->dev, "Unsupported dev %d\n", fw_hdr->device);
-		return -EINVAL;
-	}
-	offset += 4;
-	fw_hdr->ndev = 1;
-
-	return offset;
-}
-
-/* DSP firmware file header parser function for size variabled header. */
-static int fw_parse_variable_header_git(struct tasdevice_priv
-	*tas_priv, const struct firmware *fmw, int offset)
-{
-	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
-	struct tasdevice_dspfw_hdr *fw_hdr = &tas_fmw->fw_hdr;
-
-	offset = fw_parse_variable_hdr(tas_priv, fw_hdr, fmw, offset);
-
-	return offset;
-}
-
-/* DSP firmware file block parser function. */
-static int fw_parse_block_data(struct tasdevice_fw *tas_fmw,
-	struct tasdev_blk *block, const struct firmware *fmw, int offset)
-{
-	unsigned char *data = (unsigned char *)fmw->data;
-	int n;
-
-	if (offset + 8 > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: Type error\n", __func__);
-		return -EINVAL;
-	}
-	block->type = get_unaligned_be32(&data[offset]);
-	offset += 4;
-
-	if (tas_fmw->fw_hdr.fixed_hdr.drv_ver >= PPC_DRIVER_CRCCHK) {
-		if (offset + 8 > fmw->size) {
-			dev_err(tas_fmw->dev, "PChkSumPresent error\n");
-			return -EINVAL;
-		}
-		block->is_pchksum_present = data[offset];
-		offset++;
-
-		block->pchksum = data[offset];
-		offset++;
-
-		block->is_ychksum_present = data[offset];
-		offset++;
-
-		block->ychksum = data[offset];
-		offset++;
-	} else {
-		block->is_pchksum_present = 0;
-		block->is_ychksum_present = 0;
-	}
-
-	block->nr_cmds = get_unaligned_be32(&data[offset]);
-	offset += 4;
-
-	n = block->nr_cmds * 4;
-	if (offset + n > fmw->size) {
-		dev_err(tas_fmw->dev,
-			"%s: File Size(%lu) error offset = %d n = %d\n",
-			__func__, (unsigned long)fmw->size, offset, n);
-		return -EINVAL;
-	}
-	/* instead of kzalloc+memcpy */
-	block->data = kmemdup(&data[offset], n, GFP_KERNEL);
-	if (!block->data)
-		return -ENOMEM;
-
-	offset += n;
-
-	return offset;
-}
-
-/*
- * When parsing error occurs, all the memory resource will be released
- * in the end of tasdevice_rca_ready.
- */
-static int fw_parse_data(struct tasdevice_fw *tas_fmw,
-	struct tasdevice_data *img_data, const struct firmware *fmw,
-	int offset)
-{
-	const unsigned char *data = (unsigned char *)fmw->data;
-	struct tasdev_blk *blk;
-	unsigned int i, n;
-
-	if (offset + 64 > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: Name error\n", __func__);
-		return -EINVAL;
-	}
-	memcpy(img_data->name, &data[offset], 64);
-	offset += 64;
-
-	n = strlen((char *)&data[offset]);
-	n++;
-	if (offset + n + 2 > fmw->size) {
-		dev_err(tas_fmw->dev, "%s: Description error\n", __func__);
-		return -EINVAL;
-	}
-	offset += n;
-	img_data->nr_blk = get_unaligned_be16(&data[offset]);
-	offset += 2;
-
-	img_data->dev_blks = kcalloc(img_data->nr_blk,
-		sizeof(*img_data->dev_blks), GFP_KERNEL);
-	if (!img_data->dev_blks)
-		return -ENOMEM;
-
-	for (i = 0; i < img_data->nr_blk; i++) {
-		blk = &img_data->dev_blks[i];
-		offset = fw_parse_block_data(tas_fmw, blk, fmw, offset);
-		if (offset < 0)
-			return -EINVAL;
-	}
-
-	return offset;
-}
-
-/*
- * When parsing error occurs, all the memory resource will be released
- * in the end of tasdevice_rca_ready.
- */
-static int fw_parse_program_data(struct tasdevice_priv *tas_priv,
-	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
-{
-	unsigned char *buf = (unsigned char *)fmw->data;
-	struct tasdevice_prog *program;
-	int i;
-
-	if (offset + 2 > fmw->size) {
-		dev_err(tas_priv->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-	tas_fmw->nr_programs = get_unaligned_be16(&buf[offset]);
-	offset += 2;
-
-	if (tas_fmw->nr_programs == 0) {
-		/* Not error in calibration Data file, return directly */
-		dev_dbg(tas_priv->dev, "%s: No Programs data, maybe calbin\n",
-			__func__);
-		return offset;
-	}
-
-	tas_fmw->programs =
-		kcalloc(tas_fmw->nr_programs, sizeof(*tas_fmw->programs),
-			GFP_KERNEL);
-	if (!tas_fmw->programs)
-		return -ENOMEM;
-
-	for (i = 0; i < tas_fmw->nr_programs; i++) {
-		int n = 0;
-
-		program = &tas_fmw->programs[i];
-		if (offset + 64 > fmw->size) {
-			dev_err(tas_priv->dev, "%s: mpName error\n", __func__);
-			return -EINVAL;
-		}
-		offset += 64;
-
-		n = strlen((char *)&buf[offset]);
-		/* skip '\0' and 5 unused bytes */
-		n += 6;
-		if (offset + n > fmw->size) {
-			dev_err(tas_priv->dev, "Description err\n");
-			return -EINVAL;
-		}
-
-		offset += n;
-
-		offset = fw_parse_data(tas_fmw, &program->dev_data, fmw,
-			offset);
-		if (offset < 0)
-			return offset;
-	}
-
-	return offset;
-}
-
-/*
- * When parsing error occurs, all the memory resource will be released
- * in the end of tasdevice_rca_ready.
- */
-static int fw_parse_configuration_data(struct tasdevice_priv *tas_priv,
-	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
-{
-	unsigned char *data = (unsigned char *)fmw->data;
-	struct tasdevice_config *config;
-	unsigned int i, n;
-
-	if (offset + 2 > fmw->size) {
-		dev_err(tas_priv->dev, "%s: File Size error\n", __func__);
-		return -EINVAL;
-	}
-	tas_fmw->nr_configurations = get_unaligned_be16(&data[offset]);
-	offset += 2;
-
-	if (tas_fmw->nr_configurations == 0) {
-		dev_err(tas_priv->dev, "%s: Conf is zero\n", __func__);
-		/* Not error for calibration Data file, return directly */
-		return offset;
-	}
-	tas_fmw->configs = kcalloc(tas_fmw->nr_configurations,
-			sizeof(*tas_fmw->configs), GFP_KERNEL);
-	if (!tas_fmw->configs)
-		return -ENOMEM;
-	for (i = 0; i < tas_fmw->nr_configurations; i++) {
-		config = &tas_fmw->configs[i];
-		if (offset + 64 > fmw->size) {
-			dev_err(tas_priv->dev, "File Size err\n");
-			return -EINVAL;
-		}
-		memcpy(config->name, &data[offset], 64);
-		offset += 64;
-
-		n = strlen((char *)&data[offset]);
-		n += 15;
-		if (offset + n > fmw->size) {
-			dev_err(tas_priv->dev, "Description err\n");
-			return -EINVAL;
-		}
-		offset += n;
-		offset = fw_parse_data(tas_fmw, &config->dev_data,
-				       fmw, offset);
-		if (offset < 0)
-			break;
-	}
-
-	return offset;
-}
-
-/* yram5 page check. */
-static bool check_inpage_yram_rg(struct tas_crc *cd,
-	unsigned char reg, unsigned char len)
-{
-	bool in = false;
-
-	if (reg <= TAS2781_YRAM5_END_REG &&
-	    reg >= TAS2781_YRAM5_START_REG) {
-		if (reg + len > TAS2781_YRAM5_END_REG)
-			cd->len = TAS2781_YRAM5_END_REG - reg + 1;
-		else
-			cd->len = len;
-		cd->offset = reg;
-		in = true;
-	} else if (reg < TAS2781_YRAM5_START_REG) {
-		if (reg + len > TAS2781_YRAM5_START_REG) {
-			cd->offset = TAS2781_YRAM5_START_REG;
-			cd->len = len - TAS2781_YRAM5_START_REG + reg;
-			in = true;
-		}
-	}
-
-	return in;
-}
-
-/* DSP firmware yram block check. */
-static bool check_inpage_yram_bk1(struct tas_crc *cd,
-	unsigned char page, unsigned char reg, unsigned char len)
-{
-	bool in = false;
-
-	if (page == TAS2781_YRAM1_PAGE) {
-		if (reg >= TAS2781_YRAM1_START_REG) {
-			cd->offset = reg;
-			cd->len = len;
-			in = true;
-		} else if (reg + len > TAS2781_YRAM1_START_REG) {
-			cd->offset = TAS2781_YRAM1_START_REG;
-			cd->len = len - TAS2781_YRAM1_START_REG + reg;
-			in = true;
-		}
-	} else if (page == TAS2781_YRAM3_PAGE) {
-		in = check_inpage_yram_rg(cd, reg, len);
-	}
-
-	return in;
-}
-
-/*
- * Return Code:
- * true -- the registers are in the inpage yram
- * false -- the registers are NOT in the inpage yram
- */
-static bool check_inpage_yram(struct tas_crc *cd, unsigned char book,
-	unsigned char page, unsigned char reg, unsigned char len)
-{
-	bool in = false;
-
-	if (book == TAS2781_YRAM_BOOK1)
-		in = check_inpage_yram_bk1(cd, page, reg, len);
-	else if (book == TAS2781_YRAM_BOOK2 && page == TAS2781_YRAM5_PAGE)
-		in = check_inpage_yram_rg(cd, reg, len);
-
-	return in;
-}
-
-/* yram4 page check. */
-static bool check_inblock_yram_bk(struct tas_crc *cd,
-	unsigned char page, unsigned char reg, unsigned char len)
-{
-	bool in = false;
-
-	if ((page >= TAS2781_YRAM4_START_PAGE &&
-	     page <= TAS2781_YRAM4_END_PAGE) ||
-	    (page >= TAS2781_YRAM2_START_PAGE &&
-	     page <= TAS2781_YRAM2_END_PAGE)) {
-		if (reg <= TAS2781_YRAM2_END_REG &&
-		    reg >= TAS2781_YRAM2_START_REG) {
-			cd->offset = reg;
-			cd->len = len;
-			in = true;
-		} else if (reg < TAS2781_YRAM2_START_REG) {
-			if (reg + len - 1 >= TAS2781_YRAM2_START_REG) {
-				cd->offset = TAS2781_YRAM2_START_REG;
-				cd->len = reg + len - TAS2781_YRAM2_START_REG;
-				in = true;
-			}
-		}
-	}
-
-	return in;
-}
-
-/*
- * Return Code:
- * true -- the registers are in the inblock yram
- * false -- the registers are NOT in the inblock yram
- */
-static bool check_inblock_yram(struct tas_crc *cd, unsigned char book,
-	unsigned char page, unsigned char reg, unsigned char len)
-{
-	bool in = false;
-
-	if (book == TAS2781_YRAM_BOOK1 || book == TAS2781_YRAM_BOOK2)
-		in = check_inblock_yram_bk(cd, page, reg, len);
-
-	return in;
-}
-
-/* yram page check. */
-static bool check_yram(struct tas_crc *cd, unsigned char book,
-	unsigned char page, unsigned char reg, unsigned char len)
-{
-	bool in;
-
-	in = check_inpage_yram(cd, book, page, reg, len);
-	if (!in)
-		in = check_inblock_yram(cd, book, page, reg, len);
-
-	return in;
-}
-
-/* Checksum for data block. */
-static int tasdev_multibytes_chksum(struct tasdevice_priv *tasdevice,
-	unsigned char book, unsigned char page,
-	unsigned char reg, unsigned int len)
-{
-	struct tas_crc crc_data;
-	unsigned char crc_chksum = 0;
-	unsigned char nBuf1[128];
-	int ret = 0, i;
-	bool in;
-
-	if ((reg + len - 1) > 127) {
-		ret = -EINVAL;
-		dev_err(tasdevice->dev, "firmware error\n");
-		goto end;
-	}
-
-	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (reg == TASDEVICE_REG_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (len == 4)) {
-		/* DSP swap command, pass */
-		ret = 0;
-		goto end;
-	}
-
-	in = check_yram(&crc_data, book, page, reg, len);
-	if (!in)
-		goto end;
-
-	if (len == 1) {
-		dev_err(tasdevice->dev, "firmware error\n");
-		ret = -EINVAL;
-		goto end;
-	}
-
-	ret = tasdevice_spi_dev_bulk_read(tasdevice,
-		TASDEVICE_REG(book, page, crc_data.offset),
-		nBuf1, crc_data.len);
-	if (ret < 0)
-		goto end;
-
-	for (i = 0; i < crc_data.len; i++) {
-		if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-		    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-		    ((i + crc_data.offset) >=
-			TASDEVICE_REG_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-		    ((i + crc_data.offset) <=
-			(TASDEVICE_REG_ID(TAS2781_SA_COEFF_SWAP_REG) + 4)))
-			/* DSP swap command, bypass */
-			continue;
-		else
-			crc_chksum += crc8(tasdevice->crc8_lkp_tbl, &nBuf1[i],
-				1, 0);
-	}
-
-	ret = crc_chksum;
-
-end:
-	return ret;
-}
-
-/* Checksum for single register. */
-static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
-	unsigned char book, unsigned char page,
-	unsigned char reg, unsigned char val)
-{
-	struct tas_crc crc_data;
-	unsigned int nData1;
-	int ret = 0;
-	bool in;
-
-	/* DSP swap command, pass */
-	if ((book == TASDEVICE_BOOK_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (page == TASDEVICE_PAGE_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (reg >= TASDEVICE_REG_ID(TAS2781_SA_COEFF_SWAP_REG)) &&
-	    (reg <= (TASDEVICE_REG_ID(TAS2781_SA_COEFF_SWAP_REG) + 4)))
-		return 0;
-
-	in = check_yram(&crc_data, book, page, reg, 1);
-	if (!in)
-		return 0;
-	ret = tasdevice_spi_dev_read(tasdevice,
-		TASDEVICE_REG(book, page, reg), &nData1);
-	if (ret < 0)
-		return ret;
-
-	if (nData1 != val) {
-		dev_err(tasdevice->dev,
-			"B[0x%x]P[0x%x]R[0x%x] W[0x%x], R[0x%x]\n",
-			book, page, reg, val, nData1);
-		tasdevice->err_code |= ERROR_YRAM_CRCCHK;
-		return -EAGAIN;
-	}
-
-	ret = crc8(tasdevice->crc8_lkp_tbl, &val, 1, 0);
-
-	return ret;
-}
-
-/* Block type check. */
-static void set_err_prg_cfg(unsigned int type, struct tasdevice_priv *p)
-{
-	if ((type == MAIN_ALL_DEVICES) || (type == MAIN_DEVICE_A) ||
-	    (type == MAIN_DEVICE_B) || (type == MAIN_DEVICE_C) ||
-	    (type == MAIN_DEVICE_D))
-		p->cur_prog = -1;
-	else
-		p->cur_conf = -1;
-}
-
-/* Checksum for data bytes. */
-static int tasdev_bytes_chksum(struct tasdevice_priv *tas_priv,
-	struct tasdev_blk *block, unsigned char book,
-	unsigned char page, unsigned char reg, unsigned int len,
-	unsigned char val, unsigned char *crc_chksum)
-{
-	int ret;
-
-	if (len > 1)
-		ret = tasdev_multibytes_chksum(tas_priv, book, page, reg,
-			len);
-	else
-		ret = do_singlereg_checksum(tas_priv, book, page, reg, val);
-
-	if (ret > 0) {
-		*crc_chksum += ret;
-		goto end;
-	}
-
-	if (ret != -EAGAIN)
-		goto end;
-
-	block->nr_retry--;
-	if (block->nr_retry > 0)
-		goto end;
-
-	set_err_prg_cfg(block->type, tas_priv);
-
-end:
-	return ret;
-}
-
-/* Multi-data byte write. */
-static int tasdev_multibytes_wr(struct tasdevice_priv *tas_priv,
-	struct tasdev_blk *block, unsigned char book,
-	unsigned char page, unsigned char reg, unsigned char *data,
-	unsigned int len, unsigned int *nr_cmds,
-	unsigned char *crc_chksum)
-{
-	int ret;
-
-	if (len > 1) {
-		ret = tasdevice_spi_dev_bulk_write(tas_priv,
-			TASDEVICE_REG(book, page, reg), data + 3, len);
-		if (ret < 0)
-			return ret;
-		if (block->is_ychksum_present)
-			ret = tasdev_bytes_chksum(tas_priv, block,
-				book, page, reg, len, 0, crc_chksum);
-	} else {
-		ret = tasdevice_spi_dev_write(tas_priv,
-			TASDEVICE_REG(book, page, reg), data[3]);
-		if (ret < 0)
-			return ret;
-		if (block->is_ychksum_present)
-			ret = tasdev_bytes_chksum(tas_priv, block, book,
-				page, reg, 1, data[3], crc_chksum);
-	}
-
-	if (!block->is_ychksum_present || ret >= 0) {
-		*nr_cmds += 1;
-		if (len >= 2)
-			*nr_cmds += ((len - 2) / 4) + 1;
-	}
-
-	return ret;
-}
-
-/* Checksum for block. */
-static int tasdev_block_chksum(struct tasdevice_priv *tas_priv,
-	struct tasdev_blk *block)
-{
-	unsigned int nr_value;
-	int ret;
-
-	ret = tasdevice_spi_dev_read(tas_priv, TASDEVICE_CHECKSUM, &nr_value);
-	if (ret < 0) {
-		dev_err(tas_priv->dev, "%s: read error %d.\n", __func__, ret);
-		set_err_prg_cfg(block->type, tas_priv);
-		return ret;
-	}
-
-	if ((nr_value & 0xff) != block->pchksum) {
-		dev_err(tas_priv->dev, "%s: PChkSum err %d ", __func__, ret);
-		dev_err(tas_priv->dev, "PChkSum = 0x%x, Reg = 0x%x\n",
-			block->pchksum, (nr_value & 0xff));
-		tas_priv->err_code |= ERROR_PRAM_CRCCHK;
-		ret = -EAGAIN;
-		block->nr_retry--;
-
-		if (block->nr_retry <= 0)
-			set_err_prg_cfg(block->type, tas_priv);
-	} else {
-		tas_priv->err_code &= ~ERROR_PRAM_CRCCHK;
-	}
-
-	return ret;
-}
-
-/* Firmware block load function. */
-static int tasdev_load_blk(struct tasdevice_priv *tas_priv,
-	struct tasdev_blk *block)
-{
-	unsigned int sleep_time, len, nr_cmds;
-	unsigned char offset, book, page, val;
-	unsigned char *data = block->data;
-	unsigned char crc_chksum = 0;
-	int ret = 0;
-
-	while (block->nr_retry > 0) {
-		if (block->is_pchksum_present) {
-			ret = tasdevice_spi_dev_write(tas_priv,
-				TASDEVICE_CHECKSUM, 0);
-			if (ret < 0)
-				break;
-		}
-
-		if (block->is_ychksum_present)
-			crc_chksum = 0;
-
-		nr_cmds = 0;
-
-		while (nr_cmds < block->nr_cmds) {
-			data = block->data + nr_cmds * 4;
-
-			book = data[0];
-			page = data[1];
-			offset = data[2];
-			val = data[3];
-
-			nr_cmds++;
-			/* Single byte write */
-			if (offset <= 0x7F) {
-				ret = tasdevice_spi_dev_write(tas_priv,
-					TASDEVICE_REG(book, page, offset),
-					val);
-				if (ret < 0)
-					break;
-				if (block->is_ychksum_present) {
-					ret = tasdev_bytes_chksum(tas_priv,
-						block, book, page, offset,
-						1, val, &crc_chksum);
-					if (ret < 0)
-						break;
-				}
-				continue;
-			}
-			/* sleep command */
-			if (offset == 0x81) {
-				/* book -- data[0] page -- data[1] */
-				sleep_time = ((book << 8) + page)*1000;
-				fsleep(sleep_time);
-				continue;
-			}
-			/* Multiple bytes write */
-			if (offset == 0x85) {
-				data += 4;
-				len = (book << 8) + page;
-				book = data[0];
-				page = data[1];
-				offset = data[2];
-				ret = tasdev_multibytes_wr(tas_priv,
-					block, book, page, offset, data,
-					len, &nr_cmds, &crc_chksum);
-				if (ret < 0)
-					break;
-			}
-		}
-		if (ret == -EAGAIN) {
-			if (block->nr_retry > 0)
-				continue;
-		} else if (ret < 0) {
-			/* err in current device, skip it */
-			break;
-		}
-
-		if (block->is_pchksum_present) {
-			ret = tasdev_block_chksum(tas_priv, block);
-			if (ret == -EAGAIN) {
-				if (block->nr_retry > 0)
-					continue;
-			} else if (ret < 0) {
-				/* err in current device, skip it */
-				break;
-			}
-		}
-
-		if (block->is_ychksum_present) {
-			/* TBD, open it when FW ready */
-			dev_err(tas_priv->dev,
-				"Blk YChkSum: FW = 0x%x, YCRC = 0x%x\n",
-				block->ychksum, crc_chksum);
-
-			tas_priv->err_code &=
-				~ERROR_YRAM_CRCCHK;
-			ret = 0;
-		}
-		/* skip current blk */
-		break;
-	}
-
-	return ret;
-}
-
-/* Firmware block load function. */
-static int tasdevice_load_block(struct tasdevice_priv *tas_priv,
-	struct tasdev_blk *block)
-{
-	int ret = 0;
-
-	block->nr_retry = 6;
-	if (tas_priv->is_loading == false)
-		return 0;
-	ret = tasdev_load_blk(tas_priv, block);
-	if (ret < 0)
-		dev_err(tas_priv->dev, "Blk (%d) load error\n", block->type);
-
-	return ret;
-}
-
-/*
- * Select firmware binary parser & load callback functions by ppc3 version
- * and firmware binary version.
- */
-static int dspfw_default_callback(struct tasdevice_priv *tas_priv,
-	unsigned int drv_ver, unsigned int ppcver)
-{
-	int rc = 0;
-
-	if (drv_ver == 0x100) {
-		if (ppcver >= PPC3_VERSION_BASE) {
-			tas_priv->fw_parse_variable_header =
-				fw_parse_variable_header_kernel;
-			tas_priv->fw_parse_program_data =
-				fw_parse_program_data_kernel;
-			tas_priv->fw_parse_configuration_data =
-				fw_parse_configuration_data_kernel;
-			tas_priv->tasdevice_load_block =
-				tasdevice_load_block_kernel;
-		} else if (ppcver == 0x00) {
-			tas_priv->fw_parse_variable_header =
-				fw_parse_variable_header_git;
-			tas_priv->fw_parse_program_data =
-				fw_parse_program_data;
-			tas_priv->fw_parse_configuration_data =
-				fw_parse_configuration_data;
-			tas_priv->tasdevice_load_block =
-				tasdevice_load_block;
-		} else {
-			dev_err(tas_priv->dev,
-				"Wrong PPCVer :0x%08x\n", ppcver);
-			rc = -EINVAL;
-		}
-	} else {
-		dev_err(tas_priv->dev, "Wrong DrvVer : 0x%02x\n", drv_ver);
-		rc = -EINVAL;
-	}
-
-	return rc;
-}
-
-/* DSP firmware binary file header parser function. */
-static int fw_parse_header(struct tasdevice_priv *tas_priv,
-	struct tasdevice_fw *tas_fmw, const struct firmware *fmw, int offset)
-{
-	struct tasdevice_dspfw_hdr *fw_hdr = &tas_fmw->fw_hdr;
-	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr = &fw_hdr->fixed_hdr;
-	static const unsigned char magic_number[] = {0x35, 0x35, 0x35, 0x32, };
-	const unsigned char *buf = (unsigned char *)fmw->data;
-
-	if (offset + 92 > fmw->size) {
-		dev_err(tas_priv->dev, "%s: File Size error\n", __func__);
-		offset = -EINVAL;
-		goto out;
-	}
-	if (memcmp(&buf[offset], magic_number, 4)) {
-		dev_err(tas_priv->dev, "%s: Magic num NOT match\n", __func__);
-		offset = -EINVAL;
-		goto out;
-	}
-	offset += 4;
-
-	/*
-	 * Convert data[offset], data[offset + 1], data[offset + 2] and
-	 * data[offset + 3] into host
-	 */
-	fw_fixed_hdr->fwsize = get_unaligned_be32(&buf[offset]);
-	offset += 4;
-	if (fw_fixed_hdr->fwsize != fmw->size) {
-		dev_err(tas_priv->dev, "File size not match, %lu %u",
-			(unsigned long)fmw->size, fw_fixed_hdr->fwsize);
-		offset = -EINVAL;
-		goto out;
-	}
-	offset += 4;
-	fw_fixed_hdr->ppcver = get_unaligned_be32(&buf[offset]);
-	offset += 8;
-	fw_fixed_hdr->drv_ver = get_unaligned_be32(&buf[offset]);
-	offset += 72;
-
-out:
-	return offset;
-}
-
-/* DSP firmware binary file parser function. */
-static int tasdevice_dspfw_ready(const struct firmware *fmw, void *context)
-{
-	struct tasdevice_priv *tas_priv = context;
-	struct tasdevice_fw_fixed_hdr *fw_fixed_hdr;
-	struct tasdevice_fw *tas_fmw;
-	int offset = 0, ret = 0;
-
-	if (!fmw || !fmw->data) {
-		dev_err(tas_priv->dev, "%s: Failed to read firmware %s\n",
-			__func__, tas_priv->coef_binaryname);
-		return -EINVAL;
-	}
-
-	tas_priv->fmw = kzalloc(sizeof(*tas_priv->fmw), GFP_KERNEL);
-	if (!tas_priv->fmw)
-		return -ENOMEM;
-	tas_fmw = tas_priv->fmw;
-	tas_fmw->dev = tas_priv->dev;
-	offset = fw_parse_header(tas_priv, tas_fmw, fmw, offset);
-
-	if (offset == -EINVAL)
-		return -EINVAL;
-
-	fw_fixed_hdr = &tas_fmw->fw_hdr.fixed_hdr;
-	/* Support different versions of firmware */
-	switch (fw_fixed_hdr->drv_ver) {
-	case 0x301:
-	case 0x302:
-	case 0x502:
-	case 0x503:
-		tas_priv->fw_parse_variable_header =
-			fw_parse_variable_header_kernel;
-		tas_priv->fw_parse_program_data =
-			fw_parse_program_data_kernel;
-		tas_priv->fw_parse_configuration_data =
-			fw_parse_configuration_data_kernel;
-		tas_priv->tasdevice_load_block =
-			tasdevice_load_block_kernel;
-		break;
-	case 0x202:
-	case 0x400:
-		tas_priv->fw_parse_variable_header =
-			fw_parse_variable_header_git;
-		tas_priv->fw_parse_program_data =
-			fw_parse_program_data;
-		tas_priv->fw_parse_configuration_data =
-			fw_parse_configuration_data;
-		tas_priv->tasdevice_load_block =
-			tasdevice_load_block;
-		break;
-	default:
-		ret = dspfw_default_callback(tas_priv,
-			fw_fixed_hdr->drv_ver, fw_fixed_hdr->ppcver);
-		if (ret)
-			return ret;
-		break;
-	}
-
-	offset = tas_priv->fw_parse_variable_header(tas_priv, fmw, offset);
-	if (offset < 0)
-		return offset;
-
-	offset = tas_priv->fw_parse_program_data(tas_priv, tas_fmw, fmw,
-		offset);
-	if (offset < 0)
-		return offset;
-
-	offset = tas_priv->fw_parse_configuration_data(tas_priv,
-		tas_fmw, fmw, offset);
-	if (offset < 0)
-		ret = offset;
-
-	return ret;
-}
-
-/* DSP firmware binary file parser function. */
-int tasdevice_spi_dsp_parser(void *context)
-{
-	struct tasdevice_priv *tas_priv = context;
-	const struct firmware *fw_entry;
-	int ret;
-
-	ret = request_firmware(&fw_entry, tas_priv->coef_binaryname,
-		tas_priv->dev);
-	if (ret) {
-		dev_err(tas_priv->dev, "%s: load %s error\n", __func__,
-			tas_priv->coef_binaryname);
-		return ret;
-	}
-
-	ret = tasdevice_dspfw_ready(fw_entry, tas_priv);
-	release_firmware(fw_entry);
-	fw_entry = NULL;
-
-	return ret;
-}
-
-/* DSP firmware program block data remove function. */
-static void tasdev_dsp_prog_blk_remove(struct tasdevice_prog *prog)
-{
-	struct tasdevice_data *tas_dt;
-	struct tasdev_blk *blk;
-	unsigned int i;
-
-	if (!prog)
-		return;
-
-	tas_dt = &prog->dev_data;
-
-	if (!tas_dt->dev_blks)
-		return;
-
-	for (i = 0; i < tas_dt->nr_blk; i++) {
-		blk = &tas_dt->dev_blks[i];
-		kfree(blk->data);
-	}
-	kfree(tas_dt->dev_blks);
-}
-
-/* DSP firmware program block data remove function. */
-static void tasdev_dsp_prog_remove(struct tasdevice_prog *prog,
-	unsigned short nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		tasdev_dsp_prog_blk_remove(&prog[i]);
-	kfree(prog);
-}
-
-/* DSP firmware config block data remove function. */
-static void tasdev_dsp_cfg_blk_remove(struct tasdevice_config *cfg)
-{
-	struct tasdevice_data *tas_dt;
-	struct tasdev_blk *blk;
-	unsigned int i;
-
-	if (cfg) {
-		tas_dt = &cfg->dev_data;
-
-		if (!tas_dt->dev_blks)
-			return;
-
-		for (i = 0; i < tas_dt->nr_blk; i++) {
-			blk = &tas_dt->dev_blks[i];
-			kfree(blk->data);
-		}
-		kfree(tas_dt->dev_blks);
-	}
-}
-
-/* DSP firmware config remove function. */
-static void tasdev_dsp_cfg_remove(struct tasdevice_config *config,
-	unsigned short nr)
-{
-	int i;
-
-	for (i = 0; i < nr; i++)
-		tasdev_dsp_cfg_blk_remove(&config[i]);
-	kfree(config);
-}
-
-/* DSP firmware remove function. */
-void tasdevice_spi_dsp_remove(void *context)
-{
-	struct tasdevice_priv *tas_dev = context;
-
-	if (!tas_dev->fmw)
-		return;
-
-	if (tas_dev->fmw->programs)
-		tasdev_dsp_prog_remove(tas_dev->fmw->programs,
-			tas_dev->fmw->nr_programs);
-	if (tas_dev->fmw->configs)
-		tasdev_dsp_cfg_remove(tas_dev->fmw->configs,
-			tas_dev->fmw->nr_configurations);
-	kfree(tas_dev->fmw);
-	tas_dev->fmw = NULL;
-}
-
-/* DSP firmware calibration data remove function. */
-static void tas2781_clear_calfirmware(struct tasdevice_fw *tas_fmw)
-{
-	struct tasdevice_calibration *calibration;
-	struct tasdev_blk *block;
-	unsigned int blks;
-	int i;
-
-	if (!tas_fmw->calibrations)
-		goto out;
-
-	for (i = 0; i < tas_fmw->nr_calibrations; i++) {
-		calibration = &tas_fmw->calibrations[i];
-		if (!calibration)
-			continue;
-
-		if (!calibration->dev_data.dev_blks)
-			continue;
-
-		for (blks = 0; blks < calibration->dev_data.nr_blk; blks++) {
-			block = &calibration->dev_data.dev_blks[blks];
-			if (!block)
-				continue;
-			kfree(block->data);
-		}
-		kfree(calibration->dev_data.dev_blks);
-	}
-	kfree(tas_fmw->calibrations);
-out:
-	kfree(tas_fmw);
-}
-
-/* Calibration data from firmware remove function. */
-void tasdevice_spi_calbin_remove(void *context)
-{
-	struct tasdevice_priv *tas_priv = context;
-
-	if (tas_priv->cali_data_fmw) {
-		tas2781_clear_calfirmware(tas_priv->cali_data_fmw);
-		tas_priv->cali_data_fmw = NULL;
-	}
-}
-
-/* Configuration remove function. */
-void tasdevice_spi_config_info_remove(void *context)
-{
-	struct tasdevice_priv *tas_priv = context;
-	struct tasdevice_rca *rca = &tas_priv->rcabin;
-	struct tasdevice_config_info **ci = rca->cfg_info;
-	unsigned int i, j;
-
-	if (!ci)
-		return;
-	for (i = 0; i < rca->ncfgs; i++) {
-		if (!ci[i])
-			continue;
-		if (ci[i]->blk_data) {
-			for (j = 0; j < ci[i]->real_nblocks; j++) {
-				if (!ci[i]->blk_data[j])
-					continue;
-				kfree(ci[i]->blk_data[j]->regdata);
-				kfree(ci[i]->blk_data[j]);
-			}
-			kfree(ci[i]->blk_data);
-		}
-		kfree(ci[i]);
-	}
-	kfree(ci);
-}
-
-/* DSP firmware program block data load function. */
-static int tasdevice_load_data(struct tasdevice_priv *tas_priv,
-	struct tasdevice_data *dev_data)
-{
-	struct tasdev_blk *block;
-	unsigned int i;
-	int ret = 0;
-
-	for (i = 0; i < dev_data->nr_blk; i++) {
-		block = &dev_data->dev_blks[i];
-		ret = tas_priv->tasdevice_load_block(tas_priv, block);
-		if (ret < 0)
-			break;
-	}
-
-	return ret;
-}
-
-/* DSP firmware program load interface function. */
-int tasdevice_spi_prmg_load(void *context, int prm_no)
-{
-	struct tasdevice_priv *tas_priv = context;
-	struct tasdevice_fw *tas_fmw = tas_priv->fmw;
-	struct tasdevice_prog *program;
-	struct tasdevice_config *conf;
-	int ret = 0;
-
-	if (!tas_fmw) {
-		dev_err(tas_priv->dev, "%s: Firmware is NULL\n", __func__);
-		return -EINVAL;
-	}
-	if (prm_no >= 0 && prm_no <= tas_fmw->nr_programs) {
-		tas_priv->cur_conf = 0;
-		tas_priv->is_loading = true;
-		program = &tas_fmw->programs[prm_no];
-		ret = tasdevice_load_data(tas_priv, &program->dev_data);
-		if (ret < 0) {
-			dev_err(tas_priv->dev, "Program failed %d.\n", ret);
-			return ret;
-		}
-		tas_priv->cur_prog = prm_no;
-
-		conf = &tas_fmw->configs[tas_priv->cur_conf];
-		ret = tasdevice_load_data(tas_priv, &conf->dev_data);
-		if (ret < 0)
-			dev_err(tas_priv->dev, "Config failed %d.\n", ret);
-	} else {
-		dev_err(tas_priv->dev,
-			"%s: prm(%d) is not in range of Programs %u\n",
-			__func__, prm_no, tas_fmw->nr_programs);
-		return -EINVAL;
-	}
-
-	return ret;
-}
-
-/* RCABIN configuration switch interface function. */
-void tasdevice_spi_tuning_switch(void *context, int state)
-{
-	struct tasdevice_priv *tas_priv = context;
-	int profile_cfg_id = tas_priv->rcabin.profile_cfg_id;
-
-	if (tas_priv->fw_state == TASDEVICE_DSP_FW_FAIL) {
-		dev_err(tas_priv->dev, "DSP bin file not loaded\n");
-		return;
-	}
-
-	if (state == 0)
-		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
-			TASDEVICE_BIN_BLK_PRE_POWER_UP);
-	else
-		tasdevice_spi_select_cfg_blk(tas_priv, profile_cfg_id,
-			TASDEVICE_BIN_BLK_PRE_SHUTDOWN);
-}
diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index 1e0b3aa95749..4df2edcfac40 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -21,8 +21,6 @@
 #include <sound/soc.h>
 #include <sound/tas2781.h>
 
-#define TASDEVICE_CRC8_POLYNOMIAL	0x4d
-
 static const struct regmap_range_cfg tasdevice_ranges[] = {
 	{
 		.range_min = 0,
@@ -122,7 +120,7 @@ int tasdevice_dev_read(struct tasdevice_priv *tas_priv,
 	if (chn < tas_priv->ndev) {
 		struct regmap *map = tas_priv->regmap;
 
-		ret = tasdevice_change_chn_book(tas_priv, chn,
+		ret = tas_priv->change_chn_book(tas_priv, chn,
 			TASDEVICE_BOOK_ID(reg));
 		if (ret < 0)
 			goto out;
@@ -149,7 +147,7 @@ int tasdevice_dev_write(struct tasdevice_priv *tas_priv,
 	if (chn < tas_priv->ndev) {
 		struct regmap *map = tas_priv->regmap;
 
-		ret = tasdevice_change_chn_book(tas_priv, chn,
+		ret = tas_priv->change_chn_book(tas_priv, chn,
 			TASDEVICE_BOOK_ID(reg));
 		if (ret < 0)
 			goto out;
@@ -179,7 +177,7 @@ int tasdevice_dev_bulk_write(
 	if (chn < tas_priv->ndev) {
 		struct regmap *map = tas_priv->regmap;
 
-		ret = tasdevice_change_chn_book(tas_priv, chn,
+		ret = tas_priv->change_chn_book(tas_priv, chn,
 			TASDEVICE_BOOK_ID(reg));
 		if (ret < 0)
 			goto out;
@@ -208,7 +206,7 @@ int tasdevice_dev_bulk_read(struct tasdevice_priv *tas_priv,
 	if (chn < tas_priv->ndev) {
 		struct regmap *map = tas_priv->regmap;
 
-		ret = tasdevice_change_chn_book(tas_priv, chn,
+		ret = tas_priv->change_chn_book(tas_priv, chn,
 			TASDEVICE_BOOK_ID(reg));
 		if (ret < 0)
 			goto out;
@@ -234,7 +232,7 @@ int tasdevice_dev_update_bits(
 	if (chn < tas_priv->ndev) {
 		struct regmap *map = tas_priv->regmap;
 
-		ret = tasdevice_change_chn_book(tas_priv, chn,
+		ret = tas_priv->change_chn_book(tas_priv, chn,
 			TASDEVICE_BOOK_ID(reg));
 		if (ret < 0)
 			goto out;
@@ -340,6 +338,7 @@ int tasdevice_init(struct tasdevice_priv *tas_priv)
 
 	tas_priv->cur_prog = -1;
 	tas_priv->cur_conf = -1;
+	tas_priv->isspi = false;
 
 	for (i = 0; i < tas_priv->ndev; i++) {
 		tas_priv->tasdevice[i].cur_book = -1;
@@ -347,6 +346,11 @@ int tasdevice_init(struct tasdevice_priv *tas_priv)
 		tas_priv->tasdevice[i].cur_conf = -1;
 	}
 
+	tas_priv->update_bits = tasdevice_dev_update_bits;
+	tas_priv->change_chn_book = tasdevice_change_chn_book;
+	tas_priv->dev_read = tasdevice_dev_read;
+	tas_priv->dev_bulk_read = tasdevice_dev_bulk_read;
+
 	mutex_init(&tas_priv->codec_lock);
 
 out:
diff --git a/sound/soc/codecs/tas2781-fmwlib.c b/sound/soc/codecs/tas2781-fmwlib.c
index 13a197468193..3dd76aff1b6e 100644
--- a/sound/soc/codecs/tas2781-fmwlib.c
+++ b/sound/soc/codecs/tas2781-fmwlib.c
@@ -803,8 +803,13 @@ static int tasdevice_process_block(void *context, unsigned char *data,
 		chn = idx - 1;
 		chnend = idx;
 	} else {
-		chn = 0;
-		chnend = tas_priv->ndev;
+		if (tas_priv->isspi) {
+			chn = tas_priv->index;
+			chnend = chn + 1;
+		} else {
+			chn = 0;
+			chnend = tas_priv->ndev;
+		}
 	}
 
 	for (; chn < chnend; chn++) {
@@ -896,7 +901,7 @@ static int tasdevice_process_block(void *context, unsigned char *data,
 				is_err = true;
 				break;
 			}
-			rc = tasdevice_dev_update_bits(tas_priv, chn,
+			rc = tas_priv->update_bits(tas_priv, chn,
 				TASDEVICE_REG(data[subblk_offset + 2],
 				data[subblk_offset + 3],
 				data[subblk_offset + 4]),
@@ -1461,7 +1466,7 @@ static int tasdev_multibytes_chksum(struct tasdevice_priv *tasdevice,
 		goto end;
 	}
 
-	ret = tasdevice_dev_bulk_read(tasdevice, chn,
+	ret = tasdevice->dev_bulk_read(tasdevice, chn,
 		TASDEVICE_REG(book, page, crc_data.offset),
 		nBuf1, crc_data.len);
 	if (ret < 0)
@@ -1511,7 +1516,7 @@ static int do_singlereg_checksum(struct tasdevice_priv *tasdevice,
 	in = check_yram(&crc_data, book, page, reg, 1);
 	if (!in)
 		goto end;
-	ret = tasdevice_dev_read(tasdevice, chl,
+	ret = tasdevice->dev_read(tasdevice, chl,
 		TASDEVICE_REG(book, page, reg), &nData1);
 	if (ret < 0)
 		goto end;
@@ -1615,7 +1620,7 @@ static int tasdev_block_chksum(struct tasdevice_priv *tas_priv,
 	unsigned int nr_value;
 	int ret;
 
-	ret = tasdevice_dev_read(tas_priv, chn, TASDEVICE_CHECKSUM_REG,
+	ret = tas_priv->dev_read(tas_priv, chn, TASDEVICE_CHECKSUM_REG,
 		&nr_value);
 	if (ret < 0) {
 		dev_err(tas_priv->dev, "%s: Chn %d\n", __func__, chn);
-- 
2.43.0


