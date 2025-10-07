Return-Path: <linux-kernel+bounces-843673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F308BBFF74
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED4ED3B8070
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA80334BA28;
	Tue,  7 Oct 2025 01:30:09 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021107.outbound.protection.outlook.com [52.101.95.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9301F4C92
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800609; cv=fail; b=Niq6sdkhtH2tzyWeO8pag+/7sPNWVLG6qfYBlWYWwi35oYh/m8rX6Mf6ef1oe3YFJiPR1Ju74j6OtMMYqpP8qj8bHQmafDY0DPCoUN1r28RVuU4/BXpN2Gqj9LH4gN74rLjnFzIZkdOodh81W1a4tc4tWbZ2fyRZd3DpHEAoIpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800609; c=relaxed/simple;
	bh=sqh5pBEnimYnijoLsvnQtJd3O9cNCkhRXkwRlQlx3Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UeCF1AnrYSjRWdJ202AEjvqdpaO7NVz1Gtzg0KASFKmzJyQSTnY6dXbmo0S2yQ2nhUwSKBnvfUbB10ovd4UrwMX2v3BjkKRM0iDHqlSLky1/WwpoiEW7rAwfktWR3mFgpFxWN+8gNWOAY0F2ZxuKbBDvu+XsvrZqZoGzXYMhioQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqjwkqFhRw1V/dF4ee2TpM4R//uAwIpoJlGE7gJUaYqwd2KE3UondPGTNmq0+z1GaSpzac+alE/J/5UcN/OJO3eT2MfA4z9WM7xEEWURXJ5maVYBYSdDGFTiSXW+vcfTYqw5DqlV6UTNerZQIxeB5klBdVdd90hD9U+Henj9RuEm2XFBNWClBIvb94fTKrweXl1edzvyEs9S5I97m1nkseo6pz7e20K81kfRfjxfmJQnmLfPiBQDg7kJj17bQnLzIhMZP37m6csu8mQctqMywo4OuR7ujPbilytLbL+tneTTsCeLv73kZzzMbHA/JW3gPn8yJCmCWxvDPbuL0hon0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46lIX4WypKKvtc7Ib03ACIwzClUefqTek8ty2CG9Eu8=;
 b=bIhUORHKXG48/uBDiVjzvmo4JzPY6RqRjdgmAn51/fV6qwTyyhY1DU78JzXYGwRyxTRZSecirAXMkUZLnwPvQNj/yQfP1V68F0O/mkYQDeb4hRQU3JTfMXoPUCJo+dhSiw/1CFSfX9Qizn62EkyGbJ/iLKyj9cCe/ubVmpPnbVJ9BCp3RND5f90NWLZ2ZwUWx7HmafuUzgEEAQUqk7MgpiWIzw3U/sCuAfsRrXT7aU7pMy/PX49+HFVkRS2B9u7neDg/c6jTVG5a3Y+JVNQa6QCfAZvxwP4+dcHydsarpNzg6ZLujXJOfgI8wafHidM7iP45uKmLJbBeZI/bnglOpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOBP123MB8319.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:447::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 01:30:05 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 01:30:05 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] tick/nohz: Expose housekeeping CPUs in sysfs
