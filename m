Return-Path: <linux-kernel+bounces-752088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCE7B1711F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E2BC18C4E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B7E02D190C;
	Thu, 31 Jul 2025 12:24:04 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C472D0C6E
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964643; cv=none; b=XHwrMEPfQmjHiSQlNjka5hRyRuY5Vvcw94drhF37/PbKoLtjZv0ub/is+NKrPsfyw/xlnqVdGq3GEY+aZmo/FIO54nPnfGtdnIlAelTUXZgcZ4Ho9t9WsDJVX7vv1k+wItfrJmXUqCRytL96sRxSyHX54ULNoy2eyg36A8NfeOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964643; c=relaxed/simple;
	bh=4mUqqfWFbeqBFqVX7/22IGMArPVRbN3M/cT4VUWhSHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xp0N44TOJhTjuRYI5lrXQzTEN5mWakto3HJpn3KtHXECT9zpRq8pSb6WZh84i5ZI/agw+4CrRlUjOdy05B/9CwCOzhGdAc1i3fYaBgAnVT1SRlRtgctzsT/YR/2YQWLPS7DHTT/uePjbYMnVBDVjERmYDkBTE+8NLZuLm66x8Jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCACD1D13;
	Thu, 31 Jul 2025 05:23:53 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4596E3F673;
	Thu, 31 Jul 2025 05:24:00 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 13:23:41 +0100
Subject: [PATCH v6 05/10] coresight: Appropriately disable trace bus clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_cs_fix_clock_v4-v6-5-1dfe10bb3f6f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753964630; l=9848;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=4mUqqfWFbeqBFqVX7/22IGMArPVRbN3M/cT4VUWhSHQ=;
 b=umiR4vdmBSz0KQ5qtnPw3k90NJqfNDgoo2OpZv6Ie0FtPJ7ccaKvBIYHwmeaT0qgRu/9loA6u
 EgRaoK6+Ra8Ayg7OfitS6bnj05eAdg4PSbrted4vYHIbwmKptqZcG2g
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
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
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
index f2de16e4d3b4cc0fc3fa06654fc7ddd9dee1e302..275d67b91dfd58002918c3e0ec0be077467c601a 100644
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


