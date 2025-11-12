Return-Path: <linux-kernel+bounces-897638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6238C53500
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F095D565923
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFC347FFE;
	Wed, 12 Nov 2025 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AwaCb1+T"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA687345CAC;
	Wed, 12 Nov 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962537; cv=fail; b=SHDDxsB3xSyzc0vSojsDz41UDvlM4vbpHsLRiyaroUe0Nv9JknjobReMeZlFoI94DCMCs8HYAXd0x7mc1D4DwHEFI9G1KvVn1Uaro61i8glJlsOvpHMxnvof0W1J8byo33qAUZrpj0Doz9hO8Pg2hIll5ll2wY7Je85jZkFnKFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962537; c=relaxed/simple;
	bh=mFwrXDjLfOAgTVmScPd638WxXDFwi4Li7qCavYB2dE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=mxabR3iRBd6A/UBv9ZamIV5mOAGnIAgZwNfit9VATrgH9LJot/yMyEF3i7dNzzWB0/5ixi/RgcCgQYdfw7dsl4CS/yjve0WVipzsnfsl1oYpG/s+ohdGlc3HgRXQ/8DcHNeB2gorC8dNVCseG4Baiv2phv+taG6dowrMZotWL6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AwaCb1+T; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFjefv1614025;
	Wed, 12 Nov 2025 16:48:42 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010028.outbound.protection.outlook.com [52.101.84.28])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa79pfb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9N6i/GphxxjwQGB2f7Lhg0PxutwHqYd6VCfvNk/FtoEwe2r6rV09DaIoBexTTN8Eao0JU3Iv0iUD/9+R6O2DwVN27lYAHXDrbJhHVAOze9jLkUABFzKKPIi98JY37AGGe46GsvBg19eYiuelS/UhNilI/4mtP/q+QwABrbsOaXQeMlIVVlBQSU0V51sGs8hZuEK4LoGU5XnLw3Zlj0xRYZpOAqZYxRr3f+3t7hw4Ak6SIIU+9kS5pyYjHKXCzYQuXpKx9l7oQhbLpnvBYx0bPJz+p+IThxH8Ezd4zo+8c1G9ycCx7/hmE8A3jlT1+Tjm+TFtVYFwQdkG+ra4m9N8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7UV/GdFmDnxcn6OU+sCvW5h0+v3JozZkQo/areDkxCA=;
 b=hlOjUpxDINcX5aTnvxIH4d0pJJrZ2K/ZptkIWkLPp7lmWTb5fQyStCZjFjVbEns+j0EzpJaL6+Hsyj7FYXMNaagp+mMceD+s5DKHmad6CT6hPQhbE9CVioyUeMHYO0vkP+Lh6PZbkm7+uqW1jzZcFKxTMOfj6Gtxhr6qqZZ8ruGTQwkbSjNBwWiNYtwRpvO5ZQNVxxJnMEt2m81SAVFF1aevNkhteuEOjMo4xANibpSyVAOlLj0NQNh1hLEbwTaLKGCMcchF4WSwOx5YQ3OnsfpzgfR55e4i+fFJ5UQUmDFY97w77ST0l+ba7NaiWQ3JLW9/ABx8EQbj/9fvmKoM5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7UV/GdFmDnxcn6OU+sCvW5h0+v3JozZkQo/areDkxCA=;
 b=AwaCb1+Tx9wai5j8fSNhbf1CKn8noO//py3cRfYaVl4rmMSdM35pZKmYvMB9V/+A1HBbRFXh/LeUjSnmunys3sXEtqw50rb6mUQOJgoO2TGrY7i2LS3AJl/UpMDw10eUD6yJqGowGaBhEA59x0axERbQzQvDRdQj0JylWFqONta859gdJJzwlLFSjgq0F/gK7frC2FsVl2EV2DSt+n9iMxmkPJSTd9CnjF/U5+mGNh8Os//ziAD33a5APdAJ+yiTsB40ppvls/xXxtNibWiAN05CP/zV5jIeOpghwnDyCdEWx9HJK5rrVabXOXIebcMs20HdYkkbzluKYbfFMfSeXQ==
