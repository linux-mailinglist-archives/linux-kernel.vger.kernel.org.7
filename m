Return-Path: <linux-kernel+bounces-800831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9806DB43CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269A3188F0C9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC20F3002D8;
	Thu,  4 Sep 2025 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SZ3LlWII";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="dQgIAca0"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0895E277CA4;
	Thu,  4 Sep 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991540; cv=fail; b=O5rvIZJxfPt3xddnX2HmOt8sX5dXD2IVCHbKHyUqFevp4f02AQrcOQ3o1wmkZaSaOdYCbQP8280r0kn56qn01Suxa74Uru9qbH2gDSUPrRrjZyYtkQazKWyATE5cZJqWGhhPvxrEmzNnO4ESMBakFn9C6X90kL944ormmnnYJNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991540; c=relaxed/simple;
	bh=eCr5ndO/Jxw69gChhim/O2UhE53YdlT4u3VvRo5eFco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=fLVl2DqFSM+wntZcnryEeCfSCpJBoFUBgkXDQxj5Z2uwApGL804WA8Fg9q8Zmoyq3vJttguVoXAvHmjLdz3zHyjGGX1oHv59WolDYInTxug/nmQ8r85kH6t7fRlGE61zLMQqyLU1gYUVnO0yXiy2oe32XxUlVk/h4xDf6xVt7SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SZ3LlWII; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=dQgIAca0; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584CPnM6030262;
	Thu, 4 Sep 2025 15:12:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=TC7T1TufZFoTvIM9hY/H/w
	M7+bMXcVmP6tKXYUcd4E0=; b=SZ3LlWIIByXWqoPJ2PhBO2aIl5gKFku0SGoVOu
	W8EUYb8EuGRTsyb92qRAxh/2eM/x69JyM6WisQpxmoT+Qxhvo2toRojkZDob9evW
	BmSQPSHpsZwfnjXcnItbc1J1EsOczuUFT9N9a0N1uQ9XNgsOrVmwRs2vj7McRi9o
	pqLnczBqCdhWOaZ15w4Ygv3XIuKlr3xN5tIQIx6tPhrTV5KfbQbfa/bbIlC2yQki
	FXYQvORmV+I9AUwNKqf18lbfRDUXd7p0tLzl8hjeExyDOWxbEApi4IPggzc50x5E
	tyVu2yxr0+P1LXHo2iGXEBWwY/3c0qNtjQJRPFVEKMqNiwkw==
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vc8mb4yf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 15:12:06 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jn6JCd8qzMOtwdDqmBMW83WeguK1FwihM4XTtdntyMOcVooA3nVXJoSBUTEpx1h84GCuGzFX9eDYw7EGNPd6GyzopwpT5V5ZtMQNqUSuSCLZtKMNPzqecNtAE4/7QncQNJCfrQFQVKyy16sYBXk1pG+fImrjH3OZZZBGqeYXIpQuimJgGFUrDsc81EekZ0dmV+mFfSiWXf7o4gvEPggBs4ZFtGx4I0rSXLIWJKrbHSVNpqUWmKkH98GFsy0uCFJKS9ywMnilMfnXnkjKuYFSzckDFbu7K7G8GKGQR5cIrAcBnbGmJentWlDERdQZ3D1BABaagevUanFrISnIpCFcJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TC7T1TufZFoTvIM9hY/H/wM7+bMXcVmP6tKXYUcd4E0=;
 b=QJnHCrfm8CiVYgDEAlfKzGsnEgiEiE+cECb6avZ9Q+gr47mxcm7ivPZl+eOZMyaLhVeyDCtunfP9sLw5EemCpKy9epC/JvB6kqTDFgAWQh0hRJ0/jxbIADM9GgrvdoXosku6EujwuruDl1k2zM/xy6HEl4GrmlbL+tGzaN/kGf+RpTheMN7WB4TnkMMBt9xqlANK3WPS7kaLG6HpRGP+RWmYYAkSBSxco7yd8JXjO4yAF+g0MBwYnbKjFsxVyIG3Af4ZU941/DIPkLSk/ggDDYK5Q8/2pKHwz2XZnfxJt9JR/AgzBGvqaBnrSZF9Q5VVgIhYmZGKswl0tZOfll8E8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TC7T1TufZFoTvIM9hY/H/wM7+bMXcVmP6tKXYUcd4E0=;
 b=dQgIAca02gPwUSD5Inl5hbLUijPqcbFXHvQQh00KVfqNHPzCoqISu2527mbulDEfwT6Y2+9zjvzgnA1aA0A37kjnes8rgr1yzSgo1lw9rZLErHmfHNGJyfYiZRnpQhFk15VvBm4uwgvKsDnAJKjneiK0BF3WUKJQtXEC4084ATQ=
