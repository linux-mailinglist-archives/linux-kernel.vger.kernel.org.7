Return-Path: <linux-kernel+bounces-809720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BE1B51125
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12E077A5899
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2813230F819;
	Wed, 10 Sep 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="xziXOEZY";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="M/VlOCM8"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4F92C21F8;
	Wed, 10 Sep 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492723; cv=fail; b=C9SDMNjyZPXYVGk/XqwzRaxEV/xNh81bacyraHLSAF/RhS3Smzchp2OvCMGePYxt49Spmo+tITsTU/gbegkhc4BxXNmz21aQZDMLQhI1w9LUWan+iKaPRRvHnthu09ZmPpRTLg0fo7x+F2biymOLkKy6uqQgqexCLQroOIqoa+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492723; c=relaxed/simple;
	bh=iqSesTGFZFchfRK5zQmviEDcGF9ULHZ9XnHCqGGSRMA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Dmn8CIR94yat0mivuN82VMhIJOPeRYJ5Etk15vM0Rl5UFjjo3SfrqbPZdF69F1aZupenqcCWNoLBBtymdul6d4Tgqxa/aPpCZl8TQDfyuEKlF8Y1tK9oo1A1IaELUYVhI1aUXKquONH+pU/bI57OVJ6NxHP+plEhIGHIGJsYDgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=xziXOEZY; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=M/VlOCM8; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8IJFU026976;
	Wed, 10 Sep 2025 10:24:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=LpTcNc20zr0aAwXpNuu4ce
	IzWNLZ8oCKSRF8G7W1AYE=; b=xziXOEZYXFamd41qgN1+uFXY15IuY44eaJxqMP
	wzHcgc0G46yzb+mkyk6nGRZRPUThaxd5LsrKStxde6m2NnCSuioMmmTlm2OwUgJX
	yWWpiw0m4vmO0LfP4gnrzkvcmhZk9bp84gwnq/Ti3zz+HsZEL1BcOL5kFnbYwxwZ
	L0Rdrrs+uQKpB76EvCU25GFIq8tlvFQ3zWYulPPFxDZfnqc+HHJoMtqiAzdqTd2Z
	VMVkpvOJRSc5stWx8xXZWShU/uwJqKhKufdgBob4K2LB4RCnWmNe4ki06I5bKjgf
	Srt69/APxHUyTiGIhrwFR1VTDFl2y0XZRjTa09/p97qUsSBg==
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4929f0x8yp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:24:59 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKBq+YEnw6iz6jItbfV6gFZDsZnyOb+HbAOxapSknlEpaUFTsXjjhqBvyLAG6tqi8NkYcbvDYZhhzCAKzRHZL/vwFLbq++ec0XwsfFv0/f3rAn2jT0sX+M8xa+qM2OOKVqXN/kioQTiH0sg/s3g44Q4Qb9nVQzphKFG4pjyvfFjW+TT61ISCT7dli7AuOCml9Fy0pnS/wFsIsQRhzmFUgnwVlw2Z/YYBvut6mVlgiUB4UE6kPAdoOutaVCauQqV4c3egpb7GYwEn1J9s+KoKv/4QdKRuj7xpS8B4r3XY3V1EEltjclftnME/vaAg0HIrtrN4K0sZlVdGfOpLND5XxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpTcNc20zr0aAwXpNuu4ceIzWNLZ8oCKSRF8G7W1AYE=;
 b=BggJapFqdSvk6l/7ci7kuVC+AbYaf9gcN5IlSFQzPC3x80wzCA4M5gqAaapkskfoNI5xtb20IyaNQxCmsiviRRHWNDIa3d31tojdAWxAnRbvcbNGB9yd17YrbxHFAcx8sq0Ya+KwNYzqdVuUWmO4EluS7VnTuEQaH6B/18egtmV3bHFdXrlENE3rVCWZMHTwaCwI9XFcB5aH3TQ4gX0fkWMtPiNj0odvc0K0FTu59c4l3ejT03z+YXujHVJATus/VD2+84l7hJuwmUmIyfcrDR03xXjwSQPqlRmetpdkFC6EXmUZP331OAkVfbJc2ck+bF4wW0gG495srxBGeD/rPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpTcNc20zr0aAwXpNuu4ceIzWNLZ8oCKSRF8G7W1AYE=;
 b=M/VlOCM8UIWECE/rhc7Yu4TB8TFZJvtql1ssq5xnzuEJI1phhc707S0H6GQ3qvP7WsFoZsMbBuADd5Tk5oQyNr8XZ2yeEsPu6WKfiNc4IlhG35pFfCQaQUH57XIntSA2yhQlifAu36d1ivwMFFjj+vGpNJOu5EOV2Faca1OGBb0=
