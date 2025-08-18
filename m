Return-Path: <linux-kernel+bounces-773943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18309B2ACAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:26:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228DF206EEB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 15:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F100253F13;
	Mon, 18 Aug 2025 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kdpNrPMU"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B5F2566F7;
	Mon, 18 Aug 2025 15:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755530550; cv=fail; b=kPQ/87zhF/+YZ5lhhx+X2L4KbmdHzS2YoJG/XXS5u5DeLRdZsP2r2ZGDs8o4GbhNtrFRYLLzg1LZJkP0815oX3E0ERYyT10Ps/ztRSF6S2yDuVDBK2J8VR8UaUT0isrN8TBb0zo9kH/EAhRyfnK9P81RsSgTS/n8GrKHkliS2ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755530550; c=relaxed/simple;
	bh=UFxbLHs4Z9y0nwWs7DmiByDxOU1yyVeva1MaW7hG584=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VunyVfaTuiGb21W/Ik169nmXCab4ZK1Hl6xBiyhQ75OJLQ1vzAA1QLTylDtyUSVvopoQEQMwd7JKmrmpqqzgMeANJAGQLHxRaHqwLM2NrM5TcP5EmbC/bI59+QIj2G5AGKD92i4FJEUMA2QohScoq23ovnhPCQwiSXkeMw6jwhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kdpNrPMU; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R97i8ZjstY3C5XHBHrR2b3bXNNNJMzw1XFIUlooVOh/OQQsOA63av4cterwRdBpZv+vst5f8cMI4opP6OVK0lOSfkiFa4E6Dk11tPby/5nR19YiOFNDIlQdfHsK6Pbz1foV0axs3MO59fKf7cMEt4H75kHRuXtk1n0670OU+4Qw7Ck1sSH8pMBy8okiZK7Jh8sb2iedgG4ETDRWhVXmA/eBt71PaCLc+E2hiCn2Am5wH3DlTCivVl8a5idtkOilktiHSayFPNvdPp+7U+gVgLdwcbwY82dJlVFD9vC+rWhXf+YC+8yjPUEITaVRmxgUSi4cxBc0YY48FfCZ5KbTBMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O7tK8H8L6XM5JjjVqFEJ5GtU76Obv9piK06Huy5+sS4=;
 b=eiwIYRj7/Pf69LJsMjwnKScsLD6I+xYenkD/t7QtlYT/kPP7e7o5lnrHFAkWxqzCDC8smYCIOC2E5hvjh6ImFuoLLsXi3WeMf80hLDROpQInZbw8HnAqrMP/mtG8I3mRshpNfK3fXkSM1Sw4430xWdDJb3K37zY8MElRYYCDGirzYIS9HeMJSk0F3Wa8uzmSTq6GfI9XGuo2NW5wBWkfLm3iDo8cOL1o6rmSUBAyoi5xQVuEhkOzEWf9wimE+/G++UxOn6xEjQI19H8KrY/Sgr+uV5TLOlEx2lk3auHiXR/lJUd5jjga2Uq9vBGCHMU45MgS9kRlzmLt+CrdYyy2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7tK8H8L6XM5JjjVqFEJ5GtU76Obv9piK06Huy5+sS4=;
 b=kdpNrPMU2RnDlObs+gctORZF5dlVZJ03dIzS4Vi7jiFEEgv7EmSDltC2vO2j2J3blm+fpXiT8jOnsaIk4ihnaMVGO69JxHoQFeYJyxeTLFbt9tOOCNxfIjVZERY0Lmh2DM7TFD+3cIDXaW81tXbGUp/dMrLgaRVBe1cWtJvft9U=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 15:22:25 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:408:10b:cafe::f1) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 15:22:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 15:22:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 10:22:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 18 Aug
 2025 08:22:23 -0700
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 10:22:23 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <robh@kernel.org>, <lpieralisi@kernel.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2] of: dynamic: Fix memleak when of_pci_add_properties() failed
Date: Mon, 18 Aug 2025 08:22:21 -0700
Message-ID: <20250818152221.3685724-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c13fc09-4103-41b9-1649-08ddde6b08c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w6eGzBL9T1GP1BZLse/yFG9QCL/lxjz/CP1TK49PjhGP6WshiipLLDeSETKv?=
 =?us-ascii?Q?nF+pt9As5ATEwnxe/6/YrYGWgBgL2xpizSuWNSXOBII3adPAU+zw8zC48Scv?=
 =?us-ascii?Q?QZyaX7+Di8ypYbTfg0i5uy8z5mEp6bGq+bE2uNUr16+zU/pnaMgE5swISZMx?=
 =?us-ascii?Q?4lXiNHrnFnlZHVljiRNBu/gweUnXPuVWCgTDY3nQmyZeykSIRcayDfeKGTJN?=
 =?us-ascii?Q?XfQwJ3faH5dzf/tkBh+Mw6g8ck2btZvU9AQWgH1MKqTvaHJ/629GTsA+hc0k?=
 =?us-ascii?Q?JuNuDw8xU2dAJdFKSTa5xYJPsRtUJvFhDZ3L6htQRlypVkweB83b7g9VYoM0?=
 =?us-ascii?Q?T6SzbilR3fQv97OW+OmIh9wylmv7dozssoJGgIMz7vKuv+EnV3D7DxCeFAqn?=
 =?us-ascii?Q?GmSD1poHTQhXrb1e7mug8cOzCc8EMmY6EDD1ejoeRQj7UyukGZHtWrIvzn2j?=
 =?us-ascii?Q?TnW6RhSoZSF/mkHaPEjaIH/09Ji+qpZFCVMmA6SWE6X/Q3WTS1f1FmfXBsWA?=
 =?us-ascii?Q?gLicHMYrtQB+/8q7GFVWAsNsqzcUkt+d/HiqtqnqrZTqpXRnBJzMKzu34cvx?=
 =?us-ascii?Q?qx9JaNkosJX81peLTV9t2OhUNvpzciHYwCKUkhNENUbnp8uQ0QcRXojsuyoq?=
 =?us-ascii?Q?dyAKZCOCdHZGsq+LAXUwQ4gRNPtuNDg3kENR4CCT3F3s2aqmm2W2sWmVSE89?=
 =?us-ascii?Q?AQGBXczOVNAJuJO3Hk7ha4kTd+ychUF8XNGd2DDVihsbOQ3j5aKfGFZAmHCl?=
 =?us-ascii?Q?NXgvjZ+MbS77e9zGMUyOc42XC1nIbcf2Iw1BlD/O0g3gADtkGt23YCJxku4O?=
 =?us-ascii?Q?NRE58pmBK4SxoWS/iK4vBljXvV021Ig/Xy0XLTzs+4kPRMdGVTbvVC6nnhJz?=
 =?us-ascii?Q?x9+wZG0ypcsFAAzoMW2iF3xBuqMYQZRnG78U20INYsjXMW6ispDGf2QHEbb9?=
 =?us-ascii?Q?AQm3k14M1UaKkg6T+jUYEmC648SAu4Yr995aTpyPmogSpeoVdlSttuqk6BCq?=
 =?us-ascii?Q?uQPtU/wavi+Lk4550/HkvJ0mLP0SyD8tcLZ/QUkgtLx0zBpe29iIYT/mTcy4?=
 =?us-ascii?Q?1Eqitf/Z6WR/dyHb8HiPX4MpewsIxwvvoy/WKBzZlogY3dskHYB2Pqj+LlT2?=
 =?us-ascii?Q?iF7u2vJTT7DWvP0N1P+dKs1A5xbV/+4UzqRZNfdNs2dws79lkSbINIRHxz8J?=
 =?us-ascii?Q?zbXf3oTOLLzd4t9B+O2lsHMd/IO/xHyxgrwcRGFUl5KDrDG/lTE3xUogSDmT?=
 =?us-ascii?Q?7V9/+rDPqUHVc805nw74Npdopvf/196lKzqLMMdxtk7oX5aWNAjhyTzzLFhY?=
 =?us-ascii?Q?WcPUyNgTmGh9he0ym5rwO3IeavfexevVQQQykwE8pbYqjLbTOKDkWpVPd44E?=
 =?us-ascii?Q?SAfitFF2UXpFdH4CIeDoUPjnI+87kpRs2pPY/VD6Uf157Hpyg0YQdkEeza3u?=
 =?us-ascii?Q?xL4qpUhY2qtKh4BIw+CvodmYekAWKQg5lJe7tm3hMzaERfiPWo5Vrw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 15:22:24.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c13fc09-4103-41b9-1649-08ddde6b08c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780

When of_pci_add_properties() failed, of_changeset_destroy() is called to
free the changeset. And of_changeset_destroy() puts device tree node in
each entry but does not free property in the entry. This leads to memory
leak in the failure case.

In of_changeset_add_prop_helper(), add the property to the device tree node
deadprops list. Thus, the property will also be freed along with device
tree node.

Fixes: b544fc2b8606 ("of: dynamic: Add interfaces for creating device node dynamically")
Reported-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Closes: https://lore.kernel.org/all/aJms+YT8TnpzpCY8@lpieralisi/
Tested-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/of/dynamic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 0aba760f7577..dd30b7d8b5e4 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -938,6 +938,9 @@ static int of_changeset_add_prop_helper(struct of_changeset *ocs,
 	if (ret)
 		__of_prop_free(new_pp);
 
+	new_pp->next = np->deadprops;
+	np->deadprops = new_pp;
+
 	return ret;
 }
 
-- 
2.34.1


