Return-Path: <linux-kernel+bounces-761221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22009B1F5E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4886251A1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7C82C08D1;
	Sat,  9 Aug 2025 18:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OZEl0guT"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776B72C08A8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765308; cv=fail; b=UB00ViUzlnc+dqXZDDMieJWktp0PE3k1ECLMFEzsZLMQlIVNGvhVLJir8y8WRoA/aa3vbk+Y60jxGpVDCzWiEKI4o+YY6FV2HtuWx8bUs+pihWBAGfwwOlQam9ebYzH0JKlhtGPC2GktAFKy9rWwHE4OlpsFQYoPws0BFDWDwbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765308; c=relaxed/simple;
	bh=Ip+rnZl5Sa3mfucsQUTA/hDYFZIMNFmpVMnZmaREai8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BcSgPyHUw0iL7Ko+WeBHi0CBBr/5+iPbH/qpLZ3/LP2/PDqIgXBo1hYhQJhEqUQLKsSGIwEvv+hFQCwcWOvgtVOsIxXwF6FQDaz05nIZ8tCtsnE3KgpRX9RaMS1Wy/zr8B8WbGfcwigiTdVyo9helif5uRhruw1WRro1bCcrT6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OZEl0guT; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJAcwyYGjMyAGxsxSDvq07C6sNhKrJb4L97IgVX3h9qx/dNlidH+PIrg0HlQ5M+/92XabcNDYxOK2yjme2qSGjnwmtE0XtZtc6fIaZIAZ5XPx+ZkYWM4AFNQsLKRaKz2I15K3dfo9OSFKL/E/mChCq1hDNZ9PCn0QXKpi2obDr4pqjQ484FkK+875tTuGnnWJQt+R7WKYbhFpHVgR2eXek2G5+dQawLkZEg+xTfwA7XBDxttHNXa8ADtVGCN/hQDIeS1t8Y3UnvV4nP2eh1a73VM/FV3Fb5nacx3yq8pXEFWFb3esMNpFkCfhar27ObjBc5VGrfILIvVJkaRHc0vYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+RHdAKkeult/IX818u+cXGYVaztUfbM+oETcAjInW8=;
 b=zFsbMRItK8MWAgsULLLV5VPWYoild92nnAkHKojKzxs4EkSnWHk7A3HteeB3O+lcuV6BiYyvSp0SnU8jrXY5j57/af5j+lidK2vTWFpS9XD4VPLBUWlL6KKaNo2jWhH/5A35O17/Z5Go1zoURBLV7j3fm1l/zD9evelcC5F5lk/L+kw02jxEmi2b8OVsns7yhLZ2/bYBsoXQod3UFgXHJX0EmqFJmEJVW/D2wj0/iEXHIjIMQDzAZEYUZyxu3cULpyKhQEjz6EFWYuK7cCCM+sM/j7K1KDwOoK7zIUIfQa5ICo1SfxENEOaOx/Tde5zjWtxMMpNV6dqzxenEpXe7EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+RHdAKkeult/IX818u+cXGYVaztUfbM+oETcAjInW8=;
 b=OZEl0guT6u1PjWQ1IbmL6ApVvphyDy9GAxot+M5XDdnvCSph7jruZiwI9FTi7fXfeuDlpaZ/EvtOvzGRsmv5+5Iouyrv7DAVsk6HQyYut/nqdCaMswx4m5+AHjMEqxKxPK2PpNnXenN8W2k+tQe7vtBsybhTAOGYGoOvQDIcy2Js4Xql0V4qqoEngjayWRBYNOwufuLLXQfZEdlB8OdgkIlxGlg/MBqB83OgFLXoMr8rGrTAU9PiR+V56fZvqtizxVcgNxuIl/ujNhm6k+J+Y6407TYpjnRiMEG8/gzb0yt1Ey0C0cPhVvaJIpEXuwmHuwSavphi7YHuKMpLlD9gNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:25 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:25 +0000
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
Subject: [PATCH -rebased 04/15] sched/deadline: Return EBUSY if dl_bw_cpus is zero
Date: Sat,  9 Aug 2025 14:47:49 -0400
Message-Id: <20250809184800.129831-5-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::13) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de2f98e-3343-46b3-bcf3-08ddd77552ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iiTWET2BnTs6biHI7iJD1BK9SQxTzkh9CyELpoZbK3DJvBAk904n8H5S9+FF?=
 =?us-ascii?Q?sZuIs942cZd9+ISnW89DRiY+24Fa2ZZcpbMap/nzLubFJuyZ/tCbAwrojk8e?=
 =?us-ascii?Q?dkzjS7eOpAc7jpLSDraB1Oe3CLASI8Ibelb9d+hr9y8CV+mJxFzuJtHwEMB4?=
 =?us-ascii?Q?ZyYiDHVnqJ7VbIPu7dkzeFZMUg4+MRpNQgsLkIgFZxJp2w4kcIcdsrRDv87X?=
 =?us-ascii?Q?QMtV8HBQplI+sWHZXIqE2RkektXmLIkIy7WsON66L/H2SLsItRN1EvUwXBQz?=
 =?us-ascii?Q?wyePBX4nkzx19yx0Y6rKbZebhA3UH8AdXEas4fnx0TqYxN7iofi0hYSRsRIB?=
 =?us-ascii?Q?eFFm+m0T/5eZ44Hbp/7Jj6ffBCFI3exnCVcxW8MtxmHqqS5mImwPWfMNYuhN?=
 =?us-ascii?Q?XSpOwFInsKvsy8g7PmRSDK+b4gUA34I0wjXQavGaIB53XJEvWFN4n0BfQC8P?=
 =?us-ascii?Q?Cr3fTBYkk2Sbf0Y/AtHGHxkTfsVlr7P7s1OnD6cfjslaZCfJOqLA3d6UzTtw?=
 =?us-ascii?Q?WwavQ2GMY9JwxDLZ23lL2pUXi/kvdL4NYOWMu2qskOF0UDpQZhvJ+d1UO2R7?=
 =?us-ascii?Q?ANvOaMRpz0FsheKJkLSjHpQbs1YF9X59v5meCFhlnjh4mLZlKSIENE0NKJhw?=
 =?us-ascii?Q?6n3Xj/BRjBbIq8aC+HbpPJ9nAq3geWqKYgEkkCjG9iJCalYHbWybU/P3ABwE?=
 =?us-ascii?Q?i2I0Aatk4MMWTeCU/YO7bl1vBEobxm7SWu5EZ5+6bxd0ZUTuqf8bRw7HpnJG?=
 =?us-ascii?Q?xsRE4ChH4yalbNl1py1wxnx6yb731lNx9owvH0RQErBzH0b6xjOCbREqgMUG?=
 =?us-ascii?Q?/S2s8JlacdQwxkCWAoLyaOZJcpBimc0HAbUw2UA7r5pRRLFVQSkUz1j4p640?=
 =?us-ascii?Q?jr1uLi4789WBA1GwE1BAxE6kpJIg2w6zgJ7gGdPsjV7DcjYeOYKTH8of6BvN?=
 =?us-ascii?Q?JFqqVhYvGw1Z5wTopbFn9jeB5dF66+3EPVW7b0y1kzmgXcvp9m7h1y8Kxd8H?=
 =?us-ascii?Q?FFQBiXzOhMSGzV60U2vWdpNg8oi5gE/BohCiQ3hZJWC26njE023STgQvPhJf?=
 =?us-ascii?Q?aFaiTrmgdHjuV6u8AtmG9OkN35JizSF2INRPnqA+jY571SYWE9Q8qZkAkicN?=
 =?us-ascii?Q?oRpJE6Aa6geuPXrez4vl51+XOhwL95fOGBAxULWmGvcAEA/WorLUaCWOqEER?=
 =?us-ascii?Q?0ocP8glzydQdrSKDMl0wJ5mkjQSr5mi9QZa6waw5lqpZcDCG3cvIHU1H4XLE?=
 =?us-ascii?Q?+N+FKGwWfsFd628cdb9q0QC9JIagnK/Vo2p6zOarW9aeofgAOCQ1ih5CqFoZ?=
 =?us-ascii?Q?eJbKA0/GXpJdVF3oStWfwyX2wuKoVGdl3v42vkSspgYhL5W4xk2ynrKg2ZC1?=
 =?us-ascii?Q?/PGpHVdPlBBLNITdlW1ouyMFWVZO5Qt+Z+kv9KzjCHqX7+TkQk9naByuklHM?=
 =?us-ascii?Q?Ue6DDYz73DpEW8CxPq2hzdKZoD4lhKQpQypVQqtVRwKJ2TsysKynOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0HIPhZT97lMAm1XzCgCvodwDBKWazJz73ZE+zrnpDFzsfpVVzTl5NHRVkdz4?=
 =?us-ascii?Q?ZmYTEOKWAcN/DBIlE4Qf0kDTXcfAJMyfGlmEfHRs0vx3iVY1qRs5OhlsU9X9?=
 =?us-ascii?Q?4IAXge7D6KcDUWaQEH1slJuxzHWIm6Gf3TzlBXinMiyD4KKRH+wprqRrUjzg?=
 =?us-ascii?Q?X1raKFY7287vbRu5PyQQCC7T+gdYZWeos7xAUmUhataHJG1bevspwKK1hg5H?=
 =?us-ascii?Q?fzI/wKRnrtCtvvgcwckh5IfeLM+ak3qbJDnYUp0gRQE7qb+/hYowv2nuFh2X?=
 =?us-ascii?Q?66NxMoH4ybRuMVlkak/z7/fWtNgchisfJrlbmQOzVvLaMst13rFvol127i13?=
 =?us-ascii?Q?9RIMPBSKOXfGw531dNjjdN/U1lnqNItNGyh7aeCi3QDf8rBCmbT9GidmSt5X?=
 =?us-ascii?Q?Gr65ESstl4XSb0gW0fNL+Nw8lGhAyz9J+QLvXuOpzh/KKQSsYdX4obvcCn5D?=
 =?us-ascii?Q?VQfvz27VMreRwf1WSfaFrKTnH+7ss/hr5edYo7jqrQ5L6ocQaHNNAo5vrDyY?=
 =?us-ascii?Q?UwCx5TDpubPo3qbO6O6h391x7GABJGEgwyskTXzqm6Hehxu12M4f3P/xGKnk?=
 =?us-ascii?Q?oB0dTBmwWO9xVzQ3//KvYTswmsYc9YpvnlDqCcXvUiInj2GFR0QTIcrOIMsj?=
 =?us-ascii?Q?5CRr1HipoQA9OqQrdX0yugFP/K8060WtNWHjYdR/2g+t0E8lBD8KH2tyOVUX?=
 =?us-ascii?Q?XhX0N2rV8ofMGlRvGYwroNKY9AWKPkILKpC4hcdtd4FMcQbD020Zeb15Gk50?=
 =?us-ascii?Q?xAUEQWIgfFWcTRT6UcGBO8IVMfwy6qUV5hCJiAWgbPn83iKjyiOsbnrvAumL?=
 =?us-ascii?Q?W/LXxOmG5V0welu4YVLSM9r2Dl5UdK/SB+44nBLFf1jMgpFiMZ5g1VWzlmye?=
 =?us-ascii?Q?DlYaWYjwlsF5fBYODS6+jOPhdIP372E2/ct2QSP6Ae06dk1fM3xHP2g/Galj?=
 =?us-ascii?Q?P+KkePDj0uPuyYQzuT8Ybni1E9fg6sNYrtu8Ugdhp8b7SfjUX3UVczCbStkf?=
 =?us-ascii?Q?FGPnZdw2CJn129N6HwwXH//+zg3HuqmSA/8uQtaDAs367h6zwNGg+oMdMIS6?=
 =?us-ascii?Q?K+Xn56M4VGtxRdPesF//ntHikXt1b6/PEnFBDeVrphERtl/fErhIgDKTNaHE?=
 =?us-ascii?Q?9T6vSKofqoOKNxKCvudSVVRIcCYwPIhM0aigLlwjVx632IF3ZeW4WfbBtNNK?=
 =?us-ascii?Q?uN+RKFBrVnzV/msuErut/Q9cuPjO01l2UluHv5Cqp7QXqmtFwl1F11y1VcFX?=
 =?us-ascii?Q?xjP3L3ZlUAEmjH/dxo/BU/sVkQwg1jfQUIvUgp9lVw+2waImjuRIPqQqSbE+?=
 =?us-ascii?Q?fCaUAQ5gC9p5wOZhnZ0oBdt9gyPztzUAGpcHhNEXGBaP6RjHrFUCxeEGUSoF?=
 =?us-ascii?Q?fHgg5zZ5O6gPeZtpjgWT3gf/yuFa/0j2P6w4cF4D9E+hSRaUCdWFehhUiTcj?=
 =?us-ascii?Q?SFpa5182ahxwGmlfddlOYpSU+CrCumz03Kyk55vtuYvvQv3xhEaXi1Lfxxmt?=
 =?us-ascii?Q?O5+/6bsSqFrpP8XfUfSsAMtD4UJJ+ciBmjEgki/zzGmKpssR7AjQlfH2VVfC?=
 =?us-ascii?Q?g2rQ9jAF8mNSVxc+MKbF43Uac3wRUURit9NdEDcg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de2f98e-3343-46b3-bcf3-08ddd77552ad
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:25.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9FC7byjfyFFIlb8tCjs0hn2pL4k1Q4EAtFOeGeIvVnrPU/NpZ1AJOEholTInBU1XLFPiuGgMYwighRdkpsCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

Hotplugged CPUs coming online do an enqueue but are not a part of any
root domain containing cpu_active() CPUs. So in this case, don't mess
with accounting and we can retry later. Without this patch, we see
crashes with sched_ext selftest's hotplug test due to divide by zero.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/deadline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3c478a1b2890..753e50b1e86f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1689,7 +1689,12 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	cpus = dl_bw_cpus(cpu);
 	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+	/*
+	 * Hotplugged CPUs coming online do an enqueue but are not a part of any
+	 * root domain containing cpu_active() CPUs. So in this case, don't mess
+	 * with accounting and we can retry later.
+	 */
+	if (!cpus || __dl_overflow(dl_b, cap, old_bw, new_bw))
 		return -EBUSY;
 
 	if (init) {
-- 
2.34.1


