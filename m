Return-Path: <linux-kernel+bounces-824086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445FB88163
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E46D3B39A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4292C2ACE;
	Fri, 19 Sep 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bLKJkWXz"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012064.outbound.protection.outlook.com [52.101.66.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A1028725E;
	Fri, 19 Sep 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758265400; cv=fail; b=DWU5PezPWrYMJKuHtZVZdDwMnlci7dx+ju8GRKgIMFkgEwnzdtCWL+tYV+5qXLK5r6faDpTb1KulZjg4ihwWX5VTBRP4I6rZ44kMcY/UXnSPWuzvoA9S4J0x1zHFnCr/zpQKzuvjy3F9TSQEVa8Q9XyKgVThozU21NRFU3nifYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758265400; c=relaxed/simple;
	bh=w1wc+EgSAdWKny6zS/ABLdk4N9zC1DRyzMfc2WN/uqw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MxFHlH418QKVSC7GPapSvONKulu7lPjXrNyyMwT+UR7yFeENZ/AIees0FeaM1hkmVP2vMsfhcsBjvP+tzGB+3cdJOPXbHguW6DtBr96VMX9BToMpiS7wruCrwLmW/6jkOqoPydyGn8v6GNbbj7UWR9vDWqzr6kFp/+9gSF8ZIyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bLKJkWXz; arc=fail smtp.client-ip=52.101.66.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMJ9gaLeFZhvvrWZi39AzYdTwZ5Q2PgNqbVGsiVgtfcw2Sx90M/Qro/6XCy0f1N4L7bm0ra3L8TjgMh4BGHO09Ihwz8WOdmTgOjsI1Aipi8J7PNmZ7lE10ChQCHJCtosQvX7t793CGqpLCj0XC0g+5tuDaCvY2WQ/LpeixUd6cuvRVgJRM6AbOnyj6tuKvhK+apU03v00WkiAe10fEEjfi71aSAc/jy16HnRs72nSEr4sfekvI+aKjmQB6JHrO8sGQtSfgpVBpb5GGsAfqLPb+KcmW/0qzANtN+IjAWN1UVdY0w80PKtxxvS2Gj5mjyb+qiEOlD72ZE6Zu+CUPzZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ez+iDA/jtMyIzHUaG6I1Aqs8ezjl8gu97m+rsxJOG9Y=;
 b=s3pI5IoTe91T8B6yl/x+sgnceVVvSvL38r47Jiwp/kvHURDx1Dj0Cw7INLBR19yzjvcan03tTnx2Y1ijDNuE7xad1IwSmypP8Y3HX+j9wk5dggQrxxcaL7dHWQYtg6gObL6ig8Nl03Xx5MGNErRFmHT2SFg24Ohg9uROA+bAOmIeTM783+LNXmtnnSmoFgkZ4FjDAzQB8Me3gt0QJ84FfzgustoV2hi4kloZtQG4YXI66DQh2lpiJdas7jcSvrh9L7NnUNotbX9yRz5Iw+KCYOBCKTnUw2+IDfk8J/NebcS6wdohtlvb1HTwD/6fHlEvEcyJM/tn87lRDzjQ9C0+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ez+iDA/jtMyIzHUaG6I1Aqs8ezjl8gu97m+rsxJOG9Y=;
 b=bLKJkWXzNfbbIrWo68kUUSWgMx6PwuLKo+wqisHMzF2ySLKha6Hfk5VZUIyltrTCD4svHVzFWb4Z8ibvu5j2IQ8FjReW93Ue7eRMtJraH9nCnaIYpC8nGQH4S4uvaoVAX7NcFwD5c0542fbOpB6mvX7NqBzVzpxFxCKQlycKYMH/2YLD2Btu5JpW9MPz8+7pLzO3cuKdh/YtEaSTN9Dwt0mkB7qaJO+uc8LReHDldtEZXcRspIVf+dzr3aNDjkXUKGyg++k3qOtZHCZ06fKXFtQkjq7x9IFBnfzgay0vo9woY/LA5gLCe9ZB5DTXRSDbP+J3xYBxyTECDSH8MQRWog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV4PR04MB11452.eurprd04.prod.outlook.com (2603:10a6:150:298::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 07:03:15 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:03:15 +0000
From: Xu Yang <xu.yang_2@nxp.com>
Date: Fri, 19 Sep 2025 15:02:58 +0800
Subject: [PATCH 2/4] dt-bindings: clock: nxp,imx95-blk-ctl: add support for
 USB in HSIO Block Control
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-usb-phy-alt-clk-support-v1-2-57c2a13eea1c@nxp.com>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>, 
 Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Xu Yang <xu.yang_2@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758265397; l=936;
 i=xu.yang_2@nxp.com; s=20250815; h=from:subject:message-id;
 bh=w1wc+EgSAdWKny6zS/ABLdk4N9zC1DRyzMfc2WN/uqw=;
 b=7oTWx+6w8RYEPAK+3VfJ5NfD5PSuG6mZxt1FOoR0Atj9Nk89LeqxvhvnaTjiedN0KGlmBx9uF
 m7eGzNmJpIgCNoRbMvsmq8nOa0O+tRO+nR3vCb/y7iKoAp4fTd7wXrG
X-Developer-Key: i=xu.yang_2@nxp.com; a=ed25519;
 pk=5c2HwftfKxFlMJboUe40+xawMtfnp5F8iEiv5CiKS+4=
X-ClientProxiedBy: SG2PR01CA0146.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::26) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV4PR04MB11452:EE_
X-MS-Office365-Filtering-Correlation-Id: b55bb501-448e-40cf-dc84-08ddf74a9ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|19092799006|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TjAwdjlrUHgxV3REaXZtelNDWlFXK3hwMW9LVnV0UERoVHcvalpwcTJTdGdR?=
 =?utf-8?B?OTh1YzkzYzc1ZWFZc3dKRVNrYXBIeXE3Tmo1QU1Ed2YvYU1ZeEQrSDhKKzlD?=
 =?utf-8?B?UWNkUGFtaWkyWmFiZHhSMDlLbVNMMGNPNlJqWW5YUHNOY0xwWjExZ3VSZW1u?=
 =?utf-8?B?OUdZZEZpaW1XbDdzTmxzMGN3d0RucWZWanhhV2JuVUowL3ZrS0NlZVRRemsv?=
 =?utf-8?B?ajREcS9pbHhzVWNPbTlVbVpabFg4ZEVNWGJRU2gydjFKRjhWUEdjczQxbThn?=
 =?utf-8?B?NVpYVnN2bkZxKzgvTSt3bXpaSVZwVkFOQlFGSWF0SEZ4ekRVWnVrU1ZZOXRp?=
 =?utf-8?B?NlVGbWZJOWtOVGV0RVZkd3hLaHZKSnVpUDdSTUs5c0FSdGM4aEhaaVRDU0x3?=
 =?utf-8?B?SkZjOGU5dXpNdm9NMlNiakRMaGxtcER1ekZ2bUZ3TE5kV3dPWmlOYmVEbW1p?=
 =?utf-8?B?WmtaYzFQT3lOS00rclhHWGxuMVdxNlFSMk9yZEdXb29BanhCQmtTcCtOelFJ?=
 =?utf-8?B?TXdOL1FMS1NqS0dkbE5URktDOWdLM3BSZ1kvNEFwRm52VFQwS0pQQXdIL05k?=
 =?utf-8?B?ci9mR1ZPRGdidjVxWlUwTitDR04vTUMwZENvMXhaMXpzSHRPZHdOazF0QXpa?=
 =?utf-8?B?VmJtTTlwV21BZXNyRmR1dktpQWJWUGNjVEV6YWR0Z0VrVDcwZDd5b2QzdFVy?=
 =?utf-8?B?YkFINk5zMklQYUd1WU9zY2xacU1qZ1NxbEhLNnRZakx6ZWdZbFltbFhRZVQ5?=
 =?utf-8?B?bEFJREF2RVdUTHRmc2EvWXJRWGs0STV3cFpWZjN3a0dmVnBzU1M5OXVjVC9P?=
 =?utf-8?B?NVJnTGpQVGhVNDNIQTg3T3F4bHhhc25ocmJ2OUpEQllHYUVTZWtZT0orWjFV?=
 =?utf-8?B?OEpOb3AwaGhVK2pCUktiUFFVMWM0NjNqSU1yckNQcGlDSlozc0t2ZGpVKzN5?=
 =?utf-8?B?T1JPZkhHbm1oNjdpUk5NMVBQZExsakJuMzdZcEFQNXN6Z0dyVUFMbEE5SzUz?=
 =?utf-8?B?ZWZ4UHVoMFhmdjFjUG9jV2tmUXlwNy9LQW1OckxZSEVwSGYyS0FleUZZRUR2?=
 =?utf-8?B?ZFJiVzFmc1V0djI2TVFxdkRDQVMyWFNHcW5URnlNK2RKYld6aXlwWGRGMkQ3?=
 =?utf-8?B?SHY0R1M3azEwZG1lYlEvWXlXUmVubVQyQThhdncwdjVlYlBJSzR0SnhyNmhX?=
 =?utf-8?B?TGpLNE1ocVNDbDh0YzlHUWlWZnk2Rk9DK2tCNW5mR2lLUmJnZ1JhOUQ4MFkx?=
 =?utf-8?B?MVAvNG9LZ1ZmK1cwaEExdUFOMk5oeGUybkd3REVOVkU1M3B6cDMrYWp1cEoz?=
 =?utf-8?B?YUZqOW05MEhXY0JoMzZVOXZrRUh1alFXWllDYzRKYzFYUlBzRlR6dHBzMDZI?=
 =?utf-8?B?ZjZ4RXdKZng3OUJIRjkwSmFndXJWZU9nNlNMbDlYdmVIejRYMlBaaG5DYStu?=
 =?utf-8?B?NHdSY2VlNW9IS0F2ZHZxUzlGMklzU3UySFBUdk1Ld2FSYzFvdHI1bWYvVk9q?=
 =?utf-8?B?UkY3SHRDWlRGNFBMQXpIenBPeGRVYUc1RXRVc2VZK1pZeEk1cXBEdEtNV29I?=
 =?utf-8?B?UkFGVStzUURwN0VLdHhzQVJkVmljRHo3T3I4UVpLZnpOVXB2dllQT01ieEJL?=
 =?utf-8?B?UmlubktLL0FYbDIrRXZaNlEzRWhyTUNaSGs5ZHN2cmpSNXB1elFQTm9GbUVU?=
 =?utf-8?B?SEwvZnFTc2R5cDJVQWlIcEtnS2Y2S09PNUUza2NHUWNIK2R3VktmaDlYUUFF?=
 =?utf-8?B?NW5mWDJ2VUhnQi9HZXhPSytoSXR3VXZFVEg0cXdQTVAzZGYxdUM1R010REQ5?=
 =?utf-8?B?OGNVeWgzRXBZdFBkZWtJbDcvdXhXVmkvM1pVN29temd0ckw3RS8vcVR1VFFO?=
 =?utf-8?B?TlhFWi9yMFFsc0ZGMmViT1hWWjZQQ1pNMElBV0tXVVB1a1ZlaG9hMTVrVEFo?=
 =?utf-8?B?K0dkcXE3T29UZTBnVzludjdEN0VZa0s4OHZxSnROVU9BOW5vY3JUWUJQUDFI?=
 =?utf-8?Q?kLPY8IidCUeZ//lWdif+dFQdlDXxRg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(19092799006)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZwVnVPYXh2R1FyenMvK09jSW9ndkZqeUYxUXFTK28zbzNCUDk1LytoMnFY?=
 =?utf-8?B?VitQVE5tNlhNQ1dWWXdPWUo5Mno0d2FOMUcwREZBSWNxaUhMMkhrOHBrVlBD?=
 =?utf-8?B?bXJaRldtcktGaENsdVpkVXJRK3NJMW44ZnJTTFFqMXpydE9HanF6azkxdDNT?=
 =?utf-8?B?TWF4M1FBZFNVa0lQcUgxV1dZYkRXTktaTUFsYVpSTVFTYWZzcktmaXBuOFpJ?=
 =?utf-8?B?SGFGVll1YkpaMTlIRTFlemtvMUwzYXpodWpIRUFwTmVVaTE0blg3Qm95K2E5?=
 =?utf-8?B?cDFRNVEvY0N4RFlkNFl6UEtKaHBzZ2J1VzFJWnJIYmpEN2o0elpPWWQ2dXlP?=
 =?utf-8?B?TEVkTVd3QTc0SWVFRnE1VEZxUmJ4RXVzRTlQdFJmSFZJdkxqOTljZkEzSGhi?=
 =?utf-8?B?ZGxlUXBvMHF1QmltWUxYVElmRVBUdG9hWmF6cHdzZGFtbnFKZ0xQTFZjTVVN?=
 =?utf-8?B?ZFR6c2Z6UHZMREYyT0tQZHRxTHFFQ04xQXNtMnlZYkFNUEFKZXR1OGduemdS?=
 =?utf-8?B?VjFDLzFoTFMrSUwzcjlGcFZJUElnYW56YkczSm1CY016a0FBNjdTb3NmK0RR?=
 =?utf-8?B?U0pPaGhVYk1pR1hlNnlNN3M4ZmJNVzNqQ2NyZGZEYlBibjdkZjhUWEd5ZHlM?=
 =?utf-8?B?dUJ2S0FHOTZjZ2JxK1RMQkUwVCtHd1NEVEtJOVFZZ1ZZR2VqY0V4U29wekY5?=
 =?utf-8?B?SUJJenJJQllNeTY3S0hJY0d2TmI3cDJCUHRrNVZUTElNSVpqVTBaVHI1TFBF?=
 =?utf-8?B?THVQVEpLOVh3VU9OR0RTemNRU3VnSFJoWFJobzhnOXVSZ2VrS0xoM0FOMFJ2?=
 =?utf-8?B?MzBDTzU0d2ZSZkJISTBYWTVHOWwzeGhvQnNieFN3YkJhUllRM2Vsdndxa3Ra?=
 =?utf-8?B?anU2ZXpIelYzeWhoRFhZWC8wMGQvdWlSOC9lTkUvYTZIbTN4bzlmdmdCbEdV?=
 =?utf-8?B?TUNmeHFmTE1wVDZDR1BEY3pGNEc2cU8yVElGVEFSSUZEai9nZ0FLMmhubFov?=
 =?utf-8?B?Uy81R2Z4R2pMK1NrYVlMeGJoTDZHN2hnQkcvS3RJS3gzbUduZ1NhYzdpNm9v?=
 =?utf-8?B?OGJEVGNLQ3FpWE11ZkFYWkV1Q2lsWXppcnpCRXBManc3UVZwb0t6QU5BZU1U?=
 =?utf-8?B?RnJ0Y1pIckVHR1lBWXBuM094RDEwcjRmQ292L2xpNkJoUGhYeE51Ym94Mmlx?=
 =?utf-8?B?a0Q1UFlrRnI1N2tEVUpuWFNhajR5ZXE3MGhmdHpGT1R2TEorTC8wNStDYnl3?=
 =?utf-8?B?UHJoem5PVzRXTDBHeUJYRGF6cDNCVmtRYkFqRjB6V3krZXZsUmRhVXNlWThE?=
 =?utf-8?B?QXN2bXNNT2N1VHMxVm1Tdmlxc3dneHgwMW5IK1JKWEtYK3dWdHRxTC8rbGJS?=
 =?utf-8?B?ZncyUFBQK3VSaFJMN0VnczAwc1haY25vL0hiQXYrVW8wTG12YkFOTSt2TEhW?=
 =?utf-8?B?ZkJ4OGIxRFM5Wmp2Nmx4TVlubm5WQlJEbVl6MW4rdVdmcW5WZWJZWW1hRC9u?=
 =?utf-8?B?NThGRitpTHg1SU1VSVhaWitmNmtybjA1MFBnTzM1anJJaTFUdTQyVW5BUGs5?=
 =?utf-8?B?bVgxZ1gvbzRuS3VBaWVWYXo0clgxQkJCQUQ2WTBVT0NpT1hVOEEzNDgzbmlZ?=
 =?utf-8?B?cVZ0a0hiTkVteGdyWGZiTFBPclBuK1BtNUcza2ZlQmdHZmZsSXZwcTUvVUhD?=
 =?utf-8?B?d1duaWJCL05BbHNCTVY2SDdFTFNPSjd6a1JFdDZ3ZUYvQUpZQzREbWVWTDJR?=
 =?utf-8?B?dW9DZy9KeHVwaUw0RnJkL2RNYnNNampQUWNZWWtzT2tyWmUxMGdSQUQwdURi?=
 =?utf-8?B?R25pd3hlekNFdXlYck5IZXVyVlJGYVY0RzJaWWloMlA5ZU13eGc4eHhCOEdU?=
 =?utf-8?B?TzBDOGF0V015WVN2V3hxcUZYMnJXN3F1VDZIZi9YWEhzcFdaYzIxR3JqdDBJ?=
 =?utf-8?B?eGN0cE1QdlJnd0R4SHp5Ymw3cU9haytpMUNJRzY3dEtTbnBWS0Q4RXpjNVlT?=
 =?utf-8?B?UytnVGJKZnZkZm1QSU5BOHBJdlFHZXZxT0N4YTRXWHdlVkNEKzB3VnFEd3Vu?=
 =?utf-8?B?eTJQU01qN3Z3a28zbjkrekdXYXJsRVVsV1NvNURUanhBUUEwczRZR2lGT1NL?=
 =?utf-8?Q?UkFJtuBrCRjEWA4x6O3WjVYSw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55bb501-448e-40cf-dc84-08ddf74a9ad9
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:03:15.5397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dF+9XBDU5xL/fuFO+b2CXZ+J4gnnYopbsuVw9tvXxwVb9ge0olQ8SQosnamsizb7vV768eX1tDhxEvjpahQJvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11452

Add compatible string "nxp,imx95-hsio-usb-blk-ctl" to support USB
setting in HSIO Block Control.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 27403b4c52d6219d31649d75539af93edae0f17d..aa452fb438a9cd5b9a8ad3eff6249abffe576a01 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -18,6 +18,7 @@ properties:
           - nxp,imx95-camera-csr
           - nxp,imx95-display-csr
           - nxp,imx95-hsio-blk-ctl
+          - nxp,imx95-hsio-usb-blk-ctl
           - nxp,imx95-lvds-csr
           - nxp,imx95-netcmix-blk-ctrl
           - nxp,imx95-vpu-csr

-- 
2.34.1


