Return-Path: <linux-kernel+bounces-744564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BAFB10E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C194AA60F5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDB62EB5DA;
	Thu, 24 Jul 2025 15:23:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0F22EA164
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370584; cv=none; b=p3S07JtnQ7+WREG/joTVPDvHdP+A1x7bthyEysZU+SITiOgp74nEI1qDpqGd5KVTFRnrps604JBt+tRtiPKp9XzfTP0DcZ0076eWgSvIx8vBCRetrDeHfXaX59daB96dB1pfmDjNa8dcGYVbbd5q9H0VEgEq2hGAIx6MEhHgBog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370584; c=relaxed/simple;
	bh=Bkyx16zAC/Zhi8k6mZ50LLP67jxDf1yRoCusQNuxLg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vo1fhfHtHqWiE5s/D9D2QqfgjKq7JfODzFQZAaC1COwz4iraxr4UNk/YF5J+1WM/umEBhyVlL8eNlpXc5nVJe+0u3e0Fcv45wklTNPJd3JYKF1s4TBVKb7X8OO/7PZFclJoA5gcxDOqyvykFEgi2JyE602XP49wv1V4Mv/BURT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D8E71A00;
	Thu, 24 Jul 2025 08:22:56 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E18053F6A8;
	Thu, 24 Jul 2025 08:23:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 24 Jul 2025 16:22:38 +0100
Subject: [PATCH v5 08/10] coresight: Refactor driver data allocation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-arm_cs_fix_clock_v4-v5-8-63f648dae021@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370566; l=6211;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=Bkyx16zAC/Zhi8k6mZ50LLP67jxDf1yRoCusQNuxLg8=;
 b=mqTeL3QrEwhkxBOQPleM2nVX79I3WyBT0KsuVi2K6LreWVw8o8S+JSbZTwC+0dduDkINfKmN/
 uBcOOW+BpXHDfiu95XCvWTj4PR7O7h0g27dbnmF8F+zdk4ss186mA3M
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The driver data no longer needs to be allocated separately in the static
and dynamic probes. Moved the allocation into the low-level functions to
avoid code duplication.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c      | 20 +++++++-------------
 drivers/hwtracing/coresight/coresight-cpu-debug.c | 21 +++++++--------------
 drivers/hwtracing/coresight/coresight-tmc-core.c  | 20 +++++++-------------
 3 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 0f476a0cbd740c233d039c5c411ca192681e2023..a3ccb7034ae14d7339bc2549bccadf11e28c45e2 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -515,11 +515,17 @@ static int __catu_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
 	u32 dma_mask;
-	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
+	struct catu_drvdata *drvdata;
 	struct coresight_desc catu_desc;
 	struct coresight_platform_data *pdata = NULL;
 	void __iomem *base;
 
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, drvdata);
+
 	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
 	if (ret)
 		return ret;
@@ -580,14 +586,8 @@ static int __catu_probe(struct device *dev, struct resource *res)
 
 static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct catu_drvdata *drvdata;
 	int ret;
 
-	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	amba_set_drvdata(adev, drvdata);
 	ret = __catu_probe(&adev->dev, &adev->res);
 	if (!ret)
 		pm_runtime_put(&adev->dev);
@@ -627,18 +627,12 @@ static struct amba_driver catu_driver = {
 static int catu_platform_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct catu_drvdata *drvdata;
 	int ret = 0;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	dev_set_drvdata(&pdev->dev, drvdata);
 	ret = __catu_probe(&pdev->dev, res);
 	pm_runtime_put(&pdev->dev);
 	if (ret)
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 5f6db2fb95d4623a0bab08828ae00442870abd7d..3edfb5d3d02056afcaab4da575d1101c68aeac80 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -562,10 +562,16 @@ static void debug_func_exit(void)
 
 static int __debug_probe(struct device *dev, struct resource *res)
 {
-	struct debug_drvdata *drvdata = dev_get_drvdata(dev);
+	struct debug_drvdata *drvdata;
 	void __iomem *base;
 	int ret;
 
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, drvdata);
+
 	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, NULL);
 	if (ret)
 		return ret;
@@ -629,13 +635,6 @@ static int __debug_probe(struct device *dev, struct resource *res)
 
 static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct debug_drvdata *drvdata;
-
-	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	amba_set_drvdata(adev, drvdata);
 	return __debug_probe(&adev->dev, &adev->res);
 }
 
@@ -694,14 +693,8 @@ static struct amba_driver debug_driver = {
 static int debug_platform_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct debug_drvdata *drvdata;
 	int ret = 0;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 25c987e2d114881a4e4d8f6ed1791d183a64da5a..36599c431be6203e871fdcb8de569cc6701c52bb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -775,10 +775,16 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	u32 devid;
 	void __iomem *base;
 	struct coresight_platform_data *pdata = NULL;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+	struct tmc_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
 	struct coresight_dev_list *dev_list = NULL;
 
+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, drvdata);
+
 	ret = coresight_get_enable_clocks(dev, &drvdata->pclk, &drvdata->atclk);
 	if (ret)
 		return ret;
@@ -888,14 +894,8 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct tmc_drvdata *drvdata;
 	int ret;
 
-	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	amba_set_drvdata(adev, drvdata);
 	ret = __tmc_probe(&adev->dev, &adev->res);
 	if (!ret)
 		pm_runtime_put(&adev->dev);
@@ -972,14 +972,8 @@ static struct amba_driver tmc_driver = {
 static int tmc_platform_probe(struct platform_device *pdev)
 {
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct tmc_drvdata *drvdata;
 	int ret = 0;
 
-	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
-	dev_set_drvdata(&pdev->dev, drvdata);
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);

-- 
2.34.1


