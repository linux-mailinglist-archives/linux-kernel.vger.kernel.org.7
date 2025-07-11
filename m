Return-Path: <linux-kernel+bounces-727868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BF7B020D0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D65C7665F7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC6B2ED167;
	Fri, 11 Jul 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oHy5oHTG"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61B32D77EB
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248890; cv=none; b=qWYrltMP3sGddccmmFcTVyjdoXK0BGulHHXuyOWijoRGmsu7vGr4G4ApzgtUY5woCaounB72fNmdS/8wgCQArYJHGc9TSN60uxWCTYIZtjraQiGRB02u9nfY7xwztIeMR+Xzby+vCWEQ6mLPr+vpxjgJG7/PoHDhwwFKKAuieVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248890; c=relaxed/simple;
	bh=fPMY2FPNZ8s0+kp3RbA5D5imBYRyfPabypcKTws/Ezk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EEXvqthO4E+V/95gX+bgKEERAWEjDzvJ50jdGJ5r4lpjzcfj1LezARrp0aSkvfBGn93DKvK+i0xgk+f8AQjCssSi2B/VhD7PqGEYARqQAe8E2sCjoUF3Bx51KN+53TFv7avJygO+Q8OJqZZlHyD0V+SlSnGFU/o94gqqubDv/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oHy5oHTG; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-40abe6f8f08so1540891b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752248888; x=1752853688; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/F/GQiuB1z/Xyz/Nt1TdwiOkcOYhX5vbxVtB+zrbPw=;
        b=oHy5oHTGR/46EbQrLCDWftQsu1GiLCnZ7b27ANnk8kPvKc9ITnLWzsysHxGOWbLFgv
         3zSSrzDM2V85Rtbrg7xdRtF+rOtDfKuiTh/Q85lH7P8kxh9SBow3hjfzcqK+c30I9jyl
         zrmE8aCLRESkbXwt1XE0zrTti5ZnhfFFgvgBhhLZixAB1pbZDPesfh8hS9t6qKT4nNXT
         WilrcoDrRLgwkI8Ec1sU6wPZ1c9Pfy5nfWC0/S4K5g8LwsMevnmk+6O4xPWKJKuMI/sc
         MGQ4+/1RnvE1LSwumewwJx6W1LVTPGxfKlwMUAHwFP6BaX0arBNJiRDgcMsaxL66YAvD
         tYoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248888; x=1752853688;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/F/GQiuB1z/Xyz/Nt1TdwiOkcOYhX5vbxVtB+zrbPw=;
        b=IX7gwlb7sq/cEY8Au42Gvf4Z5Ikk/8soPaHigtT1LRUQUKNpl6FWER1Wj2py6wfo7Y
         Y/o/cZyQ3ERm/HkI7g/WSIcLOZiQfRcukpxyfzYjHm34HVCACRXlNtcFOmJvoFAkEBwi
         1zlU3EZo48jzSHZ8d7jKgeYquxj+CjMj4fDGCOFgubpXZAKOMytPUBcd4kB6dRBaaDyu
         JV4UF8YKwDTJTYPOSEz/EXodOcrtYsMRjTj3tEbhd001z5amrEtEmlVOuRQ0Zt9/BDO7
         CLdkxWMyHuflcioQcnUy33TPVPHi2xGUUgK3L+y/GLdFmrAoaeIYeluOpysGXymgiwMA
         ARoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoTBLJJyHLbFNR8QdzEQW64G6/QWsCcwWY9V2Bf3b0HvcQgoAhy5J3huubMeQmNb04acN2HHaQnZbTtQY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsOl+eedn9bOhtZVkY6Bx7BKEW6fruRMjqXnhs40vC3bYamnDA
	APYg7t1gV0D7YlbnF8oWOT1wbwICWppP3h5jdyjSqF4md0qu6aLtxMGjKZAgsN8hPHE7jsItezp
	fElDmr5o=
X-Gm-Gg: ASbGncutQQRiiRzCdE2LjJL1KtUF4jukDOPw8WZI48GvJsv9is89wL4XCI7XBRgOU12
	wz3ltE9afU49Qpay+bcopED7Q+8k2yONppGdbT2aQYKUOTjouVjIboPhbXOdXseuT7UVFNFBIaV
	lDNjA5I3AS1ndv8TcAV1kGXZk27lGBH70I+GFBiCcOT54wzDS+EzUsEmgquCQKNqZ4u40H2AhGN
	vieGFS10zCF48SL9tc0UaBdYRKnB+pdcTvNlNrw8tm0uQzu9UlWbwkaVck8gsrf+UGJuibieCoX
	SLF/E3GOAF8hJ328rXibEK/mpngz9z97AVRoL27VxKudNI9W0DO13uxQOVVnPIIM1Cowwm1aPE5
	KYK6d9P/VlDWU7eAlCuFX96B1H/gH
