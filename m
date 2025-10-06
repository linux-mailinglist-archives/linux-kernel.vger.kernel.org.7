Return-Path: <linux-kernel+bounces-842519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2E8BBCE9B
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 02:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0FE034E49E0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 00:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E86199E94;
	Mon,  6 Oct 2025 00:59:01 +0000 (UTC)
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021073.outbound.protection.outlook.com [52.101.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2590181BB8
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 00:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759712340; cv=fail; b=WyC4Ud2lgvUlHjAoS/ayPbBHZtgd86xRjYW8VosIlySmZ+Xswo0zxf1i97TDcDJRqrxYPxsrOiNduTPeeMVjIpjm/o5B+ftBjvmvmjp9vNzwmjqSHh1tJn77JcVzbSOOG0L4ZhbMiyLpMwsO1V/bFreae2bWNvX/mzJK3sc8slY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759712340; c=relaxed/simple;
	bh=letTB1RN3mg+syy5Wc9Gx78ZnoMfZ68ieDjnzXahQlc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cMFyCsh+bzqyaVKMiT/7VgGPUyIa7QYrij2jku6GTyL0DlS0yTtaAU5jdSVLgXKyNiBcWbLBDJJ3c1+16BmFLRNWiRbMwpV0QhUVOxJa3gBHYthfOZYpmNG7k6hqrkU24RWo7/7ZR45tft7kzYd8ayt6dxgvjPCkKhcQEbuBb2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SV/5a6tlYfNdu51V/8fUY0Vt1BnxDQAFXDZdfpebcVFTVn8rrdJvysffEVKh9hPwbnTvgPmezLUe40UqH2L7o9QeupK1Sr26jjP0nFlQMS4kus5P2oMyuFvJaxwzG8+Ukk35DoQRwF+gc9tMjmlC8iq29yJ0ipFCChBJ62pYEFdkcH2EPWTYOC2IuAG2EwuboZU126QHp0TvmMDkGHtZeZqOOdXftRROdITp1qcpGPFe7QU3XojaMoZVzuiSKrbVvDWtkQI17BM+xKgMzlBji9Fc3zSy6EpqD5n3rf4C/5UJHC3PlddzuuSINhKaRB1+QKrNapkBLuaAVANAOLuovQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLri74rinURHcJdQNudfqTy6UMW5DhmrkzVjt7Ysnws=;
 b=PIaMZBTjy+waQ3rIU7KBnr2QdVyqLKkGExmbU4ST6plBy/L+pOTDC6Mu72Vg5VMbpVLZDn9gzf7Hnz00R8Lx3qUKgm/k995IwztLLRSHQbu74uSSVfZ1HSF8c3t3T0QHe0oO91OgZawFEMQmkH6n8xRmzOqd3dzUPttQ0YhtlrjPXnXy6QQdW7/IktheUtjlMKNk2/ILW/hphGZw5T3qWUpcSQdAmsxMhh/cId75NMfAImpDjTJSfW12jcSoZ9ceKTLf8yloHA/A+xnW/QIkGtF5deEm0zP5oKPJTYSYhTbowje1OZAoMmM2l2kaOhYOqFRy9o8+kBwJ3ZRLxNZqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOAP123MB8392.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:438::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 00:58:56 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%5]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 00:58:56 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org
Cc: riel@surriel.com,
	frederic@kernel.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tick/nohz: Expose housekeeping CPUs in sysfs
Date: Sun,  5 Oct 2025 20:58:53 -0400
Message-ID: <20251006005853.76335-1-atomlin@atomlin.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN8PR07CA0024.namprd07.prod.outlook.com
 (2603:10b6:408:ac::37) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOAP123MB8392:EE_
