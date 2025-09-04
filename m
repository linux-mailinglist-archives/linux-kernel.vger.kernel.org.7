Return-Path: <linux-kernel+bounces-800732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE71B43B4B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3EB174631
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 12:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59262DCF71;
	Thu,  4 Sep 2025 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kgl1zpw0"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E562E8B84;
	Thu,  4 Sep 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756988084; cv=fail; b=pvp5luD1q0d6IyQcm1E1KK0zpAllSJoNzK2fCOJhop+oUwICdnJPUIFFqZQgpYhsnNahZw+H2fTOrwwevYGyp67paCSrK8uhfRUNgjx6cz3Fye21JFiaSs4NGchmFY9O8Kb5lhw6OF1YTYCpf9vNXesBkGGlOH5C2w4lPVitpKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756988084; c=relaxed/simple;
	bh=MgpYUF0WbV+m7Xa5eE2KR9FdXZchQUwof/RfAwkG4Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l4UHFz/FMaBEJqqW2xbYHbA8MksghxfzP+N/Dpwe7nzjLV8mAFSpPClbb3UJowjfL0+Xgual1pk6KNjdDtOHsBeu0LdPi9lS7kHFM7j6x6M4Etu3hSiK2/aVZcHFC/OjLfya8Ex0uk6cfQeUydYZsteKnICw0+kMdp2OM9tlyeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kgl1zpw0; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJ2efAS0NpZVa4oCsPeW4i2imc9zyyRf2vPJnCRu1RkAIsQ15TQL469o0G+ZSKfvBgvDe22UiGBqCZjK19qKQY7A0pg67SFe2WlbWz9eMaR0JBPoiXJtWqErlVIqXctKYPII8+Ox8VYur+L9zD4W1+dXMGSUjkkFlJt5sR2i4yYpVTOfrFFaM6baYB1/aaxYiOSSL71UCnXOwWKoP1pMY6PxL4SNGS7JK2tWtIgvN01SMIkm9VresCGXghxjTJ6/h16yb8wBqqw+zmO2ePyG9Vq/p37GNHgCOqlpSMI8VdgG5Jj5SsTWJx8U87BeywnJ00iU/rkfCPj9TJAzbYrxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTG0hpViq4x1WdXPUY0ZvleNgY+ZRGbVt6Kx4/giHAg=;
 b=eKWulGUJsg6s0n6mEuJSvGWjIEdGFsANg3se+c3e50AGI1hEGd2ZhmY19v6/iNtgB0Qhzstf0woeS4R7P/FKuZ8qEX/QTfK/TFZ7jb7YQePmgvf490NzNrvEOTkAJgejnNfeQLbToMJU4tA4rXXK/lJeIwwCoq58tF/beBm6aOFnFPuycF9wZZLNOxG8JoOhmTPEANSYrzrw6M7zuYtamtPdaG+G77vTtZxfZ33XlmlxAxMNQOy2XvLXjvWNnm7z7TvVtK35PtkXK1kbIPrVQFPix/ppPhff/WQ6rMXo4dsQpA4mNm31t1wEhnF9xJFRULxSugmAdYZa1ezQZvt4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTG0hpViq4x1WdXPUY0ZvleNgY+ZRGbVt6Kx4/giHAg=;
 b=kgl1zpw0nAZfWVBUEkpaoCn+42Ac3R20FogmPweLZjGSjDyshff2a4uWUH9BoEigM6CvilmRAU1APdeMAOjmGHrD/a+Cr91ppiZTHiiYtvWLXmUo4VBNUTShT+/HBdKlcwA0U+weREOHi/PV49oWwiGue1pECRCItVOMX/7aFheLQTctYbgOcwdOhQwD/ih5TJW2pLlHPYvYYG0vUYwE5MgDdNHD5k1FBzcZUyS0U4bVArpXDBcuzglygE7wtYRMpl8dHlsZRe/+rFQ+eo3C6jfwr9zlxR7tp2J9zCCgbcJq03S8rJCpScIsMLzO2vU0+7AdSHLVJpoWyYBlnpK9BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by DUZPR04MB9872.eurprd04.prod.outlook.com (2603:10a6:10:4dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Thu, 4 Sep
 2025 12:14:37 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 12:14:36 +0000
Date: Thu, 4 Sep 2025 15:14:31 +0300
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: imx@lists.linux.dev, Philipp Zabel <p.zabel@pengutronix.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] dt-bindings: display: imx: Add bindings for
 i.MX94 DCIF
