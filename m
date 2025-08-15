Return-Path: <linux-kernel+bounces-770559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EFDB27C57
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EA53607DD9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FCB264A83;
	Fri, 15 Aug 2025 09:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YLZQjrvd"
Received: from outbound.mail.protection.outlook.com (mail-swedencentralazon11013016.outbound.protection.outlook.com [52.101.83.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9432D6408;
	Fri, 15 Aug 2025 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755248704; cv=fail; b=Kc4MIXTzqpkTypnbZZ9i6ttJVQi9Zau1QGqWsYuERosVxfDouDb8kFAlR+KiEsINcdHTZtI68FA7CP6B+F2nLUn9isDtG5k5iyqYhimPIyXnFo7TcNjUCbpUXw5WZUk7Fm5YUresxJSuVIl7zG8VnXZiiGBSRjfoMlo3WBK2jr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755248704; c=relaxed/simple;
	bh=73C16G2k+zMbUIp/Qf1T+2HRlJtJiG6Od98i4DlgyZc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KxWLS+3qtq2GOgL8mFwn1eMOaBbXMrJNOrZzOa5jS+sQ3ToLDsSiI0A9zoSf1WrrnO/+TI2fup7HRgNa99MOqFJ90qZfmLftZIIFXCnIl/uc64m8vuSS40Up8Km0iJQbUjfGOi4g2O0nnGvC8Szc9erI/EwD4kgWMKN02OEkAeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YLZQjrvd; arc=fail smtp.client-ip=52.101.83.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JV/Uw+jc0mq0SeHjCTGp9dEqQ2EfyM4M8tOGM8LUGHQ33D575VisRYIBwMBUnQTxbSCqDn2IKd2ENQsBC7HknBXHQa+DyJrNy9+kgp77wjffolNvIZC8Qa6Y3nmRLGZPujk0Pg4ElAzlk2soEhPJ9CwSCgInZonjnQCL3HbuklRXYq8/RZWem9gQIeWWPgDS3c3f4iqlV0vtvsB1WqW0690wIj2h0baVfPrA+eVan73Kmmm+wETdHRrx7I5akfIay2vERseZKp1E08ff12yDty23GPz0zxzzoGN3NSm2J9ouom6wULHbTkxZ7J2lenOsnF3N8HKm4NAn+rC47fM8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sIZpKDEvQXOkxdx+ECEANzN2m6/Qi4CjyEDvbXe3NI=;
 b=GiaOQy3lwZWNFCwNBKJUOShRIv9zbSmCGOrCeJw2ZJ7fCDR/ZpapgUyRTtHAQ5jFbbrz3w30jmgwMSJzaq82Gk/H7evhpgj8hc3hUAdkDwDfq1oGOKuiAa/YjB4SPO5vGKfplFwDWTYVqfx2fRTV+uvZIqCHGI7l4ZskuGgWMmfr3w4VJpSRtgAHN7Zint1z/FunARiV7R/uXemQWDWr8d3YEt23pjWPTjCd2otHQ3+WJmrG9wKalTcmJB0/6l5o+Ekv6/qh/qb4Go9PtThzfKiXImaTyTcvrhKnqAdOa73xjyvVMBO9wvWk81cxjvbamG8Up2de8wzBLsuIgt5sSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sIZpKDEvQXOkxdx+ECEANzN2m6/Qi4CjyEDvbXe3NI=;
 b=YLZQjrvdQAOPMpMWMTqc0/2DkRepBWedEzZTGBq/OiFPkaDwSoxaSHlPLJqpa/61m9hJR7AC+gIxTx9jPbiTtvj9K/Q3yP4mQBKVIYEoXj2EX6Q/Bdb2AJal8BmWVOg0+PHhZOiWuRpqAd2maRxnvGdqKcjpiFqMZIGCZq/dW/Rc7RhvotAJFESbrBTh/Jcy32IGyfFcdSPp2Id3tfeJ3HNQWIEDmB2hpZRlNE3TWVDguUq7LwZ+0vKPBwpskwx6vgW8r5Hn0Z91NwgIveATVg8Caejmhoj4WpSENO5b9+TVqusYaJKPIlXLPP/FDmjMQl0kB88sNXdE03XIpBRsFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB8014.eurprd04.prod.outlook.com (2603:10a6:102:c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 09:05:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 09:05:00 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 15 Aug 2025 17:03:55 +0800
Subject: [PATCH 09/13] arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2
 regulator
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-imx9-dts-v1-9-e609eb4e3105@nxp.com>
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755248657; l=1258;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=k1+pkj1dugUWoVuDVbIgjhx330s91iqMblAbtSJmeGI=;
 b=GWO7JAix81LiV4LP/sMaghoCQ2UN/nnUL6g0UWXP4I2MHzx/O+APCOqlXmJ8Ia9qa8TCavtmm
 5nmk4m0HFhrCKpTUKwfCLwOk5FnrFXHlaV+uHiqzvKwJ4+kMJjlfXFQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 61bd0253-6442-4c70-9021-08dddbdacffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVUrYkp2NmFBS01lNTZ1RGxWWE1tNTV6R2trNHVUcGcyVmZkSWRDT1RSN0R6?=
 =?utf-8?B?bUZFV2FyVTBPYjRRbDZFa2hRVGRtT0tUdjhrNVorWWduMENMYU5wQUZlNk45?=
 =?utf-8?B?M0pONkhqTzNyd05oNytJekdFOTRQRXB4YkVBQUxWdG5MTGRqdS9BSTlwVzNB?=
 =?utf-8?B?amtqcSsyYTQ5ckk5c0hCN3ZyUFppaE9WMXIyWEc1Tm81RnZKRTZTek54N21n?=
 =?utf-8?B?Uy9hTURLUmRXYTM0ODhlVms0cFlhOFRaRjBLRU9ueTJSeWR1STNsS3crNUUw?=
 =?utf-8?B?SUlKVENEMDZwR0U1aXQ0Um9weE9BV0hMQ3pWRlhhek4vaU5LNE5VdXlGN0I4?=
 =?utf-8?B?L1hxeURhY2JxMzI0djJuRWRtOXMzbEtMakpwRGhZcEh5WVRRV3krcnR6bDJh?=
 =?utf-8?B?Nm44Zzd0V3Zmb2RzRHRFTENSdmZYS1kxNUo0U1c0Z0d5THNsNFlmWWJyUCsz?=
 =?utf-8?B?TldhaEhrKzRHRW5ISXJEQXlsYXd4b0R5aUxia0p1QXhndUdIWktOa0txZlFk?=
 =?utf-8?B?WWZKcHFJS0FQQW40Vk1FRXNhTDRCNm1pU0hEMDhRUHRLdG5qeUNtaGJrVGNm?=
 =?utf-8?B?dkkzbXhEdytiTXRIS1BwV0hsZmpiY1kvVm9FZTdON3loQXNoWGhJSWM2V2RR?=
 =?utf-8?B?M0xTRWNBcmNhclN1M0E0cmVCVFBjcm0vQkk2T01NcDVmcHpobFZyRU5JYmFk?=
 =?utf-8?B?VjJpYlZrZWF4cnNwZWcyVU8vV2NpSE1zenRLaTVhdHVGTkhKRUhGUTFHb09B?=
 =?utf-8?B?ZGNPTVphYVFyTEl1NHNpRGFiY05MRWJGM1BkZEU0OFNQakE5N1lMSDVnRlBy?=
 =?utf-8?B?bXN4a0VDUFlYN2NBZm44Mmk1M3gvcERjRnRFazB4Z1R2d0ZmM1VRTVl3QkZY?=
 =?utf-8?B?U2lXYzI3aHJaSGh0TXRPTGRsaHJJSHBsKzBWRUxodm9Oc1VkbTg2U2dac2Rw?=
 =?utf-8?B?UWkyWGpmMUlndUsxaWovazRDQlpPSHVRMThVVFNJUTF4WmFtRjcrNEkvWERn?=
 =?utf-8?B?UUN4Q1BsMThidjV3UWlwUXZ2ejM2UmlreExhTEpZRFNPdTF4MjFjVGpPNzhx?=
 =?utf-8?B?L2VzYTZiZUIyYmxGWmUwMVFETzFCamxxajBxTjdNOUIzMS9TRlR0ZFR5a0tn?=
 =?utf-8?B?OXlocDhBTktydDBRaDRVZjRsVzU0QVBvZ1MvM29JOXFQcU1wYjJ4OTNxek1u?=
 =?utf-8?B?Rmp0ZUdVT1JyaWZ4dmQyYlZ4dUdGTVR4aTJPNzJPdVB5bGdWUG9FYmFtVzhx?=
 =?utf-8?B?QU0zUjZhbG85Q0hzNWo2blRvaC9yaHJKR01hUGhwRC95VlQ3NVp5SlRzcnR0?=
 =?utf-8?B?aStxN2RhRHlJdXNkQ0E5R3JXVEZlakwwdFpHN1JhVWF6TUIrZTJUK0VxbXYx?=
 =?utf-8?B?Q3lmM0pSbVRoNFlUdUhhcUJkRkdoWnFxUnVmalRCSmVRSmtXK1pXOHlpbkhv?=
 =?utf-8?B?UmdxUmVQR1A4S1ZOZmRFcXMrbG5UcnU5aWlpdFUzK3VLbG1DcS9CMi80QW5a?=
 =?utf-8?B?ZEhla1BoRHVwTG1WWDYyTy9rNDNHeERyZ01sQ3grM25TRzZOcjN0Y09JMkFs?=
 =?utf-8?B?TnEyTjB3a2ZwcG5CZ0xQUnFjNURoZUZueHBxSzcyZlVOc1M0anhvU0Q1NSsr?=
 =?utf-8?B?dkxhK1RtUngrVmkzL3JGMDY5dGtVQlNyM3F1TkRYNFZ4KzlFRGNobVJLajFz?=
 =?utf-8?B?eVI0S2FMeDBTNWo5UHZBY1VGcWlaWVAvWkhKcDMyK1grc2NqcjFFaUhicEdn?=
 =?utf-8?B?dktCdjd0cGZaL3V2NWRUK0pGcGdjYytuMHJxWXREZ3YvTkw2SW04ak5TOEFm?=
 =?utf-8?B?RzJHcXRXK3RLOWRxbUlnWm9ESVVWdWVINnB1SkpnSjRlbzV2eUttYVlLTEZY?=
 =?utf-8?B?cjFmR1l4VVgwZ0lpZHhQTEt0VG9ZemtpQ3dFMkV0TVg1d25mRmwyTVk0NlAy?=
 =?utf-8?B?WXQyQkxJUHpRWWhSbTFFUHhyUVlEcitzUkFqS0lORXQrd20renIzMUFXcGhG?=
 =?utf-8?B?WW9PYzdwc093PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWY2cG5TaVc1bGN6RmZrTnYzU295cldMQU9uN0pUd3lLUHpoOUc0dGxieW5G?=
 =?utf-8?B?WDNLdXBMd3hyN1hTZERzQkFmUlh2WVR1OHZLSXVGTSthVUZjZlU1NndUVU1M?=
 =?utf-8?B?SlhWTWhqaUw4RVBPUFRFSldqNDgxdUNrT0RNbndwTFlGZG9Rd0Z2cUdLTWlS?=
 =?utf-8?B?dmtqaGtuNE5DNGNla3FuZ0JiT3BJSGx0Q1pweTFxdGZmbmYwRDBnTE5aZitK?=
 =?utf-8?B?dGdvc3RDN2dPOFBVYjRSTnBGOFFFSHB2OTNxZDBXQ3ZjNlZGVU02V3NXWXNn?=
 =?utf-8?B?dmVTUGxZelh6TkcvZ1pBWkMzT2crZ2tFaWQwQ1NodmtPRUlkL2RUTTU0RzBv?=
 =?utf-8?B?dDI3SlJNRUlMQWtEaTdyZW5KM3JXMDl1dFlRSWhVK24wWXJoWldDdHBIR2x0?=
 =?utf-8?B?RkI3QmJZWDVYdFlNRkRFTUJkZkIxVUYrWkxnL1pvWmg5WTNDamNxS0FzRlRO?=
 =?utf-8?B?NzhSL0RsT1VlM1RsZ2VwdnVVVTdkTnJlUmNxdkl2WFhoU3pjREZXM1JxdlhW?=
 =?utf-8?B?N1g1ZlJFOTNWZ21iMTMvTnF1UlhyQ1RMNmVFL0RYMWhpUHc1c2wxNE1waFdl?=
 =?utf-8?B?ZnpDSjB6bzRYdGFkR2FOWEVSaWg2Z2svR2NWZEI2MVJCaGtwVk5GVGxyT0dU?=
 =?utf-8?B?ZXNBYlVaV2FYS3A1cXAzeWdZT0ZMdVBiREEyZTRYQ2xzYU10U1ZidWptL1NU?=
 =?utf-8?B?VVdobElpeGE5My9HSzBkTUpuZ0lWbENQVmxkRWllOVFwRXFkUElQWDdhczFu?=
 =?utf-8?B?NjhaNE9iZ3VVeC9YMHVPakNza0FIYmdueEF0cmVyWElyZ2tFK1hCRkJuU0lS?=
 =?utf-8?B?R0U4cmtEYjlad2J6aUZkZDkyTk9yUlpWM3RZK0huQlhhRGhqaHJJWU5LMVZv?=
 =?utf-8?B?c1Roc2EyRkovU3dpODduRzU3TGQxNVZpTUhCZ3J0RUZhdFIrc0dyK0xtVEZ2?=
 =?utf-8?B?VVczYTE4T0Z6dWRUV1lTNktNem9GVjE3TktMNzRqUFFaQm1IaTlvRFBiLzJW?=
 =?utf-8?B?T3FGRGFwYmhrd0RtMEErMTVQcWRZaitUTUdZamEvZml2YStXd20wWDBrd1B1?=
 =?utf-8?B?Nm8rZU10eUJqNk9YY0F4YzI4SnY5cHE0V3FmZElxR3lWTlpsTUJCNDkyV3Iy?=
 =?utf-8?B?eUNFaVU0cVh0cTFCazJtM2tObElDbVk3QWpEN1Q3Q1ZteW1GakFYSVFlcVJ4?=
 =?utf-8?B?ZVBtYXNVSkhZRjErOUNYUXdMMHVDQVFlSmJoU3M4RTVqOWM3WXVUTG9BYjhP?=
 =?utf-8?B?TXRBNW1USDdDRytsN0NYUTNFV2hTZFpSd0dBclUzQTN3U2VENXFCWWJxMFJX?=
 =?utf-8?B?eGJGZUFtMCtlWm9zQWN6RTJHMTYvZTBXa0c5TEJCTFdLQlBEWlVZT3JzczI0?=
 =?utf-8?B?NzhXTWRyNEw5OUhPSXNXYms2Y3NiK0N4QUtUL0JlcU9IMGhvTWdCbWhMYVNR?=
 =?utf-8?B?OTNSZXlBUmxRekRpOUpUcHdpVnliZExPTkxMakZ1WDc5bWNZdGhZYm5XQUdl?=
 =?utf-8?B?UllQRzNPUk9hdG8rZllXRzkxQVE4VHpjcmhjVXlFSXFqSVJxL1RRbkhtckhz?=
 =?utf-8?B?SDhQem8rQW1BSFU2bkpSbDNvMTJTYXIvRnZWNEtKM29VQkszY1A1MTY1UXRN?=
 =?utf-8?B?NW1Delg2TG5MYTFBUlUzTEgvdlhpa1pmVjY1SEJaa0xiQ2htZUVtd01Dc2dP?=
 =?utf-8?B?cjM1bzAweE5WR1hqU21GalJ3MXVNb0NNUG5Da1VTTVpSQWo2WHpnVi91R250?=
 =?utf-8?B?THZWMVpUKytBYnFRbFpVRldtVTZmbjIzMEhtY3dHc0k3ZmxLeFlOZko5dEFR?=
 =?utf-8?B?OVZzeUFlWjQrU1RibnNWOUg1STdjek51RkNBS1VCSVo5SXdDbUQrWUlFUnh1?=
 =?utf-8?B?d2JETUFhTTRHRTByMmgxZVlNOWVwZVp0S1h5Nnd6am03QTArTDJxYklUT1Bm?=
 =?utf-8?B?ZFdwRURGZHlxSTkxUnQ4TVRTQXRCZlVDQ2ZXR1A3cWd3clJxR2RtU0FvTHBH?=
 =?utf-8?B?UENORzJsV3gzZHFVakJEbXppWVFFdWt1bzk4bTJqTFhVby9qQ2lLUjhHWHdD?=
 =?utf-8?B?WE5pbS9aVEhwVDYvUXo0WHhPSnBOd3lIWSs2TzY1YUY0azRTdlg4Tmw1b1dC?=
 =?utf-8?Q?KiHSMEuVpWEit6Co3d+1jmKd1?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61bd0253-6442-4c70-9021-08dddbdacffe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 09:04:59.9313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mKkEIyyKYrd45HE+20h0xblaWNWCIEMq7aI5ko3XUEhhGZGNMPb0Ef4QiCT99Xn91KMmva7g16ri8xVIzItiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8014

From: Richard Zhu <hongxing.zhu@nxp.com>

M.2 device only can be enabled after all Power Rails reach their minimum
operating voltage (PCI Express M.2 Specification r5.1 3.1.4 Power-up
Timing). Set a delay equal to the max value of Tsettle in m2 regulator.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
index feee6da65d37cae7413b09216014d6fe2b76b032..82e183dc581012a7c5be3d2bf749463d0a8a360d 100644
--- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
@@ -136,6 +136,13 @@ reg_m2_pwr: regulator-m2-pwr {
 		regulator-max-microvolt = <3300000>;
 		gpio = <&i2c7_pcal6524 20 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
+		/*
+		 * M.2 device only can be enabled(W_DISABLE1#) after all Power
+		 * Rails reach their minimum operating voltage (PCI Express M.2
+		 * Specification r5.1 3.1.4 Power-up Timing).
+		 * Set a delay equal to the max value of Tsettle here.
+		 */
+		startup-delay-us = <5000>;
 	};
 
 	reg_pcie0: regulator-pcie {

-- 
2.37.1


