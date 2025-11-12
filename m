Return-Path: <linux-kernel+bounces-897046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CC0C51E8C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 677E74FE158
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F24230C618;
	Wed, 12 Nov 2025 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="cOpgBJ8G"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A32E30B52B;
	Wed, 12 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762945581; cv=fail; b=c7+gVMl+gCcUKMQe5N0AV6O3YNtAjHtu2ub/qHrvA7m97easteSqhMbVV2HFGrgZ81OVbZirAV4MkTAnkDmjKg4rPG/7UMT707VqwwqJ1h15Vwrxo4bwjID2XVx/g/3oU/sAyvCqmH/vHjTG3+vr3qD6TstXnqfxYsPcrsHJPKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762945581; c=relaxed/simple;
	bh=a9UMztFQEnwWlxQonqsprRS2IbJxg9dx+AzuMpTDtss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bhN98HzxOORt2jsTVOxMwhvtZitaKrHxDV4bTFOGNzsG9axtfiUvnkuHSwaEk1JTJ42BH35DdB7+GyYURpessYMqMrCbpFFoTooEBZKesZBn9qBhrOMjUFf7vhAoggApN6Qn9GLOy4oMNbV1ZMU8O8WJC5ApI+YWduioIU+f8jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=cOpgBJ8G; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACAQpCf1342514;
	Wed, 12 Nov 2025 11:47:12 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com (mail-francecentralazon11013044.outbound.protection.outlook.com [40.107.162.44])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0gmck-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 11:47:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ag9+JHmHEPhp/QF/EQVuaqkZmRNyoUF0R8N5psuAk9V0hRKoLDsASiLH5vz3QoXX6iMEIqiSxWpWUKhPRIn0dQEGrdIgHklm8A6mOaKalColS1VdgSOuFw+tY+wiLqDTheRkeNnwlg/ZDZ7AfNPv9gtzKAv0FPIZedsmJxJeUebarE30ID5Ga8aAfKx1AFiSgHbuAxAImuBLgD6k4czb9+/QKDHI4Uo6K3+bvC5wYGtZ4j5jl4T2D2V9PZzqg6JdRqpp/QX58hepIEFagU66lfQ9DZ3zMoDXWmVEJCZO3OBGYRTvmj9g2rR0p3muuW3hQH3+GtmLrQoFo/+ezxMpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJAIPes2EzGe9wnIpvHrN5nrVZ/mmBn+f0+FDuq55og=;
 b=hNPcq7cYAowFtYhPTlelkdGTmNxANr5w4rubHV1xZ3/k6I7Pa+sB9K588nCdePI8A5BD2EWWL1STC+ZtyqWds84wav4JyxlM1+mOrE1j89UPZPlON4uWZaEhZoSEq9RXoYGIkMJv0u2D93yLCgkHrQjfH/ZZ5MRv+50uRR9WEw3owpE01Z3bDJLnytSJ/eZ0WgXS1Yhgg1ZU1beQTY4oSVGxf9zQm6HnltKsdeFp3w1pzxvjulSGFELWrNgxr5X4z4gY7M42HhKsBrRq/aSBe8zqwTzTaCEeWyNpG1cjznHwnJjLiaC9Yq9BSdlU4Sg/usz8Q7C/OHxOW9cQiFnRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gJAIPes2EzGe9wnIpvHrN5nrVZ/mmBn+f0+FDuq55og=;
 b=cOpgBJ8GSmoWCr0bCpTwuPNuXLs4dUDjyf1HcgermbI18TEWlqv4cQKLQMmcC3LoIj2LVGF/PYU+5NRqNoeLHKNr4Z5XMSVrHRr2WM9m9opmx33ZnV1rttgyRlmVDVj2E6ws2gf7Qx9PDucH5u6PRyNd643te1e3S9sM+Jt3H8MOC6C12CZtcP8+g85BCDFNqRlPfrLK99HiHIwLi0VqHmmMjaF2r1vPCKiC4n4OCF8C7a0SRSPhLW5R9giH5O/TKtOql0EYCaOhKKhWWRSHI9i3MONynE/gl+rDM24cQScbb/9Hc20JZoB6vWsX3sljmYxFX96otCNd9wYlNxH5fg==
Received: from CWLP265CA0503.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::9)
 by AS1PR10MB5604.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:47:10 +0000
