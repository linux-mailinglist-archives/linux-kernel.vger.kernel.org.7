Return-Path: <linux-kernel+bounces-735285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5151B08D41
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868333B9ED6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0002C3276;
	Thu, 17 Jul 2025 12:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bc9vzprf"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010041.outbound.protection.outlook.com [52.101.84.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD9D230981
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756226; cv=fail; b=gTsusIaJg/BRx0i2+ytPaJkMTWXe63MhItuecvUe4VHd7gqNVJOWSRVbhAGD3jBNJSjXnVlh1DfKVRU8UD8n5Abvfxl3yA3tk+eBAJzAAuzygV/evzTb6R3Oo9jQLOz4zAVlm2dRDIImykHiBlF8t43Ej80RmDNW5eAf29iD+WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756226; c=relaxed/simple;
	bh=NJlvF6f5rvR2AMnfZO2Ry3gLAIcHZZ297Bp3k/2nO30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bfi8AWFzkMxczSWZKDS5HjZBXkLhaAe0IKP0cod3+zTksPRNeq4fLid/XRPH9mI56H7sLIyOOQGKrfxTQZayQMVEX+7Pw3qgGxwKaobKcBRhj7r8SO01GWNn2JVPmcg+KbsAsXmRxVm/DrAaekKoyRO1LfCGcKgdCSIScOHjNWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bc9vzprf; arc=fail smtp.client-ip=52.101.84.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dD8On85bSgdX2tTps3+9z8v49cmi7CqxhYdpXpY/UaqRzduznChNfa897rp1p9r2OsX6PxB72zkNCdMYuy5vrnEcLgAgnixWlCDqyZcO6tvUDw/rb2Wglq8nndjIsQTQQ69IvhurdFr+ZNSlU288SG936cj63td+6soPXRwbhocWKdLdmU9MifJJ0TD5xzmh5oTQNA7X5XW+eImS4CS4QmPUj/H73NvpLsnRBHYnnm5qJUX1j2Cn4xMrEug6/ScC9ElT3j1SHiwN9/dX+oPcypSdMLsyoh9fOmwrHjDOcc1venK+8lA50xzUnuzoMLc/zDPZVbxiG2k36kd00JeB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmfQQYQny3VsF5x8mInW9+aQ4twT4b4wt45KLdTYMxg=;
 b=NuykkuPCe9oMQ7FpD41nTnov9motobM1Ck4rFCR82zmo09/IGrU8tD2JMG/76MlVkc3bAlqNv7i1Oxi0MLMC1UIgGpQdhzK0i0QlmGyz6mezaQI17bv6fAaXRYDEzLEby96eSkuMJrvdJjzkYbeWQLGUp437hLuL3LpartFB0x/eMRj34+xgxwaPQOUsRYGRF5A57EASTQknh7q3NNBWD/PucI99fL/vYpGiN9mCotdlO3IfJQ1JcuKcs7fNHppkXbd1Ti8gtxIZze2194FlBSW7unwv236WMs7IGZuqVYGXmWWdFU1mPiavYAJm1aGU9ZD5dJZqver7hnk0vay6aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmfQQYQny3VsF5x8mInW9+aQ4twT4b4wt45KLdTYMxg=;
 b=Bc9vzprf1xP3COuK2k4mtRHh8azZYZ0Ch2vc5m73ie5JY+0HHd6B+fAFQ8exsfjfCCbhl7YEuWr6fLSeGIrcyfy3er34PXpVH/xFNpdmd6QOjtsKDv81Xkz8V09bctZifqVyLA/L8OXqkuWoQJ5iQhsfc/bGgbimuGImYewElT2TCMU6KFXSDRKID3L7kQp1U+9HO1MYn9NncPj3Rb66exloIUiUJb2tphsx4xvJ8gOobtdeCl9xQLvB7dvD+V1UMxkzefhxnvxc7WUQMgj/tJTKfxgXTyybBixHWWNzumAYhNo9ibqUbPqhZ0aBFy62du35ySaleczkoZvXqMVDAQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com (2603:10a6:20b:42f::6)
 by GV1PR04MB10774.eurprd04.prod.outlook.com (2603:10a6:150:205::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:43:41 +0000
Received: from AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e]) by AS8PR04MB8868.eurprd04.prod.outlook.com
 ([fe80::b317:9c26:147f:c06e%5]) with mapi id 15.20.8880.030; Thu, 17 Jul 2025
 12:43:41 +0000
