Return-Path: <linux-kernel+bounces-896218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CB2C4FE57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 370414E5DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C900533D6C0;
	Tue, 11 Nov 2025 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YgIAYvHh"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A53326938;
	Tue, 11 Nov 2025 21:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897368; cv=fail; b=By1qQSeKG5xO+oZo0ZGWdItR8780QT+KRqqxMyC7s+n2K5QOJLd6I73xJUx6cVRSWJQeieKaykDZrjgH1vDMNKjVWf/FWC+qOmd69iYvmpYKerat1boLfGlI8jrkj5/2YGNbwQQd7XWTgUJTeZ3UcIqGKN63iCdtJWWJPu2Md1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897368; c=relaxed/simple;
	bh=rIIGj1pOcYLbPuEP8tSVf6f/1J3pRx8B92aOnfdq/vc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=K81dRSHqI5OVOh92goAtWbkMKYM3mYHepG4IjaHHMmgoc27OpAfxBQQWnrTH0yIzE+t70RatHbNaB0WcQbGJ+k9FC0oYaZH8/1G+8X7oZAnR35c5hqHMNj4B9ijpElvFkPNXb2EJchI+pEyGguiO5QzaIMtkhExBdSgHiXf2NEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YgIAYvHh; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VM2OaAiXFRwVCPpRCTxCfGSDEAw6a/bO9bGcZE5F4O9bddlSWjjoSGYeCExVdk2qkJIITpiqqBqdLlOuGNM0q1qoPaBLuE4WgCzj9SD9FxwuLScab71MbXCVXYdmma5bHGip1RjDov/Y6zWitySSvTWnjuG9NSEb5hIUFLN/vQA6XitR7lEuVKTZXLj+11FJwFHoHJIenklDNomsvNqjjr5J/E3NRuO02MLboNNNlrH1r++PyH5k54PeTgtGmPpei7zPzYhHSyu2ZwDQnjiLVdvRkz/9AFlFiKjSoIiAbkLd6fmrvWeVHvnlevovxpaYLhomefrijWNMwmK7Kokxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwJuK9xH9uZEaFmpscjMDx4HuCXH0qH/UiUYdvbnMig=;
 b=TcfcZOkm2RhdeluVEzD2IhgiTwuDiMIRMj8H2qv/dADiF+BnyQljHNZJSLK8cOIrILScN3EipQRawGd3RygyRRgNzYI/nNZx8qKUgiRTwZKcf+cold73/AJY9EY+EZxnh8bRTJVpUlW4IJCH8qqQaOu7XZoBm8TBPj2NvLKwC4gDSQnRdwT0t8ZSkmLLArCosABW3C32AP5CaHzRaxYOf3010zHmj4Xs8InKInH+w4EhpQ31NqBKgugrSyn2ZdcYeH7FGWurEWDvoGvoY/RHZ6uKLT/xJK5TDzowQNxcWEMqlnW0wk3CquOpg26G4v6Vs5QY/Z1P3EgYngkfCvxyxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwJuK9xH9uZEaFmpscjMDx4HuCXH0qH/UiUYdvbnMig=;
 b=YgIAYvHhHr7/bqHd8BrVrOl2+dI4GhylccdE39govg7fUVO0xcWuCkYvNJzmAOB3qz3YN0DIOMW6f3pT23WwCkueF7R2iyXkSdskUz6J/nm43BAA111DQH1jK2Up+74niSt00HO7X17hkY8OW927C7/9JYmf7MoWreQJiWn0r5oFsZCCXzT74z++llSIKfBUtKgNRUt38wbyxdrYCGE4ENRmBEaOyrpq0pbVj5S8bwa6ueKyI+hJzwo3sP8cKnxCEYl7Y17dhFWwp1h5rNE4myI3oOCf6gnnMmTja+qQ0R8NAZ8SH+g95upndBSvpB8xHWWD04I6Yrmd/AkUw0XYOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:38 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:37 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Nov 2025 16:42:13 -0500
