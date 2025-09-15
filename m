Return-Path: <linux-kernel+bounces-816641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DF2B576AA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 12:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2E6E1A2295C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11A32FDC52;
	Mon, 15 Sep 2025 10:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FBwkUPKT"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271402FD1B2;
	Mon, 15 Sep 2025 10:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757932660; cv=fail; b=mo0ClUH3vRj9mi4IJbjstx8J4qF/OJ7ZskF6x6TYS9+I1Er3Bdl+3cAdftYwLDkA0JtmFlT9xKHYk3qk+wBtFuLld7d/U//+COMwY8ZRZAP+6j8pNt+/7INrs2EvdTUtQh/XXwsdzkou/2oOvzjSua2ba7b7DRrJA6zhhFXMBrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757932660; c=relaxed/simple;
	bh=zlOsZ+wiOVd8xobAvcf6pl28vXM2KBVnFOY+OSZqwWs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/XN8TzuePUEyyEfs1Vmx17uCtQcUBPv/D10zNajdqedZV58bN43y7yuPaDN7pV+eUMu+BlvfWES3J8SzH227L5+ZA4lxBTDWLW+vefLMZCyATMBhYMUwUfJ2qPhUub732pgIbQXxw++RBbD++Gung3txHeFWwAL5GHRsKxAKV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FBwkUPKT; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHdKVAcynTn9OmigK7obBxm/33Fj2ApVJDjbKxZAC2aOtuGDDSAg7uKmfWPGW7CvV6mylz+442qEFkxOuJtP/MxMoD/nK3HQZnlD7kudG/Fjh97RvoZraGgAcJP9okyhK5/3fxZeF5cqP5RVx+4DoC9q8Dc/LMT6QviQlAUoZVETmuIvf5prmVyJpG11qnmOx+tA/NdZkdBSO91oF9Q2c4ak/ogU4+/BzPDZZ9HQmBZiqE6WlAx5H0ALqy7tiHygBfbtODj8O+1VGWqjJzRw4ekZpFkxam/nfbkxiZWT9Ts7W+GTn6b70CBROOYb53BlL45K/E6fP4E49Ww+eqavKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95wjM6milkP4Nm8LXeg6XIyGQcFU+5CzaG7AuMydvBk=;
 b=ys8CuC5exEmCObnaFozvAfLREKDroJsRDRSxNO48gB7QKzH/jXB46jKNTzueX23yX9Fzelo3gnbfVFJUtXY6v2Uk99PVSkRJPyoKbOQh33ft3re19wspx3EBp243VeALPIy6L07LPD3B63f9CEPVa8iMH5E2TB5gYwOA4bfxGHTSa4rY167VGCeafpAlpkb4JMs7IHGx/pFKA5qZFcyTjgKYRGbjRxP+Ps0ds6t7FyxcFYeLfnyUkvxJHHkGRbEJXJJulJCMGUAdXAafaNXcWuWE+9pFh8HlGLuymetdl8ppLaI0ZtJVMyEJF8zf+feRwKwP1euOLSMUtBe12JdT5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95wjM6milkP4Nm8LXeg6XIyGQcFU+5CzaG7AuMydvBk=;
 b=FBwkUPKTHgSqHHnmO8VMzgtwD40G/FDUET1i/nThxqQRIGjt5I4xYjfW5UZ5DYQIY429eNsqBxxRxk6VltDTulj9/cpWP3siseVjm5MXQxusxBMMaLRRl0eb2vSbvRvBh2oWjE5tmx2kTvenHIJg8DHCcHNK1rgxoKNWYAa1/mo=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by IA1PR12MB6385.namprd12.prod.outlook.com (2603:10b6:208:38b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:37:35 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b4) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Mon,
 15 Sep 2025 10:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 15 Sep 2025 10:37:34 +0000
Received: from amd.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Sep
 2025 03:37:31 -0700
From: Akshay Gupta <akshay.gupta@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-hwmon@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <arnd@arndb.de>, <linux@roeck-us.net>,
	<Anand.Umarji@amd.com>, Akshay Gupta <akshay.gupta@amd.com>, "Naveen Krishna
 Chatradhi" <naveenkrishna.chatradhi@amd.com>
