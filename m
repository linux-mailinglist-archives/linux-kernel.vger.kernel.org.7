Return-Path: <linux-kernel+bounces-733406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6411FB07453
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDFF16DEA8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9F2F5327;
	Wed, 16 Jul 2025 11:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gRgk1yVp"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314A2F3C26
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664085; cv=fail; b=QOUAxtGj2ScDeCKQEVZ7JjKbwCEJAem40uRE5vPYT7un6843tK3xo+zvibBsAhXFlhFSkWObrDUXaWuC/2Y9zAlwncjaW5ySSQGiffvdkW8QKScjyXjZJ5znn+JEfh0W2acllTFBljvo0vmUaR3WZY1t0x/NsQ2giLjW5hCPK80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664085; c=relaxed/simple;
	bh=hIrQ8IRJL8EOBbSv34AERyPuXBrdTFT4nRHMeprwyq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CkhRgCZlOJX4E8oC3lTVX1WRijk02l7pcp1m2iv3IgDZkkeGbi14QlLt8zIq2omxNoFs4z8zlMkEJgLqHKNwuu+0J/1d1qZOpfjSgxpiuy2e4cMQPuwQETGFeZpKzF9lF/eU02ie2zBrbMYk37pTjQEWGMRqyCS6iHzdyJi+UVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gRgk1yVp; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZat5pGU0xEsUBKPVjplXlCKn06tAXCHCbIvMNCXiyRysObRYvVyHrrP66Y3c0MBv2j5TNwBqNfwTfiEvCaenTTg577/SHbZu8nNRsLjtElIioCPD+UjjuPCpw2nDr7ARKMpiyXaOVcAdBrK+4+DqOQfHHxuXR8RXGDXuzdyZq/X1z/LTLOlWlJP9Djv9K44EBhuQnPCQ4ZHtaHIm2h5qRTMyA4PpXY1jixLD+2un1CwIXEH0e1ACK+y44HwvZX8pkHNcXMk5AWh+VqzZTAZGHv8qY5SYlaT13AatRct69ifVP4EEw4nnadxxd/SzXEiGn/nSLh9D0RhQGG11EFSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCSlhyB3M0f5RuBAGGrU+uxeZAFt7hAlQWutqD0FpaA=;
 b=DQ4NhKieA0cZK/jVhOx/YOs+1jHRuI/vrosf6OE9NN0k446i35rxQNEvL+cuEOLUmvmOo5kq/ojsmqkSwEYJBjOsBwLTuAdrxGRvB5JXPTviRSEaz/Fv9SS/fMLgGMzBxVX1/ElasYkUUSc4KJUxv9LC9qNAw/u1FzD5r3bak+1U54MLeptB9UJowAJiAE/G13Y2CU5gqKbSsDvpPF5PFvQiW+WA/8fNojiXirHAwfXdCAxeemTju3Pf/VBUf0XsmxFb3kyxu2Zi6W+Ibm7rN3qbWdDn7JoMQlOhrR9bVDMs2UMluWudOAG37hp6ReOB+ONACNofnxQcsFM8ZQbCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCSlhyB3M0f5RuBAGGrU+uxeZAFt7hAlQWutqD0FpaA=;
 b=gRgk1yVpHO4tp3p+Ectq7FvkGLmlf9PwWg1Hc9yQ8t2uMzsqXu1WpUJDtyfE5KM6XP462oLipQb+Ythqo50RGCX6tpURwweXnIW0BILLKkcBczk1o+1bHNyiGUoSmx0L6sIO69OK9yNxmizwwiB16wP7GKmtCXR3mSppjR3ujzs=
Received: from SJ0PR13CA0159.namprd13.prod.outlook.com (2603:10b6:a03:2c7::14)
 by IA0PR12MB8255.namprd12.prod.outlook.com (2603:10b6:208:404::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 16 Jul
 2025 11:08:01 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::77) by SJ0PR13CA0159.outlook.office365.com
 (2603:10b6:a03:2c7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 11:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Wed, 16 Jul 2025 11:08:00 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:07:55 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <Anand.Umarji@amd.com>,
	Akshay Gupta <akshay.gupta@amd.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v5 2/3] misc: amd-sbi: Address copy_to/from_user() warning reported in smatch
