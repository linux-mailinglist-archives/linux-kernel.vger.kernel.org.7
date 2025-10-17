Return-Path: <linux-kernel+bounces-857715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0695FBE7D63
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0B4754462D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A772D9EEF;
	Fri, 17 Oct 2025 09:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kH8Qq381"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232312D94A4;
	Fri, 17 Oct 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760693137; cv=fail; b=cn1JjSgKIJVPyi0WU2z3IGGrOHlj1wAJYt8H9g4Bcx6WsWwXtGBLuAVOvc0Mys+jvqFam/qkLsKy6uNt2ISelwTEjg3xA2JuIzA/Vv5f729bLLhOELKpVVsph8wmopOIqgofbJMmUgzs6lAlM6XDcGdN2sgL6jcHGsDafl1BM24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760693137; c=relaxed/simple;
	bh=5qqM4nbqA5huXy0fcCRNJ1TFs1W8pVgVQGQCkn3T3+w=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=lM/7u17fT4+ypEPeXr101/7ZU7T4lzOR7uOlXmL8uEFsmJ82Dpr8KQNoJDJGtG7Cv8M1M5D5ubBYoSntmGA60jsHCM5setqjfIgkAtd89fFxzYbR/bJ3+hXqY/SGtFryPzVgaGYSJNfsQFiPgS00rQosvSQoXRwWh3yTe0cktUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kH8Qq381; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CWqfnq9TQEagr0bpOfUJ3JDegExJtweDZSV4MWfaejV5nxxcSdhtsb5vnBwSnPKl/MKu7LzmSgJZK1MkbUWlijPxIzOZE23qPzWTwwZ/HSH4yfpS8x8Hl1itwBPCsdTRekNYgCeMGqyzgM1GdDXQXCcLNMBC3yIzeTrqtC+oEaAxqtlTdwn2tiJgv77RzA39lInX2Jylf05IRqcEqYXHVl9lPtFOi7YydaPy2SsePqNyFh/4o9I+ghw6J1Tn+eWc0x2X3YmoumDXh9t7fXokmiOHQNxi60+322ezjPUZbY5N5eQ57SIwDuCEoG+VMAui20LgPC64cyVlhM2OHXHMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2sHttU71lqnmYYlJ42O/jlTL4u4rYfdL1Q/zpVNx6mU=;
 b=fTHMI+iLPoNGRdCmQVwk2p4h+BSelBVx4PhnVdzbF5pKJ4yJjj5H/bPfymCUbUdOqvQhNgz3Q6fYb3Tpyo66kwN8YQgXX2MkHu5tzjBljJwZKyca7Li1OabfJNJNpIfqRA7QQFRlGmIfBYOvw03qi+UYQb8El+8i37d8lZwQ5lurcfMDxCSu/hwlMzrdwj6qXbGx81iydMuPN/KiFPtmxP8doEhR7A4zL9gjMi0/l4w+JzEKKGZ4bccLv5nnUO+KiccZFakv4Tr7P87NhejC/L/yhtDeIZ189CZUR9Us1flBeRFUmuBCfxe+MwMwwuoa7YVUUJJiwagMeUiOkPCYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sHttU71lqnmYYlJ42O/jlTL4u4rYfdL1Q/zpVNx6mU=;
 b=kH8Qq381zIqB5ZehyU3zICBz/e34Z+C6fHCe90LJyPb/oXeL385VdmTWqicbK1vRfMKpTQH44CzLcmcyDXbefcVwYkWjDYlYny3yHD3c5k39rXTXvzddaN3q4YG+ai4SczoCP/4YgGfgRlS4auLDt+byxaJa5OZ+JDrfvwmaojKWUzzBeOl81djdUoMFmm7W0rDU8hVeflE5Vz5HKML1xM06QhnubT9p6bqpiN2i6yoReDNrmbPlOsJ1WXiCyJZ7MnXk34JENYFBx9RnZYIPKCia0Yjd4gYHRvyVxoCCtQq0F7EAzwIKNbaqihM31mxrS21lQ367mWNnBYNjYb9Gnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 09:25:31 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:25:30 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Fri, 17 Oct 2025 17:25:41 +0800
