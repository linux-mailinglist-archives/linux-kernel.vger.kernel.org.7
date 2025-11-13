Return-Path: <linux-kernel+bounces-898739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADD2C55E52
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA4F3B8CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4953168EE;
	Thu, 13 Nov 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kZye/28P"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012016.outbound.protection.outlook.com [40.107.200.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18573168EA
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014263; cv=fail; b=WZrjqPAX/EsupitS3U5TzHkpljq3/alFzrA9Lr5QH4p0S9xQQP5KY2vvIdkimK4kAydGecO8UfYUx0pM/btOga+Da4Rd1DJwWZdkN4TEOs4s69+wup2gkypx0fuRZxBsSDaiY7pqvLSqOi10bFJIlPRhruQC/8DW4SH1Wy9M//o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014263; c=relaxed/simple;
	bh=ZuTCPSkJ3GEe7vLonU5wAxcWybWDMxob70Hm8WDczdw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UG7mdZCmNeBT/B7ujsFus+yBnCUKwW+/4TMl693zQDXi/svFL16vtpixCG5UYLP+WJbUy1JbJSQgHUOdp+vbN9qrB08kxMidvADZmxtsQJ5xhiGfAIhwWu9rfLV4cXWPmIn+wFBCjo8Q21Vle00DJdewoZQTROAdtU6lWPMRAUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kZye/28P; arc=fail smtp.client-ip=40.107.200.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB8M2y0W2sdn58qBDUtVlbrcnJrFiKVgWk4BonTSdIn9i5eag2Gk2M8WXp5jS4FotxbVN6WoWCw2EZRyo8u0wTx2eDTDyIo+gqeLoLKMzhcKEOfOBgTDJkRvBvpLY+RWbU9PORA/4tJOSWz2nRHyHiTqocfvO7e5opgyJs0Dr25ZhWhO67OYdlaQcVNTha+QLngG2ZzcalOMYBxpGC6DapVICPkL2WXToXflUsgj9gGK0hjLxESWaIsQRYkRossEy3hkAxAOMTC9g+gB55JfGNBrgS4sw5fOP2dCfIr+IwBIgndARYAdb4azNYgfEoawmWXkZgS0fWWh7b+G90TuvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0W2uni+ssWT/9semmDGtyR8IqmvwcBe2fmf6WF26bs=;
 b=EOiaEA0g1cxnAqE56GGu3ghYiO9ksD8IByQPqKEoeFccje0uX2nmi7xe/yGXELKIJl7ysUh0kpTHRKYRGYHtXXukU8mrduWrnD9VDjxod3hQ0jUK+UtAvUk+Ou6uSmupB/ZejqcUCnWcWN3GvBaaPCAsaxXOqbHmOC7UB8wmJLqN/6sASETvLSdLBu8ixMYt9ryMSGrG4J90nckg7C3WVdVaCGSjtB3DpgKiX6AE9cCQCBHw0TDEx5BHqTarnlpT61AnNqzgxb5GlD2NACpmLo4MxSI4A+Daai7yxesWrrfBlUK9qjvXbZ8i2Y0kEvi6ER0fc5sn6T/saFAN+WreGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0W2uni+ssWT/9semmDGtyR8IqmvwcBe2fmf6WF26bs=;
 b=kZye/28Pb+tz/Gf4y9QE0wMdWMpI7deozfa+KTrdelnE5MZMqvKmqdXyE5D4No4Yx1melxf50NQJLT0YiaOOneutt/B88pVoYFZUgwxW/bx89StHN523JiRyHr6c+X3TcTMQJMTqkWtUkh/EmXMy1YaXB4TlydoQHcwmigPbWD0=
Received: from MN0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:208:52f::22)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 06:10:57 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::fe) by MN0PR03CA0023.outlook.office365.com
 (2603:10b6:208:52f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 06:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 06:10:55 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:10:46 -0600
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 00:10:46 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 00:10:46 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AD6AjTs3981581;
	Thu, 13 Nov 2025 00:10:46 -0600
Date: Thu, 13 Nov 2025 11:40:44 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Andrew Davis <afd@ti.com>, "Markus Schneider-Pargmann (TI.com)"
	<msp@baylibre.com>, Tero Kristo <kristo@kernel.org>, Santosh Shilimkar
	<ssantosh@kernel.org>, Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman
	<khilman@baylibre.com>, Sebin Francis <sebin.francis@ti.com>, Kendall Willis
	<k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/3] firmware: ti_sci: Remove constant 0 function
 arguments
