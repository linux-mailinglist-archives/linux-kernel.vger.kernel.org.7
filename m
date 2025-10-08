Return-Path: <linux-kernel+bounces-845897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A522BC66D9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE333A45B2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151812C21C4;
	Wed,  8 Oct 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1i1XD82"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E601F9EC0
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950610; cv=fail; b=ELvSMGQzca0Q7gnSTFPi7p9PrpTuctb+Uc+/i4tTQGMKCH41d/Oy17XZTS/YpMXqt4rqzWnEyOabfvDpK/9FaohYqnAD+Ee5fOOTz6qfYh8sODTAJKwui4TxYTbyJ7XEZ+LP6vyduJjU6MiLmWnhZ/lNTfb0E/jYS0+VWkq45vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950610; c=relaxed/simple;
	bh=MUZqoQQSunhMSakVJ+bU7rwve5OX4Eom6gkPxqOtawI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmFg0dKk+Vo6j9GB5ytzqjjzqjRb1AShPjPcRD86Vu4HQlZrHnOVnyxOMQLL/uFUfvHAhNapXxNThca5MyXycmvO8MpYUdLd5W/E2Bhc/K8Hz9gJvmLEnSk7Er0yD2FejQvAXHrn6n5HidM0oQodI9iqaKxgNnZQfx8D7v2hWIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1i1XD82; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyqfskeyaqNvM4ZUIjWYditL71OZO7ICiMQttWzbaNU3HDGg+AeuJXahMSNiegYrjbDCYWvlhI0T+TFTLJpbLi+IigKCq3wXzwcQ9omgviR1o/J2/BxhhNJmKWqLdYI0+E4Nnvq29nupWaGP3EPZB9mXU3Uk0bVGMyuITv+1xzvRJKwmblbYPIa/To6zsHBFf0IGqqp1XLL/b9gLQ6fC797EnyjiML39dnefV2fnL5qZHF0suefFjuPsRcorPV6/zJt4GA9bo2I8ncQYCm8yZiBtQctTwTjEjtKwgBoqBkP3ejkEleok7JQZSmbqArF5QRoWiuEk0ay1DaZNmkxKbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jidatQNOkEdavEkWfDkhye5C63/P3ytt1dd7M8Rl2Vw=;
 b=aFRyNsCtSNLu5b71xZLyyejoS414WohNiOOSfrpowChqWmvv2bkNyWM7O6VyqyvcffveZa+/x5lqsZAj4WnCJM4i39JuboIqs17kQ/baQ/phE2hEOm58G0xiCE776UT5t7tr8EeLzuwDRdB72O49gmYDXMBSutMOzQXFfDyvub7+u19mrn+DbwLSy0bEKaYhJXGXkE3XyJ6fRpowksim3x9bPlZ/rpcBaWNw2XfKdIPB4UYnSH9SXk/goS206qaBurN1oXuSMhn4+CtdcbbrspJAARhuToPx+FkaZkkNV06BuPK0IG/fS2Mp5Uv3IMDEaawOGrO9+V67SWc2Gv8xvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jidatQNOkEdavEkWfDkhye5C63/P3ytt1dd7M8Rl2Vw=;
 b=f1i1XD82RML25RteFlnLitmunJJMYykOcC5BFjzMLKLR3rkYsr7NPHITlysr8v3MZczL9JgJr3enLB8rp5G8d/C8LYI0T1z3MBGJ6H0um0DJAPcrSv1HQX9+932G63QuGl6h8G9EE4mqZARrzmgy84jkTKjHUuMrGllxT6tEGmOKSG6imNu3H7AfzrF7QcD6nGHnoU9YHQ3CkHzzpDolqUwuaV0DXRdYKifSkNorSuqb4Jf1oSaUBlPYAd3nJ+EFT4JFXvY6fUZW7kjpqr/oU1HF0SInAULoV7g0UV6WqnNh4hQSXMfQZBgupelX8H2EPC9tcVSC0qdvzaqwGRRjOQ==
