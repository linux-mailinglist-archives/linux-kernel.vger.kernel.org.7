Return-Path: <linux-kernel+bounces-767543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4BB255BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98A7F7BF74D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85A32C3268;
	Wed, 13 Aug 2025 21:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hwprcvhE"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552203009E0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755121343; cv=none; b=cTcn+9UGTD74gS4LsX0mVbDSjtYVkgHVdTA6LGip7IXq82mfnNjf8/2u4REBAH63FSecXohE+7+lII19xags2l271OmkQ9PzwAqth1i5Gbn0dW0ML1roPwZIP0fDLClXf5txJC3CcdciCajMTB52EfiGaRAXIUUIbdfkaPUzSKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755121343; c=relaxed/simple;
	bh=04vQF2T5BemrVWufz+8AF4fnZqNK/1+h0ThSXgn3BW0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BrueYKQeSdXZ2s89eADqvZ7ZvV65nU4q7OOn57hwGv+FHDlbrZIPrldacuTlCKJBYOO/TPIlPZVfMUEKybGF5oU3GQuH3CVfL3qKn+EFnpet1YtVHOUcIVKZ4LF6bK0ejxu7R5Ow+MlM8AG3nth3yxZ+oNNsR8NkKStl9VVOiNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hwprcvhE; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DLfeK01788737;
	Wed, 13 Aug 2025 16:41:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755121301;
	bh=wWksHDBmgI3dIadKYWOJxAKOIZlW7syLhIJmTFxpaxA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=hwprcvhEofD7vETt+EIe1r/OT111emuuxsiAP1mZzCEyDtFBHXdfEa8rVgei90vYb
	 E3ZMoDDXI+YxhUJm9Zlh4m848bhKcfFM0svNuie7XtNwopBm8LpT2HBhqlcCT8TKCl
	 fMFRLZqkmMx+0yUXmcI3ZYpkjtYHUdgqVNB/yknY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DLfeTR678594
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 16:41:40 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 16:41:40 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 16:41:40 -0500
Received: from fllvem-mr07.itg.ti.com ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DLfdNG2611079;
	Wed, 13 Aug 2025 16:41:40 -0500
From: Andrew Davis <afd@ti.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, Vladimir Zapolskiy <vz@mleia.com>,
        Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>, Qin
 Jian <qinjian@cqplus1.com>
CC: <openbmc@lists.ozlabs.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 1/6] reset: ath79: Use devm_register_restart_handler()
Date: Wed, 13 Aug 2025 16:41:33 -0500
Message-ID: <20250813214138.477659-2-afd@ti.com>
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
 drivers/reset/reset-ath79.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/reset/reset-ath79.c b/drivers/reset/reset-ath79.c
index b5d620132052d..4c4e69eb32bbc 100644
--- a/drivers/reset/reset-ath79.c
+++ b/drivers/reset/reset-ath79.c
@@ -15,7 +15,6 @@
 
 struct ath79_reset {
 	struct reset_controller_dev rcdev;
-	struct notifier_block restart_nb;
 	void __iomem *base;
 	spinlock_t lock;
 };
@@ -72,11 +71,9 @@ static const struct reset_control_ops ath79_reset_ops = {
 	.status = ath79_reset_status,
 };
 
-static int ath79_reset_restart_handler(struct notifier_block *nb,
-				unsigned long action, void *data)
+static int ath79_reset_restart_handler(struct sys_off_data *data)
 {
-	struct ath79_reset *ath79_reset =
-		container_of(nb, struct ath79_reset, restart_nb);
+	struct ath79_reset *ath79_reset = data->cb_data;
 
 	ath79_reset_assert(&ath79_reset->rcdev, FULL_CHIP_RESET);
 
@@ -108,10 +105,7 @@ static int ath79_reset_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	ath79_reset->restart_nb.notifier_call = ath79_reset_restart_handler;
-	ath79_reset->restart_nb.priority = 128;
-
-	err = register_restart_handler(&ath79_reset->restart_nb);
+	err = devm_register_restart_handler(&pdev->dev, ath79_reset_restart_handler, ath79_reset);
 	if (err)
 		dev_warn(&pdev->dev, "Failed to register restart handler\n");
 
-- 
2.39.2


