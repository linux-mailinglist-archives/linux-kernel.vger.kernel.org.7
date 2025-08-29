Return-Path: <linux-kernel+bounces-792104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6272FB3C031
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E926F7C0DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D39613777E;
	Fri, 29 Aug 2025 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YlzOeMCQ"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70B321F26
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483392; cv=fail; b=P2IvqdSAENazDcS8s5o8AvZDiwRdiyZdcv+rJVTq1kSpk0ie/54sSioAHjZe4VcmKus7DexGsdM9wfzUlKbscYFsjgsFcDw7GymMNmqLoo5MpPavsG5Q3p7yHJdVaQiTNZjer4My2P43ebhDSpTuc1E4WNQa8F8KqP6iJRncrJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483392; c=relaxed/simple;
	bh=kRKpou3wckJFpPVLS4fCB5EHo9ciGRmHar64eBEL684=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=EN9r8kcc5yLqOHR1aORdlI6f2fUAwQsESePT+dQB6kXhpLdpawAAJIvOBQlmxo8JeIrm8jOgN9X7PsrrbtQXjKepI6cegfxr+cnok4UyfxtL7I21n8hmIFvWiPBnhz1cIeAUg0067Ei5L65VJwSpvYCvIwA+gFmN8uzOwX9BYcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YlzOeMCQ; arc=fail smtp.client-ip=40.107.223.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn8stCE4jrRZJY75JwM5Wl1HH3NWi+a8Yy8r6HEM7P/be2TNG2zA0nILedNWpTfXyvEZsCR+EFk8r9QMs3s9a8lpItaKpYvaTvmOnAGiEBOJ/PbjIIF9UtwEq38uUM1tkUpAw6NXosr7hplE8fVY3xGmpjAzLbf+m0iyth6ncrUPajb4VdE3OapR563cltAftjtd/L+f9a9DzDaor1vGStQnNVyJCwMyiUDcFPZbK9RudQ36nlv5l52/jPKmJyVx0VQXqjNxWKev4aza18VcHr6YPa62r7nOK6eCznnisMW2OhnC9IaItNgrOPK+t7m7bccupom5uvzKpzszYlyFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtUSg+hsFoWBNG8iqNOx2mDRAjOZajWUeNhNNuBA6ZY=;
 b=hpyDwyg2hpHIuTuZr9PFkh/nIhF1oinqlHaFfLOSznsR2W22Mob4CcyoQw+IufBB6zfUuPbXWPV+PxID14gYctKGR1R5wyk9ipAQ+vySzSKNtY8dG/fRQMJ+0ZG3kQy/otVuAWCO9HkcXigjcvEZtKsbJllfrQSRUM2wEV0jOe1wiy1Ry7YhxlrOpYtvopJwd2JyLDWedubpaCtILc0yCCkSMoFbntRotu8AYYpCFcKH228C6s3fRe5FaoYC33Kt9c9UC4ustVDVvxiX0ltmsjRlnKHeZiQofHJMQox89qmwz2UifaTF7k/Px0xrkORfllwPY69WaDgYDp2m+JPtyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vivo.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtUSg+hsFoWBNG8iqNOx2mDRAjOZajWUeNhNNuBA6ZY=;
 b=YlzOeMCQrx3PWvKdAJ1KQr5yu5iZ+5A0ngKGkmJM1MXqZkt4edJwtkcPxTOBby5WMUVn2j75q1oXj8lLjviwA9XiwIR0N0E3IASnf8EBoRbwyQRSDJxAXbYZHf+XgI7dAQ197gu27IE/EiUpgn5U2Mtzb29t9M860tQqhTPBtSc=
Received: from BY3PR10CA0005.namprd10.prod.outlook.com (2603:10b6:a03:255::10)
 by PH7PR12MB5709.namprd12.prod.outlook.com (2603:10b6:510:1e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 16:03:01 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::3e) by BY3PR10CA0005.outlook.office365.com
 (2603:10b6:a03:255::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 16:03:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 16:03:00 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 11:03:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Fri, 29 Aug
 2025 09:03:00 -0700
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Aug 2025 11:03:00 -0500
Message-ID: <3d2e37d4-3ef0-4062-a693-0b73ed82a497@amd.com>
Date: Fri, 29 Aug 2025 09:02:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] accel/amdxdna: Use int instead of u32 to store error
 codes
