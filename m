Return-Path: <linux-kernel+bounces-594835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A910EA81729
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 22:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1451A8A3E28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 20:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B282254853;
	Tue,  8 Apr 2025 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W4XIMVw7"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866123E351
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 20:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145441; cv=none; b=UXCuGewQG5VR/olYivnsoma8dM8CYDWrHKBiR6ilsB51YHexaNnc0qvjq1douEkv25H+EtOSb6AuwyCD/xOlk4kIQu92QpZCZJclN+4CWkBO7emFwOaLe3d14X92xllAr0dvBGzA91H9VoDkXo7WBNdpL/xiAXrXe4NCO1nFd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145441; c=relaxed/simple;
	bh=eancYxsdS8ilWV/yH6R/v1xMz01IuEitBHlNQIXr5tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8ZNimd3IiMr40jPhEj2SIV7BJRQUn35zo0wvk8OJmvkoce8onh6rniqW8eBeUMAShszohMoGA5DVAdvFe1z6xQtmAIEBBS9/WdRcqXiqdNv1fQXihNAgHwO/+zhVc1SYW0AdHqTFV203OW6iqwKHPygmBX1bVz2uIdWmTJMFIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=W4XIMVw7; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d04dc73b7so64516285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 13:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744145437; x=1744750237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+pYdHOLQi/v2mVLbftWrP4lbnz9O33riEVXb/sTc98=;
        b=W4XIMVw72kSdnhSAbSV6QBywBdb/MTMhfMjiUDeTDB1urDtah3srR43xpdK2djU0U/
         yhaZKtFtdxNUmbQbhKPdHjhPLpuhNf46OUHiOFRImz9a1PmD7pVHiUiws5HtMABUOKsI
         /5ANXYU4l5FN1KjF6fchwUcaUja6iLYwO86868kuEK9Zwii7nnn2IbXzLbz9kMpmmvs/
         iEME3rOIpjeB2ytj1df/8xW1L4QsXdji1vN71fdJ8OXBgsQWILDazRVQgjOFdS7YCHRa
         xAy5/Q+uUY5v/kLc+LP/0r9ti1LB/cVxLU4+wCpZvx8zGYH2U0A2cOwn7i/Q4PprMbKA
         5DLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744145437; x=1744750237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4+pYdHOLQi/v2mVLbftWrP4lbnz9O33riEVXb/sTc98=;
        b=fN4LdBBF3DDXFiI4O0yBVdy1tUwL4Qk/TEEhmxUiVq+sLoCQGBtjwDynv+n82QbOrs
         UcLvFwiLUJJ+hlPoKIjqy4mJNa7RPfhsSM/DvsD2lGhT4XmWbcxNZZcJnRf8D2Xy60pz
         9Bv8M4DcQAckoMkTR96B8fI0gXW0VY9bNb4ke5ylnuabJJ8yCkZtMr7sriVsZPGVQrCs
         s3Fgo1l1UpRuo6A5XALvpvZ1wqprv4O+4n2uZz8f3G4gclG052TLHkaAc2UGSj87XiyW
         ph+GTCgAxI6dLVkQtazwg5AK7RaE3VuimD26DIAbiXKFhuG5dgxyKkc8RkkJ/3XyI8Xs
         /5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZvZXrlDQqhPolEKEqI331SVFssVL8fiV0o5OD7M8DkZbU2ygj2SRqxmPfgFN5c1RUZHk8gM3OQI4U0SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDUr54KPkyf9RkpcpApXfYSsP6L3+rf67/x3aSROi/KxeytbgB
	rnjZgh2fXATrTxJocMFsiHfNqy5zE1KbC2akkPQXBbHzhezq9BD7ImiWl8rAj2PR+JaShoAUV4R
	Y
X-Gm-Gg: ASbGncur6/C67e0w+64XzwDCON0MW6M7n/NAlea87DOsZd+bDk65PHQTpV0TFTE8yIU
	P8AlmdJCOacv9qpdz7v21Qdc9jdqhtm+PhqgVnUikeyEizOHZzr92rnlr0BR13n0EQBHj4wnBSL
	fZBwSS4Owx+XNjxrkGmrs+U5PuwDt8KszYCjRu2mwWZZJU2ZrwJnO42YsFhncAHiIRMMm0IYz/f
	9xGSmK1YZL6RTZYkK11YTrYrN73zxMWE3m9P1hnfafeQdlQBEk1v2Sm/jEBu6Rd9cGJTvMW4spe
	xtubVny355rJOA7pDkJ5T7SSJmSc6rNTEjDWXR+nkxuBkWPfqJ1spQ7Lhl7q45QndlqRvh6057I
	swrc2Oz4o2jGxbfE2qz7nAA==
