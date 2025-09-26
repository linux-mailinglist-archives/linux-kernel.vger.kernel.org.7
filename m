Return-Path: <linux-kernel+bounces-833497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942B1BA2284
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FDF9627388
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62721B0F23;
	Fri, 26 Sep 2025 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2XtaMyQ"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4122920322
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758851170; cv=none; b=GO9Ma0j5LAaelc2sMdrBY5ryj2Gppbk3nLEE9ARGL5Dr0QNqcwJeiRAriZawOsFNcJsNSPRn8bDQIKLapbWKrXNcu2DPorZ+U4bmKhb/XSdUMybZUoGKH05GBjHSy+2SXUWcjCnQoypagGDR1rFq9BFvtd8/5SHu4ikKn4eSb5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758851170; c=relaxed/simple;
	bh=oNAeB4e5WwyfnDVDE3IxWFF4/RiUNvg4pvky6/QqFVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfld8pqqygwKrrNM+rr7/xyRwpCENFuBTXG1MYygdFl4joJYAyfgS4arx2LdBAxmJrSvsuqi4JS36SOAzGbQM6DrL7NPyNb9EA3YrtQ0kddV5iVCtVriXalVQMjPmntWa1llSR/YFenOIKw30i6Nb2JmAjZAh58EDczJvcvhT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2XtaMyQ; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so2066377a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758851168; x=1759455968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gQXgkcYjTebNS08BAcrTSh92Mf+gdkZJbP9GIonE5ao=;
        b=D2XtaMyQlsgpQKMI47i5zr2sX4Djhl+7XpPEOP6ZHreXH7dfF0y3KHYehd+mrghYee
         e6apwOQnLnEP6CyRy18H0s73D92EcpnulU8ghpb1+kr0wAjrPXB63rEHgySFlXbMxk7H
         1e0Xt1QWfWHOQZbWVXVsk6MtFt0BtsATz5K6IvoUCFAsf3Tk9v/3W2YgO33FWxqP+P7d
         b1KsLffwrAX7pV0bZe0N7QjfTk/BlZZzP5HxPHsf0zkA3BFj2Bgj67JwpAkRLhJ2XgjV
         t9pe0gD0hat6d2+qC0nzOBMsTSnkxrD4hc/p1m2BNJqknN4ICi/D55mmoqzjVWGLkfSI
         5TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758851168; x=1759455968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gQXgkcYjTebNS08BAcrTSh92Mf+gdkZJbP9GIonE5ao=;
        b=Ke4ZupZnStPbNHH1hUkNG02X9aoLXNowunFPcImlQkcEhgEWhvff9uYKpaa8IJb8gd
         MPZvo+mURB6EdZGRH826P7FBQ3TnrNETQSkoLblBoj/s2QpNEqRR3IZQobIax1G2lpdL
         8/rTlsNNTc1DW55Fxv1Rds+f2SokhgNGO2DK7KeTyLyByw0GDVqBIZ1Ext4M6/3Feqm4
         CVFURGsknlZ8nAgjkVv3e+8PAVqGwBIZUmqVH7e0tgASqgF5gh56V+6UjkPYedcrTmFz
         A9mzhalXAOYLmsbRz4dStRSAcpj0AR4K8rraYdmk0ZvHILlDMMzxwqJtDOZzBkgd0n/o
         mPbA==
X-Forwarded-Encrypted: i=1; AJvYcCWuvaxgr4qftEaiKHsQ6ViDSbGC9wkG6l5J0Ap9U1GueKadNyPK32PjN5AF6O7AZ12BDRrnKMc3RxCbljU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiZ7uJpKkBeLHags7epTPO/A6i1HID7oOsTrct74DiWD0nwJiH
	+k0d/e9Xq/wZzLL4ILR3NHe4d5Awp67rqltx+5cGr36PRy9d4AVZFQfO
