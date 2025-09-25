Return-Path: <linux-kernel+bounces-831702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3962FB9D5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2EF617CE92
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 04:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1342B9A4;
	Thu, 25 Sep 2025 04:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="T3vtPJdi"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013013.outbound.protection.outlook.com [52.101.83.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31920296E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758772916; cv=fail; b=AukTO39YQuNci7ASf1qZN5+qmuTPLCTohxbeIMfAqf82/2E054Yyjd2uycPv4mU6pHdttwHfafwIEVhS3OUVU8yjghIwvlu9jG8SOwWr0k6p+m0VFylEV8aL3ze8n9va3EyV7kEZLzgyrUrjygSsLDINGMdi90lf4m/wP6XpuAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758772916; c=relaxed/simple;
	bh=VI6zJd7gZvCIynu05xbDM/e1cJGDxfhwHDzPC4fZP0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DVr3nvhr6rALv8EoOOvKklrWPoOFPTTdgTg6xdkayPp85g/FeF9OUkr36jKE+1ZnFpjTTAJbmqYY2oQAV96V9ZldHPoWN1W9h0UZ0LB52vnedXBgpghr8iIxC7l4dXwRs+2rHfn1mhtXk4K51j/M7APxpFvzUDs5Qhhmmegw4Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=T3vtPJdi; arc=fail smtp.client-ip=52.101.83.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzLbxL/SNvXCIgAmA82DPPXgS7SvNl2Xntf0DdZ4HuSN3TpeEK+oJJyWtE7LwC9a/+e/yUaCh6G5kFgi2n1X36zzEtBFFH555MMJKeZmKVfBUQk0nENBYb/38Bf9iFaYsHHnngKQ8bJppz9pRsLsv+oZ6IAQjYN1yr4Dz7AJ/+CYlw+MEXSlxmIhdmwvxnf9+3gISkgv61QRffS0UjjbjjSvls+6AIoEiqj9FkhLvdj6+ScadeLRqDp7JsJzn9eG+16mT7arz0TDK0qGjQByfnpi8OWnAr5OTemKs0oIlzNQLnrJwSFrVRnV4l+VEwaM9e5wc74cR5rbuHFQnlsQYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWKMSMi2C7SwB3cLSFeRDU4G0mtyR/n/EI1UbQStJm0=;
 b=GuUo3gidNyiBdHIgmvPApb9iqnY631rFWAIgounqE/YiYV7YvlNnYoVdOZvFQnSTFUcDF5qMbf1MDsF9+dm+BbsG/qm6MtCBsIJ1P9dhn4UHn2gtpSnh9wSvDtpnv2iwIJTg4ZgwUvJYWAeP72EgBbj9UIZoTowwR424/kYF9o1nZ+JRbyI+Qy4aMgE/iwkrc8ZF33B285ft9QRZtkzIz0RfPflRAymF/dY8lC2R46q8U4zNr0zFRrMqcIhZShpWDGZcgh9mFLCTEpA3Pl802qaeYGe7mJik3wItJf3di0rbNpFw0V0oIaSgCykauNNTAwcIvJe0Fgk9DnpmuuYQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWKMSMi2C7SwB3cLSFeRDU4G0mtyR/n/EI1UbQStJm0=;
 b=T3vtPJdiN7wusZb39LPC7+uXosKbivDVorc9bd5p1aHbtiW19iH1HxN9bUwkr6u4mv3eqLDEp5nWXkEvb8jnt/JM/y9NzBkkRSvc6Dm/7n+KVswVxk8Wt9Z5wN6aJAIAaETU5q4y5kdIucJLZRRDeIsM0msEYRiurdH3oPFbb8Fg9EuM/wIbn8zWc2tfSGXxaHWPxJJfDCeaVzpedSAdgNz/U2YysHfaZFa7aj6FKV7mVNt7NYDlZzeFUCN2Qkf2nUGUJH1U5y/xDi2xJFvZnUgVDaWLwhtmUeOQrzuy+h5mtKkQTh7E+lOoneLYJ0HfbAyEScKpBtdSFCw9uzG2dA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by AM8PR04MB7267.eurprd04.prod.outlook.com (2603:10a6:20b:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 04:01:50 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 04:01:50 +0000
Date: Thu, 25 Sep 2025 00:01:44 -0400
From: Frank Li <Frank.li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: Jorge Marques <jorge.marques@analog.com>,
	kernel test robot <lkp@intel.com>, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: adi: fix number of bytes written to fifo
Message-ID: <aNS+qF9+DkTHrt8r@lizhi-Precision-Tower-5810>
References: <20250924195600.122142-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924195600.122142-1-alexandre.belloni@bootlin.com>
X-ClientProxiedBy: PH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:510:5::12) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|AM8PR04MB7267:EE_
X-MS-Office365-Filtering-Correlation-Id: 45107c2b-69f7-4e33-8375-08ddfbe84125
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgM8qaHVX8QSxdtzttqNmPZjGQSfNtMVwImsoZVi869brENCohohDeEMe/B1?=
 =?us-ascii?Q?Ykqn9IqIRxwFznsBc75aaZx5x7cFXcBTTqIo7Bqd29+riFlPszPn/CWSdtnE?=
 =?us-ascii?Q?9dr4TDzX4G8qbhfzSOZv/XIfr7ij3V43GLVI7jsnqtZ6GjkhpcD78NG934CP?=
 =?us-ascii?Q?8Eu95UEdFwn2MLXwH9nttaBcivQGrbBzBLgeDjQnj6ahoZcS8FTFUsmcNeNW?=
 =?us-ascii?Q?GUriW+c5SQTPDogWVtj7tanNSaE02xPH3Fo3OwLQSDYWugq2/Eu57fKV/dBy?=
 =?us-ascii?Q?aE7ZD2kWgDAEMknEAMErsD2Jx8dM0q7v4lAIcBfgdEQCkY5ROJ/Q6LAuklj3?=
 =?us-ascii?Q?OGym4+FXMGlBymct4fWnnvlexiS1YoOKkpGu6KVEHYvZhXDglLs4MdLx3Hlt?=
 =?us-ascii?Q?N4+SULmFPntvPPIQkGwnvgzEZeRUqtUxQHb/8AqtzOp3QRXXQXkygXnUMZKA?=
 =?us-ascii?Q?/Epn2cBMWjwVzjvloEty1LSKF/H3mwh2t0iYPZQu/lKs5Cg29kJvoUrRiNka?=
 =?us-ascii?Q?E4qtzQnxWH5fI2gWRF1RKqFbxD7PCHKemepDHNd1OLSLwhMXiPfDEnxUt853?=
 =?us-ascii?Q?wgRnWH5fJA5r6eKoT9kNsY2EZcXt+QmwfqonX+g2cl76yrqJP98W+hMWkOnD?=
 =?us-ascii?Q?969QMUg+zLdMLl6rYnC/oi+qBOdJoLrfDqvysv23kyZcLBa32mZ+RSEEyn6O?=
 =?us-ascii?Q?t1n0BrhJVe/PQpZlyTi0XsQsQXVmMnvO6HLNtG3wUQ2V5utQfN0eW5ToUG1H?=
 =?us-ascii?Q?Wa6m6L9QOj/5J+mByPKnGwNdHt/ykdqQsVo5Wf8HumyhkYmWqJk5ZjlUhxYs?=
 =?us-ascii?Q?c6KMaGOINN2GYqSG45Lz9BBr0gtcZSexPokYlz6W9E0ycAeYjPeL36XUgCjS?=
 =?us-ascii?Q?QKBwNa5ca1OE91Z4qYSfkV+OGXb1O2jqRAVkFnfKQ6xLeC+BkWkKxF2ZrMgd?=
 =?us-ascii?Q?H/O9Ek1T4kkTV0mpO6FsU1upi7CLovUl3HGXY2hyzhHTvf2Scw9V3d//Q+Ps?=
 =?us-ascii?Q?OpMXPTjb/uEU4dkuFh1UdBvO76fbQs9mF/fQuUkrO3QGX4Ba1c4DIxetOkgo?=
 =?us-ascii?Q?Fcd6+/7ke1ctIvmAYiX2OxFD633iEUpaTitunN7ThJBO3/nQFqz3W2WLFAs9?=
 =?us-ascii?Q?jfqerctvvhDLWqNXmPknOrVukp+R+BxuUSSOuqrmSpJCGtQ8NvNZaEcRw9+v?=
 =?us-ascii?Q?XXcGWydglzX0vx+fNgh/dSyxxL+tP3uRQYRgwfjqt0kUtWdCZ3Q/OzAuMThD?=
 =?us-ascii?Q?yQA8nF3SGQ4QagWu3O5r159quc3nAoFr9efNhnae+8qdW89Ms8G28p0oxj4A?=
 =?us-ascii?Q?rzv3k1CBRlytkQpFmpfet9DzAIL0h3gVH9Q26FF066W9JN+PQLFoY33hkxef?=
 =?us-ascii?Q?uUyWYKVgm5U38wvtpE5Db1x5yD/xtHvWTlXgUvj6t45P2pDaFlMu0V/Y/iXH?=
 =?us-ascii?Q?tnX4GQAClcPm1w2pTGUEyEdVkjoz3g5XCbY3ddUAInvT81u8UUNh5209tZxN?=
 =?us-ascii?Q?oke4e6oyEDjdxmErBtdmVdlVzLKPF4d4Ikdk/FzMWKQtQTZhPswe9EzBJGDF?=
 =?us-ascii?Q?B+cNoFIuGroxLYCTNKSt1iku+6SAYU6WkcLRYT/nU2qhhKFJAAkPlNuHHlgf?=
 =?us-ascii?Q?hIwIp4coEF4eCiP2PJnCTEiCY6sUQnsc5l39V5dCHRtTFpCraRCDoXsu335T?=
 =?us-ascii?Q?WRQ1C45vG9JFbVkQS1i3CAooL0OdU3Maus+KG2uVLYXjXigS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZHdjOKdAR2rb+3l2YZCIxVopz4pkpSJNFitdzDiu1V2Nuymdr5A5temx3z/?=
 =?us-ascii?Q?pck6F6iFOYM0MJ/QO/ha1riN+GL/Hku8GERpyReIw/OASEbqFl4fZjlfr99J?=
 =?us-ascii?Q?41shGOs4Yxwt5XomJ2z0uuB8ARuMYcQs5fzxdAupkbzWSr8ajVL4bL4hl+uP?=
 =?us-ascii?Q?GSrL3lrD5oeaC2PP+L1wW+LD12Ov3g76OnUcM/SnJeKaDmgyDoVMrOmUGmdQ?=
 =?us-ascii?Q?JhgGsoivcgQ20Z4WR0q23nFEdaUVsACkU4fC7ft+VTRLrxtCYxPkUpY8S5hj?=
 =?us-ascii?Q?xbe4D1dm+5A+vCaudXXYToS8fMvnP0CulGcTi3LRJ+ZkjiZ/c/qjrqVhdkGO?=
 =?us-ascii?Q?RjR+hGHeUhqMwDaOy1RywSkb8GZRe835iSd9GJllsYRXDCVgsDnt6IQzJV30?=
 =?us-ascii?Q?aujXqmiSP8ys1mCpc2rnmvV4hazFMidS3J8auF6XmtL52oK+AlGNuyFqNR2E?=
 =?us-ascii?Q?FbCxZEUf4r9nJEwDPO60SwY+4ZHl+dXCvFkplnT5s/2tgUMe+YY+QWbeIoWS?=
 =?us-ascii?Q?J3O504/ARA6ii7t6Vy2jmXlRrlc3AkZdLMfzcfv0Szf5SEEKrgbSsxomNjR8?=
 =?us-ascii?Q?QvxS3WQ+e0ytSyEO33Z+8A6mkfRn/Oh5cEs111LycV3hbjQOM4AY1MmkWFU0?=
 =?us-ascii?Q?bnWquXBh4JtUZgStrKHMucmdWUmjRSeQLjpyVdcb14yOaFTAgfXD/hgQgzGx?=
 =?us-ascii?Q?01A3JglIHC6WxX/TGjh7VsBqSUxW6usuwHEkgmllflGBvGzC9oGnVY5qmj/P?=
 =?us-ascii?Q?BdDK9H7WVcjlNIeJpIPMpirupWaltJaQaHTNdOfGHyUelk5T8HwZkxJDZouW?=
 =?us-ascii?Q?yjKdtL7kRL7QP/JmjMQ0JB2JPm85zn48xLwBMOdStGmbvCWd1Ntq50Uu9ig2?=
 =?us-ascii?Q?+VOoSNXtAmPxj81c5WWh8Dwxs1CCABHrAR7Q9KU0WhhzzGgFdWp1VjqGi8FW?=
 =?us-ascii?Q?wKMsFMAQTVP1rV+TT7V3Db8sSAxjJqZH+OfBKxIVJJEBCeWogcqrol7z1FQP?=
 =?us-ascii?Q?/j9fXmMcH1Zh+v68nzOg9Ptiami9zJ7m8PcILSzAuSJelkN0V1KyIQ4rN7xK?=
 =?us-ascii?Q?W7EATCGzE0KNxrHmP3BRoyWeVaM9mPpUGx1d/pM8xvKyjfWcmtNwMvLf5khF?=
 =?us-ascii?Q?zUKad0rS/r8dfNe/ogV1hfWPQrkK4ZI4jathqs9e40zGYTZj80uTsemfKMQp?=
 =?us-ascii?Q?OG7ZdNSQ3KzCx7RrpT2qssaSrWSeM8pEeFLAa11opY7XZ8gyx3tUPQ6akW+U?=
 =?us-ascii?Q?fML/9uu2tjm0BkXid2EmbC/hFxsmpS1QSApoGRXYJdCb4QkuT76R+N5ucW5p?=
 =?us-ascii?Q?Cs2nERh3sDet5d1Tnt5YusIdPyYtLbRc2/sl8GMKNGV+vhEVDh+J2yZ2BUGL?=
 =?us-ascii?Q?FgiblxppJrJXp8H338r3RamENkW8orwwf24fudkffAXhSgwP0MH8c3kMtIoR?=
 =?us-ascii?Q?6MmRxo4orhGO1MiOD29LubO/eiqsAIyqSbb+/m7KWp2IP0dZF78LgrUPbD9b?=
 =?us-ascii?Q?vvX/4f4GnYcocBmoRw71fjKTQE01mFqoNrKw2cNmFAQgEBM6rzkKmmYBOJq+?=
 =?us-ascii?Q?LJ9Iy8He/WFz9328E78sbfeRr7IHTKLXxPV8gss9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45107c2b-69f7-4e33-8375-08ddfbe84125
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 04:01:50.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV7aGo7AOCQFnpkij3wTlF7rb5lrGa5Y4RQMU0z/YXUMim1nW1+XQ7dHNaCOIOSu0RjQu+R11VVW9N2ZTU5DtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7267

On Wed, Sep 24, 2025 at 09:56:00PM +0200, alexandre.belloni@bootlin.com wrote:
> From: Alexandre Belloni <alexandre.belloni@bootlin.com>
>
> adi_i3c_master_wr_to_tx_fifo computes the maximum number of bytes that can be
> sent to the fifo but never makes use of it, actually limit the number of bytes
> sent.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509190505.fKGvEJRa-lkp@intel.com/
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/i3c/master/adi-i3c-master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> index 18597ba1f1c3..82ac0b3d057a 100644
> --- a/drivers/i3c/master/adi-i3c-master.c
> +++ b/drivers/i3c/master/adi-i3c-master.c
> @@ -135,7 +135,7 @@ static void adi_i3c_master_wr_to_tx_fifo(struct adi_i3c_master *master,
>
>  	n = readl(master->regs + REG_SDO_FIFO_ROOM);
>  	m = min(n, nbytes);
> -	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, nbytes);
> +	i3c_writel_fifo(master->regs + REG_SDO_FIFO, buf, m);
>  }
>
>  static void adi_i3c_master_rd_from_rx_fifo(struct adi_i3c_master *master,
> --
> 2.51.0
>

