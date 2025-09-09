Return-Path: <linux-kernel+bounces-808879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAF6B505BF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E28E1B257D0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBE42FFDDB;
	Tue,  9 Sep 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKpzYZkM"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B459630B530;
	Tue,  9 Sep 2025 18:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444350; cv=fail; b=GjsOmWc22QZr19vMgkw53lTuw2P6lBaiVRxaNyUVBZmy0eGZHP6n8Xub2ZYBpRug2d8P+ra/SfpYWK5OvpqKBbMTyI9zUcT9TGYW0hfEU53sPbLo3sumy89wVatxU5BAbK8ET4Tna2kRdEpIDFerK910SlaTqulvTXZyz+jBUiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444350; c=relaxed/simple;
	bh=zUmKdTZIwR4DbavB35bl6KOYipsXAzP5hUp89Zb3tBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aDqHvC6UkLtnw7ZGa0/kt/jMjCD8bbULS3O5fnqZWoFC+4Vr8yNXYNLrdOJQ0jxeG0GbVkmuhALJlQUWSrfO8slc0PmPqbXX4qsMqjsvPTffo1JoeKZL6KLNlmz9nDduDE6v5Stc3eoiUnc1POv8Y2NEFlaqJwSHSsdoJ1TWPkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mKpzYZkM; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xovNuvNySrgnZCQkWZ5Vfs/mY/xEB7NT7cnrl+FrgFpnKXprAqT6IExTLhRIGBMFWUFeZVZs/clRFLwAVW73wp6A+Y4fyIwjQLrrtngaT/Lzw/6c5zzqqeFxs1+N+8gcFYL1S8FgU4aZ5aMHy3DU1D356iSNZHW8TuOSw0l32JRsYQxPzfKCmT1O3CvhGKTL42/Qd0HFh6ymLsEO98UVrVK+2wlyxC1LFXqkxtJhG0IaBIEcCUKcocbndnUgFDhJp8xeiOvVgM3YwtmR894gDAHr1yvF6JqmyfIWXd4XyZ1sUv6xy1qiTRl1c+YdFJAr1P4VcZKoMcrUueE0TksoVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsMAbOtzeOnk5dPR0kJ3jJHLdu26vDhILpA4LHmVF/w=;
 b=jaM0PAsJ1ukjymlbgqEsgtEQice9RWWYt/V2Nk8LqfIJPvS+/AtpjeBPAIdZxSzkplnDz4dWmCjT9PoCJzOkyxxgYhROf/Qc8rBMwskr7gSa4zmHOs4gjHOkIrREvTS0yZHzUB2q/gyEn0B8+4uEEnOPxQzA4VsWtEXN2TsbQZp/VRACBYgiwex/ZllrlJFycHyW6niWb4us2HbvhV82R8fmJLZhHmSfHpZABJao/pK21zE9jczOSNyJEbVIGeNIZMuO2yvaPY22wG12Pmg5N+w5F8qFaKQTepb/7vVzgrXvs+RIWF0oi55Zex0AIFeFIlZB1UCEZwBLYMoTbgxbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsMAbOtzeOnk5dPR0kJ3jJHLdu26vDhILpA4LHmVF/w=;
 b=mKpzYZkMnRlcuQeY6TmUl2FVgYQR53vaNq4uhrz3rSxvkrw3pZuWqvS7c20SYNawbBKlgDBiYKvXEV4CRTs+V1SSK3sb3WFjZlTYdI7Pc6xBJ6KF31y17yhqc8h1JlVfH/75BsHECtDDD0IrtRUJ66XUzapUCCyMHP/cbTc8oUa7QQIjj6Nl7nCJeTAEPqN3QXkUWGsEHTq42P1ypw3fTNC5vqfGGeE/dx8SPoiTpfvfvHE+UioiDmYZEUezXeDFy5t0npRu1XxL9kEYHq3RFbERNuVKAsypkiP0Aw2/TzvRV59etGLsA9kvH9tRzA+OU8eigAQUY01cn1nVF1Kdnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by GV4PR04MB11732.eurprd04.prod.outlook.com (2603:10a6:150:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.12; Tue, 9 Sep
 2025 18:59:03 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 18:59:02 +0000
Date: Tue, 9 Sep 2025 21:58:58 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Conor Dooley <conor@kernel.org>
Cc: Josua Mayer <josua@solid-run.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250909185858.jun4bevwqiu5zqte@skbuf>
References: <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
 <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
 <20250908153746.7mfobudenttdi4qd@skbuf>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <fcfbea96-7978-49f6-88c6-f78fe52edb7c@solid-run.com>
 <20250909113543.q7zazfy5slrgnhtc@skbuf>
 <20250909-cork-tyke-9b460c1a6f44@spud>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909-cork-tyke-9b460c1a6f44@spud>
X-ClientProxiedBy: BE1P281CA0476.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7e::18) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|GV4PR04MB11732:EE_
X-MS-Office365-Filtering-Correlation-Id: 50510c9c-d567-4bb0-a678-08ddefd2f03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|10070799003|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?y2R+ykLcj9P63hVkiPbTdbhIZdSLfyYVfZLn1cQUpGSgCP0evbKXmtnrdIz3?=
 =?us-ascii?Q?mqaBBDErup3yTQCOknUdCjzmVzctrFuRoGDryh9138y/MxhJBFKcSvHYy4vi?=
 =?us-ascii?Q?DdXHj9AQWD0GdXpZ/Ql8+Pez0oW19L2dFE5gm3xKZ0CYa4a/YaSUEYOK2+aB?=
 =?us-ascii?Q?5WyZ+aoUJqP7XIp8Dlmu4xdcBHoCSEMyOxfdY5TxCtOwGZU5BpGLlbZsmy9t?=
 =?us-ascii?Q?fPTgNfgWioVhJBcZXkLv6Fo+aLPOL2SSng/2run6BTUYn40S0FCEnHY6c8Pl?=
 =?us-ascii?Q?8u+ipXkzW+gb1q+r2+NoRWf4MVVG4zNlu14R3ppVirG9ASioH0X9v/o2rAci?=
 =?us-ascii?Q?3ybk4mGFXhzqOvGHelHSluMRy3+qS+RAwRtRjCzkSnzijzb+o0IEZmIKJMxF?=
 =?us-ascii?Q?3pv4r8TamBM6PYlGhLsogOb1bzPt289Y1OvuZXGQQd6copa7AdrIaYxft84c?=
 =?us-ascii?Q?aqFidw6V7aRj+Ge5cYFDfbg4jmd0Pd/B6u/1nIrBUcQwYc7+eaWfsH+mM06z?=
 =?us-ascii?Q?8rap1b3QwfCTmJY5lzQSfvR5RtTLKhRYJgG1r+XMW4vA/EtB/eO2HSCcEkFW?=
 =?us-ascii?Q?tB4S+WI7qWt6f1KbZN8NUqtFPgYUFbbWk2eQq2GqD6PEarD3Z8HrHXimWXaS?=
 =?us-ascii?Q?3kBkfhgpsoLPfi2MhKdzbxHvNhG9B8uk0ZWsrJdrefaib6hTh5Kk+/uRIU5j?=
 =?us-ascii?Q?hDOcMF/rb31q454qdb0irFheX6sU0aYziqBf8gkjXBKj4slbn/kgxfCZAfpe?=
 =?us-ascii?Q?3sRiGoYvqnitSgmc5CD6FisuqVwBQBxO/uHcaJ2mWO0cyEN5/pNqfKji9+/9?=
 =?us-ascii?Q?ZPtg06a2SeeXZspBQ2jxvUYqyXl2YkyI8T8MijM5R3eczuaFq9A9H0MVam4i?=
 =?us-ascii?Q?XepfYy+a8Xyp5RbPwBaupgCetH9Jhdu1wWCeS/D8KnzxrVlD0XI++oRqDhLw?=
 =?us-ascii?Q?fKZNVF/jxC31V4KGdF1kkzPxehtO7bGJCO9vav8Cq0LjMLUtRGNHpJMI58At?=
 =?us-ascii?Q?T+lC1HhfB64N+b/qecMcHkC1UVwmgTCTBdUEjkJs14UEHaz4wUZt/QLiL9CI?=
 =?us-ascii?Q?rDtQOqX1VApuJAEveGWdwSPgFsvl/r6vRAD8T8Gw+zS5uSQCyM9HahHqOs+M?=
 =?us-ascii?Q?cBXrRpqGXgrRkaerntsGmPbM8IEWPZ+R8vWcyadJPwI6mhjBxd9sEB9PYa/V?=
 =?us-ascii?Q?P72uXauvwy1l2Kvp+GxFTmgjSQbowx6F62eUjKrkv9uIhMpNtsRi4PyG04PY?=
 =?us-ascii?Q?uUSq8Z3UDLivEY8z6axR1Mau8Eo3+PVgL8PLscjzpErKOfKuA64cP11fxtQl?=
 =?us-ascii?Q?mBQB5YJo3Em4bt6w8jAwQUhtGHfhq0RaWoxT+hBZbqbgUUgSJa+YSw3npv25?=
 =?us-ascii?Q?DCezI+8t8CpeJmGmJeGqcG/NuGK8uV++WlCRSD1+3mOTOb4ovGy0nWOhdFEt?=
 =?us-ascii?Q?sguKPzgr8Ls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(10070799003)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8ONaTcZF16LrbVM964ebdEZ73gcl2Z5UQ3OhmtbyE3H3pTlTRcbr798SGdkS?=
 =?us-ascii?Q?Hq8w/he+qxLQ5C9vrJG+cCL3ftdnxGt7ErrVgPsKf3zWJH/U7MsRFtJfHf4H?=
 =?us-ascii?Q?zEm4irhHvl2M1ZxGxoVbQFPg7S8bzBG9tY5GGeUvn22c7uK3vPhXhzZnzroD?=
 =?us-ascii?Q?j3pu2B/4whbgXgcHG4XJLo2rnXoyskZ8V0VGXhbbO5v8tatWmzLTT+Skrtk2?=
 =?us-ascii?Q?Q5A3cwRqEXNAVlQovA71vg58V1MD2A3kPUsHE8M8S2wpADx6HJAh9zlMEVp6?=
 =?us-ascii?Q?5hcPLepNnInnDF0fIgNjfC4aznUDOG3p9aNjrIytZ/4Qnm8T0PAan4W3hzQA?=
 =?us-ascii?Q?dluMAe7BsclxI7NrS22SB22w3FS5371ewnR50ZsKntY8i46xv/U98f71Mxo7?=
 =?us-ascii?Q?gKKhwAy3WkBYUTDdlFVg6GbFYECYMTqC7/Xh0fC7cZIlD7dKmuCQgD7B/nB8?=
 =?us-ascii?Q?Get/BuBrVPT2/CCT9+3xZ9TlRlDK5rn8acNNENTa901ZKE5G/pQEYk9wHwW/?=
 =?us-ascii?Q?ueTnDp8T5Oyan2hAtI+QLX4I7XgKIw+o2cFQfMSbNGJb87Q5eEmRTTyCTz6U?=
 =?us-ascii?Q?7a9YEJJuvwwyDot6Fx0musKJgkYJV1BcHEzc5CHx3wN0ylPH8tkOjj0XLUcA?=
 =?us-ascii?Q?sT2S3+M9g++X0iu4+cjZmYTjwyGuzHKlmt07Kfk780IFBAnUBGb+/x0OQonS?=
 =?us-ascii?Q?RXrsfynT7HcUZTfmHtDfOIFc8SwXNhRgsGGzeLXkVP5VlMqpBGv07O4XIzpp?=
 =?us-ascii?Q?dDmjtDReXanTxygAmaeDVYOb/cMdnMg/uq9tnyiG1UVen+F10ZpptchhfgZO?=
 =?us-ascii?Q?4FlyFMxnf9YPB/oWdXFh88ue212Iwt5TOdD2/oekb2t531tMDXhi1r4AvAtr?=
 =?us-ascii?Q?wFZvIre1It3Mcfl4oUG/IC6noepWIDR+2g/EKTdidkmuowd6R1boaeKpYl3u?=
 =?us-ascii?Q?9em3ILpdNV1WcnwAt1Kgi7LBDi62W/aMfZU+rE2nV67cqV/hqCGrVmWcNzIs?=
 =?us-ascii?Q?0VY/ZbGapmsP+Nms+quF07ad7LOyGpP9rC7QDE+XmKaH2F/f0PZxeohN0oJi?=
 =?us-ascii?Q?b16L+osY0zXCPgSwBZ6/1p+ykuk1Hhaz5LE5v29ETDcZgPiP7x5eWxzbhCSD?=
 =?us-ascii?Q?Kthm6ComGQjNiW6IElIvB5Hh1g3nlzKwsh7YJtmt9qGjC9xl/z0Xw75HvcoU?=
 =?us-ascii?Q?iP7cXq5QTIy6mqB46E29xDoRLN0bDLU9OCyvkGRGR/V7/becECJjdXIVY7Nf?=
 =?us-ascii?Q?3z8EjX6SUmxez2SMz9T+S9C3G/7iVsqrvSYXGRgi1+0GmJy6evOx4djiBIqZ?=
 =?us-ascii?Q?fe7Xa+SfXDFH4l2IFUpcGOzczlFeYzdco04+L/oiu9q3aNgvvdjrEFY+hG6W?=
 =?us-ascii?Q?iHPw4DmCVTCz8gGWiNK040T4HDZbYKvn70RokJNGigTB/XX2OXu5LvQEBZWw?=
 =?us-ascii?Q?rcm0puzGA4o7omEFgPOBldQqF3IZ4/FvfG5kaI2XzsaxLPsg/HUEXraY7Yz1?=
 =?us-ascii?Q?iH+PA6RXaz6EIat6szfR9dyVvzF/dvdR9+HbzKIwMNlMoJFVtp45nvWeolYM?=
 =?us-ascii?Q?5aeWuSunx9TnOrXEym7wMMi+FkVqfBeKTeQPTFh2xi7r8IPNMEScLXQyZzdY?=
 =?us-ascii?Q?Ne2YDrifQHlKj1eFLV8id6qspm5yhLlDAJ6MmPos+vi5fB6tmVMKZnPuSTnE?=
 =?us-ascii?Q?hkvshA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50510c9c-d567-4bb0-a678-08ddefd2f03c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 18:59:02.4618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dgQSZccPbVu+zHHVwHkOGljneCD15TJ82mbT89M87S7FmYTXn0HjGNLmgelHCciHAlCxI+kqjm/TiFP/UiaIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11732

