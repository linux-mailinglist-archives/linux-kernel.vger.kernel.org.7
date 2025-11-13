Return-Path: <linux-kernel+bounces-899701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0C9AC58997
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393FE4274C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B82F39BF;
	Thu, 13 Nov 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dezbjAq+"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C3C2F0C46;
	Thu, 13 Nov 2025 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049017; cv=fail; b=txQii/+oOz2Yhwq0shn7DeOCZ6FwjSFXx18/K0mSCGpHckWJcXD+PO9G79kuTilQghRx0HXtuNzMRA98+3Rn7fBa6IG0DGVEopLlLazadOz+HBfAa/tZutborw9iMK+qGabUF4yQ88c+gAejldXbrYzjmP4iBk0yR+o0IXsPiiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049017; c=relaxed/simple;
	bh=lAUf2m9Grw58B8lJHHSESYJGEvUeG3dUJN1fX6L9uZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hmLL2m17q/L9GEay46L5lbmhsd5WB0E3sSQlpl7k7Shda7AM1NKQDYL8Jyj979/WndLQCF/W3vYg2oK+Wi1kRisJZbJX6cqcF/+s3aYjyBp6klXWCmIJM7SkTYxmwyqFhIoMuX00XYwu9+pgohgu8tEt49KZXnH9JNiB0gSxDU4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dezbjAq+; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADEmhAa3956822;
	Thu, 13 Nov 2025 16:14:07 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu5r8y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:07 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esi1hxh8tDtNK84h4la45epd6q7xBR8G9DkHT0Gsri4g3r6arTKwC5S7SX+ZgEnatpyW5b91zSz92DOvChRvhIz4HKUMVnZJhFZhLsNORLMg9NBEfZczTo1BdERM5vu7Zna0UpCbwA+2FJStzSZB+wmD1E60dl/dTCNytoKwwdtz8DEbuPf1bBV4JpRrRjeXZvKXGizScIg4Ijls9y8hRDaYDHh4to2gmJuMjJM/jXmOYR3rR70z8PF3ZvvcgCTH9KiSYyu/XxUUbeBGdHUl+fYGYCJQ69MerPVhdzgg5oMECE8apG6tX0StFpPgwjapA8gszsE9eNz/cxWoqsxWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnM+EcUsN4+OwPvxiT/KNe49zAAuzaoRjmMRnzXnuPM=;
 b=tFj2DPYn8wmW8qznUTkQU2MizrkkdnS8jTRffNytWbRRmUMWKFUqP0FBVRr0Z1kYwo38TW4K516lmQu90blKQCgs7SRCMUXbk2l7CjMnd5D7XEH7/xgzQ49NI77K6UWmu1ELevGt/0ucQ4RPJApKi06xix9P7Uf0xHRgfGXkw2dp/f4kQbKfYwTGb2daz2qZnRZX12YkOvdE9zfrfbfO0ZwWDcsBw/65ODKe/WJ1QSsj/NkS7b4xhlL6XDx2i23Bf/sA/sOxUS+/BoTpm4VRGpxQqjvpa5hd1L83n8sjmota+YIOKVXPGX0OC9EuQn4Xg8ljijsg+fZ11+VetDgvhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnM+EcUsN4+OwPvxiT/KNe49zAAuzaoRjmMRnzXnuPM=;
 b=dezbjAq+Wg+SkVw2pGJhLYDTh1g0icTnmzMNjqJ55/nMiGYO3LK1tsn/X7RraB0PBde+ImGL0guIhVIRxrOc+y5HQPBH3vAZiZlfw1VTSwbO7VRXugIzu9pa2oKtrjhiFSicBBrjlv6HfpCRcZPrHyqqVmYyMl4tO6I9eYeulLcWoHZP2ZvoNlH+j2rT4Nh3Aer0MQV3gyDW/26HwJpz3uvCAySw+eNw3uJfr7MRoTwJtjHhF+GpPL8HuwYEErEi/e9HwM32zCm9c18dIG2O8O4L7knRKM0+w0Kf40GROqu53narIO2Xb9ZmzXDhOYSu56bWvYWAbc45EnC2xWQUbw==
