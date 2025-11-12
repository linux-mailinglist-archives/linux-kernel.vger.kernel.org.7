Return-Path: <linux-kernel+bounces-897640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31BC53437
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2DD2735796E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 693EC3491FB;
	Wed, 12 Nov 2025 15:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="WgjJ+Mwi"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315153469F0;
	Wed, 12 Nov 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962538; cv=fail; b=C9oIY2goX9p2j34D9JqtHYoxOph4UM2nag9huqg/FfNPif9UBZPhZv3QsRE0OuWS1QgE/xtWI7Ir34WjD2bkxbr0B6X5HTvr6UPBLjDEXkhq0NGCE68a8gviISt/Tr5CdXOHcg2g5Kl261OVX6Rlx0rgLGNEZsoXat7/T5CHDvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962538; c=relaxed/simple;
	bh=a1Vv0sudpo6znOOzrlmo3+Zj2MvUTt+t0C/fAiuZk4A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eDEjaJ6ZlhFiph6rtgedtiWpduKD8DoolGcm05W4FCIkZRiQkZBgx469LmyPTwCTx+KXiLpRX0ZddkOp0Hj3fI0x3OHNPOKe+HB2Mf0esaYrQvugzp+xoS3ykRc0c7UJIuGipVVPT/7PZxMTyQTViYx4yN0GM27s8nS4ap+Hme8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=WgjJ+Mwi; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFbFwR1508844;
	Wed, 12 Nov 2025 16:48:43 +0100
Received: from du2pr03cu002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acret9979-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NVrbrOwtgmBdhylUAVnbUZCgDOc2ULJlxypM0//BQQ+iHZ5WLANFo44S97PSrORIJtusDg2Iqb1zUq8eWhayfPtPx6I/eEoAWZszLX4nK2nT2fL7YM7REecfAXDJ7uwNFYM1fF5/xUsmKETGWQJFtZ7gk59Mp1Bzvjuj0isR5/zPXRfCHEHaIBS1FY2KMvn3MKO7YpUFq8+46PhdzVb+gn3m8AMW6jAmfcrqfMfI4QV4H9bMjKM0cwvAAQPKWsLrPyp3MLh7DlpLGba2Zit25Wosx2yBLFb7Dt/QimHLHUjvyFgdobfgXOmg5m0t5TChlGbAxMr/b8rPODpidQlobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCUeCFZ6sJzOzqxX1GbBaUrbhyHt29mrKHPhxhNbZyM=;
 b=leUChUlsOLRuDvVA2AAa8UstBwCZiWL4OxsEkJq57nWjBdS235vJTOjWbY5+TUVh5E6WNBe2AIxQXSGn+qjD7c5SCPw7+JYs+km9EvWpfzKHzMe9ZXRq0fkflt2ti2YU58It2IVJ7pZiPp+POCjJWZfYaRBd1PJhtQAWlXm0GqWBL8z7FdobVgznUn9Hc5kuEzyGBX8CXpUaV4pvqtvV5Uz5oCZzpfFfYYoHZCaHVBghMlf3PNWUvFSiFRMwPWzEZS7U1QPDNlYS2wJZBGYWgbYqTWQakrgInvdGJML0wJet9vlAKhKdf44AXUFLkH8a+H1y0eDKNrKjsQGd9zzRhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCUeCFZ6sJzOzqxX1GbBaUrbhyHt29mrKHPhxhNbZyM=;
 b=WgjJ+MwioiGo7nX1VssROvpQjHnHmeKTBI+LZORGfn31SdMkroqzMPMW9pmcGEqbwBK8J550Bp8TI3C1zcZMvOxI5ZAnOwHMfKYxcyjHO6JEFtWKxfCjikccJf5iQhHOQfp/qfPEzCR+Iotsl8tLHg9mFnDdgiAjO/MRBy2eNOp0zfD3Ra8sSm6eu5Bw5qkEwEo0ht5N8eh5S+xfWadKGGxJNpwSi4ydpi4vD1Rp4JHF2usY9xvoKV7S7iCZprQ8RWdxhwD8Cv76LHFy6QTJps/DTskCbSARJuGLMSZVwkJ0eR0AIiHWMXCKTG+18gkjKXPtRA6MVGNvmh20JThS1g==
