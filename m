Return-Path: <linux-kernel+bounces-738673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8772DB0BBC4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28E381897247
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9B11E833C;
	Mon, 21 Jul 2025 04:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c+QXB/FH"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963A4469D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753072104; cv=fail; b=XSBpDNlqKQRypf/D8EH4+WnWZeJbaOg1mYa640f/nG69BRP0cSVi3Y15WivdXiunHEHsG94+DXu5e1GNvKjTIjnW9BY5f2jf+6BVRIWTfyQE2B+Y13RiUkpMouCFHA96mHe4LVQQgKmMc2hAqR+mDaduRtW7jfY3dmH2pZb9MzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753072104; c=relaxed/simple;
	bh=V2mISRvPlm8hVy4yq+9Nuaw0PxA+jzsjWSRLc8GHzrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=V7AzDoo42CnkUkYEJvNkFzX0k803S4aLwOb7GpgyfCpv7etJ5dzOty9JrQ1YMkNrzEXwd0Z55gmQ0YrnwaEBg1zxe9ajCfweZUihusS5NrQsHn+3crpTuFOnjZzJdSKeuO8BqEGi6GbNhXFNb/Af5UCryY/06gN8Z/u3owXLUx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c+QXB/FH; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=brRnd44FeZeevf+IMG+zQ2W6LjSlzjuV7RKaxwmGBceb1yywJogjh5iKUxE2dgCRIVlaD5+/Dp/Kg4ksuMF3wvnarpwBtgfANRWDigCW5rVmYXkNSt5MjAyEXFyXhF7sAjvIQCMTRRxah83CQO/GmUc7oYYrnl8U6nEtGt7L1iwmp4gZkhMeLYH/gdzAKVYuq8zvLYzrQjosBut66BB6pz1tHBijRbnTLzIO4u0B0e20ih/tj2Xk+SHEVK3K5mwtX8WxltdBXxGUAwWdmnWAmkPyti2g9mUxb5wuWEcGFltfjVXsJLPmCKpDUpDlaxs2rz/mpK0lP6lSVluiY3dhmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Qc/y5/8vRKrUjlaGLbFiDh7AwuOQFIVN5MRO+kEgjk=;
 b=EdDq3Q3wO/cZgtW5kOJ6JCiAG1gDzFvfIZ/KTK6DS9Z4snxtZpxDZPNPeiVOyDOoJnnVS+CikU5hj52XW5wUxYupHdy1l0nOLCsIYZipDQmlsPLj1B90/h7vqXnqY9mHbcW8B2pIqULoHfF2wAWDyC+GemGCFeeigknuZGFRQzFa02+FijxS3umapwxdBEwFHlsIYONLnF9kM3aFpX8zSxQXkQ9oFrATNVs1WgjHY4hajhEjphNXmyf0EDOB4YowF1+mMA6IxHyQUQ347kToZfkQYhzscl5su7XIy8QtNQcu0qui+IFH9jkI9gyYCfBZiUQrOUPSWnVuastUHqyBKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Qc/y5/8vRKrUjlaGLbFiDh7AwuOQFIVN5MRO+kEgjk=;
 b=c+QXB/FHng7v+HCAvo4hhickhjKSMNaXBmNFdd3mSYcemX5Bkh43PWQbZR/W2ZiWioyLi+eYp2VBFvDbtnI5zNY9LQ6tNX6hpzsvEZWVuCZgjv9drhe9SFyDMcIkOAWtwW0jW/atM4vGNqOD7170GUOAzYPjDE6MPvEZZpCQCfY=
Received: from MW4PR04CA0168.namprd04.prod.outlook.com (2603:10b6:303:85::23)
 by SN7PR12MB6742.namprd12.prod.outlook.com (2603:10b6:806:26e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 21 Jul
 2025 04:28:18 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::71) by MW4PR04CA0168.outlook.office365.com
 (2603:10b6:303:85::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Mon,
 21 Jul 2025 04:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8989.1 via Frontend Transport; Mon, 21 Jul 2025 04:28:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 20 Jul
 2025 23:28:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 20 Jul
 2025 23:28:16 -0500
Received: from [172.31.184.125] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 20 Jul 2025 23:28:13 -0500
Message-ID: <e4eb39e8-0391-4152-9e25-daf4b47bfc02@amd.com>
Date: Mon, 21 Jul 2025 09:58:12 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] sched/fair: Use sched_domain_span() for
 topology_span_sane()
