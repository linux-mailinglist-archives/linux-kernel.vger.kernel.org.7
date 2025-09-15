Return-Path: <linux-kernel+bounces-816643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B66AB576AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C76200DD4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819262FE56A;
	Mon, 15 Sep 2025 10:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4RYdKgSf"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012006.outbound.protection.outlook.com [52.101.43.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A932FDC55;
	Mon, 15 Sep 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932663; cv=fail; b=uHOx1xTlvHGW4Y3NHXe6zGqP1096BJ7jMZRKKpoJuF0gOaQdNlL3ljZqqanHarPRIrIVBM+GCd1owgurM4xLAbblMBViKsyotrVCUQyV5qYCgYC2W2A5n6PMucMymJMVZ6vJeXiMVrUgLlDo5WnA38reokACytbnCUBhdHufEpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932663; c=relaxed/simple;
	bh=6OXFIb+K7KtGYsG+Uykuw4I6s7yQjYv1qfdh8EBWjxk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRCY3KhIzOw6zoZThnDb299ys4a1odg75odeQqBrP/LHeaBBhyfMnSqfeME7MmPS4NFEZ0PlLmjk0clMqAaQGWryif2mbpmSmJ7TEwL7s2tGX7ZUPo6WqzkaG0IhJAbauEjkvL0P3rRgqTW+l80icZ/nj96D5mQQLiHm9cN7240=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4RYdKgSf; arc=fail smtp.client-ip=52.101.43.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isLP1ukQxmLsz5P05YeLTVqKxaxu/3ClSyWdO1XSg0mwl3OygMRSUfWuWZ0vqQ+SEBWkA1IBpcKA4i0Xu71IuyHsusjAI/IkGt8jrGL1xUhQJap1GfEv53qU9GeRpCL9lr5tiJ50mBwcs+/UhIS/NS9vRK8IvNk6v2si5gEJqYKHXZbsDdAUjHdS05z5hk+xwcM3Stg6kqu+HA9tys26P+BEc7UwDL9xbMpfvoXmxs69UZeLdfJsVNkrDAai1ZcrAy7aD7Dh2xQbaiSQqqLaL+8aDoDxAANHHRbBE3MEiqweAJ3iS1WVByPNrA2pR48f9fAAl2p/CP1Sp8yRlGuc9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93tyfEdHbXcYDhr8XxDeG3OcD+h5/4VxcW/OEGjMfYo=;
 b=eulAYkPsVtJAjNyRngJt1YLZVqDm3gipuLzabWnsdL6H9rVQu7Yx2Bmsx3wOTj4+WTLW4IYmRZbOYKcUy+NWjxXvlZfkEzj9CcA+qxf2+VUKlh9qVuMALDlSeqyQofu+vQd+n65vdG/T/eM+Xmf7h/xW1O3ujmHaNDXQkcjIHJG4su9si/G/xF6GOV3XoQbkigQCVkvO2rd5AVkClgNlX2cAOhb70PQvripqLMV3kVIUT0xNg78tLXp0q1g9iTgeWi/5CJZ4V3oQFPeTQ21Z/PIqrZNb+VLHy58+fbZMFwM8lcLtDnq3pD15rA3nNqqSO3f4et1xEU/C2KoI6GKesA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93tyfEdHbXcYDhr8XxDeG3OcD+h5/4VxcW/OEGjMfYo=;
 b=4RYdKgSf3z4xSeQrXBhEARgmodScnIUMs5FnwJ4RItumtfA1Hl2/HJ90FoJUkV8cpo9u+CE6Ngf7R/dNJpTmF9DqGgI3zcXBCqlACIqT3O886g4wQcLQmtdMHOV28MnG4Zn0sa6xBAPft+GMMeGoall7cxmdGmbiX1VNECLOGNs=
Received: from BY3PR03CA0025.namprd03.prod.outlook.com (2603:10b6:a03:39a::30)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 10:37:39 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b7) by BY3PR03CA0025.outlook.office365.com
 (2603:10b6:a03:39a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 10:37:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 10:37:38 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:35 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 6/6] misc: amd-sbi: Extend support for MCAMSR protocol for rev 0x21
