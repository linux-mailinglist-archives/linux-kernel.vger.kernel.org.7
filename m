Return-Path: <linux-kernel+bounces-875922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C73ACC1A226
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEBC1893D49
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ACE3396E0;
	Wed, 29 Oct 2025 12:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L6F5i8Id"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013034.outbound.protection.outlook.com [40.107.159.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9096B31E0EF;
	Wed, 29 Oct 2025 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739652; cv=fail; b=l5HHl0k48iDMhIpfjrrzoZBVgAxIALc9vw7K575TMW5B3F/KA9tHskSSCayKLRSjZkcjVkF7+PDkx3JfC6nMBJzAH6+nchr3Q918dT+h/R6NDfeUNEKJRV/KglBws1kxnw5MS6FP3ayBUYx75K4jyHwpxxpAoN5B7l+IRUusb9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739652; c=relaxed/simple;
	bh=37u7Xj7x7kPt/BcDxd1pQOBXCgOo4SrfTdgrwwdqJOM=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=nS4N5YHCNrIY5canCdBwEdoDTYQe0fP/rqCpHxB07NhvpwVSAvXl3TgDEOuURpStQsXpl8XDKXd4a2QXyL7HV32BDQMarl8dCBPEi1T3o9J0lfw1WHRiHZ78D+b2biYGG5zqnSbceZh4BC0jMv78w68WcEPq76ceryWhSh+RxYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L6F5i8Id; arc=fail smtp.client-ip=40.107.159.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FREO5V2nXiOFEL070P93+BSHID9DkSmfgMS9QITGm3fmOieS/9VhSgh80+uZaWL7I31p/0KzccTLh6aYvBDligtG5DePB4kyFX8Je76FBRw8fIVFB2wDtV0XSlk1Vk0fvN4eZf52uA2n3G1zrIPywJY2UdXPOzJQLFxxiaXGuU4YYXmrWlToMdBM/1GIO/yp1f4bgQUDpscdJnACDBDK82LdCcl90/ID5+JsjInkJ9QHyztWn+EXgxOx1eiHeAJfQwhJusvsWajQjBUnRhnBK7c9b5RTVFSKzZr0KqqvQCj0LjbRtguMKX051Xgfzp9Kd4IQYpYrWwQUHNl6iVm19g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UQRXSmbHwy8nGRkWgSapRmoRQEbB7WO3MgkGOusbRs=;
 b=Y4TJZTB3AHCH6clSQP45hg1SLs+5OAF9NgpdcAlASLn6VRoRFQ+Kl86R2ku9B8OsTaUMCzahHzoGea909dn2mUneaQF+j4A4MZOiPaUA5pNUy2ySvKh4PTBgugB9FFiN3Qu7rSS50iq7BYtnypw6pcsVfBti3XKTLz4a8y4M88hqHVU3b0R6hk5eA+j+fXCXcz6w/LEXey2SQhEgAfxL168GUCFtjZfmQ/rz6FX+W3gbN9EcLHwAZbZlgmg2n2+4OfQo2FgVEYPzkcyt61zkCmDb09qPbHa6LCP8k7oYDjWlPWgRbkyGm8oDptFyVyLskFNawP9yD1yqSb5X4x66pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UQRXSmbHwy8nGRkWgSapRmoRQEbB7WO3MgkGOusbRs=;
 b=L6F5i8Id7uW5lM12XPWZHKuaEx/SIiqpu+I/bzfanCWb0EfkL+JpHAD61Lh+5c8vmSWZvTfiDL/XXsT0BS5TyrJWTYxs8uqQod2UuNjj0mCMiCDxGtTXnzOyx1tBfr5GceoyM0vZlh4J9oQ8dZ84UsSHrybiimEarIYJAZdy9x6CjUI8KGiv3hm3jmdFVaCvxaSz64gXbP09DcGfxHXke/Dv7WsjXKu2f3qpe4/YYS03P+EpHatO28AGXVjCvagchyC6U0Yrxl9emS5GR5QWZjSRixznlk1J9wZoWdrojIjpY4NQbQSf2lhOlXXjVyRwW1FbjNEmPuG8HNHFDyC/Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Wed, 29 Oct
 2025 12:07:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 12:07:23 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v3 0/2] firmware: arm_scmi/imx: Support dump syslog
Date: Wed, 29 Oct 2025 20:07:00 +0800
Message-Id: <20251029-sm-syslog-v3-v3-0-64e14a6e3f87@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGQDAmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAyNL3eJc3eLK4pz8dN0yY10DQxPjNAvTJIPkVDMloJaCotS0zAqwcdG
 xtbUANu4AFV4AAAA=
