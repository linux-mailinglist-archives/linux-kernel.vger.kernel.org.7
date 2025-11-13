Return-Path: <linux-kernel+bounces-899129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D3AC56DC9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:31:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E77A353E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADC4330329;
	Thu, 13 Nov 2025 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FjxYC7Ss"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7F9334395;
	Thu, 13 Nov 2025 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029670; cv=fail; b=lpDU0xk7CDvPSg9ptckY+/e/LK4La9rafZ7EgQ2rdnp5DvI7yy60oLSOESvOl9nbRbyPuhEMoIWG8hdL9255G5XdMBuL6m38S/7sxAffwGTjhlcy+v0J5ixJzGNBhHPYaMPkRusk50ZmVbw9Y1ncuztYXfr5bLBTPmm4AfhinNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029670; c=relaxed/simple;
	bh=j7pO0U/vX3Eo6mDBPo+tB6+EKCtdBRCcpusjWT1xDd0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BppFaLHyXzvTmZEO0Y2siyU11OVRUD320ASVD1ZlcVET8TiIUuJdOqUcMM5d4SLJzYXOE7yUSbs4Ia6iU7UunP1gict9hDBU1NeoRgvGUmwX3rUWikHa+5hlv8n6yHuqAW1oE7qBGwW8CO5fPH0mUAtKUlxmbuI7qCoJSBPs59k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FjxYC7Ss; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHXqa0noGFde+lpMx8iE07xgb8GioAn0/4mZUl0hqsNwj6WalMlH1KcWnl2F9vU3XXTbXCDXgVgp7fxmXZrRrA1lhcvk7nPKOHNwPFVh1NiBHY3Q3u17smLb6AeYp4HxHPnmZQfGq74UqCEN0VmEhvKVb9KKeqIkqsAOOZKV3ySt6pzSxm4b0n1Xs/I6sg9mHMUILtmnHNPkVfPsyu/6m7DNgzfi6v06WCjDwxGF5LvI0OxVqcGreZ/HJPOi1ecN4X08FjwRIt9a4c7Xd3tjzEbSTBzZa/Dg3mEmuipEhvsmaVKOkrncjN2xZ+3xXqX1f+slODEtoNxemYm+bafdKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAHnykv+oPFVn8h63+wcXMPDqInG7mBWbvzr8dEFq9A=;
 b=mnoC9M12EY0e2jGC94yHnJgfc34Rlha1+Wn9rgl1ej2HLggJ/cI8boEnZLv/NBJQk66JDmeJ9wLNUBME2ctLaOxgcdOXB6m5DX5H4Cn047uqrQY+IbDGcurr853ywfS0t8gmlKB6OqXAmhT3VhDkVTgpyKwAaRKotsT22LfkkjqWJKFt8uWEKJJEehgEkA1sGsex0voyaZld+gwKJJtGe1oLsDE10tgwrhplqu9YlIxn3gBwa8YP3vt3WZC+UYtZuNlV8MTPv5ySu0tNcIGfXe8IN2B4iD6+/PC8MGrWUqbvVWhTGD4KEGqIOjRQeMY0ofYSPlSHyibp4mgXI/RBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAHnykv+oPFVn8h63+wcXMPDqInG7mBWbvzr8dEFq9A=;
 b=FjxYC7Sshi89OpCMHY2k81MFfMON98H3e7MCdMWPLwWbUW+7Q5fhtrAKNtc+/H2IME3UXV9Y1Ih6x71VDkekCLEPV4+nWa9OddnP03NjdawhuuRqiUSHCPD3wPKgHhcY1Pqwf8EkhF+d2QmxAAC1z65w/wQv63KpASEPHcq3ySLNCvs6LyE4+qIMvAalBMEe11QJP1iIKyQNOmjkuA4vnL/7ILHAzFdbUWb97R1S/PjtcLcIqmiompJzKOgJNp+wdqoR284ChrTSambREUKxwj6e0TZigCLtnDur1W6wUZsv9BZ+IpTt6jW7A7Ijp0r5gUOZJCkruYVMRXSgvLwHvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:44 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:44 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Thu, 13 Nov 2025 18:27:35 +0800
