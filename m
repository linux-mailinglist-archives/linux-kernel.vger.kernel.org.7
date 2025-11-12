Return-Path: <linux-kernel+bounces-897632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B726AC53974
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6B250843F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFD83446CB;
	Wed, 12 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MVxwyU42"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47103341657;
	Wed, 12 Nov 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962532; cv=fail; b=KiBSaV0Gy8v4gUrZfOCKEaLnL5PLF7Z9cbXfaOHNS0QlkortpEg7I8HNhnFRZt4GlKNrIxXzoHKuQ77Vmv+f3mSZoI0qp8ZR6mc4/msEfaQgZil5Y0rQj2GYFt+RCT5tT4rQ3CDCS2bsyPJ4OV/I0oiEWkJRDhhspSSKP7gT5XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962532; c=relaxed/simple;
	bh=N8hmO4cO6QoDM0359wiZvAYgafYto/fWkBVifGtC/zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PiUJoMTOEd2S8MQFNTCf3q+Q4nWvXswGIHnJpEvUpYLAUo3vyqXkjk008Q7LnHGels0jhr6Cx08fEb63SdDlS30erHMMmhBo6pABSztWgZZnOVteZ1f2iEYt0ejXRLxhAUXcjCNJHt2e+KSm2oX987UWHVkeoaKNWzrIE3UoG30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MVxwyU42; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFRH1U1065763;
	Wed, 12 Nov 2025 16:48:39 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013013.outbound.protection.outlook.com [52.101.72.13])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu18xq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8W2HSsspkAttcj9O/65Ez+ZQOuiMtv8URfZtUoZym0QqMrwk1aDfBjMWCBT8jR2HlPWakNNIzTOXc90GxEx3VG1q0yePrtsY0QBJfGbyIUKT1zfTXNSVcKCKZrzXwPPWtgaEw6FleP2In9wYLJzo8RabdyMpkKxZfZ9UqOssrdteye7KKhT0g+q3V+bqU2fFdZlGFw1Sgcty8nK9AOCtE44ha6wW21jfAIwxivCM4zGqOl9hNQZGsyPuC6wZybXDt66/GVbHtIPkUXWNyzKyS76zbUQKfeuv8fUjzqs4aEw6kSjWGw+qE14eWAzRnconIOarZrSzgPNcsfEXfLQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVIfawv4WRbEg6XVy/EYhBkKVTrPWHCkezrLoFqA2+o=;
 b=YokXISK3mImNR/EnvIa2pztDgt0zMpTDLDVEhdO0ZXN1sUNXitmXh80GzkwFCDsN32skM69IIIVuAgyAn5idNxFbfsElG32XBuhv+if1tna4GFwO8SHlc/Ka8VKrhxiklrXnv4PTCfJoK47OVctiSuZlgrF5tm2yPmh8/YUV52HPZjPFpE5O/6H4Vaphw9iwhPnwPioutlAZVJAC0o0JI6sdnbw3oBe+Cpgrs7GidE+TNlQjVqKRMo4qiFhs0wSwvNv5y8u8uNehNZl4LiwpECmS/AiZHcQC/lHehkjtkOD5Cfl6ymjCUSxnxDFmQNDDFeS71jHHHXCqDm53nx0dcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVIfawv4WRbEg6XVy/EYhBkKVTrPWHCkezrLoFqA2+o=;
 b=MVxwyU42CzVereFgoprJvsg4TGcsyLqHIOh3g9KbOAgAvQ1MqEfCstxalyyaI/921KLqibxcKRvCebeBx7XZyG5q9l0VlldLQ/BJIZdIQYjy7AVLF0DQ+5C3iU15S+csQOxdELf/gSJrXGFwjz9kWJhqo5KMan34CFZQoRFpz+Kc8P7d6ii3vvUjcChQxzCQGcDISo73BNTKIWHBBgJfMZUBPtJqhMvvZlCed9oyaLc1ZAa687gGU1uAbjV+HX2ESnElkf2LBZ87q+RqzT8GMsdCmSb5n3lzYnJWuLKKO7jDHYBnqLJ0QUtNq2rmTrLXMkAi+yq/qsVIS1k65SeM2g==
