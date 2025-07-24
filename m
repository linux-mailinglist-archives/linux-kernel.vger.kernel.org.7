Return-Path: <linux-kernel+bounces-744615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8EEB10F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D308D3A5B09
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1BA2EB5A1;
	Thu, 24 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="rsc8qM/5"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E392E03EC;
	Thu, 24 Jul 2025 15:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753372271; cv=fail; b=LFCOz3k9sQ6wCwJe99KsK4abCWOUFdqkvdG0v5bqogufyqJEfCxOQDD+jFHkPyl20GlENbfsRtTlGKva2OOXaDdPDLQ4i9IrGRhWqe3eE/qhXBQAlo6RWSSufdyEUxPlJnVwlDWyCeqlRh8G2P0hj1BzskruXCxkHHiyz3YqVLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753372271; c=relaxed/simple;
	bh=LlAaqiDK3Ruzf9gvsf47gKQWvV87auG0mTkSgk47rtk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lPgS26kV+MMUKI/2xzu4zDPRTYt4/AhUGU0A1IrrUiiLlPGbeRWbLFJ8aejHaz1Yhc+PqmtnbM0g1cSJ+BKIfuqRrk1s6jnXORO5+h6rmeskvWnOyUfi/Z3ijHOL4oW2oHCNix9UJa1jU7qt6lsEP3EKY5M2HFd/3LSo2YjDafw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=rsc8qM/5; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k1zj1rjnFho2aMdCxWgyCs5D3NYjQIKn2tJHjMfWUdZYmQRo3fvqHkYP0okn0rlXAZ2ZYEV4mkZoGe/puoeJ39NYKEDonAfctK+0j6ew7UXEbX6gKtDpEZtMdLpilKbNcTWN496SzVPMtcOmS4AVn8uDqsKBAc/40kBsbQ0liDCoGA79oZPl+9x5JGw7pZP0ad5ByU9dQqhZ8V0FnbIjbNvcNiaIEFbXrzPeHHzBP3LxoIDbIYfSxZR3czMmtfdoFdkpX0c45x2+XBhA+BdY7mXMVRcWj/WgAMH36WYy+2yv493eupGB8cLgpYJDgeMtE035bJ15jXhWUmp88Uy9ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il7OsZM3U1ZHkIuSLZ251Fylpkw2yYbooNZG5DqMWvA=;
 b=dFLvT4zbKzAIAFeFqmC49HuaN8FjPO1GUoJWR3WqYujIoj9Mx4MBIxitLgjnmNSm5z+0ArFynqoct5GtmqLC4QRvF+a3RdDPIYT48wWJ47n0aDA/5VhvI1scQGh70TQj9XbRL0RSPnXOZH0HTcaOQtebWZqeAdorPuCZqwfeC2f8nT83BlbRKGX3yK74H3nKN71HLrE2ymk82pLuNKzn+Pjg52zVLLbPBviuM3Ou7GR8OJs8kkb0b9EjV2mGeytCHry7BdW3T0CqIuo3crm7md5hQ01ysTyK+7ALUZjvJNCOx5gh7+DThXSr3yU0sBRFAQnVWQySurY1iSA4e2rAoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il7OsZM3U1ZHkIuSLZ251Fylpkw2yYbooNZG5DqMWvA=;
 b=rsc8qM/5oJJDtpN5Bq/8NLaDqjA48udIqKj7IU2o+B7a5rhD+xIA+N5I3n6HXFEszcAPRWCs7yFSgEkU9bMxSfgpCahbhwzhs6qYgBn43gwTQawD0HFbCf8rTbymJcbpXDtWjrMjhnHpuVZzvcArz2weLvkpTxraijPDRrr42JP1HUuVf6LV0Cs34vg5MguvO6RsrDaw//6427RsE6jaci4+gYfL+tsVFd768kquJ35iDqJCc5RjPEMOpRI4DqGNag2jr2LDUTS5diufMLRsA373Ipwov8K6v52Xh53RdmTjfvtqYvD265n0gVF3Z9qmPpfqYBr4t0w4pwM+vTVezw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com (2603:10a6:102:246::20)
 by AMBPR07MB10732.eurprd07.prod.outlook.com (2603:10a6:20b:6a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 15:51:06 +0000
Received: from PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60]) by PAXPR07MB8771.eurprd07.prod.outlook.com
 ([fe80::e125:c4ef:b872:5c60%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 15:51:06 +0000
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
Subject: [PATCH v4] genirq: add support for warning on long-running IRQ handlers
Date: Thu, 24 Jul 2025 17:50:59 +0200
Message-ID: <20250724155059.2992-1-wladislav.wiebe@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::7) To PAXPR07MB8771.eurprd07.prod.outlook.com
 (2603:10a6:102:246::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR07MB8771:EE_|AMBPR07MB10732:EE_
X-MS-Office365-Filtering-Correlation-Id: 13569f67-88cc-4142-2748-08ddcac9e6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KEXro/cOEKvafrBEWHZ2T7cWaOyq9e4rkstUdWfo1BaaPL6Z27igyc+95dj7?=
 =?us-ascii?Q?/c6I1NuiNMLtZjIMLCqe92/GzbER3N4MNXE/cu9rhQrzPx2b0ioizIn5oH8s?=
 =?us-ascii?Q?glQ6JyDOEOC+RC/nLamy+6uc1qx44+u6L2Wy5ai/5gGS7Xex2kdL3SLFz9qT?=
 =?us-ascii?Q?ZNcckjZY6dJ22GZzRGuocFG+yYDBn2MpQKhrgtYOO+owP5vh69AKRcfuhpjJ?=
 =?us-ascii?Q?WcPLUkKALQLi+6igyhG3qbHs1Ye1N7cpaUCaTZnRHtzz/HKbo7Bt6eTy6J2M?=
 =?us-ascii?Q?lR3h4Lwi+2imMc4dZpC2ZjpWS3UBJwOl9uTyaQDl/HmSQqvFLSxjBa9TsU4n?=
 =?us-ascii?Q?fnjtmk3MgS+EIBPq2RMmM0nllIzpYdn4iLCPwpmmKxf7ld9e6DhanAxIfCNK?=
 =?us-ascii?Q?T74lZyAGOnYlWWVfXE33w4fw5kQ9Wkg4cSqH7cXsO6ZsuvYNXJEesgMNTDDV?=
 =?us-ascii?Q?vRMmEhGhKle0a/Vfqyf6HRga7YPFqpD1OQWb12H4tk/qBT8Wwk9xQ2sNn6/o?=
 =?us-ascii?Q?4be1oTY2QrvxqgIcHqdrt0ZU2j8M5vNeQ90VzUuPrIljvaCQhgRDGtujdkb6?=
 =?us-ascii?Q?0g/3w/JogRj2uCe+dlfYSF6cyMT5MV6D5GgPNXAxok5jVHF5pEMJZzoW50R9?=
 =?us-ascii?Q?8Iusb52hHCBLsYZQN4rUI0QQUksVGTUd66e+u49uJaEhTa6r0HGqMaRg5xkj?=
 =?us-ascii?Q?V6pqtZJWa3fjmq0ecdgSVW7b/xxEwPUWuib8mk9IfEOdT0GPnQOnu35S/NNv?=
 =?us-ascii?Q?YlY/vyNhmFErKfXkPXo98KrY6FgtVL8ToHcX6nbfG7jysIBCQxcFEuOHk0KT?=
 =?us-ascii?Q?kW7YO42SQinm4JhjIhRgwBF0Bhd27OB5F0l04LS9/nIpQUUP/BKGES0dN/yG?=
 =?us-ascii?Q?tOsE1DRIl9rNXKoaQIc1EuMCKPhVHpn5XtEpnXxsrACBNSGN7ANYHsW2faC4?=
 =?us-ascii?Q?JmSaQGpWTKqzJIWoQL0vqQVIc5Toaihql3cZNFCrxvEeVTInfUIyreJTsY6d?=
 =?us-ascii?Q?Jp28bw77K0skZ2EblIGsf44+z4Q/w6lGGxe/wDzqXl7ITmMlxdFQb7bxuE1V?=
 =?us-ascii?Q?6jbXTjHWo1mCWbebpnU2UMHEHPGImj7pcGXRcgFPXTpDLEkCTbJpGlHkVbM8?=
 =?us-ascii?Q?iKQOembFWSZGLZL2ckW+yNdj5yllSooqrnGmfu6KOwFkFuuzvTtVLOHlM5W9?=
 =?us-ascii?Q?+sz8WpOhf0maHGKYVGb2zjQTsfiL4XaPmbHKvHMOC/5GtVl7daxAM65VP3BM?=
 =?us-ascii?Q?S5EDppYRmSmIUNUoCNvwftP7osQFv+PkSMIJRj7n9j8TX4MGVM2Z4gqF6De2?=
 =?us-ascii?Q?TO9k+LeA1jDt/Mr77VR7Vw5AjT4PWpK4ZE2/XNexnd8JAK6UvDZbtnslCMtP?=
 =?us-ascii?Q?Y6Xwu79geI+E1+DjL9+snABBIX9cuiokm1//fqKV3/1P5m/E7KwXQvP+6YVJ?=
 =?us-ascii?Q?3UQGY6sugVk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB8771.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRmY9KlF5mU1FT/OCY0/emVnzLpOvQ913EWVlOQKNp5bdq03Oth0ypgx1ELj?=
 =?us-ascii?Q?jHhX+IIXh5vZDtO12oS+++6zLTKNL76LdZ52qjpeIEQje3tqzM/l4Th8Q6O6?=
 =?us-ascii?Q?zeRR9mkqnSLvVH96eOHgkXQETccC7/eZcL1tLkSqeC6G5y+oAjh6tDQmjjlT?=
 =?us-ascii?Q?I3ft/dJuw9ywNPKbz39LvBF6WlDDQiRmFFu8JhQbO6JTZnykQChRZFnV8oJv?=
 =?us-ascii?Q?YxhdxKzUjIXr5Q0n/B80hpIfBstFaKsmImg5NmbwtRWbsCHaWoiZ+7VkVY14?=
 =?us-ascii?Q?d2eTh92eBV7owv/tAqh+fuhnBVTMYDec1b/JJSxZyaZi52IdzTrbjAY3LfcS?=
 =?us-ascii?Q?bRQm7C9rUA6Cg+S3kt9uSHsjZGjRG7ReUMHSgeE+0iGGQbW26I3Ajt7Dz+lt?=
 =?us-ascii?Q?yITMDDs6V6vH3DHhGb1kxN0AFgyWGpybKGdlvYunsEFPZ2pXenH6sziD4oGA?=
 =?us-ascii?Q?rIVJNAu7vThnd/lPv89A0cH22FqyPCzm1O48ICzisRzn4gYGzB9y9qBdj69H?=
 =?us-ascii?Q?thg2jUop6xlVsAU8zWZiDLq7EO3+yc443zNbF0Mpdjd7bL9yMENvFvCtEIrd?=
 =?us-ascii?Q?HHuUdVlX6bilI4jllWUrcmlJ2aEw3rH8Cv262bGp+NhV9ASAJoGiGQOJFmZ3?=
 =?us-ascii?Q?c6ttJfKbSDsBwQoh4xtKi/ba51U1EnLnYB14WtaN0W9RFyVdTuGcPndRM5KV?=
 =?us-ascii?Q?8EQYrh9h448hDktMZiasTVrZBA5DmIzCNPqvDvBGX7jg7+B2BkXt4+m9ojZc?=
 =?us-ascii?Q?BwZiA6gvSO8Fy8EOL7p4UsABkII0pTeoR7w7i9V8xm/TaXvzstfjZds2qo8K?=
 =?us-ascii?Q?eQhLeYqhh+N637dj6SsjjQGVzT4SQ3d+Eoo1HO3fIHSmWn/hUMYYo+1hzGN8?=
 =?us-ascii?Q?hVwEAGvoXxWn83MqO4uGrVkZJttcz9tWXVpQ6dqRqGfc58XMvRmattf7kjlC?=
 =?us-ascii?Q?KtIiL58I93t5qd0juJCujlQnO5elxMyOOOcq6E+FEUVJH7ooOko8hi+BgbCL?=
 =?us-ascii?Q?Cr750f85wNjFJ2sNBloZZB4sFGisiLHS98muVEJKBM+m2rpDXNtyHNYYxc7z?=
 =?us-ascii?Q?7bVyuIq+oxz1elNB2qto29rVTeh2PqRkk5+9nLfXqDaIDHfx8MDTjjIFUpg1?=
 =?us-ascii?Q?xJs9XKdTFIonDLUCysyuQmzHp8R0O7X2RIRW8jv/9I2cn5jcPWmUewXpSoWI?=
 =?us-ascii?Q?Ph7OJNqIQcoRJUoN2+kiPumdzjqe8RBHm3ZtZiMlOraGb4+we7SadK73OcsA?=
 =?us-ascii?Q?+D8i0QWiUeeheVP3N4OGuTU8ppGIE2jBlGaeJUhFGuRRb8p9xwwsM5WtSUus?=
 =?us-ascii?Q?G2FJhJzVsGv9+7aCcP+A7QaRkiBBuQ12gwQrNM5CbB9RkkVdbXmOgAQQQifi?=
 =?us-ascii?Q?irxOgl2DLzvbNmGomvZAwfNiMoLvVgXBqOBBeDyZEcoUFIzLz1Pv/lKzRFR/?=
 =?us-ascii?Q?lv1QFJYmkdzUDoz75iY68bUw41nee7b3Dep8qEVVRAkJ58CHGr7wTjhnK0e4?=
 =?us-ascii?Q?77VIIDxFuksALuHA9I33ZWd8hbJMBCiBt21t717ZfbE8L0/h/i7CmkDn9aGX?=
 =?us-ascii?Q?pNs6mzTwW8zwYwnUc3/Hkh1JYCM0RhEQMRgLSpMpEXBkOlmoUTmBXSTrQOwW?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13569f67-88cc-4142-2748-08ddcac9e6b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB8771.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 15:51:06.5592
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: emZQ0l1c7e7CWTZc8MbBQc9kVXFCpaXskzyEYBlFQtEppVYMn81qqgCm1zIF4kfna77SzDh6LM5LwAeM1Lf02aQIiEXuvQPfJ8qHvN5hSSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB10732

Introduce a mechanism to detect and warn about prolonged IRQ handlers.
With a new command-line parameter (irqhandler.duration_warn_us=),
users can configure the duration threshold in microseconds when a warning
in such format should be emitted:

"[CPU14] long duration of IRQ[159:bad_irq_handler [long_irq]], took: 1330 us"

The implementation uses local_clock() to measure the execution duration of the
generic IRQ per-CPU event handler.

Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
---
V3 -> V4: convert us to ns in setup path to avoid shift operation in compare path
	  based on V3 review:
	  https://lore.kernel.org/lkml/20250723182836.1177-1-wladislav.wiebe@nokia.com/
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

 .../admin-guide/kernel-parameters.txt         |  5 ++
 kernel/irq/handle.c                           | 49 ++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e4b7015718bb..441943dfd0f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2259,6 +2259,11 @@
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
index 088e5c01075c..4233ead7cbc3 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -141,6 +141,44 @@ void __irq_wake_thread(struct irq_desc *desc, struct irqaction *action)
 	wake_up_process(action->thread);
 }
 
+static DEFINE_STATIC_KEY_FALSE(irqhandler_duration_check_enabled);
+static u64 irqhandler_duration_threshold_ns __ro_after_init;
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
+	irqhandler_duration_threshold_ns = val * 1000;
+	static_branch_enable(&irqhandler_duration_check_enabled);
+
+	return 1;
+}
+__setup("irqhandler.duration_warn_us=", irqhandler_duration_check_setup);
+
+static inline void irqhandler_duration_check(u64 ts_start, unsigned int irq,
+					     const struct irqaction *action)
+{
+	u64 delta_ns = local_clock() - ts_start;
+
+	if (unlikely(delta_ns > irqhandler_duration_threshold_ns)) {
+		pr_warn_ratelimited("[CPU%u] long duration of IRQ[%u:%ps], took: %llu us\n",
+				    smp_processor_id(), irq, action->handler,
+				    delta_ns >> 10);
+	}
+}
+
 irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
 {
 	irqreturn_t retval = IRQ_NONE;
@@ -160,7 +198,16 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc)
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