Subject: [PATCH v4] arm64: dts: imx: correct the flexspi compatible string
 to match with yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-flexspi-dts-v4-1-330fc467f489@nxp.com>
X-B4-Tracking: v=1; b=H4sIAJUL8mgC/23MTQ6CMBCG4auYrq3pf6kr72FcFDqVJgqkJQ2Gc
 HcLGyFx+c3keWeUIAZI6HqaUYQcUui7MsT5hJrWdk/AwZWNGGGSGKqwf8GUhoDdmDAT1le1qr1
 QFSpiiODDtNXuj7LbkMY+frZ4puv1fydTTLCiUmlvVHnKWzcNl6Z/o7WS2V7qo2RFamDWSOCNF
 +4o+V6ao+SYYiGc4BWhYEH/5LIsXzvCb4UYAQAA
X-Change-ID: 20250916-flexspi-dts-24af8b6bf468
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michael Walle <michael@walle.cc>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760693164; l=2586;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=5qqM4nbqA5huXy0fcCRNJ1TFs1W8pVgVQGQCkn3T3+w=;
 b=PRnDdsYhPQQ5LXKBFglpYyCvR18W54DUdqm9g2UuMCRgJ2tSmn5rDVOj9wWYImbgHw6W7uJUj
 19ycNpAVUqHAF4Ms869I3/wGOlfmUB5vYTH6nVBAwAR59xrIEpCvF+A
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR04CA0190.apcprd04.prod.outlook.com
 (2603:1096:4:14::28) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 0761b58c-d84d-45f9-ff40-08de0d5f1d76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFlvYnJWRUdzYXNKeGhtRnh0bFBTblMzeEowV0hjQmJIbkpBWWNTT0pvVzl2?=
 =?utf-8?B?UzJxK3pTZlpJOUVkemV4d2hEWUFuNmZQOENnQzQ0S2phdHMxNFg3Slc2YWI5?=
 =?utf-8?B?S2xuLzRQYjk5QmZoNHBPQkJXdzc5TEM2VTBHbmdqWDkxOFRJVG9wUFd1SDdB?=
 =?utf-8?B?T25pbHNacjRnKzhiNEZJUzhkK0RVdGhiUnNRdHJCNThVU241T1dXdTdiTTJF?=
 =?utf-8?B?ZG9YOVJXUlBjK2VTQkQxb0Z3WmZzT0FkZjVrcnpGemQxeU5MalRTTGZLM1Fy?=
 =?utf-8?B?Wi9YUlZkN0xGdkt6eUlTT3lkc1M4V2NrQjZuOE5hWmVWTmRWakNFNDR6Qkkx?=
 =?utf-8?B?VVF5UVBhdjZ1QUMwZVd0bFBsM1F4VXhneGYwTTBxSmhFN3hWc1BBaGxjenhU?=
 =?utf-8?B?cDhrVGhOeHRVc001V21oMVBZeW5wK1ZZU285ZmdKUDBqR1VqdkRLa2FMWDRN?=
 =?utf-8?B?aUxNSzFiU1ZyQ2MvTnUyM2JkaW1CWDZTOGRZSUQyQXBPYmpUZGMrUjhlcStk?=
 =?utf-8?B?RXFoR3REYWJnNUZCVkxXMXAvdVZVKzhtZENEalFkSE5ZQWpnN0srZ0JRYTZN?=
 =?utf-8?B?V0Z0eEl2eW1ibHhFK0F2L0V3TUVTRWNlS2JpWld5SUhQNGR3RFF5b1kvS3Bu?=
 =?utf-8?B?d2VNRHdYZXQwTVNTdjZnNG9xRFhDV3ZHblErclVnWkhjazN4dnZJTGhLaUda?=
 =?utf-8?B?anlRWVlRNFlzYTNXTkowT0dFSkd1bzlmZmFYMVdldmNlQTVGSXRHYldVVHg5?=
 =?utf-8?B?bitockkwZmhyWnVEVzQrVGZOTGhHanJ5eWZDSHVtQ1ViU0ZOT1drY0o2UWY5?=
 =?utf-8?B?eFdXMlc4b0orUVNqK2IyZFVBL2t2djhNdXpBdmh5V1dZZ0ZDSTZ2ZGlJNnVw?=
 =?utf-8?B?bXgxQ0g0OEZyUTlKaS9jeHF1VWFIcm1tbUhPNTVNUFZ3ZnRpc05xQ2M2MXRX?=
 =?utf-8?B?b0tjRUZnVXZrOGxteEdYbThDYityVlB3bWVFR3pUSWE3Vjdkd0RYa1pTY3J3?=
 =?utf-8?B?SHdVeTZUbmZqWjUrT3JBNnJQTkZYdEJXUzFnekFuS3ovQUd6dFNFOEFpOVVI?=
 =?utf-8?B?SGlGN2R5QUhmMHpMYlpiMTFTZi9CdTFrWkhZclpPQ3ZzMGZ0MHVua3FmNDlZ?=
 =?utf-8?B?TTE4c3ZiRGhzbUVyQ0ZYdkRTci9NTnBPMmdleWR1Y3BndHZob2dKVlhtRTBT?=
 =?utf-8?B?bXIzT2ovNFVRTkpWRU14azlxcWVXZW1EcjNHbEpFcE04N1V2L3IwWDF4M1k2?=
 =?utf-8?B?cGxVU0dzRS91bDh5czIxcEdTTVlFTnk3NnhwcXd1WitQcVlIL0NZUkNZdStq?=
 =?utf-8?B?ZW14QkxtUFk4UldUcUlJMEdyYTBvcTRPN3hnK3N5MnVsQnVDZDVDWERNclpN?=
 =?utf-8?B?NDg2RmRrN1pLUVh4bmQvQTZlU0hiR21CQVBMSW80dk5RMllRcU9hZDdpZDRD?=
 =?utf-8?B?ZGtLNUhZR2lxNjBqQVZORnZ5OEpYRUt4U3ZoVWxOUzdMWFpFNlVweFJzVDI5?=
 =?utf-8?B?K0tsNEZMN2c0RCtOWUdQNHFMZWh0Q0RGNUNQcTVyZ0J5SEIwc3NKTkdOdDNE?=
 =?utf-8?B?K2R5SGwvcEtLclZ5WHgwcXZ2THB3UmRWM0ZId0g1QW1CWmpRQ0hucFZXeVJ3?=
 =?utf-8?B?aG9XWmpWNlRYZ2M4NzBtTFgrYm11bXV4L2pGNlF5V1pqR2E1NVpNeUZ5WXc2?=
 =?utf-8?B?QkRPbEhiOFI3R3JTaThsMGcvRFk5Q1RoSE9mbUtyVTRWaUhCNmkvRkdURkls?=
 =?utf-8?B?QjV6U2dTS3Q0dHNpMHA1OXZlQ1JLSTVOY2FJV2JNWWNyejNIWEM0U2xUTEFR?=
 =?utf-8?B?RlJseG1YbzlLTlVTb1RjRWJFNmFEMFlXZGxuRSt3WFh0b3hVbExaVzl5ZUlO?=
 =?utf-8?B?UHFvbkl4TVNBZ1ZFSFJsbmhRSlBFSkdHaHpCeUhjMmk1Z29HNm1LamdpK3Iy?=
 =?utf-8?B?R0F4c0c4THpOa3N3SkwvUitySy9KVmpPeUNhV2Y3RDZYMXhLY2ZmQ1E3MGdl?=
 =?utf-8?B?RW83OEhFeHRWZUo3RVpvbDQ0S042TXp3bWhKdGQycmF0Y3NRUzkzS1lNbmpO?=
 =?utf-8?B?WXRSbmtyN1lXRUYwYVpReW9OUzRzRXlHUDZQQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWxuUXdhQXpta3E1U0NPTzg3VDRTVVBCYmJpRVkwekRxZStJUnFvbDFMYXB4?=
 =?utf-8?B?WDVNYktocVNFSGRZb0ZrTTg3MjFueUY3cDVHbko3RmwzZzhjUUtVd0JJcVB3?=
 =?utf-8?B?VjFrbytpNGZpQktlbmYvMXQxamxhY2NZVjkwejAxamFncnNmK2V2Rlo4cWRz?=
 =?utf-8?B?OXB4RnpvWmlZTEZDYVdRUHhRVmwrTVFBR0xidW5Vcy9OenoveHZ5bDJoL2Q3?=
 =?utf-8?B?TWEydzhiOU1ldE5xZC92Ty9lWGlEYTdxWWh2eDl5VFBlNGtDOFcrUUpMZElQ?=
 =?utf-8?B?QzlwWVo3SW01R1lnSGlZWm1iKzAzTVNVQS9na3VLN0NPM1ZXdjNqZ05ma0M0?=
 =?utf-8?B?Y3FzSHZQaUF4UksyMlVWSnk2MENOT2h1a0ZtTUFDS2JuRDRvSUhSYWl3RnJW?=
 =?utf-8?B?dldIN2MyRzN3Z3pBZ0F5aStSaW1SNmVqU0l2Q0xDNnpKcTNaa0RUMEovUWxo?=
 =?utf-8?B?aGdZd2ViWWRuZitrTEo2cTFVTEhMWVFrSG5PVTN2c2ROWm9BYm5tdUR0VEgv?=
 =?utf-8?B?TStGS1FMbHd0bitFN2txWFJXQnlXc3d2aWY5WUNPODlocTdWYVlsQVBzQzRo?=
 =?utf-8?B?dUxOZ2xOa2NyZEJkU0x0dTdWMXIyd0hmUm5qaUt4TytNSlk3K3VvYVhjWEor?=
 =?utf-8?B?UmJna2lWZzByY0pVR1cwU1JSU1FBaVBmM3R0YS9LRDhPWWRkekE4VFE3a2da?=
 =?utf-8?B?dVlyVGFlc052aGZ2OGU2VGlOVktFeUxTZ1RIZllmR29wajJ4NU1aR1hXN3hZ?=
 =?utf-8?B?Y3ZoS0xJc3RCa29vUXd1R0cwMUVOQUhEdjdUeUo0b1liTHNWL2ZhOVRUZkpt?=
 =?utf-8?B?QUZxRjM2V3l0TFZ0N09HWjVlSU13ck9hdDh0NlZFNGg5aEowVzZ1ZFBWS2gw?=
 =?utf-8?B?V1E5WlFUdDJjalN6Q0NUbkpGYjRWK2ZCNXp1UmhLRVIyRklCd3RRQnNPYTBG?=
 =?utf-8?B?UDM4WnpmRTFpL0RYWFZJT0IvYTE2QmI0eWlvNG5CMFdOQmgweXVxMVI2NzdI?=
 =?utf-8?B?QjJORGhZNUZ4c0JtZUNtTnlBeGRqY1JZdGRsWjVHVkwzQTNlZ3U1Ull4ZFpK?=
 =?utf-8?B?bVhlZDFra2hrQkRYRm12SVRvTEdDSW92MERxaWR6WW5SaDQ4QlJuWkxpa2sr?=
 =?utf-8?B?UHBHRmdnMWxEOVpMNVM2b3IzeTJNNlJ0eWM0NzRoSU5SSmJyQmM1OUorbnpH?=
 =?utf-8?B?OVlFZUE4bkdqRDBLTkhUZzFndnhyUDhaS2J1Z1VZZFEwaVFaNmQ1WUQycFVQ?=
 =?utf-8?B?UnozaHNhanJkUFZxZGtMRmNPQmNNWnJLL2MwRmVhWGZHcXpvZ2NsVmhjVDRG?=
 =?utf-8?B?MkhkRGtWc2VPVHRUZWhoOUtTQnZjdWhxdEFjMk9LQlljcVFiRjVPQ01JdlpV?=
 =?utf-8?B?bVhQWmQ4dlAyN3BLcHFWQmMxdVAxdE1uNlZwejFjMUY2b0lMZlB5UEVHOUhL?=
 =?utf-8?B?ZFV1Q0F5TTFjK3p4R0F0dUxMYW5Ubmhyc0lwTWYyVEQyRkRrR3ZnYjRlUGhX?=
 =?utf-8?B?cGo4N3h3SEpKSER4N0JnNDQ0WXVsZHNtSGRueE01Zmk2eGNLbkd4WWcwV1dj?=
 =?utf-8?B?WDNhSWdFbzJoUGoxS3FDYlQyb2plemVtZFFaME5qV0hTR0FaalJyajIzUzFm?=
 =?utf-8?B?MDRRcWtDVkdlbUFwcHcydVZNSDd4cUJPK0FqK0U5cFRPZ1NYa3ArYlpXU2lU?=
 =?utf-8?B?SkNJL3JUdDhKRENwWXNaNWE4YkdYU1hRLzRMZnNrRk1JU2tBVnBlbitXL3JR?=
 =?utf-8?B?ZE02M1dGbHR3a01SYStCbjNDU2VuYllFYWU5S0RtKzR4WUNydXFZQkdHcEw2?=
 =?utf-8?B?TWFjOVFoVVR6NTlVSVE1OE5lMHpQeGx4YVRLcnJaN1VldXQ3OG81Qy9CTkRD?=
 =?utf-8?B?bVVRUDFDMlJ1M1czY1M0R29WcVFtOVMyS0twT1AydTNxWXNKTFM5bkNCSnpj?=
 =?utf-8?B?NFRWcmlwdTJQdmxpR1phU1ZoKy9Jd2lweERBTXhSamJqclNaMHVMOEsvazB5?=
 =?utf-8?B?c0lPdHhRdlRDQmdNeFl1TmlHTWF6SEp6Z3FTUFFBVVFHMk52d1UrYTByV3BI?=
 =?utf-8?B?WU9oSi9aUjdJRVloWUZHYnBzd01PWFh6TlR2OExZWWlVYWFsYnhqNFJ4ais5?=
 =?utf-8?Q?hUwT6L7tvZNmtR56Ze8DmTmUt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0761b58c-d84d-45f9-ff40-08de0d5f1d76
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:25:30.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0qkD+CaigPY+nEkgRZpNHoQhdSGQLQnVNW+n/dVN+HbWuPJGpWTB89gpkIrcWfX2Ve0PDeTPBNXV/ckGpX8NQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533

