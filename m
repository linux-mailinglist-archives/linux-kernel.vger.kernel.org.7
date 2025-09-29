Return-Path: <linux-kernel+bounces-835887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCECBA8438
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B90189C518
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFC482C0F64;
	Mon, 29 Sep 2025 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Fxcr+NqW"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30F82BEFF2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759131511; cv=fail; b=H2y9MjrkI7VMOjNwGGLh8pno5S35PrWoX3Fq4jNQHxiwVtD+1wU06RtrPtf+q8i5s1XMgDJlBOi4olzehKz+j7ssPFoVA/TVsRJgcqd4ecUJRZB7wigR+aJhJRQpQzZoU5Ay3092iZqzM1SLnFe2dlHSoRfgqGRfvYfQD4FixSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759131511; c=relaxed/simple;
	bh=+TK8fi4FMmql5A5ThC5T9wJxxAIe+fGMXEf+V6U+N+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjZv5h70df3P1eoPAw+qtlxWYHHAiFJpChUSN2Bn8T2Zw8VBVpietjDff0cjduNkixqDHcsdxq8rC+oBNLvd1NZHZzsMxzryHQkKjQUd50OUKVr5PVYGaYiRcRgnmTmi6Np/HL1ccuqQa0mRshRNTM+jUoUqPQu1QN13KC1/5uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Fxcr+NqW; arc=fail smtp.client-ip=52.101.48.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLhdf+ypBqUkivfnOORGf7kSBRqX2vS/EumFsYdW/z7fmYuLuAII9avcgraaRXzKdPzyKnF/TEtbspwyVyv+1WN5TIDHhIjuy0H/j/+J3OjV9KuKblkcG5ZGBYVpZIPyKiOQDrUlXyF9C5WFUwliq3PQqDxiErUsdW/z68qoiZsrHjCpewBjzkOm7ILOqOThzsMHvI/g+eLCXgPk1x0RndJ+fnk82rwPMpVROGJSegRdEvFX9TdhkHvFF62ZKMvHD4MpYsw2FK5uUOFk3ikqU2rVzwcDgK8IpbWNTzm0FsqobdySydiW6ZcLBLBbYNBCyeqjeiKIJRec481jSENJvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwcI28FOY4kN3OQcGrrreoo3w9LFqikCXLdja2G61WM=;
 b=QE51vCxFMo2R9uEn4ktdWA8IRngWFaQ5/c/hLqHNhBFVkEw29VFNEzXNGdFKpzvkElXIc7cYrOU4rdSDGJvAyBoliKXtwfeMHZT0mmQopDj4W59ilqpWWJy2DcUC4PCRI88Rs3bVCClmGDNx+FKSfClqAv/ykZic4F9QJqHuYHE0dGZzh2Ug7G2y0F+ZZCaKlvaKVLZNOyG4dUF50wJ9lrEfjEkMGiLipiJ3UOUUVbmC36IYWDU+ddGecj7UbpP53jN0NWWnF+oDzUeXW49/CU794w6RTrjgiH2Fq9Q9rugEA3UJx1JbSHAGbaz/OPJH5EGENeL91oSsoE04438IjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwcI28FOY4kN3OQcGrrreoo3w9LFqikCXLdja2G61WM=;
 b=Fxcr+NqWNWa5znACdzC/u/NJ9tAzL0+HvIUZbCtf4bXlytsXpezodJES2DTmfCNJL80ekZPZYPU4LJPE9cF1b01v88654eJP5UKmzivpWsY89BsC6G0hgKlMsyXEBaxAnMhGzO7koyfgqT39Y02utk7gXPYcC9cRicd/WOGXZHA=
