Return-Path: <linux-kernel+bounces-886756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D8750C367DD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:53:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26209501291
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C13532ED3B;
	Wed,  5 Nov 2025 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RhQLhg2o"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C397E30C37C;
	Wed,  5 Nov 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356921; cv=fail; b=RdHl9a7gCMSsSqFSH2SIPiRb90hUi4vkbyCXZ+1LRYGiHdfdxj61DVI+HNmNDWp6qG6Y0yeq52SixViH2ivaKPHi4vKaeEATsaKIYXqLnJqh6CtZv4uA4oJvSlAuqCMGSj37hTyMYPyma+TNaqkJmjmRJ3ESxoJI018Yx7rGZjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356921; c=relaxed/simple;
	bh=LTHz0kV30E5YLsgvXcZmg5pGWm/NJDZK+Lyf+Rbu98A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cq0VFz8nRiaXUbCaVtwVsdsnu6t+pqKlKfkJm/AF+X0xLeUQAs7PUu0iz5yTqf7i0DzW2MhtvLikyYBnZUK/MkSsWyPznE89jmQpHb7Yzz9zXDIhlWQgSmFC+oHf2FeM69NO9TIkPjhyoyNU9XdxkCYaDQBDKGmx9htDc00lVbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RhQLhg2o; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdSjDo+e1jbauiD4ka0hpNBaMoimeZLGgxSWwRGh/0Ki4JudPYw3N48DnQMA3Do+EOt4Ym1MkNzPDn4ouza89w3YkKlLFS/z/7F6a9R7tg9qkAlAOLGZgP1QRR3DwCChVe7vhgrrOD59gUBrW73EoigugZazmNDreVhQ5ZJDooIiusnEqdmUCYPIMAEx5aenzAw6hDzdqtyznkvjYtpRNZyywY4I3dXLs1Tt+A0BzAm/iYhEsFXaagp7u1sqz626d7DYuaOIto3mlVpBVjFhhLT2H6F9brpcqyyK9Qh+b25maIuhJqLkpVIP9SwVTaEjUkloSNgK4KGL2qAI6RoW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfl6drOX55v+jj5q/MGcqKoxlXVvUgOgmLTXKvvOHKo=;
 b=Zk5GbXC2FjsT9/zx+Zd7ftoZLUhn7hz+FUnFmq+hl//zA3Rc99sCZroaEs0rcPdC69Djh43bL7LgD0T4BOmdAnY7Pg2VqaTQek7zv7Qgy7DDPT+IU9+SzwS+dqeWc2iY9fAGlWNBGloe+La+wbnoM+GrUO5aBF3GaCBQgKAguTeSJLL2213mEQr4u5//L1tllpSqrXupXefGJINoZaK5CmNWkUwROZNGGaHFgp7LKFmVkSCwQv1ijj232XNMuRTuQowKb0EVFuNHgIbW5mrkotz1XEfzkSPD9rRbr9IXbQTvzqtPIfCkvcLWfpISiiwj9Nfg5G6RiVuRGIy42OB27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfl6drOX55v+jj5q/MGcqKoxlXVvUgOgmLTXKvvOHKo=;
 b=RhQLhg2ox2uOEyUQOstHmtcu+SMjrms+QooRPWTWnc4PmYaeQ9gZk8iaOM41a/LV1Dlu2MVnllFSR7O4KTgyX1pciQnahJ7M5zJ0BRhTWxLSru4lZJf9KuF/KyqerTKdx6lnQ5+LEFdhJkC1+iJPRbMoanqE2fSfu1dNAtxZqjS3f6Fg6RthK58PKwifsdVS8QSB6AlpMf8C8xDBRUZvl+jOV4WDgXeanOOXGL7ygznGMUOCVdPN+wZi0QNUWl0EqBOiCIlasfka7mrQTL7xhIqAewlX1mLTxkjTEUsYqkjRkgjQTVgTPFr7xeGw3ndwR7GQEZF4IXiK3bt6g+3ZFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.8; Wed, 5 Nov
 2025 15:35:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 15:35:16 +0000
Date: Wed, 5 Nov 2025 10:35:08 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, jun.li@nxp.com
Subject: Re: [PATCH 1/2] usb: dwc3: drd: extend dwc3_pre_set_role() to extcon
 and otg usecase
