Return-Path: <linux-kernel+bounces-817215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB84DB57F60
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F043BA862
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9D4319872;
	Mon, 15 Sep 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZHS3Hcih"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BD3164CA;
	Mon, 15 Sep 2025 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757947616; cv=fail; b=NXrki5aFI5kRtxr9oyZLxoFDg1kNphDNgiivgtHNo+8jcsyAfldH9XlXTNSDF+iHfH4MsC8AncmvODjNt4S459T745/wlmjEuz2f6KU8UIn1pTRvsxNd1LUS2TUym/LMdH4inYGLWW6gHdedXHESkIng7vRd99y/TdOXRHOGkf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757947616; c=relaxed/simple;
	bh=wTqA9IpQijAYiNXTp3piX0ByMsjfLl0LpMjliDQMxn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iY1PiDXFJfy4k4CYRF7ylN0Z1GkBZkjOb1WMINVn0ykHcdcIdCD094FJSQ9OKl1MyEVz0ZgIrtlzLs7RbUYg094FHPq9cs94CtHdAG/rHt5hgvbrSGR3UMCmmnUOuzUu7YfJNiCxzW8P3WXTJTAPJFgXjP1PvcC0obY/fno41Jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZHS3Hcih; arc=fail smtp.client-ip=52.101.84.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnthHsF0+YqmlahaBCy6FLHJ4uKO0tEAd93xwzDd7ll3F/o5XUsFRIjo8dO7i2ywHDaqHqR3HZ7S000mvoWIWHSqJK6reFmhYCJ68Yx3Uyzbz0khcSczZIfnxn71cbjqXngbZps6uDQNaNM21ywSogz91tpE5EHZ1JUUlpSrtLBPe12+YicWAH0nkymaNZQkkQCXeb1BoxkUgCHn/62aX/XyTbAPPUac4QI4Dakp2QEeqeJsyhsNKTC0y76M0h5KtSMzrHMKt2HCo2EcSM7j/uQm6tyqRsX5XVTO1KQimYSuYQ746dFKMJx0Utnc5m77FMyFdOqLzh7GhL73olYp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YEeyxKvscbyWZlzHspAPxjkpB9NEiyBOvG9sYoj+QXo=;
 b=tboD8RktVdyCgPwIHfgVg67wTqFiykOxmGSzQlXhJow0VC6NMLHLJayygEjfTX2B1v8E3l0lwWU4l08boy88G6afeeU1YKn6jbs7L5AFIOeFJKtiFvN6pPpwR+LuDKDcYHvOawCJ5OFxeVBWvN+8/8FEsIrLoAetA+zd1/lgdWG8rAOb/x9uaI4Cwr4MDhPWZUhbLbxDDkP8haViGUJENEkVhqR6AVkiHM/0LRKjtaz1cCOWpOiyax2dT0Ntm9uJFaRrYaY9qm7BsAgqr8ssNwxAJDtXhpJY2YiWqitBMVY9Xhk0GZ2M0tukIjUfZZ+bqD/bU43kIPRJi6DRz3sZ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEeyxKvscbyWZlzHspAPxjkpB9NEiyBOvG9sYoj+QXo=;
 b=ZHS3HcihBI+9wkPNXMlO8YjX9GwgEbUsI9gCKJSf6VaPL8u+6hmYujj+/18DZ0fGcy5y2LJXeG7jtkmb+PBYOLW6DohcWmP3K7iqW47FBwNQZ3cSkYA5MvQFfLS0tuD5VLAmq8xzv3a5FZ27nfWT+xHR3rtrHj+CZaSe5wVs8klQl1yKVqDqbIPP+Yz/b+YPncd6IbKO8n/WF4DwY9w2xFalMXvq+wcwPw8QNjzNOFeF0eKOFNxKW2nA7qpkq5FDBCshdZgYw4uJ+Cfr939M8Cy/CkgxlpkWc8x29eECv/Qv825u5Gewc8z+gJ8L5S2yVpqKqlmnuq+DGY/Uz/zFhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AMDPR04MB11583.eurprd04.prod.outlook.com (2603:10a6:20b:718::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 14:46:52 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::c67b:71cd:6338:9dce%4]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 14:46:51 +0000
