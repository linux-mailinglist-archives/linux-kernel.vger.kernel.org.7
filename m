Return-Path: <linux-kernel+bounces-733405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A400EB07451
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7D4E1C31
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 11:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810692F5314;
	Wed, 16 Jul 2025 11:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JledI/ve"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470412F5301
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 11:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664078; cv=fail; b=hnD7K7a0MtMzhTZg/+3l+2ZrQP6WN23fNYk1adVjMhnIJFYO+BWCC4f3nJKPnVRyE7f63xukO6r0AC/kTVgwHLk++829YEpk0p+2SuHNtcjjUWZK+esedCzZdd/+6UpL1fuGblrSQJrFaNUQSqSAs0AVZE6Qa3+B9iwAW0+lsmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664078; c=relaxed/simple;
	bh=SP1udluasHRYiyDkah9MsLjKevRONPq6MRMDGqiMgDY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hlmrSD7FbG/qQIraHR0bTa3Ax6aA5g3KPKHl5hkOLiryjk1L6tcTUW1bw728BD2bjp3v9DdM1e/JnsM9vfosf6cMioZXZ5GfLt3gu1/Baeupj1CgsbucwYWH8QV6iKqttyY/zVgy7cwGHicVU8LSkY9IhfJj8jlXL64s56ePSOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JledI/ve; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUFc7Rv2hQQD9LvuS/LPLmHnSgwpWltE7sGvceSuCejuxmuP/nA+rZrtn2zGfdN3Ol88WFPIjT6cUwQFyYMqqZYeG+HvrsOREGZqbIUPQ0UmP47WZy1mmhYCiBoXDzIfjUSAj2Tfh5CkF0X3E33NxxSLo1ODdkfJ3ie4B+DVsGNKcLh6PpI329dwsk0Gszd3QxvdIauOa6UwzEXiLamoxTSjUswD3SLQg3+LiZkwCu5lCHkHZoJQRQtNDopnnRNkwvTc68kSZQbIqXPPosOrD/wxj0G2pSNRvVZYTsBGa8ldopWs4JCrTWnTvHKYiMGl9DfmJUyMurTBdW49zer64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=065SpLnWemvRKlNaFYoNKiIeZ6ppYYWoBxziyGYTt08=;
 b=WwbxUZB4kMZpEnDCD8aLZYje0i4kckf8OiBk2UQzMwfc6ErWlI4HcnE3u3e1hDxrGzYis2bVu42R67jPhJnwvCUOR4sQ6nDwIyMVu8kQRK7j5w9vLy5193BTIW2HGcnPlbC+WiRvxU5Bic+w25cvDcOpWnwG4Kf0gLEdTWQ1tUkr06wnd++LyQ6sIsJQ3pV2laaQVsc4XBZAp57k51Fl2+sIkyeEDA3AutgO+RLYtHC3BE0NIPSEcxXpb0ns98pnTnfQQtRBdvDxnPOCM8b+alGk9k7ovpxQMXLVDADMJkT3vlB3gfGXsaQgwENC4abQz+aphnM5WuPRaagZ/iMsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=065SpLnWemvRKlNaFYoNKiIeZ6ppYYWoBxziyGYTt08=;
 b=JledI/vemZNU1kmk3n2QDE+806t8iU+vpjJX9Aup9TCmvJ9OhPDCUMQcIygKGNH5+mQNRB4qnkGVRcdEiGWSCJhMr4cAn1SLdx1EubfbhaJJCyrFndMUxbBT9FTaaAu1AybpiFkw+OA6dIacUmSDg7IJOyaaNWxkbthkz/6npo8=
Received: from SJ0PR03CA0157.namprd03.prod.outlook.com (2603:10b6:a03:338::12)
 by PH8PR12MB6866.namprd12.prod.outlook.com (2603:10b6:510:1c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 16 Jul
 2025 11:07:53 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::d) by SJ0PR03CA0157.outlook.office365.com
 (2603:10b6:a03:338::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Wed,
 16 Jul 2025 11:07:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:07:53 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:07:51 -0500
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <Anand.Umarji@amd.com>,
	Akshay Gupta <akshay.gupta@amd.com>, Dan Carpenter
	<dan.carpenter@linaro.org>, Naveen Krishna Chatradhi
	<naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v5 1/3] misc: amd-sbi: Address potential integer overflow issue reported in smatch