Message-ID: <aQturKeWoeCa7jpT@lizhi-Precision-Tower-5810>
References: <20251105074504.1427926-1-xu.yang_2@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105074504.1427926-1-xu.yang_2@nxp.com>
X-ClientProxiedBy: BYAPR08CA0004.namprd08.prod.outlook.com
 (2603:10b6:a03:100::17) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f04395b-aff0-4c08-841f-08de1c80eb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8RqYSXOONy6ASc1mJKnafgF+XRdojUYxYYuMRDQsCdP1MqcAQeCE4mUhhLl?=
 =?us-ascii?Q?2V3txV8uIuKiRPGIICXcFb/0cetC5KZZsUEUSPJdHYqT/Fk6Q3kGdskgjqt1?=
 =?us-ascii?Q?qRGhjzoCxHokNkRH+PZt3u9rQbTXTSgLHGOG1kC9CQaFc2Po4yM8uVSXfGuD?=
 =?us-ascii?Q?5270puK99aJwNF2wrBzyMUSqj65VTRIuRPG1SyDLEI02nPXNV9gLmmjj18I9?=
 =?us-ascii?Q?Flak0Lo/Pj2UXAtnTlzL4WpDHgFmVuUh9wJCXuDYqwnVjgTgfv/a67lmOnT/?=
 =?us-ascii?Q?4ov/2eRT5IN1Gy6PNSBy+H/yxP3+bllTjeDHHvM2vgwooPn0sHXcUHFuI5+y?=
 =?us-ascii?Q?/gfnRWi9eX4/UJpj4oCK9MYCj105NvHnUmkfSg6LrCgc5Lh24IlInRjEoot0?=
 =?us-ascii?Q?pX21WHJt6AAz8W3Y+gSh8sknINIScLL1QXpDGoF6Zz3IATICJUrM4Ydoem6a?=
 =?us-ascii?Q?0sM66osi8f34GjmTDEWVSEcaLiYbGcbwAqFcE2KV65R75+chFqi+LdgUOEse?=
 =?us-ascii?Q?QF/RB13aZ23RwpJ52GZcwHi0b6MhIOp7gD4wvAs2e2/xM7K/jKWHHvZr4sdS?=
 =?us-ascii?Q?af8cdPH4pzHLqDLBSPgUzCUQ5Q/BfzjmwcojMuSIkp+lno+oqo0OM6Q24HNe?=
 =?us-ascii?Q?TIF9UzpCWElCB0jHK0w3V5Ku2pnG1bs/hEiCFcHbuKOHzODFYcz1jlaZ7WIu?=
 =?us-ascii?Q?aJoOoOFa3CALXiEs+IJA+xRJaNiIxLvfrUip+4fs6ZkTfym8rgE+lwV9kysW?=
 =?us-ascii?Q?WLXItFCMO8ZntbsKZ7j1CSONTM/QW0ZGaQ/A4C7sIKYD5Ad+4TEgU2vDfSSQ?=
 =?us-ascii?Q?PG+99nU31+BgQlyvApP454ceED7yzHzVHAh8ki0E9mq5IvU4EXGj+LOfbM1D?=
 =?us-ascii?Q?UawQts/8/Tn3UpELprGp4d8u4m8tGfQtpuiTbH/nj9WbsjDiM30i/79QjGiP?=
 =?us-ascii?Q?SkRUxSk228zgJJMDsmxoVIkXducooLV8uGUtWOe78hvJwx5OCn4y1xUjU99C?=
 =?us-ascii?Q?bOYHA3bZ0sgOdIbXzJnSxG/gZem54btezCnyzvedsRVcU6oCqOfD/+4onBXC?=
 =?us-ascii?Q?MaoAj/PhUehqk8RFIk5zH7tzggRZabU3EQOaZTL1Y1PUWjYzujM85p1JRRJ4?=
 =?us-ascii?Q?I6SxGJikWNRSgXfc6RjD0wkssatlH7oKVqVMHFJIJBixjHNeIRbylEnbbyNB?=
 =?us-ascii?Q?GpNnMAQEEcNhnDSbN1xDI0Nbj6mfVbTMvBEa0qI9uOqU2jcXekzI8qyArrZj?=
 =?us-ascii?Q?1v4blX1GVtW3YwIDZfBgdGlhin2gudT7ZLuUoBI7KZ3V1nZgPTuNl49kEqX7?=
 =?us-ascii?Q?pDWFHclJ8henNI5d57ZX5KpZ1otyNK9tcbq6Qw/+V+V8JLPCxsN1+pIOcAlw?=
 =?us-ascii?Q?8MMwFugFH/X063lTyXW5U+XJDN2qCeuuqmcYDQ1ieiPBFrZ50n4XktloLqQ9?=
 =?us-ascii?Q?y27bonQ8oS83hmK5hNX43t8jEq0pafB8nwcZPtg1dv4FxqVaHVHZyZnPFXUg?=
 =?us-ascii?Q?lFEQDV2JJ/3g8U8SuiI79j1ivN2wyuc14YK3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3N3lrl3VJz277IAxvscjrqFd9UFglNU7G4gDORuCNO2dT2gO0sAkNHSccMhZ?=
 =?us-ascii?Q?KfJrnYbVUxR/PT8eenvTooMPZcilSVLSoam7YMu6Sp0/62W4/uXfXgDuEgPd?=
 =?us-ascii?Q?Q0aeWwLyfk2o1Llay0I86hvQSBoXi/x0OCy/HkqJVSdNp7RTJwtnFC7r/Zg8?=
 =?us-ascii?Q?PuYrniVbt8YFnFfGzN+XPozAAUJZtrfeLNYX4p09j/dfwVYjBcr3bSOsQAeE?=
 =?us-ascii?Q?qmTmBcwbXpVkUF4xTZ5Hrx2l/uR+0Jont4FrmgtOqtcR747q+7R04IG6rWUB?=
 =?us-ascii?Q?72FPfuCq0ODdE8ggj6JE7uEKwR4df1ADI7DqKrogJ6FUWyHYo45VdyHqEJnT?=
 =?us-ascii?Q?/UHuvanr1leYPtBXqWQRbFolgWO7bG0tsTqR1zEr0H81F10zoN/7hvex3Gtj?=
 =?us-ascii?Q?loZgBnlC0tW5FMhT++dGIx6GSIuNlG1yu71opdT/5g3YAa8WWRU+b8Ba5E5C?=
 =?us-ascii?Q?Y3JR1pSnOo3rwqla9gTyUntPhsxFRK4x8U1C6GNeNB4fK+/OkCM4nVHm/3nE?=
 =?us-ascii?Q?T6t8xA59zJNZAtwXOymHR5Csi12ClxoEKnYhPr61tIn9FWFUbTUQaJivozRG?=
 =?us-ascii?Q?kVyBOZqHF1UtvetoeTafcJD3LS9IIvZjvhzLCGAvdA1fLWhLwpFkMRVPsyuJ?=
 =?us-ascii?Q?d2urSY4d2I2TdUR3R6aRKm/IoWrUFoinKkW5NGlntJfm/J6mXP5WtIhecY2o?=
 =?us-ascii?Q?sW7X96dOyS26aFYIDj96QfNy5FafIF8zH/jnmfHhOWUsc4zSYdpKneBL8mGf?=
 =?us-ascii?Q?Km40N/aGxwDWxQb1t9xv8XiBx7EAfxAB/il4NoRS1oeRvP32/NJII4o6Cn9d?=
 =?us-ascii?Q?h9d6+2+217fRUN+ecL4gUyrHJfk/Ndj/KJQQjkkPNlzHZaXr/1rvCKfbc/ju?=
 =?us-ascii?Q?cGCd/9I3qJiEXo6W/kGKAG4HefZgb7JQ2p1ZFVo1177oCLvtP/6Hnjl8UcuV?=
 =?us-ascii?Q?ycDcLlihNAnI/H9Yemdk561WvWhG19ykee6co0jGMLeJHy2gKyiCiF1HRqs0?=
 =?us-ascii?Q?iBhJbjAVL20bafv9UU3xb8lGL0GJgcCv9V9IBQHTJZ3YLz4pGmSnwj+A08e5?=
 =?us-ascii?Q?P4UuqQFHKjVLISyIor16fpiDjwHKR3fZhDcTOiY1kppkP6drGEvKFdQI4fT3?=
 =?us-ascii?Q?WvswuC+AMfR501r/yE8ug+RIcbimoGMDTHz8i2b6SShHRoVCAsoPRuR0KesD?=
 =?us-ascii?Q?JQyS+AEann38h9/YJ4u907nJ2BwnF0gFCazZqMiSD9ZSt+cRBDDB6zd2EcOw?=
 =?us-ascii?Q?yd/OpH7kz3g/zOirRQSzvswTQ47paQdQJfVxho8DknQHLfoOjNbMYN0+h3zN?=
 =?us-ascii?Q?7/x/stVrjc0iWqpNLJobZm4vT13PEOfoTR9T3gtlfPEM3XSRmSR6s8N9Uwfi?=
 =?us-ascii?Q?IbdpU2HxH/B5xRR9vvUTmkNDNP6c26aAcot+BEpG+/U9n/cbw5WRbueu6J+n?=
 =?us-ascii?Q?2aG1Fz7d355eyfCVVI8Zux8avtl2Lh3MGJ3qUARPcyisu17Ad4WuQXbreQNS?=
 =?us-ascii?Q?BXL4gGPIQnYw4vxWT8VVU6dT1NMDFq5DQol1m834WPB7oaiEl21j1xYLowwC?=
 =?us-ascii?Q?npPyk33ug70GTS40LmY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f04395b-aff0-4c08-841f-08de1c80eb84
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 15:35:16.8196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owIPH4WNMFKfW4uX53i8JCGr+9bexzGhVK3mtgFCo7a5I9B7/l84IkrosTDQhneZrOEBXV5jcdtLaMNIEIn8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780

