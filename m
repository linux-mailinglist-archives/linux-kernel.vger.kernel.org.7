Return-Path: <linux-kernel+bounces-810366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300C7B51956
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 16:29:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3001C268D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA37324B39;
	Wed, 10 Sep 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KTd9/MRf"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011030.outbound.protection.outlook.com [52.101.70.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0CE1E5B70;
	Wed, 10 Sep 2025 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514519; cv=fail; b=cyOuUBN1cJ+PTPULIznyjokM4iFysxRoYKsr40R5tgDb+SoONUgq3R2XapXl9E6n8ZFqY0P1rHTJA+DdtDjAnrTW8fmwB0Zm5yYVV95XUeEw+Zn+K6ti6O2J6XxVb/6rYdQCUVihHkmX0uuapxy/DjMHOZzT+iJtOV/0StkIFP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514519; c=relaxed/simple;
	bh=E1fc+ziXKmTlcfuPZzFkf1a6OFr2Ffdy+LnP8zav+gA=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=fxUA5tjcI0QNZ4NCuv5epRIfDqSExkiyC33T7dSZ3vBKz8Sp8N7K/1s34uZvUEIvP9p5EEg8BGHbf3CDD37R5Pqo1S13JgQ6e5vfAGVKW+KCdLFJo/94tKQcUGbJdGJJM7srufNqPmh0YDkujFWugtQIjv47pnlM7dhL3sJhOhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KTd9/MRf; arc=fail smtp.client-ip=52.101.70.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpeIJ8HB8dE4fTiKzVAsctZZyZ3qbPGTy2HLThtRgS9dwUk0DsshtoFvZG0k70O+rSsOFLlUphtXE9k4UBxeeucy1WVyz4XPPCdlMCFLIJ1H07tlz4shb+du6QDg4O5J21BUECUqbxXNv8BrKsWH0M65kvGFEvp6Z5bMJGUFDMxmEiJugn+7L6sYNb3kHYt5nXpXkcaPGTGl+/FR2Kl0otvNKKM/gpvDPfpVynnPBXjEHrSu0ETGkXVMexd2W5iyzvdKf5eqhQ6Ae0CcPYP7lGU/H8Gvwt8XzoWD67daf84n3GO7+fJRUBw7K6CtHi+usDzqVRU/cXwTnnNWjkA6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KR4AjVF9GkjHSyx48rt0o5tBYS3eBwTKa1Kl3yX7ZpM=;
 b=WII9KMYZANpsIsd4Iqn/RO4EueqxYAFZ4XtL50TgKbAz/4kyXg16I9HTjbeH4dWwapwuZYtDhpWi+e1MYsFVwu9QfD6IGbmwd+bN0Wv62PwnAmLHWXXM2Xt5N8MQ5FlxWue0QOLEOgjHgYU58/eNYID+8wld6NYCR68JHM16Z18vEy2hBxmGT5b2jxuSKd2BR/fz5Xv5BJhm/g2I1LKl8zb3RxOMUWOesd1zBYrm/q4T52MKPfNtbNppyOEtcIES3EvLpF+BG6VUYbsV/5cj2jdGpi/4XJog/a/MFV2Aaf92dNPNu7KYMo6iXIZ2ju40+DytLvhyQ19SZIhmF6cL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR4AjVF9GkjHSyx48rt0o5tBYS3eBwTKa1Kl3yX7ZpM=;
 b=KTd9/MRfDOBgrBNUVu04scrjjVBmsmZYkr1cKPDeXSNB1YSGpLIhfet/bowxuDwNeQgOoYMdYoTyyKy+PzKxhrOtcp/ZfAEbmf5zYWfE+10u/G9H8nmHPlZv8RBz4jD0SMrCAaydL4MI2uCeGDlzF1jwN06rYlM4fA7DyCZQfJYkUUiR+2SlMgrOdPYp9e9dxbhiVk7W1lO+z3O/mwwgXHW/8fegIReeAcBYY0B+3uJLDIdKpX/NTpc3GIxAlrzvTLhYT1WaWLI47nsp5Q88EbuWZ6woJfcqxZkFcgykG3kYmIf7wVPcniy7a1dQMCLsNSPdW6avK+9AUu3QMX0mfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB10441.eurprd04.prod.outlook.com (2603:10a6:102:447::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Wed, 10 Sep
 2025 14:28:34 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9115.010; Wed, 10 Sep 2025
 14:28:34 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi/imx: Support dump syslog
Date: Wed, 10 Sep 2025 22:28:16 +0800
Message-Id: <20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAACLwWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3eJc3eLK4pz8dF0Tg0SDlNRkM0sTkyQloPqCotS0zAqwWdGxtbU
 AUnkyx1sAAAA=
X-Change-ID: 20250910-sm-syslog-40a0dec6944b
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757514508; l=1287;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=E1fc+ziXKmTlcfuPZzFkf1a6OFr2Ffdy+LnP8zav+gA=;
 b=g2TFYYpLp4rIflrXX1hFPtCplMRYOQfYVsBrcUtbQg3MAD3ac53W0QLk6DK4yjm1X58PNNssy
 43egrwbfgxAD/YbWr54ln1xvAVnjisyNd5P5Qeutk/cQGeGLzNv+bJ3
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB10441:EE_
X-MS-Office365-Filtering-Correlation-Id: d72eee94-7d10-489d-ec72-08ddf07652c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHJpbmRSWVJ0NGZmeWt6Szd3RnB2OG9HRWp1ZG1LanFZMy9EbVNNQWxGVlpB?=
 =?utf-8?B?Y2VDWm5tMEk4d05pVmRaeHE1SWI2VExBNU1SUjJxTXF1K203OE5aVG4vWHVm?=
 =?utf-8?B?ZHA3QUF0ZDJ3QmJUMEJKbUlpZlloKzFsKzdxb2laZVJ5SXN4aDNBUlF1L2ZM?=
 =?utf-8?B?d1lvRUtYVHN1cGF4OC81OTg5aDhaWHMvR3ZNVThkOFJHeVJleGdLbFFXd3M4?=
 =?utf-8?B?c0d6Q1puMjQyNm82WndUMnZIYzkzanhOUFJ0SHFRWlJNS0VINVZPT0hHbE44?=
 =?utf-8?B?QVc3VVRjRjdVZlJRR2wvOE45SURmenMrdlNwTnNsWXUrdzZDM2h2YWliZUUv?=
 =?utf-8?B?QWZFbjdCeWlPcmhwV3ppaDV6TUdEb0xyeEJTeWFmWHdTcE9ZSk9TWFVmNXV5?=
 =?utf-8?B?c09rMmk3ZGhRa20wWUl0TnkxZC9JY3hVV2RrWHEzaEoyditTREFwZFhVOE1o?=
 =?utf-8?B?MzZGTnczcE5GY2pBakdQallLRjFPRWdReENPNDN6QU5kOW9Wa3VhRC9SMDRW?=
 =?utf-8?B?bE1PRHpMRWxtMTJnNlRsOFU4T0Nmb1gvNkJZeHVEZjFrczEydndmaFJDV2JG?=
 =?utf-8?B?YXZObDg1cXdOb1hUa2k1MEdmbkEwT1YzUHV4bU1GZ3hMWTRMVzlLeUJvK0dv?=
 =?utf-8?B?RHd6d0xPbkxWWXJpNkpVWGRkK1JBVUdOUkNGWlBrZ01SMkJIZ1VLYnZ3UVBX?=
 =?utf-8?B?OE1KZmdKK1Azbmg0RnFJT3UrK3J4cFJMWXU0a1pSdmlYQmluVjFoWUM3aHF5?=
 =?utf-8?B?TFRzQnhSRWx5SGVham1VOXlMWTFEUFF1WDVUUHorTW5JdUxWQ0JGUTNmSjRr?=
 =?utf-8?B?bUQrd09EZDh6dDRYTzN4NkZuL0hERk9hZ2sxSjRZSlpyWDEwK2VWNXdlY3RH?=
 =?utf-8?B?TmdjZkhoUXozbDdaVlJ2VXRKSzhEcXRSS1Nac0NablF4U1NSMG81MHBwS0FY?=
 =?utf-8?B?MXdHRExMK1BJdFZ3M3NqUFR3RElJbnNENFcyVGQrSFZ2blA1V3JIRmIrSVlJ?=
 =?utf-8?B?SlNGNi9wa0o3MmRhUFZMcVNobVAwK0ZJWHBCYkNpdWt3SjNZeTFESXdxS3R0?=
 =?utf-8?B?N3NPMVJZcFpsNjJsQnBUeE9WNGN4eTBYNjIwT2hGb1BwRGo2YnhoZkZJU3VR?=
 =?utf-8?B?czRGRDdhSExPODErNkJCRzdRUG5FZlJjTWlzN0JJcnF2UnRSOTM2dGs3Z2Ur?=
 =?utf-8?B?aXlMa1hXMnRiQytRU2xRM3dJTVhuQlpvM3RCeURqWEdNVkRlTVNYK3NackNK?=
 =?utf-8?B?clo2cExUaFY1M0k0VXR6R1I3M24wR0V6SU1taVRuZms0UDk5YXBxb2xZRmtD?=
 =?utf-8?B?Vjl4ZW43azdpN1VyNDFJZytnd2pnc0R2NEltQmMrOHBZY1AxWVI4VXJDRUMz?=
 =?utf-8?B?VUxTb2VIWXRCMWc2NnJvUlhYYlM1c3JSK3NSQnFrUXdWaGtJMm1TenZsRVA4?=
 =?utf-8?B?K1VxTXgwb3dSbUFYK3QxZHYxSWVzdS9mU2pwaytTRGtMR0lUTUg1OFFtOWhF?=
 =?utf-8?B?RTFPMThuQ1doZHQ1dWVzcTA0ZitTdDVJRE1qOXBjYVVFbXlJWE94b2ZyclVJ?=
 =?utf-8?B?ekcxalV4SFJiWkswam9rdE9yOE1aNGFwYUJOK0tVc1ZhRTR3clhMTlF2dnpW?=
 =?utf-8?B?T2E2RS9RNjJKTUR2OWtidkhkZUFDRzI3aGJQRGEyVHIwL01yNFNSZE5XQTlt?=
 =?utf-8?B?THliLzZuR1o5Uk4wR3U2eU0weEJBa1lTSldrUTdsbTFyYTFlTks5dmJ0UjRj?=
 =?utf-8?B?c2hJZUxqM0NjZFBHdGE5S0EyQ05lNGU4Q1lXOVFsbVdHMUF4YVREVkh6N2sx?=
 =?utf-8?B?ZENzUHJQVEgveDhMaU00T2d5L3NjTEhjenp5VFRuNlArZkp0bU41aUp6OXdj?=
 =?utf-8?B?aDlBaG1NUWl4b3ZGMFQyM1JZV244ZDlwV0l1L2Zhb2JjQ0k2cmZvclIwbmFH?=
 =?utf-8?Q?oy2O/FqTGjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWErbU92Y2xwSGMzL0xSbmpxTVdxZXYrRFdsdU96SmsrOWRYZFJhMlRqQWhQ?=
 =?utf-8?B?NFprZnFIWXRGZTVMcTQ5L2Zlelh1YUlxN1RLVU9GdUkzNVdDYmFpZ05tZXd0?=
 =?utf-8?B?QW1GU3BTa3c0VENVTExUbkJEVTl5SDhkcUIyaExWcnNjVE14M3NOMTVCNU02?=
 =?utf-8?B?TjQreDhVeEdKSE1FRFhNZ1pkMFhtS3R5a2M2NldvV01TNnQrV0RmWmpMRGh5?=
 =?utf-8?B?VGVacG54N2hmcEowaDdFd3FtWFVMd1dObC9DMWtsQVlaWUNvZHpDbjNTM21X?=
 =?utf-8?B?cnJENThtK2pPVVlDSytGVGY1NUwvUUVpMGtnZ1ZKU1dqY2dGNnpBQ0RVeUNo?=
 =?utf-8?B?MFM4M0xDYWhpTTREOE9sM3ovR0N0STFhQ0lDMzNxWXR4a3JYQXMvT0lPYXMy?=
 =?utf-8?B?NXVKNTFROWRjQ1V6YThZVGkrYVlRL1cwN1RVaWhVWGZyeTQ0MWRQYm5GNS80?=
 =?utf-8?B?VUx4RVRlUVhuK3ZwRzMwVlhTV1NGa1hmNThmWmptYmgzM3FVbGhzUUZVZGx5?=
 =?utf-8?B?YkdLZlFDeThmOXJUaUJrU3dMU1dQck54c1FCa0NoaEtIS3Q2djhoNE91Q2N0?=
 =?utf-8?B?M3FUKzFhcnkwSVl5RDJ0Mm5OdENaZUNvdHJqSW5NVzBjckRFUy9MM0dnUk9z?=
 =?utf-8?B?TC82dHNoNlVwdVNtSmEvdno2RjJuZUdTdkEzN3E1dmp0WmEvdEY2ZE8veUZn?=
 =?utf-8?B?bGh5NUdiZlphbXRkSGU2RHB0TnZTN2RxZzFVZUorVFQ1d2ltMnBvMDh3Wmpa?=
 =?utf-8?B?RHhVbGZmWnQ5VVdFbFBra2ZJK2NrTGpOa3habkltdHNENzJYNUt4b1Z1eW9w?=
 =?utf-8?B?ZnJlYmJxSDQxNUdVU3NvSFB1UmhRSUtRVGVHL0NFeXZFRS9zMkE0ZS9HdHZn?=
 =?utf-8?B?UitEQXRmZ1JnV2tjaGRQTXZEanVpWHFxS1o2VTFkblNsdzRiSHJhWFdLdXY5?=
 =?utf-8?B?MjlXVU5OVVJ4bk1vVVdlMm9rdjdrVGVuclh2SGhLUGU4NUxZcFlVdjc1L2ZG?=
 =?utf-8?B?eVp5ZURwNktrOC96ellILzhsMUUvWHNnV2laTzREck45QmFJVnZ5U3owdVRL?=
 =?utf-8?B?TmtTVXlyc05qNFdqTWpWRjR4R1B4dE82YUEwZVNSdk5hOW5reU9Sem4xUHRw?=
 =?utf-8?B?RVhnN3g1RStQWjNGb0h2dU5CbEdIK1RVeUJIY01oVzNpd3daMVpYUVNmd2VE?=
 =?utf-8?B?bDRxQ2tpSXV5Qzg0RzlMSHVLWEFTRVNEVEZOU01wK2tzVjAyLzhtUGxSUG5L?=
 =?utf-8?B?RkVzeVVub2cxa1RBQWNDbERXcE01ZzJPbktPUjdjYy9VcWJ1Mmt0aE9QZWIv?=
 =?utf-8?B?MjBMTFo1UGVHZEpnWUZJY1VNU1hBM0pua3MxdnAzakNrTVJ1SzBzaVQxRndL?=
 =?utf-8?B?M0thczNSb3Mwdm5ab3ZCOGFPQ2FSdjNtTGlDeWxrZlQ3Y2Nyd3hJUEtrWHdx?=
 =?utf-8?B?SjVKNnV3bTZTaVZtUzQyR3JIQmgxaVVrZTMxeXZqVHdNbVFMa3lOWEphUVRl?=
 =?utf-8?B?ZXlncWl5eS90OExZVnVDdUxNZmh3cFRzYjl6RHFSY2xUZVNhNHJlMitnalBj?=
 =?utf-8?B?VWN1RVI4aENuMXZNdjI2M0JOL2xSb3FkVTVuZFdvNHBEaDFrc0FjTGdpcmll?=
 =?utf-8?B?Um9iMFB0cDRoNjk5Zm8zU3FXWXlvWjB5akFocFRBcnR3TEdCUkYvT2J2QmVQ?=
 =?utf-8?B?dHJCNWFpRzVXODhTR2pCaTByZktlVy9TK2xzbkkvSmlKV0loY043RERqR0p1?=
 =?utf-8?B?V08xeStDSDNraHJCeUNnVmh6OFY3THFtZVowaXFUNVBEa3FpNjdKVEZwRS90?=
 =?utf-8?B?cXM5L1d6aWEvaFY4Tk9SVmNvVnVsOEN4SWV2amRZazZ6b0F2N1RmUytuOU5z?=
 =?utf-8?B?SmRidlhod0FwSkEvTVpqYVNuTmJwUHUzcVdHOEVDb01GK09qRlUyR1NpTlY1?=
 =?utf-8?B?ZFVRRk10cVB6elZ1a2kvc2RscWNxb1ZFdGVpU0t5Z2NmeFV3TVBraTBhREZ1?=
 =?utf-8?B?bkZqSFFBNHdRVVllWWIvanZ0T1AydlJ1eFp1cVZwSHVIVFB6R05qTnRlSC9a?=
 =?utf-8?B?bzJTUnYwMW5uQ2s2NHdHbmd0dEtkay9HM2ppUlRwWG1kQ0JPczJxeDNDcWY3?=
 =?utf-8?Q?kFOjlvDjxAn/ZbaOyAriZ2X6w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72eee94-7d10-489d-ec72-08ddf07652c2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 14:28:34.3304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhKRrJkgu90vg5BL541Na86tY8o3mdgvq2ZqilEaq6hflUlL0hewRh/t2nYpHwVWUVKJd5Ug46TWmS0IrNxIqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10441

This is the patch 5 and 6 from patchset [1] with switching to using raw
dump, per check with Sudeep and NXP i.MX SM firmware owner

System Manager firmware provides API to dump system log information.
So add the interface for Linux to retrieve the information.

In patch 1, I drop the two structures compared to patch 5 in [1]:
struct scmi_imx_misc_sys_sleep_rec
struct scmi_imx_misc_syslog
No other changes in this patch.

In patch 2, I switched to use debugfs to do raw dump the syslog, compared
with patch 6 in [1].

[1] https://lore.kernel.org/arm-scmi/PAXPR04MB845937237E3C1AF5A2ABA8FA880CA@PAXPR04MB8459.eurprd04.prod.outlook.com/T/#m6ed303ac9c584c6e2ab39f89359f3131bdfcc9e5

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
      firmware: imx: sm-misc: Dump syslog info

 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 drivers/firmware/imx/sm-misc.c                     | 42 +++++++++++
 include/linux/scmi_imx_protocol.h                  |  2 +
 3 files changed, 127 insertions(+)
---
base-commit: 65dd046ef55861190ecde44c6d9fcde54b9fb77d
change-id: 20250910-sm-syslog-40a0dec6944b

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


