Return-Path: <linux-kernel+bounces-895311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A87EC4D7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3AAEE4FEE09
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747393587C8;
	Tue, 11 Nov 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ska1y8MZ"
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF853570A9;
	Tue, 11 Nov 2025 11:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861085; cv=fail; b=EoOhpHLNDHkLHYaXxqEEf/h2mnfl3/1w3IgPkjwnghcsDHX9qwd6uMTZrMv95WIlJKb5XW0UWTLhinMW7cAeAIDjlxhFmOGWIl/USOyWZwrO5X/dnUUyZFn9jx+Es4ktmEjUdcWiDfc46cqhnrw4qXG0195ZBnr/quN/1NmLnXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861085; c=relaxed/simple;
	bh=Oxv4ISbk2v2TM1mgoUqzKErbIdqEldmBTaF8nC4tyl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XOGb+79N/lK4Jfs6sRTWmJ0ISk8GX9qR63euihdG/N+jWsPeqSk6Jh+gNlAAhTL0jyCoieah6sOkfop31wKo5FDqwj4SGSo1VEyMFhXMawycSbPNYMWslGj4UC69E/PtVq+kZbDLeaQVwqoGsqjqzs33TWop1DPq4D17s3kIP8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ska1y8MZ; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSVKsKzUPxTeVIc3L6GKKaB2m/jVyzZbQInWnWWw3OWoc4sOS3x2gqa3bt0At5jFpLIrw3oCQLnuo+Uu4Ush3rlKUFoSZl4QPPqWGHGvzPHz30EYcpKhNUSvtV1UGGbcdtDIOGVgDm+GNSUav0fFzCTYi+xOknbee64LoLRXDu78Od8y23nDlKnUzmetZ3jszCboKyJcYY0HePqOYb/s7rTW3LJXhFbeoNkPt/fckW5/kNCNuX1xyR5nBpSyVEeizoe+vCsgY/HV9HOmLOC4TWV1MVj9wUkIYOVxxc6eUXBpDT4r2djhxNtvukdSRNyfIXhUu9jfMhQwmKHuRijMUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJc5foOp/lTZXnQ8N2XKAbUbYt31/IoC3cYtneLc420=;
 b=FoKOzusXmk8tUp+VXJq/CHDVT/z6TVIWrePlUz8cjaNs9yOW15Ix833xXF3sC9ajznaHr1fVsQorTg94dpeg+WTeoNVvCzY2APlByNE38EZHrD6oiD/Pkjn1HRwxKGkLqPhyFQQnPZN/ikJThb4/po1Ar8u9VNHQI92Z2MGX/oZ3lsdJsfWImP6NmB98igekf2a7AIkwqFOs0akHuhrhvyAp9jYBx22cVG04c814brl/3VxLq1K4RKoaKpNKQyA2S+y3GROnvJHaB3TO+uWy1hwzuHWl8q5QedrnMzhhv2d8/a7eXi+97LJAwBjMuUPdLCDld0bAAEwDNR9BlOD0ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJc5foOp/lTZXnQ8N2XKAbUbYt31/IoC3cYtneLc420=;
 b=ska1y8MZXjd18q/Zv+jlYTJsfUuV7fZcdXv0l1Dh1UXi+C7h9GVNoEe0q4lJFT1KMJR2Hvcf7QO6EMUDK61nsdBZ6vJ3lJqZQYPVZ1QGU1/sQF7JgoA4uUenrxuL9f1nom359LlA3yo75NPzUxL742B3qVDzh2+umCiBj8z38II=
