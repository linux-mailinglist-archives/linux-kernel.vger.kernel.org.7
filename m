Return-Path: <linux-kernel+bounces-774486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164CFB2B2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 527E462868A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF327C162;
	Mon, 18 Aug 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A8zy853r"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013064.outbound.protection.outlook.com [52.101.72.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230A127A92B;
	Mon, 18 Aug 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755550140; cv=fail; b=lyC+i/LiHlUUpaPaaQnlBpUehygkzZ370PFwXq2zDptPS+fFcMc0T8Z+4asYA2ZseZb//i7DGmglG7eIcZaedScbw06U7GDln5FIS+drTWy3P6snMo/rViRwCxr2HyN4YAtfckc9BYakzoS3DVFPyshAvLb1Zo7xRxuGTHp1T1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755550140; c=relaxed/simple;
	bh=BQOMOOEddNiLEDO/Ox6h2RoNP7icyHU1aUqf6u4VGdU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sgrYQfeJ1onbyEpwXPxMGtTz42m3txrjbcY5X4lFR9OVo8nGtdsKsKrlnKdt42BkJwHw8Hu1OXwjsmXiwS7Hvgdvu9nPgOl/zl3M0wvn2Kt+mLItT248wQVO8DJfPsefhqBp6Mq9O7WdalNPBW3903I87XfMiSDP8oxVGdN8P0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A8zy853r; arc=fail smtp.client-ip=52.101.72.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXMuG6+JNCwm7CuzbU611NdUudIPlyQtCeGKwXl1dc0Q3S7kdQUiQMdevboS4iXVVV3X62wnwFPLQP+R83elX4LiyJbhr7jlZR79uylK9H7efO2t8tGPdYzQNQax5Gxq0/dYXyMrgGn4HTuwCE1SCF2FRWSKr5ra6rPfkFax4i7/8AkdML4j8cejCdmG4gEFJy0/hZPxs28aWDyqrqD2lXg+H4/1yotvwQiIzZr8hCncPDBfilTP/rnj0KjoO0j3l3QAcF09wyUjIcrfkvMKhTAzHaDW2p7LexGQY+5+/lEEIkZhxFMrwdciA+vLBb3hx4Ky7MlepfD8Wk2/A/hvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yO1EgbMgoAlmS6/dHVPeu8fxkXfPVwZ5vR96S1Ov/80=;
 b=tFG6UEvj/UY4/TKWzftJ+2/R5+6AHi9H6vDXlQ8lQbCxCRHdV7rhBkdqHtZXuITS+brUIkdY0diFp+DvCTFObLA7lWgN4L4j1XnI+q18ugicc9wUiKFOZgouP+Xy0opwXEwoMgIozD55FSE27m+XfZ4z/cjCkB4sIesOpUdpZUaC6KYwTEujP+SI/2A714fIn5meRtRKZLzDMfLY1q4YACXcs7SpIEpZ0GKUf1fdx0cNz2V3hrMGpa/6ivXlU8vI4ZJeQXMV8xxksoCm3x/o3dy9fgcNYiqq+zy/9GvMWfypJ5U5u2nAwA01VdXPmGppnvQZr9Nnq5tGiBA9VEP52A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yO1EgbMgoAlmS6/dHVPeu8fxkXfPVwZ5vR96S1Ov/80=;
 b=A8zy853r2spuq14xGWyR2fLFLwAsSH4tZZZ2rVNpqRxk1IwA0b4xNUmakVJ5RG9rdD8kLnCW7DW9A9D5e8BWfjhQry/3pc+5GYOVDOjnoPvYujZLGWYhBplkkBK6u/JtV6VM9nlARApUtn3SEBduXzJtnOLQAzMQdFmKjyx2Sm0PY4V0JhLmtVjQqWw9/eFCa3FDCTA+Nfh+CF4PDH3Q9aqpEytGyxa0MEdSTACtN00tY8RKGLMqp/SNK64xTXBTRBjCf96eKwu5qxAqeRqe7hHnpTalOmHbzKX6nz62Yj11Czzp3uBZU/rGyMiHvwmplC92SpmEb9QUn2fDq4fS4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB9009.eurprd04.prod.outlook.com (2603:10a6:20b:42d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 20:48:52 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 20:48:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 18 Aug 2025 16:48:24 -0400
Subject: [PATCH 13/15] ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech:
 Remove fallback compatible string edt,edt-ft5x06
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-ls1021a_dts_warning-v1-13-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755550106; l=2016;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BQOMOOEddNiLEDO/Ox6h2RoNP7icyHU1aUqf6u4VGdU=;
 b=kiAta5CH8lZKYdRfX1x+fTSYTuB8W2T4xfmlJUVoYF2BebDPLG4DR/iwrkTGC9R9P8ngniroe
 /sBXenU2FIjA9k+JJbC0Tvsm8YQDBLM4A53NHxS5b5DUQESejWF4tcN
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM9P192CA0022.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB9009:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dc32ea-d22f-4973-2bda-08ddde98a40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cDFTTGlWM2ZTQm9DTTJaclM2czEwUmhNVUJkK09PZXJOcE1VVmZhVUFCb0NH?=
 =?utf-8?B?anpwekJ5dzc5bk5LbWtwNmlTWWZGUlI5elBiRnRwdzVDYjN0VjNYelY3UTg4?=
 =?utf-8?B?NE1ycGRNS3UvK1hMZzMwSU9aNVJ2bDEyRUxEcXBLUjJiRkExSzJ5b0toQWpW?=
 =?utf-8?B?TGdSaEIxZTlvY05sbjQyZzM0SHdlcCtTLzN1NUdKeEo5TmhjZjg0RmhuNEJX?=
 =?utf-8?B?dXNZSFdHNUhERE9Cc1hRWklibk5jbzJZYytTQ1E2ZmFYdWdSODdrRnpuZmpG?=
 =?utf-8?B?ZlVBRkhaMG4zdWxZR1ZOV2JieE5BODVlWGxTdk0vRERJamNlQjJuRXpLZlJ2?=
 =?utf-8?B?SFk0SnZDc0RxejY3UDlnUkFrZW5yMm5wbDVHVFRzdEc5a2l0aTNuOURlYkdt?=
 =?utf-8?B?SzVxZ3hGMVFINi9VbUZHZGs5VmlDcTIrbElVUmxiYzd4QkU3TUYva0FKOTdp?=
 =?utf-8?B?ZUU4OWlHQ0g2cnFyVEs0dEdkcWkzR0tCYkJaS25aTGZQNzVLZVB1NEVZR2NU?=
 =?utf-8?B?SEtLUDNRSEpkZy9KaGhudFlPK2hGMW1HOWFlWDNGQVJlRy9DYTB1d2xrUk1Q?=
 =?utf-8?B?VnJ0VXAzVkRVZUNrRWZ2WGMzS2pQbG0wTlBnTEJ1YlpWUW0wZFhRNU1zWHBs?=
 =?utf-8?B?TEIxdFovL3I4NDJzbFFDVU1RZXluSlFtTFVxZ3VtRHNsS3lzU25IV05NT0pr?=
 =?utf-8?B?blJnbFJ2d1RyMXRraVVEVmIzaU5tSkIzeUYwSFcvQUtRK2Fubm5hL2k3RlRi?=
 =?utf-8?B?ZklsaEI0WVVlMHhPZVlOL3VtR2krdVBnc3h3b00xN09HaDNnR3R3b1dPRU9B?=
 =?utf-8?B?RndMWHU3RWtXZnMvb3c0QkcvNkdITEZ0dkhOenZjTngwWDVNL0syQWxzVFlG?=
 =?utf-8?B?K1RXNlNjaWFUSkJqTktOb0tvNDBUb1A0S0VxT25idjdxc0RoeFAwMGRtQ3dR?=
 =?utf-8?B?OWZyOHExN3ZnbEUyYlVUMnNadCtmdVJwTHZNL2pYd2ErQnpCbFlkV1VWd1VJ?=
 =?utf-8?B?UGwzUzB4R3NLTDh1VVgxdzhxL1YxNTJ3WW9rK21PMll3MlpUbU5DM0pJQjM0?=
 =?utf-8?B?N0VDU1VqSzFFVTMxcVpJQVEyemtYb1QzcHh4T29JNFFuZHNkSUd1VUN0empa?=
 =?utf-8?B?UEdaQy9FYkFIYmlPM1UzcEIwQkZ5WmFobEUxM0dXdy9hUWJvWG9TL2dOODlK?=
 =?utf-8?B?VFVBcjh0YkhWbmoyM2tvMWcyS1M5VjdsYXgrYm1XeUlZNG05ZFM5NzdSY003?=
 =?utf-8?B?aGZnY3RpV2gyU1Nzdm9oQzNXWENXVGIxRVk2d2g0eDNQcXJ0ZnV2eFFFSVUv?=
 =?utf-8?B?V1N4SWxncXVFditORW1RVlA5UElpandMOVVJZ2RvR2lsRVNiRzZUQWZ4bUlG?=
 =?utf-8?B?NUxiTmR4cTFZWTlIWDdySlJOdWZqRDdzVlV5MTcvalhpQkJPQnNQOXdQWnJJ?=
 =?utf-8?B?TG1ScG1HSi9TVFdUbHF4RjlJNTl0WmROdEh4VlJaQzE0S2ZrRjJmd0Z6VWtm?=
 =?utf-8?B?dnFyWDQvQmZpZTdnK2lxNWxCSmZNRllpWmN0MWRFd01jUWExYnBCUVkvdm1i?=
 =?utf-8?B?VW9nYWZ2QUMzdTgwaVB5THJWN3ZxeGt1YVpxTWY1VjJBNXA3eDlzN29Caysw?=
 =?utf-8?B?TWxLeVVhVHk1VTl1ekRHdmxWbWJDTDR4bFppU0MzcC9uQ1lrenZ0NEw2Q2ZP?=
 =?utf-8?B?TnJlWmxKbHE4TG9qaStuWG5EZTBDWnI2c2Z3cDkyVmlmckFqdkFDK0dMSUNP?=
 =?utf-8?B?bklUeHRJdnNYL3MrUG5PVVQ4WjR1TFRjY2tPUURNdzZNcXJyNC94bFpvM05n?=
 =?utf-8?B?QWxFb0E5Z1NLNHR3Yml1c1VNQ3NjVWVWM1daelRoVlEzS3JDYmFzMk9Ea0V0?=
 =?utf-8?B?Z1lWb2lnRWtVR1c3S3ZaNHlVNlVnVFIvVVZZYm02K2ZOS3h2OE8xbGh6K1dr?=
 =?utf-8?Q?lHtGbCrzqXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3dRNkdCM1NuRDZpU01vZ2J6MHNZc1pWNkJLV1p1L3llcTU2OThyK1JjenFs?=
 =?utf-8?B?ZXNwSjFzTFZNUFJTTVJQYk1SQXNtMVBBcDZxa091UHhmTXdIZUFQVWh5SlUw?=
 =?utf-8?B?VHdhQ21tNVRZd0NMZDU0UTdvM25qWkIxZlRNOG5uWkpqa0dRK2Jxa1NiN2hv?=
 =?utf-8?B?YXFjR2JRS0QwV2FkdTZYVWQ1b3JwUkJXaFdwYVFsRngvRFZhVE9uczA3L1JX?=
 =?utf-8?B?bGw0ajAzOEZkbFJqKzUvbmRUYkx6SUk1TGllNWs2N3NlYUcxR3NrSUF0eHF2?=
 =?utf-8?B?dUR0YzBvWGpoRHRwdDlhVVJ6TFZtcFEzWkhDdlBuUjlKekRBbFJ5alZlZFoz?=
 =?utf-8?B?OWdhUlJYYVhsb2hYTXJEU2YxTHNDVVRFa2w2a0d2bUxaUEFzcWJKMHAxd01C?=
 =?utf-8?B?LzBsbGVzaitpdlRLUldLWlNMZHZEaEpFQSszTFgwZzg5bEFWN21jN3A3Z0Zw?=
 =?utf-8?B?Szhidk1zNUZXcU9GNU9zSjl1eUhtMHRpV3N5c3J1OUcraFBra01CMHp5aStR?=
 =?utf-8?B?Y29JOGlUQkxnZFRKMDhMVEZ4Q0lDMTBwR09kU1p3eGtWK2hiclphczViK3BU?=
 =?utf-8?B?a2ZjN1VhT1ZIaUY1YW5uMFNqdzVSWDFuWVhJTzZGdEw5WHJvcHRlSTk4M0hr?=
 =?utf-8?B?TUJxK000dm5SckpSQVR5aDl0WlRPNXVEbVNXZ3dMNEJocGlwVCt5TWFXZWgr?=
 =?utf-8?B?dE00bG1vWk1ocEhpWkYrTWNUbjd0UFdyblVpRkJ3dDRWNm85TjVZUXZ0MVlT?=
 =?utf-8?B?SU42TmI1c3FuVTYva3d5M3FsZXNNOHVWL05tM3VvUjU3V0ZuS0tLQldzdlQ5?=
 =?utf-8?B?YWl4RnhPc09uSFkzaUYxWGZ3WlZNMTNpaVpLbCs3RzcvUUMydktOTU9ESFBi?=
 =?utf-8?B?SUc0Rlo2bkZxRDc0c2N1MWJOMVFHR1lCS25JNm9kSG9obFJMSW5iMG10S3No?=
 =?utf-8?B?SlJ0UGFFWTN0NGdsTExZemVjTGpDTlpzMFBjUGtwOGNCYmgxeEdrUnhieDNo?=
 =?utf-8?B?Vll0V0g4YVFrOVF2Z3EwUWhuYThNRjc5RGswOWc5OUJOUFQ2azV2ZXd1d2p6?=
 =?utf-8?B?ZzNtMnEzUWMvd3JWSXdGYS90YWhvQUlDMHNBaldxNTEzWndJUmorZlZpbkJW?=
 =?utf-8?B?V1NzbUZvS01SWDdydU52OTVmNWNrQmIwMVRkck1OT1BOSDZlVzFTSUVCQ3VB?=
 =?utf-8?B?ZXR3UHJCdEJBSUtjRkNOeDRIVzZNeU5VUFBxS3pTdjcrWHlYM1YwUkh4SVJi?=
 =?utf-8?B?aFNTampJZDNBQVY2dkZBcGRWNGFaeTZsQWYwQnAyajZBVHd2Yk8zbnRKckcy?=
 =?utf-8?B?cWhMUUVzd0tDTmVzZ0QxbE9LMnVWVDlsdnVKcEF0UjRFRlA2Tzd3WDFiL3FV?=
 =?utf-8?B?c2RmQUMrQWdUcGIrOFI0Q2UvK25zeGVpNUtoZW1pM01NcE90bGlvenRIbGxy?=
 =?utf-8?B?Tm4rQXllSWRGanpVeE0veDhKdDNWaXVHTVZIejZvTFpmWWtqaVhXR2x6NVdl?=
 =?utf-8?B?V0pEQ0w1bjlNdlZuTHFuaE5aUUV2YTVBcmdoRlB5ajE1U25IREw3QkFlL2VY?=
 =?utf-8?B?SDFJejZFRWFZays5MnR6RjluNmV2YVZ1YXNhTzBCWnBaWkVOTTZNMnNUYVBp?=
 =?utf-8?B?N2V2bGthSjhGQXVjdzJuY1diRmN3ZTlkZE82SE50TnpCSjY0UWtOZXpyeXo0?=
 =?utf-8?B?dkhMUGc5dzk1akF5cUdyYVNxQTJlUk1YdFdOSVVlOGJnb2FyQWgrUUl5c2tV?=
 =?utf-8?B?SjJJY3NwOWlTR2lUcERtbUdVQnBsYTdVQkZVbkI0ek9za0NZZGhReHdrcnln?=
 =?utf-8?B?STZVQXlvbHN6Q1R2WWZOYmx3U0JHcWJaZkhSdWMxS1ZOcG1VbmtJNENqV2RG?=
 =?utf-8?B?dUNsZ1ZubHZVbXUyZUZ2czJnS242NnpaUVE0b3NIc0FFVTRvTGtyalpUVjVl?=
 =?utf-8?B?OVFaQkE0VWJ5emo0VFRLdDNNZGNTSDFHcUFmMUpMTUdoZHZoV1NHR3RxUm9G?=
 =?utf-8?B?d3FJTEtSVTA1ME5vRHgvdFh0UGlPUWUrRkZoSVMyTkVkMTZ4V2NCeUxqNlhz?=
 =?utf-8?B?YlVFRUtCVldwSk0rdWhVQk93OVdKbHliNDVqcXk4ejRId00yQ1JSN2oxMURu?=
 =?utf-8?Q?tY+o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dc32ea-d22f-4973-2bda-08ddde98a40c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:48:52.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNxTYrPIjMS8P9udq1iFqx7N3WmLP88uJZfExa7HWyRHZ+DvcNc09XpihCIVKTmL/HEW+v96O+1N2WJwZ1WNeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9009

Remove fallback compatible string edt,edt-ft5x06 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: touchscreen@38 (edt,edt-ft5406): compatible: ['edt,edt-ft5406', 'edt,edt-ft5x06'] is too long
	from schema $id: http://devicetree.org/schemas/input/touchscreen/edt-ft5x06.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso   | 2 +-
 .../boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
index 146d45601f693e92e4c2613c0e56ef5ad63715cf..66cedc2dcd965d0cb3f858421009a0985e345ebf 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
index db66831f31af93bd60c1425b6e5c5c10fa77e845..8b9455bffbd2687bee8664083a97a982318ea6a9 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso
@@ -36,7 +36,7 @@ &i2c0 {
 	#size-cells = <0>;
 
 	polytouch: touchscreen@38 {
-		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
+		compatible = "edt,edt-ft5406";
 		reg = <0x38>;
 		interrupt-parent = <&pca9554_0>;
 		interrupts = <6 IRQ_TYPE_EDGE_FALLING>;

-- 
2.34.1


