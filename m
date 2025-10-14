Return-Path: <linux-kernel+bounces-853270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5952CBDB144
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 113D34E286D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EE52D0C7D;
	Tue, 14 Oct 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aDzoVMgi"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3662C375A;
	Tue, 14 Oct 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470727; cv=fail; b=PeaJPVZwU2bgsle17fvqpx0a9hRK4/oAajTsVK7KChzbYeM4CnZ4dcke4ezy943PEnWQNp0BxaeM3xSqGUHNVA9M/NcvUyqH29OjE6AaFb4tW4+4RhA/DFmMFEU/pZaRz4FUADtk91Pk2P2KF1SdxdRXQRNAqu7Rdm55EiNUJ+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470727; c=relaxed/simple;
	bh=6zKvlObYtgAHIQD5tdGU3YTllxeHb1+jB3bxqk0s9rg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=lnCMZcwm1nIe+1eIzq2YBugnuGIEohcXeoWynL7tRUFUt3k5gAr3ytOhfAPkf1Iss+rv9Xygz5pKy3XkqiFEwQpS4e9rOubvYZliDtFa+BxBbYXZmdhIff1JmOq7kankdRxOTbPbKBYqcK+ptWs7trwnLMVt9aDacips02SAgFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aDzoVMgi; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUfzYRVLwHUcMnjhv/WbW0yZvqAM7p+LlGuEXW2pc2mPgSOK5rbKEt1xpzZXUfOxejFwdhPnBYh1pWUdudcwCUqtOw8clWqn8RBJIVzTdnUyZ9kTBb6CELVaAuWkkPBYOAfe5mbK9ETBd61h/z8mgT+/Q0ONK4VURkSOnzaqvaIZH5rOs5/iRsMwsS3K/05ewR4aALOso/iJl3oKdfE6J6yNVkTYBr5oTTrGSKyfe8f4Xrx8xTwgLxAlJK5BC8G1BybuwDVlBSr9joocDV9VMLAuw3N2S5ALRWmdy0Pv1e9BSuc/LIctsH4s0Gqwd68TzVHp48nT8TUVNZ4tw9U1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gc2O1j6JZogocm3hU3WhaMR84dR3YLvfREq2H1Xo3Ks=;
 b=T6n7G8UIRLWMwRcEP0FcpMca+KYBiyp1GVhSk1KYRH/FR+BiuQlb1OfyCCKchDovgDJboOtg//80imGjyVF42MTByNP2jL1714oPfM4Xu+wiQYi5B8n49tMkODEs+dPmPg8oaQDZv2FEYObU36G/ZQa5RlotxQlLUsu+k/TDQMidWGXS3dFivj3kuhtYpUGQk2X4dhmynr4JbtBVivuk7Jycx6ru0PMzbEVquj2yjq9rUOgx1dvit314Uk/K0MIm4//Y7YhvPQ2nzaLGzzM8rBSarU4ycWTcLMapj3GzP9NPPBUz+8hppWbHxzb4MxIgkJ5Q+OuV60cnpJDb7b6Gcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gc2O1j6JZogocm3hU3WhaMR84dR3YLvfREq2H1Xo3Ks=;
 b=aDzoVMgiXn4Zs8J7z9mHSk7pusLsBm7wrqcyyz7cAPVog9pd1GPuiFFRFalsiEPL8IN44w5QkgaaGeM4SMrrJBhYKWraFPGbpQ4iVXU9hrUjLbnIgEZCetMFaVxjkM7u2hwWrFruttA7qA7svQ6gv7z2zRykA9l1/LMtwUkqNb9Ukod5/9czA33fXRVDxFNr0ahXxnxKvutK86IN8yRUgM8r8UinKIlqFegVseozzOYoEE86zB9zK0oHuNefHCkQYXoTjJ4Q07gC0GyXiiAHreZY021GZ1DHnONkw/R7XoMTjrPa5fU2jEg/grMambY/oVcwxNEOqdgczXVHRh072w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:38:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:38:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/8] ARM: dtb: imx6 DTB WARNING cleanup 2
Date: Tue, 14 Oct 2025 15:38:17 -0400
Message-Id: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKmm7mgC/x3MQQqAIBBA0avErBPUrKSrRIjlVANloRFBePek5
 Vv8/0LEQBihK14IeFOkw2eIsoBptX5BRi4bJJe14EIx2p/GuCuaaUPrjWR81hUf61Y7VJCzM+B
 Mz7/sh5Q+UiG9dWIAAAA=