Content-Language: en-US
From: Lizhi Hou <lizhi.hou@amd.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>, Min Ma <min.ma@amd.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
	<dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20250828033917.113364-1-rongqianfeng@vivo.com>
 <9c722376-da4f-c09e-3aac-1a06091791c0@amd.com>
In-Reply-To: <9c722376-da4f-c09e-3aac-1a06091791c0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|PH7PR12MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: f5bb4705-0150-4990-ebed-08dde715878c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M0JEM1VUVDFnQ0ViQVA2NlQreUgwRGRvaDJRSDJIWGZEc25xSGQvWFFTNzVR?=
 =?utf-8?B?cDIrdm1UbC9rakJYMW9QMTZvdEhjUVFnNXdGdTc1N2VlRnpWN243bE5CK2dW?=
 =?utf-8?B?WWs4TFJ0ZDAzN2tmQWJqV21LV2ZNelozOGorNzVZU29HRFJ2dGVma3V5cjF2?=
 =?utf-8?B?OFhwRy81TmtxWDFoblBUWWxjQzZodVdhc0VaczYyVTh0dzFTbCswMjVvb3Rj?=
 =?utf-8?B?eEF2RHRWZTA2elZaVElyaEZWZnl5SWNPd2ZUUXlNQ0FHT3BZK1dRSGZVOGxr?=
 =?utf-8?B?K1oyY2hoQkZLeHRxaWZRT0x3ZE5VL1pYMGk3bWxsanVpTnZLY0NwR3ZYNTZw?=
 =?utf-8?B?NGdFQUZtOC8rMGUvTXAvZVoxbGhBYnkzSjlhN29KNk5FUUYyUVg2WFhYZkww?=
 =?utf-8?B?VVJPRU03RzlWNldTNmwrWU1LYi82OTFRcUpEUXduelBuTmhqL2VjZE1XelNY?=
 =?utf-8?B?TDYrTEN6dVFEVVQvMFNHblBwQitIWjJoa0FNRStNUmJod3h5Q0dIanlCSys1?=
 =?utf-8?B?RkljR3BoSkdlYVF0aTdXWFNuYUdZaHRuUW9Zd3F5b3BueGFkVWZTZG5SMkxJ?=
 =?utf-8?B?MC9WbEdmd3A3eElscTUzSU9rOEE2VDRPQnpBUkhYU1l3K2syNmVrZ29LK0kw?=
 =?utf-8?B?bHMvUEhJODQ0RmNlODZJaVlEd0NVci9FNFQyUjJvMnZTVUtsUUw1UjVuQUVI?=
 =?utf-8?B?TkVVOWZlUHdHMDNXdzdxQTFIaWlCL3dMN1dtTzZGYW9Wckc5cHp2UmZJUHNi?=
 =?utf-8?B?UnQ5VU92Rjg2OERBaCtyaTJiZEQ2Z0Y4bCtZTkxwL1RoQnVNYlphTzJIT2pz?=
 =?utf-8?B?Y1MzRTlVdHgzL2tNMFg4RlVvWkFGMkdadjJnNzF6Q3JYem00KzVwbFNBZllW?=
 =?utf-8?B?UXhnYzZsSmViYWU1Nmg2RnVIaHhJL3RrUlEvbUVNcHlUbHlpL1lsN2hWRlp2?=
 =?utf-8?B?YlM5UXRWanR4S1J6NERZKzJsanBOYmI2T1lLWE9BNzB0ekFkZzRvam14YWNh?=
 =?utf-8?B?RXdjS0lBVDRkTmlKcDBNRkJ6NG8zYTA1cWxXTHFsRDloWjVoRUZpcld6ZVdz?=
 =?utf-8?B?NE96RmNkZVhjUURYbnMwYUYwejdhYWVsRk1xdUVuNVhDVXJvb3VEY3cvODRV?=
 =?utf-8?B?S2ZIZmluUjZDS1htYjUxUGlPdTZnZ2tndGI3aG1ma0VLMEZjSW5QWlB4TmJp?=
 =?utf-8?B?S1R0RUZuaW9KVG9UQ1hhV3NTZ2Z4bnhRcHZtaU4rcHBjc2NRR2UweUpFNE0w?=
 =?utf-8?B?MTR1SGZTUHFUWW1VbmtEZ0FwMnRTQXppVzBUWGticG8zL3VUc1FwOWZUU1FH?=
 =?utf-8?B?RUs2TThSQXhtV1g5QlRMeVpWVTJyT2J5WXNMeVJJNE90UVBteWpBZFhOcWM5?=
 =?utf-8?B?YXFzRDd4c3pZd1pCaWxaY0VXYnc4aGJadnY1RzBSb1J4UDFBZ056cWRVb2Ry?=
 =?utf-8?B?NkNidHkrdGxtbk90OWE4dno3T3dEMVJibEozMDlpUTRqdyt5VzlWSWZJOFlI?=
 =?utf-8?B?N2tneWRISi93NlBxVFJPNW1ScmVNYnZOdU9NM25aUGRyemsrWis5OGtibTll?=
 =?utf-8?B?dVFvOTZWeEw5cDhOemYxYnlVdFdzalhJUWFlM3VMT0tFd1NDeTZzd2Qzbmo2?=
 =?utf-8?B?N0V6WVZzZkR4RjlWNTdlaitsVDVJNmxuWGtUTlBrdTBvYTBkME1MamtNSDFX?=
 =?utf-8?B?YkJrTURXNitTWE9zK3NIaWJTMFFSSW11THFxTlh2NVJnRkVQdG1nRkN5VEdR?=
 =?utf-8?B?Z1ZONlZPNnhQSnpBK2FhNzVkbU1pdG5FeWE1K1RxRjdhaHpzaXlLOFZzbEty?=
 =?utf-8?B?QW9ZYkpXYm9LVUQ4ZU41dlp6SVkxZ3hXQzlsU2x3QTRGbUVWeHN4VEs5ZlQy?=
 =?utf-8?B?ZXlhN00zSDBabzJhSG56L3NlZTEvdVdIcVVod0R1eUp3aEdKczB3RGlvL2Fy?=
 =?utf-8?B?SVBsVTVCcGdlSWRaU3hIRnJkclEzdDZTZ3ZVbkJuZVBOTXFjazlDcVRNR25t?=
 =?utf-8?B?WnVEYmk5UUpjNHBTU3NSK1BXTUZxNGVxeVp1WkE3SWIvYjk3cmhzWVVtSVEw?=
 =?utf-8?Q?BnR0T0?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 16:03:00.9627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5bb4705-0150-4990-ebed-08dde715878c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5709

