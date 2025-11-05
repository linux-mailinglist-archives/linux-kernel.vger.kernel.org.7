Return-Path: <linux-kernel+bounces-886898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1201FC36F93
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79DB463932
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB2433DEF5;
	Wed,  5 Nov 2025 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejaVTFDi"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DA314B9D
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359543; cv=none; b=KyIVGy+0HsW+VjhGZxdJdWGE+ROlPW9uB+1BV5cX+EliOp1ed7MCbuFwREksfhHQC1S9dZkXGa6IJzVQC9pGPX2MAJdNGnSmKivEGnJ1hXx0KMR34avXa8w2feHqMPGk61mQB9qYKH3t7jobkQ3WooE+f9P9hSlJBQCMt7mQOOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359543; c=relaxed/simple;
	bh=Xk+5OAW2iDloQ8vsn6u4M/2pH1xF1chLoPrc11GjWUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EjXSSoRp5uCrZXD8GWVUMOnIAb/52XrgiVWcd4okDHgMvrZ8Y5XsTDTe7sEuh7J6zuxf97qls/s3aM7L2pEXrhtz3GWopzT7FEnJpyFihd31axr4KE3o1a6rzmBH5oSYYrhxWmmCVCaV9cyyS7BdlTKacWP3sM808D+Npj8pRRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejaVTFDi; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378e8d10494so73056801fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762359539; x=1762964339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkAL7T0BDgsa1zd6a0eYRZUllfTuoqXNMgKEkyRtcpQ=;
        b=ejaVTFDi5XkkmR2RPr8iXJwsNfaVMA0UnfLujTtUo1wZH5TvwYLG3GYfvulpwmiqmO
         P0aCQYPNuXGBwutp3xvvV35XOIUQNkM9ivAJDu/xt4hh3V0LGx48cv5ALRAlb/UtN6gl
         l9+RRZjmraCw5oM6q6UJ6dJR3enwVYgfRoMT0V2rHmjL20gbSlsrwmM90PaUhu7FFIGD
         oYHOF/r6g5IToLV4QRt1CYoNFMxWVpwqK1InSH/ueqw7ADns8JPfg5OwqUjufw8XZ3Zs
         zOsRsBNC6ZwbF6PozM59/3tFYdKlzLFteDwhLXrzD6RjTj57ccXSC7AJWCmURRuMY7zR
         AT9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762359539; x=1762964339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkAL7T0BDgsa1zd6a0eYRZUllfTuoqXNMgKEkyRtcpQ=;
        b=loooxItuTKkitd86L1sj9xrnEOsZDyVW9ZvgWyRaLH2IhZ1DE2rKPpzgofuFM3VcCv
         bjx+bzqDzBW3voEM74VdGWTzLzsbjWS9pYb/BP2H8gazQZ5N3QURfNSrmb9wCJ9CKHNZ
         cQNMGJ2ZosuQ8OXMz1fSs1f4VJudelSIlvdK62R9d2CG3rO0NUGAnT2Jy0x0EcelRVTq
         tQ1fob6hhCZbWU+pVBe++V6Y9N6Y5AXbBfavkuyfFI2t/kMOL2IiC+cs+rgLpF/PrRMD
         qyvsNNGXEhGVOFOuMb69mOJkHrQ3D/IQm2dJ7HL0Mkrp242dKmDXa6CyhRdKTbDoZDQl
         1m5g==
X-Forwarded-Encrypted: i=1; AJvYcCWdgTMBSBabCGz/UCns02ZWg3eaLfRAb12xY0XMn/bzkuE81oYATSEKqwoyU32gJFWFKhi7n2XJHbrMZsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbYbCMuf2jcEncGdJQWo4huyK5BIaED4AD93ugkO8ntVF5jRUc
	/CGSip3RnzyVoGSzo5XgNO/27NIepTpxnzuEOjcF5verfht9tCvGvEoa
