Return-Path: <linux-kernel+bounces-755842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1ABB1AC6D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 04:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 887EC4E10E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 02:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B181175A5;
	Tue,  5 Aug 2025 02:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="diSQ8lqV"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012002.outbound.protection.outlook.com [52.101.126.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F8A927
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 02:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361049; cv=fail; b=akoj4ISCeddL+T58LM5L3owP7FloT6iiWc0SkeLEIFo+vZhOXZVb9eCsw1XOEGmRKOBYMDUE+bmk5vgl4EpdOPTyXJXz85mH8kj82+w569JFHEBjToWzSKwiEWKqhsyhhniqE7TMFu4Jpp+NdzRYkUONoFcA6XGrfK73EXGJVLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361049; c=relaxed/simple;
	bh=URXgkqeQRcofI69Iyy9cc8yoWJPfgqHdzSlt1e3YVBo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=poqnr5Y7JQecGudIP5MmyaDzJqXw8YTGsEvEQWnHIbneLoBpqt8Y172COAVIUseeV6RHB1pkJ5Aql9K76QcHOKbd0rVhTu5xRmiq8Wb77vJlJj81BH9k4Ibl9NzK/HEAYNYi0npRgoeuIcsaYrPk/uKPzbmk+eR6dijVbkLWyEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=diSQ8lqV; arc=fail smtp.client-ip=52.101.126.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Omx7BBi52qfaXkrZKyx9IEmpBQadusUZkbDVwMm66UcW89cBN9i0yoFYygHGoAYQJEYBpEB1bFZ9mx4NNFbtSMXtnn9Xxo0sp+5TfQHwXoYzdo5p3Xikx4oP283ALvml/g6FpSGEKeRu61+qSRGVBFwAADHHvuESekUepKkJpPKWZxunzYqaYDVR0dWkhfUyMhuzuK9deApkRV08hOfHtMoNao8NJi9gJcFFEqDqkb6irxJ6huCnC16/qN4HPXEHN1e9GR3+XIEl1pfydxN7v11XBfjTSripySTAQWtlswRmYaAP1Kgjm1dlL+1+G2X4Gi9T62LyAoIY9GlWAccgyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mf/T/NBSG41pfRr4Eg4r63QBKubjVEuySP/ds8RZzVA=;
 b=UrtErKoBLgb42sxPY7i6AMkCVO4NlWPit+Ptgf7RkEDEakThEzew8SDV198way41XS/RNlXuXcilRXtiq2QnQsmt98FBGoKgssrr9hWz8KsR7+5HIiz1u2PRXQ5nE52gKxmBebx/a3bS9EaX9tqk8dCaUlFPDkGomRGWnYHGsFUdgSDZYScWzl/pl07r8hQchnKoRS2wcp1ROC6jFsY1JFUry/hsIN7VqrXTdshM0G/Zq4FbzsvBOvbxCeGPV19aog+WkTVNb+cGzz16lbgBXXpQK0nQ/Z0giD59c0Eri0Q858Fpc0xFC8DpbjqixME9YO94IbEtAWGJRL6E+niDbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mf/T/NBSG41pfRr4Eg4r63QBKubjVEuySP/ds8RZzVA=;
 b=diSQ8lqVwkLfbQe6HcoNhyZtoYw79dgFOR51sUVreTL49EFLMuX78BoSyH9O1+kiJfdrF6KEXI9FaFN8WVBIszvOcHYfYClvd4AZQ0RB7PoXSDv5NkbSzbxwspYu6D/edssSUrscJtROMvikmfPVshZqcYh9eqX7AQdmIh119KpUOIr8GCMuD/j5jbgDOho3YZVSr8bNDhlTkEEMyvK7mFklGMH3O6xZT4QU4WpTbDoxor3NHUDhw5vvbW268s1JYUQ94o2qUamyLXNL6rgahqYil5gQSxGqdUJL+R8f71SE4JtQIxzxCTsyc01uerPar+/IBhIS6Vc8gdZt3rRaWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SEYPR06MB6588.apcprd06.prod.outlook.com (2603:1096:101:177::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 02:30:42 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%4]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 02:30:42 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: willy@infradead.org,
	Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] ref_tracker: Remove redundant __GFP_NOWARN
