Return-Path: <linux-kernel+bounces-817358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A8EB5812E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495BE188C84A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670C22068F;
	Mon, 15 Sep 2025 15:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VGssqSGg"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F4B1F37D3;
	Mon, 15 Sep 2025 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950947; cv=fail; b=ZheJBApZ5DbfUbX+FdFL35UpztmtjZGwzVEtaew6MxlC27mL4qKFy54qVV41vrLZ2FvJxQIFKYuu4wuJdCvWyDyQoEKUc9EWWBarYWXszsg6mp3sJyOJjG767f15k7cQD+sNdge3F21uRDx+RNshFsfZDPJt59pxGNnbYzOg3v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950947; c=relaxed/simple;
	bh=+R77I18On3o3pyU4vikytHDyO+zU/zEghhheZNGeGgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WW1buKhDGuXohSI5WBvmcVGVn9MhV3JtqsNj42ok5T5LxewQRZP8CVwTtT5UcEKdRADiDgHzoryTDUzl/epX4K3lFWshLaZxjS/lQOqm9WalzRqQ0eRoFOIYC9Z2YPTNAyZIfWxS5rXanNpq1R18Aa3CaFIs4ZBnVPblsyUDqkU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VGssqSGg; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FFc64K010601;
	Mon, 15 Sep 2025 17:42:13 +0200
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010057.outbound.protection.outlook.com [52.101.84.57])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 494x1k04ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Sep 2025 17:42:13 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g63jIaLsz+ft0fU8FezPMN64+CPprK3I25JtCjeoYRCscqyDyT//XGGhigdMa589mE31YaJgeh5Zbvbe8eXcsq9Udl9rCIBudoiwnVech3c9nkhXKwwUHNnwRzwQTjI5WtxpB/qeDimntBAjuqKsx1O69u6MJAOhecBn2/hFdWgp11x9ggZ6PF+rWHmSqisA5paLffLuOcKtIATQcAx47DPSLTQ07pAv2nvOTf+5Xri6SJtEYeeywGf1X/a0jXmbTjrCuGQMSvpZuj42YFj0GIUugv8u8sa9rfNyvFXw0s1sdH26cEsBULJfpZnF8LtRVViYrkt6Zb7dkuR3n0yfqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7et17KJSK02yKUMTeLZVjPvA+f4Tq2soex/UoXd/W8=;
 b=oBbJET9sOkF/CwJibB6c7R6Jg4+RKcSFUkP7+we2ZdX6BcVEfw7SX4AxqA3XMozwM6feRDMv+QHHu8d9wsF+voGSs2i/z8WxVrCmVB1KkeyOr1x1+RIJWt9sZbuR4pem4AY+QhPi/w4DQrhm/d1v++SiupLoC1aITYDQ/pv1WAIW/iAje6cnYmda6sPxZ6ChFd0+7//BF6oQxCSmZh5hQf+xHn7HRH6pZqQ9pdfvGaa4BUgH4hrjd6Jzsxqi44V5RkKiW0yyesH7bQVJIyQQaIjFh+zp3dh0Gstm0SJGtbMV545h2pNkshbviJMeksTbbEKVb9KHt7pnhZdrkHQotw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7et17KJSK02yKUMTeLZVjPvA+f4Tq2soex/UoXd/W8=;
 b=VGssqSGgPNiEpVG2PsIr2dpoaT+Q0wN6bzxNsqXhBpJ9dVkZwkdY6A0V141Fe7xKC/Xi710jNp3vOBKuDMHklaNw0BGSvqQes9Tb6naERFQIEyopHuELsDtubGbeHSJOFOLUw1d1LeTnxkFukwA8zCTvQn5brOKfk+g3g/nzhwB2q0O87rURYDwg8th2aAkQLrmglXrH/KV2yYIVy7YQlKydGU/ZlY0yblGs93cyGVO6IHorVxZXeiIynQc5NEwFqagyimBfpe7YKMAkXq+IVAjbLO41p5soUZL2icc/XAAg3rBBD4311C+Dga+UfOeU9yUTqL1a1+eZQ5AUM4Md1w==
