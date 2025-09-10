Return-Path: <linux-kernel+bounces-810367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB56B51958
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8E7560FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFE832A820;
	Wed, 10 Sep 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NvRmooGw"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB623D7DD;
	Wed, 10 Sep 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514522; cv=fail; b=jlz3DzhFCbW01TaYcYcVI6UwUceCUp8uswhhJv0eB88J2j1gxQzor+NzAWE+50cTJYgxCTbmQjN3u46tsplLSAKCkxqZfjgMbzcOva4W7gAYU7X5Nrx4Rz+vjqaJencJmWNe0bBYZFETsTF/RCOaGLCqqzCOOt8cEVXrSOz/TRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514522; c=relaxed/simple;
	bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Xy4Xq+s4UBFLsMRCQP1cuydAIO9ofL5pHhH162uwKYhch0BcoymqiindvDeKwsHfH7mtb9/EDnOcPoiXV1n01AIYqqTvF4NOgmdPHM30j0/DaSMt+ERCvYK3wL6jH5yEepeDYfBDwroPmwHZUulu9eCVZksM46KdDqs/+Y+ICjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NvRmooGw; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfv1E9PEzPvGLMWAMGe0JAU8TmvkOYqN5mFBZS+httmadXxpkUMMI9/on00osIwvM0QKQPURvJXeH9xWEXJIv+MeBOiOYFQCyrdq8e8R5zXZdEokfPD7NUbkO1hKcBWxabuUgFDR89vqVwmGsLxtKdC2ufu/yEbasL5L9HBwjsZp8r2IcAbghMyXFr9XcimUsU3jxltsk4vgY7nuRzhqf+7f9OExx0lHX6kPlaUzjzLO7Kbvgo7y3tT8ATLBcQsiv9V1nd0n0XsKNl088P0TWGqkSvn+JOX3ki330ERjQsdZyV181SM2BvTp33lfhhemsauhLHqxiFSeEKSww/v++w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=oSN3rNWUMYziNtStgLtWU82mHnpWTwx8rMi/B+iJxMAU5y98h/vwAP3uOVDFZg3MMqdVElCFVi6xlCe6a5PBVJEt47iGS9Lq0r5NlQXa1b4vBWnVuB7VP65pO+cVUIU++6N6OYB6zaoBLeQJrVAAhjuvkPDC1kNxZrh4T0U08wcKx1ipMKJfREN3NpI0rRJDtsvjYETsxbP9QMQoJTGF9ZPnb/Z90PKsofi33fg9YIzIpYWYFtHNpxC/MGxeZ8+bfddkAmvqR2rsK43maBJUaZtfq+l94QPUS0+CawJNlbLjRro+bGjFLlQYGTC++lQUxZCAlD6K/y4ecZJTwuVBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eu/wKtlFCetiqa3GCS9Jt0RqHlzj8EgqU5uK7BhPKnE=;
 b=NvRmooGwnNVNfxyF4vJfDmFHMIil2mwFRUgms6wWqB64UT/hsgW104KXehlaZbDRnu6ZGlbMD7TX+UTHcke8I26EQvSJY/VQPI2dxD5Q6WAGCd2DEdeIdfJz3/rBgo0Oj5PCp49dg8aqkVARZodUwKVSxDfcq3tcdV6Cr8Ri5h1DrRBYF1Ak7UnzzofsoDVs8z9KHup6RbkwIlRtHpBLCNIpHFWnZjzBm8dnzzUCg4iIegUND2Mu/QogmE6DX9MtKK387SkLwTw7QoAZFtykX/xhdNWqXRlvmfjHh2VuI3SVRnoU1E3l7xOlIxuEWivgaW7vuZ2dyawUGBKG+QHIjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 14:28:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 14:28:37 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 10 Sep 2025 22:28:17 +0800
