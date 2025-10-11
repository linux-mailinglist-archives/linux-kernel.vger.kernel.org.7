Return-Path: <linux-kernel+bounces-849149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB005BCF4BF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 13:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0951840124A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 11:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354D26AA93;
	Sat, 11 Oct 2025 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="pDX01h7p"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FCB24501B;
	Sat, 11 Oct 2025 11:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760183698; cv=fail; b=IgmS1vkP/MmafBeZ36EVToFWJD69jkVo4SwzbO3oKVq8Z505wN3oTfwQgZBviSbFpSrGGhKzjvboBlLa4wftdp3nksBr1tH2O4l37OLOjXWUzoia7cTNWFyTYH9B+/McHDBcdRkdKmJGkOGzsnqG138HJUNpM5FVy1zV9QoA6EY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760183698; c=relaxed/simple;
	bh=yj3+lRDIGDK3fXSRtMO0YZf/RDhIBUgGEwoVNgpwD4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nLPe+LPhDMN72sN4X0a+5rENJ7TxDmcuWCGMBK6VRjhIS8wZkoXGPapASin606kH2FRz1qhhEOg4ivQkJ/whPe9q+Brq1UWDYlSNjcE7A3AMn/E5UHp+rDFC7EqAdpilqRLJfoiaZf56C+Ke/oXKvvLCl8jAB6SJ5Lh5FKx5htA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=pDX01h7p; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRjuRJ8ZDSF5RINWP5mZ33LQu/akRPMLtmTVrgyFqRrbvkXutFpc3+Gva8Mo/q3Vn1z4hSy9rWoxnCZlXMWoN0fFU/Lk++Bjp27wYJlDbF1teG1nBZxL+4cx1cT7mEBN0ZbfTdzfl3fES9lIf+RAiIE1pM4pia6Dt25yJ1KoRfC5iQkeCqEwPtez1eQORONPnoHFbCYh54aoMkjIpTSl4eOD5v5LOk46i9Kos1+iYmJGw+C6eVWd1AIB/OiJjMjKQ3uPeDrVGff0lhP/Hd5ehzuYrPEei9gl571x/Yd+Vb3Q8NvuWSrCJb0IMXA7UFWSpBEWBdkFTHCP+IVKAywXEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ecrWI+HHC1OPIJ3+qMGBpCyH0hBemLG9tVHkChDHqM=;
 b=qNyNKrHHIVXy6lEZ2NudbgaKyd1tUKMeHXTDgtlACb+I/uZ1r9/ljZTsMY+Rr6UcxPCCP7Rvgx7AzjmenGTaPWCt84/15Tbqo+cCmXOCh86bd5432fSY8Uw9C2IRaHPrsqu5lFeFFENeFJlxP+5FtR72l60DpZuVXsgJHgmJd4JQvLi3/Fey0Qdq+oW1PwBZcfJcR8Jk7piUlbGz7uQtr3uTklNGO7tGZAoQJEiKjl7C9xxxEfFoPWQYuztNA+uRaQWtevJDJOhNifbzSPB0XwwJdV476syZlHgbrJlFJddsu8LVivNJvCAsuUbGzzDQHNIlw7vuOHXWlY3TzAiU3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ecrWI+HHC1OPIJ3+qMGBpCyH0hBemLG9tVHkChDHqM=;
 b=pDX01h7piPFDOsoiPuEBl4TOg3I/Nw/VdGLjzRbKXV4uQIjtAsZNV0bIV/vzHxO0ZsMqp1rkV31TT8NdH7rn7IghgejQCAhiuzANvC354oAtApo7V8HOXeNmJ5avt2wT9vjErKiswiZbJ5lzIjAVQHUD4Wr9lc37R8vypE4cWZ/igx3GpDYPG+saTQW3Xa4khijTnP+cCTsHPX3mh4iHsbzywOclvCLY8rBeCj6vaQcOVtwWdDL65ZbwMQ+UjQIA6f8e+RUT54rr5L7g0itGEcmPACpqzTu7vsnOw46iXdxFRG52aunOztgnUCEY2c2bldCv/nQiIUZmH5csoKXFPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11364.eurprd04.prod.outlook.com (2603:10a6:10:5d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Sat, 11 Oct
 2025 11:54:47 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9203.009; Sat, 11 Oct 2025
 11:54:47 +0000
Date: Sat, 11 Oct 2025 21:06:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yannic Moog <y.moog@phytec.de>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH v3 1/4] arm64: dts: im8mp-phy{board,core}: update license
 and copyright
