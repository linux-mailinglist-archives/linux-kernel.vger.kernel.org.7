Return-Path: <linux-kernel+bounces-899126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 66741C56D8D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 727E635310C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7577E315D33;
	Thu, 13 Nov 2025 10:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ZGHuWxl+"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011068.outbound.protection.outlook.com [40.107.130.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00C331A7A;
	Thu, 13 Nov 2025 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029653; cv=fail; b=FoGPOcb4cgdIPIoZ9IX9LHjt6g3BkG1A32TiUCAg6X34y1QFnm3uTIuKFmN3tBd42L8CqHb9jSfEgAufwYYKnO17yk1tEjgTwizmNmAnCPfTw3ZBGsTcQ1x7llKSv8z50p/fj0pcrLdyhyCXMFw9Wkhh3IqBHsWSstlC6fhbqFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029653; c=relaxed/simple;
	bh=eEUB9HyFVg+9leAWEDQuulCpl+dC/y3DMYF6oSvQM4M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CWboHHM1Wb+dDpdgF73JSjv/3Udt1aSBbxCkF0eMEVSP9wAoMn4sQGW/EggCMM5CQmr1i5GLFwWX68KIl1QezqSkKFRUMWw1f3zVc/gQN8FY/JGzDkLffv8JNUSTw2J/qlY9IiVWIivsUSuWLcYoldwTM7/P0nIiuLLAxjW0bdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=ZGHuWxl+; arc=fail smtp.client-ip=40.107.130.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kjVh/b1rFWTdcInRXx6GEG8Z2/NKN3jthCXL84AGPlMCB7/R3/m71z4CUA+uVbaiY7ZlXJIt5k2CRRit/FDkxqwG0po+r/6fYdvnimcOZyVrYyS3FqxcMFQVjCbP5HfD38BvistU/VJaT4A9LzsjK1dYMUd2tWuaveO0W9on/6Nqg26+1rGdPhdt4y6lFiUb/yV77Z0L7VQQ4y/O2wCLMtqDcty0/ss3feS33BuHMCg6zl0I2LJ8vyuSPn+eMCRWQiScbMp6ddDGiO7MsURzW8/O1AlYDqctIPbmGwNlIu8UUkO9Jk27q+tb9qFhCZDBB5R6UNpBkKMmhbtEG2vjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzzrMXELb0HPieIp+4zKKKOdL6IxRAJ1Bnh3hJnqKI0=;
 b=ckfwhlIMOasFtzyScn9Q3n33Vkn/62T/ZEfYbFXwEUuoTDTT/AdES25mQ31j4RRQlEIBWAD8xFq/pfGZRfdGcGoLghvtPQLE8Vtujpzvo0+cNjPZeNFrzy8wTL+P7cOak3YyBENmGG4OIzl6zpGJAU2yiTTxM1IID7Vi/wuEzbr/lH7H8BlB3buO5nLJeqwPFonKo0c1rRMNmGRepE6fY6XJDh9rUlXJrAB6YLtaJg3PTarfkFdThlUiJHwXB7gEEsKaKWJTAU+ZDr7ZA/WO0xUN1122KSjOGk8N9VpXxn8qDoT+Qq0QOM52yB8Qtx3jWBgPA+C1ZaEl3cTz1pZeeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzzrMXELb0HPieIp+4zKKKOdL6IxRAJ1Bnh3hJnqKI0=;
 b=ZGHuWxl+DdFtiobK/vCsNmTVAgbjEO7//LzCeVOQ4wkNJkFKRjR2SqGtUXZmxL8NIScUPZXCdbyGWSb1S0OSAZq4Tmkb8efftITBzS5IWjtxemTXgp9j43+baCKWiR1xojGilfJodjlte5ldlb2/3jjF+TviWwSVRAPyhqybaLQXeG9ke6fZNpkYvDgziX4m47uIv0zhb6eRKQThzfYdWILtsZKXTl71/LERphBI98aOk9O61wRF4aeyEGuyUfceF0loLsjCqQVOMU0mdD0EF/jG/E7o96gFRRJn/nop3hM9KV/pZ5Zk2dlYzdMkmCtxn48Wt4R9qDxmg4dpBdvxUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:27 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:26 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Thu, 13 Nov 2025 18:27:32 +0800
