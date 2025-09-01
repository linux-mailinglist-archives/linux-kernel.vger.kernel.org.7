Return-Path: <linux-kernel+bounces-795188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C897B3EDFD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2562204A5C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 18:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F868324B10;
	Mon,  1 Sep 2025 18:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qkgv8s+J"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE657320A1E;
	Mon,  1 Sep 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756752052; cv=none; b=MNdUT5OMywjGb1irc+wkgt9FoVA2x2M62CU0+w9O9FRBvvD7E03MI7iNmPWIqbPs2PLjH3T0sMKYF4Ac3iwM+W7odNty3sNBfhErzE7QHY8lwdx85Mvn6wnPwNIO1Frx0cl2iKRnIuogCcN5we/s7+LbR4zvFc4W5cC/LuAUFQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756752052; c=relaxed/simple;
	bh=8mjZOMbH59U2lKc+WX8W5jCxQiG3TXhv75CASHWqnP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/FsmvBjUWeG50R7FTvqnZOxChcOYbgZZjEOz2gO74YFAawWQlkS8WO5VdfuRc59bdrDu1w+kH6+zLQNIcHlLns+m57g0abqvBp7n9ivOIaX8SZE6fzQB7I/ViPxGuSVO703/89lHfuQ23jmyqt1FI+iqE/bvH+PA6eQ7Z2Lu3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qkgv8s+J; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-77256e75eacso1299625b3a.0;
        Mon, 01 Sep 2025 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756752050; x=1757356850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGVwix7pPgZ6lDzt9/qPm6qUCw7C9IJOsoI3GBvLv+E=;
        b=Qkgv8s+JmV7foVV2tAnp4ScI8FtNnmMi2FVOebEN4ewTjjfNlhT4sXpyNCBUGCFKvJ
         uYF1Vb1dwv/93bNP5phLJZTkcxvMIcN9zYe4+/inMb1d92hmQJn6Vg+1M2sY4zDttC3g
         k9VFjUrnadYVe3W0o2MVhnx6qiWcWHdK0fGWRFs4OlYJPDIPNGv+erWqV4ij0WZ27pmp
         N73llICV/hI8hwdJDclUYyDw87tKebCmvcNR5CVCkBtCX9Q2nqLWb1610kOJcR4R5DCa
         +oek6iSesygQ1MY/BYRg5fpqH0yrarUqG1sCV+XcbIz8EAynjhpoGBVUQRljXKtNEYDR
         vHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756752050; x=1757356850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGVwix7pPgZ6lDzt9/qPm6qUCw7C9IJOsoI3GBvLv+E=;
        b=TrCxLZOQlfB7VRldFPUggcFhLSKLk2ODXs4DMAt3uMZEbdM8SS3N2MfyVVNR17BRsR
         ux0z1IL18V0vbDtARFbpFioc3fh8iO1U9eqnYpRMJKv7eivkluseMK8fZdft5z0cu/r2
         dsJ6MrYQ4FZuemiSZ5z2BXNzIto01oFiYitLXGpMZ0LohB29V+jC8JbZ+1qm9uTWaEVD
         lIXZOkyOAxInELzY9lrr8VTma4yQJNkL6UgZiuIlSXzJIuhMnSvWTmNBAFqvwljzb+Do
         eAq6L5RkyKKR45pjTjJPZnMRKuz4Z1k+H+kW2uH9ov/CEBz9toRD4hIuNmrbT6B/hV0w
         GsRg==
X-Forwarded-Encrypted: i=1; AJvYcCUK4OVXJgaOwoLNSxHZJ1n5XJoVVOj5YQ+o2rDGnD/NZGlDzWm7oAIBVuCQZhQZuDWoChAbV1EaZi1Ixm4=@vger.kernel.org, AJvYcCVwFz3SDdOF+byUCUCR0k1IbhMfNS7Y+fcVdcQn2WsMSRID3w3JdXKiihpp+J0W/ZPVPPT5ynA/bAv1cIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3qNOUL+A83Lo3LiaxgK4qUans5lLXxi9QKNIl/95PsAXdvErn
	JcXnsiw9iznXBKNujgffC8xRTdMIGpSwiBeYaj9zBCSHj9IO52IE5pYi
X-Gm-Gg: ASbGncugKX86MZTBmQDGqb0Lp4W8ZdZ6BoamDkJtphxbX7//nRca6lFn8hmX2rG+Hur
	ccg3GG2m07ki0x2kcPs9nzLM26OVi7o05g9Ydw1RIh9W8WGldnr8XSsX9F1FSIKZcojh8nZCPQl
	a50PANGDq8uwfV2uT73pyMLBBPrayf1CJpv6Cl6si1bI4hKlT/MKpgwlIoEcAZ++f0g7vygbgii
	xkQzcuWjLHB1C38kdiCQ1oZfRxsx8c3ajhdKK/F3mJUIRXHtMV8MBeEmPieqRoRGsodNq+oZbko
	suJXRXtljlqdzxgJ54fHFPQ4eHdJlKVUL1/0ffG8skGuR44+RWhFfWl8CJLqUk+diCzhUX4/8MT
	OroFoV8LZDlouLln9SEAGV9I0D5GpKDZ7Ptu+YaW05aZDhrx0t7yHW3b4jJ7kkfk=
