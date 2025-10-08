Return-Path: <linux-kernel+bounces-845675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E3CBC5DAF
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E94FC704
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30C2F7AD2;
	Wed,  8 Oct 2025 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="l7gtyMeg"
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C82E7F39
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759937997; cv=fail; b=MPPhcO8ziMOuVRP4a2V+hv09SOSozLDVWS4gl5eU4t/QenjKJTwM2ru8/nCY1zPPAiKB8Wf+bazRknrcX0X7ETsXhl8nwc6ZVU4H4FGD762ALkQqUHlLKSFs9FyZt6NOQbmL0SEtdsv62n+Sy57a4se7RqU7zuDrsvvRzumBuSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759937997; c=relaxed/simple;
	bh=RQob0DeZeknwQr9m9iuDIVtfkPrhkvb1Vxs8Zbd5VEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l0zVpMOfiCHP+Oih6d+/6GVilQKPTiHpDZJFTUs1H6buk6/Avx7UtLVgA+GX8USGH5ihqxrlOvJq3lkNUSe192Rfmw3nebm/kXroWmBfqESpnsr0nJ7mPVdbhVyr9SRaDEVNUzLhsqdb0JIdwvETJRyM9R7MZ0MZHJ3/8B+uNnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=l7gtyMeg; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AI0ii6aZfZJuQXHuGlMPe4Gw8alo8QNootFzgMM3uoq+kVajf04HfnAMx5X/DYob3hgZt/0EDNw6aAxA9WTg8lvGpxCI0bVmslRwXWjiWPijxKmDNFG/3bjfIRcikDEPq/nwXCUjW2ou1w15A/Liv0DKUV4NEQ6gwzq0IstSv+QpY2p0XNelkmiKw1TmwdJN9W1QX6vzdVu1esODfq4lZxQK4S4W4JbxnhIrEpRnchdiot1KddgANjj6O7bsPMqDmGEEoexKCnKsqh0ZnhWdu8miyra5rrjgplBZJTQX06h20AApE8ersIwUtuOdXz3r75RSIZupNK2j23IvKnisNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEDVgizYt4GRa2Gn036yws4I4xjA1X9qZo0d4FnWQM8=;
 b=Two7i2kdk4Rz7g/S/exYakBpWcVn3N9KB0o+WF1BahF7gIu/06H1xMpjmkHX9nEJMDMAR6zk05whCwI7J4GBCA3jppqpof6+nCdWuKcGWVBQfkBhIOHzsqbU2iPSDaQahCw/AhbKNJjcbynNbbbHSgV0MSrP4uwPZU68i4A0zrNMXV/Oh7g/o0O85mrT37/o/hhxh0pvl7OGpjBo+5XhsrYVJgcc496aoMnE5WseE8THVu4JNTzgWN0SSNmtxi70c8jGQayGGpJ672JXJnhE9F3bPEyYoHFraSqe3u2ZwQEKkA+J8NroWYFp1ssAdphS+uv7zAqzk4aBLmuCc0r7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEDVgizYt4GRa2Gn036yws4I4xjA1X9qZo0d4FnWQM8=;
 b=l7gtyMegAv8cRxO+rE+e3ee8LU9n3QmdrGZG/DfqUnu6Ob9iDEtAwSU3+pMPRgl1T27idFyCHwL4Ev60c8aQA2dbNroyfyLXOymDiVpRNBGRWUsx2ensYgX0Foz6sRG8WyLEql+6Gli0rwBiloLQRgYLPk+5JlQnIQpfvWP2+mM=
Received: from DS7PR03CA0167.namprd03.prod.outlook.com (2603:10b6:5:3b2::22)
 by DS0PR12MB7994.namprd12.prod.outlook.com (2603:10b6:8:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 15:39:48 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:3b2:cafe::30) by DS7PR03CA0167.outlook.office365.com
 (2603:10b6:5:3b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 15:39:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 15:39:47 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 08:39:47 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 10:39:47 -0500
Received: from [172.19.71.207] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Oct 2025 08:39:46 -0700
Message-ID: <f4a9ad2a-9258-7b4b-9e46-19378e1fd76a@amd.com>
Date: Wed, 8 Oct 2025 08:39:46 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] accel/amdxdna: Resume power for creating and destroying
 hardware context