Subject: [PATCH v8 2/5] media: imx8mq-mipi-csi2: Use
 devm_clk_bulk_get_all() to fetch clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-csi2_imx8ulp-v8-2-2ebe378f7111@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=4116;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=3q2quNB/uvwrq7nlE7YOdX2oJS39EzH0lioE7UsbVB4=;
 b=0x6CPByKoU8BHnZoqE44SIrcOM4qwePibo0tiICeAeDmfZPkrcZXCNNBCE+VTnFC7IKEpWkj7
 /ji24svIOKaCHOWuBA5grJCriqEXrFVrd3R0h3aO4Sfhc79OpTzxCr5
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
X-MS-Office365-Filtering-Correlation-Id: bd285d78-4b38-41db-6f72-08de229f3de5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?dFh5VE9CTnNKSCtFYk9OTUtyeGNqRm5aQlRTY0dMcU1HQnhKaVF4ZXZCem9E?=
 =?utf-8?B?cTI3eW04SHhzR1d1K1F0VlNhSW1wSDVFNmpwQSt3YXQ2RlFpc3VGVHBVZWl5?=
 =?utf-8?B?SU5DaUkwTWhwWWRPbnZhZXBMNUJEM2dpTzJ4TmFvNkFWeVI3ajBkNGl4R2Rj?=
 =?utf-8?B?WWFpWUttSTNESEo2VDVpdHVNYTM2WVpVamNZV1I1TndJN29XMTA3RHM0bkZu?=
 =?utf-8?B?TzhicHlSSE12N3ZDT2NLM1B1akxzWTFxd0dNcXJVZ3RPWUZwVzI2UG1iT0FU?=
 =?utf-8?B?Q3dQTDMwTWFQODllend6cXg1dFMva3ZtZG02bXdncHZKK2drblI4V2V0b3Bi?=
 =?utf-8?B?RzBDeHIrMnZmbmk2NFlodmwwUDVVVTFDeXhLcFZHSGRGREpOVUFmTEZBdHBl?=
 =?utf-8?B?QlF2blhpN2s2c2V2V3JrNzh2T1dHRHI3K2Z2UFY1cVpQWWZwaEs5cGgycDUy?=
 =?utf-8?B?MEZkd0RReUtmT3VJak4rbGRaZ0hPV0V3UWtqYTNDcWYzVEsxNHdkMUpMMWli?=
 =?utf-8?B?aE5EbXRGRFBlWDBNMDMrYncxVHJhZmRzSlBRM251UVZMczNoT3JQdS9WVFlX?=
 =?utf-8?B?N1NsZjZjTlpuK1dmcVVrZDFPV1BnaGM4cHBya1lMYXFBeWMvOUM0MEIxUDZ3?=
 =?utf-8?B?dE1IeUVnMVlNMUtLbWxhbnpWZnpRY1E1U1Zpdm80a21JMFMyRFAzcXh3OUEr?=
 =?utf-8?B?MWNCMDlWMlNVOWJ4RzZxKzJwOGlKUG1qQzNyTTZod3BiTGFPeHFwcEdNWEpv?=
 =?utf-8?B?VHZIK0tuendvamc5bUpsZlBXWVkzZUZFZHNmVjVnZE9NM2NFRnFaSFEvbStE?=
 =?utf-8?B?ZS91SjRnNVp3Zi9tdWRYYnpXYTQzMUZweW1ySmtXK0RWamo5RTlLVVNPMC9I?=
 =?utf-8?B?M01IRktrMlFLTUxJZkIwOERZaHB4SHN4aHBhUkgzMEFzRTdJLzEvN0ZueTkr?=
 =?utf-8?B?aXoycUJOMHRZWDAwY29kN0dOT0p2T0srUG5kT0tsekpFYTdwQjJwL3U3ejRR?=
 =?utf-8?B?N1BTRlF6MlU3NWFzbjREK2ZWS09GS1ZxQS9pdnd6QTRKbUU1MG9KdkZ3ZUtW?=
 =?utf-8?B?UkxqNGhNbDlCWms3VUN4QTJrZjhJTjV4U2szT0s3bTI4bVNGQ0haU1VkclpF?=
 =?utf-8?B?Y0FTYTdJWGQ0MG1TMjFZR3FwK1JaVVJ5NnVkZjdvSGUzT2pLbnorakhBNG9H?=
 =?utf-8?B?Y0Z6TXBsN0psUWtUaGdDRWdJdXhwTnM2ZzVoVkJ1eTQ2a1pPK0NBL2RLWVAy?=
 =?utf-8?B?eTRHZEg4TzgyMHdlcFltc3doRllJUXJOdlRFc2U5VThlTytRaHV3eURJa1N4?=
 =?utf-8?B?anh4WGhUMWxDbTFTVG1nRFRHb25KNDFmTytpdnFZaGNlQzVDOHZuMysrZXE4?=
 =?utf-8?B?Njc4ZEE1NzN2SkUyeGEzVzFLa2t5Wm1KQkg4VHA0V2JWWXo3U1M0QUVzUW51?=
 =?utf-8?B?ZDV5V0Mxc3lXRCt0aGVyOGpUeGNQWFM5QVZ1dG54ZlUyelVQSkFrZ2tVS21s?=
 =?utf-8?B?SElZWnlIbDJlSUpEVTlIM3RiNm5HUDUySGZIUGlIR3EzL2p1ZnBQbEV2Wk5W?=
 =?utf-8?B?eDFGdDA0bkdVb1owSTY0TXYxYjY1TVowL1JjU0VYOWJwTmlRSnFPVzZvQmlh?=
 =?utf-8?B?Y3JMbXBNRnh5NXlDYkdKaGNXeXV6UHF0blRXMDF6bXZsam1LamkxZjBBcERO?=
 =?utf-8?B?NzNiQVVoWFFhSGp3SWU5QWdXYUhXTE9rY3NDZytFRDRUYUk4UFBZelhFMHYr?=
 =?utf-8?B?Und6MG1PbGVQSlczWlJva0JOc0RKSlZETENwZVN3OER0UFBVN0dBVVhyaWht?=
 =?utf-8?B?dDkxcnBQdVpjd0Q1Tm5ZcC9Xc3hUY1dERHRUUVVzYXpQOXQxam5WbTBvb2JC?=
 =?utf-8?B?Z1lMOWFWamdzSXczb29zSCtpYTN0SDV4OWIzcHVXb0xYczlEa3NPTWdiTHdl?=
 =?utf-8?B?aUt0eXdoVWRUR3Y2YmFjRnhiSFZZb3NKRzJFdWlFVG11eVFKYjRHYXNBQWZ0?=
 =?utf-8?B?VkZaUi81eHNJVVRoazJLaTJKWjh1NGNPNm55bGJtY1hibXdyQWNDeitqd1V5?=
 =?utf-8?B?Vzl6YWx3ZUpobkhZUzB6RXArVXpvcVd2VlM5dz09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VU83WUpOMWJsSDg3MUJrN3REWGcvcE5DN0hQcWZFcks1eFZ2bDFtcHVZcWUz?=
 =?utf-8?B?NXVpdGUxMDdwVitKSk5iM3FINlpBZjRkWUVqVm1lOXFXaCtzcVU3Nmk1d3Iw?=
 =?utf-8?B?Y2lnWlhKMkU0RXY1dGxWZkRmQWNWQThsQ1l1NE5SdGJKR0NpOTNhRzlWWWlu?=
 =?utf-8?B?Z0M1MWVLQ0FqSEdTTGxwU0RjOVN3Mld4aTNQK2UzTm1vdDE2T25ZQi9HQyti?=
 =?utf-8?B?VGhESEY0Wk9rTUdNS0hEZGJxdTRvczhkRXJ1RlJGK1Nwa0p0dzBCR2NMeTF5?=
 =?utf-8?B?VDU5ZGtzdlQ2WGFzS1BBc1RFQ3ZzRDRlRk1lQnVtekhQWm4xVlNHMjRUZnhO?=
 =?utf-8?B?cE1xejNGWE9tdGJ0akp6YkVTbThiRks1SEVqZDZuazA1WWNjdXZDb1dwVXlU?=
 =?utf-8?B?SkdSVFNkcW5TV2ljVURPejlLbVlGWFhwamZlVVhIdHBxRWlmMTVEekl5Sk1n?=
 =?utf-8?B?bmROZ0NXaWhlSUQwelRhV3JFWFNHYW5pTFVadVZTZlo0Q3pCQ2pPbjZVZmE5?=
 =?utf-8?B?Nnl0NXpZdW5ScUlwQkZCUHNlVnJObXJEWXl3aEFsVUY4Z28raS9CZzBOSGVo?=
 =?utf-8?B?elB2aHhrRkVzWXFhRllqQ0h2dVVNbE1pZDZrYkFlYmJUL1BCV0pQWWxvZlZC?=
 =?utf-8?B?ZFBqcWlVWmFmZEplSXBMMGNzTnVMYS9iVUVwNzIrVm4rS1gxSVByK2V4RzNE?=
 =?utf-8?B?M05GdEpKMGZScXJqRjhXM1FkblRENXQrMzBtcnVya3VXNUg2YjNKK2w5SEY0?=
 =?utf-8?B?aXR2SGJIUXdJQTh3V013Z0U0V0JLNlgzb2w3ZHpsOXJYNjZsdGVkcGRXRWFp?=
 =?utf-8?B?YzdZM2JSbC85ZmFwRmFZTW9oOGs1SjlHeE9tZVhNdFZjdU5OTzR1ODFrNXhK?=
 =?utf-8?B?NVRnanY2VUwwRHNsQlAwM1ZXOHpkclFOaTZkMXlYcktOeWx1RU16OW9EVUtD?=
 =?utf-8?B?S0ZLbVVvejJQZjFmTUtlV210YVlkYTgzM1U1WVg3MXlRcWMrZzRJUWlhVytq?=
 =?utf-8?B?OUkyT1JQRG5waGRQcm0vWXJUNjdmakUyK2RES3Y4Vm5xd0RSSHJNZ3doRS9o?=
 =?utf-8?B?WmZuLzZwN3pFM3NJbitRcjJBL2NmcnJxMi9PZWRYNldrRXlvcE1LUzM3SlZp?=
 =?utf-8?B?c0Z4RUNpbkNqZVBEdU5ReXl2MGRRWG90TVZPemVZZStSMUN1VnRTMENTMmtM?=
 =?utf-8?B?UG83U044QXpOSGZwZmswRzBRWVova0wwZms1Wk53Z2ZNelM1K1NOZ3VJUmg0?=
 =?utf-8?B?SHM0OTNOMlR3NUJINU85MlR2V0thaCswQ1hyVld6UWlTWXJ5endiS3ZhenU3?=
 =?utf-8?B?V3dhTGRTMGJlaklYYzFtZWtrVFIvREV6S2tWZEh5WG80QnMydFJmVnRGZE9G?=
 =?utf-8?B?K1JSNFExd0xpVnFLTDNHbzhyUmpwdEp3emkwUW5pcklqeWNqTmpMdUs4ZGda?=
 =?utf-8?B?OU1VVzQyNzJ1bEVpQitrYmcyem5CNDZkR1ZIRXdYb2tKd2YvTzJtOCtRc1o5?=
 =?utf-8?B?ZTZlcjVIUUY5ODU1QkRDcFlVQ2dUN1lRYkxBWkZHcWFYZVdoOXpnRldNdEJU?=
 =?utf-8?B?b0tEUVhMOHVnU2hyOW1SMzRsbTNKdndPQ3pGVmNreVkxUWlITzcwVHIweWFQ?=
 =?utf-8?B?Z2xsajBEaGIyMDVLSnNTSndvMkRjY0pKNmtjT0FoSHJ2SEpITjNmYkM1blQz?=
 =?utf-8?B?Si9razR5L250RC82RklLajJnR05Gdm0vYVI2bTBHT09lMENJSEI4UGo0VFYz?=
 =?utf-8?B?cDJ0cTQ5TmlYaXV5MlZIN3ErRzV4Tk9aSVRWQ2NWWjAzb1VPUzBXTmZad2xo?=
 =?utf-8?B?R2hMNDNtR1krUXFSYy9yaWJnMTB6RUswL243a1ZNRDhvQWhMdHdMKzcrcjB0?=
 =?utf-8?B?N24vQldrcVVRNjhpb3ErZVRSeDByMlkzcE9rd1k3eG9aODR4ald0VnlMWGll?=
 =?utf-8?B?Z3dDWVQ5eUR6SFhwbzVhVjJzbU1YcUJYZGlWd1BIL28xQ05zZThtT2p2am14?=
 =?utf-8?B?TytTNWFHRTdZUURzWCsrRS9NT3ZuN1BPd3JhUTN0Vk5YV0dLTWlKY3lLK1gz?=
 =?utf-8?B?VWZSVGJVem9BZlNCYlBERG8zUDJKekN0UVE5QnhzMFM3RHgzKytYZVFEL2E1?=
 =?utf-8?Q?/WQ51WHz7sknpRk+vXMEVAyi7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd285d78-4b38-41db-6f72-08de229f3de5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:26.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCQWPpfJOQ+5IzR0Ssz/QPMBvGFGs9tJsmxR/BmV3gimxW33qi3zmN6zXPsGuGc3ky2McWxKtPkwvVoTZPjeIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

