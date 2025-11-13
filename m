Return-Path: <linux-kernel+bounces-899594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C539C5872B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99654A01EC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2BB346FA4;
	Thu, 13 Nov 2025 15:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dbDXSn3S"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D7345758;
	Thu, 13 Nov 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046871; cv=fail; b=UtAGyi2cPAf1ph4lhTesLQnd7L82pMI4H6ZYO5mdXqdMhK/XYuYHJd37oihal7AaUWH9Jn+6OPbKT8KFqCHsDTunAnJiPD/NF4cpcMcIMHngodr815GCUsxY3ic2hWpLJN4foiiOjlBTA1JxKU66M9GRcCix4NWQhl12uXeCVOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046871; c=relaxed/simple;
	bh=EgvZVuHzcM6xBUu4L57EAgmMitt1DOW3fWLYGgAdOs4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AfTmuMh9fpTYM/XPViyaCN8NtAZa75KSes0hjtvWczp/07RYlnD5cbsZg1U4kexXDIw8fGm4HmDdWeO3hwMXu9KYoCbGDbEdAw5uv6rivQX0xaFR9UYW+P9Y+CAzyLqY7WqSMRFUUnTQyDPEO5EAbJwdv9owc+32fPr54L4lhwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dbDXSn3S; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF8WcX259280;
	Thu, 13 Nov 2025 16:14:07 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011064.outbound.protection.outlook.com [52.101.70.64])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adc9s9g3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5dN46bi9XA0JVg8wuXWEcaI2qbRVhCtYqjIjDs6vbeJLun/qJ8qwjoCsch1iIv8z5Vs2MfQydatZU++cX+qwTcv3hRS4aa/kI8TFjKd3s6KXwNEav66i0ECtPDz34JDPA7fT7yEnKsR5R+Yl4yVFq2rMH7jAaUNV0+NxWucULTkz4+urbJljRhuXRykZcTWAIm9nA1VPK3NQCQGbelZQBjHT4KKIL2K2xWgnVdQVYmrEqQY8yeLrTIBD/WynC97ZOQdpEzhCmPzNBshBOAoO0o5Ebarm45WUP35p8zT3ah299qkFsrfmlc1QR4hIN3ViVslJAGG0g3df0P811g+IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvK4VTcvLHRHx2jGDqsoAZ/m/IROuL01EGBROV/skm0=;
 b=cXtEOvCw7WdgTtfzyTMu9tFe/Td6XxuQZoQOsm1YrU4rMPJwCkHJXxElUO3xWMeDLHBZYvrviN1ruecjKumZLHvcO97REkBzhJOtfdUUl3aL3M4WfTyoGBSqrW+PaN/RrpH46b6EFu+FNftyT6IDSnlNtm/r0sQBw7hYk1I8YogBzZSWvd845f81s2Jm1/DrB9iRvB3mGn/lewd3PxK956rxnLA9w+FEmBmdj0F0HpkeJmCJ6aXpa/EOO5d5NK1dOqsW4wSLBueaDEpYPgY4fZxICX02lO39QlnSHIUaUHw/BowIqjLBgQfC/WF7hh1j+9csjlJpwa+fYQ/uwKrc9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvK4VTcvLHRHx2jGDqsoAZ/m/IROuL01EGBROV/skm0=;
 b=dbDXSn3SdkPsgUkp04QHIt2B9lV3X5mkD8k//7K81gSCKLm8aGdb8VAf6nbS4ZYVdECimHbHjWTE0OOV2s/jFadkJMY4gKpSQe9vqNvcji2SLlqYn1hJio+Kp3CPMxdgJfNKidmATdmiAmOrLDPET4cqtRyadPQnRT6oOWJtqn1JTHVJSHOZ76ZoAavTy5a+RAbXF7EApCM9TvkQa7YE5y06pAsLByDppyeHi/5wbYAPa0RP7BwHEq2e3YeFcTWlGPD9004aEM4dTdQB5Uxa42Gar9sDB5Kdk2Qzmdc4k368M9Z7igCv3CtRVsD2Iiq07gA2qR0hIFKVxsQXlfMTZA==
