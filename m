Return-Path: <linux-kernel+bounces-793773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E93B3D805
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3607F176050
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CED21ABD7;
	Mon,  1 Sep 2025 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NMCzfXye"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC5F21882F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756699077; cv=fail; b=d3+VWWkMUY8/jH01kYS/WaaO1p3FEa/E1TegLcFCgCwtEPOBa3a1vr7wCyt96aKcAGovNQnK+wpyWa23Xrl64ob8oTsm6XKynpyZnzBc5Ax+zcVEBC4qLd5plu0vi0k4gkisQATm3y1kyIDsUyLgbqiCKgcz0ayyyL9KHc/I/ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756699077; c=relaxed/simple;
	bh=mtaYeCppi+wgtmV+PkgkMkyrcp/fV2D4zFbfghJxxhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=b0T0LDn3jBbu2VV7+64KnJ2kutmnPQlUlAv02lwDO/mjJ+6GWPi6nQ2e8gPW211Vi6pXu/zGlljzTmuAv4WM3kI+Awy3YUM6UOx9lhALQmWm8PGmqT/PMShgxQMq5WkizyLLyZNXNNA/nzZacbMJ5mQVhisazM76ZJTGpcndTdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NMCzfXye; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcHqf7c5/iTybmePj2h71D2/e0WWQX1OuEXCmCzXlYBG5gB2yar8Xe7d+/ISSKdx3LJltWZLckCj3tksf7yznjMvHGxqeeydDb/kjSU7ZsdxBTHUe6cy1yAJpNXkmKUr+BOr4Q3DyktVaipKZ3BloC6mIwVErt/r2okWacGrZHeLeX0YlshJNRZ3mECAVcsiqrng7IUeLvU+btRdH+IkBzK2TJ8ojZ7k3C9/ti8uHR81goOs1tapi7EHQ3kSPN1kU8mqw0W57LxcatOtX/lVXFSTS0J1lGceAqOBIOrLdYDyy9G6skwLJ7jKEa1u2j270CQyz/GtUAZyOTRZruTbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmhRopOKpnFAe3iYEIKT33twPrA3BFUFHMaCueEN9Ws=;
 b=GIBbe8yupFUFzRvHFN2q524jAml0dy5XY8gFed7sbfds0lrDM/y9nEnS69Zq28424YaRlHMTiIV4GCj2rsXQ9CoO9Ol5fu7rMWYwYynLVZNtitngsNDflAADz/fmkik5A31I3p+VHigbPUyCeQ2nXRSpWZTEwl/y+TjyZ3HCsTMxvipSB+iOG3OhWpt8tvnAkhEYjQVtaysCzDRfmRKV2O1nfnUlp3qOj68ywF2BFTX1wAuxgE5+R/CJh0wvlMvV1COP4iv1sOjqKuwkvhYk0FLCn5PYd4mGinoP2zNg7VZAlx5tZtMN0jTA/1WB2DZEdPcoO7pV0ArSuZfP3mjE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmhRopOKpnFAe3iYEIKT33twPrA3BFUFHMaCueEN9Ws=;
 b=NMCzfXyeY7dOb33+HxKjo+briE5cbtQc0qDW0WQocgWfudAIAfW/1TlCjSYTBqJ+vGJ2VO9JQp63QGkOB6uI55fEhVLr4CbFjKkqb9kUnITJi+cbz9GHeLv82X9DQblAEKhAO9ERGVL9J3ke1oLgyHOPUgw6T92uDkz3Ef71Rxo=
Received: from BLAPR03CA0119.namprd03.prod.outlook.com (2603:10b6:208:32a::34)
 by IA1PR12MB6283.namprd12.prod.outlook.com (2603:10b6:208:3e5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Mon, 1 Sep
 2025 03:57:51 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::ef) by BLAPR03CA0119.outlook.office365.com
 (2603:10b6:208:32a::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.26 via Frontend Transport; Mon,
 1 Sep 2025 03:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 03:57:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 31 Aug
 2025 22:57:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Sun, 31 Aug
 2025 20:57:50 -0700
Received: from [10.136.36.137] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 31 Aug 2025 22:57:47 -0500
Message-ID: <7747fd63-0677-4485-862f-5d794f9e6a85@amd.com>
Date: Mon, 1 Sep 2025 09:27:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/8] powerpc/smp: Introduce CONFIG_SCHED_MC to guard MC
 scheduling bits
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>
CC: Peter Zijlstra <peterz@infradead.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>, Ricardo Neri
	<ricardo.neri-calderon@linux.intel.com>, Tim Chen
	<tim.c.chen@linux.intel.com>, Vinicius Costa Gomes
	<vinicius.gomes@intel.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20250826041319.1284-1-kprateek.nayak@amd.com>
 <20250826041319.1284-5-kprateek.nayak@amd.com>
 <5f1a9ed6-b551-48b9-8c62-8ef0f2bd2fca@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <5f1a9ed6-b551-48b9-8c62-8ef0f2bd2fca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|IA1PR12MB6283:EE_
