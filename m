Return-Path: <linux-kernel+bounces-850717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A42BD399C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E103234C6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025073090C9;
	Mon, 13 Oct 2025 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZoEQPvjT"
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010019.outbound.protection.outlook.com [52.101.193.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669B52FE58D
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366131; cv=fail; b=gOCQBYR4DvjE7mb2af39WwU9auoEK6B1TnDujcIYzGv+7+fgYtcHVdUqO+/0ctTvqR7fWZsu6tIfsAPonwo9+mLJl1IllAn6s8hec9SpekyZLmUdAXYIUNpeWUSKVLDkhaGwgDRChjQJSpqWVKtoL9yhEBSMBf6n5XDERAvRhbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366131; c=relaxed/simple;
	bh=mPmO4VjgJZZcCIqmj+H4S/il9Swbp6apQuxe3Q8Py9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IsNU9YSUEUShGMXg9L612BUCCJRIwVNTSMw8oQtn1VPEB9QWjn9xt4JmaszixzuB1HBgWLnnK2BDJ8wg1dUNJNYlQW2K46UR1sd7qLnSa1jqINNt5Rf8a4uhHUcrrSzS3kVW8M/rFuWQPS/osnmL0P4xHz7zDNP/kvxhBve2jyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZoEQPvjT; arc=fail smtp.client-ip=52.101.193.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cY6M7RqcNvym/jkKWwDXS4cDknbsZhAtQAHicziLMm+xqVe016VqjKoU4dJJRRaVC4zz06G85MxszZ27ECpdnNlhZYWX9HNi9I9xgJFgGjqo89MC/a+FfsFSoo1Qd7cwligouL4bP42iVoDINaXkwQGy7Nlckt2zjoAEZ/Et/HnojdJHLejgIV/DX2tcUqqd8nBijZhS12chM32qJsHuopEo3mBkreOrdhLAKznXjl3efLvLPY6aSjuZ+ikvAfXuY7+RVICer8FOCVuFyU9lqnl6PZMlGjPIrjJ8KdLdGhzLaeGwW3DGBkEzfJAY0iXBu7BnW7PHyG0XP7imT+NaeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRBL9Hj4FaW4VfFzhKJk0IoidMKl7iNIeZN9GRd362Y=;
 b=xYxbzuBinMinmjXa1nZtnzJxIqmIcJbD13dLiD/RzFJu0ADkd6erc3ggqcLvnxXUfdXF0T+cp26vcqi9RGs0fhrbVtr0EMuRE+Bziv1ubvQnzfhqly2jKAWdKaWTSZbYPA2kfqPgqO4G3fZExpME9lPOWdKhESE4rsHqF2hyWgMLHiU4HRMjG5T28FXxTcaej1qE3+TcbwQobP0eEFOTV3LKc7liR/SFqkty+Uj6iliSbodGriiDLjQcNAmSsWmXj0YJvOMPJ+wlOq0bHZ8zcMlnSp5L0T0aXVKI943gIgYMvEXWIhWyTtXFgrnt1Wk0oAUisvCYaLC3YhaBZt1Anw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRBL9Hj4FaW4VfFzhKJk0IoidMKl7iNIeZN9GRd362Y=;
 b=ZoEQPvjT/AezEezWYAEj+AqEUqcLa/yZdrF0Pi+3KKZQrzsNIYxXJw28KCHoM9sRkeWv4DxyQAyhcKFmZzscA3pE3jDNpcj+XPNvO+oL99Akkro9JzhyH5ZRaXNLnKSWxqwKWrLWUdAve4vTODK6wSDQ+iXUo8Vr6IXNNLlkcJ4=
Received: from PH8PR02CA0029.namprd02.prod.outlook.com (2603:10b6:510:2da::27)
 by CH0PR12MB8551.namprd12.prod.outlook.com (2603:10b6:610:186::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 14:35:21 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:2da:cafe::8b) by PH8PR02CA0029.outlook.office365.com
 (2603:10b6:510:2da::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 14:35:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:20 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:18 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 04/56] x86/bugs: Reset spectre_v1 mitigations
Date: Mon, 13 Oct 2025 09:33:52 -0500
Message-ID: <20251013143444.3999-5-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013143444.3999-1-david.kaplan@amd.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|CH0PR12MB8551:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e730985-59a5-4be6-021f-08de0a65bc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iF7p5F4zUMhRB92uiCWeNGz4uR3pVJ/6MBSKtdvFOMpQ8cc0SUzFQ43fLIt7?=
 =?us-ascii?Q?p5uDhBbgnucbKGz8RZoZZDBjRIfDh1UzKSbAA/SoaVaCGr9+8jhtXO3nV60D?=
 =?us-ascii?Q?RMmfbxLQsx+GNFr9dhYqgJNIO0IMBs6xq74kQT82FJWfdTFe8OrVj1DtkBRG?=
 =?us-ascii?Q?gynFEsnL4b1ePFjYstQfBPFFFMCYqkju2dVwENwGR4QHDbf6/3UhB4PEo3dL?=
 =?us-ascii?Q?bgUGWpkQGZzlC88O5YrmN/flr/62ND3DqGAUBnCP4TP9oF8iFY92xo+TPd3y?=
 =?us-ascii?Q?fq86DFPL1D+FcTEt62ZpGy/u2P1Toc1g2K0l/1RG0x68bf7+2cap1pH4KzMM?=
 =?us-ascii?Q?k8KE9adK9vfmxnBsPbEiTlBfJHvu2XfE+p4Xm/GsZQLTHd94Bq0bTcYwk4yY?=
 =?us-ascii?Q?gyJuTOHfo9JmWYnALki3PE0F2Ar5GkwWFRizd9zRwzRGaCOVAE1rZkN7ZIyZ?=
 =?us-ascii?Q?PSaq4GYZ+nrWmvsm+DwoULyiwQLq1lte5Bh6q4R6PFDOVvg7tEttqU06kMMl?=
 =?us-ascii?Q?1AjksTF0KMlhIwbrydvC9zrOMvzRKRUgyqUHTqpbA6Cj6+tIJbNixCgOATxB?=
 =?us-ascii?Q?vVYPdnkHLVgbnw9ObUCgMUkK8kh9Y+aDtFP0Qc/gM+VGXpdtXsSK/nKnl6CX?=
 =?us-ascii?Q?yVHheeDCCamyTpqdm+UEqsCYWAMI1fgB/9Dhux8ZnodKm73pT4KOeg8cFG8H?=
 =?us-ascii?Q?6x3ERKURffzmVId8N3s3wOg7NW3zLmovbfOcZ4rbp0GGqtWWJOFeIfoNGXQx?=
 =?us-ascii?Q?vBi8oiQmPZ/dcTAyerE3fe0or+4fid/1xbIfHoYNkLky2NrNj0ooQ9BmXGs7?=
 =?us-ascii?Q?9m/wpz1H7r5bQRY2TZ627iDL+DFZqAYQ0ZynyUIgfyLrKjiKwfszq+IGArp/?=
 =?us-ascii?Q?edzZ/j6HaxgyKKiT51Z4VYRga2oq0rORJhqKawrQ91qegZ/CELiE8gtf3fiz?=
 =?us-ascii?Q?u6A9d49Uu2pkoNvRmbiFIx+Zc+3szwNcixmcWu9I8lW8FoqkCgapJe3sr1Ms?=
 =?us-ascii?Q?+T1LrpqIhoxIK3VeqUIxMrxyZGiUerRIMI9Z74k/MC5BXhpsi1EK2y7V05zC?=
 =?us-ascii?Q?E9FZ0eNsf+8LWlyF5kywZ3rrWLnifUvGH8Nn7rDsoLOn76nROnUh2dHkqjqP?=
 =?us-ascii?Q?QF+MIfBDLGGKQqwv32gweydae4Yjey4OpGeIncM/O31OKswrGegWmVqlo7gL?=
 =?us-ascii?Q?NXQSuhaMNb9ziwGTRP1S4ScT009jVbBcvMq78Xmdz0Miyub3e/sTvMJ3e6Zf?=
 =?us-ascii?Q?px3HgfSnkdRhzLqikw7qlOnYOBscCdK85jps//1Hpffia/iswYzxoPK0pSOD?=
 =?us-ascii?Q?zHQjwNU9ahvAFJcHtWUwFCIntpoXzbDXEoD/j4HDIi2qSmWcA5atos44nj9/?=
 =?us-ascii?Q?fY8pyfGZ62S6CebrJjjrLUtw0jprtFsp3u5ON0URyoxTWZbjqPXvhe93Fa1d?=
 =?us-ascii?Q?+fg0ivqPVMNgXR5Bm7fvEYolI0GU6BjF1OComZ1FZpoCeBN8OqoQ7RoAlLQT?=
 =?us-ascii?Q?LiCPepENIlBj7qV1Y2uU5Ist8dXidi9H3CU9bzyNpP0finZV/efy50y+J0cN?=
 =?us-ascii?Q?8YVbvjilV61xDA+gLhs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:20.1099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e730985-59a5-4be6-021f-08de0a65bc63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8551

Add function to reset spectre_v1 mitigations back to their boot-time
defaults.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/include/asm/bugs.h |  1 +
 arch/x86/kernel/cpu/bugs.c  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/bugs.h b/arch/x86/include/asm/bugs.h
index f25ca2d709d4..e43b9412645e 100644
--- a/arch/x86/include/asm/bugs.h
+++ b/arch/x86/include/asm/bugs.h
@@ -11,5 +11,6 @@ static inline int ppro_with_ram_bug(void) { return 0; }
 #endif
 
 extern void cpu_bugs_smt_update(void);
+void arch_cpu_reset_mitigations(void);
 
 #endif /* _ASM_X86_BUGS_H */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6a526ae1fe99..9d5c6a3e50e1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -46,6 +46,8 @@
  *				   may want to change based on other choices
  *				   made.  This function is optional.
  *   <vuln>_apply_mitigation() -- Enable the selected mitigation.
+ *   <vuln>_reset_mitigation() -- Undo's the apply_mitigation step, this is used
+ *				  with runtime mitigation patching.
  *
  * The compile-time mitigation in all cases should be AUTO.  An explicit
  * command-line option can override AUTO.  If no such option is
@@ -1247,6 +1249,15 @@ static void __init spectre_v1_apply_mitigation(void)
 	pr_info("%s\n", spectre_v1_strings[spectre_v1_mitigation]);
 }
 
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+static void spectre_v1_reset_mitigation(void)
+{
+	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_USER);
+	setup_clear_cpu_cap(X86_FEATURE_FENCE_SWAPGS_KERNEL);
+	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_AUTO;
+}
+#endif
+
 static int __init nospectre_v1_cmdline(char *str)
 {
 	spectre_v1_mitigation = SPECTRE_V1_MITIGATION_NONE;
@@ -3794,3 +3805,10 @@ void __warn_thunk(void)
 {
 	WARN_ONCE(1, "Unpatched return thunk in use. This should not happen!\n");
 }
+
+#ifdef CONFIG_DYNAMIC_MITIGATIONS
+void arch_cpu_reset_mitigations(void)
+{
+	spectre_v1_reset_mitigation();
+}
+#endif
-- 
2.34.1


