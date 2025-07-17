Return-Path: <linux-kernel+bounces-735250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A95B08CC8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 066F11A67D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7563D2BCF73;
	Thu, 17 Jul 2025 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kepdxcXe"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013000.outbound.protection.outlook.com [40.107.162.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8F126561C;
	Thu, 17 Jul 2025 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752755028; cv=fail; b=KfCsuEIyp8mQyxLeg9504eoFHQIVrHhwlvrTG5TgH+J7vumV+euiIrwf+Ebsm4S6qM93csZd6HxZsIXinqH6Wmfr4YOjumOgTBc1x9yITqjOmIZ4oJIWOSm9UeNhVJZ9c2zvCHTnaH7LA//yGvzhtBed5xpShnFJdc8dFsEubIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752755028; c=relaxed/simple;
	bh=fPnxVY9aYV/s/pHyCX/HHSLWAWsQBynLOXF15hMuzn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gv65+4NhenAw7902f7V2+jQWGYssjIUx28hywIs0G4gOiw/dyoPY6aFCIiiloEfaGdCm1n1k7lCOcbDVp2IFwB8IYUNRcQd6kA7C3GlFqMm9hKqErwoaYjD0b00ZUsI7I8yCxK/pHGTwIM2kYr8A4aAxw8fGGx0ZU1vbiqvx0NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kepdxcXe; arc=fail smtp.client-ip=40.107.162.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RngyqK7YNhv+lX3iKFHj++X5JH2RPk4bl7yyEQ4Ev6BOqGI5S2ZrZ/0a+Ur309bZ1zf49CaOO1NBgOsIcaKD4RbU3EOaWWJqvB+7QqQYKOLjsILBCr5WSPn4bIWYbiuR33PUwouCpTgAk6fXYzRqPueWveZmztvE42vDTjDgEdrxq+rkeRCoj9MN85amPL+o8mWMY1FjZ06YGkSDsO0dVSv/2bcsmac6dAjR+m0xLjnwRHm+7Lqcu0kaTKb9pXhSqxuyC4NJEH2SD68jqkfMQpVxg8Dz8dpnU59+2efrHlENCK+5Ir/XHktBDwSZ5tJZomV55fh68ulmOb6dk1abzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7n37Nd7p37UKwRhHIC03Bcou9LXITUmriK/9jHQjTA=;
 b=GrQV6q79zoLYAoW+6isUaoVdFCsPkaAFBVUxEzt28F3DcWbJVTdbXDdwRN5Ir71OuF0XnGN5SBZAl4BiJCKVN8nzadHqYqo9jyCVuX9VyXe7hdA8rCy8a9fgx4GXBgGdf6ztJunaHvOU1sdXJ+sRWnOVc0EXIPFhwhU2kz/1LcoMlCnToRD+ZnxXuTzmPA5C/MvP0cFUF7qlmDCICclGCfWyFMFUJ6flaLbeA0l9eP1SqHJ4G9h5uf9J9vnSdnSacRTJhcbyhuflOVFtlRKWM+OA/heD+DPoP7d3ZVZDFL19ulRDKwtTFCT2gLUDlyHnkZ8NnIw+VZ3urvmU63Hkhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7n37Nd7p37UKwRhHIC03Bcou9LXITUmriK/9jHQjTA=;
 b=kepdxcXeu+y1e3iF+w5xCLmhB40t1ruPQrzbm6cuZ/RaUOFDGAbIsO9rO08SFM/B2Qtqw0jlc+U1My/xEl5J+vDkVeH63/zV2cPwRgfBYyA/TF8q0zlwtG0FNvu1CXv2VJW4oohp35S32o1x/YCIRePDQVICAjuCf/do6pO++HYjxzsRxh+eH3RtNJNaPSLjZK2rbn7sGtMmfMVsoYck3/LmX/JCu1c15Zz0posrA36NU3wQ94SzOuE85EFtrH1em5/ylnuF5ppoiQSgGklDN0vXNN4KAuNvFcyCufBalnVWN9q2gy4mCOnV8aChSLIXmS209BjocZqO0yrda0lXBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::12)
 by AM7PR04MB6774.eurprd04.prod.outlook.com (2603:10a6:20b:104::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 12:23:42 +0000
Received: from AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30]) by AS4PR04MB9576.eurprd04.prod.outlook.com
 ([fe80::9cf2:8eae:c3d1:2f30%4]) with mapi id 15.20.8901.021; Thu, 17 Jul 2025
 12:23:42 +0000