Message-ID: <20251011130650.GB20642@nxa18884-linux.ap.freescale.net>
References: <20251001-imx8mp-pollux-display-overlays-v3-0-87f843f6bed6@phytec.de>
 <20251001-imx8mp-pollux-display-overlays-v3-1-87f843f6bed6@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-imx8mp-pollux-display-overlays-v3-1-87f843f6bed6@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11364:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cde564-5734-4775-6744-08de08bcf446
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|376014|7416014|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YwoDA6slV46YxoyeWsyFnyDmcEDcLyQ3JmtfMd8n5gHIShuOdueiBOicA9rM?=
 =?us-ascii?Q?/vJKUJ8LE6Mz2fGvv9FsDe1bdZZeM/brK4euFx01KIoZoHdCBetNp/JGiAxo?=
 =?us-ascii?Q?fjgtNY5KEeUR3kgBv3zCIoA2wk/jaLhB3S7l2lC38z86wcUPvaPA3OhwesTX?=
 =?us-ascii?Q?CYO8Xkls21Yi8glZkfphY0JI+3nskBfEtIVI06vJhU2wSDIdY2FfPlbAkgvS?=
 =?us-ascii?Q?ULgVBJdu6zP+9to1MOty4cQ+vXiONjeSsetf3tr02W8ZqV+sddv0TALp9EAS?=
 =?us-ascii?Q?2d91LKZsp7Ud9EhrXMlX1zaCt/DEuFyAOBNwVkH+3b48eQOEUMWgYFsrH//C?=
 =?us-ascii?Q?J18iWvbwIwAcszIs0aBFNATt1F+yBcZ1epzyrFUNDhQOVxsnccEIgbmYdlLk?=
 =?us-ascii?Q?Pz0To0eaROflQaeUX3/rH0U5OqBu+/eqngo9co0hYtlb6gugCuYuYEFsHNOO?=
 =?us-ascii?Q?fVsbwzZyLN/MErBRxjMOwP5d3i1lEgGm1hjEmJvYXDM3KAIPPGmmn4mO2MNF?=
 =?us-ascii?Q?C2Z531J4OQU0oSq0OC+HFdzk3mlRbZ2lIuq1f4xYTYH1w7Qompdc9gBKk1D1?=
 =?us-ascii?Q?twdao3699YXyFky2sHRCoPeToXKKC04pWwZbC+PbOl+5V2ayx4uJSsBc/QsE?=
 =?us-ascii?Q?0l4FOTw/iy0QtIpItDCEG0mr1ivjznyv20QO9+OdEgUkKtwxqDJWa4xl9jdE?=
 =?us-ascii?Q?+4A2gCSXCOAosiQKMKRcXxm8TQnJTtHqUPwsIYAoyzN+Ctz64e6cBjGrUGNb?=
 =?us-ascii?Q?Wv+Xz2ANbcoBcqgDSxSr8isdIU6IDCJ3OHCjNfHaooqvJHPlbINW0G9+Rwrr?=
 =?us-ascii?Q?+ICh+hMNjE0mCsLgL0XKoMlIrhUptMK8og9fqH0qqhQNidq9ilNA9oljzo+W?=
 =?us-ascii?Q?Nfpvr1tz5pz7C0FAFzYAqbKcrI9RMcqAj5rZKKRhJZVO78Q+Lh5CGf0LHB7s?=
 =?us-ascii?Q?Ka7JCmVn4gpqiOimeoEgGyV0eDlPTwH8Hyoe48SLb1WuQhGKTqFgK3UbUTN9?=
 =?us-ascii?Q?NaVsqbVmd29N+mwDaKX9lPuKQCVsHvHZqHoLeWxqxX/4qk8M8iFdFt5pQWL+?=
 =?us-ascii?Q?69OYe6HlO7cnCN0kfAJDkhuj4lLauQk5k0wIux8KteyEezC1XsO8rTtB1oEl?=
 =?us-ascii?Q?DCm5xA6WpVEB+OZ0wcZUPxV5NpVP+QZDNmJzp4eJguJyLycIL5iOrdlOY6IC?=
 =?us-ascii?Q?7CZQypSyJJjwm72d3GgZVOsKluTjmAUFsYKOxMCcu371DKk7PC4COU06aE+v?=
 =?us-ascii?Q?9hNtrf6AFPAZ8vIRCjdpSCRjnJjqjxRlJztR9RBh9gPYvNXH2zZJJL3I52V9?=
 =?us-ascii?Q?bEQwnrirbZfh26hMh2717Q5flUxqr6wyum4tuR/5acOWks/O3/IOaeEK8GEm?=
 =?us-ascii?Q?W6j14eqDk22jzqcoevcHYYSQ8FlysD+6TTdR7Qq/mIOxVucUqPmxrFmtPiFk?=
 =?us-ascii?Q?ydPGaiWCCoR/Nyc2t2BKzkXejpOfL4BCWPu85h8S4C4N8+6+lDNxPuojAYU8?=
 =?us-ascii?Q?+GFbohQC7vRi4Euk5a5j4bcyQyRXbkD8MUaf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(7416014)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PGZY6aT1sFOMB6XzrrscblmQU5deo83KynfVtesypyt4bw6XD2BkfLMstmf2?=
 =?us-ascii?Q?/Dbu0dNKt4P7Cm1GiPT7nFL6uCOBGuSjq9/p4GSHlZXhGkODQ7omzOQfCzbJ?=
 =?us-ascii?Q?WgPulBnzqpF+YEt4VlitHhJ3XvSwXKn+ZU9u8qVagE4pVbVcnUghZRNjTM1q?=
 =?us-ascii?Q?RPAUA7fAoVHmN6xqLccCBaMCcBSsA8Tf1Udvu0DvsNkROz9/7ZP/DQmLx6am?=
 =?us-ascii?Q?KS6K998CwuzfsDnNB7B7oQBYJQG1GSWV2IwagR5j2HlFsoQvEQYRvwm+SYAO?=
 =?us-ascii?Q?jZMKeDVphyh+fQHqOR1oulNJX+p/ZagEc4b/tyqH+5c/OGgbgxbtkFTvzsFN?=
 =?us-ascii?Q?+Kh4JD8qngrpSkcynhb9cRKrMa/P1K5LA7bsCb2A5SD+2z5JI64OUeY7qFpK?=
 =?us-ascii?Q?Q/p+p4mrajHdsJ1A4iV/gWfzCMrMsi2NtwmFcUuOqyFOxUAt5eNLM+BKEQeo?=
 =?us-ascii?Q?4EBIFesAFivze1E/srRgMNhdRs5XpATStob2kYsgtGOzVbQ7OVVj66RRD+Ju?=
 =?us-ascii?Q?X0ScJ9eahF5ynmBdGUBO0S0cz0RrY9GSblNUB1pGYDAa8n/w3WbBacTyaYN3?=
 =?us-ascii?Q?UA0KymZuRy40m2DpvvstWYsW4cjQLhYwZsIQcq7GHhjnjAblqCOS6zaUbfuW?=
 =?us-ascii?Q?DM96/Jb9m1xcFe2AbaWlFZezZLMtW7I9foicGVsdcaPgG6UYX9/xRSg+wL0L?=
 =?us-ascii?Q?+aMcmnK+qd2oCM7X+AmUJcii4kMa3axKNQHPDCogqVYcENvQkmIqSlcFaZ+i?=
 =?us-ascii?Q?s6VvtuFbpc6g8lpL86oanMseqQQFco4OyRBBqbe2HJguVM19lhr1n15h/uzU?=
 =?us-ascii?Q?ls/4KWBytdUcbh15NVLDognP10s9hpLh0D/I0LbJySIJtLiLhBiBfdWCyXqS?=
 =?us-ascii?Q?agVTzy22gRJvjIesrTkQAWKPp+5pxl7SQvMbHbaJebQjd9b2IoDYVmjNWk7E?=
 =?us-ascii?Q?xVfLTl+OEHMv4xGDeh9HWW5kR3b7IXFOx7yzOXJgV/zyN/2tp2vgCd1iXMNV?=
 =?us-ascii?Q?Ab6DIpv3GbsAQz6TTXLv9NN2FtrCiEAuJZ26KoV7h6CAuDEHjlNS1UfdjCMI?=
 =?us-ascii?Q?O1jyAZ9cEE6fiDt6zsVLKFieqX+XmPjBHyzZkEQfoYww9Lh0vJ9L5IDUPEnA?=
 =?us-ascii?Q?CM2peqSW2VpJ4clHoHdluAknGkUtkzminNR8IsWI/41y9Uqj+FgNWzvGELXh?=
 =?us-ascii?Q?+OZEG0cMqyuHcgM6yHm3VYhWMuNAeC2wWxmZYojBQCwqrRplhQhbWnev8Hq6?=
 =?us-ascii?Q?5ormkeSqGbvNnGpcaR4bVTwnk91V4FsCBB739nq9dTOeHA7E5KVRTgTmqMG7?=
 =?us-ascii?Q?Xr61bedwp34OZffEK0dxMyKuDsDpR+1ZPgpWTHZd/Mb2JSNh8UvvTElZmEcI?=
 =?us-ascii?Q?o09Gfn9fYiJXI3Em3lix8eEKccU3KoLlsumIz9GPDN/1HLA8AwwD8nW6UQdw?=
 =?us-ascii?Q?t14OEWfrOwregeNcW7Yt7voxZOkMjgEvgmfXkadKsEBIpxIsKIDAuh2FlM+H?=
 =?us-ascii?Q?LTsoBP6MVSUun7L4LdbNg2wQ2Na9aDvu42Gcxrd4rD2cKZ+PISz2p5WTbJhn?=
 =?us-ascii?Q?Rp1eHOh2uHeX6ejni1IYvfWHjA+hZ90MbzIXRDI3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cde564-5734-4775-6744-08de08bcf446
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 11:54:46.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XvWoClfHWpTRwWKdZyGAJtkOu8gQIbpz+ktHBBLtPdetTbTiKbV8nLy6Mq/LNQvckr1D5KHKTmMcY7EWfH0Y1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11364

On Wed, Oct 01, 2025 at 02:33:51PM +0200, Yannic Moog wrote:
>Update Copyright year and change license from GPL-2.0 to
>GPL-2.0-or-later OR MIT. Use syntax as defined in the SPDX standard.
>
>Signed-off-by: Yannic Moog <y.moog@phytec.de>
>---
> arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 4 ++--
> arch/arm64/boot/dts/freescale/imx8mp-phycore-som.dtsi        | 4 ++--
> 2 files changed, 4 insertions(+), 4 deletions(-)
>
>diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>index 436152308642270c320e3ae3b21b9e46b923c043..6110c6a484d3f0b427ad372e1bd16063d1ce165f 100644
>--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
>@@ -1,6 +1,6 @@
>-// SPDX-License-Identifier: GPL-2.0
>+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT

> /*
>- * Copyright (C) 2020 PHYTEC Messtechnik GmbH
>+ * Copyright (C) 2025 PHYTEC Messtechnik GmbH

Is this expected? In normal case, this might be "2020, 2025".

BTW: You may also need to collect A-b from contributors that is not in phytec.

Regards
Peng

