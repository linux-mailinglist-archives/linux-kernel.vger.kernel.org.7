Return-Path: <linux-kernel+bounces-824889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA8BB8A608
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254515A038F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650D31E0F2;
	Fri, 19 Sep 2025 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BatBobeS"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F27D31A069;
	Fri, 19 Sep 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758296742; cv=fail; b=WPEBDNwRjPDeaSw7q7OJEdyZOfzvdiCe/cRGW4z5iNofwBCayuXgEyNs7pfvBGW/6P77mBa4yd47i6CgXUbJdydQgKvIwtBWdD+vmWVcsHrz9FedY0VynNihd8Gl+pbGk6ST7wT6KH9Uh+qWWiyfYHaLb2VGNIKpaHsTXwQGwUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758296742; c=relaxed/simple;
	bh=SYpu5B3LWLie8bMmlHYRDpNOG3VPnYPHyDYkbakvhCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oFAo7jN9iN2YEGXMa2wxBc4kINuozAyUPUiT1sXosOLl6FLSJ/Qg4M3xv+Kp3dTpKec8SlAQ7dSozeYiK7jyO7cCZtY+v2nTW2/yprfqhUTfSedcp6NJDDBi51a99kRwG92RCE0Tk/QGixtMqxJbXcfcoQOviqpf8vjBI5VZShk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BatBobeS; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JkCNSupkHb4pmsdTKq60IOpFTymwM1czRBrgPR0zc90hWrqerjIvBh9hqZKY4aUhXD5SNpVsoEgleNGlV4Y6XdO0LNWg/GwmXJgExQCkmncRB76u4cItUv6mqIsXXQ2kako1TMnD93PlHSe6pAGH4QGR7iofgoeTCq7jcBUXH3zoPe+aVNoc32mqZRbWKpMriKIoZFr+o5oKj03KDfDCxR2C3Z9nCFA0IoJjKkrSULZzsi9ItCEU+Sfd9RUhgyAmv/1VzrqZtQczqoyZ9OsdvOlx1EHZUWxUmcN6rijDF8qpWJf3Ys3u5y0EURsQ7MoHWFBaFzyAMuVnVcuPUzzncQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBHIFt/P2/P8hbgLGx6pR4yMO1ZWaYxaLE5ztNCEAis=;
 b=tyTmNM3yLI1IMziXW85pyX9rZz9j82XeNC6mSwBsnK2+IQ8NZKuL13sinwXdLdnesASSTzDRymO6e6sj2HZOF9iOXzwTHSHyy/kHYs0tVRglWY1DCsEWqADm8ArwIIeVvWReZ+zNkkhrb+GUHUx8Z7F3SBUDLs1usk44ifdxYHt+jq6J7pX8WzFxiFBZHRqTU9FPUCCBvSn/dmQjJnQ8Je5bo3ABKDvqVvnFyDlMwD2cgdMpn2lsJP9DYI3HsY+oUGOVYltt2CZjDIEsa8YarBkbQ/0s2t75DbhGS5o+9TMTVmyuJ5luAA2wKQmt9oCIMzQ0rPAZbG0QCFP2FQn2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBHIFt/P2/P8hbgLGx6pR4yMO1ZWaYxaLE5ztNCEAis=;
 b=BatBobeSMtFl7GC9IAjxNfK1VERrqC3e44kqaNzv2soRKbQmR/hxOKlAf/HqaM+OMec3QywhxgXg2b4a49kL8+P6uKPFL+YxcHySSVM/ZU1xqRVsaDOpuL0AQ+SHAwWN2chnsfowJMFXgSQsTIjojnG767fjITwe8IPl/djXOLtHdCQ4w17BeBmIlbwW9h7IwpaJPlt0XjqTExbIhYPJuRLAiIom9/PUIQPoHjvOXDSIPQS3BF9BZXA5SDhE/TbrOJx+uSQYgP2qPm5Fc006fsh2lU8cZVMx1UA3pLuJoVmz2f7vp5Enn4YdCWEgC+rWR/kK+URVZUuDAasCkoolZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8456.eurprd04.prod.outlook.com (2603:10a6:20b:3df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 15:45:37 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:45:37 +0000
Date: Fri, 19 Sep 2025 11:45:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peter.chen@kernel.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	peng.fan@nxp.com, jun.li@nxp.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] usb: chipidea: imx: add USB support for i.MX94
Message-ID: <aM16mDSAwi4GIUys@lizhi-Precision-Tower-5810>
References: <20250919071111.2558628-1-xu.yang_2@nxp.com>
 <20250919071111.2558628-2-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919071111.2558628-2-xu.yang_2@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: c380325c-8e52-4903-972c-08ddf7939421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mcfdc0cNei7ZAPVXOt4w5mtO2gGQpvJAVV0YOqoA5X3erSCT9HNzWLH2cLTN?=
 =?us-ascii?Q?XQZIBtiIhk3wYK8SYeiOacZzBeEhWcXiVFcIp3w84nB5u08iM9Kasp7DIzVv?=
 =?us-ascii?Q?Xjw8FQRoe4k9ntc7OMTOsjGA794N2QrXZaZMxacRZNXTJ2ykyLFG2Z8Zt9pW?=
 =?us-ascii?Q?z91iZ12cuCUgTvMsTznEUTcxMeiX4UhjxHyKPDqofcYCNA902yw6fuR4Gcp6?=
 =?us-ascii?Q?74e73U17NIWFlVbMm+OxuiiENngXhSNdGVBvMX3KowLUo5bZzFuhwsx1q9oB?=
 =?us-ascii?Q?+5dfUrlsT7z/QsLlvDjjlRDgKiIUo5lV08N6mS0jB/RA1E2hJN/eQzuaaC/I?=
 =?us-ascii?Q?WAb/HHX6++55JeotaZIKoW6GoDck+81DQCgVaW5XVCljHq9XHuV2IfWYHfNI?=
 =?us-ascii?Q?eRp9ecVEjmWq98JX8F97TpzMMkuDja8QbDXNvSwCMeAC0m/d/It87u3U1vky?=
 =?us-ascii?Q?u7RTelo0TmrtnGtZG6lVvz4bJNjXkGGrUg2w/pczPhHCDmSpuFNg5C8hUZpQ?=
 =?us-ascii?Q?FU/t3AOoqBtno+86UoshYVAz72tfDP0aC3XyL0u0dTJiPKljQ5zdP6aEiXwZ?=
 =?us-ascii?Q?4X6XlqjLZI7tCUiKTiPIvJ68Sl3VlM6sXIUJn1V/ltHD6wr+PPdrPEqpeNlF?=
 =?us-ascii?Q?rPafg6liOW+sbiJkLWM5Kc5tdL/j3c7vVRrZXwyQWcM5Vx8EMkAqc4+BE78a?=
 =?us-ascii?Q?WS1tLNQzMjY/8ckmaEklcqObNl+5Yl1tRT3Vsn/uECL3BaJdJn75Qo5IGIW4?=
 =?us-ascii?Q?3xvNOdwc8AjXU2flCKl1zyM6G0ygSeOf/L/3ejWxfVUshxPlZNDRh8jSgPpK?=
 =?us-ascii?Q?0x7dl7wE+RxPPVDrA9mL20aco19q07ns6NFBgofN2tGjoCDgyt7GP074QLSi?=
 =?us-ascii?Q?u4TrsB0t+i+GH4wyYVc5DvffgcqILPJ9zCyLVuJfuGbwh4tR06dnFnbWASSF?=
 =?us-ascii?Q?e1zFu1YyN71QaX/AgoKd/EfIBlXUgmy1yp+Dv1/D3ZjZBGlFL77XHzK37qbq?=
 =?us-ascii?Q?oMK2G1Zon7hN4sSssFr3M9kW6+dFofHvhlHLnuy4yNxQdTmpXpqXjS2kKDxO?=
 =?us-ascii?Q?OYVK6l0DX/ZiDs8qJfwf4/6APCMrSYK8F1ycKpD0TUaLB8iUOcO7iC2yZOpA?=
 =?us-ascii?Q?aa7xjJJv/lr8+YFpGAUa0GJTtAAMVVrmPczG7Kq1r/pmRiifwiFWtRCy1PhJ?=
 =?us-ascii?Q?q6XxhmqSmbZOUHm125ZgwDbKlriwO8Rq7yEbfveS6jaVhH+PTdNZ93JWGsBw?=
 =?us-ascii?Q?vgH2hh17smNQUfb6bRJkwb57DaX5NYXKt1Omas9avH/dUJs/VGfLFMbB6sra?=
 =?us-ascii?Q?+eVQxvgnp3juBh4XShOdgaL0Cwx5G3WkmLAELvT2AV+OHiRs1ehNEztdHFEp?=
 =?us-ascii?Q?MB0ohuG2kILmYHEHLOENagu0HDpQZ1R/+8g61MmtGoo6B/k+rRj9j+GmMti6?=
 =?us-ascii?Q?87NOCnIP27Iy6Vt0vBmgUphhFr2fLbDShHHWrxAZ7Ub/83qrXWXROw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cDLdj3bjw38BYyxzI/2B43Pq78puX5fjD3Tp9uuQAM8sh93xmIU97/yk6NCX?=
 =?us-ascii?Q?p0oa9k+KGUH86HLuGnk6cPLQgsVLzLnkhKm9ZYZ3jkG0GPGTIJk0E6tPOWMc?=
 =?us-ascii?Q?0nGpGYxqB9Zad5MRh7g+9JPLny8peyDM7P5wVzOZifXHT2yZY21VT2xXasxE?=
 =?us-ascii?Q?m27vKGM5s1IIf3j1HH3bRt9MHZeahvfm24QWh7AXgHdr/Ck/0KyduvpZXZfa?=
 =?us-ascii?Q?z4ICJouX9NwUuuYY/FOYrai80XMldfe76EowJ4UaJMLiA1beUlizXkZMDati?=
 =?us-ascii?Q?d1VZb8T2/OlRoGu7gnbx4WdDNgyzkJsue3GN27nHRzBzxagsIgqPDaXwFPYt?=
 =?us-ascii?Q?H3cOATyg+8VwDtXARW9tqbw8EZYZ42Qf1Jz7UgDDsE1FZESHUE5ETxaoJRkL?=
 =?us-ascii?Q?8XL1F1incO8i11v75JzEsyA5nbGxLnmJ4ZdYYQZVPzUEwPIjCJ3qNkgTBygL?=
 =?us-ascii?Q?VhSvxKMaH8IlHQFIwqIFdEQN7Ip9kBXLxl7L9lOHU3FvyXUwD+oRyx9wlLbB?=
 =?us-ascii?Q?EWWSRH1T+Ma28Kj9neDUuHf0WnjD3I3aSlODxsSNomRpC+uYG+mdUsLDweSX?=
 =?us-ascii?Q?1L0IAu6DXD6w0mk1rqE1QKyPCC/bk3giIkMuvj+T26lTixkMFX25BLWOMJB4?=
 =?us-ascii?Q?hhe+1Pom5JyuQ2ZjWZyX4Uy3rv9qwuaHy+kJV8YzwpFG+NNUxrhDK/f6ZWZH?=
 =?us-ascii?Q?FW7xE3Ks7CCC1T1j8M3JYC1GvqkJgyLF9NUV1e0sMQAgyTr0FRT1eIcLxWL+?=
 =?us-ascii?Q?UbHR02bUuW4pcqAF2V+aJMpJ5SF2dYGVp3xYR1g8aIhSxCAeIRdVwP7rS57+?=
 =?us-ascii?Q?so/1Jk/b8IDMNTSUkoNDcWVisVxnno3STFgsBlm0rXj2nvXDq3qVhP96k5bW?=
 =?us-ascii?Q?tburnTP6Js1SL6V8U82+t+BEKBPZP178qs2eJTZbmc88WS3PbQPm5VncgTNP?=
 =?us-ascii?Q?+rgiT3XBbKs7/mFSjNyFHqQm8UimqjY1VsPlghmfNs99mvebt82cL+p2HmI2?=
 =?us-ascii?Q?1v+/g4X8xn5XYuNVCSK8vX6pF/uFk+phUlpKxeO4F764R2LaXfd96Wm+/CzB?=
 =?us-ascii?Q?cPUc1YeI7ix0A/608GrT0F1zef8nHzGmSqxn5lV/zsaHFnLKt7cC0TpzNDaX?=
 =?us-ascii?Q?075ALTvL85LTSrjLL0Ndgp9aejwbrG1LYRDJ9GwG6CwNnLfkKRIXFtEI32h4?=
 =?us-ascii?Q?YdAYmYSmUoPeIDsFudVDJ+4EipVGcecRzbg+HhcwIjQ7YBI77RuQx4U6TcLE?=
 =?us-ascii?Q?e3cQ6iciMF8ocHQrXjY44bFgEvudo9G8eDlHXrqmpg9sknZJgjyVWUd4B1p4?=
 =?us-ascii?Q?Pf6JoHq0A9l7ntVpZLQ/zdLMm28Nj5I1+OCv0SDAYDmmMkgnK2hNkMXnJqvM?=
 =?us-ascii?Q?GIwiJUJUAGyPfe+o3ySLtPPvHIj8IcfsefkG+K+mm90kWV7wSHcUF739te8e?=
 =?us-ascii?Q?FV0lETwEeRk6U/jOtg/3hW4W6RfjB+II8NV/+Laje5jmdlFzz95KdkqztPjm?=
 =?us-ascii?Q?QA6ok+/K2wNNu15WFQMORBaprHbeDPybvcbQUZKzxVDA5rQuHsEMEUKfhhWs?=
 =?us-ascii?Q?5tpmF5+6avV9axcy7ogY3AWaKKNkE6uCJy4Fn+s+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c380325c-8e52-4903-972c-08ddf7939421
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:45:37.4832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ssgLWXi+DDlbIaNIIZiYjkDMHnHsfPJhlttbIJ1tVZWUU0DgkknLup6+VasKY81we8R/Y+Mb43n4Cz1zrdaKxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8456

