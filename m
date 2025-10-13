Return-Path: <linux-kernel+bounces-850742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A26BD3B01
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 513153E7B60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974E309DA0;
	Mon, 13 Oct 2025 14:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e7rWfbLu"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012047.outbound.protection.outlook.com [40.107.209.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C6130DD18
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760366164; cv=fail; b=W6iYs91cDwqV2kEaIlF3OzPZuBFeRwCvVZ90rDLnIxVjR5KCiLImCnaFrdGoiDyD4kUvjsgEG023wjx+/Tf1pxECsFxaOxT4Na3Sa95K/8vjQRKfmj+bmTFPk23p9q7wkUawQqIBwDHEIFxMdf70V+mtQAlCKQoEWpPuzta2Kf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760366164; c=relaxed/simple;
	bh=szeS4IYBZw45VvSXuyKlguFkjaHmm6G+Hct9m/E9jGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/mbZZZAKRjtNB3Li2lEU3n6tUu/Ub5q5Z7HlgI1WreV12YFj6UBJx3uOqTGYj/WJMoP4LYZ21hw6WcpJc97/ULmfl/GNJxm+02oDfo/JULX715PBNEoUE41To1qYwCDEGV0zZEGqkPi7vWp60yv00qT3y3a9PGBXYcV5VSNlGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e7rWfbLu; arc=fail smtp.client-ip=40.107.209.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfC1b0DbopiqdLaNlhcRE7CRXuymuw3bwF7plvt0Fjoh+3j36xklSjar8rYP4q/wkg6cW9p/Vb6i6khOWY07AJTV0LfJewdFQfQWbMopOsoUT8u9hYZm3+26Gp89fEVKCMUftnfzPfya6jZECUFnr6SqehckhCZqpdx4luMz58NG76CfDwZpt/J4U9ljONxPkvlSwgPjDtYdJzm4Wzd5X2B35iGhMfDzDyGuiHGNGoTwaHku4BDA2JnnGftm4Geno+/lVplBqcYhjNx36+b+CpiMvckdtpHS9S4VPgfipH/c4Fd9aP+dvu/HrqJah7GjGeLtBqq/ALxWb86qihXX8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c20+54u+49uHkZjCXO9IZGkP1A5vaTTZmrbwnQaZU2s=;
 b=XGVaM05FHSzUg4lpD92n+Fjx+qpK3nQsRFSHa2P8m422yp8gLGVePR/r0/s2bfsLixKEtGTyA8+CWuBCAildv0HKNSKHswAi7+JilI9RfLxIo0MQLw6WeIKiKr+l/XxqB2KILHnL6bCVxwvO+STSkvkJNyLo/0oh3uy+qYV8E+fhVw8J7IplswpP//VW8JzmuZ9M89MA8t7TagnWpWkvGzbLo7QVdax7t5QdUvWa9R1cB6a2U3BRbnROOEW1b9Y9SwqRCxVAFsnHd8p8MbQcy3cBNe4WE4Mzs5p+Yg3c9UXDSfKkugt/hFifWQWFpOTWigF69ZJX6E6FonscY65ofg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c20+54u+49uHkZjCXO9IZGkP1A5vaTTZmrbwnQaZU2s=;
 b=e7rWfbLuToeQC6JNNbAjrtnEZtuDNpRJUUTYlHgxsgOoleOiDj5djEUxqouAewbBn+Pn5DoHRcfoZf3NjnD0mGpUurbJXG+X6DfBDqiAhI0xktOLMD+DX41nhlDUt3+LF9eKU3i7tXpJAvBwc0UkZn/vUlplUBYtRxoInGxTSrY=
