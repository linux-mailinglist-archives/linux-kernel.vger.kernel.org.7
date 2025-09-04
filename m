Return-Path: <linux-kernel+bounces-800285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B353B435CA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486645864E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F3E21D5B3;
	Thu,  4 Sep 2025 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AR0CsU7T"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3147610B;
	Thu,  4 Sep 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756974766; cv=fail; b=UYnq9KFLAz5TNZTtIo7bBLqFpgGethBJxaYkMWm8KLNE8KvxLm9uwQqZW2R4BdwzQUYFnpJ+ZS1tu8Cdlz0nCMpr0nZ/lstLmP3VLidmJovP1zazbzaBZA1dDUyZ1YcIT3U4KW0OHa5bnbyQAN78xJf1QPxOaOxoFeLA6lqtzd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756974766; c=relaxed/simple;
	bh=OoWUfFQYXnZK0FxkwLJ1vDxSxP4p2aS5j9JrZQncWco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+kqXQ5uEi5WSJORTp8FoR2jvw+6CgzMT8QX/cM+2jA+MI81N3Kt1apzxLT4t48mAQV1OZqCwYz5mgqV5lIy6Auql1wZ8l4tw9VrXV9D5MNUNiqgFQbovtKpR7VCfogcVuzFbqfwDrXLAlB1wtCztg72RujLCj4B9gAVQssW4OI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AR0CsU7T; arc=fail smtp.client-ip=52.101.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qywdt+ubPCv5GDASyK98itW9EitdPyLr9ZymtKHHIdG9ZsIeQFTX+4Sb0X8SjmEUGdIXCK/r7mvmAAYj6k+HKoJfbkdeb0V61NkdgsicE8Ksa6GXGiMgREaUye1VgXp6YSeuV2kGMvgyDlejmVGuVtc90P0BQ3NdR+qJzGjASi8YPWvcCer3681FGxEyj/tZySGNEuL9x2SJalFunpbZXMra0kV/CjRMQGbjakMBJStizPhtEnd42Yaymxpmv1QStDo8d7kwStG4wcq7sjJ2hvWi28cECi8S8E86ZQhe2iFACxXlSEqnTaCKGwLR5v5fvizcD7j4wozbeFaVMAONkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIdPUxHPQTf41cfnmwRDsxNAvOzuH3KePVkPLdVNXyc=;
 b=xY9ok8NjGpvHK1emoENDCMqyHRYOofuyYPb4M6VPb1DTeusqdj34C+e2ZQwXYRAeIo9LR3LC+8EPE2PgDGqD9sTRYdZOXCiO4lIH1OxxLp6QGXmItbtbTE9AYE0evzj543xF+LcNz0HyX1A8FrWxUVAgpI1RIrNuV6eJUSou0TZeR69Cx6WsGFBiR4Q98NIv5ZjnDv+/Siw/VfkqHS6cwRLsI36c5FQ4he/s171sNrfuobg+FJkZheJ+eZMFXrq9zYJw601EYN2QQSiTnjypdS9QZu9BIceXxLgHCh2vfyz9UiFCCidx9Ocv+KfD74D1jhCBeSxMEbWxTLamjl3rug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIdPUxHPQTf41cfnmwRDsxNAvOzuH3KePVkPLdVNXyc=;
 b=AR0CsU7TeleN0uqX310zzuCS0jsFqKNzr6nSBpbpRWRvVCJAfKdIvmUnVLG8po5jUHhbE46jzXn5uGqOLq+IlNEUDrrUBADDdaOox6y2Fwi6ccApw3cXM/ZcNgiWNdyq8RqPYf8vnt7TrO3gPC/JRdOGquqiUN3qS2TbrwpiyqVLIR8tVtEJk90xCimw3mBF344Mss+96pqiPfAljcjswLnhv7+T5RqsWLBpG2rGXWpH3YPLMaFfKCqFXxAsQ/wE6rf6Gv2grRRZ0Auw9vU8COX7iYVDhjeOKItak4420Ifb44oYK4ayIZ5+0hPt6b+vwAogmDsVfXIWohyW/tcPFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9507.eurprd04.prod.outlook.com (2603:10a6:20b:4ca::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 08:32:41 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 08:32:41 +0000
Date: Thu, 4 Sep 2025 17:44:04 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hs@nabladev.com
Subject: Re: [PATCH 05/16] ARM: dts: imx6qdl-aristainetos2: rename
 ethernet-phy to ethernet-phy@0
Message-ID: <20250904094404.GB13411@nxa18884-linux.ap.freescale.net>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
 <20250903-imx6_dts_warning-v1-5-1e883d72e790@nxp.com>
 <CAOMZO5AGv2ykKmL631A6O2yas-1ffmFaZdHFGMxrFx93G9t8XA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AGv2ykKmL631A6O2yas-1ffmFaZdHFGMxrFx93G9t8XA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: f979ae49-f22d-4096-e612-08ddeb8d9d30
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QSFhPHQAEYQUzcIMua55IZgV+AkFFAYB0/0gUpG0ERBQZK2yqW6EaLQK7iSe?=
 =?us-ascii?Q?r0eCn6ENqsgYWdiENq+nCle/zV0iX2y4XMj9I0H9/krzHriquzHO7qjxtpaY?=
 =?us-ascii?Q?6/h4a3/4zzvG41ZVnWNakEpDeXqACA6R7K+qsyjB0Z84rtg9U/KWMZ945cgi?=
 =?us-ascii?Q?eutxN+il5WByIT1WpCEJYmn3IhtGTjyEqzAIptMl/YcXxA/s+tJ7mpU2RtuU?=
 =?us-ascii?Q?aW29vO7jni2xD9dhkf21kJYz6T+7taA3KJbUtbCCxwXdGS0IG2RI3ZahCglI?=
 =?us-ascii?Q?QTff0i4HCtREhEGnd9ViaANfMB81jODzXAkbKiNBz2isEUqmfgtFF+fuaD9r?=
 =?us-ascii?Q?fwrnkULh2pP3jZZobeNq1QSAGUJeDaTDtvmgbCdsr09V8aNaHFlDJ7bZfs56?=
 =?us-ascii?Q?b687tSt4aYJ51ltmDL8GcEksNkbOiUNWTGRrrz4XL4eDHMIDWsAtsY8XgCgI?=
 =?us-ascii?Q?ImGBTqnkoVuVS97I9VzSiWPPbtdrlC9zIs5LI8+VaJI7t755nioJcwqtFzak?=
 =?us-ascii?Q?qYQsFaxbiTQCqXZyQYlSBrH8+msldQ87dCbrvDf9LR0st3hI/Jz2kOh9aOXT?=
 =?us-ascii?Q?F9C+0z2KgLLSALer2c+c3f9dqjA4zkxqWPzqYyrIyerPPC31PdVKXmR4CWq0?=
 =?us-ascii?Q?zv0/qUDqGB75AB4BqhAW90UGnS2JHUVOKdI92mO1yO6+5lLEoi4uqJsugU2l?=
 =?us-ascii?Q?xtLy/cgvq5n0QKPWLfBguQGp1SdhTZzdtEC6WpE+Qao+JJJMTH/UhMRmU2En?=
 =?us-ascii?Q?Jqnc0UsSjXXMoBKJAveZUYXf0mAvtD7QFnpBbfGsi0EAXpEL2kBM1XD2/Dah?=
 =?us-ascii?Q?HAqTCV81giC1F9Ht5gEpUFIWVsQkuay6Q/7SfJaTAZ0OwC56dDFAxc9+oxZJ?=
 =?us-ascii?Q?Tdc9rHf0ZgTNShVtBMClB2oVF20ypcvNSZZnQvIc1zq06YsMtbMKS9qOwpTi?=
 =?us-ascii?Q?fijEKUy7Xi47zDs6WfaoLJ0sEVxCwyT8sG6xC/Tii+sVoCncKRz8970tnvbC?=
 =?us-ascii?Q?gOC7XCKm77EpbCvVpuYdNjlPY+GJiKjXAWD3kJsa+evTcYS7xaNZDl5lSG2Q?=
 =?us-ascii?Q?FGlc2H/ZVdkYcmb+fDqGSH4lAVsT6726+8GlNsMBaRsCj1ym6R1f68/lQEgt?=
 =?us-ascii?Q?AKenu7cgyCsyBf6JYSWL+aUR7ID/xfN8c1VuHzqw4WWHe1dlQZaw0k/2ekuU?=
 =?us-ascii?Q?tKUnTrSXuf6MEJSo/iMfBYYb6wqN+xEHJ9rl+0gqbICO1uIQ6l+w1jqE/GJP?=
 =?us-ascii?Q?VlI2YhsLr5pjltl1A13jrolg6vAbO+mRCpyiekr/+hOLuAASQykHG6NMT5ME?=
 =?us-ascii?Q?PFG65enmtNBOQppb1bQM02/h263iM6os8axielJE8dl5/vUkmxMsS2HpkD0m?=
 =?us-ascii?Q?wU598Dqw4KVnYknYj3oVQbT8DVLbO4V8rTO1GzRd/j50nG1MCBRokI032uqR?=
 =?us-ascii?Q?+3g852n0dRGtbYSsK+dY1c4E+Hhc6khJf1pg+A/29SCgR452zjH4aw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8yURDrIKSl6br2GK3+mGsd64N1ivgjVnLsD4cZsNeAmDDM83owIdZb6gk2bD?=
 =?us-ascii?Q?mu46jvRLbN15O6PLPjrM0DRfJNHRLToU7IoL7ubaXdPrlHmQ1L6B567MioPS?=
 =?us-ascii?Q?GkuPAOShpM0Lvhlwvhq/+uXQs9poMzOG6W97e0tKW/FM/0pVL74jEtAhAMv5?=
 =?us-ascii?Q?4AUxKHjNFfi3L4dP9crT5iNO29U1AZUoo4oVaNsrnpYprVftFX2Mjoz/jgaM?=
 =?us-ascii?Q?+NmPRdV/aBKpd7lvsad+vE/rqlyqNYp8GjFkQKLFsw8ApQvMxsZnL01trJ7F?=
 =?us-ascii?Q?EYnkZ+sB+I3ZD6gvd19BNoEZexK5hbvq3IsoYpVjFi6GvIR8zCWv5T/J78P/?=
 =?us-ascii?Q?fjJnStaQZblxM9LNfkVVbdJHFeLaEzYmeXprmRVMpXkeAPcPl9eNfG25GUJO?=
 =?us-ascii?Q?4iq619IkSUkpPNeinXHRhmwlpZ8LcFhHoBdm5WAtyuJWqw2dCuJedT3+qvKQ?=
 =?us-ascii?Q?y6H865Ar78jcoFywoRI0QGLYZJHJ9aCDsdYfPIILplEiF63DEGmAVHRYILp9?=
 =?us-ascii?Q?c/gO8ctwFHR3S9apOqyvY5uJDmOd6RDblxGaapf+lKw4s39SPPGx1Q8Qt03b?=
 =?us-ascii?Q?1XR+mkx0v67DZiwXt9tud/mXQaOASjkY9wocCIpZqMsaCKfYxHGYRI2/Ufq7?=
 =?us-ascii?Q?yDmsgjULO7xHjj2BLJBAp45kTCEMyxsZX8SsWkguTM6DC21MjG09P5o/zLyi?=
 =?us-ascii?Q?hNMNq9cifmD3K45UeuRH4ZK9lLGJTzFOzCDqHgRJxZobjeIH8NKfVfVc4FdK?=
 =?us-ascii?Q?Ulbp5CY0NAWR5Q+g9CHwJ964DaxFKZmfRfsLNP0cM2Ip5YpaKlqG3VnTeGJ5?=
 =?us-ascii?Q?Ptx55OnxXWDpY+b6SAN/bJWtLnnODb915BIXSmBNEbIGjqO5WL9PbIOpBS+t?=
 =?us-ascii?Q?37AK+izEb8VHESppqdGt50J+u/8ZTMyHN/HEvn/REmUokImpCH/jcQk9E4EN?=
 =?us-ascii?Q?vNJFFn7AnYPBJhdDYJTvLi0hAkUjDx9/vO6U1RAGF9PLR+/2GHMp1YhbPLzP?=
 =?us-ascii?Q?R8FOPts2AYTe8VOXsx3qQwHCXyLeaSYRTofrWKn4+pBnFfCydFkemQ0Ov+yJ?=
 =?us-ascii?Q?d5gnSknXPuvvUrj6SMNb2qxcvcNrLOpYJu0wNakF4Klq5/i1z612JTTKO0Wd?=
 =?us-ascii?Q?bq/B74Y0Gof3bn87Py27rLUfqXGv+Z7D6/xSE70YcFrPgL8WpPXQTPO0l4qE?=
 =?us-ascii?Q?oJI7WLelICV1AoKhCPnTfKZ4JDhYKqr/6Eq02LdmV3yH7+YRUIcu1QokTPcQ?=
 =?us-ascii?Q?iI7dF5n3GWujwG2LvW+wHALcHTnt8wq7CGCH5jDf8XZluUz7BhLLlEwU+j9c?=
 =?us-ascii?Q?LElaVy/MjtHGz4GTTnr3GZtxd0t8ZPhk+a1ktROLwE8wYQwY1HSp3xlSQhOP?=
 =?us-ascii?Q?YI3+wp18qkk0JhY8938MXncNUxf2iG3HhcdRPGrSf55SFHOQ7r6/iOP+vlXa?=
 =?us-ascii?Q?H2ditUkXLD5W+anDdV8XDdEJIGezVpYaNQJXguxgTbSqpLHHtZ/IvkpdVclh?=
 =?us-ascii?Q?9GghXtYxMcavzeQA6xCi55Q5J4cjyKhjyAYSM82oF/zM9n5qr05bkheOPSDR?=
 =?us-ascii?Q?EDiRIE+P4hmmtYgzRghEScB8dZjYckmIW4Y/yful?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f979ae49-f22d-4096-e612-08ddeb8d9d30
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 08:32:41.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJfRSV7btc5KD65ttxkrIjrGPSjeXdM7OZQbcJ//cL3sbaRGwjOCd1Us/jUtm0Q5lr3lzM4PRIB5a74x+WThNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9507

On Wed, Sep 03, 2025 at 08:37:39PM -0300, Fabio Estevam wrote:
>> -               ethphy: ethernet-phy {
>> +               ethphy: ethernet-phy@0 {
>>                         compatible = "ethernet-phy-ieee802.3-c22";
>> +                       reg = <0>;
>
>Are you sure the Ethernet PHY is actually at address 0?
>
>The board schematics are often needed to get this information.

See U-Boot include/configs/aristainetos2.h line 28:
#define CFG_FEC_MXC_PHYADDR  0

The addr is 0.

Regards
Peng