To: Leon Romanovsky <leon@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Valentin Schneider <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>, Steve Wahl <steve.wahl@hpe.com>, "Borislav
 Petkov" <bp@alien8.de>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Steven
 Rostedt" <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>
References: <20250709161917.14298-1-kprateek.nayak@amd.com>
 <20250720104136.GI402218@unreal>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20250720104136.GI402218@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|SN7PR12MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 28570672-34dc-4323-5d46-08ddc80f043f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|30052699003|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEVSRC8rSmtIZ1NIUTVEenNoN25TcDB1Vm41a1BtdnBqai9xME9MR3NSQjRk?=
 =?utf-8?B?ZXpyMjJkZ2VKcTRaZ0ZxZFZOMVhwUEo1OTNzc2R4anFXT2VBZ0VpWDZ0b0JH?=
 =?utf-8?B?aWMwRDR1clU5TGZIaVErVFU1UEh6Mjd4QUUvZU1nRkpObnlJSG1SamtjRnFI?=
 =?utf-8?B?eHVlcldyTFdUUlI1bE9scmR2alp5d20yNGY2UjFXa1UvQWZXN1pOd0pSaU85?=
 =?utf-8?B?dWh4eENvSUxuZ2FXUTN2VWo5Y1ZrVHdSRlRaWW04dEw3aFFHdVJ5RFBuWXBC?=
 =?utf-8?B?cXJxKzh0STNXdndMc2FkMHlLMEFoaXRKTk5LeFVKb0NpQWg5NUlHQ2xLZE9M?=
 =?utf-8?B?ekt4dlk5S2t3b2gxOUM4WHZmWnpQRnNsYUJ0RGxyVEZkcFJwRUJpMXNBZGd0?=
 =?utf-8?B?WTlqWDRWV2N2L0VXVHJNSWxQQStvR3hwb21lVUk2MHFiZmx5MHUrTjBuMnZa?=
 =?utf-8?B?Tkd1ZjZORTFmeWJEN1o5eVgvUXc4WlRIQWRqZ1ZuM0xNMkhna2V1VUx3d0tV?=
 =?utf-8?B?N2ZDd2gxNUZyRDd0Z2dpWWM4cE16eG5nZTBsT0Y1NlM3cjMyM1VKM2luNnNV?=
 =?utf-8?B?ZlpHWkV2RXFBdWNpMVZETXdXWVhrYnMrL21ERGZwdkJqZlUrdGVJYTQ4VDJt?=
 =?utf-8?B?RFMzK1R5UEp1VHE4SzZrZFp2Wml6KzVLS2dMUE5VQ0JBeWFjTEdkRHM3UTZx?=
 =?utf-8?B?cHErSlpXVDcxbHNrWEhYMVFxOEJNMDBLdEszdWZ2TW5RZ01xeE5qb3FvVHht?=
 =?utf-8?B?NXdYdzN5NEdkYUNPWHlBMjJrNDRDTUhIZ003bUVjb3A5YjhzWVN3MzlTSWpS?=
 =?utf-8?B?NlREVHp0ZnJRd2ZXUnVKY3c5bm1lTzBtNmlWQkpXWExqS1FMUWh0WTVEeDRr?=
 =?utf-8?B?cHNyWXdlbm5WN3V1M2NOSnlmWVNmcVdxRmt3V1NrSzVwT29RUGdHaVVoaFNB?=
 =?utf-8?B?NGNQVS94Q256RHhJUVBrM3o3dFFFd3VVTGt2ZEQ3NU5zM3BndSt1WWp3N0Fj?=
 =?utf-8?B?WmpjMDdsaDByUWJaU2xZbXZ4SHlpeDVvRFEraGNmV3E4aGpaWWxIT1Uyb0dj?=
 =?utf-8?B?MkdDaHVsODRTT3VyVU5aS0tIRTZpNFMwb1ZFZmZxaThXNWtXZzF2SlNGRzZi?=
 =?utf-8?B?MGtlcU5DR3FaNVhOaFVHRHZqNnlZQ3dVTDE2NSs2ZG00aHBDTHhlV042cWgx?=
 =?utf-8?B?RFVISFF6SzBsNVRLQ0VmRGJCa1QzLzAzWEs2eG1tNG0zNDFWU1JUSVY4TndO?=
 =?utf-8?B?WDJITTJqZ1hSWXBNanpYVnZRd05EbTJvSWN6T1psRTBhem1CWXJmZ1dveGlq?=
 =?utf-8?B?cU5uUFpjT2hpdmhacUpXWlpNVjUrRnNZK2pKNjUxcy9ka2g4a2dzWHlUcktS?=
 =?utf-8?B?ZEFISXJOZmZPa0FEeFZrb0dPZzhMMlZUVmRDbVJ0UkRYSDZnMWFIYTFDbDV1?=
 =?utf-8?B?VDlpRXpNYmxPR1FUeXRFTXhIQnZZM1F5T3BBaUsrTzhJdjJ5Y1EzYmJKVDly?=
 =?utf-8?B?VVk2YzlXZGhyeWxTd1ZTd1dpQ0pNMFd2VmtZUXZIcmg4RHd2cTZGeldhTU1r?=
 =?utf-8?B?Z0NOWjBSOWpYdGtiZUc5WFdDUWp1QXoydDg5QXBtQlp0YmVpWEE4TnVQS1g5?=
 =?utf-8?B?Uzc2N0VkYWZ3N1J5YVRPY0lzVXRnRVYyWHlPbFU1WXY1Y09mQW4rMDZ3ZGNK?=
 =?utf-8?B?d3B1WmM4ODlVTS9NenJESkNSOXlVY0RRRXRITjNxNEFBcXNZOHBLdDRMVGIr?=
 =?utf-8?B?U3kyaVVFOXp0N1FtVUFTRjN0UUpaRnJGeXQ4cVliZ2U1ZkpjTEU1aVhub3cw?=
 =?utf-8?B?Sldzdm02RjVJOXY1WmkxejR4QTJZZXJwK3M1cVlJbG80YmhzUWw3dWliNFVK?=
 =?utf-8?B?N2VyY05rWTNCUXZDTVlmSUtqSU5hYzNUN25JMnh4M1k1RVEyeTZDT21YWk1E?=
 =?utf-8?B?TjZ4UnBFMmIzamJkaitRQ1c4TWJOREZIampjbGVkam84Mi91TGtFSGl4MnM1?=
 =?utf-8?B?MzBtTVlId01QYWhweEo0NFNWbDllOEhRTkh5eUZlSjZTS1ZqSUlpekwySVh4?=
 =?utf-8?B?VlU2Z3dzUzJwU3c4L3ZRZTV4UmZ3VkNibVduUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(30052699003)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 04:28:17.6451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28570672-34dc-4323-5d46-08ddc80f043f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6742

