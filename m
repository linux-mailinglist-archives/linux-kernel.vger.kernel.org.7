Return-Path: <linux-kernel+bounces-887185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A52C377C5
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 548121886F82
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FDA34027D;
	Wed,  5 Nov 2025 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CWLCUZ1w"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652D92264B1;
	Wed,  5 Nov 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371086; cv=fail; b=Ic8aX2dvbOj6A1zhisDUXuDygAPtTxA2JLwApr4HtjiS1N8TBiK53+H1BZnBmFn2XGovezvDvKKGY7P37TOpsB7d7ztsUwFJ0249l5SEzOuML8QW5vdygpTEhj5BH3zAp6lcUVes/L0r4haRMO3/yocDz1bWg07lxxnCPb6cKFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371086; c=relaxed/simple;
	bh=n/GqjW/Kub6dNTFIqmeRKNiuBzM4rua0j4ZO2mbgmFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4t2Sh9/dvK4CA31jHcF9m0t3gxO8w89Ql5F71Umdfb+XUlo8Rgo0eGIiPsLRtN++NhmYqLc/k+/MFfFv/gG3sPOUToH2n8C7mGclS8FUS9OpiITGQLpLtw5szvDvJ84hlTQ0H0SENLcknLrGu11SiYaWYLruo4/DXAV3fDAaGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CWLCUZ1w; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GAJXdKXRU5B7dGpzNv6Dfnre7E50tZL3Jma8QK0hfXkoR5I+z9ef6s3oXqqwqItskfiCu/pBxKE2NaPisebhQ4EMhQkq9GSYaDGUNXtBqUR1GZIP9kBxVuzjgZLd8Yj6KuaZjSZYd4Sf7fHXGT12JqLVOSsl7cfvLFCN4JguRkuBPIT0IJCPN0abZQbq+/aOf8D13IkaZFsijAXGTzibNRn6BsxEhi0HWPQ/BJRKgUty6wWidcjeflNrUZH0ch0SFmLJoGzeZafsQQfcr0GzmCaA54rA2P6Hxa31DXYb5v4g8y53EXgAp3L+h3flv0PszXg4nL/6l5AspzEPSbdfrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6fePZORu0ev2k1P64QAjzHPEeyerH1zMh0EnNCNJ6I=;
 b=h1xjbPYWyO6wbqkSZBj5DX9DO+dcwmxVaaA17FV5uZamhoJzFQJooXEWBVFZsdsyPysv47Z5PxFQ3b6kIz7VuRDqNDY3y1haTtGFfoCd52Gm7V8pGAvPBQfTCdQpNuH8Tr3c1p+sYwHUgPHRD6a/40Vh/bkxAjnhfytvzSGYpbZpg+q2yziRaMdURa/cwQq+GMxsWPSd8r4amk2qJ7tOmFWopto1sMR32oqlwt9nH2MCO+lAE+Awb2BhllcalsAWucGghG5TguqBGU+dj6EkT84HqeyGTK+Cm2RTELI6lZmBgUoirDlUUIL/CDF7NSsoKUpxOna9vf2SjaogLgbtfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6fePZORu0ev2k1P64QAjzHPEeyerH1zMh0EnNCNJ6I=;
 b=CWLCUZ1wgowmLMn0wZRZ3Mbmuy47OArdBrDhKH310/gl5ABpAZfveJHlFAkMiCPZT129y1Sz1plb/Pb6H3esf38O6gnng8Uf+WlJH4KaW9ec0toIHQd5b8qPbNQOor/ZnaPYW2XG2qRurOYVA9WkpG7YmLELikS6YaNuGJ760XKOynxHtAm6WsOGjUQduqaG1T8Icej4zgc9lHFKN1mHpJHHmfJThn8wt7xdeXxAYpiGYj9hH9G7LaYKEacIH0u/fVbMK7A9mOx/ZoXsUp98ffeVqcHAQrRq1BFMSBa2zirbbdp7ZAgxvqayyo/ubBwIhS8BqdL7aKCBNkbhlZ8HXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA1PR04MB10097.eurprd04.prod.outlook.com (2603:10a6:102:459::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Wed, 5 Nov
 2025 19:31:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 19:31:19 +0000
Date: Wed, 5 Nov 2025 14:31:09 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Alice Yuan <alice.yuan@nxp.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Robert Chiras <robert.chiras@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>,
	Hans Verkuil <hans@jjverkuil.nl>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Kieran Bingham <kieran.bingham@ideasonboard.com>
Subject: Re: [PATCH v4 0/5] media: imx8qxp: add parallel camera support
Message-ID: <aQul/VGG8e3MJxhx@lizhi-Precision-Tower-5810>
References: <20250729-imx8qxp_pcam-v4-0-4dfca4ed2f87@nxp.com>
 <20250805010822.GC24627@pendragon.ideasonboard.com>
 <aLbcpEZXm5G1Onq7@lizhi-Precision-Tower-5810>
 <20250902123920.GM13448@pendragon.ideasonboard.com>
 <aLhJDXnz9HPGrWcp@lizhi-Precision-Tower-5810>
 <aQuDSROHLGHIhtlh@lizhi-Precision-Tower-5810>
 <20251105171928.GB6046@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105171928.GB6046@pendragon.ideasonboard.com>
X-ClientProxiedBy: PH8P221CA0021.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::22) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA1PR04MB10097:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd4fe40-c09f-4ab5-6fe3-08de1ca1e52c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|19092799006|52116014|366016|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?6GPV2vqlJ3Q/dl6fUW7VnOdNkFsH87e63Q5ofh/BlpdfPUXOMG9xrPcstsak?=
 =?us-ascii?Q?2y7yujhcWm6OQvaT15ZBNKt56xNRsT/HHauWon5EiqYDlaLJIL3Y1K/Zptaa?=
 =?us-ascii?Q?YQoEsBppyKkRD7jTrnxAswF3X+Ml+GlIHNCu1KolLNRR4p2VsBpRn57z8Hv0?=
 =?us-ascii?Q?RWVWG9+KosN++Hm/Z4yQc9w8dA8N5pdFUHZbPVnC8Ae1Vo9gtLgFMjvI68gl?=
 =?us-ascii?Q?eXSR9Z686N0Xb9hSVOOBrBbfZ7XVSTEjSTdRl/kqtvaEFXNKS4xVFRM3AVhN?=
 =?us-ascii?Q?eqZWL2SM8AxGxpXxlvSpjlZlW++hTfEU5DwaoHrPoYLjyl84AL145UzuDRau?=
 =?us-ascii?Q?+/ZtgDS+kkQovlCPOKfHjZf3xMOCg2Gq2R/CxjdS9DiYPq6GpSs5CnXk7AIr?=
 =?us-ascii?Q?vl0ON0FizQrr+KCtaIA7PPXYqLq3ex4PgUy8urdIoNoWVb1yUCuohxv2UGp4?=
 =?us-ascii?Q?8S5lGISg+yKSRzcnbzxU3mbLd9P/wr373vPmVIhkmH7SejfXRZJa4YYDORpG?=
 =?us-ascii?Q?baFKZZuj/679OqbseBEYwj94yqfrZJF8xuYgQG7HGQkIx4otXtuqxqVb+gWA?=
 =?us-ascii?Q?UPQRmJWgewCX4y6CYEgjfMIlZfVAnkRErkFcYVT9NZdVbtKn4KTej9lDS4JM?=
 =?us-ascii?Q?CDhTjhEdnzG/+diaqRS79Y2wp6cb5A3QxEVe8HM/phe4RpYDfXbZxdTKlkFP?=
 =?us-ascii?Q?Wkdi/o/Tyd/pJbej85xu9zZKI7FyupMQliRqOYnCPUaZI5fw5qQCLcJ2sOTF?=
 =?us-ascii?Q?udxX7SUulbTWEnIvewCR7ukUDS3dECVrpLq7o2a57d+tnfQILKjzLpkQR8QB?=
 =?us-ascii?Q?ENtDl0C4Cb3NfQG+vzuY64zoNHAmJNH53ajnmTGhdxcfKLLyJD4iX7sO2PHC?=
 =?us-ascii?Q?SclYWoB53dDM+CUF/Ki7QONRWL8yJI2v5aCv1ZnuVdgr+pY3FEbxhVinPlIK?=
 =?us-ascii?Q?pU45aWJHesmXGLqOyJ713RWwye+G8TuADxdkIOGDyteZ9E6rZQWG+i2/fR9u?=
 =?us-ascii?Q?fTtcS4cyyBjyB6HdtI/42mEygieLUNatihRWxsXi4v+95TFCC1SbsnHxurBB?=
 =?us-ascii?Q?S8LhbuXGaHz30L7wNcQj3OGq+1I6+WXhvLlina11UdGbZd0xbqct8P6h4joV?=
 =?us-ascii?Q?HbYGyDM+uWLVbYIqglNbpJAbqKrO+WZ8Bws3yZVwn/sJuYdoIxT7B2XDMwB4?=
 =?us-ascii?Q?jbseS7ZhZtLHS8CIB/aDUsrsFTD2OfzMHORy/AYenbyxPV9UZ5aBhs7+tkNr?=
 =?us-ascii?Q?A9627RwQmLsL42+EYkIWnPlh4A/iFjZpJxpStAP8Q3yxMcIbRduDwmSPx9T9?=
 =?us-ascii?Q?D+sE8c92rHh0VUC7JFbniuDqGfl/yBRPZIAgR3WYZvjUvoSjZd8CCJB/pue5?=
 =?us-ascii?Q?LHq8dzM4+QfroHbcMGNqH6R1kOy+73F19kjxNhuOMBHp8UqlDgX8jcR0L3fZ?=
 =?us-ascii?Q?xpWkQ7jUepWzKvU+yBrv10r+KRaKU2Ku1eOHmJSZdkZvVHZ+qXGVtHO8+Wt5?=
 =?us-ascii?Q?VTHk+H32B6dtQAciYdSEEpPuFxSeU8B5/qjW?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(366016)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?L10hJcAPQQVrbpqwjrJmjHff9fwTHMvo3/sU525DcIolm7ESBWvRaZl08CCy?=
 =?us-ascii?Q?2DA5ka8X/rhw2BHHW1zECDRym10XOtENd7Ajsh3G/P8xORF9rW8T7+W9qBae?=
 =?us-ascii?Q?X3wQ25QvIlpAqEMkB5fXwjEL3X0WFTEIYCqgKr3IFTfUtAFoWgdKRdUv5uAu?=
 =?us-ascii?Q?tJET8S1KBlw9RxPKdaDIbrlnqRNeFciH+S3YN3NCypZznVH1sbKWu3DtTGx4?=
 =?us-ascii?Q?+mHfITtS+ML2GQbsNt7qeAXRqRboSuphLBkhbU84KSp9lngJeB7OGKH4hePy?=
 =?us-ascii?Q?JGvwcIPXTMsmu7zvDV6/DF9M8Xse9Pc3o4lTyL6yH8yPQwZ1yvHBnqLLwilc?=
 =?us-ascii?Q?ygLVwnfUnHOYoWjbrcBSIGSUyQx/t7AxWLC4YFy6vxapBYsMdP9eGz6bLWQL?=
 =?us-ascii?Q?wrGAoodTI9QW4e2r8NLDyGrl9k4mD9jqbPJXHjRazIfJ9FKyWbZdhL5Rabt4?=
 =?us-ascii?Q?wjLtx/mNrpx2BwTzr5cSVaKws8NXR095lVL739PiGVSnU53+Cga6+2CVT7c0?=
 =?us-ascii?Q?XhBzuTDYS4diKu8fD4XoloUsDfrBBW8BvZbPqAHKiEUO/VNuxIXNGA1jPMfD?=
 =?us-ascii?Q?iQE40GzsJKMmC7C2uOCrK78KLdXdYfCIMMD3rDGoqz1jl9+vtFgf17OwFYAN?=
 =?us-ascii?Q?yFYuLvL2aFPSgN0E6q5D7iI9+K/EC1w11T0qbSbl5m52+5BbAAbeXTHwpTtC?=
 =?us-ascii?Q?k+DfKRF0PjSsVQA8t4n6hwKlTB5I+svsPCcxrUiqFNeyC5invSWg9a8jKDt9?=
 =?us-ascii?Q?jcm+DNkxjVdpPeFyc7ffppq1UsbhNa6aIojiBnhHuKY9cItCno7hiLhOGYX+?=
 =?us-ascii?Q?FLK2KEWFH9m4vjYZ/s8Bb6weugUtfJTG3BoUs1RunwkSB+lAvO8VDVrRZjuH?=
 =?us-ascii?Q?LVnOFhWntjErNnWzUpYOHs2tzqpWA2aKHF1BIT92fW43t0TWsv1XP4sVyAyV?=
 =?us-ascii?Q?9NaZoY2uhny7hUusevWLKQsUBhfLDmUUTIbOPox3lXw35SSyR0xoW4WTZVUX?=
 =?us-ascii?Q?JUbIyqKxExfwPQdr0GYwVweUZgybSS2wJSvg+j/asH8H96PYjPpu6PgvOmOr?=
 =?us-ascii?Q?ZfZ8zaaOpvlnCoqPRWJBtYMcab4iJlKZNCrm+ETYThCm5ubObW5UsCLo36mJ?=
 =?us-ascii?Q?dnoi5DL3QT/dzbE+MFrBz5qFWpgKfTNN0cu0Fz+Ubt6w422Ojb2YnRwRtrf1?=
 =?us-ascii?Q?RWmjXTisxtDJHBH9k2wedx3OK2ExsSnmIQPU/aUR26gH36sAnThiT2KazAeW?=
 =?us-ascii?Q?SZYvzls8NSXpQTBgJe1bDOXr//mF3zHvcqSS85L7jBVaVqRjenHmCfkaJzUn?=
 =?us-ascii?Q?9BRlBMyzw3ms6Cq1ahFDtNnp0z+6CpqSnhxYgifm8wEQYgeSRgqb6c5V4iVh?=
 =?us-ascii?Q?g1jZ+Tx/Aqu44RtV3KTPqMn+7/HBxiLJxiWHezhbkGyNQhMq48TuBbDEz5xN?=
 =?us-ascii?Q?kyMSFJi1Ey5R/oZUkHctL7huabtaDmOvAqEaMuTFoflccXLIoNrkWdfR8x2C?=
 =?us-ascii?Q?cvV7n2ZAeZSi6/dcW3Z/Yii7LJsN4ntyZwx0/AoRaSvc7wAnXrdwlL91KjZc?=
 =?us-ascii?Q?ooaCg1ENjvptf9G/7YHhYO7uIcv8NslVxB0R6b53?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd4fe40-c09f-4ab5-6fe3-08de1ca1e52c
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:31:19.5405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u23yVicpBzUwi607GWCvkLYOE6gKNCt3mDcG570r52/E605ZZ03J2iwP8aRynYytaufevmedXAWbmuPBWBuSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10097

