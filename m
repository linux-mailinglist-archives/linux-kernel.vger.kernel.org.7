Return-Path: <linux-kernel+bounces-889155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4591EC3CD48
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3D15189694A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D98134F262;
	Thu,  6 Nov 2025 17:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1NJlWd+I"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0507634F497
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762450063; cv=fail; b=mG/bj8XB2e25jGvNmqjYZRNR0O26dkDaQnNFkhEPt2LJlhxKqpxezSxLr51N5jfVDxe1EIuQ6JfFvsPExdaFRppodf2nXxH3mjs92YqsrnSCTr3xFvy7u+eiOIdmKhaoY0AcB4B04IxFSa6QYyDZjyTaSbyMtzYR6EjjRUwmCzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762450063; c=relaxed/simple;
	bh=mdXyDnmWU8Km1kSJVIM1n1yTNMgutScmFbd2AJ8A1WY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TeOa7t8Rna4qdNtXz+vCxyN3pzlyYO5blS3Lh6CnlXPTRzfp54KD+EG/5FqpGyR9+B6QMPIg898KrFOfqaEJGG5Cigv3f2vLLAjOeCLWRHIzRIqxYSn/2g10HjZ9J86CFA4spNIt5bQEIeLIv6kP8EjuOe5Wk36zMjizx3KHWL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1NJlWd+I; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMYYwR6Q6Dgmz3VJzxq8pFC5wcN75I9WDntspcy55/9X4V0OQ1kPY1TyA5ES8xAzsCxc5PuBV0RNShho76Inb6sOrKJa+Sw57kDs1l5xSKGfPI2MqarZbUI0SsnHBYkc/RI7UdL6qFB2m7LwmsLuMrXAWMIK/ZwFq9Y+K7bTz4ZFUFmYQj+rk/+3AQKWXgOcB9Xhkuw2Q1tToGfDSDbkmsyOnDYe2yVFXdQb5IfiOeFLSqLbCfkC2s88qruzVJvqfzvqVr+zKccdD+uyq9zT74X10xSB7Gx3O6SNH5yoYhZYYtx7Oeha1whtG9vu7rb5ww+CuzoVv+fEAamZ6r1c8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwKa8jc+OQ9eLTdMntukj//eORrs4sf5RO8PKr4eBo4=;
 b=MyG0sz5A4ci3c0eFOpxrjhw7Xc92tUObJOhqG7jn7Wo3zvDcwUdrfupPvJ2L+CeRfK0WoJSl2MiC3AUcKpWoNmhhZdtTv+OoJVm3FDX3PL5JFDkCQRO9xEBY2GAUkfVZfMmaDnEK/qt7GJKLK+/ealE+YSt+Xx3pRn7Ndi00PgZ7uF6XPICE3P22N6AmbB88E0CrO9kjZZqFud1bJ6mDv0xHIRIxST+ZPnlOmBF/YQpoHGw2XquDY3B90TWqTNKO04JO6hoqymS30FwYjT4AjuZDKxFmOt11gxspOW2L6iU4qfwYt+ACgpQMXJGQbmkE2+9ZPcqxTRzzahv/izO61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwKa8jc+OQ9eLTdMntukj//eORrs4sf5RO8PKr4eBo4=;
 b=1NJlWd+I5VILRWyu8MCTcYX9qYEVKv1nl6RUGQ61onRHhcReXeE+vpsJJVVfrbPBBpXxNUTDAADdXZO0Q/qivkQLnHmF2824a1BDxF6eWdjuvxNpWZXupjPTOKx7WKwrYes3QslfOPivg0vokZ2wRzmItHwLxATxNuRkOjCN8is=
