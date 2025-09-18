Return-Path: <linux-kernel+bounces-752087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1C4B1711D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02CE27B864B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E162D0C89;
	Thu, 31 Jul 2025 12:24:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE22D0C86
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964642; cv=none; b=TRFQWefgaCGivshhjhs6xKoVy3UL8kLv70fJkvjPo9Brlvm33HH7ygLlopt38n5Ia5Bfp8i80hRhx5pJEZlF5Gfjg+PVu8de7ZOtfTjgCYsrXU5ICx9Uvp+KWK/43NzonCK6KbNJDGPb671rEjV1TMZLbCuVfqk+pzFkYXNlERk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964642; c=relaxed/simple;
	bh=mcfXTHdIDyVS+sEWGO/pV01EXfkVbP1a/sa1I7JP1Oc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s55XaA9VjI3iB+15kx4TXQWnTYC5dQYV/RxCFGLBGSklCJU2IL37S9CZYNZzkO3hN9jgXzS8F5ArWpGcRXfzjbZA+I5wYytc/1R/fqoiecvt+hOA+ZQKdHvJmlh5wPbyLO5PJWq51XHP54BP6JaoogTPsS+OjE1LSSsE8FdFcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFE322C41;
	Thu, 31 Jul 2025 05:23:51 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0C93F673;
	Thu, 31 Jul 2025 05:23:58 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 13:23:40 +0100
Subject: [PATCH v6 04/10] coresight: Appropriately disable programming
 clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_cs_fix_clock_v4-v6-4-1dfe10bb3f6f@arm.com>
References: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
In-Reply-To: <20250731-arm_cs_fix_clock_v4-v6-0-1dfe10bb3f6f@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mark Brown <broonie@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753964630; l=13269;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=mcfXTHdIDyVS+sEWGO/pV01EXfkVbP1a/sa1I7JP1Oc=;
 b=24tiOvsLU8L5G8AbIVTDIOQkkY7ZBFHF5vLw49T2dEivS8YFcA1dZGpsP6K7jEv32znOJrsNj
 CVpVBNyuup7CUjW6mmtyxH3oq9ki8IpPtJxgAX0//yEC2B6jzCa9bYu
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Some CoreSight components have programming clocks (pclk) and are enabled
using clk_get() and clk_prepare_enable().  However, in many cases, these
clocks are not disabled when modules exit and only released by clk_put().

To fix the issue, this commit refactors programming clock by replacing
clk_get() and clk_prepare_enable() with devm_clk_get_optional_enabled()
for enabling APB clock. If the "apb_pclk" clock is not found, a NULL
pointer is returned, and the function proceeds to attempt enabling the
"apb" clock.

Since ACPI platforms rely on firmware to manage clocks, returning a NULL
pointer in this case leaves clock management to the firmware rather than
the driver. This effectively avoids a clock imbalance issue during
module removal - where the clock could be disabled twice: once during
the ACPI runtime suspend and again during the devm resource release.

Callers are updated to reuse the returned error value.

With the change, programming clocks are managed as resources in driver
model layer, allowing clock cleanup to be handled automatically.  As a
result, manual cleanup operations are no longer needed and are removed
from the Coresight drivers.

Fixes: 73d779a03a76 ("coresight: etm4x: Change etm4_platform_driver driver for MMIO devices")
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       |  9 ++-------
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  6 +-----
 drivers/hwtracing/coresight/coresight-ctcu-core.c  | 10 ++--------
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  9 ++-------
 drivers/hwtracing/coresight/coresight-funnel.c     |  6 +-----
 drivers/hwtracing/coresight/coresight-replicator.c |  6 +-----
 drivers/hwtracing/coresight/coresight-stm.c        |  4 +---
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  4 +---
 drivers/hwtracing/coresight/coresight-tpiu.c       |  4 +---
 include/linux/coresight.h                          | 22 +++++++++-------------
 10 files changed, 21 insertions(+), 59 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index af2a55f0c907c392d092a50612b23c115a1b0f5f..4c345ff2cff141ea63c2220393e5fdd00c449ca6 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -636,7 +636,7 @@ static int catu_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
@@ -645,11 +645,8 @@ static int catu_platform_probe(struct platform_device *pdev)
 	dev_set_drvdata(&pdev->dev, drvdata);
 	ret = __catu_probe(&pdev->dev, res);
 	pm_runtime_put(&pdev->dev);
-	if (ret) {
+	if (ret)
 		pm_runtime_disable(&pdev->dev);
-		if (!IS_ERR_OR_NULL(drvdata->pclk))
-			clk_put(drvdata->pclk);
-	}
 
 	return ret;
 }
@@ -663,8 +660,6 @@ static void catu_platform_remove(struct platform_device *pdev)
 
 	__catu_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index a871d997330b09bdb741f35c59108b0b3252cc54..e39dfb886688e111eee95d4294f37fa85baccd14 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -699,7 +699,7 @@ static int debug_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
@@ -710,8 +710,6 @@ static int debug_platform_probe(struct platform_device *pdev)
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
 		pm_runtime_disable(&pdev->dev);
-		if (!IS_ERR_OR_NULL(drvdata->pclk))
-			clk_put(drvdata->pclk);
 	}
 	return ret;
 }