On Wed, Nov 05, 2025 at 07:19:28PM +0200, Laurent Pinchart wrote:
> Hi Frank,
>
> On Wed, Nov 05, 2025 at 12:03:05PM -0500, Frank Li wrote:
> > On Wed, Sep 03, 2025 at 09:56:29AM -0400, Frank Li wrote:
> > > On Tue, Sep 02, 2025 at 02:39:20PM +0200, Laurent Pinchart wrote:
> > > > On Tue, Sep 02, 2025 at 08:01:40AM -0400, Frank Li wrote:
> > > > > On Tue, Aug 05, 2025 at 04:08:22AM +0300, Laurent Pinchart wrote:
> > > > > > Hi Frank,
> > > > > >
> > > > > > Thank you for the patches.
> > > > > >
> > > > > > I've quite busy these days, and I don't believe I will have time to
> > > > > > review this series before coming back from OSS Europe at the beginning
> > > > > > of September. Let's see if anyone on CC could volunteer.
> > > > >
> > > > > Laurent Pincha
> > > > > 	I hope you have good time at OSS.
> > > > >
> > > > > 	Do you have chance to review this patch?
> > > >
> > > > I'm going through my mail backlog, which is really big at the moment.
> > >
> > > Understand.
> > >
> > > > I'd like someone else to volunteer to review this series. It won't scale
> > > > if I have to review all NXP media patches in my spare time :-/
> > >
> > > Yes, but none volunteer review this in passed months. Expecially key
> > > reviewer. I am reviewing i3c patches. but Not familiar v4l system yet. It
> > > need scalable solution. I can help filter some common and simple problem
> > > from beginning.
> >
> > Laurent Pinchart:
> >
> > 	Do you have chance to check this serise? this one should be related simple.
> > 	This one sent at 7/29. Still not any volunteer to review it.
>
> I'm afraid I won't have time to review this for the time being. My spare
> time is already exhausted by all the other drivers I maintain upstream.
>
> > 	How do we move forward?
>
> I think this is a question for the subsystem maintainers. Hans, Mauro ?

