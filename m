Return-Path: <linux-kernel+bounces-781128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D42AB30DC9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B2CAC3DCF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1273128CF47;
	Fri, 22 Aug 2025 04:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jToURF2R"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B087428AAE0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838673; cv=fail; b=esaBUs3VatD3ik4Tqdq7kKPtYguDEUwbNWGRwC7n3Uv1O+fvexNnX4D7TuFLdl/nzEMBgt/MYr2dHx2qo6x2RragGiij9kobT9+kCX/fKA6lEgWCob57ytyftbc1OtO6n81XRVJsLAX76FmXxCOLf7dMUpoByKVZ7HumZMxbJZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838673; c=relaxed/simple;
	bh=jDtJlaQjWhcfMDzc6q6XM2g5Xiy9MiR/zBs6fMgaxtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HnRUkQBMZOmJSt0wooKFqOQ0wFPql3VSwfpCsHvYnWIuFHCP0BZ6pXnXuGTfV+4N+o+YBWaSmdexw0Gql16A2yarohAZPF0LPYRxnSGUcESF1pYx8jhNLKNKhA+All+IZtrnztFDo5xIkhDnDxQB9PX+ZylhzfjIuqf4lxttVG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jToURF2R; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTtNgFWNioQZ4BkPK9AMCcXXrJ+oE4Fwt38/SuJEk3b/BFctVQAYyM26pRHBcvEKpxfkIvyQhmjXYplpmOobiy+/hXvSDs3sp26xpj7Ej0D1k6eAPQZxnS0EfpA1pkcZTBW+2AJjiH9XaVuelE6qjuVvGY65dV7qf/CJoQQA6Hf5TIdQunyumHtcNdYjxRIIh+jvINvopP106er6jf8GFoj9HGEreX3/4PAJSkhVxH26lAkfjHLGEj9kzUbg4cyeubFemUJopdtDQrF87wS27sSI3/3WNZCv3rSa0KDZYqu77DDusT+KyxOQNJLLkmO8rc3BH3Yer0qy967RTGYOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smZHk8Q6+cufMsb7LhWHrXVuTNlQxFO7r0wPjDymL2A=;
 b=IJYisd1Xe4WHdSnEa1xESw2IHZFqzNHL80eGykwT42JhKoMDcZVk5uoCGfIlGT6zU+cm97xUuTgdxE1SYYByyGcAtqahH5cxO+1JO+LtkNDehLuxZ4A6UAZLBNLAJoFowYohEId6wdtV8FwASEtHv0SUTiGXPjZFYE4fOtljhaTdCrwB8S9SmnlNa6OXOZGNoJM3QUeoFJU1uUtTG5FzaYSoYuLrIKJ90awH2ySbBEYN6TW+ww7mYALGu7Q9WXVocWsWMbrmX4kjHzQcIVqJ3sKbWwCiMBReAfpUmpKyiFS9wKeelIqyD+XNViMptFXb3lA5o8elU00/tb6GwWTrxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smZHk8Q6+cufMsb7LhWHrXVuTNlQxFO7r0wPjDymL2A=;
 b=jToURF2RfAVoT93kAPzbYs9BOFBhkdt//ZovaGJ4xTooG+UaxU2+WDeoeZx7457seI7m5iN4SWZJ1UWAjsiSvH4IurlGsgE8BD+Le/GIDUSLL6MN/WN2nLbCGr/ldknam+Mv1kDJmnyZN9urQIn91/AU49vXM5FEbKjweytq5VE=
