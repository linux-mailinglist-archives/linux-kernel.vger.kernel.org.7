Return-Path: <linux-kernel+bounces-899595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BF7C58668
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA9574F3F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D0234DCF7;
	Thu, 13 Nov 2025 15:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="V9req8Gf"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F544346763;
	Thu, 13 Nov 2025 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046871; cv=fail; b=je+Xu5BFQ9QOYflxB07GLqdnyL6R5BCFLZFyytNwzgtxpNJdY6wLXuPxcYebiEmy2sPUvHHqmZbckIGsUYt1zaTG/Ywks0MRGFmBXz8GiCyl8F2+CzP6Y8LlzN5/SvXU+IX674V4ssSIc235YnuDjIG6d91SpKKJUUHHBWeI4ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046871; c=relaxed/simple;
	bh=Wc8nG2gSyU4giEsAzqrqTcuU55VjWK/st5+l3Qyr7aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jdKpdu7Yn4kxIrkzIWJGMwFyR98Jd0Luj53F7xCMl5lq4TT6Bj/aNP+B0N1340w9mlLGCkZ+pbtIvzdn3eQCs2ajCECAXO2GZwHDzRDMVHkxKvWHXATEtIqkPR5UNAM/jv0bJQEUBNnnA88qJVJw/hglkyeZUjUpBTRafc217r4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=V9req8Gf; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF4hln4144074;
	Thu, 13 Nov 2025 16:14:08 +0100
Received: from as8pr04cu009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adan2j286-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tIliDAu0Ta3BWU+QX/Ft/n/mPejSus2x77VPPpGG7GKBrZ/410BOiuQxhNDG0ud1UzGiU1WKFheSdcgBJBkqZ/nCxU1qf3CfrGdkipn3jc/IWpIWIH27IczpPDyRFXHFrq5RsPdG9Asx+TBN2yKdwE/LXKr9rJUQdqBv4lveuyxJPev94KAgloHIvVbivNKQNTlkuUULJY5R/P7oHJDiG1xEhjW0CH+A2OQ8TB8h7VVjAYEW5pRHHRDbvcGjbhukewTPmCnSg/SQYUJVJ4zo2fZH7xnI8Xyo1GPBEGfvCd+xjUyb5w8XgwzH2x6cpqhXD/51vwlWH2bltDsO2s3wTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EZ3k/QkdRu9MX8UfN/XZh3kRk/b4PP5Mlc9QquLxeQ=;
 b=ekrUIhZJGEMqHTeMp/5/4ccLJcg61W6a3+CUHQdl2XUpoyQJgZn4cpZQLiHByIeYWhtrpknr4KzaI9bsGUOwtvNe780b/InIZ8mLDxCifAxYWlp3b8wlz02LyUz+CmtMrArXMDqU96s0ylcdN1teRRl2h9jDW3GjB0e5q7s2eeURCMGVggP9K0cdeGO7huVqWUUItcZciZUoHbA+kJR2W+PcsOoGOhls/G8Hwvb6IHv3FEH6pVM6m2M6NLavyQ0KVmm0+UKL08uH60Ewvuvwxl4BM7OpXfrQRC9DYMV4Qocv4ENw8CPj7ebJfp0Gr/Tq3hPfsfaftgBUbVDfj7KLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EZ3k/QkdRu9MX8UfN/XZh3kRk/b4PP5Mlc9QquLxeQ=;
 b=V9req8GfNOtAp3n6Lt+SPqeCRUndw9+7E+Rlt30JsCnF79J4dZ+wgal9gpWWSikO4PgGdffTE/LfWFVZadiLHUSZtnmFCC3NfQeIu5JG6Kp5blKezJhvVqOX+gO/czSnAWGYtc0GBXWSl9NV8BGMS+9M1tUo1HbMyFjtZq0uWGgK6hnEg/tgQmZwH7LSd6es9KkyKOsCQrr+A7nr647QIrLIvXnhQsqmM6AS+UJ2ba/YgXv6orB6LZGBO6s/W0f2QgGVaQKhleCXEoHLvdmxQbUUmjLSmRz0Xazc3TdAfv1GTLNh4tZyTu6fzkSBqUJkavkgZ57Jlq+sgGxUWAgwJg==
