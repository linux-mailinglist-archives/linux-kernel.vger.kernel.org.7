Return-Path: <linux-kernel+bounces-891017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A61C419E6
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00AC1897166
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3689633A00C;
	Fri,  7 Nov 2025 20:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kHDyJkNx"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF530F7FE;
	Fri,  7 Nov 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548310; cv=fail; b=m5/9xpaWlBElojCBBClW97RSNjP7FndMiy1JijtLB6ewulrSoPdbiDYe/WQ/Wou7R6sBBdLk90q9xd4L57KeXpEYGeQiqzXlSn3dLf/7/IDTdBXBkV5bQCnRtkk+JUY2X4nQqpLnbg/orZ552TXTvE4Kv+cf5FZT6JK3sstpf48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548310; c=relaxed/simple;
	bh=Nx6m2kTz9MnGvT0LPTpNQlk+9kR/GrBRxiKGW1eySIc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pcMuZscw1Jxpc7NiBcNPaBod/w1FQxpJt4N5mLNGsetw5wlkMlewTvv02rQSIQ46uSU4+Ktz+mBS2DSib9vW+rvrpySt5p5Fw0YYf1wVGACoOnUbgITZSw+K5yTUU2IU37/1wDtLf+sO4RhwgWlv9MxY5GVE4s+fWEatB3fkUQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kHDyJkNx; arc=fail smtp.client-ip=40.107.159.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nfe3yyQfv6MQpmMfZr3TPGfad+OoYJ/sKJtVQV65+0xDy6X1Gh1sh+8JY1F1ZSZq+DwYQw0VL0ncCJyekUozQv368QjgtcYEVZTgqJ7a0BUiRzQ9jAlFIc0Qr7SVTN5es9H/gBfW3NY49wC576UMTVSNdW31zxixHMxTNLeouxy8k+BcH0lDuxajaEdH/t12T4WCAyhXjcO/zRwN0V5cOx/voYbEWenTGE9WTjYZtkBFSAZDGL20WRNJEazFyAg864EiLTlyS465Dds/5eKPl7o4rFeYuiPKVAoP+Ro0Lel0S7EzY7/svzHm0a3TZ4sVoXEOGIu9VXSHuwiBwUvM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2IfrSM34hUvUtXMsyqdeTNctH21ohqKZkLvLNQvb1s=;
 b=fnfDNQOixtoBaCr/yGe1IDnrA++9KYPKefnAhfbVpxyFCa6jtizDKaB8ZYJaOMHqWrDnUhYGJcyIsK2jqACkGAQBPD6FeUS4onNJ9B7uUE2Vqi0l2C2lWdipTxwDNXiYzCU+BmyFEYTL5qIS3WBzgmfjCAYCbgEjQifOlehVtkeIsYdY1iNDphznNnQhfaD0ouSpQcaad62miihEt+xUQ34059Qw4BSClxDCoZU9cbeuljWfc9XuZTq0IG1f+eFO2k8z0SzrQuXP0E/iQ1m0+z7VstitCm5EZliB7DpeAk7dnQ4i4SfLFGo22HXYK9PyWZOU0lI+jmenF782ZkvPNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2IfrSM34hUvUtXMsyqdeTNctH21ohqKZkLvLNQvb1s=;
 b=kHDyJkNx5Uxw5WXwMgRxshHDhznlJdbovaNPc17X0jq0WCr3EjZOIx7KNmkI8Bdu5hVous/8z/xoEa2oX1tpQvyDbgJc/GKZiEYtiBZPRfOFg/Z3pSbYuMxvR8R/Oc7s74Z/5nIxS53I6e58MgBCsi0VEco+CqnnJzGgyvDFf5TCj1Vgea0nZ27eUBgfkke3GiFT01jFo/8acyWQt1nsyTkZQYCe6kpgyjs/IxOEsWkP3ryBPw7STCOiYZJrr1qt0if6jtbX+VXDWJgKyune/VLwzNL6rJsJG+GfoI1q7pF9FrF/VbrF27XA//GhAukNpAI+fMkrH9SbZTz8G4ZJ9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV2PR04MB12021.eurprd04.prod.outlook.com (2603:10a6:150:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 20:45:05 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.012; Fri, 7 Nov 2025
 20:45:05 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 07 Nov 2025 15:44:35 -0500