Received: from BY3PR10CA0008.namprd10.prod.outlook.com (2603:10b6:a03:255::13)
 by CY5PR12MB6106.namprd12.prod.outlook.com (2603:10b6:930:29::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 07:38:25 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::27) by BY3PR10CA0008.outlook.office365.com
 (2603:10b6:a03:255::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 07:38:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 07:38:25 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 00:38:01 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 29 Sep
 2025 00:38:00 -0700
Received: from xhdharinit40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 29 Sep 2025 00:37:58 -0700
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>, <peng.fan@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH V2 2/4] mailbox: zynqmp-ipi: Remove dev.parent check in zynqmp_ipi_free_mboxes
Date: Mon, 29 Sep 2025 13:07:21 +0530
Message-ID: <20250929073723.139130-3-harini.t@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929073723.139130-1-harini.t@amd.com>
References: <20250929073723.139130-1-harini.t@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|CY5PR12MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ae417f-ecf4-437a-86fd-08ddff2b2ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8PuEjr9wtL3hLwjAlQTMNZdvV+qEeyOt3iEmeTdwion++JNdc/PmSzXpSg4U?=
 =?us-ascii?Q?aa5yHTzTYjlqqLONgGr+L2nwxiXd6kAFOYNF+valIFHZyd4UiYWaBKNIL+F5?=
 =?us-ascii?Q?EbJNi1iyuaVSeDYhIHDruFmPl4j83A4uK7lY4Iroxq8oT36BTfUUtzrGx7Un?=
 =?us-ascii?Q?kJ7m0SOp6CHV7toRueoO8NmVZc47Tt6at4JASI0a2olZqRjSHiYvu8k/mKWv?=
 =?us-ascii?Q?lXkoZs4jPeIy3+6L2moKRrMe0GuQB2pgB829FdEPjO2Tu5bPMhT7csk9Sa7Y?=
 =?us-ascii?Q?hktwqBmerVLdOv8tKCXE6XgQTF/lwWGPX8d1hxr2Bt4Qwi0ALsC3gEqkqDmE?=
 =?us-ascii?Q?Tc9LxNe3r8JMPQfi3JHZp6j4qeIfsm9Z6qPWNEcwUV0AdtKLlJCXUHE5eGIs?=
 =?us-ascii?Q?t/CpQnqlbDIReQqUVhPXKDM17xlpH546LzhPpb3QpuLLU5Svnzj5gvc9jtyA?=
 =?us-ascii?Q?LS7+wrNXvG21UbLJXykR9oGto1CWNkWh0Vd45X4LwGGh8IzPE8VZZtPkyBBG?=
 =?us-ascii?Q?K7nBmvnmPJg/WzwNPuWuvZCzwfNyM3k4qHsEePGsO202/LBuBKp8wSlQB6a8?=
 =?us-ascii?Q?RcgXsk0KpNu8OsfVEN5pls/dzwkxJyk/2ZEh72ytZHmEhXT05iCy/uMJtj6I?=
 =?us-ascii?Q?DB4Vp8I+us1IBX0FDZd/UVLrg/uhpM9+Pooa0kwFCaETRzwAJPP4UhVm2rPq?=
 =?us-ascii?Q?sE4g3UJIBz1jqXI7HNGDcBCDMzMqM4HaxmU0VdOjSMjxkK092dbrj8WysOjz?=
 =?us-ascii?Q?QRfskMS8WBMcSYI5PB6F3+UMryXI5y5zWph5qqEq57LD2/DnMmf37X/sKqxH?=
 =?us-ascii?Q?5fQkhHoCoHrdn1AaY8qF5NgaUsc1cv+IQYGV+Vrdx9+PCW3ONSCp2aefY8Ac?=
 =?us-ascii?Q?hQjWTqdiKer39vjft0/M1nZYtglMyAbrJQVQPCBmSRyoKZTrLiv8bAcgneSM?=
 =?us-ascii?Q?Xph3iRBbCC2NJa+c0w7WGa8YSZCmJG0A0cFvFiRrR729gJmv08JqWO8ayOKD?=
 =?us-ascii?Q?Gsrzk2MlppMKQVNznMIues/JVCFXMLqlaEzA+l5vIE/iMofDK170zyem2JOe?=
 =?us-ascii?Q?91U7B353B8/pZbKgivexDiaKT7q6TSiD/wqO/Ni8y3Z0vJWocbPAklHkC5+b?=
 =?us-ascii?Q?jASeOzNKF8eti6R0nCYTkBmlm1swWVuhuF1d6sEU5ZfU9zZl2pePaWL/fA0I?=
 =?us-ascii?Q?/9l8A66EMBwx4cm/vjLA9zOkmTpLyBymVml8F3dWn4LCkWadFPwfddzhwCwC?=
 =?us-ascii?Q?Fq8aHSiTJx7QhITXnrVEs0PXkvOlycLjn9seR2Ix1xTGfOSHjtSObhz77460?=
 =?us-ascii?Q?kEZwH1e4s2+A/EzX8h1KdxdTMy7nnHMRDTJZ5gc+4+VHRBclfQZVlZCTxk99?=
 =?us-ascii?Q?sRxVqLD+G9W4ZSRuFeA2UPPexYvL4f34MNBu/dUa4C2JVlmPXlM0leg5qaLj?=
 =?us-ascii?Q?GnGga4sa9so5mjGLXpD5wrbLvrBjTdYYNfCunuaoGTlpHIq4Tc56L7G7s7AQ?=
 =?us-ascii?Q?6iquYi0TbN8EALUFS3RUvKW7dZcnSdzKGmk8/x0mXInaZLFO51NPJW8oiBDz?=
 =?us-ascii?Q?zDpjQ5cjuAtjjJq49gQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 07:38:25.7053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ae417f-ecf4-437a-86fd-08ddff2b2ce4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6106

The ipi_mbox->dev.parent check is unreliable proxy for registration
status as it fails to protect against probe failures that occur after
the parent is assigned but before device_register() completes.

device_is_registered() is the canonical and robust method to verify the
registration status.

Remove ipi_mbox->dev.parent check in zynqmp_ipi_free_mboxes().

Fixes: 4981b82ba2ff ("mailbox: ZynqMP IPI mailbox controller")
Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 263a3413a8c7..bdcc6937ee30 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -893,10 +893,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	i = pdata->num_mboxes;
 	for (; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
-		if (ipi_mbox->dev.parent) {
-			if (device_is_registered(&ipi_mbox->dev))
-				device_unregister(&ipi_mbox->dev);
-		}
+		if (device_is_registered(&ipi_mbox->dev))
+			device_unregister(&ipi_mbox->dev);
 	}
 }
 
-- 
2.43.0


