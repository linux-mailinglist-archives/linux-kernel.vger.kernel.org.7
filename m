Return-Path: <linux-kernel+bounces-847164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776AFBCA255
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0369188D404
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C0042065;
	Thu,  9 Oct 2025 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EAFdzDQs"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012034.outbound.protection.outlook.com [52.101.66.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413761E520A
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760026646; cv=fail; b=kk/86g2C64eT4bsG+32oXAQ6e9Mlaq3veq12ie7tErRL6NVp6JhO2E1BdSwKmhkFpqQuSp25iM9rCE79PUC1MaG/PNqkMxkeLanNtr0iKvEm2cM9rYXA2zzkhuAkWu1e6AMpMH4vbfcO10kqMFTYvbq3Qkv3IaHYF1M5xb3BqE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760026646; c=relaxed/simple;
	bh=XPXHWPCzLKIH6jFE3iWGt4+kPDbD83Gf+YxSvRshBAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UClyeD5JgChcKc8/4jScw5+5E4ffCw44w7q1MLksozmKEx7/hjaLo2tT/+22RfgbPqT/XSRDvLlkhYmZAkl7pqG/YGh0oC53sg2r0d+5GdopkFVlL8VO1tgQ++miyhFjKATJ8gTKfSXYiQMlKp/0ZAxA69USNq7p/NB5f9UW7pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EAFdzDQs; arc=fail smtp.client-ip=52.101.66.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x4QBuz5Z6/7LiLp6aKhw29HOixSZIB6KarIuhp/AF1P9n/XBXmBKGwcgmHHUWJ+ePt2B57h07+GGffB50fvF9dNVEYSomhWHf1C3eDJFo7RDxschr8gYA6bezD8fSCNtnwBEs4h7Xwsk1PyFAxa6VnssAfxG3zjbkxaLXvNFOfSsUQnTXlwtZuhAcMP2ZaC3s813uejYOakSID/U2qQZcU4Wb9VXKuMJ/crLPCHjkncYGEm8/NfZWU4En32tQdp6T6P4he5EQJIcsPVExkWtdaZvuu7lFfuiLcbOTVlYwyVPsfWdU2zl8yxZzmJHfszv4lunitqZFjH/ufk2OlJPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSmCeFrWfuC/eBvhD0k6RV5j1aV/Nv1x3kSfeBTUtC8=;
 b=OxPCb+JW4gbI20wCbwyv6f+HqSQ42neG/2BbyVEpZMkykxG7QpH2nrzWFdbBVzF0kH4Tk6DVfzkmXbjs8sgN6pOv8dVbl7nK0v72qV0+xR7EZ+MDNkNoiPwen3RBTNLCnnDZYgv1lB1hVcbYpByssai4a3rdHtpsetp11LXjR+mCcrMDu6F22pUlBnqJ1XdaPxqD824L8RIxBqaWkmW1z7q8MZ+wJqRwTN/rhlGrJiHhlTQGSl5wOHquhTKfNqT4csRipNs7W3bE4FyJHRUM+TcufbJT16OPRrHxxE37FcfwBWgewTwP0aZ9afD5dsGxUhZ1h0+mrdp579SUMLPDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSmCeFrWfuC/eBvhD0k6RV5j1aV/Nv1x3kSfeBTUtC8=;
 b=EAFdzDQsMeYTmHvmweyhUq867L2hP7mk2OpHEX2ono9avJjwH6AhJVjqOkPux5FBJhWvMSgPbCKIy0nPuyucD5lf+uVohHnCYPFn/HHTgZFnrU6nLKJVCZaft01PMSMka/VGOSABlTth7BNnd8XP+qbCaZyAZ2zijiGzF0YmDvkBb+GseCKj0UBSkhdR2sKXMf4XoVSu0TEulUKqAwd66Idi3eznT+UvgphuBSb/QohHIMY6tID7toBAZXy83iOifVoCBO6nlKzTX1yQGoAbL5M7l0dQ23YgYkmGTSieA6MTssGbEfdLTqVJYL68ylLpuV4hX3U4h96FDuNYZcz3EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 16:17:18 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9203.007; Thu, 9 Oct 2025
 16:17:18 +0000
