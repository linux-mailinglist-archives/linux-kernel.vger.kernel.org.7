Return-Path: <linux-kernel+bounces-800545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB32B43909
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:42:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 346203B6844
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73BB2FC02F;
	Thu,  4 Sep 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XC9ns3Qg"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B632FB99C;
	Thu,  4 Sep 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982514; cv=fail; b=CyWq9bEjdRo9hq0UO8vafzJnyAiyYVR8VdmXPV11uqfvuGybs25mQtJqq0PVDMKF3vokc4/V8yAPXrHhe5mUv27RCXQbIUeDf16qopkzEtVfHXhXRILqCAqhFwxubV8ONfHmEb0SjdtyJ9EEJ+xObVA+MPHCG0ArBbEJ5EOloAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982514; c=relaxed/simple;
	bh=yBeJ7g/f07RqpICAVglCUdDAVVUAfdQDo9wEVqDCVjs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cpTFQaJPeXetjN79oU21L9s7ydv4q0OXHP62/ELojiv5Tb76SXH1RhSrBKjwCJnbxZNf+Krx09rJtPO8vX4KZOCVIWOF+pQBdmAYsroh2R419mocMX/ifeZIrVfw+eQr0/qH3781yektMrxl+AiZpO/2zAG8DPiwMAvlN3hTjqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XC9ns3Qg; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFANSfITTgKCEIjFRI8fbHt5em0dtN1QCzMfePPv97bsI+5srvcQ4+Z3exwTIZzu3ejgv9Tf9T488NSlHBazu2Pnlaz7pyOteWaErBT+hAqO8YDSbOSHy+KPL+F7I3sc0BSJtCrjT1/4ko/+TKmZ9F1X9U7+wO2HB//XaB+ZDBMdMZnqqax1qI51yc0luTe1OED2KGqEPlbxHLwJpyOg7rmS4gSvYt60tU4qhWAPpSiKuAWXG/NXPn/piNqTBMH+ESIvuQSBLAR4tgDMmYzWMhHUQl6dbGNcfsRAvsZJNRuwMYRqEIbFtRgv98bX3kyTR2R7E/8HcaXLFzFt8SndDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Kfy6CHF1YUNtZFdmV1R6jlpQBLQbWH7sKm8gWn4V38=;
 b=oZumZX1hWUKz499I4wMsbltIvFDzwrqXRle2wUJWTpgxrzRTXLWpbZEeNHHv/26gvWnsfWZIPrfRCJ56DvQivGETJVcpEPZrIXmqr5BFDrIwm08dInlG789FBOGN9taCSLxaSoeVQZJdxb2DYlVXnMKvNHdCBVVWWi5h8hrbVKk6EufOjBtIFVabo4Wkx/12d3QSLJYWRRGfeH4oVNYv9uAgpc7F+cWBsGw4Pj6KSyJ5NZ5mEtDA896WB5GTpRAaGqDV1U8rNAaTu791lgi0oo0bJEy+zRQrerKGu7xMRouQF1YWlYrFnA7YiJL/sgauGs23+3Q69XVMX4Rlov2Phw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Kfy6CHF1YUNtZFdmV1R6jlpQBLQbWH7sKm8gWn4V38=;
 b=XC9ns3QgxPMplVNzO/35dzOkqVtn+Jxq85eZU5tsWdGchumSIpQCpOVxyjW0zqSrCxZ+Dp2lw6n94yaRA1uozWi+QVTwn6Qs3ttPlydiQZPQHi7Z+vbPQTjo72RSCwsuZCJdjhDjzBad/ZmAR1F7ScPUsP2I4C8fl26eo0cSkEk7wySS/2D1ujqN9OgB7RhWv+6tr1M+fqaUAH0k4VZaknnPDZMDtChBu5jtU3YLo/M3G39/+hj3RYnbzMOehjuMWbsvKIPlayWiQZUCJuh9m6dnCzo8ELDk5dkp4H+uV3gNar9XOaKFu4l3SE9jiZCgcMCTsTg2BlK8UC9q33TMHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB8PR04MB6937.eurprd04.prod.outlook.com (2603:10a6:10:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:50 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 04 Sep 2025 18:40:45 +0800
Subject: [PATCH v4 4/6] firmware: arm_scmi: imx: Support getting board info
 of MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-sm-misc-api-v1-v4-4-0bf10eaabdf1@nxp.com>
References: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
In-Reply-To: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=2406;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yBeJ7g/f07RqpICAVglCUdDAVVUAfdQDo9wEVqDCVjs=;
 b=1T1HSShQFUn+wD9CTi3bAMGTrcbplNJKNfyzRVO7Ro9bZu2WqGQuhDJjNgwWUgdlaR+tz3Pp5
 /rHcSAuJKijCullgsD7PkMmlIqaM+IHDy/1cXF1N172DCcgK269xLvr
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB8PR04MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: f33baadb-9435-4db7-d1f4-08ddeb9fa7e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YllJamhCVmhJL1Z2K1ppalpyOTRRZEtvRVNJSXNoTmtQbk8wWTJ3U0NCZS82?=
 =?utf-8?B?NXNpYU4vS0t6M0kzd241d2JMOXJYK0ZjQWlnaks2dUF4cURITEk1OU5SNUVJ?=
 =?utf-8?B?Qnl3WVJUSmdEUWJpSmsrYUUxWXVBdFFhUU5pY2xWbXpOeStVZ1ZLVklDQUlC?=
 =?utf-8?B?bnNIeXBVbng1TWhraVFTblFzOUVmbSs4L0wwbXBlbnVWWUN4enRLUjExWVlC?=
 =?utf-8?B?OTZnNVFHaHBpc292REtPZkkyQVJ2V3hPcjdXSVc0WXF4U3QwUnB0MGh5M1Ax?=
 =?utf-8?B?L2pERDNoeVYyNGo4UE0valcvL2k2MGhIZ1lkOUF2Z29temtBZkcrbnlxWUV6?=
 =?utf-8?B?ODRNd09pOUwxOFBhWm1aeWNQcjNnNGEzR1o5ekd5L3RHcUFBVlJYNXRMeXhr?=
 =?utf-8?B?bVFEQlNnS2tEa21paklBMlZ2NHB5Q2F1VGNpQS9ubkVtTFR2MEhQb01DamJy?=
 =?utf-8?B?T1RWdlY1aDZkVGJLUmEyUk5HM0YyalpSQXYwY3ZaeDJZMGlPdVNpTSsxdUI4?=
 =?utf-8?B?eDh0TnJRYXhyOTBnbUUrVXh3d0owZC9yNGE0c2s5cTJpVS9waVk1d1hHT2tw?=
 =?utf-8?B?N1BrRCtnRG9YbWZIVkxRWkNLeU1MdzNiWkpsQzF5N21KYVhpdXQvb2VRb1E4?=
 =?utf-8?B?UDVTZ0lPUWRPS2VRb0VhZjl3cWI5SkNiWmhycGJiQ2ZtT09kakg1NVJ2Mld2?=
 =?utf-8?B?cVpkSStMdDV0a1dmdi80aktGcW5qTFJBcE9vMjB6VWpSYTV3aytFUU9CaVFY?=
 =?utf-8?B?ZEhTNXZ4TmNpbjk2Y0lMd2NTQ0Z5WG1jWmljTkdFbDRCYjlHYmt6KzlKRmZY?=
 =?utf-8?B?MThMY1E5cEJPaERnY1h3cUdPcFNvaTE0Vm8vdWdvMVVDNEVrUisrU1dQUjEx?=
 =?utf-8?B?SXBsSHA3clJqR2V6ekwzZzVCZk5OWHZTeGVIMlhhNmRsQ2k5a0FqVTUvSG9J?=
 =?utf-8?B?aVc5WGZkVnIweW5zZ0dpYldsS0hXTDdKaUdJbVlveUppV3oranZUTktnZGo1?=
 =?utf-8?B?RWJEazI5TUhObnlxckZwWkNvZlJLVHN4TjBGZzF4WTJSVHNKamhSMkZYSUFF?=
 =?utf-8?B?d1plWm5CaDN3eWZHZHdFZzVrRk05ZmcrT042cFJWVFVZMlV1Z1A5YytobzRv?=
 =?utf-8?B?K1hZUTlhOS9TS2c1NUtVRUpWZ0lzbGt0dzBMSzBOL21YNllhZkY1VUFJdU5L?=
 =?utf-8?B?Q1E5eUtVL3NPZEY4U2I5VVExeWZFU1pBOGJQMk1DY2lHOWpvcG1lcVEwSFlJ?=
 =?utf-8?B?WjNpS2NEZDJxTDNSNGdLclNrdmVaRVNYeTRTSTNRaCtKcXRqL09xZEhDQlVZ?=
 =?utf-8?B?Y1N0bW9iYXM0alNlMHg1YkJJa2duQUw3eElsZ1kzbHAxUERxZDlhYk9hZHZQ?=
 =?utf-8?B?blRIWS80cnp0Vldna0o1M3g2U1lTNnh1L1oxM3RHYlJGRE92QW1kbVEwenl3?=
 =?utf-8?B?eEFXcVBQVUoydUJEQXhZcUwzOTFJMis0NzdOSys3QnREM1BvN1VtR3JMbnMv?=
 =?utf-8?B?emFuZ2dVcUJuL3NvZ0dtdVNBMWJ1MllueHk5WXp2Ny9YT1FPek5XS0tmVzRN?=
 =?utf-8?B?ak5zZWZrRElLOUhjdUlUQzlNSjhMYU5iRk8xT0RyV2wyY1JqT3RLTDdRc05E?=
 =?utf-8?B?T3BqOTRXc2dYbXJvOW9QamNiNDNXZ1NqWXFBeFJudmpTRTJRZnBnT3hzNlUr?=
 =?utf-8?B?MFM3WUN0ZDBUazNVNmxHRW9jSWtITDBPNUdnQm5NbkJQS1VqUzdNTjJjWWpS?=
 =?utf-8?B?NnpETmhFRkVIaEZ1bzZ0ZnAzb1N5KzN3OWk3ZldMMUdiY3Q0cmI2VGNDcUJZ?=
 =?utf-8?B?L1VUYVJxLzdDWmx3cGVNT1ZIWjdSVFc3YkNTM0lWYVVxT2U1bnpRbERmU2pi?=
 =?utf-8?B?UVM5SnF2YWpiaGx0bmlVc1VRc25RZXJlTnRXbVF3R3l1YTR6Uld1cVRXNXFV?=
 =?utf-8?B?NTA2SW50OG1wNFJDeERtUmdmWGZpM3dlY2w4Ynljc3I0Y29CTkUvNzFvWG5J?=
 =?utf-8?B?RzRDZXdvbXNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WlFQUVg2NjRRZDkzV1l5NkhGWlU3Mk9MSVM1Ynp6UFh5WjNlSVJzWEZxN21m?=
 =?utf-8?B?VDNSbzhVUDRVMnQ4SG9uMHZpd0VYalo0S29Ra01NbHFKb1RkZlBpd1V6NTJi?=
 =?utf-8?B?OS9GV3UzaG5KQ2NESkpUeFZQTUM2UG1NbTd0NXVQSjh3Uk9NQ1pibmJsWDJp?=
 =?utf-8?B?WVE0T3hiSmRGeTdQTVBmL25QSTZacjM5aW1jeXQzR21vbDVwQU5HREUwbnQx?=
 =?utf-8?B?NmlkUnQ1OXNyZXp2QXowTlJlajB0SFcvWE9tVFZEeUFhRXdGSmhCekl5NWUz?=
 =?utf-8?B?ZzhmMk9DTEdYZVBaYm0xcWo3ZmY4RStBdmNsVGFOV2ZUbkE2YkRaUFE2b1Vk?=
 =?utf-8?B?VHZlenZaQVBjTUhBaXMvYXhhb1BJZCtsZ294SXlFQmFseWdPNnQwdmNLTVJ2?=
 =?utf-8?B?ZFBWdDZaWjJOcmNsK0lSYkZad211ejZDK04rMDEyalJRTncxVmUzUU5xOFV4?=
 =?utf-8?B?QVNBc2VKOUhlSjZ3amc0ejlDcGpVUUFDQ2xoRHRNS093MTR5enIvQVcvNVJR?=
 =?utf-8?B?RXlSQXZ6cjNQRnE1cGkrZlNWeUFRblBZZGpwc0ZacVFIY1pHWTRMWGZpRDd4?=
 =?utf-8?B?WmdyZVJhVlhEdFB4L0tqU2pCcmFWdkNXRTFuUVNBSWZNTkZNTTlOdVRvaE9v?=
 =?utf-8?B?SEs1SXZPdDBhdmZwQ1M3T3VGOHo0VFFwYTBEYmNGTFFkM3B2TVRLY2ttaUMz?=
 =?utf-8?B?bEVYeWwzL08waTRIWitkMnpJOTNhY1RyM1hzdzl5cmg0a3ZRSEppc2FtbU9V?=
 =?utf-8?B?QURQNUEzRUd6Uk1EZTlxY3JRY1I1cEEyeWQydlo2M0ZjWk03dSs1R3FiN1Uw?=
 =?utf-8?B?amd2TGxtbTFYYmNmL2VzamF4OFFsMG5rWWt5djB4TkpMYTV1cGFiK0p0b2JR?=
 =?utf-8?B?eDRSNkhES21EL2RQRmtXSEZpclEvWWhXdmRhZ1JTcFRLRUhZcWV0cTZVUllU?=
 =?utf-8?B?aFVmOWROWnRBZ0ZPUDNoVmxhUFFjMkZYRWRYMFRYQ0FvV3I2eDNvTTh1d3kz?=
 =?utf-8?B?cTFYSkw0ZGZ3NDV0TUp5ZDBmUHpCOUFkd25TWUdtSEl4bXNZVGlMOXdBZUJs?=
 =?utf-8?B?bGRRSjE2M3hTaEdJY3JlNFFLZG10elM5MnpPbml0OEU1aEI0YThXL2ZhRmh1?=
 =?utf-8?B?RVkvaFA0QWFmTDRFMUgvMWk5TTB1aEdkRURBa3Z2dWZNNmpVT2l5bDdTNUs3?=
 =?utf-8?B?YnpZRmJXNVI1R1dpa3BqaVUvT0dIV1AvN3lBS3FKOXVIV0NxemorbnFnTURw?=
 =?utf-8?B?cEh4SjJDclFRYWh3bWpxaTU3MElRdWR5eG0rUmEzY3FEUytCbys5V0hrdkxN?=
 =?utf-8?B?SDRZdmkwS2tiaGJrdDVPU1NWMVRYS3FNeTJHS1ZNOHRLemhKalAvUllXMzl4?=
 =?utf-8?B?WEg4TFVFazFYQmNNRTdHUlBZcmN2YVZ3eHgvZ1liUTVldVpoNjJhdlNMSHBI?=
 =?utf-8?B?WFdPcllUZUVFaVdwZVhQVCtHM2Z2YU40TGtpTGpod0hDWmhTdmpmTS9rb0FL?=
 =?utf-8?B?cWdZSnd5OTJhblZubnZLMmxOck9qVlhCUU5FYWFXcFZoamVobUJ1THlxSVA4?=
 =?utf-8?B?SVdKVmpoKzZhdWZtVDVUby9qTzMrUHc3ZzA5Tmw1S3BWNzN6SlN2M2JDWDVC?=
 =?utf-8?B?SkVLckpaeFdYdytOTGxtMEdtNjJRUlpqNXJwanFqYU9hN0svVWYwWUt3VjFM?=
 =?utf-8?B?UTM0TmNtK1RaS2JUdUpNSCtGWkM3ejNtNTJGTjN0RFhxRldMUFZCSjdlaVNV?=
 =?utf-8?B?NVcxYm9nTHlPME5aZ1RnMC9CbGNXMlFGbm1NVTBGMlB0VW1rOUtzUDdMZXhP?=
 =?utf-8?B?K0ZNNVBUUDcySmNxZ25MSndaOUJwdXd6MU1iWGdzYVA5UmluS0R4TVYrRG42?=
 =?utf-8?B?VERwdFdDVm5TR3ZlMEVUemM4byttQk52RXVyV1hWcEY1UC9sZ2gwTWllR21y?=
 =?utf-8?B?a0NVajdUVjRGTmlOdy84VmF0QWs1ZTlTRU95TG9RQXZXbVNEb05scGtDdUU3?=
 =?utf-8?B?OUI1c25LNGh4SzVkQ1FEdFNnMTdBQk1kZWt0S2ZwaVBXb0UxZHc2ZHBCTlAw?=
 =?utf-8?B?QkEzR1Zpa013NW5qN0puZTVlaW8rRWpoYjlZb084TlJ4dkNETnFNL3RTVkg1?=
 =?utf-8?Q?yyl14dGOWcYAXuhHy+yCRwO6U?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f33baadb-9435-4db7-d1f4-08ddeb9fa7e2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:50.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKywT3Z52Sbxldp3IUdZfMr961zjweMudgk6MsbVbctqqgWaGVAt8ue7c3gyw8iEAs4HmGyT23ZfiBJTBYP8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6937

MISC protocol supports getting board information. Retrieve the information
from SM.

Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 35 ++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 92b641f467b053a1a15332fa0a584ea7400e3bda..9055d3c848bd159c8133298de31d3dd5a8138ec3 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -28,6 +28,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
 	SCMI_IMX_MISC_CFG_INFO_GET = 0xC,
+	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 };
 
 struct scmi_imx_misc_info {
@@ -76,6 +77,12 @@ struct scmi_imx_misc_buildinfo_out {
 	u8 buildtime[MISC_MAX_BUILDTIME];
 };
 
+struct scmi_imx_misc_board_info_out {
+	__le32 attributes;
+#define MISC_MAX_BRDNAME	16
+	u8 brdname[MISC_MAX_BRDNAME];
+};
+
 struct scmi_imx_misc_cfg_info_out {
 	__le32 msel;
 #define MISC_MAX_CFGNAME	16
@@ -316,6 +323,30 @@ static int scmi_imx_misc_build_info_discover(const struct scmi_protocol_handle *
 	return ret;
 }
 
+static int scmi_imx_misc_board_info(const struct scmi_protocol_handle *ph)
+{
+	struct scmi_imx_misc_board_info_out *out;
+	char name[MISC_MAX_BRDNAME];
+	struct scmi_xfer *t;
+	int ret;
+
+	ret = ph->xops->xfer_get_init(ph, SCMI_IMX_MISC_BOARD_INFO, 0, sizeof(*out), &t);
+	if (ret)
+		return ret;
+
+	ret = ph->xops->do_xfer(ph, t);
+	if (!ret) {
+		out = t->rx.buf;
+		strscpy(name, out->brdname, MISC_MAX_BRDNAME);
+		dev_info(ph->dev, "Board\t\t= %s, attr=0x%08x\n",
+			 name, le32_to_cpu(out->attributes));
+	}
+
+	ph->xops->xfer_put(ph, t);
+
+	return ret;
+}
+
 static int scmi_imx_misc_cfg_info_get(const struct scmi_protocol_handle *ph)
 {
 	struct scmi_imx_misc_cfg_info_out *out;
@@ -371,6 +402,10 @@ static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;
 
+	ret = scmi_imx_misc_board_info(ph);
+	if (ret && ret != -EOPNOTSUPP)
+		return ret;
+
 	ret = scmi_imx_misc_cfg_info_get(ph);
 	if (ret && ret != -EOPNOTSUPP)
 		return ret;

-- 
2.37.1