From: Guoniu Zhou <guoniu.zhou@nxp.com>

Use devm_clk_bulk_get_all() helper to simplify clock handle code.

No functional changes intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 drivers/media/platform/nxp/imx8mq-mipi-csi2.c | 57 ++++++++++-----------------
 1 file changed, 20 insertions(+), 37 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
index 371b4e81328c107269f89da23818ab0abd0179da..40db2676bade94e8e750381b1237fd02aee9d0ed 100644
--- a/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
+++ b/drivers/media/platform/nxp/imx8mq-mipi-csi2.c
@@ -71,21 +71,6 @@ enum {
 	ST_SUSPENDED	= 4,
 };
 
-enum imx8mq_mipi_csi_clk {
-	CSI2_CLK_CORE,
-	CSI2_CLK_ESC,
-	CSI2_CLK_UI,
-	CSI2_NUM_CLKS,
-};
-
-static const char * const imx8mq_mipi_csi_clk_id[CSI2_NUM_CLKS] = {
-	[CSI2_CLK_CORE] = "core",
-	[CSI2_CLK_ESC] = "esc",
-	[CSI2_CLK_UI] = "ui",
-};
-
-#define CSI2_NUM_CLKS	ARRAY_SIZE(imx8mq_mipi_csi_clk_id)
-
 struct imx8mq_plat_data {
 	int (*enable)(struct csi_state *state, u32 hs_settle);
 	void (*disable)(struct csi_state *state);
@@ -111,7 +96,9 @@ struct csi_state {
 	struct device *dev;
 	const struct imx8mq_plat_data *pdata;
 	void __iomem *regs;
-	struct clk_bulk_data clks[CSI2_NUM_CLKS];
+	struct clk_bulk_data *clks;
+	struct clk *esc_clk;
+	u32 num_clks;
 	struct reset_control *rst;
 	struct regulator *mipi_phy_regulator;
 
@@ -384,24 +371,16 @@ static void imx8mq_mipi_csi_set_params(struct csi_state *state)
 			      CSI2RX_SEND_LEVEL);
 }
 
