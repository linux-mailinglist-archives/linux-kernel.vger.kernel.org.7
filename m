Return-Path: <linux-kernel+bounces-888150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513C2C3A01D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B30425FE5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873AA2DC784;
	Thu,  6 Nov 2025 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k/sMGRIJ"
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD2830F7EE;
	Thu,  6 Nov 2025 09:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422800; cv=fail; b=EppWv+8GZtKy+DVDRo9ieznwegqQTicbAs0G8nSJoIKaQqEvEdIWOfRMwKX+ay2qSMVjOqJNjUfA93kNUDuLvRBeZLV8d+gTNA1R7O+IFDJgmr3ZZQ6/u0SQNHs1ynVO+QvyKmigqoeIepfF5wrbfGkTK2Yu4SkH8RD1d6NLAyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422800; c=relaxed/simple;
	bh=9HE5gHZuz4ucrTmenaYUEd4ViTYuQ07+Q0Qv7gSwF84=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q2vW0IN44/PfYbtGPefLDmyIRFxs9pfukBAdawbmv2suZS1tgV6g4dsmEbSsnonnqRDulFMnnA7yn+hMm0fDltS53i/7wCYD/6KUegHJXkA5uS7Cc6jiBlxJ+Zf4ELyPRr1p26kScvNm9aN+kaIz2J3RCscn7c+T3H4fhzmt838=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k/sMGRIJ; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6bfeXjbnTc/Ht56hjJ5rAxGzcoHiOBLois4Y9HoTo4cEFBDXAojqMWIqSqaq/nbmcIstMoAS9F+6Un1JCF7pIYVbt7NrB/+BdqNxFPlVwT6XiwYYUHir60Bct8h9NsiqfiiyyvruEGOLlZGDvCcpzdkfQqIVT8EWt/2J5pGfbNYgl039zcI4KntN4iZQ1FApY1EQkfmYi2Cj4O+CAsRHCEvLqMJSrTqf6W0m+e/Y+56rlrWJw9mgyDTUzgb9rpJ+VLOq/k75ctj9rJ+ER9os5L40IK1+AbtPiRheFCrANH6unAxPsk8dPY4Z5eRPDmMvT6YbDuDG2+lsPVsnCC+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlz1G1PGkwiFsa2oIdBmdqoM8LWuiu9ZZJ/L6uU29K8=;
 b=H6FCchpbY0TNSFaZCQM31o+1qDZb9sBWsvDqbWRN6Qf81sqqiL03gngCI55lx+0eMa38gjmDX9gSIv3jvZiRuxaFQVmy3Oc1xXO17lYKUOUXvbHHnjXR9nf+xgw6wXPI/9zezVyvL9QMUWH5WaljKtKwc393hX+KyXWsLcffag0hEQwPx14F/B9LSUZLUjIbQkDQ3q8fP8thj09LI+4BcM8zwQJH1HPMCkmKNiESDsbkqWkA28g3K2F7WbwmYzSeoJl329wdpgzY9Z3bRttROJTh27iDvcsZCZMhNKaU6Nsb92ayPIn+I1mvQZCmL2pJQpke73qVQXyphGrAc7ndTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlz1G1PGkwiFsa2oIdBmdqoM8LWuiu9ZZJ/L6uU29K8=;
 b=k/sMGRIJyhnKJOFcKj5umUiVLd93JpRQv7eLUqiwSXYQ3wV9/KqePAtRqYlA4MkFawS7aAyJVqB+ZgrdhnFVZgFCa+aFfTHjo+ZtNmL6t3eKojIvT//eML/0uTU4fSj3O90DLnc82Khi2M1JQ36ERd8oUDK4PVBtlCVrO1fooNA=
Received: from LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::14)
 by IA1PR10MB5898.namprd10.prod.outlook.com (2603:10b6:208:3d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Thu, 6 Nov
 2025 09:53:13 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::8d) by LV3P220CA0014.outlook.office365.com
 (2603:10b6:408:234::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.8 via Frontend Transport; Thu, 6
 Nov 2025 09:53:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Thu, 6 Nov 2025 09:53:11 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:53:09 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 03:53:09 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 03:53:09 -0600
Received: from [172.24.233.149] (ws.dhcp.ti.com [172.24.233.149])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A69r2o91022497;
	Thu, 6 Nov 2025 03:53:03 -0600
Message-ID: <c0c9c2df-89b0-4202-8833-f81dbe097250@ti.com>
Date: Thu, 6 Nov 2025 15:23:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/16] media: ti: j721e-csi2rx: add a subdev for the
 core device
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
 <20250911102832.1583440-7-r-donadkar@ti.com>
 <1d85a41e-e536-4c2f-9977-2743d0f8da71@ideasonboard.com>
