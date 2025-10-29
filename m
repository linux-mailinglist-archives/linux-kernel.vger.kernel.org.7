Return-Path: <linux-kernel+bounces-876979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF5AC1CE93
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 20:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D8E564FA8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 19:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEE1359FB0;
	Wed, 29 Oct 2025 19:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Er1XShgk"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010069.outbound.protection.outlook.com [40.93.198.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959752E6127
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 19:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761764762; cv=fail; b=WCpk/WKOU4ZXTaKXp2g2v+EsDqIKyVMQnykVRxCinI4AyaxRCoHOz/kFDz8uNZLPXMOYW523qZNfg/bJmOC/2m1lBYlGwE0g7cYpg+p/gMvtQ5Bohg0q22ePzxBlC62HV03/XuAsQgCc1w1b305PVMh8HwvJyPZL9RtMe43Sh3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761764762; c=relaxed/simple;
	bh=xWEEIGM1NM20SgSMMttt58abIunw9sz7xINtzYAYabE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=C4RCbKkpkpzYoy9fg5lSedeDs7tW1kZgICf11W2A0jrPl8806FdRpQ2MmsTm/pBsvnnl/F5S8X3I5DCx1S5HVVgpmo5PQNkaXu40/4Y3f67pzXw1msn2HjtHeJPD7SNeAsW1vqyn6kcEYVRVkfHYoHbRV4mMo2WOI+Ir5JmaPvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Er1XShgk; arc=fail smtp.client-ip=40.93.198.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmBmcyGSIyNA92J/Dni1xVtkeWfuNqmW1wPyyAPpP9PbOvik1jv8wiKafRbSwvTAcNDTGa6l+jdCuHfzJLGH7izxE5K/lqJ4fgLAPtWORIkcVJe5hDmsSBl8Id1F6u1QqOZRQJUX2euwio+ai66ISiW6iU9A2+wHlhZTyStHhbfD5j9VkT/rlmQqVD0sN4ZghEB76a+jj06pssny90BtnjqL94x1OYRYYxN87CbveCcByWY1CZtImq7v0+VM55uTjgiL3DIF+NJed4sJBq9SKasPbbJKr50B4jFF2OG9+dpSEz+Btgo6DJv1QGbYXwai8ZhQd42qkIfRj//ZxqfZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHdrz/rCsScILBrMeeSAJ1ILkG+2cdbrcclN4VsFs2I=;
 b=ZCfavPie28ODv+Vv1ZMvzDJ0G4Iwcnrgcvu/bsMZm/rRT0yWHEmcxeG/mfpoR639udD1I8PyYXGPSwunL9yQh3x0pB+KvRxsqMb5Ctx3dWh9aVbbkN5yKvtByk/q8Kcc7iUuMtMBfHiwoj0Jw5M7Vj2ItL+6qJ7Cl6fkWaZy3kue7mWDswZdNox9Z9njcSi6lcG9NbnmKPzkvXWZ+hqa0b7+Ttq0N0chRieBl3CJ67MvlG9MkFB1eLMWOLfEKp1c5nWKVNpKoAWZKNX/EsbklhCrbdWW6+5Xwvmmy/6/W/Q0Hlo5ccu/W5x8cafZKbIL1ORlMD8ANVr+UAxyg/Yp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHdrz/rCsScILBrMeeSAJ1ILkG+2cdbrcclN4VsFs2I=;
 b=Er1XShgk6R7ormMoJashNbc3jXwVIKGSbZoJJ1n0lManYflx0KmE+ArKI8sjya/2u5B8ADJ3990ZShQX6EKXj+B8GgKiUhZ9nefajHmVqcORx3KZH4pRA/RGBESmtRqKXi9nFcUzjAx85EA6sRxojSJaiNk3JbF+D08dydyy8Fc=
