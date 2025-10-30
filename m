Return-Path: <linux-kernel+bounces-878671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F74AC21376
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 638864ED9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932C277C86;
	Thu, 30 Oct 2025 16:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVggRXCH"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D81323909F
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842102; cv=none; b=WSwz9iS23WpWhIftA7xiMXY4QJm6/Ud+DTM0P9vM4H5oLYbENiaPjEDG6yb7mvI6DNKO2evktnSVAnRimF35C+C0DwcKXQ2kAbpUaEO+H8/DZ7z+0p0l8zdpw2LIksgMDdIdqVl1e5+ZjclkaC2EubXelfcP9682cnLqlJEATAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842102; c=relaxed/simple;
	bh=ONImBZWw5nyU1heMBzbmDNX/cQraQ9j5SLD3dWPIMpc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHLzGq/1Qr/0dwI+8G9zeSPusHTo5whFTEVyapYX/L5HfzvJ2pe3Wt6Dmnu+G9rcoBUcWYQde/I71xJFpBT8P4T+P0uLWNCP1+/fyNvHBdt2rcmBuB8N6KdD8NomJ/7sCqHe2BnSRi5dDsUxyyMGzsmtOtQuYqE3nILFvGOIWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVggRXCH; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-794e300e20dso1984959b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761842100; x=1762446900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOQeHWHZcjpD60qsABekeeTj7ecagfdnLWsqsZtwAlc=;
        b=nVggRXCHzhNv1wA9vDsaVP/b6UjKYWv9+T/ZAkGhE9cOLWVbH0+qyViVSyREskpAsU
         SFRDMxATmXFjnTlryMJ/FLPXKkigmbNObYIbYiADz5fC8y+IYiQmLepBQHtbifjlCf/5
         8h1az+ukrICbNiTAtmlOKcvKD8XVKu7bWLznQhuq1mYf22dVB59Y60QrJYepVSfy8BwS
         m0qq3W3UVjY1LiffWzu7UEIBF035L04RCR3Y0zlXaBq+GMDQFwqUYePWThBswzcEV5DS
         XJ25LhlxlChOr32I4UIPnScR6PvhREEwSAl5J53wDa0QNRcvNtDNuBXk7Qmnm0bJm9OX
         vZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761842100; x=1762446900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOQeHWHZcjpD60qsABekeeTj7ecagfdnLWsqsZtwAlc=;
        b=Z9NhefveZv7RWG2nvRbMgpgfucxlpXIUSMg9yQkYAYh3LCLn9JNT7mjH06ubHhr8YH
         WYvqrWBzDC37bitERuqFahXX7mYUPwPyEwgCsOh5D4z4FwLxuy5T16UVRGj6NQZSG/wQ
         Ab+YREis8sgFIcLsYcA2XJZNLl/JO8i+Nzp4alf2jEBYZeaaww4kyUymd/ExmVAWvoPl
         06UjaBf0L1N3d3n9A2e0nRV6rxvIJZzqF9EPwL5uDdZKeoLd77bRKgor3ONAc2qNCSDa
         qnpHe5ZhJCTrcL3ODCXW1F2yUqCww0iZABz4OL9Dqz0IvpkjlAj3Xns6PO59D1lZbl3m
         /M/A==
X-Forwarded-Encrypted: i=1; AJvYcCVGQBsOUfG0nFNZeXL6LVrGPZXJ1w/kCtjcWp1EludU5GbadKnE2Gzi9tX/yz9kM4eIT4iOBGLtzHenVPo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/esVuf9ECYyNGsSSsgrVBv9Rx6yFCiZ/rovtgAy5UAlExj1jb
	cNMLwilRCcBhOBDsElejn4CuD0Cyppo2/ICIYUKzmDDF4MSiDEqHPz2F
X-Gm-Gg: ASbGncuiE+ylWgJQyiEia3Xfy7F7pgI6qTE8c2Wur2rildSpUeFxBsaBhqVk55BxmnW
	Oemu7M9rOn8RDE78GkfuV8M+z09CXXzfevzKHy6g7KyEPtDD1GYjBYr2ghCKhHbEO3rFWQWZAqm
	1WKbSuqDydWFWSSyhLMAAeQ/WUdff9Wg8pCw+zfdjHTJwbUWrVA9vnmHuYQyuLbov/0CYacE++W
	IYv1LaiJhfEqFpp5Icfb+mFY0V3g4sDeO4MADErgD/J2dkpRX7XmYglXbi9eyKfiXInXqu3GAJj
	RGVazjfUiNLCmVrRdiTe2OoS0l1jHVhZ7+dgrMpfJ/ut+qGzC0mw1KyTgB509Cly8rxNpX7iuOF
	9/muetmwkoCm2nWyvB8GCqt28DRdqaTpi2q0VoB0jHoJkSqYiN9Jfehx4AZHx2l11YowuxjCkX4
	a7BvXcovsFG1sNWE7X6l8YTot6SIbxlNOyYEG0460F3pdhIt4wEgb1ZdhslVmwMkslJD3+Y7fgV
	rHjBhtvSXC5NzA9EZzjd3vW74dJt3/sTURDL0Lwrbp+2qjwxKGw0G6+xQ==
