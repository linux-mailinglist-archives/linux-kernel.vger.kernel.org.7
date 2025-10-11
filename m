Return-Path: <linux-kernel+bounces-848945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B14BCEDE3
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 886F64E5FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B63AC1C;
	Sat, 11 Oct 2025 01:30:14 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020107.outbound.protection.outlook.com [52.101.195.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DDB6BB5B
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760146213; cv=fail; b=V+6zd+9kDkEYqkKkpuYF4nzAFOGejQpmL68daOhl7frVh4lPvqG+wxdmjHPktAUOOLIvoCIM4p3yA12zvc4Wwmv8dWfv2mxKJhXI1y5YqibNJoTwarcjv1NMRRnLGCzrXGy0hBfMDKmHaBCM4kQ33AQReOC+jkRoZ/9xX2lPoLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760146213; c=relaxed/simple;
	bh=M+lwAHS3ptyIlGHeovOoyUQto7IJnCVxITpOi+YLPSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JRsjheXlefNGttNcfzaXdsgs5+dMpDUAnYgPPwgm7M5cB6V9WGm5XoxBBtOc8tEDM2Nbn/r8s2zjo07e8HV+1njGtgHFtOvAwRI0JBd7m3rnakZlezRCfK2x4i0Mieck443X102gHfY6hvnrUxlWgs4eE1lKB70HQFcMmhe5hPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X3BcWZhl/e9k/bJYN+rGd4u/Vbr8jKrU2hXK8IkPBsI3CslpcpAm3Lxj+1kLNR9/fAQ6G6EVOeNdQVJeRfeP/3hwqHSJKp84aUrFwdX0wT+wa/fzA5n2dfrhyEOQ8Onh/t4g9uar/81MMXH/sTbUntmEhlYK0hNDQcatpKDcLYn4toQZmZqw06fy283wIAc+fqm4OqZE6PMXMHzCkybDhPr2MdJItJ0FR7lFRptkZNTuBcDoU909BQETATvC31v1DhX5ZXd+2aEApRj84KbbXWwK5o3ZKV/wv24mJ0euRnNL/+aAkFyAS/RRaA9dKkzv3oIA/oLPg/scgFQKs1bKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVdNGbs5tu5DeatZn9RRKbama/QCC8MXKJI+BA2P3hc=;
 b=lkKAyXZGZdNdQcEhk35/cvH4RzYYAnVTtvY7qsNU/nCsGbKcBGo7S6mzbM1rJ8L+TLqtLf1X2ia8OOP34ZGm8Z7pt4I6S4JPX5odTzbCXFaKNYQUz/8eTtlahRokIKJIRKTFKdVUuptvMbV7YNihg94/vxhtpyxrV1U8hIR7Pj1rW6VuAIbAgC2Jv4cQ9t06KYKg8dOVnyOC/L9mgJdF3+EKGBR2wR/2H6OtYDg/mZKuCX6JfYAO372q77H06Ln3MageGGzX9myxfFP7UM38xCMEtVAW/hYB1WUhtKRaEDH+DeJ1OVG8EXu1utSCrQWQn7n3PhW+oAXX0Wx1QzzovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by CWLP123MB6259.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 01:30:09 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 01:30:09 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	nathan@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] tick/nohz: Expose housekeeping CPUs in sysfs
