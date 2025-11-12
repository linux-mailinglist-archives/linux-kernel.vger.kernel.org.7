Return-Path: <linux-kernel+bounces-897631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 808B8C53533
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51F34F448C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E73446C5;
	Wed, 12 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="aOACQTp/"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E3733A036;
	Wed, 12 Nov 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962532; cv=fail; b=J35aeATEAX1yWMYRd4cKzwTgvGMtKJ22uJ4OD7UIso6Ox99fLz23kDBv97ChUgdvdmW7j9oIxBgOgAJIWJF8t/2qOVrwK9oMEnu5Cn2RH5BEyCIgTWI1l25t8il5b+4AqobRtz74AyhpLC8WuNzcvA+KYpFhPc44/aG407xRcm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962532; c=relaxed/simple;
	bh=WuNtphOEwJiOCYndu6XYTh/PYOoknwFt5tL7iQ45mhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lt3ZsvTp+Rb7W4lcvFCqX0PRT7SShymi+gmTXOGFEs+KLDRtcBuBzWYUVqN6AJZXPEPhgEQuG92dzECIp28WjWHgxjG06lT1nSevpw0kgv0g32minIwDusqAKJeLDQiAggtXGgoAk99eW8kteRmvwrw+1O5LdIQOizMoMbEcdm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=aOACQTp/; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFXjlu1591012;
	Wed, 12 Nov 2025 16:48:38 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa79peu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7HmP/BxPSzIOYPjCiZXMJmJpRs9+p3wkL6i5kTTOxAU4sWI3QqExRPtVMkkX4AALRSB3k5hAn4cL1qXbDlOMxU6bEFuGUv41nLPy/cnsYU49wkLS8F7TOn7RE+Wp7lAHojOKV0zCbsf+DKkOzT3C34IZpiMRilukRs6wqDnsI3URWx523fB8m8GllVpO6q31XDzrv7OichQ/OYUDh8jDtw7So8m5nNodcvxynYbwow7ni+iiDT8QhbRIStpJby3HimCGJeBbgtznsGbTxgytXTQcloCNOiQT2Y6o79ndcVlk4984g81yxeUz9UG3yzM/V9ZkGMEEpZ0IDF3claKSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EYEX4uK9tXm8vrjOWv6Rpuo5FLH9HsTIG4vs54S8OF8=;
 b=CoIOuoyXGQ3M5CBcOVg9EwbW0vILciCFNnaI8NK4BoPwOh+RxiV+Zcsm06U0Qsf7jJiu3KYstXfieXjVVf+ST4lO3IHEC0e7a52/r9n8rLdH0xeVxW0FMloQi3aqvY3ltUYwhAA/m4EePCohcrlyJ9Rwr6nKW4HMWq0Rv6YYTxg0lfsZJVIQ8uS72lNgel01XT4Rwu1WUwrMtNoMxRIk2Pc7/U8XE3uhC0BLm8xTsmJWnYI8ABQJ6xz5iq37vM+AgCPO8yExngdbeWEcg88QRGLe0aMTZyXD1LmOT2GpxrEUNLe5/NcalvG9Y018S17p35LzMNqzYu042FUTjCU3uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EYEX4uK9tXm8vrjOWv6Rpuo5FLH9HsTIG4vs54S8OF8=;
 b=aOACQTp/d5ml45dQe8tRlr2J8uHiBktk3Ft6SLUF4mdMfZ3AKcYli38nkyEba7AscPG1+qgWrkhj8L7GhlzoB9eFHPB4nolx5j1w1Xw/yrvhawirS5JyvSnBuKIKYAmgFtgUzcxE7TBLC9hXcvLetIbVAwn+EQ7KWHQiVhc09QDBOJ3Dh0DjYglj6xIMvGPUstGFVXH6GA7v74GeVz7jw34XR2+iu/OeyaPMChTUWOvIXi6gtzi5ZpkW/U0cTquGkbms/eXGeeO1vWtz1HPivKi+rXV07vYbPJt8RU+IMN5fHg9SagcI02p+EiPxa+zP6kgDTXk7+5k3ih0vLPufGg==
