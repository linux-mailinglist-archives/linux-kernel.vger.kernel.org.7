Return-Path: <linux-kernel+bounces-817195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA72B57F15
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E53E11A21FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063711EC01B;
	Mon, 15 Sep 2025 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Au0YMmJr"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010038.outbound.protection.outlook.com [52.101.69.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024032A83F;
	Mon, 15 Sep 2025 14:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946849; cv=fail; b=ZcMtAQT8TUOQs37besE1LNZ87KDTBagIQvIFpflNIetJUL0au4Q4LVcgAAMCrpDAh1JhjsQXHo/yRREYSlipY8X05AuFK4aX2S8bO9/aHMcNqcdPzbrnRzaQ2kQUm+KAimejq8Tx85XcIF8spg4p1GaCo2WG54py+ZK4GuaOUg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946849; c=relaxed/simple;
	bh=lDs1cShWviZCwXOTevLta9MBr4khkeMMGwRvAxzYpBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lmSdbNdsz4tz0X/g1r0YcX68vwPLOsIBFQVge7hQG1FuA/6uLibR0rFZAZYTKQ7GBL3uAFlUcnkYVX0X1WltAqiU7QSsRco/AuIGOnegecgItW0vVUW/jqi7c4PuZINXbcNxSd/xRP9sE8QACtvqHlIxYXypneJl7b4WY2172wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Au0YMmJr; arc=fail smtp.client-ip=52.101.69.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzD5aZghYcQaHMhRyj2G8/58mUvFSvnDTu9Lb9AMjSWirgKzmMeGp5fvRUBtySJm6wanhEr4Y+oCZjaFC7iyc02tLTmBMEogQuUmMwO0MGCFFu04+Jed0cyZ2HSDxRIV216T31wlukBa3S4onfFI9jRJOftwGx9AVnYSFngDTI48z9qOIKPM5FbNRDtDYiCWcY2mQCEjSIYs42VewWjNVF54WkrApxBj0EsTiuvQQuTtl37ihuNScsnvmTFyEbVDFK5zU3QtEoDmHd3nKLWWq85mdzyStVG+4FD3DJ60cBeB/WPQnbgMVHLxfig7V0P5MqrM5TvJypaNXu57lT5srQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMv2gWFROSCmGsVG9EKjyE88xvDjNAy3Z75/nnc0Hdo=;
 b=JkTowlYtIXQl3vkKLpWbP7HI7zE0gX9S/JgQj2TjA7UlqKsN6u1AteHUNPDd3CB5+Oe9ajSmfpVxHLajWnOppk/qrJO8yucAHDT1ZJX+0k6mxD0VyswLEofpAHfT0tGUWV+bJ5TFj3qPkoczoGon9H3en5sy6KiVbLN/vou9pS0J/TlpC+ArTVH66ek/Shx2SfbRYEz8p+Hbu8fwrQ3Y+QXN7mK14fGZal8TWhRbOmGPEqXjbJapA5dVxKhHluo0sMpaSQ3WfxyhPFdmaQLmpCxM/Sd9hKsBjsg02WZcYvj3/BULoSrax0QZr7eiuiF3BhcqC/ltHqiGWr+9EeVSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMv2gWFROSCmGsVG9EKjyE88xvDjNAy3Z75/nnc0Hdo=;
 b=Au0YMmJr/h/4lXBTtZYf3EoEMQeFxq6QronWv91iBMx/snkYccIMaCSe+oeKkYnxJOfvviBUsPO5l1n9zDmxAUN8bQacdcQETxohci5DPvUiBe04nK+EGVkFIr8ugw9Vh+k80s/F86aAUfFp/XKPR7pfRr8H/qWUSOrtJt8jegPoM17BTC/OtpBRa1HxvYHq7IOR2UQoNJEJokPDg1rL5mViC/4kfwkIw3Fk9WYiqI2f0h+aP0wEsoTHQbNuyoH51NPtCAhlcfLPoVWcZzr8WiDv33AHQpsVM0jtjLg3Rjx6oxWrB/ZC4NhK8oayIF8NN3fIZMh2kdTywEEoBL6RdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AM9PR04MB8745.eurprd04.prod.outlook.com (2603:10a6:20b:43e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.11; Mon, 15 Sep
 2025 14:34:04 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:34:04 +0000
Date: Mon, 15 Sep 2025 22:28:00 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: tglx@linutronix.de, mingo@kernel.org, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev, jun.li@nxp.com
Subject: Re: [PATCH] usb: gadget: zero: add function wakeup support
Message-ID: <szlqp4i6vdhqzipxefzol5nyabzww2dezkqo67chwjv6puamaj@6pdq77cwm2w4>
References: <20250915090230.1280460-1-xu.yang_2@nxp.com>
 <2025091545-effort-trolling-e7cb@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025091545-effort-trolling-e7cb@gregkh>
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AM9PR04MB8745:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a9128b-b8b8-41a6-39f6-08ddf464eb25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6rAJMdQhIPjRZFhLzaRvC/dGFGQE9RwkkTHAEx9r2woXegaQ0A/605Btyh5L?=
 =?us-ascii?Q?YYI1ma1Sx8jgqpTfS+aw5xc1cXv6lRGemL0bSKvwILCR2vme3/ObA4vPo6rh?=
 =?us-ascii?Q?stniVW5m9jIkCEB2E3BqUvkxUVY+eHHWgSAAwrk0hKtV36Gc3tG2RPYwBrEu?=
 =?us-ascii?Q?zGD+UeV68OS9EvMBgz/3HVASRT8YrFpmPMbSQsxr4PjpjY61bGfx73CImaxW?=
 =?us-ascii?Q?9vZylwt6us2KLoaDTLrmvqMm6YcgemZb3EtE17Qqs+koWCHStNd9MoYoXIvR?=
 =?us-ascii?Q?SKfbkSL4zA35/+bTMkHVnY8XAa4pbuGbdo2DcpJUn8vTOs2t75bPKBkbaO5k?=
 =?us-ascii?Q?s+FC8b8Qk6fAsLtt0r/7G73As/ToSuvJd+upJF3dfVASOl3UKQiOvhhcNV8v?=
 =?us-ascii?Q?nU2i94/UHIUWpysVPL+ardFZWqFuuZcRw8AobddXdBc0O4dEZdJg+P5qqYqq?=
 =?us-ascii?Q?jOosbnrWPr6B8tCbuoKkRFLTcfymFAFN4JyRfVwcH0GEZJr0GWSKOI13EY5F?=
 =?us-ascii?Q?dMvEhFFgaa0hlR5GGJjxqGWvWOb+uW/LuEWjRmgwjSe91PXACFkequgWBoEy?=
 =?us-ascii?Q?aki7YYkOnOo61bVP7XLELOHwwfJLbSbdbs3ylvMHZZ74c/J3WiKxc8vnkGf1?=
 =?us-ascii?Q?RpEe/BYMv8raX7/60h5PTf5an7N/f/TAV1pQqwsZfcVLEDDRXuxsENIEQkYH?=
 =?us-ascii?Q?1ZWngNwR/4XzzBbm+fDFKMy79Sa75iHqmoQXPoITAt+gd1NNLmft++mlhnsh?=
 =?us-ascii?Q?+BPnU0AtE+nSCGzcHviuoc+eZckfhRDkIYsal3msGLSNU92TdbK0itdHxpSu?=
 =?us-ascii?Q?EDPpKJB4odbrVoIZTF9QVzG9IU4uGl7rs5UPN8A6QRAVmtfYI4r0Y86hnt24?=
 =?us-ascii?Q?6+DOwiGoO/zAhrEIb24IGu3Cm/lCj69lNq3hpXPTDMnMfR8nOXGjmPgE6WFe?=
 =?us-ascii?Q?emqp2oCmzhodMwWkxe+smKk4x7iARPoEfxj0qmhZd5fQS7CFj4Fd8qNjGmYb?=
 =?us-ascii?Q?+fywC7Ms2De8QJxXt23nfwl949L3udaqg57Y0xGRDa8WNiJqr+i0iYBS4Z4K?=
 =?us-ascii?Q?aNBLyEdOOLBPUhS7H8raZ02pw/nqsCFfGv5e3k/KmjxXz+tXJcK3T1hE6vBW?=
 =?us-ascii?Q?gHC8jvv/HXe0ipbYtd53TCzqeCemJLE5rn1sgFA8iJtjQ0uELPuXbCoMyojZ?=
 =?us-ascii?Q?OytCVlXI+eOOYKuTrLF4Z6KSI7sRv+1g4Q1U0TnjRVbqSLAoAftcKKm+7Zm0?=
 =?us-ascii?Q?Re3pLUIolaPIbvrbzYUAGIZIIlNPadQD8cK5H66zO4R0lweT8PKOCtE7Lf75?=
 =?us-ascii?Q?KpC4cIb+4/iIxfJ4oe7qnyuOQ/3tZQHxK2vvYgrWZ4ifRasemrVWGrM4IB7K?=
 =?us-ascii?Q?Sx6ZHbpGKfVTu7SOcHqwO3M/8b0jvDc7u24h3LF899iLwJhCElweCHqxntoO?=
 =?us-ascii?Q?J1Wp7edWmgrVnM4R2EC6TEP65DSHggYstzDNsVGegVhokrSho7AyUA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O87qg1MM8QZoYLjL1YuoeIA3kX8uOr7l/WToKySKQFypdHnPIchghqd/56Mv?=
 =?us-ascii?Q?pOyq8ScIuKyZQ4hzAiQVQY8oPIeguaOXnP7yh7MmlVyrxWiKwLMcfuKTohQV?=
 =?us-ascii?Q?VUK1qjszfrXApBJZNOCojQ5MUcHM93u47WVypynHzOdM2XLUnZTXM+7wHRce?=
 =?us-ascii?Q?ETZWOWwkghxiz7PwaJpDXKsVht0p/BRE2htvjR76X0MSY/xMtpSgmfGNO+sq?=
 =?us-ascii?Q?7Nn4RvHsCDd7hgl6jYhFpke6DgER+T1bOfeukSoMedtLq5v5XkrLBq374B9j?=
 =?us-ascii?Q?wQ2c7UYLVa/eUyJfNJwPf2WOOtO2ocvqfi1SBqqdBs/QtYaFwBPpLpRUSAqA?=
 =?us-ascii?Q?kd5yPdQsretoybksRk7De+r95wbwSGYEzrlMj2LwBMuBC5X/3ymg5sX6LCjr?=
 =?us-ascii?Q?uSlwyCTFv9QDGnhfGVrCWgU6AyDhyJZ3PiHSyIlLKdAWOkEvqoWXFn6ycHGn?=
 =?us-ascii?Q?N3d800RgjggmsLutGwBWzw3sCl5DArJXV7Q5l6wEnZt0mCkjBsJdtJ0U5Onw?=
 =?us-ascii?Q?Jrf4vuvpBlnBy6kUa59biojcVvfI7GlUS6+omJdo4bxHE8sIGg542JGWcvCU?=
 =?us-ascii?Q?/LTu7JIqKaKwv1EK60HTI+JGcTDLwbfjEk8NSx72QLCnxIFLONtImuTftuUl?=
 =?us-ascii?Q?cV9ob70I82CLj877pwnBxXm5d5LcMC9DM/FZpKGI9qNESygkoDblHY2WTlAQ?=
 =?us-ascii?Q?A3h5Ih4/Y6yFhJ7F0LWI1LN06c9n4ZEgoH0ZWp3jt5F1eje6EqKGABPV7Iux?=
 =?us-ascii?Q?BuaJ85q6zriOMGXKZx0PFSrgJu2Drdu8sfC2p1G7zVop32h0zzThkyigtvUm?=
 =?us-ascii?Q?CUimdPc8GTtTZciRXjRruHlPu/AlOR0/QW6+jH7UwNRGL1uxMzLRCyTY1Dsx?=
 =?us-ascii?Q?e+K0UNDhgdgREEsHIO8DZFLYgubhrso+PIHMluWrYSvlLKLWKba5p33/N3mz?=
 =?us-ascii?Q?Moiip9eYOhrpzzw3SslGpIUIySLyyLAwBtC6bsCBVj9Z+AK4J1+VEf8NBtXN?=
 =?us-ascii?Q?EYBJhseP5FHDOCs6SUlq3/PBnF8xfwiw5FoIy9nK2MDJjzMg++NBDi441KCr?=
 =?us-ascii?Q?tHxvBUTbSz60qxyS6MWDrp5dkkXFnLxQy/UXee5koorjK7wwByL9nYSzz3A5?=
 =?us-ascii?Q?/QHYpjqv030EiQFtZQ4h6Y0bScMFzIbbXaS/I75DL3Dpi2JPquNB4fr5Ptgy?=
 =?us-ascii?Q?y5/SIKpUZ2yxXnfBjNL743EwdMf68yO/dp7CVXBLDw3OTZCSfxZN2CjJ61KY?=
 =?us-ascii?Q?5cL3TbZqwe2QnCjOk8XrKAAgwmcNd9Ol8EaNSu9vaPjLji/trGsa3oOQunOa?=
 =?us-ascii?Q?bpwnkpplyWeMz54SzP20CrS8VX4TuYtglIumQsnBa4D01tN5yx1KYtT+3XZh?=
 =?us-ascii?Q?uMQltV3PUYTvFPYvnCbeQ1iSGedzUGh5cc1Z/3n42RHoBtFwwp5Z2U7dqTEE?=
 =?us-ascii?Q?RcKrUrrDcGIqQgpb3hOPpQCsPoOo0ZRalfexLugt6pHCDbny1X/K2rWFVvpf?=
 =?us-ascii?Q?wUnHCaQssEChwXjFuUxFlVuGrm73yPU2kdEKL4+BX2zx9YfjAFNF9622g3kQ?=
 =?us-ascii?Q?2Q0n7dZrOABC9nZf3lplLws2NAf0TsYOMjr733i8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a9128b-b8b8-41a6-39f6-08ddf464eb25
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:34:04.0873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoYO+fA3fLdoT0jKbenj20VXFNjWkkl2c4EL26i+Os5dj20SjAhohStQyxdm1pjSko3TvRuyIHo8UI6lwcxDiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8745

On Mon, Sep 15, 2025 at 01:36:07PM +0200, Greg KH wrote:
> On Mon, Sep 15, 2025 at 05:02:30PM +0800, Xu Yang wrote:
> > When the device working at enhanced superspeed, it needs to send function
> > remote wakeup signal to the host instead of device remote wakeup. Add
> > function wakeup support for the purpose.
> > 
> > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > ---
> >  drivers/usb/gadget/legacy/zero.c | 27 ++++++++++++++++++---------
> >  1 file changed, 18 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/legacy/zero.c b/drivers/usb/gadget/legacy/zero.c
> > index a05785bdeb30..fe286b597f9f 100644
> > --- a/drivers/usb/gadget/legacy/zero.c
> > +++ b/drivers/usb/gadget/legacy/zero.c
> > @@ -147,6 +147,12 @@ static struct usb_gadget_strings *dev_strings[] = {
> >  	NULL,
> >  };
> >  
> > +static struct usb_function *func_lb;
> > +static struct usb_function_instance *func_inst_lb;
> > +
> > +static struct usb_function *func_ss;
> > +static struct usb_function_instance *func_inst_ss;
> > +
> >  /*-------------------------------------------------------------------------*/
> >  
> >  static struct timer_list	autoresume_timer;
> > @@ -156,6 +162,7 @@ static void zero_autoresume(struct timer_list *unused)
> >  {
> >  	struct usb_composite_dev	*cdev = autoresume_cdev;
> >  	struct usb_gadget		*g = cdev->gadget;
> > +	int status;
> >  
> >  	/* unconfigured devices can't issue wakeups */
> >  	if (!cdev->config)
> > @@ -165,10 +172,18 @@ static void zero_autoresume(struct timer_list *unused)
> >  	 * more significant than just a timer firing; likely
> >  	 * because of some direct user request.
> >  	 */
> > -	if (g->speed != USB_SPEED_UNKNOWN) {
> > -		int status = usb_gadget_wakeup(g);
> > -		INFO(cdev, "%s --> %d\n", __func__, status);
> > +	if (g->speed == USB_SPEED_UNKNOWN)
> > +		return;
> > +
> > +	if (g->speed >= USB_SPEED_SUPER) {
> > +		if (loopdefault)
> > +			status = usb_func_wakeup(func_lb);
> > +		else
> > +			status = usb_func_wakeup(func_ss);
> > +	} else {
> > +		status = usb_gadget_wakeup(g);
> >  	}
> > +	INFO(cdev, "%s --> %d\n", __func__, status);
> 
> Is this INFO() call still needed?  Shouldn't that be removed?

For me, this information is useful to know the test results. I prefer
to keep it.

Thanks,
Xu Yang

> 
> thanks,
> 
> greg k-h

