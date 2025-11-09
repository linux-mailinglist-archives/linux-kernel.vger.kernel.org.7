Return-Path: <linux-kernel+bounces-891823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E84C439A6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2AF0C3449A1
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D758123EA8B;
	Sun,  9 Nov 2025 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fC5oyCv3"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011037.outbound.protection.outlook.com [52.101.62.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758821765B;
	Sun,  9 Nov 2025 07:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762671715; cv=fail; b=JA26+XpUAv9AX/4slAY8FtcHT6U152BZgu815Oz35RyAwX3X4CvVw2MuD3mz0WCbjPTbKazrn91/HYmhqVJLXiOBOK6UVtmssNOi0fS4YhGNPoQUt2pMxqgUd3SIOahqTgtBk12P791zJPb2VZTVQPkx+1xvefsZ8ZgJocCP47o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762671715; c=relaxed/simple;
	bh=JZ/YGX4260ab2CmtonJzcFUruqdL1PkvvDs05hWV8LE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jiHwtJ8Xv2ngEWZkcUIxDspVFFL53GcZxHLsCTAh+pAo5agUbMUbe+SHaNoA34NcxMJ7XdwmW3NCoeZt0xpoP+bGSOUFicHs4CIPaQxAtXiKUZqjTUpvq9m0f48fVyaiU9Zc+wc+yv5npFCn16PWwW62lOVFxzkF2CN67a/aE8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fC5oyCv3; arc=fail smtp.client-ip=52.101.62.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vQ1shr7qTmh/6xgYxaCva16eIUHpMZCWVz8UnYiecFNHmx73BOvNUQWFJSHeUUMpFGE0YYc8ZJfsFqNuZv+cWbEYWITOF9o7lOr37WfFo9/IRticKnV8doyh421lDSBz6kk3hAwxa51LyzIO42idyvlivCp+4edDE0FR1IjKAg1aM6V1QMuBubur/Fu1m05JZK0qe9auSW6wS+A8lnjwR74RLbMJX6KrEYLYXwCuSvitkFzKVS/MJaI2QX524a2G1UFDVYjS2Maf7Eds3Eu/Skttipe5r7jXJv0ohShOi6RkuNtaYogJTMoOnTT3gjxd4CSaUqOhkzuxb10JwhSAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wI4QSbznU4HFUA3jUYs3I9XnBU1EcHx8zP//QHjYP2Y=;
 b=lbinFQ+Eju6ZodD5WNRu+iTNyexwgROYh4smmt/c1Ji/1yNkao06J/yB23N+2fCUZWSKA3PiZ0Jj3cFEJiNuyoSkvrm0Ai+IMKgUpCpQTUghm9cMM+ti5ujrF66Ul5RdjXQhreRkSZHkqOqzJutmnUgdiawXSQ5qWerUqByf6giPauwucRcf7ga+LE344TVjFZA9ED/luTOFrTodeS9bB4Bsjbgo5oW/bHXrONSajUkhi9GuW7Uj5uEojI5cUPUji0Vrx4XJZWFRKXjzTl5Fa+veXeuLPHje0Fb+ERwplS+uCtUco69ehlHrh+pCmQ7iyhppzFsmVpbrnDkNE6Sp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wI4QSbznU4HFUA3jUYs3I9XnBU1EcHx8zP//QHjYP2Y=;
 b=fC5oyCv3r4M63cm6BBQ7OB0yWHLVz2Br3Y7vFo092GR2ICTsqFSpM7bsRmlS+fnLW1azEYhggxL2+LxXsDwcWd2Na22AnM51VmMIiViumkg4c8Jka2sVYnx0rtYmkJ/bwvcNQ5fiv9hlwtJaJnRTUxqWcHZdK3orgI9f8e+Bkco=
