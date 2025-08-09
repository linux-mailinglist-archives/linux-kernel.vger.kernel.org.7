Return-Path: <linux-kernel+bounces-761225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A89DB1F5E6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 20:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E6E11886FE9
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 18:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEF72C1798;
	Sat,  9 Aug 2025 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVdBTMWx"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6690D2C15B8
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754765322; cv=fail; b=mJlV0myBA17CA85er0YMxIetZDVEFeAnWpR0m7hdRDuoOAn+yctAWld3xyp3ohCqXrAeKerd+lKSwPSGaW/3L556av/7Y43Rx5lb11POkiF/re4gp4rcNKyPmJc6eunpxeOzkNjNJdUWP0UpZ2ojGsR2T1nP/n7JK1HOaPjokOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754765322; c=relaxed/simple;
	bh=capl0j9ELyrMeTaIz93BSDRa1C0xUHoQ0LZPCkZLK+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzmmkgH+qmtfe8yyP8OcPMie0TE46nrpjhCsv3VUaXLNLl68HqkhWc9DS9T3uziBZ19qsvwQAdEd/UguiTZxAYXYDcpClg/93Co3C7yAK39pTuM0q6dtQqHZXHhBfTQNcmB+GY8uBBYtup202XGxukttqrqdHstd9EU3rdOM8dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVdBTMWx; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7tOrRGtbYFrdjgydxoFcozXM5JRTdmWzKwT0tTquMTGDmIV7Nbg7ITWxtK2rbN85GvXbIqjCJMsV1xsnythe0IbUQaqTdu+RTF8LQqGaU2rtLdhpFcFeUg54wyNxCoISuSYY/2HMBFNZHbSBIkEzCrP3PVlzfeT791Y03B3tMvAy2EouSYpiMPbeoEikoRV68QrzG0zdjv4zKfFZD4OvRAAP8ibt4fXTmqNNif1/L1GsBoRzIF62eu1YFs/CalOqFRXfibvM1HMrwm8Uz1gIveWpyIBqYDK3n+BushGs77jvq3mFPFgEpiKY+fW3RpP/TsW3gkzIse9cBL5wIInRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NhVv4T1H8PtBtpyW75kwikCGA5Pj7hpogrZWx6hSYU=;
 b=MvW7ZSPgg+nClv4Sl2JR01Stmu/NWb80ByBkISDudZxeL+HwC5/JBvM0sNDbd5CriUiZwrvknseHQPsbwBoh2DveCvlMQcUJQA5tQa0A9GzK8Z9se03/sp9cjjol94KNZeVCbg17OqKqWaJ3Wnu2nRFKZQx170pmk2PTxg6d0CUY0ksh3He51ntL1MgaZj16sjmHNPUYDsYmTitQ1LW7NaT2/oQPJ3eC9owQj+L/iOX4IJlnS3hlkiTKUToE0+z/Uc723pDON3Y+9vlKpjiZ8/Wb3zzEn/0pUE5iwuODK3UVyrcqxB5ul6LMKsgR3mSg+T1o1gudiN2MsvSrD18kiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NhVv4T1H8PtBtpyW75kwikCGA5Pj7hpogrZWx6hSYU=;
 b=QVdBTMWxIe2yU6aUCUFF09w2TN8SPn//VvRj1VDxZS6nhcUMx3JMi0YMJ0vjAMxzEpp1xNmPVt8xlBgtaP99yYVTFXtAiQLhn0FYhjKb9rQ4wRNAKAzIlC1LbCvZCXkfvb3DDP99mKvsxLxgigmW7PuVc372aTkHZQDJqwY0GA8DR5kOPGmBUEV9g8PB3BaXQwNXzaT4zlEvYwKOGlRG1Ga6GfKrCurX4UdVz6bNEzqWwDwiZnzASQbPQGjHnv1/Z4/7h9avPDltNT2n+OeFkynaMaGEbooUByLa2EjScwN5TeRED0PFovCEkqTlqLXA0NmJ2vYqPZMkBbv2MHwwzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by MW4PR12MB7310.namprd12.prod.outlook.com (2603:10b6:303:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sat, 9 Aug
 2025 18:48:37 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%7]) with mapi id 15.20.9009.017; Sat, 9 Aug 2025
 18:48:36 +0000
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
Subject: [PATCH -rebased 08/15] sched/debug: Add support to change sched_ext server params
Date: Sat,  9 Aug 2025 14:47:53 -0400
Message-Id: <20250809184800.129831-9-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250809184800.129831-1-joelagnelf@nvidia.com>
References: <20250809184800.129831-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|MW4PR12MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a6bd06-0f0f-4709-7126-08ddd7755969
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xsKesPGcMnWHZyVT8b2I2SS8tcsYgzRsdN6Inqi294+f4Fi9717uxJOmQQFn?=
 =?us-ascii?Q?39HhkHwupVEpd/M90zkhgaMKPAw2Mq3yzzf4KHXxAtsdTSCtwqVUoojY3vCO?=
 =?us-ascii?Q?e+wq2JpFLRtVwaxkS1G6ZGRbsiYOAD3l+r3JWZQzuR/B+qlUI3t4jZ2Y2Lh9?=
 =?us-ascii?Q?ykOlV4zL2XrsEW7aLvEcpW2Mo9ZNszlYbZGi5PfxaZcvB8j3/aqxb+QxGWNT?=
 =?us-ascii?Q?A7xu6OUAngvbteilzfG9hUphjv6vuOS+1MC5NBMjysWNBbobUTKv6dYi83gr?=
 =?us-ascii?Q?NvsjmAPLrCk6lWia8fu6Gzf4qJkiue+TmPAlnxz/s9ZUaH2qaQA+vpMG5kRa?=
 =?us-ascii?Q?ElX/yDR0jt9BM7SdEAJPEtQW5fg7+uUZMU8Z8Oa/umMkmtufOHjpwKssOITP?=
 =?us-ascii?Q?UXSqxjfA+3uZGqCQvSVCbNEjJLjCMiskKqYP6IlFwVidPSzI1G1XII8Ofobu?=
 =?us-ascii?Q?OOGgvlK1SDnoMrlG/zf+0j7THZZhOU5SWYmQ0B9A9sNrKWdcWen0VcYKzz3j?=
 =?us-ascii?Q?WZxBRUZaACJ4pfV81NKPtBS4zocVWxLvNUPP5bEYPa2R3b/G6eHhxb633GA0?=
 =?us-ascii?Q?acXCgNQAyGrSgMI24aF/VVX3/63WzjdJPUqRTcihEsND72s/uyZsWnYQ1OaL?=
 =?us-ascii?Q?MaLO+J4N4uuULzo1DK48KxM9TQCY4yjuMOOV3eavLzrGYyD3NkLG0p7yAOq/?=
 =?us-ascii?Q?2Z+FpWqU0DokNDaMYERfa+oC6AHXSkIlotMyXI1hivdwDoOc9f9SeZuW+We9?=
 =?us-ascii?Q?b8FC4kZnjzhTxdjsevP3K5LjFtgG3ArSlsrqAZvY1n6wPpG2HMrgMO2cQILb?=
 =?us-ascii?Q?Rj9wdPGXeRsi2wLuQ/miAkm/OBVs4EG+6P97h3T1mG4d3P21dKgFkA0JhtOc?=
 =?us-ascii?Q?U2KnjNoDTYayAeFWiwS7TMY6JBKsVKUgn++KEOrJzvfRCMswuZMFFBYWbD4r?=
 =?us-ascii?Q?FhaDT5mLRQCtVu743FY6vyc+AYuwxz5VQV5ySUKf2BHQkLr07IVA170FN2Wl?=
 =?us-ascii?Q?V6G/MwgIW/XhdlENNAU/XL3v/04IZ2ifYHt6jGN1+DeMy2PxXiB9o/7XaTIm?=
 =?us-ascii?Q?yiMCZuPEW2UPw0J8D/glE3BKXqlN2tIbjf2Y6KOz90lrQw7W/VtNkWEFQ7vS?=
 =?us-ascii?Q?8dfobOXTYJPVo/o1EEOadF+oWZr2cQlADAb5mCSGaFbJv+BYFW7jrsGW8JOy?=
 =?us-ascii?Q?fdB7XON3NkocOUvZi1UYp6W5ysuFhzDgYfYoU5VKgDOnJvMbzWeKSDGPM46U?=
 =?us-ascii?Q?x08o82ildwQ/Gman1tXYoyAU/2STIbSGnJ8hCeSO1+zICOFS1DQQcvCS1tF2?=
 =?us-ascii?Q?a+FcxUgQ+14rWWMuQ/lMKShtWCUEUmG1jtk2CFss0SRMJ91rd6dB0aCbhAGe?=
 =?us-ascii?Q?q09q94zDgv4/jwONYzDFMd8qfeEt/XP6Uj1nso4rM6h7oe2aAfcMTwM4IxRn?=
 =?us-ascii?Q?eAxRiWvsyqGwbuJ0rIv9D/XY3suVVKPSOdbIgrhHZy/8P2quod1UoA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+fHoPPJXIOUQCtamcXhhJJDyZ5u+jDa4noFBVBk24DJ6OK9aK/uNdu+A7i4?=
 =?us-ascii?Q?wO6GgxB7Mr9bNGnMmc9ZYNVwgZ2MebLsmxNuLvhIL8ovCePO4u3xmn4uvdC2?=
 =?us-ascii?Q?u8I1u33gjv8fpDpEoYlas7Dx9A7zkrHOPYB4+C6WosIRNMv0xzrr5YQZJsXI?=
 =?us-ascii?Q?xhhpy9GRTggQZuizmTiP7ogPndOAM3Aiid2WafQ8CirNCthjgtEuvDKDIn5/?=
 =?us-ascii?Q?oK3zGA/0+2JYnPO/3Rdk5mYd37qqM1MHtBvu2Fx5jiPVIPI3LhbuiQIx05XR?=
 =?us-ascii?Q?ZmbJfAg68tE9ASKTEyMMZ6V0wAfC97nGs2zP8R8irhpfcR70VtA00x6CvOol?=
 =?us-ascii?Q?SuzfNr1ei2k2PNhiHvcQ1jHBhIdA0uoJmNpypWDsPY2iUH4tWpN+ZwPDz9O1?=
 =?us-ascii?Q?LM3ySe5NIGTPtw6JVToxwxTVVeb8G+YMwlct2cYUDn6wZWJTgpts8OkjpE1R?=
 =?us-ascii?Q?aBzSctZR/D6/AsDyMApzT/FAIsVWDOtiJuAK99c7z70BGxw0+NsUz+Ku/x48?=
 =?us-ascii?Q?O+5xkI8kNIvy0wMsKdCAUXpaD5J+PNXP1VwpYRUZDnsaAukPrCbObxqQc1Se?=
 =?us-ascii?Q?ihQXRXC3lxMUTiz/IMclEoOtjxxitDBQRQyB5T925Bo32k1Wx5N+vTdhCGem?=
 =?us-ascii?Q?KM28YbwFVsL0ZubKc9laNx/1FBX06plRehANn0aaSEIUhF9PK9Xec824Wh0t?=
 =?us-ascii?Q?IYScbN9gp45T9uE8RPxdcOBM6IJEp9NMBoiaIq4+USI50HPZUc28t1XAoc89?=
 =?us-ascii?Q?zTinQtptu1A9RYI0Z4JEC9iooUCzjT4B1iU3A7KdSACTYYaEZRFlPMERQlqu?=
 =?us-ascii?Q?z4mjx+DmPqpcyF6bbmwTmOaYy9rqjQA8UEVs6JssyEv+98FQojZKbyd1OxS/?=
 =?us-ascii?Q?lrYI25g2bppP/uC+I6G6Q8DYSIr+/+klr74qS92aCXh6fHYgWXqWQnrMOgp5?=
 =?us-ascii?Q?eqPDkpZCNOSdl0tzyeOV1mr7G4jQwf/bzzr7eJltwRcCxo3qGRaLEFMsBuqT?=
 =?us-ascii?Q?b2IZyCCmyVPCfZgBmQlYALZs5obNy7ZAC9pB7uAz0AXTpf/Xvb9DiW9iqClF?=
 =?us-ascii?Q?0TGznUQifkqOMUVv4Jr45ieBE3NmKXUmJP1132J688g1oIEaZiPiUmRvpfY4?=
 =?us-ascii?Q?gMhQICRKnkTQ866nkg0HZN70lahr8v1TUxkRXUaDuCO2fseJlSF7jIaJ8kdV?=
 =?us-ascii?Q?gvTsg5/aYFEXD8zf3D3Py3DChsDgmqdrL+BRR2y4TIXmzQtNvdgpylKaj+Wd?=
 =?us-ascii?Q?9FwB0YkT6pOdsQN79WVxWwQH9WBFsWDWeXu0o8Uh+mlTdaGo+fXn93/EaFsU?=
 =?us-ascii?Q?wcbVqpbPgeihAp0F0lzc5AxmCIJtmLZROWlLkBFEwA0TqA9xAPs3PLP4KXmU?=
 =?us-ascii?Q?ZmBoSohptrKPVNbhbl4S8jDB2kfabuN21Ic2IFrlbbRdF154P5jN5lj0Uwri?=
 =?us-ascii?Q?WLhUqma+dTeMc8LAyhuDssTZ/kdQ//Drv4R7DaLqM/T+mZB0b05HpIrctIRh?=
 =?us-ascii?Q?Gp4zqSp1upvXXeaqfrBBQnQ3M4OpueUqXPSF987aJYvvw42Ox7dce7HilRJa?=
 =?us-ascii?Q?yokKG+b8l/klkJenYY+zBpVY3YvpdQiFrcWfqko3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a6bd06-0f0f-4709-7126-08ddd7755969
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2025 18:48:36.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOVYElY1v95OBXcirYByUp22SlO+t/NIsMT6DO3AoH8IGd8+CWg+zjTNLOOfEc9dEzgUlIgJ+Lp/LRUNCPFXDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7310