Mauro Carvalho Chehab and Hans Verkuil:

	Laurent provided great help about review and land i.MX related
patches in past, who are quite famillar with i.MX chips. But he is quite
busy. So the whole reviews cycles takes quite long time and offten cross
some merge windows.

	In pull requests for 6.19:
https://lore.kernel.org/all/4989c563-47f4-478c-80c4-41f7e98597e4@kernel.org/
only 10 patches, and 4 patches is trivial clean up.

	In reviewing patch queue, there are
	1: media: nxp: imx8-isi: Add ISI support for i.MX95
	   https://lore.kernel.org/imx/20251105-isi_imx95-v3-0-3987533cca1c@nxp.com/T/#t
	   This one already review, but I am not sure if it capture 6.19 cycle because
PULL-request already sent.

	2: Add MIPI CSI-2 support for i.MX8ULP
	   https://lore.kernel.org/imx/20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com/

	3: media: add imx93 mipi/controller csi support
	   https://lore.kernel.org/imx/20250821-95_cam-v3-0-c9286fbb34b9@nxp.com/
	   This one is quite big, but first 10 patches is simple trivial cleanup patches.
	   I post at 8/27, but get first feedback around 10/27, I am not
	   sure if missing somethings.

	4: This series, laurent already said no time review it.

	5: ap1302 sensor patches
           https://lore.kernel.org/imx/20250811-ap1302-v4-0-80cc41b91662@nxp.com/
           binding already ACK, most maintainer want to pick binding with
	   driver together, but not an feedback since 8/11.

	I jump into and help do some review.

	The questions is how to move forward pending patches, like [3], [4],