X-Gm-Gg: ASbGncsDoIHTGFBKftgr5azwR7/iC1exoye9oJ0l97SSKJdHSOn5MCPt7uK8ljQ7deW
	TKo2UqM3F7CSo+hywIB3mNNciwD2/7UHrHjIiN2QwfBJL+i+AKXo+2dvspa/69gFS6zftxtBvb0
	I5yX/Nm7GzqDGtltodnrxR0c0DvTcN32ZjgZWzqe6aFGoP3S3gtOmreZc9Ik5SDD3IgyvK5Zbb2
	Z78YHmWA92CW01YItzQmk+XoHENhWq660bSvcEnciO6IPt9MWLYGXdpzuxG6B1l63VFSfWEZ0kW
	/YHGtMDp4Ej34q4Ss2AkgJCA+CIX7RbzH3D/C8bWrs17yMS4TSgc24bcHGuRRHg8dtDeVCy5Mli
	1i6zRloBv+C1fRyJNijIsIGLUj3hXw7M0OCkpCJttl/J1KD37kEh2zhJLNIhiyP282OVa+Bo7gd
	oHjRCx99SlvjhcdRneoA==
X-Google-Smtp-Source: AGHT+IEtnKgSnZXYqkMQq4ZUu98tBn28T7uO9YGbqi0n5t0eQapyuWQ7G+IyQ57DiA+L2paV769GLw==
X-Received: by 2002:a05:651c:b08:b0:36e:ca93:62b6 with SMTP id 38308e7fff4ca-37a5140d7c2mr12915881fa.12.1762359538770;
        Wed, 05 Nov 2025 08:18:58 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594492ac7cdsm6258e87.98.2025.11.05.08.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:18:58 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jan Dabros <jsd@semihalf.com>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: designware: Replace magic numbers with named constants
Date: Wed,  5 Nov 2025 19:18:44 +0300
Message-ID: <20251105161845.2535367-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
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

All new constants are documented with clear comments explaining their
purpose. The change makes the code more self-documenting without
altering any functionality.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello maintainers and reviewers,

Fix replaces magic numbers throughout the DesignWare I2C driver with named 
constants to improve code readability and maintainability.

The change introduces constants for register access, timing adjustments, 
timeouts, FIFO parameters, and default values, all properly documented 
with comments.

No functional changes.

Thank you for your consideration.
--
Best regards,
Artem Shimko

 drivers/i2c/busses/i2c-designware-common.c | 121 ++++++++++++++++++---
 1 file changed, 106 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index 5b1e8f74c4ac..1d4dccf9a2ce 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -34,6 +34,91 @@
 
 #include "i2c-designware-core.h"
 