When a sched_ext server is loaded, tasks in CFS are converted to run in
sched_ext class. Add support to modify the ext server parameters similar
to how the fair server parameters are modified.

Re-use common code between ext and fair servers as needed.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 kernel/sched/debug.c | 149 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 125 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e71f6618c1a6..00ad35b812f7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -336,14 +336,16 @@ enum dl_param {
 	DL_PERIOD,
 };
 
-static unsigned long fair_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
-static unsigned long fair_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
+static unsigned long dl_server_period_max = (1UL << 22) * NSEC_PER_USEC; /* ~4 seconds */
+static unsigned long dl_server_period_min = (100) * NSEC_PER_USEC;     /* 100 us */
 
-static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubuf,
-				       size_t cnt, loff_t *ppos, enum dl_param param)
+static ssize_t sched_server_write_common(struct file *filp, const char __user *ubuf,
+					 size_t cnt, loff_t *ppos, enum dl_param param,
+					 void *server)
 {
 	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
 	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 runtime, period;
 	int retval = 0;
 	size_t err;
@@ -356,8 +358,8 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	scoped_guard (rq_lock_irqsave, rq) {
 		bool is_active;
 
-		runtime  = rq->fair_server.dl_runtime;
-		period = rq->fair_server.dl_period;
+		runtime = dl_se->dl_runtime;
+		period = dl_se->dl_period;
 
 		switch (param) {
 		case DL_RUNTIME:
@@ -373,25 +375,25 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 		}
 
 		if (runtime > period ||
-		    period > fair_server_period_max ||
-		    period < fair_server_period_min) {
+		    period > dl_server_period_max ||
+		    period < dl_server_period_min) {
 			return  -EINVAL;
 		}
 
-		is_active = dl_server_active(&rq->fair_server);
+		is_active = dl_server_active(dl_se);
 		if (is_active) {
 			update_rq_clock(rq);
-			dl_server_stop(&rq->fair_server);
+			dl_server_stop(dl_se);
 		}
 
-		retval = dl_server_apply_params(&rq->fair_server, runtime, period, 0);
+		retval = dl_server_apply_params(dl_se, runtime, period, 0);
 
 		if (!runtime)
-			printk_deferred("Fair server disabled in CPU %d, system may crash due to starvation.\n",
-					cpu_of(rq));
+			printk_deferred("%s server disabled on CPU %d, system may crash due to starvation.\n",
+					server == &rq->fair_server ? "Fair" : "Ext", cpu_of(rq));
 
 		if (is_active)
-			dl_server_start(&rq->fair_server);
+			dl_server_start(dl_se);
 
 		if (retval < 0)
 			return retval;
@@ -401,36 +403,42 @@ static ssize_t sched_fair_server_write(struct file *filp, const char __user *ubu
 	return cnt;
 }
 
-static size_t sched_fair_server_show(struct seq_file *m, void *v, enum dl_param param)
+static size_t sched_server_show_common(struct seq_file *m, void *v, enum dl_param param,
+				       void *server)
 {
-	unsigned long cpu = (unsigned long) m->private;
-	struct rq *rq = cpu_rq(cpu);
+	struct sched_dl_entity *dl_se = (struct sched_dl_entity *)server;
 	u64 value;
 
 	switch (param) {
 	case DL_RUNTIME:
-		value = rq->fair_server.dl_runtime;
+		value = dl_se->dl_runtime;
 		break;
 	case DL_PERIOD:
-		value = rq->fair_server.dl_period;
+		value = dl_se->dl_period;
 		break;
 	}
 
 	seq_printf(m, "%llu\n", value);
 	return 0;
-
 }
 
 static ssize_t
 sched_fair_server_runtime_write(struct file *filp, const char __user *ubuf,
 				size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_RUNTIME);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_runtime_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_RUNTIME);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->fair_server);
 }
 
 static int sched_fair_server_runtime_open(struct inode *inode, struct file *filp)