X-Change-ID: 20251029-sm-syslog-v3-0143f85b0ce6
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761739635; l=1884;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=37u7Xj7x7kPt/BcDxd1pQOBXCgOo4SrfTdgrwwdqJOM=;
 b=ZDcUhSvbL2D8L7YhnGFPtZQYrbXPgKoVZafrpSU4OOx6zzJAd3pvHaWZP1KLz0vxoNskI/QlO
 w6T0qtSWGHHBXJbNGa1+bc3fAqjX7Cy1AWSLFdCsx6gvoGvwh/ESCSP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e65df4-f09b-458e-a672-08de16e3b7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTdHSFVpVnl2Y1RmSlpaU1lueXFFcHpQY044UnpjMlVaY1h6T05OS2RZSkpW?=
 =?utf-8?B?UEt3NHZ1cno1TGNielIvNUxmY3JTZUV4NGV4VnFFUUt1L2psVTVRVHllbHht?=
 =?utf-8?B?Qmc5T1FkVzNaRGorRVRZYlhzYWNzTUt6UGlNMGFJTG9SeUlhZ083MFlFdkpz?=
 =?utf-8?B?NTMwM1dIcmVWRlMxY1ZWTk5kQUUrWHNxWUFxODgvandYU2lPcSs4TmIxNEdm?=
 =?utf-8?B?dnFucElvbVgzUzFLcjF5c2JQUldHNU0rd1dQRE1seTNLRVQ2UkMyN2xSb3A0?=
 =?utf-8?B?OHlrT3ZYckF4UVZDZHNEQlVKQStTdzc1c1kzaWdXa3B6SHkzbkxkUmNSZkww?=
 =?utf-8?B?d3dHYjB3VEd4SFRyck1nZ2tLWDZvYUtBSUZscWpxcUY0S1luT2hIeVhPMy96?=
 =?utf-8?B?M0doczE1VEtPZG1aQ2pNSmxqSHlybXE3NFJHRkpsM0hRR1NnZHBqT09td0J4?=
 =?utf-8?B?MjNsckdJekRYRE9iYzJuZTBOdzVoUzFZUC9CYmQ4YVgraURSVXovOUZ6cXRF?=
 =?utf-8?B?Ky9sMHEvQm9BT2lsOVIwQUpvUUFzYlp0MGFrOFNrRHFMVEdySkRJU3F4aWdN?=
 =?utf-8?B?Q0kzZW5WWHZnaENIY0NJN2RLUDBDdGNkVjhiN3lzWVVvejBwUXQzcm9QYVh4?=
 =?utf-8?B?cEdNZVhJWmw3U096UUZtOE9YVUNIMTcvckx2eHZYYllQNGpnWkplZ2tkZmNK?=
 =?utf-8?B?TmY1dDc4cHFoVEdGTVVCcW00V0tuWXdGQi9CWVI2OWhPMi9ZZHJrRXlSSkhQ?=
 =?utf-8?B?Wk1RMmVqMkFxckRNdEJ5VmhwMGVXd0JFLzUycWpRRnpsbW1OY1pQK3grQjhN?=
 =?utf-8?B?dXRXMzhJMERVZFlmcUh3dGVIUmw3NDVTQmFUeEJrdHYzYzVSRWdjN3NnSERQ?=
 =?utf-8?B?b2RDbnZGY0FGd3BOVHRtMW8rTHZGc2lRaStrMlN5Y3pWbE5aTGtZY21WdkNn?=
 =?utf-8?B?cU1ESzNpSG5uQ1gveGcrdFo2c004UWdreU1FSXhjWGVUS1JLVVFKSy9UT3hT?=
 =?utf-8?B?YTlBWDNsQitFd0lDOWhZNkcxek5XajRSQW9ZS2lhT2ZUZWhqb0R0TUJBa0hY?=
 =?utf-8?B?emFMSm1iYkhVVSsxRW1SYnF2V2x6VVN3dWxhTFJ0aWZrbnVaS0JaKzN1ZE5W?=
 =?utf-8?B?a2JydFk0dC9VNmw0RVByMGNJaHdEVVdBSXJLRzBuSEtKWTM0R1N1djRHaFVT?=
 =?utf-8?B?YTQxUFk1bkZvN3QvWm43SkJHZGluWHpCMmc4OHpCeURhdEs5d3F6d3U4aVhy?=
 =?utf-8?B?WDdXQWFvZlNaQXBHZVUvcHorWGpEOXROMHpqUjBGQ2doZnhOZHNxaDNZVTlv?=
 =?utf-8?B?YmZtdHQzYUxCNHpFR0w1TjRTb29rVFNoQ1VYR0k3R2dwTzFyNk5iWjdnTURG?=
 =?utf-8?B?em9pVXpEeWowaURic2E4bEZSem80ZmZMT0cvVzFUdVdTT052clI0RTlRNHBW?=
 =?utf-8?B?dXJ5NC9rVXJmc3FaWld1VlY4MXdjdmFKcGMrNE9SVTAyc3hGeWNQeUxCWUFV?=
 =?utf-8?B?Z3dwa0lXb0RnbEh2QktDTVcvYk00eHV3R1ZqazhVVFJYRm81SWhENmFhZHpn?=
 =?utf-8?B?b0tmTStUM1ZwV0ZpUGlsNnkrQktNV0hHWGNpV0p6MVBVQi96MUY4WFNvQlpi?=
 =?utf-8?B?eHZXNjFoNDFJVlhIUy9sWk5WMDlTTit3U0NZVFcwVjBvc1d5cHd4dnpjY1Iw?=
 =?utf-8?B?dGR0a0F0TkZ2SldCWjZhREdBcTMycTJIdUhKWlIwVExIcWlLM2JBMnVDakNN?=
 =?utf-8?B?cjgvT2xVRjRSRDhwcmVUWUpsOUNySzNYZHM3aVI5YlZLSzduVGhJbTBPdlUz?=
 =?utf-8?B?NXFZME8yZlhqNTlySzVmM2J3SENiUk5oV210ejJmeGhjUEtjZE9QN1Fnck00?=
 =?utf-8?B?VDNXYzVGNXMwV2RsZzVWNlN3bjc1dHNkVWc5eFNMRUVWelBtTW9ZeTA2czVj?=
 =?utf-8?B?c0d4MWdkbW9WcVQrd0QxQml5Yy9hcWZCaU9paXY0VVI2dGlDZUs0ZUI0Mk5D?=
 =?utf-8?B?THppR2UrcnN3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUZvdXBYbVRNRS9wWVJoQXB5aFhmL3VkT3RmK1NXK29pWnBBeUtnV080Mytx?=
 =?utf-8?B?Z2dkTEpMRUxvZ21zM0NYN2ZRUXRoWmNybVhYMmxvOHFDS3cySFBaK1pIblFa?=
 =?utf-8?B?cnZCV25Oa0dnMHdXelhCUlB2NVBXc3N4S0xUVjJ0ZTFsWkowUFpxOS9EYU5Y?=
 =?utf-8?B?YWk3ZytaV3RTWVFMMHpKQkRCSmgzL3Y2aDJOR3RVYkVoRzBLK0ZUdVVIRHA1?=
 =?utf-8?B?ckpaUVRqSkZYV084Vmt2R0x5dTdJaWtzR3V6cDVpNUszVjdXMEZEOTJ1cXZF?=
 =?utf-8?B?WmRaVEFDVG1hYnp3R1FvUFlvS3lFQS9SczhhUkIydUZmQXNTTEVHeVpqZGho?=
 =?utf-8?B?MFpCOVNBWmRHSzNkZGJ3bnBsVkdYQk5UMkk4YVZMVWN6NDRCeTJjRS90M1Mr?=
 =?utf-8?B?NVkrcTk4TXoxa2NRL0Yvc0ZJdy9Jd0hiM0xVRHBHY1NnMGVkNUpKSDBXbjRJ?=
 =?utf-8?B?RXE1VEVPa2p1QnExMXZIVEpMZXZ3N0ZDSVVBQ2FVaGtYamtsbWk1eEUrS2Vw?=
 =?utf-8?B?ZThUbzlaejYycEVhRlRVL0pNM1dXMFpIVDlmcCt6M3IzMjZpcGNHbnNHZXdY?=
 =?utf-8?B?dk9RRDk4TFowc3hIWXlSSFp6SzRzdEtubWlzK1RqcVhFZHA4SFlqTk16RHk1?=
 =?utf-8?B?NXpWajg1bUVxWE9GNTJ0RFlIRERQT1ZucEdOUUdzRFNzUEtPZDRpZ294NXpE?=
 =?utf-8?B?U1BlOXduSTQxeVlmVGZsN0FXYkdhbmNMaGkyVVhmN0VpcW5Ua3VVN2VaWnlO?=
 =?utf-8?B?ZVVZQVlsRGpxazdGaU5HclkzZnBYT0lLV2Z4TTdkNnRoc3p1S1hEeGVuWDBY?=
 =?utf-8?B?Q3hRdDhPempVT3NhMzJzQzZFWWpTWXBXKy9yM3RwaWhUQUFRdm9RNkhKZnd4?=
 =?utf-8?B?SUZMTlhvZ3hXSmFGYzUzNGVsSDFybWgrdE0rb2ZKMjRCVjkxWXRoMmpBR1d0?=
 =?utf-8?B?WSt3dnRhTUlQbktmWnV6bE5oZ1ZDaEw4aVdKNDd4aGVsbEh4VE9aWDJEWVhL?=
 =?utf-8?B?S3QvUTFHT1d0SmxVNWJ4Q1RabXgwMUNzZERLdDZBc2gwNThOTDI5eWI5Z0dI?=
 =?utf-8?B?QkwvMDhKem1icmdOcHh2WUgyUUJLRHU1dE5XbXdZcHR3QWdaZ0EyUWhSTFdM?=
 =?utf-8?B?MWZLbVJ1VVFkeFdxVmczZm5kd3AyNDNCdHV4WHhtKzRuOHgwQ09VcW9aMkJr?=
 =?utf-8?B?L3c5QVhoSlNJLzRBZVE0YUc3c2sxamVoaWNWZ3NJaFZTRU9UOW1jODIwenYz?=
 =?utf-8?B?NlhVdlVLZExaSHY5ZjRyVXFSQW14SVlqT1ZOb3RySHdCVGJpZGlmeUFEbDFD?=
 =?utf-8?B?dmwvcnJJT0ZwYWJZeHhjeHVzSmp1VkoyOFNQbHhHODJ2WThJSnhETERkL0FU?=
 =?utf-8?B?Zkg3MDM0WUlhenp0OVdrQXdzWGw5QmdlbGcyZlE2TThUT2RjNDhWck5pVk8y?=
 =?utf-8?B?RHZwNlM0dERNaDdaREtNSGZNRWNvMWIvcEFrblhveE1aUGVQd1ZFUDA4a1FK?=
 =?utf-8?B?YzlxUzB5VjRJMG11QmJMWFZDM0FVdUFFNVVqM0pHcVAwS2RKbzdVVTd0bzBW?=
 =?utf-8?B?TlVqOHJFM3RnWmNheWovYWpjaVEyREJkRlpDYW94TUJpeWZneWRNMjJ6T2pn?=
 =?utf-8?B?R2tXRXJ6SkpmenM2cFA1TUZaRmRIMmZmajdVN1pnRFo2SDZRb2JEdmRzbHVi?=
 =?utf-8?B?eEpRSitlaUZSM2V6ZnlXWW5PNzB0di9DZk0wTWxVL2loZGpwc1FCWlpsVFRD?=
 =?utf-8?B?UFovYWJDUjZYMWppRmtwTmlxL3MyT1VXM1NrUjQ5K0NSdEtOZkdUeHJSSVV0?=
 =?utf-8?B?RW9GS2RJY1JPbEFOSkNCWnMvQStOSnVocmE2WVdGVmZKYzczWVMxbS81NmlX?=
 =?utf-8?B?cW16OS9TODUwOFJmbnhjSXFRbHhremJib2RSL1lDVHZmM2NrQ08xQXNPRzBo?=
 =?utf-8?B?TWZsUHRTaE5kK0xScmlsWGN5NjIvRmxDV0xiZ2FWN3gxNlc0LzgxTnEwZ1NZ?=
 =?utf-8?B?WEFOODIwRERuZEdWUmVGWjJiQmJRTWdoRkw3OExkODF6bGRJMGgzNFBKcC9s?=
 =?utf-8?B?N0wrbVd4SzI1UXFNUjk4M2lSNnlrdGtuMWM0T3l0ZFdkSE1BRlViWVJqOFJm?=
 =?utf-8?Q?fclV07ZiEv2R4+b+3k3JUyN5M?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e65df4-f09b-458e-a672-08de16e3b7c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 12:07:23.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0OLmLcIygPOx3qEq9OZLjDkfhoki9qHw9C37De72dBYNcfT1Qanytuj8qv9t0YstrjhdcEzPG53fRA6g9ET0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708

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

