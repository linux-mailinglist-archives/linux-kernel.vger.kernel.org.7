Return-Path: <linux-kernel+bounces-829205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F88AB96849
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 893724E2EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE3E257842;
	Tue, 23 Sep 2025 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5uD2LfT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680D1DF247
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758640482; cv=none; b=pAgb1K/ddCURUHthTtcD5kGBYeJRhm0pv6kMeeDGL7kna+n5Ttz/7aTgL2OLVez39NxONSiSWoVNOb54eoCgJWPuS5eN+9qSU84FI+HmUzGR4F53Xew6UPHGFyHVwPX6pIwaGoGUSHnwJqKbQfjujUK3o8V4SRasvd0Enzumg74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758640482; c=relaxed/simple;
	bh=1KrVLh9i+3wagyFqRh2yb9A01gM5zJx1I7yzbRkVgqI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hYn6eSkzUidQ01BIZrvcrvAxeOby2NLq/11RCi4UXBLrDxkKjL0HopEfYo9HTQfQ6Cv51JMV7EyR31LicySAqobsEpMymHmgzC2krMH9iATXgY3++HFnz8ieL0OSkOOyjEXZzeoGAQaHOwTw0UGlDI3OxIs2YBKQLNk52I1hdQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5uD2LfT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46cb53c5900so29259285e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758640479; x=1759245279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bSzoRKv9D6242LbOslRZzX/vjvHi3jJdP3+X1xG4QfA=;
        b=Z5uD2LfT0UTWSxcCs+rmnha8QFyTy/f6KfE4wYo4tn2/NYP9iOVEv5icbx6BzurFKU
         cpD1oeJahgfXJYG3y0r+Og5krA90CefrUEbJdVgji+96baOEtSZG5qZ5Wt23ZOW+IOQk
         RYqTRhmXUkx8p4jfYartMf0uJHlIjU/0wL70EEQDoVG4RL1K28UuMTPrneKJz4qT/joj
         S5T0FBn4xwnWVCuWYa0/iKVlbw3Tq//l55N2tz7YXUDUZ3wpshJOzI9J3c2LJxT2+FbI
         hJ6q9fYTmaBYhI9wNa4EY7oCN0nI/AH6pFTx0NbPGk0d8NBcjez1PUA1Pyhd5HsbHztY
         /pfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758640479; x=1759245279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bSzoRKv9D6242LbOslRZzX/vjvHi3jJdP3+X1xG4QfA=;
        b=cavNzOiD8quAPoeLNpBw3RCrbb22vipLI76miGKESframwLZMPW8HCDsVuTwr3riBT
         MoY1BdWeCr6/eearIYVbmlHKYhE5zjWAiCicJ08BfT0zb6iyTAPeVypIYxeKR9+LX8xw
         I8xCeCF/Crr4WgZeeKPeaceK0t5nppeFc88017iX/gtItbY5W1OTxK9CxZgM6LhxRCo+
         zIGj0pHlwRfMIXwpfwe2mGB1280gnjzSsq2UsJJTdv82te0sxXUUDCj9ncC7AmETKdug
         AvgM8fRgbpc/SE2RV8B9zHYh+ZP2AxPMHxK7Hf+NuQXmObqVcukot5Zj4vZ0vfvJ8JGb
         EipQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJozK5X++TwXvjvSothJO9L/9Ib5Znr1+1wxieIUhMGLR7RqSSmZ0aL6nJBG01h7h0Xwwm/XyF72rKuH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAIG4XN0eQC8QypnAd64SVVBrUsDooo7tW+CXyfvVle9sJAQcO
	oKaCYeIYismz2SLAaHHWLXWugwyl8Ok3hHm7S+VLnoV406rEqyjqwFWX
X-Gm-Gg: ASbGncujF/+Xn4faXMt3hjAeUKspTSftptaqdZ1q6v43o/9OxzlJ4KSEk3X/fvjdPRL
	NjqvYBDCd+DJqE5Y0lYpA8WeK8exk+tPsho2bVDMG9yY9z3eG/ldUjY73J3GRfNl0VaJSk+307A
	ta09JtdgWR+FEZV4NDrZTt7pU2TnXKBvFP/A59uJsTRUanCrTMhrdQrOc0aw31XXcdtEP5m2RxO
	OcQ5wxDtALM8sSO6RIUOe9pzs/41MjrS42WE1nI0xyEFr4WTU49kYZy3ZZzKhdILkyQslTWDBuL
	bXMVQjyvxvmeXmB0ThVIZOlCrDMC/F+AoZ1nhY2ViqEJI4i6Cn3Y0vPbnyye5F8/stbkPQTM9Jw
	G9fHjtKjjkF9CgT8YKqCXQP2HiA3M8ZfuE/6tKNh8jhmu8LbGQBnjdsv3vaXXtP/dYtjSfCMr2Y
	Nc1w==
