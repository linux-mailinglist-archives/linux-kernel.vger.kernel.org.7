Return-Path: <linux-kernel+bounces-896139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59461C4FBD9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508BE3A4794
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2CE314A97;
	Tue, 11 Nov 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rp5uQ7h4"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D906E2EBBA9;
	Tue, 11 Nov 2025 20:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894085; cv=fail; b=o63mheX4X8I5hj/DXZUm90vn2iF5T0R/HBMC0rAtMxzx1t1UZaCwX+TvRVOhMmgxdKki9NQUWPtfBcU5Ej0OhMsVNpq3k5ib7r1pOWliRH3hPcf6fq5983d9b99ang4nJyzl7oTTI5sP+eC+NOOU3wh8EI/1he2C+ZenrMyuAIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894085; c=relaxed/simple;
	bh=389jyvQ1geRt7nPAK5NO9kNtdXaQFcf9aBf5tGhgxG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Skgfvt/maU7Cda9HMjkoP9nxsc20Df/+nCf3bWVdJ5vfcXRATZT3eZtR96JlSlTNHZn3wpgu+SU6uPuDyyRtVHy/Jyvq20HyJOmt/4yQFzBORs74NRPlHdJogzSFY4Yx2OCBxhjTv6sxQX/HXTEAo/Ww2J71LDuRDzI4Nq/hN6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rp5uQ7h4; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jySY69wiKudccjCCKhe/3I9YXh3COb3QGV9ooTNdXR+6LLsr4z7yUQzJPRzhMmPpu90Pk/Zb74t05TP/ocfIyHZ81gtBe6rZqMo03KaPJehSaOpPFPjZVeNlGACPY3L+YSubCYS+/xn7Rmzu1cFNtXh9d5zwIWRasyrNqbP6L0sf93CrvyrmVna7UP8ZjZqcRJJGUydsAdYVLStsQ0S4UTd9/i+SDo+CdzcS9pVdF/ddH5V4tUu3oa1eM868rNqzMOdGsu+NZYR0zCfsaAGwdiEoTz5umaC1wfBNgM8h4Lder2zvAq0+HNYj6AyBh32NT5CpOx0fefdE0qGTWgsftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXaZ4l37CBus59jmTYmLUjPo7EnTk3nRRJR0I5h8uNA=;
 b=h9gWgXmE5z/v+zNVUcaPbVg0ICM+HmeVaMFXku5ucvZh96R/JgF9eXH+FoErB6VR91nTVreSJO8iH4vIRCEkViPlHKrgKNO+n0wM238eCYvg5xgxAuCxsu8ldFXZgM0taI6toYSCzYiXxRmDxe7w4aUiPXMOhH2YGS9SnnvngaVzGgsmel0qo81vCRpGRtmqL+z/+Bn6AIgh4XRAy0vjuveI4+US7L972GTlGXfRoHZ+Lvfms6wEE4a964yIYgw9bMr/HFuyjhpaQ8Jpsr0LsQq1/XE19AEUKBIB9O5gZMhd0DvDDMT2sPhlPn8IHC74vd9MNdziuX/omciPxOdVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXaZ4l37CBus59jmTYmLUjPo7EnTk3nRRJR0I5h8uNA=;
 b=Rp5uQ7h40rnTYaII8JnExqk1DMp4nbcHeN/G3yd20WqNWMyERxig/Pv4j77IRmeTTfMyMPb+MsCSlECxBpUZrwzjb+xk77XLf7doamT2UnyXyxqmGCo721hXtK7r8ZD/0rWSL4e7Ih2QvsfihhalPnitSUKpSdSdXqlDz3eSzPtVv7+wbGa7rHMjdrvzldVf3oss2uiKNXUqtvzAO2RwoCmc2wssqT/h1Aa/OeeigvmyVnJ64ZfbIMvsGJ6bBRT0nLKaJvdQTde+STUwX7yrFaMEAGeoCahmx+0QfuC5kPeAnK3owecjeQCGkqpM7odaK7wfXmvwmRpBusc9jKuXQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA1PR04MB10939.eurprd04.prod.outlook.com (2603:10a6:102:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 20:47:59 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 20:47:58 +0000
Date: Tue, 11 Nov 2025 15:47:51 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guoniu Zhou <guoniu.zhou@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/5] media: dt-bindings: nxp,imx8mq-mipi-csi2: Add
 i.MX8ULP compatible string
