Return-Path: <linux-kernel+bounces-897636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E000C5342E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76BA5561F9F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E03A346FA8;
	Wed, 12 Nov 2025 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Q58QM7Y4"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC913446D7;
	Wed, 12 Nov 2025 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962535; cv=fail; b=PnF58x0OVRZwImS1kC9GAUodbObiHHSLB4qeY79B5gPtfZEkXUu1rSX/sfAt2PxpetRiG51rGWiwLo5Q8DQhbTAKwPDx4zutx8psh0c8v17u+GyDNxKBSlz/cddyZaUNcTQ4zSSZVpfBpnqYoxs3yYG3ycdRZ46ecjlUDKuGOQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962535; c=relaxed/simple;
	bh=SYQOlJVl2vU7K5es7oIjGqCfCUHYz4CLb/u3veniLoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a6+WlQWRbLjklDsJKxZoLCiSGuA+S4JnjOjMlyKwUzG9HEQ6Mg+RnuvF07Czw6PPYEdDOc1s3a4fS4e8URM/SQC9lFVRIcB+/Dcjk2djipTfzL9K2BUS4UWvsbF1A+58QiTfoXnLzmI/gNdJv4nB8p/6R563Jl9FlNWv5rQm3yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Q58QM7Y4; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACFTSQf1905449;
	Wed, 12 Nov 2025 16:48:43 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0hsas-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 16:48:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFv9k9JTPp2SSLnySA3bsWYvZ5PtAMj6KoSijbsjoDoqk/7KC1BKhuYUmIpgK2Ry/8Mh+prlN+/2qlMBJhKDTbmBzAb+BA9YVACc02fBKB7mFnXgHFWvaz7c2jqEa0GgAs3CvHYmfgIJpl7VGh/0P1FrpvRoSkN5EmiHiNCa3KryoLuQZj8YqE9yP7SSj3WsuXsYSmnqgw/Qa7YYRojoEGbMeA4Bl2tnhoEFsCfU78b7/wYEF9X03B3QpvuJj7vEu4E2Usswvg9K+an2rh63Hqau7qv9FsPDZKsxZ6ELfsberBA0S0j/szk7E+olj3YazHI7UKdgb01Aqu8dIy4uKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kkbsu+CKzt838NEUAbRvMjx7e8E5L1kacC6e2bU1Kd8=;
 b=ABLhhh5GOIKYFkXfZAmONtgxLiaKKBGgtwR6SEer4SdpnLOeWnhQoSh8hPpq5TACPgtz6gLaavQVo9JL1T2GBPJX2zcjERr/chfCKpZzcJIFOkpN9IEf5hjb80o1N1rIH238s3mCrKODgOwlIyRjyeGCbXjbLzCWuyZJNTW+S1JrhJS+RryxeXrQ6cbMgXTebE4zjspORIrZUMJl8rwaVo74OEISYmv1lsHj0ucMwn+6FAxoDvBCZG2RtJpjH/BJFs96L/oF9O7UQA16HSkKJrj7MWi7StNAUghzhPUJ9XY+94edZUV/682V4Iv4Uk0RiIKUsssuWfu3UoO+ad0pRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkbsu+CKzt838NEUAbRvMjx7e8E5L1kacC6e2bU1Kd8=;
 b=Q58QM7Y4HLbpIj4YR3cucsTgAPYbMFUz6+4Nbif32Ix1rLDdVzfRWYVo5ACPCNWYRbWkqJdUttG2Ge031Gd4dRvIpYLbbfYlBJxK4upu0Jwt/cS7EHHY8jNWFVwaT/gQ2hF68DEGRNcXJHUVIx8WI89uy1yLp5yt7MBMXaMo5kWFFZayQHyWSlsiHiilIf6agQQtLxkEvrtcPGa7f1uLy2CIbVmDUa1WdEzoMhhNJwFbxVI24jxDfW2hKedP+qknKZe0rHZIn81yZW+OkKe9Z5oz3k6+RPDK8nDD64X55ouTvhgExc14JzPmwLBiX83Ct4iWGxwebmhLLypsGlrpOQ==
