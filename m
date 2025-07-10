Return-Path: <linux-kernel+bounces-725256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD27AFFC81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B89BA16B9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D492918E9;
	Thu, 10 Jul 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hL7GLYdQ"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010050.outbound.protection.outlook.com [52.101.84.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9362900A0;
	Thu, 10 Jul 2025 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136547; cv=fail; b=ms7VaYDW7tLPGa6Pqo+BsQhJxRZFsAAZjTBE0XDZXxEKtREtupGBFSxIyzXL1I5gpLCyCoomfc8xlti4xCAYUFoX8ELXp0feCTwmt2arQX16cD92776SESi2b536UBj8I9dFJ6f1kEOY509R2SQqGxCZgY1B93j+nzWu9Eaj5B4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136547; c=relaxed/simple;
	bh=s1XEDJq34AK0uB3pg0wtgPohfN/8JjB+1V9S14VKdS8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RMqKbdpQx3+T/8H5cww/xZ526pn2EZ0+IH+z6mouLnnJc2Zeuqts9Q0bYGiF7Fcj3eecvEs3EJ4gMtCXVpCwJawZqOwxXS3U7oDIkPPhOdo5V5VDaopU8xlrN75NorfZRS38mbxUrk6hAusNSBgfe95+Z37gPxNHX8oAeHavbTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hL7GLYdQ; arc=fail smtp.client-ip=52.101.84.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmcajJjYINSDD6E0PR7ck+c3+2vlOE7OmjaWemueVfjHDu/4809/BJIPFxrTEDhkhgpiZxFcYUxnzRbrQWHZj2REMNBZ3eUoGxFCaGL3YO/QzgRo3brwXjCUCBpP6Ar2nHurUJ1dcvACZ77nrCpP7Mhv9RVV4Sc1cP06SkrZC0HcE60oQINoI4EMifn7K8kPkyw95nmHyv93zt4VnTXAsRJJN3UNgQf/lbAJJ1bL81f2ay/4vyez7oMULm7bUOnGdNR50KT0QuWgs7yleaVtgWHEjMXjlWCsqgNLrYTIoN0FZh6aCnvkFNfzbcH7MFZJZnK6dBG1CEC5jza6NKK9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wldmHon6AZ+FMIRYoRiww24Ps2rEOLHZCkoQRuQkapw=;
 b=XnYetRgxb74uFdtjm7iU8MsEe4mSZ9y/n5kaKlO2duU9m9wEWi+4VMC9pe7fkNT2GU2gWFtmKmnHPsPzrX4vaBlb85FzlUX3wYbFzEstLg953zY3WIWnSWd88VSi46t1rcj+uQLqVIRGx0gkWfG2mRlsGlcElB1d+Nj6aMyZx/Qoq3mHAEi71QwREHFV7YPNqhcs8yWIsbTzUU91cskbzCXdX/sSd47d45e5MtdFv6tBPH1x2P/e/mRict4HQ1iWuv6IkcLCh4Lcv8nxX9Mu1/+HRqYNxA9Ij0dGppKozfw5NJxhpbt/iynXJd5rI71NiXMBR31qZFo6jHYS4YQuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wldmHon6AZ+FMIRYoRiww24Ps2rEOLHZCkoQRuQkapw=;
 b=hL7GLYdQ3xosIvyZaorVK7Jjqa1qDPHDOUWOsDKM1fXUJBb7dhmCGZXYMDGTGNOaLqvC2XrxTwXhIz5sNa9A3u/4OT7AzlDDuZ5XFPlSzj8pE8x0mK9rCjtzJOo/Rhd7/9W4I1hKixUVtnSRZu6/xlxz5k5NWpFMdFG3caJscHX5BhxFVYAj5lQkSjX+w0Jxh2z2j+Ymr4WwfwtUASTA76hCn24GvVesSEfUqbwnSeaHTlmgXMGN9cLlsVq7gnk/NNfKTmzw47RczdU4SVg56pjoZyzA2iRsqak6pD1sRk53+DIqFsXvUdVpr1yKoiWN8+7rpzJVrq8Ey3lwgMXESg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:42 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 10 Jul 2025 16:33:30 +0800