Received: from BLAPR03CA0128.namprd03.prod.outlook.com (2603:10b6:208:32e::13)
 by BN0PR10MB5190.namprd10.prod.outlook.com (2603:10b6:408:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 11:38:00 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::25) by BLAPR03CA0128.outlook.office365.com
 (2603:10b6:208:32e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Tue,
 11 Nov 2025 11:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Tue, 11 Nov 2025 11:37:59 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 05:37:51 -0600
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 05:37:51 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 11 Nov 2025 05:37:51 -0600
Received: from [172.24.233.14] (shark.dhcp.ti.com [172.24.233.14])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5ABBbkXR845289;
	Tue, 11 Nov 2025 05:37:47 -0600
Message-ID: <f82f263c-fac2-492b-8981-d62fcb0f700d@ti.com>
Date: Tue, 11 Nov 2025 17:07:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
To: Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Sudeep
 Holla" <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>,
	Brian Masney <bmasney@redhat.com>, Vignesh R <vigneshr@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
 <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
 <6de227bc-af06-491a-97f2-800b7523ea42@ti.com>
 <PAXPR04MB8459AE5010282F9A6DB4456988C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Sebin Francis <sebin.francis@ti.com>
In-Reply-To: <PAXPR04MB8459AE5010282F9A6DB4456988C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|BN0PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aaeb8c8-dd48-49ab-586a-08de2116c446
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WmdLSHN6MFV5ZTVVblFpTzdDTkE4dnN0MXhPSy9kbVc2N3d1UGtYVFFTMG1s?=
 =?utf-8?B?SURlcFppc0l0T2VzYVhCWUIyTzlEV0t1TXFXYkhBaFNDMkVWbTBpK2lTYkcz?=
 =?utf-8?B?RUQ0UHZWbHZva3p5ZFVRbklNa3Z4citYZjZDNEIrYnBLNTI5UndXbUJkblY5?=
 =?utf-8?B?ZkFDWktKKzNIWVBRYWxWays5L1VDdDNDT1Z0VkJCbXY1S0h5RjJ5NnJEUmRU?=
 =?utf-8?B?bnl5eG9QVW9YcFBoLzZyWm5sMjFJdU16bHEzQXBHbXR3YTh6ZHBwUGFsUW5X?=
 =?utf-8?B?RHpIeHZqbjlGWi9QcUk3MWNtUS9RY2hpSWROazVkSnp4YmZ5Q0M5S09Oa01q?=
 =?utf-8?B?bVgvL2owTk1jb21JN2YxU3FBbUZvalJyS1EvbnMzeHBIbTg5UVdua1o1UnNP?=
 =?utf-8?B?OTlOTiswRGduM3p6UzhwZWhpa1hjbVZ5dGlIWVM0bFdsbWNtK2lwbFlmSGdo?=
 =?utf-8?B?QlI0MkNkcDBpdEtTbWpEL1lOeEhYcG9QNFZHQlNnR2l4TW9QTE5pTXI5Y2lH?=
 =?utf-8?B?bXo0K2NFVE5sOStXOFlSMTJMdWIzaFRwS2s0UXBNc2YvcklhdXJoQzB2WlJL?=
 =?utf-8?B?eEw2bm9FOTVxVGdHNGNmN1JmMk1YY01vZ3N3R2VtVzZGUWRYdUhjd2JkSUVG?=
 =?utf-8?B?ZnBMMWluYW9SbEc4TVFuZzdiSjFiQzZ6K3dxWHBmbUJCK0RHazE0MkFHdkRl?=
 =?utf-8?B?TEVLSE1VelVHMVIyR05BUEE4b0pId0NNQ3JvMFRKVnZkVDNOU3djbHI0c21p?=
 =?utf-8?B?b2QzRWR2Qjl2ejQvNlQ3Q1VYU3YveTJRbnBudlBzZVMwS29XaTA5QXNTSk5x?=
 =?utf-8?B?ZHE2Q0RONFhsc2gwcm5FcVJiSWNwZUVwaEdRb3lwK24rdC9OZnFudmpKWFFy?=
 =?utf-8?B?SkpoU3hNdmhuVWZqRUJSM1dQU1BRN0U3OWVZWGtZRmVBUVJhUVA5ZE1qQldN?=
 =?utf-8?B?N0tlMWh4SzBqMnhJVHJWOHFpcUtzb0R3U3pxeE1zUXdiWndqTTBoSXVlcERT?=
 =?utf-8?B?SUdza3pPclIyMXZnZ2JCaG9YQ3g2VlR4VDN0VmI2cTl5VUJGTlh0US95ZkNz?=
 =?utf-8?B?b0JZRXY1VGlUcFhCbXA5REgremdJNWcwTFIrR1NYdVJVaENENzlsYytkVmxq?=
 =?utf-8?B?b3JiTW9veG9ORk5xR3dvTnJHdFVkcDgvWU1OY3FoY255NTc5VnRRbzhiTXR6?=
 =?utf-8?B?MTFNemFlVUpKSnJiVXpDeVZwbis1M0NMaGduTXFmU25QSDc4b3lFUTczOHF5?=
 =?utf-8?B?OEs3T1VyZkF4eFBFdTcyb25waTJqN24rcjNFa3JRdHcydmVMZ1R6QnRUbjlM?=
 =?utf-8?B?cUZzUkkvZHlMdGlFTno1a3k5ODBmSURsSXpDWVQyU3cyYzBkMm1HcFVBRHdH?=
 =?utf-8?B?U3RxQlpmZDR5ekJ4Zm9vMlNwR3JhbGVYZEx2NmdadS95QVRZckpxVm1pS2h5?=
 =?utf-8?B?R3lyNmFLRmNCaVVZd0JabXVXNWZkaEdtWmZ4REc3N3lkZG5TelRLSHVyRkZC?=
 =?utf-8?B?M0xaMHNqMUFZbUxKOVFyUzI1amhUYTg0bHdROFFBSGYyVEUzTUxTL2RucTRG?=
 =?utf-8?B?OTRtZnQzUDY3akpvejJSeDBueTYraCtSTFhaOG9iMGsrdzZyRDZmbkw0M2VQ?=
 =?utf-8?B?dkRZaktzSUVta0RSYUFMMHhrajNyM0VNa0llYjdJVGY1VEZEODlXeStVbHcw?=
 =?utf-8?B?ZXhWQWJOVEhnazU2TVdJS096d3kySjJoRVNBU25qWXZ2bDVjb0FBblRpODZU?=
 =?utf-8?B?Z09vL1RzdTVSelZRaE4xRlZ0MnBkOTl5QWNkZExWMmdNVDhKSzJCMytCbHh1?=
 =?utf-8?B?SHNZUVpvcDJ1M3N2VUFTU2dqQ0xqdDl4Y0pVakJ5Y0RsRGZPaDRhT3VKNjBU?=
 =?utf-8?B?citQVkxYYStkdUM2UFpxeVYvcGRrMTExc1g5MEJ4N0t6bEoxcVZNM1lmcXM5?=
 =?utf-8?B?UWhjaG9JSUlFa1ZVTDJiMjFEWFRXbXVXeXhhWVFIR01OY0F3TW5hKzN5YWxJ?=
 =?utf-8?B?bkFMVSsyTzB6bVVVVUcxKzZScFhMaENOQ3V5elgwN21UbElDc2lQS2ZvdGMx?=
 =?utf-8?B?QjFoOU5JRC9FTm9kSndBZGtXOWdUamxSZkRKWDZqc2hmVHRGWVdWM0FNN2Qw?=
 =?utf-8?Q?m68PXAG89QYniQ/iIjSb90C+n?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 11:37:59.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aaeb8c8-dd48-49ab-586a-08de2116c446
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5190

Hi Peng,

On 05/11/25 21:18, Peng Fan wrote:
> Hi Sebin,
> 
>> Subject: Re: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension
>> support for SCMI clock driver
>>
>> Hi Peng,
>>
>> On 09/10/25 09:18, Peng Fan wrote:
>>>    - Introduce 'clk-scmi-oem.c' to support vendor-specific OEM
>> extensions
>>>      for the SCMI clock driver, allows clean integration of vendor-
>> specific
>>>      features without impacting the core SCMI clock driver logic.
>>>    - Extend 'clk-scmi.h' with 'scmi_clk_oem' structure and related
>> declarations.
>>>    - Initialize OEM extensions via 'scmi_clk_oem_init()'.
>>>    - Support querying OEM-specific features and setting spread
>> spectrum.
>>>    - Pass 'scmi_device' to 'scmi_clk_ops_select()' for OEM data access.
>>>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>>
>> Thanks for the patch. I only have a minor comment, otherwise the
>> patch looks good.
>>
>> [...]
>>
>>> +
>>> +int scmi_clk_oem_init(struct scmi_device *sdev) {
>>> +	const struct scmi_handle *handle = sdev->handle;
>>> +	int i, size = ARRAY_SIZE(info);
>>> +
>>> +	for (i = 0; i < size; i++) {
>>> +		if (strcmp(handle->version->vendor_id,
>> SCMI_IMX_VENDOR) ||
>>> +		    strcmp(handle->version->sub_vendor_id,
>> SCMI_IMX_SUBVENDOR))
>>> +			continue;
>>> +		if (info[i].compatible &&
>>> +		    !of_machine_is_compatible(info[i].compatible))
>>> +			continue;
>>> +
>>> +		break;
>>> +	}
>>> +
>>> +	if (i < size)
>>> +		dev_set_drvdata(&sdev->dev, (void *)info[i].data);
>>> +
>>> +	return 0;
>>> +}
>>
>> This above logic is tailor made for IMX is it possible to make it generic?
> 
> Yeah. I will update it. It should compare with each entry in
> const struct scmi_clk_oem_info info[] = {
> 	{ SCMI_IMX_VENDOR, SCMI_IMX_SUBVENDOR, NULL, &scmi_clk_oem_imx },
> };
> 
> To TI, I think it could be extended to
> +const struct scmi_clk_oem_info info[] = {
> +	{ SCMI_IMX_VENDOR, SCMI_IMX_SUBVENDOR, NULL, &scmi_clk_oem_imx },
> +	{ SCMI_TI_VENDOR, SCMI_TI_SUBVENDOR, NULL, &scmi_clk_oem_ti },
> +};
> 

Thanks for updating it. Yes, for TI as you mentioned we will add one entry.

Thanks
Sebin.

> Regards
> Peng.
> 
>>
>>> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c index
>>>
>> bf85924d61985eb9e596419349eb883e3817de73..1ed2091e3d4a951
>> c8662db4c94de
>>> e4b9c98b8326 100644
>>> --- a/drivers/clk/clk-scmi.c
>>> +++ b/drivers/clk/clk-scmi.c
>>> @@ -14,6 +14,8 @@
>>>    #include <linux/scmi_protocol.h>
>>>    #include <asm/div64.h>
>>>
>>> +#include "clk-scmi.h"
>>
>> [...]
>>
>>
>> Thanks
>> Sebin

