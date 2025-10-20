Return-Path: <linux-kernel+bounces-861775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09344BF3A45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 788B035098E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F4E2E2F03;
	Mon, 20 Oct 2025 21:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZQwig90r"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011026.outbound.protection.outlook.com [40.107.130.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E96221F2F;
	Mon, 20 Oct 2025 21:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994418; cv=fail; b=GIAkZSJlBzbzMM+f9kR1IKOkk8YnGWJS6ISTgYlkyvGPSRXCtFf3HaorgLmI6ji44SpKmu8N8nQlcuaSRmlOW8vG3a+wqVLkPB9w62VP9MrL1lBvGL2u1tM9V5JyoS7IF3LJfl6Z6IVNjJCA2aqMGcfAlagfHyqds/atSAx47Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994418; c=relaxed/simple;
	bh=se4yEangNpaT/YImzn0Iovm9uaGv7z40R7MEMBbAZss=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fx4jZZh9LkyEJn7KDVdHDvxrvyZSmf4pzUO1TsnhNJLsCDUE/2nZlEFngFDfZliJ+uGoNcI+mnCdStw41AtxZ+g0plmVILvtwdQeBzBziZ6qj/JplcK1gDhoy/6d/lM2RP/RqE+M+W3Iv6LE2DLJXM2kPHycIBeOV6GAk+ELoIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZQwig90r; arc=fail smtp.client-ip=40.107.130.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+FA6300icpNYd3qmBQXosHk9LDRLPpjH4Ur6qvftOThWOQlEpaB7l38QejwgbtUVbifhid3vNHyepT4hoXuNSZSs+rhuoQ6UvetxcriYx5eVHLig1O8RIQSWEv0LP4SUVHK/VuNebHMOPNBDS6w+JVSmkFqQKPPsmVKb0C6oq8xuJIOftnHZoqrTIG7hfbJ/IoWmBkO9hNLYTiYOwN2qcZ5GlL7x2EQe2x2WyfcgwIz+FmVNZTwwAgj0cX+JkC7iEjA3y4vPQM7s6XeCucq9PT458t7T5tTNTKWHEN+A7ZMBCzECD5tBihWfCyfObh/hAidowCD23fLfQLDu2U39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crRFN6sxa5Auj5j62GFWkGpY2GgipK6yNjYhmGTbR20=;
 b=MS/mtVOhBLJmyxr+a3S9G5Vq1aZpfiIDt6jUgQ/79i0Qn4OcJA8XQCjlH0HqfEevbUOA6u85boGMwHXTB+cvmJ83DUxcVb5grDly56BMAObm1WfPbZIfu92YoMAwajviyW1Ab1lA76dOJy+bcd1P6Wm2hlujno1PEXS2PZOLeFfldXyB0bp6998ReT+IVGBPeidiqSPpAHW9yecxRyPvFfgYhjnn+ZJheWRVVkob7sReU3Q2NPIETSl78uGmhR4EATyGKCA+TpV7NPMkoOi6mQYJrwyPpIJjsStJbcjlC4nok1lVyd0eFMbPoiXbw0/VuP9MDzYLDAciIYkv6ePLzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crRFN6sxa5Auj5j62GFWkGpY2GgipK6yNjYhmGTbR20=;
 b=ZQwig90r/ZMCOIZt6Soj4PJ9onmJOCryIN8TUxYtwmZLhzR7i4kg3IDeh0aagJFkpDmwYyQbpbab1gDtNCAIIHnjX59u2RDop9ZKz8bmnjuEtwmvPRFczeqK7WMvg8WrwpkwHLf0QSuMJ2NDukFNjzg2+9P8yOy99XGPxNZEE7DQrqvFaRpRUXCnSgDtVozJgkaKAD0jKizflxyQ8hRwD8ab1oNDrj14Y8S/6oC9+8mOlAGLfI+XZq6iF64GT4ASVPUpk0vx1RFUAGv12fLe0VsIiZH+v+kYPTtMr7M0t0F+anTcNAdAz5U3Fxli1W5phAk0xP/KHF0Iif/ZL50uyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB8105.eurprd04.prod.outlook.com (2603:10a6:10:24a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 21:06:51 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 21:06:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v2 0/9] ARM: dtb: imx6 DTB WARNING cleanup 2
