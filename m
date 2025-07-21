Return-Path: <linux-kernel+bounces-739953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B8BB0CD81
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5962189E040
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17582459D1;
	Mon, 21 Jul 2025 23:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="k2G0cZNT"
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422322B595
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139057; cv=none; b=KsKWKqGb1ivcKHwQXjgvdpCCYr3/vVNDPrIL+HpVwSr+esR5+KLY2z7Pi0rFM+Ubnsxcu3JdmsjjBuhxayCjKyypeETVZ+M6aZsoIOdSK8L03uHjmBUWX/IscyGeDquPEDQH6fpvScjkyIP2OFZ2IjcsWu5z5T3ATlltDlWNuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139057; c=relaxed/simple;
	bh=CVzZxAIo8VSXhMDtW4lVVfKTU93BFVb+GE+/jPo15wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U+5X61hZdy6uBCj7s/g//6bcXrPDDevo6m/9lclxTiM88AMG6rspz8z/lK6W0/LKv1Hvaiy9ZIByn4ncNK7010mfXFR+902YZVDXJx8p1YGu46IXVFq/c4Csyy5EZeEVSmFRdGBeol8+D9M8HI5SNuIi8KoPBQaGdLOyyIYZBqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=k2G0cZNT; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30008553e7eso1830012fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753139053; x=1753743853; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3XjuVctm6NjoqaMg/cxuuhCaXLbFmTYKbU+xYGy04dI=;
        b=k2G0cZNTl1eNSsq4rngS2dglPAKVFmEYxQfjGplwo0XOVy+7Zb/Mh+64GiCh6gP80p
         GZVjaGDuXlMqntDWxv6326OmfDpvLjt2LvSPUDQBbuqsMYtQv/1rJLPInd5REl+amXvp
         OrvnAM/HzeAiJDlg8KKCkDtVjJ1ubJ2C6vODaSdLx1xc6joYDY43Lg1axhZy+a9qfk6s
         qOqor0I84re3hNvepbfQ0ROZijP7Zox4nDB9GD+xXWdqjjUGvYblUwkAjtFfjBRGxsv4
         IPdcVNCnVzaXH/Z3VF4xKihuTfPXZ8KsS02j38LNNPe4l72Z3V4wJy05GXWajK8Axdnl
         fMfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139053; x=1753743853;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3XjuVctm6NjoqaMg/cxuuhCaXLbFmTYKbU+xYGy04dI=;
        b=Vg6wAGLg2sHmVGwWQw++2HPQOSr2EZiB4xdk09YXlBJCRclp2VXC7o5soUM2DWcvC8
         UZR7+Q1RkLhT+bPqkxu1Me+yJsemgcM6m3kVJYvzqy0cO3Gw4OzlXkt0mUuWcMBfR2L+
         iKTQHalHy3nN9LAzV07mQnerqYwzYI+Pafn4BfzgBZMnwzYYYjTiCJvFroUQXJcK9jBO
         nXPvfcT4SbNWUWLlmmnXiDAyal/jO6SB9v9BkpTbmUWBf5uBe7gtqnUDAejTJmCHPpqR
         UdWuVGN3mR+L/u2Qlh4fL8vHquvI7KRc7MoZtJG/N6gYXkKwA7DftAcsoagN830q/X2k
         fLOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMA1EPiGpG6/ltVNNUj1+4K/GFl46qnbE5toRw7zPNpKcg5NG6XScXxfNMG9OeLF5xvM0FG9OaWUL5Hqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTDhYSRMlRvJPEc3AzwixFLE/E65dPtg1BTWw1pqmTjFehLRjM
	0KgH8QRcpZvO+93VeRhL8StT9E5JGgWd5bimhjopDOyC3rZxhT7WLZL7i9sfDwgRs8I=
X-Gm-Gg: ASbGnctf/WT863HIvHpUwfmsArQQjGZI93z0kXhEAtLDpgKc0QAmYrfFOrOI/hP0zeP
	j7q3Pw14zYfnorttUBFb1OQeJRE5maCpqzSbgOyyGRt8fOPYlYabO5/5fbp8k71fLC2VJiRJKvr
	vdXUpW6NbWGHQB5aK3h+08W9KYoqjznCIzqlnLZnZGynupeEfiaXr/gqCyNw5U8r4SEy41cSzII
	vKPkXHbo1vpnnDbcsAUe8Ni+50GKoAPntWC7vCMaiWsaLbrjXe1/q6RszzFJlQ/bwaLp/KDKAxC
	CANQS+M0Eb2hKT2o46YbMR7p5mA4BBXS50ZlpK9HF7LpZJVFA1PTc+3Eqs5Gdb93DWRy9MfJDva
	bCRyLES5hUdOxMN1otzvT9G+DTVjS
X-Google-Smtp-Source: AGHT+IE1ajgrpgjumZWgfAKx4BBDWDURo81gQezi9Ij7W/wmqR6qfdmg+PuK3KmqobuocjSp+7ArMg==
X-Received: by 2002:a05:6870:cb95:b0:2ff:a802:6885 with SMTP id 586e51a60fabf-2ffaf2c74f8mr17344358fac.11.1753139052913;
        Mon, 21 Jul 2025 16:04:12 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e8fc51467sm2662952a34.31.2025.07.21.16.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:04:12 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 18:04:04 -0500
