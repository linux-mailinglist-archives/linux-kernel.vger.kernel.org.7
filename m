Return-Path: <linux-kernel+bounces-856482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E32CBE445F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 17:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 91B8C543B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61DF34AAE4;
	Thu, 16 Oct 2025 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WwIJ2ljt"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013025.outbound.protection.outlook.com [40.107.159.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658001607AC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628815; cv=fail; b=k9kis2yHJKnx2kjTJ23eL5Aup5xI4raHa+QEUVvOPfjOzGPWG+te8FDReSwizlZ7c/tnNSRRWXtE7hpwK5p69CW59drUjGL3dAjLGyx3zt+QWnwceFchGEQduxJBM9sgSZkCFBY1QeJ349rXgR/IXW7gdd9sBdasqZ66Hrzw90g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628815; c=relaxed/simple;
	bh=feRXWWFfg5kfYFuDoUReScHQGcKGXfW1O49cVIFwOIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AvWMaW2OKbCJNmld27GgozMCqu3Ey/iba5zKzZVQimVNu5il9M8Ba64v6uXTwWyiSEurU/5Q5BgKUbXwgtW8j8VvbY/tyDcRThrVHfdYTJ0le6646YvmEX8/sMdkJ1tLSyX1WHAsWjRTTLrVi/J/4SM34MrhaW1JGjGi9ks9dBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WwIJ2ljt; arc=fail smtp.client-ip=40.107.159.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEVQwS7SC9emmqCmKYfjPhoji51OPZaMTl4DwnS7WB6WhJ4l8HwiUYkjuxCF8wvirWbpbDI98aEz01H0cEmH98zScmAqzMKJLPoZVPD6g2TnlZlRTNyKfqOaRuG8NZrNzFsBsqishwW5oRexjSM4il/8qlbigE4HGSfAuQ592aWoGOmKrDKnLWfllCZp040t2q+p81u+7Q3sANzO7QcrXRKmt6lq5tpqheAox1Mni9w8Ve5TDGN8uFtDbEOcl80dlQn7pnn+Spg1+KHXESH4NXPhoZwAVna9CzMT9gs60AthbA3kCfbnHjQSIxOkq3tBju8t9S1ftc6tcdmaksejmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1YFYy8JD/t2oAw3Dwx1OS9Y6vUmwaavgAh0imPbWx8=;
 b=DsgPE/wwYgqn/HdjwpgbjBgRIB7XxUF41LFcr10JwHak4Ir3LzaVG4KTj+zNmIGhHYuMLq5bYjRQNYIwaPlcQD5EI3ctAb0gXTwByXGbMz+XeB8YEQOKwMfCVXnHDX+iGyxpCCV2lL0HnWrkTFNAHpzUVarXez8DeIu1RUpArtoFCNDfSw99dIjfOi9ns/qdLPWIPqRE+BT3/XNRK0C36N2DbiuQhOQAThA1GFfDzwHiF6N5vBsCICSgusWjBUw/n0/Sh4ctWIzxMVwNA4aswXWQJQ/E9c97nb2ytuoquFSbUzPmtDLj58HYB2yCdUsO1KDFoTRgKuwiUYkHXwvfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1YFYy8JD/t2oAw3Dwx1OS9Y6vUmwaavgAh0imPbWx8=;
 b=WwIJ2ljt5YvZc9Pvr10x85aFXBXrYVs0sNgVskP0uQOuzl1/Ce4TlKob4nJRUFXwas4ySCQxbgL3J0kipszhsjdYubsIIgaujAY9jfIl5VRTP/PNCfAkq231Jjuh+gT9V0p/VKQd8LlmAh/9ZUx6asQ2rK5x1XvFhD77SkRIN+nbIKe+fcxn1OrtxzRG17/lZtC7cSawUK7/to6dnmNuoe35wtOfnYP6tA0/xoGvlhLIV22yQiAesrz4v6oeP2lo/XID1CND4NDKDdmYWvenF8eIl3vHuD1wf4IQz4eoSM1iveA6BgwpppUQ5+TEXkQL6mlEMMijXfTvnJFbn2XX3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by VI1PR04MB6878.eurprd04.prod.outlook.com (2603:10a6:803:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Thu, 16 Oct
 2025 15:33:28 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 15:33:27 +0000
Date: Thu, 16 Oct 2025 11:33:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Dong Aisheng <aisheng.dong@nxp.com>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] firmware: imx: scu-irq: Free mailbox client on
 failure
