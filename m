Return-Path: <linux-kernel+bounces-787000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C127FB36FE3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 878E04E1608
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F9F3164B1;
	Tue, 26 Aug 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lX/WDyEh"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013017.outbound.protection.outlook.com [40.107.162.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979835206F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756225071; cv=fail; b=ZO6/un+S0GTdkJbaLHVs/h8k4NwLjWtKGJJmjnV1uSrgC2sVoQErONIwgtutoHPKH4l1vo6nc0GSlva1NlKsmp60dCl4bnc7GigUfhKV20zvacoful9DuDHEIyd+xizI/c/bCre5kIzU0TZpdgISIldUY5pNtbhXB13GLssZkZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756225071; c=relaxed/simple;
	bh=8UXFLTicoy15r4JM6RnFOuazdGXiNmTm0XTcp08JQNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OAiSgC8rQjY+vGmGVuQR2+YxpSr1Im6naJul7H333gPERCwIxrWEXdP5wDDSAZfg3ecE8cPPaJ50/mbZrO0NvwJvVvJXK+jwEW4ndY0EzNY2+v1XGVISYHZQYlXdcx3L6PDES3oceU6L114NnKp6PnBvxYgi/aHDN6v/tJARAz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lX/WDyEh; arc=fail smtp.client-ip=40.107.162.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c0GGbF46+XsH25D2ux0A8FQaqvvQjedLMoEPEgqDr4cpBqTO7eHIe7PO9AsZe35P6EX2wMyEp6d+y8epBHekq6IF1+fTCLOocFeSGY7OP3Wo78KMcgm/ldossguuDfojhNE5rFwDeYWm+FGXHZQoBVNZ1o/J4drargeDCEKarRHratXeGOFEylom7EYtxOnjbsC2eAcJWTNoON3qJiRq52FJQsnhwnP2xjd5c2SoOPhJY96Z1z++N2vkquASpk7h4wZJw5wthL0RsnRpkrVN8z03n1zkKBhXERvxWvRGi/HU1Y2WohEArwBdMI1IJYmPYiX6pxaovXL4YtxQPIJ1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXTK1nEJU6twu8PtwOVereJ9GXqjbfaGLRGYnh5C01A=;
 b=Fexu8x6fhSxFW4bme6QJ8xI0X/OvrgEfcPugxFbfTvDdp9b20eOdPMKpvKQmLEoCw03VteAfiY2tTfam3K9IRU206v9N7+BBvUnUgRR8tKmg1jVDtCegNg6WOx8l1+8XxnV1yBGYjzFEMda4tYsVXSvscIlrRkDl5+jdFXFpLAOM7QxigFIgp9lMmPZiTStzi+xSPkrodONamRp0OoDAiXhIaXh3k+dY3YCfCpJQr/6ozn6zL9B192avyZ41jCe8u4k1zJBytV+ouCR/5nJINSG1p9CMS0CRN7XRM8FXbCh5DdCvvdS424JqnfLrkuBxfqpFR3iXpGqGxdqWixrfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXTK1nEJU6twu8PtwOVereJ9GXqjbfaGLRGYnh5C01A=;
 b=lX/WDyEhs6P2IeRi3AjSziGR530aihHznUj1hwyPyYkkEP1tC2D0jxpQrS1GJeCY+mDOzH9yHsncFMrVHBkkjo74lyakJ9BMW7ep8bKhujb1/TkpZwYHGdM5J6enkEkNcNQKhRYmicfwEd0uEE2t0YjxdQUdmoGMmgzBPJf6g3XjERB9Vm0Fn+vRTx0UZgt0sD1YT0HOgzyljppzItdEDv1VNkmpMDV0vSN1Vg9D0w75H30rO9rzyjK8WgRB1kwi1fgijUMFcqi/WsxyJIN1KtRFblEMBvnTWzvMLOv5XtSc4prvUNXfM142eM0U0fVRPj17aXs8658gCvtR7yuNVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Tue, 26 Aug
 2025 16:17:41 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Tue, 26 Aug 2025
 16:17:41 +0000