Subject: [PATCH 1/2] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-sm-syslog-v1-1-5b36f8f21da6@nxp.com>
References: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
In-Reply-To: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757514509; l=4493;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Tz2yhgq2IH4U3gEhZRqpgwNP9ng3E05fL2Ij5EVl5bA=;
 b=YolTBA523UrMAgfFTmIGd+5SHUnpAXtBGcCjQCz44I85umiOEYm1V5LnSpoyowduntI6ezUnK
 XW2wSOjZaeoCy1COhV2sT1C7APCNFUIAwxWsAcDrELogEWkqx438CgY
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa32884-a100-4f57-f91a-08ddf07654e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHBRM29RWnRMZXFCeThYWU9tTU5ZbWR4dDZ1dUdDaVQwbGJsdmFua0RxT1Fz?=
 =?utf-8?B?S0JWd1c2QnpYV0cyMU1WcG5QWlljSFhOVVBIK0k1U2I0YXBvSE9NYkVXQ1Av?=
 =?utf-8?B?YnpwTS9aMVpFb3RZd2gzMXNMYWJEVUQzeTlPS1VveUVFdFhnaE1TclhMNmln?=
 =?utf-8?B?aFRYaDNrUUg5Q09jemxVeDJYUHd1QnAydW1kY2NDK3lqT2MyYy9KcFlwbkJH?=
 =?utf-8?B?WU9vODFVc1kra1JQWnk5S2x6Q0prQmFZaE9RakJldUMrUEJONmYrbUowYnJk?=
 =?utf-8?B?MzNSRHE0L2w3OWJZenlxMGFRSVFXMTBSRXNBYXZlcElpeUJhaWlyWUlOUGRR?=
 =?utf-8?B?RVgybG9LTHhhYWdWR1NHbkFFSmx2SlRYRmhncENraFYvbmlNd2M4YVcrUGg1?=
 =?utf-8?B?SFFkbkNkWFpHclI4MlBPNVZ5MDU2eWN5NzNHSWxCMzZoaFpDVUJyc0JYMncv?=
 =?utf-8?B?RVFzcll0ellTYmtSM2x2Z3RsT3dGNHFoOS93Mml5RFJrRW9Pdk55MXc2WHd2?=
 =?utf-8?B?NWo1ZERPckFDSktabG8rWFR1V1k5RElFSEZURVkzSVVQL2srMXRqdmwyRW13?=
 =?utf-8?B?cVhWcDR0VWlMOFc3bGp2Yk5KemhqclAvZ28yQnJZdlVqTTVvL0hoU0k2enhC?=
 =?utf-8?B?ZEZzZWtUckVpMHFKK0JndzNsVFRYMk5VUk10TlRPWG5BaTV6citTVy93dHM2?=
 =?utf-8?B?YkJMOEg2VnpvNUdzcDE1amFzajBnR1FqanVVc0RoTFQwWFd5bzRONGJNQS9t?=
 =?utf-8?B?aENiamxaWndvbTFIcVZwdzRqdmtqYTFtYkwxNnVxM0FPQzFEQzRBb1VLczJw?=
 =?utf-8?B?OGpSWlZ5VlRJUWhES2pML2hVL2VwZGJkNXZhOFoxZlp6SkFqbWY2NExRUW40?=
 =?utf-8?B?K3RRV1RrR1NvSzFwYjlUZFNjNFVhWkw1STkyNFNwZVVTUDdoRCtJWXlhb1Ny?=
 =?utf-8?B?VUFza2FrOWR1ZnlJZTlPNXcvb0xFR1duUTNNclovamFjU2xKQ3Bra0ozMDlT?=
 =?utf-8?B?ZUl4eHc1TlVSOGVxOE1mdExFYmRoa0UxWVMzVXgvVU5wdTNKUml0eTJtbnZC?=
 =?utf-8?B?Vkh0QkNtMlZlcVcreVVRU01tMmVHeFk4cVlEQU1UbTdBSVhraG42OXM2b3E3?=
 =?utf-8?B?K3loZTNZa3FFL2hydFY1TXVnZHFiSk00ckZKRGYxOTg0U0VldG9RdGduZjdC?=
 =?utf-8?B?ak5TM2FEWWpRV1JiK1JYV2NYWmV6ZXFRWnpNbll3UnlLbjFaRUp2SEYvYVpC?=
 =?utf-8?B?OEFkNnVEL3dZeDQ2UlhsaVk3SVYxeEt5dFBqcDBPNTd4OUtBeVI1QVZLdDFi?=
 =?utf-8?B?Z3kxZTJpam1NT0lVRWdCMnVwRWUyNGExSCtqaGtxZElnNjgwQjJ0bzZydmJs?=
 =?utf-8?B?ejJITFZSZVU3dnUrSnZXR094L0NLRVJXeDVLVWF4Z1V2NVlFK2FuY1J5ZGpz?=
 =?utf-8?B?UTZOUkJmR0JxakdmckxrejlYUExLZXptc1ZLc0VmZVBVYThoSkMxQkh4QnIv?=
 =?utf-8?B?QldlVHZSR1Z4SWRiY2N1ODdlWGQrRGVpV3VQaE9YcG9GMkY4T3hHY0lwd01P?=
 =?utf-8?B?S0EzUUJNb2x0clY4ODdxWEN4QXVvTkRwMTFVck5sRzNKelBmR3Zqb0NyQ0Vm?=
 =?utf-8?B?ekw4K3NVQ1lGaUgxeWsxelRGSkkySGlPTFlyZC85SUJMcGVybzhrOVlRcHJ0?=
 =?utf-8?B?RjhMdTdXNHVUTVd6a1Z6SzdRQ280VWNkVWlEckNqMVR4S1FHSWFCeStQWXRo?=
 =?utf-8?B?Wm1rYlh1RUNuaXVlZDUva1NONTAyOURxdTRuYjFzV3ZXaEZoYmovZjI2Ulho?=
 =?utf-8?B?RVZuSjhYYWNrdFR5Q2JxY212ckk0L0xmaUIydFlwOVVNUWdLNUlIaWd1Znd6?=
 =?utf-8?B?YXhJTVJGdmZPMjcrdVBqanJRUytza3lxbmhUS0FTRlA5VmMvc0YzeTdBbFV3?=
 =?utf-8?B?R3dFSURzVkhiY2RDWjczNFJYcHdncW1Gck9hMndYZXI5L1BYSUxBbmVFZkpM?=
 =?utf-8?Q?s9MhXBLE0flzLjMvMvt5H0idRatV3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2xFZjhmUVBMa0ZHREdwOGlmUTBBc1M3VUNPNk9Qb3hacjhGMUdkN21pdFNz?=
 =?utf-8?B?WnpBejdrc2VKMWV5MmZicHBhT09TMTJkNXo3ODBzL2lzNEZkSVNhNks1TmM1?=
 =?utf-8?B?dkhudkc2UDhRKysxM1dNaUJybU52eUd4cEpsZkRTR3Nyb1M0d1k0S3E2emY1?=
 =?utf-8?B?b2lOTnE1OTRtN3JMMThtN082K2dzb2JOT1JkVFY4K1lmMURwcmtaeDlNTFl2?=
 =?utf-8?B?V1Z5VzM5dUpIaUdCaHFOSkViRTAvNTFxZmNSeTlMUGFkOTgxVUl6ZjFSdlNM?=
 =?utf-8?B?YjJ5MHVUR2dKWEF4NkpLQUlBRDFzZ3Z1enZHLzBKenNJcmcrVTdIbG4vMmNT?=
 =?utf-8?B?Yyt0UmZFZlNrNm5hOUYwdkdvRHBjeXlQNnpRdVpSUHFMblRFZUJ1ZGpkL0Ew?=
 =?utf-8?B?VkJIM3htUzVvenVuQWdEdE9OTGNMV2VCNHRUaUtrZ1d6aVExT3J5TzQ0Ylhq?=
 =?utf-8?B?cGcvVEVncHdOV2NZL0tmR1F5UHNmRnB3SllMSDhxVGxRUjQ1V3JRMjRwNCs5?=
 =?utf-8?B?Z0hlU2E1MkllUEpwOFgxU1Jmb2V0TFltYjZUc1Ryb2RIN1JTOVFQckVqcEli?=
 =?utf-8?B?ZnhHalJLVUM5OHREdFlVaFhFMzFHbnFDaWxORGhqczBEdlFCaHJ0SStJWi9p?=
 =?utf-8?B?T3o4cU5tZWRLM1BUUnJmd3ZRQ3hLeTM0b3BkdkVlSWRmWFFMdnhpdWZHcTlQ?=
 =?utf-8?B?RFFKdm5QQzVxTk9EdEpWZGxwNk96V3pjUkpjSmdVZFAxaEVwQk5aZHVkRlpx?=
 =?utf-8?B?WmxvNEMvb3NLTlBvU1EwWXlERWM1WVFKZjIvNGtLYlIwNUJiaWlLM0hUVTJ1?=
 =?utf-8?B?N085cHdvdTlROUpia0RVcjM4cjZSdjNPdG80TjdISElEN2VUSUd4eWxoWkJi?=
 =?utf-8?B?T00zWWJpd1NlV2t3Vi8rOVR0b0RqcVJkSWsyUzJQZ0p3RW1mRW1oSHB0ak54?=
 =?utf-8?B?bHRlMXNybG5Pdy9WTktjT2gvZnBIN3U3aWg5ajMyems1MW82QWgzS1dkdUVM?=
 =?utf-8?B?SWZteVVlUFhHb2ZDNkgvM1ZxK094Z09EU0xOazJ3bTlxWVlpZ0lxYmlaWHpu?=
 =?utf-8?B?VVRrcElBS0JBeG5XeW9reUFmSlNKYnlRc2YzZmx2ZTRDM0UrSU8vd1lUVzJj?=
 =?utf-8?B?S054MzMwZEdyS0lHSVZpV0tYbm5Na2xRSGlxSjdFTXdRVUttUG9ML3FpRktR?=
 =?utf-8?B?b3l4cndnQUZmdCtQYTZGY3A1bFFqcmdjOVVnVG9za2lyZVBzZHZWaHFxWCti?=
 =?utf-8?B?bzkvT04xdUs1UnQwRkFtVnREcUdHKytDV1lSdU1oMnRJdlVYNXRqT0J4U3VB?=
 =?utf-8?B?YnZHQ0pmNjVKdEx5K2tDQXl1NzVWWTM3aTJsSk55R2NNaXRQODRJblM2di9E?=
 =?utf-8?B?VGFiY245M1pGdyt4bmJJSFJGWnJPN0t5YkFJQmk5NFRGRkNMYXk2MnBhRVlu?=
 =?utf-8?B?b2RVUmt5OWxiWHFyY0VXQVhqbTlkeDZySGZUVXRvSW91amNQbnM1NjdXdmgr?=
 =?utf-8?B?TWc4OTJaWDhkY2FlY1JZVm5xV05CZHZvaFN2Z3YySXZGL3hLMTlqWEZpcy9m?=
 =?utf-8?B?NmlvQ3RaTFdtbXNpSkJtRCtDS0hoUFo0cFYxY0Z4Mlk4cHVvd3Bma3VpUWhB?=
 =?utf-8?B?eXpLUEE3ajNjN0V0S0VxQ3ovYXdqTnh6Q1RqY3kwWU5sVjl0UFZsYi9ZS0lr?=
 =?utf-8?B?UUJ5dWVPYXJJM3Z6Z3NXZzY3THhRd0JVNGd2NzFFT2krSG1FS0dqOXd2NmVo?=
 =?utf-8?B?RysrakVhZXBoVHBHTlJ3Q2RrSVNXZXhlRUxUcEl4QVpFM01LWUxCMURDcUNL?=
 =?utf-8?B?dWpqMXNhcVQ4eUpVR3J4RDVhWE9Vd1p6SXZFSXllRCt4TTJKeVJjeFdmVmxY?=
 =?utf-8?B?Mm80YVRyT1dXVTV4dy83eVZsemRGcEJTYkZyazlnSmROZmdubk5FVUI0Yit6?=
 =?utf-8?B?YmRHSlNZaWUyeUNER2xVL2d2ZEExN09pMExLdmVuUVZ6R1NHT2lIbm5JSlRX?=
 =?utf-8?B?RVRtWXI2ZVQ2UmsxeUJCWnFabzZmT3RXODNXZkZhYTZ4bk85T25wMUYwNzFP?=
 =?utf-8?B?WUlROHlyYTRESDY1ZHRNVVNSVCsybjdtdHh5bEN3c0RRVGJiM1Rmcis5VGg5?=
 =?utf-8?Q?iBNzZ5R6FCJ4L9ZJTfLe5FSW+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa32884-a100-4f57-f91a-08ddf07654e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:28:37.9057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afBzVgYdUk4V8GH7D/iIHacGlC6r3gKLYAXyKZgPJ/TZ7t/QyrYBYsuxdGJo5vsBTZ5TmRZExguS8HmamqynWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

