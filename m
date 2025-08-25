Return-Path: <linux-kernel+bounces-785370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB6B349A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FF01B24FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2E83093DF;
	Mon, 25 Aug 2025 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAfwvC9s"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C503093CD;
	Mon, 25 Aug 2025 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145000; cv=none; b=o3f8u8ZWL2Q6sxtOFKXROhuEbP6saMvpedd7aTiXrjl1JuYCtEU6UuY4If7yLvr5V2RkToyP8j2dKA/o1yTrzfJSJ4gsJho17WvUNpV90bUCYd4IvxwOuxPth7gc6kX633mGlL7tuyPGt4bUAOBHw7+4djegsBgu15rT3gKfuRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145000; c=relaxed/simple;
	bh=YDj5b8NzSjrYGF773HsoV6Qs2DB8NhpVoembdkH0piY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPE0bs75TtZ6l6SGQxTk3qo5zdU/DFGdDKLgh4quLZtDYlF9/nJgUDG2FrT/vzUoxwiKWRRXIbHF9R/OrNdzqBNR9PeNHnVezQnvSA+lQ8ANtgpuGIoc4bos1E1QIDBJ9i0FNMVLontAzgPTm6bnzFnzNJ/B3ejr+zpGV1hL6ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAfwvC9s; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c980bd5f48so1136524f8f.0;
        Mon, 25 Aug 2025 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756144996; x=1756749796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIgAYUOn+KH+iV2yDLJ8wzc4v1JnGoScAfW+DfWbPro=;
        b=WAfwvC9shMAqcHUwdPChTdA0URJCio/9sTD1xVx/UMo5wo/7A26l56lgTpcLWaxGsR
         5V4+01dLeQZLVYXikSK/zNU/sQbHarwV3Sd7iZdZVoXbv708gDLRFl566Fz7+loJVJMX
         5vNxFGj5qgY3WJNWrnQfB/BYnayB2phKLdkj1FnCz0c72nz7U92luYGQ62QxhJ/OUatt
         ug9rixR6XuQPt+NLt+BMdwgKfwqbme6Z5AhPkjHdWopYyr4RHNWMdKy4kSGd7NNjPGDC
         fEWR6rxAwRe8gpuqCgx1Ixw/LCCecr4q8VHqRPKuOtKeZ9xZVDAbAO4ELmuwcZrQo9Gz
         mtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144996; x=1756749796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xIgAYUOn+KH+iV2yDLJ8wzc4v1JnGoScAfW+DfWbPro=;
        b=GF6A/5del57NCzAKW10i5dsNAZaln5rI+B1Lygz7oC/L0ABdCVtEs22Q8yqQ/0eqy6
         RexV/+pYZRr8BXnGMSveBFovVPYe//7CFbM5qebLKbvn2lkGQHA1DylqPl+gLfPKui1k
         Q6mxl9SpU81fJGv5VjXQSRYSqFJm0BT/FhPPpUuGZirvSXegnWRhgbEDoQ2tcID5Je+r
         vbgX0VBmTP0rZXssm0FChZ+erx8epDjtIbuQjfoH1j4mVgJP0s0VZaLAE0BJ1wkWrFTT
         VRoX3G4U45UUT/rVNISRF33+2MNmro9641hncRpZVfU0t9vqdm14WIWSXk49z4nlJbZG
         dpPA==
X-Forwarded-Encrypted: i=1; AJvYcCVIrt9ZGypZRwYTRVRvWWVWkIUXXw1uLPT0fnyO5byKekshTMbP3LTvKV1tXe3Owr0XTyd1y9qLspDN@vger.kernel.org, AJvYcCVmMW3BTtZzEtEGNVapWtJ8QbwREOCxAxMl4BpThaCSIXkXzzylWO+8OsFXV9xV0a2qSpNmwnvu7O2xyNuk@vger.kernel.org, AJvYcCXRt1nk0dFkqxgsLperNmMXHdBmOHEEOZ5xn2KLOtd4qMHWnvtB9zVFilWEOKBMZLYF4CQ+MM5ISV8bSQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzktgR/8DRjcGuf4J2rt6Mo0oFFUeQzphZy0Isc6TA1YZSkuGwY
	9V54ax1hoa3SgfhZAkPGreG3VHo2wDcaeML1a8S7/yUIRgq/K1rn5dUE7dLcUZv3