Subject: [PATCH v2 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sm-misc-api-v1-v2-5-c3e953e34be6@nxp.com>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=4860;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=s1XEDJq34AK0uB3pg0wtgPohfN/8JjB+1V9S14VKdS8=;
 b=UWQFmlPQsIdMEyaScoDeyAirnoYSazkEVNgjkq0W6MhkkIDXUuR90q3HDpq3XUH+XfkjTT7wu
 pUwGN9J13GnCKL6aDLHv2Yt1G5bx53gHKjFjHjH3QoYTwHefSezIsCh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11512:EE_
X-MS-Office365-Filtering-Correlation-Id: 591d6d5c-b9d4-48de-fa98-08ddbf8cc19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2RTcGI3dGxsUDhaaXFmb0JCYlJlckZHeFNJMDJaazNlb1Fnc2Z1WkE2U1FY?=
 =?utf-8?B?eEVZc0RyY0U4VFFRWkdtNjZLYm5hRWJ3UHMyNkVZaVRxNXVVT095VWp0RVBa?=
 =?utf-8?B?NFpiL2lTVlBaNDd3aFAzSXFqeC82SWhVR2xHelU1aEwrZ3dZSHE0SDZsQnVm?=
 =?utf-8?B?bXVtNjl1MEtOMEhPeDJZY2g1WVNyeHJSZ2FXT0tGbnhLZ1dMTzNZMkJvSTRB?=
 =?utf-8?B?d2k5TnlnSjJ6V1lyNng0SEdVS0hVUkFnSGVXVjBON2JCWXExaTQ2Q0FyNzhh?=
 =?utf-8?B?NnRwaGRlY0RwRUtmQnMzbkRiMm15a1hwMDdNKzNjSEhUQ1lHQXVCaEx2a3pY?=
 =?utf-8?B?RzJWaFZUQTV5d2doUGlJMkFMUmgwOFg5OHE3bDVvY2dYczhxdm1pOElCVlVC?=
 =?utf-8?B?TTl0STY5Y2RPNHRMdlJwWEdoVjFFK0dDL0N2OHBob3JuUWN4QlhRZjRISnpZ?=
 =?utf-8?B?bHg5bU1HZnkwWTZ2TkhraWNNMktiSjVwS3M2emJwcnFESllzYVlKd21TKzN0?=
 =?utf-8?B?OE9aTGlhZDVwUFh5anIvaG0zOFZ6OVZRQ2JIVW1UYUtvSFF4N2ZpZzh0V3RQ?=
 =?utf-8?B?NnpRdUk2eFRyZXRYaGFtV3RpRVhpcTkvK0tVWU8vd0h5WnNSZ214TlU3ZUZK?=
 =?utf-8?B?WTZxVXpEN3RYdlJrM3poaVcreERsY3RMYjBPVUVXU2dKYWRvV3BqbzJwa3lY?=
 =?utf-8?B?OFRpZ05XZytmeDdCaHBSdm9EWmxXMHBBOTJZclc4OHpnUjlNamRHRmsvWHdT?=
 =?utf-8?B?SHdIcVNQYlBML0pTRmdUa0xieHc2VkJPZzQrekRWd2YvZW1jUXBhd05scXZz?=
 =?utf-8?B?YWZzNXFMR2oxOUdheGJZK0ZqRGxpbDh6dWo4QXFPTW1vdW9YWndYTzZSNmFU?=
 =?utf-8?B?SmVObzhuU1pXUmthV2w2MHp6ZTVaUHkxZVlPMXAxOWsvOU9Qa2hNNHhQMmFX?=
 =?utf-8?B?R041Z29DUDU2cnRYTTB1Rk9oTW4wQ29idDdza0Y3cVN4WnZ4eVlkeGxFdE1M?=
 =?utf-8?B?NkZ4UU5ydXdkTE1LWmNzbzArWGJkRklWSnRIRnNWSXgwWFphMEo5Yk9lR2lG?=
 =?utf-8?B?ODg3VWhOSldydGVJM0srRXBGT3cwN0ZGbUJrZmovNC91UmN3OC9qcEJCc29w?=
 =?utf-8?B?bDBwZWp4Rk9CR0psVW81R25JVW93STRaTUFjVWE4VFJqVzUvUDdVSXNOVmhS?=
 =?utf-8?B?TE9zUXUvQndINXRDRjVwU3VQb1YxMW9zLzJvY24wZDdOakNDUGliZSs4SzVH?=
 =?utf-8?B?QmJ6ZVpkV1pZOUE2c2J6bGpiZFNLUENsbU1IWlNOMVJZc25JQVhjUXV3NVZQ?=
 =?utf-8?B?d2x2K1IzZkJ1RjdwRXJDQU5LbURmN290T1ZQelJnQXFUNzFRdkZVanp3d1Yy?=
 =?utf-8?B?Q2dnVXhvcUFTYW9iQUlCWjBKODdLOXNTZ0ZlRWR4ckgyeTR5cXdyUUFOUWIr?=
 =?utf-8?B?UzdsSjdyejg2bWpMRUo2bkNNL2NyWFZkTWtHM0JzZ3hTRHRCOUVWakF3VHZm?=
 =?utf-8?B?b24vU2tmTWRIM3RCcWlHL0VpK1ZGSmZSb2Rsb1BENHlyaHJGeEp0VkJ5Y1ZN?=
 =?utf-8?B?NTBUQnBkeDBwRE8zT0FXUy9xME53bEVFSGVJMVdHYWNucGlsODlPekNNUnlX?=
 =?utf-8?B?ZUJrZ2VCTXF5cHQraEgxcFhRYWRTSGd1cFNrTmN1WjVsQ2w5NUZlOHBidHM2?=
 =?utf-8?B?Z052VFNWallSYVBpZFlLalJOVlc2bkNjb2VtU1BGWmVMV1VSUVkyQ2NXek9M?=
 =?utf-8?B?d2REOE45Yk55Sk84ZEhmVncrTXM1NUs5clhrOE1MQzJ3S3pQNC9OSnBXcW9T?=
 =?utf-8?B?TUg5dDJiVUE4bkc0VTJ1VmtaeHlXZk5WM3YwYmlrRG9WL3Z6aWk4TFVadHdO?=
 =?utf-8?B?L2RXVUFnS3NtdXh6dExhL2J4a3RoWlZvajVVb0ZPanBIZG5oaGcvREM0bFU1?=
 =?utf-8?B?YUd1dHBOVzAyM21JUWNqUzB2d1BKeHN1b3VvWXNsbGFJTUxFckZReEwzY2tD?=
 =?utf-8?B?LzFZNEc2b3N3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTVjNThxMzNIR2JYblV4b0FYT2ZNNVB4UHNKREw4WURQY0NlckErVlBleExh?=
 =?utf-8?B?dXRtSWtqWm9FNVpiQ081NFhVNkk3RC9UR1FRRkNleU1PVldVZGovZldzR01O?=
 =?utf-8?B?M3NpaDhBVFc5NmRrVGRDVFZJUzRDRjh2YVpkMmg3NHUyUklSeUhQQ3VNdkM5?=
 =?utf-8?B?NWZlMmhsODFmMVNMZkIwa0RkcWJPdmZQbG1UcXJhQzVJQUFDRzk4ZHhBQk0v?=
 =?utf-8?B?T291cmdSUkNzeFZleGFMdG10UkJGendieGx5bmRjaGZkT3dodDdSV1FTVjlI?=
 =?utf-8?B?MEZwZUlkM1c2cW5FbUQvbU4xWGd4aWRaWmgwa2pOODEzc2M1RHdjSFlENkww?=
 =?utf-8?B?VjJkWFZBOUFJYVdFcS9Dek54VHREZldIZ1ZqR1Y1aGFUTk9pU3ZkNGtZbzQw?=
 =?utf-8?B?ZHJCcnZuZGZzT3lsWURFMFp0b0k5NndCckU1UlB2UzZmYVM5MVNWeGI0U3FW?=
 =?utf-8?B?bmY3eHZ5UTJDdGZuaWgzQVpmUUJwWWxUTnRUNVFTVVVmc2VsME9vMHZZa09j?=
 =?utf-8?B?WWRJTUEreGJWNDhhdmhjZkZQVXVOWFhKT1Byd3hPYXE5ZTBFZGd5TFBFUm9r?=
 =?utf-8?B?SDhObStaYnJKUVBmR2VyT1V3REllRW1PUDd6VHRQeE9PalU2clF6ZXZMc3h5?=
 =?utf-8?B?bVpFTWpCRGp0eGxMMnhLd2xSRVdLbTlRcHJtSUwzMEhIWjRwTUVZSTFJWXRk?=
 =?utf-8?B?Y21xemhJNDdTYmFFeU5MTkZENnBPVTB2V0hzbE9lbndtWXJ4ckQ4V2YzdSs5?=
 =?utf-8?B?d2FnNTVJNGh5eGlra1d1aENLQzQzZUVUQjM2RElZNUFVbUVLYlprUm1xREw3?=
 =?utf-8?B?L1F0NXdJYThPZXhXQXBwSENiaHIyQmhmQ00rMGN1VmtLTmVSaE9ZUHVuWnRT?=
 =?utf-8?B?blYzZW5KcHFlZ25BS1BGcDJOcGl6Q3Iyakp3WTV1cjNFS3VORnNpMlIrbkww?=
 =?utf-8?B?SFJKR0o4U1hOWUxYVitOUmlRVmZIc2pGMFVwNzB1ZmdHOWg0VXoxdkJXemZQ?=
 =?utf-8?B?dlhnemdDc0N1ZGZEcW85SDNwWkxzblpvRzdWNURZYVJ1azZGUkMrUENGL2U1?=
 =?utf-8?B?L2JhUDdwdldjeTBqZnpOTHh2NVlFWS8vRnBvbWpzbmRWMWVJYUR0SE9uY1Rz?=
 =?utf-8?B?VGpiOFBHQmpxak5DZndLR296OUo1eWFWa3dXYkprd2VRdCsyejllc290c0Mw?=
 =?utf-8?B?SEpoU3RDZ3ZRMVlHaktmT3pVWnBHcDNhZEM1WkV3L2E0bVhoc1pRZG9KOVZF?=
 =?utf-8?B?YVVHVktLN2luaEpKZlBRKzh4ek5uNzhseHhpMGNFL0RWVndDdkkvWGVnWHVS?=
 =?utf-8?B?bGRUdkk2em4vVTYydnprclhqZ2JEYlJvWS9oeU1JM0lHd050V3Rwbk5hUEIz?=
 =?utf-8?B?cHNuR0d3aHVMWm9PMTRMdkNyUy81NGNzVGRZZ0RuajVnUHIzbG1KeDBlYXNh?=
 =?utf-8?B?K1lqMW1WRkVTN3pveEcyN3dua1JiaFkrT056b0NEdlRmRjl1ZlgxaW9vdG1x?=
 =?utf-8?B?aHp6b1pPbStWWHJ1TzhnUkdsSmltTTlkOHcrWk5wbzFFSmVHYUpFSWNUc29M?=
 =?utf-8?B?eEpxUEZrbC8wWmJEWjNDeDlDWkIrK1IxUW5DREpBcjFPSHN3Y3Brdk5vdWth?=
 =?utf-8?B?b2svWVdUMU5CczliQlRCclIySWoyOWtFZklrd09iVE9GYUNKM01rRDkyRG1Y?=
 =?utf-8?B?UC9TQkxqR1lvZTVkYzdyZHZreE5QS1RVbXIvTnMwMnBaci9EbWtpR1BiVDh0?=
 =?utf-8?B?bDJlbk9DbENFY2V0K2RnMVhMVDdyakpjZWNtMk5RUU1FbjJpeFhsSHpkQU1h?=
 =?utf-8?B?UC9rUXQrSWNTTHJLV2RVU1VuV2UvREpTc2Rpc0FrZHhKRitJdm5wT2xzblJE?=
 =?utf-8?B?aXJKeXZCcHh2NmhUNFZyM24vK1cxYkJzWGtwK2xIazljUUxMaXp1a2RVMlZw?=
 =?utf-8?B?Zis1VTl5MmYwR3AyUmJIWEh0aURTSHl0NU0yTjlzZDFtUEwrN2RKTUpDc1Rm?=
 =?utf-8?B?WVlqcUY4R05haUdrNHdnUEFmRXMzdFB5VjdHbW1yVmd5bFFEZS9BeThsbU1M?=
 =?utf-8?B?d2t1dUJnMllBV2tYQ0pCdG95NEJUcExxZ1Z2V2hHckdYN3FuL1dtRHJ0R1JT?=
 =?utf-8?Q?X+TculdyfD2UVtRTCHeojk98O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591d6d5c-b9d4-48de-fa98-08ddbf8cc19f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:42.2485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/lsEPCRrESic5vg7gjgx18K4xMg+/pLmPvzwl7h5biMwx4UnxzhQOlgi4/W9R8fEr0uqKEwJiBAQDvXycUNgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

MISC protocol supports getting system log regarding system sleep latency
,wakeup interrupt and etc. Add the API for user to retrieve the
information from SM.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 78 ++++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  | 19 ++++++
 2 files changed, 97 insertions(+)

diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
index 6b86c35c192d02e13f0d2a7d713bc447886b84bf..193a862cf9b807232f04a6dbbd6a8efd1b40ff73 100644
--- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
+++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
@@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
 	SCMI_IMX_MISC_CTRL_GET	= 0x4,
 	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
 	SCMI_IMX_MISC_CFG_INFO = 0xC,
+	SCMI_IMX_MISC_SYSLOG = 0xD,
 	SCMI_IMX_MISC_BOARD_INFO = 0xE,
 	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
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
@@ -372,10 +386,74 @@ static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
 	return ret;
 }
 
