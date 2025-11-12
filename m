Return-Path: <linux-kernel+bounces-897434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAA7C52E26
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2304507D2D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B55D3451D5;
	Wed, 12 Nov 2025 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="lr9Vr2F7"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98333CEAA;
	Wed, 12 Nov 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958453; cv=fail; b=a2zGv2CDObdkq1AhnlNRaUDcZgEgHD6wO7G11eODX00Aprhoun/cyt9IyOWDU7NoO51Pxr/Qyjn8XohWLkvppImw15KnMSAz3ttfclbXTlhou4JohonItipCBskZWgBj/l353YBT3VOl65ckMqmBYsDCS4QpU+7GqCQtalL/koA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958453; c=relaxed/simple;
	bh=Wg2uvUCuKBCprCnD7LCic95+r0QdJFecCTaVmgJDK0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=FYb0087yPlZf5PxKp8IroAPN6gWjGnalYSfswuSO2wBoYiI3P9FeaW5fUkT1a64vABicJpF+tkqsguWVrcTVbDUJq0tVqeeTYbTMjYnh5wGRD8DRC7pNH4DgshqzpSIr2LVe0p2f/U6L2nv3pQNeVPkStjbxHN24gMWKD/rq/Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=lr9Vr2F7; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEZaTh969844;
	Wed, 12 Nov 2025 15:40:39 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu1043-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckidDu/pcYSYRMJd4FdncUxPNKHv/3YMJKkDw4DsmQyryoTN3H953v0Acso/6o0YlfcJ0/cuM7rns2hWKBVfQxo7/ro4D0OhYKNo6eG0jPdV6o8vjgCG6PMh1rAQRFHdOGMc849HRXZK/5QiFe0UGSJF6PuITCVoVyDjknlYYgT2FmG0xbTniTqmqeMt+thwue8BqqT27knOxO9lCRVLKW0j/5poEa0GdBEN70z3Ug0Jj1lyYDQqaJzn+dLMBH+pBsMRd75WxmBGoUMH2m9pdLgvFGK7e2G8p3QzH+oNsazeB7uBIumVJjvbMZxJnRpx1d7c7YIe78uEv9sOwSOWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8NlQdfXcveEtcPLAuB+E6YLR/5Ij587r8uZzOFnF+I=;
 b=nYTl+DRelyt23tvRzaN08t71p/iQV6Eo3PUWDn8Tv3Ub+2jVqolFF8nhW845zc/HtVqi3SPvuB315DlhD28jq64bNDXPvxauoNXCGrKjVr6bnHopHsoAmLXNHF0bLYk34GgnVXj9oWyiABuWQm6YMl4t2I4O4KfM3nQQ6B5hQStw76mhq5ETKldefhydY3SpzCLLIXyKLM/X/naLf7psMS+xwcMrOrq7ZowyjicJuiiYk1lZiHXQEM+PQhitJtgA6XDSAuOcqdjbaygwc/r3/Lh+/VWH2vJCagkMyVEJbpAEdgOOS3qqxfsrpAoSZ04Yz6diKO6Q4tKGfqfzY1Z/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8NlQdfXcveEtcPLAuB+E6YLR/5Ij587r8uZzOFnF+I=;
 b=lr9Vr2F7/XA+cxh38mHLWrJ1kwq0jM7dhj1LyRWhuqBpD2X+4Cd8ObwItVM8DXYgA0I3k9y0i8h/MFUNzgSA9gYJTsVsVpP4xLxqflpziqYyUvhtzaAw7Dk4n/Ayn5hq8SrYYbZatIPShIlY8cJPtwT47ttNNuwm65ITRHjGTkngNE+4If9cZQLHTNiiRiJLkcWj6iZ4WfGf6mrSatp4ktJxXYX7A84VxEnnMgufv759EKVDIbc6clMWy8iWbPDUr4howG7sYq/4SsSsdZfUOOjOvHOFdCf9XD5awC390VM8l7AVmrB6TA0aTgnSQAJgtJckQZgW+VXnw/ENv699pQ==
