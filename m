Return-Path: <linux-kernel+bounces-845895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D05EBC66DC
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 21:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA064F4A75
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDEC2C11FD;
	Wed,  8 Oct 2025 19:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xy84jaOz"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338002C0F96
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950609; cv=fail; b=C36/eebGg/eDv1yHQCIWzLXJ5jB6MRW7O9ULUuakXSO61Ozw9ns4WeNw025MuxB30ytkoTq6gMpWxRVVJq+7hgTxn81T4ffSKtkvW2nkSLprqrj28JaZeNEgqm99JsG9fSTK9goAerMYz9qSLNbym84K+NA69HrbTTGgt8g8U3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950609; c=relaxed/simple;
	bh=J6ppa/VFKr4p6k8mhGLfOeD5Lh+oy80zjTK6orWBV4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxCDdnyA/LwlscmFFe6iG14yhGKszdxdFfoacahecIc42zlhk3/mjwDag01/wKWfPyMCgRpGcMNV3ouqS74HcAzbI6XV5HkWD9NxQnWYQK+iD84OTyBvjzI1rmiccN/9EtLEGopelpiU3pc4FI/IheLdSgJa7pm3YZwVkj9IBfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xy84jaOz; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAvMTj6ORZGkazNOgyTDK8IBgw9QSUupByvGAogESWzwdx2oCiOAjcP9kxqNlHXD4KX3ZIU/uOe7oxDNvuHp3gkBmzBFeGIsz9QZqDw1etFZhrWf64ahSugI01977P9/Gk1WlW/680TB1Emuz/0vT4b3jbSayZm8pB1pzaJ3JulzTYu+avhMY1il1qknEu1a1+fiZDPOiucTBM2Wt5Cya6fcq5xlBWibixka+cCX0JG6ovGbSO4vMSOynDMSrqLfBFHJpJIQSiEDH3vGJkMxwNoN4ZuPW1tIPKPKTAmqg5b+YDQP5Qjgazjv2URr7zIcan0vSzK+CD7r2OHrawx0UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf+YYeTQWrcuuCIS+3A7q4yxtZaY1yZKvZdXSJmVK88=;
 b=ZtjKz/rEz/JYURnAG4kyf1mYpCe+0i03a0m6ZhNpz9ucGkpDyabHKfynNSeAUT7dRLg6mryy8TFcJ3f1+pZROKam38oLs3yyW9K0KZIWXx1cXUJTWGbzxV9vH6x7lFgVdiAQZggZ0Vuo8ARiSMIJCjILqysKIHQL0Set7AerNRF4yE9YP4u5FjjpPRFVxaSkXyNWadfGspH9816H4vvsG/XZJZa3qlBA9puq9AazeeJ3feJIiGqlCJJVNdh9HydJVnEGUHz9Q3bPmOcl5QAvpiffqNl/kwOU3tNXlG3rhFz3bB2DrK407gpjSgL0n8gP9n2Vszo3ZsyVj9rAq/xDHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf+YYeTQWrcuuCIS+3A7q4yxtZaY1yZKvZdXSJmVK88=;
 b=Xy84jaOzHWjVg3MNKgCFE8GwR9/oLyrUepUc1o7oyj4pK2ed2UGztoBhyL5VAYoa8sOUqdHoILZSwCSYxRvfyWzcnUbdlxxdzJM5NDg1UaJ4RppIBzX2Qxj5G8/E5hG5eLbkTEkbNxRlZSIbkwXEHFbpEfzQdSt0I9/HTFlhbBu08YUsSZ/tWD20X7a/02EHy1N4Rz2Wvm3L1XdCnWfFi8DTc9kMsscQqV9r/FOjSOv7FR9lAvcR8S8HjR9WW4VDGTg33c2Cak0FbrLx13m7dMiBvxorCp7gAUp49s8b2geoRC8RWM2Ljbmx9udZAI2qiiUfoD984wksUylOa4LcJA==
