Return-Path: <linux-kernel+bounces-891013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276CEC419D1
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A61421896CD9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921030EF9F;
	Fri,  7 Nov 2025 20:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZVYwxuOW"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F982D8776;
	Fri,  7 Nov 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548291; cv=fail; b=fuTA9hSxKbdA72Ue/Z9upvoj+ZiLpbcrPU2XbTEmSBozkNgRG8tmJc9IRygQjydoSZbLfTemp3CB1h+5j3Gv6Pc/dk0mfz3+ex02OkX4OZO38RVvK952E4WgWe2rB7y7kfoNjqOHsRlRjhcycU6j/DaZ26CpHnTPYh4ODRx6T1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548291; c=relaxed/simple;
	bh=Qo4KzEKIrWuLIY18NmkiJcrqrj2snMmZG00ThAB+Wrk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=dWFnNrhngA9aGIyB9MGR7S40gn4/eGJKdcXOVQikNYV2HR3lGZHlov5LU6oZ2fPJWWKVnSpzPa6FeQHUNPJWOlb4yStzeDhLe90wuAgGEeHrSYFUp2GaFIUFztfAZbxlid8YJF0aDP/d0wT6/C+ceCHwP/FqI4ew8mruqX67VAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZVYwxuOW; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOe5QpfXtrZzJHlBTHQkKktzeHOqbin+AIjH4yekr2BaqvgbA5nUHZk37B1l9ueTvu/jMNw19VKpiii/+ndPcUZkhjH+DCD6wHfb+ePupgAL9513roMAcVJkvqi0XQ1AOOXNWR5GbAw2eHAp0xuZtbjPOdzKNa2pFBvqqh5WD3e8puIpMQZKYC/NLF2l9I7+MXG8j8OeW5aRbTAvnuSc6KsYPv4Q49AGQ8oVrjGGL5njZdFHp41SL4EP9Fi2jL1oQWQARHIqVOPRn1F2Jxk/qhiG/Gau8eGzb5aty4c7ygbVdLqqtpCliX8ciuqYdKJ8X0ygMfTLWuULY7zQlTrUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kspmcEJBZ7HsS0bM3lGr2t3lPIBiZCBs1YwoM3V9YWs=;
 b=MhPdA/qLebDD3bRQSNqgRsqgZe1nTGzXENX++I394vSMKuu5NBgXEcY3S9RVrJfYwq28Jh+uqxNSNtmtEV56Xsvr+IsoqlLwOeOLj5jyBFa9mbZi/LUyM9j/rC7Ci7MK7x0XvldGC1rl4/3OBl/RNFfyQGZKmMg+LaTM/Y3e5k0Dzj1jLN2ITrG8rFe61LFHobq4L4NfjwWLnxsDPzzQWyalVnfAREvkItdfjjqXNzDkywYMDBzk6M9wsgHk7R3uaNWI+t+u628ZDpYr2Qsx2InnJ2BDg/IpEhSkqO89ye/0RqvHm0JIQ4GppfYc6JCKcpo0UKU0ERTCCSbikCxRyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kspmcEJBZ7HsS0bM3lGr2t3lPIBiZCBs1YwoM3V9YWs=;
 b=ZVYwxuOWN5A0Iwp+okhC6Y0WwvuuOJIi5sMlzvPM9xLuS+3GFUbtBmGIEg5HAaQcwJr4ib7KqFOpW3E4ggMLzzglPC6L5MU4ouK3dfAYrdyMhCYRO2XU4eTqvrjjUZAQEWo/y2ZxItb2aWfxktTc4ykjHK+Auukks1knfMeu3UP/umuEMguggR/Bv/WGzn/JZmqg8I0VsRoVp8cbG4tkGajaHWe3GqwNfFB82LDxl0/fd/rOSMinKRwjxEjTNHvS80/FzLPH7HFtQr5PoSSSPLHLwnbDz322Om5O6wMOTE2H7RVR6nGt76otiK0rGMgnPgbpwqlWEdCtxjmU3O6hMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:44:46 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:44:46 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 0/6] media: staging: media: imx6-mipi-csi2: trivial cleanup
 to prepare convert to common dw mipi csi2
Date: Fri, 07 Nov 2025 15:44:31 -0500
Message-Id: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC9aDmkC/x2MQQqAIBAAvxJ7TmgFM/pKdDBdayEs3Iog+nvSc
 QZmHhDKTAJ99UCmi4W3VADrCvzi0kyKQ2HQjTaITavkcEV6Ya38Si6du2rDhBZNDNhZKOGeKfL
 9T4fxfT++xtplZAAAAA==
