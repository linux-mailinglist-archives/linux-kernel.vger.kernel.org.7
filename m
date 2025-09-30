Return-Path: <linux-kernel+bounces-837768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A94BAD24D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 566094A13FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE32FB625;
	Tue, 30 Sep 2025 14:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dg2wD+Qh"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011052.outbound.protection.outlook.com [52.101.65.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411F11F5434;
	Tue, 30 Sep 2025 14:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241264; cv=fail; b=EohIqdf3rlqcqZYhT3OFsgwUCv5bvNaeYLaQSk4THORb6pmvni8D441dMxgQw6bvZsgbk+srCk1bhaFoFq8ainmoNf+Apcv4JkRW/PaLjKizC8vXbHrf4sjyGtroLjKT0jPEs2w4VZGieaMRlKSRjLHML3a6F/0UxaLKOwoR8m8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241264; c=relaxed/simple;
	bh=pvX9nWqVJVeG2tkMe0xax2XA9KCjNW+VTmj86v3GOeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BquNWgA0Zs0RvADKtyaTvQH2TfyFbeNuvSbqG4FfBna8kSiX1a0LEqwwvLOgm+y1CtjrlE/cd1uoKX5t6A8YlPGncLfNWwdd6bJP9Iv0tGvMJfu9mw+UF42esztKTYpKRYj1X5ohagVwMwvmDvusTn1WkDdEpKECDo9tnrU8+R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dg2wD+Qh; arc=fail smtp.client-ip=52.101.65.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ8aC5jeXFI6r+S07GpFPp0gysFZ0jJONmntIgaeesxX9GYAoQegQVdA+8BjCqtlFMjjp4V6UYtdlaV6NbwSUseQmZAnTFjv94l82hEQSVwjvc+Mu6dFSsVT0qiiovuLtpx7DQSRVqQLG2pNDr6o/3Gj0+2bXVgvo76gr+GERtLhtnN22gbTlZsSqczO+C3uyZanSEMhEGp3q4jZnZXayta6/a4WbalzRwk+TikA3Qc39xo9JcU+V+aMYdJ176wYI+oYvJI7eYyyrTx3sVRDe2AI+PsyX9MNmVK0y+jFPlZgB3xgb3M9VnZXJ44WXL7PBPfRs/05EdQjK2XevfoUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2RsAQRiUMDaHJ/A9DUuz7zhFiPq2NftzdtOaXSdkC4=;
 b=xF6uHsoisAsHEDmnN0fWhn2mRY5zX1g5M2SmaG/w2yl+kBVCHVviWQlSqPOMJBUCx9uWFYCScCPAm5Cyv5WQn0tk3fdAsafAy8k4Ptj+kl0adZMkHGuj5U8kPJp4LgWU3zKSDPTp0eK0w1Wkk7UL6ubObKQCV5AhB2VGlXnsf0K/2KmH6JfxgzMKU752Wa6A3ElvT20X9M2tPajWU9t8GrQRAE27wSKy1SnLMF6qxnlw/5WCnB+bjtjQgHwoKB7Ld35EFTbcAqjM/bTNIrNksXQP/9fOto1BkxJfS3khMTDUJ5sr6t3LnnoP1dr6RqV+lHoJOt3BPhHpOTXPVpFtzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2RsAQRiUMDaHJ/A9DUuz7zhFiPq2NftzdtOaXSdkC4=;
 b=dg2wD+QhKfFRP7oIlmMFql/Uet/aEhF1Ld23NPttPEDnY7zo7NKDxP2zG/RqBfogYCeKfG7s3ZxYKs+Kr+qRyY62j1KkW0yrvGAyD503pjlJl6iyUF+qA1624wu8setIdugReRLlDOvbevyv1XbbmGNjM07K+VmiobPyfIsuSKVC2BpJnD4zmhvHIFjK+tgaSqfDIFMqCWo6CrMNExCUehCFoW7RVWthXjxkD7yOiICcGmrCY1+LoczAeuixoev5Z1BjihuVCu0TVRNX/mUV97ojSuv10jJAlbKwtmk8RYGkGD2GHrsyznfWuBbPaYyz7Owt+eIpv3sATcL7ReUjZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 14:07:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 14:07:38 +0000