Subject: [PATCH 4/6] media: staging: media: imx6-mipi-csi2: use
 devm_mutex_init() to simplify code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251107-stage-csi2-cleanup-v1-4-5d42535243ac@nxp.com>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
In-Reply-To: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762548279; l=1431;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Nx6m2kTz9MnGvT0LPTpNQlk+9kR/GrBRxiKGW1eySIc=;
 b=Rl23NE12mg5TTOHuZQ3JR1bZT2YiEs6192UFj/5Xn5xGP2jx+eciPMizvulal7TLi3DkTDjqM
 I206Gr2EIjED+/xMj2dSEYl/tiWJpvMJVx6kfFF6QDWDJcfqy1EhtzW
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
X-MS-Office365-Filtering-Correlation-Id: 2b63f99c-e0e7-42e4-0b8d-08de1e3e8781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlpEVm9nQSt1RVB1OUdveHI4YmNoUU1wU2p0UWZmaC8zNDFZby8yM1RpSU05?=
 =?utf-8?B?cnVOTGc3dDJzRWRhc2ZPdStLeFhkQStGZXJsRGl5NDVoT2hFRWdZY3RtWnRh?=
 =?utf-8?B?ZWFkZ1o5L2JvS1ZoVVArR2YrbmFFbFRiOUFQK2E3SHJQM1N3azNDczFaTkZk?=
 =?utf-8?B?T1ZDRk9YWncwU1FsSFdkVy9sTUlJa1NYcXlORXg1YXQwSnR4L1NVK3c4aDJO?=
 =?utf-8?B?bkErdzN2S1RFNmJqNXFjcG9aRkNuWnRpdWFtcEtiZjJnTEtvNXordFYzbDVp?=
 =?utf-8?B?NGlCMzUrYlBiaFEwQ2JaN1I0VU12ZlhwNi8reVdPeXhncThDbWQvRjZEZEtJ?=
 =?utf-8?B?dFBKOVBUMTZMaEM3M1dPdFhITzVkUWFFU3p5dTI3Q3BucCtDRjZ2dUZzdExw?=
 =?utf-8?B?RWhmTGJUUTZlTlJvMnMvdkl5TDFsVWRPakdRMmFYN1dRS1FzUlBOcG5yNkRV?=
 =?utf-8?B?ZVhaOUxIU1NRSFZscjNoSldDeHRITkNOaUVuMXdVS3JCR0tmK2l5YlJtZ1ZC?=
 =?utf-8?B?RlA3bk4vbnVMZ1E3NkRrQlJPMHBYcWIvWXJXZU0weWZUbUpoVzFKd3BwUmtC?=
 =?utf-8?B?a3ZFS3h1OWVPOXVta2lQOHhPU3lWdVFFa0xtcXhvYjJHZTNrRm5zVTB5OEsz?=
 =?utf-8?B?cSt1RWFUVjNod2RjaGRvSzBXWGR4ODdVUEE2eFFjeVpieWFLT2pqeWdwQmYz?=
 =?utf-8?B?UHZvdUFhcGc1Z2Y0YjNuQlFzcmN6YzNCbUw3TDFSbkIwUGxMT0syMkhQMUJk?=
 =?utf-8?B?YzVjamJ5RmlrWm01VDUxQ1gzZ0loKy9Rc2xzeFpkVFA5SHBOWG95L1F0Ykx6?=
 =?utf-8?B?RXBKR21hM2VwVTA3NE9hSG0vWmJlbUxlUlRnMFJRVEFNdklXWVJpOU1NQzBZ?=
 =?utf-8?B?elFvU0NsSmxobkd1eEllTjJFN2c3UU9nYzdNLzYyL2RMalZvNUNYMGQ0cUor?=
 =?utf-8?B?c3R4aWM1WVZDNnp5RmJXa2RBMjUwRnFpaUs3VUdhbk1xMFVIUVNjWSt3ckx1?=
 =?utf-8?B?SCs0eUxHcFY0TytFam45S0VvOFI5QU9LdStCdTA1YnIrL25wbVdRQUNaeDJL?=
 =?utf-8?B?dXNJZS9PalR4emhBc3oxZzJ3U1lRd1lGemc0UzVmcElEd3lubXQwZ0FxNU00?=
 =?utf-8?B?K0JWL1dLVzNmaEphcmE1ZWNNZENDYlVoc3lSTzdYTXdYTlAvRE1nTHR1YXM3?=
 =?utf-8?B?TW9YdWpqR1B2NXVYa3dDQnJFRzg1eFZlRENqRWVyaU1LWnRra3Z2MlVHdGFO?=
 =?utf-8?B?MVF3UjVLMjkrNnduVjVTK2o0cHkrNTdUYnNHdkFva3V3YU5xeG51UkY2dFVI?=
 =?utf-8?B?TUl2eG5LbGwzYklPRWh3YUlHZktPQU5qaWJudXg4RTNtZ1dQaUZsZzdTUFhy?=
 =?utf-8?B?djdPZFRCeXlJZDlIdGRVSjN3bGMzWGdkRFhMZDNUbmIvaENIdnRoMU4zVHIx?=
 =?utf-8?B?b2VDcVFtTWFlbHBSYTR2aHhwOTRzWkw3S2xmM0J5VFFtWExReUZ2bm9aSHQ2?=
 =?utf-8?B?dWF2YUQyNTI3YVhmek8yMndBR3d2eXRWcGt0RGhYNFl5Y0pBRVZTSThOdXdK?=
 =?utf-8?B?TkQybUc0aC9SN3o4MmlQOTVXT3lJOXIyY2FQdG9PVUt4NkMzK3dDSnpjQWU0?=
 =?utf-8?B?TStqK3g3YTNmdnMxZytISXpDRXFsMi8xbks2VUIwdWM5akNGN0lpc1Jad21B?=
 =?utf-8?B?R2NZemNaTmlSTXE5eG1XbGNOV09raGNkU2Y0S1pLL1JDZm9QN0JBdE9Sb2pC?=
 =?utf-8?B?dVgrVzROYWU5L2tsT0V0R0FNWUlaUVhCeDFERFJnSU51bFBXZ3J3bHM1TWRt?=
 =?utf-8?B?M25vNlpITiswSVFBR0d2WXN5ZnNUWEphZGZTcU9JVGNBMkg0NmUzSnQ0Zkd2?=
 =?utf-8?B?Y2czQjIwR21xUER4ek9XQjNOS2R4TzR2TUdqeGtUbzVBWnNlYlN1Y0t3ZXlI?=
 =?utf-8?B?NktnbzY4d0haVTBRQ2NmNURHbEtnRVIvUHdJbjNPb2pYUlovY1Q2NXpCWmEy?=
 =?utf-8?B?eGsxRUtPd3pyZzUvZWNic3hIVUdtUEZMWmhlb2l4d0lDK2p1OGJCNDRSUmRh?=
 =?utf-8?Q?2I7iWa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0wxTlN6Z2xidXkzR0FUVng2Nzd6L2o2OEVodm5qS0t5dWFQeUJONi9QVERU?=
 =?utf-8?B?aDhEb2Z1VkFZYzNGb2hxV1F3K3pob2wyZDIwcCs2R21tMzlNSmpVTFVQanRq?=
 =?utf-8?B?SHdhdTlEVnFTeWhLTks4eTFnK0VJanV0MXBnNThGanhXR2hWUTZPQ0ZGNWJw?=
 =?utf-8?B?TVp3S1dFWUoyYzFDY2VSQnAvTVd2RmNTcUU5R1BYOEwwM0YwcE9IZVE3RytQ?=
 =?utf-8?B?a0FyVmw2VkVqZFVmTEduSXlZaW1XZFM5QlRqMUJlRC9PRzJNVUIvdi9aVW9t?=
 =?utf-8?B?eGxzTzJmVExXbnNKT05zVCs1SzlETFF6RDg1SFhoQ1h6dC84blhNNU4xS0VW?=
 =?utf-8?B?cjJ4SFU4UWEyWmlLVXZFL1pTT2xlZi9ZSXJWbWQ3b3IxNUJnazQ0eUxhck1W?=
 =?utf-8?B?Z3A1N1dyQ3JQcExrN0tvMmlXQ04yb2twbUx6eWNDTHJzUGFuZThWRlpKdG0z?=
 =?utf-8?B?c3lOOHlIbmlwVlZDRmFEK0FaL0I0ZE5iYzFCQ2xITlFWelA3aEo5Zm9EaTUx?=
 =?utf-8?B?VTc0MEJPdlh3VGp5L1JGZnlLMEJtQm5SbStzR0RHZlpma3BZQmRSU3ZEem1n?=
 =?utf-8?B?bGlkRzRZWG84dFV3cDRlRlk1R01ybWdJRkhicEc2dEVJVFFrcGlnWG1HL2JF?=
 =?utf-8?B?Rm5aV2pCM1kwcFUzblVzbnRnMmlpTHExUWFHSmprOVRvNzdqNHpWTmR2eDQ2?=
 =?utf-8?B?SGVUUWpSbWZEdHF3d2k1ckVwTVNrNTF0UFNpWDQ3REZaNm9HTGp0VWdoOHV2?=
 =?utf-8?B?MmF6RGRYR0hOYWFyVHg3bklUQXVrdjFpaHZ6TlpOL3Fab0FrcGZEaUx6emJE?=
 =?utf-8?B?emROaEFodkNKU0dsRkI3a1owem4xZFRiVlh0c0tHYUI4TkZDVHV3VTVGTXEw?=
 =?utf-8?B?MC9qMDhVTVluc21zOFZmNDFlekVaVm1yd1gvN0V1VjJPa1BmYVl2SVdwcm45?=
 =?utf-8?B?QUR2bng2Mm0vQ1dabWMxWGtveTFXdEFhamZzbU9hRHhLQ0ZyQlNGTlNEeW5Y?=
 =?utf-8?B?bnRSMG9DTVI0N2lndURpUXYwb0lOTGpLSGRpR1NLLzZXRm84VjViWXlTOE8x?=
 =?utf-8?B?dnlTZ2xQdVg1a3M2bkRrZVI2emw5VEpuT3hWSW9xMlVONlhPTy9jU0ZtWDJp?=
 =?utf-8?B?L1BmWEZtUm5MSEVDRFFpcUtKTk5TT1RhZXJQbGtWa3lRNE5ROVBuZ3g1V3BC?=
 =?utf-8?B?dzJ5M1gyc2tzc3lrTXlmRVpycWdORWp5OURXVzlaQ2JYTGVGLzFSRVpNUVBy?=
 =?utf-8?B?R29LRXNnNUJXcE00TUUxbmc5WmhuR3ZJcUZTakhpZEV0dlg0Ny9SU3VET3Nm?=
 =?utf-8?B?QXpyMnVSK1NJeXA2cUFiaWorN3Q0SVY1d2Q1YXpyLzFVTEk5UDI5YWdKbXZK?=
 =?utf-8?B?UHZuRWRxRnc0dm5VQXp5bVJad3psMTc4R1dLcXA4ZXpOeEVyT2xpQXIrbWVS?=
 =?utf-8?B?RmhBQVdReWVWbTdsMzFhU2tUL01URU5yckNJWms5L0dFeGxMNC83MGhVc3hT?=
 =?utf-8?B?bFFOSzFyYWNDR3g2VkdUOWdGQkZhSGJWSmRDdkRYWlJQNi9GZ3dxN3pZQ2tC?=
 =?utf-8?B?MTM4dXNLRk9aR2Q3WnhZL08vQ0EzOTRDUjVXbk9nelFsWndBVUZkSDRGUnhB?=
 =?utf-8?B?N1RWWm5qM3g0TFpMTmdDMTlLdVJJeE9qczR1SlNNWWlRT1pLM1IzS2FjWjE0?=
 =?utf-8?B?dG1pWWZ3enVKQkRJa3dsemRCc3BMcFRqMnhVZFYwYTg5U1hFanNYYlBuek1S?=
 =?utf-8?B?QzRxcXM2MzVsK3p4RUg5WVIvK3h5K21CUjR4QmVTN29NaTc1YnN2Mzl1UXR1?=
 =?utf-8?B?b3RiNXJva2Y4OVM0YzBEY05DK09xRFM1NUNKb2l1Q1llNzcrdmt5aXdzVWQ5?=
 =?utf-8?B?ekNPWjF6bVY5eGphSFkyd0xrSVF0Y1hmbUtYQlFnVnRkZ1ZxVXV6SHU4TENu?=
 =?utf-8?B?UlIzbW4ycHdralFtbExxNDd3K1hDTGRvRzN2TSsxb3h0alNFemNUNzVvOWk2?=
 =?utf-8?B?cWQzWVFBdytUNXJyMVNSYU1TaVArcTNTZURQTFVBN0IrMEF2TXJrMDVrRzQw?=
 =?utf-8?B?bHN1b2NkU3FqUkk1eEpDQXg2RnZFYTFqc2p4QmhRblU5ejRYWW5jTXVkeGhT?=
 =?utf-8?Q?0CbM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b63f99c-e0e7-42e4-0b8d-08de1e3e8781
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 20:45:05.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbwcjHXuMZ8zx1MvIRXsOdUFWxb6hnP61N4keOTYdHZ0AYtB9YJjfcwVO+owj18PhIY+BOtXqG1W9f/McJ9/eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12021

