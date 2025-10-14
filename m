Return-Path: <linux-kernel+bounces-851814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 689B6BD756A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82AC4087FD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877AF30E0D8;
	Tue, 14 Oct 2025 04:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BSK1zS4q"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011066.outbound.protection.outlook.com [52.101.65.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B230E0D3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417723; cv=fail; b=HPxT6+FD9Zvb/iHqpTnsPMq6belvxQdOo2NgNtSRC/5UTLifr2FgzaKyc5Vuz7q6/JJQAO9gZxET7AptJth86ChhBTlB272R8dBGI5vFi5YTy6zIYiL6OwBp3ooFuQZHW1ayM0ziPflL89U6eDhujZ7V6B+UxAbiy5dz+OTgclg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417723; c=relaxed/simple;
	bh=vYPwd77EUKqnf+7pARHql3LgApUW4JIhySkvzO4pb2I=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=CnQ2bNgcEAJ0tQw030kE8+Oj1MAWGCxS5rh8mI6bybzVFJV2EOz2joUI8q3PAojNP/b3FJT3ce1xLBDOT2IiRn1jE8s0iLtcwjr11iwMtlQuS2tnJqt7Be8b1Bnb14Y3/OJrYgv32EnvC88ZglP/qfXPLOBrq6NGHSzgppxQ+2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BSK1zS4q; arc=fail smtp.client-ip=52.101.65.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFTJjN7P9jqh+MPUSQ5gPJyUVaYRdcoZdkgEaOj9cKQlcId4BE3d+oxnaM8eHbhq5b/U2MG516XE2W3CzXSi0Ituj2kW7D0rn3lkB3cH4vqouvAQM84d0pfQa+EAYTQBS3tzWQNcwhMoPo4vm/BRUGX17lb2KGe3N/BAwcOoNHo1pcMn7243YlVQfGdhd9gWsGT1H97URQ22hLkXI9wbtFPrp/zb3xWptzTOQU7FyIF3SBl9oBUN7Q5aNTnQE3S95k4j6tQLiFah/1j0iB3cQE/yjpwjpUXTx3YgLRlUYZ7hU3pKDcbV+KlAlvLweDEqazSxSiEQu+D9384L4GjyZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFEH9fNIyDczBfRhUWNOlHfy5244QOBxy/5g8vmgrSA=;
 b=mOEJt1tcL196OUeX2M+t3ZvbgDeE4K1lh3E70LDgMFnTBAXXUhIqIYYGTi430woIdOURJ15zHVHpVZXcUVJ/wKyVDI4/skA9NI4dKZmfKsxgkS0F48l7d5GTV8CuWRzEJSd657tSi42Un+fRlCVvCMWzdX1kubOARvJu9gp8mzsGLmDwGqDrQGSWlFIR6H8q5Y7/NGGkNsVIBwVfRnnWl7fKmrHBS/iM68llODhlHRF+AoPQhhFxz97IlCW4hGweDcLjfq3GOabsgQcP7xbjI8Vjn4P1mKNBDNUnhWtrcasdzMowVDTkgOfkDp38CYIgKfls5olk28z5FURlNJLlXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFEH9fNIyDczBfRhUWNOlHfy5244QOBxy/5g8vmgrSA=;
 b=BSK1zS4qvHjfoDGiHBAwHNhDDsgdQi+zGO1zGGfzuCRNjAw3UaogPA31ncsO+06ViXAXiZUwrEq0TzTd32Xpvz9MFlJ4mhy+B9qIm8/hG9WivesJT3w2SrYXOPr8Kz0+uaXI0YFMxNuTAKoG2FKRqALq87bhgSkcT8FPm9WGrZXlqZf51jSPifjvsmvL9DeWaERiDPxI5y/7gxKNRDUwe+5I23dJK6TAkaj667EMjWddXrOOHg/nFsu00KlKyvGMCuWu8tEornrrXO0Pn/2PidaUiPatlMnE9FrXzxRfIItrKYM6f4f0y6PVGzMj+pMHYiKQEjjFs2WgscrUUQAnJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:20 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:44 +0800
