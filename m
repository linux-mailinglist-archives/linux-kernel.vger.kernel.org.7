Return-Path: <linux-kernel+bounces-725250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F36FBAFFC73
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 10:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FAD4E31B0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C346233735;
	Thu, 10 Jul 2025 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FM2n2stq"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010070.outbound.protection.outlook.com [52.101.84.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D024676C;
	Thu, 10 Jul 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752136528; cv=fail; b=AJSX2mVFHOt5u7OihQ5DuF68TKx5SI7XEyTL5BTLV6AEed+5ZRMr/Ff/AEGVqDPbRBjPbB645Lxp49L0K73HoV1ywJrYbOTt/pHRtxX3XtzPyjuGJjYlYM85hLWLZsnsBWxHhPh1eL+UzSGyUSZ9PSQB+w9BWfPluGdUD7TriSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752136528; c=relaxed/simple;
	bh=8webyB4E6TCv2JNw9JWwUrInVpNtjFgLVpgJz+X/kh4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=X8SmjR4xR6pK7d3u65hxK6B+20a9m5OsizY5kUMijdpfnT9pmtIKCltSomqIyTDnj6tNrmQubw8tIYZEfUfebxJIJVbySCr3L25fCZ1LDfrf7JaBarHc9flepNyml71hGN0frqgJwtvY+lTeEIOc/HHlzdLWCJWKE9itwCKreuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FM2n2stq; arc=fail smtp.client-ip=52.101.84.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HvS646Nj8jHq+3kpqubgn+wcFayYXx8JLbRLR1hdcPVRWZVASHwO90t2egEJc3iltcwX3wQ7M6qaA5yq/XjLN7aLQuYfrTidzm24SEr8eIfeCihU2Cvc0a9DIV+JnK0La0kY4Fa7qSYX/fzB3lQdkoeg6mhGsViZOU2CeJDHNcb+ujPmWxJhsnY+IkN7jSUEZb25vQldMSZGoSBioIVAoAvHxJBv5azMR6DMoibi6DJfjawwuhv8jZPi/EzmQbXFH1kSsFEVjiDUc0eIW1MQuqAyQrlrNONEvnidjXzVuQYY4EUcEhJnObuSIEv2pF8amLGMzsaQS9Wfelx+cKX1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgEUh0SbJboNmRYgJ4YLouXa9NpT5Rrejtnatpc9JyQ=;
 b=N8qSnjQBlWOO3CxY0gFY4VK7SCo7FnOy3SGgAT0gDCJpS+FE7YyU4xSPlMJuFDZ42h9UO5D6k4F0+ecoMR6AIek6Dxn10KcvCPI7fl0YbAaFrYKWPuFDeWeF1pwspkIBnSzfjpiTOO0jeu26OAYMYZhgCD/M99aiEItOsk2f2Xj0klG3cH+wNrgnB8Cf7vpPMBgxK/Q9EQ2wrG25A6Ro8Yb0GXnx28UmTVVSAf2/6XPWIkw66tjiDc/AVZ+jR9afrd6ODWP60dnSxtAswt7dCE8GE/OhiwnPRKpKwCtsCsK73HMWLHP7xw6+cegWrOl07T7lfTZU0GKn7RgPLPpkaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgEUh0SbJboNmRYgJ4YLouXa9NpT5Rrejtnatpc9JyQ=;
 b=FM2n2stqLLplR+P8/Hz6QPDNI0RhMko/jrgH+JXeqrA1uPs8L8tda6iN4MB5Em76eIikes1fb4ONzQaNaEvwtAF/uyEhZwXrAU8gxjPJPNNLgGipSUSmyFd4YkvoBp1VQn/vLuBTqnr8+EfakufjEOAuqQpEBM/wggiUp7MS5/EjRw5bzOVdssshfwA3VY88iFE3j+o2PdAHEAwGk7TxB3uwQUlDdw0KUb7cFSm8oTKOxGJjn2vlbATqOfvEuXizBbpm9sc2o5UBxMjpnM/cpi4J+twrWs9znwOmo0iOuD+GB0JeQpqNfJg9KejPD+gGdUkPU23jmjDeH8ON8FZg8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11512.eurprd04.prod.outlook.com (2603:10a6:10:5e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:35:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Thu, 10 Jul 2025
 08:35:22 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v2 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Date: Thu, 10 Jul 2025 16:33:25 +0800
Message-Id: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANV6b2gC/3WMwQ7CIBBEf6XZs2sApaU9+R+mh4rU7qFAwJCah
 n937d1k5vAmmbdDdolchqHZIblCmYJnUKcG7DL5l0N6MoMSSotWdZhXXClbnCJhkWi0FRdh244
 LfIrJzbQdwvvIvFB+h/Q5/EX+1r8qjkD16PurkbMzSt/8Fs82rDDWWr9Q/R/+qgAAAA==
X-Change-ID: 20250627-sm-misc-api-v1-85c030c670c6
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752136418; l=2119;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=8webyB4E6TCv2JNw9JWwUrInVpNtjFgLVpgJz+X/kh4=;
 b=UCq0aRKh5agVyaDdJ0iNZrDEmio2jcqK5cYF7B1QVfyzk0pcGoAybsQlouNFm/D4+gYEzBD2S
 LpEuYaI5De9CgYSWzhqbL7S/z5eFoDOMdUdY5WbDOntUGC1VWn63YQK
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
X-MS-Office365-Filtering-Correlation-Id: 00fcf71a-485f-4aa1-b004-08ddbf8cb5ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|366016|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEwrY21GdEhrYXF4N1VrOTVONllLWnk2bmpsSWRYM3k3TkdKeTNTd0xXWm5W?=
 =?utf-8?B?V0wrRFI2MlpCVnUyeUp4Mnlma0JUQmVrZmp4Rkp4NE9oT3BsNXA5Wng0LzR5?=
 =?utf-8?B?dnI0QTVZd0Q5ZW9sSWNDMEUrM1Q3WmR4ZllQajhnVXVxbENVQlBwVzlSRjlT?=
 =?utf-8?B?cUY0d1p3dm9wcm03Z2tndXpIVUpGL1ZqNjJpQUpJL2VsSG5wKzRTNnNjYXdh?=
 =?utf-8?B?U0h5V1FwQWl2K3JYVTJkTXZmamhQUUU1WnhlRjQ1Y3ZpRnh0OFlQUS9XWDU3?=
 =?utf-8?B?WndKS3crYUZCMUpqQ3YreWhHVVpSL1AyMXA4Nk5TTjNJZE1vL3pZdmlvZ1Nz?=
 =?utf-8?B?a2lMbDhZUXdubVFtMlFzblJieU1FVWk3MUluZzIzT3FwM1ZURHRWcElTK3dr?=
 =?utf-8?B?MGc0YjU4UlhSWU9WNyt1a1FRdStQcHRIbjNOdVZVZnVoVFJuTytPWlFHb3Br?=
 =?utf-8?B?MEh6VE1Rbmprbndad29iNGJVanl5N3R1a25vWEl5Y0x2aTdRUzFTYzFQRnpF?=
 =?utf-8?B?dzJEZW5XZnRMcTF6ZEdUL01oenFQUzVtTnRYZHErT0t4dmtqNHRsd1dvbjhE?=
 =?utf-8?B?Q3pkZkxwRGkrczlNZFVNUFN1VlhZZmxoSzdkR2N4SXR0OW1NNDl2TXp5MExJ?=
 =?utf-8?B?elR2RHp4dng1VVdXc0hQcFZCdW9ubkRjbHhIWTh3WGpGbmdyWmh0Z1ZsL0ND?=
 =?utf-8?B?eWxFL2FYTzB5K0VKMnltd3cyOU1PN2d5M0JYbTl3Y3hrekFMTW5nTTVSam1l?=
 =?utf-8?B?Mk5BTTVrVG1nK0QvWXNlVWV6OWZBWFBiRU9oYVJ3Rm9Za3haeVhlY28zUW9r?=
 =?utf-8?B?Qk9SOVF4VkUreVJKVUY2Rm1oazRacUF4bGVqWUpiWCtiVDlqY2pOTVloNEZo?=
 =?utf-8?B?UnI1blh4Mm1iVzEwd3BSV2oxQ2dVdXB0ajNMcmVlMVVKU2k3QUZyL2p4ZTB3?=
 =?utf-8?B?YVlKWjJEamd6Y2RvVUtqUERPYkQyZHVQUVBXTDc1MVNkYUxPV2NXVnptNXF2?=
 =?utf-8?B?R0J5TDFrMWMyR1BTMDFkcFNOc1R5WERjeDJrazVKQmcvWTQyMnZrYjlmL0dT?=
 =?utf-8?B?MnFhSE9wVmo0MWNFL3ZLV25WVEUvN0ZuZXFqL3k1dG9WME9Eb21QZXc5cnU1?=
 =?utf-8?B?TEVCaWF6STR4VnBtSkxWQ09GWU13NDYwdTBXQjVNWkxrMWZ1MlNvWllwZVdM?=
 =?utf-8?B?bDBqcHJBYnZxZ01iRkVvVWFnelFyWElUcU4vWmhpOS9nOFdGWjNuNHdxMUlv?=
 =?utf-8?B?ejlGZVcrR245Sk9BMUhLeXFpQmJHWXNUTHBUaCtFaVRsVDd2cXB4WGFTYVht?=
 =?utf-8?B?bEpLQUNtdGVmMjR4V2ZPODgwdmRtNHBzVXlmTTY4Rmg2SGdEQWdkOWRCODVK?=
 =?utf-8?B?MkE1eUFwcFEvcDdYc2dtT0d2aE9GQTBpTDJ5cXA4bWRSSStnRWZVUjJUNiti?=
 =?utf-8?B?eEtXNVJyMEcraUJWL3JhZFEzcDFOMytVNk9HT21OanZDQWk3R0R2LzNoQ0lp?=
 =?utf-8?B?WmVHQjg3bW16ZVFDUVc0aDBzS0JqVGVQd3hMcDFhM1Vua3R1RTduUWlCdUg5?=
 =?utf-8?B?VFYvOXpFcW9KUDZiZWhGZnhKOUhrNHlvTlZibWlmdmd2M3JGb2w1Z2pOdUNR?=
 =?utf-8?B?a2cxaVE5cGttRkt1MjRncEF6QlE3SVZpSzJkSDZmcnJLWTgzODhpNmNsL0Vx?=
 =?utf-8?B?RkRJaSs2cDVxSHUyUVpBY1lNejlrR0pVamtkckZNbnAzVDZOU0dubXBNRGhC?=
 =?utf-8?B?TUFVNkhhYUVQOFdJckJjMHZCaXhzSkhESDREalEyQlRuTGFCMzFDaUpTdWlV?=
 =?utf-8?B?OXk1dUp2RDVLU0d0UzBrUG9BeVdMVjRZUndBUThZakxIZUx0WCtlUUtJZXVW?=
 =?utf-8?B?ZnFaQktOaktKa0NReGpneEMyNUFBTk8xR3o2WHJWckZBbDZIZm5EQkZKdFFm?=
 =?utf-8?B?dEJzczAyeHNnZmJTd0g0L0I1MWtUdWcraWd4eGdPQ082b21UQTNtZ29Vckl6?=
 =?utf-8?Q?p9HK/wY3lSj8uZk+8UDgsRPVmZrRcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QTRva01mVzBPMFQ5K3BLNGM1VitVOXNrZStLd1pFTTVnOTY2b1BVU0ErdE5z?=
 =?utf-8?B?Qk9LNytHRlV2MzZWQU9BenltMmZYdFkrc2RMV3VLelhENVJheUNMRkZNT2Zu?=
 =?utf-8?B?UUsxYXpERVhmNFpvWWxIQVJGQmtrbGZyZFlRc2Q5Z1U1L0dPcHhGeW44VTNt?=
 =?utf-8?B?ZDh3ems3QTBoMWpqRmtLV2NDWi9ncDNCcWc4V3F6ZURxWDF6Wmlvd0ZCT21w?=
 =?utf-8?B?Zkk3VS85T21NL0FZUFQ0N3JVblJRMXd3bWJ0VjJSeU51cGFHV1RheFRCT3Z2?=
 =?utf-8?B?enJ2bW8zYmhmS202dGxCSG1xWlk2YnBNdHkySmt3Qzk0ZmI0NnYwRFAxQ3Av?=
 =?utf-8?B?RWFqa3R1SFNiTkE1OTc0ZFVjV1R0L2pHTFFheGZmV3hoVjE1S014dCs5cmd6?=
 =?utf-8?B?NTUxTkdHcEVQcjVKdDNZUmRERzVDYUpPZi9uakllcU03dWJXUnhJNDQ2RU5O?=
 =?utf-8?B?Y1h4VzdhMDVqcjdyMDFqRU9HUlg0UGJjQzVIbk1MaTQ2ZUNnSDU4MzI1NElm?=
 =?utf-8?B?VzVxekVrNDRXK1FpbVNBMU5kNk16a09MRjczdzNHVVgwQUF2ai9wVWU2eHRz?=
 =?utf-8?B?dlF2TVRCYXJadkhQc0MxUWhCV3RSWHlHMXVKY3FSYUdEekhWWUo3Smg3UkFi?=
 =?utf-8?B?UzVySVJ2VjVTaEN1MjMwcXVHRXU3Q0RZSkpjdzBDcU80dDJpYTNnU09hQ1o3?=
 =?utf-8?B?WGU5VFAwanhxR2hlbjg2SVUvd2s4SzNzMmhmb2FEeGNvMktkdEpJeGRBcTlJ?=
 =?utf-8?B?SVV4QlFscmFDbHhVYm9ENGZZSUxKZkFQbTlMc1J5eTZQZ0RvWmVWTDgrNkRH?=
 =?utf-8?B?a1hTLzdVNEFhTmMvOURnMWJzR29DZjZGbmJyVXBnWXMrRE9RS2JzZDJRMnBk?=
 =?utf-8?B?L09nSXhOeDlRc2dhazZoWW5FS0pZQldYeXUxWU1zLzR6a2Y2RFMveERzR21S?=
 =?utf-8?B?YmpJUzlkWDBTOHR6cnNNY3BQajZ4NVp3Q2FZSWQ3cWVSVzh2NkhOZm1CWm1K?=
 =?utf-8?B?MTRPR2ljT2hOL0E0dWc0Rnovb1lkdERqTVJlMmxWRFhmQXpKVWhCSlQ1dU1C?=
 =?utf-8?B?VVNsMzVmcGVkS3JJM3o0d1ZKWGdpY0VrUWZLYTk3RlRqT2pCTDF0MG1GVExv?=
 =?utf-8?B?K2NScy8rdXd2Mk1RTXl2Tnk1bnltNlRMeHBPMTE0YkkxNFNJNG5xSGJzdTNG?=
 =?utf-8?B?aEpPZExkbmY0NWI4NlNmV2tMWkhCcFQ2bkdLQjhZZjh4OFVIL2FrSWY1MElu?=
 =?utf-8?B?SFJ6cGQvYXlhWGh4TzE3UytzUnpyRVJvSWljeVhmSjdqN1NFSkxSUU9VaXRi?=
 =?utf-8?B?Z0tIejdOM203Mnd1bWFjTHM5cmM1MVpEblZQYjBGM25ETjZiT25zcUdkaGR5?=
 =?utf-8?B?TlV6MkJxSEVPQTZCUWNuRHhWZld6YkJHUmpiVHc2a3hVKzI0L0xoZ0x3TFRm?=
 =?utf-8?B?ZHlodENjZFM5OVFsY2VDS3kzbEpTbllqMGIwdlNZNnI3TGZnZUZYVUMyWG4v?=
 =?utf-8?B?V0gvU0xpNDA3NVZHM2ptR2ZsZDI5U29ENkxmeW0vL2tnd042dkEyTVZlNTBj?=
 =?utf-8?B?eVJIbTlMQzJFRmlwaWJJbmNXK3VqUlBIN3VFNlhLQkJBY3AvekVBVUhQSjRu?=
 =?utf-8?B?TlF1S0owUHEzaEJlWHNYQjhibE1PNXRsUGxDdG5qM0gyL3hXZXZianB2aThV?=
 =?utf-8?B?dEI3RG9McnE1TG9EMk1Oclc4MkVibDhiZWdlVHZLb3Z2K0xUNTV0T2xwSGU0?=
 =?utf-8?B?N3NTM3R6emV4RHNJMjlkcFVRVWtZek5ISWlEa2dXVDNUNzMvNnNWaEw4VFJ6?=
 =?utf-8?B?Q1NUbFpBVlhlajhyYWpFZlJUQVVOaEwzdHc5Q2R0RUJXQTdrZUlKc09KWUxD?=
 =?utf-8?B?OVoxR2lYQjlkczlSRVRHRHVLL1RzUm53bm4xbjkyS0FXajU1WE15cUp0KzhR?=
 =?utf-8?B?TlBXZm43NWVUUGlERmp6RTIxZzczYW9pd3RsUlZ2TndLdDFzS1h3d3NDblZC?=
 =?utf-8?B?T2M3MG5zM3h0OWdXQTg4eEFGcU4wT2VWQ2VVWFdVV2JTaGZkMllwMnNTa3Jo?=
 =?utf-8?B?TmNmZXowckdGK21jQlF1cDlmUERyd2VSazA5TUVhRUE0dU54YWFtZ0tkODB0?=
 =?utf-8?Q?47C2qPF0LY/H1x1r0ZwuYTCS6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fcf71a-485f-4aa1-b004-08ddbf8cb5ec
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 08:35:22.6619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mqogHa80Lbrf8F4kZOP8ELsZomkllzSV8QpPzyxqng0B9xNlm1y5DO3MCHkPVfzHoWY56cyWyMgGX1GoKNV63A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11512

Cristian,
  I only kept your R-b for patch 1, dropped your other R-b tags, because
  there are some changes to address the comments from Sudeep. Most changes
  are only to dump the information in probe phase, update to single sysfs
  single value for syslog.

Sudeep,
  I saw you sent out PR to Arnd for 6.17, so no rush now for this patchset.
  Take your time.

Hope I not miss any comments from V1.

Thanks,
Peng

System Manager firmware provides API to dump board, silicon, firmware
information. It also provides API to dump system sleep, wakeup
information. So add the interface for Linux to retrieve the information:

patch 1 is to add doc for board information which was missed before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v2:
- Add more info in patch 1 for documentation(attribute is reserved for
  future use, boardname may not align with the board name in device tree)
- Drop dump silicon revision API
- Update discover build info, cfg info, board info API to be only used in probe phase
- Update to use single sysfs single value for syslog.
- Link to v1: https://lore.kernel.org/r/20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com

---
Peng Fan (6):
      firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
      firmware: arm_scmi: imx: Support discovering buildinfo of MISC protocol
      firmware: arm_scmi: imx: Support getting cfg info of MISC protocol
      firmware: arm_scmi: imx: Support getting board info of MISC protocol
      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
      firmware: imx: sm-misc: Dump syslog info

 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 190 +++++++++++++++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    |  22 +++
 drivers/firmware/imx/sm-misc.c                     | 178 +++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  19 +++
 4 files changed, 409 insertions(+)
---
base-commit: e88d17c7335a917e98b7c65776cbe3358210e8ab
change-id: 20250627-sm-misc-api-v1-85c030c670c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


