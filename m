Return-Path: <linux-kernel+bounces-856547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C669BE4739
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333645482C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFBC32AACB;
	Thu, 16 Oct 2025 16:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QBFVGOVE"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F132AAC3;
	Thu, 16 Oct 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630456; cv=fail; b=B/EgxhMi1CiaEArttjJVfVtX8ZYYcJoe39vsqLpAuf0XeDcLHwkOnevfaCRdnOVAnK6HE+9VxEQNQAo2lNlMEYsRLylp453vkii82Sm7dcJjAwGCdbanSM8CQNyqbJwRM5Mkj8HMmGHdS3hdK+uMwGyQTUz3SbSy2izblzNfmLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630456; c=relaxed/simple;
	bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BXMWgT9BNjSFvUUo75+JkdOabPNlfHNHNxncMIM/Vj3zBkdusxYTaLNhN1QLDiYsQEw3A8gRa8P9Ogp9ls0dut8rZzduWdCa3PCMqUjREO/DKoabJha7nV6S8AbitfZ7/ZLA2JvTctkzanRWpqYLSr0eTakYpBDlefHHC8rMS1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QBFVGOVE; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgkruvJ9vzJqmNmUyHDvpmUKGFEZq86u02Es2KZN875Acx88yRReNG6y4n34CNe1v44SgueQOPFJXHbbqvY1U0PS+niXVZInELKZrcM76u5LzZ4eZzXmzk55AV3pk80iNytxCI79MwUBKF3nnyKLREy1a/HOoUYqyxHWDndD5W5hbpTuH371wz0iqg4P4ubAT5xI++DZ2eU1prF/IXINN/aMBT+UzeaRn7pMk/VccAV/OvZSHQkhSa7h3E4UpWCFjA8O5cDNYVeYy3X7htB5CnKGS06++/6+degRBMXXuhWszqqXMr19/9LXZ77bStypf8bXAUY9K2w5rPsG26qO+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=n+sd69pBToctcqAyNfJ6bxwEyNH3QW41/a0eIJ04qQvHHDRrvlFcCjHm3grc5pfUQ9R3oKY8fzqYqr+BCGut8SETvHVKNHcxA71waVTngwBEv/SaoDUhl3mYzzCZ8z5w7rJuDzBbLw80leeA/RqpolC8WPyE8dio3JCthL9rOO3SVxRi24X5GbzZH0LbKSizioWyRklqyh6DVc02xal/AIl63jay9f5qmRrP86BPQvFwQlQiVZXCcUip2r7IFC+e8uyNwM8AxqnB5vv0YwEml05QzSuT1pL/i2Siv82htv5B0iAEQg4b2QButi+lFwEvHrmLprMxmQqgAt6nUxkCgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3IlXN3dlG+tELTbPs8SlgWOIT5/trZS+4l3k9L2Y48=;
 b=QBFVGOVEFimJPs2EV7NhNrurKBdW1fORD1v+1KFcncYZmTpIwS/rR2zXwJrMqi5N8dOjQ0/KWlQJCBV9kC/0HTyMEFJd3FCZMIO+LAepMtQExdpHbNx+S+0YRZUOFjW3ewIVfOCLIwxIjV9sriUjCTth493fRzTH2OkgNeoHdXg3D1PorM3zABCqi0s0j5i/5HsVhHwPc6Nh1ppxABWoeMgvPrfPQGmZK9CnIZEiWfXYlK321RROUZup40dFMIrFzFeoi1YQvv8YOxS355ak6spM1nPot51R0du2FqJYotbqdcqFhtGy2aaJY0uO34omUqxRhc2e5lbWsroMep5yGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:52 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:14 -0400
