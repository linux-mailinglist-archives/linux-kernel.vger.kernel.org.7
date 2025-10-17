Return-Path: <linux-kernel+bounces-858172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00672BE92FF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F91894534
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D8289811;
	Fri, 17 Oct 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fe4fnJkH"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011069.outbound.protection.outlook.com [40.107.130.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A5933971D;
	Fri, 17 Oct 2025 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760711331; cv=fail; b=hiPj+aX3oxKQ4pExkPYg7jPjxT5PeMDxBbUQZKp+B3oIE0k3N1VhChSRz7bPPHd053reUNouWMg25aE/RdP20iKiqysZKBjJ0Qf4tiqtAZY5nWSOId7dvWTyke/aMxmH70jxW/yeSM8Ifc7XP7Yav/Cm2v9J2Te/4c/UB6BhtME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760711331; c=relaxed/simple;
	bh=1/gsUlkw7snuZg1HPVyPWVRZ5err+QmvFT84/tjsOb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dc/DjW5SvvRqW62xP4Q/UYwEF7mXSdPzTd6I7Dyzx8Yz++x5hXILe+2nltF5jDHmbh0yEgaoK6CKgAVRyyi3+NwOMTcZrbFeb1sjhLjVra1XCWf74jdZnEXCvU8tzXlawgFC62FwInxfMb3F9TcTD19qW36nBY897lsD9U39qlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fe4fnJkH; arc=fail smtp.client-ip=40.107.130.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaTXrmvTT5XlepOycMGU32LFeVXQsfz6vREjOgH1xA0YPL4woeP2EAEnGosrzVfeHMhx1NHwApFAVcB5F73qNJDWbQGWM+xaTryHQ4Ox2ruoEPY6T/WD8odm6lEeoDomaHWLg8RSdivWhdZV1ep1plvHgEtxD9nVzsenO4L1cq6wdt9igYRFwUgwzFomtqanZEjvD9P37WBPLorZWSSAA+w8G38wbRgf1sLc+n4k8/PsKHUlcZ+KtDT2C0KkIViZOLe+moAtqHSjSFCpOghieosRfAnHlYBpZXcX6XUibzdFB/cAWuiYlnEwln2dh9lR4cG8GhRUDcukhWEnzzKngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQJR9QYGpqVtWB2KEKXyf2/wjVDfocH46dPTmz0Aau4=;
 b=h1a4iAc2dZMF1tKx1spqvWSrwe0kt272gEJhTi8ax81OqLdMzEXVFeG4OcLeKPZoY19mBaqXkPlkCPN5Y3CFYRuhJsr4MvbTbh03R6HcjwwF1I37v/1DUXTfDMeOfGenE3VlAqc6zDowNlxXvKkzSWyAVPDRrqM5kF+ztIjslC5NJgdTCqi+m4im6ZBA1cmTZAkTxWkKjPGHyqHzwO5B3g7YUbn+iniCe3PaW4KkcNE6jauSi8YQ+NFwSkWHWEoA0jkJ0PFmzIll+JOnGehMG0qFTpXtnn4/QDH2oiJkS0UDnz2zUIigH2VoEx6ATz+b7W2lFn8Wz5WzyHIqVsb/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQJR9QYGpqVtWB2KEKXyf2/wjVDfocH46dPTmz0Aau4=;
 b=fe4fnJkHunvNh2cPGMz1/S08pOikBjzDSuIqVEKlhRU63/qGEtUIq2u+ndUaZkmlVgtjokhhg//of038SgVtTmAglOZng490Jf+QMC5sUi41RhnMCy2ekxn51aneNgnm1iKlf2Nm4Pc1d0pxgcJLuJy4k5AjBoq5Byt06HU8EFjNruj6AtgYu+Qmxv/DjHq6LOC0h4fHKFZGCa0oCbUySN1yufrlo9j8PZkdnXsHdqwZiTJxwcbWYjkkB8SezvFbGHZdne+z3sHU0k/RC0Ag/P8WS0Dn7lSQJC+WcCsEZuq7Y0U3YyiE4hvJMqa3t3NvCR0YJhczZEUofaiL/xRxuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS5PR04MB9854.eurprd04.prod.outlook.com (2603:10a6:20b:673::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 14:28:44 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Fri, 17 Oct 2025
 14:28:44 +0000
