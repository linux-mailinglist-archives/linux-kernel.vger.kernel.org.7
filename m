Return-Path: <linux-kernel+bounces-781125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D4BB30DC8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 06:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CDCA601206
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 04:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167D278E7B;
	Fri, 22 Aug 2025 04:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FAB/dtbn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448BD266B67
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 04:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755838668; cv=fail; b=bxR5nZJGTe99AeiG1GVFB0sPUvQXxQAWKtT+D54H6hji9YFB+hjpi5NTMa2qp5ac1c3S8QMWJBRDFvK++H/pMB50/g4A5m6mZLbdm6Xbj0OCdnjAkj9kVa8Eg55BpaAc4WuzFibLT+t6jBxjLEUqEBrwlgFLvEq5qS/sOSAGAeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755838668; c=relaxed/simple;
	bh=BqR+kvSB5HoRDVGyBoP4mSU/tUG8rHC3ijrUOQ1ObB0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RiHDOYbIR2J2zlA8hRnSHDM3YTJRPe1+3hGfqdGtUKSJKhvar9259+ei++TxYpbk2ehvi8O9vUFJX/K8BfYxfPkIDcLEMXDtSra74tkpS7l0pgkH/jTHgOTH0LfHDEw/G9ANldW23xBowYcWpEM4Z6WTY2qTxeiPiTPprZ2mL+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FAB/dtbn; arc=fail smtp.client-ip=40.107.93.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8rJYSnqPPEmton/DwmQB6o+pb0cEe8h5QqZn7yk+eMXyJvUgWPcgCwOBhbXvLO48klV3kQaWdzYMLJeHizQwBgYIpU8ruJoDQtXsLUyDUrJPXjt7nb1nfNrtJQUBGVR99gB9qv2vdKQIhw1/x/UjFkzZ0LzUWkDkyGujU+bYkyNcdWoajdBZfvdxmY1j7yFiu4orYC/Ymbrc8z6k7wnSkI9YO3eZSgtzhudMiyx0clTrhJcjGNYhoQ+qG0HAXKUY2VvXhK1pAIpsD9KaMBcVEA2BDxamX/2rZwwJ1iJygxR15Sx1IadWVBJz4Ym0f/w+VJFf+RPko2nvCLBpOVTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVaXdPg00eE0Jg/sZmunFFWiOZhrBEbEUFiMAcYPr1A=;
 b=OeUm0xH5vX8FWBQqBKA6A2YCt148o75wMTdU9/glUe92MkKlLDrcy7TbfFyJDcSjo+fCKR7hkxJpIi5jQoYCR9FI0RwDZDqUzAZGN/Pi7LTFh5k+ef1LHabPGePjwjPp+fET+O3z3t5axiNwfOsHQ8QeXclUBbOJ4LWHWytHPLjBKejfBUFTF9w1yIPDbtQJ9fiHqoScF+NO8ph4kfpNY2oqoKp10+xH57l5gPQF6ZlcG+gN4QzJ95KnOkYKwiYvJ7pnozV6RjA2Ntczc1K1hOFBXSBIDPw+XRVDejKVoiGwVLgGoewqjzHSdFg1ZO5dHpe+Wbfd00KZJ5Vvu4epEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVaXdPg00eE0Jg/sZmunFFWiOZhrBEbEUFiMAcYPr1A=;
 b=FAB/dtbnKzE8q7xHcC4xJVpPGGtFY/niOlqK00HCzu9U9kdHwUHtl7fPDjfBrWIxqpAk6wZ7tJZJcqqX71r6/Ds2ULYcBMQVxQc5qIMuTdYOQP0PgyZ+73hTG59n7BUj0+G1FppdC3CgkYrty+qdsK2OiliJd1S+x5OFSu/buUw=
