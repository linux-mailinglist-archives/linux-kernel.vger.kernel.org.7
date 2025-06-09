Return-Path: <linux-kernel+bounces-678027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9FCAD2336
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 18:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D7E188CDFF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0021C9EA;
	Mon,  9 Jun 2025 16:01:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2221883C
	for <linux-kernel@vger.kernel.org>; Mon,  9 Jun 2025 16:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749484891; cv=none; b=sHnOkRhcY6To/IaA5miidsbhwBWIjVycROpcIJs70MA46sazsGaeZobY8TAhnV3LP1puQ387rFgdbWBW5YF1sVUvhUriBIoNKzkGuQM1VDo4Ek0yRzxAb8chPAAFVZVEd9SEUxdLWPg5/uhSIWWrqmFN2o+Yt+oXV5nKoye2Oas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749484891; c=relaxed/simple;
	bh=n87S/2oSxpnOkHLiSzhmE46RIApYY231MlBT/6pX/wo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dWPBVBcpDrzT2viBBlEQ4V6G+gwUzmuR26Dojx6gyYOw5onRDBmVNKNDKIeZIUmt6ekxX8iraHD7xEyVqUoUY8E4FvMmLeiJT/3X+8/Peb5QWbu3TfQTus+uO604l/87qMXXbQmcPCmItr+j+0TnxF16Aaa0nC4zYn78zIWadfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB54314BF;
	Mon,  9 Jun 2025 09:01:09 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50C5E3F673;
	Mon,  9 Jun 2025 09:01:27 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 09 Jun 2025 17:00:42 +0100
Subject: [PATCH v3 8/9] coresight: Make clock sequence consistent
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-arm_cs_fix_clock_v3_public-v3-8-423b3f1f241d@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749484873; l=3530;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=n87S/2oSxpnOkHLiSzhmE46RIApYY231MlBT/6pX/wo=;
 b=PDLu9GvClY1WLd4GrAMQoH1zoCBEKjV/pApuZbLAuhs0M5yQqUYcU/mN3ctrTe71SaDXw7iPd
 q1mBUskfxQUCq7r1wYDNnCGr5wNFLgGlnUFg7kEUN8T2c39Rph946Ni
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Since atclk is enabled after pclk during the probe phase, this commit
maintains the same sequence for the runtime resume flow.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
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
index a931282ec0eaf1b2a5db8ccc8f21789441cd634d..ed68d8280b1945f38d1294a5b5f557a614c90c94 100644
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