According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
imx93/imx95 should use it's own compatible string and fallback
compatible with imx8mm.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
PATCH1 adjust the compatible string to align with yaml
---
Changes in v4:
- change to add 'imx' in commit title according to Krzysztof's comment.
- Link to v3: https://lore.kernel.org/r/20250919-flexspi-dts-v3-1-44d43801eae7@nxp.com

Changes in v3:
- PATCH1: add Frank's review tag.
- Drop PATCH2~4, according to Peng Fan and Michael's comment, need to move this
  limitation to driver side.
- Link to v2: https://lore.kernel.org/r/20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com

Changes in v2:
- PATCH1: small change of the commit log according to Fabio's comment
- PATCH2~4: fix type and split into 3 patches and add fix tag accordingly.
- Link to v1: https://lore.kernel.org/r/20250916-flexspi-dts-v1-0-61567f969165@nxp.com
---
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 52da571f26c4e8a2703e4476b5541fa7aca52f10..7958cef353766a430df5e626ff2403dc05a974b1 100644
--- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -706,7 +706,7 @@ flexcan2: can@425b0000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx93-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1292677cbe4eb8c5f3ec2874a17ad6efd0111192..a0ff7002be9fa0529ba5712df4c056c56f0e3242 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -945,7 +945,7 @@ flexcan3: can@42600000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx95-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;

---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-flexspi-dts-24af8b6bf468

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