@@ -725,8 +723,6 @@ static void debug_platform_remove(struct platform_device *pdev)
 
 	__debug_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index c6bafc96db963310b5e77a095953c83a172cfc7c..de279efe340581ceabfb9e1cd1e7fe4b5e4f826e 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -209,7 +209,7 @@ static int ctcu_probe(struct platform_device *pdev)
 
 	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->apb_clk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->apb_clk);
 
 	cfgs = of_device_get_match_data(dev);
 	if (cfgs) {
@@ -233,12 +233,8 @@ static int ctcu_probe(struct platform_device *pdev)
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		if (!IS_ERR_OR_NULL(drvdata->apb_clk))
-			clk_put(drvdata->apb_clk);
-
+	if (IS_ERR(drvdata->csdev))
 		return PTR_ERR(drvdata->csdev);
-	}
 
 	return 0;
 }
@@ -275,8 +271,6 @@ static void ctcu_platform_remove(struct platform_device *pdev)
 
 	ctcu_remove(pdev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->apb_clk))
-		clk_put(drvdata->apb_clk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 36cbf60f24f1e86b466c9c216d33c74393f65504..1892e1c3e4a1b2389e858abf9cf08a6868ae475e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2304,14 +2304,12 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	if (res) {
 		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(drvdata->base)) {
-			clk_put(drvdata->pclk);
+		if (IS_ERR(drvdata->base))
 			return PTR_ERR(drvdata->base);
-		}
 	}
 
 	dev_set_drvdata(&pdev->dev, drvdata);
@@ -2418,9 +2416,6 @@ static void etm4_remove_platform_dev(struct platform_device *pdev)
 	if (drvdata)
 		etm4_remove_dev(drvdata);
 	pm_runtime_disable(&pdev->dev);
-
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 static const struct amba_id etm4_ids[] = {
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b1922dbe9292b02c91ca5730998e59ecdb08fdc7..36fc4e991458c112521c4261d73f3e58e9a3f995 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -240,7 +240,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	/*
 	 * Map the device base for dynamic-funnel, which has been
@@ -284,8 +284,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
 	return ret;
 }
 
@@ -355,8 +353,6 @@ static void funnel_platform_remove(struct platform_device *pdev)
 
 	funnel_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 static const struct of_device_id funnel_match[] = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 06efd2b01a0f71620eac71166567d14655b58403..6dd24eb10a94b0eb28f4f27afab845227e22b96c 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -247,7 +247,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	/*
 	 * Map the device base for dynamic-replicator, which has been
@@ -296,8 +296,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
-	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
 	return ret;
 }
 
@@ -335,8 +333,6 @@ static void replicator_platform_remove(struct platform_device *pdev)
 
 	replicator_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 464b0c85c3f7d3519169d62a51e9f8c6281b5358..f2de16e4d3b4cc0fc3fa06654fc7ddd9dee1e302 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -851,7 +851,7 @@ static int __stm_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	base = devm_ioremap_resource(dev, res);
@@ -1033,8 +1033,6 @@ static void stm_platform_remove(struct platform_device *pdev)
 
 	__stm_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 85ba037c27f7b18fd4aed2447129f15316e635d5..519f225428070df5c5e6fcf014cd132058f01228 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -981,7 +981,7 @@ static int tmc_platform_probe(struct platform_device *pdev)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
@@ -1005,8 +1005,6 @@ static void tmc_platform_remove(struct platform_device *pdev)
 
 	__tmc_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 3e01592884280819c16398cbb5e09cbaee5d3efb..b2559c6fac6d2f02e0038e583cd324d7165c5aee 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -153,7 +153,7 @@ static int __tpiu_probe(struct device *dev, struct resource *res)
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
-		return -ENODEV;
+		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -293,8 +293,6 @@ static void tpiu_platform_remove(struct platform_device *pdev)
 
 	__tpiu_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	if (!IS_ERR_OR_NULL(drvdata->pclk))
-		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_ACPI
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..1e652e157841955864a4bce00b2285efcad327aa 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -6,6 +6,7 @@
 #ifndef _LINUX_CORESIGHT_H
 #define _LINUX_CORESIGHT_H
 
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -480,26 +481,21 @@ static inline bool is_coresight_device(void __iomem *base)
  * Returns:
  *
  * clk   - Clock is found and enabled
- * NULL  - clock is not found
+ * NULL  - Clock is controlled by firmware (ACPI device only)
  * ERROR - Clock is found but failed to enable
  */
 static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
 {
 	struct clk *pclk;
-	int ret;
 
-	pclk = clk_get(dev, "apb_pclk");
-	if (IS_ERR(pclk)) {
-		pclk = clk_get(dev, "apb");
-		if (IS_ERR(pclk))
-			return NULL;
-	}
+	/* Firmware controls clocks for an ACPI device. */
+	if (has_acpi_companion(dev))
+		return NULL;
+
+	pclk = devm_clk_get_optional_enabled(dev, "apb_pclk");
+	if (!pclk)
+		pclk = devm_clk_get_optional_enabled(dev, "apb");
 
-	ret = clk_prepare_enable(pclk);
-	if (ret) {
-		clk_put(pclk);
-		return ERR_PTR(ret);
-	}
 	return pclk;
 }
 

-- 
2.34.1


