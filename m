Return-Path: <linux-kernel+bounces-774074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 281EEB2AE54
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 827394E7724
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305B8340DA5;
	Mon, 18 Aug 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FbGqX48V"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2057.outbound.protection.outlook.com [40.107.237.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C196E35A293
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 16:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755535118; cv=fail; b=Oc8yFb6KODVG55nSljyVh3XZqdnqpb6rgelfub6PaFC5Fi/W32G6/Pa+gzriUxKsEbgS992RTJcVqnY4AwnGkF7gBJhLEtNdcx+sq+bmfbS1nnBW7bICyvV0Ut6XtcyXaGB5HSdKzvwCv7ZLrBSqFGRKdeYFcW/ipR5yZsUnT8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755535118; c=relaxed/simple;
	bh=4mArL5MWsM2Cdb1RG6L9AvnROPA90zyISrRJ3xspZGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aezooeZFTFVDZz0JZAT/0P8ty+OZ0TS1dGTTJRiopN3VQyJUL4WvWOUJySzYolkNkzj4MPdBY8cmzAATsL3v45Q/lVv/XPXDw/u9cZOe1Mpo+tSCqX6t8JJywNU4KOlmZdNU4F8dPxbyQYtOJjbr3yj6HMSR4q/TWONV3HAVn58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FbGqX48V; arc=fail smtp.client-ip=40.107.237.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JlcsgoA9hwZ+mDQeQ2Mg1yjvu2h56KL4//OCdqDF999PlNFakdpsjDCUDk2iJw/hb647J/ScLSRH/SGEHhJljKaoLcaLRt7V/5KfHPrT5yxxk+B1HH9q9pakAK5hK107IKCegWy1svo3NcmGYUTraAwmUu/sRxYuytjtGi3SZP5e5yx/4u6ze9f+Op15y+EHQwoWj8UeYoSzUeiDbY+BWGtOZ5Zg2+A9kXCXH9bJV++1efROk5B4PZFpW9Bjfo+xH5RHTxJNJzoLxjSl4rOlq1UopJ1Wr7/EYzdFBZah/L72zP+JUlsSuKQdb9lYDdNBeG799z+kBZO0ESWupRi3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XMveDw7j+RG7OCCUF0laeHhU5GCkfOiKfDDjX4/X1o=;
 b=vzkCo/pC8FP6CoJofdhiZehr6bR91pC/lVWzAj1dXXIcXMoPAFdZSyMWDDR/Xaojj3PINmpjIguBB4ln9Dga2vc5xFwRzUY510ZOoWA4rCzG2xUXzeCRq3jZLXolee3EKwa9nurXTYvnzEEV/aKBr15dlWkNMXk5LzoYwmEdgZiUlj6EhshkUTLpjim7ZCiQG1MQoM6POYW6YmY4jWmbakr0kmj6uEhxsArw2u/pPz7ya3D8Q4CnMZHjXmkvGi0tiNuIvGBjRQ3ed7DFaTAX0BQQi9a/r8WXSsceMB3Xj3cPVMKc6OOATW75ecNbVnGLxg+Yy0Xi6skxryW9ZPzkYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XMveDw7j+RG7OCCUF0laeHhU5GCkfOiKfDDjX4/X1o=;
 b=FbGqX48Vay3Dr0wTrQ9Oyb/nH2mxma4t631eCllmd+tYz9t4M+kTEBwzbHkAfUiNUi6KoOocg7rw/0pTd9sIR5wmEgCu8HneVXM4mZbju7H8WOOqYJAeBRZ+M8nC9FCkec2/iigkKswgLJrbAMgYVL4S/cwv6/CkSpSP/3078B8=
Received: from SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::19)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 16:38:27 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:35e:cafe::a8) by SA1P222CA0089.outlook.office365.com
 (2603:10b6:806:35e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 16:38:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 16:38:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 11:38:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 11:38:26 -0500
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Aug 2025 11:38:25 -0500
Message-ID: <186f82a7-934f-d001-bab3-edc1e2b0e063@amd.com>
Date: Mon, 18 Aug 2025 09:38:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] accel/amdxdna: Add a function to walk hardware
 contexts
