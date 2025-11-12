Return-Path: <linux-kernel+bounces-897045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F38C51E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 906294FDC0B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8F030C342;
	Wed, 12 Nov 2025 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PdE5p2GW"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D702FE06F;
	Wed, 12 Nov 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945578; cv=fail; b=V5NBYTLfagxHxq7ZSKllezECmUUksQ1OlsRQs0MKPwGR9kcvajEZangUHfhGmyJBxoF8NLLbuQb/RQ7W0loctlxcJES27NRMq6Qy4h/w1L4TKp5qhYw4enLt2HSyUA/mCViMvcg/VzAeC+bz1q2vezV7OfijOgZ6CasdXHoEljs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945578; c=relaxed/simple;
	bh=SPyTouDGCC91+XOEDTxMlZFfmZXDEg8sPf2qZbL5oWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pvoQRuTYC5zviDQBfo9BAWUysAiHIe3VnvZJcOnWhnxMtVJMIILDazFz/BmGKuwy8bAG29/Z94cZyp5culXHEo3TlJsMd1EZNi4x+XGmc92V9KB0pkio0pgLrJ2nVMDm3KpOSZVFNaWzRZgi3RW8XO1bLyhgKALOn7tqrSujEq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PdE5p2GW; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACALQQx1331463;
	Wed, 12 Nov 2025 11:47:10 +0100
