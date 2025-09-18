Return-Path: <linux-kernel+bounces-822993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FFCB853E7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E3631CC1AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20F23770D;
	Thu, 18 Sep 2025 14:23:37 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF211EEA49
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205416; cv=none; b=KouwgKUiyKKPvT3VCP2Sv9XPvPAZrCV9ZEAmCGXyaeWZZQpXtP36QXAHPZgFiUtRKD3PI4rtRGKE6riKcEoG/p5F7ha8bqLoyIUFCIjIG68Va7F2JFEvWiZFHCDEmdUogcXQJyZ8YLCW1DZQuSDQJNWb42BOhS8JHLxn1fMgw68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205416; c=relaxed/simple;
	bh=wJSRhr9/Fy0FT5SUoEtOfGxsBakvPzZRpSRC+SjxwlU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=terjKKVESv83BwfFRZ6QSvOu3D7tjCVqspbdTElNwUYBZyAtQLgqp+HIAYm7QwPFEfmlgu82JSOwXKaHP1qd1lypR/5np8+CBMfc0HhMtNBBiFBD5/zM5LDvZsE00g0kD8OoQCEtImGlOMDsm0lNAQb1QJsMack+3lFcaUiRkIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cSHnC0d66zdcjB;
	Thu, 18 Sep 2025 22:18:55 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 40808180B57;
	Thu, 18 Sep 2025 22:23:31 +0800 (CST)
Received: from kwepemq500001.china.huawei.com (7.202.195.224) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 22:23:31 +0800
Received: from ceph1.huawei.com (10.67.144.45) by
 kwepemq500001.china.huawei.com (7.202.195.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Sep 2025 22:23:30 +0800
From: Nianyao Tang <tangnianyao@huawei.com>
To: <maz@kernel.org>, <tglx@linutronix.de>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <guoyang2@huawei.com>, <wangwudi@hisilicon.com>, <tangnianyao@huawei.com>,
	<wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
	<guozicheng3@hisilicon.com>
Subject: [PATCH V2] irqchip/gic-v4.1:Check whether indirect table is supported in allocate_vpe_l1_table
Date: Thu, 18 Sep 2025 22:15:57 +0800
Message-ID: <20250918141557.1791041-1-tangnianyao@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq500001.china.huawei.com (7.202.195.224)

In allocate_vpe_l1_table, it allocates a new vpe table without checking
whether indirect table is supported.
ARM allows vendors to support only flat tables. Let's first check if
indirect tables are supported before using it.

Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 467cb78435a9..a4d719720e61 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2903,6 +2903,7 @@ static int allocate_vpe_l1_table(void)
 	unsigned int psz = SZ_64K;
 	unsigned int np, epp, esz;
 	struct page *page;
+	bool indirect;
 
 	if (!gic_rdists->has_rvpeid)
 		return 0;
@@ -2937,10 +2938,12 @@ static int allocate_vpe_l1_table(void)
 
 	/* First probe the page size */
 	val = FIELD_PREP(GICR_VPROPBASER_4_1_PAGE_SIZE, GIC_PAGE_SIZE_64K);
+	val |= GICR_VPROPBASER_4_1_INDIRECT;
 	gicr_write_vpropbaser(val, vlpi_base + GICR_VPROPBASER);
 	val = gicr_read_vpropbaser(vlpi_base + GICR_VPROPBASER);
 	gpsz = FIELD_GET(GICR_VPROPBASER_4_1_PAGE_SIZE, val);
 	esz = FIELD_GET(GICR_VPROPBASER_4_1_ENTRY_SIZE, val);
+	indirect = !!(val & GICR_VPROPBASER_4_1_INDIRECT);
 
 	switch (gpsz) {
 	default:
@@ -2973,7 +2976,7 @@ static int allocate_vpe_l1_table(void)
 	 * If we need more than just a single L1 page, flag the table
 	 * as indirect and compute the number of required L1 pages.
 	 */
-	if (epp < ITS_MAX_VPEID) {
+	if (epp < ITS_MAX_VPEID && indirect) {
 		int nl2;
 
 		val |= GICR_VPROPBASER_4_1_INDIRECT;
@@ -2984,7 +2987,8 @@ static int allocate_vpe_l1_table(void)
 		/* Number of L1 pages to point to the L2 pages */
 		npg = DIV_ROUND_UP(nl2 * SZ_8, psz);
 	} else {
-		npg = 1;
+		npg = DIV_ROUND_UP(ITS_MAX_VPEID, epp);
+		npg = clamp_val(npg, 1, (GICR_VPROPBASER_4_1_SIZE + 1));
 	}
 
 	val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, npg - 1);
-- 
2.33.0


