Return-Path: <linux-kernel+bounces-720376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFBAAFBACC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12EFC426E66
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEBF26FD9A;
	Mon,  7 Jul 2025 18:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WrRtMUw8"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14426F469
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913237; cv=fail; b=AMxUuUyvG41oHlLuex+tY+mE80rdKqc9mG6tRT6UaEuqYOiZZfp585ASDmNDJTSNppWI8vNp+NN+8tVPhtHkAuvXGxaV/Xd7u2hzwUt/gxL1a+Flakopp0Ebn4sJZJms/+WWVKtaijU6gHknfQzUfZHc3d+R52OBu9ovfurVZAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913237; c=relaxed/simple;
	bh=RyAhKBePYSz9QwD2JI1ve8t6GvmfnSar3mRpK71wyuY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGV5zsB46uY9ESVytyZGBEvbMeLChBYs2WPItk1732GYNPYv8wVcGqbKMTYMhB3ezGbMKP3PB6Ro06qZ7o+TAI4oED4Yz30U/e353GnuzZiT5bMQFjY54yKwnQyr6sBwTPJkxTkUAeLN+ZSXcHLTednXH6PvE9SjR2KXDlL1zaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WrRtMUw8; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouDk/gqJ5LO7wMHK/lCPFxc8sgDdpWzNu0lqNY9wjK28kr1lHGzjG7imbPk3vUrafTem0toxaGbctNiP/WmUbc4IAhipim59spfvdeH9kN7ZXyVbPCN7Q3cPcZQDvfA/scXgLnbwl3Jrd0LZrLc31v+wnomb4Ad5coXv6Mole3e7nSGhp1h6JT1xJImMxlsIaFPkV4VFX21OFFJVeBMhkkhGV7E5qThEd6OGhfPfTVY1Z3csYBq8bjINFUg+rCNpR5LK9GU9CG16opi35o1td+bufZyWaMKk13SAU35d7mjMMOaMhcylzfYMiwPA5402RI7oZiO0wLK9tsk5IaT4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wgMfm9Vh+6ixVrUOUdlFXV+UuzFXiqi4eTwHEikx/NI=;
 b=Fa8eHtxjToMOBdy2M1M+myzFSqBRfDY0/T1+D2opd+lQaRrmrib4Ff8ZvfGFc/zX21o6f41IdA9Ef4skup9id/W+10QiDBIWC6RfMJIl7YGjYUdZq95SXhTz2BZUwmPOJLNXrgWRkNekPYwiZGnKvINAY6lXCyHbhs3fTgp7/S3gZx1dhSbYrqjXr/Y4HVirPfoT36zslWpOxy089+VIe07RsBsynRSwO8C9n59iHoS6o/3Z3G0mUjQ32hwPpVkS+ItIU5OCqGVOdf7QnwJPf0jQGYooabk0B3q+xF8kONvogD1PzkT98RoD9kA8F0lMCqwdHmhUOQ3kEWuAwURmBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgMfm9Vh+6ixVrUOUdlFXV+UuzFXiqi4eTwHEikx/NI=;
 b=WrRtMUw8oO/OHBRk6rEc8mJaAQ1VrDGCnhxYfMofQSMRmvwOX9pfMQ+HeUnOIWzzu7SNI/PhSgGL3Abx3trVq9GJvQmLkq7OMKEae8XcJ1bw+5rCJjDOu5JtW/yw4lp7psPZe0J8RcUMvd+ZhOTl3Sk0KQTiVp6tWNU5u+CDH/c=
