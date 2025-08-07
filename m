Return-Path: <linux-kernel+bounces-758549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C10F8B1D0B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E00D1AA2D1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279051F4177;
	Thu,  7 Aug 2025 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eS5SxRxU"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013018.outbound.protection.outlook.com [40.107.162.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE21A2872
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531290; cv=fail; b=NXbCSOJJqCZrilIF4fLIMGsjq5qtRIpo01tGvp5ynNZzbZRk/wxF9UT3+bGSLScryWhPmvew1g+CDiArf0TJdjni1rMuJJkj2MepiJEQPx66FJm2LSaUA73VEMxk1llPpMY/4hhdj1kNiwmdlQcTzRYLgvI4wFwadA5e/hrhX4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531290; c=relaxed/simple;
	bh=bwnlL1B3bwGzVJpot2Tei6wXY17ezNEeE82lRCjmN30=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=Osb88quJW+DTePd0k2Rpir9IoDwUG+aq/BO1A0db8ZDW9lwYbXx5Qkny35XlfnFQ0jOTFiD9VRQKwhhqxM47chcp+FZulrmjVG5WYDsmb5IvVl2N0p+goFtDMpsQQnOY47QX3Z+kQw2QwFdeBhxdz1Qd9Nw06cSUR9xzrki8jUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eS5SxRxU; arc=fail smtp.client-ip=40.107.162.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bCWq3cY1W5Ja//oRbqPUJGIk0jb4knKgYltJnaKdu+MqXveWIDVht8FN1WwsIpDuRZsfLF5hdbLjkRyyBKqVOUS2ZRq2Jc6AkMAbhmpbEtvbsa+FvZT03Yrx+rzQCLS2mJDOkXFKaK25VD3Q/vMt6TibtWudx93oplaf/UlsMG+rtULVGxtVPHC7TbnWvTnjWNHzI3DZog6DyV0h5VDxVLyiN390ppwO1ctPeilNqtacWqCzfjQnNeiv/7+s1nIqOfLi7uw6YnD9b7W3OQlOY3ae/6pJq3PgU3Jbnwyt/fsVrg+VbbhfcqOw3r4RBbWhkyBQmPzbbZogxddT0Bxg9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVKCfAoc4eQYKqo3Wa9MnMzE1nG84GhfZTk2c4Q4Sfs=;
 b=moyAk17uZutKR50VOtp9+d8D3YaWWALwYaD2IwyLRZKXEgYvCpuUHLB6zSrk7jF67SJZMIvTTzWl8gVbpUkhLx7lotpMqye3gtrzYgplxxXHlcm5Ycw/Cm6UgIiS8otGZZ+p+D0FxsRC5CEQxm+8Pi3C1184GJvipd9IzJe8Moe990RRWmGJISQ0zFbETbqcAfZg6vWGQR8cmh+NMwfET3JGxghrtpJH2Hf0CVvxh7PjrDg0Qht/8e1EKOV3zuX8vhB6QXEbQseC8kYdCekxi8Lw0qzzJHJUDiymCCoE5GL+aGxiZ2NgfC/MjG9eaLPG8wsZvJfukX5wWqKwe8iZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVKCfAoc4eQYKqo3Wa9MnMzE1nG84GhfZTk2c4Q4Sfs=;
 b=eS5SxRxUqXibHzgbmimsqKY9/0LhkA4kEsSHjhwBrdY4z+EqQiZf3c6i4Ww73Z1mO0CMcaYb5tOBRMByL0ZWLlcnpdjUpapSWdX9EZhUI15F1voNiQegscoSJB4m0zsVWHjDVt7ZtcxajP8rN9kCGy/D2bz1UH9lnZPcjtBytWcGAAdsJSGlB1oeyvwqCcnQ3bC+geOHT5l6hQBHaeO95G1zlRcew4c2GCiY/Kf0YZEbai59kFUIkYcxjB84QzMsm2wAL/Aow01K2TjfBT0WwiTxfCuLtwNCkNsO807xRxN5tY4C5DeaG9Mu+UQ20ImKVkN6TQWYjsnIQu3QyE+Flg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 01:48:05 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 01:48:05 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/3] firmware: imx: Add stub functions for MISC/CPU/LMM
 APIs
Date: Thu, 07 Aug 2025 09:47:41 +0800
Message-Id: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL0FlGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwNz3czcCkvd4lzdpNREA0OLNAMzAxMjJaDqgqLUtMwKsEnRsbW1APM
 FAcJZAAAA
