Return-Path: <linux-kernel+bounces-851811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B1BD7556
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA8663E6401
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6D030DD28;
	Tue, 14 Oct 2025 04:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0dcfCeA"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B930DEB6
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417714; cv=fail; b=Qg8d4+fKGPN3HdXYUsPu2TrE+5F9vWW3MD/W9Geph+UV7mKMmOftwvmTxGnAAVrcNcHZgCxOomLDwUMF1ZRwSl2tiGijhlaYhSckHnGZ+mbEYVPsCyvQ/GFxNYIJ9f7NhMvyMZQBaRdzS1BsFMLB3/5AQowZENjDWK9QGDpni7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417714; c=relaxed/simple;
	bh=g6Xbw+yvVzO5YKoAyuvORDzNLu0Cw/v/cAhU6pMy/PQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YUagj8y7BH/lfj1LhgMzdIT0+ofijk36Ewla2jDFOk9V+sGI85RPc4DdBfEE8H8993ZVgfosTDEzUtir4ElbOSybRHE5ZDfbtvDtnLb3TxElEkspS0KZmWLaHlId9uKLDmiK0xpg03DRS7SkaybWn48ahUWzY0fBWYc7urCqeAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m0dcfCeA; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ffS2Q9RApYHKatGG9nAaBTx3K8jfGppn7ZF3oIAYr39VaDetW5xQHQ582cCTCm2yIM2vTU2QZf6NROqFXm+EmMv4KD58I/Pq5dw8IRzHmHk8vCAK+ASZrCmdH01KpKl4lBSgxqq+B44kmjblpjUq1CVwVeQ+GHVycZM9jgS5+0DCge1hTCK/0RfSdnT3lfcd6KCQjj+NsV84Rd9ekOcCm8HGT31uWR5V8q3d9XB66azeRW8hXVICY7R3LmywEr8YzdUOzQILmkupIKCi9zC0c/w8X5W2eQQwJaFdGns+qF0Cc3HJHO+vOIMt+JB2WJMbOY2btpSOMws9n/R8Xr1Sog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WpwogZULccC6Wg64K7czRmj5TzqzdfrEXp0ncUEbJBU=;
 b=mvG7p7vKPYRRIaNZGEQvD59bUKnc2SGHaKKr35zXg/M1iV9XxpkALv1bI1fJ2udlhxaxr6sbAkq0nep7ujzk9n6t7a0QYnHtDV6Q7buKKikHqSjAPM53B16GZ7wr5MkZqwolJbgowXLOza+qbnMVa8bFigAlY2PKxAPddSNTDzCRZCRlxjagRUas/nQT2Z0lck+QgYLI8VOhK0BWa8K63cRhgrOwgz6u6NaegAp/e0NMUXqebPRedukukyEDbFXL/QAbwpL8ou+PfSeO+l8NdfH9o705sAfm27wdphO5EmoIvqqD+YqQjoPmoHApMCy2RU6M0NbU+IKHzH5cTyqYGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpwogZULccC6Wg64K7czRmj5TzqzdfrEXp0ncUEbJBU=;
 b=m0dcfCeAd+VJJ9ghOkrVNpYn3X43S5GbAe4uwbtaoE9sUcohogvPvBlvpuUxsmcYxMZ+7H+aYz3Xf4sE3a46s+TrrAdrrzMxqcSYy+zOWaUJtwpAjqIyVhV8O4c0bluXCltVeb4EeDnH2gtdIIxMdbmT+7fSsncsCwqMtLXk3JC3mlxacVYgdJjkBLnfVkETEzAl2txkDgh4teY2PMESVAWTZYhcg6avjae73oxOxBWwW5gjb3DKhXuxEW3+wrM9JxW/EbpiMkHaPw5YavwDNhRoyHEfngU795P/9XTTEikNUCklvsdUpU4rn0ZSAjxt5lasreZ1lHrkdLM8C8a/hA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:09 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:09 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:41 +0800