X-MS-Office365-Filtering-Correlation-Id: f569f11f-5118-4062-a4e9-08dde90bb90c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Mzd1ZDEwc1dKcGNuWnAzYVRqYXhiMWVGYjJ1c29mczZxelFTM3VQQU9OelpQ?=
 =?utf-8?B?Y1FSMVNEQkxzaTFCNURhMktESUNzMUlhMVNiU3E4L3dQKzJuMUZWUERoc1Iz?=
 =?utf-8?B?RVl5QU9lYkErSWc4VUM5YkNaeW9yM0kvZ1pnQXBLc0RQdWpjY1RINFYwYi9H?=
 =?utf-8?B?dHRWNnV4VmdOY0dtUnBHaUdtcVpiM2R3TURTem9rbXNsN2UvdnFjVzh5Z3Y5?=
 =?utf-8?B?VGU4RHJZcGM5alBwK3VLZVlTSTJrYXFJbWZwRlg0YlozUTAvMHJ1a01OZWlI?=
 =?utf-8?B?RzBQblFKSVEwYjl2WFdrMU1QanBzcElGRlpCTGhMQjNWRkFBcXRPUUQ2dVFh?=
 =?utf-8?B?Z2dyZzlsZ21Oa1RPTzJKMDdJZVZ2RFBWRWExQ0U1UGN0MDBBcGNtbysyMlFQ?=
 =?utf-8?B?L1ZJb1hQSlVmR3FvSm9IZjBHaEtjcUpSd3lkK3FYR21UWUhxREZIUFk5dUNw?=
 =?utf-8?B?V3J5UmFsWjY3Qlp2QzJwb0NaREZCOFg5MUJsSXh1QlVFNG9mMWtHSVlIODRZ?=
 =?utf-8?B?QTBzTjlHZkJ0bUdtQnV6ZGoyd29NeEphYWdNU2YzQjdrMG9UMGdiRXNxZXR3?=
 =?utf-8?B?a0dUZnl3TjJCVno1OUljZHpLdUVaT2FseGRVSjBpYjgvVld6dGxLRHZYOG8z?=
 =?utf-8?B?OUQrV2dLKzBtMkV4ZU1CZElSLy9ucllibEhCOFNmeGdhbUlrL09aM09DcHAw?=
 =?utf-8?B?RUhOaXN4bFFBVHpoajdGY3UyWVd3Q1U3ZTEwZmxLWnNBUXc3WEZud0djbUlw?=
 =?utf-8?B?Um1sTk5ZQnQ5TGlidWJhclJBb0dvK0dSOC9naHhXQnNZd2NlUjFzZXBhc2ZM?=
 =?utf-8?B?UFpmbndwRVNQRVJLMDc0UHBRdFFjK0tqRjJndXNSdXBIUlc2TFF1MFp6eFA4?=
 =?utf-8?B?ZGNXY295Y3JYcDRUUDhqYmJBdnd2cjR1VzF6bkMxaEJvbDgxZXd3R1I4VUh4?=
 =?utf-8?B?enlRMm92RnIrZEVYZjhHQ3J0Q1BsSTdDcm11aExsSkJJL09keldQZTJ4dW9M?=
 =?utf-8?B?R0h1Z093YzdJbTdnOE1Zbk41aFY5Z3JBSkFCbDIydWt3Y083eUx1RFB4UUNV?=
 =?utf-8?B?YW95aTFQellOU21MWmRvMTRPeEtLUzZNZ3lNTUx0YWRqNmlWZVd3ZjBIWkxk?=
 =?utf-8?B?T1pWTjdlVTBBVktGWFdZWkVMVVcvNU9UYk5ZS0FBa0lSWXlHK1ZSNnRZSFQ4?=
 =?utf-8?B?dWswZHkrM0V6bDRwM0VPbEMyR21hNWJMMzVRWkMxakNuZ1J5WHdEbjRUZTBv?=
 =?utf-8?B?MjJ1UGRNSmNJVGQwMnN5MTJaMjA0elE5SEdwTjNNeE8yTnpmZlVESS9ycmRP?=
 =?utf-8?B?Skk4aHBaMFcvNkcwdFluOWdMdkFxWFBaTGhySGZodTZFaUE2MlozMWltWUo1?=
 =?utf-8?B?Rm5aN3hiODRGcjNNSnJWa1pueVkyeUloU1E1SURrMWF6WWs0cDRwakdlZmxV?=
 =?utf-8?B?MTA1UisyQ3MrN2tGcGgycVdIODBuRm9yRFFYWDlUcGc1RlpJZ0cvUGlEeGRE?=
 =?utf-8?B?K2tYdHJkY1JCSmxhRWZhY0dQdkxHTDBXa3gyblcyK2M3aDRrQmhrOVp3amJJ?=
 =?utf-8?B?K1lNd2dkeFNiWXJVM1AwUi9jblhHWC9xaWtWOU0wdFpiUHN0SWwrL3o1aUh6?=
 =?utf-8?B?Ym9XWjVwUXcxWHdESWpXWVBpNlZ6YTlCQnJOTW83eEZSd2E5V2NidXcxcURB?=
 =?utf-8?B?cjcwc2JLQVNxY1BWVTJDQVRjeVZteUlwQ05ac3QzbnJyQ2lkbWJ3cmZMaWph?=
 =?utf-8?B?S2wrNXRuUExHYkM4SkRqSTBPQ1lrWHV0eUt5Yldsa1FUOTdSNGxjUmdpbkxx?=
 =?utf-8?B?WGVQcExkRVhPRk5mZmp0MEF2RDNsekdsazJGUVF0YzArcjFqWVBteDR0NjI3?=
 =?utf-8?B?MXRUR0VURkdRQ0FTS1FhcVFraS94MEhLd3BwanUwMThndDlGaTZQL1FTM2U0?=
 =?utf-8?B?VHRZeTAxeTVKSFZTdkFnT3FVR1RkUHc1ZCtLaXhkQjdkTnZRM3dUNCtod1lC?=
 =?utf-8?B?VnBReVR0WVM4VzJKY0ZFM01UUjBDaGJDb2dzYVdlNkttYi9JQVp0L0dhYThS?=
 =?utf-8?Q?gC4a6E?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:57:51.4568
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f569f11f-5118-4062-a4e9-08dde90bb90c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6283