Subject: [PATCH v8 5/5] arm64: dts: imx8ulp: Add CSI and ISI Nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-csi2_imx8ulp-v8-5-2ebe378f7111@nxp.com>
References: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
In-Reply-To: <20251113-csi2_imx8ulp-v8-0-2ebe378f7111@nxp.com>
To: Rui Miguel Silva <rmfrfs@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Martin Kepplinger <martink@posteo.de>, Purism Kernel Team <kernel@puri.sm>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=3075;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=pafiDd8TT+F3YKZUKFnv2yYEiY+Kqw4JnA7sm+f9DV0=;
 b=p0dVKmwmMStAJSbqtIcdgCv2+lSpfGE1jdyNTA95yf0AVl+vZbjwcUlIeXPlfgGQSSsAkt4lw
 uCH+R9S5V1sCG9RgHqa96ybMd4mMpA5cLNjx088fLmOY6lUEvi06MtQ
X-Developer-Key: i=guoniu.zhou@nxp.com; a=ed25519;
 pk=MM+/XICg5S78/gs+f9wtGP6yIvkyjTdZwfaxXeu5rlo=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To AS8PR04MB9080.eurprd04.prod.outlook.com
 (2603:10a6:20b:447::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9080:EE_|GV1PR04MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: 5093702e-c5c1-4ada-70c4-08de229f4865
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cS9kbFF0cUQwWS9LeURkUHdEV2hLd05rb3J4NXMrRXZQdk5ENThsNC85blpl?=
 =?utf-8?B?dVZjamdCekIzYkpKZEthdTZrb283NnMwc0w5cHg3OVA4cmExbXVHb3VmTjM3?=
 =?utf-8?B?dmlLWlB2bERDakhWNzJXZUMwUTJnYWNyK2JYd1ViLzYwOGNJSlV5WTBkYkF6?=
 =?utf-8?B?WkJ5L1RscjdhS3phRGJKK3dSUkRLdVBmYzlrZVZkVmhGUDV2UDVCRGdrSDQ1?=
 =?utf-8?B?NGJkR3ZrK3ZBZnN1Y0EzMVpmTDVINTlDa3ZaM3BLaWRTWjg4VFdtbXB1Tksy?=
 =?utf-8?B?N1VHS0ZIbGorL2JESzdYM0c2NDFCWFk0cmx4ZHp0MFdvNGx1RGdNaEExZmlU?=
 =?utf-8?B?QlRCVUgzUnNkMEFmU1hsQ2duSUxaVkZmS29vcWRPQ21OVTR0NjBUVkE0Mmto?=
 =?utf-8?B?c09aSWliT3FhY1llTlZ6L0l6THhmb1U1RnJRbml6cEdzdTRCeWVqbnU5OHNp?=
 =?utf-8?B?OTJHa2xPRWVmS0g4MVFwRi9OMHVEZkNsMlNtUVR1WVp6RVp2cHJUbUduU0NE?=
 =?utf-8?B?ZXhsclRJd01TN1ZYY3I5SXNMMW5RVUtZdnZwTnR6WHp3RXM4STVhMEw0UEN2?=
 =?utf-8?B?M0ptbVROVjBqQ0l4N0FnZjFxTkQ0NGlNbXNaa1NlVHJZQ3pzaTdBa0dyOGtj?=
 =?utf-8?B?dWkzYzV0dEsySE5mY2huQklYTU4zV1N2QXNLWmlTZXVrQjNXK2UxK0xiU3hI?=
 =?utf-8?B?TGpMdG1mK3RUZEU3VVhhMG1OYkRwZ0prUnEvejRvWEVkK0RIZmpEVTRNcjQr?=
 =?utf-8?B?TWRtN1hzS3B1OTVuMFBqVy95aXBkVVNmUEMwM0NicnE2SFY5UFd2Y2hScUNE?=
 =?utf-8?B?MVUvLzRyVnlpTUYwNUE0NCtrZWJlQ1hRSG9ZZHRObzZKSDJEY25oNmJkSGxQ?=
 =?utf-8?B?RVlBckN0K2RGMzNSMVFvTk9CVk1UZWtYM2NJS3Y2TktHaDBZZnlJWnFmY0JX?=
 =?utf-8?B?QW1KN3luMVdoMVR3WmRJMDY5QjJ1V040dnJPQUh3bTB3RlVZNUZKdUZLNVdo?=
 =?utf-8?B?Tit5eUJIdFR1eVNzNkdCeVM5aEhEcG1OenNoVTdmZTZHNDJMUVR5THV5aE5V?=
 =?utf-8?B?R2k2MUdRK2d6TlBzdXRyYkxucnRDWFM1QVEzdXZNNUFkR0MzTjU1eW85ekhY?=
 =?utf-8?B?Sll6NG5SdmFUTTFtbENxbWRLZThiZXI1R0hlVHFSeVgreHc2RjFncjlkRHJo?=
 =?utf-8?B?TEZNTE5Ha1d3UnBmMzRkOU1rcWFmNmViN1NwOGYrZXBrUS9jOWwycnJ5d1h2?=
 =?utf-8?B?WXBmaDI4TGF4dCtLK1UwL2owd1FLRUlXMkVYUmEvMmlMNS9rY0hBZFMxWWc1?=
 =?utf-8?B?MEFSVnR4bkJBZnZoWUxJaGtHRXcxUzJOZkpIeUF1bCt4Q0s3aE0vd2MyUHV5?=
 =?utf-8?B?VVhLR0Rkc0Q5dUdWcFM2NkdMdVpxZzJLTlMvNTlESVhxK0NoQ1BwQlJqdnE2?=
 =?utf-8?B?V1JScUYxbXV1cEppUm1YUkJZTTJoY2lmMHN3V1JjWVJsbzVTeTBkcG9HNWla?=
 =?utf-8?B?eXJ0YlNBUjY0MXU5aERWTEY3NEVBU1plUnQ1czZsYmcyeFJuNHFvbVk1S2FC?=
 =?utf-8?B?VWF2c3pXWUM3dkt6R0FYTkZad2Jrd1R6dURLQVlvT3NVMTRycWpJRnU5ZkNW?=
 =?utf-8?B?WFpTMndDUndSS3lYWFJiWmllSDZJUVF1Z0JkMzlaL3VVUmkvdDRCc1ZSMk83?=
 =?utf-8?B?anpBb1kyRFZJOFJDeEhxVnhNTVUrZWxBVmRKdkFlMWVBWGYvejZ4cGZBNnR2?=
 =?utf-8?B?dHY1ejZpYWoyS2tjcDhvNkY2RmgvcVgweUN5MGRRWUJMRnNtTEM0MjBnRjJj?=
 =?utf-8?B?OWRXUjVOZ2ZaSXNkakJKTVhpSy94am9aeGNOMjZZOWNQS0czaTN4c1NLOGlM?=
 =?utf-8?B?dVl2MElSNWNaRksxL2dwUnpTUDR5Y3BIUkhKQndnZDdidEJQYzBVeTVnaTJn?=
 =?utf-8?B?Z3ZhanJnMDR1bGFmZGxtVjNhOGxQb1BlRlpINjE0MmVXV2F5NHRkR21DTGNm?=
 =?utf-8?B?RTNIakZjM1c1Y0ZCZlpDWXFGeFFCRGt6Tld5NWM4dWROZ2VkSDU1bzhOR09T?=
 =?utf-8?B?V2lLTEpGdzh3cWQyL285WnhTYm1lOWZXNWpOUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Z2VPRzI0VlRteTNldDRmMGFZUjF4UWVISXJtRmt2Z0ZpN0M5UEd0SWF5MjRG?=
 =?utf-8?B?ZE9mcjNwVlJzdXd4WW80RkVRQXlQR0IvUEx5cC9nN1AwbGVuU2xPRTFzT3hH?=
 =?utf-8?B?dTR1cm5mbFMyU095cEdRWEdYSVRnRVpudVlsMzQwVVZqdHlXM1hKSjc0UWZv?=
 =?utf-8?B?Vy9QZnZRbTlIR1IyajFjVEF6azMrelVPZGtKaUdZbDRDeERWWmJkU0xOMzJy?=
 =?utf-8?B?VWhPaWg1S24rWnVCOGFNMFJNNXBRMFZ1UVRvTktiL01kS3J4cG5OV2FDbGtr?=
 =?utf-8?B?dzBQdytYSEYyZGk0ZExBV1U3Ni85MVhweCtjZEF2MDR6ZG0rOWM2QkFaak5K?=
 =?utf-8?B?eEtWVzh6Tkp1Z3FvU1NhRjBNWm9SWTYrTks4eWNhelNvS0ZQNGdsRmczS1l5?=
 =?utf-8?B?RzlEQVZma3dhNW1lb0U4OURyaGQwVGFRaWpvZHEwRGFQSUpHQ1NUMDFSekhB?=
 =?utf-8?B?YjBFSVErRWt2cFppY0F0UXZIa1RCVkxuTGZ1dGhVMElJL1F6VWJQVkxUZko1?=
 =?utf-8?B?bHE3eXl0T1p6TFhnc1M5dm00dzFpSHNBR1M5eld2OEljenRSRDRaTzZSWEtr?=
 =?utf-8?B?eEJOeFZOeis2NEltREt1dFZlYzc3bDExNHQyL3lERUlsODlvbDl4VXdRWk5l?=
 =?utf-8?B?OVhTSyttNGZxanFldjUvK21DMFp3MzVZL3BNYXB6YWxPeFhWd0I1WEI0SDNp?=
 =?utf-8?B?ZlY1RFRGVGppdVdleEZmRDI5QVhKazR5TkdVTFFFcWdXUGJYb2FMa2UwQjF4?=
 =?utf-8?B?VXNiSm5qaWhhYi9ZL1hyeURudHk3SHlRRHJqcDMzaUZuMUtuWHNqRTRNd0Nh?=
 =?utf-8?B?MDFPSDZ3QmJ3VmVoQ3huanhDRkJOVmZaQVNOcG11eG5zbEdFU2FxRGhaWWtI?=
 =?utf-8?B?NmN1djl3K1RWbkFYZUlweCtBQ0hUaFhvQ3ZkbUxScTA0UEVJaFI0U1hVdDdZ?=
 =?utf-8?B?eHBiQVpqTzQvNzh3dVFybHdiMjNCdFpHRDM2REVRZWtHMzBheUVVT1hBanpy?=
 =?utf-8?B?Qk1NaWJqMWxsU1dQM2ZWczFmK3ptaVNBbk9pSTFBd3B2SGxrT2toaFpnZEg1?=
 =?utf-8?B?a05DL1RkU0JCQTNRRUtqT214T09XNENVK0JuTk92Y0pVQVRXMEhEeFFhUVJ2?=
 =?utf-8?B?VXNabkhlNGozMkN0blhPRjJFRmZET08yd2VMRXd0bTdKWFpmWHNxWFZlblV6?=
 =?utf-8?B?NFFpY21PZmNBQlVtblEzMFdPSzRqZVQ0OUpOZm5xa0hVTGNPNmxLMmFxOERV?=
 =?utf-8?B?eER3b0kzRllSdXZQRWNVdG96cW9SS0tEVVRJUGtwckF5eTdSbTFEMHRLZ2w5?=
 =?utf-8?B?YWVoVktINjYyc1NNK282VlhrdG91VEtGNmdDb3pSVzA0WmdhYmZrVzBsYzdU?=
 =?utf-8?B?YnhpZjloMGVlZWVhMFJuYWJ3bkh3OGVQVVByTDhpdkNDdGZYMU15ckxFZTdM?=
 =?utf-8?B?aVdsUk5UUlMwcTNwckFwbCszU3ZML3VQc3AxU2xsTVJDNmhkK3g3TUVBYW8v?=
 =?utf-8?B?a0F5WWw0YTlkVnMwby9BWXNRNndmY0tRZks1WEpYNVBPaVZVWTRXMURoR25K?=
 =?utf-8?B?RTBVc2lNb0RPWmhERngvcytwU0gwaW5GcFJzd2ZaYkhobFJxQVBuMjRWRStw?=
 =?utf-8?B?dUhWZ24rY2x2MklqU2ZYcXFKcmQxS1NWdWhza2paMFJJeERTNFF1QUFnbEpm?=
 =?utf-8?B?T2ZPWjRJZGFaSFhlSi9TWDNFVCtDVXQydWlkVDh1WEI5ODlMZjdPVFJSL3NB?=
 =?utf-8?B?VzZ3ck9pek1NOFRIZzYrd3VSWHRGQkpEQkhTVWNHeTRFdU8wWHBUMS9EV0lZ?=
 =?utf-8?B?YW4zOWJ6V3JKQzhVeW1ScWI0bU1WcXFtaGV5dFRMbDhjRTZ2dXR3Y2ZpWmY0?=
 =?utf-8?B?dDM5MEFVcFBPNC9vOVYrK0w5UUV3YThva1lkUlRmOER4Mmcvc0Z0UlZib0h4?=
 =?utf-8?B?OW16Q2daSktIZkd3Y3VQbnlRRlRJTVE5bmVob2VsUEczdFN2c1p2ci9SSVha?=
 =?utf-8?B?OXVmVnNHMGxEbHNGV1NBSzlnUWxjQlljR0xGY2Z1ckRYeHRNTHZWR1c5aDMz?=
 =?utf-8?B?U1hwL3F6N1JacVYvVGY0MGJnWU56TGJUZ21uU1FCS0lRMVprK2NWMlVFYy9l?=
 =?utf-8?Q?nIK0t9gMeGMpWD7Qr+hfWz7fV?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5093702e-c5c1-4ada-70c4-08de229f4865
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:44.5080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wW0rYc1KkHMeWADC/Oe5saPKrXLSXkL5SP31hx+/w+9a8docDc/VGv+/jqZz/wwEEX6/XtHtP6+I0U5KLH5XBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The CSI-2 in the i.MX8ULP is almost identical to the version present
in the i.MX8QXP/QM and is routed to the ISI. Add both the ISI and CSI
nodes and mark them as disabled by default since capture is dependent
on an attached camera.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi | 67 ++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 13b01f3aa2a4950c37e72e04f6bfb5995dc19178..99271d55dfb60ed2cbfe664d928be179eb257674 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/imx8ulp-power.h>
+#include <dt-bindings/reset/imx8ulp-pcc-reset.h>
 #include <dt-bindings/thermal/thermal.h>
 
 #include "imx8ulp-pinfunc.h"
@@ -842,6 +843,72 @@ spdif: spdif@2dab0000 {
 				dma-names = "rx", "tx";
 				status = "disabled";
 			};
+
+			isi: isi@2dac0000 {
+				compatible = "fsl,imx8ulp-isi";
+				reg = <0x2dac0000 0x10000>;
+				interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&pcc5 IMX8ULP_CLK_ISI>,
+					 <&cgc2 IMX8ULP_CLK_LPAV_AXI_DIV>;
+				clock-names = "axi", "apb";
+				power-domains = <&scmi_devpd IMX8ULP_PD_ISI>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						isi_in: endpoint {
+							remote-endpoint = <&mipi_csi_out>;
+						};
+					};
+				};
+			};
+
+			mipi_csi: csi@2daf0000 {
+				compatible = "fsl,imx8ulp-mipi-csi2";
+				reg = <0x2daf0000 0x10000>,
+				      <0x2dad0000 0x10000>;
+				clocks = <&pcc5 IMX8ULP_CLK_CSI>,
+					 <&pcc5 IMX8ULP_CLK_CSI_CLK_ESC>,
+					 <&pcc5 IMX8ULP_CLK_CSI_CLK_UI>,
+					 <&pcc5 IMX8ULP_CLK_CSI_REGS>;
+				clock-names = "core", "esc", "ui", "pclk";
+				assigned-clocks = <&pcc5 IMX8ULP_CLK_CSI>,
+						  <&pcc5 IMX8ULP_CLK_CSI_CLK_ESC>,
+						  <&pcc5 IMX8ULP_CLK_CSI_CLK_UI>,
+						  <&pcc5 IMX8ULP_CLK_CSI_REGS>;
+				assigned-clock-parents = <&cgc2 IMX8ULP_CLK_PLL4_PFD1_DIV1>,
+							 <&cgc2 IMX8ULP_CLK_PLL4_PFD1_DIV2>,
+							 <&cgc2 IMX8ULP_CLK_PLL4_PFD0_DIV1>;
+				assigned-clock-rates = <200000000>,
+						       <80000000>,
+						       <100000000>,
+						       <79200000>;
+				power-domains = <&scmi_devpd IMX8ULP_PD_MIPI_CSI>;
+				resets = <&pcc5 PCC5_CSI_SWRST>,
+					 <&pcc5 PCC5_CSI_REGS_SWRST>;
+				status = "disabled";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+					};
+
+					port@1 {
+						reg = <1>;
+
+						mipi_csi_out: endpoint {
+							remote-endpoint = <&isi_in>;
+						};
+					};
+				};
+			};
 		};
 
 		gpiod: gpio@2e200000 {

-- 
2.34.1


