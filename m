Return-Path: <linux-kernel+bounces-885528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B9BC3338F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 23:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E746B4E136E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED07C313544;
	Tue,  4 Nov 2025 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Apn44FK6"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011040.outbound.protection.outlook.com [52.101.70.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508726AA93;
	Tue,  4 Nov 2025 22:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295258; cv=fail; b=U73TRqCvl19iD/eQdbOQ8MjNPBT8GZSI0GY40NrcJFfh9qUmMRciwRobLTPJhuaGtV12ngomhoK8b4uyOys96blSOTqwBsjcQXNXPCl+k3s+2oZjArxQeb0kO7bjrwMQJp/rVFtjqiXX788jkfbztgVhII4GtMmUn82WTwp3IoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295258; c=relaxed/simple;
	bh=a//qHHPXd56BZbIElUNhNnt1FmmuCeOSLW+wsFlJn2k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=GiQ+wn8WByIws5eMK+c/D4UncxtB9X7RcciCI9le/NYCRfUBzKEqW/EFfatsRBHuTvONKCYv9/1zjfH7x4zrGYb5q8NGEC3tkCj3WA0pqVzqwJLeL6hau8bMDbiUsR9i/Yt5WwGp7YzVYFAYTKfv9OTfDc8vwlX0HBz4BwluLc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Apn44FK6; arc=fail smtp.client-ip=52.101.70.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6W4jNxRnirbHL/+bHeUCqhtbikjVLSN/YvIr0jDllbBtqET080zJQKL8oR2gPmQcN+ph06x+kqWNM7PZKsXPYH7mvV882taRja3oUZhokTjxGNH/SwozwLDRjyb2bTpEbCknERcv+Mhdpd8zrgVJKvtzXiMjFvk3uDeQ9agdMIGXtD+IZpnJXqff+wMpRLWxCYW9cOk3FCpkII/ThStjVJnJ9oFTD3hnd/sn6boOS3a6gORW47LwL7LqqsKOcRyDBy99HqxIVjDnHzQToOxi3K+AoO5/IKpMCJ4YGKM+jKrNLKwhXsKUOSQNXovMdUiZLhZkxNmNCqr/2+KFJcw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArPMdS3wQgYKv2bd3E7nNEIpBNZpwRSlN0kOKOnbM8E=;
 b=YnWRrqP8OsgK0oUKnE5B8E80Ij+gCuhcjn2DiJBG2Y7vfqxjaAb8nzoqPZdAS6Cp9GR+jZZNZn4TGK212jq7V7Q0F5uEAS3D3mug72sEwczI2txJOJlcIhfHIHMzjtYlCdYk16KoWllnyFUtzfyztpRBso78aCfoiSjtE9SvGPs7IHFG/XKUOGl8tJRK8a1plqiU62ndTcLw9b6ETup6zJ9cldSxMgbMtWFAV0Sn5yuBoFzREShJRw4ZsmDGqlKATnytBDpLABwL19ii1qmB7LVHUsQDQbk3ZjtuDHsG84/U1i/iMluB3aSFcHKzLUlyB4pDWyhyQ4zvsULyLnHbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArPMdS3wQgYKv2bd3E7nNEIpBNZpwRSlN0kOKOnbM8E=;
 b=Apn44FK6XNuE+5RY6ZjquXMynSF/tVNrkh20HDegO/7qCKlOGj5Cea82zsFcHpdrV4SLqaCGcEqmypUSjtL1A05miZqs44ATWldtqTkoVzz0ScDgIRZXebw3pllAYN4TeZoXYmp90YrlzmG0dXv1aVhHSEH/FongZ1k4k36AllKBPFXDe0s884aBsG5AJQeW6fEe2IAoSuxIsvEo98ypZoNI9gGB4MSJlAz+fKKBSHZewB8Os+BGZGnbNlMrX8u/etPcIRUX16UfLZo5IetHXfpFFqT/tHnNf44mLx1VoTItB71W32fbsAMyJ1E9MvpkrHBz+MKqPY66Cg8H1xKl8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DBAPR04MB7286.eurprd04.prod.outlook.com (2603:10a6:10:1aa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 22:27:33 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 22:27:33 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 04 Nov 2025 17:27:12 -0500
Subject: [PATCH 1/3] ARM: dts: imx6qdl: add '#address-cells' and
 '#size-cells' for gpmi-nand
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-gpmi_dts-v1-1-886865393d0f@nxp.com>
References: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
In-Reply-To: <20251104-gpmi_dts-v1-0-886865393d0f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762295246; l=1083;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=a//qHHPXd56BZbIElUNhNnt1FmmuCeOSLW+wsFlJn2k=;
 b=ODY1r55BYQGPsymCE2qcvqt/DxPYsSVYIycdJBmkaXuvabkZOtPqW2+jJIqJzV+6BRUhIylsU
 Uc3FNWnT9/vCcniBGOgs2VRObPVe+dSciDG2OcOcl9zfwI0eHIZqoD6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0033.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::46) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DBAPR04MB7286:EE_
