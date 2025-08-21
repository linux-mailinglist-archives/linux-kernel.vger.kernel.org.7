Return-Path: <linux-kernel+bounces-779993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6129B2FC15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E481CA26F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888CE25524C;
	Thu, 21 Aug 2025 14:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="aGlFqsgF"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013027.outbound.protection.outlook.com [52.101.127.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0349923D7C9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785329; cv=fail; b=JdKawf2NW/0ofC3yCdqtVxPT3jqZn+zYT1AzSqlyb5gpnvLvCiNA41TDi/4+AZvkuD8RgotgXYfenqky7X/GRgTy5kZVWSDuPqkaxmqbtLjFQA8sbevjjahCLzqZugIW1kyB2yFNEqgVhgCJ5KP4ktXEq0kcidIOCOHZBAmkjh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785329; c=relaxed/simple;
	bh=v0iHeDbo+UddWyCynN2C+2QIhb1dG00L8V0SPjcemVE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=K5BNHOhp+sqhDwnpAi1WiOM7Vry/6mNnFSL1uPAP/qPxKgjFoP6oXcaebcklF//Zmeb/SDP8mXGUdYEOj3q1ctyWUROf7Z4VZ+s9zpFZeivTZs1LwHsVqHtixx1Hf+2YCV0j0ixEv13uv0umEJAfcN2T0zF78HuZNWVJZ0WfGo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=aGlFqsgF; arc=fail smtp.client-ip=52.101.127.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx4V55s0aUosmayizArK7lWyAbMjjFj7dhr4DSAE/gi6ziNPj5KcvDf4N1w3snzxmMCRutPNYKfF70i52AJ3ZxbRvPcsSstSVtcdapRqdhVnYy/1s4l48XoBBjXFQKEW/4bmVXxU2Jg8xJ7EKiMTmhpc0pXTEiUsCIH0AaO1NWrSJcaH8n+GqiQpTRa7DeXf3HgG4sdabZ18eVB7htwT9Dj1NRohrbq5pVXEsABwkL1ZDhXRr9ziaTpxsn7Yjb17lOEprt493V/65b9+kkvasR/yqCiFRSYP+4efWpT8Hso0WMVx+g3imvPzZCZ0g2ZIZ3heHAPN5Z5tMmFPLgBqjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6mnNn0cFnfQ7XMp1UhdHlZqFznPYY9rc+dMlsUHEjE=;
 b=spMNN6FYBbNqRvBAz6xxXjrhcdnPVhwhLKSVdkC3DhynQSrhBGt/UQn6C3tQAcFyRwt7tSmF58D7reJXtiw2dA0xmJKD8idbNwZXfKYoGPaWBdMz62fFsL0DWuGuCSeoBW89BOhNRlh/EtpEpQ1Nb3vAdyXSHryEYxMFkIaNCHprgVcd/B3GnXE0FhvSmgEJ00qYZWSDzCRpw6txS8FY+XXROGKxhfBladRUWxDqk98GvLl/iuKe8JqRS8Tdu5Yi49Zalakcn3t3dkdVWmPnoSuotkuOiJj6DMfsBQmw0tb/okLUTmSOJtZAtbHj1tTRXlygC1IQdn6wCut1VoTq3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6mnNn0cFnfQ7XMp1UhdHlZqFznPYY9rc+dMlsUHEjE=;
 b=aGlFqsgFwo8oi/BcdRYr7NF6bcTCGFVg7zQ30BnNXmH6C2NaHGKaWu/IZvHUZHmPrb80c6s7u41jy40mCHkZNBaSOlR02FThozj0VCVe+/fI9owtez6yCMIuB+ZMgqoVt814Ddbm7MQrIQnw1VUXYwgBi+Pbb57HQranetUvq3+tjBirJNf+c/3X+rqfaNH6fcwbX73GBy79OxUxJqDpHMflTsPH2EtuXYvzGjovSM3x7rhBkEE6GSD6WYAgpOeYUCO5CG7GacOmqWtGayFKTVRcLjJVxYISuGhUcmuxldmWF0af9yDRDInqceQ4YifuVLWYK9NxuwQtx9VIdQ14cA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TY0PR06MB5126.apcprd06.prod.outlook.com (2603:1096:400:1b1::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.14; Thu, 21 Aug 2025 14:08:44 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:08:44 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Qianfeng Rong <rongqianfeng@vivo.com>
Subject: [PATCH] sched/topology: Use kcalloc() in sched_init_numa()
Date: Thu, 21 Aug 2025 22:08:32 +0800
Message-Id: <20250821140833.24791-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TY0PR06MB5126:EE_
X-MS-Office365-Filtering-Correlation-Id: 6185babe-1642-4f83-f7b0-08dde0bc3d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0I/bCqA9Q5BAZIfx22p1yIIFO6ZSG8BJQCawCg/6SVd9+0O1gSnzkDVr7t7?=
 =?us-ascii?Q?PX50fZhYgyG1wdj1UcN+xr4km4UyG9VNL8h4kJyrORN4yTtlqppzpiMyNQgp?=
 =?us-ascii?Q?UMtyDvXN3d1guTeJrLU+VtgCQ4n9JK/D3RzOAA6MhR40bFFsQAeyiOCDzP9p?=
 =?us-ascii?Q?cCyGcYibOGPZPasTNhKaOxZQSzJK1glyWKC6xBHdqS254bITCULInr4CXDu0?=
 =?us-ascii?Q?0kkWITtRNXubCuzsKZeOjKxXeEIyyFtL1HKQNM+nt6HfvNwcrhMOjM46KwMn?=
 =?us-ascii?Q?cEIXWe5ZHe6tF49XjvNSpjiJX9KZv5/LEj+KeLgMkZ0wHfiVhvqfivJWBSlJ?=
 =?us-ascii?Q?GVeJSOdoCCSZDzYy+cul6CQ39mc+FuKg2DrPF+oDK/rNYGcLAoCNVVRqMGG7?=
 =?us-ascii?Q?eLV5evLQFRoiMjBAlnmtC9ndvHWG1FsxpSUvXGyKHNe0amJnY8x8UuCn8M+V?=
 =?us-ascii?Q?tlxACr6zlwdjPxciy2PkkINW/3GCDhkWqIGimp+giRTyX3+B+mYA27Hog6iD?=
 =?us-ascii?Q?ciq4e9KbG2795pCcJAGB6mpD7533yU8iN291ZWUe4tTZHO9v61xxdqAZzBYk?=
 =?us-ascii?Q?jBLmYrMJ/kceSUAo4545h6v3RC1Q9uJBkpkhc3GQhY8AG8QXAo/OFsLmrK9O?=
 =?us-ascii?Q?BHcnGDYPL4VJFUI15EuBPWiVajs6fArYkuFcYewZrDTnE37XaoirsliiUltj?=
 =?us-ascii?Q?9d0805BfJRhdYBLhunJCiVewblZIxx3KAniOUExP9nxEDU50IcyGcMvyAtsB?=
 =?us-ascii?Q?XSQioLkMJP1R9Ab1OmXPo28h0eOwecGdlDXp9g7ExN+CaP+dffhrNpKddW7R?=
 =?us-ascii?Q?ZlSfei0TyZXSC1PKXaxMwOQ+IPY7gyCeHZYK/ok3MnXoep772gIhg0HNUuU0?=
 =?us-ascii?Q?Nmk7/RqvnWMWKsxX3DCXQQ/0Jixytf5bDZyQk7TczbTt6vqoR7hOW12Vo1bO?=
 =?us-ascii?Q?IsooM/qrxIp3yrWcIqtuGYemYmq5PCe5C0QRT87MRjHaMj3zLdGDg5ywwXUO?=
 =?us-ascii?Q?+XDeZ78y54K4UbzE5rF2uZIkMLOiiGOL4tuOUbubvM2W6nx/Gjv/AzwvC1DW?=
 =?us-ascii?Q?5yuxGnDJSktFCFCwtL0MoiyfyY39y3ESL5ffCEgCd47XwxHervqYIOZjZ0En?=
 =?us-ascii?Q?sfSkGyKipSNrrYNTvw9Z1dtTvebgexfgfaY1Kl2+4c7Bwcda+YHukwSJhFLJ?=
 =?us-ascii?Q?FMqFgSXbI5CHyEUzXYJxtgOULfetQjEFxX98eTJbw3xxsxYHdftuk/n1Fh3U?=
 =?us-ascii?Q?ZB8MUurCY98WMq6X4rvFjVy9bPVZPoJbLt2db0zoxqsbTlP3rVr0wy5lsnD2?=
 =?us-ascii?Q?14wN5eizsUEziaR9Xs7SJ086G6tE24uN9ec6WguHRAgFuE5pZxr2QbYO91gv?=
 =?us-ascii?Q?WvkqB3LLKlznVOjRJcCTX21JdszP6AJ8U+gvI5mZqccUtVJdQ1WKjBmXm8/w?=
 =?us-ascii?Q?FLnauhnfkE+5FqRfjH6P7VBMxG3scopbWHde2shUfHU1zK8Ov5w/5gKbiWRM?=
 =?us-ascii?Q?v5jmrXIjTHFmpOU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFiYF18qOBNkL6+Sanz9aJBJ8hydCiZQ34k8hUAcKUAsn6nXeZnCGA/ZfFaN?=
 =?us-ascii?Q?xX1Ubt2pljlqbxt0wr7k0cEfx16KfWJOn4CW8Q3sVKh1IqJp/WGDTr9/8z1d?=
 =?us-ascii?Q?D6S7EcVUKjNll00DHW8CBnYmwQXrKpN1eEupzBpZe5xwUFQsakC0mNwmDwPv?=
 =?us-ascii?Q?P1ybIiZPILBo52W8bjuemG0yrD411wLV747/0oKxkgmVF4LMYfqk+4DCObuA?=
 =?us-ascii?Q?kRuDsHg9a/lQKDMKujySgvmJrIg4T/GnIwKBUpmK8vo04F/nDhdsmY4mqwvK?=
 =?us-ascii?Q?acAomlxOY/YEbETKlfDXjsnWiutuRoq07OTyaUFnxQU78vMDpoFdxNj3ZNPu?=
 =?us-ascii?Q?85nlpLbR5E2yos5h8rZcA3YW77FaVpV1AeRX9V5Z9Z9v/MX5+L5KtBGeURdI?=
 =?us-ascii?Q?x/xO4ii+jG4lJQwgid0GwE1yC6m/N5uv6+0jXNpJzlK1k1Q9Mzmu+hsy03as?=
 =?us-ascii?Q?YgLnM1/KqaLuwTigjDdBIKqn15BZ8Sh22z6ADxdoD8YICY1GiuT2bEJmbwhJ?=
 =?us-ascii?Q?TLM8SQ3MfltNHTkKWFhZTTvlDXCVfiT4usrQPzW61N5hy131OKGmZWIyiU+s?=
 =?us-ascii?Q?D9VPxE3C8VotbDV0JwBczJlrIXuwJSMAaQcRVHuMHQMy+yAuj0lq4NGDLllK?=
 =?us-ascii?Q?QXaSwy040GhRijkWpgZcqpaCx3kQ9bZqtJB8SQZ5bv4rVdgqhfpVLI3X7Wtv?=
 =?us-ascii?Q?PqwLcG5WwiX3XsMFFyLfH/9DtjsFz+QnN8XxWm5fPOnh5SDCmAxw8NP2cauy?=
 =?us-ascii?Q?TKWBILZ/ooJ8Pl5ewN+c7uUAnoyvc14RwkeP2weK7S7KrEhRL5R4fSWGK7Ny?=
 =?us-ascii?Q?7JMK3pjCg2sEpjOYEWhSA6Y9pYBPY+mkMvn6KtzAH7niVt29YVcveZaVixvK?=
 =?us-ascii?Q?Ao+pbDPu7aCFiwEjmTbmA+RdHqtK5UKbYnR2VHiIuRTdzVsZLfLtgZqyijLl?=
 =?us-ascii?Q?RsXp8qq0cpnVwEemOKXUhVr7tw2O0Tol4scS3GhBP6aZ9LlnTOYLmsfl64mP?=
 =?us-ascii?Q?mKsrkiYqFUAwjZH4nf7TLP8+FyKBuVlvpMhQz2FcKh+3yQE3tMnWPIFbtmuT?=
 =?us-ascii?Q?u6FLZmeyF3dW/Gz0ovD41RXvE80qztuoslsPT8vdd2jZVyquqmKlf12Ca4Tx?=
 =?us-ascii?Q?0hRmmy5DelcSbB/y8kpZnHbnjMiuC+jOOrZfzGlDefPVlCaskEBVRaxxsHYX?=
 =?us-ascii?Q?lT2+lsWbbexjPsMa9sIx0aHiseoV9Dwle4UzO12tUGE1P2BAiYiYPPISszf4?=
 =?us-ascii?Q?mI6dkyclbGP2Kwy3tkBpqNR2I9QwdvO1UULNjoGHuZXA/Z7n6Qw8/Pt/ic2M?=
 =?us-ascii?Q?TOe6/5zpeTbrD+Gyys8s+GqhHpAUHuXEYAhAC/+IWPM92AmgcWt3zLItYSoM?=
 =?us-ascii?Q?6rtCDzigiJFxWr3lY8JoS9h8Fu+9y/myl+CMMdWJCw+pYhwD4iDtSbVK4MZt?=
 =?us-ascii?Q?HzVe7eRjh5QhRdbJrXwvzDtQ3pKQSDjfwxVaaCMpzBQ3nlzTtJfUsiqWfQTc?=
 =?us-ascii?Q?USizWJmQE7FkuUI0cy5fh4ehxFQkzKEXM78x5ZmdGjNNu2GtGuTekNm+xTH+?=
 =?us-ascii?Q?vgntpqP4SZAf1C8pf/wtgmn5DmQbaZTvnae5bDBE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6185babe-1642-4f83-f7b0-08dde0bc3d72
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:08:44.7910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hFUNIy9//rLAw0+L3rMvl19Ig09ZZFoVbHhT75fNE4QrFROB0qU+Dx9/51/cPHwLxhVcBRbw6AiU6oa7sNCT/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5126

Replace kzalloc() with kcalloc() in sched_init_numa().  As noted in
the kernel documentation [1], open-coded multiplication in allocator
arguments is discouraged because it can lead to integer overflow.

Use kcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication. Similarly, use size_add() instead of explicit addition
for 'i + nr_levels + 1'.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 kernel/sched/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..0500146f9c1f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1956,7 +1956,7 @@ void sched_init_numa(int offline_node)
 	 */
 	sched_domains_numa_levels = 0;
 
-	masks = kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
+	masks = kcalloc(nr_levels, sizeof(void *), GFP_KERNEL);
 	if (!masks)
 		return;
 
@@ -1965,7 +1965,7 @@ void sched_init_numa(int offline_node)
 	 * CPUs of nodes that are that many hops away from us.
 	 */
 	for (i = 0; i < nr_levels; i++) {
-		masks[i] = kzalloc(nr_node_ids * sizeof(void *), GFP_KERNEL);
+		masks[i] = kcalloc(nr_node_ids, sizeof(void *), GFP_KERNEL);
 		if (!masks[i])
 			return;
 
@@ -1994,8 +1994,8 @@ void sched_init_numa(int offline_node)
 	/* Compute default topology size */
 	for (i = 0; sched_domain_topology[i].mask; i++);
 
-	tl = kzalloc((i + nr_levels + 1) *
-			sizeof(struct sched_domain_topology_level), GFP_KERNEL);
+	tl = kcalloc(size_add(size_add(i, nr_levels), 1),
+		     sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
 
-- 
2.34.1


