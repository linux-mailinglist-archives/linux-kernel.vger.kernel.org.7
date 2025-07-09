Return-Path: <linux-kernel+bounces-723171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D1AFE3FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6331886F3A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B056283FF0;
	Wed,  9 Jul 2025 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ef4GWNWT"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57BD272808
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052878; cv=fail; b=HcPcKk/yxyzqhCdL9ldAHjtaGXXZZFIIACqMK8Ja26Ccf+erjtv5DNAx950IOXwVP9G/lQ4S10gDedz3NHhLGnCLa9jjQ/VXIKnJX/vdsIAtGji+akfjaGOgUpSbM/034wwiN/kL/wuQcpKmitSHxArFi66ejEWHnPU3dFwZxzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052878; c=relaxed/simple;
	bh=6gGj0tAoY5v8Z8WyaBTyk1xXfKXd3A/APwCANtIKw5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZkuaRcqo9l+UbjF1i0gatxFd61w9awG3qyxgg15EMXqupz8Di1Qv1kG17FRvLmjpYEljnuNLdiv8tbZnJpJjx0GC31rl0l9PuJvAHgQAgcuG8hRu/R3IGblsVYzqQSSwL4JfvdJ3jraGv5NXzdRCKOTuI8+yHs4R05FoiroPnYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ef4GWNWT; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDi/JKtngx/9pCeLl5rw7kELkCxeuMEXzEli8KCv2gJyh/kAvPcSzIRv9kf41jOrGDvC3ZHmF0YEKXNQnhjZqijiekSM/cATF+uBX/t//GLdLpGat27MK+06MFLbC9Td6n59u/LKGHFATTh8RSPFkbLpVAK81jegrrYxmAendq8dRGJXsG4/jU6srkuUb+G08P6niNiE6XO9njUi9N3z0zRAWLxEYEYDojctVNDA6REnvslSCV1urXsMSOQg65piLKfS5LtU5nBNmPL9V2o2SGFjhQG6xPp4GmzwvSrNLxxguzG6eaf7QNEq56VcvbrPu8NhJ7LObDvMfPON9zp3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p0M7xt7JvM2lqY6mCfQi1kVY+2uoPGsY+6s2fPSRroM=;
 b=L2S0IXY1638rtDvlAAjuPuhson59ZpyCgpulzMBI/kp9ijBxRMf4+6rniVZz/bKGCYDkzXTG3NnlxOTGZZA/EGFADBvP7jrLyjepwPmyM/FjN3B0YedUL8+72EsMK+U3I8co8YLp2EOQakDCtXVRdTiSuSegl9s/aP9tYFFGHiHU70Z1yUxvv3uE8t8DZuWDcbF7bKpDxsdcK71k52mF9c1H8p+y530tOwvg81bQDbfOxlXbpDQ4nmv/6Q9OHFTixwAM9PwpYrZDc+RgTCBfWc/a4rMxM/hNOU5ETKS3cf/sKmwzSHP0AZ1H/VqC321mnXYSMeub7Gqwfv9NM9auXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p0M7xt7JvM2lqY6mCfQi1kVY+2uoPGsY+6s2fPSRroM=;
 b=ef4GWNWTmGJPgsJVaLiC5hYyMvaA+EipqUobD+o9p5BXXefxFZZdCu108QypGl+VGNwYBwVr21/7bkL/2SdNyAncy1YlVAkn/08N/vGrz68oACOGOz/K2BFZSerSsTMwrGOXxm6hkgknDwxBzntNlOWj+9nYKzfefe7YdjAd1IU=
