Return-Path: <linux-kernel+bounces-880569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE770C2619B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F18C585E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 16:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CA034CFDF;
	Fri, 31 Oct 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pDNNfQ97"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011060.outbound.protection.outlook.com [52.101.52.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960552FB993
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761926848; cv=fail; b=kc6IFNgz6tHmRZN6Wnfzkl8wQ8/v1I91a/6WiC8f0kbmuQnERUaeU4Yokq+gTaXpXumyaF+P48/GWgwKxQtXDfD85B8kmAojxEhOTCULgG3KHElqR0i6cgQb+N/6JHIUilXGhIDj+gBLJ0ZMGgZAK7ZaqzpLCsaEKSnLq0B22hM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761926848; c=relaxed/simple;
	bh=UDbwIvPbuv3i8b7afCGL2fx3xlJOAtweCHEAumfJdIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=u3tDArD58txYqeEhQe+1atJRKGEmPPSvOB9HlZ2DufIBuqoO9WWNWxrFlswMwCKPZFH4nGahl2mCMhG25+j8wQCw6i7H+VdDWTlsftR0wA3GkxMJF2t+w1mAX8I+3lVV9iBczLE5mk++/nx4oWlpehqYL6KIrbaCvTze9BlWKzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pDNNfQ97; arc=fail smtp.client-ip=52.101.52.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvsU5TVmETB+1xwEm7B3d34KoW0NQx0GO03+ZWHbo3BwhqBMR5FQso2Fd9XYJLFz6KUtMcapE75FQrOMhOU9rlbG4eizJ8551h2nsedCXh4ynnS7om3EgHMbB9SgdspKVKiu+OP4aDUrGQeuK7GHuPMUWgPeRloZTVA+F6VAUlkgHkkn6BJJWICWb19DBbh8Fyt/oaIMPC03Hlwal1cAQj9hLXz+aT/MrtM4KN3uGUNUoM2QmpNyAHAHZcYBx24sSSNgkFSG8Doj6NM4LtPnQ6vyHzshh22VyhBp1zEKj63E5oWcghy45mk6pCjAOg4/X8wUUd9UgQwypoYMTiww0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJEZixQBfcT+mmyhngYpRpIlEC9ZfwLEu0+gz23E0vM=;
 b=AehhrFsCK75zW4sFDO+nR9wSKod/mAdEubyuTCnEKpJNgMDhGuk3KwBT5kin+Gpx83oQYhGTEgxzTU+m/SKJqgPTIqiwZfSCRalTzMAQmnovWvWYK4K7V2/kbf55uHL3UurbPZ74n1unHynDCBo/+9DDiuEJOhsfDUT+PnQxMglrbSOcIQRlExPvc+UB/JdS/wPQ1lWmh8wUe5tjBtV7nw1zIzxBYcFeaeHdyV/zMEGFW10eZfkEMawbz3jPi9w9kkjWoLCAx0PUQ57VP+N9M7vW6SGRqZ0NR0o3EDTkDnNimN+EHLVAIXrhMvrvTbH8K2rogaPRaVpz3rZ1BEj9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJEZixQBfcT+mmyhngYpRpIlEC9ZfwLEu0+gz23E0vM=;
 b=pDNNfQ97VcaIcL+0/3RU3p+jfmbfpAZG+2RUZxLxo5AVe57IBipfXqSQf/p71ukEXV+NYtRMIWIR/VN2we6K2I92h6xU7CFY9iJhIOrhkiIDxYgZGJOK6cbLVYOeEWmM9WRkh1UdZ6RWH8ho9c6/nseJc/rWGf72Y2QEd0YfIsQ=
