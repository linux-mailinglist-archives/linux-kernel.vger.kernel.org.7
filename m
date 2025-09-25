Return-Path: <linux-kernel+bounces-833231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 804EEBA179B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A4EB1C8042E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97667321458;
	Thu, 25 Sep 2025 21:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="G4jYBJsy"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D031D74C;
	Thu, 25 Sep 2025 21:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758834853; cv=fail; b=okmpfQBhNWc22nKxGcnm9n0G2amNzghhTd9RHE8yVcwIKQZf8G4KdLHzkJCbtThTgVI+EMnIIjFDFH6B5c5AqtTqhtKOfLczMlukwEVYRKJnqmd/dsgdf5lUinCdrzTto2Kbp0mxpaQwFu9+6X7jgLqGU2aaiWW8KMyaHz16MWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758834853; c=relaxed/simple;
	bh=R8vpBKnpkLEXT+66UI2YmUmOQ2ZWT3iQri50kkI8l90=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=emBAGlKEaanOcgDoM+gBNQGn0JVS8hU1EHN74sw74FdG6kThmugsnMLOhyjq7WBO7JE4fKclx1iWOXudcQBhxqfI1WXouUkd2HnrYmsD5MuGwJVqr7W936FrF6SuqjIO/1MD5iaL9OmczjTRI2HNDmfSPeNjd2Bw9IRt9ndeVkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=G4jYBJsy; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i7xfoZvq4rJmISH6XyLBNMx5LEQFh2Y3D/jgDBDefPaf+0ujvHvW5NZWRoctEcBVfLvGm8GW/jZ32HJNzPyDtRF5FJptAPDzelQKJzpW9aSHOPpN+GpQhn2w70zesUHzM8Pjnyun17MZHB9nG95xpV84Fz/63SzMJ2JKEUDIz1QzOHgx4EdrEXURkJXxRSKl9F7pfPjWcnVhqdeGoQeVi0Hp7AQO7AcUTdckZLXoANmEq1EXxaH/tLpSilF+yrSROShiHUa25InoXnKd/Xf91NsUd8YHeOVwz17YumisapFolSS1RQfY8hZBppLr3DBaew7ee6TtuXdK32Ul6tGhsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BF8kK5IxVUpqdsFFvM0QNG1y/iEC4Ok3DOcmKjvyD4=;
 b=cgKoGtMEzH0VbD7QzRIcfcZmZpfRSYxPeiTrMJHOa1W6qjzHziNHQitHR6EEQQx/qFqOYcpF4w47UFvOoQsYNrE55x9QynQVprKGT49mfCX1vBzEqYfakT1KRdEm4TfRpFnczPm2YVFzVkfiY2Xt9r3xfvszRjtMYV53MdzFkl+O3A14A/7tZThxm9jB9q5k7TbkJanqXk1ZZu4vjh+uJtywdBlPGZu4X7Tuo1mH8D/cZI//A57Uz+yB1igq7vPo5qQCCi4PJp5nJBDLwNDFzs2uEHZ0oth06aab5nTADKtImnJq6uIuo33pajCzbL7y61v8ntUl96h6vJ9qwC+f5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BF8kK5IxVUpqdsFFvM0QNG1y/iEC4Ok3DOcmKjvyD4=;
 b=G4jYBJsyRBIqdIogCr6YkS4NQO0brlayYsDSo2259HpywBdDzxO+6qoO3kofJavYU72b7DtoS/YDI7NHhqUeJ5IG/mKDgpxFfGS8Pu5sf8STgDLDiuERhw3fA4WMdpoY49r+sj3FMd1HghgSU2C1H+b3FaU+fZ7pL1ezRLmhJiMO9MsuEUCMzXuiD12WDvQoZ6wp99fkwSokxDOvelxrfIlKF46xUuhwsKbO8zB8tMejGbK0aFhtSk0mOuBzZ0EbTSf5jZKdifaFJlCWmCTsyprgYEGksb1XwPjWnY8OCz7+1dShqZKAX2DNtGswHSO4NlUeNZlYtin7DQrqClh3sw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8865.eurprd04.prod.outlook.com (2603:10a6:20b:42c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 21:14:09 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 21:14:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 25 Sep 2025 17:13:46 -0400
Subject: [PATCH 02/11] ARM: dts: imx6: rename touch-thermal0 to
 touch-0-thermal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-imx6_dts_cleanup-v1-2-748380dd0d22@nxp.com>
References: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
In-Reply-To: <20250925-imx6_dts_cleanup-v1-0-748380dd0d22@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758834839; l=2692;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=R8vpBKnpkLEXT+66UI2YmUmOQ2ZWT3iQri50kkI8l90=;
 b=pGBXa7oyrr4VlV0219ie55E3TssOT94nWWJ7BPsIemYllHGtnFxVMVr4UHVRDRdci06KQt2Lh
 G+emG/mhIfzAV9MY2WG76jm+dJj+cL5m8wUxfAQSpLq/Vu1DdCSKknd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 97b60dbc-9313-43a2-18ac-08ddfc7877d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0grV3d5Uk9WcE5MN0xqRWR5djR1TFZJclJ0QkVIMUhYR1NrcytlekNGdDBK?=
 =?utf-8?B?Vkx2cWJPaDMvbkRvejgvTGRZWE1UVHFJUGNCVHFHS2FxQVRjUlJNelpRNHRk?=
 =?utf-8?B?RjZvZlRBRy9sWnFpRjVnVnVSZGF0Ny8vQ3JDUUFPaE9qbzZCQVdtRUpkYWM5?=
 =?utf-8?B?MGRsZHJzaFVXT2hpUjh1TEU4a2pCc1BTbHdNSWlxQWI5aUNua2t5Q0ZGT2Fq?=
 =?utf-8?B?OTgxa1Q1RHdzTkE3YXdkZ2xrRkswVCt2RncrVGlScllKemJ3bTBBaytKMnJx?=
 =?utf-8?B?bEo1eUpIWE5QOFZsTmJQRTRVZTNjMlo4TEFoVGpOL3h3M3pBRlcyM2JoWVBL?=
 =?utf-8?B?SDZpMzhwOHREM0JOZFRscWlFSXRNblVSSnZESDZlNm9ORWZsYXkrdmJ4ZUhq?=
 =?utf-8?B?c01qVzJLSldtZ1c2V0pKRStRRzBqZHMxczgxYzQrSXJwRlZZSVZiTUxhMkRZ?=
 =?utf-8?B?aXdyNEEvK05pRit3RDFVdERGMkNmNlI2aGkyU1lWWGxQem84OEhLM3oyRFJX?=
 =?utf-8?B?aVh2VVpaSVN1SkJIVG9qc1BwUzhqK04xbGIwTE54RHhVSTFUaUNnREdTNDN0?=
 =?utf-8?B?c0JuZUdBY1JaREd3WDBhMUt1N0ZIVlVpQWp1Q0xFQVpoenM4cEI2ZnU5WUtm?=
 =?utf-8?B?dVBPS2hVN1hsMWxwVjJhY2NPd0NLd3JxODJFa0RPamFtOXRxZ1RxUEp6QXBy?=
 =?utf-8?B?VHRoN2xrMXpWSUtOSWVKQzdkZmRldFEvcDdTdW82L1ExcDc4TnI0TFZSdzQr?=
 =?utf-8?B?RXB1bUlNOUpMS0FWQWVQWjRxWFdLaFJpRHFBTlRYd3ZvL3plakRHeXRrdDcx?=
 =?utf-8?B?cld0aHdvRFdib3NibXpGaWN0d1p1TEc4OGhrTzMydVI5aXBjT2Q4bFpSVk9N?=
 =?utf-8?B?SWFXYjdFNWFVQXJOVnkrb3Rab2hnbjJNOWVDT2VaaUZlTmJkWlJnSURvVENi?=
 =?utf-8?B?UXljS3dqelBRcjl1K2pOT2F5NFJLNkI2dDhpN1hTMENLbHhaNjNyYUpTdk1V?=
 =?utf-8?B?UWhzZ1YyQWUza21UREt1ZXhaRFZuemlpM0k0Zld2K3BpT0FsUHhZOHpGdENr?=
 =?utf-8?B?NCs2VHMzeG5VaVNxcWpiVnIyZEw5dGw1bnJ1NnNrRWZnK09LMDBLV1dIKytK?=
 =?utf-8?B?WW5GQ3ZlYXRnN2I2VHlPNWNzNmVpdEJXYlBBd1RmUjV6SVUwbVB4dXBDdW9L?=
 =?utf-8?B?RmJmc1BUd1FRMXhGWkhuYzBrWHhKWGE4M0YvUXBVTEJ5T2xENW1NREp2NTll?=
 =?utf-8?B?ZDE4b3ltUGV2ZzBGanhtRDYvTUpSSmdKNGpzOTl6REUrYlZSYW5LMll6TXQ5?=
 =?utf-8?B?ek80OS9Ja3hmZ3ducVlqUTFCUFh0U0pPQlN0OVBJMEdGeTRNd0M2ZXhFcUhp?=
 =?utf-8?B?bG1GTmNOWVplem03YkZrTDlIM3pLdXBXYVRLTVU0U3h6dnpPcTM2YmZBei9y?=
 =?utf-8?B?Zkpza3lpNWpDb3ZFNENTaFFwY0NOVFhTcGU1QXhtN0VqNGY0R0FtVlR1ZjFw?=
 =?utf-8?B?azY4QVV5ZEtEcHptRkJ2STMyaDQvekJleDZmS2l6b21GL3JHdHpJKzU4WHNY?=
 =?utf-8?B?QzhzZjk0eDlPOXdaVzFkaklPVlhORm1zREFaemREN2tEbEpVMEJQemJxN3RY?=
 =?utf-8?B?dllyajYzL0ZXSitXRC9xVlhzS1dXV1djdUIzbFUwNlhsTHM5eHMrRnRhMzdX?=
 =?utf-8?B?QUJMbDBueXd2RmNINmV2Q1BXSjVzQ3lEUFRVM29xSnptc1EvZnVMN2hzdWJt?=
 =?utf-8?B?dVlydzNwN1JsdWd0WnJCU0VXQU1iaWZJWGV3OUNsb1ptcmlKa01kNGFEMklE?=
 =?utf-8?B?N2tLNjZxMHR2VjhITjA5RlBVWjZqb2d6T1c1VEpMNmJaZU5sU1ExZlhaTGlt?=
 =?utf-8?B?ZjBnZG5vU2ZVQm5LcXgzaUVqOWtBSCtqeWtLNkZ1cW9nZGFSSktRZjNOOFhW?=
 =?utf-8?Q?cF3z7uS4TF8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTNBejE1ZmtEZHZQb25ib1BncVp1d1cvVVRHVjBDanYveVM5ZnFsalRoWkEr?=
 =?utf-8?B?QVIvcTdHMHNrbVBwSmZVL3M3MVpDY1BRZHd3eklybnc5bU1iaWwzbENYdGFV?=
 =?utf-8?B?b3l0ODFRVnFMTUtkNnlrSXZvTjVlQ0lYT2VFa3Y4aDZLMmRKbFgwckcvbDgy?=
 =?utf-8?B?MXZiVG5mTlhDb2dCMlhSVStnUkYrZ1cySi9VSDd6b01QbnpISUllNzgzL045?=
 =?utf-8?B?cS8yMUtNNVJPbGVCSVV6WEUwQm9HWnppUFp3RkNRck1wZXlNeVRXRC81UENM?=
 =?utf-8?B?N2dpVTd2NjZ2K0tBWFRKSXRyUnE1THhZUHFXUGtvY2ZrRXJrbVBLNnVHeW90?=
 =?utf-8?B?bWJTVlBpUnR1QjVlbmM5bXpHN3dQdUw5alROdXBCU2Q1VE1EbWFiTk5yYmRh?=
 =?utf-8?B?Tm9zSjlkWWVldEU2RFJhNzN4SWJTQndndWlScGRFYWtITmNWZWZQL3NTc1Vh?=
 =?utf-8?B?eS8rTm5EeHQxQUl1OUVIREdiZ3ZOVGpPVUUwN0paUDdhblFjeWF0dS9reGk4?=
 =?utf-8?B?bHdWTzErOHpFZkRyL1ZPNDd5T0V6RjlENEREbHNUSHpvNXNBQ0hVQndqNkdZ?=
 =?utf-8?B?THNLaE1hMFNaZ2lWK051QlRIc0x2TC9zbWlXN1djN0d5bzAyb3lMT2tNMGt4?=
 =?utf-8?B?ckZ3aFRsSlJMS2lLc3E2YWk4SWtOeXUwK2FCalorVXloL2tiU2Y1S3BSai96?=
 =?utf-8?B?eE5RQ1FLT1VQQ0RiZC9QejBvSU8xQVJmTWhLRzl6R2FzN3hsRmhMalJseFpu?=
 =?utf-8?B?R2pUNUEvVFMyZWVDMkZ4cGVhb2Rad2RESnFveVh1T1doY2hsRXNKTzN5TjFp?=
 =?utf-8?B?RzdnL0ZoY2RaMThzWEkvejdGUllHandlbTArcUwwOWpLSkVQZCtseERYYnBx?=
 =?utf-8?B?dmRMd2pzOXluODZCREZjc2NyakE2eDJXb0l6bHB6WjFPcnR3aTdLamZjQ3Bq?=
 =?utf-8?B?ZDM2Rnh1bmtiZjlBZ0c2OVlmaDJUQ2NLVWF1R0cwQTd2elNsWjN3clZvVHBj?=
 =?utf-8?B?VDYwMTVNL09nbHd6Y20wMDZXdlh6RkRLMGJCek9CbTlEQXR5RVhXYUtoSnVY?=
 =?utf-8?B?eFM4Zlk2WWNSZVViUjFDcGNvaWFMUHJYRnlmQS9SdWxka0xRNGxac3ZraXU3?=
 =?utf-8?B?N09Oa3F2bXNnZlNRbzVPMU9QR1ZMNXVUZFpQZ05XcFZlZTV6SzNDQmkwRHdt?=
 =?utf-8?B?aE9yQmc0eFV2azBWMk5wVmlYM0FsMjhBbkdCUllLeVA2ZWk3YjJvbDZDVnl3?=
 =?utf-8?B?OG13WndjWk1BY1hxZlh6SHhKRlVuMmdIeDhzUjRtdFZsekxycEhHVkZhWTRJ?=
 =?utf-8?B?b3hlVlkxM0F1cEp0MFN3Ung4SGpUajFwdER5UklqRjZ4M0UwcEZTYXhBMDZY?=
 =?utf-8?B?Rk1wTzB5MXc0dFBncU50UmpGNVVNSk1iU2dia3Q0eGRKd2IzQXA3VU9HMVps?=
 =?utf-8?B?dkFleHVseHNLQlpRRTFUWlRsR29OZEpnaDBVbi9mdjRhZ1Z1NjVNNjg0MjVi?=
 =?utf-8?B?WVp3c2hKMG1pcE5uS1ZmL005bW1rVHRUbUNiVTV5UWRqLzZheGFoeXF2TXg5?=
 =?utf-8?B?eXlaVUYrTXBsc3pFdEJpU3NGWFZoTGc1RjU1VkFmWkZ3VlloVnlWcTAzVzNF?=
 =?utf-8?B?NW1ReWRtNGJQT0NyVDQvQmRSNFpOaGJoYitkRng3SFNFdzZLZ2kxUzdHZStS?=
 =?utf-8?B?bFpKSDJCeU5pSVFvL3FFMjlzN3JobWZWSlFXbFhBVjJ5NmpkTXZGbFR2RnZy?=
 =?utf-8?B?bDI0VEJENWhPUzZvM2N1bG5wNE9mV3lnb3RrKzBSQkY3Uk9ML084Q2dGS29J?=
 =?utf-8?B?bzVvVVRFYTVGUWZHbWEvNHRoUlJsd1hMTjV4TURKZldSaXlMdDRGWDBWUmk2?=
 =?utf-8?B?dTdsMVgxRU1aMWg4Qk5wUVN3RVFxN0s5dkIwWFZtV2p0VDlPVEgwZ204TUlH?=
 =?utf-8?B?a1BMc3Y0Y2MrTXZrVlFBUVBVbU9PV1pramIzOTFlamFqOXdEYmZtSWJkR3lO?=
 =?utf-8?B?bEk3YzFubTlTQkdrN2JndnM4R09TTVpVZUdpK3NvUXdSSEY3d0VJSVgwejU0?=
 =?utf-8?B?UVd6dEZzRG92eVlDek1BNUJ0RkhaU0d4YVFxa2NURVNTajk0OEp6eDZId2ZK?=
 =?utf-8?Q?14FmK05I6Y6rOgQ26oNJV2Mza?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b60dbc-9313-43a2-18ac-08ddfc7877d3
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 21:14:09.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsWsUv6r9dEHU3Iux5kIGxdWv/HigAZWOrzw952wAqeaicJep5rRvv9VSIEcrItRdw0OoTKuyZSegurjWsgJWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8865

Rename touch-thermal0 to touch-0-thermal to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dtb: thermal-zones: 'touch-thermal0', 'touch-thermal1' do not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,10}-thermal$', 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts | 4 ++--
 arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