Date: Wed, 16 Jul 2025 11:07:27 +0000
Message-ID: <20250716110729.2193725-1-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|PH8PR12MB6866:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e62d6-f43e-4c1d-8247-08ddc4590300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EsnYrkKUOWOFvGz1XRF85vQ4szgHocqi9Z9qEAlokj1FSRjRIi0ugA82tyaD?=
 =?us-ascii?Q?nTn9/SfGl2kBAhtOy2snB6MiOjtzvLQAg8gqZPu9Po2/gjxnHkz2zLZy5IIe?=
 =?us-ascii?Q?uSGTqh5u0RRmhyBZI2Wz/j2iTVv6U3HB/NPdDD68vWLUdeV7wK4+HvIun23K?=
 =?us-ascii?Q?Df3ZqAD6EASEOwGC8s8t58Ps+DtWk3iA0GCzalHGuKJyLiKLssCQdj2FxJkb?=
 =?us-ascii?Q?/kCs1KZC0A+8GKH8dnKuszvTvBy0w0MX25xe8vFJ7GwD9TA24/PSDoZ1bUI0?=
 =?us-ascii?Q?d7+V2gy57vtDHGK+t84zRQ1uX+haGk5j9RZJaVUg9JMaI4I8c66yAJyf2eD/?=
 =?us-ascii?Q?/dk60SpMZZs3woOqj3LrtHt3j0caUMWiWS9W/+cXHGanIBASOzhQw/MoUOUR?=
 =?us-ascii?Q?J97wnSUbZUcpbIWaCWmH041PQBdqzjtkpd14MyRPnZ0r4AJdipyfMLEkRDDu?=
 =?us-ascii?Q?LyUgsIMO3UuV9+0E/xX4cTet0V4UIadYhMdby4B2V4O9zF0NeTLRr4J6Se8h?=
 =?us-ascii?Q?Yqw345QbY1XsvAVKv627iDV55youLBbGHYKZ/c9ctGrTZygIDQQ6ZI+nr6Zs?=
 =?us-ascii?Q?1sMmVSU5y8B8CDZHRhM8h+6WeJ12aIi1MWCFPNoncBUCgpPfwjyhxMY8l5IG?=
 =?us-ascii?Q?KgaSlXq+ptLwApNUvJpVOdN41/pL6e5TKUXNka8lnxppe17WfzzZr6DupBMQ?=
 =?us-ascii?Q?I8HByd0C+G92OBv6xgranWpZm3Qig4sdURtV1Nd4a/h3dsI2POd4fH/rtcgY?=
 =?us-ascii?Q?gcV0nadkAe9G0PN3fFiOWzfKyMANUYqApjOAYCgKZhQ2RiI76Zq5mAqjiW6/?=
 =?us-ascii?Q?LmLMdsi47dKmFAjdma2ozDfRDx18vYZsEcKmmHYBygjSqtfM5hqw2LTkHg+p?=
 =?us-ascii?Q?bUt5uyLRySF3B7Eaz79deGcK0DZr0AWGK0DO8XcTdoMUmgToQHFeiXFaOI7t?=
 =?us-ascii?Q?rQWr/UXGgN9VXxsxNQXXxRclMEoBua6hN6P3n5Kn5H+QSDCgVmJkKYy0asUR?=
 =?us-ascii?Q?xPcv8SfAFMVpY8taSp6AsD6Bc/Tz3kLUUYLJhWSWRYk+rkzfFVBL5A3Kqrjs?=
 =?us-ascii?Q?USbTJVUBhOT1AiW6f4kWBWnfms89SM7t9YoVOQN0gYNk+96tGtcMsNYbA6b7?=
 =?us-ascii?Q?snZerjZq/iWko1YWzWfD6X1oqedhv8SxNDKML/V5EZhvQkY5sbwjs/t/W1RX?=
 =?us-ascii?Q?cMnevw+uImYOvfabpa+zTZg4CvegKv5Gq7l/NUhBbO4kq+F+EA8iwl3o7TTi?=
 =?us-ascii?Q?GTzmeDdh7ElM3VJAehOUCF5eVCsAi7AaH+bPGSGWD8skq2aJJRXDIMjpTVaH?=
 =?us-ascii?Q?uzszI7BhaF/pLAM5xf0dtGNgIu3/EUTjljHuxFbeV8o+Pcqr1oGeGR/Q1/ct?=
 =?us-ascii?Q?4QUW1OE9PWAA64REl47yhkHQtlmW2WiFwsoIL2Iz3rajECn8enM1D1BeprT/?=
 =?us-ascii?Q?g5JfcyEx0Dwq0slzFLwvOis2IqyanUOpsWYZn1avfzfJhLlQwB7DDG/L/QhM?=
 =?us-ascii?Q?jANYlLb3T1IY41OICKHBQ1tX6akeRN4Pqm7PZKtF0GDhKWab/83KOK6M6w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:07:53.6634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e62d6-f43e-4c1d-8247-08ddc4590300
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6866

