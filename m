Return-Path: <linux-kernel+bounces-734681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC9B084C2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95D2581F74
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7835B215198;
	Thu, 17 Jul 2025 06:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="Bs40qhbh"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2095.outbound.protection.outlook.com [40.107.100.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F371E2312
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733285; cv=fail; b=sFqEdvOR0fxkQbVFnPcK4Tp/C4NWGIzo2RUVBxWVACqJTEPz//5UIMWO399/7Pc5G0dZg8OfIhci7x3xKYGpW3t0RBx43ESx743RT24fkcf1/9yiylys4a6zw+kMCtDL5VVhCDUhjY1TkVN99OC9YfhLGrOHuVxKyWuzvCjVQl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733285; c=relaxed/simple;
	bh=LcGFyASB0l00aJHpdkFXoqhrriIis2i1AuhZHxvE81w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uJ1QBZHwQMUr3Z6bt5S+Bjf7XDFmI4wSSn2i/8d/2MOe6liZhLsFOu6sioFyGQycmj22cPaZTMi8n+noIIQIHQYbNPXmN5bJIfmUp5gSQ+gMuDON1nUx0bsZHqqItIQNDdkfuXLgEdXdurhM2LjoTgmozbZ0wRGHXzJy9ulFtig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=Bs40qhbh; arc=fail smtp.client-ip=40.107.100.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hAqPdG8H8nrYdWE0PXhF+ahHMF2wOR3rVIi16FWvpwAOKInwS2wC9MKKPMZrPn28rUhx4iQuRImxsmmNabQTYTYeRRLwfIiloznJl+tADWIeIhEcwSJCOFDkRaMY5wALNebnVnbtIWWiTaXqBykVsVaq1VKXEo/FAPk789Bc9ycgMRcbG2/i2W5osqYaIYNvlDEoOWA+iA5HNUJOpt+xAEma6Ggak4QQoUW9i7II0IYwIT1/R7PjiwHqtWPb8fHMnlxo6dKOXp9eAlg/td2IAD8ebzmPeRAM4qCFbD1tYEo0tmQxrsS9VTh5VNZyTMv6Rd53qR7IKi9oscpyG5Tm+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YK9tctMcjXW3aVDhAIoVsniyGzXwglzwIMQRLRtN+mU=;
 b=IIbJZkcgFHGRCdD+ln+v3bbBqkePYU0OT06LBG96Wk8KI/ZUdx8ycSBBZA3Oa+ktqMea8FuE20bSTIQF2vqD9BcJzT072UpZXP3eFrTLkBSFLLBfJSqa+qSWagp9rHmvq30ALfkZMVsS02OaM0qxxp6UJvmEgS1kocUQPcC7dplBxUTx3P5SG1pc6OHDDuvaI3k+yY3mH4UsD1/k0vo3Q1WxLRYkQ72nEOteLVQ22YlHcn3gAbQleQo7WY8h51rdHpjvHLyhYA9hry1WYZmIKzSlf53riBjUxsinNHfWkdjQEZovpVPkAghwGDx0FG7TkyWLA0lo3yC2NQJAvjs0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YK9tctMcjXW3aVDhAIoVsniyGzXwglzwIMQRLRtN+mU=;
 b=Bs40qhbh+5IjopojyvL+68cL5+Y3LIMJLX6mRDExrTQc1B/6Mkj+KwBzdKowQOaatAp0Xt6IGH+KNuwJN9x6gf1PkEQUo1ZwdvZn02HiOTtp0D0CCh4uQRMRnzu+foryUo4sbf627Sz3ejDvaML5l9Uk5+9mYUqbjy8LwmqX/Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:21:19 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:21:18 +0000
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
Subject: [PATCH v2 0/6] sched/fair: Fix imbalance issue when balancing fork
Date: Thu, 17 Jul 2025 06:20:30 +0000
Message-Id: <20250717062036.432243-1-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:990:5::13) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: cbb5be6b-a8e0-413c-3522-08ddc4fa2433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X+VqMeBVQGzEdIrDAcMfjL7vF5+dQgsos42XwSZ9q2VbQEa6wnlUvy+jVmZh?=
 =?us-ascii?Q?C5y+yob0sOe+L9/qSFwSaAK50P7aiUerMLOja4A3lPvE45Br1/nFu5ZlBcWF?=
 =?us-ascii?Q?y/Kb8m4n4qKAB/USrTNrddyEb2sT4QCZt3N9L8j21bBOz2ud2C0NGRGgrXEt?=
 =?us-ascii?Q?rdU0g4eLfts/cpQ2tLWtqBy+s8V+zNb6manBpNMy8MNjGWuZM1V5G9dcbg3i?=
 =?us-ascii?Q?3cZ/u0v+W4S0gBtZx9jU/0qnwZ/DjlVsq7M2Q3cgdmUJozMFG7hDNTO2B5Wv?=
 =?us-ascii?Q?Jl6oy85fk3yPBGaJXZA/F7XbQZLRXJMhHBl2oFr9OS0YPQoWGZStQ9qiGm7p?=
 =?us-ascii?Q?HnwmAt88cuV9pJntwTcdOouEz35Gkr3AezeDtl9DeV3b1PpJD1Nvt51VJQHy?=
 =?us-ascii?Q?cdaYpak0yZYI23ov8k54rT78UBFkb0+LOhoRutBQJPjPbXxN2M19iQlaubhQ?=
 =?us-ascii?Q?cvQfjs8WPaxSCqVj2TKJfL13y/I/OG3mVTkF/ATfWcW2LMjAnrnDMRGLswLv?=
 =?us-ascii?Q?l5YuZDYNudz4GjUWnDxFI/3+Fvt8Ldv5f8V0oZT6g5LNRoyUAbZevBINFiVo?=
 =?us-ascii?Q?2NndNL6P8Rz0AaOO6QqY3ZpQHUfsIv7n1fmDahTBQ/LiFcKxWFpYJywQTPPl?=
 =?us-ascii?Q?TsZ9TEMyiO7iDGsSwrpTp8kRKa87Lqk0gpgSTVa1xFpISoMR277CebzSh+ZN?=
 =?us-ascii?Q?g7WnMJL9wIVlmxjx6hzARcFyO5EKDB70/oiEZwZbh47osabCSMSoCvqcVSef?=
 =?us-ascii?Q?yWXBNtuJcRC0IkadrUk2LkK/7JA08LoMfCCWI6ZcTXkXOkBoQRPrHqINRINO?=
 =?us-ascii?Q?yypzr7hFZdpoFVscrs7yrUNIJpcJjwLRA8xLo+7NpRNv/tocyRgZfSDvv05Q?=
 =?us-ascii?Q?VpIFS5YJS8WrSXPhuBGBFlrM/4KxtWInTOIcScikiN30QuH0BVbVsUneYsOR?=
 =?us-ascii?Q?+5I+mg7Mlr9MV6YQJR8Kvof6NvhANtD7lNqTySPrWKtFUAX8Mn0JFffQHeOD?=
 =?us-ascii?Q?ZfEBbZZ0aSzvNWYw/uSVFtcu7efmSWH72vAcTn1Vv+q0vNJiV5gQ0BDklZAA?=
 =?us-ascii?Q?8z5EJvXtA8duII/7rG5pES0s8AdrpS6LVPM/uI/vlxIeGn7OHMJEK4nRR2hG?=
 =?us-ascii?Q?QoJd9dPE67b0j8gD9tOvxqDgxq8TtN9tFsalhepwVHm0HniC5NVMSRYzvE0O?=
 =?us-ascii?Q?mYTUxyv+Cj7RC63YFG6TB8TQ8hkHFPeWApTwCDHdCtlRWmffT2vlf3NR9ZrT?=
 =?us-ascii?Q?E117PLsYUVq2LI/P6ZHJika3mgtn9qkM6hTXxrI+TwnsWyxRhe2tYJi81Evo?=
 =?us-ascii?Q?ZBj4Xj7VbmVmxPOR5UACExcfcL/o5lcC/jIN4OXb7fBR7YuT2f0aMMjG/Ee0?=
 =?us-ascii?Q?v323Sf+h9N3VPi7QjfnkNwJcjN7Nxe0zN6rgMzX9wu4azUy4AohmckUgFcD6?=
 =?us-ascii?Q?ADIElBtt1JU4q9iy0XNlxAFtYe8rybWcdiSAeLrHKda0dlwHAXhqDEYpYS7B?=
 =?us-ascii?Q?SPa1buHF7UTUulw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DvGCAGElG4RGmthZMu5wKOCCEnzUC779pEX+FiAi935vXsa1Xukf2VYriJJm?=
 =?us-ascii?Q?CJh9zwv8QSQDq/Asy8f/8OIDkMxqeKpnOOTswHHyU/nad30SadLFLaOHsiML?=
 =?us-ascii?Q?AKV+gv53OfyC+0CioWKHC7OgPuGAWZ1AmeDAS2zfFoIe/SpUwaxoClQj7rph?=
 =?us-ascii?Q?bI+dnfN9zgcUb1y//+6D+U7WAFz4DMsiF7d7R6D2nrymzp3dizr87KS+Qi22?=
 =?us-ascii?Q?86d9tJYrIq9fI1J0XM0wf1o3ICc8t1zf1piEDCsm0FSB27S6zImGz/9oFQDD?=
 =?us-ascii?Q?4rAKR542gpHjV3QhafCvXgHTlDRv6Fp9+uvBeXRlSbzPTxLNDCc0MKnHfgg5?=
 =?us-ascii?Q?WDJR457JG57pn5HkTb/iOoTMSpjRK+GBt/tBU+nuFTybxTcrqbodj9FUe3P4?=
 =?us-ascii?Q?GIXY0yiTPJ+3erXhitFrL6aAZBrIXDYp/lhFqKiTfk86/Xc7fd7CudfBKK62?=
 =?us-ascii?Q?GA7oH2K6vg1ff35f3VSosNefQYXf5Eu0ffwEYBu6zXMkSpTehrm+W4ft9Js6?=
 =?us-ascii?Q?5BpxAYWu/KsynN6dIewYQhecSaWWKPjCiKb1qRYa6x0ITLIlCoyeSmNDUerB?=
 =?us-ascii?Q?5+p4jvRbbamPPw+Z/kNBRD3Lk/rt6htuLS8C5q3JgHxwYqN/6YOnHCMr7rva?=
 =?us-ascii?Q?Q6BIq3lUc2ZjvEhNsPtX/zNWB8/dFVrd62gh+SUTH7iyxMDNpMsG240UiJL8?=
 =?us-ascii?Q?Cc1I5E/Tly+iFb1w4OT0MkkDSdilERzcvCd7UirFeKypWotJ0LWXadwR7qkX?=
 =?us-ascii?Q?CHobkahrxKyHo6szjSS1kzr9E8HywVlUHFQ+uIqAa65JFi+q4kcY3CmViKbN?=
 =?us-ascii?Q?mAPQUmot7YP0oc5yRHe332YAXbEuAtezG5uVYqHj0DmUbn0n2fQPupfjm9y3?=
 =?us-ascii?Q?Zvo6HarqTn8H45z0fVJ6+Z0h4fHiq2JeG470Df1rm0JEAAoq06y6uykRyJru?=
 =?us-ascii?Q?M7K2Waz+BlTaTS3NHlbV4tO6ey9e3dZKpYGoh8vX8QoSvlg8oCVG+1xfg9ac?=
 =?us-ascii?Q?DJejxCutx1YYTtGMQlV5mOvMzTDdxcwEM0HjE9XnOwaQfb7l/YMN5BN+oYXw?=
 =?us-ascii?Q?4t0Yhl8FlFCSnnsFFE3txSkgbP1kLaQrvElG0a7v7A+8c/bkcaAyvu7JGDwP?=
 =?us-ascii?Q?Y/h0LIwEZ7nzxIOjYisD708XyRtn7F1mqWv0MMXunAyvcQ+S11FcJNurvPTH?=
 =?us-ascii?Q?yn5xW0eo7WGXaNoYNY7ea1lNaaQKZ54TPG2O8hKhvyEet1iRv6tYx0XJDyX/?=
 =?us-ascii?Q?8rGEh0+9ZzN6YbRelcZMDQpGEbOsa/th59aeuqORAO6ASws5TsC5N0t5GZRL?=
 =?us-ascii?Q?F9yds84XK+ZKf+Su8spBFfT/RDi6xaDZXIbWRQ4rrtTHhhf0bAM4rWMJbFvy?=
 =?us-ascii?Q?l0rLkGfsO6L7BG37lB7I9+EwD/lwmCz6GgCJydXS4OWrd9bl5KabpKlHO/EQ?=
 =?us-ascii?Q?8gGC7PsMq0AZvlJQMe4LJ7Kes+KxZ3Ec2fXQA2CorOYfDKhk4BkEYMImXjj1?=
 =?us-ascii?Q?ZsRmCC9EVi2RAbMnGaZTYxfou3Mbmu73GdoMwNJENDO4QYWoa9eQRae/7QuD?=
 =?us-ascii?Q?dWdpwUM03y1Tffw3wo21iUClkOKQfWDd1Lwwb5e9jqsyQLvT8MMcI4yDC4Yd?=
 =?us-ascii?Q?uPCLXgxSccYA7k7mwjb1xc8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb5be6b-a8e0-413c-3522-08ddc4fa2433
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:21:18.8628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2UZchyl8FxNzkPdPQk3mTCoGsrf2Xa3XaouMdwgEpaq8OKbBUTHbTOwLRcIdlKlctVA45l635imTYLwmsJKlFuLkgPxKehwbsKnqnsgI9G7phm9gwoxKoFzMZDP/rP+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

