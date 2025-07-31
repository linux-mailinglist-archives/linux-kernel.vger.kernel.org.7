Return-Path: <linux-kernel+bounces-752092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B72B17126
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74D691AA42B2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F62A2D373A;
	Thu, 31 Jul 2025 12:24:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B349C2D29CD
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753964651; cv=none; b=Ud0QajEyjPJZMquAtLvdygaA6r3nHUsvuAF9HnfGjZU1dFc90WWt2bZU9GQ3Etc5tA22A5y7ZRq/vC0gzwSU4okWTfgnBJ3224Xj55PiTIdoB8mx/nDCOgACVDZQmx1Xi1FMCbK7r0971X/hnLT2oBHKmcowM27HA8s2cLoOf+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753964651; c=relaxed/simple;
	bh=hUNNDqo+LmdjplLN1Qs0GpR2ElWB0UTaFBEJRK7T2lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1OfwJwauCYU/uCo/ojjiwUWRsj/ikTrt8Eg07VRIYXR/sAO1b+wytbkiOy7UPlFux0eNOHCq44+TQce8YtlAYM5G5UkEYWN9tzps5q6tBO9Q7o3yy7r3DzMOjNKTghypFsR/fAqYayoEWP1j8mjNdIf05y6Dlg7JRVkciTlx3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 807CA1D13;
	Thu, 31 Jul 2025 05:24:01 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E083D3F673;
	Thu, 31 Jul 2025 05:24:07 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 31 Jul 2025 13:23:45 +0100
Subject: [PATCH v6 09/10] coresight: Make clock sequence consistent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-arm_cs_fix_clock_v4-v6-9-1dfe10bb3f6f@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753964630; l=3627;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=hUNNDqo+LmdjplLN1Qs0GpR2ElWB0UTaFBEJRK7T2lM=;
 b=cRxxCaOZZn020ZP3iHeKereoVlmsb5BdEtQ6D4oXFw7xIm1/dob3SZ2R3hErmcJ48LfBwH4on
 TptpQN6rRxmAKtGI+yycaOvCCenfoRgdhDl/mUwkUklPhfW5iE/YluB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since atclk is enabled after pclk during the probe phase, this commit
maintains the same sequence for the runtime resume flow.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 drivers/hwtracing/coresight/coresight-funnel.c     | 6 +++---
 drivers/hwtracing/coresight/coresight-replicator.c | 6 +++---
 drivers/hwtracing/coresight/coresight-stm.c        | 6 +++---
 drivers/hwtracing/coresight/coresight-tpiu.c       | 6 +++---
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 02e0dc678a32c3b1f32fc955bf8871142e3412e1..9dcfc5ce8845d9e01bb956dddab0d64de51ec397 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -297,11 +297,11 @@ static int funnel_runtime_resume(struct device *dev)
 {
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_prepare_enable(drvdata->atclk);
-
 	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
 		clk_prepare_enable(drvdata->pclk);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_prepare_enable(drvdata->atclk);
 	return 0;
 }
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index f1bbd12e63e0c130f945d8df34fb2334bd21336f..e53095603b0c0419bc96a66b23d15bb54e75e634 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -335,11 +335,11 @@ static int replicator_runtime_resume(struct device *dev)
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_prepare_enable(drvdata->atclk);
-
 	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
 		clk_prepare_enable(drvdata->pclk);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_prepare_enable(drvdata->atclk);
 	return 0;
 }
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 23ba33ac4d2ed8d63f1e0fb922e7f6e44de86cd1..7b1e289f17ab2000816d8641fe0a79759452d3b4 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -969,11 +969,11 @@ static int stm_runtime_resume(struct device *dev)
 {
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_prepare_enable(drvdata->atclk);
-
 	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
 		clk_prepare_enable(drvdata->pclk);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_prepare_enable(drvdata->atclk);
 	return 0;
 }
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 5e47d761e1c4e99072eeb492c1eac7dd4285a591..1c5c2a82971490888c45508c68b516ab7dbf3eeb 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -218,11 +218,11 @@ static int tpiu_runtime_resume(struct device *dev)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(dev);
 
-	if (drvdata && !IS_ERR(drvdata->atclk))
-		clk_prepare_enable(drvdata->atclk);
-
 	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
 		clk_prepare_enable(drvdata->pclk);
+
+	if (drvdata && !IS_ERR(drvdata->atclk))
+		clk_prepare_enable(drvdata->atclk);
 	return 0;
 }
 #endif

-- 
2.34.1


