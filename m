Return-Path: <linux-kernel+bounces-893525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D33F3C47C80
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:08:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D717B424F5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15CC31960F;
	Mon, 10 Nov 2025 15:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="F9tKZ9RP"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013059.outbound.protection.outlook.com [40.107.159.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5CC26FDBD;
	Mon, 10 Nov 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789166; cv=fail; b=YJyXQIL6LXcX6sSFf4/tkRetsHDLge2yRm4N3bc/O5eHnZIlOXnCuMAFmIVu8PfMt8HCKVi9GKALJudYxebFlQhVS/nIAtDdhOGRvnTFtY7AywIAUN7Nl9bOnLCgtTxwScaEgC5wOl7nzd7Q8TXBupMJ5UR+uHov3CwnCsnT40I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789166; c=relaxed/simple;
	bh=3pzeKBf9DP8CGrezU+8M0HoBoD8XDPa0muyFOVzaUZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mOco9n4gSfCqKNsJp5RG/R0cC5LsUSvkTuJnyZ9Pwts5Uwm3sLt/2HXn8XeT9ovlaQLRgP6EPE2KbPJUSnihbUcDwjeDNxWIq/Fm9mIFSjf/L7WlX+bE04/RQaclx15RzbEl9ZwH6oSKFPFTkuNKQktgko2sjg0d0omnqe0CIKg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=F9tKZ9RP; arc=fail smtp.client-ip=40.107.159.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhIq/kmCZwzJG7H+8caFhzYrGviZzoncq9+baWsn3a1pOlFEPFI1UhEJ/QVtYF11+CXgaA3dv80w4ObYbKNjva+MG7cNJbyvNC1TIc/dhdKdYcH0JKMFl0JNPQUgMAk4k+zwmJMoOYTI2H+oGhSfNK44G+owUySaewFW4vYHtWwPFigz6SELKobwSJc4MmQyHvVepzMNk1r2Fx7GZfCsRJscAK+ZC52JW7B82wB4MVquS6CPThpbiyt56YoghTZ3jz4bQHPWAGNuTJj4bH9XXbDoYTgdm8WYhq4k5GUJ7WaSjjBknJyMwE8hgDhlVGffTK1IweTSrMAslfWo26fjOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzkM6wmvWMVhmJtqe/0A14bzFJ+fST6vzms7KVx6r5Y=;
 b=pJNUFB26mBW2QRGvx32vulUvo2/rkx/OKpj1fhtaYHurpUsINRMLmLZUGVgl0bat5M2pePfZCRRl5M0dbGxig00H3sRlPK/D++SbgDmxvD3GazF0rk1ePlx8uBu+L2l8bHgSclY2THYyOqDj42kKc9MYgcpGG3xdAF2qQZTQiD4jOqxSbsbKfFyuY+VtcHlFrWgRFwjohd5wGm+TFtGoKpBKKo9o9GPBWvyVBIhDXdvOopwr8nySzmZI0K8xBR6Mrlm5Em5qw/VsFh8qbq2TcsbVguTOWbivtDUp4Xi13gNEoS+fPrL5RPvoIvNe3Dj4/sLIo0mPCWm7uTbZH2mB1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fzkM6wmvWMVhmJtqe/0A14bzFJ+fST6vzms7KVx6r5Y=;
 b=F9tKZ9RP8D/QicoUO+ckPLjoL27XnVIxypvivdoJYxqQVoWYuHQUe0djP2qPMAxD41PuHjRAqhnkoIMwgEsjICMrJTAxtoGkyaRYR/TTXQDpk0oK1TT/cE1rqOP+wgSVQ+TMw7TAgOUaerINrBmEyXg/avQ1xo+0ENz+A9mk2uLeGtL/kEUoJSZNDDDL/sGc08bZ9ff4FXmvxmO7JrOXp5w4vxEgku1Ogpxbr8T/RRaMH45nD7QVcSpwbu3HIiXpZRvKc6R7GJXR3S6rUcIm5ydrAYpenJE65bHYgODSFhQIRkIFe+3EGVEAXcJj6d9+BrOLMW4SrSPtHyHeGrGZkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10121.eurprd04.prod.outlook.com (2603:10a6:102:408::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 15:39:19 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 15:39:19 +0000
Date: Mon, 10 Nov 2025 10:39:11 -0500
From: Frank Li <Frank.li@nxp.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Steve Longerbeam <slongerbeam@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, imx@lists.linux.dev,
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] media: staging: media: imx6-mipi-csi2: use
 devm_add_action_or_reset() to simplify code
Message-ID: <aRIHH4czX7dm+ZAo@lizhi-Precision-Tower-5810>
References: <20251107-stage-csi2-cleanup-v1-0-5d42535243ac@nxp.com>
 <20251107-stage-csi2-cleanup-v1-2-5d42535243ac@nxp.com>
 <6ec725f916737f2f25bf3ce4df412b4c07f6449e.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ec725f916737f2f25bf3ce4df412b4c07f6449e.camel@pengutronix.de>
X-ClientProxiedBy: PH8PR21CA0004.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::11) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10121:EE_
X-MS-Office365-Filtering-Correlation-Id: 4267279e-f93a-4912-d2eb-08de206f504d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TFhIxHjj4eT+7n1KOEgVGwslcY2mA7lqBTOC0sr4JTVroGX6t90X3EOxUPde?=
 =?us-ascii?Q?7ZeJDsuRIdAwd7LBDEqX+QxGiF7CQz6XjbghqFgOv0C/bj12a9Z2Mr8dPIAN?=
 =?us-ascii?Q?mh5B+He6Uzuov748J0Y813uEYPsWE4QNIQTnM6Aqx8j/VQUpfJmmkX89/uuG?=
 =?us-ascii?Q?I+ILYQ+jr32Df+O9wBL5ck6vBm3T/pj4AUXHtfiRwIIY0AZ+Mw98GirMeykD?=
 =?us-ascii?Q?udjWT7k2w/BmbJnwIBxOPjuKNPx9Bgb+B2zUqErSy7wTjgNA/vnaWsyNO96y?=
 =?us-ascii?Q?IqgASFxzlnWhVkiWo43dhxpuhM+N/DXeCwJ/rXY03AU7YGNC/uQMbW0A6b6x?=
 =?us-ascii?Q?0YXBl7ubPJyx7jQYIXoGqQnp4mOQKIt667nFYwqH5IMozWWjzUK2bG1jWfX4?=
 =?us-ascii?Q?NibR/L7UvctKb7rutS2amJKMRAqUq8jLvNUCmAvo4mkrmH9lc40Sr1xDZjyI?=
 =?us-ascii?Q?L7WcS981Pyvk+zjkLoj8z5tTsaK7+epp0TRtXbhKrKFK+PitQZK0RYIHNVbv?=
 =?us-ascii?Q?8OEt0ouM5381nLPHAcyX4Aq35lOQKonU3VQD/KFZJHFc0WDqxmZFhpOZWUTz?=
 =?us-ascii?Q?XMtRAfZS9IkLNbLBha+z8RNEMH/Gw/dnOOszqemygp0mw9Hz/MjRU2Sgmqgk?=
 =?us-ascii?Q?wRcoZy08pm6lTHNclAYsn40y4/PShASA0cTnNBJPJ4BpKZh3R0y+c/OW6r3K?=
 =?us-ascii?Q?C72EQ8mDwMu6WDB/31Jg7oZhf/WB2VDjPgj4sgU0LpB3cAkrdIKX2TkNDLbp?=
 =?us-ascii?Q?JnMQAi23LNjzWOJqlJ49a7V44goosHGDI/gtrOf/K76nvwdkSIBFLtRwPrDK?=
 =?us-ascii?Q?gmLGyQpZFIZsoRIp3jrHot5v5xZOrzmNF1ZKJAAdpJ9w+zvyLNwm+txTF7KV?=
 =?us-ascii?Q?DZW1ap3DvHRZtPqEZw7O4JfTuKLhDPDXbafA0KYlBdtmp4ckmi1SwaNtzr1U?=
 =?us-ascii?Q?0q5Vlb/WiR+5s5/wtWG5lPaY46b3c5TLkDOuzz7J1iovGdjQ1mdRsQt5Br9p?=
 =?us-ascii?Q?ZI/jRQ5QHonyRqVinHuckQmEh6DUWDOQvVPLtwirjCciuW+SmGsXhek0kQZb?=
 =?us-ascii?Q?gfc1zZHtyOOSPRtKPoMNtB5hkMjIrwv6zZe+e65L41mR6iI8+VVbVrFBfQKl?=
 =?us-ascii?Q?ec8vY0CsvBB4pkj7/oFUNIdzevzjn/UK0gFZzsFQmCYEXQLqNRb2qe7t7gC6?=
 =?us-ascii?Q?iNqLbH5gl92fOle4ggcJ2FaL/B1efq3MQv03XECy+jYGo+ssyxngfai6yyLs?=
 =?us-ascii?Q?FO+TFOJEmgKLOFgSGXd2W+uWFmzhN8rZmnlX1C0X3HGSX+/yYVVw63pM7QlW?=
 =?us-ascii?Q?5xWnkAKI2V/+OjiLDtNCQjWdrfxpeWbKB10Q1IVcB4KQhwx0yWrXAw8ICw2I?=
 =?us-ascii?Q?PPQWc2TQUWi5coSD+k55csBvONmq3kaOkBF4+70k5irBY4H8JJ20wz/hm4tf?=
 =?us-ascii?Q?8C8SoR7OI7UfIN8ZZgJeuaa4oymoIDK9mSrEan0gxNIs8rWKO4FxbKKTYXgN?=
 =?us-ascii?Q?1OZ2J8yGNrh/m52eAdCfbaWRg0tnnIYiUMoU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7jehfK/eYMiaWXKmtBgfCtaZRVJSNnEJu2U3qj1X3hAKALemhd1uQP81QqkC?=
 =?us-ascii?Q?vDriYQjGtU8YsZ/sk0MxABytE2Fmp20o+JezlcbFa9ocUGQzmz6Vzp8do/6G?=
 =?us-ascii?Q?+jP2a/FVMRknJ2pajC5GAOKrbx8joRIqusyNlm6mqPohXJZc74po9McL420B?=
 =?us-ascii?Q?CRwQkNKRfVggpl+J7kSdEbPXXJzhuagLbYEnEJXUizbopuYltAOfJm3BwWuj?=
 =?us-ascii?Q?nNvYM4gO53XHbOF/5mNjbWmCdN3eP6teM2mtFkFWSeg7exN1vVpbRSAhOZ5p?=
 =?us-ascii?Q?fCXQv19F/ikd2PL3JnPAX1WBJNhHFIjcxOZVIUvcZbKfBXaokJFwBnXfstTS?=
 =?us-ascii?Q?eDXi9NyI415zQ2RsLSuP3ZZofCQ6LisR//81xEaL2TeEbUl8MakbZL24/gq8?=
 =?us-ascii?Q?4gkmybwT402tNuwryJsQGQsnBe8NR17fOfXDnRx61MA6kI8Pfm7AMOkZvcP1?=
 =?us-ascii?Q?n4VJxZfp0Bkf0Gm3UW37TkWWZUN0efzHsdyLMe3q+atNCtg/QKNjW+aHW5QJ?=
 =?us-ascii?Q?PGAuzTTf437fJ0cAJas/vYB6OV5CF2/NWxUFBEkH1dinrm+5v6aNqNG2wYUD?=
 =?us-ascii?Q?ahHhXkPstD9BCoihJci6fOP66/eWkic82UKItBZGzoRMTJPA84KFXUTZzUmG?=
 =?us-ascii?Q?rDMXh2ynGeB+Spc8AL1IpRwhrjHSK3SB/P/1mtAt7ztSj9vPCfGP2NhC5c7F?=
 =?us-ascii?Q?bVgC1BAbxS8Kx4E0ua5gimQD2ROG29s8hnDsAJoXUVf+8M9pI9lNoXF5rG8e?=
 =?us-ascii?Q?gT6vJGAf5mL7NTwQ1LeyzFML+4GwGpAXZYANC7m8KOeejSsQdeBGkfHQ5rfL?=
 =?us-ascii?Q?U9DyEQEFgLtc+VZrY053imY9Xnl/PhmXG7VIqj5r8XdTymPmOn6lZqkaPIYd?=
 =?us-ascii?Q?/ALhPn8w2BLY04evd6qPcQKSL+nC36CxDjRV2lRCo/2wDGPfzZh4ej8n5xCc?=
 =?us-ascii?Q?1kFM2EPOsjHTITBYTTYUJu+elkKYz5rYOodTem2OVhKDmksEpyaxuJPuECsa?=
 =?us-ascii?Q?KyBSvUEXFP48bDFYY5eIOHR1OGHgwB/HRmL1VchDT5OwnMVOAM905dsVlrIp?=
 =?us-ascii?Q?akouJobyllpJydQu98pBrKQjC0XprErbTu5Qyp/v3zTUTpwLUkYz1JZy5ikA?=
 =?us-ascii?Q?VzmsQjr1zYKgOUCD2KZKDqGwhI+exs+dh8iLtfNpGS8P0k3YIRMreDF1+Adb?=
 =?us-ascii?Q?BxHLR2gddT/flvBdyhEOuoJ9fZQHddrkvs7dABxlSvRKnA5/dtjFj8AIw5HO?=
 =?us-ascii?Q?2qQrmYPS7N9Qy+7m/+KdLp6caZj/jwvLM79G0R2zIJRr+kpLZd7iWYbhWODK?=
 =?us-ascii?Q?oeAI3tcxhH4PVgkEczM9qAmycyU2xVX6rCYr0LOoqlWs5wDwNlXKmFuXeO9f?=
 =?us-ascii?Q?LIDeNoIX0CeBrm3GbCnAgywvRFi4HGdvaJkujhaCjkpDx1aCr8U7WCaNtNPa?=
 =?us-ascii?Q?3yzbZc/9Hz5qeph1Gcam6eHIsKJZa4Xa3pLMhMLLvMHZOYhImYVPEYJksH5C?=
 =?us-ascii?Q?rXVvLe6if3UfHXngwFcbP5JOfCtU3PxP4KJ6Tthb9FU6KldF+EEkyBFXr+wJ?=
 =?us-ascii?Q?fclujaKZ4CcxIy9014o=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4267279e-f93a-4912-d2eb-08de206f504d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:39:19.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D9ci+y1jwVLIUFgu/4MpzvT/s5mRtxXbKWr0VdUc76aZZ3DsRXgN6Guy+52GIPbXzs/d887IbcGfpTl/gUJ7sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10121