Subject: [PATCH v2 1/5] media: staging: media: imx6-mipi-csi2: replace
 spaces with tabs for alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-stage-csi2-cleanup-v2-1-371bb951776f@nxp.com>
References: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
In-Reply-To: <20251111-stage-csi2-cleanup-v2-0-371bb951776f@nxp.com>
To: Steve Longerbeam <slongerbeam@gmail.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: imx@lists.linux.dev, linux-media@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=5038;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rIIGj1pOcYLbPuEP8tSVf6f/1J3pRx8B92aOnfdq/vc=;
 b=Dynup/Pm1VdVShUu9VRbM+xjci/j3oejmiBWIu8QA/r6o/VvxQRK4rBzlqEVJnHZ6cf2If6b4
 7m5aAnW+ddbD5hgi5D5u6EETPeqJzhhmGE9ZvIu3XmPy/4eyl+I2ns2
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 459b7698-269d-4f28-4288-08de216b3b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S2VhRHRuWGNQK2F2eWt0bnhCSFRVOWIxNGFYS05QaGdjOXRuQkd1MFV3aFpa?=
 =?utf-8?B?SHFzT0tmUHZLcU1xbFNDbWRjWlQwcTh4cTVJeEZRTlBUc3Ztd3V1eHlBYThW?=
 =?utf-8?B?dmF2SnhuV3Rab1gvM09YaWF3Y2ozVzVNRUFuZHVOTm5YVFh2M09KYlJQY21B?=
 =?utf-8?B?QnFhVlNCMEhnd0ZUYzJoMTBOc3VQTnRsRkRtWDVQblVXc3dZbjc4M2NLSW1m?=
 =?utf-8?B?VVBiaGFwclhsdXJieThNUnFZVjhDcnJwZWY0Z1I1eUd3am9ndnF1Z1Y4UEdL?=
 =?utf-8?B?d2JyLzhtZFBPQ1hkaTF0dWgwdWwyeStTU1lYTDI5bEJQd1BqcXlkeURyVnVt?=
 =?utf-8?B?bDVHUmJUQVpUbnlHTGd5WUQ3SzZUZkcybE95a1JzUFpJQlhkQkR0b3B0MXVM?=
 =?utf-8?B?NmZHWncySzB6M2IrbWttWGMxUmNiamdRODBtSDZZejUycHBJdXFiNzZZckFL?=
 =?utf-8?B?OXA1KzBlMXUwS0QwaTNVaGZBdUVzUTRtTG9vTTQvMS9kQVp5NnRqNW1qMWFP?=
 =?utf-8?B?a3dBbWFDdmZLc1c1dnljRTMrRTUzSFpvNVF2QTNsa2traW5RNGt6V3ZoR2tS?=
 =?utf-8?B?ek4wZCs2VkZ5N2RxeDlPWlFUSzR4V2crOERabUJYaHd2RnNvcjNOOTBjcUh0?=
 =?utf-8?B?RFlDUU1tOFh1ZlJvTG0vMDY5NzN4bGFLV0d5cTBjcUk3TnBTSWJKZTkwQWFj?=
 =?utf-8?B?K0lSYnRNRGwwZ0ZEU2tLYWtpQVBpdXB3UlZGcTd3S1FXamJsSFFsMkVWdnpq?=
 =?utf-8?B?Q21qcWxTZGkwZXplSUNrSzBvRFNVWE10SnduYWs5NlhXZitMZ1BzdHNhUEZo?=
 =?utf-8?B?UHp6QXBsblE1azNDdktPRHBRMGh4MDAyMkgxelduM0NnYWxFUFgvbjZYaWx5?=
 =?utf-8?B?d0kvcUNLaU4xTjZ4SlJlU2U4M1Q3eWltdENjVUc4RTFwT2E4SUFKSkJ0K1Ra?=
 =?utf-8?B?MDdBSzZJeDlpaUEvVU5wQ3lTZk93emJTRGtoT3lvejNqN3JURjQ4RnEydHI2?=
 =?utf-8?B?NEUyMDZBcS9CaXpacFA2NE4rQW5TUWhMdUIrQS94enR1ZWk5WHRpVVM2N3Bj?=
 =?utf-8?B?WTJnYWN2RFVFWnh4allFOHRSeXM2b0RaQ3JBN1pRa2hpWktRRHZDYXNxdERX?=
 =?utf-8?B?c2tEQ2lsN2plZGhKN3lJNHpLWTh5UHBUWGt2TCs2U2tFbzRKb2VxUEh4VmZ6?=
 =?utf-8?B?UDJ3VG42aWx1Y3RYWFNnSmJDSnFhbzB6NTFXaFVmL1U5THY0WTdibUl6SGto?=
 =?utf-8?B?YkI3SkdhK3RXZ3IzNzFBSXpkR29vNUwxa2ZGWWRKaEpIdG55Z2RHS0VZcG1C?=
 =?utf-8?B?YXNMeWxPcFE5czZLYVd2dUFBdHpncFo1ZkVGNzZsdlNOU2RLTE1uRldyZWR2?=
 =?utf-8?B?Yy9RMVFmQVI1ampIa3hzb3lieXA5a052c1BIRTBLNXdIVnRUTnU3ZzBudCs3?=
 =?utf-8?B?OEtDaElXR1o0cDhLZTlDNzFBN1Y2Q3JPVEI3SVpzWHJTOStCVFpTZmRNNVNT?=
 =?utf-8?B?Z05pb01RbFBLWHhRUzFuOTkwK3hFYlR3Y0ZtUmQrTStvOGQrUVdUK0pDSmVl?=
 =?utf-8?B?TjBFNDNHKzdiMTVlVFUyTXB2WHY1VjVUbnRTdC9KL3NpWVNsVjF6T0dKZ0J3?=
 =?utf-8?B?WFN5NkxzRFhqVWIrTjhYOU5uOXRtaG4zaGJ3eXFpQzJYN0dpWGdSdGVNajJM?=
 =?utf-8?B?cHhQQjJ3RkxuT1o1Z3BLOHljbVU0WTFQWVdZMWpDOVZhaGloSERqeVRPU0Zx?=
 =?utf-8?B?ZzlxUmVFYnlZSERhZHJjUVlZS1dSU1J1L2tpaUZIYjM3MFZZQnZlMHBZaHZz?=
 =?utf-8?B?MitIVm4rL1NjS2x3M2R4SUUyckRpUDBIclM4RFdZSXl3MTkyVGJ2VW9Bc3Nx?=
 =?utf-8?B?MzltWUJMUWpoVlNYUU01WVpIK3BYQ3pITjdGd2lGM3l0cVBad1VlK3IrWUhO?=
 =?utf-8?B?NTlydHRlZklCNVpJeW5nNWNhKy9yMjJZaER0N1ZrcDNyS3hYK0ZtSnp5YnRt?=
 =?utf-8?B?U3UzbmttVWxOWTU0blJVNHBUZnJUUWZyc0tOQnJ5WjkzTm1Tejl6Q0k2NldV?=
 =?utf-8?Q?OYhvXe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzVVSjg2VXZmV1hBeU9nbHpLdzcya2VXSlVpN0I0RzN6Z3FRY3BZTnBSckMy?=
 =?utf-8?B?SGZIYlZiRUhzWExyVGlzWTgreVk2NlNxc05HTVNqakNBSjNmTDN2MUtabEhr?=
 =?utf-8?B?VitYVjBQLzF5N2gvZDJqQ2ovcEFlNFJZdGtRbDM2eTM0UTkwYnlWd2RhSlZx?=
 =?utf-8?B?ZStTSlZOTXpiN1I3V3JMRE5xcXB4NndIYVVjczlTRlRBdWtrdDBHMk53TzI1?=
 =?utf-8?B?T1U4RVJsaWNicTRPb3c3T0dkc3RyRjRnYWtPTkdvWFcwNlhKRU5DNW1OYnVu?=
 =?utf-8?B?MS8yN2liUFZlQVN1OFdUczh0NjVNbm0rVTFrNTJiMnBzR1lZYjZweHlLcjBG?=
 =?utf-8?B?LzZYSjdyQmxzdnV2TXdDK1JKelJBSlBITVNMU1dXcnY5Um5tV0hjdWFONFRD?=
 =?utf-8?B?aUpHZVpiNmpPUDQ4U0N1cmRqTlZDRWxmVFpGcTNaNkxHNHJnWmdEeEdVeHJo?=
 =?utf-8?B?WFRaWGk1dWFLUG1PdUk1WTRSYXJzRmhhRWVxOGc0SDJOeWEvajNjczZjMTdM?=
 =?utf-8?B?bHU4WWdEdjNOQTZiUW04bWUxL1ZZNy9PRFZpY3FYZi9DZnNrQ3VwdTkxTXJU?=
 =?utf-8?B?R3YySEVFVEVJU2c3YlJDV1lTdmlBbDRuMHFvQitjaHhtOEZkSzA1c2RiZnZ2?=
 =?utf-8?B?bE40ZnY3a3ltMVB3K2tsY3VXelJmSzE4emJNTDRwRy80QnVSdnREZEd3Ykdo?=
 =?utf-8?B?U3pqNXhJekFGMDl2ejlqdVhFZjRZaThwUHZFWXp5WW5wK2loWnlQYXJxQi9J?=
 =?utf-8?B?U3AyTkcrelo3c29raVdsQTBTMFRqakRmS05wYXhnRVhyUlp5Qk9OU3oyNEw4?=
 =?utf-8?B?b3hUS0IvNDhLbmdEVks5d1VIQzVENmozVjduRVpPeW82ZGJQOWFIaVc1bFpa?=
 =?utf-8?B?QkRkZmZBS3ZaZFJrNkI0Yy9LeGJUWVlFUTN0MFN2YmtpVFBJS090dEhmakNv?=
 =?utf-8?B?MGdhNStUVk83R2wxaGpoc2h4bjJxdGtkQzdYQmZZUEFwcEtadVd5QUdyL1Ur?=
 =?utf-8?B?NzV1enprRGNHcXF0alJhUDBNTmxyczUzSE1vZnE1OUREb2JTLytwc3ZpWEww?=
 =?utf-8?B?OU1Ua3ZKWUpBSzlvNWpWWU95SUszTmE0R3RrQXllcDJMUHpESVFKSUorR1JS?=
 =?utf-8?B?SmpyeU0rS2F1OGdWVEFDamRhbE8vOHp4ZDVGbWU1R1IzVFlzZmZ6K0UwWTFn?=
 =?utf-8?B?TjRLaUNuNDlNbU9pM1Z6OWFGTGhLZVYrS0RIRW54dCtYYUhHTWRheWJQWkkz?=
 =?utf-8?B?ZGsvMmsvemdxSEExZVlDaFFaVTJHby9UVzByZitpaTlxRS9sdC90RVNOV3Rj?=
 =?utf-8?B?N0ZNeTA1U1VyY0lOSnIxNW54Mm52Q21CaFZYRkVnVjNMdGVYVFA5UGlJdEY0?=
 =?utf-8?B?V1dFdWlBcDVRMDVDaHJRbVk2RUlFNysrWlgrZzREUVRwcXJvSlVEcGNQaGth?=
 =?utf-8?B?MUkzRFlHYlBHejZucER3WjZxbjlYMmdScjVDUC9LSm5Fb2ozQ2RhRUwrZG9Y?=
 =?utf-8?B?RHVhdXpvdjliNkY0S1V1Nk1JWmtxa1haTVFsY3JpL3dVeUdhNjdlY21mb0ky?=
 =?utf-8?B?V1ZEV1k1MzJYbVU3aXlJQ21CeTNlWlNYbFVUQm1KMnRBQ3p3WlE1enRBYWJP?=
 =?utf-8?B?WFpqNU9GN2MyTDdIcTA1aW81VWZxNnV3bTQvSjZxUlI2NWdWc1J2VGtQdU5a?=
 =?utf-8?B?TXI5bEc0dzdWVXNpUE81TE93M1hEY0EyMVR4RGpIcjFETFBzbjlIMUN3TkdW?=
 =?utf-8?B?MENlUFJ3S0lzaVFDdU9lbjIyZHBVdHg4ZklqNG9pZHVqamtoRGhiVUVJb2RR?=
 =?utf-8?B?K3h0aithaVdYUWxsNVhuVnoyTEE2bWtqaXNmMUQ0NHByTmhoTzdhS0h6Q0xo?=
 =?utf-8?B?S2RrNExwVERwZ01waTVVY1RYSEhZOG40WkRTMVg4Z1BWaS9VOStQaGtmN2tj?=
 =?utf-8?B?ODRXYjA3dHdKQjRscmRFbnlwYVBtdU95eU5CY2NKQjFZOUlaWGZOM2hsWWdU?=
 =?utf-8?B?U0VOS3ArZ1hmV1BWanh0K1lVZVUrSTFYb2R6YTltZzNBL2xsbk44eTltcjRt?=
 =?utf-8?B?ZzVwWmsvL1hSS3RRTGRZdlE1TXlLL2U4K0hkMGhNS1JValE1ZW0rbHdTSWND?=
 =?utf-8?Q?duoCXLmw37V4I4mY88lgYbgS5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 459b7698-269d-4f28-4288-08de216b3b6f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:37.8296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ll8fumfT9VP/DCMTp0dSGS4ZMSulxjNGTkE2ENoHz3nj/TAxaKpdWVJeuenYU/MWGPnlzHXlglGJipDg7zGGbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

