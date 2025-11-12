Return-Path: <linux-kernel+bounces-897442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC03DC52E86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54F4C4FD112
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 14:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83986347BD7;
	Wed, 12 Nov 2025 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YLaPLBP6"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246EA34679B;
	Wed, 12 Nov 2025 14:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958460; cv=fail; b=ByO/hmhha79co3fhW5dxRdC0dIcT5ekM0tPXzSJWzhe2LPmGFrhtQ6s3sLxsldv0dGMR0k6W935VHrXY5ic9/PUhCUdOyf6Q0F5fv87gYch6Ni9l+cMGDXkykRs1WgdeWkEA9VTm1S8DvPz2mOtVvdBAbPcrSElLtAZFyzjfmnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958460; c=relaxed/simple;
	bh=4JTANo/OCjdFCmtwsJcRBD6JmihNfE7OOitNkcf2Xj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pWZLAiJPzaVkMw/SRcbmljrATfZ7U2Ps77S2jNATBngfEct+KDLI0Ehr9iB8Fdtcjz6y5qzXpwLwdz47XZ+Epgb5W7Lb+eVWnIv+LXWeiKbv1UVXWfq/4mdD/NkvOyjCy0JZZSQoarmBXP5WrqWcSS8ITnIqtvEgbsWmwbbyrrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YLaPLBP6; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ACEYHEp1802916;
	Wed, 12 Nov 2025 15:40:45 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4abfk0hgm6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Nov 2025 15:40:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCoeb8Jr3MitLOi28ieYLptmITMRRAbvU4a81WwE075HBm+22hHvQpECGz3Se9tuv47Qc+vtXMzQTm0V+rCCoqbaqXBzEaAt+dfn4U5efkZIFG7CL6f4vgo1kRUd7nL5n8OVEmonbPDayC/4AEf85fLOVFmEaV7FL4aRP8d13lXbW0DKF8JV6bMnKfVDVwARQ1OKq+BCE9YQ0UUhfWtbYjCmmMwvPCJzz+s0IK3W69wKChTPQXwZ8ag5TQyLeqYgxe2bpk80i5/NcDO4Csqgv2jlxQ6J0he6e09PTV94VkmthcrEk38qxKYQVj6KVblXZdzSIeJjA7+jpBCxTSRCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EQHNuXFbDFkzHOA5dwySgO4GQ/sTkkYsujIwbrJMSM=;
 b=E/dtwhx/jkeimTpB/oQ2stZ0KXHmUOd1L+mQJRgeVA3r3txjtgdgKDGcpsxqpxmnb2bwNs2JjCYyu7TqCIambw33AKR3yOy2GQC9vd6qpVquYdPPubufR8QTSGFYVijki3H1wJQ1cYPhP1ascZz+kurYAxhitQUGRHsZyOq0mMqMoNVcTV+W8mTnC5ActPQTHbDR/1pGQGJUNznQG2FPSLRzPu+C5McexTOb0FFMVuSntxFBd3QY6yB82QoyBTbovEXkXCE6Kt2tPEDxHGA+dYEA083tqIqja2dJFHxNp2mj0l23AzeMdFJ5sMMaeOBa4mGpg6catIyZkPLM7LkKVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EQHNuXFbDFkzHOA5dwySgO4GQ/sTkkYsujIwbrJMSM=;
 b=YLaPLBP6loJZJnwaKtdngSej/eZ7xxKkm/OL2i8y8kyuiKNjjbW06rdMBwQlICfX5wEZoJkIUagZV/sla/a1FCYJqWyyFMJ15jZ8Sc1t3Dr/BenYJbLZRwSSs6xkpMCFYCBrItexYV1yvoKyOf72AEUYGkgZodRqOINfaHInbxx1fynjPyjF7bqEz2oltgBhysvuCpG9Ms7dEVzntk0dj7YV7vBwJtJ3oFAVdvBXvqb6MXq3/SnipNIJ0hI0eFBIfFG9eVgfnTExaMNV4vTPoM6Wo22quumcI9Mz5U1MV4xvghXLX0g7yxbEwDb+Fsq14VuBC9A40yFMSD35Nt7+cA==
Received: from AS4P190CA0015.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::19)
 by DB5PR10MB7824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4a8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 14:40:41 +0000