Received: from DUZPR01CA0058.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::12) by PA1PR10MB9004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:444::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 13:12:05 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:469:cafe::75) by DUZPR01CA0058.outlook.office365.com
 (2603:10a6:10:469::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 13:12:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Thu, 4 Sep 2025 13:12:04 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 15:09:45 +0200
Received: from localhost (10.48.86.98) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 15:12:03 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Thu, 4 Sep 2025 15:11:46 +0200
Subject: [PATCH] arm64: dts: st: remove gpioj and gpiok banks from
 stm32mp231
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250904-stm32mp231_gpio_update-v1-1-bcc7531cd00e@foss.st.com>
X-B4-Tracking: v=1; b=H4sIABGQuWgC/x3MTQqAIBBA4avErBMmf4i6SoSETjWLSrQiCO+et
 PwW772QKDIl6KsXIt2c+NgLmroCt077QoJ9MUiUBjvUIp2bkluQqrFL4MNewU8nidYYdKQ1OVR
 Q4hBp5ucfD2POH48T2CVoAAAA
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|PA1PR10MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cb3c740-14f8-47c4-6072-08ddebb4a4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0k1c1diZy9xNnhxMkk0ZlpJRkRqcW5wWUw3K1lTMXhMK0ZHc1pCaWx6ZEJW?=
 =?utf-8?B?T2RBMHJleWswWm1BQkI5R2pGZUl6UlpxQnJ0SGFsWXRFcXZQTkhQRHlmN1dj?=
 =?utf-8?B?MTB4dFF0SjRraGF2RE5ic2t6WjltV2ZSdUVlbkR0TFN6Nmc1cno2Qmc1RzRU?=
 =?utf-8?B?bGljQ0xUV1V5ZFJrZ0dnNzkreFk1NjBDYkNVWmwveWRHZnYxOWF5ZVdmcGx6?=
 =?utf-8?B?elFxM0pPSU52MDRUNVRFM0hUR2hPQ1l6RUgwYWlPZlY1SU81Um4zY2s3R25h?=
 =?utf-8?B?d0czUUd3cnBERlNFQXRaaGNPZ2NmWnh1QkpDT0JnbkY0SDRQTDdrWHpSa0ll?=
 =?utf-8?B?ZHJwQUhpYi9jVFUzVFVBNU9ieWRZaml0ZUFlQVBaU0FaU0g5MUp3a3lteEJw?=
 =?utf-8?B?UEhYQXhrVXBIeTlvY2NjVWdFTDFaSlo4S3M5dGxSRDVPRVk0SmpTSGJsWjkv?=
 =?utf-8?B?MHREeXBlR3NTRmc2SU9xd1k3elAyR0QzQUo2ODgvR0d5Q3JBVWp1V29VZTZh?=
 =?utf-8?B?a2QybVdRZlFIenR5Yk9oaW1BV09ydi9jOXgzd3RHaWVoV0o5OXhFQ0VDMzlp?=
 =?utf-8?B?emQzTlN1a3h4R2FoMnZ0UUVqMXhKVjg1cXdjT1FwckpMbWhRSk5UOTF4ei8x?=
 =?utf-8?B?bzNWbHQ1U2YyOHlmVjUrNEs4UDl0a25id21DOTAxeVVvTEdMR1M1Rk1zMXg2?=
 =?utf-8?B?L1hNMGtwKzNFL3kyRGhqTXNOMzdEV2c2NTA1cnovTDNiTERESkdxZ0RJK0JG?=
 =?utf-8?B?TDNaMytRVlJmTmxlZU92dldpMXNHVXZCdDRJY2pXSHhSY2VVM1BObW9pYi9s?=
 =?utf-8?B?SW16bG5uRUhQdFJQS0FTZGg2MWZ4Snk4aGJMN0xJc3ZQb1pIa0JOUFEyd3V3?=
 =?utf-8?B?UTRRTUdaYjRlZ280NEpsb0dXb2NzZ3N5Z0UzUWxxTGFFdGJ5UTVOMGtwb1hj?=
 =?utf-8?B?dHA5a0J6S3MzdW1pcGx0bW1zYW5sNk16Rkt0TW9zQTEweTZaQkdsbFZYYnpM?=
 =?utf-8?B?T3p4NkxiRmRwY2c1OXp5bFZhRHdQN1BXV2xTMUw4eW1Tdmw2Z3NPK0ErNXVD?=
 =?utf-8?B?N3BnVUFMWDlpaG81U284ZlE5SWxhbVp0ZnNGcENCUHpXc1BRS3p3eVdzdUNj?=
 =?utf-8?B?YXg5VGdXN01NQWxVdVQwdGd2VUl0WDdIMkEzRDhMMUt0WFl6STlGNGRyM2lu?=
 =?utf-8?B?VmlPN0J0eVNRbTNsN1R4UWk3UUYrdVJTT1dKUzU0U2hUek5Ra1B2SkQ4ejRZ?=
 =?utf-8?B?KzgweHFoRWx3TTljU01SOStYeVJBKzdFSDM2Z0h0L0RuQWR5K2lPcmxlNllB?=
 =?utf-8?B?QTBYZDN6a3JGODFrU1BtVGxXNjBYOHdid3ZCQmo3Myt2Yy9KbFdkUGxIQTl3?=
 =?utf-8?B?SFI0YlFVMXQ2QzFiMGo0bGZLN3NhOHF3ZnZxaTZxeGcxc2lyRTJKc3Y3OHh0?=
 =?utf-8?B?cGJmVGZBcFpHUEJRL3Z6S2J6MHRnYUtsdlVQbmw3WDRlSXphSWJlc3VOM1pV?=
 =?utf-8?B?ckxaTjFRakl4S3hTYzdJSHMyZ1l3WXFpR3ZabU9OTjFLM3FXNk5wbU1lQUQy?=
 =?utf-8?B?eWRacFdmNXFPU1VOdEFVSlRSY2JhVXRudUpveXhPQm1PNFZBeVdlOXUrVWoy?=
 =?utf-8?B?Y0pXOGdEc2I4MHIwWW1IMnd1RVlBNWNHTjVycDExWmlnOTM3enJIRFlvN05P?=
 =?utf-8?B?cFhNcjd4eGtMNTF2d0Z4VE1VL1QyNDE0WjUrdEZ2d0UxWVI1ZjR0TjZTdmpr?=
 =?utf-8?B?YWlYaWliWEp3ZkJoQ1g0WkQ2TUp6L2R1SlZudnRyMVhjV3RCUndJc3NvaDVK?=
 =?utf-8?B?YjJsTGlCQlpjQjFsYXNSVFVIT3RwS1p6Q0lVTHRmOFVxcVgySlM3UkVNUVRE?=
 =?utf-8?B?a3dEYkN5SVlGRFhTV2Q5ckROVVg1ajlCeGI5SnFmaUszY0tZWUZ3aEFBcjFX?=
 =?utf-8?B?a0xNalpNYU1tTW1UQkl3WVFxeGdlTElDaDR0WnRDREhNc0N3RjlHVm9Vc29Q?=
 =?utf-8?B?TFZkV2luZCtzaVRMTyt2M3cyRXNteHU5VEQ5WjN4MVhXQjNZcHd5NXZTWlY3?=
 =?utf-8?Q?keVMgK?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:12:04.4848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cb3c740-14f8-47c4-6072-08ddebb4a4ae
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9004
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMxMDAwNyBTYWx0ZWRfX6wQdtNKnVFVC 3kIRREE1bhaCz8XdoL0nOV3j8jKs9vcp2a+g1q/h35IzmuPlmIEfyRGRtG9VbZA1TklwuWxT7tL 258pt46Sv65TklH3NzNBpAo+EJe47r8ZKLz+vjRemOz+gW4xaBwanaTIFLf0md3oxzqwejZE/hI
 bYZHsdwqRWheV8j2+2zlY143+sq00pZNuNROp+5fnt/ZzCXDddFOwucfCX9MDmuCpFzd7nDWKCa OzVzjW4foDzBZf+kLEO7+VM8UBbVzBNxrJADDjbrfBLSbCBXmvnAK4vKH3Bgs02Eay5YQ4pvr35 dQ0eEA4aIQzikyt25zuYWJK1SQzyIN7iMY7NNlQp25hU6V4F3mdo4xAXn4KVggBw3dEV+mdXJMy ZvLzHPbt
X-Proofpoint-GUID: biDASaKQhe0vSE6nCPCSjEiTLbgn_WPb
X-Authority-Analysis: v=2.4 cv=ZeMdNtVA c=1 sm=1 tr=0 ts=68b99026 cx=c_pps a=0dS1Un6p98pWodQyLfc2pA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=-bC81zkkRrkA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=3taiimqfx7hiQp8dKJEA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: biDASaKQhe0vSE6nCPCSjEiTLbgn_WPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508310007

STM32MP23x supports AJ, AK and AL packages, where PI12 to PI15, PJ0 to
PJ15 (whole K bank) and PK0 to PK7 (whole K bank) pins are not available.

It means gpioj and gpiok nodes are useless in stm32mp231. Remove them.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
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

---
base-commit: 6d40d5ecf683e31a5e204d0a2f57035c39fc9c5f
change-id: 20250904-stm32mp231_gpio_update-7550ce44ec03

Best regards,
-- 
Amelie Delaunay <amelie.delaunay@foss.st.com>


