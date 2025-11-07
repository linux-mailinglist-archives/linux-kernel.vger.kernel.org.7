Return-Path: <linux-kernel+bounces-889884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427DC3EC29
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 08:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08D353B124F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 07:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D556C307487;
	Fri,  7 Nov 2025 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2D0UnXs"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA542853F7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 07:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762500652; cv=none; b=s4+brVMurPZcFpkfJuopr/mh+1BxP7tCwPXtXAQ+a2eppsFTQIM42343bTPYDJC9Ygo4DsyAkDwfQrr3QiBfnec/NQH6tFZAY5q0jf0ju+314vhVdB3Xgw+tT/KEkoVS6h3jn6au7qq4ewt8kcBjMY1IO0UYtPDszaSf4uCJEsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762500652; c=relaxed/simple;
	bh=f35DbpZpPqMDzZoRIqs7Osgf1PM69yqyjWw/dglp96Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifzP+daw+HsvjMdofRBRdTRSEhEyL2wNhAehjmVghP6rniHjdpVclzjDEYOBUwK3Ox6NrFO1zhP3SJ87bb+BZIfQBYpsy3mAO1ajIvj1A7NN/wyid7tE6OJL1c+4KpHAAbOg2f4L2+hjQbTJlc+EvdOaHtJeq1pjxKzR6E8uDzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2D0UnXs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-378cffe5e1aso4369971fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 23:30:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762500649; x=1763105449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4M6PwHQesX19scpYMiKXrQJ0jxJ0uMLe/ADSgAzPkxs=;
        b=F2D0UnXsBgpmz9PNRt+ECrBo4w7erhNmC97oPwsP4TrPXiT14dHqq1/xwaj+v/WXO3
         tHFp84/rByrCXxBUz7fDOdtbDrlP6pOBRliRMEUotcj48DiJN/1ogIHVQ4+FSWwYzMPn
         zPKQ/2396+5I0b9LDc83IOETtz5ZsdI5gyhM1K+yTuYYFpCRnP5S7Yor2h0zEDlUZ/6I
         eMm8300+YF5g5uhzKCDZWo4SdIWgHN2v+QlSHfowa4PL/VVKSUS6BI46l0rMy2a6jYiB
         pMZEnOZmACDqwa1ng5wPhfwYHuPxHzpKJA9PI4eKEhzw6nxG2PEfDgcPYByafJCw7r/7
         2vzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762500649; x=1763105449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4M6PwHQesX19scpYMiKXrQJ0jxJ0uMLe/ADSgAzPkxs=;
        b=mDJaJ8CUWoN4Iifpmqm8aN9306XeYw15yZZOAAU0gfjsPGuo0u3Z+NP5UA5E5MMK7j
         QGMWjB8o43ieV7ue1bVRxcFIa1LWU5UCqLI3ulVCIfk3s5raifndSP0CE1VCpBtKCucH
         56gDj4NHdpeyWZ3/anSrvLffHwENQAeVTqzfC/to+BDKe2TRGiPtoPlo3WnFgo/oK0yZ
         H1HZxFq4EGbc6+CEKc5Bbuvv3jPxlmuPG2oDQw12w26GO7fGxzXc2uBW1Y516um9Ti4L
         3ex233RWea1ucq3ECmdM2yrFRJuLuqT7lKMoDqkf5OvlUsesrX/n0xHTl7cj55+v5M2E
         3uOA==
X-Forwarded-Encrypted: i=1; AJvYcCXV5WrUlitLlNwhEzbMJZUbltEyU4lxDMCc7uwDG+b7Pe4gxe/e9emlTvaNHPVsSGpIh07wES1TFpq3wy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhNbv3raEErZeUDCxb8g2iX7mZY+elr5BNG0H0tPg7zvxYMzn
	WhigxhOFhm4BuAF0ctY8O8PF25Qc6f7rHEGSvltHgYao/aKFGoDBp/yW