Received: from AM0PR02CA0162.eurprd02.prod.outlook.com (2603:10a6:20b:28d::29)
 by VI1PR10MB3533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:139::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:39 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::d8) by AM0PR02CA0162.outlook.office365.com
 (2603:10a6:20b:28d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
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
 2025 16:48:23 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:18 +0100
Subject: [PATCH 15/15] arm64: dts: st: Add boot-led for stm32mp257f-ev1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-15-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|VI1PR10MB3533:EE_
X-MS-Office365-Filtering-Correlation-Id: 73fa9c00-4cc4-4a89-00d4-08de2202f295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Sm1Pb2Z0VkZZZ1krTVBoSVc4WTg4TDBaZ1ZKeXpJQWp2VWR3R0NPWFBtQkdj?=
 =?utf-8?B?WU5uV2MrUzdkb2NNQW11R3pOMW1WS1hZWXNIUWVweHpWNGo0SEtlVGwxbUgw?=
 =?utf-8?B?K0hEOUVqTTZXZ0RuWFhDVTJvSzBUOWJRcWxKTWtTQ0RlRDZUYVRoZmxhN3pu?=
 =?utf-8?B?R3V1cDlhdDhJYUJTaUd0cFNmOU9rTXNmMHpMNTBKeEVQTlhhUU9vd0M5ellF?=
 =?utf-8?B?dGM1ckdmWnp3alJ0aXBYWFZzRHBIS3FUK3hIeEpKQ25JeThWWU84QW5aaHhs?=
 =?utf-8?B?aUFpZmNjZWo1cWpzSHZXVy8wb1FORjVWNHpPazI1UnVUTXg5ZkxsbHp6b2Zo?=
 =?utf-8?B?WkhCTEJLeVFsTVN1VGxQaHp5SytpMmUzL0R0MUNRQkJNdG5qeEFvbS9uNEZF?=
 =?utf-8?B?Z0RuUXkvYXNiRC9aczNXRzVxc21zR1BWUGhhSlg4Zzc3WWNrNUlpZGtKUlFF?=
 =?utf-8?B?QlVTRWt1ZDk5a094Mi9ObVcyb29Ed0FUeVNPTUN1cnA1a0hZSytocVNGUkdi?=
 =?utf-8?B?eUlCT0h2RDZYUFBaVFQ3Z2E1NEMxUE02Sjl2b041V0pyUUY3NFUzeUtuRGVG?=
 =?utf-8?B?akVTNGo1M2Z5WllEaGN4L3pwRlNVUHZWWWh5RHVrTlFWR3NzaWw3eFQvdDhQ?=
 =?utf-8?B?OVQvaEN4TGxqa01uelJEZUlBRnJqWVAwUHZla0FzaXBNMDNnUWE3ZCsyKzhW?=
 =?utf-8?B?QUdxcU03YnBwT1BIOXArTEdobHRqV21qRmoxeXJlY3ovR1p6TGVpZjNnQ0pk?=
 =?utf-8?B?Y2FpY2prOEptTXg0Zm52UzdHMjVKYUZIVEEyaFdUMW5Eai9oNzFVVWY0Sjht?=
 =?utf-8?B?UjZLc1kxRzVhSGlKa0Vsem1MZVJRaHhhaHh5dTVqb1hqVzQ5aFo0RUdGamo0?=
 =?utf-8?B?RkZKc0NWcElOQnZXSEtWQTdJVlJiNlBIQm1BRmhSdGFQVm1FOVRtVUhYd2lM?=
 =?utf-8?B?V0JsT2tETzdjMEkyYmZWNzJzb2MxVTViMUtmMnNXRG9VUVVNT25Vbk5UcThv?=
 =?utf-8?B?K0o4dUhIRXdJeEprQXN2bmpCRUx6WkhEWDJZZDlRRk5hYmtBU1FWcUE4ZXRq?=
 =?utf-8?B?dWk2ZGpKUmxBUGlFMklyZGJ2THg4OGpvbUpQYzJJcUhHMkVQbFVjL253RGNx?=
 =?utf-8?B?ZGlpOFZLdmljSmpGbUd6aDFZdDEzWFpMTHFmUk9keWtnM2JzQ0J1c29jWWQ2?=
 =?utf-8?B?dks3WWFGQlFVU3RLa2ZlSWovaFRzNkQwNENLaUhnY3QwWlFOQ1Q5dzU3WmxO?=
 =?utf-8?B?aDZkNGlwZ0UvaGREdFB0N2hVVnJyOGl1MVMySy9wazVwVWxrNkpXQUEySzJa?=
 =?utf-8?B?OEpNNDFzZ2FzTHBOTlNOUHBscEMwMi9RQnNsWFVoM054bEVLdllna1Ftcll2?=
 =?utf-8?B?L1pxNDQrdURXaThuRFREUkZieGVrWWErUXFOREJXNzBsTmpWYXRUSzNsU3du?=
 =?utf-8?B?c3FXQ25pazdzNlJZdXp2S1RIZG4yUjFGTXR6NnRDUmZ3ZkxCNkdoV25wNGxl?=
 =?utf-8?B?eWRzaVBxZmwzV2NWbHduNFlrS0VYbkR3K1BIbVB0ZW45T3lTU2xFNWhKNlcz?=
 =?utf-8?B?elZHQ3c0dmtvU1BHWktYL0tobVZZYWljYjVwcjA4K3dUM2FJUXZlTmdCY2tH?=
 =?utf-8?B?QmppOUMrVnlVVUJxWWdjbGlWZ0V6UDRtalR4VjlXZ2NNeFhtRks5Wm9OTXFn?=
 =?utf-8?B?bWxpMU1yM2U0bGV0eVgvaDFXbWdZeWtJbllGYmFKakJubmZrY2YveTJYclhS?=
 =?utf-8?B?bnpWWUg2eFBySGYvcHI3T0hHVWpPZThEUjJlM3l2dTlJaVU4OGRSTzdNcVhy?=
 =?utf-8?B?SE1DNzlZMWIyNHZvMkhBNk5SWTU5bzV3Y294N21CbXNQckkrL2NUeDdJRTlW?=
 =?utf-8?B?VU11R0tld0xOVTlpWEo1TSt3UGp6eXJEYzEzR0xtU3pCVHFSWWt6dFk3VHlC?=
 =?utf-8?B?RHBEcUVJdVVvN1Z1QWhGWUpZT3pQQSt6dnRxSDJSd1VnbC9iWUFTbnJIZDkv?=
 =?utf-8?B?VWRCVXNEekR1cUo0V1BJR2ZscUI5bkhKWHZFaTBnV2J6VWxDaWJ3cnhLZjFF?=
 =?utf-8?B?TnhTa1huaTBpc1RVWS9NcUxMWnI1M0ljaVdRc0kxdUJLbktySXgzRXZtQnZC?=
 =?utf-8?Q?Bl8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:38.7529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73fa9c00-4cc4-4a89-00d4-08de2202f295
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3533
X-Proofpoint-GUID: 8JhxQVQBVil33xhoYUxdoNMeKQsxYw1U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX6n6pkTcZKHYl
 i3NohB+rVjjS/SuMPL4URVunqCFz0k8s7bVTbLdcb7qAJTQG4cWyw//xk60Xlre/HbuVMtog2zK
 pciZy9MYlB8tnQLrV/HuOydMKv4T5yUvhe5QN76HbfQ40Su2TzsCDTBppcs6jVNjKY6Eg2oHEHJ
 ggL/S3Xui78y4/S7IMYNJY04yi25yqDCS5lzq13/uvvP+rjtvF0v75Q2LrfE5gpffKx+r5YfEDV
 EsUkosviQobYPFKeHkOQCoqbdgY8WXScu3L88xGzCF5VWTBceN6su0zL5I2FZt+2+tt066DdiKQ
 4aQv+NcQmTGHJ4Wo4sDH8WCdHdUfu1u13N1+Mp/T3sCQ2h3NrY3QDON1OLAvlYraZZxy8AxqR+N
 MTavFg0IgNdscGC1yH99EkG0hrgNpg==
X-Proofpoint-ORIG-GUID: 8JhxQVQBVil33xhoYUxdoNMeKQsxYw1U
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6914ac5a cx=c_pps
 a=mf19cOnrXCbh2f51U4A3hA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=GoHG9ZAtNuuEcBzL9IoA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index f41213187723..703b0c08eb5f 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -46,7 +46,7 @@ pad_clk: pad-clk {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		led-blue {
+		led_blue: led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioj 7 GPIO_ACTIVE_HIGH>;
@@ -94,6 +94,13 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x1 0x0>;
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	panel_lvds: display {
 		compatible = "edt,etml0700z9ndha", "panel-lvds";
 		enable-gpios = <&gpiog 15 GPIO_ACTIVE_HIGH>;

-- 
2.43.0


