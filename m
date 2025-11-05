Return-Path: <linux-kernel+bounces-885840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5EC3404D
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 06:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61312424146
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 05:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427A287272;
	Wed,  5 Nov 2025 05:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VAm5NSzO"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F5286881;
	Wed,  5 Nov 2025 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762322099; cv=fail; b=ohaBt5ARA4982M7PVlIjHbggDvygSil0DLfciNAgX0hs7RUikfZMb8u5MsLLkXDc2a3Op60lt7Vchzyj4f7YR0ZPR0OF+2O/1t5HzgnI/hj/nW4FxYpQ0A4LliIseWsKA/Ea59MAWwYmZDAqkxWpJ2JSS9LkrMA4TrZE77+1l4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762322099; c=relaxed/simple;
	bh=YqgQGGQ3WFhyrOrhM4MoAM75fyTvcH7JjT1DmQs4voM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CG5mPtWMmJT3XlSw8qHGA/HPiGUlLu1CHH/6+gWPay0v88MLTxiL2bLg/t/hca7IU3YSEEy62RdhNxupBjFsWGKF96qpe/T2OOHBJC4gsKz2/h6rGu4BxOFLAEFiGRiJHC/WFDQm0bQk2sJJ3wLqt2qGiBpXYWcGTCgB9g/8Ca4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VAm5NSzO; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVNk982Cmgp5MoWMIv/PymVU7yJvQj36if4zgBhoX8j4XwYpJmNXb7yarBkxP8U9AsGVHffd9gwlRU4SjtudXIt1nHuQKvXI+G8oXi+arbm55fINnmBHBroh+fYm3pWDef7PZmJaGK7hqITh4X3HLAO+z7fgIXTpr4WC0BZZwbtRyzN6diu6a8R7ZN6RzV90fydWx2eVE23x9juzyg81EqIcrGsJDYiE1f9yCRp6NBULhn+LMxAQHzPm0x1nuvU+b7IylK6CXJ/bWxU3ujAsBwBAngGPjn5VAjcueGxgUDWnppsw4mih3Thq8AW5mL5K6PzQnTyHZZbf+tHSNDr9Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoztExghkHCqGkPqcooLTMr1ggnDhPrl3Hb86U+80HI=;
 b=g/p6xKUhmKQshi1Vmt28ek53xUNqZYH10dRxTfpzlnfnDLkGIYrWtb8pLZwDgg/sCmkPF8LfJ4MqnF9NsQE55lA4EtTV2SkV00negbrSKn168L+xFrkiQRdC/9kWK6ZgSagcd6grcSrWrecVPrGRM59bOFbcz4gn9owxylsBGEhrEVuq/E0MnGdVINKxJlAZmk658YNGecHChKQU9X8Vlsd/6tsGQ4uqKYChqc3U4Q2Tex3gix1cSRSSvICLbHVqtEmTcHSetwDymsxMl0ULuuL/fIosTsWWVmqsAk3rYpZXeta+dKU/M0/TZXvaHb3+Q69R1rhHbmejcSVE3d+Uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GoztExghkHCqGkPqcooLTMr1ggnDhPrl3Hb86U+80HI=;
 b=VAm5NSzOPklR6x489JLho5mEE/QN6aCF7YaqsZXLpssZmBn0bfxzh0X93698QH5vblcxA2+Mqrqt8Gy6N3OoTmYVQp6Jf7x2uoyYG9xQVzrEhd5Gb4A8rSH4sRL65M8zkJxFgFuGB15cYBOENc7hjGhfVTGmzqUNv0bBdcxdFnIY6Odft+KwfvF9GVLm4F21ac43oxi6fw1og9CkLj9u+pK+tBJOJ9JMLjWdU5ZsNMA1EghiwZBd8p1wldYcXXre3kElfrSjT9av9pecppJIhfs8daqwVxynL7l1pPdnXdjxfvQQ9jgcwBovWECH7WqNZH1jf8upiDxvi7egbdu+Qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by AM8PR04MB8002.eurprd04.prod.outlook.com (2603:10a6:20b:247::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 05:54:53 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 05:54:53 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Wed, 05 Nov 2025 13:55:11 +0800
Subject: [PATCH v3 2/3] media: nxp: imx8-isi: Keep the default value for
 BLANK_PXL field
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-isi_imx95-v3-2-3987533cca1c@nxp.com>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
In-Reply-To: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762322131; l=1885;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=UI24isGZ2rZx/LL+s59Zl48MTTdH4ur1WhcJ2jDXedo=;
 b=zq8IljmwjLCHBrtGCawQMRXkoHPaRxJoNz6sMT4Ert6o+eL50xOrbeFUl+rFPmxV3BzgL9Mdv
 FM24Ttt6Ol7CTE7U7DnHk745nKXw/bYVfEejhpawZIRJ+oPXxm8jwnM
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|AM8PR04MB8002:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbe5b42-5816-4ab5-17c4-08de1c2fd768
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QnNQb0tsTWkwUk1LNlZQakUvWU5rZjU4cklGTlNGT0dXN0Rwckl6T1ZwRHFa?=
 =?utf-8?B?ZzRuc0ZKUXhCY1hta3BnSVhoNWpVOU9EejhDb3ZHbEVIcDliTnFDdGhkc3pu?=
 =?utf-8?B?eFBvVXBlRExXTExqK3YvWks2UUV2TUZNYVNPZVlhQ1k1ZmZaa0k1ZEx5YndN?=
 =?utf-8?B?K25uRlI5bGtXUytDd05udnAvSW8yc3pDZlhwcWQyYUJqd3ZIVjZDOStBUE15?=
 =?utf-8?B?TkJOc05zRWwyUCswaGRVL2FVS1FDM3AwMU0vVFFablJyb0xScWFiVlpSVUp0?=
 =?utf-8?B?Y29PM2V0N2FRdHJmZEZMV28ydmhEeC9nTkk0bkZwQTBzVXNuREhkbGNnNmFK?=
 =?utf-8?B?QUF3OG5mNE10bGlqaHB6VTc4Ync4YVNIZWRjcDVaWlRRMTZNUy9JWnFDU0ZP?=
 =?utf-8?B?OGY3bTBBc3dPd2l6T3A1bE5KTXBlWTBhUzFzcjQ1VkNVc2t4UjNSelRaYW40?=
 =?utf-8?B?bFd1bjlUUTh5S1h6QVM2YmlkSjhWZWZVSzFlT0xiNE43UWszSi9scW5ENjhx?=
 =?utf-8?B?SmxQZ3JvWDF4ZkRDR0l3V01pQTNZYWpneWRPOFlXb09sQ0hYYkVyNzM0N0oz?=
 =?utf-8?B?QWxqU25qR05qQXJ6Q0VmcUVGaDdoRGpUZDVHTzEreUlDWFh6TjB3TWZ1NWhv?=
 =?utf-8?B?WDhVUlFrMVR6UmxJZm5RWm92dDhhdXBrS3FISDhzYnhtVHAwYTdwZmJ2NFdw?=
 =?utf-8?B?aWtDSnR6N2FHRTRkMXZTb1gycjRrUXZOYWlPUmNHR2ZZbUdva2p2QjhQUGRa?=
 =?utf-8?B?QXh0VXFsajcvQU13U1JEZnJ2TFFZRWlEUmw0QkxKQkJLOGJaYkpiRENOT0FS?=
 =?utf-8?B?K25OQWdFWm5lblpqUFIwVGFjU21nRVhTbXQzQTFNVHRDVWIrc2ZYWlVxK2ov?=
 =?utf-8?B?V2tHTFJkd29KdldCODBSRnVDaDVmMjdOemJBMEF5ZHhnektYRFNOMU9MWUFS?=
 =?utf-8?B?WnlyOHgxcDBEd2JSRm9hazBQb1JGM3g1TTQ1VCt4V0pBRzVmY1MxQXhlb09O?=
 =?utf-8?B?eW9wMzYwUXBFNXBvN0JmSFlOdUlON2tnTEdkSGhoL1YvaVpOaGRFMVlTaDY5?=
 =?utf-8?B?M21CN2FJNmlsaUtOSDV4MVlCUTZ4ekZWL3Npc1F1bG5TbnFLR0VTMFBtamIx?=
 =?utf-8?B?bWRSclZGK1NiaEQwYVE0alRaUFZhSmFvQy9YbE9XN2NxenJhVjFTWm10U1BQ?=
 =?utf-8?B?QmhabkxjRk9KanE0b0pQMkl1Y2g4b1c3bnNjM1g5cHZGbnBpUjZ3R0d5RDBL?=
 =?utf-8?B?elgrOUxZMmxGQWNyS1E5ZWJFUkZ3M2ZtdEpKcTNoditOdDhPSDduNFZteC9h?=
 =?utf-8?B?d2xtTm14cXBvZEdMWXIra21hd0EvMElIbm9QNklHaTdNSHdMYUpiZlBDRkta?=
 =?utf-8?B?ZEVBNzdlM1Q4R25NcTdNZ2VjSm5vSTJxdjNTd0hJUFdLY003SWJaYVUyZms0?=
 =?utf-8?B?NFhhSlhrS085SzFaUUFDYks2U2NaWWZndGRyWFhveFFUczNlWDE0S0hFRU5K?=
 =?utf-8?B?Q2JjejVVR3FDc2hwUGxDdXp5R1cwcGF3ZDRPbTlNZU9PcXc4bWRjek1PRDEw?=
 =?utf-8?B?cjRBdXBlSjRYaXZSU3ZCOG5UeUhBa2xvVjUxTStiSHNEenVTaE10WTRYZDdZ?=
 =?utf-8?B?eW5JVG1ObWhUVVJ6OGsxZXlHVnFhZUYzTkhKMmdoWkRCU3lUcnV2RTg5ZjZE?=
 =?utf-8?B?Z2sya2xSZWNRbjJGQlZHWWg1TmU0ajNVRWhZUnlOUStlNlpueldiV3A4T0U4?=
 =?utf-8?B?K2dSRHdHVGhNTWVsNlBXaEFhV3RXWEhhY0JKbFFhdisyOXJHcjAyMmtGcE45?=
 =?utf-8?B?TFhuc0RZNHRCVnhESXVtbWNqRGxHbGI0cU1IVFlaZVhVWFE5SlBLNm1HRUo0?=
 =?utf-8?B?S1h2Y1FLL2E0YVAyRjZHd2dDdFBLdXBlV2lJWkxEK2gyaHVVM3ZteGxCTDB6?=
 =?utf-8?B?eVVrUHR6VHFKTThOdGVGbU1CR3VkV05uQStUMG85RWIreHVuK29pNHlCUUJD?=
 =?utf-8?B?LzRCdUt1Z2tlK2pJNm5xbUlkV1gxN0ttZFFtZmdOV2hieHJWQUdyNG5vdC9r?=
 =?utf-8?B?bEMvenJUNkkxQVFrTmVxTW1jVWUzdEJYTFF1QT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UVNjaUY1MUtHZVYra20xOU1oMG9kQVh0Mkc3d2xFWDBMUjR4RjRrdmF2QVpS?=
 =?utf-8?B?Qm9HVFhvMlJHUGVrK3MyU04xM3ZGaUxnR3Y2TitBak1DNXdnVW9LdFRHZ21E?=
 =?utf-8?B?Z3lFOG1IRXZJd1REbm5oODJtSUU3UTMvMFZrd1pxc3hDdnBsOENLUndxVkJU?=
 =?utf-8?B?b1FyZm9aZnYwNGRGZ200NzFnVnJLRkRvTDBoU3RDNllIczBJT1dsV2t3clJj?=
 =?utf-8?B?SG9WRkhDVWg3SThwZXpoV2NtSHA3VkR1Qkg4NHg5bDkyeUJDbjBOUkxYYW95?=
 =?utf-8?B?VUFIL2FtaXBqNiszRXFMSnpuWGw4YUN1TENIa2R6a2R2RlBvK3JTb1hrRlF6?=
 =?utf-8?B?dkxaaDVHMDJEcG5OQzZpbHFUTnIxakxoeGRJdURjYllwWTI4U2tnS0pKa2sr?=
 =?utf-8?B?WnVoalBGN014Qk42M3ZwK2JwNGExcmNtekFRNVg3TlA1U21mbUJxTHcvWFNw?=
 =?utf-8?B?enhBYlp2ay9HcThSSnc5OVNublpUaGFTZmU1cjRZVUhSaUQwdk1LS0IyS203?=
 =?utf-8?B?OXpTL1RFUEU5Nkp4bi96SzUyV2Z6TlFxRjVZOHB1ZUtZeHA4QUFBZUVYaFFU?=
 =?utf-8?B?ZDIvMitZOFFLVDdTbUhFQnI3S0dZSVhrZVFwMmRVV3ZVLzZBMnh1ZnVYMEl4?=
 =?utf-8?B?UmtMOHRDN2cvVkp4K0JjcDdRSXZ2Q3RRY1VNZFI1ZjdZQVliVC8zY2grRFha?=
 =?utf-8?B?S0Q1Z2U5MXVyWkhQb1cwZjJUVS8xK1ovYTRxWi9jQzQrd2FKaU9kVFMxYnVZ?=
 =?utf-8?B?Y2tCS0JLWGRMZ2RyQ3VBMjc0UFZ4MXkrclppTWhUaVo3OWdhTGpJRGgraFVu?=
 =?utf-8?B?UjdZZkZmUkViZXhJU0NUdEJsNThRTURiaDlFMnR1aTVqeDA1MGpPcFNGakVC?=
 =?utf-8?B?c21iMnlqZDFwZWpFOHRpQjBzbWRhNVQ3eWgvaDRWQW5kUzBMVHZVcEhUNEJT?=
 =?utf-8?B?VHNjbGZSTEJhbHUwTTEyUFAyWDJjN3IrTmdmWnNPL3FaVTljTkptYmdIQjZT?=
 =?utf-8?B?VGFRV2NCa09UeGE1OUwxNmUxQytlNkVYcUg2UDVPamN6dUFEUDlvK1QrYlV1?=
 =?utf-8?B?N0s5Qm5kK2dieWptSCtyUTFQTlNjYnhyc2xZdjlVOTMzYTl1S3BzRCtsWTk5?=
 =?utf-8?B?MDVWQWxmZmpwVTA2VndlKy9jOFg2dU8rdk9XWGN4SE43THduTW5xVUV3NFRE?=
 =?utf-8?B?R2l1U0Y4VmkrR1VMN3NUWVFkYUdzRVdEQTZNMmVxMGZzalhOOEdPREk4bXF6?=
 =?utf-8?B?VTlldjd6U2FYb2orUUlFUTBoaWhLZEpwVEd6WHo4cHZtendoNXFrVitPRDhj?=
 =?utf-8?B?MzFWMUpZZmliMXNDTFZDSFhibytQZm1KUXpVSVlteWtPVWRWc3dFQUNObTJX?=
 =?utf-8?B?azlGbkwremJMYit5NDBxOHpDZ1dUV1ljTlRKRDg3SGpRQnRUV2RmRUkyWE1U?=
 =?utf-8?B?TWtsaFRDTDk4OGNGc285MW5kMGpIei9WcUEzSTM3a1hzekZTR0cyeHloU09D?=
 =?utf-8?B?UTZUbzhnWkVmbWtkQ0hUS1BWY1NaMGhPdG9YQVJISjRleUV0RDY0Zzk0RnFu?=
 =?utf-8?B?dXluU0RJT1FrR1lxaUk5enhkVlg2dU8xZkJqcktmaHJ0aXc5Uys1K3p2bWNS?=
 =?utf-8?B?b0tScFRtWHpQNGp4TUxZb0JCWkgrZHFPMHBMWmM4bG1iWGRmZUxsQ1BIUmRC?=
 =?utf-8?B?MkJ4TjM1Wk9DejJleVBnUTF1NW82OGgwZVUwWGpKZkNyM0xGUHlmMnowZkRk?=
 =?utf-8?B?dDRNM0sxQnYzZ2NSWndGclJlQXA0MnFKSGhleER0amlMU1E4K2NEZVNqMkFh?=
 =?utf-8?B?YURZWHFVbTBRb3NHWlA5VXllMk5XTG9CRC8zRHprVzIzN2JYNkhUcUJyQmll?=
 =?utf-8?B?d3ozd1hWV1NhZXdDeEZRVWFhYTM4TG9JL2U3V29kb3BMWXJ3aUYzeU1tajU1?=
 =?utf-8?B?K0IvWXNDME9PM0FDVmN1Z1ljQWQ1UWxGTWVpQkNwdlBwcERKMm9haVNzUG1E?=
 =?utf-8?B?RFo3Zm1RalBDTmZxUzFCTVVZSXBvMXFuSUFtNGpMOTMwckI4UENSZy8reVgv?=
 =?utf-8?B?ZWtjbWpadFlxUEF6a085L0NCTWNSTDc4Q3NNbUxFWW8yYlRnNlhkaDdwdXBt?=
 =?utf-8?Q?u3ZLqcsb/qF5L6Zuss2Cp8D9k?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbe5b42-5816-4ab5-17c4-08de1c2fd768
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 05:54:53.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eERuATfQHPii/ZLlLHtsD8VGizGNadD23P8h1HGwR27Q68Eht+9dBlTCXDfPb7bu50J4U/8uPcr8l9cb4fX0Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8002

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The field BLANK_PXL provides the value of the blank pixel to be inserted
in the image in case an overflow error occurs in the output buffers of
the channel. Its default value is 0xff, so no need to set again.

Besides, the field only exist in i.MX8QM/XP ISI version. Other versions
like i.MX 8M series, remove the field since it won't send data to AXI bus
when overflow error occurs and mark BLANK_PXL as reserved. i.MX9 series
use it for other purposes.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
index 9225a7ac1c3ee7e42e64983982eb4b6c27e356fe..0187d4ab97e8e28fca9013f6864a094e08f2c570 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c
@@ -309,8 +309,8 @@ static void mxc_isi_channel_set_control(struct mxc_isi_pipe *pipe,
 
 	val = mxc_isi_read(pipe, CHNL_CTRL);
 	val &= ~(CHNL_CTRL_CHNL_BYPASS | CHNL_CTRL_CHAIN_BUF_MASK |
-		 CHNL_CTRL_BLANK_PXL_MASK | CHNL_CTRL_SRC_TYPE_MASK |
-		 CHNL_CTRL_MIPI_VC_ID_MASK | CHNL_CTRL_SRC_INPUT_MASK);
+		 CHNL_CTRL_SRC_TYPE_MASK | CHNL_CTRL_MIPI_VC_ID_MASK |
+		 CHNL_CTRL_SRC_INPUT_MASK);
 
 	/*
 	 * If no scaling or color space conversion is needed, bypass the
@@ -323,8 +323,6 @@ static void mxc_isi_channel_set_control(struct mxc_isi_pipe *pipe,
 	if (pipe->chained)
 		val |= CHNL_CTRL_CHAIN_BUF(CHNL_CTRL_CHAIN_BUF_2_CHAIN);
 
-	val |= CHNL_CTRL_BLANK_PXL(0xff);
-
 	/* Input source (including VC configuration for CSI-2) */
 	if (input == MXC_ISI_INPUT_MEM) {
 		/*

-- 
2.34.1


