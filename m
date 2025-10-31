Return-Path: <linux-kernel+bounces-880218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C307C25203
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D813BD1A4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F334BA2B;
	Fri, 31 Oct 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAlqV+5A"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0A0348875
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915371; cv=none; b=dPpOOsIXyW758pMcRkTlWw8Ua33cluynw+4idRODlVXMgetYCzUwvYTnJJNWQXSr9iA4tr7hMkrUuSWX+YcmiQBAeECp6hlVAB3+FvC9hbhX4/QuU9MK0DBDbHwZLFaoSsYF42tzU4x+t+vUzh7Pu2P+CrCLsbMzMJGdpm66N9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915371; c=relaxed/simple;
	bh=NNM4SFeVcha76qHLmwleNiSAgrvUgh4usYvH0Mgk4ZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9GMZlqDS2rMNTNGr9CvTOjyVAbzjBd+GwRO2sfS9Kqwr0Vc6EIwm8vyiN+NkhUSXVDWcdjlgkWMGbB5cnbbrJ9vSVY42Hyg5qGSSQhxwTkukJilaQujB9Ilr2cY/ZaJJ6DXjp1heeVqZw/88NhVCj4yxInrVcK4Pry9sRr0fR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UAlqV+5A; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so19341855e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915366; x=1762520166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DGzycItuSiWLzePfs0iR8NZ1MGamLLUApmHPBB2Kekk=;
        b=UAlqV+5A8QelkHleHWVW4juzTY7Ouw30BGjTWmtxxHj9m+d3nZQfDTsshaO97RIQ04
         Qa7jsD/w6RE7YBG3OnS3yyIOHigKrVLLvMwC8BOpsXOjdv9iaOD8qwR96M06bFjyniMq
         UEd/zUqT7zGl3vtRpi4PXBS3NriCa8YMQ54whfe2mECl0imQhJQVAZiLNdmD3DyiYox+
         qRcwrhC1gxQHpAZlVKFuQSF4uTNDJVDnsUGqvOiAbMzeBkizYVZeAxRMvlC6VevzDlaq
         T91jxZbifHWVypziqRtN5k+un0gSecdLeCH+iByMgQUKv3c408GLDe4CuCGC6l2k2Pxd
         AlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915366; x=1762520166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DGzycItuSiWLzePfs0iR8NZ1MGamLLUApmHPBB2Kekk=;
        b=gx4ESQ5i61/KxpJ0VGgJJ8w6ESKvFfQx6/2ANiaGEeh5TJBPDMU0HWWWsY6c0CHGzZ
         by3r5X+fBFP2/eX3fnYxINYl6P/Zl8iUogcE1kVC7CZVmWfiSTKTaeanx1FRmOC28ow9
         bKP4JiacDtgW6/O5Al/o8UdedWdOVIzp6QCS+lnjcAiJq80qfY/w8T62S9cfqIJfkgPX
         AozHiMy6C7R3wjmp7q85WJnSlwt+iTXyiWnillwc4sbfRjJA3F0sMfDMzDUiygteUhII
         oiCvTVQDv4PZx126OTis0PcUGh94qwP8awdcgK2NZ4Gvn8L9Yh9zB4iUEp30bDhg1sil
         1sjA==
X-Forwarded-Encrypted: i=1; AJvYcCW0BLKxh8qo7K97b90FMU65HEm6eWqIw7gdpVtzJN73IEiSDOe5RwJin0cLsrUr+zmqUTp0Ivmtz0bUVdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1g/+BOrYWaeGg0f9tFxE1emMIetUjmDWP3zqhJhnfCzKCV4yd
	kEkehvkHR8T0SVBRsvWS48Fc8RyelvItyOqPY1+r+esD/5crcauApV/ReAbJArcunoc=
