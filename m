Return-Path: <linux-kernel+bounces-860677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC388BF0ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 12:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13CC3E35DF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B6624BBEE;
	Mon, 20 Oct 2025 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Sv59Vb2j"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068C2254876;
	Mon, 20 Oct 2025 10:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760957510; cv=fail; b=dXX0dM4eePfZhAXpg5wmWh35C0v2rxfGBFxPiWlW/KNXBMxopEAtBPorlFb8MrzOJpjmOrRGgPXaF2vNG4sNKBbd8Sm67mB8B7UeTVU30DVRx3FqMeniRjkmBOI1dccivtn2WJ0Vch+WUFFIMX++2Qxwxlc9ZvdpmxSg7DPT4WA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760957510; c=relaxed/simple;
	bh=7fsRIJIoLb2EDijlOhya+RD2/+I2OyR64g9Y/8QWWE4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nzSkDo0zfP703EhlIqwWEK7AsbLIrPEyvhUGp0iRd7A/ObVJoLUvYAXF3kjx1zVoxUjdZTrbxz3dfglAU/ePIW5ey4JMM+BO2sEVgdrwSafP92Nr8Er43BtOXiUHcFf9W2D8iGge6/C7jDOp/l7IRAYYthRalQ4mhK12KlsTPVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Sv59Vb2j; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJBDMcOvdFbGQECzNh31Jey8Hd1GkhYr80xdwcRxMTeUlUTRGMMBdtHK4ARxRCz07HngP/ZuPrpNGmezBY+8GLz/XQGAF36d5lRiZPjVW5Nyz+lGNV4fzXBAK8UN26tyby1s/a/XLyy/xPpxYhQ2chTFUZZNsVKcA8hdQi8iqfloAS2sN1Uv3HvChXn3Kk/YSSePyAsMF9EUECY72TdWBP82y/hqY+p8fA6IGkCAAXT6TakuZqi6zrW3x3e32WsYy9eKWbb1cbsa2T8DtUh4+8WRxTPS8wFKuqXf/2xXuMJvBksbWEAjl1YyOnwyW+saOiXat0E76luGO1CZhUFnNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oSR5qV8QrfSDZYaJPJRgw73hIpdYvB50szQkT5k14YU=;
 b=waDte64RRg6ZIUNWjPLc6MjdY5bFFdoBBskezJ+zb1yceYV5BMaG6Wy+Sw0INVzUqBpg3KZkOyEEfkvjOcQ1RZraNxvzsnccn+LnRpMZsPcqAap/7cHnNtX5BjP5AihU0UBiapsrB9VS5DfRRgNEoqjnuhSMaQcWU05i6qoHkH80UWzgfp2c4tVwf82fP3eR50Er7w/et36Q4YyrMVkCaIPCoZGWPzpwcVVTP81HGsk83CyQVmFdd5US4oH7wWa86XULveiJq+cWmsOKBu5YTuSYQz8XLCN7j09GfcHLJeORTHZHfDUguAvt72QAkP34U1ehqeLuRnIFPGW/hJgETw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oSR5qV8QrfSDZYaJPJRgw73hIpdYvB50szQkT5k14YU=;
 b=Sv59Vb2jo3tsGFBC+CpOWQ3aEoAXw13/hZ1xA8k7FoiUvXeOLZ4c97rqc3MjzYWSwCESHBgZw1s21eyz62C9ibPhTnPlVRyvD/QFPFHCtFLxl+Vz4HVGlb/Mzrej4aFRjyG5I/Bm2B+2K1izPAPr2cW+PGUMreto3gI9ZxZXz/N+j9zP+XIlSUJUQ32FoY+NS61nPzOton2chy2+KFaNe0XYmRdBP2JjKhroA6fwr+AK+JTiQiNNRwW383oChlHCuNq2MSCrWZCmu9+cb+6iwnnTvxTWpxk6Ne66e+9MzugU8HT5nmiEBR4uTu2vT029MSJEM0ZfULxyIVdQDfXcPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11683.eurprd04.prod.outlook.com (2603:10a6:150:2b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Mon, 20 Oct
 2025 10:51:38 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 10:51:38 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/3] Add i.MX94 OCOTP support