+/*
+ * Byte offset between consecutive 16-bit registers
+ */
+#define DW_IC_REG_STEP_BYTES			2
+
+/*
+ * Bit shift to combine two 16-bit values into 32-bit word
+ */
+#define DW_IC_REG_WORD_SHIFT			16
+
+/*
+ * Default bus capacitance in picofarads
+ */
+#define DW_IC_DEFAULT_BUS_CAPACITANCE_PF	100
+
+/*
+ * Standard HCNT adjustment
+ */
+#define DW_IC_HCNT_ADJUST_STANDARD		3
+
+/*
+ * Number of disable attempts
+ */
+#define DW_IC_DISABLE_TIMEOUT_ATTEMPTS		100
+
+/*
+ * Minimum retry delay in microseconds
+ */
+#define DW_IC_DISABLE_RETRY_DELAY_MIN		25
+
+/*
+ * Maximum retry delay in microseconds
+ */
+#define DW_IC_DISABLE_RETRY_DELAY_MAX		250
+
+/*
+ * Mask to check if controller is active
+ */
+#define DW_IC_ENABLE_STATUS_ACTIVE_MASK		1
+
+/*
+ * Abort poll timeout in microseconds
+ */
+#define DW_IC_ABORT_TIMEOUT_US			10
+
+/*
+ * Total abort timeout in microseconds
+ */
+#define DW_IC_ABORT_TOTAL_TIMEOUT_US		100
+
+/*
+ * Poll interval in microseconds
+ */
+#define DW_IC_BUSY_POLL_TIMEOUT_US		1100
+
+/*
+ * Total timeout in microseconds
+ */
+#define DW_IC_BUSY_TOTAL_TIMEOUT_US		20000
+
+/*
+ * TX FIFO depth bit shift in DW_IC_COMP_PARAM_1
+ */
+#define DW_IC_TX_FIFO_DEPTH_SHIFT		16
+
+/*
+ * RX FIFO depth bit shift in DW_IC_COMP_PARAM_1
+ */
+#define DW_IC_RX_FIFO_DEPTH_SHIFT		8
+
+/*
+ * FIFO depth field mask
+ */
+#define DW_IC_FIFO_DEPTH_MASK			0xff
+
+/*
+ * FIFO depth value offset (0-based to 1-based)
+ */
+#define DW_IC_FIFO_DEPTH_OFFSET			1
+
+/*
+ * Minimum valid FIFO depth
+ */
+#define DW_IC_MIN_FIFO_DEPTH			2
+
 static const char *const abort_sources[] = {
 	[ABRT_7B_ADDR_NOACK] =
 		"slave address not acknowledged (7bit mode)",
@@ -106,7 +191,7 @@ static int dw_reg_read_word(void *context, unsigned int reg, unsigned int *val)
 	struct dw_i2c_dev *dev = context;
 
 	*val = readw(dev->base + reg) |
-		(readw(dev->base + reg + 2) << 16);
+		(readw(dev->base + reg + DW_IC_REG_STEP_BYTES) << DW_IC_REG_WORD_SHIFT);
 
 	return 0;
 }
@@ -116,7 +201,7 @@ static int dw_reg_write_word(void *context, unsigned int reg, unsigned int val)
 	struct dw_i2c_dev *dev = context;
 
 	writew(val, dev->base + reg);
-	writew(val >> 16, dev->base + reg + 2);
+	writew(val >> DW_IC_REG_WORD_SHIFT, dev->base + reg + DW_IC_REG_STEP_BYTES);
 
 	return 0;
 }
