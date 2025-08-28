Return-Path: <linux-kernel+bounces-790008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9462B39E34
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE00717CED8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA8231064E;
	Thu, 28 Aug 2025 13:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kwtbArHo"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012019.outbound.protection.outlook.com [52.101.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB18252287
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386551; cv=fail; b=aW0v1/z4lk3a/SQorp84X2aqV7QkGKpvPINp3XWxVuUVswubVrvvlCbVimLyGM4kwkGSj6Xzw49CepvZcnkZxuu4UBWBE8tEn1Xl06Avg1rJ1A1kmOnCAg7NDQqpLU2mI9wLaGhFE1Pqwajdc1pQfDiUXuLcmsGJ9MQrP4G+Uzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386551; c=relaxed/simple;
	bh=IbpXEFMKK/JQBbpZSIM3/i/qMzJGl0PB3ghBKWiUdHg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=C/FRfYk5FzwNsP5Wu6g4aNhB0xw42vRkHrm9udzbXaOAbVvruJ+ut+la0550MvgmLJBLva47JhGwJLu3z+IBDyWUjqtTBja/ChlhKG4GbSX4JAxdVIvX0ajC9CvSHU/lnqLk7HX7kmBjzIv5pBaFi1blFLeKhqEcPtz00aYqiN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kwtbArHo; arc=fail smtp.client-ip=52.101.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB6mzr4tks8Q77uqDMYfzwvEKw3q14IxOmT6wVvk/yo7YV0dcevPdIX+Aht1B9lDYxi2z3rUD0L37UOnFmHtGl/AHRtcZPFL5kRssnYjd55vOl6nfWY9qtSSIpijsXZQfglZ6QPcUqlTYRJ4E+pdHois635I7G1mGF/w+8u4cyTECu+ctdghdPrjTgX5RYFovW42Rmku2DWuPB2vndYtVO27GvhzKxowA/K7PmuJoqErlfc0WL4n/KmvA/9aPWq4hKZoGmJEdEHNtkM+DQ/PxwcLG1s+ArV0KJjX6pG6HFY3QTkoWlfE9sop10L3wE9ZoxlV5w/WdYsfdl8goAswww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3yII28+sljwE6s4bnsY3+sy/GTpswinvAAWw5cgAhQ=;
 b=payi//rga8NpSGv564Ma2gHICV8TnTxWHOK0xUIQzfIkXw0c8HzmkLgyqWFDY7zA+qpOl0Sgg0mpaqd9NzA9ZvAlqYcEhsWGgEwLpVs7lNGvuvFO0SIpyIGJ+oWYfP161nAx/cHGTy0R1ojhgF/N8f3PFXLGw7+vV789kdz+zQp67/XCoctF8Izdj3pYqEq9cpaQuAN2m76QXxX4o3nfzTJnsi9UCZrbz52x7YniRrEoW+wEfziZ5ztSaX4mw6RwenQYbjhyQjrxR+jqZeBJuzvXb7wJp1IHIPJK4HAxCq+ShtX13SAZu2Xuoq+NPxb2Y5xGoT5Ozu0rVqq8+omOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3yII28+sljwE6s4bnsY3+sy/GTpswinvAAWw5cgAhQ=;
 b=kwtbArHoX/OtOUF6w+Mv47zZgOYYX6Zsmo/xi2q5ryeCz4yyRf5TSO2QWMJlIAmAsb9DZjCdUochVpapjTIhScOL4fBersBY62eLxNqtiInnv3hE59jPINjCstN9SXcCS9rLdrb7gNMN59G3MIEue/fJM4xdhgVg57HH/5sReqRw2nZ83/VODwuuiZ3nGpgBQ8tBsACN9GJ+tW0E8FokvdAyInXVQoBNyhe57NU3xKNfckYkK6JCyMTE/lzJaGA3G9HV6TmnZ7gW3lqv1LrJgLOF1DU7Rhq/YLWuxpFK09Nfdfbbj1qv5YetuQNmsuo8X9kLaoE/BSTAfXK5fZQ04w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 PUZPR06MB6221.apcprd06.prod.outlook.com (2603:1096:301:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Thu, 28 Aug
 2025 13:09:04 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 13:09:04 +0000
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
Subject: [PATCH v2] sched/topology: Use kcalloc() in sched_init_numa()
Date: Thu, 28 Aug 2025 21:08:54 +0800
Message-Id: <20250828130854.157165-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0055.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::16) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|PUZPR06MB6221:EE_
X-MS-Office365-Filtering-Correlation-Id: 20440f9a-7396-4304-7045-08dde634107f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OgnP/+U/qnog1hYPQARUEgWdnuSHJEJw8Zxq4NKWpkxfpCSdqTD+2ilcfTsw?=
 =?us-ascii?Q?k59MpNEEcMpObod9vxtqh6r3ShyCgIgnXVxzi+A14OOrp95wwR2m6bATvQUC?=
 =?us-ascii?Q?tfLxVs/P4Zy6sc6oKV9GVu4FoCPJkAGSK8F2jjHTMYVyPqdiLLBrynrzT7PG?=
 =?us-ascii?Q?zfpwmzYPb20FE+BrOaVFNp8P3+iGywm7lpkBn0RDp9KlHx7jr9MhrgGypI/m?=
 =?us-ascii?Q?sZzXJbNgkZHgsgzc7MTtsre2BIYg2RMxP+27Ie6cZoHg03HxGnVKw0r30ZFf?=
 =?us-ascii?Q?AbtJYmM4/h+FDH1fR6z9Fz3ZlLIIaImSLyLGKf09k5P1eYjsBKHjCq4T6bvb?=
 =?us-ascii?Q?M4NzU7YFhzoWG9zUnRLVhdu7xgKheNTBQwoABNHuAHqz4cjJXpYL4/8Rccs2?=
 =?us-ascii?Q?b4uYc9/t1l4xGpaRPpIwTdE2DbRfwlnc3RBzZnvdJmvJZ6YiTPSeggidzKYc?=
 =?us-ascii?Q?LYCkqpavuxf+cpB1S4jFKMecBhZ9RUaU4cQHWxSXIzrkQjYekdEfvCCdD9jy?=
 =?us-ascii?Q?94l8FRnlFIRV1RQ9I6JwSWZjUYmNe72JEtY1g1HRwTcJTFVjoBTQgcwV9RCl?=
 =?us-ascii?Q?v3/avtdF75FrYvrL9wr/kwSNj9426qZkV9KrX8BxLhfymPVfNi0w6bjKGKjw?=
 =?us-ascii?Q?u8iYSblUoCyWtDm1IvlqOPoAWslPZ7BgDMW6tGEpSb/T+cnaJOIRo7eM+4FA?=
 =?us-ascii?Q?0cF+Gas3eh72OjNSd9reQhZYdKe/SOAD7m3T9zMJaFjSMgQ/Z5RzS2fEYsSq?=
 =?us-ascii?Q?qsOpHjCuszbmvG0290mIUmiuw5eqwjNqEm8r7gaiBRTwv5P0GAHfdZODM52N?=
 =?us-ascii?Q?Is+Wgnvv0h0Z3ISv9VDnb5Xop5n2I2ytNVWkJ2eou0BggcVWAtYjgYGJ7lG9?=
 =?us-ascii?Q?RRqcWHmoouBr0SNSIEcFkblYZwkUeManaOdlY2Tvy4Rb58W9mMrGEv3ArI81?=
 =?us-ascii?Q?T0gV6SEzjvErwWDFkgh8fJ/EdeWx9GTAN5LBEj3BX3S8d0RoiPNAmQ/Il4jn?=
 =?us-ascii?Q?OifH2DiS79MxcbenVCotItOZb1/mXtssLhtbvCvaercvXQeIMhjSOJccsFkk?=
 =?us-ascii?Q?CzKTeQIizpUQH1vuL5C170f7uB7giy8KYJ9kl6oU0YoVJKJDipNNyqrdDC7a?=
 =?us-ascii?Q?1XNF7hAAIat7A+yx/DUKhhEYtUuJ+hFgJZ5swMVKhIuI7wKm4eUvDuPe1hJL?=
 =?us-ascii?Q?FhVqMe/v0ZeZEml56XQ1U9TsQwwz/3+ADtZFV1ipJwn6st9XGS+GnIwGZcJP?=
 =?us-ascii?Q?l/ygOhp6EsAaTDl9iAmO7lhN3CFMO2PZ+A9k3ykzZJN41sBz2ykB1bLje8a0?=
 =?us-ascii?Q?OHsmuAVoJ/NV2Y1f/Uj3GsVqut1AjNOxmYtZAjTsfZ0dlb1vuR+N/i6I8GEB?=
 =?us-ascii?Q?aeOswqweo7qzXiKQbAvk00g8PTw9+RplOoYhO4NUpy/Vha0gQmiwSKgTr4z5?=
 =?us-ascii?Q?Fnqm6cI28kvOr/I5buP9V9Ol/RYCgBmDGk8POUiJzpbf2Sk9SyyPjGoOT4B1?=
 =?us-ascii?Q?fg4aJvswjMZM/L4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iHMPwKuZsHlFpD1pYO5La+UCFaOCVUFtfmqNNtWkbKYs2rMfk/rKWCYr5isk?=
 =?us-ascii?Q?WJPay6vCsvDKygqUPSKbpD+ikrCoDJ6ZW3f+HI03U/tqcSunL1O1plMMR7rn?=
 =?us-ascii?Q?N1kh20KJdyp7vTPfwW0mdu10BLocuARpeulj7NQStMiGvAPCprFdigcGFnEj?=
 =?us-ascii?Q?j6rimza45BCNTFq5e7lBKrq4Q3SZEILpcLXYFZm74lqz/A3KA/wklmb1Ybba?=
 =?us-ascii?Q?lHaBn2J/7G+krfLDbYNYutfTNNophFhfK1BeMpNkd6pBapoog7GWP8n6Xmxq?=
 =?us-ascii?Q?2zVdbb648p6zx/qcgXDoNH1dY4beSuCB84bnhof9d6ZQUPJqehmTN7QHjq5u?=
 =?us-ascii?Q?pMoaJP9kyMzPkLR35FOD7zmFtH5wqjOVXUHWdtP6vnGY3AXECsMeNboNw3cf?=
 =?us-ascii?Q?XB4MDK6UX7CG8XjDNBoZFOISuOnXKExz3dFtu4ddIqCuDaC5aiVtnwNArTVv?=
 =?us-ascii?Q?xpSPUQIJ2eiiehBGuHetv43pSpWNaATk9B4GpaB2YUohnmtiU7bBcunBnf5N?=
 =?us-ascii?Q?OVcp0u0teOILa91K4UNKnlQJ+IpsS29xsYLNjCeCVRKIMV1T3hUhjw864pU2?=
 =?us-ascii?Q?Ag50AGrevH7zCakbZFPRQHglTfV8zkKUFbtxzi6cNzY3dkTMZobiWPi2Y4CM?=
 =?us-ascii?Q?fbw9baD4kAZHPdWeN8hPFeIvHIBuyI6+kZLtt1fi+G+M5L9p8TkBOYs/1nGt?=
 =?us-ascii?Q?0aeRQwRC9OtyPcKwuOohoPYHDYbVX2eUeW82gDMNNMy5fJk5JL6wWLdUJ2bE?=
 =?us-ascii?Q?QHxyVvfYqU0idhDhJJde1HvzWASk2CsCLzi3yfVZtX4Zrx0P1n2A1qKt+z/r?=
 =?us-ascii?Q?/kak21T4YAscGKNadHZLcaQO8iyej1JpJLT8BR9IPz25SDSFBaSVNEyV0/Bd?=
 =?us-ascii?Q?I9MF2XDqQUvtP0MrnHEFczwJUQlUkOdgVHlzdwUaDcnYmw/5V8Q+xWNrjc8q?=
 =?us-ascii?Q?0GOATuyQpt7D0TSfHPK5n9AdfLIoE3icdu4r+v6H5Zat1MEP0PsWg9FUeN9B?=
 =?us-ascii?Q?6IgssRdbje0aYkNHXLSYe4S6J7UQ5fEoT4ixucJwtJ62xGEcgZRryVpljVqe?=
 =?us-ascii?Q?Tzp3M17fVRRUfyxW/C4aC6PE71SkNSgJRhXdiqcpuZgQgvsPyozyP5f60104?=
 =?us-ascii?Q?WEVVqxnYipqmiJ4Ex4gXahVCO80IMLdlQywVCaWgBjU6ekjKWbYkCQWJIbG8?=
 =?us-ascii?Q?13vHPSjZIjIW0gScUewHvEh8gTZSGIiniDaA6UeG15fy2zsxoQk7B5VPQgoI?=
 =?us-ascii?Q?x/TX4YF7G4e20Tm+KuDSghbuMfUVdgJnkKEm7e01tjXLT6EhNOAR0n5IQe54?=
 =?us-ascii?Q?SKw+OcUtoJ92Ro/6jkCTtl0je6vv71TEe+5pIl+7mT4r3XG2eb2SHG9QvhpD?=
 =?us-ascii?Q?g6SZHrEf/C7q/8S7QGdVwLbZsq9ngUI4or5osAD7znOAFT34r+NrCoRY0nvR?=
 =?us-ascii?Q?8hJfYASSG8qIo8C8zQt56QhwFVW7v2+1C/L6qg9ND3GGEvfeaxqv0J3bmvZu?=
 =?us-ascii?Q?728KT3qqRukNgQErhn1tx1CyCCtZlV8wb2mxIXq144toUsEWpx05LHxW7NNB?=
 =?us-ascii?Q?6Pw/DDLF22eXWgUWEHjTRMMlnlbxpn0fryLU59nJ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20440f9a-7396-4304-7045-08dde634107f
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 13:09:04.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqn7h2Ru4CX7v684TwN6lFy7mz7kKlLlBdGRnzF/gvprqwqGXDFwMuvFGVo/Gwgu2oVAAUad6ayQw10VDtfpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6221

Replace kzalloc() with kcalloc() in sched_init_numa().  As noted in
the Documentation/process/deprecated.rst, open-coded multiplication
in allocator arguments is discouraged because it can lead to integer
overflow.

Use kcalloc() to gain built-in overflow protection, making memory
allocation safer when calculating allocation size compared to explicit
multiplication. Similarly, use size_add() instead of explicit addition
for 'i + nr_levels + 1' - since the maximum value of nr_levels is 256,
double calls to size_add() are unnecessary.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
v2: Remove redundant size_add() calls, as the maximum value of nr_levels
    is 256, and update the commit message accordingly.
---
 kernel/sched/topology.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..239f7c5b8242 100644
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
+	tl = kcalloc(size_add(i, nr_levels + 1),
+		     sizeof(struct sched_domain_topology_level), GFP_KERNEL);
 	if (!tl)
 		return;
 
-- 
2.34.1