Received: from CWLP265CA0311.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::35)
 by PA4PR10MB5538.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:24:51 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:401:5d:cafe::ab) by CWLP265CA0311.outlook.office365.com
 (2603:10a6:401:5d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 08:24:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:24:51 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:22:30 +0200
Received: from localhost (10.252.15.61) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:24:50 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Subject: [PATCH v2 0/2] arm64: dts: st: Couple of updates for STM32MP23
Date: Wed, 10 Sep 2025 10:24:36 +0200
Message-ID: <20250910-stm32mp231_gpio_update-v2-0-8510efa2c5cf@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMQ1wWgC/4WNTQqDMBBGryJZN5Ifg7Sr3qOI2HHUWWhCJg0t4
 t2beoEu34PvfbtgjIQsbtUuImZi8lsBc6kELMM2o6SxsDDKOHVVjeS0WrMGY3U/B/L9K4xDQtk
 6pwCbBkFZUcYh4kTvM/zoCi/EycfP+ZP1z/5NZi21fAK0zmoYlcL75JlrTjX4VXTHcXwBt1LfJ
 r4AAAA=
X-Change-ID: 20250904-stm32mp231_gpio_update-7550ce44ec03
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|PA4PR10MB5538:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea9b814-ca6f-4d3c-1915-08ddf043833d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXdOZjBRSmVBM1pidlpZcy96N0VBWVQ2cUpqUTk1Z1gwTHVETDlaNVBvWG1n?=
 =?utf-8?B?VUVCY0dRSjdnNWZYclZrQ3RyYXdoSkI5anFjeWdBSlJFK2RkYm1BNWhkQmMz?=
 =?utf-8?B?SkphS0ovUmdJZGppUXgvUGUyZnZqaVBVaVRYMHMwOVlUWitQdlUzSVJiWGk2?=
 =?utf-8?B?LzJpN0xicTBXMlh4NlVkUG5iQS9UaW9TYTM4MFFxNFdxZUhEU0J1UGRYTkpX?=
 =?utf-8?B?NW5sTmRUY0RQU094RHZyL3hrMzlVdms2cjdnd2l5am9JREMwbllDTlgrSmNn?=
 =?utf-8?B?MWt3bVJQWWtvS2J0NjU2eHpYSVBUaGg5eTRURk95cVB1OTdyczV2dE8xVUl0?=
 =?utf-8?B?S1dnQXhyMHQ2YWQ1dXBMVTIvd1B0MVhjWk5VQzBPMHNQRFRuWXNTQkJWOXo3?=
 =?utf-8?B?NUJFN3p6M0FtM2hWWGpnNDJycGFLMDF3cFJJQTFCQ3RzUDhBbTB0S3lUYk5w?=
 =?utf-8?B?SXcvQkFwaTJhY29GTUZHaGZ0UkhqMzNDQ2pEeE00VXRxQmdOdFNwbEZhc3NU?=
 =?utf-8?B?ZGNNSDEzT1BRdkxJUzBxdzRSdXhHbkRZZG9Yb1JxQk9zVDVqSFZMNS9JM3ZG?=
 =?utf-8?B?TTZRQ2dQaDZ5RTJQUEhOdVVFOVBNejV3aFV5REJWMVdiYnREN1F1VW5qbEdD?=
 =?utf-8?B?KzlnTDIxUWdHWkJ1M3NlMW1BOHNZcDRnTUFYbDlGL0NDSlViSDRTeUhSZXZM?=
 =?utf-8?B?YjZXbE9zNW4wUksyN256Ymo2ODliWTFqTitpMi90STJYZUVOb2YvQzNBS1p1?=
 =?utf-8?B?SG9mWmlSY20vYW9SNUhqbUMzTFV1cWJKYU1XNHF0djZSWUt6dDk2SWNHenIw?=
 =?utf-8?B?YURySVMvWTNSN3ZxeDR0UWJId3Ezd3VqV0cyY1ptMFFVT0FuOElmb3kxYVl3?=
 =?utf-8?B?Yk50aitQK2haeW5wdXNNKzZqNkd6UlBHdnhmMUhHRDNlTEFUdDQ1OHpoWEx3?=
 =?utf-8?B?amc5UDhYT2VXQjVmNzhpUkhzVkU2WkppYUNtbHdQbE1DcXRKMjlERWZleEJX?=
 =?utf-8?B?R2VjRWZNYlRKa3lvZmN6OHQrQ3lPVWd5amczaldKbUl2NzdLZkx2bWJMQTl6?=
 =?utf-8?B?MVd0U0lub2FyN3pnTFF6cFBaYmZSUlc2SGYrMzcyeGloeVF6VFJ6V3hLem5x?=
 =?utf-8?B?dkF1NGdGd2ZMNDU3M2hvL3FJT25WbklxNmJtVnpSUzVLUFg3VEZNUkFXUEtt?=
 =?utf-8?B?K3owWG5iRlZraTlQRGZHSFRsS1BhbXZ0dW1ialZ6WmdQUWVCa0lvcjRQL2l2?=
 =?utf-8?B?ZXN0czF3eUh0TlZQcGpHQlcwTk5kcSsydE5LOXltRnkzV3pzT01hSVdYQlM3?=
 =?utf-8?B?bi9OUlBGUFZxcStDRzlSQmYvQnk3a21CeDJxMEtyTWZNYWorbzQ5VjlsRE5p?=
 =?utf-8?B?QThvOUpWWVBSYi91K2hMMk13Q0o1ZW1nalJQLzRlT3pZRmlwN2gwYnNyVTF5?=
 =?utf-8?B?Tmk0UExieFRrYmpUQ1N3bXhLcWZYZ1pnQTVnOWMxa2xJdVFmNmJSM0owKzIz?=
 =?utf-8?B?MDdaa3pLdTRDQjB0RWJyc3ZueENOVjlCMTFybklEa0dxVUhYMldDM0Evc3Zi?=
 =?utf-8?B?QW1OMGw1cllDdGRKM2FTc29udE1waXA0OU8reENaRlNRTWtiSUVFZHBVRC9I?=
 =?utf-8?B?V05yN2c4UmcwWW5ERU8wUzVFTDlwVzVWN0ZienpqcTV2L3BWaWs2R2l0bXRT?=
 =?utf-8?B?ampsOHpleW9zRWNCbStOY0NBVHF3eFZlc1BiUkwrZWRXdHFrWndoQ3NpcXRD?=
 =?utf-8?B?cmVWdi9hNWR3dnpZUkIwUU0yN005OCtWbERWZ2tSSE5NRGZJZy9kdXZRalZ3?=
 =?utf-8?B?c3pEMDNzeHdwQkpDU2VESTdiWVFES0V0U3QyYUc5ajdQakZJUUgyZVZGNlRj?=
 =?utf-8?B?clFNb01PMG9BR2EzOWlOS09lNWlWSkh5bDNFZjdDdzJjdGVmYWhUQjdpRXBy?=
 =?utf-8?B?M1UvcmNRek9YWHBYQWR2QVFtS0tMeTZFM0RkVE5LMXpXdnUzaGh1NzNEQWFx?=
 =?utf-8?B?NmcwSFF1a0lGZ29xUFJZRTZack5iMWNMTkFaT0FTejVHaC9raWs1UktuNmsv?=
 =?utf-8?Q?cg/+qX?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:24:51.0877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea9b814-ca6f-4d3c-1915-08ddf043833d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5538
X-Authority-Analysis: v=2.4 cv=MrlS63ae c=1 sm=1 tr=0 ts=68c135db cx=c_pps a=7NAaTQ08Iu+netfH3uu5eA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ifg0f1jqALsA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=bbfWk0yqAbS-qEUU6UcA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: m3ISaZtT_7q9CAf3bGjB7Rfbn36BKa7l
X-Proofpoint-ORIG-GUID: m3ISaZtT_7q9CAf3bGjB7Rfbn36BKa7l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDAwMCBTYWx0ZWRfX6C2BUkSS+rKd Z3nP63y9iTBYFOQtuNhMzFGlNn5+hoe/eAma8lk6MQz90YDMQNuQout7X1G1CwLXIVe6HY93UNm vn0Yb8jMWQvkk8K7tCtIXRtdXwoociMg/Ktcr0ofi6Gml7ig+suz57JcrmqJvhYxn7i5CN0i0rl
 CaDDrTkvi7pOftStBlWBOywJF7+XAdBxLM1fg3otrvym4XdcgEyfNovZtpEFc0V8IktXUdEntNT qe9BxbYKEt7Sv4QxjNREAVqnCneqvOdttHP6s1hx2X+qVqJHUDB5YCBhHl3BO2ljYB1GLxZ0apu +ISZ5NCS2qz3gn+MeJecFq4hdML8U7RqHU06c8JKuVT5yGTRH243GUtZ5e+fT3taNsCf5wOEYoB T/akgPUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509090000

Remove gpioj and gpiok nodes, as J and K banks are unavailable
on STM32MP23x packages and resize memory on stm32mp235f-dk
because DDR controller control pin is not routed, so it is not
possible to configure 4GB/16-bit.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Typo fixed in first commit message
- Second patch added to fix memory size on stm32mp235f-dk
- Link to v1: https://lore.kernel.org/r/20250904-stm32mp231_gpio_update-v1-1-bcc7531cd00e@foss.st.com

---
Amelie Delaunay (2):
      arm64: dts: st: remove gpioj and gpiok banks from stm32mp231
      arm64: dts: st: fix memory region size on stm32mp235f-dk

 arch/arm64/boot/dts/st/stm32mp231.dtsi    | 22 ----------------------
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts |  2 +-
 2 files changed, 1 insertion(+), 23 deletions(-)
---
base-commit: 6d40d5ecf683e31a5e204d0a2f57035c39fc9c5f
change-id: 20250904-stm32mp231_gpio_update-7550ce44ec03

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


