Return-Path: <linux-kernel+bounces-770298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB541B27979
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ED2F7B7C88
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8012153C7;
	Fri, 15 Aug 2025 06:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="G8htHEHw"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2102.outbound.protection.outlook.com [40.107.236.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657A8207A26
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240768; cv=fail; b=DFXGtkXDmoleSCk6HvT1vkSjZQEOH3/jIto2AmL4FtydC9fuqH0S1n6WUWs50e8BAsCJwFLSW9GZtCYG8Hv5fXaoDx28p8L3lAgdl1Gtmj74iLaLKHa1wc9nKuixAXlsFURyjc4M3s9mo2hBvDAlc78R8HLdYHiCsJO/GcmO6pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240768; c=relaxed/simple;
	bh=12r47nHopHGHbbr8xRGiN3TedMTSSuNY8Z7u9KK4qVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bYimeui/EnhiLWehRLgNnE5mZsp4ug7m1HLkgSnVKs2t6I4I5y2e0jt3ZnvYs4wYqX7q0numIsKZY7um2jr3eY+tli25I6W+aqi5YXywBKHBTpDaCnQukzO2CJEcOFDBSzE5LKEoNOlu+wsQotf8UkfZAhllZd/jTgSgCD4vlAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=G8htHEHw; arc=fail smtp.client-ip=40.107.236.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIqKkbM62A43TM1Kkig9vYERLSziPOYgYqo2LOX904f1P1SGK+jyhLbootH1JimdH+3XmXAkqmxopFpRn5ls5IE48S1g8OmL2qKqwGC122LuD5QJ9YtBDn6/fht0Px4kApGT/C4kE6j1iTlEtJRzB6EVlOVoCeTptKso7a8w+uZXK9yz2gnqzo4oKDog6eeAWBRNrQfhi9qcLEB/vCD1kzGpX2zzsga7ONgvS9KjwxbPg3ryNyGDoQAsDN7Xn9v8aA8ZKfE/k+BVcgV3GEZdc62TdnzqrVMi6uXsBKM/+0s8CH0NiEWFvxvKOuJfaKS6ayAuRiAGISfH+pPmX27qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2CKVqqUJQyAEM53ljMgb255zDalrevfUMEIDh/at2ao=;
 b=HEUlbz56M72EiztuDbs4K9G0ogItg8Er2vcEGq3e1aBad8Df0323Fmq7Sy9c7KXE77Hlx2E1xPoo0lezK1Q95Nk9CUlnj5Sagp0VUQt1nKPmAoUmmXCissunlopyVVGSbHQs+oaGZzMOrl2/tOQkFq12Vx2BgNu9lEfVjo0HLUVXdizKAT+qU5Y+nvdlFzAo7k2srWegr2W1mYE+4scn4hD4DtWGU4a/2IkskLlJwuAJpAYuhleQSqvqEdNg6uGQREVSfdqnUDaq51PiLhOtqH5fgZ8MyJBfcyFKURAsmtzENfNhzNWCZqrjdEgL6CfUBrhBDKNCF8IhXZVCas3mcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2CKVqqUJQyAEM53ljMgb255zDalrevfUMEIDh/at2ao=;
 b=G8htHEHwWMhfm+VZH03jUEp5NKtvNNxp1Z6kbZwUJGumiNmj+Hvmt06BrgUp1NirzRzSQBCU7BjdmfXAQxUOD9DywkbjqhYhyGPF1VkCKT/CHEEPPq2WU711nKVzhz4soDnOAZhIuFTbJu+zKy2TMWSQHfC6CLLBvamZieeQNGA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 SA1PR01MB7358.prod.exchangelabs.com (2603:10b6:806:1f9::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Fri, 15 Aug 2025 06:52:44 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 06:52:43 +0000
From: Adam Li <adamli@os.amperecomputing.com>
To: anna-maria@linutronix.de,
	frederic@kernel.org,
	mingo@kernel.org,
	tglx@linutronix.de,
	cl@gentwo.org
Cc: cl@linux.com,
	linux-kernel@vger.kernel.org,
	patches@amperecomputing.com,
	Adam Li <adamli@os.amperecomputing.com>
Subject: [PATCH 2/2] tick/nohz: Trigger warning when CPU in wrong NOHZ idle state
Date: Fri, 15 Aug 2025 06:51:15 +0000
Message-Id: <20250815065115.289337-3-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815065115.289337-1-adamli@os.amperecomputing.com>
References: <20250815065115.289337-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0044.apcprd01.prod.exchangelabs.com
 (2603:1096:990:5c::14) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|SA1PR01MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 6090f68e-0e18-4eb6-86c0-08dddbc85599
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1i1KliKThFGJjbuEANV7JkUiGTTQZnhyoIV3PheNom7ZfYOhrn4RrfPeuOCp?=
 =?us-ascii?Q?sgp9xKc4XHVhv+Ol+FngjV9qmaShwkCpYETb2+DCp7NaAVvNpTyjWw/ysp1X?=
 =?us-ascii?Q?tNR73xcJ2VzNK1FGGd6rTszlD5rQe7DRJB6LJtDswyqVRKRd6Z2uFTKKpXve?=
 =?us-ascii?Q?3r6SeGoFhP87U4nMbpclI+V6ZleButcDdRgPqnmW8hbT/4KBztMtbOrUEvOg?=
 =?us-ascii?Q?4kvPSIpHFV/D0LFI3DDr86th+W5iNL1fV65twSe26ZowZ1PYOtFNwBEPjQaM?=
 =?us-ascii?Q?E+MwKHsBZWUzGkE9mks260vdOZLaHlBtft3zWl7m4b6fHGL7Pg4RtuUT9Zas?=
 =?us-ascii?Q?GbTO9IyHv1cK2X95Xr+U+wq6I+OF6oZXW5P5ndJyYbOgEgD8tyBY5+xCHlUn?=
 =?us-ascii?Q?wdyQ7oXENR597x37DvKhB7Db6fb2Ntm/HVsjQfGTnI3K6yF/hhArWaYt3Avn?=
 =?us-ascii?Q?IhfwPrkBX9wTTgV+BGZUirBl3z/uoEVqeGN34wZWqvAX12z0vgnCt3Dk0dIY?=
 =?us-ascii?Q?NasaHJpIbXJkmTBmZFOEQeTMLxC2eMlsorEbUicE+aBlRVyElWoOSdduL9z4?=
 =?us-ascii?Q?s9U/MXn5m5o5itXGuaFS9pTgEaku8Bbk+HYGvumr0lUfJwfPZc0IqEwNVDWF?=
 =?us-ascii?Q?AQFlbKSC1UenjbU04AA+EK3rlzSvHyO328vlfrYLEj7pQXsc3pQILDS09Vc2?=
 =?us-ascii?Q?zO3WBdyCu6SSl1A1+XmFDKhf8C0I7Sk+GffofsHTBOiuR3jT44GTlBLMuQiT?=
 =?us-ascii?Q?y6uksHgKnr/vsCNzmqk+3LhTf1QkXG+fnAqN8ZawSRsBzzlL5SSTxoyPoj9l?=
 =?us-ascii?Q?gP7JwtruHPm871rW/czgbA24MjDQWBaWgZzmT+jnZFlEe4lwv9JASDg4hSxc?=
 =?us-ascii?Q?p2+EcjL+4PGQemuyV8u4w9OiDh7iravv/dprVboEJI7LCQCUlAR5RkQx/xBd?=
 =?us-ascii?Q?1qF8FX9W0pQl86MazVBoypAyhYaZEOhQhEUdbSO4AKAeEt/Fu0dufDdnEZkc?=
 =?us-ascii?Q?2MWWG9Q+7Z5z2zX176KaaR6AVW8TJ01fRcoVfozqAtdwsrO+oRyt+rAKy/v7?=
 =?us-ascii?Q?WNYEaTo8hN4mTCgiHhAHjNFFyZijIGlu9P4L7b0v2QKSWvF3fxiyJVCfFowr?=
 =?us-ascii?Q?b3RJHaVTyDu5sZftTy2FMsRPdVt4aDX/jEUPv7+U+RdoiOVNvC6ml0tg58OU?=
 =?us-ascii?Q?yb+fmllcip+yr+d+FiXefHbY7XfUja753nFOjegYR49MYRKktwW5icHQ+uj8?=
 =?us-ascii?Q?Wzu9MTRURGmNe7DKbFCR/9EnMr7m7oK5YWLFqBJc6/4XJ6Bl+XFjNAuky/zo?=
 =?us-ascii?Q?cEfReQCm189YkRDoX0Qaz7If/QezG3LrEyixnVJixjox3NSCHy0l8/kd/ZfH?=
 =?us-ascii?Q?oc14LmX6hbvToCdT0CzESxQOBRcu7TLk0buxA9q1bbmF+0HoctoFQ6Bi/aJF?=
 =?us-ascii?Q?ezKZqR6jzO4C3iUzOBMdvmpI8lHbrKhUyDe4C8X1nHNixsZNht/Ihg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qe8tOyW8jgl1EjG69p4l4QgZ37V3GMBsIehenx7jkvvk1mevaBeSpU4laTGY?=
 =?us-ascii?Q?OmdRpumRnd+fJu1TXvb4+GNdp2mIiWV11HsMBT8iQVHW5VFxb2fzWJFuZdfH?=
 =?us-ascii?Q?QAS8CJHOcTi/kdC+/4eY/DpDIyEpPoX0HZ4p0Suhxc1cxJLBAyupw8adqJYB?=
 =?us-ascii?Q?ySpVhZn2oTXDbQbqbUGHHoi+c70Eb9lXjN0weJ3o9fVfM2J579yTtv4zJH6+?=
 =?us-ascii?Q?7Zyix68vGBIHd8LWto9PN/mjO2/ZHrDporIPU7zgRhrdiggKo40jjVO9dGRi?=
 =?us-ascii?Q?HhY9cfd9UhUvD4h/AMnwAt01eFKNCtIEOqftvH3O7f8gakS2ECAx06NQL6Sr?=
 =?us-ascii?Q?6haORJFjbS+DBl3R6ymUVLOq0CfOyu5+btYJUOC+Sjr2m2glVBkiAuohq5PX?=
 =?us-ascii?Q?Ykp8ZRAn54FV++HVNSfjH47/1KehlFbhg0x/Fppbf9tT1B5tbmqFxM18jtmE?=
 =?us-ascii?Q?RnnnIrnTIeD0zC8Afle0qt4qgv+uTsLIMHCvGpN0Q2lNFJSsNS8aKOz8t+Or?=
 =?us-ascii?Q?ehUpuLU2k3j7ZCfAmrO3OIFIsVN0H8SDCdb+yHaABm+LJoarvDZ2jvNMn6OE?=
 =?us-ascii?Q?dosAwlKlepXbYodM1RWN6Z63MJpuTc+WNk3YRQnBi0NtOmjuKYPctCyf39vq?=
 =?us-ascii?Q?kt+Tdxdl0zuHgOXV89s7GKXRVNZ9XoBDPesXYDC7yWfIjfE+qjJGcY9x18Gh?=
 =?us-ascii?Q?0Mxe/cDuY8cFCbi3v/0tg6jf7kKN+GXBf6o013nCpktCg2Qzp8a6baxlD0Kx?=
 =?us-ascii?Q?g5qdIG0Q87EK9SvIciUaF83ohQcTOOG3Gm9gSHOK1aKfJVxSa2kpw5aE2d7G?=
 =?us-ascii?Q?j4q+lfyQ6E5a8WQYUmk94tM20I72VSZ4QFDaE/Ga+zyoY9AiFYfvTk0RwE/H?=
 =?us-ascii?Q?gG4MzomH5cvvCqQNubEfUG48EaFMlwaM8GVWOIavHCxuCKhV7+s0OHStwdPG?=
 =?us-ascii?Q?fK7+8pxpHHLpW/Rh7jbh3RzPzDovFfGxODJyI0wzRCeHtPAr9pQSsJiLphFD?=
 =?us-ascii?Q?YB0JPXLkhqkRPo4G/rkQOgwekPP7ubYKyZuIcTchTeIEZf58GRhCV5AMAPQT?=
 =?us-ascii?Q?CQn6czwreAGc9/EF2x3jkBr2ilqdBuQxdPioBLgsKMCbartSURsf26oTGDaB?=
 =?us-ascii?Q?Fv7OapW/9Ei/BqiYDhB+3xZhXfOjqGIn1aNmrB5u4AqJabhIi+F6dYcFrfYF?=
 =?us-ascii?Q?dGb4L2Ka7S2vTPMW0RMc9dWYEX2OiWTcC5KMvqg20j2NBqRm5oTGxuCTSJv6?=
 =?us-ascii?Q?reXS5X0Sef+HXvCVfY1LFCFlm8BHIxBDM0BwNqjlnT86sVZjP7TrHyniEGJN?=
 =?us-ascii?Q?qIrmERF+2aUWQAwXbtjyO67KsMzkP/7XJOkG1doYBuT6PseKT2KEnRQFmJ6x?=
 =?us-ascii?Q?mFKbDPrgwixqIRc26Hd7kwCbTkf6XaKVlF92rMUXu40PEZ4OuHZG/lTxvMLT?=
 =?us-ascii?Q?OCCVl2lNV+86AGIYPUW9LaB7+0o13PiquPWs7fmysRzKuq243X3O1hn9RbtY?=
 =?us-ascii?Q?noh9ASbUz7A7dbx20PI7EwqEwYmNvN348+2L1Puo5SUYUV+kYyyxlGBi/Fxw?=
 =?us-ascii?Q?t/3MdE+zXUw2Uu0CA80lK2kvk7VclnvvMv5ltJYQEXDy9A6dQ47Sd78T6xsE?=
 =?us-ascii?Q?OtdRY38sp1pDDGekz5t19KE=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6090f68e-0e18-4eb6-86c0-08dddbc85599
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 06:52:43.9194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxshnqMS1hVIFlmi2HN/3o2C/gW8UuDuW7Z7TBo/TaIZNb7DBCHSCOLG5v+JkQEQiR7iqb2tjN2K1sbhHOMFDnqqc22eESDzoQXDQKV2XbsPGr//x2P/yDmeQmIrWU/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7358

This patch is for debug only.

Warning is triggerred when CPU is in this state:
1) tick was already stopped before tick_nohz_idle_stop_tick()
   stops the tick
2) and CPU is not in nohz.idle_cpus_mask
3) and CPU is idle
4) and tick is stopped

