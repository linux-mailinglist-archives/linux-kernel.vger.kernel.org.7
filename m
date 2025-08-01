Return-Path: <linux-kernel+bounces-753001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA44B17DA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B1897B98D9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121BD1FCFEF;
	Fri,  1 Aug 2025 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ueNTXQPJ"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D713C38
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754033606; cv=fail; b=A6MJ44Skayf4p99DUIP3M3iLJmvMaRrNhKki6MZFaElmViDQPcV7o5585NPr1TiMMcgcm+g7HFlHZU9pCN/+i9jRiq8/n8m++crwEUlUIsf3eRnVtFGrs3dYy8J4LBMrgQG670uOLQ8DtZhckGnkN4Pfk4oc7kAE4FrfRefc5bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754033606; c=relaxed/simple;
	bh=WxHtVTNx7XLdy1W63I92fzCAFgvXQ7tRA3h6wqoIx84=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IROmEJS1ORU4g6gTPPOvORgfFfXR1NyOddbGQU46Q1toGdWMT+GX6QBUuq3s/d5FyGRrWANtqmHMuf2PRBUzT3dY54CBqXEG0eecWJ4c3a0MqD7uwWFgT0fV46J9KNDGKX+/W2E3v1T9G71Iwswm6O+yq0tzQw2LGwoMo26a3s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ueNTXQPJ; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6R176XSWu4ja9WrFS7mMLXMUqI3xhz2nyX1RS/+sp636LOD2pHvHCnq81G5JxFyPlk3tezcwhgkygkC9X3xWjqCuEP5sFIf15VAAcpyLCZckn1nf8wIfgRX8+EG0ZjQ/YTdipayvkoXm/yUb9NPBVhakwGxdSl2sNAFTcBtGIzsS9yXfZlwMWoNe7M48H4eY7O8eO5ChCQkz7tulJy9i0HWn4Hyaa8A5+F/QTaQQTJXZUKx/Zgc/JW3on58BXIS2tP9/uVoNx7WOoDe+AEuROMm3igUArUYlV95UaFSRgH5LcZ+SMHPZG04+fgcS5ia/pwfWXNDOQBQZBFz4stFmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OoYgvvG6pM9lgcgDt0wrgRRezt0iMh3xGu721L6YkFY=;
 b=bJmmfL9XoKimyTS5XtS5aLqsxVGHinHKRQMOO/ndIaBZOIllF2M3QVIIst96MEpVQ/ituOu7maoYqZFKtdtlbzbCZSOsjqvXsVMTQzFNZn4PjDPmWUMbtzVB17lb2g2sqggvUpIw9KkS3nVs6VpDd6+8FzLLkN/eIwNEim6L6oyEwBlGgBxKNUdNZSyWhMYOjRV/RJ/fR3gNRQpxA3IpSn1KRPnsYaH7Ss2eYy/X/nk1dS+iwuigfCMqdsX+QEQKlWy9+m2Q9k8ZA0FJvBWIHQFFyGHSsWhWWNwl9aKj/6xr0T9VMP+67mUwV2+8Odk14xqJjz+Ka1Q9Ld5mslNKmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OoYgvvG6pM9lgcgDt0wrgRRezt0iMh3xGu721L6YkFY=;
 b=ueNTXQPJ127CqdyAyGoCkumZMGKS6BrX/A9a0++Ks4+chr/icV+hSKMnCR3Qqn67SPfLo1vW2Sr/A9nQBHk3zezySDw4LJR357j1zMoe49VALVVmQrbMf5XpfgCsHwwx0y73H6D8gy4vlmDWD1gUKAziVnDQKhtNa3czoYTZ/D4C2p8wbVnAO2fvzHv2R1n9F5Uv/oS8Eh4vBq/wjeTPgLhx3eltqjTKoYGlWhn0mwpqpjCxi10LPkq2b8S7LjSWVCqfzzhTNpOHzwZ+hVbJai+oGd8oUHkhScIZ6fWpkUufd240kLHcKEZCv1fsdRYb+Fx0CiNw5zMaDaniSrg8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com (2603:10a6:102:219::10)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 07:33:18 +0000
