Return-Path: <linux-kernel+bounces-861154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF60BF1EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 16:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8397189BFFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB19921CC60;
	Mon, 20 Oct 2025 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nPHUjZTV"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE021DE4C2;
	Mon, 20 Oct 2025 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760971830; cv=fail; b=bU+NO6VjfnDMoeKL3HqrE1Im9pwsFO8zMVpHwWZifEBKNhDMmvKeYzZruoDL+IgArE28kznKKTL+LgDgUjcdICybmM4Z60YAsGExzjxtKLg44JLilLdu6/dJTRFZPRYs1Nvv5PSUFv7SVhEikOtF33CmWI+hjSQv3n8fZZ5tgnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760971830; c=relaxed/simple;
	bh=edDsOj6fO67zTgBdqBQ3kYvjKy8EdQfSl4WIyJnJFF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NWqRns5JoMTzRDIalQjGZ/dMTFdyn2bQuNSjBiaBnVY9aDFWi2g9HqGEkICs6pVjKHuPhMFBH5cJP7Ad6xk3PgGeOgjujo6NvVMgT+S52kadvF2zqeA13U9b01HDI73TKoRzU/AT8CzN4EhkplOMQixnpqRREleV86QXw970GXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nPHUjZTV reason="signature verification failed"; arc=fail smtp.client-ip=52.101.72.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jqZKUuciyn3rxM35K5P+t0/zadN3qeziTU1mHKX/WzUf4RDI+lxkWncJb3gVA3PMz+K1Ig66QE6Ypa6OZiVIxZ2areTPWtPPBwyth7cHlKckvXjuw/5OQNsPDnYMVOt02XhqIatNESfIHV4T9Gk5SqUJNKUQWOoFJhgbHGStEr2BBiwajG1Y6v5ZqtLyoeviGSEQgym5eLTb+l2zT0+hlpbA+lWghKWR1okXkMK7GDlwL3WWlW6xLn478ccwbUcQShgZwaSfHjY6Hdxucmv1Shf9j3g49/z8/zKCvc3V4HZmmFEOIBRseMVcOQ5EzMwPvTDWzfIbOLc+mKGJ7MsR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEMy9dy5w2j1W1HRvBgtVS0GYtEQgzQODPMO8ooU97Y=;
 b=TmH25ecz9nv4B/lQaQUwV+90ek0Wh2ViDlmEPtMfl64vXvQc1IOfltZXed+mkBMYHmpGB0QySDaAGlYBZfAYtM4pgNfqPr/bMrAuj+x2PY8tVh439iSwnz82LJHm3SvWHIRQpP/dY42nK9KMLGyZQ5svjKMnh8EIOOQEKFvN4i7NdYuvlv9MCLT5Fqe9Lp/zHSlGEbRIFcVfE4uNVu1yB5UVDmBMSDo5WSN5rA6IKKmMZxdMGxrVZ/MjvjUToom+7cPX8pIEf38ZDPso4pxP46zyrgKsawI2leWtqmwCNvukOegWnhAc67mlnr/ZY6ALS2xxyHxaON73yNjm+Gi9qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEMy9dy5w2j1W1HRvBgtVS0GYtEQgzQODPMO8ooU97Y=;
 b=nPHUjZTVKLOc5HPpm9dfkpF6SZTbbldvkG2U/xBL2BsSW4V2UuP1dviqWec68r7wb07NLz56gKnb2pituU9oBUPYV0t28ObGhz2Uy/jo2AlVTRV8ATdYD2ay7MIZTOW4J0rDYiJqsjjsOpM8MElU1zxsZwe+JUu1NQAUjAosBX6t8h87qOzipuNN1oQYq6yb3fEL+3FA4J8jOiPPP+YAFE+JRv1rIV3UglKXdW46I/0UOPsCrKGOIv/8LXinERkf0Wnclzw0kYhsIuvqKx6wgPdsbRNvlaSO9qfs+uI63ftRcxMrkOwGaXt1CwY5dHSC85N33g1sSg9T/f6mLEN3FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com (2603:10a6:20b:4ff::22)
 by VI2PR04MB10932.eurprd04.prod.outlook.com (2603:10a6:800:279::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 14:50:25 +0000
Received: from AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e]) by AS4PR04MB9621.eurprd04.prod.outlook.com
 ([fe80::a84d:82bf:a9ff:171e%4]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 14:50:25 +0000
Date: Mon, 20 Oct 2025 10:50:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
Cc: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>, linux-clk@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 7/8] reset: imx8mp-audiomix: Support i.MX8ULP SIM LPAV
Message-ID: <aPZMJb9VwylTIiCM@lizhi-Precision-Tower-5810>
References: <20251017112025.11997-1-laurentiumihalcea111@gmail.com>
 <20251017112025.11997-8-laurentiumihalcea111@gmail.com>
 <aPJZdAQwdoOP3cqN@lizhi-Precision-Tower-5810>
 <64b28a11-337a-42ba-8765-d94b19070d66@gmail.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b28a11-337a-42ba-8765-d94b19070d66@gmail.com>