X-Gm-Gg: ASbGnctbSmiq7m7z0n5dYQ2dBRDc/vch/P73DbWYiyNogMiGPoGAmCbiYANBa0fHT4j
	3j9ZqwPXfkSssc/TrEHMguQL93OuuAGjktDsqHLkgJGgGqxNHiZyn7R/kjFaFTrUBw1DgV1TQj9
	VeElWiww8haKcfoyzmmVFRnIj5twomPrl30jNLE/3TrG1x0i2eXbi070Pjaovgnx8asVRI2a1Tk
	Eqe4AHPAqlXuO6FpoSIYTI5gJwWQ2o/CTG20FtdCeXerhSpAY3u1yyrhJiYFmHXCJEXyRjpIgOb
	qLrCTrSJ5zERQz9kFvgFj3Njbc2wTte9nOcull997qzkjA5mpZvMqc47DrDKzSctHtD2IeuLfNp
	ffPAU/Tn64G2Vi13lM2THP0G2ILX/bKB5dw7EDA==
X-Google-Smtp-Source: AGHT+IElPaRbyIM+48mprGrymAo1GQZLVzIDqLk498OclQ1jFdGiOZBc2eQFMuqSE0M1QOAaSZBsAw==
X-Received: by 2002:a05:6000:1a8d:b0:3ca:2bc7:e821 with SMTP id ffacd0b85a97d-3ca2bc7ef61mr2712285f8f.53.1756144995578;
        Mon, 25 Aug 2025 11:03:15 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([5.15.80.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4ba046sm13434442f8f.1.2025.08.25.11.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:03:15 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: 
Cc: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Flaviu Nistor <flaviu.nistor@gmail.com>
Subject: [PATCH 2/2] hwmon: tmp102: Add support for label
Date: Mon, 25 Aug 2025 21:02:44 +0300
Message-ID: <20250825180248.1943607-2-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
References: <20250825180248.1943607-1-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for label sysfs attribute similar to other hwmon devices.
This is particularly useful for systems with multiple sensors on the
same board, where identifying individual sensors is much easier since
labels can be defined via device tree.

Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 drivers/hwmon/tmp102.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp102.c b/drivers/hwmon/tmp102.c
index a02daa496c9c..8dd295b0d87a 100644
--- a/drivers/hwmon/tmp102.c
+++ b/drivers/hwmon/tmp102.c
@@ -53,6 +53,7 @@
 #define CONVERSION_TIME_MS		35	/* in milli-seconds */
 
 struct tmp102 {
+	const char *label;
 	struct regmap *regmap;
 	u16 config_orig;
 	unsigned long ready_time;
@@ -70,6 +71,16 @@ static inline u16 tmp102_mC_to_reg(int val)
 	return (val * 128) / 1000;
 }
 
+static int tmp102_read_string(struct device *dev, enum hwmon_sensor_types type,
+				u32 attr, int channel, const char **str)
+{
+	struct tmp102 *tmp102 = dev_get_drvdata(dev);
+
+	*str = tmp102->label;
+
+	return 0;
+}
+
 static int tmp102_read(struct device *dev, enum hwmon_sensor_types type,
 		       u32 attr, int channel, long *temp)
 {
@@ -128,12 +139,18 @@ static int tmp102_write(struct device *dev, enum hwmon_sensor_types type,
 static umode_t tmp102_is_visible(const void *data, enum hwmon_sensor_types type,
 				 u32 attr, int channel)
 {
+	const struct tmp102 *tmp102 = data;
+
 	if (type != hwmon_temp)
 		return 0;
 
 	switch (attr) {
 	case hwmon_temp_input:
 		return 0444;
+	case hwmon_temp_label:
+		if (tmp102->label)
+			return 0444;
+		return 0;
 	case hwmon_temp_max_hyst:
 	case hwmon_temp_max:
 		return 0644;
@@ -146,12 +163,13 @@ static const struct hwmon_channel_info * const tmp102_info[] = {
 	HWMON_CHANNEL_INFO(chip,
 			   HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST),
+			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_MAX | HWMON_T_MAX_HYST),
 	NULL
 };
 
 static const struct hwmon_ops tmp102_hwmon_ops = {
 	.is_visible = tmp102_is_visible,
+	.read_string = tmp102_read_string,
 	.read = tmp102_read,
 	.write = tmp102_write,
 };
@@ -213,6 +231,8 @@ static int tmp102_probe(struct i2c_client *client)
 	if (!tmp102)
 		return -ENOMEM;
 
+	of_property_read_string(dev->of_node, "label", &tmp102->label);
+
 	i2c_set_clientdata(client, tmp102);
 
 	tmp102->regmap = devm_regmap_init_i2c(client, &tmp102_regmap_config);
-- 
2.43.0