Date: Fri, 17 Oct 2025 10:28:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/8] reset: imx8mp-audiomix: Fix bad mask values
Message-ID: <aPJSk2spnihEEkas@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017112025.11997-2-laurentiumihalcea111@gmail.com>
X-ClientProxiedBy: PH0PR07CA0004.namprd07.prod.outlook.com
 (2603:10b6:510:5::9) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS5PR04MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f291342-7626-4453-9c36-08de0d897a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SfpT6/lm39Dj5ieG9bYkmEzKaZrz+QTyFo8VoKUEcWNEIgIHtPzQq65f/YoS?=
 =?us-ascii?Q?fFKodPi2i5zvGqDI9RE34N+7ebsI9ue6eiMItScpczoTCxrEi21EJCqrG1bz?=
 =?us-ascii?Q?sR8C+trW+bW3FhUA0EYMQCAOyg8uJ3A1DwvNzvps22aJfpLzMdDo/elxxHWk?=
 =?us-ascii?Q?425CvDlLkC3qhLrwFqs5fI8A4DmwK8uO7dFgf2PbLgFLriMnMc8aSn6t5o/7?=
 =?us-ascii?Q?M59gdU95yrfWyltwMR4mO1G0t0AJtoAtDv7Tmzvsh+waqbgDtPr95CkysFg1?=
 =?us-ascii?Q?2oYLVuxNJ3Pe6z6sqKhIhyVxa/Pq6KcKrdmNEAP+qrdE7wYrifY2WEgwbMsT?=
 =?us-ascii?Q?XptB7ac/Z27qFCeQJSSBcejoH0x+dmIz7cS3N7zKKdPWA7MRLUeHmcKVyqBn?=
 =?us-ascii?Q?9cVGeMgAG9MvEJ5lpR3CfTECU+myEjQ8SlYnKLpR78i+blv01iByCmqbe2Qe?=
 =?us-ascii?Q?OZ5r6TRNuqViOtcRwbHJk3/KVdsu1YiAuVY/PbZ2US5to6EBP7aHJ4owyP/d?=
 =?us-ascii?Q?/Z0pWhA1qWuqILnM8YiyaTTejpmoL2yq93YOFoW177JWtwHGyyx+K2oLVJZP?=
 =?us-ascii?Q?FIW+BcjNN1NpJfcsDpJUZBrC2G7/8Lb+myzdcuHJMCL9gzXGNUF4JQsdkaQ7?=
 =?us-ascii?Q?CAqTchQEOXPVJ0Xq25brxUXmaQC1eh/h+R85KSLLREWbD7Xeuj6bcnrN9rPM?=
 =?us-ascii?Q?9QGXl6m2yWcXax0GCQnvYi3iiKVgVV4wKJPFTnO1O5iCxGXhVqaLuRG1uiNJ?=
 =?us-ascii?Q?Q4qHEEsvuOQYdZty0S/xXZ7AulxoNCQKtC4RtvL45GAVDwXGE8JqcDp6z7YF?=
 =?us-ascii?Q?jIIiX4llJeWuci66Bc12dfZhTT5GKUC48ZfTQseUCaFJ+W9V+2tqBxJ/ykGr?=
 =?us-ascii?Q?n0TCiCC4cqL1MxMuHz0BQ2wJvwXWeWnOQTjzltMCEaZLrzvzab+iwTVaFXyJ?=
 =?us-ascii?Q?8vrjpb6dZEdVAiTMa2T+nWAON7cflq9xcEFmXDnw4ekjJrh4dpj5fb4ygaQ1?=
 =?us-ascii?Q?j4OVZGT+TqbBC0nJncipbOjNkQLf60SYxS2W0VkZPTiBbTeeuDdNlDzBKsKo?=
 =?us-ascii?Q?oYxH+d6/XxQbOJWFJVRGmU27ERMG0Y6+0DoGonM/ykAqmX4RA0ebNgkGEMo0?=
 =?us-ascii?Q?OW3NMvTomq7eMOLk0ah8zT1kkuz8jFaCUj4P6eu6ayyu02r2YhGwUkuv/+li?=
 =?us-ascii?Q?wAtxWkwdxlUxbntcydNJJ6H8KBC9MonjBfw3IJ4hpWafr03nlDffTgshr3uy?=
 =?us-ascii?Q?o33CUgF/niiFJTDyKyzBC2idFrUGr+tw9WLt+nZ9UweKum3Ulae8X6tuO++s?=
 =?us-ascii?Q?499wbA858FtYiEVlEJSXjctUNictl/cPP8WI6cDVrQX0f0Ij8QP8SUQJnOrY?=
 =?us-ascii?Q?j2pZ8o3ks0NFuzXHyNDkcdGP7kY8IYs30iv70ssmKvh3sGLnfg05HegIOZZ+?=
 =?us-ascii?Q?rQEsXmx5KN18MySGgmax/fjvegPJ8X6llpb9nAiw2+NT4zOWGD+2/w0KQMZk?=
 =?us-ascii?Q?VjxuJj5jS09T15Z/pCOMlcBiGkGGP+yTGKKo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f9NvKBYtFSzvdJNN9gzOAhWY1BSeYAzTHeYDlKEmWj38mE5oh8SIfIE2Nvev?=
 =?us-ascii?Q?dcURifPasZncPGrjwi4+HTajzX1UaKDoGKy0SkWi5nOGh9ENjs18nedow8zs?=
 =?us-ascii?Q?Oq9wbjsh56RYZ8erieFQz1uHavjsDGkksiBA1dRbeDNRh/j6OCuqONuIfR9e?=
 =?us-ascii?Q?Xgv9J1JcprJRnSKbQpiKNzWk2RsncW3zfZTJztp50ifZwmI0u2xjDFAZWRTX?=
 =?us-ascii?Q?EXSfj9aC8RY2ergQFQsupGwI3CwxcKFDYjjdqyT/jWAvja/WqMgejD6E/upX?=
 =?us-ascii?Q?YxXoPYfh/SydV4N9QqVs3l0piV8NKr3I/iX34IRnaiTcn2x301+tMoCUEp5U?=
 =?us-ascii?Q?srGwpVsRWLev1b0bBCYcE+R7Zq16kctb07mu99aD5dR9Si+ZMAm5iyszLRdF?=
 =?us-ascii?Q?vNqg5YDlcYpV0M+13YpJM8GP6ZGO30WVnrAnSIa8MLkkVnsj2h3OG3jMtdwM?=
 =?us-ascii?Q?Y9tZ1AoRkq/R5xrPgHEMllCxg+qgwUoF97eBT6X3DHjb+lWOeHmdXKaF41bY?=
 =?us-ascii?Q?62BCCIC/hZ9Kgi3ivfwK77evLIdjPCnvWoyTF6nXlFDv7/r0BGAhj8+lUNGt?=
 =?us-ascii?Q?2913R9gzvWZdZuLQyfaZrtle04jFVpcEiOrjoshL05BGVkQO6nWY1RIDa7Go?=
 =?us-ascii?Q?4ydv5x1vIo/k/d9BYByA0wuN7J2P8YuX7VGq39cZSAhy+916fSqzw27E4RM5?=
 =?us-ascii?Q?1TAuihZSpsBZNlYs6i4hbWEbmrfpOawwq9X6RLDsTzSBYlvLyRbkEpzDMN5T?=
 =?us-ascii?Q?30iMAOkx1sh/CE0pVVC3EkGwOVGq7GFS4kSLG9d38kJf+mh1+tketT/tXQsc?=
 =?us-ascii?Q?gpjcx+lZ8tMR2mcLE1ueurdF7KQjrcujYraPa2EXwM+iyNmMQXP29i87yyGC?=
 =?us-ascii?Q?zF8993Fqu5+tkOt2KqeMCL8r3Fsja2IZIuzJT9NqAfI3Vc2wE50fkoKYdP5r?=
 =?us-ascii?Q?fBLeCF5JZALI7lsW75U84D+TsfC6l21NVBCRGdIGiXl3dflFOV6sighgVS5A?=
 =?us-ascii?Q?7j87Uwr1yphUvQoETN926iKQBlB9v94jNgZ/sm5fUWJFMPm1FpPmGl56dX/k?=
 =?us-ascii?Q?u0jxxPAuI77N+8FkCPZEPd9SsRPEArzM3/+fhf6Jnr0FYUJ+ed2N/AD+nRVl?=
 =?us-ascii?Q?3wmZ3uCvsl3U6ie1cFdE0E60zxehy4O9zZok4kjy4hhjjUop55yzr/pPbLUq?=
 =?us-ascii?Q?MmiOcMTG92LU9qycCHytXHB5SG0USoIN4n5gUVUM+PGeDDpYDapiSQ1al0sC?=
 =?us-ascii?Q?pnsZMNwSmahVBXI+gv7vrOw0OB51eaR+jvoGdzQwbuoKMAyF3EBgm+DSnf8+?=
 =?us-ascii?Q?jbf9Ms2tl5rFdqu61OKOxwAiKlA8Jp/Nf77nGQU3RrQI20/NC5n+6coO6EiY?=
 =?us-ascii?Q?I+B7pJ6hbRVc/VtsL0gxSy2L8PMOTtazhmkFNFmxVoyJBGKcqjxUnkbIBJgc?=
 =?us-ascii?Q?DfyGDK/c0vRs8bTlWxnOSqjLlCCEkcPtcRU4MFOU5C08FLljcmW4f1h8geXX?=
 =?us-ascii?Q?u9p/sK+fOo338ehGq+nb6cH3OXFly2gO0biudZS1jYjXEvbaEkV7y5exrH7U?=
 =?us-ascii?Q?FpggDyVk4NRS2fpqe9M=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f291342-7626-4453-9c36-08de0d897a3c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 14:28:44.7454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DzPDONQL71hUY7FhxijWEiVQV1qCL4OXuTCHpexjPk/MdmA+s0tYQj1VM/hKhEyJdhMdgFSTw+ot8oIyXRRMhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9854