Date: Tue, 30 Sep 2025 17:07:35 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Rob Herring <robh@kernel.org>, Josua Mayer <josua@solid-run.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 phy 12/17] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Message-ID: <20250930140735.mvo3jii7wgmzh2bs@skbuf>
References: <20250926180505.760089-1-vladimir.oltean@nxp.com>
 <20250926180505.760089-13-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926180505.760089-13-vladimir.oltean@nxp.com>
X-ClientProxiedBy: VI1PR09CA0169.eurprd09.prod.outlook.com
 (2603:10a6:800:120::23) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: eca95225-8bc8-4b11-480e-08de002ab652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|19092799006|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GfIAYD7R/sm09+RBAmshwagCI/a7nEdr3qFyUhVH8YD9gTg/tA7Nq5EpQN60?=
 =?us-ascii?Q?AjeN7U8U/DMXS5EU+p65FCRZda6oY8KKi1OkBhcnTvAfhfzeyl0uy0P+D0yC?=
 =?us-ascii?Q?2W2H2ru+Xt361U5GRbEtXCnnAHqJ0SE8QfNwhHN5HkgwbBplgYYb5no0vwDa?=
 =?us-ascii?Q?pqr3w561rd1nk8GOtW4xD5S+xbq+4Qs/9gOQTClrUXTGS3NLIA8cjkDPI5j8?=
 =?us-ascii?Q?BdBTmAhCibTN2BBPQxoG4s8h/uMBNABu8HZrdDs3KVt/VM36E2T+2sjtlHcP?=
 =?us-ascii?Q?o+dW1antBA6QwllCfeZ7AoYkrPYB9BV2wD/xMMMmidjv1AEoGSFld1l1JnQU?=
 =?us-ascii?Q?SY0zanTLFF+Ly+PUSFxlgB2Q94kYHxNXmswSde5FUDQK630eY0ibMxVR+EHn?=
 =?us-ascii?Q?OIptBjVadDnh+cbkmazwq9PW7pMmgKorrLZ8rBOz6WfevbSXp+N3x7xqIW7h?=
 =?us-ascii?Q?PlXCXVakv+Xk6uv8e/3yiVvDR9jaX+Vh8BEzworUBN6ZgXy/t8zPvqK+ljUm?=
 =?us-ascii?Q?jq0Ia8BeJCu1x7KIIPs12Av9He+oIyNejoOQUV6mYBxiRMvY3Bo6psmSxeDF?=
 =?us-ascii?Q?P/j0hox7c0jM8lMNJaGuQrzkfYpKwufJMYJdnKbjnL1C7vLgWKqr36GiG7FG?=
 =?us-ascii?Q?AHsFfcCTq2XufUeMzpur+epTSj2NeCWuFZr3qNtomfs92BGU1lvwegT4tBKx?=
 =?us-ascii?Q?q7sCUPxwrbu4B2nOHYsqZMbJin0PBhAM1w5PrH+rxl/evgt0poOpUpX4cUtd?=
 =?us-ascii?Q?W8l8Ijf/27fG52uOU8ilXSW/vd1XNoTc05Mye9xydhdnz0fYyJ5AXQ41Rcgm?=
 =?us-ascii?Q?/Z8+Jv35+unZ5ADlyGi5CC/iv91xA0IcLIFQ0wASpoXwa/i4fIrIHgcVPD82?=
 =?us-ascii?Q?7JTL+WfKLKdAjazAAMOKRvkfLe5VZC0ub/UV/siXS2WWvrCjJ1j+XJuz3//Z?=
 =?us-ascii?Q?lAQZ1aWfaWxrr7WvBCKiXczvHyeai9QPzpvY9onWIHxRjBIX7jZ+DtOAFrcm?=
 =?us-ascii?Q?0XdRPrhOzMo+zV8D3d5PDos/Wubs18eYTHpNj3G2FxEgQPyYtTtpA02SFHOQ?=
 =?us-ascii?Q?OU1JDdDig7I2NfullKetyvmSorROD3JHQSUon+E+ueAP9mDppsp1IIwWr2qj?=
 =?us-ascii?Q?SG2yZTi4mFilqj0XREG88W6vFYn2IF0m8FWiRMnDNi3wfYUfzcGt7bvWlUSh?=
 =?us-ascii?Q?r4TD40f/eydfULDRqrmOO6PnS5qQvZG7uUZ/1c93/jgQiBMjBfnebvLaja66?=
 =?us-ascii?Q?HC71EdgDUMFRIK92HgJTxEwB0v88xBAHIEq7r3O52OPwOgDlhKHjz99mcbVw?=
 =?us-ascii?Q?novpB+gn1VqFimYT4PONnzm9nL46csA8+6Sviod6SrGxcKtUmTgkXcxtw8Av?=
 =?us-ascii?Q?VC9UA62z8rNUiZZ/aYAeiHEdSRBvkuIPnsLRMriE9m7NAIK5fQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(19092799006)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3gQB5laOnTacML6xnC2uDFetafANwC5ekyEaxkomdR7Zab29OiQ8Igz6Ef4t?=
 =?us-ascii?Q?eCHl5UHD/yetC4tIAlr2m2h0X/kV3fWO3ztJ5m3ejV4Z5IcgyZKHAUZn6orz?=
 =?us-ascii?Q?RVuKrZNkmW5kR9gz07NJSLzNdxCYbuIK06inmvFcovEU/QGksyVJx8jMqd81?=
 =?us-ascii?Q?m4GhO/FjbFok0Feom1tuWD6JpIZDhCAt7oygBv4dxb9hcjAkMvgQk1k0WwWz?=
 =?us-ascii?Q?m5tN6UZ3nHd1Roct20obzmdTU+Na6AGmgAaz63gg8Nt+m4ZZz5BUPG2ZxWOs?=
 =?us-ascii?Q?KK2nFtpFDjgcPMEXYebDQ++nwzmgmeMQG7qsr9FshoE0IgWEjNi0Vsf8vyLU?=
 =?us-ascii?Q?Cxt6PUWqoF4NA8CO9j5JEwREJF8uXDppPR59KGqu3pK4bo3WB7OhP08uUIS2?=
 =?us-ascii?Q?l3wH9LZmvevvdgr/XeFymbSu5biaVNx5n+pID36ucak3utZ7dJWf3YnBuzUK?=
 =?us-ascii?Q?lCMLt/ji219z50KU0qDTj/Qd+uSl4zFKNYV+/7Axcvnmk4/zJfH0mc5J/dAl?=
 =?us-ascii?Q?Med/acZWPHeJW10QLl98ReKPTPeubdQapoXKgrcihnyInc8gu3HwpUfdT60C?=
 =?us-ascii?Q?rKOkwXWgqLuAi/8tDrTJVJ43MoE5tIKfnuWykQ+qPKbFBP9zoAW6vTDb+PSS?=
 =?us-ascii?Q?qUPpkIJfUpOjTxXG9e6BeEla8Jeo67G34CwExdYcHRcCc/bl10I7A8K3gMUO?=
 =?us-ascii?Q?0l6GGSBlXPxYFLitKv9vLCwoRj59hhLEESdbpAcVR1sVdSGHCjPQDECXZLN1?=
 =?us-ascii?Q?FebUMU7P5/+s7fxirbHvRLjIEY5WEzlgBXEi7+TBjxeEnYOBXqz+iVJJHCqa?=
 =?us-ascii?Q?Zf7DjODE40nMdmsWuNzH0oC9cjyw6FIzv1X4XR3wY36gqEsWxydUy11tTGDU?=
 =?us-ascii?Q?4OoiQXayvzipFs/LYtjOZsU5Z0Cg99kgq3Zuo3jWGPOYM+jdYysbMxUR9IJV?=
 =?us-ascii?Q?6J6sAt8ebFz0nrzArUrzaDcmwboG46/W+5/XlPC0ljc9YxTVBKUfJ6mGIuKL?=
 =?us-ascii?Q?KnPrs4x5K1zSo8i3UF8Y/XxPN629cI81/phsq5+Sx65glBG8pZqcvB+lyE4q?=
 =?us-ascii?Q?R+kH2OndTJ6eSAInGIdpjrXNTo5eSBzs0FJeAWVKFzfVe0Vie9ySkbzHi+Wc?=
 =?us-ascii?Q?wmO9c/uFpgAtuJHv669yDA87KmcEr135mKzLzRgHwcVFpIT1As5amUgDQ4sd?=
 =?us-ascii?Q?nztrUr2tRzpjPiKGuu0z2fJjjKMLhk26KPjYp1Cl0dWNANkR+2DC7HrwSMeM?=
 =?us-ascii?Q?hdFXrIeMM3f/OT/ew9ooNzE26c4ROIPb5/qLjmaJuyu8jXDltzuZlyBS8/Sd?=
 =?us-ascii?Q?kUBYwc8XISRS7i+6rK7qcWpS60clO0EIAWyn06GY58c4FLkVMItTA1/4OMC5?=
 =?us-ascii?Q?wIS8VUQ56mlVlkN/wkLNQjajnj9KMvt8mFDjneA1rB22WfPLVK31VWOupt2e?=
 =?us-ascii?Q?s9YrtPdjuTA72iMjYL4O0GFIP19oI2Ymro0tPIw3ofzUgx3dxMdzgqQ+KUW2?=
 =?us-ascii?Q?skPJleeCdKjWb5T04aqcLmoOiRz01oLrRVOlFtoXnMtIjGr/EJ30AoAfwn0x?=
 =?us-ascii?Q?bC6NiPZajgeHhc0HctqX6TQi5spQYtXpEQch98Exb0KBY37jERf1sqKh42H7?=
 =?us-ascii?Q?C3YrfqoldVqB9wOcsnHfuRH+J8zWTa8KlcpE63tQoYw03VkNIAwyd4cYzf3M?=
 =?us-ascii?Q?4hR6lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eca95225-8bc8-4b11-480e-08de002ab652
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 14:07:38.6320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Z45mLAhG2aw1jGbVUY02brX6/ls8QdKF8/HZ/HUhOsOm5HwufBr9Dnt3+EMAsBe3JGeLiMmR3K/1Ty9E5KewA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

