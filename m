Return-Path: <linux-kernel+bounces-743078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F7B0FA49
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 20:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5561D96597C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 18:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C9E22D4DE;
	Wed, 23 Jul 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="HV0jJcEw"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8F1E5B63;
	Wed, 23 Jul 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295336; cv=fail; b=WN8AJ7kTELlJEHDZtUzsu2D6Z7B7aR2GOVPWM1oOQ6X8Oeq78jWphDAH1byRTh1j42aeJyve5UaT8jA6t/Jm57KwIsEQRJf69YeSSEe6WnIxBgU5QBArSzt6z487w+Z8YTgIL0t8Jz10h/QBWBHyMDqh6aFTWoGe3nlSXD+hhbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295336; c=relaxed/simple;
	bh=LzGGy2ZWilpJRJhuLgUCrnU2uIYN3UuVcyYjY/i4lz0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fRCQ0tpYymTShjAtaNj2JqQxtCM/HOQfoUIbIQH5dJKLCMTAhrnunDx6TN1QC2U+C/r0QsrdeCg3Vk1/TZ247rwjQDg+2NhiPPmLNur2iKqTDKtVYkblWDs2AhvwSJ7C927dOSFbXPxYFkYj6pPiyD/ouFlpC6dH25a6Va1hQZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=HV0jJcEw; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4Bo66Q8rgoq+7IlkYmC3xdoMS5g7OTyne+lX5AmzCMcyIwcyZ1rnmUPdzfboD9C4DW1CIIr4OvwGaMvVBwcZeeyycmqTLPk5yTkYmclYL0h79lWmN4nxy3UHIcaS9CC9AlCd05sQlPzHwE2y124d5J2qG5B1mjWO3LVbzLufnpKemvak4KXaczwe0hxaYzXLKtQ7HaOzus7/NdilNjgs1gD/7uHVQ1sXqMvqogNtxToNsZGDWwSbH+4VrLMPQE/lqDaUEII/+Z4ijuFPeM7Y4mEZh7vWrkCF5mLoEtI5+HaFinWlkMu/5PXqhHaGErHS1qB/riR5bgoWNiMZq7Y8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIB9bnltkvAlrTmadKNTXWIu/5DlGfW02AMhdQVrgD4=;
 b=AGcZTBr8p3gzr/D5P2FzXziKzUYQ+xMX8TOuQUGCat25tkymX8HV04IfVdo54Xio5JtQs6LQi21YCBRuzr2tfgd9yG6xLPPZj0vXIFZJLcN/0iNQYRrQNaog7e+uXTwhYhVPd3gL2gEKZ+OTGZ4ux/BPrmqqrthQ5H58Z7Aa4PH0KvqCFYBjmIVGXvlh2TVKbENBl+7kq8suMsrDNGA41nudy/kiA2PdQLPpgHRtTofxCb28Dvopt90CUj04nbrlCQtUaRrGtM8TrpS/yhwIXSnHqN7hhocngRnycVHDTXfml+O1T4Q/Pg3Li22P+V73G9ErXenxykmryg80H0msng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIB9bnltkvAlrTmadKNTXWIu/5DlGfW02AMhdQVrgD4=;
 b=HV0jJcEwPlmKf+4ceOUrSr00J3ap9FLmpThLjzxJjxyR5hecqt24P/ok7FlGTJFXxY08NK3jDKtC74wrkIJNjxJT7quUSMZdz5xyMp+OUj0bf6J/Vn2OLmr75+neJChUrRc+TDf1fzF57Ih6cZxNF1Ip/afwJ7xEysOlXH/x3+TALsIixabKvbfL6pPQ+74BmqIBHhvW+5yjXgsC/DIA/rRxo4EsisUf1gpUDe4XMLJMsCxJKTKBRxEBlncE7jBv+8rMBcNWwETaZHoTiUV5KIyruuzyH2W9b8KgLfvPCwPTtTxQuMtevlZ7zHKLi4ESXF0mUqI+U5GO4QHEPBVOAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by PR3PR07MB6794.eurprd07.prod.outlook.com (2603:10a6:102:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 18:28:51 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 18:28:51 +0000
From: Wladislav Wiebe <wladislav.wiebe@nokia.com>
To: tglx@linutronix.de,
	corbet@lwn.net,
	jirislaby@kernel.org
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
Subject: [PATCH v3] genirq: add support for warning on long-running IRQ handlers
Date: Wed, 23 Jul 2025 20:28:36 +0200
Message-ID: <20250723182836.1177-1-wladislav.wiebe@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::18) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|PR3PR07MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: f42e2c8f-51aa-48a2-5f98-08ddca16c60a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/VtvGnsykwA1e4Co3b95DvADVodwz6MueOuqmDlrRCu6lgtcTvFUIJ+GJJNc?=
 =?us-ascii?Q?a6ChxJELqVSaN6SivhCY6l3xiuUSxSvXiCy3rO4IZ0tu2LMEANH9K+UYHWSm?=
 =?us-ascii?Q?whkGI1eQaT5yA+0TbnHza2ysN2CbxalnYlks0WPUpUleY6P+3YMzWZ9pB2g0?=
 =?us-ascii?Q?KlP42GNitU/ioolsOPSpbPqtpWVDAGq4EgTQ3JC4y1QeRicgyKxaeCfyMxBn?=
 =?us-ascii?Q?kt5BYF//qiT6iyv1YNMXy7W2PdnMQFHxvYpGEZv8X8aLGtWntOPzdOEHG8OQ?=
 =?us-ascii?Q?zxhXbnkKNqCwXC9JxO38YF+otgNV883ZY63F/ivrAk0WosUs9irLdu0ZHx82?=
 =?us-ascii?Q?GVbr4irpjY1WSjcRLxCNtZJDSaQ0dqEsqj77teCn4sJhlzgxtMHAVelUBsoQ?=
 =?us-ascii?Q?xHTN147UeBdx80VxWFk/9eWjlxdxHma/XRWnh4y71XvJGVaPTSgcJZivd1Q9?=
 =?us-ascii?Q?yP12ooOhXl+x/YfUXB5t5PGq8WBaeXPESQOLRa3jfq3OaJ+iK/nBUwsJY+Yv?=
 =?us-ascii?Q?sEv5z1AuD3xqaz4EtffAle+wqr8Ho5y50xOAHwiQs9xDDlXeeUjfUmORiL3x?=
 =?us-ascii?Q?EOH3UZrFCOdgJEOEvIknFVxloTeYJMEuqbeICgVCXQvXeZMCu9ICayTyeJKc?=
 =?us-ascii?Q?4noPxAlImnd9AAVWa7llvk4b4Z2PFgxxJMFuK0SWp2Uu+LccKtKMLgQ97Ct9?=
 =?us-ascii?Q?KMhkTvdo5k9Bge8dVR/56Fiucig0+EsVDLg3z0mLBfZwSM64s62OiNuaxM04?=
 =?us-ascii?Q?2qsmJWTUWL1nRRIDJDyzW7ymGI3wUpKUXuUKeFj/0V+2BO4izdf4keQi5Jnn?=
 =?us-ascii?Q?yENSNF8+g4L1S4o8bucYOCn2Qr2xj+wGTXhn2nCJSYAJDYc6WMVz6WCoJucd?=
 =?us-ascii?Q?vZ73x8U0iK6ukJjbLCAuQOKZzm1f15cyCKFGbLIcZD+ud0hMefoxvk2pLBex?=
 =?us-ascii?Q?bju0OtUH6Yn2uamxClqzkOZTtB8loT7do5/GmUAlkcHZhRUZn8k3lt/KEFKa?=
 =?us-ascii?Q?W2q8XDTPvy6lNDtdLSWkPlgVcQXhkW909hS6Qmmb7gYpKyWWE1TeJrmihg1p?=
 =?us-ascii?Q?jA0RcAKmHDXsQCwlNB7szCVVQT1/oQeA1XxPgaIIHNsTkFVPPcsMSjy4iLAe?=
 =?us-ascii?Q?epv8uY3sclHQkm8Xzy2TuTVU7ZdWg9AOivtXX7tSOnOFG6s8PiVIQZBrkqEk?=
 =?us-ascii?Q?livN1t3G17aYmqybCF4gEeJCEznFoUibrcGipqf3ouhR8J1Fn22dFp/PevIw?=
 =?us-ascii?Q?F4CJL/tETJLsXmh6A4jug6Svo76SUCE2cyh3jSyDu6IzW3Y9vejM2Kl1cVFM?=
 =?us-ascii?Q?V5rGuf4V5iRe+2M8dGVcN+nf2RrT63dMvq2GS4DvzpBpQnFI4KaRi0TuIEzV?=
 =?us-ascii?Q?bBG2v6n7aWdvBXFhgLSsgUKtiIELKY6CRZLMW8WaLzjea9xazbggEh8k2S6W?=
 =?us-ascii?Q?V/ebLZL081A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+8ULR+rK5rTvctEuH8gVf/PncaXQI8qyBpR6aJ9nBw2RY2QA+ruKYWuHacQp?=
 =?us-ascii?Q?wQJ78FQBLCnb25vRRgYahJqTUICdquPwSOM/PCwSdojRW0jVLAJEGKA7d4HP?=
 =?us-ascii?Q?L2LkVFS2wFIILaZN1r+ZI/8lMyJnaqF29FdHNKdZiKmYosnR/aOgx/sfCtrX?=
 =?us-ascii?Q?8WecCnQ80cJz+xrOYNanVSY2cLL5c8A2iDQVW5D0xo+2+ErlwS4PV4MMbyA/?=
 =?us-ascii?Q?NikdIexpiyK8TNjJFVgoPuT3Sj3OyPl0VRL5JRCt9caQltHzAxGlRZZ259cJ?=
 =?us-ascii?Q?1xSb/tgJzcNy7XMavVTtHezCE9be6Owudpy9syHNjVxXxw9/0T3McleynPLv?=
 =?us-ascii?Q?KZdtFDryiKhwx9U2W+6cuSoW11ihwVCicoMjXFD0o2y5jHSRcqtS5KBo9ojE?=
 =?us-ascii?Q?usYkwTHjGn8DomHJbvqeLV6fZJLx1OZN8pF+1wyle9hOaDMsqf+omhCS9kAM?=
 =?us-ascii?Q?O21xeETiLuS7uWa3ggI9vNSRqhrFiAIHYG2URKu0JGTVlt1wACItGWQctVyQ?=
 =?us-ascii?Q?nXpMFBtcjjuQUSjFR2AsKEf/P/EqKdTBXjC7okyiv5AL7jy36rl0DhahPB9L?=
 =?us-ascii?Q?igesW78MrLvJ7vQtXHXTsKBPqRFW/sitjb6de4lnNj8hi7BeEaBDF/+fppWN?=
 =?us-ascii?Q?tsZoogKeDXHeTmOqJ1Wd9exFZDk9TQU8xL6oT9i2WU+IgyXMY1lhMG1GtceA?=
 =?us-ascii?Q?PGMZvJrbafAB5D3E+lbc9t/RmlnyZKbz6yLZz8qWYEINH6jU4OfuJMvGjNbQ?=
 =?us-ascii?Q?rjWLL0OiMFksHrWvn6Bq4mil2Ode1X4zdQ2U4jwyrLWL87lAyx6zXpFUmJPy?=
 =?us-ascii?Q?6MwVus/xa3XU8/D1FCNrcPT+i0LaXDId3/sx3Ra+Y9O4rK3HCl4u0Ljr/Umz?=
 =?us-ascii?Q?+rnVMDXJC8Otr9YpR7zV2i9Szz2IZlZ4o3XdQWmogDVEbKuCryM+Q1cciX4F?=
 =?us-ascii?Q?YjyhGHSz4yLlgsHrzeGpDkWQ8dBt5ZqvTEtl04wqqew5y34tJTvgtGhHtwiv?=
 =?us-ascii?Q?eTlE1gSyb5c7lEkyxXAMqZlwGoFXCFR3EoOh0wPTRl315NOHkz7CjekCD16Y?=
 =?us-ascii?Q?cIKA3B0+PmS0TF9BsWNIfr7pGvZioT1Pro7th8bJ3nU2Hzor8XyZfB555d4Z?=
 =?us-ascii?Q?R3qDIK5mmw+6Y79NhgPyO0BXQajeXrH+g/aE6YApqidPXVL7vxXUDuzPAkwB?=
 =?us-ascii?Q?gL7ENaCLnwXi/jok8aYitucknW8FAN0xNB0CwJgVQsRVBXdzNmxbPNVNtW6k?=
 =?us-ascii?Q?5VTTk6A8yF33to1H76rV5YRp2w1QYSzbHqGmQpKSepaFQUhyKaZpEIlbhJWh?=
 =?us-ascii?Q?Efcb46HaLm3e8yQWxebwov2BcwvvPxDkClYDO5BgkDDjnY/C3zTio4o9/ORY?=
 =?us-ascii?Q?enrnglkFUSKKsB2RqEmIj7iUcfiF6J0VUik93JXZWfe8I3WjgN1QH6op07SR?=
 =?us-ascii?Q?mOSYwGZKLdnZy8j/fdhvN82aNY1biBQBxVL06yX6jwE68RloSfWJzNEKzTDn?=
 =?us-ascii?Q?i1RLl2XqBWPenTclF8GW1tX2PO+aKEzIfA8KYsU5ypHv1Fm9zxhqowrzArrV?=
 =?us-ascii?Q?k81DZsAopmbjBm85x78qdtxXV7TrR1yLlqxd7ry1HmeorrvGRZ1vahdoNbl4?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f42e2c8f-51aa-48a2-5f98-08ddca16c60a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:28:51.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbEBB9D+BdEEbCENn/Bs7+vUyRV3qvdpA3JD+0NuCjHT99vethVNNHdkSoRDWTU0XFegB+UGQjz8XJxYR2dHxNQT5FTYwYPeq44EAU07m7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6794

