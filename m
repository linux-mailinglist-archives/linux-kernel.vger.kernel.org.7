Return-Path: <linux-kernel+bounces-761227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87EAB1F5E7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53BE3BECE8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704232C3253;
	Sat,  9 Aug 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K+3Mfuox"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B162C17A8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765325; cv=fail; b=dyQaUypeajQPb4+C50A5/L2t91kCojJRvk+NQ4ej84BwQOGaE5ICynpGYRAV6fK7ZtUqjjn1Mze8YQy/zR2OioyTTbUZ/jFNxQod3c8dicLw2f0mvEDn6muHPNrkJPSHWHvuy9afqSDl7CBSqD6mSMK1ZrhGExL/ImU4Uv/UqB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765325; c=relaxed/simple;
	bh=ZKsZ6jmuUZI5/k98cjcQA93j0aYGZevewdLUvMCP7q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFIGbq4owJmJeObCaFgUnDdvmGlTo9KOl6RcZF4sdlXEMoOVG9/cOxFxSEhCBNkLwR98tj3KD5ks5OrC8TNX5IzrroQ/9ObjLgHoznyDyRIBdszGs4nZ/WDi+Nz6lsM39ZnJO88JPaIOp091zu7EyowgPPHnWAY325pum8bYzac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K+3Mfuox; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWnGQjc9536D6Q13O36NPWtDZemruDzxleeVS2ZC4wi+NZj4TyWS67TQZDUNfterWQ7CmePk9MGqM54ULtDtpBnATt6Lmo3BPQjVAK3WeCErgqbQ5pzZypH97JYEHpDs5RYjJple3om7QLtjns8b6urLbTKjHE5UlwYiWMwF6qw3cxammyXgndeKjVXj2+9LGooQv37i8W7I5Tto54rop1fH7nLge28bEGNazuT39gU5Cbtq7vS74EVIrToW00iS9O0MfxxLRz2B/+WgMivkayVPhu/ZqiYKi4qVTWArItjNok0zWF5Lx7E9jrb/qYaPxxthbhVRdYdmuAFZ8DzY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0mTrP5X5JYE8VGEpoAv9DzDkmGcHOehaaJ8duhxF/U=;
 b=sosV3DBp/uNLelSm1gQ+EojE0Pi2usC5niaWiiJSWBMidwtmDIOYY3cEv9cvnXOvyS4gJDuFFmvehU9m1Wa/2U7czAE16wLpSANOvo8etcMV6woqCIK4bRzYOKT1qAHNwuhFlxaOkfHdjcsVR1hl/32Kn8OGJtuRtiH8csS/G8GLutFkFRbqjQn85+Wg51BbHhMJKGyTnl4r322c1b3Qpvbv5YPixwub7UPTly34gAkWrbJS4lsiHKjb0jCjgBHx9GlKiGnAj6c00ESKLpQhjelOc4xHXDBaWFxf27MG/gGWiMAqjtK+q1H2tU4xEC3EKDF9vz5ZKClebTX+rUv1TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0mTrP5X5JYE8VGEpoAv9DzDkmGcHOehaaJ8duhxF/U=;
 b=K+3Mfuoxvdj5IE1QOUJCKBDuKm8zKBZP5fgK5ZsNYn/+TAzqH/XOA+OxFUt3IRi5l0mFEw8RQSNS5XYbQEbSvTeM73SxhT3o43L+8BjRSDbdAUz6NO5mqCIfRiNsE/fk4x1yfxcsKN4J7QIF+LKWjan5zzPXIcCf/EqkULxL4Cer9gPpGpNYUlpdU5PZGWq4QpsGxdsGeAm4DtIiW82NFBBJ/JWa+2Mwbg8r4O7AsPxylvnkUlObfzac/KohKw87yDIbTcvTZkapW42n9xnvkaOAfrEIXnCnvJSocSMdDWfL/DKdSGZGjz2I+j1RMLQjVC50fYoerGuPIw8Dkd4+8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:41 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:41 +0000
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH -rebased 10/15] sched/deadline: Account ext server bandwidth
Date: Sat,  9 Aug 2025 14:47:55 -0400
Message-Id: <20250809184800.129831-11-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:208:236::33) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: f894b1f7-f0a9-4872-e4e5-08ddd7755c55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPzk8mTWhRhA+ULoIRRbg9JerCS6MHIcOhnIRHJHazFOmlKSTYc/e/VJELn3?=
 =?us-ascii?Q?lfa7YCYU2pgezcPKYi+I/ipnKar/RE7S0IXiUhwH8ZED3rxc5I/k+nVmNzmC?=
 =?us-ascii?Q?t4pkryJB58acGZMyQ0Bae6L6eQN/pKeXAjmVGwd7tn2HipW7i3C65VnyK4zY?=
 =?us-ascii?Q?EDhCmKuOvHYOS5thHhbykhCqpQYiv4QV8pWGqCg6UL1Hbpq8yiVUeFDyQUF/?=
 =?us-ascii?Q?6D7jYBDKiKe4zxja6W4/desuvOd3LxVsfoITJi8mAb+n9lAaF3I0D4vu/ovq?=
 =?us-ascii?Q?5cAHQ0kLMuw0wTXhgjpYdlIA5j5fg2y4lgejOlHd2lAVLZfH6mC83E5eAVDV?=
 =?us-ascii?Q?PYRutJ9e9J5agR3CUwhVNgHWv0FV18ha7Vsh6xa703YRKpFO5N6TP0bUT0Ny?=
 =?us-ascii?Q?5v66L7KI/GND+73ZxVoIS+shhqKPvRkc3Xto64UkTvRH1IRxvHo24w8reD2U?=
 =?us-ascii?Q?eo6Ty4NEvzX7iJozy2gnltdLiRxGdiOYzUhUB12wJxJPzNW5ngcvi96AZR5E?=
 =?us-ascii?Q?FXIxb7wuwnc8z04Ie8HJRvXjcfcO3B23KrO6F04BKSFp6BCgXq9+ZqzNC1rj?=
 =?us-ascii?Q?eOp0rdO59oXwIddN5UbvYjH9WrFnfcdN7qKkoLyYCNFcnCxj7I7/phtXqCQR?=
 =?us-ascii?Q?/Zc+FF7AOMRWRg4fsv2yirx3K2LHIbcPH378YJ8CY0HyUqDaR8heKaqtDozt?=
 =?us-ascii?Q?e50jlo+hCO8NZFWWkVXvM/0l7BygGEf/gIQy/JrK5JFtTG7E8aSoq5PqFNQO?=
 =?us-ascii?Q?dKiYeUTVAjg6+v88KREXbbHQt3MbBNjA5a8urvP4rTEZj6pvNn8bztRYgIPT?=
 =?us-ascii?Q?kJEQJV+UnxzFTICYnog+Wpx3KSf/iHbMKSpI94CZ5yjBaUVlvZSPxTrnZdDC?=
 =?us-ascii?Q?1XNde8pkPqHxA4kXi0R4Ua71J6DcxQ5Gh7DK5nxqCxxDfmcNCe52B+DNM+iZ?=
 =?us-ascii?Q?LFrhNwb5pl9H/M/OOcwfXti+yLiz4arjFcgk28A65u6p3yDobaVZLCbZCvG0?=
 =?us-ascii?Q?Rn8UoKO3EkprmUFwXhwhvwSULKOeA+8KglhC6W4uBNgZ/nL6u1d/0Kz/KyMx?=
 =?us-ascii?Q?exBsdyA3vgUVcLgfZ5j6BcRBk0s35bYMFbYgsilGtHFROtMrSM4BzFiaPgNW?=
 =?us-ascii?Q?jZVPi+aCE9fW6HK5IFNj1nEJe7O2nVUzz6ID1peh9dQ1MMemd1fi1FXKnM5M?=
 =?us-ascii?Q?X0wHBVEImkCZpgOMNnO3L691EurQ2e7Gj/IeFNrMTnosxe1Fng/TlWpk7JoN?=
 =?us-ascii?Q?BsqmkiiA95rAiCyF876nKKlJI5hvjAhZ4bjY6PsUl4m4AtWyLcRhgAwxaBIw?=
 =?us-ascii?Q?6ddBeVmKLlmfIXgjI6NOUWiTLNto8ehERpdRNbc/m0osEbvOWs3ktacP8O2G?=
 =?us-ascii?Q?TwAGNLewLjjzy+esn6qe7oC6ONwfNh7BgJWDQ6dt/v0Rv54UklQOxC4rUiu0?=
 =?us-ascii?Q?DJuiPJKs0jkuw8nmZLAM7NXqdcNHQw6CSjrtsB+dc15qbxRqeShyPQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cwr+gKXJwPMmsihXKxt85R57u/bngsP1SxvSy1nQ5m/MafwDZ+UVQ89+au+T?=
 =?us-ascii?Q?7REvMhiRG3R7RIYyre5TcZPOLptZhRkJbQio58nA7suGQyeWasV0+uUGO7M0?=
 =?us-ascii?Q?5stJ2+MoIn6Ed3O+USYtbcS/5vVulF2ZmUsukCqirgQmCYiV0KeBkfd6jcU0?=
 =?us-ascii?Q?KRQ1aDtTRXv/tjulpUsS9q4D2miWCfIT94fw2O4k5qY74KB+3Igr3Au2BrTS?=
 =?us-ascii?Q?7gsiYdkgmSSoX2oTORYZCeZc0cpaCaLdWBGaaC56LLSkxBn6ZJLTM7EEC0p9?=
 =?us-ascii?Q?rvV2hI2L7w3qCZ+xxRW+Fu1hTTj0XTU8Q3Q7+kyhNlEC3ihlnlSIftPsWYjv?=
 =?us-ascii?Q?S/uI+b7yoScoDz68RsKxyCnBlIcyf7BYbbqFsIbFtDFySwdP6ObGKv/oITMz?=
 =?us-ascii?Q?MmFl0YbQ7YLOSYIC8FgSJ58bvePb39nx3m2DvNqhxWCFtpnVioeYWkhphVJc?=
 =?us-ascii?Q?jIJIUR9xkXz8xTmjtXAHql5bzugfUucpQGfGAOsr1bs5sttfgzpu4H2aL0Rx?=
 =?us-ascii?Q?6ojFfpSsUGGwKCnZYGppcDrq7mQtL5mH1/S7IYj3bVgKDxvCf/sAujXOM2yv?=
 =?us-ascii?Q?Yseq3/x2A3DTawUeosSIIF3Es8SW72nWjf/6mQ9IoYemhWsPX6HgYOcF/n9a?=
 =?us-ascii?Q?WXJL+OpKHOiUzCqxGtqkP4hfP6YwBDNrpx71BHsKJ8rSQc6xk+0Bs14MZirh?=
 =?us-ascii?Q?xG6U4CBLOWPqdYOR3r+jGMyAzmCGiwnhrKKD7DcNRGN5e8ernkeEBFMJXLx0?=
 =?us-ascii?Q?v98/tV4+m1Y9e9eaZbfQK75fmyGk78URl2yzsbRg6WUHHWavM/13CKk9Wbb1?=
 =?us-ascii?Q?to/ZgsMiEnSik0bd2HG4afXDCtFMNd6CAXR1aJp55acS3OYid2cYI0+Xk/+5?=
 =?us-ascii?Q?l+zGZ9v/0iUcXMJ3k/9clvbRGT7ig30BpMkYY/uGhTmqkCT6ng2f0Vi/U1Tu?=
 =?us-ascii?Q?73QQyt5T2/tQCI6eeQvFbv7OgUiEZ9O61XEi6fk9cli2mns819B6YZFiC62H?=
 =?us-ascii?Q?4CuedgE9XM4zdcV6Gb+z/lRmMiG5YKoJD8cRi2byEMB9vkcvzBHck0h3WAkd?=
 =?us-ascii?Q?LhLvrFXIV+0IDhlaWfuPXgyxFjcC+DdDlJazHUHqhKeJLeZKwB3MDyR5m4aQ?=
 =?us-ascii?Q?HvfRJz/DTsD7+tDUf3ftlGCrdRlijgw0ShGJLuHhlqERyaGNcYHzatcvsvlw?=
 =?us-ascii?Q?gwjOJI/eKA7cxofER57uacCE8cfXeczNRv28fEj1TBLHcrVdXG3GSK/yctt8?=
 =?us-ascii?Q?vZ2p2/dbAaNEVyr3kMltWhHJ4G69zYdBm4fQ6/tFsrdpcFb9JATCqDW+gfMW?=
 =?us-ascii?Q?/UtsW3En5Y8PHSOR7Jp0FsqsMIHEs4X40NQCqXf6P+SKyEVPoCD+sshhGc+W?=
 =?us-ascii?Q?tCpougPQ/+oBLDqrUlsWNQG+Z39MoPZ6naMILRlnSoI9FGkhNmZi+Gb+2PJ7?=
 =?us-ascii?Q?n9sjyYcOlCSKvZpQvBIB56WGwKHveLJfiUEUmQg7LAb8u9HH/14t0ClCYgj+?=
 =?us-ascii?Q?U1SbuSQD03d2xIbVxsETJrxY4NegOwVY1hygzyrAG5zezXXfLQKh6eosdZab?=
 =?us-ascii?Q?dMLg6meqw0qNHxvPlZRDVMjUm/VXnjXSQ+0dB3d4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f894b1f7-f0a9-4872-e4e5-08ddd7755c55
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:41.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOR0hAlyy7SSjG/zik65860HAh3Muez3veuiM4uJ9lBjfJWExuPc2TE2/YVaHfSzbPA9lIP4Rl8z1lins0t7fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