On Fri, Sep 19, 2025 at 03:11:11PM +0800, Xu Yang wrote:
> Add new imx94_usbmisc_ops for i.MX94 due to it has same wakeup logic
> as i.MX95, but it doesn't need workaround for ERR051725, so pullup
> is not needed.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/usb/chipidea/usbmisc_imx.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> index b1418885707c..bb027d2bd700 100644
> --- a/drivers/usb/chipidea/usbmisc_imx.c
> +++ b/drivers/usb/chipidea/usbmisc_imx.c
> @@ -1224,6 +1224,14 @@ static const struct usbmisc_ops imx7ulp_usbmisc_ops = {
>  	.power_lost_check = usbmisc_imx7d_power_lost_check,
>  };
>
> +static const struct usbmisc_ops imx94_usbmisc_ops = {
> +	.init = usbmisc_imx7d_init,
> +	.set_wakeup = usbmisc_imx95_set_wakeup,
> +	.charger_detection = imx7d_charger_detection,
> +	.power_lost_check = usbmisc_imx7d_power_lost_check,
> +	.vbus_comparator_on = usbmisc_imx7d_vbus_comparator_on,
> +};
> +
>  static const struct usbmisc_ops imx95_usbmisc_ops = {
>  	.init = usbmisc_imx7d_init,
>  	.set_wakeup = usbmisc_imx95_set_wakeup,
> @@ -1481,6 +1489,10 @@ static const struct of_device_id usbmisc_imx_dt_ids[] = {
>  		.compatible = "fsl,imx8ulp-usbmisc",
>  		.data = &imx7ulp_usbmisc_ops,
>  	},
> +	{
> +		.compatible = "fsl,imx94-usbmisc",
> +		.data = &imx94_usbmisc_ops,
> +	},
>  	{
>  		.compatible = "fsl,imx95-usbmisc",
>  		.data = &imx95_usbmisc_ops,
> --
> 2.34.1
>