Received: from AM0PR02CA0151.eurprd02.prod.outlook.com (2603:10a6:20b:28d::18)
 by AS1PR10MB5673.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:479::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:48:33 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::c4) by AM0PR02CA0151.outlook.office365.com
 (2603:10a6:20b:28d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:33 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:39 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:17 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:09 +0100
Subject: [PATCH 06/15] ARM: dts: stm32: Add boot-led for stm32f769-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-6-50a3a9b339a8@foss.st.com>
References: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
In-Reply-To: <20251112-upstream_add_boot-led_for_stm32_boards-v1-0-50a3a9b339a8@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AS1PR10MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: cef15d52-f94a-4a40-9b1e-08de2202ef3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWRCbktKUDFUYUIvNGJjdXZPL0ZXUVkxUkN1elZJR1dWemFIZHh1SjQ3cGQr?=
 =?utf-8?B?Z2ZUUzlHWDc2cStRcktuT0ZnOVhPcUI4U3BkbERZS2k4Zk9ka1BNYTc0dGIw?=
 =?utf-8?B?NjJpVHVhZHBqMDhtWkhVVGdTZmRFemQ2dFd2SGxseEQ4eFc0dUkxVGEzNkFy?=
 =?utf-8?B?SzBNbTgzVGVUUUxubHdLdTE3bDFiTzlJVXdzWkg3djZIc05vek1WYXFMMnFN?=
 =?utf-8?B?YjhtdGdHM3ZOOG93T2kvck5TanZXRGFzejdaOEhPREJkYVJrb3RrMDNzQTVy?=
 =?utf-8?B?T004Q25mdktQYWZNT3RabTlQQXlDTm5FVDFkZmVEQkxIbG1XMjY1N1J1eDJC?=
 =?utf-8?B?M1lQV2J5ZTAwb25zRDF0Yy9HbjFEWXFGcEJENUdVNEZCVm5KTmhmeFBTUnRL?=
 =?utf-8?B?ZFd2aW1CNkdLN1g0TFJyWVNkTjVUek9ic1d5ck5jc0lGcjEwRm5IeElvMFhz?=
 =?utf-8?B?NUI4V09XL3dXcXRJSjdIZlNzUEEyMWM4YXZHdWZsRUhPRGJVc3l3RGcvWkZG?=
 =?utf-8?B?MnU2UlhrTjl6QlVmL2YxT2ZacG1pbmdjaGFvbXp4THZFYUpIb2IwTlp6MUZx?=
 =?utf-8?B?VWloVG95Z1lqNDJiUGJWTlR3cWNMbEZzclk4YU9PdXUxTG54T3NUVEQ1eE5w?=
 =?utf-8?B?QjdCVlg3aFhVU0VGaHprZ1QwZ3BqZnRCSTNYb3ZFWXFXYkM2WjlLZTdCcmdx?=
 =?utf-8?B?THVMbUFvYWJGaGowTVFiTFB3YW81Y2dVYTZhQzFyTWw0TGN6RkdMd1JaU1FX?=
 =?utf-8?B?cW9wOFdoam9mZXc3a1hqZDI4ekJLSDRNQWhpeDRWRmF5SVNiZ2ZpT3hRWDVy?=
 =?utf-8?B?bUdVd0FhQzhJMVo1bnoyY2FRelFkd28rR3k5SEYyaWxlWi9IdWIwdzNvQmV1?=
 =?utf-8?B?aWZ4dGUra0U5QW0wcWpNZWtTZVJMS0taOWlyeVpGNFYrUXBuVnR5TFpKZDVj?=
 =?utf-8?B?L3lHVW5TaWxlWkdGWFhYWEdUTWtqM21ickVvcUkvdTUrZTZKRXBENG5ZVHk4?=
 =?utf-8?B?SVBDZlo0VHo0QkcxUExGaDlaay85bCtpZWdvV0RpMFRzbXVXcjRHeXVKdzUy?=
 =?utf-8?B?eSsxUUtlK3N3ZkhpaXdTeXJhRDdJQmR4a2ViYnh4ck9QM3JvRnd5ZC9LUHFF?=
 =?utf-8?B?QnBRQXpTU2RVWkp6RVliUVpNbmhuVUxEdlVocTlrRkFES0QwSjJtbDUzZnUw?=
 =?utf-8?B?YTUyM0VpbUE5aGRvb2hDUlR4OG43Yng1QnJYWTN6dVZkSDBRSHYrNkJmaHZQ?=
 =?utf-8?B?WmlwWGhzSWpPczFrOE9XemtFbDFuTDFFUmpjL1lDSGdxdnlNZTJrK0pOTjJo?=
 =?utf-8?B?Y2JiUUZEK0k4WVNCNTMzYVF3SVRSNDlsdWlRTGFBRWg4am5xNHQxN2pxbTFV?=
 =?utf-8?B?OUpDdCtGb1RUaC9ndllaRHZ4SnI2bGxMVDZnL0c3b3o5MmVVaU1xSDRKdnBl?=
 =?utf-8?B?bXllajRBdkl6QXB1cnZBSTdaTndwVllSR1RSelRxMXJGcE1WVlFteGQ2NFRi?=
 =?utf-8?B?azc0TUwyNlR6dnhSeXJLQ3Q4QURWOXdISnIycXNyQXBEd3BzTGtGYUZodnZm?=
 =?utf-8?B?eVhRRlA2MHo0eDRqcFlPdXlpY0ZLemFDR0JzMW1KTFFMMnVSTldBRFNYaXlS?=
 =?utf-8?B?WFlhSVRWblRyc1lkWTZsazZYbWNuWHYxUlhBb0hnell0cVNIaXd6Sno5TWg4?=
 =?utf-8?B?a3pEMFh5WFU0cUtBWDF2STFKOFcra05tRVlSaXZLMERpM3U1UkNVeWF4YWFK?=
 =?utf-8?B?MWhWZG5rK2kwcVkwWEhlSUppVFhQeXlwcmpBR09TZ2JYOE13ZTJDUlBYcGZJ?=
 =?utf-8?B?NE95bitlWGJrMXJ3MndJNUhadzY5ZEVrbUI2ZXpERCs5TlcyMVh2Wk9SZ0d0?=
 =?utf-8?B?VXNoc2VuTy9nTGhSSWZXQnpyb0NDZlh6L0J2Lzg1R1BOampZUXpaM0tMTEo3?=
 =?utf-8?B?MXZlNy8ybVBhdWl2ZEY4NlQ0dFlOa3U3SHVEdEpwV205Tzdza1lYbElLaFY3?=
 =?utf-8?B?Z2cwVHRlU3NPQVR1VTQ0V0ZsQzJ0SjlyUGszUHBNOHBENTc4TS82b3Fhakh0?=
 =?utf-8?B?cVBaNWoxYnVnUXdBV3hkQzBjYkk3a04vOFMxa2FoeE5DS0h5UXkrQU5uYkk1?=
 =?utf-8?Q?kWi4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:33.1547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef15d52-f94a-4a40-9b1e-08de2202ef3f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5673
X-Proofpoint-GUID: Sc6dOsml-R_DVVXI2NE2JJE6A7Pm32ks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX/Qz/XfrEtiED
 l9Qm8a1Za5ydiRaScICLiLyIIcYt6SWIDYm3P7BgXs8GSD+A06kFjMrGnlttA1uKD4Iu2Ldc7+Z
 oOqGU76BjjnN2gx1ZsMuNHg6od/ie/gcGKIm8poRivn0YSE6vSvX2y5VGSdfKDh/MTikV7dGWhc
 3JWH5W+13GLEQwhl1XWLO7oD8PMxPiYU+YhveCEevU/SdgVIuQYncqUehGboFlxON6grRF4Rs9P
 21PnCh1J5L4yHYmghUHAY+C8OTgh5Xnyxl7OCm5ws8whtC+r9ZSFvTTh6AAVp205joWTTyHX1Xl
 VLvsSdR6uTaXhlrkyXlQwmfuwqRbGIADcPiWfYUrV+VNm40WZhNuCZHXaSiIc9A0H9fYEE0yKmd
 9ikkygeCd5hbvPc2aMCXhh7QC6F3rA==
X-Proofpoint-ORIG-GUID: Sc6dOsml-R_DVVXI2NE2JJE6A7Pm32ks
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6914ac56 cx=c_pps
 a=QwrbhXh03MhuZ2mRWfjA2w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=t1GZ2tUcJAtBDft1ZKIA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f769-disco.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 97c276f81f9a..e5854fa1071b 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -80,7 +80,7 @@ aliases {
 
 	leds {
 		compatible = "gpio-leds";
-		led-usr2 {
+		led_usr2: led-usr2 {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioj 5 GPIO_ACTIVE_HIGH>;
@@ -106,6 +106,13 @@ button-0 {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_usr2>;
+		};
+	};
+
 	usbotg_hs_phy: usb-phy {
 		#phy-cells = <0>;
 		compatible = "usb-nop-xceiv";

-- 
2.43.0


