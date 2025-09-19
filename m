Return-Path: <linux-kernel+bounces-823915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C348EB87B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 04:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761B7625584
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1CB246789;
	Fri, 19 Sep 2025 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V7rexA2E"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9020B1E1A05;
	Fri, 19 Sep 2025 02:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248888; cv=fail; b=oGt57Ok6Y41zIrGQ7X8njU6dCppqNr18efdZwqu6ojQ8FH2d9gFwl8RQNIgixGGU7CHZcvXdI0qNLMDmf8qGwhJV+lmBhocsPxjhH5iSNb23dUzfGgY+pdN+Jq+NNBpsQjDLojjBowPw/pyrJqzKqGlOk/4jenhr1WuFwPFZor8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248888; c=relaxed/simple;
	bh=ZYTX6LNGQpsmF0oIxH8HqahiwmbXqF8f/DC18v0uxQA=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=c10u+1pifdEUuQP45Y4bZIQrWgrySfe8aEqa1op1VwQmm1KefgK6af6KwQ/ErClS5IqxfppoaRe9l1VECvFeTXxpX1TP07gvVULCVK3QuZxU8fDq9utzIiMI/vJlXwjVkHt5vJwm43D3kXvAk+ZKQm8sTqFXDmJ5JCSkBAkv5vM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V7rexA2E; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2WJa9hAXybUZcpC1pLvCv6Z6B/ZW2H173ZKHVvdWZUHPKedBXe65ZGMm97/zSLX38SQ1oPJmw1vKDPZd6bB+BnEfIpxzg1O6czQU3SKP+5Dhb6s9qDYGKj3/5U2GIDMSYUyE06EuYfDTNYYvgrdLfIvm2o9+9GmZgcgGT1GjrPbNgg9lcUBeT5fZsl6QUZgfmeSzwiVs4Prb2mbCko11ZocpkNK0Iw9xMZ28H/adHvt2xQyWXOL9dANhP0Cz6SC4Ui1fpj+WEC0J3BYMnt+5dh5eqGc+eQ3P0yToRWF0fh5IbTS2xAITvJcodWDuqV/bI8WUBT4VRlr1RU9lgZ3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtqrJJtL0k+bKA2WF+nBCU1Z8Vl8iX4/f1floG3+tNQ=;
 b=R/zL6aSw6GbmarIFa9OaMumtm/nIZpfRw6mhX9cH51s1ZkeLuIYcAmnaX3jIIYw+kwenLNbX0rt75Ei49TwF8BEeLkriQ08xOYMsOZqMoW1cMzUBoZ8k8GuXn/b5JMfBcBdMtwaUR2/HA1nzYdhAHHpH+JWiM6mt6C/CVBABDYm7iywIiqQEc38o/deyKeiPJazL6Heps2Q4P+iqwzS6v4189hcSjRj7BhW0Z8bcpY3DfGw5uruFJGT8qoQ6x8Y/ISnlhXxCbqtiX/XkZ/Pce0EgG8EhEeUk+RONStEX75rdMg/YRMECym8HtNbNNpMLVMI4zUqyziUGD6sOyjnLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtqrJJtL0k+bKA2WF+nBCU1Z8Vl8iX4/f1floG3+tNQ=;
 b=V7rexA2EiFWASQHWy7lrNASVUhZzRhjA5UgJBK7XzkCE5VvmHiaW6bVl5mXKPlVHrfCCISJdoYX9Emiy5DumdhOzlUJ+uHTzbv6bliHIFYXEjbf2+VFEF2eeHNsl1v4XKG248yCE/c6zjhTVQj7a9H3+dwvhMdlNGJ/F+XduLfIOon/HrtehIhp+ZdhJpmNCm3z+v94UwI8L3biLiorE+RKAJPdtSE/o0fr7ioh1ve1Ma0J/jkdNTtYoaf3J1FdwwIw5LWOi5lYF+SmEoC5ssYQVsCNC3iDsOMehBxSYFEG6Jn8+GpN2osTXM/I4h0GIYGgq6B2Q/PVFB6/WgymFYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by PAWPR04MB9743.eurprd04.prod.outlook.com (2603:10a6:102:384::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 02:28:03 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%7]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 02:28:03 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Fri, 19 Sep 2025 10:27:04 +0800
Subject: [PATCH] arm64: dts: imx95-15x15-evk: add fan-supply property for
 pwm-fan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-b4-imx95-fan-v1-1-c9127bd975e9@nxp.com>