Date: Tue, 26 Aug 2025 12:17:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v1] i3c: master: svc: Use manual response for IBI events
Message-ID: <aK3eHkf31uIw04EH@lizhi-Precision-Tower-5810>
References: <20250819090831.3009647-1-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819090831.3009647-1-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR03CA0036.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::11) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf606d6-dea2-44a8-e2fe-08dde4bc1510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qaCqFOYp2r3xS73k9lDL8P8FFfE2xSnj7RWJBuFRyc50pFxg5Vaq9iwI869r?=
 =?us-ascii?Q?vU4G/PutxUsdaHuCD74gMx2IhYTergvwF1kB5+9ahwG+YmJVhPJZf/xGvwvp?=
 =?us-ascii?Q?wodrwL2xaiV7G3IjNJ1HAU2OIrvmyVFZUkBYmpuwvGkkhQgjJ5q6d7Cn4Qfd?=
 =?us-ascii?Q?c11UFBR+g2TzeKlUo7UFlvdKWuh8jOv+mV/lAeLyOSh3M5ypHJRqXTig7xMs?=
 =?us-ascii?Q?PeNi0ixptD27tVWv8RvAzOHy7MFVNZh5vvI8ZyFKfoTt53v88uykSm9SJoJW?=
 =?us-ascii?Q?+PFhyNe3D4WtlMTUphgCxXjg6kBmOrK0JHLdzh0oVS8EDlWJoUF4MJlbIRoL?=
 =?us-ascii?Q?3kinQtJzGaeZ6cGHg1WnXfMZM9bl2d92kq30VESLuEGmaoOfKZbmDE6T4YtY?=
 =?us-ascii?Q?tIqRXQPtRvcS2XMb/RKcrAnAVtOg/T0mlkli3RkfOJYnUY2NSVScxjRx0wjb?=
 =?us-ascii?Q?vTKdFTgPG3ZuSZJJHSIuNimWxdiX6t4yUbf785MZvcmfPbyxlu7lTyTeFW07?=
 =?us-ascii?Q?DeGrAf8FUIxUBeQa0hEIs4AWAJSDGZ7AuZfBH+dQJHv8ZbK6kiPGRXaAGC5Z?=
 =?us-ascii?Q?L6NHuDnQk8YW08b73ddRGcHdESzcFN0UVOlt1Pc0wMVW9NPeQRFC8xx0HgzZ?=
 =?us-ascii?Q?w8nEPAQsCxuzEPUEayQ9jRFedNtLIfEZL+Vo+3h6h5IMpYNtuqh4mzft5X4w?=
 =?us-ascii?Q?cY40FLrHDkI+sam6O2mL2IwdOMGd1T6A9hCQ5sSsc/tCM2DilxOnrikD0nV/?=
 =?us-ascii?Q?8ATrSmBGugEYFva8IXGE2KEH0jS4dqEp47azia0Hh3aRfpRPuy30fvxIsftV?=
 =?us-ascii?Q?9MO+Hec9rrzeoZ6UDe1t2fjxx4Hm63fy2uCfkBsKLK/9EgPdafk5HAUM/8le?=
 =?us-ascii?Q?dEwV/U/UYIX4tmO7Ok0wdoXhCXo/6azaOM1U62vVSPP0fRUdbo5XkT3iBVBX?=
 =?us-ascii?Q?CutrmWc3xlCmJv01t1Z9Nh2j78VhswvZIehw3sl4+sKQ/fvMp+MklVfTMpWW?=
 =?us-ascii?Q?4ew0Eccr3plDf53ldRtyEATAPmg/wK3kRK5Hoy/ehxLIiFPRXuF3zU0ev6l8?=
 =?us-ascii?Q?PFrsnmBGzIDdFNZz5NLkt2yp8mTIqBU7XWEgh/bgvVZs1QY4NYqmh5xVO7Gu?=
 =?us-ascii?Q?S/1yWKPCaYK45KPXHATkxZ5hmGe1U6qXAIs0eZ/dThH7cvpr3df1pmCGRUFW?=
 =?us-ascii?Q?6Xi5oipcm4xMFy9RcCllrQcGWB3gVJTA7fm9HY4tK/TcBeyZh2EnaSQfT4XR?=
 =?us-ascii?Q?T6hqs1tIdULeAXRbCJJrCybkNkRGSzjIvaXlpsPE7codS9d8FehT1URvIDJ1?=
 =?us-ascii?Q?r3tLOws2JuAW12MOqWq9cTy7UwQwJUDoYOFZZodt5ysSnZM97Qe0MjaVw+Qh?=
 =?us-ascii?Q?YYKUbKM7gQfqP76RjgAaGG/hjOP5Br84k4Ru8uepNYL/RiMeZ+EwhaoSoyHs?=
 =?us-ascii?Q?Hmec7Y/8tiZCwg0fzTCBh5bFgwhJan4aTfK6/U3jGnoyJz3BZuuzKA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jjXYKfL6AuefZ7nD9CwGEs9/NK3f6aeui0mdYed1tEZotd63jjpwcdNznm0J?=
 =?us-ascii?Q?hyFIwhYXbYFYXwuugL8U3fouVrcl3q0sUG90lrEA0cVO3PeeBi3fbNWJK8L0?=
 =?us-ascii?Q?cYPeAJ+V3Sp/bbsfCC9VSlar6qxdk3trHi4wuNEYTrVyYM/Ufp5ib2T+2JxU?=
 =?us-ascii?Q?QyZRyCnC6BX+JZKSLxMn+yZb2vYwDZCOOCjqNP0c4RmC46L8+NURCK78C5ld?=
 =?us-ascii?Q?ZNoRiULAiebUTIaQCMe7J/xW2rTb8p1qgIQ2UG9InQMD6yfFthv446SEFMst?=
 =?us-ascii?Q?qkLWIjMrl/TbG+CsKAPBh9FCQyHCy6HqpHwrTZ8iIj9OGcKuzMiD0WM02Kgj?=
 =?us-ascii?Q?Q/r48kKX+t9yvgF4QDBePMq4j9HPCKdQEEd0unKAPm2J7m006syZU89rL3d0?=
 =?us-ascii?Q?i3m16ItsySFoQc0ABMPnl4NHuxTN3aZ+8AnPZ+2ScKtMSOPRbD8FUfVdg+3S?=
 =?us-ascii?Q?DmBcOnVCSvmpWx1ubDfzJ/WZ0P4qZu/6DmWbzh3IxagFdS5ZVg7vcFdL2IpQ?=
 =?us-ascii?Q?G6g3GPM9ZBXk3HfvmjBr0wGzb5Uk+mhdHYLOTVXGrCFD1cnFpU6XnHZVPIpm?=
 =?us-ascii?Q?mMG3Shfra2dcKvHwchD2RfwiZpaYE1JcQbX/zX8N+X5m3HhlK+n9UlQx2Eko?=
 =?us-ascii?Q?81qxTAdEQRvLtVYuGdcXd0P8m/nt+FM8kEgJQP0G+LR8JIqmxRSmnBms9k9W?=
 =?us-ascii?Q?565SXNjU+hXw+pN9aLgAjfueEY5XbIINM6nn1+VM2YOxs+7CkVBRM8z/CY6M?=
 =?us-ascii?Q?xKrYwYre4J8PVnN7Jtk97ox32sCVc4YeIpXYfVyoXL34Q1tHPmnpMdwoe/m3?=
 =?us-ascii?Q?Nj90nmQmjqiYP6DRyfnrZHBxKSsbGQ2NBOF9Vvf8y+R/WbQ23viPT7Os8HJD?=
 =?us-ascii?Q?ddctopPLOlzyMErqFmUtfx1GLQDu1hYmT9ov7R60EV0CEOl5M7XQH3Z5ws05?=
 =?us-ascii?Q?tZgGOAb/2/EO4Nv6DNREatBtPT52Tf5Hgli9gmtK3Rgv8npkLLRdwjNFi6Ry?=
 =?us-ascii?Q?RZPKqa3mS3/s5Fu+o2+/xrBIbXJ5FbruRCqQJ4BnBJNZeTNqrpGdykyiG6zV?=
 =?us-ascii?Q?Dzxv0YGxnBeE/o/vOj7f/7Rw4RwBmU+7PkuZ+iUlUf9Cdl7GJr/rpOUciKvl?=
 =?us-ascii?Q?AkkXL2JEMmjk+tt5qC1ybnxuPbU5qot8QQ8LarnwcCtklQsUG1qCksJJnBz7?=
 =?us-ascii?Q?XhWQKKKAWfM8xV73pRLdlrWQ9mCaRqKAtmFpJgnQjMP96tdJiJVd8BHG40Cj?=
 =?us-ascii?Q?v+NXsLemHZ2mL/GqcUjnSAYSn2hWaR7Gc4vLHlnk9ihjzMRQZX8DX/Jun1iE?=
 =?us-ascii?Q?QGnomtiPVQGA8zM5pHmrfW5QD7zD7Ejp2BhHcCeyRGMGYPz1JNd13Zey8xwJ?=
 =?us-ascii?Q?xXzhKGR2C9rQEjmByyiGwHC+HTzgnzZEelCfU17LWPe7mPNkcenSIPJJgiBK?=
 =?us-ascii?Q?Kc0wUmcuHzDJ6uElsNo520uxo5wrvxcoTZzm9XTAU2kGXOgvq82EvDXjlcGT?=
 =?us-ascii?Q?TZymj6rloQbH9LtPZasCepcx/Uq8m7bXQJcT2F5UG5xg3pLgh4W/KE/i0a46?=
 =?us-ascii?Q?oIc7WiR3YfQXk8CoK04NfsXeI3Rfu4JoVuoXrzF3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf606d6-dea2-44a8-e2fe-08dde4bc1510
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 16:17:41.7441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WKcUo1zdFS5qlcY3rMtZ1pHO31YSdXOMfk9AsaYYaV6tAHggldJbAl8HxbggmbvtQ/O1pwd+kkDampwjfV4rYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

