Return-Path: <linux-kernel+bounces-823962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB20B87D29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A745565317
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5A257853;
	Fri, 19 Sep 2025 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HxyDcSKJ"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012001.outbound.protection.outlook.com [52.101.66.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B45244671;
	Fri, 19 Sep 2025 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758252873; cv=fail; b=bBQ1eF9jbrimkVgenBhH4n1QSCHAtXIZHbjhFw+buIYugJcIsvIW7q6h7yeL5gwYAdEz+ysRweJ/TyLBJE4+sbi47794eQKEF8yFZKxng1gGcX66eRRoRPvgzU/uCJCUFiYdhO05uX+94o7z/Bg+0bym4RMyMN10CDP46N0Ps3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758252873; c=relaxed/simple;
	bh=fxyDnAKyZeAr/Vuqfdy+1EPaWcCt8Rvdzu+fqrjZ9Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lhRodUTFvXO+0Me/f9aXTnve/FBrVgehYWdrxjnwDvQx3H82rQmOCwzmLwMKXksPNXLs4EmLBlbreHyCvfoF3AUiW2CMfCXfHSSyIeEU9Wnt7ft1kHKUn99lGXcreLZEN/icxQylz/4oC9V50wwEZGiCmFWUuT8wZmpGDqz077I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HxyDcSKJ; arc=fail smtp.client-ip=52.101.66.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJL2mk4wa/l36zGrUux0S2p/Ieh2UgD6xbKgYEbtuYZ4n8nhQPyqEYBfnNvgi7sOUcDvlOdx9L0Kw9NI6cFzkkwbjprISvJozFp0yxNhtM6Vjqekyv3fm+Ora95rBl2wuSAsKwKeypWWCUiNq2fr+SR3xWh3BB9LWI8aSLxrizjoqIVTg7nAAocgZpgTStWTmlo/QPS8wo3HB4lisRysMxbLH8bPKBKM97pr5Z2eqoHcARSlJxFR5cxZkQrykCkwd8YN0Fvikx8jn86dzG+Y4Ov8ls7NFfe3xDkKIdRpNxYpFRk2t7arxcHYeBQkz001UhUgNJWiXo5+UyNUoSi6EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fxyDnAKyZeAr/Vuqfdy+1EPaWcCt8Rvdzu+fqrjZ9Sw=;
 b=WeBSJkEuhksmW78mmDueB4KU1XJ7LpQ/ZgAvB3ibnF8ugKlGK6SxDfcHsAqkJn0urHzlKgw9Gk0HCZIdN7HJR0S2EM2zKgxs9KiLh0r3sS0AC7Y9o3whVfkroMm0I0+k1SQyqN87+R+D9b5WVKOMhkEEl3KDWOEBP7E0LA73W1JnXngmCItl4C1DY8w4X+6v+NlKOqjzBRd+yejMPwIVWdIJgZU4D0Y9rTLaSBtpXPhc43mm/5oIBKts2EukJwiWC8sRGeGz/nB7aQysFyR5b2rXNlJg+wvMPkFi/WomVURGdw8Ehk2+8X9pxRubq6UQTuMqB7kYbw97KWfvr0kqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxyDnAKyZeAr/Vuqfdy+1EPaWcCt8Rvdzu+fqrjZ9Sw=;
 b=HxyDcSKJv2z2ZfKRdRrM0vaBe4iSJc29a15zwSeFyr4qeywSoFKAXEFXKFjPH9nRWXPe8cPZeOtVN8CieTrQXy9RPTlOofjIm8k13CkZDhwPE4ELKjn1/KdhnBVzohI1c+c2zzWOgE4L1fEruVdVn19QNPAkkvAt7KjI9oriG4jDFlfS05YF3xSl7JeHCL6/xYAs4OW1lLS+EYao04O5mff9Yphkzl098QtLg4YQp3/C/TWExtURRYafObaWSLwAO327ickx5W6FQ4saVlXKLsQooRr5w1fZ8Guy5s0Zx/+ln2Qp3OqNcBlZE6BGmhBuYIRupn6myrxnC8MRPbhoCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 03:34:28 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 03:34:28 +0000
Date: Fri, 19 Sep 2025 12:46:08 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arm64: dts: imx8mp-venice-gw702x: reduce RGMII
 CLK drive strength
