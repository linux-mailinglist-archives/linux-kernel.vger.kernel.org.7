Return-Path: <linux-kernel+bounces-899718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D282C58AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0984D4FB605
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5B12F4A1B;
	Thu, 13 Nov 2025 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="oBNAG+iH"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226CD2FAC12;
	Thu, 13 Nov 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049249; cv=fail; b=LZriT6Rs0i/bW/cdb8aQqM+Ka5ExCAz10EhT3GVw4zPFHPaiK7Uko3qaVsuzzUHyHMoYFSkug/KB420EazTPfqle7Mu3uvJNdSinMeLBgnBL8anYcFgaHhCVJI8WMyDLY9SldF3jVNCep9e9V8ucG+QB3stzvr81URM5I41xOUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049249; c=relaxed/simple;
	bh=vvcBApb/cZ5pv0si/v6Yf1oKTyqfPEoVDpL/1tWmqeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ipd0GofGWo9HmbCxULUyLTO1rx1t5Il0X3OR42Xb9C+C2qL7z1KZUk22pSmOUEY8FllUmkSbv9jS+GnWIo+XRSEIu9CAhkyXVToXGkyZBuc++bxJp8qVf9CEanl+Hc+20Q0iwmhL0Zj7N19zxeGu1Sxr9Oij6j45ZqD02qTLIug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=oBNAG+iH; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF9DrE4068774;
	Thu, 13 Nov 2025 16:14:03 +0100
Received: from duzpr83cu001.outbound.protection.outlook.com (mail-northeuropeazon11012058.outbound.protection.outlook.com [52.101.66.58])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acretdrv7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SMGLBVjIaBlCO74YCRx0/f++j0JKgCzxXMKy5suMmvn/+Q5slbjCCPPo8lMTGPPwb3Vtk/K1sEn4eUi9YEMqr/FxvEvqmfCQgRwPXIUL9mhnuFfvj8GhJtVwQyt+QRLyh0Gdtr4Qi+rIlpNX3gLQyeLxy4jNkgzSjV5JpeEZdXOPY4ew0mXOqTHp1FY+2EZ80+g8oNUDdHTkPBLHtVDNzls+NWNfF3bb+lQD39uMDt4Ck5E1u8pBMS8ouOrLZTFbiv4MYyFnYCdlY/MHaYyKOntEZ53LOjOFubTiY6d7MJMVZSR1n9FW8pLR4OgpJcUIfUT3umrKNTKq5VHdx04UZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9OkfTeBtO+oUsWB12PkymdGbxUw8aVpVm7iU5djpNA=;
 b=rh+aCm4cDrz+N7j6QqxfCPmL94b6P5SrsPMvnCQ0tu67trEDIzqYgGOd4QrPKtbrWrImqFVwkFVXM8sPE8kpKg9xVvZgp+SMfsMhjuJBpia4UReiQkIG3Dm6bjLRNGXDQLUIwOTI5l4icHdEy24rjhjmXcSGNNH7ScnFtrIzFQYmEi5FJ3H75XbMY1hjiaay4TOHO5SPL/14K44ZEg/Ji8nhLuZvOG7gIf0zl2ihDtkQFgMt87HvyZyg8fVd0M1lW5QcAEBifo+pB9Q5KJPtY5wzFLNWd94Yrf+ro4/cM1dGXHvKSLjr8j5s+phP9GyN7qogtwy0uyOYOxjbdsKCvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9OkfTeBtO+oUsWB12PkymdGbxUw8aVpVm7iU5djpNA=;
 b=oBNAG+iHXZ4klZize47GReHJ3ZxRuzZ1fik3u8JU42z94Wqr6UELNJjpoR7ojE3dVo8Y+TMBKMfslRfIKZ6iCwLmlKhJycOfDRA1VaUM8UwB4GzY+rWoAEaORQwdX910ubhp9sOBUuYNAcPFOUZX81jFLny2r7nMB1seSBYUP1bn6X9Oo+uMNPSGNHJC43HZ31hAPjeBBZLX4fqMeYId9IMM7qv7oDL1fk3qo2vxNh3j2hKWzJHlnixKQAuVOz9AYV2FjqX3OYvtP3c9NeXmQZtnM7lXItNfHZjXPl4nrQUboXQrDajFrLIEAe4pDFqwAgXS8FeKITaf+c2iu//vKA==
