Return-Path: <linux-kernel+bounces-883043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4DC2C623
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 15:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1F383B8422
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6A0E305E0D;
	Mon,  3 Nov 2025 14:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fS+8MxwM"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013048.outbound.protection.outlook.com [40.107.201.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 036F02FF64C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762179018; cv=fail; b=SYO+9aBE1+0LcNKgbbvGW/Bicsgn6xjGdf421DRpn7ky77TUrCp8wogV1jPxnqFkYZ/vO6mYnBcU6cXChjImvRYMlvMm9RLNqk9XwXNkKjhdos64XUCE5QgQSJ9dfF5RFWLbOkSqWceln6c5Qqdj/RJy/deYb2oY//bw8ntmmAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762179018; c=relaxed/simple;
	bh=MlOtPWMKLCiLGMEM+VE6mdax3s9MvXHt6b4x6Khb8Bc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MwsnMbRMi966eDfTSAoRb5bm2871PtS5Ow4IPYJmIbJ8Rw3fPngSRokKwEoIDsdnik7aeaTi/AUtYL1y+KbFWybJLiSdn0pq/YnsQk+6yDgun8YM+m8VrUzv2qRspCGsUO2RMWfy8HW7KZqyWZJAjZsiL0m7CXDEoasc6rwj72c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fS+8MxwM; arc=fail smtp.client-ip=40.107.201.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oWzy4hmv8XQYRVb8XuSgoT3JAY/gurK63i35g3/5+dvDBrB/tJmfeGD91kxv1AN1kPkHz178FFj2wHI4DxK8kqPxPP3KiezrfG9Ln4CswTD608A2YGRjsKxbOm51BZwnoAoI1ZWfNhQ5M9lDVJcdrSWIYiM+L921PYETHJ5ETINHeqSmo46LpDbdca8+auK4NGwh1UvJr5HMp37AZN/nrFIvZtNsjKj4EmqtbRbypjtWuNOl93wwTeer3YSF2NLjvcHabJIpsatF266y5erQyg3lkRSPaFT9LNOGMahFB/1biMnTaW6wC++/9HxuHm8msY2M/UFJ81LO6Amyp75n/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8XejGX2DvFhJVlNaU9NbLHVoo7S5o7fb5pnOv91MOE=;
 b=P6QBBGMZTAutIRSbs4GOfewHoZXNWU/wQw9Vqdg+yyxrt9oEU1NYFNuTDVelCu3hJ/jhNQauxUIXCDHRrLiIcRRGplRyKOyzFEXcjD/OJ3OOgSE+aLsTOVdjAs153r3vVipfIuRGDs5FzCxdtKeIGWaYjBVb+l0YJfbDDy88NIk9rGS5/li16KPxoYv8euZoSnlUhvorlU6y+h9i59U0J75Pfu42RiqXjYwgybYwHPKw6QWWn0tE89pa6Gw+LFtJ9CtVwQbwDCr6wNtdHAv4PfZJyHB/zJs9ZzTlzs+GgxqnJGzgvk+N1B2h6ryhkLpz6W73ATg5tHJARs7yuEwYSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8XejGX2DvFhJVlNaU9NbLHVoo7S5o7fb5pnOv91MOE=;
 b=fS+8MxwMn/FjCQYpZsg8m2NbSO+q6Z4O0tQLS2HOoDgRWP+HLj6s/Rz3+6wOJvcjNUUzBvlWq/V/A22MUNCWZP/wIr16Zg7a+tnLHwygfQGszV0KVJW2OAsu9FzOxM2qD5sXWt5UB2p9adY1iC0hYgGNnNCTPodP+qIwKpNf4BU=
Received: from MN2PR18CA0003.namprd18.prod.outlook.com (2603:10b6:208:23c::8)
 by SJ2PR10MB7598.namprd10.prod.outlook.com (2603:10b6:a03:540::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 14:10:09 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::7c) by MN2PR18CA0003.outlook.office365.com
 (2603:10b6:208:23c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 14:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 14:10:08 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:10:05 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 08:10:04 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 08:10:04 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A3EA46n298644;
	Mon, 3 Nov 2025 08:10:04 -0600
Message-ID: <58c2b614-1a56-413c-977d-42d6b8b8d2b5@ti.com>
Date: Mon, 3 Nov 2025 08:10:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/3] firmware: ti_sci: Partial-IO support
To: Markus Schneider-Pargmann <msp@baylibre.com>, Nishanth Menon <nm@ti.com>,
	Tero Kristo <kristo@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>