Date: Mon, 20 Oct 2025 17:06:34 -0400
Message-Id: <20251020-imx6_dts_clean_2-v2-0-3c12ead5094c@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqk9mgC/32NWwqDMBBFtyLz3ZQ8jA396j6KSDRjHaiJJBIs4
 t6buoB+ngP33B0SRsIE92qHiJkSBV9AXioYJutfyMgVBsmlFlzUjOat6dyauuGN1neS8dEo3uu
 bcVhDmS0RR9rO5LMtPFFaQ/ycD1n87J9YFowzzU2vGtRWje7ht+U6hBna4zi+o0Gtaq4AAAA=
X-Change-ID: 20251014-imx6_dts_clean_2-0f830b578de4
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Marek Vasut <marex@denx.de>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@dh-electronics.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760994407; l=2686;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=se4yEangNpaT/YImzn0Iovm9uaGv7z40R7MEMBbAZss=;
 b=f/Bbnuji31qdIFIyWFieF8YtCMF925ry460G/kG3Veelut6qzcLCBF81HgV50zFy7BHZwA5cD
 HUf+tnIceDXBiBRp+wir3pK0El8pqhqs3ylNO+9Htqp1H8rk6jazG8H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0035.namprd17.prod.outlook.com
 (2603:10b6:510:323::16) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 71d228ba-19fa-4555-fe43-08de101c96ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ektjL2lacHdXaU1xT2pGU21lT1gxaTFqZDYzbGlNcTBBRDdlVUVwUWZtcHZu?=
 =?utf-8?B?QzdDemo2MGg1V05KUHM1aUZDWlk1UTlsb1dvK3BiU01YUEhQaTJhYzJ0QU5M?=
 =?utf-8?B?Vk9iSHRGeVpTMGVBZzE4Z1VLRU0rdUpMSGh5MXNIV1IzNUxiY0F0ZTJaTGl0?=
 =?utf-8?B?MFpMdTVzZ0RvQmRudVZKNFBOd0NEZFRGbWsyY0s0NmRtczhJSCtmSEtDSzVh?=
 =?utf-8?B?WXBEczFDdXhwQkVrWHZtTUFja0ptODM3azNNekhhYXJYR1R6WWQzNWFXRk0y?=
 =?utf-8?B?aEZXREN2RnNNKzg5RE8yRStSME1ZSm1JOUE0b0plUThFMWdtVExpclNnR1Vs?=
 =?utf-8?B?MFE0SDgzQ2ZkaGxXeWlYdk95T0hnenpyb2dsQnR3QVJhRFBZR2lWQ2Z2d254?=
 =?utf-8?B?Y3FGeFZGSzZ2WStOWDZ4N1FhNUlScHNqWTgwOXpxSlJ3U1NUU21TU1JFTzZQ?=
 =?utf-8?B?bnpNVkJTaGVaeHhBNS84QW1wYW1adW1FaXFCMGpvT21tbU9keCtCelpvVlNo?=
 =?utf-8?B?V1ZVUVRXZ3hjUXp2b25tWktTaHNKcFRpMS9vZER0S081QkFxVWF5QkY1Zkhs?=
 =?utf-8?B?c3dUejFvZGNIM0FBZnN1L1lXRFoybWJuSUF0c1h5Y2RBcjhybHRxRnlZOXlN?=
 =?utf-8?B?WXJFbG5CMittL2xaVUlROE1SSUJKOFoxK0FZK3R5YjlQcy80SjlPRU5CN0tq?=
 =?utf-8?B?bW5YV1NsT09IT1pYOE9meWNDUEpvS0VGU2s4SHE4eFdSc3ZjUStqZHJIendM?=
 =?utf-8?B?blVWZzNMd1phL0pPdHdhWXpjdkNKRWtPVUJVRmhZVlB5b3lLOTJBZGFvR0c5?=
 =?utf-8?B?TEtLNkZXRzJGbkJBUElzWDRPQ3ZVdk5ackhlTVpHb2Jtb04rSmZnbGJUR0Zk?=
 =?utf-8?B?YmI5SFU3Rmg5bTJkVmlJRVI4dmYrNHIvQVBoTFZUb3NWU1p6Y3c1MndJaXg3?=
 =?utf-8?B?WnIzQXZrQytWWUdmTDVjS1F5Nmo4YmZBY1F5dnBjZ3NvOXdKSDZuakJoVndj?=
 =?utf-8?B?NUlVMUpVdFAvS0cvc1c5U0k4b1Z3V1hXTThxT2o2dEFiaGp0STVEOVJBbUZz?=
 =?utf-8?B?NWRtOTRtemNYKzZvczFYYnVNWkZPbnE0eDVOTkpYVi9SZnRNN0ZEbnM4Wi8v?=
 =?utf-8?B?ZTJLMjdkdDl6cWR5amFld0N5RnFCQmZzMExyMTNuRWhvMnRUKyt2bXdhTVJ2?=
 =?utf-8?B?UG5FRHJXUVZpbWxSTVFkR2owWDJlbmVoT1B6MCs5MEMvbDA4MWpFT2xNWlg4?=
 =?utf-8?B?ZmdyMG1JMmNQNGlJTCtsSEJtR0p6eEV6aHlxejh4d0JQQ2VuUTV6VzdGR2Fo?=
 =?utf-8?B?QjVEKzJiR0ZXcGNpeGVGODVpWjgrWnlSeGNacHo4Qlppd2dZa0pvQldkTU1W?=
 =?utf-8?B?Z0hxMWpLNnl4KzNINFVVWUt6VlJUc2lOWTNTRXU1VjlYSytMZzBWamZvUGFn?=
 =?utf-8?B?ZTRqQ2E0MHQyWGRUYUZkaDk2MlpYMEhQZDV1UXNNUCszUm9sK0c0TEZSUXp1?=
 =?utf-8?B?aVJWS0QvSWdYUUlHQVN6dnRnYzhTN2Z5MWZXWDJ2QnpRSkdGanUvcWF1Q1VX?=
 =?utf-8?B?VVBGRmtGK3FSR3J2TUgvWEYvWlNLcVRMWDBEWVVTZ3AyNTAzN2tza05uNlBM?=
 =?utf-8?B?OGxtVW0vbkZZZmVvK3dBY1VncVExMEg1MVA2aVE3Tkp4dG9uWFRRSHcwTk9Y?=
 =?utf-8?B?K0p6ZFlLTEFCWWRCQjc1UmZvcUxteHg5ZGpRdHZPR3RPNlRTaFNaVUJyVXZQ?=
 =?utf-8?B?UUhmUDBhUTlBeEM1U1BrZ0FFOG1jYXRBUEFjbFVUWHp3Yy84US81V0NKMkpP?=
 =?utf-8?B?WFAwamFiMENlRnUvQkEyWkdUTFY0U2hVR0c3eVdEbnJaQkNjUDJ0dW9kdlBY?=
 =?utf-8?B?ZXlBMlFNNHBldm9hVEkyWit5alNFRm1ZYVBLMGNzZE5seStxZHcwVkx3UFV0?=
 =?utf-8?B?UEd0Y2dUN3FBSEYrdy9xbmRlQ1ZBT0o5eGE3RThhVGlpYUdtcWh1eERqMDAr?=
 =?utf-8?B?RXN0Y05YL0dhVG5xVU5BdmVpeFZQT2VRQ3Z1VVhlZUVlUnFEOU9tYml3MEpw?=
 =?utf-8?Q?LAY4/Z?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(19092799006)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlpPeXlHNy85YThYOUN1WC9GTGU1d3d0SFFEK2JUbmJPdmlGVjBReU94MmhV?=
 =?utf-8?B?ZkUrNG9LaWdJaC9JcXY3RXVna2ZPNEtpdzRCeWhDOC9iK3luTkZkMkJjcmVQ?=
 =?utf-8?B?OHBRaUI0OFE3NjZ0cStuY25GL3pDZDhrcUdvZTJWRkFqSEV3UURMY2tBSHpk?=
 =?utf-8?B?bm5kZncraWp3L2ZQQVowM2FENHp6czNQUjR4VGpyYlhsRHdRZ0lyTXZ0T2lD?=
 =?utf-8?B?WTlBdmliSkR3Q3V3dFEwMkFRQVdCK3RCYVZmaXZUSjJvNk91OU9tQk5VK1U0?=
 =?utf-8?B?Z0ZKb0pvbmdwWVY0YWd2UkNNL1pYSzI4c1hFSjdBemgrejF5L1NvWTZJNkV6?=
 =?utf-8?B?NHdLazFKWDJMLzNYQmtXRWJyRnkzSHVGRkx2bEZtYkdFbGhSVmNGUjh0dGhw?=
 =?utf-8?B?NXJFa3d5R3l2SHFRZTd1YVRGV3ZnTERTeWNzVG9HTUFWMDJHc0JOMmtxbncv?=
 =?utf-8?B?OXRPYlR2Mkk3a3J4cERuV0NDOG00VUhDTk5neXNsSy9ReVZMRklFU3hRUWVQ?=
 =?utf-8?B?Nnh0NEFMcW5aelBaWWF2c3hVcHd5TloxaEhkNzdhaGJ5WkYvRHZ5WXJKMHpW?=
 =?utf-8?B?K1dSWHNYNzdsU3NFTmNQdGNsK2VPc0NoWXdoc1lBd2dsYVVnc1RjQ21NdFRR?=
 =?utf-8?B?WUpuWkVWejV1V3BiUVdkdWYxQUtGbEs3NHJHN1haVEVURTVkWWZOd0FNRFFy?=
 =?utf-8?B?V0xMMEgrVUQ3aTJQT0NDeWFjeHdVTnBxbmk2VWFZbTR5MjQzWDZRaENQemNJ?=
 =?utf-8?B?WUs0bTV5cEI1RWpVc2JiWWNGT0U3S1FVbUVpTUZlaHhUK1lhVGF3aTJVb2xQ?=
 =?utf-8?B?NGsraS8rNGhrbk1CYS96VG1KOGkvRW5aQkk3RXcyU0RKaTlHR3Awc2FOZThT?=
 =?utf-8?B?K3h5M3JyUjJjbjB4R2E4MDRsbTJDRStXUEpNVklkMnV5b1lxc0FkeVYzL2Ns?=
 =?utf-8?B?azRBaEFaWVVnL0RpZmxKV01NdU84bDBPN0Y4OFlOOHJ4ZHBxVG5uanFrMnkv?=
 =?utf-8?B?cHRyYW9xeVI5K2pwNTJ5R3V6ek15eU1SWE0vVGtrdFNsOWU5V2hrUW1MbnNw?=
 =?utf-8?B?OFhtSHpockt1RU5teFhkejdlQWxHWlJSMmxhUEd0M016VXEwRTZRYzVhTVhl?=
 =?utf-8?B?ZzRuVXI5Y09pdFVrU054cDdyUjZWZ0RpaXFDRnJYOWNaMDVhRzBJR0VDTDZG?=
 =?utf-8?B?YXk4cG0rWkJzU29OQmU1R1hCZjdOaDg2dVRiRGZQUXlYWTJmMzhwblgydGoy?=
 =?utf-8?B?YlM0VWdjdkV6dHZKQzZ5N2grYzVDeXlscEpleUVLUEZobklQLytIOWRoZktQ?=
 =?utf-8?B?T0xZaXgrSFBMUzFvUkNXUjBNWVhKMkdmaWtEa0xTRm01RDNDRENUYWZLcC9Y?=
 =?utf-8?B?SVVnemt0RGdmSFJXZkJYMkV1WStLb3dNNDN1bDl5YTRtQ09kZy9VMTlvY05a?=
 =?utf-8?B?bElOVGFwUlN1ZGZaWHJXcHllUU9adW1tSy9hQ0cvdVF1UEtyWUhLVTBQdng5?=
 =?utf-8?B?bkFrZmZtcmFwSE1EMjVFWmJWdnhXUmxiVEx1UWtkSGRrbkVYZjI4bTRSeEp6?=
 =?utf-8?B?VXJWM29RT0NlNWV4MnNRNjRjWHp6T0xLbFhkQ1o0YVNtM0dnN05oaHY1bjNa?=
 =?utf-8?B?d2lOdERELzdQUFFHYkVBUldjTUhlS0JXelBYTDN1NzBTa0FCYmh2RDRmdDR3?=
 =?utf-8?B?QnBGdldpVXNtM1h4T0Mzd0daWEdIRWVPRzhVOFVRWkJsSUorY2dVV2FHSzZt?=
 =?utf-8?B?cVNmQWZRWkpRWVlyZHBwYjZoODBsMmt5U1NhNXFaVi9UYjFGOE90NlhOVHND?=
 =?utf-8?B?bGtmZ2JGVmVEZFNITzVmTmg2WHBhajdsSmgzTW9ZcDVNNW9xZjJ3MXFhcFVU?=
 =?utf-8?B?Q1ZtZVZEaU5HM2NhT29mVG5oOFl5dzZqejl4UUgyajFyUDIySU5SZFZwQ2kr?=
 =?utf-8?B?c2RQSWNkSDM5RDVsdVB6S0gydEpRMjZ4R2tTRHhDdmFUYXJhZHBPREt6eGhP?=
 =?utf-8?B?dkh3NFZpRkx4OUNjQ0pZelkvTDhzTjJGTDVRNlkwOU1FNk5KYWszV01hbU00?=
 =?utf-8?B?TlFaTkdha3RhcTk1VVdpY1JnaTdJczIyellUTEZobXRKOERKYkVubHVoRGxN?=
 =?utf-8?Q?cW2RA0QIVxxbn6+CY5lTlkNuS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71d228ba-19fa-4555-fe43-08de101c96ed
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 21:06:51.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aGDUnTMj3O18DAJ9ZFBQ28x4/WLo6p9FTVgUXfA9iZ+1YlF6yqqno2rsW4nGGAR9U7FU/E9zcmZ21A3ByvBdJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8105