Message-ID: <aPEQQMudFKS2gpwl@lizhi-Precision-Tower-5810>
References: <20251014-imx-firmware-v1-0-ba00220613ca@nxp.com>
 <20251014-imx-firmware-v1-2-ba00220613ca@nxp.com>
 <aO5yPLL9HKdM6yuB@lizhi-Precision-Tower-5810>
 <20251015135503.GA31091@nxa18884-linux.ap.freescale.net>
 <aO+wg4I1IFxQQ7rf@lizhi-Precision-Tower-5810>
 <20251016021459.GA3592@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016021459.GA3592@nxa18884-linux.ap.freescale.net>
X-ClientProxiedBy: SJ0P220CA0027.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::18) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|VI1PR04MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: a595a686-49a3-404e-10d4-08de0cc95a59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MkYL78gzY8BcuIMohrEQtiG08/dJ8gf3c9feMCMKP5bmzWsOd37L/rxctddG?=
 =?us-ascii?Q?+N3v/TYCrIcAsJonDb5oF22B7rLDAFTgmLf4OKcSYsyIPCDpqOCC+pTkg8J1?=
 =?us-ascii?Q?bmI4AJ5beNaYStw0FScNqKNDk0L8iJ9i5VV5EYZk8RePXoCmzmWLrHvP98hY?=
 =?us-ascii?Q?8IvJdlldJ5SCBJwB2zfSFyqFbVwj+ezSIM4TaI6vMu3v/MAAhUNcSoJKVk+R?=
 =?us-ascii?Q?FC26aOZpFVQ7y+cQWsLlw+QV07ZNOLasp2Yc/fi13zbnqIwIBBMXeRtE7673?=
 =?us-ascii?Q?Bm8Nc5Ix3X/mowWC+RNJV8AsX3ecwzQ3Xp0FAGrb1bkdNz1tYEHoczJch+1v?=
 =?us-ascii?Q?f+FNVVYc2UCC0RMG0h73PijYrOMLuIOP1AE21znsjvkpn8xRwC8j8ocq67D1?=
 =?us-ascii?Q?zrUQr+WDGdyOhH9T1lsMdknRmrGUS7KFMnTibG8DTz5JlXJUtjhVBbcWzvgr?=
 =?us-ascii?Q?yHYR6uxSZrnwMDAhvBJDngnDUHGQTVE1T/t1cMYxb6dLxjI4WbkX1rXiXJjR?=
 =?us-ascii?Q?dVTl6wLG2msqERipt/msZ9fsKhZTf4F4wcaEW7KQ4y08CLKv+PmsQOPClmQU?=
 =?us-ascii?Q?iloSXWD6wGz0VmADFbJGBgCPrUnwJXeIZbHYI+ty1zjTkXuIqnHyhhrHWFVq?=
 =?us-ascii?Q?h6FXqo91aXisBlXhlFEsKGQxK+mfGddY3fSCB82H3t/GJX5jWzcI9RiqQGeE?=
 =?us-ascii?Q?XqYfwrQinoUMM9DIsaBxRSD2ZDz2UE0KuhbWNYebi0La+jBim8Of8z7eEHoh?=
 =?us-ascii?Q?sQo6ijyfRNPxFHRDOWkFVaf33ZW8UrscmcPlaeljVzheC8R0zYj6W33C50ds?=
 =?us-ascii?Q?1wLGNnVmjFNDXkBFnUpVowKyflVn9ZQn8R/J84r9HyWUHPucrOqoWQ/88TJW?=
 =?us-ascii?Q?gi25lwRCSMkcjWkNSZ1zej3iHEi+1zsRLqJ/qNzA/0xsYBF758rt2//c8F9A?=
 =?us-ascii?Q?O1rP/P8/wjUVcThCZTMlQsZAZCnqMT4ARvD2bXFH7AJFJs7DQZV5E2kosMIv?=
 =?us-ascii?Q?k2vunYHikUCAAoY1L3TW3/Lv0zKdYDlvYJkg5R7VpRX2ZZm15g56duz9zBYM?=
 =?us-ascii?Q?caUJJVHf68f5GYJfnLnkjT83jk7Id3VjAImWZTT5x1BGsGVER664qeO9hMhL?=
 =?us-ascii?Q?bUErm5sC2F9ugmj6I0Ms2wmHYQx3s5tej+YNtRjBrXBXwk5RuWRB96RxpTiq?=
 =?us-ascii?Q?+m74mQOhK9ZsDz/x4kDSAX+RLlEBtFUIivRv7csC7s76cgb9td5kMRbssCxC?=
 =?us-ascii?Q?KE2wR8inbcPausw0ZTnF3b/ptUqiU/Spgx2ounV0+076tTBVmbD7gqqiXIlY?=
 =?us-ascii?Q?A+aB1QT6FBxgruSBBTSNXOKs9EoYPt4KJFzY2wzalJZa4c3N3DfQIuRoKiI/?=
 =?us-ascii?Q?v2pLON9VutXLeoLnkezXiUbySHfDe1jKb9LAfUS77sveYm1aViXILXJUP7rt?=
 =?us-ascii?Q?S1wxvGLff1ahXAQVNwXGdIE/yZmtqi5OvYIlkDNZVkxLvwNCVT1UD8l0VQFz?=
 =?us-ascii?Q?7MduqEFeKzCMF29hsWHdyvGb7uUTwggPZO6B?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1QVP9p/Gp8vR9DaTUjRb4V1ojSaxJNwHwNgUILOe1dX+JTWgmi34tkypx2fU?=
 =?us-ascii?Q?6aL/f+0XCi0HIxAX6n6fjNxdfetxP4785ddrRDtcC5a+Ub0Kxnj0fwwlLSTJ?=
 =?us-ascii?Q?DF+yI4IxrGnBBP7DqOVu4QekilMuL3jez3r4ck5xMk2PH8wa6GFGwmyXEbwV?=
 =?us-ascii?Q?4zDt/qAGgTfP70svzuI8kFT8MR5p0zBDj+1jT4+H4ZLJX+R6HMbIhVK+Rdc1?=
 =?us-ascii?Q?c6D3UC6eDCRkJaF5lPb3E14gc5UaFViOnqluUL/PFT8Poc7VftHi6RSyk4YQ?=
 =?us-ascii?Q?u0vZ0bvNnjdVRvWr0cfgEnphr7AiEW7RIndNp9kUg9LTAPm0bcGVD+h5MIc4?=
 =?us-ascii?Q?QxL/mjTtlV4S+OpDOvYIfXZiU+vANm0Vm0hsyYRTgZ45SyY80gEZyKvLDSer?=
 =?us-ascii?Q?wXS8UqExkqWxmK3gQFGUVlkBMA/XCsPtS5LeVfcR1rWamUBV82vqHd2UWsf2?=
 =?us-ascii?Q?DcMdyVqVBFaqeyHS2rkyaAIz2EddR1ub9ymTioo6IViEpl32hRb3wbCAC+Y/?=
 =?us-ascii?Q?XJQ7V6e7EWMT3ZRAZvn1NhM1OLTQORZ2L6W6XSKZkT7EQkF365JxXiK44r16?=
 =?us-ascii?Q?wW6XomWe3y3rZK/EptFeD0H7VXAoWIgsGrQzKF6FZwnnXbyMpXJ+W+ZvYOjl?=
 =?us-ascii?Q?O8bvEsfhMkBMJIEmoEih49A0xKW5FZfnque383JZyU++dot79hp6/fLqfIse?=
 =?us-ascii?Q?ZzX/plTJ1U0tmFkX87JS+NNcsFktY31uOJYIFLBb3OrwEtnApplPB4XxslBs?=
 =?us-ascii?Q?4bshpZK2ZL8TEbmP2o3/QWu9PAC4FQ3qcIGBpE5bnIRukxTvpXP8y2Dwd1i5?=
 =?us-ascii?Q?WW1jARWNlTOcwnZ8i/hn895iYX963vZrL5Xds755SGNxrWaz6jJ0dNhvjqOP?=
 =?us-ascii?Q?rra751GgqUD6Wn7P7jkhtEKcDJ9ia1UUrNhb2V+WH1uaibAxNHNXPiMV2JBx?=
 =?us-ascii?Q?cnuNugyHwAPshYkMc0j+vXHrpbFdE72+Zoipog9z53c8P1MxfSGUF34R7nuR?=
 =?us-ascii?Q?gtos+jDUmRH4CBsIyZq8zgL6CzMT5lFDBZF5cFaUO44vjz7urnLeMIpnBRcJ?=
 =?us-ascii?Q?5hHw3MsoycjolP5ZEFjtQQ9AOaJK2nCPBmfdibvlHqGVj8433VhDqK80MHL1?=
 =?us-ascii?Q?vH8YjgvJA3eu8k1/Jl/QYmnfhzDVjcppfrUoScKYmmzprMq4VmDOa/z1T54u?=
 =?us-ascii?Q?5R6BD2MKItMSXGTxm1sm6b2W9G7jb49dBDw3daLMpu3vg95qP5XrvANVsuLx?=
 =?us-ascii?Q?t3NTlnOZ9QcYBeEb82pjEeBJB1Zs7qiie0WiOU7EIIPf1wMlQzZ5MQ+WSIrz?=
 =?us-ascii?Q?gA0NjPreWxBi5bl8gDqu4zvmjLbNBaliK8uzaW8YOtT1n8jMo7jXvCP2lmax?=
 =?us-ascii?Q?S8r/bCsZtFVh5y2AAy5sjoRDD8fe1TerO8U1S5UdXakkSi0CHbI0OonC/hbD?=
 =?us-ascii?Q?ZdaZIKiFaxGGkEBFZrDAkjLyKIC3piTBPKAg/im4/BEi4ohs3ysiLyp7S2WV?=
 =?us-ascii?Q?kyUyNmFtr00liMC2d2IMSML5YRPPlfJtuFq37uWq8iEYAmfZiWRN9xD0Gled?=
 =?us-ascii?Q?S197lkd1ucLXTex0kns=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a595a686-49a3-404e-10d4-08de0cc95a59
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 15:33:27.8348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p/W9A4GXIWTSUPrTyMlDBq8PfST4OCME1WTmDBAdXjQOcDZ8GCqIEQPIjAaBwC/L7WscMhwTH27YzXQaM1Z39w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6878