Message-ID: <aROg99ryy6RTZZIx@lizhi-Precision-Tower-5810>
References: <20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com>
 <20251023-csi2_imx8ulp-v7-1-5ecb081ce79b@nxp.com>
 <20251027000537.GM13023@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027000537.GM13023@pendragon.ideasonboard.com>
X-ClientProxiedBy: SA9PR11CA0005.namprd11.prod.outlook.com
 (2603:10b6:806:6e::10) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA1PR04MB10939:EE_
X-MS-Office365-Filtering-Correlation-Id: 253a3bfb-af88-4ff4-6292-08de21639911
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?yww87KpBgZIBsc9QcAzsy22EbFTHOmUAxFS9ffDWi+1NG6jpfQHqOOHI/ZUP?=
 =?us-ascii?Q?Z36zZYmWpY2CGIzBb2zRqG7L6ujsNOV7/XINKqNensIVna98l0nYPGPj1KqZ?=
 =?us-ascii?Q?06y/m6GNh/+YyfOpC3mNoyJBK0YJGLRbT3sKZkVt7d9nGKJFZZUjS5cVVzd9?=
 =?us-ascii?Q?1IPj0AsoIKRazs8ip9jojwh7GD7gexlOssIk+T2WJJl/12rUuPpPPSzcco5X?=
 =?us-ascii?Q?dL0CGqXXQY9gdpb/rPZ8tBdwZTUhXoXRPq3QOUTEpCZXkb+HsItqr60kRab7?=
 =?us-ascii?Q?lL4gHIVyLHli/As12SK9Erpl6kKKD+yEbR+RjP8HP0OYSzsW4Yd/3AiAvuAZ?=
 =?us-ascii?Q?OncSJSsesi2/sKZOjCAQ3Y0O3yGu2dsu2f1vw3zth4jMF+EJUrOGOE1YdBSW?=
 =?us-ascii?Q?tn6rohXSIWWwW5/Rb04OqfgjKPWtzgfyJ7YMxvTS/dWxIqiPHaa5Sc1l0N1Y?=
 =?us-ascii?Q?/m+M1M9zsGlQYqQiFGLfsbR8IMdgxO6zmraFareUfmbmqoxYyLHNEsx5PmNt?=
 =?us-ascii?Q?oxB1JrNdn7/K/FR/MYr2ZnwewmPWVXO/IBLn1BdlGywPYWrW6V9DKoG0Ooa2?=
 =?us-ascii?Q?AwTWoE7zldY4QDj/aPdaOHcMPgFVUWSPvdFPYZysPhC/mQ71QiLN9e7M5vhm?=
 =?us-ascii?Q?fOi7u4CZUgylkpXVEuPjR6mUUwb04hp3qTuFWm+1GVe6Rmn7s6ZyEgjknsWk?=
 =?us-ascii?Q?9aE8pT1L1oEcavu08ZrHOGN2BU0I4Tgk4qC/Q/hBdT8o2IjF2YEXLOvNommw?=
 =?us-ascii?Q?9gkWOZt/+QSAzHZnfIlZbyx1pNYyTvRp2U2NWrPS1gINzwMCM2S8d9TzKTp5?=
 =?us-ascii?Q?t6bdMQ9CONju3tSC1WF66LZXFvjYiu5cypqZ6J+xI415arkFSc76NwrVn7wI?=
 =?us-ascii?Q?ftbAMvRk+p2S3TAC8uIuES8h0kppXNVpIBlxFw45blwlM1CoCOIogxvWklwa?=
 =?us-ascii?Q?CFfIxNkaM0LanvZGHwuih7MZhKo1nwPLneVWFN2QKY/cvsLApFHxsCQ/BaWs?=
 =?us-ascii?Q?5uAHaSjFL8zJjrClIpEZm/cfCnFUOs3UgwzE8D9N/xUoClnzk84p5/Njx1wY?=
 =?us-ascii?Q?bUPGvFobw6ZIuhNHRdhUr+oMftWgh7H+MQ/KoGgqI3iRawxslC08o7wVDXnH?=
 =?us-ascii?Q?T5sj3KZmHTU+BRCSuvGVmNrtumFxhni0tI1fEDCACZx3vk+keAt2zL74D3Kc?=
 =?us-ascii?Q?KGCAGqrL/GeC5l1i7cMbQva1rXw+6EtsIkNeY7TZm35xDkds8rtkuAJJ5zSM?=
 =?us-ascii?Q?UhL5bGxK3mgwJWt9GyEERiaP5XdA38ow4wGTJ+6k0kqwHjfadloqxFtqxapS?=
 =?us-ascii?Q?qQI3/oSDElZjKwR7MrvF29XXxugg+spNNnbVUnttiYezY8ZTbQI5OX4oBYmc?=
 =?us-ascii?Q?SoSc6Ru0FIV4HEUWOXoHDY/FDBGyBjLESinc5wMITguQQsQPinH1d1/FRFbO?=
 =?us-ascii?Q?elgOOfhzbHmeFtp+4XdXQL9JdYwaGCjLTWPDLFktTmYw1wtzDrxaYHWb5w2v?=
 =?us-ascii?Q?nlrA/bxSDct5LUWn6NYCNGCIZKdtuPzooYUE?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?6oAigogDOerJtSWxv9S2wihCOK2umHRhZiupjS25uLu2jS8bHtGrE1PqcJqG?=
 =?us-ascii?Q?yLG6zImXwd++dGiCMnh+x/BqYFuu2FPg2YnZRJihYVq2agCoq+wmBAqWGjVS?=
 =?us-ascii?Q?bKVVGEtG38xNFazbp7oeebvkqvCaQKy/d8LH2CYWiqw0BLLNwYjVHWMfIh+K?=
 =?us-ascii?Q?2T0z/glrjsg5c9hCnzq4r2jce+2/KKKPQpXBi/IqvnDO9QU3JoeqoKrgG0VI?=
 =?us-ascii?Q?QLPia1wbgQF36rsSxOrLm4DefjjiC08dypw6ZV2l+X1n+/EF/fm7K5MuZlb7?=
 =?us-ascii?Q?9ZOIkMQyBYBZ69hsf6nsKzb8nEUYfVyzKh3lRZINQGFs2vvrzR30WBQqz2di?=
 =?us-ascii?Q?ZQdReswb2kjZF8g0Z9tu9GINgYQlRo1c/j2+iMQMY8ZoL0pqn1kdsXZaKeTB?=
 =?us-ascii?Q?SeIVtVYvmK2lH8+wpLPR6CThFPIVNsSdFmtK+Phi7+qO/hNA0MqTLyV72Flf?=
 =?us-ascii?Q?NkCw7cf7kD4AHYDKL2oSEIoeGg3hUpGRNXTqai7ZhouBWve4VVV8NoZd2okK?=
 =?us-ascii?Q?leZYbgYdPQ5dmOAUhu8KvoDUCYPZvDIfY3jThoKByxM0XJn9ciyh7bNM687+?=
 =?us-ascii?Q?LPANVPGwKKaos7z9DabgvpdgEoGuJTLgLwi+DkYQOUgGBbtrrNyIZBadKsti?=
 =?us-ascii?Q?gVAECi5KMqvolH3taVJfQxWAjdeEjeMzTXsq5Krpz+1ea33rznFoEzdHtuvg?=
 =?us-ascii?Q?onWUAkEnn2OHB67MTqJOGoa6le+lvOlgJbV7w0CjRylBuiXF8Sanr5LgQAWc?=
 =?us-ascii?Q?ebZLQbigbn1yx2Lux31cywk+vPbIexMqRX9liJMYh//3LjNnhtIq7TC8nzcx?=
 =?us-ascii?Q?rnoIvNOyJd1nXBnuQKsAqxJxXR75ymj306A+A9rPYvonCs9/jx1SOSfHNgXk?=
 =?us-ascii?Q?YT34Zfo7CrbxXBFGiRQfF4g5dzaMW03e6GxXR+vG2YFqIZw3ZdJEarwkbapS?=
 =?us-ascii?Q?KvSEQi1PutiJS49JeBmlbMyYscI+BOqLdEH0jklk2qaZlAzgDIJbC0WdSLHS?=
 =?us-ascii?Q?+Iilf8H4I9mxr8MPQeyWC2yCTxFZxANJvpG3pSUSIFKhqe3utYHzC7Ezpv4Z?=
 =?us-ascii?Q?GaJvY0SuAd0yFmVnNOpC879kprPNGrsX41OvtXN9oTgh6ODR6+KwEqoDJatA?=
 =?us-ascii?Q?S+dLLv5OJQL4Bv43qVj5RtXyUXUQ5JbnERVKCRE5U1GA09tfe8LBitZQxPLy?=
 =?us-ascii?Q?yQMMlAFUJWuq+FPIc26lMKSCmYZRcPhHfvr/V/p/2XZseOQTi/BQt+WhLKXe?=
 =?us-ascii?Q?irbayGDuUOgHYaS+KRgXQwoYoAPi8wj2EGzuWuNyFIUxNYEB1Si9vVOePftd?=
 =?us-ascii?Q?ReallZSjxkOmoWZmU61SUVloU66d01lGRubQvH8AZmR9u9XjBhMtSbu5cGLX?=
 =?us-ascii?Q?dGRrDj5T/nqy5fcnVdrkppSG4OSZ6BAnvJPeeqW6enn+fBCpbexT1ObZv8mW?=
 =?us-ascii?Q?80hewzhMAABUDKzj/391QqQ7jB9BDD21g73k3iGdfMT/NeKjkEz+3Uk9QMEl?=
 =?us-ascii?Q?lu0Rd4giTEjywC8Pis42g7xrZ3tqJ/opwlKTDTTgcExfWA7YUDGVMIdxJQJe?=
 =?us-ascii?Q?Rmi0F+gT2nqzwTyCKoKHBQJxZKdhgaqG+5i5AESI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 253a3bfb-af88-4ff4-6292-08de21639911
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 20:47:58.9106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XGjewjOX/lZc1IersKRG823//DTkS+9MteWyy26h/exFE350RALKE31HoBYwrmoDnYKDM+UQQ1PAJW3InQilQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10939

