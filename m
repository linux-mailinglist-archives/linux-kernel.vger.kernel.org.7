Return-Path: <linux-kernel+bounces-854907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F72BDFBA5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 931AE3E8D8C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A53833A035;
	Wed, 15 Oct 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CyJsefnV"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7281633A032;
	Wed, 15 Oct 2025 16:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546698; cv=fail; b=KyUQn82OngMCC6pSLm4tLp+ZpXWuQZON+4iY+43theGLKZvutiaNs90SIRq8BW+ljVdalGkvWawdd0UJIiIg9p1B4D7EJr3C2MbBKAYgIjTkBzpEi50AMbO5QWza+SACtweiWCCqqJr50nusCSrQ/h3qMxqwkfCizYrNJ9bUsbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546698; c=relaxed/simple;
	bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QD2cCc2OtwTDMlMt0ZS6iCssXZIRcsuDWSJMConW0hflGHnUa+5cu1unR4Sb7wEDs365nGTwZDxVZUc6Wfhf4TtDu0KltuNAB88iK8OVSmwwtMfvBJRKITWA7w/8b4+0TiGfoMONlrMiEHeOUuos4qkqE/CYo0LO8eeoqtkdyLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CyJsefnV; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4qG60k3bTePFikgFtlhehgqtMwkEsec5wN9mbvfkn761qoVXP78GbAP0Oykvag+O9SXeSUB0WLPhAtoEIJq5NEIKIkVt/ln2FGEIxTNaLZPfe8uGJBL7YduZt2lKSY5HSy9C73DIlqLSX2DxoV7HBu9Ms3hI3lum4HchUC+ALsojjfXHsMIsS3VHshGKt79gjMKQ63ixQ4UFbyScZE8VVCd1BNv+COM0v/ZO034mPxHpipDbeeUTYXgIKJEhcTpuC54AO37n688rpBxCfXvqeh+BuHIJxUQQBBL00nB/pboGBPScrtVPrZnsuzdPDZUrvgedqNfK+h8IdJS60d+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=dCWQhQJwl374vyUyKc2COZg+j8mRCV62Q75X+Q1k5iFL0EajeSqIeqniAVBlrjvaIHnCXzcr3ib/rx2m3Bu4cKTHLPFT6v8NBhqW60ZNdUEhktJm0USmltZffCpIsOIjRsb7G8d9wGW5e5sa7XursV3uEEyLUHOt+uP+P2LLizaoMaViTqJoaVbDtc2BhzDRDz+ZnK45gwBEzDRpo8tJgnEeXMlrxLdgFRT3BNmddSeArMywaArDwINt3TJW6/1W0al3l2o1G5f2YETaa15J83XS1K2wmEY6SgTcjKAOzm1dX+XfczfTj6TRZxH8MW3rrAqUyPRArDbd4I7gVImH6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=CyJsefnV4q30bfLuBo3rb7odOrwysuhyR+SvohJVdKq0kvdfoVqeKcpPLHwSB5zn8AjVRmPS9gWzM9naYbiI/RN0EJUlAODlqNXjaB7IKOIPS953PyVx6hD7PgAOEVqRPKID/xwmlwwbPzXW0Gm34F7Xl70EpF5RBdxnMlyYCSzsLC7v294oDIqiFm33q5FulOeZm409EwUooj8J5mCITNwcl6qdrK65/hvUuTSwRtgEmkHIbMiUKbFiVgXIVULA+DrlzUlegr8QRPWmNrBP5Gbu9LAdjBK0HKik+sMOEMD/mRxXprvv0YMApE5YQMagvwtjBEf0rUzeLfSLVrj1xA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:44:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:44:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:28 -0400
