Return-Path: <linux-kernel+bounces-873780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D99C14AD1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 13:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 092804E28BB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD9632E13A;
	Tue, 28 Oct 2025 12:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="r0z/BlY0"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023135.outbound.protection.outlook.com [52.101.72.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D3D3054DF;
	Tue, 28 Oct 2025 12:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655420; cv=fail; b=shzlYtgUZGvtsj/lcG/1QvXp03PQSxULMz+7CbprNOENcsbU5tVTeyabz3qQaQ/fdRc+K98UYO4r25P5VwixZ5/tjW54NZ+akqNaxYTz5gnJH4fxuo/rWdaXfl4Y6ZNIwGKhtYu3OFaQOgl2UF6PuziP/n72cOS/ouEsLWihK44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655420; c=relaxed/simple;
	bh=ugOgjXNVbAbx70/ZQcfuuHWLFQAZa2IAcTaQ+q8dePU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRgVjFadEbDo9erw+z8yIKOZEQhKZLrOeV2hp3BA4B7Adz0GwmcfZoA6nsldFSSKZyzIk5xbHt8aJ34ihoGq9/nRIWzFT4k2lk2stGJl/N6AJQglkc3EM4+XdpUveK9oGWg81pHzMZNIIVzVC4KgK5f526nnYSCrbXhXu/a4Gak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=r0z/BlY0; arc=fail smtp.client-ip=52.101.72.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lURdpZAYICGJzhPQfD3qoeFz3klWG4ZBvq4NXCi9/hF0AFAVy8LFtZPx6OE1Z2V/XXYlyIkBhsSem0JBNPmgNmH9MW42jVVS6uniZLQJ7Zf/qECtkUGM6PTeAbBgbgLQz1eDZHjuCsYQ0fh0GLW49R7yUn7ok1SNCp7110PAO/SyM3nqd/27rMojbq60IU7Y2+lMteGYe3JCAk4rWZOLt0cpqHVT8czL3p44bWTmcRidAh87KmvuqCrzuhDsEF1CUP1allqHA4YvfC/g4h00URHjE70BjIbvrQ01iHOe1P1xPigAZCexO4HJdIC0eHIJ6OndVF17XeyXJIxdFGGD5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kn0NkZPy6tdSybcs/tuLwnQLewfxRgO3CbHBxH9kTaU=;
 b=i3jqDkbpVm6nhfkpIleM0+qZyAeZBZLFGEifu3Hqc4FcVNsV+LRGttCuNU9IGHa9XMAB4/SwmXXLtzAWKOQhj47nwwUYOr0dNUxzKvefufpdOJDZ35lN22ATRRCM62TANucMNyhTZAQbI3f8+1S9xOWif7osdh0eQP4Sy0ogU6H9OuyKkXuaXFj0qoFMm5Dp1s/t3Ftn0rzyhtjMxPu4upIMR0hrhqwTrb5ZzRSMhcMMqEtUDPevt/LNYEffUTFAhMq4/rVnUpR6E1CFO5XFWcuWB2O2EuQYfINvmRsCxS1Mo5KnHLaacjQaHkQsIf44+mbTrhm8AEDKuXP4X0q7Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kn0NkZPy6tdSybcs/tuLwnQLewfxRgO3CbHBxH9kTaU=;
 b=r0z/BlY0icCaJTCoE03oMKpgboeVdYbZU6PEfmom2peG2VRE+CJXVKRUI2jCJLV9Jk7NzTMeDaUHSUewGv2WtnM7LCsCYx7I1kMpPyhtL8JXk+CHeXNcayG1sN62653NyFereVgBbdwJ4meYNbkoLHb1C6fZE1zBOPplexntPb7DCaIUtFYoMnXGdvmTOHBMSAg1lL7Odt1G0lNvOjZz5oqnSS8HXhp2MIQQFO7RxL9MruWvhXeL2jT3mRixoQGQkuJT30DCvSLYWU6j0wsSKaKLFc5k6FVa6SEUvZTusI2bMI5YH9x5ksPZ+EZGcx9GMrCZhXNxqaXaSppO6gwqNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by DB9PR04MB9818.eurprd04.prod.outlook.com (2603:10a6:10:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 12:43:32 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 12:43:32 +0000
Message-ID: <65202d1f-6c4f-4d4e-9fef-85cfb74ec768@gocontroll.com>
Date: Tue, 28 Oct 2025 13:42:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: freescale: add Ka-Ro Electronics
 tx8m-1610 COM
To: Matti Vaittinen <mazziesaccount@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <20251022-mini_iv-v2-0-20af8f9aac14@gocontroll.com>
 <20251022-mini_iv-v2-3-20af8f9aac14@gocontroll.com>
 <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
Content-Language: en-US
From: Maud Spierings <maudspierings@gocontroll.com>
In-Reply-To: <a7012995-c2a8-48a3-abe1-5c227272f21c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P192CA0037.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::28) To PA4PR04MB7630.eurprd04.prod.outlook.com
 (2603:10a6:102:ec::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7630:EE_|DB9PR04MB9818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5454b1ac-a8a6-4071-8600-08de161f9a30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUVKYjFxN1EvdzkwNENCb2hYMmUvQWU4R1hOQVltbnFrSGt5NU5QK1pJQnRv?=
 =?utf-8?B?ajFXaTlOOEZBbkNXSG5nc3dtUzJxeCtPZVYrN0RFOVBlQnJlS0dmVEF2Zm5D?=
 =?utf-8?B?eEptODlKaVNFa2FiV2djcUZSRS8yK1doSnNwQnp0eWUxMjhWTGNEOUpGZnkz?=
 =?utf-8?B?cGNwTVhNZkYwVmpCMFVlT1d5dlBBV1ZqNGdpOFdnSW5JNk9jZGtmeW0vTjdq?=
 =?utf-8?B?N3R0cGM3aWhHZGF1RWRFVEthS09CeHRMaEIxM256RUZtZ3ptaWFCYnhGQU9k?=
 =?utf-8?B?eUdIUjFXTVFmT3MvNWVxeUs3Qkx4bm41TnRFU0pzb3BKSloyWWlhYkhHa3Ex?=
 =?utf-8?B?cTNBRHk1Nmt5UEFXQWdGUjFMODhsTFBma1NOSldXbnFkL1hvRG9sYlpEUXZs?=
 =?utf-8?B?RVFleU5Wbmc3aDlmZGdSNnBJaEFoTEkyUUpkVVNVa0FYZ2dDRTVLbC96ak1m?=
 =?utf-8?B?YkRSNW9qSTNtYWtWSEF0UFZyalIzTW5uQ0lnanEvcDBESU1qalJHRnkvRkdC?=
 =?utf-8?B?Nkg4MVRSUXNUazZKVlpCdVBNaFJoTFoyOFhRa2E4T04vQkUwalBkL0M5RVE5?=
 =?utf-8?B?SUNzeGNpRENlL3B6U09tM1I1b3hXLzZYNG1TZEphcDdWL29vSU1VR3pzcTln?=
 =?utf-8?B?dkNIQ1BLQm9mNjFENzVUQUNtMEp4ZTJ3SldlbTZZU0w3V1VUUzdKeWZxNGV0?=
 =?utf-8?B?dFdjTktNRFlwZjRSdHlHb0U2cGFPQ0g1NDNZQUJPUFpsVG9hekk0WWl1anI3?=
 =?utf-8?B?MHd2aERwNDJXRnRCbzA3VlgzWUYyR2daYms2a055RENLVVJJSnpsQmxqYk44?=
 =?utf-8?B?RzV0eitCS25GcGRIQnlMd25qQk9hZm1NTGxqT0FWZTc2R3VONWhDbURWazZy?=
 =?utf-8?B?dEJRWEJlZGlLdVg3ZDMva3JLN1ZIT0pwK3kzRWdWMk54Z0FPRGd2U013Zlox?=
 =?utf-8?B?dWNNVXlyL2ljdTJwbUVXZFpaR3pyRlduZHpvNE1yMlo3SUhIekFoRGpQNnFo?=
 =?utf-8?B?VkNWemQwSnczbUM0QzZuWEhSVWh3OXhUaU93M2xVWWZKM2JNM0l4ZENFVWZF?=
 =?utf-8?B?L3FUdHhCY0cvWkw4NFBXUk5FS3NNcHBvS0FjaVRUQkdQRFl3L0dhczA3S052?=
 =?utf-8?B?TDdCZE45VGk4T0syRCtxRnhDbk9Nc3dPM1hoYjJpL2NKdjFaTW8xQ1NJaFBv?=
 =?utf-8?B?cUo5VFdndlJXSkREcUo1ZU5KbzZTaTFDYUlBKzBRc1BSVHRudGVEeXFTQlp0?=
 =?utf-8?B?eU1kQUlvL3BSY2FBL0VFTFd5ZDZndUlwUE4rditSbXpTU2JFWkVaUUxKbE1K?=
 =?utf-8?B?aEdyajJxMWhBS0ZacktqOG1wV0VKSkJNdXFHYTVzTU5EcmdJeDBqUjRRMy9u?=
 =?utf-8?B?NTY0VS9EZmYzMGtKcmhIbFMxM0luLzZ1RWk4N1RhUGdKdEI0REtCaGpPOWxu?=
 =?utf-8?B?Z2NwaGQzcldhVmdIbHBwS0pQTU1BSHBiN3k3YjYwODkvQVZuNTRhd0RYYVo5?=
 =?utf-8?B?R0tybFlVcFlNNHJnQ1BMc1pjaEZNNXgxUEllYmlETkJudzhtWkpKZ0orOHBH?=
 =?utf-8?B?VjhHMzhDV0pUMkZVRk4rcURremFFVjl2elBMOEpRNlFDQTdyQ2pYY1NyTUxC?=
 =?utf-8?B?U0NPWlNqQkpOSU55WmNwcnIzQlRuQXBKM1RaZ2ErM2UyaE01OS9BdjhYc1ZX?=
 =?utf-8?B?dkVMajhQN2RXM0l3Q1MydE1yVzgzaUxLMmVmcHNCOUJ1NzFyYzNaUDBMMlRO?=
 =?utf-8?B?ekZFMGcveTRHNjJRelNoMWdCdFNTN0d3N2hqdHg4YlNwK1h0RmVIdTRGSlk2?=
 =?utf-8?B?Z010VHNucmlJaXQ5Y3BwdWMzTmFSc2VHaE82bnpzWGNxWEUwVmRGZHkxRWlZ?=
 =?utf-8?B?UC9VTTJWMm1Ub2tOL3MzQnhHc3hRQVV3Y05JN09ZaDArM09kZ241MTNmQ2tW?=
 =?utf-8?Q?S5HpYM6azINGaHJW+31RYizxxnmBZJOf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z3BmbVVnSXl0ZExmU0Zud2p2ZEo0bUwxRGZhUHJYOXJPTXhUQkMwVXUxSzZP?=
 =?utf-8?B?aElYbE5EaUtEQlZVMXJZbG1iZEtEVEhVeTJkZWFRZEllbkcxNEo3VE14U2o4?=
 =?utf-8?B?WlRCN2FYZkl0SnRzWStlV0RxanpCQnBSaGRFWlJvMjlMMlZSMGNBWFR3L2dI?=
 =?utf-8?B?T0RwRW5hMmlsU1F6bVdkdEpieUh5RE1XRUlMTWJ2UTZqYk8xeGExT2k4djJj?=
 =?utf-8?B?SHp3cXc1eEVLOGc2c1c2ZTEwNWhxYVovWXM2dC9Tem9jc1RaQnI4Z0F4bzFu?=
 =?utf-8?B?NXpMVnRnbk12UlFpSnoxT3VjSnczREM3d2NyczlBUHdjeG4zYkk1eVlEME1F?=
 =?utf-8?B?c2ZCK0VEbll2eEM5TG9helJFRWlsVkUvY09Dak5qMElXQkpWSEQwbkVYMzhI?=
 =?utf-8?B?QVAzWTYvamNWUnZ6K0pUMlgrb09PTDNSZjQ0OVFqYzFyM0VMUjRXR1l4cjNT?=
 =?utf-8?B?a3FlSlYrVFBNMDBzems0b0FvVlFSTWpYV1psejhLaTFhTFdoT2dHaVY2bDFo?=
 =?utf-8?B?U3Z2MjR4djd4L1NQQi9veVFpV0xTVU83eDljMGN1MEIrMXU0UXFmblJtK3Vr?=
 =?utf-8?B?Q3JrWUhvSnlTY2dmclJIT09ZVXR0bm1NTGtJaThKeG9VL3VVOURwZkJrb0Rj?=
 =?utf-8?B?Z2YwS2krN3RHNzhmUWR0ZjRUVGpUdWlpYkl3SDdFaW5VaFo5cDA2RFZ2enVJ?=
 =?utf-8?B?aDJwL3FMNGRJYlVTME9jZXNHbDdVaW5HakhnaU9QTG5YeXluVlJ5NThFd3l4?=
 =?utf-8?B?U0ZobnJYSlFFZ3FHaWpyYSt6SldQVHZHK09jL2U5ZUpFMjdJeVV2bG5DUHQ0?=
 =?utf-8?B?bXRYOE9LSUIrU0V0U2tHYnh1MmkvZmMraklNUS9LMjBCWTRCbzJjQ3Fxc0pU?=
 =?utf-8?B?RHRTK012aXhuQ2hZNVg3ZStHRmp6VjYyTEQ1RWhHRlJwUXZ5MWVaZEtiazNa?=
 =?utf-8?B?ZWNFdEwvS25ibStoRHZNUTNEd3d3WThtU0lOcW5uZW1TS2htUHJrdDg5d3Np?=
 =?utf-8?B?WTBvaDNMRVVra1cxQnJQWjlOSzNIbmhxU0t0enpKc3NxSXRCRk5hdDlONUhW?=
 =?utf-8?B?N3N5RHBXTlNzUjBLcSs3L2lSbVNuQnNxNUpvVHZhcjU0TE1vbXBWUVRtWWxS?=
 =?utf-8?B?SmhLQVZram9rWHNxTDhpZUpaTUZob01GZ0xKRFkzQytiT1NCcU4vaktoc3gr?=
 =?utf-8?B?SGN5QUM3UUsxTjhmRVUvVGVBcXQ3UkZiV3l3eVVYa0VIMi9UYk1pQ3RaZEpz?=
 =?utf-8?B?U24ralNGLzQyTkpuNTJsalZnYjJPdGdqc05PZUFKRE51Z2hNMmFYNGthRS9l?=
 =?utf-8?B?Qml2U3MrbTY1VTN6YW04U1VCcnlldUloT0tvb3RhZjdjNVRNZUVTUzl2NldY?=
 =?utf-8?B?clQ3SGhpU3BOcFU2RDBnZUFsUEJsMy8yekQyeHc4OE9nNmtsMUw0UGNZdUpE?=
 =?utf-8?B?a0ZYcjV3VDhtWXY0d1NJZVVVcGk3Z3pVU0krck4wblZxazExTGFRQyttTzdy?=
 =?utf-8?B?d0E0NHVtOGZkK1U4NnR6V2JoNVd6bUs3c012bFRNWGR6eFZJTEdUU3Z1N0Jm?=
 =?utf-8?B?STJaVER2ak5ySVNwU255L3ZXcEdHTlN3S1d3dXNpeDFPMTBiV2p2OHQ3bGRL?=
 =?utf-8?B?M1VtQnpwZWk0QmMzU3dEa3N4dncrV2c0YUpWNEFaUXVpRHI1dUliR3hxS0Nj?=
 =?utf-8?B?UG5kY1BPUWtmbUNHYkxJQ2I1cVdkQzBuakZUWHQzU1ZYVk5MYktQOWcwYnpP?=
 =?utf-8?B?Ym5SKzRnWktnUWFWb21XbFdGcElELzg2b0RQMHZUUFg0clJNNC9qbm9ONmpN?=
 =?utf-8?B?SFJpSEJPV0NVc0tXUHhnSENNc1pVbFNrN056enp3bTRTTlV0S0FDOUh5OHhE?=
 =?utf-8?B?UXRNNUNudWtuV1UyL1RvNW9KaDNtYUdrMmF1YzZtMVFINUk1dW01S3F6Z1VM?=
 =?utf-8?B?YlZkUlp1SjltOVZSOU9weGRkMVFMZmpyejEzanFtdE9icjcxSEFDY0c3cmlP?=
 =?utf-8?B?ZVQwN0pRSVlrSXFRMkJabzFRZmRza1pBck5YL0Npcy9TaDFSV001bFFCRSs4?=
 =?utf-8?B?UEVnK0E0eWhDQ3U1eHVtMG1ZQUVMN24yWjUxalFmTkc4Vy9saUJ5eWZBQURq?=
 =?utf-8?B?dmxMUCtFOXJJNWNVUW0vRmM4VmlMakZUR0ZsZnNGOHNuNkZtQ0M1L0tWTzlv?=
 =?utf-8?B?SjZIR1ZDZEJBbU9UR3NQSkVwMk95Y0t4dTFMSE5SQUdpcUxTY2RUUmkvbXJz?=
 =?utf-8?B?cWpXZDBWZUJEdnFONi81TTkxelRRPT0=?=
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5454b1ac-a8a6-4071-8600-08de161f9a30
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 12:43:32.1644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kltk6ew1TjkkEAVklRrXeavXLkbont2FLLGzAJyUXDnt9Jgi08THPwKrEABtrgD3ixZxxWKW2PpdbShta/nYfkjHs3X48nsNj/TOnoArFgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9818

On 10/28/25 13:15, Matti Vaittinen wrote:
> Hi Maud,
> 
> Thanks for the upstreaming work! :)
> 
> On 22/10/2025 10:22, Maud Spierings via B4 Relay wrote:
>> From: Maud Spierings <maudspierings@gocontroll.com>
>>
>> The Ka-Ro Electronics tx8m-1610 is a COM based on the imx8mm SOC. It has
>> 1 GB of ram and 4 GB of eMMC storage on board.
>>
>> Add it to enable boards based on this module
>>
>> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
>> ---
>>   .../arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi | 439 +++++++++++ 
>> ++++++++++
>>   1 file changed, 439 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi b/ 
>> arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>> new file mode 100644
>> index 0000000000000..46d3ad80942cc
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-tx8m-1610.dtsi
>> @@ -0,0 +1,439 @@
>> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
>> +/*
>> + * Copyright (C) 2021 Lothar Waßmann <LW@KARO-electronics.de>
>> + * 2025 Maud Spierings <maudspierings@gocontroll.com>
>> + */
>> +
>> +#include "imx8mm.dtsi"
>> +
> 
> // snip
> 
>> +    pmic: pmic@4b {
>> +        compatible = "rohm,bd71847";
>> +        reg = <0x4b>;
>> +        interrupt-parent = <&gpio1>;
>> +        interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
>> +        pinctrl-0 = <&pinctrl_pmic>;
>> +        pinctrl-names = "default";
>> +        rohm,reset-snvs-powered;
>> +
>> +        regulators {
>> +            reg_vdd_soc: BUCK1 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                regulator-max-microvolt = <900000>;
>> +                regulator-min-microvolt = <780000>;
>> +                regulator-name = "buck1";
>> +                regulator-ramp-delay = <1250>;
>> +            };
>> +
>> +            reg_vdd_arm: BUCK2 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                regulator-max-microvolt = <950000>;
>> +                regulator-min-microvolt = <805000>;
>> +                regulator-name = "buck2";
>> +                regulator-ramp-delay = <1250>;
>> +                rohm,dvs-run-voltage = <950000>;
>> +                rohm,dvs-idle-voltage = <810000>;
>> +            };
>> +
>> +            reg_vdd_dram: BUCK3 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                regulator-max-microvolt = <900000>;
>> +                regulator-min-microvolt = <805000>;
>> +                regulator-name = "buck3";
>> +            };
>> +
>> +            reg_vdd_3v3: BUCK4 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                regulator-max-microvolt = <3300000>;
>> +                regulator-min-microvolt = <3300000>;
>> +                regulator-name = "buck4";
>> +            };
>> +
>> +            reg_vdd_1v8: BUCK5 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                regulator-max-microvolt = <1950000>;
>> +                regulator-min-microvolt = <1700000>;
>> +                regulator-name = "buck5";
>> +            };
>> +
>> +            BUCK6 {
>> +                regulator-always-on;
>> +                regulator-boot-on;
>> +                /*
>> +                 * The default output voltage is 1.1V, bumped
>> +                 * to 1.35V in HW by a 499R/2.2K voltage divider in the
>> +                 * feedback path.
>> +                 */
> 
> Could/Should this be described using the:
> 'rohm,feedback-pull-up-r1-ohms' and
> 'rohm,feedback-pull-up-r2-ohms'? If I understand the comment correctly, 
> that might allow the driver to be able to use correctly scaled voltages.
> 
> https://elixir.bootlin.com/linux/v6.18-rc1/source/Documentation/ 
> devicetree/bindings/regulator/rohm,bd71837-regulator.yaml#L108
> 

Ah I didn't know those existed, should've checked the bindings in more 
detail, thanks for the hint!

I will have to investigate this carefully, since I don't have access to 
the actual design of the COM, so I don't know exactly what is there.

Kind regards,
Maud