Received: from AM3PEPF00009BA0.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::95) by CWLP265CA0503.outlook.office365.com
 (2603:10a6:400:18b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 10:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM3PEPF00009BA0.mail.protection.outlook.com (10.167.16.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 10:47:09 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:18 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 11:47:08 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 11:46:48 +0100
Subject: [PATCH 6/6] arm64: dts: st: Add boot phase tags for
 STMicroelectronics mp2 boards
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_uboot_properties-v1-6-0b19133710e3@foss.st.com>
References: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
In-Reply-To: <20251112-upstream_uboot_properties-v1-0-0b19133710e3@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA0:EE_|AS1PR10MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 7188ec1a-fe3f-49fd-b7b6-08de21d8d4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eG90YncrK3dQQTZuYS9ZaEV3YmhIK3N0SEtmb2hnUXVuSzVoT1l1L0ZSMG0w?=
 =?utf-8?B?TVBidFBzaVRBSWxVeWdQM2NXR2xEbU5sTkhYM2pEbDFUbm9OaXpQVng4S0R6?=
 =?utf-8?B?ZXVZbVh6azk1MU5HaThwNVZBR1FCNUt6TGVzZFVyTnJ0SUdZbzgyNk1zNDBH?=
 =?utf-8?B?RnBIT1lNK2NOMDQzNVBCUzUwVXJVWm9LNXhyZXhqdGUyWG1jRnYyOExTbmp1?=
 =?utf-8?B?RzBhZHhIRGwxTllzR0s5VGVoaHV4eEtTakZZclRpMjBjaDNLaFlNSWNnODFP?=
 =?utf-8?B?VzNpeDVQY2VndXA4QmN2d05HdlBTZkFpWDhDOFlhcE5kUUJQZ0t6dmFCMklB?=
 =?utf-8?B?NGlReWpGbXpaU0QvVElGb05aZ3FnMERXVUozUGNIYkdidktlTVdNS00xSXJp?=
 =?utf-8?B?b052em9LZFFMZEtWTmFKMnNOWWNaNHp2c0k4SVg4elk4c3BjNU9FVDl0RFZQ?=
 =?utf-8?B?azIrdWl5bWxnRTdQdXZtTDN5Q0lxVmo2UEpRZG5FM0NNOGtFMWsvVkUwM0RM?=
 =?utf-8?B?OWpXUFM5bjg0Vmp1dlFtNE9xTnFrWkwwVmx3NGRoODBnNEpGa3daRW53dXFt?=
 =?utf-8?B?YlByY1hHMWNPUm5FbnY0Zkh4Rk5RenJHTndUZi9reS9sbXRZbWVvOVBORjNx?=
 =?utf-8?B?MU5JWk9JUjFUK0piT2dQTUlBajNNK2MrQmRFUThUU3hjU2ZKb21tVFFXb25w?=
 =?utf-8?B?dmNON3A0Z2UrWUNyalQwZHpHUHd2N1lPb1V5WCtDWHhqWmRVTDhuejB2UWN1?=
 =?utf-8?B?bVNRYnR0TWp0Z1RJU3FZUmpuQ2o0S2VOcVcrUUx0QzM3c1dGVUxaUzNDT1h1?=
 =?utf-8?B?NkhjQnAzdTZQck9ZU01kVjNQZEtvU3ViY0RzUDMzUEhDMkUvVFhlOEdCV2RI?=
 =?utf-8?B?QWcrNUZnSzRQOVA2MmN3ZXFqOE9BN1FvcU1BN0Nvamw2U25DM0srZHJMcGxp?=
 =?utf-8?B?SXNwdGtiazV6OTF6VlVQVnhmTVNoWTZ4NE9lSEp0V2lqdkErRnpoc09uUXlL?=
 =?utf-8?B?SHBsWk5QVkpWM0NDeVJvOWtwakx3T2VNKzhRVlM0eTZuVndNbzNJRytnN2Vw?=
 =?utf-8?B?QmZrRUtma1NRd0ZOTjZJNlRtT2cwanM2Rk5CQzY3OUdpN0prajNwMTNYaUhP?=
 =?utf-8?B?V1UwaWtXRlhIYm9QSFY0REhaZkNvLzJjWUtlclhhak9vL05TYmt2QTFjZEhS?=
 =?utf-8?B?VTlIUWRSK2lPWUgwOUU3TkNpVzZLVjNrOEZ2Mit4cytDdFhjZkNpYkYyNjRR?=
 =?utf-8?B?WnVCRVpsN3VMV2k3ZnduRkU0alh1dS9LRGxsWVoyQTNQVlNjQXBwNlpVRVA3?=
 =?utf-8?B?cWUyak1UUld2OTg4WFVMK0ZLT0tQSzZFc0ZJQlRVYi9OR3NBT210bmxLSWk2?=
 =?utf-8?B?Y3RTVXl6OXBXT3B6MGZ4TmVFN3BZU0UzOWQ1UVVBeGUxSlpBV1RrN0ZoZ0JE?=
 =?utf-8?B?WGxKcXdQV0VsRkd5dHVSdVpjVkFnTnhEWGt0Ymk3Lys3d1M2eDJOcGxFbVlT?=
 =?utf-8?B?OVVjbUFCaWplNi8wdWpFa0lNK3RTRHZjTGJ3RlF5MzQvazlvck1kK0pDWFUr?=
 =?utf-8?B?YXVYQjVBU2xiQ3E5SlF0amNManlHWUJ6Y2UwQU9ON3c5aFRSSmRQSXBiZTYz?=
 =?utf-8?B?VzZyb05qNUdNbml1TVhUd3QyYVpFTEtwcVB1Q21YbE5MNjA5L3VPSi90TDI0?=
 =?utf-8?B?T1NwWkV1eGU4Vk9iMnE4UUtKcWhmT3BYc2JHWW5uMCtCVmJYeTRhN0hqZjl5?=
 =?utf-8?B?ZTlsOXRicENMMzBhZy9kME9uUC82clkxVTFkSC9IYm1sNUpUeXZDQmx6b0NQ?=
 =?utf-8?B?cjRmeDQ1aHg0NmwyNjIrSEZ6cHJYM2dJVXk0LzBZNXZhcFhGNWNtNFkxcFpi?=
 =?utf-8?B?NDB0WUdxMHJaQ2JEUU0rYWp6dGVXeWxSaUxkaENoSFIrMFovZXU4c1hFTG1V?=
 =?utf-8?B?OHgwdzhRYTVwSG5ZTCtZeDdvZWYrRGZkc1VzSkZFZGRjYXFvUnlMS25mSk1E?=
 =?utf-8?B?b3JabnB3M21jZVpucTJNY2JCdG13SWpsamhSSXVvWE4waHMva0t4dGJNeUUz?=
 =?utf-8?B?TENMY1RWZHlhMFFXTjVFQ2R2WGZ4dVZKMWJQaHRPL3BKczlnR2ErUUZ0Mksv?=
 =?utf-8?Q?oo4o=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 10:47:09.9120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7188ec1a-fe3f-49fd-b7b6-08de21d8d4cc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5604
X-Proofpoint-GUID: nMYPuTjfm48te0vBtyeH5k-6VFzaYT4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDA4NiBTYWx0ZWRfX0rYnOcX/ge/U
 I47PLaokrH2SZJw73su3Eeg7qEtrc7oBu/N3eIb2qUwvGrK9PCCQFQbp9xEyCIGUCc3QgnlCY4q
 KcjutxPrVYMD5SXx83df9JUoR+uS3cK1YrtxwcfmlO53MOA2TTMu9Mfm7VjsiTm710NEzAiXe4X
 iDz8b36qNCe3yk1IGetoA0xLjuqJtuJm81oQKPELP/7f7GeShJaeasxHlhD/urJ5S7H6ueA+u2U
 DntQYCS+CVTBjeleBwUqFHa59YTmjm7+T3uAmt2Ln1F0Cm+NK/wzZ0/E9ENpQdDpE74dbLxRkT7
 0YOSh+wD6fRvgKnOsAzAQ5tSdz3Wk/rvQbtpOcIFbLT8FwcqQk+pGrMMth1OlDsLZV875Idi6Mc
 2VbTkjnUP8dKDOwfyn4UI68HeIJpWw==
X-Proofpoint-ORIG-GUID: nMYPuTjfm48te0vBtyeH5k-6VFzaYT4M
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=691465b0 cx=c_pps
 a=CcFEla9EprtmhgrLblTNNw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=LVccn3Y3NjMr1cHtPMgA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_03,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120086

The bootph-all flag was introduced in dt-schema
(dtschema/schemas/bootph.yaml) to define node usage across
different boot phases.

To ensure SD boot, timer, gpio, syscfg, clock and uart nodes need to be
present in all boot stages, so add missing bootph-all phase flag
to these nodes to support SD boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp211.dtsi     |  7 +++++++
 arch/arm64/boot/dts/st/stm32mp215f-dk.dts  |  1 +
 arch/arm64/boot/dts/st/stm32mp231.dtsi     | 22 ++++++++++++++++++++++
 arch/arm64/boot/dts/st/stm32mp235f-dk.dts  | 11 +++++++++++
 arch/arm64/boot/dts/st/stm32mp251.dtsi     | 27 ++++++++++++++++++++++++++-
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts  | 11 +++++++++++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 11 +++++++++++
 7 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp211.dtsi b/arch/arm64/boot/dts/st/stm32mp211.dtsi
index bf888d60cd4f..81b6a71fc032 100644
--- a/arch/arm64/boot/dts/st/stm32mp211.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp211.dtsi
@@ -50,6 +50,7 @@ firmware {
 		optee {
 			compatible = "linaro,optee-tz";
 			method = "smc";
+			bootph-all;
 		};
 
 		scmi: scmi {
@@ -57,15 +58,18 @@ scmi: scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
+			bootph-all;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
+				bootph-all;
 			};
 
 			scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
+				bootph-all;
 			};
 		};
 	};
