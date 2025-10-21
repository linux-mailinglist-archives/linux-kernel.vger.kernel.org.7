Return-Path: <linux-kernel+bounces-862997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C456ABF6C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EAED5445D7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B25337100;
	Tue, 21 Oct 2025 13:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="o69PsxyM"
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685873370FA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053051; cv=none; b=PuynurO0QwQauhDFLKzH31bl+KyYDMa15h9GZ+o+rD5RRmlTBEgz//Jmjuqnv3c7HykQvuF9Nyak2Il0VPi4DmA+JeBef6xYCopTv4EW3O52GdWt7xuzm+RI1HHBYINIGYVSjgtTZOTAyLyzrvi6XbXCAK92KGd01DNL4Hjchts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053051; c=relaxed/simple;
	bh=mUOp3RkD0WvW0xPMXKW+Quu5MRzzr+VDwZB/d4rf2aY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BnzA8AzXFp2/KtHnALECp0JBIwX901vTtMLhYaivMqVyPRPdBPLpmnT+l0RebHUcrZPNrAoH5tYuuwrCFNp/GzTg554jPgzH+XkpalKYiNSZQNDHNqP3x1Lqer1aOGV79sFK7oxp2QHcMc8e9BhrwDVia1T3oS/s6bKwssCOtUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=o69PsxyM; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WOTiB39a6DgVGV93rhDR02QXQQuNzwOMoqALStC09kc=;
	b=o69PsxyMFVNNI0c0rgeWtIY25a/AsGE5e1asHhJbNco9UglotmM60McAv1yCVfut5jSaKhLmX
	umbI6K+Td2MdD7iQPJUPkJ3GRFVCl2iuXdzlesJtS0Kx+EHO9u/KeIdOFW1bwNmuVlDMRJXJbDz
	jupFM2/i1LzVkYMCz9AduSo=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4crY0C3GQCzKm5G;
	Tue, 21 Oct 2025 21:23:39 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BA23140155;
	Tue, 21 Oct 2025 21:24:03 +0800 (CST)
Received: from huawei.com (10.50.163.32) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 21 Oct
 2025 21:24:02 +0800
From: Jinqian Yang <yangjinqian1@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<maz@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<yuzenghui@huawei.com>
CC: <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
	<tangnianyao@huawei.com>, <wangwudi@hisilicon.com>, <liuyonglong@huawei.com>,
	<yangjinqian1@huawei.com>
Subject: [PATCH] irqchip/gicv3-its: Clear cache with VINVALL for erratum 162100801
Date: Tue, 21 Oct 2025 21:24:01 +0800
Message-ID: <20251021132401.3570140-1-yangjinqian1@huawei.com>
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
 dggpemf500013.china.huawei.com (7.185.36.188)

Use VINVALL to clear cache after VMOVP operation to avoid incomplete
cache cleanup. The previous implementation only cleared cache on one
ITS. This change sends VINVALL to every ITS to properly clear caches.

Fixes: f82e62d470cc ("irqchip/gicv3-its: Add workaround for hip09 ITS erratum 162100801")
Signed-off-by: Jinqian Yang <yangjinqian1@huawei.com>
---
 arch/arm64/Kconfig               |  2 +-
 drivers/irqchip/irq-gic-v3-its.c | 25 +++++++++++--------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6663ffd23f25..d4848a8396a9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1268,7 +1268,7 @@ config HISILICON_ERRATUM_162100801
 	help
 	  When enabling GICv4.1 in hip09, VMAPP will fail to clear some caches
 	  during unmapping operation, which will cause some vSGIs lost.
-	  To fix the issue, invalidate related vPE cache through GICR_INVALLR
+	  To fix the issue, invalidate related vPE cache through VINVALL
 	  after VMOVP.
 
 	  If unsure, say Y.
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 467cb78435a9..767ac171e440 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -66,7 +66,6 @@ static u32 lpi_id_bits;
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)
 
 static u8 __ro_after_init lpi_prop_prio;
-static struct its_node *find_4_1_its(void);
 
 /*
  * Collection structure - just an ID, and a redistributor address to
@@ -1405,6 +1404,14 @@ static void its_send_vmapp(struct its_node *its,
 	its_send_single_vcommand(its, its_build_vmapp_cmd, &desc);
 }
 
+static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_vinvall_cmd.vpe = vpe;
+	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
+}
+
 static void its_send_vmovp(struct its_vpe *vpe)
 {
 	struct its_cmd_desc desc = {};
@@ -1442,17 +1449,12 @@ static void its_send_vmovp(struct its_vpe *vpe)
 
 		desc.its_vmovp_cmd.col = &its->collections[col_id];
 		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
+		if (is_v4_1(its) && (its->flags &
+			    ITS_FLAGS_WORKAROUND_HISILICON_162100801))
+			its_send_vinvall(its, vpe);
 	}
 }
 
-static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
-{
-	struct its_cmd_desc desc;
-
-	desc.its_vinvall_cmd.vpe = vpe;
-	its_send_single_vcommand(its, its_build_vinvall_cmd, &desc);
-}
-
 static void its_send_vinv(struct its_device *dev, u32 event_id)
 {
 	struct its_cmd_desc desc;
@@ -3910,7 +3912,6 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	unsigned int from, cpu = nr_cpu_ids;
 	struct cpumask *table_mask;
-	struct its_node *its;
 	unsigned long flags;
 
 	/*
@@ -3974,10 +3975,6 @@ static int its_vpe_set_affinity(struct irq_data *d,
 
 	its_send_vmovp(vpe);
 
-	its = find_4_1_its();
-	if (its && its->flags & ITS_FLAGS_WORKAROUND_HISILICON_162100801)
-		its_vpe_4_1_invall_locked(cpu, vpe);
-
 	its_vpe_db_proxy_move(vpe, from, cpu);
 
 out:
-- 
2.33.0


