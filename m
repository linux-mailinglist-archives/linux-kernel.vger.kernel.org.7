Return-Path: <linux-kernel+bounces-899642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A284CC588C8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E58EB4A101D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD9331A554;
	Thu, 13 Nov 2025 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IXgaOLsD"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F22E718E;
	Thu, 13 Nov 2025 15:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047765; cv=fail; b=OJtIuFApedFEDw4ZSLgaumHoLBWjIbuG7OJA+6hT6Wzw26VRdos7PvzAjK7WdN3dv4EnS7QHI9SNay/UfG7E1sw5B5ic2QcWLCGocw4eZYcWTdaEjVKZpm/+BFe3m3P8+KAiiPa5PCKc38zeC1khZaYPtOUE7GgPvrVkKZ7xs7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047765; c=relaxed/simple;
	bh=qYKp8OovI92GecoohfNr7h0HP3VXOLXPpA6ZMgWY0Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=MHExQDM1w3ysyDnltDnRRKSMvZPAyIhmqlbMJRHil1ts45stBayApfx2+vlT9axOA0TaxZSwpKNr9y2AB9iyndOwrdAo+SF9hoH9mOL8ehRGaA0rJzJ0eLKtu6k6RS4g+N0zGSWZL/R5/qV1fA8b6LN4fTebZhuXiaRz712kXmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IXgaOLsD; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF3loI4121449;
	Thu, 13 Nov 2025 16:14:02 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa7e62v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3pqVccLI1aTk15u3jwJl2m6tIgXioRRvRojbKNpOxm8ibkjCqXhA7c1RrNSizMBreV3k+6LF9rGvSx1g9+L223jDJnnAWD8F4bwdTKEWOI56pbo1ITggWFCCWXNpVHZyr3sOLn5Zw2AFmKvutAOBsgtGpeC8PUt3a/CwemEYedwgBhPXJQikjlxqVTfOurrIFw2NdRe1R+fqamaty8rg1KoGVbhWI2YgBzVUN7kAZ8/Ba9CwhnFVO9SOX2mZTjbu4yXo8eMwjfQhIggHTQchTLyGDq3EKBL7pSImLKBYTI8yUAP0mtTPXlfEOydcJ7rSEbl6mxOpqn0XKvIa4ETgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+rl9UgHHA/sUe/13L/rwNoq89UPoQvQo1v8oVVZYno=;
 b=NzG4+VVWLEjCk9GgsxeWnI/uBCAqYU1roBqyIUhEBTPS4ij2UrYud+pXRuOPWMiFKcJSF5ZofjD58P6o89HFaI0jPzXBGUyfmSxkgqJzYgVMDQcvggKkv5vrub6bUPKDkm8LePjYiaj8OoFQ+Sg63Pyt51NQ8ce8xLm9b7+vzVMkEQ1GEJL4DEPl0UvUFibFQ8YqKzY5qhjS4dQYo2wJ5bzmOSdSFxz2fitRC17IsjEfbTMzF7k0L/ZUYj8tVucPC4mOjDPVFQK3H5mRfXUSXF1WkzHDR66EGbUS2fHpjepmmGRF6QpsYPjInZ/RmENyYZ+WfsNmNN3Cw67HQUEGRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+rl9UgHHA/sUe/13L/rwNoq89UPoQvQo1v8oVVZYno=;
 b=IXgaOLsD5jF2osSVqMglHEkwBlO19FFbhauJBQReF3RO7rG64qmBdjrE3yzPuwvtFrgstKcC4plXVCIG/M4uYSG/ly5LWOm7qFnjdAs4T7dQ8VZBclyd5r/QaxpiaE457evVdsQ8Q6OQRX9zN/+r8Us3+kP54sEgkJm3eTOwh60mhxYRpV/Rpl49IVC02ewXfob/xD373C/cv5x3MSTDf2JUkaNs3NOSoOXddUDYOvH/gyUwnwDyqPuG6gvV/R73yxu3BDmlfRpdXeGIe8JGAa0vrb/Ou3eZiAbJWOzo6S6LQXsvgpVErPv3oBM0o/3xQshW0AKkeN/hgMHmAduDFw==
Received: from DU7P191CA0015.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::7) by
 GVXPR10MB5792.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:6e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.16; Thu, 13 Nov 2025 15:13:59 +0000