Received: from BY3PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:39a::34)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 22 Aug
 2025 04:57:43 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::8b) by BY3PR03CA0029.outlook.office365.com
 (2603:10b6:a03:39a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Fri,
 22 Aug 2025 04:57:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 04:57:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 23:57:40 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 21 Aug
 2025 21:57:39 -0700
Received: from xhdharinit40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 21 Aug 2025 23:57:38 -0500
From: Harini T <harini.t@amd.com>
To: <jassisinghbrar@gmail.com>, <michal.simek@amd.com>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 1/3] mailbox: zynqmp-ipi: Remove redundant mbox_controller_unregister() call
Date: Fri, 22 Aug 2025 10:27:30 +0530
Message-ID: <20250822045732.1068103-2-harini.t@amd.com>
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
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: ee8541e8-38e2-40b8-276c-08dde1386da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3UnWwOeQAqsyy1lBi7Wg861uY2BP/SlnEgkau3w8RZBP0D045/Y1Tsx3h70W?=
 =?us-ascii?Q?FyL0U3JgEBM+R9R8iEIQuueRqhuwoZV7q0AaksulhAPo/67xoVTul2hyRpmp?=
 =?us-ascii?Q?UJW/mLnDYwuyKK6elpk10qkoW2EMgaN8cPMD99wisQHI8PKYEldryFixemjV?=
 =?us-ascii?Q?82bHeUzV4aUI2AZHXmRZc9y87Nzxv7PDchbjT7P61bjkfBxs0IEK9U29XL00?=
 =?us-ascii?Q?dQ7qEu04BtIrOy3BxhvIjWphTMpR0mk68+dqk90H3wqYtFyn9HXHcSkHj6MG?=
 =?us-ascii?Q?deaq/FIvFoL+XdFLC0Zsb2aHRjKNJKDWJmEpcikXjJufjT1nCqlStkVNWg+B?=
 =?us-ascii?Q?el4v22O/a7v5OD4iFqatQ5QfE/pJnat2FIztdoDcYLTpCOrCACcn2yazp5r3?=
 =?us-ascii?Q?SKms/H/ybFssSgthLxZnEbd/U0NxRJT/MkmYlRRdmKxSODQ/YmSuMvNdnhkN?=
 =?us-ascii?Q?c2JIvxome8JKsfSpWYPXZRQFS3ECgB9SweRM1fQOKYeG9HDfjyUksoK+76ZI?=
 =?us-ascii?Q?lnsrddlET7LYFGJEMlAJDD7ndYRIIgUiwXfDmccplPGTscrA1Oz9e8K2O/9v?=
 =?us-ascii?Q?TbFo5VQnEPn2h8gWEiF4WxkWiLQyV2A3JOCzaonG6z4X7MqUhv5pW4P526IC?=
 =?us-ascii?Q?ozomzTr+gp9Z7FvqiHHUdCjM6L7HdVuthrLENo0lGL+Vq4LDYFPbF1n7Q4cs?=
 =?us-ascii?Q?eepLOQk2+jWoscevFaBYcJpBtyLF5B+xNKkVaH2/Nm5ju/XheCCb1zdi+1Gb?=
 =?us-ascii?Q?Geks+wZhHv9OYz8sGnEcXCn1K70ZF3Yox7+QDldeJ8a6HRD1yBRCrrtQed6e?=
 =?us-ascii?Q?5hNjHwfvrYWm4oNuFy9ZktXlwQKoW445JhSiX9hKaEGe67ggMYhqfnoLZGW7?=
 =?us-ascii?Q?uY+MgditLKBPuACPK8xc5BAN62PsQolW6QcNzLT929XzarxVkhH7IXt/xT60?=
 =?us-ascii?Q?49+fgBQMplCjCjjflFd0YYTpb83mQJN51HCkTynhh9jfM+jS9fh2JhmVS/Td?=
 =?us-ascii?Q?XJWox475ULX3cDYHXHbd2ExRs6Q4HrvTk1A17JsHMmpnawdA9afSoVhrR/Q/?=
 =?us-ascii?Q?azhKoCTYUF33k3d7qpNmQSA4722z9Y/UePdgGsoBm3pOJwWGqtMAsML8uzL3?=
 =?us-ascii?Q?ndls0gBUA2ntin4TJsCv/+KGyw4lmp/xWM2RNX+x7DcpK2V5XHxyZyD5JCeE?=
 =?us-ascii?Q?LPvZQwlQjI3RzicxRp6jcxK4aI8jiLgJBsIeN2KYphRUmlxyPJDtW/WkN8kz?=
 =?us-ascii?Q?pXDC6ScVEOrkcCIGoi1rUMrvv8SHAghy+/JYq+2q1qRxgBPO0C+nJgAYd62s?=
 =?us-ascii?Q?GjihzA5uwkrMldNLJq64BrAVUMtb1sXBhU5Jq2zJSacGd+2Rrogcwd/wwkS2?=
 =?us-ascii?Q?DVPCVYrNmZ66ZZS3sd2oQHprg0c0pINQBxZDMTjjUsGyy+MNQXV+T3MA+U4x?=
 =?us-ascii?Q?qt/4mkCCIaEyVru2metONlT2rmca6ZZCHHKtxKI3XewYQb3p/3VysHNbyBFl?=
 =?us-ascii?Q?daQe/fboGDqc+2Ud1cUg2rUqIAY0UsSJsSn6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 04:57:42.8835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee8541e8-38e2-40b8-276c-08dde1386da1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

Remove redundant mbox_controller_unregister() call as
device_unregister() handles controller cleanup.

Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 0c143beaafda..bdcc6937ee30 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -893,11 +893,8 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
 	i = pdata->num_mboxes;
 	for (; i >= 0; i--) {
 		ipi_mbox = &pdata->ipi_mboxes[i];
-		if (ipi_mbox->dev.parent) {
-			mbox_controller_unregister(&ipi_mbox->mbox);
-			if (device_is_registered(&ipi_mbox->dev))
-				device_unregister(&ipi_mbox->dev);
-		}
+		if (device_is_registered(&ipi_mbox->dev))
+			device_unregister(&ipi_mbox->dev);
 	}
 }
 
-- 
2.43.0


