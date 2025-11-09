Return-Path: <linux-kernel+bounces-891819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6BFC43933
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 07:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190D73B2630
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 06:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C478D23EA88;
	Sun,  9 Nov 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I2j/bw74"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012030.outbound.protection.outlook.com [52.101.53.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1F518A6D4;
	Sun,  9 Nov 2025 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762669461; cv=fail; b=PQzCDv+vRoT47sYNbMpirq7jifpqbgfLYyQP5Jca7jGF/1XGKYRPn4mCUEU0wbhmeNGzOy+Fmo2RtHLhCqhtsvUPrxkqmZJ0CYt/5489BkXnTtGkrOxExdMQikqDVQWPKyw6mk36JIbJrCI94QymSIuPbd3eAOPeDO6R/+s4qsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762669461; c=relaxed/simple;
	bh=8FwD9Y+JopWAwW+G12OJPiZLlAhW39CY0JHqYdMuX3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G287KqM9WnVZcAy/4y7orv/i+hY0/7iOE5XORThPrE2UE5pZ3iLPjm9yMOSfbbwB6iQEq5ITqLnHhj3Bechu3e1MCA8z95SwTC3iJYafERSnm4o7+dqyd0BFgJatsj6r0y+lI8yptkGs5jmnFtdQxDXqdO7wcrEvDy4VOS74CFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I2j/bw74; arc=fail smtp.client-ip=52.101.53.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BusOYSWhMuKj1avS3clsEGXl3Dw8F7noSaGrf/vx2qnb7PFuvvQ4WF2sQNMKe0U1UOiLXV82XjnZjTZLUIbQ5YhELGSRUDx2fZlm8tbkdrT7oCDF80AC9kjRURBIl7PNOXSiOtYd8BDNoWmeQPbv0p8nErKWNh3VwL7W5QmBmeH6vT9S464LaHEBKOaveub9u3w7FKFL3sXlyQuv1RFWNv3Hq3f73dlzcza9Hxv+nKiClFWHrmyyimjaKMb5YB396e5c0oSF0q5dNmld3LxFWuSm9K3B5BN/8gq1cD8/QZsZGijebkZF32bRIgQNn3YqsrOdU0rl2HvP8bB/yrfvGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKta1opoLlM6FdH5aApiGo9C5SZlRuIfO4eVSAq01EY=;
 b=d4sjIP9yxyCLrRwok1R6SKq2MUeAxCoG9SOS1qvIizUGtoVuWskkZCrKY5WQltSAA4VxZebRDTEA5Do4N7NYM77g2zpvniqFuBQ45BaUeqRkl9I89eWzq1/U+Cj057gim9bsV2CKKOI11hh50qPDWaKNZcC2DdaWwpk8WSnHizGWooR4k4vOyzQe+YRC2tLGCS9v++Z4wtG3NG9kM6Z2qruLeJiMlrVLhhWikVS8Q1lA7pNUPaMzYOdjTgDeK3PwdXfUDxolQnsQ9l94cH5R/6Ln8KgsBVtWRx0A+iv8TqTf40DSu4ZwqctNXqTHFgAXoQJnZYKhWeIqKRBtPKqoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKta1opoLlM6FdH5aApiGo9C5SZlRuIfO4eVSAq01EY=;
 b=I2j/bw740Bzf2slbvCYSrsD8ApVzvCbevpa2yyro7dLv2J0eRZhZhfot4+fhn2iwD5l4GwPy6v+Avq+mSq0Dg6s766AXKot2tMvTbh7gfPl2vqhziNdlXhIhVePM1i54Sx54hUvXrZyfqX0iWnauu8mYDeJvPAHdaG/fwPBooD8=
Received: from SJ0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:a03:2ef::35)
 by IA3PR10MB8466.namprd10.prod.outlook.com (2603:10b6:208:57f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 06:24:15 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::b2) by SJ0PR03CA0210.outlook.office365.com
 (2603:10b6:a03:2ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.13 via Frontend Transport; Sun,
 9 Nov 2025 06:24:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 06:24:13 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:24:10 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 00:24:10 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Nov 2025 00:24:10 -0600
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A96O6Wg1486110;
	Sun, 9 Nov 2025 00:24:07 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: <nm@ti.com>, <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, Hrushikesh Salunke <h-salunke@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, <s-vadapalli@ti.com>,
	<danishanwar@ti.com>, <linux-arm-kernel@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] arm64: dts: ti: Add bootph-all tags for PCIe boot support on J784S4 SoC
