Return-Path: <linux-kernel+bounces-851808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F63BD7550
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 06:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49E942374D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179030CDB5;
	Tue, 14 Oct 2025 04:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PQ8iSmzM"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011048.outbound.protection.outlook.com [52.101.65.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6528D30DD15
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760417707; cv=fail; b=hhg+61NgDwc3flt6tOimO1ZiBmCbHEUs8WpIQnd7MSVUU1rhnZ2UVhFWTIz07B2KQuzx+EIdMoL88PNUFuHnVP4gimLXQBiBWZAqFgWP+EkNURnyEGIHzp5afTcUgFkWU+/MitqFQlbm9E64o3WfjL1OlzyFy0bpG4ENswT9H3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760417707; c=relaxed/simple;
	bh=ehHvgSKQUwWYmewa/fky7V3E3br7uJ896w7lOLCS9A8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ADWv5My3woRB6NT4d4oW13YjY3f5/4mYPYxoflaKny7hbTk+hheN5uhhgrkt8jfT/VCJdtX2pHX5ewqGrDzV1z2Y6waKl1yfyQgKDmGOpiWbnf/KbdpAmlBDEdyfsZVgojNNwteV8ej9dquL0Q0wZ77aYr82LR+O1RQpnla7aRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PQ8iSmzM; arc=fail smtp.client-ip=52.101.65.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckjqOsATIBgBe4ZcMYEZufLMMCyjeCUnobuF9TV8lhAmZzdJGJwG7fOAbl/mDVPbsOpUTOsadxfCQh2r9I+Z5ATSY5DJcO/fJUKxD6b5t0Ogyx6QXCfscRwHunHLQWlEa1HS9RCBdT5a3VFB2JBPe8vJ6AAgD4GwqYJrTNS2vor+e09dVkuyUgprFRkTpvkshOiBFnn6A0CrfN5wpyXX9zbidVvWKzaN2SOQat+AUq3taR80aS9d3/zcawfLQqkalDHjQz80uqiFRS3aDrqgpPF4GoRG0fF4HCFky9oxgbncz22fS3UYOtLxLlaF0s3vyMQeQPFWo61FIhMtwUSdaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CpObEYgkodWwaLvOuFlLiOxwYKqKH1qh236szS+dlzc=;
 b=dVjU7QhrgNJF1tGvtAZUmSmI57y83DqjCYWDc1uUdSv3X18Pr4R894wMLj8alRsjoPz3h6UUdLcD95/z7w3mQRTRTyGrWuShl7QaTv3y5b3mR7c5KCECjs4S8WYdqhw3q8+66ahSMyHMRzEh+Y75y33gudK3CZLeY1Ir6jX64IWaZLeS6P7cbawNhqHPV9MJyD8Y113GVLi/rUaSbzTgCEyt10DNFgBGGD8z8sMdNG5oR7BwzLH2tkJpQXiczhaMQk0cQA+3pXlDj0VNzbrs9kaML+d22iAksZlrcqbVM/Xg99TjM0v9v21J7tYsVLaSn/OFcmfOwPDqNl8aPebWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CpObEYgkodWwaLvOuFlLiOxwYKqKH1qh236szS+dlzc=;
 b=PQ8iSmzMq/dt4hzcc/80EiHmvEggKr3JPt/8CbKLa3Rf9qQVDQ2P0rnHpJl2Yn7AjBPUO0HVGh+Bnx2h8HE7ncfItpPQPhSmN3b4GFaK7Vxob2SacbOuyyoL6EYKEj4hZ7whOBKsVZlNEVeazKgTbjgeSOPROqyK+9kRu4iR4oyAHiSI1VyIa7fotDHCEso8R0fgVgzQ6ygfd4q5Dce6AUzjsBEtiADAJstKLaY1ssg3luVomLe+z9Ck0wc3lm5yFDRxJQzCrnfAUBgi12rBoYJTwQkBEAEk+ULUuabV+o4+QgIfuKQwVJJz1ofTc09KbWd0PwmhE9DGu3j0lEvnJQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9838.eurprd04.prod.outlook.com (2603:10a6:102:380::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 04:55:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 04:55:02 +0000
From: Peng Fan <peng.fan@nxp.com>
Date: Tue, 14 Oct 2025 12:54:39 +0800
Subject: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on failure
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
In-Reply-To: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
 Dong Aisheng <aisheng.dong@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760417688; l=687;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=ehHvgSKQUwWYmewa/fky7V3E3br7uJ896w7lOLCS9A8=;
 b=3S6jMFjWbT6xadOmiAFlXpw8/P4Z/lNXpertp8X4kx8iOMsNmHKWKwo530+ZcPlGsyDNlC9Op
 pRL3bQYpmrwB6WOMVtmWzjwpZV+2JaoRvOzX86mRyk+Ehwek1Cw+xH/
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
X-MS-Office365-Filtering-Correlation-Id: 1841de6f-4d9c-4868-8227-08de0addd56e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzFRTGpHclBzS1E3WE5Tc0V0ZC9ubXFlUFJJVVNRbGVYQVVXdnlHK3hsSllW?=
 =?utf-8?B?SmxEYlc5Uis4S3oyVFhaNjBqRE9ISDVXaVFGQ1EwMjVGZzdKbklOdllmTXBm?=
 =?utf-8?B?emppM3hjRWdYZjJrRi9VL0MwSHNKK1RYTDkwMjNzSjh6aS9iQ1lpUEtuZEx6?=
 =?utf-8?B?UXV5Z1NIaStrNUd3YkJtb0hFWkpNbllUakczdy9qU1RvRVB5S2gvYThVR3BV?=
 =?utf-8?B?UlpaVG5wa3gvc3RucnVGU0RCcC9WUHdXVEdOTnE1TVd3bVlYQk9xSUZMM1RS?=
 =?utf-8?B?R0l6V0JkTUFYcGZPRzdQWTlnaUtUU09NU3VmalF0Slkvbm9yeEtTaHRiNzhi?=
 =?utf-8?B?UnNzeVZkNUJ1aThtT0ppYkltR204Tlg4N2MwOURhUE5PRjR1em1FNnVaN1Fy?=
 =?utf-8?B?YW55U3VOQ1drcWlhYmxHTzRkVW5DQU96VkNvTkJQMU9Ca1Ntcjh2NFpLVTBr?=
 =?utf-8?B?UkIwbFMvQ0NBSEVoUnc2OU5xRFJVaDUwamRFQ0ZSb2Y2NzE2dlQ4aWZJNE1Z?=
 =?utf-8?B?VlpDWXlKRHJCUnA4MGdRcDNrb1VDYU80ZXpyR291VHEvNVA5dmNnU2daZ0tr?=
 =?utf-8?B?TVY2SXVKMVNmRHV6ekRiWFlSczBKMTJCbnNCL0RQY1c0Z2NLTW1sem1lK0Rw?=
 =?utf-8?B?aDVJcWphVnRqeG5yZU5tRVFQWG84WHFkbGdHWnhxSmtjeC9aMVZBRjczZ0Mz?=
 =?utf-8?B?KzVjK1IxOEhtTWFXb1NSMnJDQmQxUVc2Z2ZxajJ6OFhRZGo2NkVZYWI3K21w?=
 =?utf-8?B?aXh2SWVVNHZGRmEyQk0xMHZ0M1VhVzdXcjgzSW56ajY5ZUIwU0F0R1R5c2Fh?=
 =?utf-8?B?NFZ5Y0kzN1pIYTRreVRrQVU5N28yYUVqangwSWU0T1dIalI3K1lKSnB3QTk0?=
 =?utf-8?B?T3JpcTNMK2JZUmhEcTFPamZ1Kys4eGdENlJGY0J3YjhtdmFoU3ViNGY3ZUM4?=
 =?utf-8?B?UWV3TkhwZWVnb2huQXVoVUF1Qkk5Q1MzSFpubUJPblJtR3I2Qjl3R3BkbHRa?=
 =?utf-8?B?K1lDQU1mV1VuUVplS3ZvR3dGS3ZvaGxEWTVVRlpuRzd3aXM0U0xrVFl5VFJG?=
 =?utf-8?B?anM5c1R0Uno2TGFpR0x2UTYwWEpPaDUydUlVUFNjRUo5WDJ4V0FuOTJEdTBt?=
 =?utf-8?B?VGg4L1IrUXlxZkliU29sMEZqNjF1cXl5Z2dHTmYwaUJ4M01qS0UzNGF1MzNo?=
 =?utf-8?B?M3hQOUZ4YXhnWGhyMkpubWs3NEw2amYrOHVBaXN0TU84Q1U0Y0ZTZ0IxcUkw?=
 =?utf-8?B?RWxFTWI2bHg5NmpRZ2tLYkd1UlM4RWJkeVdneTdLYzhVb0NVRkY3VzQ5ZDRW?=
 =?utf-8?B?VGxWdnhvT3pCSnhKWldIMlFrYlFVMGg1Skg4TmdDemsxczAxRDE2MlJVNWhl?=
 =?utf-8?B?RVQzWGZLUDFvazlGQTFVZWxZNEZvN1NSMG8zMTREUG1PUEdiYVdtV3liQ3Ju?=
 =?utf-8?B?Q1QyTmVYVFdXUjY2YlJBL3BNN1RqYlEvbk5mVmIyZ2QwTm1hWHJlcHBWaVBh?=
 =?utf-8?B?TkNteTZmY2dJNG9xMDk5YXBCaG1jK21GYTNqVjRIYS9HV1ZDOXJIclFielZB?=
 =?utf-8?B?T0Q5VE50VXR0SkN5SktUeTJ5eXM5VHBnR2FRdWZ4UlBoWWticEt6UmhDQkxv?=
 =?utf-8?B?ZnlSUm5wYnl6QnJtQ2EyY1FDbVVPQnFBa1dMb1JXY3o5SjQ2b3JmOTVMcisx?=
 =?utf-8?B?Ti84ckpxUHRLdHVYQ0s3emkvL1RHakh2SHRreVJvTWxwbGRNQVdrODBZNzBj?=
 =?utf-8?B?ZWdTa0xQUlQ0bVJRZHVDcXQxMmQxZmhIZks3VnhkbXJRZ1owcWduY2pkblE5?=
 =?utf-8?B?byswN24vTFJ3RUJNcFFtSnd4eWhGQ1J5T2M0UlZTMmhJT0xQVW56YTE2d0Rt?=
 =?utf-8?B?aGFLTDB3SUxYblh3QjBIU1hDSlEyUkRiNEZNWUR3QmZPOXlMaWRCSlVRSVN6?=
 =?utf-8?B?LzQxcnpjRDFvS1dXTWR2Wm1jY3dYOXNUbjVrakxxeXJSZmRxWjZMV3JVejhC?=
 =?utf-8?B?Q05IYytET2N3Uk9qckJqWU9HYlJWM1ZLNXkxaHFvQUlzNzZybndmMzg0TW9h?=
 =?utf-8?Q?NXRsUI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WitBWVlWSHlPMk9oWFBsdWVrTXh6UU1UOGFPQlo1d2QrSG1WeUExZU5EbVFm?=
 =?utf-8?B?K1EwaXFkeXpxeG5EKzNQUElPaVB0TEgyVzRLM1REQ3V0VE1hMzVxNlk1ZG9t?=
 =?utf-8?B?clEyeGpxTUhlVlRqd3Jsdlo2K2RDeENqOGpmTWlUdFVrcHJqVXJsK1JjaU15?=
 =?utf-8?B?Q2dSYzZVMmp5QXBHN1JEU0J6RUcxSTJ5Z0JhSVJxSGpPMHZGSElKK2R3RU11?=
 =?utf-8?B?eHZPYlZiL0Z3QThWQmtFRE1tazJGT3dlZXZGMmpwL0E3YXpCVmJZUGNjbHBl?=
 =?utf-8?B?bFZObVd5OGNpTzIxdHNoSDMvNGMzcDIzbHJ1UnplU0VGRks0R0h4NXJzekhw?=
 =?utf-8?B?Rjc0bFZkUmhWUmR6QUtZYWNham9vanFSaDNQejVQQzF2enFhNDM2c3hFMGJw?=
 =?utf-8?B?eUl2Y1FzUVNzV24xUHlDSHNUUmFWNFVjM1RETjc5YkdHbE5nUDRUNjFMWmZE?=
 =?utf-8?B?TlNKZHo3MWdJVWhVclliNElycUVEUzlPVUFyMyt1dHVlWlg5encxcEYzeUM4?=
 =?utf-8?B?cjIyeExSa1J0aEtvcytzWkFaRHIvaWFhMzRJOVFHVTNnVTZuWkNlYWpOSlZv?=
 =?utf-8?B?NjVueExJcENhYVdGdlA2UlVqUWtrRkNpcU9hMUhKK3lOOHhYU1hEclQ0cUhF?=
 =?utf-8?B?VmxzRWgzbnFXclc5YWlTVlpaTWhMdHhxRlhiUVQ3Z3lIR2ZRdy9BdnNWbzZx?=
 =?utf-8?B?bUFoQnpkbHRZa1o1OVJKVWZTOG1KSVN5T2hKanVicmx2cHdFa1h3OUoyZzZZ?=
 =?utf-8?B?SWpENnFkZkQ5R3BNZ0dVVTR5VTc0Wk5SQkx4cWVGbUJaY2sxWVl3SytzYktr?=
 =?utf-8?B?YjI0NVM0NU5PbmdsY293KzVyekhPdGw3MjM5cTZORlVBckYvSjRRbWhlOEdG?=
 =?utf-8?B?SlQwNzF2MStGT081WEg1RU5hMzJxUUhsRnUwYkdScjFVdEZWQjI3OWt0b0tP?=
 =?utf-8?B?S2IwemE1YjRuS3RiTC8rb1F5K0FtbjVHNGpQbXBiclBRUDNnQ3lVWGxYSHZH?=
 =?utf-8?B?eVVhNXhRTTBrb3lPVjFlMEtJazRZQjFxSzdnMWUxbGJFTFNWT0xpVXlydkRa?=
 =?utf-8?B?aDZ0aWhDYXFyK2lIMUNGRHBMQzBuamYxU0k4TGFqR3JkUUswbkg2MU5hcGNR?=
 =?utf-8?B?UWNRVGpybHJuOSt6YlV5UkJZUEdrVE9Zemo5NXdUQTByL0VUM2ZsL1l2bXY0?=
 =?utf-8?B?L1plcWt0dGJFcGVnMEdxcEEyaDhxMExybkJzU2NXanRGMFgxN0l5R3kvVHpP?=
 =?utf-8?B?WVNpbzdYMGJSRmhRNFBTaHd2c3hvNmtNTmdCR1hMazlzYkxSSFVQeTk4bUNr?=
 =?utf-8?B?NG52SVlhSWRDSFdoTEZLbmgzTERLRDZNNWFqMG5HTHloaUtZb0kwN2hMWUN1?=
 =?utf-8?B?NEpTYXF2RG9aZXErZDZxL25oUFVmMXBwWEpKMHlyck5JbTQ0U0hHZXoyTWFK?=
 =?utf-8?B?ZUZWb3FQaWlZV0dFTzhDbC84NFB5WnZUVlZhWVZ2OTZHWWRpcE5ub0JFeFMw?=
 =?utf-8?B?WTdDRkY0MW5HN1hBUUw0bGpxNEJqODZZVWdZeVNLcy9ldjJTUHJVd1JmNlMz?=
 =?utf-8?B?UEpxOUhRT3FvWWR1WDR5MnpRVU44RGJ5TFQzMFRYOExIM21HYS8zUTZZeS9V?=
 =?utf-8?B?Z0FCMWdTNkpaaFlWQWdaWlpLSE9NOGxLcHV1WjZSK3FjWmRKcWdvSkx3cHZX?=
 =?utf-8?B?eUdKcnRwbzU1RTJ2Q2t2Q00yM1gvdU41UFBHYW5qL1BOUFdtNHh4U0ZjUVRo?=
 =?utf-8?B?dEZqUWlTUUQzVzF1OXhRcXRwQlpvaDNsN1IydDNJUmdTQmdQTHk0c1d2Z1Zk?=
 =?utf-8?B?dFNES2VlZTJIMmx2a3F2OTFFOXR6aDNVejNlUlV1eXN0RGpQc0tUYkZCa0xr?=
 =?utf-8?B?bWI4WFR4dFdSd3BTWHZmVUVIUlhURjZiV0dlU0xwQ21TWm84Q1JFZm9NcCtV?=
 =?utf-8?B?WHhkZis5UmZhSG44bFhCSVVDY1poQmdQczk4WlY0d0JTN01CUXNoOXBoTkFK?=
 =?utf-8?B?L0RERjB2TUxVWERyc2RuRXV3TTJZSGhmUS9teWpSdFkvNmxwUmR5VTRKSW1q?=
 =?utf-8?B?NkluakhiYWpDVUJqZWFEaUxqOWYzZU45dzJMT2VzWkFuQ280NlFwVm9xTk1U?=
 =?utf-8?Q?wR9eZSrhac/DsIjpkffROC0eu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1841de6f-4d9c-4868-8227-08de0addd56e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 04:55:02.2098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t1b6VKckHorebE2pdQQ5+bPxsFP7TIGICPsxD5AXdzjrWd2jvXHuzToWDHAkC7wHID8svMfKKA54XO2NbpZ1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9838

With mailbox channel freed, it is pointless to keep mailbox client.
So free the mailbox client in err path.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
--- a/drivers/firmware/imx/imx-scu-irq.c
+++ b/drivers/firmware/imx/imx-scu-irq.c
@@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
 
 free_ch:
 	mbox_free_channel(ch);
+	devm_kfree(dev, cl);
 
 	return ret;
 }

-- 
2.37.1


