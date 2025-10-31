Return-Path: <linux-kernel+bounces-880217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C2FC251F1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EA303BDE39
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94F34B427;
	Fri, 31 Oct 2025 12:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SFLs3DRh"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7490F34A786
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915369; cv=none; b=dEOps6EP7uT0Tj7lgUuaaUeIyrQd91rdOOo8t6YyOA4n8L013lxdBLq7bJqzjEYd+A0HbB6XHcnRd3idR0aPlNUsOF9Vahc9VOh+PnEHW0KtBi7gtyxt6fEXiqEmT8TMN37Ae3Zh0/IMMwVDHyPL6Kb2XqO9ZPCyDcrm5lXYWjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915369; c=relaxed/simple;
	bh=X61ET0QayRGQSnh54T5fe6GJ6+lTqv8ZTwap/CsnBTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kd/97KF2J2t/mH0mxYoq1QLzJbuOj1fuGmR4tBdaIRydDkg8nf6nL2FwTi2cH9qLLJwlK17Gu/26Y6iKBShXlbcKyMGQPafII34wdZxpbr3phrJ9d1DrOnNKVe4kl4sukT6rTabFfYlzXeoXGU3oHmgyBzu7p7bAoi2wK0GN1wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SFLs3DRh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-471b80b994bso27823705e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915366; x=1762520166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSaQ1fMzBn62httc+1ynJ5lZCTonhSY3jc12jXK/iU4=;
        b=SFLs3DRhAQaIra0iPy2Y5YcBQFaL7akyAhB5dNRDjjn9jw88MlK0sHC/xRyVGmvbKJ
         lSuU69gor9N/cvrzMCLpPfC54ka7Ibp4Qshh4Yd6gKVh8QfjLayyyauY7UT7bqelBttd
         8nhvQxupZ+bd2naKFNkQWsqHZRTRJtubFe/7SRkqhaX+Mwr3WIzgk6X75nJ6vKES1xQD
         ZcLj10jr5hbh2FqNy91GJx39Y+0La1Wm0tZQysg6NOoT8fdzOKEpqG7azbaXL0TTtAH7
         6pGmyYvPsFO6cjBHdrLG+428zoeq22Egoxftg6D9hwO9PUjhMMtpTVNZaq9paL2aIpNl
         KQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915366; x=1762520166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSaQ1fMzBn62httc+1ynJ5lZCTonhSY3jc12jXK/iU4=;
        b=cGxzrdYGPGCNNWNbhtlDw0ULro4DM+8Vl0gtBvVOffdGEw2DoE8B5fb6zaO7PRISyB
         /esd7Wtc5sIi7BjO4PJt2pt7uh9KKw5pDaTqlJVrKEnYppIIclIbCva7+OdYOqx22KLW
         Cznyxgg22r78nJLS+B5LpRjHdhZTK3qYjnRvX4DmJd0CHh7+t/MzLy5oFLSrIZTl+sHa
         gSVrr4e2g0rkrx+L2Og+tEBR9M2mZfgKw1pW0N5Cti9SbgZFfeUFaMbxkP+myEIzezKw
         9K/O/Km5ckG9ARbQghV2JTl/2g83jEJOs1e8+kqZvxHQlj4u4/NWODdwuuchW9ESx9J8
         kkaw==
X-Forwarded-Encrypted: i=1; AJvYcCV1WAwmZ2ckH2IkEbW7Ifkj2egX7Qsr21zvEQfzAe8mz2visb645IKMEFWxg5g5vHUglVBZ9aWHLF+ABKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRKw3v39ZzTDvIbZYXlGJwZi0yxUWrpiWTtHwaM8UQ14SWrbI+
	qMcKQw27EIs1zoIA4JAz/cI4yQy2jx1nhwjAkxuh/g7Sqx1TfFVj4oeRZsoTZDUy/5Y=
X-Gm-Gg: ASbGncuHILUGGaCd2rIu97iDQDOU5a6GlFluiLX+IvfOWIvtC22k9hEs3J8vc62AEG5
	9qrUUUA7LtLn1K9iUQqgrHTSz9e338ouWWihTGzzaj2n1On62O8rHutdy3uzQsrjaMJJITBfT6T
	mDgBy3/Knp2dfo0+D979aNpETRKcm8KiM0Vwtnghqq0ROj4Xg/Kg628UUt/KfGMz1KHhdXAH8hE
	BXk5VhvgVMMpTL3dLNzCiBgx0R1pdFmj5xhllVz1hmHs8zl4yaHp+62UUKDAKeHRoScKMAV/UF4
	u0U0koiKz3HHWNJyCk0hI57FEndh0A8n94wM0zu1wJgNIeiwlkAUA4FS1fl5+tkbnap0+Sv1U38
	WZjEu8I4MVPVCyKsjUVkmQsivm7tZDau+jP7CeU8v5a3Io40xL75Pg7i3iwP41Pj4muT1AEswwJ
	bW3crTxJGVsa6gBchdIvb/iEZLsVtIm3cPBLl4IP3yDUhwzZCQOxy+
