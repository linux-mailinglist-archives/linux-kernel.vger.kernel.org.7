Return-Path: <linux-kernel+bounces-707372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BC6AEC338
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BCA1C25C8C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E832EE5E8;
	Fri, 27 Jun 2025 23:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XtRQkJSu"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61C299924
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067696; cv=none; b=n9zsGPLkF6QqfMxbYmcli3Q8U0Ae9KKDaX9zRLJM9c9w0188+b1LMAcF7qnl8WB1bEk1pPUmN4dE9ZW4/g/fT0zeCW0oSDDu9YhbuF0f9gKVhPXgZsUciKf01Q8vGaMvS/XsefP27sTHR4B6jUfmNk1/9z+y0rHkmK7Rg36b4pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067696; c=relaxed/simple;
	bh=UWnNQjC9xY1Xwfu0SBlWSeVKesQj5uaRhdQrBvWhhA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfB2d6Z7sJKBOAuKTuVp3r7wCIvId6ADMqFbYqD35CaXDXcCmTI3i+aWhI/vudYk7zimEAuFs8ya6Z4NKa26gkCLFTuCDs34L3DdFQTF/Z9S99yXrlQKqVjk87LifZnLKXYqa1mwyp395SkytYdtgNYDuSpXlY5IXX1/B6ZZJhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XtRQkJSu; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-40b32b6af9eso948112b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067693; x=1751672493; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iwbNmWnwrhGbfrT7YdfqYIeoba1brn/qJ+hnINiPsI=;
        b=XtRQkJSusSANrW+LjCncPv0Gb0LGW0zhaGJnAWOt90IEAI2atnCRnSgUy9MqNo9Itk
         kFB7PvK0Q/NrkKX7APBFNaar42N5Lg1Cv/M5r8PCV1pvrsEFc6R4FReUGWXTS6l/5pp3
         drp0D/LBtT3kTn/t4pKx234P3gHHcGzqFrpdNkUfVq7m6/PhJZN6MPJg4T/EnhdWsIRh
         TdGB8K+ZyAxdshhcopfsDtvllpdosOZDE8LJZcHzh3imxWb1R3z+LzI5XE7otQBZA73i
         D0SdYQ1JVchFNOx0yFA3qyHAkkg3K2EnsGgjUeZlAdCcbK1oVSImUs2zTmpY5nL72WGX
         1qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067693; x=1751672493;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iwbNmWnwrhGbfrT7YdfqYIeoba1brn/qJ+hnINiPsI=;
        b=EVUDfr8sAfKgH23voPoeV+Ii2ZVxXfmbGDiThsmmsyUSecyk9NYurF4bepTHHlGmpa
         dFKWrFOtYZqhoTk3cQJY4NemOwaam/ZyKXvdtX1l78lpF/y61f52ELxBqhFHVmkXy1Xl
         7c4r5V4Ih059v5liDOwoHmW9OekncukNJBKYkNdD+iSD9xHyqvEqc4Y0Ebuc0NjNFSyE
         bNxMehOJewW/XqPtkLAXH6cVExQuEiO/TAL9SqzxkhCqw/V/+luDn8P2T6Z0zlCu/k5V
         jEHF1T7KvvtglBAe6aGzFGYKHeREpuelaOHxILwu05PjRet3v0Q1uTeQ0FleNDu46slt
         lAXw==
X-Forwarded-Encrypted: i=1; AJvYcCWh/JWk8As6LKrKg1wzKfBSGB+7+VwkPfIX/ubAn7wcv/AziO3UQv/41dOnTXVcK2BaLA2ZeVbGKKWhZZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUb46Q8pQoVLUOxNKdTkleLXckD95W9HvrV+TfVcpOM/BXBfcs
	w42Q/Ckyl+LuUs43ZgaMdHYiTAmckBlxom8v+QTEbaMYU9Ziw7yTRtEVr9aiLaUSf1E=
