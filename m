Return-Path: <linux-kernel+bounces-734684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3E4B084C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF4F6581EA3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F256E21576E;
	Thu, 17 Jul 2025 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tHIeouCv"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2118.outbound.protection.outlook.com [40.107.244.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A421507F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752733325; cv=fail; b=KQiWiYoX+ELtjJQZe1/2NrTCIPWkmO8dJEWl7t5re9kdoKOEz6SXyZjNlTwtf8p76GNdtD226nK+yGmZ/qNEC+xrKtDUInZj7f9gM+qWdrzNUxaP8p14XBmTfDLLMINRn4owKD2V2RMbihW6N/ml/d6Hy32QgmnYC7XPttYrgwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752733325; c=relaxed/simple;
	bh=nyepzh4yxo/21jDVL+Ub73ZWLc+Qxyo8E9TxTVu/ws8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jXi8WKwJG2lznkFiDLtyW2iNfjQxwLxfUOh7N50AzseoLve8pCZAc66Dn6aeAq3Avf32h85vWWzYQSDeeDIng7wHsvULVCt0Au9zrZCCMZP3pcZNSIpDBQO+TsValzsZKPa+/mUrzsfLKEkQDKTPX1m1YQ5uHrMHUNEeRR7ZVcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tHIeouCv; arc=fail smtp.client-ip=40.107.244.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cXiQFS+MVMiegUna/KSppzC7LTk3C+EY+yMwlo/bGiytbb0Zh4LwzolaSUUccfzovdbKbanJH4jHQ8OqeNZ1nIy7TNW3sMgPY2vi17V81R+BAsUSnnAt9yuuK1SzOx1ovjMcy2XwB7UU61s0vGKRSE2lgRzaYesDxRygX7L7pGajSn7wOMsQ7MhU+0EYScNsWjniQwRWOcaa3q6yVGrgpcO2ntNQLp12c8c3fF9tCMbHjnsMTqR6+UxWkMB533rAHaOW9WtBCcDqyu6Yl4Ejy0IpeQo1bbE/EbHl7fBz2oeeLyyvHeGjxuAF3y1SEaGRqoympZe9ILrIjIWTpKgz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yx5J3kY5wdlF2swVLKrIu/oidcFcb6sWkPuog/U4SM8=;
 b=uxAysKjHpSY3Ig9MhYvI4AMmq2iP6WL4MXJWltTV671qgpMd1OG1tvjEufoesOBRl0y88SO4Fdk6WYxYL/xf6/LPDV+7Ws/XrGAn1vSfv+gKb7OhPlC9X/xiHI1x4rf/SQxsbfM1uF8onLNBBphI4c3nQkXKFNaCxM1dZBDyCiYL/64E6d247vP1DN2lWZfOHBp4UmBlbAVrqalvV/gYn5tzaToH4GtZ6e7CeZeDf8PSXMKNBQauGE1fBoYQWM85gdteBOGfLVNjAM0cyFkHcCR7wVipj5+4JddLtszyD3hjqlVLiRIhg97ycCMF697pWh4jDnpcnT+kiTwRETS8eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx5J3kY5wdlF2swVLKrIu/oidcFcb6sWkPuog/U4SM8=;
 b=tHIeouCvIA0vEXDPmw7a1a4MC/PaYgyu7byLSHpylpJ1SX3nh7WvzRFYMf0PBR7KWpaJYurdDPhLpxkmKBwdIu5ZNCPxiBn3lXTzYZkUtF4mb/H+cH404+k3UJXNGQNzcWUkMVRoMaXrWgkSvrul+GIOFiFNgf0lP/T1ghYQwso=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB6761.prod.exchangelabs.com (2603:10b6:510:76::23) by
 PH0PR01MB7287.prod.exchangelabs.com (2603:10b6:510:10a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:22:01 +0000
Received: from PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2]) by PH0PR01MB6761.prod.exchangelabs.com
 ([fe80::bf98:19e8:71ee:cf2%7]) with mapi id 15.20.8922.035; Thu, 17 Jul 2025
 06:22:01 +0000
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
Subject: [PATCH v2 3/6] sched/fair: Only count group weight for CPUs doing load balance when looking for src group
Date: Thu, 17 Jul 2025 06:20:33 +0000
Message-Id: <20250717062036.432243-4-adamli@os.amperecomputing.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717062036.432243-1-adamli@os.amperecomputing.com>
References: <20250717062036.432243-1-adamli@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0166.apcprd01.prod.exchangelabs.com
 (2603:1096:990:75::26) To PH0PR01MB6761.prod.exchangelabs.com
 (2603:10b6:510:76::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB6761:EE_|PH0PR01MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: cf710adc-e410-43da-fa3a-08ddc4fa3da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UMLL04HOtQxSD5K+wVLTRUJu3cLexynRnHd+4XYJ6fapS3dnt/u15TOlwOfd?=
 =?us-ascii?Q?59SGLptLpFcIiFzUuwZEFoSNE5d0hjhSEvb8lIx1PwjAiGStXUznABEaqZd5?=
 =?us-ascii?Q?M/lO2Yga4oVu+sJDixrypQ+0Ytn6oCYqYjiR7Nnhy0VElVfGuaKbvMc++r+E?=
 =?us-ascii?Q?0GSC/oBshmJhU7Czbky/JWt+D9ebOGSTeTflN6w0s72QHkocNxQSk6SJspi0?=
 =?us-ascii?Q?voMhkcRIrpL1U7R1SUk+o3RySm6eeY+hdCmbC4/NJH6j0d3C0F21c1svZUvz?=
 =?us-ascii?Q?YJF+pBAMIw9kfHnuGK+81+kXLG7WSzU9sK9pq25xWEP1GXTN7ABzMkAafeL+?=
 =?us-ascii?Q?JufJ8hoNLvMW62w/mYaTh+1zTbgdD84yq7P6RWg3ZScbumTNwnfthYPZzmJL?=
 =?us-ascii?Q?WJoMzRnh4EI4mkuJDQD2oNn4kKSedEvK9by2mYrofKJuVt7fum94kaLvmK+0?=
 =?us-ascii?Q?piu7KIEIJTfcfcuVIVSkn9EvIg6a1BRZ71boG0l4fYCRcANAAEfDRZl0RgJE?=
 =?us-ascii?Q?nJrb3s6byX8JVnXOr1d5EKVp6YbsxFQoq1e8PoznHmRxiSMOf+N6HqjaGcgH?=
 =?us-ascii?Q?Vc92IjkYPv9uYd0dVwB2ZDggu02SlyQKHcx+nd7tCfFVKK/2Z+o1AMBVC0Gn?=
 =?us-ascii?Q?c3uWVu5oQjIFCkIsYyHz5eyJKi6b5zHCOwA74YFQVwSO4Mo657bYljp4FuC7?=
 =?us-ascii?Q?lFtBToq1ZU+lFKH/1yZuk3IyOSABQmnVGP3ZDy+becOg+mOhQU3JQZ33MrxD?=
 =?us-ascii?Q?3g2kt66oktVauyYVe1UzGWUPkdmlUrU1kmqdEhoulKKctxs1iFMVZ4Fzw90j?=
 =?us-ascii?Q?mFm/Hs8BS9+YYBmDLbkzv6zeXxTlzUvSz/i30zj12sy6aogofaN/Zd52pIPl?=
 =?us-ascii?Q?0/vlDqq2PFw4okPXsWdCdCcCJOO2oUoblW7dtmoSHDoXzR4m/F3raZsh/y3S?=
 =?us-ascii?Q?+fu9mqskY8c3dGDWVzffnZFSIGR+KqrIVpVght/4ZBrDcgrSUpAZJOrN47Jw?=
 =?us-ascii?Q?lyZnKKCLX75yDJ/f/yyFTXsPWyKdf5h76swLikbxkXgrsNAaaM00mAyzKi1D?=
 =?us-ascii?Q?eULvNazMHC1jWn3J9picrXNA05euXJwrMQZVFHDidhSnwn9gbZAHXj8oo9Tu?=
 =?us-ascii?Q?JeqM92yxG7BwLWQADTD6vwmOU+gEbbXA4zWupp078nrjKPwVZa3k0m2t3gI/?=
 =?us-ascii?Q?DwZf1rmHC4DTMy4dlrhORU0UTmgfhoUNIYDatyd4gNivlU+QYGLIfJ4XKcLA?=
 =?us-ascii?Q?nSw6Ctyi27q44nAu6CS7i9mRsWDZbuOia3rqgFj+H17oqNCF9iDBXKYPnkqL?=
 =?us-ascii?Q?eRwlrFL768xeVPMCQeL9CAdSJEOMCERho4LAY1Il0d1X3m6+S9JDY/ahG8Gr?=
 =?us-ascii?Q?DoooKDCvlv5vuTsyJDNCvyY1ud/AnRfn+EhXjVtacZwDk37Bvp9HqYMQg5N/?=
 =?us-ascii?Q?hjiUUj4KJPEr0pCEv/N6wDIdX/TZ4hEwUZ5ivekNAId8duT+5Yt6Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB6761.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2yGG9j70PrLDq8Qvd33Z2bmc3wUvekY++pP0hK4wbhPEm3ZX0K5DIN6FhKhO?=
 =?us-ascii?Q?WYoxzVgB5+i7gGbfEJShJksqS+msTL9Kd7EUT1eQRynz9erEtzIWxSuywAdq?=
 =?us-ascii?Q?41z9B9ts8kR+kFAEfW/kaafeGEeuV2oOxNEUyQftB999TxR6i8DU8t+zXnl6?=
 =?us-ascii?Q?Iod0IhNzWXPKvzVX6/Z6R+hYrMN6rB9bKr/sNZDaccBKyz3dnZ5XoTtUd6Qv?=
 =?us-ascii?Q?3guM8uznciYl4s8KZl7aZGhVEov33JXGjoNFffUrWzIqjvrv03ERLqCv+L3i?=
 =?us-ascii?Q?OiMp384pXJdKeRPoPm1GwMqVfy5CC8Awa0v8Mo4Z6wAxbeQNXgKTtuVZFgaX?=
 =?us-ascii?Q?LvIwS9k5pibzzEJouW0b9nBokh6tacJLGh25/Mhy9xsCnLCVE73gfuMS5bPx?=
 =?us-ascii?Q?J+j1CEOawPidQV76vtyituMK4DbD8VQMRvgc6/WeHuf16tRfFfNN4PWNjPiq?=
 =?us-ascii?Q?xw3PdPjqLR8VsOQ2GShGi5arsbD515gj3Ndk4Ilr4Jn8oDk05BRlmnASf+nJ?=
 =?us-ascii?Q?vRlryObLzF9BvnchjbID8r2H2umATv8NULXnRH+POVGrlNX5PZLENDMN7z1j?=
 =?us-ascii?Q?gIp8l48VY5P7aQOGUSHPunXtUQg3ahB5EAvKrehn/N6jK/do8hGCZoDcoWOm?=
 =?us-ascii?Q?hF+1+9auVI68pbCCWuWx9qnfcQ7qxB+aFLRiYyqXvgTZwpg3S/oL4ytU6C3j?=
 =?us-ascii?Q?xB9+1W2yYim4Zucs9iAKLH46uAATZ0NWOVbeI6cqMIVtjyOXQj+s+cHA6OJD?=
 =?us-ascii?Q?4ILaOR6SvwkTgnNweYEM0byEU1HZTDLlyaMD7rEARSf/olblk/mCHgTJoItI?=
 =?us-ascii?Q?HdVMC+hlWG8zaPKgNO/WSG0LgNHn8mHikuaeum+SIUQehKDnKVnM0j1moIlg?=
 =?us-ascii?Q?m7j4M6tR6KP4Lw9PQ/sLXjQFSJVuMqhFT54gMODpqHRS8Gvhkk6ZAk4j2PKn?=
 =?us-ascii?Q?pxYND4Ygrht57BuMT23zo5uh/jDEEFzvCp8rqSdjAfD0TLoFKx41ZQ9W5S6c?=
 =?us-ascii?Q?hm47fMLBxQY0fwPSjntt9yeeZHRCi/zDSb95coTowrd6ttN8/vS8pkghXvl3?=
 =?us-ascii?Q?eS6gGRmYnnCYGCWLXQCQX78SpXvgxJmiTzHSQ0jkAMThXORH4+2+Xy2TOLq1?=
 =?us-ascii?Q?kLAgNSOLKWoVKvX15GzG+jBjRrbw9C18YefgdUJiT6B+vFErx80SKyRg+P2u?=
 =?us-ascii?Q?bT7e0Lnp0cEcIzBKKn/ZORg/otJqeorHKq9PgRW9tpvYaIi24juAJMUfOS81?=
 =?us-ascii?Q?raJrDAdM5D/FEwdlIhKw9xBZaCpYaJZz7pabXBxoi/uaOzUiDrEfDlZzVI3Z?=
 =?us-ascii?Q?t21zY8DyAGmFolvkwm0xbcKbTGrgb70CeXXmL/NwNGramIL7kXaUDXGaS7/5?=
 =?us-ascii?Q?BsO8v93GapE6yPDWoh27WZ1LGxKf5wRG9/DjyGI1gebLs5SBXdY+gi9YkTSm?=
 =?us-ascii?Q?veRVcAJKQ1uF++QIPW8shThwFe6CGCa88Zn2rfsTs9UJChbh8NIDTmVAN+PB?=
 =?us-ascii?Q?GNbKcdCgKlmwWZrKivJLDeoCCRzdU/4TL0S3vhywxQUHe51GLXSXgq8IBIAP?=
 =?us-ascii?Q?n7YLjkd4oSq1fu5qwho9Ik+pvHmPzoOBZR71uQ2qxh4gGbvpWHX/UvWPmC41?=
 =?us-ascii?Q?8A8ObglLesnjl7Qog0Ud698=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf710adc-e410-43da-fa3a-08ddc4fa3da0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB6761.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:22:01.4965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLTpIG8Ydp6k7TONz8q5CaaBdUnHv35ZKLz0K7Rd7A8nG8otvMHYOjHhU0iAnZds4GvsSNUz0N9QVxjFORwQg1POvUDjSq8RuZc+brqywZKnBR7Vk5WBhFeYbEYG9FPN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7287

Load balancing is limitted to a set of CPUs, such as active CPUs.
Group classification may be incorrect if group weight counts inactive CPUs.

Signed-off-by: Adam Li <adamli@os.amperecomputing.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 452e2df961b9..db9ec6a6acdf 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10427,7 +10427,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 
 	sgs->group_capacity = group->sgc->capacity;
 
-	sgs->group_weight = group->group_weight;
+	sgs->group_weight = cpumask_weight_and(sched_group_span(group), env->cpus);
 
 	/* Check if dst CPU is idle and preferred to this group */
 	if (!local_group && env->idle && sgs->sum_h_nr_running &&
-- 
2.34.1