Introduce a mechanism to detect and warn about prolonged IRQ handlers.
With a new command-line parameter (irqhandler.duration_warn_us=),
users can configure the duration threshold in microseconds when a warning
in such format should be emitted:

"[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"

The implementation uses local_clock() to measure the execution duration of the
generic IRQ per-CPU event handler.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
V2 -> V3: Addressed review comments based on v2:
	  https://lore.kernel.org/lkml/20250714084209.918-1-wladislav.wiebe@nokia.com/
	  - refactor commit message
	  - switch from early_param() to __setup()
	  - comment on approximation of nano to microseconds conversion
	  - move ts_start to if() branch
	  - align pr_warn arguments
	  - surround else block with brackets as well
	  - invert the condition and drop the "else {}" in cmdline arg. check
	  - make struct irqaction *action function param. const
	    in irqhandler_duration_check()
	  - print smp_processor_id() return as unsigned int
	  - fix warning text "on IRQ[...]" -> "of IRQ[...]"
V1 -> V2: refactor to use local_clock() instead of jiffies and replace
	  Kconfig knobs by a new command-line parameter.
V1 link:  https://lore.kernel.org/lkml/20250630124721.18232-1-wladislav.wiebe@nokia.com/
---
 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/irq/handle.c                           | 49 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..7a2d0338ee91 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2543,6 +2543,11 @@
 			for it. Intended to get systems with badly broken
 			firmware running.
 