X-ClientProxiedBy: SJ0PR13CA0059.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::34) To AS4PR04MB9621.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ff::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9621:EE_|VI2PR04MB10932:EE_
X-MS-Office365-Filtering-Correlation-Id: 62d4a905-29a8-407e-c004-08de0fe80086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?3P5Tb6euz3jo+diUxHUkFiKSGcOOtXeLM2HtHx/NL3428b579nJ/DQ2f7X?=
 =?iso-8859-1?Q?Ir8m9XDXx/E0iGo5r0nhejJiO+rJ/CYB8kuuPffNNMQm/fgD53eUOdQioD?=
 =?iso-8859-1?Q?59kndDk2+8BAoIGYKGlkrGGaVsPOIu1ijxnuSWAqEMcerJG+sONt1Gbxfb?=
 =?iso-8859-1?Q?PFwXhrR9WoL7q9G/TQHqcKj0RP6qjlsNJbC/vX8Z2Exhu9G4BbSMYa3+YY?=
 =?iso-8859-1?Q?z1J3wEHh/UJJRRUcZ09fqKqu7Q8bS2arKnfZhteFPoy+TF1woar/mEbNJU?=
 =?iso-8859-1?Q?zXds95bLjjND/YE2D2+Og04zo788Y6ncMpJGvKH8h9AkQH0WlHJzgxb3Nk?=
 =?iso-8859-1?Q?iNp770tLrb521u9O1egp12JdBmsnFpMG5pZWdg5gCkAxHdhS+G5VZVwdVD?=
 =?iso-8859-1?Q?TgWehz5vz32VIRFKR+11lJDxeOwN06w+f2xVEgJSqMNfJf0fwelGAKxReE?=
 =?iso-8859-1?Q?QsPiEaRVDDylUyB8whnvqGWgQ8Qj0GG5pfkrPZaaIhK+K4ob5Akdc+GGa3?=
 =?iso-8859-1?Q?9XDARKcnJrjvY9rU41/OqCOo3f2rChmD+ibVMcTnJuSPDJOc0bue1pVDjn?=
 =?iso-8859-1?Q?8utGDwVEn1/C5Lrbpz2t1R7VdQMpUzby5b2zQg/H1ugcIRha8uhqcWxsiD?=
 =?iso-8859-1?Q?BDQufdHd6GXKZHNE6DdkInmc7W6tSrOnlmhg3621T2UaQkV9WMXlUjznBj?=
 =?iso-8859-1?Q?dRbn6r9gYgT7HkS0ybXlQ3OnlVT8hbtKXlAcXvNkK8q0pEXPbtxp/e5cST?=
 =?iso-8859-1?Q?JktuGIQJJgyYkra+YB3V68POZvxfineycsXwn8VJKbhJ4JpYGj373H3Mz8?=
 =?iso-8859-1?Q?DLTs+Z5YFUcPprLhB9lrqUmpB9qpQC2wf99C2YClqRnWdyxMYT1ugKCT0V?=
 =?iso-8859-1?Q?3TtTG+2bEgo9i65OfSTzhLu6fsS8WzmdJeCY950wIqGeiKtq1K62uPglXm?=
 =?iso-8859-1?Q?wW6olxNrUJGTenzMIEOZ9Hh49EiNJ903ejnHbEf/6KtwmJq06K314wcPad?=
 =?iso-8859-1?Q?at25Js3ROFEA+n9J5gBMplwHimGcYFbyuU9phyij6+6FjZJjWAqXRoMMRV?=
 =?iso-8859-1?Q?JNtDW07+1qLOvONPkiWf0d7T3gdUHLEu41XNgv9iNPRGkDPoO2r74YNAw7?=
 =?iso-8859-1?Q?Vn2CaFwUFGaolLBaf8sosWR3YJn0ksvDS3kGsSoKo1NyVAZ07eZiEQGLtX?=
 =?iso-8859-1?Q?BXEpiuLgqDKpBMElJQy4h+WSj3C9tHCkZZwxcf0KJ/6KkGf9hbhhXZI/H6?=
 =?iso-8859-1?Q?25MWVgWRwBsvLoxzwG45wRJfrttSsGvkZXT4TNNf9LUqSxAfMGVFs7xrDz?=
 =?iso-8859-1?Q?AmPM29t5wuTGg6FKf1nz3RaL/3BXNxTMZE4+RsodulRBPv1q8tS46J+YR+?=
 =?iso-8859-1?Q?tunql79YAWkS8e3c0RAmTvU5KAfosO54LIgizQmFJwwPIlGejx9+0v5FoB?=
 =?iso-8859-1?Q?mf+Lp6P4BKv/8Z1ILq9okMGkAlVhyvk6u2uYVhruYpeOpPDiSp0nr227CQ?=
 =?iso-8859-1?Q?AnEgINABLF1I3ylxqcxbddnzaeizG2GApY1lmVTt4/iYAB0JTegPFKj0wJ?=
 =?iso-8859-1?Q?AbFgQOGrwgEeimuHYK6ENU/R8ot9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9621.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?FFodb9H6gGuwKnvxvF6FljgLEYINDxLvWb2xvdaQuCEmIWvLjfu+/FK58A?=
 =?iso-8859-1?Q?0/1qO8Gs1H6MsTWUp5NhYDKrQ4cHhTHmVa8v2jgzLH2mW70JWwbVTEmYJg?=
 =?iso-8859-1?Q?aNim2pjq/GNA3aFhmGsVPbuE/b52QsAL7Day6dJsqvFWI9bmbs7qCCQ0mL?=
 =?iso-8859-1?Q?RTJ1l60ZFDQy7YwlhGvWuksDK3b4ypajOLsGF37N3eFRxjCnKJoYrKGOdz?=
 =?iso-8859-1?Q?dYehuPDYfPxhewgHgqD2cUkmvhCD8vi2Dpv2izP6uqWks4ZvMwhFKaGS/c?=
 =?iso-8859-1?Q?Skql1Jc1O4SQJVpz7FYDV3OvD9zsiUdx/IQpZatbxCcaxH3K40mcJf2U7t?=
 =?iso-8859-1?Q?yMtwQKzN3AZGF8Ck+FiJkZGNKwsQqcdeN5UZB1oxzekqYMAP9VxWakj0lU?=
 =?iso-8859-1?Q?zOVmhco/lkqFMIQANydbJQQdASYSBgRo3TJWBOogFlohxuVH4/+RPfTcmt?=
 =?iso-8859-1?Q?K4VAqtxniqKNKbQQZpBw64URAij30cTCR1Al0fzq5Dp2WvSPnu2lB2Bcga?=
 =?iso-8859-1?Q?wf9OPllnqH1pdcfQ4mbQmNUlP0A0xTAgzx61kVs/8+OQVB1tKZmeXJZtaD?=
 =?iso-8859-1?Q?jxBste9/m20NBCiQLzPNyZUifxhm5DbSx1enEq22/kgygeAhqWaQNAd/vD?=
 =?iso-8859-1?Q?hOoX3/Eqp6qBYAMOnDbxCsE08ihNAYSpjFaMN+KC/mpLVJZw8EhJlBpL/K?=
 =?iso-8859-1?Q?q9bxLBPR2s8sTQeO05SFWbsaLmkugvMimBelFXgZH4ou01au9zJowq3euP?=
 =?iso-8859-1?Q?kVCagXnWpAsdX1H4xDARvCGg2YVUYXSIvqcZDPeEIMn9P4K2NPuLhynK12?=
 =?iso-8859-1?Q?EgF+OHPx9oPgcd7WhBTZ6fmGOEb8k/jaRY0LtioSzN9DkeGrge/dDEutUE?=
 =?iso-8859-1?Q?p/yODU6NaMzWH+PwU9Hlkg9jPaNGpfVW18Z3tfk/ftCYCUfvKZzYxnP4Xc?=
 =?iso-8859-1?Q?MYNlXMJ+PKceTeL7CynpndNTFqR6qqXBci5T7d3EUh1AEwlzLtZAvrxY0+?=
 =?iso-8859-1?Q?tszZZWjps0oXMzW84PcNfIkxeDSkfo8Xp2ZbJTpsMPK8Eo20PlpE3Bb9WV?=
 =?iso-8859-1?Q?0sfOVSnbz+a917Utdi3eqowO8/afGdyap9stKGshjYRN3W3Q8o81nNmPBC?=
 =?iso-8859-1?Q?/2AZ26YlLj9JOFKnYFa/5K7oOcPxhdXDsmL7k0DPuszjcMPDTWBeFMtbmv?=
 =?iso-8859-1?Q?BfizYoYtfn9cpHw6y3My3APJPWNFaz6lICmO5hWrFOdmfX9ZPohsnZaHYt?=
 =?iso-8859-1?Q?RqWzh2y/G7gUWyBTeJQ29+ar0sByJR6cobFtx/mPh4Kmi8xAm2l3ZAxGSV?=
 =?iso-8859-1?Q?2IGd/94mr4MHl/oWo42AeZxkgjNIfW8hFxUchXjpFf32AeYwBBNP1QYOBS?=
 =?iso-8859-1?Q?bgwlweLRftVvhCjBAaT2SMqScXyMd+7ExfKAh2MZf3d+JaeradIaZ7HfS2?=
 =?iso-8859-1?Q?o/3CP3dV/u6h7H/wuR2vlFp5ZcLzYBSopJmGUGFxk+Fq/zXUlNsmpJVS4P?=
 =?iso-8859-1?Q?GZKklczvvEFGKbSQVj6CILURM13Hxo3KxiPs45VdEkuWC/NWCxhEBqvhzx?=
 =?iso-8859-1?Q?IG68HAERv++bLARrIDiCq+AtS3L9q3DbFGj5B9k9TwHmzrav3smknQ/PqZ?=
 =?iso-8859-1?Q?KOC1KuD/vLBJA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d4a905-29a8-407e-c004-08de0fe80086
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9621.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:50:25.3085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mAsR9+ocyoGlUPUQfM9S0+QiOrlGA+h3vEwYe8Evu+7aKfP5MPoXy5P7CsIgs3TqXv1BpXmkGHkyf4cDJSVt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10932