Received: from BY5PR16CA0007.namprd16.prod.outlook.com (2603:10b6:a03:1a0::20)
 by BL1PR12MB5731.namprd12.prod.outlook.com (2603:10b6:208:386::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Mon, 7 Jul
 2025 18:33:48 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::88) by BY5PR16CA0007.outlook.office365.com
 (2603:10b6:a03:1a0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Mon,
 7 Jul 2025 18:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.20 via Frontend Transport; Mon, 7 Jul 2025 18:33:46 +0000
Received: from tiny.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Jul
 2025 13:33:42 -0500
From: David Kaplan <david.kaplan@amd.com>
To: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 21/21] cpu: Show attack vectors in sysfs
Date: Mon, 7 Jul 2025 13:33:16 -0500
Message-ID: <20250707183316.1349127-22-david.kaplan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250707183316.1349127-1-david.kaplan@amd.com>
References: <20250707183316.1349127-1-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|BL1PR12MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: d76b1ecf-60e9-4eae-3547-08ddbd84cf02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d55OtIo2JfG/8MDgOm8ZLZt9HNEcU7TD2qE1YImnGlyyeAUv+LhsxuWDGJgo?=
 =?us-ascii?Q?P/xKrUctZyCKkCbZi9T7Z9yN7KLZHtNVLVS9BZF/9FrFF6yqp/OvIYVwUCpH?=
 =?us-ascii?Q?AKcf53GLmGicyyrE58T2nHMFOB3iHwzzuEohTVr0W/jWena4iVyhQt3sZxeJ?=
 =?us-ascii?Q?7aFTViI/SFXfJkNheqvB27auQKIWTOGROCu6VIhvI9Odjt9hp3S7diUd6mA5?=
 =?us-ascii?Q?JVlkWycDT7sPsfIuEr9YsThV52GEKqwLFhUihPt2YIa5Dr3AgNJxq/6UNBAZ?=
 =?us-ascii?Q?HFmRAaAtkDfXLZnd1l2bbfUUrKieyYtfeYXA46SM1BBGWBON9oGrrW43RRvm?=
 =?us-ascii?Q?T0IFUEVDdQnxRtzH5EIwF9n6nz0fooQEdWMqfHEF8ZSqxDPQXEDEOMCgYWr/?=
 =?us-ascii?Q?1Oc+rpZTEk+3Q0siR7YWFLLtGdqdZEOV7i3KtB4d7/xaBpTrlGxWKeyNEp52?=
 =?us-ascii?Q?N53LuYmF98+Jx9H63IfbsqAAifNIHZP7f7rfcH/XIF7oUTHCVrglOEOzmNh+?=
 =?us-ascii?Q?s4JQDr7rATvPZQHY0GWGI8b8k164DZaFXRHL9N/M6t3UykONaJ0scdaHVeCW?=
 =?us-ascii?Q?AXI1p/ttpjU8+CQgE2vO9UdSVvXCval2C4x09O62GApG6iweX+wZb9ZP+5Le?=
 =?us-ascii?Q?mv3/NoRNwfuPt4UNutzIJhJuVoudMy6nX0YUdP/7n/oihA+hIEydc1jD4uLK?=
 =?us-ascii?Q?4wg3yqGMXrfd74KpU+N+4uwR2cgxXO9CQzihyaCD4vkQ/+7XOSFD4zh2JtSv?=
 =?us-ascii?Q?7VZr0UWDc5eTY4Hgj6gjRAqJuHaRJjB8BLw9RMrsb9eTw5vWGXQ5YYq7x13w?=
 =?us-ascii?Q?4IlUsJOHuDw+Ph341Dn7vR0FNi8uNcShUq0TmPFBLo9nD8n5fkhj80KONJ80?=
 =?us-ascii?Q?FHKGBJq7Wv54s9mRWe7833fwJSN06gU5dkYIZI6sSm8j4tM/vKzvD4uXk1bk?=
 =?us-ascii?Q?65bBh4I70J7sBptOnOTxMH1Klu6WXxigjvlTI/xJEBp1kX56KxEox/gDdfeu?=
 =?us-ascii?Q?5Uz9vr/prRO8QvWB9ySkYAcHly5vsCzIkj8RU2GZKK3x9S4P5wgvoZnVKU8P?=
 =?us-ascii?Q?tUA4J+oXj2UnQfy1iep+6DPfqFjp4qqks5cwLqnBf+fK7j3Ih5QeNXpAd1yG?=
 =?us-ascii?Q?S3PBZ5L6dJoG3U9Nlwdxcenvy3qtcwLhEZLFmfLQPNMtNHGtZ6H/JaHKRP2p?=
 =?us-ascii?Q?lnrImo/6nBLfzb8YV2Kgj9XrGR6NUdPjXhQgFGCx//3JLO0PvElV/s4oblmq?=
 =?us-ascii?Q?GOirC5cBRAJw3/wc4x3mhV97cn54W6HD3HMtYg/GcQ5YYfEAXIG23bxLyhVv?=
 =?us-ascii?Q?kWxa0R13/d22196A+kJNFzy30XO4RjSTXvgy98kWWDJOnh4rkk+RYtC8mc3D?=
 =?us-ascii?Q?S/N8wGo/N8dpnuO83jEtlazvHcJPdJBw6tMdcVRP1Q8ZVEsbxfKT4r3GajyS?=
 =?us-ascii?Q?ft0cxJLIGXVjAehsVIxDXJL179hnvTzcLIAJYFe9SpAVRYcp9CrN9gLm1hog?=
 =?us-ascii?Q?O9sJfQogukJvK3X72YLpV4jPznUnLImFVHZJ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:33:46.1481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76b1ecf-60e9-4eae-3547-08ddbd84cf02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5731

