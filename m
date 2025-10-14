Return-Path: <linux-kernel+bounces-853275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFDEBDB16B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 21:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33B3E4EC529
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5852D372E;
	Tue, 14 Oct 2025 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jLfm8XuF"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F772D73B2;
	Tue, 14 Oct 2025 19:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760470747; cv=fail; b=X5CJ+3JBhwpOlSJAxy4ABRGHzHwO/ake8dY0p45qgJBAm78c+hPVU4GT9TRxqaW3hxtgYz+2S2PzSyjE/i1mWTnNzrNj54d8z/Z35h0bpEm0JQTdhuHSimDHMPALPZUsTbkXA/JiHY11SDPFsGWyjY2agyKfnoEgMv47FGO1/og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760470747; c=relaxed/simple;
	bh=ow5mGN688cVCXK745NZs7e6vJucjn8jDq3yyjehkDjY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=lFmjpc/+8TjQqe4384QdiOaxCMdKgefJC7nKz+uq9bBUAjBCLcWS6on/PGXsykGh+a86DS96hFdjgv3hlmFpdO9pn5uFxt59/GtEU3vSN1hRnhsrM1R7xDk8f31y24vJQ1RwMuWVT73Ebp2WH3t6rfL1uQLF6AtdNopuCXUZ5i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jLfm8XuF; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eD8zeUcY3A4t0dcnRkiZNXYyLASMQkjfE9HaBG96DhiEm9jVQvHpRkisjM8Z/k3qLAPItq8Y6kVgBvPTMAwTEbh5863gcaOoJXFw40tm2QOpjnthHClR8Rpk8OYHiIiKnbYY8y8aHKaRYDcaidQ8Rrg3u0cEuCZH5q28ntpbZACHFxS0asQaiVsKpdqTPY847PDykj16jZ3WJLA1STx6r6sMyGNMptR2ZaAdbFig3Z99ksmGZTuimvIuHu8nQ34pKQuqRc3jTVItOVggnq/LVDdKDnvwkHp5i4F8eC1PBoW7O9n1ceVC7uqMtgSNem+LObdVlOBpj+zTQTBr/GQVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9phlVN9Mi7K7p9lrebzJwaGeIazWWB6sCxvTPy57AnA=;
 b=l6ZjlzeiL3LxexXNZx7QD81WaXFs0+JisoHWGtSFRZsMa/kT8izre3HXBXBRXaHgQn1ht8WfmQcfocLjXDWyoduBKZ5UO8ZsSOZq93gDC54XSfPUhfIEsLmk61Edu5yVlTrr+pfaGPVlVIA4NS81Tq6w/9H5K2rF0K8q30GlCaNByfzoHTH4PCyAfvI7DJkgl47UvnpYwVSLlK+u5PaqQ0MYsmPEWU7XNFzT11YjcJaTQls6iPDaPdz6RutQuYWmvkkSnZHCWIH0TEqsNEngrY/18FXvlvz2CQ0Vr+EY+HWH3y/PtYc/03tw8ht3Xixm2Aa7kqGwWUDQBcWmQgAP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9phlVN9Mi7K7p9lrebzJwaGeIazWWB6sCxvTPy57AnA=;
 b=jLfm8XuF59YBy8Q8wYYMF12h51RhzlGK8agogdUOiA1SkeVOirewYSZbOzM3InwNmXtHeXW3013Zyqk2zGsespGrtC4coYSjh83M3Laa8YR0M2Cc2FuxIEc14zlBoa2rZOHxUlNFuGAqvSmMB1oMRJVmPFCJsjXGd3OrJ7CGCPysD7gKBUaNH3I7Cdhi4+z8hTmGqJnvkvY70sjSFKgCb141g7FZmxBJE6JxXS7b0asWWEktna49Rh3jzKU/c4CN/uMzmAY4ItECnYoJKaFCr9kgsDuPr7g7uHwzwtJ9BN19nIrxM5fi7uGOD+eBbmoz6CSU0bM04/NRRq653gSyJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 19:39:01 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 19:39:01 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 14 Oct 2025 15:38:22 -0400