Received: from BN9PR03CA0393.namprd03.prod.outlook.com (2603:10b6:408:111::8)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.24; Wed, 9 Jul
 2025 09:21:11 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:408:111:cafe::d6) by BN9PR03CA0393.outlook.office365.com
 (2603:10b6:408:111::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 09:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Wed, 9 Jul 2025 09:21:11 +0000
Received: from spgblr-titan-01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Jul
 2025 04:21:07 -0500
From: Nikhil Dhama <nikhil.dhama@amd.com>
To: <oliver.sang@intel.com>
CC: <akpm@linux-foundation.org>, <bharata@amd.com>,
	<huang.ying.caritas@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <mgorman@techsingularity.net>, <nikhil.dhama@amd.com>,
	<oe-lkp@lists.linux.dev>, <raghavendra.kt@amd.com>,
	<ying.huang@linux.alibaba.com>
Subject: Re: [linus:master] [mm]  c544a952ba:  netperf.Throughput_Mbps 18.9%
Date: Wed, 9 Jul 2025 14:50:46 +0530
Message-ID: <20250709092046.10428-1-nikhil.dhama@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <202507030638.d8cff1fb-lkp@intel.com>
References: <202507030638.d8cff1fb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: dd0060fd-965c-4af6-6437-08ddbec9f1f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R4R5psArLH/DTerYlpoUvEhY1EKxkH2DVYYnnMay+lWAIbqrFp27WuEOwKCM?=
 =?us-ascii?Q?OA6WeVbS6mq+SnUPNv2xh2yigrW3L6sfpxTxKXueemwns29I1TZKmcAeG/tk?=
 =?us-ascii?Q?RPBeGGcgyj8RIRgJRAIjbvh4a5xBIvndOsws1w6GWPg6Mpb1puDcC+oPeNTl?=
 =?us-ascii?Q?ku+r/x/jQz4m0U9X7tKFZuGLbg9arW1SM64iTydXBsj9Ahba60aFgZuPl32t?=
 =?us-ascii?Q?EYV7EgtI/nsktXgOlIXyDdEH/FBRJk0u1red4Xo5ag1kaHuAEMInUKMWQpNk?=
 =?us-ascii?Q?q56x9DJo30rXIHfTu7eoqPMp+MbAC9tp7BhXrQbRwOqExboTYNhKkyHIjoUh?=
 =?us-ascii?Q?5k00Nq7XnKhUoCnVbbABQvy6oz/2z3wzTMttWYgc8XJdfPXmlyWMqd5sgB/N?=
 =?us-ascii?Q?/fnuv1PRbtuKH0mPYTKnEdKNz6cOCd8uiWRuk0B8tIlZ/zrC0GDa9wpqu/Uk?=
 =?us-ascii?Q?aOhd5+yfNKXldHEo7pl1KVyMkdLf9IaB3Rm+1lLhYYk/w4vdWP/0zs5NVPYX?=
 =?us-ascii?Q?7EnyhGCHGbZlrUE6PeN4WzWhPqgEY+M/npZjVEg9mQXZB1lYihURmbmaFOps?=
 =?us-ascii?Q?CZ39fIAC8CeyH93ltYlsruXDQVYbIKQLHm6+BMBmBbPaDQH/itrTMsE1ogpp?=
 =?us-ascii?Q?xISkHibl/iSAzbVcd0seX6+BwVdPGK1qCm4Xfy2cVFNBWwLY2wZgxiXn2TM0?=
 =?us-ascii?Q?TMBjekE7U/5nCOA+YRGYaE/4yE3D0EvRYlioW+6o8BmYVnoRoZ0k+eQ+cKRc?=
 =?us-ascii?Q?AkCmI/HOtrAE6y1SWBLdERNgri98mbG7Q2ZZH6OPl5QqLn0gvvBswwhCBQnn?=
 =?us-ascii?Q?/rCGXugoZ3zdh0WXaPDy+QvJh65HTC3SHFD5b2OFJNg35H8cs6rjtnKHpdva?=
 =?us-ascii?Q?97VJ4TeJ9+uRihbwl/HdY1FvxRDmYPDcqGpLPRuOI856bpcfMGZkPB1k2C9e?=
 =?us-ascii?Q?hLwzuvVKdD6WC2DxAjr0ZoFIkTRNJsdFaIXX7FnfK91IMcl0d9Wdb8EakgFA?=
 =?us-ascii?Q?JdyAGIH0QKsgsOUUe9fvEIN2VCr9xOF+5xUzv0bC66RNBZgBLt7nz67oIXuc?=
 =?us-ascii?Q?NJFlei2CxEkx8uYSaSFWh/Bix6rk9v6/WtxUTfj0JC7vr58v5+UntFWADBl6?=
 =?us-ascii?Q?lrWHozO6AB9DfVGUdN5saBe03gjmlTYLh95GLYgPIOGFdV7k5iuq5HB5Z7Nw?=
 =?us-ascii?Q?ABQ50ldXILUmwqdhTO4/IVv5w5BKpMzA/spK48Wfb+GfdyGisxfKZhKj2asI?=
 =?us-ascii?Q?x7C03hct8fuRtSE+8umdJXIQUlhaFqVy6lrXF3s2vervnwmoIhEY1G0aRQVv?=
 =?us-ascii?Q?SJNvb/CIOy7JSqFcuM2xOUt7K0m8dDhwlzPX0o9z84pc9laR3/kv57k0fdb1?=
 =?us-ascii?Q?OEO2GJNBdD0ekSlTjBExslBb1VnxA3wQ2WvigABIQVt7+/dWobhOpz0yj8UF?=
 =?us-ascii?Q?YrOCrS/QKHerjSNXEEOd2kVVKTUdI9etWrJ0Q+Hxao94zsnor1CX2/Ue7P9L?=
 =?us-ascii?Q?j+PiYSHgT/34NYQ=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 09:21:11.2867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0060fd-965c-4af6-6437-08ddbec9f1f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

Hi,

On 7/3/2025 11:19 AM, kernel test robot wrote:
>
> Hello,
>
>
> we reported
> "[linus:master] [mm]  c544a952ba:  vm-scalability.throughput 33.3% improvement"
> in
> https://lore.kernel.org/all/202506121415.eeceda1d-lkp@intel.com/
>
> now we captured a netperf regression on a Core machine.
>
> we don't have enough knowledge if this is a tradeoff, just make out this report
> FYI.
>
>
> kernel test robot noticed a 18.9% regression of netperf.Throughput_Mbps on:
>

[...]

> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250703/202507030638.d8cff1fb-lkp@intel.com

I tried reproducing this issue using the shared kernel config,
On a 192 cores AMD EPYC server with 768G memory, 
I am getting following score (normalised wrt v6.15 vanilla):

                      netperf UDP_STREAM
                      ------------------       
v6.15 vanilla                 	     100
v6.15 with (c544a952ba)          100.085



> commit: c544a952ba61b1a025455098033c17e0573ab085 ("mm: pcp: increase pcp->free_count threshold to trigger free_high")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>
> [still regression on linus/master      66701750d5565c574af42bef0b789ce0203e3071]
> [still regression on linux-next/master 3f804361f3b9af33e00b90ec9cb5afcc96831e60]
>
> testcase: netperf
> config: x86_64-rhel-9.4
> compiler: gcc-12
> test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory
> parameters:
>
>         ip: ipv4
>         runtime: 300s
>         nr_threads: 1
>         cluster: cs-localhost
>         test: UDP_STREAM
>         cpufreq_governor: performance

To match thread count and memory, On the same machine I disabled all cpus
keeping only 4 of them enabled, and limited memory to 32G.

with this configuration, I am getting the following score:

                      netperf UDP_STREAM
                      ------------------
v6.15 vanilla                        100
v6.15 with (c544a952ba)              154

I am not able to repoduce the issue, am I missing something which is required to reproduce?

Thanks,
Nikhil

