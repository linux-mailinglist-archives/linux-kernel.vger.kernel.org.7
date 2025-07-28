Return-Path: <linux-kernel+bounces-748189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F1B13DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6B417AAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A0526F477;
	Mon, 28 Jul 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PT+wd6H1"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E91263F5F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753714282; cv=fail; b=YjwwhBujmLD8GEmo2qcdpG8utri7EUf8xHUh8bi+zh2fvwyuVMkw8KJ8HoWpYSvOMJJDzVSWawM591/Y0WjBFa81WX/TEdgYEzHfTKw4ZHzCqW8KBikX7NmTZCFc6KUVTa1K+tY7o+0WolHB9SDbF0WrhGmrN9MqetoteKz9XkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753714282; c=relaxed/simple;
	bh=ZG39jHC18x0McedKc3FvEyrUXFDaUL51kXd1KkWvF4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dLQ5Ai6jOeJI/GxTrQ8k5gl7iYX65pdPrkpofDfqXn11AkiF0atwvcK1/chpbcgs4J4qd7pEs9s+j0WdDc3WH8y4D7pDu1l55HtEaQUPXlXemgwKPRdg54RCsU5lyrlgoX0hch5UpS4WWd+rTiPmhxVdUBPsbQcA2UHrAAk1jQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PT+wd6H1; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtRd/v5GRLKQdj+f702IZRY2YVsQjuZ94RzB5H8qjozlerV6jMVHtsD8j3eC4L3UEgUw/Ddw1p3CgwLJ1jfV8BZUzd3qXnA6coupXnUCwafHKriN5Z4/Z9EJINWG2c93G00VxYyMTkyiKMUME2L17eDfabu9zj0H187fCy/kSi2CzkrKt83OVTNugwz3HGHdFPEjham5bau2d4U1p1IUbv3crIjmUjCNT9FQl7LIOAkhUO/xFrCiEpyU0ai0v6VxGO6XEUwgaDQZySBnCkg2orVKtoBEs0kxdai213F7qaFQJgddqXsNrSD60yKJ+eBP2MCEhV0bRw240/+9FUX6hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XcVijGUkh6kv9OLt8zoagESsT1DJrUT+p5Z6/wzYvKA=;
 b=KIWsqma0sZiBrdDNTeaYOfGm9Anstk9YUm6ADUKkXUY9oQ0oj6Ur6q2ibdlwBP08nzMhs91aVkcIB/6MM3hC+dMb6P2rLkljtqNMOWK9szFQEMCTdBo89W8zBe/jC+FcdCInwilIH1PFhFtrhxdQ2mrF6nugqzF0kBoIcC7KIxD4iHhVlVpj6l/isswBuu974Ev6F8uH4Wx23aut4G8cNVcnSWWWh+b0AVug0l+peppzrxyE9oi8aY1Fp7fg3KJBBEIBQwsyvZ2OG88j29KnihZgK7UydUkURQmipr2dhtlnYKuJ5wj2Ap/IBOo5JsnZbUSxGKzYGFxz8QROMihYwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcVijGUkh6kv9OLt8zoagESsT1DJrUT+p5Z6/wzYvKA=;
 b=PT+wd6H1lnijRL/igF1eMKjd7qVqzrhg4EBDwq0YGpMRF9jfqmMWB9WjLBZB3YeAJ3v93w5V2LBYaOPYArk+RPVUo59IzbAHZqIDflPZUDodkh2Mqllc2ty+KO6NKaScwsTPPbwi751s1uMoIEQJLAajC7JcEbYuDpbRlx7yhOkViHXIgatlaIzTOmcnVn/zXUjVbXjbxFxiD0mvdwZK7RrJMaqelW4gbXdu2lrRmJLcvgnJdQPEo0W6jfO0Fcn826Tzqr6fiTBQ63cg4hy+iVVQxjH/pHWtw/6zWbdZzLEh/JFfUsoskSig0zKtDj72Q0DvO/MRPrU5CYUPmfFwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6847.eurprd04.prod.outlook.com (2603:10a6:803:134::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 14:51:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 14:51:17 +0000
Date: Mon, 28 Jul 2025 10:51:10 -0400
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	tomer.maimon@nuvoton.com, kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v2] i3c: master: svc: Fix npcm845 FIFO_EMPTY quirk
Message-ID: <aIeOXkHB37TPXgel@lizhi-Precision-Tower-5810>
References: <20250728080508.1743052-1-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728080508.1743052-1-yschu@nuvoton.com>
X-ClientProxiedBy: PH8PR22CA0008.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cecf93-4727-4753-34c0-08ddcde634e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vbqK5+9oELE7fqWss7x/1r3qS36oDx4eEYOFcJUEygkr+/U0msUbkMiT2BAH?=
 =?us-ascii?Q?uq336Lrn/zCMJfn1r9qQ65pNFsISITPJtWRyb6uudlI24TdeJ+ajppNoR9HK?=
 =?us-ascii?Q?UP40BKzo8TuYr9pwSZ4jR/3YPPdx5Ghj3vGb7vTP9VACvvhge4W5kzHO94P7?=
 =?us-ascii?Q?IvXAct7cpvKN2SbhrAa+xokqlYEdrajZDWXpePTAWyVptfLuYrzV4odhgT7A?=
 =?us-ascii?Q?5DOZdXUkiO6QiCq0wztxfTJHFFa20VauEILa85ZvE44ewB5lxKqIy2qmDY6h?=
 =?us-ascii?Q?1ZwPkTCgatKhPnjYeOhqCyDbkdYMXl55bNrAdGrteoDtPGrKLVc6P66xp3LG?=
 =?us-ascii?Q?796ePE3nZxZF6YD9LhWibt8Eo/3uSrfjP2OtEMs8VkffK7Tom5pTUhhBrf5o?=
 =?us-ascii?Q?vTLjHX4zC3DGc07z119VGaZbhFXxsRZwKA4tOVPgBEmHYwfGQrRBlIZt++e8?=
 =?us-ascii?Q?4Wy+WTmxlx5SwjEM/mm0pC0jeYg64a3l9dMt8lzhsRf/pEPIVm310H1/RYPs?=
 =?us-ascii?Q?RQZq/Lz3n9RvthWGPOQoIaFQDcH7HYihtII/aHSq3ItnGY9xqnNuwiueIW74?=
 =?us-ascii?Q?dwmigsey0UtOx3xEtsaG43jaIUY7kQca8tLhsKn/HGrDw3yrQkOU5q6LRZSW?=
 =?us-ascii?Q?QCsTlb3xBVKPgcD/E+4w3M3xa/DwNCuKCXftgEilgowXGnEUzlEOX0wGBSOG?=
 =?us-ascii?Q?AeBPTTQMYolhYlpNdmfKINjyF7rL300o+CQH9vcLQUL6ZJ40y6aSmbXGe8WP?=
 =?us-ascii?Q?V5DZxuU5gK38glPwc+aOdGKWBkFgzZro2sjo145PvZvQICyl9hMGRU1auyNe?=
 =?us-ascii?Q?r4+Q71kf4C8LyEI8mPOzm5SdOjQsI/xXof+N74SxPHYA1lEvSLL5WwlqG9mN?=
 =?us-ascii?Q?ziwG5IkpPhwmJmIBODjdrOe7wS8/45Fegr8Ie5etxkiRE3npvKtNDLM/zbTf?=
 =?us-ascii?Q?PS9Y6EY3oezEgtWRT0XiqSTvOWhU0sY/yvMLXjZYozcS97YcKAuGqX4HbZjQ?=
 =?us-ascii?Q?XSkMzQwJRc6IjlEkrkCN9PcHGzmLvYMvlI9Oq2o0i/OduqeHlcYzcVPLp6w3?=
 =?us-ascii?Q?k7wWNrw65/6jwT+rZ1EwV4A84mI0OtzsMh4UcRzVot0narH4Sp2wFL0NgIcg?=
 =?us-ascii?Q?ICCTILJxe3b9oTy+M9Op/Z/m6ivRUCctbKS2oekVifVRn0KHGp9ToOm/IskC?=
 =?us-ascii?Q?gzQq8DlKCJmX6NezY9nghvMIs1v7YHaxbpmYVAbdhQJ+4CanfYZAoCbIRkPq?=
 =?us-ascii?Q?s31jdtkdfiEn2spJgT5B0RrVh5mkXJwxT4t4XsydkxE4/OB/5dQhQbqUYqbk?=
 =?us-ascii?Q?TXvc9k2IH4tqKWfKZLadAHXloVZYJKkqrfq61+7VqyK+A28c6LpMnaYdh4iW?=
 =?us-ascii?Q?eB0aCOeedJnFSiq8KPsO+YS3gU7zQTWZ0DbPHu171K/b/fgGpJDxNJTtQ9UM?=
 =?us-ascii?Q?EFu/f0hZMBZTwM+knktajJEk3fHSUC1DrCCpjI/TYQaC77Wpdvi1wtAHMOh7?=
 =?us-ascii?Q?SjUsGsavThfmt6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jO8CqWNicVPp/S4/kODOmWn06boqVFhrJ0G6klagKkMDFQusBbzth4sgjdTR?=
 =?us-ascii?Q?mX1D3RmY+7qnUQPuUy25ra1u4Eh6J6s6ZdhK7S5r347B/cgTN9scfNajNClP?=
 =?us-ascii?Q?c9q9Xh+ArRyiEVZ4UQOLvqUQ9tHFn1HPtAHF1EXtVJUhJJUrAHIGKjWneDmf?=
 =?us-ascii?Q?TOr8xgRrDjrZiyTzrPQDymjkGqhgeIn7qIne29vGlK9jZdeudpRmnsg8xbVR?=
 =?us-ascii?Q?IkF388q0676WY5dUACC2CkG5DjzYDTEYTlbeFZ+ggbFCQOKhg8mgzuxc/AKP?=
 =?us-ascii?Q?8zz+A/UMlq9+gRDTXXixX9KUQoe0SOSLb3LPg+HZ9MVqji+oxQXOddJPZCdK?=
 =?us-ascii?Q?iaS3qLQ5He3saXO0Yeg1vIyS+AUuc8hsiD64G6GA4/ijjnBviSdYoX0ygjYr?=
 =?us-ascii?Q?40gPDMrfVIm1+uWkwSPEHa3S9OBhNzplyNaQkiJO79+N0Iv11LlOqiiylLz6?=
 =?us-ascii?Q?T+Z6yXdH+T0XX3pY868+ABivB1qBNpRwcOmEyLzZM8ZI1IzRXI6aumy2l2zI?=
 =?us-ascii?Q?WgB16s1aCXkYSiXz4YUH0Hoe4/LvZHFB/Ycyp4aMvgUdg1grDsdZnQ7CghFT?=
 =?us-ascii?Q?o3ihhJdY1EHT0q+peCEl7ub+AKcutFn7rT5vszO3M1Lu+VMSiorE3QfC16+2?=
 =?us-ascii?Q?mCz1ql9y42EeWkNZ7mBx+pqFNampcF/WClmwfQEHxZ08fiac2p6PrnhYngEx?=
 =?us-ascii?Q?UhJT35vQB4JP2wo5faDlr2VaGF82SMYPj3QDolRNJ0MCz+4DUplKaLLmdoHi?=
 =?us-ascii?Q?o3GAyBq1WhvcTXsp2RpPqR1zj1PsQxEvNy5PS7L9zedrSkCO98pc2mk11Kk7?=
 =?us-ascii?Q?uTxNZyX5xTdDlTDxqh6V+0lHg4UEq7iMtFhuNdp9UnIqRdF0omi+BDPigNme?=
 =?us-ascii?Q?oiZzVyEW3r7O12zszT2O+sgmg6eBh4tm+MwrgRJtGveTTomZUeu4pJUGEos8?=
 =?us-ascii?Q?WRzq63ERamqWXUTFjI3aAHGS5XhWVHfRZj6CQqv5fitarJlfLqsIIfO0JQ02?=
 =?us-ascii?Q?dkj7/4gj/PgsPL6WVkj9swwiINY+RhrkRFOZBdqjZPNUjGqZjoAhQOz2tQT6?=
 =?us-ascii?Q?i49MICt/yJUw382N7RepkwcS2kSjwyQn3La84X9PLQBxFvzgPaMaknt2imPO?=
 =?us-ascii?Q?7Iss5zTtufzDwZ0VGdyAm0RruBINfrGGPXcM4y86yQuSb67qYNBZqHKxssBR?=
 =?us-ascii?Q?dFkKWgGHB3V3h0lAgzfhMybgVaHTmjnDa7gf4i1Stw5FZLbYaOeyxvKIJlB4?=
 =?us-ascii?Q?LADCeUgAEmlGCjjDa6UJTLbWGnZeprSDWyPx0AVC0FxOon0gRvWlE5SN5AFy?=
 =?us-ascii?Q?ZevQMnwcWiLnIO+mG7ubMYiHBrv1yLz73JpoqNMxSenmY60l7YXOcjoYlUA3?=
 =?us-ascii?Q?ZmRChhri3Slz9jX492nfuFkR6slcULdECLpsvhg0MP1iBeRTs5q2CUNkcITj?=
 =?us-ascii?Q?vUI3u9DmjDGrZSJhZ3mmfGyzMRl2EDL1ujrZ8OijJveQYh2ZnnmmCa3VbJlT?=
 =?us-ascii?Q?185rbvLs/Z3vVWkn6+6OzII6zD8QQjFZj7AzXNpqBSqmGQWUVwj+a+/Evuo1?=
 =?us-ascii?Q?kVP67BnOjE2TraWWkttElkuXSejPDYUhZb8f8g4H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cecf93-4727-4753-34c0-08ddcde634e0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 14:51:17.1577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWWVCo2+vaaqgORp2mEr3sLojru1V3l2JNzf6STu602joI9g0vpD1/n5vfbT0M75yWDSGpgKvkrWwFNVbRJBPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6847