Received: from osppr02cu001.outbound.protection.outlook.com (mail-norwayeastazon11013043.outbound.protection.outlook.com [40.107.159.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0gmcd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QdJV6s0EI4Djx8lUXP8TcqSypVrtGoqXjh6wi9fMIJzlgC0b5yL4NlGVR5zI/eNlAA/o7ai/SjRAdivsWyDWiHQtO5mvpfqXOeW3/bkv2T8lj6zIi5PTdEv8xvdEM7M1+FShg32LAbMa1ug3asHNDlsehbfgtyn4ACe/Fh8YfA1T2doqzalsTUtkB0yDIHb9UqgCF0lhIDCaXaCKe+7Yq30G3CblaESNOQllxbjUS0kyRKxXpbPOIYTvIjGR6mhBuvVjmhc2RDX/8fXM8qHSxPaOs1fgwP8QqV5L8k3hHLiJUcUPcjZyCCPHbxbEcuK7iX7zgdF1FvpCyWiYJThNww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdgesra8sUsh2QVglCjzufnpeFIapWv6f1CrS9FLne4=;
 b=JurwPKz7XMpNdYX8Ma8Rba31wKRjClKPdqQFCMOCtHJPkZRG2XQkSSkJOfJsZcGh/5gJOZ9nRY7Cqnax4n77Bjkx2+sa8gGYZUGVXEpUqWXL7SI7Vd4k8k6/MiZ0kgG34vi9cHt5tOwXrdabdNfRXmKzohPmFBdYyaeECKms8NhyPWoA2UYh1fR8XiF7qrFBE7GgjJY/m2KI381jq9RoZr7MMt0WZZWySBTZA8r6pYMZipOtRwjuwPp4BzGv8aEB/VZKtEhQCzox/cJi5D5RR9jukSQsoUg9VbxkO947+nE+RP1hWvPJ0+l16N15esfU+tJKYVWpnYq21CH8Dm8LeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdgesra8sUsh2QVglCjzufnpeFIapWv6f1CrS9FLne4=;
 b=PdE5p2GWtyfeXe60NSXP6wgPdXxvqhtckDikGnXYRxR5FLH0NofMOrX4XO7ia3KiWHiZDLr1DkFcerX00x8IDJp8Q/5wYAsU0zKPgs/CXfq/RADfeijWhpETho2+hC0yCH4M9Gc5rBPNq5qX72xyoVUKHTsDGICMn5PQ1sS3g0MFzl6H5HE32R0BCr/UIy9UntNSFKGFwnPkXZCElbvdYiM2ritpD/AeaqI4958UPBYXQkrX9XcomSwlKGIO4N0P5M9eVTf3BrAWRsXW1sU9MlKGtqsEp3iQZCGxpmk0psQLSnh99/pNa327tm8lWBNK6qoknMEqMWbS8h9gcBIy1Q==
Received: from CWLP265CA0505.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::14)
 by PA1PR10MB9035.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:449::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:47:07 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::20) by CWLP265CA0505.outlook.office365.com
 (2603:10a6:400:18b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:46:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:07 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:15 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 11:46:44 +0100
Subject: [PATCH 2/6] ARM: dts: stm32: Add boot phase tags for
 STMicroelectronics f7 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_uboot_properties-v1-2-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|PA1PR10MB9035:EE_
X-MS-Office365-Filtering-Correlation-Id: 9befabfd-f8ee-43c5-012a-08de21d8d341
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEZKcDJRejJMY1BLVFF4Z0xuem5GSGVxQmV2TjRzL1lHbFo0ZGEyaGQwaVhN?=
 =?utf-8?B?MG05dmxWckhuSGY3c0VydHVLcmxqQUR0cGtDeHRaM2g5ZjdFa254SEpWblZZ?=
 =?utf-8?B?Umx2N0o5TDlyQ0FmaTVLaCtZcTZuK2lRdUFYdmpzc3l1bW1pb0psQmQrRTNj?=
 =?utf-8?B?d2FLK1JaZ1ZHaGxCMFMrZW9kRnlKaGlhVmcvb0FKUWs1QlE0VzZRTktKZ2Jh?=
 =?utf-8?B?NUk4cFJQNTUyMVpUWVU1REJRd0NON2xZL00zL2hweEhRSG5xVXQ4MTZETWZy?=
 =?utf-8?B?b1JGRkJGdXk5UFNPTXNxbStSSmxJTXA4ZFhnejdTRHZFdXUwYnVock1tRUZn?=
 =?utf-8?B?ekh1eVhIclkxcXJWYWFENGM4dVo4eXh0RnlyWmNYeWxGR1VtaEhFSk5jL2Jq?=
 =?utf-8?B?YjBYaXFVMFdXWUZucHk1bllxSWllL1V3M25MZGpjR2kvWExLUDJvWGZ2dXV1?=
 =?utf-8?B?N3VYMnRpcmYzUHZiS3pwSWlEbjl6V3d0cjhVeFJrNlNLVDAzcU9CQVlRbU1N?=
 =?utf-8?B?a2lXSDdIOUh5TUtXb3kyNkMwSHV1L0ptN1I4UFE0QlF4NkFnb0k1ZytTUTB4?=
 =?utf-8?B?dDFCY1dQNisyRXA3ckpjRHBNenpDZ0RQd0RHbXlnWGZBSWkzTkV1aHUxU0xy?=
 =?utf-8?B?UUNmS2JhNUFkcEFXbEh3ODZPYzRqYU9oYUJ4eVFtUm15TDR5RDUwaU1LT3B3?=
 =?utf-8?B?enZ4bVRvakl1Z0VkYzdtaUxtR05sakh1QkxJVDhlTFY5djZwMjlQcTBLOFcz?=
 =?utf-8?B?dFJuR3ZUdlcza3Y0ZDJOQ3lwcUtGR1R2Ri9oeDdNZUJTYzluVkRUTnhNOTI5?=
 =?utf-8?B?UHRvTzJOelJJMHgwTUpkdndWNkI1OThzNHN4bHJVUHhTZkFMWCtSMmxoaytx?=
 =?utf-8?B?L2ZEd3ZzTXlOMkxuR25nTkM5OUkvaXYyV1NSalVJaUJvN3VVYld5WWxlK3JL?=
 =?utf-8?B?QlNJNzdxdWUxanRBN2N3SzB5YzVFaTh0V1VtODlLRzgyS2JYRXVzL1ZPaDVn?=
 =?utf-8?B?NVgwdUc3S0tBT0liSEZkZm9OWHF3aFp2QjlnM001bDZydlh6aGpNSS9hRGRy?=
 =?utf-8?B?aSthdjRvbXRJTTY0TFR6L1lFenlVK0t5K3ZvODZ3ektqSTVzLzkwTHF2TXZQ?=
 =?utf-8?B?dEFNS0lkQlRRenpRbXFFd25SR1prRDBWRnE2cTdrK3pFei95TGJra1ExdEh5?=
 =?utf-8?B?RWtMcHUxcms3a1M1UXMyYTkvTDBQektZTkVtdFU0YzdyQTV4dktkUy9rNmx5?=
 =?utf-8?B?QlJrVGs4RmFQQWJQYWdjd1oxdFp3WEgvbWNnNFlKS1htQ1FsanJVdGlFbjYx?=
 =?utf-8?B?L1hzSElDbzNCOHJuNVkvYW50UC8yeVBqdnBkVlNnWFR2eTQ1UnFWZFdITVZl?=
 =?utf-8?B?Y1hWalhoSnVUckFnaTZDNmhHbWVydzhXVityWVFkODZUVnpiYVJHNDhFQTcv?=
 =?utf-8?B?T0lKbkU5dTR0WllpY0xlRGFuLzZ1SHJYYmQvOXNpZCtpaUFqZVB3TkdFSXRM?=
 =?utf-8?B?bDJyZkllZWVLOFk0VmZmYThMS3RVWVJXcmZkeElab0NqaW85cjQrWHZkVGNB?=
 =?utf-8?B?MFc5eE02K1V0MExJWG93Mkp6cFlwUWNQMWJZL3Q0N0FQaUVMbkxCTytuL2Y5?=
 =?utf-8?B?MWpvTlF0VGtSeFlYQnA2UFBBTGhnQVNXN1J5YlhibEJuTkt3d3RZTDNIc0RZ?=
 =?utf-8?B?QVBsb3ltY01mSW9haW45dTNzZENoaFlaVWhPRDYvdHlIV1dMNWtQcU9qeXBE?=
 =?utf-8?B?R25qUHdxVDBUWGpKMlJjL0pTZHhZZENOUUI3ZUFYVkxEWms3MzVFaWdIMFlK?=
 =?utf-8?B?TGlYdnU3WmlRR2dvbERES01ZSGs3Mm9XSFZPN3FRMTVNOEJOTFk3dEM4a0ZJ?=
 =?utf-8?B?RjBGMi9JdmRWRDM4RXdBa1dWZjNGTC9lWURIWGlEaTVMWXNzYzFrR29PcTNB?=
 =?utf-8?B?V1hrWlRjRldYa3N4TUlzc3lDbThBL3R3T25Rbi9wNytod0RyTzBkMTlKSUNp?=
 =?utf-8?B?dzROS3Z1NVFsdTJnbzRzN1NnSjVFUTV3dWY3VkF2bFowRldPQzNXKys5Wmd3?=
 =?utf-8?B?YWtoZWdlVVNDUDlsS09sY05HNnl5YmFXM01GRmhBbGc5OFJGbEdhRWt0TkJp?=
 =?utf-8?Q?HeQw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:07.3196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9befabfd-f8ee-43c5-012a-08de21d8d341
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9035
X-Proofpoint-GUID: gtf4iG0_ktEElvSfopwbgsZba1dyd9a9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfXxPH3Tjkdb32v
 ER1uEV3UEzkFkIzYrjznpfHAVbq7RFsfWF+i63COHeJYWqoTBcZJc3YMDFekqAh04Qc2hbpm4FN
 Csu+U5yjOc8TcGrJD2AlghgnL8gHq+u77AX24RIOjPcvNf05OfM7IbGnkBxrWIJyTrS98LYDwBh
 8a10bqY1/QdK480T4kM4CBIxFhM7rCaqVxpV/Zb1ETWSmczVPHTlelIif0vp29Ha6bmRQ5DujKR
 687nb/YLwDWohfNG7paYO0Y0DvbMoBNuSynBurRwPTtWWDFkQgL+cgz3H0OR7nxMUTy0Vhb5PVl
 VRGYX8+MqSEBIj1f+C8daqePXyAuP0AN49B6pVt+PgrpglzsNyxIBBMLyEr/gyJKA53hesjne1+
 PInLkOw86BdOej155jikXr/nXfjcXQ==
X-Proofpoint-ORIG-GUID: gtf4iG0_ktEElvSfopwbgsZba1dyd9a9
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=691465ae cx=c_pps
 a=pNXGupngiSMufF7CtLwx6w==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=fTQ55MeeFdhIrGqxLO4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32746g-eval.dts   | 10 ++++++++++
 arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi | 11 +++++++++++
 arch/arm/boot/dts/st/stm32f746-disco.dts  | 12 ++++++++++++
 arch/arm/boot/dts/st/stm32f746.dtsi       |  5 +++++
 arch/arm/boot/dts/st/stm32f769-disco.dts  | 12 ++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
index e9ac37b6eca0..26c5796a81fb 100644
--- a/arch/arm/boot/dts/st/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/st/stm32746g-eval.dts
@@ -213,6 +213,16 @@ &usart1 {
 	status = "okay";
 };
 
+&usart1_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_hs {
 	dr_mode = "otg";
 	phys = <&usbotg_hs_phy>;
diff --git a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
index 97fc3fb5a9ca..6b01c3c84272 100644
--- a/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32f7-pinctrl.dtsi
@@ -24,6 +24,7 @@ gpioa: gpio@40020000 {
 				reg = <0x0 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOA)>;
 				st,bank-name = "GPIOA";
+				bootph-all;
 			};
 
 			gpiob: gpio@40020400 {
@@ -34,6 +35,7 @@ gpiob: gpio@40020400 {
 				reg = <0x400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOB)>;
 				st,bank-name = "GPIOB";
+				bootph-all;
 			};
 
 			gpioc: gpio@40020800 {
@@ -44,6 +46,7 @@ gpioc: gpio@40020800 {
 				reg = <0x800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOC)>;
 				st,bank-name = "GPIOC";
+				bootph-all;
 			};
 
 			gpiod: gpio@40020c00 {
@@ -54,6 +57,7 @@ gpiod: gpio@40020c00 {
 				reg = <0xc00 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOD)>;
 				st,bank-name = "GPIOD";
+				bootph-all;
 			};
 
 			gpioe: gpio@40021000 {
@@ -64,6 +68,7 @@ gpioe: gpio@40021000 {
 				reg = <0x1000 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOE)>;
 				st,bank-name = "GPIOE";
+				bootph-all;
 			};
 
 			gpiof: gpio@40021400 {
@@ -74,6 +79,7 @@ gpiof: gpio@40021400 {
 				reg = <0x1400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOF)>;
 				st,bank-name = "GPIOF";
+				bootph-all;
 			};
 
 			gpiog: gpio@40021800 {
@@ -84,6 +90,7 @@ gpiog: gpio@40021800 {
 				reg = <0x1800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOG)>;
 				st,bank-name = "GPIOG";
+				bootph-all;
 			};
 
 			gpioh: gpio@40021c00 {
@@ -94,6 +101,7 @@ gpioh: gpio@40021c00 {
 				reg = <0x1c00 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOH)>;
 				st,bank-name = "GPIOH";
+				bootph-all;
 			};
 
 			gpioi: gpio@40022000 {
@@ -104,6 +112,7 @@ gpioi: gpio@40022000 {
 				reg = <0x2000 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOI)>;
 				st,bank-name = "GPIOI";
+				bootph-all;
 			};
 
 			gpioj: gpio@40022400 {
@@ -114,6 +123,7 @@ gpioj: gpio@40022400 {
 				reg = <0x2400 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOJ)>;
 				st,bank-name = "GPIOJ";
+				bootph-all;
 			};
 
 			gpiok: gpio@40022800 {
@@ -124,6 +134,7 @@ gpiok: gpio@40022800 {
 				reg = <0x2800 0x400>;
 				clocks = <&rcc 0 STM32F7_AHB1_CLOCK(GPIOK)>;
 				st,bank-name = "GPIOK";
+				bootph-all;
 			};
 
 			cec_pins_a: cec-0 {
diff --git a/arch/arm/boot/dts/st/stm32f746-disco.dts b/arch/arm/boot/dts/st/stm32f746-disco.dts
index b57dbdce2f40..9545b14d77c3 100644
--- a/arch/arm/boot/dts/st/stm32f746-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f746-disco.dts
@@ -169,6 +169,7 @@ touchscreen@38 {
 &ltdc {
 	pinctrl-0 = <&ltdc_pins_a>;
 	pinctrl-names = "default";
+	bootph-all;
 	status = "okay";
 
 	port {
@@ -207,6 +208,17 @@ &usart1 {
 	status = "okay";
 };
 
+
+&usart1_pins_b {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_fs {
 	dr_mode = "host";
 	pinctrl-0 = <&usbotg_fs_pins_a>;
diff --git a/arch/arm/boot/dts/st/stm32f746.dtsi b/arch/arm/boot/dts/st/stm32f746.dtsi
index 208f8c6dfc9d..b0f012de759c 100644
--- a/arch/arm/boot/dts/st/stm32f746.dtsi
+++ b/arch/arm/boot/dts/st/stm32f746.dtsi
@@ -54,6 +54,7 @@ clk_hse: clk-hse {
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <0>;
+			bootph-all;
 		};
 
 		clk-lse {
@@ -76,6 +77,7 @@ clk_i2s_ckin: clk-i2s-ckin {
 	};
 
 	soc {
+		bootph-all;
 		timers2: timers@40000000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -149,6 +151,7 @@ timers5: timers@40000c00 {
 			reg = <0x40000C00 0x400>;
 			clocks = <&rcc 0 STM32F7_APB1_CLOCK(TIM5)>;
 			clock-names = "int";
+			bootph-all;
 			status = "disabled";
 
 			pwm {
@@ -645,6 +648,7 @@ ltdc: display-controller@40016800 {
 		pwrcfg: power-config@40007000 {
 			compatible = "st,stm32-power-config", "syscon";
 			reg = <0x40007000 0x400>;
+			bootph-all;
 		};
 
 		crc: crc@40023000 {
@@ -663,6 +667,7 @@ rcc: rcc@40023800 {
 			st,syscfg = <&pwrcfg>;
 			assigned-clocks = <&rcc 1 CLK_HSE_RTC>;
 			assigned-clock-rates = <1000000>;
+			bootph-all;
 		};
 
 		dma1: dma-controller@40026000 {
diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 535cfdc4681c..539517c7991e 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -133,6 +133,7 @@ &clk_hse {
 &dsi {
 	#address-cells = <1>;
 	#size-cells = <0>;
+	bootph-all;
 	status = "okay";
 
 	ports {
@@ -178,6 +179,7 @@ &i2c1 {
 };
 
 &ltdc {
+	bootph-all;
 	status = "okay";
 
 	port {
@@ -221,6 +223,16 @@ &usart1 {
 	status = "okay";
 };
 
+&usart1_pins_a	{
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usbotg_hs {
 	dr_mode = "otg";
 	phys = <&usbotg_hs_phy>;

-- 
2.43.0


