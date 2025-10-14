Return-Path: <linux-kernel+bounces-851813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D168BD7569
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4978D4082D9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDCB30E0CC;
	Tue, 14 Oct 2025 04:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UfDcCIgW"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BD30DD2C
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417721; cv=fail; b=NXdebMwuUGsYh5G1SEu7tlhk6P9ewuM91AHYjgqVDCs7joBp4qjUMmCU57eQhqr7lL8R87n0HiKAUJ8qJpygp3ksXO8SBvz/+lbdkkqTB+4LnRRrnx2YoTai9K/IwhMrHDlVSYthhYgUVA5uSSLsbGGizFL7bFXQg2h73/jYK9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417721; c=relaxed/simple;
	bh=5unI9c5m9IXOQuHH5pqSnrEDHuYavYZJ+al87e6FFnQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=NuCTBNY6zDo/TT494/uwq2klA4ifk3TBByDue3ZfXD6/0eqHgQx3KQKAs1lOeg5bUn0XlbL1lo+XtrRboxtBs+S5kQJFxX8q3/Hjy8kFLaKr1l0KDOY4l13RsLk3+Bk7QthFZodmuCyIMxmZj3QTeeEz9wjym43RxdPwysoe1FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UfDcCIgW; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DefNsY/tNSScVmm9vTYRtkpCYAYZZWz4J/VxLpN3HrKo0JzlcdDro0nt31pZvKhbgGapWudYHyMq78PJjyviSk4tW4O8QAytJ/uLAnnvMsHpL1vZHvkolPVGcQFzhnaAyqx2o3whnC6PPj3c4k/oy4immx04InM4UOevXceSfxK5AV8OJpJjUvSuyBvZyBbDJn7Vx38CiCIhpG6nhsI8+0hqd7WIvqjTZVM25r9epvxVv+8az1HXyUMzVT7SOTZR7BpDjj1HFOr3KkXrnVTZdZeQM9x4W/svG/XEJQKqnBCwa+kJhi+cShrfr7zFLVvlIGDOFJKGYecmRx5Sjiz+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGrf6bHeWEu1WHa8bMWNQY+/jdHg3GVX7eWnoInMjpI=;
 b=P9BXpvEue3Ulv+JJYnf5xjwjg5y192xnFfe3GtV8aqO+U07y+29E8lmRzWcRsmknF1W7mPReUXm7gxNWl3diODETwx/5LSnIyZSmTfk8Gk1vbt5ujgzIdVA55YgbwQnzbeur0Ph5mBYefbg/jBC94dgk4r/zoNpXcz2uHTKczp5aLTqKKpD/RaULdLEaMPsTIChjboap55YYEiJtdbf1WatBhIB/5MUZ0h+RloTT2zoLckSMSQtTQd8V1YGAUh+FfmiDxFjNC6S7gBT6Ga1uxHd5v1Ax6ISYguJa52kIXqO6f266SHVQo6nEgxV7qXX99Owstvfx8Tw7TgR5p0v0+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aGrf6bHeWEu1WHa8bMWNQY+/jdHg3GVX7eWnoInMjpI=;
 b=UfDcCIgWvHb3sXZoS4gAwXDNdHaMM1ETwchCEhR5L05T13ocIt9EDl7g3rdmvjZLti9X8HGjrbtV8JR+b1TUPoi1NI8fJ56QoFn57qUmWRmU89VZZB6d1wEKGKXR14NGmgb4GyqPZ3FA2Y/8S29CvwRP8twnTUGWbFTlU7Y+CUTdmRJYPZJESHjSkoyhwar3Cg+ZR0HSe1+s4uhp9MO9cVfY2r4lNpEkYD/wDmUXasKYAyMoNQbPyJKtS3nMiBB2hx57xfwqjrgLRSkVz+uMnH/JSONnbFva/ULvq6VnKOnntT267Z220+0EpB9W4R1dJ119BYyz2WN1E72oaXJIbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:16 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:43 +0800
