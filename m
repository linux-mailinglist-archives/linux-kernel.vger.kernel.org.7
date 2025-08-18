Return-Path: <linux-kernel+bounces-772679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6517B29604
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 03:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB2AB4E052B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 01:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A5173;
	Mon, 18 Aug 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BKn8Gvkt"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011069.outbound.protection.outlook.com [52.101.65.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799FC20DD75;
	Mon, 18 Aug 2025 01:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755479682; cv=fail; b=ZQkN5VhwI39oVZzlcxx+AUCtpEzrk+ZhD50FfV8LoQjbEE4ENPZFhAvZAcwZ4zm4yfaO9oXEmdEMNgRQkdRL2aYDQdP2XYYJ6BRMMDXjlaEAp8/SflfHAdJ0lBn0zYCv0lFvnlq72AKiefLbD8xCKuhuZ9C8tsf1E8X1lbTYuHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755479682; c=relaxed/simple;
	bh=3ZdnAdlWl0ncJ28rPOTrcTUUlE7GZKHT2PU2flpfCXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bx5oJb6/Sckp5Y0IppX2vnNCyvRmYbJHOlJAiZFELnTolo/Go277vJCUX4Rr+wZTCciP7Z+TA2yl2IwH+cXB9CbiTmV3f4vR7FoMbOW/MPR7H+2nwHlXEn7UUQthbXsswDcj8O7fnrRwT0UZOtNMOvCWYQvllrO7iVBc/dBTPKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BKn8Gvkt; arc=fail smtp.client-ip=52.101.65.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqdQeWJTJq2zeMHJj5K16ZElWJ26rffa60yb7bVMfACszTqIxTQ3Aittqvxk6Qa9dOZPoF8MIdBtAGUY+st+IuruESkcZh3tTpLBF0JVS9R4n82f/ZpYCS5F5ekBw65iRWnqrwmnc0t3w1RK9P+sJe6GhKIm7CB3P6Rb5luY1ykf52W2mvIMx5jO3w/tL1m080rTBD2yziGQSlOc5ZAXyQHY6NOaf9LZlz+wSLhg2XJUskuXI+Var5E1okigTxd3PPNLZtwIfJvm6qjMUlHNGTxONs/MQ4WQkUdgrdCkNhWLK4b0CFDvsXmv8Pqc76SWjkWoeZM/urMZMXD3sRWATg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNAjdt+tAKV8prZadxFSEbhS1EHBUUEXfheSOQ2bhUw=;
 b=Ism9QOsLjkk7+H11atE5Bkp0uUSW6u6r3BKlv+NnDzoIvQPe6fH1Y+utwSBmDsQ+v5iXyX62GWb/hlb/smwJiDwewvaq8QvOf2XT/wRLbK7/Dd7fMP9V3RgZNHyGichgPF1TKxvC55WtoGyWQ5KcgIDp4PZdoAMqFseXd0HzZXdyLBwWFNgAQGBla6DCYcoG2ATUCMASITRjClr+yGLZ050yf/s04Dwl1IShpp1HFXD6KD0RkXNz3Ofjcey51GN9phhI9/eMxscgNVJrE/F9U0LHlfBLMSicq7ndZd3PrBfO+Qw0U8Lk3q4jTh2HXXNg6dsEFN8NP3VtZSWSpnIrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNAjdt+tAKV8prZadxFSEbhS1EHBUUEXfheSOQ2bhUw=;
 b=BKn8GvktgGMxNTbcnr2G41mYUa4SRDufLsPZT45p+6rpOk0+CmiG1YiXHPR6o36H8R/U3YBJWIg4iIdMpvqQ2j05OIE3SVlps/BmRDirXf2q3JMrtTY7YTgSI+OytJL1f5xXNblqHcGEmhIum418mAVb/oqFyyRRme3Q6gGOm+mrzvNTbgqnyBC6uq6LFF5FkLPjP37nwCDkdJRRqaXUZoVMR9cVrSgQjuzboIx5nD2lObgY2ioDnPPNtJ1SSTuS6cdQIfqIeL1PenIjoF22Wvp45AVA24O4ttgipUOoD4qkW/9b8Y2+6L3zwwcm/dHyYtLejv7PG4/Na1ed1JvMZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 01:14:37 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 01:14:37 +0000
