Return-Path: <linux-kernel+bounces-800206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48A6B43483
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681925E3027
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E527B335;
	Thu,  4 Sep 2025 07:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="sc1I5xnR";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="XBTUYhpv"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E5327AC48
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756972119; cv=fail; b=OYJJd6Lh8/7sgBObMrkg9gfaqPzylcHo+LxqOCMwhyHzCb9/kRDqNEKJmEZtphcGwMuJq5csDg4LSX/XgXSu1AExEdoBCutbrqlycRodWxLzxzwi6NzR3MCNcXxue24IykXxIVKDNFW/wDr8vX5yOk/ul+OB02jwNTy7Q1UCALw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756972119; c=relaxed/simple;
	bh=Hl6ryT7G/oDLhN7HU154RGGHqQH9O8GIIq8HbCM4Qp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uO2sEn3TlF5NFyPNRgUyVKz1VXDny5IdOp830jqBJ88Ph0CWw1wivLagJ1hO4Tcs24HW1529zmoInHfLkjfh05q2qvlUFSRpZIffOUqDhDalqo9/ejofqffgoIEj1kHWJXAbkowx6bR6gxQo3sHOq7oAglh9xDjC2jPcqMAHzXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=sc1I5xnR; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=XBTUYhpv; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5847IPEQ011620;
	Thu, 4 Sep 2025 09:48:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	GQZT4UOW2K4nU5mj19bOXPZ3JJF2pGE4sMcjYoD3iBI=; b=sc1I5xnRt46U4bKI
	kHiem2T2wptm3xJ2O07aDKYqkYQ3xCPQh8RwrHXzxlboPlj0c+gVdq2oOCjE+rZ7
	2Ttj60v7wZSWGuaiPCGc6C8FxBHMHkIDKAfV2SyXaxdz2ZG/Sx+ajonaFrb31Qpi
	MlVEM3pjtoYNvP2DQvVvZNCsCIv/Wp3IeLmZf3Reh/q5YI7i2rztYLVKY4o7h4SY
	kB9OxYAriVik6xqIEXiDT+azEpXGZP8cK7RS8ocPBTQS3FHCwQYVSC28yy1/ySvx
	+AJ1snX6EpjQfEkGWXpP+UgrTiqJi1a/QiIDbOaqG1XHdie+W0gUSdyTj0qD8VrO
	/v+IeA==
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48upe7m9ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:48:26 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXHTnxZQYIMFUgZtaYXzHgba5KSSnSLBFA1FaEsgfnhraKh/dnLcyvlL8fic2XRSXyHCPuR0Cw4EEQFQ5QejlMi352jALqpUw7bLy1ZkyKclzSi5uwiai4t08/7sh2NaWdBUJFaQXPI1jrzAG7Z1W746t0ZEQJbKmtz/4luvVfnRWFQq35dxzyOk4t5N+WSPMethnsS63BrqRNnnZAj3QoBXl6jjOwCp2m0+AwYiNLYCqLZN7/Wn4fHGiDaKrdJXy7gxeXfEh3h82fiMouEvfQIbv4RJm50vm1w+fKRfKFToUq3oYORxLes+71tceAwAY8xLtd7Vt02dQZV1kCnViQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQZT4UOW2K4nU5mj19bOXPZ3JJF2pGE4sMcjYoD3iBI=;
 b=NGSN2jnClDojBqdTwL1sRdnFJJ2FNydHDVmFE6Opv4M3ZIv1GvsJSOnw4qMOSGgljY3arQIqSwsv9q8t8L2VMPC8lyaqUYv0yRAY5eqe19Mr4ZybR9jxpH+FoEpRgcA7XCitpSGyG5cFLVT7qH62AzcHmlZSiTnFY+NncI/PScxl69a851fywd+LXNKsFrY+LTyUHhmlRxQaW6+/2uce5fmd/r+hJrxPP4OQe9aaMHQkHnxJBaZjVz40HT4tVTDdW04yZoZ0RSDic1b1r2befudgVZjytHoTuSySICXm48SMzJHxpeTAiLF+z1VFfIL2tq0oKCV8e9ziDA3oSVqivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=arm.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQZT4UOW2K4nU5mj19bOXPZ3JJF2pGE4sMcjYoD3iBI=;
 b=XBTUYhpv6x6mOkHNVv5ciJfMNv9jUwt2qg6XaRwEAcRkZAwQPRkpFxmowXvtkME7DrD/UksnE+L4OS/aY69cVSDblcyTAnFAR+bANf50l2R79v7ETTJn9uaL33Wd+qDIATjPe2zwckgwsxRlYMGV1mrIW4krqyu4XYPNlugaRS0=
