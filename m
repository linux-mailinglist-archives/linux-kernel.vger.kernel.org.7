Return-Path: <linux-kernel+bounces-800961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B7FFB43E46
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D28C7B214E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226C13093C4;
	Thu,  4 Sep 2025 14:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gcV1qpaY"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956163074BE;
	Thu,  4 Sep 2025 14:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995019; cv=fail; b=TNXUxK7TCWUevNZK4kuos46RP/MFZnINhtzSXZlYjmomAa9ZGvPOMXRjLdyIQEVgWQAU8YXEsljWD7qcZg5VzZEAcljlICV3jtiSyu8+G65E42o+rSskkGWhp1oavKPhSWSjsM5dT2cgLYIo3Rsm7UOU+H7P2mwn9B+9QXaWuAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995019; c=relaxed/simple;
	bh=6VwK5bhiQAdWfgid/JohJSOz+zsRg+zwnQmCPu9aniI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LzbwLJ9uypcqGZSMhnsV+wtEsfMhH7NMab/juKuKlJBhj8ruNMpjyF2nVDV5bM/p9Chn/CVKfJK1yOWC0DalqZNsUXLXLr69S++z6nKKLBU/fTgN+LchAMiEx53ZAczL0NeISzLgmbl74D5NOlTsXEQdYZ1xZvO2Llt1k2T8C3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gcV1qpaY; arc=fail smtp.client-ip=52.101.69.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzixOpJVrbdGGcDNsZ63q+faGsxw216ycvcDj9poRSZGQCfFRuf9KVE/7ZJCyQUjM4nvxDqMVTmpI3zuW8c9ljp1rr3KCCmKomHZi+Xc44KcahF+SCQ4qnc+5aT40D/rIoeZy4A0vwBwoZbJ5TQFfsSb2D2G3+QZh5F28unCmuA/8dlaoSS9qpz3vOtTtnQ+HwYmuqSAadzEX/qwUDqlAP60yn9Y9TkqqW1RorN2AmHYbG+Tx1ZeEKs8YvJ2BWl9APlqteY5/C3UH6kDcCuB5REBz/ez70gYKx0ti1w4q8O3hxH8C6e9h7DJbvDszSc5W0eMONOOeKsGCy/wZB9dPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HV1SbRFjkOSOBdgSw41FVX/fhY9upgMFQJwigNknUH4=;
 b=bPAWOfxLjnlBFq2/r8kX6lHdB9gF0Ig4hOXEQzkAHiDsEVg5+lE5GRLEGRsS0tN5SuVQuu1g8BRgYvEJ0npe08FdeuG7eG41x2QY1N8TNmyMJKuVBmUY3l2teUzlydnDTVPdB/7oQyL5GlQjdF0AltNUdTZT1d2bLz2pAarEotYK5abVqQUcBeoEAxmL1faPHTxWhQQUg8XQMBZgBiJ17kju+9AVRsDNJA5YMHqLrc523/MbnfGuyNmMiWQYaENdN2vjtLWkcTvDcg5ieaggPg5/XjAI1PfcMrE6O4/W3HQJjlxZ4cf3tdERGIX23Fd7aPMnPSdhwn7NOIoWiHShxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HV1SbRFjkOSOBdgSw41FVX/fhY9upgMFQJwigNknUH4=;
 b=gcV1qpaYdCD2C31+7oP/ZF03+yhC/3v995f/eNPe3af0X46Dg38c2V7rg3xwcsr5rd1TRqmsdAv4ZfHVTP7vP6DHvcKf7ySEJJ5razvZza9JnfkQuPWXaK3tmahplOpRXEISI9NLhs2PPO/aOXnu3GFb14PWyIdqOeBVC1BQX0z9Fivpz8mKZjp5lrErpYiCP0+edePyHHp7ciukGulT/CtSFYKL8zEKK06evOp2zYiX75oWcoA3+zMk4sEWukNYrCMhl8HM88HKB5eGo3AaAfd2DjWhyIE67PyzouoRKNXPZD8cRhwb2zOLDT6kJlYCKksIjwgBMKZcVFnIhOzibg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 14:10:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%5]) with mapi id 15.20.9094.015; Thu, 4 Sep 2025
 14:10:09 +0000
Date: Thu, 4 Sep 2025 10:09:58 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, imx@lists.linux.dev,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add ldb
 child node