Received: from DS7PR03CA0236.namprd03.prod.outlook.com (2603:10b6:5:3ba::31)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 19:05:58 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:3ba:cafe::27) by DS7PR03CA0236.outlook.office365.com
 (2603:10b6:5:3ba::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Wed,
 29 Oct 2025 19:05:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 19:05:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 29 Oct
 2025 12:05:56 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 29 Oct
 2025 14:05:55 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 29 Oct 2025 12:05:55 -0700
Message-ID: <cac0eb0f-7e91-f68d-8cbd-f6bf9586afca@amd.com>
Date: Wed, 29 Oct 2025 12:05:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Fix incorrect command state for timed out
 job
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>, <ogabbay@kernel.org>,
	<quic_jhugo@quicinc.com>, <maciej.falkowski@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20251028175452.2329497-1-lizhi.hou@amd.com>
 <ecdd1f2d-7192-4fce-9fb7-854cdfe2ab88@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <ecdd1f2d-7192-4fce-9fb7-854cdfe2ab88@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5f8530-3c4d-449e-9917-08de171e30a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3RPZDFhVkxINFpmdlFqT3R3SDE3b0FzY1NObXhXbmtOREJVS0trZE1UcU1J?=
 =?utf-8?B?bkJzWm12cHN5TEEzd2NCUGFYUytsYTJtSFljWGhnREN5NytmaUxyeHI3QStu?=
 =?utf-8?B?WXRSejgvL1d2Mzk3SmQyaG91TGVMMU5ENml1ZWhXaTFLeTFlRjhCSTdFLzJL?=
 =?utf-8?B?NU93SmtZQVNibGFGNU1SSm1PRlQ2ZWJDd0RyT0d3QlJGS0dTbStVRkRuNW5y?=
 =?utf-8?B?dHlqSERRRTdqMW9wd2xFZnNNWHdKYlJnNVpEOHZ4RXNkT2pLUENPcVNZYnhq?=
 =?utf-8?B?Wm9WVmdQYU11Zy9rRXV0c0U3SjJmRkpscnZmam1MaUtzZXpSMHNxL0I2bUJS?=
 =?utf-8?B?bWVuWnRYWUd5WEwvb0hZUkRQN085YWVCM2l0YzJDQlhEY3FLVHpHaTNhYTZ5?=
 =?utf-8?B?bmF0MDBtUmJXVEt2Z1ZxVDhJeW9BT2lPQjdxM2JEaUNuQVJZai9RSzlYdW1R?=
 =?utf-8?B?ZTVGRFBzUTNVdGNmcWpnbmtwQXRsOTB1WFJuVkFtc2RaOXVYM2Y5aVA3Wlps?=
 =?utf-8?B?aTI4T2cvTnl3cHUxa3EwRHpZVXdqWnVtcExLUWowcmRTaTNoeGcvUkdUaDJp?=
 =?utf-8?B?TjFybHpYM1REYWwzb2tZZnE5UFlVRGNSemQ5WCtrQmhrdHlNUzRaWDZXc2hL?=
 =?utf-8?B?Z3NGRmxTVGQxUnpMaytEc2k4RlpCdXZ5blVrc2dGMEIzeEFXUjZ1WGZ1Uktj?=
 =?utf-8?B?dVhxMmgvblIxdm56Q3ZtdzNiUTkzUEs2U2NjMXhpRzBIdmR2WkdnTkhYalBN?=
 =?utf-8?B?c2VvL1pUU0k1YlhLTEg1WUo3bjVlZTVGSm5MQk5CNHdxSGJ2NytMeGFmZ1dj?=
 =?utf-8?B?dmx3RXlhWkk2cG00MGhWcWVad1IvMkU3azJVTnpaTkFqSFVwRzgxazQ4cXQ0?=
 =?utf-8?B?TFo1aERvQndVMnlrSko3UXJObVZUQVNxUlFCVGFPR2RtQi9XaHJOemdNTytM?=
 =?utf-8?B?cEN2aHBUTnlrSW9qdUZobHcwZWREYUdsNHdhb1U1VXBRcUFiWTJsZm84SmNo?=
 =?utf-8?B?SDgwVkN0Wk03SDRSYk9jb2tuZHVYcFErSDhIbjZob095VDRYajEybDJhdXpL?=
 =?utf-8?B?aWFESUtqM1Bkbk9LZytsRWxkU1ZwNjRrN2hhbE5WbFp3SjVUK3hFQ1pYSzZX?=
 =?utf-8?B?NDEvcE5XcGV6MDNXYjFpN1ZqRmFETkg1eGhXSDdlSDZBdzJuTGNyZEhYUTRp?=
 =?utf-8?B?MzFDNXlMZzdodDN6Vm5yOS9PbllnYzgzb2pLS2ZBamNHb2xYZ2FwWVBON2Jy?=
 =?utf-8?B?Yno0VzFUbGErUnhvYXlZa25SLy83VTd0dXZKN0doN3VBdnRnYlFJRVczNS9s?=
 =?utf-8?B?QVc1WlE1VXZKbmZHMDZ3Y0lEdXE2b0RvNENCSHhwZWlkdDhwdU15L2JhWTY4?=
 =?utf-8?B?MDdNTjN1YnoyOFJWeDZaV1JrUVpBbnVMVDAvZEhrd213Mng3V21uVzFkbHJX?=
 =?utf-8?B?eDBUUzE0UHhOL2Fka3IweFNhbkZQNko2VmFLelEwUkN1czYzTW5PRW9BNWor?=
 =?utf-8?B?MjVGYzJsd3NsK2Nnazg5bURPbExzWVZMMExNUS9KcDhJbThucUYyZU1MUzl0?=
 =?utf-8?B?a2s0eUwyTDh1Tm55bnVYSGVlOHV3eGQ5TFhuQm43OXlMdzB2L0pwbXB1N0VW?=
 =?utf-8?B?SmdnaTc5T3c3YXhhb3pTa2JuMktvU3U2QSs3ZXFGQ0l6SXZGb29HSWNpbTEr?=
 =?utf-8?B?QkxUT3FGdjZCUWZVbVordlFTZzlJT1ZXcDdHVFV5d2R6b3AzZG9abW1pWjMr?=
 =?utf-8?B?YStCazRyM1ZoZFc2bVFKcnFhdFlUWkFIREwzUjNrSzlWQitqZmFFRjM3TVlr?=
 =?utf-8?B?dHdiS0s5QWV3ZlMzRE16L3U5ajRndHd1N3ZtMXVwbng1NC9PNjNUKzB4VzZN?=
 =?utf-8?B?YS9ueWNuenUrWDJtaDduY1R5UjVFZGZaeG1FTVZ4NTdvSmZEeW8zNy94MnI1?=
 =?utf-8?B?Mm9oQ1FkSlVyazg3UkcxdmFDT2N3SVU2dloxUXF0K0dOZ2tjK2tWNUxoK0kz?=
 =?utf-8?B?czVBT0F5MndVb0x2bTJoMGFZRkxYUWJ4ZFJleXRNa3ZJN1Z5eWcxKzc4Q0E4?=
 =?utf-8?B?S09kejJxamRzTUJWWXRUYnNjREpCbHBGdUw3bGl6b0VyVXQydGIyVU9XMXVI?=
 =?utf-8?Q?b6ec=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 19:05:56.4918
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5f8530-3c4d-449e-9917-08de171e30a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533


On 10/29/25 07:28, Mario Limonciello wrote:
> On 10/28/25 12:54 PM, Lizhi Hou wrote:
>> When a command times out, mark it as ERT_CMD_STATE_TIMEOUT. Any other
>> commands that are canceled due to this timeout should be marked as
>> ERT_CMD_STATE_ABORT.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c    | 12 ++++++++++--
>>   drivers/accel/amdxdna/amdxdna_ctx.h |  1 +
>>   2 files changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index c6c473c78352..958a64bb5251 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -204,10 +204,12 @@ aie2_sched_resp_handler(void *handle, void 
>> __iomem *data, size_t size)
>>         cmd_abo = job->cmd_bo;
>>   -    if (unlikely(!data))
>> +    if (unlikely(job->job_timeout)) {
>> +        amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
>>           goto out;
>> +    }
>>   -    if (unlikely(size != sizeof(u32))) {
>> +    if (unlikely(!data) || unlikely(size != sizeof(u32))) {
>>           amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>>           ret = -EINVAL;
>>           goto out;
>> @@ -258,6 +260,11 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>> void __iomem *data, size_t size)
>>       int ret = 0;
>>         cmd_abo = job->cmd_bo;
>> +    if (unlikely(job->job_timeout)) {
>> +        amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_TIMEOUT);
>
> Don't you need to set ret here?

Yes. I should set ret to -EINVAL for a timed out request.


Thanks

Lizhi

>
>> +        goto out;
>> +    }
>> +
>>       if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {
>>           amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ABORT);
>>           ret = -EINVAL;
>> @@ -370,6 +377,7 @@ aie2_sched_job_timedout(struct drm_sched_job 
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