Received: from DU2PR04CA0251.eurprd04.prod.outlook.com (2603:10a6:10:28e::16)
 by AS2PR10MB7024.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:598::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:42:12 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::91) by DU2PR04CA0251.outlook.office365.com
 (2603:10a6:10:28e::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Mon,
 15 Sep 2025 15:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 15:42:11 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 15 Sep
 2025 17:35:04 +0200
Received: from [10.48.86.79] (10.48.86.79) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 15 Sep
 2025 17:42:09 +0200
Message-ID: <97a0e13f-9756-4011-86e4-6925d3528ef2@foss.st.com>
Date: Mon, 15 Sep 2025 17:42:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] arm64: dts: st: Couple of updates for STM32MP23
To: Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250910-stm32mp231_gpio_update-v2-0-8510efa2c5cf@foss.st.com>
Content-Language: en-US
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20250910-stm32mp231_gpio_update-v2-0-8510efa2c5cf@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885F:EE_|AS2PR10MB7024:EE_
X-MS-Office365-Filtering-Correlation-Id: ca89da80-699d-4d90-50d2-08ddf46e6fc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THE4Q3RGWEtyQ0t4d1VCdnAzMEt3N3BEOUlXdUJOSjh0OW4rNFNIMEhBT0Zy?=
 =?utf-8?B?b0RycEJOZGFXWDZsbHo0UDdtelpHMWhGdjRkZ003QktYeUN0T3F2NTcyL3Jw?=
 =?utf-8?B?Kzk0dzlVdzV5Wm40Mm1OaHRFVC9FL2JuemxyNmYwaDdObE9YekY5Q0VuRGN0?=
 =?utf-8?B?bk1rdGxQa1dDcWt2UlNUQ1I1SDhZeHgreUJtaVFSeURTQkZ0QVpXbTg2TmZ4?=
 =?utf-8?B?MG0vWDhRSWYzMVJQZjZpU2JBd3ZOalJES0lxcnl6TC81OWh1Vm9nOWZ1TjhS?=
 =?utf-8?B?dVB0N3k3T1djQlF3aEFpMXc0MjNmdVpzWTJ5VlZMYWpLVmNJNDNENERyUmw3?=
 =?utf-8?B?VGRsREFRVFJhQ0xiaUFCTVpCUkZHa0hpS2JYbUtUWWpidXE3eEZ6aFFpc3pq?=
 =?utf-8?B?TUd0Q3Ewd29iNTVtSk1BeVAwL00wK0lySmJBTnVqZGl3RERSbEtSdGFORjBC?=
 =?utf-8?B?UzErb21KYWpOU1NibUg3dFNjbVdnOWlacUllVFVBbHhlMVpPQ2dTTTBjaHFP?=
 =?utf-8?B?LzdmVHZNWmRPZmRWQXc0RHBONU05NTV1L294YWpNK3VyU3Y1d05TbmRWaGJ3?=
 =?utf-8?B?aFArYm5FcjVHMm45ZnJYalN6RXVXWEdEa093NkNpWDNGRGJmNTZxTUk3cDFt?=
 =?utf-8?B?U1dRQWYzUU0zMWZCdW1zVmcwc0JWVGJkNDV5ZXJhVGNaWERsUVZjSmp0L1hl?=
 =?utf-8?B?QVFrNG9PaGc5aFdGd0JsY1hyRXhmOEoxQnBTd3Exa09TOEdQVXZGL3dxOFky?=
 =?utf-8?B?REpHZXBFVUVNVHpnY1IzRnlOY2dVUkk3U2tTUVpFcXFDaXdCN3dCNUdJWGpy?=
 =?utf-8?B?Um9xZkR1Sys4TU5Zc0lBWXpUUlR4bThIM29WL2V6bnFaS2RWOTMzek1Ba3E4?=
 =?utf-8?B?N0VLQlptTW81TmRUTjNpbE1JU2lLcHFDQUxrYmZOQU1uR05LRUh5NFh5THhI?=
 =?utf-8?B?QjNqNzA1WEtwYzlqMjNKMk02VkNmeTBORSt2dGNNNlVzbXYza0RSL0NnMEd3?=
 =?utf-8?B?dEY4NTlEWk9XNFBSejFoeWhEaDdsWmVCYWRXVUFpa002cUJFNDUyeTdCOFdH?=
 =?utf-8?B?MTNPZmZtNXlQdnFLdjgwZTRBSlZobDJ6SnBtaG9IQjZjcEpJT0dpU1FudUVD?=
 =?utf-8?B?K0g1eEhQQ3p3K0pqeitmODllR1hEYVhJVUtpdUpqUjJBbE9hQmlxd3g0Qyt4?=
 =?utf-8?B?NlozRHlMazJVYkVCejZzdnZtUnZXNGY4NzZFZzBQdzJaZEFaeGlGOG9md3Jm?=
 =?utf-8?B?WkduWXJSUEJMZk9yMmpqcUMySXkrQVJ3MVpyc2MyVlhGL29pa1dmM1N4Y1Js?=
 =?utf-8?B?d1IvM2FzNVc0akNzVDUrOHQ5YlpsanpYeHVHay9naEVkNUUyL1g3RHhTeWtQ?=
 =?utf-8?B?ZmliamZzYVVCSUVCS3NwQVhrVU4yOHEyRUEvVFFNa1dLbUZTeG5VYkptMzNL?=
 =?utf-8?B?eUpIVmVtbkFrY2lyYnIxbmdGM0ViY21Kd281R2R2aGdYOXZWWXNSbVFtZzZG?=
 =?utf-8?B?bDhtR0ZmK3JTSU41Q2RHVHdRWGp4cmJzTHpVT1RBblBEOEFiNWlMSnlLT1hW?=
 =?utf-8?B?algxTjZDWVVKU0pOSW95b054KzJtelBxS2xSNmJvaXVPdUE5a3FIV3Ric3JE?=
 =?utf-8?B?emsxdVNHNythbEs3WmJoR2MvL0JzRDZ0enQ4U053M1c0eEpoRGFQT043SmtS?=
 =?utf-8?B?ZGd2RE5UOTBXdTZiUVY3eE01SnJ3dEpyeDVzSnJVTERsMVJzL1pTa3lRbkxv?=
 =?utf-8?B?OTN1Ry9nQTJwa2Y0eEhQc1p2eVJKRitPVUtWZ1preHMyYUkzc01QVVBKbzdE?=
 =?utf-8?B?UHBUQjRudUpjVlJIS2Y4YW9DQ20vWUU2UmtsVXk0cUczOFRkclo1cFVRamlL?=
 =?utf-8?B?WEg1REowVHZNY0ZKS1pORVlFSnpzTmpLaFhWeDFTdXROT0pvSzBnQ0JadWg2?=
 =?utf-8?B?NStnbjdLZ2xqRjEyWGVyRG5kMlpQSlloSUFxTlBhSUxWTi9MNkRUMjdTVW11?=
 =?utf-8?B?U25kc0lmdWZwQm43Q2ROc2NKcmVoNmRVODQ1ZHFaSlNHMGg0SE9VUWZqMTRT?=
 =?utf-8?Q?s46Uvu?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.44;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:42:11.4508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca89da80-699d-4d90-50d2-08ddf46e6fc7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.44];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7024