Received: from AM8P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::23)
 by AS8PR10MB6604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:565::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:14:00 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::d2) by AM8P190CA0018.outlook.office365.com
 (2603:10a6:20b:219::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 15:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:00 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:11 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:59 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:57 +0100
Subject: [PATCH v2 06/16] ARM: dts: stm32: Update LED nodes for
 stm32f769-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-6-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|AS8PR10MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9401c0-98f5-46bf-34a8-08de22c74627
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWMvTUh2VUEza1hZdUNJd1djeU1oY0w1QVZmNnFQbkVhSkJMVkxvU3poSXF6?=
 =?utf-8?B?eGd1cUlWbU1kVmQ4bjNhWlNpV21EckpobjdLcUJON1VoYzBhMGRYY3M5Y21L?=
 =?utf-8?B?VnA3U3IyZXl6ZDc0WnhzMUtSRXI1bUxDa3MxM0RNbmMwQ1RXeTNldm5hYngx?=
 =?utf-8?B?Z2Z2aUE2R09DaU5sZjVOLzJoZklTN1JEaTJqM0cxNjRuYXptRy9MbVFKK0Jp?=
 =?utf-8?B?MmxsaDEreU93TlFESFJjYkVGc05iVTkwOWJnektXSWFDTUZpZkx3N1M4a0w5?=
 =?utf-8?B?dGVNVlFkZVREQnF2SXJtREcyam9zSGRhR2plN3QrOEVDRkV4OGdqOWZmRHFv?=
 =?utf-8?B?Rmg4MEZoV3NwRFc3YnNUNUxOSURRZ2JLOTMxT1lpNWVxSlNCTER6endaemtF?=
 =?utf-8?B?eGIwcm90ZXFqUmZReFQ3angyS1ZGQ2EySFRpbFdZK3poQU9sd24zSHlLMHdW?=
 =?utf-8?B?djJwK214UVBhT1l6ejExL0paaDhyRVlkdndIWmNuSGZoZTdXTVJ6QjFnb3dt?=
 =?utf-8?B?Z3U0SGt6RjJxWHRhTUE0a3kzaEMrNmhlOXZOUDNRMTdqQ1dxSUVwK3AyaGZE?=
 =?utf-8?B?WWk1TytxWHBFMXRnY0hYQmVDcWZOcFFrOVN5dngrbDdPRUFjRDNUSmovUjF0?=
 =?utf-8?B?YWw4djFMeXd4MGNxdzN6UjBpOVczdkNQTjQ1b25JdXphNkxMVHZxbXl3RFY4?=
 =?utf-8?B?cUdHM1JEaW9KZXpFY1lYZzlOSmx1YkZHQlpTT2NBSmVFMENlZGFpbDcxUDlQ?=
 =?utf-8?B?RW4rdFZEN2ZBWHRNUVhlRjBQYUZQdWsxa2ZzcUFvLzRCUjZ6OVZnb05nUWRl?=
 =?utf-8?B?Q2hrV1VER0pqUndzSlQxamQ0dldJazcwcHpOUlcxQzlKUHhVZjJKS2t5RHJH?=
 =?utf-8?B?dUhPSkNtL1QxNVYyWWc2R3NmUVBxUlpKK1I0UzlYbHk0a3o3eEVkaHB1TFJk?=
 =?utf-8?B?YW0ycnUxNFZqalM0YzBxRjgwOWdEQ2UzTWZ5YWRzZ2xpTjZDY3EyRDBER2VQ?=
 =?utf-8?B?eHRGcXJLMmpIbTNyTDExQkVmZXR4V21DSklIQ3ZzckI3MWdwNmxHMDNYZkF4?=
 =?utf-8?B?Yk82c0lVSzhKZTI2NGJmQURUanJydlljM2JjMGkvUUxXVlpESmFNS0QzckI1?=
 =?utf-8?B?MjRicFRFQ3NaTVpWRFl4ZGl4eTgrakY2K2s0L2xWa01SNTY5bWJJejFyWEh2?=
 =?utf-8?B?UnExMHVTSjhnN09RdkxERkdobUZmd1cyZzVhQU9Vak9kbjJPdW1yRFlkbFpC?=
 =?utf-8?B?ektiKzRwTnY0Tmt5b2t0cDV2bkpEbEpIZFo5UXVDeHFYWHc3WitnTFF4Tmov?=
 =?utf-8?B?SjJiK2liMHluRksydlNJT0NKR1RxL3k3UDBKVUtqNEZBMjNyaHVjaU5HMUEy?=
 =?utf-8?B?VVlISWpIU2hPTzdhTlIwbUJOMWNhZDFJMXUza0RDb2s3M3dxc2t6bUl0ZmMy?=
 =?utf-8?B?UEswd0x2dXdhb0Jvd0ZjMCtKLzBsdFpYOGJMS01OVlFUT3pCSi9JM1UvOTNC?=
 =?utf-8?B?TlBIUkVVVnB0c0p1U1JMMEJqNGpMTVFBaFJUYUlRLzY4TDBjdmNWZm9NdGl1?=
 =?utf-8?B?RkxiY0hNNXdIYklCVVpmQzV3L3c5azlwMjZLUkZVOTBCcWFKdklSMXFkZkZX?=
 =?utf-8?B?YUFveDJnL1MwckQ3S3hPREJyUlFWakNNUlZBUzZPQmZOQzV6dzBhNHhnYWM3?=
 =?utf-8?B?U0R6Qi9EMjNjYk41TVJteDN6d0VRc3Zuc2h2bnlScTF3cmV5R1JzaTl1QSsx?=
 =?utf-8?B?VkUvQWQ0R0NNNnhIbE8zSVlCWUlwY0FXbXpEWHFBTVNYY0lscy90NkN3NjBi?=
 =?utf-8?B?L0hBZEZrR0ZmYXpSUUNTS1p6eXhTbEVyVFBZMUxOUTgxQ01GcTExTVpHVHdF?=
 =?utf-8?B?ZnlPYk5SVFdLWkR0NUF5a3hxV0ZQZktHVVVhQjZCVVQwNnVkMkQzT1JQS2dO?=
 =?utf-8?B?R1NCN2o2aWtxU3F3cXdnT1lQUUJvR2FidnU3QUMzeTNPZnpkK3V2Ums1Zmgx?=
 =?utf-8?B?NTBTTjByVm1ON0ZxeVVDYTdwSHVIZ1p3Njd0cmwrODc0ZnpNYXd0NGV2empH?=
 =?utf-8?B?NWVjVlNLbmREck1HUVNORUdYaFZIRkd2SHJsMDFjdndUd1pONEhscklCamVX?=
 =?utf-8?Q?j+SY=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:00.3262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9401c0-98f5-46bf-34a8-08de22c74627
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6604
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfXznEaX/OEzeTe
 vqtLfemgDpoq00PvsYaUGqNpqf+MQ9rE6o2EqfyaRMbx4gHfxlQIOmBEq+ND0tvVza+FGA80FBj
 GT40wUFFI/fGjQVOkffXWBhMkHTe44vAkVRMMPwl+FyUM3oNUJCHWKMZLOoH8DSc/lRRI9moyYG
 sN7TmfFjDA+aeAOHnOYMLbvuAuWFyJTMm/Kv3KYuL+EETI2eqPaanm5d71Nhs58hY0HE5aHxa3j
 b4TAI6UHlfFRmo7Q3mPodhpvIdffasJDmkMEvdhkmaKz+amz7jnG87AnlfAPxsEFHFhRNMpLMwX
 e/BSPKGThfTbEvZbeKhdbVQRqQRh9NXxivriNlWPMBsuLE7fVO2gj5qY9btdkT6Uxo+9Q+vsXgB
 YbTn2EI4tJBwYcQWV12Y8uDunwMbOg==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=6915f5bf cx=c_pps
 a=u8ACBDucoOS8YlAhSULG+Q==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=Xl1y7immRxvDyKJo7PkA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: OwmxDnRGUVwMbQIGQms8l5SRodT2ot0v
X-Proofpoint-GUID: OwmxDnRGUVwMbQIGQms8l5SRodT2ot0v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add function property for led-green node
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f769-disco.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f769-disco.dts b/arch/arm/boot/dts/st/stm32f769-disco.dts
index 535cfdc4681c..97c276f81f9a 100644
--- a/arch/arm/boot/dts/st/stm32f769-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f769-disco.dts
@@ -45,6 +45,7 @@
 #include "stm32f769-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F769-DISCO board";
@@ -80,13 +81,17 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-usr2 {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioj 5 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-usr1 {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpioj 13 GPIO_ACTIVE_HIGH>;
 		};
 		led-usr3 {
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioa 12 GPIO_ACTIVE_HIGH>;
 		};
 	};

-- 
2.43.0