Received: from DS7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::18) by
 MW4PR12MB7189.namprd12.prod.outlook.com (2603:10b6:303:224::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 17:27:36 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::36) by DS7P222CA0011.outlook.office365.com
 (2603:10b6:8:2e::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 17:27:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 17:27:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 09:27:35 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 6 Nov
 2025 09:27:35 -0800
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 6 Nov 2025 09:27:34 -0800
Message-ID: <75f699c8-3158-5999-b44e-657d0ddb52d1@amd.com>
Date: Thu, 6 Nov 2025 09:27:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix dma_fence leak when job is canceled
Content-Language: en-US
To: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	<ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<maciej.falkowski@linux.intel.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20251105194140.1004314-1-lizhi.hou@amd.com>
 <5e341c1b-4cb1-46b3-a8b2-2c6758017988@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <5e341c1b-4cb1-46b3-a8b2-2c6758017988@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MW4PR12MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 192e081e-e3e2-4ffc-9235-08de1d59c6f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZGN1RWFJenBkYU5XeWpZcVZvTjZPMjFhN0hXZjFoQmF1dXU5UXQvUFFpZ3R1?=
 =?utf-8?B?bHZzNGcyN0lsNCtLY2FjMjYzSkZGWEgzQWlqQ2R0QzRVczlJZ0RhY3NIK3Jj?=
 =?utf-8?B?akV5dm5YQUM5OWUveCs4ZFlaWWIwbE5qUzVvV3VjU1V2enhKWWdSOHkrNWts?=
 =?utf-8?B?VzJwOHphVkdZZjRvN2Qxemx4Wkd1cW4rS3k2ZThNSmtxY2VESFJxaFZmVDJT?=
 =?utf-8?B?S08wWElNTVVWN0Z2RHFHSXVua1VuRDc0bk1MZnFmc1NPQ09TMFgwNTJvZkls?=
 =?utf-8?B?ekpBNFlXNVZOK2FxOGwvbGY0c3hxRlR6SndSNGFXZ2c1TUFZRlU2MHJCdEpZ?=
 =?utf-8?B?dG5BR0EvWE1EelQwWW9aNkZiWDNrQ0ZMZDAyaVh6MjQ1cXdTa0RjSEsyRVFn?=
 =?utf-8?B?VUhVSHM3SGRSVlBUelpVVzFrT0duTlJSNjJUeVAveXl0Z2M0T2pJUk5vWHZZ?=
 =?utf-8?B?Q3pGWWRDb1lNeVBwRUxDMkdIU2tNREd6dWpTQ1VqbkhuZ0s3VVRtd2FWZXNw?=
 =?utf-8?B?RWdYb1pFSUovYVFPUzRVdi9ubkFCYWNkM2hSUjVkN3BrY0xFTWxOeXFlc0Rv?=
 =?utf-8?B?QzJZZ3g2VzhKSGNSNlh0Y0dzOGJpRU5zY0NuR2dLeXU2MFpNZlhGVGtTU2kz?=
 =?utf-8?B?bWE1eHpWT1NNQWdxTUx2RktDWlZOUGJWZ3R5Sm5oOHovQ2JjcFc1aGNuY3lC?=
 =?utf-8?B?cjdPRmF3M0dvdmhBQ0wyNnFnWVA4VkdLakk0VWpyNDhvMUswUnhiT2EzdktD?=
 =?utf-8?B?VFNZUklQUEIyTVd3ZE1Kc0NQM1ZsMXdhZ0xEUFVKeDJuZlB2eTBsbE9DUnZ6?=
 =?utf-8?B?WnJDRXBGYXNKZWJwVGRucWtzb3lUSFYwNlZmdWhrM1Y2VG9WNjFvMkkrNWwy?=
 =?utf-8?B?SjJkOC9zV3NBZjlzVXR2YXZZZ3JZdXdUOTA0SStucXgwbmxHYkZHOFVKR0g3?=
 =?utf-8?B?Sm12akxQMXJKZE02WEFkZXdYbGUzMjBXS1l2TWlaU01yd3ViRWMzWlJlTFpn?=
 =?utf-8?B?Wlp3enBRcTFDTVVpemtpMUI3Qyt2MnFMaVNaV0ZKdCtTMmFncWJ3UlppNnRR?=
 =?utf-8?B?WExGMDl1aDlSNWdOb21tNEVSWnB3elMybWJjS05VaUhiVzBJKzBVYWVDVlhB?=
 =?utf-8?B?UVpyRHlCejBSdmRMSkFKLzBQazJMeGVreUNsRkhCSDF5S0pPNDA3ZjBwVXM2?=
 =?utf-8?B?S1R0Y1RaZ2lzN0tMU05ERzZlaGx6ajFrZzcwWVk3dzJPdm9jQnJLK2w1ZWZL?=
 =?utf-8?B?UGFvc3NpQXl2S3htOUlKRW5QRjhMdUh6MUVocTFhVVYwcE1pYkhxOWdidEJj?=
 =?utf-8?B?SjFBcURNS1d1OFNsVTNjODZwdWlHUzZGOCtVajJGbjhmQ1F0WFJVaHlpRmtp?=
 =?utf-8?B?QUNjbGh1OTUyOUdYZC9JUDhCcVN0NnRub2o4ZENiRjZWTUxjUzZYc2Q1MEhl?=
 =?utf-8?B?ejFVdlZLM0pmc3dVdW94KzI2MyswaDNNdTloK1BxRzcxWjZtRnhxcVV0S1FX?=
 =?utf-8?B?YnNDemZaU2NwTmRYSldkVEZodFZ1T3ovdDhENXpoNnVZK2Vhd3dHWnNaWitr?=
 =?utf-8?B?VWVSZkxTZFZxd1hNcnQ1TEVlZnpoQjVWWE5vdlZPZERvZ2hmbDRHSmRQMVdX?=
 =?utf-8?B?a1R1M29kMFY2Yk9nNUNRVzh5OVFFcHZjcHdCUUQwWWp6TXpWY3ErL282QkRB?=
 =?utf-8?B?b3hpKzZVYWpHRDdoRGh1MjhNUmh6ckt3L3Z1Um5wWDg0LzdKY1RFRHN1OGU0?=
 =?utf-8?B?bndHcVpYMEVQMlpHZUlZZ3pSMWhZTU1hS1NpeEh0SWlLNHM3K1d4STkwR09R?=
 =?utf-8?B?N09KZkUvVVpKclVjSWIyMUZaQXYxRFNycU51cmd1bHZhc1lnTUVoRGllS1ZD?=
 =?utf-8?B?TkhadTZqRE1nRE04eGZxYUtOZ0g3UE1hTW9ZN2RZdlUvaWpzL3hBWk9FMmtk?=
 =?utf-8?B?eTJndlNDQ0dYa2hjZTZaN1VaNlhxRlBTZFY5cndUZFlROWpyQWs0UndURTc2?=
 =?utf-8?B?Q0dCV05mdkhCUGpsKzg5NEhZWUhDUUJWZWI3c3BZOUs0VVprNW9CaXhGVERX?=
 =?utf-8?B?VEIvR29pdXJpTWRsdDNIa3BtQkVaS3Q5bmFReHp5YkdHeENXOXlyOFRtck5x?=
 =?utf-8?Q?5upw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 17:27:35.9273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 192e081e-e3e2-4ffc-9235-08de1d59c6f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7189

Applied to drm-misc-next.

On 11/5/25 11:43, Mario Limonciello (AMD) (kernel.org) wrote:
>
>
> On 11/5/2025 1:41 PM, Lizhi Hou wrote:
>> Currently, dma_fence_put(job->fence) is called in job notification
>> callback. However, if a job is canceled, the notification callback is 
>> never
>> invoked, leading to a memory leak. Move dma_fence_put(job->fence)
>> to the job cleanup function to ensure the fence is always released.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    | 1 -
>>   drivers/accel/amdxdna/amdxdna_ctx.c | 1 +
>>   2 files changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 2b51c5211c2d..e9dd9e03ef07 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -189,7 +189,6 @@ aie2_sched_notify(struct amdxdna_sched_job *job)
>>         up(&job->hwctx->priv->job_sem);
>>       job->job_done = true;
>> -    dma_fence_put(fence);
>>       mmput_async(job->mm);
>>       aie2_job_put(job);
>>   }
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c 
>> b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index 878cc955f56d..d17aef89a0ad 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -422,6 +422,7 @@ void amdxdna_sched_job_cleanup(struct 
>> amdxdna_sched_job *job)
>>       trace_amdxdna_debug_point(job->hwctx->name, job->seq, "job 
>> release");
>>       amdxdna_arg_bos_put(job);
>>       amdxdna_gem_put_obj(job->cmd_bo);
>> +    dma_fence_put(job->fence);
>>   }
>>     int amdxdna_cmd_submit(struct amdxdna_client *client,
>