Subject: [PATCH v2 5/6] misc: amd-sbi: Extend support for CPUID protocol for rev 0x21
Date: Mon, 15 Sep 2025 10:36:48 +0000
Message-ID: <20250915103649.1705078-5-akshay.gupta@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|IA1PR12MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a04df3-6d95-4228-ee12-08ddf443e21d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1nJSKFayEtRNCdsv/UYI8UDtK0itoq2QjeDNK0NYkgHBl1116RecdoraqX4/?=
 =?us-ascii?Q?FoJb8E1mlSEwu02phEmCuKSwWNVmFvSTMIiYHQsPAo6VO75Y/5qCaw1SWCjB?=
 =?us-ascii?Q?f1S5RQU1vZkS8BXWruT7dSKjVqJsYO5goWxI11Ea4oK6Yv5x19+EDgTihmGS?=
 =?us-ascii?Q?0YZ9+BK78+1pWfj69tQMTB8XY1pBOIQjRhAK+wiMZ6JPORbU87tN4F80Gd80?=
 =?us-ascii?Q?L/rICcEwqvqTxD/8XsO/nm2HsaJVpGoT0dPN3gW59KgxdO/Ix6zYl8Vzo1QM?=
 =?us-ascii?Q?gX5VLmTr844/UAI68EA79Pj5Ls9vpGC0z5e5sYtxPd6YkZyLgP/ctD2IupsG?=
 =?us-ascii?Q?D5SkYfT6O/Vtbhjh4wBdjRMXuypwO9SJIF7MUqCGeTGqREWhjYCkgx4zxg6U?=
 =?us-ascii?Q?BbCdw29lA/cVF+UpLM5BqNLXM/5cRoLfPiTV7nQsV290vDc5WxKP08nX4j+e?=
 =?us-ascii?Q?WuO0F4hkvnpo0Kj8E+ZeprzJNqGuCQB/4O5EPxzi+xY9v1s1kL3vXqW4sS90?=
 =?us-ascii?Q?eFITJpfV4S7nS0NgeLF3unqAiApRW5OwEkbik0k47RhdMT9PV2D/Rvgl/HHy?=
 =?us-ascii?Q?MJHTrtnyOdIWahnamSXP/DFHgWrcVMJjrHVDeJDy+Wxg3y4+HA+hK1IxwYFy?=
 =?us-ascii?Q?ZzrV3SmBxnvGcdGHRXTpokckEBTNG8CS6WcYW8TuV4Quv4id4QvYL7EcYV95?=
 =?us-ascii?Q?Enn2rX4hdZyac/6H2l0xnEGGewIqeLM1gTToJxjG1LAyX/wU5nYLvbU2jTWA?=
 =?us-ascii?Q?SlUyTqq0uSRXyF+EOUIoZX/JYp01kpiWxiMh6CgsuVYdmx39J3ZQWE/8liXl?=
 =?us-ascii?Q?6p/QmIIYRSwFvIduwTfip0Wbch5XwSDKacPkHa1jn4eDCXA0LRDEnnMopOtQ?=
 =?us-ascii?Q?OQ7uhDqODLvZqM8ZsIbQtNFcZWwQn+PN1MFFSzMYMDDNJng/p0YYWxZog//K?=
 =?us-ascii?Q?uxEWjDyEh69bdk43kqVwhs/Jk42Q2+8MIDZCE+k5sbBGGHkAPJ2/a1f/TbeO?=
 =?us-ascii?Q?3oZ/xNplMez7ma30GnFAk6P8pVdKCQUM8NzcyGOVktAJ0wj0olk/r4c7I9PQ?=
 =?us-ascii?Q?emsggYOxLN7KwBhLTOEeckbmb286mmKFUR6EPEgWCwGQe6tOExx9llPD2dKP?=
 =?us-ascii?Q?qqLO80OKYF/jWetEPD1+Hmfko622TXP/pi1c6oI1RXQIe+zmpZPAiFVJ8h8b?=
 =?us-ascii?Q?pPoWfwefXp5y1pYExervzjafrTw4x8RWAtFH/NBvgoFhfDj2QhOy+Aa3eZEy?=
 =?us-ascii?Q?vyvlNxt3f629HHrlUgl5qCL8PGmvtG0N15FV89DjM/ywKSbFNk/OZQXciTt0?=
 =?us-ascii?Q?9nUNYnPNP+EKLinDAcLcE+j6wwPqYfmj116eo61tD4h+xBbHYMTfdmjh8SwN?=
 =?us-ascii?Q?qNpD9fng1HJRCqx2/3FyVEypTEzb1IAznHpFyRuycMpcqYbakHRNaeD1t8y9?=
 =?us-ascii?Q?PCWSHgc7T4Dw+9YSMbemZVtjYPWMbCu5GPTHZyFJPHzDljIeTeVb3+5PyRqL?=
 =?us-ascii?Q?csQc5b1GX61EpbC+Eqym+Qcfz/QC6e93yF/K?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:37:34.8745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a04df3-6d95-4228-ee12-08ddf443e21d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6385

- CPUID protocol for revision 0x21 is updated to include the
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
 drivers/misc/amd-sbi/rmi-core.c | 106 +++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/amd-sbi/rmi-core.c b/drivers/misc/amd-sbi/rmi-core.c
index bf534ba757db..ef93dce7e038 100644
--- a/drivers/misc/amd-sbi/rmi-core.c
+++ b/drivers/misc/amd-sbi/rmi-core.c
@@ -28,8 +28,10 @@
 /* CPUID */
 #define CPUID_RD_DATA_LEN	0x8
 #define CPUID_WR_DATA_LEN	0x8
+#define CPUID_WR_DATA_LEN_EXT	0x9
 #define CPUID_RD_REG_LEN	0xa
 #define CPUID_WR_REG_LEN	0x9