Content-Language: en-US
To: Mario Limonciello <superm1@kernel.org>, <ogabbay@kernel.org>,
	<quic_jhugo@quicinc.com>, <maciej.falkowski@linux.intel.com>,
	<dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <max.zhen@amd.com>, <sonal.santan@amd.com>
References: <20251008045324.4171807-1-lizhi.hou@amd.com>
 <bb0e5610-2c59-4d74-9585-d9238e7143d6@kernel.org>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <bb0e5610-2c59-4d74-9585-d9238e7143d6@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: lizhi.hou@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DS0PR12MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: b4b5ec25-a585-4699-ae54-08de0680e9a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qk4vZDJaRHAzVStGWEl5VkZSbXQwWXlGQ2hNZjB0TFRNUklCc3ZEWjlrdFlY?=
 =?utf-8?B?cXZ5UWZSRFAxZ2NFZzZqdDlHcUxVSHIzd1FIN25YYzBDV0krSUlQcFMxZU91?=
 =?utf-8?B?V2dVZVlYL05ZaU9tQnZCbGc5VkN1RUtINTRFb29Jam5yazY3YTZQNXY2eUJJ?=
 =?utf-8?B?bkkvZ3FicWYwQ1NIeHVQUWlNUGsvSnJJcEVMdThUNXJyUlFkWjhIZzRTaGpB?=
 =?utf-8?B?b3ZxTFd0V3hFek9uL2x3cEdTSHNXd0xLTjlFRXg4RWw1YnczODM2RDA3cnlQ?=
 =?utf-8?B?TW5kU0lhSHVuY0o2SU53ZHdYSnBGTGUyME83eThvUWFOcENSR3djTWh1cUxY?=
 =?utf-8?B?Z0NndjJUTnlVUlBhWjRhRm81elNlTzBrZ1o2ei8xK2lhK1JDNFBLbi80QzIz?=
 =?utf-8?B?ekYzT0ZsODFobGUxQndtSXh3Q05qL3RKcEdyNUZ5azJNWUR0WVFJNU1lRG8y?=
 =?utf-8?B?Y1BETzJEb1JXTXV1VlVPUkp4UFBIajNxNHVWb1pIL1ZPY2NoalgrUWsya1Jm?=
 =?utf-8?B?ZUVLNTM4eUdTaWhHU0QyZTJIWTRsUHZGeVVsUW9Cb1lDN0dta3ZDc0VXcW9u?=
 =?utf-8?B?SnRkb0E4eVQ3bDZGQ2liUmdMV00rNnByOU5aTnZnMjhoWXdDZzNjcUxvNnRZ?=
 =?utf-8?B?NGtpVUhRZTBBSitzYVBBT0JUc25PS05ObFhLRnhhMk9kSFdzRTZOVTVIU1N5?=
 =?utf-8?B?ekg2SjlrTHlzRXlsUE9zMW1Wb0RvamVNSHRsN2pSck1sTXZpMXJBS0VhOTkr?=
 =?utf-8?B?UlBqN0wvNlNTcDQwRFpoM01odmIzTUtSL21RU2kxVnV4MW9iR09IM2NCVG9z?=
 =?utf-8?B?cDg3ZE01R0NISmRqWDY3S3hQNWNKNWE0OTNiS2JtcHcwMUgrSXFFelptcFBk?=
 =?utf-8?B?c1lJbTlUVGZ4MDR4bThXampyOENIRGJERmZuYVp0Z1VCN0NlM0xkYUhPNFBJ?=
 =?utf-8?B?NlhUVlUvb3owVWlRcUZwd05QTTczVjVVQ25XdEpjZVpGOE1UNXZwdklPcDZs?=
 =?utf-8?B?dEpGODZRK2FQRkFTSlFRdVZHaExQQXdDNmlFTXFHdWVQMldDZC9mM3pxQUhL?=
 =?utf-8?B?ZTk5U0c3dkFGbWdOVjdpUHc1b2FhTlRYK1ZmRHVzRWlOVkdMNWRYZC83YnRF?=
 =?utf-8?B?S3pNcnVMK2xyUnB0dG5Dak93QWpRbjFRcTRFV1dmTUlwalZOVVd0VCtkL1hp?=
 =?utf-8?B?TkJYYWJQRDNLeDhPY1pjalBvMDNIbFlTdFZnQ2l2VTlDQVhUODV3Y0J0NzVs?=
 =?utf-8?B?R0RPeEJpN25hdTh1V3FDZjN2aWNyS1RtNXBZckpDdTFMZHk3N2FoTnNhdUw0?=
 =?utf-8?B?WnVVMSt1OHoyTmlDdVptUUdZODZESzNZakFuOFlvb0plZ2ZSbUV1aEpUWUww?=
 =?utf-8?B?OWtQL1E4WjhCNWlQUUVlSkc5bDBnZzMwVmxMYTZSOXNaK2tCNmk1elZBUHNr?=
 =?utf-8?B?aCtFZnovM3dDbTNLenJ6aW1pSXNncXBpa1dvRG5ENlFtR2JnZXhBQlg1V1A0?=
 =?utf-8?B?akhiWUxhcFNSdnVTZ2M3S2lqR3AySmhIb2QzWUQvNTNsZHBjc2s5WlBPV0Zs?=
 =?utf-8?B?N1FEN3ZlVGFxZitMRng4M1RhUmF0Vm9lOEYxblREMktFVHVLRkdocVd0NFJV?=
 =?utf-8?B?WWh5Y1RJMFlUNmVSUnlDK1FHMVRjSUVLSk9IUERDQURNR0EzeDIyNzhTQkVO?=
 =?utf-8?B?c2UxbU5IcE50SUtVWnJBNUVRbDl0OEMvVG1SZmxaSzZyNkRuS3lKSWtsQnlF?=
 =?utf-8?B?WUsyTHBGay9HOHhNck14eFdVVHk2eHQ4OWkyMnRLSEpWcFhQQmtMV05SUnZm?=
 =?utf-8?B?dkV6UVJXWE9uSEdVTmtWVjJBRFpKSUhSSkVYZVlYLysvTmJOODN3aXdkSnZm?=
 =?utf-8?B?MXpxbHFlbmhNMnVsdXVGT1U1YUlZa3Z1VVgvQytFT25MN1B1NFRDY3VUUHkz?=
 =?utf-8?B?WmZVekExMHRhbXVkamNsUmFSUjI1YmhyUHBLRnI3L2xndmloSXFFcDAydlFB?=
 =?utf-8?B?WjVsakREckM0eS9rTjliVWhSMTNrcTJmalNkSmZiNkNwSk1RNlpBL0h1RU5y?=
 =?utf-8?B?WTBCaWQ0OXg5c0dlbG1HSHcvbUJObWdkQ2pJVE5kQlhhRUNMMVZKZ3BCTTYv?=
 =?utf-8?Q?+M4M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 15:39:47.7973
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4b5ec25-a585-4699-ae54-08de0680e9a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7994