Received: from DUZP191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::26)
 by PAVPR10MB7057.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:302::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 07:48:24 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::72) by DUZP191CA0043.outlook.office365.com
 (2603:10a6:10:4f8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 07:48:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:48:22 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:46:04 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:48:21 +0200
Message-ID: <e66cd47c-41c6-432d-82ae-a5dbd41a48c2@foss.st.com>
Date: Thu, 4 Sep 2025 09:48:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Enable STMicroelectronics STM32 DMA3
 support
To: Patrice Chotard <patrice.chotard@foss.st.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20250821-upstream_defconfig_enable_stm32_dma3-v1-1-d9c1b71883d9@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250821-upstream_defconfig_enable_stm32_dma3-v1-1-d9c1b71883d9@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PAVPR10MB7057:EE_
X-MS-Office365-Filtering-Correlation-Id: 617ce9b4-22f3-4f7b-cbee-08ddeb876c77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3VVN3ZDb2dDTjFXRTMwRCs5R1llWmRPeXc0R2xJY2piSHRTOXJnZWs4VllR?=
 =?utf-8?B?am4wV0F0bnVLU0FwbDA4YnFkamNlZ2d0ZzdnOWdZTDJwd0kvN0RwdDNkMmtw?=
 =?utf-8?B?dlM3ejY1SzdTWGh2eXVpK2VtTFZkWkVFNEJpREZ2Z3g5NExkZk5FZUxUdUkx?=
 =?utf-8?B?ODZGZGp2eDFBRGs4NEU4SitJZGpGelFEelpVVFo1aDFQdWJ1Qy9UZFUyNmJ0?=
 =?utf-8?B?Y0dVN3hKTnhORE5WMkxsWTRZWFBVQmdaN0tBNHF6UVdXRDNURVVlNTdZUW02?=
 =?utf-8?B?Z09OdWtHQ0czWTVLd002a2lFVEJnWU9VVldlajFQbjV4SWpQRVJ4RUhmUTBp?=
 =?utf-8?B?dk5rRUM3NXliVi9pTmlJN2FwMUtwZWhaaGdrL3g5Nkt3dEJVVzdsSnBKUmNM?=
 =?utf-8?B?V2xLMGxJTlJQaTlFL3lYNHQ2YUh2Z21uQWYyK3JEaGRUU2l2V3pMVWNSNmlh?=
 =?utf-8?B?c0hnUzFzRkxxY0tZVEtRdU1ibittVjlSM3RrR0VhbkN4Z3ZtWU5ZbDViY3pl?=
 =?utf-8?B?VGpSTUNMQ1FlY1YreEcveDVTZFhRMC9lRm1nVWpYL28wdkV3Vkd4dlJZSmU4?=
 =?utf-8?B?Y3RMbXp1SlFwVGNJUHpmME50akM5eVAxUkxQeDdjQ055dmhGQWU2NUlpTXAy?=
 =?utf-8?B?SEpDZi9lMk42Z0w1cVluTU9LT2VNTVdvTkpnVmJRaGFLZlN3VFJYT2d2K1J3?=
 =?utf-8?B?Q2lhRG9tZXdoOGtKR0hPaUl5NndwRVI4NUJBTnVBbjJSdVVudGEwb2J3b3p4?=
 =?utf-8?B?UHN2cndSRGtjeWNXZ0xHR1lDa3RmU2RsTkoxMFBWTXB3S2d6enVmRlBQeWJp?=
 =?utf-8?B?UFVLWWRTckdKa0lna0NDc1Q4a3pCeU1ZaytITU50QUkrSFY1dnZkTWdYYWRu?=
 =?utf-8?B?NzZtK3hNK0FXSFkzbHJZTWtlWFZ3NlNTUXFScjdPcXFjMDhaNzVrWVBWd2ZL?=
 =?utf-8?B?TmIzUXVtdjd1aHBVSFhyYTJRNEl0MDBmM1FHY1ZRY2hVbUxaeXVtWTltSjBH?=
 =?utf-8?B?T2ZBenY0MDVhRnR1NWg3NlpybG5zZjFJb0hTY3A2RkJoU3JndWlFbUJvd2hG?=
 =?utf-8?B?NHovaFNaWUE1U25MY1dBaHoyOEFZb3ZTUXExZGUzcnhXVmxrZFZOOHk1ZlVu?=
 =?utf-8?B?VUFuTXpoKzBSZ0srQjA2cXJqSVBpeGpucVNFK2dqUHlZTTJXZWxpTTQwMkt3?=
 =?utf-8?B?K2JIcXZXZk5rN2p6dysyL1k4RHlQU2plUHZML1Y2RE5RYk1Zb2V3K2dTQ3ow?=
 =?utf-8?B?VXNqQUJVTlpWemhyak9tbUdPRXQ2eTQyVWxGbVMxZ0lGOTM1b2hBc3NEKzlW?=
 =?utf-8?B?YWhBMlN6dWlHVjEzb0w1cnJLeC9kNDZpR0Y2dUlEcVdNcjVreDV1WDFmeXhN?=
 =?utf-8?B?R0NvL2JyWnFCYmhXeVJPWDIvdkNzN1RyYVFzb1V0K2ZCV1psdFVrRmhnMjNX?=
 =?utf-8?B?aFlSTnhSRHVPVXBWLzJyVk54QmM0eVpNK2FoM0tIQjBBeEhjTjNjVHpLbTRK?=
 =?utf-8?B?K0ZqN0dtcEthL2c1c0s0bzAyUkwrSVlBaWRma2dqRlRuRkM4QmErWG8zUDRX?=
 =?utf-8?B?bGtQcUtBVVdmWGpseWg2U0JJT1V5Z3cwQ3RjYlZBcFBOT2Vrbkl1UiswM3p4?=
 =?utf-8?B?eHpkNFB1cFFzL0RFMjRObDA1YWNBNTVISHlnckNnUDc2UHlsVEgzZG9OTEtl?=
 =?utf-8?B?clJCMTNRY2dPaEJxYlJsOXpoVXFrcXBEY3Azem1CTnJwcHcvRDZRUFk0YkJl?=
 =?utf-8?B?a1JHck1BQUhIRFpMS2tsUXZYZktGUjYvVk5iV3R5RW5zS2ZWWGZKK3h6RVJX?=
 =?utf-8?B?K3QvWnZFcTN4THpiYjdXLzRYeWs5bC9rV1p1Z3libk5iTXlFR2ZaVXFtTTZG?=
 =?utf-8?B?L0ptRjdCL0FJS1gxTzUzNmZLSU04aFF1NkFGNFVJYUhybUdKdVI5SVpXVVRx?=
 =?utf-8?B?aUMyRmNnVmhjV0dsZiszYTdMb2s3RlpnRVZ4V09FeW5zUFFLMzBsT1p2eG41?=
 =?utf-8?B?UTVQYUtRVmVVbWZXam5oWEFvQjg5TVFhTnMvWkg5UHl3Qzh1YUJoMERoNzU1?=
 =?utf-8?Q?3UTZYx?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:48:22.8221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 617ce9b4-22f3-4f7b-cbee-08ddeb876c77
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7057
X-Proofpoint-GUID: aSH8kDejJNFitcs70WKDdzrC-DRtiVeL
X-Proofpoint-ORIG-GUID: aSH8kDejJNFitcs70WKDdzrC-DRtiVeL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI5MDIyMCBTYWx0ZWRfX9uteePiw+A2h 66mbBdsyboqmDLTFOt1BYRs7jwhY62+YlSc84MfXFXhtHctmnhQa7EGp6IJFjqwvpP2TW4AamLh i1phhIUtqo2iMZN47c7at9Mw8k8svihcLk9DidqJUc7GuzCg58BIKvyZOnPatRF8G7gwQuSS4QF
 zwDRXyQKAR5mfGvtmLzCMRM33pkRVkLdu21zybNmcLnpMyi3CvJwQVzsQX3Qzof9XdZWTss6Ncr v49/74o9/l7KITJAizQNfZEf4+84919xHMKpwKTXnxbwrhTFRH8Oj2n7ZTOmU7rU7ZNcMuBeJDT 6PZGZz6ipH83wnejTlxeqZQY3nsX2+k6IREltJD+dTRNbK6sXqkPX/+RBIsFth3f6vhDJ+gVRJk RZmXP6Cq
X-Authority-Analysis: v=2.4 cv=Vq0jA/2n c=1 sm=1 tr=0 ts=68b9444a cx=c_pps a=Uuq83E/5hH6QxGThgS15Jw==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=vGnLZm69KljG1-TqoOwA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508290220

Hi Patrice

On 8/21/25 11:14, Patrice Chotard wrote:
> Enable STMicroelectronics STM32 DMA3 support as module.
> STM32 DMA3 is used among others by STM32 Octo SPI driver on
> STM32MP257F-EV1 board.
> 
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 667c4859ecc3cda9b0a3dae7abdd8587fc4f8dbe..d0a9d2a5b140aabe40927981ee710b0eb3b729cf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1302,6 +1302,7 @@ CONFIG_RENESAS_USB_DMAC=m
>   CONFIG_RZ_DMAC=y
>   CONFIG_TI_K3_UDMA=y
>   CONFIG_TI_K3_UDMA_GLUE_LAYER=y
> +CONFIG_STM32_DMA3=m
>   CONFIG_VFIO=y
>   CONFIG_VFIO_PCI=y
>   CONFIG_VIRTIO_PCI=y
> 
> ---
> base-commit: 5303936d609e09665deda94eaedf26a0e5c3a087
> change-id: 20250820-upstream_defconfig_enable_stm32_dma3-c1c93f116e62
> 
> Best regards,

Applied on stm32-next.

Thanks!
Alex

