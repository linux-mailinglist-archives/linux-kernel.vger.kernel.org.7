Return-Path: <linux-kernel+bounces-823155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8199CB85AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 17:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FB1E3B6DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D8311C33;
	Thu, 18 Sep 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DjvXZQFs"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ECA30E0D0;
	Thu, 18 Sep 2025 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758209758; cv=fail; b=l6hCcbyPNuSDPgOqMEfugNDW5/Kg9E8y2fEAeI1COg4si/R1+JIz1ktD7ZTYyhhd/XBll5/cyaOrpIQfOljGn9jiJ2dAHcDh/OdRusCBrsR/r8MlZFottf1AKbIS7oeYjbT0qwVJRvpCC52oPgY+5mYMiFL0UsyKsd6T4PuDmaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758209758; c=relaxed/simple;
	bh=wDWYoiW/2mL+ffC8tCs7w2hyRn6yGVVPwkjK/jqNpuI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=KKbadLv0umtxp50nKXZ6qPSxMYzTTxAtCZaJIvKgRJCV4d4h8D8SOum+tn3suPuvz+7u7uGbgfZzfeZRhGdLU2kkqRKuHv32nzVMomSwbyYDUtLbW056KSxMV36rh7GkUBPdmLFJJjNussTXoXVNeuhMj48yfIic/xnS0UkYERo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DjvXZQFs; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IFVDpb029199;
	Thu, 18 Sep 2025 17:35:47 +0200
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010018.outbound.protection.outlook.com [52.101.69.18])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxd1c4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 17:35:47 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkfhHwROfIbdRXVlDiPwKDO1e/m278G6rKbSrooW/UmJv6qqzp68Rpxlfus8sMxblbk7wmzn1hKVZKthQroKSKtdtXm9+2LvCJKv+mSu2GEC/H7ZOsR+GDScB8EldEqIVoW/uH2H4fNJzU0awq5vvZCvSsrnxNb5j7q1Xw+CmTVtsV1HyXArbPQzBwoaHBB0SRf/zBfQ22L+UvS7xVNgAW1IdK06Pp793g/gYZFFGQ/1XqIMVrhtGAcuhGNCX7JSCf0Le0CvSWIS7PHL17/y7FJ0tKMOL9DL/DAZOBnbWyZyYxm4WBFKKO0+WAEgCfqr07nNhk03K1IB8Zqfn8n2Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EtKlGamaSDbytLpeeR+EWlDN5yg3jOEiruDCysfj+w=;
 b=NZc72RS0XhoOLOYAcrPzsD4E8E7NAvRZbs7RSIaCPG6+R0BBVze8WhBq6EPMoJzsELJgf4QjFeP1gzh8DjNNpOAKDLZuuWS8REoNItoHoj8AGagX3BH676DJ2CovayePqF6in9xe8+mzw9cW+0GU/0qXmGU7zwHr8hgHEe5VfvPBmbvaeC3oAUH8pqNfWFg26Ck/mYowh09dzoH1EBwAG1fp9d9CmTFEEWNE7qtZ7reymEdqKLqQvBWHsMi1onZobgcwWhFN5ZN5DHGo+LwPbq924ZKtn951hGao4p5CKh1lp5fA7cAdF+twqWDvCU8R2pDP+EJOGcQseVSHiI1SBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EtKlGamaSDbytLpeeR+EWlDN5yg3jOEiruDCysfj+w=;
 b=DjvXZQFsTYUa3Cux6xxmrPbbg8NjhTpx7imJ2/xM9CS/NJ49Ro5l/39hmS00HuDnBlQvFcOPDkkNGilwT0oLJwfEOsxsJMjdwlBPpWHEPolChmWaQis28fqFGIevCa6PVJfOa7k8l4rlPbh4qKhw7Bo046w31aCT24Yy7SzfquEpjDnRPKTzq8qkb9R2pRyGbHY9a4y4wGDhEecglI5e3snLYT6XSDaQ9DaUp9w3ScKcOwMv+AuCJhCLdbtRHtdrQj0rzEOaaD6xQOsph4X4cDSFkwEFnRrvydb8WWVVcFcmsPoMUaqrTkrJRGiA6kN6AQilKst3tlVbpC0LyuJkQg==
Received: from DU2PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:10:232::10)
 by DB8PR10MB3626.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 15:35:44 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::ee) by DU2PR04CA0065.outlook.office365.com
 (2603:10a6:10:232::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 15:35:44 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 15:35:43 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:28:40 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 18 Sep
 2025 17:35:43 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH 0/4] ARM: dts: stm32: watchdog updates on stm32mp13x
 platforms