Received: from AS4P190CA0026.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::13)
 by PA4PR10MB7937.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:26a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:14:06 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::52) by AS4P190CA0026.outlook.office365.com
 (2603:10a6:20b:5d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:17 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:05 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:14:05 +0100
Subject: [PATCH v2 14/16] arm64: dts: st: Add green and orange LED for
 stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-14-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B5:EE_|PA4PR10MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 1526188c-dc0c-495b-c467-08de22c7496a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTZhVnFpcHlmVkM2K0RqQTZEV2RJUm5ib2k0OHZWd1BuTDV0M3dJemJXczVr?=
 =?utf-8?B?R0U4RTBFMC83czI4YUFvWFM5SSsvSkFFNnJHOWQ1bEltMisvYmt4bThxcE52?=
 =?utf-8?B?dFpHdXI3TWpucTJZSFVocGNseXpiay9PYmpsTEZPTjM0cGRDdVBqenErY2xC?=
 =?utf-8?B?cmJJakpEUW8vajQ0NGxWMllDUTVRTmI0SmFSQnRUS2I5YjdVbFBCKzB0Nm80?=
 =?utf-8?B?RWs3RTdxaXBXY1ZpSWI5eTYzeEtZb1JDaXZXMVVjNEZtd3FJM2R4YmZOaHVX?=
 =?utf-8?B?aGlEQzdWOEZ5NlEzNTJwd0xmeG53OXJxMUk2QnpDdTVVcHVGT2xaUlppNVhh?=
 =?utf-8?B?YUpueTJLTEMwQWZVaXZoM3g3ano4VWxoajk1Vml3NmdFOVRneGJTVU0yUzFX?=
 =?utf-8?B?Z1E3S25heHNNS0tMMFFNc3FTeFlySTQvVW5NZUFaU2VLTllNM2psVFNUNlRX?=
 =?utf-8?B?WjM0MktmOVpXT1h1dmVMaXBoZHdMbGpzYmtwMGpaODVEZHR5MVJrbUhSRzJS?=
 =?utf-8?B?UGJPQW1jWExQRWdheXdFOHJDVllVYzU3bXFoY0NmUWQvVEptRFM4WWpsMGFx?=
 =?utf-8?B?WXcyUGV2MGR5R3AzTUkxdXhhVzB1dmIyZ3pJcFRVQ293cWNFTmpieU01dUJW?=
 =?utf-8?B?c3gxL2lGTG9mQ243TDBuaUlnTFVvK2xzTGFvaFE1UmlyNUJObE40Vmc1a0Rp?=
 =?utf-8?B?dmgvNFB0QU5EdXhodzMwemNiT2tiSlVwdUhkVVRZOUIyTW1NKzJDRGR4NGw2?=
 =?utf-8?B?dlBqU2MzNGkxaGF3MDNKeWJxRkEvWnQ0YkhBZVpKci9kVk51UUFKam9QSW50?=
 =?utf-8?B?K3lJS0Jra1lrK1NpUVlBcnp1QjgxSmhQNGl1djJzaFl2YlRTdVY3Ylk4TXd1?=
 =?utf-8?B?UzlHR0pnN0RBTWhGMFVQL1dhNWxhTTNUSmFSU0JxRkRKVWZsaWR4SWxUUFNZ?=
 =?utf-8?B?VXZ5WnZEQzh3ZTU5cUtWODF2U1FobUN2b1Q5ejVrOWFyMTJKSUhIOWZPVGlV?=
 =?utf-8?B?bXN2TDlBSk1nSytsY2JxMXZhTjIxbllCWCtXZW45RXp0OXJsL1JYQ0l0WmZH?=
 =?utf-8?B?cUphTTlPUGs2M0VVN2IrbEtnZ0lQdHdXcWRFK3lkZnhDZHBhZGVES1I5b1FE?=
 =?utf-8?B?MVRUbmI1WWtXV3htN0JncVcxMmRxVTFtR3lOekM1MCtFS1pGZmpLMFBldElk?=
 =?utf-8?B?ODk1bkNrUjhaL0FqZU04VlFzSjVTWDlabkhSUjhkbWpMRzFoRy9BUERTcG9B?=
 =?utf-8?B?SFd5b3NieDJBOUJXWC9ET1haRjRjalA1OUluc0VpdEtEWVNMWkc0YXBZZTky?=
 =?utf-8?B?YzZwTFh6NUwvcDIrNEpaaEs2ZDhvbmFhc0RzWENEL2lUZTBaZTYveUJGL3Bv?=
 =?utf-8?B?OXVsSnhJS2tuWHJEbGZDa21rZm9mem5scmZoemJPSHlyT0VJY0xLQzc5cjNx?=
 =?utf-8?B?M0tObTZiSmc1RTg3UllLY3laNVV3Y0VXT2hjeTArd1h5SUNaN1VleXczM2dt?=
 =?utf-8?B?eFl2eWFHWU9hK1RlNzZoTFRqUDB6eDNscE5mNzVCamZYeDQrR0hFSmFpcWk3?=
 =?utf-8?B?RGhUMXg0cFZOSzJOSXRFQTVIb0dGODd2NjZwT1lUNEFTM2RnN1d0S3B0T1Y4?=
 =?utf-8?B?eHBERUt6ZDcrUjVlb1l5UkxDQWkzSGwrNk1FeWVkS1FOa3pScGNYOUEvV2VT?=
 =?utf-8?B?S3E4THd0MEtmN1NYcDNGM2JaZVFkTTFtbndTRGRLLzZtZVhPYVN5L1JwdXFv?=
 =?utf-8?B?RFVVb0huUDlPVGJhWmpkK25IdnExN2NkenhySmVWUmgvTjY4NVZlM2tLU3Za?=
 =?utf-8?B?TmMvYnBWMk5sdXk2TElOLy80b0VIT3ZjR0RmNWFpeEMxWDFJN1llYUpuUUJB?=
 =?utf-8?B?Mkk5Z3p5OFAxWTh4N29IeDZabW44aTJMbTg3UktiTWhNUzZHWiswUHpFQjEr?=
 =?utf-8?B?R1VNZDdjWCtJQ0w4WVVSUlFKZFM5RXd2NU90b0lWZUNpeXRWVTNrRS9iRTVE?=
 =?utf-8?B?WDVaTENia082djlRR2ZIa2FaSjVYNUgzTm11QzhFS005S2gra09PL1hzVi9C?=
 =?utf-8?B?NmlBN0VnS1l6Q3A2MlFBMmJ1Nm8raUF6MnRWRTNsVCt2K1FXS042b1l1RGRx?=
 =?utf-8?Q?e7aQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:05.7942
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1526188c-dc0c-495b-c467-08de22c7496a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB7937
X-Proofpoint-ORIG-GUID: xeAGBYAxrBFfS1H5Z6wet6b7_BNFCWGc
X-Authority-Analysis: v=2.4 cv=DOiCIiNb c=1 sm=1 tr=0 ts=6915f5c0 cx=c_pps
 a=x9zcKlvBpG4CqsuvBplHWQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=TTPuxdn9ZdDPh6fWduYA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: xeAGBYAxrBFfS1H5Z6wet6b7_BNFCWGc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX0osy44zCEr92
 AJvCVJrQ5P3/Of2+ePeVFxKNnDeRZpL9Aje03d6jSOtDWT4lwG22J0l6mnMIheEhbX1VJZM4yPz
 CqQ2+Z0n/Ga6Zl9+rR/31dA/rqT8hGePTMAHFa2w6EX46PGY8n0XSKP7ODvwxHmHhd++wyCoi9Q
 qr3saU+UuZJXFSb3MBHEveWy43QQ1vg84dPpG3+uO7R1B2rzRM5bmtdQv4t6qSEP3JqUo/O762k
 2vl1YlLsfVOB0xhtgSzKzK9QUnOxQOJL71k92EotY8UVCc6QafptKW6tn9ZSoYwaPbV4/m42qng
 fGSAo3SQX51VWEj7ji219Zy0wo15TGpdzEN6CLBAolAQ91j+OCCxM3HzP2P17/5LwZXuT0Ov2MT
 8iS7ek/d3UBkVaRBAVSkPQxeeAM2eQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add green and orange LED support on stm32mp235f-dk board.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index c3e688068223..ab9a30103db7 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
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