Received: from AM0PR02CA0143.eurprd02.prod.outlook.com (2603:10a6:20b:28d::10)
 by VI1PR10MB8232.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:33 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::5c) by AM0PR02CA0143.outlook.office365.com
 (2603:10a6:20b:28d::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:31 +0000
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
Date: Wed, 12 Nov 2025 16:48:10 +0100
Subject: [PATCH 07/15] ARM: dts: stm32: Add boot-led for stm32h743i-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-7-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|VI1PR10MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: eafadfad-43f6-4d66-9497-08de2202ef5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WVMwdGkrME9NNE9Ib1Y5SmdKUVRJa24xV0Z0Y1lXSVJuVHpFbHo1VUZmM1NF?=
 =?utf-8?B?Z0lISmxjK2Z3L3NXZGFOYUVEYnhXRERaRkxNbCtHMmxMR3BoSGlsVUdDK3h5?=
 =?utf-8?B?a3k3UnUvcEh5OVNIOVJOckxBQ2lJVGxPR1VyMjhRbEdjYnpSaUQrbUxaNXZj?=
 =?utf-8?B?bHJ0ejFoOFlNUzB3aHozSXRzNEtraDQvWDZ3ZUtCSnkzeDZGaUN5bTdzaCtr?=
 =?utf-8?B?VzR1YzV3VHdnVVk3bDRSYlFWTm92elNBdFRHZWVCdFQwMitkMzQ4YkVkQ2Rq?=
 =?utf-8?B?MXRIc0Y0UVJXRGFhNjgzS0t3cC9PNmw1SXhDd0xjTUswaGVtM2Uwam4xc295?=
 =?utf-8?B?bDBPY2xZZnZxdE5PMytJS0tCZFgwZVZjUnlNb3FXSmU2cW9OYkgyayt3aENr?=
 =?utf-8?B?ZnhrV01jai9LazhrQ2g2YnphbHY2MjVwMlpYNUMrTWVNTHBNd0xJa0NOdGdr?=
 =?utf-8?B?bVV0TWdVbkw2eXFacUNSaVZ5eE4xbWY5VnhmTHNLZ3VDUnNCUDNldlRrWUpy?=
 =?utf-8?B?ejNabGRXVzVRY3k2cEVhdHIzbzhRS0Q1bWQvMC9hbmo4dW1DVSs5QldPdE4y?=
 =?utf-8?B?blZCR21ZYytNRTNlZGdZY2daRWtTT0I3SXpha0czdkNvZFFXVkVrUXRUZFd5?=
 =?utf-8?B?VjVMZllSaXVhNWZkbWsyb1J4VWYwYnJzVmZzYkxpNHZ5RndkMWdPdXdDK0pQ?=
 =?utf-8?B?K0JaVngwVmNjemNTTmFUMCtYQllxZnJTOUgzazBqdWVaWHZrSUhXbnozNzdD?=
 =?utf-8?B?SW5uOUszM1VCNjRIdEczMHdqVlU4U0VzWXBVL3g2NHBDUEJEVGtzTDdHV0F0?=
 =?utf-8?B?NnVTSW54NzJCMUNxckduQ1ovZW5ydkhjci9LR2Z4YnFhNVdNMHdyUkVxeVdt?=
 =?utf-8?B?YUJOZlluWFQ3OWlXT04yK2dGd0lUMXNFR0dTVlozQzFPSGJVTHhvdWlSa1do?=
 =?utf-8?B?OVNHN1JKaWhMNTZqU3d3RVJRRlVTVDRTRGx4d0oyR0pUN1BIeWY3Y0F1aWxn?=
 =?utf-8?B?WjRZZVNHeW1wWStxN3FVSUUyQTVVUEt1ODhMV3AzZldZNjVLMExEWGRDOWVY?=
 =?utf-8?B?RDk1WGVFWkNtK2prZUdabWlrVHFSRU1RVjYvbVBrbUxsa1NiYkd3UEEwRTBn?=
 =?utf-8?B?YkpTd1pVM29qWjIrUGozL3dKZG9GbjNEZlJzS3VCbUpPWi9EWVRnSVJFTTdw?=
 =?utf-8?B?TVFkZUkrVmpreWQvWDdtZmJ4R05SeU4xLzZYZThpL2hKOCttL0pQNS95T09Z?=
 =?utf-8?B?bFJJVFkrUi9uYWIvZ3ZtTzdTMVA0THFBZnNPRlRPZlJnclUycUJpZjVlU3I1?=
 =?utf-8?B?eHcxSG9rUEIzWXpqc1huVDZab0U5RUx2RFRLZ0plYThZdFFxVURnTXd5U001?=
 =?utf-8?B?aEVDbVFXdXltT2VmRmNDbGdWcWlIYUMzVGp2eFZ3V3Q5NXJhby9GalEvTzdU?=
 =?utf-8?B?U3c1Q0dlYllDWlFCUExtazZ1ZEh2SXNMNlFYVFVkTExVcTZFSjhEOWFwVnl0?=
 =?utf-8?B?Tk9ET3E1cjRtNG1mdjRWRWdkU3A5SE1pWHUraFZKanh1QzErYXJrVDVqU1I2?=
 =?utf-8?B?bThxTk1xQUtkSjMrRzRQWGlUc09DWEJ1cHRxNkFwZXNNVVBoOEtlRm8vZWVP?=
 =?utf-8?B?WXd6NHNDNzBMYkZLOFBBVGIreUc1WWtNNGZJMXJVV1BuQkhnYTZqWnhWZkFv?=
 =?utf-8?B?WnIwWngrZ1o2d0VnenFPclBGVmZNWnhVR3hYY2JJL3doL0k4ZDNZWHFoQzY1?=
 =?utf-8?B?YzM2cGhvdjYxNTg5bjhPUFRUM0VoeHc5d1g5V2d3T1RObVdMeDdxcEdiZUpL?=
 =?utf-8?B?Sk03aXpHV0lNa2ZwaU5GTFY1MUpxdmd5NWN5eGZNTktzZW56R3FKZVFkTmI4?=
 =?utf-8?B?UUhIVHJOWThWUFBHMStFTERWdjJIdXdHMjlPNDVoU0Q4VkRncTg0WVRRcGN4?=
 =?utf-8?B?bEVtbnZZU0JuSXB2NXR5YVc5SFZkVXB2ZnN2dW9XaGhXM2I2OTB2VTBPMURN?=
 =?utf-8?B?cFlQdE9STzViREQ4VUZtT0R6TkhiaS9ma3JKMUI4NGNRNVdvMWtzNGNvNFp4?=
 =?utf-8?B?RzlXL0p6NUFUb3AwUTBISS92N2F2a2JzSUhuNitpVVB2ZmJVMmRudEdPWGlp?=
 =?utf-8?Q?z9jM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:33.3591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafadfad-43f6-4d66-9497-08de2202ef5e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8232
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX/I4VbBJeL1Xq
 S7mCcIDUuS9fPPzVPrMRd82EI8xjADDeZVkpH4J/ilAVWzlNciUklWNJym3XKFFKoRxeh2Nbhqp
 JulGaLhT4BcEDabDuxmqwDK1h7aBUBRiIXwr5XAXimanAVaL0/WF6ZFOyewtOeaeGNkICIWBeiN
 no8mdRlXC9tdZwDdXzpYiJYEkaXhrXzZ71w4wqYqCAhzSPDUDTSmKZ2aukSknFcNH4J9A4CTn07
 Ft5fiesHvz5BIJk4MUqfHJvzPS+p6tRNx8U0TrAiyCGmFa7bmy/vSx4mO6Jia7pG0HPGbRdZMnp
 SutG4xIvXJJFGXZBAeyZ7X/WsD6cfoD1b+a74SDA0lEQacjtYTr1KQaC3H1s4Fu2GM3c1GvQBwk
 JEuk5OvzdmCFPfXazBqv2Mkc+cESzg==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=6914ac57 cx=c_pps
 a=nL4jJU91y3sJb0QYIFFgig==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=2zncQlSHK9NLHtoiaqsA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: yssS556Ca8Govo_hMSLo2zk0hg7X9BaW
X-Proofpoint-GUID: yssS556Ca8Govo_hMSLo2zk0hg7X9BaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h743i-disco.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32h743i-disco.dts b/arch/arm/boot/dts/st/stm32h743i-disco.dts
index f20266de4e7f..78d55b77db7c 100644
--- a/arch/arm/boot/dts/st/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-disco.dts
@@ -74,7 +74,7 @@ v3v3: regulator-v3v3 {
 
 	leds {
 		compatible = "gpio-leds";
-		led-green {
+		led_green: led-green {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
@@ -96,6 +96,13 @@ led-blue {
 			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
 		};
 	};
+
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_green>;
+		};
+	};
 };
 
 &clk_hse {

-- 
2.43.0