Some trivial changes to reduce DTB warnings. It is 2nd patch serise.

First one is at
https://lore.kernel.org/imx/20250904094649.GC13411@nxa18884-linux.ap.freescale.net/

This should be indepedent on previous one.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v2:
- Split touch vcc-supply from lcd power-supply patch
- Link to v1: https://lore.kernel.org/r/20251014-imx6_dts_clean_2-v1-0-508b36e5a3fd@nxp.com

---
Frank Li (9):
      ARM: dts: imx: add power-supply for lcd panel
      ARM: dts: imx6ull-dhcom-pdk2: rename power-supply to vcc-supply for touchscreen
      ARM: dts: imx: remove redundant linux,phandle
      ARM: dts: imx6qdl-skov-cpu fix typo interrupt
      ARM: dts: imx6q-cm-fx6.dts: add supplies for wm8731
      ARM: dts: Add bus type for parallel ov5640
      ARM: dts: add device_type for memory node
      ARM: dts: remove undocumented clock-names for ov5642
      ARM: dts: imx7ulp: remove bias-pull-up

 .../boot/dts/nxp/imx/imx6dl-aristainetos2_7.dts    |  1 +
 arch/arm/boot/dts/nxp/imx/imx6dl-lanmcu.dts        |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi         |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-bosch-acc.dts      |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-cm-fx6.dts         | 32 ++++++++++++++++++++++
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts            |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap10.dts  |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-icore-ofcap12.dts  |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-pistachio.dts      |  1 +
 arch/arm/boot/dts/nxp/imx/imx6q-prti6q.dts         |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw560x.dtsi      |  1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-gw5903.dtsi      |  2 --
 arch/arm/boot/dts/nxp/imx/imx6qdl-nit6xlite.dtsi   |  1 +
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi    |  3 ++
 .../boot/dts/nxp/imx/imx6qdl-nitrogen6_som2.dtsi   |  3 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6x.dtsi  |  2 ++
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabrelite.dtsi   |  5 +++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi     | 11 +++++++-
 arch/arm/boot/dts/nxp/imx/imx6qdl-skov-cpu.dtsi    |  2 +-
 arch/arm/boot/dts/nxp/imx/imx6qdl-tx6-mb7.dtsi     |  3 ++
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi    |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx6ull-dhcom-pdk2.dts   |  2 +-
 arch/arm/boot/dts/nxp/imx/imx7d-nitrogen7.dts      |  8 ++++++
 arch/arm/boot/dts/nxp/imx/imx7ulp-evk.dts          |  1 -
 24 files changed, 106 insertions(+), 8 deletions(-)
---
base-commit: 13863a59e410cab46d26751941980dc8f088b9b3
change-id: 20251014-imx6_dts_clean_2-0f830b578de4

Best regards,
--
Frank Li <Frank.Li@nxp.com>