Date: Tue,  5 Aug 2025 10:30:31 +0800
Message-Id: <20250805023031.331718-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR03CA0024.apcprd03.prod.outlook.com
 (2603:1096:404:14::36) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SEYPR06MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b1cdbec-73a7-48ee-31c9-08ddd3c812cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZCRfOHUHDQOC4dlnAVLwQqpQ8kESk5eZ3LgpcNP0VF5bHTfy+fL2nRtoEJUb?=
 =?us-ascii?Q?/PYPMdMb4/tKr7NRTlmMYglSUAIAD7YX6fu24cCInQI5do6ZqQczMX98w1Yo?=
 =?us-ascii?Q?5FxU/tPZC8mEtCSAw1RelWV+9YjuEDyBnaEbc1ujx8j/gFl62XSbo66S4FCB?=
 =?us-ascii?Q?WQMiVxoOwvavDE/0W7iWOblk/z3bkLxiioXGwXWbPZ2+du4l3W3BygIqwEHA?=
 =?us-ascii?Q?aS7Ih8qBrySWNsk7qCVLlx1OczRGVgz9JAHUGNyKBvtNgvAHOWeCMmR6KzIA?=
 =?us-ascii?Q?QrkpZ9W7haL0m8+49Zf2jpGfuHNygtCjxchvQxY+JDKxXMHjcIhrgX9koz6q?=
 =?us-ascii?Q?YM9cNigISXPlqUHQnFwQi7aZcvUaXeTf1Un5hAonk7BINWDMZg8XMF7wOCGD?=
 =?us-ascii?Q?fvWuT1KESweKUti2UIxOr48Lxz5h5fAtxkzjO6Rqvq4fTv2L5hnLEjSlNcjf?=
 =?us-ascii?Q?ZDFSw4YLoQQ5aDoc6Lpa86tgSnULAdfKQ+qnZ3FV6V9TY2SAxphEmbzoXqCF?=
 =?us-ascii?Q?miIQceKJy6cWyVq7E9Mo0D9K+NVeheFHAdr4FtdsU+0MZ21NbeazCxW5PbbD?=
 =?us-ascii?Q?2K5jLfrTxIr9Tl52s7UbOGmT9MPXwyuRmAVNQpu+GR5wVXmEI12hzsUJw2Fu?=
 =?us-ascii?Q?TUcPRPrLae9m67Blx98a1wpPJWaBOKm+uEkLs/pvOBuhKfwk8kbXKfqiZEE8?=
 =?us-ascii?Q?ZTTnSMEGf2fZnUI1hjv69UBsE5E/5edd4+y2w5DX6N4KDyCJJeTrG8MCPpQF?=
 =?us-ascii?Q?cdGOiBfYGQRYeOROitPPy19nFDbmKfE8DdkxgrVQ625rKohCKn06l4WUofrR?=
 =?us-ascii?Q?qLZ1DE2yvMxIcdR8CCqGeQiAZXXaWkRZE7gzzNWz7aYf46cPUF83XxM/SPcq?=
 =?us-ascii?Q?XzWZqBPJmvbL/VeuRneVUglncAzezr/ozh8V6BMnL700LbluNsr8A+1skFuI?=
 =?us-ascii?Q?IYrb/S4WtAFOgnONrQUpiN3L6zC0Z9be0w+QiEPKBbJQsHFquPLOQ3RlLhMW?=
 =?us-ascii?Q?4giIImkZdfiMHfXYO5k9nqywQFPlaMIE0hrIyY2Nky/koux9rSY1uT9HWRP9?=
 =?us-ascii?Q?BluxNrFsQsqZ5ZdIm/CDFPQS/kyiFfukRAQ+eTrRMPsyxLI2kzKnWFojUOfS?=
 =?us-ascii?Q?T5evarRBpgv/Qk0Acl4jsveTpNSDv19VTPmYLVunAjMLXZhe4liiZMWZAwNS?=
 =?us-ascii?Q?3+08I+56/ciFz5Rua62U6ZfZ30eV1ofqeoLvkyhAumwwmNr3Dgluh9glCgoc?=
 =?us-ascii?Q?M6SGoyUdqN9HzRh8hLKVh5Yd0xSthIRNfdGD6Fm5icRXg8pXLP9LcsBUKk++?=
 =?us-ascii?Q?c4jNlzT2rZlpQKKlgop1HasLcuFcZRceuhIk+XJeY+fTQijHx8uAqeKlDKET?=
 =?us-ascii?Q?sPeHxpH+3V7XuiXk9TWwMtGO8EvHklaz+Q/18ARCSFEqxQtNdJobODOLZNYc?=
 =?us-ascii?Q?42zbaP+CZQJWxnv/DtxxrsxttHqgNMWnFbd9Ntb7IHRIRct4mgGTcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SISvHaRoWnyjiVY6PaonNixf6Z33Toxr1VwZlwGXh0n3IwHW74cxWcK0Cmsf?=
 =?us-ascii?Q?dGaS8KwS1AJV27LJ0uebjZJpC9ljwii4lqyV4wYbVhtnI2q1+D0UwKWMhFso?=
 =?us-ascii?Q?lw0rqHoRSYDHv/+3CaVfg0Nhj9ZAel24QI1a1iXY2L/whlVIFYVQK/XRLePT?=
 =?us-ascii?Q?l5+rKxReW1XfSk+Vw4pfxzhq2+axmlkAhz6DHiVVtCQLchvgY82LeUtXf+4y?=
 =?us-ascii?Q?lep/vc2IpK8ZBUvgaAYZmCDlouPL58h4jVMMkgDCe5gKr/JqJ8z5pTqPr26j?=
 =?us-ascii?Q?HIntMnL7SmpuVkXy4F0NT2nNENlxON1dM1CIC4TbDcvhO/2J+0n/AdjEr21v?=
 =?us-ascii?Q?IFhuOxSvvm8mOUnQ+jubxK+3VnJHszWNU3jPoiLevsE8eGz6TteB83MYcKRT?=
 =?us-ascii?Q?WIrwGbMg9EW5gssiAY5bRKEFjBqQDbzKMndNArXkBuoafW2KTZ6DArj1j1k4?=
 =?us-ascii?Q?7fhx95ce07b0ssnbddcXzFUEU9xz/S82wO2/IHGZ99KvPCD+vPvumzWEIW1h?=
 =?us-ascii?Q?aI5JLGGAUqZg78x6AhjZh6BCN0w93nKgbFJzpWgoquidfH94jZVe1Zgb8y7v?=
 =?us-ascii?Q?fvTFXXPRhYne88YBJu6fWQsiCDsHoW3hA2B5l63AdNPhe0NrEzbw8fNsAqjY?=
 =?us-ascii?Q?19+igO9P0IZu8Cpx9BYxsF98lh3Hq+9IoGS4dX9a+yQx3QwAGjIWzOnaIBlq?=
 =?us-ascii?Q?v3LCjJtV6o8U+f6DnGS/OmnbfDZ9coNqd4aKr2lPIpjPI/CCqB9EYkDmrVvl?=
 =?us-ascii?Q?ARBO5TZTGvdyPnUNB3VPEdwslAGhVCSGbU6sWU/GKda518CfjYndLLOR/xBm?=
 =?us-ascii?Q?T1MouQ8FqrKk68x1XTiizwpaRicJnRq/yNyakXDfFTDht1Hc6H7/qVF9YAzJ?=
 =?us-ascii?Q?M0Ep4aIvqAiyU0trewH6YQPduf3GFTg1HXmgI1eqPSctPik+Ak0e7K2RULEG?=
 =?us-ascii?Q?SK8aHBlB5UWAxSswAgy7qmd8RoTSxexSEvLFl2OkputLK226SizUtAYhLxfG?=
 =?us-ascii?Q?MpgT/6143gtP4znLFf8YFkGfxKGbi/dXsAWWBP3j0acg+miAzaAH6Sbcqed6?=
 =?us-ascii?Q?f3Yv/QYbi2Xaex2K6HM1bMMqwmLoW0yBpTM/r4qx6Dc3SRzfJaPaRVj2tn7g?=
 =?us-ascii?Q?3P6ZgTH8EYN8mpn2qoe24HXuBI0F+SGFpIL17AxorXFjoBoIuWYeDsc0CkNW?=
 =?us-ascii?Q?7cs5h8rKS/csJXZWQa9tESp3xFf5pbsYoaFruAcFwFo6IZjkAyHc8FxSZKEr?=
 =?us-ascii?Q?D5aFYpvMsrVOVXpD3qTPxPeMNBH4ii8wIbl45HZj2cIr+TdN+jO9n90/7/ZS?=
 =?us-ascii?Q?jlkRLqkkUZI3tee0+yv1FvRzYm9g3/csZugTSV4fFWmGP71xcyBUIoj3GRW8?=
 =?us-ascii?Q?hNJpFngSPbdvPY8GZQ8leV37VtTi204J1+9mTmicq8P2Kpvh2ILaY70V5Nce?=
 =?us-ascii?Q?wiJE787FH2f8+gr2Vp/3zxZ6AvKecjW4TiuSm7yQFLIV/1TnNNYscb/Y0vtg?=
 =?us-ascii?Q?VTUsQcnoQVrBegubZtYIeneRlXgH2fHSNJpiOrpDoleTmXWkqflv2QfJl8/7?=
 =?us-ascii?Q?XdF4unPLOCAeWOgTxvZ2Hug4FDZ4RBdlZADo7ZJP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b1cdbec-73a7-48ee-31c9-08ddd3c812cb
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 02:30:42.0892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpgarX/I7t0NZ+MMqyOY0k7+BMAv9Vue0FtWRwqKZhOMpeyfWV2d4exz1Cei+1OHzT7JE4lsMmFQm5igbOnlCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6588

Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
made GFP_NOWAIT implicitly include __GFP_NOWARN.

Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
(e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
up these redundant flags across subsystems.

No functional changes.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 lib/ref_tracker.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index a9e6ffcff04b..5bf4e4698bdd 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -75,7 +75,7 @@ ref_tracker_get_stats(struct ref_tracker_dir *dir, unsigned int limit)
 	struct ref_tracker *tracker;
 
 	stats = kmalloc(struct_size(stats, stacks, limit),
-			GFP_NOWAIT | __GFP_NOWARN);
+			GFP_NOWAIT);
 	if (!stats)
 		return ERR_PTR(-ENOMEM);
 	stats->total = 0;
@@ -159,7 +159,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		return;
 	}
 
-	sbuf = kmalloc(STACK_BUF_SIZE, GFP_NOWAIT | __GFP_NOWARN);
+	sbuf = kmalloc(STACK_BUF_SIZE, GFP_NOWAIT);
 
 	for (i = 0, skipped = stats->total; i < stats->count; ++i) {
 		stack = stats->stacks[i].stack_handle;
@@ -306,7 +306,7 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 	}
 	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 1);
 	stack_handle = stack_depot_save(entries, nr_entries,
-					GFP_NOWAIT | __GFP_NOWARN);
+					GFP_NOWAIT);
 
 	spin_lock_irqsave(&dir->lock, flags);
 	if (tracker->dead) {
-- 
2.34.1