X-B4-Tracking: v=1; b=H4sIAHe/zGgC/1XMQQ7CIBCF4as0sxbD1BLBlfcwXVAKdhaFBgzBN
 NxdbOLC5f+S9+2QbCSb4NbtEG2mRMG3wFMHZtH+aRnNraHnveAKJZsGRmtRgjntmdKXKxothXQ
 C2mWL1lE5uMfYeqH0CvF96Bm/6w9S/1BGhk2Tg7HOTVzPd1+2swkrjLXWD0YvsIWmAAAA
X-Change-ID: 20250918-b4-imx95-fan-9a371ca858f5
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|PAWPR04MB9743:EE_
X-MS-Office365-Filtering-Correlation-Id: f010ea80-8b1a-4372-1da8-08ddf72428a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3IyRHlnUnlkc2o2c3Vmaks5U2g1cnVLcmtocC9taDdVemcyY00rbmw4eEdL?=
 =?utf-8?B?amJUa1pING85ZzJkMkNaTDhqcTRvTVJScFlSOGxyOWZmSU9FQ0hiMmk4dEFv?=
 =?utf-8?B?OVppWlhtOFl2c3Y3WUwwTjJRR2lqT3liY3BZZGxDb2FkUDBEWmc2YlJqVFgw?=
 =?utf-8?B?dWpiNE5PRENmTk1TNVZzQzMvNXJoQUMwYlBKNFppUlJ5UFNMVlFCM1JkZXdW?=
 =?utf-8?B?clZLU3ozNCtoMTNGZXRLQVY2MWJUaytsQUwzVEk5a2R3dW5tNkNFajVZdWI3?=
 =?utf-8?B?MWxEcjlHWFlzdGM0SUhSMUhHajdCTmRBeHNISEdtWktBSkRKejdMQmI5RmZI?=
 =?utf-8?B?N21aWC9QeHpSemRlUEFRblBlYm9aaCtzME02OXYxSUZrZVVrMGRzUGhuZEhP?=
 =?utf-8?B?OC9uRWFxU2JNc29IV2hvSVV4THdscktWWXU0aUE2R3Q0UlpEVFoyd2JrVmRH?=
 =?utf-8?B?d0dhSnFDNWd6Y1YvczBFUnByd2F2Y0dUdXRvZ0hWSkpjZ012S0xwVGxJOWpT?=
 =?utf-8?B?cDdzdTYyY1pZcEdRZXNVcTFHb2s0aFlTR1liU2w0Qy91STlleE10TXF1eEhK?=
 =?utf-8?B?TjNsYnl3TWltazBwSnpXN1dYTUdCMDQzSWVwbVdXTE0xRU5DL2RIN0VQc3lm?=
 =?utf-8?B?eGpRMWkwQmZqdkUwdEhNMHRlSnA2bmR5VGZNTlJNTzF6d2lkcWdYNHdFckNF?=
 =?utf-8?B?RXF5QXBsNFIyMEc4elFFbi8zTEt6WlRPTys2TC9kTnFKSmNJSjZDeTJuc3J5?=
 =?utf-8?B?bzNjYTZOV1NScE1GeTNGU21RTUQvWHh0eGV5cXNCNWxDcUZzblF3Q29vNkM1?=
 =?utf-8?B?RFVtTTRLSlNMNkxUZGZBMG9GYXcwVmlzcHVIVFdkTnJXODY5d1llSG1QMSs4?=
 =?utf-8?B?TUdZTVIrSXlwKzlmYThWNDBmVUJBMHBNakFIWndZSUNEUFlZUGxQVFNOOW9k?=
 =?utf-8?B?eW1JOTFCaXNwL2dBZU9jb1VJWEprajFuSFY5ZmRPUmJiRnlsL3NQeWJCL2J6?=
 =?utf-8?B?ZlZPQkR4NnBzdmJrWnhGNkJGSkRsRE5FbzBzWEZ4T3NnS3NmM1V2NEpuYk9R?=
 =?utf-8?B?TlF4MTRBSjVmRU5PZExGRElBQXhFM0d2QVIzMzhSNldWQUZGMi9aUGRPM285?=
 =?utf-8?B?RU12U0Y1a2wwL2RtYWlKUjFnemFuV0w3R01zT2QrN29kQlFpaGdJeXpGOWly?=
 =?utf-8?B?MHlTMG5zZTZMRCsxajY1SUlsK29ZU2lYNkNiRy9qb0tYYXZ5OUxVWFFraVhR?=
 =?utf-8?B?emJudVhJZ0ZmdFA1dTIzTDJ2Q2J3aU1FeUc0bGJKSFFZWU9pSEkrM0o0SERs?=
 =?utf-8?B?S1ZvaGpXMHNMSHE2VU5sRFJrK1pxd3UwU0hpZzlGODFVekkzZmlta3JUbEtE?=
 =?utf-8?B?SklwcVJoWExDRitJWmQ4dmlNUjZqK2MvVDNuU05vNjNoMmJENW40QVFBam5M?=
 =?utf-8?B?Szc3SndPaDZGSHEvRDFQblhRYklMLzRhTVZWdnlFb05DVEU2K1hHSnMzbysz?=
 =?utf-8?B?MnY0L2NHczNzRHg1ellENUxKM0FsRVd0VjN0K1gzaHA0blJ4SmNvRE9OWS9H?=
 =?utf-8?B?bmc3T2NnOXZXSkM2U2hBajlQVTNNNXJTcnJ5MDY0ZzFGWUQxWmg0aEFDcytB?=
 =?utf-8?B?b2wwMXdjUFAxNWxYUzdsQ1gwYkd6RVBnZnlWSjdPMUVRNFBhRG5LZGZsUi8v?=
 =?utf-8?B?VWNVbWpsNjczRkhuRmpNVHV3c05uWnAyWTd4VXFzVGhRekZ6YzFqais2bTdD?=
 =?utf-8?B?ZmIrdFZJbGwvMFA2QkpJYnQzaEVCSitZYUFZV1QzdlBGc21zTFZiaWV4dmtX?=
 =?utf-8?B?OGUwcXhXUTRkRHBhM3RZVHpjTFZGQ3grVWNxU3R3Mnd3OElhSG12UmRmUEQ5?=
 =?utf-8?B?ZFcyV1Q2U3RraEZqUmpWaVRqd3lIdzljZlFOQVBnSjZBNHVvYzNDcHdwb1hr?=
 =?utf-8?B?TE9MNWRRQzZXbzY4WHB2a09QK05na0dXcjk0eElXSXNNU2FpdkVpTkwrVW40?=
 =?utf-8?B?TkJtV1BJSHlnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NndEV3hFbmowb2JFR1RCQzVvSzJ2RW1mYm02YUFpckErY1c5YlpvSWRlUXcr?=
 =?utf-8?B?ZzBkc00zeStJTUlBNU1ob1V5Myt0eVBvaHdvbEVYUzBlNmxjU1VOOFIxQ3hH?=
 =?utf-8?B?emNUT2gvTlU4bHdhUkQ1dHV5MGY1dFp5b2RBOEFhY0pwenYrQ0kybGZVT1Ix?=
 =?utf-8?B?N0Z4VU5zRVpxczFiM2t2Ni9DUkNnaCtGY2pJSkZUakViUHo0Tkg0dE1NaDc1?=
 =?utf-8?B?M2EzMDdMUW1MRjlpMEIyS0lrM0ZEUDd3UTdwM3l6bVVFZnJoMlA0bjUxRTdv?=
 =?utf-8?B?K0N2eTNrTWNoYnBIcHFUbEl4aXlWa2MxbFZUQms3b25hQ3doVnQ0MVVGanJY?=
 =?utf-8?B?VnZoSVBhMWtNSXVkdmFEc0MwZGZ6dFBGZWdMU201VXU3dXBYWk1pbW50SHZk?=
 =?utf-8?B?NFNzUTFsYmZEZktpMjdYK2Z5b2Q3UDdpcm83QU52VjZjWmkvTWxrekIvMUcr?=
 =?utf-8?B?Uld5N2c1ODBTNGR5UFd0SGdMa0ZxSy9UY1IvU3p1ZGRuSG93cXFmTnR3cjd6?=
 =?utf-8?B?c1VlazBJOC9PNVI0b3p2am8vdFhHRHBTMVBDYXlmdk1uZnhWZ05uc0c3eTND?=
 =?utf-8?B?NHlzR3VlYUNVWlRXVEhMZ2tTN2xjL3IwYWk4bEZsQytUZ0R2bmY0NmdTWnkx?=
 =?utf-8?B?d01sRHhicmNsRE1XYS9MMnJEdUdTWm9YSDRBc0dDcEl2U25NVUxjcGxGTFN0?=
 =?utf-8?B?clVzSmw0QVV3am9TV3hhNENKZ1RpdDZIVy9XRVZNS01CU1gyMFhEdE1PTWVK?=
 =?utf-8?B?MzRvUENQejYrZmZ0b2RrdjdjVW51Ni9WUXJZR3B1QWZYQnJwMVBMODVqQXU5?=
 =?utf-8?B?ZnJPRHlDRllWRzIydy9KSGxlMm1HR2hIWTJlSXNhNWw4NEFEY2NzYTBCWElQ?=
 =?utf-8?B?NDlCWDRlQTZvMnowSkZ5aHl0OG90K0UyNUVsc2JGamx3d1FQbnVmUDVhRkxG?=
 =?utf-8?B?bVpoNEF6Q3k3Y2hZbkhnWWc2MmxSZUoxaWgyc3JlMWgvNmxpazlFazhNMFZI?=
 =?utf-8?B?WXVremNQc1M3TzhaT2IrcUdwa0xQSDdMTTRZcWMrTmpaQmZkdHNJRVJVQ3Vw?=
 =?utf-8?B?TWRKay9ybGtGZlAvZTdNa05JTUNGWGhwRExhVldxWTZzOWYyZjkzUTdKOTBl?=
 =?utf-8?B?WkpEcFh5RGZYUXF0a3MwQVFZTjZ0UW5abUFhQVJabjFQR1RJWXRpa3hxZGdF?=
 =?utf-8?B?cUw0alZlNUhnSUQ5WHpyQ3FDSDUrQm0rOHBFR2p4bHkvM253bCt5MS9WWi83?=
 =?utf-8?B?U0dNdS9UY3FHbEF0NUZJc3YvL1JNdmsySUJsZGgwZW1FOERIRzVmU2F2VzRF?=
 =?utf-8?B?TFhXOXlTRXUvR3c2NHdNd203V2RqQUorYTM1bjg2c0tZUGxpWXliQ3FNU1hX?=
 =?utf-8?B?bURrWEhvT2Jrclk2L3JWRnpTMk9ZZGRoMWJ2d2V2K1JSTDhISzdKQVBtaDBv?=
 =?utf-8?B?ai8rZ0I2UkxMenZtbXJ4SmdJaUd0QXo3NjBtZ1lta0czUUdhUk5qcndHYjJB?=
 =?utf-8?B?NUVHc2lXNWlsdERnSEF1Wkh2OC90RjhZQVIwSE5aRUd6WDUyMXd4V1pLekJG?=
 =?utf-8?B?YnBqaVhMQjFDNEE0S1d6U05oR1NwRzloQ2JiNGk2OTQzdHdxQWtTRGozalJy?=
 =?utf-8?B?bXE5TURiTVk1Z1RpK2FvY3IrSm9NY05JdEVQZEN2SmZ3UVRxQUVqTEV4cEpS?=
 =?utf-8?B?eXNNbGlxVzBrRzc1eWIxN1lLb1RxN0I2S3FTNWwya1kya0twUS95Q3MwV29W?=
 =?utf-8?B?RHdkNlBCRHpid0JBREQ0SVllbkRCNEtsUFFiTWRYZnBGRnIzTmJHdWlLanhj?=
 =?utf-8?B?QlpSbW4xbzBPYWdhbTZydG9ibkxtZjhvcTlNZzNqYTVKSFoxNGV1TENWTExT?=
 =?utf-8?B?NUJSUjNQUXVVT1k4M2Jpc1o0dWNGMXMzbEZOejB0bWdtM1RGTHlLK1ltZ1pO?=
 =?utf-8?B?M1F1LzRGZTRzVC9sRFR6QWthc1NTVkljb29LVnBZS1RlOTZmTFhMS3BxUHVS?=
 =?utf-8?B?MFIvYVNib2lqQXI0T0wraEJDWlVqYzBSZmdiMzcvb2VJViswamNuQ2tuU1dp?=
 =?utf-8?B?TmdGMVlUdkx6eStsWmZnaFliRGMwck5YM1Q2YkZMajVjeUdWOUFPUUNrd241?=
 =?utf-8?Q?j7zb/chNNG55ec2hN8V6Anxrz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f010ea80-8b1a-4372-1da8-08ddf72428a7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 02:28:03.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k007Y/Yc5tuKBn00g+oGhClTx1bZRVBkPvmeeR1gZTuvulEV9al+09YvZlgU/4hj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9743

Add fan-supply regulator to pwm-fan node to specify power source.

Fixes: e3e8b199aff8 ("arm64: dts: imx95: Add imx95-15x15-evk support")
Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
index 148243470dd4ab03afdae949c8316f31467d1377..0953c25ef557684a3e78ef27a5e3f5aface33e3e 100644
--- a/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts
@@ -61,6 +61,7 @@ chosen {
 
 	fan0: pwm-fan {
 		compatible = "pwm-fan";
+		fan-supply = <&reg_vcc_12v>;
 		#cooling-cells = <2>;
 		cooling-levels = <64 128 192 255>;
 		pwms = <&tpm6 0 4000000 PWM_POLARITY_INVERTED>;

---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-b4-imx95-fan-9a371ca858f5

Best regards,
-- 
Joy Zou <joy.zou@nxp.com>