X-MS-Office365-Filtering-Correlation-Id: bb40f4c4-8a9f-4b81-2600-08de1bf1597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckM1TCtxVnI3TmpnMmVNWWRidThFVmMrdVpyYXI2ZWpLMzVkZFFVazh1NjlE?=
 =?utf-8?B?N1hFb2FSODRQQ1dOcXozVWd4cjdCQ3FMQU9ZV0dqZWpOK0FONno1dUhlRzBr?=
 =?utf-8?B?SjlnRGg5MGZZRUNKaUV6bG1IZllIdDUvOElCRkdySWRvbkN0V1d5UXMyc3B5?=
 =?utf-8?B?Lzh5bWV0N2dqbnVWZ2xjbTZGWVhKbnVwdTZyU2RnRjVCdmtoMmlwWkp2Vzh5?=
 =?utf-8?B?eGJBL2JzVmp6NVVJRnhGdjc0MW1RY2lqVHBtRndtcUVDT3pISWx2Z0hlRWc0?=
 =?utf-8?B?K1o1QXR6THNzRHpPTGRtemJiT3VnaFpCbnp1K1RBQU9mMWVWRTN5VTQ4SFp6?=
 =?utf-8?B?aVIyNmZoQjF2cmRhVnhOaC9MYUJidW5ZWmgzZVFDa2JSdEtWV2pDNGJFVjFI?=
 =?utf-8?B?Tm9SSnRZNjQydjBrU1M2SmJRejFsWlhTc1B0NFY2d0JwQWU4WTZtejBkdnl3?=
 =?utf-8?B?L3lJb0UwSUVxT0VxdTBiY1lWV1o1VjRKS1BaUDZDUjVpT1ZadHRCSFQyeG4w?=
 =?utf-8?B?VHhnaHFJd015bktZM3hQSzZOTGplWXhxLy9md3dzeEtLZXFCWUZoQ2tyVEtF?=
 =?utf-8?B?UkFkdHMxcEU3aUkvQnptbTRDbjZrWHBWdnBwRHErS2JxZWtYVG41MStYV3pE?=
 =?utf-8?B?bUxBK0JVY0JaaTlTZVlzNndqNUVzcXQxT2ozUmlxUjNkYWcvYkhKTDIxN3Ix?=
 =?utf-8?B?bWJ5U28vZXlFOVI1bnlUd0dteE1RMklzbURWYzBoaW1DRit4T204bU13WHRi?=
 =?utf-8?B?YUZWL3M4bUdqQlJVYnAwVjZtZkhGVEdUNVpSOU1kL1d5d2hCdnJYaGFSR05q?=
 =?utf-8?B?MjE3cjhkdE5SUWQvZDhnV1dHQ2Y1ZXBsUTh1NU9sczE4akZUVEl1YTN4b1ZH?=
 =?utf-8?B?MXIrZDVCdTRjZnJMTldUa3NsT2VIWlZqclNTK1NyTjJnYUxlMjU5UWFvZ0dH?=
 =?utf-8?B?N2Z0MlNIUm1xOW51ZnZ4QTBwQlFNa3VOQjh2U0tacmpGVUJhRFlPaTBnMGkz?=
 =?utf-8?B?Ty9OSFdJaUJGd3JOY2t3SXlxdlExSldWUzN3aytIOGVlSkRGVlc3am9qTTFS?=
 =?utf-8?B?ZnhWbW9TRzUrdHp1K3lUa2FsdXNrbHBZb1huOVF5QlJyNjVOVXJ4MjBkZTc5?=
 =?utf-8?B?NlRaNDZJQ1oySXhlZVByQW8wZFM4elFUUnZaL0c2K2JQaXhYK0k0dWJVdGxQ?=
 =?utf-8?B?Qk9QdmRlN0ZueVVDWERFOCsvRFJnV3R3OHN3c1hSU3M4WkRXakpiTVYrMDlk?=
 =?utf-8?B?V3M3YWsvZkt0NzBZUVNDSDNUbVJyeW8rRWhONFhrdXY1NWZ2QUYxVlNqRmg0?=
 =?utf-8?B?N0dhYzJtN0hQaXN6SGE0NHhZVndQbTczd0JTMlErS21ibmkyUFNPdkt6d04x?=
 =?utf-8?B?d3pGOVRIRlluS2lkdzJiR1BJMEtVSHpRMG1CY3F1dHVEVUFRRFh0aFNmUHdw?=
 =?utf-8?B?TnJIaFNwMVdOZFVCbEgybXljRzZ6bGowRFlxcE9QaWVNeTdBTjlQZy9xOXRU?=
 =?utf-8?B?dHgycDQ0UzBCNThULzlUZ0RNaXF6VUNUanN4bzAyb3gyOVhFL0J0eXZWMENF?=
 =?utf-8?B?U1BNNVdienM0TFZnbmd6UUdvTnZpY1gvZXVVZTVET09CRTFmSCtJbEVDOU9M?=
 =?utf-8?B?NTV0b3BkcHdDZmZKdC9ldHZvZ2FxNjMvUHFIUU8vVVp4Y1JwMm9IdjJLL21L?=
 =?utf-8?B?UHEwL1hYWjJRS0E5aEZXYjRydFdEQWpteE5HUXV6YVh1eWR2MktOOHMzaHpv?=
 =?utf-8?B?aXBWQXZZY2dmSU9YVnQvQnd3ZWpkeVQva014Vkh2QjBzT2ZZTkdCYjVrVGd5?=
 =?utf-8?B?VENpa3h1UTNzbC9tbjc1SDB0OVp0N3BqZDY1MSt0TDgvN3AxTU1oT1FjTXM4?=
 =?utf-8?B?RHVtaEFvY1V5Q2xLT2l2U0JxVGxNdjVUQUhFMlh5eVdhbEZEdmVFaWQwY3Ry?=
 =?utf-8?B?QU56MVZtMWJuQ3duTXVtMGFOV0p0ODYyQXNiaTJQbE9DM0pTcWQwamRFdFJ1?=
 =?utf-8?B?ZWFTaFp6YzdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dWVGcUs0WkZVWVVOc3h3dWQ1U2dHU1ZISVIzMUdMSVc2c3EvOVMzOW02Ym9P?=
 =?utf-8?B?cXg3UVdFNEMzcWpvckxCajJCTktVcXYzdnZZSzVlWVBYNTNDWWt3RXJzMllZ?=
 =?utf-8?B?VjMrSGVXOWE1ZWxwQ1RkRWlPYktUb1RqSGd4ZDFpeUVveDIweXhubTRwTGpH?=
 =?utf-8?B?cWVEZThwQzVIZmJFL3Bvb1I4bmp6SmVVL1pjTTNDN0tSM1BiMGhyajFNM0Vu?=
 =?utf-8?B?c2pvS01xeG1MaEZoK3creUZZNnZ3SkdXamRGaFJ4dk9EanpUOHY2MFNhd0RT?=
 =?utf-8?B?ZDJjL2ZHYkRUaml5dlhqU05NOURXYU5nT3VkMkhZRCs1ajZlYk10a0tMb3Jl?=
 =?utf-8?B?MEU5RW43NmZBeDc2YjdaekRTOVJsc1dwS3hIZTRqSlorMCthR1R2YzlyZllF?=
 =?utf-8?B?aU9yT3I5YkF4dW5oOXoremUxdzB0Si9sOG85aHNtMVBwdnFtY2pGZE1VakNH?=
 =?utf-8?B?MCtDVy9DM3hFUEdwVEFpaWdPLytUZHZDeURSRWdrN3hyV2ZzU2ppM3k4QWc2?=
 =?utf-8?B?OGZ3bGJibUtKSzNiRDA5M04zT2kvbG5sWTZGaDhpNXFCV1EyUDZVQktpdlZW?=
 =?utf-8?B?TnlZRGQ4Y2YrVTJKcW00RFEraUR2bHdTRzhzQ0g0aFpOZTgvNzRRNGF1Zmk4?=
 =?utf-8?B?WkJld0lNcUp0R1FFR0t0bGhJQ1paYVYvTXlvRnRxVldSOHVYVUk2Vkx3K1Jt?=
 =?utf-8?B?RUJoWGhCNU8xOERWWFI2OWEzSWI3QkFNTER1cnArOTZOaGJISHVrdFNOaGJ2?=
 =?utf-8?B?RFhKSjlwNzZKMHJ4MzhLRUpscURJSFNOV1pLY1M4ZXVBSG1hMnc2bWIyczZ5?=
 =?utf-8?B?aEFmd1E0ZnBySFlrOGluMzYvY09QRGJwd214dE9iYjBrbU9OcjgrMjdtdDNV?=
 =?utf-8?B?WnFPREJVRkk2amcyWmZJME5qaW1CY0xiMHRWU0x0ZTZiTElZbGEybURGRFVD?=
 =?utf-8?B?QU10Ylc5RTh5WU5LUHJ0M05aT0hIUllhNHdiN29SMXVzWk5uTkxNUTJoS09L?=
 =?utf-8?B?SVpQMEZIMisxeStQWlBKVGtRTllySE8yeCtLTVdhMWJvbnB2UngvUW5ucExn?=
 =?utf-8?B?dDJsSS9JQlpYa3V5ZTlyWWlxdU5QeURoWjBEVUFXa3dpeVBqaGFuZXF0SkE5?=
 =?utf-8?B?RXlacEpNcGZTMEpIWHV4NUc2ZFd6TUwvQmZIaGNsZkx2OVVCbWg0Y0tyY0xP?=
 =?utf-8?B?c0tNdzAxaXMvNnpzVERIZVl2anBHbWZ1ZXU0aXRReFBCQUk1VEUvdERGNTg3?=
 =?utf-8?B?dkNaZ2c4a2dteXZFV1FPQW1yM0hscmM2M3ZsSU9qSDZqakRmT3JxYUEwbTk0?=
 =?utf-8?B?cE43TURPbXVZNDNXeUlGQjZ2dTl3L0h3L0lRQzd6NVVjTm5YMzNBak43OEJL?=
 =?utf-8?B?ZXRGRXlNWmxuWGx3eFV6N0VkZm1HenlNNEJ2NVM4Rzh0YjZGbmdDK1hGK0Rh?=
 =?utf-8?B?NGF6WVlrZmh5SHFxeDhTVS9qd20wbnZMU1U5Q1A5cVVuOGdIdGdFTVQ2V3Z1?=
 =?utf-8?B?SmhoN1dTRlVDY2dMeHVncUE4ckRIajlhWENhNm1PRkt6ZktJbTRMeUpLNEtZ?=
 =?utf-8?B?MzdXWjd5MWpUTi9Ca0U5ZXpoNHRycmNsS1o0OXpyWkRWYXpFY0poUUh3ZFJY?=
 =?utf-8?B?ZStjdXVIUjdiUEw4MFlUN1paKzJ5MVJQTmV5LzhxcTlaWFZUVW1MTEc4OTdW?=
 =?utf-8?B?Q0cyVVZ5TUVJcFFmdkpycDNPL2NObGRUN0U2RUhEVHpKTGlwN0tBNjNVNVhx?=
 =?utf-8?B?YnZtUmFtQVlZaEd6UGV2bWZZQlFSMGlnRzcrWnJ0MnF0b0dKMjR0blgyUXJq?=
 =?utf-8?B?cWllSTdSVjlsNE9xRkdsaHhneEZCdWlhb3Fia1FqMFZWZktMa3J5WFBPTm5B?=
 =?utf-8?B?QXdURlBraUhPcHEyRjVubWg3T1diN2hsVk1PbHR1eXNIM0VjUE1FcTF1WTlS?=
 =?utf-8?B?eU91TjQ1bmVjbk02T3VhQU0zR3Nma21MYUdZVHZ6VEZhTDMwcjZkQkhVRDdx?=
 =?utf-8?B?YjdTOVUzd1BqT1ZxZlhxa0lTNE9RbW5xVTIvb2QzYWQ5YkpPVWk4K3hyYUgz?=
 =?utf-8?B?cHpSTEZqUkI1L2p6cEhydkdIbmp1WVFvVUxXdVJETlI5ZUJEWDkxbDRNNmxi?=
 =?utf-8?Q?WfB0cPmg4IGtuG5nU3kOoVDlC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb40f4c4-8a9f-4b81-2600-08de1bf1597a
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 22:27:33.7007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1t4lMb0rqjI2eOx2ZZoEeXw/J+QcPmxs0W1KufyCmblnQzDK7k+/ajKP+AAlp+anSrF3DTXGORu9v+Ak71O8FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7286

Add '#address-cells' and '#size-cells' for gpmi-nand to below CHECK_DTBS
warings:
  arm/boot/dts/nxp/imx/imx6dl-aristainetos_4.dtb: nand-controller@112000 (fsl,imx6q-gpmi-nand): '#address-cells' is a required property
        from schema $id: http://devicetree.org/schemas/mtd/gpmi-nand.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 45bcfd7faf9db628479359b5c0a26e1011a7c2d3..a361886144ee1de5a183f405a58d7020d75cba9b 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -166,6 +166,8 @@ gpmi: nand-controller@112000 {
 			compatible = "fsl,imx6q-gpmi-nand";
 			reg = <0x00112000 0x2000>, <0x00114000 0x2000>;
 			reg-names = "gpmi-nand", "bch";
+			#address-cells = <1>;
+			#size-cells = <0>;
 			interrupts = <0 15 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "bch";
 			clocks = <&clks IMX6QDL_CLK_GPMI_IO>,

-- 
2.34.1