Subject: [PATCH 6/8] firmware: imx: scu: Update error code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-6-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=1044;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5unI9c5m9IXOQuHH5pqSnrEDHuYavYZJ+al87e6FFnQ=;
 b=HaiWDHKD0XyszNvGN3ZrM7c0hqGvPCszM9CCfXNaYkve7neWgwSx6bUk3atGG9nviFblA58A5
 07+Q5E09f7mA+NlzhjgOOBI3+Rot7kAmZm89UVCx2Ed0iRrJs/n34t/
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 220ffe8a-7585-4d2d-b844-08de0addddfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVcvaEpRRjZ2TnFLQzhvMmRmNE84L0xERG1HMEdja2o5dDhtMGJMYmtKUlZ1?=
 =?utf-8?B?VVllN21ubEt1VTFYTXppbU94Q2pVWHBGdmpteEx3RXUzcDBVa2ZxSTN2b0g4?=
 =?utf-8?B?SFBTR0hET0NtNG1Dc245bVovOXVkSzZHOGRacU9LYjRzcHVrWmYxYzR3Vm40?=
 =?utf-8?B?UlhLVUlKLzdEQ3RpQnV4YkNyU1hyNjQ0Y1R1ZzhmUXJ6OFltM3ArYUU2NUda?=
 =?utf-8?B?TXBGYnpnenRNNXpzRzU3U2ZiWXBnQ0trMWpQTFlaUk9YU3FTV0dMZmRadzd1?=
 =?utf-8?B?aDNtTEpDd0lYMytsY0JFWTBsN0ordjV6azBGM0Z5cE5hcVV2eXVGcDNYVVBC?=
 =?utf-8?B?M1RhQzViYUorRFM1MnU1YmFiZHVJOFhMblo4OWhqQVJWWTgxVzVxc0xXalY5?=
 =?utf-8?B?bG9jNzU3R3NUV21FUXh2Y01xY0xxUzUrcXY3WExHYzFUMGZ5ZW9KNmdsaEdM?=
 =?utf-8?B?dzAxYjBKWmxZTTRQT0hBN0xvdjV3MDM0TXBEMmdEV2ZZSzUyRDFyM04zREN0?=
 =?utf-8?B?aEJCTVBZU09GNjRPVG0xRWdPWHJMRlgrKzJMdmZzdjBxd3h0N0g2NXNNaTh1?=
 =?utf-8?B?QmNyU3NMZHVJeHJ1QkpkMytiMlBIN0NTU2o2T2VpV1EremJuZ2Nvc0dQelAr?=
 =?utf-8?B?TWpLNDdjaDZwTm0vN2FLVmdVaGlBTVVGR0d1UFpkSDFLeDBvSmUxWUlDVGJR?=
 =?utf-8?B?NTFveitka0MrTkluREJaZ3N4cE5wVndYbWFQRklYdHE2eFRFWHVnUVNzVmlX?=
 =?utf-8?B?Zk1PTFFORVMwSzNaOHJHangrY05tVnFDaXVLaUVLQ2tFZEZVR2FaTllrbFpG?=
 =?utf-8?B?akRRVTBEWnkva0UvcHg5WG5MYndtbkNPN2dRTW80NGl3eFRScXhzWi84cHBM?=
 =?utf-8?B?VCtiUUdKUHI3M3dlek1MQStqWFJTSzUzdmRCMS92WnM5cXd3MTRxak9uU2xB?=
 =?utf-8?B?TTBITTc5U3hKV3RKZlNyOXZPdXJMSGtnZVhUK0N6V05LOWdRTFVaaDFwNUg3?=
 =?utf-8?B?dW9wc0hWRkJvMjRONTU1WjArbGFabHBhQWRjcWJPL3Y4YTZON2JQVU5uM0h1?=
 =?utf-8?B?QzBCejFhYmdZSHRzb3gybERoaU9DSWpmQzdFcVJqQTY3WFZ4dUVyZFJiT0FM?=
 =?utf-8?B?NGl6VkcvemQ3Z0N5ZHVuSC90N0pHZWtlNkQra0dJYUdLUnhtVWNaYnR6QzFT?=
 =?utf-8?B?ZDVEN2hXaUpDTk9LbWJUVVVTY0RubHR0VkV2NjZXUjBMSE9jOFEvdUhrNlow?=
 =?utf-8?B?ZnRDeExsRHY1WjVqT3JzRUdWMjRtaDhaUDB6dU9NOXlJU0RzUUlKRTJMSkRT?=
 =?utf-8?B?bkhaMVhxTURkcnZzMlc0Rm5GVHNXUk1EcTk2Z3M2ekUyZVlUWEhobGV1VHZp?=
 =?utf-8?B?VzdNNExxNVBiaDdzajcxcHZQbjNQRld0clVrWDFObVBua3c2ZDc5akpsbnJK?=
 =?utf-8?B?dWVTRitqUDhXL3RsL05WUExkMlFncUlYcjJGZ3RlZ1BqdStQcEdscTVNVVNZ?=
 =?utf-8?B?UEFjUk9MdUV5YUVMeS9SQ2NDMGgxWm4vRHoyblBIWXpMdUpMUXhmb0VsS015?=
 =?utf-8?B?QlpTVXhYYUpjN0pnbVVPRGh0RCt5cVg4bXMrbDY1QW9vVEtiZkhRQU45ejNX?=
 =?utf-8?B?ZU1veEZFT1hnSlFCZjNqaUxyaDFUOEVIQlQvL09JQWhGTzlGT0tnN240L0sw?=
 =?utf-8?B?VThPY2Ztc1NaOHUvcTZZdEE0UXVFOWxFbFJVQzdFajVUbzFicGNuTFpYWFd3?=
 =?utf-8?B?RWo1S3lWMGQ3YitVY0dMcEM4a1VETFlRSWxONGUwTzlydkticU1ra3lWT3hx?=
 =?utf-8?B?ekZCbHdNNU5rT0FDVkFvTzRRWm1DZXlKMlN2b01DY0RQL1poLzhTOHpQNTl0?=
 =?utf-8?B?U01TUUNkZzFWZVplVjloVm4wOWg2TTM1dW1FTlQ5NEQxeFUwZXVoNFVmTXZV?=
 =?utf-8?B?UVZNUTV5RzIxN1FuVHh4VlVnMWVoSWFnZzJuY0QzTHJHWkFLZkpXblJBc0dm?=
 =?utf-8?B?TGRqNkxvY1BBSU9JaGgyR0V0SnZ3Ui9tcG16OWh5b3BDU2tqTVNMcU1Yc0Uv?=
 =?utf-8?Q?3Yc8Wf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTBBZlFyK050ZktqMHlWOXpBbmRTOGpmZUFPUm1QZnFXY2FXNGhVOFNwa3B5?=
 =?utf-8?B?RjhaOStja2tJeStBV0YwSEcxaGVUREV3MXIycU0wOVNjS2pkK0pwWjNjVkx0?=
 =?utf-8?B?ay82TlZOSnZobVI1dUU1dXg0ZVVCQXVkUmlZNmRKSk9vK0Q5K0ZsaHJSdENW?=
 =?utf-8?B?dzFXVklvak9zdTAzajNLQlVFeXRTVDg5NEtrSkMvb3pSa2lyeGk1V09KUUIw?=
 =?utf-8?B?aTRQNGJuRlYxN0k1bTg4Sld1QU1PRmlVVlEzdTRCdjRNdklNeDJ3ZEJjRHpu?=
 =?utf-8?B?UlNLUjcvRThDTmxkRXVMd0RHOXhia2RueWVnNkUwemp2bWVCQlQzRllVMmto?=
 =?utf-8?B?bVMyL3U3eVJRSWtFUG5iQ2VJMDh1ZVoyQU1NTzRvNHlXMzNXRXh1QlF4NnEv?=
 =?utf-8?B?alJLVG9ENm1xaWd4dXBxRlpubmtTL1JLaWZFQ29TekFNb3ZtaGJIMUhmTzVv?=
 =?utf-8?B?eVhiM3NxOUtSZUV3Z0xyR2Jxc1Z4cmxpZC90emNtd2J3UjVuNnZmcThnaWtX?=
 =?utf-8?B?VFVhOXMwNmNaNHF2cjd6eXczYnFMNHB6WWZIVEQ4OGtQbHlWTWVlcktXUk9Z?=
 =?utf-8?B?dEZVUXNEQWJpTlRBOWFEVDVMVjBDOWFIc2N4Mk4zdW0yaVVaRnIvRU5tekhz?=
 =?utf-8?B?ZTdIQmNNU1VlemtSUVk0V3FDdjFqL0U0ZUZxSUw2cHFHTWhWVzBzZWVybndl?=
 =?utf-8?B?cVdvYURRQWFBQnJWSEx3K0VVd2krU29FWFBFVkhNVVRIVUZ5eTVkVzZ6Qyta?=
 =?utf-8?B?LzJoT0h1YmRjNUh0SW16L0hQY29wNkFvTUhpaGUvNzlRYjduMTBGbWc4SUtB?=
 =?utf-8?B?VmFFclF1K3RDQ3FvK2ZXeVYwL0RseG90bkVFRk1Ed2U1ejZBQkc4UzlFc2ZP?=
 =?utf-8?B?REFXWStNd1dFYWxtZjAwVE1GTFh4cWZxakFhSmltVjlSZFNiK2FlOWVxSTNy?=
 =?utf-8?B?enh0bVBXOHVXS1dZYmJwa0IzUWhBZitjTVJ0VmNPUG9jQlEwQ3ZKcnlDL0JB?=
 =?utf-8?B?eWc5QmxSSWk4c1B6T0hveEFaSkxwbSs1T216am1GZTdwZVExVkh4NFdlUU0x?=
 =?utf-8?B?a0dOOXdRTU0zbDFvRTVJNmdSb3czQ3lnOFJCQnl1NUVINnh4aS9mNmlmcmlN?=
 =?utf-8?B?TWJtZDg5T3doSDlCQnRadVFHRWI4bit1MnR1blljbC9TSFNXNjFPTHpTR1RH?=
 =?utf-8?B?enJ4NFdGeFBibzlabG9FbmNuN3p4aUE5c29aejg4N0xDcE1mWHloNllMWFcv?=
 =?utf-8?B?M3dJdCt3YkJkaEMyeC9zNjFPd3FJbFBFYkZSWFhBK2RiUy91aS9GRng1b1B3?=
 =?utf-8?B?RlV3TTl5d0o2ZkhTWUlkUkZGMnVBZ0o1NGQ0c3lFVnVheXB0ZEJlNWplVXNK?=
 =?utf-8?B?WXZYMnp3YXd1SmQ2QTdmZDZrTnhwajFJMjd2K3cwano0UUwvM2JndXlzNjJh?=
 =?utf-8?B?Ty9IUGw0d3dxblBMOS9SS3phZHFEcldYNmE2S2V5Ny9JeWpnU0FZOVE0QStL?=
 =?utf-8?B?eUR0QTBIMHp4c01MZDRkenZGYnp3QXdhWFN1VVlKOVAwWXJkVkVMUVJ3eEZy?=
 =?utf-8?B?RC81a2FqOUg1RFg4MGdIeEpxaXF3OWJ6RGxHUGhGZDR3VGJnTXc4R2pJVmJZ?=
 =?utf-8?B?eEl5VDNEdTdhZHhIWFRFa2lqSEVCZjNvWTVPbVFTT1ByTHg1WU1SekIxcDZh?=
 =?utf-8?B?R3hiVmMzejROaisyQTVGQjVmZ0hFRW5kRTRySTRDNUxmcEpMWm1rTkFzTytI?=
 =?utf-8?B?Z2pJQ1NINmpUYXRpL1NSWXg4MWRmMEhoVVhMK2xhdVFnTXdRSVlWL0xGU0Iv?=
 =?utf-8?B?ejZEZUZmbGlkM1pHZzlsVm13ZVkyTHh5aXJMeU5EdmV0bzVBa3NPcWhad3lp?=
 =?utf-8?B?TXk5c1BIMlFhdXZ0cGJFakt1OWdDU3doUDZTa1drS2JJUURuVTZVUmlZU3Rq?=
 =?utf-8?B?ckNDSTM5V2Y5L0dVNXNDM0tPVngvZ1RKRk5qdlcyUGd4eEdlaDZUQUZCRk9E?=
 =?utf-8?B?UEhNeHQ1MzlIdk1kQ0xicmZXclZHUTJvUWhxLzlPdjVSNHVSb3dSM3JnTXNk?=
 =?utf-8?B?ODgvTjZjYStDL1N4VTFoOFpHdm94REFTVlpFYWdDR1BqaTNtSHJibnZJUXJR?=
 =?utf-8?Q?Zjbzf6uK0dxK7Nz4NhTbF8YKx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220ffe8a-7585-4d2d-b844-08de0addddfe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:16.6372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GbD+X8qwk4emWbDMpQveV5YPH3+FxvtfcCcA8HGsUfzGBA62n3GxiuuOU1M9GhaUxpH9kGQEOG56sTA4HUjF7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