X-Change-ID: 20250807-imx9-sm-bea018f06042
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754531281; l=1497;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=bwnlL1B3bwGzVJpot2Tei6wXY17ezNEeE82lRCjmN30=;
 b=CGnrsyqwx8/25BQC5SUwe1SE2Ss6ieaJXkJ4fvdMLdZ51MiAUXElpDgcdJtOYxkIvcuCaJUvw
 REx8itRwNlfCDCI6nFWursyMzMvW8ksDb4LymwfJsBUKvYARC4sFEIK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: 19dc09f9-1504-4276-6544-08ddd55473be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHBjUzNNeWFiVTFkaEVvM0FLVy9wSnZwalpETE5BU2RPazBURTFQRW1RUTJK?=
 =?utf-8?B?RXZPeUc5Vysvb1BQVDdiUThDWDhoTjRiUnVEZTZsMS95WUhucVNrNmVKYUdw?=
 =?utf-8?B?VmRKU29wK0REekM1Q0FVZmNZMnl4eWlVMVlJcEg1UVhhczBGNE9zaHE0SklD?=
 =?utf-8?B?SkpiRklLdFhGSDlQMHVUYlRFUjRzS2xoZ3dNOGRKRERBSEhwOEhqaWZXUnhl?=
 =?utf-8?B?d1hxdHdJQWptMUxrT0ZDcDNTVEEvTVVRZUp3QXV3eUpUUi9wYThTVDhrYm52?=
 =?utf-8?B?Wk8xSm9DTUxpR3hNUGtKVFozUzBFQmJjRHY3THpVUWRma01Kb3pXTzdqR2FE?=
 =?utf-8?B?VnlQU3hvRndDZzRSVFdSYlFNWTVnbitoTHk4ME1UTTN3emlKVUxXb2pIUm5y?=
 =?utf-8?B?T2VIS0w4c0x2R0s1VkdncDUyRko3SXM5azRTbjRZb2h2RXZNQmhPd25LV09Q?=
 =?utf-8?B?aVlQaDNSWFFXMjdnZmVHY0lFNUhDbnB6M3NqNGhOT0hJa3FMN29XaDM5bTcr?=
 =?utf-8?B?MzlvVFNwbWw5THhpQUFNM1l2Yk9JMlhBcE10RnZHSTRML0g2b3pmNVcwYitI?=
 =?utf-8?B?NWJnQmRKOWdZR1Y1Sm1TaTRlcjV6dVRiZTkwZ05sNXdlZGpWWHZsSXFlTmVY?=
 =?utf-8?B?SWNuMTcvTVRZYnl5RDNwa3RDQThPUHllS0ovQjBlemludTJPdW9TRHJlMFVB?=
 =?utf-8?B?WGYwNFFXandzajVvbS9KclZ0cUxPcE45cUt2ZU41VEpCejU2YVU5dnA0Z2lY?=
 =?utf-8?B?djRjY2owZmh1UWpaVFB2VFlDT2huNW1WdU1zbkR1NnVTWUo2OEI4RWp5SUpB?=
 =?utf-8?B?aVBodkZsUUxVWnFKaGFGMHpRdlhnS2psMVl5bDlqUm1STHJhTGN0eTUraDN6?=
 =?utf-8?B?Nit2VUg3bFlkSTlkZFVIWklWRHU5RDM5MzFLQXRKWjRKbUwyUG96UWVIbTFM?=
 =?utf-8?B?VGZOUS9JcU54Z0ZyRVAwOXlFVSs0S2hwOHNBck4wb3VYN2FIczFhVVlBVWJP?=
 =?utf-8?B?VG5DZU9UODlCTE81QTlVUnZnVjY4djJ0akgxMDY3ZHI4NUQ3R1BRQ3hWcXEv?=
 =?utf-8?B?MDRGNDM0d3pkbDlxRzRzUUZNWEQzYVU1QjUweUE3YWZ1Rks1dS8yK2dWS3Rn?=
 =?utf-8?B?VHNZcFE4Y2duTHlTTkRFZTFyUGFNQ3BldHB0UG13MkNPK3hTaXlOVnlvWlZD?=
 =?utf-8?B?QXVENk1BK3JYbTZXbS91WllvL2ZXZm1STDJCZEFYMk5XRzA5S091Zm9VdDFF?=
 =?utf-8?B?cUtIM0hJaEpJUnc0UExPdVlxUHNBL1lSZHJGMWZDWE1UaHR5VGxKVGJkRDBl?=
 =?utf-8?B?OUo2dHJqVUhNOHVWaVJRSk5BNDE4WWRDYUxYaXFSVWpncWlyTmowZTZ1Y0d6?=
 =?utf-8?B?WDkvaXd6SjBqV0F2Rk9JQ3R3OXVaaTdhejZldUZ6VE9YTDF5c29xc2RxWVh6?=
 =?utf-8?B?SUlDcjFSZWVBZ0lnMEt1Yk13b2w3S0ZGUldqTWgrK3p5THQ4TVpYaTg3cWhF?=
 =?utf-8?B?SmM5NUxadXNoRG5RNlp3QWtXTDQrak1oaTM1bVQ2MnE2YjE1VVZuZEkxNGxK?=
 =?utf-8?B?M2VNWTg0RTM2QWdzYnJDblNoKzlpczVuT09TWi9zeE4rcGxQWlhXSEljL2RB?=
 =?utf-8?B?VzUrbEhrUkhVZ0JEc2UwYlM0Zk5mOE5mUTJxOGdFNXlQL1EycytBTXhhTThL?=
 =?utf-8?B?Vy83c01QdnMrTmYyRU04dHhXZlpMblYwOGNyY21LeUlFajl2d0J6b1JZbDBQ?=
 =?utf-8?B?enRGUW1yQ1graHdlZTRDVUhDa2VRRnlCd3J4OG03cUJqRGdlYnVhL3psVDM4?=
 =?utf-8?B?NDE5c3ViT0o2Zm5BV0NuUTg0MXhoNGN4bkhHeHpLT1hVbUE4eGN0WmR5M0tM?=
 =?utf-8?B?SWJyUjI1aGZFOW9odURsdUlXK2tRbjdvbHNvSWV2ZWxiTkdjK2hFeTllTTVN?=
 =?utf-8?B?SFFjU3pFOGxseVEvbmhpR292aTd5cFNvRWFXYmxsNWUycGo5a2NBYzhuQnZH?=
 =?utf-8?B?NmpxQm5iZWZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXk1MFJQMW9Pdk9VSlJQY2lxYnJtMmtIUTVRQ3R3R2NMQ0VBWmdaTjAvb1BS?=
 =?utf-8?B?RjBZTWc1M2ZJcTZyZDBBTnJtcDhlZm1QM2drVUZ4SFhUNktpOWVTd1NoRzVY?=
 =?utf-8?B?U0pFdDk4SHY5eEM4V05KSVNBTEdhKy9GM3JYN0IwYlBYemxTM0xBZyt2L0pG?=
 =?utf-8?B?WVlOZ2ZPSjVsOGF6Y0w4ck1YdWdiWUJvVTVoM2NmaE4rN01tVUhJUlpTSzY4?=
 =?utf-8?B?K3NSSFZhdFhYSE00SEsvZFVBejJ0Zm1DLy80YkRXcWV1cUxQb08xLzc5TDQv?=
 =?utf-8?B?UDM2Tm1MdllGWXI3VDR5TVM3eEtUV0tQbkZVM0x0M3dLNWZPWmdLQmlFTHFt?=
 =?utf-8?B?NFcrWW41QW1FdVBhdXFRNEtTUmlTYzd4dkt0K0VpSGtoTUNMUk0rOEp4WDM5?=
 =?utf-8?B?QUh5ZXh0Tld2ZWZJN2pPMGZpRVAwN3pSN21nZFhReGEyMWxyNnJMY1dqYmR3?=
 =?utf-8?B?MVRzbzdCN2NGZ1ovT2oxMktUTUMrY0JpN09xTXlCUjgyQlc0R0ppamVqWjUv?=
 =?utf-8?B?SlhmSVU0Mkc0MERoWU5xZmpJL1NkaFlLck1NWWhjM3ZTeWw5OVRXQ1hVM2tM?=
 =?utf-8?B?WXc1cmQrRG1kUDNRbTJIR0FsV0NUVXdNbDZ0M2d6TUNJbjRKb1RzRUVIWkk3?=
 =?utf-8?B?eWpkYWVoZjV2anVKT0FYWjRKSThabnNkSHl6ZzJ0bm01TC8vNWR5VVF4dzFo?=
 =?utf-8?B?U04zNmxwNjUxQlZwbWFVZVFJa0lpTlpLSG93OVNRVE5wdnphd1plcG4wbE5y?=
 =?utf-8?B?WDQvK0tnOFBUL3B5NVYvV01pdlhmN3hwVjNUTHNBSXpzMUdIY0dzejhMMEhx?=
 =?utf-8?B?TWhKdDBsODFZQThJZktaWGtxSjZxVCthRUN6Q3h4dHVqOHRpc3JkMzU3WjFI?=
 =?utf-8?B?c3JOTFRFZ0xUaFE5SmxnOUdvd1F3LzBlcmdmYStUQkpNOGdKRmd3TDhTRkxJ?=
 =?utf-8?B?bDJqUXhzYlE3eThFSndxUTRPTDJXejMrYktCUVRValhJZDlFZEcxVDA4eEVE?=
 =?utf-8?B?VUoyRUpNMFFycXRncktCMlhCRFA3czJPMG5raFdPTFJocVpDYnVFc1UzN2pw?=
 =?utf-8?B?ejM1Y3QyWGJUSHoxWHRPeDNaQzlReHNLQmpWc1JWWDI1V0hoZTVYNHcvUTVG?=
 =?utf-8?B?Zm1rZmgrUWRDMUFqbm9jSU5CVS9KQURFa2N5QXlPbndZcGdaZHB1bHJzc0da?=
 =?utf-8?B?QmtSajlLS2hydjB2U3FhVEsyVmhaTG9pa3F5ZHlFWVBTamswZkVuVXJ2U3NI?=
 =?utf-8?B?Uld3T1N0MC9pci9hSXFtNkl3WEs4SnZRM0w5T0xsQjRkNnNEZnp5MlRmSnhz?=
 =?utf-8?B?bFNHTStZeHV5Wkl2UHRjakZmQ1h0QjBHNnFDMFZ6NDY0U1FndTNSZlZ4T3dZ?=
 =?utf-8?B?UUZJVittUE5BcnN5dk4vcTkvT0lxQSsyV1NhM0x5N0UzaXI1b24wTVFqR1NF?=
 =?utf-8?B?Z2gyOTBkSW9KbnQ2dFovS2V1b2JpUi9uVkFhRHZPVG1ab09zWjc1aUhZRkJD?=
 =?utf-8?B?WHM4bHhiMDhYc3dnWGNNQ3dVUmlZeUEvazVqVEpIUlpDelFadm1LWFBBclJ2?=
 =?utf-8?B?eXVQTUE4Zi9Bai9kMGtUZjhlZW5WbUpqbzU2ZXpLVGtiTTlmRXF1cEhaUzdB?=
 =?utf-8?B?VjZTYVQxazNOcEJzNnhzanBlSnY4allweFdQN3EwZFV2d04vcjUrYzBGVTVU?=
 =?utf-8?B?dlQrODlRUUQ5VG13ZC96SHFVZzFMTnVyWmVKZStYQXdlbVZKSXdiaGYyeGds?=
 =?utf-8?B?dTQ2dEZHNHgzOHZFS05nQnp2SS9aMHRpekJpR21tUENpeHdpSlhKN0hRSE5Q?=
 =?utf-8?B?dEdCL3pRYUJHSlBlYmRmK0ZYZ0o3V3A0cEhsOThHc1JOUWhUWTRVUmJDVUJw?=
 =?utf-8?B?bXBkUXpVdHg2ODZUZjNmN2h0S2VBYWQvQW10QkFJZVNIdVliNGJTdEhnYkJw?=
 =?utf-8?B?MHhtWE5ReGFBS25ENTF4YUQyM3dhS1VxazRPMG1SdEJQemVmTFZaNmIyb2hp?=
 =?utf-8?B?c1JrRXBBV200a1FjbEZQbjVEQXh0emNscnN0RmFKbDN1SlhtWlpydnZXbnJs?=
 =?utf-8?B?L3pLcHAweU5sS21kRWFOZXJsc1crU09PeXRIOG42ZnJMTkU4T1FiQ09FTEtx?=
 =?utf-8?Q?nq8ES5C6KULacBwqBSfZ8eaGn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19dc09f9-1504-4276-6544-08ddd55473be
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 01:48:05.3490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTQd9d82cogcxeAultsrSmusEZvrWGTnIiG+JkmAEY6h7f4aVUUMafF3f0QM2Vkh1UXp5mZljE03VivqOZi5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

To ensure successful builds when CONFIG_IMX_SCMI_[MISC,CPU,LMM]_DRV are not
enabled, this patchset adds static inline stub implementations:

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

The initial support for SCMI MISC API was to use CONFIG_IMX_SCMI_MISC_EXT
to guard the API. But this is wrong. There was an commit [1] that tried to
address build issue for MISC API, but the better fix should use
CONFIG_IMX_SCMI_MISC_DRV to guard the APIs. Because when user driver
reference the APIs, but CONFIG_IMX_SCMI_MISC_DRV is not defined, there
will be link error.

This patchset is to fix the issues for all the three drivers.

I add Fixes tag to the patchset, so I not delay the sending until RC1.

[1] 540c830212ed ("firmware: imx: remove duplicate scmi_imx_misc_ctrl_get()")

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      firmware: imx: Add stub functions for SCMI MISC API
      firmware: imx: Add stub functions for SCMI LMM API
      firmware: imx: Add stub functions for SCMI CPU API

 include/linux/firmware/imx/sm.h | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)
---
base-commit: b7d4e259682caccb51a25283655f2c8f02e32d23
change-id: 20250807-imx9-sm-bea018f06042

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


