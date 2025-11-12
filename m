Return-Path: <linux-kernel+bounces-897634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB444C5341F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13F62351E23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63B5346778;
	Wed, 12 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dt4DFOMh"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5134253D;
	Wed, 12 Nov 2025 15:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962533; cv=fail; b=sLGwL1NkREe/P5oLFXTvydYh7cLqmHwdXOZwFrhEvdlQApH0f+xrGjozaF/lrGYg5iE6+P5TKfuRPRY5UKeDtC3TBB3MjhsfrHAbXuuyaJzwPZgd4mQKzrOnyj2H8BDp7/+YSVQXgfyAGeab/eGYwou1Vy8ZKqt+mLlqHHEwSTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962533; c=relaxed/simple;
	bh=ZMGEVUl+h5hjrrQ3a8Br2QNX+iIk8NwICyRDXVPvkE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VPHOIMueBZQxfeCohEJEDsbJyQziBCjjSqA7LF0V4uUS1i67bqJN6voXrnVR/JGXBAmDaHNhhMTAfwsGNXB6YE9aW71pqhSlUV+3EmIsDmRzAtiwa0OnUTSkZDoZT6Gp5wnQyRbHGkzyrfmo9sPIsF94rFLgzE9Fa+y4GwB8LTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dt4DFOMh; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFlGom1938350;
	Wed, 12 Nov 2025 16:48:41 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0hsam-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:41 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m560wn3e2LZT0zXAZJPI1WLy5qGDCpP8Rw8o1A7GiErI1RvB+ujUddOsYNZEciJr3j3Rvn+7sHb7IIO8HjMpjvRWi/4q+xx1gt/R0gcVlGD7XUqTMsE3wT0NAWATwnUPW+AteZpTPAbCtSUelF1WiZFeQodWEFVEIXl60BlbiXhpPnfBco1tPQ7ImFOV55RxBNvSXJTovl5fLXA0tset3/ALFeUBgoRrWkDDstinA+bhydyTxZPy0n4sIrY8Q1X2HvJnhMi2Pe7cWelZIvKa9bYzrxdvU7CNd4sgYonjt4rDPqXl/BnC7bh+KK0asCzFUe67wxmp8o/LAz4YltGrGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD+wOmDCOMxNR05Ln8BWKobtzYNSLr2tboWtbq9UY4M=;
 b=gx8/eqyMWWKxqHt+Ztfpw8vRY4aBk8UumRob76IyUVrDnVz1z53P1Osn19TrlL5H2r4KG3oxMW2ohUKFwt+lEu92Gk21vrP7+0zpDRWJlBJ/IqTzVYvKyJ8mv4ySxqcmLr6jgk1yqyrEcljlV1qlVS2RsW2+cRyxdKgZWuU4gZ2VDUlCVbRPW9WSHcgEp0TwIQMj+EHou9YWwSxsnVvX92yGjciShUGiJzZeVQluxV8Rnbu/AgTuqacwvZQMANlH94kNBamtfdSNoEIwE/MnhSe3H6g0lyM2RT1qCrG8P6Ed99huSLsj7sdgKnMgoLDy94GWFH9TaWowYG3Te9X2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD+wOmDCOMxNR05Ln8BWKobtzYNSLr2tboWtbq9UY4M=;
 b=dt4DFOMhudDxZteIgrqzwA3RdNMbQgOHEby1Mka8Z+L4jf8S0nveeFHnCX/J4zn0bz936Yd9gh4glccPCSKbHMAUzW4mxthdllGA8V9BMfhTaRcI4M6XiISUNWeDdpx2sYBV/PlcDp1qtuH5+XvrDnKAA73/xT6U1WdLK61P4ZF5EOIDxh4bUYtFmhYUCWIDibY0A0Mg+eujP044AbL+3hjecnFBpWKEiwYJgjrhbw/uSxH9KtyVJumJzpOsAwsg6JIoDvn7wPiZ8uFnunh+ZGrjirnwtwqWM//70/oqsCh3AiEHWMyBZbh2JFciLmj9cMQai2GMRx27p3px/V4NlA==