IMX_SC_ERR_NOTFOUND should map with -ENOENT, not -EEXIST. -ENODEV makes
more sense for IMX_SC_ERR_NOPOWER, and -ECOMM makes more sense for
IMX_SC_ERR_IPC.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 8c28e25ddc8a650d2d191c40193cf1fb5e70bc35..6046156bc3c9abcd8f62b46f04571b1a9decc0eb 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -73,9 +73,9 @@ static int imx_sc_linux_errmap[IMX_SC_ERR_LAST] = {
 	-EACCES, /* IMX_SC_ERR_NOACCESS */
 	-EACCES, /* IMX_SC_ERR_LOCKED */
 	-ERANGE, /* IMX_SC_ERR_UNAVAILABLE */
-	-EEXIST, /* IMX_SC_ERR_NOTFOUND */
-	-EPERM,	 /* IMX_SC_ERR_NOPOWER */
-	-EPIPE,	 /* IMX_SC_ERR_IPC */
+	-ENOENT, /* IMX_SC_ERR_NOTFOUND */
+	-ENODEV, /* IMX_SC_ERR_NOPOWER */
+	-ECOMM,	 /* IMX_SC_ERR_IPC */
 	-EBUSY,	 /* IMX_SC_ERR_BUSY */
 	-EIO,	 /* IMX_SC_ERR_FAIL */
 };

-- 
2.37.1


