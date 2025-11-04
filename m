Return-Path: <linux-kernel+bounces-884596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E8DC308F0
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 11:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA7EE4EC600
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 10:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D902D6E67;
	Tue,  4 Nov 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="gYSfu+0I";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="dimYbER0"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00127E04C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252871; cv=fail; b=D49X5yqO4lalJS3iwJOL+7rGatvx7EIry4ycqRDjjjLWv9qe6v4JBiY+t+lpEIboXwtSr8YRxWI7swbf14kNtlyOmgTbzispaalC7/cz6KQja8jAqESOTyKUsN7xP924EYxl2M26WJSgx9RZiBOu49iaQoyn5VKQ6Nd1tcOSSvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252871; c=relaxed/simple;
	bh=41S5xNhZGclj9t7Se2ElCYtOgMWfMbB5vsFJ7xRN1uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j1RE4ARKZOwxAiv7jR72YiGHIe4K2bQTjxxVE2faf+/UFLOhtCVuQp26zNDkgSTjt60qyvXql+eHJGc8YA2EQYTcQSbdbPBLBhMsZ93RlS0eFKkF7o4ywFN5y8u1LXGZQ0P8LYUqDs/3+8iTIgM6RdPZUfOX0yDszQ+MdhTGgr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=gYSfu+0I; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=dimYbER0; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A466lQb3342456;
	Tue, 4 Nov 2025 04:40:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=VlsgBG3NGr+V15nQc98jVRwaPb7jT+LIcNhctPuYWDY=; b=
	gYSfu+0IXjX+xmi92NNVZA2xYVKXuHJVahwSrWV9dLo7MzAThwZUBIpTlPOJTv6m
	5pbu7uAzUCW04KwmBN2K+xtxHdXDJXG7iJmapD7PIl9ieddfB/meHB4jg2fz2ad4
	HJE59pDV7W5Nw8lUqyU0MNI8XQqZXi60GXihCEIVdJdHrDgbqzTF60nhKcR5isIp
	OmNLHPLdjXVRROejmmEhr8G8BzT2g7TPmFW0K06hA+HT3ckSjLXOBObs1wD9RX7L
	GkxmFS5VbqCvYw49AJD/IJwyhy2lcAeOWkMAOHKlpAwJmC1p1nFl7fXGaiVS1pJY
	PGwEFJVoUzTM/DbJW2wN6g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11022072.outbound.protection.outlook.com [52.101.53.72])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4a7bwx06ys-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 04:40:55 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IfxH1JsSD6NjEnVFJp0y4vyYT3SY0hbpm8hsX0xSW1emTdWjT9PLO4WUAOgvc0e68VtxWS4qJZw7ecdqrhZGvZyBMWl9hn8sfgbP27hOANpGof4YUgvEKJfNnRAw9y2xhXdH7/T4pnwko5mJtiHNDNFPsAp1qbO8wzvEJ7/3/IoqAeN0tx9NKE9ep8+CYbbEPBul58GWF6PeS9akZvcS4Gsvfd9qZmaY1X/5IvRMFgXhfSxZ/LkBmV3m2NIr04RJzByh35x/5Q7nB3PaH4WqRG7VWBLstjrhgZhTCgCNw5VSeFz6fnlmt1ZZBVUhFm5B7Gv2PUNid3uBWv17crCNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlsgBG3NGr+V15nQc98jVRwaPb7jT+LIcNhctPuYWDY=;
 b=xrPIl33YLFB5N9BsMsSYgveV07+T/T9hskR5Z5On2uE0RN5rLpOjRc55tA/r6wn2G8T+jS3cpWuCTJQ+FfO68Td3nMULye+vEW3tfgbDoKtJ9cPe/ss4Wgvyvj/0X42bIPKc0ekwPMbTuFxie/J+XxkL1aFMztJ3VIJEvUb1bTcNyNukyMgqNy1K0AOVRZoHw7KdE3rnUO+gCn6uIEu1eH0w3IB5kr4xhH8XqzqvSOJ0kyjm1u3I6PsEqa0kTMGSKIygsEZOb3D+ZlM6vqKG9MpXNmKyrXwplT43BzzEV0qpFXJVMKbZXAVJxAHxjjclnn2aIOC3zIdiAOf4fzXmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlsgBG3NGr+V15nQc98jVRwaPb7jT+LIcNhctPuYWDY=;
 b=dimYbER0YXgNR5hykBMzsqOr84DEvNu/68JOVQzOSyVmWqSZ+yoyKEY8R5+Q0NfPnEpgojQCAw+OMJpHA28O3n2sL4MoaScW0K7NIhyFr1aTPRytQ8gLXEpkxSEhS+VUMi+Woq/EXKJra0MVbziKgc3u/I/ucyErLWvibdzvZtQ=