On Fri, Sep 26, 2025 at 09:05:00PM +0300, Vladimir Oltean wrote:
> Going by the generic "fsl,lynx-28g" compatible string and expecting all
> SerDes instantiations on all SoCs to use it was a mistake.
> 
> They all share the same register map, sure, but the number of protocol
> converters and lanes which are instantiated differs in a way that isn't
> detectable by the programming interface.
> 
> Using a separate compatible string per SerDes instantiation is
> sufficient for any device driver to distinguish these features and/or
> any instance-specific quirk. It also reflects how the SoC reference
> manual provides different tables with protocol combinations for each
> SerDes. NXP clearly documents these as not identical, and refers to them
> as such (SerDes 1, 2, etc).
> 
> The other sufficient approach for Lynx 28G would be to list in the
> device tree all protocols supported by each lane. That would be
> insufficient for the very similar Lynx 10G SerDes however, for which
> there exists a higher degree of variability in the PCCR register values
> that need to be written per protocol. This attempt can be seen in this
> unmerged patch set for Lynx 10G:
> https://lore.kernel.org/linux-phy/20230413160607.4128315-3-sean.anderson@seco.com/
> 
> but that approach is more drawn-out and more prone to errors, whereas
> this one is more succinct and obviously correct.
> 
> One aspect which is different with the per-SoC compatible strings is
> that they have one PHY provider for each lane (and #phy-cells = <0> in
> lane sub-nodes), rather than "fsl,lynx-28g" which has a single PHY
> provider for all lanes (and #phy-cells = <1> in the top-level node).
> 
> This is done to fulfill Josua Mayer's request:
> https://lore.kernel.org/lkml/02270f62-9334-400c-b7b9-7e6a44dbbfc9@solid-run.com/
> to have OF nodes for each lane, so that we can further apply schemas
> such as Documentation/devicetree/bindings/phy/transmit-amplitude.yaml
> individually.
> 
> This is the easiest and most intuitive way to describe that. The above
> is not the only electrical tuning that needs to be done, but rather the
> only one currently standardized in a schema. TX equalization parameters
> are TBD, but we need to not limit ourselves to just what currently exists.
> 
> Luckily, we can overlap the modern binding format over the legacy one
> and they can coexist without interfering. Old kernels use compatible =
> "fsl,lynx-28g" and the top-level PHY provider, whereas new kernels probe
> on e.g. compatible = "fsl,lx2160a-serdes1" and use the per-lane PHY
> providers.
> 
> Overlaying modern on top of legacy is only necessary for SerDes 1 and 2.
> LX2160A SerDes #3 (a non-networking SerDes) is not yet present in any
> device trees in circulation, and will only have the device-specific
> compatible (even though it shares the Lynx 28G programming model,
> specifying the "fsl,lynx-28g" compatible string for it provides no
> benefit that I can see).
> 
> Change the expected name of the top-level node to "serdes", and update
> the example too.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v2->v3:
> - re-add "fsl,lynx-28g" as fallback compatible, and #phy-cells = <1> in
>   top-level "serdes" node
> - drop useless description texts
> - fix text formatting
> - schema is more lax to allow overlaying old and new required properties
> v1->v2:
> - drop the usage of "fsl,lynx-28g" as a fallback compatible
> - mark "fsl,lynx-28g" as deprecated
> - implement Josua's request for per-lane OF nodes for the new compatible
>   strings
> 
>  .../devicetree/bindings/phy/fsl,lynx-28g.yaml | 159 +++++++++++++++++-
>  1 file changed, 152 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> index ff9f9ca0f19c..e8b3a48b9515 100644
> --- a/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> +++ b/Documentation/devicetree/bindings/phy/fsl,lynx-28g.yaml
> @@ -9,21 +9,123 @@ title: Freescale Lynx 28G SerDes PHY
>  maintainers:
>    - Ioana Ciornei <ioana.ciornei@nxp.com>
>  
> +description:
> +  The Lynx 28G is a multi-lane, multi-protocol SerDes (PCIe, SATA, Ethernet)
> +  present in multiple instances on NXP LX2160A and LX2162A SoCs. All instances
> +  share a common register map and programming model, however they differ in
> +  supported protocols per lane in a way that is not detectable by said
> +  programming model without prior knowledge. The distinction is made through
> +  the compatible string.
> +
>  properties:
>    compatible:
> -    enum:
> -      - fsl,lynx-28g
> +    oneOf:
> +      - const: fsl,lynx-28g
> +        deprecated: true
> +        description:
> +          Legacy compatibility string for Lynx 28G SerDes. Any assumption
> +          regarding whether a certain lane supports a certain protocol may
> +          be incorrect. Deprecated except when used as a fallback. Use
> +          device-specific strings instead.
> +      - items:
> +          - const: fsl,lx2160a-serdes1
> +          - const: fsl,lynx-28g
> +      - items:
> +          - const: fsl,lx2160a-serdes2
> +          - const: fsl,lynx-28g
> +      - items:
> +          - const: fsl,lx2162a-serdes1
> +          - const: fsl,lynx-28g
> +      - items:
> +          - const: fsl,lx2162a-serdes2
> +          - const: fsl,lynx-28g
> +      - const: fsl,lx2160a-serdes3
>  
>    reg:
>      maxItems: 1
>  
> -  "#phy-cells":
> -    const: 1
> +  "#address-cells": true
> +
> +  "#size-cells": true
> +
> +  "#phy-cells": true
> +
> +patternProperties:
> +  "^phy@[0-9a-f]+$":
> +    type: object
> +    description: Individual SerDes lane acting as PHY provider
> +
> +    properties:
> +      reg:
> +        description: Lane index as seen in register map
> +        maxItems: 1
> +
> +      "#phy-cells":
> +        const: 0
> +
> +    required:
> +      - reg
> +      - "#phy-cells"
> +
> +    additionalProperties: false
>  
>  required:
>    - compatible
>    - reg
> -  - "#phy-cells"
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,lynx-28g
> +    then:
> +      # Legacy case: parent is the PHY provider, cell encodes lane index
> +      properties:
> +        "#phy-cells":
> +          const: 1
> +      required:
> +        - "#phy-cells"
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,lx2160a-serdes1
> +              - fsl,lx2160a-serdes2
> +              - fsl,lx2160a-serdes3
> +              - fsl,lx2162a-serdes1
> +              - fsl,lx2162a-serdes2
> +    then:
> +      # Modern binding: lanes must have their own nodes
> +      properties:
> +        "#address-cells":
> +          const: 1
> +        "#size-cells":
> +          const: 0
> +      required:
> +        - "#address-cells"
> +        - "#size-cells"
> +
> +  # LX2162A SerDes 1 has fewer lanes than the others
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: fsl,lx2162a-serdes1
> +    then:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              enum: [4, 5, 6, 7]
> +    else:
> +      patternProperties:
> +        "^phy@[0-9a-f]+$":
> +          properties:
> +            reg:
> +              enum: [0, 1, 2, 3, 4, 5, 6, 7]
>  
>  additionalProperties: false
>  
> @@ -32,9 +134,52 @@ examples:
>      soc {
>        #address-cells = <2>;
>        #size-cells = <2>;
> -      serdes_1: phy@1ea0000 {
> -        compatible = "fsl,lynx-28g";
> +
> +      serdes_1: serdes@1ea0000 {
> +        compatible = "fsl,lx2160a-serdes1", "fsl,lynx-28g";
>          reg = <0x0 0x1ea0000 0x0 0x1e30>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
>          #phy-cells = <1>;
> +
> +        phy@0 {
> +          reg = <0>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@1 {
> +          reg = <1>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@2 {
> +          reg = <2>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@3 {
> +          reg = <3>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@4 {
> +          reg = <4>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@5 {
> +          reg = <5>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@6 {
> +          reg = <6>;
> +          #phy-cells = <0>;
> +        };
> +
> +        phy@7 {
> +          reg = <7>;
> +          #phy-cells = <0>;
> +        };
>        };
>      };
> -- 
> 2.34.1
>

I should have realized sooner when Rob/Josua requested the changes for
backwards schema compatibility in v2:
https://lore.kernel.org/lkml/20250925080317.2ocgybitliwddhcf@skbuf/
that despite our attempts to preserve compatibility with old kernels,
we actually fail to do that. Actually I should have documented my
earlier thought process better, where I already came to that conclusion,
but which I had forgotten when told that this could work...

The SerDes schema itself is technically backwards-compatible, but the
problem is with consumers, which aren't. In old device trees, they have:

	phys = <&serdes_1 0>;

and in new ones, they have:

	phys = <&serdes_1_lane_a>;

Because the consumer has a single "phys" phandle to the PHY provider, it
either has to point to one, or to the other. But on old kernels, we do
not register PHY providers per lane, so "phys = <&serdes_1_lane_a>"
results in a broken reference.

There are 2 directions to go from here:
1. Have optional per-lane "phy" OF node children, which exist solely for
   tuning electrical parameters. We need to keep the top-level SerDes as
   the only PHY provider, with #phy-cells = <1> denoting the lane.

2. Accept that keeping "fsl,lynx-28g" and overlaid properties has
   absolutely no practical benefit, and drop them (effectively returning
   to Conor's suggestion, as implemented in v2)

3. Extend the schema and the driver support for it as a backportable bug
   fix, to allow registering PHY providers for lanes with OF nodes in
   stable kernels. This avoids regressing when the device trees are
   updated, assuming the stable kernel is also updated.

It's not that I particularly like #2, but going with #1 would imply that
lane OF nodes exist, but the "phys" phandles do not point to them.

Combine that with the fact that anything we do with the 28G Lynx
bindings will have to be replicated, for uniformity's sake, with the
upcoming 10G Lynx SerDes binding (very similar hardware IP), and #1 is
suddenly not looking so pretty at all. I.e. introducing the 10G Lynx
bindings like the 28G Lynx ones would mean deviating from the widely
established norm, and introducing them like the widely established norm
would mean deviating from the 28G Lynx. I can easily see how someone
might look at them one day and think "hmm, can't we make them more
uniform?"

OTOH, the fact that device tree updates require kernel updates (as
implied by #2) is acceptably by everyone in this thread who expressed an
opinion on this topic.

As for option #3, while IMO it would be a justified "new feature as
bug fix", it sounds a bit counterintuitive and I'm afraid I won't manage
to convince all maintainers along the way that this is the way forward.

I'll wait for the merge window to close before reposting anything, but
I'd like an explicit ack from Rob and Josua in the meantime, whose
change request I'd be effectively reverting, to make sure that this
topic is closed.

