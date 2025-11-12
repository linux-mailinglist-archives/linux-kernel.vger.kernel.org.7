Return-Path: <linux-kernel+bounces-897637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6A1C53431
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0C1053576DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB87A347BCA;
	Wed, 12 Nov 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MeNxYQxc"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8B133CE92;
	Wed, 12 Nov 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962536; cv=fail; b=Bnkp3Hd2eTJW+J11R4ySSqXkKZAwU+Xi48moR6IIUC46uiUEIMfwitehKVMD9kSI8MMnR0gd5Ts0NZaAYgAGXP8BYEw7opul11jUkUtYBcVi4jLrmfN+opagBnzEF8NblHrA0EDPP/m+m95fg5KmmwnwoNNdZ1lm8yaOZNzPEcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962536; c=relaxed/simple;
	bh=Kvw6gaHFEbYBw07rbIGaU+svJeXKuVSijzsTCkXKgFI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KkJ64j94Lglt+cxA12A2TOz+A35ejigeVn1JgYAQKZPiDMU/DCEMSgmhoSbhu8SJnPW+si8GIg2LZw9UTS5eEk7UWQSoKUpxPIWQPy+5R31oGuSzOgf0zlEQgCUoa0YWioistHg2qidOzBLkpLKsBKSYnFAZNikbMLVHD6Q/9nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MeNxYQxc; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFm5u61107778;
	Wed, 12 Nov 2025 16:48:43 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acq20hrae-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I/80cNU6/YZg0i4SNfJSmEEwmdJxBtvWUkuVSCh0t4GvKX9lLACO4QKAErNe6xEre/Gq5jjtXlgo+BY3ohUvXTLjhjRqVi9Zg5k9bmSHIWVgp6Lg28hB1JIic+xBcBWkU4Jp/yf17a9Ww6jHFO8O6gtiJYaR7sv9xOT4CNX4wTY2Zekep1zA+qSqtP4nnh6M1MR/R7eSqpx9zJjkcF8GoYQD9pYo4QSPcUe0ghkyrA8EnWGrG9Q60DDiq9FAcZYocz3SD6nqeSotEcrOukvcOCDhWBefcHuJnLZG6/3xGlNb6wghUaD4Y5MNntzzkJt7UxOaRb5gREFmU0ww/8F8JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ji+qBoUHlr70RGZuEH/6OWCYYBeK/UHqYt4eK+8rolo=;
 b=iZNwcTf6ghVgZa1q53lKmXz0qo5pRMDyCSObfKy2S7V69cTY0/M5ilkLfoIUcmBxLx1Ph5m1fG4zAj6OAukUrtfRFjTDxtnHkIn3Mal+4IG5ItKQc5QJ6FohpwowGNmSrB8nuR5iRv1hNgqGoArMLnxtIjJvvsTXlQIJhemDWqfJ8o4tIxGNCEUvH8r1KXl75Av6y2oz+VMGXF+JmbwiloyJSsqmoJfqDyF1ijFQzvpgd2Oq/GknxAL5BRUTwI5Ojq6rZNEBeLXaj2/dLGxts10SJThTYWNriYN5jnlr6IJm5rqiiAeN7QW6yy1uVQtt2l5+Rcc0mDlGiA3SslxFZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ji+qBoUHlr70RGZuEH/6OWCYYBeK/UHqYt4eK+8rolo=;
 b=MeNxYQxcPxY3tluKW1/zXwDm7Dy3ACGthcCWMI/LN3FCS2xyEbYzg9rWBgHTsFcAkZdBIwjt7Luv7ZOIBBwDwhIFpinVkWBg93RlXhYb4LP0bQCWHYGvgp5p1aGhwAP321oPvGrwfsk6Fp9oIufbjfluS8gNaXQgLDbv+CWJFQOcnTFW17OWZSwoKvNpfyARZ4mbLfef2yVBJI2BybijFPxVxsB1r/EdYkKChPzyz02rNAt0Pcz7dUE43E39D8YstnmkABFXz4THa26uaihlWNzHY3ZEtXPCyGSWGnqTuiahV9f78dzGShEAuLa6lAJa57z/pbr7YGCwBZ2pTwx21w==