Date: Thu, 9 Oct 2025 12:17:11 -0400
From: Frank Li <Frank.li@nxp.com>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: fix refcount inconsistency in i3c_master_register
Message-ID: <aOfgB6UpBha+pvqa@lizhi-Precision-Tower-5810>
References: <aOYSTX5EA_nRoIY_@osx.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOYSTX5EA_nRoIY_@osx.local>
X-ClientProxiedBy: BY5PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::31) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: 6775bc4c-8c79-4e3f-14ad-08de074f5191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ir69dRy7mraSrucsSKGJrpybNjbDtWhjArx9Neze8D/2oQEE4LxArWLeE2nx?=
 =?us-ascii?Q?5DAM0nTRgFIXI0UICXtPPt3RMATu8WBI4QpZ7LnwnOCYyuqsh/f8KlL1+hzh?=
 =?us-ascii?Q?GzRDIuKL8iqLdDxkusxIvyd6API5RJkrWZCR18CJNU/WG+d0znGrVAhlJwjd?=
 =?us-ascii?Q?icqdjf94uSK8LFC2mUvB259Z/ptPezRq2dygKBXQJdMKCJbce6vx4wD/mQQ5?=
 =?us-ascii?Q?cLmE5umtXPsNHdYcK5/NGdjVDN72/sR/hjG3QmTUKLJQbfmzJ0fctl7Ruf3t?=
 =?us-ascii?Q?lkt7WSWmiJ/wZ32oy21cNHp1bRHORrferLtO78NVXMoFqKtI6z5BBcaF0Ivj?=
 =?us-ascii?Q?N9/U2EfDlUga4aMFE8vA9EhNMFQ/Skf9VEuFmcqBseJQ93I0lQuf/Fngf3I2?=
 =?us-ascii?Q?HMSdx6TEDEMySlKFWhihi9A6lRly4Tb3bmBmmxDNkTvAhhBX40eAzDo/333b?=
 =?us-ascii?Q?keep7XHKlrFninI4yDvZSgWFXYsrt11jwGd0PcUuZhLWuYM2Jvjh4xq91ZnG?=
 =?us-ascii?Q?LZGBnSqnQAbPaTQGlnv01DpglR2sQOJviCGEoIqq+FTd57wT3RH7k58FTU2k?=
 =?us-ascii?Q?CMV2pFUWlv/iDDjuHVhaxg8XvzBSct2ArhKubtnUhbsSBhSLQyjIRc6t3ZsA?=
 =?us-ascii?Q?Se4fjpHUNqPkFV9q9SqBJJ888bf3+k+lTNVHV8nDNeMFUj1CAz5MCBoU95HN?=
 =?us-ascii?Q?2+5OQ5L3yOtR2G7MiUstmmjZn5RCPG6T85E0Mgek0RVjAJK6Ga6EoCFZbSIY?=
 =?us-ascii?Q?gdwTxVvxRDcpfzaQrAzzarXuLEc8iThRqO90dbX6zTiR+Qq8/kpUOvRxmI2/?=
 =?us-ascii?Q?pPKL7LBSQ8MW4qtVCmOBjB91yukN2xRQNdu3lBPcP7KD0IUUcnE1yG04zF1E?=
 =?us-ascii?Q?AqCZyHOHTFdutp1UlZBUZWBmb6/NNAcoJm1XYa5kLlx+r3Zjqiw++r5k0wzC?=
 =?us-ascii?Q?yt2LtyWfH2fc1xCCnzQ/PsiOHYw5/6mTCy1Ez32oNwxeT9FCNytjcH+p0S8q?=
 =?us-ascii?Q?N2lCbrH+qaMwZNkhSQoUuSDEQjPhUee9RNgPJ6hae6v8G25Y1FKaGBtds8em?=
 =?us-ascii?Q?h7hn45xQJNyHJQkKJonMAv++qxzXkumN/hRCOZQAiK2iaMEIKq4D7V5qg9gn?=
 =?us-ascii?Q?z3fEcovBRDCx2LGJlFF325R62cJi+N6mU+M+vbDLgxFGQYp9sqF5X5mJldLj?=
 =?us-ascii?Q?gXRCeA8f5ZOFaK1AUYQT2H8eFBXvDO/XLVkkLguvaoGR3vVRR9biozEK2TnG?=
 =?us-ascii?Q?Gnqama2/MYpQifeQogmqNB1jftQbOaN+j2fBk3ptcR7lVy5WSujjnhoZnOcn?=
 =?us-ascii?Q?QLOo+qKEv8QVUfYok0sGF/zBFCbRQggM+kvbrz88/LLM+Kux2SBlNCkyUI/A?=
 =?us-ascii?Q?fQumLY1yLjqVVvTd5IWrxnzxBaUBNiuJK910hGjyeY+zjOfOnR9tSCSxMVr6?=
 =?us-ascii?Q?Jbrdhk+Rwwd9LiLy1Gin0ZrxhWzrWeFn5l2CHg81xyjzoSTci0tWVRcQUYZb?=
 =?us-ascii?Q?uMKF0dIGTSL85HlRrWZQ9L4t70xFk/3hkIo4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?92RmGPs54Vea/cAmFm0GxkPbq36zs6sAvyTUfplGNPP7quYek6c8gNbzkP5Y?=
 =?us-ascii?Q?Y0T4jUznKy6/UeEU4YwOZd0kCKNXWT5i5xOrtjog64pojZkDMjuARX5b8L90?=
 =?us-ascii?Q?CqL2RDOAWrbZO5/xkWOOEikEKyyfI4ptHzCry0ehIvRP1koX1QN8GT27Rr18?=
 =?us-ascii?Q?3jJsWZyvwx4T95vIRkPPBFhMfkS8jGGn0MvVg/zDwDQ+uUWov45p2oP931bR?=
 =?us-ascii?Q?TlX4XMXJAhjVBFdxCPGUw0wezlWuMZ2KfnnXwYDjZcmPCq4Y/JtT8vOWDHO1?=
 =?us-ascii?Q?SBbal0pYtFRGy0FMWEHdCF3bkkEf92ya//7tXrI0tJRHJs5vY810ESvZxjoS?=
 =?us-ascii?Q?Gmf92EGlICFSVOm0vUSzscCokqnnITJLe9AZaUfNcNEv+P2+NBOGwLYXOBMy?=
 =?us-ascii?Q?ISUFFcPIkZRx7NEXB/e+8LcU30RHjE5F53Jx13kbuz8D+UhTFScAlx911ZNn?=
 =?us-ascii?Q?/5N7vxCTXoyOw8rk9zksu1K9YZGtRc47vkM8abzTLbLK+OIqP1ZvxVJd33n/?=
 =?us-ascii?Q?lWon0s7hV6b+08VYBMfjoINqaoKvtNlO6WCN3gv2umonWwXgBoi2h48djLyM?=
 =?us-ascii?Q?CLiAkCcqKVZxdoClkPXcQdEEr7d2FwB4q2d0SOxqR0DNw6gnsDbOFIdyf+uX?=
 =?us-ascii?Q?s3l62UyAWZ4yu2WfCK+2sHLY0F2QPYDGUuUsfYl11iUMqHNhhFoOC4szSBBa?=
 =?us-ascii?Q?uoVM7dON5iA2ayUsuPgFihDLxvymd6nUXd48G96/c4ZBsFGeDQqhvb7fwMJg?=
 =?us-ascii?Q?pqWswtnQ63LC7fWEss4JS9W3M79XGVNdW6iXf1uM7JbZ4INNerPtEIL53vvh?=
 =?us-ascii?Q?9ILR+EcNHTqpEmQyaYFGRrcWzs8/99RlmFLWu99BCdyHeNhAu+MfVwpeiKPt?=
 =?us-ascii?Q?nPXaCxGX1GFjT/2p2/83pPeKbEEgBdeT9/kMfpqE1Kqdiyf9zkDQQC17Mg0P?=
 =?us-ascii?Q?QCyRp8rn6lXRTpGfMEa8P4UTIu6nZpOEL0j6fbPsHfvx/aRqYuOWZQtZ4gd/?=
 =?us-ascii?Q?pjfi46PXNMuZorS4xP5xYgUHOVvzJl51nvVHh9GgdA5P4yHZ4MTyzf42pDPZ?=
 =?us-ascii?Q?ljhka9bYJLb3P02Eys1WqEVzVACxG1Gt24kevlz3FoU0TqViDQzSgyjBOUux?=
 =?us-ascii?Q?I3a0CgZqJFT7CjvP1x/SrWfyZGc/Zt7shhZY2Ti+cpaNVo+lil0650RGx2yI?=
 =?us-ascii?Q?x+syyI2uHh/o/++faCPrFFINsVWvipK0lpyr01pcMLbWD5Zn7o8ENn4pdpTE?=
 =?us-ascii?Q?XamfDoYSl0wcq7B2cDKzzy31g5TGNihoun9RLAc6gmBAyL2D9VNnT5b4dAHB?=
 =?us-ascii?Q?dsrwuiKRmdbhfU31wvGgLUFPHIZ77+56FMBWmY4yZ5KztaUvkL54c3Nt9sQ1?=
 =?us-ascii?Q?t5tvAVGF1iQQ8lwrkSmLmGcvd6GODCtqdbDURz+RgNh3Fav2Gnd2lFvZWYbY?=
 =?us-ascii?Q?3YEiDb9bN2xFugwXGjX9uGM2k55u3oyUSnftA8siUzviq90Pxk2rJRN/fIBz?=
 =?us-ascii?Q?Q3qfszU2nxML0OIVakg6+bRys6/U3L63YbZIf2WVgnwRCzp4fSnFmt4shrS5?=
 =?us-ascii?Q?pWdq4DkKJH3LBEk5oIld415L4FHmkxFxjhtJD1Tx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6775bc4c-8c79-4e3f-14ad-08de074f5191
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 16:17:18.7423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/midGnK74zpSK3YhxU90pKZVxYhOjbhCngg2HdJlIas5iFMully7Q73jmmFD0wM2qmVm25M5yKnmf/wbQhOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

