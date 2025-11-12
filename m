Return-Path: <linux-kernel+bounces-896772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3EC51308
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:51:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EE53B9154
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C052FF158;
	Wed, 12 Nov 2025 08:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PFPGKxn5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF302FDC41
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937327; cv=none; b=bZQZ9G1bdCyy10AHsvyKvX3UNszGyV0B+7Ze2AyYaomGuOce9eCDDUVQGIzxuWs22lGbockyV/7fsn67VrPw7MhzKUEZV5P51pkNybIn/X05IIEHl6hBxoF0/oHy89Ba5RpDHwZas9oAnzQE0NY0M0NJTtlvgTP6vTgg3hayFR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937327; c=relaxed/simple;
	bh=n57AkQX/19Tb7iHOH+H3uEtUeyVRBEzgRBixRLiXHFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q68+FwrYeJQWi8NsjL37ARB5IDYPmxVb/W3Rr+u61w43Aqts8PLJVYEj+eEFWhecs0KXpiQJYtZcIlJylll/egv8iNQ0j2l75ChDrhQDL+cXzW4xwZ6N5GBNUjq5ADBZMR5Wx0p9MJJppryAwaFCXCTKpQIgWjFYEEafV1QYvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PFPGKxn5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso3659045e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762937324; x=1763542124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YHCwzReQ17B3LDkchxkIz3eblf2i0j4UnwMVHJlClGg=;
        b=PFPGKxn5zBt9prhjOxKgV6FPoSOd9VYvzVnAH2K4Cn0HVyBMCjEoUxzD2QwQoySfJn
         TKSYOIccp/l+yD7x/zH23sWWiUjVZhvMg64V9keL/vFxNAoQG5kclLa0tuqzcDiQTbmh
         UNg3GfnQc46GpXEU97QSvI0i7TxdLf1yVgVeFu8QkjGMUvKwS/QT3vb1xJYMnw8qZFv0
         ALiq1xtvQgSXmijkNIM7IqUrVsYWIkgHDbsGNiqTTJlQ1vaDAdYJYuNWEdyEL7H0cNnZ
         Ec/BbVboYCYtC6RPgxgYUaL6LCGkAvhRMBoVoLm18yyJ5U9AqDru9r8OuYVylmSbxrSL
         0Rmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937324; x=1763542124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YHCwzReQ17B3LDkchxkIz3eblf2i0j4UnwMVHJlClGg=;
        b=JHEN9xqG4sEBftwaQpUOTUWC1SVYiyMPjwis3zUwENWcjEit3v+kqQp2cdj1LwrJBq
         8sOjhUwgkwzBO+99YESuOCEjMI32xppgjZDNLAdfqG82flk8STdplKQ+GNn8MX8XrNnd
         v1rMt9+ayNiSYU77AbhLR8RlAI+jf6S3LdMfUB3NE1eD8AeV2++WPDnPkcMLCDLs9rjV
         BJ8t6Zj2VApR0px9PXBH3PksNkdIHi7BM5XLQajIErfnK/l3TluF1VJyx7CwwBssnshB
         MkEWexWfTD4pSosNIC3FSGuUOjFfh470/iQzvm9TxfgAQZpy/vpS/9D0TLrTUXaiK5g0
         OO6A==
X-Forwarded-Encrypted: i=1; AJvYcCXOTLjh1fBi6c+qNCqbeEpIIlb8vNDqE/5JvjmqawSISB9Zsc8pjo393QaEQqfPHRAsI17gqVb1KUPdANs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFyFmTMHy928qkQATKux6UJOyF5j2lhrXaHVTQpH/nx7e8vYMD
	Ipzu4xlk+RmbjywaX9XDBBt2/s6CLvGB0Ak/bY4Uyc2X09m2dx+I1eNd6GgMqB+vJjo=
