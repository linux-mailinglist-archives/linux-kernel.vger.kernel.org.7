Return-Path: <linux-kernel+bounces-834343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4914BA47EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 17:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C9C67B7795
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9AA23D294;
	Fri, 26 Sep 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVUImZON"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013067.outbound.protection.outlook.com [52.101.83.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800B123B638;
	Fri, 26 Sep 2025 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758901704; cv=fail; b=BpSwqyUoRuhUbJSVfPFcyaBeOrRa6T4A8hHosXyEt0XNX0iqWUFa5F15k2nQKsfr/Rrmh6Hcc2axikcZQkm0z7hOYBDwcX4Cycdo8rEAmkWhG0TBmVnZttucDgPSzwPrGRa44O7H+VoWj8gJyMAok54dtwyix54Q9LN1FZ1ynNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758901704; c=relaxed/simple;
	bh=FLnIRi5cTPNBZAh+UhkCshhTBVW4NnN6H3RB3mQ3MNA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZPUbor6meTACHhiRCLFscAO8ftR0OVp28X+I5ZxeS9NR6iHoLH4L+qvDfGy3PN9CimTD/wC3Y+XFizEiFHuuwSIEsF5uaN4c9bXS3JUrsN94DyqMpLmiwrREI7RKlynwY2EsJfKfvQtc5En9Bqh6qcEYJrns2bOAKcUgDR0qB1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YVUImZON; arc=fail smtp.client-ip=52.101.83.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT11uGGFF4oZNm0M6OmGY3bbTcjZhqAo5XQULsShlnlAUw9N/lAmxvq5N8oAUWSzEFL6ccdicwh/pUA7pkpH0ifDh1Kk0zk6C3ydAf9T4HfbRx/NMwo/xfTWqcH7K44PdyoYz9P9EBoNlp22WRtD3gfM2xPKaI9Yl6UohB4RKyIbcTJ7urOy49ditW8lYIPftQjG6nywC1cFphivFJmXme1eNwwhD27eVQh9qwGMWrtH7KXUSESn7SVDUw/EAhg2QWaXvz7wekhbN8x58lps9t5qaj8KzpwxQORrQWrs6Ti4RWjU1unBZg9iVjJkKEE88vNzP/PA2EXxb4emXzGlcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtHwUPX0mkTp1rMnxFsCGlFPu+A0iTGvk4r7WxfYHeY=;
 b=lsHKG7q0i/1rSugkyIQxye8/mArcAeiH7pyJFW/jp3SmSlIS69pXhYEd63q1L+j9+/b7PXV9YLEq5ymUdFbSaWSmGv5ELTih+x+WqbDl91Th4Ila8hrRRUJl1M/6JTGONiO5jLaUwW2vMmm3Tl3HJcyXrHKD68bbSqAaGiijAQ3PZrtKtXNTVPWeJFNNBlczlLicifif3BHXclHFzEuOT6aoTN1toL923EQs6LpdopFIxQIPzfq+PPsmAbMkiJ+wUWoAXMEPshi20p27HFTzRBf2xgq9iWYmnmjy6SPcAjolyoN/yEeRB/dVdwwCxGj/EboVabw+w+suf4pnVGA1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtHwUPX0mkTp1rMnxFsCGlFPu+A0iTGvk4r7WxfYHeY=;
 b=YVUImZONelRW7r1X/5uFijWiB5NS34y13/LL7Yh8fs+5siBw3lTit7dwxJw/0eQLDEbnWNM8POdOK3p2Nw1pTFJKbrrsWvCKOFGst5HcFVXNATht/3rKJvCUn6HAJhsbOhxBhPG8D24e21kUZDAmzOfcoW3epFeUCevAJKpk3pu9agLPpDhmt1mmz5pw24FED+gvUns9BS6gVGO8OIHxweH1NRxG5riGLrxeknJ9iUOGWQ/lIHgZocGbpQCI8/rsfEOP6lRik1RoCpuFS++3QobN6qyRJ20MdSvc6kWyP+a9u6uEsM64VNK/QLAPEr0mJY0sI5yegqJFP5OS4b2Gzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GV2PR04MB11826.eurprd04.prod.outlook.com (2603:10a6:150:2d1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 15:48:19 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 15:48:19 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
Date: Sat, 27 Sep 2025 02:39:35 +0530
Subject: [PATCH v19 5/7] firmware: drivers: imx: adds miscdev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-imx-se-if-v19-5-d1e7e960c118@nxp.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
In-Reply-To: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
To: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758920996; l=33997;
 i=pankaj.gupta@nxp.com; s=20240523; h=from:subject:message-id;
 bh=FLnIRi5cTPNBZAh+UhkCshhTBVW4NnN6H3RB3mQ3MNA=;
 b=n4E5JdsRxCHtKO3/SytLIs7lNdcpzasnyHobo1lqv7dbEaFE+hIw+p3/q7l2nirvdxWeMCVFO
 upqxtdco0OtA9Z0ZAQe52gphl5gBzd0OKzF3Xzw0BvKlaUCbErdZiLe
X-Developer-Key: i=pankaj.gupta@nxp.com; a=ed25519;
 pk=OA0pBQoupy5lV0XfKzD8B0OOBVB6tpAoIf+0x1bYGRg=
X-ClientProxiedBy: SGAP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::27)
 To AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8604:EE_|GV2PR04MB11826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccbb334-db80-4c7f-2787-08ddfd141dc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|1800799024|52116014|376014|19092799006|13003099007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0xFUkN3VDJvUk1mRCtDajk5RFl6bXRGNklTMkhOZkhlZkdXVnYzUWJJbmtP?=
 =?utf-8?B?bmhWMkVkTzMyVnJSY0NDVjkzeHhtL3d1endEWk14R2JudE1BdlZwdEp1b0wz?=
 =?utf-8?B?YUt3OVR2YlRTNnFGS01KYko3OEtRYUs4YkoxL3o3SkVCRUNNNWxtWkx2SFA5?=
 =?utf-8?B?OFBrbUgxRG5OcWMxUDdwVGRVVG1ndXQ5d2VtM2hsVDcvdzBBK2R5NjhldXFX?=
 =?utf-8?B?MGljSTVuRThWNXVhcUlqRThRclN2eS9zbEFOazE2VEJqZlhMNHF2bFgxcEYr?=
 =?utf-8?B?cDNvdEJpZkpoUHdTcVNVbVg1RlVjYWh2ZmlmN2NYeWhRY1MvdVpPZ0hrQ2dS?=
 =?utf-8?B?Wk5qUTNheU95czFNWnN3bzh6ellDMFZOSFByWUMzSTVPbWEvZENtcFlnc0Rm?=
 =?utf-8?B?czU5dThDaEFBZm1vUCtTTEh2TVB5Y0xuamRleFY5Sko3ZVYrZjNISFJVRmUv?=
 =?utf-8?B?dXR0Zm5LQUhwZ2RIL2RwSmdRcFdOUjBXSHc5elNoVHFWUDdjaW00S1pMbUN5?=
 =?utf-8?B?T3V4WElzSktoRmczajNqNDV2VTlhWTlVSjJPWTNQMURwN2JDTWZ3WkxFT3FR?=
 =?utf-8?B?bFk5aFpjRVIvd0tvekNrdHN5L290Zm00dTU4b3J4bEZFUXhySkhNdS82QXpk?=
 =?utf-8?B?cFI2b0lLdkZsV2NaM1RCVWZkU3FhQUd3ZHRBT044ZWY4VEI4WnVRRGl5bFpM?=
 =?utf-8?B?UkRsZFgrQVByTDNrbWdwZGdKRkQ4azQ0a0d2RmJlRWREL3FXSjl5TUJPSXFQ?=
 =?utf-8?B?UWpScUdNMWtGRTVTeXpSVFVpWmhVdmxQcmg2QWNjODl5WG5PNmtucjhQTWFR?=
 =?utf-8?B?c1E0ZitiOHlWL0JIdUZVU0NJY0Z2VkQyYmxLUm04bkwvVkN2NjE5R3BaUEY3?=
 =?utf-8?B?U1JIRWsxTCtiaCtubkRoY1BaMzM3dzJUL05xMUdwQXh4Y3lPMTZwT0hNN0M3?=
 =?utf-8?B?Qk9VUE5zQTdkd25JbHcrZk9TeGZsZFJsZlBjYm4xYlJ3QUk0MkRRWmg4RXlY?=
 =?utf-8?B?MWdnQmJuY2psQzhqWnlPU2ttUU5vejFlVVdtYkozM3NmVkE4S082cHp5Q3Rv?=
 =?utf-8?B?eDRtLzluam5GMi9nSTlvZ211aXp0d0ZFamFKVlFNTktDWkZGbmN1bi9YUzlu?=
 =?utf-8?B?bnZGQlJZZkQzdml3QzhKSHBrdmw3VTYxU3dFZW5YRW9rT2J5cHZZSmpUQ3Fw?=
 =?utf-8?B?dHdJWXlFZmV6UFVxQW1VOGRtcmVZMEpwUmE4SU1CZ1pVTWhZZDVzRURUamc2?=
 =?utf-8?B?Z3BrdExmeWpXaHpncjdzb3p5WlAzZ3dNTWlYNXRlVnJIcG5rUkphOGpZeFJP?=
 =?utf-8?B?U3VYMjNQc3J0NmdpZ3c0VjN6K1o1TGtqdkovSmRBMlU0TFc4R3B0V1ZTSG02?=
 =?utf-8?B?TGQ1cStEOFFSSVltTUlhdGNQcTZDc0liTVlRbkVaWmlLR2d3ZmhYSk5iNXNY?=
 =?utf-8?B?bnh2NHdxUTBzanVPNCtjY0RTVGpEZEJvem94ejBhME54d1Y3RkZzcVp3ZWFw?=
 =?utf-8?B?aXNlRWZIWWNYdnlPYlZsRkxXM1BKM0FEeE93REI5aS9WZ2tRMjRDQVJ3MU0w?=
 =?utf-8?B?SnNtekxiSlF2WTdPa0lPSFZtUmtpRUsxanE2NDVYNkRFZ0lLM3c5bFlLNzJX?=
 =?utf-8?B?SHRPUHRmTVJwTWVveUdQVE1tVTN4bVhWOWNiZWJ3R1VicFlhbWhlOHM4ZEFm?=
 =?utf-8?B?Uzc5bkVYd2kxVm82YkRqc3E1YjVwLzRuQkVhd21NVUloNHJTQ3BwYmlDYUU1?=
 =?utf-8?B?cjRrV2h1eEJaNW53RjZRVWZKcFlFSHNselR5eEVBNHBOZTdvNStUMXduUFNp?=
 =?utf-8?B?czFVaDA2ekhPcWxFZ2paY0Jodk9Ucld1ckRyVEg0aDlxcGswQkJVa3pFdmlq?=
 =?utf-8?B?TWJzUXZvK2ZqbUJmMG8rRWVLaVYvT2dSenNzVnBMK0Y2U3RrZ3p2WmVpTXhL?=
 =?utf-8?Q?7FeTRtAVS8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(52116014)(376014)(19092799006)(13003099007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEUyMHlzUlNPQ2Jab1dLOHBRamsvS3h2aWdvY21iZ3JOTmxDK3haOC81dkJN?=
 =?utf-8?B?K1Y2NWtlak10Q2JmRU1KM29hQTdTME9KSDdHaEdzSzUwbVVhMTJyQmpKa1ZC?=
 =?utf-8?B?ZlF2YVY3ckNvcVBZVVN4aXFpTUI0OTZvVFo3Y2IzVFNldjNVbUxzNHlBRXV2?=
 =?utf-8?B?b1E4Wis0d1NrWlRKQ3Flb2JiRGk0a0cyQXdzYkZkak4vdDc5dXlvc0hBdWVi?=
 =?utf-8?B?OGZ5d2dLeUdXSHdaUnl0L1NuOC9SM0ZJR3BiY2x2by9PRjlhRWNWTksyMGMz?=
 =?utf-8?B?YmpvTDdVVUVpQWtFZ0JHVkdRd1NTdGgxTnRVckF5MzBmRXJmZU5ObTZROTRx?=
 =?utf-8?B?a1ZkWDkzMnB5b0tmZktudlh2T0hicGFEYVJCeXJoUzVYa0ZqQXdJbEZ3V2dl?=
 =?utf-8?B?OVpKSUd5d3BmMEpuZXdTbE5nWmFPTDhrdXg1RjQrSEV3SUczcEhmZk9QOEh0?=
 =?utf-8?B?bXl0MFQrODQrbTA1R20zUXNXY1doOUR4V1hXMlZubzkvVTlwcHBOb0ErcVo3?=
 =?utf-8?B?MHdST3B3MGw1QUFpeWoxY25ueHB0cHhlNHovQm9xa2svWkhlT093bWFEb1RF?=
 =?utf-8?B?VEN5RkwwSUVqRW85ekxtTmN5VFJudk5uSkM0UXNBWC9LeERaODJqWUt0MFEv?=
 =?utf-8?B?T2l0UnNZRXVnWEE3Yms2ME8wdENNckwybEYvVWM4Y204WHQ0YVNaZ1N5Z1l2?=
 =?utf-8?B?bDBUZkhSVUs0RGZsSGZRbE9XOWNyU3VYTVhrb2h5ZUlvczBOTHpmS1gyRWxG?=
 =?utf-8?B?bk1waVRSREFicERBeVNOaWpjSEdrK0pHbWFSZHlyQllhS3Q4OHo4OE1VVHBw?=
 =?utf-8?B?MWlXeTJSVHhlbmpRTGxKTXlkOXh2aU1vTG5ueXFkQkg0RzFYNHA5NEh6WVkw?=
 =?utf-8?B?VU5LWDFldU5vdks3UTFjUHFVc0hxTVlKUHhvakxSVjVFMUwzeHpYUlhETGNn?=
 =?utf-8?B?ZTlIb2llMklWdC9jYTlabmlDWCtuVmM2Y2dDeStCKzRTTitST2VQZm05UmhU?=
 =?utf-8?B?d01lc25acVRoaFRwNWRuc01UNVNycW0zRW4rcnZnTHJxb2lFTTdJRTlBTHda?=
 =?utf-8?B?QndMUDVncjA4ZzNUYTRJK0pLYUFtZGRoV2YyRlVlNmRRQzl6VkV3czdncExx?=
 =?utf-8?B?R1FmNkp4LzhEbGdvcXdrUUpteEV0QlEwSlI3ajdXNkhvRGJTdExiZ3lpMElU?=
 =?utf-8?B?bTRpWG5jbHVUa1pUbTdWUVAzVDZleWZrTTAwNGtXK0RlTGtqYis3R3hQUGtH?=
 =?utf-8?B?QWtCdFB0Nm5aUDIvYXpqVFdkdFRNUWVXY0FEWmlNTi9XT0V4eE9CZFF5bS9B?=
 =?utf-8?B?UkpsckpWWlhQSGFDVTJsbkVoOGNDWDNUa2YwZUsrQmR5cFNwSU9NMmRjdTdp?=
 =?utf-8?B?WUFXUFk0NXNBTExsemdVNks4STFpVUt6TmNrTkNqdGNrYmFDNFM3TlV1SHhp?=
 =?utf-8?B?ZzRtYzJ2VC9kOU5jekFjNlNmTDk0cCszK1pQOXZaVlZMaktwYXNOVndhMm16?=
 =?utf-8?B?RXRWMW9BWUdPSnRpTzdIdDhKN3hkTjFvNEFiSWJvcmlxUEViNDZqVkF5L1dp?=
 =?utf-8?B?a1dZUFNtTFBNdG1CN01ZRnB3WTFVemVCZWtPbkN3K2dCNERVV2FQRFFIbExS?=
 =?utf-8?B?VjVMMWdZYlVERU9TNk9mSTRKNkg3YnpMRC9ucGVWNHloenBUQmg4bk5maXFr?=
 =?utf-8?B?azdmWUcxU3ZuZUlPUVFLQTRVeVpyYzd6K3J1VGtBRnZ4c0pjY2Rpa1M1aWZ6?=
 =?utf-8?B?bVhqdnF4Z0doYVl3cTFndlFPTHFZRDlQS2ZjVU43R2ZjWUdmdjFaQ29DLzRB?=
 =?utf-8?B?Y2V5RC9uazRWMGtqNWxGd2ZvY1R5TjM3eEhHS21Pc1N1OEU0MmRpb3o1V1g1?=
 =?utf-8?B?R0lrcFdkSW1SNDVwaDdTaHkwMzYwZFdVTW1UbDRQZGVSbFNMUjdrVG5sby9N?=
 =?utf-8?B?aEZobFI4QjZYUFY0VEVJUVd2cEN3c1JkQ1JuY3pTWkx6bi90NlQzWS9iMzIx?=
 =?utf-8?B?UGFSTWY0VEVhN3RrYnQrTjBRYU84Vzg5d2VEajRaUm11RnFIUTlvV3RYaUdQ?=
 =?utf-8?B?UFQycTlNRnRXMUYxR3NzeVlWNUZuMUhQakRrM0gwV0tPSEdPR1c5L3NyRnVL?=
 =?utf-8?Q?hFijMDMFykBcuwMkD+dj8INqR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccbb334-db80-4c7f-2787-08ddfd141dc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 15:48:19.7858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4NtTNJepseGJZEUjKegjxsDfzsXYf73NsT6+og9tNEnNpoBZwOX9FfWtYQoqMoI8dOqjaDeIxeEUBVcSDM6gPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11826

Adds the driver for communication interface to secure-enclave, for
exchanging messages with NXP secure enclave HW IP(s) like EdgeLock Enclave
from:
- User-Space Applications via character driver.

ABI documentation for the NXP secure-enclave driver.

User-space library using this driver:
- i.MX Secure Enclave library:
  -- URL: https://github.com/nxp-imx/imx-secure-enclave.git,
- i.MX Secure Middle-Ware:
  -- URL: https://github.com/nxp-imx/imx-smw.git

Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
changes from v17 to v18
- Collected Frank's R-b tag.
---
 Documentation/ABI/testing/se-cdev |  43 +++
 drivers/firmware/imx/ele_common.c |  20 +-
 drivers/firmware/imx/ele_common.h |   4 +
 drivers/firmware/imx/se_ctrl.c    | 733 +++++++++++++++++++++++++++++++++++++-
 drivers/firmware/imx/se_ctrl.h    |  33 ++
 include/uapi/linux/se_ioctl.h     |  97 +++++
 6 files changed, 918 insertions(+), 12 deletions(-)

diff --git a/Documentation/ABI/testing/se-cdev b/Documentation/ABI/testing/se-cdev
new file mode 100644
index 000000000000..dad39ffd245a
--- /dev/null
+++ b/Documentation/ABI/testing/se-cdev
@@ -0,0 +1,43 @@
+What:		/dev/<se>_mu[0-9]+_ch[0-9]+
+Date:		Mar 2025
+KernelVersion:	6.8
+Contact:	linux-imx@nxp.com, pankaj.gupta@nxp.com
+Description:
+		NXP offers multiple hardware IP(s) for secure enclaves like EdgeLock-
+		Enclave(ELE), SECO. The character device file descriptors
+		/dev/<se>_mu*_ch* are the interface between userspace NXP's secure-
+		enclave shared library and the kernel driver.
+
+		The ioctl(2)-based ABI is defined and documented in
+		[include]<linux/firmware/imx/ele_mu_ioctl.h>.
+		ioctl(s) are used primarily for:
+			- shared memory management
+			- allocation of I/O buffers
+			- getting mu info
+			- setting a dev-ctx as receiver to receive all the commands from FW
+			- getting SoC info
+			- send command and receive command response
+
+		The following file operations are supported:
+
+		open(2)
+		  Currently the only useful flags are O_RDWR.
+
+		read(2)
+		  Every read() from the opened character device context is waiting on
+		  wait_event_interruptible, that gets set by the registered mailbox callback
+		  function, indicating a message received from the firmware on message-
+		  unit.
+
+		write(2)
+		  Every write() to the opened character device context needs to acquire
+		  mailbox_lock before sending message on to the message unit.
+
+		close(2)
+		  Stops and frees up the I/O contexts that were associated
+		  with the file descriptor.
+
+Users:		https://github.com/nxp-imx/imx-secure-enclave.git,
+		https://github.com/nxp-imx/imx-smw.git
+		crypto/skcipher,
+		drivers/nvmem/imx-ocotp-ele.c
diff --git a/drivers/firmware/imx/ele_common.c b/drivers/firmware/imx/ele_common.c
index f26fb4d55a9a..dc4607984f00 100644
--- a/drivers/firmware/imx/ele_common.c
+++ b/drivers/firmware/imx/ele_common.c
@@ -42,15 +42,22 @@ u32 se_get_msg_chksum(u32 *msg, u32 msg_len)
 	return chksum;
 }
 
