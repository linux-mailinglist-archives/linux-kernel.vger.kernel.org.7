Return-Path: <linux-kernel+bounces-836384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E56BA98AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18FE3A7997
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4558C30B536;
	Mon, 29 Sep 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WzmPzQza"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425C8309DD2;
	Mon, 29 Sep 2025 14:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155885; cv=fail; b=HHI45DclbD4o7pZyfdlzqeD5QjkIgA9GkphdlLmNDLHiZh3xrFSUP/JTBFfjoBlHjwL2IVHOF4nOA55R8LPjs3WrtNRi2W8hnCMxBZniKTtPquGKOHtGQgnwCr5n38R0cuOPCjJZVf1FsKYZ0y/2OAEI+R0pTF1Qb4KV8x1ws5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155885; c=relaxed/simple;
	bh=aIHEblPEUU9onRAuFOQAmpLaupn73nS3Bk9VVkwWnYI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=JdAlbuwa2W2Phqpjp3ueDdjx4+eZz0UybZiP+BA35/HlBxB8GE7VOEzlH8XC5F0XsV4sNQ3mSvh7hbyWctFKqEZ1lth8Mtzc2rmOJ4EO2sbyY39ECrKxWueVad8iG+1yRLGmeF3hZPITcQuy2j9E8YNWLVcEAH1rRGuOuxUSjCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WzmPzQza; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MJpWGqJ+XzDVs3DkL4pr04DGO7jCBa9w64siTcSV1S7BtDZQMFStAf+S1PUfNdoZJYXOnILs4lGgJFB6h/KQ10u7epYg8bNW/SVJlrEFAfp/jMbEokga0Tk1jM63vuF7/Bpt5Qv8dTrKOd94PkVabNb8OZPN2ytpdJkz9csHazUul9g0kRTTAvlE5UL9Sf+xGXzjP0I0HuKLm/w56HAQJ0ftGLUxgccMK+xB+tLowIwrAatlx2Yw5IeWV7IKOztd5rqvzSxgx3hXktPsuETxmOD8gM02rDRzz+aL9N9KfQjJI1Ss5QJ3/WYbQPQQJY9k0Q5l0/eUghX3biB0oTMPvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXkawFsYT8gwsJeq7MevcIWVbx1NMYayzdoiUHA1JZM=;
 b=XZ4arO9I8WqEuw+KMiVtnJ4PeloDl+d05jj5Ke9caVFHHi/aIjEPWwLS9KxBEK8Q7FHzt4OS8qD+pV2OT+2IPCfs1NllvK2XBIMXuQuEsPtel6wvPEq/cEzx7fa2VGbiv3foaB9Q4+QG33uIUebqEbEA2U/wAITUjWUqsEdZ1J3exN3mWLHi+W+9Fiy00kaMoTz4GbX1Z20xupgEWJ3d40yjduuyzCda7pYADShvyPPMN0WwFpLKvKZnsYIkCXak2XLJE5t00fXcaXBlfNGP7fM0I6l3fTHVIrCGVTOqeYwGD7CAJt+vC3YECInnL/O3/+n+gLFkBF3us+2lstBaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXkawFsYT8gwsJeq7MevcIWVbx1NMYayzdoiUHA1JZM=;
 b=WzmPzQza//Vn3qFem5Sv0p+goQKt7nRHSI5fZs81GOlYUzWGW2e3DLP1Fvc3z8/8YoBlmWZ0hUHfHwiu90Wql3QbsgVgzY28dpfQRYxtCp5Cn6sImZPAx5Kt9dXWl5268qTHiKnuAU6PVZ33UImvUuNUpHm+2aEIXHeVx29hn/cIRpueZTD46AipdiUqLNGlezV5eTXYMS7TcRCMFJBfZimuBRQudX3NY9hyH8dA/7qKzFAQbRnadfouzJxDQJkRZthdtLPxNjgNqJmngEHXCuoL2+uNL1BCX1RphBc7QFHfYHj4MYL5groK/clFBX5yPKT/+ZdKpbeiOe2/rcEksg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by PAXPR04MB8607.eurprd04.prod.outlook.com (2603:10a6:102:21a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 14:24:40 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.014; Mon, 29 Sep 2025
 14:24:40 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 29 Sep 2025 10:24:16 -0400