X-Google-Smtp-Source: AGHT+IEMG1uBB/nM2ExhUoSIALv5lI0e6AJa+tuQvPuDL99NpDZ3UQgWksFzIXH5FeMHLGmGMsY+Mw==
X-Received: by 2002:a05:600c:699a:b0:477:1326:7b4b with SMTP id 5b1f17b1804b1-47730872322mr35934675e9.19.1761915365648;
        Fri, 31 Oct 2025 05:56:05 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:02 +0000
Subject: [PATCH 03/11] soc: samsung: exynos-chipid: use heap allocated
 driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-3-d78d1076b210@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=3640;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=X61ET0QayRGQSnh54T5fe6GJ6+lTqv8ZTwap/CsnBTw=;
 b=0K1j4+WDA8muM25w4/AKELtGUQ9BOkhp3k+p+UHT6d2Sl/VE5k+tF31SWP1r7l4Rln/B7iCsy
 lIZmzLBAHceAAjz0RqO96KF1Lw4NqxJTcwe41uEqLf0u+PuxubM62lS
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Prepare for GS101 chipid addition, it will requre more driver data. Use
heap allocated driver data, it's easily extensible. Together with
the change s/soc_info/exynos_chipid, it better indicates that it is the
driver data structure.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index d3b4b5508e0c808ee9f7b0039073ef57915d60fc..f5107b8b339e8884d6a67a80650a95441510c66c 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -82,7 +82,7 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 
 static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 		const struct exynos_chipid_variant *data,
-		struct exynos_chipid_info *soc_info)
+		struct exynos_chipid_info *exynos_chipid)
 {
 	int ret;
 	unsigned int val, main_rev, sub_rev;
@@ -90,7 +90,7 @@ static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
 	if (ret < 0)
 		return ret;
-	soc_info->product_id = val & EXYNOS_MASK;
+	exynos_chipid->product_id = val & EXYNOS_MASK;
 
 	if (data->rev_reg != EXYNOS_CHIPID_REG_PRO_ID) {
 		ret = regmap_read(regmap, data->rev_reg, &val);
@@ -99,7 +99,7 @@ static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 	}
 	main_rev = (val >> data->main_rev_shift) & EXYNOS_REV_PART_MASK;
 	sub_rev = (val >> data->sub_rev_shift) & EXYNOS_REV_PART_MASK;
-	soc_info->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
+	exynos_chipid->revision = (main_rev << EXYNOS_REV_PART_SHIFT) | sub_rev;
 
 	return 0;
 }
@@ -107,7 +107,7 @@ static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
 	const struct exynos_chipid_variant *drv_data;
-	struct exynos_chipid_info soc_info;
+	struct exynos_chipid_info *exynos_chipid;
 	struct soc_device_attribute *soc_dev_attr;
 	struct device *dev = &pdev->dev;
 	struct soc_device *soc_dev;
@@ -119,11 +119,15 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (!drv_data)
 		return -EINVAL;
 
+	exynos_chipid = devm_kzalloc(dev, sizeof(*exynos_chipid), GFP_KERNEL);
+	if (!exynos_chipid)
+		return -ENOMEM;
+
 	regmap = device_node_to_regmap(dev->of_node);
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = exynos_chipid_get_chipid_info(regmap, drv_data, &soc_info);
+	ret = exynos_chipid_get_chipid_info(regmap, drv_data, exynos_chipid);
 	if (ret < 0)
 		return ret;
 
@@ -138,10 +142,10 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	of_node_put(root);
 
 	soc_dev_attr->revision = devm_kasprintf(dev, GFP_KERNEL, "%x",
-						soc_info.revision);
+						exynos_chipid->revision);
 	if (!soc_dev_attr->revision)
 		return -ENOMEM;
-	soc_dev_attr->soc_id = product_id_to_soc_id(soc_info.product_id);
+	soc_dev_attr->soc_id = product_id_to_soc_id(exynos_chipid->product_id);
 	if (!soc_dev_attr->soc_id) {
 		pr_err("Unknown SoC\n");
 		return -ENODEV;
@@ -159,7 +163,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, soc_dev);
 
 	dev_info(dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		 soc_dev_attr->soc_id, soc_info.product_id, soc_info.revision);
+		 soc_dev_attr->soc_id, exynos_chipid->product_id,
+		 exynos_chipid->revision);
 
 	return 0;
 

-- 
2.51.1.930.gacf6e81ea2-goog