X-Gm-Gg: ASbGnctJHKiBWiViLSbEqsr1z51QVF6NauUXSLaYn4rF9Z7Q/gnXzp7YzYwni/0GKRW
	IiwfNXdTZS+3kmbdfbuur0wXWz+K6+wcCyQ/hgPG5UIT1APCXe7dg4z/pE/YRiJcBQOUq5gpvcf
	ggJ4wpy9k5cHRwxvSsWrNnA2hjOAfH9C3leSAArzsU2xXfWHSVvROYqtKtqZ3xK8FueX4TiEhta
	kP+bu3CkvtSQvZyApp6hwas747T9CTfksORrRmmSNmdR+vhSdGZG/d7wbbr9YSnVqvNIQFEoXPj
	ooJMWhEktSTxfWvp6mLlvXa1rcxXKZJhRYlXOEFIUSNWPDotiTZVPJBFNG6NnNCrzulnKMHfMtp
	zf2kUP9dPchB3vfY1G5CCXs/+p0SY2WuG7TdMXZKL2aM3uKd197NjE5Irn3EvUcwf7C4Ks6O4VO
	lXsAFUKtcycglXVAkA
X-Google-Smtp-Source: AGHT+IEM6jJW7S0zoNmv87VOalpMKNhTySFhZbseoiHIzvl3ywyxFEtICW2fvawnuW/rzdA1JD3pIA==
X-Received: by 2002:a05:651c:4194:b0:37a:2e2a:da6f with SMTP id 38308e7fff4ca-37a742ce607mr4452981fa.44.1762500648643;
        Thu, 06 Nov 2025 23:30:48 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5944a013bd8sm1284123e87.1.2025.11.06.23.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 23:30:47 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: mika.westerberg@linux.intel.com
Cc: a.shimko.dev@gmail.com,
	andi.shyti@kernel.org,
	andriy.shevchenko@linux.intel.com,
	jsd@semihalf.com,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] i2c: designware: Replace magic numbers with named constants
Date: Fri,  7 Nov 2025 10:30:39 +0300
Message-ID: <20251107073039.2646048-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <202511071402.qHS6LLi9-lkp@intel.com>
References: <202511071402.qHS6LLi9-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace various magic numbers with properly named constants to improve
code readability and maintainability. This includes constants for
register access, timing adjustments, timeouts, FIFO parameters,
and default values.

The change makes the code more self-documenting without altering any
functionality.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511071402.qHS6LLi9-lkp@intel.com/
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello

--
Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251105161845.2535367-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * Move register-related constants to i2c-designware-core.h
    * Remove unnecessary comments to reduce clutter  
    * Keep only essential timeouts and default parameters in .c file
    * Use FIELD_GET() for FIFO depth extraction as suggested
  v3:
    * Add missing include for linux/bitfield.h

 drivers/i2c/busses/i2c-designware-common.c | 33 ++++++++++++++--------
 drivers/i2c/busses/i2c-designware-core.h   | 13 +++++++++
 2 files changed, 35 insertions(+), 11 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 5b1e8f74c4ac..3bc55068da03 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -12,6 +12,7 @@
 #define DEFAULT_SYMBOL_NAMESPACE	"I2C_DW_COMMON"
 
 #include <linux/acpi.h>
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -34,6 +35,14 @@
 
 #include "i2c-designware-core.h"
 
+#define DW_IC_DEFAULT_BUS_CAPACITANCE_PF	100
+
+#define DW_IC_ABORT_TIMEOUT_US			10
+#define DW_IC_ABORT_TOTAL_TIMEOUT_US		100
+
+#define DW_IC_BUSY_POLL_TIMEOUT_US		1100
+#define DW_IC_BUSY_TOTAL_TIMEOUT_US		20000
+
 static const char *const abort_sources[] = {
 	[ABRT_7B_ADDR_NOACK] =
 		"slave address not acknowledged (7bit mode)",
@@ -106,7 +115,7 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 	struct dw_i2c_dev *dev = context;
 
 	*val = readw(dev->base + reg) |
-		(readw(dev->base + reg + 2) << 16);
+		(readw(dev->base + reg + DW_IC_REG_STEP_BYTES) << DW_IC_REG_WORD_SHIFT);
 
 	return 0;
 }