On Mon, Jul 28, 2025 at 04:05:08PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> In a private write transfer, the driver pre-fills the FIFO to work around
> the FIFO_EMPTY quirk. However, if an IBIWON event occurs, the hardware
> emits a NACK and the driver initiates a retry. During the retry, driver
> attempts to pre-fill the FIFO again if there is remaining data, but since
> the FIFO is already full, this leads to data loss.

Need extra space line between two paragraphs

> This patch adds a condition to ensure that data is only written when there
> is available space in the FIFO.

submitting-patches.rst don't suggest use words "This patch"

Check available space in FIFO to prevent overflow.

Frank

>
> Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---
> Changes since v1:
>  remove svc_i3c_master_tx_empty helper, instead check for available FIFO space
>
>  drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index 7e1a7cb94b43..ece563353895 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -104,6 +104,7 @@
>  #define   SVC_I3C_MDATACTRL_TXTRIG_FIFO_NOT_FULL GENMASK(5, 4)
>  #define   SVC_I3C_MDATACTRL_RXTRIG_FIFO_NOT_EMPTY 0
>  #define   SVC_I3C_MDATACTRL_RXCOUNT(x) FIELD_GET(GENMASK(28, 24), (x))
> +#define   SVC_I3C_MDATACTRL_TXCOUNT(x) FIELD_GET(GENMASK(20, 16), (x))
>  #define   SVC_I3C_MDATACTRL_TXFULL BIT(30)
>  #define   SVC_I3C_MDATACTRL_RXEMPTY BIT(31)
>
> @@ -1304,14 +1305,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		 * FIFO start filling as soon as possible after EmitStartAddr.
>  		 */
>  		if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> -			u32 end = xfer_len > SVC_I3C_FIFO_SIZE ? 0 : SVC_I3C_MWDATAB_END;
> -			u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> -
> -			writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
> -			/* Mark END bit if this is the last byte */
> -			writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
> -			xfer_len -= len;
> -			out += len;
> +			u32 space, end, len;
> +
> +			reg = readl(master->regs + SVC_I3C_MDATACTRL);
> +			space = SVC_I3C_FIFO_SIZE - SVC_I3C_MDATACTRL_TXCOUNT(reg);
> +			if (space) {
> +				end = xfer_len > space ? 0 : SVC_I3C_MWDATAB_END;
> +				len = min_t(u32, xfer_len, space);
> +				writesb(master->regs + SVC_I3C_MWDATAB1, out, len - 1);
> +				/* Mark END bit if this is the last byte */
> +				writel(out[len - 1] | end, master->regs + SVC_I3C_MWDATAB);
> +				xfer_len -= len;
> +				out += len;
> +			}
>  		}
>
>  		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> --
> 2.34.1
>
>
> --
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-i3c