@@ -73,6 +77,7 @@ scmi_reset: protocol@16 {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		bootph-all;
 	};
 
 	timer {
@@ -92,6 +97,7 @@ soc@0 {
 		interrupt-parent = <&intc>;
 		#address-cells = <1>;
 		#size-cells = <2>;
+		bootph-all;
 
 		rifsc: bus@42080000 {
 			compatible = "simple-bus";
@@ -100,6 +106,7 @@ rifsc: bus@42080000 {
 			dma-ranges;
 			#address-cells = <1>;
 			#size-cells = <2>;
+			bootph-all;
 
 			usart2: serial@400e0000 {
 				compatible = "st,stm32h7-uart";
diff --git a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts b/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
index 7bdaeaa5ab0f..bc366639744a 100644
--- a/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp215f-dk.dts
@@ -45,5 +45,6 @@ &arm_wdt {
 };
 
 &usart2 {
+	bootph-all;
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/st/stm32mp231.dtsi b/arch/arm64/boot/dts/st/stm32mp231.dtsi
index 88e214d395ab..075b4419d3ae 100644
--- a/arch/arm64/boot/dts/st/stm32mp231.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp231.dtsi
@@ -57,6 +57,7 @@ optee: optee {
 			method = "smc";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+			bootph-all;
 		};
 
 		scmi {
@@ -64,15 +65,18 @@ scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
+			bootph-all;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
+				bootph-all;
 			};
 
 			scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
+				bootph-all;
 			};
 
 			scmi_voltd: protocol@17 {
@@ -114,6 +118,7 @@ scmi_vdda18adc: regulator@7 {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		bootph-all;
 
 		cpu0_pd: power-domain-cpu0 {
 			#power-domain-cells = <0>;
@@ -146,6 +151,7 @@ soc@0 {
 		interrupt-parent = <&intc>;
 		#address-cells = <1>;
 		#size-cells = <1>;
+		bootph-all;
 
 		hpdma: dma-controller@40400000 {
 			compatible = "st,stm32mp25-dma3";
@@ -223,6 +229,7 @@ rifsc: bus@42080000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			#access-controller-cells = <1>;
+			bootph-all;
 
 			i2s2: audio-controller@400b0000 {
 				compatible = "st,stm32mp25-i2s";
@@ -760,6 +767,7 @@ bsec: efuse@44000000 {
 			reg = <0x44000000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			bootph-all;
 
 			part_number_otp@24 {
 				reg = <0x24 0x4>;
@@ -857,6 +865,7 @@ rcc: clock-controller@44200000 {
 				<&scmi_clk CK_SCMI_PLL3>,
 				<&clk_dsi_txbyte>;
 				access-controllers = <&rifsc 156>;
+			bootph-all;
 		};
 
 		exti1: interrupt-controller@44220000 {
@@ -955,6 +964,7 @@ exti1: interrupt-controller@44220000 {
 		syscfg: syscon@44230000 {
 			compatible = "st,stm32mp23-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
+			bootph-all;
 		};
 
 		pinctrl: pinctrl@44240000 {
@@ -965,6 +975,7 @@ pinctrl: pinctrl@44240000 {
 			interrupt-parent = <&exti1>;
 			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
+			bootph-all;
 
 			gpioa: gpio@44240000 {
 				reg = <0x0 0x400>;
@@ -974,6 +985,7 @@ gpioa: gpio@44240000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOA>;
 				st,bank-name = "GPIOA";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -985,6 +997,7 @@ gpiob: gpio@44250000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOB>;
 				st,bank-name = "GPIOB";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -996,6 +1009,7 @@ gpioc: gpio@44260000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOC>;
 				st,bank-name = "GPIOC";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1007,6 +1021,7 @@ gpiod: gpio@44270000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOD>;
 				st,bank-name = "GPIOD";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1018,6 +1033,7 @@ gpioe: gpio@44280000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOE>;
 				st,bank-name = "GPIOE";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1029,6 +1045,7 @@ gpiof: gpio@44290000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOF>;
 				st,bank-name = "GPIOF";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1040,6 +1057,7 @@ gpiog: gpio@442a0000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOG>;
 				st,bank-name = "GPIOG";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1051,6 +1069,7 @@ gpioh: gpio@442b0000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOH>;
 				st,bank-name = "GPIOH";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1062,6 +1081,7 @@ gpioi: gpio@442c0000 {
 				#interrupt-cells = <2>;
 				clocks = <&scmi_clk CK_SCMI_GPIOI>;
 				st,bank-name = "GPIOI";
+				bootph-all;
 				status = "disabled";
 			};
 		};
@@ -1084,6 +1104,7 @@ pinctrl_z: pinctrl@46200000 {
 			interrupt-parent = <&exti1>;
 			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
+			bootph-all;
 
 			gpioz: gpio@46200000 {
 				reg = <0 0x400>;
@@ -1094,6 +1115,7 @@ gpioz: gpio@46200000 {
 				clocks = <&scmi_clk CK_SCMI_GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
+				bootph-all;
 				status = "disabled";
 			};
 
diff --git a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
index c3e688068223..391494eda5e6 100644
--- a/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp235f-dk.dts
@@ -130,7 +130,18 @@ &usart2 {
 	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-1 = <&usart2_idle_pins_a>;
 	pinctrl-2 = <&usart2_sleep_pins_a>;
+	bootph-all;
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "okay";
 };
+
+&usart2_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index a8e6e0f77b83..068720d49afa 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -66,6 +66,7 @@ optee: optee {
 			method = "smc";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
+			bootph-all;
 		};
 
 		scmi {
@@ -73,15 +74,18 @@ scmi {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			linaro,optee-channel-id = <0>;
+			bootph-all;
 
 			scmi_clk: protocol@14 {
 				reg = <0x14>;
 				#clock-cells = <1>;
+				bootph-all;
 			};
 
 			scmi_reset: protocol@16 {
 				reg = <0x16>;
 				#reset-cells = <1>;
+				bootph-all;
 			};
 
 			scmi_voltd: protocol@17 {
@@ -142,6 +146,7 @@ v2m0: v2m@48090000 {
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
+		bootph-all;
 
 		CPU_PD0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
@@ -174,7 +179,8 @@ soc@0 {
 		#size-cells = <1>;
 		interrupt-parent = <&intc>;
 		ranges = <0x0 0x0 0x0 0x80000000>;
-
+		bootph-all;
+	
 		hpdma: dma-controller@40400000 {
 			compatible = "st,stm32mp25-dma3";
 			reg = <0x40400000 0x1000>;
@@ -305,6 +311,7 @@ rifsc: bus@42080000 {
 			#size-cells = <1>;
 			#access-controller-cells = <1>;
 			ranges;
+			bootph-all;				
 
 			timers2: timer@40000000 {
 				compatible = "st,stm32mp25-timers";
@@ -1569,6 +1576,7 @@ trigger@4 {
 			};
 
 			ltdc: display-controller@48010000 {
+				bootph-all;
 				compatible = "st,stm32mp251-ltdc";
 				reg = <0x48010000 0x400>;
 				interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>,
@@ -1738,6 +1746,7 @@ bsec: efuse@44000000 {
 			reg = <0x44000000 0x1000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+			bootph-all;
 
 			part_number_otp@24 {
 				reg = <0x24 0x4>;
@@ -1842,6 +1851,7 @@ rcc: clock-controller@44200000 {
 				<&scmi_clk CK_SCMI_PLL3>,
 				<&clk_dsi_txbyte>;
 				access-controllers = <&rifsc 156>;
+			bootph-all;
 		};
 
 		exti1: interrupt-controller@44220000 {
@@ -1941,6 +1951,7 @@ syscfg: syscon@44230000 {
 			compatible = "st,stm32mp25-syscfg", "syscon";
 			reg = <0x44230000 0x10000>;
 			#clock-cells = <0>;
+			bootph-all;
 		};
 
 		pinctrl: pinctrl@44240000 {
@@ -1951,6 +1962,7 @@ pinctrl: pinctrl@44240000 {
 			interrupt-parent = <&exti1>;
 			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
+			bootph-all;
 
 			gpioa: gpio@44240000 {
 				gpio-controller;
@@ -1960,6 +1972,7 @@ gpioa: gpio@44240000 {
 				reg = <0x0 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOA>;
 				st,bank-name = "GPIOA";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1971,6 +1984,7 @@ gpiob: gpio@44250000 {
 				reg = <0x10000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOB>;
 				st,bank-name = "GPIOB";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1982,6 +1996,7 @@ gpioc: gpio@44260000 {
 				reg = <0x20000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOC>;
 				st,bank-name = "GPIOC";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -1993,6 +2008,7 @@ gpiod: gpio@44270000 {
 				reg = <0x30000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOD>;
 				st,bank-name = "GPIOD";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2004,6 +2020,7 @@ gpioe: gpio@44280000 {
 				reg = <0x40000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOE>;
 				st,bank-name = "GPIOE";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2015,6 +2032,7 @@ gpiof: gpio@44290000 {
 				reg = <0x50000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOF>;
 				st,bank-name = "GPIOF";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2026,6 +2044,7 @@ gpiog: gpio@442a0000 {
 				reg = <0x60000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOG>;
 				st,bank-name = "GPIOG";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2037,6 +2056,7 @@ gpioh: gpio@442b0000 {
 				reg = <0x70000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOH>;
 				st,bank-name = "GPIOH";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2048,6 +2068,7 @@ gpioi: gpio@442c0000 {
 				reg = <0x80000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOI>;
 				st,bank-name = "GPIOI";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2059,6 +2080,7 @@ gpioj: gpio@442d0000 {
 				reg = <0x90000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOJ>;
 				st,bank-name = "GPIOJ";
+				bootph-all;
 				status = "disabled";
 			};
 
@@ -2070,6 +2092,7 @@ gpiok: gpio@442e0000 {
 				reg = <0xa0000 0x400>;
 				clocks = <&scmi_clk CK_SCMI_GPIOK>;
 				st,bank-name = "GPIOK";
+				bootph-all;
 				status = "disabled";
 			};
 		};
@@ -2092,6 +2115,7 @@ pinctrl_z: pinctrl@46200000 {
 			interrupt-parent = <&exti1>;
 			st,syscfg = <&exti1 0x60 0xff>;
 			pins-are-numbered;
+			bootph-all;
 
 			gpioz: gpio@46200000 {
 				gpio-controller;
@@ -2102,6 +2126,7 @@ gpioz: gpio@46200000 {
 				clocks = <&scmi_clk CK_SCMI_GPIOZ>;
 				st,bank-name = "GPIOZ";
 				st,bank-ioport = <11>;
+				bootph-all;				
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index e718d888ce21..69bac9e719d7 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -130,7 +130,18 @@ &usart2 {
 	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-1 = <&usart2_idle_pins_a>;
 	pinctrl-2 = <&usart2_sleep_pins_a>;
+	bootph-all;
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "okay";
 };
+
+&usart2_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 6e165073f732..307b9692b00a 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -477,11 +477,22 @@ &usart2 {
 	pinctrl-0 = <&usart2_pins_a>;
 	pinctrl-1 = <&usart2_idle_pins_a>;
 	pinctrl-2 = <&usart2_sleep_pins_a>;
+	bootph-all;
 	/delete-property/dmas;
 	/delete-property/dma-names;
 	status = "okay";
 };
 
+&usart2_pins_a {
+	bootph-all;
+	pins1 {
+		bootph-all;
+	};
+	pins2 {
+		bootph-all;
+	};
+};
+
 &usart6 {
 	pinctrl-names = "default", "idle", "sleep";
 	pinctrl-0 = <&usart6_pins_a>;

-- 
2.43.0