+struct scmi_imx_misc_syslog_ipriv {
+	u32 *array;
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
+
+	st->num_returned = RETURNED(r->numlogflags);
+	st->num_remaining = REMAINING(r->numlogflags);
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
+static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph, u16 size,
+				void *array)
+{
+	struct scmi_iterator_ops ops = {
+		.prepare_message = iter_misc_syslog_prepare_message,
+		.update_state = iter_misc_syslog_update_state,
+		.process_response = iter_misc_syslog_process_response,
+	};
+	struct scmi_imx_misc_syslog_ipriv ipriv = {
+		.array = array,
+	};
+	void *iter;
+
+	if (!array || !size)
+		return -EINVAL;
+
+	iter = ph->hops->iter_response_init(ph, &ops, size, SCMI_IMX_MISC_SYSLOG,
+					    sizeof(struct scmi_imx_misc_syslog_in),
+					    &ipriv);
+	if (IS_ERR(iter))
+		return PTR_ERR(iter);
+
+	return ph->hops->iter_response_run(iter);
+}
+
 static const struct scmi_imx_misc_proto_ops scmi_imx_misc_proto_ops = {
 	.misc_ctrl_set = scmi_imx_misc_ctrl_set,
 	.misc_ctrl_get = scmi_imx_misc_ctrl_get,
 	.misc_ctrl_req_notify = scmi_imx_misc_ctrl_notify,
+	.misc_syslog = scmi_imx_misc_syslog,
 };
 
 static int scmi_imx_misc_protocol_init(const struct scmi_protocol_handle *ph)