-static int imx8mq_mipi_csi_clk_enable(struct csi_state *state)
-{
-	return clk_bulk_prepare_enable(CSI2_NUM_CLKS, state->clks);
-}
-
-static void imx8mq_mipi_csi_clk_disable(struct csi_state *state)
+static struct clk *find_esc_clk(struct csi_state *state)
 {
-	clk_bulk_disable_unprepare(CSI2_NUM_CLKS, state->clks);
-}
-
-static int imx8mq_mipi_csi_clk_get(struct csi_state *state)
-{
-	unsigned int i;
+	int i;
 
-	for (i = 0; i < CSI2_NUM_CLKS; i++)
-		state->clks[i].id = imx8mq_mipi_csi_clk_id[i];
+	for (i = 0; i < state->num_clks; i++) {
+		if (!strcmp(state->clks[i].id, "esc"))
+			return state->clks[i].clk;
+	}
 
-	return devm_clk_bulk_get(state->dev, CSI2_NUM_CLKS, state->clks);
+	return ERR_PTR(-ENODEV);
 }
 
 static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
@@ -456,7 +435,7 @@ static int imx8mq_mipi_csi_calc_hs_settle(struct csi_state *state,
 	 * documentation recommends picking a value away from the boundaries.
 	 * Let's pick the average.
 	 */
-	esc_clk_rate = clk_get_rate(state->clks[CSI2_CLK_ESC].clk);
+	esc_clk_rate = clk_get_rate(state->esc_clk);
 	if (!esc_clk_rate) {
 		dev_err(state->dev, "Could not get esc clock rate.\n");
 		return -EINVAL;
@@ -783,7 +762,7 @@ static void imx8mq_mipi_csi_pm_suspend(struct device *dev)
 
 	if (state->state & ST_POWERED) {
 		imx8mq_mipi_csi_stop_stream(state);
-		imx8mq_mipi_csi_clk_disable(state);
+		clk_bulk_disable_unprepare(state->num_clks, state->clks);
 		state->state &= ~ST_POWERED;
 	}
 
@@ -801,7 +780,7 @@ static int imx8mq_mipi_csi_pm_resume(struct device *dev)
 
 	if (!(state->state & ST_POWERED)) {
 		state->state |= ST_POWERED;
-		ret = imx8mq_mipi_csi_clk_enable(state);
+		ret = clk_bulk_prepare_enable(state->num_clks, state->clks);
 	}
 	if (state->state & ST_STREAMING) {
 		sd_state = v4l2_subdev_lock_and_get_active_state(sd);
@@ -1027,9 +1006,13 @@ static int imx8mq_mipi_csi_probe(struct platform_device *pdev)
 	if (IS_ERR(state->regs))
 		return PTR_ERR(state->regs);
 
-	ret = imx8mq_mipi_csi_clk_get(state);
-	if (ret < 0)
-		return ret;
+	state->num_clks = devm_clk_bulk_get_all(dev, &state->clks);
+	if (state->num_clks < 0)
+		return dev_err_probe(dev, state->num_clks, "Failed to get clocks\n");
+
+	state->esc_clk = find_esc_clk(state);
+	if (IS_ERR(state->esc_clk))
+		return dev_err_probe(dev, PTR_ERR(state->esc_clk), "Couldn't find esc clock\n");
 
 	platform_set_drvdata(pdev, &state->sd);
 

-- 
2.34.1