Show the status of currently mitigated attack vectors in
/sys/devices/system/cpu/vector_mitigations/.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
---
 drivers/base/cpu.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 7779ab0ca7ce..0b76213ea70e 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -20,6 +20,7 @@
 #include <linux/tick.h>
 #include <linux/pm_qos.h>
 #include <linux/delay.h>
+#include <linux/string_choices.h>
 #include <linux/sched/isolation.h>
 
 #include "base.h"
@@ -647,6 +648,70 @@ static const struct attribute_group cpu_root_vulnerabilities_group = {
 	.attrs = cpu_root_vulnerabilities_attrs,
 };
 
+static const char *attack_vector_state(enum cpu_attack_vectors v)
+{
+	return str_on_off(cpu_attack_vector_mitigated(v));
+}
+
+static ssize_t cpu_show_user_kernel_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n",  attack_vector_state(CPU_MITIGATE_USER_KERNEL));
+}
+
+static ssize_t cpu_show_user_user_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_USER_USER));
+}
+
+static ssize_t cpu_show_guest_host_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_GUEST_HOST));
+}
+
+static ssize_t cpu_show_guest_guest_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", attack_vector_state(CPU_MITIGATE_GUEST_GUEST));
+}
+
+static ssize_t cpu_show_smt_vector(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	switch (smt_mitigations) {
+	case SMT_MITIGATIONS_OFF:
+		return sysfs_emit(buf, "off\n");
+	case SMT_MITIGATIONS_ON:
+		return sysfs_emit(buf, "on\n");
+	case SMT_MITIGATIONS_AUTO:
+		return sysfs_emit(buf, "auto\n");
+	}
+
+	return 0;
+}
+
+static DEVICE_ATTR(user_kernel, 0444, cpu_show_user_kernel_vector, NULL);
+static DEVICE_ATTR(user_user, 0444, cpu_show_user_user_vector, NULL);
+static DEVICE_ATTR(guest_host, 0444, cpu_show_guest_host_vector, NULL);
+static DEVICE_ATTR(guest_guest, 0444, cpu_show_guest_guest_vector, NULL);
+static DEVICE_ATTR(smt, 0444, cpu_show_smt_vector, NULL);
+
+static struct attribute *cpu_vector_mitigations_attrs[] = {
+	&dev_attr_user_kernel.attr,
+	&dev_attr_user_user.attr,
+	&dev_attr_guest_host.attr,
+	&dev_attr_guest_guest.attr,
+	&dev_attr_smt.attr,
+	NULL
+};
+
+static const struct attribute_group cpu_vector_mitigations_group = {
+	.name  = "vector_mitigations",
+	.attrs = cpu_vector_mitigations_attrs,
+};
+
 static void __init cpu_register_vulnerabilities(void)
 {
 	struct device *dev = bus_get_dev_root(&cpu_subsys);
@@ -654,6 +719,8 @@ static void __init cpu_register_vulnerabilities(void)
 	if (dev) {
 		if (sysfs_create_group(&dev->kobj, &cpu_root_vulnerabilities_group))
 			pr_err("Unable to register CPU vulnerabilities\n");
+		if (sysfs_create_group(&dev->kobj, &cpu_vector_mitigations_group))
+			pr_err("Unable to register CPU attack vectors\n");
 		put_device(dev);
 	}
 }
-- 
2.34.1


