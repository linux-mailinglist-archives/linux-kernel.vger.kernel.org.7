Return-Path: <linux-kernel+bounces-809719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 137D8B51124
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EEB61C24CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1D30F928;
	Wed, 10 Sep 2025 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="QfZxHuhj";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="gtWvIrD2"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47D24BCE8;
	Wed, 10 Sep 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757492723; cv=fail; b=i7wEGunmC9QhYmvxDPgwSvKc3wB/YhzZSm+lQrslqBMSgykJvw5AURr89wKJF0w0vghrEZ4uNNxUGd/1Htzrr02gD1fnWfkI/yela87hu8yTyRSycbOsChqXChjSO9w3gQz3hngBtv+UGaTxNmeJKJ1WsQi+VLKBrvB6+kc1Njo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757492723; c=relaxed/simple;
	bh=56REALfXtCMOTTb1cTyIoMEwZA/cEXwZM0UZhN1ZZrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bYSzqNYdAuocvmLV8q2K1Lg+lPAc0oGqh7xoE+SSdO0gBsxqmltqFnQNALf5me/vgSno0GuqabnzTyncnnJu920nzJpuNkFLWWB0WbZIgL+RZRz/I1CTeMvFcj9CTxB6e6R81TXiumEN4v3qz8pgy2gzbqQZG1TSQzGKVMpDcRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=QfZxHuhj; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=gtWvIrD2; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5prr3015763;
	Wed, 10 Sep 2025 10:24:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	iaomuW0gA41bjxli5jQ+CUiklJbR99OwwFarq/2FxjU=; b=QfZxHuhj9wo1W1E3
	wE+y2xiIm+zaLDFp2OPnl0CLDzvKjGAw/IICOm8QzQu8s09HOgrKTnVWLtQju3RU
	qMOV2+qMFRNNZpRz4bKfSPriEKtKeSF9jk8mDjRFMlg8H0D9WZlDG1ptiR/BBzug
	oDXHxEyY7ObJqel0NWuXJkMLM6X+Go5sQ0Uja5mE3rxH2N+bVJnE3KAWZRzvcWRD
	ygv6yfO9aHZ/FSgwoHee08AWGjyquDuNqw82NddIpU2iqrkZDzjcALTV2tFxeawB
	8RuOMaryxyUdFThs3Xuu0UIJWSyOmI6D634rCgNPd+FGYu6WZdDLfXLinxsQgt61
	evYLZA==
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 490xh1vqv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 10:24:55 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p2T4B2DiNEVL9z/vtgQ4loqCYZng8I6idJeSp2fYUWS5KOAEGlOn+U8jWFYdbU2+/mAgxwLFf67saMw17jeXLDovZeCX4iQM9SuwmVQyLvjf2/R00KpNNxeF6GP/vdS75BqMTvR8BMvVV9EkvbApYOCNITb3YgoWmXeRCUV38zXEHMMYS6IDb6how9hllz/lWzEW4pi37zMqKPy0t9lz9QexBrcw+fn8+m3U2qobSp/63x7L2ipwNzEd35lsFIR2tPkhkH94CcZwxUrkITBmWXiFLnHZeGe5ZE66DsKDktK0V7Qbdxbs0UOR12Eo2q0RKf2hbfDSSqP97I8yeGQACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iaomuW0gA41bjxli5jQ+CUiklJbR99OwwFarq/2FxjU=;
 b=lsScjOMZNo8wef7kGDfbYeM7wCh+1qVUwCs+pwB223t135Uw0VfXT5b94eUuPmaxIZ1A65iLdggNhzSVrBoQEjw9Det8ua3ulq0lYFilYVVPsN7xQMqyzdQ0f4wDpP6oOug8qdyLIEVYAs+N1rp/ggZx/zRNnqUQroa1TiBdIU1eKH3q39dTd1tyx8x9FDgSF8ImOb6BTuAu0LUKjL6th5B+pnAZ2gayHyUk1Ux90oiOvi4oqS6XsHS96kjanhN6XbE8eG3iaJ8eoVyPGLdZ4iE01GcwZ0a/5xDJqOAAt2Zk34Lv+u4vhZ6XqJVJF9NRENVNAmYLh815SZPrUAp/gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaomuW0gA41bjxli5jQ+CUiklJbR99OwwFarq/2FxjU=;
 b=gtWvIrD2SAkKvDPwrpc/dWjJrMjvLQgnYpHzOXkZ3/2qPFVRs6yueF6smdPPI+9/TUSZnFBQ1zo+UkO3cbLC2rOuw0VP+lhj6aeErkqWcKVuybRmMUe79iNMWHZPhoYYeErlHihKADDLfpJQz28v0GpKILe58s8D5c8UprGjAi0=