@@ -165,7 +250,7 @@ int i2c_dw_init_regmap(struct dw_i2c_dev *dev)
 	if (reg == swab32(DW_IC_COMP_TYPE_VALUE)) {
 		map_cfg.reg_read = dw_reg_read_swab;
 		map_cfg.reg_write = dw_reg_write_swab;
-	} else if (reg == (DW_IC_COMP_TYPE_VALUE & 0x0000ffff)) {
+	} else if (reg == lower_16_bits(DW_IC_COMP_TYPE_VALUE)) {
 		map_cfg.reg_read = dw_reg_read_word;
 		map_cfg.reg_write = dw_reg_write_word;
 	} else if (reg != DW_IC_COMP_TYPE_VALUE) {
@@ -223,7 +308,7 @@ static int i2c_dw_validate_speed(struct dw_i2c_dev *dev)
 
 #define MSCC_ICPU_CFG_TWI_DELAY		0x0
 #define MSCC_ICPU_CFG_TWI_DELAY_ENABLE	BIT(0)
-#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	0x4
+#define MSCC_ICPU_CFG_TWI_SPIKE_FILTER	BIT(2)
 
 static int mscc_twi_set_sda_hold_time(struct dw_i2c_dev *dev)
 {
@@ -384,7 +469,7 @@ int i2c_dw_fw_parse_and_configure(struct dw_i2c_dev *dev)
 	i2c_parse_fw_timings(device, t, false);
 
 	if (device_property_read_u32(device, "snps,bus-capacitance-pf", &dev->bus_capacitance_pF))
-		dev->bus_capacitance_pF = 100;
+		dev->bus_capacitance_pF = DW_IC_DEFAULT_BUS_CAPACITANCE_PF;
 
 	dev->clk_freq_optimized = device_property_read_bool(device, "snps,clk-freq-optimized");
 
@@ -434,7 +519,8 @@ u32 i2c_dw_scl_hcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
 	 * The reason why we need to take into account "tf" here,
 	 * is the same as described in i2c_dw_scl_lcnt().
 	 */
-	return DIV_ROUND_CLOSEST_ULL((u64)ic_clk * (tSYMBOL + tf), MICRO) - 3 + offset;
+	return DIV_ROUND_CLOSEST_ULL((u64)ic_clk * (tSYMBOL + tf), MICRO) -
+				     DW_IC_HCNT_ADJUST_STANDARD + offset;
 }
 
 u32 i2c_dw_scl_lcnt(struct dw_i2c_dev *dev, unsigned int reg, u32 ic_clk,
@@ -512,7 +598,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 	struct i2c_timings *t = &dev->timings;
 	unsigned int raw_intr_stats, ic_stats;
 	unsigned int enable;
-	int timeout = 100;
+	int timeout = DW_IC_DISABLE_TIMEOUT_ATTEMPTS;
 	bool abort_needed;
 	unsigned int status;
 	int ret;
@@ -539,8 +625,9 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 
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
@@ -552,7 +639,7 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		 * in that case this test reads zero and exits the loop.
 		 */
 		regmap_read(dev->map, DW_IC_ENABLE_STATUS, &status);
-		if ((status & 1) == 0)
+		if (!(status & DW_IC_ENABLE_STATUS_ACTIVE_MASK))
 			return;
 
 		/*
@@ -560,7 +647,8 @@ void __i2c_dw_disable(struct dw_i2c_dev *dev)
 		 * transfer supported by the driver (for 400kHz this is
 		 * 25us) as described in the DesignWare I2C databook.
 		 */
-		usleep_range(25, 250);
+		usleep_range(DW_IC_DISABLE_RETRY_DELAY_MIN,
+			     DW_IC_DISABLE_RETRY_DELAY_MAX);
 	} while (timeout--);
 
 	dev_warn(dev->dev, "timeout in disabling adapter\n");
@@ -635,7 +723,8 @@ int i2c_dw_wait_bus_not_busy(struct dw_i2c_dev *dev)
 
 	ret = regmap_read_poll_timeout(dev->map, DW_IC_STATUS, status,
 				       !(status & DW_IC_STATUS_ACTIVITY),
-				       1100, 20000);
+				       DW_IC_BUSY_POLL_TIMEOUT_US,
+				       DW_IC_BUSY_TOTAL_TIMEOUT_US);
 	if (ret) {
 		dev_warn(dev->dev, "timeout waiting for bus ready\n");
 
@@ -699,12 +788,14 @@ int i2c_dw_set_fifo_size(struct dw_i2c_dev *dev)
 	if (ret)
 		return ret;
 
-	tx_fifo_depth = ((param >> 16) & 0xff) + 1;
-	rx_fifo_depth = ((param >> 8)  & 0xff) + 1;
+	tx_fifo_depth = ((param >> DW_IC_TX_FIFO_DEPTH_SHIFT) &
+			 DW_IC_FIFO_DEPTH_MASK) + DW_IC_FIFO_DEPTH_OFFSET;
+	rx_fifo_depth = ((param >> DW_IC_RX_FIFO_DEPTH_SHIFT)  &
+			 DW_IC_FIFO_DEPTH_MASK) + DW_IC_FIFO_DEPTH_OFFSET;
 	if (!dev->tx_fifo_depth) {
 		dev->tx_fifo_depth = tx_fifo_depth;
 		dev->rx_fifo_depth = rx_fifo_depth;
-	} else if (tx_fifo_depth >= 2) {
+	} else if (tx_fifo_depth >= DW_IC_MIN_FIFO_DEPTH) {
 		dev->tx_fifo_depth = min_t(u32, dev->tx_fifo_depth,
 				tx_fifo_depth);
 		dev->rx_fifo_depth = min_t(u32, dev->rx_fifo_depth,
-- 
2.43.0


