Return-Path: <linux-kernel+bounces-874235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7886BC15D19
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9ECE1895E3B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4DB1514E4;
	Tue, 28 Oct 2025 16:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="CdIKhAxg"
Received: from SY2PR01CU004.outbound.protection.outlook.com (mail-australiaeastazolkn19011062.outbound.protection.outlook.com [52.103.72.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009AE275AE1;
	Tue, 28 Oct 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668745; cv=fail; b=mYvctgp3mMWltgJm1SINL8sdk6dSxK7KFMG32eGgMHVC3qYEaz6rjER/kpzcP16xXh4u2jejKvY2kieJ73PWH+w+dwL5XCtoRSFFT05/uqQUMeXIoRoQsTSfsCzbnnMPcwT9NlZdNzjGc7cHcuUubmIh/pRW+gm48ELbYWt7NJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668745; c=relaxed/simple;
	bh=+ay8vj17UNMTUsYiNvCgUpcpkgWgNeKC1P4Xwbleq7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZXmkd6iqT1x9HsCZKCk9DXsEByT8pUzAKnf08YIwwHHNrg7fiP3VEU1Vu0S6hmsYw41sXXhayClj1PSsnhlLYdNrWmXy3NsJHre5oeA/ARp4GxLD25KgoWadfHO9Q0GVwJF5M86PHyDSMI5kmBJq//+8BgWHyP1mQfdUl8kBebU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=CdIKhAxg; arc=fail smtp.client-ip=52.103.72.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THHRZ5ci6JbHhHTKqSHtf3xQDbbKryj4zaNjaOB0/fNNYUef/K1HJVdsxD7fVVuW/oAVZT0MittBRpZdl4oNDpUQhOGbOoAe1z4EtfHPRM3vwZHMq8kmq1ReE6vnUPuC5z6A9gPRHjiKoypVAAzJ1rR7QfMv1d/LbZ1TT30IwKu3+UWIN6BZcC279kNlH8Aao2T6uEQEUewvuCCbblnjLEmeDZp+W+cG19Vc/RV/K3QEcMf4UzvSzM3QjUFWGKp7jKd2K4QDdRrrOUYtgO0sB3vCSSLBO5OOvGbKsKJaL+uxp/VT88ZjdwJt6tPfjQ6Ym1ZkYDyS1QmIW7pA0degaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjI+HuU5IacpmtnoJug24KpkdJF9pf1rg1qxVCiUyPw=;
 b=y0DJqZ9cdPCf21Lk4AbgNX0/dnYzl5wqHuxWrciikiWkx10Etf9Qzc0oAOtg2gnvK85m0vZ4Jky7nr2RLfZAh/qh7owNikx6vdrk4jJqJmkqeELccFffVGJ5yJdOyCeGU6BzrqFay3xRdMw3bC1k20pQU+BnCH/TDBdqTVu75vSqa3801rXOejBfL3sDKQRWStcUsb3RfsXDBL5P0tdm5ZlptUN7QQE9dRJxQ7tUsD1RCWVBo2eo3SAvme4+TMFCd3kp5b3FLB+5+NyvpS+6jzPm9EaH9cbGQxirlVlAyGUYN6QIkKaytdG72bUyA8UJUbly5g8Z3tLIfWJ4YYXcFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjI+HuU5IacpmtnoJug24KpkdJF9pf1rg1qxVCiUyPw=;
 b=CdIKhAxgAFd1G3uzXUNrGeXtcAP//1Ax82Iy99wii41eCsSAc7b2+/YMu1FUzrVPbsAj3Ws0fq71RlLLSFEy5Pb9p1dI2CdKwjRTxsmEJCwqRhFtIy9SOi/UkeJBp58YqmPmJJ7bVABenGWPWLJFu/UW+nsYk5Aefs8ipwu/zGLg2LjyvGwqx3MiF86leecqRCyro9Rb7rWAvR89B2h2CkBEyU2t4D792vFPX3DLjiFsGGUBjEuEqs3KynjVW0ZRd7PEUyKLe4UB90gg/Z5V4Cas5B8TI6xWlDUIgSu9PxS87GcxhWt7QbI09D9IAvYNO/Tn73VG/cAd8sIXDo4ydw==
Received: from ME2PR01MB3156.ausprd01.prod.outlook.com (2603:10c6:220:29::22)
 by MEWPR01MB8833.ausprd01.prod.outlook.com (2603:10c6:220:1f6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.20; Tue, 28 Oct
 2025 16:25:39 +0000
Received: from ME2PR01MB3156.ausprd01.prod.outlook.com
 ([fe80::443d:da5:2e96:348d]) by ME2PR01MB3156.ausprd01.prod.outlook.com
 ([fe80::443d:da5:2e96:348d%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 16:25:39 +0000
From: moonafterrain@outlook.com
To: David Airlie <airlied@redhat.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>,
	Junrui Luo <moonafterrain@outlook.com>
Subject: [PATCH] agp/uninorth: fix out-of-bounds access with negative pg_start
Date: Wed, 29 Oct 2025 00:25:24 +0800
Message-ID:
 <MEAPR01MB31582BAF75B78750BE6B2152AFFDA@MEAPR01MB3158.ausprd01.prod.outlook.com>
X-Mailer: git-send-email 2.51.1.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0061.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::15) To MEAPR01MB3158.ausprd01.prod.outlook.com
 (2603:10c6:201:3f::13)
X-Microsoft-Original-Message-ID:
 <20251028162524.44119-1-moonafterrain@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME2PR01MB3156:EE_|MEWPR01MB8833:EE_
X-MS-Office365-Filtering-Correlation-Id: dd7bbad6-7c4d-44ad-6b25-08de163ea074
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|12121999013|41001999006|23021999003|461199028|5072599009|8060799015|5062599005|40105399003|53005399003|3412199025|440099028|3430499032|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bCZk4kbXQSz8aG0k3GAv+Ntq3jCi7p6pTaOQk/u2/F9ubuE6HsZO6/FKB0gA?=
 =?us-ascii?Q?4DDNovlBZFLAyFHkKi8/nkriU/wlfzeCxU1q8QDI7xFd5XzS4zyGOHekmu3m?=
 =?us-ascii?Q?2OL4PBRK7Bjma/GaN/cPfYpLcde/r+XRmASWhFvp6VUwmWH7m23bYN5iHb/5?=
 =?us-ascii?Q?3tnybcwnVLYeiFus/tRecfWMjpQUMcnQOqIqTs1ZUDEnB9H2JG7IFsj30t0T?=
 =?us-ascii?Q?Oy/478G0C8uyI7+e/BHhmnOPUJp9nlc8JqGJrGB40jVpgxKiHyXe/CHQ3Bd5?=
 =?us-ascii?Q?H2r3sD1IS02SncCoQshZoCFAIJGG/SPL7cPa9EevhNAerSo1l7MLBANPBcYI?=
 =?us-ascii?Q?2p3kosN7oz7934Mp1O5nz9gQZPog8UHPAeUhgk+0m+gOBgcSCvPL2CFUFgtk?=
 =?us-ascii?Q?lgSobIqAdRuxXnsmKTOZ4y1Q9PD5Y1C4Z1REnGmjNu1qWoKxLPWghRz4eBXn?=
 =?us-ascii?Q?Wik9J1go0oGCq+3XmHrT9PB608dWH03N2xD4/nSIMa8PHvC5Axew4Ou/fbT/?=
 =?us-ascii?Q?SZ8VW1cmUeBbeKrPDZgvQG+FUML8JnkstFQwSZ8n2Yn9DF0KEF6K/M6zzMus?=
 =?us-ascii?Q?EZg3/PZw4fiq+f12BIQafS2P5QjD7qFTtexEMv+KvBjjPXzPtMhA+w6mozfo?=
 =?us-ascii?Q?cISsHUPbuuA1Pd7eK8dAVECHp7uFRI4xYlVyfwocXvt+VF7WO4QIia6Meusg?=
 =?us-ascii?Q?KovD9QO1PUSpUCUf0QFddegfNgyWmfwPrBQNtN3jQhkPGiu6RNj9XrrWYN2Z?=
 =?us-ascii?Q?q6zERXnt8thcox/uBPnFnRqcCKXrEq9JFasbprJxiPtvMVZNn3LFK6AZJoAR?=
 =?us-ascii?Q?pPrlrAQn+AtPPsBaaK3hCwks4UwEdRZM1Ry7k6w8S5B0KSU2r9vNrFTuUErS?=
 =?us-ascii?Q?i/lWKLXy0G2/7BHR2qQDNLw6USQT3QpmNJn6yPWyJFUfwVkwWhdKCJID4rDq?=
 =?us-ascii?Q?w476e+nR25F746mcIJtm3tYWNrm/g3VU9nDnwdQGFW8PTHBJdsphU/Kq6vDI?=
 =?us-ascii?Q?bQYi/3hX1rjp5XOYp0lMlN824t7ZpqqvD3D/qZSybftiRvG8N+2GvFvBzRG1?=
 =?us-ascii?Q?yXG//rH5QoOuyKUQnOEIHCnMV6byZccToBlHVNd+bDScm6ua+uiKFVW1ztJh?=
 =?us-ascii?Q?2gkK7fZE0RjIsnEGdEKWsM2ZzKduoVMZAjs5yd+6mVkljpNkUkCJIy1XBciz?=
 =?us-ascii?Q?/VQMJFZa/XmMfdpm7I8Ou3Mv0Fl8oyJKbTR2mT7eBeQtrnSEV3MzDgMvPtin?=
 =?us-ascii?Q?bZJtUE7uncTQkO9XmmaimxswB1JhFk90E7cXPUgHk/IzmAlKFuDhMNdU1uLW?=
 =?us-ascii?Q?DAE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/10X6EpuN7jezbaTby43H5S1O1p/MTQeElMxsDmOP5wPYVb9F/UEl/l2UNzw?=
 =?us-ascii?Q?tt6VTNuzeGndpLAwxglT+RvM8hb3u8/ZbFsoqVChmrlXA0LOKbbieSDcrIQ5?=
 =?us-ascii?Q?XbpCzB25EJ9wYVM+FG8fJ/ucd2YB5i3HkgU9N3XGhBvjN3VHncl2G5Z674t2?=
 =?us-ascii?Q?7ZdzR71pv9RtIIUs6NxAnBkF28BGfi7e28C0veBE10NWjMRFKDgMoxZqsFdv?=
 =?us-ascii?Q?ZzY1+Z76HLXEme+TSbALk85Txs7EIUISdOJ8UcLCL9Zq7Kqznio+cPt41QSf?=
 =?us-ascii?Q?bywi62v8ftan2Q92f9rF2Fv2Emy1YU+jYEnVHcngONurt47ZBC6JgtON0XOj?=
 =?us-ascii?Q?saJ5vwFimvnft7nBDL2WcbKY92kkVUNypgAQ0m2rTQKu3qu6Ngp8p+C2jbRW?=
 =?us-ascii?Q?lJvm8H89vPIJ1x5VS7nAcvb2EE5prxhzCIwpyj1/LulqHlLEn/jMlU152Aom?=
 =?us-ascii?Q?uqZHU2QlR+zDSc4eK3l8z+VVIgktk2K7cEpRLRgseOgziqGds/4X8KHrqXON?=
 =?us-ascii?Q?SYGl5UB0gxD78hgn3VQDTugPTGCHpyiGsKksSrJ6LzVdPISpytnqcdC/4wQp?=
 =?us-ascii?Q?YmAY72hvBqy5+DavaV92zTg4wFjgWQavpzP2pijHDDn8oaiHXg9WSIh/DmYx?=
 =?us-ascii?Q?/zSJIrmOhfj/xluk4iRhYKG8DnE3cD3lVdiTsHbcZeBHlWqoDKXjN/3YB6M+?=
 =?us-ascii?Q?UVTESDTEpFGoXI/HZMeZ+fjJeTkbWAgDFOx8nHjSMou7alsBP/8WvLRBP/jK?=
 =?us-ascii?Q?BJKZ9pYFRJFB7H97I8vDXOBRcEk+Mul3xYgCFbw7wOg+n7tnl0Kw/JtxITl8?=
 =?us-ascii?Q?bcHmoOScTrVMuP8qrYvVvMgCumfTJY5eIxVKwsEyzrjIiGdDZpMuffRLVbC4?=
 =?us-ascii?Q?hMwgCAN1p+iy/p+efpumKb1tAlYdfrqtyWRSLmglgef2n39BZAjhTgYzxZ/y?=
 =?us-ascii?Q?uGTbpo7ZYwN7u4FB9EDaTzD0wmAlYMwU1A8hurbHn1d4LfiFK3MwPoUSFVWJ?=
 =?us-ascii?Q?XcLCj+3s10KA2jy3EuxnMnGGwVql5ccv9RGQ5ZGXlDDjYc/qfVnUDx2hLUi+?=
 =?us-ascii?Q?dHplcgT0DA/DBhW3PeuT6WX1fGO6w/RTvm/VB984QU9c7c/2Aa/OChZiwYyu?=
 =?us-ascii?Q?bH+PHP2Ow1r/1bhGodf1cj4FpFg999cTgmNQ/0PsKt27Nlg1eVx9Aw1hRikv?=
 =?us-ascii?Q?6swyjr8b9jxDsuGCCyy+Azapngr1sLcbocgEdUvmhlsGbIaUTo9jq3/QK3eb?=
 =?us-ascii?Q?t5DQ6QWLsNwVmNYFjyom?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7bbad6-7c4d-44ad-6b25-08de163ea074
X-MS-Exchange-CrossTenant-AuthSource: MEAPR01MB3158.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 16:25:38.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB8833

From: Junrui Luo <moonafterrain@outlook.com>

The uninorth_insert_memory and uninorth_remove_memory functions lack
proper validation of the pg_start parameter before using it as an array
index into the GATT (Graphics Address Translation Table).

The current bounds check fails to reject negative
pg_start values and potentially causes out-of-bounds writes.

Fix by explicitly checking that pg_start is non-negative before
performing bounds checking. This makes the security requirement clear
and does not rely on implicit type conversion behavior.

The uninorth_remove_memory function has no bounds checking at all, so
add the same validation there.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Reported-by: Junrui Luo <moonafterrain@outlook.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/char/agp/uninorth-agp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/uninorth-agp.c b/drivers/char/agp/uninorth-agp.c
index b8d7115b8c9e..4e0b949016f7 100644
--- a/drivers/char/agp/uninorth-agp.c
+++ b/drivers/char/agp/uninorth-agp.c
@@ -169,7 +169,9 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int ty
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_32(temp)->num_entries;
 
-	if ((pg_start + mem->page_count) > num_entries)
+	if (pg_start < 0 ||
+	   (pg_start + mem->page_count) > num_entries ||
+	   (pg_start + mem->page_count) < pg_start)
 		return -EINVAL;
 
 	gp = (u32 *) &agp_bridge->gatt_table[pg_start];
@@ -200,6 +202,9 @@ static int uninorth_insert_memory(struct agp_memory *mem, off_t pg_start, int ty
 static int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int type)
 {
 	size_t i;
+	int num_entries;
+	void *temp;
+
 	u32 *gp;
 	int mask_type;
 
@@ -215,6 +220,14 @@ static int uninorth_remove_memory(struct agp_memory *mem, off_t pg_start, int ty
 	if (mem->page_count == 0)
 		return 0;
 
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_32(temp)->num_entries;
+
+	if (pg_start < 0 ||
+	   (pg_start + mem->page_count) > num_entries ||
+	   (pg_start + mem->page_count) < pg_start)
+		return -EINVAL;
+
 	gp = (u32 *) &agp_bridge->gatt_table[pg_start];
 	for (i = 0; i < mem->page_count; ++i) {
 		gp[i] = scratch_value;
-- 
2.51.1.dirty