Received: from AM0PR02CA0150.eurprd02.prod.outlook.com (2603:10a6:20b:28d::17)
 by DB8PR10MB3498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:37 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::de) by AM0PR02CA0150.outlook.office365.com
 (2603:10a6:20b:28d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:37 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:40 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:20 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:14 +0100
Subject: [PATCH 11/15] ARM: dts: stm32: Add boot-led for stm32mp157c-ed1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-11-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB8PR10MB3498:EE_
X-MS-Office365-Filtering-Correlation-Id: 48398562-960f-446c-0f3d-08de2202f1cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVdwbUNvM3VGWTJGajhuN0lNd25JeW94QzViSGY3THJIZXhaMTNoaXJPbUM2?=
 =?utf-8?B?S3RDbldzM1BUNHA0elV2WHJVM1UwdSt2NUZ6R2tFd0ZjdW5RRndNVkoxL1p1?=
 =?utf-8?B?WUdDWkJXc2t6OVZRc0k0bFVwQTlIMGZzZmo3REZ5bUhRZ3ZEM3pxYXNsK0RM?=
 =?utf-8?B?c3dLVnZxS0dEbzZ5d0Q2R0NlS0RwejUxWExYZHpSaHI4QTNFbCttSmpHRHZD?=
 =?utf-8?B?STc5TmVFaDd0cFFzOXA5NlUwL3BoSnZnaWtHUkJiNXRWYTFnZ0JIOHl2NDha?=
 =?utf-8?B?L1hyVUdCOGphalpGR1JqRndhVEdRVlR3OVYzMGtUY1FPM1AvbXp3MTRuOEhL?=
 =?utf-8?B?UzRnam1BT0t1MzFrSjhob083Y0xGMXA3eE14QkFoZGlmSVVVMHFpYlA5UFNY?=
 =?utf-8?B?VzhyR2FlODg3R0VTRjhkN3RmZVgzVExwR2FTdXpjZnFNdkd1TE9PRFVaWFRG?=
 =?utf-8?B?TWpyUG1MVzI4QjlCQWRSWWVGTGdSOFhidG5YUmQySmJqL0dUVXNWS0d2djlJ?=
 =?utf-8?B?TVNjdmEreFVoZ3UxZ0FxYTNYYlZvRnFETXdGeEFYdW9jVDVQVjU5QTZ2dHU4?=
 =?utf-8?B?TGdiMHl0KzBNTHp3bDl5dUhjOC96d29LazJLYkF3QmI3dzljTWxReTh2K3dE?=
 =?utf-8?B?V3RuVis1MC9xYnQyMm82Ly8zT09HeFhlNjhheDlRd3ZpYkNVb3hsa1pPQ3Ew?=
 =?utf-8?B?NllNUml4bndVbXdCc0pidHgyd3NZZkVEeW5jdVJsWTRDcy9PNWZzU2pvRWNB?=
 =?utf-8?B?Tlp3ZlZIMC9aQzBOSThiU2t5YWQxMi8rL3J3MDFyY1NFdzd4SHdxY0VVT1lM?=
 =?utf-8?B?WEJySkxDZVFlRDRJRmx1KzNSUmpGNjVKS205NVhQZXZTdUVFKzJhRTN2dDVj?=
 =?utf-8?B?U3FkZVZ6Rk9TeWZoRFZZSXI2cnFOSkZzTEltbmRFbi9CRkNOby9VOVBPNVBv?=
 =?utf-8?B?UWxhNzkrMHR6UlFXM3I5alJnWjlyemVNQ2lTSG5JSmlpY01kNjBtc0hCeW81?=
 =?utf-8?B?TjJ2d2dDNFNCdE1nUHdvWWY0cTluNFlmSURkeHVnNzdzN0pmaHpHaEh2Qk1S?=
 =?utf-8?B?dmo3eDRwQ2NBTnZBSjhXcURFNW1KUTNhenIvaktzL28rUHNzdHYrL1FLeXlN?=
 =?utf-8?B?N0RtcHNYeEZKUUN2VktJclRPS1llUHVyUVVIL0JoS0VEMjc1b29vSW11TzdD?=
 =?utf-8?B?ZWdnRFE1ZjV1Ymx3ZmtYU1ZzUUV5aDdBangwUUlUUnN5TWg3a0JZWjMydEpy?=
 =?utf-8?B?TDhYcGFuaExUQ2M5QmZjRXhxSTEwU05SREFXMmJhWEdldVpnSXhJdWNtaWdV?=
 =?utf-8?B?R1V6dFBwWVV3TXB2SVl6VHEvci9zVG1iL3FxV0wwUllvZzJPR0h4Vm1KZ2Zk?=
 =?utf-8?B?RzVDeTl0RmYrVUx5OE1POXdWbG1vSHFMaUI0TXBIUWltMVVhUkx6NmVEVUFO?=
 =?utf-8?B?ajNCb2wxYks5eENrVUVjWVdsTG1kLzZNRC80QXpoSmYwYVJhbnlLS3pQSzVJ?=
 =?utf-8?B?VUI2WXY2enREa3VTQytVY2hHN0FMNlBwRmpJeGJzS1A1UVNhbEsxcEp3aTR6?=
 =?utf-8?B?MCtUVkxpUDNUVTFTMVlWcVNGL1R6ZjRrRjdKMHZPL3oycEhac0lHY1VyWTNK?=
 =?utf-8?B?Q1YvcHNEYzM1bXNnRW9mNDkyVmxUVnVrcXo2cFdKT3hyVFIySXpjRnlXbHRj?=
 =?utf-8?B?QlhaOUNUUmlBOGxLQm53NUlTYVhMYjlCYVNwLzFXSVV6YWt4b2c1OHN5M1h4?=
 =?utf-8?B?ZHZSTnpPWjVGd29MSW1EakJyNzZIaVFUZW5xWjl5aW1IK2lwZ2N3TE8xYS94?=
 =?utf-8?B?UEI1TWZIUWhBNHh2eEgwaW80V2MyWDJwQXZpUGt5WXczTnkwUDUrekFieFdz?=
 =?utf-8?B?Y2d2c3haL2RVOVlGNnczaU81eUVHRnBsVUhUb242N0ZTYnJ0SzRFUDFlaWE5?=
 =?utf-8?B?SDQ0QVNCM3o2Y2daZnVPMEhValpSM2dUc3RwZUY3Z2Uyd002M2ZsNWVmM0s0?=
 =?utf-8?B?QzlhMlpnMVN3aC9KaDRPMzh5c21QUnhsZXp5cktzeU9FS1RnZE0xOFFndmVM?=
 =?utf-8?B?bjBOeDdlZFBWbjBsVUZRTk1NV01MbUZFdjd3UWRtakdQSUNTQW4ramdXRmkr?=
 =?utf-8?Q?djeM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:37.4389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48398562-960f-446c-0f3d-08de2202f1cd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3498
X-Proofpoint-GUID: NL4Tm6bn7rW3d9kaV_HScwBbt3uSlHNA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX72wE3CzcBp1B
 t94UUaAk3O6XhldCNlRrgmbGS9cQxhosxkOC8q1MMOeRJGddvSQ259yY1fF9VdRCR5bkZXFV7FI
 SQUjVBqaK2VOjTyTl1Sv4aHlf8ZIiI1h7UNXrLQHbHYiHBxxCG1WoQvPZNLt/54WYswTQqVydEd
 ISKB4VgqgSu0H5zsXEFECn6HNG9cq1eFC89p7Xbe7D3K7PxyY3X1x+gVp5C3Nc/UEtaTfhMYbVZ
 bn/15pZFT3LyRQsbVRiCK9TNYwawj26oWCtmwfIhbaeJIg2lrP9STAM8pSRpzv6cE4fTh0d70hl
 KkhBWMpCnj/Nvm6C6kIGsFy53MOX3AOEC3u07dPOACoXt3YEnl2sX1E4R8tUNbr5/AA0q+hZDvX
 plqSAbG+dWBTdKLdcyY4FcDcextHzA==
X-Proofpoint-ORIG-GUID: NL4Tm6bn7rW3d9kaV_HScwBbt3uSlHNA
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=6914ac59 cx=c_pps
 a=hKIJfTMmGXcoSyh2svBxPA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=zIsizn63LtRJFoyuEFEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
index 6a1c4e5d31a4..49dd555cc228 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
@@ -74,7 +74,7 @@ retram: retram@38000000 {
 
 	led {
 		compatible = "gpio-leds";
-		led-blue {
+		led_blue: led-blue {
 			gpios = <&gpiod 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "heartbeat";
 			default-state = "off";
@@ -89,6 +89,13 @@ led-red {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	sd_switch: regulator-sd_switch {
 		compatible = "regulator-gpio";
 		regulator-name = "sd_switch";

-- 
2.43.0