Date: Thu, 17 Jul 2025 15:43:38 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: MichaelWallemwalle@kernel.org
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: simple-mfd-i2c: add compatible strings for
 Layerscape QIXIS FPGA
Message-ID: <tkukh74qtng3qdweau2aznm6apcwadescelhtg4oyqrc6s6tio@bm67q7jgnkxz>
References: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153120.1371719-1-ioana.ciornei@nxp.com>
X-ClientProxiedBy: FR4P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::9) To AS8PR04MB8868.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8868:EE_|GV1PR04MB10774:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c9c175-cb6f-49a4-dffc-08ddc52f8f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|19092799006|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F4VboXBrNe3yVzkmWU91RxB5urH/ZUeiyPPlEWnzrloOX5GGhL+J6wxVNohy?=
 =?us-ascii?Q?jteEgJ2SEBY/nfcYNwDRdXea+7C5grNlY/Dk2p63aqcJDwKXXNQzeXbgUxEW?=
 =?us-ascii?Q?fSSMLQni9nvtPMkHYaX+NbQXpeypzFdYlHUC8RsqvlwUo/9a3z48d3H8RqCW?=
 =?us-ascii?Q?Pt0JCqjG45aicd33g2rZe79gUFHHl4qdIWHkkl6C4r8R7YbZ9yxPYF0f82jX?=
 =?us-ascii?Q?6cQCt6O4UYq4Q9Up68xQPTgkqHFvH/7IXxxQvy+3a8Y+u8OKJiXH/BjZHe5a?=
 =?us-ascii?Q?QNeY3GyGtnH1FZn22vhcYfZcn6JohjS5vmhfymICWgvhyhcOGOEL2XBX/imG?=
 =?us-ascii?Q?JaYs8/zoPvLY88mXFQugEDJbdxbKpXknvbOrZSsizctFrhvx62OaeR9wTDXu?=
 =?us-ascii?Q?vFUhchJvfzX/+s0XErU5+z8LwFELoKAU929rdXeXFgDAk1xZeYbMtnaW1n03?=
 =?us-ascii?Q?g3y17e3yxeNyHUgwcPbnXGswPXjZsg8dIWqCm6wJgLT+A4Q3VSqnBhLzyg/C?=
 =?us-ascii?Q?njdBWk0c0yNYeSyKwq2ODa/pXpU5H2dpMCCyIbs+QLOqfnQl6asXW2lR1rKk?=
 =?us-ascii?Q?3GFD+0AiK2ySt4ss91Ju2NSkvufXAgU/v/NSEsmVp8IWp1iskyVCIXEe/e+r?=
 =?us-ascii?Q?Dh9AducS0SCfxPc5VdvJ6rogMYg+XrnjyAM79bUm9BmeyxydBm6kgX3rAO/d?=
 =?us-ascii?Q?P1jyrB0JcBEUtjsbCcWUngy0PBUOBy8HLXvefRLNIbd6PpRnurXBq94UdWeJ?=
 =?us-ascii?Q?jXxwUSrxePl8DhjCADGbEVG5+k5jdNjvcd8FN2EtKG3ocbfRePlEKrMfWvzn?=
 =?us-ascii?Q?j6hYcUzyz5tTxCeq8Va1I83YJHHQGJrPAiRFYQ37YMcb3ETiDT8bqadwcPIP?=
 =?us-ascii?Q?ZOv8MoGN7LuiCXj0l0OX3ck7s3kUrBAzKpueOG5ABhFtgFc+tok7NBebosDU?=
 =?us-ascii?Q?m2AiW+FqDyNL0ip3v+UXm4R3aAD5b8NwmwA/B94traeSRETKMguGD03ki0JG?=
 =?us-ascii?Q?qcUD8o9yBxDZXIOTVaOvxBpLH7j+o+Roe4NH2ZB1KqltGbbwBkDxaxQvEIyk?=
 =?us-ascii?Q?xv6x/YUozN2Dn6B5SIBqtoa/M0UC3JohA42gF2g3dZ0tY+nhMaQMKXL3NPxh?=
 =?us-ascii?Q?36+0heWCuzR3zEQCMgwNRQJ0KFSFYA8vlRMNnJgb+p6px6CY3tr138xAX2OO?=
 =?us-ascii?Q?qdUxDu5aai0SApV2mLK4pPa4SHWp+qtV8bmS0qkQ8tarWOzE9t9v2RZmzVHg?=
 =?us-ascii?Q?RGxFQisblSKSZv+SOR67UMqE7wd+oHVr4gvdcJ7I3hxSgdZlVbrGr0Jp41uM?=
 =?us-ascii?Q?M1RZe9wn7dsEJZLycH8rcPWQIW3vIGmobKqUW9iJfZHMfKKUIl0C8+wYBngD?=
 =?us-ascii?Q?2m9um415haQYDSGJjCMc1SOkhunUDgpx2jN27YNzujAtC3E8Lw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8868.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j1W1N+qWzOSnJwE6Xi4WSa5RuAHxuBE/LPKwPv2m1PUvSF9kdrVl+amR7zFC?=
 =?us-ascii?Q?XQltnxzpVSizUWk0W4VYtGK3lUF0Y/Wg0cdJpuj23V/DBBJpNpRynaZan7zX?=
 =?us-ascii?Q?kVRwoQ0b+Blje7gNZGSFW+N5rxa/y0oSUmVOoza5o7gcpADkH3ENxCYKrERs?=
 =?us-ascii?Q?eQt4sPWh1Dyj5cDRY4JDwKXFhKcZWwVg68lifACMAHlB/V+BL2G2CrZeaArH?=
 =?us-ascii?Q?kD0tlxK9uzqmeMEIHjM1rnjTY+0R41X0qMdbpSk4HfUGIUeR/mGXllFKU2ui?=
 =?us-ascii?Q?nTUHH6oHuZ5AUkJ6IV5/HXIfCnhgJHbIccRPLKIjNIGPWP3MFyoQZUjZ8kse?=
 =?us-ascii?Q?AnE39HnGq5yNtsVSlhYY2OuOvEr6Msb+40Wn6UeVm6TMwsWAPX2S2YCvIR9M?=
 =?us-ascii?Q?w0zwjw5pD71Q0MTs9tbURjw5ykeK8yxElren9D5vGbJ5dIgcRB4cj82sijav?=
 =?us-ascii?Q?8/6BMpOsdKDjjWvVlX/c/jfnxUWX0nOykXWRnIZpMtgPH625juow3CIL0WJN?=
 =?us-ascii?Q?uBBgq2wzGXy19/K9Tm1cxJkJhTqaNkHY4ujrw97E+FnD8Xr1daUyArJ682Gv?=
 =?us-ascii?Q?NVJ+opkMfaJAWYLmvHeJe2yQYrvf1mOh5xOVCyyblbqbYw1yJFjNuk6W+gqf?=
 =?us-ascii?Q?Ttzoc/vXdnCI7UhiQaDdD8W9xlefF7z2LpyZ2/Z57stdOdpzEBTym6H+U+t+?=
 =?us-ascii?Q?8fjuhmhaG102PueDKLeJT8eV0tdCFdXyNIAU50vDhkiRqALcBmKimB5+i8ZB?=
 =?us-ascii?Q?x+Vmpve6KpMCweD7HEv+xBpkIOIhLQtkNw2XCOaRxECPJfk67byP6Ln2kuk2?=
 =?us-ascii?Q?iHepto0hd5kWq6pfr79miO0d/FVRn6JxRfzqMw+wejiAhexxpsDyrNhvvcXT?=
 =?us-ascii?Q?8z7bOb5SnZgJIC5so+BbLORbZKAtN4ildikAVQdN+devJDM/8sWjCs7ZTlfN?=
 =?us-ascii?Q?ER2hThZGZJADUBSu1xn1Gtks+GW29Lu2Hg8mhkjQGMu5cZLKl6aNPpcddTsc?=
 =?us-ascii?Q?oCCG5m700quyYNUYafLCII7GakgfVAKiraUyBtbm/MhWa+nVhjB5Lb5n0lzQ?=
 =?us-ascii?Q?+pT/7FJlT6hwKssl+qZ8W0XjCqCKKU2y7SkWnnugX4DKld1E2W63zrZhE/rS?=
 =?us-ascii?Q?zWCdy5BZVu85prjhyIfTT1yCQ2G1OIE87goSGpWxJvSpcEHODNT8T7nyxPrx?=
 =?us-ascii?Q?c+h6DbHdQhfJx4yL2+7sZC+BNVxmWpMkcQebYP1eSFn7VR7gkW6x7bocvcwE?=
 =?us-ascii?Q?+V5v2yXeQ3yV9yh0shi3RYlsnhJKh8LAlu3zLTYE8g6pnpg7OOA8/6YONwiK?=
 =?us-ascii?Q?aW+/gTfvCpyiWRBT3GONA1mniti14oGW1MRw0dxbLd2LI1+JQCk9hMEaRt6f?=
 =?us-ascii?Q?zBnu6gnbRcLe6GJrnQI3ZEK1/8as0bIAIwiJoRfsYth3DCMs8K95nXUJk0nH?=
 =?us-ascii?Q?J21KyOVliV5H8qMRiyTr4+lQSX2vyWUs5CJazIwUaY/Lpod7GKPf3+P1M4u7?=
 =?us-ascii?Q?8YIrxGiuxeJW2wEiqret8jH7EsSHRBp8GVXgLGYnwiT4hVssPrYUp3kD2/bW?=
 =?us-ascii?Q?MH5EZE9B9OnBPEEMuNK80zB6Fqd8MVIIRMlQw696?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c9c175-cb6f-49a4-dffc-08ddc52f8f26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8868.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:43:41.6803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t23ElO/h03O77CTKNSdNTFmkPVJNWUSRfiaqK0quq8nLNJoHmXWCNFWPIyp2fClJWgFBK2umbIAXDQqOx5sa/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10774

