Return-Path: <linux-kernel+bounces-892959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C26AC4635D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1F2188AC59
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDEC211A14;
	Mon, 10 Nov 2025 11:22:28 +0000 (UTC)
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022102.outbound.protection.outlook.com [52.101.126.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9502F5A18;
	Mon, 10 Nov 2025 11:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773748; cv=fail; b=PIAHc0VIUGHLqmmoMetHWVSHp0wX44DuBCLGSa9eAtHHuHS+IdzrUDzndhNnxmJQ7qR3Dvv1mTz/2P/siDvvX47QxExsqoNrU6KY+RRmucLekxarhlbRitYk67m36nf8U4t2wzP7f7zLDsjIspcbNgawRQoVcMhWbcE2v6lFoQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773748; c=relaxed/simple;
	bh=R9/L2XUlMZvG5Tb/lOySAhuXcpsRTDvdVJ4kpyIk/UU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VWhgTOLImrYDp4+JTktWiEzbZQcSooKefwNqaIxa7h1xjqsgEoehTQB8JMBXta2iC+EtwtoJTW9EclyYHBN0jgQxGXGcrksd6lnRWxeRdKr409V2cF/e0CCi+8DcV0gYl4RZpKlmayXVQQQvxfvVw5DYo7Dz+s7P3lrCLU6z0Qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AP9IrlvICqygQNQQXNhGxb4cwjRLttNT4OlXqh9GshI2xtuvitmitze2CbsCx+aRoqURxEW3BEbH03eBzQVLFoCwEked0L7gcIacQw+JWy+G6+UK+Q2CUXBRXm+Q0YhttEA13gr8Y+7dv035oy5Cs64oYOCV91keHnq6pU4KFVND2PWGwZuAnxTC0muqq2PU0uZd9AQ4KPVP8iXvcUuHoAOPvs4djEuuESCMzHWd/eQ2s2VPjdgQQTCYbfmWiFxEgEqNVkm+9gS6Hi0+vWZKIuD/af7P1MjDVVr92h/Fy9GNmeVeBUiJcPKoAVD/ijq6B+oC3rs/wWHDpjv/MxA2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R9/L2XUlMZvG5Tb/lOySAhuXcpsRTDvdVJ4kpyIk/UU=;
 b=Mrewg0/LIr0iwtXLCNHRPkBbWzDsDmeXU0OZBxwhIRyuw3KWuxiPWmGIcnZn9deAfHFxNeKkhBx+jaHF2cHCPesrhrKwXDt0Zf0u9/zNAmfqqY/Oy/ZSsKrEbpq5+jl11DUprN5LbKIo1LIobWlGx+/WUVWVlb1gKTf1QotbkMcEwePCwhYUy9BEYMJkZb4vVbsbW9yP3K102SNcWiiNsqnm61NK1pPChd/sEJQbqCGpoyRsXG2Yb/tNuHhrhbXrocXbNHXOedyUu4G0tbGzowFZMSlNBsEJsnz47UN6Z4wvlOfbCyURzOn0SKuUOmw+sQtuh5gBBJ1R7fOogsDX7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com (2603:1096:301:117::13)
 by TYZPR06MB6990.apcprd06.prod.outlook.com (2603:1096:405:3b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:22:23 +0000
Received: from PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d]) by PUZPR06MB5887.apcprd06.prod.outlook.com
 ([fe80::611c:7f38:af2e:22d%3]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:22:23 +0000
From: Gary Yang <gary.yang@cixtech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, cix-kernel-upstream
	<cix-kernel-upstream@cixtech.com>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggMy8zXSBkdHM6IHJlc2V0OiBhZGQgc3VwcG9ydCBm?=
 =?utf-8?Q?or_cix_sky1_resets?=
Thread-Topic: [PATCH 3/3] dts: reset: add support for cix sky1 resets
Thread-Index: AQHcT5f8ElvFGfSfgUagEQTw+Uqv2rTmzqKAgAT54tA=
Date: Mon, 10 Nov 2025 11:22:23 +0000
Message-ID:
 <PUZPR06MB5887E37550709E15C0C2F14FEFCEA@PUZPR06MB5887.apcprd06.prod.outlook.com>
References: <20251107033819.587712-1-gary.yang@cixtech.com>
 <20251107033819.587712-4-gary.yang@cixtech.com>
 <d7770d3e-bc35-4539-a927-0387cdec2b2c@kernel.org>
In-Reply-To: <d7770d3e-bc35-4539-a927-0387cdec2b2c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5887:EE_|TYZPR06MB6990:EE_
x-ms-office365-filtering-correlation-id: a6aba014-41da-4d5c-84ab-08de204b6b8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1h0ZGFFS21FbGZLUC9RQWFrb3ptdk9WVlZxanR0WGVlc1NrakwrcitZV2Rl?=
 =?utf-8?B?T2l1QzY2KzhEZ2hSemd5UldXYllGMzRnbW9VenpLZDM3aU8zYmoxQ0NxR1Na?=
 =?utf-8?B?Nko0QUo2NTV2clE3TVBTVDBMLzhQWkdtdkdpODVFWU5IbnFJL2NpWHExbGdJ?=
 =?utf-8?B?R1I3bWNObnd2dml0YWFPSmVVb0xpOUJlK1VHN3dXVFdESDQ3MjRpR2hQb0Vi?=
 =?utf-8?B?NmJFL2VZUU1RTU5oc1cxdVEwcXZDblROTnhCYjVqTmtxR1RSUGVsY2c3MFd0?=
 =?utf-8?B?WFRaTWxCQ2pJZk1FbFNQRWlha0x2ZUtVS2EwM1ZUekFGSHIwb0ozd0VKT3NW?=
 =?utf-8?B?cm9obVovMmtla25EWTVsUS9Dbm1hMmlNM1ZhQkh4d1pwNzJpNUc3dmk0STdJ?=
 =?utf-8?B?KzFkOUxuUEFnajFBUk1Fa3BxeDErN20rUHVHWFk0dWczVFQzekt1Z25GSlZ4?=
 =?utf-8?B?WXlQU1NHYnIzSzFBWmtXMkwyRitDSjdkMld6NisyUVNxNE5BNzVtREwvdzVX?=
 =?utf-8?B?S29ZZlNlYmVDd0VERmdPUkJhbHcyUElBLzdOeXFDamxUcTV1Z3IzSUw2THph?=
 =?utf-8?B?SlNqQWlwMzB5VUZKS2I0VVRadmRsYTBHaVZjNVg5aEsrSTQxa0J6bFdsMDAw?=
 =?utf-8?B?bWVTN3lmOE9md1JmTHF1WXBhclhQaFlzWXpaTTE5d2thNUJPQXJuZlZBVW90?=
 =?utf-8?B?alFNblVadFppcVdobDIvR1pvMVJ4azJSSGJucHZxNTJXQVAxaVB2cFlyQjMz?=
 =?utf-8?B?elNUeklLWERIdVlOMTRIcFFHeEtyNldmKy9VQkJmemlwT2pjdzVtenY5ZEdr?=
 =?utf-8?B?cW9JdmRHdWtRZUZ3ZllrQnVZd25XMEpwQkFpOS9JempJUkJsRHoxbzArd0lI?=
 =?utf-8?B?MmZqV2FyUUVOYlVES2ZsTEhobXczSzNQNnFSTzVHV3RibkQ0dTd6MStBQUd4?=
 =?utf-8?B?bXJvT1J2S0dHSGI5VitFMTU3OEFia1ZVeStLazFhaVFwRUxhNDR3NFArMEJZ?=
 =?utf-8?B?bG1YVkRwbFE3OVdnL3B2RzFrL0RPSGszbjBQNTBPT0k0R2xlNVlsYmFEL3Er?=
 =?utf-8?B?K2JpbUZFZmhiWUtVbjV5TjlmQS9UaGtIVVpmR3NsbXRRZ0haZjlyQ1M0NzY5?=
 =?utf-8?B?ZXUwMHpoMUZ2cEFSNUtKamUwTG5VV3AyWUQ1NnN4WkFEOGY5RjFzODJ1UXJW?=
 =?utf-8?B?ODROOTRFd2xLYjRWWmpSZ1hRcXdNSkNUa3BTRDFkTlRNYWhYRjZHRWFNRDB5?=
 =?utf-8?B?THhBbG8yZnpRS1g4RzVZelpsVDZFQ2didmpGZURnTlFQYkVUSVFPZldwUWE3?=
 =?utf-8?B?QWpIMDJaM2xrQlgvYWJMbmUwTHBZZFNQR1hjSGkrR2dlVml1MSsrYVlLMGE1?=
 =?utf-8?B?K2hxR1FuQ3ZRZDFPTlNtZlRablJQUncrTVpmZWZMN25lSGp3WXJSdUlla0xJ?=
 =?utf-8?B?UTBtbng3UE5FdGEyeDd1S0dwT0dkUVNUcWRBL2ZMc0ZDZWEybmtUc0hKell2?=
 =?utf-8?B?MDVNSWV2SGRJQTA2aHhZL0F3cUFyNkFMaGYxWnk0aHNIcG82QnVxTHc5aStF?=
 =?utf-8?B?TDhSZ3B2ZDZmTW14V3YyYURyMmpCdUZkTHZlMlhXVEhmWUVtT01xL2Y3ei9v?=
 =?utf-8?B?T2xWMWlNOUVIRXluZXgzb2RMQTBZenQ5WjBJOWIrdHpla2FBTFIwRENnTDkw?=
 =?utf-8?B?ZnlPdWM0R2tPNGd1dU0xazRxaFN0T052a2FZYXZFMGlYL0FiakplSmt4a1p2?=
 =?utf-8?B?V0MrSXZwcm5VcUZrTXpFczBFYmFCdTFPVFVNeVBrWG5QUW0vL1hsQVloZERl?=
 =?utf-8?B?TGxyeTVTK3hISkFJOEdYNkhYUnNUNXBObzhYVnVuV3ZzQnZFTkx5MEQ2Ny85?=
 =?utf-8?B?dkVlbnFtRVVVZjYySWxoYXNYRmg1Yjd0RTY0dUFQTWZZdGlQTEx2SGtNeTRt?=
 =?utf-8?B?SXBPTGcvYWtkN0VuZWtwTTNXRWplWjg2R0pSNkFoUXJwalNpSmExMEJ5YkZG?=
 =?utf-8?B?SUtRdE1aanREdzdmMHdycTFiQy92OTVzUEJYL1ZjQmNOQUNnMmo4THhsMVVX?=
 =?utf-8?Q?mItwuF?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5887.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnBSS0J5Zk4vVHVXNThFVXFKTDZTdzFsVkg3ejNSYTZGSitLakxsK01xVi9k?=
 =?utf-8?B?bVRsVjJHTzhKOStKdTJjQXc5ZHlaY3NxSHN4aUsvRTd0cDNvdzM5VG1UcDk1?=
 =?utf-8?B?cGZSZkJSTG5DTUo4dU4vd1JDZ29ZUHk3dTR3ZURWR2dHVlJrYTJjaHk0L04x?=
 =?utf-8?B?ODNxYWNJcituZmNvM2FRbVFZVlV6anlwOHlWZU5FUVJUSlJxQklmTXlpVVR1?=
 =?utf-8?B?WitodmNlU3RFSlh5TWF6ZTd0R1dRQTNFOUtkTzVtU1pybFRHNzlvNWp3SUlJ?=
 =?utf-8?B?blhZaTk4UGkraFBDWmZNbUloSnRSQ09iY3pUaTdkaFZxTnRXVGx2ZC9Fd1dD?=
 =?utf-8?B?citONGp2NXNWUUdnSkdGdFU2cjczemJsaTBvSGhIZ295Vm9XYmVYRCtFc1Zo?=
 =?utf-8?B?d2VhUDFrNUhJS2lMMWZYb0hCQjI3MmVaaXd2UEJuVEw1TmNZWVVlY0JFL0N4?=
 =?utf-8?B?TjVyUzE5NTJyd3RKM2Z1ZXpQMU1ScExCVW03dldjNGliZG0rRkxpYi9XWlNN?=
 =?utf-8?B?SDA5Ymk2eDYvRmUzVDl4S1kvR0RCK2dPbUtDVEFlQVIxWVY2VEU1R0hnK1Fq?=
 =?utf-8?B?WWExU0hSWGRQeEc3a3ZUMlZhM2Q5aWMwOTZJTkJObXhncit4WWZBeGJOSzZH?=
 =?utf-8?B?SkIvVVVYaEhHZ3VPblViaXU4aVBheUI2Y1hoOGhDRElzVjZWZTNGaVZzQTZw?=
 =?utf-8?B?SlpoWEZrN1lDMHRzZmdJRytWSklQMmU0eXJqZU5xOFFoOXdMVzNjQzhQZGNk?=
 =?utf-8?B?OCtZRURoSWk0d1VUWUlNeDN0NlV5R2M5aURyN3YvSVI1Um1neEE3dGxHcUZz?=
 =?utf-8?B?clRpTHp3WE5uTFhoTlpZdTdQcDFqMnUxWWpMbjgwRVV6Rjc5ZTFKaUFOVFc0?=
 =?utf-8?B?N3FWU0tEcmVtTUhwajJWRUdGNVArYU83cEVyREpLUlZhQnJPTnRLSFFqS3F3?=
 =?utf-8?B?Q2JoZHZidk1YRjZjWThwdDdRWkdCMWdzSUo3WVhsTlRmZ3RudDh2dWozczFk?=
 =?utf-8?B?ZkZwdWdsVytWR1A2d2hDR0hYeCt4SGp3eTlqYzltNXVoRmlHNXhudE1FcERm?=
 =?utf-8?B?Y2VpKzRIbzNLS0c5TUpKUk1HZXk5Z0hrQjYxMjNubHJ0Uzc5aWcwT2IzbFox?=
 =?utf-8?B?SmgvMVh0WTYyV3NwNWNhMFVHR2hiNVRURHlDd0lLUHhIdXBXd3UrQjVoRkRS?=
 =?utf-8?B?eTlBTUtMbm5rN1hHZnlBcW44Mk1KY0xraEhjZE85WEtqREVXSHlrdkdpWW9C?=
 =?utf-8?B?QnZYT2NSL3grS1VkL1BJNnM5aTF5SDZGcUd1OUlEWDdyREhNZ1BVRGNETUNR?=
 =?utf-8?B?THU5WUNqbFRjQmJxOHg5MzNXeUxmN21hZnF0U0FXOHFRRVY4Mm9lYW42ZW1W?=
 =?utf-8?B?UENENDJsWUF4OERqdmtUREhTUlZ2YXU4eDNSTEtkZHV6L1JWc0F2bXpKODR4?=
 =?utf-8?B?SVhaODlFNTl5bGxUOGlKK0tQbldpRlNCVW5oYnNabW9IQ0VmQVEzZDU0aVFB?=
 =?utf-8?B?RWJhY0l0dWJkQ3Ard3RJZ3ZGODdKUDRNWnhrelIwK3MxMzBhRHdBNGwyaDZV?=
 =?utf-8?B?SWxjaVZ0M0s3N1IyVE96Z042QUFCMG1rTEg1WWh1ZW1RZWVMVnRPakduOFF1?=
 =?utf-8?B?dzZWdllycG0xalRKSGRKc0VqbzdmK082aGNQZnhOb3Q0YXpBOUJGLy93UHh1?=
 =?utf-8?B?aXo3ZTZRSW5rdlNjdzQyRXg2V3pjT3JGd2s4eHFGVEt2UmEyQzFLVDRWNEU3?=
 =?utf-8?B?NHI2aFNuckJOSFgrMXl1MEFTZEUzcTA5ZEtkWHZLYmhpTVdXNmpQaGdiNk5z?=
 =?utf-8?B?bVp5THpFYUdodFBHR3ZXSEpWWTlrd2pRKzRIYUtSWlk1NlVFWmtxSlpzZU9D?=
 =?utf-8?B?YWR1L2R4bnM3YkJqNytvM2h3NWpQa21USTVqalYyaXY3aWJiUFJuNU0vM0Js?=
 =?utf-8?B?NHJaQUxCUGlINEF4d3hHeTMxYlA5ZGJoNzdDMUVoVi9SVDFKRTgzUFFuWVVL?=
 =?utf-8?B?aVJBYnNpUW4zaHBKMTVYZDk4dEtFYmMxakZJcFd5aE5zYlMrOGtlTGtsK2Rs?=
 =?utf-8?B?M3VCRk9pNTVzcitEYTZLd2hvV2UwZHIyRUowUmZHSVVPMmFncnhRQWlFUzBY?=
 =?utf-8?Q?CH4Y3JY9MLmSrW451tyBrNJdI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5887.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aba014-41da-4d5c-84ab-08de204b6b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 11:22:23.1735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oX8tydzhv3PaTPihles0fvp6JSTsQ01O0uMYfmIF+GeNHUaWSTxDKXV6bfZmPrqDVGmCRnJaRS58pjU4YCiPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6990

SGkgS3J6eXN6dG9mOg0KDQo+IC0tLS0t6YKu5Lu25Y6f5Lu2LS0tLS0NCj4g5Y+R5Lu25Lq6OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+IOWPkemAgeaXtumXtDogMjAy
NeW5tDEx5pyIN+aXpSAxNToyMA0KPiDmlLbku7bkuro6IEdhcnkgWWFuZyA8Z2FyeS55YW5nQGNp
eHRlY2guY29tPjsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsNCj4gcm9iaEBrZXJuZWwub3JnOyBr
cnprK2R0QGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmcNCj4g5oqE6YCBOiBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGlu
dXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBjaXgta2VybmVsLXVwc3RyZWFtDQo+
IDxjaXgta2VybmVsLXVwc3RyZWFtQGNpeHRlY2guY29tPg0KPiDkuLvpopg6IFJlOiBbUEFUQ0gg
My8zXSBkdHM6IHJlc2V0OiBhZGQgc3VwcG9ydCBmb3IgY2l4IHNreTEgcmVzZXRzDQo+IA0KPiBF
WFRFUk5BTCBFTUFJTA0KPiANCj4gT24gMDcvMTEvMjAyNSAwNDozOCwgR2FyeSBZYW5nIHdyb3Rl
Og0KPiA+IFRoZXJlIGFyZSB0d28gcmVzZXQgY29uY3Ryb2xsZXJzIG9uIENpeCBTa3kxIFNvYy4N
Cj4gPiBPbmUgaXMgbG9jYXRlZCBpbiBTMCBkb21haW4sIGFuZCB0aGUgb3RoZXIgaXMgbG9jYXRl
ZCBpbiBTNSBkb21haW4uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBHYXJ5IFlhbmcgPGdhcnku
eWFuZ0BjaXh0ZWNoLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9jaXgv
c2t5MS5kdHNpIHwgMTQgKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGlu
c2VydGlvbnMoKykNCj4gDQo+IA0KPiBQbGVhc2UgdXNlIHN1YmplY3QgcHJlZml4ZXMgbWF0Y2hp
bmcgdGhlIHN1YnN5c3RlbS4gWW91IGNhbiBnZXQgdGhlbSBmb3INCj4gZXhhbXBsZSB3aXRoIGBn
aXQgbG9nIC0tb25lbGluZSAtLSBESVJFQ1RPUllfT1JfRklMRWAgb24gdGhlIGRpcmVjdG9yeSB5
b3VyDQo+IHBhdGNoIGlzIHRvdWNoaW5nLiBGb3IgYmluZGluZ3MsIHRoZSBwcmVmZXJyZWQgc3Vi
amVjdHMgYXJlIGV4cGxhaW5lZCBoZXJlOg0KPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9o
dG1sL2xhdGVzdC9kZXZpY2V0cmVlL2JpbmRpbmdzL3N1Ym1pdHRpbmctcGF0Y2gNCj4gZXMuaHRt
bCNpLWZvci1wYXRjaC1zdWJtaXR0ZXJzDQo+IA0KPiBQbGVhc2Ugc3RhcnQgcGF5aW5nIGF0dGVu
dGlvbiB0byB0aGlzLg0KPiANCg0KT2ssIHdlIHdpbGwgdXNlICIgYXJtNjQ6IGR0czogY2l4OiBh
ZGQgc3VwcG9ydCBmb3IgY2l4IHNreTEgcmVzZXRzICIuIEFsbCByaWdodD8NCg0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvY2l4L3NreTEuZHRzaQ0KPiA+IGIvYXJj
aC9hcm02NC9ib290L2R0cy9jaXgvc2t5MS5kdHNpDQo+ID4gaW5kZXggZDIxMzg3MjI0ZTc5Li5m
YzY4NzM0ZjM3YzIgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9jaXgvc2t5
MS5kdHNpDQo+ID4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9jaXgvc2t5MS5kdHNpDQo+ID4g
QEAgLTM0OCw2ICszNDgsMTMgQEAgaTNjMTogaTNjQDQxMDAwMDAgew0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiA+ICAgICAgICAgICAgICAgfTsNCj4g
Pg0KPiA+ICsgICAgICAgICAgICAgc3JjX2ZjaDogcmVzZXQtY29udHJvbGxlckA0MTYwMDAwIHsN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJjaXgsc2t5MS1yc3QtZmNo
IiwgInN5c2NvbiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgwNDE2
MDAwMCAweDAgMHg5MD47DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICNyZXNldC1jZWxscyA9
IDwxPjsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiBXaHk/
DQoNClNvcnJ5LCBXZSB3aWxsIGRlbGV0ZSBzdGF0dXMgcHJvcGVydHkNCg0KPiANCj4gPiArICAg
ICAgICAgICAgIH07DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgaW9tdXhjOiBwaW5jdHJsQDQx
NzAwMDAgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImNpeCxza3kx
LWlvbXV4YyI7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDAgMHgwNDE3MDAw
MCAweDAgMHgxMDAwPjsgQEAgLTU2OCw2DQo+ID4gKzU3NSwxMyBAQCBwcGlfcGFydGl0aW9uMTog
aW50ZXJydXB0LXBhcnRpdGlvbi0xIHsNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4g
PiAgICAgICAgICAgICAgIH07DQo+ID4NCj4gPiArICAgICAgICAgICAgIHNyYzogcmVzZXQtY29u
dHJvbGxlckAxNjAwMDAwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAiY2l4LHNreTEtcnN0IiwgInN5c2NvbiI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJl
ZyA9IDwweDAgMHgxNjAwMDAwMCAweDAgMHgxMDAwPjsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICBzdGF0dXMg
PSAib2theSI7DQo+IA0KPiBObywgcmVhbGx5LCB3aHk/DQo+IA0KDQpTb3JyeSwgV2Ugd2lsbCBk
ZWxldGUgc3RhdHVzIHByb3BlcnR5DQoNCkJlc3Qgd2lzaGVzDQpHYXJ5DQoNCj4gDQo+IEJlc3Qg
cmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=