X-Gm-Gg: ASbGncvxrJ6MgauKyjnO1k0loizk3Qfcf0CZTPXRShRcE/f1R6K0n0lalWOZ2NzVuYq
	MT4lpspt3+Jba2ayBeEqpI+4PH1eFsD/H58WjYLsAM/1lhIgNTKFbecvjWyV7I0gr2YB6sa7wVP
	LKIYzvCM7+/IW5thLAzFkqeBoUMTW5GOWdKGRlT5Pp3C5vlIWfU2VX6iN4btktlK1kMLbXgX84D
	Whr2KKJ8aT7KdIp7bWqziZdtacgxCEac5XFp5d9VcZiP5XhWUck9fYlGKzDd2wZnVxdSPJiQAOf
	kT1fvtJ+eXxfWdSGylrb0p4HPje+CB374HlHkfBbjXQz8JSa871SNLFHRorfDDrNBMF0DQI1Vkd
	1VzjoQ3TwXnCX84KSSiN61vwI0cyaRHmwqqKe0CzeJHMzWDUconnhFSDGmyURmEjz+oRrb1HSyG
	apna3g80wgszAKHTremE0kyFjpIrrjSmE92yn1B6WZGpl3J8tH8MdHpgfRHiq/Eqc=
X-Google-Smtp-Source: AGHT+IG9pEBdndjx7oyiTadyuA+yWQc7v+Ul4I1Z11B4Hn5fGctLstA/eCvhF1GkcnlxdSMTkGKiJg==
X-Received: by 2002:a05:600c:a010:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-477300b9e59mr30491685e9.7.1761915366461;
        Fri, 31 Oct 2025 05:56:06 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:05 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:03 +0000
Subject: [PATCH 04/11] soc: samsung: exynos-chipid: refer to match->data as
 data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-4-d78d1076b210@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=2584;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=NNM4SFeVcha76qHLmwleNiSAgrvUgh4usYvH0Mgk4ZM=;
 b=GCMSHfKvpeO2dk9a3N5A3IjogAlj5fNR7z1yJcvLIgqPVwAp/5fsSRsiw6fB0LbtnrI11VbfR
 36PzrnjCSa2BSjpyMjkbPp4HUWtCbdwtVJwpUfjVuKxhc50A4jO8YWI
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Be consistent across the driver and refer to match->data as data.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index f5107b8b339e8884d6a67a80650a95441510c66c..ab6bdf24a754a0faf974190c1fa1f99735cbef8e 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -106,7 +106,7 @@ static int exynos_chipid_get_chipid_info(struct regmap *regmap,
 
 static int exynos_chipid_probe(struct platform_device *pdev)
 {
-	const struct exynos_chipid_variant *drv_data;
+	const struct exynos_chipid_variant *data;
 	struct exynos_chipid_info *exynos_chipid;
 	struct soc_device_attribute *soc_dev_attr;
 	struct device *dev = &pdev->dev;
@@ -115,8 +115,8 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	struct regmap *regmap;
 	int ret;
 
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data)
+	data = of_device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
 	exynos_chipid = devm_kzalloc(dev, sizeof(*exynos_chipid), GFP_KERNEL);
@@ -127,7 +127,7 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 	if (IS_ERR(regmap))
 		return PTR_ERR(regmap);
 
-	ret = exynos_chipid_get_chipid_info(regmap, drv_data, exynos_chipid);
+	ret = exynos_chipid_get_chipid_info(regmap, data, exynos_chipid);
 	if (ret < 0)
 		return ret;
 
@@ -181,13 +181,13 @@ static void exynos_chipid_remove(struct platform_device *pdev)
 	soc_device_unregister(soc_dev);
 }
 
-static const struct exynos_chipid_variant exynos4210_chipid_drv_data = {
+static const struct exynos_chipid_variant exynos4210_chipid_data = {
 	.rev_reg	= 0x0,
 	.main_rev_shift	= 4,
 	.sub_rev_shift	= 0,
 };
 
-static const struct exynos_chipid_variant exynos850_chipid_drv_data = {
+static const struct exynos_chipid_variant exynos850_chipid_data = {
 	.rev_reg	= 0x10,
 	.main_rev_shift	= 20,
 	.sub_rev_shift	= 16,
@@ -196,10 +196,10 @@ static const struct exynos_chipid_variant exynos850_chipid_drv_data = {
 static const struct of_device_id exynos_chipid_of_device_ids[] = {
 	{
 		.compatible	= "samsung,exynos4210-chipid",
-		.data		= &exynos4210_chipid_drv_data,
+		.data		= &exynos4210_chipid_data,
 	}, {
 		.compatible	= "samsung,exynos850-chipid",
-		.data		= &exynos850_chipid_drv_data,
+		.data		= &exynos850_chipid_data,
 	},
 	{ }
 };

-- 
2.51.1.930.gacf6e81ea2-goog