Date: Fri, 10 Oct 2025 21:28:53 -0400
Message-ID: <20251011012853.7539-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251011012853.7539-1-atomlin@atomlin.com>
References: <20251011012853.7539-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR18CA0001.namprd18.prod.outlook.com
 (2603:10b6:208:23c::6) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|CWLP123MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 21abaee4-6b39-43af-a101-08de0865b6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g5A1s9PGVN6gq0Hasw1yvwNxD3pK4D8KzzG29ZqJdL90i3TX7lfm+fHXGi0G?=
 =?us-ascii?Q?JQhfRpH7U8EGQ7I/F5Re63N4Y+AI9HR5JGp24J6mCD6gq+hyMWhUOkjl/YTJ?=
 =?us-ascii?Q?FvyKg6FQ8RGOCRg4GKXpzvW8NWbEx4xgKGqmRUerJ+MIX+wNOflO8YnDI69V?=
 =?us-ascii?Q?lJ5PiBVYbUUrBCTLdTWl4JHBg/6WUB5vOXrKnoiqATw91nndOoPiOHRyQd/u?=
 =?us-ascii?Q?+OGCBj5U1hMv77k7WHlDuoDC1/niTrwoHUtQoybbKK+h40B+C2pwo+Z9diTQ?=
 =?us-ascii?Q?ujdCXHBDuiyi967y9R2Ztbj9m/tEVQ5Sob8IvKPyq7Qh9oiWL39Q554kh6HZ?=
 =?us-ascii?Q?Cx0t3aD7fFtPjaz5Kz+yUStMBNUUIRp36fitBfGs5g/PWLNT8oHbZ5BKEeZ1?=
 =?us-ascii?Q?Z4kRm6vYcikJMldcFbsMwCWbDkJym3CeG8+G+hnaE0JNP/qK1K/Wq0ZEZ0lp?=
 =?us-ascii?Q?Juhx6cs078XCXRUHx5ioL6XuREyEFnRhUtlvbSkLM8ugqzaAzIiR5N82khmR?=
 =?us-ascii?Q?87flaaX/W26q/SVYwa57xNhZdNIvGh+JJo0fubvNZwUGvz+q7dGX5Tpkyw4J?=
 =?us-ascii?Q?4/+ZwfognunkYJPNtaI1PsqCkwWQilmdf0mAVqQ+LBf9Gupnf3blP3kMvqZW?=
 =?us-ascii?Q?IpYX5G82j0GaOVT+sLbGqQmyuG/EhNwXh0NCwVxcCw6kRFxRFWyhpkHuE4Kp?=
 =?us-ascii?Q?vgf0ENOn+6yfvrTeZFVfqyQob9CnRDWZk269MwZc44J29Q7TRfrsMtrQG35c?=
 =?us-ascii?Q?vwQPHdMtrvLCf+89O+dm257jTUIkh/i0f8bAZPWd6sDitWW6t5Mf75k+oh3b?=
 =?us-ascii?Q?J/Pgfv0p165pSWE52/naxMLH2pYsXGtWNmdw9ruGDJ7ToS8QBFbhgBofnM+9?=
 =?us-ascii?Q?K6VDhOSBwcdYVDClmtW9rXsJD1l0jcrt1q3LMuy5JvTfAzyy8aTTzI8L0/jj?=
 =?us-ascii?Q?Soy4ppfunR5mWRnNzdbldpFxDbiXXv6ZfnIUGeRB9/eau8z5EKUhmdmqktAp?=
 =?us-ascii?Q?IfioxDoo6Qr33p9lXuJu7djg3xfv6eW08jFtdpsO0sNDkPtigSKrySvQZgAT?=
 =?us-ascii?Q?G7gaw4HIUfFMZfukJpb2VOkOLo2WhlmMWRzUQeCpSugYhOkbGtIOGQP3zJR5?=
 =?us-ascii?Q?+IAXM+pjsL8qRaijam5cJnUnfPu3EucyLdicqD46pgvmeG4zkpdluEml4Grv?=
 =?us-ascii?Q?Kaiw94ClrdWF3bp7R4VGc2wKrMBk+ToHPkT1FUF0unlYCf1SWvwrt+lMD70l?=
 =?us-ascii?Q?7aiT3AWIDGRThUrNU9G49H/mI09zgXNPOB6xJSgcrgGOf25Dp9IZP71vw630?=
 =?us-ascii?Q?KYlQtQu/zVTMbqSst6+rmvAEwtoo0SheaiHbBIFt4mLIIeEFo9bvyAH6l39R?=
 =?us-ascii?Q?hwm3ii5HtoVOzgOZAh8r+Oto4jssUprVoHlBJsSmUWHnvv4Tfq50igD/dZKE?=
 =?us-ascii?Q?/D+BDiKFmHRnZPa+sS2p9HaEs+TCN/Ee?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3C90LfTsJAv6BMFOoKIssH2nvK4lNDSzeMsQ5FFEWPdZdWk6pIqBDAX1AuJJ?=
 =?us-ascii?Q?sBcrUY88YsmAqyLbHy2f7mLbdr2dw2Q2DKtU9VUUD7t1J5UrbDL3JpUoFQzP?=
 =?us-ascii?Q?r1lBl9ybaTZHYWNe//uANtF6BEmoMpfcuJlqP4RD07MNaoRltyJpQJ9SsGOb?=
 =?us-ascii?Q?alPIRfGzSTzCgRtmbmmmRxVaWaDuX1WDbRflEjy5CZ9I47G9+MUM8bZUPHf/?=
 =?us-ascii?Q?Miw1GseZvDZOsClfoE37k2Gizai8iWINraOHnlELKi34WVRgVNJBytgqt5Dp?=
 =?us-ascii?Q?XGJjRGNxZ5HZIAce3xpd11uc/VmaLcqivScJuQ06+1gEbXGB5nXMPL5i9mTY?=
 =?us-ascii?Q?loJonLyfuRDQvSDZJyesNE3agdUzpoyKRibbMrCyuqdQIX+M/s+XPM4rSm2p?=
 =?us-ascii?Q?x3peDAxw5zkiReipCUrOzN3oeeP9aYdO5RPQZ5lJDAux1e72zcU/DQFyV8Cw?=
 =?us-ascii?Q?m5W0EGyXGnRx2p60uO3MPcH3oN2H5rrk6gXiN6PSlEwVwquthMtoqP/pzpTT?=
 =?us-ascii?Q?O+Z/WLgdtqXRXAJ6Zca/z5mFfNnufQfyKc8DDFZiAab+Hxtn3Wi5T4zbbuGF?=
 =?us-ascii?Q?K+GHfJCkfTa8PcqZM0oOFMJcwlycaTnQ2SSmens9l2wSlFBu6QUvqo7dLm6B?=
 =?us-ascii?Q?liEje2jhaqwgWfaZD5djRvI8wXCdnI9r1JtnwID/lWb7aKA3pAUPKqG/BGJw?=
 =?us-ascii?Q?kSHAltlquHeD9b5HBu23E+HL9wNimeQtstsBuR4ewAfyBgLly+IfxGqZEW2a?=
 =?us-ascii?Q?gGtwtknTBC0TeIBWrqGAYCnlkVmG+llB7I2HTzH7zn6q0oZAD07o65AirDg4?=
 =?us-ascii?Q?GWG9GQQqDOA00d5Go1fqjm8i3ocGvW/0zNQKYAoBbD+5TOZrZdc3g4869KvY?=
 =?us-ascii?Q?HHBK2OFTJO2IHFfScXmXTm5nX4JbeyjycTT3FqCGfZhlVB4FWnfxBh8Ont0h?=
 =?us-ascii?Q?q9ZIeTUnuq9QKAxZt8vK4xh903Wpz1Z4dF52MrI3Df0deJsRZH1Mv0YDp4Fe?=
 =?us-ascii?Q?2wGRCPm3PUvzyWtz2qszvRNlXzDX7BNLDjNfXArsryX0ZiK9UFhX0ThtQyzG?=
 =?us-ascii?Q?HcPLdjds8KHAHKlHjbwMZyubQg6h9cd60GBcIJEq/tTqNJ9OlFOVMe4EFd6y?=
 =?us-ascii?Q?8T0xFXmkSfZSD/hZ2+Kg3A3BUTgWGYkR5fMzyjtFBu94hBAN9W1IYllojHhv?=
 =?us-ascii?Q?4N89E2LtlvkrqGo50DYPiQ2BaVgTpiSw9vvMV1wRvV0mYJlp8lVFO2cnrGwg?=
 =?us-ascii?Q?z580r7aXlDca4nXftYsaW/xd89N3lX8LCe53mR2YPoL8kFW3owinnqNJjfAZ?=
 =?us-ascii?Q?bNcpHWdlScFPIIUS4K/yEZkYi/ge5EDlT1u0j9jb+/iAxw0xLlcUYkZ5SS8y?=
 =?us-ascii?Q?+MPC9sn8pepSuNEznEWLJS0tzTL1lIjPFOmVznVTHGk+qbaAulMLA5b9aXtB?=
 =?us-ascii?Q?zSkL7vBRpYaie+pnRrswsNZhDEBR9nw9FLpP5Pni8an9h/3IB2rYTcBa3Sav?=
 =?us-ascii?Q?kUuTdaWqoKPZ4ncC1ODK9zx+88y+LkcQgL2tSHR+oKTCYJYHw+HJ8X240yNe?=
 =?us-ascii?Q?x5FZlvfyW+Dvsv6U7QCK0gepYPMhL7YZHG8ZACsh?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21abaee4-6b39-43af-a101-08de0865b6ff
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 01:30:09.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S9YQ0/3gQ6dW69LMwSskR3X5LwzqCT2Sip+6YaNu0b1H+WrPv/cZwOz/mgrKR+EgqnrEixzliLwDBOjxhM0Pzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB6259

