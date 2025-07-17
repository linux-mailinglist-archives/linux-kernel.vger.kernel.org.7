Return-Path: <linux-kernel+bounces-735580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C39B0912E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A353B49DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC8B2FC011;
	Thu, 17 Jul 2025 15:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dde+YMKQ"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010009.outbound.protection.outlook.com [52.101.69.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247BB2F9490;
	Thu, 17 Jul 2025 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767808; cv=fail; b=hvwX3W405LOX6MmVdh41M3kRyAaPJSAZ0BSidlLEb1lVyPHVQn4FAsu9PsxJqUh6eFjyqZtxBdpYfmDPRLalM8S8ZtRzuQJwdCUYAO3ISIyec7VUMjCitpQe83BaHIUXackENgyn9bsF5ECSnObGNT3hYhlga0gsHwOFvlCBRgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767808; c=relaxed/simple;
	bh=Ty4KfyX5zfvSXdSn5xtlQkERoGPhlAJYPl1NS7EmaVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kMhO8Q2AvmVlrlqYqTCFmaNwr08VnGdZlijCKdzQ2iHr8DczAZRNx9qGM59umnceGd5LOG2v2p3XP4iUJOZfTy6o/7VaiXM8rUcCWshtl/D2Cjh9bDBO2ILmefVNx38JDfqwRtiGwo7UyBTuMj5tF8sZWIUsGpJUmUARt0g7F/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dde+YMKQ; arc=fail smtp.client-ip=52.101.69.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yDKKyoMl5dQzsl1LC4QA55JCzyoSlOUdSi9ioQerMZ6ZxYIKZ4vpgnRfJG2Uxriy7T/Uuyvl8iIRiqv1uEyo3Hjk0PCgZ6hogSuJATjWV3xRJsdUVDoMFmWg9I2jLJn25msqQtf7GJp5t5DtpZKhs8wTQEqBp4jhNQNwG4AI68qzlKmZYo1VGwjWhpwHjaxuLZtKL173p+BT6KMuspRz4SuHcbP9uNQSkQVKT0o/MeOFI9ujwNwt7slu0/b5WemoD1Z/zSKZtOG3OS8Wpq6yKFSPV2d/xGlOKI7EQ/TCpOZ0k7pKNxAuOwLhadh/UdfYVdMPjVbMztg+96NwKR9Rkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p79z5SKKr6c+tOM6QbqYFZPpfA/eCo6/tVY+BJFdHFQ=;
 b=bevjEi+pKfDdYbJpzicvlsaTKdgLG1mizaKZBSbnTZlV45px528VIjeFxZAtKSC6/K5wXvKKA34lo88MIEMBxqDfS0K2kAC1DzE64FR2cuQVdNQcyZdeQB6SKfyEJ1N1bWw58Jrj5N2lTnmb6jLpNmfsgw2gSMslw+/8+hk0A5tT7IjPhSV23M67S1tSQnd3GGY7Gd8LbmfVJhw/5AnvGHPeQQAnStLer6FuNda10FFDSc3QKpj7mSiiSO1J35DxgN5O1slPmUxe+9ghsJEj85yQskahiRaFKdbPSft5unagUl6OephMb8o/2dW+9wBIN0M+UCH1cvoiv4Z3AJcr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p79z5SKKr6c+tOM6QbqYFZPpfA/eCo6/tVY+BJFdHFQ=;
 b=Dde+YMKQPWg+qn0ag9XhhJqcCbItffirTnlG+S1oIU00DAxP0ZiF43PZOkFbmQLSvP2t94mTv20/6gtk+Fs0hZyvWGM//YE4Ynk868QBabOuqB4UPd29ZYvK+HqEFf3PHhIm1W7Bd69X3wukRYYBIcZLwserAnuBegbXvenpcLzQTgYs/3lQG2vKgmfcgMtI44LUybtJGrobiTNe3H78FwtkqVksCTNBJAz57kRntaxART+7efBFjOgua0l2Jnj/Vfpb6ZAvYv+a1sksFcJPr5PnoDlJmB1K8d6DBJ3yTJF7GAaF1dBcwpde+MUoNg84m58XY27E/NHud7epfJpjwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7048.eurprd04.prod.outlook.com (2603:10a6:20b:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Thu, 17 Jul
 2025 15:56:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 15:56:39 +0000
Date: Thu, 17 Jul 2025 11:56:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Xu Yang <xu.yang_2@nxp.com>, Peter Chen <peter.chen@kernel.org>,
	Chester Lin <chester62515@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Fabio Estevam <festevam@gmail.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	imx@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/3] usb: chipidea: imx: Fix style issues