Use devm_mutex_init() to simplify the code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/staging/media/imx/imx6-mipi-csi2.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
index 32ddcef7ec8535a44e121754bb621c0d2e226369..f8d0b3b8b250774af51f2aba731e639131aceff9 100644
--- a/drivers/staging/media/imx/imx6-mipi-csi2.c
+++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
@@ -771,30 +771,23 @@ static int csi2_probe(struct platform_device *pdev)
 	if (!csi2->base)
 		return -ENOMEM;
 
-	mutex_init(&csi2->lock);
+	ret = devm_mutex_init(&pdev->dev, &csi2->lock);
+	if (ret)
+		return ret;
 
 	csi2->num_clks = devm_clk_bulk_get_all(&pdev->dev, &csi2->clks);
 	if (csi2->num_clks < 0)
 		return dev_err_probe(&pdev->dev, csi2->num_clks, "Failed to get clocks\n");
 
-	ret = csi2_async_register(csi2);
-	if (ret)
-		goto clean_notifier;
+	return csi2_async_register(csi2);
 
-	return 0;
-
-clean_notifier:
-	mutex_destroy(&csi2->lock);
-	return ret;
 }
 
 static void csi2_remove(struct platform_device *pdev)
 {
 	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
-	struct csi2_dev *csi2 = sd_to_dev(sd);
 
 	v4l2_async_unregister_subdev(sd);
-	mutex_destroy(&csi2->lock);
 	media_entity_cleanup(&sd->entity);
 }
 

-- 
2.34.1