On Tue, Aug 19, 2025 at 05:08:31PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> Using IBIRESP_AUTO causes the hardware to ACK IBI requests even when the
> target is not in the device list. The svc_i3c_master_nack_ibi() has no
> effect in such case.

how this case can happen since default target's IBI is disabled. Need host
send IBI enable command to target devices before target pull SDA lower.

>
> AutoIBI has another issue that the controller doesn't quit AutoIBI state
> after an IBIWON polling timeout. The following sequence is the case:
> 1. Target pulls SDA low
> 2. SLVSTART interrupt triggers the IBI ISR
> 3. Target releases SDA
> 4. Driver writes AutoIBI request to MCTRL
> 5. SDA is high, so AutoIBI process does not start
> 6. IBIWON polling times out
> 7. Controller state is AutoIBI and doesn't accept EmitStop request
>
> Emitting broadcast address with IBIRESP_MANUAL avoids both issues.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
>  drivers/i3c/master/svc-i3c-master.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 701ae165b25b..17644e041b44 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -517,9 +517,10 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
>  	 */
>  	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
>
> -	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
> -	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
> -	       SVC_I3C_MCTRL_IBIRESP_AUTO,
> +	/* Emit broadcast address for arbitration */

Need comments here why Request_AutoIBI not work. I think it is IP design
defect to make REQUEST_AUTO_IBI useless.