Message-ID: <20250919044608.GG9196@nxa18884-linux.ap.freescale.net>
References: <20250918154451.2531802-1-tharvey@gateworks.com>
 <20250918154451.2531802-4-tharvey@gateworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918154451.2531802-4-tharvey@gateworks.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: d24adc4b-d6d4-429d-d409-08ddf72d700a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?dxqXpLrSWMqMkq6fdqvC2QdC3nU0JvwnLOuN8kI2tEd9obKIkKQnypYV9Vcg?=
 =?us-ascii?Q?f261VVsXsDcwzsNOc3YpzqpQz1ZRqcSb2tyBba5pu0gxJSEdtZRXAOv32hKn?=
 =?us-ascii?Q?S9u0iDHTm1IWyroUBVJ/ijugQ58RiBFT1/woeKwGOugZgsmlGO72qyaA6HKz?=
 =?us-ascii?Q?E+tynA5h9ab/0rbnp9QlkX1jFtlXcpUQvu4vlM6w01PprhrK5PasW1odbv+h?=
 =?us-ascii?Q?8Bs60ZRTiTlTNayfrEPkz3pxdhQoyy3QPE+X6xESVYZEcddkrYoZGQs7hX45?=
 =?us-ascii?Q?zh5F0ohNiZc5EbcNwzYASLmJF8hFu70ljJVzmAoNICNQm8zFlkZrHMkr0/vE?=
 =?us-ascii?Q?ZiXblxcfdXak97fjrvib5KN3Edr/7d0eaNos2klddsv1o6N5UPaX+C8U8jww?=
 =?us-ascii?Q?abljbq2taCCRXkqi+8zPhSnqcylwNUW0mxG7T0rZlw7KrfwgbDabUP5zflUD?=
 =?us-ascii?Q?zwokT8tDJgp82NbTtBzpMN/3STCWsEjNUtPZkCSdEfy8nadYxLjNRdsrDa4D?=
 =?us-ascii?Q?wfD9mSFhbY7xgNCEc0oi8CBhFiVxxHkSZ34SrD92kTEo/ZBE+MPlRXwK5uWd?=
 =?us-ascii?Q?Z5jX4txQVsaerE8GiyDT/hDj+ZW6faSwFQdFpAHKI1TdfZQSOIB4GoB/DYaa?=
 =?us-ascii?Q?wCODVeZpbObpcm/zg2A+Hovqy5WoxAody2f3ndPlnqLBqknl6kPzcj1eFQcJ?=
 =?us-ascii?Q?j75sLe0SXHdkeb8XqQN0SOo1ZpAMrfjZxv9xAXweRjSsPE1W1eaztHpqvfLr?=
 =?us-ascii?Q?6XjwLDnAZCm3sfKZd+yEqFOvdNPLLyZlGtLFYE5rdasVyxoARRT+V1NEKxT/?=
 =?us-ascii?Q?0IIVX4p31EGmyk1PKJmd8TMjXqC9BurgkvC35m2mwkKu4LBx4vXoA8Xz+Kza?=
 =?us-ascii?Q?RsmHAhHA9B9Cy/5GBPRAHANUb13yxWfyDBJ/U49LErHxehreI0+4bqp2KvwF?=
 =?us-ascii?Q?N7glBXfO5/x4XRFld5RPH1OaLjsBhTyPjtNxCHgw5W7Lrvcme8h5UXMcoYMs?=
 =?us-ascii?Q?al7gtx+a3T11dueqTMi2agauz4NkS0jjgoQyc5V04e5R7CMAb8IkuxuKh7IZ?=
 =?us-ascii?Q?SVYUrOr0uPZveAT8UUZewzx8piGTuTxWi8w01jy8F5sPrrrMfs6O5W6Rwhd2?=
 =?us-ascii?Q?tj+tSLrpw1/MUPTE0JkYncJkBhOTqHeLq0yQf2o1w5uo19cOSJSDv5IysKfR?=
 =?us-ascii?Q?m9+mduQNSTbIc+dkWXdO8RcbdgKpqPeH2FG2LsUHfimPSAPU4ZfQQJKDgO5K?=
 =?us-ascii?Q?WN7POKDbU29RfsWfRyz9r0ZP/iRDUj/hPH5YoPtsvdG81ewqbTiXtsV/K6T2?=
 =?us-ascii?Q?lNqAt6+p0e1AKYJa+FlyjA7dW3Fa2+ywbY51pvt+Ofrrzn0U/DOWZFNWmNrV?=
 =?us-ascii?Q?SXhiP3Dj8R6POlX/Hi8dPXOoGD8X40kEhDKSEWfzAQAfrLv6SjGIiKIsgexP?=
 =?us-ascii?Q?jhGPj3BrYhNzB+NaxAEw0q1AOx1rPynK0TfF1rfX6KK9EXYVmhG6kQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?WXvq6TAg+Ew5/WduKKH6Rrh1VlpFNfvqNeHmlUC4kgdpOPI6LuqRC88bXBnE?=
 =?us-ascii?Q?LtV2vu040YouNWeo+vkDqUv2nJdVNtv8Iwyn0ZiMG7aEwx5CPCdroe2UFLmA?=
 =?us-ascii?Q?6ys1eDKK/ZJBdhxESwoYxNUJpvVhLWQuu65rUl8ogopMQbp28XaDhBlDIo90?=
 =?us-ascii?Q?37rFiPHNhnk8WzBGLuklpWC+IVMPOwZJvxKH2/02bXtpAgmTd8KteU12ZAVe?=
 =?us-ascii?Q?gSqPD5DInew0EJTkvC3ssVqCf6H81YYggG0jF1VMwVsB/BFWHnEb9u8jE9I8?=
 =?us-ascii?Q?m+emAwSp5AEejkNbkuI291p0AnuBJNQs6ipBpIb0R1LLWX74HoOQVHIt+A6o?=
 =?us-ascii?Q?RCa2zj+uV1rZMQlAJ/3S1pFw1droC2q1NzcW4lTVNAJbNfdQMXjlDaXEjaqA?=
 =?us-ascii?Q?HSUlQNiPMe938cFV7e7hBednbHqz8F77W0U5aaysn44Rq9YT2VJQQk0GQMPP?=
 =?us-ascii?Q?qw5jt6W0z5N/gT5J/df/pPpj2XN89kagXmPyrMhAVU76YTps8loYXmOMKpSE?=
 =?us-ascii?Q?yK6lrEbEgO+M9GmialvxT8EtgxyY+4Zt6w/xo+eixdRvQudbIfGRRQDQ81/e?=
 =?us-ascii?Q?73+k3Q+MpcWU69rTONxnQOqCH7yuKXDPbltDYgNALEKmiGIHzlndrsAXnlbC?=
 =?us-ascii?Q?0o2e/5hDRgJmBKZbZh7Amm1DWV+S0iBC1YIA2G1ss1JeFVYh5oA04Jd1mauA?=
 =?us-ascii?Q?YLqPN2owntwHoN25pUArfTarkbFiAF72zo7OTZV2AeOZ1Owg6x7rXIly/rNS?=
 =?us-ascii?Q?KleAAgzmqDgZw+BdqLNgEXkH8aYmtKYZDG+9icCTvxrIKqz2dgNd/gLG+VLa?=
 =?us-ascii?Q?x8eD2qNe+f+gCIIytMjxL7AxUN4gbLMiR2w9QmR7YPPcZqoEJmgjPoU6U9yj?=
 =?us-ascii?Q?3oRD32rtip82+W6sGtuecLb95TG+ihdFXirLgeBnZKsoBiIcRhpHJgddvYkZ?=
 =?us-ascii?Q?5S+mRjH/XSst+xhnXM9OwSytgx0IjtpmoUoJ21MO2MJq/i5AokN1IqsiXfTx?=
 =?us-ascii?Q?stMWwz+LNFJykPph/e2ZICivZbsmo5m1uiLQudAQAasHWhKPOh/gf2n4DIyo?=
 =?us-ascii?Q?fcuEHsdsY2sxKQvo01xfbfgDDHdcbkHzIUZPhNKoBAfVFWQTQaWlGhj9Ey82?=
 =?us-ascii?Q?gUc5dEk1MPjVzPmQhGKGlxjvrG2oKhjZjLOAB39o1boOz9JhGPi4y+cpo0uT?=
 =?us-ascii?Q?LgKKm4sJAcPJ2yrXwctuxQlwqeWiu+MpR0kDQ4YhcpBvW9p5GKWUK8VyFiBP?=
 =?us-ascii?Q?S5lG6VYz6UGBCKgQVwl6uPOSaBhdLATfVJxNsr6BejXxjj3GClnl8YpQmYBL?=
 =?us-ascii?Q?j0F3m9izvfYDlMK4d0vvwjdRjRCdJZ9lqNmodDPCPezUaNrFcdAnl8S3f1Yg?=
 =?us-ascii?Q?VwEXCjrOCMz1Aobu5Ap19xF+9YKc2K/VatoXTRtatjIR9snv3D0fXY9lAxgY?=
 =?us-ascii?Q?jftiVH16pkje7iGNcDncBLkEu20IRGjsMHzo9fxJevE8gL0Pbd8DrTzGoNIO?=
 =?us-ascii?Q?rYCan9Ja4t3DjdTb3XGDsMI03y/p/dm9ST5XdGx/9w+Twcwx8k8tZZmjs4p7?=
 =?us-ascii?Q?Knxk3xn453YeCb8/1PEbQluqpqDaRwKXSF3fssM+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d24adc4b-d6d4-429d-d409-08ddf72d700a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 03:34:28.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7fEOpvEEDiIN9WJ5zhyILuGNdlTrr19R1auAhSSEovs7FXoOGzlRROBMLKrhgAzlLQszniMyeV5Rs2KJIPoliQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Thu, Sep 18, 2025 at 08:44:47AM -0700, Tim Harvey wrote:
>The i.MX8M Plus EQOS RGMII tracelength is less than 1in and does not
>require a x6 drive strength. Reduce the CLK drive strength to x1 for
>lower emissions. Additionally since TXC is not a high frequency clock,
>use slow slew rate (FSEL=0) for lower emmissions and improved signal
>quality.
>
>Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