On Fri, Oct 17, 2025 at 04:20:18AM -0700, Laurentiu Mihalcea wrote:
> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
>
> As per the i.MX8MP TRM, section 14.2 "AUDIO_BLK_CTRL", table 14.2.3.1.1
> "memory map", the definition of the EARC control register shows that the
> EARC controller software reset is controlled via bit 0, while the EARC PHY
> software reset is controlled via bit 1.
>
> This means that the current definitions of IMX8MP_AUDIOMIX_EARC_RESET_MASK
> and IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK are wrong since their values would
> imply that the EARC controller software reset is controlled via bit 1 and
> the EARC PHY software reset is controlled via bit 2. Fix them.
>
> Fixes: a83bc87cd30a ("reset: imx8mp-audiomix: Prepare the code for more reset bits")
> Cc: stable@vger.kernel.org
> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Just curious, why previous version can work?

Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/reset/reset-imx8mp-audiomix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> index 6b357adfe646..eceb37ff5dc5 100644
> --- a/drivers/reset/reset-imx8mp-audiomix.c
> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> @@ -14,8 +14,8 @@
>  #include <linux/reset-controller.h>
>
>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> -#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
> -#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
> +#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(0)
> +#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(1)
>
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_MASK	BIT(5)
> --
> 2.43.0
>

