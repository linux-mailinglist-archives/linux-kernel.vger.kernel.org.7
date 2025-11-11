Return-Path: <linux-kernel+bounces-896223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C153C4FE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0EB914E2465
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1077352FA4;
	Tue, 11 Nov 2025 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lofS9boz"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A535C1B0;
	Tue, 11 Nov 2025 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762897380; cv=fail; b=hMczaECBKDrM4oyDSCW86Alp/ueBaDwPjCTgCbP3OnciUhzw+pEy+/qwRSb54rNo6OGQKaM1MT3sJP6KyvH1V8FCXXzf6CzazFkA11qpUR24RfhdlCmnyrK+HTSUH15zP1nuo3Vp+hbx6eHr+gkSotGxMc91bZcWMdMDZUneWyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762897380; c=relaxed/simple;
	bh=EPx4lzmvmCsye4Te4aDiO3xOTYXdELRvhCxugrYXaNU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=OUeUhai6dQye5+XLgUGQaVAg1uaBms3/qHZbTDpkPYEo6Qbbk+MC19472dkw9UXyV1Yh5OQC0DUy/Nh/BLZBvHiZkMyZWZkNb0tJSfSfwILEnTGDRChhElQ3My+AV3lvbHXejvHUPoaIt58fxu2jQqx2mFSgEu1q70jvDTwRSNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lofS9boz; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0erOC0vblLsSGU60rJXdyyQORvZuA+TRzxD6o4A61pEntTlzuUzSjcqherAXxcfwuUNB0sTP7TSHZ+DHBM/nGXcfMJmDypoFGWuXF9x+uRKhYLhqcVnh2RkIUpljj8I/Dwo6vg/48ROhjWsrS3k/hWydM5xH1cTk1qZ81SrcMJ6zO0MTVUuht8AVWURyFHQkPCtdqeVzEDD6kVZdci0e3SAtXPdBlIt4NZE6yJpdjwjg1nebFeXV/I09WerNgTZWi4MwpGc//GUnKEtwKJrTEJ7UQfeIRKtIUF1PLNFgQfAAQHcGhkjyEzBHsgdF8dBWMczEXe2NzLOKZ8Fcq2tzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdzeSUnntxMRKssrfMEMSBkLMcm7aXbn8sbMuQKG9zE=;
 b=cCHhURonNGk0tSBFfFsh+il/XXdg+XfuNmqkZhGdPPg5sRfrC+Ne1nbtv9rsr6VKjfJOPIyQTpRkOK5T1fFie6rrXXUeTg/yQzsuMeUqUbZWxHV1MIYtXC45N9ha/Ohlg/nURPad1bcW+LCGo66uwjp3puVyFiVWvH62Leb+KTGIgC6mqD0VxOpthaj85SwyNi6EvxBLjBzq5DQjtZtLi47Jf2o1NISvu1/4Bkyx+nFq/xoZsGObG40pn34XsLXOrc7zLUMPWSX/HkcsahBm1h8VYIbsBFyqPokEvZhQOz+dE7FhswavPma78UxVIUcMwUqzNUuWl4PqSVbRnutR/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdzeSUnntxMRKssrfMEMSBkLMcm7aXbn8sbMuQKG9zE=;
 b=lofS9bozRxVUUqzpUoBruUaAKvOqKUjavuKFW+iNIbjrkd8Vwsfupi440EQRUVprQJA4dGmuXnn0kblERSpQ05mtAWVzpSVvosGnEofe+rO+FPNeg7HlpCL8jLhJ+m8dgNzCh+bcAnCENv2CPkGSlT1th+izNb51I0FhUceIGJ88dV64xK3CaQDgl/sDZlIpHnr3GeBZ0VFGPjmZXViTHz4cEnBIAIyPPCNjmz4lFBwjJjR89RKnbzVMkfpCyQn/Y6jTyfHECtlyaLlx5hjWZsP3lORoVmOfJma0oN0tSAqFw8zE2XvuX+0+BX0lpXYTgHzEKZ5oF2z+0Lu9DtaqTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 21:42:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 21:42:53 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 11 Nov 2025 16:42:17 -0500
