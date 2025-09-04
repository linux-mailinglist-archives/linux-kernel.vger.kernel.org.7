Return-Path: <linux-kernel+bounces-800189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D144FB43464
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5873317A363
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFF12BDC27;
	Thu,  4 Sep 2025 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cNCyZrwA";
	dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b="A4pBdR5k"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F9829E116;
	Thu,  4 Sep 2025 07:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971673; cv=fail; b=GMyopC6A/Z639ONSXRv+9XNcOwamsXCNrQSrNb93eMVqVK3osPBePoc3Tg/08Husz/xvpn02SBJK+JXN7iXgAnnM3RTL3HQC0853mNTg/oZl6n4u+leWIEVko9KxrlxeFxtztU33XDaDBa/+Di6041d49EwUH81/sk1MiUsuVPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971673; c=relaxed/simple;
	bh=/jSxi3Cp6PVsd8OxX5W2QWbMou7nSNSMnqrCD0f0E84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kUyPrHnoXMOYD3zDlVcKkuCbBsyFB8GMF8iYE5E5YVZ/AIQVNiYIGa4RFW0kdTqnfzS7+EwPTZVAnGexy08ltpjaodYJQ3sQi0JIOw1nvG3wVmJCw87lufNtvQvj5ZTRLckYnA2+gubKSBvO8TbdVGfpFG82gx0WoKYRjbmk4nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cNCyZrwA; dkim=pass (1024-bit key) header.d=stmicroelectronics.onmicrosoft.com header.i=@stmicroelectronics.onmicrosoft.com header.b=A4pBdR5k; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5846R3NG029847;
	Thu, 4 Sep 2025 09:41:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	lwHbTxLy7peh5nYCVtB/o67dVblLDQBWz2rtUMh+g1M=; b=cNCyZrwADL3AmKLW
	3iRj96NeLyEM6nZM0woKMH5HLgwqagQY0WMKcTSnajvBw+e3dFcMhhP6dEAUGhV/
	etyMEuTzSN/bQizusIYumLdwBBA01V0G0ZZ//PKHD7VaiWlK6X6uEpE2Nn7ZlMMy
	2hvgNG5juk9vEGQNB97hPfM7Sp7n3zyGatZiBrJbvL0RfMcPEjbd2SwsZzk7At6j
	L0dFHueQi2/MdBptnMnfOv+ng/BOuEivwCB6b0Ol0XxGm5H3iOCAPx9grOTcBWy0
	+7MvBaqRwmJukf8nHs21uOqph8vtkl+NFpPaBpbx3Er+JNEKjZaaOtYIBfutAdo0
	fXjKYQ==
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48vav2tapr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 09:40:59 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LSfVi8T80jgBEZMBQ6pMP0IFnbUfH95VeUDjOFpxYAYgkFZ955iN+zlwlxZmHjrHB6b4I3SKD4vMyOabhsWWzcw0VTF56GU98d5wuk0XQh18HZ/E2eQNqgxrftSsYdVouN4NOWQSvXHpWOK8VHmshNYrvGZXxG9/Lr79X40SQtvGoqU443nlm3r15+GJZGFXFXUgNsfUv/4ewee7IuVbJ22oz/Z4annVzAixkfio+gLUwo5GAafcwSQdapPmKuEYVgG5F8+o4wlcvzOwqM4Xsouj/LQHyLn9gXvazHtbIAReqBn0OKOQ5uHvS9RILv5nQqhsGyDdT9fXd2z2FuhmtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwHbTxLy7peh5nYCVtB/o67dVblLDQBWz2rtUMh+g1M=;
 b=eyvxL3rl5JZG1JKF4HVULQzPRoJhfOb5/PChzQLY1m59+UEi6f/vei2pW/uQR3Yn+rJwd6E+vbBmsoi9biLklewCyEKgpjR/7h9UPI49DEObF0EkOVGVIgLbsGs5FrzhJcIZofwNGcCFdSyqP5dE0Kb/1sapRr7A6pwgPOIYrLHErBprOnyEEvthgI1HzL3eXT6D8B/VUm3A4xwSIu7k6dNOsN4ycbeK0yUKDeHvR1eW1FG8miufiVbenICood1oKiH/F1nUj8Uhei1pvD+qEk+kWfyPeUrvna/r0WESxAXTQbPCPIs3RpaQUskWRXyiHh9DcDC2SKWz9dBOco5DDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=stmicroelectronics.onmicrosoft.com;
 s=selector2-stmicroelectronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwHbTxLy7peh5nYCVtB/o67dVblLDQBWz2rtUMh+g1M=;
 b=A4pBdR5k6wC1qK+ZjD2qtk5PhU1giYqx0OJpEr69Z8oogfZh1GTVp2WJHWJl1t7LBnp3gc6YYTqmqbOkANZXezfoLpAvhnPKuHOxzQ1lJfQRNUAMWtfi4ckd37hUwjVwRJm+WZpSuuIiCmb9j0nzLA4fZt+5EqD+m3ND4Xm07IA=