Content-Language: en-US
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, "ogabbay@kernel.org"
	<ogabbay@kernel.org>, "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
	"jacek.lawrynowicz@linux.intel.com" <jacek.lawrynowicz@linux.intel.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Zhen, Max"
	<Max.Zhen@amd.com>, "Santan, Sonal" <sonal.santan@amd.com>
References: <20250815171634.3417487-1-lizhi.hou@amd.com>
 <bc4d34db-ad0c-409a-b6ff-0e16b36e1cd2@amd.com>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <bc4d34db-ad0c-409a-b6ff-0e16b36e1cd2@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4831c817-59c0-4050-63be-08ddde75a806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjEraUNMYWRubFJwMWQ1S21sNnlzMytuUk5SaDVDZGRrak56M0RYSllvM3pu?=
 =?utf-8?B?dFdXdmpEVmNaN2lseHdZVGtvUnhESGFtUG9qaW1hRlpiVm80U21Jd2hETVpo?=
 =?utf-8?B?Zkw4dXY5NExDcG9raG9oR2tZcWdNYUcxeXQxeEtyd1hVK2hjU0IwNXhzNVpl?=
 =?utf-8?B?aU5WaFBFSGVQQWRNMU9VZGhZU1dFdzVIUlZBYTlFUmFQWlJ2eUxTZXN6bkpF?=
 =?utf-8?B?d0JQaGMvZm5jK3k3MmtsUm9qU0FCN0k3V1lqbC9aMzBSKzVhOCs3MytlT0pI?=
 =?utf-8?B?N2UrVXh3WC9Mb0YxUEpnTFJkM08zY2RoODdBMEwzT0FuVlJuVFI2OXl0WWx1?=
 =?utf-8?B?d3lQdWp5bVhxZGlWL3NFeXFkSW5qRk1DWXFqaXlMdGJGSjBoV1RLek8zRkJB?=
 =?utf-8?B?a2pQa3BOaHQvczJhRU16eFNRd2Rkay9Rand6VnhRUXFoK24rbDF5dXVGZUMz?=
 =?utf-8?B?aHJCaDRXUGlQT2RmaUpXNTF6Y0N3UDhUdWs4TENBVUtmWnhjYjFlM3FMTFVC?=
 =?utf-8?B?cXovRVNOejE4VEx3MkRBM1Q4eTVnc0VDUmx4QVdpUzhPZTkvQXpxeGdDZ1pT?=
 =?utf-8?B?Y2p0cjJCdTBFQ2NZY3dodzA4L0FMQzNBSEx0TFNkN0V5eTRnb2dmU20zS1NM?=
 =?utf-8?B?RHJXaHFLZHpmU1ZmcU56aUlnbVI2R1M3TUlFQ2pnelNpaXJWbjV4cm9CUTRR?=
 =?utf-8?B?SlR3QXo1d0NneW02VDZqSS9TNC8yVC9PNFdpY0Zrckg0UWljUWtHRUhicFZz?=
 =?utf-8?B?UmhkT0d1cWNEZlh5RG9vNW5oRXlMVUhXd1VzSFludm0zTFQra0hSUS9iRkZ5?=
 =?utf-8?B?OTdRbnVwSzFOaitudFFibzZabVBEYmNGRFp6ckl5N0RNWldtY2ZRdGtlNlRq?=
 =?utf-8?B?ZWJXMzZVVlRZYjdkeTc1TnlTdUFSQXJaZC9XRkRoTHAxVm9NVFZodlNSQ21L?=
 =?utf-8?B?NXlwMVRmdkt3UWNsdmR3dmtTMXlhLzJhWmFGVGkyWUFaMHRuVVVmRjk0VkJY?=
 =?utf-8?B?ZGNCU1RCWE5WbTFBTWVRVWFXUHZYUllaSkFlR2pZNVJjTHBMM3F2aHNHUEJI?=
 =?utf-8?B?eUFUN2YrbzkxK3pjZm13QW1SbzdKbUR4cmdGUEhKNi8xSkVJU003NnZjaWpK?=
 =?utf-8?B?ekpwRU1TWlhGOFBsYyt4V1NZVm5ZNW9uVGU2ZDJFZ2N4ZVhuUVcyeEd5aFJy?=
 =?utf-8?B?WnpiV2NuSmFxcHk4ZWRtdTg4Y1Q4aGh2SWU5QkdvYWJTUG9XM0ttbjBNdlBU?=
 =?utf-8?B?S2JnYXpscWZuWXgrYWtCYTBUWVJDUFRuWkluV0Z3dkIrbjVXWnBMeWdTNS8z?=
 =?utf-8?B?SFVhWVNRY2pXNDZqTkdTcGNaWitWeTFDWWVvbTZobk5QWkZQdW9GTWljRVUx?=
 =?utf-8?B?TWJTMEZZa3R0USt5ZGJ2TU5FQVJhOXFrUTB1L092cTJ0QTFnNVRzYjY1K0Vz?=
 =?utf-8?B?TENXRExOZHg3dkFsZ242ZmorM2kvbjE1cE9GMUZ1UElibllvV3J1MTFDZVox?=
 =?utf-8?B?MTY1ZncvaEdpUFV3RUJzY2JxeDhPU0p6WHVQbEhQbWVtaktMbjBzUXhtNXFR?=
 =?utf-8?B?N3pUM2dyQjkycTdOdWNERllrQ3c3L1JlUGJjeWI1cUQxS25yOUs2S2FLeFRI?=
 =?utf-8?B?SnVaN2lYdWh2aUZ1M1JZdFRYR0p2Q0M4S1dUT3NjQ2NPeVRDQUJxTzNXVmRC?=
 =?utf-8?B?Z0QzaHpMU0dhVUVmQzQrZlVPOFlsNEpSNTBidFJoaDZITGUrSXoyMGROV0Qy?=
 =?utf-8?B?SFJranJ1V1dvYUNKLzdBSDA3c1YyNk9TYXNKRlA0Vm54ZXliNlhaTm9UNmxh?=
 =?utf-8?B?aDRSZGZmb3hEQjhlRkJTQWIxcDliMS94MmxwdjIxdTVZem1odkV0dHp1MlFM?=
 =?utf-8?B?QjNaSHRvRyt5TUhUb0grQUxxQUpNTGJGN3p3ZHlLdHcxUmp2b2V6T1k4M3VR?=
 =?utf-8?B?Vnd4TGVjdUZXWTd1bWxLQzd6MlR5ZFZiRHFVc2hua2lnc05ZZS9reGRaOW81?=
 =?utf-8?B?Mnd5WG1PRXdzSU1ORXFoNy9OL0VNVkhWMlJJTUtHUFE1Z3Nra1Y2ZWhwRytt?=
 =?utf-8?Q?nbkMkv?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 16:38:26.7322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4831c817-59c0-4050-63be-08ddde75a806
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

