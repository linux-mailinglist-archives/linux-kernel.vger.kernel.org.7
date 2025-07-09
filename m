Return-Path: <linux-kernel+bounces-723652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F70FAFE988
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CE4E6F1A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6743A28ECDA;
	Wed,  9 Jul 2025 13:01:14 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381323DE
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752066074; cv=none; b=up5mwShf56Zjh1zpccVfva2EfHo7799DSQ3M+Sw1KU6DxIcehIROLQk+ToE6x3lfERUUccT1qaFZgAIedW9kGAU7S/oHJtDpDSxWs7CQBJq86K783XszNv7VCpC5sZIphc/dp8tXI60mYvxec/iYpH2fnbW8yCqRHi1N+nMvskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752066074; c=relaxed/simple;
	bh=mrK3bJTpnSUZkTcCs+5wqdvPrJ1AdzjufH0kI1+8q18=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iw4HqNca+LjStW4Os8LJeQzr3bw2PCUXwezwhR96vt2LYZG++0Su6f4lCkc5pXwHNOST9UknF8Mrp9IWcxM+TnO50jv/S3wB0IrfL9ENivDkUXZfdIMKDImsuMcTK0vBkA1tEqs5qZqEuBaj29TKutBdjyH2eHEEJUcBg+gM6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bcdMv2ktmz2FbNY;
	Wed,  9 Jul 2025 20:59:07 +0800 (CST)
Received: from kwepemk200017.china.huawei.com (unknown [7.202.194.83])
	by mail.maildlp.com (Postfix) with ESMTPS id 62EC0180044;
	Wed,  9 Jul 2025 21:01:02 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 kwepemk200017.china.huawei.com (7.202.194.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 21:01:01 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <maz@kernel.org>, <tglx@linutronix.de>, <wanghaibin.wang@huawei.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3: Fix GICD_CTLR register naming
Date: Wed, 9 Jul 2025 21:00:46 +0800
Message-ID: <20250709130046.1354-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk200017.china.huawei.com (7.202.194.83)

It was incorrectly named as GICD_CTRL in a pr_info() and comments. Fix
them.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index efc791c43d44..dbeb85677b08 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -190,12 +190,12 @@ static void __init gic_prio_init(void)
 
 	/*
 	 * How priority values are used by the GIC depends on two things:
-	 * the security state of the GIC (controlled by the GICD_CTRL.DS bit)
+	 * the security state of the GIC (controlled by the GICD_CTLR.DS bit)
 	 * and if Group 0 interrupts can be delivered to Linux in the non-secure
 	 * world as FIQs (controlled by the SCR_EL3.FIQ bit). These affect the
 	 * way priorities are presented in ICC_PMR_EL1 and in the distributor:
 	 *
-	 * GICD_CTRL.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
+	 * GICD_CTLR.DS | SCR_EL3.FIQ | ICC_PMR_EL1 | Distributor
 	 * -------------------------------------------------------
 	 *      1       |      -      |  unchanged  |  unchanged
 	 * -------------------------------------------------------
@@ -223,7 +223,7 @@ static void __init gic_prio_init(void)
 		dist_prio_nmi = __gicv3_prio_to_ns(dist_prio_nmi);
 	}
 
-	pr_info("GICD_CTRL.DS=%d, SCR_EL3.FIQ=%d\n",
+	pr_info("GICD_CTLR.DS=%d, SCR_EL3.FIQ=%d\n",
 		cpus_have_security_disabled,
 		!cpus_have_group0);
 }
-- 
2.33.0


