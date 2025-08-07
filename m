Return-Path: <linux-kernel+bounces-758552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E148B1D0B1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B6055835C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561232144C7;
	Thu,  7 Aug 2025 01:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="POCx/C62"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013056.outbound.protection.outlook.com [40.107.162.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABDF20299E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531299; cv=fail; b=ScB842eAsF5xqyy+SIS+zCUx/Ejab+9E2D5z0x25hG0ocHl0aTc+X5ihggK/OKqI1gYsRbEUrAsvE1XSfdat+GmCpiUlWpOzJhPZAYK7tJ/NeBbiusTxyK6elE11X6g5yMIvXJpsCHpfnn3isk2QDIktY5f4UCikS4OF+lkaGrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531299; c=relaxed/simple;
	bh=APiFT9JTFOLKYO5B65mFJHCD1F5+atccwQxWyBKzFgg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gjsLL+CqE7xkPmVhceJWoVyOUUnxPaaxXvC2YXwsdqC+BfTZiKwrEQGdtynt88UlCY0Jqrq4BIJNfEFIISanYeMwhzBl1yyUcbmo0242xchkGjN2Z4sZ3GRXfcNOsmLqegnTBGBCxDx+6LkCoiApr/mgfFYH2zzQBdxkifD2/ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=POCx/C62; arc=fail smtp.client-ip=40.107.162.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i9fNnDHfNW27mtu/NTNdWRq6LjPrxgRP4ErDUVv6B5PWdLpRFkfvsXiS+sAjKCe3ksd6NQecq+Q87F/D/b3wOhD5cMa1NLh8AAvfPOPjnXj7KIbYXccmnNMdDlIP4i5lr4qT2bdym+xgjyba5rybs6EeRcU+PmrZxkOgDvb++PBQH5f0eGM8/bcy82H4W6Ptc3vyR4/BDxf1+yzmp7JoqTod03Vkhxsd8WxbnoYXsapESBnSYKvZBs+nQGKok7jsx4p5xINgD4vmOHhvYeNgZH5UwtONPxEeTIDRz0xqDRSwnoSnkff3j+Uk1TiLmmzE7zva49mGHvn7Q+hS3W3/ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIwQeNtrRCwVc0tTP8vgQawQ9Cj64tSZEMwkNHcMy/4=;
 b=Zw6AcTK0iHxtToN2N7/dfFEJq9pG5GN0LYF1lVmNs3VPEzl3zc17hra7p1il/5efOrknIzj63a1PAK6hDEryW8fuG26+KCffClHv7Qt+1F9liQcpKqn/rPWju3fcEep4fZK5eP7TJDQH3jLAiDSuytNLb4TuusFtKX4kI0bjOkIVXqFmjq4RuwPCqB6RkDq95iSfdfRbM+VWA433BlIVO5Wekifh+tja6qmRQKZton/NVvPxymMq2vDkZyhnk8oJ7y7efxwgbcK08jbNa50HCnzudgmhzQiVjJDNdC2mBSK6pKc7Q/WRgzDClLvTgWeMEZgbhzq7Ude57vgmd+gtew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIwQeNtrRCwVc0tTP8vgQawQ9Cj64tSZEMwkNHcMy/4=;
 b=POCx/C62pm0Af0qJLKtcX1JzqSplWsXOp+i5vGLyyKuKrovi+lqeLq+3UesEhRMlp73UnR6qJmvzXmwQhB8mj5suI1gMpBsBAGFAKHMsG3rZcG4ixpQA5pnn6vqV9THGTAVMXUDyHnkPsYYrsJ6VKJt3qovzB9F0ChS2MZKTmSU+FpEwxjg+G5ilqxhpXui/9o92iNtb7zJW4wp1c93xokNFLWZk7Nw8U27ZYm36sKXbYOnc0+Z9PW1UixFzn8qJXLi4g7VL9v43a+ySHMvVDYEV3YjzQ5Kvaq/UaUFXbzMzm7AHDCNDYsrTWoKTFgOCsKIzeLIE+pXnSP8u7ra5Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7683.eurprd04.prod.outlook.com (2603:10a6:20b:2d7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Thu, 7 Aug
 2025 01:48:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 01:48:15 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Thu, 07 Aug 2025 09:47:44 +0800
Subject: [PATCH 3/3] firmware: imx: Add stub functions for SCMI CPU API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-imx9-sm-v1-3-3489e41a6fda@nxp.com>
References: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
In-Reply-To: <20250807-imx9-sm-v1-0-3489e41a6fda@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
 Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754531281; l=1730;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=APiFT9JTFOLKYO5B65mFJHCD1F5+atccwQxWyBKzFgg=;
 b=pOWm+EMgJcUv6snswYktd1a051NZzmHF9LLYpkgsTkFyuR9geUpm8JU4wyKQsT51ibIx55ht0
 glXDu6CYxHRAJlJuzdlveOUTwV8Zpgsd6o0KXYAv8VPBkl8SJJeN0SQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7683:EE_
X-MS-Office365-Filtering-Correlation-Id: d396c46b-bb34-4872-9ad4-08ddd5547998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q214M1Q4T25HYXJQaXB6amFNN2M5VnB6M1JDVytzRnNYVVl1ME5OdUJCamZW?=
 =?utf-8?B?OS9rK1VkcE94bDREK1ZhTUUrVEpWMURYcGdGVVNoWGN6VzJLSG9zM2NBekNG?=
 =?utf-8?B?ZTFQRXk0aVhqYmtMeFBFcVFFaUVPam5kU0RUTi9HejY2N1MzWE9qaVNlU1NU?=
 =?utf-8?B?WENuVEkzY1psSzljNGRqT213bFZxSjlDZm1YT2t2dHVCR3NibVAzMS8yVFBo?=
 =?utf-8?B?ZEkrZmY2bVcvWUJWYjhoeEZ5YStuangrb09qUU5Ub1RqY2lPUVFBSXlMcGt6?=
 =?utf-8?B?ZEZhRFlDNkl4UTRoY0JzRXg5R0Y3WU9qT0J0bmFZa3QzOW5wYWxDM2ExTWMz?=
 =?utf-8?B?VnhHQ3VMR010TjIwWDhDSTRPQ0RackFhc0tUQjZXUVFJVXVjTTRnTVdmbG9x?=
 =?utf-8?B?YnNUUzA5eVlsc3dBbUlTS2hKZHNvNEwrV2s0bDllYlB2TUpWSlZGeE9hb1JW?=
 =?utf-8?B?aWtoTmxCVnYrL29XT2ZpSUIzT21PaUo1VE9kVmFMaXRldnRIZzcrWUQ1UVkw?=
 =?utf-8?B?S3RteE9GT0JDMDZNQW8wY1lzMXh3WWxhM3JObGtRRi9wR3cwMkhmSFRQUFdN?=
 =?utf-8?B?MnRnYUd3Q3NYNnhCaEFacTY5NFlMMlEwbjNUaFVManBQRHFzOUF0NlA2OTA1?=
 =?utf-8?B?dTgwbjRaMnNNVmFOOHNaQWN2dnVsT2R1OWlmZkNmdnNVSzRicjRZZmtlYjRu?=
 =?utf-8?B?eTJrTW5ZTUFUNEQydnMyamRnQVVZWDNMMGN5S1hHNlp6RllDL29IZXlJK1Bw?=
 =?utf-8?B?ZzkvSXJZMFdmcExPcW9SMU9Db25Kd0FoMmJxV1YyKzZvYXVmMGtDQXlQZDB6?=
 =?utf-8?B?VHdSK3F5Slk0eVBxWW56cnZYcDU5Nyt4Y0FscWJmclY1WG9ha2FPdzdaZ1NO?=
 =?utf-8?B?YjcwVzVSTlVWeVpXVGtOckFKSXNkUlA5ekhyb3VHL25aYkNrRTUzZVF6Q3BW?=
 =?utf-8?B?YWNVbTU0ZnZHZzNaUzlDbHlGeERxZnFjbVJSaHhxRHhWWEpOYTZaYTFLaDB5?=
 =?utf-8?B?YW1kZDhCMWhXN1JWbHlEdmJwTDVnTHBoRTgrY08yRnBkZEtnN0JHRUd1ZEpL?=
 =?utf-8?B?RVpXcjRUZmhIbU8vNE9JVktiU053emU2TzBVWVF1SjZmK1h0OGp1bDhaRW1w?=
 =?utf-8?B?TDljVS9HWlg5MHZjYndNM2lkZi9wbVBjcDVYcGlmRzVVUnZFMFYyWkRibVRG?=
 =?utf-8?B?bDU3dCtyZUZnSlJob2NwN3gvNk9BbzJ1NThSNVY4V1ZGbDFwRHB1ejBFcTBG?=
 =?utf-8?B?YUJpZHROdXU0WTNTQVZkWGJvd2J3QkZCVENYMEQwRlF2blluUWhPWUhseUtM?=
 =?utf-8?B?NjRVQVYxZThBUUU3ZEgySG9zcVdBSWQ2WW50UkFEVzZUMHJsc05JbVFXcXZ1?=
 =?utf-8?B?KzRhcU9YM2IwOW5EbU4wVTg1Y0k5enZiL3lrU1M0aUd5OFhiL1dLU2gxSWtB?=
 =?utf-8?B?YitaZGNTNkszdmZQSWN6WmVBNDhDWEV5UnRrTmxmWnU4dkdPbVkrZ1E5S2xw?=
 =?utf-8?B?MVBUTG56eG9wZjBjdE5VbmdCbDNMTS9wenBabEVTTTd0TDhZbWM0ZVp4dDFr?=
 =?utf-8?B?NkZ2KzMxRlRNbUJ0bGRrcGR5aW93TU1pRjVnR0c3QzBrTkgvS09yRE1TNEs4?=
 =?utf-8?B?OURvRVYxR0RzRVZDVWZtQ09SeXFwOFpGWG5ySXYrcjdUazZLc3Uwc2ttMVBX?=
 =?utf-8?B?WFhUWHROYXhLVlp6UmJ1SStCZTRnelVaZDZNdjFCT2NmYk1BOG9DdGZONmxq?=
 =?utf-8?B?NTluY1YwdVRjZnBDOVhWOTRXcmVwUFpMUjZlRzZpLzRjMXBDWUJVNTZ4OEkx?=
 =?utf-8?B?ZTRHSXdRM2FZQnRyUE85ZUlyYlQvOTVnVTFrNGU4UHZJQTRnZGtYNmNROEo3?=
 =?utf-8?B?UlMxOVpFSHVxK0NnQmc2dG9xdlA0N0xmNjlxUVRIQVZHUEtwVFlJSFBocW00?=
 =?utf-8?B?MFVXdmM4R1hUUG9oSUZNRmxPMUQzMitOMlBqNGN1MkpENDV0Y3hEYUxFcTBV?=
 =?utf-8?B?ak5hWVZpRGVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NXam51N0o2a1liMitSa0xiUk9KOVVQMDVxaklxRHB4M3hxZk1JZkdEY3hU?=
 =?utf-8?B?WitXRDhLYlFmWkZ0NzViQ2ppUGlwYTNRNjhXU28rblYrVmpCbkpHY3lGUDBa?=
 =?utf-8?B?STJHRHFnTTNyVDY3THFnZXFOOUd6bTZyWStSR3pScUltaEkxeUFTVkVkbThP?=
 =?utf-8?B?cGhXTGhWc0xJOTFjcUt5Qk4vb3Z0SHd1aExWdXQ2eEdGNzdHSWFnRlUvR0My?=
 =?utf-8?B?Z0o1Y1FPUHgzVXlocGVTTC90THFTTnVmU2k5NVJGck80Vm1HY2xoSHJTS29w?=
 =?utf-8?B?eWJyL2VHaWZRNkNUZ0pjSkVJQitZZHJIemFjL05YWmtIQVA4SmNuK2MwNno1?=
 =?utf-8?B?Vk1BbFBaNTJBUDI2S1dQQ2NBWGtFYm9vR29nUDhEWVRkTS93K3p5UXMxUXpB?=
 =?utf-8?B?em1Mb1hyejl3L3hqNm5iNEVGUVhiNS96VEZJRHl3U0E3MGhFbnNEczFNWGR2?=
 =?utf-8?B?SDFDR3gxSWdMTmdqOXYycWwrQlBhNG5LSFprVWNwbm5sQ1U3Sm9aOGcxQzhh?=
 =?utf-8?B?MFlJY2lXVEh2cEh4K3g0V2QyMDdIM0ZxbjY4RzJFQmxNWGViUlJ3bVh5Wkhh?=
 =?utf-8?B?djBhNVpab0hkekd2ZkxVRGtldTgvLyt6YStTclk5ZnF6Tm94Q3JZY2hhSjcw?=
 =?utf-8?B?emFERllXMFQ0Y0tMVk0wUThjRnQwcVAwczN4WnkrLzJzSUduK0ZySnNxL1Uw?=
 =?utf-8?B?TjNqUlpwQjVPcU1XaitjdmxzcjR1VHFUTTFXcHVvd3BBdm15YUpud0ZkRmR1?=
 =?utf-8?B?Rmdncm9oa0hsb3hXVTJRelJZd01jTlJkNmdhOHFxeTVQUXJFS3ZIQVkrdFpT?=
 =?utf-8?B?dVEwV1lweTU1VHV5RGdRblo3ZUxjcVkwbUdzamtweW03TGtzUVF4Z0ZTV3Rs?=
 =?utf-8?B?dE5UNkc4MlhJdExtTTVNVkl0akdsNEFHTkJHNGVyZkJPVVFaMFFWMUpzOTU4?=
 =?utf-8?B?RVgrM0lEN3VzUE52a0tnWGJTZnFwaDdBUHVPL0xBRGRCb3Uxa0xSRnJIeGJk?=
 =?utf-8?B?SXhuallpdE5BWXNaVnJLeXdKcTlpbWwzKzE4UmNpUkVrUzIvbVA4TEIzbjg3?=
 =?utf-8?B?eGJjc2hIMnpheG5hNVJhb0ZVWEI1WkRTL2xPTC9zMHNRMDJUWkt3aFMvd256?=
 =?utf-8?B?SDVsVWFXcGR1TmlrcDVETHYrSnRFUUhiczNkaGZEZ1RRSklZa05mV3dUVG4z?=
 =?utf-8?B?dFp1QkhWbVFTMndzVUFuZWNyYnpVM0Q3c3ZRK0FRTTBlMlpZRjFGNVFwN1M5?=
 =?utf-8?B?QzFjc0IveDVnYlZnb1U2V0E5SVhPVlJOOEpFTEI0OUJueHBGelVqTW5BUjNX?=
 =?utf-8?B?VTROL3oxeGdOV1RkU0JwZHVMWnRTZ1plSjc4WW5YbnhCNGZ4bnlCeFFvU3VO?=
 =?utf-8?B?VDhjUFMwTXhuT0dhNTdGd2dDVXZKalVvNG43Nnl2R0U5eGRIV1FKSkMxYkxM?=
 =?utf-8?B?T2ZjNXNMdTFQR0ZqdFFaczZNWFRtSVcvU3V3SjFPZ1ZYcDB6b00wSXoxK1p6?=
 =?utf-8?B?eE5PenFod2U4bjdxZGVHaU9pTms2MHdBS1VDcXNVVXEvSXY1OUV4NE1wSmdi?=
 =?utf-8?B?aTNrMHluMjUveEJ2TDZVcTl2NEYrN0pBQW1YcUNwZGJoYzB4SDFWSkNjbjhy?=
 =?utf-8?B?SE5Gb1hRbTMxc1llVW1Bd2lxUXdDdEFNcjRPcTN6RnFpMkZrY0F3SGc0UHlM?=
 =?utf-8?B?ek1vc2MwMXVkM2ljNHk5ZVpDZFpkZzl1L0NxSTB6N3g3TWlOQWFXc05BMUFC?=
 =?utf-8?B?YVFnU2NhRGR1WGdCRWtNOU9NSEllMGQzWjBGT2NBNm5RWm1wYWRmZTBUN1Vm?=
 =?utf-8?B?bExlT09meENzVzdRTnhNeG5lekI3VU44SmNSWnlRMU5WZ3JKMkZlL2RFdmVY?=
 =?utf-8?B?RjFuRzRnL0xiVlpLcFJoRkxSTGdWd0tocWY0Tm0rajhpTU1GY1FaazFnMU1o?=
 =?utf-8?B?eHhjOEhtRGNORGw1c0lhTG1Ydkg5TEJSYnFLcHVuRFJtWVpJc0lhU3RXUERl?=
 =?utf-8?B?NGJmZG5GZkY5STQyRmx5UFJhVWN6QVBTdm5BMjlHdlh3S3pEaFdXUkJhSXBJ?=
 =?utf-8?B?c3VHMVl6VEpCc0JWZ1ptMEgxZ2E3b0lnSGc0VitCRk5KSERKaStnTy8rdjRt?=
 =?utf-8?Q?1qpd5da8DCbjaTF04cQkSEsO4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d396c46b-bb34-4872-9ad4-08ddd5547998
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 01:48:15.1936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HV3tizGRz8dEX1lcKhk9Z24IGJnXyiv4wWy8XgGAir01Mshl7IJsIEQSkmNwOIh9TC9NjxiNNsdVsg2HuTTPoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7683

To ensure successful builds when CONFIG_IMX_SCMI_CPU_DRV is not enabled,
this patch adds static inline stub implementations for the following
functions:

  - scmi_imx_cpu_start()
  - scmi_imx_cpu_started()
  - scmi_imx_cpu_reset_vector_set()

These stubs return -EOPNOTSUPP to indicate that the functionality is not
supported in the current configuration. This avoids potential build or
link errors in code that conditionally calls these functions based on
feature availability.

Fixes: 1055faa5d660 ("firmware: imx: Add i.MX95 SCMI CPU driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 include/linux/firmware/imx/sm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/firmware/imx/sm.h b/include/linux/firmware/imx/sm.h
index f2a72177bb37c1d46145a60710e3809641e0f5a2..a33b45027356751f4b8ad9b9136f0dd302a82520 100644
--- a/include/linux/firmware/imx/sm.h
+++ b/include/linux/firmware/imx/sm.h
@@ -41,10 +41,28 @@ static inline int scmi_imx_misc_ctrl_set(u32 id, u32 val)
 }
 #endif
 
+#if IS_ENABLED(CONFIG_IMX_SCMI_CPU_DRV)
 int scmi_imx_cpu_start(u32 cpuid, bool start);
 int scmi_imx_cpu_started(u32 cpuid, bool *started);
 int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start, bool boot,
 				  bool resume);
+#else
+static inline int scmi_imx_cpu_start(u32 cpuid, bool start)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_started(u32 cpuid, bool *started)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int scmi_imx_cpu_reset_vector_set(u32 cpuid, u64 vector, bool start,
+						bool boot, bool resume)
+{
+	return -EOPNOTSUPP;
+}
+#endif
 
 enum scmi_imx_lmm_op {
 	SCMI_IMX_LMM_BOOT,

-- 
2.37.1