Subject: [PATCH 7/8] firmware: imx: scu: Suppress bind attrs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-7-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=737;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=vYPwd77EUKqnf+7pARHql3LgApUW4JIhySkvzO4pb2I=;
 b=QPTlearDUUJpwY17xHaa3SjUaF7xT1Ws+J44CGV4Pac0AsiuQQl0gaNP1SXmE4UjBd8jyFjzH
 Bb8/3mbNSOeDcEZJ4rlM6PfYeKTEq2x/ljzc+aJMY+BiN+Qu2YOrKaz
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9838:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6bc9ea-058d-4cb6-2998-08de0adde024
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2lkU2NrQndnZ0hraURCdlZaZ0hoQ0w1bG12SFpJY2JpZm10aWxrVGtJNTht?=
 =?utf-8?B?TDY5alV6YXhMcnZmRUV5NkQyZmZ5SzNGdk8rY2VONG9BVjlhbDMzQitTcVB1?=
 =?utf-8?B?ZG9LUjVVak1teERSWWMrRU1yZnR6dG9PNDIwOFZDVnY0d1pVbWxZLzAvQW8y?=
 =?utf-8?B?bElmQ1Z0aDlsdXZWdnoweXQzUHpRRTFWWFdybGZiUG5obHA5WnRVa3d1K0Vk?=
 =?utf-8?B?OW9vZksyd3hkNnhPTkxoUkxyQlVSbFUxRmplV2p1SFM4UWpSS1pxZnhvd1J3?=
 =?utf-8?B?dUVZa2c3RENIN0FhWVU2TnlwZGF6RTA0L0YrNnp5U0NiMSs5NVlwRTNPWGFR?=
 =?utf-8?B?d2NDa3hya1d1UUxHOGppTDQ1Q3JMd2Jza0NINnNFK0s2VVg5d3RBcHIrV0xZ?=
 =?utf-8?B?UGNkbTNxKzgvZTZ1V2owOUJzaE5CL3hxU2lVc2laOW40amxiNzZ4MVNTdGMx?=
 =?utf-8?B?U0lab2hHQkNtUFh2VCtuUEphdTh1QzBWOWNLb296Qm0wVDB0ZkozdjNNMi82?=
 =?utf-8?B?cGJVRUJvSXVUN1dYYkpyTDdGUlNiUFNkVUl4UEFtTXhMZUlTZ1hlYzBlNjhz?=
 =?utf-8?B?T1ZtZlBoZFdQZEFzVER3Y3o4S2RtaUdnUkpPR0tianJlVGlXSzUwUWZzaXdy?=
 =?utf-8?B?a3ZwNGhyNjNaL3l6c3pUK0hYUmZMVzdnQzkzakJ3eDNFSWtCR2NVanYyL2lZ?=
 =?utf-8?B?WUxoSWZLQ0dhVGpLOC9XV3RZQTlyVGh0WUJCYXczT2VXcENmQ3IvMHhyQ25Q?=
 =?utf-8?B?Vkh0VWRXQTI4K3NUY0tOV2hwWS95aHlrZDdtVjI1NHhqMjJXOTNHRmdGc2Zt?=
 =?utf-8?B?OHpSVWxvemNITUNKMEN3VzJUWGlieHlndWdOQVh2SHo5QjZZcXFEd25jUlJ1?=
 =?utf-8?B?TDNUekYzQ285SXV3L0g3dmNOWDRPQlZncklQYXl2Q3BHT0FSdDRYM21OMGwz?=
 =?utf-8?B?THNJNnhhVHdyRUVJRGZ1ZEZyWE5VQ0NVYkNGMEVYUXFYTzRLd0tNaS95U2pp?=
 =?utf-8?B?K0Q1eGV5d3dhRHNNb3RXcUFxb3hmazkvTGFqRm5XSnpLa01aMTNjWk0xMlgy?=
 =?utf-8?B?Y3dhNXlRenhDcS9hRGN3UDNWYzlkMW4yV2JSL3BuTlVnT1dGWnFjdEhzUkFJ?=
 =?utf-8?B?WTB4OGYzMm1DUXk2dDJGRWhXRlg4Z0ltSFFTamJ6OXNGV3A3RGFvQTRpR1Fq?=
 =?utf-8?B?UG8ybmZ4QVd3UnUzZDRwMnNaWXJEbFhCc1dOQ01HQ3dJOHRENTIvNlhxWjg1?=
 =?utf-8?B?WHBTYzVrSFdvZ0dtNnFFcjlyNWpZdDFqV1lLTFFZRk9IcFdJTzRtZ3VqT1VX?=
 =?utf-8?B?N2VMUnlWWkJxdHdJaTVtUnJWYVpzUmxvTTRLbzNFMGxHRmE2d2lHR3Nkb281?=
 =?utf-8?B?dmR6RUhuYTBjMmthajVHamhRSWdmSUlvc1RVbGNwMlNxWDVOZ1Zpei9Pd0kw?=
 =?utf-8?B?Y2h5ajd4ZEcwM29sQzRLeHVTL0JOS0IxUU4vbU14SVhsQW5YYVpoc0FLVHI4?=
 =?utf-8?B?K0x4dHlZT044b3MwS3NBcXZad0lVUFZWYlZRWVVXN1JwdkNBcWFxVWVDSVFj?=
 =?utf-8?B?elRoRDVpS01Ma0dJRURVZmlZN3BHMEpreHE5TTlES042YTJ3YXdGZ1h4OUdW?=
 =?utf-8?B?QjFqUVd2WE12VE8xaXp1VWJvajlCdFFsR2lsZUFqR2xNdm5EZDVQWHo4NXp5?=
 =?utf-8?B?T3JoZkJ3Z0lpd1VtVk5iWmxSWnFGSXRrTnJGTURESVJ6QlpYNFRUQXFtK0hV?=
 =?utf-8?B?T1cvckR1bzNFOEV0eFFDK21RRmVjQ1hRUGhUZkJPaUQrT0tRdTE0K2xyeHpJ?=
 =?utf-8?B?SVZoZlVqV0U4OEE3SmI3MXZGNmR6M2pzZm5xRzdaL2dHZmpSTjVvVkhtOXBF?=
 =?utf-8?B?TjN6WkN1VEl3eTNGRXlZZ29yV0F3Tms3dUh5THh3UWFVUjJvZzA4bmtZRmU0?=
 =?utf-8?B?ZUt4dS9iaDIyQjl5TGtINFA0bEVWUEx3VU83bFBrT3hVTTVZSUJzQ3lYSkhi?=
 =?utf-8?B?ci8zenA0bm5wc3FuY2VQMGlNOWVQeDNoekR0WlhvOFV6NzhvUGZka1E1R1JJ?=
 =?utf-8?Q?J2VjXI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGkvU0N1aXJRSzJpWlJGRkNxeWZ6YWVJeFJVMlhrNGh5dHhNUFR6cmN6b0lO?=
 =?utf-8?B?UVlaWjFjZW1lSHI1RHlNM1FOYWdCZFg5eGdvb01ZZi9TcXl6eWVOeE1qY0RJ?=
 =?utf-8?B?VUFsWGdNUzlla0xxcHJPZDR4TEw4RmV2U2kzdkhWcy9ndkNkblRnaDVGQnVR?=
 =?utf-8?B?OEluWjRSYU9qTFR6T0Q1WW9VQmFUVURjVkIxcXZOOUN5MHVEY0Q3UWZmeC9Z?=
 =?utf-8?B?OGdOeVlrdDNEM2UybWpBaEIvbE5ocG5wOUNWYW5XbzIvZ1hvVG95WVBEQU9X?=
 =?utf-8?B?a1lqMG1pd08vVVg1bnZnWW9HamR0RVk4dGtqLzBSaXh3TGpmakNmOGJBMzdR?=
 =?utf-8?B?SURmMU5ocDQ4SmhLazcyTk5GVTNHTHRuWUtaeGI4ZTE2cm5xTHFBL29vZDdS?=
 =?utf-8?B?T2Y1L3FkTzIvVjFlZ2pBL3NwREoydmIzTzlaNE0rNGo0UnZ0SmZEM05GSWta?=
 =?utf-8?B?cE5FaWN2dmpYSkZCU2lUOVJTTExwNlVaQ3hxR1RUS25zeWQrNmwwZGlpa3lY?=
 =?utf-8?B?UkQxRUNHWVpXR1Jtc25Gb1JCUXA5bllUZVVzMzJVd0xsNEl1blpGVUdyUlVp?=
 =?utf-8?B?TDgxdTkwL1AyU0hDL1hsQnVVcXdFMXhGbzlKOUViVmdLNXIzbzJzbjhlWjRn?=
 =?utf-8?B?bG9LWU1oNVprVlA3YVZGaU5jWmNFamZHdUpkM0MzcndCYis4QVJmeEo3TjY3?=
 =?utf-8?B?aElRNkg0U1k5S2c4OThVYmRSMG85SExERmNJdnNGVkQyQzB5bkdMSmtCM0M1?=
 =?utf-8?B?SkhmdXkzcWdLeE1kbWVWUzRYT1c3N0p5WGJNNk9qdVloelFrTkpYczcyVVJi?=
 =?utf-8?B?Z3piSmNKM0RUeEpmOEhSMWpTbFZWMmV1NVgxcHU5dXptTXF4M0JtVWpGWVVw?=
 =?utf-8?B?Qm9sSEVKVmVXdkxZRjJKNTVQeUx5L0E0Q3V0NUJncEdPMEdQaTNlU3g2cE1Q?=
 =?utf-8?B?S1RZZGZTU0pWRlk3cjc4MUY3VG10bTU1dGc2YjVYTnBHU3RZbUxFYVV6UGo1?=
 =?utf-8?B?c1lUbVNLb3FibFp2YkF1Rmo5TGplbmEvMHY0NG9kRXNPVWR6U2h4QWxCYUV3?=
 =?utf-8?B?cUhWTXFEWVI0eEpnQksxOEw3b3VTM0I1Vms4WlVWRUk2Qy9XZWRLZmdwOVNY?=
 =?utf-8?B?WGRHcjdmTExtMmFONTB2OFYxWFRqUGpybnhXRm9tZGNNMExSdE9wYk9jTlBN?=
 =?utf-8?B?dUd6VE8xYSt4U3dzd0FmbE5iSFVRU3VvN3g1V044cnNySW9JYjhXMk9XR1Jo?=
 =?utf-8?B?dDlIZTB1bUdhNHpjTU9JVE5ZWmh1NW94MnpiUWV3eDNuTC9zOTBLVTVSeUtL?=
 =?utf-8?B?clpmQm83ckkzMEhCS2dEQWNWUFBlNWpvS09TQ2J4YjRoekh2aWJSd3pEQUFC?=
 =?utf-8?B?NGhzU0ZmOEIzQ3lIVGZyV1NEYjRLdm5uNEwzd24yRjJmWVdRNFZ3dVRnN1ZM?=
 =?utf-8?B?bVlLWE5KQzJqL2JTZG1qSHpObEt6dHJxZ0s3cU8vYzR0UU01YTNXaG5temxR?=
 =?utf-8?B?T2FqOUsvKzd1YXMrcGhVNkF3YTIvRFdYdjRlV2R4RWZTa3Rod25oazhMeWxn?=
 =?utf-8?B?RUw3d0g2aElRczZlZWZ1YmhRaGdPdWJwVndvb1NDS0l4MS8reXRRUU5vSVNY?=
 =?utf-8?B?Ky9kOXpvbXVrOCtMbllkZGt5ZWg0NElGYy9ZUk95cS9zRXdEWVF2UzVCazFI?=
 =?utf-8?B?WlpnZWd0T05wby94N29aWmZyVEdnZmpJK3hRSnlEVFVGZWR1Q2c2cVY0VHRs?=
 =?utf-8?B?bEtzUExEMmVHUGtNQ2VybGdzMUJJemdpaUEyQ0ljNlpNOTg4U2dPVzdFcitS?=
 =?utf-8?B?alZ0NDl3M1E5Q2wyS3c4cFVqWEZ2VWQvelNBcnpZczdnaklKMnM3ZURUWUdH?=
 =?utf-8?B?TEhQUHc2cnV4cUlGbWdSV3pKRzdzQ3FuMWVLb3N4WlljSHcyNDc1S05GYzRs?=
 =?utf-8?B?QmpiaGFuem5yK3Rsd2lRcDBlZUVzSEZXT0tqRnBrTjVNak50SVowM1lxYmtP?=
 =?utf-8?B?bkhKQlEwTVpEVE1BNjR0R2traklLeFluSUNmZ0E4cTJTa21TQkRHbEVtMUpz?=
 =?utf-8?B?V2dyc1htZjJlNDNBSTVFaHlENnY5VUtlT3FhUXV4bm5KT0FKNEpzMmkwRFlU?=
 =?utf-8?Q?QgnTWVsb2iJp7bi40B4Y4EiXn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6bc9ea-058d-4cb6-2998-08de0adde024
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:20.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O+A8Is+FLakhye6VmSqBzHqnXViyo1tBrxq9hehp6sN/hHi/vZKtJelZ/Er/k31gDz9d7oEUKFZVkiSp9fXYUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

The SCU driver is critical for system working properly, it should
never be removed and binded again. So suppress the bind attrs

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 6046156bc3c9abcd8f62b46f04571b1a9decc0eb..630e3dba4db15961ae4d77273af6248be614145e 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -352,6 +352,7 @@ static struct platform_driver imx_scu_driver = {
 	.driver = {
 		.name = "imx-scu",
 		.of_match_table = imx_scu_match,
+		.suppress_bind_attrs = true,
 	},
 	.probe = imx_scu_probe,
 };

-- 
2.37.1