Message-ID: <s6uc6wjdb3seygps6nvusvu3x2io46dc5kai2bnelpnggpgyyh@j2ao3lhupohz>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
 <20250903123332.2569241-5-laurentiu.palcu@oss.nxp.com>
 <20250904-attentive-seagull-of-fantasy-adea9f@kuoka>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904-attentive-seagull-of-fantasy-adea9f@kuoka>
X-ClientProxiedBy: AS4PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::6) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|DUZPR04MB9872:EE_
X-MS-Office365-Filtering-Correlation-Id: fe09cacc-d69f-4a1f-fd24-08ddebac9d26
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IRrTExC3N9Nu08WDhz7rcAbIJ2ggEWET32uQfvKCCBAyE3WUE5AHySKeWMrm?=
 =?us-ascii?Q?CPvzRVV6vjjuIEFVEaVMZ0JsfLgcCIOCXkE+IIOl/4RM5s9M1+rZmcrZfYaY?=
 =?us-ascii?Q?bUMUvg3cHUCqfpUh8KyLqaF5ia/gXZngQBF30dg/fp66Bw7/qPoEaAWYF6Uo?=
 =?us-ascii?Q?FYkRUhdR07KfHi1+V/Ua/RgRkPLWnO2xvx60fclXgDELlwAGNguHv2HR/zHG?=
 =?us-ascii?Q?f/gl3RFHchLrubSOA9uZtiT2IFCF+PXqSgpJcr7VMHE2iPbaTDiDUTSgEPvx?=
 =?us-ascii?Q?E3XHCGi5PM9FFy8bh7NZ4TK4bBpFLVkr6qj0RGlOMBVVhYmRDGIeMc4utLdq?=
 =?us-ascii?Q?GYOLxpTvkPHIoq5C8N4rEdpvz1LmGhvrh6iqEjozLHw51cei5xFsFd6de/R6?=
 =?us-ascii?Q?Vi1XpBhuiJ6iUpIyZa7Pf+AfdIwvPKkkOb/u7cyoEo7ks+PfBztMLPaen5e0?=
 =?us-ascii?Q?13p2EXhn697sRerpNUbXMfuNgD0mhnIBnB6mtIVnT+y3i6WJO2hqNM4YFL8/?=
 =?us-ascii?Q?jyNtVhLgiU41SJjEusob+naWNSiWzp2kpUu/U0D9nTQCN/aJ5It74EwRlfuW?=
 =?us-ascii?Q?R85QzP4nY5i1BakJhCugRNy9BNOxLOkRhB71oNdd+26jPFTk6xeHicAXPkol?=
 =?us-ascii?Q?mDgNrub7DwmghdXumvhpfZUVDTi9uE/YC4e0FFR5yvkEGAIsZ++I0OSHRQXV?=
 =?us-ascii?Q?6O6Yb6W9kNQyzmunaqZjOetqdtmTab/ND7YRuIaQtBce7kCTJz8G/aE9qPeQ?=
 =?us-ascii?Q?AMGo61NB6HYMP/1VH3RM4HQLQEYtfgmQn6WllWY1cjrrlyTIaLFUGbT6sDuG?=
 =?us-ascii?Q?OZlNfeUrRFrxWlo7s3XqyprEfTR60GHgx5lvV9PV0JMF2sDnRSj4LVZOAe4J?=
 =?us-ascii?Q?TMKnTIsuk+rVNE5JAZksI/WYDXuypkbj/Yj939USvLcbyxjVBzZ8q4/ehorI?=
 =?us-ascii?Q?6HalNexPAhgX1yVnCHxPRoDhgxN6S0Ag3Wj43IQLuu8+TW5C1CRAQWW5r2cy?=
 =?us-ascii?Q?h3tRiCOnNvSdDLiN7fU9dSP67uJDuXtbYuawlVQCHn0OM6YuNI3JZJ1+8AMG?=
 =?us-ascii?Q?3lgZVHJogFoTD/egxiJN47el8LC82v9JqpGCuU+U4LpcWzkq+642N5DQwcRi?=
 =?us-ascii?Q?h+R1JCCMdEe931GHfjtgfngJ0k5UTUgsOO1OGJ6WpZXKGJYrk73Vn4u6zwrs?=
 =?us-ascii?Q?ZQMg57136MAN23i+HTfeyzcpcXQJBQGTcV7DQ8Bsr5HK8LbivZBMn4oBp6Nk?=
 =?us-ascii?Q?d1uEh1g9OU6E1ZzDMP5Ew1YcEDsyIm+B+nK8ZdyjbdXTO3flYC4zDMv8Nyzp?=
 =?us-ascii?Q?ap06NR6UmLQE59t73obVl3HxNA865SgIpfbtsaAh5XbQg8uKrWqIvdt7Xls9?=
 =?us-ascii?Q?PcshMJk+sSQKFd1GUIiCU1u24OTE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJArZRVCop8vGEoKBmitLTuMxF2xWIbCeCJfdia0R38lbEqcdjiPXe/I9oDq?=
 =?us-ascii?Q?Ed1SU7ZjjzBdScLxMBdtttcwoloJ0ENtEZzJxhVzMaGC0gYT4lJFrIGlepgw?=
 =?us-ascii?Q?+DpOXD8QMHN4fyAH4DBJ4fzOtamguHVa8ktxPPOr6sygziwMzkJcJaXchazG?=
 =?us-ascii?Q?EyI7DCg/m7XnETfOIidsR7IkfcgGAu2VE6qrpsHaWgyHLvGjn5G6tcEhU9k5?=
 =?us-ascii?Q?IFM2b9mw/vh+BFsy/ux/SM2WrUdK6ILI/fo9Ck8yl7se3Jra+NvVIytv76hD?=
 =?us-ascii?Q?wWeJhvcCx3v9Yp1ub0dNWEiW+yerAOEFozYU0BR1jW0h0MzdSYKE2UQQPx4M?=
 =?us-ascii?Q?krBoCFYDF1I0U6mRh0lUoJ0tUWZgUJ8MDay1Dn5b+OCSTvamv4XeWxLv2XSS?=
 =?us-ascii?Q?SIpx4Kpq31OJODnNWNLMi4Kg0qb8DpXOftzZh6KJiylva7OEXrVYKXd0ofY7?=
 =?us-ascii?Q?kna8l4iPwj+Ao5yvPuT8i3TGBYfJYOOWuXEb1NA3Aezi62dh97iezAfaWljF?=
 =?us-ascii?Q?3PazR5BCLw+I0/v//KnmIyCnYr5jlBQkayBVnnYFdbbWmeBUFHrWRpN/AckB?=
 =?us-ascii?Q?AZxDesxLG+XgzV+jaAVxck/sWPiL5B8fuHqZHhG3FQnnMlAjLfYcyjFqerd5?=
 =?us-ascii?Q?povnNdibQ3AOlun5dc+vPn99As+Ym/eODE38MePndc7ugXM8hgnhldOjq4+D?=
 =?us-ascii?Q?xNpEX5Webv1mnE5qqA2dwi5V4YtMtC/eEslRpn0gUVVnQTAHA1XnEEy+zxEh?=
 =?us-ascii?Q?vr3Nv6LISlAXj+chzSzifedMCQBzbOKsvlWQO8WGXX1js7FChMRvcLOci1ht?=
 =?us-ascii?Q?DibL6lZxxBJrWqsftDlyFPF3zIrGrTSYK2CD8VgMfjwXIcZ0RFqTcU7y6nE1?=
 =?us-ascii?Q?YdWtOpVzCHE0tW7DN1Yz/g5zqoRXGkBk5XR6kTg+YkGxDqPyN/iJYyoI0SEo?=
 =?us-ascii?Q?u8K69H2y+fsOobvyDGmmtcZemsOmxvXMP7Ut8zOT14LBuflJEd8IoxzW1mSl?=
 =?us-ascii?Q?OuQbW4zdysEpN9EhW5BVr8Bj8SmOGpEnOSPOtH209WcRKUwflRKpd+0dV9/I?=
 =?us-ascii?Q?rUS6gkE4vsyZGMOEVXqBIaSxqDEw6qqSZUa49BUJSSDG+RsmEP6zTYajOjcs?=
 =?us-ascii?Q?yc8l6yrxISJVGwgYuApe8R7uof4/RTeOmbES9ncDWC4i9kaBoItSEzu8z3Rk?=
 =?us-ascii?Q?r3qCh8O4fBv77F1lTghkoJyOTHYqHZ2YL7ffZHY9DQC2pkyiQ0iViwo9RYGh?=
 =?us-ascii?Q?N4+Ap4HohTJ+hSvlg4Mu0uypfgxeoYoKcsBerlGndytAZS94E+6X1rrT7/cF?=
 =?us-ascii?Q?0swobbnR86klM4pUamGb1ihmD7gAPl3lUauzIdXHInbH3cfOQPQtv+lQQW+0?=
 =?us-ascii?Q?KgJKbbHX5rXIkaw0YqO9wVsv0BjPFu0lztS8pD5ol/M+dvcvqtZVuJ/6FhQM?=
 =?us-ascii?Q?Cj45etqtiu43evCkGazjAWGFmYiIprWbTn5zJ7HAbLJ2LkhqFUHL405pXt8s?=
 =?us-ascii?Q?hpJHj/4r9M+aqnezdJ8FZS9qOkaa0dODlkA5t/JyFUZUqlODW7ND+FIVWQEV?=
 =?us-ascii?Q?01msEBII5WZnPCSDkxojuMUwu6cuNnImIAoWyvITYJ4GZ5o4uTGSLnf9Bjfx?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe09cacc-d69f-4a1f-fd24-08ddebac9d26
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 12:14:36.4511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFLDYeq6jnS+4tFCxcCha8e3WwXQi96hvBxkyWWHjle6qT8LrQkF1CxXWTeygLnn6MROpPyXMGtLRGC/OLKLJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9872

