Return-Path: <linux-kernel+bounces-880383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E10C25A3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C88C421641
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B898534C98E;
	Fri, 31 Oct 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NCfETboK"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F4734D4F3;
	Fri, 31 Oct 2025 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921788; cv=fail; b=fIRwGLEHevezh/nDdOs/26HQ9UwM1sKzRFpm5WuxZHFILqCc84th1+oD5p53lXBpc77fLstfEGCQTy00MuPfzB6oX5m0QVEY7Yld01wsXqAKnXrWj8xDsH7G1YF9WQWABrpdnZm4ILq4eL+289pE5H5W44WVyjKQbxi9XnrlEwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921788; c=relaxed/simple;
	bh=4yk383a0wqC7Pt2gtcdcQkAKODSBzvUPgquX26P2Sn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IQ1gUCo8bE6WWb5RDEuV2iEzOBWvgCxvMEtoFgGmVw/454R7DY+XFvdGO2IW8FuXQ00U69RGsNF5z+kCI98NYV09VsczUvbibM98ypTPtAppoTsWIqJOJAvNcgpmhT1QxpbbmleLpwnOu4PDfE9X/Ip/jor6QUOlkaEccLcGUUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NCfETboK; arc=fail smtp.client-ip=52.101.85.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RFEykrv3F4e4MbMQ9Zll1fwGcdZ6mPjX6KAA4UTbJ9WFhVSB7lU78IeeoS4/CzNCsmJfum71OTGbLnGCX1twMMd8Qv/yABIpWDr0wH5rZ6LfLz1AIbgGUPajDg/MnI7xAFVRlCeT4dbU9whJ6JIBDlrTFulQQppvd5wuz+1qeapv+0OWKFM0qLvzEfqFWCMsi8pZNY1DiWBsE+rs+cagl+SOTEDILsfQeh0ebwnJSyfSIisCEHBQZJdLKo0AaBqHLio7VoCce1MWO07As0wo9c2i6SmF9ZARWfVlH6DdvbZrBfMSMH7l81/6NI3rxor4PIsD+fYWwxhlToeEaQUeBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwXWIY1U6vqYlb46JL95/22UpN3h2C8HN96ComeREDA=;
 b=kCuGQPP1Jcg/1X9sTHQIC0rVTb/CtkuYdWzMIeRwXXl6qWulCxWuRh/6OrTxn8XrADz06tjPx0WvkDtVpmztPFFmF2W3CVNpwHXLCxnBbZkglAiLjK0dkZHcmaCKxT4zwy5k9jobraeIFmpE7CsgiSZKc0SkzBAi5BAONhzxZC+A3V73Jl2URZysrIXNeOGmvM+ohiPefRVY1qddKfIcHAlse7WAzTxh2vbO41Dx/nYoLm0hrHURffql997hay2JbSKVOcZ6E7pC+zMzly5eVtcgAo3wykLqw9EuNsml6RnU6aAAgRYPqXyBnJLcoAiEYPPhX+g6+r76xijeu1limA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwXWIY1U6vqYlb46JL95/22UpN3h2C8HN96ComeREDA=;
 b=NCfETboKelFuilc+Cd8/fvos3DGOl6OBrSR99UenUmXHCl8Stfjm8vFTHt1aShBKwB0H/Yb7tdAQY4y5PdGDDreiUZrJt2bQu5hEDijD+U8/fwQzHjdNUYxwSnljlizlB5d8T06ov6k897dZY2hLJUNIFK29pUOgUWmIMXlC3iY=
