Return-Path: <linux-kernel+bounces-638477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83000AAE66C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 18:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64CD3A21A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 16:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AB28C5C7;
	Wed,  7 May 2025 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4NEqO1x1"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859E628C2D2
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 16:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746634515; cv=fail; b=QTKIobMLu2IaDaQ/OrDbzagIlTUOY3+BKRdGDOUvj0QWmUMYNlrtND9sRX6UDSgXEvmdY4WogkU6c7KV7TRBAscu88OJp78tuzxVxKarrc21gzYUOV2yBiy+NWHT1qN9r1JOLSec5Vcy78obMb0sNBjJTfnE2BTi8pSagxfKScs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746634515; c=relaxed/simple;
	bh=CZVlUN9ovUIWCrYYf8BGHIEnNDy7LxnzUXEuI5u7L6E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L3gzLeP8srNfsbkjQzyZqoyybsiK0kqBNFT3tYd8Cdn0M/Dm+P9bvUuJA2q6Y3oM2xADRNbkeFq8h73SGScbUT5FVtr46SbIhTwXQaYBaCgQ87lBQu8qtfUwFdCvoE8gTrg1Apfp5Pi4Mo/Oj2JfvBRUyPykrmIKFLvRdp/7NQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4NEqO1x1; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLZR2vFspxeLqRqQDYA2o6Mbh8955PKEX18Q2apYI0JCcMrkfRsz2/t6d92HJub+vOkc3fRuYQpWXPMcaokMjNx1Hnbjjz4gWSKUPhZIsg4hX78OZ/4V8Z1gvvFp9x4xSicTxFwNHpgjOC45RddlX8ypzyRqI7ichRZF4IBlTYFhR0Y9zjuqsYEkjNs2sJceLtiTOUS/3Y5lbKvNtrldOsDD7SvvO8LyI+kbozgDbxm//EsKqwdC8N1QwvrSmjfqYcnUPjesVNCKpBF5zpsSMwJqi9GUJbner1lTQCo3rGqnrgFWhfndrbZvmd5jYjkBnYGqLJgT0nNLSXGY7MwdQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+RtdtV45O4u79mPxv0VzLDF8nbC11mt7k40eShmkG8=;
 b=tiJ33ILGnhU2DljbePDL9o0sjH06kxXRcINzQm1PGgrZ3PtonxAgH/o7ByEnTTgqZYrWAYOjwVJil8J+e/DqBprW5o0nx6C7dazcr4da8yBS3HX3uQeP7nyQgji0R9T+ii5nlkjsx2FmPaazSrqU+5gX0lu1DqB5uPLR7D9EpLSE8lX6A+MLqQFCoTDHdD3y+C0gzKjSYEnr0SSSBDEApM/hTGRHqvWVazlopBTHbiYv4aI+dlo9RKDQxEhrPwwK9K1r0W/S3J+Je+T4EMu7ct3O3VARoyIIwlrBSebjHgYFliX0b8iR9k8rxEs793crb3zFGCIpSLx4GA3zODTvPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+RtdtV45O4u79mPxv0VzLDF8nbC11mt7k40eShmkG8=;
 b=4NEqO1x1CNIew6Baj5LdKCU4BkdkOnDcPbCWc3EfCAK8vq0P/afAq421Bb0mDVAAhDBDpmyzYW0ffCug+2hXH/cQChj75NZfgrohgNE3j78VGRYZFOmWIv9NjrGkaZ1AfsazoxZ6Anuz8EM/iA/+Cdptr+Pfe+l0JUGw3BGYnQk=