Received: from BY5PR04CA0001.namprd04.prod.outlook.com (2603:10b6:a03:1d0::11)
 by IA0PR19MB7726.namprd19.prod.outlook.com (2603:10b6:208:3de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 10:40:52 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::5e) by BY5PR04CA0001.outlook.office365.com
 (2603:10b6:a03:1d0::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 10:40:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.6
 via Frontend Transport; Tue, 4 Nov 2025 10:40:50 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 57E42406543;
	Tue,  4 Nov 2025 10:40:48 +0000 (UTC)
Received: from [198.90.208.24] (ediswws06.ad.cirrus.com [198.90.208.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 35997820257;
	Tue,  4 Nov 2025 10:40:44 +0000 (UTC)
Message-ID: <f1628a6c-6937-4951-8874-5fabb8c55208@opensource.cirrus.com>
Date: Tue, 4 Nov 2025 10:40:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: fix kernel-doc warnings in a header
 file
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Simon Trimmer <simont@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com
References: <20251104004241.482723-1-rdunlap@infradead.org>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20251104004241.482723-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|IA0PR19MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: a8dec7d3-eab1-4f73-9c15-08de1b8e9fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TW1pTHVIQXA0b1lTSG45K0U2QnUrZHhtVXVWWkhVMVVNVGw4U1FJNXFNYWI3?=
 =?utf-8?B?c3A3UGlaOVJtUVdIQ2JBZW8vVytvcHhPajJXMzM1WGlKdURGRWJlL3dNZEZM?=
 =?utf-8?B?cFltQzhUWlJSWG5rVnExNUhsMjVOS0U1ZVp1MVBxRjNKUU5zeUttTEpLVEkr?=
 =?utf-8?B?S3JEeGwyMzY3NnA2ZXlRZ1grQjY4bXV2TFc5UE5TSUxvQmUyNThWY2N6Vzgy?=
 =?utf-8?B?OGFPNHNJOFc3OE9la3RsWm9KeVh2OEU0SWtVdm91Q0trQ0UzTzloQTUrYndo?=
 =?utf-8?B?YVhvUXVFU2x3VU11ZTdDdUVKM05najdHOWVMTGx5czQxdGFrTCt1U3hxZGJ6?=
 =?utf-8?B?Q2w4OU1keXR5MElJam45b0RsMHdNKzh3dnNmRUs1MUpNdTJ3SE9UeTVFV0wx?=
 =?utf-8?B?TEdmVXk1aDFXYmRqajhhTVdxNWY2UlUvUzRxNTIrdlRqdEpEWVM4U2N3cEVB?=
 =?utf-8?B?YkgvWXl3Tk4zUEhGRFlrdks3dWZOajVpa2QrTTU1Y3JpQkY0V2NyZVRnbjAx?=
 =?utf-8?B?ZktScW9FbjJtY21BdmZEMFk1NHFYeHlaQkI5eWh2RkZNUS9UUUQyUE80ZWhZ?=
 =?utf-8?B?QVFscFRCMHVLVml5MWwrQVFnSXRDMWZMRlhpYXo0c1FvYTNwakhybDBIWnFS?=
 =?utf-8?B?ck5vRXVaRmdCb0VXQXlDREQwSGlwNThVRFpqMU9rMGRBWFBCZlhyR0Qrb0Zv?=
 =?utf-8?B?L2tTMGZ5RFZMZFdCSjUrbHFFaVpNazVNZW94MWEyTER5emd5eUs4UTlncmZB?=
 =?utf-8?B?djN0ZFlKbkF5TlpVdU82U011L0syMlBkcmJ4MXE2ck1IZ1VoVVEzUTBzd2JE?=
 =?utf-8?B?OHZZQk96VjR5L3diQk9OSUZ0amNVbFp3NnYzYkd0RXpyMnNOaENUUXp5c0Q1?=
 =?utf-8?B?V3N2blFONCt4YzhFMmU3Qk1WMmRVdlIxWGdtbzRRQmFvVmZETmJRWWxZN0Js?=
 =?utf-8?B?dWtxSFYxTWRBbWNkcDMzL2tUcnNYSlBLN1o5dVBvNTVwWjJxcVNnU1poM0c4?=
 =?utf-8?B?V1BCSjR6VFRZZE5sdnJoaU5scWplZXg1a1ZvSkhLL0wvYnR3c0tvQnAvMkJq?=
 =?utf-8?B?TTNJVnZOODFSK05sYy9xckR2WjNTQjl5Qi9BL0xEUDVodTdrUkNncXZjY3pW?=
 =?utf-8?B?ZDludFNVYUo4OW9DenM1Y1lWaVN3dTFJLzVZbmJKUEZrSHYzYWRreG11cWhX?=
 =?utf-8?B?czFzOHFXNFJ0aEtlY0w3bjhZT0MrL2JqR2pyd2UybkZ4blIveW9hT1kyVHE2?=
 =?utf-8?B?OFlBVm5wdEhuRzhFSVVwWGI0d0RHejdDaFI3anR0Z1JZcDl4bEQ1N0JhdGdx?=
 =?utf-8?B?dWg1QnJ2Vlp4bCt1T1VJd1drQURVUmNKMytmRUQ5bS85bjh6L1ZXcGJLNkVW?=
 =?utf-8?B?OEdLOTY0L1pNR0FrUGdCOUdNOGMxVnRFSU9XeElESE5wK2NCSTVmOFVMa29j?=
 =?utf-8?B?YSs3Q0FUT0tHOWNBMkRVeTlNZXBOSFlKM21MOE1xVnpvbHUxT29jNktlZHIr?=
 =?utf-8?B?ZjFhdk5Wanh6akwvUlBnY3BXamYxWHl5Vk8xaUwveFB4ekJSSW16aEZkdkJq?=
 =?utf-8?B?ZGNXVTF4UStXcU1JWVBiM01QNDFnQWhMNWhoOUV6eFE5aFdBUWFjY0d5bXFJ?=
 =?utf-8?B?ZTlOaUJNbnpVNDVyWHRPSERYK29LNDZ1dTROdDNOQi9uRWtWTS9kczVkVy9D?=
 =?utf-8?B?Y0Y2TGQ0SnNtUElPR1p4RHNPTm5TdVZtV2pIbmNLUmczUGlQT1NiS2hDN1V5?=
 =?utf-8?B?MVhIZ0p1REVEdzJyOWJjcmhrRFQzZnIwMG1OSzFDZzlhSUIrSXdmU0lTc1JJ?=
 =?utf-8?B?UkZtYTJ6ZEwvc2svVE1xOG40OHg2L1BKM2VTUjlFR2JWWVQ1d0ZOcEZqcnEv?=
 =?utf-8?B?aWJNemFZcUVRWlh4eFVEZytqNll2cHltak5zdEhjVWFEYzZLaXI5WGpqSHJR?=
 =?utf-8?B?UVJwSnkxT05wMEwwMml0WFZvNHppT3dsZUlGR2F2TC85WGJnQW91bGY5NXFW?=
 =?utf-8?B?UnJPZDdWVXFBeVlGUlAxUXZmaDNWaXE3dGhob2Z3enhFL0xyK200UUx3clNm?=
 =?utf-8?B?WlhaTGt1UG9rSTJqZDZ5VnluQ1ZqMXV0dFJMaURVYnQ3V1Z1c296bkgrMzRi?=
 =?utf-8?Q?yPrw=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(61400799027)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 10:40:50.8635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8dec7d3-eab1-4f73-9c15-08de1b8e9fb4
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR19MB7726
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA4NyBTYWx0ZWRfX/VUgOivhFFPT
 iFMbrf/AXek48QhFQ7+FYTlzxnIkR+LIMSxJOCX8bUs9WSOQmj3tqtcpGe0r6p41eq3NKhDH4rX
 ewIGq8pe/PhEVcImka/aVZVIZTYPaCjd3l5P45WrUBJmOr4jclGeUXXC4rd4mXwxocToz9UbFuC
 K+vOO8FxAN4wscbXN87opHWsWTWlhEgv42rW4Cu8X6fgOopa7kuV+of1+v+2ZcAdetuPj6ywPyM
 yZvVsB2EVWeMkXrl9tnL/cLP2Jvm6Y7YYRFeVrl3uvNJVfeDZCQV1G/OU+Juz7o7+cqdFtoP0en
 Cb7rAMmC5Oe5GO2zX+OfHfoq0+6s5hHGMUxyRw1Xpf3AEGy7XahG6wCd9K5RXyOA9Zk1ppg92us
 CshP/3VRZzib4Z9cPS2uD6cLGaiP4w==
X-Proofpoint-ORIG-GUID: oYIACjq7zYQUvY44q5UZYI8aNndGXkQb
X-Proofpoint-GUID: oYIACjq7zYQUvY44q5UZYI8aNndGXkQb
X-Authority-Analysis: v=2.4 cv=FpcIPmrq c=1 sm=1 tr=0 ts=6909d837 cx=c_pps
 a=INeTqmUF62tx7pR8qDg5kQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=w1d2syhTAAAA:8 a=4ivXKEXP3ZiagDnOexkA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Reason: safe

On 04/11/2025 12:42 am, Randy Dunlap wrote:
> Use correct kernel-doc format to avoid kernel-doc warnings in
> nclude/linux/firmware/cirrus/cs_dsp_test_utils.h:
> 
> - mark one struct member as private: since the comment says that it is
> private
> - add ending ':' to struct members where needed
>

Reviewed-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks for fixing this. Sorry about those mistakes.

Can you re-send this patch to include Mark Brown in the To:. He deals
with patches for cs_dsp, since there isn't any maintainer for the
driver/firmware tree.

