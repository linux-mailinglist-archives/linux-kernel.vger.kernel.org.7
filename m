Return-Path: <linux-kernel+bounces-854906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4495BDFB9F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04173E8A09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E43233A00F;
	Wed, 15 Oct 2025 16:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5bpyWN1"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E74C33A025;
	Wed, 15 Oct 2025 16:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546696; cv=fail; b=n+zTpSVd6nk4BxnICbC7x15p6b6QQB+jzT+E64UKz2iROF0DjGypy7c2ZkCIOFPI8F4nfcgulheLgzMSz43/9m1mYE2Md+Ssw/r1rECjjBs1mKqoyppCSx3lWdXRfzaXXJgEh8k4O/pP2irT2uyHC3S8DwHN251MkU6FkwHgZ7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546696; c=relaxed/simple;
	bh=R8vpBKnpkLEXT+66UI2YmUmOQ2ZWT3iQri50kkI8l90=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=MNmljlMSkSmjK9vX6holXgSpZZOrSFv/zsDCjUNhlTd2Myf8dIVKSSILTYe7GvUh99GfGF3FOaI/j8YpI9DPxsQG1L2nPQCHnDLRiBonDR72yMQfxwNz32hhPSyomHSInhoJu5l4+cDxoG02x0K4VSHXu2yUjadLyBErbbTDdgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5bpyWN1; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1ghUpox8MpLnw1jQvx87RP18F+g/1v5QEtcjrUNy2GvoIwSjNye688RJX7TxWD9fbJO2dlCq0N3mO/gOpxJmsX+oOSgDUYZVmpIvDoa7Tixbgkd3Vlck9vpzRMqB53GEELkaY5lo5BGq+2ALWYHE78X/E4C0raM0ybkbKjsVPnS9eu28GhizkWy0K0RKPlWv02y5ut1Ib7Tz54GCcu+wWazc+QaPqRYsvsW681A32pek0yhLPveEKN4ZmkhqrU+TTNw6i5DMesNHhJs0sJENuzXer5P5SMraf4Waa+NxE6FovhVClM5GTG4c9TagZvPqo9Eg/C5ryWzmUhjN6aH3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BF8kK5IxVUpqdsFFvM0QNG1y/iEC4Ok3DOcmKjvyD4=;
 b=a+Qt97Uart86ar5lRqnWkaoXjt/OO8GFWV+wof+N/qGw+8cUIXYKnp/dwSqXS28SoA0WhBLj7GCHwYGyvoASnj1lmxHXRSR7qsmNDOjyxSwB0lG841+RBAom4GQdu7IoHP2KQhq269NBVjymqQgfBoqLY9CexadT8WIAeXenvIjH5fOvDGEqogXrbA0AWLHTydYdS4VUjL1aCBBt5XrwY9PUCwa9ERua7XiVWv71elQBB0OcXSE2zmPALfkCR3jIDhQbNf/GUeS30by/LWDe6XkhiFaLdqFRTlTR4Ij/S37WelVsb2DmewicmwiFYb/aigrSbjrzbXnzxF0lNUSM5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BF8kK5IxVUpqdsFFvM0QNG1y/iEC4Ok3DOcmKjvyD4=;
 b=W5bpyWN10mioDDm+LFWn5ZAOKCH9l5iJklTp360W1gH5CBDcotBY9wpYDTD995RMKVjel6R04cWNkvWmhFh/LKN+AfmrBtDVrniiFftv0CC0N73oSjiBKw1BWZZSOYaRfjbyiuSdqnJ5WnrfhinYHzojLIb14hmgkQC7LSfFE5M9LaVA7DmNr0hr6KrQ+D9F2HYI7eNUOVUkokwuyF3JQjXRAUGdZdEgPIBTNANdE6z8YPZtE9Pd8WRW6m94fEh2v40cLYe0GIe3f1nfTwoeCq52rtSDjG338+Kn5UPBb9vEyqKr0sVFj/AQReePISkjQM0ijo7+4N6hqAcGuAFOng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:44:50 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:44:50 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:27 -0400