Received: from AM0PR02CA0158.eurprd02.prod.outlook.com (2603:10a6:20b:28d::25)
 by DB9PR10MB5810.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 15:48:38 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:28d:cafe::5d) by AM0PR02CA0158.outlook.office365.com
 (2603:10a6:20b:28d::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:48:38 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:40 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 16:48:23 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 16:48:17 +0100
Subject: [PATCH 14/15] arm64: dts: st: Add boot-led for stm32mp257f-dk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_add_boot-led_for_stm32_boards-v1-14-50a3a9b339a8@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|DB9PR10MB5810:EE_
X-MS-Office365-Filtering-Correlation-Id: cc81faf9-3691-4f70-b0d7-08de2202f267
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SG9tYlBKVVNDTERkY1BkM1laYllvc3VvYkR4TGJ0MFRXSjF5bllQY3ltVThk?=
 =?utf-8?B?cFpWS2haYlRZTFVGYkwrWE01YmpBL0JUZUFieW9XUGZyZy92OEtXSTNpbWFk?=
 =?utf-8?B?Z3dWc3pIVWN6SkJCMTBBa0FKSktxK1pIMEdiQ3JHY05rRUl4WXB4eWZta1RC?=
 =?utf-8?B?a2cvcnJOdHJyUGh5YStBY1NiVEFTL2RLV0pVV2IwUXA1bm9KWFVRY2JxQnVa?=
 =?utf-8?B?WThoTjh3aEN5S0hNZDcya2wzVUNuTGZmZ2RMZXQwSEh3QnUxU3NIenQ3RlJQ?=
 =?utf-8?B?VjRGbDQ1a3FGQ2pPd085WWR0MlFHMHBCUzNrQ25Tc0JWdnY5WEJ0d2RVUXVk?=
 =?utf-8?B?YlkwVXkzSlJEcGY3dWlrcUJtTitCUGFSN1VNaXBlWnZ4YWFZWU1uRTF0Mm51?=
 =?utf-8?B?OW14bmhSNWx1RTZlZGdKYnNIdWVPZUdOL1BFNkY0Uks4MXZOVFg1MGFGSDJ2?=
 =?utf-8?B?WnlrcVBnaVdRUHkxSnNpeHNKR2xnNk9SUExvM2RzWFYySXppSlNZOTJ4Y0c0?=
 =?utf-8?B?VUw5WWhqYnJQZTBrbjRob0JxNXFMaXdsdXFnYWo4UnVybHQzcXFJWnRkVysx?=
 =?utf-8?B?Q2p4YTFSOGRnNkRXRGNiKzJyK2d5RDRyUkJCNDJrRHF3dllOZDlybFllcXFp?=
 =?utf-8?B?SmlZQ1VnQjVURks5N1plcllJUkRsUk16T3E2T3lVOUdwdnR1cHpwL3RYd3BV?=
 =?utf-8?B?ajFKVTExWWZjTVlZM3U0S1RBWWpPdnFBb08vd21NemQzdDBqNWJWV1hId2Vq?=
 =?utf-8?B?WFU3OVNxYXo4TGhCYXdBK0p3bEh4cnNWMWR2cVQ0VGNFZ0pXRVJJMGk1amc0?=
 =?utf-8?B?M2gyQmNCRGtGN1J1OVpFc0NvQlRuWWR5VE9xak52RTh3S1ZtYXVTUG5wWGhP?=
 =?utf-8?B?cWlUR1ZsT1lKQzQ2TUFNZzZzbW5GL09KbWJUeVJ4Q3NibDhEUlR6dEFkdGMr?=
 =?utf-8?B?Q1hPeFAxcER2VUoxcWV1Q214dDl1TlBNeE5tS2F3UlhmbGNQVEV6WFVvdlZZ?=
 =?utf-8?B?SDVhYk5NOWc0MjBBbDdDdUs2MlRtMzlDSHJITDJpS25QaGRUTzRieGNPcU9V?=
 =?utf-8?B?NDNhMStjNStYaWdVZGxFNlpDMjY3bklpZXh6VklDRzFoSHREMDFINlpEMzRn?=
 =?utf-8?B?TTN2WktLYWtSTHB1Ukd1cmkxcENnMDVTOXdGRFVzZWRHaHNMbGFVamZ3T1V5?=
 =?utf-8?B?SnpyK0l6ZURCOXY3QTlONElnMit5amxPVTdQOExidmNPbFVXUU5kN2dIU3VU?=
 =?utf-8?B?elJpY3dWaWM5NWk2bU5pVG9EZ21zSllzVE9abWthZnNJYmxuVENvbUxJclRk?=
 =?utf-8?B?eUtMTkhzMHlJUy9JVERuZjNtd3ZmMzNhNlFsc2Y3b1dhY2piOUNTT28vaTdr?=
 =?utf-8?B?czM2dm5JRU9WandZQTA1bmJ6a1A2NU9qVStnbDJlTmpXYkxSWExpMTB3c1R1?=
 =?utf-8?B?VHdEU3BQMStEQWhJQmVFenlkY1cwUlcraEpyRGR1Yk9hUW5Fbk1FWTlYNUJH?=
 =?utf-8?B?ZWI2OHpsN0lBS2VROGdFbEZTL0RudDVPeHNKYk12M2toMWwraXFQRkNobWFw?=
 =?utf-8?B?OGQwUUJ3NnpGdkFHblVJb1FFNTlCSFo1QXpIV2hUZC9sWGU4amgvN24wL01y?=
 =?utf-8?B?MHh2M1RWOHd3MXFoREZxV2doV0RITVhpTTZSVlVseDZJVlRzTnJtczhsTFFj?=
 =?utf-8?B?MndTdFI5YmFIUUl4RTlyTERLdkVubXpWSTRtbTk3TEVLcWo2aHlYZFQ2bjB3?=
 =?utf-8?B?VVk2RXFZV2ZvQXJiUFJUYXBIYitROS9veDhBREZGSXNUQ2YrUFpyL1hKNzho?=
 =?utf-8?B?eUNHREFIWUNmVHJvVGhzYVN3REhxZ28yQWdRZk0ydDcwWHU2ZXNOd0VFVkFn?=
 =?utf-8?B?QTNnZ0lMYURpa29XWDk1cnBNb1ZMd3dYcWVXN0pSalZoYXBGelgxUEczMUxi?=
 =?utf-8?B?OUIydDMxbUlGUm04NGNEazU3N2lHMVFFZ2FwZUh4QmFxZ1lKZjJleld0VFdT?=
 =?utf-8?B?cHZYWnd1ODltejZJZnZQeGNvSi9KOVZJM01lSVFmZGFISG1TUGZoTnlUNWF0?=
 =?utf-8?B?Z0JERnBLQkxES2pVWk8xZmFkQ3NvSjhTcm1uMEdKc2FDcnMwZ1o2Q3ZIZzBZ?=
 =?utf-8?Q?tUYw=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:48:38.4464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc81faf9-3691-4f70-b0d7-08de2202f267
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5810
X-Proofpoint-GUID: sKVFmCrp59OK6A56__ABIxN-ikaXXvQl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDEyOCBTYWx0ZWRfXx/sKoOeuHHOS
 IYWHenWm0si4AbBnwviA4afEjExda2oTgDf3NJY+j03qg3Hmpjcfk4n1TEEPG1mGmCQvLwZyYo6
 Pjnvjwk/CjkU9W/OVKc5ojyT7vm4I5dTIiXvPfqwHG22bf3/UCL9A90iYyo6nJ32UfNh0tMyVM7
 DVavZKJRfY1HK4xODK3MQ82g2Ar5hVGLUbf90f8jVtdkIo9tBcEoRF5gr52124E9bKs8Gjjng1T
 Zz6MMCN6QEj2DvQBc4L5uQ4iIxkba5nup1ehdX41Ca9+AtqYAFh10wdw2ylw20zClv/Sv+jka0H
 Ycltm8sbMpc0x5X/c6llGalm8GXWQL/soyEpsHKbsNxlcvc3YfWGPExH/5qfN0My5ImMsedsmxA
 OBfiI62fy50xYKoWoSf/2YdTxXe6dQ==
X-Proofpoint-ORIG-GUID: sKVFmCrp59OK6A56__ABIxN-ikaXXvQl
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=6914ac5a cx=c_pps
 a=MFwqwqiNWLUu7SydzG1yOw==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=8OzEVrWVIK6RD9uD4J4A:9
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
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
index dc1a75f10f49..d260e18cc1c9 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-dk.dts
@@ -46,7 +46,7 @@ button-user-2 {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		led-blue {
+		led_blue: led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&gpioh 7 GPIO_ACTIVE_HIGH>;
@@ -70,6 +70,13 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x1 0x0>;
 	};
 
+	options {
+		u-boot {
+			compatible = "u-boot,config";
+			boot-led = <&led_blue>;
+		};
+	};
+
 	reserved-memory {
 		#address-cells = <2>;
 		#size-cells = <2>;

-- 
2.43.0


