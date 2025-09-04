Return-Path: <linux-kernel+bounces-801810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03A3B44A36
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 01:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE6F316C3EB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D922EE262;
	Thu,  4 Sep 2025 23:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iqWjeYP1"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD72F60A3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 23:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757027259; cv=fail; b=VrbC6OXEf2MOeNNvwQ+TQ+biDM0Fw91Dvm6Pk+JF72sEGQMjiIkTMDd3d5NOOButlVcoqndNDWQvJMjjCtjtWJke0P8uQ1uLmr7oEbjXnWH8wi/50AwR13PJpJBWquMzOJlIX9RQMEIsz4Ey6hKd7P37fmoH+ruhUiF2idfdDQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757027259; c=relaxed/simple;
	bh=9x2lyy+9LPCQ0Utl5JuI+yc0EAMoyqOizMQhXN57W3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gODgtq5co5d+qQ+wBAg2/JPO5LD/fZ4sI8i0ke6+JlJEUBwjx8mvko3On6nc1lUxnA2/xATgs8bAfOIQlE4NmOCEC6lDYInBMlZ4gQ26kRv3pmniHgJpBLdCjjf+brhLsO2Bh7A6sxPEkZgOKhNSFG4LGvzQMvTqAK6I98AaWx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iqWjeYP1; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UrhCP7p3KBZF+R/4uZKfMW90e9MJGUdmAKVmK0UP6rm9PRrst83+wi/pH2zRwq5X3ADTGLGGP0KpSa9BD+Svodch6l2xJEqfDk4XqEExZadoOQQOhTwWghmXPxYk1bek+9Hbj4266KBmn/F9811ttoOGSKm2mcq1jTDP/oobwMmGQVVuR/kBmOuxw+frXlYYLbBjqnxPi02K2uCpul683QXqiOBgBbBp6x345233Utj8g2EhlH6asSZB4kSWTzjA57bBEz7PzegCFF1XSI/2+/LsxABcgL8JF4M7wtamzuGEbGrE/enpzLTrqRsek0Semz//PAU1W9S+s8Ocn/4h2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ft8kdowHlIjGH7kMRtIbUmYbmF8v6L+VZgUSy9JqQvY=;
 b=lgY1QnIsGyeD4H0kMx48olLrVAgnkm35zAihnqpMWnaoAdSfBQlWCe5WksZ30/ccZs5r01Lgp8WHWc1MnMJLraSNdK2fZtiX2TkKJ7lYflpH6zlNCLcw86jwL54XljTiqrDZEYYh1TIlVFqfl7OojpRuk5YOMQEVkCg0DY7vU9twTzt8+DTl5HzTVWwzUtc2ZV8L2tLFt81G2y6APmXS9h5ejUl9ECp/abIhsX47YjvuVD0No6fV4etxRPoxrTGs5c62zBimUEB7hzbb8Br3ZbXLbKG58ZRcSVXKj4+MTGYpwCzkafBY9wwG96u1xCeitsH3kQq2T5x6pPYTp2B0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ft8kdowHlIjGH7kMRtIbUmYbmF8v6L+VZgUSy9JqQvY=;
 b=iqWjeYP1fd0FAFQa2LaiKvaj/TS/FS9nCf81DNZrgb4+EQ7oi4NYCN5JtIjs1g9x3y0AnW8oeMM8HAL4B1xgDSrQ2M6briTolT3dgp53Y7QerZD8trCeQGJ/Qe/EzXvmKZt+7TNhBx8ixccv8nSkGqQDZ9hEGBlFCDlCtRhO860=
