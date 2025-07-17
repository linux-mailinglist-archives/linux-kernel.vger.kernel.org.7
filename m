Return-Path: <linux-kernel+bounces-735804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973DBB0940D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF0433A2D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D3C20299E;
	Thu, 17 Jul 2025 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KHJOQrg9"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06782116E9;
	Thu, 17 Jul 2025 18:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777281; cv=fail; b=IoTcRUShWHa1tmp/hj3d7e7oZgsZjvzn8eR9WjwC1C2kCYBy4tKWUH4d7twpvqPIWbxM52KA0PksSO6eaheIL9HNJAEU9ycA7HOFE1M49jFgm8VfIwhF1j/AdR3EF8OSrqwKEoDN887U1gIGh3Y4YisAANMn2vr4Qf+JeNYontM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777281; c=relaxed/simple;
	bh=mr5XZnYhGEk0klyLrkYi9GB2bER3+xIaW/5C5OjtMUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QcArdJGSlCekvvQo+Se9GcMRE+kw1O2UZf4pZCNTZ2f5VKNPTM+LzfjG/mMkTXvOMdssP2rSIOkNDYitugJst9gRONUt/y9NyPmvIL4AV7OC+wlSKfZPni/3ssXyKHWwFgg3XeepqQRHaRolLCwsxTpGCPfgYe+L8iBR0J3hztU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KHJOQrg9; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfDQ4C7MuFeCGI/wSageygnzu4bRvGT41HqA7w+7ismSs14TQ7f4luUoabg8tyZb28I323JMQhpk1hm8Fjsden/03oHSCcfgcHKBaEjg2v/05QaCLQGeC2E0P47yZwhi6PwO4KZvfs+tddAGbmNcOEfyGjqY3BwEQ2j6qPdYR8yNiJsuT2d7Ee39wnvQYZDBGtVw1I4eKR542DLN2/4dKCdrpGuBAxASD3uaRgMUUcQDhOT4ho20hBqs1TBwW67RS4YvLFCIiErjYjz4zCh0bb8SariYs4cR1rtZDxdhcbZO+BlNYpThPEoGzZROlecc3ilWp2/jCZbznrI9kvXKQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8f67fBDrkti8g7bxxl+kHF/q+hlJ71mNj1YqtCMVLwE=;
 b=fO8lkK0Ve5D6l89wU7VIFNGKbSPTQqDr0SG2Xs8CyePJFYUTgs2iacwULYsnnOhNfRpZc3Lu2hc9lUsbcRLHfFdSd4W6KM+zXJxpm39eCuypfvnt1loCqCeTX6YGy63xKR67klgcPcAlHWuy2xgcCdTEdnX7wQTqv/eEalOHblJCb77IODwCVa5STdzvGKBK1rH1rrEpfhohJyDFjUJ7RdO70Fv6kXEB9SCxhugZfbtCY7NeMdsIQz+EC6PzpoD+aGwug4rF1ud/AkbBdOAaCeWah7fqPIJQZp1nTRrFMea95589bKikK5g1qbcWoYKtj+k8qeSNBtqKgDHfji6SDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8f67fBDrkti8g7bxxl+kHF/q+hlJ71mNj1YqtCMVLwE=;
 b=KHJOQrg9ucRnIKXeSXXuzCoUV0FOMX1+9n5WOKmuhGHbq+WoupKxdasD+sI0+H1Ib8T9vV5ve4u6Y911vqM7oQHKw5fO5XmSRCc7lep5Re/Dpo9ODg7fyqT8ZN4JhJHTT2So6GJVw1Z9xJLy0eBscZ+obGCB6IYNi50AjHdRTWDgCGBk5EVUX6Ltu5PGeZuNSwmCFMzWHjubQg82fPl+lxozxjXkzRzi8DGXucBgmmhk0SSSv0esg2q5ppCtlMB1OQtjApX0HJ2R3g4YfkKdRneYVEyCxpsvkfHmGc+v0ErvCxtVqIlc2V9iC1RZi0RicO846Zu+Npz7pdf8+GHgJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10576.eurprd04.prod.outlook.com (2603:10a6:10:58a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 18:34:36 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:34:36 +0000
Date: Thu, 17 Jul 2025 14:34:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Jorge Marques <jorge.marques@analog.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-i3c@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	gastmaier@gmail.com
Subject: Re: [PATCH v6 1/2] dt-bindings: i3c: Add adi-i3c-master
Message-ID: <aHlCOD/Xjw0Z/Y8h@lizhi-Precision-Tower-5810>
References: <20250717-adi-i3c-master-v6-0-6c687ed71bed@analog.com>
 <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250717-adi-i3c-master-v6-1-6c687ed71bed@analog.com>
X-ClientProxiedBy: AM0PR04CA0095.eurprd04.prod.outlook.com
 (2603:10a6:208:be::36) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10576:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0b96f1-85d6-462a-d415-08ddc5609509
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|19092799006|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OTRoT2JGNzBFMm1aVmV1bDU0NW0vd0JvZGpMOHorNytkS1ltejZ5dVZ3K3lH?=
 =?utf-8?B?SXJ4d0ZCQXhzdmFQU2NXbTZ4b21wcmtCbC9uL1RkQ2cvQWY5c2FGTitoamdu?=
 =?utf-8?B?dDRqMWt5Sll2dXQyUWdrTjcwWitHcitQdGxCWUJ6TDZPdElPc0lOdEc1K0sr?=
 =?utf-8?B?cHRXNmh5amZxenBhY0JkZmxrd1V5YW1CVlJ1RnFPaTdFWFkvSVBOeWFjdG82?=
 =?utf-8?B?ZFNlU2djc2JuMVhtQmZTL05QS2d2RndNUWRDNkJvNGhZdnpid3lYa3QvY1FJ?=
 =?utf-8?B?QkZBVU40TEFIaGZwaThYMmFTRkplQ0IzUnBBNFhXa3Nub1BYa1hDazVNYVl0?=
 =?utf-8?B?d3A0cy93UzM3VnRaSWxlQk9DZ05SQ0NDelJBZS9FVmdZSVlURzFpMGpZWFdp?=
 =?utf-8?B?QUk3ZjRSeFZKeDdVVjl1bFFiK2wyWFBKcmErN0dpS0hTam5OZkE0VXo2V0xm?=
 =?utf-8?B?ek1ocGFrbUtUYjB4Nkp0SUdBK2JITzZOSnB1QW9lNDVEbzdTVGlnVEpCSkUy?=
 =?utf-8?B?Wmw2WWNQT1VnTUlnMkczNjhHd1JSL01sSW5Ra3d2Z3NtQjRqWW5jV2VjL09m?=
 =?utf-8?B?aktTNzZ3K2Q4d2t1by9IU2F2UGNEeFZWdVZlallGMXluTCtPZUdVY1FIaW5R?=
 =?utf-8?B?T3BJZmlORVlaNFlFbWpqVzROZ0NiakdIR2JVVDdyWXVyVU83ZWJPWjN6bW5K?=
 =?utf-8?B?TEM4WWV1Sm5QTkd5WVo3RldINGloYVBBeHYzZ010TlhDaG1VVGRFaXk2UUhC?=
 =?utf-8?B?cWxaMy9lOEdaNSswUkgyT2p1LzNnQUFSRGp6QVcrK3ZwcnJMQ3VncmVpRmxk?=
 =?utf-8?B?Q2JFOEVTdHgweXpwbmNJL1pWc0xad2NMUnJINzNWMGlrY2RzRVpLcUxYL3Fw?=
 =?utf-8?B?NzNldnZQdGJyV0VKc25PWFhzVW9kTk8wWFlPNXBtQzVSWUVDV3VQc1c4ODJO?=
 =?utf-8?B?cmVRL1JLMVJMZk91bWJiaGx2R2VjbWNXbzlwNFkzYXpGVXJCK0o1bjhkZnJQ?=
 =?utf-8?B?OEZUUHJYdDJFK3hYMi9BZ2lOSnFhT1ZoUFczREJLdDdHektnQ05IeU1oQVhw?=
 =?utf-8?B?ZHk5UStyWk8zYVFZbVlYZVg3QUxCekdBNWVJMTlzNndTN2E3Qk9OWk1kUTNz?=
 =?utf-8?B?UFlzMG84UDRtNkEwb3g1N1I5VkMrMDF4d3dYb25TejlnR3crZ2Roa2h1ZFFq?=
 =?utf-8?B?ZFU2bEJmTjdVUFVOVVJibGtDaTFFVUowR2hCTWRRcWpGcDBUU29jSStnUElq?=
 =?utf-8?B?NUlITFl2RFZuVUd3ZWRxSEdQTmJWUy96MEFyZmUxN3NkZFhaeGhIM0ptMVlH?=
 =?utf-8?B?akwrMmV3bFV4SFVkZ1FEcSt0bVlsaU54UzdsdUFQa1g4MU9rUzQyQWdPTVpC?=
 =?utf-8?B?RVFTNlh6T1BDSE56S3dBY1R2dk9oOHlkcklHbmFmZGtPRTFPeExzOWpZK3Uy?=
 =?utf-8?B?Z1lra0FzeGpQRWMxTjI1bEk0M2FQN3N2ekRibFc3TCtMZndMd3RNWCtvYlky?=
 =?utf-8?B?NkdJalNvR2hMWFc0MzBydHMrd05WWllxUVJOVjAyZ215ZGcrM053bENQcDhn?=
 =?utf-8?B?djk5MTBBRnpJU1VtTlZTeEFmY2hCc045WENlSjBVQkp3S0JBM3d1OXB5Zjk4?=
 =?utf-8?B?a21QMVljRkpoS2J4emxLd3hpWXJHblNSSE5rbEhWWk43cDlVL1NRcXU3ZTlj?=
 =?utf-8?B?dVZvUjlGWG80dFBWYzZaSk5tSm5xZEQzdnI5cjlWMTVtNThHK2o0Ym9qL1RN?=
 =?utf-8?B?VkwrZEc5QzdaMWlKR0p5ZVNWeGhJZ1ZkZEFESlJ4Q0N1akQrVi81bUNEQXNj?=
 =?utf-8?B?U0pETVBYSXN1aWZZcy9vRWlQV29NeUlzNUJpQ0xsV1phcHFwSFpUSlhlK2ps?=
 =?utf-8?B?YjhXY3N6aE9hQ0JvT3BESUExblA3R1VHcW9LTlNhOU5CdUdZOFRmWEFObkFJ?=
 =?utf-8?Q?EbvFq9CJCi8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(19092799006)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1NDdkdaMmJpYVBzYjRjZ0paYjZnejBLeEhBaVZwaTZwSkZ1QjZvRklOSWls?=
 =?utf-8?B?ZE81WnhZZFZxTWlZdG51SjVHOXZiSnFkaTRuUG92V0Q5bmdrWUNwRVovbC9G?=
 =?utf-8?B?MVAySkh2RGNSMkF4RzErZnRZcm1GdFFzcHlDQTR4NHppVHp4UEd4NEFiMzYw?=
 =?utf-8?B?ek5FU2g5bXVvNjZyeCtNVThkaUFQaDl4MUpJSHVCZW9NcnB0N1BIcSsrN2VE?=
 =?utf-8?B?a0QzaVJ3Zy9LeVc5Ui93SWlydTNvZkY1ZExQbjVQNndLQ0xmS3ZLNldpeUc3?=
 =?utf-8?B?NUhqbTFmNFc5WDNKMyt6OTQvcXltdTVWT2FiVzBybkpEZkFjVk9qUk54aWxW?=
 =?utf-8?B?SG11d080d2FCZ0l0NUNGeFZqdXNwWUtRd20rM3ZvcjJrc1BhTThUQkkwd3BB?=
 =?utf-8?B?Ty81TDVtZkxhUnZlVTV1RGtHWkp6a1V4dEowM3pFQWZlYW4vSnhRbnR2MGxa?=
 =?utf-8?B?Y2MrVWZTUDQ5eXBEK3NPZlVxbWVadGJ4ellLTzZ3SnFSRHhPZFdJTG9QUVZS?=
 =?utf-8?B?WFUzWVNKVTgwRXJzbGUwelZmR2NWZkN2SWRTdVZ5THN5ZjczaTFXQzV2MXVP?=
 =?utf-8?B?N2hEcHdIQTVDVUJJOFh6MStyLy9PQ0hrSENlQmJIQ2ptNHI5KzZZaldrTk5Z?=
 =?utf-8?B?WjZRVFphZ3VQbGJCNWpQS0lUZG1BNEFMaGdvWlZ6a0Nja04wcWRTQm42UTY3?=
 =?utf-8?B?NUhKMHdKMkc1MEJ6SXA2Rzd6RnJIb2JrUzZWaG1CUEQrOU1qOHVyZE5ldDZj?=
 =?utf-8?B?a0hkL1l4aFYwbGlwNkdTTXgzM3dpZ2pmTTc5ajRIMFpoTnZ2QUIwNFJSN1Js?=
 =?utf-8?B?YkxweWVHeWFHay9WczJHSWNsaHZ0anNTSmR5V29xMlAvNmdBT2FRNXNrY0ty?=
 =?utf-8?B?RkhRVTZMMmJJTDN3anVpTEQrMkVXVDJpUGc1eC9KZjgwcDR6RmFobVUzQXFi?=
 =?utf-8?B?WHlSbVZkSkdVQzM4Y1pVSVg4RVY0T09OQmpLMkhiQWs2VTNPZk5aNXM4U01w?=
 =?utf-8?B?VEgzTE9YMDk0d2dhS245U29EL1doaWZwbGtvZVpUam9GbSsyN0NWT2VhUFZG?=
 =?utf-8?B?Q1Y5NXVaNTYzSGt1K2V1bmxBdVlNNm5nUGJUbEVhd05FMHllRHZwaDhVL1ky?=
 =?utf-8?B?VEZrYmpYenl3bklSaGpXV2p2Z1RTMnQ4QjFSZS9LNElEWUFsSEtKZ0JxRjlh?=
 =?utf-8?B?d2dkRmE2UWdGdXpraFBCTml1bGJieG1tcThkNVVjNkpjZnY0SWFxNitRVU5F?=
 =?utf-8?B?b1pEbkdDQjBBeU5OaGJMckZpbHl5ejlRMFQxZ3lTTFpRZWM4OWZuSThXblN3?=
 =?utf-8?B?YkVzUHA5VWNpNmlLaUlTMGtxb3k2Q3ZDSWNWTFdReGRuVG1xUW5WQTU5VDF4?=
 =?utf-8?B?c2JHRk1NY0l5emxWeWx3dExSMDVaOVppUXpKanp6QW4zM2IralNubkN2aUZU?=
 =?utf-8?B?RzRETFZRYWtraTI4NEtTOHZOdC93dS9TVTYrM1RNaWJ6MXBZeWdhL0dmeGNG?=
 =?utf-8?B?U25mUldsMlQzNUlQaTZLcXIwc1BmeXFzVzFMbitIVmtoTVpwZm92ZCtsOS85?=
 =?utf-8?B?KzUzRnY3ei8veExkOFZ2aGF0aGRkZ3BQN1VYWkowaHVIZ1d3NkRxSmMzQmtr?=
 =?utf-8?B?eE01R3UwU0cwaUt1cXJzajlQT2tUcEFWNnVUVWorNldjUWZlc2pkVlA4dGlY?=
 =?utf-8?B?K3p5UDFiMlE4ZTVRL3U4UVRmK21NZE1zK1dDYjRwdlNNaTA5bisyNzJnRFpQ?=
 =?utf-8?B?NC83ZVZNUzBsSU40ZndiQ0p2R0cvWTNUbWZwMEdQYWx1QmFvUUErYm9RcHVt?=
 =?utf-8?B?MlJYR2pHMW9WQy9PR05TS3YwQW1ja1VJQ3R5bVRudDlQVVhPUTlVTTRsK0Fq?=
 =?utf-8?B?cHY2RkZjcnpnOFJ6R3FGbXQ5U2hBTUdYSjFMbDB3bk40RWNRK3Zya2xLYkxa?=
 =?utf-8?B?NldmRE9IWnlLSGdQNm5PWWMvSnpmOHhaekphVHE2L2RhN0V0MS9zNnFpRXFo?=
 =?utf-8?B?eXNwVkxZKzhKZnRUbkREWndERDhxanl0aFpmdHNiSXBhQTNnVFdzSHU5U0ha?=
 =?utf-8?B?OHZRSTNFVXIwQmtGdmN3TDlWaENXSjBlR0d5UlpVQW4wU0ZNWmRzOXhXNGtU?=
 =?utf-8?Q?5CCxijq5Ye/LIgYVkF7GBNS1N?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0b96f1-85d6-462a-d415-08ddc5609509
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:34:36.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDkw3ESJsrKDj6FeSTAKVL339chnMVl/h7g1jJ3uz2rl/LxXUTmuNvs8gmoDBWHA7guOtkwalDKtnTp+g+MEQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10576

On Thu, Jul 17, 2025 at 09:09:20AM +0200, Jorge Marques wrote:
> Add bindings doc for ADI I3C Controller IP core, a FPGA synthesizable IP
> core that implements the MIPI I3C Basic controller specification.
>
> Signed-off-by: Jorge Marques <jorge.marques@analog.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  .../devicetree/bindings/i3c/adi,i3c-master.yaml    | 67 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 72 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..8f532386de2c05d3d514d41ff4d6a37ec840674c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/i3c/adi,i3c-master.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices I3C Controller
> +
> +description: |
> +  FPGA-based I3C controller designed to interface with I3C and I2C peripherals,
> +  implementing a subset of the I3C-basic specification. The IP core is tested
> +  on arm, microblaze, and arm64 architectures.
> +
> +  https://analogdevicesinc.github.io/hdl/library/i3c_controller
> +
> +maintainers:
> +  - Jorge Marques <jorge.marques@analog.com>
> +
> +properties:
> +  compatible:
> +    const: adi,i3c-master-v1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +    items:
> +      - description: The AXI interconnect clock, drives the register map.
> +      - description: The I3C controller clock. AXI clock drives all logic if not provided.
> +
> +  clock-names:
> +    minItems: 1
> +    items:
> +      - const: axi
> +      - const: i3c
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +allOf:
> +  - $ref: i3c.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i3c@44a00000 {
> +        compatible = "adi,i3c-master-v1";
> +        reg = <0x44a00000 0x1000>;
> +        interrupts = <3 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 15>, <&clkc 15>;
> +        clock-names = "axi", "i3c";
> +        #address-cells = <3>;
> +        #size-cells = <0>;
> +
> +        /* I3C and I2C devices */
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d5a173e987c06d75848d112339e39966f2b71cea..1f212529276f4ab28f4b7d16b4105a8cf9ff5e2e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11452,6 +11452,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/i3c/aspeed,ast2600-i3c.yaml
>  F:	drivers/i3c/master/ast2600-i3c-master.c
>
> +I3C DRIVER FOR ANALOG DEVICES I3C CONTROLLER IP
> +M:	Jorge Marques <jorge.marques@analog.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/i3c/adi,i3c-master.yaml
> +
>  I3C DRIVER FOR CADENCE I3C MASTER IP
>  M:	Przemysław Gaj <pgaj@cadence.com>
>  S:	Maintained
>
> --
> 2.49.0
>