Received: from PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18]) by PAXPR04MB8590.eurprd04.prod.outlook.com
 ([fe80::8cc7:661f:ab20:7d18%5]) with mapi id 15.20.8989.015; Fri, 1 Aug 2025
 07:33:18 +0000
Message-ID: <8d76fd30-57de-40b0-a847-4b84c8d529c5@oss.nxp.com>
Date: Fri, 1 Aug 2025 10:33:15 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] clocksource/drivers/vf-pit: Allocate the struct
 timer at init time
Content-Language: en-GB
To: Daniel Lezcano <daniel.lezcano@linaro.org>, tglx@linutronix.de
Cc: S32@nxp.com, linux-kernel@vger.kernel.org
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
 <20250730082725.183133-8-daniel.lezcano@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <20250730082725.183133-8-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR06CA0074.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::15) To PAXPR04MB8590.eurprd04.prod.outlook.com
 (2603:10a6:102:219::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8590:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b41881d-50c6-4e10-010f-08ddd0cdaf2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djkvKzBWZllieGZhYkZ1akR1eWpyZ0dZZktxRDgwWXF1NW1oVWpJOEg3Q2d3?=
 =?utf-8?B?TE1BeDR0aW1ZRERCYzR1UUFqSU9BQklPQjNOdXQxWmJ1djJ1WjFJRVlsM2FB?=
 =?utf-8?B?SnBMNGt6RzdMYjVubXV5WjhBTWk4bkRJZGxydWpFOFcvVm5mT2MvU1NkTTJa?=
 =?utf-8?B?ZXVpTVMveVJOczN4b2hnenA2OGtJRDN5Snk5R0dIRHBmYmZaSmZxUWk5QlFF?=
 =?utf-8?B?TlNxUXdvWGNGY3ZzdDFKaGF0THlTdW9wOHdtODk3TGowWUhSYkI2SWc5UDhR?=
 =?utf-8?B?ZCsxTndPNUJyR0MzU2dhUytBaTVpY0VMWlZFakpydXlWRVNMWThQT0piYmVH?=
 =?utf-8?B?TWxiWHpFS2N3bGFueXN4Nnlnd0xHZ1lVbm82VzU1bnR2UEEzcXFVQ0VhcjRk?=
 =?utf-8?B?dUNwc1hhdDNTaVUxZklTOTVSOGFtVk84eXQ2M3ZDZlA3S2lXaUNIdENOR1V1?=
 =?utf-8?B?NStRRDFLckJ1N3gyQm14RTM1TVVRYUlRUzZRMGVma2tkQ3k2UkpRUW9pUE5T?=
 =?utf-8?B?MHpicWtZNlFpSVd0MnFmRE1ES1JqOGQvQ3h4WmpDdmgraldmMzZWL3F3cHNn?=
 =?utf-8?B?OTd2QmFxbjllSkRqKy9Jcnh4aWRBaEI0ZVY3TnhKRHAwdTNYOXUycFZoSzU1?=
 =?utf-8?B?Q3I3NVJlNk5ET2VuQUtsb3E2ZHVqeWZzd3hOcWRCR2JMWW15WjRwVS9zN0FT?=
 =?utf-8?B?YnNJeHgxeFpZdWtINS9sTmkyNGp1SG9UemlJbEhPRGxlNHBzYllhTFhEOFZn?=
 =?utf-8?B?TEdjVkI3WHRIUG8vSFE5bnQva1pQcDNSZzdqSng2c09KSXRWSVcybm1lN250?=
 =?utf-8?B?ZHBXcWJTUisxYW82bU5qd1lNZ05Tdkp1UlJ0TmV1RGJ3RU9Ick9mWDZDbXZF?=
 =?utf-8?B?MHF6bGpSaWx3dXpyalJHR0hKb1VnOHZYMCtmS0dmZ1BhRW9jZ3VmS1RGK1pw?=
 =?utf-8?B?SzhiS1E4QTlKa1V1dWJPLzNoVTNWR25TMWlnQm9nS2VsVE1YQXNGTkhpZWNw?=
 =?utf-8?B?ck1ZT09RRUwwdzljSklCc3I2L0c4RVhuZ1VYeklBbW9taC95MEQwbGJYK1o2?=
 =?utf-8?B?OTVISktTZitBU2gwQ2lqMlBXZVpiNFlPaGFvQlRFaEZvR2E5N2Z2YzhiZ01t?=
 =?utf-8?B?cFQrQytKR3I0SlR1MnZyLzVrYlEwaGxjbTc5UVZXZEk1bXZnYjJRVE5YQjdO?=
 =?utf-8?B?SDVmZkhNTXpzNW84T05Yemk0eGR0VGgzVFpEL3RsWnFXbWkvblFDSFE5c1Q1?=
 =?utf-8?B?VFIzTDdLbzE0ak45MjdFb2FUZFFPREp6MHcxVkwvTmFkcm52SUFBUlFFNEM0?=
 =?utf-8?B?amFDbmRXUUY2Z3M5cVNUamV3dXhVVWxNeng5Q0N5WEhYdDdodmZFS2h0RjBI?=
 =?utf-8?B?WFlsV1FxeTFHaElQNEpuQ2NWTkhlL293WFFrYzU1WkE5cTNqTFRpR1ExRkps?=
 =?utf-8?B?aXVxOFdqclBxRjZNTUtHZ2w1RjRDY1MzbzFYbFBER21TUDZSRTdwWnl2Zk5D?=
 =?utf-8?B?dUlwTSsxZElwWmg0b05zL1BmYzIzb3h6M2sybjd2RGJXVGhPMFVzWTdvbHo1?=
 =?utf-8?B?U0tLVGtqeUJYQ2l4ajNldk8rZUIwaGoxaWpnYitVbkZUOG5HTWR4QUt0VEla?=
 =?utf-8?B?Ym45NHRiVytlckxlQWx0K3graDFSWHNGRzhTNXlqNUZUQzFzYXR5ZlBvUnZ3?=
 =?utf-8?B?dEt2NWQ0MmlhQjlTVHFrdUZlU0VuVDA2dkR2RytwejhuVm9SSnVONmVPZ1kw?=
 =?utf-8?B?SVFKVU1Jak5TOEtENnREdUtWOE9xaUNjKzhjbWFQYXIyd1p6cUZMN3lJMFNl?=
 =?utf-8?B?WXlKS1JZUU5wTnFIa2FValBVY3hQay83ZkRtSEFlSmtJdjBEaXhJcFVscDBx?=
 =?utf-8?B?U1RjaXFrY3B5a05vVEtQTnBvZGxDTTNLbjlGZ1BRdCtCelNQV3o0dW1vbmRK?=
 =?utf-8?Q?se/0oA7rEKI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8590.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?enl4UnhwK3lJRXBGVzdNbnNhVnoxbWlvVnRKNW9meFNKZUovbWdER09tSmNR?=
 =?utf-8?B?QXBoZVlhdU51N0RDSFFrTWJ1SEluVi9rVEFNNlcvN0V3czR4TTNveFVyRmdl?=
 =?utf-8?B?a3p5OS9LNGE1L3lCNDdEOHkxMWJPWmpBODNkRnozY284WXlHWEkxUkZuOExX?=
 =?utf-8?B?M0d1VXZUYzZhSDMrMVplc1dOREhLVzRkbHBud2xtWUdyMlEvVzUrZkxCOTNM?=
 =?utf-8?B?VWlzMjdXaWZweE8vZDFJRmtYVk5KQ3VqMGNVNTY1dkRUOFdhUDhCZGNiZ2cz?=
 =?utf-8?B?NEd0a1RoN29Ba3NWamNzQVJCVDVNVFdyY2dkTXp3Z2cxK3NTUlpTRkdjTkd6?=
 =?utf-8?B?YzZ1VWVhV0gxRzFCWWpPRXYzK2tOTUJKM1VESEp1N3NBQUJTaXdNZkhoQ2pT?=
 =?utf-8?B?UTRyY2YzKytqbWZ3cEVwNUdjeVdmREhFWGJENFpnT3hscHpwWTFQZVQrT1Iz?=
 =?utf-8?B?TTlUSEJ2bmtEazBHdjVhSFJhaGZkK3djaHJCN0p4Rk5Ia3NEQ2Q3ekRYTUlJ?=
 =?utf-8?B?T2hJN3lzcVBlU2FxcWR3V2lrODhLb0JwRGJTTS9wVGp1QjMvU3M4TldzYi9s?=
 =?utf-8?B?ZFBJb25ya2Q3d2wwWVNXMm15L2k5TnRQSEtiY1E5ei9YUUJId0NXRUNXUTEv?=
 =?utf-8?B?cDh4SGpneW84dUVhU0pacDdtZk5rT2FqaGp1dDJ5cWVMYnJuNzk4Wm83MWVB?=
 =?utf-8?B?Z0lOQ3FEOS9LQzZYbHBXZXpjS3FITzROa3hxNUpJdG8zZWxoL2FhMDhrb1Zj?=
 =?utf-8?B?OHpFZkpIS2d4RXJxRS9hNzBNTVhiVG5kVlBUUWh0WWFHdUpKVkZRQ1FkRFVi?=
 =?utf-8?B?OHBlaFROaERUZzVVYjZtcnpzZ3NCQWFwWmEyN3RpcjJjMzR0WFJhUFJYZWxj?=
 =?utf-8?B?cEpjUkFKOVBYZzVibjl6bHZiK0l0UFVPdXNjeUkvN3RBMDc1OWUzWmw4ajBX?=
 =?utf-8?B?NXdYcFRFZG1BeTM0VWVUcDVZKzZWUHB0bTN1OHlKYkNKZ0xyMmJtRFB4Tlg1?=
 =?utf-8?B?SWRTTm0waGVwZkNmS3hSbkZRNDh3ak8yMGJGT2tta3JMOVVJMVdhdTd2cDhh?=
 =?utf-8?B?N3V0ZWRGWEc0SUkyVnJLQlVhT0NnVGZTYjdYLzlaQVZFYXJJc2xJYVpTcXlz?=
 =?utf-8?B?bDQrQmQxOWt4NnpVbWF5RmFzMEhENmJIaXJ2cjNKS1JMN25wYXR3eDhEa3Vt?=
 =?utf-8?B?Uk81V0xKeXZJUEt3RE5WeHRaZ3EvY0F4bFBmUFdqSFZVNk0wYjFrTUw1SDUv?=
 =?utf-8?B?Z2xMT0s0d0pGenRwcFlwSDFrcHpPUEYwMGRNRzdkcG5PN0g0VStYUGdHWVEz?=
 =?utf-8?B?di8xeUpmRHpFK08ybzd1N20xNWJvTG5KN3E5MlR5MEp1a3ZFUGNmTERWY1BE?=
 =?utf-8?B?NVR5ajJIZDBudE1qSGpuK3VkQXlSdEk2eUlwaXM4WXhRUFVqV0VrRXBTNTBQ?=
 =?utf-8?B?cWY0b3M3c20vUkNud2pRdnZ6RUVBYUxpbS9pdElPdUJpM2l0L2RLRVBNL2pF?=
 =?utf-8?B?QzdHSjZ1S2VVaVFpMGhiaVBUMzY5eXFKNUdiQWl5NXdtZWR5OE1OWU1ibnd1?=
 =?utf-8?B?M045MStxVWNHb3JtRFN3ZzJYUVhSR3RRSjMzQlBRNXZjazJIN3Z3aUtGUDJR?=
 =?utf-8?B?WjJmT0ovcUc1UE14S0VCRWt2d3RjZGR4cEVlbkpramxCNnk4azgyREkxcEJX?=
 =?utf-8?B?ZjBISGNxU210UU9ESE52MDdZbmxNeFZkcjAydWtDdFYvM21talJVL2E4ekcr?=
 =?utf-8?B?TUlRWkdKZzRESTVsUDZPVlg5T2dNaGpGSGZiclE2NHNTN3hmYjlCTU1BcEhx?=
 =?utf-8?B?a0pjbU9NU3ZtYnNhOFNTSTlodzh1eVFJYnArSmI3Z2hZSEcreWE3aTAzOUNn?=
 =?utf-8?B?RVE4bk1mUy85VE0vUmFYWTFnMHVrdm9nQkw5OU01dVJCWXlNOXlMZ1NSYUxD?=
 =?utf-8?B?UDQ2Nnd1S3E3Vm5qZVJFZFlXR2dUdGtueFFlT0w5cUQ2Ykh5V0ZKOUYyWFhF?=
 =?utf-8?B?L0xUL3NrL2FEYUFCb1FYZ0hSMzMwc0NYNFpsR20ybDFZZGJUMDJ0NEZuOG90?=
 =?utf-8?B?TW04SG9WRkFwSnFFUjdCcWRyQ050TkxMZW9xT2hoMGMvVUJYS0RPTTNyelhR?=
 =?utf-8?B?TUlscU5ac3lEakVnSDluT0oyV0ladXNOZHFEcW9NK2ZXd0gyRktEZ3pCSTJF?=
 =?utf-8?B?UWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b41881d-50c6-4e10-010f-08ddd0cdaf2b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8590.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 07:33:18.5150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aywv0Pkc/I35KfRxJrgimkZb9CjL4dH7o6kzjM/JhVExrtxZMRHyICVX+dl/9uJR8m4x7nulWqS+4jQjoARBqCAhZNZ8pYll72Yp5y9bg6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

On 7/30/2025 11:27 AM, Daniel Lezcano wrote:

[...]

>  static int __init pit_timer_init(struct device_node *np)
>  {
> +	struct pit_timer *pit;
>  	struct clk *pit_clk;
>  	void __iomem *timer_base;
>  	unsigned long clk_rate;
>  	int irq, ret;
>  
> +	pit = kzalloc(sizeof(*pit), GFP_KERNEL);
> +	if (!pit)
> +		return -ENOMEM;
> +
> +	ret = -ENXIO;
>  	timer_base = of_iomap(np, 0);
>  	if (!timer_base) {
>  		pr_err("Failed to iomap\n");
> -		return -ENXIO;
> +		goto out_kfree;
>  	}
>  
> +	ret = -EINVAL;
>  	irq = irq_of_parse_and_map(np, 0);
> -	if (irq <= 0)
> -		return -EINVAL;
> +	if (irq <= 0) {
> +		pr_err("Failed to irq_of_parse_and_map\n");
> +		goto out_iounmap;
> +	}
>  
>  	pit_clk = of_clk_get(np, 0);
> -	if (IS_ERR(pit_clk))
> -		return PTR_ERR(pit_clk);
> +	if (IS_ERR(pit_clk)) {
> +		ret = PTR_ERR(pit_clk);
> +		goto out_iounmap;

This does not revert the use of irq_of_parse_and_map. In my opinion, it
should be explicitly reverted as part of the cleanup phase by calling
irq_of_parse_and_map.

> +	}
>  
>  	ret = clk_prepare_enable(pit_clk);
>  	if (ret)
> -		return ret;
> +		goto out_clk_put;
>  
>  	clk_rate = clk_get_rate(pit_clk);
>  
>  	/* enable the pit module */
>  	writel(~PITMCR_MDIS, timer_base + PITMCR);
>  
> -	ret = pit_clocksource_init(&pit_timer, timer_base, clk_rate);
> +	ret = pit_clocksource_init(pit, timer_base, clk_rate);
>  	if (ret)
> -		return ret;
> +		goto out_disable_unprepare;
> +
> +	ret = pit_clockevent_init(pit, timer_base, clk_rate, irq, 0);
> +	if (ret)
> +		goto out_pit_clocksource_unregister;
> +
> +	return 0;
>  
> -	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq, 0);
> +out_pit_clocksource_unregister:
> +	clocksource_unregister(&pit->cs);
> +out_disable_unprepare:
> +	clk_disable_unprepare(pit_clk);
> +out_clk_put:
> +	clk_put(pit_clk);
> +out_iounmap:
> +	iounmap(timer_base);
> +out_kfree:
> +	kfree(pit);
> +
> +	return ret;
>  }
>  TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

-- 
Regards,
Ghennadi