Subject: [PATCH 5/8] ARM: dts: Add bus type for parallel ov5640
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx6_dts_clean_2-v1-5-508b36e5a3fd@nxp.com>
References: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
In-Reply-To: <20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760470717; l=2034;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=ow5mGN688cVCXK745NZs7e6vJucjn8jDq3yyjehkDjY=;
 b=ugcDlrvNltMEDF1KuTVR6fItrsy2xHacfFdSx9Xso8AheAKzRa+zyizAFcsdaMipmXr3ZcBL7
 FJYWmq+ouMaA+njlNhtvTuZSbng05K87wDn4+WouZgx5FbHVs4STz7+
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
X-MS-Office365-Filtering-Correlation-Id: 17aac30c-2748-4039-1b3d-08de0b59536a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|19092799006|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUpUZnBqck9kS29GSDZONGVaeEFlK1ZMZ0FqTjBNZWF2QzJxYkdDanQ4VTBw?=
 =?utf-8?B?czB1bU5VbmEyQVR6U0k0NDVvYWFrQVYrQklndXRSRkprOUIyZFhFWHFxdGEv?=
 =?utf-8?B?N1dYMVo1cjZDeGE3SlZOWUNQZUxUOGhORWxuYTU0VXh4ZDVqLzNKZHZSdWNX?=
 =?utf-8?B?TjJ3VkJmckZIcHdFZkRJbUtKZnMwMUloUlZJSjQzK3dBcGl5YUZ3VEdRME1K?=
 =?utf-8?B?RURXUEtVc2dPNDhPZnNlT0FpUzdiZUwraXhRUUJqU1pDNTNtcG8vUURSTnMr?=
 =?utf-8?B?OXdvSC9rRmtJSjZPYXJyU1BOTmdudXd1NXdocUduQ3NMcWVmU2ViUDgwM2w2?=
 =?utf-8?B?NWx3NmNWdEpjRm5ZL0liQXhnUzR2bzVPZHQ1U2xEckl2RUIyaUsrMCs5Ynds?=
 =?utf-8?B?MU84SUl2d3NsMXFCV1YxTXQxSlBUOXMwVkkycVpUMnJlUHlYaHdCOEFpanF6?=
 =?utf-8?B?RXZMMjBOeVlVK3c1TW1BK0ppMHV2aVBEeWx6NTgraXFRZ1U5REZydUhFRnBn?=
 =?utf-8?B?c3RldHQ3SGhqcHhzb3RJdXFPVkdjUHVWZFZRazlvc1RVS2lLTWR2d1ZKaXJO?=
 =?utf-8?B?RmszckxTdFFtVG5wOGx6alZjWUxOK1pFVTZqdDBvOGRlbUFJTk9OQlBMSHpj?=
 =?utf-8?B?N3EveEZDYmFVLzdrbjA4VDlUR0dLRk9yQi8vZnh0dWgxaytlNEh4NTYzcENu?=
 =?utf-8?B?Y2RNUGlLaHBBWjE1V3FoSGdXN0dGTktoQjJEU1hZTWc4disxci9JbTlvTlJZ?=
 =?utf-8?B?OExvNWxxTm5SUXlOaE9KNEtxNFJ2cmNZMVlNY3VBMDloY2JqTURvRTFkY3po?=
 =?utf-8?B?eEt5Q1ZKcnBhT0RxM0NuNDB3b29KdHBTR2VMK3dyNVFJbll6bFExcFEwR3N0?=
 =?utf-8?B?WWptY2V6ak9Bc2JHSUhTZmo3RkxCbXV5cTZzQmpqa0Z3SmxGeW5OQy93M0Zw?=
 =?utf-8?B?VS8zb1dHOE8rNis4OW1uRmRZSS9RSGRrY3owQ29obGZyeXNiTkJCbUlvNDk1?=
 =?utf-8?B?OGN3TjlRM29NVUlmVnNuSXJtYjdpblR4dUgyQldWVnYyMzJhRHRiM08yUy9T?=
 =?utf-8?B?RFNGTGhvbTA4RGV3dWJPc3FYMTdtbSsrREVDc2tmRGdPUnlWaEorRVhLOCtn?=
 =?utf-8?B?NGFlUm9zY1loNk1QZnY2MUo4MkxnSCtkMnBGaXZ2NEZiTHAxUVNvNkp4dWk3?=
 =?utf-8?B?TDJNbC9EUnpGaENoTFpNSjUyQndJdGV0RlZTdmwwVnBlSURRNXZuTU4wTWlu?=
 =?utf-8?B?R1FkRjc5Z2VTRy9DNWN4VW5mRHYrRTFhd1h4KytjOEpLd0xLT1RyWkZTdUlG?=
 =?utf-8?B?WWU1bGlTMy9HZG5DSWVQVU1mZE5qRVF4bXZ1TFh0R1R0SW9kUFAxMm96Ymlz?=
 =?utf-8?B?MXAzcHU1R3JtcmFyTzR5Wmd0L3YxZ3dzaTEyUXBPWXpYSUdtLzFGZjAzdWl3?=
 =?utf-8?B?YnpiTlVKeVZlZ0FWVVdhT0JpbkU5SzdINGpSMi9XdjFKMHRHSjlNTm9aUHdn?=
 =?utf-8?B?czVxalNMQ1E4Y1ludDJRZnRYbTFRbG11cFNwdzkxbmJzTWczcW8wVmhjWUlm?=
 =?utf-8?B?dFNMMHdqaThKckk4Q25sSGNtNVBrc0VldmxPK096QXUrYkFSdllkYXJVenRu?=
 =?utf-8?B?YTF6d3Bzc1lJZFcrVnZ5RkNWN2NQY010YkRUZW5pMlBxVktWR1hsVWVLSkNy?=
 =?utf-8?B?dmFGMEtidW11TVJhZkxSQjFMVXQ5UklFckNuTFhTVURIU244VjhrYXZiWjFL?=
 =?utf-8?B?M0VVS1RkMjAxc2VQaGc2bmtNdkhrMjNwZFZxYmJNTVhNdUU3dnc5NWpJc0l1?=
 =?utf-8?B?VS82L0JraWFjTjg5ckg5OG5sSldiZDRHeGZNWjhURC96QVNRaldUL0JpRVRz?=
 =?utf-8?B?VGRJMFdaNVlpRENlUmZSeXh5ZWFMVmw3ZmRjdE9WT3ZDWGp0MnJBYkQycmhW?=
 =?utf-8?B?c2U2Qkh6bTJHblMzZ0ZSVXZsZjJuMTFobDdCby94MGlmTUhMa0VVUzRaUWVP?=
 =?utf-8?B?Mm1UT2ZrREdpVHdDbG9Dbk9mVElZS2FlNGoreUVXUVNoUXV6NEF6Rm5rYTBW?=
 =?utf-8?Q?wwkdoM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(19092799006)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekpCSWhHVlpLbXBHOTV2UUtRQ2FFY3dmY2MrNmI2NTR5MHNrb20wNEdPemdt?=
 =?utf-8?B?ek50UU5HcjBoMmlhUnBWdTMxUFRUOHhyR3krMDRDOXp3ekJaUTZmampVOXcy?=
 =?utf-8?B?N1I3VkM4SkI2MjVLL2FpV3pnenZHTGg1azRvL2RnVm5xUngrVFhEaTJUb05H?=
 =?utf-8?B?TkJFTmNPZU9nWXNBb3FSeXRYM3dzUHFoY0U5aUp6MEdaTVJtbXo0VFdQbVFE?=
 =?utf-8?B?aEJFeFFaOGluaDVEbzBxTkpybUtJMjZ0N2RLeU5ndHNvcVpJZUx0TGFVM0ht?=
 =?utf-8?B?Rko2L09KcnhXSmdDSFJBYThPazU5Vzl3RVlycFROWHlLUXpEVGNkdWVEY3pZ?=
 =?utf-8?B?VERFM1R3WUVTTW11WHY1Zzh5VGs0Y1UycTN4UURtVENWQS81NnBXZEF2cjdG?=
 =?utf-8?B?MDVzYWpLblBPVi9uaWt4YlUzbGtISnVQc1hqMEVCNWlXbW1mUGpSR1V1UGZW?=
 =?utf-8?B?eW5xa0NFbEh6N2FJbHVMM0l6TW4yYi9vSkZlQ3Zaa2NxdERNdStWNU1xMHRT?=
 =?utf-8?B?TFljVmt1djh5VEFYZFl4S1ZCeHJVaGRiUno5UGREdmRGSnZad0VaQjdTaDdh?=
 =?utf-8?B?Wkx1UE1uL2NGenRrZjJOc1ljZkp0YmNaL2o2d041b1lKK2Y5dWZ1Q2NmSE1a?=
 =?utf-8?B?WDJhcWs1WWVZNXZST3ZaSkZ2dWltNWVrK3JmYVhLTlI1WlF3ZGZubnJFUjJn?=
 =?utf-8?B?Qk9CTW85c0ZVR2JpVnROVkNHTkJka0diN3VjU2JmL3pEUFMyR2orN3VOQmhn?=
 =?utf-8?B?eVZaVzJMbXR1WDRqQUk2QXRLNTdWcThGTWxqaTNyMEl5cS9wanRXNWM5d3JM?=
 =?utf-8?B?ZEZtcVMraHNUZEdsTTk2dnhVd1J5WGo4Q0h3b0lJYm12M3Rlbmg5K0ZycS83?=
 =?utf-8?B?VkE3MFZCSVVsNE1oMHFjN0R1d3lVVWMrY2pHcXYveTU0WmJ2c29pM0VWYUYw?=
 =?utf-8?B?M2VZcWc5NG5vT1BpL01oVG1McUxrb0s2Vlh5L2R3dFBSTlZkY0ZaQ1NKZHZN?=
 =?utf-8?B?VnRMUTlEMXZGdCtpc05XTlZid1U2NENIb0ZmR1lDMWpFUWpqOWY0QzFZTVlQ?=
 =?utf-8?B?ZVA0aGZ3NmtrcVc2RjdEd09sdGMyb2x2YmZEWFpxWFBiVGJDNkIwdmhBOXRi?=
 =?utf-8?B?RHhoUHZHaVVaQm1hUXpJeE5ZV055ejh0R3ZITnBQamMvVjBoTVVLNThldkYv?=
 =?utf-8?B?T3prS0NKZXV2bFludGdyVUE3UzFycUpIZkkzTHRXMk02TjQxTkFkVFU3MHoy?=
 =?utf-8?B?YXZxQXdHYnNXRFpXZ0F3ODhjM0duVW9XcVFDZW9aVStHSm4vNjZWK3Z6SlVK?=
 =?utf-8?B?MlVSbGVpR25keHdVWWViOC9QVjNCbDRFeGg2cUJkaGM1YWRsbWZXVllUZGRt?=
 =?utf-8?B?aERVV2VObHlNZFhmUmxsU2FIa04xNHJqS24yUVp5NTk5RFNOOWtLNGVIOWhC?=
 =?utf-8?B?K25JWEZWNnNVYXREVGF0NjdwQ1VYSSs4OHBCaVljd0VpL0ZNa09wbDlwOEk3?=
 =?utf-8?B?aEYxZTdBOEsyZWZsMGZ1Ull3YUNwN3pocTlPSUpvVWpWRGp2b0pjdDg4YlY1?=
 =?utf-8?B?YXBiZEZJMFBsM3FURkhPQi9sa2JjNVpqMS9NaWN5bVpZRDhwQ1RmSzg3aGQ5?=
 =?utf-8?B?aTZnb2ZpQUJTV3JSdTZOeTk5M2xYblVwUGRJSTN3UFZGQnQzZHhidUYwWWg5?=
 =?utf-8?B?cjAzNmZsVEtlWTljcFFxZE1mM2xoTFZDc0JOZFhDNmR5ZS9CSytneS9KTkU1?=
 =?utf-8?B?c0ZPUS94eHViTE1DeFJGbVBoOVVodVk1M0F5dEQwMllxeiswVGQvSWg3dSt0?=
 =?utf-8?B?Wi8rM3VreE1uWlFiY2xheXl6VGMyOWVIOERFLyt3NncvR0RiemJKOHlHSG1D?=
 =?utf-8?B?dXN0dWFyUkFub2tYbEpRMWVpaGpkNkg2NkFYMUQ2ZXJBVlVscFJIZG9zQXNv?=
 =?utf-8?B?RWU2KzhaYmdTK3hseUxvUzBWY3doQVpuTnN3WTZYZVhFa0JXQ041RFVWVXF5?=
 =?utf-8?B?cDBIZTI0dGVYaTBJN1dhNzhmT21vOE5sZU5GOFJJTEpZZHdjQ1V6MjlVMm1H?=
 =?utf-8?B?Z3FTSm9yZXJiWkp6ZnhtcHZhZXYrR3pnTUt2dGx1cnI3b29NeWI3djNQVERF?=
 =?utf-8?Q?PbUF2+BOcYS+4X/j5wuZRDXUG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17aac30c-2748-4039-1b3d-08de0b59536a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 19:39:01.4033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JGH91lxudhKb33Vnuq7Lsp/Csy7AURHY0/RnyZffe1pJH+HGx56Hx4XE9hjGCPoEDtJTVASBTRsAwyTS6sgZVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241

