Return-Path: <linux-kernel+bounces-855256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E04BE0A56
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 22:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BCFBC4FE1EF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D53305E04;
	Wed, 15 Oct 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a11Kg6bh"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAB4302742;
	Wed, 15 Oct 2025 20:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560487; cv=fail; b=pZtWit6mI8bPRPbjm2l1EP1ce0SIjyvHIxGl6rO+EIiC/OaPj9xiugSzkDEBDt/NimHqcbOnoaqm+R+63Dwm7mDrrd1rcXAI+oFfoRUxgJlUWu66c7POg4tkXDqzLyP/remK3GvuGoIdootd0tIZlAJUn0tQD+c1QEZARadMWRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560487; c=relaxed/simple;
	bh=RpkNFtikYsCTlTctzNA5YBJWwIvRQQ1pflhR7aEhXQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ozu6sCrwMxByzZ+Att2gBw/O/G7pVUZajumWP2xqmUpYsRts9Ufqe0dLRhwqwDmmqz0PE2dBlaxNt4qmECn+H9aAscESa/KjPRebEXYrFZdJv0fLl9KAm6nHLyUJj/0tt0mfmBmuDfYmttaHTMI5MqspT1SCmRwuUJ1uE4WP9qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a11Kg6bh; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MvSLLJ3hHoK9Qe0O289TBMY8zbcNuDQ5sN89OKe4kazDXo2hnslETantgd4dPUUbG8KO1ssY5JNYUQn/7qBYyu40G8ccpORA+Hfg8wnXTYTJHlDm/DD/mMAz/y09KI6I4GLLkazBAaAURm44X+Zj4nrlA8xoy8Oy+rH1xXH9vNwnHYAEk3Es88vPlMBhkSc2yR7iO62iYGMnmofGB3WYkDDmafEYcWtuIFxJTVf9P57HIJ/E/+1g69XOZPKx3Xf6xS2VLPMkkKRl9ByaRk8OloybRF6Cz+uhF4CXRmXpmZOOvngCfaZSU6UejlTWsEVFVuG5bRxULwJJ/lmrS4/T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wm6Yveb7TURE5rbYKACzY/hFToFCMld1KacmyH10qsY=;
 b=Vg+VVYjbAR3etx3QDBAvddZIAaeot+b2IP1Lz0ZM9U5dzB/EEjaPZVlDaUZMnXrB2dM/SUDfhNN9f0sQCwBaSWdyO/uo7LBK6te6TCI51S39qv/fUJPSOMsgaB3rGVq0pCEgDATrU3ZEjYtmMA88ODWyJ0bNlFYeWzAef3HC3HsXGeMqvz5vMtRfH8AKxkMpnEPnUvCRVYHz3rSkib9L0KsSSzT0edWDLYN/g/xb1r8/GA65W7ZftoX3F1R6Iz/60RE35/5g7Q3z6vB3eA7tYGCJhn1w54xChoR8vysF3oUmJthS2wtuYemTnXvJdJ4/BKx+6HciCouyEEUhm7JZCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wm6Yveb7TURE5rbYKACzY/hFToFCMld1KacmyH10qsY=;
 b=a11Kg6bhwuOAqa2lN9PkfmifXqOYJD5T1kSKPHc832WBTO19w4HHIp50wpCSoZeesuKzvBeqsVSHedvkPQm1kiEZhFw34Go6VYNg8GfENHhqFpJoSz4cpyDkiAp7P/IrDUZs41MAFMvx9TpGP3OZ14a/kRVObV/g7WJY5tlkU5iAv6nJ2330qOjQUf34ZjRjH8Anxprsthl8TzWMn8Y6clhcZHmKT5bG+nCo5sPAW6+q1q6W4w5fwBDHuDLft3qLljHZXOsHajL1dGiweVB/3Jpz+R3IcHG4EuE6Uh4qDdqZnEqISzok0907LoYEUcwJLX6HTQy2+arNxoU0foYgww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8768.eurprd04.prod.outlook.com (2603:10a6:102:20f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 20:34:41 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 20:34:41 +0000
Date: Wed, 15 Oct 2025 16:34:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/11] ARM: dts: imx6: rename touch-thermal0 to
 touch-0-thermal
Message-ID: <aPAFWuJCfvTcK8hz@lizhi-Precision-Tower-5810>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
 <20251015-imx6_dts_cleanup-v2-2-41a7281b98c6@nxp.com>
 <aO_9Tw1s7VcHauNh@shell.armlinux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aO_9Tw1s7VcHauNh@shell.armlinux.org.uk>
