Return-Path: <linux-kernel+bounces-891751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF8C4361D
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DB05188EBD1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64C5296BCC;
	Sat,  8 Nov 2025 23:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="O1WWlgvV"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD028C849
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643609; cv=none; b=tZFj8YAO9H9VDK/s98KeuN35+z3T6bNEQwFQbnOPWWKMUPr5YjLBAT2BDUpfF9ZYY1zVSoWyh7Su3kVeY5HYtBqD9DtyG/Owo3GsXWu6gbnupf4BWOHRknat6idyk5hMvq6zvvZ+qKiFfRLjtSULG5GA6s0LIKRO4Ss1SYe8Jjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643609; c=relaxed/simple;
	bh=LRgQG8dmzk1BLZPP62AH0NDL2Twf5lOn1hcY4/I8VFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzkSiWhnhl8imoM10eVLUTQiaqEKnbWdJPjEcuUJW7bYvTr0k4ktVgqCH9zAqao0+0t1uSZjSmbuNUuOueyzOpb6YUvFAAvBmFaMX6Isxj2m+lzQSJelMegPdemOjOlK/3gy4Dor3ChZbpFIdbd9I4SleV8iumB0nBLUWipU1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=O1WWlgvV; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so3074271a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643605; x=1763248405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MEwQ3w0WXL0SbyJSEK5ayMTVI87i1RH9nRchsrOxNc=;
        b=O1WWlgvVv2vgkkklyh4x+dbs882JcoL7raHaLMEOs853JRSoJkjlqoE+E4grv66jWH
         Ux5h38G4VaEmzPjHcRoZIBMw4Mkp6KBmLzSBu6Kbl+mn7ZJ8DbbLbzy86h5/5yatDKac
         fsDECl8qZCSrtOcBj4nwBIRRM9iYRBSM0cAY/9Q9xVbWrTZdBhmy9/OeP68SKAdND/JW
         Y9bdfTlcjgGCvopdhu4i/tGA9R9Kh3HFlsbQrJXhKFsAqCMsYlOvD8pg+NMxnoqTO/mM
         MpncH72amL5T2qGsVi5l0R1zOdUqzk3rRD+iqHRnJzxPEIX9hLAZEZLJZtsBkl0FPZt+
         tv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643605; x=1763248405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1MEwQ3w0WXL0SbyJSEK5ayMTVI87i1RH9nRchsrOxNc=;
        b=loBIyyB5wQ2yVzmkHm+NLe0vQ/8qAY/LrfaacdzikPcZtLGy8Woc0k6vmkMuKavWot
         krI5I+7d0ijv1fFP/4x309xz0YA2Sr2X9wES/zTfAIZp1zDMIBi/tQmAR/1zSiOJe8i6
         JLv96ttvThTe75v0D6cL7UiUuK7+LlPIm2IF4GQNmUA6DdgpeCaC0k9c77DUxOxVqtTv
         PzOiqzYx500E1CRZyv9ilrGOToBc/Gv1FM3Nz67z7Vr3wehDyrrlwU0GhLTdYDaYeyjY
         UntymBTvQ+lH6Lye+poC2w/TgSfjaBJSgjmejQVd9iP9xRBCR8heBi6Py5HAlC9WLQGC
         bzpA==
X-Forwarded-Encrypted: i=1; AJvYcCVvKOuIZmtl6IEx+N8k6ht4+AGNt8UGiKwn1mhi9cMw14bQH0+DnVrGIhxmqD/zhGSD1WOCSJzBeODTioQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9BQqXa4Dznxc7LHvmzi2W9ylMJTSs8xl/Zp4TzBRsr2j6Vgx
	llE+2CcNs1S8+NfjFqNEsORMHWCCCiKuxvCY0Ft5Xeh3x7xqy0XGXRcF
X-Gm-Gg: ASbGnctV9SsoNK3EpKuhTUKg2STU2TkuUwqWtqQc/lJukY7HH+Y9cYsW+a6r2ln+F7+
	6wp1qc2/KEHivwN33CTN7mlLkOy0SdUyF0RZdmLdvDoNIQUa8rMuHTzAQy2rJsHQ3mbzBbwPVCi
	CEHDGDGRNd156sd2GAgBrqnxGHaSI8MUi4cXXJzlwile8B7TuYL0qcQum6AFP8z+HByUK75JnMR
	Aef21z4m4Yzt7ku+QA2IBQiZeHhPkPgjSArpxbEVCS0sEZDG1+yRqy1tj5bSUhPm0CMKRso/EqB
	lGW04wxCmkTy6+he8OsDNPea91hyQOFzhhRibfNmuP0eyXsOPRFU12DUIZVl8I3/3VN+EQnLSOB
	VvCGwIQhhBOb8EHhQc27ao1hnp91gBxUCTF/2SfyUbklkgO1iKUFZopYhQB6w8DJD2bfb2HJxdN
	SECk4jRCA0Jgjtb1k8Ip9tBZJ3W2iMO3XPio50fpDMc5Uz9alMEAiE2ts0igMFtRc0+rclBJeMi
	ozdMBLqkaMKHYRmB6bEKLliSsqhpL8Ccjs637mw+l8=
X-Google-Smtp-Source: AGHT+IEsR1rp3/X0FtnDGE5wBY+8APLUTqmqxSkpd5bpl/RawvNHr6XzcekK44kWFCslKuF52z+IjQ==
X-Received: by 2002:a05:6402:305c:10b0:640:ebca:e680 with SMTP id 4fb4d7f45d1cf-6415e80f7fdmr2452169a12.37.1762643605472;
        Sat, 08 Nov 2025 15:13:25 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:24 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 4/7] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
Date: Sun,  9 Nov 2025 00:12:50 +0100
Message-ID: <20251108231253.1641927-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Binbin Zhou <zhoubinbin@loongson.cn>

Use new function devm_mmc_alloc_host() to simplify the code.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index ce1828d915da..214ce84f1ddd 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -648,7 +648,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	else if (IS_ERR(slot_pdev))
 		return PTR_ERR(slot_pdev);
 
-	mmc = mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
+	mmc = devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
 	if (!mmc) {
 		ret = -ENOMEM;
 		goto error_unregister_slot_pdev;
@@ -667,13 +667,13 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					     &meson_mx_sdio_regmap_config);
 	if (IS_ERR(host->regmap)) {
 		ret = PTR_ERR(host->regmap);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		ret = irq;
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	ret = devm_request_threaded_irq(host->controller_dev, irq,
@@ -681,24 +681,24 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 					meson_mx_mmc_irq_thread, IRQF_ONESHOT,
 					NULL, host);
 	if (ret)
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 
 	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
 	if (IS_ERR(core_clk)) {
 		ret = PTR_ERR(core_clk);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	host->cfg_div_clk = meson_mx_mmc_register_clk(&pdev->dev, base);
 	if (IS_ERR(host->cfg_div_clk)) {
 		ret = PTR_ERR(host->cfg_div_clk);
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
 		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
-		goto error_free_mmc;
+		goto error_unregister_slot_pdev;
 	}
 
 	conf = 0;
@@ -718,8 +718,6 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 error_disable_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
-error_free_mmc:
-	mmc_free_host(mmc);
 error_unregister_slot_pdev:
 	of_platform_device_destroy(&slot_pdev->dev, NULL);
 	return ret;
@@ -737,8 +735,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
 	of_platform_device_destroy(slot_dev, NULL);
 
 	clk_disable_unprepare(host->cfg_div_clk);
-
-	mmc_free_host(host->mmc);
 }
 
 static const struct of_device_id meson_mx_mmc_of_match[] = {
-- 
2.51.2


