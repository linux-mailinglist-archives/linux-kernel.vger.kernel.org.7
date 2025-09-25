Return-Path: <linux-kernel+bounces-833207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558F1BA1696
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40ED560F81
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF1321438;
	Thu, 25 Sep 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XscQm0C9"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D755F32142D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758833166; cv=none; b=leq5hVaMn5zMPcsA2R4xvTLkEzdtavQmLk75o/ZycfvbrikGAUuIaESs98vj3ylUQGFMgSP4qOv0cHLF5thWMcTyBLFKXll36dtAlvv0a16nOaaG22m78oXcetyra1w6fLq6z7NkBVukUFxzgtU9GleDKWlcOOrcFHjuWSlpAHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758833166; c=relaxed/simple;
	bh=QZYLwLOu9FwUcgSKVi5UCynvL+ZAZTQpQ8/aAvYckS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kh/RUEVgg5RWFtNasCpRwjgVoENB8Fohn9MbhMYm1ScWDWH0gpD4qMfvgRJhZaMsdI3GCZUfsfHkafBOQFCG25XtUhmqJ/b9TNG/sf5LmnnDvbechU0k0ns18vzDRnM18+JiHjwvHAvVOX1KH/MPKsN3MydwODpUquENB8Px/AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XscQm0C9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e317bc647so10255015e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758833163; x=1759437963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=XscQm0C9pMGlvK8V/vNa+cpWOjgXjN+4W2+l6WKSSaNvDWzZRRN/+k0JutDmXxpgI2
         ksz1RfSaTRR4sTNqIaTwZsN6bnOZH7BFXw8PXgTgIDZ5mWvnpdICePTSWxW1zcKblB4h
         pYXDuUW2dtMpMU8sDOxlK84oHvyDEp/C0ZWleZXj1PKL3Q9NP5ipKP/29fbkRcnXzsIg
         wi5Pii+sepieEGRwMJY90yzIdrDz+jI+lmjbIByaoNH4heQzld8H4UUpkZYQr9fNFDqp
         1loafMCrKn/wpjewRmWpDMYBA5c127Pcs//sXQcfQvuJ2m6aso3VCoo7ZdcwThje63S2
         aPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758833163; x=1759437963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=PVcNhA4jP4/yNurYE5uTq3vYL0RcLl07NnB2/XX+jgNri93pf1PzQ6gx/2LpkpelgG
         JAT1oGNv+Sb+aWFAiigvtucgk3Qn3Ll7nlkbiDC/9k3FHDcCq3qY6NB9r9NKJUvjHslg
         fad/3DjufDwkZBGCWusBvv7jB/wQQcZw8S32ix9PUlO0b8EaWZ1IkZ5lYWdwhfl020Bt
         gCuoBsW2R0HWF//M+eS3vxzUYSnhb01/yOwcf5rKKg8RaMlEXOCre3cMTiyMPkOF8aVS
         bRGTyhiPTiQ0MudKweflbgay9vJqzLH/cPe5WgGEk7ePyDce9tnWG/9/mwMAhToNN3sD
         IsSQ==
X-Gm-Message-State: AOJu0YzOXYYU6vk9uE+hrLqFl5NCR3XWvBVHHDxgQA3PTuoxqh2k43+v
	ZDi8Au5wUj6PVbHPtrAUQaRDPhJHCccA7OpBuFJctg8qf/C4k+JuD3AQ
X-Gm-Gg: ASbGnctw67exAFg+KSahXjxTaO3QtC7ib/q2Iscm8KI+POTWtRR1A/5iXH0NWK5B7sW
	NgJoFce+dQEzFNp3kWPTcumCNIxOcYIvFEHl6dJdRXQr499sRHuBMvSDXsilcHVC+YO/DZ6z05D
	OINAJxkIdW6DCVqiIVEBKB5qpSTl+xDcAXJGxguA9+4NYNeaQDQZG/hV3bl4J/3lV59FjJ8qtAD
	l7PZOpuXbXj+iV6l4YDNI3vHMsFLE/mjC3tu6Bgmje9inRyrknaPu0TTrbcYouiW7ggqz7AL0Cf
	mJx/Sgn7pzKus/8mwwoG8V/6kFhUF1VEfYeuwEbwS0+znUBQ0sdv7Vj/jm5tLJl4kL2zjUwE98W
	8u3EXVVX5RhCel9FUB0DrVoGGgEJSLC1GQtlNFA2Sr4PqXSkAWw==
X-Google-Smtp-Source: AGHT+IHHohFMXgIwk1CDdD+uJhrqIHjozKM/oy1Tn2dqyy7fv4EN0p48AORO2mEQxcWa0xSlEG+lFw==
X-Received: by 2002:a05:600c:5494:b0:46e:33a6:46b2 with SMTP id 5b1f17b1804b1-46e33a649a8mr42974005e9.12.1758833163236;
        Thu, 25 Sep 2025 13:46:03 -0700 (PDT)
Received: from localhost.localdomain ([78.209.201.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm91201395e9.1.2025.09.25.13.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 13:46:02 -0700 (PDT)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux@roeck-us.net,
	rodrigo.gobbi.7@gmail.com,
	naresh.solanki@9elements.com,
	michal.simek@amd.com,
	grantpeltier93@gmail.com,
	farouk.bouabid@cherry.de,
	marcelo.schmitt1@gmail.com,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v2 2/4] iio: mpl3115: use guards from cleanup.h
Date: Thu, 25 Sep 2025 22:45:36 +0200
Message-Id: <20250925204538.63723-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250925204538.63723-1-apokusinski01@gmail.com>
References: <20250925204538.63723-1-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/cleanup.h and use the scoped_guard() to simplify the code.

Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 42 +++++++++++++++-------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 579da60ef441..80af672f65c6 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -10,14 +10,16 @@
  * interrupts, user offset correction, raw mode
  */
 
-#include <linux/module.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/delay.h>
 
 #define MPL3115_STATUS 0x00
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
@@ -163,32 +165,26 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	u8 buffer[16] __aligned(8) = { };
 	int ret, pos = 0;
 
-	mutex_lock(&data->lock);
-	ret = mpl3115_request(data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
-		goto done;
-	}
-
-	if (test_bit(0, indio_dev->active_scan_mask)) {
-		ret = i2c_smbus_read_i2c_block_data(data->client,
-			MPL3115_OUT_PRESS, 3, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock) {
+		ret = mpl3115_request(data);
+		if (ret < 0)
 			goto done;
+
+		if (test_bit(0, indio_dev->active_scan_mask)) {
+			ret = i2c_smbus_read_i2c_block_data(data->client,
+				MPL3115_OUT_PRESS, 3, &buffer[pos]);
+			if (ret < 0)
+				goto done;
+			pos += 4;
 		}
-		pos += 4;
-	}
 
-	if (test_bit(1, indio_dev->active_scan_mask)) {
-		ret = i2c_smbus_read_i2c_block_data(data->client,
-			MPL3115_OUT_TEMP, 2, &buffer[pos]);
-		if (ret < 0) {
-			mutex_unlock(&data->lock);
-			goto done;
+		if (test_bit(1, indio_dev->active_scan_mask)) {
+			ret = i2c_smbus_read_i2c_block_data(data->client,
+				MPL3115_OUT_TEMP, 2, &buffer[pos]);
+			if (ret < 0)
+				goto done;
 		}
 	}
-	mutex_unlock(&data->lock);
 
 	iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer),
 				    iio_get_time_ns(indio_dev));
-- 
2.25.1