On Tue, Sep 09, 2025 at 07:35:43PM +0100, Conor Dooley wrote:
> On Tue, Sep 09, 2025 at 02:35:43PM +0300, Vladimir Oltean wrote:
> > On Mon, Sep 08, 2025 at 04:04:45PM +0000, Josua Mayer wrote:
> > > Am 08.09.25 um 17:37 schrieb Vladimir Oltean:
> > > > On Mon, Sep 08, 2025 at 02:02:35PM +0000, Josua Mayer wrote:
> > > >>> My updated plan is to describe the schema rules for the compatible as
> > > >>> follows. Is that ok with everyone?
> > > >>>
> > > >>> properties:
> > > >>>   compatible:
> > > >>>     oneOf:
> > > >>>       - const: fsl,lynx-28g
> > > >>>         deprecated: true
> > > >>>       - items:
> > > >>>           - const: fsl,lx2160a-serdes1
> > > >>>           - const: fsl,lynx-28g
> > > >>>       - enum:
> > > missed fsl,lx2160a-serdes1
> > 
> > I didn't miss anything. "fsl,lx2160a-serdes1" is deliberately not in
> > "enum" because there's no point specifying this compatible as
> > standalone, if for backwards compatibility reasons it will always have
> > to be "fsl,lx2160a-serdes1", "fsl,lynx-28g" (it was described as
> > "fsl,lynx-28g" before), which is already covered by "items".
> 
> I think Josua was pointing out their own omission here.

Maybe, but the quoted text was my proposal.

