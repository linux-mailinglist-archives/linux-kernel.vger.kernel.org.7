Return-Path: <linux-kernel+bounces-666513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DABD8AC77BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 07:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8228A1C00135
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 05:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A3253B47;
	Thu, 29 May 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n+qukhYa"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2067.outbound.protection.outlook.com [40.107.101.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C621531E3;
	Thu, 29 May 2025 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748497139; cv=fail; b=aXkm/bSV3sGEEeOakXeBpn1thxyipysdzVtLxzn23fFAUBqqjUgSk/wtM+/cNviqa4kUwflIY6nBKdPlYnmdx/E8j9Q/lqNa+vwSNy0KZc4czg27CCd4UjZv0xPM/P+ZJz0N2Y7NoWBKhzn9rIfyf3lMGE1u50cQhqdCY57M9Tc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748497139; c=relaxed/simple;
	bh=2DEMDZYam94fDoI+TdFwPaCYRr9y2EswJN5rNPtI9ws=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLNoBhGMIvKuyY9mLRV2chy6gOjyIaeYLTflCzo0WARWopSE9QC0axBp0TfPyfjYhaHr+/MvPqOG/fl1xzQt1gOgrN2QGM25pkDmuuy53YCZwnc3hwZ9GpVJtcRTH/Fmsix+6FdF7OlTp6FZFbwU8lAypgtDa1sDF0plDKs04ME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n+qukhYa; arc=fail smtp.client-ip=40.107.101.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k85f4zvhunXT/C7gwSovlxSj/eoIan/a5JffWOGeNVnzWdUrn7VUTlJjkdtA6ITDre9LLeZuDboI61bEuxmadWAse/ztXiHQAB0yg1EKQLtbPjMGRv8bHLbnAFw9CmZzOVERQmvbBJNgOeh73+gg4gvFF4E5m1UrDjsklfZnA6xAIZDO2ZybhI468CccgPA5EAZFU6FuWTeyFsPZgmynsVGpO5PHfZgek29uZSracObaAGSW2txxcateqRczEXF9lrU2iDS5yk1pDOa1ZtVt097tcQAphOPHjWM4UWrVYgNilYihsO5FGiLmpZMSLilX5OzYWeixa24RZBw5c3siKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1sL23ptZHWrCRDLxrSmrL4AUZquEt3WYs+m/mJF6H0Y=;
 b=yw85ebd9cEr1GQ37fQHL4aUw55MV9DtHg2GdlQ6jo3+1cW9X5umzF0SCcGWARhB1PzMmuGCgdqAmVcfYnB2yfzc/k+VN+5SLr+lCYmB2c7N1p5h/Vy1I0LtCAzxKUwIg9GG1Mv6Y9wZHyWosZoTz969qyNKiyT05FYLj8XLtj+GGYhgj+MVM8wxoA//GMifK1+DlfR2X09hl/g7c93fGYw3kOIQvDoumlEz3XVHDSZMXFGj/r62IgPxX6gx+jXmJxouS/9JAmbLDm8Yrh/Id7rvg7VGxibRYLKqYbI/SYGKGNf4i7dO+HuoK9xpRSoF614IkXBt/Geymld5gAKTsxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=perex.cz smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1sL23ptZHWrCRDLxrSmrL4AUZquEt3WYs+m/mJF6H0Y=;
 b=n+qukhYaH/CO1hA6Ms2vekFNgKZvc2a6o3jIeMR8EGsCQPWzXAyOBoCd9HV9tL6N5hoD1MaUxXn9srnzlY0MZFXqsR8I0haR3WB2yqbyFGI8UUb9cjhAGnGa35McwZW3V4ODLKvjVQ1b8MKA1f6vphDr8/FV9MnapIoJDeBNyq4=
