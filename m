Return-Path: <linux-kernel+bounces-899707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349F5C589CA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95C2F3BA52A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD822345731;
	Thu, 13 Nov 2025 15:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="afy4HrY6"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D534028D;
	Thu, 13 Nov 2025 15:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049135; cv=fail; b=s0eVs8K26xrfVKTszu7Ay+y8zZKE0sSFRUKrsJC8EpFyIJIDzvFd9m/rUDAQ9fX+A6WDDcQRFPuIE5UtnEhN7o+2NmoPzM038dO8qNQ+aUPiZAQv4ntzUfH7JzPojvZCceE8XlH5lGd9sU8q6hLhkxtqVZdwQlUaejvf9/LpYsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049135; c=relaxed/simple;
	bh=qxs6g7juojlbSokPd8vqij5YNG8MUdgaGyAPYzs3GYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SP5nY3+Bz7HkPT9RqAQ82Fvok3em2qJXMshHq+Ds/naqg3XCJfXzc9nbS82tuq2twnqUXAZFVkWk0pjQltKX4amFHtbXWFCRf+X1O/8XGdLxcpHQGVLMDRwJzd+w6+IirvTSunsMBDXd8Ng6wChZcVHzKw6lpvWKskiLAy+cxwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=afy4HrY6; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF25LY4053904;
	Thu, 13 Nov 2025 16:14:01 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acretdrv3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lDOQweVEsSALHuB5H7+aWs6kcajTCK3HBuPQ64Sp+PZ7g1wFwH3anzww8rrZNwlAJfSkH0VXLGzNAqYC0gArSmH+RNAyVX8GRLuAyv2wrbHOIsdNphjlobv0haVXtpyuP+5yRgDn0k9HJWH85QtrJbwYkjj5UWmhmo7wDirnVFSSTGgqT/GnmdlhN4g4WHxW4OvfU280J+v2hbf/BzkGs6+dZqxS7DoRq/d/1iKfM8HZYGcl/hZ/B6yUjrZEJt54c7UW1l6bBCpcjOdqVnTHI8317NJ/dgv5GutyyPNntOzGKjcvEGYEFHd/sdyqeTa5DhkGq9kMCqT/xbsrzMcVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gim2m4b5zf6C2Y8piAl0HOkUFaYNHMI1fjCw1yiHtDs=;
 b=oVjmRki2sPCRA2g/aWiKGs0SwmpD6LiOlDn2KAB+3D9yNa6KMCK7XcAY5RKtZ1LmrYmroX7bkzB8F+CFJlqZHhcIMdZHNn/xMf5o0lwd+EvK3l0oo8BIRGjkVgk6VTVg1gBaRQId/b+MINfyaeegyLu3qeBhoSHpKvlZkzLQ1aMHHQuWzIIVr4msOvx9BKAlUXrVNa72lCI/ouZbX7V4oRL4+xUHL68UMCr4d499qty9ABXQzVhRztu7tkfVLFP/tSXP2tap2cWTWl3DONjQ7ZijQu7sXHSBbnCXqdYsjV1tFbQQUAvGlfEYHiqX5uxbHdvtjM6rJU6q6NAkvLSPxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gim2m4b5zf6C2Y8piAl0HOkUFaYNHMI1fjCw1yiHtDs=;
 b=afy4HrY6h44xFthLjAaNPSJijEuWaha37cSOmy/He6LMZbI8GC67UIdR7eCSfu5IUSsKC3CO21GuVfabmB+qwjNBCg4QYiaeK/TK3R4t9hma55r0p3UpABtsLT16B1zl3wjQpDp11X7Gk/h05dRSBS+60rfYrO4IVdGfruHZR9FwrbjBBQd4s7hh5aYZFb+9xLP/NunYmDENmaJGdxPcjiwRi4IfSeQzj3euUDwlSE7v7HHnmtn+VvAQNMuYz8GQEaSEtEF2CIAQ3pN6cN4oMDYCPTbFMA0DD25mMvbVan0jeFTuNdSRQ4a5hf19qJ1Y1d9eyNn1lI1GFtjR0FmjyQ==