X-Proofpoint-ORIG-GUID: au2waPxB_NpeukFxyfcZEfyF5my6Xp9I
X-Proofpoint-GUID: au2waPxB_NpeukFxyfcZEfyF5my6Xp9I
X-Authority-Analysis: v=2.4 cv=Jv/xrN4C c=1 sm=1 tr=0 ts=68c833d5 cx=c_pps a=w37XPDA4sYKthlASMuCTjA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TP8aPCUxYTYA:10 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=hJygllMBqLbmra8X7gsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMSBTYWx0ZWRfXw4GUjS/Mcq0W U0oBVBqwYy+wIQU+pJwNq/Y8mng4mY40xpS4nSLqlnuyNxOgsB2uSFh7+GzlckhndAUb0x40DOU Y32Sg1ZVtRTqFkwgNAQUPY0v/UUYmKuJSB9jC05GzTOM66be8LJvqoKQK/kJ/v5xxDlwOunjVS5
 BpcKvr9+ChoYicCHhCeB17ts3Qj8ZmXczsrmv2CwnNdfGrFXT6mN2kikRnYQfEo6pedAA1J8N0a BuiNYtT1NnH4Uvlk0ZlSG1g4epUV/FvJYqpotWxHfhYflVCzG1B6xEcPfHuhEnxzg583hD+e+aU rwoube3cAcpq1bi9cxhOg44JWJNpUA+wX2YRRayvx1jZLSDGY/LVoeOGye9lgAL7ZBwR/Dtr6NX 8eTMP1Qj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509130001

Dear Amélie

On 9/10/25 10:24, Amelie Delaunay wrote:
> Remove gpioj and gpiok nodes, as J and K banks are unavailable
> on STM32MP23x packages and resize memory on stm32mp235f-dk
> because DDR controller control pin is not routed, so it is not
> possible to configure 4GB/16-bit.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
> Changes in v2:
> - Typo fixed in first commit message
> - Second patch added to fix memory size on stm32mp235f-dk
> - Link to v1: https://lore.kernel.org/r/20250904-stm32mp231_gpio_update-v1-1-bcc7531cd00e@foss.st.com
> 
> ---
> Amelie Delaunay (2):
>        arm64: dts: st: remove gpioj and gpiok banks from stm32mp231
>        arm64: dts: st: fix memory region size on stm32mp235f-dk
> 
>   arch/arm64/boot/dts/st/stm32mp231.dtsi    | 22 ----------------------
>   arch/arm64/boot/dts/st/stm32mp235f-dk.dts |  2 +-
>   2 files changed, 1 insertion(+), 23 deletions(-)
> ---
> base-commit: 6d40d5ecf683e31a5e204d0a2f57035c39fc9c5f
> change-id: 20250904-stm32mp231_gpio_update-7550ce44ec03
> 
> Best regards,

Series applied on stm32-next.

cheers
Alex