Expose the current system-defined list of housekeeping CPUs in a new
sysfs file: /sys/devices/system/cpu/housekeeping.

This provides userspace performance tuning tools and resource managers
with a canonical, reliable method to accurately identify the cores
responsible for essential kernel maintenance workloads (RCU, timer
callbacks, and unbound workqueues). Currently, tooling must manually
calculate the housekeeping set by parsing complex kernel boot parameters
(like isolcpus= and nohz_full=) and system topology, which is prone to
error. This dedicated file simplifies the configuration of low-latency
workloads.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 11 +++++++++++
 drivers/base/cpu.c                                 | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 8aed6d94c4cd..3a05604c21bf 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -764,6 +764,17 @@ Description:
 		participate in load balancing. These CPUs are set by
 		boot parameter "isolcpus=".
 
+What:		/sys/devices/system/cpu/housekeeping
+Date:		Oct 2025
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of logical CPUs that are designated by the kernel as
+		"housekeeping". Each CPU are responsible for handling essential
+		system-wide background tasks, including RCU callbacks, delayed
+		timer callbacks, and unbound workqueues, minimizing scheduling
+		jitter on low-latency, isolated CPUs. These CPUs are set when boot
+		parameter "isolcpus=nohz" or "nohz_full=" is specified.
+
 What:		/sys/devices/system/cpu/crash_hotplug
 Date:		Aug 2023
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index e3cb47eae982..c6c57b6f61c6 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -300,6 +300,19 @@ static ssize_t print_cpus_isolated(struct device *dev,
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
+static ssize_t housekeeping_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	const struct cpumask *hk_mask;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
+
+	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(hk_mask));
+	return sysfs_emit(buf, "\n");
+}
+static DEVICE_ATTR_RO(housekeeping);
+
 #ifdef CONFIG_NO_HZ_FULL
 static ssize_t nohz_full_show(struct device *dev,
 				    struct device_attribute *attr,
@@ -509,6 +522,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_offline.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
+	&dev_attr_housekeeping.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
-- 
2.49.0


