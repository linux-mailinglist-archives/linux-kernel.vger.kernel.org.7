Return-Path: <linux-kernel+bounces-830302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BC6B995A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 293457A6AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50F2DC762;
	Wed, 24 Sep 2025 10:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="K8r+LRvt"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5889E2DC341;
	Wed, 24 Sep 2025 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708425; cv=fail; b=P380t1L9HDVlvw8DybKgH+iiewJ23hYE2VtMALRB8tal82h+tJBtRTbxpu1fvZAmD09uAzuh21Etg5SVmp7O77gbRdGLV0Q0k0lBinaPzKeIfmZG2H68QZYfu256IEUDRjC2yCxZhWwqZGiJICI7W0T3TL9m4GM/ciT46DloGxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708425; c=relaxed/simple;
	bh=EwfjTw9BQkUVvuRD/9vjP7oTp7nL48aPuZ4hK52woXI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fFY1JS3RsDkfz0D8LebN1UwnDaMANF73bosfo8PAdUvTkzWCfKB45CG/PlrbrO/LhJPw3j9dsHWiPrZ0bBYlN9S62c+WOuhGHSWe2RhMH1OUceCx9yGJHtnMahwv/RAxT38/lgcgWzxTQYjyIoqDX6/HD3RX4mRKCnsov/7gmns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=K8r+LRvt; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OB22OPuW9M+Tsdh7H9aFq0oriehCTs7CehgjVBWHhzWrFmxm3X8jFvKdbVkg1qwDVuVXLZAruXyAgzLai23ovcWEAi+Dy26XIC/JykUfspFoYp7ar+p4Z8Q2Jyfz4uOE157ULGQwkhXrK3JWK7hK8kARx41g+F/aIqiLJTOsgB5hZeDEDWc00k1TM1pMlbTXryyXeZ+bTrNzt/F8MW2vGPjwMyf5UvvryxXMYDfd5iyrazneyTdCn0lcUH1hQd0Lc9UeYzOm8ThlprXCRQF9ryazxgxaN1jzYn9m1EYynQlqp2huOQy7jNrJtoiwqYYaFeWeBpUhBMA0hFG0jkZJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXirQPNxtmw70k52SE4ooNNRsuTYUsZdlp3tgDJGhwo=;
 b=To+gJEXrw8Te+GWr8acH/IRg59GUEuj44AfCHweY6VsU7DWidQmwkXK7GSTwiprBHzlyFTnDRSl/te59dG3o6gx14WMlvLEWssgtLR11aBxXke+hYWJckflEzlZe3c0sIh+Hs3ntI7gogAjGk/lrqKDu8orcH8gY6Pj0WzyFQpsbqLeKLC3YY0a+g8+yWc4bqCwggvJ/FDhzDaBtISmTYF8b4P/Rwm+sK1xmm4lqsVUC3HDpIA+tN/AdrqJylSBYRvo/7snKVPXF4s5BDYaUN0WGZrw3nyqtcURf3I8R9VJ5TjoXdBaxIPM82qCAaQstjE2VpKqalTeOHr5ufhntGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXirQPNxtmw70k52SE4ooNNRsuTYUsZdlp3tgDJGhwo=;
 b=K8r+LRvtuQPWbGMVzCXdgVF5++Bg+fitpP2EegbztyQH1d3bXjJDzlVyLei7VMoZ8rdG3Uz6V1C8ga/eTvOmewcSoh8aEHoCQycAKbm6kf5ZYR0Oyf7K6USdNDr/Y01q8xRalT5dCk6NFVoyJuUic6lGC+NjixcEmlWtYOvn/DlrzFV5P5N3XCfn3suGLfNRdaFz3D3ybKXhidCRS6sZRPUDWPtT/4yVIDTB7KdZ8JuA4AFZPw2ZDR9/+rBM3dY+ou7Kv0i/TS4zbptPc3QAuDby7AGnHPGgWzecO0TD+5bW4w5vcEA5icIT/PSVsJIAsQ2tl+aqZ+FZoZY93a4KdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DUZPR04MB9745.eurprd04.prod.outlook.com (2603:10a6:10:4e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 10:06:53 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 10:06:53 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Wed, 24 Sep 2025 18:06:23 +0800
Subject: [PATCH v1 1/3] dt-bindings: nvmem: imx-ocotp: Add binding for
 i.MX94
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-imx943-v1-1-0d32d7852ecb@oss.nxp.com>
References: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
In-Reply-To: <20250924-imx943-v1-0-0d32d7852ecb@oss.nxp.com>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DUZPR04MB9745:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a477351-e508-4445-063f-08ddfb52162a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dUl4Zk93OGp3cEdic1NUeHdSSjh4M1pGa3pUZkFGMXVNb2tuanF5QktnV0w4?=
 =?utf-8?B?K1BlUGUvZ2o3c3Fja1FXUkJxa25lOFFTVnBuRk1JMThPNmpJMG1Ydms4bzNv?=
 =?utf-8?B?OHFiTVV5dDBXYlp5NDI0UDRuU0hnZGtkQXA5dlVOR1R3K2Vlc1dSZExXQ3Yw?=
 =?utf-8?B?eHFhVi96a0Q4TGpmTENaSTh0Z3pzQW02Rnk3Um1hOENSYzlLSVUwWGt2U3ZB?=
 =?utf-8?B?UlIvL3hhaDJNam1jY3NaenVDdXR3U21SYzJvaXE4dzdtMzloRVBKT1hkUVd3?=
 =?utf-8?B?K2dxSGgyOUd0bWtoTkVJaVlraTJiaWNvOFk1d2ppZ0MralhqbzFkK2kzSVdV?=
 =?utf-8?B?bW5ET1ZnVUZmN3JUaUlnazcwKzFLcFo1YzhNT0hWQUFmV2VDUFdIS3VpRjJ6?=
 =?utf-8?B?alZwZGpZTWNCOG1TUnYyWVBNRlZnZ25DZFZqNGo0eU5xNzVWdlp6Q3liL2lj?=
 =?utf-8?B?K0ZVc2lPeG12K3BhMTU4aVVLMGNjMi90YkJaVXpEbDNnVldHd2FSOTFsM05w?=
 =?utf-8?B?S2tsU0UyRlBMSm04SVN2NzYwODYvQi9TbnZrTUpNVC9pQ1k5RERycVFWdVdB?=
 =?utf-8?B?aE00RzNPT3NwOEVBR1VtYWw1NWtLQzFSQ0tuandnTWlINm4vZDFXc1ZZRU1h?=
 =?utf-8?B?K1hIS0VMMGNtUGVOUjBMYUFiRjdmMnpibG1zSEhIMk5zcGNpLytaRnd6MG5T?=
 =?utf-8?B?SnBOV3Ztb0tzQWlFR25jZjRUbFlGU1dqejNlUDJSV1p1cFhVMllhblBYZmNm?=
 =?utf-8?B?cFF1UzhKT0t1N05qekFjMEtMWWRDbWRjNlJiWVNPNUVkOXRITDZ4Sit4U2ZJ?=
 =?utf-8?B?WURSU1UzY05IVzhpZ2V6Ri9pVkFTVzJ0OUkwdTM4MVdyZlJwUzQvYy9VMnFI?=
 =?utf-8?B?Y0lSb1BKOEN2ZGtCSlJ6MlgwRGhTeW1xdlJwNmNqbVRRU2dHREUwdEtTMGZu?=
 =?utf-8?B?VUxrSTI2M21VbVI2L1FtYmhuR1BTaTBzUHVHMThrOVZYZU9KOFBLQ05VU3Zh?=
 =?utf-8?B?OS83QjdVK1RBVEdpUU5uMS9BU0poZ09uTmdTUmozYXJYcGEvdUxES2hjTlRv?=
 =?utf-8?B?TnJBMjZtU1ZWK1hpdjBuS3R1NUVJRjNVZHZ1ZWdyUFhZMTZNUFQxQ1hBQU9h?=
 =?utf-8?B?VStDbTlIS3hPRGdoWUNnNk1LdkVxQ2pFdktsdzVMTGN1VUdBVmhoZEtZSDgx?=
 =?utf-8?B?UUJUTXFXYmRTNysyUEd2Nys2aGxyNnpGYUttOTVGaUZjSnRyK0Q2QU5xUU9X?=
 =?utf-8?B?NjNPL0Zwb1RJa1lnYmpQUG9mdXcxU0ZnaFZhcHhJQTFtcGVDLytsMWJqKzZy?=
 =?utf-8?B?dWhGTThQWVpQSndac2xZbmtXVkQwRVdyd055V0dKRDByWC9JcEpXdzdPWjM1?=
 =?utf-8?B?UVpGVFZsUXB5WEorQmRzdkg5eXQycTdkSmw2RXFpc2hHYXkxbnp2VndaTDBw?=
 =?utf-8?B?MTIzeGkwQ2FGaUFRakkycXZtM0RXU3BucWZ3elBnSkozTVRENG9GMUVncGZD?=
 =?utf-8?B?bCtVaEhYWWhtcGhlUURFdERXM1NvcjFlWnNVcFZGQWxlK1g5REVlRXZkWlNu?=
 =?utf-8?B?S0gvS3dTS3V0U3BBYThvbW5uUk1oZHU1YzIyQkhpSi9FU1pEME8vaDBwLzdm?=
 =?utf-8?B?aWMvcXBFeDY3aFpWSWNkdG05QWE4V1BhSyt5aGJaN1o1ZnJBVVdIeE0xcVA5?=
 =?utf-8?B?dGJ3ZzcvMnBnSmxVY3RkTFpsUlBGVHhORTdJekdRbCtlV1U4bjV5REVpRHQ2?=
 =?utf-8?B?ajA1aGRtQ1ZJNGRXVEd6Y0N0cVp4NzRxOENFMGRxQVZpYjAvRlp6MkgraWoy?=
 =?utf-8?B?MHZqb3VrOWNsV1M4SnpkZmxhSlJwYy9HNTNsN0R1TmVDUVoyaVdMd2xqSXRT?=
 =?utf-8?B?K01jeXpPbXFDMTFXZUhCYmR1c1A1NXBCQ21ydUlpMHZ6Mk5aTkFUOTA1RTYv?=
 =?utf-8?B?aUZqUDFvbGU1MERsbGNlQlR0eVQ2bFdIZFV6L0dDVWE0R1BuclVMVm5kaVRL?=
 =?utf-8?B?TjhtclFxcXVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?STVFSHBJd2FjcDN5aGg0dXY0OXRlUTFBeEthVmpicTVBakpBbGt3NUY5Z21H?=
 =?utf-8?B?UzlaaTIyMWRXRFljWEVjYWZIMTFBbUpBWUNFQldWN01uYlRUWlB6VjFDclU1?=
 =?utf-8?B?VjA4Q0NTcUg4QkNwODJ5dTBFcGN5RGl0b2xsMVUwdEtOZXIydjJST0VFem10?=
 =?utf-8?B?QnFFVlF2UHFqNGFwOUxKMjQ4ckFYQWM1enV1RUlzUnZaVjhUVTRTMUdVNDc2?=
 =?utf-8?B?UGQ3NThEb0N5Y0dDWFl3ZlhLTVBKV1dHK2hGK3VlTzVnY3g0THRHQkFnNHl1?=
 =?utf-8?B?dHZhUEJ0bStBYVIrSENEZW5OOXZuemI3WFNIU0x1am1vTWtydFBvcXFPN0dO?=
 =?utf-8?B?ZGh2d0xRcXZPd0QvYzM4TExYS0IxYkFINU9QTEVYMkRpRnVFeXZKbENzNGds?=
 =?utf-8?B?NTJyTXZCMXhQKzZIY1ZNVlE1UU1DRVVIbXJuVHI4cFl0a1lkaFhkOHl3OHNJ?=
 =?utf-8?B?MDQvbGM0d29xUlRJOTU1UTg4YVFIRTFOQm8reU9ySGtxNDFBWCtTME1BTWJW?=
 =?utf-8?B?TTJpVC9FQ0MwVzdFTk8wdmZpQU1KUU4rZ0x6Z2U3WkNTcGtnZzUxSTdWSGZh?=
 =?utf-8?B?cURxbXptcWYxS1VXVHNBWmMzVTRCNE5CenF0dmV6ck5MSVJlQ01GbjhzUkFy?=
 =?utf-8?B?VU9oWWV2MTZGSEYzb1YzQTZZRFhPMVI3ZGhMcjJLTy9DeE9sVi9SS0Jyc0xI?=
 =?utf-8?B?Mlg0eFJkVlQ1LzRrOVVGT210dWNXaHM1QWN4NjdIbUp1QjNmWjRmSTRScEtr?=
 =?utf-8?B?cnZ5cGR5UE51YVBYWkZPK1VML2tDcmVWZU5hTk9kYzNxdjU5Z2plY3ZVOVQ0?=
 =?utf-8?B?cGFYcXRDZWEwUWpMVWsycVVMM0R1dmh6VVEreURGV2JhRklpSkw2QzdlTTNk?=
 =?utf-8?B?ZDljbjhSNkx0Z2ZsQjdWWmlHVlNUaXZ0cXNUaUg0cVpyWlpna1VYeGZwamc3?=
 =?utf-8?B?L0FXelhhWmVDNjYzQlVDeW5COUEvb3I3b28rcHZxN0JuenRWSmZkQVJlR0N1?=
 =?utf-8?B?Tm5oRnVQdHVMRU9wSVpLOXpYUVVFYkdCM0dYMnZybzFGem1SMWh5amQ4TUJm?=
 =?utf-8?B?bXpKNlZuQk1iNHpHVTV6RHhUMG1GVnRaOTlIcGVpd2tzdjR2TlAxZnFaeEdo?=
 =?utf-8?B?Vzh6L1YvcEJ3cmZFeWRJQnZRVUdMT01CbHU1VEdXcUU4bG1zcC82Z1ZQYkJq?=
 =?utf-8?B?b1d0SlkyWlUzM1R5Q1A0L0orZjFaa2VteEE0Y0QzSHhlZ2VFZnVIeTMxdFZp?=
 =?utf-8?B?NmJuTXIvMnB0SHJJcGpoUG1VdHJSME1CSWNXRUVpcUhoYndXNm9hQm4yVWQ5?=
 =?utf-8?B?TXpKL3dRdTJ0NVVZQ3NPdC9FQTB6QjlmdGwvNEpnZGwwZy81cHpvUVVZejlx?=
 =?utf-8?B?M0NEKzVBMk94WEU2YW4zQUdoWHRqNDRqNTBEU2RjUTdOeTROTWlOYjVWNmta?=
 =?utf-8?B?UG1TWVlQb0w0UW1pdlFzc1dkcGFpZWs1Z3BiclFkR1pjVVF4cERUYkFBbzc5?=
 =?utf-8?B?UDJhT2trbUVvNTVlMHVucGJ3YkYxb0lvK1NSaGk3MjVzbi9NUUQxYWV2NzJn?=
 =?utf-8?B?eVBYdXdudlBwOWNVcFRLZldIcEpZaG1aRWZFT0l6dkxkWDBDcEZ4WUxGN2ZR?=
 =?utf-8?B?QVVLSWdZWW9lOURBZnVLSitEaW42aDBHSTF4VFVpdy9yamVzcHVGSktXa1Vt?=
 =?utf-8?B?Tm5lUjNqdmlpeEkrOTB6OXIzVUhaYWdBN1RyMUJNOGxBZVh3bzQvamptZ2dX?=
 =?utf-8?B?ejR3MWQrbnZpRDQvMitmUml4ODd6bVBVMW5La1Q2Qk1Qb1pYR2srWC9ESStC?=
 =?utf-8?B?UVZGa2EyQU5jNXd0RnUzS2hYajJsUnN2ZnRQZFFOYVNUY3Vxcm5ZcU5MeFgx?=
 =?utf-8?B?clBua0o5Nk0rL3crV2tmdlFBWWtiZ2c3VXc1YW9Ld3kvK25lbFJxektiTFht?=
 =?utf-8?B?d2xObVd5UjhRQ2NKc0cyQVh2NTJtdnRQL3JrZmlid1J2Y0NsK20rT2QzOTA5?=
 =?utf-8?B?NmNmUFlQcGdOSXJ1VFppS2VISGQxNEtiajJFNjFFekhPQkgyUTYyWTk2dXlI?=
 =?utf-8?B?dGhNbVg3WWZBTVE5N2pvTGp0dGVTNkhwUXVGeEdHQmRKb05uOUtybHVianYw?=
 =?utf-8?Q?MKqxLv6NO/I4QDuJvnFTptIu3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a477351-e508-4445-063f-08ddfb52162a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 10:06:53.6242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: htuFk7xROGnrtKL9NkF/FlE/yFjqaLE38cxcBV42Jpud7QcWgw/1Odyznzlg15QUPf5lWIwNUVDyXRdXql0pUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9745

From: Alice Guo <alice.guo@nxp.com>

Update the imx-ocotp device tree binding documentation to include
support for the i.MX94 SoC.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
index b2cb76cf9053..a8076d0e2737 100644
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -14,7 +14,8 @@ maintainers:
 description: |
   This binding represents the on-chip eFuse OTP controller found on
   i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP and i.MX93/5 SoCs.
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN i.MX8MP, i.MX93, i.MX94,
+  and i.MX95.
 
 allOf:
   - $ref: nvmem.yaml#
@@ -36,6 +37,7 @@ properties:
               - fsl,imx8mq-ocotp
               - fsl,imx8mm-ocotp
               - fsl,imx93-ocotp
+              - fsl,imx94-ocotp
               - fsl,imx95-ocotp
           - const: syscon
       - items:

-- 
2.43.0


