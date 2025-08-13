Return-Path: <linux-kernel+bounces-767545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1F7B255C8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:45:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD7F3AC9AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D542D2F39C1;
	Wed, 13 Aug 2025 21:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k2jaOzW0"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4F23009DA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121344; cv=none; b=uijo5rMNt5bihHjFsHgy9oaJoXYUBfIwTrdAzj90mty5NtvR1s5P/YtB+owUSYchCCn1eT9bzw9fy4iWnV7gKqVhGDB9ojp8WESwamj1P9uV1DmdwBwbzkYVAljcPizCiuNh+4Hf9VWLnC9DSp/Ye4xUD1wTuEhofzNPDz6Cl3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121344; c=relaxed/simple;
	bh=5V5q6i8kQZ70RmiyZmzuP0NApwNlyogBepTslWv6mVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laa2DGbdftQv7/DIKwNo7gAityAeGsZKQ+3w9X6Z6Y6NS4+j+p+OMRWwNbtx9X2YeqYndOnkxo3e/HMO2jYlgup7a8IdxMdMrUhTE2HAGfeSmvBEpXa7H+oCa+j5CkxCgydhQcGiNo1YHTGBNvQtyUs0sAiFUrZqQrPDoc6jS0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k2jaOzW0; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfgZ81737106;
	Wed, 13 Aug 2025 16:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121302;
	bh=ZQcBjCnOuHYG+l1tmZJq0ANml4aVyybZgww+09zyHFo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=k2jaOzW0eX1Q9Lh1Jg+5ql5U2GDt6e1QDt+kaPPCTFvdR2o1jyNv9UVaqVKwWQmXQ
	 JGyZJOUhqG10nwoarENrF8+Nzk50CZ6WxRHAAyRinTmsaJv90JgCJJ2X/Phfv/Uw6B
	 4Teq74wPC4KX2n3lIDF8cWQAIOQCHTgr4YrUsr4s=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLfgum1253263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:42 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:42 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNL2611079;
	Wed, 13 Aug 2025 16:41:41 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 6/6] reset: sunplus: Use devm_register_sys_off_handler()
Date: Wed, 13 Aug 2025 16:41:38 -0500
Message-ID: <20250813214138.477659-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250813214138.477659-1-afd@ti.com>
References: <20250813214138.477659-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Function register_restart_handler() is deprecated. Using this new API
removes our need to keep and manage a struct notifier_block and to
later unregister the handler.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/reset/reset-sunplus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/reset/reset-sunplus.c b/drivers/reset/reset-sunplus.c
index df58decab64da..58b0874337598 100644
--- a/drivers/reset/reset-sunplus.c
+++ b/drivers/reset/reset-sunplus.c
@@ -100,7 +100,6 @@ static const u32 sp_resets[] = {
 
 struct sp_reset {
 	struct reset_controller_dev rcdev;
-	struct notifier_block notifier;
 	void __iomem *base;
 };
 
@@ -154,10 +153,9 @@ static const struct reset_control_ops sp_reset_ops = {
 	.status   = sp_reset_status,
 };
 
-static int sp_restart(struct notifier_block *nb, unsigned long mode,
-		      void *cmd)
+static int sp_restart(struct sys_off_data *data)
 {
-	struct sp_reset *reset = container_of(nb, struct sp_reset, notifier);
+	struct sp_reset *reset = data->cb_data;
 
 	sp_reset_assert(&reset->rcdev, 0);
 	sp_reset_deassert(&reset->rcdev, 0);
@@ -189,10 +187,8 @@ static int sp_reset_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	reset->notifier.notifier_call = sp_restart;
-	reset->notifier.priority = 192;
-
-	return register_restart_handler(&reset->notifier);
+	return devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+					     192, sp_restart, reset);
 }
 
 static const struct of_device_id sp_reset_dt_ids[] = {
-- 
2.39.2