Received: from BN1PR14CA0013.namprd14.prod.outlook.com (2603:10b6:408:e3::18)
 by SA1PR12MB5640.namprd12.prod.outlook.com (2603:10b6:806:23e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 19:09:58 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::8c) by BN1PR14CA0013.outlook.office365.com
 (2603:10b6:408:e3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 19:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 19:09:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 8 Oct
 2025 12:09:42 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Oct 2025 12:09:42 -0700
Received: from build-vvidwans-focal-20250627.internal (10.127.8.10) by
 mail.nvidia.com (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20
 via Frontend Transport; Wed, 8 Oct 2025 12:09:42 -0700
From: Vedashree Vidwans <vvidwans@nvidia.com>
To: <salman.nabi@arm.com>, <lpieralisi@kernel.org>, <mark.rutland@arm.com>,
	<sudeep.holla@arm.com>, <andre.przywara@arm.com>
CC: <ardb@kernel.org>, <chao.gao@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-coco@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <sdonthineni@nvidia.com>,
	<vsethi@nvidia.com>, <vwadekar@nvidia.com>, Vedashree Vidwans
	<vvidwans@nvidia.com>
Subject: [RFC PATCH 3/3] firmware: smccc: LFA: modify activation approach
Date: Wed, 8 Oct 2025 19:09:07 +0000
Message-ID: <20251008190907.181412-4-vvidwans@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SA1PR12MB5640:EE_
X-MS-Office365-Filtering-Correlation-Id: ae2d9bda-9bf8-40bd-b97e-08de069e4603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?feks78hQxOLJFxzPx07hjww9a6xWEEIRC9UzdmwRujUJ9+088E1m4CMkocwN?=
 =?us-ascii?Q?r+Nd+XUoI7hR+d45FNryut0VXaJPRs/vJGlzqpSbrE80kx/TL3sQ3Irj1ixf?=
 =?us-ascii?Q?i8VJA7ctrqAhqxVEMfqgXVsLwc2EtUG1uFUXCzW9Sk9d5PdSoO9TbwcESMO4?=
 =?us-ascii?Q?/bY2QihVIkflxuriuFqNzAYOknFqOtG5VylttqVkGkMSC4S0O+Tyvc+l+Wad?=
 =?us-ascii?Q?Qw4RiqI9AA0WfZfa/2TZ5TkzSnY+6QNq/h3ZSIbJ92rXw1FLaBYxhXmk2tp4?=
 =?us-ascii?Q?n8oqtlh+9wsC70xFHD01cWzryp6c1KP4kg6Pufimb14QjVeMsKSh7MoU5j/g?=
 =?us-ascii?Q?cvnqMJsFlANns6VYTkEzaeCOQPeusDTmegZeXmvRH6/4gbQCYuEr+rZquwMC?=
 =?us-ascii?Q?rpjSpBjvDcxjp369acby+ThqM3Zk+PosUy0kK0++cwzV66eJYTQAzaJC1yQb?=
 =?us-ascii?Q?Ul59c8ZC2Nmyx/MTCft1rC6tkL/QcVjRtqiA2A30lWpClg1UHMuTb3DSQ852?=
 =?us-ascii?Q?Sxf0DYpqn0Ok5WyYy7DHWpcZGuHfNyiN0iTARo8TmHq6OL3shxW9kxsGkhh3?=
 =?us-ascii?Q?J7UcVRX4sfl/q5LI0oaFnyCkk7tJPH9lxZuTO6xHnVCdu17bJmlhiYTw+Fg6?=
 =?us-ascii?Q?3itf0Mj/LbFTpQF/4L9dfhqZzdomRpMMsmOL1fwOkTfpEh90Pv1JyH6pz0oO?=
 =?us-ascii?Q?fNEVQnJOoF+Du26PgdIz5uhsvh6lNPNPgb9RJkePm6u76Z7R/J6CQJDptUwx?=
 =?us-ascii?Q?uZa4CNbeJcbal7GG2S5YRJJTvmcvh0FWVt/BcsUo53/1uZILfxr99r4Rqss9?=
 =?us-ascii?Q?r3iG8g6sG04LYw1iEyXfZktxPEezLg8pK1J3gRm586owndLnecDJtdR6Lk87?=
 =?us-ascii?Q?GKi2hRWxbdImLJ8/qva2qdcC6u02VrSraekYu+yFzP/Gv2hcXd1tgxQzy/X/?=
 =?us-ascii?Q?xr6zUWocH3sLG21orgkhR15OdvH4aOKDDHWqTDk2E2OYSW0I7VK+soa7U+Zk?=
 =?us-ascii?Q?9iBkzWlKkxQeBvoINHlMZ0kCDYmsMYyiO2Rg18yQ+Y5OXLLbae40XZEfEoPb?=
 =?us-ascii?Q?jnXw2A18eCrmDr6sWjxcWrqkfKq2qXHX3gnDdHckiJMHn5UN/XbmrhJRt3rT?=
 =?us-ascii?Q?+zcae5KtyxQ7CCbei2a/IDtmbqDnfbKjTtAZnB9WBNv54mcYV2tSqsMlgOpP?=
 =?us-ascii?Q?MWRhtwgyqyBRnF+93bzt1JhY5L+Cs+x41SpFdXzDj4aXfOhmUq1wBWcYngbv?=
 =?us-ascii?Q?xa0w9YeE+f/t4Gx9L2jiZthKFm73c80p+TdFAaJUY7FYwoKi9kQQQLHh6i1o?=
 =?us-ascii?Q?2Szm9XkXF1c3sEfOnHFzgunF7YzDF5h5nYUi0M+0XwYPxs6/guNTOR6LAJMK?=
 =?us-ascii?Q?9WxEDNuCqyjnQ5vQScaRg3Pw8WT1MEeDT8+Vorvq4sDMgzRliQyjrGotO6aA?=
 =?us-ascii?Q?BLN2CFiSJyWAtoopmjR5GvfJLQJF/pMGGJG5tz+gpmXO/MKujgIUvB0TDWAy?=
 =?us-ascii?Q?1kd/CHLhA+rhqZmqMfdiWnGtMg/kR3lciE0ZMG1UYpuM9yrToEv0sN/aWbmQ?=
 =?us-ascii?Q?BM9NadzmYRvEMjKcF3Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 19:09:58.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae2d9bda-9bf8-40bd-b97e-08de069e4603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5640

Currently, on a LFA IRQ, all activable firmware components are primed
activated sequentially. Modify the approach to prime all firmware
components followed by activation of all components sequentially. This
approach will minimize the time where old and new firmware component
images co-exist.

Signed-off-by: Vedashree Vidwans <vvidwans@nvidia.com>
---
 drivers/firmware/smccc/lfa_fw.c | 74 +++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/smccc/lfa_fw.c b/drivers/firmware/smccc/lfa_fw.c
index b36b8d7457c30..dead2282cd04b 100644
--- a/drivers/firmware/smccc/lfa_fw.c
+++ b/drivers/firmware/smccc/lfa_fw.c
@@ -46,6 +46,10 @@
 #define LFA_PRIME_CALL_AGAIN		BIT(0)
 #define LFA_ACTIVATE_CALL_AGAIN		BIT(0)
 
+/* PRIME COMPLETE status */
+#define LFA_PRIME_COMPLETE_FALSE	false
+#define LFA_PRIME_COMPLETE_TRUE		true
+
 /* Prime loop limits, TODO: tune after testing */
 #define LFA_PRIME_BUDGET_US		30000000 /* 30s cap */
 #define LFA_PRIME_POLL_DELAY_US		10       /* 10us between polls */
@@ -104,6 +108,7 @@ struct image_props {
 	bool may_reset_cpu;
 	bool cpu_rendezvous;
 	bool cpu_rendezvous_forced;
+	bool prime_complete;
 	struct kobject *image_dir;
 	struct kobj_attribute image_attrs[LFA_ATTR_NR_IMAGES];
 };
@@ -229,6 +234,27 @@ static int call_lfa_activate(void *data)
 }
 
 static int activate_fw_image(struct image_props *attrs)
+{
+	int ret;
+
+	/*
+	 * We want to force CPU rendezvous if either cpu_rendezvous or
+	 * cpu_rendezvous_forced is set. The flag value is flipped as
+	 * it is called skip_cpu_rendezvous in the spec.
+	 */
+	if (!(attrs->cpu_rendezvous_forced || attrs->cpu_rendezvous)) {
+		pr_warn("CPU rendezvous is expected to be selected.");
+		return -EAGAIN;
+	}
+
+	ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
+	if (ret != 0)
+		return lfa_cancel(attrs);
+
+	return ret;
+}
+
+static int prime_fw_image(struct image_props *attrs)
 {
 	struct arm_smccc_1_2_regs args = { 0 };
 	struct arm_smccc_1_2_regs res = { 0 };
@@ -285,10 +311,6 @@ static int activate_fw_image(struct image_props *attrs)
 			return ret;
 	}
 
-	ret = stop_machine(call_lfa_activate, attrs, cpu_online_mask);
-	if (ret != 0)
-		return lfa_cancel(attrs);
-
 	return ret;
 }
 