Received: from DB5PEPF00014B8C.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::4a) by DU7P191CA0015.outlook.office365.com
 (2603:10a6:10:54e::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 15:13:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B8C.mail.protection.outlook.com (10.167.8.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:13:59 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:07 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:13:57 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:54 +0100
Subject: [PATCH v2 03/16] ARM: dts: stm32: Update LED nodes for
 stm32f429-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-3-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8C:EE_|GVXPR10MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 938432f1-26dd-4a84-69f5-08de22c74568
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWZpdEdXOUkwWTh5REZiNko1QksveEZnTmpuUUJTZXVYQ1hzcUlRYnZvQjJD?=
 =?utf-8?B?blpZSmdPdXl6Tm1pV0pjb2U5Q2UzSE5TUDZWNmxLaXBteFlqSUJKSTF3OXhE?=
 =?utf-8?B?QzlGUVhnSEVGeWlRK0ZMVUVJZXlGZFI4SDNLZDk1RkZwNGZvTGlRV3Y5WjVU?=
 =?utf-8?B?SURmYUphc0dkSDkrSDdHMXJVZmNacmV3OTNoSi9VWWhtbDhJenpCMUhOb09x?=
 =?utf-8?B?aTI5WjdKZ1hyalJPYnhwRWs1U1ZRWEMzVkF5a013d0tHYTVZS3QrSHJ0bFI4?=
 =?utf-8?B?bVJCTEtPUjJ6SGhpMlo0THZDVCtjTmNDQmF4M0FhK3ZlRDhQR2p1dmdiOEhO?=
 =?utf-8?B?akpzOHd1TGdOdnd4ckR6RlFPZzZCWmpFZWo5aWpyd0Y1ZForS3F6Y3V6Q3pD?=
 =?utf-8?B?OEhqK2RjcjhKS2poMTh2aXJ0bGExVUdqdHRJSjUxNG02aDNFRHByMFJzWjdv?=
 =?utf-8?B?dHYra1NoZGFKNHVFZjdGWVQ0SUNLN3hHRWZHSmUyZHFuTU4xcmF2SUxUSlE2?=
 =?utf-8?B?QTFOY0FQTS9DOFVhRm82bGZwWStMWnVJUmxHc0ZwR1lPVC81dkRjN29TbW5C?=
 =?utf-8?B?elVtbmZOTHJZQ2RJd2NiQnhGd2tZZFp5YXdZb0hnMVp5V2JQK3I0S0t1QlhD?=
 =?utf-8?B?Vjl2bEhGWUY3cDJ4aGI4RmxBNmhHVmRJdGtsemthZFRuZy8rWnRDL1drTUFQ?=
 =?utf-8?B?T1dzeTBkb1huQURWajBXQXNKYnV1ZXFrUGZMM0NvWUZSeEUwMXdpTEY3OFhD?=
 =?utf-8?B?SWltZGtDblpwRDVGQ08yT3FxVVdKdmJjSXZpSXNuYzhWUUhPK2MwQnp6M0s4?=
 =?utf-8?B?Y1RtU3czOW1MQnFrajNnc1pkbytEZHNRZUdqMHdZU1JhbXlwUFF2OEpST0Ju?=
 =?utf-8?B?czd3dHJJbkk3RWovckdJZzMrT1FSN0dOQmJONjRCcTM3K2ZiWC9yV2FLWTBm?=
 =?utf-8?B?N1Ixb2JoMlM3cjhVVmVGWHFUN1pUcU9wWStsRVM1dFlodVVrZHc0Mm1UQUh5?=
 =?utf-8?B?L1g4NHg1eituSzFBUW9XVjV2TnVpTXRYUDkwaDZrd0llZUxraUEvZTV3Wk9j?=
 =?utf-8?B?MDZFTEVSSXBzTlhqM3N4cnphaUw1U1UydE90NERCblJGMGFyZ0pDY080dVVp?=
 =?utf-8?B?VDlyUVBYS3pGYUdVRGRkTWc3TTR5Q3l0Q2NPeFlWaWFOMlNNQzRLNng2U0F4?=
 =?utf-8?B?Yys4L2pISjNZNXJVQys2dFo3aDhuKzdIVzlZdFpQdlhPU0FnTkE0NGwyL1k1?=
 =?utf-8?B?S0E3MGh6bDdxeUVZWGkyc2pvU3NSQXJkS2d2SGNWN2xRakUzcXRYL0ZNZVQ5?=
 =?utf-8?B?VzF4OHE5blBEbVpDQ1ZnTWJBeWg4MkZ4a3hKVHBsVUdMTis3dnBySVR6VVF6?=
 =?utf-8?B?UEF0ZFA5bHRhTzNhallNNG9DNTk3UGJ0RTdNcjcxejQrNC9GcWgwZVFEdmRJ?=
 =?utf-8?B?Q05CYlNWVkVpcXJUb1p2L1Fjc3NyKzJ3TnlUUUZQU2VDZkpRYXJsUFBlbHdJ?=
 =?utf-8?B?Y3dvRDdvcXcwQkRvMzUrL0xtaFJTNkkwSlp1SUgrMmtCRXBFQW1DTFFXUlBH?=
 =?utf-8?B?TlVUSElmcjN6bFpNTVpyT3BmaWVEZUNKNkxBYlpWYnl4Z0lyMjBCUG5Ec1dC?=
 =?utf-8?B?elBUOFJRTVAvQklHaUkxMUdQUUpxZWgveTZOWXFFT3VNZ045YkVydEZ6UGlo?=
 =?utf-8?B?MnUzQkZyL3VacDBOUElhNFJJS2tMdHNmZDJndWZCOE5FeHV5TWFqQkh5bkxM?=
 =?utf-8?B?RzRlRXZaSE1tN0hQZkFwWXd1cXR3Q0FUbGtuUG9IcWh2T1dxNXFnTmpOaHFS?=
 =?utf-8?B?TFpTTHlGeG84K2FGWDJ3cmxET0FZYzYxOGY5Uk1TWnptV1J0RDkyNk1WQW40?=
 =?utf-8?B?R1RaVnJRSlc3K0diVzJZM3JlWGlCQUkxdjhmOG1VZDg5T2M5ZWFUa21YNGhm?=
 =?utf-8?B?RFYwWTNva2pQWHZ1Zmh0WWxyei8rYVNlNXZhbFlIS2dPcnpha2RGcnBRdEJn?=
 =?utf-8?B?U3FuWFMxd2hyVnNYbDJGSnlXNXdWT0d2TytMOWJ4QmpHems4WnEveVc2eTlX?=
 =?utf-8?B?b1hnK0toZi85OG1xOXF1TmlpRllDUVkvRFgwKzhPcmRPNG85RjJ1SlhIQXV6?=
 =?utf-8?Q?B1DA=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:13:59.0471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938432f1-26dd-4a84-69f5-08de22c74568
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B8C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5792
X-Proofpoint-GUID: m8YBA11bnJhNPgoVVtTtv_9r-0125Oyq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfX9PD1rxHA4bf9
 GCkC4kRD9MNFNt28+IYo2Mh2PCdIG6Ay+LsSwkyYQAVRAvkcDI5uvUI+GMFkOYnKbC5fNP8jh1X
 y8awp4XG+Hye19BTZsNsdouUIa77DkN2llY6fQRFLeTFiU0xN2ujFIyCr3VUKXTSoOTIn20o1MU
 8WI3bsLkYfLS473LDEm5/eo3+vyls6o5M17Do4pauY4M5u2iDnwISD6wN3Z/f28xE73Sa+vsosO
 YR+sOpPLK3e9CHTbH7scx+MJQ+QmmUMyKhZBT+qzOiJMv7DKKB9DCHbuTXIxceAb//kny1t9fRe
 sowPtr8aZDu+NT7KLoQh+t7LjgMV81cgRI1kGEWAnLTXtCrPkUTUHQFbf1DFgI80xNVCnoBB5po
 c75+slKeHwpBeUJSVP4QKlA21EeLiQ==
X-Proofpoint-ORIG-GUID: m8YBA11bnJhNPgoVVtTtv_9r-0125Oyq
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6915f5ba cx=c_pps
 a=eE+qLHXDGUwwSs2WNjMcQQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=LGokPihkvKNT9fXVwzQA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add function property for led-green node.
Add color property for LED nodes.
Reorder include dt-bindings.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32f429-disco.dts | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/st/stm32f429-disco.dts b/arch/arm/boot/dts/st/stm32f429-disco.dts
index a3cb4aabdd5a..15f92842c8e1 100644
--- a/arch/arm/boot/dts/st/stm32f429-disco.dts
+++ b/arch/arm/boot/dts/st/stm32f429-disco.dts
@@ -48,9 +48,10 @@
 /dts-v1/;
 #include "stm32f429.dtsi"
 #include "stm32f429-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
-#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32F429i-DISCO board";
@@ -73,9 +74,12 @@ aliases {
 	leds {
 		compatible = "gpio-leds";
 		led-red {
+			color = <LED_COLOR_ID_RED>;
 			gpios = <&gpiog 14 0>;
 		};
 		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&gpiog 13 0>;
 			linux,default-trigger = "heartbeat";
 		};

-- 
2.43.0


