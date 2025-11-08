Return-Path: <linux-kernel+bounces-891749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F21D0C43614
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 00:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76206348958
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 23:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C762882B7;
	Sat,  8 Nov 2025 23:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="LhincJ8Y"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E2F287259
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643604; cv=none; b=fq9MxqBzDCc3M63QSM3HMeWFdHXfuq5hM84nCYmDALOxQWqYZZH3gafGy6eps7UOSAEveZLm1FxVodfT3ZA37qc/HjObPYFzB3cwjhlGmZ8d/ACkIjJMsd+1JRR7DqhLnlnsadF8zLuTECiPrxg1LC8cHipdaQItfZKt/3O0W10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643604; c=relaxed/simple;
	bh=Uyhvca88h8vv2OXwxtdsVNrGpi7PUq2+kDeHdZ0oXjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIYfeCrhVPYN8sVhcWJx0T4PegGChiMahiMCOrbJmCE/5lf/4KSFCSn/RiYdHtkVBVY5eyIHbbejQNzUQ+OdEfskuRoLfX3BSDmN+8iWkm/dWCk8A4+5WKATmP+dWl3dZ2SkxjIqFICuCRv5c9RmaXnHk3Bj7RKUmHjMrCPJfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=LhincJ8Y; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-640b4a52950so2883986a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 15:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643601; x=1763248401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIdZxomTiawbxwfqpMnoqPSizZxwJiiryInuVxUgs40=;
        b=LhincJ8YrW4cCa30JjkSAPa35E4wQOBqvdpYZMKBXXyxaOrlHCo0o2FqDamTx/vsnr
         d3BvE7Mbcp+kE/2Rqo9MLjtmq5s1WmCrBZl92s2nFbezuugFsi5V/Uqn6JetG4MnXLaX
         8dWq/MZw7fdpv1x05TidydU0F1c9Phra6Gk8Kjhx39bCROPz8xl+Bn9yfOj5cN2UUyCg
         Ahl43oQoBlTIUHK+XdSvujFUfjk2QiPIIChUlSiS4e0taQGYEmizcRkT/3YM3J2q0wWL
         Q2CotD6XmMEPwsEGv/58RfuUkso2qA7V7TiRTXecVO/BOekBb2cbjvb20sUi4MOvDe98
         42aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643601; x=1763248401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OIdZxomTiawbxwfqpMnoqPSizZxwJiiryInuVxUgs40=;
        b=Y8r9l8v3adJN3LF+fUk5tHSBqaj4J9o2BqJxhLnme06d9ru+ghtLG/2TZK2RgHQrq0
         Eu3DTzNA5JcHhgcVlOSGWj8HY+a3Nu06WOFQAL9KWoAf0EIiyVN58oDtlGEotlRRUZbm
         pN/k/gBvuFi8cNq62lTUVMXVKwPl1xy8t2IeNAt6xCNZrelk/ON4WxqWpjU/y7mOH2xY
         gZJPlgdmeS0SxtuA9F/1PBU7Yo+EKx/nxp66+7Q3UjNc4bOPwMb06wOw6+cRUrSscxex
         eTLpVoVwJQh4tr8Zfc3NerfzN+z4WKfa5TlhB1NIzDLxx+WOQMAfpupuJ/2WhuSzv14X
         XSYA==
X-Forwarded-Encrypted: i=1; AJvYcCWg8bUg8avnz4J4WhJpV0jf1v6QqaavI/OY8miv60FXsY5UOtZC0C71fq9b9e6kSRb1l986Fxx59Y/ZTeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnnCVYYb9+AABRNQNtpPeOlK6Moe6GuHi8yjrezYeEfToGPNy
	hSU0njMLQw3JyPoUVzP9t+2d9wJbGhFOmEovoUuyG/H9rnWdV9lfjSqt