Received: from BN9PR03CA0363.namprd03.prod.outlook.com (2603:10b6:408:f7::8)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 8 Oct
 2025 19:09:57 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:408:f7:cafe::f9) by BN9PR03CA0363.outlook.office365.com
 (2603:10b6:408:f7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.9 via Frontend Transport; Wed, 8
 Oct 2025 19:09:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 19:09:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 12:09:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Oct 2025 12:09:41 -0700
Received: from build-vvidwans-focal-20250627.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Wed, 8 Oct 2025 12:09:41 -0700
From: Vedashree Vidwans <vvidwans@nvidia.com>
To: <salman.nabi@arm.com>, <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
	<sudeep.holla@arm.com>, <andre.przywara@arm.com>
CC: <ardb@kernel.org>, <chao.gao@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sdonthineni@nvidia.com>,
	<vsethi@nvidia.com>, <vwadekar@nvidia.com>, Vedashree Vidwans
	<vvidwans@nvidia.com>
Subject: [RFC PATCH 1/3] firmware: smccc: LFA: use smcc 1.2
Date: Wed, 8 Oct 2025 19:09:05 +0000
Message-ID: <20251008190907.181412-2-vvidwans@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008190907.181412-1-vvidwans@nvidia.com>
References: <20251008190907.181412-1-vvidwans@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: ee521611-c931-4b24-d700-08de069e454b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EFvbtZuYgtaSlrkeprdjkFGgRMt8dCPSO9YdtTN6Oqrw+GxqnLEK0r6VfwB?=
 =?us-ascii?Q?BRaNf4Hu4TOeGI5GyRxR3J259hNy4mO6YJjCV4BoVcsWj7D3rrbB2wVIz4NN?=
 =?us-ascii?Q?fuse8DDe+PqyFPx7YQG1bUmICN6esgJKy93DihSvmLHj36eJQh4NWnRe1fjN?=
 =?us-ascii?Q?XwlxwDTSoRzPs42AHZK4qDr2SvzLZMgLAwATNAXeM8buQxK6OPCkho1I+1ok?=
 =?us-ascii?Q?iRbtblhEzISNHgajeTuPB0Sfc1LcrG9hGVpDyJ4r97r8Vihd1ecgfyQZKjBj?=
 =?us-ascii?Q?v/Lb9PFCtpv75ObrbfP5Rtiog8b0EARaM3Nx0DLk0IzFxJtdjrmQy2v7upQ2?=
 =?us-ascii?Q?NCECRkR+n3zQ5Vt88EmMb9c/fglGqBs6s4g2yKfGYIvC3s/MKXSCRiYTg0rG?=
 =?us-ascii?Q?L95SqQN61uw2ZzCXwy6jRyh8J0rag/Xu0e4jaTFLx1QccrHc3BvVgTK8JxJQ?=
 =?us-ascii?Q?wM82mm3EdTwSqU8n9xSYEAQlAxP0X34igHpgNQQJucdxjfhTfuLzmuiF5SvD?=
 =?us-ascii?Q?ds004nTYt9vxrEpdVn5Dc7uDQsRCxKlcBepcf5VqhnuB7RfEjlbZtzLojSBt?=
 =?us-ascii?Q?WTP/Ot1M3kMBkC5mL21JgWUsCgVw3ySVASDju8wNzpyszcbK9ToOLs4BJi8D?=
 =?us-ascii?Q?H4tDjgJkxGjpVRaneMSPO1AJv6iOz+z3honjgNtAH68rq+y9vrygU7aZvpXT?=
 =?us-ascii?Q?rmNSrrjdFiaXGmQo1j3PZO/pBEOaqd9OCEJt5Kt7IAqSwtTw08ZquKInJZON?=
 =?us-ascii?Q?hAes2SFjU8SSPRjzNiZF5qP/pP9+rVrfoSdbCAdwRoG11a6/hR+CwiSCobQf?=
 =?us-ascii?Q?q8o4fyoDKjtgQGmQvW2scoo+8qKdgcRm9x2w3DvnCSdO0swSyJUMyJmLuWcT?=
 =?us-ascii?Q?VNVNyW7c8VibF5x0VZVQxyOeKDAIWcwpnaYT7sQEVrOrD9Jldir0HQ50aUzx?=
 =?us-ascii?Q?uqYcKx5xqM5wL05PIQH4RLmpWfDHQ28bBsranSlYqa5EGL0WOs2kYVgev7hO?=
 =?us-ascii?Q?Ub2muUpnP+f/96bx/slh80p+FFgdxiHVxa/URl4kDj7/FI9paazavLroQNRD?=
 =?us-ascii?Q?zvOqf8PFL2XqKZ8RGemKJ1+aNuaPEr/W2VwomqzKbJ+B9uarvPrrhnMENKu8?=
 =?us-ascii?Q?CvhjLoUIL0kv4pNnIOrPwCTalkbT2RdzgaSAa78kzd3fsaN3T+WlfuzXmue6?=
 =?us-ascii?Q?LHhA8OjJaxoTJK6ijBMSmHFNQxrm2GYG98aInqZnPT+OaHW/O8O6ohCQncjO?=
 =?us-ascii?Q?Zx/Wod2t7GUYoNiv2TLAlDA6pa+qmKbiLxzmdeESxcRWn2z8xkgBo1rj8bhP?=
 =?us-ascii?Q?5YBiB7/yicL3IU/vnDaIQZhF8+qhCZMTuFpZQa0p8mnzu+9281CSBtg0AFI5?=
 =?us-ascii?Q?ZYLeNhCQ9v8biCtMhBu+lOlKpy7CMhnCY6ka6lyfx4lV7LkCVaOJrlsDZ0+Q?=
 =?us-ascii?Q?7/lj6fluiliFasMX81HP/U1KufIPJAj4LA336ZyV1G6KRjNWFmHZcn8FjNXS?=
 =?us-ascii?Q?imllNgr+uZPyoz62dJe/YmluEQPACOPJh50UUmnts9hWcKXY7rhEgvWeMbg4?=
 =?us-ascii?Q?NFlqW10aB0PNH5SUMNo=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:09:56.8591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee521611-c931-4b24-d700-08de069e454b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA

Update driver to use SMCCC 1.2+ version as mentioned in the LFA spec.

Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
---
 drivers/firmware/smccc/lfa_fw.c | 80 +++++++++++++++++++++++----------
 1 file changed, 56 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
index 1f333237271d8..49f7feb6a211b 100644
--- a/drivers/firmware/smccc/lfa_fw.c
+++ b/drivers/firmware/smccc/lfa_fw.c
@@ -117,9 +117,13 @@ static struct kobject *lfa_dir;
 
 static int get_nr_lfa_components(void)
 {
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 
-	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INFO, 0x0, &res);
+	args.a0 = LFA_1_0_FN_GET_INFO;
+	args.a1 = 0; /* lfa_info_selector = 0 */
+
+	arm_smccc_1_2_invoke(&args, &res);
 	if (res.a0 != LFA_SUCCESS)
 		return res.a0;
 
@@ -129,20 +133,23 @@ static int get_nr_lfa_components(void)
 static int call_lfa_activate(void *data)
 {
 	struct image_props *attrs = data;
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
+
+	args.a0 = LFA_1_0_FN_ACTIVATE;
+	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
+	/*
+	 * As we do not support updates requiring a CPU reset (yet),
+	 * we pass 0 in args.a3 and args.a4, holding the entry point and context
+	 * ID respectively.
+	 * We want to force CPU rendezvous if either cpu_rendezvous or
+	 * cpu_rendezvous_forced is set. The flag value is flipped as
+	 * it is called skip_cpu_rendezvous in the spec.
+	 */
+	args.a2 = !(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous);
 
 	do {
-		/*
-		 * As we do not support updates requiring a CPU reset (yet),
-		 * we pass 0 in x3 and x4, holding the entry point and context
-		 * ID respectively.
-		 * We want to force CPU rendezvous if either cpu_rendezvous or
-		 * cpu_rendezvous_forced is set. The flag value is flipped as
-		 * it is called skip_cpu_rendezvous in the spec.
-		 */
-		arm_smccc_1_1_invoke(LFA_1_0_FN_ACTIVATE, attrs->fw_seq_id,
-			!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous),
-			0, 0, &res);
+		arm_smccc_1_2_invoke(&args, &res);
 	} while (res.a0 == 0 && res.a1 == 1);
 
 	return res.a0;
@@ -150,7 +157,8 @@ static int call_lfa_activate(void *data)
 
 static int activate_fw_image(struct image_props *attrs)
 {
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 	int ret;
 
 	/*
@@ -159,8 +167,10 @@ static int activate_fw_image(struct image_props *attrs)
 	 * LFA_PRIME/ACTIVATE will need to be called again.
 	 * res.a1 will become 0 once the prime/activate process completes.
 	 */
+	args.a0 = LFA_1_0_FN_PRIME;
+	args.a1 = attrs->fw_seq_id; /* fw_seq_id under consideration */
 	do {
-		arm_smccc_1_1_invoke(LFA_1_0_FN_PRIME, attrs->fw_seq_id, &res);
+		arm_smccc_1_2_invoke(&args, &res);
 		if (res.a0 != LFA_SUCCESS) {
 			pr_err("LFA_PRIME failed: %s\n",
 				lfa_error_strings[-res.a0]);
@@ -211,13 +221,16 @@ static ssize_t activation_pending_show(struct kobject *kobj,
 {
 	struct image_props *attrs = container_of(attr, struct image_props,
 					 image_attrs[LFA_ATTR_ACT_PENDING]);
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 
 	/*
 	 * Activation pending status can change anytime thus we need to update
 	 * and return its current value
 	 */
-	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, attrs->fw_seq_id, &res);
+	args.a0 = LFA_1_0_FN_GET_INVENTORY;
+	args.a1 = attrs->fw_seq_id;
+	arm_smccc_1_2_invoke(&args, &res);
 	if (res.a0 == LFA_SUCCESS)
 		attrs->activation_pending = !!(res.a3 & BIT(1));
 
@@ -298,9 +311,12 @@ static ssize_t cancel_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct image_props *attrs = container_of(attr, struct image_props,
 						 image_attrs[LFA_ATTR_CANCEL]);
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 
-	arm_smccc_1_1_invoke(LFA_1_0_FN_CANCEL, attrs->fw_seq_id, &res);
+	args.a0 = LFA_1_0_FN_CANCEL;
+	args.a1 = attrs->fw_seq_id;
+	arm_smccc_1_2_invoke(&args, &res);
 
 	/*
 	 * When firmware activation is called with "skip_cpu_rendezvous=1",
@@ -395,14 +411,17 @@ static int create_fw_inventory(char *fw_uuid, int seq_id, u32 image_flags)
 
 static int create_fw_images_tree(void)
 {
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 	struct uuid_regs image_uuid;
 	char image_id_str[40];
 	int ret, num_of_components;
 
 	num_of_components = get_nr_lfa_components();
+	args.a0 = LFA_1_0_FN_GET_INVENTORY;
 	for (int i = 0; i < num_of_components; i++) {
-		arm_smccc_1_1_invoke(LFA_1_0_FN_GET_INVENTORY, i, &res);
+		args.a1 = i; /* fw_seq_id under consideration */
+		arm_smccc_1_2_invoke(&args, &res);
 		if (res.a0 == LFA_SUCCESS) {
 			image_uuid.uuid_lo = res.a1;
 			image_uuid.uuid_hi = res.a2;
@@ -420,10 +439,23 @@ static int create_fw_images_tree(void)
 
 static int __init lfa_init(void)
 {
-	struct arm_smccc_res res = { 0 };
+	struct arm_smccc_1_2_regs args = { 0 };
+	struct arm_smccc_1_2_regs res = { 0 };
 	int err;
 
-	arm_smccc_1_1_invoke(LFA_1_0_FN_GET_VERSION, &res);
+	/* LFA requires SMCCC version >= 1.2 */
+	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2) {
+		pr_err("Not supported with SMCCC version %u", arm_smccc_get_version());
+		return -ENODEV;
+	}
+
+	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
+		pr_err("Invalid SMCCC conduit");
+		return -ENODEV;
+	}
+
+	args.a0 = LFA_1_0_FN_GET_VERSION;
+	arm_smccc_1_2_invoke(&args, &res);
 	if (res.a0 == -LFA_NOT_SUPPORTED) {
 		pr_err("Arm Live Firmware activation(LFA): no firmware agent found\n");
 		return -ENODEV;
-- 
2.25.1