Subject: [PATCH v2 03/11] ARM: dts: imx6: rename m95m02 to eeprom
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-3-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=990;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
 b=3WPfEAe4SuIcp8Rx1vJ7n4SkGLB14D4FVbjv87mtedASqhkdLv1GY1qFM/fW0MZqwpCNcr5pc
 yfySJLFCQULCIjweZs1CPYxK9LXEOFYxpA/3KYwHdKWaEMz2lHMZ7II
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 9075c7c5-37c4-4dd9-faac-08de0c0a2aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cU0wUFhxZ2lEY05MQzc5bmx0UzQzY0EzaGtzRWhmaUYrTlg0S0hlSk1rbEJ6?=
 =?utf-8?B?UjJiZkFNSEJHVUNjS294Q2o3UXFsVmZXdFVPcHhpcGVlU0Jqd2pPVVMxbFhh?=
 =?utf-8?B?blgraXRobXJtSWtaN0QrT2p0cUhneU53WlZjV2hHS2tJaFlvRk54MHVOK0Nk?=
 =?utf-8?B?ZHdMTSsxVnNlODR2WXJGL09CeHdpK05DN29XUy95NW1ncGJQKys2cTlHYmZo?=
 =?utf-8?B?RU1NVHJNL2xmMDVvZVgwNmRaQWp4T1BzVTJxZ2JSRFhlcFRJbjU2Z3FCQkJK?=
 =?utf-8?B?OWhOdmxSMmNyajNOd3hUZmdzV28rTGlyOG1jQ0xNTlhidlVrUEJkNUlyS0JM?=
 =?utf-8?B?TVB0YzVrRThETWlUWHBub1lqYlpsZXNVMVcvOUxOQlhVQld6ZlBaT2ttZTNY?=
 =?utf-8?B?cStBMnl4NWtCTHdLTjlrSElhWEEwaXd4MStvTnlZbzE5ZzJmTHBaUHRxaHQ1?=
 =?utf-8?B?d2xDeTNpaVR0by9JRkN1SGZPaGhNM3BIcXZhNHBaWkJEbXl3RHBNd24ra2Ji?=
 =?utf-8?B?cStLYXpMTTlucVlNL1pXOC9MaFI5NThodllUTWQ5TCsvc2JlblJDYVdmbFpj?=
 =?utf-8?B?Yy84SmFjSWZreDJzZGRXUFBGVlNSY1FEeHRYNDlZL28raEJkOFFZWEVlY2c4?=
 =?utf-8?B?Zk9MOEpEbVlka2IyUmJ5SHY2MWFXMC9Qb1Bsbit6RjliSVp5SWJ4UUowSDBF?=
 =?utf-8?B?cyswRE5lQlM4dHdqdzVjYUlVWVBoSGpaS3FZZ0d4WnplaktMMkdHUGlTTGt2?=
 =?utf-8?B?MldRVlJjVW55WGRQai9rUGhLYVdXaldOOWprVmhZeHJXZjVVSzlic1hMWStT?=
 =?utf-8?B?OE5ibFdmSUFCbk1MT0lrRlQ1aTFsR21icnAvZTRlcEdtUlMxcUhhU3p0d3Fs?=
 =?utf-8?B?ekNRMWtPRU1XZFBQTTRESU5jQ1NDWis5RnRjQjBLSlpmVlVqQ2pxeERJUGVT?=
 =?utf-8?B?Q21tSC8xZ0lEQ00zQ0IyZ1UxbEdRaWZ6ZHVnTkx6UEd3a0c4aFR4NGxxUTdn?=
 =?utf-8?B?RlUwOVlMQ2NQNnYzcjZ3WGZIeEpkeHpldlhhOE42S0NnSWdpWlNrcWJQY29J?=
 =?utf-8?B?TGxNQ3FTMk5nNG5ib3ZCZFpSRlVhYXNkbGY3bGhlWm1Ud3FhSWFjRDhGOU1Z?=
 =?utf-8?B?Wld5MU1GV3FJVWwvVWFPT21tbEJLU3NEb2JWQ1RyU3BmeDJLMzVtQVZhM3JX?=
 =?utf-8?B?dktpZ0pMK1dxL1pHejRiQzh5RHVaRjJSQ0NnLzVBNS9Pei8vMzVldlFoUWk5?=
 =?utf-8?B?UFYzU0I5UXRqZFFTa2RrT29qZjlhTmRMZk5rM0xSWDJQNjYvV1lPdHNQM2hi?=
 =?utf-8?B?ZXRlcVRkTGYzWWhmQW5kVGNoNytEalNyRnlkaW5xQ2tFbElnVVRpRkJpOTdZ?=
 =?utf-8?B?bFpiVURDRHZ2Q0tMUXQrTS9kb3pPeEhxUiswTEpIWlBWeTh2OFVFKzFEVFVu?=
 =?utf-8?B?MzhHVmtYUmF3cDhhMnBic1lnVW1WVzZnYzF2L1A3NlhkeE1WZTRuR3BQb1JP?=
 =?utf-8?B?QjNpS1dRbkpDeXA0M0FsZEcrMFArcjhsbmZPSzhJUXhFV1MwYXo5UG5tYkFD?=
 =?utf-8?B?MjZoem5ZWWM0TjF1djIzUjdta3RPdnB0YTh0eGlxb2gyb1pIWUlZMHdsUzlI?=
 =?utf-8?B?R21vUWlqbGJDVThPZFR6anIrdWh0VTdJZ3Y0TWQySkZvZFZXQW1kdzdtTGtR?=
 =?utf-8?B?YkJGajFIM21BZ0V0dnVPQ2dNRjJsK1kycFRvVXVnNXAyNEt6VG1PUWR2TjZY?=
 =?utf-8?B?VkJpbXlhR0U3RW9vRjU4L09JN3RQQk8zOCtsMGxnQnRGQzFkN1hnT041T3I4?=
 =?utf-8?B?S3RpWDFVMjFYREhmdVpkM2JjbjlPeGw3eDRUQkM3Nkg3Q1dTYi90VVJlU2Rh?=
 =?utf-8?B?Q0l6ZzFQRkNwYUI4bmtFYWlsMWlQaEZQdWgwY2ZXV2pQOU5ud25DQWNxbUpV?=
 =?utf-8?B?Ymh3ZE1Jalk5V2dTU0tyTXJDM2ZyL1VQUmcyT2lEb1BFRHNjUkNqU1luNUwx?=
 =?utf-8?B?enNVd0xYTWRNc1JvaFdRWkJmT29xL1FCZ0Vvays2bTFvbzFDQXZKUmV1LzZW?=
 =?utf-8?Q?5i1nNN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1NhUGRtK095aEc1QzVlU2ZXeVgwMk0xc1M3ZTdzdlRndUJSMWxjZElWclJC?=
 =?utf-8?B?aUl3alcyMktxS0FzVUhsNHBjZ2J3RVVKVjNRWEk4SDhlZEgwNHc0eHhScEZJ?=
 =?utf-8?B?aXBNNmw4Qnl2Ym44ejFUaTcwZUREVXR2YVgxN3RXT0prSWwxbmF3bDhaSE12?=
 =?utf-8?B?SVk4S0ZpcDlacUxnQ0FRR3dEaTVZbXoxSU03NnJrNTAvWDFja2tOOUtEbWxy?=
 =?utf-8?B?K2tNblNlUXZJUXU3WHU2UWpkUE92NDRCeUhwVCt2MGlCUk1oeEFkR0lNNkF5?=
 =?utf-8?B?L0dkOE02TTgycldHOVY1MFd5WDBCc09LT2JIT2dIb2swQ1ZEcExLQ0VVbmlI?=
 =?utf-8?B?SUZESml1KzNXbGNqTVF2S3JON3NxWTVnZlpDUVVvclFTZXlKS1JVd01mUHFy?=
 =?utf-8?B?bW5xUzkvZUZpckRNaW9tOTRWK0NzRUxodDhqK3IzQ2dFMVp1SldLcjN3Nk5y?=
 =?utf-8?B?YVQvS0pkMGxBTnFzLzB6aTcxU0VhNnhSVU9vSlZ2QU1KcGVPZ05IeFQ2V0NB?=
 =?utf-8?B?M3F3UDRUNnNhZVJ3aUJ6ZlFmZ1NvRnlxOU9JeEVmMXRzNW5nWWE3aFRBSjhI?=
 =?utf-8?B?VGp2S3cvT3htQXpQVGczSE1yT3FMMklDdmVpWGdHWFBmNFBRbFZ3STA0M2wr?=
 =?utf-8?B?RnM4TUhqdzlreWRtaklMRHZ4YWRWS0hla3Ixa0x4MkM0SU14QW9SM3V4STlt?=
 =?utf-8?B?YVFTOEpuZWhjRmdCTGoremc4TyttY0pvWGIyU0xyK1BId1dqQ3gxOUVJNCtr?=
 =?utf-8?B?Y1prWDl1UjVNdE5PN2V2ellaUUUxY1lVdVVEMzNvQy8rN0NVb0NBcENsN0tR?=
 =?utf-8?B?NzRUTVZYSWZYMXBGMSs5MmdlYlpUbnhId0MwY3NBMFFFYVQ2K0dhRzFKV0VC?=
 =?utf-8?B?S0xDSVZNUG1QY3MzSjZ4OHp3eGtheDNWc1RCZmRqSGtSRm93bS9kTVd2TmV4?=
 =?utf-8?B?bTFTSGNqUys2VUpHR0R4NGN0NlMxSGFWYkpuYzN4RHRLbkZZMFVwc0dOcTJF?=
 =?utf-8?B?bnpJM1YwRWpiNS9xcmRwekN4c1QyanA4TSthcHBqSG8vUklIZHpXcndkbWx6?=
 =?utf-8?B?TzE2WlN3OFIwNXQ4OU02UmdoQ3cwcUNyZ0d5K3puS2dJZUhYTnFjcDNic0Vy?=
 =?utf-8?B?TDFoR1JmQ3FTbHZhcUprdm5neTFQVDJWVW9VaHkxbWZVSHovK3RFRG5ZTGtX?=
 =?utf-8?B?NG5OR1pWRUR5bXZNMFFhVXQwSUxHOXExYnl4dkdUYUUvYVM4cmZDd0hrSXha?=
 =?utf-8?B?WDBCUzJIRlE3bXl2bFpqNC9oaWFPL0h0MFFudU1sclpubGE2c3VIR2c2cUZs?=
 =?utf-8?B?dVlRbHNBdDJCTmlGTGtMSmZWL014eFZxVXFCVjJZc2Q5Z0lzb0tnOVN4RlV0?=
 =?utf-8?B?MHVrNmRGVnlXY2YzNStjZU41UzRyN3VGL04vSStnblpDaUp6WU0zVXlFNHhl?=
 =?utf-8?B?bFBEQ1FTMFJXOTJ1SWhiMGJJeFhJZjl4UzZ6K2VFYklWVjhqYThFTlp5aWdY?=
 =?utf-8?B?bktMRE9uV3Qyb0lpdWNkUi9hYmszRlJMbjIvMElaMFRIZDNwYit6S1gxaUpR?=
 =?utf-8?B?cE1udW1aSGl4VCtLZjdCMHhGc0c2ajVDSzRVSUlMdTJ3aTVrTHgyUGxRay9a?=
 =?utf-8?B?dVhwU0lxTnZpS0JkRXJhc1NRemVtRUxuT2hpcHZ5TEdUZllMWm5oYWhKRmk3?=
 =?utf-8?B?ZlRWSHgwZHVWdnIvRm5ja1B4clRxVHg2MGdFK1oxN3lQWm1INU5vaTFGMUNx?=
 =?utf-8?B?Sldxemw3dHdpR090UHovSG9SelhCL2IxQXI5OVdTL2ErcGwvN1pkMmFrL1JI?=
 =?utf-8?B?SUpHdmFweU9iWWtpZ0kvWWMyeHVqR1RDbktkQVQ5ejBBT1BoZ3lhKzlDK0sr?=
 =?utf-8?B?cTRBcERwUHNVRW1Ka3RWS1B0Ull1ejV5d2hPelA1RnZOK2J5MW1PeStFU2FS?=
 =?utf-8?B?WWVRVzZRVDN2bXRnTnQyZVdxZlJOU0poVi9hWWJjQjdnQVlGbnR1QjF5NkQ0?=
 =?utf-8?B?SWVidUlxTHhwamRueDlZNXdPczlIbmJNbkc5WWJjUFdSSkFHUWdZU29KMU9C?=
 =?utf-8?B?aXN6bURiSE9SaDNTVTJaNWV2N3ZudnVLUUJobXRCa1FRMWptWlVobC9BdkF4?=
 =?utf-8?Q?hdNYJwivwvNokW4qbJpj2f0dT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9075c7c5-37c4-4dd9-faac-08de0c0a2aaa
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:44:54.2498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5IbTjwQyvcEjHyFlCzZ0Jn1LK++5nCUbR4fx2VjqXzWAUerRfBMgBhQ5C3dxb44b1Ra4vRsvfrh4YUJ+hHcMCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

rename m95m02 to eeprom to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: m95m02@1 (st,m95m02): $nodename: 'anyOf' conditional failed, one must be fixed:
        'm95m02@1' does not match '^eeprom@[0-9a-f]{1,2}$'
        'm95m02@1' does not match '^fram@[0-9a-f]{1,2}$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..f1cfbe2ddcd37f6e7c8312eb7a3e384c82ff61c3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -124,7 +124,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5 &pinctrl_ecspi5cs>;
 	status = "okay";
 
-	eeprom: m95m02@1 {
+	eeprom: eeprom@1 {
 		compatible = "st,m95m02", "atmel,at25";
 		size = <262144>;
 		pagesize = <256>;

-- 
2.34.1