X-Gm-Gg: ASbGnctXQKG7S9jrpl0lDoG29CjST1+idJl7faInIKc8uEGNtBXh9xEcJ8OKCJ4vB2x
	HO7W1vBc8gBg7N0/m/AOWlUltn+ojrmHh+v7Lg27Kmr6Q994+JK2RKlzmet1YuqVaJa/juTJjPu
	9lis4g7Oz+JKzXUpG3m+6WwABXqgHRhhVkDN+uEh6jTzZB4I60QMtGRJ3J4rokAGjZ5hQjNjvGa
	61F3jc/K46vpQ50SFKtMlXbcPw7X7Ux1LYat3yIUIbiY5NTfl+R12Nv7/dwvJJy6Omoh2MQSLtH
	feezaeQvWvQdK/fnyvuJTwy8w5iRC0yx8VKqmfWkJzn3EDQz4DF9GAYwOPaCCnVizM6JIP5Mm7i
	ZLuPEDeA+HaVWB9AI0JcsCdxNFvJw03rZB0R1FZcKpm0mZ2PlLsMvu2ySkOphDacoF/922cZjYj
	7gO7hjw1zt09c8B1zSegYdXVkvQEo9aToUuWxc1CvnxsWgTrPPT15qt8J8LMG/cIDAnvuJuYyrG
	nE9aY2+5fAEr2UH1XsJxyi01WiZl2+b
X-Google-Smtp-Source: AGHT+IFQjlRv39XcJklWKjtg5/kXtIXi7GGXYRLVU3hdPD9cbN+MwifNhIboaa4CWjMgje18D1/dkg==
X-Received: by 2002:a05:6402:2106:b0:640:8eed:5601 with SMTP id 4fb4d7f45d1cf-6415e104231mr2993008a12.2.1762643600704;
        Sat, 08 Nov 2025 15:13:20 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:19 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 2/7] mmc: meson-mx-sdio: Use devm_clk_get_enabled()
Date: Sun,  9 Nov 2025 00:12:48 +0100
Message-ID: <20251108231253.1641927-3-martin.blumenstingl@googlemail.com>
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

This simplifies the code. No functional changes intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/meson-mx-sdio.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 2448f21bd683..1159cc911359 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -103,7 +103,6 @@ struct meson_mx_mmc_host {
 	struct device			*controller_dev;
 
 	struct clk			*parent_clk;
-	struct clk			*core_clk;
 	struct clk_divider		cfg_div;
 	struct clk			*cfg_div_clk;
 	struct clk_fixed_factor		fixed_factor;
@@ -627,6 +626,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	struct platform_device *slot_pdev;
 	struct mmc_host *mmc;
 	struct meson_mx_mmc_host *host;
+	struct clk *core_clk;
 	void __iomem *base;
 	int ret, irq;
 	u32 conf;
@@ -676,9 +676,9 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_mmc;
 
-	host->core_clk = devm_clk_get(host->controller_dev, "core");
-	if (IS_ERR(host->core_clk)) {
-		ret = PTR_ERR(host->core_clk);
+	core_clk = devm_clk_get_enabled(host->controller_dev, "core");
+	if (IS_ERR(core_clk)) {
+		ret = PTR_ERR(core_clk);
 		goto error_free_mmc;
 	}
 
@@ -692,16 +692,10 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_free_mmc;
 
-	ret = clk_prepare_enable(host->core_clk);
-	if (ret) {
-		dev_err(host->controller_dev, "Failed to enable core clock\n");
-		goto error_free_mmc;
-	}
-
 	ret = clk_prepare_enable(host->cfg_div_clk);
 	if (ret) {
 		dev_err(host->controller_dev, "Failed to enable MMC clock\n");
-		goto error_disable_core_clk;
+		goto error_free_mmc;
 	}
 
 	conf = 0;
@@ -715,14 +709,12 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 	ret = meson_mx_mmc_add_host(host);
 	if (ret)
-		goto error_disable_clks;
+		goto error_disable_div_clk;
 
 	return 0;
 
-error_disable_clks:
+error_disable_div_clk:
 	clk_disable_unprepare(host->cfg_div_clk);
-error_disable_core_clk:
-	clk_disable_unprepare(host->core_clk);
 error_free_mmc:
 	mmc_free_host(mmc);
 error_unregister_slot_pdev:
@@ -742,7 +734,6 @@ static void meson_mx_mmc_remove(struct platform_device *pdev)
 	of_platform_device_destroy(slot_dev, NULL);
 
 	clk_disable_unprepare(host->cfg_div_clk);
-	clk_disable_unprepare(host->core_clk);
 
 	mmc_free_host(host->mmc);
 }
-- 
2.51.2