Received: from CWLP265CA0420.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1b6::18)
 by AS4PR10MB6208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:58c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 08:24:53 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:400:1b6:cafe::c7) by CWLP265CA0420.outlook.office365.com
 (2603:10a6:400:1b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 08:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 08:24:52 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:22:31 +0200
Received: from localhost (10.252.15.61) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 10 Sep
 2025 10:24:52 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Wed, 10 Sep 2025 10:24:38 +0200
Subject: [PATCH v2 2/2] arm64: dts: st: fix memory region size on
 stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250910-stm32mp231_gpio_update-v2-2-8510efa2c5cf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AS4PR10MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: cf8759da-803e-407a-4d71-08ddf043843e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WDFaWHdjVDFsNEpFVXZkNzl3d0VXbXl3L2t1SDhIZjA3S1ZZdjBLMHZkWDRk?=
 =?utf-8?B?YkFJeGdkcVJYKzZySnJ4NWhLeWRIRXVzNTZQRGx4RmRvVzJ5cFhXaDRRNER6?=
 =?utf-8?B?Sng2bERCRTdCczhwaDZ6dm9KUnRYYW9vWUo5QlJCY3hkM1ZYTFVkZ08wOVdJ?=
 =?utf-8?B?N1YvTG5pSW9oYmd3blRCdHFkSzc3WU5mNDl0Z3gremQ0Wk81SjBFUjlRME82?=
 =?utf-8?B?eFNiWFVzOFhJS2N4VGtuSmJvWjlXTTVFRXV1Z1czL3owVkkyOGdmcnZpMmF6?=
 =?utf-8?B?U1JsVlZuYkJZYnBYdG1SdEJVR3lqUFpuSVpwTkUrSlc0QlBEUk0rWFZxVWlt?=
 =?utf-8?B?eUxJU2g5SlBvZWFvSC9EeUsveFJyamNYNnAxUkN4WXcrOFI5eFRRajVDMjRy?=
 =?utf-8?B?UmtSTXZQVVJaeFhHSkJzU3F0MHg5YTRCanhVQkhjRE9ZQjlHR3BUbk03b0Ey?=
 =?utf-8?B?d1ZiMUp4RWxTZWwwWXNLemJ0Q29jdkFHMlNVZ2J5VjNyVEh1Tlp6TEM5YVp0?=
 =?utf-8?B?NGFOVFQvM01WQjl6amd5V2xzOEN5TVlxUzNTNkFwdkMrcXdBSlRaU3dYS2ZN?=
 =?utf-8?B?NmNlZWVBdHc3SVVSbjJTS0dVZkVhOWZuWkhmQ1JMRGV0c3FzT0VJQ0hUUkNx?=
 =?utf-8?B?QzBYYUFlSlNXSTlNaEZFYWZwMHU1QVRDaCtWTE1kNVUwWDZnTG9tSXhsbHY4?=
 =?utf-8?B?QkFvMDJ4c3BrdUxkWWtlQkp5aXVNNEQ0czB4bmNQMHZtOVhjNEJ4VFlSTndY?=
 =?utf-8?B?c0k5WEhZcDZSQW1oYmw4RWpvTHpxdEErVlhhbXRwNnhUVmpYNmJTNWR4ZHVw?=
 =?utf-8?B?ZzI1VlUxSW8zT0dKYkZicTFSa3c5YlRFSWd5d0dDTjl4OVh0elpuL051SHE3?=
 =?utf-8?B?L1JxQldwenJrVmVGWW5xRUYrYjRjN2xNVCtXZmtHSWZmeE1kblhqSHNxNEJC?=
 =?utf-8?B?aEZLbmZHUFJTcldMV0VaRWZxeldQYXRSc1BGL0VLMnZES1dnQjQ0c2JVZ1BH?=
 =?utf-8?B?Y0orc1JMeDh3K1pwVnZQV2VzaU5OMUJGcTFWTXVlZXlhdmc4R0J0Uk9ESzFE?=
 =?utf-8?B?VC9MZy9TSEVwU1JKVnlJb1pZK29TLzgrQ1B3UDI4QTdmQXowSjl2clBQR2hC?=
 =?utf-8?B?cjR1RG9ZZm56cmQyS0VmR29hNGc0OHluZkxKMWs3RGcrUWlEdVFuTjJHT1BO?=
 =?utf-8?B?Wk9icEV4WFp4NDJpaGFtaFJJWEYyU3hlVmVmUUViQlEzZE1rTnU1d3k2U0la?=
 =?utf-8?B?UHpIaGFzRkVhUlNmN1ZjQnJ4ZTVUTE8vRVZDTW5EejFPbDdNYzJYVm9UWUN2?=
 =?utf-8?B?UmNJTmo3NlEyblR0SDN5aTJJYUJtMXQ0OFUyZlFiZTRiM3UxYTMvaGthR2Jx?=
 =?utf-8?B?YUYrUWtDbUI0c2diWEtrVXk0TlFvYVdFbS9kSHUydUx2c2pDQi9lRG9oTnRv?=
 =?utf-8?B?T3p6NE5NdGxqWlhRVnRWVzVSbmNFem05aXZLdzkvYWV6YmJmZVQ4bGNSTnM0?=
 =?utf-8?B?Zk1VVUF6eU5mei93Q2tFN3pGN29FYWpXcFhlc2t2SUNEZEFPQUM5SW1JT0F2?=
 =?utf-8?B?SFVzb1FOYWdUKzduRjZwQXMzWkdRVmxZM0NteVRmVm1jL0ZkMG9ZdW9LRHJV?=
 =?utf-8?B?bnNDNUt3Ymd0bmVYRXNtYnVFWkxoVWl4Q2RiZEVWZFJwd3RMcmd5R0N4dFVu?=
 =?utf-8?B?K2YxRkk4ZzJmcmhoVmtUamIxb252MTNGTjk1b0tyVlNqNDhxL1hhbzRhTkVG?=
 =?utf-8?B?ckdwbWp5STNHZFNhN256ZW9zMVFUNGRiMjhFYlExQTlKaE9rVXdVSDgzWXdj?=
 =?utf-8?B?Y3pzT2FMQm45UCtZSVhodmVwVGhVNnNHK3k0ejMyVkF2aVFOWDUxV2NLMmVV?=
 =?utf-8?B?YUJYNUllUzdybjNhWlpQU2hxN0cxTTlaVElSdUM5ZmdKYUpiQ1FON2FJUHdO?=
 =?utf-8?B?d3g1K2M2bTV1d05wNC9aU0JiUEpLbmlnT3JmWVE3N21ZcStBZVd3VzVJbURW?=
 =?utf-8?B?MjNyYVgzaXhndXU5elhvWmsrUUdkN2hPUTcrZFptSmU0N0dxTVRoaHBtMlA3?=
 =?utf-8?Q?b4PXk9?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 08:24:52.7722
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8759da-803e-407a-4d71-08ddf043843e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6208
X-Proofpoint-GUID: Yp3aeA3eBAtdoksLYSTUOmJiadDl3AME
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIyOSBTYWx0ZWRfX8A183DA55Xes kvsGq8EdGhMdWoXszcZ7ulO7IOEBS//z21qZn2p8C1irz54CrxNFf8J9BWP+tk89ONP3DX2gc5W B39aV7G/d+q8ijdIU2DEoLvH0n3IU+IRAq7ZomDHLv1KK6Zq5ZQV83GnAU2lPjvEXFrVZ8bJ/Os
 3Gyj/ETGGmoX6R8oj15HBralibjxmOOalQTmmzvPjFsd2L60KGzeW5OeoA5eQ1CYGOlm5g3Nfh2 ahcJsWO2/dpnU9fMF9xkDY+ywQ78xPI0PTcnbkZ7/NFlwlgazUrnUmm2/r/NB8vc+eIzMN1SGyK oFihN34c411e5j5jYIs9ymLrvnu4r/UJuXBwwoXCdcLCAD3yf78qnLkTgHqVLCzgTOYILrRJMe0 M8XjAGkV
X-Authority-Analysis: v=2.4 cv=VKfdn8PX c=1 sm=1 tr=0 ts=68c135d7 cx=c_pps a=jm0U/TU/I4WKL6ulXPbHDg==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ifg0f1jqALsA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=WDhxaK7bLE2TBr9Bg-AA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: Yp3aeA3eBAtdoksLYSTUOmJiadDl3AME
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060229

STM32MP23x SoCs provide a DDR controller supporting up to 4GB/16-bit.
The control pin to properly configure 4GB/16-bit is not routed on
stm32mp235f-dk, that's why the board only supports 2GB.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index 04d1b434c433e5f76d120f4bd254c15a2de3fb94..1d0ccf4a03314703553facffde3d41647645ea3e 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -56,7 +56,7 @@ led-blue {
 
 	memory@80000000 {
 		device_type = "memory";
-		reg = <0x0 0x80000000 0x1 0x0>;
+		reg = <0x0 0x80000000 0x0 0x80000000>;
 	};
 
 	reserved-memory {

-- 
2.25.1