Received: from AM0PR02CA0160.eurprd02.prod.outlook.com (2603:10a6:20b:28d::27)
 by VI0PR10MB9498.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:37 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::ad) by AM0PR02CA0160.outlook.office365.com
 (2603:10a6:20b:28d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:36 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:40 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:20 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:13 +0100
Subject: [PATCH 10/15] ARM: dts: stm32: Add boot-led for stm32mp135f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-10-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|VI0PR10MB9498:EE_
X-MS-Office365-Filtering-Correlation-Id: c9c7abc7-e988-46b0-3812-08de2202f172
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aktsZWVPVnpFbkd0YUpTWGlzeUMyVXJzWWNGWWl0bEh6U2NGOWNLQXVBMmFy?=
 =?utf-8?B?ZDdqRmR6VzIvN1A5Q3BndFJGdUdnODB0VnA0QzVvT0RORmdwb2xmTWhVcGYr?=
 =?utf-8?B?QzNESXFTOHNyS3h6NUtNak04SzZocVhMd0NKQmd0aDNRY0JYTUxNa0hUNG8x?=
 =?utf-8?B?Y1BRMGNhdXU5aStpM0dHTXVWZmxieHhVdlRTVEpCd1ZaTS9Fa2ltclJheVNj?=
 =?utf-8?B?bFZFQ2JjSnVPRzVaNTN6UHQ2VUpadWFvbEgzSzlWbnViQno1WGFVeE9pMzl3?=
 =?utf-8?B?aDIwZTlJNERmYkJ3NXlXTU1ZUG91bnpOOFdQZUxkbFYycEtwRjVNVzVjVjJq?=
 =?utf-8?B?cWh0NnFiYTd0bUVzbnBTQ2IzZDNlVU90cXNSTE5vRUdVVHMyWFNaRjhqYVV6?=
 =?utf-8?B?RWpqRmNHaUNCQXFEKzFXWm5SUGhlbWljN29yY1kvS1VhWW5CUXE5K2Q5WUNG?=
 =?utf-8?B?ZWpqV0tWTGNEQk5oQjVmTmE4dGJUNzRZNEZtSnBHbmhuVjI3NlJCV3ZCN08y?=
 =?utf-8?B?eDVMOHlIRXV5WGJKUVBNQ3VwdGYxQTFxanVQUHJoWWRMbSs5QWM0Uy92L2dI?=
 =?utf-8?B?QUx4OWN2ZVRKeDMzZHpaS0FkWXAzZGI3Nk1ELzhQNGU0MXBEUlRVdWR4YVZU?=
 =?utf-8?B?aUpQdEVsNnUzZ3FVRGg1NEpiNWgrZGZVNlprQnpsUzlKTlJkMW5uVG5wMlpq?=
 =?utf-8?B?c2hKSTVUY1Y3dUlVM0ZIdktmTHIwQnNEMzBGbm5CZmllVUFyMWNvRm9jdkty?=
 =?utf-8?B?NkN1Qk9Tak0xU3Z5Z0RMNGM1dkJGcGlBV0JkZXRrRmwzcjJjWlMra2h6TWpY?=
 =?utf-8?B?azZRS1B3MlVCdjN5TmJ1U2NwbCs1ODJTSTFvelVYeWJwQkN2NUFRcnlWU051?=
 =?utf-8?B?OHJCdFB0Nklsb2JseFdwYkJkQXdkeWdCdlY5YlhhZVlYektnSTNiMHA3M05x?=
 =?utf-8?B?MFMzcEw4eDVsTCtka2lnTS9HVGNEbDVEVmFkMDRIYWNCUGp1aFNTVlNWTytq?=
 =?utf-8?B?OGgwR2lUbCt2cWRQdjMrZmxwY08rOUFLWmRLb05ocmZDTFJ4bmw3MHhEUXRH?=
 =?utf-8?B?UThJSHhNN2JlNWtya0RUZHNnMTBUWndtUlFHQmpiM3IxaHVUdXFKTzRKVStr?=
 =?utf-8?B?M2xLbEZjRVF2RmtpdUxPVWRvVUd1TituZ0ZuUXlKSzVhYzMzQWlhSnRPUE10?=
 =?utf-8?B?YU0zVGh4K01CMEl6Qk5OcGZVU0UxekgyTFRXTGpTTGJmbHJaMlpSK3k1QjJo?=
 =?utf-8?B?VlhmWHJLRnZEellnOVk0c2t2WWpCbkNINjJITk5VSllSbWdlMWorSlJXclVo?=
 =?utf-8?B?QVF5bWpLRFhqZWxjUFNqQndYMGlXRXQ2KytFU3N3N1BHN0l0UXhFbTJBQ1RN?=
 =?utf-8?B?aS9qdkhaSDBaRFR0Rmdxc1psbGw2WHlrY210bGR1RkQ1TnRoVnA1K0xaemVh?=
 =?utf-8?B?Nm1tWnZDUFRNSWNLeEJ6SkVVT3hlbHFOMCsvdHpUaW5yVlRCSDMxVlBCcGtQ?=
 =?utf-8?B?dFFSWUEzbHdjaEJYM1gwZnNEVkVzUXA4V3FVSU5NK3lMNDVIaFZrTUVTaXR2?=
 =?utf-8?B?dDlvakFFclZBdWJyN1dMaGNGQk1KYlVVSENhVXhXRDlNc0ZtVFB6bzJ6d01Q?=
 =?utf-8?B?aWZhUnpZdDdhY1JMRitLeVRyeTIweGM5d0dENHBuaEluNFVDdUJDM0xPUWVJ?=
 =?utf-8?B?eWlINzhFZzltTzJHNXZHb3NESWY4c3pKK0EwaXc2T1N5ZzJLSWxjb1IwbHdq?=
 =?utf-8?B?b05ndVpqL21WUzlxZWM2TjRZRHcvS0duaTJUMnFBQUhqMUVleVdtZjZib0Nk?=
 =?utf-8?B?NmxWTEJkeHdBVmpEcmJqeTFRUWVxbnB3TjBOT1A0V2xxWVE0VmtYYjlDcld0?=
 =?utf-8?B?TlNOQTdRTFE1dThNbWlhY0F6Q1ptY1U0OGNmN1poeUFETDZqVW9kdlFkTEF4?=
 =?utf-8?B?ckFnUUlCK29vUm5hZGQ3ZW02NnJHNjIyWVJjNmk2Mzg1R2s1SkJoSTZwUGJ2?=
 =?utf-8?B?WStiRi9ySkd4T3hWNS9BTWlPNHBJWFJ1SFJsdC9Xa0Y0c213L045MmEwKzlq?=
 =?utf-8?B?YWJTTDM1ZGYxdnQ5aEZxazlqQ1oxL0xnMUczYmkraUpRQ2g3TWt5TG42dmtE?=
 =?utf-8?Q?A7yQ=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:36.8485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c7abc7-e988-46b0-3812-08de2202f172
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9498
X-Proofpoint-GUID: TajJ6IWqU303yA6q3jAhbaQ2_igOiyJ4
X-Proofpoint-ORIG-GUID: TajJ6IWqU303yA6q3jAhbaQ2_igOiyJ4
X-Authority-Analysis: v=2.4 cv=SMNPlevH c=1 sm=1 tr=0 ts=6914ac5b cx=c_pps
 a=KDZ5a5fL2lDbxPkgIe+xSg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=m0cIrV4ErFGKJCW-7zMA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfX9mX0jmnNhnhC
 2hoMGDguqzyuht4dc4H8veTZOYyb4kjPj/JjlmgezBMC0tPjKJ67rGOeiXzQEZX76MtBxdetzbl
 MXozc8xDrfWqqOSTs6Gv3fxFZZc/OQDYebDpqrLboASMXxzC1GYBS1uBngZa8bCdeoUFe8t9wgP
 hvqI9SrYhK6Hu6/uP1tc878DjrQGPaVOPsL76TlpnqECgyLvje7TmSdG38wwl+D1vBzL3D8cleX
 Vc3yiLbKFBVZEiQyVKE5u4bNWLVVK80YN9amnFgFjpfVgXKNDEImS0ykeZnZ4gUqF26Ut6cjiWp
 xx8Qjjg5O0BrD60Hoj1StHcz+z/NoWfVC20Cz4ox0MqqLa/BzQQFIG3E+Fi3Zrz6trzEkyHf3AQ
 ZyLHphqDQAMwKq8PUqCDVU7+zcBPlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 909372da711b..0a2124eeca2b 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -73,7 +73,7 @@ button-user {
 	leds {
 		compatible = "gpio-leds";
 
-		led-blue {
+		led_blue: led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioa 14 GPIO_ACTIVE_LOW>;
@@ -88,6 +88,13 @@ led-red {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	panel_backlight: panel-backlight {
 		compatible = "gpio-backlight";
 		gpios = <&gpioe 12 GPIO_ACTIVE_HIGH>;

-- 
2.43.0