@@ -396,6 +418,17 @@ static ssize_t activate_store(struct kobject *kobj, struct kobj_attribute *attr,
 		return -EAGAIN;
 	}
 
+	ret = prime_fw_image(attrs);
+	if (ret) {
+		pr_err("Firmware prime failed: %s\n",
+			lfa_error_strings[-ret]);
+		mutex_unlock(&lfa_lock);
+		return -ECANCELED;
+	}
+
+	/* Update prime complete status */
+	attrs->prime_complete = LFA_PRIME_COMPLETE_TRUE;
+
 	ret = activate_fw_image(attrs);
 	if (ret) {
 		pr_err("Firmware activation failed: %s\n",
@@ -469,6 +502,8 @@ static int create_fw_inventory(char *fw_uuid, int seq_id, u32 image_flags)
 	INIT_LIST_HEAD(&attrs->image_node);
 	attrs->image_name = image_name;
 	attrs->cpu_rendezvous_forced = 1;
+	/* Reset prime complete status */
+	attrs->prime_complete = LFA_PRIME_COMPLETE_FALSE;
 	set_image_flags(attrs, seq_id, image_flags);
 
 	/*
@@ -573,16 +608,39 @@ static irqreturn_t lfa_irq_thread(int irq, void *data)
 	if (ret != 0)
 		goto exit_unlock;
 
-	/*
-	 * Execute PRIME and ACTIVATE for each FW component
-	 * Start from first FW component
-	 */
+	/* Execute PRIME for all FW components */
 	list_for_each_entry(attrs, &lfa_fw_images, image_node) {
 		if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
 			/* LFA not applicable for this FW component, continue to next component */
 			continue;
 		}
 
+		ret = prime_fw_image(attrs);
+		if (ret) {
+			pr_err("Firmware %s prime failed: %s\n",
+				attrs->image_name, lfa_error_strings[-ret]);
+			goto exit_unlock;
+		}
+
+		/* Update prime complete status */
+		attrs->prime_complete = LFA_PRIME_COMPLETE_TRUE;
+	}
+
+	/* Execute ACTIVATE for all FW components */
+	list_for_each_entry(attrs, &lfa_fw_images, image_node) {
+		if ((!attrs->activation_capable) || (!attrs->activation_pending)) {
+			/* LFA not applicable for this FW component, continue to next component */
+			continue;
+		}
+
+		if (!attrs->prime_complete) {
+			/*
+			 * ACTIVATE not applicable for this FW component,
+			 * continue to next component
+			 */
+			continue;
+		}
+
 		ret = activate_fw_image(attrs);
 		if (ret) {
 			pr_err("Firmware %s activation failed: %s\n",
-- 
2.25.1