Date: Mon, 20 Oct 2025 18:50:41 +0800
Message-Id: <20251020-imx94-v1-0-0b4b58a57bf9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAEU9mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyMD3czcCksTXQuD5LTURIvERHPDJCWg2oKi1LTMCrA50UplRkqxtbU
 AXInNbVsAAAA=
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>, Conor Dooley <conor.dooley@microchip.com>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0020.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11683:EE_
X-MS-Office365-Filtering-Correlation-Id: 0af303f7-0fc3-4a52-2832-08de0fc6a52b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2tveXBYaTFncjQ2RVh2QWgwRmF1eXN5U1A2a3g5amlWVzFzQ3NPcUtjclht?=
 =?utf-8?B?c0pIUmwvUGRSaU1mL2R0aEptVlhDSkpTTzN1OEdJaGpOcHdqWUNUZVAwZXo4?=
 =?utf-8?B?b2xsSmo1U0FHanI0RWJLbmkvTElCNEZwQXIzZGE0M1FRMHpDMmg4YmtGWThw?=
 =?utf-8?B?QVFxR0tOb1R4Z1BkbWJ4Z1lkVTlrTUM0VnpYUVRFVjVERTg3dXNwbHI4N2Iv?=
 =?utf-8?B?eG1SbU8rYzdpWitZMTVGS0RxL2V4OTBJWWJ0OUJyY0JlTksxQlo0N0RqNWg1?=
 =?utf-8?B?SnlpUWZ3bGtpcWt5d1JhRmUyZEJzV0MzR1pGcFBkMXF1QWthWHBEQXcwL2RU?=
 =?utf-8?B?cmhDWTlUMWRJUjhzajQ3bDRlSHgwNWorUDlZZVc4VU5jWEh3T3BKTlVMakVO?=
 =?utf-8?B?ajAxTEtiU0Y1dkg0bTkvcjUxOUQzYzdZcEthRDI3c3kwbWg5RnA3L0l2bEZ2?=
 =?utf-8?B?MGF5NEJ5aCtSTzF5eHFVYWEveUFRbGpDREh4bHlscUlOc1h4SFZIZExNbnlX?=
 =?utf-8?B?cjdTdjJhSzJTc1Z2NVBXMXk1QmFrNjQxTjB4cU14eEVmTGdRZHQ0dG0wNkpa?=
 =?utf-8?B?ZjBucGNKS3A3VUxWWkVvUHFKTWc1eHVYME15ZHJFTk8vVC9lRExEaUV4UDZI?=
 =?utf-8?B?Z1o3bVpVL0xtbHFJM3Z2SEovN1NHS0ozV0NEQ0FvZ1NLbmtjL1JKa2ZPNlkx?=
 =?utf-8?B?T0hRUFlYN1JDSDZPVEtNRjRYR0JZaDJGQzhpbmJQZVBtK3hRcEw2c3d5K3gv?=
 =?utf-8?B?VzNkdUlVaUxJdFJsZHpjekFPSXZvSG1iT2d5NWxsZ0ZaZTF2WXhUTlp5K3hn?=
 =?utf-8?B?Vzc1dnpGSHpqYjJVOXE3aGo0VjBwN0dMTlhPRWE4NDlpN2VVZUQ2VmlDYi83?=
 =?utf-8?B?a2ZEUUVlV21WNjN5TnliK1RGbkVGUm92cTlYTDNGYmZDcmJrcm84d0t6bC9D?=
 =?utf-8?B?K2ZWbjZuSjc2b0YyTXhuOFpGV0ozWGJydXovdjhESzRoTFUzeVVSRWRNK202?=
 =?utf-8?B?VW50K2xNODliTEttRGdKVWZLbXBpTlVQNjdCUmR3SXBYYjVDcFI1QzdpajJJ?=
 =?utf-8?B?cTA2RlhRUitiaEQ0MlJtbHRRL2JScFpVUVVLVnVXb1lWdmhZdGthQ0s0bjFs?=
 =?utf-8?B?MTZ6bjU1c0xOTUtYenl0QjQ0ZXpDZ3J1bWxESkVmQXhFb2hCbWcxeURqQndX?=
 =?utf-8?B?emhXeDRSLzBJWC9NRlhFeWhVeXl2TmpRYUdTbUJRS3hYUURDVTEzQ3dISlJD?=
 =?utf-8?B?a2FUeTIxRjBJcGRWd29HMkoyc1BXTThQc0Q2S1lmV1VUMENEVlI3NVBEemVE?=
 =?utf-8?B?OWlQT090NXJ1bTNpZkZDbVg3UlY4OVRqNUxGSEd1QzFKSENhaEZuR0FObVlC?=
 =?utf-8?B?RVRHVzNvRUJnNjZBcHJBTXdvODNNYlZpUFB4K2ZFdWZzYTJaY28vcXBJdHdz?=
 =?utf-8?B?ZnlCWmh0NlhveGxpWVRYaUVTV3pOK2VFWTJMeFZvUkZGS3pwR295SVRNZmpt?=
 =?utf-8?B?Z2sxcDhObkhwNTlKUVEvSW1QWVZpQldqeXF0K2c4VVl0cVhuNHZyNHAyR0My?=
 =?utf-8?B?Z1ZhdnpwR0ZPVzhSU1lBZ3AvTkJlQkVRZDhxbXh3U1BCWlQ4TmdNTGFhbG1p?=
 =?utf-8?B?ZVlrdnBlSHppaFYxSWhoY1BiYkRzWExTdkVxWEpwbTlKN2xybE1VdDhCamZj?=
 =?utf-8?B?UjdBZFdZeDdPaEdpbVZNaXBTZkJQcmtJYnRLT1hYVkVpZHUrRkdsR1ZsTE5L?=
 =?utf-8?B?M0tSZFdhOTErUkdVT29NZGM4eE53a0tqeGg5YVZHWE92OEZHY20zTEVuQVFD?=
 =?utf-8?B?Mmp1U1FTeVlvc29GQ2pNcG1mbitvR0NpK2x4THBtVUVVaEdNemRPVjlyZVEx?=
 =?utf-8?B?Q2NuRjZpN0ZyeC8yUm5oK3NWeEFYNXNheG1taEhMdDh1V25OZHh1cHpmYVNX?=
 =?utf-8?B?MUxjZWJmSUlMaitFcnRQMlhwTFdDUExzQlpSazRwZ3VHQlVySStXSHRYWFow?=
 =?utf-8?B?ZENsS3dmNC9WQi9SL3BqeU5NUjY1Z3cvR0JjcE83ZVlrMU94MTVCaWNKSUJo?=
 =?utf-8?Q?r+pme5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlQwbEVHenE4eURneTR0aUlGOHNZdHl0MDIvMzFrbFdUS0xuYkYrTW5Ta3Rv?=
 =?utf-8?B?RGMyc2x3Y3E2Z09xVjJ3TnJPdU04OXRvT3VCclN2Qk93emhvUmZCR3FGSXpD?=
 =?utf-8?B?WVhPTUxwbUQxYzhPek5NMENua28waWxscFhpZm42N015MmFEbmU4S3NxdEM5?=
 =?utf-8?B?SDlHcGhpOHIyWEUrNkdZL3dTdEhIZTJpTGZzaHRZL2Y0QU1UcW5PQVdIemlx?=
 =?utf-8?B?SkExcFd3N0wrNWU0QlluYkFTeXNVVS9FYTd2Mmh3dXFsSEtSWllFWnVSNE5u?=
 =?utf-8?B?V0hvM3FJNXhPNjkxZDV4OUFnbEEwL0dTd2I4dG1CQzZETHhwK0cyUnVIYmF2?=
 =?utf-8?B?ZmhtM2dRZVNaTzVmSTR5d1dPRW9YOGhTcEg0LzEwbENDOWdYbGdNYkZ2Y2Vp?=
 =?utf-8?B?empCOVVUY3NsMitWRmZ2WTFLUURhZEJlTzBIYTRjWFNia3RCVEt3OG5vZjVs?=
 =?utf-8?B?OEJsQVpjL3F3b3YzL1Mrc3p4cU1MT0JadldDSm5Mc054ZFc4UEZiRVd6UGF5?=
 =?utf-8?B?eTdTaHlLVFBvMkwwRUNkNWtBSHd5NmcrZkJ6Y05xNTA0bXJQM2FETmxwRUI3?=
 =?utf-8?B?bnd1dWc3bUpXTkhPZ2dsWjlVVm5Ma3FqWnZYczJ1aEc0YWhsRTNXT3Z3cG8y?=
 =?utf-8?B?eG1EQU91bkZ3dWowZGRFYnlUanpaM0MxTVZtaHlQa1lhcXpnTEVNcVdDUjUw?=
 =?utf-8?B?dGpmbEMyUis3Vm85aXhydENJbDE1WEJrMWJMdXVoTzdQcFBzZDdNa3pNVkZq?=
 =?utf-8?B?SkhvOGdvTDAxV280WDFMV041YTN4M2RKN3o3aVJvNzMra24xbE4xUm5Wcld3?=
 =?utf-8?B?R2xuTW8rNUlUUUxhK0RwQjFwUkZCRzAzL09YT1FRTFlWR05wQlprTUJwVUlB?=
 =?utf-8?B?VS9lQWJ6TWI3K0ZPaC94NzUvaGx2ZTBXdnBpY3VVbGx3OVpxQWM2WmtMNkdE?=
 =?utf-8?B?eWpmU0NSMnZsNWdxWkZwYVMyMHJBQXYrWERTNGhMYXZtMmVLTlVHZ0dIWEZ0?=
 =?utf-8?B?N3htOUk5N2pZQWsrZ2xYL1hBaUgrZHp2RG9wSHdTNEtveXlHZ1lhbEdWMzVR?=
 =?utf-8?B?UzVuYW56R1NGODJEOFNreEovQm1LYWdTVFdmTUhuZXk1KzQ0enVnZTN5cGlR?=
 =?utf-8?B?TnRJTmxTZDY5UXhhUUgvejJBb1F1VVh3RFd6S2ZnaFJFN1p0ZlRUNFhJaE9n?=
 =?utf-8?B?MnpuZkdFWlg3ZWp3ZHcvd2UvQlJlY2JlOUhHTytLOTF0NTFlRnpPeWR1Yktq?=
 =?utf-8?B?YndzUFpvY3B0YnRuNkl6a0VDeUtCNGRyU2hEaENuNFR0RDZnTXQwV1I2Yzhr?=
 =?utf-8?B?dmNPNFpnWSszb1ExckJxWjQ4S0RYUFp1dTBPTWU0OHpuQ2NCVFEzdHFlc2Jl?=
 =?utf-8?B?SnpCbXhJa0ZNYUF6Vk9BWXhzak1kT2JzcmZoNXRodDY0d0c4NmhKcGJtRVdz?=
 =?utf-8?B?MlY0RHc1am04YUJxUE54MncyT2o0V1RZWndSdFRiLzRST05KaGFxSVVRaitK?=
 =?utf-8?B?NU9waURXbjRMMUVWRnYwN05Yc3hvL09LeUxxQlJSSGZvT3VpeGhEc2Rua0M1?=
 =?utf-8?B?K2VReTJTYlJCb2xpcmdEbDV2dnU5RmRkaHFkaW0yNkZ0NWpTK3FybWNLWjFt?=
 =?utf-8?B?aTJvRWdXTStoWm9mVDlkenpYTEFINlhMZFhIbEdDVnpBNzk0MzQxandJRXZ0?=
 =?utf-8?B?V0oySWM2ZHFCM3FaMS9EZ3RoZ0dXem9xWjVZbXN0cnR1eDVBNG5CeVV0dTE0?=
 =?utf-8?B?bmxaN3FRUkgzZ2xmeU9RK0dzaEEyK1BUR0ZkQ3pNbnp3SzJCMUxpVC9sTElD?=
 =?utf-8?B?b0QwUElwelVWNDN5aUtjbjNMa084Z0FaeGRxZ3N2UTdqeGhVVDBVNXJwbEtH?=
 =?utf-8?B?MEtWWWxHSE0yRzl6SXk2SVAwYUlmNHJ1TkxIZWlVK1dMVldub0NnUG9CZTVY?=
 =?utf-8?B?VGpUL0RLM2trZ20zMzNXaG45VXJsT3M5c3JKREd5eElKM21uYzR5cUl1SUJ3?=
 =?utf-8?B?VW95Z1Z5TzNTTHIrNUQweTRmZWJ1QUQvS0NndnlMOXJUZjRXaWp0Yzk5UGg3?=
 =?utf-8?B?NTdBUU9Ma25Kajk0UnhwWkc1czBCYmJYUWI0TGNRbmFIUjg5VzZkQ3Bxd1B0?=
 =?utf-8?Q?hfetDdgMfqaGW29WQh5dnhgcS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0af303f7-0fc3-4a52-2832-08de0fc6a52b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 10:51:38.5665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZN5Txyauxo53HaKlkPFjE0tLxZHTfdlr8YPdiI0LgZiqWrEp3IAjSDZmPI7TQBZzWxVDQnN+0jUYMVGEutiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11683

This patch series adds support for the OCOTP controller on the i.MX94
SoC. The OCOTP controller provides access to eFuse regions.

Tested on an i.MX943 EVK board with successful NVMEM read access via
sysfs.

Changes for v2:
 - improved commit messages for each patch
 - added Acked-by and Reviewed-by tags from reviewers
 - updated the efuse@47510000 node

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      dt-bindings: nvmem: imx-ocotp: Add support for i.MX94
      nvmem: imx-ocotp-ele: Add i.MX94 OCOTP support
      arm64: dts: imx94: Add OCOTP node

 .../devicetree/bindings/nvmem/imx-ocotp.yaml         |  4 +++-
 arch/arm64/boot/dts/freescale/imx94.dtsi             |  7 +++++++
 drivers/nvmem/imx-ocotp-ele.c                        | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251020-imx94-80cfea8aa71b

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>