Received: from BN8PR16CA0014.namprd16.prod.outlook.com (2603:10b6:408:4c::27)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.16; Fri, 22 Aug
 2025 04:57:46 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:4c:cafe::b7) by BN8PR16CA0014.outlook.office365.com
 (2603:10b6:408:4c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Fri,
 22 Aug 2025 04:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 04:57:45 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 23:57:44 -0500
Received: from xhdharinit40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 23:57:42 -0500
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 3/3] mailbox: zynqmp-ipi: Fix SGI cleanup on unbind
Date: Fri, 22 Aug 2025 10:27:32 +0530
Message-ID: <20250822045732.1068103-4-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822045732.1068103-1-harini.t@amd.com>
References: <20250822045732.1068103-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: cbf742d7-ac10-4e47-99a6-08dde1386f50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?z7YmdQyXrorpNjvdTJj9vM6xXTt6d2oX6JfjCyFvtStbHR9KamD6LCaWebMx?=
 =?us-ascii?Q?8TU8WX9dgymvKLfDoy10c6+QV6cuSMzNrAy2aOr3pRaFDGEVKCxDbwuyIIXO?=
 =?us-ascii?Q?DkTg+jWd4ZDqdRbet/6TQ3F7239zBySHjJNqzu4Q43fSOfubvv/GGYI3d53j?=
 =?us-ascii?Q?6kDwN5EjNhUcyfl+vqRJ0mufRHsyHJ0DTRXdbg3XoXC9XuC7Q/Uc+zZCCyoL?=
 =?us-ascii?Q?elN0NfsjHXNuAGlGhU5JXi/FSCW95J18UjURYdAxT/juaUWwNSc2Z029P//Q?=
 =?us-ascii?Q?Tu59RXF9/7A905iUprQuCehxC79LBBhNnV8hWuWNMrtOjYF5JlSAHI9YC4wY?=
 =?us-ascii?Q?A2t3jviQAi9n7zZmgcXwF6yK6pEpQ1eKFS6g4DbOFTri0reKljb3Z2i9nTzx?=
 =?us-ascii?Q?7WTO3k4Ohe3W8dpB8tA04TRNxvK7XsPxHJhdwFMX688E5hRsE2AyzTgNtqU/?=
 =?us-ascii?Q?7qVJFO28CE0JeswBYzrBQCPkxU08rXV6ju9QJZ1+cBi+NgNY69D32aCo9lTg?=
 =?us-ascii?Q?QNfVQBdHkZYxNdKOLHC+JjTtsDJv6geIDdsgwxnYCl0UoZ5Tg3JPwj5M56Xd?=
 =?us-ascii?Q?ld8KI4thSdNw6d81gHDpyNDAQXPttuhg++cFBiDm9OVVSDIci6TVWMSut64w?=
 =?us-ascii?Q?3MnJ/N8T8qps3Scd3GEKz6kcv+as8YemyC2y3o3yXNFx+C14HG/AV1cYtUWj?=
 =?us-ascii?Q?GiOU9vh3+ppZIYYrUW7/9QM+RZHmKGUVvSz1Vj7vYouIqH0dX0WeG8/uEmra?=
 =?us-ascii?Q?iDLTDT/gkBHs+AFAahz7+Ndk7eltJf9domG00MdxsLjr22/ZssVutAxKZo1a?=
 =?us-ascii?Q?NETorNUoOL2Y1bkupsYxn5e4iYyia997Mn2S1lomVIN8NMlBiIU2PvHnpXJC?=
 =?us-ascii?Q?CklE/rFjwnUHsNHW4UpjjXt1LCEOr90U0wdQzjAllCSlUsS5OM1ihFEsijwC?=
 =?us-ascii?Q?Lzb0zNWB6QcMD0VZBc33Wcn4Nprbgd1ZaBOKN3ZcaSaZTLhoRWnqXWJBuEip?=
 =?us-ascii?Q?suxahJODuIy+JMIdeGTWIFG6CWqsAejvvrtvAViDYF8E1VzBs4y/dWteg/XY?=
 =?us-ascii?Q?dpvPXeilW+YCoP/bPHcLhnDk5HOnVd8LR21Qfb8Pk7pgRELy8WeTwyWSmeG8?=
 =?us-ascii?Q?uXfcWSPwH7zS/FuNK4758pv7ldgwVIOF+NDTPoSJBCiLlIzCjfkORMBWjJc/?=
 =?us-ascii?Q?WAAOH53DrIx9o4OoSOQsPoI9nriaUUJxSp8irHLYNc+xIPE9vD6HnmEH6kNJ?=
 =?us-ascii?Q?mQ0ft20Hp/YVzodVNKyjN139nqCBNGh3o0RtJCMS7yDCtOvMx2xiGZ318l6d?=
 =?us-ascii?Q?haJ4hPcSotdvj9FGkOPPUTW3sFwa8j0JMzJXmnoetjZ8UkQPi6aGNS+XJJr+?=
 =?us-ascii?Q?QG0EOzu24wB3pN6NFU98u7P6tnEwekclh+XSfW+3+Q9RpEtu46lqxd+0UqH6?=
 =?us-ascii?Q?hMdq4WTYliyLLHzKyH0L7895mUTn78QBKuyWi+KI9TgEZkz8IGy6w4ZXeEnp?=
 =?us-ascii?Q?aS+OQ9bdMKRS6dM5KGkkeAEJSuCkbbjRjzeh?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:57:45.8031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf742d7-ac10-4e47-99a6-08dde1386f50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094

The driver incorrectly determines SGI vs SPI interrupts by checking IRQ
number < 16, which fails with dynamic IRQ allocation. During unbind,
this causes improper SGI cleanup leading to kernel crash.

Add explicit irq_type field to pdata for reliable identification of SGI
interrupts (type-2) and only clean up SGI resources when appropriate.

Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 3b806d1f89bb..1af758a406e2 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -62,7 +62,8 @@
 #define DST_BIT_POS	9U
 #define SRC_BITMASK	GENMASK(11, 8)
 
-#define MAX_SGI 16
+/* Macro to represent SGI type for IPI IRQs */
+#define IPI_IRQ_TYPE_SGI	2
 
 /*
  * Module parameters
@@ -121,6 +122,7 @@ struct zynqmp_ipi_mbox {
  * @dev:                  device pointer corresponding to the Xilinx ZynqMP
  *                        IPI agent
  * @irq:                  IPI agent interrupt ID
+ * @irq_type:             IPI SGI or SPI IRQ type
  * @method:               IPI SMC or HVC is going to be used
  * @local_id:             local IPI agent ID
  * @virq_sgi:             IRQ number mapped to SGI
@@ -130,6 +132,7 @@ struct zynqmp_ipi_mbox {
 struct zynqmp_ipi_pdata {
 	struct device *dev;
 	int irq;
+	unsigned int irq_type;
 	unsigned int method;
 	u32 local_id;
 	int virq_sgi;
@@ -887,7 +890,7 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	struct zynqmp_ipi_mbox *ipi_mbox;
 	int i;
 
-	if (pdata->irq < MAX_SGI)
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI)
 		xlnx_mbox_cleanup_sgi(pdata);
 
 	i = pdata->num_mboxes;
@@ -956,14 +959,16 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 		dev_err(dev, "failed to parse interrupts\n");
 		goto free_mbox_dev;
 	}
-	ret = out_irq.args[1];
+
+	/* Use interrupt type to distinguish SGI and SPI interrupts */
+	pdata->irq_type = out_irq.args[0];
 
 	/*
 	 * If Interrupt number is in SGI range, then request SGI else request
 	 * IPI system IRQ.
 	 */
-	if (ret < MAX_SGI) {
-		pdata->irq = ret;
+	if (pdata->irq_type == IPI_IRQ_TYPE_SGI) {
+		pdata->irq = out_irq.args[1];
 		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
 		if (ret)
 			goto free_mbox_dev;
-- 
2.43.0