Received: from CY5PR15CA0218.namprd15.prod.outlook.com (2603:10b6:930:88::21)
 by BN7PPFCE25C719B.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Thu, 29 May
 2025 05:38:54 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::28) by CY5PR15CA0218.outlook.office365.com
 (2603:10b6:930:88::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.22 via Frontend Transport; Thu,
 29 May 2025 05:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 05:38:53 +0000
Received: from vijendar-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 00:38:50 -0500
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <perex@perex.cz>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <Sunil-kumar.Dommati@amd.com>,
	<alexander.deucher@amd.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Subject: [PATCH] ALSA: hda: Add new pci id for AMD GPU display HD audio controller
Date: Thu, 29 May 2025 11:08:13 +0530
Message-ID: <20250529053838.2350071-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|BN7PPFCE25C719B:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d15146-5268-4cd3-4d24-08dd9e73190b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SG7Kwm+vPWc77I6FuDGqOztGajSwOQW77DwZqE39HwsUu9GMD1uot7VxO5s2?=
 =?us-ascii?Q?143ND9Wsd9CcnzcYXN1cVtIp6krWjcVGjZe9LwIBx+J+vcNmNwi45zkRZtoN?=
 =?us-ascii?Q?UOZJO5HgjFGrLftfUIEXYFbI3lCVFkZTt9mWYf6vty8EMEXGwBRiYN0Ya4UR?=
 =?us-ascii?Q?Z6sT1xBGcHqUY+Wm4+63R/uwo7lJMM1glGAkcnGyxRjKz1P7Q+YFE5JGMtI9?=
 =?us-ascii?Q?+55/B6sObBk3wOhlGP4BElliu3HsW89ukPFq3gLAazTbmlSa0M3XCNMpnqNq?=
 =?us-ascii?Q?a0XnKr1HArP7pPFQsvTJk42XbQmn9MutXSU733LGmHh3Ki0K0pbMI/dFN5c0?=
 =?us-ascii?Q?LezQpqGgeF6TtVEgvKBq1tUN+6bg4VAPCbAikREA6de7eRlaYoUehEOVeaNe?=
 =?us-ascii?Q?E9a5Th6FBRQPYplApqP11SWh46U5aAgiV6i8LgStH0WOeevsMGoMRc+W+xyc?=
 =?us-ascii?Q?aEHmX1tsTXzA3nc5Gy5lrbm5s5uEAt0emB/9bV/r5D/0rv35waKM8Fvttvne?=
 =?us-ascii?Q?Yn0BQ8XXIzOB5TQzgGErbCnAjWuR+KkVZhkMrvS1zWVJk4rrih2Xc2xPl+54?=
 =?us-ascii?Q?MW1BOFWbTghMEsXthmHyLFqLc47pFmem5XnS6+1SCvFRpZy0wnK5Go0UVs+Z?=
 =?us-ascii?Q?fgrOpEAUyMWSRv77dMcG1lsrPH78eQvmY1Qw76zwBe1DL4xJorwdJVQWP8M5?=
 =?us-ascii?Q?klYHsIhJwB7a27tSC6Z2m4CuDf/1ShcHUT0Of+nIHe4tQIywIuI7/mr6lqc9?=
 =?us-ascii?Q?HGF4AY2SNXCYbZSmi+7GVhkR7cijhBgoG64MkFLxmbRB9kdg7kEpmYKsVSzL?=
 =?us-ascii?Q?Jh5bAoxx+GwtIfdO3ka6GMokdCZn4WCZz9N5tuAjNMz7VoMtQ1eQixmRYAwd?=
 =?us-ascii?Q?IFG39rYgIpi92YK5LasYqb8zz6+NIJc98uDrX0d++gVODqz1p5CPWoICLHLz?=
 =?us-ascii?Q?cJoH5Mnvgdg/TJDXK6Oqnfz63+3ktSw9TvDXbtOF3pADodFU2vuB43RDrhO5?=
 =?us-ascii?Q?2waecIk4S2TPkMfBixqeT54o66EwZBn33aw796VdGdf0zGRpIel0/Kf8S5EW?=
 =?us-ascii?Q?INkH/ghgZghv/srEr1RB7Fyq3lryO3Ca64beeZqhXf+yfKRMUSWFfPad+m41?=
 =?us-ascii?Q?w16HTIlSYKumSj3yMuGX1F5sptQ1qndq6RJvedytyCLk+7Ti7oOjavmUzdFz?=
 =?us-ascii?Q?5scGCMZdfR+WAND328BfhwMfnYPxF7b/zaCqjaiQm3NyJs8mbq0jcw37uyzI?=
 =?us-ascii?Q?O0IYKOO0nKdMlO2pvi4ubAEU8DVMwCbr/BYpT1fkzQG4M14P+gw9yokw0Gzd?=
 =?us-ascii?Q?m6OFSudafOp75AMWK/nsAnFwHavV9AOlhDAju+kF0dPTY3PsVT8terwICzc+?=
 =?us-ascii?Q?/5kPIi/mfkK/4f35zW/TS8RUhu84QQ/pGXIUWZJhh40odg7B5f0YQdmU/Ktd?=
 =?us-ascii?Q?P+ajl1IEAux9S1cmhpfZUtTcM1dCmhrmmW8NCXPbHw+yBqrVbXaZ0ws3vBbm?=
 =?us-ascii?Q?DH67VupOMtqZfOQ9P2bXgeR+CMW55UvmXGiX?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 05:38:53.4082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d15146-5268-4cd3-4d24-08dd9e73190b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFCE25C719B

Add new pci id for AMD GPU display HD audio controller(device id- 0xab40).

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/pci/hda/hda_intel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 512fb22f5e5e..3f8b2bf6eab5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2715,6 +2715,9 @@ static const struct pci_device_id azx_ids[] = {
 	{ PCI_VDEVICE(ATI, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_VDEVICE(ATI, 0xab40),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	/* GLENFLY */
 	{ PCI_DEVICE(PCI_VENDOR_ID_GLENFLY, PCI_ANY_ID),
 	  .class = PCI_CLASS_MULTIMEDIA_HD_AUDIO << 8,
-- 
2.45.2


