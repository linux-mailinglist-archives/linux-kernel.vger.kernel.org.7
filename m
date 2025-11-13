Return-Path: <linux-kernel+bounces-899968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 102F8C59656
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 19:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 690B74F533A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596B72E7F14;
	Thu, 13 Nov 2025 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="P/WbmDN6"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010037.outbound.protection.outlook.com [52.101.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665802C21DF
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 17:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763054691; cv=fail; b=feksjMayLZtSBzf/7AICkXgjex1JbHuw/8vOgQoWLZ9jppMGNK+93xeUVX4HEwMaO2k6WbBmZlVV5X8InuixBWh2jKvtwJKeN+r5G0Jii9iUFddGeIedyd1we3Iknoxa05ESKT61mDw6XS7mvTPS1xBev2S4N/19s6D7yKDsl3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763054691; c=relaxed/simple;
	bh=vuPEdNj5ylnPVgFkr/mthDfHjF5PAmb6uJEYWXRo9aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=m4pFS3HK0wOByTjoSeZbTZRfUgYB10gYmuU2AphTY4zJUdkZ8Ggp+k2ooQrvNVHHQQuMcml7Vwh+mt4HKAG/Xzy4sDJ64+13rDzKs33ygS94LL0U9rtaLLN/yr8EBAea0f0/m46PkROE57NtxXWueA0ZLW28XYm/IKxnxW8Rjug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=P/WbmDN6; arc=fail smtp.client-ip=52.101.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lZ0kLGUhDIC1H9UmczuasdovErDKlNfQ2MqaFK/oMb9kD8p+7FfMS8BosWBPJANt3omMhGOqP6msZNPXCFQ+Ud9rb/dkGbnjlJ0Vl4H+7x8IExAgAfpSY7RZYOOOpUoMmEZ8ebeicgzPPK0cImiTAseUT1v/gplIh0jaRFeoaelpS+/7ZbJ7kaAd4CpZJwnhEr5XZCq9wjQs6kmgFG8MKbRmirOKPoXriY4o8RuWm33buS+6+f2uFtg6roa8lRJC17wTIR7yFS1Fzi15BLiHxtfPHn7fNQnpmnZ7a+CTLUHE3sZASzfhR2QjYpqns05iD3vilyN39vBuMl0oVxSWHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NKvtVI5/N/MG1fBG3yTQ3ylq6AhV+nPJMre5mWK2ACI=;
 b=vJt5QBQbBBronjRwe2Te8RzUNWAvjAFrose3UPGezqRX3J3GfPPwDQk1s82f/EMpYAghOJUHA6oYndVD3xicTb+ceUnqJ+lAJq3Ye/h0X9N7P8kgnO6E7SotT00cWjsvx4C1nxlobri5dfuJ7IUC3rp1kw3G3dIm+WTBxzJjM3usHlnlS/kMSs7VhtqUrivKV/pKuuyKQgLWFwD8zeewUK83r8OCqGlHH57JA+orSr340fVVcF0FQea6B47hQ+fdbgcZJJ5KJAy4RL9ziL+SosBLzflpGX3dNOa1LXIUSgKETrRxMhhz3fgDtFimLmUkRRmb9gWCDgORHE50zsoLrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NKvtVI5/N/MG1fBG3yTQ3ylq6AhV+nPJMre5mWK2ACI=;
 b=P/WbmDN6VOeR1A9CyVUsLZX7dBemCO02MVbukVa0AFUQVfijoaxiE/j4v+B5Hr9niETr6ziULOK54BQy2cWGdFVqrfvZiJZH+N3V99921j/3RCWl+m/alB3T/3VxToya/TKyXR1ZgymtVDJtG9HYozxMSdXHCOZjhe8iEW/pcTw=
Received: from BL1PR13CA0345.namprd13.prod.outlook.com (2603:10b6:208:2c6::20)
 by DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 17:24:42 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:208:2c6:cafe::79) by BL1PR13CA0345.outlook.office365.com
 (2603:10b6:208:2c6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.7 via Frontend Transport; Thu,
 13 Nov 2025 17:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 17:24:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 09:24:41 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 09:24:41 -0800
Received: from [172.19.71.207] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 13 Nov 2025 09:24:40 -0800
Message-ID: <9450655f-233a-804b-465a-d7a7e969ff8b@amd.com>
Date: Thu, 13 Nov 2025 09:24:40 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix deadlock between context destroy and
 job timeout
Content-Language: en-US
To: "Falkowski, Maciej" <maciej.falkowski@linux.intel.com>,
	<ogabbay@kernel.org>, <quic_jhugo@quicinc.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>,
	<sonal.santan@amd.com>, <mario.limonciello@amd.com>
References: <20251107181050.1293125-1-lizhi.hou@amd.com>
 <9ae59f7e-9d99-4e73-a805-99586d8f49bb@linux.intel.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <9ae59f7e-9d99-4e73-a805-99586d8f49bb@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|DM4PR12MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e3c4c2-83dd-40fa-bd36-08de22d987fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXY2ZC9ab2x0OXlDMnhwSG9udWhsdlN5VU5ZTXlidmdnaXl2S3FDeDBnMFUw?=
 =?utf-8?B?eHhvOTMvb041MEZnQmh0bnh2NWdGNHQ2T3MzdHFmOHdsM3d3a2JJTmxKTkc4?=
 =?utf-8?B?S3czU1pValovSmQreHllbkxtOWZWS3N6TmRoTis1aFB5cGpVMFBJRHVGdDdE?=
 =?utf-8?B?enFqRlN0TktXRXZwWVBMWFVjODBPV1l6RnJtcllXRi9RazN1ak9hT2ZaY0ZP?=
 =?utf-8?B?ZFY1cS91Z0lmQS9lMU1PZE5vOUZidnAxWGhMeWtqT0V4aHVwblhQTnBqdHk0?=
 =?utf-8?B?R0FiQUY4RWZVa2gzOS9hRDVFWUlrSVFHM0hqWThvTHh3OUtQdE9OLzZFMzVp?=
 =?utf-8?B?ZFBJd280WndOQnFSRjduMHZiV1JPcUt1L1ZXbUJYSjdTTXdLdFJCRGVxWVla?=
 =?utf-8?B?WFlnOXJueVQ4YUw5Y1pHa3Fzdll4VzVzYXBITzdCemp4U2Q4NWJsd0tra2wr?=
 =?utf-8?B?OFFsMjRtNG1UK3dnMDB4TmV6WWZ6RzdPVlY5ZkFyakk2aUk2NG9sZkl5OXkr?=
 =?utf-8?B?RE5uaWg2TFFlL1lUbDRPalZpY1l2cExkQ1lsRzIrZkdqeVpVUjBPU2hYSklX?=
 =?utf-8?B?bGRabUlCdFlkZ1JFU1N3VFI2QTRZNnFnT3dIS1JLNTExa1J1WFZvdnpXbFdw?=
 =?utf-8?B?M3hsWXBua0kvaUZjajZIZS94M2NLaVZ6eTZRVFBhTFlJZStSQnNmaDZ2c0NP?=
 =?utf-8?B?NGk4Y3k1ZlhwR2dKTmo0UzdBUkdocmIvUEJ0dTM4aG5SZlZkaWtpOGladzdZ?=
 =?utf-8?B?QmkvTjZwRzA0cjdZZko3N0VqL2xaOHluM1BxSWpIWFB2Y0JYUWhGOERyVjI1?=
 =?utf-8?B?a2FjeFlidjI0OUY2QmdSMFgraTJ0RDNmb0dORmdXbjFvcUFBVGEzc3hxaEw2?=
 =?utf-8?B?VnJaWUtJelh5d3RaUDFiL3hLR1VKVjdvZXgxaS80YlVYWjlDTU0yMDBvT3Nh?=
 =?utf-8?B?azVWSHBjQ2p5ZUFJM0tRUUhjU1V0M01nN2FleFNRb1ExNkpPZlIyRWpaelRk?=
 =?utf-8?B?UlN4eXF6TnUrRW5yZU9uUGt3QkV1dFRybkhEWHVteVIxa2Z3SEVCbWI1cEd6?=
 =?utf-8?B?TlpnM05MNWlqOStKcGFnc1J3YS9vK1paU2ZVblg2b1d6UW4zcFRkKzY4cHBU?=
 =?utf-8?B?dTI0RFJXRTk3SWc4N0hZQ3cxSWpkQUlyODJ0T0hpaUNuYWFTeDRJbzhPWU9z?=
 =?utf-8?B?T05xdU1WZTNCbjBPb1NiUE9Va05NSC9XREkzU0gxZzIxVUtpQVVOeWMxR3ox?=
 =?utf-8?B?N3k2YXk3UVVmN0w3Z0syQUZzUGJhMnZKdVN4WExOdE5uaitSQ0pUN1pJVWpX?=
 =?utf-8?B?T3RpZldPeC9zRXlPOEZMUXJkOWVYVmJDblpMYWJ2U0ZrN3NJNXFrY3crQnYv?=
 =?utf-8?B?Yk4zbnIrcFdtYUVETEc1aml6N3lGNDE1dTBReFJ0ZHE1cmpOQ2M5Wnp0ejNO?=
 =?utf-8?B?ejBrUUhYVHEyVU1SMi92M205QXk2U3FnQkEvSEJxakQ4ZkJXOFlZK2l4dGNu?=
 =?utf-8?B?MnVmbzJhcUpGNTBhNGxsQTdvYmo3UHdhMitLVU4wa2hlTm15SVJqZGxVd0hi?=
 =?utf-8?B?OUlncllaa3J5bFRKdVYwWjdpM2ttdGxGMENGQjB1WENTdEdYWk1oRXBqaHZX?=
 =?utf-8?B?c3lBZ3ZLcU5mRHdXV29wbGVNSjU0ZUdCRGJ1VmFHOVIyWEdXTDFzWXBhRzVI?=
 =?utf-8?B?d3RVc2hkTlFzL2d5VXd6czl1YmswcVBIREtQN0VZMndGSmYxRFBQbHhHWVdX?=
 =?utf-8?B?d2UxRXYyUm9iWTR5WCtNbGNVY3VQTlRxRGF0akFKaWR4dFhmVTdxYjA3aVJl?=
 =?utf-8?B?MzZZQmJMWDNWMUlISy9FTmFML0h6SU9rZUJRVm1aaGRlYnZST3ZJSzhpWW5G?=
 =?utf-8?B?UHA3MVhuMjdwN0lBaW9nNWdZN0MwSkNNN0VLRWZ4bFJjRWJVVHJRKytDMjZL?=
 =?utf-8?B?MUNmVlVadGdZSzUrSkNCS1pyTHJlOVh1N21UdDErMW1aRHgxSTNKeUZCeFpT?=
 =?utf-8?B?dVp5SWwzUm5BcUo5UE1vWUtISXp1MU1vdittMjZOdmlMbDVvU3NRU1ZsVHIr?=
 =?utf-8?B?VkV2QzlXQkVQdGNUQ0dudHQ5R3p1Ly9PVklKVHAzRzZYWFNDVjdzZTFBbWsr?=
 =?utf-8?Q?OnYc=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:24:41.7630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e3c4c2-83dd-40fa-bd36-08de22d987fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451


On 11/13/25 08:45, Falkowski, Maciej wrote:
> Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
>
> You could add some lockdep assertions for dev_lock to better track its 
> state.

Thanks :)  Added lockdep_assert_held check and applied to drm-misc-next.