Message-ID: <aLmdttUH/GoIhMRm@lizhi-Precision-Tower-5810>
References: <20250903123332.2569241-1-laurentiu.palcu@oss.nxp.com>
 <20250903123332.2569241-7-laurentiu.palcu@oss.nxp.com>
 <20250904-misty-mini-buzzard-af2aec@kuoka>
 <dkumg46ybhyvjlqgequj52vq4wszjce7myz5of42ofydwuvkp7@2okl64wavaa2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dkumg46ybhyvjlqgequj52vq4wszjce7myz5of42ofydwuvkp7@2okl64wavaa2>
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f99aed-705e-4834-4e11-08ddebbcc1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H8gpNcu6Dr2WPKeGnZgTkLr2Kr6R7UjDOtfWBDGVV64IoCUS6hF2Ksuf/8e4?=
 =?us-ascii?Q?0F+oMNxbSmq0PsuvDrQ2FK0KF0rHidSckNQ/Wio7aBY+za2zOT+OU4Xysqzg?=
 =?us-ascii?Q?cMMgKy/sJa9vAV+kH1ZzkVUqLPBKvxZM05l5AfxQLR1jjHtOkA52I9YPBvnk?=
 =?us-ascii?Q?LsSo5OyoeH74lhkiRAZiPgh2a64/nS1CiSLr/414D7A/50QlmESIDLBEM+Ji?=
 =?us-ascii?Q?roKXiMyA8RkZBqFVVmY/g75ng4kc48zPFZxCkQ1Gc6xavrqN0XL09P1Q+Wk/?=
 =?us-ascii?Q?Y2Rr2V6AVVCCqK47rqqW35Cw9jiz6i5Q0PLawZ2HSua6BKWMViJ8pMJd++8m?=
 =?us-ascii?Q?MHA6t6s1FjryTFdTYVUIEIjxUjIfWtqjBVl47wDeJIGpu9goxDDfQFoKlLzg?=
 =?us-ascii?Q?DPdSgjytAo28vkYO42qvPxsD0BlNsgzyUFpPrgdKdUJ2yNTTmA6ONPEA9e4v?=
 =?us-ascii?Q?4sq3je466pcLOYpW+1nB/jwzul51+kWCGAQ611H+4m1YRYnPVe1+uIzFESW/?=
 =?us-ascii?Q?81dasG2mUN9U0y2Qjg0QslKSSlBc6lNt1tORN09fQNUn1kDNOnbN8qGv5/+u?=
 =?us-ascii?Q?ArLnHNtb1JaM1M3tp4u0YO+0MmsKPEC3Y03cA2L/zcdCszhK/hDNc55/QbuO?=
 =?us-ascii?Q?3kTuVAoSLSf3bnmRHp1Gdf2b/HssIAmRxK40hVLa1Dzo/OpfLwA+CX9IFx1S?=
 =?us-ascii?Q?TxAAeTU41Wrmv+tG8ReKoz7PJoGoTJYlFGsX/HrmB3gKjKw0JDhFmZKa1Uug?=
 =?us-ascii?Q?2bCRASrWa5xdQt8Tcp1VDGyp9HZxTcbImwYNb9SVyu8bTNbNLS++5wBDLbg+?=
 =?us-ascii?Q?A7irqsvvRekD6Hu4JZmi29YtZTxo/FXLDEdlsBRlzXOFqPvi57PuwLKgiV/J?=
 =?us-ascii?Q?mLdV6e5wrqVULj44jOLGcSKsv4Imtc7ly5irpahshfuvce0joX4KBrQxb37x?=
 =?us-ascii?Q?0B4OQvnyhTi+ML3nbWMSIRyzIV0s6D7vZh6dJBLcwokSaJ3ijXz5DUXDiM5H?=
 =?us-ascii?Q?1h3AO9OEsk8SWvc0MWRVqm9f2YmU7X9lqcjMdufMz0PCUD5wgBT5zLh7QM+R?=
 =?us-ascii?Q?8rXx7V3vLESYJxtFdHpZkc9wTwueyg8C5buY8ydSPGiASwmRVWHGq5L+MLh9?=
 =?us-ascii?Q?LjRdUrECimc7AZfjKKjTTe8lpfCM1429PAvmHYp8RMTwBy98bVRfI1Cjy0nd?=
 =?us-ascii?Q?BUDleAOfvjPblkK4e43X6wclzg0iCWCL8ScruVaYcSszjpJD1asvxcyzQGD+?=
 =?us-ascii?Q?qGNZ2f/oU5yMz3k6+6EwZtjg1UQ/Uzkhbd0JW5yORbgVAKhckxt3PmwpJ1wM?=
 =?us-ascii?Q?s0uYhZTJ/oacX9CU4RwH6ffH5zEcmdQOWUaEvfwH2OZXTWVCCdjcYOxalYye?=
 =?us-ascii?Q?0qGTZPp6RM6GRBA/UDHEvzx2OXagsX/99TykzMJwnlHaOhgcoIQmgJ3iSg44?=
 =?us-ascii?Q?cYxlkfwb4rFDky8DxFjd37wDtLHLC//Dmh2zdWpM57KLRT4hVnmLIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cbpi7HmG9cJNMTThF0WZSel7oyj9WruQ7YJT7Q0YwiRbgN+NaaSxs+hjPNn4?=
 =?us-ascii?Q?Nkqh3m7iXpLAe+O8q2ScPEx67+y+HS35R8p7UYfh4WYl1t7XPP+6nvfYrbQy?=
 =?us-ascii?Q?axzPgiXR9iUSrbSZ8HrRtp21eqO10wwHC3Uz4WMeqgSbxnOz6NbBoG9qocaQ?=
 =?us-ascii?Q?AzR+eAFx10D9Uh0KA6aYhb2U8n2YyWOgmPZ1WVSer+uLji9MMutI++/FM7Dc?=
 =?us-ascii?Q?bEHRvMVQffOFwB3EayT/yO+s8FVGO8TrebqvGmWxdQDk22RptqLqO8IJfzUG?=
 =?us-ascii?Q?Dq793DSxNpoULigpQ/vw3H6ejwRNRyg9dbrrjqMioi19jP6amzTSYdc00tzP?=
 =?us-ascii?Q?+LB2efTJuecbGlQcJ+iWLGo5KJ5KnA7PfhrTKqxOr6hzuCKcuUhc5X5j2Vav?=
 =?us-ascii?Q?S1TriV5+sVl4LgJ5BtyASOyoHj76LojL+jbKfPf891YN7cQcQzYZq1KTm8Ob?=
 =?us-ascii?Q?2Wyq82zJp4ZQhzEGM4PRdJhDfS/eefUJgC2RUGg8TRJYDQNSZVsUaOFhwF7c?=
 =?us-ascii?Q?Q+lWXF9gx+Io0y8asX+5PjItvt+x2Z6ei9qcrCkkmZGve2dSR4QYyNKvFSBS?=
 =?us-ascii?Q?OLZiND/GATUVIzP9usKqkyt7amhhXl0TWN5F5bpUBhM4fOnjq32poF4uplho?=
 =?us-ascii?Q?lCRlHFugyxxYAkqDv5un9qYGuGs9v26/BiDplO0sq6fAPo5kx70vV1xD618V?=
 =?us-ascii?Q?pX8ZI07QiN+WmCFYDEX4FvwvrzKvRx1EeTE4du6h9rsLLS9EO1eo5x0wntd9?=
 =?us-ascii?Q?SPzNjyZG9nUmcPUxqR8py7PMshH++nw+Ripyb56UR8naRfZ4KC62LSKJZtFH?=
 =?us-ascii?Q?vhhQLvspD1LpXnBka8snm4FHEOWoNQ6XnXx5kFtKZPMV5b4cXFuNtQd/mArv?=
 =?us-ascii?Q?9euGJo4ZELS4IkOFMmT3Ee13tdo31Q7WhFG+PxUepZAV9G23t/kw1b9nP+cQ?=
 =?us-ascii?Q?020DDfIbR2gTNqW66S/spK0x8cKnz+Yk1WPILlpfJyHFjJ/10l4MBjtnCSZ2?=
 =?us-ascii?Q?ZP9EAXrYDmML3HcNurw0qFXrXXR3Oo8EhMUe/r44fRmdsYqKWKkkxGMuXZzW?=
 =?us-ascii?Q?okg9nAbSVV7xvtmjg9Uf5OhkIYOVzJK5P89kN2VZOcEB7+6tp4QwX1nqzFPm?=
 =?us-ascii?Q?b93Z6dab74GOysV0jViu/lr9TdOPciJ4O9xJKL57y9rsE6lALzbZhk9HwUjS?=
 =?us-ascii?Q?HWv/slPDQO6T5KVGplvhMfg30VXmKDnsMGGUxrQTI5RodQhiZEDJQXO7krlD?=
 =?us-ascii?Q?GakwkMbB852Eeci3G1SalnhGNyKQUp7WgliSVbOmWt9dVc8Z1luMa9fzBc3B?=
 =?us-ascii?Q?S9+WT8OPAqR67sO9omKljEYrQ02h/uH9y3nQNEySKOOqh4a5GqrXSX8GG2Sl?=
 =?us-ascii?Q?imYeyD6n+EHjXFr4q4RaU/v+TrPon6ZjjS14Qvqb2B647oWVJFxf2P16KBK5?=
 =?us-ascii?Q?r23+Prc3rkO37zZ/jnCd4NRKj3s4wWpBD4OMAZi51JwRAKqZi0cCpwlU+YCh?=
 =?us-ascii?Q?u/skc97p5oGKx6BLbcjnriuFCw0EOzE2sWHpheFn1BWJnR0raCzPaOxEGzMM?=
 =?us-ascii?Q?TeK4029EQOXI/MyIBiE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f99aed-705e-4834-4e11-08ddebbcc1c6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 14:10:09.6336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BUXaf9Y5cf1zKF6otAa1oJLKeU2h+iCJJrCYd765zsIKcL1Xq18mtHxu5db3pWGbyOXvgUsc1msoXDIaOP8Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

