Return-Path: <linux-kernel+bounces-857169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9735FBE6130
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A521485FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719542494F8;
	Fri, 17 Oct 2025 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DfnTIx8F"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AD241691
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666235; cv=fail; b=LGP6tyPhqxpwEGjWGs1VpPh18V+5Lak0wHGYYCcMBFwVniXF1elFLpUCd7ilizqK0vXc+OjfbFgllnRsn0LEezlZgH5QI+xG8ELepgTsabGN1FTkbT+7rPANaoJy3elCyrb3nOoxjzAaDsbAZXZm1ymYTk2tNFJ3szgvvr9g1pY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666235; c=relaxed/simple;
	bh=EQ4ckRhWo4qnXQuIZhAwF5x/tSwo/5D0fcxRJMlnuhc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Q8JgRqgN5iCo10syPZAEcJphkv6mq2EY4g7pGwcyHzU+/J34sqhUoZiH6FiwCUKUA/N+omxeGLZOFgzLH1FptXQsWzwNeKbbV/oxsrGcLfkR5ElLvPWOx8uEvGPE9AdmyvlrIoSdR1+SIPVq6szfV6rU7Tm8EVnF+35MssLvgfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DfnTIx8F; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRwOS6EasEn7hPTBethJdHUBpPj8106d63H8TwiFPlb9zw7zHc63sNW5gI7NXifuCZ9FpRe3zNiNCVfT26deGidmw50hKFffYFbnm3lhfBz+1IByAhMLrEho03D8RHt5M09y4v9SfTMH75fyIwd4tgbT+9BX2Uxxl7MCXHW4emhAQ5ZL265aHLyJYCQ9oOnYDFbbQNftqVaY3JUcNLwJJ2XvYIqaGG70uZX7DsR8nJC2F/N/kuN5opraZdUrXWWhYcBSZLWx7cPpQ/wQo7inBQsNi2Vms7JWwCgdIoNURA8wlOAoEr7s5oJoDj6woAMoJpBoLfetWePNAbACAVaANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpY1oimJSyFaHLP3z+ZZD2iFiu3ZBJMq+TqCEOKEbbk=;
 b=kZApt09HmIXq3OZ/kxziE1bbDE/zP0+f0t0v7Oz2vrqAg4LpI/lyYWXbX1o1d3YkmOSXfGKetASTnfti2XquBob4phouJH/FnCAkkljd+b242tMetC1R70Yb+1J08ycZw+bJnys2kilQFOuQJggWOKYze5DYhbRZAHfljQQqDLULJ0VbMvdrUk1tnatdxFFcz4yY9ZfKCaOkaA9SghWgqi28uWdrXVq7UXNrzNKlPlinrq1OodkxzNnpon2mqdj0CGUT2dHTnTHviazIZHSLxmwpg4MHnt5X9nsZRucIRqmpVunREtmetOZ8/4P4uaRhvUGeC1xY9riL6iOdESbOHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpY1oimJSyFaHLP3z+ZZD2iFiu3ZBJMq+TqCEOKEbbk=;
 b=DfnTIx8F1OzsCj+Czx2k/YEI9RpEH0msNBUbyWJ6JgSKmxG1cP9ef3pFKgZAlonKVJ/V5G08eE3t1d6c09WU10fHlx9MCvpO4zLhN9GexWX/zSifADizKIfCznZXlqHtg95JppF7Oko4tFSThgT7j5BX04/cHNPM2BUhassg0HukjjFRiEvNasHGJjaUZBt4kqE/yX9fPzTS/9yVUyQ+/9bSOy8vtKxX+BvzesMr+uGPAz3ULW6yWV8owDbG9l7UWIdnj+EHt69Jk1xaK60XDuyOlDJQ5MOAsGSBLY7o08wqTC4FD/dTt7r0qNPekm6N399IrZPhliT5i8cbOAKNSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7125.eurprd04.prod.outlook.com (2603:10a6:20b:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Fri, 17 Oct
 2025 01:57:10 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 01:57:10 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Fri, 17 Oct 2025 09:56:30 +0800
Subject: [PATCH v2 7/8] firmware: imx: scu: Suppress bind attrs
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-imx-firmware-v2-7-b58f68ec2ea9@nxp.com>
References: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
In-Reply-To: <20251017-imx-firmware-v2-0-b58f68ec2ea9@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760666195; l=779;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=EQ4ckRhWo4qnXQuIZhAwF5x/tSwo/5D0fcxRJMlnuhc=;
 b=LYhm2pj5274Y5ACQOUHTJT62cM/UivYRE8iJfP2XAf2dGso8npRho+zG9vI7dlzgyV55nGnMT
 zBBba6MKaI0AuMYrLeh4ru+Jz0T46Da+2rogbasT/+LPXq4OamOHqpK
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI1PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c9d626e-efff-4f80-7667-08de0d207b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXdhZEI5UnZwMGpOTzZ6ekpFR1V4ajNlcGFyaTJjU0p2SXZDYXlyWENjc0w5?=
 =?utf-8?B?bjczSlYxZlk3Umg3VEtHMkZIYTRHZ2Q3UnUxcW1CMVZwbjdkb0ZiQzYzYkNJ?=
 =?utf-8?B?WEFwNHFJNGNUSXNjY2dGb2hGbEJRY3czMitiRnpEMStkbFlFRnVKL05wdEJx?=
 =?utf-8?B?QzREYWJYbGQrRlFYcDdnR1lYSDF4T0ViVEdQUEErTHNqUTh3dEVET1ArSmFG?=
 =?utf-8?B?UURIYVZCSnZ3UmtjeUs0ZGNaM0ZDWHcyTU50TkdKaHhYaWZPQzV0NEdBRWZ1?=
 =?utf-8?B?ZHp5d0huWGNqaEdGU3RTRTFtc2haNENtNmhzSEJuSkV6clpZdjh2Y29EdGoy?=
 =?utf-8?B?b05DMmFySTlWZUpwMDNWdkM0K1VyendSeG9ZR0ZFNmdNdklaZjdMWUxCamVF?=
 =?utf-8?B?ZncySm5XZlljYjJuM1l2L3JhOVZycE5xaTNQUmR6K3VieDMvU3NUcnFJTjkx?=
 =?utf-8?B?MHN6UjU3NG93OFlDYjYzczlrTHM2RFlYU1MvZitIb2l3NFJ5MTBVdGhWYUNQ?=
 =?utf-8?B?eVVCSy9lejJHV052TnNITDlrVGZVVHA5c2U5UElOaXZ1eWFScWxtVFd0ZHMr?=
 =?utf-8?B?YWZBekdpeUM2Q09Ea1U1S2RBaGw0Vkt1ZzAydWZ0eElJYlJVaFhkVm96emVX?=
 =?utf-8?B?cTVYYXBQQ3hjaFpwZWNEUmdmeXE1L3ROOTlzZmROWktIeFJmcWZZMkxzcHpY?=
 =?utf-8?B?QUVJZGRQSndTaWpjOEo0VVRQNHd6bHBqYkwzM0MvMmFObXIyQVgwK1RtNWFt?=
 =?utf-8?B?bUZxbTRaQUxjczFERG95bTJ1OTB0Sng4L0VMWktqVlJWSjZpL0xqRnV0Nmx6?=
 =?utf-8?B?ZUMvc2ZDd0s5ZXI3R1ZvNXExMDRvTW9uME9YL0tlcXlpd21IbkpBUFdPVFJS?=
 =?utf-8?B?R0hoSFdYVVJMWHc0a3pwSXpmU3pqL2pDZ25YVStTQjVMK2ZXRHZYSVdNbGZj?=
 =?utf-8?B?dDRBdGIwSGpodGNRS0xXRzZtMFgvUWIrQzRGbnhrMkI3WkNmM2R4ZEcwb0hZ?=
 =?utf-8?B?QzZJVmpJVEtXdGNHTE5Ea2ZRODBEOUswSWROd29wdTVEakxacWU0M3JvWmJW?=
 =?utf-8?B?VWJ4K0x2dHZRWkZMU3I3Q3piendFdExUTTVQRmdaQzlFazlNRGxQS3YzZjNU?=
 =?utf-8?B?anhvMFpsQTd6VDc1dzQ0Y2ZXMUI1QnFCb2lZWmtMamp2bmhUQXUyZHAxbnBn?=
 =?utf-8?B?L0tOanlzLzZZY2tOU08xbWw0dUY2bWVtaG84YmMxeTZWUis2SU1yVjlUbmI5?=
 =?utf-8?B?SkJyTjhRRXRnS1lBUHkrdHpUYXFyWVJuUTF3eWs4MlRzSWc5VXJjazM1WU5F?=
 =?utf-8?B?eER6WDhmRWFmSUpHMW1OYmZxd1RpVWVCemtmbzNmVWJwSGQ0WVphOWdqZ3c0?=
 =?utf-8?B?L0w0KzJVUVQxWWxBRGZaQnAxUDgvMmpYY0htTlVSK2VKb2NQSUQvU3lER0Nl?=
 =?utf-8?B?S1NlT1p1ejNJdkxNWGNOMm1LRi9QUjF2am9zMnZDaGl2ZnpRcjdPOUtPdEVh?=
 =?utf-8?B?THVWUTBMcU85MWhOOThWTUVwZkNWU2crTVQ5ZlBDNFVsYVRoQWphSmNQQzIw?=
 =?utf-8?B?dklBVWRZc2xYb3dWUWxndE83WXV3Qi9Ya3NFWXdXbnhwcG0xajdlbWpFWVFU?=
 =?utf-8?B?UjNzaStZWEQxR3RZWkZWc1N1U1VGVGQ3ZWVKc0RMS01KOFJPYTlMYlArWlA0?=
 =?utf-8?B?dTNvSkxSeWwzTzlRd3ViRU9SM3d1MXhRODVIVFp5WE5WdTRWOVcwWk1ndll4?=
 =?utf-8?B?MGR6SE80cjJaS2hyejJiMEUwcjdkcllUekxVcEkwdEUwYzFkZWN6ME5Da1R5?=
 =?utf-8?B?RDFCbmNwWTlnZEFTbStIOTFaeWlCaGIwMit2RlVpcUt6bFROUEdpQzlXbi9z?=
 =?utf-8?B?TW0reXg4aXVnYU1xa0F3QUFsdENHMkpKdVptY09Cd0lrUERuVnpXeW41K2Zl?=
 =?utf-8?B?NnRLMUc4SHBJcUd4N0ZnekRaeHBHdlZOaXdLeDNzbzNxeng4TjkxTEFXR3Ri?=
 =?utf-8?B?SU1JMmpxeHN0QnE0eXJDNHgrMXhQb0VzM3JraTFsOEx5ckh0aUlPdnZ6Mkph?=
 =?utf-8?Q?wmwSAh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHQwdFJ3bWhqQVU4QTdUSDdTaitSTmVUci9CTDgxYzk2WXJnaGp6TUpLWjNr?=
 =?utf-8?B?Mi9GaHJVL0JTVXlSbWxhTzY0Z1FoVGlpTGI3MlZ3ZkFZRDVLazZZR1BnVVBU?=
 =?utf-8?B?aGtsQzhaY3BLajNxUnY4TVgraWk3QVozK2Z5NGZEeHk1T2NOOSs5aGZ4VTht?=
 =?utf-8?B?WFpFazBnQWRkRjBiTnlRRjZsTlVueGlIVEg1N2NPckpnelltODJyNlNkMGtk?=
 =?utf-8?B?Vk02cnMxOU5hL0lFNEpzWjRWUE5OY1NuUUVMVVcvUEFsalJMWVhpeVdmZjZC?=
 =?utf-8?B?UnlLU3QydnNGa1ZUOTdGWDZod2FMcThJbXZ0SVJjeHF5T3UzMGhDUjFmRGhj?=
 =?utf-8?B?cnFMZHp2RmFKcGcvZUtvS1ZVZHcxbGlDUDdKelR4S256ekx5a2ppRjV0QWxx?=
 =?utf-8?B?L3dHU2xxU25PT3V6Y3FrV0dSTDZ1L1dESEFsMzBaZk1lRkZCU016eG1lNm1X?=
 =?utf-8?B?bFArTGordHBIY0hKTUxvamJqVEpZUkFRVHpDc1k1S09acjdtZDZsMkJZMHVN?=
 =?utf-8?B?aGw1WUQ1UnNFVmhyWk1WVXM3bk5xUzZKUHZlQSszVW9ZT2FzVlpZeldFTnZX?=
 =?utf-8?B?Yk1SMk9kaEhrek90M2ZYREgxakJVNlFIME5UMDVLVXJqZnVVOTdERGtNT1Ez?=
 =?utf-8?B?cWd1aUQwTzljTm1teXBzZDN2dUpGRzdMMVUxQUdpNTZIbzZqdU1UVFgxemIx?=
 =?utf-8?B?amMxTkJ5UnJMN2N5SStlUFJESGxZckt0WUExbFFYNGFTTmYzNzF6bXQ0Y213?=
 =?utf-8?B?WjE2WTFTanNGR1VXeUJhQ2YrZ05keEZCV0V0OE1sSit2Q1k4cU0xYm56L3ha?=
 =?utf-8?B?R0FEcGZOdVN2REJMZzZiZjBpVnB4NkJ0dzBicGpMYnN0SWZGRWJGMGRrWlBn?=
 =?utf-8?B?cXBPZ1FHdmxwNHhYRk5FZWhhNVR1d3RUcXRweWZPYWc0V2RwZS9LRCtNZHkw?=
 =?utf-8?B?bXlISnFlVVlqaWtqdUltRXpEY3AvTU9naHN2NDFFY1RaMUluWlNGVUdpckxW?=
 =?utf-8?B?aURSV3NJWU9LWGQwSlBDTkowZkhuRTdjck1ZV2ZvK2FUMisrMFc0cFVMQ2pj?=
 =?utf-8?B?cHFlc0V0ZzJmbHhzQ01YVUFZa08ySlZvbUFnTjVSb0pCa1I4QktYRlJTS0hY?=
 =?utf-8?B?YXA3dzJQUksxUDlDQlFDckJVZE5MeTVrVXp0ZFoxQkIxWkd0dnBMaGoxQ0hJ?=
 =?utf-8?B?Z0JrK2xOTmdja25xSmhuSDBkSUowMkNIZHdFRTNmY2tKWkFiQm9wMVkzL2xZ?=
 =?utf-8?B?KzczL2JYVWZkZXlubTFrY2hDK1VySU1HUHZMRjM0M3NKWkVzOFFmNHpReDJp?=
 =?utf-8?B?SE5LN1RNYng1OVVJbDNyU0Vvb3FreWhQY1UzMWxRWnNoaWd4QWRGb2hUckdk?=
 =?utf-8?B?VWdXMjFaTlZ5NDQwMnJ3TDFuVHRxSVhqZGJkdDNpTFNnUXJONHNMLzFZYjhT?=
 =?utf-8?B?c0hOR3ZUY0ROaXF0ajdIYTE3VUxPUmhqNlJ0MEYwK3FQWnJidk9Vc0dvUTBJ?=
 =?utf-8?B?cU44T25jenpHOEdQQXdvRUxBY2NPc0pyVmNWdGt1a0d2SGxmdW9lRTN6OWFx?=
 =?utf-8?B?RCtZSmVscFByNjEzT1VCMTVENmhZK2xuanowTEs2dmZMRFVhZHVpNExyUWxT?=
 =?utf-8?B?eGNPZDNIOWtuNU96Y1B5bE1jYyt6UTZjL1l4ekFoM2ZKSG9TaVdUK1U4Zmpl?=
 =?utf-8?B?ZXNJdStYbXpIZCtRUWsyVS9TRmx6VTdENUREL05JU3liQkNzbG0vNzJlMUdK?=
 =?utf-8?B?UGxZL3FPRmRlSWR2cjdaYzlUc05PR3RUeEJ4MkFZeXFmWXRNRGlqVTFDL2pN?=
 =?utf-8?B?L280TUN4eEVHVUpoY2R0OVEzSE9JTWwvb0RFaXBDM1dlV05GRDh6bHVvVzc4?=
 =?utf-8?B?UkM2K1NjUWsvS1hLZGRrNWZUY3QwQkpLOFMzM3lMbEhxUWF3ZGdnL2ZNNHNR?=
 =?utf-8?B?d1lVWmVFc00wMEQ0QXZuUFh2cEQyQTYzZWI4ZlN0TEhHVldMU1Z5UUtneER2?=
 =?utf-8?B?eU1NT1VXL0lLbW13QTdmQXRXU1NOTVpTQjFaU3g0VVY0U0tQVnZUODVPU2ty?=
 =?utf-8?B?SFFRb0JSVTR1bmFXRXFtdWFBUUYyWDBxWElZb3MyQnhtTng5U0toVDhxRHdQ?=
 =?utf-8?Q?Th4ucnGwctiqRxHyShTUHnbXv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c9d626e-efff-4f80-7667-08de0d207b9e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 01:57:10.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: im6d0g2j0uMz0ruHBn+DBhlMbo8BhnPzFnlR6u1Eg5BnsCZtTPQb0fHdI/7+tp/k0eyCsxVa/n19pXtdG0gg8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7125

The SCU driver is critical for system working properly, it should
never be removed and binded again. So suppress the bind attrs

Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