Date: Thu, 18 Sep 2025 17:35:37 +0200
Message-ID: <20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMkmzGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0ML3czylHRDXYM089REQ1NTQ2PTVCWg2oKi1LTMCrA50bG1tQD11+6
 mVwAAAA==
X-Change-ID: 20250918-iwdg1-0f7ea155135e
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|DB8PR10MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: a1ba49cd-f22c-47e8-9687-08ddf6c9080f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFdEc3lZVzZ0R042T0RYdGcrNTdmd2lQZHlGODdPckdKNjB5WmJyNHZHcS8w?=
 =?utf-8?B?czh1cWNaNHVuRDBHNUNxR0lLKzNvV1BvYzZFV2xzd1I2T3lnK3VsWmRka2hh?=
 =?utf-8?B?TUVCb05IUHovaGsyeTFDWlZocEN3dGg0cWdudlRKTTBHZWRkQ0xES1p5Y3lx?=
 =?utf-8?B?N0dQMjUzd3czUHlSSnpYa3FqVDd1ZE5uaG1odXU4VXhBdWlIMmhUbXIyNGM4?=
 =?utf-8?B?SFFBVUl1ZGFsUlVpVWRSdlhEZFpTVHZlV0p4VGI3S3loNjNaNHZBM3pmSjAy?=
 =?utf-8?B?NENIblRFc29OOGVzMlVESmZsY2xiV0pPdWx5b1Y5Yi9vSFRBVTZ0MGVDQXFl?=
 =?utf-8?B?a3Q4Q2twa1pSeGtxS3pHWm9TSHJ5VmsrMi9ySUtPV24xeHl5aDRVUzdvV0Nj?=
 =?utf-8?B?Z1g2VjNPU29tZzI3ekhsdHdPTzF6ek9HUVd2d1dGRFRWKzk2ckxXQVJFUzZL?=
 =?utf-8?B?VGszUjA4VnhtaGIzYkpxY3p1ckNjWWtFU0dXTXI0YnpkeDEyaTNCV3ZyRkQ4?=
 =?utf-8?B?MDlrZUdKQnFHcVdZL1R5UGZMWU5FMFg5TW1tN1B5QXdJTCtGWVdpWWZsL3M0?=
 =?utf-8?B?R3djb0pPN2VweDVDMk4vSXZnNUtRMzZabXZtQ3FrM3kxRm5wcG1KcS9qUUJJ?=
 =?utf-8?B?ZjdhWkdsZ0JIVjl6aVFFcjQvTXFqRi9BLy9ibEtvSDU5cE9vc05HWURWS2R3?=
 =?utf-8?B?UC9DdEVlUFRuRThOSGozSkhVU016eDdPbC9KNnUxSUQ2L0RVU1VwNWZwVkt2?=
 =?utf-8?B?bUdvNzVncWNRUUc5eENZYlVFS2JWWHVvMVc0b1hsNDFtQ0J0enNKb2t4d1Zz?=
 =?utf-8?B?RWt5K1cyN0J2eVpKQlY4bzlnRnI2azlvbFRJcVhqZ3dFSFdiVTY2akNNZG5n?=
 =?utf-8?B?V0FLQ2hJVTRvQTZHaC9lWHQzd1hGZXBMZVdXUVRQUnVqcmpoSExySEM2UXZu?=
 =?utf-8?B?RnlOMlNpNTZnU3R0Z1NkRzVmSnQyZUMxelIxUGFpR3VreStwV3F3dmRFNU1m?=
 =?utf-8?B?MEg4a252cUF2ZlltODY4aDV2cFpheWpjOUx1Y1VCMnVaNlZBNnpnc2hnQkpj?=
 =?utf-8?B?RVFpMHBDSXZBbWZxQUcwWWNYTVdlSVVWVGdObG01WU52bmd3eDlNelhLUTlM?=
 =?utf-8?B?YVI5WHl3bXMvN1VpdHJ3UzdIc3M1UWw0c0NuUWFUVTNaVGZhemY2ZUtUK0ZZ?=
 =?utf-8?B?YlNvbFcvZThUZmJhK01qZDNqRmxGQXNxdjN0TGpHRERYMkJ4ZXBsYlZSTUUy?=
 =?utf-8?B?c0hpd0k0b0JoM21FQkFHelJlM0dPLzRRZFFoMlUvL2pKektuSldBNTlzczBa?=
 =?utf-8?B?QjZVT3lNdTRxaGdoNW5wcnp5aGswVDJKQittaVFkVXRES2UwR2JmUmloZjU2?=
 =?utf-8?B?eVhHL2VRendLNmJ0R3hKbGdjUktzYmd5VTNBK2lJZmNBUE1xdFdOOUduOEJ6?=
 =?utf-8?B?bUFTY2UyNmpOUlZWeHM4K29odExmSzAzb1VzMEd6YzJob3dkNWk0R0w5QjJ6?=
 =?utf-8?B?dk11NTZsWU15WlFZVTFNVmtqMXNQWUo5SUI3VWlCK2hQcjRJc3Q2TTBWaFQx?=
 =?utf-8?B?NVd5SkprMlViWlJoVktDUktYTWZjUllPUlJRT2F5aWxneFZvNTBZWGtkUUZ5?=
 =?utf-8?B?VC9uVU9UZWhPQVJpK0ZnalpGc1NYZmRRL2pWRURRVUFFSkpQRmQwVzBvZWpz?=
 =?utf-8?B?bEFuREZacTZUQWtGRHQrVmF3anFNVHZsZlRWODJQaHh2SlYxTUlBVUxtcHIv?=
 =?utf-8?B?MTNRejRLMDVQeUJGUklzZDMrUnJSaEt6OW5mZUJqenBReXROcjZ5ZXlJOUNM?=
 =?utf-8?B?d1hXbjJvMGZ3dmNZd2NBZ2s4RzVjRllKRlZuaHZsY3BubHoyRzByTGlrcUNU?=
 =?utf-8?B?cGVqQkE1U3daT2d4VDl4ZzcvVGYzcXZRdEtPNDRKYWxzRDBiTEwrbHVUUk1l?=
 =?utf-8?B?WHZHOXUrK0tsQ3VHWitSSTIrRGVqSE5vMzkwYzRvV0Z0Vm1GVStmOVFiTkVp?=
 =?utf-8?B?NVB4NjVtT2ZsY2ZqL0ZYSUFRcGRxLzVoam9OYVZOcVYwLyt1MC9XMlhDVTdr?=
 =?utf-8?Q?Uxm2gS?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 15:35:43.9378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ba49cd-f22c-47e8-9687-08ddf6c9080f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3626
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX3TfWPfVCTU+i 2S1CIsoTkmvoHdyvX45CAhz+hpae4dlWUgeuPqkkZDiSEs6N4CCpUalf2nrUNqCv2heXquocLLn 1tni+NZr/H843dyEoJnXg+p4hqQGzSXVeqMlza+TF3zfqxzPVmD03eUDYBGDD4jrN64YEqMKUup
 ZMGjnqbYjdY0FBynNMWWFwxImcBGl7xZwWhqb3ywWxucobAUWeLfVaoknLos+0wWJj0DsABDtLT iVwwOlwrEaEir2qVgw//vRJ7Uqwv7fpq4fP/wOWCQ3btQZGNDqa/bJh/K4VrqTYtSOuAZxteZE8 76ulMlnE6PXuLyyjPOZQ72nSgxocw2Emyd1HzjbhNdSKN1nFhSU1Qtyx7/VLuXWwGAfUnUoFr5+ s2d0mOm/