Received: from DB7PR05CA0066.eurprd05.prod.outlook.com (2603:10a6:10:2e::43)
 by AS4PR10MB5247.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 4 Sep
 2025 07:40:56 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::9) by DB7PR05CA0066.outlook.office365.com
 (2603:10a6:10:2e::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Thu,
 4 Sep 2025 07:40:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 07:40:56 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:38:37 +0200
Received: from localhost (10.48.87.141) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 4 Sep
 2025 09:40:55 +0200
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Date: Thu, 4 Sep 2025 09:40:59 +0200
Subject: [PATCH v2 4/4] arm64: dts: st: enable ethernet1 controller on
 stm32mp235f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250904-mp2_ethernet-v2-4-05a060157fb7@foss.st.com>
References: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
In-Reply-To: <20250904-mp2_ethernet-v2-0-05a060157fb7@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AS4PR10MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: df1f5ac3-c353-4953-5047-08ddeb866233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVlwS3NWbk1nM015d1BqZ0pKeXlYUGZIM3doOHp0ZFVNc2UvSnRZaWdQOUp1?=
 =?utf-8?B?Njh5cm1OMWY1ZzNxa3lmOW81a2txK1ArT2MxT0xrY2pkSDlZQzdReUhITnhB?=
 =?utf-8?B?QVNoQThCNmVGcjNxTm1QaitDMTFyT3BxNW40YXd3cGRMTFRqM0ZuVkVUNVU1?=
 =?utf-8?B?bk1BYWFMYlB2cWRkZkxZL1lBZDBvY3NHdHRUNG5RSTVuenRUTlBqZk9lNUtl?=
 =?utf-8?B?aWVHU2lVbjhmWTB6d3RTNVJVSEg2VFQ0Z0dJakFzaitjaUxEMC9zRmpFM1FM?=
 =?utf-8?B?dlhpeHcvUi9DUER6U05VSHRjU1FxZm1kT1FzRmFTTEl2RkwrVDVxeXl2SUVU?=
 =?utf-8?B?ak1pUC9mVS9NUlNmeVhDcHg1Mm9xQlBibXEyYmVlc1dRcmpLUExmTk1ncnlD?=
 =?utf-8?B?YmxxMGdJOEJpS2d5R0JPbjI4bm1rSVkrUWpZc1c0dzZ6R2RRUDM5SnNmRis1?=
 =?utf-8?B?VUl4TThDaGpTaFpUOGtDck55bVBlMURRV1B6SUhDRExMZ0FSYVRnVXNMNVdH?=
 =?utf-8?B?clkrbVRtclJ0dmlTK2UrUG4yejVjdHJHSEQ3Vm5WNWdFcnhRN0hYSTJ1NzdF?=
 =?utf-8?B?dVZqOUFwTklwZ3dvSXEwQmhZeThyM3BiOStSZGlrc3pubmNja0Z6MXFNVXN2?=
 =?utf-8?B?cUQ5RzIrK0ZrcGJVVG94R2lsU2EyUUloMzNKSnkxamQ1QW5Cc25GaDgzOUU2?=
 =?utf-8?B?UVExYTRkQjY4TUlRNDI4cWNXTC9LcENHVDFNM0lBcU85Qzd6Kzd0UFFsZTNa?=
 =?utf-8?B?Z2c3QzBBL1NIWnI4aEh2L0QxbmVKVDJjbEx1aVVVV1FGY0I1bmh2U3BsNnhQ?=
 =?utf-8?B?OVFuang2Um5EV29DTllnZGxWZ091QUlKSzRCR3ZZc3Ixdi9hV09KTUhRL25F?=
 =?utf-8?B?QUVLMGI4Y1QvcVpPRGVDcEZqV0RBdE1ldFdEL0Vtc2RKa0dLcGxYSXJjbm9p?=
 =?utf-8?B?eWt0bnE1Y2tGbjYva0xRMjBObzAvMERVVWJKaUwxTkVqdVE1LzhBQ0crRjJY?=
 =?utf-8?B?YXd2N2RCMXU3L3BPeCs0WVdrS0RxMGlRNUhwd3J3cnU0WmJiekF2cCtLNkJY?=
 =?utf-8?B?akE0SWw1M2dHS1Vtb3ArZ1VyeEdaOGJjb1gxa1VDL04zYTUvMzNaU3B5eHVu?=
 =?utf-8?B?UjF6RktsUWtYSlAyOTVETXdMbis2WUplMkJudCt3OUdJbUtaalp1aERIU3gr?=
 =?utf-8?B?MldiNHJkOUprY0Jva01qSjZIZUg3SGI2UmNOaWFBZGl0Sk1laEt2dHYzTEY2?=
 =?utf-8?B?UlJVbVV4TEZ3dnJ3eDlqS2Rha0lCRmRiRU1iZk8wR05ycUhITW84ZkhkWTc4?=
 =?utf-8?B?dU5oRUtFT3I2UFRhcnpVSGJlaXdJbTcrNUpubDhENFRLNjdMMVN3elRnTlBW?=
 =?utf-8?B?U3hPU2YwSmMrRUpHejFjejB6bUlGMWF2NWdyTzlsbmNFNkQwMzdvaVEvbC92?=
 =?utf-8?B?aG5FQ29Tb3BERVRvblFIRGVkR05ML0NWZ3kzbjRLSDIrMjgwRFJaNmZEakc1?=
 =?utf-8?B?RGcxQWdYdkZmSHdDVUdiMmJGWEsxNVhBWnpjWUJCM29UUWFheGVVYXdnK21Q?=
 =?utf-8?B?RXo0V0hCQ1V3YU0zZGs0aFJkZWM0c29PRlduQ0VmTGtydDNncUxBaUpYekJl?=
 =?utf-8?B?dEExOXFTNEk3d3QxS0NqTTVmU016bmZYZFpIRWo5Sk9nN1RpRmcrS1RJZkZn?=
 =?utf-8?B?RlN1dmpaWWFkUFlFeER3UmFvcG81YXlRU2orNVltTVFISU1BTHViVjBrR1Fi?=
 =?utf-8?B?WmtwNk5xVmtXRWF0d0RyTjVVNlh5UDJzcFhkUXcwZEo5TE52aGpPaVpER3RB?=
 =?utf-8?B?Y0NXVzNXcERyWWdOWHpQUFhheGc0bFo1Nm9WRjNzUU83MXNPMFYzRzI3dVov?=
 =?utf-8?B?d0dXM3ZpUUI4Y093c01TYmlSZWhoMlUrQnBxWGdpRnlFb016aFkrSVFyYyti?=
 =?utf-8?B?UzhmZklwT0p5RWlJVVhlcTZZRUJDd3A0WFYrQlp3Y3ZzUDYwQlVzRThNMzMz?=
 =?utf-8?B?SVh4Vk1IS2lwUWhPc0l2QTdEZUh5WkhuMDRCY0l3SWhidlh4WDFURmcwblc1?=
 =?utf-8?Q?3NBbiX?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 07:40:56.0872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1f5ac3-c353-4953-5047-08ddeb866233
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5247
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDI1MCBTYWx0ZWRfX9wbH2YMAlAh4 pcemXc4HyYzqxe0X0mXE94m5re0BgoHJPi6KWZ+LqYt5p14iTVqKYqC/po8/fBQ8Nq09w/fb+s1 xJwRDlyh4cLCv/Jc/35nkqeyKYZAiy5oQVOPi099EtFmtGoV7a9nfG41Qv5NskKNkcIMpJMC42Y
 GaG2bIs/VaFNNvRnZDoF0hVWDK/EsGTjlbiZxJT+xSvSux+PYS0kb8uDk9RmxjVvYECcfMGlfmq O6Dk9lALEw3JXht5DQYDJiEK68cRALl2hqD45v3g2WM2KG2LVNN8RtQwzsZi+mPSYNPpfwlS+JO jzo5ZVqMvqgxBqPZr5PqMfZKQWTTAFpOwDnCWD8No3jwiys4xa+tTvfDUo7toCgEX1g+NX0ys2V mHFhTay/
X-Proofpoint-GUID: wsl7ckXqmqFC-zVayXY_poLZNlQeiCpg
X-Proofpoint-ORIG-GUID: wsl7ckXqmqFC-zVayXY_poLZNlQeiCpg
X-Authority-Analysis: v=2.4 cv=bchrUPPB c=1 sm=1 tr=0 ts=68b9428b cx=c_pps a=guev5NpOtKZLIFWBmHTLzw==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=ei1tl_lDKmQA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=FUbXzq8tPBIA:10 a=8b9GpE9nAAAA:8 a=iuNovMGHdh9w6S5YmP0A:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1011
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300250

ethernet1 controller is connected to the RTL8211F-CG Realtek PHY in
RGMII mode. Enable this peripheral on the stm32mp235f-dk board.

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index 04d1b434c433e5f76d120f4bd254c15a2de3fb94..29ccf8dab35e85fac15ae64f46c65c296b0fb22a 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -19,6 +19,7 @@ / {
 	compatible = "st,stm32mp235f-dk", "st,stm32mp235";
 
 	aliases {
+		ethernet0 = &ethernet1;
 		serial0 = &usart2;
 	};
 
@@ -77,6 +78,28 @@ &arm_wdt {
 	status = "okay";
 };
 
+&ethernet1 {
+	pinctrl-0 = <&eth1_rgmii_pins_b>;
+	pinctrl-1 = <&eth1_rgmii_sleep_pins_b>;
+	pinctrl-names = "default", "sleep";
+	phy-handle = <&phy1_eth1>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "snps,dwmac-mdio";
+		phy1_eth1: ethernet-phy@1 {
+			compatible = "ethernet-phy-id001c.c916";
+			reg = <1>;
+			reset-gpios =  <&gpioa 2 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
 &scmi_regu {
 	scmi_vddio1: regulator@0 {
 		regulator-min-microvolt = <1800000>;

-- 
2.25.1


