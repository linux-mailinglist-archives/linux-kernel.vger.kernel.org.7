Return-Path: <linux-kernel+bounces-793769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 782E7B3D7FC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 05:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34607177D68
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 03:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9966202C5D;
	Mon,  1 Sep 2025 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLmKNQw2"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96E521C192;
	Mon,  1 Sep 2025 03:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756698728; cv=fail; b=MC1B7XoKXeeuf06CHr2kM7ppD2aS7F49Ktb2QNQeDCBQCbavuj9c6ru5AHkZJmCErcX8X6pKoC7QNy6+8h+rulw2PyV7lOQwga+sMmzTufn52Sho0uaZWHXGSr1pTOIAkl/QvO3uzC1L0vl3U82Ma2/95Z1Gle4jGfVdfr7YnQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756698728; c=relaxed/simple;
	bh=wHj3HDimqqwUH8bTE42s72eSY99c4VP/N4xs2fwCQMw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=imO17ODJYzR1O5oWjf7kJ6SF7CTIRVkm0D/NY9NinU/iAzFEPDEINifQKHeqyvujxhFTuxMl/tB+gx9dBl0MWL8lA3nMJ07YUWri+TpIh/fTQ3KPAM+/v022BMPekSExVEUoLm/rmalUPChoihSzauJtxFe9BXkib17WWMsxnQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLmKNQw2; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7GACPqFHSj8sY+iT4399sIO/L0vxNOPsmEStnnr7o/VRs2CGw4BX4aVfracryd9PFBNpUtwS6LOjZtL+Pl/mT7LAXcC/BvkhvfO43HDj8JfXUwRm4/lnBloF3NFWd55jmVVgdaITMob4sk5nFnB3qzGpj9zX2GMIxt1qMiHiUEgyToIQYqLczAiCsLYqq9EjSI/fOlUa+VGVDupBUSG3NUJVfNdARsbhy2XFe9LvHKG9gCLSxn10W/0Ug8iwecnsQMQfbXh95lzC/tBK6LvlBDqTKh9BUUQd64LHL5iKeKLz8P8vYAnZ8j8dgDUtiv1cYkvgoyMiCMvbyhKa0YK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGHH/PAWVJctrJAM8aKe1N1UOH6HKY37al+SUF0PR3s=;
 b=VCKfZyxVmIih7HankaIvNuF9wiwINoodJXjL79E05Y8oZw7HENOZM5GzlJe0PYULmOpG7yrW9zOFgy3Jm5MA+0SLcb2j9oeF20qhEZ4uB2Dw59+4YHLHq+YYqsy4CsWHJk63Mr7McQPPNBBX/9WtEWfR41cwK4zITBDCvUSgPY2kmFeFmX5dQpCgpgdOVExKSW6PDwUT6Bmm4UGmt58rfi+/vjtNKh+MoGjzyHzheQbo1itjDONWHIUU8Muaig3x36cZAz+KfmSsJxRaBh/ZxpL4tDOLPV+7WzDD+D0w/Q8G61fRF/cyGNq0Ig0hNvc+MHMg3mOAcM1yUayvRJI/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGHH/PAWVJctrJAM8aKe1N1UOH6HKY37al+SUF0PR3s=;
 b=WLmKNQw2E4T1Z9Q3o+oAQnBoVauyhxZPfvocPz6Ye20wDGOzznhwrkEdPSHNfYCW+TNid8D58W0s9jd4CMAI23b8Gig/W8zDy4h3xbB3NN8HvDbM1YLY3KFLUuzg5PdAYhD++hKaQ/pzz48wLpg8Z6/XEiMD2GOBkDOm8o9/GoNfnH+tWyyOxuQWaE/e5YQxmFHFZxNW12knje7TV0XVAY50hwrH6EDitlcmDtyX414D8pu54mlf2Ahz53hDb/elXmiQsZ5BhppHaJAAOoQIEb9LAsEjfMjaii5h4umY4nl6AyLccGsi15oAUrhBD6GbdlKJXbwgyIAiZSOCmlQKBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11358.eurprd04.prod.outlook.com (2603:10a6:102:4ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 03:52:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 03:52:04 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Mon, 01 Sep 2025 11:51:45 +0800
Subject: [PATCH v2 1/3] clk: Introduce clk_hw_set_spread_spectrum
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250901-clk-ssc-version1-v2-1-1d0a486dffe6@nxp.com>
References: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
In-Reply-To: <20250901-clk-ssc-version1-v2-0-1d0a486dffe6@nxp.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Marco Felsch <m.felsch@pengutronix.de>
Cc: Brian Masney <bmasney@redhat.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, arm-scmi@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756698713; l=3629;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=wHj3HDimqqwUH8bTE42s72eSY99c4VP/N4xs2fwCQMw=;
 b=XpbG9kH+sVMRfpUmTs1cJUmTlhk19jMmfvuAEqk3J9wP3onJLqVuFR5BesA4HxVpY/9TGL0oi
 ISflH6m+b8BAJf1F+GSpcodhSLag2dH4/EDPMGbfI2IIvKR9jg3KXRL
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11358:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd09150-7a20-4d5c-072d-08dde90ae90a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjM1TFNnSlcvbnNFQXNGSjZ0ZFN2Tk1EazJNK3BCaXlkN0RERllydi9jRldS?=
 =?utf-8?B?L3NoVytyV2h5c2JDSXBIZ2hGSGs0NmNLRXJRTWxFQVJ5cTh0c3l6Q2xNVHBP?=
 =?utf-8?B?OEF4MEZaa1FIMWFlektWbmdEVGxzSTBLWWNDbVo0NmRZMnU3Z3FtOEpzZmgz?=
 =?utf-8?B?MnNUdzhYc2REVDdaRGh4MjVLRk0wditGaG9MZHd6U2NBVTZXYkVkNWVnM3NM?=
 =?utf-8?B?Q0dBNzg4WFBQNHlSKzFUWDB1OVFnZ2sxTTdXUG81M1JnTklVUGoxaFgyMzho?=
 =?utf-8?B?bENBU2FHRWN0V0FkNk9OZUhWa2ZScG9qQ1ZRZm9naUprenh6cFRsNEtRVEdY?=
 =?utf-8?B?WS9KK1ZKOGw3KzdnWk0rTlFuSko4TzJmTXcwV3ltSG5CL1dZNk1LUEdUNUVW?=
 =?utf-8?B?RXROV3NJWUExRHBzbk9UV05yM0tTNWNTOEJObnFFZHBJd3p4bCtKeFZBNld1?=
 =?utf-8?B?cEoyRndocUhxM1RHVkcydkw3c3FpaFMwRjFodjBKYWFmS2Q2RDlIM3BFdTM1?=
 =?utf-8?B?cUFFRVN4bVVoU2Nja0daOWE1b3lwMER6bFAxWWZiRHo2VDJYV1l6K0dVNjBX?=
 =?utf-8?B?TVdLN1p5cHBMRTBQTFVmNUgzZGtySk9SaDUzTTZMeEVoL2dmMURENDlDOVNC?=
 =?utf-8?B?dzA4RlhFRnBHN1F0WGMvU1k1ZDZPM0NKOUZsczE4ZWhKUWVNT0VwYUtUSW82?=
 =?utf-8?B?Mzc2UWt4ZFFHMHRCYnVibUdkcVBYMEM0Y0l1QVlxZldvcVhpWnlvMkZOK1N2?=
 =?utf-8?B?KzNiL0VWS2toaEZKWnZ2NDNISk5KUC9OVlhJeng2aXpFOWxMaEZ0QWJjbm42?=
 =?utf-8?B?bFp0d3ZQbUhEdlNUazhsREgwSDk3d3AyNjkzU25aSTQ0R3p6ZEVlcll0VTJa?=
 =?utf-8?B?Ujl6cTY0cHgzaktqVTkyUlZDU1pwckErUUNRbzJsUENPRTVPQy83TVdDajlN?=
 =?utf-8?B?QVYrbkdCTWZiVk9Bcjhvb0cwSVViK29xY1lSTzY2OThtWDkrbnB0RkNwOFBt?=
 =?utf-8?B?Yjd0WHZTWndrdVpFM1hvYStrRjA2WElOMEh0SzBKZkNaL09jdktMZTk3L0E4?=
 =?utf-8?B?ZTE1K0oxSUVaalRPb1VGK1JMaFhUUm9FazZZLzB6NlJ1bU9GSWNQVnZWYkRR?=
 =?utf-8?B?bVRRaFhwV3RGN0ppRDlzcm92R1RESkdUekM2TTlYbm4rbE5neklVYUUvRE9N?=
 =?utf-8?B?bE5jSnNtbjczYWFXd2dBRngyOFpnUytlNnV3ZzJkSkdoQVg0NGdEazlkNG9v?=
 =?utf-8?B?aDBMSUluZy9oL0FvU0FqVXFoZ1RKYUdoVWtWV3E2TGtOUTZFWUpQYWFEU2pQ?=
 =?utf-8?B?clVMczgyMklqbkwwWEx6c1VXOFR3bXlzV2t6WlAwZlpVQ1A2SUdMbmtBbFNa?=
 =?utf-8?B?MmFaT2kzelc4VVV3djV4cTFZKytJSHR3VWJDeFRseWo1L0pQY2JrYzN2aHVZ?=
 =?utf-8?B?M0tWemMzSm5ybDNBN2VnaGdQRk4rRDArbm1SaXhOQnlMU053UEcyczJ1Tnhq?=
 =?utf-8?B?cThRM0lvV25ITUtJcjdDYnkxWmxjZm95bGxVRC8yUW9kK0lBbk9IRTBvY1cv?=
 =?utf-8?B?WkJndDRGY0RiSVphb25zVTlxMmF5Wm9XWXJLYVB4aGROUW9HWUYyOEZIU3gr?=
 =?utf-8?B?d3k0WmpDVFJHV0pINy8wWVdtZ3AvQ0xjaUtvQnh2OGxONEVZTHQ3ckREeXF4?=
 =?utf-8?B?bkhRTU92bG9EdkpHaDdDQnVFbGU2RTNEY2pCYlJSczR2Z09wR2NlUVhxQ2RZ?=
 =?utf-8?B?VkhPY3NCYzg4YmNoZVA0TEg0V2dUMlc1NjNwQWJPT01ZTWNRZEdEcm9LY3Qr?=
 =?utf-8?B?TWFYWVlCN3FjU1J1VGtNMGhNZTVIQStpdFFHSWRqSGlIZmQwUEtnU0xkallX?=
 =?utf-8?B?Z2crY2w3Z21yeSt0a0VJV0J3VUVKZCtUTTRBNEtkNi8zRGU1cXRrR0VCWHEv?=
 =?utf-8?B?ZFVsVFZHWkxrcmdWMWxGeW4rOUFmTnBrVXN5Mk1sTVNzdnZDYy9nUGZBSEY4?=
 =?utf-8?B?aXNhcldUNjN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTBSQStDejV4bTgrTWlKV1k5ZGZ1Tm1YSEdhQmdBczdOL1NJOEFSYm5DdzRD?=
 =?utf-8?B?NXkxYnNJZ1Vpbi8xOEthNVpadTE3ZnJBQjg5cWxjNEE4VDJEckxxVGtuNmZU?=
 =?utf-8?B?UDgwMG1tbGtKVGJkRDJOaE1sOEp1UU4wWlUxVUVULzhaVUQ0N0x1SXhQaEhS?=
 =?utf-8?B?dUx0T1k4bXU2VjZmdEM2bkgwZnFLRzBMOXpDMDQ3dGtxQlQrZXFXLzlLV3Jx?=
 =?utf-8?B?NFlnUEkwbjNNNHBlUVl3WWVsSjdUOTY4bHdtQ0NUOGlDeWtTRUhFYU56cldT?=
 =?utf-8?B?bGM0SER6emRnNTUvMzBVUjZVSVAvR0o3aDc0MG5EaFhhOFZGRUZjKzByQUY0?=
 =?utf-8?B?WkNvb1JzeHRudFhHQ1RoL29FSVdzcEpaNFBHRnF1aUdKblRzbitGMXR3Rllp?=
 =?utf-8?B?YXRka3ZuUGtpZUNtaDd2ZjdnbkdDZGZPL29wM2FMeGNKdUl5RWF0V2JmdXJR?=
 =?utf-8?B?S1lUNHFYaytCR0NzVkVvQ0NPMlJEdE00ZHVvTHpUd0RjbEhERUtQY0hLdTNL?=
 =?utf-8?B?QzU5RHRPWkFnTHNpblNkRzFZa0dVMi9vRXFacm9NamFaSXFOQUpTY1Jvd3Zt?=
 =?utf-8?B?clhTRS9ydUQ2N3pFZmZSKzRuNStWM2IxR3F2US9jcVp6dUEzdlg3S0RDaDRX?=
 =?utf-8?B?cm8vdnNEZXhDd2N6NldMejJDWmZ4VXBkNTVxTVFXVkk4MUg3Z0I0bUtZM1E3?=
 =?utf-8?B?WnBlVnhrdy9mSno0Z1grcTF4a2J0alNIeFFxQ0Juam1aK1AwYjdMMHV1b0Iv?=
 =?utf-8?B?cGNWU01FMHZsZGpmMm1WWTdOazZ4YkVSaHVmMDJRcHZjNWpuNHppSlIyWXhq?=
 =?utf-8?B?SmZmd1NsVHM5ZFVwU2pHbmRUYlZzK1NGczZvaEpIeXZqeDhVS1BJc2E0d3pk?=
 =?utf-8?B?SWsrMkFQOGVZSVVCanpIbWRvNnFyc0lPWHcwVm1OSlhTMjMyNThWMHBpaURK?=
 =?utf-8?B?TlBBNm1CL2RZQzdvSkJmam9NTE9lamFIVkRmbS8vZ3M3UU9QdXRNeVcwdkJl?=
 =?utf-8?B?WGxEWjBlWFFFcEdhSW9LZndrV2ZEQXVCb1VkS3p4dEpzZzZEVXRiVkxZRnU2?=
 =?utf-8?B?dUNwOTZkSkV1T0NOQkJPYm1oT0UwWm8zTW9GOTQxKzFNNzMvYzlVT3lIcFN0?=
 =?utf-8?B?eU0xdHFHTDJldElnVnNWcnlRUUhPT2NPOXhGUFFuY2tta2VibzFqN242KzFR?=
 =?utf-8?B?OFdxdHFlWTRwczlZSEloT2c2V3FJS25iUTVMTHhDY1pPUkJSQ25MNmtiSElQ?=
 =?utf-8?B?dUx6eCtFbVBmMTdadUVZSFFqQVdnMEtPb3lSWmc1TU9oaWM5NXBNWmJuVm5x?=
 =?utf-8?B?SXhnMitSeE8vTUFVaGhUMENWSkZKcVBvbzc3SDBSbkNEZGM1TjYvcnZKTGFX?=
 =?utf-8?B?WGR2QVVRMzV3QUNvN0RDUS9maEFBVDVtM0xOcTd0RGVTak5JYlRkNHlNQndo?=
 =?utf-8?B?M2tsOGlHWWF2MnI2Ny9BdW8yVDh4WVpkN1Z2M0p4ZjdXWFh4TGxWSVdCRFZ0?=
 =?utf-8?B?TW1HazBhbUJXR3IrNHV6QVExTGtXOEJtTUcxRFlxbkR4VDJMRUVCblBpem1H?=
 =?utf-8?B?RW1Iem52WkFqRldWRFNYb242NnU3L0ptaDB4b1RuQ3JPS1ZrUVo0amJDYzlo?=
 =?utf-8?B?OTVnY1VjSGd1cloycEZNeC9pTVNvcjl2YldvanpWRHpma2liU0RxVzFEQTYy?=
 =?utf-8?B?UXV1K3pTZ3krKytFWmwxT3NaVHBTcjRVUmlWOXdmZll3c3B4YXJoRnYxQUYz?=
 =?utf-8?B?VFQvSUlmVDRaZXJwaVJXOHVHeVRJQlY4b2U4cmVHeWpVNDA0RHFxUit3bGQr?=
 =?utf-8?B?OFNRZ0RxdmdvN1BabjZHOWR1T2MrQWlucXl1b3UzWHdYWWJsSTJpRUlFd0U0?=
 =?utf-8?B?ZUNWdlZsZFBsTU92eXNWWlEzRWxkWlFFc0h2SitHbmsvUWVKZ1orMGVGMEZ6?=
 =?utf-8?B?TUROSW5LVEQvaGxzcmtsOXpSdGIzWU5OWFlTS3NhcEc0dHgrcThOV2ZCc3ZF?=
 =?utf-8?B?TEtYaHcwbzNKM3M3QklNaVlWanhicU40ZW9OSVRUaG90SlhjaFVoUktRYVo2?=
 =?utf-8?B?RHcyMDZHU1Q5QTBWSFppSnZaUmJkUW1LKzVNdnF4UmdBTTZMRm9rd1RNT2Va?=
 =?utf-8?Q?9QfKo7zjW5jDFuNFZTrSawmMq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd09150-7a20-4d5c-072d-08dde90ae90a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 03:52:04.3151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0i3rKBRfiRSLVH8WZ5RzMSV0bLmxpvpOAQwoXNciZTTdSSvvr+UMtDU5Lo+UaOEIBSfuOcMq06QTmqn16GMW0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11358

Add clk_hw_set_spread_spectrum to configure a clock to enable spread
spectrum feature. set_spread_spectrum ops is added for clk drivers to
have their own hardware specific implementation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk.c            | 26 ++++++++++++++++++++++++++
 include/linux/clk-provider.h | 26 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155331c85fafbd2fac8ab3703a08e4d..06db8918a1b35e3280e565272bc4603a88295a92 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2802,6 +2802,32 @@ int clk_set_max_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_max_rate);
 
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf)
+{
+	struct clk_core *core;
+	int ret;
+
+	if (!hw)
+		return 0;
+
+	core = hw->core;
+
+	clk_prepare_lock();
+
+	ret = clk_pm_runtime_get(core);
+	if (ret)
+		goto fail;
+
+	if (core->ops->set_spread_spectrum)
+		ret = core->ops->set_spread_spectrum(hw, conf);
+
+	clk_pm_runtime_put(core);
+
+fail:
+	clk_prepare_unlock();
+	return ret;
+}
+
 /**
  * clk_get_parent - return the parent of a clk
  * @clk: the clk whose parent gets returned
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 630705a47129453c241f1b1755f2c2f2a7ed8f77..251035a96244c34ff2cbaaa349a08f4ea094e7fc 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -84,6 +84,24 @@ struct clk_duty {
 	unsigned int den;
 };
 
+#define	CLK_SSC_NO_SPREAD	0
+#define	CLK_SSC_CENTER_SPREAD	1
+#define	CLK_SSC_UP_SPREAD	2
+#define	CLK_SSC_DOWN_SPREAD	3
+
+/**
+ * struct clk_spread_spectrum - Structure encoding spread spectrum of a clock
+ *
+ * @modfreq_hz:		Modulation frequency
+ * @spread_bp:		Modulation percent in permyriad
+ * @method:		Modulation method
+ */
+struct clk_spread_spectrum {
+	u32 modfreq_hz;
+	u32 spread_bp;
+	u32 method;
+};
+
 /**
  * struct clk_ops -  Callback operations for hardware clocks; these are to
  * be provided by the clock implementation, and will be called by drivers
@@ -178,6 +196,11 @@ struct clk_duty {
  *		separately via calls to .set_parent and .set_rate.
  *		Returns 0 on success, -EERROR otherwise.
  *
+ * @set_spread_spectrum: Configure the modulation frequency, modulation percentage
+ *		and method. This callback is optional for clocks that does not
+ *		support spread spectrum feature or no need to enable this feature.
+ *		Returns 0 on success, -EERROR otherwise.
+ *
  * @recalc_accuracy: Recalculate the accuracy of this clock. The clock accuracy
  *		is expressed in ppb (parts per billion). The parent accuracy is
  *		an input parameter.
@@ -255,6 +278,8 @@ struct clk_ops {
 	int		(*set_rate_and_parent)(struct clk_hw *hw,
 				    unsigned long rate,
 				    unsigned long parent_rate, u8 index);
+	int		(*set_spread_spectrum)(struct clk_hw *hw,
+					       struct clk_spread_spectrum *clk_ss);
 	unsigned long	(*recalc_accuracy)(struct clk_hw *hw,
 					   unsigned long parent_accuracy);
 	int		(*get_phase)(struct clk_hw *hw);
@@ -1430,6 +1455,7 @@ void clk_hw_get_rate_range(struct clk_hw *hw, unsigned long *min_rate,
 			   unsigned long *max_rate);
 void clk_hw_set_rate_range(struct clk_hw *hw, unsigned long min_rate,
 			   unsigned long max_rate);
+int clk_hw_set_spread_spectrum(struct clk_hw *hw, struct clk_spread_spectrum *conf);
 
 static inline void __clk_hw_set_clk(struct clk_hw *dst, struct clk_hw *src)
 {

-- 
2.37.1