On Thu, Sep 04, 2025 at 03:14:53PM +0300, Laurentiu Palcu wrote:
> On Thu, Sep 04, 2025 at 09:27:31AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, Sep 03, 2025 at 03:33:24PM +0300, Laurentiu Palcu wrote:
> > > Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> > > LVDS Display Bridge controllers, add 'ldb' child node to handle
> > > these use cases.
> > >
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
> > > ---
> > >  .../bindings/clock/nxp,imx95-blk-ctl.yaml     | 24 ++++++++++++++++++-
> > >  1 file changed, 23 insertions(+), 1 deletion(-)
> >
> > Nothing in the changelog explains this patch.
> >
> > What happened with entire previous review?
> I will try adding a changlog to the individual patches in the future... :/
>
> >
> > >
> > > diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > index 27403b4c52d62..f83d96701bb04 100644
> > > --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> > > @@ -39,6 +39,28 @@ properties:
> > >        ID in its "clocks" phandle cell. See
> > >        include/dt-bindings/clock/nxp,imx95-clock.h
> > >
> > > +if:
> > > +  properties:
> > > +    compatible:
> > > +      contains:
> > > +        const: nxp,imx94-lvds-csr
> > > +then:
> > > +  properties:
> > > +    "#address-cells":
> > > +      const: 1
> > > +
> > > +    "#size-cells":
> > > +      const: 1
> > > +
> > > +  patternProperties:
> > > +    "^ldb@[0-9a-f]+$":
> >
> > No, don't define nodes in if:then:. Where did you get this syntax from?
> I guess I looked over various bindings using patternProperties in if:then:
> blocks but I completely missed the fact that the nodes were actually defined
> outside... And you gave me a good hint in a reply for v4 but, somehow, I failed
> to completely understand what you suggested... :/
>
> Hopefully, the following *is* what you meant:
>
> ...
> patternProperties:
>   "^ldb@[0-9a-f]+$":
>     type: object
>     $ref: /schemas/display/bridge/fsl,ldb.yaml#
>
> if:
>   not:
>     properties:
>       compatible:
>         contains:
>           const: nxp,imx94-lvds-csr
> then:
>   patternProperties:
>     "^ldb@[0-9a-f]+$": false
> else:
>   required:
>     - '#address-cells'
>     - '#size-cells'
> ...
>
> >
> > > +      type: object
> > > +      $ref: /schemas/display/bridge/fsl,ldb.yaml#
> > > +
> > > +  required:
> > > +    - '#address-cells'
> > > +    - '#size-cells'
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -46,7 +68,7 @@ required:
> > >    - power-domains
> > >    - clocks
> > >
> > > -additionalProperties: false
> > > +unevaluatedProperties: false
> >
> > NAK, so schema warned you above syntax is wrong and you decided to
> > silence the warning with this hack, right?
> Indeed, the checks gave me a warning and I thought it was the right thing to
> use 'unevaluatedProperties: false' since additionalProperties cannot recognize
> properties declared in subschemas...
>
> Anyway, with the change above, 'additionalProperties: false' will do just fine.

Laurentiu:

	You can ping me by nxp team first if you have problem or can't
understand Krzysztof's means.

	Krzysztof is quite busy!

Frank

>
> Thanks,
> Laurentiu
>
> >
> > Best regards,
> > Krzysztof
> >