Date: Sun, 9 Nov 2025 11:52:28 +0530
Message-ID: <176266923841.19596.4147637793586614093.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251017084654.2929945-1-h-salunke@ti.com>
References: <20251017084654.2929945-1-h-salunke@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|IA3PR10MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e8ce6d-a709-4b1f-3b1e-08de1f5899f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qy8wNGU0Yjd5TCt3amJHMG9XTzlzT003YktIcVFsUHlrdzJ6WEE5T3FaUmVD?=
 =?utf-8?B?Z2huUHJOK0s3NGRVYTZHRU4yTVBYS1NDeWNFVll6N2NmYlpYR0Rab2xIM1lt?=
 =?utf-8?B?bUFQdFp2eDFzMEhWRFFJM3J5STBJY1ZqM0FxODFKTjZNRE1SMGJPYmJtSzFx?=
 =?utf-8?B?ZjJocS9JMm42UzNYR0lBMDI2cWxaODRYdG5ocDErZHlZdC9ka0J6M0VHSm93?=
 =?utf-8?B?MS9IT3NjSzZROW9hTDB2L3NnNDRMUEFqdUVSY3hEWVZZUEtlTXlPWVlybjZM?=
 =?utf-8?B?bDd2RktFWWRmRUhsUkZDaXAvODJTZEhaWmhHZG1OV010L3VMSjJiNFJwQ1U5?=
 =?utf-8?B?Nkd6dXc1VWV4NnRJeDVuRlpRdVNiMS9FVVdIOU9MUWlRZnlmVXgvUEswVnRS?=
 =?utf-8?B?RG44MzgycUM2Tzl5NjVOQXNwQkkveGt2UFhsK3h2T1ZLdFVZK3RSaWNIR2xO?=
 =?utf-8?B?MHlvWXczTzhKcHZVWEFQVlZwdjYzQURWalRHUnlIL3BDQVAxSyt4QUswRXdE?=
 =?utf-8?B?R2czYXhLT2hzYW1mZGVUNVk1SEVibm9xMUEyaitMK3hlbEFBMkRXMituQ1Jw?=
 =?utf-8?B?NmI3dGlLREZIdklRZ1dpeVZhdXZ3V2pxbUtrZzhsSlhESGJnR2owM2owVWdU?=
 =?utf-8?B?YzFuWWhiU1dSSFlnOHRpR1FFdVZ2b0dOWEkrMVRja3BUZGdsdTR0UDhIL1Az?=
 =?utf-8?B?clJIMjZMdnk1V0hVZHhiSTJuWm9LaDBkaU5TcGhaS1pQOVVVRDc0VlZvMit2?=
 =?utf-8?B?N0NzdGlmQTRiSU51MURjbFBpdEh6aGQwMmlKSjVsT0x0TWJmOHE4Q0NyaUd4?=
 =?utf-8?B?ZU4zUXl0MEplalpxM0NkTVlVRk90SnRteUFFSGVHTU56UWRXdFhTMHM4UENO?=
 =?utf-8?B?dnd4R1VsOS91QmgyQ3lIVGNsL1R5RG5tMlZUT1R0ZmdibGx3SEx2cXAyWGgx?=
 =?utf-8?B?c1J3QUxFOU0rVmxJZWhrNzBKY05IVnpPM0xmbHhDMURZUlBWa0hNVEt2dTRP?=
 =?utf-8?B?RWg4NnhxUzFYSSsyTjc4OXFTTlFRb1NFcyt2S2JnQnhVczVYTGpCTmZGOUY2?=
 =?utf-8?B?elhjZE1ac3JvaUljNnJ4dXcxb1RGcHhJMkttUGZJazZWa1d6MnpnMnA0M0NP?=
 =?utf-8?B?S0NaVStsRjhsemlIRkxXblAzWUFaUDNBYVBXdDVnVHZ3K2d1cy9VWEhvR0Qr?=
 =?utf-8?B?cFFBUEMyN0I3S1N6OXp4ZkdvVXkwMzJFVmV3Q0RxVEtmYVZXc0QvM1Q1QXNn?=
 =?utf-8?B?MTQ3MTB1cXY1U29KSjFIQkxucVd5QzRWRmpXb2M5dHBIcTN5Q3l0aVdQYXpL?=
 =?utf-8?B?bW94YmNVNE5FcnVvMmU0dUZKSk5IbGo1V0JXc2k1ckFrVjZNcy8rUmxybC9C?=
 =?utf-8?B?RWUxaXM0b1h0aWpQdzFPd0ZXKzZhN1lUSEVPSkFRVWZETlVnN1N3bHI5d1Rn?=
 =?utf-8?B?S2czV0xZTlpOdlI0QitRcjVjQy9PbGVNZkNxOXZWb1M3NnNRTk5BTXVRcVUy?=
 =?utf-8?B?eWVOU2dkRGYxL3FQTWtDMXhIekMyQldrRnIwU0hPVHdSVi9iRC94Y3IwQW43?=
 =?utf-8?B?ck9YYU9haWMzSmNnYllpSVpwUzlKQ3pQRHgyaWxpdE0zYUYzQnBCRk8yek9a?=
 =?utf-8?B?SGVEbGVUckRsNENLcVJNWWQ5WE9OcDVoeG5JQ0dLdTErdnd1UUY3Qkl1ZHg2?=
 =?utf-8?B?Qmtyekp3NE1XT2hBQ05SQ1VXZXhGbHpSdGZqektoaFh0RHFjKzZRR0w0VWRu?=
 =?utf-8?B?RmNjY2hONjJOOStlNk9BNW56aEdoR1NuYWxaY3pTMXQxZFBkbmVvaC9GTFQz?=
 =?utf-8?B?THVIazhKRUczOVNnZmNURDlycU9DMGsyT04rSEFQUFo1b2JNZ0ZsOHZiVlFx?=
 =?utf-8?B?dEh5by9MU1I5SVlYMHFzUFlGZjl4dHJaSG9NK3cwV1lyS2FSZkQxK241dWJi?=
 =?utf-8?B?TVpLOURoc0dmUloyYUVvQ2JWZFdLaE1jUTgyWEtOSFZMNmpmcXY2WU9hVlJl?=
 =?utf-8?B?TXc1bzUzWEIrQ3RXU0Rwci9DSzFycHkzQlpSZ3A2Sjc5a204anhzOWdZcC9R?=
 =?utf-8?B?eDVRMWxKaWlScUNtOXFubXgvTTNqOXNvS2ROZEJ4VXIzUjA2V0s0U01Wbjh6?=
 =?utf-8?Q?dbz4=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 06:24:13.2691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e8ce6d-a709-4b1f-3b1e-08de1f5899f1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8466

Hi Hrushikesh Salunke,

On Fri, 17 Oct 2025 14:16:51 +0530, Hrushikesh Salunke wrote:
> J784S4 SoC uses its PCIe1 instance as part of the PCIe boot process. This
> series adds the necessary "bootph-all" boot phase tags to all the device tree
> nodes that need to be functional at all stages of the PCIe boot process.
> 
> This series is based on commit
> 13863a59e410 (tag: next-20251014) Add linux-next specific files for 20251014
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/3] arm64: dts: ti: k3-j784s4-evm-pcie0-pcie1-ep: Add boot phase tag to "pcie1_ep"
      commit: 1f03b9e71e49a2f903c914f12ca5068995d916d7
[2/3] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to SERDES0
      commit: cadd9234aedc9d4c5b4342f96a1ebe02314adeb2
[3/3] arm64: dts: ti: k3-j784s4-j742s2-evm-common: Add bootph-all tag to "pcie1_ctrl"
      commit: 56bf2702cab02d6781c6201fc407be356bb256fd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh


