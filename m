Return-Path: <linux-kernel+bounces-897433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C951CC530F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F308A508127
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA21A344044;
	Wed, 12 Nov 2025 14:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VHGnGXtB"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC90433CEA1;
	Wed, 12 Nov 2025 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958452; cv=fail; b=Mf1WKmNcwtWALuIss0puFA04MjDASTD/BBaOdQdOx/Cz+EOHX+6WYwCZUH2tYYHW5GwCikAU31n9w+BHSK7PUnSE47OKXch9sV3JL8v1DMZtrwu+OBYx20KXUtJK+DcWiSJPFvfkLTqPD2o2F4SK+o1V3Mp95FAweu1ruPnD3cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958452; c=relaxed/simple;
	bh=vvcBApb/cZ5pv0si/v6Yf1oKTyqfPEoVDpL/1tWmqeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EKCm2Sg0maD0Yz+FkEZ6Gd22tp8paERCSfTslATICIDMQleGOavgcmM79mQBr2B6OpyhpqRTm67rsqvD6XufL/P/ByqXzkRq/OiHtEveRq7ZWJ+WPXI0jqrh0L9+R3n/XoD7ZdrkqbvhlUST4ADi+6Z1yf9ntw5TEwFsA3LzDjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VHGnGXtB; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACESJWi956181;
	Wed, 12 Nov 2025 15:40:39 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acreu1045-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ctxjrVU9br2rR1+r54DKPeifXgsD2fXKvXx8RkxWF0MmWHuk2E02PnUHcQ0NHzsZW63v9ghbCiNHlBXStv0hUP1IlQNqr4jL5f5m9FcAdPjuXlyOoc9vJBY0tVt0vMnzNz73poMot7oXamiakAakIb3qcb9dDC+93iPKRl0qyaC8KqNxOa8pvwOr1s1hXqc4lgAGwpW4xxwBEIFsrqDnshFbPYCLoAqSd0lY3TA3RdMg0mkG6iLUBJZDxm5LyLdBbx8MRiAlyhcXKDqTzbB5A/hHvm3VtAhMOALtWTI/0MNMso7qjFJsgkqOf/XNkck3KwqXJfDMJDXuEUleZNsr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9OkfTeBtO+oUsWB12PkymdGbxUw8aVpVm7iU5djpNA=;
 b=RsNDspiDk2StcK0FnLy/ipAK8GWV3+O+XtSZkDwqFZKExGSFVibbO7N7Rod286XA7dRkUqrm14+kDYFAvCzsPiYprztP2uG7lJESi5D6xw0qG9aASPSTb1M3jAsL9SsvaigChDFRKb3+qglus6lXZQ62ov7sgbIyQ5KDxPEz075aOOC4IZrNuBCQp76lyRoNe+mw5ykSOp8Ru6I76riGx+Tpl8QxsnUfB1QlCGnr65zlN4ESbyeb03LWj957SpkoQIqXC6UDXDiUJvTjLutuTsaFQ5AUdBlhGxeE5UvpRyjBzGUTplLgXL7r73IsgV0nH8KOjQxssZW5gKbOOrz8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9OkfTeBtO+oUsWB12PkymdGbxUw8aVpVm7iU5djpNA=;
 b=VHGnGXtB/SGE3zlVz3UguVpjPBzt8MvdP4petBbQh8ibCFP8yBxr2X+ncdjk1C/wk5SgbQ9O+WYvfWu6mSvibo4XnYYBL+PIXa0+MjWP0+CNLd89C8lAE51huO2LprO/9aPGqOiOuj4H4BSkUg7fSIsGpFuBQiLdtUbOqSRYgGLRHHpJwqnZ2ZcJb4apxUAGQHplLWhV07AFGb+TZkO5SWo7Iy5vlbp4cHYtXlRp0thSjhbol7p7vkaJ9nqvC333JYw5OQzKdD8sfD7VSpwUzX8WZI5h1W+WnBsTCsBZYCiCMJmK4OLbEP6n2Bv9Cfq7HTpWA2xEQcsCJs58rUBD9Q==
Received: from AS4PR09CA0019.eurprd09.prod.outlook.com (2603:10a6:20b:5d4::10)
 by DB3PR10MB6811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:437::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 14:40:35 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d4:cafe::f1) by AS4PR09CA0019.outlook.office365.com
 (2603:10a6:20b:5d4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:35 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:45 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:33 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:21 +0100
Subject: [PATCH 04/16] ARM: dts: stm32: Update LED nodes for
 stm32f469-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-4-f6c77739113c@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|DB3PR10MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: d76501f6-c557-4e1e-0337-08de21f970b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFk2cWlwMVlUeWh6R2F2bnNxSHFEdWcvWjcvNFcyME5RSENkT3BKU210d3ZM?=
 =?utf-8?B?cmZDV1d1SEVlRnQ1ZisvZVlPazV3Z1V4bU9tQTRhYzAxejRERG1VYXdHY0xH?=
 =?utf-8?B?UEZSMGpzdG9sVUlxQ1dxRE9yM2czMnBRR25wSk4wK3ZsK0tTeUxoY3hGVUU1?=
 =?utf-8?B?T3JUejYrdlFtRmRlTi8vYmFvdlFwdTFodFpLRWtIYzNnTklJRktGME11VGJz?=
 =?utf-8?B?ZnBHMHBBbnlPcDdqUTI3LzlaU0F5M0JXNGQ0NDlIeE5UOG1vRVJpdHFaWlVR?=
 =?utf-8?B?OGtCTXZjelRHWGgxWXFadWRUV3AwOFFuME9ETHNBREU2MytCY2hISFBJdmh2?=
 =?utf-8?B?ZCsrTUY2anlOQWxmRGgyS2pOQk9mdEt3aXNDV29pMDNBbUtJTUU5dWhqNFJ5?=
 =?utf-8?B?YlNPOGNTbXdxMDJkdEo2VkVlQ0kzdmxzd21qeVE2d3NhL21JNHh1L2hyTm81?=
 =?utf-8?B?UGxlZHVCbUNBM1RCN280NUVVU2ZDM2U4WlREZ29mM2pZQ1VXa05rLzJWK09w?=
 =?utf-8?B?OTNMLzJjcWgxOFViTXRDWTVyNytKRXQ5enN3dTl4cFNmYW1HanhjRnlLVXlP?=
 =?utf-8?B?bDdBcWFBNDFHa3E0OGhjQzBES1RrQkJVeVdwTEZLTm1KMUk3Y2FIZXJNajVM?=
 =?utf-8?B?MWtXU051TjNRSFMxLzhldHdUbjZaVk1CUG5SVTQ4YTJ5MXplMXAyalVBS3lY?=
 =?utf-8?B?WUErVFBabjlDb0k4R2g1UDFZUjhRS0dOLzFSS3YvY09qckRsNlRXVkRncnht?=
 =?utf-8?B?eGdISUdXZXEyU0NETHl6SldEZDF1QVd4a3E4S2I4QUxDMTNJend6aitBaW1I?=
 =?utf-8?B?TzJaRDdJNjdnVUM5KzNqZUtjOHVwVnJlOEN0UUZuK01USTRZN0RkVmlTK2Zj?=
 =?utf-8?B?YWJrc3ZPN01zVUM4dUt5WGNLU25BQlArbjk0Qi9pdWk5ZTg1by9PMHd5dkR0?=
 =?utf-8?B?WXhyQzhYRTZsUFRtcEFtUm9NSDluaDEva3gxOERNUnd3K0hZeEEzZjZIUmI3?=
 =?utf-8?B?S2tJR1RsdG9uellFUmMwNmhtWjRuTnVGdEg2Nm12NVBsV2R6SE8rbnJOR3o4?=
 =?utf-8?B?VWFNdlg5ejVTc2RPblhUbDc4UUdDRDY5TG1neUlOQUt2OWRGaUNKUmoweEND?=
 =?utf-8?B?WElka1NWM2FTalRPdnBtaHBsZlM5NklyOTc3d3FPa0RLSXc0MXZrNERSUFY4?=
 =?utf-8?B?QXJQK0JIcE9rYUtwbFJTaDRwSzNDbXFOeHczOVFZbFBBcS9HeUloNWdUSFJ1?=
 =?utf-8?B?WHo5Y1hoVUJGWkNxaG84UitRSVI3dUd2aktPTXNxZjBDWG11UzEyeU5Yd0d0?=
 =?utf-8?B?cUtvbEEvNVNUTnZ3RzR6RTV0NTVnVDJwUWdyMXZMMTRSb3pZTzY1b3JSdW5X?=
 =?utf-8?B?bDhHRXFoKys5bEErcDVtMll1bVI3VmN2UEYxYnF6TjZ4UFJhTjFIQTJOSmx0?=
 =?utf-8?B?UjQ0dXI4Uk15OFZWOHFNUVpJc1dwL0NpSWloMzhlcUdFSVM3VE9EWWFzZ3ZU?=
 =?utf-8?B?SWplUElBVG8weTlOQU1Ya2diNWRaUW5KN1FlN215N0RFYW9iUnlYQTRHK0hB?=
 =?utf-8?B?RmFqWlVBU1REWHZ3b01VdFVtbW9aUkx4UVRJK05FNmliOGk5c1hGWXl3U09s?=
 =?utf-8?B?VTZ6Nm5CK0pvaGxrWGhqdmxnd2VHRTExR2xucUs2bDNpcVRxZGRtUVVieW0x?=
 =?utf-8?B?RElSemN4RlJXUzZlS01ndHltVzJZWGhCSHRRSUxYTmdseE42K0wvYURrdlQ5?=
 =?utf-8?B?Q01mVHlMMWJ1UVlhOFd6bGVDbC9ub2l3cFdjVXZwVEZ3VlVJS21aVk5WeGdJ?=
 =?utf-8?B?ekNuNW9KZTVvdFhxejcxMFROU0J3aWxxQXlmL3pWQU1LOG10aHpWSDZWNnBz?=
 =?utf-8?B?b05jNWY1MENRTDFDcUp0MkMxdU9jSWpyMWI1Qk5OKzJ2WGtWMkE1VEVOemVO?=
 =?utf-8?B?aVFwV3g0WGplNWYzcmw1MlIvTGFmd0xjY1hDeXhuS3dlOEF6Y1d1bThWalc3?=
 =?utf-8?B?TWtpcmFEWWV4cDZlR1hkWkdVT3JvU1ZFa0M2MlAxc3RRdmVLMElUWFFBTkMx?=
 =?utf-8?B?dFBsV1pkWEYwaDlNUHd2YWJyeURXbEpGR09YZWtiV2pSUXZ4TnZpcytRaWFT?=
 =?utf-8?Q?0tCw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:35.3487
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76501f6-c557-4e1e-0337-08de21f970b0
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6811
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfXyH/FwYzRXuUI
 BO6daG++RFVZJHT0VgoygFuvcstjZFeMKZtOMkE+6gyocxlk/YBAn2tL9/k1JWf4aK9qVdfauth
 HwFqICD/yLGOq30qGyXrVkcZHYks7T46/X84OLc7sjCcyaxwgdEjV1sLKyFkWs21S1NPViFvGXx
 K+IhjrkdutVB+WmKtC7IVx+u2+jxHcRbcvliSpByXQbIDB3JyS0n1k7Wi2U3HbeD4EJtig8iPy3
 AkEDQ4e3QgnfJa8HKFPXopGmxQX3HxnNEIiFr+aIXD0fI7+9Db7M2B/99HwN5MiN2NDGCLeeXQp
 H3gY5KTaRMiR/7p3P9MR4tefwJQhi36fSewAsiSTs7TGxtr7VHRzkFjqCZ7o/KugCT7ui5+4Tbu
 v0PmT7FKuiTav16A8hA/Lsq5AlRmrg==
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69149c67 cx=c_pps
 a=NFb+XA0cqGrCirhha3CpiQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=jhUhpFCSItG6WmWFtkQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: I0g_BbW5c9UVmoPw_DwQYzcs3CAUNi5j
X-Proofpoint-GUID: I0g_BbW5c9UVmoPw_DwQYzcs3CAUNi5j
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
 arch/arm/boot/dts/st/stm32f469-disco.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32f469-disco.dts b/arch/arm/boot/dts/st/stm32f469-disco.dts
index 8a4f8ddd083d..f43547ec436d 100644
--- a/arch/arm/boot/dts/st/stm32f469-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f469-disco.dts
@@ -50,6 +50,7 @@
 #include "stm32f469-pinctrl.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F469i-DISCO board";
@@ -83,16 +84,21 @@ soc {
 	leds {
 		compatible = "gpio-leds";
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 6 GPIO_ACTIVE_LOW>;
 			linux,default-trigger = "heartbeat";
 		};
 		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
 			gpios = <&gpiod 4 GPIO_ACTIVE_LOW>;
 		};
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiod 5 GPIO_ACTIVE_LOW>;
 		};
 		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpiok 3 GPIO_ACTIVE_LOW>;
 		};
 	};

-- 
2.43.0


