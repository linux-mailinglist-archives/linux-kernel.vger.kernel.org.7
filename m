Return-Path: <linux-kernel+bounces-879889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E47CC2454B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59DC54250AE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE43320296E;
	Fri, 31 Oct 2025 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ixSGo74q"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E2D34D3A0;
	Fri, 31 Oct 2025 10:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=91.207.212.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761904867; cv=fail; b=UCnf7MStMR54EaCFluPv3zrFzRDmwxR7tjT7NT2g3QjscnidHsA0w3jSebFK5+1jqJFhdq3WR36W0y3I0q6UBNODJFueuUM+DJvqlVZepraCQ5eEfOYtmpz//7ni7LVasB+FEry8NWKm5fEEKbD4Gd2+mR1107zNXGnEd6Ux0sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761904867; c=relaxed/simple;
	bh=juc3/W8Bod9RBlMJ32MdCQGwyfdISz4NddDLoEe0Nqo=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jEoM7OiBRh98wXdpVs8D8PpIFi8NWQiVMh4Mq04Hc2UzuMx/l0qm4HFwE7eKpJpHIoORhE8aL5ZI9N0JdAo2iEX5a84+qG6oan/ZFSCmfMG4uglK9gWpoUFRpZPLk4AqNZHvKptOCqoRkcrpJhJTitwol7szdU4fqfgk9VBvCf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ixSGo74q; arc=fail smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V9xotw4003737;
	Fri, 31 Oct 2025 11:00:44 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a4t0mrae6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 31 Oct 2025 11:00:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deQ0/ZEomkfO7n68mzZmFB+/XpDtdbQQPX+ke/KDBpq2QsoYxItpgZpa5UEs5SKtgKMpD+hD4BruiPwtbSJXADz+QQ8a6QycscvOAj2ur1w4OEdU6vooqMyOpGgoby7f6mirFp2lF/V75v6/by/3M8tRTmQXkvcoRW+BHrvfCBsVC58WKJriU7GB2EYuaShRJBQz/cv0Luxtc4ZOXsI0nromIy6CkaCJ/0NxDGRHGWK2DHx3bgLJjhxAKkM1nRzMwrDMis154CgP6AxdNYxVUsn6Fg5fFX64HFNxDvxgdLzQSlDCbGW3KwCSpJ6gW0HbgM4Tg7Pk76GwiILmlveXIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olTdvrJOaGswzSdrPqkpFRmWWHngZkLFNzciWDkfYjo=;
 b=PEE+mgXOGftnA9clHb0BDMDaKmjdJ6tog4XT/QtAudmvc4NVoZa/YP2490IrXRkr7TjtLkVrVmqpCOVh94U4g6YwQJOS/hm+l5qrQfNNX8tFmx28ofkg1dqbj6l6nnPfHMQU3bNhnq+27tEFPefqoZZ5gkqh7NwIEXnJA2gGz1Hnm/zrn6T79RWzOuaOn/bP1sWqu9WpiPNG+B9bxW8cxqUpqmm7go3/iQnunIYJA9vcTfVO5ylvKARDjzMQNBjBRlY6+sCdlLlCJ1Z+lIC6kufnFXK5UM6vpj5/gf0g1Fy4656ypSf/DlMYW/Kf0BCiV6HkIguxuRjOskT7X+/FWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olTdvrJOaGswzSdrPqkpFRmWWHngZkLFNzciWDkfYjo=;
 b=ixSGo74qrD5O3O4FOS8pqFDPvqmcXqS7SMFEZGia9mM9uWE7B7C37Gm60muL6nnVDloBXxrLvkbigizqRB16MThnw6ui7hf6y7FGw611du5cT4E93nXthh5kgy2iAA0xS9VQu1yTJtb+n3XHYwXS0wFP/81EZ3HzMh5rgTd2HbvSiX/upg34VZBcGrDOEMsj5pgz56v+0lv5HL1VAbrzV5xsEvPFCcJYrw2b5pry2Ti9VYuutccMZ5F4Y77xIKRoWPWuY11b0P3KUVz5xbHc9Ri67e46Ns+JxpIEpjYQKIbHnc8Ar+8Qc6F8TRSSfXxn8R51b6NJfqgBpcZpTq8Nxg==
