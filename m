Return-Path: <linux-kernel+bounces-880219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E80C25258
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 629184F8B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1171534C12B;
	Fri, 31 Oct 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CGFOZ52Q"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCEB34B193
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915371; cv=none; b=AGtyJBSJNkSDCYOzRxDndovFimyL9yOvjLiKTrwcFIeynEpTavu/B0bd4AyPU6DuWSakk/7rHNGB+jCGWL+ff9YPftHNUlYG8pqG/NrE4+Srr393xyMiUCmpoV7cnJYXSleI4YfnS9HJbam5Z1Q1G75jGlzAkaEUfp9onWvrOf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915371; c=relaxed/simple;
	bh=YpELVcKRbuAd/GhEt+Uw8ZWb+caf7nBbVVxyl3NyrsE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WSBcQlBkx4vI1IOZ2w40ns2q304adcgKe23TpOZfk1qkZ3LhBfWXVG5Pk4U7DqU8rxShF5h6FFvBG9CVkNgenO9FJCK7c3k3iz05r0X+uEr6H0628S0+6ZVIrtPIgSdQJTlA1az+Pgparo3OV+ao7P0jDsTBDfeakpG+LXx/xoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CGFOZ52Q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f99ac9acc4so2186175f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915367; x=1762520167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2E8O1HVfDYkA0RiCP/aCuaFM9xdalT+JDcjuD9x3xgE=;
        b=CGFOZ52QZfppPMqllIkGiG2tWNJtXKZmTmP0ZY0GXZ/7IvcJC9ERMAslUNcks++BCb
         kad+qbB3/elCH/km+fVV9JDJeuHDFgSv+tMK9HB6YUZVqhzPCDdi0xWQAuBZxr9yeezQ
         4Ajocu3fIvMFMRWA5mKXGOXL6zUHX1pxmdn2foQ7nEqAYfvIJ4Y0C6ivU61IAYCACb45
         PipZk5cQfUBLhzGjMCkirCkAJdewZvDbOI4byWIcELSOTwi5uEOaEvXUdM7cjf7vS5gB
         InJj2f7Riwxc8wghFzL35IBJp2/vChIsQI71fijYL3niPfHNW8/Okc4omk1ago/x3p3H
         rw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915367; x=1762520167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2E8O1HVfDYkA0RiCP/aCuaFM9xdalT+JDcjuD9x3xgE=;
        b=LlbgH+UU0KYUVCR66C9nPt1LGqSw5lxW0f1HKfvzvPRK0VDTiv0uw/FB/YDJ4xsrSN
         bzQAMP7kV/TuGdVZY5CAYg+SzuX941fFQlt+373hHAvCxnt/ByN3qA+QVAYG0WHPWA7/
         xBs8b7GrLSZ/X+EPp3rBsKXxaqimA+mDh1BMBjihHGHfC+bZNQuiyja1ruOARPflucmc
         OKwRHD9mE0DvSdIPpRoTvFCV2vd+Ajcznxkkg60gAj+qvBNWfy2d8J4/ykM3o7hdsEAT
         Hxge2RxF7n/YX1QXXM9METuFBPJT/DSmKPkrBDwqWe75/dhaEC38424GkJDcYEJOlS7b
         U3kA==
X-Forwarded-Encrypted: i=1; AJvYcCXZlsOvhLf76GAFWAOYfGwhr1KkFihLzjC4pFn5/RKYdHG0fXTmlF9c0G5tY2Ye2auK24qPInZbYHQjKCo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylkhhw64wRhk0/RaepUSksEv5XHRIN1w93hq26kaSwsGr+abJD
	LBAUnivDgAawgS/EOTY65MtUbEe/h+vWTJxXMCpxq6YQGRXOUUYbt/pmA+c+KGtMv2A=
X-Gm-Gg: ASbGncu2EM5WyM4He20AKgG1pqIIoDd8gMeBh96jvoceZkjj8hcBfVfes4/k7zy5NvU
	KDqlJs5/VrTzE2CCkdd4zb66yrA2u7Zc68kZlTo52UfulR9ZTy29j77mk3pXpVaoQvDpaWSi7Vi
	hfeWLGnP5ai/sp66agZiJqBpp574bLFk5b8ktfUjXPDGPgB7bVWVXuir8o5nOVOamMJ1xcEqkLO
	L3KJy2UaYs3o0DXxThfwHEbx2ErFDQOdSXShZ+x16GotrycVOgnO7KqqEb0inYJb4aU3jN1jAW9
	9vY8XYXM4BuONibEwr3A8cGQ3qORu+HwD2yIJVWBK8DqdAmpSAfdZBSK74s8aipE383LEDqxCqY
	S0ipxJ3S88+j7pAzp2+Aj/mNjrzqcuvDE4vtqbHOREp6hOR0V196J1TYLAN1vnGVpf39rExc4uB
	+icSE5BhM++VjF57EfWRLImR/CD6/YckYQEOEeTpyfJeqnY7MRymD/
