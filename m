Return-Path: <linux-kernel+bounces-888252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B60C2C3A4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DE9F6350A21
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78092189;
	Thu,  6 Nov 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FUJQO/yz"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012050.outbound.protection.outlook.com [40.93.195.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D808F7D;
	Thu,  6 Nov 2025 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425352; cv=fail; b=Sm73liPe8mQGLjt1MkIMjE6LEYI4zHtcm/+IWgb9m0SO+IaY+9aKEI3pvQWXGD4zseADOEQEZccS/4qjYs+4K1ODqzzL07SK8XNpMx7L4bhXbVOZ6Ihw5a0nWfE+iVNZgbSYnNsDueOX/TO0Zsh91Es9syzguXhEqtESptsbg+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425352; c=relaxed/simple;
	bh=C6w2uVNKoMhBcfbcaG+JTKAyDmZYMY2WRKkPAxeGviw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Gab3QXEyfj9SB1axU9NWDRDz+S+OGascAghA+1TOe7vgLjgk4YdLe9jMxqrUVbtgnS+ceCD2VySINF7SYGbc8SEKlsVqloqpgk5Mo/CoNdNNYzIV5jMRPH4yEIxzZZaYWm0bIM5asDWJ8uVRvd5piYkx/s4CS5dmI+/s3nvriC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FUJQO/yz; arc=fail smtp.client-ip=40.93.195.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ABmkR+CuIsMCpS/cABXR6FkTK1TbIEY6AVwDMrd4s2NNWyQ6bn5PaTkGDOwqn+M9zxYUS6rQ9vXY7qm1wzqxY/IQ7TPZtI+OnXXrga0M4/1eB8SJEMQ8nyJhFQrnoSnZh3YepH0WiHjAJsMmlEBcXBlqINt7sppywAcmzt2pfuMuznoslXDnVzkaRRttCluT5eATxoQH04M8HPkGBz4VgTr0ii/DWtoNYxvb7+Qi32uuF2zGhI1ejXby2LerQGU3KCYifAlzwmsNNBkEfZnxeiquRzO2DtS4dh3KVXcv01LFWfVt53OAwNR5aNQJtjEkDXA4BrPu1IAA7K0qObdi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGFs8yGBVBjW92RHWvPmrHH+dblgfGXIfHN1uCEw1uI=;
 b=IJ8lF/WZScUgfbL6AaCsMKqaXxvp1QNWPR7JH21kNZIYiVDmytD3sW+oCNpZo7y1ZlTPmRyGUZQSjCkOSb3lDsX9X6tLtEvC+VBUtkLSZaLdMmBXIUkkFNHiW7yMQBCYtAfZ/XdxlGREA24cUuHJIbXg1+ESFIt4hEC2S6Ox4KP71NtCnOBaztZwmQBbDVhpPap6XS0nbDUQNzhrSIJeVUOxrM2EgvDWjdEEde3a55VvcizwWlPryffQys1dXVT7VBhJ4JVfZK7EBLkwid6yj8bd8ITrWBplMiX6bqMjHxn/jtCNTKK0gh/y+KzG/MkD26i2qKka7TJL9OniYkuoyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGFs8yGBVBjW92RHWvPmrHH+dblgfGXIfHN1uCEw1uI=;
 b=FUJQO/yzvKPg7pySkuKBFkoG9BYRJn3wgQHGHTfVRHEMp67xJx01JBaVnkdW2NQOpGivG/0wRciNCRGhhVbXdGtD/UhtuyXi6ZChLEc6aYUAwXTI7vGJxef2Rbj/OCx1yuZwJn4BgFpzuAXveDOlWppjAztEw4Hp1Y9Ciy3dT9g=