Received: from BN1PR14CA0004.namprd14.prod.outlook.com (2603:10b6:408:e3::9)
 by PH3PPF5FDE66ECB.namprd10.prod.outlook.com (2603:10b6:518:1::7a6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 14:43:04 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:e3:cafe::c7) by BN1PR14CA0004.outlook.office365.com
 (2603:10b6:408:e3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 14:43:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 14:43:02 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:52 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 09:42:52 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 31 Oct 2025 09:42:52 -0500
Received: from uda0132425.dhcp.ti.com (uda0132425.dhcp.ti.com [172.24.233.103])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59VEgf5X4024498;
	Fri, 31 Oct 2025 09:42:49 -0500
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Michael Walle <mwalle@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] rm64: dts: ti: k3-j722s-evm: explicitly use PLL1_HSDIV6 audio refclk
Date: Fri, 31 Oct 2025 20:10:55 +0530
Message-ID: <176192142804.427883.5509699051513732912.b4-ty@ti.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251017102228.530517-1-mwalle@kernel.org>
References: <20251017102228.530517-1-mwalle@kernel.org>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|PH3PPF5FDE66ECB:EE_
X-MS-Office365-Filtering-Correlation-Id: 818f59e1-179b-4919-6316-08de188bcb9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|34020700016|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U05XY3VYakJCTTFPdm5Rd1ZheXNXZGpnOVZpZVlXazlmQW1HZDlaL1Q0UjYr?=
 =?utf-8?B?bzNtd0FXUzZnOEIrTnF1TDY3Rm9uVG13OE00eXRiVkR3clJBNnFFMnNuUFpk?=
 =?utf-8?B?QUhncmxPUFRnWGorbkpIVnhPWEErSmVvVnUzd0pnRldpamlHMlc5WGZqZk5M?=
 =?utf-8?B?MXlwaFZSQkhmL2xMT3ZTWllucWg1aWtwUXZRTS9KMGFXai93LzljdlgraG4v?=
 =?utf-8?B?ZFpxTU93R3F6TnV6dnlxbFJmOWZhLzZHWEh2d1d5cjRIa3g0dksvS1pnQTYv?=
 =?utf-8?B?VEhhVTNFN2VoUzFWV2E0d2wzcnJDbCtJenA2bWZXc21OUzE3V2VjWU8zQ3Ju?=
 =?utf-8?B?OGJURU9vR1RvanNqeVpkZkExdW1sRUl6emZuQ3I0Z2lmZkhBQytoSitUVzhJ?=
 =?utf-8?B?Rno4bkZnMTFtbThCdWg4Z1pQVllrN3RSOUtxSGJyMEY5SnVuaDZBZWZTdnk0?=
 =?utf-8?B?QjBjZGdlYlZ4OTEvWUZ3Q3hHU2dEYVlRVkZzN3hVQTg3REV0Ykc2eUdObVRj?=
 =?utf-8?B?OEt6SWVid09obVhiMHR4N3dOdEVDazhVeFdnUkJISS9ZcmZ2emc3MGlXcExZ?=
 =?utf-8?B?NmRjQ3U1TGtGbXBOVjZzLzRNWjJwOUlxRXptY0tOSUF5M2ZiMWYyR2hHQnI0?=
 =?utf-8?B?MHBiQlpwSTgxd0F5S0pMNFF6YzNmSGFhN3BwUlRFNjVMd1BqZE1ub2gzclJQ?=
 =?utf-8?B?U1RoSCtLVTVXNXBIQjBMU0JNNlJTVUpIcVVta3BYOUt3U2NVTmxoMll6Z0R4?=
 =?utf-8?B?anZ5NjVLVnZObDdMeFlqZkNUcTN1L3RDUi9WSFpsc1JEcGk1MkdzY3Zhbmg3?=
 =?utf-8?B?RUtMWitCYlJIcjhnampnM1pvUVZhUXYzdjZvWTA0L2NCSjBqM3VCdFgydU4v?=
 =?utf-8?B?SVoxaHFOOUxoSlkvNC9tWjFPdFRaWUh1eFpzRTFUSFdCRWkzZnlKVTR4Z25z?=
 =?utf-8?B?TVFhZ2N3Q2x3Nk9ubE1DNE80SDB4UDlYU3NKZjltL3FpTC9MdTY0VHBWNGIr?=
 =?utf-8?B?NWxHZkhoNTd5OGxyY0VLRGdYeE9XTmo2SE9samxURzZLNjlKcUI1cDhSZVlk?=
 =?utf-8?B?ZXZmaXdXb3FpOStEUGl0OWVzSlV6MzFWZW1WOUx3dlYyR3VuSDNQUlpVb25F?=
 =?utf-8?B?RjR5WEpUVVlVSk9ZU3N0TzhEVUVjQjZMbytrMXdwUFpZQk1NMFNWL1ZLUW1v?=
 =?utf-8?B?SElDQ1NRU1RXTVBySEZUWVFFRnhDNk43TTNrWmhXbGp0M3ZaRXZDNkYzNDBx?=
 =?utf-8?B?Z3dFMTdOc2tSTWNWcHpFeWd1dkpCL3E2cFAwa2hxVDkzK2JYYnNYNmxoM1pV?=
 =?utf-8?B?Q2VsMm9GWm1hOCtmRGMwRHNrNzB2cW11S3RNNWhKOFZQSDhrZUtFMzgrSytv?=
 =?utf-8?B?UVVtOTZ1Q2c3OUh6OWxHLzFJV05oSytIeDY0UGRiZkQ3aGpLb3FiS2xVVFpZ?=
 =?utf-8?B?WWZNdGhWRURVaTdmVXRaelNabWIxeFAycU1OM3dkOEJOQjdBRFVLais4NExv?=
 =?utf-8?B?MEFCM2d4cTNOZWd1d1FWSXMzaTZHU1ZHelFhYWU2NkhYSFVYcUJLdUozenpS?=
 =?utf-8?B?amV1OGVFNEtGMEpRSExtN0hSbm14SER0SmwyNUIzTk8yK0hlTEVnbkxDV1Ni?=
 =?utf-8?B?VXRKN3R0b2VVMTIzNmJ0WGZ5R0pzQjN2eW1jaDJ4MFlhVUY3aFlTOU11MU50?=
 =?utf-8?B?UVBNWFlTQ3E1UkErRHNOMXhsclhRdXFadTFXdHpPQ3hFMGRBbU1qUHJmTU9u?=
 =?utf-8?B?NGhqZDVOVm1XVGorVldIL0pRZE5qeFNsNUJLQ0NCV25PWmt4YUJac3N4UWNr?=
 =?utf-8?B?UXpDY3k0ci95QS9ja1JpbFlaK1d5anR1Q3dNOC91RGZab3ZjZUZzTDlrQzlZ?=
 =?utf-8?B?QzJteWtlbFpWQjExbjN3dzVWRkxqdUtrR1ZpcTRKVS9PY1ZFZ2JLbExTUGRu?=
 =?utf-8?B?NFhCdkJoay9QeUUrZDkwRVFwUHZ2M0pUZ2tJSTUzQXBHZUswdTFaOGl5dWhP?=
 =?utf-8?B?NUNUa0IvYTYvY1dWTW5wYzRMT21ibmZQSnZkUjFFU2h4cVE3SmVpZzJ1RUl6?=
 =?utf-8?B?S2Zmd1NJTWk4eUtRS0NrOG04NmZPOExZM0pOV2pzb2tOMEtQaUZWVmkvdDVx?=
 =?utf-8?Q?I61w=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(34020700016)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 14:43:02.8077
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f59e1-179b-4919-6316-08de188bcb9e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5FDE66ECB

Hi Michael Walle,

On Fri, 17 Oct 2025 12:22:21 +0200, Michael Walle wrote:
> The parent of the audio_refclk0/1 is about to change to a sane default
> value. Thus, move the (soon to be) non-default value into the board
> device tree.
> 
> 

I have applied the following to branch ti-next on [1].
Thank you!

[1/2] rm64: dts: ti: k3-j722s-evm: explicitly use PLL1_HSDIV6 audio refclk
      commit: b2f45bdc185f687fbbfef838eb49320ad07602b4
[2/2] arm64: dts: ti: k3-j722s-main: fix the audio refclk source
      commit: a3a74f9b15f020952a4c9e4eb3a0b44241827b73

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