Message-ID: <aHkdMimhC2N3nTd3@lizhi-Precision-Tower-5810>
References: <a5f4c53e-98a2-4eb0-9f30-55313be27f86@sabinyo.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5f4c53e-98a2-4eb0-9f30-55313be27f86@sabinyo.mountain>
X-ClientProxiedBy: AM0PR02CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7048:EE_
X-MS-Office365-Filtering-Correlation-Id: 31157276-8739-41a2-1dba-08ddc54a8474
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fTc/c9b6Gk3wnt2WIt9Hywkb2s9hBxsMnPRrcdIcP819J9OYwjTCU0vUXzBu?=
 =?us-ascii?Q?F7sNPwPm32ws7dbZnYuwn4cu6SyyOwXyQWwnC22SRpxYp6h0qenlgq2bIKEN?=
 =?us-ascii?Q?/X3EJd1htSFfP7GHzLxjGXzgaRQH3ATMekJna8g3I9WBxYo4910tgAP3Mlve?=
 =?us-ascii?Q?uGH9+Z9Ju2LFeXPqKBCIWrglzQJp7KwOFpUeoPnaanhQCJotrWDWScZcVui+?=
 =?us-ascii?Q?PH4pWBRNKMDwHp3Jl+r2829LSvzPyOYgVh17OhLjeTGdEvjnd9JQnMnFV6kg?=
 =?us-ascii?Q?ZQ+3CBpxNx2N5HzAgkRnUmrExLY9YTfoBKz2natjaJ1Hhbz/arswJJ9AQWSt?=
 =?us-ascii?Q?OowguhUqREH4mqyyEzUKCeXlT4O78WXrTWvbQO2ANp2T2t6yjOZpSjjNKact?=
 =?us-ascii?Q?ctXP3+/Id2rn7px2eb52rkvOIclrb7N9Fb8v/QeUcD09AysC3rpcO3mba708?=
 =?us-ascii?Q?xc1y2VbOXQ7SzQjHDmllhnPRmPQLubqkLIWlx/ws8b0PXEAzYcNG/mHs5ErL?=
 =?us-ascii?Q?8tf0/OI0/PMr2czQVz+AJJzuqHBBYOsKpJA08MQyyaI5bDBvge/X4+mTrwLL?=
 =?us-ascii?Q?jdyT3OhAKei/0bWIyg/YbqDek8ZtTd0F2PpiaY6JH/ELf+k7xXXoeYLC5Sfq?=
 =?us-ascii?Q?UZ2HKco2NfiKMB+X2BJYSznFVQN1FenALtMbWMPUshKHU5Xd38L137TXGrBT?=
 =?us-ascii?Q?JPRGMwIWjn0q9P5HpnL9BZ47BhpoUKBzqg6WXk1jx4d5wznVDaP3qM9g9lPM?=
 =?us-ascii?Q?e6Qw+if97oYTPRjasclnlYsjgiAtAApxT7GDgyBhls6wFWHSmeMZdW/4vg3h?=
 =?us-ascii?Q?lsYcGcK7rG0nHswOfX0/4G3likqnwXKXzeUo8F0AH+aPMeqLMuqtVWL/Jsyi?=
 =?us-ascii?Q?RZr0nQPijW8ZcxlYjPPXOx7qiogq+V5iAWXi1RaFhg/oBjmcA5Z69vsaCeqc?=
 =?us-ascii?Q?ZMI4HPf3eXWGRG/gvlUISwIBrU4vx12qyk0K+NGEn2JcwV6OO3ggrNH/CQTM?=
 =?us-ascii?Q?IpYlenFf3oRWpgRUx9OztO4BkQTI69K32iuKAsJ9AsSQTKwDIc536QyTzQNE?=
 =?us-ascii?Q?b+8hVmNqMdXSESFTP0hmOU0j6V9273m6fmUogUgAtamWHph3Rp+SSXB29QGl?=
 =?us-ascii?Q?zcuNhw4lLFDbesisrHueOSJnr2YgnOvy3X+CTs59FuWBRTrjecMrXWmO0U8b?=
 =?us-ascii?Q?18/aH44dud5yhM2qdTwcwy8tUp1sCh6dm67fKufeUNdYdLTphy0hIUZq9XO7?=
 =?us-ascii?Q?mgFlXBiiqFE0G88WFWhEn4LnkaND7JXLRa8/WAKYamRAWKREG5fKxRZBLTjP?=
 =?us-ascii?Q?jfxVDbYoHuOnJqnyCgNZttPcpBdeGHMLu1XmAN5zeUkeLVeWNNmNaKnwflQd?=
 =?us-ascii?Q?cD8loJelc7TwmKayfb7PJfC1brAQPsNN4x+19CJnVq7a30soYJ0Fgpst21W0?=
 =?us-ascii?Q?dEC8BVJ6mWxw7Rpbkb55Qc3gVmbFIJuDGrv0073UoUpbDT2jpHjGdg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(52116014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lEZIed5efdQmT2KHUXGJbTyH3lJojx3Hsg1bR+wgUoKTefY0Yz3K2tUBNfL4?=
 =?us-ascii?Q?bJm0IrquXrI3zvW8oYMbbl/ITkT5VVC2bAzPIn0JTIU3rbYK60Nd5UtwGDLX?=
 =?us-ascii?Q?0w66VH2NUQ2uSbyS6bFf/s7SI7sKLwmEfYeWtNvOrCPuwnKQMdR7XVtIDNYQ?=
 =?us-ascii?Q?DiYUSaDxle7lIN9spFSFdBwrVFz6Sw4as4dcQEebRrk07FzEJuOj4pXnOsBm?=
 =?us-ascii?Q?2kOj+GmMYsWsgRaIv3WWMVt75LRCW21mZ7F6lUOfwJvamk8q1LncufLG0Evw?=
 =?us-ascii?Q?qsARJSf+6qf16xmyBPD302j0X2y874Uxkz1w/KJTQI3hXCnhYqALFS4jzhB6?=
 =?us-ascii?Q?oAx7JO7QsAb2Ox3GdkgHzcqBhIghtVMb1vYUBSwlgBpUkZrfg4YULe7PWwN7?=
 =?us-ascii?Q?sKD+SJGx4EESFDgm9BNgCnMoX4vm/Ilp0UjXTWRukqGnSuHtkEfLhdd+biSX?=
 =?us-ascii?Q?z9fueLLBwJ9RDPPl3C/R+cER0m9issNMSdq4b/MXn72knP/JqPP6GqlUFpmy?=
 =?us-ascii?Q?KQZj/7lMkbz73mNcZmSIotDt8PmNGgScwuhsXW96WL+L1+VExAxYbt4P9Vbc?=
 =?us-ascii?Q?X0KCxwQUNUloYdBhjmBzBKj10YrSOXqvo/Y/sRdIXISvM7r06h3wZkgVpz7C?=
 =?us-ascii?Q?vQ1u/7UIbcgAnIRngDl5jVva6dy5QClpMl//uEKS2aRtiMRLJW3O0fc3GZRD?=
 =?us-ascii?Q?WPV4bIn9Y0KZvBV8fOI7vpBFWaukNmfLJny/9u/LaUkikKXEn/Hrv1qH8a0q?=
 =?us-ascii?Q?8PeTeXWpw7Cqh+Zmc2/ftxsy6o4vINTxKRlA5FqxU9L9oev1b6TXvwBAU3zA?=
 =?us-ascii?Q?QRemqMO1XFLKRbgYE5UFMAZbzbdiXF/MBip1/bUtlqhfUanWqLz7J0PzoXyL?=
 =?us-ascii?Q?+O+JhrffQex34MIq4ENRnq/zoef+0GXdNBX116Jhlc3Uc99rF8uBYufcwaaR?=
 =?us-ascii?Q?92cWbazszVVheo5mQZzyxr9TubwVi6gSWdOyuYD9D2IiN0dCRcYwknPmunj3?=
 =?us-ascii?Q?ohDx0rfZ3Rt0KgMmm91gtV2/KF2/Bgddv6XGHLYSyPZ393Yg6u+c6dLwy2Lp?=
 =?us-ascii?Q?ks4MMCwk8B09J7lMDuL+XlHrWoU00nDWECvBuPbGgP57BMdUNoCX57CvLhL2?=
 =?us-ascii?Q?nZfzIks9huCQsNiYl7PtJ4gdwXzC7VtvUy+HSVakt6T9QsTJU87izT/PNjbv?=
 =?us-ascii?Q?cjnk0ROVzpoZ9dklMpRFTDnEWhIGzVO2TNfYdX45tiRZhS32t88QICBjvfoK?=
 =?us-ascii?Q?2/cIsmYpWvO5+V8fO/bXGTYo8lf6nUvAYudWQXmyEoUAfFroT4UHh58gqwu2?=
 =?us-ascii?Q?HTaBj+iZwRzfGmlc10MhkGDfnJ1alMLfx5qGm8niA30ZqupscVQ95iQkoqoK?=
 =?us-ascii?Q?JzPVa38zPD6rRXLrgKoRVqFHqInxHF5mxqzikKzhtvQPyr2WWTuDZAdZ2RJ5?=
 =?us-ascii?Q?9bHbCMb81ARoNFn8kMVBby9yP/pG2I4R9iNpDm8nXFVUOFttk6gwzcwTNaMN?=
 =?us-ascii?Q?bJ/P+OyxmG8mL4uN8T/V6crVyUpYiH7rLNRS18k5BYvYmXfj4Y+ULS0uHEyq?=
 =?us-ascii?Q?Avu9vTAI1qg472ruKPUfypkmhTT3GTPeSbU4R0uf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31157276-8739-41a2-1dba-08ddc54a8474
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 15:56:39.8746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mir/f6MfyhYveGhVFKiTUKcYQzI9bI5m9J2alAH3RjnOlWXikjCz4koO0HoHRA3tDe8GRqdY2T27Vlm1RnxPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7048

On Wed, Jul 16, 2025 at 05:46:17PM -0500, Dan Carpenter wrote:
> Xu Yang pointed these style issues.  Sorry for the delay on this.  I was
> out of office last week.
>
> Dan Carpenter (3):
>   usb: chipidea: imx: Add a missing blank line
>   arm64: dts: s32g3: Fix whitespace issue in device tree
>   arm64: dts: s32g2: Re-order usbmisc device tree section

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  arch/arm64/boot/dts/freescale/s32g2.dtsi |  2 +-
>  arch/arm64/boot/dts/freescale/s32g3.dtsi | 32 ++++++++++++------------
>  drivers/usb/chipidea/usbmisc_imx.c       |  1 +
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> --
> 2.47.2
>

