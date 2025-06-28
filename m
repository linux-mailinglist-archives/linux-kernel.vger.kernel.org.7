Return-Path: <linux-kernel+bounces-707366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8897FAEC31D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jun 2025 01:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783571C259D7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jun 2025 23:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8C9221FDC;
	Fri, 27 Jun 2025 23:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ehz02Agl"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B51291C34
	for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751067688; cv=none; b=frb0AwW7LEPfLJc3xV1sdMCmSMCmZrGEL3X9JaWLNFMDszK7Bxxqyml5QRmLZpJnLcTaElvMH9ZXe92ekkRYANnFoWCvo0erBxt+W+LIeC53dB9qomjAcMhp/uXpETcqt6cDTOaeB+OUB9iRYVFFPMMD4nN/OFYg+n3tvDReIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751067688; c=relaxed/simple;
	bh=0yYId7CmKo/+nPN29+4m0T9CC1yhegBE9FCPgm6tkyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAIovYMYexg+s0DtDMAxqUBCZbPXbJ0M5kwRlvN0UD37keNsvMQaN9879oIzlHwIbJxEbHjUJmJh/A+qH+8ZUocl3Tm/qkddoL2P8y6m8XjdMN0lz+INrJHDH8UDojavbAWehU8UDluMkM14ULEGTRRe7Tz/3REypS6wQdo3uz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ehz02Agl; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-4067ac8f6cdso322783b6e.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751067686; x=1751672486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xaL2xzco1uO7UeMG0BpmNABPZ9hJVHgxxIybCcO0RO8=;
        b=Ehz02AglaaqgD8918b18JM8JM6ttx/innhaR0RLjDSkjhUs2aOh2CKIadCv5/uToQe
         cxfz1nNfY4dCjTAxCfNj5xALpbO5EedD4Z8xqs0/hcM0R5dP3eAn532U4Jz1EqvaannE
         okCMNvfPbOZMQ3asmIJnaZf132RE32OUzmfWNw0x+2llQbweVqYlMvJrs52rLIinBfqj
         VTcDC3is5rx0gVj1qGO+XAIe9pawgeoQ3CAiH1bRXKKOksgL9+y6IJ3uO3yRtWXFBwrR
         BJE6KXySDL0YF1HkGEYz9DQhsKT+357W4WOzsmEcKY2hP02O6C2Yjj0azsY7nPDWrFyX
         Aepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751067686; x=1751672486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xaL2xzco1uO7UeMG0BpmNABPZ9hJVHgxxIybCcO0RO8=;
        b=my74iIwyDpysoOsuezX3o/B5WPTn55LtxM+Sz4ZMVruDtexqZ5SCDK9SZG6l10JGCX
         letQuj21d/g1ckygeIHJfv7jf3KvwNQfjL1gxzFoFM0GXX20X63ceb4paUUH1LaiAv2R
         KKboD5UgohqXPzXTH/zBhUwWCw54b56t2J8NEFK3JDgt46Jr/fZLL/FSt/kT+QzZxbbf
         kANDFma02pHDMZg4iPLwkOZhLsyCWvq+/2+8rMyYb2QYrmIpXz9IoeLqn0k3oT5MWQYt
         S0+A9RHmrzWnXCORc0dS4CA4L7i6lndUTOxRzq5aXPEX34naZzrRnF4gsPSz5HOAm220
         j0Qg==
X-Forwarded-Encrypted: i=1; AJvYcCWbkBHY4rCIWYZuv8Swk2Gm6rXEHlNKIyrivoId4LEh61pJTRHqwOB13Xdf36YnCP3FOw1UKNc2vz+xGkk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw59S5YkWFHVTGbfmRqz9gLd5Dy1TrjGzkbzM9E5n5k4oymyjdM
	eVRj19M3M1svMPlXPM+NfdQQEUJb6o2eiG/4iEVD1co3vAIQFGlGVrIJfRh8LyBzKtc=
X-Gm-Gg: ASbGncstyWrcYMIzYhoECr7sydlm4AK6s4sS2cT1PR5APHfYNg2qhfBf3SFq4/cA2ax
	uWT1hK6UCz4ATpRLv1eoSQuMCDBnPydq6dheekBD5F03jd5XiurWLWwXdNUFbXsrpPYZ+0RgM79
	A/Oni+FIHbUPDN0UXo6ms5OHvxa2B6/ij0SDRGgBOQ3qeajIOVzp5izqLzOitYm6VLS+vaDIaEX
	80v+UKoYyN7me0CFX4vbYPuzfXfPAKSUdDadKodmS3sHUU1MaNbWPCxCUsCWwp1O1cVc55PlRXe
	fg6KkGgkOV69g8Q9TSP1OezxeznSeXwQ8YY9sK6QH9jKPYNMDCZa7mZle0liZWa7fYc=
X-Google-Smtp-Source: AGHT+IGO6lAxDYiAUSvgyLFtpRPPATaclvQB+pcm3lsuX6smcfmglueV4fyHhGV2aVGGAamMVe90Nw==
X-Received: by 2002:a05:6808:80c9:b0:3f7:d16c:e283 with SMTP id 5614622812f47-40b33c78e69mr4539437b6e.11.1751067686119;
        Fri, 27 Jun 2025 16:41:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40b322ae4e9sm568483b6e.17.2025.06.27.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 16:41:24 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 27 Jun 2025 18:39:57 -0500
Subject: [PATCH v2 01/11] iio: adc: ad_sigma_delta: don't overallocate scan
 buffer
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-1-f49c55599113@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=0yYId7CmKo/+nPN29+4m0T9CC1yhegBE9FCPgm6tkyc=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoXyvZJrVOeLE2k6/aVVIHrXp2W07Q3xZQASTEO
 QVFiFjP/faJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaF8r2QAKCRDCzCAB/wGP
 wB/aB/wJwURJXvafTrvrK8ufRZppvAXSjMZBuIT85AEXQRrU0MUsYobunJ5v2lPFVC8SvR8a5Xz
 KlyQBuKbLk5QMcP8Qc4M+TiQhNuCmzWOnzwAvhzOLEVAPr1uxcVYloODK0D01eXYKNfvOHyeudz
 j/VbzqO8gS+tukC9Pyx8g9IeF4JcsdVx9tjv0hUt8pDM7vH19rFaiSeicQgWOEF4KeLRYPLDjwF
 tZ5QGM53wWGpTtDt5r0SEzd8+orrafRaOMCQCZlT1VcXvHkgqZHwRl1k+bHXfN2uY0qS0E+MHCg
 RBoRQuP5eZO8K+8iHYxyZ6z1UcMstYROq0xH6kqND0vznmoE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Fix overallocating the size of the scan buffer by converting bits to
bytes. The size is meant to be in bytes, so scanbits needs to be
divided by 8.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad_sigma_delta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigma_delta.c
index 4c5f8d29a559fea7226b84141bcb148fb801f62c..6b3ef7ef403e00804abeb81025ed293b188e492b 100644
--- a/drivers/iio/adc/ad_sigma_delta.c
+++ b/drivers/iio/adc/ad_sigma_delta.c
@@ -489,7 +489,7 @@ static int ad_sd_buffer_postenable(struct iio_dev *indio_dev)
 			return ret;
 	}
 
-	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits, 8);
+	samples_buf_size = ALIGN(slot * indio_dev->channels[0].scan_type.storagebits / 8, 8);
 	samples_buf_size += sizeof(int64_t);
 	samples_buf = devm_krealloc(&sigma_delta->spi->dev, sigma_delta->samples_buf,
 				    samples_buf_size, GFP_KERNEL);

-- 
2.43.0


