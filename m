Return-Path: <linux-kernel+bounces-744558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC120B10E87
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966EF1D005D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70B42EA72A;
	Thu, 24 Jul 2025 15:22:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994082EA154
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370574; cv=none; b=q3JE3tUstUI7oatAexwr+8NpLy84BOuN++rjvshijZ93w07AAqrvvHrMhQJeUZ1CkDj+iarRthmWUSoLMyxpDL4+duQuf/YORijUKviPF9WDbt5Rp1uHQmGHwrlI6WIlQEvpZYvzYeMknMI/AznvuyrTHNDR+91PuPPyMchWVz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370574; c=relaxed/simple;
	bh=HbeFTDQwjRbnEBUtsVNf7HfR8X+xeKmnS2yKVIywgF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbLWdHYVBiMT9Cu28ZPD53M1gKPs0qR1JMGCQh1b7fuYx0LWvp7xOk/+TEEoqZamdt4AECnTYrCs8CPASeQS/iWKdDAjaKfj+UjNEMnfIl1HyyK39wswbEYe28zQ1uVqQFuc2NsAnT04hzbWtkllogzRQ0mq52Cepdrrg2vHf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40D2E1A00;
	Thu, 24 Jul 2025 08:22:45 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F08F3F6A8;
	Thu, 24 Jul 2025 08:22:50 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 24 Jul 2025 16:22:32 +0100
Subject: [PATCH v5 02/10] coresight: catu: Support atclk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-arm_cs_fix_clock_v4-v5-2-63f648dae021@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370566; l=2757;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=HbeFTDQwjRbnEBUtsVNf7HfR8X+xeKmnS2yKVIywgF8=;
 b=9qyb/8tL3XPt0g8WG3h1OsdPmM72R7jBBYDQi3g9ztB5qxSg8NKpcwvJT6KLxMKqaIyfv/Uo7
 6yE8geyUdWDA6mdtZjY7rBPmAJV86SAX3HfY4WayljpBqIakvyMirXG
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

The atclk is an optional clock for the CoreSight CATU, but the driver
misses to initialize it.

This change enables atclk in probe of the CATU driver, and dynamically
control the clock during suspend and resume.

The checks for driver data and clocks in suspend and resume are not
needed, remove them.  Add error handling in the resume function.

Fixes: fcacb5c154ba ("coresight: Introduce support for Coresight Address Translation Unit")
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c | 22 +++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-catu.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 5058432233da1932f1965008fc1b98b560490414..af2a55f0c907c392d092a50612b23c115a1b0f5f 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -520,6 +520,10 @@ static int __catu_probe(struct device *dev, struct resource *res)
 	struct coresight_platform_data *pdata = NULL;
 	void __iomem *base;
 
+	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
+	if (IS_ERR(drvdata->atclk))
+		return PTR_ERR(drvdata->atclk);
+
 	catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
 	if (!catu_desc.name)
 		return -ENOMEM;
@@ -668,18 +672,26 @@ static int catu_runtime_suspend(struct device *dev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_disable_unprepare(drvdata->pclk);
+	clk_disable_unprepare(drvdata->atclk);
+	clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
 static int catu_runtime_resume(struct device *dev)
 {
 	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
+	int ret;
 
-	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
-		clk_prepare_enable(drvdata->pclk);
-	return 0;
+	ret = clk_prepare_enable(drvdata->pclk);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(drvdata->atclk);
+	if (ret)
+		clk_disable_unprepare(drvdata->pclk);
+
+	return ret;
 }
 #endif
 
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 755776cd19c5bb724845ca586ace1e0b29e72556..6e6b7aac206dcae9ff062355e50179637b4d1703 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -62,6 +62,7 @@
 
 struct catu_drvdata {
 	struct clk *pclk;
+	struct clk *atclk;
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;

-- 
2.34.1