X-Google-Smtp-Source: AGHT+IEM0IizIY6zKHHTUoU/7maB6WNMbu7DQNWYaZmsDz61aQ66cg1D8Vspw9HQMEmMkaFXkgjmuQ==
X-Received: by 2002:a05:6000:4813:b0:429:89c2:d933 with SMTP id ffacd0b85a97d-429bd6a661bmr3174422f8f.36.1761915367453;
        Fri, 31 Oct 2025 05:56:07 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:06 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:04 +0000
Subject: [PATCH 05/11] soc: samsung: exynos-chipid: introduce
 match_data->get_chipid_info()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-5-d78d1076b210@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=4101;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=YpELVcKRbuAd/GhEt+Uw8ZWb+caf7nBbVVxyl3NyrsE=;
 b=UEW6/PQ3Egxk62/OqWjiQypCQ7SA35bhWD5liiLVFOeTb2m9dp8f2u0wl2seB2jO2g9zYq8Fk
 afYP3a8tYFeD0XpzgeLk+q2Cd1vzo0fyR4BP8LIeZPeNIStcCkLZEiC
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Newer SoCs, like GS101, don't have a dedicated Chip ID controller.
The GS101 Chip ID info is available as part of the OTP controller
registers, among other things. For GS101 we will read the Chip ID from
the OTP controller using the nvmem API.

Extend the match_data with a get_chipid_info() method, to allow nvmem
integration.

`struct exynos_chipid_info` is moved to the top of the file to avoid a
forward declaration. The structure is extended with pointers to device
and regmap to allow current implementation to obtain the regmap in the
newly introduced exynos_chipid_get_regmap_chipid_info() method. The
nvmem consumer support that will follow won't use the regmap, and
instead will use the nvmem API. It will need the pointer to the device
to report errors.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index ab6bdf24a754a0faf974190c1fa1f99735cbef8e..7b1951f28e8d4958ab941af91dab4b0183ceda5f 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -26,17 +26,21 @@
 
 #include "exynos-asv.h"
 
+struct exynos_chipid_info {
+	struct regmap *regmap;
+	struct device *dev;
+	u32 product_id;
+	u32 revision;
+};
+
 struct exynos_chipid_variant {
+	int (*get_chipid_info)(const struct exynos_chipid_variant *data,
+			       struct exynos_chipid_info *exynos_chipid);
 	unsigned int rev_reg;		/* revision register offset */
 	unsigned int main_rev_shift;	/* main revision offset in rev_reg */
 	unsigned int sub_rev_shift;	/* sub revision offset in rev_reg */
 };
 
-struct exynos_chipid_info {
-	u32 product_id;
-	u32 revision;
-};
-
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -80,13 +84,19 @@ static const char *product_id_to_soc_id(unsigned int product_id)
 	return NULL;
 }
 
-static int exynos_chipid_get_chipid_info(struct regmap *regmap,
-		const struct exynos_chipid_variant *data,
+static int exynos_chipid_get_regmap_chipid_info(const struct exynos_chipid_variant *data,
 		struct exynos_chipid_info *exynos_chipid)
 {
 	int ret;
+	struct regmap *regmap;
 	unsigned int val, main_rev, sub_rev;
 
+	regmap = device_node_to_regmap(exynos_chipid->dev->of_node);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	exynos_chipid->regmap = regmap;
+
 	ret = regmap_read(regmap, EXYNOS_CHIPID_REG_PRO_ID, &val);
 	if (ret < 0)
 		return ret;
@@ -112,7 +122,6 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct soc_device *soc_dev;
 	struct device_node *root;
-	struct regmap *regmap;
 	int ret;
 
 	data = of_device_get_match_data(dev);
@@ -123,11 +132,9 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (!exynos_chipid)
 		return -ENOMEM;
 
-	regmap = device_node_to_regmap(dev->of_node);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	exynos_chipid->dev = dev;
 
-	ret = exynos_chipid_get_chipid_info(regmap, data, exynos_chipid);
+	ret = data->get_chipid_info(data, exynos_chipid);
 	if (ret < 0)
 		return ret;
 
@@ -156,7 +163,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (IS_ERR(soc_dev))
 		return PTR_ERR(soc_dev);
 
-	ret = exynos_asv_init(dev, regmap);
+	ret = exynos_asv_init(dev, exynos_chipid->regmap);
 	if (ret)
 		goto err;
 
@@ -182,12 +189,14 @@ static void exynos_chipid_remove(struct platform_device *pdev)
 }
 
 static const struct exynos_chipid_variant exynos4210_chipid_data = {
+	.get_chipid_info = exynos_chipid_get_regmap_chipid_info,
 	.rev_reg	= 0x0,
 	.main_rev_shift	= 4,
 	.sub_rev_shift	= 0,
 };
 
 static const struct exynos_chipid_variant exynos850_chipid_data = {
+	.get_chipid_info = exynos_chipid_get_regmap_chipid_info,
 	.rev_reg	= 0x10,
 	.main_rev_shift	= 20,
 	.sub_rev_shift	= 16,

-- 
2.51.1.930.gacf6e81ea2-goog


