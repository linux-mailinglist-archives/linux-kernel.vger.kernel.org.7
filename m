Return-Path: <linux-kernel+bounces-899671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F4BC588BF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2F454F9D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0702A2FBE1B;
	Thu, 13 Nov 2025 15:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="W4+/N+BJ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2886B19D8A8;
	Thu, 13 Nov 2025 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048085; cv=fail; b=kVO5cfKRwPj9Wk6T93fA8Qnncw4coo50esK5Hw5MxsFrJl+HnYyfZIRT+6lWAY6++Z/twCJTHzo1EbQQ+c+6eJb30B5y2iV8MsbBvQOg2A4Vas8VN5MiaRYRsm9UIGPsy8QWVO1FIS8nZUWqPiiGvZd7WGcJYMvbnuER2unpjvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048085; c=relaxed/simple;
	bh=AO3Fk8quRr42PUKJPRCKocBNaCSqwQkEtSE0K0a6ryk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=V/l+CC3tOgqlzyRhUNxwxWB02gCnrnAqcOjCif12yGIvH3Lc039eTJjxrYPmicXKzfkoYfgXuoxxoNipuGZ7SuC9mbAavSo1H/9hO07EwK7vom9OcGnzO8KemZ/lAFoMxlrRUUFKrvs0rEq045ZnVJeNvyCgZ8VBx7eJb6oPw50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=W4+/N+BJ; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ADF3vYi4121800;
	Thu, 13 Nov 2025 16:14:06 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com (mail-westeuropeazon11013048.outbound.protection.outlook.com [52.101.72.48])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4acqa7e637-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 13 Nov 2025 16:14:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kS8RJERSYrhtum0oVcHFynE05/c7IWolS6zI4wKjjMw9tEHzBBUtDNaA05WQzEJKHenNnZDLlO9ifomjxj1kDVCYt7BBbmloCUoy9IE0UC11cUCW0vAvw64Iv+bdrYDoi4RhWwVSVkjSvc8gKc0JsUK+kPYplHJPPv1E0xvaq8mmXyMnJlkp9tS6dLUMFgsYmYyBkyE9KY1GcKdt+IX/uqYyvPJJFXdiogsQAte5WYNJTSzYOK0rr5JQjlG78PRPciK3drQ3GmdG/9cJFEFVz0+auUopJH3E4JzzrF3qpzHkrLl//JzSizXHug5urzQ0OMLUN+C5BKTbaihUA+QJ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwTDHTTnXwgEqpAqZ5vXB0+k0u3TTJ/e1pqsLsu/SWw=;
 b=VD9thOyxtxGdR5DHiaB9JC4B+cl7DrHDLUYjWUNIUSj0GzhJfJ2eOR/GlpDMGAkW5IIh75jECSsbn6oWmIRx317+0jN4shfVm0JXpG8GboZ2M2Hgi4kfIvxmhmQOPD4FHnf1NfORSkFegNyuf7Ims2qO0EgbykrCAT+eP4S5niRQgfWMpUzgzrP6GGHG0Ev/hZafQcDcKCNgwzGNyvhX9uRVHtXbMZZgDy6DXvUrgGFhlVyGhZZbIZESpwlmgQeJ7vfZQwy9gpUvCRcBjYbYtTyDY66//sGvAExCaH6vqZbK47DlXMXSk5R+3ZvbQhmNYX6iJznZT9Ej+Eh7mCIpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwTDHTTnXwgEqpAqZ5vXB0+k0u3TTJ/e1pqsLsu/SWw=;
 b=W4+/N+BJq3WgqJZHZJM8/p0q1vLMwFMUHiw1DwGP4cVAL6uu7sUsJlnf4AGgTdX0XNP5+Q9GEwKhID0bssOsVW0k7ngSItCWthtHwtVPN77U4LADS6IHKL8m+jrL73jXyLtz2E8dz9X5BPGglVqQgTbDTtEepcbw63I92Yd/ilwRILk/f6xCwDVUtnh9tNX7sfI5yX+CjdCAXMs+Xdg4xDj72TGCN/4pInf+iURFeU0BIqdkKqoO++tIJWJ1rKDal5J90CdB/Kr/ubpF64HOYN7A7RreZZjQ0u38AwmkE50+vgl7xT/mI+EsAUAtA7hUlwyKncjskH9OxgzrOXNlvA==