Date: Thu, 17 Jul 2025 15:23:38 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>, 
	Peng Fan <peng.fan@nxp.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] clk: imx95-blk-ctl: Save/restore registers when
 RPM routines are called
Message-ID: <lp3m4bahzbwvb6nfu2o6hsr5cux3y4rgdasbgba2jc774iei5a@plfpzihh7pen>
References: <20250716081519.3400158-1-laurentiu.palcu@oss.nxp.com>
 <20250716081519.3400158-3-laurentiu.palcu@oss.nxp.com>
 <aHfvbTpQ4LmexJpA@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHfvbTpQ4LmexJpA@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: FR4P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::17) To AS4PR04MB9576.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9576:EE_|AM7PR04MB6774:EE_
X-MS-Office365-Filtering-Correlation-Id: bc573423-ba10-4117-be8c-08ddc52cc457
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h2+m3xEplw7ll3cFJf+LsKCJtryvHBEvQbuBDAE1hzF4wgaTv8oPsc8/BaTq?=
 =?us-ascii?Q?f1LcaCqaEAkH139WFa3PD7n0I+KBo7xlXb6R86cCBNGw1mLwwqT8KS3zR+ZI?=
 =?us-ascii?Q?lRHnulZIP3qNG4ks/2rSi0wgi5ju9mPcnB8a5vPfEOvWHI3dwqdrfwHA7Z2H?=
 =?us-ascii?Q?GXne96nm7/v46yRNcGdKNIefWdMVgU3ZItyFjWJ776SurTds2g+RPmsanxbZ?=
 =?us-ascii?Q?dJmgLN8vXMqBcNnBMAagWVN1D3c1iyvU+i18dlNN/U2L3euhQg1Uvpa8QAXA?=
 =?us-ascii?Q?UThF158bvT9uN9b6Ub1s0UldMWtVMw8FgY70+D02W1zo5LmXyKC48xL0FXd3?=
 =?us-ascii?Q?co81JX/GQV6I8tTATZHYbZoPBH3n4GkaPOmGF736Sjx0MVovV4xy3qo+zlsF?=
 =?us-ascii?Q?SnmI1qmx27qlnW8y3/tpbmQIvJZ+PqGPYbPV3Qrlmih71F3TeoobNu0Ywtxi?=
 =?us-ascii?Q?2ffeDxv9r4RRJa8GQ7+AjeEOI267t/SpOV2Y2OlK2dApaV3lBiyqsbB55u2p?=
 =?us-ascii?Q?T5gBYnyHbW4741j6Irqe0S8gXhQWP4CbFUJ4lwSCF8zEhUi1he7DNqSIobAc?=
 =?us-ascii?Q?o1HFhDDysw38bs1vhRe4gNMR5KW9jBrWufPTyr1IeYkXrOPpXjMM2D25aB0E?=
 =?us-ascii?Q?b4hUgoJn6ULTKixul51qH1DrwOhzhGy5zgZYBZwihea9tdHB9wjiKylCGESV?=
 =?us-ascii?Q?li2eiJFA7TRhGGY0k4p9IhAh20k6y8cOxDfV2o4vxSrpVbAhrILfn9Nq7SxX?=
 =?us-ascii?Q?DoaI+mTvEy0R/oPP9ZtaE4sGbBpv3u9kpxLTXjizXNy+ajmKr2P9Whg1uqp6?=
 =?us-ascii?Q?8HQmNOPHWGiuKTlo8U2Ud5Bjp5MiAAGWOEYaNG8MSeuqkpiDihDZQpcgqW2D?=
 =?us-ascii?Q?wsVuf40J8nxgkLdUi0iFN4Z4me35QQKU2YY0bqN6y3glr9NV5EP3KZcop5pj?=
 =?us-ascii?Q?RkoeD5bG5+PUz1EuzxjS+LJsVN1kd1CFisVM3U2CsQ+Zkmg7Y1rA98+jQrBn?=
 =?us-ascii?Q?DTAgs1pMwX+FbNNxIXp+i4amkf3ZKAy0QLs1GmyVF6i1Ec9Av6SYCHCsmdtG?=
 =?us-ascii?Q?qy6e0mDA4uJwEHmnqJgGrCgyxEW7Q+R97LPvuSFbWcAmWH0YbkuEs63YYzcN?=
 =?us-ascii?Q?opp+frNk9FlhdohRRTsrL82gQK9roUTB9LpAUfMTrydeL4RVu+ACAmPC+tIE?=
 =?us-ascii?Q?tpStQN8MGRLD/5E9NZJjmIHSjtSz1usCRYXzOoGka1oIUeW2+ulQ3Zkz9FQk?=
 =?us-ascii?Q?3D6kDcXiay75qvguWT3DIpIKIlAGv2uMQ6p6lPzsFaV3VlfyXlggHL9+i9Oo?=
 =?us-ascii?Q?0UR4wfrjs2Pt9H3EK3H0e5sz7fhoBecEk2tb+T8VAWb5ZQ0lzcM4/rG83L9r?=
 =?us-ascii?Q?6N24XwfSo9DNMBu180bEsJt0/ACjKa5V55EYLVDYWSTiUHO/c++NhZwm8ZNH?=
 =?us-ascii?Q?MxIjvLSccz8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9576.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VBeHovefM3Rc8pwzrnnEtb+GA/iU/RAUmXkeT2eRi3oWKTWm0pu55yW4ocJL?=
 =?us-ascii?Q?wpnWL9D03NN3ibf/QEcnanhL8HldBWojUaZQ/ZAWQG9W8oUDyblJvL8FwvyJ?=
 =?us-ascii?Q?QTh0aCoFQSDDQ31DfyEeozmbit9LDy9DmiGJ2xmcp2svRhm+6fgi5KujWDM5?=
 =?us-ascii?Q?vic1p8OKNRkqpLXOsDFWrF4XpH+eqX3a17B3BRG+e3l2TBaI7t0GXJHEbXug?=
 =?us-ascii?Q?FzM0d6ua1Cgdqow30sOyCcKkClbTfcZQLtMU8XFnLRytB0B1tWI+6CDs402k?=
 =?us-ascii?Q?t5jGM02/I4CeNujR9J9mNNYBssGxh3IUHDQSACf3tdcllAmBcvlzKd1OlNR0?=
 =?us-ascii?Q?p+RfWT9SCO7RKLb6jopmPw/spXBbIoupvIlHF8IUyKwE9GxcNFFjvWurrSAj?=
 =?us-ascii?Q?wJdMyiQqBmRPT6gXlJIlEGrCOIvZOt9WVhQ519KmFwhv3WjpMGnDT6LeNHKd?=
 =?us-ascii?Q?U7UVm3fpWgApXP1MUdbiB06thOHihn2Q/NJyBgdt2ubtQCy+/A96x/M2cDKj?=
 =?us-ascii?Q?D5BKzWJBa1SoBEPUGos84j4gQXGAE/HCI7GnJO0dVpJvR9oYhb1MCQSanKIw?=
 =?us-ascii?Q?93uIubtEcVgCFKaNE2MAz14MqP/BYYjURj1WuN7Oj9jsZA+W4BpxyVi1VgR2?=
 =?us-ascii?Q?IYSYbI6F3/urBoAATKdKryqQM3DqHamH4qTEZBX531qkvqUObVgpA0kbhG/a?=
 =?us-ascii?Q?jVfbBnsL+cxPIoVNfyQ6zC63gNvy0060WixAK8KqNFiwiRLDPEr9wf5bVogj?=
 =?us-ascii?Q?54FIas2+pSKlNZtDN73RcCG00ri0MpCDqXhFXQThZw8GoftioJecJG3E12yk?=
 =?us-ascii?Q?S9LK6x7dCbho5hanfnblgofM9FTN7R5m4dtdqbCyO4AgVVxeniRfybvwZX4+?=
 =?us-ascii?Q?njY7BMqcYkRPCsSEbVBYrL+AUc5itCiK0AVYk/4d+6kZtDYOXDqSbNwBIHjf?=
 =?us-ascii?Q?oHBI08nHHamssDieZ4zj8dyaeXpXDbTpMo1F7BdkxvJ/sJ1SjthbgkiHBFH+?=
 =?us-ascii?Q?lfJJxBvg3LCoeb3skqTLjArtOuUxi26iqeBhWXNeTnQbR9ffkfZS6IN3kDCr?=
 =?us-ascii?Q?Zcm3KgE4ba93Ilz2RuYKWwY5ShCw5+6u97L0NAeCGO2frE3b49hPhfJILxuz?=
 =?us-ascii?Q?d3ZtrrfBaepNGb0Y4v2CNJEeUs7VC+H/d7fhp78E8g02T8gwWLWanyDp/18t?=
 =?us-ascii?Q?JxSCpqzwBFvlKVK2mK7IJMm0ju2gcCms93ImA/Ik5Clpb717gJ2caYFy8JNN?=
 =?us-ascii?Q?SO1SQtw4V11auZ7fWaOORBsO2UOqmasrwODEf/5+9cGfvEiCrx08cvKxrNqa?=
 =?us-ascii?Q?K2r3nalpAe2vLRTwgjHdbaGR5vjGgPQvf8NEbvuRPBU5lDYIjRQppVXK4dmf?=
 =?us-ascii?Q?9mU0besbUgUJeA1TxH4gBWWrjPKnkqG35kWBIiWLZTDXGpklMK12KxZooRY3?=
 =?us-ascii?Q?aXfrFRucZ/gHrMZQx484vxA41kmVYDxIeoypga9W3Mv7L2ZIQLQUy1SpKbn+?=
 =?us-ascii?Q?GUclkYQ8B5ppDy3J2EHzk2kS91yqPJWMN82g4004oYUSPiGWECf3inXfBjXz?=
 =?us-ascii?Q?JVn15EgrRWuo1nZVjmmpoFiX+5kB13c2zEqk6Bs8gsY7MLf3fcnQeYK0+nOt?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc573423-ba10-4117-be8c-08ddc52cc457
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9576.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 12:23:42.4242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GirOClC05egxiGTMqKL3wj+xBFdG2m0tQbl01ackLwNuFA9OgI6Fb625UORfEBZisjHlu11uMe9lHFETBfs7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6774

