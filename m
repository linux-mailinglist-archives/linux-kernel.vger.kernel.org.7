Return-Path: <linux-kernel+bounces-784956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2DB3440A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5AFA4832A6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503C302CD6;
	Mon, 25 Aug 2025 14:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bKhikXIV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFFA302756
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132033; cv=none; b=QKHKaqqi5F8iybR1xDcto5D74V8V22H1beVGmRgEqM7i/fKFpB905cEVzZQRaxlLBqXn+20/CNFOLbuSyv5M17UajlydPAxLkUnNtc26jBV88oTL43LO/RjwB5kKeizNfX4q6GUQY4FvRZxQ/dGGalv4p78kOBH9kEFMgGeTL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132033; c=relaxed/simple;
	bh=+HNEh7kwqO29/XBYa7Ua9Z9/DByHKmxsSbqdzoDcKd4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NC2x5BtMasuS2cGLKelqXtPCZDw6ZmxuC6CkXGwaMPI+8Z12eDf8cktzX07Y6LwPqrod59aYZfd1lDloCfwawGgA13nZANvg0s1Uq+6DhqOB/YRZS+mV80yCKeX+YRobszLnYXPUmU/8eBe2hflmdiZbwP5C3L8B/UkMeCOgFTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bKhikXIV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso35462015e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132028; x=1756736828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E0OX3l7hSZpbmIvG6p8r2X61gE3s0wO+uAxqyQVEXs=;
        b=bKhikXIVB329pJUWytfkQQXQfY3QvN5kQiBsB/5HfI65+b1hHr6gE/lLSBgh53GTiT
         Xy/q+7hjx4qrPcBVfTcpoLU68UvouWle6s1BWA99Jp310gjzCM/UQoqEUFzzKlRXmyLD
         pMdX8dOgEVNKImLEp3NlVzXyzLLKSobMdIfN3vJ43srkTbQhvLoatUCRtYpeYhAO8R2T
         00Y5mp3LV/jZMJ9dVw4CWBIvT4Is1P36pIw/7u2jcyffsYvfGjoYiiOvCnW5cFf18pfl
         SgVOyLuuqxuJfMIX2MYVoK4z494QOlE6EHKr5eEdgJXiFLp86J3MhbyGvCmzlEv+hkC6
         HosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132028; x=1756736828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3E0OX3l7hSZpbmIvG6p8r2X61gE3s0wO+uAxqyQVEXs=;
        b=YnsPOfrkhkWnhqf+GdmkNIZseIyujFhcOu0M5zv1LbmRmKAqLYrmRoWxSMrQZ6scS+
         V/BGjUAFMmdLQzJLccyp/0zLtpJFQmADWe3xvdJMl7el2dvXjMEGdmvVbwXevKXXAwmy
         vKmLuJZc/6H0sFIWtUw2WJp+BzvSuSgpLhqn9nvOuD/ZpXUP0muUg2W+DXEsywFd8slz
         iGkyh+qWOgqCMzGMK8vBZ+5UeXpwv5kp+XOg0lnSIYOHx/3fDpg75FZ7NISk1JbgPC2R
         Nw98sbxBaMZBJjGbdjC9fGZ1wswiggmA2dIszE/+EHCZQu6p12j/vyOR9Z4ZpEkuDg98
         loaw==
X-Forwarded-Encrypted: i=1; AJvYcCXk7fuAaDrhpwKfgrHdm4vLl1Ir5fd86zrhdGQxA1ZViUgz1nzwIwElQDvDokS5rgPPGIu4C7H3fnS+88w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIYQxSwGGg60LUD20E1SrbAEcTlSBQFTpehFvf1o6C/08iDuF
	M/ioQ36a395RrViRuFAuH9g7r1OkGtMQ/qGKDr77TSzJtbKSn9JMJp/cv4ysWSnQap0=
X-Gm-Gg: ASbGncv5KLnYjR02UHCTUTyy92vSBQrrK79F41xCnkYCrqS5wr5M55daKCDr9y6sPLL
	RHpdmTiMFa3LQSUs5wiiqiC7tF+lf0FJN9uZTua6PPXQRpxpyp87G9OqD9JQkLadUYH88PV0K7J
	bA+O4qY2IyvVp/zz8ounEd0pBNk+cZfwUjobm3OB4j1abz8bnp5tHmghEBvpGKW08TFVCoRV/oZ
	zjG0MZU0cUPI+X7bCNerjDidf5E7jSsn5I/HLnPD15G3UsJDO4Ac8hHEAuninPyDBMFuOcMO6Ke
	DLEmAmYcG9dtOUh8809Xu8FbBlwcoXQdE8zc0fOBNaBkF8rr0wm+gAhurTOu6TF/K2iuEb65n+w
	dVmFKuaeoPu2gZNCLj1jd1md9AqdfVuC5gUAO
X-Google-Smtp-Source: AGHT+IG97/qISA8MqcZl/mFg7nS0dUGfrxzbGW4TGxFceOnmVdStCa+f8SnHWO66tjzhKARbGRvgHg==
X-Received: by 2002:a05:600c:3b2a:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-45b5179f3d1mr151618155e9.16.1756132027543;
        Mon, 25 Aug 2025 07:27:07 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:07 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:27 +0200