Subject: [PATCH v2 02/11] ARM: dts: imx6: rename touch-thermal0 to
 touch-0-thermal
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-2-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=2692;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=R8vpBKnpkLEXT+66UI2YmUmOQ2ZWT3iQri50kkI8l90=;
 b=blKinCBHyqk1xWbUByPR/4a+YRGmBaG2bdYUX7jZ/PhPbhuE79LsRlwLJvKj9TErV3OAdmXv5
 6juwC9LnUUKDrbOzbxFNVi54CjA8XAdCxPTREVFghrVEOUsIVhwhFJU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ac37a4-fc01-4fb5-0e51-08de0c0a28b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WkdzTDgrVUFZbzBVWW5uMGJXV3BGeU9ISXRMa3doRENIZy94NlRUWWY1a0U4?=
 =?utf-8?B?WUlrTHIxREI5SUV5QXBJeHNoSGRWamY4WjNoZXNDMW40amFkY1dzNDFIK3Ar?=
 =?utf-8?B?QUd2aHlzV3IxaVNlOG5LSkdEYStTQWhTVUcyMXo5RWxTbnNaYzJNOWZiVW10?=
 =?utf-8?B?Um5ERGErVVJCd2RHbEZBVCtwcEJDdS9CdmNCc21LcWdWNHZkYjk1QjFnQ3V4?=
 =?utf-8?B?QU1CY2hpV2JBWW9uOEJRSGJHajJFeExMNERBdFVERmxrNVdkemNUb094NDJW?=
 =?utf-8?B?czJybmhLSXI5aEg1emdNbEM0NFVUc1QwQW9FZml5NFpQRWxCakQ0YXh6bXlX?=
 =?utf-8?B?bmsyOG9FZXBObS9YemxvaDlaR2NVR2JiNnhTRDdEZVZkK290a0MrWFp1UTds?=
 =?utf-8?B?UDU0YUJpT2x2RVNCSUlOenJ5MGdFUVFhWHhNMTJ5eU1jRlFsa0xEWnhIc0RM?=
 =?utf-8?B?amcrZEN2OWpGMkJJR3BYbzhrYmlFOEZLdU9hbVRSblNIM1VEVHBFeGtKNEEw?=
 =?utf-8?B?aGtCend6WUJWZEpEeWxRbHpGaEVyOTFHYnBxOVJSVDQ1c2lvenBTQkZsazd2?=
 =?utf-8?B?eGNOemN6Q3VKSzBWUUJxVDgzVXVlSlI2ZVpWQWtpZFpwOUxYWkFrVzkzMWpX?=
 =?utf-8?B?S1JaU1ZsaTVxcFNyT2wwUCtqb1FGMlZuWVR2UE9TQTVKSitTVC9xeUc5UXRh?=
 =?utf-8?B?cUZpL3BEV09uVEZjRGF0OGxlaFpmOXdrMS9wZGRzcUlObWFtK1J5ODk0Z1Ey?=
 =?utf-8?B?eWtJWFE1L29vRjhiUmhITWlHcmJhWjBDS1Zsd01rc0wwbGtpNm9HMXFLSGli?=
 =?utf-8?B?TmhHRWQzQnN4cm1uT202b1hLSHg0Sk5IVW94N2xSZ0ZEbDlLbXRCNEdBQk16?=
 =?utf-8?B?bFZLNlMrOHROcENFYmJ6OS9vVnNGSCtnUEk3QVRBNjRJQkJRWEc1NStvQjlX?=
 =?utf-8?B?WTliS3g5THNWYlNqeE5kWlYzd1B1YjJvbG9xcTQ0QStlVWk4bEt6Y3M3bHgw?=
 =?utf-8?B?YVFuckRqQVBkSklwNkhBWXJWcHhhcnNwMEF2NU4wWE8vbVZXT1pWYU1reG1M?=
 =?utf-8?B?WUdGUHplc1NTc1FiZnlCS1JHU21PQVdqM2ZMajJwMmFKd2YreFRTT0F0bmQx?=
 =?utf-8?B?OFp3UFdoTGpRS1cxUU9DbnF3V3JYY1libUVzTmU0ZkNPc29KdVJLbysrUGVO?=
 =?utf-8?B?Tnc3anBlNEZtRUZHZVRJQ1pkcjNobzFvcDQwV0VTdVpIOVpPWk1QelJhSERN?=
 =?utf-8?B?VEt0ZWx6NDlScEZvdE1lRDcyZzlBNnlXM29QRmJFK2Q3eUhPYlU1MkROY0wr?=
 =?utf-8?B?TnVMMVlJVTArNUE1NWFjVjZqSVVHMWtBZWdpQ0l0Q3p6ZlhIZTh2UEI2OHJY?=
 =?utf-8?B?NGs5bGRrY2ZWMlhyaWRpc1BCKzJ5OFhVdkFMMlR1UHNKM1B0OXBFeENibEhI?=
 =?utf-8?B?TFJaOUZRNTJaaUtBSmlsYjFNYTNIVUZnQUdyaURkaEVOdUkwNTVteVRPUjJh?=
 =?utf-8?B?ZlpTckdmcEVDOXhhd0d1dGN4K0FXcVBHaUNRcjR6UzBrbDhtTjRtT0h5U3Bw?=
 =?utf-8?B?WlFvbjJ1d0xwV3JhOHA0YkgyWTU0VTBTVFh5dDIwU0c2MDJNdUprdk9kL0pG?=
 =?utf-8?B?M3NJcXZkNE1GVzdxV3ZLZXRDUDB5dS9XS2w2SWpDdzZEQ2RlaDZGMklHa3hI?=
 =?utf-8?B?L2JyalYwM3RpZ3lMZ1E1WEpuN0tiSkE5NVpmTUxva3Q2aGZRTWJMWEp3NXEv?=
 =?utf-8?B?ek5YQlhpTXZwWXZicXUxUjBrK2dXN3MyYlluOUhMQUlLNXF4aC9UUTFBZVpO?=
 =?utf-8?B?SURTVHk0cWlIYStkeHlRTHNOOVN6dFpncjRKblBidVl0OGFTMldwbnBMWVNm?=
 =?utf-8?B?YkFxTWFGUThLdmxvalMzc3d5anRxL21aTFJBclRWcm9ZRG5yTDlTdHA3eDM2?=
 =?utf-8?B?cWszWXp1YmJkeFdJRVY1c2I2azZoeTR4U2o5MGF0bnd3MHE3MlZsM1JmbDBO?=
 =?utf-8?B?amV5c1MzWDJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlNxUlllR0NZNVNlQ2N1ZEI1MjlaMWVHVGYwSmp5MXNOU0lSYXRwWXRTVlRh?=
 =?utf-8?B?MzlOOFhyak85LzZKcXNwUlpMdEFkSEdPYlcyNE9EVmQ4bCtNZ1RORjYxN2Jy?=
 =?utf-8?B?MmQxaS9wMi9DLzgzMWpoSDdwajM5d3NqRGdsemVkd3duK0Z6OGlZeXNkMzFr?=
 =?utf-8?B?emkzT0czVXBxOGNpU0NvbEc2dTNwRjczNXhDQVAycDhqY3B5bnVCWWQzTi9D?=
 =?utf-8?B?U0d3aHZ0MWIzS2FFWWpsTzVPU0NBMEgrQitkRWRwTUZQeENNRlg1VnZVTEhD?=
 =?utf-8?B?R0hUb0FOQ0hvb00rZTA0NGNvRmlLNzRsK0U2ay9taHU4Z2F5cWpWR2NEako1?=
 =?utf-8?B?aDRBL0tRTG8xRWJsWkM3QlRTbWpNUnBCdjFNUzdVWVc3ZTRyblptamxadUZm?=
 =?utf-8?B?QUJjNXBFM2pZVFF6QjBhbkJtSE93K0wrdlR4aDZxUzlJM25UZGplS2gyKy9n?=
 =?utf-8?B?Q1kxT2ppUHZGN3ZLWVN2NFFOcEV5SWtOdUdSYi9janYvdElCSUJsRFB6YkZ1?=
 =?utf-8?B?c0JZbHpWNWhyZXFTaXpSNVBPQW15a1dmZDBOQ3BpVXBUTXlPR1pEQWZiZlZW?=
 =?utf-8?B?QXRPbDFmSk9rdzdFaUZLSmM1UjQzMm80RFllUEVHaG4rNmhGVWRSc3Iwblg4?=
 =?utf-8?B?T2pCWEhoTUdkUmxtS25BcDM3c29XaDA1blY1bFdlQXA4L2FMWW1oWFdWdXpI?=
 =?utf-8?B?dE1vTHVQNFBuY21nTWRLcFFNYkxZTnpmQXJvdGFLSENoSnYwQXVGa3hNRGh6?=
 =?utf-8?B?Tzk5YURWRytoQWNmcFg1U1BDZmdKanlDbDB3R2VpNmRSSk11elU4Tm4vOFhE?=
 =?utf-8?B?MVYzQU9jMVlqVE5xMTYrNWs4RU9UK2w5TUJNbno3dzZGbFdTUVdkNzAyRWxM?=
 =?utf-8?B?dGd2YWxGY203Wm9oYWpGanJqVWRSeW1adDY4N2xZSDBrb2g5RTZROHJscHVh?=
 =?utf-8?B?Q2VxKzk1OHUybnpHaEdLNUxFQk02V0l0MjNGdXA3ZnNxc3ZyTFZjaTVLQnBx?=
 =?utf-8?B?Y2FuL01QOUNVQzdtS0ZzTENDZEd2bUZLN3Q3L3VRcjBKTDAvWkJUR3NuL1FY?=
 =?utf-8?B?MXVwcWxwWDcyalhwOFN1c2Mvb0FGdWRSTzIrelhHVkdKZnNqZnltZ0Y4WUJV?=
 =?utf-8?B?cFpJQXgzOXpUK1NWNHlhcnFLOTh0WUYzZHJsQzNmMUx0VFlNdytBU2RVWWl3?=
 =?utf-8?B?RTI5RjBheGZQT0Qrb05ucTNaSmx2MEVXZ25VYldEQmVxOElaN3MzSEJGNUc1?=
 =?utf-8?B?R1dQRkxQLzB1cS8vQkk3Q3FIN1RGWmNyVXcyNnF5Q1ZKUkFnZ1IzYnorTHI3?=
 =?utf-8?B?NTJ1NEhTZC9KT3VMa3RVZnM4ckI2ZHJ2em0wQ3dGNTQzMzdyd3h5NjhkcWZm?=
 =?utf-8?B?eW9yWG9uL1ozS3hOL1pGQURYVW9zRjRJaWNCUEd6MGpzZjVaeHorLzJwTlFl?=
 =?utf-8?B?azlqek9zaG0wWjloNzc1NTdGTjNLOUVkYitKREMvanAzd2tNQnRqb3dxZmQv?=
 =?utf-8?B?TEdJYWMrRExoOGRicDlnM1dBMFJISzdIM0dFbDdIZElGVFoxRzBmeWsrai9C?=
 =?utf-8?B?SDdJaG03OHc2UjNSTm9WVm1rSnFobnE1NlBETGFSK0hXaXVlMFg4TW8va0pV?=
 =?utf-8?B?ZGJobFZDRVZSUXpDMkk3eVVNREk1VjhKUWJmWVE3SUpWRmZrb2NsTFRVbStC?=
 =?utf-8?B?YytjYTlWWkhIUVNVOG1KOFl2ZTRZTFJkL1lrQXJoZ0NETTRBWWVFUVgxbEIr?=
 =?utf-8?B?V09xRjBJdnFJbEN1aG82a1NPVWJFVEJ5RWd5V2wwdHBiZlk4WEhvaUsyT3RX?=
 =?utf-8?B?Q3I2WlFmUGVaaU10NjJIazFCTGxDMkE5bzZQOWlvWk91TEVOWWlXQTl6aUJY?=
 =?utf-8?B?UHlaaGxPMXRHL0d6QXBCQUVHLzBuWmNWWTNFVW5XWFNiN0ZPb2NGVkFSbUJr?=
 =?utf-8?B?K0ErQzlGYUx4OXBuc1pvQ1ZheEFuOGEwYUIzQ2VLclFzUmVVdllPdU10cVhx?=
 =?utf-8?B?S2dZaHRKNUJ6akkyRlJ2WWdrMUllR2djNm9wRXJrYkVseUp4eDdrRkdJVUlw?=
 =?utf-8?B?NTREcWVrVUVlVzljZk9CdFNzT1hBTnJaR2RrVW1GaGVYUktGNmVDZFdQK3pL?=
 =?utf-8?Q?6YdfTPeb9D3RKyu/rmLN8jEmO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ac37a4-fc01-4fb5-0e51-08de0c0a28b8
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:44:50.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxyCGcnnV1kbn0WfFreiWPRY94itEjCAruYe0ZvYcKH+K0qd7xQ1I1yqcRNlRpjT+CtVn4E98cjbbTkIpA6a8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

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


