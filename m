Return-Path: <linux-kernel+bounces-800541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154FB43905
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD6517B1BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E0A2F8BE6;
	Thu,  4 Sep 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrY9LU/2"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011036.outbound.protection.outlook.com [52.101.65.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4D42ED151;
	Thu,  4 Sep 2025 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756982502; cv=fail; b=oShRw/A0oD2FjpXStixSabYLOIY02BUFRYM1baHykEhhH8CZUupuxYT3WxFpVtwqc/1/etViT7lyG4FLX7GWQNb6gV1x+cP3eO+f2EFNN2hUqB6CsbSEIvch+XTn62h7Vn2V9Bo9fW6/XYEo+Lw2AQBlyk83UZkL8yxqUDOKk2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756982502; c=relaxed/simple;
	bh=01nUeA3pWR+A+945v3rhqC7aNThGBJtQFlHcVEqE+o4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=AUSnL0siWxNVnfsDRZnsUmFrEOURYXjXkfkZv59N4n9Sa0hvaap+cOAxJLqQEEZ2s3EvqYw9/ShHABX2ib/6T5V2B208BxYWjFY+FZqfqfQLGiMCnRHSGhn3Ct6FmgkIR0BO6JBeBUgaKwB6vlW+61bvO0DpZhMid4sUT3O8r5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrY9LU/2; arc=fail smtp.client-ip=52.101.65.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5VodwsRS2udhR4CWqQSGiG1h2w5byHq9IFVqYB0Jcdvff6Lf81P8dbU8UKQ0q3txcGrEKx7XFf34VRx4fAFcj1tuPfUtptiEyeuROPvxsr1tEgG90klwCqWLmx8QU4qvoeXJIC9ZqSQbrlrECypuT0rkJ7BPusoVkbO5TJlEl63TNuZxA3cgWJDsE54KzPxcmt4nEzZV4DBm6euOL+OYB4CA5G5PYVNAIcM859QtZUbJMDJIzlkpWzBTwO874bnvgvfvmHNzcAMKIwzWcv7v/S/0Wbr8RxNG8eoDHpbS5F+tKgj/etEjJIQfSkTfmIKAFDZcHmLAKxiCuDSs+mgqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCcWtpdlJKSefXOKkeGMqI6Ln8NCOXsGs2mWaTlWTfo=;
 b=L8U9Ga/0u8zhguoY4wizbnQYUhg6LNbzVKRDGgexRK2V39nnzNsExBPymYgdLaCGaegEKr9pj2fW8Ut6SezY9fdDUBsFjAaaPws+JWgVPZrkFjyF+OE3VC1o6ZMO5r5lp2KqzSIQaLo9qMQyVKeAA2kJb9pSi6U6fvL8yg2MPJHIedjzvFhuuubfue3p1VIhoxzR87OFYwzrzKUmMJcaIg3vmgraWX1ZHBGvju9REZD/OE0tXwgg3genTnIExnDEuJZECGI2ZM85GEC5O5z8LbR0ht4lKLAzjB5dE8gkLNlTq8K1jbjDMbNcKc8lLGcZVlxb81O1V7A0OLHFsYkvjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCcWtpdlJKSefXOKkeGMqI6Ln8NCOXsGs2mWaTlWTfo=;
 b=RrY9LU/2JiegRqg7kM3QJ56tIV3vvknoq3V35uhWHMXdy5Ibb/wb1geMJCzP6loWH9b5FF+rsJ9bGLoGPt0FwGwg1A+LLJvV4bFh3MQy0Qf2y/0dw7EBqz7pICTpbENlRv/ifQe+12oIFJL7pEE2PJagt9MMSTS+wtgmeoL2iz7ylIGUh7zkc4i/NZL5zwj+oVsZrZ+F1gH0dvtIBFHbwVN3KJX9s1rYjnqN120zlbQUGoMxEbcWKd86xRTunJ1xE2qBGr6HuCUFfVIB95ohz0/9OtfCrKA0mctQW8QmS5mIU2Zdkk7Tb/57IMVjWYx6KBjuplcww4+5eADstXvjpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Thu, 4 Sep
 2025 10:41:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 10:41:37 +0000