Subject: [PATCH 4/8] firmware: imx: scu-irq: Set mu_resource_id before get
 handle
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-4-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=1725;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=g6Xbw+yvVzO5YKoAyuvORDzNLu0Cw/v/cAhU6pMy/PQ=;
 b=ufMHqH5Y1EtbyNpB/HIMFYDdA7KSOicnGId9ttVyJDYOnHEgBF4iP4PN1v0Afr6to9nk+uVX1
 +eojsnQpEtoDJRGyZk7sJwDWkjjZc4qIZaDJa/j30Sbxdg131gU3OoG
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
X-MS-Office365-Filtering-Correlation-Id: 6c353909-9743-4205-b994-08de0addd99b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWl4Nkl5d09ZUUNCMHJ3Z3ZVN0NXWUQwMW9mNHZLTHYxTWVyRWR3cDEvbmdu?=
 =?utf-8?B?eXV6UEtpZVBHSktDblgrUGhiK3h0b3dJOTN4NGNlY21WSUNpTitLZzMzNjdX?=
 =?utf-8?B?bFVQTmRBazZJL25UUXkyL2I1cmxONnRpQ1diNnNEMG1IS3J0MXFCZ2dlMXls?=
 =?utf-8?B?N0pIc3Z0dVNFSnVqQ1gyaEJETWxWRVJYU0Y5aXl0aVFZcTJNNXQ1aTI5Z2JN?=
 =?utf-8?B?S2dhemhnYWczODlrWmlnWmFLMFBoaHNnWWpqN05sVVNTbUlvUzQ2MWpPNzFD?=
 =?utf-8?B?ZlRhRGhZQzB5czRhWjZWWFVINXdJdTlaendqVjZkd20rUHozeFBlUTNsdmo5?=
 =?utf-8?B?OExOSVNXTWdpOHR1d2h0OWNFVmU3TitTdkVJc1lGOVFlcnFEVmZHSUN3NWRs?=
 =?utf-8?B?SGpUZ2Uzdzh6eHJCRSt0SXNOT3JmWS9pMk5mVmo0a24zaU5SRG13NEQ3MUw2?=
 =?utf-8?B?U3JyY0thd1pvclVxK2EvR1ZSL3A0NDBhK1NpdzZQODZqUEJzbEwxRGJ0b2dW?=
 =?utf-8?B?NXY3WVZNK2RIaWh1SFM1bnFIUEFaM1dHMDVDMVBNOWRlby9PU3dQZEM2NG5J?=
 =?utf-8?B?VjlnbW02dVhVb3laVWNMWktIUFhKb0ZUK2xVbnc0ZnJadmQvY1c5MzNXTyt1?=
 =?utf-8?B?RkxhVmVjN2FrSUVaSkl6ckRPbTg1blBwOXJ0MkxOQjlqc2k1eUg2N1lKVGZ0?=
 =?utf-8?B?QUpwMVR5THBvcS9IUEx0Z3R3US9nLzN5Mi9jekFkRkJHeGt3R05jWTVPNDVO?=
 =?utf-8?B?VjAvTm0wNjllZXNMNG9QTFM5MU9GbmxRaGNldXE5R3FHbHBBUTE0UnBjcXQ1?=
 =?utf-8?B?T1pudjVibkZHNjRRUXFzSjRLR1ZGWnF3TlJ3V2FNaVp0MkgrbitjcEF1dVRq?=
 =?utf-8?B?SGxJOEp6Nm9HOWF0aTU5WDJLWVI1b0dFTnNXWXFwZEFtSElBSXAzS2toaEpl?=
 =?utf-8?B?K3JTS1phMEVldDZvaWZ4Y1dxRVh3aWpkdExveVI5RWQwRVJibGV1ZVFoTlJB?=
 =?utf-8?B?MS9IY0Y3YXdwbGxHSEQ5UklxZlJYWE1oTDY2VUsrckc2VC9pM2FSc2xUNzJ5?=
 =?utf-8?B?bHdOQkhYQ1hvM1VVMnBPSDIxVVdIMjdXY05lNnBteU9ZWTllbWxCZ0QyalMx?=
 =?utf-8?B?aExaMm5POUtaZDM4MEM3RW40V0lzQWhEb2xSVVRNb016OHhrVmhPc2s4QjhM?=
 =?utf-8?B?WW1VK0FrU2RwU01WUDRNR2swVlRCUXRBTDArWHhHcFJUaEFTeDRwbFJxZ1cx?=
 =?utf-8?B?S2RuRlExbjhCQnpZZnlzVStFM0NFbEFLcFl1bEt0eUo0Y0cxOWFOUlVMblRY?=
 =?utf-8?B?NktiTzRZRTB0Z2FUcXUrOGpIeTkycnp6NGtwRWZMK0ZycTI0YTBaVnhhSzMz?=
 =?utf-8?B?UnY4YnQ2Yzh6ZkppaGJmMVllRDNxMXdLc1RPRGRndzQ0a083ZVZublNuY1VT?=
 =?utf-8?B?bTYvemZ3TWVKcnVkdDhoZG5lRWVRZisxTldYWVN5dzg5dXJnVTdHQ3BUY1hX?=
 =?utf-8?B?djdzTjlKaGFKSUwwSElmOHNCVlhLMldvSWVHT205eVNxcGRrb0wrZDFMeVdB?=
 =?utf-8?B?YnJSYVZWZGpHRHpURCtZNmZxdVRNK2tEZnllL0JzRG1FZ0Y5dTBTcXNBbm0y?=
 =?utf-8?B?dHdBSVNZaFRSYkpFK1JYYmZ0Z0c4eG5IallWeVVuZUhvN3RtVndabDQvdjNL?=
 =?utf-8?B?ZEVGeXVUT3RZMk54MVRZZnhuUEV4Qm13bEEwOTVxUEVmaWxJTysvL1pqMytH?=
 =?utf-8?B?N2hTY1kxWUpzZXozYzBzYzByOW94Q0l1Q2tIVGZaV01aQkx6WFJFYVZMWkxk?=
 =?utf-8?B?VG5sdUNpc0IwQmRLNjFmMVhwUXdjQXFRYkpoWVI1eCtKaTRIMDgwL2lRdnpj?=
 =?utf-8?B?MFU5Y1RKN25rNE1DS1NiUjdKUFNqNHdCSEZ6NzBqNkg0TUZKa0RvQzI4b3BN?=
 =?utf-8?B?WENBOUlaYUZqVkdDQkllLzdQZUlCS3ZvNFhXQ0pRdG5kbTdBbldaWDZCVStM?=
 =?utf-8?B?dldDbW5lTGNLb2xobDdxaTdEVmJ4dHdialB4eG95NFFVQ3ZxeWNhQ1JwNW50?=
 =?utf-8?Q?uWXsFn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDB0cGdGNWRHbTBNeGJGZEsvZEpVYldGdXFSSHRuRGphSnJ1UUxzdGhFVDM5?=
 =?utf-8?B?NnVPR09sYkpydXZaNGpUeVBmWXFIaXJEa3dSRjl6QnlJUjBVdFYvRWtUWTRT?=
 =?utf-8?B?dU9WaldsQ2c3czlrUWsrTzZXYVFZRFdsTHdYbXdLbUZsSzdZV28vNkRJK0cx?=
 =?utf-8?B?UGxKaGtBbG51UWt0RUlZQzlpTkRXOFhsbkpXaGVNM00zbDRhRytNb2NvVGNj?=
 =?utf-8?B?UlIvMk05ZkM4UmJhR2JZNitWNTF2Q1cyTURLTFR6cHZENkhmNER4NnhyM29x?=
 =?utf-8?B?MHM0UW5QZ2JSYStOaDlXZSsxbWtQZWdPbXdDRHRabiszUW1aSjIyemEzV3ZU?=
 =?utf-8?B?d05GUzB1U3VVclNOZDM4NFNTZm9RNVZ1MjEyM0VYOWpKMzZMSExLdHA1MUIv?=
 =?utf-8?B?RG8rVVJTUkhZbEg4UWhGTUQ4ZXRzdDhHMVF6RnlHM0JQUnRSb1RteEJTdU81?=
 =?utf-8?B?cGtOTjVzR3VZT2xRK2p3TVM3b2tIdFd2cXVSeUdNTlVUUEJQaG05WGpJZzZC?=
 =?utf-8?B?VVBPdjVlY3U2WHVpc3JjNEFiaEhKdmJMT21RTm1CSjNqTTBMUTRPQVdSMDBT?=
 =?utf-8?B?UXlDUS85V3VYck51YnVhUmd4REF2VE9DOE51OUxKV3BONU9CY05sbE51TExt?=
 =?utf-8?B?cElQcVJrZHJmZ1JJV3VYbzNQdzlVOFZqUWdKd2Q3bzRSb1JqZEhzVGJQS29r?=
 =?utf-8?B?MVVTOW8raXhmMHNSOTNjUGgrN2QvNjY3Z1VDeTZxQWNqcTUzSDFNVlQ5R3dN?=
 =?utf-8?B?aGMwb3B5N09JV3ZWcmJkQWExTkd3d1NYb0hDeElCTDZjb2dyUCt5VzUxQksw?=
 =?utf-8?B?V1l1N1J3a05RNmtPSWhpemlqVDZCWVZjWXdsazlzWXBkczdwK2NKd1pPSGw2?=
 =?utf-8?B?UGQxS3AxcHFhMFBQM01WVlM1Ylh2RTJDc1NRQWx4SEVGV2REclhpUUJHSlRu?=
 =?utf-8?B?dGZHZzhzOElrb3pSR2pGbW5jL2tZRmg5Y0c2ZWpBU3hXbVdVZXdCQUNibUFB?=
 =?utf-8?B?TVJ3S1RJd1lzYUl4V1FDMlRBenZhY3ZZcm9kbWxSeG9aRUZsTkpCenE3eVpU?=
 =?utf-8?B?dGJDNE9qVUxoc01EYTFkbnZhUE5WSGlZZXFLaEJ5am5BWjN1WmNUd0E2ZVBw?=
 =?utf-8?B?b0ZDanhRNzZTc3QxaEY2eWZZUU9ZWXFDajJSdWNUZldnaWRFYkNSS1lpaVZS?=
 =?utf-8?B?cldMaEhZUE9EV0pNRndOZU1zS3VrZUorcVZuNk1yUlJpMXdZVVJqemwwc1Bh?=
 =?utf-8?B?cWdZWTh2WlBxMms2SzN6NG1IUkVYV3JBWGwrYS9scWNaNFVPeERpWi9jbk5t?=
 =?utf-8?B?b0JNbzJaOTNqZGMrTkt5dG1YUTl5NEE3dW11Rlp4V0xuMjRtOVY3TnBQM0xn?=
 =?utf-8?B?bkg2UzNBa0lNYXVYQkFiUmRrcU0yY1FFblA5OWtreUdJVkpPQ002YkdsT2Zs?=
 =?utf-8?B?amFmTnZnSGdGT1pQZHEwZkZ5M3JLaFpaT3BiSjJiaTkxRmVueXNscG9yVjA2?=
 =?utf-8?B?YUp6UHR1S0xIN3FUUUROaXhtUGFzMVVieFFTOFJLemxjRzdCV21LQSsyNElK?=
 =?utf-8?B?ZGR0S004NVZwNlh4NENpc2lXTlBKYlBXbUVLNTVJQkVPUTJSOWVmZWc5V0p5?=
 =?utf-8?B?RlZqNndEZHQ1OXhxV2FzbzRKaDd0QVloUlhrWWdJRFVUODNrTWY4cHYzT2x3?=
 =?utf-8?B?NHVrdjRsUjFhZkVpamlLdVBNelhwenp4WXM0VXNQcko4UDJtT0oxaVdUSzZZ?=
 =?utf-8?B?V29FYlBjdHYvb3EweDMxbEx5d0pHYWc0Ty9JODY1cDRpWEFxZk1wendmSlNB?=
 =?utf-8?B?S0FYcXNMY09KTTVFNjd1S1F5bVd3MHdhdmhCN2x1Wi93RzJjb0graDZ3ZVB4?=
 =?utf-8?B?OFhHY3dOT2lUenhsMjNxQjJ0RWx4QXFkMGYzdTQvZ2F0VTh2Z0tRZ0dDZGU3?=
 =?utf-8?B?VDVhU2NDZjBVRVZWMWdoRytSdGxZeWtCVEVaQWNmWWdGenVUdjd6em0wK0Vm?=
 =?utf-8?B?a1diL0RBWTVGbUluQ3dOWU1GNE1yaHZDbzVlRENMUFAxMlhBTlFUZG5RMnlP?=
 =?utf-8?B?SkJtTSt6UjQxVFUweHd5U0NxTS9pU1lNYytlWDNWQ0g2YjNZRzBrdENMOUZJ?=
 =?utf-8?Q?TXA+4pyONIOOp+dtIG1nFKwQV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c353909-9743-4205-b994-08de0addd99b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:09.5088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/oZbPA49dCXvVxiYE3R+88upicoykZzuZXI+WpCvHWJGxdpzTbOpc8FO8GFO8ctRGSL2+w4XZPv3j3HlRmBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