Hi Frank,

On Wed, Jul 16, 2025 at 02:29:01PM -0400, Frank Li wrote:
> On Wed, Jul 16, 2025 at 11:15:06AM +0300, Laurentiu Palcu wrote:
> > If runtime PM is used for the clock providers and they're part of a
> > power domain, then the power domain supply will be cut off when runtime
> > suspended. That means all BLK CTL registers belonging to that power
> > domain will be reset. Save the registers, then, before entering suspend
> > and restore them in resume.
> >
> > Also, fix the suspend/resume routines and make sure we disable/enable
> > the clock correctly.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  drivers/clk/imx/clk-imx95-blk-ctl.c | 25 +++++++++++++------------
> >  1 file changed, 13 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > index c72debaf3a60b..3f6bcc33bbe99 100644
> > --- a/drivers/clk/imx/clk-imx95-blk-ctl.c
> > +++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
> > @@ -453,7 +453,9 @@ static int imx95_bc_runtime_suspend(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> >
> > +	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> >  	clk_disable_unprepare(bc->clk_apb);
> > +
> >  	return 0;
> >  }
> >
> > @@ -461,7 +463,10 @@ static int imx95_bc_runtime_resume(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> >
> > -	return clk_prepare_enable(bc->clk_apb);
> > +	clk_prepare_enable(bc->clk_apb);
> 
> Need check clk_prepare_enable()'s return value!
> 
> > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > +
> > +	return 0;
> >  }
> >  #endif
> >
> > @@ -469,17 +474,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
> >  static int imx95_bc_suspend(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> > -	int ret;
> >
> > -	if (bc->pdata->rpm_enabled) {
> > -		ret = pm_runtime_get_sync(bc->dev);
> > -		if (ret < 0) {
> > -			pm_runtime_put_noidle(bc->dev);
> > -			return ret;
> > -		}
> > -	}
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> >
> >  	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
> > +	clk_disable_unprepare(bc->clk_apb);
> >
> >  	return 0;
> >  }
> > @@ -488,10 +488,11 @@ static int imx95_bc_resume(struct device *dev)
> >  {
> >  	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
> >
> > -	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> > +	if (pm_runtime_suspended(dev))
> > +		return 0;
> >
> > -	if (bc->pdata->rpm_enabled)
> > -		pm_runtime_put(bc->dev);
> > +	clk_prepare_enable(bc->clk_apb);
> > +	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
> >
> >  	return 0;
> >  }
> 
> Look like needn't imx95_bc_resume() and imx95_bc_suspend()
> 
> DEFINE_RUNTIME_DEV_PM_OPS() will use pm_runtime_force_suspend(), which
> do similar things with above logic.

As I said for v1, we cannot use DEFINE_RUNTIME_DEV_PM_OPS(). This driver
is used for various clock providers and RPM can be disabled for some of
them (see rpm_enabled flag in platform data). When RPM is disabled and
DEFINE_RUNTIME_DEV_PM_OPS() is used, pm_runtime_force_suspend() is
called, as you pointed out, and suspend() is never called.

Thanks,
Laurentiu

> 
> Frank
> 
> 
> > --
> > 2.34.1
> >