diff --git a/include/linux/scmi_imx_protocol.h b/include/linux/scmi_imx_protocol.h
index 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..4283f09d7185e980c4fb18aadcba16f64cb341a4 100644
--- a/include/linux/scmi_imx_protocol.h
+++ b/include/linux/scmi_imx_protocol.h
@@ -52,6 +52,23 @@ struct scmi_imx_misc_ctrl_notify_report {
 	unsigned int		flags;
 };
 
+struct scmi_imx_misc_sys_sleep_rec {
+	u32 sleepentryusec;
+	u32 sleepexitusec;
+	u32 sleepcnt;
+	u32 wakesource;
+	u32 mixpwrstat;
+	u32 mempwrstat;
+	u32 pllpwrstat;
+	u32 syssleepmode;
+	u32 syssleepflags;
+};
+
+struct scmi_imx_misc_syslog {
+	struct scmi_imx_misc_sys_sleep_rec syssleeprecord;
+	uint32_t deverrlog;
+};
+
 struct scmi_imx_misc_proto_ops {
 	int (*misc_ctrl_set)(const struct scmi_protocol_handle *ph, u32 id,
 			     u32 num, u32 *val);
@@ -59,6 +76,8 @@ struct scmi_imx_misc_proto_ops {
 			     u32 *num, u32 *val);
 	int (*misc_ctrl_req_notify)(const struct scmi_protocol_handle *ph,
 				    u32 ctrl_id, u32 evt_id, u32 flags);
+	int (*misc_syslog)(const struct scmi_protocol_handle *ph, u16 size,
+			   void *array);
 };
 
 /* See LMM_ATTRIBUTES in imx95.rst */

-- 
2.37.1