X-Google-Smtp-Source: AGHT+IF6TC9k0KZZtCSrvPjNSG60yv8ERg3M/uUzOKbpRSvc5GW7fYhJqrQ+rxt0YLPXaQsekE4tUQ==
X-Received: by 2002:a05:6808:5182:b0:40b:3c5f:534b with SMTP id 5614622812f47-415395c87d2mr2369707b6e.24.1752248887732;
        Fri, 11 Jul 2025 08:48:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4601:15f9:b923:d487])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141bbdde6csm553833b6e.23.2025.07.11.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:48:07 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 11 Jul 2025 10:47:57 -0500
Subject: [PATCH] iio: proximity: sx9500: use stack allocated buffer for
 scan data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-iio-use-more-iio_declare_buffer_with_ts-4-v1-1-1a1e521cf747@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACwycWgC/x3NQQrCMBBG4auUWTvQVBvBq4iEmvljB7SRSatC6
 d2NLr/NeysVmKLQqVnJ8NKieapwu4biOEw3sEo1dW3Xt0fnWDXzUsCPbPghCOJ9MITrkhIsvHU
 ew1z4wN6LREHv9wlUe09D0s//db5s2xcFiylAewAAAA==
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3193; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=fPMY2FPNZ8s0+kp3RbA5D5imBYRyfPabypcKTws/Ezk=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocTIuKiz43grPHTIDj4iQGH+oqWm2nLFE2/jEa
 VQ91iq83ueJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHEyLgAKCRDCzCAB/wGP
 wIN0B/wO4lJRwsIhMIAm7Dptolc15q3Jw71SaFLx+QNW2pAp2ghJWLPvT7MtcceMmEzv8CgUdaa
 1fVAGuY3l3rlJtwb+/a7YOiDHXJcB/TDHz2clW1JqSBUyn0fN+Ze/Ora82PBDw6yflLK9dQ9JyZ
 9US3CpQ3oFbGhm6c05RrE8Oob5I36afDXKMgTypxpZuReS1jT+bVSq4ueePXKJQTtydRebKfmT6
 6qpDurLeDx4AXenJiwG/TjVIgsgb/B38YktEGcGQ+nlT+yL8SnFu7u5fpkOkwealyUAz5r9HNiC
 2pTo7JizwTSJKziCpvBc4TP2bZpkPh75lD0AzifJfX6m72xA
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use IIO_DECLARE_BUFFER_WITH_TS() to declare a stack allocated buffer
in sx9500_trigger_handler(). Since the scan buffer isn't used outside
of this function, it doesn't need to be in struct sx9500_data.

By always allocating enough space for the maximum number of channels,
we can avoid having to reallocate the buffer each time buffered reads
are enabled.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/proximity/sx9500.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 05844f17a15f6980ab7d55536e5fecfc5e4fe8c0..373e60b5c92fcd508af6420fff8067794d429a1c 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -88,7 +88,6 @@ struct sx9500_data {
 	bool prox_stat[SX9500_NUM_CHANNELS];
 	bool event_enabled[SX9500_NUM_CHANNELS];
 	bool trigger_enabled;
-	u16 *buffer;
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -578,22 +577,6 @@ static int sx9500_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sx9500_update_scan_mode(struct iio_dev *indio_dev,
-				   const unsigned long *scan_mask)
-{
-	struct sx9500_data *data = iio_priv(indio_dev);
-
-	mutex_lock(&data->mutex);
-	kfree(data->buffer);
-	data->buffer = kzalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	mutex_unlock(&data->mutex);
-
-	if (data->buffer == NULL)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
 	"2.500000 3.333333 5 6.666666 8.333333 11.111111 16.666666 33.333333");
 
@@ -612,7 +595,6 @@ static const struct iio_info sx9500_info = {
 	.write_raw = &sx9500_write_raw,
 	.read_event_config = &sx9500_read_event_config,
 	.write_event_config = &sx9500_write_event_config,
-	.update_scan_mode = &sx9500_update_scan_mode,
 };
 
 static int sx9500_set_trigger_state(struct iio_trigger *trig,
@@ -645,6 +627,7 @@ static const struct iio_trigger_ops sx9500_trigger_ops = {
 
 static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 {
+	IIO_DECLARE_BUFFER_WITH_TS(u16, buffer, SX9500_NUM_CHANNELS);
 	struct iio_poll_func *pf = private;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sx9500_data *data = iio_priv(indio_dev);
@@ -658,10 +641,10 @@ static irqreturn_t sx9500_trigger_handler(int irq, void *private)
 		if (ret < 0)
 			goto out;
 
-		data->buffer[i++] = val;
+		buffer[i++] = val;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
 					   iio_get_time_ns(indio_dev));
 
 out:
@@ -984,7 +967,6 @@ static void sx9500_remove(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (client->irq > 0)
 		iio_trigger_unregister(data->trig);
-	kfree(data->buffer);
 }
 
 static int sx9500_suspend(struct device *dev)

---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-4-66ddcde563fe

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


