Return-Path: <linux-kernel+bounces-899125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787B9C56D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839183AC1AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB91A32F74B;
	Thu, 13 Nov 2025 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qiiYJKCy"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011026.outbound.protection.outlook.com [52.101.65.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717D32720B;
	Thu, 13 Nov 2025 10:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029646; cv=fail; b=JLQ52QiBCB/BZkcxOh2pMM1Rlxpx4Vu8zWm7YyB0NPJK97FdPFTq/FJWB/5HighGntJkGu2D5+EtY9ZRYGifXJ4k41ZPRqh/a1j3KaH3g5LxFP/O2lApE8mg5+xVg1ZVbgB89ARQUyfnZjbe1qXzi8veUImpE0rhRUWoTbR9vd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029646; c=relaxed/simple;
	bh=2CimTnz1Nd3csVvlCKC8T1GEFkaFhxB5icEMykgw2AE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ki3NOrtKjIUyvb2cxLl4qJ87rixsf3lvINSGABGOYfK3mTuHOwphVsKjEEVDDsyEVjzf9XWmPdp87FEUDeKNc3MexvCO8Cc7lWFQq1aYjsw0kWBNqqtFVJ3k8EZUDq3ThrH/tqOuT8ZMC1WdCVj1RuBPef621XZtCvGBAaMeEcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=qiiYJKCy; arc=fail smtp.client-ip=52.101.65.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1m0uLHo4jcMT1VSLNtLrfRWmtWXKhnh4cw6ByWPaD8fX7fIINuFV5TG9dbVJ1c2nEShuHD3Zp5YXhjiQQJ1WqxuZsB1nibNcXk2/fkeP2a9iDk/NKpZxA7F4eTNgNRERhIDNFixWil8uk+oy3NSRxg+98XziJPltzYa2y2/j6wvXjjvpLzubfH9rXA4KE2OV0NtMyKA4llb4xen85giZTyv/G/xvLKevEaqEhrHRauNizx8PGXHmIoggpbFPW4JP97VYcwJkkZ4kN4bakxZDV13ssYiF0a1/mh8O0TcTIogfhoomNUFYgtfK6kGNiN8QI0wmTdcjghaCgcRjDfLtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCB66I/F3mFfDiW112Et9MaOWRJnddQU3vxOshI5ouM=;
 b=ZF6syJz+IDUq+peIeRC7xZwcXVlVqIONax5lMz1FCzrT1ArDnnyZ+M66/FK03WTj6BTHDIRB6V6yr6snVlt7ruIa8l2jzDcS4sSwem0FEvV+M12DKjlQSegrab73PekEO7ScfOzfhv6v2k6RZNSE6sKF4PwU55ARl+52LBdP3Y70bAnziaN3AVJLNKmCv+kiSz/eopAVkZOmtrIpi0I0PzwUcKzf4p5wE2WCS5Xx4nZWBa2xGdtcD5csTWffnS4HCEfYYJy7iX+lRYkZMY3IG5zhqqVv0tu5HOi6yYPlbkw/qkRnuldy4lmc86CP1vZVZkz6xXVC8kdL7pBtfyppIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCB66I/F3mFfDiW112Et9MaOWRJnddQU3vxOshI5ouM=;
 b=qiiYJKCyAJ0J1cplqCU7JAPAsrcarFM+Sj2KyPf3ksQWo6DZh+s2i5ZL27wD14/4k51r1XAvKwafAT1e8BDpboa+UZkhcPamsIwOUBS9jVHmTye5A+HYRicGmqTw7hGpQHtCSbG1SJcpr/WoItLxZCmpBwankWlH5olgHMbMEGR/W+FM3CcU9AO5ptwRmShfAA/dwgXPgf69ebztX+qj/KROOk4CfNNFGUP0BaU560361uYoHLLxBFb+iH3vc5qSGyn9twnvKH7vVx7pVS46HFf4Gwe/FVInSJhY1mXM0AV14v+gLEPlL0mEIYloD8VJRqb9Oz3fGYoMbPgIbDvy7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com (2603:10a6:20b:447::16)
 by GV1PR04MB9117.eurprd04.prod.outlook.com (2603:10a6:150:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 10:27:21 +0000
Received: from AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb]) by AS8PR04MB9080.eurprd04.prod.outlook.com
 ([fe80::92c2:2e03:bf99:68eb%6]) with mapi id 15.20.9275.015; Thu, 13 Nov 2025
 10:27:21 +0000