Received: from SJ0PR03CA0265.namprd03.prod.outlook.com (2603:10b6:a03:3a0::30)
 by IA1PR10MB6781.namprd10.prod.outlook.com (2603:10b6:208:42b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 07:01:40 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::55) by SJ0PR03CA0265.outlook.office365.com
 (2603:10b6:a03:3a0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Sun,
 9 Nov 2025 07:01:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 07:01:40 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:01:38 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:01:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 01:01:38 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A971XdJ1479605;
	Sun, 9 Nov 2025 01:01:34 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <jwboyer@kernel.org>
CC: <shenghao-ding@ti.com>, <linux-firmware@kernel.org>,
	<13916275206@139.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Baojun Xu <baojun.xu@ti.com>
Subject: [PATCH v1] ASoC: tas2781: Update dsp firmware for HP and ASUS projects
Date: Sun, 9 Nov 2025 15:01:06 +0800
Message-ID: <20251109070106.5993-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|IA1PR10MB6781:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f565c3-c663-4ecd-8f41-08de1f5dd522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CwwvQPL+RfJZCqRNlx7P2nnQq1HA3WoZZfAelA2/cjZ4B1VEolyGxSLNkCuS?=
 =?us-ascii?Q?crr6P7dQGD7c+BHpI7y2KMJed9Fvcfd0J43XqQQ6Za8ErjwPFHO+IZPH77OG?=
 =?us-ascii?Q?CoT15RwVMyl2g9AOFtLYcLzGrGNN5VEmuzVUPF8Yt867rB4qa14oZSM/ggAO?=
 =?us-ascii?Q?8r5JE5sEEtJ8dQAvokE5pTgn/lT+ytprVXtNomsOSgjJr5rtHioj5VXkkP7b?=
 =?us-ascii?Q?9DVZhNU3u/DOiXJZS8PkHI1LATpUB667H1YDU+JuES9NvkTxTVhionYYf+ys?=
 =?us-ascii?Q?PFWjeGxGo3zDmHEFTeugksTJ17MjwFAxNVmtmg3BTRx4dU6jV8OTY+1SCOHf?=
 =?us-ascii?Q?x5D97e8KSn/wmATmedGUCEi3N/fmveXzHg1gyQBOXIC0UHIeCZoAHWFijL7Z?=
 =?us-ascii?Q?Xa4EwSSb1GbBmKI/QO0LKiUI9MVOlxaN5A1i5BGI1z19bNRY0voN4ipBaexb?=
 =?us-ascii?Q?/Of9WeqZfbjTmfcHgY103Qo9ECBWNr0cy+19lWwd5wL7+IXF+x2WvmpJs/vq?=
 =?us-ascii?Q?y+Ot4VsjqLDklW/pP1hO/7pF3Dh3hCQwWpsnHbTUj0Zv6hXlm4Do/riV8e2s?=
 =?us-ascii?Q?xHPSYCdmBGKE7WNbBGurxqmR9erVLFPZjikiNOBnzzEO2oSbvifDHACprDeI?=
 =?us-ascii?Q?rxIGev/JxSCFfh2aGdlKC3jaFtrjC7G8fPT4yFrLEgG36pbRIuNkSB3P8Ugu?=
 =?us-ascii?Q?hPmgC3cLvAZh266l2f+KytuPwUcbMFD4/ZSBBMii3Brln4H9yzBQs26KweAN?=
 =?us-ascii?Q?pOYz68Omz7t/E21sXzJ766lREQPS+jVH8DHfV5rVz8bGRfJQhALJRw/Z/XQC?=
 =?us-ascii?Q?+eXet1EsFYrAziYITdpo3ivGdWlohHWlmmjbS306QWIdE3HT/XTeZWAPhDIB?=
 =?us-ascii?Q?JLZoQL3kI0KWjXNDUdszk52EQfY9VUlXepw0lMG3y/88juW6OKB9MCbaSbxZ?=
 =?us-ascii?Q?HfGwXtT1yBFvmQCiIdFDSady/MDjBcoqvERtZEkj7AfPhqBTfOhR3pRrRivi?=
 =?us-ascii?Q?HGb8dFqakhGUDtUMy55mRQWFMBeDFdSafgToxWqZ0sgsUcChDpG9JjUYNVNb?=
 =?us-ascii?Q?SeCo/kKqWxHvf+h7zEwxEJg1ZFviBzhN5WmiqBPu1R7CaQpxjme8/ToXcHI5?=
 =?us-ascii?Q?XGqmFPcHg+Hoo0v8BzYYTw2fwM+U2uF1xY3NXnP/meV9vziWmAPwgGu7noZi?=
 =?us-ascii?Q?Xn34azO7t2jPKoknTT3FXd0nt0DKl+GVy+jDl399kpdWgxsoYTK0dP0zxfJm?=
 =?us-ascii?Q?WK9PZb2DRMShOvHjVE6rjWuMUfxfypSwLG9bILXAzNzEkT9wbHo4T+iIvWg7?=
 =?us-ascii?Q?KGPhZ7wI/tHPcZq3bth39fJArlXBM+LA/hF7HBSDX+aBPCfoGVCcK22HFoVM?=
 =?us-ascii?Q?csZ+AOR28u0VLwM5+9DP1T87AN2TEIoCZsMgjfR0BQ1IMwT1nBA+bDScb6YR?=
 =?us-ascii?Q?WOJZC0Re7J60SAG2ApvKn5upQxsdBpBxDkEDLTJwfoJkYgfgxPuo9GuxJ2Ad?=
 =?us-ascii?Q?ikRJGs6b+YyFrc8qfyrualQVIfdOjpYYr0wSl3LM4yVxNzyoNTXC9nwm1wUt?=
 =?us-ascii?Q?MlhaKNT4yyZpSGayQJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 07:01:40.0780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f565c3-c663-4ecd-8f41-08de1f5dd522
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6781

Update dsp firmware for HP and ASUS projects, and add symbol link.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 WHENCE                            |  50 ++++++++++++++++++++++++++++++
 ti/audio/tas2781/TAS2XXX13840.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX13841.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX13940.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX13941.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX13A40.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX13A41.bin | Bin 0 -> 49192 bytes
 ti/audio/tas2781/TAS2XXX8D8E.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8DAA.bin  | Bin 0 -> 49224 bytes
 ti/audio/tas2781/TAS2XXX8E17.bin  | Bin 0 -> 1852 bytes
 ti/audio/tas2781/TAS2XXX8E19.bin  | Bin 0 -> 1660 bytes
 ti/audio/tas2781/TAS2XXX8E1C.bin  | Bin 0 -> 1852 bytes
 ti/audio/tas2781/TAS2XXX8E8A.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8ED5.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8ED6.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8ED7.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8ED8.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8ED9.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8EDA.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8F40.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8F41.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8F42.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2XXX8F62.bin  | Bin 0 -> 49824 bytes
 ti/audio/tas2781/TAS2xxx8C70.bin  | Bin 0 -> 1756 bytes
 ti/audio/tas2781/TAS2xxx8C71.bin  | Bin 0 -> 1756 bytes
 ti/audio/tas2781/TAS2xxx8C72.bin  | Bin 0 -> 1756 bytes
 26 files changed, 50 insertions(+)
 create mode 100644 ti/audio/tas2781/TAS2XXX13840.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX13841.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX13940.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX13941.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX13A40.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX13A41.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8D8E.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8DAA.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8E17.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8E19.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8E1C.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8E8A.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8ED5.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8ED6.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8ED7.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8ED8.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8ED9.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8EDA.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8F40.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8F41.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8F42.bin
 create mode 100644 ti/audio/tas2781/TAS2XXX8F62.bin
 create mode 100644 ti/audio/tas2781/TAS2xxx8C70.bin
 create mode 100644 ti/audio/tas2781/TAS2xxx8C71.bin
 create mode 100644 ti/audio/tas2781/TAS2xxx8C72.bin

diff --git a/WHENCE b/WHENCE
index eb839452..8532c44b 100644
--- a/WHENCE
+++ b/WHENCE
@@ -8573,6 +8573,12 @@ File: ti/audio/tas2781/TAS2XXX12040.bin
 File: ti/audio/tas2781/TAS2XXX12041.bin
 File: ti/audio/tas2781/TAS2XXX12140.bin
 File: ti/audio/tas2781/TAS2XXX12141.bin
+File: ti/audio/tas2781/TAS2XXX13840.bin
+File: ti/audio/tas2781/TAS2XXX13841.bin
+File: ti/audio/tas2781/TAS2XXX13940.bin
+File: ti/audio/tas2781/TAS2XXX13941.bin
+File: ti/audio/tas2781/TAS2XXX13A40.bin
+File: ti/audio/tas2781/TAS2XXX13A41.bin
 File: ti/audio/tas2781/TAS2XXX1EB30.bin
 File: ti/audio/tas2781/TAS2XXX1EB31.bin
 File: ti/audio/tas2781/TAS2XXX2234.bin
@@ -8620,8 +8626,27 @@ File: ti/audio/tas2781/TAS2XXX3F200.bin
 File: ti/audio/tas2781/TAS2XXX3F201.bin
 File: ti/audio/tas2781/TAS2XXX3F300.bin
 File: ti/audio/tas2781/TAS2XXX3F301.bin
+File: ti/audio/tas2781/TAS2xxx8C70.bin
+File: ti/audio/tas2781/TAS2xxx8C71.bin
+File: ti/audio/tas2781/TAS2xxx8C72.bin
+File: ti/audio/tas2781/TAS2XXX8D8E.bin
+File: ti/audio/tas2781/TAS2XXX8DAA.bin
 File: ti/audio/tas2781/TAS2XXX8DE8.bin
 File: ti/audio/tas2781/TAS2XXX8DE9.bin
+File: ti/audio/tas2781/TAS2XXX8E17.bin
+File: ti/audio/tas2781/TAS2XXX8E19.bin
+File: ti/audio/tas2781/TAS2XXX8E1C.bin
+File: ti/audio/tas2781/TAS2XXX8E8A.bin
+File: ti/audio/tas2781/TAS2XXX8ED5.bin
+File: ti/audio/tas2781/TAS2XXX8ED6.bin
+File: ti/audio/tas2781/TAS2XXX8ED7.bin
+File: ti/audio/tas2781/TAS2XXX8ED8.bin
+File: ti/audio/tas2781/TAS2XXX8ED9.bin
+File: ti/audio/tas2781/TAS2XXX8EDA.bin
+File: ti/audio/tas2781/TAS2XXX8F40.bin
+File: ti/audio/tas2781/TAS2XXX8F41.bin
+File: ti/audio/tas2781/TAS2XXX8F42.bin
+File: ti/audio/tas2781/TAS2XXX8F62.bin
 File: ti/audio/tas2781/TXNW2781RCA0.bin
 File: ti/audio/tas2781/TXNW2781RCA1.bin
 File: ti/audio/tas2781/TIAS2781RCA2.bin
@@ -8646,6 +8671,12 @@ Link: TAS2XXX12040.bin -> ti/audio/tas2781/TAS2XXX12040.bin
 Link: TAS2XXX12041.bin -> ti/audio/tas2781/TAS2XXX12041.bin
 Link: TAS2XXX12140.bin -> ti/audio/tas2781/TAS2XXX12140.bin
 Link: TAS2XXX12141.bin -> ti/audio/tas2781/TAS2XXX12141.bin
+Link: TAS2XXX13840.bin -> ti/audio/tas2781/TAS2XXX13840.bin
+Link: TAS2XXX13841.bin -> ti/audio/tas2781/TAS2XXX13841.bin
+Link: TAS2XXX13940.bin -> ti/audio/tas2781/TAS2XXX13940.bin
+Link: TAS2XXX13941.bin -> ti/audio/tas2781/TAS2XXX13941.bin
+Link: TAS2XXX13A40.bin -> ti/audio/tas2781/TAS2XXX13A40.bin
+Link: TAS2XXX13A41.bin -> ti/audio/tas2781/TAS2XXX13A41.bin
 Link: TAS2XXX1EB3.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
 Link: TAS2XXX1EB30.bin -> ti/audio/tas2781/TAS2XXX1EB30.bin
 Link: TAS2XXX1EB31.bin -> ti/audio/tas2781/TAS2XXX1EB31.bin
@@ -8694,12 +8725,31 @@ Link: TAS2XXX3F200.bin -> ti/audio/tas2781/TAS2XXX3F200.bin
 Link: TAS2XXX3F201.bin -> ti/audio/tas2781/TAS2XXX3F201.bin
 Link: TAS2XXX3F300.bin -> ti/audio/tas2781/TAS2XXX3F300.bin
 Link: TAS2XXX3F301.bin -> ti/audio/tas2781/TAS2XXX3F301.bin
+Link: TAS2xxx8C70.bin -> ti/audio/tas2781/TAS2xxx8C70.bin
+Link: TAS2xxx8C71.bin -> ti/audio/tas2781/TAS2xxx8C71.bin
+Link: TAS2xxx8C72.bin -> ti/audio/tas2781/TAS2xxx8C72.bin
+Link: TAS2XXX8D8E.bin -> ti/audio/tas2781/TAS2XXX8D8E.bin
+Link: TAS2XXX8DAA.bin -> ti/audio/tas2781/TAS2XXX8DAA.bin
 Link: TAS2XXX8DE8.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
 Link: TAS2XXX8DE9.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
 Link: TAS2XXX8DE80.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
 Link: TAS2XXX8DE81.bin -> ti/audio/tas2781/TAS2XXX8DE8.bin
 Link: TAS2XXX8DE90.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
 Link: TAS2XXX8DE91.bin -> ti/audio/tas2781/TAS2XXX8DE9.bin
+Link: TAS2XXX8E17.bin -> ti/audio/tas2781/TAS2XXX8E17.bin
+Link: TAS2XXX8E19.bin -> ti/audio/tas2781/TAS2XXX8E19.bin
+Link: TAS2XXX8E1C.bin -> ti/audio/tas2781/TAS2XXX8E1C.bin
+Link: TAS2XXX8E8A.bin -> ti/audio/tas2781/TAS2XXX8E8A.bin
+Link: TAS2XXX8ED5.bin -> ti/audio/tas2781/TAS2XXX8ED5.bin
+Link: TAS2XXX8ED6.bin -> ti/audio/tas2781/TAS2XXX8ED6.bin
+Link: TAS2XXX8ED7.bin -> ti/audio/tas2781/TAS2XXX8ED7.bin
+Link: TAS2XXX8ED8.bin -> ti/audio/tas2781/TAS2XXX8ED8.bin
+Link: TAS2XXX8ED9.bin -> ti/audio/tas2781/TAS2XXX8ED9.bin
+Link: TAS2XXX8EDA.bin -> ti/audio/tas2781/TAS2XXX8EDA.bin
+Link: TAS2XXX8F40.bin -> ti/audio/tas2781/TAS2XXX8F40.bin
+Link: TAS2XXX8F41.bin -> ti/audio/tas2781/TAS2XXX8F41.bin
+Link: TAS2XXX8F42.bin -> ti/audio/tas2781/TAS2XXX8F42.bin
+Link: TAS2XXX8F62.bin -> ti/audio/tas2781/TAS2XXX8F62.bin
 Link: TIAS2781RCA2.bin -> ti/audio/tas2781/TIAS2781RCA2.bin
 Link: TIAS2781RCA4.bin -> ti/audio/tas2781/TIAS2781RCA4.bin
 Link: TXNW2781RCA1.bin -> ti/audio/tas2781/TXNW2781RCA0.bin
diff --git a/ti/audio/tas2781/TAS2XXX13840.bin b/ti/audio/tas2781/TAS2XXX13840.bin
new file mode 100644
index 0000000000000000000000000000000000000000..fe3443c3fa64d82bc0c5625139c46e5546a29b5a
GIT binary patch
literal 49192
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX13841.bin b/ti/audio/tas2781/TAS2XXX13841.bin
new file mode 100644
index 0000000000000000000000000000000000000000..c91ecb8db6d3f879c572fca63901f2be95351204
GIT binary patch
literal 49192
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
O@|n5P*OU79_xvw|2U8jV

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX13940.bin b/ti/audio/tas2781/TAS2XXX13940.bin
new file mode 100644
index 0000000000000000000000000000000000000000..fe3443c3fa64d82bc0c5625139c46e5546a29b5a
GIT binary patch
literal 49192
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX13941.bin b/ti/audio/tas2781/TAS2XXX13941.bin
new file mode 100644
index 0000000000000000000000000000000000000000..c91ecb8db6d3f879c572fca63901f2be95351204
GIT binary patch
literal 49192
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
O@|n5P*OU79_xvw|2U8jV

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX13A40.bin b/ti/audio/tas2781/TAS2XXX13A40.bin
new file mode 100644
index 0000000000000000000000000000000000000000..fe3443c3fa64d82bc0c5625139c46e5546a29b5a
GIT binary patch
literal 49192
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX13A41.bin b/ti/audio/tas2781/TAS2XXX13A41.bin
new file mode 100644
index 0000000000000000000000000000000000000000..c91ecb8db6d3f879c572fca63901f2be95351204
GIT binary patch
literal 49192
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
O@|n5P*OU79_xvw|2U8jV

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8D8E.bin b/ti/audio/tas2781/TAS2XXX8D8E.bin
new file mode 100644
index 0000000000000000000000000000000000000000..4b92188babe69f7af6938db1613e7fb1458fb5f1
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8DAA.bin b/ti/audio/tas2781/TAS2XXX8DAA.bin
new file mode 100644
index 0000000000000000000000000000000000000000..94ff6bda537f4e8c751233fd3bf04b190d3db46d
GIT binary patch
literal 49224
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
Hs^9+t&9^bM

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8E17.bin b/ti/audio/tas2781/TAS2XXX8E17.bin
new file mode 100644
index 0000000000000000000000000000000000000000..3c8fec8cc5975023af76847d7710921e5d38a478
GIT binary patch
literal 1852
zc%1E3&ubGw6#izLO_$WbY6GoRaNBwa79}-}Hni2GHuh&on-=Y%vav}UTeOk>I9NRd
z5%FB15baqCq89}b6$2jhP@(^T*n<ZTf&oDaCSBj`W=*?#h~5egeC(Sy-+S}Dna8Zp
z=Q|Emw%-|D`U*tA7-%pgzr6VrjfB-J{;NK9AgT_Z4-Vq*N0puo;>$m*@tvNQlZ13A
z;Z$PcANDVfii)BkaIh7&LZ4N#8%c!-R!?eb-hu5`z`7rT`R0jfgUw^;<hE36W+2;*
zfN48MN`6Pe@H4UtPA3ZfVH8evq7XXC*AwCZP8Yce(T%tnC)_CI5Za;r_{ejRW~moA
zL<<MTX-%R!;I0os=@pLXT<ih92?65LS<1HzUo|9$u7P|tX~S2C>hTkjUWuMhIcE4<
zV1NE-)!3_*{B3!l<AcEqd<TLqvhBcF2Dp$0Vw5x915A*XBn(Z{*ms@puq+sP=E%3O
z0W8M!b=Fb32Cj*Pcw8-PGVKny2u`opE7P|sley<uTYGOgdlzg0%(`x7DR4CK>RHxL
zN{&w7PU$?+h0A7)sPGV8^C0MauVtPzi~jBh{7#~e`$Ueu&;9EhXBxuyIoie|lN{dV
zp=OSz^=O{suw&#c$HA_1OB|HqHRZhoyQG(rCJk9qv_X~Ta=_*$kf+nz+5$AqD3>T8
z3Wx%tfG8jehyqU0h@cTcBZ8Lu9ePcbv0qKhWG3(OzO6I+cJE!GtIWP-|ND0L_H8^h
zGdY!9n7ueZm6}nle-zbx+SQg;rN3uUo%5(3>=^pX{UW{1L-&e?og@S;^N?lUXqk6f
L=4ZE0v@*v}Vfj7G

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8E19.bin b/ti/audio/tas2781/TAS2XXX8E19.bin
new file mode 100644
index 0000000000000000000000000000000000000000..ea0a1a66f1a35a5415050ef41c24dfc0af744398
GIT binary patch
literal 1660
zc$_meH8o;jV5`xZ{q-UPgF6EwBLfgHGNg+>o)O?~6d&a88y{SfT9jIpA8!~QZ;_vo
z%RmC)1{=n}@&}6?$fhmC7y@*If^U9GDk&DD0%m3?g9(Hg?=jv3QXW9I3{ZpvD9@mw
z=*Xbp$;1WZvoJ95FbI5Rasavz=thASh?p<~2N&4YKr!(KAPF>6N{oR)S_x>38ITV&
zTOO!DK@Xzdgn@0R?h1%{3kHaKYhXCo>}FuFZGfn8VE85iGt&h`voSElNHQ?QHZU+G
z0L7AlZcGKbFP#D6&MXF@YM`wQ)0lv2*%=s$fnuc(7#PZdhEydmFp8gGU{nN}qXALR
zXp0=$K<Ek*mtbHK0J@HW0c16=v9YlLkmjB_a~9W`GiSl>VljZ|U;-*(abPGCX*vMZ
z7~!yY`vFU!%XG8a^1<p@MHq5mdRP@eT0s5^U|`i?sGPakkk!(CnFA>P)_Jjlu-6Ok
z3n1*Q<U1RLtz-PtK-hR%pdkorUkLgG!YW)L$3a-eC2SH11C7`ZG&h5RjRWkJ`v3p`
z<HN+LA!r83PaG1kR0CvdFgU>2TpkE<t_X-YFcC4zGs+W8SCg4sM$^@3x*|4RCFkd*
zWu})FC6;97=f&eFk>g<{WW0%mg11Lie6c~i0j%f)5xX0Z3PWI8U{GQ}1&(NZS2Vsd
R8s7<x?}p6z&+wlp000*0gqi>V

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8E1C.bin b/ti/audio/tas2781/TAS2XXX8E1C.bin
new file mode 100644
index 0000000000000000000000000000000000000000..3c8fec8cc5975023af76847d7710921e5d38a478
GIT binary patch
literal 1852
zc%1E3&ubGw6#izLO_$WbY6GoRaNBwa79}-}Hni2GHuh&on-=Y%vav}UTeOk>I9NRd
z5%FB15baqCq89}b6$2jhP@(^T*n<ZTf&oDaCSBj`W=*?#h~5egeC(Sy-+S}Dna8Zp
z=Q|Emw%-|D`U*tA7-%pgzr6VrjfB-J{;NK9AgT_Z4-Vq*N0puo;>$m*@tvNQlZ13A
z;Z$PcANDVfii)BkaIh7&LZ4N#8%c!-R!?eb-hu5`z`7rT`R0jfgUw^;<hE36W+2;*
zfN48MN`6Pe@H4UtPA3ZfVH8evq7XXC*AwCZP8Yce(T%tnC)_CI5Za;r_{ejRW~moA
zL<<MTX-%R!;I0os=@pLXT<ih92?65LS<1HzUo|9$u7P|tX~S2C>hTkjUWuMhIcE4<
zV1NE-)!3_*{B3!l<AcEqd<TLqvhBcF2Dp$0Vw5x915A*XBn(Z{*ms@puq+sP=E%3O
z0W8M!b=Fb32Cj*Pcw8-PGVKny2u`opE7P|sley<uTYGOgdlzg0%(`x7DR4CK>RHxL
zN{&w7PU$?+h0A7)sPGV8^C0MauVtPzi~jBh{7#~e`$Ueu&;9EhXBxuyIoie|lN{dV
zp=OSz^=O{suw&#c$HA_1OB|HqHRZhoyQG(rCJk9qv_X~Ta=_*$kf+nz+5$AqD3>T8
z3Wx%tfG8jehyqU0h@cTcBZ8Lu9ePcbv0qKhWG3(OzO6I+cJE!GtIWP-|ND0L_H8^h
zGdY!9n7ueZm6}nle-zbx+SQg;rN3uUo%5(3>=^pX{UW{1L-&e?og@S;^N?lUXqk6f
L=4ZE0v@*v}Vfj7G

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8E8A.bin b/ti/audio/tas2781/TAS2XXX8E8A.bin
new file mode 100644
index 0000000000000000000000000000000000000000..11a5ea4ca08785ea41d1ff8f29c04145c1666a16
GIT binary patch
literal 49824
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
J)yLQU`!8~cq$2<T

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8ED5.bin b/ti/audio/tas2781/TAS2XXX8ED5.bin
new file mode 100644
index 0000000000000000000000000000000000000000..873426b1b60874f942af071709dc3f7ceb23eb2a
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8ED6.bin b/ti/audio/tas2781/TAS2XXX8ED6.bin
new file mode 100644
index 0000000000000000000000000000000000000000..873426b1b60874f942af071709dc3f7ceb23eb2a
GIT binary patch
literal 49824
zc%1Eg3w%`7wf8!E&P+}wlQ4k@Nq9{VVt9xF34$V=goI3Z*dYOlh$fLhi1G-p8WG4O
z9#UFkqPDf7y&502+V*<;-CwWbvtz)o5wzvXtwn5Ws(AIQ)pG4c;gV#&|JvuAVTgf(
z+WY-_zcatz=A5(l+H0-7UVH7Gy~)eVn@rTv{z3IUTZz6#ibD7)v})?(*DYAFp?2-M
zNtaekD=N(6f2LOC=1rbP=kZID$mp*5{j>?9A*dg+?5`nNw0Ujq+M2+Eb=51*hj#3z
zkjrJg@>5YlN{DFUQM_*k7xgWQM%1g1rf$^4N=QD9xk{q_E;`9ey_fD15w!P;@u$P<
zbhhv2NWRbLP=x4chytgEcbCK~NNo|C2`8woMfe$aS$toSOF~RTNl!GtBYqM(jTAu-
ziI8g>MKj)Mqv*RWQBR{0R8(WGnl6IsE8uqt-WBj$Z0u8o(V-HaF7%xug5(k*3Q#n2
ztCWGu<iQB4>9P-S<LMGP^pH3}bAc-WJTBvPi9-O#Wxz2|gp%$CUey?<x+ywzs^m}i
z+-Vd5CMTg1eH8TV5(hl(tv$fmk+lgpT)?3SJ?U-{O3)>JRU_aaiViE6ID!;GKQiV~
zUh{r>O6Y12+J4NkN4>wbC+Tjr@~#OjQJ*QNQTjSjN&dE6qL$v0fKiZ@Xq0AYbdSDK
zw)g5=`Pte-r7cml-FQiDZ|=+z%?GkvlD=C*KLz8VIiRznwOjc!!vQ|Sh$w?>Sip<{
zOwfYC7(9&>73-~W^ZUc{J>(|iB^qgz(Jb&Qe2Ljvs0-t}$k-3v>7FRYxSOK>`z3vk
zDSx4R7o#3>@Ryn2NzgN7AEG-^_Xk<GkHQ%LNMm1?isD7_1MUin4t&eB57I@aD<lrM
z%DG+y74SpTEd48xzo2Mps+3E#s7TUJu<0jVC4#WC=<o|Ie&$m&u+OxA&vE`1!DQg`
z90e}G1+FpSd@U56lyAR_p!kHMxh9TI@d;p65p-P)n{vZ0NE~vF5}gUKDQ~5uuW2L>
zBxD<hRgc*}AxDI~VWt7QP{6xjy8%uiaaO{vf(a9wU!m_3-6`5CVJrK_q9}<wmQtgp
zQx^KBQ&d;k7h%Ukb`(&f(Jn~rp){>KkgAbC03FSg^b?`~D9x034=`?wZB)TMY=c_2
z`iy9&TyYa+v_xHzF1V;+B*B(k1Ut_NkLsefI`Fid{L-d_lt)qD-G)&@hOTBnSI>%&
z8W!d1of7{lj(rcfj7~){B1t6adtv__fZtaOUSS)Zv|H*5J^|fb2Hii{5>0v*<!-ir
zHE`F2Sd18zp96i9v?;q^feQYTI^z0vNZtU)G8I7|@T#vs&(}!$Nv8fGgOR|YsR0_p
z@{xSYF#&c|!4}b}-f5JYc4Wp6Pm!e$wYA3=G&;vB&~XNj6Z9W7%ExjX$%LN<#XRXt
zE+eD}BOkD^N9xHo$M4hZ7`sIBrz7SBshHynMQN^#O(8Wy;@Lx9qg>5|{1OoF+`#8C
z%B$qKB#zmXF5z{>#4r63-=&N<f#cQ)iYD(h#|!*SKUpKh4pol5J#_+)#guJ98ekqp
z-wd?9D0z!eGV22Nxfrs&TI#n`nI|GjJ;tP%{G%=i-wh>92Fyz)t%S+&#TP-x1)1<z
zr?MO+{S=M)%e4Bzm;EPAc_{CQ2z)X`Q@IWCIn(xI=+2aV&^zD6Cw?y?;<wUQ%=iji
zK3#--)8MBSQYI0^_mG+i-Lg-#ATEDH(jNf->r_7jd@lE+?EGgj&N8-t)+Hh*XeNS|
zYlYBV*BP(SLikQ8MMu7G#hfzPmvLBlCBLA>a{&s^I}7nlfFJw7uL?ga#XPf9()UCD
z?ZkY0(XOFAk!=_-Q^7+6;O=M(L_b5jALB~_4BJ^UVBC<;VbPfaSWyeOX0#0g+(5t~
zme6*<B>`>#<g*X*c>-`(ibJ9rv1SNh2TS^??0@P7=$8hcONIV9j_DLF90cFiU^90B
zkAQBTmGfedT4gNLsZ8=2q^I$n0A9DF?nTrkN*x4!EzGAl#5__P<n#i@^mEK-Zv!R?
z^u3b)KuKRi9}oDlV`VDj`KgGwpnLHN;&}$gO|%b0KR=I2%3`1DgMZ!$8-YG@$4J`@
z!cTPAEqq4W73QEe&LdV4+b8>{ikPVx<?~Gc8zk*-D16E#V{Q<!34ZGLhr^&V%<`)Y
z+n<b1HAABb9An{=Nsp)j{{+w)D&atb@zV_jLlOUm!B%E!-J{=>wwn)s>z1)H1G3Q6
z%GA-4ewv1OC4FKE^!Z1OWhrGB%r}g&rr#n~;VDo*1y2>@HgkxO2XheoP|ooMS4-aF
z;ST`*^}g`#pIEt0CV0D2(!W4MoF83pbY?->{s7`&7veqgD9>uPf6gnw&ng263G_P?
z{(#s$R>o}5U1yD3SZywDYugPP9rIAC6voN95X)jm35^7<n|*;{S;$M?m-Gii{`=`l
z@Gzb0_&pZ05U)6H*)hwmM?B$JHXQZ8L|*b4^l*<EyHn%l2Ho_}K5?I8x{Up1-dW!=
zMCQN}7JT_h?UnN>?2zd#L8JMN+)mB~^ne);bWc0RHPZg(*u=4$q9Y<_i@Wh-ko40v
ziXV&33-a365$mUNe1pC&mAQ0h)xhRR)gYdq+KyAQR-Fy)?DTO=i;a6_!9LSY^I1Qy
zB1htW#8325+F+w?KP8?g&G-vzZVOS0u@teYRCTr0M^B1+=`Su(hj{@u09($3jbFmC
z3v&wu)|z6pXPxZwMX0%ny6U<DUB|ohF7WB9>#FQB!d2>Vq7T9ew1Q&>>Q$S+rUW{U
z?>vl6NcxD#z>PSWrGd}S+Um&-UR=!w@{ddVjbyo@KX;o>DQ)EhBX0E=?W$Vs3sbl_
z(AX7j4=V}&fL55DYjo5S@VWq-jq$0?o%tu)x}s6!-fqymMB)ia9BD?R#MJ*#jnwD~
zw-Hv|M~E83#nkAFexRwdo^b=0<U3YB>v2uWHVk`sg#4%n4^#twRi<l?(FiL&vOS=4
zdsw4;k>%tDMF%NbrDvcxOagtIB>iC;h4o02Mxh{h6k6rV4aVz=IO3oEDda-Py^l3V
zvi=kCsXMIib#csv91x6Jy_{RBzT;Q2JxJSni_*2~IWm7f;;)oE8;4X?>&{t^{II*Z
zJxdsod{Sq<=>hJklKyZFusY8-<f%+ugg#BC9nCKD&Fb`HTzO`UnSBlPDtJ97X*KCA
zmoUGFYXU5f45LX^j|3_SPj|So-IP%n&yGqSV<Y&Ou7>N|5g$g%zD$3Fng2)}dl()+
z$OF70GUiY+`GdS>)bu$EA)m?WtP?4)$BEFX<l8u)aITrx+@3#DDfZ`Tg@6kwJO{bj
zf;9L@82s$hyEY9gR=S533p`!j!;96J|Br<HYv{j_rKA|8=*M!g*RH@RaW##lv*F?X
z48#4ICiqb}FP8DJJ)e$9Tcwp&E+?SB5i$A!jp_J|hgHrslq0@&$ck!EH;{3`UPoZX
zoyalOZ0}-RE07Z$haV_xGpE|ZX5Y@Nk5NAfd>}rwrrP#l>2;6f<3PSiA4^5!^(@wJ
zC+v>Iwd6M2t7JXb8HNbUxDha8hj<ukc`Pq5mdUV>DQ&Bw$78$~x7XP5$2aSP0I&7i
zh$bSQ{g<2<kV_yJ^I;xMlJrN(_2)Q4sBSxl1YR%r=RC;8zD3b7e=_r0d`B?vcd8ot
zbj86VA4dLA!0V(@$6~NSHCg7Ly-KOsmh(oeEu;>R^e@ynzN&zE)P&K~V=x4sBD{Z~
zY_rDU!8m%rtKhu?_C<3oneCQiK)3`hj+Z>A0G3>U|2bq-4p<&@5V2`Mb9<GUTQdF8
z8l93|pc-uo^gaYQ%0PP|;-S?Z;r1HL$2G8@kuAN*ftF(I0=eJ;b&;Hx4`Cg3xYk_j
zcB)_F_`taU-a~CajXsC(1iY7^&Wn;F>0`AcbFWVID&V~c_LhUVn}oVV$XCW<z-ky{
zBHJ|NRu0~R*4~baIX4#Dsi2U3GzBnaR&ESF^6Pz1uF~u}#PbsP?o}wIl76<e{}NG1
ztqu8NxNa!CUe<TyZ-N}YCUqTA=YhYmGS4qXEU%1qf$xRDIT!dAvMr!}oXkNBq@7%i
zKBbV)0wYJAk3JsAcD&5BJJbY8|01@3xsSs(Q3AORfo?J03q@-;WQ_4ZXA_t%e4td$
zfdx_~oQE@w#h_6D8YMixSnG9`(*pFJ4_VEF-5s{_t`xu(0)BRDch(?DKL_(~W%MX;
zvJUd$*AMYNMa;H&-B2L=EkVDzfSH4sUM$xNtRL3#Veq4?K8hAR4L&DG9R)#0S5pv2
z1nMTqTrL(TIL7ETlKxm}|8p^~Z-f4)%Uq7<{d(RrY}GK&Q*55E#5`ZA<5`Jk_&DZr
zp5tr4*F~Iz@c7IaQ@9WF`8KgH!hTdvy@jtC`#qnDeY*VScWDnye;nc;a&Opq9o9i#
zN38QoUs<YhoG$|J(?wYFJ@oWEr|@laUMl>9(WJ<D#<7a)RNw6@eQQ(a$Jymk8MhGI
zc#p$4RP}ZEq)*Zxuf=fsqN|poJ|#AfAE;7{*Q-261U~rz+u}`L@a1FPW&F(nf4gY|
z^D6g7sddO{JZ2Xqo3XIUtp<`-`kq{Pil>!DsgnK#i+*oWs<AJBLoEIxXY)NdH;eg1
zZZ0_X8vCl;SbK1e!?N+g?&Y448mNo&o1#ElPV^)A&1S@-WV!Fqp(KDebFWC|?#SWH
zJ=pq|i#3jG`G`}!h$S+n@mh|e=6<h?Wl=rRiixqYA>Mgq{ELo$ub;Mn*_LzAZUZk$
z8&m8Zdn4K>gWfSof1<`Q%q#Si)9CUyMT^Fo`)Vn?)(>G#njpUqB>AycN*A5pxzg9n
zbwAdmSm)*>NuLqrSnD20(nQ2tj`eRX*1b=dcwBWN<f`X&H0bBHTq4(>F8IG{twA;D
zGm)aR-;}%))~U8^%{hSQtxY6+q@!xZPg*W%IQdjsSS|Te!)L2=$ohS}cP#yJ6H?9h
zD)YswufEE4(UWh>KJmZP`woTeUPhEy8EcQk-h}<AB$q~0;1h1{AB{$1xZ>V*tDJ@?
z<Dcox?!z?rrPt*jC@5psE-tRQYbknt3MIUEK!W;*&tf`h<XX+2N3GIDmtK0Q#X~(I
zM7riKTz&D4&FiM1Dh(wW?XZ4I+O_LG@2juACg~4xzl494iEn=R5SLN&b6(hx*2Eev
z*I#%#G9BY!99yryN@$m@Sv2#t{kt1_dy1Le-rh%lCdtkD*%58fjw&9X93#_*CnQzv
zgb*f5d94OL_pbYBz9nn^-Lh-fF88!QPthOwjhFQl+LL!s&whW#<YN<hbGBsf4P^gi
zK*qNQElDe>d>LcD*oVH}afknvX~mbFC>F{TYy7K;_pR{@gZ~Ja?dpP%Af@BTgu1&=
z6$xXBzsnLNKuniso8SU~C;*}Wh#viXv1qE~*-F;<7g2(rZodC{eMaN00|s_?sn37=
zN2}kz>&g9de*fGjfW8tXfHI={-sY;4FRs0$_fG}Qy+15SKT{vr-5`rj8YM`*llP(0
zf3;<<n{7VQG~3QxF}^ftU-68=`zq4XWdrx6!pVbF%MSV3So_Jg?cYi6X!_NAo44PS
zd>fbBE-t=q`{T8G)3(tMGTvL>h<v|MAN|7ipT9M`@tAji!&AS$Yx|;+kKFdy58mB+
z&C=n<=9KFiuBrHJ>!iDWEbSmsi?{OAe4uY#__kd=4YxL4-srxuwqff^7njD%pZv!5
zy=#s)ZM-LC`^yV&;c~9{Bz^C>)9<fN9gv*;Mdc;wCz<*<FS&h1^5VbSkx!%ZmfM$<
z7wBr_tCxPoMcQDpX1{NuWFIZtQufv(JAN{TpG!7QfBE^I(Ifh++r0PRGj}W+CT(xa
zkKe8O))g85?oP-YY!@4@zq&2I7=PK0Y5(>LKe?~eM~X&_qi-A6(a_>I>~hvR*nvIn
z=$`8ro+v;0!|wd_*x!;PD4)JHVdkfGZwo>YLy)Z#!|!j9^asEmJqI^bf8(Qtr{Vea
z;;R`?57mu48y;oA$M;cU#-Y#k$J8MCP(s(9u|L!Ivp)=}qks9<IJ)4C+Zm6JnhW3m
z_N;*QjMuAD_U=W!zdLr2pIiRCcHB2#SpV#~)<rDSkk9bw=Oq19(;uS^ZxuDH{9m&g
zspRH{|1<MDx@|-H_s2)WbtC1w=6xreF?*qgXToR4M%ZKW9$X~nonsSzJpW+M%dOvi
z?1@!p!l8Vx;`-c^FE2>MQ_>%(k!Mx=!`z?Y1D5#spEcJ``0d?~9vscjn|gMu54S#l
zZ+~^=S6njFE>C8L@9X$|{;&J1vt;tREfYz9kVcTrGY!4BK9c{PpRANYI;k=*rpI3l
z+rWA}DRRFT(*f(;`{4^cFCE|6^QUbGQFWB{w&}^YFS~tV;1zyun%HvPcOSa{cm37f
ze0=IoW6b2El75;Qk8VBuntx})D{#`%!*;RZ`>VV4!%gFiwA<g{r`@-|I`aQ8(=MN@
zWBM0B|8Z@)Wh1T+zqO2YSTtbEcn{YM{`pESqV&DD<Li~&`(C9{r5SeFmb_#5j%)vM
zdBn1fL62>HC}PP>wEnD>(l$TZ5dG-Bh#7n8X|QE~&t3nY5d3ZqN`3Xj`q{RA-UiEl
zrJW!RgAN`mAA}r=lgKNV<$Ow6cl?>W%bvpLYX46!e{t6LyI)Msx*f4%!x%~9$Q^Gr
zoJbuQPJU*PZqw)eZ1J3j)+B8qWyk}u=ji2OS&|=XmVSNt!7Z$Fa&PXYl(zM<xHl9N
zy|kEo>EC9il*_!FN01~YQcF0-Y<s7=5eejKE}rT=%WWHC8A$r+S}bRc$pHBm{pj6?
zz*n-R55c@hUz+#e8d8qzlsuv={+%+A;iME-k6Ohg9N7E){^kT_{->8m^?#bd&s9^i
zo|p79H2TrC|L_-vzkNw)20u67mNNa$anD92PL}ETCzdt*+trVfYtC<p%HHLt?;975
zII;7eKXP5tmE`(Wcem@^pY2fR-+CX>^ajuV!Ebv4|L{xOPfon>AOBl@Z|WXb<||iv
zHr!uD*Zul^qS5k94P}CgI$;2bNw;{OtJ|&|+V-Fxr)Rs^w!|{E<kfKX$%?z4P}|q>
zGjv7S=Dpv{d91%W;eGT?yVT@P%X(r{_qF^k>0_1Lx6Q<_9HPR)LNfC<mF<mlcI3RT
zag6e;T)9#yelo4Ug63)zuT|Wf;}hU1ZOb1x=T8Q%9NYeeX}rNs{GCRz^^4}Wo{S>}
zeIr)8l*``xA4`Rw^euMo8O!^vK8$<j?jJnEIOFF9Nq@LT@$*B>H%)sy#`eg5%XMtO
ztW$pXduvbFWzvU<fBY>K2AO6;U)#6(aeihOjvrh=Kb=Ns#IeMVC!SO0%JcJR8nKL`
z|KS<q`i<#Z_K(N(z1zC5G+4aU@{n{Id3tVX{yeR68&c3P8d)9Rkc=|i)NeuwiacLJ
z0gc)p_cNPQ8Ecqgxzt=Tmyq^PNpAj50~frPp$xGbbn_vnlKMBgAJFNldx=izC!Ptk
zKS=WI8=3ZyrP*_!{ZwKCiB9FU+IFssm{oW1`}W-nKZIm^Y?^UnZ?t%J$KyeL#FUH7
z3{5NJI;KBLe&iA_SS?^WH6GyLLueA0Eejj>AL8KR>Ro%Sb~O$k*ZV9O8(!}3(uJBm
z=E&)E?S2WmRd3@HR()-sdeyA=UT5Lhf+}80?uJd@jpv1UK8q*kcQa8IN&2Jvvms`c
z51vSP<&-Rw4x5Drko0xsB9s@gz}`k?4zmYl_Dl5L2llZtO&p3PW~3hi_DJgaG>t`*
zPj?lX!(;ktm&rH3$HsK8HI@sA4`rHTS!D5N<*l-v>t>j;N|;Ed-BVn9De$*T`q`5H
z6tkZHeoGIaEcyI5`-A*ma*EcM{4xED`jh`zf0@>k#}q&rjKYUc2a+ihwu2kV42A5g
zESnbV2_I0`S*F@3>E|$gPcuoc@Z3q#7g%?MoG>99&jd?`kXa)4L+tQcvB4WM+r8!1
zcO{-bAYOFJ`Xs+upOj8ge$t+FQ>PS^^v5!&kNI0~hA3sb$&2JS55VWOhekx_zK6#2
z$DNXYB=#m~@E-rW{|$R+^)z162Sc=s`q@i6%O2XUbKXO1s%+?Q4^7gaVCG|I+Dq%R
zhxY1MxrZj{U#!tt_tNNZw}&R_Pt-oYmqvVck`znVJeOVYH`q%v<Nqa6|NlhNUp~L5
z7Ppu7wCoeO_FwSeSm_E|;|@!fT^u6^oKx;#{{-S~ZhZW)atG7wpCWVK3Yp(7%g0@H
z*0Y}C^8*)P753YdCa|HCl7-$wI!Vb0kW&03Qt~#DA_8(RhX3qrj$gI+1I_mw)1Ua=
zyU3i_<a;&oJ{NkZ)RUY{J=4pmXJ!HQ6!94uwc0(OW?8V+?i^Zf_Y+&~apHZ3++PO{
z@T`@XA$;g4gqUZLtn!>7l&2NQIG3%Ug`D&6&iQxe{JV4h-8uj6oPT%DzdPsOo%8R`
z`FH31yL0~CIsfjQf0uUToPT%DzdPsOo%8R``FH31yL0~CIsfjQe|OHmJLli6@jK_=
zo%8R``FH31yL0~CIsfjQe|OHm-xo1sk8}RrIsfjQe<$bsyL0}Xob&I_`FH31yL0}X
zob&I_`FH31yL0~i|LOU6nHjh!Ju9CAC1RZHgE-~?OOq}~Mt;Mr8$_B{a*w(pVY3b)
zdDK)*j!5DSOf>7Kkms3ye4PKIc{4;`0h7G)cP5<vDN%kJ-Vwl-We{BlHC94s%c0v9
z;HAdOR&Jz$w=#u$go$S(>NdlQw^Yh@B~I1MlTu{nhN_>=wC~<W2Wh10)Zd=Fgmb6K
zy>s(DV9PT^kn>l*f6n{E|DF5hJSL>UwgoFe_ABT9gLD7Ex&PqYe{k+UkaPdRx&PqY
ze{k+UIQJi%`w!jD{Rij%gLD7Ex&PqYe=ysf`w!0j2j~8SbN|7)|KQwzaPB{t#kv1r
z@!;HlaPB`i_aB`556=Au=l+9p|G~Nc;M{*OV~=zH!MXq7+<zeF{)2P>ft>pf&ix1H
z{)2P>ft>pf&ix1H{=@&M`wxYG=l35n$-e*a?WV$Wy#Js$_aFX#?>{VGw{~T1&E^eN
zn`+mstyr*PL+#pilP;~8R#ceB|4gmO&6_-}V$tTcwQFkv3)WSysF*S>FfX{JV&kNW
zT+{yXdoCR3OgxZ*%Ja(ekUZxi!%Y3L?IlA0Uh9rcGX14VH_Wy)uQ{E=4)|{f*1oy3
zUw#Joe(Ie4@-MVs?(B*G|GOtX?Mv;63#_wJ3%~5XxEk9RXCD~oclO4ey>Vx6+}Rs<
z_QsvPaj9RFQGHA}zt4A3pYK7+VrB6ea_>w#_r~(h$-SkXoZQ>Vy`9|K$-SN2+sVD1
z+}p{$o!pz8+*|6G<k^AKeg%EL=fr<3uUcJugSC@>mL2mm|IW0RenL3`Ij}7Z|El-W
z<9}aCzIVR){5L=LH*9G7O{4FHj~c$7dX&p;Q?5_h+VN~p^VJ_u+PeRtPq>^H{V$u(
z6P@v_{$IlppU<BU&2z2$Yx1)5`SX_Bm#DM;Ug_lXPCoDC^G-hBe?I@4w5R*c=Vz`K
z=aSFsbSekaEt$E8*AAnc4@<sCKELIidyZIk{I|>J>GogQPv%?Z@0`ygPMns{v(Nqw
z^Ld#UF8)P9d_K?en;~BVS8-w7TrxM#?sD>ZC!hZxna|6!OMC?Q3+$<1p<Ho>9Q;e~
zsmK4E9Nfvlzet^vgF896lY=`sxRZlBIk=O9J308@K@NUid+X72{MFvHv7)H&Hv8cD
zO3k{>71va)>r)?6Zdp-RF@NLw1*dfxyi8fM{Dz99H`iWOv!?3CQ}va~x?8qXEY7Xi
zd}Dn)e6_-Ki)U99FQ{36s(whhvUyESMcKwR^NNaR-?GB4zo1aLsiwMO$;Ras3pd_S
z7lR)@0sJhln7w}Ein5LCH=e4`k@(Bj)!bBEv#w@x49_N|bVWtU+D)eqtJ+nmR88uq
te*6@rYH~mI)5?{y+L}45t7=ZKpD{!7Q&zR2;+oUsQ?8t=KECST{{@||T897t

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8ED7.bin b/ti/audio/tas2781/TAS2XXX8ED7.bin
new file mode 100644
index 0000000000000000000000000000000000000000..84e5d20474d182828148f408b451ece8a948b140
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8ED8.bin b/ti/audio/tas2781/TAS2XXX8ED8.bin
new file mode 100644
index 0000000000000000000000000000000000000000..d9b846cfbcabcf7257bd2f510549eec6477b7006
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8ED9.bin b/ti/audio/tas2781/TAS2XXX8ED9.bin
new file mode 100644
index 0000000000000000000000000000000000000000..84e5d20474d182828148f408b451ece8a948b140
GIT binary patch
literal 49824
zc%1EA4SW>UwLddEyF1xz!UiHq_{s($h7U0yAXJ1&NXUi{yCf(P(IgTGQ6%9b8WG4Q
z3@K_%z*;M4ZB%Nt^=aSxSw;L>1O6IOTPm$pY-?0neYLebEs7<{zW=#1vn(-C@T2e7
zzS-aJGBf9%d(OG%oO|xMH}^7W(xeGQ?QNSkjod`^O_C(SPom|MAG&GY($!TftH)0)
zosyq-0sk|#G<(v7DRc(EctMP|&F!O3CQ1Q3W$`~EvY>Wl)yhi$yy}XjXTm%BlgQyP
zU->CX*GbnAjXR9@T1ZjXEU832+6d|bBwB*vsn3?;tarJCJk)dkb~%jt9(l}(_!^z+
zyD6OG)!QXmZm*AkriyompevKoEUN~dOf}82k7*ajww1F<mZzYk#u?vXAITb}%K;b3
zLB|G)q`lKhk$0OTt_D3IDf(<BRSqaGLf(aVmmqI}zE6?$c7^bCpzTCCKn^)beu@lQ
zFLdBAWY7ajs%Qh+csk@Px>w#$vq8%bIu89+K|=<O3qYg49E`sWbQOKH;-tvn$wEHO
zwN=jrPL{h2Z6vhql=r*ZTDn2AJ!36sI6y;^wfNiQpj#9C6_r4PC^Do(&<Ic%?MR<P
zlbT+l$7N0FM%|BD_kjCay5nzC%C?Pdj(80{4cDsWGV--%6E*h~`t{t5IK3!Cr8~4W
zqP|C4&(D@_Dr$}>ZTj;{TT@4d+_XQ#A^1C0w3E;ungu?aTe_sbG9K{L^sqF*!UfJq
z-~>z@^ug6Y5qXu_Z+^c|ya%16KTqj;G0lLyvNtX>1F#Uj^YxctJIxhAA9qp2cbDMr
zGW0KNo=X6S9(={dcRcJ2-3MtaU~dc9J_@1#>H5A51;vBn1Kx!c>HntTAEe10j-b5X
zQNnOJAVD6QV%lGV{$+|JB?-Mm^793Mx5YpHVmSamiwr&6lxHqQ{QC_5cOB(#IgkK)
zuEU@OJpW||p0}AI<8!QcIUs*Tk!*uThx`$66*=HI7e3{LUy%H|W4PSmhEI9Q1b<Z}
zdA~bTKd88j_U<e>=m{|o_=N=7W%e7;lm*Q)_*K9?uIWYk4$)S*wG6(pZxo6Yw|NmY
zs2XLUZ7M}Hg~uZNIAwD#HRx?J$$KbS?eZt7<nzNu(*^%H*grzk1>OBj8+{v|dk6cV
z+NC@xw^6oy4W%_l9N|t3QC*LRFF6Q)o)#M3Nv$=IX$kp+PX}lcMZCA^dLikWk_KDt
zmV-)2E>X4$`pY@?-Q&<ZBuNj)li=@x|F;8wUlnA9Z*<TuVJnOY*zN+@{`<|5_}wVC
zvHvUnZDXS`Vt7s#>`lU_taiBy<cn{QY1=Mj10L&C4tPOVc@cKLOz@94><=BJgNCa3
zX(a1M$SwK=+~K+F<PK%4US#-@5kFk{rahFFZf`*E7$w2RY1~in->H|3;y5x0<1`@8
z5o5`r2PIk00WSQJx-*UbdsQpOE)?=<h&cf&;P^rjnk`~eP)QSX_K-&}Q3gSOZp1q$
z=(+Tga?vkAV<x2vd`&Xwi}8r>BBtx+xHXI-344wHf<E(4PzkX^5q)n<8q0k#beo$D
zoSkT!hPr2kY+*`ZTfjdrfo?Aq_U(}7$YH4teUc3M0SjR42Hg{Y^Sr^!Jpp6!S@3Z{
zC*0S`tVh8=QDylCne8x^ea8%aNbksDjL9HP<~qdZLDo2i?F`)qJaY|t^6%xa{97?r
zjQ9##UQG^qr(m3x3Y~-z--F5^*p|mcGve~M1pj^*e;vxFz|ZD(l$o;|{VZnxXImn2
zf@d6fIhM+r;|l#nnvbzlM3MCO%$QRw+A<B3u8<eJcrHNUd1pSJZj56u<W(@viZIV?
z5&V77e;cvf9@ML-k7FMO&Sc0?54>Aj{gF>m??e9*fx~{5030Xub5QO`1g=~Kye8BQ
z0A7FKA(qfa;Kc*4AM~>i`gsU=7s;>76^Jz{z#S;~C-L}G&O*CnjJYJ(pW~QDk-PyI
z+bVqKR?v}Qo84kw3{Z=RWf~O=IRo?rzTJ>@BVf-07AI^F@HVrY^6M-kwL(wNpij?X
zK6?u|@!;<f{QC?3D%!XpmlZ3MpwCa_umiT2KSDfD<G6|X{%GgpJ_%jyQ@j|TTj3+H
zNA^hJn*ody4StI;Bm4?;P%GyV%ZdGy$ESjrsp=(jjPW->_}^fRDTj!;0mLSZQ=cys
z0-qt~xJt9elis1EsWg^jEXHK~{fgf=7Q6-vJn&%pbXD$P#J?f%mFa5Nh&P1q=3u;a
ziCCEiU8qV~(g?vnSw*}OV`3rf`6u*c5oPAi)%8)vxJ9hOQwDq@o(lSH<Pbp@<{*qi
zF~{d#DrAer-w*s(d*eGFHglapknJMD|11@8eng$#kpW}-{D^~{i1)~&Tr1fBIj?{`
z%XK6qu<vw?2gL4CB4&ecwb^gktaET(>n`wUpMz2^F-^{eSQncMDIK(~_xguqATN1O
z@E-{MzeE>7hN%qW_h`&QyyCcJ#ViYsc*3!4DBwRwUh*mIaEB4QlVauu%^07(;y%Z8
z5&Mn2v#vQs<iG+Ka`{N<5%Vehkohe{rSXm2PRs>#j}Z?vR~!13ZhdoX;@C}*Vc}E7
z-Pk?|{;4X(_QjF~dF`u+^^-Zi!CvQ!T)LyYe^a=80MAdYM=3$A$b@yacsZs;`@Jl8
zpW&xDY@e5rBXK+8C)!A@@X^+v5YLlF{Dn8S1}RZrgjiLiI9lr>$K*OOUL0}_<^}iw
ze0dUl{5+0bm|LK*mPEZR<5;IROihi{S<~t7Jld&sLQY3bXIZBnDp!sYy&rPZQjQsb
zE0%nXZaRwZN$8s__#+~NHsWN43OPS*ts^I7aWw7EIV$`&oZ*E1oUIxqww4f_xW%Qn
zDN2PmM4<wILuaThB)NTlH7_$;Z?7WIbpSUL{ZpDcaz1PAj6{%oJHhijK_@6^B<tZq
z!~TO+QX-!@^^oE`MAQ%}payT`eN~z9q!YA++)?<92UVfl5d7hO@&OJRs1ouj%-8Cp
z9+J96y<g+{kV<zV%gGMN?IfvXuKw~tlF_zN@E@X5NDDWr6bwK{SuI<(T7OlN5BX+(
z0=*D&?;}m&jK3j1b%nIO4vx9d1A<YDhjUBCd-Njq2jN?9QmR@pOXSaod}Tsr{dGlA
zyRudxKkRC1%aHYO4k<I<aDnz@!GEX<T#e@&a+M`5K$}Lxk7gEoXLR_`uSrIXnRyxP
zD)V|y@M_dpFCl&pRr*;UX?mlg9P*bDp3YENo1vo+p6zAa#|FqTRSDI#AwHyww#<K+
zk^cx9dl(--=mWAMGG<W%`2xIVRJB?2p`QuLjL#C`kK<rdA-BF?;#_l5Q(I2DRN%{2
z^MDtWcn)&3258`+5aijXb*>#!AaxBXknwbM4J}Zj<3AnxucW^tOG(s=(2n(DtzAJ=
z&}tk-r=r8{8Hd|5Psk&2UM%8aTMiu(zDmo?Tuz4lhDG`NRp#T>?^8I}kPdm<pew2b
ztUuF&zYfESJC0+jQQyh5mLexOig6&Z&m6A{8Erc<J_LL`<Uo9ANwWOIwCf%r$Nn6H
zKbDI6s~K$H4)`6(my^?|FBfoz>AD;eal>!K4*5Q;<*~d#UnammCblk*9F59e&{k>1
zAMcF!{k+z1B^rl#_IEKaAeTTc=EXc3FZd4^>(9};tT?S45_CO~pYtFGk1dLf{IikQ
z;ya9aze7>crZWZ~`7rW_TwW&)KN7_aC<!9}?2(F$x~$itbwQ<{;D5Ht@l^rNP6J0v
zjp7hw3iJMfw889$3;pPZtTOKv@K`j~l9^7?2ZT$|;&{n(3UJ8*{O6#f65w*51Bgxi
zn%c^Z+>-f^Q0cht{1vE^VD}WzC<gEOh=*o<nCmMsA6LSE(wlpb11&<|W#oeUl?7s6
zejV$mgH^^_w?p|R#|O>@@E&aaN#rSfyYXHKm<J_M@W*OL<X#=h#h`l*{4EP{Hy*G!
z=vTyI;Hv0j9Q!o%Rsz`q=H8BiIX4>HDL0SDXd-Zm&D<Dr<kWc|S*}_z#PdRo-HTC*
z1piEP|0OJuQWf+@X<e0frGU5Rtc4!FDQq29=0LttBF`^EEH8_6LhkvXIUDrmvoD~2
zw8%kog`ZrCHbv0SJUvU9i#9Ikc8tii+ZDIqe-8V<*vDa?D1=^9U|aO}Y`LWiI!1qB
zv$4z<W1vXPfw@8_oQE@yOTZ%+JPLV!G1u#?r+H{Q7rL4QzdLB=U5UWU1OCjGu8aYK
ze-`H7vdCf3WE<pQT;I$46j9&ibwjRbw-D`S17{XudVyFguzlFZ2O*E9cqx+m1mqkm
zY!m<=O-V!?kpUYoa=B=n;25J-3jU*n|Ify}z5({1DsnlV_v?7iutmi@Ptke44D)=M
zhG!X`p`)0~d5*7yT<35O!u>O1Ox`}s=NsgGVID^%)RXs${*vocd7mb}`Ca$}^B;})
zhuj-}UW0Yeb%=EyF;*5S9Ov^P`&2n3<Q{xto|E^MF)!u4tv5;{o^h;VnBu)<nRjK<
z+!((+EaDbo8}D)Gua{qkG3gcj$EZ=7-pKMrfG0-h@%`nJ{%W~P4`WQe&%St#2Xc8?
zb`gKGAm1)p&9aKUQEEv!LB`Dd1S1xfI~9NYGVdevkIS?yKS}T(Yx3{OPty10td7QC
z<ZRwYW@oUR$jxPrz52d#C)OUE<FIbL@O!Z*r1)!M#!bGzH7oKLjGJ1-qXe<<&@Q<l
zo3U3Ua(Co##vW{4^SLU=wH(B$9>fw6(|9dM5o5ns#IlGMXU4>6-w^LSBK}22{GpFJ
zzfqTUz^a2RQY&-p8Fe-4CxG7(!GD~}G0Y=ti6`*oZ;IrPGWOLHd95GBn$#`6_s9FN
zR!WsSJhR1EGuHiBlVY8l6)(n&T!OXk{&-amdrGkWt-`wZA%l*iMh-gacpVM?+0EyP
z^``^lUoqF9D(o3Yk(qA@*$L}ZOSi@x!1LBxlD(t>wDjTT^XiX1o*YsN|6Kp+iYzjJ
zAMPDRe_D%F^ABY?^2;y3%&^F@w?v!R--&Gp!*?$riYtrOhof(@^(Z5UN)s_AoZLPV
zi9~6|ylZATfl%6i(HmU{Y2fp(ia$_L+V<^S9J5za<jO>H|6#vC^$nfDe3Hqrf<F(N
zrIXG-|9n%1Izota%$~pE+^d_aCjyj=l7M=6KgDm~zQgnK%dZIjDbDBduQcwB5ANkM
zd~Vh=tCJhq!X?@>PlTtUA53HYl^4tE1=lW^{>n?c>U+8iSlphTosS82vmQI74%l4I
z{S$p;{ul}I<y)YHaYA1!z|XmT2hBBg&A%JAZ{O~m^4E#l{lD?Boq~HN9ndo0n>OLd
z*q*F)nS1@2ANNbUdBDQt!m=08=X1Si>luCUm&_}+Y(X(eCYt?ULA-B`UkLJtA#7(S
zlmsmuMJCkMb-V~1Q~jN$B7tHIdG-k|K!^Y#0))un&li)YLay~>_J0AneRTa@PixZ}
zZtT~;t5bRU+do?I-nK_xn)UmqJ_7bdD1MY-U3WH>AA5G?c|Cv5ZR+`9ZtBU}!0!f_
ze3Hp6>`tD0i+*Y8Tr=vtq^g#mIihl@u)gFPiTCBCriuz~OL-FpD5f9sv!Uvv4I6Jy
zXm9+*A8I$=k+6x&rgICf*!W<T*0^EB_nGbuuZ8b!&_+D7@wqo=HXQN1RR8#|w{2XI
ze*dNie(>)4%N7mQYZI@izpV7r_2akwSolGl8tdgJjDg;;(9Z7#>o4p6cEhZirS+Fz
z^%E`)TOLi^So`6EO^J8Dz47|sM_f*qp5X5}eg1vHlzs`BUsPX$f4pIjGt%2vq%Z!v
z9eGtcW4(PzeSxn^-a0X^xCkFiP_6g1l;EYs>x$pJfAhm5`MGe-)EA!a9x<#hSnb|F
z4%)n6i1592KYq9T<_pvQ=yVSnXcY^uFW9=Djk#d+lwZBbPi`yhk*E^W=v~J!8eH(2
zRZa<mA6Wg4?74FOXC=pe*p-tS{abPv<&!tZPXDClEtwF+5M*oQp?B2_{{7&Ot^=zp
zzV(;+C(!xzC6_XtZmLN?6&<PHhdU@P?e)*K$J8L?kb;+=v_13p@pwq7p`YG7n$CLd
z7N(;Ca`t=Qp5Zs2v38Y;-#w@2cSjEJbKPH8j=t%cRl83Y7B*c&JVPU%68w{l@ffLp
zGrxY>f6i#2!t3k*d;0B~<wM%tV<MrNbn&iw-U+46oUh{P{`AN&t52Q-3&gy0WbBXU
z9>{v3<vR~NwESc=r0<qqnSJbqd2x6O{{2;QEpNMz+cUo3R3HCy?d4;Cd)v+fBlvku
z_b%nWmZ$IR3s!RBdDE@($e_@U_TT6Hx-XcilUFUB2>t_9f^MFy@44~*oZBB>CW3T)
z*`%l)e>P+_+wqv3{oSYy*yf%Op6P!6=$7t3Z#V$ZVYb`aN8Y;Nmihh{`MGvn^A+E@
z_paad1-t&}<SqKh35Ny$WFsEkc<>e97Wa!7q(uj<V&V4%yYYjyqxIxlUgM|Lwl5g@
zemKY~pMx>~vta+2I?ePE#|JkrW*g@BTQ|nVkb%!F<0Aih_w})G>74X8=-gdrTV?(C
z98Wg&OBLxomjMr~zc*~^Om2Csg_3J`)<^!bBW%Q;IvQyD-&0rq4T|5zL8-T$*ghLp
z%~@^wukaJ3VLM3eSTq1R6ep2W`8(s*zmjM1<M>>W1iQ_+yX#qRam&Xvc=brZ<It^d
z)_<1NKa}v~0L|jh``PkSF1j{;9Z4zoM4uy;ghWYrph>=e$IJAM1MAr4<gD$YZQuM%
z6lcLBL{DE$@sH19p`^f(Jxo?GlamTL#%y?}q5%oy3NEgSJxeSfVjT$nscJN5jp_jT
z7d;-2`1n+UX%CrY5o2l2_pc@C&=w&h$|b*(`ZJ!;;)>zRxrF?C@9t|(kmi2!jfnQ>
zG=46hobj~apQh4}F8|)gjDO3*;52^LZc3cGb@c9tpvgKN^U&h@UtPMB9J78)RQxVK
zy_au$`{>cX-{vYyIVMfIWUO@I?SE6|-navnsCQo!?r^<QeYG`CKHL4PdgV_k^Brfs
z|EQ}r{y}=;(3^;PM*JTHF3PH(k^EsW?%;t(9e3ydj}~KRt609oIyLoGf9bK(Z4W7J
z)%*-zSX{gJrmP40g2|qpZ&;-=drHPbYr8JzcflX4<lc1#ed%?|%gZApZ&TRcIA=%B
z`wGV>*Ro~Hq=HA1`zoleK=GKx$vHj&pOV+T%{hMpXk}UcH$>$PcH-}3imqQ&pZR1O
ziD(-(>xEwS-t|Bd#!2sD<(|>J-)zIQr|<f~lT0&qUJ(3;suVjvM8~G#k4M-adE7FL
z{g-XZ?><k}XI2^iLEN8yOL+n2>F(|OW;@Q$tithw3;3tfFqJr#Sn<Sl++BHo9znwv
zQ{;bKBOSl-Tomie+^6qu>crCEl11hSNu~4?b4%mrY7yIzG7X{hir9(-l%a-w-GwOP
zd<pqgYJ1SfVoqkNA&TZwv&mROT0beF>GpaqcrQjtu_`p<A*PbL*ShY}=;Awxj@u_z
z2-JU{#Mw78{2@cN=0NKyMHLd6%xkrc3=12eTlszCuK6E8v)vZYn7%idGCO1G03J5<
zA~Hk6%NWM|hl`JF;svXTOvn2J8hi*%(6V%4(SADyF9z<|Yt}0<^ce0naV&hXze{JU
zR-eNs^0nHzH4|>plTCP4FSugBJy)1C)&ayz$zAa2+weRa&)s-(em5Ouf#5%)FCSu2
z`QVAbmyYW){-9B)ABnLporCf$7T6oe$YC%aB>Wt0_d$HDOydS)i5c#Lfz^{bK22lt
z<kMYwM)#P%(rL)e@6kTpY4+tT;zOB6Uly41nR%<IXV^4DSMG6S_&vqc7lD48;GZe@
zPc-2C_glILW#Q+)c|3^kg~xe)$shASr!W1V@;AtQa-aMt15x<!X@4?w!hUcy8KIEJ
zD(j}%d}0hJ)uyX92>w~j-_=B7RJgX17z=DWLQd$;#M5o+5IT$Fc8DDwGd6gFM!l!R
z{4T@u2gHj`0gv|?@c2{``V;=788)SW;6I8{y)54<BSc9X4OxV|lYo3iduT*-`g>^1
zfAn$vhof&Y4cy~<_n)wbR!3t5e+Wd2sgJ$1Q|zH_KkYrV#<Kdp_Rs|Xu|__2vc0rk
zduT6zm3wG{|G6riaxaa(zCAR-f1LXHy)@#plO&n8=DF;wuVF9Ei2vsa`#(xzynKF7
zEoLw63DL%X`A<3XW?0DVcSwlr;27EOv~maQCnMfw$HpHscQD-kaWdwupz-Z6$GD@$
zeAZEHe&7JE#N#%x5n^a0WuSFR2T5suk_vuA(xkN{$$qgH!+&-*`mb2~fyR55F`oF{
zv%r|x#CrwtJ{MXj)SZw(-BXLHdwMQ)=kpmErNTLvW|+7Y&MaDDwUgId{lxn;vA+%)
zkXbD>Lipg}2r*A0S>-uFmY$QIL-=DaXeRsoyM6xMKL2i?f49%S+vnfy^Y8Zgcl-Ri
zeg54(|8Adux6i-Z=ih}N+2`Nw^Y8Zgcl-Rieg54(|8Adux6i-Z=ilw~@Amn3v;X$_
zcl-Rieg54(|8Adux6i-Z=ilw~?>oXq?6J?k+vnfy^Y3Jzf49%SlYRc(KL2i?f49%S
zlYRc(KL2i?f49%S|DT?J7ny;BQZsVMUnq|jZ4jq?A2({EXXMij*Z@*JLVCbbLIw;W
zdH7^i^hnV4k2ByC$@S!aJjnmiyb+==giBuZI|EPqgeWH&?+9Rv(}=Es8OxxwC9v&M
z$Wm!$D_2wh8=1o$vO#AJV72h#b!DPniZM0IB;^~qq2i;H?YsA~K{6>C^|j|N@SMqF
z@7#FzTlx$V^!%0YpY#6kKXc!l`-C*u@?c4mH2eO8egDC}|3LQr2mAhmegDC}|6t#L
zu<t+E_aE&05BB{B`~HJ{|G~chVBdeR??2f0AME=N_WcL@{)2u0A#C4&u<t+E_aE&0
z5BB|sK4JF#2mAhmegDC}|6t#Lu<t(@vB$puVBdeR?>~@z|G~chK=%Cy`~HJ{|G~ch
zK=%Cy`~HJ{|KZ>2{zKls`2B}LWZi%Gc4OXY-hYtn`w#!R_aBy2uUuADS-ZM?ZB_Nk
z(s@f)SFNlbKe2R5e%=NA&(zZFNfV}&E~s5uwX)JbuexGs>BK4iIe~ShYsQym8~%^q
zQ=yo_#2x7`ZIv*m#&a$*#IPUxUL5T2G4I$U(8rCMZqy}vjOiSHz<)z9_s#A7@{{2A
z0kikZztDcUy(j+vcTarEm)aATvCc}$`?CAuN_1bG$3TCdy*F;}joW+U_TIR?H*W8Z
z3;UuB@8!Zdy}t8%eGiaskZw3h?mfuLy|KKrb8lfMJNLG8Z#(z4b8kEMwsUVg_qKCy
zJNG6#_ZIdgadzN@Uv97OS+O5W%2!lfW$vV(V#oaCzmx5yUngA$J+Lnf{i^rUV}D;s
zzIUei{7oPF>Q^`ZrosEnU+S+*I?QF$#48imx9{$5y7a^G>tDL}BQ9se|I6m{L?=C~
z|Bq<I=JRL5^K@bVNMBYyf5v+I5-{`cm3BUF=ks<xZ|C!U=kvcwexlEO{`s8yPA8w&
z=y(pMnL2Y0tr|jE9~6F(e16?KcN{YP`0LB(>6TwuPnKKc@5tvlPMna>^O*e_^LddM
zt{C`yY(CHWn<ifU7jt3STn4R~*=gtVc0T`ana_)}OMC?Q3+$;sCOvkN9Q;e~smK28
z9Nf;qzX;6E!R;K}&cW>*+|I%69Nf;q?Hv4HAO}CAz4gdx{;IB7Q<~p<n|<J1sj|AZ
z^s@5mUhtrF!_u14xocL<JE6(I#nQD)t}0!0ebvR4*Op&>99||>->|OqlI+sjtLtL%
zD<tMyFtfB^UgfIe@RSm%_S(wQ;x*UK$uF3B!%_==R-SZCWku=2HA_n8uequwia&HL
z<XKWWbJd!q#cNirIS$Vf^oy%2uPLakuAC61vsNlvT3Wbr?TOv0aFj{q<NJV*nJAS{
n=mS2bL@KVToVB97@<jNwX+oaj@};GhouHo*>2&S!Rsa4Msu`4Q

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8EDA.bin b/ti/audio/tas2781/TAS2XXX8EDA.bin
new file mode 100644
index 0000000000000000000000000000000000000000..d9b846cfbcabcf7257bd2f510549eec6477b7006
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8F40.bin b/ti/audio/tas2781/TAS2XXX8F40.bin
new file mode 100644
index 0000000000000000000000000000000000000000..84e5d20474d182828148f408b451ece8a948b140
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8F41.bin b/ti/audio/tas2781/TAS2XXX8F41.bin
new file mode 100644
index 0000000000000000000000000000000000000000..d9b846cfbcabcf7257bd2f510549eec6477b7006
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8F42.bin b/ti/audio/tas2781/TAS2XXX8F42.bin
new file mode 100644
index 0000000000000000000000000000000000000000..84e5d20474d182828148f408b451ece8a948b140
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2XXX8F62.bin b/ti/audio/tas2781/TAS2XXX8F62.bin
new file mode 100644
index 0000000000000000000000000000000000000000..84e5d20474d182828148f408b451ece8a948b140
GIT binary patch
literal 49824
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

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2xxx8C70.bin b/ti/audio/tas2781/TAS2xxx8C70.bin
new file mode 100644
index 0000000000000000000000000000000000000000..2f4c90fdfd4b84602d255ff1a587b3a8c993517e
GIT binary patch
literal 1756
zc%1E&&uddb5XZlpyu|owA!wjKESOdgg=$Gmqp7u!YFa}}s1~U`RGwPXpV~lcQR^iK
z@ehblNIZBGFM80Ev|v4{P@x{|Ng;UBTR@PCX`kPHn_z4Mtvz=i^LBRjGqbb1!v=%F
z<AC#X|NHO1Af_M$*aYIgKQ@OFqc;uzC8Mu5h8?yFD;TtVnK{~pXFEZ-zBiV*9^Yva
zfZbkDY*Iu<WY|Ti*U{qQJW$^O?_QhEu?Fme`-e?t$Q<4GmF)mrI>O3UmE@mJwX`3+
z#xN&1ro$o5d7BmA0_Uq|PZb}6;@fx*r{{t8FNz7{rw4^~BC>Y^gEheABygo37-Eib
z<~IVB=Q#G?L#-WiHnMwwY1(G8z-<PZ^+Hs=gP@yeRJ>>}J#BuS(q0YC&FlcVbW<P@
zaI>#Sr!)G}(g!Oq&8IwUM6@vOtmGflaiHtyi?6NB?AZ8&gvB{LxKZ?Rc%@5{`gu4S
zaX0<a?`S>uBrNamdACDK_qU#9DQ6pEkEFB>_6|!4%w6zHX<F{fOF5!nd@H3c(w~yT
z5U&|`6i%15l_YamTm-V*c`gU6t^#?U?D{%jnrgd5Km<fU1VkW<kO(AV5-<sv1kBuK
zvG(MuE>;coMudyH9{p?A2b7&fBvK-^WnDciTUU|Yy4tO)a&<M7m>eD(nVGtJYb-Ho
zl)T7B@l`ZhLf)R}tTF8~eAwKqmv25<Vqq<yVFT46Cd7nQx9Ucn5GPMzt+Enp&NmP>
j*@FIw^POTrEEKL;vf4kaVh(SJf95~pcWo8l+-Ca&NOwNS

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2xxx8C71.bin b/ti/audio/tas2781/TAS2xxx8C71.bin
new file mode 100644
index 0000000000000000000000000000000000000000..2f4c90fdfd4b84602d255ff1a587b3a8c993517e
GIT binary patch
literal 1756
zc%1E&&uddb5XZlpyu|owA!wjKESOdgg=$Gmqp7u!YFa}}s1~U`RGwPXpV~lcQR^iK
z@ehblNIZBGFM80Ev|v4{P@x{|Ng;UBTR@PCX`kPHn_z4Mtvz=i^LBRjGqbb1!v=%F
z<AC#X|NHO1Af_M$*aYIgKQ@OFqc;uzC8Mu5h8?yFD;TtVnK{~pXFEZ-zBiV*9^Yva
zfZbkDY*Iu<WY|Ti*U{qQJW$^O?_QhEu?Fme`-e?t$Q<4GmF)mrI>O3UmE@mJwX`3+
z#xN&1ro$o5d7BmA0_Uq|PZb}6;@fx*r{{t8FNz7{rw4^~BC>Y^gEheABygo37-Eib
z<~IVB=Q#G?L#-WiHnMwwY1(G8z-<PZ^+Hs=gP@yeRJ>>}J#BuS(q0YC&FlcVbW<P@
zaI>#Sr!)G}(g!Oq&8IwUM6@vOtmGflaiHtyi?6NB?AZ8&gvB{LxKZ?Rc%@5{`gu4S
zaX0<a?`S>uBrNamdACDK_qU#9DQ6pEkEFB>_6|!4%w6zHX<F{fOF5!nd@H3c(w~yT
z5U&|`6i%15l_YamTm-V*c`gU6t^#?U?D{%jnrgd5Km<fU1VkW<kO(AV5-<sv1kBuK
zvG(MuE>;coMudyH9{p?A2b7&fBvK-^WnDciTUU|Yy4tO)a&<M7m>eD(nVGtJYb-Ho
zl)T7B@l`ZhLf)R}tTF8~eAwKqmv25<Vqq<yVFT46Cd7nQx9Ucn5GPMzt+Enp&NmP>
j*@FIw^POTrEEKL;vf4kaVh(SJf95~pcWo8l+-Ca&NOwNS

literal 0
Hc$@<O00001

diff --git a/ti/audio/tas2781/TAS2xxx8C72.bin b/ti/audio/tas2781/TAS2xxx8C72.bin
new file mode 100644
index 0000000000000000000000000000000000000000..2f4c90fdfd4b84602d255ff1a587b3a8c993517e
GIT binary patch
literal 1756
zc%1E&&uddb5XZlpyu|owA!wjKESOdgg=$Gmqp7u!YFa}}s1~U`RGwPXpV~lcQR^iK
z@ehblNIZBGFM80Ev|v4{P@x{|Ng;UBTR@PCX`kPHn_z4Mtvz=i^LBRjGqbb1!v=%F
z<AC#X|NHO1Af_M$*aYIgKQ@OFqc;uzC8Mu5h8?yFD;TtVnK{~pXFEZ-zBiV*9^Yva
zfZbkDY*Iu<WY|Ti*U{qQJW$^O?_QhEu?Fme`-e?t$Q<4GmF)mrI>O3UmE@mJwX`3+
z#xN&1ro$o5d7BmA0_Uq|PZb}6;@fx*r{{t8FNz7{rw4^~BC>Y^gEheABygo37-Eib
z<~IVB=Q#G?L#-WiHnMwwY1(G8z-<PZ^+Hs=gP@yeRJ>>}J#BuS(q0YC&FlcVbW<P@
zaI>#Sr!)G}(g!Oq&8IwUM6@vOtmGflaiHtyi?6NB?AZ8&gvB{LxKZ?Rc%@5{`gu4S
zaX0<a?`S>uBrNamdACDK_qU#9DQ6pEkEFB>_6|!4%w6zHX<F{fOF5!nd@H3c(w~yT
z5U&|`6i%15l_YamTm-V*c`gU6t^#?U?D{%jnrgd5Km<fU1VkW<kO(AV5-<sv1kBuK
zvG(MuE>;coMudyH9{p?A2b7&fBvK-^WnDciTUU|Yy4tO)a&<M7m>eD(nVGtJYb-Ho
zl)T7B@l`ZhLf)R}tTF8~eAwKqmv25<Vqq<yVFT46Cd7nQx9Ucn5GPMzt+Enp&NmP>
j*@FIw^POTrEEKL;vf4kaVh(SJf95~pcWo8l+-Ca&NOwNS

literal 0
Hc$@<O00001

-- 
2.25.1