Replace spaces with tabs to align register value definitions, making it
easier to add new entries and maintain consistent formatting.

Also use a space between the type and field in struct csi2_dev.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v2
- struct use one space between type and field name.
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 84 +++++++++++++++---------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index dd8c7b3233bccfc34b59e0f0ff813b36752e1526..1113ea2a37f03753423164069b95c049968cc0af 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -23,65 +23,65 @@
  * there must be 5 pads: 1 input pad from sensor, and
  * the 4 virtual channel output pads
  */
-#define CSI2_SINK_PAD       0
-#define CSI2_NUM_SINK_PADS  1
-#define CSI2_NUM_SRC_PADS   4
-#define CSI2_NUM_PADS       5
+#define CSI2_SINK_PAD		0
+#define CSI2_NUM_SINK_PADS	1
+#define CSI2_NUM_SRC_PADS	4
+#define CSI2_NUM_PADS		5
 
 /*
  * The default maximum bit-rate per lane in Mbps, if the
  * source subdev does not provide V4L2_CID_LINK_FREQ.
  */
-#define CSI2_DEFAULT_MAX_MBPS 849
+#define CSI2_DEFAULT_MAX_MBPS	849
 
 struct csi2_dev {
-	struct device          *dev;
-	struct v4l2_subdev      sd;
+	struct device *dev;
+	struct v4l2_subdev sd;
 	struct v4l2_async_notifier notifier;
-	struct media_pad       pad[CSI2_NUM_PADS];
-	struct clk             *dphy_clk;
-	struct clk             *pllref_clk;
-	struct clk             *pix_clk; /* what is this? */
-	void __iomem           *base;
+	struct media_pad pad[CSI2_NUM_PADS];
+	struct clk *dphy_clk;
+	struct clk *pllref_clk;
+	struct clk *pix_clk; /* what is this? */
+	void __iomem *base;
 
-	struct v4l2_subdev	*remote;
-	unsigned int		remote_pad;
-	unsigned short		data_lanes;
+	struct v4l2_subdev *remote;
+	unsigned int remote_pad;
+	unsigned short data_lanes;
 
 	/* lock to protect all members below */
 	struct mutex lock;
 
 	struct v4l2_mbus_framefmt format_mbus;
 
-	int                     stream_count;
-	struct v4l2_subdev      *src_sd;
-	bool                    sink_linked[CSI2_NUM_SRC_PADS];
+	int stream_count;
+	struct v4l2_subdev *src_sd;
+	bool sink_linked[CSI2_NUM_SRC_PADS];
 };
 
 #define DEVICE_NAME "imx6-mipi-csi2"
 
 /* Register offsets */