Applied to drm-misc-next

On 10/8/25 08:03, Mario Limonciello wrote:
> On 10/7/25 11:53 PM, Lizhi Hou wrote:
>> When the hardware is powered down by auto-suspend, creating or 
>> destroying
>> a hardware context without resuming power will fail.
>> Call amdxdna_pm_resume_get() before requesting the hardware to create or
>> destroy a hardware context.
>>
>> Fixes: 063db451832b ("accel/amdxdna: Enhance runtime power management")
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>
>> ---
>>   drivers/accel/amdxdna/aie2_ctx.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c 
>> b/drivers/accel/amdxdna/aie2_ctx.c
>> index 691fdb3b008f..ab4d66f1325d 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -610,10 +610,14 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>           goto free_entity;
>>       }
>>   +    ret = amdxdna_pm_resume_get(xdna);
>> +    if (ret)
>> +        goto free_col_list;
>> +
>>       ret = aie2_alloc_resource(hwctx);
>>       if (ret) {
>>           XDNA_ERR(xdna, "Alloc hw resource failed, ret %d", ret);
>> -        goto free_col_list;
>> +        goto suspend_put;
>>       }
>>         ret = aie2_map_host_buf(xdna->dev_handle, hwctx->fw_ctx_id,
>> @@ -628,6 +632,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>           XDNA_ERR(xdna, "Create syncobj failed, ret %d", ret);
>>           goto release_resource;
>>       }
>> +    amdxdna_pm_suspend_put(xdna);
>>         hwctx->status = HWCTX_STAT_INIT;
>>       ndev = xdna->dev_handle;
>> @@ -640,6 +645,8 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx)
>>     release_resource:
>>       aie2_release_resource(hwctx);
>> +suspend_put:
>> +    amdxdna_pm_suspend_put(xdna);
>>   free_col_list:
>>       kfree(hwctx->col_list);
>>   free_entity:
>

