Return-Path: <linux-kernel+bounces-897630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA13C533E3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5563D352553
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801C343D6F;
	Wed, 12 Nov 2025 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YuS+m2IM"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77712340283;
	Wed, 12 Nov 2025 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962531; cv=fail; b=Tb/yDMJ/wJEUuQXoOh1jjmuz/pB+Ljn2u+XfENwmVHZNRfrZi4a8Aq9sUk5bR5w9RQmleXbUSVpuQ7FxvixPc09GbOdL3KKkqnlCiw9UvKPZFTKH9IBy9mdqBjaMLyk5kFZ/tjPtZbart++VjhLtzMrRc/2g7hpZHUaaa7FduEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962531; c=relaxed/simple;
	bh=C3QRJogCZrvuoTyfoFax4TK6nshZo136kTgh9S3RUBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tnr8jf1aVBGUuUHz6URYAGDWu3VCKX8ieHjqHD8e/FIL1NyK/TYQa+uSswM14eYXB1hjmjQJ9C8NuTk+tYI/9f48a9buAE2ZlhnoY/+yA8lf/6bhUGziTb7oyB3Lr9oNCHHuEMVbw0SV4HqMmtU0+ZXKSPCt+NWfLK2sizO+ZPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YuS+m2IM; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFWB5N1604183;
	Wed, 12 Nov 2025 16:48:40 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acfv8be0k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:39 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLkiR4wwyBsq3MbTYXXBw/0ir54iK2qxgN2qWC29Bf/jUZXXJr/Ms3LQydB3vQrrNwbQDqRdNOuKKPuUooN1HWOqy31oTaeDt7OvELKCMaEB5fyK3tEbH3bRg4+xkgAd0lAiogsnZIancVNoFwwtrzNFMOF3blm32U5zyigLpZzkD4QLvptrNzRdepERYZLnrHTyJOfsMahtZkMAaGC9v9qCe/AGo+TghPjJQKCpYAiHNJXNDYqiCq3rDOr3fY/3sK92FhthDRLLjXwPMgrm/o5KOc/PzhJKoJxfShi3D5dQR0mSZx52gg2G83hiJUpBluNmA/dQQEeXwDdwx2hZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kag20vVBBt513UJK9wIMVXbkFEyTYpZQ8jsDKHbGxmQ=;
 b=VZeOWb22bgKDKew4dyMYgN6cUaDgNIV9mwY3mKDtc04yTa3v8YpOC+u5DrGGfHl7LCRF4m6C0HhzsoiDdKSCShblM3/g2ukNLj8Pvz7BfJqkwNfBUHpgvLYXeA7ihxELfSTFRcA6ydm/IMvSBqyvos4nW6Rv+LQgQ/SjC5jd55o6nIJakzOoSCMQ/Ka7m4Cr4caBuc23j9lJZ5Ndi5ZZ+dk6d6891HDNf3AL6QrGgBU3zF/JcOl+lAMOQxp7yeivEP7rtUSfkqFgTg2ly4AWE9dLli9iP2AJVZenbiN7Ll11zkJXsDqW6qBPvyxMtIqhn7osHjYdjEpO9VFnv0cNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kag20vVBBt513UJK9wIMVXbkFEyTYpZQ8jsDKHbGxmQ=;
 b=YuS+m2IMLIRX67iChTkpKjDwGLEJ2PWAzIJeVnqkReketR5db/XR11n00/4Zw4Y6rc329RVknpxTaOOCqfBNV4ouVMx4HK8XxdVIn0rKi6AEmnwaWuRDylouzKc0OFLqRmj5BU9QnPdO5Qwad0fKAJqtppu6PX2MSaspm9S6/RAFiKvTMNHRRCrO+MIlrBy867eg0/mgKsBsPpFLtfWE+0mvgDzpRCQYMFLRrFV2XW7f4YE2lTPEQsKdvewvpWJ7dcIyxBMj0wozv72x7t2gGCLswcBvVPk6o+ZUZiLoTzK1nX+PSUuEQYfBytDfx+dwOuPsQgDrqrtV7VkXz1GUCg==