Received: from BN9PR03CA0937.namprd03.prod.outlook.com (2603:10b6:408:108::12)
 by CYYPR12MB9015.namprd12.prod.outlook.com (2603:10b6:930:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 16:07:23 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::1b) by BN9PR03CA0937.outlook.office365.com
 (2603:10b6:408:108::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Fri,
 31 Oct 2025 16:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Fri, 31 Oct 2025 16:07:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 31 Oct
 2025 09:07:09 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Oct
 2025 11:06:40 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 31 Oct 2025 09:06:39 -0700
Message-ID: <011ea4a8-3947-67a0-d132-816a2224360e@amd.com>
Date: Fri, 31 Oct 2025 09:06:39 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Fix incorrect command state for timed
 out job
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
	<quic_jhugo@quicinc.com>, <maciej.falkowski@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20251029193423.2430463-1-lizhi.hou@amd.com>
 <8324911f-ff49-457c-9021-a860d2d4c0c7@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <8324911f-ff49-457c-9021-a860d2d4c0c7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CYYPR12MB9015:EE_
X-MS-Office365-Filtering-Correlation-Id: 58dff7cc-72c3-43a7-9455-08de18979395
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWFDS2tqenJhTC9BdUxFb2RTNC8xOHBwbUVyY1NBOUdrUzZSamxYWG94Q0RU?=
 =?utf-8?B?YzNPU1RPenNNbzB2UnhldWlDSUswWFpwbGFHVXhRM3VyZ2NHb2VFNXhJdE9u?=
 =?utf-8?B?L1ArSXRWT282K3RDV2pWYm0wRWVDdUUyREdJbDlOOTdlK0FOem1LQWxWZi8v?=
 =?utf-8?B?bEx0WE5PU0lQdnB0ZGZBYmFzTUJEaC8zWERCeFZ3SDRRN2NadEtRYkNlT1Nw?=
 =?utf-8?B?ZWxIa2g3bnhaa2NuQ2VwYzZNa0NDR3hMWUJZQmREUnBaMVJyLzZ6eE5GcFdV?=
 =?utf-8?B?N3NmODhDcWUyKzVDUFRWU0x4Q3dTWFhINXFUMlB5dUQwZmxQR2RjOURsNFIr?=
 =?utf-8?B?bEZhL21pWVRFM3pGMWJMbmpQUmhSZ1B4aHYvLzdFbmRWNHZ6dGdtT3Jja1Fo?=
 =?utf-8?B?empUMVJjajVNUHNHRkdkMmp5VUM2SWhsMDJDYURnZE1QWmYyNVZvTlZQMXk5?=
 =?utf-8?B?ZkZvb0tGL3I4YWJFb210OU5INWhBS0N4TEhESjVKSDZXMlJkcW5sbER1clF3?=
 =?utf-8?B?aDh4WGVCRUxxOVE5MUtSVUhpa1hBaFdJNXVweGVNdXRQT0YzUVNXU29kZ3cx?=
 =?utf-8?B?NmQxczFORmpGd1M3MkRvdW9lSlZGZ1E2TU1MdC9ycVpVaVJSd3FIVUpCT3ZN?=
 =?utf-8?B?R0g2aUJmb1h5QTNOQnArK2dMZEpQWDg1SVE3SXd5K1p0TE5CeGZzd0pXY1dT?=
 =?utf-8?B?UlZ1OTE0NnRPd3lMTCthZTdBaHZDMWZPL0hTVWg0dnpiUXFXbEI1ZTBQdlFH?=
 =?utf-8?B?RkJ5bVNPcjJuVTlteFpCdzNBYko1Qkd0SVhzNEg0QkZiM0hWa0pKSU9XeWJY?=
 =?utf-8?B?cnJvTE90Y0hTV2NSNVVhUFJtTVNQQmZGeVl2ZDdSSUZCQUh3ZnU1Q1NISWYv?=
 =?utf-8?B?eExCVzV6ZzJZSk9VditHMythaWp1amd2L2IvZXZsbFZFRk01aDZhZWJUNjB2?=
 =?utf-8?B?ZjU2MU84ZzhZbE9jSk93TWt6d1VXUll4Rksyck5kNWZndEcxRWc1UXFEZ3BP?=
 =?utf-8?B?MmU0VUE2aE41UjNTVW5nMklqRTMyMm1RM0d6SVVqWVFqbjQ1YUlaYmhXdFpV?=
 =?utf-8?B?V05kQWNoN2NLdEI4dzlNNjVGVEdDYlZFanRYNlZzTm5vZXBCQVZyYnRpclFT?=
 =?utf-8?B?N29xVWpnL0xuNnZZamxpVjVMQmltSkgrY25ob2Q0TEtGL21pTFQvQkVxRERL?=
 =?utf-8?B?U3p1cWFxSWpIcUdQcXVjN1hIZzJRTkl6bXE0N3Z4SWFicW00dm5jVmQxcDE2?=
 =?utf-8?B?cTIyalJUT2JPdDc3M0VHWm9hMFphZWFwRGp4Q1JGVnZFZmJ0RnVpNTZYczFV?=
 =?utf-8?B?U3M4Tk5kRll0anpETHNEeGgvQmVjcHBvOU5EY2JxVTRsK1VmdFMzVW9UajJh?=
 =?utf-8?B?VnFDUURBVWFxS28rYXAycVN6UEl1dW5PWGpicHkwYXY0R1gyb2p0ZUYyQldx?=
 =?utf-8?B?eDVZNktNdlNJZWxpdCtRRHRDVVhEcHo0WlZDTU1lSlJnVlVEekdMMjZHekJK?=
 =?utf-8?B?aDQ4V2ZmeXBhOGtxSExzeUxrLythb2RkZkZ2TERwbC83S3BVMGxlbC9kVlV5?=
 =?utf-8?B?MTVpNWJrZFprZGV6QTZKaWNlU2RQMXpyV3ZvUzYrTjJOWXliUzlQd2dZcFp5?=
 =?utf-8?B?aUZTRHlKZzVwK25pd3VoRlJ4OUxPa3RTR0dPRlgzVGMzdmJCenI0N2h5QzU3?=
 =?utf-8?B?TW1HUzl5bEtmR3lLd2pSdXRsVkI3emo1ZlBXeDQrYmtMSEFCZ1F3eWY0OXVI?=
 =?utf-8?B?SWNzRy9kemJ2YmJjZjR2Z25KZTdodk5aTzIwLzZobk5nMWw5ZVg5ZXc2Tjhs?=
 =?utf-8?B?ai96MHFxYkN1MmxvUmpUNTRiaG1rcmd3cVdBczBGYmQ3ZjFyZkFFbzFxN0Fr?=
 =?utf-8?B?NzdOMGZCbjdoSDBUdGppNU1FNktYRUZBSmRReGd2MVI5WTJMaSsvZmFiZ1F4?=
 =?utf-8?B?TnI0ZDlDWmRsVTJ2ZllhZjJnTnZYeU11bDVyZHBsaVN3akZkN0tLVVdZdTRR?=
 =?utf-8?B?RldvLy9VVTBUWjBTVmZnWTRVQmFMaml0NmVabWVvTFNqSGlMNWd4azRiNXFS?=
 =?utf-8?B?VklibEpaK3JVby91UVNSUGkvTjVsM1k0K05LTi9xbGZQVDJoYjNmcnY1UldJ?=
 =?utf-8?Q?gh8U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 16:07:22.7945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58dff7cc-72c3-43a7-9455-08de18979395
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9015

Applied to drm-misc-next.

On 10/29/25 12:38, Mario Limonciello wrote:
> On 10/29/25 2:34 PM, Lizhi Hou wrote:
>> When a command times out, mark it as ERT_CMD_STATE_TIMEOUT. Any other
>> commands that are canceled due to this timeout should be marked as
>> ERT_CMD_STATE_ABORT.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    | 15 +++++++++++++--
>>   drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
>>   2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index c6c473c78352..289a2aaf4cae 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -204,10 +204,13 @@ aie2_sched_resp_handler(void *handle, void 
>> __iomem *data, size_t size)
>>         cmd_abo = job->cmd_bo;
>>   -    if (unlikely(!data))
>> +    if (unlikely(job->job_timeout)) {
>> +        amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
>> +        ret = -EINVAL;
>>           goto out;
>> +    }
>>   -    if (unlikely(size != sizeof(u32))) {
>> +    if (unlikely(!data) || unlikely(size != sizeof(u32))) {
>>           amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>>           ret = -EINVAL;
>>           goto out;
>> @@ -258,6 +261,13 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>> void __iomem *data, size_t size)
>>       int ret = 0;
>>         cmd_abo = job->cmd_bo;
>> +
>> +    if (unlikely(job->job_timeout)) {
>> +        amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
>> +        ret = -EINVAL;
>> +        goto out;
>> +    }
>> +
>>       if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
>>           amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>>           ret = -EINVAL;
>> @@ -370,6 +380,7 @@ aie2_sched_job_timedout(struct drm_sched_job 
>> *sched_job)
>>         xdna = hwctx->client->xdna;
>>       trace_xdna_job(sched_job, hwctx->name, "job timedout", job->seq);
>> +    job->job_timeout = true;
>>       mutex_lock(&xdna->dev_lock);
>>       aie2_hwctx_stop(xdna, hwctx, sched_job);
>>   diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h 
>> b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index cbe60efbe60b..919c654dfea6 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -116,6 +116,7 @@ struct amdxdna_sched_job {
>>       /* user can wait on this fence */
>>       struct dma_fence    *out_fence;
>>       bool            job_done;
>> +    bool            job_timeout;
>>       u64            seq;
>>       struct amdxdna_drv_cmd    *drv_cmd;
>>       struct amdxdna_gem_obj    *cmd_bo;
>