X-Gm-Gg: ASbGnctydfM/EuVN/DKxGtEhvI+tCJTVktoWtY/F2+TwYwnRmD6pkPBUDXdtWWfRTUS
	78yVCGJHFbNTEZ3jVF4dyZ1wUAuiAio7E2KEuWbgLNKA3+iHJbiaTVs8h/jG9xQdl3nTq+G2YUg
	WWp7hCFQhzwmoGjdQqFYsn+HtVztt3hmYDlbzCyMIaB1FG3SEXn1+/6ujCeInoKdhTI3g90UXjr
	LFmeJ1BcH0gqJrDUZDCDoaMDuiU0TduCvT58mmjNOZ2/uBksWvhO+oYCMhvLoNZ5YoFVho5/uuS
	8sWbGfIaAFmGrcmlYLD3wz1JjEVDMDt5i/yaSGzdSYRrkFG6cj8dnuLfBA8P0a8g5W0chdBzOJs
	jpnNNFq7uP+FdZM2bf0akT3CxbBd10QklGyPgmDqzYI4AZWxiVmkbY4gHelWxU6iiZ8fu
X-Google-Smtp-Source: AGHT+IGVUpxNwK7HMjTCb3KDiJvXwoRUb4l/EP8cEdjREpO8sRfEQNZyXbKGT3vf4rSU0e8P+gLEZQ==
X-Received: by 2002:a17:90b:4aca:b0:32e:36f4:6fdc with SMTP id 98e67ed59e1d1-3342a22bf5amr5802516a91.4.1758851168371;
        Thu, 25 Sep 2025 18:46:08 -0700 (PDT)
Received: from JF.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-335277eb10bsm1116423a91.2.2025.09.25.18.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 18:46:07 -0700 (PDT)
From: Jeff Lin <jefflin994697@gmail.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: cedricjustine.encarnacion@analog.com,
	ninad@linux.ibm.com,
	andriy.shevchenko@linux.intel.com,
	johnerasmusmari.geronimo@analog.com,
	Mariel.Tinaco@analog.com,
	jbrunet@baylibre.com,
	kimseer.paller@analog.com,
	leo.yang.sy0@gmail.com,
	nuno.sa@analog.com,
	chiang.brian@inventec.com,
	gregkh@linuxfoundation.org,
	grantpeltier93@gmail.com,
	peterz@infradead.org,
	william@wkennington.com,
	krzysztof.kozlowski@linaro.org,
	tzungbi@kernel.org,
	thorsten.blum@linux.dev,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Lin <jefflin994697@gmail.com>
Subject: [PATCH] drivers/hwmon/pmbus: Add support for raa229141 in isl68137
Date: Fri, 26 Sep 2025 09:45:52 +0800
Message-Id: <20250926014552.1625950-1-jefflin994697@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In chip RAA229141 there exist ISYS pin which can report the current data
for the device connected to this chip through this pin by routed by Direct
Memory Access(DMA) command. To read the data in ISYS pin, we have to set
the DMA address to 0xC5 and then read the DMA data from 0xC7. And then use
the Direct read format with 10mA per LSB to transfer the data in 0xC7.
And for ISYS input pin, the DMA address is 0xE0D3 and for ISYS output pin,
the DMA address is 0xEE42.

Signed-off-by: Jeff Lin <jefflin994697@gmail.com>
---
 drivers/hwmon/pmbus/Kconfig      | 10 +++++
 drivers/hwmon/pmbus/isl68137.c   | 65 ++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/pmbus.h      | 11 ++++++
 drivers/hwmon/pmbus/pmbus_core.c | 20 ++++++++++
 4 files changed, 106 insertions(+)

diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
index 55e492452ce8..a14393d41412 100644
--- a/drivers/hwmon/pmbus/Kconfig
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -211,6 +211,16 @@ config SENSORS_ISL68137
 	  This driver can also be built as a module. If so, the module will
 	  be called isl68137.
 
+config SENSORS_RAA229141
+	bool "Renesas RAA229141 Supply"
+	default n
+	help
+	  If you say yes here you get the support for Renesas RAA229140 and
+	  RAA229141.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called raa229141.
+
 config SENSORS_LM25066
 	tristate "National Semiconductor LM25066 and compatibles"
 	help