Received: from AMS0EPF000001A9.eurprd05.prod.outlook.com
 (2603:10a6:20b:5de:cafe::57) by AS4P190CA0015.outlook.office365.com
 (2603:10a6:20b:5de::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 14:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF000001A9.mail.protection.outlook.com (10.167.16.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 14:40:40 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:50 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 12 Nov
 2025 15:40:39 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Date: Wed, 12 Nov 2025 15:40:29 +0100
Subject: [PATCH 12/16] ARM: dts: stm32: Add red LED for stm32mp157c-ed1
 board
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251112-upstream_update_led_nodes-v1-12-f6c77739113c@foss.st.com>
References: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
In-Reply-To: <20251112-upstream_update_led_nodes-v1-0-f6c77739113c@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A9:EE_|DB5PR10MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a3ba8e7-45bc-4914-f29b-08de21f9737c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVN0cUJsMGY0MFV3dkpRem0xZmkrYkFJMmpreFZxemZScWRjMTFvZWdBcm5I?=
 =?utf-8?B?M3JZUzNReldIaC9sVTM1K1B1WXFlR1N6UnJ0dWg5YUNKTzZUSm16bitCdFEz?=
 =?utf-8?B?bFEwTGpoa1l2Y2htT3RnTDUydEV2VjA5R25Qa3dHOE9kT2NlNFJPZndTKyt1?=
 =?utf-8?B?Zk5zcTVLTUg0TVZZajFIRW1IcGdTMitia2FRZDk5SklLb21XWExidHNvV1Jo?=
 =?utf-8?B?My9weGNkaEpPNDAxdnVrYUNBUEdDVkkwUDlCL1cyY0dZelRlZzdIYnRXblUw?=
 =?utf-8?B?bVkyV203OXFmTjlHQk5xczdjQmpIRU9GU3VuaUZjMGpSUmxpTit2c3VpQTdh?=
 =?utf-8?B?aDY2TDJ1N3ZYbXNsNjhjcnBoaERsMGVsQmZPYXpwckV0Vy9xd2hSbHlYUm1F?=
 =?utf-8?B?UVQ0MXdCUHBkZ2RsS2VmZjM4WGVpQng2TGVNYU5Xb1Q3Smk2Rks3RkJzVmhk?=
 =?utf-8?B?c2lFdHhvTkVDdDRsVmVlYytWY1ZSbDQ5elR0bVZua0tSSzY4VlYvaUx4TWFx?=
 =?utf-8?B?eE1ON013cmkwUDhiMFBYL3p6TkVjdXRlNGZET3d5OUdPUlpsdmhaaytkanpm?=
 =?utf-8?B?WlhQZTg0NTB5aHd4QzR1S2FmWGpHSzZqVEFrcDZFaHlzK1ZxVUFCV2RsQXNH?=
 =?utf-8?B?ZHVuc0V1OFQrczFqZ2JRZmF0TmVlZk1XS0RVRmpGNVNlbFAxZmhXSTM0T2ty?=
 =?utf-8?B?SWpnVG9wNlMvNXc3T2YvK0N3Z0c4dEEwdWY1KzZaOTBZSURzMGRZVVN3Qlds?=
 =?utf-8?B?OCs5a3hjNmdCNWY4NzhmcVZ6R04rWjhTVWh2ZDIwcHRXOWd4YUFKZWg3Z3hF?=
 =?utf-8?B?KzJtZEVUaTR4K01LOUJsVnYxUHgvVnBNT0I1N3BwdmFtRnVKNU5STjN5dSto?=
 =?utf-8?B?MUZsY1pTL2JtVE9QTWd2Vk9NTFAyaFlaNVYrSFYxK1kxUFVpMnYzRW9xY2Vv?=
 =?utf-8?B?cGZiNTg2blNsWWxjbDh6ZjZ5bStreUNSODh0bDJqT056WTZONVlWQlJFeW5y?=
 =?utf-8?B?RDZQN0NmM2hGMFhrUTV5ZEZmQUpCMGozOU9nT2lselNMb2lrUTNnUVl0Mnk5?=
 =?utf-8?B?NlRsYlVlOXJ3ZEV4WnFWZS9UTUpGMjYxODJlNTBpdGxUc1F4Ym1LditCZ0F6?=
 =?utf-8?B?a2UwSXNEaGhkemtQYzRubzVKSktpQ2FuTmE5Vlcwbyt4NjdrOGlHTzdDVEM5?=
 =?utf-8?B?WnJxdWtvYkpQSnhwVEJabFpvZXpwMEwydVQ0ditwL2M1aGx2c0F2SEdEbm11?=
 =?utf-8?B?V2s3UjJDTjgveFRManQ5Zzh5VlVOUG9WdGJaR3MydEEwVENNM0xHOEF3NGNU?=
 =?utf-8?B?YW83SGxaUHJCWVRiSzgzU2N1SVJyc24xMmlyU3gwaEN0UkRRdklFRVN3bi9X?=
 =?utf-8?B?c0JHRU9TN0M0eHNyZmVwTnAzaE9sbDRFeG5wclpGMUZCNkNmUXVyUjdiS05k?=
 =?utf-8?B?YldOcVlNMlYxY1pITnB3VEpCWDB5OGNNS0VCdVJ3SEF2aG5XT0NjVTdsenlV?=
 =?utf-8?B?WTZIV1ZkZEU4MmIwRUkrdGN2ckg4NS8xUnlPKzRRN1pvd21NWGw3cGkwY01K?=
 =?utf-8?B?QlRhY1JtM0JjQmdjMU5wVkk3U0IrVDlhNXhkUWIxVDU0cmovRlZ5NEFQNDl0?=
 =?utf-8?B?eDlsZ3JzL3luWTRGZFBnbEhvRzJDMUNrU2JzcXNRL2RMN081clFNUWVnM1Ez?=
 =?utf-8?B?UWdLemhRbC9rT3g2bHFFU09JdHI3eVZxSWN3OWRNQWF2ZW9qUXBPMWhiSXpT?=
 =?utf-8?B?T1B4YWpUSmdJYks4NXFTSExtRW1GVUhkMnV5RktHQzVpQUF5cFc3R2tKTHMv?=
 =?utf-8?B?eVZzSXhuUEdFUUtSSkNYKy96dVZMM1o5cFpjY2NiekVFK01ONWxvZzdCK1N3?=
 =?utf-8?B?eWJONDRtcGpoYjhNUmpHZi9pTUZ3LzRGbitIMTlZTUUrdWYzc2IrbldHbW5u?=
 =?utf-8?B?QW15U3E3dVI1TmF1dGd4VkdiREREZDVITEJxQTdZeVpZY25WY2RwT1c3aVNa?=
 =?utf-8?B?OU5OdDVxVWNWOFFiUGNkVmN4TERJcTU5azRCUkpDcVJwN3MvU2wrc0k0S2Q5?=
 =?utf-8?B?QWt3eHU3ZUUzU1RqbWVJU2R4Vk1hYmljWnNuZmJFN0FIVDJzV0Q3dGp0ZVBt?=
 =?utf-8?Q?EIYo=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 14:40:40.0488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3ba8e7-45bc-4914-f29b-08de21f9737c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A9.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7824
X-Proofpoint-GUID: 0UCK0np7uab4ml_jCtj2le50w_2nI69P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDExOCBTYWx0ZWRfX+gyFKh79bR/z
 I6dVpdTFZvn2ISexlgTV/8hw87ee96itnOVXvOMfS7KcA9xb+sHTvPiY6oYzy8wKz01Xqz7iEF+
 2iLMVZeuuD26D7cWYo/22kpKB8zHR2pRG3a9wD5O2sqJTTlnkF3web1pnhidCepDe+WlrCLdetu
 Maei92oSzOk4YlAWXc7N++CaYbBuRnGb9TYrWjgJ1J1kjH8+TpIQ410v2syybI+VLNkv+IxZk5i
 YFwDPI+IpVCSNo3gRbJ1v5ZhpEz8a8cGt3Omq8/4GB87PznbgcWAY2TJkPbry9eGpZvj4JMSfeB
 dZVnHqHvhqRfXKM3Or6FIT5C1P+JBTIrY5eh1ZDdKbnaR+K5+V5fP4cOXTsukt0uCXq9/QBTsLz
 4ifqQ2G9JbSorXLdFmr0HVGaNL333Q==
X-Proofpoint-ORIG-GUID: 0UCK0np7uab4ml_jCtj2le50w_2nI69P
X-Authority-Analysis: v=2.4 cv=a849NESF c=1 sm=1 tr=0 ts=69149c6d cx=c_pps
 a=siRb+Px2ILhIpkBuM5jyjw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=zIsizn63LtRJFoyuEFEA:9
 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511120118

Add led-red node for stm32mp157c-ed1.
This LED is used as status LED in U-Boot.

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp157c-ed1.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
index f6c478dbd041..6a1c4e5d31a4 100644
--- a/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
+++ b/arch/arm/boot/dts/st/stm32mp157c-ed1.dts
@@ -81,6 +81,12 @@ led-blue {
 			function = LED_FUNCTION_HEARTBEAT;
 			color = <LED_COLOR_ID_BLUE>;
 		};
+
+		led-red {
+			function = LED_FUNCTION_STATUS;
+			color = <LED_COLOR_ID_RED>;
+			gpios = <&gpioa 13 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	sd_switch: regulator-sd_switch {

-- 
2.43.0