mu_resource_id is referenced in imx_scu_irq_get_status() and
imx_scu_irq_group_enable() which could be used by other modules, so
need to set correct value before using imx_sc_irq_ipc_handle in
SCU API call.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index a53ed2040c0cf7065474d681b2eb933a15877380..1346b75596293892ccd90a856d46f52171d88734 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -203,6 +203,18 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 	struct mbox_chan *ch;
 	int ret = 0, i = 0;
 
+	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
+				       "#mbox-cells", 0, &spec)) {
+		i = of_alias_get_id(spec.np, "mu");
+		of_node_put(spec.np);
+	}
+
+	/* use mu1 as general mu irq channel if failed */
+	if (i < 0)
+		i = 1;
+
+	mu_resource_id = IMX_SC_R_MU_0A + i;
+
 	ret = imx_scu_get_handle(&imx_sc_irq_ipc_handle);
 	if (ret)
 		return ret;
@@ -225,18 +237,6 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 		return ret;
 	}
 
-	if (!of_parse_phandle_with_args(dev->of_node, "mboxes",
-				       "#mbox-cells", 0, &spec)) {
-		i = of_alias_get_id(spec.np, "mu");
-		of_node_put(spec.np);
-	}
-
-	/* use mu1 as general mu irq channel if failed */
-	if (i < 0)
-		i = 1;
-
-	mu_resource_id = IMX_SC_R_MU_0A + i;
-
 	/* Create directory under /sysfs/firmware */
 	wakeup_obj = kobject_create_and_add("scu_wakeup_source", firmware_kobj);
 	if (!wakeup_obj) {

-- 
2.37.1


