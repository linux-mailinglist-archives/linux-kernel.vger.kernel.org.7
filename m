Return-Path: <linux-kernel+bounces-744563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A670BB10E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6567B0C0D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A652E9748;
	Thu, 24 Jul 2025 15:23:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C732EB5A1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370583; cv=none; b=WkotDt1SSJdYTHHzvOlaymfQqd/nGqNMaWg2YrFUFEr0WNUOAPKdOlS9CplCtnAqikgL7E+xbCCFnwxAgThKK0QlBDWBUkWA2HHdN8sIJSaHOJbC8rP6JS8ZBuZrHsInSsPcmqFwLjVyRsCloEgFaftMTJH6oZSZ8OKS7btFVs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370583; c=relaxed/simple;
	bh=IT2xsuCYyPFSburN6I1fg8rNoD/L+iaoBGyrN6tbBHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K6842i1GfY2LuvUhAW1+vCbWPCylUBLk99Jk6NEHN4oLez9gtAXojT4uAMwcr/P6BUScu2pp+6i7w52yUEJhMfcurWqUBrQD0wuxLnd4yMZZZIbVUFpDFERuKorPCwHJkdrHlEt9dWxPfXNv1dFsit0VOMf/0MmDyGytfZGF3Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43A9B1CC4;
	Thu, 24 Jul 2025 08:22:54 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 238A03F6A8;
	Thu, 24 Jul 2025 08:22:59 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 24 Jul 2025 16:22:37 +0100
Subject: [PATCH v5 07/10] coresight: Consolidate clock enabling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-arm_cs_fix_clock_v4-v5-7-63f648dae021@arm.com>
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
In-Reply-To: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370566; l=16295;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=IT2xsuCYyPFSburN6I1fg8rNoD/L+iaoBGyrN6tbBHo=;
 b=ECYHkYMlT/v/X7c3rb4Y+q78NUTMeh6DIQ9R8IsDnLWgdHjSPl1eGJgu1FQErtEdcJjC5bjGI
 XWk+x9c1KVWDRywQ2qcfgfCtN05wMi5+gKXOTqXTnktogXaBhsYnAbd
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

CoreSight drivers enable pclk and atclk conditionally. For example,
pclk is only enabled in the static probe, while atclk is an optional
clock that it is enabled for both dynamic and static probes, if it is
present. In the current CoreSight drivers, these two clocks are
initialized separately.  This causes complex and duplicate codes.

CoreSight drivers are refined so that clocks are initialized in one go.
For this purpose, this commit renames coresight_get_enable_apb_pclk() to
coresight_get_enable_clocks() and encapsulates clock initialization
logic:

 - If a clock is initialized successfully, its clock pointer is assigned
   to the double pointer passed as an argument.
 - For ACPI devices, clocks are controlled by firmware, directly bail
   out.
 - Skip enabling pclk for an AMBA device.
 - If atclk is not found, the corresponding double pointer is set to
   NULL. The function returns Success (0) to guide callers can proceed
   with no error.
 - Otherwise, an error number is returned for failures.

The function became complex, move it from the header to the CoreSight
core layer and the symbol is exported. Added comments for recording
details.

Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c       | 10 ++---
 drivers/hwtracing/coresight/coresight-core.c       | 48 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  8 ++--
 drivers/hwtracing/coresight/coresight-ctcu-core.c  |  8 ++--
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++---
 drivers/hwtracing/coresight/coresight-funnel.c     | 11 ++---
 drivers/hwtracing/coresight/coresight-replicator.c | 11 ++---
 drivers/hwtracing/coresight/coresight-stm.c        |  9 ++--
 drivers/hwtracing/coresight/coresight-tmc-core.c   | 10 ++---
 drivers/hwtracing/coresight/coresight-tpiu.c       | 10 ++---
 include/linux/coresight.h                          | 30 +-------------
 11 files changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 4c345ff2cff141ea63c2220393e5fdd00c449ca6..0f476a0cbd740c233d039c5c411ca192681e2023 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -520,9 +520,9 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	void __iomem *base;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
 	catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
 	if (!catu_desc.name)
@@ -634,10 +634,6 @@ static int catu_platform_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
-
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 1accd7cbd54bf0c41ba209dccfd510d9710a21f7..66b7eb4990fa0e390eae78e711196d7662c8cde7 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2012, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitfield.h>
 #include <linux/build_bug.h>
 #include <linux/kernel.h>
