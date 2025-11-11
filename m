Return-Path: <linux-kernel+bounces-895389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB79C4DA25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C76A1898249
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7D33587D8;
	Tue, 11 Nov 2025 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z47pVn3U"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937B239E70;
	Tue, 11 Nov 2025 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863617; cv=fail; b=lajEtabknyviOXabSuznO6SS/krtZ7nOLu6R2LfGYQshcRdRUAw8hVG+JFib+G3Y1VZ+xq8FidpRRPlmuh7ABNyq6/ltwf6vUeveHNMbsKOtrSJ8EACeFwxzmCEZGbHI4qxzrWq7TGCZDL5AlwEnS8EwZKbWz/ptATcCzCuCtRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863617; c=relaxed/simple;
	bh=vqFy24DGHh76az2g0OA4GM23HfmPyssy/vUL4FdZTx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=badBT9ZwQzFRaUnGrZjC8GPFpsfQeRKmUjJR/WpGR08EiMPxfwRNc7JKuR4oK/VawJ90Wo/GIuDfpx2LDEOSK944jxa7KZd5xYdI5XQtbwyioTjvmU5yhF7Kl05PVcgNK+Xk+kHaOcTbtY/tPLnclkPjvBvT7JvOdlSJLlhgYb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z47pVn3U; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hZVQFJnzP1l729wAOzshU7zpCjtZJGZkhkq+KnnZfb4/4EW2VjPWxDfTtLBzg0h6INrvqFNI8DZkxPP6fsbNzJB3SlzbwCXUnhzBYCXkMqWXhVwvcFoE1wCowJuHMLs46yIaFn91qs2mWgqHVOtN6tVGBJIEMygPbN/zUt3kJKnBA4Vnd7QhqmtzmbjWruCHDIay/JRwVaYoycDMdOQ+aCOIqiSHaBD5/401X7PWm2zxzSs9HfyDMTe+4+lUiPl9MPLJIibqojx26JG7Nae2U7E9o7hY4tBUtl/WaZlWuDf88bMzluyKyBWiG320D4qzd4Cgmb+IQJjyIV14lKvj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBQJ+FbK73gZ0zl/76iBqW0ZuRV7szRXoDY3HvMoV7k=;
 b=oS4U7j4ZCvnRhuYe/go9mewjJ0dkWgGP70pCq+UB+OYt3ixMI41DdZmOSEfkI6N3f1L3+GNg6aCmQOK0jM4GR0wumEW6smpaLjCtMsccj9eeEqt9KTLayT27zxtWkipBVRIQZkTK5FHV36zaXLuX+0fTmPY1FfkrBiOlCmWhhM9jq0gP0c+LL15PudJ7kO7E9pt+pzqbkRw6LahxEDI7I3Kat10lG9AA0zY4SB123WCU0YnAbCsHArIzzRxGHfrkPu2x4M8+z1LF1/upe32GRi1vbLmfdHA9tRZUkgJrcIGtrNZcQTZdc/fg92RtPeuuFrD8bVltEOkr6b15d/jg0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBQJ+FbK73gZ0zl/76iBqW0ZuRV7szRXoDY3HvMoV7k=;
 b=Z47pVn3UIAZZAP2Diz1tw8HTsMQ7j64LOgE5jEMM2mGS3u/6Klt74636PGF6J7umoyk49ungbPKPPbJzw7h/EZoc3dNyY0dQCv8zkAEz4nMT9+FEE8w92GEeGQrO9fbHl8JvXNzk75CWd0bOLbw8p8S+WhFLgs48VDj2kh+7svQ=