Received: from AS9PR05CA0331.eurprd05.prod.outlook.com (2603:10a6:20b:490::6)
 by GV1PR10MB9111.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 15:13:57 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:490:cafe::3f) by AS9PR05CA0331.outlook.office365.com
 (2603:10a6:20b:490::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:57 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:09 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:56 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:53 +0100
Subject: [PATCH v2 02/16] ARM: dts: stm32: Update LED nodes for
 stm32429i-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-2-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|GV1PR10MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 07bd8217-d384-4b99-1fd9-08de22c7447f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTRSTGxuVitXeThGNDc3VkpuU01ISGtja2tlb2MwUlJOaWc5S3BqWllIVXFr?=
 =?utf-8?B?eG9ZV2xqOWJidGUwUkpDaWErQ1lmTFdZVVg2UHV6QSthOXQxZGdBMHRFSWg4?=
 =?utf-8?B?RnlOOGNwY2RRdWUrOW5uMTFjTUVmWHhYazB6QUJvbjRuaUorOGNEZjAwWk8r?=
 =?utf-8?B?LzlaTlZnaWVnQ1hzYlJ5R3h6N0kzRUlsTklSdTlNRW5YK2ZMb3AwK2dCaDV6?=
 =?utf-8?B?clJ3cndKTHVFbG0zTVR6aVhYaFFoZWVSL0RnbjhiZ1grZFNwbGJFekpIclo4?=
 =?utf-8?B?Tnp5dHl4TFpVMHdZQmRGZE1wb2U4MGNackhBL2VTWmpNVExVNitqc2x3VmF4?=
 =?utf-8?B?SzhuaHQybkpNQWJsVXVZWjZOeVJRdGVVMWdJclZhNjF6WGN5R3RtRFRvck9G?=
 =?utf-8?B?Y1lGYm96M0VNZE15TFRxanU1VndxYXpVWlN6cStlRkMrNTlnNkNrZFBncWg5?=
 =?utf-8?B?RG5WNitLcERGMWY3Q2tZbkdJUnVlYUkrVlJ3SkFIdC81dTd0eW04V0xXVFZM?=
 =?utf-8?B?VFRFTHR4a2ppb3MwNHdiTVljeG8ySG8yWUJKNjdFTUljeWdKQnpBNDE5ektI?=
 =?utf-8?B?LzFRUFRTNThQZmlKRHhJK28rb1UvM1dhZE9QbDk4UEVOU3BBZU9IMVFzeHlT?=
 =?utf-8?B?cnVBVXE5emlwTUI4SzNHTWNSTXRrYkYvOHBBdWMycytKMk8rekIreitCZ0NJ?=
 =?utf-8?B?b3lzWFhybzh1b2RNY3VvZW16azBZZmR0Wkd1aG11c0dRR0h4Q0s3OHRCbXNS?=
 =?utf-8?B?ZEVKd0ZkakQ1N1JnRytDTDc1aHo1ekt5YzFHTnY2NUxqNHZURUlWOXYxVkEx?=
 =?utf-8?B?T3Y5dmdMbFRjOEx6QnZkR2haNjcxcGxYekZXT0dMd3lDK1VzNEtpeGRlUUV5?=
 =?utf-8?B?QTJWelZIcjlBdkEweGNja1Nqc0VUclJFTlROY3hLT0R1cFJ4UU5qVk5wYTR1?=
 =?utf-8?B?TmY3UGx4WGdYdFJIR1JDWDF0bldYNHkvVk1Ybm41VS9TL3ExWGNMbFR5bTNE?=
 =?utf-8?B?L3VJUkxjaDBXUG5Rd0htNTB3Q1FmeXAvSDNnUVpaMFgya2xuamFacTltbFNL?=
 =?utf-8?B?K1FXRVBYdjYyelZXblQrVG04MnkvSmF5NUlvL2VKTWUwbkNweGhGUjZMRnVp?=
 =?utf-8?B?U0wxNUxrWFNMS3ZkWE5Zdk9zTmYzRXhxNDZnUHgzZ1JJejREaXIzU1JUQkZn?=
 =?utf-8?B?bEtYMm96S1QvQkkvd1dhRTVSQjhkQWtvRTFIMnNrdkVMRVRNTW1kVUQ5QXg4?=
 =?utf-8?B?RWJtQnljeU1tbWdtNnZVTzJ3V0JzK3B5UXNZc1ZxTjU0Mng3RFhSM1lFQm90?=
 =?utf-8?B?VXh1ZnBxRUVDcC81cThwS09Gc3A5WTFlYjBNZFI2Z3lzeWJXeEZJNnFsREFD?=
 =?utf-8?B?TXdvTWZNOTZUblFVakpkcStWdHBOcjZIbWJLclRpNkZpK29LZzVVSUZtaTVu?=
 =?utf-8?B?eW1WeVhkUEdwY0hCMUZ6Z0dqK1UvNENTOEszZDRkbHFTSVczL1pvOHVUZnFv?=
 =?utf-8?B?bXBSajF3dUxGZFlERTF4ajUxY1pPaTZua284RXNIRzBuYjlxdHJNQ1FwT0Fr?=
 =?utf-8?B?clk2MW9oMFZzZmZ5QmdBNmdmOWd3OGU1U2s1QXl4VmFtZkNPbVNHWlVUSDhq?=
 =?utf-8?B?UytOWXJ1emx1QnM5MTdOWm00VWNYbDhBWUFTK2ZvZ1hBNW5sbThGOFdJbmJq?=
 =?utf-8?B?eU04dTlac1M2anl6enZqbXZBNnVINXlJOHRsSXd2b2ZnaUdXWmpIb0YwTXVS?=
 =?utf-8?B?c0JDcXVTQ2RUN1FUQ25TMXNxdG42eHdTRXgvYU9taG1mRGkvTVB5ZUJOR2ZU?=
 =?utf-8?B?REcyODFyTzQ2aVNsdU0xRUozR0lFMmNmdURjc3RxdFpBdGFVcGY3aDNzZENO?=
 =?utf-8?B?d1JqWjBNZkE0ZFVBc29MNEEwOXYvQ3pzS2RqQlVMZTMrckVRT1Q4ZENCTWRi?=
 =?utf-8?B?b3l4RkpCcDMrWkN4eGhXNXhDR1lEZi85anhCTUV4c1hJVEgyWUVjNTdUUk5B?=
 =?utf-8?B?Yi9qd04zL00rRFJDY20vYWs5QlM4K29HNXRwU3kxQ1FXVXFkZFEzS204YXdM?=
 =?utf-8?B?b3dWSDA2UTRxc0doRHk4bGY0T2pCZlRTN1VxSUJZRnN4SCtkU1ZKOTZLQ2RU?=
 =?utf-8?Q?kDjs=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:57.5469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bd8217-d384-4b99-1fd9-08de22c7447f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9111
X-Proofpoint-GUID: h6Ag_PhAx6ZXIBA200Z_T3cNvd-aT41R
X-Proofpoint-ORIG-GUID: h6Ag_PhAx6ZXIBA200Z_T3cNvd-aT41R
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=6915f5b9 cx=c_pps
 a=LyJHBR+ct1ioTm2L5dn97w==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=NfShEiaLPU-5VWSYspEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX6ooUU0rEfXKl
 G0NLg0km3JsP0z/3duVy1S1Mx3hxdPY0TYTQQHT2PQtcoh6lWzT0d9yBbOCL0ypwzM4L/gZV9Au
 s1AL8mKsJRwfjmt4Et129dfVHXeMBl0NuyzXq0640IZCcXmDStc+vVN/wKmV8aXUNZCkl+UKNXD
 6e8YF7lUUnGo4tglyzlVs6ACo/goVu1MQuRDYfDSAN20VT0h5gc5Kbiw/A3//o8JgVOf1YoGRiL
 GaPf7TdH6lUeyudi7AZ4kodTU6865GWp/0HnZJSbrCLFI275QDsWSqh0KXT1+RPBviiSkefjCA1
 /pM9Oa42106mEFFa95pQVnhl0Z/dvfT8aEgtibyiB/LrHITURicRwXXlNo8bvfh+9n8iIZVoaJ2
 fKTxNdqYGusZwuZpked9Ucxe2wS2SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add function porperty for led-green node.
Add LED color property for LED nodes.
Reorder include dt-bindings.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32429i-eval.dts | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32429i-eval.dts b/arch/arm/boot/dts/st/stm32429i-eval.dts
index 6ce8d7e5565a..a138c0ac8e77 100644
--- a/arch/arm/boot/dts/st/stm32429i-eval.dts
+++ b/arch/arm/boot/dts/st/stm32429i-eval.dts
@@ -48,8 +48,9 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
-#include <dt-bindings/input/input.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/media/video-interfaces.h>
 
 / {
@@ -85,16 +86,21 @@ soc {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 6 1>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&gpiog 7 1>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiog 10 1>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpiog 12 1>;
 		};
 	};

-- 
2.43.0