From: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH v4 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Date: Thu, 04 Sep 2025 18:40:41 +0800
Message-Id: <20250904-sm-misc-api-v1-v4-0-0bf10eaabdf1@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKlsuWgC/3XNzw6CMAwG8FchOzuzdQyGJ9/DeIBZtAf+ZDMLh
 vDuFi7EqEl7+Jr8vs4iYiCM4pTNImCiSEPPIT9kwj/q/o6SbpwFKLCqgFLGTnYUvaxHkklLZ70
 yyhclr2A0Bmxp2govV84Pis8hvLb+pNfr3yoeJaGpqtzpFh3Ycz+NRz90Yi1KsONSqy8MjL3By
 ho0eYPFJzY7dj8+G8YOfMWrnbb1jpdleQNH3UE8JAEAAA==
X-Change-ID: 20250627-sm-misc-api-v1-85c030c670c6
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: arm-scmi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756982492; l=2707;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=01nUeA3pWR+A+945v3rhqC7aNThGBJtQFlHcVEqE+o4=;
 b=nkCuygOp6ugb14isSwolhMugluTEZF28mjq0xdKfxaHtncVreZsfXnJLc0vnmWvuYtSkrjRCy
 Y3YDonTr4eUAXTwNw8V7330EqBT0ktspv9VzC7G4OjxQ2KzOORoYNIh
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGAP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::15)
 To PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: d1717620-4605-44a5-b39a-08ddeb9f9fcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDJwQWtUR2xwWWxmcFNUbU5POWFpTlBKd1dLcEdJdVAzdDZsdFlqdEgvSjJI?=
 =?utf-8?B?WlIwRlB6YVRwak1qUEJoSVdJSU14T29LQTdrcHNCemJPa2EzSWxkYTlKL0Fi?=
 =?utf-8?B?dzJBOWRZN2RiQXpXRzVSYXU2c2dlOWpQeVc0S0xmNDY5MkwxbDRPVXVwSnRv?=
 =?utf-8?B?QU5LVmYzQTRoL1FPYThFSWR6Y1NXNEgvTnJnSjF4a0RLbGhSYkh3TTFpRHNt?=
 =?utf-8?B?dncvT01sWWNsYjZvU2VzdEJvUmlDakMxQ1ltQllOQmhVa1ZocWRTajNYWjdq?=
 =?utf-8?B?ckh0WEY2TGVXdzJDUGlYUUduUXFjQjhaMlI0K1hWQWJBWDNiTTQvQ3BlM1pN?=
 =?utf-8?B?M2YwZzY5aVBjQUhKV0JxY0xTQ3hWeXlOS2sxOUNsc1o3V0p6Y0hOVVZWL2lN?=
 =?utf-8?B?VHJ5MFg4RFo4R0lxU3FWSGNjVjl2Yy93aWU3NHZvS1MrKzRmMG51dlR1UEVL?=
 =?utf-8?B?U2tyeE9kaGxNWU1vWERLRHVFS0tlTUdBbnBBUE1zbENESFR6djEzbXA3c1lv?=
 =?utf-8?B?ekc1MjFoN3ZORnpRdEZDWk1Wbzl1ajBjLys3WGl2NFBLOUJYaEdWcFh6S0ls?=
 =?utf-8?B?WlZuYmZEU1VocXRPSXcrVnNQZWFwRjk3ait4bHdLMEVMRHBIMklLSlFGZzlp?=
 =?utf-8?B?N2EvU0VrMGtNcitsWm0rVFJkcnNhcmdxOHB0UHErTjltditLcHBCMHVvR0lR?=
 =?utf-8?B?NkRQMkVCR2FweWlaZmRZcmtoTUM0ZmpLWWMza3BsVlF4WGlFNTlXbHhwUmlt?=
 =?utf-8?B?QkRXUHlNaDlSbFd0VkFja2V0VVhwZ0EzbjZ1Rk5LNlJneldSZ0pNQUJuZVNS?=
 =?utf-8?B?cWxTUzRFSCtFRnc5cXhsbzRERElLQmw1YjBHV1J5Ukk3YmMrUnBRRDZaQWRh?=
 =?utf-8?B?TlRianZVRFVsTE45cDhaWmJxTlljQ1ltWk5VVkduaTQweURPcFFGWjhNMUFW?=
 =?utf-8?B?SDhubDlaYkJzT2V3VTI4aktZQkJ3RGl1enJpWDVmWDQ1cEdkL081N3dzUU0r?=
 =?utf-8?B?QmVhTkJlMHZqRlpKUFMxUXN2elRiMlpUYzZIamgwTlZhai9Tb3FwOGFhNnVq?=
 =?utf-8?B?ZnJGalpsUWJoc0tSdGI0bjgxYU5ENUNiOFhWU25ndGcweFAwdnFqSW9CbmYy?=
 =?utf-8?B?RXdVRytwYWg5V0pQckxFbTc1NFpwS3R2cHNIb1VYY0ZiZEJ6UmxiKzdFT3Nv?=
 =?utf-8?B?dFN3cFZyZXJsdm1kbnhIZFd2SXg2UGZ6QTRRM0hKeFh4WENCYTZSbzc0Y2RJ?=
 =?utf-8?B?bmI5em9WRitzSVU0ckdpaEswaG5ZbU1uWG9sTDVNd21BTmQwNTJlQ0h1bUtP?=
 =?utf-8?B?d1F3Rkg1VUtYUEhwZm1zTUVoOS9ydFlQdC9mZ0h4RXd3NCtiY1Y1Ynk0WUp0?=
 =?utf-8?B?TmJ3QXpwdzZ3QTdNc2dmUHVZV25IYWVYN0ovV1g2RHAwOEpnSWh3OWlOT0xt?=
 =?utf-8?B?UjdPOVNpcmtGNWJ2MGhoOEFCaThtL0RjaVRDakY4TVRoSE1idE50N0ZyMTNh?=
 =?utf-8?B?UWNGUi9aeVgwVEVBOGs4MS9tbkZoYXErbGVhZFFnWWFGb283RC9tdkxjTXVw?=
 =?utf-8?B?OUxUSmN0cW5CV08yM3RNd0cyZm9zUXZGbVQrYVFhdXFmL0RrcUpSRmxVR3l3?=
 =?utf-8?B?SXVHYVZZYkhiT3E4bEs4a0g2dko2WjBZRUl3WXVmWmpGdnI3Qkh4a3hNaFF6?=
 =?utf-8?B?NUJRYUU4UEtWWlovcUdaYUNXamgrVmphbC9lRy9KVFlqeXFaeFdqZnUzNTVN?=
 =?utf-8?B?QjJGa1RMRlkxQndMTDJFRTM5REh5YUtMc2VYUVFZSWV0TGtCVWcvaU1lZUNl?=
 =?utf-8?B?UmpZTzE2WG1pOXlKNFh2U1hFY2s5SjREVHNkMzhCZTZRUnFBallib0tTZnc5?=
 =?utf-8?B?SnM1YXdTQ1pCQWNKa2pnanhKSGhmY0hXY2xuNmRobUZGNHVWWE8zS2Z2a0ZC?=
 =?utf-8?Q?8JxzprPsQB9sdOUs8X/wRHs7SimlY2W2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjNHNFN4Z3FRMEZ3ejhLZW04YkU0RVVEMHorS2w1N2dRekgxOWdlQk9ZOHVK?=
 =?utf-8?B?emNObWJhL21PeFI4SDB6c3R2NzNMS2VOYmo5M1lLd1ZyZmhiSlA1TDNUeC9K?=
 =?utf-8?B?amF0dEJVL1NKYW9oSUlsNTQ0ZmRVUm52NnMrdEdOVFNBMDd2TFd3a0ZhaldG?=
 =?utf-8?B?VlVBQVNLU3lmV016SmJHUHc4T0RkbU1UMHZ6ei9vNFMrOWxla0hXSjI5dW42?=
 =?utf-8?B?cGdHZjNUM2Z5aVRNRDQ4SGFMM1EvRVgxcjF1NWpXc2xKQXF3OVlUeDhSNnBi?=
 =?utf-8?B?azcxREFOeWdEK1FQQUUrdC80SDhlSStEN0wvNEcrdlhaL2hoM0NEL3JjQUlr?=
 =?utf-8?B?dXRFcGRRbFVTRElsNFkvZ3o1U0hpRGpqcUVUL3NHVHFQYzR6ZDBXQWRlem96?=
 =?utf-8?B?Rzl4UG5GUDNsS0lQY1piRTJkTDBHaVY0dTd0Y2N4L1paK1pUcXhBRUUvK3p1?=
 =?utf-8?B?WmYyUmR0djZ4MXlORmVSU0VUSzJ4U2N6RUYvbjYwWFVCWkFnYy9NdzNETlRu?=
 =?utf-8?B?QlhySUljSUtobW44UEdHZE9KMENGL2F0aDdHNWpqeG04Qkw1T2JYcWViTHRP?=
 =?utf-8?B?TnlEUFZyU282N3l2S3pMeCsycW5FeExvM3BSUVE5VU94alhNMnFEU2R3NGlw?=
 =?utf-8?B?cmZGYkNvdGNhNGliMUc5RFpJWU5hbnB3dGNxTVhOQ0UwSUhvdldtN2p6bzRn?=
 =?utf-8?B?NzU0WE84ZWg4ZEVaQ0ZJY050bm90TXZJWENPSEpxV2RUL3VsaCs3RGZJTVdk?=
 =?utf-8?B?Tk56UnRzN0kwSG5ONHhCbWhtUnpHQ2R4Q0hSeUpyNFgrVXBCQ3habzhzNDF2?=
 =?utf-8?B?QkhtNEFaRDg1Z1drcUZ6NG5oOEJtdU5JMkIzeFlpek9Ub1BDNjhrNk5qU2xv?=
 =?utf-8?B?bXRJdms5STB4MDFVbHJLZHBnWjZ1dDR0SFYvU24xWFBJRkt5YS9SeU1haElD?=
 =?utf-8?B?VmwzZkoyMHkva1E5a2lBaFB3MUNkcGJacHZYZTI4WDl4dTBmalgycWFwU0d0?=
 =?utf-8?B?bnlkeGlhb0NST0YxQmwreTRCZ3FXSXlNUER1WXRyemRMT1ZGVjNic3NJQUFr?=
 =?utf-8?B?cncyNlplOThBTmdScnpHcjNta1RqTWpyYzIvenlqQTdCYXB6NDlxQzA5YmJi?=
 =?utf-8?B?Ylp1U0ZrV1N3M2FpSGVtQ053QzdkWkNreVZndTFubFZDaWdubHdPZVBGYk5m?=
 =?utf-8?B?cXhoZStKcGhudHd0RTR1Ukg4MG45OEJUUjFhN1llSzUzQ3AzZTJWcTQ3YUZv?=
 =?utf-8?B?NjhXVE1mZjlSNDVpQUZBNkV0VW9lQVIrQm50a3VqdW5Xb3NnbkM1aFNTYkhp?=
 =?utf-8?B?TjZyMXZ6aER6b2JjQy9hWlJCMVRVeVl0L094dXdPck1JSkU2TmFrL3dtOWw3?=
 =?utf-8?B?Rkxsdy9HME5nMmp2NnZvMFhzYkpiTDRDU21pWjhhQ1Z6dTNRY3NacE5yTUww?=
 =?utf-8?B?SUhLNHRPZlRHZnVwZ1pZcUd4ZmNKMWJGVmZaOFZQckIwSzQ3eHRLZWQ2OHkr?=
 =?utf-8?B?RG1QVkE4UEMwV0NVY1NVMjhRVU9pYzVwNExwdjM3czd2S0JmeWhzY2grcnh1?=
 =?utf-8?B?ODZ5VkFMT2ppek9EN0FKQ3ozcmxIS0o5ZktFeE96ODdjdm1QYjdzVTJGUHAw?=
 =?utf-8?B?bG9STnpxYVJWeTVBeWhxYnZuK2JWRjVEVlorbTc5SnJRMWFuQ0I3anFuZ1Q3?=
 =?utf-8?B?Z2VadDE0Z2R3RERuVUgvSkdwaXUvOEhQUVN1bWlhQVBFSHpBRTZCOWFCU0ZQ?=
 =?utf-8?B?RnNZZGhVZVZKaUtYTEFjVzAzVWkxVXFWYnlrQ1F5Tlc3VmZQNnhTeGFKaEY2?=
 =?utf-8?B?bkhOL3ZoTGR6dTI0NVpHNHdBZnFuREUrM003SkJrNUdoc1laZmIycU1UVFFi?=
 =?utf-8?B?V1FXVU5uQXVpWXIvVkZDMVJqdlZhMHYyZ0IwVGlUbEFWd2txbU51cm9RMXZ2?=
 =?utf-8?B?UnBLa2FPYnlkYlRFZkVqN25iMmlTQUI5VFZNUTF6NHp5d0tlQzI4Y1duNVhw?=
 =?utf-8?B?NG1pdk9tRU40S05XT0wwVUN2QnVUT3UxeUdoYXpVejR4anN0WWMvNWwvNDRl?=
 =?utf-8?B?SXNNZzN2a1p5Wlh0UVkrK3VFTjVDaWtUM0NXc0hMN2xzbVZaZUE4V2orVmo0?=
 =?utf-8?Q?PW0rCxj2Wx/B3NQF6ySyweG9D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1717620-4605-44a5-b39a-08ddeb9f9fcd
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 10:41:37.1193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ey07NEyxkle7L9pN85onUzisqFU8pAlp5qdEU3Y05mO3rwePZ0hMO0FZ/vfqTujGrZRZZRKk0BtBOxdWkv4NNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653