-#define CSI2_VERSION            0x000
-#define CSI2_N_LANES            0x004
-#define CSI2_PHY_SHUTDOWNZ      0x008
-#define CSI2_DPHY_RSTZ          0x00c
-#define CSI2_RESETN             0x010
-#define CSI2_PHY_STATE          0x014
-#define PHY_STOPSTATEDATA_BIT   4
-#define PHY_STOPSTATEDATA(n)    BIT(PHY_STOPSTATEDATA_BIT + (n))
-#define PHY_RXCLKACTIVEHS       BIT(8)
-#define PHY_RXULPSCLKNOT        BIT(9)
-#define PHY_STOPSTATECLK        BIT(10)
-#define CSI2_DATA_IDS_1         0x018
-#define CSI2_DATA_IDS_2         0x01c
-#define CSI2_ERR1               0x020
-#define CSI2_ERR2               0x024
-#define CSI2_MSK1               0x028
-#define CSI2_MSK2               0x02c
-#define CSI2_PHY_TST_CTRL0      0x030
+#define CSI2_VERSION		0x000
+#define CSI2_N_LANES		0x004
+#define CSI2_PHY_SHUTDOWNZ	0x008
+#define CSI2_DPHY_RSTZ		0x00c
+#define CSI2_RESETN		0x010
+#define CSI2_PHY_STATE		0x014
+#define PHY_STOPSTATEDATA_BIT	4
+#define PHY_STOPSTATEDATA(n)	BIT(PHY_STOPSTATEDATA_BIT + (n))
+#define PHY_RXCLKACTIVEHS	BIT(8)
+#define PHY_RXULPSCLKNOT	BIT(9)
+#define PHY_STOPSTATECLK	BIT(10)
+#define CSI2_DATA_IDS_1		0x018
+#define CSI2_DATA_IDS_2		0x01c
+#define CSI2_ERR1		0x020
+#define CSI2_ERR2		0x024
+#define CSI2_MSK1		0x028
+#define CSI2_MSK2		0x02c
+#define CSI2_PHY_TST_CTRL0	0x030
 #define PHY_TESTCLR		BIT(0)
 #define PHY_TESTCLK		BIT(1)
-#define CSI2_PHY_TST_CTRL1      0x034
+#define CSI2_PHY_TST_CTRL1	0x034
 #define PHY_TESTEN		BIT(16)
 /*
  * i.MX CSI2IPU Gasket registers follow. The CSI2IPU gasket is
@@ -106,13 +106,13 @@ static inline struct csi2_dev *notifier_to_dev(struct v4l2_async_notifier *n)
  * reference manual is as follows:
  *
  * 1. Deassert presetn signal (global reset).
- *        It's not clear what this "global reset" signal is (maybe APB
- *        global reset), but in any case this step would be probably
- *        be carried out during driver load in csi2_probe().
+ *	It's not clear what this "global reset" signal is (maybe APB
+ *	global reset), but in any case this step would be probably
+ *	be carried out during driver load in csi2_probe().
  *
  * 2. Configure MIPI Camera Sensor to put all Tx lanes in LP-11 state.
- *        This must be carried out by the MIPI sensor's s_power(ON) subdev
- *        op.
+ *	This must be carried out by the MIPI sensor's s_power(ON) subdev
+ *	op.
  *
  * 3. D-PHY initialization.
  * 4. CSI2 Controller programming (Set N_LANES, deassert PHY_SHUTDOWNZ,

-- 
2.34.1