Smatch warnings are reported for below commit,

Commit bb13a84ed6b7 ("misc: amd-sbi: Add support for CPUID protocol")
from Apr 28, 2025 (linux-next), leads to the following Smatch static
checker warning:

drivers/misc/amd-sbi/rmi-core.c:132 rmi_cpuid_read() warn: bitwise OR is zero '0xffffffff00000000 & 0xffff'
drivers/misc/amd-sbi/rmi-core.c:132 rmi_cpuid_read() warn: potential integer overflow from user 'msg->cpu_in_out << 32'
drivers/misc/amd-sbi/rmi-core.c:213 rmi_mca_msr_read() warn: bitwise OR is zero '0xffffffff00000000 & 0xffff'
drivers/misc/amd-sbi/rmi-core.c:213 rmi_mca_msr_read() warn: potential integer overflow from user 'msg->mcamsr_in_out << 32'

CPUID & MCAMSR thread data from input is available at byte 4 & 5, this
patch fixes to copy the user data correctly in the argument.
Previously, CPUID and MCAMSR data is return only for thread 0.

Fixes: bb13a84ed6b7 ("misc: amd-sbi: Add support for CPUID protocol")
Fixes: 69b1ba83d21c ("misc: amd-sbi: Add support for read MCA register protocol")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aDVyO8ByVsceybk9@stanley.mountain/
Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes from v3:
 - Update commit message to address Greg's comment to include
   "Fixes: Commit ID"
 - Update commit message to include MCAMSR thread data index fix.
  
Changes from v1:
 - Split patch as per Greg's suggestion

 drivers/misc/amd-sbi/rmi-core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index b653a21a909e..3570f3b269a9 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -42,7 +42,6 @@
 #define RD_MCA_CMD	0x86
 
 /* CPUID MCAMSR mask & index */
-#define CPUID_MCA_THRD_MASK	GENMASK(15, 0)
 #define CPUID_MCA_THRD_INDEX	32
 #define CPUID_MCA_FUNC_MASK	GENMASK(31, 0)
 #define CPUID_EXT_FUNC_INDEX	56
@@ -129,7 +128,7 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 		goto exit_unlock;
 	}
 
-	thread = msg->cpu_in_out << CPUID_MCA_THRD_INDEX & CPUID_MCA_THRD_MASK;
+	thread = msg->cpu_in_out >> CPUID_MCA_THRD_INDEX;
 
 	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
 	if (thread > 127) {
@@ -210,7 +209,7 @@ static int rmi_mca_msr_read(struct sbrmi_data *data,
 		goto exit_unlock;
 	}
 
-	thread = msg->mcamsr_in_out << CPUID_MCA_THRD_INDEX & CPUID_MCA_THRD_MASK;
+	thread = msg->mcamsr_in_out >> CPUID_MCA_THRD_INDEX;
 
 	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
 	if (thread > 127) {
-- 
2.25.1