X-Google-Smtp-Source: AGHT+IHCN3WeL/ds9ycqblwIJ3dkQqbxpT1BfcyFWS9/dXfTtKaRj8B0yoxYFkR7+mbJw1Mm6Ces1w==
X-Received: by 2002:aa7:8882:0:b0:772:4b09:ba3b with SMTP id d2e1a72fcca58-7724b09c30bmr8196327b3a.1.1756752049917;
        Mon, 01 Sep 2025 11:40:49 -0700 (PDT)
Received: from fedora ([172.59.162.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77236d7eb7fsm9436621b3a.54.2025.09.01.11.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 11:40:49 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	shenghao-ding@ti.com,
	kevin-lu@ti.com,
	baojun.xu@ti.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v3 3/3] ASoC: codecs: tlv320dac33: Convert to use gpiod api
Date: Mon,  1 Sep 2025 11:40:07 -0700
Message-ID: <20250901184008.1249535-2-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901184008.1249535-1-alex.t.tran@gmail.com>
References: <20250901184008.1249535-1-alex.t.tran@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert driver to use the gpiod api instead of the legacy
GPIO interface. Replace power_gpio integer with reset_gpiod descriptor
in the dac33 struct.

Use devm_gpiod_get_optional() to automatically handle resource cleanup
and add proper error checking when setting GPIO values.


Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
Changes in v2:
- Included removal of struct 'tlv320dac33_platform_data'
  and header file 'tlv320dac33-plat.h'
Changes in v3:
- Split into separate patches as per request
- Moved inter-version changelogs after '---' line

 sound/soc/codecs/tlv320dac33.c | 55 ++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
index feefc777c..c495be1cf 100644
--- a/sound/soc/codecs/tlv320dac33.c
+++ b/sound/soc/codecs/tlv320dac33.c
@@ -14,7 +14,7 @@
 #include <linux/pm.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <sound/core.h>
@@ -79,7 +79,7 @@ struct tlv320dac33_priv {
 	struct snd_soc_component *component;
 	struct regulator_bulk_data supplies[DAC33_NUM_SUPPLIES];
 	struct snd_pcm_substream *substream;
-	int power_gpio;
+	struct gpio_desc *reset_gpiod;
 	int chip_power;
 	int irq;
 	unsigned int refclk;
@@ -382,14 +382,26 @@ static int dac33_hard_power(struct snd_soc_component *component, int power)
 			goto exit;
 		}
 
-		if (dac33->power_gpio >= 0)
-			gpio_set_value(dac33->power_gpio, 1);
+		if (dac33->reset_gpiod) {
+			ret = gpiod_set_value(dac33->reset_gpiod, 1);
+			if (ret < 0) {
+				dev_err(&dac33->i2c->dev,
+					"Failed to set reset GPIO: %d\n", ret);
+				goto exit;
+			}
+		}
 
 		dac33->chip_power = 1;
 	} else {
 		dac33_soft_power(component, 0);
-		if (dac33->power_gpio >= 0)
-			gpio_set_value(dac33->power_gpio, 0);
+		if (dac33->reset_gpiod) {
+			ret = gpiod_set_value(dac33->reset_gpiod, 0);
+			if (ret < 0) {
+				dev_err(&dac33->i2c->dev,
+					"Failed to set reset GPIO: %d\n", ret);
+				goto exit;
+			}
+		}
 
 		ret = regulator_bulk_disable(ARRAY_SIZE(dac33->supplies),
 					     dac33->supplies);
@@ -1488,16 +1500,14 @@ static int dac33_i2c_probe(struct i2c_client *client)
 	/* Disable FIFO use by default */
 	dac33->fifo_mode = DAC33_FIFO_BYPASS;
 
-	/* Check if the reset GPIO number is valid and request it */
-	if (dac33->power_gpio >= 0) {
-		ret = gpio_request(dac33->power_gpio, "tlv320dac33 reset");
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"Failed to request reset GPIO (%d)\n",
-				dac33->power_gpio);
-			goto err_gpio;
-		}
-		gpio_direction_output(dac33->power_gpio, 0);
+	/* request optional reset GPIO */
+	dac33->reset_gpiod =
+		devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(dac33->reset_gpiod)) {
+		ret = PTR_ERR(dac33->reset_gpiod);
+		dev_err_probe(&client->dev, ret,
+			      "Failed to get reset GPIO\n");
+		goto err;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(dac33->supplies); i++)
@@ -1508,19 +1518,17 @@ static int dac33_i2c_probe(struct i2c_client *client)
 
 	if (ret != 0) {
 		dev_err(&client->dev, "Failed to request supplies: %d\n", ret);
-		goto err_get;
+		goto err;
 	}
 
 	ret = devm_snd_soc_register_component(&client->dev,
 			&soc_component_dev_tlv320dac33, &dac33_dai, 1);
 	if (ret < 0)
-		goto err_get;
+		goto err;
 
 	return ret;
-err_get:
-	if (dac33->power_gpio >= 0)
-		gpio_free(dac33->power_gpio);
-err_gpio:
+
+err:
 	return ret;
 }
 
@@ -1530,9 +1538,6 @@ static void dac33_i2c_remove(struct i2c_client *client)
 
 	if (unlikely(dac33->chip_power))
 		dac33_hard_power(dac33->component, 0);
-
-	if (dac33->power_gpio >= 0)
-		gpio_free(dac33->power_gpio);
 }
 
 static const struct i2c_device_id tlv320dac33_i2c_id[] = {
-- 
2.51.0