From: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Date: Thu, 13 Nov 2025 18:27:31 +0800
Subject: [PATCH v8 1/5] media: dt-bindings: nxp,imx8mq-mipi-csi2: Add
 i.MX8ULP compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-csi2_imx8ulp-v8-1-2ebe378f7111@nxp.com>
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
 linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763029686; l=3062;
 i=guoniu.zhou@nxp.com; s=20250815; h=from:subject:message-id;
 bh=NP4K4kzXlsKcowmJJhTx1ZLEzcgAZm4BdbbBYySKyt0=;
 b=2G2EqMcfj3FSTInB7x49aasDdIW7S3GMIQixwWVN+L/YIRsccvzo+fF6RxN2l7yMWwD6S2Duo
 qUJI5WFR+A3BwFZYL1cHiwhMdIVilJlbwzjqKEA6EPf7jBnIFfpc23J
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
X-MS-Office365-Filtering-Correlation-Id: 951f232b-4119-4e4a-7ea5-08de229f3a57
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V3pPRGNOZ0ZPanFTYkN0WjQyMVk3aGZLMkxFMEtBSEpOSFFidGNQNlBSNkEv?=
 =?utf-8?B?ZzY4d296RWtuWVp6SFQ0T3YxajJQV01HM1h3bXpIbXh5VTJOR2h0aHhtRHcx?=
 =?utf-8?B?L3paMnN0Qk5MMDQ2SkloeDE4MnJpbHFpcjloUUN5TDlyNnoyYmZSUW5iSGhN?=
 =?utf-8?B?bVIvcEpxUXBDWndtSVJMaFNaSTIyaHJnZUx3eFZiL0Zadnkva3g3OXFBd2Zl?=
 =?utf-8?B?NmZrUWpYZFNMUTNIVlVhbHRsNDdwZi85aTJTcWhpY0I2ZWtuZHptY2lDZDZC?=
 =?utf-8?B?M2ROV2k0bm1ockZjdHpUZlJkQnRrVjJ5MEwwSU0rUHdsSHJYRTRwNzMvMExa?=
 =?utf-8?B?Vkpsdnd6a1VlT3V4U1R2R2dzUDdndVlidXp0QnN2Z0RDUTRXelRWc2Zqa05i?=
 =?utf-8?B?QSs1Mlo1RG9wVHYvUExBODIzc2NuYTY1SE8zbTlxRG9QalVUais3RlNIdTFq?=
 =?utf-8?B?Zm16RjV3V1JYQS9BZmhHTGlUVVF4aDI3OTlwbDkyRWlsRDV4bTdBZHFZVjJS?=
 =?utf-8?B?ZjVzeitWTVkvcSt3eWJlcWk0N1Z4ZWxIWVlUc28rN0NDejFlRE1VNFdQTVY5?=
 =?utf-8?B?S2NiR3FjUEVjWVoxQWdUUjBMZURzZTJyZDZyWDFpUSt2VWRZQW0vSHA2OFJP?=
 =?utf-8?B?bnI4VW4yVjBBS3FMMnNmUXZaOG5Za3F5MTFqUTJLYkNkeTZaTEhETHRrV3hn?=
 =?utf-8?B?cHRKcHIyYzJjKzRpQ0hiUGJiUjRRTXRydjhhd2VjZXN1a2NwU0dqWnZtSWRS?=
 =?utf-8?B?STZBaU5xRTlwdXhET2VWZSt5azg1VWFBQmY3WmVjaTdybnFaOFBLaStvc3g1?=
 =?utf-8?B?L2ttVFhBdFZIeEFHRnZ2bUlhK2ZZNXVsdDd4NWl6QjR2TFU0TnErUnFsUWtj?=
 =?utf-8?B?eGZubHViOU5KM1Back1mMHQvRGpwRFBwLzljT2RwemFneXJ4NTh2T3EzSksr?=
 =?utf-8?B?K3pOOUYvUUQ3d0VkeHMxRHRyaTNVdy9LUzBuMHRleDlIZ0tqRDBzb0JBWFpo?=
 =?utf-8?B?UFQrcHZUbHdFT3RsQXpnUStjK2xraG5RbnAyR0F3UHpad214WnJGQlEycHdS?=
 =?utf-8?B?WlFsTzY2cnJGNlMwbUZJN0JDU3BxZzRWbEFndXlrcHQ4QW0vZW5vOVZBb214?=
 =?utf-8?B?ak9IM3JLZjJEeXNXV2d2VVlyWENMejFjdGRUWDRtUGg2NDZxYWIrZkl5OVRr?=
 =?utf-8?B?eDZsNkhPL1hQNVdJWnZsUHduc2hxejdWV3hTbEg1M3Z2WGpGQVNmZkpqNDR1?=
 =?utf-8?B?RXdxUXI2bWNyNncySUV0ZG5kd1ozK09nNW1JMWpHR2g3dUdzZFM1dDdwQUhy?=
 =?utf-8?B?cEpkMlJsQXgzSzIxZ2hRWU1iL0p4ZGUxSU9rQ1RwK3lyWWZTdVBQcWpJdHBG?=
 =?utf-8?B?SU1yenFPUTRoWTdLYndoSjltTVE5Y3NxVzQwalZxUGJHemM0U2xUU2kzVFcz?=
 =?utf-8?B?UzQ4bHdTNWpJYlBYOHhSZHM4VU02SjNlUGdTakYyL1J5MW1YSStDaEt5bUZ5?=
 =?utf-8?B?b1RvVWxXWE9wZVY0cmdmK2VDL2JKcy91M2Q3RkwwU2duOE9xM3pySUorMGM2?=
 =?utf-8?B?ZGpTWXZnamNFdGx1Tzc2SmVQd0svWEZ3VE5hR0ErS1VzNTZBV2JESWFNa2FT?=
 =?utf-8?B?SFFRQytZc3p4WW13SC8rLzBmVldlVHIwOXJISDZyRkdQRVpZb1hmQUl0VHl4?=
 =?utf-8?B?Vy94VlZUanVZUXhFZnJuOWtLQks4SjY4R1h3YXhCT0w2eHVwckNRaFlPUXoz?=
 =?utf-8?B?QzlZakpSaFM3cUN2SmRlUFpXRVlBTWlHMmttVG5VSHJlUEU3cVhPU2YzRHVt?=
 =?utf-8?B?ckwrZzFUbVFSWW5LamIwMGF2aVFSK011V295LzJJZHg4WUVLTWdEOEs4U1FF?=
 =?utf-8?B?cG5vTTFlbHNoNWVjME1aTHBHV1IrTVlDVXRvZHlIZjNVcXRISVVjSEI2RUlw?=
 =?utf-8?B?bmRCMFdRVksyTDZ4ZzJ4K3pNcWh5UytZUTZwYkQ2ZVpUTjBqNzR4Rjg2aTNQ?=
 =?utf-8?B?UDRhZDZDNUEvbktoaCtIQ2hCeEhZYzFON0lweHRZaVhKU0JRY2lGZDlBOVdr?=
 =?utf-8?B?MGc0bEpLMi9NUHV5UjJ3YmVka1l5NjcrY0hhUT09?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9080.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Nlk0RzdUVWR2djdCTWY2a0E2YjQxQ1c3d2ZiQ3VGbkYyandWYTFMeEd0WmtG?=
 =?utf-8?B?V0xUeUNOTHppcmRUanRLVjlvMC8yakltQUl6cldic1pqQjhCL0FEREk2ZXFv?=
 =?utf-8?B?Z1lUKzFtZlVzRFhFTkJmdlJBK01MbnlJTVNEdG45L2hwMDdrY24zdEhWaDly?=
 =?utf-8?B?eHhxd2lXZ0NIcXBBVE5Qd28xa3hJck5qYW94RjNHY1JpR3ZXSGJRWWpYb0U3?=
 =?utf-8?B?akFuM3lXb2ZyOU9GY2RpL0ozZVpVMTlTQVRLRVpVUloxNWt1eUtHVXdUWkRF?=
 =?utf-8?B?SnluT1VvZy9jMkt3amVBc2pYeHZvSGYxc2d6cHNPNXFvakVVOThzUE04SHBP?=
 =?utf-8?B?RmgvR3l5NVFvVXhOSGxUV1BWV2FLYytOVlRVSjdqYWV3anBRcnAraklqaEVv?=
 =?utf-8?B?VFMvUzF4NjQ3eElldTVnRTZzd3oxV2VNckNNNzA1NWJRbS9RMnBLVFJNU1pQ?=
 =?utf-8?B?eHBQeU1LVmt2NWZKODRGcmFaMGJkOXJOd1VHVEk5dnpjc0JhVk4rWGhvZFVK?=
 =?utf-8?B?Z1AraGUzekZobVNuVXVzMjVMNXdnSm1VTWlGU0tEYnY1WkpDQ2hvMDljWVVs?=
 =?utf-8?B?bldYbEV5MWlKSk5JNEloVW1ZN2xkbHRhU0ZtZUFkQmFBS0JOTGlBUzM3TkJr?=
 =?utf-8?B?dWRIdlNLdHhaeVphRGJ3cFhWbEQxam1hTS9KcVpMTHNCV1EvTHZTM0wrV0ln?=
 =?utf-8?B?NDY5UjJMWXNDcXJFS0ZJSWIxUkFVZjY2YWx0OTIxNzR4VlVuWWNoWFJCNWFY?=
 =?utf-8?B?UjdsMEk5M0twSDRiaU1GL2g5YlgrMElsc0J3RHBZdUJBNzJ4aG5TVHVOSUxX?=
 =?utf-8?B?OFc1UlU1bEQwVmVFTlZZWTBydnpIYWdDRUoyRnIvZGh5Zm9QMlJrdnBGUzFY?=
 =?utf-8?B?SlpZNnc5YURkbHluV0VxK0xYZExubUNKbWR3anY2aXgzdnZYTzJaSllMdjlZ?=
 =?utf-8?B?eU1nV016dkptUlVTMmNENFBkdWkySHByU0tSaTFoYmcxdmNQdWtwL3dkOUd3?=
 =?utf-8?B?QnpzbUUvM0dEN0JJczExamp5ZzBVcVFsNUs0MVoyZEY0TURiVTlYWVRwU1BF?=
 =?utf-8?B?blNxQWZxOVE2RmNOWmhTVFY3WnMxUEY2Q2h6K3p6WlhNdk1kVWVFTkh5MUxr?=
 =?utf-8?B?R2E2WXVFVHhDYXRjU1cxODh0bnQ3T2Q0YW9SL0JnNUFVSGRQYWcyWk1LbVRT?=
 =?utf-8?B?MjdxNHJUZVBUQmZ0YktoSWZHZC9sQXdXOWJjOWErMzZvMWZOTTRxb3pxdzlx?=
 =?utf-8?B?VkFoS1NGdGFwOWhwZzRnZEp6bVJ6by81VHpybTJUdXprR0pIcDcyWG5BaE5l?=
 =?utf-8?B?Q213RHZiZGlVSHE5RG1RaVZ5R3lxZ3ZuWEJPbHc2Y3ZUY3FrTU1hbTRqLzNB?=
 =?utf-8?B?ckxzQVNPRlY1akRYelB2WGVjenZDVTJGdFN5ekxaWnFNWWowUVN6WFZaQStI?=
 =?utf-8?B?RjA1d2oraERhdkQ5OVlGb0F5eml6SDZtbXcvNWV5QTBhbzRIZnIrNWRLWWMz?=
 =?utf-8?B?cWhmZWdUeDNBeVNZdWd6eEczSjVjRklxaG5qdmZzL2RHa0xFWDRhRkhEYVQ5?=
 =?utf-8?B?Z0NQRm43MUpvRFZQbDhZNk1yMFZmQWVjUHl3VFhEdTZzVlI0ZFhmbHE3ZXJL?=
 =?utf-8?B?T0pmWFJBZXZEcnMyUHJrTlpzUkk3S2FlRkNqa3RtRmRtWVFPemRhK3k3Vmdp?=
 =?utf-8?B?dlcySTVDMjJ1RUphemI1L3gxZ1FVcFhyamwwa2FsdFJodHdQdjJyR0hxVzhI?=
 =?utf-8?B?STJIcGlHbE13eXg1WUxhZG1wU1kyOENENFZZRUFUQk9RdFhFVWxYVDBHQXQ4?=
 =?utf-8?B?QTlBMU9QRTRVbEF0UW5veTZvbUJjNk14dFRBVFM0ajdHVjhEZmZTSHpFRDBU?=
 =?utf-8?B?Y0R2RW8vS05uL3dqMkJLZVJvZVVOWUxTTUVUTFIrWDhGUEI0cXY0a0RCbDBl?=
 =?utf-8?B?ZDB3Rml3ZzRRRkFWQ3JzRWJsbzlaTVVaUC9wRE9HRDlySnBIZGVuZStuSEo1?=
 =?utf-8?B?SGJsMlNjT213QUNQV1pWUWVjVyt4MGxXbUJYVFlnODFpN2tzbUluRnprQ1Iv?=
 =?utf-8?B?ZWppcWpmQUNuSkVMS2tPRXVHaENTbUtrUXA1aGFJemVCbE5KNGhYNFJhQm5M?=
 =?utf-8?Q?53JIdN6CQAR1kkaEZV2VrXiKz?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951f232b-4119-4e4a-7ea5-08de229f3a57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9080.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 10:27:20.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DNUZXEbzbzOpOfM3Biy7/cq4lPcWFsZ00f1hsl16khxOH0SNCCl2cT3hBBknV3fByylDIUzIPDCqERtGX8U05Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9117

