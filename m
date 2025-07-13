Return-Path: <linux-kernel+bounces-729099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9839B031B9
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 17:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 649707A49BF
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jul 2025 15:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60235228CBE;
	Sun, 13 Jul 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACr7eafx"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BB2A920
	for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 15:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752420292; cv=none; b=W5B83GOxzgEFockRf39z3Hx6A2XHqgytHYlfN2PkjQ9hr1DWJAju4BLeiW4Y7SNYQDAVv4BdAFt40tl4+Cw0IeszfALlipiCguradKp0TafhQVh0P2udDneoHcNeW9sYksJimZxexHsKmFMPw+gOJgRQnQfsbjrfuyHdyvk5fgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752420292; c=relaxed/simple;
	bh=x6nwlnCf8EpliBB4PAXRWVJfoeL/+OwxGylEV3WROkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVcDCKlXKoUL67ZF5aHus9M1blw3D0PzoXkBJBRjAI6AMOy14zP6FLgghjkPnGiXCBp8rlMBmSj+wIVnD7kZKPmv+mgPX0zq62vVD3s4I92d3zHNOJejrLncHjLlFdD98y9Sz2tHlyi2qXjv/zPWa9e5BzRpuyGBb56N/fk4jIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ACr7eafx; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45611d82f2eso799995e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752420289; x=1753025089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d9ZNHXnXaiutNt4q3B66spimAL1ksGORFJerkfIEhuw=;
        b=ACr7eafx0KlrrK7wdzemM1D1Qw5Q/fV+ghXny8JeoXmkm7bjsMLmRx5+lzMjJT0SHd
         BPgCsKZyks3pWsXklqzZR7WGaYCPYC+btuMeLX4fOTSeriyYHj/CmN9pX3st5MhjStSg
         B+9cgmSgn5CJJDHih1y8NhneOURqXckr16gLcDXHeum6a7PbkJ4xINP/+M+XiUJyn4Ko
         sRtutARX9bK9Ua8TTY/sJEfFFGehXpBZXOujjMq4DLoVkMSG0MPEveyDBx8O+DzOnbKQ
         9rYXm2hWEB995rPMzHwGJbdL8SeTNDj2lyLPywCu4YfsH5gF8kYUy5qDpI7u6eQ9e94t
         bzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752420289; x=1753025089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9ZNHXnXaiutNt4q3B66spimAL1ksGORFJerkfIEhuw=;
        b=M1HrUb0opQG58U/kdG7QYfSME1hAxKEGU2vy5EkbMcAGQKmVT4+v8Lvd1z0W1jgclk
         uG/wCEDof/oiKwdMTCX9Fhm5RTsupHdNP+7SMS2rXiCh4ErF6g8oZAE9tNf6IDn2aM+/
         ZwIqprmTJ7kZQuj0fwQT8zR6cpNoJ4SBkmMqH97JXleo4ApEHd/hBG5O0hddL7VegDfG
         Qrl4S1INZcfr7q2AfBjELsBn0UAIAvxyLTyj89tV6hssqXZEP8mwtThU8vXll3zdf86M
         adWLCqRSvI+QPhl4QTZRJPZLEUqbu7yWzF3U7xtFKKCbgt1Tj4lkBHi6s1KoiUGgWrSE
         8BAw==
X-Forwarded-Encrypted: i=1; AJvYcCVtiLYHiK5T18PAPcZPWP+s7g+7GZlD2s5okvVTQgrawGSENvx25rRkfWLMABoehnoOLkDa2dBzH1UI39w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbM4HKx1BOwvRKE32AI8SpULEsA1TY8pK+zC8XzarxpoDxO963
	4JCg8jy1IlrqdAewx7zUXX1APvz97jXD4/mfmozBMXSZ59zmd81o8swTWbfZRA3Z3/g=