Received: from CWLP265CA0490.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18a::14)
 by VI1PR10MB3311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:13:59 +0000
Received: from AMS0EPF000001B2.eurprd05.prod.outlook.com
 (2603:10a6:400:18a:cafe::4e) by CWLP265CA0490.outlook.office365.com
 (2603:10a6:400:18a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B2.mail.protection.outlook.com (10.167.16.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:58 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:10 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:58 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:55 +0100
Subject: [PATCH v2 04/16] ARM: dts: stm32: Update LED nodes for
 stm32f469-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-4-45090db9e2e5@foss.st.com>
References: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
In-Reply-To: <20251113-upstream_update_led_nodes-v2-0-45090db9e2e5@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B2:EE_|VI1PR10MB3311:EE_
X-MS-Office365-Filtering-Correlation-Id: b21abf58-a8f4-4f17-175d-08de22c74556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1FFelhrajVkeWMxTk9BWjloSTZRS1g0ZnpkUDhldm5WNFB6OWd0d3pwR2NG?=
 =?utf-8?B?MXNLVnlQZ1JsVWJEem45RmRNSEtKSEtyOVRpWStaTnRnNjMrUmdqbUk4WWRV?=
 =?utf-8?B?ZEJpWWxCL3E5SXdadXBveXZzZkVBMGFMRGluVkRBc2lOZm9kL3g4MWVLV3lZ?=
 =?utf-8?B?SFU4Tk5yYkhOY0I2d05EcGQxbTJkWHI1WURBQi94aGZ0YnZQcEdQb1hLN2My?=
 =?utf-8?B?VzVaMEZjMThxWExtNkd5dFQ1eVBKeHJCRFExdUxIM2NnQTBuQStJcnBFRWRV?=
 =?utf-8?B?YWw0emFoMC9LNVkrbXJhbEdISDRFTTY3N2krQ29MWS9XUkM1V2x4cUk5MEsv?=
 =?utf-8?B?d01zb1F5QytmY2hCb3NwUHZIQldhNlRkdEpDMGJyYmUvNUdmRWt0THdTZHEr?=
 =?utf-8?B?UjJuVzFTVkc1L2VjUnMrQjIyZUpta2NrNkU4MzdrSHc2Y09STVNXaUQ1cW14?=
 =?utf-8?B?Sm1tdXhDT1BwS1BFTVg5N1JjUXp2b2ZhTStubHJRODQwZFdVcjZHZDBONm81?=
 =?utf-8?B?TWZITHNrRkZWbXZuWmJiYzRJZHIya3Y4ZG5xaGNNeXk2eGpOY0dyK2grU0Jk?=
 =?utf-8?B?elRuTFk1OW52ZnpITGo0Vi9NNXJSTkNQYmt2M212cHFzMnJ2UVdJNldka293?=
 =?utf-8?B?RXJBVlBmYU5iMTg1VXk0bnZHb0xMSU0rdHlub2VKTGljNVM0emRpb0FMc0Vo?=
 =?utf-8?B?cWdhS0k3Y1grNmxlaDlGa21JZXBRZUM0UnFrVU1MQ2JnTk1OR3RCNkF1eHpn?=
 =?utf-8?B?NXZoeFNuRmRaNHFiclFwdEwwQzlOZ205VWdCc01uNmZ3U1VNQThUTktaZUFP?=
 =?utf-8?B?RHlibkNxWDJKMFNjZUpyOHpxYzh6Sm9ia0tyZ1R4LzJadXBhM2RBaGxXbVZk?=
 =?utf-8?B?cWt0UnlhL1ZVbnZiTGZiWmMwSVFDVkpnSXJKc1R6ZkdvWk51WkxaZWdmajl0?=
 =?utf-8?B?KzNzU2xDblNVVjBpQjFaKzVWQktqUUFGMnRNTmlmL2JGaWU4RlJWVTBHcGpM?=
 =?utf-8?B?L2pPL0o2ZkZkclNTNVlIazRuSE14bG5pWkVlNnVTL0JlUEkvbExrNmNVbit0?=
 =?utf-8?B?aGFsUG80aXhSZERHQjc0ZXh1RlpxbE0vQVlTaUwwK1BvbVVBUllZMUxqcis5?=
 =?utf-8?B?TjJBVlJpMktSL1FwamJwZnlyOWhZekhBb2NnYTBPcVVSY09ycGxDSW1uYk1h?=
 =?utf-8?B?U1J0M0RBOXlQSEIzVUtEVGFmUVU3aWFjcUNRNWJnSktZT1dRSkZZNEw3Uyt1?=
 =?utf-8?B?azZndnRvcjUvTDlwa0pCdW51T0dYL0ZLY2dsSEp0VTRERzZocnFwYWZ0cjd1?=
 =?utf-8?B?NlB2MkdYRHA3TFlrNnJudU4rMEEzdXRwdzNqTWpOTWxsZmxtaU5ZZWZ3RENX?=
 =?utf-8?B?Mzc3YnpiN05TWmJxQmNiVFNxS1RHTHUvbVo4M0g4QW41aXd3Y0k5eGVwV3Y4?=
 =?utf-8?B?QWVjZ0I1bEVhOFI2dVF1MDRENThnR0hWaUVVeFBiTTNxOW9relBzNmRvYit6?=
 =?utf-8?B?UWpxM3NwQzlrWXRmRGs5Umw0ZlFLSk16bi9kYjFJT2kyQTRKNVFPcjVuVFBm?=
 =?utf-8?B?OWNSMVVuaTFOeGJRcGdQS0IrMll0Rkk5ZFQ2M0ZNWkVocGFWeXJmZlRFRTBq?=
 =?utf-8?B?eE1EdllIZzZwTTVicFo0Y2w2aHdFaWhJU2RrQjJoVEZpWWpKV01NK3dQVC9z?=
 =?utf-8?B?bkpGZWpGanYvM2FXdU5kZk03UkZ0UDdIamJqRjNvZUJaR3kxMlZwM2xReXdD?=
 =?utf-8?B?bkJUTDN4N3hIazZLSHZyYkFDd2FTWUZtdzdNbDRjU0lvMTRQMnBhalNvb2lk?=
 =?utf-8?B?Y2FoaUo3L3kwTGZNdkNOakNMVW92Wm9zWVZ3a0RWQitSWmZIRTFOY1VhTTBS?=
 =?utf-8?B?VmxHU25HT1ErRkp4ZThUekZTdnNLVVhXNDNqY01sZkFXRmJhLzc3RTVVUmVk?=
 =?utf-8?B?TlF5cjhWVmdEOEJSOEJQVTdtdnU4d3dyY0RVNGtlOUNUWXM0OHI5RTkyZ21r?=
 =?utf-8?B?bmRLb3NQdjZRd2dkTU4rZko2ZFRoQ0w0OEFlZUJTN1E3dFNrQ3cyam1zMlFu?=
 =?utf-8?B?djJpeGx2R3hQbUJqYlhxME9EcFJaUkwyR1N5TndBNlA4VUZyeC9aNWRsbU1S?=
 =?utf-8?Q?fJ/4=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:58.9395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b21abf58-a8f4-4f17-175d-08de22c74556
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3311
X-Proofpoint-GUID: uHoM-iI9XaiLI4WUNQtuMTdzpqOQ3sCu
X-Proofpoint-ORIG-GUID: uHoM-iI9XaiLI4WUNQtuMTdzpqOQ3sCu
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=6915f5ba cx=c_pps
 a=BL40uYAdW+KS4jwGTbLPRQ==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=jhUhpFCSItG6WmWFtkQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX/ZAefcyd7ZnH
 9emqD8brJcUxJsPVfi8CtDthYR0LmXxyckjkz8HwfQ/082sL3+piCM5foXkoufr7XZ0iufNr9qb
 N7AV40cqIPVHDBRkrqiiA7/cRUFJ/6t8+til8S15j0rOH3clEiqQeSZV3f6rMbWrKRFCDXRqX96
 Hnzazr5RdmNZfg3DWq829WYcyKL61PnNAIemQoGrEWeWGar1kL1rZSoyGsRTCIwOd29aVq+mzS7
 jO0MlbMdhSy9toV7o3SbnWNDikb8sJEG+iQwMGuP7l2ORv3jY/oI2EegDNTqD+a7v+PKyjt86HU
 olb+IHprNwWcGoNDfqoENU+ZZR2bgk5FwMvlA5LbcA5g+cOL71xz3nWcRqX/Pi7SPh7M3W2c1hM
 jladuKSvnqcmUXt09b/x+72D23XATQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

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


