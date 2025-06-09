Return-Path: <linux-kernel+bounces-678024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7F6AD2334
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 18:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB1303A519B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1A821B90B;
	Mon,  9 Jun 2025 16:01:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977E21ADAE
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 16:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484885; cv=none; b=B3YomO7K6k1jE8iXUwHzAx547nzokwpuMM7VYml26Po8cMTego5caaKETx72MPIUw87k8f3/e6vwaMt7PjN9Cj3m0nHeL5xnT0/TVlArhBs3LmmUtcCr3hk8JRDBcodgh++WEb3k6lXn/Azr9lmQ/Fcaz2LL+BdDxD6+JwtQg/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484885; c=relaxed/simple;
	bh=R8yXcLc5dSn9yMFhaxh3rhAjU3tKpIPpRldbC+BaQ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EQpKVTmLNWzrhOGubNxojqb7U6r8l5mNIPCwuG/yPIR1f0P4ATDrny4zb/CzmTmMmtS8cM27ZGqHebLwwhQm1RX0D9W6uv/izGqR5lTqpknK2n6Nclndywwk3ahXXeht8NffLqPOBkO5hUGIZve6vBuPYyOejRDdgfInVi6WyOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3A7314BF;
	Mon,  9 Jun 2025 09:01:04 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598E73F673;
	Mon,  9 Jun 2025 09:01:22 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 09 Jun 2025 17:00:39 +0100
Subject: [PATCH v3 5/9] coresight: Appropriately disable trace bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-arm_cs_fix_clock_v3_public-v3-5-423b3f1f241d@arm.com>
References: <20250609-arm_cs_fix_clock_v3_public-v3-0-423b3f1f241d@arm.com>
In-Reply-To: <20250609-arm_cs_fix_clock_v3_public-v3-0-423b3f1f241d@arm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749484873; l=9751;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=R8yXcLc5dSn9yMFhaxh3rhAjU3tKpIPpRldbC+BaQ3o=;
 b=9m3RET6acKqinNdrzYpbCGaqE5vekl0cr4gyGUy7S6yvD2pCIOE9dnJwdZ2FD4sysYoAMzlcQ
 oP4NRPyHKshD/wXC3GmpRLt0tI5AAHKF+P0zXFRqIn5EE0MyT/hH93j
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Some CoreSight components have trace bus clocks 'atclk' and are enabled
using clk_prepare_enable().  These clocks are not disabled when modules
exit.

As atclk is optional, use devm_clk_get_optional_enabled() to manage it.
The benefit is the driver model layer can automatically disable and
release clocks.

Check the returned value with IS_ERR() to detect errors but leave the
NULL pointer case if the clock is not found.  And remove the error
handling codes which are no longer needed.

Fixes: d1839e687773 ("coresight: etm: retrieve and handle atclk")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c      | 10 +++---
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  9 ++----
 drivers/hwtracing/coresight/coresight-funnel.c     | 36 +++++++---------------
 drivers/hwtracing/coresight/coresight-replicator.c | 34 ++++++--------------
 drivers/hwtracing/coresight/coresight-stm.c        |  9 ++----
 drivers/hwtracing/coresight/coresight-tpiu.c       | 10 ++----
 6 files changed, 34 insertions(+), 74 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d5efb085b30d36b51ca591c1b595ef82481f5569..8e81b41eb22264f17606050fa8da277aae05c5cc 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -730,12 +730,10 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