+void set_se_rcv_msg_timeout(struct se_if_priv *priv, u32 timeout_ms)
+{
+	priv->se_rcv_msg_timeout_ms = timeout_ms;
+}
+
 int ele_msg_rcv(struct se_if_device_ctx *dev_ctx, struct se_clbk_handle *se_clbk_hdl)
 {
-	unsigned long timeout;
+	unsigned long timeout_ms;
 	int ret;
 
 	do {
-		timeout = MAX_SCHEDULE_TIMEOUT;
+		timeout_ms = MAX_SCHEDULE_TIMEOUT;
+		if (dev_ctx->priv->cmd_receiver_clbk_hdl.dev_ctx != dev_ctx)
+			timeout_ms = msecs_to_jiffies(dev_ctx->priv->se_rcv_msg_timeout_ms);
 
-		ret = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, timeout);
+		ret = wait_for_completion_interruptible_timeout(&se_clbk_hdl->done, timeout_ms);
 		if (ret == -ERESTARTSYS) {
 			if (dev_ctx->priv->waiting_rsp_clbk_hdl.dev_ctx) {
 				dev_ctx->priv->waiting_rsp_clbk_hdl.signal_rcvd = true;
@@ -59,6 +66,13 @@ int ele_msg_rcv(struct se_if_device_ctx *dev_ctx, struct se_clbk_handle *se_clbk
 			ret = -EINTR;
 			break;
 		}
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
+			dev_err(dev_ctx->priv->dev,
+				"Fatal Error: SE interface: %s0, hangs indefinitely.\n",
+				get_se_if_name(dev_ctx->priv->if_defs->se_if_type));
+			break;
+		}
 		ret = se_clbk_hdl->rx_msg_sz;
 		break;
 	} while (ret < 0);
diff --git a/drivers/firmware/imx/ele_common.h b/drivers/firmware/imx/ele_common.h
index 5bac14439d7d..3e88ea45ca5d 100644
--- a/drivers/firmware/imx/ele_common.h
+++ b/drivers/firmware/imx/ele_common.h
@@ -12,6 +12,10 @@
 
 #define IMX_ELE_FW_DIR                 "imx/ele/"
 
+#define SE_RCV_MSG_DEFAULT_TIMEOUT	5000
+#define SE_RCV_MSG_LONG_TIMEOUT		5000000
+
+void set_se_rcv_msg_timeout(struct se_if_priv *priv, u32 val);
 u32 se_get_msg_chksum(u32 *msg, u32 msg_len);
 
 int ele_msg_rcv(struct se_if_device_ctx *dev_ctx, struct se_clbk_handle *se_clbk_hdl);
diff --git a/drivers/firmware/imx/se_ctrl.c b/drivers/firmware/imx/se_ctrl.c
index 40544cbc70ca..5766d0759955 100644
--- a/drivers/firmware/imx/se_ctrl.c
+++ b/drivers/firmware/imx/se_ctrl.c
@@ -23,6 +23,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/sys_soc.h>
+#include <uapi/linux/se_ioctl.h>
 
 #include "ele_base_msg.h"
 #include "ele_common.h"
@@ -32,12 +33,6 @@
 #define MBOX_TX_NAME			"tx"
 #define MBOX_RX_NAME			"rx"
 
-#define SE_TYPE_STR_DBG			"dbg"
-#define SE_TYPE_STR_HSM			"hsm"
-
-#define SE_TYPE_ID_DBG			0x1
-#define SE_TYPE_ID_HSM			0x2
-
 struct se_fw_img_name {
 	const u8 *prim_fw_nm_in_rfs;
 	const u8 *seco_fw_nm_in_rfs;
@@ -130,6 +125,13 @@ char *get_se_if_name(u8 se_if_id)
 	return NULL;
 }
 
+static u32 get_se_soc_id(struct se_if_priv *priv)
+{
+	const struct se_soc_info *se_info = device_get_match_data(priv->dev);
+
+	return se_info->soc_id;
+}
+
 static struct se_fw_load_info *get_load_fw_instance(struct se_if_priv *priv)
 {
 	return &var_se_info.load_fw;
@@ -203,8 +205,213 @@ static int get_se_soc_info(struct se_if_priv *priv, const struct se_soc_info *se
 	return 0;
 }
 
+static int load_firmware(struct se_if_priv *priv, const u8 *se_img_file_to_load)
+{
+	const struct firmware *fw = NULL;
+	phys_addr_t se_fw_phyaddr;
+	u8 *se_fw_buf;
+	int ret;
+
+	if (!se_img_file_to_load) {
+		dev_err(priv->dev, "FW image is not provided.");
+		return -EINVAL;
+	}
+	ret = request_firmware(&fw, se_img_file_to_load, priv->dev);
+	if (ret)
+		return ret;
+
+	dev_info(priv->dev, "loading firmware %s.", se_img_file_to_load);
+
+	/* allocate buffer to store the SE FW */
+	se_fw_buf = dma_alloc_coherent(priv->dev, fw->size, &se_fw_phyaddr, GFP_KERNEL);
+	if (!se_fw_buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	memcpy(se_fw_buf, fw->data, fw->size);
+	ret = ele_fw_authenticate(priv, se_fw_phyaddr, se_fw_phyaddr);
+	if (ret < 0) {
+		dev_err(priv->dev,
+			"Error %pe: Authenticate & load SE firmware %s.",
+			ERR_PTR(ret), se_img_file_to_load);
+		ret = -EPERM;
+	}
+	dma_free_coherent(priv->dev, fw->size, se_fw_buf, se_fw_phyaddr);
+exit:
+	release_firmware(fw);
+
+	return ret;
+}
+
+static int se_load_firmware(struct se_if_priv *priv)
+{
+	struct se_fw_load_info *load_fw = get_load_fw_instance(priv);
+	int ret = 0;
+
+	if (!load_fw->is_fw_tobe_loaded)
+		return 0;
+
+	if (load_fw->imem.state == ELE_IMEM_STATE_BAD) {
+		ret = load_firmware(priv, load_fw->se_fw_img_nm->prim_fw_nm_in_rfs);
+		if (ret) {
+			dev_err(priv->dev, "Failed to load boot firmware.");
+			return -EPERM;
+		}
+	}
+
+	ret = load_firmware(priv, load_fw->se_fw_img_nm->seco_fw_nm_in_rfs);
+	if (ret) {
+		dev_err(priv->dev, "Failed to load runtime firmware.");
+		return -EPERM;
+	}
+
+	load_fw->is_fw_tobe_loaded = false;
+
+	return ret;
+}
+
+static int init_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_out);
+	INIT_LIST_HEAD(&se_shared_mem_mgmt->pending_in);
+
+	/*
+	 * Allocate some memory for data exchanges with S40x.
+	 * This will be used for data not requiring secure memory.
+	 */
+	se_shared_mem_mgmt->non_secure_mem.ptr =
+			dma_alloc_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+					   &se_shared_mem_mgmt->non_secure_mem.dma_addr,
+					   GFP_KERNEL);
+	if (!se_shared_mem_mgmt->non_secure_mem.ptr)
+		return -ENOMEM;
+
+	se_shared_mem_mgmt->non_secure_mem.size = MAX_DATA_SIZE_PER_USER;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+
+	return 0;
+}
+
+static void cleanup_se_shared_mem(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	/* Free non-secure shared buffer. */
+	dma_free_coherent(priv->dev, MAX_DATA_SIZE_PER_USER,
+			  se_shared_mem_mgmt->non_secure_mem.ptr,
+			  se_shared_mem_mgmt->non_secure_mem.dma_addr);
+
+	se_shared_mem_mgmt->non_secure_mem.ptr = NULL;
+	se_shared_mem_mgmt->non_secure_mem.dma_addr = 0;
+	se_shared_mem_mgmt->non_secure_mem.size = 0;
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+/* Need to copy the output data to user-device context.
+ */
+static int se_dev_ctx_cpy_out_data(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_buf_desc *b_desc, *temp;
+	bool do_cpy = true;
+
+	list_for_each_entry_safe(b_desc, temp, &se_shared_mem_mgmt->pending_out, link) {
+		if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr && do_cpy) {
+			dev_dbg(priv->dev, "Copying output data to user.");
+			if (do_cpy && copy_to_user(b_desc->usr_buf_ptr,
+						   b_desc->shared_buf_ptr,
+						   b_desc->size)) {
+				dev_err(priv->dev, "Failure copying output data to user.");
+				do_cpy = false;
+			}
+		}
+
+		if (b_desc->shared_buf_ptr)
+			memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+		list_del(&b_desc->link);
+		kfree(b_desc);
+	}
+
+	return do_cpy ? 0 : -EFAULT;
+}
+
+/*
+ * Clean the used Shared Memory space,
+ * whether its Input Data copied from user buffers, or
+ * Data received from FW.
+ */
+static void se_dev_ctx_shared_mem_cleanup(struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct list_head *pending_lists[] = {&se_shared_mem_mgmt->pending_in,
+						&se_shared_mem_mgmt->pending_out};
+	struct se_buf_desc *b_desc, *temp;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pending_lists); i++) {
+		list_for_each_entry_safe(b_desc, temp, pending_lists[i], link) {
+			if (b_desc->shared_buf_ptr)
+				memset(b_desc->shared_buf_ptr, 0, b_desc->size);
+
+			list_del(&b_desc->link);
+			kfree(b_desc);
+		}
+	}
+	se_shared_mem_mgmt->non_secure_mem.pos = 0;
+}
+
+static int add_b_desc_to_pending_list(void *shared_ptr_with_pos,
+				      struct se_ioctl_setup_iobuf *io,
+				      struct se_if_device_ctx *dev_ctx)
+{
+	struct se_shared_mem_mgmt_info *se_shared_mem_mgmt = &dev_ctx->se_shared_mem_mgmt;
+	struct se_buf_desc *b_desc;
+
+	b_desc = kzalloc(sizeof(*b_desc), GFP_KERNEL);
+	if (!b_desc)
+		return -ENOMEM;
+
+	b_desc->shared_buf_ptr = shared_ptr_with_pos;
+	b_desc->usr_buf_ptr = io->user_buf;
+	b_desc->size = io->length;
+
+	if (io->flags & SE_IO_BUF_FLAGS_IS_INPUT) {
+		/*
+		 * buffer is input:
+		 * add an entry in the "pending input buffers" list so
+		 * that copied data can be cleaned from shared memory
+		 * later.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_in);
+	} else {
+		/*
+		 * buffer is output:
+		 * add an entry in the "pending out buffers" list so data
+		 * can be copied to user space when receiving Secure-Enclave
+		 * response.
+		 */
+		list_add_tail(&b_desc->link, &se_shared_mem_mgmt->pending_out);
+	}
+
+	return 0;
+}
+
+/* interface for managed res to unregister a character device */
+static void if_misc_deregister(void *miscdevice)
+{
+	misc_deregister(miscdevice);
+}
+
 static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