X-ClientProxiedBy: PH0PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:510:5::19) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: 3312e933-6cd5-431d-cc1c-08de0c2a44db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|52116014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uri0J0sBVSlImiQPPCmt7I2i9XeB00467BthiFa1QVwE2MhNqf+JXf28carD?=
 =?us-ascii?Q?KF+fuDHRDVjxOdOF7Tbjo+XSza609Nb4Tl/C/2aUayMluKIxWj8ytH1RTKuJ?=
 =?us-ascii?Q?aYIow5DBjYyj5RS0xM0GQBIyrQspIrRbzj7XNw7zjTmV/yyqUxq4PkZ6eUrm?=
 =?us-ascii?Q?juI5brpFZUzmSFn7Zirb0/B61vnkibH6QSU9DmU9vfAiWHNx/wPxbTPS0t8k?=
 =?us-ascii?Q?vWU93cuxqPJYzwIsL+BHVka3O/Vo8q4Nss8Shz2ocg60bdp6Hd+XdytgAjV0?=
 =?us-ascii?Q?3PKjLZBVNBzUxKs/MAKJyzL/82mUn61DMGipcV6Iyob9Pua9k59xHap72+sx?=
 =?us-ascii?Q?JX4Y776QoGFbFxJn1RTDqcfPUI0RN7U0xCesvYDhKg95SrG2zITwdmVJz3r8?=
 =?us-ascii?Q?dq17khXTWTIdYOtc3l8VFIhdX63qawH0+SuXvN0Zn5ta1r5ayRvuMX6QqQCD?=
 =?us-ascii?Q?aoH6Gwq7dIJekcGiA/WoCRs7jM6llEBBNGaWxif92IYVgzNaf4KjcEQIyC1t?=
 =?us-ascii?Q?FNB6D++1nhNyONufVCFX0jqJLfyaACVPdRucHSO4quaU8Z/utkLbRqNE8hzw?=
 =?us-ascii?Q?sLm/jEL1VUCrbbOXYqbP8Fs72CnzVsm3GDPPtvX40+ylQDm5qhn+oCSBDgSO?=
 =?us-ascii?Q?YwYAbGVwL6UjCQcI1Tk4jKugouc1178kyhYbE0I9NM65FrCDnoqqpwRGhXhN?=
 =?us-ascii?Q?ifgA2C3tNuf5CKzhVX0btO1e2Cz5I1p7ff3ZUtgPzXAW05P13SObYDcvJPf0?=
 =?us-ascii?Q?nWWbCNYhwZCeUeTP+A+F8ICZ91/ZG6eD79ENBD0Afq7wYyB/bPGedV/7bUhV?=
 =?us-ascii?Q?9/3VAVwcXth0p50E5hnQ0OlBKxXVUk8xJSh9rpKN8GR/e98ncbCeR0eXqpHq?=
 =?us-ascii?Q?k3dr7Um4mdqiAOgdDlKblW53UG83acarjo76dgpriFWshUyH6X9cbNPQeT+8?=
 =?us-ascii?Q?Zrb2wgX+MqKA/AqLxnefvHs2wlzYYPfthnbgrtJpWx+yCqkZi5ubt8Jd/39i?=
 =?us-ascii?Q?nxJuZRfPOzTyKY+uZRNm34g/83HuziqKmx5floCYD53iukgMwJ4YBjhPX21R?=
 =?us-ascii?Q?ryeLO7n/Wn/c8VGP6KtRRBXHm0evUf72iXcJB18a9eFzsAGrnbXn29QHfTq2?=
 =?us-ascii?Q?xVsSOJQI0q0ooKff0j5l7zxy9fQFnUExPwGeUXJsmw9zpp0b4CjgoFAjC94I?=
 =?us-ascii?Q?CkIPQQvgxW5bgt0KCaRNl/6at7Yv9ytMdyONSUSG6SnASXZXTHF7PUan2xuY?=
 =?us-ascii?Q?DwMuCjAOLrDUpohvsUkHb5djE2KACtOwHKU45kQb1o+cwEtLukE2Agweb6LC?=
 =?us-ascii?Q?zuitnTzfr7Upz0QUBxukxcmBA9+Cd88Po2RP2Y4Yh2b9iWQVgz0ewfuSfjZx?=
 =?us-ascii?Q?lisYc6a0KMvFni1i3HLGBihODujENym7KrMI3b1lsbh6r+L8JJa9xx0C6YYD?=
 =?us-ascii?Q?sCmuk8vVsKw2Ltf6HXUm+OEWMK22e9vp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(52116014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zTx9HGPcnHTy0RcMAsWm4ot+S5pWdi8jKcD02XmIGHIoD25uWHB51tS6q0MF?=
 =?us-ascii?Q?h79KmCkJDvx9zZ+Qwn0YUh8YqwBXHiSLe95UqEycz+nQg59t1MPgg74BaZsd?=
 =?us-ascii?Q?FeNlil4Ta61cSNlEY/nx+0aTvlZ+ND8/AGQmOGaTdJx2a0kubJDhdcBi/aEV?=
 =?us-ascii?Q?3C6gw0afz8269jd/9R62AQ0OCOoOZB7tjNh1glOI8V0OycLd7Is4FKcpmUX5?=
 =?us-ascii?Q?cxziO8oFmF0HgdAtGe6q+zL50Orh0+oxBCx0nvZ5wYYOYGYR7nta38jyvP6h?=
 =?us-ascii?Q?TOumWyEEH+mJw7DwhoH++dvJa2vyWAjVWLujq+sQcPPHTVe8dilVQ1Kj6RMM?=
 =?us-ascii?Q?37MJcpfBTwAJMacYjwVFh6Q7MxFpDculkeLc9sHQ+Pd4Dpp0tTFAd2GrLijW?=
 =?us-ascii?Q?3K+A9LpvUfvECu9QmHjufZn65LqyPv4dXZTJdGr1gWHlpZv2JLAMzkLpy913?=
 =?us-ascii?Q?NdDn3gjK4Zp5LcELxZlZXGXjO/y4cTZ8zIUT+u2wjgL5IOjWUqeK3W44yl/4?=
 =?us-ascii?Q?KwgyRnibnuW9P936LfUeOH6fJ32A+5+nC2vDuB5cCxIGkCf9Fl/EHVi2LeVv?=
 =?us-ascii?Q?pFeejO8qpdH/WNEjwBJb78Zt2C5XUGTJL/iUgkzXXITWC8YobaBCCWfvkjAn?=
 =?us-ascii?Q?JOwZC/O5z+Ql01UnEj/AI86GKIh4f4zBt55Y+s3ZnJdCzN59cEuH2rvrSpTZ?=
 =?us-ascii?Q?Gxsfv9PaYNTQBCEcvcm1+vHt424uUhpo57MpBVi6/xrisIUS+JN9M/LrVELr?=
 =?us-ascii?Q?26VXptRaeIeTPsHNS+TD1jWHOWw/hAeV8ySqtkmVF7QztR2YSowrz2DjAayl?=
 =?us-ascii?Q?p34jAdQcslzLVtlVOtyBY6oA51kBIWAIcUsRpa/BoN1CjXLcJUnFrEljbYt5?=
 =?us-ascii?Q?hW6M6cgNlznwgNedkndrF3DKimUvGGhcgPhIhKPFIaVrtKHOSoM2yUH90JPI?=
 =?us-ascii?Q?hNubSdqbsyHOWnOSTijqpJnDrAHS6jtu1sqfI65o/ZlVAo7Nynx9Kh9BfNix?=
 =?us-ascii?Q?HmO1bEG4ooHl8BxgxfwlXIVvPJu3b+Avo4aG61lSgnwqOjM3/LnCMGVWu7FW?=
 =?us-ascii?Q?IYmC6jxRr/kaJYzAQxoGh+sRMPl3+73MCXuSO1YRPsQx7dQxF10dWqHGOUlj?=
 =?us-ascii?Q?rArRU6ymF3TD/M5iYhLrySq+HlvHSAlxo+C5JkA4ov6p2/E9a0YHzDaKC0iA?=
 =?us-ascii?Q?GZwZSQp2tJGDSlOu80kSUpo07l1dip2i1C9G5s+YX54LExlgrAfiUX4EKWRT?=
 =?us-ascii?Q?9U9YjDVUC1svhlKYtW2QISnV33hfyJ5u+47ovEjD9dzydt6oocPYO8mNHrIi?=
 =?us-ascii?Q?9uo+zIaTrcrH5hoxPO4RGr/iX9JH0Mg1jP6NX73s2mZyt2vzJ4SD7eIQuk4i?=
 =?us-ascii?Q?efs3NeKQnK6Or+lBfRwhdb4PjDS37ucVT1BV9S1s0gd+a/9EPgl0YOw7RYpE?=
 =?us-ascii?Q?uuvNTrunO9MkhHLfoCHPMjlOA1ZLOx8qizncuZZrZ6mMnl0QZYSOYs3QFOxY?=
 =?us-ascii?Q?FcomBRB76GBe588dzCGaReb9X+xlySg2BcqCZtsG+3mXqpZZ/QBrgYvOWM9O?=
 =?us-ascii?Q?fGfl+z8XcJXppdhwrUI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3312e933-6cd5-431d-cc1c-08de0c2a44db
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 20:34:41.7844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tplKDGgqH7rvbQEK8ssH4ockHEpfnTGqb7ZDNojUQZ4pFVEjhqBBZCbXi5Asg9ivog5m8TvvK5BIgRH36JXJAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8768

On Wed, Oct 15, 2025 at 09:00:15PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 15, 2025 at 12:44:27PM -0400, Frank Li wrote:
> > -		touch-thermal0 {
> > +		touch0-thermal {
> ...
> > -		touch-thermal1 {
> > +		touch1-thermal {
> ...
> > -		touch-thermal0 {
> > +		touch-0-thermal {
> ...
> > -		touch-thermal1 {
> > +		touch-1-thermal {
> ...
> > -		touch-thermal0 {
> > +		touch-0-thermal {
> ...
> > -		touch-thermal1 {
> > +		touch-1-thermal {
>
> Is it touch-N-thermal or touchN-thermal?

What's difference? I suppose both naming should be okay.

Frank
>
> --
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