Lizhi

>
> Best regards,
> Maciej
>
> On 11/7/2025 7:10 PM, Lizhi Hou wrote:
>> Hardware context destroy function holds dev_lock while waiting for 
>> all jobs
>> to complete. The timeout job also needs to acquire dev_lock, this 
>> leads to
>> a deadlock.
>>
>> Fix the issue by temporarily releasing dev_lock before waiting for all
>> jobs to finish, and reacquiring it afterward.
>>
>> Fixes: 4fd6ca90fc7f ("accel/amdxdna: Refactor hardware context 
>> destroy routine")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index bdc90fe8a47e..42d876a427c5 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -690,17 +690,19 @@ void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx)
>>       xdna = hwctx->client->xdna;
>>         XDNA_DBG(xdna, "%s sequence number %lld", hwctx->name, 
>> hwctx->priv->seq);
>> -    drm_sched_entity_destroy(&hwctx->priv->entity);
>> -
>>       aie2_hwctx_wait_for_idle(hwctx);
>>         /* Request fw to destroy hwctx and cancel the rest pending 
>> requests */
>>       aie2_release_resource(hwctx);
>>   +    mutex_unlock(&xdna->dev_lock);
>> +    drm_sched_entity_destroy(&hwctx->priv->entity);
>> +
>>       /* Wait for all submitted jobs to be completed or canceled */
>>       wait_event(hwctx->priv->job_free_wq,
>>              atomic64_read(&hwctx->job_submit_cnt) ==
>>              atomic64_read(&hwctx->job_free_cnt));
>> +    mutex_lock(&xdna->dev_lock);
>>         drm_sched_fini(&hwctx->priv->sched);
>>       aie2_ctx_syncobj_destroy(hwctx);

