Return-Path: <linux-kernel+bounces-729651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8779CB039B5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D18B7AC322
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 08:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85F323BCFA;
	Mon, 14 Jul 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="Y2zJxTPS"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013011.outbound.protection.outlook.com [40.107.162.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426872600;
	Mon, 14 Jul 2025 08:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752482555; cv=fail; b=MPx/lS0Ze8W8yLiQ9MmQyJoWZB0kz3c7ASJFAdO7CyyZ70GpQnWXVw65fjmX/zQP/VLE2gyHtNUxfbZsLJ9MokerD9+Z5z2xlKMGJFM0/nYDNPTSnh1aRSyavbHjfHxJoghij8NKDfaoxlbbopJgmmdaboc9vCAefs2GV0AoN6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752482555; c=relaxed/simple;
	bh=cAsreaCIh49vKTZac1e5leFRQHJiL8wwsQ8I/cjLQhU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DneoB/iMPS695eqNUZ5TP57owlJMYgoYIVlLyZ/EA6SKv8LDQ8g9ZJegj9IRRGuqrO7nRBuOyaPloq8whWCYVz5lB5Ga8hOQQVTbkego11N6VPgALgaCrZoAcxDKeR/2m7xZeKuzWfzvBhZT/B+IcJ3fuOEkKTnhlAWISDgLw6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=Y2zJxTPS; arc=fail smtp.client-ip=40.107.162.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d971tJG5EWU/oOe5Rz8G/CEVw76E5lkzqBlQBAE4UdENSTCw1JFUGkh5uwNxpoSmV1bGV3Is7dRkz5MI1ZEWUtj0ZOdPAwIynvscjgQ+N/fHXugv5LNjSdpksFaQEmzF93llRGe5Tokmkwdd60Gkqdhx32eWB4uNbmVvD/aj4Kf69STkqW1ZxC/tczew58IhAXPrJW6PclP7UCiiWwZNVMMnKDyvn8BsBK82P39t/C1nNvUYax7YQQczCYho/bY0Db4UoC5Qn+GT++D8vgQ2BojIuAWYbpNJIdkNkIQVDKUVZZ8bqLQxNThPdruTG7T7PSOe7nUa6623ERgKNJprMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URZLMvvQO+ypw+R0ohU/Qyrtvl8IRs6RGcTeG6LeG+M=;
 b=UL8kdEnlZ+rIzY4C/UI/aF7GEKjPHWgZr4746IyvhnQ8//VAGFL9y1iBL73hpVZvJn3Pt8PcpgZLUi076EMR4rUKnIbHo0E5nucdffP8WE0OXWGM8WWjcPRrek71Du28z9Rscm5RjrhJbX++mg9e/AowERk/ciil7D4KkKHMXeTsr17vmxL9ftKr9IJkCHuCIkkIh9v6dJGpD0nwbuuTjSudCZ75jXmW7EGqssMcDt01404OZrA+se7Ni7hSygwJ2gybx9dcfwhFmOOv5x/sgW8V+e41rVLhCGZgh2ZHMpEnVWLBuJxSgk5lyHY0BmnjxIo2x4iNjkROROkcD+7woA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URZLMvvQO+ypw+R0ohU/Qyrtvl8IRs6RGcTeG6LeG+M=;
 b=Y2zJxTPSjcv1KZD0tgGduOlbbmZlziELEcWuC4/X5+iwvm8grTwMj4IseM7N9TCn2t8GrOQgpUd7ZQ06w6tDruqrTOMjwwTXdn1VUYNlaAnPNseoNxU37lNlnz85culc5qdcXZ66RoET2eHLM5VunBJ8/JnIHJnRpmwyy/0Y/ChQjNj7Rp5uLN21F6kPJDX5xoY5aCQ8FdFxghJkzlzMfrNjRW46hT8MIAAYPmuz2gqzwqH2jBVC1ja2vYMplx6pd8tIqW1OnLoBYrVCTetiv+KpVNdHN2jGf6EA2dM0hqJ9gwQhSM+ZQpjYwsrPgahrxQukfN3JZrzZ7INZ8vlN2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by AM7PR07MB6548.eurprd07.prod.outlook.com (2603:10a6:20b:18e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 08:42:29 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8901.024; Mon, 14 Jul 2025
 08:42:29 +0000
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
To: tglx@linutronix.de,
	corbet@lwn.net
Cc: akpm@linux-foundation.org,
	paulmck@kernel.org,
	rostedt@goodmis.org,
	Neeraj.Upadhyay@amd.com,
	david@redhat.com,
	bp@alien8.de,
	arnd@arndb.de,
	fvdl@google.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wladislav.wiebe@nokia.com,
	peterz@infradead.org
Subject: [PATCH v2] genirq: add support for warning on long-running IRQ handlers
Date: Mon, 14 Jul 2025 10:41:45 +0200
Message-ID: <20250714084209.918-1-wladislav.wiebe@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::18) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|AM7PR07MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: de486abb-e332-4010-6909-08ddc2b25e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VIGusdugBfZ/yrfrnWpNFLqygwKlSsVgZS6vl8myMkpwpYRWV7oFpZUriuJf?=
 =?us-ascii?Q?D7bCXraUm2MCmtwyDptarqaLTogibtYDvIrCjTOQhtk/27iC0yWnOrIzLv3J?=
 =?us-ascii?Q?JpQluWZT1awcvVyKYzV53KbGoHp965rgnBrv1y5tZl0peeDJ9ZEf7lX0S525?=
 =?us-ascii?Q?6rzwxHEcg5o9B+2hm9yUhDQWazkGPKCDrY58pPmaphBqjxAKn7401XsuWKLx?=
 =?us-ascii?Q?gKe0BnZo7ZeiqtXeMLjwEPPsChCmX6j/M8UqkS75IDs4Lb4Qe8+URE+xjuOz?=
 =?us-ascii?Q?TNFYUBNZToaE6MG1NmUGATFx4htG8dwtHeiFHn3NlmrzbI1r3f8z6NvhQqrr?=
 =?us-ascii?Q?jwbjCMw+wGwikQZU7rPXShbxBl5RoxjNgQfohetDViaxqJJSfDhieGn70Xdk?=
 =?us-ascii?Q?fg6cCTL8XLFQ65+Bh18rHNDEomLyVcuJ4wAhDyU3KeZhtRVcl/QNULnjo3p/?=
 =?us-ascii?Q?sNnoHh1srSy4XG+Cb5iLkWCQ5DJGuP2NJJT9+EH0owTH0fVWXxYL9hltNtrM?=
 =?us-ascii?Q?ktalJUjDeUKkYd7Nap6qvBAC3Dksrc/v5sPKgaEheystUzZa4UwPE4Wh+DhX?=
 =?us-ascii?Q?JdKsJj8Rbl6XP/wnePWQIQ3eiizbE+Cyg0nA4RpdfUSAqinF5vQ2ihHlaTdC?=
 =?us-ascii?Q?toMcPXPKf1ssL4j7UbkqogpSvz2sXvkWhW+JjHiJ1bVKHh2BLzBH80+0zS+u?=
 =?us-ascii?Q?CKcLLzAlATZa1Z+GdUwkZLCVO9D7YaUsBYCQYh2dHPQ+Uvw98A4Z5JJvPsqE?=
 =?us-ascii?Q?DEmbnnuhca7xlbZZF2hpkfkgb7KiHeyhgb+NdHtcy53lXmqW9ewe9v0DS4eY?=
 =?us-ascii?Q?U5SHUF952go5nBeYGG4JA6GRF81PuN/XD9m83Z9UO6shBv6GYs8DGC70QXJ0?=
 =?us-ascii?Q?g7ERdI2ZxJ4FCKu5fSmcXsTuYqw+CSWSkxTVJxd50TTN4O+lTvs23mYQFlwJ?=
 =?us-ascii?Q?MUW4rSkVNJdjLLTgy/1HFdK6YxsTvaS5QhnaGAYKDApj3PeVkjHn3kGA5/eK?=
 =?us-ascii?Q?t3QTVe8k60ys0r0JXSsKZgcdl7ea9IiqjQAM0L+6/gb/2d4xkFO5xYQ2WtVl?=
 =?us-ascii?Q?aO7krFAGhktktgYfQ2NkYJ1U7torWqyFt7id1nKTsJbCj1+Gad4vUZnAkFJB?=
 =?us-ascii?Q?3YXE0XEZb0E1FkX5oIDJo3St6aoQPX/qqMrb5dTnZhn5v+lIZhrXu9Mepmn0?=
 =?us-ascii?Q?1pbnI0DKtlG+hZT4wgfCkaylyvMxx/GuXWfHrCk4qIqmtQwXzWd4K1OCMV5T?=
 =?us-ascii?Q?dZQQcGtZ34aApkWrxmPXgNHmD8GhcehM/aMN2rW+Z07VlnFmIwzJEApTC2ue?=
 =?us-ascii?Q?80ek0QsWYZM5XDiDXAF62vEy12yfAxE68/ZUgnMkmi+MeZasln9YWngOMx9R?=
 =?us-ascii?Q?r8+HWT6Z5+oQHlHqjS5mPqCsFC1qHmpTP2WwHaq8ZyIqV3hP9h57HIWLBD8K?=
 =?us-ascii?Q?0tfBnsaz91w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qu14KU+xSWMqK27/zZZKcBwbd4UQuWZnviHMrNe9Tu3lQRszhyPPHCczupSw?=
 =?us-ascii?Q?RfGif7+apdcPCGmGhHCg/JDb5faNUh7Z0QJDkqpSD7mOfKrOgRtc62n808bD?=
 =?us-ascii?Q?uMM531g/tIOKKb3qgOrluZyRU3ujxiopPBXasEG8xbDPkAkMu+7NsYo1d/zt?=
 =?us-ascii?Q?fBUDMhPFMI3vea4YBUzZuX8xMC5AUbBkW6+k0WzWhjd5Qmk007MXnkF7D3CS?=
 =?us-ascii?Q?D1cMTLj/QJHl25fIrPymOJ+u76928Gdy0oDgB7gwsKsbDzCE2P4bo4e9cpsC?=
 =?us-ascii?Q?QyvOWOVx7V9IuumMqg+Dy9I/csq9EVAOUn9jUcowIynaBD1R+jYM2bQlDHJQ?=
 =?us-ascii?Q?xa8lxbtu7btAcFCW1CiM70iBWbP41DB6WIDfQJWEZiuAqDVyb0kn/3v/qwLw?=
 =?us-ascii?Q?cLXUuP/C4xLTJTqE1gSf/aoVvrqFPzhT1laqg+HJNG7o/Wt/N33o9yxg6C9x?=
 =?us-ascii?Q?pcaTmdGVwsRtIImRGfTBgtQsVbbhAyTj4S8YVB/c0xTZP1wSr4ee23a5HP47?=
 =?us-ascii?Q?S/HGVTFaxi4h76WrspP8OouuFNjCrDbKSKdEn3u2K8wRX4JyyXdNBca1CZcn?=
 =?us-ascii?Q?v/AySQKLT723GDv+XOQI+rkiMQL4ee44aNjegFKmWKroQ47QkMMo2rCULi/v?=
 =?us-ascii?Q?djiZiNSlGqN3Hig/3R5IUKZtpUYdUKsTX0u9RPEAS1vykMVggd0wKLuj+u94?=
 =?us-ascii?Q?ZkPx7wXA0sX5GTsdl4bd9h4KpZHnDbKG2A64SVUzUg7ee1r6uMVXyauStITN?=
 =?us-ascii?Q?wI5LSTbJnfiwGEEPUJV384E/6Od/JSZhyfOBP1Za2BYK4eB5vgrbrQHwSlly?=
 =?us-ascii?Q?jpoOfSNQk4++SvH791ma0Dt8LesAzB03KTs/3gcR7wChoXvpAXnkh7cCRB2i?=
 =?us-ascii?Q?suJesNayETUwF+z7F204SG0he6yB+IL2qrXtvvr3Ddms2g9+icDhaqpCEKHU?=
 =?us-ascii?Q?y1TdfMvGwMEhdxr2g7OXVi85qrB2wJ+i81bZBvEZwhTI/XfSvCEnrUSadUFO?=
 =?us-ascii?Q?rkwiqro7TbioQ3qZyCf90isUlZ68hkr0OM+2xfszFxNWuvr0oJU5VvJ5HWr0?=
 =?us-ascii?Q?qgDShdnq8NKJHZ5sCrWB2nDXBqamBx2vqabnsYend/flmgVekaFuUeXYspeC?=
 =?us-ascii?Q?gzkOIDutCnHnBU19xrh6VeoOTIUgC8mPMz+EFmcepr3YbeTvAi86j3M1wRlp?=
 =?us-ascii?Q?PoU8Sulh7ahplwwHQ2hiVvMJXBr1XrQ5FshAJLz+nglLWJ7/hrE6gwuQgcLA?=
 =?us-ascii?Q?5gh6oEbB4dPyq4kccg+ZZaqLFaI1hlSsSFeiDZe07lxzxAvNWK/de9PZ/sAa?=
 =?us-ascii?Q?DfcwAck8B2bR/f2+oPzhyw/AZEsR3vKYO5gr34sgQTuj5tI6cig82Rzjo5XT?=
 =?us-ascii?Q?zxHzTUHZrFwk22WYeVsQDiYNyTgB1tJhpxeu+FqSQeGHcNXup5SUHFb/v0Xm?=
 =?us-ascii?Q?lIEnFAm65AIfBwGtzFZ/TLsrCVYZSZinHxrM1/o4RvF1bfg8KBzj6QYVxjVT?=
 =?us-ascii?Q?Wu925xUs/VIg1peBdKWZ6o4cJwPxnfjj8a5FonNLMClopjCIORDyHK6xQRnc?=
 =?us-ascii?Q?BM/gHFuT9JGp2Nlann1CeHV4nz4941UiqlRGrFfDtFZ34QQCELJ0j+8G36tk?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de486abb-e332-4010-6909-08ddc2b25e07
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 08:42:29.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9m19ORiysRrzp5B4lD4QjoY2OI2roRW71kqeBFbxOTqk8IibzssuzAwTZrzKBEXOO519P5mIjRS9IYPSe6/X5pRA6JGza7NMVUntEHqN3XI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6548

This patch adds a mechanism to detect and warn about long-running IRQ
handlers exceeding a user-defined duration threshold in microseconds.

The feature is enabled via the kernel boot parameter:
"irqhandler.duration_warn_us=<threshold_in_us>"

For example, passing irqhandler.duration_warn_us=1000 will warn if an
IRQ handler takes more than 1000 microseconds.

Implementation uses local_clock() to measure the execution duration of
IRQ handlers. When the threshold is exceeded, a ratelimited warning is
printed:

"[CPU14] long duration on IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
V1 -> V2: refactor to use local_clock() instead of jiffies and replace
	  Kconfig knobs by a new command-line parameter.
V1 link:  https://lore.kernel.org/lkml/20250630124721.18232-1-wladislav.wiebe@nokia.com/
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/irq/handle.c                           | 48 ++++++++++++++++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..fa89f21ea1e6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2543,6 +2543,11 @@
 			for it. Intended to get systems with badly broken
 			firmware running.
 
+	irqhandler.duration_warn_us= [KNL,EARLY]
+			Warn if an IRQ handler exceeds the specified duration
+			threshold in microseconds. Useful for identifying
+			long-running IRQs in the system.
+
 	irqpoll		[HW]
 			When an interrupt is not handled search all handlers
 			for it. Also check all handlers each timer
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9489f93b3db3..eab8fdfab8d8 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -136,6 +136,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
+static u64 irqhandler_duration_threshold_us __ro_after_init;
+
+static int __init irqhandler_duration_check_setup(char *arg)
+{
+	unsigned long val;
+	int ret;
+
+	if (!arg)
+		return 0;
+
+	ret = kstrtoul(arg, 0, &val);
+	if (ret)
+		return ret;
+
+	if (val > 0) {
+		irqhandler_duration_threshold_us = val;
+		static_branch_enable(&irqhandler_duration_check_enabled);
+	} else {
+		pr_err("Invalid irqhandler.duration_warn_us setting (%lu)\n", val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+early_param("irqhandler.duration_warn_us", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					      struct irqaction *action)
+{
+	u64 delta_us = (local_clock() - ts_start) >> 10;
+
+	if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
+		pr_warn_ratelimited("[CPU%d] long duration on IRQ[%u:%ps], took: %llu us\n",
+			smp_processor_id(), irq, action->handler, delta_us);
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval = IRQ_NONE;
@@ -146,6 +184,7 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 
 	for_each_action_of_desc(desc, action) {
 		irqreturn_t res;
+		u64 ts_start;
 
 		/*
 		 * If this IRQ would be threaded under force_irqthreads, mark it so.
@@ -155,7 +194,14 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 			lockdep_hardirq_threaded();
 
 		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
+
+		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
+			ts_start = local_clock();
+			res = action->handler(irq, action->dev_id);
+			irqhandler_duration_check(ts_start, irq, action);
+		} else
+			res = action->handler(irq, action->dev_id);
+
 		trace_irq_handler_exit(irq, action, res);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
-- 
2.39.3.dirty