Date: Mon, 15 Sep 2025 10:36:49 +0000
Message-ID: <20250915103649.1705078-6-akshay.gupta@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915103649.1705078-1-akshay.gupta@amd.com>
References: <20250915103649.1705078-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f2a9d47-b883-4020-4da6-08ddf443e476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpJnqdiH5yaeaySYEtJw1+IIgfHKM9rQ/Di3r0JKWFzgYGbDpfZjVBL3l1hJ?=
 =?us-ascii?Q?KcIsZrh6X7v8q5SGY5xQai2Nabb5SF+seEoIKi8aKk4w8wUHWzSXqFlK5wDH?=
 =?us-ascii?Q?Qkc3BdAXwdf9oVDh+7re9R3flfPIgWTBY2bG7f4oUWhHb8Ivb2uBWCwC0FeM?=
 =?us-ascii?Q?QwI9XvqghPBgnubMpDdHxQLd4zPrF+t9Kt2+6aAg2sbzKwTc9pJCp2H6PT/Y?=
 =?us-ascii?Q?4IPAsPdfuysQn9VQenK8UzKWz/cIi6H5cwO6BhupKg+q72FprvYblNRrGqxu?=
 =?us-ascii?Q?XqnVKgGItVTj+OtpsVYHhKhDZqml7B/IWzhWYB5J3lPVx3GJK2saejRlm/rL?=
 =?us-ascii?Q?AA/SDKK3jtR3Awj1pZkc3sGOaK5mqNUZmyRE57iLhtdufrE5LjDjJI/Z2LtY?=
 =?us-ascii?Q?htE3DupkT04T8qpV8g68Lso6F5iI5Bvddnymlv72I5AXKpUoXVWH/N7Xf3Go?=
 =?us-ascii?Q?V4qix/kwBD9/vxVsJcBIx0WDe2uaDEgbSYSrRTGS7Vv0pMDwtK62t7I7Xygb?=
 =?us-ascii?Q?RHvW2cZaXVi0vtqj0AGb+IXoMp7ae7k6iT2iCAX+xsF+fgnf+YfdBib5noES?=
 =?us-ascii?Q?vdULNzLyDmXGuyG1UznlYfNC1UiwkTCXlHTyz1XXYTfgjs7xRdiiu4IaM6zI?=
 =?us-ascii?Q?bOS+eSP2Rez9YS7m7EX3ljbWpQpt3MZF+i2cUfZWlwHsZnnZcxl7qv4H8rnf?=
 =?us-ascii?Q?CNQKRK2O6go1wu1jt/HYnK3msFAM7gCXo/2EOoXbXXFxbc05TO2Ws/QnAVgI?=
 =?us-ascii?Q?ipnmavkdG2exroR/AKKkqVYaBlNDUERpAb/UivXO7Cq4/QzjBWJmOTVKJgfv?=
 =?us-ascii?Q?pyqMoxCnAyXOnZnAgSP3UmhV2RCGifV+QQhd1Vik2A06VMhAwwE4h6SX+hyQ?=
 =?us-ascii?Q?x6v7EaniCZcobQ3s8Tb6f+TyEluqrMcD3eFoMnUy6bsue7uFPnHB0vVtv3wQ?=
 =?us-ascii?Q?RkhIhJZ4HOLNbZwnkTPG3JDOydvNfR4jQzWX3HIU3DieqiONRGlSPQ9qHMaS?=
 =?us-ascii?Q?SVdXMVeksU3oqa82oSf+IZkcorxqWiBEy22n7c3PE7LgqpnJ7oGCHoIPcd8u?=
 =?us-ascii?Q?X/X64pvlBn18a75Cf7w3LqMc34zjobckoiw9poyMBZr7gN49YhflKmy+/eig?=
 =?us-ascii?Q?zgvmZWTRERyGPTqK2ZfIgDoi1k9Vpjp9M/pQECzQCJJZ7AQQGn/j3WvKfhtA?=
 =?us-ascii?Q?aODEilr6Exmd3tjD53WDmNfdEV0cX3ZPss7Z6+VCHEB2gON5QwNnWpkdFWE2?=
 =?us-ascii?Q?u/+EzFI8RENsc6ziu3XGRoL/MU+3QSgYQtPpLBinCLOD9RCMETquuJyKt4e7?=
 =?us-ascii?Q?W4yv/bzDeUFVsWgcUDzMOFJCFb2G/ariqPQjWWkL2CuVyPFeuowz7wJ7KG/f?=
 =?us-ascii?Q?ui5LyMhbc7+dzl01eldhZvJibTPyjhL1LZuRNJWfeHRfjFI7kQcfV7xzdYQc?=
 =?us-ascii?Q?Q61AdnnWKLcWUuShHhiPyjxpSdWdAbzWUcWBcVzpr3EKRXtws4epeJapCg9H?=
 =?us-ascii?Q?n5mtFRFtE7eT2YNnccpPGDoS4Nlthbc3Mmrg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:38.8096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2a9d47-b883-4020-4da6-08ddf443e476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

- MCAMSR protocol for revision 0x21 is updated to include the
  extended thread supported by the platform.
- This modifies the existing protocol to include additional byte
  to provide high thread number.
- New input structure is defined to address this, as the hardware
  protocol is tightly coupled with the input structure length