X-Change-ID: 20251106-stage-csi2-cleanup-6db1715fd187
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=1127;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Qo4KzEKIrWuLIY18NmkiJcrqrj2snMmZG00ThAB+Wrk=;
 b=GbmocYNk63TKcRkrdHS+9+Q0GoOy6ZG1KX69cZe3FOg/RlcuqJIEepWgjB3QwuJoI7t7YNOqZ
 Dtg8wQaHIuKCaIgChM1Yqk19waLW/RabF1wGI9dLN8riQFlOcMQosP8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0332.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::7) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV2PR04MB12021:EE_
X-MS-Office365-Filtering-Correlation-Id: 71639a05-f213-4ed8-a15b-08de1e3e7acc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QnB1REFKMHNIcFlIMzNXV0hLVTVVSzFQNXhpRFNtYXNIai82bHpRTElmNWpm?=
 =?utf-8?B?dmtacVhuWE04QVVFSklEai81SzFMZ3JDQk9mMjNKZS9jdU91bmdJOGFScmdk?=
 =?utf-8?B?cTlhV0hzaDZrZzJXV1VwOU4ra0xBWmxKTFNkTVRYanlibkZ6WVl3QUZPTnAv?=
 =?utf-8?B?eEpzQlhNRFlhNml2STFabTZodzQ0bk5EK2NZTUhESmxwb3ZYdjRzS2FWOXlN?=
 =?utf-8?B?ODJkblJwSkZ2VnFmRHEyWlA0Wi9ERUk0QWYySGZIT0UvNURyTk50ZUdnbFNY?=
 =?utf-8?B?dVEyblY2enpQUEdrekpWcmY1Q0syVkhoOGxQZUhPVFN6a21HWWM5dlJVaWxy?=
 =?utf-8?B?Njh0YmxBVWhyZDB4SlJUZXk3cWllTHVmVmpXL1NtejNva1FmQ3VCTDRkZkVz?=
 =?utf-8?B?RTc4MFJDVGE0cmozSWNpMFpPTFZEOUZBU1ZoNU02U01MT2hHdUJINWFCU2hL?=
 =?utf-8?B?RU1DeHVCM0hQTVhmOEdjQXZhbWJ3TUlwUEg3UHF3bzdaS044Z3QreFhCaVg4?=
 =?utf-8?B?bFI1dVZTamZSc2o4MnhGakVUcWx6VFN5WVZ4TzE3Qnh0WHJKdzQ1Zkl4d3J5?=
 =?utf-8?B?SEJWYTdCSkZ3enpYcTNLVjV0c3E5OW14dUo4S0ZETmYydnVEbWtQcHR3S3F4?=
 =?utf-8?B?Mmd4YzRPMndCS253ejJBaTl2d1lxZUtZOGJIVDNsOUZodUhUcTd6SlhtRWZm?=
 =?utf-8?B?OXNBanFidFRScWw3cFVTMEJuaEhRMHFoaUxseHF6UmtvWjgvdnhwNU4vbWRL?=
 =?utf-8?B?eDU3bVErcjFtN3FEMHhzR2xBNFBzU3pYQjROd2N6ejRmS3lhQnRWYmluYzdC?=
 =?utf-8?B?WlVmeHhueHlRQTNaYzcvdWV2eDZtbjdQN1BOM1I2LzlqbTdXSVpUVlplVndV?=
 =?utf-8?B?Q3BNa3A2b3owT25wWXlvYnp3Rkh4RFkzRm1JTzZocHBuK1lpNnFJaDh5NGxP?=
 =?utf-8?B?Um1XN3hpaXFwRG9WTmFUTER3TFhsbWMyMmZHR3VuWk1SVlBBSzRkUHNOZVRl?=
 =?utf-8?B?VTIzRlRjdFI4N3liQlBkQmxSN3JLU2FjQ1hLd1p4VGMwcVZML0hwS3VaT0E5?=
 =?utf-8?B?NmdQTEtWNDVxWnorT0lNWm1ncS9wSnRGWXZsRjhST2lYaGk2ZU1Na3JSdHd5?=
 =?utf-8?B?NjBjNWo1cnp1OE1SNXhhRTRieVIrWmVaN0R5ZkdrTHhpQ242Y2RtUEMza0FP?=
 =?utf-8?B?cmplTCtmMDZ1Z09kU2NydXlPTEpYamNWTENjaGZkcEcyMFVFaUU5TkJxTUxO?=
 =?utf-8?B?OWxqbzlLVmtIWi8xYUVHU2hiS2lYMzhDNUhkdnlDSXQvTzhITkd1VE1xa2dp?=
 =?utf-8?B?M0tFSUZtMStWOEtaaGN3QUJNczlPMnFsMmxOWDdMYnp0bE5xUGc3cXpmSStT?=
 =?utf-8?B?K1ZxZkRiVkk1L0VvS3JTV0ZSUGpIdXFwLzBJblBna0tSSVJzQTlkRlVvVDlR?=
 =?utf-8?B?RFV6Q2laK25UbWFoTmpRNU9iU0Z4bVRZVHMzTnhZK294Y2ZBZUtIbWRqNno3?=
 =?utf-8?B?aDhzQ0hVWHBLRU9XR25CK2MzdXFEaFIzdDlEaS9uMlNxbk82Y1pkR1pZNFhu?=
 =?utf-8?B?VWoxc2tmUU9yTjRINkFBaWhoeVNYWkJUNXlIWjhHb3o3T0FsOWIxOHhGZytv?=
 =?utf-8?B?MDcwNGNHa3QrQUd1MDk0QjRXdVdNbytZdFdpUm9hQVJIeVFTTlhweUdnZHdV?=
 =?utf-8?B?NUh4SUwxRTdTRUl2eTlpTXljOGZyWlBZU0xZOEdqNC9TMStGd1JXaUFNV0V2?=
 =?utf-8?B?dkc4UytyMndBS0UyOEVCaHVqTHJ5NGpGbjhvT2k4c2lnbGNZTkQwSHRCeHc0?=
 =?utf-8?B?Um5uZVBtc1Rqekhid2hPVlgxSHZsOXNqYnB5RXY4RUI1dFpLZDU5aFQ4S0RP?=
 =?utf-8?B?MCt0b2lBVzhMOHM5ckx1NjA3aE1EYUlpTEtSLzRKTG8renRpS21hUVJZL2l4?=
 =?utf-8?B?dTBZWmhYODB0SWl6VFNCenM4ZU9DVjhJRWhEd3pGcEJqaWxWSGIxSGt1UmRX?=
 =?utf-8?B?ODh1OHBDWmdCTTgrQXV6dXZjU085VmFMM1dsMi9RdHFxMmNHd21GWm9YSWQy?=
 =?utf-8?Q?9qOTvw?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bFZCT1Q2VVRPUG9VY2V1c0N1K3lpNVhFaWgvbVVlcWtMbFhNSmhXV2RPbUpz?=
 =?utf-8?B?bVJpMzNyejlUSmtHOC94ejkzVmoxWkRNRjcxYkxzdDd2bjR1dlpXZCtMK0RZ?=
 =?utf-8?B?NmVYUENCRjVtN1VWM0V0bTJQeUYxaWx1emdvbldqOXUrckFBaVAwTXRmcjl5?=
 =?utf-8?B?bEd5Uldld2tFTnhzYnpsT3B5Y2J2Q2NxTGFlWGtyTktubUpWbG0zRUJlenJX?=
 =?utf-8?B?ME1Zd0NLd290ajNtUjlYMkYxcFVWNEN6eXYrT2Z0TC9lM25LbDRWK0dteHJY?=
 =?utf-8?B?YlN1V2lHbHNWaktoa2RHczhNcnhDUC8wQ3Bncjljb1NjSUV3NVhFOW5NMldO?=
 =?utf-8?B?U1pGNk1ZVDdaaEZyY1pwL25aSmEzLzlxeU9YZTJNb3lNcUFQS3l0YmRuUWpm?=
 =?utf-8?B?eVpUR3hBdHVEWjNlRDZ5V1Q0c3JCWitMVjk1THp6L3F5WWw4VHQxRmpkR21k?=
 =?utf-8?B?OWdaOUM1WjVCaFp3MlJkb2FVL2xNYkZyOWJQU3VpTDk5N2x3ZTNZZWQ3Mkwr?=
 =?utf-8?B?Z0NTR2FLcXE4MzlKN3hLUVVqWTVURnJja2t1c0h5TERQM3NLdUt6bzgvRlhk?=
 =?utf-8?B?RGl0RFk0WUY2aGMrZkhkbUlNNTdaMGw0alVpK2lKMnB3ZnV1SkRFY0xTb1Rk?=
 =?utf-8?B?alduNW9VN01NM2FaeVF6QWdFSTVqdFNkZDlGSko4MnhQbU5xVlRLdGJlTUd1?=
 =?utf-8?B?c1Nmd3FwWTduVTFmQTc2d09GWmtVL0x4V2taalZjUStuWVdHTEFiQnlLWjdp?=
 =?utf-8?B?ay8wUVF3Z2FNZ25GOWg5RTd4STViWmk1M204djlCc0xUWU41L0FTWXoxQUdM?=
 =?utf-8?B?NnJSek1IaDRpbm1Ya2hNRHJMcVlwNnVxeEY5aG9BTGhsSk1ObmxFYklIbU90?=
 =?utf-8?B?WVFYZDJJK2NhWllSNnVEY2k1RDFLMTNKSUwrcEcveFJsU2FSaEFTa0h3OTc2?=
 =?utf-8?B?QnA1d1lLakNBQjd5YkJwb1lWalVsU25LTGcrVGVHdi9yVHpJNFNzdXRCNlR5?=
 =?utf-8?B?MmVjM1lPSmVRTjJWT1N1QW1lNHlGUFRrSGlnUlZKYUZ1SVd0c0tTODY1eHJW?=
 =?utf-8?B?bndqbmV0a2IwejJPajJMM2NTQUZTSHM5YW0vM0JRVUVXMy8ycW56NTh3UUVZ?=
 =?utf-8?B?WGpTMmlzUTZPUC9DUnpYVkRWNVRZM2crWU8xUFQ0UzZHQ2dQbHJ0aUswVFVS?=
 =?utf-8?B?MWJ1WmV1K1ptdFBMYkp6U01ycU53M2ZLdXRnaDJFMDJmbDV4VlM1UitBdkRk?=
 =?utf-8?B?Y0xMdFBpME0vZnRMaFpaNGQvMUFnd2FtV3l5ei9qK2M2bVVpNHFZeTRBOG5S?=
 =?utf-8?B?U0VOOTJaWEZLa0JJVHJFQlFHTzRXSlprT1dONC9TS0hZNTRhVVlXNEhMZ3Ft?=
 =?utf-8?B?Si9YeGJEVllIVHFNNXVUMDBaVmlQNGxyNnpTeWFjKzRIZHkxd3hIU3ZJU0hV?=
 =?utf-8?B?UjVqZklIWXgrUkI0ckFxQW91M0N3MjAzRnhrU0hZTzF5S3FWS29HbjNsNjFL?=
 =?utf-8?B?T1MvY3RGZ1V0czIwQjR6Y3llby9YL2NHWXg1SVd5Lzl2WW5aNUUrRWt5Z2tn?=
 =?utf-8?B?S2hFWlZHb2ZhZm1SbkpoVjFTbWhoZDEvMnVKcHhjWWJWQ0w5N2pzUkozc0FR?=
 =?utf-8?B?TmVuSGlCV09TbC9OYzM2VkJVL0M3aEVrZDRNZUsxNDdJb0JISU04QVM3R3h6?=
 =?utf-8?B?U0hSdFplMUlBUGNXTFlHOG42Z3pwcHpoQ01Vd2FrYVlIdy9acFVraUJ2ZHlp?=
 =?utf-8?B?OVhqMmpDNG45UExmRTU5Ynhya1l2Wm5Jc2xuQkZaVk9sNFcrem9jMFdxaWpY?=
 =?utf-8?B?UHcwbDNQRnROK0RrWXdxZjQ4dmlIOHRSeHBRMGF1ZnJHTlI5dzNlS0duRzd2?=
 =?utf-8?B?THhhcW1MODBMQms0cHFoVVd2WCs2MFpETXF6Tzc1RHZwRzc0bFpmL1A0Vjdz?=
 =?utf-8?B?NjlBZGtSUVJLRkoxOXY5YTFuK1ZYTVRzajA4UzNieC9USkxETlRZS2VxY3JX?=
 =?utf-8?B?OHl0cm82UyswOUlvcTAxL29iZm1tWXdwSkRuSnNROHR6d3ZRSTU1bzJ1NTB2?=
 =?utf-8?B?dnVibUs5OGlHQ0xBWWQ1TFpVVU9hNTRNdklPc0FmT2FWSm1Cc1FYV1FIOWRi?=
 =?utf-8?Q?Qg+0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71639a05-f213-4ed8-a15b-08de1e3e7acc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:44:45.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tw2xYWYpRzD0PIwinFdsNx3xAPb6ydcBDaRuNX+CePPqtk/8/iuY9fc/a0+lDeW5jF+PZztX4f7YTTVn7bTjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Previous https://lore.kernel.org/imx/20250821-95_cam-v3-0-c9286fbb34b9@nxp.com/
There are too much patches (32) in above thread.

Just extract first 6 cleanup patches to review easily. The overall road
map see above 32 patch serise.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Frank Li (6):
      media: staging: media: imx6-mipi-csi2: replace space with tab for alignment
      media: staging: media: imx6-mipi-csi2: use devm_add_action_or_reset() to simplify code
      media: staging: media: imx6-mipi-csi2: use devm_clk_bulk_get_all() to fetch clocks
      media: staging: media: imx6-mipi-csi2: use devm_mutex_init() to simplify code
      media: staging: media: imx6-mipi-csi2: use guard() to simplify code
      media: staging: media: imx6-mipi-csi2: use devm_platform_ioremap_resource() simplify code

 drivers/staging/media/imx/imx6-mipi-csi2.c | 234 +++++++++++------------------
 1 file changed, 89 insertions(+), 145 deletions(-)
---
base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
change-id: 20251106-stage-csi2-cleanup-6db1715fd187

Best regards,
--
Frank Li <Frank.Li@nxp.com>