Subject: [PATCH v5 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-ls_dma_coherence-v5-3-2ebee578eb7e@nxp.com>
References: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
In-Reply-To: <20250929-ls_dma_coherence-v5-0-2ebee578eb7e@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 bjorn.andersson@oss.qualcomm.com, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>, Ze Huang <huang.ze@linux.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155863; l=2066;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=aIHEblPEUU9onRAuFOQAmpLaupn73nS3Bk9VVkwWnYI=;
 b=4Omq6QH/aCEMLLx/5hTfiUQg0yNZxzbqWUdyUs6ER++V/YE1Kvg3vnrC/GWRm/hs0vm86u+wp
 /XZXfkMiDStASeX2351YBb3sH54sNpIHlRgdi8wRDAUDAuM7pvnW1/0
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0099.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|PAXPR04MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c1d688-fe5e-4ed1-7b2a-08ddff63ed10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHlPUFpGMDI0UlBYWmwzTmZlWXBCdnNGQVFkaXUvbDg1NXRqRVBrRnhKVy9R?=
 =?utf-8?B?cU5XWWtCWFZ4R3RpMDl5UHZZcy8xSW1Cak1iV1dOMTN4dndTNkxOTklwd0pK?=
 =?utf-8?B?UHBQRHcwbncrWDhCNy9YeHkwTllsb1o4R2ljWmVsdFp1NkZpaHl3eEtiUFhE?=
 =?utf-8?B?cVBXUGZwek9ya0VyclJBMEo5ZVpiTVk4NnVvMWRaSEgyaGxnOW9ZSVNXRjF5?=
 =?utf-8?B?QXhVcE5UWDRSM1pGL2lvVkcvNW54bTBzdW5xVDRpMmhqZzJ3UlNiSVpLMUNM?=
 =?utf-8?B?K0tZMVdvbUNKaXFYSGRPbmpHRE1IWlRNbFduUkY0QUNyM2ZBVWI4bk5KemlB?=
 =?utf-8?B?OWNtM0c1SmNzU1BDODczeVV3c1FvcC9xbWs4bnRyOXZwSXhOUWRBV2lOSTdP?=
 =?utf-8?B?dlAwSjZtV0t2Sm9mREdBWDR3RDVSdlhPUEw4bzJ6MXlTMFRFaUhwVFNGazFr?=
 =?utf-8?B?S1BWd0RoOGtiYWNBOWdzbE9yckFobk8zdWo4WXFJMS9NSWdET3FvQlp3RjBy?=
 =?utf-8?B?Y0tzOXdERU5vY2gxRHpQVUZhK0FCbEtyaER0NnVkTGJwSWlhcExnZnVTLy84?=
 =?utf-8?B?TmRIemhMTXhhcGQwQm56a1dVNytrUEVPVmk0ZGlpUEUwYmluenRQSkJzM2o3?=
 =?utf-8?B?N0d2T2FVb0YxM1pNNXhxam5kbWVDSlZiR1JpNW5oT0VMWFRodUpXNXlIUFZP?=
 =?utf-8?B?eWF0a0YwcXQzUnhlRWQ0VGV0RUJJRzk4Wjd6akplK01FMEM4NUJJdXEwYXBy?=
 =?utf-8?B?eWpTMVBtRjdreWJURHVQN2hjZERqbUg5eGRUWjVYS3V0Sk9uYjFEUU9vMmha?=
 =?utf-8?B?emVmWVZjM3FTeU1yMEJWTGs3V2tuWFZRaCtwYTJieXlZM1FVWnVjTlBTaHFx?=
 =?utf-8?B?cWFFYngzQUVuSUsyRXRnSDdTalpsU3E1VmFFOVFjQVM4TzI3MjRQODNZcU5W?=
 =?utf-8?B?RE5WRENiRzdoNnRsRWY5elZGcjc0aGtreWNFalV3RURyUW9FQnptME5mWU9i?=
 =?utf-8?B?K3NRUDdrNDd6djJiSEtnZDBLTG5UU3RoR2IyTEtBSG5VSEtKSHpZdE5YWDE0?=
 =?utf-8?B?ZjljNnRBbjRyZGw2by8wSVc5b2NIYXBZTFV0NGlrSnNpdVdpZjFJQjNmUmN6?=
 =?utf-8?B?T1J5b2YwSUl4WmptQjBKMC9lZlZMZUNNTFBOODNCOUlCampBcUsxSTN0cEhU?=
 =?utf-8?B?RXdTQ3BPSHFZRHYyUEdORVBVdjB5K2VublNLYWVVZDEwZk9sUDNGbDFFSkhU?=
 =?utf-8?B?TERkK2dWYWtrVzRqYVkxdk96Wi96SXZMeTlXOEQrd0ZWTWxRZHJxdGhha1A4?=
 =?utf-8?B?djNoQ0RwamJUM0Y2SStGNnhrZktxM2lkRXhkTGFXMDJvcndyaVhDeXI1NWFy?=
 =?utf-8?B?WVJtcHZWaUc5K2dRdnRGQWlreHdKN1ZRb2RKZTU5akt2UG1FeUg3ZDhhdTZz?=
 =?utf-8?B?d0lqazhyR2xDbHZBQUlKRmF0clpqVWh1U0lPS3ZHNnhhQWpUbWF0MmExajAv?=
 =?utf-8?B?b2ZZQ01OWUs5WjJ2R3JNOXNkWXRlbUs3WjRZYUppb0lONGhiR1RHWXBQSm1R?=
 =?utf-8?B?SW1hejZhc0pzNERoZ3Zxb0tVV1lGbjFaVzZ0bERuWTdOUFRBTHJHM1BXS3Fa?=
 =?utf-8?B?cDZxenNCdUZjMit2ZXVsS2drMURrZWRtTWZOUTdiUEFHMkRRaUd2SENka0Yz?=
 =?utf-8?B?ZnpoU0t4c1JyTWtNcUE2Q0l5TlpEMGtqb2JUN1lkVk42YzNkYWtaOHZQSGtm?=
 =?utf-8?B?aldmajAralVhZzU1WG55eDQwN3B3dmF6dXBLRnd3SjROOGtHZXZGR0owRUVl?=
 =?utf-8?B?MGgyUnROWXVuT3N3QXRENXhKd3dpLzNFMkJ6eXdQakFKeFZrdWU3UUNreWp0?=
 =?utf-8?B?S0lhNjBUbTczRmMxU054dkpzV2xOcjBOUEMzdlcxejVLdGtqYURuL2tIU3Ir?=
 =?utf-8?B?K0hXNCs3NGpIakxsMzNmZEI4dHlaRWRiYitaRVlkOUErb0FYaG9peENjSFZ2?=
 =?utf-8?B?K1phQXdweVkwcmFKODB3NnVITDBrNm1Zd3JWb0F2MjZmc056NnFtM0wwL2NE?=
 =?utf-8?Q?c/CGGW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTJXU0M3d29ZekkxVjFNVGhwQUZONkI0QTlyZDhWRExFZjQwNFdMYTR6YzdU?=
 =?utf-8?B?TXVMN0xpUENreTd3cW1rTGNDeGltampFejJsdmo2NkxMRnJFdmNqaSt6Tkdy?=
 =?utf-8?B?WG4xV3owVHE3T1dxQ3g1aXdaazFDenRVOW5ya0I3NjM5R2gyZVdMQlBWb255?=
 =?utf-8?B?aitGM3lvZXBmK3Bkdk8wcG10UWhZOVdHWG1RTmIxTk95ZkxlQ2J4cjlna0Jm?=
 =?utf-8?B?am9sZktDOWc4eUp6RzNhMXpNRWVJd3V4ZnZJTWFUdlMwVnNMRzVvaUNEZkxs?=
 =?utf-8?B?d2FCNzN2NGNzNnlFNjM2eFlxU3NBMGQrMFhWOSt3MTkyRDQ4SnRJZkRaMFBv?=
 =?utf-8?B?ZjhSOEJZWHhnQXhEb0IweS80K3NnWlpYTCtvZE9tUXE0MzQzdkRzYmtDNWlH?=
 =?utf-8?B?L1hJSTlXRDFhd0RtWmRJdEhGYWJqbE5Zb21LUzArUFBqN05Rays1UWNlWWor?=
 =?utf-8?B?U3lBZGhBdzhrcjcxMU4wKzNQNmdFMWpoazFkUkhHZU1CYVJ1UnFZVEszTXly?=
 =?utf-8?B?OEpKeWxCU21PQzBDRDFZaDk5Wk9FbHk2TENXVi9xeWZacWtVQTExSURmblJn?=
 =?utf-8?B?TWw4YmJZWE5OU1MwVzU3MXhqUlBoSmVBODdhVDBUZDlvQWFnQ0lPZzlidW5u?=
 =?utf-8?B?eUN2K0xFVmFLSFRKTVNoVXJWVlFQNXJnRXJvOEFMS0NuSklGRzdhQm8raXBJ?=
 =?utf-8?B?Yjg5YUJKOXNxY2ZvTHIvNk1MUFFOWkg5eXJ3T212WjNwckwzcWppQ1IxWWxz?=
 =?utf-8?B?TG9TSUMyVHRhTXFTaE12VUU3dnF2Q0ZibXhzeXNyQmtjZEFaSDh4dVZLbE5P?=
 =?utf-8?B?TkZYTk9TZEVVazJ2MVpSVjI1WmVaMXE0c0RrTWFVRjhQWWFMUlRTdmFzTXZY?=
 =?utf-8?B?MFppMUJRTFlzeUdrN3RCNnZUdkJBMnVhVzNNanl1Snp2RHU2TDZETlZsUFZo?=
 =?utf-8?B?aFpnVTV2bEpyNVdaL09tSHQ4ZEZjRlZzcnJHanVuZ0xmcVZpWHFFYXB1Wlpi?=
 =?utf-8?B?YlBPZ29IdlVRV0xnbTl2MkFSWEEzOFh6aE5CR0NSalc3cWhSRHdsbjR5a3pP?=
 =?utf-8?B?UEl3UkdWNklRNWZFM012eGg0UVBHWDB0cG41dXFtVDZ2dW5ZaHoyMnpacW5o?=
 =?utf-8?B?cWhGL2tMcnpHb3E0ZjRld2ZDS04xbEdyV2FHQWlDZUtOYWRqZWZIay9oNG5C?=
 =?utf-8?B?T0MzUFAyYlVzWTNKS21EM080T1lSL2lZYjF6ODlOc2JWSnBZb3NGeitEYmtW?=
 =?utf-8?B?eGZSUzNSRXRFSndFNnBkVTdhU1NibUlNYlFVTktIRXV1OUlXaVQ2ajcvZlpt?=
 =?utf-8?B?djd4RnQ2TEpMd1JqbXArMlh4VHZXdVBnV0RRdTdCSVVndTkvYTU3NDJMQUs2?=
 =?utf-8?B?U0VlbWY3TTE3aWxtTEFNUmFwWUkrVk9Ra2hVM1g0Qlhuc0xocm92NDdlQTBR?=
 =?utf-8?B?eGErcUhWZmY5VTRLZ3BzQ2ZiZEdXczhIMFl4aFB4UFVKc1MzQVpyRGg2NFZR?=
 =?utf-8?B?RFIzd3JDNzA1T1BlQ0RRTS8vckZtRDV0aGRHMnVKaE5KYkR0djVoVU1mWlNT?=
 =?utf-8?B?dElHNlo0dXhkc3RDa2N2NlI1TVNDUTdib0VYZkFLOUlxMUU2enQyRFBHbFZP?=
 =?utf-8?B?dVR3RHlxa2FsVmw5dlY5WU5Eb1dvMlNQY3BDUzd2UDVyWHFIU1Ezbk1IOTY4?=
 =?utf-8?B?eG5WWS9MQTh4TEt0bmJML2p1SDhCMVFlWFFGZlhKMksvUWJoZDFmRzltVWVW?=
 =?utf-8?B?YlNNTGR0dW1XTEpSRG9aaUJiVVZyNE1TeW0wNUx5U2ZVUDg1QTFvUDVWb1BS?=
 =?utf-8?B?L2VnUmttUmkrdU5LMVRCSENMWDZEUDBlY0pNanA3bVZrRHk5RzdJNStXc0JP?=
 =?utf-8?B?SlRFMmpOQXA2ZlJjbzJBVUpRajVsUzhWUWJ4SDhyd3FkOU9mbmtlOEQ3bFQr?=
 =?utf-8?B?ditsQ0xJSXQycDkzRm5yVjhGMVJwUGt3dEtPUkd4c09oSmZjWW5YZkpvZk5n?=
 =?utf-8?B?U21SaWNqUHpHOEpMRUx0UU5JTVFvTG4wdzZleFNDUVRQYU1jTUYzQU1qVFFB?=
 =?utf-8?B?Wm1qNG85QVBiY1RPODZrdHdnbU5FaStMQlAvY0dmWGR5RWZSQXRjV2xvRkg0?=
 =?utf-8?Q?vVqo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c1d688-fe5e-4ed1-7b2a-08ddff63ed10
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 14:24:40.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WsQt9bqa377yiQCUvH0MzL4FjyE2fB0IZR6nLo+Zm1B2LkAc7ZOn6teoa2gfrr91rPY6krKGeB5TVK/fDL1LkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8607

Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
dwc3 need set gsbuscfg0-reqinfo as 0x2222 when dma-coherence set.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
chagne in v4
- remove of_dma_is_coherent() check

chagne in v4
- rename gsbuscfg0 to gsbuscfg0_reqinfo
- use flatten core's properties.

change in v3 (skipped)
---
 drivers/usb/dwc3/dwc3-generic-plat.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
index af95a527dcc27a7a14d38dcc887f74a888ed91e6..770fedc16bb80dff95ff12c9506728df5ca4b831 100644
--- a/drivers/usb/dwc3/dwc3-generic-plat.c
+++ b/drivers/usb/dwc3/dwc3-generic-plat.c
@@ -29,6 +29,7 @@ static void dwc3_generic_reset_control_assert(void *data)
 
 static int dwc3_generic_probe(struct platform_device *pdev)
 {
+	const struct dwc3_properties *properties;
 	struct dwc3_probe_data probe_data = {};
 	struct device *dev = &pdev->dev;
 	struct dwc3_generic *dwc3g;
@@ -75,7 +76,13 @@ static int dwc3_generic_probe(struct platform_device *pdev)
 	probe_data.dwc = &dwc3g->dwc;
 	probe_data.res = res;
 	probe_data.ignore_clocks_and_resets = true;
-	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
+
+	properties = of_device_get_match_data(dev);
+	if (properties)
+		probe_data.properties = *properties;
+	else
+		probe_data.properties = DWC3_DEFAULT_PROPERTIES;
+
 	ret = dwc3_core_probe(&probe_data);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
@@ -146,8 +153,13 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
 		       dwc3_generic_runtime_idle)
 };
 
+static const struct dwc3_properties fsl_ls1028_dwc3 = {
+	.gsbuscfg0_reqinfo = 0x2222,
+};
+
 static const struct of_device_id dwc3_generic_of_match[] = {
 	{ .compatible = "spacemit,k1-dwc3", },
+	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);

-- 
2.34.1