On Thu, Sep 04, 2025 at 09:24:57AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Sep 03, 2025 at 03:33:22PM +0300, Laurentiu Palcu wrote:
> > DCIF is the i.MX94 Display Controller Interface which is used to
> > drive a TFT LCD panel or connects to a display interface depending
> > on the chip configuration.
> 
> It looks like you are going to send v5, so:
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.17-rc3/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> Anyway, nothing in the changelog explains dropping tags.
> 
> I am not going to do the work twice. Write proper changelogs.

Sorry about that. :/ I agree it's frustrating to do the same work
twice... I admit I was lazy and only wrote a changelog in the
cover-letter. I will try to add a changelog to each changed patch next
time.

The r-b tag was dropped in v4 because I removed the QoS functionality until
I find a better way to handle it. Hence, the 'nxp,blk-ctl' property in
the binding needed to be dropped as well.

Thanks,
Laurentiu

> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless
> patch changed significantly (e.g. new properties added to the DT
> bindings). Tag is "received", when provided in a message replied to you
> on the mailing list. Tools like b4 can help here. However, there's no
> need to repost patches *only* to add the tags. The upstream maintainer
> will do that for tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > ---
> >  .../bindings/display/imx/nxp,imx94-dcif.yaml  | 82 +++++++++++++++++++
> >  1 file changed, 82 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> > new file mode 100644
> > index 0000000000000..54419c589ef74
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx94-dcif.yaml
> > @@ -0,0 +1,82 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2025 NXP
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/imx/nxp,imx94-dcif.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: i.MX94 Display Control Interface (DCIF)
> > +
> > +maintainers:
> > +  - Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > +
> > +description:
> > +  The Display Control Interface(DCIF) is a system master that fetches graphics
> > +  stored in memory and displays them on a TFT LCD panel or connects to a
> > +  display interface depending on the chip configuration.
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,imx94-dcif
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    items:
> > +      - description: CPU domain 0 (controlled by common registers group).
> > +      - description: CPU domain 1 (controlled by background layer registers group).
> > +      - description: CPU domain 2 (controlled by foreground layer registers group).
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: common
> > +      - const: bg_layer
> > +      - const: fg_layer
> > +
> > +  clocks:
> > +    maxItems: 3
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: axi
> > +      - const: pix
> > +
> > +  power-domains:
> > +    maxItems: 1
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/properties/port
> > +    description: Display Pixel Interface(DPI) output port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    soc {
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +
> > +        display-controller@4b120000 {
> > +            compatible = "nxp,imx94-dcif";
> > +            reg = <0x0 0x4b120000 0x0 0x300000>;
> > +            interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>,
> > +                         <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names = "common", "bg_layer", "fg_layer";
> > +            clocks = <&scmi_clk 69>, <&scmi_clk 70>, <&dispmix_csr 0>;
> > +            clock-names = "apb", "axi", "pix";
> > +            assigned-clocks = <&dispmix_csr 0>;
> > +            assigned-clock-parents = <&ldb_pll_pixel>;
> > +            power-domains = <&scmi_devpd 11>;
> > +
> > +            port {
> > +                dcif_out: endpoint {
> > +                    remote-endpoint = <&ldb_in>;
> > +                };
> > +            };
> > +        };
> > +    };
> > -- 
> > 2.49.0
> > 