index dfa8110b1d97b14eae30159acc6daf74ae482eb7..da70908334d71f58aa53b13726a69c1db12ae1b8 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-plym2m.dts
@@ -123,7 +123,7 @@ alert {
 			};
 		};
 
-		touch-thermal0 {
+		touch0-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
@@ -137,7 +137,7 @@ alert {
 			};
 		};
 
-		touch-thermal1 {
+		touch1-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
index 29dc6875ab6680d316bc28619df883ad2411ab28..c9dc48c1f9b1c36e33a55c64b9fa64262f011f8e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtvt7.dts
@@ -256,7 +256,7 @@ alert {
 			};
 		};
 
-		touch-thermal0 {
+		touch-0-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
@@ -270,7 +270,7 @@ alert {
 			};
 		};
 
-		touch-thermal1 {
+		touch-1-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
index 4875afadb63005d101c4501b70f64761d732b86f..e258e7b3b3fe792d061002a6b70bef4b22c5e89e 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-victgo.dts
@@ -84,7 +84,7 @@ alert {
 			};
 		};
 
-		touch-thermal0 {
+		touch-0-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp0>;
@@ -98,7 +98,7 @@ alert {
 			};
 		};
 
-		touch-thermal1 {
+		touch-1-thermal {
 			polling-delay = <20000>;
 			polling-delay-passive = <0>;
 			thermal-sensors = <&touch_temp1>;

-- 
2.34.1


