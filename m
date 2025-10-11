Return-Path: <linux-kernel+bounces-849030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8DBBCF0A1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F383119A06B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9632222C0;
	Sat, 11 Oct 2025 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="QTFRl+rl"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022099.outbound.protection.outlook.com [40.107.209.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35474C81
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760165045; cv=fail; b=NhDmgMHSpA/p/ZF8l710/bKVXW/D7RxBJSOIATz4wGdEtys6ECULV2dl92U9iUE+VMB7B2xdiiW1kF3lrCAgqNWhh+X9E9t682jWnhNZit+diI2D8tekOr+0rgMlKsbFX72rfZot4Mg/SF5Q3Bn+lleGPpxm93lzubtF6qyqZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760165045; c=relaxed/simple;
	bh=rr5oR9KySn9o4gitRWdjQTRu+yBXLLDVbHZQjxVkKAc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CYDv0AVuF7oDSz7yoH5sWAICxeM7rhTnPxQDA7NQlPQMzalMo0oTTxco+6LIc06oLapcDU454lYkN9Zgt6HHL22Z9oe/bDPfL7dInHdg0hqo9PnQrb/G5MpdTqBEb77GlD+32EQLRn2gveQGftM+SYjR7QySrk1SM+7xj0Z/hVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=QTFRl+rl; arc=fail smtp.client-ip=40.107.209.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Of0osviOJszA5aiaZHFim+NzNdZJeFqttuH0sUa9lmqGfslHpgZHVyU3TEoLNJN91gRN+FrpzPOsufBqZmEhULtQUZ1ocdIRpADIGpYkum9J1AbzVi0yQPv0SWypexZlyHIF7ibYCGWSpT6Me+P4F5zglOd7QbZ7Tjq/vhh3gz1jLfogzfTJ1NWGLoIyiiiW3g54BzoLQxpe00tSh/tJZEZzLrYLugo5CqEVa5gZmX5EH5KI2zpuSQna+WEAdR8K5kysgaA+22WkQ1HSJRw7RsM06VYPr43RpdfvCE7xTP0ZvonPBgkIC7BCsP2yqDfa7+WVi4goiJ4ElWOY/IXB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xARuFJD/D6DDuK8Xe6/L0wAQ8x6+HT/4UIj3Z8dP+P8=;
 b=zJlDzRhls+c1Q7eLIe4O57O5wzy3eM3agUyFGPlbCb0xG27yAdgjWgICGjghdYWQqgX7JD0vp4+jy5R5sWgajY47S4+8XwBQ5SvuFu7dg5IvU7jAoAMKgvjw4Hp3XW0HvTxPN1RMtsIqrzPdrPuskE7ROLBxVN8enDTC1yub4nb+aboPQDFeQ/lwGjKB8QUUopSbVfgc6Ph8OKRbKcFGexvtCeDlWrW1uU56v0gb12zR5+PFZFdgMxXtWt36gQ94906lQOI2wKw9nywom0O6RWsMYO/3FERysuqFn6wiohPJOHuXUKYbSXOMhHi0W4K69zsStsHsgg8gaGv1SOq5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xARuFJD/D6DDuK8Xe6/L0wAQ8x6+HT/4UIj3Z8dP+P8=;
 b=QTFRl+rlS8B1Yn04bBgFiYn2lGZKEhUJ9ydv78TIcaAXIMteB/hr0HIiqXBrY8sD95aee5KEqMDja6nc+PDQjIZLUBo+ovpQmo0ck+ps5thgzQVK3nUMuw3SL+cpjd1dLW3QmBakmh+dTFj5lJO/avZQXnKJrroVu85KJwqsY2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA3PR01MB8015.prod.exchangelabs.com (2603:10b6:806:313::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Sat, 11 Oct 2025 06:44:00 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%5]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 06:43:59 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org
Cc: dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	shkaushik@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH RESEND] sched/fair: Only update stats for allowed CPUs when looking for dst group
Date: Sat, 11 Oct 2025 06:43:22 +0000
Message-Id: <20251011064322.8500-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0007.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::19)
 To PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA3PR01MB8015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbf892e-3cf5-4243-75c4-08de08918e00
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e1veeMmaoDtBcNdNv3YRkP5mXdZ6xmfswlcWHXMmlz7l+fE6eyvCdnBnSd3V?=
 =?us-ascii?Q?iLJ2GBxi+owvX9ooX1ZGifTSZCLF1gCXh6dhDPeVKClrL+ie9jH00N0KYnqq?=
 =?us-ascii?Q?ijm3h+kf1AmTQpY3C+4dNueWJt/1LqPG9++CcO0VNswfqTjKhKiUdGaMN9YJ?=
 =?us-ascii?Q?Rhm6qHGwNpMrJVRzE3mlPcnmE8qHb/NOv2ZdrlsWFa2ft9FeyI2qD1NoMSj0?=
 =?us-ascii?Q?pT7XE3/pxE5MlMZFTaws+gwxBaahbQ7B8fjJa3vE0iKFt5uziXT5u43D1Odl?=
 =?us-ascii?Q?VqOviZH03ZNADEGqYgE+ECj1jebEhSQYns3XFGnmfITSm5DGfFaLhYeqGBla?=
 =?us-ascii?Q?pa4yIo3bApeHT9NJ5E01eOOkKhlKMnxmStKa34EENV3pFnLflni1HSkEpzW7?=
 =?us-ascii?Q?J/1lSE28q93/h6gj4o+bPxWQH07k90Wk7v5Lg2ZFHeHzge7AyJHjYhnBvR/n?=
 =?us-ascii?Q?vpYLMBJhcSgvyI5YLMWV5URL5KJYDsbMfbkRTBqAVDJAQ7TkZDuUquRau+C/?=
 =?us-ascii?Q?XcS6OYkkUQCOBUDPpWL3suZ8NQZjYuT+b24KvOVm9YKD5cWy8nFQCbefOl1v?=
 =?us-ascii?Q?uVBCdbEinudeV4yXTelo1CQhzg85VhP9tyrcgZ93mSi6Oi4nkdaxu40c9BDu?=
 =?us-ascii?Q?2vLfann1GVWIqQpwUjJhkPZJSXVjqL6uOR8/3bgZ2Zklk4WPgAY6nBTXrheD?=
 =?us-ascii?Q?35XSM+el2na3PMlrC79t5V/7h2XTpRrrOuHkcvGE9ozg9qFLxogCoGFKHDy1?=
 =?us-ascii?Q?8P2HWMo+LcIUsXlOiU3mL1++8CEyWP4/PjHXcI+W5VcVHuhvYI1oGkgjlUf0?=
 =?us-ascii?Q?HxocFT1z4VK+biVyKFodqaTx970bGEF+9CghNZ2bOrGbjgpAoL9llPqxQ/st?=
 =?us-ascii?Q?G9q5D9GluBOchSwZ3X3lK01rCt5GizEsOdk+B8TOr/RW2AkLI/A8Ye/lzOvt?=
 =?us-ascii?Q?koIkLfEFtsOQDXdn6fb6zBpcSsPkVgTHsvk7udV6hN5tLTbyj0WGOH1Trq2A?=
 =?us-ascii?Q?TSi5d3DPP7w1LioiqiG+NYbqB1S/435NmJOglVulotohxh3MAxr1WIUaQVOW?=
 =?us-ascii?Q?yHtzkIdUrBRLiGhP0AR5zuCNgWWck7rTo900DL8z14/FO+ANH4D+feOvoeQ5?=
 =?us-ascii?Q?tziJgODixQ+eK9UW5EOEItxVpDi9pb0g+S0LVyXGUyqN0xSIZF+AATgj8/1Y?=
 =?us-ascii?Q?SBbS6nZFmyUHdBNrXfn/YJ+kt1rQnzBz0Y3d2wTp/QK/OhQ6bzKu5joKI5jF?=
 =?us-ascii?Q?o63xWW++Lv9C9gen0YVHw9oC4JT1J74kjHK06C5BMLg8FX2PBsSQpJl5xOTj?=
 =?us-ascii?Q?3yxgZ84DU3hLfV6ePAtBwBbDIlIubcg85apEzTknH166KVRMSgnbPAYtZ70q?=
 =?us-ascii?Q?vKjHT81NmJEiHNiOKaHW802ldxdzRaudSMB6grP6kXJ4DYfkolwQmWq93mWB?=
 =?us-ascii?Q?LG7HwpxZJ1duIfZbZshKLZeYA+K97qGlv9zEALgGXVCJT36mwK6Xr4IVQsbR?=
 =?us-ascii?Q?j4184GneHGjO1t17tTHX9BV/GOmErJ4QTxPd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pmSMCXLHAZzLdp+hQmfKMJqFIVMTk3q9Ai3be/kEtPxyALMeysQeaPpwxir7?=
 =?us-ascii?Q?5KlpRYlxnuchb+R6q+nQ8bLQtMf72fso3c2CoaiPqSpMAty1Lt7ZYICvJfXo?=
 =?us-ascii?Q?fGmUluW+bKRuTU83QwRVSYLX8o5WJQkYPOHu25UWbO5OdCOI897PHCFXBeCv?=
 =?us-ascii?Q?ktslSR+0wLk9xXgBqoHZoHC6HhRp82TjeU3V8M9Ci1JruODnBZTkuGPnL8S0?=
 =?us-ascii?Q?BMx4EQ3Xuq9ZkMkIGiRDeFPMEVwohmwN3XgDtB95J1Cq7Yd3fGmFxS+5i+NZ?=
 =?us-ascii?Q?jUjCObqsljB5MyT2XMedEXvWY2jZO9dpLescc6DWs/wuWS4Ez1Pytgl6b3NR?=
 =?us-ascii?Q?tTQ/S1s2LARVNvo89z4McalNtZ9L0JM+TDN55kv82CKyUDjQ42iN94FUgT+0?=
 =?us-ascii?Q?4EnjPh5hPuYPmXyHliQzf/Vr+z2Xce82ASTvzYWHGuGnCYHK3uMwRDNTs+O/?=
 =?us-ascii?Q?sv+c9oO8OTX+kFKJhm/pceqXyaoWgCfJ0UOkRT8ryUHz3j7QjCW2HwSWnvgv?=
 =?us-ascii?Q?Ru0WOprMhS6JWx72OF9ws/fC9W5liSgXDjCpcl0H25ret5MpH7qAlW5pvTop?=
 =?us-ascii?Q?c6rQZysRcxWyxecEjWxLKo22WmcgsD4nDj8yT0C//tGcXMsrzf4TQapoZ9py?=
 =?us-ascii?Q?W7gp/P1YebFXTcj8py6GeFaSX0XU97FdTN3zL+R27VQNjGY7KP1hv32NZA+n?=
 =?us-ascii?Q?UdalbiP4Tsu/3+MMcxao0sCUQL/iNKYzWFmnmF3xfoq3MXY94st84pBpsm6a?=
 =?us-ascii?Q?7HDtigl/4XIrznYFzNH9F8kP7DGAwCnvJQupoyh65dLo1mRukbNPqIkR6+tH?=
 =?us-ascii?Q?LgDyLPJOe8ZkYdyf+itdJyai85wppALL+yrC9aaZutjKaClP7Kvdh4kUbVUy?=
 =?us-ascii?Q?dKWbtRgiyznidpZCxBKNnfdlW8ENNHx5D7p+tpGV5ldXWY30Z5FLtdBpVVEi?=
 =?us-ascii?Q?KhXK0U9IplNTdJR1n1/ilMGN3CjE/zJjeStrqxcHHiHMcxM5T8qdX0ofgaCz?=
 =?us-ascii?Q?8geYRy0i7KHrkB1Jn/4symWrzP2BwOATKvGjZCLmseO+Goi7F9aS6ByNLmkw?=
 =?us-ascii?Q?zH3SGoUmtBvaYjp+T64/xrvQSktJw98Y0nJXJJLwm7tHaZ+8T0MsZjRnxlxi?=
 =?us-ascii?Q?u7/TU8jGkTE6gcnmtuHTvZsAhk7Cb/7gRjxUO01d1jkfwuuzbR13aDlrjac9?=
 =?us-ascii?Q?gYyOVd5NWCZpLtaXUXbtLhJMjc9ijmohO3BLpLPuADD/HGhyLTTbKNvQ0r0Y?=
 =?us-ascii?Q?xXrF9a+G/+DRzp71OflGdd3S9DfTBXCaoXQHn6zhy17FBjvyY9l6PVX3qGrz?=
 =?us-ascii?Q?j1FQ6U66EmakIImeAGzJeoiYUjfajklzoDXE+NVNPs0GRBPyXOkwyEprzMnY?=
 =?us-ascii?Q?usj+YUwkJhOhKVC1vsewU+BZyTYqIRMzoW9bxCGTx1v2LW2Yp9S1stW4NsJN?=
 =?us-ascii?Q?Ecoz6QksNgzEu58Kn3YM7WbcAEWj9mejt4FW8BJLpa5tLYfCmVU/9usBNFYo?=
 =?us-ascii?Q?VQIJveiXidg+Lg0J2WXLse8KzpefxZpkpr+PhKTCK9ypfnFWGtCFKQLPJXq0?=
 =?us-ascii?Q?78TuD1c3lIRbp8L2OjgGjLCg3vjSJhHyqFSU0JhmsKrse75S24KntD+t4HEd?=
 =?us-ascii?Q?iGavQmBw7jVM5JrdoantTL4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbf892e-3cf5-4243-75c4-08de08918e00
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 06:43:59.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bsAWQRkS/JzCSoHPTRakQLrrw5cR0dUorfpJKqqbGZ0acp/zMj4bRY8weOK5vEtDpbxgAMuUlZWkxJ9sTu4iDm02CxM34uzJuWbFse93RurD0FbNdmt0xAycC2Y2TRtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR01MB8015