Received: from BN0PR04CA0177.namprd04.prod.outlook.com (2603:10b6:408:eb::32)
 by MN0PR10MB5981.namprd10.prod.outlook.com (2603:10b6:208:3cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:20:12 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::e) by BN0PR04CA0177.outlook.office365.com
 (2603:10b6:408:eb::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 12:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 12:20:11 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 06:20:06 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 06:20:06 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 06:20:06 -0600
Received: from [172.24.233.149] (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABCJxEh924501;
	Tue, 11 Nov 2025 06:20:00 -0600
Message-ID: <3a297a74-768a-46c6-b204-e390a8fb09d1@ti.com>
Date: Tue, 11 Nov 2025 17:49:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/16] media: ti: j721e-csi2rx: add multistream support
To: Jai Luthra <jai.luthra@ideasonboard.com>, Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>, <jai.luthra@linux.dev>,
	<laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>
CC: <y-abhilashchandra@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
	<vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<changhuang.liang@starfivetech.com>, <jack.zhu@starfivetech.com>,
	<sjoerd@collabora.com>, <hverkuil+cisco@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<devicetree@vger.kernel.org>
References: <20250911102832.1583440-1-r-donadkar@ti.com>
 <20250911102832.1583440-12-r-donadkar@ti.com>
 <4534a09b-7eef-4e61-835a-c70d07df3416@ideasonboard.com>
 <175983794202.36451.17500767517117494893@freya>
Content-Language: en-US
From: Rishikesh Donadkar <r-donadkar@ti.com>
In-Reply-To: <175983794202.36451.17500767517117494893@freya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|MN0PR10MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: c7f4830f-78f9-41fe-f6a4-08de211ca955
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFRpTzU5cUtnWVFOaVgwcFBoaWs5ZzRIa2E5TzVROUtXT0JQeEFIU0wwM2gr?=
 =?utf-8?B?TGJxUWU1ckJHYUg1YnpXR1BSeFA3MWVTRzRhaURaM1YyYWFXbWVHckptWUFC?=
 =?utf-8?B?WHBvNDVmMzNDYUltdTBzNmtSZFFQMU5xaTdOZkp3bWxmZ2wvM1ZJNUkxby9z?=
 =?utf-8?B?Um5rclgzbDZJZDBFdTlmdmdjVzZGSEVlck5lanY3UFV0SDJzNXllMUE1MjR3?=
 =?utf-8?B?UmE3SFNtd0o3d1pSNFpwTFE3eE5zWDMxMUJFVXQyU1ZUZXFNcjMzOU5aUllX?=
 =?utf-8?B?Y1p1S01ENzZmNGdTM3RKMGFlcGRRbUtHdHYyZlVxMXBnby9NS0txYm5ORnNa?=
 =?utf-8?B?MVE4eTd6VVF1M1F2aEprZSs4WEVxRmVUNTVpYW1NL1BRT09zZTQ3N1M5anRP?=
 =?utf-8?B?STFWK1BHL1RUSVAxSGhpclNCTWswMlNvZHlEQ1l2V1dhV2dmYkpjeGduMDVW?=
 =?utf-8?B?WldadnQyRGxFN3pyTW9aSEFVRXM0dEhmbHhGVXk4SlAvQzQvME52MDhXQkEy?=
 =?utf-8?B?R20zWjh3T1hkYjh3UVpwb3dWSis2YksyZkdTb3I0NngrcXB1aUR4eEQyaXF4?=
 =?utf-8?B?djhiSnQvSTZJV3p4U0RtRi8vRllBNXNZRis4QUhxL2c4bnhicU5ZVmx2MDhr?=
 =?utf-8?B?T1AvQXlMd3RSSldQUTM5amVnYWlncTdvZ3JPQ2ZlM001aDRnN1FQUzJiczdG?=
 =?utf-8?B?THJuR3ZUVUVkNjVxcXNEbHh6UlFucHFXSjA5MEFQWlVDSXgwMnE4V0ZIUnJv?=
 =?utf-8?B?NEh6YmYvdE5Td2tSaVpJVXhpd1preGRvU1ZRMHJxVERwUjBtVGxmS1ZmMFg0?=
 =?utf-8?B?VlJtUmFlOVJMS1RjTHoyOGZack9rT1M2TWJ0L1BsQy9vbGZjMU93MUhVbWRr?=
 =?utf-8?B?eUFMdXJUWDVrMW9WRkNhd3kycXZ6UUFKVzZWUDgyQ0F4aGtXTjFBZm5oUDFr?=
 =?utf-8?B?ZjRGRk9teHRBVFNKSG5TK25ad0hjTVFraUcyZ1RGeWJvK0xlVUNFUTh5NU9p?=
 =?utf-8?B?Z25CZFQxSlFhM3FucFIybjBVVU9EajJkVm5OVnhtcWcwcTJsa0Q1S242ZXB1?=
 =?utf-8?B?Vk1Gb283RkRvcDNkaFk0YjF0UnJsaTJvTG92VnVFaGFDWTRnV3E2K2xqbnZG?=
 =?utf-8?B?ZDhQTGtna2JUMFc3Y2hONmcxNnAxOVl3MTBpZGY4YVBLR1FmREZtVVpZYWZ6?=
 =?utf-8?B?amJmTnE2M0hwejhmSC9ydk9GQ0k3MEZnODZpT1krYVBncHptMDM3KzZnUC9q?=
 =?utf-8?B?YVJkRHVKVHRyMHIyRVMxR2RsNnN2b1VUSitVdU8wQ1U1MnRnekhRRXhtVzJ5?=
 =?utf-8?B?NktRejJoSXhkNDhXTVVWMVl6eUtLVU1ZY3Voa2xuV01vckNEZlFmeGdRV3Bz?=
 =?utf-8?B?RW1XMEEwY0FrTUNaanpvaUlOeE4rYXJla21RSG9LN21NSFRNdS9IbHFqUUVM?=
 =?utf-8?B?dGZzbUYyRXVTem1YaTl0NDYzL3ZJWEpsbkFEK0xSTnB4M1V5YndZVjhZM2M3?=
 =?utf-8?B?amI0cm1MaVA3MXJLV3hnOVZQSmNXY1lrUkp5MXpNL1Y4NEZxWWpCaVBmRGh6?=
 =?utf-8?B?aEFJT0FxM1VyS3BVNXN3dEZvaXJ2NTRwQk9HYTZjYkVySHNEclM1QlBjYlBB?=
 =?utf-8?B?UDBvUlFqQm5pZC83enBWOHhQeFFxdnVjSTJ5eFZPOHB2aCsxcDN1L0hIR3dR?=
 =?utf-8?B?ZWpFMXFzK1JPeFVJTTUxdEQvM0l5NXpJdllIclFMbWlkZlZXSGU1eDJMSG83?=
 =?utf-8?B?K0RiM1QraXpNaDJoWVU4bnJGWnY4NDRQNjhCbWZ5TW9BOG1RMDUzVVFyKzBQ?=
 =?utf-8?B?VWdxak40RDBielh6TDBnYS8yOEIvcW5tVHUrTkZrWGNhbmt0UENOdk9yM3Uv?=
 =?utf-8?B?U285WmlkbU0vOEtnNXExL3dLV1dSY3FrbDFZays4NCt1OGpxbFJWbUpadTBQ?=
 =?utf-8?B?Z3Y5UmNPSklKeTZJSDF3MFhwZ2dhT2V6ZXFBVFNvL0ttdW8vSjFiaHI0SEZn?=
 =?utf-8?B?V2tjTXd4MWU3ak1pcVE1UjZxTjVIYUQzMU9CWGZCa256NGZoRG9oRmt1WGVJ?=
 =?utf-8?Q?FOTGZG?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:20:11.6195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7f4830f-78f9-41fe-f6a4-08de211ca955
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5981


On 07/10/25 17:22, Jai Luthra wrote:
> Hi Tomi,
>
> Quoting Tomi Valkeinen (2025-09-25 17:47:38)
>> Hi,
>>
>> On 11/09/2025 13:28, Rishikesh Donadkar wrote:
>>> From: Jai Luthra <j-luthra@ti.com>
>>>
>>> Each CSI2 stream can be multiplexed into 4 independent streams, each
>>> identified by its virtual channel number. To capture this multiplexed
>> The split can also be done with the datatype. I don't see it supported
>> in the driver, but afaics the HW supports it. Was there a reason not to
>> support DT filtering? I would think it would be very simple addition.
>>
> I believe DT filtering should work as-is with the current driver, given we
> program the SHIM DMACNTX register with the correct datatype depending upon
> the v4l2 format of the video node.
>
> So if there is multi-stream source with two different datatypes, it should
> be possible to route it to different video devices and it "just" works. But
> I agree that it would be good if it can be tested once, and this commit
> message can mention that both VC and DT based filtering is supported.
>
> Rishikesh, would you be able to use an IMX219 to test capturing embedded
> data and frame data?


Yes, DT filtering works. I tried hard coding 0x12 (CSI DT for embedded 
data) in the DATTYP_CFG field of the DMACNTX_J register and captured 
frames from IMX219 using yavta and viewed that using xxd. I can see 
first few lines are that of embedded data, I can see the tags as 
mentioned in the 'CSI-2 Embedded Data Line' section of the IMX219 
datasheet[1]. I will mention this in the commit message as well.


[1] : https://www.opensourceinstruments.com/Electronics/Data/IMX219PQ.pdf


Thanks,

Rishikesh

>
>>   Tomi
>>
> Thanks,
>      Jai
>
>>> stream, the application needs to tell the driver how it wants to route
>>> the data. It needs to specify which context should process which stream.
>>> This is done via the new routing APIs.
>>>
>>> Add ioctls to accept routing information from the application and save
>>> that in the driver. This can be used when starting streaming on a
>>> context to determine which route and consequently which virtual channel
>>> it should process.
>>>
>>> Support the new enable_stream()/disable_stream() APIs in the subdev
>>> instead of s_stream() hook.
>>>
>>> De-assert the pixel interface reset on first start_streaming() and assert
>>> it on the last stop_streaming().
>>>
>>> Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>>> Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
>>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>>> Co-developed-by: Rishikesh Donadkar <r-donadkar@ti.com>
>>> Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
> [snip]