Received: from SJ0PR05CA0134.namprd05.prod.outlook.com (2603:10b6:a03:33d::19)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.32; Wed, 7 May
 2025 16:15:07 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33d:cafe::5e) by SJ0PR05CA0134.outlook.office365.com
 (2603:10b6:a03:33d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Wed,
 7 May 2025 16:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 16:15:05 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 11:15:05 -0500
Received: from xsjlizhih51.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 May 2025 11:15:04 -0500
From: Lizhi Hou <lizhi.hou@amd.com>
To: <ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<jacek.lawrynowicz@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: Lizhi Hou <lizhi.hou@amd.com>, <linux-kernel@vger.kernel.org>,
	<min.ma@amd.com>, <max.zhen@amd.com>, <sonal.santan@amd.com>,
	<king.tam@amd.com>, <mario.limonciello@amd.com>
Subject: [PATCH V1] accel/amdxdna: Support submit commands without arguments
Date: Wed, 7 May 2025 09:15:00 -0700
Message-ID: <20250507161500.2339701-1-lizhi.hou@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 439388e2-93f9-4057-c525-08dd8d825484
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/DyiNhh9oqX6krfjGttfGRzTAQL8IXbv83F4vbPxvexbDbhvSSyCffeGFyH?=
 =?us-ascii?Q?TCOwCqDJyrl9bFpYkA5NgKgTPrYmENBbaJxq6ckmQB9gGjhsM6WGpd2mX8Yg?=
 =?us-ascii?Q?rh2uQrRQKyS042AkuJY85XbruNKzacCRXLZrkBCa7yO3I1xyqbTL1K0qAGGY?=
 =?us-ascii?Q?BCXyoY++JKNXi2sMScslRYVyYwxG/PHGX4pJ3Eb1Gj+bceVCFi9hLtHviN5v?=
 =?us-ascii?Q?wKkjInL4QtgE4J90T60xwY80a3gJ2c+8xmqd/d76tP1Fh5rH1iBJ3oP031z0?=
 =?us-ascii?Q?njC9cIMg+vqNfdB8laXGuydiVe7075alp4HHuqoGcVZxvHpkFnIOYpn/QhaK?=
 =?us-ascii?Q?e5c17RCz29kOkHZYbdqS2+HvEc0rWkXXWDJL9KB0vRFN3n+D2KusW6jCAGDz?=
 =?us-ascii?Q?q/V4hL9utX1pf9IEcR9iwKq4O+xrmmAfZVPORxJDsPEv+gqPPKEh4FWyhGMD?=
 =?us-ascii?Q?xM7MWWoRnmQbjpuLmC/KYWmqrfcXjXoj+fUP+m6JyldX1gAXJ9zy5NRH/+3Y?=
 =?us-ascii?Q?CXFstil7G+QQ2ezh8MiKf+wll3GfhMdR96iQPi7G8tjoUmJUGE1lOQG2QhUE?=
 =?us-ascii?Q?kzt5369fMRuChoA5WWI+OXQhMx/HTFgx3KOE/lkjBbVcZrojc+ZvGXlOat/b?=
 =?us-ascii?Q?jBhU2nBTszun1/xhWqLhMmOxyhei/tTNkqw05wH96IQW+TcMluHOPoZTyhon?=
 =?us-ascii?Q?6FutiFJeiWdfg/cBsh0mVDwSNKir7yOo6g6dc8dQR3RrqaDOeFIimmeIFBuk?=
 =?us-ascii?Q?lbLvKmiRYxg6YTZymlXu4UWL/GleET96deOTZXZAaQRUQ3U8E82AZ6ZKbL/p?=
 =?us-ascii?Q?6MAWzCvxIDexM+YxhkHh35tFGR287Auy5D2ZB0U66vDvUwskcErr/zgkRLR4?=
 =?us-ascii?Q?bFjvmh7jgXioPpCL3AuAFSGx1i5KaVTFCkxic0FDGk4tazHdtXYIFNuTVU/x?=
 =?us-ascii?Q?uz+NmYGnTSzKHLKziOIcRlue57MTtlbkrU3blEuO5SL7JLa/jP3NfO2b7uPP?=
 =?us-ascii?Q?BShzhLWF5fTiBJq81oma3QJHzCEwmcWY5D8ifC86upmyzvb6HBcdIgrA4zWi?=
 =?us-ascii?Q?uZjbPhZe/56ApDYAZzi72ig0bG0EeVPnKii7nqaRw2rPT9NnX+jWcUBe3a0S?=
 =?us-ascii?Q?d8jecfzfBh+KibuoFJ298ZrPuXvRQtWPpDHAx29eOkNLDDNmCm67X2Y6RTvq?=
 =?us-ascii?Q?POJiRQii2F9rW9oSCSv0C23lA4s/bDWYrGVUqQRT1d8zY4S8j82mhdQvs7+x?=
 =?us-ascii?Q?g/sDFRs+LfZDm9GhTUW+aI98XtWaVrKSGq0VrufsnRS08R93O7qaV1n+s24S?=
 =?us-ascii?Q?m7FkkCqFvG3BXRyKgC/78xaRDO59VrOtKdGufoTM1bLC8qjgqo4mW6k6S5xu?=
 =?us-ascii?Q?9PhXH3L8YotVDAn7o1AOoKxHUCQ/nROb4AheGTrzi2WGdd6sMLea9KIR6kP/?=
 =?us-ascii?Q?HnixsCk4JAfvQ26bNyhEkIpSNNOD0MAP2ffIN/QtqhpHt5aNqbCJPJ9F1cXO?=
 =?us-ascii?Q?ltOXxzwkTiWu0KizCmWClfKzab/fX4IZ14TU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 16:15:05.8929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 439388e2-93f9-4057-c525-08dd8d825484
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525

The latest userspace runtime allows generating commands which do not
have any argument. Remove the corresponding check in driver IOCTL to
enable this use case.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/accel/amdxdna/amdxdna_ctx.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
index 43442b9e273b..be073224bd69 100644
--- a/drivers/accel/amdxdna/amdxdna_ctx.c
+++ b/drivers/accel/amdxdna/amdxdna_ctx.c
@@ -496,11 +496,11 @@ static int amdxdna_drm_submit_execbuf(struct amdxdna_client *client,
 				      struct amdxdna_drm_exec_cmd *args)
 {
 	struct amdxdna_dev *xdna = client->xdna;
-	u32 *arg_bo_hdls;
+	u32 *arg_bo_hdls = NULL;
 	u32 cmd_bo_hdl;
 	int ret;
 
-	if (!args->arg_count || args->arg_count > MAX_ARG_COUNT) {
+	if (args->arg_count > MAX_ARG_COUNT) {
 		XDNA_ERR(xdna, "Invalid arg bo count %d", args->arg_count);
 		return -EINVAL;
 	}
@@ -512,14 +512,16 @@ static int amdxdna_drm_submit_execbuf(struct amdxdna_client *client,
 	}
 
 	cmd_bo_hdl = (u32)args->cmd_handles;
-	arg_bo_hdls = kcalloc(args->arg_count, sizeof(u32), GFP_KERNEL);
-	if (!arg_bo_hdls)
-		return -ENOMEM;
-	ret = copy_from_user(arg_bo_hdls, u64_to_user_ptr(args->args),
-			     args->arg_count * sizeof(u32));
-	if (ret) {
-		ret = -EFAULT;
-		goto free_cmd_bo_hdls;
+	if (args->arg_count) {
+		arg_bo_hdls = kcalloc(args->arg_count, sizeof(u32), GFP_KERNEL);
+		if (!arg_bo_hdls)
+			return -ENOMEM;
+		ret = copy_from_user(arg_bo_hdls, u64_to_user_ptr(args->args),
+				     args->arg_count * sizeof(u32));
+		if (ret) {
+			ret = -EFAULT;
+			goto free_cmd_bo_hdls;
+		}
 	}
 
 	ret = amdxdna_cmd_submit(client, cmd_bo_hdl, arg_bo_hdls,
-- 
2.34.1