Subject: [PATCH v2 02/12] clk: amlogic: add probe helper for mmio based
 controllers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-2-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3563; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=+HNEh7kwqO29/XBYa7Ua9Z9/DByHKmxsSbqdzoDcKd4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHKvxaowyPgU9EztKNOZEz2aQx91OrxuPgs8m
 8sKoQw4BwGJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxyrwAKCRDm/A8cN/La
 hVQXD/0aAjUtx5KRzTTrPI2utKSOITXpjIpBAvWOFFJyhdNjV05yalKeYTT73MxL9ZEsqMnajIw
 66jChhvqaYDcHddLUwTzMsX+EOJd/rhwUgqlIYEVXlGwmzg8dEQcp/qwJS1ECewk0Kta4JoYH+z
 OuD1oz4bbhp4xJLOSckzAKW43qHjy/5yjl7RjjVo5E29EmcE5mnRs9TKaN9K8f7/3SmDmyHMQfs
 2DDziIS0L6j3BsURuw/oplHoooSN7de9FN5MgPQprrKdLvSxj6DKVMGYW5bUZOgXCAwXFkCRPyO
 1qtBA5VYOXA6UfvPxHCu5t/r7rFYBj4Wr+GwEe5x7MODMm5ExB4daArLYtuD3d91rQPdyfk+IG3
 yKIynnIKuC2W5CwvRJu/sfWruBp9yMhyV247opoYmx9vnqrmwBxB8ZyumqxcMarcmuEm5kdCXgI
 ORY2mdkUfYE2JgN1jDDzvzIg5rBrmITtlmAYpO6Jdsc2ixMYYsPKIjXTVHLhPxoXQdFm8kevemX
 4foheR30XhsMspEdnJgRnoh82yVeVG+/fPUpFqqp4NTg+kTPGGvdY+QedZWsrzwfndqOE+EB2e/
 IMlMcWjAKop3gFKJpRO4RIaKkm8sTCXYql/1QQ9DUB/im7pDrh3QPOWj3Y5zPeKZcFzYIIcH2rw
 4zBO2MbxH7HjyhQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add a 2nd probe function helper for mmio based controllers, which
are getting the memory region from a resource instead of a syscon.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-clkc-utils.c | 62 ++++++++++++++++++++++++++++--------
 drivers/clk/meson/meson-clkc-utils.h |  1 +
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/meson-clkc-utils.c b/drivers/clk/meson/meson-clkc-utils.c
index 49f562d0f203b9a7d15b5119100216564c10cb21..870f50548e26841130dd4267f5a79c8bcd188c70 100644
--- a/drivers/clk/meson/meson-clkc-utils.c
+++ b/drivers/clk/meson/meson-clkc-utils.c
@@ -26,12 +26,9 @@ struct clk_hw *meson_clk_hw_get(struct of_phandle_args *clkspec, void *clk_hw_da
 }
 EXPORT_SYMBOL_NS_GPL(meson_clk_hw_get, "CLK_MESON");
 
-int meson_clkc_syscon_probe(struct platform_device *pdev)
+static int meson_clkc_init(struct device *dev, struct regmap *map)
 {
 	const struct meson_clkc_data *data;
-	struct device *dev = &pdev->dev;
-	struct device_node *np;
-	struct regmap *map;
 	struct clk_hw *hw;
 	int ret, i;
 
@@ -39,15 +36,6 @@ int meson_clkc_syscon_probe(struct platform_device *pdev)
 	if (!data)
 		return -EINVAL;
 
-	np = of_get_parent(dev->of_node);
-	map = syscon_node_to_regmap(np);
-	of_node_put(np);
-	if (IS_ERR(map)) {
-		dev_err(dev,
-			"failed to get parent syscon regmap\n");
-		return PTR_ERR(map);
-	}
-
 	if (data->init_count)
 		regmap_multi_reg_write(map, data->init_regs, data->init_count);
 
@@ -68,8 +56,56 @@ int meson_clkc_syscon_probe(struct platform_device *pdev)
 
 	return devm_of_clk_add_hw_provider(dev, meson_clk_hw_get, (void *)&data->hw_clks);
 }
+
+int meson_clkc_syscon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np;
+	struct regmap *map;
+
+	np = of_get_parent(dev->of_node);
+	map = syscon_node_to_regmap(np);
+	of_node_put(np);
+	if (IS_ERR(map)) {
+		dev_err(dev, "failed to get parent syscon regmap\n");
+		return PTR_ERR(map);
+	}
+
+	return meson_clkc_init(dev, map);
+}
 EXPORT_SYMBOL_NS_GPL(meson_clkc_syscon_probe, "CLK_MESON");
 
+int meson_clkc_mmio_probe(struct platform_device *pdev)
+{
+	const struct meson_clkc_data *data;
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	void __iomem *base;
+	struct regmap *map;
+	struct regmap_config regmap_cfg = {
+			.reg_bits	= 32,
+			.val_bits	= 32,
+			.reg_stride	= 4,
+	};
+
+	data = of_device_get_match_data(dev);
+	if (!data)
+		return -EINVAL;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	regmap_cfg.max_register = resource_size(res) - regmap_cfg.reg_stride;
+
+	map = devm_regmap_init_mmio(dev, base, &regmap_cfg);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	return meson_clkc_init(dev, map);
+}
+EXPORT_SYMBOL_NS_GPL(meson_clkc_mmio_probe, "CLK_MESON");
+
 MODULE_DESCRIPTION("Amlogic Clock Controller Utilities");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("CLK_MESON");
diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index 26cd47544302b28ca1a342e178956559a84b152a..b45f85f630d7190fb6509b088f05f17ca91fa1c8 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -25,5 +25,6 @@ struct meson_clkc_data {
 };
 
 int meson_clkc_syscon_probe(struct platform_device *pdev);
+int meson_clkc_mmio_probe(struct platform_device *pdev);
 
 #endif

-- 
2.47.2


