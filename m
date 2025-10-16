Return-Path: <linux-kernel+bounces-856540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5DBE46FA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA89B5E322F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3497A3570CD;
	Thu, 16 Oct 2025 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m4udmJPm"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5966D3570AF;
	Thu, 16 Oct 2025 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630436; cv=fail; b=GhR/lfo2n5jDZEr/NJZqPGNJtIsKeeXWtyMeDoZy1nNwJ2bUG3jhuQbRhYjc7m6OFt2hgVbaGH8XFHA6ovTPwxY6PL5UvmL4J6BA5zo4CIY78YDGT2u1NbswL65DBTdp9WUwMRqmvJWNLoTULvmgCZazoEyPX4y0CQUM0Xj1bNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630436; c=relaxed/simple;
	bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=cS2dmvC+lsTB2ARMVfh6OsU/O+laWgSiq3DjNY+2LQIklHaREaCUkRnmhnEC8CMnj/z9BmJSWHoZ/tylm3A/xI+rVaDATizGDfETrGxTB0cAUV/D9RlcK7WWSF5JoCU9zHq7ymrLJ991a/oaShLUKH3czaQBFJooeuwBLK1IKuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m4udmJPm; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yU9Tmo/0iEkpoOJEJxeT+V5BQjq+HL3+CTLiQKJnS/Rz4t46Il825XmDIgck07yI3GeQPOU3xRz05ORw7dm0R9o7PnIKlnf1TSo1VTrx6dAIRx+l4sdyJFD7HPeOoXiHQVzEIzAcw1DvN1KwDzjAgIW0QnDd9DnddcI4RpLwlSnRcr3+LuAMobIX3dffshnpYj0USRK0FLOAYnacO9SboElz0+XQCjFjVPORpxLPEBHSt86WskdPA9zi0RWCqMeuEmjfRh2sIB4cigGsgUrHBD9Ve1TMRXbToVqn6RWuoiQ7yFdGw/FqauRhmouiZXPfEv/j3ZXGbfjFSHtUi6sqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=mejN9r7hasdXelygkifLTTv0V23P0u/5xo/Nk7r0OMKjZEGNAIs4b9yzwhJ30lZ5BnISI3sw1XL00kAaZ5aHlObUX35FzmAezil16GerNzLA4Qr5IqU0xb0fUZIKKjyKkSU79OU4H5gY771PPXawxtNTmGwHxjgSPFrPgqReUzRbo70ul1rSIY0DIhX8Q0xojrrVpBj4gQ3fNg3W+yWM0u4UsAkeFg/AuWb9oU1B8z7wnTILE9mRtYcSOGK98107Ii1ZyFrz7FbwFT4FRMtTKOvZqFGVbNYcI5w65R9l8BAbMzOotRQC/kkiSJedAQpvqhDFq21/ffgfzjEpBX/bXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pchcZFUY3FQC/EwRgEjc7dtwsg1qn4KqKfy0DaKvV08=;
 b=m4udmJPmQ+3qvD9lmVS+bebZ6zIEJYpZNmaa4b0MDVzXC3qSjUVQG/9T3OgwshTaJZn0u3qZtB4FEPz4gb6NXXePGBvbsINV+dtDrw9nQCopkIHJWclv4yLUQODa9zNDKbgFQtlOXwosINQPrTCr7TO8P72PpGt/MVWoHjg29YlY0XC9YB6jZKPqed87zS1iKQBLNlC1V6Pb/UH9JZTI78nmlAKIhMTB9nkaOkMmsfxe2VohoxlAbRBLwH7ENlfseO4S1InDh5e/2DxkIPojgZ9rbSFBg47G4pxQK4ITWkI8AwuCQh41pZnz36HMAVdKmBuK4lZehmmIV2Ps8ibV/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 16:00:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 16:00:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 16 Oct 2025 12:00:07 -0400