Received: from AM8P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::32)
 by AM0PR10MB3250.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:189::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 15:14:03 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::46) by AM8P190CA0027.outlook.office365.com
 (2603:10a6:20b:219::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Thu,
 13 Nov 2025 15:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 15:14:03 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:13 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 13 Nov
 2025 16:14:01 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Thu, 13 Nov 2025 16:13:59 +0100
Subject: [PATCH v2 08/16] ARM: dts: stm32: Add LED support for
 stm32h743i-disco
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251113-upstream_update_led_nodes-v2-8-45090db9e2e5@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|AM0PR10MB3250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9d16f0-0e1c-4b1f-5e4f-08de22c74838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1R6WG1HN3BLNm9xOXZrK3VRbFJFNDhnTmtwWncwaHBoZjI3QVR4RE1ncDZV?=
 =?utf-8?B?cWNxYnRSbEhqRDNRUHJyQkZscXFkNURHTWRCclY2TDRlNURSdjdlK1Q0ZjJq?=
 =?utf-8?B?Mytza2VFSjl5M09URlpuZ3JxWWZhcG9melVqS1p4ZGVCTHc2OVc1cnNuTWJs?=
 =?utf-8?B?TkpVeXdlTWt5eExMc0orM2tCMDh1N0NxV3BETEJwdFRXU3h3dnV6eHRRZHVx?=
 =?utf-8?B?TDVPNloxdFhaN3ovamVFVmMzR2g0UnRwcXhaWkNOQ08ybzgxaFNDZ1RicjZu?=
 =?utf-8?B?MU91Y2NRcmYzN29qdlBJK1lJQW9HS0gxNjBpYWxJVWIwV09XenVaN1o3Uk8v?=
 =?utf-8?B?c2V3ekR1SStOaG5MWjdXMmoyTVFSUGh4ZjF0eXlTMGRYakwrdlAvM3VKNzl5?=
 =?utf-8?B?VWlHek15K0o3UjNINTJaOGZocWlTLzMxdndqRjhoUlFhV0hGZUE4RjFmTWI2?=
 =?utf-8?B?a0lWMjNLRkZ4c0MrbW9WMjFPUE5GbHRpWW5IUTV6K1l1ZGFucmR3ZktiQm5L?=
 =?utf-8?B?b2E4SkFjSzZNMVVmVlZrYzIyYS9DVmh1WmN4NjFOZDhwZlp5ellsbVlmc0Jt?=
 =?utf-8?B?TU9VSkQ2VElMUEdNdmdHWjZQelAzeWl6YjNDaXBaczIxRWNQNENHcDR1VGlm?=
 =?utf-8?B?K3V1Rzk3a2xhMzJXOGpZNG9sQnBZaW5JS1JkLzVWWjNFeHliSTZTa0RVZXpF?=
 =?utf-8?B?M0RkeUZrQlYzRzlQN0hpTTJoYUwyQUtTb0QrckZmQ1Y3d0EvbnlkWjJXN0hm?=
 =?utf-8?B?TXBlQi9VWFBzMFNpYi9MajBaVEpXcEYzRjJFUjYrci92ZDIxcXBMVi9lR1h1?=
 =?utf-8?B?M01wYUhRQ3BzMjlLbEdRcmh6bHRUVW5VV0oyeDJaZTB3YjlkRHFZL0hnRlYw?=
 =?utf-8?B?U3l0YzlRa0V6K3kyNkt5aFN5em90SlRINUsrUTNKWVV3OW4veEgrVW5KWDd2?=
 =?utf-8?B?WWRnSW01aVMzNVBENm1FVlBpZUFUOFl6cDFCT2xGSHFmWkNRZzFEdmY4S2dL?=
 =?utf-8?B?NG4zeWUzNlY4b0pLcTRnend2aHNkT3BaaHZ0YVkzSElRclBxRjlTeHk4Y1VJ?=
 =?utf-8?B?TlYrM2xOUytwZzBDeno5QUNiN1R1KysvS0Q4OFduNWEzNWZQTUE1TWgxdUtW?=
 =?utf-8?B?OEZsMGJSRkhsdk9HUFRmRk5WZnNRdXZKSHFLZzdydHZqbkgvOHpwS2VKOEVn?=
 =?utf-8?B?MEZLRW9tbnMyU3VMeDdlVDdhcGdoaE9zRnlMNHZlL3RrVE1EaXBYMGk2dEdB?=
 =?utf-8?B?U1RCNGlPeVVRa1Jua1prMng4VTVJUnU1U1NoYzhTVzVhVlo1N3JwWUh5V3lU?=
 =?utf-8?B?T0hXekJVZjd2bnFidFpKUWxBRkhYVmlrdzU1MUJxK2w4ekcvNUo3Sjh0SEw4?=
 =?utf-8?B?RXFMTkpYVm5HUWhjN1BPWmFVSXZ1VmlxeXdZc0srWEpKZURzdkp0OGpEL09k?=
 =?utf-8?B?WkNhSmdlMk93SjFGakc5Tm9UYmd4WkhFVHJsZVFPWk51dXlBdmNuemExU2xW?=
 =?utf-8?B?SzNKODZWd2NpWGNmUUVaaE5MbVZla1Z6UE5ibVVDNHNFVnA3NU9zc0Z5U1R4?=
 =?utf-8?B?akxDNDdOOFBacTJtcjV1Ymo2UW90ZUhnbjNwL2R5MXU3S0c4REhhNW45a290?=
 =?utf-8?B?Q0ZBY0tCMjBGY045UjdlN1JaZU1GQmczdHBJY1UzMEt6b3MvbjBSUmhsWTYw?=
 =?utf-8?B?Rkh5NDF1UU5nYmljMHpMNmo2NTE4U2I4bDBEbXNPQ3VJeWRYU0RDMGNlY0FB?=
 =?utf-8?B?OTZsQmRhVEt4VTllcGZQbFNlUjJjL2xWemd5RmlERGpycktpQmQ1OHhsTHBh?=
 =?utf-8?B?T2FJN3l4Tlp3VjJkaXJwNHpUbGFXYjJBSkJXU09DT1c4dCtiKzV4UzluU1RK?=
 =?utf-8?B?dEpySkZSSnoxT0xzQTRQcklCSVptSFB5ZDBzekVOeFhxTWo0MTROSEdTOXdP?=
 =?utf-8?B?U2JIUTk0TUtWTEE5Mkd6TjMwak9RZUxHeGh5M0NoaklMeS9NeVVGdGlKYTdi?=
 =?utf-8?B?M2k0NnNianpIQW5JbUowbnh6UG1HaHN5VndUNFBMVERJZEEvcEd1dTBLNmV6?=
 =?utf-8?B?b2tKd0VFNWtkRXhCUHNjYTRDTUR1OFNBcEJPR0U0Nk4rM2NMYjAzYnhOUHJO?=
 =?utf-8?Q?8dno=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 15:14:03.7827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9d16f0-0e1c-4b1f-5e4f-08de22c74838
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3250
X-Proofpoint-GUID: _QPj7xMKT9K6xlGI2AFRmxDkkimKtXv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDExNyBTYWx0ZWRfXwoktx8U2jL0g
 +WH878a9g0FbsFB80hycfWGa5spQymP8lU2SB1PXZFhq5D0lSkRyxUncEQEOgvE2Kvf8uhJLbtY
 Du0J9rM8gYbtGhZ4TRSsokOg/l5apBUGdBUnNSvMq6tmFyqNdYPi3AGajgO15DfpOsjiXX17mx9
 jFoWiF5LPb/xvedrrj48/aBas09pU2Xc4s4uD3PAJtIkTN/h0GqaAq2LZ4/gpWxGdVEsTHLWqR4
 JZNypb8wAQNJXIS30QOvGuWKBNcgO4H4pHTIlzRXyhUlHnrwl6R9I/tM/oJEi/VwVtnEuZCDtBf
 pGi67K6R+vZEy+7p0XPRG2CoRAsO9vEX9iGs8eIesQqFTsqRn0FAYDSyoSRvJGo9SL0Q1JcGldV
 ZAMrQaWxHmx6l/mNKJEubKYXyYzSHQ==
X-Proofpoint-ORIG-GUID: _QPj7xMKT9K6xlGI2AFRmxDkkimKtXv7
X-Authority-Analysis: v=2.4 cv=VoAuwu2n c=1 sm=1 tr=0 ts=6915f5be cx=c_pps
 a=dWv+IZVXSp+wWF30QydOXw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=MH3SmirnJdOKttSIsTgA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511130117

Add gpio led support for LED green,orange,red and blue
in stm32h743i-disco.dts.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32h743i-disco.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32h743i-disco.dts b/arch/arm/boot/dts/st/stm32h743i-disco.dts
index 8451a54a9a08..f20266de4e7f 100644
--- a/arch/arm/boot/dts/st/stm32h743i-disco.dts
+++ b/arch/arm/boot/dts/st/stm32h743i-disco.dts
@@ -43,6 +43,8 @@
 /dts-v1/;
 #include "stm32h743.dtsi"
 #include "stm32h7-pinctrl.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	model = "STMicroelectronics STM32H743i-Discovery board";
@@ -69,6 +71,31 @@ v3v3: regulator-v3v3 {
 		regulator-max-microvolt = <3300000>;
 		regulator-always-on;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-green {
+			function = LED_FUNCTION_HEARTBEAT;
+			color = <LED_COLOR_ID_GREEN>;
+			gpios = <&gpioi 12 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		led-orange {
+			color = <LED_COLOR_ID_ORANGE>;
+			gpios = <&gpioi 13 GPIO_ACTIVE_LOW>;
+		};
+
+		led-red {
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioi 14 GPIO_ACTIVE_LOW>;
+		};
+
+		led-blue {
+			color = <LED_COLOR_ID_BLUE>;
+			gpios = <&gpioi 15 GPIO_ACTIVE_LOW>;
+		};
+	};
 };
 
 &clk_hse {

-- 
2.43.0


