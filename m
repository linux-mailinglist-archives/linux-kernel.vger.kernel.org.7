Return-Path: <linux-kernel+bounces-897441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D20C530DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC4560D30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF65347BB9;
	Wed, 12 Nov 2025 14:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="E6mv6VN2"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691833446A2;
	Wed, 12 Nov 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958459; cv=fail; b=VJbfROiBvdhksLRrBfVS6365EEX7sLme7VAgKgxDlgNzPGz3GhSGcsJHRL262KN9suUxO4cVrQKPVNM5HqwCOUjKEfBfE9iGOVsfsZuwjb5FN+EhD5NM+AHn3VROyDI06PxRlLDf6W6TrA1Woy9tu16rwx7zaJ7+FEhJPGw6GF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958459; c=relaxed/simple;
	bh=CQhzPqI4DpL/d04W3b2ZrSomOiL88MHcWHDvcckU37E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V5jov34PjKdp6riX9Rrj4H9wNFX/YSCUb0abzUKdZbzY9osl4vsnnqjW+1BNY/lluTCHLSAE7Mf2oZacKiBUMUwZ5LHsJVTrZWxPUEJAaiamSpuA/Y8FcaAjC2e99MFi79IYdl8mrwb5PeIpYPLAzd8FM7oEtupne161bDc0wm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=E6mv6VN2; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACETNJ61794059;
	Wed, 12 Nov 2025 15:40:45 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0hgm3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F05gq8D1otUwr2rRLuZWFH0cSK+vIA0QlqGOKnHSPsv6IZLZpZf0Xx+ByHVsUCcqhWx3qJBDjXuS74/UVrD9unTHBn3sYGHAYjJeCpdDwhTq7kDa0YpZRL8/fhAt3BSkSDCtwn2DFF1LD6YrgGS4Tid/puNzwFsxb/mHim0uQlVgz3iXse3XhtgGINY+bQJPwcO2WamntOywRMCXyNytmNg20YV9OcqwNsPAjIDCiMYemMiDyaFRXZxkYXepR5b7TBfjCUFARNlesXA2EypqHuMDCvb/j/0D2hHvbVvUSFWmF/dF+f7U207Xl08zMMJAok70svZ1g1bgsFGErH+bcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=92zov0C+uB9MOBT16ijczFGM5kBkTH2zO13odElRvVM=;
 b=c1s6dsAxX+3+VUkHXRyukJQNEEZ0pG3WE16hG3IFD8Om9Cmyrq6Tm7IkBA3E+Z81uZZEDZXEF7vbsgVI/eiIAUztzSnIIb/iZnICizOVRxP26gQ8RjXcng0xiz3iqhlCqwwGzD8PuT7RHYFNLFvc71hSYZL4V9nNItrwpdqtzkEVvlofcxctBFTgdlJsvhuci1kBPPpjGM5B3BTHLW1NGUtsiThqN0cPtB7VOyWwaz+wA7z5emJhx1yxw8C2378V+IE6sfqjHcsTwOGaZ4CU1sDvEKPqrwyNjmCQTpUCULD3p/OkwO/viIft2Q3RhxRzNY/EUtfVrDdbz9W5wh38YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=92zov0C+uB9MOBT16ijczFGM5kBkTH2zO13odElRvVM=;
 b=E6mv6VN2Ne8eMDZ44GXQGpk7EI6ejYz39a8JnSDiGxlQ/18RAuT9J/NXecornF1trcYrR/HT3MXZNe+T6FtXZQp1QkO8OOr9ueec4CsTkWid8BiFDu+mM1PTTznFIrKRGdvvapFdFLMSElny076VWLfr+CeclJv7+ZqIxiRVhwOM7i993KypD2Lu2a1X82YcpK8nDw8d/qTsv7l/e7ATC4LuIvHUc2I6ml8QDUt39wF28jhLHbMI0F69xlmwjhIMDDUCzje/xJSZIm/bV6t9r99dI8dcQHkDwAX3wiG/M3e2WmwV05rIfhooJaPY5bDj2U6YzhPuPYrOHQLKslwwxQ==