Received: from MW4PR04CA0103.namprd04.prod.outlook.com (2603:10b6:303:83::18)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 14:35:56 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:83:cafe::b2) by MW4PR04CA0103.outlook.office365.com
 (2603:10b6:303:83::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.11 via Frontend Transport; Mon,
 13 Oct 2025 14:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 14:35:55 +0000
Received: from tiny.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 13 Oct
 2025 07:35:40 -0700
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 31/56] x86/alternative: Prepend nops with retpolines
Date: Mon, 13 Oct 2025 09:34:19 -0500
Message-ID: <20251013143444.3999-32-david.kaplan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: ac3c5664-b7e7-46aa-9ded-08de0a65d1b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2o5D5j4NJiyqrcIWVi66FO+0HnuNCXKktD9YUI/eJmJrbBf1sjHtJpKGNB62?=
 =?us-ascii?Q?G1LgKyLVJ92tMzwpF2vjFWtho95le5noF+CD5FmciWfBVP6pG19cg7P+HDNn?=
 =?us-ascii?Q?kLrVwAo/e+PBAd2LWfZWJmFu7tnDwQ1G+GU7Wn8Mr34Ml/lZFvdakK5hh6cR?=
 =?us-ascii?Q?yTOop8x02NZe9JoAtKOnB96cLuUMgxiBG2JKv84J06pSG7W7xk4W20lW6djp?=
 =?us-ascii?Q?SYQf/LdrKYJw5P6PmxKygwqfHAY1Pktu1zGk8Plwgg6hozvS8MKfPZkALk7B?=
 =?us-ascii?Q?gJCHCW1NEr/nsfnpcAfPPSX59Zizt2M4dInjZJ5cayy8ry5kEJpyg3K0wI7Y?=
 =?us-ascii?Q?2BdJrKmHaTm2SnnyAJ0mMQvWwzqoektoRMIq9jjbbMB6FVNfh6infRddBoG4?=
 =?us-ascii?Q?GFsHXpTF1Lp/Gz5XqChKa/HG53Kj/7YMv8sKgOo4ld/oQUuT7/tnIMBZgSoy?=
 =?us-ascii?Q?2r+V9STF8bXhRd646/jz2H5mouWFiphGZdZxiA6XVE631WpLQnw6PdQQly+v?=
 =?us-ascii?Q?NhZ+XfG/0mo7f9QRT3bfsdg+lb8Gq/DOER0T5KojAoKiDtlm0kG3pkW3WOpj?=
 =?us-ascii?Q?skO2l63wYGpIrekApej69xyxyCpr93OQEWxLJwR2I65ZcbEInHgXm4xT9tf0?=
 =?us-ascii?Q?414QD+RHw0XO2516pxL4LKiUofLTTBKgbPm3A5GvBECLXqmzGkCVSzRYp9b+?=
 =?us-ascii?Q?UpnwFVhrihVoVZhBRZrB1mfQ5ZbPXb34kbgyQoyf6eM3pp6zzsJL/XDfTP0C?=
 =?us-ascii?Q?4CUpeF0mEzsaRtTys4jMvu10P3J6mdLk0VweJewtjYBEZqczGhuVle8NAOJp?=
 =?us-ascii?Q?4Kkr4AZbOAP3V47XbFlaRQeCjanT8vZrffPWckTcZQk0tmTeJHmFZ9oe+WZu?=
 =?us-ascii?Q?P391z5ZTxDfOZygOyKLtbBONVcczK4BY5bmqRDGRgqEcuX0lyYoEl7FpJMAD?=
 =?us-ascii?Q?zjrTQ4f4fE5MOf4mNBLZlw+zMWuvaHXIikOIsXD/DQAs421459sqV0n7OBV1?=
 =?us-ascii?Q?hr5PTVqvfTyLyjmS3SgXh+N1Xs+LC0KYDN4lplUeK6vLwPPHOjng3HqAPn1d?=
 =?us-ascii?Q?4MzBNtmKyb1NOQ3+5kF+e90ZNvoNysaJENM6Ak919o9YJ2DjB5w0rqlu1F8K?=
 =?us-ascii?Q?bh3Z0y+BTDTPaYMI52J8UkObUyFMZII4j8912nE+uqYwbAW8cGuklXKB+kxy?=
 =?us-ascii?Q?+cnk3S4wpBTgdLNPYZbSLvDBLKzcz43Wibh9Ymc84uTt4VBMJFQAvgpovpkt?=
 =?us-ascii?Q?WCTaVCetsOZDLqer9IcSYNO6lGmoYJ7Zpfm5nxkNlKSXXgDHOWPgnsChspbA?=
 =?us-ascii?Q?1VLdpCOIURmy1wvui+3euO3VzOvvkYHQmYyVUaoEJBTqeLg57DXppd36QicE?=
 =?us-ascii?Q?fMMYuEzA5TtYL5MAQhTrAVxCJ2Z9TOBlniQ50+lHL5Eh5VOXJvbK8UymtrKC?=
 =?us-ascii?Q?jhIQyZbiR39+IclNF0DHAP3WudpwcqMJKiN7TaiyOTHXd28Ovl6jUeWMBgf4?=
 =?us-ascii?Q?HOTpU+ILEQ7AOVfZLXt8b6AIAaQsQ/rtiBZ9e/yJdJCG8ZDe4JG1c1C0BtLb?=
 =?us-ascii?Q?9Sg9f4zlj+7MYb5k/JE=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 14:35:55.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac3c5664-b7e7-46aa-9ded-08de0a65d1b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

When patching retpolines, nops may be required for padding such as when
turning a 5-byte direct call into a 2-byte indirect call.  Previously,
these were appended at the end so the code becomes "call *reg;nop;nop;nop"
for example.  This was fine because it's always going from a larger
instruction to a smaller one.

But this is a problem if the sequence is transformed from a 2-byte indirect
to the 5-byte direct call version at runtime because when the called
function returns, it will be in the middle of the 5-byte call instruction.

To fix this, prepend the nops instead of appending them.  Consequently, the
return site of the called function is always the same.

For indirect jmps this is potentially slightly less efficient compared to
appending nops, but indirect jmps are so rare this hardly seems worth
optimizing.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 arch/x86/kernel/alternative.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8ee5ff547357..7a1f17078581 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -854,6 +854,21 @@ static bool cpu_wants_indirect_its_thunk_at(unsigned long addr, int reg)
 
 #endif /* CONFIG_MITIGATION_ITS */
 
+static void prepend_nops(u8 *bytes, int curlen, int neededlen)
+{
+	u8 newbytes[16];
+	int pad = neededlen - curlen;
+
+	/* Fill padding bytes with NOP. */
+	memset(newbytes, BYTES_NOP1, pad);
+
+	/* Copy the new instruction in. */
+	memcpy(newbytes + pad, bytes, curlen);
+
+	/* And write the final result back out to bytes. */
+	memcpy(bytes, newbytes, neededlen);
+}
+
 /*
  * Rewrite the compiler generated retpoline thunk calls.
  *
@@ -942,10 +957,16 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 		return ret;
 	i += ret;
 
-	for (; i < insn->length;)
-		bytes[i++] = BYTES_NOP1;
+	/*
+	 * Prepend the instruction with NOPs.  These are prepended, instead of
+	 * appended so the return site does not change.  This is necessary when
+	 * re-patching retpolines at runtime, such as via
+	 * CONFIG_DYNAMIC_MITIGATIONS, but do it always since the performance is
+	 * the same either way (other than for JMP, but those are very rare).
+	 */
+	prepend_nops(bytes, i, insn->length);
 
-	return i;
+	return insn->length;
 }
 
 /*
-- 
2.34.1