Content-Language: en-US
From: Rishikesh Donadkar <r-donadkar@ti.com>
In-Reply-To: <1d85a41e-e536-4c2f-9977-2743d0f8da71@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|IA1PR10MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cb2a803-bc65-4a8b-389d-08de1d1a4c4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|34020700016|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2Y3K01uTmZiZGxMaDhzR2pBcHBiMGllOEpJWFo2UzAwRlY0WkFjam5Uby9M?=
 =?utf-8?B?U0J2dzRXcXFYQURuWDd4OEtzM3RpelNaT2VxNVlaZ1A2VHVtb1NYSlNTSGh5?=
 =?utf-8?B?QmZIOHYwSFFOY2dvNGhnOE9rMTFLNGEwOStXK1ZZNHFPbjZoWCsrNktjbVpF?=
 =?utf-8?B?MkVDQ1Nzbnc4cnJ2ZTY5VVduaFpyOXlqNC9iWFNicVIrZUxhWjgzTnE2L3h0?=
 =?utf-8?B?MFJIM0tXMFI1OGRGdUdEdnFnVVpjZlc2UVQrTDE4KzQwQnBzVG1wcUJHa2x5?=
 =?utf-8?B?MGR2dE1ZVDcwNnhHeHJ6WDNsV0tRRE5La2pFSENlNnNVTDFOR1BqTkZFTzdO?=
 =?utf-8?B?SWFPdXNCTUFIeTVsTFFGNGZ2YjJ6dTM0aE51UjBjd0ZLOUU0Nlg1ZDJCV1ZK?=
 =?utf-8?B?bnVzQ3RXblNvY3YyUmdjbHdmckk3OUpRSUtPRTU5dm5SWktLYnFxMFVJQnd0?=
 =?utf-8?B?REpMQy9sQ2pESGEyVE90UEdvYTZ1ZXFQUU93UEZoY2RLbFNJNVF1eUVNN0FH?=
 =?utf-8?B?cUxwT0RHNjJvSWVNMjJ3MmhzQTJnSU5oYS9SS3VwWmRyNWlRTHA2SHRzNWNm?=
 =?utf-8?B?TFZuZ0g5QTlvT2k4bGVHQjQ0d083OUJWSVFUUDVmK01EOEtKWDFZRXdVeXJN?=
 =?utf-8?B?Vkk4UVNOMVVEcW02OVZ2YlVQZzNVSHB0K0w5cWlsYnJZZGNnY2xHS3Y5NlBF?=
 =?utf-8?B?TTRIU2t0cXgydWc0eXh6czZGaDd6VVZFMk1rbHAvNFJSVHZqMUNzNit5d01s?=
 =?utf-8?B?YnkrRWlWdDUxWlF4em5sNUZndWFnVFFYSWg4Unc1U2dTTUtMME1ScnpsUGQ0?=
 =?utf-8?B?cVk2WXdZSkl6bEtON3RNTC9UK1B2UnZYTDlLNlFPOHd0SHE1WjA0Wkk4b0dD?=
 =?utf-8?B?eUFLUytNQkNQVlI0Q3ZrRTJnTHFGSGVXZmFkM1NFKzBtdVN5STZKOG56VWNZ?=
 =?utf-8?B?YUpvYmxkb3c2bVdHc2RjMVNudG5sU0xOSFFlOVcybjVnWVcwSGNjcHBVRnZD?=
 =?utf-8?B?cmpIKzcwT25TM3pPMENhblJvS2NNQ0tBbWFoejJ4ZVp2SExGd1NDbGsvWFF6?=
 =?utf-8?B?WUNNWldCb25WaFlSQkpxSFV0RFlSY0F6QVJNQmZMWnQ0UHVQUkJpN1RXK0Jq?=
 =?utf-8?B?SWsrSWo0SnVVSWxXdEpSUzhjaXpqeWo5bXBQS3dCTjE3SUM4dUhqOWVrYnQ4?=
 =?utf-8?B?a0pyMTFET0lVQmhFSmp5Ymo1RHJWRGlpRXk4TUdQeTFwY2JVZ1ZjekdrVlY3?=
 =?utf-8?B?alR1dEorLzdPVzVwVEFVWVE1am1yL0gxVFZDem5oSnM3RWZPa2oycFJLa1Bs?=
 =?utf-8?B?TGJQMis5NGk2SzFVUnhuQ2F6NHVLTGROdkoybFNPN2JFSnVhVDBma3ZETzM2?=
 =?utf-8?B?eFB4bk1OUkdERVk4OEJxNGlXdmZwZ3FtRGJKNGNsZGl1ZmZQN1JvRGRibTNz?=
 =?utf-8?B?Nm1keU5EeTBQMUR5eHFMaTRPalhYZGRKL2pvdEQ3RTZITGZXYVFFN0U5eUp5?=
 =?utf-8?B?YmQ4Y3ZIS2JVYW1TeDFiN21xSmhKMkpuRHorZnN6blNmRGRPM2k1eGpiQjVq?=
 =?utf-8?B?ckE0emorcXZBN003S0FJdXNOUUtXWDRoMVNUQVVJTWN5SDRsUEE3WEhSZldE?=
 =?utf-8?B?T25FcDJibUplSkJDQ0FGcGZ4UU5WOWJMejB6WVNJaTZHditwUGU2ZFNQSGlL?=
 =?utf-8?B?Q1U4UTZiY3FwVzhSUHJEaXVYOEFkTjNkdEY2endFSnhTdHpDMCtEUzljai9V?=
 =?utf-8?B?SXB2aGVhT0JiR1pRdzRWMUQyYVd6MkZ5eGxxcmg2UWZDM1B6cy9rV1NCajRp?=
 =?utf-8?B?b3JMVWcyRGlsMkcxK3hNczdPN1VKQ2dlUDN6T0dBT29EcWZjTkRQbTJiN2U2?=
 =?utf-8?B?WnVtRllMQUk3aGZDc1QwcjBhb1MzdGNzbFBkWk1mYlRjUUZRZjlaa3VPT3dC?=
 =?utf-8?B?RHM1TVo5Z05oZXBRSW9pUlAxWkFMSmJBT0RXNEFaTjMyaTVERUxDL1RxbXFI?=
 =?utf-8?B?a2FaYStuTzdlYVlscGJEenBMcnpTcGFPa1lGUXlvelhFeHJtQm93NTZnaHYz?=
 =?utf-8?B?TnZOU3V3ak1kVjFUV3o5cWdpVVIzQy9DdUxtMFlkK3V0VktyMUVuNk1ETzBo?=
 =?utf-8?Q?+M7g=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(34020700016)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 09:53:11.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb2a803-bc65-4a8b-389d-08de1d1a4c4a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5898