CC: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, "Kendall
 Willis" <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20251030-topic-am62-partialio-v6-12-b4-v9-0-074f55d9c16b@baylibre.com>
 <20251030-topic-am62-partialio-v6-12-b4-v9-3-074f55d9c16b@baylibre.com>
 <d3209c85-dc30-4f9a-8ea5-3c3e19330afd@ti.com>
 <DDYZOCXFX1J2.30UFCSI059R9V@baylibre.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <DDYZOCXFX1J2.30UFCSI059R9V@baylibre.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|SJ2PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 78816e40-4152-4d16-b878-08de1ae2b20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkdkYncrd0p4alF3S2J6cDFmV0VPcElPczZVeS9wNUphWlV4YWM5S3lZZWtB?=
 =?utf-8?B?V3JleHlWa3dFMHpvT3FZL0xZQzBGdGRsaGluckdaU3BFVFd2NDZNbEEzY1FI?=
 =?utf-8?B?NmRNakZScVdROVAyRlNjU0hwb283K1JrK0svQy9KTFY1NXMvelJCcHNDQWxY?=
 =?utf-8?B?M0p3TTIrWlkzQ3VObE9jNmN3YmloK2grWC9vZTFScUhZSEdIRmEwTjlMRThD?=
 =?utf-8?B?d0RlMXg4STRJRUFIVkcrZ09LeURpUzMrNGNYSnduWDdBS3M3Z1VIV3BETXFQ?=
 =?utf-8?B?Y1NzRjdkdWFmRTdwcVhqZElwTjFGWkxWVVdsSElBSWRBMU9rTXlpK01PRWw5?=
 =?utf-8?B?ZHVzZlZ5UTR5WSt1SkNYS1pINSt3Q3NZcm91Z0VJWEJhbXdyNkthalVMRitQ?=
 =?utf-8?B?OWlHSlZtdnNoRDhyMGZ3RGQwdDU1Sk9HMENqSEZLRGw0SE45ZHVhYUpxRmhX?=
 =?utf-8?B?V1NDOGZOTWdPTGkxTzkzRU85eE12UjRVeGJiL2s0bHovN0hoVmxXNnlUcFlm?=
 =?utf-8?B?UjRPd2xZNzlZY0M3dXBPK1BVV3dEeHFaYXJGOEN0d0hjWi9EZHRPL0RINnNM?=
 =?utf-8?B?VUMraFExRGR4cC82TDU4MndaTHJ4ejNPUTgwSndvaFpzcDZMUHZXTHNCVXJP?=
 =?utf-8?B?NWtWSElubkJHT0ZNVDlINThhanZPbDUwZGprVkp6ckNVYjFrRldXOW5Wdm9Y?=
 =?utf-8?B?Vlh0QzNsUm9Wbm1TREszQnd5QkFWUFZZV0I4YTB3amJhaStwdnQxT3Y3VW5R?=
 =?utf-8?B?aXhQMEYrY2oxQUV3am50bU5vUkk3WFJaUlZlVW82OUEyWk96bWd5WkdLOVJm?=
 =?utf-8?B?VXdVdFBTMmlMRlFaWm5TWGJRRmxsV21EOHhQUjBJSUx6NEp1SlhPSkRGcXBx?=
 =?utf-8?B?N3I2djNrako2RU81a2RxSm9YOXR6V2JwbzlNZTB4REpjWWFZUkVZWW5GQk92?=
 =?utf-8?B?UjFKV1V2ZzBjY1d6c01wbzRTbHdka3hBUk9LbWhxM0U1L0g2Vjc5c2NLVU56?=
 =?utf-8?B?TE5KNTliWC96TnY4S2FpM3ZxT3R6cFYzS3ZoVFdmVUpDTXFyTGdBOHo1VHV0?=
 =?utf-8?B?SVd4dmJRZXEzQWg2MDNBTWJBd0xua1J3RFU3US9CLzZLWEZGQUY2bGpXWkVl?=
 =?utf-8?B?Sy90MTVMakJTZkZ0R0pqenRxSHpBQnc0anVXVjNUQldPS1hWVGE2OW5ZNmxJ?=
 =?utf-8?B?dVdWcUhrSHE0elJaR2duWDA5NFpmTjlXZW9XUDZOZlcxY3dHQnhZRlJJL1Zv?=
 =?utf-8?B?VmcrQlliZzFVVnlnRTFsekU3RFQxMGZWTEh1TXJyd21yOWNsN3J4Y2FVbDY3?=
 =?utf-8?B?VElBWlVOVmVrQVlmdnBNVmhJVWZON0Q3RUh5QUdEWmdBaThtQ0J0UmNQbHov?=
 =?utf-8?B?V1M5M0kvdlF0dFczNmgvaVlhR0pCVnBESExVY3ByaWlIaUpWM1IwZmRQTnNV?=
 =?utf-8?B?Yi9renhwUXMrZ0dLbWpTVXpWamUwc2NuTHNqS0ZzY0RSam1HcU5kd1o3VlFp?=
 =?utf-8?B?VU45aVNoR1dwb2s0bkRFcTgyMHZkOHlFcVFEaktWelV2dVlzZmdSQXF5M1E5?=
 =?utf-8?B?ZmQ3YmRFdVVEdjlTR1hjSVdQTFQ0UVl6b0t1YUd5MVBGQ0NQdzFJZWJVM3U4?=
 =?utf-8?B?blRnU2I3VUJnaWxoL0ZmRmI0Zi8vS2Npb25WWkVoaUg2cFpodGRUVk0xeVAr?=
 =?utf-8?B?dU1DUWdYOFNPREIrTDl1UXZ4dTlEdnN2ZmZkMlVQejhzVWxwSEhaWWdnZFFu?=
 =?utf-8?B?STRjaDVxRGdGOG1iNVQrSWw1QkFsT2FWYVpseDVuZHNyeng5eWdDcUNrSVpS?=
 =?utf-8?B?SWx0YVQwTTg2cHYvZGhTaFpQRmgxYzFWSXpMYThyYlk3QW9KaWUwYzc3ay81?=
 =?utf-8?B?aG9qMkJ5Z3QzTXJJZVFmLzJ4WUZKZVhWeDk2VnJlUHNBZE1DeGpTUyswVGc3?=
 =?utf-8?B?OGNDcXJPelJ1ZzJ2ZXRHL3YxY1ZnRmZnRUNzWjdaZ1R2aHpCc2p5UFo2a1ZQ?=
 =?utf-8?B?OTduMUcyOXUrS0pIL2hVQ3RjM3VFdVF0c1ErN1dySG5PZ3RLTkxBYTRGd2kx?=
 =?utf-8?B?UFBRMGZWdFlPYUR0b3FvVytFcE1qYWFSR0JpeWVUb0tnZUx3WGRYSlV1WDFm?=
 =?utf-8?Q?FROs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 14:10:08.4299
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78816e40-4152-4d16-b878-08de1ae2b20f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7598