Date: Mon, 15 Sep 2025 22:40:53 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: gregkh@linuxfoundation.org, tglx@linutronix.de, mingo@kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
	jun.li@nxp.com
Subject: Re: [PATCH] usb: gadget: zero: add function wakeup support
Message-ID: <ukbhfr3iutrwm75ivin6ru74k5asqccazj2px7ttiltmpl3bzr@brs6e3wnmmnj>
References: <20250915090230.1280460-1-xu.yang_2@nxp.com>
 <95ff48ae-5cdb-4e3d-aeb9-1b6cc33412dd@rowland.harvard.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ff48ae-5cdb-4e3d-aeb9-1b6cc33412dd@rowland.harvard.edu>
X-ClientProxiedBy: AM0PR06CA0116.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::21) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AMDPR04MB11583:EE_
X-MS-Office365-Filtering-Correlation-Id: e5425026-e897-4f60-c514-08ddf466b504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uMQUTjuoQ3pKZn+zCILRwPDfAPdd+T9A4i5/y/EUwzL1FPsaUt8SevKEvmZi?=
 =?us-ascii?Q?Fowqkj39BVNw/u2u7jKBLVqQ/oSQTzf7kchY3nQhXtS9iP/uOsptUxTTz4GT?=
 =?us-ascii?Q?8Krv/xNKqAvxUJfPNu4jIH4N5dkJstAAMGhmp3GG9jS+W/hqSJZJxsuImtGF?=
 =?us-ascii?Q?liClUmoXsW1PWIlPANI1pkO4HtBdd7U8GHYnrjruK5/02sQC1A8ed8+8Jh12?=
 =?us-ascii?Q?UjmHYTGIW/os5cogQpXqqkXYU2r/Zj9p3JvJ94gZg8QQAwxxWG5PR3cYLgQS?=
 =?us-ascii?Q?SMzjlrQBMxPe7YqE7mlsApTWxUzGW9aCb76UX/sk4DBbgmA8ctxMLHvs9whF?=
 =?us-ascii?Q?JHOx+0sUlwXdgYLqQ4TuVH5cprsa9mNawL8FefipOrVDeLy5iERHrXMFH/jk?=
 =?us-ascii?Q?84iNQu98EKNvfkYJUvSvgo+hZsW5q1tBjX8naieJ8swJfE7n6PjOj6yI+OU5?=
 =?us-ascii?Q?cEJYlPxMeFHmKg6khWKcu6TJf2c44Wa+7tMYLer8h0U4e//sNfr8Y9XK0clC?=
 =?us-ascii?Q?LghoCfHeCz7UStaAcGaIM3m8iAQsalRIQH6oA2wDYVVSMvRrJG3mX7Jvg58I?=
 =?us-ascii?Q?hIz+9p+4hGzGN1Mlu63qRZTV/UQkE57M91Fm5s6LQcOJmKwkNKZRjWcptgg4?=
 =?us-ascii?Q?6Zn9R/DB5wPmTYWEeOum13NCpKx08cbx/7TGTSNYYGaZ1dPnr0rVIc/JKqn7?=
 =?us-ascii?Q?TJuxP9FJQ/ZJ8g95G++dRgrumnPDw80oVD1xRGQPyTGBFyYqjIHINcBTOEeo?=
 =?us-ascii?Q?3f1BpsEVjEw6h7j3gybEDWiXdJboATE8pnzpKvckLh7qr68CLqHVvKE9ew2A?=
 =?us-ascii?Q?t8al3ugrCXZlyP0Y1viUzyaNENWbErQWuPPn0SfZcwXXp2f+ksioA8ne0uFV?=
 =?us-ascii?Q?tK4axeEfp6qVelNn2NiE+dqQPfs41SAWOa+BTIyqby/vmR/1PbKpXxFZPLp7?=
 =?us-ascii?Q?02qXk/KpMIESfyxRwet6dfQOczjXdiSBuJmDazA+nGR1v1DRzJUM7QRXovrp?=
 =?us-ascii?Q?qy+ZE1TTZcGnClFGg8W1MhI33D1U/PmYG9r/cBKsVJLfi3C/2U/37+qulkdV?=
 =?us-ascii?Q?OcmJtbraPk76wrMlyyc9bb+YYb3wFn1bdSqiSK5b+kvx01rhnx+KSuL0IAZJ?=
 =?us-ascii?Q?YRM1/tvGLLMp0b7Y8b26SB9iiamPpBMfAczYGC8qryPF9BEOXLhlxAZBKSw8?=
 =?us-ascii?Q?wsWWp1w6P5OJdZak99ftm1W7g+Nr0B9EIYlmDX7RLX9OSQtyB9R9oMiwm40c?=
 =?us-ascii?Q?f/4YHoYRLH13/sj+mafqA6oEk1vSc3zPf+Ig5XZjnsV1otIkjiUxg37evn7r?=
 =?us-ascii?Q?jgzzBuGtJPCmBaR2wP5ZJMMAnOT2pXJ5hDNKxVdIvOcKOqJa2zLbZWj+Fzbz?=
 =?us-ascii?Q?fvOQAAZsvNAf5zwOFcd8cMChqom16BhR4+TvhZ1PsD3FA7iaXVOAluqJv16o?=
 =?us-ascii?Q?QfD5goDRxIEYM/yxy0Vnp23F5JCHCR+1+h9xt6slLEYHTHSI6rbJEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siFAmx7kfqQMHN8ppD7uoyDXiLDb/A1xjvYCH/FMEKS46eLZJtsZdpgFgQbo?=
 =?us-ascii?Q?8SuvVABMTDjXUryvUqjU+w3bA6Kh75gVrE5oFFpDXhw8XV0FL0WuzGM0t1gF?=
 =?us-ascii?Q?M+p+IJlxeKOhxD5eqlgS74/LLoZ4o8Lk2zkWEkf8GxxsDhCZRxYR7FzWhJF5?=
 =?us-ascii?Q?prMTkZ4sl76XHahx8qvrAfEe1XB6D0NSxO61j1X73K7iK+SMWQ8A/cwuOKR7?=
 =?us-ascii?Q?lx31EW5LYgtEeGpW8lvpewHMsGqYmTGMl7r/NMMJ3S9dRLJ7pZB8SuKekcU7?=
 =?us-ascii?Q?65OY7syWsvHfVbYg+EMGUDBSPPZnlnovrVXSU1knvbBL7/yYnZQSZx7SD0/A?=
 =?us-ascii?Q?JsOTxXxiO8n93tY3jQwlhM7RO16yQpmacc+AM/l6zQ8Wu9Sur+AymflF8+UL?=
 =?us-ascii?Q?iRQDYXfRhJWmJFXGcJo0eDj0G0C47a4pWPSTpCPLxfnMyIxowgxXcn2hf6Pj?=
 =?us-ascii?Q?PTQpWcfKi4AJ7+yefdgYUTc61Z++QdGo8OGVe0iIftxf55Ez8Pi/Ki0EzlgA?=
 =?us-ascii?Q?Hiv4f9/qT4Y8z9+IJdh4afiyRH6W7Iyax4bQBV/JriwlI3kPqVuy8ofYsn23?=
 =?us-ascii?Q?FG12QWelayVkPVkbzHDIC7BoO7Z2fWKd9BURJDm6CFgdJVvTuseEUQ+rHQNv?=
 =?us-ascii?Q?wyWXsMaSsB9mdw0awMjNbJw7Pysf+74Xp7jfJ/t8dBH/CKDZFDTEaOaqOVsk?=
 =?us-ascii?Q?5GUrltBj1Y5P85hQU94zf9AK3lu0UgrCA+Bh8GcE3ZXVQshBMkgIML+tfPIj?=
 =?us-ascii?Q?apLztPvCwABE/TckXthyqutpNrdH/b0SFTmxo7abnZCLcjSk5n0zVaQ/eLxW?=
 =?us-ascii?Q?XO/nTiOLWXhAleRpAgT1gNSsqNfRK+PuLmrTm+j+Eu1zHDFYiirBgbHdnCxz?=
 =?us-ascii?Q?Vr1E7pcqDHp+abvb2DrkrclVMUIiXow+J8cy6rPQ5oz3HT9v2yJS34vwPIIK?=
 =?us-ascii?Q?7kyFMFK3sOMKByVqdHHJR1knFPiK0IPZ/OGPTUHcDO1e+xHjw01RpCFFCel4?=
 =?us-ascii?Q?NAxEbp7Z3sBCHicPCdChwi3rJRnGTOllaExI2nsaXxIqwdsQNccMT1No+eie?=
 =?us-ascii?Q?BrosRTyVqrdgGy4PN+JKziqxpBMfw80WwcWLYS6TVfhEkhInrFJOKQxRacsH?=
 =?us-ascii?Q?Gj3oAddBNv2kyfELtJKi334FalkabzD9o7wbjk43EUZaqWbLa+KDMOs6uhgE?=
 =?us-ascii?Q?gIItWEMGlY+8O17+YdSP2epzQqPqSPaAKttmLJwu8jf+TICwo+HRenOS4RN8?=
 =?us-ascii?Q?/paNIHiew8YBxfy+7ZvTQavsXM2ChDSu7sKZ6IUEzsxT6RsewRkQWQ1FcieX?=
 =?us-ascii?Q?OxXzSpTpRoaUw6V0dNUewQaAU5Vrz1WKL9fh5nKI8PWhNoSTt+Mim14PhHRU?=
 =?us-ascii?Q?/xjqWW0Ob6qj8rXzCqNsInrzTi25nOLqFcCeWBGxP7aszGvat1ZU3ObeiJb9?=
 =?us-ascii?Q?1ww+6d4xk+5UXrM4zXqTkrhQ1yPz2FtyZYQ+YWjohfBB1wmg3aF91s/RrhFw?=
 =?us-ascii?Q?81XCxLzFZ8+8Jc9/l3H+usHDVWcNcNND/T75PF/BRpbCFVevtMevVUGOMNQ8?=
 =?us-ascii?Q?zt8tt0R9uPEtMAYvWjynJxxcHGxzxWbammZni1YC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5425026-e897-4f60-c514-08ddf466b504
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 14:46:51.8988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3k4XaTf+o1PpyLEn+zWFRQgDFAflISTBtYTTa+OvXsQJhtUiBwOFkjnk0CWAkaXmUV1br+QOjnGLenK2wQzY0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11583

On Mon, Sep 15, 2025 at 10:05:15AM -0400, Alan Stern wrote:
> On Mon, Sep 15, 2025 at 05:02:30PM +0800, Xu Yang wrote:
> > When the device working at enhanced superspeed, it needs to send function
> 
> Is this also true when the device is connected at regular (not enhanced) 
> SuperSpeed?

Yes, it's true. USB3.2 Spec regards it as SuperSpeed/SuperSpeedPlus.

Enhanced SuperSpeed | An adjective referring to any valid collection of USB
                      defined features defined for the bus that runs over the
		      SSRx and SSTx differential pairs in a USB 3.x system.
		      It is used in place of phrases like SuperSpeed/SuperSpeedPlus.

> 
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
> 
> Please use the same style for your new code as for the existing code.  
> In this case, use tabs to align "status" with "*g" and "*cdev".

My bad. I will fix it. 
Surprisingly, checkpatch.pl didn't report this issue. But it always report
a line break that's not properly aligned with the parentheses. :)

Thanks,
Xu Yang

> 
> Alan Stern