[5]. How to keep good community channel to avoid long time pending?

Best regards
Frank Li

>
> > > > > > On Tue, Jul 29, 2025 at 12:06:21PM -0400, Frank Li wrote:
> > > > > > > Add parallel camera support for i.MX8 chips.
> > > > > > >
> > > > > > > The below patch to add new format support to test ov5640 sensor
> > > > > > >    media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > > > >
> > > > > > > The bindings and driver for parallel CSI
> > > > > > >    dt-bindings: media: add i.MX parallel csi support
> > > > > > >    media: nxp: add V4L2 subdev driver for parallel CSI
> > > > > > >
> > > > > > > DTS part need depend on previous MIPI CSI patches.
> > > > > > >   https://lore.kernel.org/imx/20250522-8qxp_camera-v5-13-d4be869fdb7e@nxp.com/
> > > > > > >
> > > > > > >   arm64: dts: imx8: add parellel csi nodes
> > > > > > >   arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > > > >
> > > > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > > > ---
> > > > > > > Changes in v4:
> > > > > > > - remove imx93 driver support since have not camera sensor module to do test now.
> > > > > > >   Add it later
> > > > > > > - Add new patch
> > > > > > >   media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > > > > - See each patche's change log for detail.
> > > > > > > - Link to v3: https://lore.kernel.org/r/20250708-imx8qxp_pcam-v3-0-c8533e405df1@nxp.com
> > > > > > >
> > > > > > > Changes in v3:
> > > > > > > - replace CSI with CPI.
> > > > > > > - detail change see each patch's change logs
> > > > > > > - Link to v2: https://lore.kernel.org/r/20250703-imx8qxp_pcam-v2-0-188be85f06f1@nxp.com
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - remove patch media: nxp: isi: add support for UYVY8_2X8 and YUYV8_2X8 bus codes
> > > > > > >   because pcif controller convert 2x8 to 1x16 to match isi's input
> > > > > > > - rename comaptible string to fsl,imx8qxp-pcif
> > > > > > > - See each patches's change log for detail
> > > > > > > - Link to v1: https://lore.kernel.org/r/20250630-imx8qxp_pcam-v1-0-eccd38d99201@nxp.com
> > > > > > >
> > > > > > > ---
> > > > > > > Alice Yuan (2):
> > > > > > >       dt-bindings: media: add i.MX parallel CPI support
> > > > > > >       media: nxp: add V4L2 subdev driver for camera parallel interface (CPI)
> > > > > > >
> > > > > > > Frank Li (3):
> > > > > > >       media: v4l2-common: Add helper function v4l_get_required_align_by_bpp()
> > > > > > >       arm64: dts: imx8: add camera parallel interface (CPI) node
> > > > > > >       arm64: dts: imx8qxp-mek: add parallel ov5640 camera support
> > > > > > >
> > > > > > >  .../devicetree/bindings/media/fsl,imx93-pcif.yaml  | 126 ++++
> > > > > > >  MAINTAINERS                                        |   2 +
> > > > > > >  arch/arm64/boot/dts/freescale/Makefile             |   3 +
> > > > > > >  arch/arm64/boot/dts/freescale/imx8-ss-img.dtsi     |  13 +
> > > > > > >  .../boot/dts/freescale/imx8qxp-mek-ov5640-cpi.dtso |  83 +++
> > > > > > >  arch/arm64/boot/dts/freescale/imx8qxp-ss-img.dtsi  |  27 +
> > > > > > >  drivers/media/platform/nxp/Kconfig                 |  11 +
> > > > > > >  drivers/media/platform/nxp/Makefile                |   1 +
> > > > > > >  drivers/media/platform/nxp/imx-parallel-cpi.c      | 728 +++++++++++++++++++++
> > > > > > >  include/media/v4l2-common.h                        |  30 +
> > > > > > >  10 files changed, 1024 insertions(+)
> > > > > > > ---
> > > > > > > base-commit: 37a294c6211bea9deb14bedd2dcce498935cbd4e
> > > > > > > change-id: 20250626-imx8qxp_pcam-d851238343c3
>
> --
> Regards,
>
> Laurent Pinchart