@@ -1700,6 +1701,53 @@ int coresight_etm_get_trace_id(struct coresight_device *csdev, enum cs_mode mode
 }
 EXPORT_SYMBOL_GPL(coresight_etm_get_trace_id);
 
+/*
+ * Attempt to find and enable programming clock (pclk) and trace clock (atclk)
+ * for the given device.
+ *
+ * For ACPI devices, clocks are controlled by firmware, so bail out early in
+ * this case. Also, skip enabling pclk if the clock is managed by the AMBA
+ * bus driver instead.
+ *
+ * atclk is an optional clock, it will be only enabled when it is existed.
+ * Otherwise, a NULL pointer will be returned to caller.
+ *
+ * Returns: '0' on Success; Error code otherwise.
+ */
+int coresight_get_enable_clocks(struct device *dev, struct clk **pclk,
+				struct clk **atclk)
+{
+	WARN_ON(!pclk);
+
+	if (has_acpi_companion(dev))
+		return 0;
+
+	if (!dev_is_amba(dev)) {
+		/*
+		 * "apb_pclk" is the default clock name for an Arm Primecell
+		 * peripheral, while "apb" is used only by the CTCU driver.
+		 *
+		 * For easier maintenance, CoreSight drivers should use
+		 * "apb_pclk" as the programming clock name.
+		 */
+		*pclk = devm_clk_get_enabled(dev, "apb_pclk");
+		if (IS_ERR(*pclk))
+			*pclk = devm_clk_get_enabled(dev, "apb");
+		if (IS_ERR(*pclk))
+			return PTR_ERR(*pclk);
+	}
+
+	/* Initialization of atclk is skipped if it is a NULL pointer. */
+	if (atclk) {
+		*atclk = devm_clk_get_optional_enabled(dev, "atclk");
+		if (IS_ERR(*atclk))
+			return PTR_ERR(*atclk);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(coresight_get_enable_clocks);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index e39dfb886688e111eee95d4294f37fa85baccd14..5f6db2fb95d4623a0bab08828ae00442870abd7d 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -566,6 +566,10 @@ static int __debug_probe(struct device *dev, struct resource *res)
 	void __iomem *base;
 	int ret;
 
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, NULL);
+	if (ret)
+		return ret;
+
 	drvdata->cpu = coresight_get_cpu(dev);
 	if (drvdata->cpu < 0)
 		return drvdata->cpu;
@@ -697,10 +701,6 @@ static int debug_platform_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
-
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/hwtracing/coresight/coresight-ctcu-core.c b/drivers/hwtracing/coresight/coresight-ctcu-core.c
index de279efe340581ceabfb9e1cd1e7fe4b5e4f826e..75b5114ef652e4a47c53fbd2b7811c1bab575645 100644
--- a/drivers/hwtracing/coresight/coresight-ctcu-core.c
+++ b/drivers/hwtracing/coresight/coresight-ctcu-core.c
@@ -188,7 +188,7 @@ static int ctcu_probe(struct platform_device *pdev)
 	const struct ctcu_config *cfgs;
 	struct ctcu_drvdata *drvdata;
 	void __iomem *base;
-	int i;
+	int i, ret;
 
 	desc.name = coresight_alloc_device_name(&ctcu_devs, dev);
 	if (!desc.name)
@@ -207,9 +207,9 @@ static int ctcu_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	drvdata->apb_clk = coresight_get_enable_apb_pclk(dev);
-	if (IS_ERR(drvdata->apb_clk))
-		return PTR_ERR(drvdata->apb_clk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->apb_clk, NULL);
+	if (ret)
+		return ret;
 
 	cfgs = of_device_get_match_data(dev);
 	if (cfgs) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1892e1c3e4a1b2389e858abf9cf08a6868ae475e..3046605b5e6121c438b96d8cbfb761c23456edf2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -2212,13 +2212,14 @@ static int etm4_probe(struct device *dev)
 	struct csdev_access access = { 0 };
 	struct etm4_init_arg init_arg = { 0 };
 	struct etm4_init_arg *delayed;
+	int ret;
 
 	if (WARN_ON(!drvdata))
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
 	if (pm_save_enable == PARAM_PM_SAVE_FIRMWARE)
 		pm_save_enable = coresight_loses_context_with_cpu(dev) ?
@@ -2302,10 +2303,6 @@ static int etm4_probe_platform_dev(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
-
 	if (res) {
 		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(drvdata->base))
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b044a4125310ba4f8c88df295ec3684ab266682f..02e0dc678a32c3b1f32fc955bf8871142e3412e1 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -217,6 +217,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	struct funnel_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
+	int ret;
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-funnel"))
@@ -230,13 +231,9 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
-
-	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
 	/*
 	 * Map the device base for dynamic-funnel, which has been
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 9e8bd36e7a9a2fd061f41c56242ac2b11549daf5..f1bbd12e63e0c130f945d8df34fb2334bd21336f 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -223,6 +223,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	void __iomem *base;
+	int ret;
 
 	if (is_of_node(dev_fwnode(dev)) &&
 	    of_device_is_compatible(dev->of_node, "arm,coresight-replicator"))
@@ -237,13 +238,9 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
-
-	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
 	/*
 	 * Map the device base for dynamic-replicator, which has been
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 275d67b91dfd58002918c3e0ec0be077467c601a..23ba33ac4d2ed8d63f1e0fb922e7f6e44de86cd1 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -842,13 +842,10 @@ static int __stm_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	base = devm_ioremap_resource(dev, res);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 519f225428070df5c5e6fcf014cd132058f01228..25c987e2d114881a4e4d8f6ed1791d183a64da5a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -779,9 +779,9 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	struct coresight_desc desc = { 0 };
 	struct coresight_dev_list *dev_list = NULL;
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
 	ret = -ENOMEM;
 
@@ -979,10 +979,6 @@ static int tmc_platform_probe(struct platform_device *pdev)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
-
 	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 8d6179c83e5d3194d1f90e10c88fcc1faccf0cd7..5e47d761e1c4e99072eeb492c1eac7dd4285a591 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -132,6 +132,7 @@ static int __tpiu_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	struct tpiu_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
+	int ret;
 
 	desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
 	if (!desc.name)
@@ -143,13 +144,10 @@ static int __tpiu_probe(struct device *dev, struct resource *res)
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
-	if (IS_ERR(drvdata->atclk))
-		return PTR_ERR(drvdata->atclk);
+	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
+	if (ret)
+		return ret;
 
-	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
-	if (IS_ERR(drvdata->pclk))
-		return PTR_ERR(drvdata->pclk);
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 4eada894c08293f36056483a8b5a038b26c387df..6de59ce8ef8ca45c29e2f09c1b979eb7686b685f 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -6,7 +6,6 @@
 #ifndef _LINUX_CORESIGHT_H
 #define _LINUX_CORESIGHT_H
 
-#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/device.h>
@@ -475,33 +474,6 @@ static inline bool is_coresight_device(void __iomem *base)
 	return cid == CORESIGHT_CID;
 }
 
-/*
- * Attempt to find and enable "APB clock" for the given device
- *
- * Returns:
- *
- * clk   - Clock is found and enabled
- * NULL  - Clock is controlled by firmware (ACPI device only) or when managed
- *	   by the AMBA bus driver instead
- * ERROR - Clock is found but failed to enable
- */
-static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
-{
-	struct clk *pclk = NULL;
-
-	/* Firmware controls clocks for an ACPI device. */
-	if (has_acpi_companion(dev))
-		return NULL;
-
-	if (!dev_is_amba(dev)) {
-		pclk = devm_clk_get_enabled(dev, "apb_pclk");
-		if (IS_ERR(pclk))
-			pclk = devm_clk_get_enabled(dev, "apb");
-	}
-
-	return pclk;
-}
-
 #define CORESIGHT_PIDRn(i)	(0xFE0 + ((i) * 4))
 
 static inline u32 coresight_get_pid(struct csdev_access *csa)
@@ -732,4 +704,6 @@ void coresight_remove_driver(struct amba_driver *amba_drv,
 			     struct platform_driver *pdev_drv);
 int coresight_etm_get_trace_id(struct coresight_device *csdev, enum cs_mode mode,
 			       struct coresight_device *sink);
+int coresight_get_enable_clocks(struct device *dev, struct clk **pclk,
+				struct clk **atclk);
 #endif		/* _LINUX_COREISGHT_H */

-- 
2.34.1