X-Gm-Gg: ASbGncuMbbq4yi2xx6PG2oSVx1YDx8lacamewhb3Tqa6TRbpTfZoX/3SvhqTH05dZjs
	gib2D+QcHSDyIJW0o9DAg373ktoHZ6K/JIFpjcgXMWS6ZpmJgKyYFDMQWpTa74gugaKM6LGHXXI
	w0Yq32onaXeNdwcqH9XhexdwqfIqUvultFF3pWUf7g4d5K4Jmx0ABFRcV2hNaAHJZksrXiOcp43
	F9AcxwmgcSuOznYul6Lp7h/L952NOY23hrHXiJYGoh0h+ME6GA28IP1bVv5HITiua0eFNgWjMO+
	7QJATZnoY7j8NE878KDu+zOQAF6vjC0rZ0AXRAGR/22YnromPlE5pZQPZT8I+OTtxNk=
X-Google-Smtp-Source: AGHT+IH+448kgf864CgSqLTWJUXw1D/YDaapL6g2xhmRXZborzFLiyfuV3mt5ne9VPRC9riu+hk1fg==
X-Received: by 2002:a05:6808:2385:b0:3fb:85cc:9f27 with SMTP id 5614622812f47-40b33ac8e41mr4264778b6e.0.1751067692936;
        Fri, 27 Jun 2025 16:41:32 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:32 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:40:03 -0500
Subject: [PATCH v2 07/11] iio: adc: ad_sigma_delta: use
 spi_optimize_message()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-7-f49c55599113@baylibre.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5695; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=UWnNQjC9xY1Xwfu0SBlWSeVKesQj5uaRhdQrBvWhhA0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXywBjJObaNHVaWoiK2VxvYxEPhXkdoVtYA3bg
 od/i5eAfpuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8sAQAKCRDCzCAB/wGP
 wCiFCACQ6zcWMQqtw6hEuiiyHHeH1+ZeloLoNUEIXcuGbUjkYnHLS0Po1PFxPZ7XFKns/cuunIZ
 1PVB5YpfoxEhTc0kOz1Z0tTKK95g1nM7aGWH8Iom//T1fSp5q0gMzgPqmOwxIarH1kU5VX4xr43
 97TGyDU526jH7dtBH5Kx0X11iUxXf/dtzyPWmiFTeV5jTxiuOV8EUg+ydanMvAOHiBoHum3Dkor
 8TrRBE/gnlWBSz6h2bFPX00inWhEw7uQ5VsKxgZmyQnf9kPhF7SvmOLEtGRcw2OU6LeLgE5Y9Z3
 CILib2nqlXiGfGlHyWQYYsrL3+i5ooubCUePwDrRv6KILtfq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use spi_optimize_message() to improve the performance of buffered reads.

By setting up the SPI message and pre-optimizing it in the buffer
postenable callback, we can reduce overhead during each sample read.

A rough estimate shows that this reduced the CPU usage of the interrupt
handler thread from 22% to 16% using an EVAL-AD4112ARDZ board on a
DE10-Nano (measuring a single channel at the default 6.2 kHz sample
rate).

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c       | 72 ++++++++++++++++------------------
 include/linux/iio/adc/ad_sigma_delta.h |  3 ++
 2 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index d8101f5d443f957a398e66db1dad0d1f73c16078..30ae7ef6d3f9f686b02176508813c689e6fb92f2 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -466,8 +466,9 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
+	struct spi_transfer *xfer = sigma_delta->sample_xfer;
 	unsigned int i, slot, samples_buf_size;
-	unsigned int channel;
+	unsigned int channel, scan_size;
 	u8 *samples_buf;
 	int ret;
 
@@ -509,6 +510,28 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	sigma_delta->samples_buf = samples_buf;
+	scan_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+	/* For 24-bit data, there is an extra byte of padding. */
+	xfer[1].rx_buf = &sigma_delta->rx_buf[scan_size == 3 ? 1 : 0];
+	xfer[1].len = scan_size + (sigma_delta->status_appended ? 1 : 0);
+	xfer[1].cs_change = 1;
+
+	if (sigma_delta->info->has_registers) {
+		xfer[0].tx_buf = &sigma_delta->sample_addr;
+		xfer[0].len = 1;
+
+		ad_sd_set_read_reg_addr(sigma_delta,
+					sigma_delta->info->data_reg ?: AD_SD_REG_DATA,
+					&sigma_delta->sample_addr);
+		spi_message_init_with_transfers(&sigma_delta->sample_msg, xfer, 2);
+	} else {
+		spi_message_init_with_transfers(&sigma_delta->sample_msg,
+						&xfer[1], 1);
+	}
+
+	ret = spi_optimize_message(sigma_delta->spi, &sigma_delta->sample_msg);
+	if (ret)
+		return ret;
 
 	spi_bus_lock(sigma_delta->spi->controller);
 	sigma_delta->bus_locked = true;