X-MS-Office365-Filtering-Correlation-Id: 35953a83-bc41-4c79-83b1-08de047386cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yfa5yHE8Xm2eXoAReZ9ao8oA/cTS8a3rjX4uCUC0ky1tdsbD32OZhYwJ0vmV?=
 =?us-ascii?Q?tNFVbJ40Z4iRzB4jaRZ69BepOlhWsB2FLC21J/YtILe47xWpRqZY4kDWZJ+V?=
 =?us-ascii?Q?juS6YirgN3PhVgB2vJQQlmerdDozhWlZEq6AxezZYpD5VJKxLVFJP+qO48U5?=
 =?us-ascii?Q?tBI7K/Nx5fUq0gV4wPXOkQXOXtYLixKZDRJyXrK3ygMW4lwx/JLv/sFZQTPc?=
 =?us-ascii?Q?XXRfHd99cPPwr+FXPvEkO7gqp6LpaZw1nL+VFI+Pn5CczZnEc4dnPgS1SryY?=
 =?us-ascii?Q?SmeQS0827s/gou8xi5rEllTrx1efX3/JxZy1iUjwizLbqoCUG9dJrkV6FoNN?=
 =?us-ascii?Q?6xKWJWeZ70c+QYOWAOhLrsyLoeIGGzCNagblWx1ALgtacoJuMWh/ySTe2NY0?=
 =?us-ascii?Q?tLZVBrXmuDZQIeg6UxmJF7Dyw6w2W5HVgKHjh0UVjPjNGjnCQ8zy6SZUtnxb?=
 =?us-ascii?Q?NCwPIUwkiMOGapEhStNb5Q0DMXZ3NWt/GPsqogBDahHPT+iX1RyXduSZpzYQ?=
 =?us-ascii?Q?w3Gk7pD0IzY0ReF8+nvZ5HJwHpakR2gKhrmxSRiagW/BOaJiJRNN8Ps20oC2?=
 =?us-ascii?Q?OV7mz18jwRdse0FPoZNa5sj3YDAlg6WEptieygRLpEHEIP2ZkNAGXyKIaGNs?=
 =?us-ascii?Q?I5kQAsPl6dNwK7akl2z/OAtmErYkOqWrr0G4yGiTchKSSOOX4df/GAJrIcCG?=
 =?us-ascii?Q?4s31t2BZkEy0YxgRM239qjnRQi5oI57Mu6zUpbUcSzJ/FX9MDsrNlZ7BazUA?=
 =?us-ascii?Q?DOLr21LK7IICdIfDq/xrrfmeAh0m48V9g8wA/UbgKbGMTXu/9RDK/QP72O+s?=
 =?us-ascii?Q?OaPG0Ur964U7GFgyxzfrwqwk9FM4t2s93+iPBj40AVwA0gyYxGYvKbY+70Xe?=
 =?us-ascii?Q?NnDDJNEO09AV0SIoXrcp0474ElCPm5Tk+HnhVTP29tjlrJUlYbTR3gv48y6k?=
 =?us-ascii?Q?9b9dShfjokBvS55cL+8VrhmsUy6O+ZH27kfUntQmH1shFYeYi30alpmL4HX2?=
 =?us-ascii?Q?AX3MvrTnR/NTXNgfQ4+mNBdz9RVOvEaZgZP9bwLxej7acG7tNLhBqWRjRDaT?=
 =?us-ascii?Q?s2Yft2uROjUjhmcrW6TMbfAGlIJl6371IHwaZzfFph2btXjWaIGaI4s3t1CY?=
 =?us-ascii?Q?J71PaVIUJDdw29xtLST/zZNmIx6306ZquHPVdaSyonUlJ6fapGG4UU63fT2x?=
 =?us-ascii?Q?8t3czaJN67MKnSUVMGYCX0r7UWFqZWl7sBYnZcpTxTnli0Ff+bSvEmSQByfB?=
 =?us-ascii?Q?ZcfePCYzc+IE/QbQtga303B5g7M4PRc+ubGg3/x0uP/l6nLxxYQdwBVe83wx?=
 =?us-ascii?Q?ntfVNbeZ3Rd0UpjTg8d3XL++RSJpdjsUhVY136ecl59xDe2AWTmtjVmXuT+q?=
 =?us-ascii?Q?i9voU2bPCya/i6Y7Y1xHmYMIX89mHvDzCu7ocETXR90jjNK761xut/CmQDDZ?=
 =?us-ascii?Q?5h83EhrVO8MuR++u0R3oVPXhpgBvn0LQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v7JsdR2sGXzE4+3QJAP5NwY13SLIDxX474sxwi+oeE9aYPMRp7Clh3f36zRt?=
 =?us-ascii?Q?j76RAmXKkqi7KTiND8c7KUHK1fo/DSVBGCVCNdnq4MryBSP7a+urLv7KMgkT?=
 =?us-ascii?Q?Lp3NeN3dRGqcvudw7FVxnXfV+tvRKT0b7f9+LvQlWRJHvnFQoNTWeyQwpcL1?=
 =?us-ascii?Q?Z0QOXa5B6BfLOFrWKBBVAKCDHV5sQEQlismmOB3IV12ap9FWx5gNBbpdocZi?=
 =?us-ascii?Q?4P1fIfnRjxKuM0uYDciFYkiSYU4N1DRcu8DDZW4F2JVoOW5TFN8yHvgXmsNG?=
 =?us-ascii?Q?SH4QwOd63EEXzL8ZNnzNMcvk5PTFum8NRqLXHcJLrxsyMejvlEjNEw/EwIrQ?=
 =?us-ascii?Q?yg5f75fKKp/tDpOCvCCmrtXEvtT4A+X7E+t1aSB+WoyRtI9Oly84CJeks9Rr?=
 =?us-ascii?Q?RCDX+GKDLQTxRWPGVz+j+iwGMtwCyLCLSBlflqiUg+46AUxhIiTTHjXXflNj?=
 =?us-ascii?Q?voKi0gL/uheSL2WZSW5+RyANpVC+JWEhruH8F8Lb5fnJOPuSkIr3ar+D7v8O?=
 =?us-ascii?Q?UlI/XxkEFyrAjPMSY/KlnqtIq5hNfIwphfw6uwG9rw0CZn0srcxAoAG+BO8g?=
 =?us-ascii?Q?0eM9IrBtTNI7YAqTNQ+jDfDt51+YsMbYcwFuqa3avyZq7G4AsNEdksB5HzVx?=
 =?us-ascii?Q?A6dXHsZ2iCDZK3UY3PG1WyeM9iYSknyPjleJoniDTNgXu6W6tBLcnYO0YVlT?=
 =?us-ascii?Q?z6s1XybDJXhiMeJpUaQve1NIsnAgrKG+PyGss+IqEtvq5oDpVkWm5Vv5NVRB?=
 =?us-ascii?Q?W6tXrJuGTPl6xBKn0FPwPhCa7g39T3heiAiVczFnp7mW2oS6rtVPpXviYIIg?=
 =?us-ascii?Q?6brMZqA2dtOlgne3EkXrD4sY5vo+dMp6lFo33vrU4avejtpIChxtZSb6eRER?=
 =?us-ascii?Q?KV4F+ckLTosInngoGtNvbjsKiODAaYHNAX19PwXHhu4X3SFLb0tCPM7KEmXm?=
 =?us-ascii?Q?rAXIAiHXNOz3+yAIkm+gDtxG5BMo0B53ejtwBHJydJMCr26MNaqu0tjfBSy4?=
 =?us-ascii?Q?qavpUYlXcCWa2LhcAtZHV/Bsrpol7Sz9PExORpwPR7g4RtSC4Y2ffc3wthKo?=
 =?us-ascii?Q?7H2X1sjFgHK6O0LT8o9kEXkFiW/BINLRDb4olxGkxghJ8EGkcRiqV/SnWF5T?=
 =?us-ascii?Q?DmdV6xfjTn5tHHjw6ZIgISmI0SdCQ6uq+MINMBmdeK8pgFpgu7d7xKhb7D2w?=
 =?us-ascii?Q?Om3ipcnGZt7k14l7ppEtgqduqAQ5/vH7whjafjfyeVDQhTsUHkKr8xuUesP1?=
 =?us-ascii?Q?9dUgMHXCnmqrFP0CU74HUvAOZQ/SrCEcI4DYUxk8jOaHuDaFu/pE09/KbSEO?=
 =?us-ascii?Q?zYqM+dtZoWHv/g60LGO8C30YR4EvC/cKqaLjQnHFnJ/hMg5ixYEGyzXbQAJd?=
 =?us-ascii?Q?x2NAcUGhNe8vXadEzVeU0j290HKbw/lqjvWfoQASLf7pK+aILoc0hACvFIvc?=
 =?us-ascii?Q?R99QDsHviA0gIS0I9i4U0t84UlAKUWd2IPc00JzdA0TN6e+NGzPEO46y4inc?=
 =?us-ascii?Q?42psere/eE6fr20AGR2QkCPbAyBwjjczoDSTH8rLLAFv+WwlgpOW16qnRx8b?=
 =?us-ascii?Q?ErCf3Z5rRI1Lx4HupwegsFcIS30FAyb2X6y/bW9h?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35953a83-bc41-4c79-83b1-08de047386cf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 00:58:56.4143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VAgBRkyT8ELFEkpN0IkX0B7cKqAbkK4MZrtlA0QLJLQi/yACR/PJlBf2z0Y9CNzhoPRlRJxtn5oPbfKs8eWNkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP123MB8392

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
 drivers/base/cpu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index f694b4b24d6c..c6511658f6cd 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -300,6 +300,19 @@ static ssize_t print_cpus_isolated(struct device *dev,
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
+static ssize_t print_cpus_hk(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	const struct cpumask *hk_mask;
+
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
+
+	return housekeeping_enabled(HK_TYPE_KERNEL_NOISE) ?
+		sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(hk_mask)) :
+		sysfs_emit(buf, "\n");
+}
+static DEVICE_ATTR(housekeeping, 0444, print_cpus_hk, NULL);
+
 #ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -507,6 +520,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_offline.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
+	&dev_attr_housekeeping.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
-- 
2.49.0


