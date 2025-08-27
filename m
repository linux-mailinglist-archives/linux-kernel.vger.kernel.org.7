Return-Path: <linux-kernel+bounces-787675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D6FB3797D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 07:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E603C366B14
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 05:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F9130F7EA;
	Wed, 27 Aug 2025 04:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hqMYfb4m"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134130E0FF;
	Wed, 27 Aug 2025 04:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756270788; cv=fail; b=cvQk+mUC53zT/6U8S5Liv0xWtTu0T7Jr4NlPSnpr5tHGxKP2INiJF37IKTIyFPotC9rnBfHzaOIBONWcHUuB1dEHGDmVj20p+YuJicP8XxrgSe5wjZxzIeY3/m9rmHRIqTPHvjPsP5H/tiU5rBOh6AdltYuGVknb94HlHW+/X5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756270788; c=relaxed/simple;
	bh=XhAL8ROMn7krTliawqwXyMPOvyuU+R72Ek3M7DoLCB0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=S4Uhwl0eq+bkedsQtasgCRGOpXu/0aNra4z5F15AJsWJpBL0i9l1qzshOMD15pGLH6F8VJBmUbl/mP6cEX4c7zytDovLdSBeUmq6Z3Huzj+z5SFVsTIWWYTBgLF99Q8iVlGtT1faff87F6Mo9M2UhoNOFu9X09+gI+zWZMfkqb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hqMYfb4m; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P0vHOYJu0krM0Oo3mfHp7ZfuIo8RdJ8NAHof8rgEh/P8fOU4bNyCfDK8/TSbED3kJej+cHSlYTX1KjAhSR8tdXYAuvlIU2fDDA1x491EY3odcBFBrnisHTfuPCIZo6ISsHJl47ryTCeqlvZPV2e4BG8MXgQsrtZ1CnbxADnUu81OLVVEoP/4owHR8SHJbbQ2pZ+cXjRW/xp7sTJYjlEp2HGTNOINjgyQpJyFYcVPNP4vzI27EFHZF8ku8ejlo04+yZ57DRJN48za2njQ/4dPMCYL7sfRJ4nKyMALKPblFOEYUYz3/154xPuJTGOObDGckdvI1wxRazuSG4FMq0Ilvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJpaDeA/yWMWi8lLxXJKKBGyCxgbcvKDuTCwaPyvftk=;
 b=NntjPW6ETNushLpFgWFkTJzcXV8tQIsFvH/9stUZ+1KzA69h5vT87v7qTZqQhJ9dBVh2/0EHPr48iQDOAN/YciIKMlNZBIyUc+zLJ1+rNXO6l26pwFAFljjgfg4dggPlwQ8hZ0VU+1ehJdFzFwlbguuvDVbqv8DbSEldwlr6/fOMFjcRl1CSn5VCr1QeS9rHOl3IIVIAVYlR3frpHEDGMf9UCETLvqu3NI6AHygtVskwukxISu0Rm71HuzA/wK+19HSyvOav6AQjG440gXJfA69hj3ScN5R1wKuMFAZweIlU6BhB2jxlkWBvrrZOFPhF9jD5Hl4YLvfbdGv9k3Txkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJpaDeA/yWMWi8lLxXJKKBGyCxgbcvKDuTCwaPyvftk=;
 b=hqMYfb4m+oTO0mXtcCfOZghy7qKT/hM0gEng7utD+FfuxCo6Zx/fF2WE4/lAtqAvJUc73oukM3rpyscLL2CHwoeVARHQHH0MorLQbWF8dzyBv2KixCJHx88CH5XlAn990lXVwvE0kRv+5wLe72evhuE1ujk8Yw126KSBJBjDvXcZQpfUBsh2S6SbpatxgsUKOP+XF1bcEEB61+KBRDlbBMDytteWk3Yx+On/wKX/edF/x2kaRAsEHz3bsVKJpx5XP7FXYd226an7IbuSYj6xXfXT6pm9mCo419aWkGZki6yF6MAvFdBxAXcxDKtnxn9LYq5fdGnvC1x/rpkDvd1tSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB6899.eurprd04.prod.outlook.com (2603:10a6:208:183::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 04:59:44 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 04:59:43 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 27 Aug 2025 12:59:15 +0800
Subject: [PATCH v3 3/6] firmware: arm_scmi: imx: Support getting cfg info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-sm-misc-api-v1-v3-3-82c982c1815a@nxp.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
In-Reply-To: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756270768; l=2415;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=XhAL8ROMn7krTliawqwXyMPOvyuU+R72Ek3M7DoLCB0=;
 b=SWL2z4ww3WL8sL946rNcY6g/1D5/OJWzmxXUotc72phk881oPxl53HGlSsLS52/B+6H+qbVle
 5mP5PkKQPQBAekudetb3ini0rPDT1hMTnSbZ/fljKWWks8B/CDq2z5p
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 284851ef-5eb4-4ca5-9260-08dde5268953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTU2TFFHSGhUWnFGaHBncXJJR3M3QkthRVdhV3lCZVZsb1FMRWJOVW52dEc1?=
 =?utf-8?B?b3g2TmhJS0lPVHFDSWpzL2tJQUNyRFMrMUYyd2c0VW1DREowRysycDIvTWVr?=
 =?utf-8?B?cDVDUTJ0bEMzR29hcEZHZHZ5bUN5WkplcGxOcXhNbVFSTTRma3ltMHFjSFZD?=
 =?utf-8?B?UU1zdDgxUEl2OSt2YllwTWt1UjVrcndyejVhcFNqRHlrZFNiUTd4YTB1YXVa?=
 =?utf-8?B?cG5sNlhXYVFZbXNjdVp3NFNMSDlVbllZbm1CSkQ2TzdFaFlqQmJYdWVyRUgx?=
 =?utf-8?B?WmtwZmYzYlRBZGdnUlFXRmZYdUM0QU5hbzUwcnRScTVJYWJyQUVsQURpK2V3?=
 =?utf-8?B?QThwVEdjNkhYNUNPL1BaaFAvZk5QcnlvMFhyWHl4ckJZa2lhMUpYSW8rcFNn?=
 =?utf-8?B?clRkNDhId3gyS1AwekhPT2ZhT3BJMUZRcTNLMUsrTDhTOUpKM2lMMHRyK3RN?=
 =?utf-8?B?OXJRc054ZkRLdGt5eU00Q2xhQVc2blVpclRoanJtUEI2VXBYODZINjVOcCsy?=
 =?utf-8?B?cnFTUXFRbmlCZEIvanB1TnhOZFlra3hYVXZvdk02emIvOG1FOWRxK1gycXlD?=
 =?utf-8?B?U2c3SkF1bjV3QnZscWtwT0FVV2ZFUVVUeE5COUIweTJDWis2bVpYUGhrVCtM?=
 =?utf-8?B?NmIvZmd6UWovazM5b0UwUWxuWTRvQVNGQ0pidHNEaUlOV3RkdzNxNHpKbFlE?=
 =?utf-8?B?S3FBT3Q5VVlhS1E0aTNrRWFGaW9hNFBBaDFPWHo3UWl5VFdzcVVZS3VTU3Nr?=
 =?utf-8?B?MnI4cGRWTUFxUUJVa0o5akYrdnpLK0FmbWFtQmpudzNWVjhaZUlKcXV3ak9Q?=
 =?utf-8?B?VkNTbG5qc1B6QWlmZ2JuczR1VTJmVDAwUHRwMXE1Y3ZtYU9ZYWdVbVljU2dN?=
 =?utf-8?B?ZkhTOVFBMFRKcm9FOFlrYVlERTI1d2NKb3dtS1paUmVpV0k5enZacklHcUk4?=
 =?utf-8?B?TklqWTI1WStwOS9RaFpnNmx4eFFsd3VxQWY3RGZCV1Izak1iOWVMTGFCdFNK?=
 =?utf-8?B?ditJZ2IyemUvSzBCOTNFREU3bzk5andESHZrOTIwRHZmakgxQXVkNXFOTTdT?=
 =?utf-8?B?RkhWMTlZZitGOHdrRGdCaHQxV0NZa3VrOW5GU2dpTlhIdy9PRGtZSEpIZzc3?=
 =?utf-8?B?bnU1RmFSa0VOQndzbUc3cG14S01yTTFBd2w0U09JQkZvaHk5Y2FNT2IrQVhQ?=
 =?utf-8?B?SjVtdnczanFDWlE0c0EvSVJaeE9WU0R2aVlxNFFQMEVvd1VKUmViNUtkQzls?=
 =?utf-8?B?S3BzSVpyeTFjbW40N0FsazhSallET0lLSkMwZkpFTWdpU3hQTDJHcHZvbFUx?=
 =?utf-8?B?eWNIb3BOOHdtNWZXZXN6enlobWxEQUFoU3V6U3pBYUtpSXR6clJPM1FMN2dm?=
 =?utf-8?B?MHY3OWt1aHF6Y3F5ZHlUbmd3eC9Wc3dFekQ1T293bTJmalF1bFFWUXR3aDY4?=
 =?utf-8?B?MTZmaFZnbmZXaGZvelN5NEkvYXVZRjdsY09kSUJzNmVHcGNMU09UZ1ZuRWxC?=
 =?utf-8?B?eGJ6ZjZrelpRRkZQdzlHbndpQXZKRmtYYldDVllvZE43SldWZWQ2a2JRNGhC?=
 =?utf-8?B?TlBNNWIxZkZCNjh6U3pCS2N4VGtrRDROdjFNTWJoNndKYjN2Z2RtTlhsMGFX?=
 =?utf-8?B?dUpGdGFtclVFOGpEc0crY3V0YWZ6bkdtQWtCOHh4Mm1PWU9OaEtlU2o3Sk1Z?=
 =?utf-8?B?MGhHSHBUMHZMWW5NZUJMaHI2MkNoUFFzbUppT3Jlams1SnU1czhoZU9EbERl?=
 =?utf-8?B?Vy9BZFZkbm1ZQ2d6TW8rdjdWYkFWR0FoaXdHOVlvNHdmSlZlYVdHTm14eWJP?=
 =?utf-8?B?eTFIcklGMkpwai9pZVZFWThqazk2SUVZcHZ4eGFLbWtHM2Z6Si9tLzdoSnda?=
 =?utf-8?B?N3pOYnFhWE5lRUQzQVk2cHVObTUvcjhjSUgrci9lU1I4a1grVmJsaFhMd3BF?=
 =?utf-8?B?MkUxNmg0Nk53N0VkeG9iWFB3QzhXYUVJcFhJM0VCV2tKMnh5YllFR0t5K1Ni?=
 =?utf-8?B?dXlRM2lvakdRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b0szY1pKejdEMk9yLzN1TUZrSTRsbTV0N0xiTHRoRFVMSjdwVjU1RC95VzU1?=
 =?utf-8?B?d3dienFvT2QreWZDQzdaNmR2QlNxM0JVQkRPWk9mU1djcHN0MEQ1dGJJbEV2?=
 =?utf-8?B?R2hKTTU5UUNPVWRTSkVJZHdqdXVRVnErLzN2Z2ZYUkN3WDlFc1I5YnhFWlJj?=
 =?utf-8?B?eE9WSi8rWStjOUJKdm5WaDZnZ09LOGFDSG91Ly9YRTZ3dnVTdm01NzBMaGov?=
 =?utf-8?B?TCtmK0pUL0o0T3BiZGNhZk92VDRPRi8rb2ttZkY5a21XUkM1TzR3ZW9JVjd5?=
 =?utf-8?B?OXplTmR1WkJsNFpEb0RiS0RlSVM5dndKMTU3SVFXbHBLRXBTd1ZGRjdrak5k?=
 =?utf-8?B?Rm52aU9tc1d1elJjRWZITUZIeWhoOFBHbjIyRlJ6RzU3TFY0UXE4VGppZGli?=
 =?utf-8?B?TC9jNzlCMER4TXV5M2dSMGIrVzlKOXdYQll4emQrOW5BNUYrQkZ4QXprVDI2?=
 =?utf-8?B?M1VPRE9Gclh1eHV3aU9HcGZib2VHaFhrZ2J6dnFVQzZZNENIUDR0WWdoQ1Rq?=
 =?utf-8?B?MU5EWTh4TmNFc2haMHM4d01RMnY0aWNZNUFhZlQxMkpkOE1wQkF2MnVFSnVR?=
 =?utf-8?B?SWRUS0dwM0JYSWZ0TkV1cFNuU1NwUytXZEdiZU5GWjdoaHNILzZwRnZzUitC?=
 =?utf-8?B?dlZnQ25tSTVDWUJWV2lpcEhYUE5OTUtSZ2ZoU1NObEFmMFVmSDJZSlBENGNi?=
 =?utf-8?B?dkNnNkRETzZxRmV6anQrK1RpdUVwZkMzMlBIQkdhNm5zb2pzd3VMVmRaUEZR?=
 =?utf-8?B?N3YzRDFSRkJLNldGWmczem9sdENGekFrNjQ1aHgwSjM1ekt6dEhIdXRHMUJB?=
 =?utf-8?B?T0hGaksrZk90amxqb1c3eW82RkF5VHFQaTNpOUdxdHZlWkJ3bHYzWmlMckpY?=
 =?utf-8?B?THhVZHI4ME1hOUVSQW55d3pXcFpXVGNHNGxBNk9jK1Q5VHlPTG9pWC9UbEVl?=
 =?utf-8?B?bXU4MDdRTXdaUC83SVg1UnF1QjlENlN0Sys3T3dIc1JqaXlvZ3pnYzhiT0N6?=
 =?utf-8?B?NWQ1UUtHNzdqNGtrcHFhTFd5dkhFOGNJbWczVE1QQmpnanN3bUNDQmRUM0hQ?=
 =?utf-8?B?THF5VitNUTZBSXNZOEFSSjFhbUUwVDFEZXlmM0JLL3ZicGw1VkM3Z0hoaFNn?=
 =?utf-8?B?SXFMZVdZRzVmSkQzYmRzeHJKSmljUEN4eklYUnRhdGlJWHZ2c1V3NW9mWFJD?=
 =?utf-8?B?eDBhOHhHajR3NThEUzc0YnVNenZYV0l5Uk5mR0lQK1ZIcENiTUw4QUNmdlYr?=
 =?utf-8?B?d3JjR1NKSUFENTF3K1FtL0EzMVRPS2QrbldZemFMOGVyWFBBc3NMZkx2RUxq?=
 =?utf-8?B?cVRvSTcyaXNvY005MHRnL2dQOGM1YllZK1JXeENPOUFITTZXcXBPVkR3a3dU?=
 =?utf-8?B?S09OaXRORVhvcUQ0OVNhcnpoVFRuMnkzYmlWMytJVDF0bEFvc0pkd3NJZ2s2?=
 =?utf-8?B?N3UxQjRidHM4Sms3amRXT0hWMzNnQUlEdmZJdE9DNnM2eDhaYnBVaUlYcVB6?=
 =?utf-8?B?ZkFXYThLQm5WYVBBcUs2QkFabFNVWWFaOWpEQjZwRDdEcjdiM01aWVJ4N3du?=
 =?utf-8?B?Nm4vd2ZRbG1pVFBEQXdrOTc0QmRiT0VNTDNLbGNPZ3pnbnNKcUhwelVsN0g4?=
 =?utf-8?B?R0lHZ3NvZzFNRzdRS05yOEllRlowL2M2Y3M4cXVLbUgyQXBYUXJ3TUp3bWMx?=
 =?utf-8?B?WTEzR25jOFV3VC9EZXRsbERwcGZ0ZGorR0lhY0o0aTRkWHE5WGpxQkhTMFln?=
 =?utf-8?B?RCtxRFBjK3F6SkVNdnoyV3J4RkpLTGxUQ1NiRE8vUFo3dlpzTnhqRE1WdzRo?=
 =?utf-8?B?ZC8wQlJPb1RZNEowK3FZZWsxMjVaNE5HNmxNd04xdmR1bzA2ZTR5UVpLWVQ2?=
 =?utf-8?B?elVvbFJQOVVUTFJVQ21jWWhiV21vWWx2RTE4Y00rYVZ0N0hDbVB0ekpCdWpS?=
 =?utf-8?B?R3MrTzBvaUMvUVYyZERTTGtDQjgwc3hNLzVlUGY5V2tyV0Z5cEozR1RrK0F1?=
 =?utf-8?B?ZEpMNFo4VE55UnpmK3VVeE9taFk4SThxQ3pNQVVNUFFKQkxvUXJmeE9WUllC?=
 =?utf-8?B?bGRmZ2VCczdJdlNZS2RVSlh2K3VSczRJZnp5WWx6Qk9MMFA5ZUV5MkNqa2dZ?=
 =?utf-8?Q?WIQvjMbNErboug2/PwgpGjRWs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 284851ef-5eb4-4ca5-9260-08dde5268953
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 04:59:43.3217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U5uQRuKs59NnMUIXPMxQO57pw61RmSXp7PB6Hm3KxVn1ZE/YQK5m+ThkA0O8wQ8vhoyHCZgnmYsWSts2lmyhIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899

MISC protocol supports getting the System Manager(SM) mode selection
and configuration name. Retrieve the information from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 464afeae8267d8c1eca4c4d5e008eca6d741c6ff..220b9369fb537306f9e1a105930ad4d65e6b10aa 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -26,6 +26,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_SET	= 0x3,
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
+	SCMI_IMX_MISC_CFG_INFO = 0xC,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 };
 
@@ -75,6 +76,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_cfg_info_out {
+	__le32 msel;
+#define MISC_MAX_CFGNAME	16
+	u8 cfgname[MISC_MAX_CFGNAME];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -309,6 +316,30 @@ static int scmi_imx_misc_discover_build_info(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_cfg_info_out *out;
+	char name[MISC_MAX_CFGNAME];
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_CFG_INFO, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->cfgname, MISC_MAX_CFGNAME);
+		dev_info(ph->dev, "SM Config\t= %s, mSel = %u\n",
+			 name, le32_to_cpu(out->msel));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
@@ -340,6 +371,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret)
 		return ret;
 
+	ret = scmi_imx_misc_cfg_info(ph);
+	if (ret)
+		return ret;
+
 	return ph->set_priv(ph, minfo, version);
 }
 

-- 
2.37.1