On Mon, Nov 10, 2025 at 09:28:24AM +0100, Philipp Zabel wrote:
> On Fr, 2025-11-07 at 15:44 -0500, Frank Li wrote:
> > Use devm_add_action_or_reset() to simplify the code. No functional change.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/staging/media/imx/imx6-mipi-csi2.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/imx/imx6-mipi-csi2.c b/drivers/staging/media/imx/imx6-mipi-csi2.c
> > index 42256441b881d9f132ad7ff899d6f1e35643b4ac..eba9a650030f5e380aa900b94728ad375171c6a5 100644
> > --- a/drivers/staging/media/imx/imx6-mipi-csi2.c
> > +++ b/drivers/staging/media/imx/imx6-mipi-csi2.c
> > @@ -716,6 +716,14 @@ static int csi2_async_register(struct csi2_dev *csi2)
> >  	return ret;
> >  }
> >
> > +static void csi2_nf_cleanup(void *data)
> > +{
> > +	struct csi2_dev *csi2 = data;
> > +
> > +	v4l2_async_nf_unregister(&csi2->notifier);
> > +	v4l2_async_nf_cleanup(&csi2->notifier);
> > +}
> > +
> >  static int csi2_probe(struct platform_device *pdev)
> >  {
> >  	struct csi2_dev *csi2;
> > @@ -749,6 +757,10 @@ static int csi2_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >
> > +	ret = devm_add_action_or_reset(&pdev->dev, csi2_nf_cleanup, csi2);
> > +	if (ret)
> > +		return ret;
> > +
> >  	csi2->pllref_clk = devm_clk_get(&pdev->dev, "ref");
> >  	if (IS_ERR(csi2->pllref_clk)) {
> >  		v4l2_err(&csi2->sd, "failed to get pll reference clock\n");
> > @@ -800,8 +812,6 @@ static int csi2_probe(struct platform_device *pdev)
> >  	return 0;
> >
> >  clean_notifier:
> > -	v4l2_async_nf_unregister(&csi2->notifier);
> > -	v4l2_async_nf_cleanup(&csi2->notifier);
> >  	clk_disable_unprepare(csi2->dphy_clk);
> >  pllref_off:
> >  	clk_disable_unprepare(csi2->pllref_clk);
> > @@ -815,8 +825,6 @@ static void csi2_remove(struct platform_device *pdev)
> >  	struct v4l2_subdev *sd = platform_get_drvdata(pdev);
> >  	struct csi2_dev *csi2 = sd_to_dev(sd);
> >
> > -	v4l2_async_nf_unregister(&csi2->notifier);
> > -	v4l2_async_nf_cleanup(&csi2->notifier);
> >  	v4l2_async_unregister_subdev(sd);
>
> This effectively moves the notifier unregister after the subdev
> unregister. Is that safe to do?

Good question:

I think, it'd better to provide devm_v4l2_*() helper functions for these.
I am not sure why there are not devm_v4l2*() helper functions now.

Frank
>
>
> regards
> Philipp