X-Proofpoint-ORIG-GUID: QuJxBmOR2BASm8IXA0jzNSHgC5NhQ5Gu
X-Authority-Analysis: v=2.4 cv=XPQwSRhE c=1 sm=1 tr=0 ts=68cc26d3 cx=c_pps a=4dgOkCfxDmvKyApMK2ikSA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8 a=d0MjoUQ0B-Ieqs7PGqsA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: QuJxBmOR2BASm8IXA0jzNSHgC5NhQ5Gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

The IWDG1 can be used to monitor the Cortex-A7's activity on stm32mp13x
SoCs. Add the IWDG1 node in the stm32mp131.dtsi SoC device tree file
in case this peripheral is configured as non-secure and managed by the
Linux kernel.

Add the arm_wdt node in the stm32mp131.dtsi SoC device tree file in
case the ARM SMC watchdog driver is necessary to interact with the
platform watchdog (e.g: the IWDG1 is configured as secure).

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Gatien Chevallier (4):
      ARM: dts: stm32: add iwdg1 node in stm32mp131.dtsi
      ARM: dts: stm32: add the ARM SMC watchdog in stm32mp131.dtsi
      ARM: dts: stm32: enable the ARM SMC watchdog node in stm32mp135f-dk
      ARM: dts: stm32: add the IWDG2 interrupt line in stm32mp131.dtsi

 arch/arm/boot/dts/st/stm32mp131.dtsi    | 16 ++++++++++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts |  5 +++++
 2 files changed, 21 insertions(+)
---
base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
change-id: 20250918-iwdg1-0f7ea155135e

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


