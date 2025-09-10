Return-Path: <linux-kernel+bounces-809721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D6CB51127
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05E2F1C24373
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990AF30FF02;
	Wed, 10 Sep 2025 08:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Ux+Pr+El";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="lP8aWbRC"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FC4306D52;
	Wed, 10 Sep 2025 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492724; cv=fail; b=AaNddECW/mo2SnylT/AZ3fcfSUEvgyluNXrgKCOPHsG0x8nRUlE8Qbjzto36Rgfj715CBR8/AShqVbvPuQ/z9pBDE7sAszmdNz8ec5o2yjUhuSLcjMff462kEsKWqetai0NmJxlhx8plGsHp29AQCD2XD6oihjsJIigQ33bG2Wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492724; c=relaxed/simple;
	bh=vEiB9JjjaxSW9c8EtscusAk0iqpbLxxNn4nl9MNSkks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CMHZpi8cnWLdp2EwH1l+R+bR8LGDXs3W2HkSAg0g5SvfC/0/eROyzXE+wOvkQJd0Sdz5VJanu+47C6siz69lbaimErPRzlIQfrq901Av5uIav99Y3xVXP2FjtJZJl/00qD3KnUA2Lw3ZfT8Ba3+qdYB04IyrzGQ5hUe+8k0SarA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Ux+Pr+El; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=lP8aWbRC; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A7k4Cn008571;
	Wed, 10 Sep 2025 10:25:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	9FKscBMgShSGXp4/z6T72Hv4dQJ89QFe3iPHe3i8yhU=; b=Ux+Pr+El+nccrthJ
	t7PXf9gOS8mzvlke5c0buQUjewk3CHP1rdFx+b7g+lUtiokX6Z6BrMneP8eH1O0V
	FX4Te/XIZIhSBtDprldQd6LmsyX8jCnbhYg1W56/J3Nr0pw3tqZq0plLz1TNs5vD
	EiXCHPYS73CD+LoTWaHBc8rF8njivV6HxGtb4iZ1M88aM1AhLazCayI1tW9CoUXS
	dGyPBCJCLVyY+GhcFfq/x0W0vfmyhvfiizrWniq6CaHlgk00dHlBuZLKKs2mgEfV
	ZWon9J9Ebjmk3Li12W+lpFEGkj58LhhVdwI6JQG4MYpT4tZN3fNOSS91J5LLorE3
	Wdt+EQ==
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011043.outbound.protection.outlook.com [40.107.130.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 492fr9cxh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:25:05 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jZUYQcCzBS8+kGRXgbS1nQPwIeQd7lu2XVgomIAUr6d5lhVgTDIPFBfRO54cbKxEZVeO2XeZQoT29Wx1ERsqZWgTkFuBY7mbtcZZSYYY0PpC5+9z/AOyog8edP+SABeKwbpihD/Pm8CWgEOVusAMlDpUmcq9qiRYeQDcHOjwwBt+gDcbUDqiJ5cecqOOBrLdfGcUNJy2DLSrNQFcKfsPwtu/dT36R8ebs4Kd2NhTRlsXgzwhYhtyZuAJ60QrRq8rLFfNTppfesk0NrNx1xhBtEMRyRj0NiektsWjYQ3hHeakdMkH4OlKCTNfNfQdU6F4PLV5hKh2eLKG5SNrobNEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FKscBMgShSGXp4/z6T72Hv4dQJ89QFe3iPHe3i8yhU=;
 b=jh0Qy8D6YKx9MDxoYorKGjm3Zjv4p8qrTpLz8vwVjFAj6eQHvunxRcBe037ruDswTWE/Hx7Zxk26mpKgl77YRgLtWVcsQjVyBDVRR7ZB9bC4b/jpkIb632psi6mktKT+jsrn8STXx4rOOSgH6N8VbT0WfnJIIMboRmT/SGVNOC4mUUIUEwngp5nW6i3ZxHTNcD/Mjw3IvFDmGOiuL1qX/PnHqwO4ejk0KgGO/1986jL2Brx2MUvlHUeQNcCLhZyk0MSKtBqUByeWcMz8noDT8j7MEXz1eWrxBDSRov7A57iYO6K+rhWa/HLXYJG+Q8W1Gs8s1qPSVaiVjqqFPWDdpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FKscBMgShSGXp4/z6T72Hv4dQJ89QFe3iPHe3i8yhU=;
 b=lP8aWbRCyFWMrcfuIZHfTmvti1vQo+39j694BTaO/1GH25Utha8qOC6xvD6oO2DzPU5r34iOQhspJV4tD1UpDfHifVOO1xWO8OI7U7PUwdkNCisFaM0KpDO4pn4Xbi+fCuJhsGVxmNVEdjfXBDMEKnvQElSdueHMAtXYQz+GLHc=
Received: from CWLP265CA0303.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::27)
 by DU0PR10MB5924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:24:52 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:401:5d:cafe::b5) by CWLP265CA0303.outlook.office365.com
 (2603:10a6:401:5d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 08:24:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:24:52 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:17:42 +0200
Received: from localhost (10.252.15.61) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:24:51 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 10 Sep 2025 10:24:37 +0200
Subject: [PATCH v2 1/2] arm64: dts: st: remove gpioj and gpiok banks from
 stm32mp231
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250910-stm32mp231_gpio_update-v2-1-8510efa2c5cf@foss.st.com>
References: <20250910-stm32mp231_gpio_update-v2-0-8510efa2c5cf@foss.st.com>
In-Reply-To: <20250910-stm32mp231_gpio_update-v2-0-8510efa2c5cf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000049:EE_|DU0PR10MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: cc866eb0-326d-4b2f-3fee-08ddf04383ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0xBazFNVFEzSW8wK1lRcitxWXlRNk5ib3NHYVA5c3FCRjlndTZUaG9tL3pU?=
 =?utf-8?B?VU1VQkdDeWZQNlBZNXZQWUdFejFaTlczU3ppOUxncFNBYko1M0pHTmptQytK?=
 =?utf-8?B?TjdBUXFoZGljSlhoUVY0cEl3ZTNXaUJ1K2NVcFhBKzJhRUgvSXpYSVd4UXQ5?=
 =?utf-8?B?RWdqdkQ5YUZ5Q2Fqbi94WDFpTG51aGh3ZzkrUDZZZGVQNmx2Y0t1NkFqbFJC?=
 =?utf-8?B?aEJ4eVNDN0ZSK0lTVi9uZnBjaVNReWdndlFubW5WR1ViVnZIY3hPRGptMzVK?=
 =?utf-8?B?WlJpVmNqcG1vS283Y092YU9IK3hBc25wRnNUUk5zemdlQ1BzYk4ySFQxN0Nn?=
 =?utf-8?B?Nnh3dG8xVklxVksvZWpFeTRTTVF2NFFKTHdKNzhjTENBVUpKaDBwNlB1M1Yz?=
 =?utf-8?B?aU0rd3pxOFU5aml2RDhnamVVOFJ6bE15NGhvZWpJWVZLQ2hwMGZ1clB4SlZx?=
 =?utf-8?B?c0lXTU1nRnN5SENVSEtoQ01sYUpYUE94RnY5N0dwd2l6bUg1UlpSOVZPTzk2?=
 =?utf-8?B?NDBXRkNZR3NRcFpDT0p3TFVHMXVsaTJGd1VPcVU5OTNOc05kMXdnMHUxWVFS?=
 =?utf-8?B?SkJEeTFiWTRLOTQ2eTNOUTJVRzlyTjFLQUlNcXJyWDZ1ZE5uZWRMdW5kYk4v?=
 =?utf-8?B?M29oWHZxS0dEeExPMWh5azg2SFpPem9Eb2JPYUZ0UUZBZFlJTktQcHJVSzJz?=
 =?utf-8?B?a2s4d243TElkZHFON0FiYnM4dzZYM1hNMXRQaDJBOHBOWGpjWTlQTjRYTklR?=
 =?utf-8?B?OXpjZXladjB4bTQ2YUpzNjJQVVgwZ01zQ0hqMEVGaldOcFlLTXl0SUJzZkxt?=
 =?utf-8?B?Q1VaV08vcVhMQUorZnFYY0hTUzRlVFFoOE1INWZQOVRBbk1JUWVrZDJDaWRX?=
 =?utf-8?B?YXh5eTFVM2xiWmNZdlpyWGJQR1ZCVnZJZ2pYT3JidFkrQWtIak9TOVBFRkpi?=
 =?utf-8?B?bm5lRUdhTURFQ2pNUFA3WjcrZFZIZkE5VHZvTXdCSW9HaFo5dDVqOU4wUTFy?=
 =?utf-8?B?cnBoRSsyRUxZbS9yOEZoSXFvT25sQWRDM244Q2I1OU5ZOHkxWi81SllJTlBy?=
 =?utf-8?B?UXlYQzBEejZXbVdlcXZ6NWJtd2N6ZGJtMXpPdWhPbjdQNGhFd2dQZUpzYXBr?=
 =?utf-8?B?OFI0RjJZQ0w4L1pUcWV1U0wzZUxZTmUvUUw1VTVmNGg3SzZMKzQvaC9TeUFr?=
 =?utf-8?B?bWZHSVpyOTFjK2QwMllPaW1oRFZrNWFhOVNDRzNKc2VYQnp5SXZQRkMzQVc4?=
 =?utf-8?B?N3UvQ2lqYWpkT0x2S0FlbTNHUnhZajI2YVloL0hrTmI3OG9WNTNxMU5DRWNZ?=
 =?utf-8?B?dVRML2Z1dkxtU1pOd1NqbE40R0l6NVppdjBiN1NOVktmRGJOamhSanl5WnVW?=
 =?utf-8?B?UnNKeGY1LzBSMERQZDUzb2YrSXo1blNZY0FrcWdlVWFjNnp4M2VnU1V6VTd6?=
 =?utf-8?B?ZElwanJWa09ZMW9Bb0FTUDhvaFZ1bWM2aVZOaWRFTWZVMnhlY0VLTm9IY0JT?=
 =?utf-8?B?aFhIcGl0N2xrZUNnbkduem0xZXdUSnFNWXpUcXNmaklnSU9pOGFKK1ROeGUz?=
 =?utf-8?B?ZlZoUmgrMVRQc2lnYTA5bnZWU3ZzdGQvTkNML0RLWjE0amNNb294eDRTTEhI?=
 =?utf-8?B?MXlmdk1QTTlaRGk0OVRObENXMm4vckUzVlZCMElZdkhMYTlKdk5BNlVNODRR?=
 =?utf-8?B?eE5Xb0pGUXUwRVlXYisyb0VzQmY5Z21HZndvSkVycnB3NkF6YjA2UnFXckhD?=
 =?utf-8?B?TXo5KzhubEFpeWNNSkw0SjNQRndkTG1yVW5ER0RPRDdTMUNjUmpWUWVaYm81?=
 =?utf-8?B?RFFZaTVQZ3grYVpXZ3ppb3U3TzU4NFdQT1NhZGpPcnAveDdHSzRxcllYU1lv?=
 =?utf-8?B?d09EdElnd2drSlJIa2ZIZmNJalZZQ1BjN2Y2UE9RUWZ6NjQvUGpoNmVPSExR?=
 =?utf-8?B?SmVGTkVKLzJoaXZvdEpnR25vRFZ3NnB1bzdDT2ExdHhQa01JTUVjcy9SWHBr?=
 =?utf-8?B?MUZkZzlPSmJCQjVvbkVwWTdMSHBpdGt1UW1YekxRd1d3Qlc2OVBMWTMzcmtJ?=
 =?utf-8?B?VTFOZURuVVh1Sk9PR0VlaWh5U05GQ2E1ZGFYZz09?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:24:52.0120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc866eb0-326d-4b2f-3fee-08ddf04383ca
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5924
X-Proofpoint-ORIG-GUID: cXCOahlndc8yXxntJByvef8sX6Wh_PEq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA5MDA3MCBTYWx0ZWRfXxExlo3qX310u 6xZKrvHs7rPr27cco6JDoLH1DSTXMX3LHe0SdBBPq5eB65WzC6nmCc271gTVQ48WaU9ZYIw9UEc 3+JUYvg5i7m9hmRlMSFnz6Yg1Qn32R8JB6jhJca85rI81OXBeRVbRqJ5MrfBALZ6Pr0stLVYZvA
 i4pNikHrtVlFroUXgqxA4h4y4Lw9GI86XhvYR9rlJykDU/Za7TypDfsliPdtnEGe2/LZnBZwiHh 65U2iZEVTQlH7JYcW/SvmRRQOdhGwJcb/B8ED65UHFeQYYqm7W4nI3ihdWAKme5HpobKTAORzx5 hqn7H35lzRI4/9ERL+NWdXoH30zq72LekS0Zhj4T1I8Z/ii+h5f/rebpyVA9x5PihBo7KVwAkMS EcUIM2Q/
X-Authority-Analysis: v=2.4 cv=We8Ma1hX c=1 sm=1 tr=0 ts=68c135e1 cx=c_pps a=CUAEBjslK4IwMcEc9encMA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ifg0f1jqALsA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=3taiimqfx7hiQp8dKJEA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: cXCOahlndc8yXxntJByvef8sX6Wh_PEq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 impostorscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509090070

STM32MP23x supports AJ, AK and AL packages, where PI12 to PI15, PJ0 to
PJ15 (whole J bank) and PK0 to PK7 (whole K bank) pins are not available.

It means gpioj and gpiok nodes are useless in stm32mp231. Remove them.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
Changes in v2:
- Fix typo in commit message ('whole K bank' was repeated twice)
- Link to v1: https://lore.kernel.org/r/20250904-stm32mp231_gpio_update-v1-1-bcc7531cd00e@foss.st.com
---
 arch/arm64/boot/dts/st/stm32mp231.dtsi | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 75697acd1345b2a1cdf963300c0a64608bbb52de..88e214d395ab7af53e2707dbc2dfc6b3d000a798 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -1064,28 +1064,6 @@ gpioi: gpio@442c0000 {
 				st,bank-name = "GPIOI";
 				status = "disabled";
 			};
-
-			gpioj: gpio@442d0000 {
-				reg = <0x90000 0x400>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&scmi_clk CK_SCMI_GPIOJ>;
-				st,bank-name = "GPIOJ";
-				status = "disabled";
-			};
-
-			gpiok: gpio@442e0000 {
-				reg = <0xa0000 0x400>;
-				gpio-controller;
-				#gpio-cells = <2>;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				clocks = <&scmi_clk CK_SCMI_GPIOK>;
-				st,bank-name = "GPIOK";
-				status = "disabled";
-			};
 		};
 
 		rtc: rtc@46000000 {

-- 
2.25.1