Applied to drm-misc-next

Thanks,

Lizhi

On 8/15/25 13:43, Limonciello, Mario wrote:
> On 8/15/25 12:16 PM, Lizhi Hou wrote:
>> Walking hardware contexts created by a process is duplicated in multiple
>> spots. Add a function, amdxdna_hwctx_walk(), and replace all spots.
>>
>> hwctx_srcu and dev_lock are good enough to protect hardware context list.
>> Remove hwctx_lock.
>>
>> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>
>> ---
>>    drivers/accel/amdxdna/aie2_ctx.c        | 38 +++++-----
>>    drivers/accel/amdxdna/aie2_message.c    | 21 +++---
>>    drivers/accel/amdxdna/aie2_pci.c        | 93 ++++++++++++-------------
>>    drivers/accel/amdxdna/aie2_pci.h        |  2 +-
>>    drivers/accel/amdxdna/amdxdna_ctx.c     | 26 +++++--
>>    drivers/accel/amdxdna/amdxdna_ctx.h     |  8 +--
>>    drivers/accel/amdxdna/amdxdna_pci_drv.c |  7 +-
>>    drivers/accel/amdxdna/amdxdna_pci_drv.h |  2 -
>>    8 files changed, 102 insertions(+), 95 deletions(-)
>>
>> diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
>> index 910ffb7051f4..420467a5325c 100644
>> --- a/drivers/accel/amdxdna/aie2_ctx.c
>> +++ b/drivers/accel/amdxdna/aie2_ctx.c
>> @@ -133,11 +133,20 @@ static void aie2_hwctx_wait_for_idle(struct amdxdna_hwctx *hwctx)
>>    	dma_fence_put(fence);
>>    }
>>    
>> +static int aie2_hwctx_suspend_cb(struct amdxdna_hwctx *hwctx, void *arg)
>> +{
>> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
>> +
>> +	aie2_hwctx_wait_for_idle(hwctx);
>> +	aie2_hwctx_stop(xdna, hwctx, NULL);
>> +	aie2_hwctx_status_shift_stop(hwctx);
>> +
>> +	return 0;
>> +}
>> +
>>    void aie2_hwctx_suspend(struct amdxdna_client *client)
>>    {
>>    	struct amdxdna_dev *xdna = client->xdna;
>> -	struct amdxdna_hwctx *hwctx;
>> -	unsigned long hwctx_id;
>>    
>>    	/*
>>    	 * Command timeout is unlikely. But if it happens, it doesn't
>> @@ -145,19 +154,20 @@ void aie2_hwctx_suspend(struct amdxdna_client *client)
>>    	 * and abort all commands.
>>    	 */
>>    	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>> -	guard(mutex)(&client->hwctx_lock);
>> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> -		aie2_hwctx_wait_for_idle(hwctx);
>> -		aie2_hwctx_stop(xdna, hwctx, NULL);
>> -		aie2_hwctx_status_shift_stop(hwctx);
>> -	}
>> +	amdxdna_hwctx_walk(client, NULL, aie2_hwctx_suspend_cb);
>>    }
>>    
>> -void aie2_hwctx_resume(struct amdxdna_client *client)
>> +static int aie2_hwctx_resume_cb(struct amdxdna_hwctx *hwctx, void *arg)
>> +{
>> +	struct amdxdna_dev *xdna = hwctx->client->xdna;
>> +
>> +	aie2_hwctx_status_restore(hwctx);
>> +	return aie2_hwctx_restart(xdna, hwctx);
>> +}
>> +
>> +int aie2_hwctx_resume(struct amdxdna_client *client)
>>    {
>>    	struct amdxdna_dev *xdna = client->xdna;
>> -	struct amdxdna_hwctx *hwctx;
>> -	unsigned long hwctx_id;
>>    
>>    	/*
>>    	 * The resume path cannot guarantee that mailbox channel can be
>> @@ -165,11 +175,7 @@ void aie2_hwctx_resume(struct amdxdna_client *client)
>>    	 * mailbox channel, error will return.
>>    	 */
>>    	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>> -	guard(mutex)(&client->hwctx_lock);
>> -	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> -		aie2_hwctx_status_restore(hwctx);
>> -		aie2_hwctx_restart(xdna, hwctx);
>> -	}
>> +	return amdxdna_hwctx_walk(client, NULL, aie2_hwctx_resume_cb);
>>    }
>>    
>>    static void
>> diff --git a/drivers/accel/amdxdna/aie2_message.c b/drivers/accel/amdxdna/aie2_message.c
>> index 82412eec9a4b..9caad083543d 100644
>> --- a/drivers/accel/amdxdna/aie2_message.c
>> +++ b/drivers/accel/amdxdna/aie2_message.c
>> @@ -290,18 +290,25 @@ int aie2_map_host_buf(struct amdxdna_dev_hdl *ndev, u32 context_id, u64 addr, u6
>>    	return 0;
>>    }
>>    
>> +static int amdxdna_hwctx_col_map(struct amdxdna_hwctx *hwctx, void *arg)
>> +{
>> +	u32 *bitmap = arg;
>> +
>> +	*bitmap |= GENMASK(hwctx->start_col + hwctx->num_col - 1, hwctx->start_col);
>> +
>> +	return 0;
>> +}
>> +
>>    int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>>    		      u32 size, u32 *cols_filled)
>>    {
>>    	DECLARE_AIE2_MSG(aie_column_info, MSG_OP_QUERY_COL_STATUS);
>>    	struct amdxdna_dev *xdna = ndev->xdna;
>>    	struct amdxdna_client *client;
>> -	struct amdxdna_hwctx *hwctx;
>> -	unsigned long hwctx_id;
>>    	dma_addr_t dma_addr;
>>    	u32 aie_bitmap = 0;
>>    	u8 *buff_addr;
>> -	int ret, idx;
>> +	int ret;
>>    
>>    	buff_addr = dma_alloc_noncoherent(xdna->ddev.dev, size, &dma_addr,
>>    					  DMA_FROM_DEVICE, GFP_KERNEL);
>> @@ -309,12 +316,8 @@ int aie2_query_status(struct amdxdna_dev_hdl *ndev, char __user *buf,
>>    		return -ENOMEM;
>>    
>>    	/* Go through each hardware context and mark the AIE columns that are active */
>> -	list_for_each_entry(client, &xdna->client_list, node) {
>> -		idx = srcu_read_lock(&client->hwctx_srcu);
>> -		amdxdna_for_each_hwctx(client, hwctx_id, hwctx)
>> -			aie_bitmap |= amdxdna_hwctx_col_map(hwctx);
>> -		srcu_read_unlock(&client->hwctx_srcu, idx);
>> -	}
>> +	list_for_each_entry(client, &xdna->client_list, node)
>> +		amdxdna_hwctx_walk(client, &aie_bitmap, amdxdna_hwctx_col_map);
>>    
>>    	*cols_filled = 0;
>>    	req.dump_buff_addr = dma_addr;
>> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
>> index 6fc3191c3097..16ac0cab4f44 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.c
>> +++ b/drivers/accel/amdxdna/aie2_pci.c
>> @@ -10,6 +10,7 @@
>>    #include <drm/drm_managed.h>
>>    #include <drm/drm_print.h>
>>    #include <drm/gpu_scheduler.h>
>> +#include <linux/cleanup.h>
>>    #include <linux/errno.h>
>>    #include <linux/firmware.h>
>>    #include <linux/iommu.h>
>> @@ -465,8 +466,11 @@ static int aie2_hw_resume(struct amdxdna_dev *xdna)
>>    		return ret;
>>    	}
>>    
>> -	list_for_each_entry(client, &xdna->client_list, node)
>> -		aie2_hwctx_resume(client);
>> +	list_for_each_entry(client, &xdna->client_list, node) {
>> +		ret = aie2_hwctx_resume(client);
>> +		if (ret)
>> +			break;
>> +	}
>>    
>>    	return ret;
>>    }
>> @@ -779,65 +783,56 @@ static int aie2_get_clock_metadata(struct amdxdna_client *client,
>>    	return ret;
>>    }
>>    
>> +static int aie2_hwctx_status_cb(struct amdxdna_hwctx *hwctx, void *arg)
>> +{
>> +	struct amdxdna_drm_query_hwctx __user *buf, *tmp __free(kfree) = NULL;
>> +	struct amdxdna_drm_get_info *get_info_args = arg;
>> +
>> +	if (get_info_args->buffer_size < sizeof(*tmp))
>> +		return -EINVAL;
>> +
>> +	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
>> +	if (!tmp)
>> +		return -ENOMEM;
>> +
>> +	tmp->pid = hwctx->client->pid;
>> +	tmp->context_id = hwctx->id;
>> +	tmp->start_col = hwctx->start_col;
>> +	tmp->num_col = hwctx->num_col;
>> +	tmp->command_submissions = hwctx->priv->seq;
>> +	tmp->command_completions = hwctx->priv->completed;
>> +
>> +	buf = u64_to_user_ptr(get_info_args->buffer);
>> +
>> +	if (copy_to_user(buf, tmp, sizeof(*tmp)))
>> +		return -EFAULT;
>> +
>> +	get_info_args->buffer += sizeof(*tmp);
>> +	get_info_args->buffer_size -= sizeof(*tmp);
>> +
>> +	return 0;
>> +}
>> +
>>    static int aie2_get_hwctx_status(struct amdxdna_client *client,
>>    				 struct amdxdna_drm_get_info *args)
>>    {
>> -	struct amdxdna_drm_query_hwctx __user *buf;
>>    	struct amdxdna_dev *xdna = client->xdna;
>> -	struct amdxdna_drm_query_hwctx *tmp;
>> +	struct amdxdna_drm_get_info info_args;
>>    	struct amdxdna_client *tmp_client;
>> -	struct amdxdna_hwctx *hwctx;
>> -	unsigned long hwctx_id;
>> -	bool overflow = false;
>> -	u32 req_bytes = 0;
>> -	u32 hw_i = 0;
>> -	int ret = 0;
>> -	int idx;
>> +	int ret;
>>    
>>    	drm_WARN_ON(&xdna->ddev, !mutex_is_locked(&xdna->dev_lock));
>>    
>> -	tmp = kzalloc(sizeof(*tmp), GFP_KERNEL);
>> -	if (!tmp)
>> -		return -ENOMEM;
>> +	info_args.buffer = args->buffer;
>> +	info_args.buffer_size = args->buffer_size;
>>    
>> -	buf = u64_to_user_ptr(args->buffer);
>>    	list_for_each_entry(tmp_client, &xdna->client_list, node) {
>> -		idx = srcu_read_lock(&tmp_client->hwctx_srcu);
>> -		amdxdna_for_each_hwctx(tmp_client, hwctx_id, hwctx) {
>> -			req_bytes += sizeof(*tmp);
>> -			if (args->buffer_size < req_bytes) {
>> -				/* Continue iterating to get the required size */
>> -				overflow = true;
>> -				continue;
>> -			}
>> -
>> -			memset(tmp, 0, sizeof(*tmp));
>> -			tmp->pid = tmp_client->pid;
>> -			tmp->context_id = hwctx->id;
>> -			tmp->start_col = hwctx->start_col;
>> -			tmp->num_col = hwctx->num_col;
>> -			tmp->command_submissions = hwctx->priv->seq;
>> -			tmp->command_completions = hwctx->priv->completed;
>> -
>> -			if (copy_to_user(&buf[hw_i], tmp, sizeof(*tmp))) {
>> -				ret = -EFAULT;
>> -				srcu_read_unlock(&tmp_client->hwctx_srcu, idx);
>> -				goto out;
>> -			}
>> -			hw_i++;
>> -		}
>> -		srcu_read_unlock(&tmp_client->hwctx_srcu, idx);
>> -	}
>> -
>> -	if (overflow) {
>> -		XDNA_ERR(xdna, "Invalid buffer size. Given: %u Need: %u.",
>> -			 args->buffer_size, req_bytes);
>> -		ret = -EINVAL;
>> +		ret = amdxdna_hwctx_walk(tmp_client, &info_args, aie2_hwctx_status_cb);
>> +		if (ret)
>> +			break;
>>    	}
>>    
>> -out:
>> -	kfree(tmp);
>> -	args->buffer_size = req_bytes;
>> +	args->buffer_size = (u32)(info_args.buffer - args->buffer);
>>    	return ret;
>>    }
>>    
>> diff --git a/drivers/accel/amdxdna/aie2_pci.h b/drivers/accel/amdxdna/aie2_pci.h
>> index 488d8ee568eb..91a8e948f82a 100644
>> --- a/drivers/accel/amdxdna/aie2_pci.h
>> +++ b/drivers/accel/amdxdna/aie2_pci.h
>> @@ -289,7 +289,7 @@ int aie2_hwctx_init(struct amdxdna_hwctx *hwctx);
>>    void aie2_hwctx_fini(struct amdxdna_hwctx *hwctx);
>>    int aie2_hwctx_config(struct amdxdna_hwctx *hwctx, u32 type, u64 value, void *buf, u32 size);
>>    void aie2_hwctx_suspend(struct amdxdna_client *client);
>> -void aie2_hwctx_resume(struct amdxdna_client *client);
>> +int aie2_hwctx_resume(struct amdxdna_client *client);
>>    int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq);
>>    void aie2_hmm_invalidate(struct amdxdna_gem_obj *abo, unsigned long cur_seq);
>>    
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.c b/drivers/accel/amdxdna/amdxdna_ctx.c
>> index b47a7f8e9017..4bfe4ef20550 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.c
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.c
>> @@ -68,14 +68,30 @@ static void amdxdna_hwctx_destroy_rcu(struct amdxdna_hwctx *hwctx,
>>    	synchronize_srcu(ss);
>>    
>>    	/* At this point, user is not able to submit new commands */
>> -	mutex_lock(&xdna->dev_lock);
>>    	xdna->dev_info->ops->hwctx_fini(hwctx);
>> -	mutex_unlock(&xdna->dev_lock);
>>    
>>    	kfree(hwctx->name);
>>    	kfree(hwctx);
>>    }
>>    
>> +int amdxdna_hwctx_walk(struct amdxdna_client *client, void *arg,
>> +		       int (*walk)(struct amdxdna_hwctx *hwctx, void *arg))
>> +{
>> +	struct amdxdna_hwctx *hwctx;
>> +	unsigned long hwctx_id;
>> +	int ret = 0, idx;
>> +
>> +	idx = srcu_read_lock(&client->hwctx_srcu);
>> +	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>> +		ret = walk(hwctx, arg);
>> +		if (ret)
>> +			break;
>> +	}
>> +	srcu_read_unlock(&client->hwctx_srcu, idx);
>> +
>> +	return ret;
>> +}
>> +
>>    void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size)
>>    {
>>    	struct amdxdna_cmd *cmd = abo->mem.kva;
>> @@ -126,16 +142,12 @@ void amdxdna_hwctx_remove_all(struct amdxdna_client *client)
>>    	struct amdxdna_hwctx *hwctx;
>>    	unsigned long hwctx_id;
>>    
>> -	mutex_lock(&client->hwctx_lock);
>>    	amdxdna_for_each_hwctx(client, hwctx_id, hwctx) {
>>    		XDNA_DBG(client->xdna, "PID %d close HW context %d",
>>    			 client->pid, hwctx->id);
>>    		xa_erase(&client->hwctx_xa, hwctx->id);
>> -		mutex_unlock(&client->hwctx_lock);
>>    		amdxdna_hwctx_destroy_rcu(hwctx, &client->hwctx_srcu);
>> -		mutex_lock(&client->hwctx_lock);
>>    	}
>> -	mutex_unlock(&client->hwctx_lock);
>>    }
>>    
>>    int amdxdna_drm_create_hwctx_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>> @@ -225,6 +237,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
>>    	if (!drm_dev_enter(dev, &idx))
>>    		return -ENODEV;
>>    
>> +	mutex_lock(&xdna->dev_lock);
>>    	hwctx = xa_erase(&client->hwctx_xa, args->handle);
>>    	if (!hwctx) {
>>    		ret = -EINVAL;
>> @@ -241,6 +254,7 @@ int amdxdna_drm_destroy_hwctx_ioctl(struct drm_device *dev, void *data, struct d
>>    
>>    	XDNA_DBG(xdna, "PID %d destroyed HW context %d", client->pid, args->handle);
>>    out:
>> +	mutex_unlock(&xdna->dev_lock);
>>    	drm_dev_exit(idx);
>>    	return ret;
>>    }
>> diff --git a/drivers/accel/amdxdna/amdxdna_ctx.h b/drivers/accel/amdxdna/amdxdna_ctx.h
>> index c652229547a3..7cd7a55936f0 100644
>> --- a/drivers/accel/amdxdna/amdxdna_ctx.h
>> +++ b/drivers/accel/amdxdna/amdxdna_ctx.h
>> @@ -139,14 +139,10 @@ amdxdna_cmd_get_state(struct amdxdna_gem_obj *abo)
>>    void *amdxdna_cmd_get_payload(struct amdxdna_gem_obj *abo, u32 *size);
>>    int amdxdna_cmd_get_cu_idx(struct amdxdna_gem_obj *abo);
>>    
>> -static inline u32 amdxdna_hwctx_col_map(struct amdxdna_hwctx *hwctx)
>> -{
>> -	return GENMASK(hwctx->start_col + hwctx->num_col - 1,
>> -		       hwctx->start_col);
>> -}
>> -
>>    void amdxdna_sched_job_cleanup(struct amdxdna_sched_job *job);
>>    void amdxdna_hwctx_remove_all(struct amdxdna_client *client);
>> +int amdxdna_hwctx_walk(struct amdxdna_client *client, void *arg,
>> +		       int (*walk)(struct amdxdna_hwctx *hwctx, void *arg));
>>    
>>    int amdxdna_cmd_submit(struct amdxdna_client *client,
>>    		       u32 cmd_bo_hdls, u32 *arg_bo_hdls, u32 arg_bo_cnt,
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> index fbca94183f96..8ef5e4f27f5e 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
>> @@ -81,7 +81,6 @@ static int amdxdna_drm_open(struct drm_device *ddev, struct drm_file *filp)
>>    		ret = -ENODEV;
>>    		goto unbind_sva;
>>    	}
>> -	mutex_init(&client->hwctx_lock);
>>    	init_srcu_struct(&client->hwctx_srcu);
>>    	xa_init_flags(&client->hwctx_xa, XA_FLAGS_ALLOC);
>>    	mutex_init(&client->mm_lock);
>> @@ -116,7 +115,6 @@ static void amdxdna_drm_close(struct drm_device *ddev, struct drm_file *filp)
>>    
>>    	xa_destroy(&client->hwctx_xa);
>>    	cleanup_srcu_struct(&client->hwctx_srcu);
>> -	mutex_destroy(&client->hwctx_lock);
>>    	mutex_destroy(&client->mm_lock);
>>    	if (client->dev_heap)
>>    		drm_gem_object_put(to_gobj(client->dev_heap));
>> @@ -142,8 +140,8 @@ static int amdxdna_flush(struct file *f, fl_owner_t id)
>>    
>>    	mutex_lock(&xdna->dev_lock);
>>    	list_del_init(&client->node);
>> -	mutex_unlock(&xdna->dev_lock);
>>    	amdxdna_hwctx_remove_all(client);
>> +	mutex_unlock(&xdna->dev_lock);
>>    
>>    	drm_dev_exit(idx);
>>    	return 0;
>> @@ -330,11 +328,8 @@ static void amdxdna_remove(struct pci_dev *pdev)
>>    					  struct amdxdna_client, node);
>>    	while (client) {
>>    		list_del_init(&client->node);
>> -		mutex_unlock(&xdna->dev_lock);
>> -
>>    		amdxdna_hwctx_remove_all(client);
>>    
>> -		mutex_lock(&xdna->dev_lock);
>>    		client = list_first_entry_or_null(&xdna->client_list,
>>    						  struct amdxdna_client, node);
>>    	}
>> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.h b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> index 40bbb3c06320..b6b3b424d1d5 100644
>> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.h
>> @@ -116,8 +116,6 @@ struct amdxdna_device_id {
>>    struct amdxdna_client {
>>    	struct list_head		node;
>>    	pid_t				pid;
>> -	struct mutex			hwctx_lock; /* protect hwctx */
>> -	/* do NOT wait this srcu when hwctx_lock is held */
>>    	struct srcu_struct		hwctx_srcu;
>>    	struct xarray			hwctx_xa;
>>    	u32				next_hwctxid;