Received: from AM8P251CA0003.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::8)
 by PA2PR10MB9114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 10:00:41 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::d9) by AM8P251CA0003.outlook.office365.com
 (2603:10a6:20b:21b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:00:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:00:41 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 10:58:24 +0100
Received: from localhost (10.48.87.185) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Fri, 31 Oct
 2025 11:00:40 +0100
From: Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: [PATCH v2 0/4] ARM: dts: stm32: watchdog updates on stm32mp13x
 platforms
Date: Fri, 31 Oct 2025 11:00:39 +0100
Message-ID: <20251031-iwdg1-v2-0-2dc6e0116725@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMeIBGkC/13Muw7CMAyF4VepPJMqTrG4TLwH6hClbuuBBsVVA
 FV5d0JHxv/o6NtAOQkrXJsNEmdRiUsNd2ggzH6Z2MhQG5x1ZC94NvIaJjR2PLFHIuyIoX6fiUd
 57869rz2LrjF9djbjb/0XckWMdcHRsQsWPd3GqNrq2ob4gL6U8gXKxHm8nAAAAA==
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|PA2PR10MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 958d0ee2-11fa-4994-0fee-08de186459d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzZHRnl3cE1jaStPelExR1k5M1NldjdWanlydGJaYURnV3ovNnJwcUQrbjBG?=
 =?utf-8?B?ZUxRWVVET0JwenR0TEZwQU1RL2ZKTEJQaXByWEUvcFVSbmt6SzIvQ2dqbThO?=
 =?utf-8?B?azFWSnZ5R25Ud012MUw5WE4yZERKMm5ONzkyYWhmQmhZc3pScnlWcXk2c25N?=
 =?utf-8?B?ZlcyZ1M3TWtJcEdpdVN3SUc5dEpDWnlrcnB6bmZqMkxORDNsZGV1NVVyN2lZ?=
 =?utf-8?B?TkdLc2RLMnZWUU9OdlBjVS9MZUtZWVFsUG1vK2c1WmhreW83TWVJRkpKR3pP?=
 =?utf-8?B?TjlzSGp1TW1iS2k5YW9hRi9qL3QyeEFjeGptUU9lbWpmYVVaVnpOcmhtY1o0?=
 =?utf-8?B?cllxUVRRRE9nbytBQzhWTWM0ZS9hd0UxQ2IrK085N04xSDZaUnJXS25iL201?=
 =?utf-8?B?d2JHZitmK0IvdHJuaWptRjFmemQ2Mk1LMXl5aENMQUNMUlhkUU1na0MwTFNj?=
 =?utf-8?B?ak9MQWk2VDlvODkyZXQyREVsYmp2UU9Wb095OHVpUUdIUXNBa0sveHU4Yktq?=
 =?utf-8?B?QTZsMFBYdzR1dG0vcjRmMUVUSVlOR0R6UjdhSWlxZDRQd2dKdlFQdW5teHhL?=
 =?utf-8?B?V3F4OWhDSk9JSHdtUThhMVZxUm02MW5ibTFxMnZSQzRTekpJak5vcHErUFJ1?=
 =?utf-8?B?eU81YmlWaTVKTnBBcS94dytDUjlvTGNrRHF5eWFHdnkwaS9wU2ZsdHYzdldS?=
 =?utf-8?B?emhHd09VdEpWT0J5dEUweWRCMlJDWm5zcFRTL2s5bmI1cFZ3M2MvdW1SQlJL?=
 =?utf-8?B?VkpxTmplZUdGMlFNdXcycXRDNGhvaStlUGhIUEs5eUlrOUJobURhbXhSL1JU?=
 =?utf-8?B?NkdBWHljVkdBOUk2azJQYVZqSTV3Vng2WllzYW5VV29rQ1UwdldFcE5PaXJP?=
 =?utf-8?B?SzUrdy9RQ3QzajZWTVRQK1FvdUlNV3FoLy9wWUN1VCtSa1hESmxwNnZ3MDJC?=
 =?utf-8?B?dGxWRnRkWG1wVFNyQ2J5VjNpTXloMHFLS1RIK2dQT0FGV0Ewb1BaeGZlRGRB?=
 =?utf-8?B?YjdsUjZWampkT2J6Z2lHbDF0cGlBMzNYR1dXU1Nza2IySVNOV2pkMEZZOTVk?=
 =?utf-8?B?Z2t5NmRoYmY2bFQ2TFZ1c3BZRkM2Ym9kSW9CakpJSTJxQjF6NGpGc21lMUxE?=
 =?utf-8?B?NWtnYllXRWtEUlpEd3ZSSThnbUNzS2FjYWZuVlE3bE1HK3Q2ZW1sR3czT3FF?=
 =?utf-8?B?RVJSTmRib1g0YzdiL0RvNGtqVDlyTDhjK0RFR0FtL3FOVDBZcEo1M1ErSWdL?=
 =?utf-8?B?dDZ5eUFLNGthYXk3YmFXZWN0amVUL08vQ3QwK3NvMU5oRUt5d2EzanVuUGVH?=
 =?utf-8?B?dkgzTHFRemIrVGJ2Rk5zR1F4UUpJSzcrVjhCZUR1RCtFdThzeTJvSWlnZ1dx?=
 =?utf-8?B?a0hQazdsMSt6MDhvbXJlYjRYaGoranFzNVVaNGt0c0wwVzFydWFtemZ2ODls?=
 =?utf-8?B?VGVCRTdEeFBGYjdEUkE2Y3JPTTFORVdIS1BSTWtkRmhvM0s1R0t4bmdxdWVI?=
 =?utf-8?B?SFIyTTk1bWxDUFJUREFSN1IycVdCN3haOHNaRVRJdHB0S1hjaWVIQ0k4aHJR?=
 =?utf-8?B?ZUhNS3M4Z0tYNUpXbnNMUDk3bkQ2WDV3di9NUktUWGx3TUlCdllTamlZTUpl?=
 =?utf-8?B?Z0R2MFpPS0NjcWVrTEhHaVhndkx3TjNGN2p2NFJYaFdoWHl5eldOT1VYNFdP?=
 =?utf-8?B?QXQ4aDludnROS1BFR29qZUw4bkk5cVJhV0Zad3hOazB1V2FkS05XMlJkZmRS?=
 =?utf-8?B?NXM1K3dKYk5yK3h4cVFuMnl1QlY3SWpyaEJQdzd0ZU1xUnQxdDlrck4zdElG?=
 =?utf-8?B?c0pSOGJaR1BMVldTMjZ5Z3V6NmZxalpaVmlJSGdEaENJNmNrMWt1THRlaWlO?=
 =?utf-8?B?NzRWamJHdEpITmF4WnBER3JINnhSSW04dUcrWFdZSlc4eHdSbU1EajlyMTlS?=
 =?utf-8?B?enVTc3pWbERrUEVkWUdsOTZuUHQvUndDUlNQeWlMQThjTW43OUxIVWhYalM3?=
 =?utf-8?B?OEozZUVPc3VqODBNMHpUaTBGa3NTRko2OHl1N3J4SUpvTVBGZC9zamE2N1Bq?=
 =?utf-8?B?ZzVHZGdZYWE5K21Kck9BNjkxNEVXV0kzMEJmMDlaTkJtbUZCV2xJVzlZRDgy?=
 =?utf-8?Q?4SWM=3D?=
X-Forefront-Antispam-Report:
	CIP:164.130.1.43;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:00:41.5442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 958d0ee2-11fa-4994-0fee-08de186459d7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.43];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9114