On Wed, Oct 08, 2025 at 03:27:09PM +0800, Shuhao Fu wrote:
> In `i3c_master_register`, a possible refcount inconsistency has been
> identified, causing possible resource leak.
>
> Function `of_node_get` increases the refcount of `parent->of_node`. If
> function `i3c_bus_init` fails, the function returns immediately without
> a corresponding decrease, resulting in an inconsistent refcounter.
>
> In this patch, an extra goto label is added to ensure the balance of
> refcount when `i3c_bus_init` fails.
>
> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  drivers/i3c/master.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index d946db75d..9f4fe98d2 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2885,7 +2885,7 @@ int i3c_master_register(struct i3c_master_controller *master,
>
>  	ret = i3c_bus_init(i3cbus, master->dev.of_node);
>  	if (ret)
> -		return ret;
> +		goto err_put_of_node;

I think it'd better to set release function for master dev to release
of_node because of_node_put() also missed at i3c_master_unregister()

you can refer drivers/base/platform.c

Frank

>
>  	device_initialize(&master->dev);
>  	dev_set_name(&master->dev, "i3c-%d", i3cbus->id);
> @@ -2973,6 +2973,9 @@ int i3c_master_register(struct i3c_master_controller *master,
>  err_put_dev:
>  	put_device(&master->dev);
>
> +err_put_of_node:
> +	of_node_put(master->dev.of_node);
> +
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(i3c_master_register);
> --
> 2.39.5 (Apple Git-154)
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