Only concern here is that svc_i3c_master_ack_ibi() need send in 100us by
i3c spec requirement.

Frank

> +	writel(SVC_I3C_MCTRL_REQUEST_START_ADDR |
> +	       SVC_I3C_MCTRL_IBIRESP_MANUAL |
> +	       SVC_I3C_MCTRL_ADDR(I3C_BROADCAST_ADDR),
>  	       master->regs + SVC_I3C_MCTRL);
>
>  	/* Wait for IBIWON, should take approximately 100us */
> @@ -539,10 +540,15 @@ static void svc_i3c_master_ibi_isr(struct svc_i3c_master *master)
>  	switch (ibitype) {
>  	case SVC_I3C_MSTATUS_IBITYPE_IBI:
>  		dev = svc_i3c_master_dev_from_addr(master, ibiaddr);
> -		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI))
> +		if (!dev || !is_events_enabled(master, SVC_I3C_EVENT_IBI)) {
>  			svc_i3c_master_nack_ibi(master);
> -		else
> +		} else {
> +			if (dev->info.bcr & I3C_BCR_IBI_PAYLOAD)
> +				svc_i3c_master_ack_ibi(master, true);
> +			else
> +				svc_i3c_master_ack_ibi(master, false);
>  			svc_i3c_master_handle_ibi(master, dev);
> +		}
>  		break;
>  	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
>  		if (is_events_enabled(master, SVC_I3C_EVENT_HOTJOIN))
> --
> 2.34.1
>