+	irqhandler.duration_warn_us= [KNL]
+			Warn if an IRQ handler exceeds the specified duration
+			threshold in microseconds. Useful for identifying
+			long-running IRQs in the system.
+
 	irqpoll		[HW]
 			When an interrupt is not handled search all handlers
 			for it. Also check all handlers each timer
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 9489f93b3db3..258f40ad8cb1 100644
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
+	ret = kstrtoul(arg, 0, &val);
+	if (ret) {
+		pr_err("Unable to parse irqhandler.duration_warn_us setting: ret=%d\n", ret);
+		return 0;
+	}
+
+	if (!val) {
+		pr_err("Invalid irqhandler.duration_warn_us setting, must be > 0\n");
+		return 0;
+	}
+
+	irqhandler_duration_threshold_us = val;
+	static_branch_enable(&irqhandler_duration_check_enabled);
+
+	return 1;
+}
+__setup("irqhandler.duration_warn_us=", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					     const struct irqaction *action)
+{
+	/* Approx. conversion to microseconds */
+	u64 delta_us = (local_clock() - ts_start) >> 10;
+
+	if (unlikely(delta_us > irqhandler_duration_threshold_us)) {
+		pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n",
+				    smp_processor_id(), irq, action->handler, delta_us);
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval = IRQ_NONE;
@@ -155,7 +193,16 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 			lockdep_hardirq_threaded();
 
 		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
+
+		if (static_branch_unlikely(&irqhandler_duration_check_enabled)) {
+			u64 ts_start = local_clock();
+
+			res = action->handler(irq, action->dev_id);
+			irqhandler_duration_check(ts_start, irq, action);
+		} else {
+			res = action->handler(irq, action->dev_id);
+		}
+
 		trace_irq_handler_exit(irq, action, res);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pS enabled interrupts\n",
-- 
2.39.3.dirty