Message-ID: <20251113061044.asf4e4k2z746iyl3@lcpd911>
References: <20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com>
 <20251103-topic-am62-partialio-v6-12-b4-v10-3-0557e858d747@baylibre.com>
 <bc987a5f-ee3f-4722-92e5-056bef4d84f9@ti.com>
 <20251112152853.3ad5co4usxu7hiyl@ultimate>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112152853.3ad5co4usxu7hiyl@ultimate>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: f89fc91f-2fe9-45c9-d952-08de227b6841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t0ZxcDtevs9o7e1ugUgwT79iM7c1a+Mxcn49o/5RkgCsDQri3KRzT5BP+dGL?=
 =?us-ascii?Q?Fl/AI5A2VtVyWWB3s+XreLLROLtnllyjdVsaheAmPZXLc9/2Ecr5PX+G4W6n?=
 =?us-ascii?Q?mhMp8qefGMIbW/Rq+Smz8gQc6LE5h25eKpcEjc2lUJMOCZoBjMFckrPOybwc?=
 =?us-ascii?Q?h+YDAMiKXqmoAUikmi0L0U7xE3E+1SWqRux1Zstez74u6+bSWAR+zG+1Iri9?=
 =?us-ascii?Q?LSdyYRXOJc3kgR2ZCgXJ+e2qq2wK0IPuQaDVdoqtJHiLMuZe2JXKk8gIzc/o?=
 =?us-ascii?Q?YN7DXB4In8qX9JyuP0FE6i8otwoBf4ab2Pb3ym19zBNlgtShBjSH6WigS1Ya?=
 =?us-ascii?Q?ZDfkcZWTXE65oF46KOhMaN45yWVcMDqlfjpSVJl9DdxfP6yIJALtJ1IbDdoA?=
 =?us-ascii?Q?EIrvKg/DkaSdLoSkq+pxR4j+DU7n/AI5vzdtrXqJBVUXU8kEXu/7jCLxrOYP?=
 =?us-ascii?Q?Y4NJaLgk7KLbnxdupZFvFlghag0FUq+dy4drENDJLNWpkMYNj+6SXEmK8o41?=
 =?us-ascii?Q?cQ0X4vg8EjwYQSqmAKqy4G74xd8Bu4UP6HaaJWTWpxWXamy/pLlJG7O8aDid?=
 =?us-ascii?Q?uJ1iiKVjfi7cYLt7YWEFv0wgImNCz0kZ0C4E83pzu1lAf323GG6f+Wa6UgZA?=
 =?us-ascii?Q?GeugG/kSollhFlrzsQ7jiaWXq6O6gMlmyv5zTyRd7LM1KDHE/Mikzg8kemYE?=
 =?us-ascii?Q?mt3D7mHBmvfxJ0PRbGqCY74iuYm+jbQOx4z68R2NnN7WO4NTli8fZwXYwz3G?=
 =?us-ascii?Q?zEyF9a+a5TFVoysTrQuC8TQeXaGz8qDFti0hghAfNcF6rP+6/pTAnZSUbMaN?=
 =?us-ascii?Q?diiC9lyfx1BVh8Zn58ytH8C54i2TvtaznMZx3l3JvajlKZJcW1en6zTfO8Aa?=
 =?us-ascii?Q?0z4ErbBaJzBqC219ZlqWe100NtFVeDKFiXP5nVKgDXJQJseSeICNJa4TO0aV?=
 =?us-ascii?Q?WcSVS0eNPUvqm16PkqsuL+5tOcR25ogNYBPAcqREU5sMnBL8Q4tUPTNbE+Yn?=
 =?us-ascii?Q?Wk1QeAYGcuWAe9tQi4mdiXF5rkdx1ijGKHBUv+UKmOAgYYuNJwWMVXE9oEr4?=
 =?us-ascii?Q?wpEgYVLY4t3hMEpBQdJW5YIbUjhfxXFqcT1anw1pGWqOH/Y8Mo7K5ToqgIwZ?=
 =?us-ascii?Q?kfZCqoKWWtikxlCBpOEO11TxjTH5LcOMZO/465qiBeSJGM8gvdweBHXGoRTp?=
 =?us-ascii?Q?RXBGp/W1AVnzovLiNvgzTPb329aVv8+apc8eajXsxizDIXOBHsZMMI+E5xHV?=
 =?us-ascii?Q?1j3q/0smgj0gv5AoR+/AlnBdymdMFL88OmtCIryGT7eMAs1ZPa1UTA+MbHOK?=
 =?us-ascii?Q?DfD/upnMBrw44aKSCf4aFYMqpOHr84bv4FKGNSqHuaqCJiSwJYxL6PFEEXH5?=
 =?us-ascii?Q?F3QZaUa+bMs6ghcWIODwRgBEtOKuwuVb2dwqhkljhkeePkzmIji2fm189MMb?=
 =?us-ascii?Q?+OTAN+4jdlkirf8p6mq4DvoRaiJY99yTQ6DpiDgAj5pKNWrG8IeFpAJXETt3?=
 =?us-ascii?Q?VLTLJa2N11TlBbGJmgtlxgWn78kxYgDVY1SrWqG+9bkW1DSGHL5qMzncr+Hx?=
 =?us-ascii?Q?ovOIHo3HQJFTVI7bUJI=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 06:10:55.7488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89fc91f-2fe9-45c9-d952-08de227b6841
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592