Add bus type for parallel ov5640 to fix below CHECK_DTBS warnings:
  arch/arm/boot/dts/nxp/imx/imx6q-sabrelite.dtb: camera@42 (ovti,ov5642): port:endpoint:hsync-active: False schema does not allow 1

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi | 2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
index 8323be1bfb769fda5c21ea9d4790786654e996a8..b2d9e528fcfec55d5467a11ae4308fc92c1d1d50 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi
@@ -8,6 +8,7 @@
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/media/video-interfaces.h>
 
 / {
 	chosen {
@@ -372,6 +373,7 @@ ov5642: camera@42 {
 		port {
 			ov5642_to_ipu1_csi0_mux: endpoint {
 				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
 				bus-width = <8>;
 				hsync-active = <1>;
 				vsync-active = <1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
index cc2a7b61a293a0d8919a74a0ea28ae83390dd68b..d1adbb11c51ae078094dbe475b85038c89d243ac 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/imx6qdl-clock.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/media/video-interfaces.h>
 
 / {
 	chosen {
@@ -299,6 +300,7 @@ rev B board is VGEN5 */
 		port {
 			ov5642_to_ipu1_csi0_mux: endpoint {
 				remote-endpoint = <&ipu1_csi0_mux_from_parallel_sensor>;
+				bus-type = <MEDIA_BUS_TYPE_PARALLEL>;
 				bus-width = <8>;
 				hsync-active = <1>;
 				vsync-active = <1>;

-- 
2.34.1