On Mon, Oct 27, 2025 at 02:05:37AM +0200, Laurent Pinchart wrote:
> Hi Guoniu,
>
> On Thu, Oct 23, 2025 at 05:19:42PM +0800, Guoniu Zhou wrote:
> > From: Guoniu Zhou <guoniu.zhou@nxp.com>
> >
> > The CSI-2 receiver in the i.MX8ULP is almost identical to the version
> > present in the i.MX8QXP/QM, but i.MX8ULP CSI-2 controller needs pclk
> > clock as the input clock for its APB interface of Control and Status
> > register(CSR). So add compatible string fsl,imx8ulp-mipi-csi2 and
> > increase maxItems of Clocks (clock-names) to 4 from 3.  And keep the
> > same restriction for existing compatible.
> >
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> > ---
> >  .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 41 ++++++++++++++++++++--
> >  1 file changed, 39 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > index 3389bab266a9adbda313c8ad795b998641df12f3..da3978da1cab75292ada3f24837443f7f4ab6418 100644
> > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > @@ -20,6 +20,7 @@ properties:
> >        - enum:
> >            - fsl,imx8mq-mipi-csi2
> >            - fsl,imx8qxp-mipi-csi2
> > +          - fsl,imx8ulp-mipi-csi2
> >        - items:
> >            - const: fsl,imx8qm-mipi-csi2
> >            - const: fsl,imx8qxp-mipi-csi2
> > @@ -39,12 +40,16 @@ properties:
> >                       clock that the RX DPHY receives.
> >        - description: ui is the pixel clock (phy_ref up to 333Mhz).
> >                       See the reference manual for details.
> > +      - description: pclk is clock for csr APB interface.
> > +    minItems: 3
> >
> >    clock-names:
> >      items:
> >        - const: core
> >        - const: esc
> >        - const: ui
> > +      - const: pclk
> > +    minItems: 3
> >
> >    power-domains:
> >      maxItems: 1
> > @@ -130,19 +135,51 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > -              - fsl,imx8qxp-mipi-csi2
> > +              - fsl,imx8ulp-mipi-csi2
> > +    then:
> > +      properties:
> > +        reg:
> > +          minItems: 2
> > +        resets:
> > +          minItems: 2
> > +          maxItems: 2
> > +        clocks:
> > +          minItems: 4
> > +        clock-names:
> > +          minItems: 4
>
> Do we need the clock-names constraint ? The DT schemas will enforce that
> clocks and clock-names always have the same number of elements.
>

clock-names list already restrict at top section

clock-names:
  items:
    - const: core
    - const: esc
    - const: ui
    - const: pclk
  minItems: 3

Here just restrict need 4 clocks, instead 3 clock for fsl,imx8ulp-mipi-csi2

Frank
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: fsl,imx8qxp-mipi-csi2
> >      then:
> >        properties:
> >          reg:
> >            minItems: 2
> >          resets:
> >            maxItems: 1
> > -    else:
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          maxItems: 3
> > +
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8mq-mipi-csi2
> > +    then:
> >        properties:
> >          reg:
> >            maxItems: 1
> >          resets:
> >            minItems: 3
> > +        clocks:
> > +          maxItems: 3
> > +        clock-names:
> > +          maxItems: 3
> >        required:
> >          - fsl,mipi-phy-gpr
> >
>
> Could you please sort those conditional blocks by alphabetical order of
> the compatible strings ?
>
> --
> Regards,
>
> Laurent Pinchart