From: Guoniu Zhou <guoniu.zhou@nxp.com>

The CSI-2 receiver in the i.MX8ULP is almost identical to the version
present in the i.MX8QXP/QM, but i.MX8ULP CSI-2 controller needs pclk
clock as the input clock for its APB interface of Control and Status
register(CSR). So add compatible string fsl,imx8ulp-mipi-csi2 and
increase maxItems of Clocks (clock-names) to 4 from 3.  And keep the
same restriction for existing compatible.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
---
 .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 49 +++++++++++++++++++---
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
index 3389bab266a9adbda313c8ad795b998641df12f3..4fcfc4fd35651e0cd6e80b97cc0b12301b65b684 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - fsl,imx8mq-mipi-csi2
           - fsl,imx8qxp-mipi-csi2
+          - fsl,imx8ulp-mipi-csi2
       - items:
           - const: fsl,imx8qm-mipi-csi2
           - const: fsl,imx8qxp-mipi-csi2
@@ -39,12 +40,16 @@ properties:
                      clock that the RX DPHY receives.
       - description: ui is the pixel clock (phy_ref up to 333Mhz).
                      See the reference manual for details.
+      - description: pclk is clock for csr APB interface.
+    minItems: 3
 
   clock-names:
     items:
       - const: core
       - const: esc
       - const: ui
+      - const: pclk
+    minItems: 3
 
   power-domains:
     maxItems: 1
@@ -130,21 +135,53 @@ allOf:
         compatible:
           contains:
             enum:
-              - fsl,imx8qxp-mipi-csi2
+              - fsl,imx8mq-mipi-csi2
+    then:
+      properties:
+        reg:
+          maxItems: 1
+        resets:
+          minItems: 3
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+      required:
+        - fsl,mipi-phy-gpr
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: fsl,imx8qxp-mipi-csi2
     then:
       properties:
         reg:
           minItems: 2
         resets:
           maxItems: 1
-    else:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8ulp-mipi-csi2
+    then:
       properties:
         reg:
-          maxItems: 1
+          minItems: 2
         resets:
-          minItems: 3
-      required:
-        - fsl,mipi-phy-gpr
+          minItems: 2
+          maxItems: 2
+        clocks:
+          minItems: 4
+        clock-names:
+          minItems: 4
 
 additionalProperties: false
 

-- 
2.34.1