On Mon, Oct 20, 2025 at 07:29:28AM -0700, Laurentiu Mihalcea wrote:
>
> On 10/17/2025 7:57 AM, Frank Li wrote:
> > On Fri, Oct 17, 2025 at 04:20:24AM -0700, Laurentiu Mihalcea wrote:
> >> From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >>
> >> Support i.MX8ULP's SIM LPAV by adding its reset map definition.
> >>
> >> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> >> Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
> >> ---
> >>  drivers/reset/reset-imx8mp-audiomix.c | 51 +++++++++++++++++++++++++++
> >>  1 file changed, 51 insertions(+)
> >>
> >> diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
> >> index c370913107f5..b333d7c1442a 100644
> >> --- a/drivers/reset/reset-imx8mp-audiomix.c
> >> +++ b/drivers/reset/reset-imx8mp-audiomix.c
> >> @@ -3,6 +3,7 @@
> >>   * Copyright 2024 NXP
> >>   */
> >>
> >> +#include <dt-bindings/reset/fsl,imx8ulp-sim-lpav.h>
> >>  #include <dt-bindings/reset/imx8mp-reset-audiomix.h>
> >>
> >>  #include <linux/auxiliary_bus.h>
> >> @@ -17,6 +18,8 @@
> >>  #define IMX8MP_AUDIOMIX_EARC_RESET_OFFSET	0x200
> >>  #define IMX8MP_AUDIOMIX_DSP_RUNSTALL_OFFSET	0x108
> >>
> >> +#define IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET	0x8
> >> +
> >>  struct imx8mp_reset_map {
> >>  	unsigned int offset;
> >>  	unsigned int mask;
> >> @@ -55,6 +58,50 @@ static const struct imx8mp_reset_info imx8mp_reset_info = {
> >>  	.num_lines = ARRAY_SIZE(imx8mp_reset_map),
> >>  };
> >>
> >> +static const struct imx8mp_reset_map imx8ulp_reset_map[] = {
> >> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(25),
> > Register defination still perfer use macro. If not, let me know.
>
> I see no value in adding defines for the masks (see patch 4 commit message)
>
> in this particular scenario.
>
>
> Is the assignment of the "mask" field for the "struct imx8mp_reset_map" item found
>
> at index  IMX8ULP_SIM_LPAV_HIFI4_DSP_DBG_RST not enough to deduce that the
>
> constant we're using is the mask for the DSP_DBG_RST bit?

This bit is NOT software choose bit, which must be align hardware spec.
Define macro help map name to spec and easy to look for spec by use macro.

There are over thousand result to seach bit 25.

eventhough search SYSCTRL0, may have many SYSCTRL0 in RM.

Frank
>
>
> >
> > Frank
> >> +		.shift = 25,
> >> +		.active_low = false,
> >> +	},
> >> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_RST] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(16),
> >> +		.shift = 16,
> >> +		.active_low = false,
> >> +	},
> >> +	[IMX8ULP_SIM_LPAV_HIFI4_DSP_STALL] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(13),
> >> +		.shift = 13,
> >> +		.active_low = false,
> >> +	},
> >> +	[IMX8ULP_SIM_LPAV_DSI_RST_BYTE_N] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(5),
> >> +		.shift = 5,
> >> +		.active_low = true,
> >> +	},
> >> +	[IMX8ULP_SIM_LPAV_DSI_RST_ESC_N] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(4),
> >> +		.shift = 4,
> >> +		.active_low = true,
> >> +	},
> >> +	[IMX8ULP_SIM_LPAV_DSI_RST_DPI_N] = {
> >> +		.offset = IMX8ULP_SIM_LPAV_SYSCTRL0_OFFSET,
> >> +		.mask = BIT(3),
> >> +		.shift = 3,
> >> +		.active_low = true,
> >> +	},
> >> +};
> >> +
> >> +static const struct imx8mp_reset_info imx8ulp_reset_info = {
> >> +	.map = imx8ulp_reset_map,
> >> +	.num_lines = ARRAY_SIZE(imx8ulp_reset_map),
> >> +};
> >> +
> >>  struct imx8mp_audiomix_reset {
> >>  	struct reset_controller_dev rcdev;
> >>  	void __iomem *base;
> >> @@ -183,6 +230,10 @@ static const struct auxiliary_device_id imx8mp_audiomix_reset_ids[] = {
> >>  		.name = "clk_imx8mp_audiomix.reset",
> >>  		.driver_data = (kernel_ulong_t)&imx8mp_reset_info,
> >>  	},
> >> +	{
> >> +		.name = "clk_imx8ulp_sim_lpav.reset",
> >> +		.driver_data = (kernel_ulong_t)&imx8ulp_reset_info,
> >> +	},
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(auxiliary, imx8mp_audiomix_reset_ids);
> >> --
> >> 2.43.0
> >>