diff --git a/drivers/hwmon/pmbus/isl68137.c b/drivers/hwmon/pmbus/isl68137.c
index c52c55d2e7f4..04a582ba9416 100644
--- a/drivers/hwmon/pmbus/isl68137.c
+++ b/drivers/hwmon/pmbus/isl68137.c
@@ -63,6 +63,9 @@ enum chips {
 	raa228228,
 	raa229001,
 	raa229004,
++#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
++	raa229141,
++#endif /* CONFIG_SENSORS_RAA229141 */
 	raa229621,
 };
 
@@ -71,6 +74,9 @@ enum variants {
 	raa_dmpvr2_1rail,
 	raa_dmpvr2_2rail,
 	raa_dmpvr2_2rail_nontc,
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	raa_dmpvr2_2rail_isys,
+#endif /* CONFIG_SENSORS_RAA229141 */
 	raa_dmpvr2_3rail,
 	raa_dmpvr2_hv,
 };
@@ -174,6 +180,34 @@ static const struct attribute_group *isl68137_attribute_groups[] = {
 	NULL,
 };
 
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+#define RAA_READ_DMA_DATA	0xc5
+#define RAA_WRITE_DMA_ADDRESS 0xc7
+
+/* DMA address for input and output */
+static const unsigned char dma_address_in[] = { 0xD3, 0xE0 };
+static const unsigned char dma_address_out[] = { 0x42, 0xEE };
+int read_isys_route_dma(struct i2c_client *client, const char *addr)
+{
+	int ret;
+
+	ret = i2c_smbus_write_i2c_block_data(client, RAA_WRITE_DMA_ADDRESS, 2, addr);
+	if (ret < 0) {
+		dev_err(&client->dev, "Set DMA address failed for address 0x%02x 0x%02x\n",
+			addr[0], addr[1]);
+		return ret;
+	}
+	// DIRECT ISYS format 10mA/LSB
+	u8 buf[2];
+
+	ret = i2c_smbus_read_i2c_block_data(client, RAA_READ_DMA_DATA, 2, buf);
+	if (ret < 0)
+		return ret;
+	u16 value = ((u16)buf[1]<<8) | buf[0];
+	return value;
+};
+#endif /* CONFIG_SENSORS_RAA229141 */
+
 static int raa_dmpvr2_read_word_data(struct i2c_client *client, int page,
 				     int phase, int reg)
 {
@@ -183,6 +217,14 @@ static int raa_dmpvr2_read_word_data(struct i2c_client *client, int page,
 	u64 temp;
 
 	switch (reg) {
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	case PMBUS_VIRT_READ_ISYSIN:
+		ret = read_isys_route_dma(client, dma_address_in);
+		break;
+	case PMBUS_VIRT_READ_ISYSOUT:
+		ret = read_isys_route_dma(client, dma_address_out);
+		break;
+#endif /* CONFIG_SENSORS_RAA229141 */
 	case PMBUS_VIRT_READ_VMON:
 		ret = pmbus_read_word_data(client, page, phase,
 					   RAA_DMPVR2_READ_VMON);
@@ -253,6 +295,12 @@ static struct pmbus_driver_info raa_dmpvr_info = {
 	.format[PSC_CURRENT_OUT] = direct,
 	.format[PSC_POWER] = direct,
 	.format[PSC_TEMPERATURE] = direct,
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	.format[PSC_ISYS] = direct,
+	.m[PSC_ISYS] = 1,
+	.b[PSC_ISYS] = 0,
+	.R[PSC_ISYS] = 2,
+#endif /* CONFIG_SENSORS_RAA229141 */
 	.m[PSC_VOLTAGE_IN] = 1,
 	.b[PSC_VOLTAGE_IN] = 0,
 	.R[PSC_VOLTAGE_IN] = 2,
@@ -398,6 +446,20 @@ static int isl68137_probe(struct i2c_client *client)
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
 		break;
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	case raa_dmpvr2_2rail_isys:
+		info->format[PSC_VOLTAGE_IN] = linear,
+		info->format[PSC_VOLTAGE_OUT] = linear,
+		info->format[PSC_CURRENT_IN] = linear;
+		info->format[PSC_CURRENT_OUT] = linear;
+		info->format[PSC_POWER] = linear;
+		info->format[PSC_TEMPERATURE] = linear;
+		info->func[0] |= PMBUS_HAVE_ISYSIN;
+		info->func[0] |= PMBUS_HAVE_ISYSOUT;
+		info->pages = 2;
+		info->read_word_data = raa_dmpvr2_read_word_data;
+		break;
+#endif /* CONFIG_SENSORS_RAA229141 */
 	case raa_dmpvr2_3rail:
 		info->read_word_data = raa_dmpvr2_read_word_data;
 		info->write_word_data = raa_dmpvr2_write_word_data;
@@ -466,6 +528,9 @@ static const struct i2c_device_id raa_dmpvr_id[] = {
 	{"raa228228", raa_dmpvr2_2rail_nontc},
 	{"raa229001", raa_dmpvr2_2rail},
 	{"raa229004", raa_dmpvr2_2rail},
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	{"raa229141", raa_dmpvr2_2rail_isys},
+#endif /* CONFIG_SENSORS_RAA229141 */
 	{"raa229621", raa_dmpvr2_2rail},
 	{}
 };
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d2e9bfb5320f..ec5a4b9286cc 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -236,6 +236,10 @@ enum pmbus_regs {
 	PMBUS_VIRT_CURR_SAMPLES,
 	PMBUS_VIRT_POWER_SAMPLES,
 	PMBUS_VIRT_TEMP_SAMPLES,
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	PMBUS_VIRT_READ_ISYSIN,
+	PMBUS_VIRT_READ_ISYSOUT,
+#endif /* CONFIG_SENSORS_RAA229141 */
 };
 
 /*
@@ -381,6 +385,9 @@ enum pmbus_sensor_classes {
 	PSC_TEMPERATURE,
 	PSC_FAN,
 	PSC_PWM,
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	PSC_ISYS,
+#endif /* CONFIG_SENSORS_RAA229141 */
 	PSC_NUM_CLASSES		/* Number of power sensor classes */
 };
 
@@ -411,6 +418,10 @@ enum pmbus_sensor_classes {
 #define PMBUS_HAVE_PWM12	BIT(20)
 #define PMBUS_HAVE_PWM34	BIT(21)
 #define PMBUS_HAVE_SAMPLES	BIT(22)
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+#define PMBUS_HAVE_ISYSIN	BIT(23)
+#define PMBUS_HAVE_ISYSOUT	BIT(24)
+#endif /* CONFIG_SENSORS_RAA229141 */
 
 #define PMBUS_PHASE_VIRTUAL	BIT(30)	/* Phases on this page are virtual */
 #define PMBUS_PAGE_VIRTUAL	BIT(31)	/* Page is virtual */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index be6d05def115..88344c088f6d 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1929,6 +1929,20 @@ static const struct pmbus_sensor_attr current_attributes[] = {
 		.gbit = PB_STATUS_IOUT_OC,
 		.limit = iout_limit_attrs,
 		.nlimit = ARRAY_SIZE(iout_limit_attrs),
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	}, {
+		.reg = PMBUS_VIRT_READ_ISYSIN,
+		.class = PSC_ISYS,
+		.label = "isysin",
+		.paged = true,
+		.func = PMBUS_HAVE_ISYSIN,
+	}, {
+		.reg = PMBUS_VIRT_READ_ISYSOUT,
+		.class = PSC_ISYS,
+		.label = "isysout",
+		.paged = true,
+		.func = PMBUS_HAVE_ISYSOUT,
+#endif /* CONFIG_SENSORS_RAA229141 */
 	}
 };
 
@@ -2501,6 +2515,12 @@ static const struct pmbus_class_attr_map class_attr_map[] = {
 		.class = PSC_TEMPERATURE,
 		.attr = temp_attributes,
 		.nattr = ARRAY_SIZE(temp_attributes),
+#if IS_ENABLED(CONFIG_SENSORS_RAA229141)
+	}, {
+		.class = PSC_ISYS,
+		.attr = current_attributes,
+		.nattr = ARRAY_SIZE(current_attributes),
+#endif /* CONFIG_SENSORS_RAA229141 */
 	}
 };
 
-- 
2.34.1