X-Google-Smtp-Source: AGHT+IFni6TH8MGUWBWjCjHCYhHGXILklcn8cRu2vDbncMqxw2ouu3ZjMQL5xTbf+f9nA3Rt1w8R1w==
X-Received: by 2002:a05:600c:3145:b0:46e:1d01:11dd with SMTP id 5b1f17b1804b1-46e1d9745c1mr25739075e9.2.1758640479096;
        Tue, 23 Sep 2025 08:14:39 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e1ce10bacsm20913985e9.0.2025.09.23.08.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 08:14:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2] memory: renesas-rpc-if: Add suspend/resume support
Date: Tue, 23 Sep 2025 16:14:33 +0100
Message-ID: <20250923151437.287721-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
callbacks to control spi/spix2 clocks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated error messages in rpcif_resume().
---
 drivers/memory/renesas-rpc-if.c | 57 ++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 4a417b693080..2bcb05559ccb 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -67,6 +67,8 @@ struct rpcif_priv {
 	void __iomem *dirmap;
 	struct regmap *regmap;
 	struct reset_control *rstc;
+	struct clk *spi_clk;
+	struct clk *spix2_clk;
 	struct platform_device *vdev;
 	size_t size;
 	const struct rpcif_info *info;
@@ -1025,16 +1027,14 @@ static int rpcif_probe(struct platform_device *pdev)
 	 * disable it in remove().
 	 */
 	if (rpc->info->type == XSPI_RZ_G3E) {
-		struct clk *spi_clk;
-
-		spi_clk = devm_clk_get_enabled(dev, "spix2");
-		if (IS_ERR(spi_clk))
-			return dev_err_probe(dev, PTR_ERR(spi_clk),
+		rpc->spix2_clk = devm_clk_get_enabled(dev, "spix2");
+		if (IS_ERR(rpc->spix2_clk))
+			return dev_err_probe(dev, PTR_ERR(rpc->spix2_clk),
 					     "cannot get enabled spix2 clk\n");
 
-		spi_clk = devm_clk_get_enabled(dev, "spi");
-		if (IS_ERR(spi_clk))
-			return dev_err_probe(dev, PTR_ERR(spi_clk),
+		rpc->spi_clk = devm_clk_get_enabled(dev, "spi");
+		if (IS_ERR(rpc->spi_clk))
+			return dev_err_probe(dev, PTR_ERR(rpc->spi_clk),
 					     "cannot get enabled spi clk\n");
 	}
 
@@ -1063,6 +1063,44 @@ static void rpcif_remove(struct platform_device *pdev)
 	platform_device_unregister(rpc->vdev);
 }
 
+static int rpcif_suspend(struct device *dev)
+{
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
+
+	if (rpc->info->type == XSPI_RZ_G3E) {
+		clk_disable_unprepare(rpc->spi_clk);
+		clk_disable_unprepare(rpc->spix2_clk);
+	}
+
+	return 0;
+}
+
+static int rpcif_resume(struct device *dev)
+{
+	struct rpcif_priv *rpc = dev_get_drvdata(dev);
+
+	if (rpc->info->type == XSPI_RZ_G3E) {
+		int ret;
+
+		ret = clk_prepare_enable(rpc->spix2_clk);
+		if (ret) {
+			dev_err(dev, "failed to enable spix2 clock: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
+
+		ret = clk_prepare_enable(rpc->spi_clk);
+		if (ret) {
+			clk_disable_unprepare(rpc->spix2_clk);
+			dev_err(dev, "failed to enable spi clock: %pe\n",
+				ERR_PTR(ret));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static const struct rpcif_impl rpcif_impl = {
 	.hw_init = rpcif_hw_init_impl,
 	.prepare = rpcif_prepare_impl,
@@ -1125,12 +1163,15 @@ static const struct of_device_id rpcif_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rpcif_of_match);
 
+static DEFINE_SIMPLE_DEV_PM_OPS(rpcif_pm_ops, rpcif_suspend, rpcif_resume);
+
 static struct platform_driver rpcif_driver = {
 	.probe	= rpcif_probe,
 	.remove = rpcif_remove,
 	.driver = {
 		.name =	"rpc-if",
 		.of_match_table = rpcif_of_match,
+		.pm = pm_sleep_ptr(&rpcif_pm_ops),
 	},
 };
 module_platform_driver(rpcif_driver);
-- 
2.43.0


