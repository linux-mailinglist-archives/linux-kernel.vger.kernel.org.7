Return-Path: <linux-kernel+bounces-880220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EC47BC25270
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 227D74F935C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F85C34C837;
	Fri, 31 Oct 2025 12:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMCMO6A9"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0119234AB1C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915373; cv=none; b=R1W2GgbyDOKzhXowMi9XpGUpMEq/fjJtsJtpzjMRCkv1cmDbEg1UkilE9rWdHwwAwrlpQbs362VLh1d0ZheERBTdP/BZus4enpSBcG6FzV2gy27Mis1+SN1PDFn0/n529J4duLiyp5GTmKFyMpCAuokVWgVCU1PqLYh0OI8/wX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915373; c=relaxed/simple;
	bh=qrePO2TK/xL/G9ZFtgdmHMhzoS09DkAF2L3GWw8CmWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u2uGJJssisbK46KknfEkAXBD7MhTLbF27+U2wi0k7s0LNiRveCp+2edFzj2zmIuWYSdJ86A+JTG4Ff79mKp1fCvxWJ5xPAsUhU6h8UZPx4qP8R2DJE+s3B+hMq8VaL4Y3u6swFCvfC2YQdZzWJ6YV6F+AZQSuDdkBwUsVwB5Lh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eMCMO6A9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471191ac79dso24608345e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915369; x=1762520169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwIK/V4pnfd3q3cRM1eF0IWydHjyhl1l5vitzaGuW2U=;
        b=eMCMO6A9ILLBfxel5ScoIB4F0gObeg7rMV1La1EzTHcjvBEg9Kre0aUdkwCg06FCAK
         L0i6KDhK8GHskOJ+gTlXj6kq5QqOfJoSGlPFblmambexnvdtiLd6wDUvfiOkTMXM/D02
         Lx03u9v7GddtFDx19Auo7YFRfTU5+ZHjxtxBtEyReLuSdhauq/ru07ezD974N49eN968
         cjWpHGcaC1bDtH5t2QyqbBiCCb7jvDJlKjZMtOWrPC0U6ug3HSNWd4wJJGJ5r9ug9mFY
         oH2XQrVyHTbDfxP05VpHRAPdMeSRMsW4o2F6gyED/afBYH3RP80I0FT2Zo1rDjSSFfMQ
         FmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915369; x=1762520169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwIK/V4pnfd3q3cRM1eF0IWydHjyhl1l5vitzaGuW2U=;
        b=QB8GvlFVudXCR0n+KBWkv4Vzobet1K8z8egdlXgNOuAsvnO9kk224QKmv/hNrctHPa
         5TLud3S9NCl9BpTu9t50cIsYVKZZo7e9tQg29ho9hPw+FWHWMMB/Yk3KDOdMjhmFdd4W
         Io80tEGw6Fh8fAiF4Lgvd+Lm3dgcW0NJQdeRuX83nwbJaOxvX0ssJmRIPMmwCc2tcktp
         PNzhtWX+qRw+RL1P7xhVByoyI90Oz9jZwuEaXk7Qx8caz/I1NIxhPygqs3VsaVnShxfe
         XxlG8QTP/XaiVAXe/QNJ5FpErbwt/nBzFAJSNry46AJxHJmTBqQEL5iO1/+3Hn1vZ/Ke
         u4YA==
X-Forwarded-Encrypted: i=1; AJvYcCUzqrT9q7C/LXJrAM5Znb0wVIAhWWv6wCEZC8nkADQ91olGCVfDgi8Ap5onxtUlMYcvDygcVXLfMt4n058=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdzTtmu4gDCfJpWl6bL44ohrKTXaocP4Dx2JNkqthomJBTmKQ
	mBRWVWbwMaEc9sG+LyuOa/jxQ3VHs7jan1mdS7IFPqPIMGtEz4RrPFjPkcIdKJJvf5o=
X-Gm-Gg: ASbGnctOjCqTlTvuxdHKYVnFDdYXEtTJjgufDcIoqpTuWt/FDD6uP2R8Pq1SJVBjV66
	tHSqfJ2iany3/D/yoAw24z4fm/HfNwe0B4ST2mrESgkr3N1ODOYJQr8nYRkhYvnZYrzJjxr3JTe
	oVGwhmJzvW0ET5btjxYb6SfEWwOzU+48jfQan6PYdKNdIN/Sl7C5wGoo2M3WqzIkz/SRvNZz7AR
	TO9ztPhpziLrHmfeKKZhEYxiI06sl6qY8vFNIYyFJ6KUOc+1pMlq1tRBTrZmT5OY5Dus2+bwNvY
	PpPRpak19lSpC8lySNIc2GBgLRYfDa9E+oaS0yMhRltt2fl0akLdzOaNrWlPkjhKa13m+SxMIsL
	9NoNvj8EbUIbTkfMdqpm8t8JpvDUqHbWItWmL0VnttxeqvvaW+BqPSrA48+DyOcITVVWhImAE1p
	cwbnbgTIEkfmp2zCpvk9bQ+vonjXMTndbPztghkFZM3Vl2xTiLgHU9MFIzEi40CBw=