From: Andrea Righi <arighi@nvidia.com>

Always account for both the ext_server and fair_server bandwidths,
especially during CPU hotplug operations. Ignoring either can lead to
imbalances in total_bw when sched_ext schedulers are active and CPUs are
brought online / offline.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/deadline.c | 29 +++++++++++++++++++++--------
 kernel/sched/topology.c |  5 +++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 17f8cd5df1aa..92ca2f5b7cb9 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2981,9 +2981,17 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
+		struct sched_dl_entity *dl_se;
 
-		if (dl_server(dl_se) && cpu_active(i))
+		if (!cpu_active(i))
+			continue;
+
+		dl_se = &cpu_rq(i)->fair_server;
+		if (dl_server(dl_se))
+			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
+
+		dl_se = &cpu_rq(i)->ext_server;
+		if (dl_server(dl_se))
 			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
 	}
 }
@@ -3478,6 +3486,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 	struct dl_bw *dl_b;
 	bool overflow = 0;
 	u64 fair_server_bw = 0;
+	u64 ext_server_bw = 0;
 
 	rcu_read_lock_sched();
 	dl_b = dl_bw_of(cpu);
@@ -3510,27 +3519,31 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu, u64 dl_bw)
 		cap -= arch_scale_cpu_capacity(cpu);
 
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
 		if (cpu_rq(cpu)->fair_server.dl_server)
 			fair_server_bw = cpu_rq(cpu)->fair_server.dl_bw;
 
+		if (cpu_rq(cpu)->ext_server.dl_server)
+			ext_server_bw = cpu_rq(cpu)->ext_server.dl_bw;
+
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - fair_server_bw - ext_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow = __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow = __dl_overflow(dl_b, cap,
+							 fair_server_bw + ext_server_bw, 0);
 			else
 				overflow = 1;
 		}
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133bb8a4..f4574b0cf8eb 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *rd)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
 
 	if (old_rd)
-- 
2.34.1