-				    struct se_if_device_ctx **new_dev_ctx)
+				    struct se_if_device_ctx **new_dev_ctx,
+				    const struct file_operations *se_if_fops)
 {
 	struct se_if_device_ctx *dev_ctx;
 	int ret = 0;
@@ -220,12 +427,509 @@ static int init_misc_device_context(struct se_if_priv *priv, int ch_id,
 	if (!dev_ctx->devname)
 		return -ENOMEM;
 
+	mutex_init(&dev_ctx->fops_lock);
+
+	dev_ctx->priv = priv;
+	*new_dev_ctx = dev_ctx;
+
+	dev_ctx->miscdev = devm_kzalloc(priv->dev, sizeof(*dev_ctx->miscdev), GFP_KERNEL);
+	if (!dev_ctx->miscdev) {
+		*new_dev_ctx = NULL;
+		return -ENOMEM;
+	}
+
+	dev_ctx->miscdev->name = dev_ctx->devname;
+	dev_ctx->miscdev->minor = MISC_DYNAMIC_MINOR;
+	dev_ctx->miscdev->fops = se_if_fops;
+	dev_ctx->miscdev->parent = priv->dev;
+	ret = misc_register(dev_ctx->miscdev);
+	if (ret)
+		return dev_err_probe(priv->dev, ret, "Failed to register misc device.");
+
+	ret = devm_add_action_or_reset(priv->dev, if_misc_deregister, dev_ctx->miscdev);
+	if (ret)
+		return dev_err_probe(priv->dev, ret,
+				     "Failed to add action to the misc-dev.");
+	return ret;
+}
+
+static int init_device_context(struct se_if_priv *priv, int ch_id,
+			       struct se_if_device_ctx **new_dev_ctx)
+{
+	struct se_if_device_ctx *dev_ctx;
+	int ret = 0;
+
+	dev_ctx = kzalloc(sizeof(*dev_ctx), GFP_KERNEL);
+
+	if (!dev_ctx)
+		return -ENOMEM;
+
+	dev_ctx->devname = kasprintf(GFP_KERNEL, "%s0_ch%d",
+				     get_se_if_name(priv->if_defs->se_if_type),
+				     ch_id);
+	if (!dev_ctx->devname) {
+		kfree(dev_ctx);
+		return -ENOMEM;
+	}
+
+	mutex_init(&dev_ctx->fops_lock);
 	dev_ctx->priv = priv;
 	*new_dev_ctx = dev_ctx;
 
+	list_add_tail(&dev_ctx->link, &priv->dev_ctx_list);
+	priv->active_devctx_count++;
+
+	ret = init_se_shared_mem(dev_ctx);
+	if (ret < 0) {
+		kfree(dev_ctx->devname);
+		kfree(dev_ctx);
+		*new_dev_ctx = NULL;
+	}
+
 	return ret;
 }
 
+static int se_ioctl_cmd_snd_rcv_rsp_handler(struct se_if_device_ctx *dev_ctx,
+					    u64 arg)
+{
+	struct se_ioctl_cmd_snd_rcv_rsp_info cmd_snd_rcv_rsp_info = {0};
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_api_msg *rx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err = 0;
+
+	if (copy_from_user(&cmd_snd_rcv_rsp_info, (u8 __user *)arg,
+			   sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev,
+			"%s: Failed to copy cmd_snd_rcv_rsp_info from user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+		goto exit;
+	}
+
+	if (cmd_snd_rcv_rsp_info.tx_buf_sz < SE_MU_HDR_SZ) {
+		dev_err(priv->dev, "%s: User buffer too small(%d < %d)",
+			dev_ctx->devname, cmd_snd_rcv_rsp_info.tx_buf_sz, SE_MU_HDR_SZ);
+		err = -ENOSPC;
+		goto exit;
+	}
+
+	rx_msg = kzalloc(cmd_snd_rcv_rsp_info.rx_buf_sz, GFP_KERNEL);
+	if (!rx_msg) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	tx_msg = memdup_user(cmd_snd_rcv_rsp_info.tx_buf,
+			     cmd_snd_rcv_rsp_info.tx_buf_sz);
+	if (IS_ERR(tx_msg)) {
+		err = PTR_ERR(tx_msg);
+		goto exit;
+	}
+
+	if (tx_msg->header.tag != priv->if_defs->cmd_tag) {
+		err = -EINVAL;
+		goto exit;
+	}
+
+	if (tx_msg->header.ver == priv->if_defs->fw_api_ver &&
+	    get_load_fw_instance(priv)->is_fw_tobe_loaded) {
+		err = se_load_firmware(priv);
+		if (err) {
+			dev_err(priv->dev, "Could not send msg as FW is not loaded.");
+			err = -EPERM;
+			goto exit;
+		}
+	}
+	set_se_rcv_msg_timeout(priv, SE_RCV_MSG_LONG_TIMEOUT);
+
+	err = ele_msg_send_rcv(dev_ctx, tx_msg, cmd_snd_rcv_rsp_info.tx_buf_sz,
+			       rx_msg, cmd_snd_rcv_rsp_info.rx_buf_sz);
+	if (err < 0)
+		goto exit;
+
+	dev_dbg(priv->dev, "%s: %s %s.", dev_ctx->devname, __func__,
+		"message received, start transmit to user");
+
+	/* We may need to copy the output data to user before
+	 * delivering the completion message.
+	 */
+	err = se_dev_ctx_cpy_out_data(dev_ctx);
+	if (err < 0)
+		goto exit;
+
+	/* Copy data from the buffer */
+	print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4, rx_msg,
+			     cmd_snd_rcv_rsp_info.rx_buf_sz, false);
+
+	if (copy_to_user(cmd_snd_rcv_rsp_info.rx_buf, rx_msg,
+			 cmd_snd_rcv_rsp_info.rx_buf_sz)) {
+		dev_err(priv->dev, "%s: Failed to copy to user.", dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+exit:
+
+	/* shared memory is allocated before this IOCTL */
+	se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+	if (copy_to_user((void __user *)arg, &cmd_snd_rcv_rsp_info,
+			 sizeof(cmd_snd_rcv_rsp_info))) {
+		dev_err(priv->dev, "%s: Failed to copy cmd_snd_rcv_rsp_info from user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
+				u64 arg)
+{
+	struct se_if_priv *priv = dev_ctx->priv;
+	struct se_ioctl_get_if_info if_info;
+	struct se_if_node *if_node;
+	int err = 0;
+
+	if_node = container_of(priv->if_defs, typeof(*if_node), if_defs);
+
+	if_info.se_if_id = 0;
+	if_info.interrupt_idx = 0;
+	if_info.tz = 0;
+	if_info.did = 0;
+	if_info.cmd_tag = priv->if_defs->cmd_tag;
+	if_info.rsp_tag = priv->if_defs->rsp_tag;
+	if_info.success_tag = priv->if_defs->success_tag;
+	if_info.base_api_ver = priv->if_defs->base_api_ver;
+	if_info.fw_api_ver = priv->if_defs->fw_api_ver;
+
+	dev_dbg(priv->dev, "%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x].",
+		dev_ctx->devname, if_info.se_if_id, if_info.interrupt_idx, if_info.tz,
+		if_info.did);
+
+	if (copy_to_user((u8 __user *)arg, &if_info, sizeof(if_info))) {
+		dev_err(priv->dev, "%s: Failed to copy mu info to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/*
+ * Copy a buffer of data to/from the user and return the address to use in
+ * messages
+ */
+static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_ctx,
+					u64 arg)
+{
+	struct se_shared_mem *shared_mem = NULL;
+	struct se_ioctl_setup_iobuf io = {0};
+	int err = 0;
+	u32 pos;
+
+	if (copy_from_user(&io, (u8 __user *)arg, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev, "%s: Failed copy iobuf config from user.",
+			dev_ctx->devname);
+		return -EFAULT;
+	}
+
+	dev_dbg(dev_ctx->priv->dev, "%s: io [buf: %p(%d) flag: %x].", dev_ctx->devname,
+		io.user_buf, io.length, io.flags);
+
+	if (io.length == 0 || !io.user_buf) {
+		/*
+		 * Accept NULL pointers since some buffers are optional
+		 * in FW commands. In this case we should return 0 as
+		 * pointer to be embedded into the message.
+		 * Skip all data copy part of code below.
+		 */
+		io.ele_addr = 0;
+		goto copy;
+	}
+
+	/* No specific requirement for this buffer. */
+	shared_mem = &dev_ctx->se_shared_mem_mgmt.non_secure_mem;
+
+	/* Check there is enough space in the shared memory. */
+	dev_dbg(dev_ctx->priv->dev, "%s: req_size = %d, max_size= %d, curr_pos = %d",
+		dev_ctx->devname, round_up(io.length, 8u), shared_mem->size,
+		shared_mem->pos);
+
+	if (shared_mem->size < shared_mem->pos ||
+	    round_up(io.length, 8u) > (shared_mem->size - shared_mem->pos)) {
+		dev_err(dev_ctx->priv->dev, "%s: Not enough space in shared memory.",
+			dev_ctx->devname);
+		return -ENOMEM;
+	}
+
+	/* Allocate space in shared memory. 8 bytes aligned. */
+	pos = shared_mem->pos;
+	shared_mem->pos += round_up(io.length, 8u);
+	io.ele_addr = (u64)shared_mem->dma_addr + pos;
+
+	memset(shared_mem->ptr + pos, 0, io.length);
+	if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
+	    (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
+		/*
+		 * buffer is input:
+		 * copy data from user space to this allocated buffer.
+		 */
+		if (copy_from_user(shared_mem->ptr + pos, io.user_buf, io.length)) {
+			dev_err(dev_ctx->priv->dev,
+				"%s: Failed copy data to shared memory.",
+				dev_ctx->devname);
+			return -EFAULT;
+		}
+	}
+
+	err = add_b_desc_to_pending_list(shared_mem->ptr + pos, &io, dev_ctx);
+	if (err < 0)
+		dev_err(dev_ctx->priv->dev, "%s: Failed to allocate/link b_desc.",
+			dev_ctx->devname);
+
+copy:
+	/* Provide the EdgeLock Enclave address to user space only if success.*/
+	if (copy_to_user((u8 __user *)arg, &io, sizeof(io))) {
+		dev_err(dev_ctx->priv->dev, "%s: Failed to copy iobuff setup to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/* IOCTL to provide SoC information */
+static int se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx, u64 arg)
+{
+	struct se_ioctl_get_soc_info soc_info;
+	int err = -EINVAL;
+
+	soc_info.soc_id = get_se_soc_id(dev_ctx->priv);
+	soc_info.soc_rev = var_se_info.soc_rev;
+
+	err = copy_to_user((u8 __user *)arg, (u8 *)(&soc_info), sizeof(soc_info));
+	if (err) {
+		dev_err(dev_ctx->priv->dev, "%s: Failed to copy soc info to user.",
+			dev_ctx->devname);
+		err = -EFAULT;
+	}
+
+	return err;
+}
+
+/*
+ * File operations for user-space
+ */
+
+/* Write a message to the MU. */
+static ssize_t se_if_fops_write(struct file *fp, const char __user *buf,
+				size_t size, loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_api_msg *tx_msg __free(kfree) = NULL;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev, "%s: write from buf (%p)%zu, ppos=%lld.", dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
+		if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx)
+			return -EINVAL;
+
+		if (size < SE_MU_HDR_SZ) {
+			dev_err(priv->dev, "%s: User buffer too small(%zu < %d).",
+				dev_ctx->devname, size, SE_MU_HDR_SZ);
+			return -ENOSPC;
+		}
+
+		tx_msg = memdup_user(buf, size);
+		if (IS_ERR(tx_msg))
+			return PTR_ERR(tx_msg);
+
+		print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
+				     tx_msg, size, false);
+
+		err = ele_msg_send(dev_ctx, tx_msg, size);
+
+		return err;
+	}
+}
+
+/*
+ * Read a message from the MU.
+ * Blocking until a message is available.
+ */
+static ssize_t se_if_fops_read(struct file *fp, char __user *buf, size_t size,
+			       loff_t *ppos)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	int err;
+
+	dev_dbg(priv->dev, "%s: read to buf %p(%zu), ppos=%lld.", dev_ctx->devname,
+		buf, size, ((ppos) ? *ppos : 0));
+
+	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
+		if (dev_ctx != priv->cmd_receiver_clbk_hdl.dev_ctx) {
+			err = -EINVAL;
+			goto exit;
+		}
+
+		err = ele_msg_rcv(dev_ctx, &priv->cmd_receiver_clbk_hdl);
+		if (err < 0) {
+			dev_err(priv->dev, "%s: Err[0x%x]:Interrupted by signal."
+				"Current active dev-ctx count = %d.",
+				dev_ctx->devname, err, dev_ctx->priv->active_devctx_count);
+			goto exit;
+		}
+
+		/* We may need to copy the output data to user before
+		 * delivering the completion message.
+		 */
+		err = se_dev_ctx_cpy_out_data(dev_ctx);
+		if (err < 0)
+			goto exit;
+
+		/* Copy data from the buffer */
+		print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
+				     priv->cmd_receiver_clbk_hdl.rx_msg,
+				     priv->cmd_receiver_clbk_hdl.rx_msg_sz,
+				     false);
+
+		if (copy_to_user(buf, priv->cmd_receiver_clbk_hdl.rx_msg,
+				 priv->cmd_receiver_clbk_hdl.rx_msg_sz)) {
+			dev_err(priv->dev, "%s: Failed to copy to user.",
+				dev_ctx->devname);
+			err = -EFAULT;
+		} else {
+			err = priv->cmd_receiver_clbk_hdl.rx_msg_sz;
+		}
+exit:
+		priv->cmd_receiver_clbk_hdl.rx_msg_sz = 0;
+
+		se_dev_ctx_shared_mem_cleanup(dev_ctx);
+
+		return err;
+	}
+}
+
+/* Open a character device. */
+static int se_if_fops_open(struct inode *nd, struct file *fp)
+{
+	struct miscdevice *miscdev = fp->private_data;
+	struct se_if_device_ctx *misc_dev_ctx;
+	struct se_if_device_ctx *dev_ctx;
+	struct se_if_priv *priv;
+	int err = 0;
+
+	priv = dev_get_drvdata(miscdev->parent);
+	misc_dev_ctx = priv->priv_dev_ctx;
+
+	scoped_cond_guard(mutex_intr, return -EBUSY, &misc_dev_ctx->fops_lock) {
+		priv->dev_ctx_mono_count++;
+		err = init_device_context(priv,
+					  priv->dev_ctx_mono_count ?
+					  priv->dev_ctx_mono_count
+					  : priv->dev_ctx_mono_count++,
+					  &dev_ctx);
+		if (err)
+			dev_err(priv->dev, "Failed[0x%x] to create dev-ctx.", err);
+		else
+			fp->private_data = dev_ctx;
+
+		return err;
+	}
+}
+
+/* Close a character device. */
+static int se_if_fops_close(struct inode *nd, struct file *fp)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+
+	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
+		/* check if this device was registered as command receiver. */
+		if (priv->cmd_receiver_clbk_hdl.dev_ctx == dev_ctx) {
+			priv->cmd_receiver_clbk_hdl.dev_ctx = NULL;
+			kfree(priv->cmd_receiver_clbk_hdl.rx_msg);
+			priv->cmd_receiver_clbk_hdl.rx_msg = NULL;
+		}
+
+		se_dev_ctx_shared_mem_cleanup(dev_ctx);
+		cleanup_se_shared_mem(dev_ctx);
+
+		priv->active_devctx_count--;
+		list_del(&dev_ctx->link);
+
+		kfree(dev_ctx->devname);
+		kfree(dev_ctx);
+	}
+
+	return 0;
+}
+
+/* IOCTL entry point of a character device */
+static long se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct se_if_device_ctx *dev_ctx = fp->private_data;
+	struct se_if_priv *priv = dev_ctx->priv;
+	long err;
+
+	/* Prevent race during change of device context */
+	scoped_cond_guard(mutex_intr, return -EBUSY, &dev_ctx->fops_lock) {
+		switch (cmd) {
+		case SE_IOCTL_ENABLE_CMD_RCV:
+			if (!priv->cmd_receiver_clbk_hdl.dev_ctx) {
+				if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+					priv->cmd_receiver_clbk_hdl.rx_msg =
+						kzalloc(MAX_NVM_MSG_LEN,
+							GFP_KERNEL);
+					if (!priv->cmd_receiver_clbk_hdl.rx_msg) {
+						err = -ENOMEM;
+						break;
+					}
+				}
+				priv->cmd_receiver_clbk_hdl.rx_msg_sz = MAX_NVM_MSG_LEN;
+				priv->cmd_receiver_clbk_hdl.dev_ctx = dev_ctx;
+				err = 0;
+			} else {
+				err = -EBUSY;
+			}
+			break;
+		case SE_IOCTL_GET_MU_INFO:
+			err = se_ioctl_get_mu_info(dev_ctx, arg);
+			break;
+		case SE_IOCTL_SETUP_IOBUF:
+			err = se_ioctl_setup_iobuf_handler(dev_ctx, arg);
+			break;
+		case SE_IOCTL_GET_SOC_INFO:
+			err = se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
+			break;
+		case SE_IOCTL_CMD_SEND_RCV_RSP:
+			err = se_ioctl_cmd_snd_rcv_rsp_handler(dev_ctx, arg);
+			break;
+		default:
+			err = -EINVAL;
+			dev_dbg(priv->dev, "%s: IOCTL %.8x not supported.",
+				dev_ctx->devname, cmd);
+		}
+	}
+
+	return err;
+}
+
+/* Char driver setup */
+static const struct file_operations se_if_fops = {
+	.open		= se_if_fops_open,
+	.owner		= THIS_MODULE,
+	.release	= se_if_fops_close,
+	.unlocked_ioctl = se_ioctl,
+	.read		= se_if_fops_read,
+	.write		= se_if_fops_write,
+};
+
 /* interface for managed res to free a mailbox channel */
 static void if_mbox_free_channel(void *mbox_chan)
 {
@@ -246,7 +950,7 @@ static int se_if_request_channel(struct device *dev, struct mbox_chan **chan,
 	ret = devm_add_action_or_reset(dev, if_mbox_free_channel, t_chan);
 	if (ret)
 		return dev_err_probe(dev, -EPERM,
-				     "Failed to add-action for removal of mbox: %s\n",
+				     "Failed to add-action for removal of mbox: %s.",
 				     name);
 	*chan = t_chan;
 
@@ -255,6 +959,7 @@ static int se_if_request_channel(struct device *dev, struct mbox_chan **chan,
 
 static void se_if_probe_cleanup(void *plat_dev)
 {
+	struct se_if_device_ctx *dev_ctx, *t_dev_ctx;
 	struct platform_device *pdev = plat_dev;
 	struct se_fw_load_info *load_fw;
 	struct device *dev = &pdev->dev;
@@ -279,6 +984,13 @@ static void se_if_probe_cleanup(void *plat_dev)
 		load_fw->imem.buf = NULL;
 	}
 
+	if (priv->dev_ctx_mono_count) {
+		list_for_each_entry_safe(dev_ctx, t_dev_ctx, &priv->dev_ctx_list, link) {
+			list_del(&dev_ctx->link);
+			priv->active_devctx_count--;
+		}
+	}
+
 	/*
 	 * No need to check, if reserved memory is allocated
 	 * before calling for its release. Or clearing the
@@ -319,6 +1031,7 @@ static int se_if_probe(struct platform_device *pdev)
 	priv->se_mb_cl.tx_block		= false;
 	priv->se_mb_cl.knows_txdone	= true;
 	priv->se_mb_cl.rx_callback	= se_if_rx_callback;
+	set_se_rcv_msg_timeout(priv, SE_RCV_MSG_DEFAULT_TIMEOUT);
 
 	ret = se_if_request_channel(dev, &priv->tx_chan, &priv->se_mb_cl, MBOX_TX_NAME);
 	if (ret)
@@ -340,6 +1053,7 @@ static int se_if_probe(struct platform_device *pdev)
 					     "Unable to get sram pool = %s.",
 					     if_node->pool_name);
 	}
+	INIT_LIST_HEAD(&priv->dev_ctx_list);
 
 	if (if_node->reserved_dma_ranges) {
 		ret = of_reserved_mem_device_init(dev);
@@ -348,7 +1062,7 @@ static int se_if_probe(struct platform_device *pdev)
 					    "Failed to init reserved memory region.");
 	}
 
-	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx);
+	ret = init_misc_device_context(priv, 0, &priv->priv_dev_ctx, &se_if_fops);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Failed[0x%x] to create device contexts.",
@@ -389,6 +1103,7 @@ static int se_suspend(struct device *dev)
 	struct se_fw_load_info *load_fw;
 	int ret = 0;
 
+	set_se_rcv_msg_timeout(priv, SE_RCV_MSG_DEFAULT_TIMEOUT);
 	load_fw = get_load_fw_instance(priv);
 
 	if (load_fw->imem_mgmt)
diff --git a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
index b5e7705e2f26..5fcdcfe3e8e5 100644
--- a/drivers/firmware/imx/se_ctrl.h
+++ b/drivers/firmware/imx/se_ctrl.h
@@ -14,6 +14,7 @@
 #define SE_MSG_WORD_SZ			0x4
 
 #define RES_STATUS(x)			FIELD_GET(0x000000ff, x)
+#define MAX_DATA_SIZE_PER_USER		(65 * 1024)
 #define MAX_NVM_MSG_LEN			(256)
 #define MESSAGING_VERSION_6		0x6
 #define MESSAGING_VERSION_7		0x7
@@ -37,10 +38,38 @@ struct se_imem_buf {
 	u32 state;
 };
 
+struct se_buf_desc {
+	u8 *shared_buf_ptr;
+	void __user *usr_buf_ptr;
+	u32 size;
+	struct list_head link;
+};
+
+struct se_shared_mem {
+	dma_addr_t dma_addr;
+	u32 size;
+	u32 pos;
+	u8 *ptr;
+};
+
+struct se_shared_mem_mgmt_info {
+	struct list_head pending_in;
+	struct list_head pending_out;
+
+	struct se_shared_mem non_secure_mem;
+};
+
 /* Private struct for each char device instance. */
 struct se_if_device_ctx {
 	struct se_if_priv *priv;
+	struct miscdevice *miscdev;
 	const char *devname;
+
+	/* process one file operation at a time. */
+	struct mutex fops_lock;
+
+	struct se_shared_mem_mgmt_info se_shared_mem_mgmt;
+	struct list_head link;
 };
 
 /* Header of the messages exchange with the EdgeLock Enclave */
@@ -89,6 +118,10 @@ struct se_if_priv {
 	const struct se_if_defines *if_defs;
 
 	struct se_if_device_ctx *priv_dev_ctx;
+	struct list_head dev_ctx_list;
+	u32 active_devctx_count;
+	u32 dev_ctx_mono_count;
+	u32 se_rcv_msg_timeout_ms;
 };
 
 char *get_se_if_name(u8 se_if_id);
diff --git a/include/uapi/linux/se_ioctl.h b/include/uapi/linux/se_ioctl.h
new file mode 100644
index 000000000000..0c948bdc8c26
--- /dev/null
+++ b/include/uapi/linux/se_ioctl.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause*/
+/*
+ * Copyright 2025 NXP
+ */
+
+#ifndef SE_IOCTL_H
+#define SE_IOCTL_H
+
+#include <linux/types.h>
+
+#define SE_TYPE_STR_DBG			"dbg"
+#define SE_TYPE_STR_HSM			"hsm"
+#define SE_TYPE_ID_UNKWN		0x0
+#define SE_TYPE_ID_DBG			0x1
+#define SE_TYPE_ID_HSM			0x2
+/* IOCTL definitions. */
+
+struct se_ioctl_setup_iobuf {
+	void __user *user_buf;
+	__u32 length;
+	__u32 flags;
+	__u64 ele_addr;
+};
+
+struct se_ioctl_shared_mem_cfg {
+	__u32 base_offset;
+	__u32 size;
+};
+
+struct se_ioctl_get_if_info {
+	__u8 se_if_id;
+	__u8 interrupt_idx;
+	__u8 tz;
+	__u8 did;
+	__u8 cmd_tag;
+	__u8 rsp_tag;
+	__u8 success_tag;
+	__u8 base_api_ver;
+	__u8 fw_api_ver;
+};
+
+struct se_ioctl_cmd_snd_rcv_rsp_info {
+	__u32 __user *tx_buf;
+	int tx_buf_sz;
+	__u32 __user *rx_buf;
+	int rx_buf_sz;
+};
+
+struct se_ioctl_get_soc_info {
+	__u16 soc_id;
+	__u16 soc_rev;
+};
+
+/* IO Buffer Flags */
+#define SE_IO_BUF_FLAGS_IS_OUTPUT	(0x00u)
+#define SE_IO_BUF_FLAGS_IS_INPUT	(0x01u)
+#define SE_IO_BUF_FLAGS_USE_SEC_MEM	(0x02u)
+#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR	(0x04u)
+#define SE_IO_BUF_FLAGS_IS_IN_OUT	(0x10u)
+
+/* IOCTLS */
+#define SE_IOCTL			0x0A /* like MISC_MAJOR. */
+
+/*
+ * ioctl to designated the current fd as logical-reciever.
+ * This is ioctl is send when the nvm-daemon, a slave to the
+ * firmware is started by the user.
+ */
+#define SE_IOCTL_ENABLE_CMD_RCV	_IO(SE_IOCTL, 0x01)
+
+/*
+ * ioctl to get the buffer allocated from the memory, which is shared
+ * between kernel and FW.
+ * Post allocation, the kernel tagged the allocated memory with:
+ *  Output
+ *  Input
+ *  Input-Output
+ *  Short address
+ *  Secure-memory
+ */
+#define SE_IOCTL_SETUP_IOBUF	_IOWR(SE_IOCTL, 0x03, struct se_ioctl_setup_iobuf)
+
+/*
+ * ioctl to get the mu information, that is used to exchange message
+ * with FW, from user-spaced.
+ */
+#define SE_IOCTL_GET_MU_INFO	_IOR(SE_IOCTL, 0x04, struct se_ioctl_get_if_info)
+/*
+ * ioctl to get SoC Info from user-space.
+ */
+#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, struct se_ioctl_get_soc_info)
+
+/*
+ * ioctl to send command and receive response from user-space.
+ */
+#define SE_IOCTL_CMD_SEND_RCV_RSP _IOWR(SE_IOCTL, 0x07, struct se_ioctl_cmd_snd_rcv_rsp_info)
+#endif

-- 
2.43.0