Load imbalance is observed when the workload frequently forks new threads.
Due to CPU affinity, the workload can run on CPU 0-7 in the first
group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.

{ 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
  * * * * * * * *    * * *  *

When looking for dst group for newly forked threads, in many times
update_sg_wakeup_stats() reports the second group has more idle CPUs
than the first group. The scheduler thinks the second group is less
busy. Then it selects least busy CPUs among CPU 8-11. Therefore CPU 8-11
can be crowded with newly forked threads, at the same time CPU 0-7
can be idle.

A task may not use all the CPUs in a schedule group due to CPU affinity.
Only update schedule group statistics for allowed CPUs.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
Resending this patch from the patchset:
https://lore.kernel.org/lkml/20250717062036.432243-2-adamli@os.amperecomputing.com/

Only changed commit message. The single patch may be easier for reviewing.
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bc0b7ce8a65d..d5ec15050ebc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10671,7 +10671,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
 	if (sd->flags & SD_ASYM_CPUCAPACITY)
 		sgs->group_misfit_task_load = 1;
 
-	for_each_cpu(i, sched_group_span(group)) {
+	for_each_cpu_and(i, sched_group_span(group), p->cpus_ptr) {
 		struct rq *rq = cpu_rq(i);
 		unsigned int local;
 
-- 
2.34.1