@@ -116,7 +125,7 @@ static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 	struct dw_i2c_dev *dev = context;
 
 	writew(val, dev->base + reg);
-	writew(val >> 16, dev->base + reg + 2);
+	writew(val >> DW_IC_REG_WORD_SHIFT, dev->base + reg + DW_IC_REG_STEP_BYTES);
 
 	return 0;
 }
@@ -165,7 +174,7 @@ int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	if (reg == swab32(DW_IC_COMP_TYPE_VALUE)) {
 		map_cfg.reg_read = dw_reg_read_swab;
 		map_cfg.reg_write = dw_reg_write_swab;
-	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+	} else if (reg == lower_16_bits(DW_IC_COMP_TYPE_VALUE)) {
 		map_cfg.reg_read = dw_reg_read_word;
 		map_cfg.reg_write = dw_reg_write_word;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
@@ -384,7 +393,7 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 	i2c_parse_fw_timings(device, t, false);
 
 	if (device_property_read_u32(device, "snps,bus-capacitance-pf", &dev->bus_capacitance_pF))
-		dev->bus_capacitance_pF = 100;
+		dev->bus_capacitance_pF = DW_IC_DEFAULT_BUS_CAPACITANCE_PF;
 
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
@@ -539,8 +548,9 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
 		regmap_write(dev->map, DW_IC_ENABLE, enable | DW_IC_ENABLE_ABORT);
 		ret = regmap_read_poll_timeout(dev->map, DW_IC_ENABLE, enable,
-					       !(enable & DW_IC_ENABLE_ABORT), 10,
-					       100);
+					       !(enable & DW_IC_ENABLE_ABORT),
+					       DW_IC_ABORT_TIMEOUT_US,
+					       DW_IC_ABORT_TOTAL_TIMEOUT_US);
 		if (ret)
 			dev_err(dev->dev, "timeout while trying to abort current transfer\n");
 	}
@@ -552,7 +562,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		 * in that case this test reads zero and exits the loop.
 		 */
 		regmap_read(dev->map, DW_IC_ENABLE_STATUS, &status);
-		if ((status & 1) == 0)
+		if (!(status & 1))
 			return;
 
 		/*
@@ -635,7 +645,8 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 
 	ret = regmap_read_poll_timeout(dev->map, DW_IC_STATUS, status,
 				       !(status & DW_IC_STATUS_ACTIVITY),
-				       1100, 20000);
+				       DW_IC_BUSY_POLL_TIMEOUT_US,
+				       DW_IC_BUSY_TOTAL_TIMEOUT_US);
 	if (ret) {
 		dev_warn(dev->dev, "timeout waiting for bus ready\n");
 
@@ -699,12 +710,12 @@ int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	tx_fifo_depth = ((param >> 16) & 0xff) + 1;
-	rx_fifo_depth = ((param >> 8)  & 0xff) + 1;
+	tx_fifo_depth = FIELD_GET(DW_IC_FIFO_TX_FIELD, param) + 1;
+	rx_fifo_depth = FIELD_GET(DW_IC_FIFO_RX_FIELD, param) + 1;
 	if (!dev->tx_fifo_depth) {
 		dev->tx_fifo_depth = tx_fifo_depth;
 		dev->rx_fifo_depth = rx_fifo_depth;
-	} else if (tx_fifo_depth >= 2) {
+	} else if (tx_fifo_depth >= DW_IC_FIFO_MIN_DEPTH) {
 		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
 				tx_fifo_depth);
 		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 347843b4f5dd..a699953bf5ae 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -41,6 +41,19 @@
 #define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
 #define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
 
+/*
+ * Register access parameters
+ */
+#define DW_IC_REG_STEP_BYTES			2
+#define DW_IC_REG_WORD_SHIFT			16
+
+/*
+ * FIFO depth configuration
+ */
+#define DW_IC_FIFO_TX_FIELD			GENMASK(23, 16)
+#define DW_IC_FIFO_RX_FIELD			GENMASK(15, 8)
+#define DW_IC_FIFO_MIN_DEPTH			2
+
 /*
  * Registers offset
  */
-- 
2.43.0