+
 	dev_set_drvdata(dev, drvdata);
 
 	/* validity for the resource is already checked by the AMBA core */
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 1c6204e1442211be6f3d7ca34bd2251ba796601b..baba2245b1dfb31f4bf19080e20c33df3a5b854f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -832,12 +832,9 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
 
 	drvdata->cpu = coresight_get_cpu(dev);
 	if (drvdata->cpu < 0)
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 36fc4e991458c112521c4261d73f3e58e9a3f995..b044a4125310ba4f8c88df295ec3684ab266682f 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -213,7 +213,6 @@ ATTRIBUTE_GROUPS(coresight_funnel);
 
 static int funnel_probe(struct device *dev, struct resource *res)
 {
-	int ret;
 	void __iomem *base;
 	struct coresight_platform_data *pdata = NULL;
 	struct funnel_drvdata *drvdata;
@@ -231,12 +230,9 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
@@ -248,10 +244,8 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	 */
 	if (res) {
 		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base)) {
-			ret = PTR_ERR(base);
-			goto out_disable_clk;
-		}
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 		drvdata->base = base;
 		desc.groups = coresight_funnel_groups;
 		desc.access = CSDEV_ACCESS_IOMEM(base);
@@ -261,10 +255,9 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	dev_set_drvdata(dev, drvdata);
 
 	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto out_disable_clk;
-	}
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
 	dev->platform_data = pdata;
 
 	raw_spin_lock_init(&drvdata->spinlock);
@@ -274,17 +267,10 @@ static int funnel_probe(struct device *dev, struct resource *res)
 	desc.pdata = pdata;
 	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto out_disable_clk;
-	}
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
 
-	ret = 0;
-
-out_disable_clk:
-	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
-		clk_disable_unprepare(drvdata->atclk);
-	return ret;
+	return 0;
 }
 
 static int funnel_remove(struct device *dev)
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 6dd24eb10a94b0eb28f4f27afab845227e22b96c..9e8bd36e7a9a2fd061f41c56242ac2b11549daf5 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -219,7 +219,6 @@ static const struct attribute_group *replicator_groups[] = {
 
 static int replicator_probe(struct device *dev, struct resource *res)
 {
-	int ret = 0;
 	struct coresight_platform_data *pdata = NULL;
 	struct replicator_drvdata *drvdata;
 	struct coresight_desc desc = { 0 };
@@ -238,12 +237,9 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
@@ -255,10 +251,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	 */
 	if (res) {
 		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base)) {
-			ret = PTR_ERR(base);
-			goto out_disable_clk;
-		}
+		if (IS_ERR(base))
+			return PTR_ERR(base);
 		drvdata->base = base;
 		desc.groups = replicator_groups;
 		desc.access = CSDEV_ACCESS_IOMEM(base);
@@ -272,10 +266,8 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	dev_set_drvdata(dev, drvdata);
 
 	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto out_disable_clk;
-	}
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
 	dev->platform_data = pdata;
 
 	raw_spin_lock_init(&drvdata->spinlock);
@@ -286,17 +278,11 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	desc.dev = dev;
 
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto out_disable_clk;
-	}
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
 
 	replicator_reset(drvdata);
-
-out_disable_clk:
-	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
-		clk_disable_unprepare(drvdata->atclk);
-	return ret;
+	return 0;
 }
 
 static int replicator_remove(struct device *dev)
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 88ee453b2815444a550a2b932b28367eb93336b8..57fbe3ad0fb20501d4e7e5c478d1e56e98685c40 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -842,12 +842,9 @@ static int __stm_probe(struct device *dev, struct resource *res)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2559c6fac6d2f02e0038e583cd324d7165c5aee..8d6179c83e5d3194d1f90e10c88fcc1faccf0cd7 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -128,7 +128,6 @@ static const struct coresight_ops tpiu_cs_ops = {
 
 static int __tpiu_probe(struct device *dev, struct resource *res)
 {
-	int ret;
 	void __iomem *base;
 	struct coresight_platform_data *pdata = NULL;
 	struct tpiu_drvdata *drvdata;
@@ -144,12 +143,9 @@ static int __tpiu_probe(struct device *dev, struct resource *res)
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
-	if (!IS_ERR(drvdata->atclk)) {
-		ret = clk_prepare_enable(drvdata->atclk);
-		if (ret)
-			return ret;
-	}
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
 
 	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
 	if (IS_ERR(drvdata->pclk))

-- 
2.34.1