(Trimming the cc to kernel/sched/ folks)

On 8/26/2025 2:57 PM, Shrikanth Hegde wrote:
> 
> 
> On 8/26/25 9:43 AM, K Prateek Nayak wrote:
>> PowerPC enables the MC scheduling domain by default on systems with
>> coregroup support without having a SCHED_MC config in Kconfig.
>>
>> The scheduler uses CONFIG_SCHED_MC to introduce the MC domain in the
>> default topology (core) and to optimize the default CPU selection
>> routine (sched-ext).
> 
> Curious to know if sched_ext usage. i see below code.
> 
> if (static_branch_maybe(CONFIG_SCHED_MC, &scx_selcpu_topo_llc))
> 
> scx_selcpu_topo_llc = true if there is sd_llc. One can have llc domain without MC domain.
> I am wondering whats the reason behind the clubbing.

Seems to be an artifact carried forward since commit dfa4ed29b18c
("sched_ext: Introduce LLC awareness to the default idle selection
policy")

The commit 860a45219bce ("sched_ext: Introduce NUMA awareness to the
default idle selection policy") continued to build on top of that except
that it was fine to put the NUMA bits behind CONFIG_NUMA check since
topology.c only adds SD_NUMA under those circumstances but sd_llc is
just the highest SD_SHARE_LLC domain and shouldn't really depend on
CONFIG_SCHED_MC.

The ext part already has a check for llc_numa_mismatch() to only
enable "scx_selcpu_topo_numa" when llc and NUMA boundaries don't
overlap so I think that dependency on CONFIG_SCHED_MC can be safely
removed.

-- 
Thanks and Regards,
Prateek