Subject: [PATCH v3 10/11] ARM: dts: imx6ull-phytec-tauri: remove extra
 space before jedec,spi-nor
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-10-baf2814f8a15@nxp.com>
References: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
In-Reply-To: <20251016-imx6_dts_cleanup-v3-0-baf2814f8a15@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630414; l=1012;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=diM9UTCgcTMSY0BE81fzrRqIHpUjJ/cuzQKi2kUv5jw=;
 b=COA1AQgHLXCEHdkM74XvywABpZNDCCPThy5xMbNJijlsV1U4bsMcUOt2xuCgDTjd8VggCpt1c
 upIJcSF9EUzAjyU04ApU0WtuznSUbwTGejQb8IMbJENfoxk5/tdQwO/
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0034.namprd13.prod.outlook.com
 (2603:10b6:a03:180::47) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: 1429d980-612b-4a81-8e3b-08de0ccd2ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NDdkZzQ2dW1sT294ckgzaUZNZ2hCRThRMDRYUFZHaHJhb3pENm4yeUFMUWtB?=
 =?utf-8?B?ZGNjSzgvZWRldDE1V1VxRm5ERENDNjZ5WDBlMGRXSGl3L3Vyck9ERTJCWWZQ?=
 =?utf-8?B?dDdKeWpwY0toYXptUFJZQjRUOFdpeDdEVlFnaVdFa216SnRGUy9jQkRXWjZH?=
 =?utf-8?B?dXlLZnRMa2JXY0pkMlJidTBJQ0NuUjN2S28yZko0dWNnaTZyclBWNzFtZkZv?=
 =?utf-8?B?eXk1U1lTQTlHRlZhY3hRS0FpbDhpS0o5cUFHY0ZyZEZjSG5qWTZqdEpsUy83?=
 =?utf-8?B?dmJQN0gwR1poTEkwbG1rd2MrVkI5ZlR4cTVRMmZRM3Yrb3VSN216aEdHcXl3?=
 =?utf-8?B?TEJxcGdJVHVLdXJMMUkxd0xJUDl4emlLZThsdGJjcjRYeTlKbXdNbTdyY1J6?=
 =?utf-8?B?c3FyOHF6L21zZ3pWNDVSd1I0RDRBd1YyNEorZE1SRWlyaXo3dGxqd0dva0Jo?=
 =?utf-8?B?cWdUSFg5Z01FTTVsU1lBOGNNeEN5NnRPTWd2N05mUGVKRzQ2aVRSR0w1UEdD?=
 =?utf-8?B?L2FXQUdPM0VLdHFFdHNxY0JPVmZhVE5peWV3b1hNbDlEczltUUZWbHFOeFEz?=
 =?utf-8?B?dmFoYS83dGJaMGt5WlJMVzVBS0RDQVNXSXRhOHNnUnlqTm83UHY2dzJTZVR6?=
 =?utf-8?B?cWV1Q0FHMGNhQWd3TVVVSFJMQXF1MTBjWUU4eTVCQkxVN2wvOEdFd1QwUkNr?=
 =?utf-8?B?TngzMzZWMSthRDVsYzhsVlArLzhaVFBUVGtTVnd1a2VBeklyM0dScDNnbXYv?=
 =?utf-8?B?WUVpdXkvazBWTjRXbTl3TVEzU1hEUmc3cFcyUFkyOWY2clZJNm9vZjV1K1dV?=
 =?utf-8?B?T2Q1L3RPSm50dGZtOXdpdXVvaE1KcnZpZEV0OUpyemdZem01QUd0dklPUWV3?=
 =?utf-8?B?K3ArS09YaktsTkdmSXNtK2Rkd0J2V0xXNFlsYVFWT0hnRytCTE1LRFV4dk5E?=
 =?utf-8?B?cjN2UTA4YzBKU2ZTU01WaHdmYk16OEpVVy9rUDhZYkx6NTl3RWxDNVVKVXZs?=
 =?utf-8?B?Y292Q0FPMEVkNUR0NzBoT3o0L2VubjBhU0FCMHlVYU1YdGh0L0JtK1ROYjgz?=
 =?utf-8?B?ZXVOS0FNUnk4ZjV3cDhRN1RLVnh5YTUzOVVEUTdxdTh0b3N3Q3hlK0Q3SWFD?=
 =?utf-8?B?TzNyM1RuaHRpdUJHeWlCN3FDK3J0UEJnY0gvajRtNWxmNDdMWXJNWVZkbEc2?=
 =?utf-8?B?c0tqbS8yWTVqZGZYeWlBa3Vsa0xIYk9sSExmKzVJb1A1MG1PTDFsR2VsUVZx?=
 =?utf-8?B?MEUxajZrclZZUGsvQW50T21LQUhKL1VJd2dNOEc2RWpSU1BxVUZkODY5Q0Mz?=
 =?utf-8?B?Nmg3S1lOOWFGbGFrRjJ2b0daMW5GV0Z6VnowYUJvSEtwMXZuUmM3V2dKcmYy?=
 =?utf-8?B?RTJMSzFjQXc5Ym1nYmtCVDUwVFhFTk9zK29wM1pNYnM0VjI2bzJkTWY1QUQv?=
 =?utf-8?B?ZnFpVGdoUlAyNll1QjJVWTdKWll0a0FrSjdmV2p0a1o3Y0EvNDM1SzFlWFlm?=
 =?utf-8?B?MkJQUGs4QUxyWVdPN2d1RkwvSDI1THpURXRNcGFTSmQvZVo4Yzc4c0ZXb2NN?=
 =?utf-8?B?eGhxNDhmdS9QaTRlTUphcmFCZkxLYlNPMkNTNTRpdVhralFPcHJudGRzcGpp?=
 =?utf-8?B?bzNhdmxMeGJtcUlWVUVyOVBuZjdFd0g5alpvL1h2LzRkMXpIWitXZE8xY1RX?=
 =?utf-8?B?MDZLWElGRlU4Z0JNR2lJSWNVYjE0MlZpTGJzT0toZzF2d0RJSDhOR3RSMFA1?=
 =?utf-8?B?dHNCRHl6aGU0Q2M3SzZyTXhhZkg4d1NaN3pRT21CNjl6T0RLc2NXNFhPVmNE?=
 =?utf-8?B?d3lMVDJxdEtkeUFraVpkMWRLN0QrM1RTRTc3YnNMSTMrNEdpNnl3SU1NZnhP?=
 =?utf-8?B?dnBSVVYycFdCRzlNb2xuN09MdkM3YXl3aGpFZHpFQ3E0ZmxOMnp6dDYzZkxi?=
 =?utf-8?B?aXBmdzEva2NuQTN4MDMxd2h0Nis4b29HWU9oUHhMMEMwRGRuMEJhZnltbjhm?=
 =?utf-8?B?aTJDM3gxWDc1VkJJL2JjM3hMUTR1ZldqWjB4SGhwdWY2MUtSN0h2bUwvVU5H?=
 =?utf-8?Q?9t6HlV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm15ZUV5cmxVZStkL2EyY3hTYk8zVzNhTTdod240MUN6Yit0YXpFK2R5WmFP?=
 =?utf-8?B?cDJ0RnBXMWlMc2l0SUkrQ1hwRWdLUmxEQktsYjRaNFNZVTBHWGh0bnlOdTZB?=
 =?utf-8?B?Q2NlWnc5VDVxdDVKN2xZdGgxaE9hMnI4N0gwRS96U04raUZmVExveEZweHVX?=
 =?utf-8?B?R0dkc1lRTzN1cW1SQWlJQ25NUnU5WkR2UTVXb0ZNMWVFbHEyOUxDeEtMUWto?=
 =?utf-8?B?eEI3d2ZIeVVENkNic2NWakJXcGJtcTlTc1ZjTUJnNjdWUUJiUDRhU3lyYUIr?=
 =?utf-8?B?TzVuS0owR2pVcmVqdkFsY0dPRWlZN2xTZHIrN1hTZGk1RUVLRU45WlB4bU5y?=
 =?utf-8?B?S3lzRDJRQUJVUGdia2FDZG1tNmNocEliNzJtVGFSbWxsT21uRlBlTEZCTXNZ?=
 =?utf-8?B?R0tUVmxGUXoreG4vaitIM2paWkFiUkI5V3ZQMlN0bTR3TWdKZHQrVkpReVcx?=
 =?utf-8?B?a2cxeE9JOHVFUmRCSnJIY1Q2anoyb3VUSks0S1p5L015UXJYek1IaGxSMjU4?=
 =?utf-8?B?ZHVHZ1R3aHdOdjlhQ0FMWmRHQ1VDSDhpQThKUTRBdVVZOHBPNVpRQUpkVUJG?=
 =?utf-8?B?ZnVLdEJyaU93U3pEcGdVVVlOYzNGTS9EamhjMDk0aWhyZnhZTStnZHRpb0pC?=
 =?utf-8?B?d1NYSmlVMVExSDZackhkZUJCblkvWHQxUktxclF4YThncmRJZGQvMGs5RStx?=
 =?utf-8?B?UkhFQmp6OFVVYzJWTk05aHhFRDBVemlsWis5dkY4TnhlbnJ2YU1uU0lsSm4y?=
 =?utf-8?B?bHliY0dVZ1N5ZE4wdG5aVmR2U0NpTHdRK3VOaDZJL3gvNVdyNTVqOFNEWmx5?=
 =?utf-8?B?eFpmMlhWSlBNN2xGWTRUMUQ0NWZIOTVQWTdLc0xqSWVodjZiWi9uOFNsSlox?=
 =?utf-8?B?UjFmVllEQUNmTWdGa3Q2eUEvK3pqUjhOa1FVb3hRbEkxMng2N2lRdEh2SW1B?=
 =?utf-8?B?d3lQbzZIeHppNThpL1lTM0ZOR1BTcFVYS05uQTI5djQ0dHJDWElsUU00cC9i?=
 =?utf-8?B?MlkwdlM4RDBDNGF6VWlEWG41eHljclR2b1NmSk4xMXBKSEpRUXAyVktvNVpS?=
 =?utf-8?B?ejB4NGl3YmkyZVJyZXExbDNvOU5CZlFnWUQ2YUZoNU5pRXk2VWFmQUpDMWkv?=
 =?utf-8?B?MWtza2xTMlVmbkxNNFBSald2bG1scC9IdnAxUzhJSkRXR3FMbzlQOUt4elEw?=
 =?utf-8?B?ejlPR0RZM3FhZ0phbjh6Yng2aWlMZi9Fd1FxSDRrTW9ybGhJdVk4dnVzWkdC?=
 =?utf-8?B?bUZSSjNkTFg1RlhtV1Z2RFZsQ2lnWkJNRTJTNElsWVdmM2hKQm4rK2RTY21l?=
 =?utf-8?B?dGhUWlBhUDZ6OS8xOVhuV2RTbko5V3A5a3FXVnpzelRCK2V5YkdmdytrRlNU?=
 =?utf-8?B?S3k3VEhxYW83VnFyZzVzdTFROUhGK0ZQYjRwRWVVY2ZETGJ2TDAxK2FmWVNk?=
 =?utf-8?B?ZDdJbGNhcDh0bFE5OXArWHkyci9rcjh4bHNPTDloaEJHeVVLY1Z1QUxaaEF6?=
 =?utf-8?B?YnZxWW1hTmdrN1RHcytyM0dicElLOGxCcHRRZnRvSkxkeE5OS2w3U1FsQlpD?=
 =?utf-8?B?TGJjNWhLVldsM3RwTG9NTmlYd1dMdUw2NWUzUHFhWDZNbEdBNVQweUQ5dEND?=
 =?utf-8?B?ZEh4NFpDUmRIOWhLbXFGc0ZaYUR0aU81bW9DZnBsNHBPZk8xOFRMSnJkQXRs?=
 =?utf-8?B?QXlVWm5CSkoyZW9zdmpQRlFBWSt1dDhpdTF0UXdDd28wZDBveEFnR3gxVUNH?=
 =?utf-8?B?RDZzUnBTeHVkc0Z6NmRwL3BVS3U1L3dwTURKVGRsSVBpVDRZWUNUT1JyQ0Er?=
 =?utf-8?B?eitRRTM1QkpxbDFTcHBFTW52bTQ5SFpLSzBoQTJ3eVNlSTNTOFBtRWJhOE52?=
 =?utf-8?B?U0pISEp4b2luSWY0U01tM3lYQkwxckcvTUU1K2ZhZTNvTjlneTRHcHdZZUti?=
 =?utf-8?B?cHpWQ1RWUUdLZFZIZStwanF6WTZ0d01yelhFTEpCKzJzaTBCRjdOaUtQL2wy?=
 =?utf-8?B?TVJTdDF4NHNsUkFSYzVGcm1wcUt0RHkwVlVUdC93Tk5mRGZEbjByUHNoRGNn?=
 =?utf-8?B?QzQ0WktIaklvVURsNXBETlBQd3Z4d0FVa1lham04emhqSXBCMjh2VUl0V29h?=
 =?utf-8?Q?zPFPeg9GsRPLuyJIh7ubfvW4/?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1429d980-612b-4a81-8e3b-08de0ccd2ead
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:52.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urq4mnIg5HyNq/Fe8+jsHkqFACFacKo0LkipOWcIYSTCaZzGVSnRyaJmvZGz0Au1JFQ62CEJDH/c3d+PrbMkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

Remove extra space in " jedec,spi-nor" to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri-emmc.dtb: /soc/bus@2000000/spba-bus@2000000/spi@2008000/flash@2: failed to match any schema with compatible: [' jedec,spi-nor']

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
index 7ee25b14162760effd4a402470f814f021a607da..6fd68970c0b4568fe609f544e9b7f3fb2ed1cab3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
@@ -126,7 +126,7 @@ tpm_tis: tpm@1 {
 	s25fl064: flash@2 {
 		#address-cells = <1>;
 		#size-cells = <1>;
-		compatible = " jedec,spi-nor";
+		compatible = "jedec,spi-nor";
 		reg = <2>;
 		spi-max-frequency = <40000000>;
 		m25p,fast-read;

-- 
2.34.1