@@ -446,16 +454,55 @@ static const struct file_operations fair_server_runtime_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_runtime_write(struct file *filp, const char __user *ubuf,
+			       size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_RUNTIME,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_runtime_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_RUNTIME, &rq->ext_server);
+}
+
+static int sched_ext_server_runtime_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_runtime_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_runtime_fops = {
+	.open		= sched_ext_server_runtime_open,
+	.write		= sched_ext_server_runtime_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ssize_t
 sched_fair_server_period_write(struct file *filp, const char __user *ubuf,
 			       size_t cnt, loff_t *ppos)
 {
-	return sched_fair_server_write(filp, ubuf, cnt, ppos, DL_PERIOD);
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->fair_server);
 }
 
 static int sched_fair_server_period_show(struct seq_file *m, void *v)
 {
-	return sched_fair_server_show(m, v, DL_PERIOD);
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->fair_server);
 }
 
 static int sched_fair_server_period_open(struct inode *inode, struct file *filp)
@@ -471,6 +518,38 @@ static const struct file_operations fair_server_period_fops = {
 	.release	= single_release,
 };
 
+static ssize_t
+sched_ext_server_period_write(struct file *filp, const char __user *ubuf,
+			      size_t cnt, loff_t *ppos)
+{
+	long cpu = (long) ((struct seq_file *) filp->private_data)->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_write_common(filp, ubuf, cnt, ppos, DL_PERIOD,
+					&rq->ext_server);
+}
+
+static int sched_ext_server_period_show(struct seq_file *m, void *v)
+{
+	unsigned long cpu = (unsigned long) m->private;
+	struct rq *rq = cpu_rq(cpu);
+
+	return sched_server_show_common(m, v, DL_PERIOD, &rq->ext_server);
+}
+
+static int sched_ext_server_period_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, sched_ext_server_period_show, inode->i_private);
+}
+
+static const struct file_operations ext_server_period_fops = {
+	.open		= sched_ext_server_period_open,
+	.write		= sched_ext_server_period_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static struct dentry *debugfs_sched;
 
 static void debugfs_fair_server_init(void)
@@ -494,6 +573,27 @@ static void debugfs_fair_server_init(void)
 	}
 }
 
+static void debugfs_ext_server_init(void)
+{
+	struct dentry *d_ext;
+	unsigned long cpu;
+
+	d_ext = debugfs_create_dir("ext_server", debugfs_sched);
+	if (!d_ext)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		struct dentry *d_cpu;
+		char buf[32];
+
+		snprintf(buf, sizeof(buf), "cpu%lu", cpu);
+		d_cpu = debugfs_create_dir(buf, d_ext);
+
+		debugfs_create_file("runtime", 0644, d_cpu, (void *) cpu, &ext_server_runtime_fops);
+		debugfs_create_file("period", 0644, d_cpu, (void *) cpu, &ext_server_period_fops);
+	}
+}
+
 static __init int sched_init_debug(void)
 {
 	struct dentry __maybe_unused *numa;
@@ -532,6 +632,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("debug", 0444, debugfs_sched, NULL, &sched_debug_fops);
 
 	debugfs_fair_server_init();
+	debugfs_ext_server_init();
 
 	return 0;
 }
-- 
2.34.1