Subject: [PATCH v2 5/5] media: staging: media: imx6-mipi-csi2: use
 devm_platform_ioremap_resource() simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-stage-csi2-cleanup-v2-5-371bb951776f@nxp.com>
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
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762897350; l=1642;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=EPx4lzmvmCsye4Te4aDiO3xOTYXdELRvhCxugrYXaNU=;
 b=MARZfhNkl+azb6QrEJ7x/bUTFqCDIzuiLYw5P7Q9xHfZA1oDdU7DiWyceZjyVvzv2p+ymHYN5
 cso8oYhgiTrCCuord6Jg5yblZiuk6brv+2aRS2y+kP6N9j2YEofhFO2
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
X-MS-Office365-Filtering-Correlation-Id: b445d30f-8126-4af8-bc59-08de216b44f2
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|52116014|7416014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UGplUWY3azVJakRJSmh3dzRLZ2c1MklXVDMxQzBLZTNUL1NwL0FkdmJjU0dn?=
 =?utf-8?B?RVRkOFVaWk5UTENaNkxYZ2VGQno3T24zSmlZVVdYYTBxRHprWDNrZEVoTU94?=
 =?utf-8?B?YU10SExkZk1RWTlXamdMYWl1TzM0WENrcVBvR0RzbzExd0UvckdHS3hldEdG?=
 =?utf-8?B?YVp5bSsxeDFCUHNVK1lEQmFLV2RaZmE2MnhpWFp2OFhYQVAvVURJNVNtbGNO?=
 =?utf-8?B?Nk80cHd0OXhIRzM1VVhWcHFmQlF6Wlp0TEhXa2dZY05LalN2ZWdpcVlvbTIv?=
 =?utf-8?B?d01pb1VFalVkTWxsK2hrZkFoNFV5N25xcnlyK2ZHWWV0UzR5SEFKbzhhME96?=
 =?utf-8?B?ZmxCU3BOa0pOMzNRNjZUMGQzK0d5S3RNMzB3ZnJEYktjdFp1dE1LK0pwTkNE?=
 =?utf-8?B?eFdqUkF4S2V0b2xyZ1UyWmMweVRNSGdZR3Z2eUpqb2RUNzVwV2VzY3NoVE5q?=
 =?utf-8?B?NUJpUUs0K25ianhPTGs1Ymsrd0dlcjloWUN0SnZqVmxZWUozUmJIOUNXMml0?=
 =?utf-8?B?Rk9QZHV6MnVnVzNYdlpCYkJEaTNCaklkVGorcWFYaTc5WCtNTjIydGkrSFBW?=
 =?utf-8?B?RXEvVm1UWkszN0luZzBNcWxEYXFCb3NLR05menRvem13N2dLN2FTZUVxNjQr?=
 =?utf-8?B?ZE9kV0FrR2hXdnhBS1FHeWxDa2RkSHcrTnJJM3kwWUZUMmFOOWxzNlJ5Vi9l?=
 =?utf-8?B?TVM2S3FrZDd3QUhnaGFZczNkSUNyeEFjSFNGNGw1MGxwWFVwVUdGbnpEMmVK?=
 =?utf-8?B?K2I2aTM0cklQRnVXdTZncE1lTHdYVU9VQ0k4bzFMWHVWWjE0OFpHVitPbjJh?=
 =?utf-8?B?UFU2a2pEbVBCRTQwcEE2ZGViWFhWdytDUEZ6Z2V6dlVLTUErZnhldDE4SXBw?=
 =?utf-8?B?elpKa29HbTJubEhyRWxMMUt0NGhJbUtIeWF0Y2JHcnVyU3RPUm83Uk1DYlll?=
 =?utf-8?B?dG80b3B4OGJnWGhQRzNCYUJONzZEYlJ4UlRsZmxkRG5lMlJtQzlGTGhRczlT?=
 =?utf-8?B?QVRzcGJhc05tdWw5QjlCdFozNUlqT1B0dzI2aW96K3FSQkwvWUh1a3I1Tk4z?=
 =?utf-8?B?ZlFrMnUvbzBLTE1Ncis3WWF3b0VxS3NneTNGeEtDZmhOSTlkbDRvVDUzRnZj?=
 =?utf-8?B?M2RiWjlkZ1dwUmFvRUV1VGJYSE9xSDVqbWt4SCtRQW9oUGtKV3pwZ2xGY1RW?=
 =?utf-8?B?bzJxdkE4b1dDVndqZlFlSWZ3bHRkalZxR29wRFNHeGFCRWw2eG44blZrK1Rw?=
 =?utf-8?B?aDZmbDV1cFdxaFJDWFpYTUJYSkNza09XRFdwVXFmdzJ6RExpQjE2UUZySHVt?=
 =?utf-8?B?OHQyL2ZNVEVkL0Mxd3I0WGVHMUF4M0plWjE5YmZ2SnVZRDFERytJWDlTbERy?=
 =?utf-8?B?Z0hHWDlSVVhaTFkrLzhabTNOQ2NVVHFvMmhlelV3ZFptT0d2SGlYVlJySEtG?=
 =?utf-8?B?WFZ5RmE5RUZUYmtUUUVwQXowSmJianB4bWovdWtPWEdtWnB0b3NtZDR2ZW5x?=
 =?utf-8?B?dm03SERxZ1pRazRZeHlZYU9SZXBRbnB5K1lwSkVHcEdHckhPbytpVWpHTUdG?=
 =?utf-8?B?bFdCZnYxdEd1K28zMXl0K0FGUnU0N2JYd3NpdzBjUTlYU2JVU1JIRDQwQUls?=
 =?utf-8?B?TEN5VUtuWml5YU1OMmVyc2xldHRjb2pZQ05MSGNXdlNSSFRvQ3N4Tjg2MjdO?=
 =?utf-8?B?anA1dWVMbktQVzRJazF2V3BsL2VvZ0RrYXBCd3dSVDNLaWR0cUZrdXZwbEdh?=
 =?utf-8?B?VnVtTkhmSW1FZ29JNVFQY0c5andnZ0tIb1EzK21GQjN5SjBRV3JraExSaWh1?=
 =?utf-8?B?SStqVit1bWtTS0RNTFh1K0tXbGwxNVRWS0JyYXEvMjBmcForRmJqTEVaVkll?=
 =?utf-8?B?UWdrNTRWQlJNTWc2YldxQVlwRS9XZHVzS2ttbUV4N3hZZGprWFMvRmhQK3JD?=
 =?utf-8?B?V2dabExHR0FibmZ0NGY2WGtmS2pMSWZUVk9OZ2srdkFXamZZZkE3T3NUYUhR?=
 =?utf-8?B?VWZ4WTQ0SllocnVVNGk5a1hweDc5Z2xwRSs0dUlNai94M0lObjJUWkFzWlVH?=
 =?utf-8?Q?DRNShA?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(7416014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NElvNzFHZkgzazhMalF6bWtUWlVUWEd6SGJRdGFNOURmcEs0Z1dQclM1Qm1U?=
 =?utf-8?B?b0FQME1SeFBuV2krbHRLV2kraUNPTGtTZUNTNFZUdDRIN3h2V0srY0hrNDhL?=
 =?utf-8?B?VkVRQmtsai9kc2xZcUZYVnByODJSb0x3Um5vVFgxclB1RXJpSEx4MnFIdStS?=
 =?utf-8?B?azNycHlOOERTVmQ5L1cyU01ORm1TVEh2YmZpMTZjZzlJcjVuN3FIQWNwajhY?=
 =?utf-8?B?emF3VExyYzBEcS9qRXhFYXFFeE0wMU5YcFJMVktSbW5lMzNWam1qclY2M3Ax?=
 =?utf-8?B?ZytwWk04ditBTUJVaXA2cHczZ0Y5d1R3bi9BYWNYQmRuSG9WWXZRY2x3eFJs?=
 =?utf-8?B?dEZQR1ZGelFIMyswODN2UDVoc1BhejFtK3pQaGNGTHV5Y0M0amhjeGozMHZW?=
 =?utf-8?B?andEVDZoZi9Mek55bGhudGFkbllqckM4UWZNMkZuWFhYT3FRWHRjd242L3I3?=
 =?utf-8?B?RUh4SVpnTlYzSU1tdGQ2QUl5cEt6WGt3QnVMU0ErbWJreXByc1I2alorR2Ni?=
 =?utf-8?B?V1RsZHl4QjAvODZVUmJUTjBmVFdlTU1sZFpGd1hGakVRYmZDYldXOEpPRVRu?=
 =?utf-8?B?dmdudC9WVUlJY1kyWG1yMjl1ZjhobnoyeHF3VDhmVUt3clBEZS8zQlRXWnda?=
 =?utf-8?B?UHVsQUJlaFZlYTBTcFdiOWQvNWFSakhaMGNtQ3RBdzZYVkh4MFNobm9RejQ5?=
 =?utf-8?B?cENmeHlYQmlDN0pXRndmaGFLMUFreXV5dWVXVDRGcmwxZUYzQmpVN1M0TGtU?=
 =?utf-8?B?SnROc3dqVndJYmYzc0JJQTdxZ0s2SkdPV08wSXBCaEE2UnNyOVZjUGw5clJs?=
 =?utf-8?B?bG9NcDRaZlY3ZTBES0FaVEh3S2tzVVBQMTVUaWYzQ0JTT0o4dUNHbWxtRGNz?=
 =?utf-8?B?MDZXSStXZmJTNzVLbERvWGowWlpJMitkVVNGbW5SWWtBUUNCc1dWRUJuVXRT?=
 =?utf-8?B?U3l4OHlwa3dRQXJ4bXQ0U1QvcXVGQ2pmNmRPVnNadlJpUEpQTlFtZkVVVDJy?=
 =?utf-8?B?em84dTl3REZhMGV6RE9lazI3K1JqM0FZRndwRVhXSWFGMmtQb2RPVDg3M2VB?=
 =?utf-8?B?eTdTZitDMy9jN3I4UHoya0pBc04zdlhCcTVVSkI5bUE4UnNkQktOdU0rTnBn?=
 =?utf-8?B?Z0NmVnB1R3lnOHFqdHQ1Yjg1eHJGamZzK1R6aHQ5T1RzT3BCbVJKdUZ3STNG?=
 =?utf-8?B?dUh6TUpWWXJQNXgxSHZ1VEZRVk1wUzRKRG5uR2huOTZWYTBaamcrY0o2dFZz?=
 =?utf-8?B?MFNqcmJrWFpNam1jeW01NC93Wk9yS1o4b3pBMFRhK1QwemNqeUduTS9oOUh4?=
 =?utf-8?B?amNOZjRLTStYeFRwYWxiTURVREJmU0lHSlI5WEVUQlNtS2xxRTdTRXB6Q3Y0?=
 =?utf-8?B?bUdiUjZHN0RURXp1QXhKM2FjdkRqVElFTmpSakp3YUJFWGR3RlpabkRWcTYv?=
 =?utf-8?B?VzRYYlFMdmwyWGpuRnBYZ3VrWlZTWnIvUVVzNlZTaGhuNWdpdzlxSGxLcVVQ?=
 =?utf-8?B?eVFsRnR4UzRiZnUxR3I3UVRIZVFreXRHZk81QlhDdnp4RHFvY1BTMlpiZ08r?=
 =?utf-8?B?Wk9WeEovaUY2cUFXUUZDRTNJR2RiLzBJQWoweFFqdThDVEd5Q2Jpd2daTVU2?=
 =?utf-8?B?MStaOUQ0UGhzV3NOK0VnYjYrY1llMHdBd0F0MUNhSGNwdmlScXJ5dW1MM0ow?=
 =?utf-8?B?M0NsQUhrVXg1RDI3Z1h4cDJ0UEhkYkNRWjNHRnVGY2dSQkMxTnNqNjFTamVw?=
 =?utf-8?B?cjRnUmc3T0xZcTV2ZFdhd3lvNStTK3JmRVZBeTE4aFRxZTV6Mnp0aUhSOTFn?=
 =?utf-8?B?bVl0aFpLb0drTjBER0grbGpXWWNKZGRLQ0JZRzhEV1lTZm9mUi9EekpUMWxn?=
 =?utf-8?B?aGkvSS9ycUx5bENlVXZrU1Q3aUhpcmNjY0wycTRCQTEvbmtQaEYzWkl3NDRQ?=
 =?utf-8?B?R2RxZGdGRXdXVWIreHQ0SGJIS0xYdy8wV1JBaGtPbWRuV05hM01McVY0T0o5?=
 =?utf-8?B?eTZGY0FKcXFqN0YzaXdRZnoxdlpuOWVFcGNkRnFNdG44VUorOWNGSHVWeXhD?=
 =?utf-8?B?RVZXY1ZNZWVkeXUzOGVsV0RjZnh4K0xUYWZQL1JpZSt2QjNKM3EzWEJZY2tG?=
 =?utf-8?Q?K/irDBe5UC4rxuAsE9yrOSvvr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b445d30f-8126-4af8-bc59-08de216b44f2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 21:42:53.7495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lgu0CRI6Mg16YWfAwNJDsP98w3Vds025Lshm2VugFTw2fEVcqCH1C8Fsnq8oVyW8zHCX15I3XmC+x95if9hOgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

Use devm_platform_ioremap_resource() simplify code. No functional change.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4 (reset verson v2 because split to small serise)
- add Laurent Pinchart's review tags
- return PTR_ERR(csi2->base) directly.
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 762f19ffd0858c952027afa8e0f36fc87246e1ea..3d8995dcc9132c1b92c36a65e55476e3ca2703ac 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -709,7 +709,6 @@ static int csi2_async_register(struct csi2_dev *csi2)
 static int csi2_probe(struct platform_device *pdev)
 {
 	struct csi2_dev *csi2;
-	struct resource *res;
 	int i, ret;
 
 	csi2 = devm_kzalloc(&pdev->dev, sizeof(*csi2), GFP_KERNEL);
@@ -739,15 +738,9 @@ static int csi2_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		v4l2_err(&csi2->sd, "failed to get platform resources\n");
-		return -ENODEV;
-	}
-
-	csi2->base = devm_ioremap(&pdev->dev, res->start, PAGE_SIZE);
-	if (!csi2->base)
-		return -ENOMEM;
+	csi2->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(csi2->base))
+		return PTR_ERR(csi2->base);
 
 	ret = devm_mutex_init(&pdev->dev, &csi2->lock);
 	if (ret)

-- 
2.34.1