Hello Leon,

On 7/20/2025 4:11 PM, Leon Romanovsky wrote:
> On Wed, Jul 09, 2025 at 04:19:17PM +0000, K Prateek Nayak wrote:
>> Leon noted a topology_span_sane() warning in their guest deployment
>> starting from v6.16-rc1 [1]. Debug that followed pointed to the
>> tl->mask() for the NODE domain being incorrectly resolved to that of the
>> highest NUMA domain.
>>
>> tl->mask() for NODE is set to the sd_numa_mask() which depends on the
>> global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
>> set to the "tl->numa_level" during tl traversal in build_sched_domains()
>> calling sd_init() but was not reset before topology_span_sane().
>>
>> Since "tl->numa_level" still reflected the old value from
>> build_sched_domains(), topology_span_sane() for the NODE domain trips
>> when the span of the last NUMA domain overlaps.
>>
>> Instead of replicating the "sched_domains_curr_level" hack, Valentin
>> suggested using the spans from the sched_domain objects constructed
>> during build_sched_domains() which can also catch overlaps when the
>> domain spans are fixed up by build_sched_domain().
>>
>> Since build_sched_domain() is skipped when tl->mask() of a child domain
>> already covers the entire cpumap, skip the domains that have an empty
>> span.
>>
>> The original warning was reproducible on the following NUMA topology
>> reported by Leon:
>>
>>     $ sudo numactl -H
>>     available: 5 nodes (0-4)
>>     node 0 cpus: 0 1
>>     node 0 size: 2927 MB
>>     node 0 free: 1603 MB
>>     node 1 cpus: 2 3
>>     node 1 size: 3023 MB
>>     node 1 free: 3008 MB
>>     node 2 cpus: 4 5
>>     node 2 size: 3023 MB
>>     node 2 free: 3007 MB
>>     node 3 cpus: 6 7
>>     node 3 size: 3023 MB
>>     node 3 free: 3002 MB
>>     node 4 cpus: 8 9
>>     node 4 size: 3022 MB
>>     node 4 free: 2718 MB
>>     node distances:
>>     node   0   1   2   3   4
>>       0:  10  39  38  37  36
>>       1:  39  10  38  37  36
>>       2:  38  38  10  37  36
>>       3:  37  37  37  10  36
>>       4:  36  36  36  36  10
>>
>> The above topology can be mimicked using the following QEMU cmd that was
>> used to reproduce the warning and test the fix:
>>
>>      sudo qemu-system-x86_64 -enable-kvm -cpu host \
>>      -m 20G -smp cpus=10,sockets=10 -machine q35 \
>>      -object memory-backend-ram,size=4G,id=m0 \
>>      -object memory-backend-ram,size=4G,id=m1 \
>>      -object memory-backend-ram,size=4G,id=m2 \
>>      -object memory-backend-ram,size=4G,id=m3 \
>>      -object memory-backend-ram,size=4G,id=m4 \
>>      -numa node,cpus=0-1,memdev=m0,nodeid=0 \
>>      -numa node,cpus=2-3,memdev=m1,nodeid=1 \
>>      -numa node,cpus=4-5,memdev=m2,nodeid=2 \
>>      -numa node,cpus=6-7,memdev=m3,nodeid=3 \
>>      -numa node,cpus=8-9,memdev=m4,nodeid=4 \
>>      -numa dist,src=0,dst=1,val=39 \
>>      -numa dist,src=0,dst=2,val=38 \
>>      -numa dist,src=0,dst=3,val=37 \
>>      -numa dist,src=0,dst=4,val=36 \
>>      -numa dist,src=1,dst=0,val=39 \
>>      -numa dist,src=1,dst=2,val=38 \
>>      -numa dist,src=1,dst=3,val=37 \
>>      -numa dist,src=1,dst=4,val=36 \
>>      -numa dist,src=2,dst=0,val=38 \
>>      -numa dist,src=2,dst=1,val=38 \
>>      -numa dist,src=2,dst=3,val=37 \
>>      -numa dist,src=2,dst=4,val=36 \
>>      -numa dist,src=3,dst=0,val=37 \
>>      -numa dist,src=3,dst=1,val=37 \
>>      -numa dist,src=3,dst=2,val=37 \
>>      -numa dist,src=3,dst=4,val=36 \
>>      -numa dist,src=4,dst=0,val=36 \
>>      -numa dist,src=4,dst=1,val=36 \
>>      -numa dist,src=4,dst=2,val=36 \
>>      -numa dist,src=4,dst=3,val=36 \
>>      ...
>>
>> Suggested-by: Valentin Schneider <vschneid@redhat.com>
>> Reported-by: Leon Romanovsky <leon@kernel.org>
>> Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
>> Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (partially) overlap") # ce29a7da84cd, f55dac1dafb3
>> Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
>> Tested-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> ---
>> Changes are based on tip:sched/urgent at commit fc975cfb3639
>> ("sched/deadline: Fix dl_server runtime calculation formula")
> 
> Was this patch picked?

Not yet. I think Peter was planning to pick it up as v6.17 material.

P.S. The latest version v5 can be found at
https://lore.kernel.org/lkml/20250715040824.893-1-kprateek.nayak@amd.com/
It is basically v4 but rebased on top of tip:sched/core to resolve
conflicts with a recent cleanup.

> 
> Thanks,
> Tested-by: Leon Romanovsky <leon@kernel.org>

Thanks a ton!

-- 
Thanks and Regards,
Prateek