On Wed, Nov 05, 2025 at 03:45:02PM +0800, Xu Yang wrote:
> Extend dwc3_pre_set_role() to extcon and otg usecase, so that the glue
> driver can do proper action in case of role changes.

Nit: look likes

Call dwc3_pre_set_role() to support both extcon and otg usecase, ...

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> ---
>  drivers/usb/dwc3/drd.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
> index 589bbeb27454..031cfd12300a 100644
> --- a/drivers/usb/dwc3/drd.c
> +++ b/drivers/usb/dwc3/drd.c
> @@ -381,6 +381,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  		dwc3_otgregs_init(dwc);
>  		dwc3_otg_host_init(dwc);
>  		spin_unlock_irqrestore(&dwc->lock, flags);
> +		dwc3_pre_set_role(dwc, USB_ROLE_HOST);
>  		ret = dwc3_host_init(dwc);
>  		if (ret) {
>  			dev_err(dwc->dev, "failed to initialize host\n");
> @@ -406,6 +407,7 @@ void dwc3_otg_update(struct dwc3 *dwc, bool ignore_idstatus)
>  			otg_set_vbus(dwc->usb2_phy->otg, false);
>  		if (dwc->usb2_generic_phy[0])
>  			phy_set_mode(dwc->usb2_generic_phy[0], PHY_MODE_USB_DEVICE);
> +		dwc3_pre_set_role(dwc, USB_ROLE_DEVICE);
>  		ret = dwc3_gadget_init(dwc);
>  		if (ret)
>  			dev_err(dwc->dev, "failed to initialize peripheral\n");
> @@ -433,10 +435,12 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
>  			     unsigned long event, void *ptr)
>  {
>  	struct dwc3 *dwc = container_of(nb, struct dwc3, edev_nb);
> +	u32 mode = event ? DWC3_GCTL_PRTCAP_HOST : DWC3_GCTL_PRTCAP_DEVICE;
> +	enum usb_role role = mode == DWC3_GCTL_PRTCAP_HOST ?
> +				     USB_ROLE_HOST : USB_ROLE_DEVICE;
>
> -	dwc3_set_mode(dwc, event ?
> -		      DWC3_GCTL_PRTCAP_HOST :
> -		      DWC3_GCTL_PRTCAP_DEVICE);
> +	dwc3_pre_set_role(dwc, role);
> +	dwc3_set_mode(dwc, mode);
>
>  	return NOTIFY_DONE;
>  }
> --
> 2.34.1
>