+#define CPUID_WR_REG_LEN_EXT	0xa
 /* MSR */
 #define MSR_RD_REG_LEN		0xa
 #define MSR_WR_REG_LEN		0x8
@@ -59,6 +61,20 @@ struct cpu_msr_indata {
 	u8 ext; /* extended function */
 };
 
+/* input for bulk write to CPUID protocol for REV 0x21 */
+struct cpu_msr_indata_ext {
+	u8 wr_len;	/* const value */
+	u8 rd_len;	/* const value */
+	u8 proto_cmd;	/* const value */
+	u8 thread_lo;	/* thread number low */
+	u8 thread_hi;	/* thread number high */
+	union {
+		u8 reg_offset[4];	/* input value */
+		u32 value;
+	} __packed;
+	u8 ext; /* extended function */
+};
+
 /* output for bulk read from CPUID protocol */
 struct cpu_msr_outdata {
 	u8 num_bytes;	/* number of bytes return */
@@ -81,6 +97,19 @@ static inline void prepare_cpuid_input_message(struct cpu_msr_indata *input,
 	input->ext		= ext_func;
 }
 
+static inline void prepare_cpuid_input_message_ext(struct cpu_msr_indata_ext *input,
+						   u16 thread_id, u32 func,
+						   u8 ext_func)
+{
+	input->rd_len		= CPUID_RD_DATA_LEN;
+	input->wr_len		= CPUID_WR_DATA_LEN_EXT;
+	input->proto_cmd	= RD_CPUID_CMD;
+	input->thread_lo	= (thread_id & 0xFF) << 1;
+	input->thread_hi	= thread_id >> 8;
+	input->value		= func;
+	input->ext		= ext_func;
+}
+
 static inline void prepare_mca_msr_input_message(struct cpu_msr_indata *input,
 						 u8 thread_id, u32 data_in)
 {
@@ -105,13 +134,48 @@ static int sbrmi_get_rev(struct sbrmi_data *data)
 	return 0;
 }
 
+static int rmi_cpuid_input(struct sbrmi_data *data, struct apml_cpuid_msg *msg,
+			   u16 thread)
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
+	prepare_cpuid_input_message(&input, thread,
+				    msg->cpu_in_out & CPUID_MCA_FUNC_MASK,
+				    msg->cpu_in_out >> CPUID_EXT_FUNC_INDEX);
+
+	return regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				 &input, CPUID_WR_REG_LEN);
+}
+
+static int rmi_cpuid_input_ext(struct sbrmi_data *data, struct apml_cpuid_msg *msg,
+			       u16 thread)
+{
+	struct cpu_msr_indata_ext input = {0};
+
+	prepare_cpuid_input_message_ext(&input, thread,
+					msg->cpu_in_out & CPUID_MCA_FUNC_MASK,
+					msg->cpu_in_out >> CPUID_EXT_FUNC_INDEX);
+
+	return regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
+				 &input, CPUID_WR_REG_LEN_EXT);
+}
+
 /* Read CPUID function protocol */
 static int rmi_cpuid_read(struct sbrmi_data *data,
 			  struct apml_cpuid_msg *msg)
 {
-	struct cpu_msr_indata input = {0};
 	struct cpu_msr_outdata output = {0};
-	int val = 0;
 	int ret, hw_status;
 	u16 thread;
 
@@ -122,31 +186,29 @@ static int rmi_cpuid_read(struct sbrmi_data *data,
 		if (ret < 0)
 			goto exit_unlock;
 	}
-	/* CPUID protocol for REV 0x20 is only supported*/
-	if (data->rev != 0x20) {
-		ret = -EOPNOTSUPP;
-		goto exit_unlock;
-	}
 
+	/* Extract thread from the input msg structure */
 	thread = msg->cpu_in_out >> CPUID_MCA_THRD_INDEX;
 
-	/* Thread > 127, Thread128 CS register, 1'b1 needs to be set to 1 */
-	if (thread > 127) {
-		thread -= 128;
-		val = 1;
-	}
-	ret = regmap_write(data->regmap, SBRMI_THREAD128CS, val);
-	if (ret < 0)
+	switch (data->rev) {
+	case 0x10:
+		/* CPUID protocol for REV 0x10 is not supported*/
+		ret = -EOPNOTSUPP;
 		goto exit_unlock;
-
-	prepare_cpuid_input_message(&input, thread,
-				    msg->cpu_in_out & CPUID_MCA_FUNC_MASK,
-				    msg->cpu_in_out >> CPUID_EXT_FUNC_INDEX);
-
-	ret = regmap_bulk_write(data->regmap, CPUID_MCA_CMD,
-				&input, CPUID_WR_REG_LEN);
-	if (ret < 0)
+	case 0x20:
+		ret = rmi_cpuid_input(data, msg, thread);
+		if (ret)
+			goto exit_unlock;
+		break;
+	case 0x21:
+		ret = rmi_cpuid_input_ext(data, msg, thread);
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