On 22/09/25 18:08, Tomi Valkeinen wrote:
> Hi,


Hi Tomi,

Thank you for the review.

>
> On 11/09/2025 13:28, Rishikesh Donadkar wrote:
>> From: Jai Luthra <j-luthra@ti.com>
>>
>> With single stream capture, it was simpler to use the video device as
>> the media entity representing the main TI CSI2RX device. Now with multi
>> stream capture coming into the picture, the model has shifted to each
>> video device having a link to the main device's subdev. The routing
>> would then be set on this subdev.
>>
>> Add this subdev, link each context to this subdev's entity and link the
>> subdev's entity to the source. Also add an array of media pads. It will
>> have one sink pad and source pads equal to the number of contexts.
>>
>> Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
>> Co-developed-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
>> Signed-off-by: Jai Luthra <j-luthra@ti.com>
>> Signed-off-by: Rishikesh Donadkar <r-donadkar@ti.com>
>> ---
>>   .../platform/ti/j721e-csi2rx/j721e-csi2rx.c   | 259 +++++++++++++++---
>>   1 file changed, 228 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> index 99a721e46d54..e49448e1f2ad 100644
>> --- a/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> +++ b/drivers/media/platform/ti/j721e-csi2rx/j721e-csi2rx.c
>> @@ -55,6 +55,11 @@
>>   #define MAX_WIDTH_BYTES			SZ_16K
>>   #define MAX_HEIGHT_LINES		SZ_16K
>>   
>> +#define TI_CSI2RX_PAD_SINK		0
>> +#define TI_CSI2RX_PAD_FIRST_SOURCE	1
>> +#define TI_CSI2RX_NUM_SOURCE_PADS	1
>> +#define TI_CSI2RX_NUM_PADS		(1 + TI_CSI2RX_NUM_SOURCE_PADS)
>> +
>>   #define DRAIN_TIMEOUT_MS		50
>>   #define DRAIN_BUFFER_SIZE		SZ_32K
>>   
>> @@ -103,6 +108,7 @@ struct ti_csi2rx_ctx {
>>   	struct mutex			mutex; /* To serialize ioctls. */
>>   	struct v4l2_format		v_fmt;
>>   	struct ti_csi2rx_dma		dma;
>> +	struct media_pad		pad;
>>   	u32				sequence;
>>   	u32				idx;
>>   };
>> @@ -110,12 +116,15 @@ struct ti_csi2rx_ctx {
>>   struct ti_csi2rx_dev {
>>   	struct device			*dev;
>>   	void __iomem			*shim;
>> +	struct mutex			mutex; /* To serialize ioctls. */
>> +	unsigned int			enable_count;
>>   	struct v4l2_device		v4l2_dev;
>>   	struct media_device		mdev;
>>   	struct media_pipeline		pipe;
>> -	struct media_pad		pad;
>> +	struct media_pad		pads[TI_CSI2RX_NUM_PADS];
>>   	struct v4l2_async_notifier	notifier;
>>   	struct v4l2_subdev		*source;
>> +	struct v4l2_subdev		subdev;
>>   	struct ti_csi2rx_ctx		ctx[TI_CSI2RX_NUM_CTX];
>>   	u8				pix_per_clk;
>>   	/* Buffer to drain stale data from PSI-L endpoint */
>> @@ -126,6 +135,22 @@ struct ti_csi2rx_dev {
>>   	} drain;
>>   };
>>   
>> +static inline struct ti_csi2rx_dev *to_csi2rx_dev(struct v4l2_subdev *sd)
>> +{
>> +	return container_of(sd, struct ti_csi2rx_dev, subdev);
>> +}
>> +
>> +static const struct v4l2_mbus_framefmt ti_csi2rx_default_fmt = {
>> +	.width = 640,
>> +	.height = 480,
>> +	.code = MEDIA_BUS_FMT_UYVY8_1X16,
>> +	.field = V4L2_FIELD_NONE,
>> +	.colorspace = V4L2_COLORSPACE_SRGB,
>> +	.ycbcr_enc = V4L2_YCBCR_ENC_601,
>> +	.quantization = V4L2_QUANTIZATION_LIM_RANGE,
>> +	.xfer_func = V4L2_XFER_FUNC_SRGB,
>> +};
>> +
>>   static const struct ti_csi2rx_fmt ti_csi2rx_formats[] = {
>>   	{
>>   		.fourcc			= V4L2_PIX_FMT_YUYV,
>> @@ -423,6 +448,17 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
>>   	struct ti_csi2rx_dev *csi = dev_get_drvdata(notifier->v4l2_dev->dev);
>>   	int ret, i;
>>   
>> +	/* Create link from source to subdev */
>> +	ret = media_create_pad_link(&csi->source->entity,
>> +				    CSI2RX_BRIDGE_SOURCE_PAD,
> Usually the pad number needs to be found out at runtime, but maybe it
> can be hardcoded here as it's always the known CSI2RX bridge that's the
> source here. Still... Maybe it would make sense to find the pad at
> runtime, to remove one unneeded hardcoding.
>
>> +				    &csi->subdev.entity,
>> +				    TI_CSI2RX_PAD_SINK,
>> +				    MEDIA_LNK_FL_IMMUTABLE |
>> +				    MEDIA_LNK_FL_ENABLED);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Create and link video nodes for all DMA contexts */
>>   	for (i = 0; i < TI_CSI2RX_NUM_CTX; i++) {
>>   		struct ti_csi2rx_ctx *ctx = &csi->ctx[i];
>>   		struct video_device *vdev = &ctx->vdev;
>> @@ -430,15 +466,17 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
>>   		ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
>>   		if (ret)
>>   			goto unregister_dev;
>> -	}
>>   
>> -	ret = media_create_pad_link(&csi->source->entity,
>> -				    CSI2RX_BRIDGE_SOURCE_PAD,
>> -				    &csi->ctx[0].vdev.entity, csi->pad.index,
>> -				    MEDIA_LNK_FL_IMMUTABLE |
>> -				    MEDIA_LNK_FL_ENABLED);
>> -	if (ret)
>> -		goto unregister_dev;
>> +		ret = media_create_pad_link(&csi->subdev.entity,
>> +					    TI_CSI2RX_PAD_FIRST_SOURCE + ctx->idx,
>> +					    &vdev->entity, 0,
>> +					    MEDIA_LNK_FL_IMMUTABLE |
>> +					    MEDIA_LNK_FL_ENABLED);
>> +		if (ret) {
>> +			video_unregister_device(vdev);
>> +			goto unregister_dev;
>> +		}
>> +	}
>>   
>>   	ret = v4l2_device_register_subdev_nodes(&csi->v4l2_dev);
>>   	if (ret)
>> @@ -448,8 +486,10 @@ static int csi_async_notifier_complete(struct v4l2_async_notifier *notifier)
>>   
>>   unregister_dev:
>>   	i--;
>> -	for (; i >= 0; i--)
>> +	for (; i >= 0; i--) {
>> +		media_entity_remove_links(&csi->ctx[i].vdev.entity);
>>   		video_unregister_device(&csi->ctx[i].vdev);
>> +	}
>>   	return ret;
>>   }
>>   
>> @@ -494,14 +534,13 @@ static int ti_csi2rx_notifier_register(struct ti_csi2rx_dev *csi)
>>   }
>>   
>>   /* Request maximum possible pixels per clock from the bridge */
>> -static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_ctx *ctx)
>> +static void ti_csi2rx_request_max_ppc(struct ti_csi2rx_dev *csi)
>>   {
>> -	struct ti_csi2rx_dev *csi = ctx->csi;
>>   	u8 ppc = TI_CSI2RX_MAX_PIX_PER_CLK;
>>   	struct media_pad *pad;
>>   	int ret;
>>   
>> -	pad = media_entity_remote_source_pad_unique(&ctx->vdev.entity);
>> +	pad = media_entity_remote_source_pad_unique(&csi->subdev.entity);
>>   	if (!pad)
>>   		return;
>>   
>> @@ -527,7 +566,7 @@ static void ti_csi2rx_setup_shim(struct ti_csi2rx_ctx *ctx)
>>   	writel(reg, csi->shim + SHIM_CNTL);
>>   
>>   	/* Negotiate pixel count from the source */
>> -	ti_csi2rx_request_max_ppc(ctx);
>> +	ti_csi2rx_request_max_ppc(csi);
>>   
>>   	reg = SHIM_DMACNTX_EN;
>>   	reg |= FIELD_PREP(SHIM_DMACNTX_FMT, fmt->csi_dt);
>> @@ -882,7 +921,7 @@ static int ti_csi2rx_start_streaming(struct vb2_queue *vq, unsigned int count)
>>   	dma->state = TI_CSI2RX_DMA_ACTIVE;
>>   	spin_unlock_irqrestore(&dma->lock, flags);
>>   
>> -	ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
>> +	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 1);
> I think it would make sense to replace these s_stream calls with
> v4l2_subdev_enable_streams() and v4l2_subdev_disable_streams() in a
> separate patch. Maybe before this patch.