X-Google-Smtp-Source: AGHT+IFl2fVZkH8NbGTsVKHQ51a3P5UWfIMVf1u2rA58oBLfzo5tdEguq3dN5wzS6GkAl0wZLOLCcQ==
X-Received: by 2002:a17:902:e545:b0:267:99be:628e with SMTP id d9443c01a7336-294ed072557mr47266685ad.2.1761842099491;
        Thu, 30 Oct 2025 09:34:59 -0700 (PDT)
Received: from ajianan-Latitude-5591.. ([2402:e280:21d3:2:339d:c9c4:e069:47f7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e429d9sm190932845ad.100.2025.10.30.09.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:34:59 -0700 (PDT)
From: Ajith Anandhan <ajithanandhan0406@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ajith Anandhan <ajithanandhan0406@gmail.com>
Subject: [RFC PATCH 2/3] iio: adc: Add support for TI ADS1120
Date: Thu, 30 Oct 2025 22:04:10 +0530
Message-Id: <20251030163411.236672-3-ajithanandhan0406@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
References: <20251030163411.236672-1-ajithanandhan0406@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for the Texas Instruments ADS1120, a precision 16-bit
analog-to-digital converter with an SPI interface.

The driver provides:
- 4 single-ended voltage input channels
- Programmable gain amplifier (1 to 128)
- Configurable data rates (20 to 1000 SPS)
- Single-shot conversion mode

Link: https://www.ti.com/lit/gpn/ads1120
Signed-off-by: Ajith Anandhan <ajithanandhan0406@gmail.com>
---
 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ti-ads1120.c | 509 +++++++++++++++++++++++++++++++++++
 3 files changed, 520 insertions(+)
 create mode 100644 drivers/iio/adc/ti-ads1120.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e683..afb7895dd 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1655,6 +1655,16 @@ config TI_ADS1119
          This driver can also be built as a module. If so, the module will be
          called ti-ads1119.
 
+config TI_ADS1120
+	tristate "Texas Instruments ADS1120"
+	depends on SPI
+	help
+	  Say yes here to build support for Texas Instruments ADS1120
+	  4-channel, 2kSPS, 16-bit delta-sigma ADC.
+
+	  This driver can also be built as module. If so, the module
+	  will be called ti-ads1120.
+
 config TI_ADS124S08
 	tristate "Texas Instruments ADS124S08"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d008f78dc..49c56b459 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -144,6 +144,7 @@ obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
 obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
 obj-$(CONFIG_TI_ADS1100) += ti-ads1100.o
 obj-$(CONFIG_TI_ADS1119) += ti-ads1119.o
+obj-$(CONFIG_TI_ADS1120) += ti-ads1120.o
 obj-$(CONFIG_TI_ADS124S08) += ti-ads124s08.o
 obj-$(CONFIG_TI_ADS1298) += ti-ads1298.o
 obj-$(CONFIG_TI_ADS131E08) += ti-ads131e08.o
diff --git a/drivers/iio/adc/ti-ads1120.c b/drivers/iio/adc/ti-ads1120.c
new file mode 100644
index 000000000..07a6fb309
--- /dev/null
+++ b/drivers/iio/adc/ti-ads1120.c
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI ADS1120 4-channel, 2kSPS, 16-bit delta-sigma ADC
+ *
+ * Datasheet: https://www.ti.com/lit/gpn/ads1120
+ *
+ * Copyright (C) 2025 Ajith Anandhan <ajithanandhan0406@gmail.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/mutex.h>
+#include <linux/spi/spi.h>
+
+#include <linux/iio/iio.h>
+
+/* Commands */
+#define ADS1120_CMD_RESET		0x06
+#define ADS1120_CMD_START		0x08
+#define ADS1120_CMD_PWRDWN		0x02
+#define ADS1120_CMD_RDATA		0x10
+#define ADS1120_CMD_RREG		0x20
+#define ADS1120_CMD_WREG		0x40
+
+/* Registers */
+#define ADS1120_REG_CONFIG0		0x00
+#define ADS1120_REG_CONFIG1		0x01
+#define ADS1120_REG_CONFIG2		0x02
+#define ADS1120_REG_CONFIG3		0x03
+
+/* Config Register 0 bit definitions */
+#define ADS1120_MUX_MASK		GENMASK(7, 4)
+#define ADS1120_MUX_AIN0_AVSS		0x80
+#define ADS1120_MUX_AIN1_AVSS		0x90
+#define ADS1120_MUX_AIN2_AVSS		0xa0
+#define ADS1120_MUX_AIN3_AVSS		0xb0
+
+#define ADS1120_GAIN_MASK		GENMASK(3, 1)
+#define ADS1120_GAIN_1			0x00
+#define ADS1120_GAIN_2			0x02
+#define ADS1120_GAIN_4			0x04
+#define ADS1120_GAIN_8			0x06
+#define ADS1120_GAIN_16			0x08
+#define ADS1120_GAIN_32			0x0a
+#define ADS1120_GAIN_64			0x0c
+#define ADS1120_GAIN_128		0x0e
+
+#define ADS1120_PGA_BYPASS		BIT(0)
+
+/* Config Register 1 bit definitions */
+#define ADS1120_DR_MASK			GENMASK(7, 5)
+#define ADS1120_DR_20SPS		0x00
+#define ADS1120_DR_45SPS		0x20
+#define ADS1120_DR_90SPS		0x40
+#define ADS1120_DR_175SPS		0x60
+#define ADS1120_DR_330SPS		0x80
+#define ADS1120_DR_600SPS		0xa0
+#define ADS1120_DR_1000SPS		0xc0
+
+#define ADS1120_MODE_MASK		GENMASK(4, 3)
+#define ADS1120_MODE_NORMAL		0x00
+
+#define ADS1120_CM_SINGLE		0x00
+#define ADS1120_CM_CONTINUOUS		BIT(2)
+
+#define ADS1120_TS_EN			BIT(1)
+#define ADS1120_BCS_EN			BIT(0)
+
+/* Config Register 2 bit definitions */
+#define ADS1120_VREF_MASK		GENMASK(7, 6)
+#define ADS1120_VREF_INTERNAL		0x00
+#define ADS1120_VREF_EXT_REFP0		0x40
+#define ADS1120_VREF_EXT_AIN0		0x80
+#define ADS1120_VREF_AVDD		0xc0
+
+#define ADS1120_REJECT_MASK		GENMASK(5, 4)
+#define ADS1120_REJECT_OFF		0x00
+#define ADS1120_REJECT_50_60		0x10
+#define ADS1120_REJECT_50		0x20
+#define ADS1120_REJECT_60		0x30
+
+#define ADS1120_PSW_EN			BIT(3)
+
+#define ADS1120_IDAC_MASK		GENMASK(2, 0)
+
+/* Config Register 3 bit definitions */
+#define ADS1120_IDAC1_MASK		GENMASK(7, 5)
+#define ADS1120_IDAC2_MASK		GENMASK(4, 2)
+#define ADS1120_DRDYM_EN		BIT(1)
+
+/* Default configuration values */
+#define ADS1120_DEFAULT_GAIN		1
+#define ADS1120_DEFAULT_DATARATE	175
+
+struct ads1120_state {
+	struct spi_device	*spi;
+	struct mutex		lock;
+	/*
+	 * Used to correctly align data.
+	 * Ensure natural alignment for potential future timestamp support.
+	 */
+	u8 data[4] __aligned(IIO_DMA_MINALIGN);
+
+	u8 config[4];
+	int current_channel;
+	int gain;
+	int datarate;
+	int conv_time_ms;
+};
+
+struct ads1120_datarate {
+	int rate;
+	int conv_time_ms;
+	u8 reg_value;
+};
+
+static const struct ads1120_datarate ads1120_datarates[] = {
+	{ 20,   51, ADS1120_DR_20SPS },
+	{ 45,   24, ADS1120_DR_45SPS },
+	{ 90,   13, ADS1120_DR_90SPS },
+	{ 175,   7, ADS1120_DR_175SPS },
+	{ 330,   4, ADS1120_DR_330SPS },
+	{ 600,   3, ADS1120_DR_600SPS },
+	{ 1000,  2, ADS1120_DR_1000SPS },
+};
+
+static const int ads1120_gain_values[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
+
+#define ADS1120_CHANNEL(index)					\
+{								\
+	.type = IIO_VOLTAGE,					\
+	.indexed = 1,						\
+	.channel = index,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
+}
+
+static const struct iio_chan_spec ads1120_channels[] = {
+	ADS1120_CHANNEL(0),
+	ADS1120_CHANNEL(1),
+	ADS1120_CHANNEL(2),
+	ADS1120_CHANNEL(3),
+};
+
+static int ads1120_write_cmd(struct ads1120_state *st, u8 cmd)
+{
+	st->data[0] = cmd;
+	return spi_write(st->spi, st->data, 1);
+}
+
+static int ads1120_write_reg(struct ads1120_state *st, u8 reg, u8 value)
+{
+	u8 buf[2];
+
+	if (reg > ADS1120_REG_CONFIG3)
+		return -EINVAL;
+
+	buf[0] = ADS1120_CMD_WREG | (reg << 2);
+	buf[1] = value;
+
+	return spi_write(st->spi, buf, 2);
+}
+
+static int ads1120_reset(struct ads1120_state *st)
+{
+	int ret;
+
+	ret = ads1120_write_cmd(st, ADS1120_CMD_RESET);
+	if (ret)
+		return ret;
+
+	/*
+	 * Datasheet specifies reset takes 50us + 32 * t(CLK)
+	 * where t(CLK) = 1/4.096MHz. Use 200us to be safe.
+	 */
+	usleep_range(200, 300);
+
+	return 0;
+}
+
+static int ads1120_set_channel(struct ads1120_state *st, int channel)
+{
+	u8 mux_val;
+	u8 config0;
+
+	if (channel < 0 || channel > 3)
+		return -EINVAL;
+
+	/* Map channel to AINx/AVSS single-ended input */
+	mux_val = ADS1120_MUX_AIN0_AVSS + (channel << 4);
+
+	config0 = (st->config[0] & ~ADS1120_MUX_MASK) | mux_val;
+	st->config[0] = config0;
+
+	return ads1120_write_reg(st, ADS1120_REG_CONFIG0, config0);
+}
+
+static int ads1120_set_gain(struct ads1120_state *st, int gain_val)
+{
+	u8 gain_bits;
+	u8 config0;
+	int i;
+
+	/* Find gain in supported values */
+	for (i = 0; i < ARRAY_SIZE(ads1120_gain_values); i++) {
+		if (ads1120_gain_values[i] == gain_val) {
+			gain_bits = i << 1;
+			goto found;
+		}
+	}
+	return -EINVAL;
+
+found:
+	config0 = (st->config[0] & ~ADS1120_GAIN_MASK) | gain_bits;
+	st->config[0] = config0;
+	st->gain = gain_val;
+
+	return ads1120_write_reg(st, ADS1120_REG_CONFIG0, config0);
+}
+
+static int ads1120_set_datarate(struct ads1120_state *st, int rate)
+{
+	u8 config1;
+	int i;
+
+	/* Find data rate in supported values */
+	for (i = 0; i < ARRAY_SIZE(ads1120_datarates); i++) {
+		if (ads1120_datarates[i].rate == rate) {
+			config1 = (st->config[1] & ~ADS1120_DR_MASK) |
+				  ads1120_datarates[i].reg_value;
+			st->config[1] = config1;
+			st->datarate = rate;
+			st->conv_time_ms = ads1120_datarates[i].conv_time_ms;
+
+			return ads1120_write_reg(st, ADS1120_REG_CONFIG1,
+						 config1);
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int ads1120_read_raw_adc(struct ads1120_state *st, int *val)
+{
+	u8 rx_buf[4];
+	u8 tx_buf[4] = { ADS1120_CMD_RDATA, 0xff, 0xff, 0xff };
+	int ret;
+	struct spi_transfer xfer = {
+		.tx_buf = tx_buf,
+		.rx_buf = rx_buf,
+		.len = 4,
+	};
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	/*
+	 * Data format: 16-bit two's complement MSB first
+	 * rx_buf[0] is echo of command
+	 * rx_buf[1] is MSB of data
+	 * rx_buf[2] is LSB of data
+	 */
+	*val = (s16)((rx_buf[1] << 8) | rx_buf[2]);
+
+	return 0;
+}
+
+static int ads1120_read_measurement(struct ads1120_state *st, int channel,
+				    int *val)
+{
+	int ret;
+
+	ret = ads1120_set_channel(st, channel);
+	if (ret)
+		return ret;
+
+	/* Start single-shot conversion */
+	ret = ads1120_write_cmd(st, ADS1120_CMD_START);
+	if (ret)
+		return ret;
+
+	/* Wait for conversion to complete */
+	msleep(st->conv_time_ms);
+
+	/* Read the result */
+	ret = ads1120_read_raw_adc(st, val);
+	if (ret)
+		return ret;
+
+	st->current_channel = channel;
+
+	return 0;
+}
+
+static int ads1120_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int *val, int *val2, long mask)
+{
+	struct ads1120_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = ads1120_read_measurement(st, chan->channel, val);
+		mutex_unlock(&st->lock);
+		if (ret)
+			return ret;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->gain;
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->datarate;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1120_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long mask)
+{
+	struct ads1120_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		mutex_lock(&st->lock);
+		ret = ads1120_set_gain(st, val);
+		mutex_unlock(&st->lock);
+		return ret;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		mutex_lock(&st->lock);
+		ret = ads1120_set_datarate(st, val);
+		mutex_unlock(&st->lock);
+		return ret;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ads1120_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	static const int datarates[] = { 20, 45, 90, 175, 330, 600, 1000 };
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = ads1120_gain_values;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(ads1120_gain_values);
+		return IIO_AVAIL_LIST;
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = datarates;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(datarates);
+		return IIO_AVAIL_LIST;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ads1120_info = {
+	.read_raw = ads1120_read_raw,
+	.write_raw = ads1120_write_raw,
+	.read_avail = ads1120_read_avail,
+};
+
+static int ads1120_init(struct ads1120_state *st)
+{
+	int ret;
+
+	/* Reset device to default state */
+	ret = ads1120_reset(st);
+	if (ret) {
+		dev_err(&st->spi->dev, "Failed to reset device\n");
+		return ret;
+	}
+
+	/*
+	 * Configure Register 0:
+	 * - Input MUX: AIN0/AVSS (updated per channel read)
+	 * - Gain: 1
+	 * - PGA bypassed (lower power consumption)
+	 */
+	st->config[0] = ADS1120_MUX_AIN0_AVSS | ADS1120_GAIN_1 |
+			ADS1120_PGA_BYPASS;
+	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG0, st->config[0]);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 1:
+	 * - Data rate: 175 SPS
+	 * - Mode: Normal
+	 * - Conversion mode: Single-shot
+	 * - Temperature sensor: Disabled
+	 * - Burnout current: Disabled
+	 */
+	st->config[1] = ADS1120_DR_175SPS | ADS1120_MODE_NORMAL |
+			ADS1120_CM_SINGLE;
+	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG1, st->config[1]);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 2:
+	 * - Voltage reference: AVDD
+	 * - 50/60Hz rejection: Off
+	 * - Power switch: Off
+	 * - IDAC: Off
+	 */
+	st->config[2] = ADS1120_VREF_AVDD | ADS1120_REJECT_OFF;
+	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG2, st->config[2]);
+	if (ret)
+		return ret;
+
+	/*
+	 * Configure Register 3:
+	 * - IDAC1: Disabled
+	 * - IDAC2: Disabled
+	 * - DRDY mode: DOUT/DRDY pin behavior
+	 */
+	st->config[3] = ADS1120_DRDYM_EN;
+	ret = ads1120_write_reg(st, ADS1120_REG_CONFIG3, st->config[3]);
+	if (ret)
+		return ret;
+
+	/* Set default operating parameters */
+	st->gain = ADS1120_DEFAULT_GAIN;
+	st->datarate = ADS1120_DEFAULT_DATARATE;
+	st->conv_time_ms = 7; /* For 175 SPS */
+	st->current_channel = -1;
+
+	return 0;
+}
+
+static int ads1120_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ads1120_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	mutex_init(&st->lock);
+
+	indio_dev->name = "ads1120";
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ads1120_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ads1120_channels);
+	indio_dev->info = &ads1120_info;
+
+	ret = ads1120_init(st);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to initialize device: %d\n", ret);
+		return ret;
+	}
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ads1120_of_match[] = {
+	{ .compatible = "ti,ads1120" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ads1120_of_match);
+
+static const struct spi_device_id ads1120_id[] = {
+	{ "ads1120" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ads1120_id);
+
+static struct spi_driver ads1120_driver = {
+	.driver = {
+		.name = "ads1120",
+		.of_match_table = ads1120_of_match,
+	},
+	.probe = ads1120_probe,
+	.id_table = ads1120_id,
+};
+module_spi_driver(ads1120_driver);
+
+MODULE_AUTHOR("Ajith Anandhan  <ajithanandhan0406@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADS1120 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