Date: Wed, 16 Jul 2025 11:07:28 +0000
Message-ID: <20250716110729.2193725-2-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250716110729.2193725-1-akshay.gupta@amd.com>
References: <20250716110729.2193725-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|IA0PR12MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 93f75897-dfe2-4f32-d48b-08ddc4590705
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lDLV1oNfBEUgAEdZ5fZLYFsVIlESXnv1Fx9XQ/B6nx693+Edar7WSZbrBvFS?=
 =?us-ascii?Q?AJJjvEroQEd08UKVeQkj0Qp6EebuS4rgfulQaIXrdGLiRQDBEDBnXfszC3MQ?=
 =?us-ascii?Q?qwwZ9aSXdjxqfkUQus77S0sntM2urVDA8vXqYN/4eeIurDfwjRLqMb3oYjYW?=
 =?us-ascii?Q?/Dt/1PadNAoEEBKKef8MRWWfS0asTjTgMX7Esa6JuIAbYPdhIGZlJcd+vAhb?=
 =?us-ascii?Q?Zc5sTHYaS/0iu+dA2/QoFeaTbzaCiVxslQXLDndyrSSA9MrTkXhVqgmoiGyp?=
 =?us-ascii?Q?NdWFjNC72C7O3tx7BxhyeMTuI3hih+Ne0qqoNlSCvpfqc9I+OVgqR6qBxF11?=
 =?us-ascii?Q?RRifdWDzESZcxP24cLlcdRxWnsZGE79e6NBlH+voRn2A/MupE+3f0dj0cKZG?=
 =?us-ascii?Q?BysWliZfp67qPdlWfkREHCgRYK9+QZ44QzCjTmh91bb3+mB+JHoYbwWcFIPt?=
 =?us-ascii?Q?kKxsM4Z/R8AJzRodMpiIhIRuDmG9rn20O1kvU/9bEFfaLZ/3+16ZTfRIqi/1?=
 =?us-ascii?Q?ZEENVQgodjWUcByIA/gz7EBJqYESWieWYyBg7lefOt7IbrJL2j3IZURgDMA/?=
 =?us-ascii?Q?KaI7hwh2qs1p8S+cVikeNAoazmohRflBBnE3/3+aNZlXOHLBO2YJIdkNLXcf?=
 =?us-ascii?Q?5aJmqEFegNfR1YxZzGVdDyau6UVvarMSoHHE5RZ1hbhXC6szcUUTt15G5MIe?=
 =?us-ascii?Q?CfatNO2s8LGGLjhJSUXwRYiO2nIR/KtQcn4F70zVDSTUZJh0t5TT0CgCmYL8?=
 =?us-ascii?Q?mIo5cFU8oS78/4ssyAGy2gghMGEQ+CXOKAQafvxkY+iNT5F6v4n/QpNRGeKF?=
 =?us-ascii?Q?CzfgBzWpT5XJsiS9W5hCmF+s1u/bxNdeECAVGDOGttFmJLISWBZk2e5MfLis?=
 =?us-ascii?Q?KBitYgzsNlBe4aqHnlSg/yWDmE+ovG/+rckIfvVW2YBu5VicPjbd7/PwfiEH?=
 =?us-ascii?Q?pNhzTYncBd8CVKkYOe30iSOE3sG+YuuneRCB3M0uRWqjRrI5nLadQ3qJAFwC?=
 =?us-ascii?Q?H8FyIXmiJ5N8ts4nZnu/qYUNAMmo3u67tu29K+FsO7npb8CJW1lKVIWKgMcV?=
 =?us-ascii?Q?tc+dRChpnH7H/IDHWEvNT5unhc/b955x4Ky/jZ0kKBuKu5fTpuYzdPG6PiIV?=
 =?us-ascii?Q?qHwlPBBai1C+nfjjYyajGbl4+h65rKnIhJb/RLtqb5hxIUgip7wwEsti5qjR?=
 =?us-ascii?Q?LqbhabK8NTW4mDYjg5FYFGN51FfVaq+jd3WytwIceZRsr2LQk1DoKJwDuYxJ?=
 =?us-ascii?Q?3qpOpI48b+5TEIvRAO/6n2XuIgOcVgHMe5VeYiEgF5qSNvRpTCaIA8YDtdNH?=
 =?us-ascii?Q?FgXN4OHIdS2jiavokm1FtjJpNHDeXMjWhq+8AVJiQeFN23RUHcASkuYwIZrm?=
 =?us-ascii?Q?c17nisQ7YPvH15BIN/stMzymwNKCaerOg1S31rCYKnjHsOPSAZWecRg6LavY?=
 =?us-ascii?Q?gq84up/RVY4Gl2XESiGNveWgm5Bs500HWZShWYSAw4sakv8rt4lv4S20bhc5?=
 =?us-ascii?Q?wGjjRibza0PjkLdch6fCmFRIILJBE0+N3Y2p8wAObpGmQ906uX0S859vkA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:08:00.4097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f75897-dfe2-4f32-d48b-08ddc4590705
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8255