Nishanth, Andrew,

On Nov 12, 2025 at 09:28:53 -0600, Nishanth Menon wrote:
> On 09:26-20251112, Andrew Davis wrote:
> > On 11/3/25 6:42 AM, Markus Schneider-Pargmann (TI.com) wrote:
> > > ti_sci_cmd_prepare_sleep takes three arguments ctx_lo, ctx_hi and
> > > debug_flags which are always 0 for the caller. Remove these arguments as
> > > they are basically unused.
> > > 
> > 
> > Does that matter? The functionality is still available and when we do
> > use those arguments we will just have to revert this patch.
> 
> I agree. please leave the existing params alone. no point in optimizing
> it.

Thanks for reviewing.

Since there seem to be strong opinions from you both against this, can we
simply drop this patch while applying?
I am just quoting author's intent from the cover letter change log [1]:

	Moved the removal of the ctx_lo, ctx_hi and debug_flags to the end of
	the series so merging is optional.

We can avoid a respin just to drop this patch then, thoughts?

[1] https://lore.kernel.org/all/20251103-topic-am62-partialio-v6-12-b4-v10-0-0557e858d747@baylibre.com/

> 
> > 
> > > Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
> > > ---
> > >   drivers/firmware/ti_sci.c | 17 ++++++-----------
> > >   1 file changed, 6 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> > > index 811507ded63ac784ad6c6ad77b2f827768f3f3c7..023c603ae58cb5df176c66eec429bd0b4037b798 100644
> > > --- a/drivers/firmware/ti_sci.c
> > > +++ b/drivers/firmware/ti_sci.c
> > > @@ -1664,14 +1664,10 @@ static int ti_sci_cmd_clk_get_freq(const struct ti_sci_handle *handle,
> > >    * ti_sci_cmd_prepare_sleep() - Prepare system for system suspend
> > >    * @handle:		pointer to TI SCI handle
> > >    * @mode:		Device identifier
> > > - * @ctx_lo:		Low part of address for context save
> > > - * @ctx_hi:		High part of address for context save
> > > - * @debug_flags:	Debug flags to pass to firmware
> > >    *
> > >    * Return: 0 if all went well, else returns appropriate error value.
> > >    */
> > > -static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
> > > -				    u32 ctx_lo, u32 ctx_hi, u32 debug_flags)
> > > +static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode)
> > >   {
> > >   	u32 msg_flags = mode == TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO ?
> > >   			TI_SCI_FLAG_REQ_GENERIC_NORESPONSE :
> > > @@ -1702,9 +1698,9 @@ static int ti_sci_cmd_prepare_sleep(const struct ti_sci_handle *handle, u8 mode,
> > >   	req = (struct ti_sci_msg_req_prepare_sleep *)xfer->xfer_buf;
> > >   	req->mode = mode;
> > > -	req->ctx_lo = ctx_lo;
> > > -	req->ctx_hi = ctx_hi;
> > > -	req->debug_flags = debug_flags;
> > > +	req->ctx_lo = 0;
> > > +	req->ctx_hi = 0;
> > > +	req->debug_flags = 0;
> > >   	ret = ti_sci_do_xfer(info, xfer);
> > >   	if (ret) {
> > > @@ -3729,7 +3725,7 @@ static int ti_sci_sys_off_handler(struct sys_off_data *data)
> > >   	dev_info(info->dev, "Entering Partial-IO because a powered wakeup-enabled device was found.\n");
> > > -	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO, 0, 0, 0);
> > > +	ret = ti_sci_cmd_prepare_sleep(handle, TISCI_MSG_VALUE_SLEEP_MODE_PARTIAL_IO);
> > >   	if (ret) {
> > >   		dev_err(info->dev,
> > >   			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
> > > @@ -3768,8 +3764,7 @@ static int ti_sci_prepare_system_suspend(struct ti_sci_info *info)
> > >   			 * internal use and can be 0
> > >   			 */
> > >   			return ti_sci_cmd_prepare_sleep(&info->handle,
> > > -							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED,
> > > -							0, 0, 0);
> > > +							TISCI_MSG_VALUE_SLEEP_MODE_DM_MANAGED);
> > >   		} else {
> > >   			/* DM Managed is not supported by the firmware. */
> > >   			dev_err(info->dev, "Suspend to memory is not supported by the firmware\n");
> > > 
> > 
> 
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> https://ti.com/opensource

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

