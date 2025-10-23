Return-Path: <linux-kernel+bounces-867431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EDAC02A97
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 19:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27459567333
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A94533F8B6;
	Thu, 23 Oct 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwDO1Qi7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04769314D1E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761238330; cv=none; b=NvejUnejHZxTAqEvyTDKgdyoTX2IrG6grB6/z4jBGNFdu/OPBK6eFZVepYIGWGHRJP+cSHfzfiCA1Dt5Gy1CLBRPP51aERjxzo/r5ubsoNcMfyvSrPrabiS1SkvpWcuT8A5zQxjeOurFox1jyqodsi8s2C/dJy7tB0qGouS0OdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761238330; c=relaxed/simple;
	bh=Un9cy8WvlPiOpPDaw3C6f2NQUDVmZuXpLzFqgb6+81w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cssiRdDJX0EiUhotZa4mUMmHVNJdWaKI0/GJiLzhJcsaLFfYtFvLWzgisaJohHFuuiYV6a/AJLofk7NAVdg4WukexAmvSIsrR5DMxX46pqHtBz0LxUjHyjBtsdX7IOEm2H21K0dYOVupScxKkBuduaRcixIcK8qlklcLyH/cbdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwDO1Qi7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D864C4CEE7;
	Thu, 23 Oct 2025 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761238329;
	bh=Un9cy8WvlPiOpPDaw3C6f2NQUDVmZuXpLzFqgb6+81w=;
	h=From:To:Cc:Subject:Date:From;
	b=dwDO1Qi76AcI1gfq9ZzorLbQtZ81lg9KNstGf4LsICSR0C1WnydHFvHGt3OHAN4BL
	 XJCFh+8Blplk7/K2cyielPV2ynMeUiVtdzcs+kJSqLsEqNuPxCp6DhPwRnCuetlMHa
	 BQUuWS3P+5lUNsHMSV54GyYjlRQrhnZLXyG+0Q90yzooVobWLkgkgPJ5cqSssv5NCE
	 L3//YQw1Y8Qf0rCyHOsdbDTyjLRv0jY1FxE4689ydc5s3+6InMxDmILAuBEkf57Oa2
	 FKOQc41n5c2kphR9cgzwRX23rQuHyDlIxy4GvODXpZZGHMNujqzAqEw5aTT2W0qzGp
	 W7k0K6xU09Psw==
From: Conor Dooley <conor@kernel.org>
To: claudiu.beznea@tuxon.dev
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] soc: microchip: fixups per CB review
Date: Thu, 23 Oct 2025 17:51:15 +0100
Message-ID: <20251023-sadness-shiny-6c2f966d621e@spud>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=WD3sVWmk63zgJPc5ZkZyYjiq6UnccQrit2LiNouJnbg=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDBm/YpmTFb+E/1Iv2PRAfqPb3wsN6aqbrzi0CN768Wsqs +Gve6c7O0pZGMS4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjARtnuMDB2NLfHsZpmt1iqp M1q3OhrfvJ6ZfUL3zNqS6tjZvwvZuhn+5+f3O/+ZyXY9vSLcPvM/Y+TlrqDO9T9rZ7l6zbcIvzG JCwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

I'm gonna squash this, since only the binding is a stable tag.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
CC: Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: Conor Dooley <conor@kernel.org>
CC: linux-kernel@vger.kernel.org
---
 drivers/soc/microchip/mpfs-control-scb.c    | 15 ++++-----------
 drivers/soc/microchip/mpfs-mss-top-sysreg.c | 12 ++++--------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/soc/microchip/mpfs-control-scb.c b/drivers/soc/microchip/mpfs-control-scb.c
index d1a8e79c232e..f0b84b1f49cb 100644
--- a/drivers/soc/microchip/mpfs-control-scb.c
+++ b/drivers/soc/microchip/mpfs-control-scb.c
@@ -2,31 +2,24 @@
 
 #include <linux/array_size.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/syscon.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 static const struct mfd_cell mpfs_control_scb_devs[] = {
-	{ .name = "mpfs-tvs", },
+	MFD_CELL_NAME("mpfs-tvs"),
 };
 
 static int mpfs_control_scb_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	int ret;
 
-	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
-			      1, NULL, 0, NULL);
-	if (ret)
-		return ret;
-
-	return 0;
+	return mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_control_scb_devs,
+			       ARRAY_SIZE(mpfs_control_scb_devs), NULL, 0, NULL);
 }
 
 static const struct of_device_id mpfs_control_scb_of_match[] = {
-	{.compatible = "microchip,mpfs-control-scb", },
+	{ .compatible = "microchip,mpfs-control-scb", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpfs_control_scb_of_match);
diff --git a/drivers/soc/microchip/mpfs-mss-top-sysreg.c b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
index 9b2e7b84cdba..b2244e44ff0f 100644
--- a/drivers/soc/microchip/mpfs-mss-top-sysreg.c
+++ b/drivers/soc/microchip/mpfs-mss-top-sysreg.c
@@ -2,14 +2,13 @@
 
 #include <linux/array_size.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/mfd/core.h>
 #include <linux/mfd/syscon.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
 static const struct mfd_cell mpfs_mss_top_sysreg_devs[] = {
-	{ .name = "mpfs-reset", },
+	MFD_CELL_NAME("mpfs-reset"),
 };
 
 static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
@@ -18,18 +17,15 @@ static int mpfs_mss_top_sysreg_probe(struct platform_device *pdev)
 	int ret;
 
 	ret = mfd_add_devices(dev, PLATFORM_DEVID_NONE, mpfs_mss_top_sysreg_devs,
-			      1, NULL, 0, NULL);
+			      ARRAY_SIZE(mpfs_mss_top_sysreg_devs) , NULL, 0, NULL);
 	if (ret)
 		return ret;
 
-	if (devm_of_platform_populate(dev))
-		dev_err(dev, "Error populating children\n");
-
-	return 0;
+	return devm_of_platform_populate(dev);
 }
 
 static const struct of_device_id mpfs_mss_top_sysreg_of_match[] = {
-	{.compatible = "microchip,mpfs-mss-top-sysreg", },
+	{ .compatible = "microchip,mpfs-mss-top-sysreg", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, mpfs_mss_top_sysreg_of_match);
-- 
2.51.0