System Manager firmware provides API to dump board, silicon, firmware
information. It also provides API to dump system sleep, wakeup
information. So add the interface for Linux to retrieve the information:

patch 1 is to add doc for board information which was missed before.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Changes in v4:
- Patch 1: Typo in commit log, state the attribute is set to 0 by firmware
           add NOT SUPPORTED return value for syslog
- Patch 2: rename to scmi_imx_misc_build_info_discover, add -EOPNOTSUPP check
- Patch 3: rename to scmi_imx_misc_cfg_info_get, correct command order,
           add -EOPNOTSUPP check.
- Patch 4: correct command order, add -EOPNOTSUPP check.
- Patch 5: correct command order, align command name in doc and driver,
           Use u32 for consistency, add comment for sleep record.
	   Add a comment for iterator run "saying propagate -EOPNOTSUPP
	   to caller".
- Link to v3: https://lore.kernel.org/r/20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com

Changes in v3:
- Add R-b from Cristian
- Store size, per Cristian's comments in patch 5: "*(ipriv->size) =
st->num_returned + st->num_remaining"
- Minor change in patch 6 to add size check
- Rebased to next-20250826
- Link to v2: https://lore.kernel.org/r/20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com

Changes in v2:
- Add more info in patch 1 for documentation(attribute is reserved for
  future use, boardname may not align with the board name in device tree)
- Drop dump silicon revision API
- Update discover build info, cfg info, board info API to be only used in probe phase
- Update to use single sysfs single value for syslog.
- Link to v1: https://lore.kernel.org/r/20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com

---
Peng Fan (6):
      firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
      firmware: arm_scmi: imx: Support discovering buildinfo of MISC protocol
      firmware: arm_scmi: imx: Support getting cfg info of MISC protocol
      firmware: arm_scmi: imx: Support getting board info of MISC protocol
      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
      firmware: imx: sm-misc: Dump syslog info

 .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 194 +++++++++++++++++
 drivers/firmware/arm_scmi/vendors/imx/imx95.rst    |  24 +++
 drivers/firmware/imx/sm-misc.c                     | 232 +++++++++++++++++++++
 include/linux/scmi_imx_protocol.h                  |  23 ++
 4 files changed, 473 insertions(+)
---
base-commit: 8e5b06f3b616530c57cd765b769c5ce54aaa6da7
change-id: 20250627-sm-misc-api-v1-85c030c670c6

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


