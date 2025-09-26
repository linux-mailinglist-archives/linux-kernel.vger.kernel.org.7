Return-Path: <linux-kernel+bounces-834734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF892BA5633
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9E1A1C07B8B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 23:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD3E2BE7D6;
	Fri, 26 Sep 2025 23:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OX6QPVAX"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013029.outbound.protection.outlook.com [52.101.72.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E85202976;
	Fri, 26 Sep 2025 23:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758929579; cv=fail; b=gzuB4hrKqWU1W2sOoTxBVguwpV9WGyQrsjJT4uO0AMacOEWAzT5XAjy1PoEnbZi2uVyOc7rSmkQnSCCDZUVD3Q2IT+mEQWox9a9r3axLmYvChduOInVPvDjIk1aPEpxVHVKcldHc9VgcAKXCDp2aYfNXV08KpqlSaRpsWO5nWZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758929579; c=relaxed/simple;
	bh=ZjRHNR1H/grt5zrUf2C3iJMOuU8HYXg02QBqQVPLSDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=adAURFMfKqC/+njnxwLM1EG+LYfYoEzzDKt6XknYgsT4QJG8jUgeoAxMWmmreSloqgSbSnF632mvQtwrmuqCTbMxg2aowjDrEBKVGFMPTNhV9XgKKv++tEtjGAMn7obqBqgQ56laxrDI91HoyTPbFWlqWdSFWffftbQmqBwrGZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OX6QPVAX; arc=fail smtp.client-ip=52.101.72.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jxav+Lh6MoKLTvPSWGdKbB6DIPsWu9H86OOXBZ41kAMgWZnmWZtyw6RV/XLCkcmMq3JkwdiebQDRQD2JqgqNWY+2d/t40okHd83cCz6HkHgme3iQLAm+VFWnIZayMaq9QVYHpae54zuyUH29uRQLrxZj990YSh0fD9NjjGchO6H3U6gJWq2gO+SaC29K6FWs/bTNNuDx+y5DSJ7xd9/iUQ7VHZl846+E+9xzgaXdd6FA5PUrI8DD21eMzn971TP2HmUUle5uIt7q66KPLBI6o/7Gqs7FA9eC1396Xg912tYqNMWPEYdykRCHVNU1Skc+nWaulKiq+fwAUFV9x1cZIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wflYc4YQb6A8Z1rTcxgA3eMcIt4OrA2ZGNLwT+I6CnY=;
 b=fO8bgdv43TS5qV1EDIh4EvOeMXj9CMsuDUfrXYthCASZSjgB1wcnVPaMEIoHcEsYQsh5Sj7CyzZiv6Ttv2sEydZ59caclChYb6ZKqrk6zaeOeZB9HetufnyogMxTJeGsTiVaNJCxURvo1DHgbETZgYQ3cXIwKiUTiPyuvKcV/lIBncRQZITdTFrvVFo69pAYSmmfYVYaL5V6KyFNSFGEiGzUJNUU4FjuW3nd3bc2i9yXedEfcMfCnX37UnYxKYBG9abXAH7UC8OAle1JpIzZlT5QjD6yidUTqtA6GuVAbKdFKuHQmWnmo1TNRmSf28k41lMWztzHqGsjDsBxzmlEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wflYc4YQb6A8Z1rTcxgA3eMcIt4OrA2ZGNLwT+I6CnY=;
 b=OX6QPVAXu1kTFVl3quSNE2lW146bsL58invsHQHQhu4LeS81QKTp5vzUEpUFTjRxYMNd/AR9cPVGgQCql9etd3LozdHl6+TE0UjgQvZsHuX9Qj7igj8a3M2tuJWTdpq7r71fbqsRLiKFCXX/fyNtAViAN6Bkdzg0bF/Ewro3QQJyIxjWIB+m0psJWYrhJeRQOn90WjLFXuET8D47AceLTtA2UwjP5KrWM37hKVDITvD71hgGL192bVw2XNolLMLHj+m4fBGfkdFOQDy47n5WtMPNk2YjzKbfzFzKPpBEeWmpHSaDWjABmLdOoilU7+BmUpKY/sPYxKxJ26wDmSjnXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DB9PR04MB9556.eurprd04.prod.outlook.com (2603:10a6:10:304::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 23:32:53 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9160.008; Fri, 26 Sep 2025
 23:32:53 +0000
Date: Fri, 26 Sep 2025 19:32:43 -0400
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"bjorn.andersson@oss.qualcomm.com" <bjorn.andersson@oss.qualcomm.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Ze Huang <huang.ze@linux.dev>
Subject: Re: [PATCH v4 3/4] usb: dwc3: dwc3-generic-plat: Add layerscape dwc3
 support
Message-ID: <aNcim7GUT0/1rDb8@lizhi-Precision-Tower-5810>
References: <20250926-ls_dma_coherence-v4-0-21e9c6bdb5cb@nxp.com>
 <20250926-ls_dma_coherence-v4-3-21e9c6bdb5cb@nxp.com>
 <20250926224256.xxf5lobht4dndixz@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926224256.xxf5lobht4dndixz@synopsys.com>
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DB9PR04MB9556:EE_
X-MS-Office365-Filtering-Correlation-Id: 61c68959-e48c-4957-09cf-08ddfd5503ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/6YN5zxUO1TkyfLALbve42MLEX697c5sfpvxJ5VbfV/711pGXeW2MU4FmJI?=
 =?us-ascii?Q?WFAniXVVkEWdwnAp+chU19fQFsCE1u0m8WEi9UcrZBQfdj4KVfD2BTtRt6XO?=
 =?us-ascii?Q?cItv5dPE3WhHID7pPWj/HnYDsIFFhpenpCHyeA3ofaKL3sH6NImNEk9HYKAx?=
 =?us-ascii?Q?sPFiz76MY6WqdKxz6AOCI9L7iU5yNxcJNOhvgQOZa88PSgDvFq88FwCcp32z?=
 =?us-ascii?Q?E993dKcLmdcRBiMimVEUms7NpFSXjpnEHfrKfbBuVhM5wlrAuJFSWTk5/Q8y?=
 =?us-ascii?Q?HrbEkcXRKpErgGkDgdItsDd7c526u5fUnhLSgRGOqhFINXsqSg0ZDuxJbydf?=
 =?us-ascii?Q?om4bmkTEU+8dFPk1/iOzG4NHe5f4APSkEMuHzx1i9DM1lQG5tauAPNieAIwW?=
 =?us-ascii?Q?Cq4xEHFz3q12zapWgJv6O1qNh7KIrygAle91P1MmcxGYRiBWqMKNaxf6ozLT?=
 =?us-ascii?Q?pcTfPtu1R15/10DDNrOqu3Bt8Y/uMGKn4rFkHVknXesyPrdzin7X6QNOhA6p?=
 =?us-ascii?Q?5LyjX4N1G7M8opq5a8L0I33YiQcX0nFPr0iSGl81CPcUNsgeRBwcPx41IklU?=
 =?us-ascii?Q?FqAUwX8U77d/jaF6xsFkhGnZrgCyCFKbQ1c2/nV1xPsBDW9ilKtI3vc7Ykv+?=
 =?us-ascii?Q?iNjq8xK36BvA9cAg371cKAxnme8uGcIyhYC0TQT9MSzdoj5j27IJStPIxKRZ?=
 =?us-ascii?Q?Gb/Iom9NWP8XXQe+070qmRd/lYsQe66riEZ+GfGBtAL+R8NoR0HXEYXmxEm+?=
 =?us-ascii?Q?sYeOFbxlrBQNw7HYbjsgcSR3SHamu3W8l+HS1+/Yl33agonNWoiXgWv+H9OV?=
 =?us-ascii?Q?s3O+AuXjRfGc8qI1yWCHnGacFTPLvjxuvsg2W/aEOveLfw9knHEdCB5tMyBs?=
 =?us-ascii?Q?BzAECbNzLnM+9vQFGuQflBTZH4b4hWvy3uOwoqXwXuuJruZPXTeDZbCFc8bA?=
 =?us-ascii?Q?Tso57gNi6Ghn9rORela5XwBeMbVVYDr0wiAP9bezb/Q3LdHhWtaNF/1iuSXL?=
 =?us-ascii?Q?HNT7rmT5w0ks7IWTIGVBrvdoghjNk5CainNAq2Q3E1a4TFckk1a/8KxTR719?=
 =?us-ascii?Q?VM1yZfHe0MyDADV9evPMLvxcY7OvqVjaZ3AOYX2Nya5INHnt+66qDOFH921O?=
 =?us-ascii?Q?+8WDGGpbv8fcJswCYEb4LJdp79RL2/xDztRaxhNwBNY+IffQGn+0/Ts9bAcC?=
 =?us-ascii?Q?2PW9oyFnvr3UCJl5nb5b88KLfy3oKRbujgx0eien6kh5mTUf6JBvJX0UM1Dj?=
 =?us-ascii?Q?Ut1Gxbplbv88D/R+N2LNJOcevLH6yybvj7v9m/vm60I5d94+USmQsw7fQufR?=
 =?us-ascii?Q?j7a3D41RPMQBifQpSbkzfoG6ZUcC17P+dCKaF8RG2pxRIZ4g8lIJUDwzG+yk?=
 =?us-ascii?Q?HJumpF6KGuYlVH8XjqyjL4fpwJ8btjmnw39abxC+V+rUufkGqUkKYENPBFMn?=
 =?us-ascii?Q?tKmJhNf1H7l2Qnxo0eJn5NG5cZvXygCh2vSN2dnhU5KX1c7SdRRVsVJoi2yZ?=
 =?us-ascii?Q?mj46sqmwuKpsSgVGnwSJXhH5KHB+mkZHtjp/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n/9FGcEkoC/GoQXTRRsVJIllzShUbBxdm4FFE9LkgtR8uQVsHl23P/rSg6ps?=
 =?us-ascii?Q?fT8rW6Gk5z7CRzMEiFgKMyWPReftFzG7GhRdS5NEInAAb9wt7SuSwd3vwAZ6?=
 =?us-ascii?Q?0Q0KTSRoVTYoAMF9cOL9IYXNZu2G9L5ggHwoiFQIT42h/UBRC0AoQ/ihu3k7?=
 =?us-ascii?Q?g18Vj1iizILmXchU5DZuwlSBQx4xeu03Z7yuHQV95kZD1lg8Fv5r7ANdupDK?=
 =?us-ascii?Q?WDI6/KYqERQ9DfkMj3gWVUQJ4mU0kcK4Vy4GBdZvNYseq+LyDW3jE0OyOSKj?=
 =?us-ascii?Q?YXzUUcCf/3qri0OWB12AurvRF5LviTIIlHLe18bKI/wIcrIihOKumiXpJxFM?=
 =?us-ascii?Q?a26vq+mviA4fdT/rC1FBxRJc5YI4JbyZb+7TJb1n0hAkRdWmx6WBvIAOsWzW?=
 =?us-ascii?Q?gkmo++qt+2LHxSpAIvCtAo0CDVGiUdYGDAJbupPVMGSnT5qkL8CY/O1O+Tpd?=
 =?us-ascii?Q?u10eTsE+XhzeJroEU3Y1vpHsoN0u2DmPgv9alkIih/AJq1oA45gUA8AX44wk?=
 =?us-ascii?Q?LPuMHpdZQBJgNwUjIxfddPBxRTnUT+p6e48XIfDn87+nv1iIAJ3Rmlc9Rona?=
 =?us-ascii?Q?9B43a1d12msGrbARM/vwomg4KvBHeAFh+qeT6x4u5ep2aJe7meaOQ615LeBE?=
 =?us-ascii?Q?sU4eMgMqSxQwpNXtAVSqgSw06rmv8c5G6OPiVhq0PY/YgkSgNBaUTaPhYio/?=
 =?us-ascii?Q?WN+fNPQN0EnmLwVpiPCTmOI8UwzEP8aUDSfqbg6bPgGXW/Xd4vvZFWPmTO80?=
 =?us-ascii?Q?nUyuNuYrRY00Yt9Yl2aA9JjtfzQJVP5Kin+5iNJeNHFUVZSRss1o8LXG5R7x?=
 =?us-ascii?Q?gcOWYgQt4f/oGqxj843tbRitFZl3kHC6h8WdFDyYaC5spx7zHTFlj3pqry5q?=
 =?us-ascii?Q?YKMCuFU7luipt/ffYlv8ftElA9uj8qrMzYcdsQbLGm5mW1+w8TuYgBFDIdaC?=
 =?us-ascii?Q?3Od1an/nlGbTX15pYFU832io6CvPBQnRjMqrV2/ZWrZ0ct9qXt+PdXqXg7Fj?=
 =?us-ascii?Q?Hotk42vAOzK4l8mTFrCsLKnVlzZAgRREGAq1+yeSFueqS+w82RXBUujCRHZ+?=
 =?us-ascii?Q?Oi2/7/4oUPVmZ/fm6KIOp3XuYMGIEUD0WNYENQOR7mDt2onU4yWyxz6FP+Dw?=
 =?us-ascii?Q?jn+yTijFEWCumCVLl6rZqtdU48kCuWy7ylyme6PsYg/kb+bnJS3cjlNutDcp?=
 =?us-ascii?Q?mmwDtWK4dnS8whLSCjghzyJr0YPTBplfqdq+7/8YYvL7mmB4QzrVWMhvSowx?=
 =?us-ascii?Q?Qo7UdWy8QFFf8IaFuXFPmI3Lu8usygJKQr60wd1rwghU9G3wYagryJMc+QDj?=
 =?us-ascii?Q?4BTYfNzuKwINma5j59ubAjsKikflvNfMDmk2VqHbKH4TfoXFFZXtYvWBwkZy?=
 =?us-ascii?Q?Zy/2n+60qVrD2moAYMekiftGGxpb1gjbmOzDnlLrVdVgnX/eb4NGYM0dxYs9?=
 =?us-ascii?Q?FAnVnCeT5I0hqjkR70xxrlehTSeNlZNYxtrIw1XsnmR64TAMSLperNfDQyL7?=
 =?us-ascii?Q?mfrzFqSnPOT2yKB3re8RCVaROxfJAgZB3dRCm4z+b6kovVuj0cSm9n8DbuoA?=
 =?us-ascii?Q?jBIGUZSv2JBO6PtYWeBINe91E+Z5/CP2WQmmoYNu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c68959-e48c-4957-09cf-08ddfd5503ac
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 23:32:53.6528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X49mb6UrltsrK2IXE4qQK0vMqdFpSh6SsqqSxRGjyYsIj0BspT5qPMb2zYliykdRKzZnU7N7EOA/abevNSgMkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9556

On Fri, Sep 26, 2025 at 10:43:03PM +0000, Thinh Nguyen wrote:
> On Fri, Sep 26, 2025, Frank Li via B4 Relay wrote:
> > From: Frank Li <Frank.Li@nxp.com>
> >
> > Add layerscape dwc3 support by using flatten dwc3 core library. Layerscape
> > dwc3 need set gsbuscfg0-reqinfo as 0x2222 when dma-coherence set.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > chagne in v4
> > - rename gsbuscfg0 to gsbuscfg0_reqinfo
> > - use flatten core's properties.
> >
> > change in v3 (skipped)
> > ---
> >  drivers/usb/dwc3/dwc3-generic-plat.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/dwc3/dwc3-generic-plat.c b/drivers/usb/dwc3/dwc3-generic-plat.c
> > index af95a527dcc27a7a14d38dcc887f74a888ed91e6..cfcefeffd7ad6c0a21ccc9aaa4483b9acb9dc4e0 100644
> > --- a/drivers/usb/dwc3/dwc3-generic-plat.c
> > +++ b/drivers/usb/dwc3/dwc3-generic-plat.c
> > @@ -8,6 +8,7 @@
> >   */
> >
> >  #include <linux/clk.h>
> > +#include <linux/of_address.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> >  #include "glue.h"
> > @@ -29,6 +30,7 @@ static void dwc3_generic_reset_control_assert(void *data)
> >
> >  static int dwc3_generic_probe(struct platform_device *pdev)
> >  {
> > +	const struct dwc3_properties *properties;
> >  	struct dwc3_probe_data probe_data = {};
> >  	struct device *dev = &pdev->dev;
> >  	struct dwc3_generic *dwc3g;
> > @@ -75,7 +77,13 @@ static int dwc3_generic_probe(struct platform_device *pdev)
> >  	probe_data.dwc = &dwc3g->dwc;
> >  	probe_data.res = res;
> >  	probe_data.ignore_clocks_and_resets = true;
> > -	probe_data.properties = DWC3_DEFAULT_PROPERTIES;
> > +
> > +	properties = of_device_get_match_data(dev);
> > +	if (of_dma_is_coherent(pdev->dev.of_node) && properties)
>
> Why do we need the check of_dma_is_coherent() here? Is this specific to
> your platform to determine whether set gsbuscfg0_reqinfo only?

I remember someone's review feedback. Anyway, 0x2222 works for both.

Frank

>
> > +		probe_data.properties = *properties;
> > +	else
> > +		probe_data.properties = DWC3_DEFAULT_PROPERTIES;
> > +
> >  	ret = dwc3_core_probe(&probe_data);
> >  	if (ret)
> >  		return dev_err_probe(dev, ret, "failed to register DWC3 Core\n");
> > @@ -146,8 +154,13 @@ static const struct dev_pm_ops dwc3_generic_dev_pm_ops = {
> >  		       dwc3_generic_runtime_idle)
> >  };
> >
> > +static const struct dwc3_properties fsl_ls1028_dwc3 = {
> > +	.gsbuscfg0_reqinfo = 0x2222,
> > +};
> > +
> >  static const struct of_device_id dwc3_generic_of_match[] = {
> >  	{ .compatible = "spacemit,k1-dwc3", },
> > +	{ .compatible = "fsl,ls1028a-dwc3", &fsl_ls1028_dwc3},
> >  	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dwc3_generic_of_match);
> >
> > --
> > 2.34.1
> >
> >
>
> BR,
> Thinh