Received: from CY5PR22CA0061.namprd22.prod.outlook.com (2603:10b6:930:80::6)
 by IA1PR10MB6050.namprd10.prod.outlook.com (2603:10b6:208:38a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 10:35:45 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:930:80:cafe::c) by CY5PR22CA0061.outlook.office365.com
 (2603:10b6:930:80::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.12 via Frontend Transport; Thu,
 6 Nov 2025 10:35:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 10:35:43 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 04:35:42 -0600
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 04:35:41 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 04:35:41 -0600
Received: from [172.24.233.149] (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A6AZZis1077580;
	Thu, 6 Nov 2025 04:35:36 -0600
Message-ID: <e50ba842-95c0-4ca2-b830-0938ca0c5696@ti.com>
Date: Thu, 6 Nov 2025 16:05:35 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/16] media: ti: j721e-csi2rx: add support for
 processing virtual channels
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, <jai.luthra@linux.dev>,
	<laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>
CC: <y-abhilashchandra@ti.com>, <devarsht@ti.com>, <s-jain1@ti.com>,
	<vigneshr@ti.com>, <mchehab@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <p.zabel@pengutronix.de>, <conor+dt@kernel.org>,
	<sakari.ailus@linux.intel.com>, <hverkuil-cisco@xs4all.nl>,
	<jai.luthra@ideasonboard.com>, <changhuang.liang@starfivetech.com>,
	<jack.zhu@starfivetech.com>, <sjoerd@collabora.com>,
	<hverkuil+cisco@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20250911102832.1583440-1-r-donadkar@ti.com>
 <20250911102832.1583440-10-r-donadkar@ti.com>
 <fa27ae08-4568-4b0c-b8bb-a4b31746e27f@ideasonboard.com>
Content-Language: en-US
From: Rishikesh Donadkar <r-donadkar@ti.com>
In-Reply-To: <fa27ae08-4568-4b0c-b8bb-a4b31746e27f@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|IA1PR10MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f9f6d12-df8b-444b-19fb-08de1d203d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|34020700016|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eE9Ub25CT2ZwQm8zTUwzZ2lkcXZCajl4NXBOS0c5OFpFKzcvQ3FSUVZybGNx?=
 =?utf-8?B?SHpObnZyVGVQRFA3TC9KTEpoc2JhRUVDKzlDaGE0ckZBOStRSmtFZFZuQ0Vl?=
 =?utf-8?B?dVdJbDlXR1ExbXRZWDk3WDgxclE5MmF3UVZPOE41U3VGU3E4WU9xalFkNXZ1?=
 =?utf-8?B?QTdnSC9xbnRNckxORzdISEVqcThKREhhVlByVHpzWUx1WHBTMng4U3FKY1RS?=
 =?utf-8?B?TytnOEZTSUQ2aTR6b3Q1SGdRVTBTcVNybEorcFNNallxWnFkSll3Uk9QRVVM?=
 =?utf-8?B?NXBRY1dhNjhlZXBxL3RWOVlScEx3VmJLUzVUYWZWT2ljSGdrQ1ZVMVZkUG5D?=
 =?utf-8?B?ZituMUtmRDgrbml5ZlVUNW9xTHkwQ09TRDNHNmc0cGR1bGlQOEZnVnFPZ0pr?=
 =?utf-8?B?M0h0L25GQkYraFpsUFgrWHZvRWpvMHpkYUYxb3ZDcFBaMXlWaEpEUmtiZGVF?=
 =?utf-8?B?SFd2Z04ra0dqOStMZFJ3TUkwZitmbFozRzRmcTZrWEF1WFBTZFVEWGpqbXh4?=
 =?utf-8?B?TUhzbTFEZXV3M2s4LzF5b1pDSVFHc3p2L3pad3RROUpRdDVNMDVUUW83VUpw?=
 =?utf-8?B?R2YrOUd3OG1NMWxoQnlWcm4xQUxGV0szc2huTWp5dEF2OFI3d09kejl6cDU4?=
 =?utf-8?B?aGNVY1RmTFU2VnJZWlMrMGw2SFIyb01oVDVlZlpOalJKbUxPQWd0RjFiUWlp?=
 =?utf-8?B?ejlMOHFxcldnTzNjbHdYZ3lZakljaXBPNVFyTHZXNXRHR2JZWDh6dXhiSkhY?=
 =?utf-8?B?K08wSG41aEg4eVVraDdMeDBmQm9kUDdQTzdIaG9oc01PSTBQS3M5OTh5WUZi?=
 =?utf-8?B?YkE0RnZCZ3I4U3dOa0l2MFFUaVIzRjhvOEQvbGlJM3d2OXNCVWdrbzUrYk0y?=
 =?utf-8?B?b1VHbkJpM0FBUWxoc0RjV0wyVVNDeUFRbnpBR3hIelZ4dWtVdVZZV0VBWXQx?=
 =?utf-8?B?alllQWhNdVdNbXRVaHBHZ0VFZE1qYXVHRmNNRXRQZTljNEJobGpjRm1YSVVB?=
 =?utf-8?B?UW1CSDNyeVM5QlJuQmw2M3E3WEdJRXVaWkZOSzBtQ3IvTWFvaTVTMUNnRktU?=
 =?utf-8?B?Qk1UK1RKWXo5QjRpeGJpcXRXdlZFdWhkMGxMTXFmcWFjQVI2eS91eWNPbWdq?=
 =?utf-8?B?amVZSVhPZ0NLVkNER3VFeGJ4TGxPaVBab3czUmYvaEdXVkFsYXRMOFJoQkgr?=
 =?utf-8?B?ZUlTMGl5bXBpZHE3RmllQmV1RVVRRzIvd0ZSVVM3ZU9QNzhQdTNUbmZZMFBr?=
 =?utf-8?B?eVo5OWpnQzAwMlRoUkw5M25BMVhWL0NUMUx6dlMwL2V6T2F0a0lJZnIxdWp2?=
 =?utf-8?B?TUYxV09nWktWbE1ZZUJuQUNNQ25RMk51OG5qYVFUKzdTSVcrU3I1L2s2bUtM?=
 =?utf-8?B?MTlpVGRyVTNZUEZ0MkN1UlRrKzViN3BiR3JSYUROaXFudWFrU1Z3MEFZK2Vk?=
 =?utf-8?B?UnlJZHRtMGtnN1hwaTNkanNNaVlIdDdlbWo2Q2w1ajQvY2JORjQwbXMwa3R6?=
 =?utf-8?B?RGRycWNDQ0MybDhRQ1JEdi9XNEVtVTUvL2hiRTZiTllOa2NlZERMNkV3eE1T?=
 =?utf-8?B?Y2FVT3dvb0V2T2VWcWxwdFZuYzFqWXNNdSsreEpjUEpmbzVqL213WFdGdE5p?=
 =?utf-8?B?ZFhhNndYZVZDRGVnbUhiWTRFODR3WCtYck1MN1dpRWxoTHBnbE55QXIvaDJ1?=
 =?utf-8?B?WEVmOTlhMFBVdFE3MytXSm5nVGxTUmtqUVZOUHpUNGg2UjhVU1pOZW1sT05h?=
 =?utf-8?B?VVBxTTJ6VkxRS0hIOUYrd0QzczZnTlBRZzc5d3czVEwyU2s5eHdoVVdIcC9D?=
 =?utf-8?B?bW5rT0Z6ZDlUcm45OTdleGlEWHZ6bHA3WkFIL2hpbjlwNE1JR1IwTlZPKzh6?=
 =?utf-8?B?YlRnMW5MMGNRbi93RWNOenJBWGxoS3NWZkxoRStaL0RjazdpTGhBODVJMVkx?=
 =?utf-8?B?dTZ2d3hZZU4wQjNCYmQrUXhEVXlYa0RZbTZzakNkaW1GbGJwZUI0ZnZCUHNr?=
 =?utf-8?B?LytiMGJQbmVsODFpaHYybU5FQVB2dFZwbUVCazRsWG5wdVF1UzV2SzhPWnBt?=
 =?utf-8?B?QU1CN1Zkb3F4THUyMmJpcm9sQXo3RzZVYVJROGN0dnF2b1EzaFo2cHJVUUFF?=
 =?utf-8?Q?xrq4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(34020700016)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 10:35:43.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f9f6d12-df8b-444b-19fb-08de1d203d41
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6050


On 22/09/25 19:00, Tomi Valkeinen wrote:
> Hi,


Hi Tomi,

Thank you for the review.

>
> On 11/09/2025 13:28, Rishikesh Donadkar wrote:
>> From: Jai Luthra <j-luthra@ti.com>
>>
>> Use get_frame_desc() to get the frame desc from the connected source,
>> and use the provided virtual channel instead of hardcoded one.
>>
>> get_frame_desc() returns the same information when called on each stream
>> start, so instead get the VCs for all the routed stream at first
>> stream start and cache this information in the driver.
>>
>> get_frame_desc() works per stream, but as we don't support multiple
>> streams yet, we will just always use stream 0. If the source doesn't
>> support get_frame_desc(), fall back to the previous method of always
>> capturing virtual channel 0.
>>
>> Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
>> ---
>>   .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 107 ++++++++++++++++++
>>   1 file changed, 107 insertions(+)
>>
>> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> index f3443c3ab01a..903722b5aea7 100644
>> --- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> @@ -32,6 +32,7 @@
>>   #define SHIM_DMACNTX_YUV422		GENMASK(27, 26)
>>   #define SHIM_DMACNTX_DUAL_PCK_CFG	BIT(24)
>>   #define SHIM_DMACNTX_SIZE		GENMASK(21, 20)
>> +#define SHIM_DMACNTX_VC			GENMASK(9, 6)
>>   #define SHIM_DMACNTX_FMT		GENMASK(5, 0)
>>   #define SHIM_DMACNTX_YUV422_MODE_11	3
>>   #define SHIM_DMACNTX_SIZE_8		0
>> @@ -103,6 +104,7 @@ struct ti_csi2rx_dev;
>>   
>>   struct ti_csi2rx_ctx {
>>   	struct ti_csi2rx_dev		*csi;
>> +	struct v4l2_subdev_route	*route;
>>   	struct video_device		vdev;
>>   	struct vb2_queue		vidq;
>>   	struct mutex			mutex; /* To serialize ioctls. */
>> @@ -111,6 +113,8 @@ struct ti_csi2rx_ctx {
>>   	struct media_pad		pad;
>>   	u32				sequence;
>>   	u32				idx;
>> +	u32				vc;
>> +	u32				stream;
>>   };
>>   
>>   struct ti_csi2rx_dev {
>> @@ -134,6 +138,7 @@ struct ti_csi2rx_dev {
>>   		dma_addr_t		paddr;
>>   		size_t			len;
>>   	} drain;
>> +	bool				vc_cached;
>>   };
>>   
>>   static inline struct ti_csi2rx_dev *to_csi2rx_dev(struct v4l2_subdev *sd)
>> @@ -610,6 +615,7 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
>>   	}
>>   
>>   	reg |= FIELD_PREP(SHIM_DMACNTX_SIZE, fmt->size);
>> +	reg |= FIELD_PREP(SHIM_DMACNTX_VC, ctx->vc);
>>   
>>   	writel(reg, csi->shim + SHIM_DMACNTX(ctx->idx));
>>   
>> @@ -884,6 +890,82 @@ static void ti_csi2rx_buffer_queue(struct vb2_buffer *vb)
>>   	}
>>   }
>>   
>> +static int ti_csi2rx_get_route(struct ti_csi2rx_ctx *ctx)
>> +{
>> +	struct ti_csi2rx_dev *csi = ctx->csi;
>> +	struct media_pad *pad;
>> +	struct v4l2_subdev_state *state;
>> +	struct v4l2_subdev_route *r;
>> +
>> +	/* Get the source pad connected to this ctx */
>> +	pad = media_entity_remote_source_pad_unique(ctx->pad.entity);
>> +	if (!pad) {
>> +		dev_err(csi->dev, "No pad connected to ctx %d\n", ctx->idx);
>> +		return -ENODEV;
>> +	}
>> +
>> +	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
>> +
>> +	for_each_active_route(&state->routing, r) {
>> +		if (!(r->flags & V4L2_SUBDEV_ROUTE_FL_ACTIVE))
>> +			continue;
>> +		if (r->source_pad != pad->index)
>> +			continue;
>> +
>> +		ctx->route = r;
>> +	}
>> +
>> +	v4l2_subdev_unlock_state(state);
> I'm still learning the structure for this driver, but the pattern here
> does not look right. If you unlock the state, the state can change. You
> can't store the route and expect it to stay the same after unlock.
> Here you are even storing a pointer to the state, which can be dangerous.


In the driver we don't allow anyone to update the routes when we are 
streaming (i.e. if csi->enable_count > 0, return -EBUSY). So, it is 
unlikely that the route may change here.

Also, looking at it more I realized that this changes should not be done 
in this patch as routing support is added later in this series([PATCH v7 
11/16] media: ti: j721e-csi2rx: add multistream support).


I will shift these changes to the above patch in the next revision.

Rishikesh


>
> Our current v4l2 state locking is not perfect and we need to do some
> manual locking/unlocking in the drivers for now, and, indeed, we just
> have to expect that it doesn't change. But that has to happen inside the
> enable/disable path, with such locking that it's "as safe as possible",
> which means locking early, as much as possible and keeping the lock
> during the processing. In many cases the framework deals with that (and
> that's our future target generally).
>
> In the subdev enable path, .enable_streams already has the state locked
> and the driver doesn't have to deal with it. If using s_stream (but why
> would you?) you need to lock it yourself, and it usually makes sense to
> lock almost as the first thing, and pass the state forward (or use
> v4l2_subdev_get_locked_active_state()).
>
> Here all this processing is happening from ti_csi2rx_start_streaming(),
> so not even from the subdev's ops. So I'm not sure yet how to clean this
> up, but, as I said, it just doesn't look right.
>
>   Tomi
>
>> +
>> +	if (!ctx->route)
>> +		return -ENODEV;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_get_vc(struct ti_csi2rx_ctx *ctx)
>> +{
>> +	struct ti_csi2rx_dev *csi = ctx->csi;
>> +	struct ti_csi2rx_ctx *curr_ctx;
>> +	struct v4l2_mbus_frame_desc fd;
>> +	struct media_pad *source_pad;
>> +	struct v4l2_subdev_route *curr_route;
>> +	int ret;
>> +	unsigned int i, j;
>> +
>> +	/* Get the frame desc form source */
>> +	source_pad = media_entity_remote_pad_unique(&csi->subdev.entity, MEDIA_PAD_FL_SOURCE);
>> +	if (!source_pad)
>> +		return -ENODEV;
>> +
>> +	ret = v4l2_subdev_call(csi->source, pad, get_frame_desc, source_pad->index, &fd);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (fd.type != V4L2_MBUS_FRAME_DESC_TYPE_CSI2)
>> +		return -EINVAL;
>> +
>> +	for (i = 0; i < csi->num_ctx; i++) {
>> +		curr_ctx = &csi->ctx[i];
>> +
>> +		/* Capture VC 0 by default */
>> +		curr_ctx->vc = 0;
>> +
>> +		ret = ti_csi2rx_get_route(curr_ctx);
>> +		if (ret)
>> +			continue;
>> +
>> +		curr_route = curr_ctx->route;
>> +		curr_ctx->stream = curr_route->sink_stream;
>> +
>> +		for (j = 0; j < fd.num_entries; j++)
>> +			if (curr_ctx->stream == fd.entry[j].stream)
>> +				curr_ctx->vc = fd.entry[j].bus.csi2.vc;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
>>   {
>>   	struct ti_csi2rx_ctx *ctx = vb2_get_drv_priv(vq);
>> @@ -904,6 +986,25 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
>>   	if (ret)
>>   		goto err;
>>   
>> +	/* If no stream is routed to this ctx, exit early */
>> +	ret = ti_csi2rx_get_route(ctx);
>> +	if (ret)
>> +		goto err;
>> +
>> +	/* Get the VC for all enabled ctx on first stream start */
>> +	mutex_lock(&csi->mutex);
>> +	if (!csi->vc_cached) {
>> +		ret = ti_csi2rx_get_vc(ctx);
>> +		if (ret == -ENOIOCTLCMD) {
>> +			ctx->vc = 0;
>> +		} else if (ret < 0) {
>> +			mutex_unlock(&csi->mutex);
>> +			goto err;
>> +		}
>> +		csi->vc_cached = true;
>> +	}
>> +	mutex_unlock(&csi->mutex);
>> +
>>   	ti_csi2rx_setup_shim(ctx);
>>   
>>   	ctx->sequence = 0;
>> @@ -950,6 +1051,10 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
>>   	writel(0, csi->shim + SHIM_CNTL);
>>   	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
>>   
>> +	mutex_lock(&csi->mutex);
>> +	csi->vc_cached = false;
>> +	mutex_unlock(&csi->mutex);
>> +
>>   	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 0);
>>   	if (ret)
>>   		dev_err(csi->dev, "Failed to stop subdev stream\n");
>> @@ -1303,6 +1408,8 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
>>   
>>   	ti_csi2rx_fill_fmt(fmt, &ctx->v_fmt);
>>   
>> +	ctx->route = NULL;
>> +
>>   	ctx->pad.flags = MEDIA_PAD_FL_SINK;
>>   	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
>>   	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &ctx->pad);