Received: from AM0PR02CA0148.eurprd02.prod.outlook.com (2603:10a6:20b:28d::15)
 by DB5PR10MB7844.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:38 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::42) by AM0PR02CA0148.outlook.office365.com
 (2603:10a6:20b:28d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:40 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:22 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:16 +0100
Subject: [PATCH 13/15] arm64: dts: st: Add boot-led for stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-13-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB5PR10MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9c4ab6-1afd-4525-438e-08de2202f233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmlaMDcvRm5pSjdVWVZTUURaVkRueG56cUVTT3NZWC9HZWFHNHNneUg1MVp3?=
 =?utf-8?B?SEs4TldBZTF4b2xpMURWd2cybDVDZkkvUUVMMXpYalZaSjB0UGpoOTNuS0xw?=
 =?utf-8?B?ZWEzYkVPSlJJSHRjZmFmRnBmanZRc1hVQ2ttZWgwc09qeDZBb3RzVURvZW5G?=
 =?utf-8?B?V2dlMVR4cURYWE5FWHNhTmhROVRHRWoxcXQ5NkQ4Z055dzdHVnErYWRFNldY?=
 =?utf-8?B?N1pXbWs5UUt6bDVnbDJxRDlUTWE2NzR5cDJZN1gyMzZ0OExhSkxiN29HbGRx?=
 =?utf-8?B?ZFd0ck1MVnVMb1BudE1nMDRPc2FUU01aNC8veWV1WUt4N09YbmF6OTZUR1NP?=
 =?utf-8?B?V2dPZ0d0ZGI3cU13ZkxaZEd4WFdJNDMycDMxS1h2TFdhK3JzNXFTWnhXVmxC?=
 =?utf-8?B?cThQVHM2NnVsbXhaMkhSL3VaeWhhd25DYkZxd0VaMHhieW1WK0NjWjg5aURh?=
 =?utf-8?B?b3VKNXRkb2R0VTczSGM2aU1tbE4xUExINllWdmhUNmlVWXhEVDR6ZkFHSkRO?=
 =?utf-8?B?akJGcXVmVytmNDZNZ0QzV2VIYU1IeWtDWStlcCtoQnZET08yRVZIRTJkc0Zw?=
 =?utf-8?B?QWRSTHhpSCt0ZTE3dFFUZEx5d0loTE5ndXhIVVQ1bk5NTEtFYi84dDNoRHQw?=
 =?utf-8?B?TUR2TG55QXNCaG1pdlhZZFBjNG5PaFV5TmkzNCt6ZFI5TXZ4TUpvdVd0ZkFq?=
 =?utf-8?B?Rk1CN3JDa1BtdWU1eHZPQ1luenFqV0gzWmlLT3EwbnB0M1BoWlZhYURja0FK?=
 =?utf-8?B?M05BRXRDcEJ2SzNsdXBrMGZEVDZrNlBRZW0rOFc2UGJKWlJhWTNSbm9UUjV4?=
 =?utf-8?B?ZVEzWjU0M3pGUHRvbXV1SGhiN0g0TWlUZC9RekxqWFJhUXQ2Y0NoOTY3MXhO?=
 =?utf-8?B?SUpTR09iOUtlT1VZdkEydTQ5QWlUZlRrMnZrWEFMN0E2blVXV0FPUXIwTzhZ?=
 =?utf-8?B?akt5Q1VUK2VaTUFKSitoRG5TbzNQZ2tjSjcxR3k3QTRBemwyakU5VC8xS3ZX?=
 =?utf-8?B?ZXdabkJ3V3ZFR2JrTkJCVjRNTURjOUQvdmd4WURRNnM3WUgyeFAxZ1BzMTRm?=
 =?utf-8?B?TlkxK0hidW5vckw2eHphRkM2TlVqamkzaTZoVC9vd05ZL09QUy9UOVFxZHU4?=
 =?utf-8?B?anladUs2aUp6RXNjSEtCWTF2dk9sdWJkOWZMTzMvckNkaUZlUG1rdXBaeWFy?=
 =?utf-8?B?cVQyMDlwdVFReTUrMzNoclg1akQ3dkpHaGtTVEp1N2ozMzJGR0p3THFKdFli?=
 =?utf-8?B?cG9hR09sR1VWRGhOUVE0dEJYaUo3SHR5a3A1cVFMQzdmQlhJMXo4MVdKMy92?=
 =?utf-8?B?NFE3UkdGcFNnZzNBZjc3QWFCSjRqQVpyMlRwOTJpV3NWWEx2WmplWGVsYi9Z?=
 =?utf-8?B?TzFvSG55aDAxa3pCTDU4eE83NW50cWRvVTlaYzF2d1VMREdGL0xxREV1d3Q0?=
 =?utf-8?B?QVlhNDFEbHpDbHJ3NGUvYU1pK0gzVElWQm8rV0RrTmdtOTBWbldLOEV3U1FN?=
 =?utf-8?B?dERLNFhHeHhic3NSd0VvVDJXNDBYZWdCY2xmN1U4ZStSWGpzK2ZmSWt5eEt0?=
 =?utf-8?B?alFtOGtyV29aaUhzbCswZGZISEtwVGZMbHowQS9ZeGh4UG44WVZ3M2xKNmJI?=
 =?utf-8?B?TVlLdmhrcTBocW9PUDBZaHZnUVNxcmZadTBzdGN0bkpBSHV6ZWp4V1c4SkVk?=
 =?utf-8?B?MnZIaEVPSnQvKzhEVHBNL0pMTjg0T3Bna3lKcUNQOW5tcHFxVFBoT2VaVi84?=
 =?utf-8?B?YlJ4L2V2c0NWNkxPNTFINEhxajZUT0FXaUg0Q2ViVHJ2bDFIUktQRlpyMGJj?=
 =?utf-8?B?NUU3MEVzemVXK2FHaFpGY0doZEMwcXluL1pJSC96bHVMTGVPU2hvaytRSlc4?=
 =?utf-8?B?eWJVNlMvWkQ2ZnZ1SHhoV3VyUkZiczJLT3lTRE9Kd0pLS2o0KytnNE84ZlFM?=
 =?utf-8?B?WndKYkJFcGxBWUtQMEZoeXkrelI4R0hOTDdqMFJocVFqVk5UZ3preGZNbzFk?=
 =?utf-8?B?WktyemdRcW41aGVNVTlFcVh3MXpQRmZmU2FBQkpZTng1WGRBa09mbmVGSzJN?=
 =?utf-8?B?ZkN5QlVZZSs1TTVjYTdXZ3ltY0tNNzNWTXVRUmZ1OXQzejVwZ2wzYnFCclF6?=
 =?utf-8?Q?0dVU=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:38.1032
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9c4ab6-1afd-4525-438e-08de2202f233
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7844
X-Proofpoint-GUID: Ze8KhOz_5wWQWH6nD4WGiGkNxq1ksS78
X-Authority-Analysis: v=2.4 cv=LaQxKzfi c=1 sm=1 tr=0 ts=6914ac5a cx=c_pps
 a=CDwPQmgHc+Eu1NRyjOF98Q==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=mryTFFmu25SiHa2O-hoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Ze8KhOz_5wWQWH6nD4WGiGkNxq1ksS78
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX/Kz6b3A0Gpcc
 otjr3ySsUFBBvABrE1Oca+pkUeGbGdfUpMyMCN3cXcIdQ7ZFXFnHTidCij20VCRAHWhaGZ6xvWU
 H6enNf2y5O3fXXg8QLdycLWGU26bAwtM/pYxnNGqRbK9R0TYFRqhC1sdEcpXYfVK+YI9HIpeCHU
 jjgm8kLwvn7pa+FMnbj27OBdSbSe/gHm4afstRFW/cpyP1wRD4ZrtXfpaAhY9Qlz5o+0aJLuead
 HXW4LZASTReiP6ywNuSwJEAkpHn4AnRsYSgrefiprhZeu7ok4TFqLslYE8FhQcNCOzxB3Vl+pWG
 N/O1MH7SWWoKzdbEWkfYgd1YSqt9Gn1gQ7VsaFg8cHglQfj5NFImQDPAOA/bTO6VFZI6K2myYig
 KEX/7XOWiZz+Eqp5BaiwpEvi0xEqcw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index ab9a30103db7..4d7e3939ba5c 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -46,7 +46,7 @@ button-user-2 {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		led-blue {
+		led_blue: led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioh 7 GPIO_ACTIVE_HIGH>;
@@ -70,6 +70,13 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.43.0