Subject: [PATCH v2] iio: temperature: maxim_thermocouple: use DMA-safe
 buffer for spi_read()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-iio-use-more-iio_declare_buffer_with_ts-3-v2-1-0c68d41ccf6c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAGPHfmgC/53NQQ6DIBCF4asY1qURiGi66j0aQxCGOomWZlBbY
 7x70SN0+b3F+zeWgBASuxUbI1gwYXxlyEvBXG9fT+Dos5ksZVXWQnDEyOcEfIwEB4wHN1gC080
 hAJkPTr2ZEldcOqea2mrdecfy35sg4PdsPdrsHtMUaT3TizjWfyqL4IIH7b1SWgXfVPfOrgN2B
 FcXR9bu+/4Dh1QwLuUAAAA=
X-Change-ID: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3485; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CVzZxAIo8VSXhMDtW4lVVfKTU93BFVb+GE+/jPo15wQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBofsdlrfHL/YVQQFy+i6DSnuGVH+VfUWNeLa4sL
 QCd/KZqw5eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH7HZQAKCRDCzCAB/wGP
 wET3B/9bZyGjpyC2YDJxrGhYIbCEe+yvmrrtNCHLm/ny3M/yzAOFpHBOGyaF0z9SazFNYMugQN+
 pBXbXZt5jduSEHuFCjLRQpo5eGhwaKmbxZKHxzkBecMx3qfCvC6Ko2BWe90ixlXioLFNxX6KbEC
 99nq5JEgZZgvRETBy9zSSKR16EemLDbKCOO3EWVsCowSgGS+/bMUfivTVAa7gg1QUI8vhfE4Ntd
 /CM4x0rj6O/bc9gVGxd8EHJp2rrwnFPGg9wsJYHYMhOtceQbt7B1/v0VXdM3paO27TcN5MvkH0Q
 4YjzeUAlNznpwsfDdMZg1dBQGILixoDqQxS/qx0igWYDDbmF
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace using stack-allocated buffers with a DMA-safe buffer for use
with spi_read(). This allows the driver to be safely used with
DMA-enabled SPI controllers.

The buffer array is also converted to a struct with a union to make the
usage of the memory in the buffer more clear and ensure proper alignment.

Fixes: 1f25ca11d84a ("iio: temperature: add support for Maxim thermocouple chips")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- This is a new patch since when looking at it again, I noticed a bug
  with passing stack-allocated memory to spi_read(). So now the primary
  purpose is a fix and converting the array to a struct comes free with
  it.
- Link to v1: https://lore.kernel.org/r/20250711-iio-use-more-iio_declare_buffer_with_ts-3-v1-1-f6dd3363fd85@baylibre.com
---
 drivers/iio/temperature/maxim_thermocouple.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index cae8e84821d7fd521d59432580d51def939fa4d1..fa648a6542a4e2f08adb556c776b68331ae69631 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
+#include <linux/types.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -121,8 +122,15 @@ struct maxim_thermocouple_data {
 	struct spi_device *spi;
 	const struct maxim_thermocouple_chip *chip;
 	char tc_type;
-
-	u8 buffer[16] __aligned(IIO_DMA_MINALIGN);
+	/* Buffer for reading up to 2 hardware channels. */
+	struct {
+		union {
+			__be16 raw16;
+			__be32 raw32;
+			__be16 raw[2];
+		};
+		aligned_s64 timestamp;
+	} buffer __aligned(IIO_DMA_MINALIGN);
 };
 
 static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
@@ -130,18 +138,16 @@ static int maxim_thermocouple_read(struct maxim_thermocouple_data *data,
 {
 	unsigned int storage_bytes = data->chip->read_size;
 	unsigned int shift = chan->scan_type.shift + (chan->address * 8);
-	__be16 buf16;
-	__be32 buf32;
 	int ret;
 
 	switch (storage_bytes) {
 	case 2:
-		ret = spi_read(data->spi, (void *)&buf16, storage_bytes);
-		*val = be16_to_cpu(buf16);
+		ret = spi_read(data->spi, &data->buffer.raw16, storage_bytes);
+		*val = be16_to_cpu(data->buffer.raw16);
 		break;
 	case 4:
-		ret = spi_read(data->spi, (void *)&buf32, storage_bytes);
-		*val = be32_to_cpu(buf32);
+		ret = spi_read(data->spi, &data->buffer.raw32, storage_bytes);
+		*val = be32_to_cpu(data->buffer.raw32);
 		break;
 	default:
 		ret = -EINVAL;
@@ -166,9 +172,9 @@ static irqreturn_t maxim_thermocouple_trigger_handler(int irq, void *private)
 	struct maxim_thermocouple_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_read(data->spi, data->buffer, data->chip->read_size);
+	ret = spi_read(data->spi, &data->buffer.raw, data->chip->read_size);
 	if (!ret) {
-		iio_push_to_buffers_with_ts(indio_dev, data->buffer,
+		iio_push_to_buffers_with_ts(indio_dev, &data->buffer,
 					    sizeof(data->buffer),
 					    iio_get_time_ns(indio_dev));
 	}

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250711-iio-use-more-iio_declare_buffer_with_ts-3-2cc387a66bdc

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


