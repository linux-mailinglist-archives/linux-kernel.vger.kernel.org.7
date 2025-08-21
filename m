Return-Path: <linux-kernel+bounces-779215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3986EB2F08A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F47F602363
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578C02E9ED5;
	Thu, 21 Aug 2025 08:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GdlNB+/V"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3019036CE06;
	Thu, 21 Aug 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763450; cv=fail; b=jlnxB49cG35WzKLO2WIZdhbsyHyDtghCoersKFqD7AXxmiQXtUewA8mmIHk1frW8qlE2KvfE9wABeivwp8o+7j1Wcerpn4C3Z+kAuFLJ4Rc4qHfUs4f72C+gL9k5zHhJ+e5NBbpwDbtWX3umxg7D7wCp9p6Bp4FI3WyemTrOe68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763450; c=relaxed/simple;
	bh=EZgseAZAm7rE95o/WIrBqMWfSmv3DqHspY7j3Opm67A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QaPj0CemuJRJCOLCEz+QsTkyQxoGaEDqT76Gu/SgYk6oI6aGN9hxq6juo5lKXixpDxVSE4O0Lpnl/rgObdFFhm4jxUhiDuq3mq+sHXY0ONCF1egUvVZu9OV2fTFOvlvza69ss39F2H3B0Jahy6h2tH01wEIhpL5fio6YKQPogHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GdlNB+/V; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNc2hhrAntqpRYPu2aO81KDbjq0N/ZVr0PbpfVUYERnTFIHPAKcd+1gX+4jEl8LI0Cgy+XvqVttgAwL8UxVBmxpPnkrv27FMwUaUwVVaeyCTQxpLf/MUzzboDmRfyRWCub63Ztt4fJAM1fXreyoFOsuU+ynNtMZMmo8LKY2onu6jSbuegSFUvekcVUsbh9cxGVFwnjOnkGH4vVxA6OzH73vIPkSoeY+yPXfWMqQrEd+hx40Qki2KhpTpHQhJxJLYqbPDFVJ6zPVRmF8v59yyoVqp3zXob9KXKd22vaNG0E0JwYedjP94d2j7QCDTeyglMUleFaBcrfuCYKmvgQs+HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1hCB7HcS2bzez3S37eGrymsQTBw9cIzkfsQShPc09s=;
 b=odjQfuOLrVWJ2tgJvJ9W2I1ndPZSiLt1CpDR5F1MLJRE0K5xWDjkGu4Ad/tHyxrucwyDNavkRGRaHTx4iatSZbrpqTJkzx6aRs+5OLeT9LrxlwXrxj3N+biVi2H1TdzNslTHbt+CRI6pLFsM4Ec6Nm0wn/R5o/UfupSPk50Eytf4jweWGC6XxI9udrntNHU4QPRzDt9klZg4kG9MMsiAeJ6oyFRX6qvj6rfosdi1sWDAnxCszLqqAZGX5gNiAZYE5/58M39mcL5K3fs0IpzVLxwTEoQCT8S9KEHCRbEWZZC/AJMIBWa+CdFouIK4exgqzQ8Of+VntbV8XYqzR+T2MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1hCB7HcS2bzez3S37eGrymsQTBw9cIzkfsQShPc09s=;
 b=GdlNB+/V+xU13lhS5IGmH6T76zE0/6p+Y7LBQJU+qMkI75yVa/N5J7Y4Pg01bWY59gMWPGZSb9sm+kmxP2KFc4W6P53IFIe9GKRLQwPtZIfUEHVmuJVpSvxB8wg/frdR7vbwThw8W78hgWSn5OF+XQncVwfDZDah6KOEALQrdNV5kOkfFScQ4Ukpzrk33SnnrJQsqX0W0vIFkEsp+JgAgwzLMUIMYDz1hz9UySkSceotOLsYi7ooNrRXNyVobOeoZqLVwaBeXgu8NKqTnOe39ofEV/rfFXOdNADpbwxmtHWSFPzBQ9WiD2KNBK90F1K4n+RaujW32abdDLyhvqnewA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB9798.eurprd04.prod.outlook.com (2603:10a6:20b:654::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 07:59:03 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 07:59:03 +0000
Date: Thu, 21 Aug 2025 17:05:15 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Sudeep Holla <sudeep.holla@arm.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, arm-scmi@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Message-ID: <20250821090515.GA19763@nxa18884-linux.ap.freescale.net>
References: <20250710-sm-misc-api-v1-v2-0-c3e953e34be6@nxp.com>
 <20250710-sm-misc-api-v1-v2-5-c3e953e34be6@nxp.com>
 <aKSv4NrDfC33Niqs@pluto>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKSv4NrDfC33Niqs@pluto>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:4:186::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS5PR04MB9798:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a263266-e106-4b89-1d68-08dde088981c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|52116014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BdhTJogwqCBcPHxW4PwU+p+ffDF7+gymabzfP7rcMlSc4bilrGdlGDko0HHV?=
 =?us-ascii?Q?lnUTZcUmse5uEHszdtasPbKFbmJTjfFswuu8UEgXH8BfY5VdWHPE03Wk5fjV?=
 =?us-ascii?Q?LA0srXfsKsVb67pPFAjOe/wpnhu097IruHwtOwtvPNcjI5mi0MrP7N5+FfDf?=
 =?us-ascii?Q?LXvlW5TFeoDPWf8qYu4l6YoFURKTB/OTa2nLk3KVW065uXEQi60Vsd8qO/vi?=
 =?us-ascii?Q?wKM4Xr7xR9u4509pSkF5Ix4QZLgi4wgq+EaJQc8C+pplfA+u1CVhtdEbhHvW?=
 =?us-ascii?Q?ghwfe79sUDK9FSHQ1DbHWH4yPL4WTM3JOUy7sFKcn2Tj03Wh4QWUapvCpLu/?=
 =?us-ascii?Q?vrhtlM2DMKE0VEZIhFZ1YAW5g+jQeLsqVVU5K7Zmj0wsc0UHg0gXajfm/ml5?=
 =?us-ascii?Q?TkEKmGRZGgZISwBdlNQVWmMzP9/y4UWpfKHW6WFrsKaX+ly5NUzhCbdX0QPw?=
 =?us-ascii?Q?GpQfjWf/25ff12+3eHYpSeeaKgAl5G2Bo8v7Wza8TwxwNDjiH88kitENLHu/?=
 =?us-ascii?Q?jnxeqr/lQr3L+RP8rReMRatd2JK+1yshkPZfXXXNe+Li2qGFZPma3TnaiDWu?=
 =?us-ascii?Q?HbCbw+89rNDfYxDK+o5LMdm5wj6Z9AYK3GNMA2YVQGyhyFx2Gj/8xsLrVvRz?=
 =?us-ascii?Q?lFBUWkdyKenGc322MrFGX0QUctmDgmcFDUnxIFBkOMABaY0Xj31e/Gnzwsfa?=
 =?us-ascii?Q?ivrf8cAzzvs6fbpRBKD5H6tY4myje8u7vIWvlW6I9JWj5SmfljTeoQSOqg6a?=
 =?us-ascii?Q?0MOGI5xE7xxvqjhvBlOLWEr6wnjcaVhPCSTmmy+bm/57ChdvqTsJXGG4WNAy?=
 =?us-ascii?Q?GDkGHBIKHIgBx23ow1Monr2O245k13dIVVNb1yrfPPA11CJ4nTsGaubAricq?=
 =?us-ascii?Q?huRfWEBfmxbgqKoJvz7CUnxPop4dBwjcVHZI7j8XH3AIujHzxMMmOKjs5aLS?=
 =?us-ascii?Q?PaNTJkVVbyfDj31JBDxrQifX3Nq93ZgYZLTCrTQKbqgpYstCguyCcGkCv5RS?=
 =?us-ascii?Q?S3BNQrtZGVAYqtGGC8SjyDr5rhdKnyC58uFVmE1UHj/r49bRVAEQtLxWFKm2?=
 =?us-ascii?Q?s40x3AZNoOCaAl8LSybVLlYEdpouK1TAIj2+KyNnR5jcbV7i/YCFluCjXWMw?=
 =?us-ascii?Q?oPavoppP5+dfcDOWYpe7BZg9+kR+R/PZn2MladKCfyvjZSfKFm8NRscXyCcz?=
 =?us-ascii?Q?2xMHXamqP1A1pwtIDRJAHQgcctyThsBTPxv0l75sjCMeen5RPgNKw6kz1Rsf?=
 =?us-ascii?Q?b13a6HPNgZMb4ERZDPROgVzuI6zPnaVP//BnLWu+VTowyohKzKVhibsfJdrX?=
 =?us-ascii?Q?49bO6OsfnZ5yHMV3bxQ0ryrMA8G0i+QLV0FJHKhR6u6lG2yfNIGSjG7MkbtD?=
 =?us-ascii?Q?mmSG73q0wSmdZTf2mqmPtpnQ+YHYqshTzs/XjSfQbjJh04YO4Sl4G4ltv3yc?=
 =?us-ascii?Q?q2iWdZ1GD2O44lZoGFc/2QnGi6dngILrIib6phR6cbB/VwWnTMcsTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(52116014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yj94LCOaM97VPb2luc2J81mwGClra0lijx7bdQ/i4d5mDGE+g7ikaq8WsHwH?=
 =?us-ascii?Q?zdq72FrtFDOJli7kO44Qah4f/kXFs+z/h8/R6ji1tGEDGNDIbACAmNUHGWwZ?=
 =?us-ascii?Q?6HIUj8DK7tmXi3NCNIjeUvXV0XJiX4rzlkZpYwgu+PN/HbKF53V6jQ/I5iVS?=
 =?us-ascii?Q?/dj6MQLQUnEJL9LBM/q/y+GzV1yTMWJzf1ej0ahFrpcR4jZim3mChVqVw3LD?=
 =?us-ascii?Q?LDu6HjatqIAUpMJ/Q2XxqwjVFMn4R6gFck578G5gQyTR69FbD8CSeEY9OU2h?=
 =?us-ascii?Q?Y9UHU/58gZ8JeudAm5xDakjKfUi8amZyaeaGRGeTF8XE6kGWgMNJE92jrlX/?=
 =?us-ascii?Q?DeiTf30h/CCDDAzByt9TNmk6IL69N/HGERxCE2ih7H5aCmLYOsF7F6LYdNSn?=
 =?us-ascii?Q?jbvkOyK5eXhEmr2i9lZIoz+2Ij8Y7JlE+qAJlyOf69DLbluoCZ96CPswxBCp?=
 =?us-ascii?Q?Qu8y1wkVOIvTAMP6UxP8v6WNIcuYoaAk4qFJu0PxshSBFNSwtjWwbdi7pwZQ?=
 =?us-ascii?Q?H08RkG1+nTUUxyseXQdQFkpLMSruAtNf+aZ+vhE9cQQZu9E5tcjc/RICS4hR?=
 =?us-ascii?Q?rFp9NbFnVUGjdByP5f5q9mqZd5fv/IePlFfUd+tM3NXSBDdDkrSqBR3IgPZF?=
 =?us-ascii?Q?B4zPf0TaIAO7Lk3JgSw2H/CE8rMHJLuC2xZRVWzGdAXrJrHcme51qJdUZH3Z?=
 =?us-ascii?Q?0cKigXzuzheD6m04pOKB5LQKL5sv3p/fOguc8q/AzhyKwmrSyenerZU4mj/7?=
 =?us-ascii?Q?ENAfGVAtgAZdZo0YSBjtB/PGmtUkKd2zgNyW5aZ5+x61EZNK62+0q6niwtlm?=
 =?us-ascii?Q?ahNV8xtsFrpm1Q86oLOvf8zVBSts52nh802UbDp95/59Ttikp1O0gJTm0jIZ?=
 =?us-ascii?Q?gPV8/jVYtcuLn9/aeJA4AefQDuyNVstDp49+lMOcUHyV9H+mYzSrI4j1Kt44?=
 =?us-ascii?Q?5IIoDqUX5pvFbUoUAbwx92/zm/f086h+IjZ7+YUchW+sNVqzgV2A77hb9bBE?=
 =?us-ascii?Q?xtBfO/RxCV8cBC2jjVrrQ9SMnNxkwQc6VjQKsNg6+QIgrpri90w60PwcQAoD?=
 =?us-ascii?Q?1qtFqbkxRwXqNEhBLDxmnue+9lzQuRPWVrkV0ISIvQ4jAXJ7xdK/vog20sp5?=
 =?us-ascii?Q?8fkBk+Y1vD1puaj3HVA3ghYa21zt5zxOWh5nwo/enDTUjcLnfH9MmhCcFE9q?=
 =?us-ascii?Q?kmNTG1gmDSRLgZSZ9HdwTndnHyEREM7hpoDDSVVcuxT1HUmLTXJh1V0E7UX4?=
 =?us-ascii?Q?XgYnXgHVprijFYdPa7DDYQMeZE3SSNQaWBCI9+tjbIKo5ijU3EzcG5zkn4HR?=
 =?us-ascii?Q?XFdDsta/l7s2weUdVw7Muy7vDyLLmxgonGZ3C0Vnev8TVwhpS+PuieDYLdCV?=
 =?us-ascii?Q?ioqXb0KokE0w6loczWYG2KgoxokikyuCTbAkyExvhdymcc6qpo2nQbM9tV3g?=
 =?us-ascii?Q?xuBA0ky5VRYBkQkFc9IxPYE3CHEq4XH2xxYMsYREf9H1oiRVgtXnczf5q+gR?=
 =?us-ascii?Q?A46pyemvW9/smzvrNcY8uTD0wpoM9YtQVNOLZPp73SE/T+vMR53zJ733KRiF?=
 =?us-ascii?Q?lTfsTOZ2bseMUS+I2MeTppmXg3mrzxKSD3TpoJfR?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a263266-e106-4b89-1d68-08dde088981c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 07:59:03.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5snDTVsurJmF6xIHvJztYifudz6OYwP4XbaOHXPF2yCPFBxC2pdTg5WcVBKqP+x+XXae/yYo4eqEfGfMf6VkYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9798

Hi Cristian,

On Tue, Aug 19, 2025 at 06:09:52PM +0100, Cristian Marussi wrote:
>On Thu, Jul 10, 2025 at 04:33:30PM +0800, Peng Fan wrote:
>> MISC protocol supports getting system log regarding system sleep latency
>> ,wakeup interrupt and etc. Add the API for user to retrieve the
>> information from SM.
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../firmware/arm_scmi/vendors/imx/imx-sm-misc.c    | 78 ++++++++++++++++++++++
>>  include/linux/scmi_imx_protocol.h                  | 19 ++++++
>>  2 files changed, 97 insertions(+)
>> 
>> diff --git a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> index 6b86c35c192d02e13f0d2a7d713bc447886b84bf..193a862cf9b807232f04a6dbbd6a8efd1b40ff73 100644
>> --- a/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> +++ b/drivers/firmware/arm_scmi/vendors/imx/imx-sm-misc.c
>> @@ -27,6 +27,7 @@ enum scmi_imx_misc_protocol_cmd {
>>  	SCMI_IMX_MISC_CTRL_GET	= 0x4,
>>  	SCMI_IMX_MISC_DISCOVER_BUILDINFO = 0x6,
>>  	SCMI_IMX_MISC_CFG_INFO = 0xC,
>> +	SCMI_IMX_MISC_SYSLOG = 0xD,
>>  	SCMI_IMX_MISC_BOARD_INFO = 0xE,
>>  	SCMI_IMX_MISC_CTRL_NOTIFY = 0x8,
>>  };
>> @@ -89,6 +90,19 @@ struct scmi_imx_misc_cfg_info_out {
>>  	u8 cfgname[MISC_MAX_CFGNAME];
>>  };
>
>Hi,
>
>one consideration down below...
>
>>  
>> +struct scmi_imx_misc_syslog_in {
>> +	__le32 flags;
>> +	__le32 index;
>> +};
>> +
>> +#define REMAINING(x)	le32_get_bits((x), GENMASK(31, 20))
>> +#define RETURNED(x)	le32_get_bits((x), GENMASK(11, 0))
>> +
>> +struct scmi_imx_misc_syslog_out {
>> +	__le32 numlogflags;
>> +	__le32 syslog[];
>> +};
>> +
>>  static int scmi_imx_misc_attributes_get(const struct scmi_protocol_handle *ph,
>>  					struct scmi_imx_misc_info *mi)
>>  {
>> @@ -372,10 +386,74 @@ static int scmi_imx_misc_cfg_info(const struct scmi_protocol_handle *ph)
>>  	return ret;
>>  }
>>  
>> +struct scmi_imx_misc_syslog_ipriv {
>> +	u32 *array;
>> +};
>> +
>
>So, AFAIU, you basically use this generic u32 array to retrieve data words from
>your FW in a generic way....
>
>> +static void iter_misc_syslog_prepare_message(void *message, u32 desc_index,
>> +					     const void *priv)
>> +{
>> +	struct scmi_imx_misc_syslog_in *msg = message;
>> +
>> +	msg->flags = cpu_to_le32(0);
>> +	msg->index = cpu_to_le32(desc_index);
>> +}
>> +
>> +static int iter_misc_syslog_update_state(struct scmi_iterator_state *st,
>> +					 const void *response, void *priv)
>> +{
>> +	const struct scmi_imx_misc_syslog_out *r = response;
>> +
>> +	st->num_returned = RETURNED(r->numlogflags);
>> +	st->num_remaining = REMAINING(r->numlogflags);
>> +
>> +	return 0;
>> +}
>> +
>> +static int
>> +iter_misc_syslog_process_response(const struct scmi_protocol_handle *ph,
>> +				  const void *response,
>> +				  struct scmi_iterator_state *st, void *priv)
>> +{
>> +	const struct scmi_imx_misc_syslog_out *r = response;
>> +	struct scmi_imx_misc_syslog_ipriv *p = priv;
>> +
>> +	p->array[st->desc_index + st->loop_idx] =
>> +		le32_to_cpu(r->syslog[st->loop_idx]);
>> +
>> +	return 0;
>> +}
>> +
>> +static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph, u16 size,
>> +				void *array)
>
>...and you provide a output array param and its size to use in the
>iterators to retrieve your data...
>
>...so you can use size to properly let iterators check bounds...
>
>...so far so good BUT...
>
>...is it not a possibility, especially with different FW versions in the
>future, that the platform will return LESS than size data, because maybe
>different platform can return different log data...I deduce this from
>the fact that you are using a generic u32 array...
>
>...so in this scenario wouldn't be useful to have the above size param as
>being both an input and an output parameter using a pointer ? 
>
>So that you can...
>
>	static int scmi_imx_misc_syslog(const struct scmi_protocol_handle *ph,
>					u16 *size, void *array)
>
>...use *size as the max_resources for iterators as of now BUT also pass
>it down to the iterators in ipriv->size so that you can easily once for
>all in prepare_message
>
>	*(ipriv->size) = st->num_returned + st->num_remaining;
>
>...so that you can KNOW if the specific FW has returned less items than
>the maximum *size slots provided in *array ?
>
>I maybe overthinking...and also this scenario will assume that the FW
>can return less items, BUT still contiguos items...i.e. no holes in the
>array....
>
>...thoughts ?

The current platforms that deployed i.MX System Manager firmware use
a fixed log structure and return them all when input log index is 0.
But you bring a valid point that the firmware may report less in future
or new platforms. I will follow you suggestion and update in V3.

I would send out V3 in early next week. Wait to see if Sudeep has
other comments.

Thanks for reviewing the patchset.

Thanks,
Peng

>
>Thanks,
>Cristian