CPU will stay idle in this state, since neither the periodic nor
the NOHZ idle load balancing can move task to this CPU.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 include/linux/sched/nohz.h | 2 ++
 kernel/sched/fair.c        | 5 +++++
 kernel/time/tick-sched.c   | 3 ++-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/nohz.h b/include/linux/sched/nohz.h
index 0db7f67935fe..ea6e07777395 100644
--- a/include/linux/sched/nohz.h
+++ b/include/linux/sched/nohz.h
@@ -9,8 +9,10 @@
 #ifdef CONFIG_NO_HZ_COMMON
 extern void nohz_balance_enter_idle(int cpu);
 extern int get_nohz_timer_target(void);
+extern bool nohz_balance_idle_cpu(int cpu);
 #else
 static inline void nohz_balance_enter_idle(int cpu) { }
+static inline bool nohz_balance_idle_cpu(int cpu) { return false; }
 #endif
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..cd1c17368e05 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7109,6 +7109,11 @@ static struct {
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
 } nohz ____cacheline_aligned;
 
+inline bool nohz_balance_idle_cpu(int cpu)
+{
+	return cpumask_test_cpu(cpu, nohz.idle_cpus_mask);
+}
+
 #endif /* CONFIG_NO_HZ_COMMON */
 
 static unsigned long cpu_load(struct rq *rq)
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b900a120ab54..8241b14842f3 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1228,7 +1228,8 @@ void tick_nohz_idle_stop_tick(void)
 
 		ts->idle_sleeps++;
 		ts->idle_expires = expires;
-
+		WARN_ON_ONCE(was_stopped && !nohz_balance_idle_cpu(cpu) &&
+			idle_cpu(cpu) && tick_nohz_tick_stopped_cpu(cpu));
 		if (tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
 			if (!was_stopped)
 				ts->idle_jiffies = ts->last_jiffies;
-- 
2.34.1