On 11/3/25 4:31 AM, Markus Schneider-Pargmann wrote:
> On Thu Oct 30, 2025 at 3:24 PM CET, Andrew Davis wrote:
>> On 10/30/25 4:26 AM, Markus Schneider-Pargmann (TI.com) wrote:
>>> Add support for Partial-IO poweroff. In Partial-IO pins of a few
>>> hardware units can generate system wakeups while DDR memory is not
>>> powered resulting in a fresh boot of the system. These hardware units in
>>> the SoC are always powered so that some logic can detect pin activity.
>>>
>>> If the system supports Partial-IO as described in the fw capabilities, a
>>> sys_off handler is added. This sys_off handler decides if the poweroff
>>> is executed by entering normal poweroff or Partial-IO instead. The
>>> decision is made by checking if wakeup is enabled on all devices that
>>> may wake up the SoC from Partial-IO.
>>>
>>> The possible wakeup devices are found by checking which devices
>>> reference a "Partial-IO" system state in the list of wakeup-source
>>> system states. Only devices that are actually enabled by the user will
>>> be considered as an active wakeup source. If none of the wakeup sources
>>> is enabled the system will do a normal poweroff. If at least one wakeup
>>> source is enabled it will instead send a TI_SCI_MSG_PREPARE_SLEEP
>>> message from the sys_off handler. Sending this message will result in an
>>> immediate shutdown of the system. No execution is expected after this
>>> point. The code will wait for 5s and do an emergency_restart afterwards
>>> if Partial-IO wasn't entered at that point.
>>>
>>> A short documentation about Partial-IO can be found in section 6.2.4.5
>>> of the TRM at
>>>     https://www.ti.com/lit/pdf/spruiv7
>>>
>>> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
>>> ---
>>>    drivers/firmware/ti_sci.c | 132 +++++++++++++++++++++++++++++++++++++++++++++-
>>>    drivers/firmware/ti_sci.h |   5 ++
>>>    2 files changed, 136 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
>>> index 4db84a92a517b0aa7bb8d47e809d9848a16e2cc4..f2922fccfbe748a436cb9aa0a8c8e5f48db02ef9 100644
>>> --- a/drivers/firmware/ti_sci.c
>>> +++ b/drivers/firmware/ti_sci.c
>>> @@ -6,6 +6,7 @@
>>>     *	Nishanth Menon
>>>     */
>>>    
>>> +#include "linux/dev_printk.h"
>>>    #define pr_fmt(fmt) "%s: " fmt, __func__
>>>    
>>>    #include <linux/bitmap.h>
>>> @@ -3663,6 +3664,116 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
>>>    }
>>>    EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
>>>    
>>> +/*
>>> + * Enter Partial-IO, which disables everything including DDR with only a small
>>> + * logic being active for wakeup.
>>> + */
>>> +static int ti_sci_enter_partial_io(struct ti_sci_info *info)
>>> +{
>>> +	struct ti_sci_msg_req_prepare_sleep *req;
>>> +	struct ti_sci_xfer *xfer;
>>> +	struct device *dev = info->dev;
>>> +	int ret = 0;
>>> +
>>> +	xfer = ti_sci_get_one_xfer(info, TI_SCI_MSG_PREPARE_SLEEP,
>>> +				   TI_SCI_FLAG_REQ_GENERIC_NORESPONSE,
>>> +				   sizeof(*req), sizeof(struct ti_sci_msg_hdr));
>>> +	if (IS_ERR(xfer)) {
>>> +		ret = PTR_ERR(xfer);
>>> +		dev_err(dev, "Message alloc failed(%d)\n", ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
>>> +	req->mode = TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO;
>>
>> This whole function is almost identical to ti_sci_cmd_prepare_sleep() other
>> than you use a different mode here, which this different mode can be passed
>> into ti_sci_cmd_prepare_sleep() just the same. Only other difference would
>> be the NORESPONSE flag which you could just check "mode" passed in and
>> use the right flag for the mode.
> 
> I thought this to be nicer as it avoided ifs, but as Kendall and you
> both requested this, I changed it for the next version.
> 
>>
>>> +	req->ctx_lo = 0;
>>> +	req->ctx_hi = 0;
>>> +	req->debug_flags = 0;
>>> +
>>> +	ret = ti_sci_do_xfer(info, xfer);
>>> +	if (ret) {
>>> +		dev_err(dev, "Mbox send fail %d\n", ret);
>>> +		goto fail;
>>> +	}
>>> +
>>> +fail:
>>> +	ti_sci_put_one_xfer(&info->minfo, xfer);
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +/*
>>> + * Iterate all device nodes that have a wakeup-source property and check if one
>>> + * of the possible phandles points to a Partial-IO system state. If it
>>> + * does resolve the device node to an actual device and check if wakeup is
>>> + * enabled.
>>> + */
>>> +static bool ti_sci_partial_io_wakeup_enabled(struct ti_sci_info *info)
>>> +{
>>> +	struct device_node *wakeup_node = NULL;
>>> +
>>> +	for_each_node_with_property(wakeup_node, "wakeup-source") {
>>> +		struct of_phandle_iterator it;
>>> +		int err;
>>> +
>>> +		of_for_each_phandle(&it, err, wakeup_node, "wakeup-source", NULL, 0) {
>>> +			struct platform_device *pdev;
>>> +			bool may_wakeup;
>>> +
>>> +			/*
>>> +			 * Continue if idle-state-name is not off-wake. Return
>>> +			 * value is the index of the string which should be 0 if
>>> +			 * off-wake is present.
>>> +			 */
>>> +			if (of_property_match_string(it.node, "idle-state-name", "off-wake"))
>>> +				continue;
>>> +
>>> +			pdev = of_find_device_by_node(wakeup_node);
>>> +			if (!pdev)
>>> +				continue;
>>> +
>>> +			may_wakeup = device_may_wakeup(&pdev->dev);
>>> +			put_device(&pdev->dev);
>>> +
>>> +			if (may_wakeup) {
>>> +				dev_dbg(info->dev, "%pOF identified as wakeup source for Partial-IO\n",
>>> +					wakeup_node);
>>> +				of_node_put(it.node);
>>> +				of_node_put(wakeup_node);
>>> +				return true;
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +static int ti_sci_sys_off_handler(struct sys_off_data *data)
>>> +{
>>> +	struct ti_sci_info *info = data->cb_data;
>>> +	bool enter_partial_io = ti_sci_partial_io_wakeup_enabled(info);
>>> +	int ret;
>>> +
>>> +	if (!enter_partial_io)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
>>> +
>>> +	ret = ti_sci_enter_partial_io(info);
>>> +
>>
>> No need for newline here.
>>
>>> +	if (ret) {
>>> +		dev_err(info->dev,
>>> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
>>> +			ERR_PTR(ret));
>>
>> Why cast this int to a pointer before printing it out?
> 
> I am casting this to an error pointer to get the resolution of the error
> value to a symbolic name with %pe. This will print 'EBUSY' etc.
> 

Ah I see, but why not use errname() directly? I see dev_err_probe() also goes though
a ERR_PTR() cast, so maybe there is some reason I'm not seeing, so I'm fine either way.

Thanks,
Andrew

> Thanks!
> 
> Best
> Markus