Date: Mon, 18 Aug 2025 10:25:35 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] firmware: arm_scmi: imx: Dump syslog and
 system_info
Message-ID: <20250818022445.GA13772@nxa18884-linux.ap.freescale.net>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR02CA0125.apcprd02.prod.outlook.com
 (2603:1096:4:188::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f650329-fae1-4782-40e0-08ddddf498a5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|7416014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iYq9otqWjsAe68JHIqMV3JBnHDevq6t73PMufAPYb2VpiVrLsyCuhGM+J7Ba?=
 =?us-ascii?Q?7YnAmXHFXbAT230LubqaoEA+MRcMiSbY4tsZPMlkhUXF0wrtld4MYpnuudfE?=
 =?us-ascii?Q?UP+55oBBYBGXyH01bff40A5I/mps5aFZDmMjA19SeLYgBes0g9gN3neNQ8aj?=
 =?us-ascii?Q?4MynpkGn1WfxuxntrP+eiGIR5hYamndoP1LaL5mEs75V1nPDRIL/DxKhP6V5?=
 =?us-ascii?Q?iCLmcByQOIoUbwb3lQszOIBtXDBMfOoeXJ3wrzIxqsEtbN2kQI2D53tcgu+8?=
 =?us-ascii?Q?+dfnrJi//VIqpfIuWXrbSg+pDvg0IrnXdK7UPaYL82iRZQy/f+gYZdjy4kRW?=
 =?us-ascii?Q?1F2rpDw/USIyHk82a3QnRlGquAFUezpEWsQk/e5OdEpeXbTO6V6K2j5mFvxx?=
 =?us-ascii?Q?JQwUw3ps0zCoXGigeK5tc4SvxG/cZL46jW4iPEC+w4fbjz4hi/a+EQJQP1CK?=
 =?us-ascii?Q?cD2UZe7vaHqhko0FJ6ksP8sGLk6fiyt/ptvxMXNubzZqTaQCAztFakyrEW/z?=
 =?us-ascii?Q?vFhMPSNd6nYrMp9wJim8dCK1+da/62Z4a/HXiOLPZ/vhyzl5SdWOO/bPCM84?=
 =?us-ascii?Q?zXygJQPRsr/5zh7UxXgfgvL7r6YKupneJx+KbwNxrYccIkfMmkearloUdWzl?=
 =?us-ascii?Q?x9YTNEe9KsQt8sarelYCVxeApqqnQAgIPQgQq87TKubiuqYHT4fBdgJ/jc5i?=
 =?us-ascii?Q?VM6RE5pkqY5itH5RTi5XhDuZhIddvuMubK4ajguIEdN6lIy/IOUY/KX52ZZu?=
 =?us-ascii?Q?wFtwfoEf8PKEhTIAqPJaG5GdKHrvtqngZJr0Z1CWF8uW/EDXCUrzooFNSV8h?=
 =?us-ascii?Q?mkX6CMxrTPV8Bm0HUOlByvUTOPagfxOfmsrcJr6rqGus5wTJuiAp2P3F6X3j?=
 =?us-ascii?Q?a1euKDgSHgnZ4TcBfkRKZdfceIkVUKIk4zE28kBC7rD2zyV2nlgBQpP07RGE?=
 =?us-ascii?Q?c3SWQvqn0YQ9sT6m2xUC5WAvZzQIyaad8bbz4bLnrZg5UOEGqhjg1OLR4OEU?=
 =?us-ascii?Q?Hq5R25btpwDO5vFXrtOrXA5xYXQiSm2IOolwMb5PTNauIP9kU+Cpw0PrpNwB?=
 =?us-ascii?Q?4HmvErRSXqsa/DDQ8IdPWigGR0WGmvenrVgH202Oo4SnaUm8JeBv7xGdgRPG?=
 =?us-ascii?Q?QPzxF+L91DUAQNePLeealp/bs8Aq77fC4zEnR1tB10Hi3whygXyc/+TB0YHg?=
 =?us-ascii?Q?E2cNQ7YUcsN1WIhNsRkQXV2ZC6Cm3WRDJ4BhZ8Mbc+kRrnt7uFsgv97I3JPd?=
 =?us-ascii?Q?cQYfdXTCesUl1txQco/kqS/iLLLp32evdc27JgTVOJt0e/BOeJXmlUwhJhkl?=
 =?us-ascii?Q?dsIyHWfSmelEHbGZPoBm0o2Sf9QZmtbHb8NG2Iig4WAnOU1wrg6ZjQu72Fb+?=
 =?us-ascii?Q?Mjop+/KwYYt7oGKPdMtpvhKlMXhAWV6mKYfMSN/umiTkOrwdn3GOu1g21sld?=
 =?us-ascii?Q?XYn0c7T3ElY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(7416014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8VwPROu18IB4gYAUptkguPPu5LQ8vefQKCkWCDW5cE3XmnpkppN4ntBVZy7b?=
 =?us-ascii?Q?LdEi/PcECbQzTjBExZYJVhhsWsx3wP0YhAYgaDSpvIrI4DdXOr2tS8/GYxYz?=
 =?us-ascii?Q?mQqco5SDlWssl86ltbxgoE8lX//7zZpw7GotQv8v1EibOPXev6jsxH8sXYkD?=
 =?us-ascii?Q?a6wlaOGPeQ0uF7CipSORuK96NoETUc0EdHd5Qvqw4DHdK9hrZ99pHApMMBC7?=
 =?us-ascii?Q?ipf8gV/dgIXW6UyIlhe4Xr1kLl6ExozsKkhPGk5sd3qiD9Ph7x8xHw2XkRtE?=
 =?us-ascii?Q?tLN9ekvSDxPHhc/xMqs1CBqbU9NeWrhYRtPdnj104D1BSHAGVZvKZK4Qky2l?=
 =?us-ascii?Q?jCRFc7/VVeVNdGRi/Z2JjmvhFieK09IWzcNG661uX9XZYEZZIU7yNjiofhfF?=
 =?us-ascii?Q?AZ9yvMreO2S4+NbVcyIQZZQ/4b/Rv/+eJj1hNycoYjWBd2yw1PCXQHzXXHfB?=
 =?us-ascii?Q?4L6ui1TuWPjz23UNJxR4SMVojDRXp8QmTfCOIoN80nA2JuqhXjZxv2OvCQKL?=
 =?us-ascii?Q?6flIGE7eWmS4xiIJhtcBG05Ks1gPlYK4Z0suKk2jx6UlF0+YH/gK7f7ql8gR?=
 =?us-ascii?Q?jZXXMOW2uhdBrloubQaLaZr+HZnzkTpThaYBJUBQkd3YS5s1H7StAjN8bKot?=
 =?us-ascii?Q?AgAU/Gfes6f7iuCnSt+1HHIdS/tJ8K/vsZ4EoTMduVGakCOOU23OQJouZPax?=
 =?us-ascii?Q?G/aJ0ZKixubuJiUcFyKVTXkdQVAjEPsGlsJaEfvmeZTfwSKkdqjScNnGVgNG?=
 =?us-ascii?Q?vJlNVPpBrJYZucchlJvoYk5P8UNgt3Wl94bRHuLQAg5V8b3T5SLr3F/nCcLJ?=
 =?us-ascii?Q?JV65mZ6Wzah4TFEAUCPaVqscS2JJOfahicYjA8dt55UzpEvBDY09hpuTbhYP?=
 =?us-ascii?Q?B4MtgOxuwqV5KU9TQ/u78J0jcPGf7cP5srl6aUv0CpPsDuvyiP0uK+dMG/Bl?=
 =?us-ascii?Q?TfCL/f5ocR3LPeaJdvVcEOd71C08iMQ4+z6Jh6+jiL32wZGysJ7w07hSfkpS?=
 =?us-ascii?Q?THa6PXbLDKJEegKw6bv4IH65lWbAFsTskl7RoA2oidEacBXIi7NSpG1V3966?=
 =?us-ascii?Q?j+XZXmgwQu+SiSPYzgJVCLmb/FXgGl/+PANor3AN7RsCp2hh5yVStvWllZar?=
 =?us-ascii?Q?ifUQL4Py1sxmHugQzrhw94yXbZf4nyKJHwlbE5zMobjyy35SzYS+4UKROlay?=
 =?us-ascii?Q?ggrjdZq9cbZf4amQXSw5FgwtorUqK0sdHNI03zSB5g8bFuMF++gMs0lRl6+f?=
 =?us-ascii?Q?lmiVTVk2OjQwhTx2i9Ps0Qop/hz53yqH04tdxUqioq0JG04ve8YfCgi+SW/h?=
 =?us-ascii?Q?gMykG5XPO0XaAWTxH7ufluB1akaWK5DrdnZuQ7IhTaOjT2JQOJye/pmG/yj5?=
 =?us-ascii?Q?RZ09JLZSGeiQk10c0RdUfWrIiQIqx+gjY0T6Lfb2sP4gJ755bCqCt4fNBbM2?=
 =?us-ascii?Q?/6nMGuLDgUkv3boVZtBSNsffZubytcXBMAw3t054/MHyouDKdj6f5e6HH0df?=
 =?us-ascii?Q?Xj2g5v3kyM0WHSdSsq4+H8xq7iowjGJRc0+yKoKPw/YXRLQeAC3zHPsZ5O3v?=
 =?us-ascii?Q?1AeH6ViU/JKebCOOyYSM0YtNitw+nyzmeXo0qY4z?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f650329-fae1-4782-40e0-08ddddf498a5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 01:14:37.0038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kjlmy4sevDf3e4ZwHNwQ7VlNSrDsr2Yba70TWQJ4T95r6owPS3ydlChnbyU70giuk0Uwt0dhewVXGkSPkR8f+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189

Hi Sudeep, Cristian

On Thu, Jul 10, 2025 at 04:33:25PM +0800, Peng Fan wrote:
>Cristian,
>  I only kept your R-b for patch 1, dropped your other R-b tags, because
>  there are some changes to address the comments from Sudeep. Most changes
>  are only to dump the information in probe phase, update to single sysfs
>  single value for syslog.
>
>Sudeep,
>  I saw you sent out PR to Arnd for 6.17, so no rush now for this patchset.
>  Take your time.

This patchset was originally submitted before v6.16-rc6. As the kernel has
now reached v6.17-rc2, I would greatly appreciate it if you could take some
time to review it when convenient. Thank you in advance!

Thanks,
Peng

>
>Hope I not miss any comments from V1.
>
>Thanks,
>Peng
>
>System Manager firmware provides API to dump board, silicon, firmware
>information. It also provides API to dump system sleep, wakeup
>information. So add the interface for Linux to retrieve the information:
>
>patch 1 is to add doc for board information which was missed before.
>
>Signed-off-by: Peng Fan <peng.fan@nxp.com>
>---
>Changes in v2:
>- Add more info in patch 1 for documentation(attribute is reserved for
>  future use, boardname may not align with the board name in device tree)
>- Drop dump silicon revision API
>- Update discover build info, cfg info, board info API to be only used in probe phase
>- Update to use single sysfs single value for syslog.
>- Link to v1: https://lore.kernel.org/r/20250627-sm-misc-api-v1-v1-0-2b99481fe825@nxp.com
>
>---
>Peng Fan (6):
>      firmware: arm_scmi: imx: Add documentation for MISC_BOARD_INFO
>      firmware: arm_scmi: imx: Support discovering buildinfo of MISC protocol
>      firmware: arm_scmi: imx: Support getting cfg info of MISC protocol
>      firmware: arm_scmi: imx: Support getting board info of MISC protocol
>      firmware: arm_scmi: imx: Support getting syslog of MISC protocol
>      firmware: imx: sm-misc: Dump syslog info
>
> .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 190 +++++++++++++++++++++
> drivers/firmware/arm_scmi/vendors/imx/imx95.rst    |  22 +++
> drivers/firmware/imx/sm-misc.c                     | 178 +++++++++++++++++++
> include/linux/scmi_imx_protocol.h                  |  19 +++
> 4 files changed, 409 insertions(+)
>---
>base-commit: e88d17c7335a917e98b7c65776cbe3358210e8ab
>change-id: 20250627-sm-misc-api-v1-85c030c670c6
>
>Best regards,
>-- 
>Peng Fan <peng.fan@nxp.com>
>