@@ -528,6 +551,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 
 err_unlock:
 	spi_bus_unlock(sigma_delta->spi->controller);
+	spi_unoptimize_message(&sigma_delta->sample_msg);
 
 	return ret;
 }
@@ -549,7 +573,10 @@ static int ad_sd_buffer_postdisable(struct iio_dev *indio_dev)
 
 	ad_sigma_delta_disable_all(sigma_delta);
 	sigma_delta->bus_locked = false;
-	return spi_bus_unlock(sigma_delta->spi->controller);
+	spi_bus_unlock(sigma_delta->spi->controller);
+	spi_unoptimize_message(&sigma_delta->sample_msg);
+
+	return 0;
 }
 
 static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
@@ -559,50 +586,19 @@ static irqreturn_t ad_sd_trigger_handler(int irq, void *p)
 	const struct iio_scan_type *scan_type = &indio_dev->channels[0].scan_type;
 	struct ad_sigma_delta *sigma_delta = iio_device_get_drvdata(indio_dev);
 	u8 *data = sigma_delta->rx_buf;
-	unsigned int transfer_size;
 	unsigned int sample_size;
 	unsigned int sample_pos;
 	unsigned int status_pos;
 	unsigned int reg_size;
-	unsigned int data_reg;
+	int ret;
 
 	reg_size = BITS_TO_BYTES(scan_type->realbits + scan_type->shift);
+	/* For 24-bit data, there is an extra byte of padding. */
+	status_pos = reg_size + (reg_size == 3 ? 1 : 0);
 
-	if (sigma_delta->info->data_reg != 0)
-		data_reg = sigma_delta->info->data_reg;
-	else
-		data_reg = AD_SD_REG_DATA;
-
-	/* Status word will be appended to the sample during transfer */
-	if (sigma_delta->status_appended)
-		transfer_size = reg_size + 1;
-	else
-		transfer_size = reg_size;
-
-	switch (reg_size) {
-	case 4:
-	case 2:
-	case 1:
-		status_pos = reg_size;
-		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[0]);
-		break;
-	case 3:
-		/*
-		 * Data array after transfer will look like (if status is appended):
-		 * data[] = { [0][sample][sample][sample][status] }
-		 * Keeping the first byte 0 shifts the status position by 1 byte to the right.
-		 */
-		status_pos = reg_size + 1;
-
-		/* We store 24 bit samples in a 32 bit word. Keep the upper
-		 * byte set to zero. */
-		ad_sd_read_reg_raw(sigma_delta, data_reg, transfer_size, &data[1]);
-		break;
-
-	default:
-		dev_err_ratelimited(&indio_dev->dev, "Unsupported reg_size: %u\n", reg_size);
+	ret = spi_sync_locked(sigma_delta->spi, &sigma_delta->sample_msg);
+	if (ret)
 		goto irq_handled;
-	}
 
 	/*
 	 * For devices sampling only one channel at
diff --git a/include/linux/iio/adc/ad_sigma_delta.h b/include/linux/iio/adc/ad_sigma_delta.h
index 5056677c9941afadc2383febbcafeb02e23a4f44..2037bb68b44115681ff48f66b580b63f50c2ea9e 100644
--- a/include/linux/iio/adc/ad_sigma_delta.h
+++ b/include/linux/iio/adc/ad_sigma_delta.h
@@ -105,6 +105,8 @@ struct ad_sigma_delta {
 	bool			status_appended;
 	/* map slots to channels in order to know what to expect from devices */
 	unsigned int		*slots;
+	struct spi_message	sample_msg;
+	struct spi_transfer	sample_xfer[2];
 	u8			*samples_buf;
 
 	/*
@@ -116,6 +118,7 @@ struct ad_sigma_delta {
 	 */
 	u8				tx_buf[4] __aligned(IIO_DMA_MINALIGN);
 	u8				rx_buf[16] __aligned(8);
+	u8				sample_addr;
 };
 
 static inline int ad_sigma_delta_set_channel(struct ad_sigma_delta *sd,

-- 
2.43.0


