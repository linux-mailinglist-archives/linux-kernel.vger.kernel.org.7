Return-Path: <linux-kernel+bounces-892599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D838BC456BA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:47:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 51EEC347108
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A782FD67A;
	Mon, 10 Nov 2025 08:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BDtCGnSP"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D942E974D;
	Mon, 10 Nov 2025 08:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764427; cv=fail; b=a+HLpbEYIHdPF6FZw5KfJ2L+Hc8CCxVvafHki0BQ6ts46Gn6uQo1bGOwSawKwaOopapbDR5eDp0ZCIsJgCg+ExrzKtBsqATDVkwSbmLnebIV9+01qYzG0BkOo0aB3F2tWyxW2pBMtIFxwG8thOh3CloYQhVEFmoXupD1gYWBKLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764427; c=relaxed/simple;
	bh=w22G7h2xzLA/FfwSvCys5p3ktaEkHOjxnVqFRjdigPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Oi67AkK+gYk3LrigS7pMyVxYXvqFUD+7F3mH8T4+Wbp2A7f5SI+TiXxxtYuA8DKyiFCvliP+PHB+g5vAYNo+uLkVpCuRgAKz0CD4184bw0ySxL2X506l/RdPUfaVGMiPYidh24OY7HPlF3oRaJOIHuu4cgjYLUBgnF0canCoHOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BDtCGnSP; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AA8gHNp2321066;
	Mon, 10 Nov 2025 09:46:40 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010040.outbound.protection.outlook.com [52.101.84.40])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a9xv65rs6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 09:46:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4DGpGk75nzJXSDOphGjKXR73MHc0FckstkCQ7dhkvb3E3LC3gu/C8OtNlXUv2ZLVPCpKJxfuxKLJR7dCrY5gLMLAuQdpui+EGfjB7LPKDITaUb3ge3rRTtVgBxaJzf7x7x+iwnOBBU075Cm0OBWVuBh5vqIQbwBXQG+TQFx7CXnfPeSS/9bhHiSrJPVJPUx8ge/rKQh7nMEM+MJZHEkQcffU3WxKdcDQyEh46YJDQNFwJE0ia5s2divFeTGfWFkJ6CHcVdt6k/MxDU8QwGg1miMAIU6y5KoY0HthGZLVIbIf/4+S4EPjTY0ft6Ns5+T+lecuYK6PkbQETZBELsvZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59QjWHfgIxZm5zFNOoyFKRIRlaldWiYYqYPanGxjZRA=;
 b=kt/nMLyXJ0jp1aBPUVASWfZAvPmzo2K6ZBbQlv2hbVxn4lwj9I+Qz1jQsFUEhYlX7tU6lChEUijA8Q+DWraiztnqwe4fSr3URbphlJ685XO4A5rrz5pZy/KxxmmX1bhtyzj9TM6xV5O+V0rMd+eeFR/2unlwSRoAAbX6olLcG/ezThXwmeq9lJuI2WBJj5RApJTBZjRyOqH0c6Pz4d6fEf9msqNUqzZIivvflcQptfQ5YFk7oNCl5raFBPfzckz+NLUFuJ9V1qkJH07LGg4WE7A6iJc+b54qAPNuxalJuzCNBcPG3y8BHqiuwUIF9UwjcBFV0ttRnMggJQ2OeaCMjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59QjWHfgIxZm5zFNOoyFKRIRlaldWiYYqYPanGxjZRA=;
 b=BDtCGnSPfdpD0eI4kp/yX8WLTpUgKY8REQxOn8WasBm00rnMey62NOjNzokM+BSD/UJ7YxoxbD+AIC+l4TckMl71XczFKhkKX8z+4RoWPchDoozCU+NyDpFHBj8ml7dtEl0I+6F9p9LpqOHybbCkNSLbVdweo6DejJZyzeRjJFRj1CQeng9J4whNbAuX0twcEAYiEtebLdPQdLk+/h6yfJCVXpk6CDnlV17xh6Yc2ibWWqClD423JlM1KwMp4V9/mMqpgkGbqdh57VmXnnAr7A1Jyv4o7wNrOfFgalCc2Lq+N1hsp7I6ZLNay7Xpml7kZMih/Wp464xI3K5XxWpt8w==
Received: from DU2P250CA0026.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::31)
 by DUZPR10MB8192.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 08:46:35 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::7c) by DU2P250CA0026.outlook.office365.com
 (2603:10a6:10:231::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 08:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 08:46:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 09:46:41 +0100
Received: from [10.48.86.79] (10.48.86.79) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 10 Nov
 2025 09:46:33 +0100
Message-ID: <2f987d78-6494-45d7-86cf-466785e2124f@foss.st.com>
Date: Mon, 10 Nov 2025 09:46:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: stm32mp157c-phycore: Fix STMPE811
 touchscreen node properties
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, <mcoquelin.stm32@gmail.com>
CC: <robh@kernel.org>, <s.trumtrar@pengutronix.de>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20250915224611.169980-1-jihed.chaibi.dev@gmail.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250915224611.169980-1-jihed.chaibi.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|DUZPR10MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 05894918-f43d-4892-ba50-08de2035a7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHoxalJRM1pwRm1QaEUza0RMOXlPSE51N2J1OGw5eW52SVFjVGFYSW45dGRj?=
 =?utf-8?B?bFFHVTF4RXRiV1NEZ1J2WnFJU2NYUDgxc3B1TnliUHQ3NUNtZ015c2UxSUZh?=
 =?utf-8?B?NUtHSVB5NHRMeW5vdFVwMEJmUnYvdTRIcjRManphNWtyWmhub0N6MFdud2Vu?=
 =?utf-8?B?ZURrQXdNOFRnUmdBWGhHclpLd3VLV1JlU2tzNEh5Y1VFeldRTHkyMVZ3UHRT?=
 =?utf-8?B?OEZHbmNEdjcyc3lEdWlMdGF0bTZLdXlxdmRPblhYZnF6SkZmdmt4a1dqZmQ5?=
 =?utf-8?B?bE84ZXBIcHlnTVdCY1VlS2plbWRuRVpqc1o0OU82a0ZTb3E0K3lQK0M0QTRE?=
 =?utf-8?B?L1dtcDBsU0Y5SWJzNS9wSVlyVnFVWmcrTWE4dFFTVC83RHorcUVyVXpHNktP?=
 =?utf-8?B?bDA5RHV1ZjMxZE84TlVSZWt2aElRZW5SbXNuMDRVME9Zem5jMzIxenJhNmlF?=
 =?utf-8?B?S1ZDRk5JTmdaV3VHSmVtMlc1RVlyYXhtYlg3K1AyR2xna2p2QzU2aFhVK0ky?=
 =?utf-8?B?OU1XMVFjVVNDSWdwQ3Jya25hRGNOaEtYRkU4TmkxbEFiMEMxRUZzdmd3QzZq?=
 =?utf-8?B?ekpFeDZsYncvd1EwbDN0dkFJaGEySklIeE96cjZiWnJiMnF6dVBpRVd2STR6?=
 =?utf-8?B?RkpNdUJlc0REaTVNMkp2SjJhVWF3dEZEbW5EcWdxdDdpMjMrcEVGQSttdFh5?=
 =?utf-8?B?Mm8xOFMxWnEzSWd6UVdrREp2MGpMRkVDREZpbkZLUDFaUHcyenhMd2NJVjU5?=
 =?utf-8?B?Sno1TE5BbTZZQWxqeWdCV292K0t4REtpUm5SMHNPV1VQM1YxYzBJY0JmSmJE?=
 =?utf-8?B?WHlJVHFmbXFGZlRJeWNIK2RyUDJyVmtGaGVkek80UXFqR3M4b2hld2dsS2xx?=
 =?utf-8?B?VlNqRUhzNDVLTG1kVTBHREd2UktSbllGVGFuem5oSmV1Smdvek40OUhTMkJP?=
 =?utf-8?B?OEhqSElKNWVhTjZWeDhzQk4waVE4VEMvU0ZrR1JldlErYUQ4bWRHSkQ1cG4r?=
 =?utf-8?B?dVpXeUFaU054OWxKZEsrdm12VlhDTXVCK1dtcGpRMzZDTUlUWnJkdVVMMERx?=
 =?utf-8?B?NlY4ZElaQ0FReStFY2x1SG1XQmhCcE05T25ybVpWUmtwYTYvb09oV1MrOXRj?=
 =?utf-8?B?TkFueUhHU2FVQTNjN2Vjd1BvalNnWlZpSlZCdDJncWhTQ3l1TjhJMldVMldq?=
 =?utf-8?B?dy9jNkw2VmpmdkJscC9oUTl2ZDNRamtwZ3J5L0VKcUd4OEtLcVVMMWwrTlp6?=
 =?utf-8?B?T2hCZ3hlVy9PNmFoV2ZyQWduZlBQbUdVTmJMdkJTNzR4ekVKNENXZWtxNG0v?=
 =?utf-8?B?UDZXVzl4QlhIRHIwZmZFV0RrYktzdmVja0lKbDZuQTZVQUVjNE91U1NUUDNR?=
 =?utf-8?B?WWhVTkt3VDZzMUNkdndEK1QxYkkycDhWTkhpV1U5V204bUt3YkczOUZaNU1h?=
 =?utf-8?B?a3Zad3ErVTVuSGRZQkxnUksvL0tFNDNTWnBRc3dtWTZuS3puZEhtNU1PbFZS?=
 =?utf-8?B?ci9RWUNFNzh5V0tXVVJReXkwMkJJN0Y3K25oK3B5NTdYRnpwYW1QK3U4UEh6?=
 =?utf-8?B?eTgvMjdjNTRjRG51U3RJQkdDM3lET085VzRIMzJERGgzYkNoOFFRcHg1blpi?=
 =?utf-8?B?V2pqbGYzdmMvcFJnSlRwWFY0c0NzSjRpUWxLMU1yRU5CMVoyK1psT2ZNVXZQ?=
 =?utf-8?B?Zm1SWkwzbEdnZzFiN3NtZndneDJrbDN4NHU3RjdFeTVoL25OQzN1MGo5T2c5?=
 =?utf-8?B?N0lYZS80TW40dURXdVRDZXZUZXNHZitKRXNVOU5PYVR6VXhrN3hTTGxYakVB?=
 =?utf-8?B?anFic05yWHQwOXc5S3Z5ekJoeG5scWlwa2p5enRCd05kbjZPbVM5anRiUHgv?=
 =?utf-8?B?YzVOSGtaRWt0Z0xySitwUU1Yc0pEVm5wejhnUk5UYjY5QS96MDdjYmtJSEZh?=
 =?utf-8?B?SlZya1lvUEpkZmFUaE5Dc0pYLzl6dnVTV2xqQVpXTGV3dmtuOEU5bkhidjhq?=
 =?utf-8?B?U3R3YlhLeGdtNi9xVCtZSnF6Ykt3V2NSMW53TnBDRkcySU4rc1VZaW9TM1M2?=
 =?utf-8?B?MzFpV0FCMGlGM0pkd0xCVzZkVDJqTGVjZ2FsSjRscmhSU0UyaHdLNEdGbDlD?=
 =?utf-8?Q?hzHA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 08:46:35.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05894918-f43d-4892-ba50-08de2035a7ae
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8192
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDA3NiBTYWx0ZWRfX2b37+MJr4+N2
 NYs+0/+iMB8F/fOnJ1EiCl/4bOL7aQSGUd7d9h9jXw5OuDkVDAM+ihT1OOUtLzhI+FYtU6qtsuL
 8aGibSQZ2MMCgw14SCrIozvARh3E/YFNrd6rt6tciUi1ck0G4+513YjqiBfCnU7GY1mHHkFzz3B
 RGSrwS7O4EB+Qk1yn1JIzfDqxjL5xVgnoTuUMkUjhpS/Jq31NL+8cgs/ioYtEVJ/CYygoyqz4nd
 /R0+tS2vLy0305N8a52tIrw149POW6Eeny8rxxe1IQj5bXQnJPfBYjle+W7iipMpAPav6BRZLEo
 BTQZrj/ysG7RhRgxTmPKogVROztSMwPfRZ7EP4b6b2lVEqY000TTWK9u0PjWGWwtjhBFGA9AyBy
 XygbVjvJNWAz6iYZ24qxcUbS8eSpdQ==
X-Authority-Analysis: v=2.4 cv=OuZCCi/t c=1 sm=1 tr=0 ts=6911a670 cx=c_pps
 a=2DzPM8fQPN4EfAmge14Bmw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=PYVhz2m5A5KxUzFyFHcA:9
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: vEtP1TnqV2Pu2tE4nc8N017w4zZqnGR2
X-Proofpoint-ORIG-GUID: vEtP1TnqV2Pu2tE4nc8N017w4zZqnGR2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1011 phishscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100076

Hi Jihed

On 9/16/25 00:46, Jihed Chaibi wrote:
> Move st,adc-freq, st,mod-12b, st,ref-sel, and st,sample-time properties
> from the touchscreen subnode to the parent touch@44 node. These properties
> are defined in the st,stmpe.yaml schema for the parent node, not the
> touchscreen subnode, resolving the validation error about unevaluated
> properties.
> 
> Fixes: 27538a18a4fcc ("ARM: dts: stm32: add STM32MP1-based Phytec SoM")
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
> ---
>   .../boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi    | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
> index bf0c32027ba..370b2afbf15 100644
> --- a/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp157c-phycore-stm32mp15-som.dtsi
> @@ -185,13 +185,13 @@ touch@44 {
>   		interrupt-parent = <&gpioi>;
>   		vio-supply = <&v3v3>;
>   		vcc-supply = <&v3v3>;
> +		st,sample-time = <4>;
> +		st,mod-12b = <1>;
> +		st,ref-sel = <0>;
> +		st,adc-freq = <1>;
>   
>   		touchscreen {
>   			compatible = "st,stmpe-ts";
> -			st,sample-time = <4>;
> -			st,mod-12b = <1>;
> -			st,ref-sel = <0>;
> -			st,adc-freq = <1>;
>   			st,ave-ctrl = <1>;
>   			st,touch-det-delay = <2>;
>   			st,settling = <2>;

Applied on stm32-next.

Thanks
Alex

