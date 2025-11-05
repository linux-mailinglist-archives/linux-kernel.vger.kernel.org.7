Return-Path: <linux-kernel+bounces-886868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1247BC36AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0139665EA5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA92332EB2;
	Wed,  5 Nov 2025 16:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bp2WKdEB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011043.outbound.protection.outlook.com [52.101.70.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E112FE078;
	Wed,  5 Nov 2025 16:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762359199; cv=fail; b=YF+g1OG0BAdkAASrxAb6Y0SXAJhfUDmV+EF9GT4J+kmIAdTaxgX6j/gUMKZpNBCxPEWQ9w0efSVlwWD8DJBWTe6DbPEyGrjbLlkcpUMXMue9CaS1FPeg9wG+uhVu31EWGCMEam7+go9AULwVvBPk34VH2QHekK7AuEq0eueAiL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762359199; c=relaxed/simple;
	bh=wj3bdUP6E3t/qdvENVDxLcNiJdWO085tudD8ej3qhcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OmBbzGTRLWgp3lLuKRcRgvFfyqzYEj1ijmxnVrXEloj150fAInOhB+9ttOvMBHh0kZeOhIHUHOBDnuUvZ46g0uCj4rCGXYlqyUq2vfGzxtTGBBkvQaCdLapvszINpdJXPD5K+9TXNuwPX0QczDI5EXMD3j+SrVFzMJFseODyN5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bp2WKdEB; arc=fail smtp.client-ip=52.101.70.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAr7+EJ0c+cak+571FQYa83h+g0+Z3j53eh8OyWJceNJlLAHuOVlYdxT+km9cRbbOPJHW/dnYtrq1zvPOz/VXJ7pW9Gtsx/wEpGrU/2hHYBdlTPrCIpjx3q3iwe53QO5Uvtqxsd+pgYrbIPnlUsnVMpFqDgu2cfh14rmYJlqsDXUEVLo7aTc707xOY7b7BHYbP5tQW5iDLGOzL+Lts3F0dFpFULTuvLtmQrFyMhik1kM5XlgcA2LsvK3bD0YG3ZfQ0zZkOcPuskXLPzYzO2butmAiRmSykAa/elvPD+bohqn7dPT/TihGHSg8SX9eQ3kC0pJU+xSpTA51N01K0Sg2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPtLryQQWx89i+zmKj4fWT5f6CWWHYksI706KvUuijc=;
 b=ANi3Pd0AfjSkis3Bcb8jdtcoD2s3VLAV1WAZWExvNLj94KvBYLg3BJHtnNWRZVNSzAlPX9Vc8XLgfABcSfkoDT8gPEYQ19kpemnv3+glhkSrafTsnXHvZegTyJP8Ke9gh1SxhhM6QOcrch+vntKE9M4QX0rGCzbeCta/HdYS1UrYImKZnjkBRrMHOYJaA2VHaKL3GsM3MLAk4Vm8nNPbJETDjHgwze3ljcaoZcx2iAfeJBWLqcV17xPTEsmrRcalM5AHfVwthoK5UgvUcS+gRztcMB+wiW7phBk8+BnhVOO7mUFpIt95AXaqP6fYY8R8aKtEFqGnNXXvsh1eJFdilQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPtLryQQWx89i+zmKj4fWT5f6CWWHYksI706KvUuijc=;
 b=bp2WKdEByi2yCrjF+sXJWcwlW9wvtzcV/mlWhbO44dXw6rV8loLcwOzctG7RjnbxPxWdi9T+XP8b2fuSeCK0qFS3l4mwjUuAawaSE4odzWAB8atAz0Uii2msoPBBbX/cPVlMy72tMkt7lCd+nYQBtjIEF/uNZ8hHNiSmzQ0qbaMDu65aqofv4a/3Ecx1idQlbw+khT+Voaykf6FGow49WTyu+3Te9OeXzNFgPnnPh+kn79A+2L88TR9mbsj4VFbCA7IoWHBTHoYYfO0SYFgdeesvAi8TKA+ILWnjppVEp+vXNFqCpGSQi4s96Jf6vXeOCWm0uWG1pe+ywyV8YpTUfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com (2603:10a6:102:20c::17)
 by VI0PR04MB12078.eurprd04.prod.outlook.com (2603:10a6:800:313::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:13:15 +0000
Received: from PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad]) by PAXPR04MB8829.eurprd04.prod.outlook.com
 ([fe80::cdc5:713a:9592:f7ad%7]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 16:13:15 +0000
Date: Thu, 6 Nov 2025 00:06:36 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com
Subject: Re: [PATCH 2/2] usb: dwc3: imx8mp: disable auto suspend for host role
Message-ID: <63knf2kyyqmo2znym7suhb5ua2si2xse7ptufoo77jkddldjyu@3hat6xulwgbe>
References: <20251105074504.1427926-1-xu.yang_2@nxp.com>
 <20251105074504.1427926-2-xu.yang_2@nxp.com>
 <aQtw+dNQEWkKxs5D@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQtw+dNQEWkKxs5D@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SG2PR02CA0081.apcprd02.prod.outlook.com
 (2603:1096:4:90::21) To PAXPR04MB8829.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8829:EE_|VI0PR04MB12078:EE_
X-MS-Office365-Filtering-Correlation-Id: e947cbba-7c4e-4092-ac17-08de1c8639bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|7416014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odfF7I980FflcP+U3abM+Vo9lloS59fXIZ8jnrOM3u0BD+hho5rwaNEP7Fw9?=
 =?us-ascii?Q?SOI4UQFB0T10vcDqYcE2fTdgIvkoPDdIw1PeeKvRFcCiT09B2Nao5EGJxHu5?=
 =?us-ascii?Q?2lnHpLObLSRgHyCEwSFkUMlgbX/xACUoyMtcHJv5Z72EYBpgD2WQiR5Zz4iP?=
 =?us-ascii?Q?M22YGYtN+B+4ebPm0UwCVDpJsKWFQcVLkZ9LawyEbqokwhyiycLHf9C/bWL7?=
 =?us-ascii?Q?kLzZb8ZWERdcaKtMtK/PmN5rQAJRbj/3EJEfaQSiGbH4gRQIVNBJ6M8NHz5J?=
 =?us-ascii?Q?IsQE71b3q7ZGZeOYyywFFCEgnrICnu89tSvpJPbSaAZL370yoWWuS7uFEp6d?=
 =?us-ascii?Q?EE/Bs27UOsquBW1nJk8CQPOWD2Bxu7wp63VUSeQYD7BC9Mdtw13jNgu+VTOC?=
 =?us-ascii?Q?gFDwoi5IEc28bAqXhgXlpGTX4zdzOgx8FMf/f2xSgbPo5nCVReV7Dx/mV4YY?=
 =?us-ascii?Q?NyJA+P48st3a+EiIJ8kzYelHQMbyNt8czfEUzdB8HXRxi8QBIyzOhoMP2DlC?=
 =?us-ascii?Q?OR2zlpUY2N/ARvZGyyXXL9pUjpeDgsgD+MO/VaOTYs1WQEY1yrXCz+3RYslh?=
 =?us-ascii?Q?4i4/TSmHE5ASIU41mfZzyqFaEe4iHxtEPlzXGBylYnUJI+5u2Lsgb8xAaGPo?=
 =?us-ascii?Q?DGZQ5QOyPCO1Zw7HXrMLHmFoDHpuk+tCX0yefwStlx6LGNLm+AnBsq6+8ehx?=
 =?us-ascii?Q?BSNUx4X2IzwflOqxx9A7E5YpxNeb894hWnAVMjylcfwszSZp9CwHFmJM/MwH?=
 =?us-ascii?Q?cbJxFMPT70H1eLlB02sNWDbf8xIG2rbAUdF3z/zos7AgThkRJMKQbr+MIP0V?=
 =?us-ascii?Q?GDM6lMWXHj9jF1+Xo3CNMQ6nt04ixFPYLkIbz1CmGlSS8gO06q1ZvPFhTi+F?=
 =?us-ascii?Q?RNgBGUgqYPT7Za93chW3Kk5+KLV9tYC7FDIlQdBRjNEHLseznl38on2kBBjn?=
 =?us-ascii?Q?P5zDzxggrwpSp5mLfLTNSu6stqdLNn6kzRXDXPQdhZ4ceCSBoAokcm4+HY5U?=
 =?us-ascii?Q?u3YEdam/l1F+qDCjNCHx4zcUp4lkXcUQxDVtl0Ksz0UGNHOkJnZ0PBEVY+Qi?=
 =?us-ascii?Q?KKj7S1ptUvlU0lp8IwOad5L1+ss1u46rxuGF2fqlzw4MgaLnN/LU40Kncpy9?=
 =?us-ascii?Q?eWvTNNgXnDMuzH3qGfAve5n++BpzPVO8eUGkQ/kIoqloKmm9AwwezvdOYjHQ?=
 =?us-ascii?Q?SolZwo3OJrEDI7teBTc+93PLMJfuurA9seCIe+fVZWnDk0RRUqIVjYxnIaY/?=
 =?us-ascii?Q?Z6sKbHR7wuZVOkH6RPAqc/I/oNn0aiT456G5FD7wMue/wvS+vf5uU4xowYjc?=
 =?us-ascii?Q?GV0gsviNMr2DzRduKt3TSX2nH2xS6eCh6mREHIL6ulm1zioU9rUMQlD96aUw?=
 =?us-ascii?Q?13UiUQFWG81ZR8QumM0ePUYVHgEZhFIujQ8c+i+CLFVavipE5oam/bAYqTg1?=
 =?us-ascii?Q?nAh4j8Qu1SpHvhXUx+1GZBL6Frfs9CgIrJqFAW46VIX/rG24LAr8rUzJjVup?=
 =?us-ascii?Q?/l0NrKyFmQYzyx1YvoZCJtWbPCrBV3nFIgq4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8829.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(7416014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8t3ZPcg7SypRbI4tpJKF1i+gOYvr3RHW9YbmCulkXbgSyvNqGNkGQuOR6aE?=
 =?us-ascii?Q?mGW96p7R0HPayNtg/joz+f8yozaZk7BvhBXd5tYubij4YCoxJ+pYwE+QyL9e?=
 =?us-ascii?Q?VhUgUG8Lv5gN7towz1bJmDMhgrtW8nduh1s2N3d5JNTex+PdeAr6UsqVn0Gr?=
 =?us-ascii?Q?jTig94r7glszzz/13ssPmE4XfSomI5U+FA+urZptROWGmGGTC5rKNNvbNAPl?=
 =?us-ascii?Q?BSzWY93ZjflBk3PkHr5mb4r5QIdrWYzKzh3S1HshcqnlbRJDDubrz9M5TOMZ?=
 =?us-ascii?Q?vSncs8tMgOk9/YxDe3fAfSrL3VT2Q/W7y7sSGMM3+2WdlTRGt0N7dCqIb5Vj?=
 =?us-ascii?Q?d8HpfbbiN+ya25I9QK9U7HxvxGDCN6I7I5t0p9oFwDwfkkSrRKda64wj3a6t?=
 =?us-ascii?Q?XD6fW6YG66a/aUWad4DrlqBQhrFgnbRmXx5uGq4Pli1F5qCDEkVgSpePapoI?=
 =?us-ascii?Q?/rZTXkEghJKoURf8TyWb68a0b8ntns5c90C//BKnRuvNzpymxDRTaEA9K8WH?=
 =?us-ascii?Q?nZSkIiQf8jojzXsfqOH3oazUGexuiM5J3cQtWY5wGJbOUKS6hiO0QgPf4jV2?=
 =?us-ascii?Q?HiKu8gJ3q7t2oU3C9FPlgNo4ZxpAdR6ACOJdneRUPD+6bo8yoS05C0AITyRA?=
 =?us-ascii?Q?4mkmxcQh7p7YO8Mt4P9B5d1gSZiZe3FPY2fUexTW8mu3N1FSUIjAo0fE0Nuq?=
 =?us-ascii?Q?Wt97hDOze1C8wRIL/hhUttlKxGNoCk931CiFWhlRZ0CfjmVgdIWdFVivOFEn?=
 =?us-ascii?Q?HJMIidPJe4as/Iu2ZWbs3q9zaf0RL9qx6XU+3defx9WLNpakrvsDIGPsgLtR?=
 =?us-ascii?Q?79lXneJxM8zIIaeNUuGE+kVKDHJLVh5yBZj3YQj76f25EzjKcJr+oSivmF+i?=
 =?us-ascii?Q?ScpddypxrkRFroR5HrTG34B8iaHuq6/fAg40mPP5ec81fK60SZzrooVkQ/87?=
 =?us-ascii?Q?8G1SljJhfh2MN3zo9Vzwr8w0p+uzjXzWenKWUQwtNx1xY80hDUxrtslmJQRw?=
 =?us-ascii?Q?+fIZEmOxlP6pEemOAXXm1aCwVQdn6Z5aLX5Id2ITUfQUcWNWMPbHyt6hLsoo?=
 =?us-ascii?Q?fcPo4Ek2tQbFNNGMNedBtVGjP3/BugboZnb9L+Q4DtPGFhhmh8UhrIZGOKjn?=
 =?us-ascii?Q?9tp3Qe3GbwnRjhFZXPMCB9896Oj2CAQW6KS3D3gksMEl8PVGfe+Ffl8XRoEG?=
 =?us-ascii?Q?Yx/+rnNs8RGXjEEy+asrZv6ZM5k+UTwNfucCheyZtau3xQovolBqeFsqrmnt?=
 =?us-ascii?Q?FHxIy98TjqDDkvNw7QD/SU2OdBmo5sWlVsZaeELw1EmntvwNuvdT6OdV4Lq4?=
 =?us-ascii?Q?U26yeLh66+jWN8E346JO+MwWq35ExqHKKIpW6+F/fO5EBvE8ACjNWpnP8PfA?=
 =?us-ascii?Q?3KIIGSC19kMdjKrt/k5LWDLfmAjouK2LKuBKQid3QPe9ctpcDUkHKKbil3YP?=
 =?us-ascii?Q?tc+VZlGzF5p9zsZQ5qmro9rVETKaQLrqT/Tgl825QsX2CausZ1qwzqUFalSr?=
 =?us-ascii?Q?NICCM7m0oLK1LaHtl8HwgVpjmymXPGH3EwIJbJKg2KfIdGVpBlX/qGi9m1sl?=
 =?us-ascii?Q?ngBrYXFJz6ejueLJ/twetkkHVhtJ30OdGURkgOoO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e947cbba-7c4e-4092-ac17-08de1c8639bc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8829.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:13:15.4571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52shyonmxu9hR1PhzJZbCtboL4t2Pvy+7wyySyZM4fZ6Ai7s8mjbQ1yrvaWOTNHE7WfnPXRqjD/tJ89uvDnNIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12078

On Wed, Nov 05, 2025 at 10:44:57AM -0500, Frank Li wrote:
> On Wed, Nov 05, 2025 at 03:45:03PM +0800, Xu Yang wrote:
> > Do dwc3 core auto suspend enable for device and disable for host
> > , this can make sure dwc3 core device auto suspend setting is
> > correct all the time, the background of disable dwc3 core device
> > auto suspend is to make its parent device suspend immediately
> > (so wakeup enable can be enabled) after xhci-plat device suspended,
> 
> Does wakeup only enable at runtime pm suspend? why core delay runtime

Yes.

> pm suspend impact wakeup function?

If xhci is suspended, I mean the wakeup function comes from external glue logic.

When xhci is suspended, it will stop host controller (RUN_STOP = 0) which means
it can't detect connect/disconnect event. Meanwhile, if dwc3 is active, the
wakeup IRQs (in glue) is still disabled. when a device is attached, xhci can't
detect this event and the external wakeup logic is still unfunctional. When dwc3
is suspended, the previous connect event can't be fired again even though wakeup
IRQ is enabled. So that event will be lost. 

Thanks,
Xu Yang

> 
> Frank
> 
> > for device mode, we keep the dwc3 core device auto suspend is to
> > give some wait for gadget to be enumerated.