X-Proofpoint-ORIG-GUID: yb6yWrnn4EFoSU8fGptS-XXnmDK7J5ZW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA5MCBTYWx0ZWRfX24g4/pymxKFM
 2AVtW/XwVgAUgQdHvBWkpa+Z+mQbeMGehPt6cqlImya1LDvaLCug2+DTohO9LpisM7fjAlSrxkI
 UlaurEKBmvKv5SmAr/ElmihuWGN170InQFGt1XwfuhMG3otYdGvg5biauonolkyq5UL4Ya58Swf
 SEOdWztu9W+Tz5dkByJbn5KC00YZUZmI8vCWQ637FvIW9OW4LXkzHg5dS6JsyRDrwyw5Qh76LN9
 N9C1RS+0zqNHag9NasbjHl5lIkeXHAL/JvjKIf++kPdj5Lgq2tA9+eQn0l2mgRnMOHOM/HIItZK
 9MDELfnwH+afHC48mbNqfcSjYjTEW/lz+BUo3GPu8vymFymogQTX+D5/cAwpw5UcVrCDs+6ofWy
 I4TTv5vyAvdwvamnbEkUshN2LC9bJA==
X-Proofpoint-GUID: yb6yWrnn4EFoSU8fGptS-XXnmDK7J5ZW
X-Authority-Analysis: v=2.4 cv=U/ufzOru c=1 sm=1 tr=0 ts=690488cc cx=c_pps
 a=EZgaof5W1PwRFPttEW8xcA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Wpbxt3t0qq0A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8
 a=d0MjoUQ0B-Ieqs7PGqsA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310090

The IWDG1 can be used to monitor the Cortex-A7's activity on stm32mp13x
SoCs. Add the IWDG1 node in the stm32mp131.dtsi SoC device tree file
in case this peripheral is configured as non-secure and managed by the
Linux kernel.

Add the arm_wdt node in the stm32mp131.dtsi SoC device tree file in
case the ARM SMC watchdog driver is necessary to interact with the
platform watchdog (e.g: the IWDG1 is configured as secure).

Signed-off-by: Gatien Chevallier <gatien.chevallier@foss.st.com>
---
Changes in v2:
- Moved the IWDG1 under the ETZPC as is it securable. It should be
  managed by the ETZPC bus.
- Link to v1: https://lore.kernel.org/r/20250918-iwdg1-v1-0-02c2543c01a5@foss.st.com

---
Gatien Chevallier (4):
      ARM: dts: stm32: add iwdg1 node in stm32mp131.dtsi
      ARM: dts: stm32: add the ARM SMC watchdog in stm32mp131.dtsi
      ARM: dts: stm32: enable the ARM SMC watchdog node in stm32mp135f-dk
      ARM: dts: stm32: add the IWDG2 interrupt line in stm32mp131.dtsi

 arch/arm/boot/dts/st/stm32mp131.dtsi    | 17 +++++++++++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts |  5 +++++
 2 files changed, 22 insertions(+)
---
base-commit: 53c18dc078bb6d9e9dfe2cc0671ab78588c44723
change-id: 20250918-iwdg1-0f7ea155135e

Best regards,
-- 
Gatien Chevallier <gatien.chevallier@foss.st.com>