X-Gm-Gg: ASbGncts11KgypNqYrgxqQv59jlIZDA7ucXxxn1WrHBpm3ps3AU6GaZtQ+URGSHFsFR
	HdiGtAVIvaLuW28TR9XJvGk0rtWRkVZKkeSVElb/yj+sJ+ZIBMK0Bt4FLB3LSt6Qgu2I6PYeHS4
	yjL0zCeJFsms2nngJ9XoZuL/IArIjzRDfi4l9Ald/aI0pLrzbpxhQg8YEly1MpUXlhG5gHCkUGc
	rwY+87nHN+bUtS+sRBKYTTgAA/dRfACCiuj5FcfkEUs8ruLE6oCY9L4wdyiRYm/5ifcRRQ4BOku
	y0ji7oEEClMu8giMHrs0aD17zWvGZuNZE8fzJWz1K2Fsk0FdS5JT6Q+pfkAEwUcQzkKF5XR/yaE
	6j46hO5xXWUdKwloI7K1/Tui8nkTPEVYm8x8=
X-Google-Smtp-Source: AGHT+IGy8JKQhFVQ7X5a09go849LYeCFdHeT6JGJ2x1jHRS/zEozOLowuvjyXYNHDSKsJPFJGcQlKQ==
X-Received: by 2002:a05:600c:4f52:b0:441:c5ee:cdb4 with SMTP id 5b1f17b1804b1-454f42841ccmr36722635e9.4.1752420288847;
        Sun, 13 Jul 2025 08:24:48 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-455fde3fb7fsm28656635e9.3.2025.07.13.08.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jul 2025 08:24:48 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] i3c: master: cdns: Simplify handling clocks in probe()
Date: Sun, 13 Jul 2025 17:24:12 +0200
Message-ID: <20250713152411.74917-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=x6nwlnCf8EpliBB4PAXRWVJfoeL/+OwxGylEV3WROkY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoc8+bFmvNquQAH0tSpawh2scyCoMl+9QGb7lL/
 Znepp8IZNKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHPPmwAKCRDBN2bmhouD
 169oD/9wvzMYFZ1dj/NhqOY87tzC4+5LoUi+B1aRCH+9avMB5A6eXk06jyHYzCr5b8MRToMYqz/
 tDEyikyuka1/Nel7Sv5T54+4Q5b3mdfnbZdwcohrmnVCO1oSV9vUZsQLpgEx04SoQqp52z+IWX1
 SASkJTpsSUY0qxk0ZBGq48+EARpWyTS/2tVGY2v6peLA2pH4PoPhLe94k0uc2S0A03LWPMSgVbo
 z0D8HMSFWAmwMRMDneBSMBQ9kKNaCzlPm9TmZf3IWl6Mf1zJOSZhEI9UYr8z3abY847yUJkqurA
 dK6Sw4jdf4TeUi7IgDnv9V3IKz1E/NWN/7kZDE99+8Mn3uqrhgOjyeXTcAcch82RnhIN89ER+ha
 y14uR2ADvcUsvvYXoeDw4cSd7F/eY6Al+mI1/VHPK4pxID5kCYiV5Tgmy8Nih2LVCTc36kN5KR4
 NNLBzIqlzzxVBsxB4qnUtNOAFOzFIEsURiXxAv2YBsXxHuFjw+KY7RoQfs60d6D2GF19Bej0/6x
 Ami2GLyCLgFNSHR5grP/Jf7UhjUrKwfB5meBtI2TXrOTzznCQst341L69fZHKCiL9iXejW1/b7W
 MzpJCHUYKkWD2o56BT7S0ZgrvbMIWPq0UJC5DrQEMuGju5jRmMkvjDRkl8tXoGx9Ll4b/YR0eKo BMetp0bDtSamRhQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The two clocks, driver is getting, are not being disabled/re-enabled
during runtime of the device.  Eliminate one variable in state struct,
all error paths and a lot of code from probe() and remove() by using
devm_clk_get_enabled().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/i3c/master/i3c-master-cdns.c | 51 +++++++---------------------
 1 file changed, 12 insertions(+), 39 deletions(-)

diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
index 449e85d7ba87..cc504b58013a 100644
--- a/drivers/i3c/master/i3c-master-cdns.c
+++ b/drivers/i3c/master/i3c-master-cdns.c
@@ -412,7 +412,6 @@ struct cdns_i3c_master {
 	} xferqueue;
 	void __iomem *regs;
 	struct clk *sysclk;
-	struct clk *pclk;
 	struct cdns_i3c_master_caps caps;
 	unsigned long i3c_scl_lim;
 	const struct cdns_i3c_data *devdata;
@@ -1566,6 +1565,7 @@ MODULE_DEVICE_TABLE(of, cdns_i3c_master_of_ids);
 static int cdns_i3c_master_probe(struct platform_device *pdev)
 {
 	struct cdns_i3c_master *master;
+	struct clk *pclk;
 	int ret, irq;
 	u32 val;
 
@@ -1581,11 +1581,11 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (IS_ERR(master->regs))
 		return PTR_ERR(master->regs);
 
-	master->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(master->pclk))
-		return PTR_ERR(master->pclk);
+	pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(pclk))
+		return PTR_ERR(pclk);
 
-	master->sysclk = devm_clk_get(&pdev->dev, "sysclk");
+	master->sysclk = devm_clk_get_enabled(&pdev->dev, "sysclk");
 	if (IS_ERR(master->sysclk))
 		return PTR_ERR(master->sysclk);
 
@@ -1593,18 +1593,8 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	ret = clk_prepare_enable(master->pclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(master->sysclk);
-	if (ret)
-		goto err_disable_pclk;
-
-	if (readl(master->regs + DEV_ID) != DEV_ID_I3C_MASTER) {
-		ret = -EINVAL;
-		goto err_disable_sysclk;
-	}
+	if (readl(master->regs + DEV_ID) != DEV_ID_I3C_MASTER)
+		return -EINVAL;
 
 	spin_lock_init(&master->xferqueue.lock);
 	INIT_LIST_HEAD(&master->xferqueue.list);
@@ -1615,7 +1605,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	ret = devm_request_irq(&pdev->dev, irq, cdns_i3c_master_interrupt, 0,
 			       dev_name(&pdev->dev), master);
 	if (ret)
-		goto err_disable_sysclk;
+		return ret;
 
 	platform_set_drvdata(pdev, master);
 
@@ -1637,29 +1627,15 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
 	master->ibi.slots = devm_kcalloc(&pdev->dev, master->ibi.num_slots,
 					 sizeof(*master->ibi.slots),
 					 GFP_KERNEL);
-	if (!master->ibi.slots) {
-		ret = -ENOMEM;
-		goto err_disable_sysclk;
-	}
+	if (!master->ibi.slots)
+		return -ENOMEM;
 
 	writel(IBIR_THR(1), master->regs + CMD_IBI_THR_CTRL);
 	writel(MST_INT_IBIR_THR, master->regs + MST_IER);
 	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
 
-	ret = i3c_master_register(&master->base, &pdev->dev,
-				  &cdns_i3c_master_ops, false);
-	if (ret)
-		goto err_disable_sysclk;
-
-	return 0;
-
-err_disable_sysclk:
-	clk_disable_unprepare(master->sysclk);
-
-err_disable_pclk:
-	clk_disable_unprepare(master->pclk);
-
-	return ret;
+	return i3c_master_register(&master->base, &pdev->dev,
+				   &cdns_i3c_master_ops, false);
 }
 
 static void cdns_i3c_master_remove(struct platform_device *pdev)
@@ -1668,9 +1644,6 @@ static void cdns_i3c_master_remove(struct platform_device *pdev)
 
 	cancel_work_sync(&master->hj_work);
 	i3c_master_unregister(&master->base);
-
-	clk_disable_unprepare(master->sysclk);
-	clk_disable_unprepare(master->pclk);
 }
 
 static struct platform_driver cdns_i3c_master = {
-- 
2.43.0