Date: Mon,  6 Oct 2025 21:29:58 -0400
Message-ID: <20251007012958.16666-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251007012958.16666-1-atomlin@atomlin.com>
References: <20251007012958.16666-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::7) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOBP123MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 397dac81-a858-4e77-1ef7-08de05410aed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OhCmpVuY/okdzmti7giz4k2/7aQwPrtfhzjDRxk9eYfCuXqaQdG86H0xFWvU?=
 =?us-ascii?Q?rZeIZNUhc0k59e2KliZn9ONF2RZDJA0VuEDM5Ka7My1fVFaO2T3Dvw6uaQll?=
 =?us-ascii?Q?CNUuX3Ph4xgaW2cJfD2H/j8bq8GB+mA7iuj7fJ+TVPutHko8cU+4o5Fw8c/e?=
 =?us-ascii?Q?UX43lAwzvlNvtqgHSiym80Y3BSs7LZakILr88dehx6EQ8RvMnrctIoT+FiHk?=
 =?us-ascii?Q?K0yz5gURhJ5Rah3S9LETB//Tt9D6WH2y+aoA1hoEvRHw4VD/JgHWFSbgrMGf?=
 =?us-ascii?Q?9AzpiWYh5RFx2dJbedum0+wDL+sxkehqSeUucz9fB7kVNfc8NWDQX15wTnw8?=
 =?us-ascii?Q?A26PPEn7qoOsRIRBd8sPtSlhfg8pjxnna6BNNpT89+T7CPAAMONphWcWIngj?=
 =?us-ascii?Q?NoiFYNN0n6SaCe34WPO+6P/AqiBa8AoE40FWtfGJJO7DFyOADxvgUheAjb8j?=
 =?us-ascii?Q?IAcMZ/DaCqMvgO7N3eCjA/MmRRz0ORvCUgFzxTBf8FpJD9IYwflsTS0NoSNR?=
 =?us-ascii?Q?P0j5ASiUiN0TFBvv+br2aGQC/mzQi8qXdgT+zARJQy9TX8D0OWJr+a4NbCky?=
 =?us-ascii?Q?+CRx2vPzQJlqO/XIlNDdVUd1k0eEXM5FIgkUo9SkKEy8rpX6gRwEUoOgEweo?=
 =?us-ascii?Q?orkftPfTX+1P/qOIFJS48udzF7F8tyx99yYT++ycz+3+SmoUK0vAiLUmAiK2?=
 =?us-ascii?Q?MGJ1APkUwCF5ENN6SxUR/zVHy3bc1DvhKEVNx/TExqS1lWVNoQYLjA4H88FS?=
 =?us-ascii?Q?K9CIP7MXAWJ6u9fSX8NYuxCt/JmxR4U8q/hLhBK6xhQLR36x6Ci7eml0K8mu?=
 =?us-ascii?Q?0OelnBgsKlBygS3bf0vk5d6PcidaBqPRBW9Hn7y4rkHHHhueNN2yAOUEdKdd?=
 =?us-ascii?Q?uutqyLqztAoY9dqAtVcaM/zK/v2deXr65tk+8kBb/6+UMOVBX8e+U5GV79x6?=
 =?us-ascii?Q?RifYR2tpMRmfmQB46ZVjvt3We65Amv+LuZHQH2t0N3A/Yt67/8hkQqWDsw5p?=
 =?us-ascii?Q?qR5FOxm0xBgFSxm4AXrxSNtWTm2XqVdCIUY4Sy70gNFoSBgNXZ1Uw9Jgbq68?=
 =?us-ascii?Q?jajZXiSnSmmgRUX2MOKaq3nuDnDUjXYTmNznj9rzbm9PrEXlCHXxm6PQnscb?=
 =?us-ascii?Q?/xfRrOyRr/rhmyUgGxrFOEDWetAHUFJO94nc3CPHW79Mspi0vZo1ic6AVU1N?=
 =?us-ascii?Q?/mhleUw2bR9kIpJGRvDV8TFW6dkHyM+I5UdaQxteGqwL9y3pbQHDp/LWhots?=
 =?us-ascii?Q?sgTfPyQFNOMHYUcc+mk7g8xEsXuNv4YJTh1HI0Z4vVfTFzUnVewhukPM6/Ji?=
 =?us-ascii?Q?tz+AT7PPy30ILpo8R7eATesmbZn4ErBU2XywV7Xq0gUHYdOQW62SBS8pJ16C?=
 =?us-ascii?Q?BjaMYuWP0IGcAtRQbU8xr6mD/41E4vq88YYxNwGxSB9ToPkfgxhLL+SnPk2Z?=
 =?us-ascii?Q?ZM8ueli/osKteq3YEbKrKm6J96KreMMM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lpxvII8tEb1WQ3miM52gko3OIvDZxnWy10ieQcDbuQ26m0YfSbuK5UdyFt1Q?=
 =?us-ascii?Q?PND5PGeXa9OTPIUZDC3YO28y4cX9P/Op//LXCRZ7lhmDvcoAx1qkDn/Fulsk?=
 =?us-ascii?Q?dfy9onMYbh9j+9vIkCDcWoYh/1qWm70u1XzLCQDoFG+2ODl5ocK3axrkiJfY?=
 =?us-ascii?Q?fbDKql3y6xmqJRSy/kEyIY0JHNZ/Cs3H6mNO+e2vSab/Mf5kDGFrS2tMfURv?=
 =?us-ascii?Q?ZQVM7PoNr7V7RbqD5rPVAb+jOkkx4hLgBdqmuEnoaABCohlZ+hymNNjeGTMu?=
 =?us-ascii?Q?2lvzt5x+jmrXm5FTe+tcSw64uLw1C96IFuHLYAmpnFyv0tFud1GtWQeIUivB?=
 =?us-ascii?Q?BxrDHpBIsu2LYVZt1VNPEn9IuaeHxoqr+VGrv2eKblBVqNne18Ow06xu3+SC?=
 =?us-ascii?Q?h79YT3QF1AIA1+HdpjlhdH5scQ5TORHB25vQ9rDArlP45WpCx7fRJOP/Ad07?=
 =?us-ascii?Q?fNdUuNcWSmFj8nTNrXJ86JHpQN9Y6p7dEwLE2OR4Atl4CSJJB5GYtSVuqEQU?=
 =?us-ascii?Q?7WKwjJl1Z2UJae3zV6mUbYBAApvQRJJUKmEr1NRCuZAi3P4aQDq+/8UxSuQQ?=
 =?us-ascii?Q?xPIsTij2dcIAFe9RHY5QUVh34pDKc5ihnMajmd9pGVa2xyE85XFXrau46yas?=
 =?us-ascii?Q?mFYIiArrtmTCnmOSMeCIjssJo8sqQnzZNH7GwbFbW+64dnUQ+6Y6CpF3+3nI?=
 =?us-ascii?Q?gs6GwO4mAlIMteQKMdbhiW9cNopOAIxc8Qnh1bUuskm5tXgkxJNj7kXqQZ+a?=
 =?us-ascii?Q?wl9fVvVSdrkAJnHC3YkbDgOD3/5fDFRvpqZ5agi5yrUm1OEtq+v071JBs8G6?=
 =?us-ascii?Q?ymaUurj7/bCFF6f5IxtJvm8NJYV3uJdL5dhiCfKIvAyHfgalaIwCJ69NLFB8?=
 =?us-ascii?Q?OpTwZMb9HNPuD7zApWbondCM0/N8dJp01Sq61yGbUiJL7sSX7kzNo9x/zfnl?=
 =?us-ascii?Q?FLR4B50fq4M5SSb1n1P4mZhQMRTVZSWvOuMiKeGrqSjEUs7NXiAoz1d3EvFE?=
 =?us-ascii?Q?Kdd/IjP1PRUG57Dol4BSi/IyMXfrAGFTWkA1JR2kqdIrZttutlQebZERJkaR?=
 =?us-ascii?Q?0yQ3tGCRMVr6ukQEEoR9/PntzJXFQ7NNUjQ4fCmP6oEYxvTTf+GkBK4U/9ii?=
 =?us-ascii?Q?1e3Sk+DWmNvBr9A82CJRFQE2+M8HO+BxObTweUcSulF3Jax6AzHsNbVa6I6B?=
 =?us-ascii?Q?TVnIAVQDHsZaf4IEAl7kZdy9n0Z2yEn42zNkjAenAAdNC/CMElWUJ/4oVif8?=
 =?us-ascii?Q?w5gq2cJ1bpi0hZzN4jVMyVoIch9X78d7jWNzNWIbO4mT02qedD4QqY7cULOm?=
 =?us-ascii?Q?7nmWFoe+GO/gqGS8b0mdx7RGhatPSjRqzAe1iLgpUhNc7HoKuVpj4vR9WZoT?=
 =?us-ascii?Q?/rXd6Je+5IABp7fscp9VfWpKkNqC5CYE/0vIaqE/sDT+mwwjMlLzD8NBvf/k?=
 =?us-ascii?Q?EOiWoc4rq5Q25KWMmOQ0I3RVpiIsPtpumsvukmTTOGHOjHrbe2FUXE9PecZO?=
 =?us-ascii?Q?3unshtFEpcNRkHy98Nuxu86B74cCTwhIXyKmpwJCNSZu/a2oFPrj9D+QINAx?=
 =?us-ascii?Q?Tfq1Zmz/lhjh8HW2EpDlSguPqDcczEa0bIOsEC6F?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397dac81-a858-4e77-1ef7-08de05410aed
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 01:30:05.0235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udSK0KMVczqh9jv0A4svNXB74yShIN+FpvgfDHnmDY7rtR+oz2zhZn40Jq63YZ/XXx0OK4NZM/+vXVi3miHT/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB8319

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
 .../ABI/testing/sysfs-devices-system-cpu          | 11 +++++++++++
 drivers/base/cpu.c                                | 15 +++++++++++++++
 2 files changed, 26 insertions(+)

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
index 10924fb5103b..60a003a94130 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -300,6 +300,20 @@ static ssize_t print_cpus_isolated(struct device *dev,
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
+	else
+		return sysfs_emit(buf, "\n");
+}
+static DEVICE_ATTR_RO(housekeeping);
+
 #ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -509,6 +523,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_offline.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
+	&dev_attr_housekeeping.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
-- 
2.49.0