X-Gm-Gg: ASbGnctUicOpfFudEOd4PWe/N0uN9y6W2W6M8qt6HzlYVX4bB1aSieN4UdUfzY1KyAT
	VnZYfJkPw0KobGLk13JCfiPWHEBuyWHygH43GW+ailMhyiOIA1fzwE+7s9z7N5D/JFtXdo7w2IX
	+CYzOy4Ohq4GKTQn3VbQSHRclVCJbpAJ3EAKvMVzaRkoIPpk+F8gmZcBt3b2EOqv8nGesgyjQO6
	6JxVT5BE1wmfqFYLdMRtxx6vtLqVkVChRGnKH25YmiA18W363DCNcWPLZlhXmvBvuCBK2b1jDC+
	mfhWkGcO5pe6ve3h1/+h2H2vtxAZosuaHf3FaGBu6BChoNRQnJxS79nHtDNfFFilXIJoVkXSGaN
	QaPLXYfvu1xqCxm2t5FwjJQiEvz2FgtY8/WAN+qjdyE5QHyBs2zfIxswaIRYbG7QN2win3IvJ0v
	BYMZOXlkjRE7U84yTeCGGvftR2WZg0z5e+AFFKrpTsFLYJDT150aPwqvdG
X-Google-Smtp-Source: AGHT+IER3DYH8U9sYwYLoN8VfKXngSp0sef0ZPfwedq+Ay/0zM7XddiA+Z2Mq/fUyg1ZnrUUB2uTBg==
X-Received: by 2002:a05:600c:35c9:b0:477:6373:f3eb with SMTP id 5b1f17b1804b1-477870a8b57mr21511475e9.31.1762937323522;
        Wed, 12 Nov 2025 00:48:43 -0800 (PST)
Received: from ta2.c.googlers.com (17.83.155.104.bc.googleusercontent.com. [104.155.83.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47789ffea1esm3732645e9.13.2025.11.12.00.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 00:48:43 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Wed, 12 Nov 2025 08:48:23 +0000
Subject: [PATCH 4/4] soc: samsung: exynos-chipid: use devm action to
 unregister soc device
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-chipid-trivial-v1-4-ec2dea03bd83@linaro.org>
References: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
In-Reply-To: <20251112-chipid-trivial-v1-0-ec2dea03bd83@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, peter.griffin@linaro.org, 
 andre.draszik@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762937318; l=2293;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=n57AkQX/19Tb7iHOH+H3uEtUeyVRBEzgRBixRLiXHFw=;
 b=bMyB0dF9A7s2TwSb6EVYiRGLCLForFlgHHMYDdy3K5A6G2Ioi2jiFOZ13zx6ejNWqrQuMYtg/
 v1Svk1Zmeo6DeqIub2Zm7ixB/YNYSXR4VxOo/yq1VXDQvkqPk2UcVcn
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Simplify the unwinding of the soc device by using a devm action.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index b5866a324d8ae911a5c99d0290328efdcc072dfd..d5b4d4f8d43da4c50d0e856e914550a9322725a1 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -14,6 +14,7 @@
 
 #include <linux/array_size.h>
 #include <linux/device.h>
+#include <linux/device/devres.h>
 #include <linux/errno.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -104,6 +105,11 @@ static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 	return 0;
 }
 
+static void exynos_chipid_unregister_soc(void *data)
+{
+	soc_device_unregister(data);
+}
+
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
 	const struct exynos_chipid_variant *drv_data;
@@ -151,28 +157,19 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
-	ret = exynos_asv_init(dev, regmap);
+	ret = devm_add_action_or_reset(dev, exynos_chipid_unregister_soc,
+				       soc_dev);
 	if (ret)
-		goto err;
+		return dev_err_probe(dev, ret, "failed to add devm action\n");
 
-	platform_set_drvdata(pdev, soc_dev);
+	ret = exynos_asv_init(dev, regmap);
+	if (ret)
+		return ret;
 
 	dev_dbg(dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
 		soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
 
 	return 0;
-
-err:
-	soc_device_unregister(soc_dev);
-
-	return ret;
-}
-
-static void exynos_chipid_remove(struct platform_device *pdev)
-{
-	struct soc_device *soc_dev = platform_get_drvdata(pdev);
-
-	soc_device_unregister(soc_dev);
 }
 
 static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
@@ -205,7 +202,6 @@ static struct platform_driver exynos_chipid_driver = {
 		.of_match_table = exynos_chipid_of_device_ids,
 	},
 	.probe = exynos_chipid_probe,
-	.remove = exynos_chipid_remove,
 };
 module_platform_driver(exynos_chipid_driver);
 

-- 
2.51.2.1041.gc1ab5b90ca-goog