Load imbalance is observed when the workload frequently forks new threads.
Due to CPU affinity, the workload can run on CPU 0-7 in the first
group, and only on CPU 8-11 in the second group. CPU 12-15 are always idle.

{ 0 1 2 3 4 5 6 7 } {8 9 10 11 12 13 14 15}
  * * * * * * * *    * * *  *

When looking for dst group for newly forked threads, in many times
update_sg_wakeup_stats() reports the second group has more idle CPUs
than the first group. The scheduler thinks the second group is less
busy. Then it selects least busy CPUs among CPU 8-11. So CPU 8-11 can be
crowded with newly forked threads, at the same time CPU 0-7 can be idle.

The first patch 'Only update stats of allowed CPUs when looking for dst
group' *alone* can fix this imbalance issue. With this patch, performance
significantly improved for workload with frequent task fork, if the
workload is set to use part of CPUs in a schedule group.

And I think the second patch also makes sense in this scenario. If group
weight includes CPUs a task cannot use, group classification can be
incorrect.

Peter mentioned [1] that the second patch might also apply to
update_sg_lb_stats(). The third patch counts group weight from 'env->cpus'
(active CPUs). Group classification can be incorrect if group weight
includes inactive CPUs.

Peter also mentioned that update_sg_wakeup_stats() and update_sg_lb_stats()
are very similar, that they might be unified. The RFC patches 4-6 try to
refactor the two functions. The common logic is unified to a new function
update_sg_stats().

I tested with Specjbb workload on arm64 server. The patch set does not
introduce observable performance change. But the test cannot cover every
code path. Please review.

v2:
  Follow Peter's suggestions:
  1) Apply the second patch to update_sg_lb_stats().
  2) Refactor and unify update_sg_wakeup_stats() and update_sg_lb_stats().

v1:
  https://lore.kernel.org/lkml/20250701024549.40166-1-adamli@os.amperecomputing.com/

links:
[1]: https://lore.kernel.org/lkml/20250704091758.GG2001818@noisy.programming.kicks-ass.net/

Adam Li (6):
  sched/fair: Only update stats for allowed CPUs when looking for dst
    group
  sched/fair: Only count group weight for allowed CPUs when looking for
    dst group
  sched/fair: Only count group weight for CPUs doing load balance when
    looking for src group
  sched/fair: Make update_sg_wakeup_stats() helper functions handle NULL
    pointers
  sched/fair: Introduce update_sg_stats()
  sched/fair: Unify update_sg_lb_stats() and update_sg_wakeup_stats()

 kernel/sched/fair.c | 274 ++++++++++++++++++++++++--------------------
 1 file changed, 148 insertions(+), 126 deletions(-)

-- 
2.34.1