Sure, but v4l2_subdev_enable_streams() would require the subdev for this 
device, so I will replace these s_stream calls with 
v4l2_subdev_enable_streams() in a separate patch after this patch.


>
>>   	if (ret)
>>   		goto err_dma;
>>   
>> @@ -910,7 +949,7 @@ static void ti_csi2rx_stop_streaming(struct vb2_queue *vq)
>>   	writel(0, csi->shim + SHIM_CNTL);
>>   	writel(0, csi->shim + SHIM_DMACNTX(ctx->idx));
>>   
>> -	ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
>> +	ret = v4l2_subdev_call(&csi->subdev, video, s_stream, 0);
>>   	if (ret)
>>   		dev_err(csi->dev, "Failed to stop subdev stream\n");
>>   
>> @@ -926,8 +965,114 @@ static const struct vb2_ops csi_vb2_qops = {
>>   	.stop_streaming = ti_csi2rx_stop_streaming,
>>   };
>>   
>> +static int ti_csi2rx_enum_mbus_code(struct v4l2_subdev *subdev,
>> +				    struct v4l2_subdev_state *state,
>> +				    struct v4l2_subdev_mbus_code_enum *code_enum)
>> +{
>> +	if (code_enum->index >= ARRAY_SIZE(ti_csi2rx_formats))
>> +		return -EINVAL;
>> +
>> +	code_enum->code = ti_csi2rx_formats[code_enum->index].code;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_sd_set_fmt(struct v4l2_subdev *sd,
>> +				struct v4l2_subdev_state *state,
>> +				struct v4l2_subdev_format *format)
>> +{
>> +	struct v4l2_mbus_framefmt *fmt;
>> +
>> +	/* No transcoding, don't allow setting source fmt */
>> +	if (format->pad > TI_CSI2RX_PAD_SINK)
>> +		return v4l2_subdev_get_fmt(sd, state, format);
>> +
>> +	if (!find_format_by_code(format->format.code))
>> +		format->format.code = ti_csi2rx_formats[0].code;
>> +
>> +	format->format.field = V4L2_FIELD_NONE;
>> +
>> +	fmt = v4l2_subdev_state_get_format(state, format->pad, format->stream);
>> +	*fmt = format->format;
>> +
>> +	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE,
>> +					   format->stream);
>> +	*fmt = format->format;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_sd_init_state(struct v4l2_subdev *sd,
>> +				   struct v4l2_subdev_state *state)
>> +{
>> +	struct v4l2_mbus_framefmt *fmt;
>> +
>> +	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_SINK);
>> +	*fmt = ti_csi2rx_default_fmt;
>> +
>> +	fmt = v4l2_subdev_state_get_format(state, TI_CSI2RX_PAD_FIRST_SOURCE);
>> +	*fmt = ti_csi2rx_default_fmt;
>> +
>> +	return 0;
>> +}
>> +
>> +static int ti_csi2rx_sd_s_stream(struct v4l2_subdev *sd, int enable)
>> +{
>> +	struct ti_csi2rx_dev *csi = to_csi2rx_dev(sd);
>> +	int ret = 0;
>> +
>> +	mutex_lock(&csi->mutex);
>> +
>> +	if (enable) {
>> +		if (csi->enable_count > 0) {
>> +			csi->enable_count++;
>> +			goto out;
>> +		}
>> +
>> +		ret = v4l2_subdev_call(csi->source, video, s_stream, 1);
> Here, afaics, you could use v4l2_subdev_enable_streams() and
> v4l2_subdev_disable_streams() right away, not the legacy s_stream call.
>
> And can we go to .enable/disable_streams here right away, instead of
> adding .s_stream (ti_csi2rx_sd_s_stream)?


Sure, will move to .enable/disable_streams in a subsequent patches in 
next revision.


>
>> +		if (ret)
>> +			goto out;
>> +
>> +		csi->enable_count++;
>> +	} else {
>> +		if (csi->enable_count == 0) {
>> +			ret = -EINVAL;
>> +			goto out;
>> +		}
>> +
>> +		if (--csi->enable_count > 0)
>> +			goto out;
>> +
>> +		ret = v4l2_subdev_call(csi->source, video, s_stream, 0);
>> +	}
>> +
>> +out:
>> +	mutex_unlock(&csi->mutex);
>> +	return ret;
>> +}
>> +
>> +static const struct v4l2_subdev_pad_ops ti_csi2rx_subdev_pad_ops = {
>> +	.enum_mbus_code	= ti_csi2rx_enum_mbus_code,
>> +	.get_fmt = v4l2_subdev_get_fmt,
>> +	.set_fmt = ti_csi2rx_sd_set_fmt,
>> +};
>> +
>> +static const struct v4l2_subdev_video_ops ti_csi2rx_subdev_video_ops = {
>> +	.s_stream = ti_csi2rx_sd_s_stream,
>> +};
>> +
>> +static const struct v4l2_subdev_ops ti_csi2rx_subdev_ops = {
>> +	.video = &ti_csi2rx_subdev_video_ops,
>> +	.pad = &ti_csi2rx_subdev_pad_ops,
>> +};
>> +
>> +static const struct v4l2_subdev_internal_ops ti_csi2rx_internal_ops = {
>> +	.init_state = ti_csi2rx_sd_init_state,
>> +};
>> +
>>   static void ti_csi2rx_cleanup_v4l2(struct ti_csi2rx_dev *csi)
>>   {
>> +	v4l2_subdev_cleanup(&csi->subdev);
>>   	media_device_unregister(&csi->mdev);
>>   	v4l2_device_unregister(&csi->v4l2_dev);
>>   	media_device_cleanup(&csi->mdev);
>> @@ -985,14 +1130,22 @@ static int ti_csi2rx_link_validate(struct media_link *link)
>>   	struct v4l2_subdev_format source_fmt = {
>>   		.which	= V4L2_SUBDEV_FORMAT_ACTIVE,
>>   		.pad	= link->source->index,
>> +		.stream = 0,
>>   	};
>> +	struct v4l2_subdev_state *state;
>>   	const struct ti_csi2rx_fmt *ti_fmt;
>>   	int ret;
>>   
>> -	ret = v4l2_subdev_call_state_active(csi->source, pad,
>> -					    get_fmt, &source_fmt);
>> -	if (ret)
>> -		return ret;
>> +	state = v4l2_subdev_lock_and_get_active_state(&csi->subdev);
>> +	ret = v4l2_subdev_call(&csi->subdev, pad, get_fmt, state, &source_fmt);
> Hmm, so csi->subdev is our TI csi2rx subdev, right? Why do we call it
> with v4l2_subdev_call(), instead of just using the state, which we just
> locked above, directly?


Yes. Will use v4l2_subdev_state_get_format() instead.

Rishikesh


>
>> +	v4l2_subdev_unlock_state(state);
>> +
>> +	if (ret) {
>> +		dev_dbg(csi->dev,
>> +			"Skipping validation as no format present on \"%s\":%u:0\n",
>> +			link->source->entity->name, link->source->index);
>> +		return 0;
>> +	}
>>   
>>   	if (source_fmt.format.width != csi_fmt->width) {
>>   		dev_dbg(csi->dev, "Width does not match (source %u, sink %u)\n",
>> @@ -1022,8 +1175,9 @@ static int ti_csi2rx_link_validate(struct media_link *link)
>>   
>>   	if (ti_fmt->fourcc != csi_fmt->pixelformat) {
>>   		dev_dbg(csi->dev,
>> -			"Cannot transform source fmt 0x%x to sink fmt 0x%x\n",
>> -			ti_fmt->fourcc, csi_fmt->pixelformat);
>> +			"Cannot transform \"%s\":%u format %p4cc to %p4cc\n",
>> +			link->source->entity->name, link->source->index,
>> +			&ti_fmt->fourcc, &csi_fmt->pixelformat);
>>   		return -EPIPE;
>>   	}
>>   
>> @@ -1034,6 +1188,10 @@ static const struct media_entity_operations ti_csi2rx_video_entity_ops = {
>>   	.link_validate = ti_csi2rx_link_validate,
>>   };
>>   
>> +static const struct media_entity_operations ti_csi2rx_subdev_entity_ops = {
>> +	.link_validate = v4l2_subdev_link_validate,
>> +};
>> +
>>   static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
>>   {
>>   	struct dma_slave_config cfg = {
>> @@ -1059,6 +1217,7 @@ static int ti_csi2rx_init_dma(struct ti_csi2rx_ctx *ctx)
>>   static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
>>   {
>>   	struct media_device *mdev = &csi->mdev;
>> +	struct v4l2_subdev *sd = &csi->subdev;
>>   	int ret;
>>   
>>   	mdev->dev = csi->dev;
>> @@ -1071,16 +1230,51 @@ static int ti_csi2rx_v4l2_init(struct ti_csi2rx_dev *csi)
>>   
>>   	ret = v4l2_device_register(csi->dev, &csi->v4l2_dev);
>>   	if (ret)
>> -		return ret;
>> +		goto cleanup_media;
>>   
>>   	ret = media_device_register(mdev);
>> -	if (ret) {
>> -		v4l2_device_unregister(&csi->v4l2_dev);
>> -		media_device_cleanup(mdev);
>> -		return ret;
>> -	}
>> +	if (ret)
>> +		goto unregister_v4l2;
>> +
>> +	v4l2_subdev_init(sd, &ti_csi2rx_subdev_ops);
>> +	sd->internal_ops = &ti_csi2rx_internal_ops;
>> +	sd->entity.function = MEDIA_ENT_F_VID_IF_BRIDGE;
>> +	sd->flags = V4L2_SUBDEV_FL_HAS_DEVNODE;
>> +	strscpy(sd->name, dev_name(csi->dev), sizeof(sd->name));
>> +	sd->dev = csi->dev;
>> +	sd->entity.ops = &ti_csi2rx_subdev_entity_ops;
>> +
>> +	csi->pads[TI_CSI2RX_PAD_SINK].flags = MEDIA_PAD_FL_SINK;
>> +
>> +	for (unsigned int i = TI_CSI2RX_PAD_FIRST_SOURCE;
>> +	     i < TI_CSI2RX_NUM_PADS; i++)
>> +		csi->pads[i].flags = MEDIA_PAD_FL_SOURCE;
>> +
>> +	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(csi->pads),
>> +				     csi->pads);
>> +	if (ret)
>> +		goto unregister_media;
>> +
>> +	ret = v4l2_subdev_init_finalize(sd);
>> +	if (ret)
>> +		goto unregister_media;
>> +
>> +	ret = v4l2_device_register_subdev(&csi->v4l2_dev, sd);
>> +	if (ret)
>> +		goto cleanup_subdev;
>>   
>>   	return 0;
>> +
>> +cleanup_subdev:
>> +	v4l2_subdev_cleanup(sd);
>> +unregister_media:
>> +	media_device_unregister(mdev);
>> +unregister_v4l2:
>> +	v4l2_device_unregister(&csi->v4l2_dev);
>> +cleanup_media:
>> +	media_device_cleanup(mdev);
>> +
>> +	return ret;
>>   }
>>   
>>   static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
>> @@ -1107,9 +1301,9 @@ static int ti_csi2rx_init_ctx(struct ti_csi2rx_ctx *ctx)
>>   
>>   	ti_csi2rx_fill_fmt(fmt, &ctx->v_fmt);
>>   
>> -	csi->pad.flags = MEDIA_PAD_FL_SINK;
>> +	ctx->pad.flags = MEDIA_PAD_FL_SINK;
>>   	vdev->entity.ops = &ti_csi2rx_video_entity_ops;
>> -	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &csi->pad);
>> +	ret = media_entity_pads_init(&ctx->vdev.entity, 1, &ctx->pad);
>>   	if (ret)
>>   		return ret;
>>   
>> @@ -1170,6 +1364,8 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
>>   	if (!csi->drain.vaddr)
>>   		return -ENOMEM;
>>   
>> +	mutex_init(&csi->mutex);
>> +
>>   	ret = ti_csi2rx_v4l2_init(csi);
>>   	if (ret)
>>   		goto err_v4l2;
>> @@ -1202,6 +1398,7 @@ static int ti_csi2rx_probe(struct platform_device *pdev)
>>   		ti_csi2rx_cleanup_ctx(&csi->ctx[i]);
>>   	ti_csi2rx_cleanup_v4l2(csi);
>>   err_v4l2:
>> +	mutex_destroy(&csi->mutex);
>>   	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
>>   			  csi->drain.paddr);
>>   	return ret;
>> @@ -1217,7 +1414,7 @@ static void ti_csi2rx_remove(struct platform_device *pdev)
>>   
>>   	ti_csi2rx_cleanup_notifier(csi);
>>   	ti_csi2rx_cleanup_v4l2(csi);
>> -
>> +	mutex_destroy(&csi->mutex);
>>   	dma_free_coherent(csi->dev, csi->drain.len, csi->drain.vaddr,
>>   			  csi->drain.paddr);
>>   }