Received: from PH0PR07CA0056.namprd07.prod.outlook.com (2603:10b6:510:e::31)
 by BN7PPF8FCE094C0.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 23:07:31 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::9e) by PH0PR07CA0056.outlook.office365.com
 (2603:10b6:510:e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Thu,
 4 Sep 2025 23:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Thu, 4 Sep 2025 23:07:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 18:07:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Thu, 4 Sep
 2025 16:07:30 -0700
Received: from [172.19.71.207] (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 4 Sep 2025 18:07:29 -0500
Message-ID: <8a1a1d26-c49d-b1e6-0164-32eee95db501@amd.com>
Date: Thu, 4 Sep 2025 16:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3] MAINTAINERS: Update Min Ma's email for AMD XDNA driver
Content-Language: en-US
To: Lucas De Marchi <lucas.demarchi@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <jacek.lawrynowicz@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <ogabbay@kernel.org>,
	<quic_jhugo@quicinc.com>, Min Ma <mamin506@gmail.com>
References: <dc0227cb-7e02-10c6-9790-2e2331ddfd6e@amd.com>
 <20250831001228.592-1-mamin506@gmail.com>
 <67138df3-115d-94cb-005f-84f6f56f5986@amd.com>
 <b2cb52b1-9bcc-b77a-ed9b-cf3dbaea1a71@amd.com>
 <igd27jsm2nmdqm6z6mvdgbe4nx4j2xiv4ki43q4637mvx2an2d@6i4phi3cpx2r>
From: Lizhi Hou <lizhi.hou@amd.com>
In-Reply-To: <igd27jsm2nmdqm6z6mvdgbe4nx4j2xiv4ki43q4637mvx2an2d@6i4phi3cpx2r>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|BN7PPF8FCE094C0:EE_
X-MS-Office365-Filtering-Correlation-Id: e9747513-e5aa-48e9-bca5-08ddec07d33e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UFJvVWhVUjR5dk1UN2xmVWhsU3p5RnZLNWwvampmSjg3bCswYUNpOWYzTW9V?=
 =?utf-8?B?Vk56andvNGtyNk5LajFVcGt5OE5Kdjh4allEUzR0cDBTUEs5Z1gycVFvV1pS?=
 =?utf-8?B?cnprWkR6WWp1ZEEzaTludzdXMzNrUzZ5R2Fkd1dmdkxuTzRYK3pZdS9oU3Vp?=
 =?utf-8?B?U0ZYelhaUXp3MVBIOC93T2Z2WnhhSDZFa0FkRlVhSTdUNkxYUnhmaVRVOS9h?=
 =?utf-8?B?TUVEc0ROZUdpeE1iWjJKWEhlWnZMNzV4dTFJbkEyM2lDQ2YxZ284WVNIRVA4?=
 =?utf-8?B?WFhaUjI2N0VRODNqbHIvMkNnK2NHaS9DSXV2WjR5WHBOZURvazJhYzdlVVRS?=
 =?utf-8?B?djNHSXV4Ni9WWllPb241MUdobHlOTkliQUVmYUF6cVFMVXEzZ3p0enE1SU5K?=
 =?utf-8?B?dkdhTlFFSG0rVXpxZ0dlbUpaSjlWWVBvL1BSYVpndUk4R2RnSmF2dU9ha2V4?=
 =?utf-8?B?aEhIMkljSkN5alVnMEQ0NDBsMjE0OVpnRDd4b3V1VnlZdHEvVklZNjlxTXlQ?=
 =?utf-8?B?Z2t4OGxwVzc3a0RLT004c0UyYk9RQndmd1czcHBJK3htUExGblZmeG9IY0Vj?=
 =?utf-8?B?MXZUTHgwYWdPUi81REJNa0NoVFRrc2tsWUxTSHc4d01ySDhWck96emtxVDRR?=
 =?utf-8?B?VVJkbmU2QXR3cWJ0MkFLMTl3dXdrZGRiV3lobkdPTUlzd2YwYjJ3TmF5aUp4?=
 =?utf-8?B?Z3JDRDltOSsrUUE5NXJqVUo2WXVzSVY4bFRHQkZVaVY4cjlUWDN1QldPdDVH?=
 =?utf-8?B?cUhQRHhlM1hJa0lITWwvRkw3WmJxM28vYkZWMnk3MW9tYVlWbndRWGxic2k3?=
 =?utf-8?B?MTRNZEZ6ZkZaN1NyQ3lNcXRpVDBScVAxT1dpeVlTWXNPbnVaRy94ZzBGenBa?=
 =?utf-8?B?NmVQcm91aTd2KzhiU01ZN1lZN3FDdVRDbm5IalQ3aGRxYU5KUkZiZG56ZHpp?=
 =?utf-8?B?clRrZ2lWT2F4TFVjZGh0Z2NoMDJKa1pnbk5oTnU3OUtVSU5uT2Zhc2s1NUR5?=
 =?utf-8?B?SnpsMGw0SlVNYStkalhDZEVxSXI4bnVpT0JLZENRZ0VUZ2RhTUtyWlFhaG5p?=
 =?utf-8?B?R2dtUURwakxuNDM0aUxIVy93bWcvYjVHVlRZN3pDTlBzdVkzUHpFS3ozTkR0?=
 =?utf-8?B?cmdmb3psR0RoK2I5VWNtdllDZ0RTNGhzQTlwbTBrL1EvNTdLeUVpTHNGNE1t?=
 =?utf-8?B?TWd6Um5WSmVQY0hhQjUrTFR3aE9RaUNGTWdxci9XQUtTeEZWMTB6dzQ1MWVE?=
 =?utf-8?B?Vjl6Q0Z1VmUzWGJZb0VlY1JzcHU1S1B1WmFpSDBiUkFrNmRiVWdCUWtmeGxQ?=
 =?utf-8?B?dVFtNEVmQ1ZYTXhYZFhrUlgrai8zRURMTTFrbXRqMlpQQnpLRWN2QmtXYncr?=
 =?utf-8?B?SGtYaVlRdWtxQTRqcTh1MFl5Zy93ZXJ4NHc5QUpyVXlpcENaMGNmaFJ5aitQ?=
 =?utf-8?B?dFZ6YnNoOWZONC96TnVCNGNtK3o3SSszSnF5MUFycnRQbStFblIydVIwQVBv?=
 =?utf-8?B?OFE4eXdmT0J6V0FNOFhVUllkUWpmb3ZIUDNBQVNZeHNPRnByL0YwTTBoaUxZ?=
 =?utf-8?B?alpLa3RTSnlDVFZvYjNDL0F2NmF3Zkl4RHA0Yk5vRjZiV0hUSlBxakY5Z3Zw?=
 =?utf-8?B?ZmdIbFRIb1doaGhESFVoRVN6K1VmbXhnVWpKeDZEK2IzeTBXZ0pBQWZ2NUZC?=
 =?utf-8?B?NXVMZE5wQmxMRVViQWNNckVQSTB5M2VnM1plTWo1eUEyQjdEWTJYbWhsU1pO?=
 =?utf-8?B?REtONjlZZ1VyUVJSbzlSZktnM2JnYml4NEZYOEZsMmFEbjJBbHBaY2FkZk1a?=
 =?utf-8?B?NHBLUXpmVEV1UnVnK3B1clQ0b1pSTEErSlI3YzNqb1NsdWE1Y1YxQ0Q4eDFh?=
 =?utf-8?B?dEpYZTc4UDMyMTRESVhKdnlxdkpUSEplRmdWSnhSRXp1c2FqazZhQzQxcFZx?=
 =?utf-8?B?eHArSUI5QlBSYmxKcEpYMlFHdDN0T3lNMWdSektRcDkvWVhTUGtINjR1VFRo?=
 =?utf-8?B?OG84a1BGbWVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 23:07:30.8083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9747513-e5aa-48e9-bca5-08ddec07d33e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF8FCE094C0

Thanks. Applied to drm-misc-next

On 9/4/25 10:50, Lucas De Marchi wrote:
> On Thu, Sep 04, 2025 at 10:15:42AM -0700, Lizhi Hou wrote:
>> Hi Lucas
>>
>> I got a dim error when applying this patch. Could you take a look? 
>> Maybe there is not a maintainer for MAINTAINERS? :)
>
> Yes. A little bit worse than that:
> https://gitlab.freedesktop.org/drm/maintainer-tools/-/merge_requests/83
>
> For now, please use `dim -f ...` to bypass this error.
>
> Lucas De Marchi
>
>>
>> dim: ERROR: a12586e4e737 ("MAINTAINERS: Update Min Ma's email for AMD 
>> XDNA driver"): Mandatory Maintainer Acked-by missing., aborting
>>
>> Thanks,
>>
>> Lizhi
>>
>> On 9/2/25 12:47, Lizhi Hou wrote:
>>> Reviewed-by: Lizhi Hou <lizhi.hou@amd.com>
>>>
>>> On 8/30/25 17:12, Min Ma wrote:
>>>> I recently left AMD and would like to continue participating in
>>>> the review and maintenance of the XDNA driver using my personal
>>>> email address.
>>>>
>>>> Signed-off-by: Min Ma <mamin506@gmail.com>
>>>> ---
>>>>   MAINTAINERS | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 10850512c118..6eefa494000c 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1231,7 +1231,7 @@ F:    drivers/spi/spi-amd.c
>>>>   F:    drivers/spi/spi-amd.h
>>>>     AMD XDNA DRIVER
>>>> -M:    Min Ma <min.ma@amd.com>
>>>> +M:    Min Ma <mamin506@gmail.com>
>>>>   M:    Lizhi Hou <lizhi.hou@amd.com>
>>>>   L:    dri-devel@lists.freedesktop.org
>>>>   S:    Supported