On Thu, Oct 16, 2025 at 10:14:59AM +0800, Peng Fan wrote:
> On Wed, Oct 15, 2025 at 10:32:35AM -0400, Frank Li wrote:
> >On Wed, Oct 15, 2025 at 09:55:03PM +0800, Peng Fan wrote:
> >> On Tue, Oct 14, 2025 at 11:54:36AM -0400, Frank Li wrote:
> >> >On Tue, Oct 14, 2025 at 12:54:39PM +0800, Peng Fan wrote:
> >> >> With mailbox channel freed, it is pointless to keep mailbox client.
> >> >> So free the mailbox client in err path.
> >> >>
> >> >> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> >> >> ---
> >> >>  drivers/firmware/imx/imx-scu-irq.c | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >>
> >> >> diff --git a/drivers/firmware/imx/imx-scu-irq.c b/drivers/firmware/imx/imx-scu-irq.c
> >> >> index f2b902e95b738fae90af9cbe54da4f488219906f..1fbe4c3de5c1592bfcf2334a83776c25d5ca7a3f 100644
> >> >> --- a/drivers/firmware/imx/imx-scu-irq.c
> >> >> +++ b/drivers/firmware/imx/imx-scu-irq.c
> >> >> @@ -255,6 +255,7 @@ int imx_scu_enable_general_irq_channel(struct device *dev)
> >> >>
> >> >>  free_ch:
> >> >>  	mbox_free_channel(ch);
> >> >> +	devm_kfree(dev, cl);
> >> >
> >> >
> >> >you use devm_kmalloc(), when return failure, framework will auto free cl.
> >> >
> >> >Avoid mixing manual free and management free code.
> >> >
> >> >So I think this patch is not neccesary.
> >>
> >> Actually in imx-scu.c, there is only a warning message if this API call returns
> >> error. So need to free here.
> >
> >what's warning?
>
> When imx_scu_enable_general_irq_channel() fails, there is only a warning
> printed out as below, the probe continues.
>
>         ret = imx_scu_enable_general_irq_channel(dev);
>         if (ret)
>                 dev_warn(dev,
>                         "failed to enable general irq channel: %d\n", ret);
>
>         dev_info(dev, "NXP i.MX SCU Initialized\n");
>
>         return devm_of_platform_populate(dev);
>
> Thanks,
> Peng

It make sense. commit message need be improved to make more clear.

scu-irq: Free mailbox client on failure at imx_scu_enable_general_irq_channel()

The IRQ mailbox is an optional channel and does not need to be kept until
driver removal when an error occurs. Free the allocated memory in the
error path.

There are

 ch = mbox_request_channel_byname(cl, "gip3");
        if (IS_ERR(ch)) {
                ret = PTR_ERR(ch);
                dev_err(dev, "failed to request mbox chan gip3, ret %d\n", ret);
                devm_kfree(dev, cl);
		^^^
                return ret;
        }

Here should goto free_ch also. keep free at one place.

Frank

>
> >
> >Frank
> >>
> >> Thanks
> >> Peng
> >>
> >> >
> >> >Frank
> >> >>
> >> >>  	return ret;
> >> >>  }
> >> >>
> >> >> --
> >> >> 2.37.1
> >> >>