Smatch warnings are reported for below commit,

Commit bb13a84ed6b7 ("misc: amd-sbi: Add support for CPUID protocol")
from Apr 28, 2025 (linux-next), leads to the following Smatch static
checker warning:

drivers/misc/amd-sbi/rmi-core.c:376 apml_rmi_reg_xfer() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/misc/amd-sbi/rmi-core.c:394 apml_mailbox_xfer() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/misc/amd-sbi/rmi-core.c:411 apml_cpuid_xfer() warn: maybe return -EFAULT instead of the bytes remaining?
drivers/misc/amd-sbi/rmi-core.c:428 apml_mcamsr_xfer() warn: maybe return -EFAULT instead of the bytes remaining?

copy_to/from_user() returns number of bytes, not copied.
In case data not copied, return "-EFAULT".
Additionally, fixes the "-EPROTOTYPE" error return as intended.

Fixes: 35ac2034db72 ("misc: amd-sbi: Add support for AMD_SBI IOCTL")
Fixes: bb13a84ed6b7 ("misc: amd-sbi: Add support for CPUID protocol")
Fixes: 69b1ba83d21c ("misc: amd-sbi: Add support for read MCA register protocol")
Fixes: cf141287b774 ("misc: amd-sbi: Add support for register xfer")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aDVyO8ByVsceybk9@stanley.mountain/
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes from v3:
 - Update commit message to include "Fixes: Commit ID" as Greg's suggestion

Changes from v2:
 - Update commit message to add, "fix the -EPROTOTYPE error return".

Changes from v1:
 - Split patch as per Greg's suggestion

 drivers/misc/amd-sbi/rmi-core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index 3570f3b269a9..9048517c088c 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -372,7 +372,8 @@ static int apml_rmi_reg_xfer(struct sbrmi_data *data,
 	mutex_unlock(&data->lock);
 
 	if (msg.rflag && !ret)
-		return copy_to_user(arg, &msg, sizeof(struct apml_reg_xfer_msg));
+		if (copy_to_user(arg, &msg, sizeof(struct apml_reg_xfer_msg)))
+			return -EFAULT;
 	return ret;
 }
 
@@ -390,7 +391,9 @@ static int apml_mailbox_xfer(struct sbrmi_data *data, struct apml_mbox_msg __use
 	if (ret && ret != -EPROTOTYPE)
 		return ret;
 
-	return copy_to_user(arg, &msg, sizeof(struct apml_mbox_msg));
+	if (copy_to_user(arg, &msg, sizeof(struct apml_mbox_msg)))
+		return -EFAULT;
+	return ret;
 }
 
 static int apml_cpuid_xfer(struct sbrmi_data *data, struct apml_cpuid_msg __user *arg)
@@ -407,7 +410,9 @@ static int apml_cpuid_xfer(struct sbrmi_data *data, struct apml_cpuid_msg __user
 	if (ret && ret != -EPROTOTYPE)
 		return ret;
 
-	return copy_to_user(arg, &msg, sizeof(struct apml_cpuid_msg));
+	if (copy_to_user(arg, &msg, sizeof(struct apml_cpuid_msg)))
+		return -EFAULT;
+	return ret;
 }
 
 static int apml_mcamsr_xfer(struct sbrmi_data *data, struct apml_mcamsr_msg __user *arg)
@@ -424,7 +429,9 @@ static int apml_mcamsr_xfer(struct sbrmi_data *data, struct apml_mcamsr_msg __us
 	if (ret && ret != -EPROTOTYPE)
 		return ret;
 
-	return copy_to_user(arg, &msg, sizeof(struct apml_mcamsr_msg));
+	if (copy_to_user(arg, &msg, sizeof(struct apml_mcamsr_msg)))
+		return -EFAULT;
+	return ret;
 }
 
 static long sbrmi_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
-- 
2.25.1