X-Change-ID: 20251014-imx6_dts_clean_2-0f830b578de4
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=2429;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=6zKvlObYtgAHIQD5tdGU3YTllxeHb1+jB3bxqk0s9rg=;
 b=MZ9/aYeIluCyzPBdYtG2OFEWCZ6UX5sQFfbCxEFbHTjXDripF1Hlg8WhqVhQD6AZnFlOJm1Cv
 Se2JdhFQKHXCCnb1Dt3Zb1x/4mTVTGeEuPJH72dW57/TvbY63/dR4XX
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0065.namprd02.prod.outlook.com
 (2603:10b6:a03:54::42) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f77e95-a4bd-4410-52ae-08de0b59479a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWxDMVJ0UHRHTEVrazZURFdvUUVLcEl4V0ZZdm5qZEZSdnl2V2c2UUpoeGNP?=
 =?utf-8?B?blY3VnU1K1NHOE8yMnk3ZDV0VFpwaDV0OUJaMlJHaENXWHdqai9CSjdjNm5J?=
 =?utf-8?B?Nk9zOHVHSWZUcWpESnpDUm9lTnJmR2lmMkI1R2dhczBIOUxCTFlaUjB3L2l5?=
 =?utf-8?B?aHNYeTBwa05LZlUvZWZyaDF6eHZKVzE4QXFBZ3lIaUQ1ZjlLODRWSzZQc3Fw?=
 =?utf-8?B?cnVXSSt6WVEzZzhnYlpEMk45ZkdTVlVVb0sweVFIY0UrNWRycG1GY0xGUDYr?=
 =?utf-8?B?aDR2OEVKU1VYakluaFNtT1BJeEF3bk01TWVaelhXeG1rZWJNS1pQV3BaelJQ?=
 =?utf-8?B?ODZsNldRTENleDJrNlptQXp2aHpkejNmdEFKdGNPWXdudVhKeVhoQ1dNSEJQ?=
 =?utf-8?B?dFdJN2V1OFFnT1ROMFlRM0V1R3d6QThtR3BqOUMza3RCdHNvSktnamcybmZL?=
 =?utf-8?B?bjduNmFWZXpacHdaQ0k1R2VzV3Rvc25ESFhWZE9SRUtLc3JBRlJYUTJDc1BJ?=
 =?utf-8?B?eFVFblZpVmVXcXI0b3kyMm5XZURxcllXT0lpTi9uUUE4clk3OGVWV3lQdEg2?=
 =?utf-8?B?cEdjb2VtYVZHM29HaWt2YVozL05obkoyNGViTlpyZGdING5nREkvOWdsQWth?=
 =?utf-8?B?ZStURWVtQ29SRmlnaHhhMXNwY1BnNy94d01jUENBc3hGdURYOEoyUXg1Mnhw?=
 =?utf-8?B?YllJMEhGeEV3a3NCZVRaZXVvUFVrdUhHVk91UlpPMzNackxnaDY5OThudnd2?=
 =?utf-8?B?YStpQmRRRFdqbzdFSWNLSUJyQk1DK2pLRDQrUnUrVUtDVEwreHYyMjFFeFdE?=
 =?utf-8?B?R2hZUzcvUnlYMXhyYk82Z1pJbE92K0Q3czBrbGVsR0hDYXgrL0RQVU1RRyto?=
 =?utf-8?B?MUNoOENPMXF2QUxDZ0pSNmx3Ymw1VlBiWXZ4RWNQekhFZVNsY1FNSmp0UGJo?=
 =?utf-8?B?dUh3NWQyMWtPZUxiNXdiYjNlcENlTlVBWW85SlJyRkxjUGx2R3lqZlNCejJ4?=
 =?utf-8?B?dTdCeWJCZm9FNDk4RzRIakNHZWROenJUbG02aTJBZVBSWnBSMVFlcXBSVWtB?=
 =?utf-8?B?ZUw4SWRPNi94TjZMdm0wTEowT1l1MUtwa2JSNkhmYjhldXQ1bU5CRlRDODBH?=
 =?utf-8?B?M2dneDYyc1d3dG9LdmVCOTdOc2NhS0Q0R2ZkVzYrZElQZjlGZFh6RWxqUEZq?=
 =?utf-8?B?dDRZcXp3TEFFR3dtd0xRWk5zUm94SVhTd1UyNEdrRUxXSzRiVjUzSWQ1T2pi?=
 =?utf-8?B?RkZ2R1NNQU1BRm9SUURmb1dvWThrZVYybm1oMGlWSE1ZOVo5WkZTczc3Tzlx?=
 =?utf-8?B?aXVJT2lYL0FDcTl0OHJiMU1OYnFvMFRkNXVuSUxmUTNtRlY5ZGdPZmtqbE4r?=
 =?utf-8?B?U1BQNmZuaFBXMUpQOG9Lb2tlVVluUlFoVjlaM0c0bGQ4S2tyWlN6OFZ0NnZR?=
 =?utf-8?B?OG52b0F4K3lXdzdvcmtlK01SbGxQTTRQUVBCWENCYXlpTEhMeFFqUDhRUHFH?=
 =?utf-8?B?Q0tRaXozeVIzTm4rbWU3WG1ySnkwQW9uWGp3YTZuK24vOHFHaFpKcXdKTkFJ?=
 =?utf-8?B?dWg0M0RwbGlBcVB4MVBvd1BERWdvWFJGcjZRV1I2bHNVYnZpVkNtSkhhd2Ex?=
 =?utf-8?B?NW9scEI1azdKb2YwZmc3RkcrK1dvdExuWENVVVcwdlZBMXp5YzFaZ1BmSVly?=
 =?utf-8?B?RjRINWV5ZXMwU0tmbjVmblRZcG5oRHV6czVTZUhTbUxQbkg1UGxoREhibXkw?=
 =?utf-8?B?NEhhVjdZZGF2Nk94dkJHYlNsYTFrL3BOdEt6UklESWJIMENOQnY1TW9QeEp6?=
 =?utf-8?B?bndyUmhzVkQ0dlF6c0w2akszSVR4RTJ0TVdPdk1MTm94clRwM0FYZ3hkNUVB?=
 =?utf-8?B?a28rRUtYbFkwUzJHcnR2cmo1bUk4Z3NESjNBVHVUOTZkTDVwdHJaSndaRXpn?=
 =?utf-8?B?aHhraUZjOFlDTTYzK2ttc25uMVFKTXpYZm4yNS8yNExMS250aVBYSWRrZXZw?=
 =?utf-8?B?Y1BkdTE2cHcwQ0dNUXJZQlY2YWJpcmJFR1dsdnFKbmlVMXQ2WnUxeWlEVXVB?=
 =?utf-8?Q?rjEVQY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OExoZS9aaTJCV3VrdHl6MncvMlBiS3QvcllmeE1SM09XV3FYSzJueEp0VjNB?=
 =?utf-8?B?TVRMWENqbFFwWGM4UGlCSDA4QVNpYU9jL05iT0t6V3pVOHY1WlNqZDhjMUlI?=
 =?utf-8?B?NVRVNGd0dGtWQ0xBQ21EUUZQSjJCeFpnVzE3a2RzNkdtbklqOVE2Wm9CUlNW?=
 =?utf-8?B?Wm0ra0F3WDFZRkgzYXJ0anpIZnppK0Q0YThXa3lJWFFndHl6eERVNW5ybDJs?=
 =?utf-8?B?Mm1FKzdRK01odW1ackN1LzJNdnpyek9UYzV5U3Y4UldLSVp0OUFxc0dKVldM?=
 =?utf-8?B?Z0hDNVNLM1pLZ1QycG1GY3ZQR2pqLzcxZzJiK3dTOTlNTktONFdEcUxSUFlI?=
 =?utf-8?B?c1Nxa3NaclZLRGZ0Z1JvZERGSkZGK1NEemNTR2xBMDV2WGEyN2l0c1ZkeFc2?=
 =?utf-8?B?OXg1dzg1T09OWkhNWU5FQzd0VzhWalpVWlErVnRRc3lsSTN1NlpLMUs4aHN3?=
 =?utf-8?B?Y1J6RnVQM1lvMnFuTXlGd3dNSnRmVWptTWMwekVQalhIa2N6aHl4UnF5TFAr?=
 =?utf-8?B?MmVMeTNkR0h4REJGNVRBV3NGd0YzdnhlamFzaE5Na05yUGVqM3hUeEE5WEVM?=
 =?utf-8?B?YVB3SDJZOTN4NXMyMzZjRWxCV2xPbThZQlE0SkU4NVNkK0wySDB0MGNBc2xL?=
 =?utf-8?B?dWRWaHRweUxRYjVKUTZtakJiMXEyTEtud29UT2FwREFaTGNIVmFES2xiUkpV?=
 =?utf-8?B?SXJTWitOYUtnYXdkVjRwTjhGT0ErWDl6ZXBCYUtFRzZjb0t1dERSbUEwSVU5?=
 =?utf-8?B?K2FsaVV6YkV4aXBlVTVtdzloYTdjdFgwbEU3c2FYL2NIOW1lcE1NaDZNbEJY?=
 =?utf-8?B?bHlxSkZISXRTeGFzN1hZR2dLQkhDTjJtb0RUa1ZZUXh1VHA5NjNBYkpVVHFG?=
 =?utf-8?B?MGZYcVBFMUhBb2V1T0s5UzF3NXlYN1BtQXFWdWlDNTBERGhhdXkxUG00Qlh0?=
 =?utf-8?B?Z1ZkMEVaZVhQajZoajF3cm4wblRRWWc4Q1MwcUdUTEdsTkRCSk9hdEpGNEds?=
 =?utf-8?B?WVU3VkM1SFNGQXRxYzZpczg5ZWlSNzRxQXJsdnlZVXZtaDBYYVFINDJBNGwy?=
 =?utf-8?B?dGRnMjZ4bFpUSGEvRW5WdEYrVjRBU3U0enlXbWN2M1IwamIvVDFaTU1zakdY?=
 =?utf-8?B?ZEtNTW9keTFYZmp6ZVRkOVZmYmpHQXp6WkY2ckpNRnRaSVQ1V0ZUTVh2aTgv?=
 =?utf-8?B?QTIwSHNqaHlscFk5bEIvMFdTM2FIMmIxYjZ6WWFuU2IxdUVOai9pVHFsRXpn?=
 =?utf-8?B?MU05d0RYdW85TTh0SlRQSTJWN2dkMk9NMjRwUnhsRlFXT3czWGNmY04zUmc2?=
 =?utf-8?B?OXZuZTZjRVl4dTBWSkVTbzhSK1dNaytmWXdtOEhIbDdyZ0p0dFRDb1NpYkNl?=
 =?utf-8?B?WHlaUXVnUFdvUWlCQWlJbllnQko0VTNNaFArK1I4cysyeHpVald5Q1phMGFS?=
 =?utf-8?B?MXUrOWhIYmZzYW1CYjNHd1hzU2IwbXJ6TENRTVl3QjF4NVFlSVlUWWtIN0xH?=
 =?utf-8?B?UTZGemxNNVNFZWY1M2J5WW9Wc2RwN0JaZGwxOXNkS0Ezb3hSR2cvZVBjcGJ4?=
 =?utf-8?B?VmhrZFhURXNQQlRrc21yUXpTckZyeXFDL3M2MHlMa1EvTWpnVjk4SFBJeExW?=
 =?utf-8?B?NzRVYkMwZjVsZkRPSFUyOTg2ckY2bWZtL29tL3FMR0dnYWFwOWxvZlBiZVF0?=
 =?utf-8?B?SU9STmFjbGphc0RMKzJtcWN5YzRuMVZZQXE4SDhabHlta2dpc01EQVROc3Nt?=
 =?utf-8?B?ZG54N0FFQ0RGYWFKQ0NYVEdpMmNxaFdrY0pybXVPNEdIMTVLS0Y5RGpLRDRr?=
 =?utf-8?B?YXoyL2ZPT1ZZVFZjYnY3MXZzcGgzUGlyVndLZU9CY1g5QkIxR2xqOHl0Rng3?=
 =?utf-8?B?THRMSnJRLzM3UVhFeTQ0R2JDQ21zWHp0SGdNN3RLcTk5NXJZc2Q1Y3NzbjN0?=
 =?utf-8?B?MmtpRWNUSjZqZzcxbUlMNTNxZnZBR3ZFVnNNQ2FFZys3L2ZyZHY4UGFXbmpo?=
 =?utf-8?B?N3VNWUpHaGRxQ1N6dkFyUnVZbGxuZC8wRGwwMW9RKzE1RzUrSlZ3UkNjZDJs?=
 =?utf-8?B?TzlUYjMreEROYmhuNG5qdm5hWS9VcWdGdTg2RHpOdHZFc0tPUE1RRVNoUnJ4?=
 =?utf-8?Q?TccU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f77e95-a4bd-4410-52ae-08de0b59479a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:38:41.6621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1itYoK5Lu3OST6rraETM0NtjnQcwtCHAu/sPkIInc3KNVGK65qSp5FyrpM6uuEGGW+B3ppDw7p2fk/BPLl+L/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Some trivial changes to reduce DTB warnings. It is 2nd patch serise.

First one is at
https://lore.kernel.org/imx/20250904094649.GC13411@nxa18884-linux.ap.freescale.net/

This should be indepedent on previous one.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (8):
      ARM: dts: imx: add power-supply for lcd panel
      ARM: dts: imx: remove redundant linux,phandle
      ARM: dts: imx6qdl-skov-cpu fix typo interrupt
      ARM: dts: imx6q-cm-fx6.dts: add supplies for wm8731
      ARM: dts: Add bus type for parallel ov5640
      ARM: dts: add device_type for memory node
      ARM: dts: remove undocumented clock-names for ov5642
      ARM: dts: imx7ulp: remove bias-pull-up

 .../boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts    |  1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts        |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi         |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts      |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts         | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts            |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts  |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts  |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts      |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts         |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi      |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi      |  2 --
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi   |  1 +
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi    |  3 ++
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi   |  3 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi  |  2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi   |  5 +++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi     | 11 +++++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi     |  3 ++
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts      |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts          |  1 -
 24 files changed, 106 insertions(+), 8 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251014-imx6_dts_clean_2-0f830b578de4

Best regards,
--
Frank Li <Frank.Li@nxp.com>