Received: from DUZPR01CA0019.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::10) by DB5PR10MB7774.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4a0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:14:04 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::63) by DUZPR01CA0019.outlook.office365.com
 (2603:10a6:10:46b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:04 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:03 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:14:02 +0100
Subject: [PATCH v2 11/16] ARM: dts: stm32: Add red LED for stm32mp135f-dk
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-11-45090db9e2e5@foss.st.com>
References: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
In-Reply-To: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|DB5PR10MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ebb67e-2d57-441a-916e-08de22c748a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RThhUTBkckZUTm1iTGZldnJDeitUWkp0RlQ0Q25UZXUxN1M5VnJJOHVGQTFk?=
 =?utf-8?B?Z0p5UENJNFovUEE5eGl6aEpUVWJ2eHhmL2drbVZVRU9QZkFHYzc1Z0hkOG5u?=
 =?utf-8?B?bW54MnVtWDBtRGJEWVNaU1F0Ly9jb3lXd1lNY1VGOHdFaVlyT3o1R0VCOW5L?=
 =?utf-8?B?QlNWeWRPRTljV3VYRGhOaGV2YzBtTUJlVVVCeHhNMU9YSTQzaFg1L0RZT1Vq?=
 =?utf-8?B?MTlGUVI1REhlR04yM3hrNzY3aE5Dbm1aeGZlaWlzLzVtcUplWnJHMVhWMFRW?=
 =?utf-8?B?WEpDelZ1ZFcrWnB3NXRCUzkxbHY4MFV6c25ubWxzc3l1VFU5WkdiR3ZRZ09x?=
 =?utf-8?B?amF4WldBSXBweWVyUmw4SVMzb0llQW9MSUVmZXBud3drcGc2OU1iU0tmV3F6?=
 =?utf-8?B?TTJId0lBNFVnNzEyMjc0amdmakZHSG5FOUVMczA3cnNnc2FaV1diV2gzY28x?=
 =?utf-8?B?WnlXRDYrUHNFRXliaDdMZzJwdEs5OUFrRUQ4RWx5NG56VWk1SWtoVHAyK0dT?=
 =?utf-8?B?cnhPc1FvQmxRR1NKMTNRcnJFd0ZxRThFb3FaZ0tqNjRYZUFFbFErTVhTSk1C?=
 =?utf-8?B?VHFSVCtud1Nqd3NsTnZoSGswWnlzYjZucEdqOU9KUktuWlczRytWY2RIc0Ny?=
 =?utf-8?B?UEhxb3VyVFZBQVBRZmFNMzZlRU9ZaDQ5ejRHYXhHQ3RsVXlRb2l2TmJNWnNt?=
 =?utf-8?B?ZnpZVWdRbHc1TzBiMWJ5azhvQUd0Mm1GRjBOelRCUlZwYlNJOGpSWXR4b2Zq?=
 =?utf-8?B?OXRWRjFLaDFldlNzMnVnSjlVU1BtY1lndGFJLzFPNDRCcmpMV1lUVjgzNkg1?=
 =?utf-8?B?UjUyNEYyaHNvYmFJSGxKaFAzc0JLNVVnZEVOWjA4NFFVYmV4V0U3cnMzMXNB?=
 =?utf-8?B?Qkc4Y1dNWHYyVVBrOURneFRxUVJnZEc4em5URmdHYTJUeVo3S3Y0Y1VWVVRy?=
 =?utf-8?B?MVZCUFFUa3gzQThmUnJmc1k0dXJZNEJ0MzRHYkpBR3VOWnQ3dEplVS8yTHhG?=
 =?utf-8?B?d0hpN1UvaFhWWldIbyttSFlJSzlhR2hZYkF3eUI3WmsxdVRSMWlJeGRHdk04?=
 =?utf-8?B?YTZrRW1SRWxIdXFLbWRNTUxnS0pDdTBuSXRBT1h1aTlySWh5VStGZjFTTElS?=
 =?utf-8?B?Z0s5cUNMcERTbEYxUHBBWm94SldnWTRUQVZQeENIaWNOT0JxaExpM2Z2ZEd2?=
 =?utf-8?B?ZHRlVi9EMzIyQjFXNXhmSUdvamJEUEFaNEExK0QxZk1sUVhKNlM4R1BFeThv?=
 =?utf-8?B?TnFlR3VkVHFBUkY2Z2dYSDNFSnp3LzNvWjBsL3dNS0gxWHYvRXIvVFoveVhW?=
 =?utf-8?B?MElacnpIOGFKenJ5TFlVaWVWdUdFd0VrZ0Q4OGZrUHQ2d1hLMk1CVFZIaVJR?=
 =?utf-8?B?VVNBd3NCa1J4TzdEdTdhUUJXdVpJbUo2bzBkS2dJNHBMVlU4a0FyOWZ0ZFc3?=
 =?utf-8?B?Ym5iVDNwV2NGM0VpZW94ZGNsTjRDNVM3ZnQ1Z3F2ZVZQaTNWeWNmUlpYekFV?=
 =?utf-8?B?Y2JkVWtvQjFybVMrV1JqOFJoTS8ydHRYUlZpWll5VElKRVZiVmlVS3NIQlBB?=
 =?utf-8?B?bnNFSWdCWVdtcnU3aGNFVVFld1ZBZTljSGJRSVh5My85d2FITDJHekxxZG9x?=
 =?utf-8?B?QWtVUTQ2cGRNbEtsdGpybTFNbVMydTdITU1jTXRsYkd4TytlWDljaHUyYXZt?=
 =?utf-8?B?dVp5TTFkRXQ4RG5Gank3ak9zejV5Y1NIalh4UmxPcjFZZ1ZIUHVkaFdSVHpV?=
 =?utf-8?B?UWdMRStXQ2U1SytOVmJVaGlMMU1TVWVhckN5WVZ6dlRTdk42ODJrd2dHWkJu?=
 =?utf-8?B?WFB2YUcyRDdxOFdKOUFlejdWY2xUYm05UE5UYTJBN3BhZHdIVm44NHVFdkR1?=
 =?utf-8?B?QkZlRlpZRWNlYnBWOGZYVG5jOWxGTEVNNEh5d240emp0eUtQU1pmOTJuUmt4?=
 =?utf-8?B?QWMvM21vc1lZTGs1Vkt4RWpiQlFicXRuaWo3MlBBWXlHVTJBdFo3OHBTbzJQ?=
 =?utf-8?B?WXFpR2VWTGhhcVRSVHlnMWFKT2lhZ3FaTVVHT0o0djNhTXdFTmN2TWlVdHIx?=
 =?utf-8?B?QkJkLy9vdkJCU0JmaGs2SStna0w4WDN1dmhXdDRTY2tNZE0vWnRCT0l5bUZH?=
 =?utf-8?Q?0/z8=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:04.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ebb67e-2d57-441a-916e-08de22c748a4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7774
X-Proofpoint-GUID: 7Rf9zuJ-4T_B9yOA6tGYV2yW0-ooFCBS
X-Authority-Analysis: v=2.4 cv=M/FA6iws c=1 sm=1 tr=0 ts=6915f5bf cx=c_pps
 a=cOLobNEpc0FqjrPV1EZGJQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=bCBYE7X1YGK-GcsMjE0A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfXwemXsLI8O2jH
 Yam8RAkK31tddinkois88nxEVQk/5S2ALsLTs7HsWFOYjx0o5DV5qIBHedwS1Gu1ZS9qxXnNI3Z
 +zTUDjlWyT7/HGVZ+LCuumdLnL4Llzcmgik9Iu1Ge2rBjtnLkckLh6caz+Myn1HqgXlua8jUdWm
 Zfv4RM+uNqG78yyDvTs3p4i6hwq6xzdlgZN6JdCFxJkiGpZEwYqBPtohU7+CqcTJsiKHy7+DNyn
 l6AyC6d9SrhRY1g/NP4LKjUf20OWpfXVIhWJ1Fjlpm9kc3m6o6OtlQJtBSUXVV4SFFW/k6T/cR7
 NRCIunI8LK00wAltV11KzlPcLUcKen1cyY44iEqznkExXCuvFQ409G86A0xxQXcl6OZn8aYMGWn
 p5AB7OiYaFnHUm5/Anh+wyququ789A==
X-Proofpoint-ORIG-GUID: 7Rf9zuJ-4T_B9yOA6tGYV2yW0-ooFCBS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add LED red node for stm32mp135f-dk.
This LED is used as status lLED in U-Boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 9764a6bfa5b4..909372da711b 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -80,6 +80,12 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
+
+		led-red {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	panel_backlight: panel-backlight {

-- 
2.43.0