Received: from DU2PR04CA0237.eurprd04.prod.outlook.com (2603:10a6:10:2b1::32)
 by AS8PR10MB5879.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:527::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:37 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::bb) by DU2PR04CA0237.outlook.office365.com
 (2603:10a6:10:2b1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 14:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:45 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:35 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:24 +0100
Subject: [PATCH 07/16] ARM: dts: stm32: Update LED nodes for stm32746g-eval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-7-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885E:EE_|AS8PR10MB5879:EE_
X-MS-Office365-Filtering-Correlation-Id: b2fe113c-bb45-4173-5520-08de21f971a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlN4TzlQV0IzcDd4ckV3TmxIWk9LanphUnl4Z2JGS05zbFZRMjhpdXBLWnh3?=
 =?utf-8?B?ZnVuYk51c2grQjB1YWlwcFQ1dHJycm5pcXVNZXd0RXBVWEw0SXo1NmY0a1M4?=
 =?utf-8?B?dVNRTFB2cE84RUl1NVBMcU9LdU1HNHRZcndQUytqNjczaGxrbXQyWGM3Sml4?=
 =?utf-8?B?UHpPUTh2citCYXNDY2NRVE5zUHlwditFaitXTElwZ21HRER3WVFvOGIybnlm?=
 =?utf-8?B?b3JwS1g2Z2N1SHFNUjNpNlJKYklFbm8zQzl1OUxJbXowOSt4ZFIrTW5lMnZB?=
 =?utf-8?B?QjBTQnVhQXVHVmVqb3VJNlFzU2cvM01ab20xRFVLbHUzeGVkRGZzWi9JMUNV?=
 =?utf-8?B?WWY1VlFiSjEzV3ZqdnVsVGhPSGZrQTZ3YjE0WG44ZEY3NU9DT3pMdUJpOEs1?=
 =?utf-8?B?eThuV040V0RhbDB6REh6ZXY5aVVCUTRpMEFGclA2Y08xRXdCNnFCdzRzamZk?=
 =?utf-8?B?NUQ2SVlQd1k1S3ZDSmE1cGpuV1NiRmZGRmxXcndKZ2V2djc0VnV6c1UzN0t0?=
 =?utf-8?B?dmZKNmRvcTJ1TjN0Z3I1ZFBLOEFFUXNkY1FqY2UvZVBWejdWT1hlRzdEUVV6?=
 =?utf-8?B?ODgrK0p1dVhXVzhOQ0pwMWZIMXFYdyt5c29qOEpkbXYwWmN3SGlJRWdacGZK?=
 =?utf-8?B?aFlJSG1oZnc3M2QrSG5qNE9mdW1EblB5YThobWxpblcxNm9pOVJsajJPN1hr?=
 =?utf-8?B?SnFUck56Z2taQXlJN0t0T3lqelZpajMwOVJKRGhjOVRrRlA5eHNUZGFGbjNJ?=
 =?utf-8?B?em11V21wOEJNazZaa200Mm5TQ1lZYVJYZGhBaGsxcmk3RVZvYkl1dkMxT3dM?=
 =?utf-8?B?MGUzeE1XcU8yeTNWZU9neTh6dGNwVlpYejk1QzdNQ08wc1UwNGRFMERvZGJY?=
 =?utf-8?B?NEZIUTFneVBTMktVMlNkTnpjc0x4V0t2elFYdTc3d3hXTUFob1N6ZFB0T2VK?=
 =?utf-8?B?dk93UDFGbHFiL3g1Y0JFVkpONFJEcUx1N1hPc29WL1FhR0JtZW1mTlFVRHk3?=
 =?utf-8?B?cEhndFptdWY5ckxKbzZvcTNWTkNENlBtY2pucmVYQ0FxQWcyUnMraktEN3hx?=
 =?utf-8?B?ckJQckpUSmtTaUVqZHF4TElGTHpudmdvalNSTG5zeHRYQzlWUC81dGI5ejZt?=
 =?utf-8?B?dG5KVlFJV0FFZFcybUpjd25PZ1UzQ3h2RzRpT1pOZWc0bUx4Vlllalc4TlBn?=
 =?utf-8?B?ZU5GbjhqSmxuMFVQMkNNVDVwYzRJQkZLcE5CS1gvaFdJcXMxS1NMYWVycEk0?=
 =?utf-8?B?Ymcvd25wSTF6NlgyOE9GTmFJNkg0VlAyYWs4cUU3YnhiV0hKeWdFV3g1bVpu?=
 =?utf-8?B?MlpONzNuOHYvZFRMc1Z3N3lnRXBNQzZTdDFaQWdaNEswWm52LzdRLzM2VTFG?=
 =?utf-8?B?OGFSRTlVOUh5T3orNUMxcllxMmVzcDY3V0VCblhlRnlZTVVDYkdFWUVxOVBG?=
 =?utf-8?B?bzhuelJpN2lseDZmRHNtbElhenlubE53SkwxYm94ckxTWi93eGxQMWVhVmEy?=
 =?utf-8?B?M295OUpmeGNxeDlFcUhDNk8rNFJ2a0dNOG01SDhhRktKb3VpalhjdG50U0ZN?=
 =?utf-8?B?U0duS1M2WElJUkNGa0Zna2RxaWpUSHcvTUVmakV4QWZoYm1zYXpzUmVrWncz?=
 =?utf-8?B?ZFpJZUxpYzBMVS92a0c1TUlDbDZpVnVqOFp4cW5zVFR2a1R6OWRFOFpDcXMr?=
 =?utf-8?B?cVlnNlg4WkwzSEl3d3Q1SWFvL241UHZNTUZHRDdkTVNZT0wwRGR3aXVJa3lo?=
 =?utf-8?B?bnUvSnR4Vkl6UkVLaFkxT2ZjVW83VFdueHZmK1VZZjFEd25ZSGNXeiswb2JK?=
 =?utf-8?B?Uzk3aXJpVm9JRjVuWHM1SlJSZHBveW9rWklsUWxZdEZpb2xpT3lmOGFJQnht?=
 =?utf-8?B?QnlkWHlEMUlodGp6YmhCUlV3WGZqS1NYWG1tUFlJbjlTUUNiTGNFSWZkN3lQ?=
 =?utf-8?B?ZTVIT2dmajk3WmI1ZzVHSHFvZmtRYkJlVlN2WFFXVEVlSndGRmloTU9NODVS?=
 =?utf-8?B?UUR2NGdnYitOUzd4UWpvbHlrSXlEeGdyajdOUGJUa1pGa0MrZ3lwOUZpVUNx?=
 =?utf-8?B?ek1sSElld2owS201TVF3bzVUVCtaTXFvVzlERWNPMndXcjV0cEg2QWpCTTBS?=
 =?utf-8?Q?tFsQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:36.9040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2fe113c-bb45-4173-5520-08de21f971a0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5879
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXylat/WRbOcIz
 NLgZ1lbWRrvmKnNxKDWnhhtugcAJIicmZc4TmnUboJWfdrHXzY/6glDmUe+gklxIjAuOrBPRFgZ
 theVCSKNvzkOYRzSeSiZfxHH4qxdT2v4uq8zah0ufSDERZiv4Fb93VebeDElTlu6zLBzdG0e8vy
 5Ywx5P+9R7Fxj2S/0uxiN8R+fn9PVV5W/8J+T6NqtFKUo30TkYIJq5LoMAO5uElmCLtSKJVtMtE
 ryuQROxJNLSYnHTS1hYqKoWScyBpoQTh9ZhLnoJy5c0RNO9GFn3h8Zv5AFxKycRHZsFZp3vGMtB
 YHnsvXJbxjANuIQZxGwTcSxnm1SBl8xAouL6An4JGFSXkcRlrlGk0X8mV/yj/gEskQCpXwCq9Pc
 04WeGMB6jknkgDMK17/Hq2GjausPyA==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69149c67 cx=c_pps
 a=w37XPDA4sYKthlASMuCTjA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=jhUhpFCSItG6WmWFtkQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: WgyTdxt3eQzMnwITjxvpsbfYOFOlosmZ
X-Proofpoint-GUID: WgyTdxt3eQzMnwITjxvpsbfYOFOlosmZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add function property for led-green node.
Add color property for LED nodes.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32746g-eval.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32746g-eval.dts b/arch/arm/boot/dts/st/stm32746g-eval.dts
index e9ac37b6eca0..78ceec4a9487 100644
--- a/arch/arm/boot/dts/st/stm32746g-eval.dts
+++ b/arch/arm/boot/dts/st/stm32746g-eval.dts
@@ -45,6 +45,7 @@
 #include "stm32f746-pinctrl.dtsi"
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32746g-EVAL board";
@@ -67,16 +68,21 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiof 10 1>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&stmfx_pinctrl 17 1>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiob 7 1>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&stmfx_pinctrl 19 1>;
 		};
 	};

-- 
2.43.0