Applied to drm-misc-next.

On 8/28/25 13:23, Lizhi Hou wrote:
> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>
> On 8/27/25 20:39, Qianfeng Rong wrote:
>> Change the 'ret' variable from u32 to int to store -EINVAL.  Storing the
>> negative error codes in unsigned type, doesn't cause an issue at runtime
>> but it's ugly as pants.
>>
>> Additionally, assigning -EINVAL to u32 ret (i.e., u32 ret = -EINVAL) may
>> trigger a GCC warning when the -Wsign-conversion flag is enabled.
>>
>> Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>> v2: Modified commit message and add a fixes tag as suggested by Lizhi.
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 420467a5325c..e9f9b1fa5dc1 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -199,7 +199,7 @@ aie2_sched_resp_handler(void *handle, void 
>> __iomem *data, size_t size)
>>   {
>>       struct amdxdna_sched_job *job = handle;
>>       struct amdxdna_gem_obj *cmd_abo;
>> -    u32 ret = 0;
>> +    int ret = 0;
>>       u32 status;
>>         cmd_abo = job->cmd_bo;
>> @@ -229,7 +229,7 @@ static int
>>   aie2_sched_nocmd_resp_handler(void *handle, void __iomem *data, 
>> size_t size)
>>   {
>>       struct amdxdna_sched_job *job = handle;
>> -    u32 ret = 0;
>> +    int ret = 0;
>>       u32 status;
>>         if (unlikely(!data))
>> @@ -257,7 +257,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, 
>> void __iomem *data, size_t size)
>>       u32 fail_cmd_status;
>>       u32 fail_cmd_idx;
>>       u32 cmd_status;
>> -    u32 ret = 0;
>> +    int ret = 0;
>>         cmd_abo = job->cmd_bo;
>>       if (unlikely(!data) || unlikely(size != sizeof(u32) * 3)) {