Subject: [PATCH v3 03/11] ARM: dts: imx6: rename m95m02 to eeprom
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-imx6_dts_cleanup-v3-3-baf2814f8a15@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760630413; l=990;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G9uDIeY7Ci9zoDJS+JpzB0TMKGogWur9pcJTCsldAT8=;
 b=yq0ENOy9ej9HRLWKm0Lzl0UOrrcH3ra/tGBRMxdTRV/cSz3lwOCOiLvL7OjhY4s4IMAKnmLGH
 xADHKA06SWvCzTbGL3cFajzHDy7dztANTqpl2hnorwYlXz934JWnBJZ
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
X-MS-Office365-Filtering-Correlation-Id: ef7aa925-d0b2-4ae7-aad5-08de0ccd2018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OURZZzFJazRZQkhGTjg5UWtPMXQvVHBTbllQNWxsazltZk9rbm1tRkpiT0tK?=
 =?utf-8?B?bjk4UmF0M3djSndYV015dnZiMU1GYzlpY2Joc00wN3k1cUpZcXFRcUREOUlJ?=
 =?utf-8?B?ckszemJYbnljSDQ4VnZsRktNUHBacUZSSGszRVRZWHI2WDJBSEZnQmRJdUJV?=
 =?utf-8?B?bmVadm0rOUhQZXZQTURTK1J4V2h2aGIra0xPZWlsMlNIWVF1dFNlVXdsOHhu?=
 =?utf-8?B?cWd4T1BhMnZBWmZLQk81THhIbEwySVlqeWt2U2pZb3VaUDJnYWp4QWU0eHZR?=
 =?utf-8?B?Y3lJNG9mcFR1SDBzb0tXNXlwS3Q0ZWdzRmtSZFpUYzRSS3BmbG9VT2lacnNy?=
 =?utf-8?B?cVZMRUkvRk1zblFzcXNKL3Z5Y3dhTE9JcUNqM3pjOHduemhWbTAxS3hndUdB?=
 =?utf-8?B?OGhsNVRkNW0rOFhzMm9jWVBGeHgyZEJSR2hJNDUrR2o0NmZtZ09jT0lHUEtl?=
 =?utf-8?B?OUNQY2k2eWdUUkhUdDVPR21XajZKb0FBbTRHd1RoR2RBcGdxUnZ6ZHpPVnlu?=
 =?utf-8?B?aFE1UTFTYUZtbUZpYVhKSjZ1L3JRSG9QMGhnaWkrSU1BamlqOG10QjVOMlg0?=
 =?utf-8?B?NzZQNVdBUlhqaG1nTStqa2EzUSs0eStsaXZpRzZkYUI3QXpBU2RFRDVycW8z?=
 =?utf-8?B?N2RQdmxGVDN5Z0p6dkNUUkxjbUZlTStWbkhyRXg0QXBCalA1U3llNDZ4Sms4?=
 =?utf-8?B?alBSSWxDelFqcHhkc3czMmQ4UEg4a2V0ekFsUk9UeEtXbmMvWnRyRUY3UCtY?=
 =?utf-8?B?c0IxbWFFazFsbjZMRFQ1N0lBVUlTd3E5WWd1S0dwVzVaQ2xjcCtFNHRvb3Zx?=
 =?utf-8?B?a21UdVNGQllTc2tqcXBwUUh6QUFxZ1dVU2FzbjJRMFVuVGdrL3EyRy9wWkRD?=
 =?utf-8?B?SzBNc3RNbWZnQ245dlkxdjl6dS91QmZnRUhQMVBSTG81N0F2OUIyUTFaTzdh?=
 =?utf-8?B?SmM1UUMzOXRoL2NQUi82TnBYcjZVZFpHV3EzVDNJSVhPRXl3bXB3RU5tVjl0?=
 =?utf-8?B?bTFCODdIOEhEdjAyY295dEEzZkxwRHBJd255cEhMelVZc0crVkJyZEZJSkVi?=
 =?utf-8?B?K04zTnBOZHp5RTFlZTA2TWQvN0FwOVFsR0ZHZy9qUjF1WW1uZkVYb3lJeU1K?=
 =?utf-8?B?M2k1M2M1MUUyd1RZL2tXVUt5cjAyRmFuTUVXTkNBa0hoRndQcEpxTU9FUmJm?=
 =?utf-8?B?TmpOWjhvand4cnUxeUhONUxpVEI3cUtFOS9Ic1g1Z3lScUtMNEhubWtNakdo?=
 =?utf-8?B?b1Jydno4aitic3ltZldWSU9OM3JZVllDTDlKMWVjZG1NdmZGRWcyZHRSRTZw?=
 =?utf-8?B?NVpQT0N1S0I3Y3ZIdUJvallxZUFTd1g2eEFJd0o1alNhbTc5ZmFCNmRUeEYz?=
 =?utf-8?B?Q2E5b0k0Rks0c25QUDJPc0pRdHgxRmlJbEp4bTRRTzRzQkE1VURjV3lCZnAy?=
 =?utf-8?B?c3dTMEh6M2dZSWV2Z1J3SUlIbHQ1eVAvMUlnWGZMOXpyS3ZuVHROdWxPOHJp?=
 =?utf-8?B?YksyLzAyeG13RnpRVEltMWpGY2RJUVkzY1Rvc3IrZEpXSWIyRFl6M3FLYzVQ?=
 =?utf-8?B?aGZOdCsrVUtiUVVYR0RMWlVwRlhVNjZuVllGMjBOT1pwSFAyRkM5K2dINWxH?=
 =?utf-8?B?ckFWdUNjeDBVL0VNLzlKRGdNQVd5VHVTQWN5U2VEdGc3cXFPME1iSHR3dUpP?=
 =?utf-8?B?QlE3NTRIWXkyTGJpWnBsWHlPWlF2S0xDc0lERy9lR2VpTGNUcXRBZ09PZ09i?=
 =?utf-8?B?SURsb3g0ZjJxbjlDR2ZOaW03Z1JUeFcwSWxsZUN0WUp0VmNud1ZwazhIaWZ1?=
 =?utf-8?B?UE1Bc0UyRWJNSlVBVFdDNUZGTzBTZlFLbUl3Y1d0NlZtZlR6cldDdnVkRzNk?=
 =?utf-8?B?WjRsOVJrdlFBNUhGNVNNS1ZzdFRpbGdoVGFvQ1pob010QVR2cEZra2FlZXF4?=
 =?utf-8?B?NStPVkdvaUc2QVhhU2hCa1ZkSXlMZTBMMkhmZGpKOEtwK0dMK1lna0Q4cEY5?=
 =?utf-8?B?ckZGZU9hbDc5ZERtMnQ0aFRlb1Bkc3ZRVnRkRWM0LzEyK0pQODNUeVFySVV0?=
 =?utf-8?Q?lRvU/y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlRaRzA4b0xXTVFXdlpNZStxeThqR01ZNTBKNTVENm1FQTE1Tld5cXpWY01R?=
 =?utf-8?B?T09DTE5BdmQ5UWJIcUtNQnN0ZGQ2eXc0TFdPV25pbkoxZzRzUjF5cTd0YVN1?=
 =?utf-8?B?ZkhRTHI4eFREQ21FQ0lWb3Jla1dORThDQklHbGNZb04rRm1kUDdIY0RSZlpX?=
 =?utf-8?B?RXFoSTdnaUJVSWd4eVhOTjdWWTYwZGxJeXBQcVdoVWMyMWxaQWFiT3VrWXJa?=
 =?utf-8?B?WWZSdG5NZzVHYTR3Qys2RDFMU3dXNjEzaUNXdkVMQzR0YkJZQVRJbGUzRGty?=
 =?utf-8?B?NXVDclo4MUsxZjUwSTcrVDVCc1pZVzVLbW5aeW9jNmRtOUFiSXZZR29ndk4z?=
 =?utf-8?B?blA2OEpLMEpSYUk5NlVSRm5sSDhGVFVLSitPVjB0WHYzcUxwekVBRW1HbjU0?=
 =?utf-8?B?cS9CTkJRY0dyeW9WWVFaK3dGQmk4WDNIbGFnUXNKaEk1TG5uRzkyeTB3Z3pC?=
 =?utf-8?B?cEVBZjh4M29RcEswWTA0OXhxNmh3WnlWakZTS1VqY2JNZ1FCZlEwNjJrYUsz?=
 =?utf-8?B?cXlMbE8rMnhuYjZ4aEFhZjhsWWxsZlltS25QeEJXMGs3QUszYXArZDByR1BT?=
 =?utf-8?B?Y0FsY0dUc0gxdkladGUvM0c3Zkw4RWZhcHo0VWNRZVdUVGxyeFo3WlB0Wlpl?=
 =?utf-8?B?dStqU3lzUWJURnVlNFpoZ2MwODZ1RDZBa0QvRjZRSmd3RG4rSVFtM04wK0Zv?=
 =?utf-8?B?cko3VklyVVRyRWxsbHB0QXJNK09zMFNPRDZyRFd5RndhWVRmeEprRTZrc28z?=
 =?utf-8?B?UEJtNTA2cWNoTHAxOTJ3U2dabHkyajl3M3JqaCs0WWJSOVlsYnk5NDFFc1Vx?=
 =?utf-8?B?aEx6VlFsUTk2UndXenkzZ08vSjVTL3M5TTZvRUx2TGF4YmtVd3JxV0xuMEND?=
 =?utf-8?B?SUNGdkNiOTNrSW9wZmc5YlRVOSsxK0FJRUlBYW5PcDhKSXFWeGZiNXlkVG9G?=
 =?utf-8?B?VkRQRkl1VGtlek1WMmFDN3FxcGZLQlNiNlJadjNRR3MvLzBBVjJLZk4vazdw?=
 =?utf-8?B?RVhSTi8zZjhRdExtL3F3Y1ZKa3Rra3g3a1htK2VId3JSMGVlM3BndzBSUVdr?=
 =?utf-8?B?dWlBZHhKU0huUVY1eHZpK01GZys3TjdHaVhQb0pLa29QREJlSlhGcUpiNlc0?=
 =?utf-8?B?QjJvWFl2QmgydkE3Q1RlT2NFSUtXVkl0WW54eTBlV0IvTUdrVDRlVnhwTnNk?=
 =?utf-8?B?QWNMZnBwR3pFN3dVYm1CWDhKZE8wbmxISno0d25mUVdoVHZWbEZ3MlZSRTdV?=
 =?utf-8?B?SEZpY3pBaS9xc0FyR0JsOTY1VG5sZGc5ZFpSY3BDOUw1NmJIcGJJYUxtZUpY?=
 =?utf-8?B?clg4TkY3eXJLM1pHampFS0hlbFFSWitiQXdrQ3EwY3BNN3c4dTV6TzBhaTNy?=
 =?utf-8?B?ZnkxR1NydXpQaTRHQ0FONmYxU2pyS3JBK2cyQ28vK0RqazY0Uld1QUtoNUFx?=
 =?utf-8?B?aGlZMjBzbVVWZnFaUXNGaUgrOHJYa1ZzUVJjVTZHNFk1Y0NBZG1ZNVBIL3Rz?=
 =?utf-8?B?YzFjb09nNmVDMTJkaDVEZ3lSU0ZFQ1FGRlFIajUzOHhyak1TTTBka3IxM3M5?=
 =?utf-8?B?alFOM1hhQmd0enVtNHZFd2d4eFJFa3VDWDlWbFRvN0t2dW55cUlVTXk1M2lY?=
 =?utf-8?B?K2VZcFhOV25GZTdPTWVodU9LbWNDN1Q4VHVmcEpXNmpkdkRWSHFSbmtJdVFI?=
 =?utf-8?B?ZnlyaVpkMXB0UEo0VWNhakVmNW1VakVOYkpIQnd4bDAvU1VGd3BxQ0NwOXJ1?=
 =?utf-8?B?cC93L2RDSGdMclduSXVmdTNpSHBDdXhENWlES2o3VVQxTHA3YUg2Y2FlNURq?=
 =?utf-8?B?SXdnYUtmMlIrb0hFdGswZnJGVnVmY1o1dWtXeXZGR3hpQStKZGx2R1FqRkQ2?=
 =?utf-8?B?aUlvak1TdEd5MVJ0akF1SkJnY3gxNUNlak4yclg0QnduMUFTV1RxVjNxeFpC?=
 =?utf-8?B?TFZuN2huQ1NYdXQzdDZXKzBPK1BnVVgvTDI2Y3g5VDdJM3l4T0owSDFvQWFD?=
 =?utf-8?B?S1diTEg0TjlheWxJYTRaRnJ4OWNid3RRdjZESVVWRzJnT3RhUjNZV2ZSdjVT?=
 =?utf-8?B?eTl4V0dUZk1sMXlldnZxMS9FZ1Evd0lIN25YdXpieEg5RnJsVWVZVTlzUW04?=
 =?utf-8?Q?Vx/bDE48OvCS6gqahsrOkSXjl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7aa925-d0b2-4ae7-aad5-08de0ccd2018
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:00:28.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDif/gu9wG7kI43RrnlrbddFegfFGWdFGM2w6JjvyPGSQV6YRhihbSZB/fMdsaXiCkKyHnlRtoKzkSx1LMsKPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069

rename m95m02 to eeprom to fix below CHECK_DTBS warnings:

arch/arm/boot/dts/nxp/imx/imx6q-evi.dtb: m95m02@1 (st,m95m02): $nodename: 'anyOf' conditional failed, one must be fixed:
        'm95m02@1' does not match '^eeprom@[0-9a-f]{1,2}$'
        'm95m02@1' does not match '^fram@[0-9a-f]{1,2}$'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6q-evi.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
index 78d941fef5dfb288c69d702ed190150caa92ba7a..f1cfbe2ddcd37f6e7c8312eb7a3e384c82ff61c3 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-evi.dts
@@ -124,7 +124,7 @@ &ecspi5 {
 	pinctrl-0 = <&pinctrl_ecspi5 &pinctrl_ecspi5cs>;
 	status = "okay";
 
-	eeprom: m95m02@1 {
+	eeprom: eeprom@1 {
 		compatible = "st,m95m02", "atmel,at25";
 		size = <262144>;
 		pagesize = <256>;

-- 
2.34.1


