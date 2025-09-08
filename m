Return-Path: <linux-kernel+bounces-805795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F57B48D8B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88B483B7566
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344A22A4E9;
	Mon,  8 Sep 2025 12:31:21 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECEF4690
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757334680; cv=none; b=YCucpV5X9ROFcFsd54cD0DbTFwDvxCwGt90nWB+fMbKeNiuhYqrHOrWhcG3TfRkMumbNnW+vjR/jaryTBL1CWYlFXsX6yyP5+xZUt/BzFctxMEinjOn/BSg/+JKZ7v3rEQrqDpfg1Kbtwe7/6ZNEt8Fee95HSenHXH2kG5LCmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757334680; c=relaxed/simple;
	bh=N6jSKhzkxWPsT2J2ylZEjvNaAtSeTJFjCtGmViSKnzc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MHhBRGkR0xd37Fc47sQt0FDpYRRKW9vlEk2+AtaZft++gWC69PUAOZ8MFY7Tw4yDSTmKp8gD8j+L7frmqlZTVgHPRh3LtVyjTxjxeHHO/4VriWjNWiuLI2wnqTlfCJ93XYEUTLDq6mYJnd4ZFqT8TDSUS4xn/Z3Rxp4jBg3nwEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cL5rW4b6TztTjG;
	Mon,  8 Sep 2025 20:30:19 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 21CE8140159;
	Mon,  8 Sep 2025 20:31:15 +0800 (CST)
Received: from kwepemq500007.china.huawei.com (7.202.195.21) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 20:31:14 +0800
Received: from huawei.com (10.67.174.117) by kwepemq500007.china.huawei.com
 (7.202.195.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Sep
 2025 20:31:14 +0800
From: Lin Yujun <linyujun809@h-partners.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
	<james.clark@linaro.org>, <alexander.shishkin@linux.intel.com>,
	<anshuman.khandual@arm.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] coresight: Fix incorrect handling for return value of devm_kzalloc
Date: Mon, 8 Sep 2025 20:20:22 +0800
Message-ID: <20250908122022.1315399-1-linyujun809@h-partners.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemq500007.china.huawei.com (7.202.195.21)

The return value of devm_kzalloc could be an null pointer,
use "!desc.pdata" to fix incorrect handling return value
of devm_kzalloc.

Fixes: 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
Signed-off-by: Lin Yujun <linyujun809@h-partners.com>
---
 drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8267dd1a2130..caf873adfc3a 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1277,11 +1277,11 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
 	 * ends up failing. Instead let's allocate a dummy zeroed
 	 * coresight_platform_data structure and assign that back
 	 * into the device for that purpose.
 	 */
 	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
-	if (IS_ERR(desc.pdata))
+	if (!desc.pdata)
 		goto cpu_clear;
 
 	desc.type = CORESIGHT_DEV_TYPE_SINK;
 	desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
 	desc.ops = &arm_trbe_cs_ops;
-- 
2.34.1


