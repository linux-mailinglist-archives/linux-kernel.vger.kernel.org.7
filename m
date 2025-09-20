Return-Path: <linux-kernel+bounces-825656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D9CB8C706
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FBC176BF0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D2F2FE051;
	Sat, 20 Sep 2025 11:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bonouqON"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C012FDC50;
	Sat, 20 Sep 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368628; cv=none; b=BdQQwm8A6wvifyu8FwH4t0q8lx3dDmECtYo7R3jT7rGIVBfdbt4JmdtZKYEVca4KBHZkLpDYcnXsI1H70dxOrDQdkQ0LNJEKaanOZCgPRhIObFQVij3TKTMq0/t4WOaJbowkcaW+2tliMGtf/on+dFwAZ60ovUgcWI0FAbt4Aoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368628; c=relaxed/simple;
	bh=uCNIebJ5GBC3Ic5GqrP78+5py435enPbQqSaXVxrZpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=enBnhM8eU4KGfUIR7DDXNLZwBGE6ORJJFQLNPIm0mEloRKhoOiTW6PQVY28ek5Up5OOPhak7Br1tVfFiy8PVRVgqkNTFdHSlCDEMJSLgYJrNWRTDvXe0T1qafkfJImhjdnH+we0yzTMOknL3XiSmCPOWd1rNIrJ2TUuhD0dpWo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=bonouqON; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=NVd4XziI5g9VoBf1826LH9iYhIa1opWEsNRaWvihNNM=; b=bonouqONZN8KXO3z89X+04fzhc
	wN53lCMk+MS9nsA2nifxg+oHeXKv8y0KATmPcTNoxJs4o7a+jyV5aZQpC8UW9lWnSqv9dxtUSV1U6
	UmqvP94NKtSZFzjTOphdRdyPs+vV8G56A3rgHHtWhHgzdnOju+0cplVW9CLR1Q2U4E0SyyUu/xSWe
	bzkV5GoV45MOZY5nIEN/FNREo5AJGxwbOmBvGfsl1tkeVLcrpfN3Jfv3Un5kLfcixmhG2unVH1euk
	1spuVIWdkYpszZqBttKk/B+CN0G5LjsPKrmTy0dCl3rmt5RgNkABPgHstqOs59vsnHNqKxxp5eMY8
	RpfsL5dQ==;
From: Andreas Kemnade <andreas@kemnade.info>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] hwmon: (sy7636a) enable regulator only if needed
Date: Sat, 20 Sep 2025 13:43:11 +0200
Message-ID: <20250920114311.291450-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250920114311.291450-1-andreas@kemnade.info>
References: <20250920114311.291450-1-andreas@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid having all the regulators in the SY7636A enabled all the time
to significantly reduce current consumption. In pratical scenarios,
the regulators are only needed when a refresh is done on the epaper
display powered by the SY7636A. This is can save around 10mA which
is much for this kind of devices.
Also fixes the asymmetrical single enable call.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index e83d0e50c735..0fda69bea3b4 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -18,14 +18,26 @@
 
 #include <linux/mfd/sy7636a.h>
 
+struct sy7636a_hwmon_data {
+	struct regmap *regmap;
+	struct regulator *regulator;
+};
+
+
 static int sy7636a_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *temp)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct sy7636a_hwmon_data *drvdata = dev_get_drvdata(dev);
 	int ret, reg_val;
 
-	ret = regmap_read(regmap,
+	ret = regulator_enable(drvdata->regulator);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(drvdata->regmap,
 			  SY7636A_REG_TERMISTOR_READOUT, &reg_val);
+	regulator_disable(drvdata->regulator);
+
 	if (ret)
 		return ret;
 
@@ -66,23 +78,24 @@ static const struct hwmon_chip_info sy7636a_chip_info = {
 static int sy7636a_sensor_probe(struct platform_device *pdev)
 {
 	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
-	struct regulator *regulator;
+	struct sy7636a_hwmon_data *drvdata;
 	struct device *hwmon_dev;
 	int err;
 
 	if (!regmap)
 		return -EPROBE_DEFER;
 
-	regulator = devm_regulator_get_optional(&pdev->dev, "vcom");
-	if (IS_ERR_OR_NULL(regulator))
-		return -EPROBE_DEFER;
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
 
-	err = regulator_enable(regulator);
-	if (err)
-		return err;
+	drvdata->regmap = regmap;
+	drvdata->regulator = devm_regulator_get_optional(&pdev->dev, "vcom");
+	if (IS_ERR_OR_NULL(drvdata->regulator))
+		return -EPROBE_DEFER;
 
 	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
-							 "sy7636a_temperature", regmap,
+							 "sy7636a_temperature", drvdata,
 							 &sy7636a_chip_info, NULL);
 
 	if (IS_ERR(hwmon_dev)) {
@@ -102,5 +115,6 @@ static struct platform_driver sy7636a_sensor_driver = {
 };
 module_platform_driver(sy7636a_sensor_driver);
 
+MODULE_ALIAS("platform:sy7636a-temperature");
 MODULE_DESCRIPTION("SY7636A sensor driver");
 MODULE_LICENSE("GPL");
-- 
2.47.3