Reviewed-by: Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Signed-off-by: Akshay Gupta <akshay.gupta@amd.com>
---
Changes since v1:
 - New patch
 drivers/misc/amd-sbi/rmi-core.c | 88 +++++++++++++++++++++++++--------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index ef93dce7e038..c3a58912d6db 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -35,8 +35,10 @@
 /* MSR */
 #define MSR_RD_REG_LEN		0xa
 #define MSR_WR_REG_LEN		0x8
+#define MSR_WR_REG_LEN_EXT	0x9
 #define MSR_RD_DATA_LEN		0x8
 #define MSR_WR_DATA_LEN		0x7
+#define MSR_WR_DATA_LEN_EXT	0x8
 
 /* CPUID MSR Command Ids */
 #define CPUID_MCA_CMD	0x73
@@ -120,6 +122,17 @@ static inline void prepare_mca_msr_input_message(struct cpu_msr_indata *input,
 	input->value		= data_in;
 }
 
+static inline void prepare_mca_msr_input_message_ext(struct cpu_msr_indata_ext *input,
+						     u16 thread_id, u32 data_in)
+{
+	input->rd_len		= MSR_RD_DATA_LEN;
+	input->wr_len		= MSR_WR_DATA_LEN_EXT;
+	input->proto_cmd	= RD_MCA_CMD;
+	input->thread_lo	= (thread_id & 0xFF) << 1;
+	input->thread_hi	= thread_id >> 8;
+	input->value		= data_in;
+}
+
 static int sbrmi_get_rev(struct sbrmi_data *data)
 {
 	unsigned int rev;
@@ -248,13 +261,47 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 	return ret;
 }
 
+static int rmi_mcamsr_input(struct sbrmi_data *data, struct apml_mcamsr_msg *msg,
+			    u16 thread)
+{
+	struct cpu_msr_indata input = {0};
+	int val = 0, ret;
+
+	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
+	if (thread > 127) {
+		thread -= 128;
+		val = 1;
+	}
+
+	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
+	if (ret < 0)
+		return ret;
+
+	prepare_mca_msr_input_message(&input, thread,
+				      msg->mcamsr_in_out & CPUID_MCA_FUNC_MASK);
+
+	return regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				 &input, MSR_WR_REG_LEN);
+}
+
+static int rmi_mcamsr_input_ext(struct sbrmi_data *data, struct apml_mcamsr_msg *msg,
+				u16 thread)
+{
+	struct cpu_msr_indata_ext input = {0};
+
+	prepare_mca_msr_input_message_ext(&input, thread,
+					  msg->mcamsr_in_out & CPUID_MCA_FUNC_MASK);
+
+	return regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				 &input, MSR_WR_REG_LEN_EXT);
+}
+
 /* MCA MSR protocol */
 static int rmi_mca_msr_read(struct sbrmi_data *data,
 			    struct apml_mcamsr_msg  *msg)
 {
 	struct cpu_msr_outdata output = {0};
-	struct cpu_msr_indata input = {0};
-	int ret, val = 0;
+	int ret;
 	int hw_status;
 	u16 thread;
 
@@ -265,30 +312,29 @@ static int rmi_mca_msr_read(struct sbrmi_data *data,
 		if (ret < 0)
 			goto exit_unlock;
 	}
-	/* MCA MSR protocol for REV 0x20 is supported*/
-	if (data->rev != 0x20) {
-		ret = -EOPNOTSUPP;
-		goto exit_unlock;
-	}
 
+	/* Extract thread from the input msg structure */
 	thread = msg->mcamsr_in_out >> CPUID_MCA_THRD_INDEX;
 
-	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
-	if (thread > 127) {
-		thread -= 128;
-		val = 1;
-	}
-	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
-	if (ret < 0)
+	switch (data->rev) {
+	case 0x10:
+		/* MCAMSR protocol for REV 0x10 is not supported*/
+		ret = -EOPNOTSUPP;
 		goto exit_unlock;
-
-	prepare_mca_msr_input_message(&input, thread,
-				      msg->mcamsr_in_out & CPUID_MCA_FUNC_MASK);
-
-	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
-				&input, MSR_WR_REG_LEN);
-	if (ret < 0)
+	case 0x20:
+		ret = rmi_mcamsr_input(data, msg, thread);
+		if (ret)
+			goto exit_unlock;
+		break;
+	case 0x21:
+		ret = rmi_mcamsr_input_ext(data, msg, thread);
+		if (ret)
+			goto exit_unlock;
+		break;
+	default:
+		ret = -EOPNOTSUPP;
 		goto exit_unlock;
+	}
 
 	/*
 	 * For RMI Rev 0x20, new h/w status bit is introduced. which is used
-- 
2.25.1