On Mon, Jul 07, 2025 at 06:31:20PM +0300, Ioana Ciornei wrote:
> The QIXIS FPGA found on Layerscape boards such as LX2160AQDS, LS1028AQDS
> etc deals with power-on-reset timing, muxing etc. Use the simple-mfd-i2c
> as its core driver by adding its compatible string (already found in
> some dt files). By using the simple-mfd-i2c driver, any child device
> will have access to the i2c regmap created by it.
> 
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---
>  drivers/mfd/simple-mfd-i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
> index 22159913bea0..f7798bd92222 100644
> --- a/drivers/mfd/simple-mfd-i2c.c
> +++ b/drivers/mfd/simple-mfd-i2c.c
> @@ -99,6 +99,8 @@ static const struct of_device_id simple_mfd_i2c_of_match[] = {
>  	{ .compatible = "maxim,max5970", .data = &maxim_max5970},
>  	{ .compatible = "maxim,max5978", .data = &maxim_max5970},
>  	{ .compatible = "maxim,max77705-battery", .data = &maxim_mon_max77705},
> +	{ .compatible = "fsl,lx2160aqds-fpga" },
> +	{ .compatible = "fsl,ls1028aqds-fpga" },
>  	{}
>  };

Hi Michael,

I somehow missed to cc you on this. Are you ok with this patch?

Ioana