MISC protocol supports getting system log regarding system sleep latency,
wakeup interrupt and etc. Add the API for user to retrieve the information
from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  2 +
 2 files changed, 85 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 700a3f24f4efc153ca4a9ef1a9e50a7ece492a18..eae0b0562f6cf1931be612852ba2651f60820e6d 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -28,6 +28,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_DISCOVER_BUILD_INFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
+	SCMI_IMX_MISC_SYSLOG_GET = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 };
 
@@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
 	u8 cfgname[MISC_MAX_CFGNAME];
 };
 
+struct scmi_imx_misc_syslog_in {
+	__le32 flags;
+	__le32 index;
+};
+
+#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
+#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
+
+struct scmi_imx_misc_syslog_out {
+	__le32 numlogflags;
+	__le32 syslog[];
+};
+
 static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
 					struct scmi_imx_misc_info *mi)
 {
@@ -371,10 +385,79 @@ static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
+	u16 *size;
+};
+
+static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
+					     const void *priv)
+{
+	struct scmi_imx_misc_syslog_in *msg = message;
+
+	msg->flags = cpu_to_le32(0);
+	msg->index = cpu_to_le32(desc_index);
+}
+
+static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
+					 const void *response, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
+	*p->size = st->num_returned + st->num_remaining;
+
+	return 0;
+}
+
+static int
+iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
+				  const void *response,
+				  struct scmi_iterator_state *st, void *priv)
+{
+	const struct scmi_imx_misc_syslog_out *r = response;
+	struct scmi_imx_misc_syslog_ipriv *p = priv;
+
+	p->array[st->desc_index + st->loop_idx] =
+		le32_to_cpu(r->syslog[st->loop_idx]);
+
+	return 0;
+}
+
+static int scmi_imx_misc_syslog_get(const struct scmi_protocol_handle *ph, u16 *size,
+				    void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+		.size = size,
+	};
+	void *iter;
+
+	if (!array || !size || !*size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, *size, SCMI_IMX_MISC_SYSLOG_GET,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	/* If firmware return NOT SUPPORTED, propagate value to caller */
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog_get,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..2407d7693b6ba1303e07629e45e2a7eaaa906fd3 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -59,6 +59,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 *size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


