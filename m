Return-Path: <linux-kernel+bounces-767542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9980AB255BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A81017ED25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A197156F45;
	Wed, 13 Aug 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qQ9pX/BV"
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1187C3009DF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121342; cv=none; b=WUX41TpcDfseWJV5tnQ4oPl7GSUxWbIfh2gaPcNv5CDKpy6RktHFFp/sYaxQPRNNsdTT073cj1N5ymAbwrWjb9MAtYh6jGkcdxW5rjc7yIzS/dI7BwgYkxlEBcqhyW4PJQz4p1tbqUSWg+dehdsgtFf46y8ikGEQkgR4Sobipto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121342; c=relaxed/simple;
	bh=zo4J0NzTN639xTLHjSR63Ft6utoFtk9PsEm2/mVwkoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC7qEt1u51dqVWPOhSWkOAOvbeDlzSnZoWHGzlIRsbGrxBEKN747A/fraF0jdUZwtlRGJsc2Yb6opXpB6N/RkFLcAMD3TcVKdAr8vr8irUkQy9nQIkH46HloarnH9jNlRyMwXsIWK2t12DiYQ3a7dDYRFtHGTzbm8pd9rF9HB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qQ9pX/BV; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfgrP2238055;
	Wed, 13 Aug 2025 16:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121302;
	bh=N10erRoEBXTD6NQIqVCoyKFPIunTNnzn74wpSpfIUKs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qQ9pX/BVJfCp4RKnoYAUwMmgmWjPB6GtCU4fqgI2IfJ5hOq0hRoklLxUPRjM8Amn7
	 d3Lok2q4SfnGwM70ycFfAmmIZn07qv7nTVyxebkEJPIa9m3wcWaEgBYhabyNUEVZWa
	 BaLYMaTvsYVtmn46fF8vG/nzKYw1COtmxmwyZd4o=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLfgIg354028
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:42 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:41 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:41 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNJ2611079;
	Wed, 13 Aug 2025 16:41:41 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/6] reset: ma35d1: Use devm_register_sys_off_handler()
Date: Wed, 13 Aug 2025 16:41:36 -0500
Message-ID: <20250813214138.477659-5-afd@ti.com>
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
 drivers/reset/reset-ma35d1.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-ma35d1.c b/drivers/reset/reset-ma35d1.c
index 54e53863c98aa..4ee901f001326 100644
--- a/drivers/reset/reset-ma35d1.c
+++ b/drivers/reset/reset-ma35d1.c
@@ -19,7 +19,6 @@
 
 struct ma35d1_reset_data {
 	struct reset_controller_dev rcdev;
-	struct notifier_block restart_handler;
 	void __iomem *base;
 	/* protect registers against concurrent read-modify-write */
 	spinlock_t lock;
@@ -125,10 +124,9 @@ static const struct {
 	[MA35D1_RESET_SSPCC] =   {0x2C, 31}
 };
 
-static int ma35d1_restart_handler(struct notifier_block *this, unsigned long mode, void *cmd)
+static int ma35d1_restart_handler(struct sys_off_data *sys_off_data)
 {
-	struct ma35d1_reset_data *data =
-				 container_of(this, struct ma35d1_reset_data, restart_handler);
+	struct ma35d1_reset_data *data = sys_off_data->cb_data;
 	u32 id = MA35D1_RESET_CHIP;
 
 	writel_relaxed(BIT(ma35d1_reset_map[id].bit),
@@ -213,11 +211,10 @@ static int ma35d1_reset_probe(struct platform_device *pdev)
 	reset_data->rcdev.nr_resets = MA35D1_RESET_COUNT;
 	reset_data->rcdev.ops = &ma35d1_reset_ops;
 	reset_data->rcdev.of_node = dev->of_node;
-	reset_data->restart_handler.notifier_call = ma35d1_restart_handler;
-	reset_data->restart_handler.priority = 192;
 	spin_lock_init(&reset_data->lock);
 
-	err = register_restart_handler(&reset_data->restart_handler);
+	err = devm_register_sys_off_handler(dev, SYS_OFF_MODE_RESTART, 192,
+					    ma35d1_restart_handler, reset_data);
 	if (err)
 		dev_warn(&pdev->dev, "failed to register restart handler\n");
 
-- 
2.39.2