Received: from AM0PR02CA0157.eurprd02.prod.outlook.com (2603:10a6:20b:28d::24)
 by DB5PR10MB7667.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:489::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 15:48:37 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::85) by AM0PR02CA0157.outlook.office365.com
 (2603:10a6:20b:28d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 15:48:04 +0000
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
 2025 16:48:21 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:15 +0100
Subject: [PATCH 12/15] ARM: dts: stm32: Add boot-led for stm32mp15xx-dkx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-12-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB5PR10MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: bf5b10e9-ca13-4e42-6c8f-08de2202f207
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG8zR3BHaHk0S3J6TU9LWHJRNWJBTFhjUnNzT29xZFZESGJTc28ybFJIVVAz?=
 =?utf-8?B?cUhTU0tUMGx6YW9oSmF6ZVN1a0N4amduU3BXS04xeFB5dC9FalVlaEkvcEFz?=
 =?utf-8?B?V3F6YVJBb0ZzSVc5dGZYUmN5WGtYRGM0SXFiam1aTHFtVjZ4VjAzeGhoN2gr?=
 =?utf-8?B?dUE4MHdOZ0pvdkpNaXVZS2NOa1QxaEMrek45T3FCa1pSM0FGLytTbW9OL0ho?=
 =?utf-8?B?L01wakttaFpDcCt4SVlkOHZvZ1Jkdk5nbzdLZFF6Q0dKQmdLQlpZM2xTVmw2?=
 =?utf-8?B?SDJmRkFEZFQ2MDdRZWRmWE1FaExxYkhGbDErN2x2cFY4d1RlcTFlSFR5MXhh?=
 =?utf-8?B?VVBLYStGcGdwb1VLTzZnbUFpQ0NNdVlkUVpDTVF4VlE3TWZXOWxEUkNaSzlv?=
 =?utf-8?B?eGxvOWZYRGtreENHTk8xZE9jb0NHRk1sKzhqd3BHcHQ0c0xQazExRE1mcU81?=
 =?utf-8?B?OWE3Wm16YVN1aExKYkp1UVZsOENVUG5LSlIyck40T3puMG9NbzIwbnhHMlZx?=
 =?utf-8?B?enpaMHNYK1luK3dmUWpyQTRhZkdvOTE1Rkd6RlU5VEg4U3lsaVhuMjBxNkQz?=
 =?utf-8?B?ZFhpSUtlYVRXeFFrS1NZcGVNRVRIKzRpc0tETzRYRGVGUHpjLzluZjgxMFps?=
 =?utf-8?B?WmFrbFNQdnJMRWtHbTdvNUNCbHlvaE8xdW5WQkgyV3JkbWN0alJmMWlrbWVP?=
 =?utf-8?B?ODFHMjl2bWJLZzJZTFoydzd0QXR4SXByRWN0dWMxRjB4RmdQbmVBUVVuVmRj?=
 =?utf-8?B?TUcxeThRQ2p1OFhHbGFDd3JBVE9pZDBiQWFHYnVJYU5yd1VXbkh3a29CUkRw?=
 =?utf-8?B?Nm5zNWRETDBDQ3FaQmlyTW1DYzV2a2s0aURJc0poVndHcmZEa3JZQjNRdXJr?=
 =?utf-8?B?UkhIT3cycThsbUU5bkxEaEFETUpIT0VIUTN6dW9kTnEwbDJsNU96Q2Q3WlB0?=
 =?utf-8?B?QTl5Ujd5MXdscitLSE5zb3B4eEl6Tys0VWRWeVVHeVpTcU9ReG8ycUg2VTdP?=
 =?utf-8?B?bmJYYXErWGVJVFNxWUFBRWluMitTRHhwMFNVekdWdTlMeGtsTU1DQWNRNlZw?=
 =?utf-8?B?RUVzdEQwVEZNSjFvdXdJZW1EVjA0OFhINjYybXNwUDVYZHhFbjhCRFRhcnNu?=
 =?utf-8?B?WHFIY0Z0UW5EaDF3aFBKejdxNnIrdzJUdWdqUmdFNGVVNUNGSFJucGRYUmsw?=
 =?utf-8?B?cUNYcmVqS1Fsd2djeXkyUm1ZZEo3amMzN1FWaVhkMDVqUldTM3BFT090V25i?=
 =?utf-8?B?cjhRa01WSFVPZmdLdE5RNnlzQ3MwczFJbzcyRW5jajlaSkEvNTE5NllnVSs2?=
 =?utf-8?B?KzVVOUVITDVKbTdWa0taazcyQXRMcHlZUVVEanRKaGhPQXpZaXF5UFZ4aENK?=
 =?utf-8?B?K1ZXd2tvS0tOUjRURTBXc2ZCZ0FHNnBodnE0S2l4OWgxZjI0MlBja09OT3VM?=
 =?utf-8?B?b0NsaUZMMlJ6R0Fyam0vdVErekdQT1RNb1hpVUZGYlJPNzBLbzIxVDNESmVI?=
 =?utf-8?B?Y05JODJwdzYyZFFHWHBLRWx3RVB0NUs3VUlpN0ppRHFFRFArZnJvdHZJQW5E?=
 =?utf-8?B?REhVck1yazBKNVlvOEdZemowempYbnZPTUJBSitvRDhTc3gvZnBVNkp4K1NM?=
 =?utf-8?B?cVpXb0sxTEM5UGVERkY5VE5OZDU1Z0V2WCtUTHJrUEc0dGxtNk5QQy9hM3Z4?=
 =?utf-8?B?SlNraWgrZTdXeFJteTNFVm9KSmNsaW5jby9HSG1JNnRWZWlsVnRqSk0wbWZY?=
 =?utf-8?B?QmpVcjNxUnRCMGttNHUxQ2JIc3FSaUttMWFnUnZSdGpkOHlNZ2VPTFl4M1NQ?=
 =?utf-8?B?cGhTWmM4N1prVHpqUW9zelJtR3NQNzVEeDV2TDlxVnMzdE9leDZobkptcjho?=
 =?utf-8?B?bDVlTnBWamlaekw1eHd5RkF2ZG5DRlA2N1YwaTFZVEhLbU9EeEVick1HVFRz?=
 =?utf-8?B?UzR4aGpoSkVydWJBY1UvcjJZTUZWYVVNclNqUzg5T2JVSkJTcDVSbVBzb1Aw?=
 =?utf-8?B?N1Y1OXdrb3dmQ2RNTFJEa3dWdmNHcmVBTnNtL3ZhWGQvSUY3NUZwZ3lqN292?=
 =?utf-8?B?cUwrVHVOOUJ0VlMydUppRENITmxQdytWKy8yREhnN2lsSXBuNVBQYUMySFpH?=
 =?utf-8?Q?oeh8=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:37.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5b10e9-ca13-4e42-6c8f-08de2202f207
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7667
X-Proofpoint-ORIG-GUID: -Ykz4E-wNfZhO3JueyK550kZoMh8WuPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfXy6p7NWpQ0J9e
 j7FyUYy8qstabg1Ge8KVB1X1OKCll7UgHi+Q63gpNzfzqjCgizhAW0VkrVAhVxAGf7OaX0GejWb
 TduHSvCrKW9c/1mQbiHzMwZYP87UIkoQ68Dr+V/nZdme6cXIBqiQSAH2SUCSYEjsSWBza2EtmR3
 sXsQk3kMWVQg0qbbZ10iHGRhaW8ppnzPghChGkxufDlm9bm5usITB4JLP1Bsr9TaHMHZuMpDa/N
 11icpbQsspmGFNWim6PjE5O89nyKCAUoFvBj/KQCpNKvHjsMB5FPmviL8g2oUmdHcgJSNGPM02Q
 mAnEVucFVZwawhXkmPtu9z/u1H936chq4XLOvexzN4kGU+f60hGYABNNzK7O1B6LlsYSYFWTjgI
 b42bOfWT0j92fN26Ao7gp78KQf0+ow==
X-Proofpoint-GUID: -Ykz4E-wNfZhO3JueyK550kZoMh8WuPa
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=6914ac57 cx=c_pps
 a=4XKZ1CoTyA6ki1p3Zi0imw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=D_TvHsN4yP54iExFr7QA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_05,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120128

Add options/u-boot/boot-led property to specify to U-Boot
the LED which indicates a successful boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
index fc0ff818e1fa..7ed2b01958fe 100644
--- a/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp15xx-dkx.dtsi
@@ -64,7 +64,7 @@ retram: retram@38000000 {
 
 	led {
 		compatible = "gpio-leds";
-		led-blue {
+		led_blue: led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpiod 11 GPIO_ACTIVE_HIGH>;
@@ -79,6 +79,13 @@ led-red {
 		};
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	sound {
 		compatible = "audio-graph-card";
 		label = "STM32MP15-DK";

-- 
2.43.0