X-Google-Smtp-Source: AGHT+IGAqrtAozeX4mHTyoFtvprWgQZcWnfcTxGTeZnvl6CteFk2bRlR166j0MpMYArr04A1quVbUg==
X-Received: by 2002:a05:6000:2910:b0:39c:13fd:ec44 with SMTP id ffacd0b85a97d-39d87aa0b71mr528626f8f.5.1744145437456;
        Tue, 08 Apr 2025 13:50:37 -0700 (PDT)
Received: from [192.168.0.2] (host-87-15-70-119.retail.telecomitalia.it. [87.15.70.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226da7sm16367156f8f.98.2025.04.08.13.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:50:36 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Apr 2025 22:49:00 +0200
Subject: [PATCH 1/2] iio: dac: adi-axi-dac: use unique bus free check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-ad3552r-fix-bus-read-v1-1-37add66aeb08@baylibre.com>
References: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
In-Reply-To: <20250408-ad3552r-fix-bus-read-v1-0-37add66aeb08@baylibre.com>
To: Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2602;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=ozxNUeMl4HqHZ87vmBOdOVasJbRl377XUsrzZVApVsE=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYkj/2n0oPy5ClFsjKnP6o/Pxwl6+buxbfI7eYf691LSsm
 0u0IrG1o5SFQYyLQVZMkaUuMcIk9HaolPICxtkwc1iZQIYwcHEKwEQez2JkeNPS1f78ctFl41zD
 Y6axbGf7OWdyvPh0OsFX4HZn9SkGDYbfLG9nN7RPeHR+bf08z6sKy1KXtovd/3iu/opRffPk4zf
 mcQEA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Use a unique function for the bus free check by polling, to reduce
duplicated code. An error is always thrown in case of timeout.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 8ed5ad1fa24cef649056bc5f4ca80abbf28b9323..91557aa6797a3478de3607e5733c162d7745a3b2 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -635,15 +635,26 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
 			       AXI_DAC_CNTRL_2_SDR_DDR_N);
 }
 
+static int axi_dac_wait_bus_free(struct axi_dac_state *st)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, val,
+		FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0, 10,
+		100 * KILO);
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI bus timeout\n");
+
+	return ret;
+}
+
 static int axi_dac_data_stream_enable(struct iio_backend *back)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
-	int ret, val;
+	int ret;
 
-	ret = regmap_read_poll_timeout(st->regmap,
-				AXI_DAC_UI_STATUS_REG, val,
-				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
-				10, 100 * KILO);
+	ret = axi_dac_wait_bus_free(st);
 	if (ret)
 		return ret;
 
@@ -734,12 +745,9 @@ static int __axi_dac_bus_reg_write(struct iio_backend *back, u32 reg,
 	if (ret)
 		return ret;
 
-	ret = regmap_read_poll_timeout(st->regmap,
-				AXI_DAC_UI_STATUS_REG, ival,
-				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
-				10, 100 * KILO);
-	if (ret == -ETIMEDOUT)
-		dev_err(st->dev, "AXI read timeout\n");
+	ret = axi_dac_wait_bus_free(st);
+	if (ret)
+		return ret;
 
 	/* Cleaning always AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA */
 	return regmap_clear_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
@@ -779,7 +787,7 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 				   enum ad3552r_io_mode mode)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
-	int ival, ret;
+	int ret;
 
 	if (mode > AD3552R_IO_MODE_QSPI)
 		return -EINVAL;
@@ -792,9 +800,7 @@ static int axi_dac_bus_set_io_mode(struct iio_backend *back,
 	if (ret)
 		return ret;
 
-	return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
-			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
-			100 * KILO);
+	return axi_dac_wait_bus_free(st);
 }
 
 static void axi_dac_child_remove(void *data)

-- 
2.49.0