X-Google-Smtp-Source: AGHT+IFt/W8OfN0wmotc2k2dZiu/wdYB093masEn025f2GkQDw06G564MPjZck4rgVdGwtFbw/tSNg==
X-Received: by 2002:a05:600c:358d:b0:46d:b665:1d95 with SMTP id 5b1f17b1804b1-4773b1fb273mr5102695e9.32.1761915369135;
        Fri, 31 Oct 2025 05:56:09 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:08 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:06 +0000
Subject: [PATCH 07/11] soc: samsung: exynos-chipid: add support for
 google,gs101-chipid
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-7-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=4142;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=qrePO2TK/xL/G9ZFtgdmHMhzoS09DkAF2L3GWw8CmWM=;
 b=hXnqliaCMtZnuuW9qt7shGlniwBylvdPQspx1a5Nl22QLeoTw3pMOicddtAPTuVX2e3cN6Wuc
 qURFvBTuIWlDmEKKbpcfO9tnJFNcQWFRXrBpaxzeMi114ttbt659pry
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

GS101 reads the Product ID and the Chip ID from the OTP controller
registers. Add suppot for google,gs101-chipid.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 76 +++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 5678bc85c4d93547e446caade64a0b650d06a332..9c43c615167e4bbf15d00d42c2e52cc64d7dae1a 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -13,10 +13,12 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -26,6 +28,11 @@
 
 #include "exynos-asv.h"
 
+#define EXYNOS_GS101_MAIN_REV		GENMASK(3, 0)
+#define EXYNOS_GS101_SUB_REV		GENMASK(19, 16)
+#define EXYNOS_GS101_CHIP_ID_SIZE	16
+#define EXYNOS_GS101_PRODUCT_ID_SIZE	4
+
 struct exynos_chipid_info {
 	struct regmap *regmap;
 	struct device *dev;
@@ -73,6 +80,8 @@ static const struct exynos_soc_id {
 	{ "EXYNOS990", 0xE9830000 },
 	{ "EXYNOSAUTOV9", 0xAAA80000 },
 	{ "EXYNOSAUTOV920", 0x0A920000 },
+	/* Compatible with: google,gs101-chipid */
+	{ "GS101", 0x09845000 },
 };
 
 static const char *product_id_to_soc_id(unsigned int product_id)
@@ -85,6 +94,66 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 	return NULL;
 }
 
+static int exynos_chipid_get_efuse_data(struct device *dev,
+					const char *nvmem_cell_name,
+					u32 **efuse, size_t *size,
+					size_t expected_size)
+{
+	struct nvmem_cell *cell;
+
+	cell = nvmem_cell_get(dev, nvmem_cell_name);
+	if (IS_ERR(cell)) {
+		dev_err(dev, "no \"%s\"? %ld\n", nvmem_cell_name,
+			PTR_ERR(cell));
+		return PTR_ERR(cell);
+	}
+
+	*efuse = nvmem_cell_read(cell, size);
+	nvmem_cell_put(cell);
+	if (IS_ERR(*efuse))
+		return PTR_ERR(*efuse);
+
+	if (*size != expected_size) {
+		dev_err(dev, "Invalid efuse data size %zu\n", *size);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int exynos_chipid_get_efuse_chipid_info(const struct exynos_chipid_variant *data,
+		struct exynos_chipid_info *exynos_chipid)
+{
+	struct device *dev = exynos_chipid->dev;
+	size_t product_id_size, chip_id_size;
+	u32 *product_id, *chip_id;
+	u32 main_rev, sub_rev;
+	int ret;
+
+	ret = exynos_chipid_get_efuse_data(dev, "product-id", &product_id,
+					   &product_id_size,
+					   EXYNOS_GS101_PRODUCT_ID_SIZE);
+	if (ret)
+		return ret;
+
+	ret = exynos_chipid_get_efuse_data(dev, "chip-id", &chip_id,
+					   &chip_id_size,
+					   EXYNOS_GS101_CHIP_ID_SIZE);
+	if (ret)
+		return ret;
+
+	exynos_chipid->product_id = product_id[0] & EXYNOS_MASK;
+
+	main_rev = FIELD_GET(EXYNOS_GS101_MAIN_REV, product_id[0]);
+	sub_rev = FIELD_GET(EXYNOS_GS101_SUB_REV, chip_id[3]);
+	exynos_chipid->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+
+	kfree(product_id);
+	kfree(chip_id);
+
+	return 0;
+}
+
 static int exynos_chipid_get_regmap_chipid_info(const struct exynos_chipid_variant *data,
 		struct exynos_chipid_info *exynos_chipid)
 {
@@ -191,6 +260,10 @@ static void exynos_chipid_remove(struct platform_device *pdev)
 	soc_device_unregister(soc_dev);
 }
 
+static const struct exynos_chipid_variant gs101_chipid_data = {
+	.get_chipid_info = exynos_chipid_get_efuse_chipid_info,
+};
+
 static const struct exynos_chipid_variant exynos4210_chipid_data = {
 	.get_chipid_info = exynos_chipid_get_regmap_chipid_info,
 	.rev_reg	= 0x0,
@@ -209,6 +282,9 @@ static const struct exynos_chipid_variant exynos850_chipid_data = {
 
 static const struct of_device_id exynos_chipid_of_device_ids[] = {
 	{
+		.compatible	= "google,gs101-chipid",
+		.data		= &gs101_chipid_data,
+	}, {
 		.compatible	= "samsung,exynos4210-chipid",
 		.data		= &exynos4210_chipid_data,
 	}, {

-- 
2.51.1.930.gacf6e81ea2-goog


