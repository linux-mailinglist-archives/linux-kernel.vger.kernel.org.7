Return-Path: <linux-kernel+bounces-834689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CFFBA5483
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 00:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5891B7B95B4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 22:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9E2F99AD;
	Fri, 26 Sep 2025 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSYZFPKY"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C474E2F90D5
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758924147; cv=none; b=h+7pcz5xxJ1GILXI0gCV8jm23C9K+belmaSWncr2oa6Pi8RxI4Zqv8ka6HDIH/OARwQjK0HnBE5K6hURwaukXW8guFFZg6KsH5DsBjrNi8l988aSAqo8n23HYwFlhp7XbjGLFlP2zTQq0qKPlWeyq3E/dWjqfXCOLs/+KcDMxwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758924147; c=relaxed/simple;
	bh=QZYLwLOu9FwUcgSKVi5UCynvL+ZAZTQpQ8/aAvYckS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F5rhOnBrqhRtJQ68BmgAvM97PsnFhy1k3kWgnlsCRKWZIhGCA9N4FlaJsSOEvSiCV0Xj15ZHeiOroaDwAftmCbSf4pYRGUpu6XKy32S9sTJwuHW6ITQT393hLr9DnVPX+FO2SYXc+ykyYTTojOGbeAQSspMDvtOGJtG9ZnGJph0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSYZFPKY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3fc36b99e92so2272368f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 15:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758924144; x=1759528944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=iSYZFPKYLrgulfqG/D9FE4V34XHQ/0XaHVmmF9fvuBzKPAs5gLvx8nDgNtIHpSkrfG
         FiszWHkRBMutcCNW87RpBOWKlZI9PBJ6tx9VPn9J3aTKcNy9FdccSf/oEsM0m7ZexRnM
         slZ09RdN7rNJItJKYNNgLLDUH62Jk/TYnOe5J8qKZnnOFtW3fcAotLoiTLk8CFxV6nZp
         HHQBrdQsasq2FYE0wZQTKuEkb6/Xpy9ZoxsIqg0ZLwcR88PYlPqhVqfhxIWBOkzRVmy5
         bjwngvyY6plgO1KlRUrtygAvu01ZHDBGz0XfYE/JjEZxoE8EwrdBOBHDC2YiMQg0KOKj
         6JMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758924144; x=1759528944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hzGFgAL4kFJpF+2U2ML/HycqoaNqqsEROO0epHyQA0k=;
        b=rmMWnJXF/y7vVYgRaho9Gr3aQ4Rk6eUgp2mDXi4BaYGYMvFSyRAVTtLNKkB3dkE4IJ
         ENEjQBwMtl8dVLxOO/gJz8n1rJUo2pIPEvYckX7dH7We5UUCtYGhmqnUroFJqUVv+fMh
         R6fPDSOdTIaAljxiuUi6eWkeS+lxFDcJ+BotIMAGHEuMzNpfoxq6h6+EgSMlrB195uu2
         02n6e1ybUL27s9KCTHha2RVTVYAaJHFRxFJebxFtkMM0skc/IvQxIhvCt7w9g2kJ2dX7
         2vu6XZtkUjDE9K/8AuQbWM0vzx8f3T2yf3MKLECNHu+HkRvRzh7ZKbx2z5MHBGxfeA+J
         jRrQ==
X-Gm-Message-State: AOJu0YwRycfGs9xvMhEkzFoS9ESaKRdgIZJ3RoPrHD+7UELyD+Ihk7aD
	lCUNWAyWaSb4V8ZjyRCQEGblTDveWfvbBw09hr9d9Bzthey2Tbprf/4b
X-Gm-Gg: ASbGncu5BsIiYqlhRXqJcjbgo1+ye0aJ36PwOk22kaz3BXTE3epta+OtY8CaizwSlbY
	Bs3bnyOWZEWxOtezhjfy4S7KxRtPfwKoThi2uqlfA9v5pyM+x/qBZpxbbub4WRHVt7hnSkO0Yok
	N3outLHej4FISmVAdsT08mmsK4zMrXcCESAbnU6IcvHKHCZ9xDM1AY+eV4ZCvwEEtYfgy2HrG4C
	geLHl2GGCvTQCYT1mpB3Dh5D0VgEAyxwF/GMzy129JQGkup+NQqJkLmkBzm4lx+2hNabsCBHBZ3
	bJHilH+Ywmd6JDMpx05rG10feGOsRCWOyOKJtImoh4i2vyiA9gYiFQvqTxLLnzdbZE1xZPSSKy7
	hL6OA4fuW6btsZYJkegytFXEBNkxoCLKAjEzkQ3pH9K6r68BO4Yk=
X-Google-Smtp-Source: AGHT+IEdmGEYGI/H69HniS7cB0ahGFtHyM85fnqKZIEnyyV2R6F1Gk45uwDld+P0FJLHi5vnddBzTg==
X-Received: by 2002:a05:6000:310e:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-418006e9436mr833697f8f.10.1758924143833;
        Fri, 26 Sep 2025 15:02:23 -0700 (PDT)
Received: from localhost.localdomain ([37.163.230.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc82f2965sm8410236f8f.55.2025.09.26.15.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:02:23 -0700 (PDT)
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
Subject: [PATCH v3 2/4] iio: mpl3115: use guards from cleanup.h
Date: Sat, 27 Sep 2025 00:01:48 +0200
Message-Id: <20250926220150.22560-3-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250926220150.22560-1-apokusinski01@gmail.com>
References: <20250926220150.22560-1-apokusinski01@gmail.com>
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


