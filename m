Return-Path: <linux-kernel+bounces-825732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6937B8CAFA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B71B239E5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4092F83B6;
	Sat, 20 Sep 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b="W4FlIpmT"
Received: from smtp1.iitb.ac.in (smtpd9.iitb.ac.in [103.21.126.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B207E212566
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.21.126.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380549; cv=none; b=gAq89ZXV/oZZvvrz+z1DSayzkgLqc76L9jDHSus02Nryt3mGiWKE1uzGvlLgAqTwemY1pAqO2gIE2JnL2C11tB+To2zqxc+Qw6V8GMS8gqXYLiprCcVnxopNkVAZSKOZFuM+F4AMtLJr1jHundeMQXdhFzT+yVKBt6thK63Rv4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380549; c=relaxed/simple;
	bh=lBULx7uqbmscImIjfEPqSce/EEelZHFj7L5TbmJLI7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGFrDTZU94hE2OVuBhjYrjACaagS06tVkl5/ug633iPNhW26loRcx9GCte7JWLZeu/148NtJ99lrpVyzTGLZDYEj80ZiicGQzXiE8CB2z8D2zp0phA6MEuMgz3S6f4f15EsvX3StCDUfw9GwjxzPHnMq1JqbK1TFtfOfm29Dvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in; spf=pass smtp.mailfrom=ee.iitb.ac.in; dkim=pass (1024-bit key) header.d=iitb.ac.in header.i=@iitb.ac.in header.b=W4FlIpmT; arc=none smtp.client-ip=103.21.126.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ee.iitb.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ee.iitb.ac.in
Received: from ldns2.iitb.ac.in (ldns2.iitb.ac.in [10.200.12.2])
	by smtp1.iitb.ac.in (Postfix) with SMTP id 546BA104CBA2
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 20:32:25 +0530 (IST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.iitb.ac.in 546BA104CBA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iitb.ac.in; s=mail;
	t=1758380545; bh=lBULx7uqbmscImIjfEPqSce/EEelZHFj7L5TbmJLI7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W4FlIpmTy5RNjX5M10FbOG4xpsLm96F90upwQxDtTdTSB/JmsM+5Ewchx354ESIgd
	 dC6oFKaodTULajc7HGp70NbceavUKzp40hjYPjfN7J9GPaJEUTA1lNwCZ7C9jA4VRN
	 H8bX8ft+gxEfOEFJcOq4oPWg7DpR4pruGUuFD/gU=
Received: (qmail 19315 invoked by uid 510); 20 Sep 2025 20:32:25 +0530
X-Qmail-Scanner-Diagnostics: from 10.200.1.25 by ldns2 (envelope-from <akhilesh@ee.iitb.ac.in>, uid 501) with qmail-scanner-2.11
 spamassassin: 3.4.1. mhr: 1.0. {clamdscan: 0.100.0/26337} 
 Clear:RC:1(10.200.1.25):SA:0(0.0/7.0):. Processed in 3.814 secs; 20 Sep 2025 20:32:25 +0530
X-Spam-Level: 
X-Spam-Pyzor: Reported 0 times.
X-Envelope-From: akhilesh@ee.iitb.ac.in
X-Qmail-Scanner-Mime-Attachments: |
X-Qmail-Scanner-Zip-Files: |
Received: from unknown (HELO ldns2.iitb.ac.in) (10.200.1.25)
  by ldns2.iitb.ac.in with SMTP; 20 Sep 2025 20:32:21 +0530
Received: from bhairav.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	by ldns2.iitb.ac.in (Postfix) with ESMTP id D417F3414DE;
	Sat, 20 Sep 2025 20:32:20 +0530 (IST)
Received: from bhairav-test.ee.iitb.ac.in (bhairav.ee.iitb.ac.in [10.107.1.1])
	(Authenticated sender: akhilesh)
	by bhairav.ee.iitb.ac.in (Postfix) with ESMTPSA id BC1A91E814BD;
	Sat, 20 Sep 2025 20:32:20 +0530 (IST)
Date: Sat, 20 Sep 2025 20:32:16 +0530
From: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
To: alexandre.belloni@bootlin.com, krzk+dt@kernel.org, robh@kernel.org,
	conor+dt@kernel.org
Cc: skhan@linuxfoundation.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	akhileshpatilvnit@gmail.com
Subject: [PATCH v3 3/6] rtc: m41t93: migrate to regmap api for register access
Message-ID: <180f9b6c3ee7c490fe3537c2d50a92cec359e4cd.1758379856.git.akhilesh@ee.iitb.ac.in>
References: <cover.1758379856.git.akhilesh@ee.iitb.ac.in>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1758379856.git.akhilesh@ee.iitb.ac.in>

Adapt driver to use regmap api with spi bus instead of direct spi
subsystem calls to access device registers. Simplify and standardize the
register interactions using more abstract and bus agnostic regmap api
to reduce code duplication and improve maintainability. Define spi regmap
config suitable for m41t93 spi bus protocol to achieve same transactions on
spi bus.

Tested on TI am62x sk board with m41t93 rtc chip connected over spi0.
Validated set and get time using hwclock tool and verified spi bus
transfers using logic analyzer.

Signed-off-by: Akhilesh Patil <akhilesh@ee.iitb.ac.in>
---
 drivers/rtc/rtc-m41t93.c | 121 ++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 51 deletions(-)

diff --git a/drivers/rtc/rtc-m41t93.c b/drivers/rtc/rtc-m41t93.c
index 4e803ff0ce49..ad862bf706b6 100644
--- a/drivers/rtc/rtc-m41t93.c
+++ b/drivers/rtc/rtc-m41t93.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/rtc.h>
 #include <linux/spi/spi.h>
+#include <linux/regmap.h>
 
 #define M41T93_REG_SSEC			0
 #define M41T93_REG_ST_SEC		1
@@ -31,23 +32,17 @@
 #define M41T93_FLAG_BL			(1 << 4)
 #define M41T93_FLAG_HT			(1 << 6)
 
-static inline int m41t93_set_reg(struct spi_device *spi, u8 addr, u8 data)
-{
-	u8 buf[2];
-
-	/* MSB must be '1' to write */
-	buf[0] = addr | 0x80;
-	buf[1] = data;
-
-	return spi_write(spi, buf, sizeof(buf));
-}
+struct m41t93_data {
+	struct rtc_device *rtc;
+	struct regmap *regmap;
+};
 
 static int m41t93_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	int tmp;
-	u8 buf[9] = {0x80};        /* write cmd + 8 data bytes */
-	u8 * const data = &buf[1]; /* ptr to first data byte */
+	struct m41t93_data *m41t93 = dev_get_drvdata(dev);
+	int tmp, ret;
+	u8 buf[8] = {0};        /* 8 data bytes */
+	u8 * const data = &buf[0]; /* ptr to first data byte */
 
 	dev_dbg(dev, "%s secs=%d, mins=%d, "
 		"hours=%d, mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -56,31 +51,31 @@ static int m41t93_set_time(struct device *dev, struct rtc_time *tm)
 		tm->tm_mon, tm->tm_year, tm->tm_wday);
 
 	if (tm->tm_year < 100) {
-		dev_warn(&spi->dev, "unsupported date (before 2000-01-01).\n");
+		dev_warn(dev, "unsupported date (before 2000-01-01).\n");
 		return -EINVAL;
 	}
 
-	tmp = spi_w8r8(spi, M41T93_REG_FLAGS);
-	if (tmp < 0)
-		return tmp;
+	ret = regmap_read(m41t93->regmap, M41T93_REG_FLAGS, &tmp);
+	if (ret < 0)
+		return ret;
 
 	if (tmp & M41T93_FLAG_OF) {
-		dev_warn(&spi->dev, "OF bit is set, resetting.\n");
-		m41t93_set_reg(spi, M41T93_REG_FLAGS, tmp & ~M41T93_FLAG_OF);
+		dev_warn(dev, "OF bit is set, resetting.\n");
+		regmap_write(m41t93->regmap, M41T93_REG_FLAGS, tmp & ~M41T93_FLAG_OF);
 
-		tmp = spi_w8r8(spi, M41T93_REG_FLAGS);
-		if (tmp < 0) {
-			return tmp;
+		ret = regmap_read(m41t93->regmap, M41T93_REG_FLAGS, &tmp);
+		if (ret < 0) {
+			return ret;
 		} else if (tmp & M41T93_FLAG_OF) {
 			/* OF cannot be immediately reset: oscillator has to be
 			 * restarted. */
 			u8 reset_osc = buf[M41T93_REG_ST_SEC] | M41T93_FLAG_ST;
 
-			dev_warn(&spi->dev,
+			dev_warn(dev,
 				 "OF bit is still set, kickstarting clock.\n");
-			m41t93_set_reg(spi, M41T93_REG_ST_SEC, reset_osc);
+			regmap_write(m41t93->regmap, M41T93_REG_ST_SEC, reset_osc);
 			reset_osc &= ~M41T93_FLAG_ST;
-			m41t93_set_reg(spi, M41T93_REG_ST_SEC, reset_osc);
+			regmap_write(m41t93->regmap, M41T93_REG_ST_SEC, reset_osc);
 		}
 	}
 
@@ -94,14 +89,13 @@ static int m41t93_set_time(struct device *dev, struct rtc_time *tm)
 	data[M41T93_REG_MON]		= bin2bcd(tm->tm_mon + 1);
 	data[M41T93_REG_YEAR]		= bin2bcd(tm->tm_year % 100);
 
-	return spi_write(spi, buf, sizeof(buf));
+	return regmap_bulk_write(m41t93->regmap, M41T93_REG_SSEC, buf, sizeof(buf));
 }
 
 
 static int m41t93_get_time(struct device *dev, struct rtc_time *tm)
 {
-	struct spi_device *spi = to_spi_device(dev);
-	const u8 start_addr = 0;
+	struct m41t93_data *m41t93 = dev_get_drvdata(dev);
 	u8 buf[8];
 	int century_after_1900;
 	int tmp;
@@ -113,32 +107,32 @@ static int m41t93_get_time(struct device *dev, struct rtc_time *tm)
 	      case after poweron. Time is valid after resetting HT bit.
 	   2. oscillator fail bit (OF) is set: time is invalid.
 	*/
-	tmp = spi_w8r8(spi, M41T93_REG_ALM_HOUR_HT);
-	if (tmp < 0)
-		return tmp;
+	ret = regmap_read(m41t93->regmap, M41T93_REG_ALM_HOUR_HT, &tmp);
+	if (ret < 0)
+		return ret;
 
 	if (tmp & M41T93_FLAG_HT) {
-		dev_dbg(&spi->dev, "HT bit is set, reenable clock update.\n");
-		m41t93_set_reg(spi, M41T93_REG_ALM_HOUR_HT,
-			       tmp & ~M41T93_FLAG_HT);
+		dev_dbg(dev, "HT bit is set, reenable clock update.\n");
+		regmap_write(m41t93->regmap, M41T93_REG_ALM_HOUR_HT,
+			     tmp & ~M41T93_FLAG_HT);
 	}
 
-	tmp = spi_w8r8(spi, M41T93_REG_FLAGS);
-	if (tmp < 0)
-		return tmp;
+	ret = regmap_read(m41t93->regmap, M41T93_REG_FLAGS, &tmp);
+	if (ret < 0)
+		return ret;
 
 	if (tmp & M41T93_FLAG_OF) {
 		ret = -EINVAL;
-		dev_warn(&spi->dev, "OF bit is set, write time to restart.\n");
+		dev_warn(dev, "OF bit is set, write time to restart.\n");
 	}
 
 	if (tmp & M41T93_FLAG_BL)
-		dev_warn(&spi->dev, "BL bit is set, replace battery.\n");
+		dev_warn(dev, "BL bit is set, replace battery.\n");
 
 	/* read actual time/date */
-	tmp = spi_write_then_read(spi, &start_addr, 1, buf, sizeof(buf));
-	if (tmp < 0)
-		return tmp;
+	ret = regmap_bulk_read(m41t93->regmap, M41T93_REG_SSEC, buf, sizeof(buf));
+	if (ret < 0)
+		return ret;
 
 	tm->tm_sec	= bcd2bin(buf[M41T93_REG_ST_SEC]);
 	tm->tm_min	= bcd2bin(buf[M41T93_REG_MIN]);
@@ -167,26 +161,51 @@ static const struct rtc_class_ops m41t93_rtc_ops = {
 
 static struct spi_driver m41t93_driver;
 
+static const struct regmap_config regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.read_flag_mask = 0x00,
+	.write_flag_mask = 0x80,
+	.zero_flag_mask = true,
+};
+
 static int m41t93_probe(struct spi_device *spi)
 {
-	struct rtc_device *rtc;
-	int res;
+	int res, ret;
+	struct m41t93_data *m41t93;
 
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 
-	res = spi_w8r8(spi, M41T93_REG_WDAY);
+	m41t93 = devm_kzalloc(&spi->dev, sizeof(struct m41t93_data), GFP_KERNEL);
+
+	if (!m41t93)
+		return -ENOMEM;
+
+	/* Set up regmap to access device registers*/
+	m41t93->regmap = devm_regmap_init_spi(spi, &regmap_config);
+	if (IS_ERR(m41t93->regmap)) {
+		dev_err(&spi->dev, "regmap init failure\n");
+		return PTR_ERR(m41t93->regmap);
+	}
+
+	ret = regmap_read(m41t93->regmap, M41T93_REG_WDAY, &res);
+	if (ret < 0) {
+		dev_err(&spi->dev, "IO error\n");
+		return -EIO;
+	}
+
 	if (res < 0 || (res & 0xf8) != 0) {
 		dev_err(&spi->dev, "not found 0x%x.\n", res);
 		return -ENODEV;
 	}
 
-	rtc = devm_rtc_device_register(&spi->dev, m41t93_driver.driver.name,
-					&m41t93_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
+	spi_set_drvdata(spi, m41t93);
 
-	spi_set_drvdata(spi, rtc);
+	m41t93->rtc = devm_rtc_device_register(&spi->dev, m41t93_driver.driver.name,
+					&m41t93_rtc_ops, THIS_MODULE);
+	if (IS_ERR(m41t93->rtc))
+		return PTR_ERR(m41t93->rtc);
 
 	return 0;
 }
-- 
2.34.1