[1] https://lore.kernel.org/arm-scmi/PAXPR04MB845937237E3C1AF5A2ABA8FA880CA@PAXPR04MB8459.eurprd04.prod.outlook.com/T/#m6ed303ac9c584c6e2ab39f89359f3131b
dfcc9e5

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v3:
- Rebased to next-20251028
- Drop unused variable to avoid build warning reported by kernel test robot
- Link to v2: https://lore.kernel.org/arm-scmi/20251011-sm-syslog-v2-1-v2-0-f43a3f6b32e4@nxp.com/

Changes in v2:
- Rebased to next-20251010
- Patch 2: Remove the IS_ERR check for debugfs_create_dir per Dan Carpenter
           Change 'return 0' to 'return devm_add_action_or_reset'
	   Drop the size check
	   Include 'linux/sizes.h' to avoid build break
- Link to v1: https://lore.kernel.org/r/20250910-sm-syslog-v1-0-5b36f8f21da6@nxp.com

---
Peng Fan (2):
      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
      firmware: imx: sm-misc: Dump syslog info

 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 83 ++++++++++++++++++++++
 drivers/firmware/imx/sm-misc.c                     | 37 +++++++++-
 include/linux/scmi_imx_protocol.h                  |  2 +
 3 files changed, 121 insertions(+), 1 deletion(-)
---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251029-sm-syslog-v3-0143f85b0ce6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