Received: from DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31) by
 DU0PR10MB9327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:5c9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.13; Wed, 12 Nov 2025 14:40:42 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::53) by DB3PR08CA0018.outlook.office365.com
 (2603:10a6:8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:42 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:51 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:41 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:32 +0100
Subject: [PATCH 15/16] arm64: dts: st: Add green and orange LED for
 stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-15-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|DU0PR10MB9327:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b15d7e-8f41-4fa5-b184-08de21f974dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXMvazBRVkRuZ1Fnd0phSkVIaGFUck9rLy9CN3l5WURLUmp3aWd3WUNsVUNm?=
 =?utf-8?B?ZC83em1YTE91d0ZWYWx1NGt2T1FXVlgwWXN0M3pLQzZ5U25oSUV5Q2JEaHc2?=
 =?utf-8?B?ZG45Uy9hOXNCT3d2bzhuRzJXVTRVNUlDOCtEdXBZeExaRFU0TlgwYkpRTjFP?=
 =?utf-8?B?U1JvQ21vckZ3cHJNVjZGM3ozMFJjRldxVEoyYTFBOTdZZkFKRE93VzNld2Uy?=
 =?utf-8?B?aTVwc2U2WTNvc3pGSzE3Q3pISldmN242WlBZdjRSNUFpSmJOZXhIQ0dsQmE1?=
 =?utf-8?B?VnlNczg0SGQzUXd5b0ZHbkV1R0p0QnlNajhOb2RWTnBjSHRlVTE5ZFFKM0Mz?=
 =?utf-8?B?WDkwRTVVTEhuNXNxM1hLcUpVUjhaQThDR1BlWlc3ZTMwcXlTcU4zNWZ1VG5a?=
 =?utf-8?B?NnNmQVd6dDN0NzViY0wyY0N0bk9Tc0ozUXRNbkIvZ0VUNG1GQ3pMSU1BTTFD?=
 =?utf-8?B?ZU1OZ0ludkQ5WkJLTGszQnJTeWlRM3BlUGxnTWVxek5qVStUcWtOZy84anlv?=
 =?utf-8?B?SDhEdFY5QU9Ua0tYQWN6N1dUQUxLbi8vWXRTa2lJYUVsSzZ0ZzZhdFdudVVE?=
 =?utf-8?B?ODF4TjF3U09abkZzTlZRamliejB2R1lvUTJybjdoditwZXo3bFF2ZzZHV0N2?=
 =?utf-8?B?SFVXWUxaRXpNQldUT1Z3S0o1UWd1MlBQdFloUDBnaFhPd3pwTkhJT0VqbTNy?=
 =?utf-8?B?VHJJb1paVit4aGdyUnpBQjMwQkxGSktaeWdFd3JKaTRpaktYekp1bWVlYU1T?=
 =?utf-8?B?VUZuRGczVjBGVjRsZTl1dHlZSUdwT2pXMDZSTWpLVE5vd2dlOGNmMzZ4SGFG?=
 =?utf-8?B?enV1alBDSElrYVlEeHREOCtyalFpTWZEWmRiS2t5U3liS0xYK3VWV3VGSzdT?=
 =?utf-8?B?L3BURUcrSWdYWGx6ZUdVYVdIenRKUEtUUHBJWWRWNEJoLy9aSlNSY1pTNE1p?=
 =?utf-8?B?ZWtUeC9UcmVVbEo3UlFwL2IzekNhWTQvd0RmOWJScW1LU3pTU1Mzczd4TjBy?=
 =?utf-8?B?ZDNMR3ZtYjZ2bXltc3FpS0RxSjJray9lMzBpc1NXN0ZIMFNEbHRZVURCN0hr?=
 =?utf-8?B?Q2djYXZ4M2t4YUZqbXhqWUZVdUo5L1Zydmxoc1FQUWpVRWRkZ1VoY0trUjZa?=
 =?utf-8?B?U2ZETWhOUFNPczBqblBJdGZEMTBBbWRFVXo4RkdPa0ZGb0ZjVHh2RklYY3pw?=
 =?utf-8?B?aXVKN1BVWDJxejFKZGpJeVljeE1pNHZYL0tqbkw1Sk5HQ2tTRWhuQUs5K25w?=
 =?utf-8?B?RStDcDA4L05pMlNDU3l4ZEVsMUlYRnA2a3dXVEhDanBFM3dveTR4Sk0vS3Nr?=
 =?utf-8?B?Ujc1N3NldDdzRGpneXMzUkhDZlZOSWxJL0k4dWlCTGQzajhkUUNNa2h4dkVL?=
 =?utf-8?B?Z24ydFE5NlQ0VUtMcTRsbDhNbVZFeEVDbUhKZEJCcVdqUVVZbEpSREZRTlVi?=
 =?utf-8?B?MVVRd1dvRzIwZjVUY0hKcHRjTDcxSDdoaFZzZFBhSnEzTW1xUXNxeXNBTy9E?=
 =?utf-8?B?TWZWVHFjSXhqd3B0RDhSMGlxYWVDSEdaNEUyT25YdXpCeFB2SW8rdWxXbk5z?=
 =?utf-8?B?dDdLS0xXSmRFMnRtTTQ0SU1JV21EL0FWUUpieUlPSkhFT1A4RWE0VTJpckVp?=
 =?utf-8?B?elF4RUM2ck5MUWVwZWZFQ0RsY3doUFJiRHhaeVoydFIxYXAvcjhUWnMraHRZ?=
 =?utf-8?B?bXFCdHJlVDRSRVBUcGJ1bW0wRHRLYUx5eE9SNjl0cjIzaEhSdE9jRzd0OVh3?=
 =?utf-8?B?R0RXeXVYK1VpL3JOYVFLWXZWUTFBUzBtVnZLRk5xSGpZcEhBZDVnUjFGc1BS?=
 =?utf-8?B?MHZOQ1k3VHNhT05QdFJGWFF3d2xNa0JVTWRITDRJR0RmRmtWWWFzdzdGREFF?=
 =?utf-8?B?QVBGZGV0cWpHQ1g4cnR2YUUxdXVseHEwUnBxRXl1R0NqRC8wL1FzVjNQNThY?=
 =?utf-8?B?QUZNMm5QdnR0MHU4SE5oZUhTcFVzS01lWCtua1BSR0NmK2g0OVJFVXpNYXRL?=
 =?utf-8?B?dlpYREppaXNiRC9TRkx2ekRIOG91QzV2bFdDdlVhUklEcHRqZXVGUTVqbllD?=
 =?utf-8?B?Y3cvSmthN2xFUVF1OXdsREZsa0RZcXF3VE9rZ1hqR2RiSXpGUjgvZlhHYWlH?=
 =?utf-8?Q?k4aE=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:42.3369
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b15d7e-8f41-4fa5-b184-08de21f974dc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB9327
X-Proofpoint-GUID: CIStAhA_7oTQ4ZfDStR-SYDtZaB-cUhF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXxdDpNbyMWmD3
 qSwvslGifiHvwOQONA4bqgpYnKKjK7N5IguBhIfpcqTBlCicK/2cWrv6/nDijt6yTOsNs9q6n3+
 17moMDwkfceRLu8YzCt8aA6aEuYD4n+hJ2cYipi0oMqmYgc9wCk20AK5vZRSiYIzFtaG7RsFSHJ
 /4th/0B1Ao8iA/B9nkjGtu7T4Foaqc2IqDz7o6TTj8klUSOZ7hDJSoYEzVv0AQHwbPNBGAGIFzF
 iI16MMtuP6JsdZqm6ePb0XJAY3ieP0FIGY2gZjmt2TYvGp0dw908ilcvbeNVyAoDRZe4wFBjAQm
 jp5aw8/+mwo/UvYmTh4w22jFY++ZjkrXvoh1ZRVnkV8RFwLy0S1MTUgO3SgZcMScXZiGjtOaOYK
 zUdfH92yxTgw1am37lHDuHV9mQYy+Q==
X-Proofpoint-ORIG-GUID: CIStAhA_7oTQ4ZfDStR-SYDtZaB-cUhF
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=69149c6d cx=c_pps
 a=7oA0jwBRI02ESJGoGLsOrg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8OzEVrWVIK6RD9uD4J4A:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add green and orange LED support on stm32mp235f-dk board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index e718d888ce21..dc1a75f10f49 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -53,6 +53,16 @@ led-blue {
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
 		};
+
+		led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioh 5 GPIO_ACTIVE_HIGH>;
+		};
+
+		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&gpioh 6 GPIO_ACTIVE_HIGH>;
+		};
 	};
 
 	memory@80000000 {

-- 
2.43.0


