Return-Path: <linux-kernel+bounces-896241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF0C4FF20
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4B7F3A86CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF86352F9B;
	Tue, 11 Nov 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H9VZ+Fxe"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8E932573D;
	Tue, 11 Nov 2025 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898777; cv=fail; b=CmriVxIJlqOSnG3F/C4tl6YH6Y92I0tLGmBv9aF+hVxG8brnAWJ81Z5C3MeonJlv3xNjzV943z9DQf2TDBiLwBHRxy7T6ga4BBX8/rPO4y7SLHZvxuNs1mqMBHJ0aE7i5k7fV3k3W8A3tsT2JS8B6tcF/7CX/w2uUtaQlQ1n3Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898777; c=relaxed/simple;
	bh=oeexgy6oRPOhk8xlqaHncUlVSsNvEAp0jAwSv2uihhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VpZkSYnF7scRMJHkRS/PmqpnVlAZTFxJtQQPUbBt8z8FUsMB18iyqV3cSgfcrVVvEvESbTse2pKJBXciyB30upqSqv6S7fEaB3YSNUxdNM/BpzVJjfiUwTShn0wgeSgr3CAMD7uqZa36yZzb08bWI7mE8qWT7kJFyFTmJ5eyydc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H9VZ+Fxe; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vr3OtqKQVjzHKjBw1WQb+gKnGypco36o4MpjA5O3vywEE6Rm2YRF44z1SzfvDhKd6S3C7NfeaT/m7ef/cEZkUuKPHdskfkf0YIpNoPKbFfWA5a2xb/oB5nOgq+4x3J2/JX1n+LeoYqmv7VSY12ygt8jk6uJA6TwW89xHg6g7mkFu+8IPPVX8AuiUKUWyLT75FuZxD1As0CKzYmy8avabtY3I1YQ1+5lO1VITUkaR+Jyd/Dvc5Gferlfj91peUl3Kbz8J5dgdtLiVRyWD56ixaHc6uNghT65QImwt1XXZWz5rGtXV5HnPu/d095dO6NrRD+hDZBK5WGCanvEUJkXbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJ2TTVuI+l3ft2C3eRA9OGyBPbsBmnZVvxUvjFt2OMg=;
 b=zDMZpCl7Z4vw0BuMJg6MeHySPch7F1nI4VmlAgsOBJLLttfU437vI94dV0VaT59uybO6PR2zZVxrx5omaH2gR6hSHOnCkglHHPmH/Cf1WG0QkSubayd7m+T+Mc8C22eB779+vkeGCNnKJ76gMVCrsXyoh51QL/dlfLf2eWXV9htOb/scRTV4RX5njBHSuMGjPQPKsZnUEn9IOHMhW/HHCh5XXQHTFmkSjnU1SEFJt0sk+ebMausdF4K5+DYyII4z39cBdVU3xOqJ0xGwuO/cvCU5aGWS/nK6LimOOpUNuF1JUKbxYmWp/D6n3drYbTF4H1uiyAx9ghYmhE83714ziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ2TTVuI+l3ft2C3eRA9OGyBPbsBmnZVvxUvjFt2OMg=;
 b=H9VZ+FxercSKpkGY6x0IsUP4XQgWuwir2bKle+NKrTnujJQklBOq4ouDYGwv6O8myVEHIuBsCXo2vNDRNHpgp9bjj2IkDCR9qYA+9jUnlCIRZ2OWngk4AU18iBuSEH00FxvlgreXbQ5rcVRqNRDv6iJDw8qdjUuY/N0m51HyUxcdx9aOpEtW3VG9blFy6uQb0ZTWNATIcJNc7fF79xyS+Qu3kWobllJht7CFmBBO8Id21kTLL7hOCNRvUL/DYIPKt5a+jE2g+CpzRgYz95DlLqY2ynY6smx+Ahov091ZqREIT/VGqUib3LTyEi/5ARuIsuijUc/9HSBhIjhrb4nLJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DUZPR04MB9982.eurprd04.prod.outlook.com (2603:10a6:10:4db::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 22:06:11 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 22:06:11 +0000
Date: Tue, 11 Nov 2025 17:06:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guoniu Zhou <guoniu.zhou@oss.nxp.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Martin Kepplinger <martink@posteo.de>,
	Purism Kernel Team <kernel@puri.sm>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-media@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Guoniu Zhou <guoniu.zhou@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v7 1/5] media: dt-bindings: nxp,imx8mq-mipi-csi2: Add
 i.MX8ULP compatible string
Message-ID: <aROzSqKEOXQgkWLz@lizhi-Precision-Tower-5810>
References: <20251023-csi2_imx8ulp-v7-0-5ecb081ce79b@nxp.com>
 <20251023-csi2_imx8ulp-v7-1-5ecb081ce79b@nxp.com>
 <20251027000537.GM13023@pendragon.ideasonboard.com>
 <aROg99ryy6RTZZIx@lizhi-Precision-Tower-5810>
 <20251111211025.GA26805@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111211025.GA26805@pendragon.ideasonboard.com>
X-ClientProxiedBy: PH7P221CA0034.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::11) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DUZPR04MB9982:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d2ab3a-664d-4552-e028-08de216e85d6
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|366016|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?b6BZd8MRJviH/JX63zjxyvFOTn1NpCbs4p56srvhlnACcw0jFzVRNhmIzWqw?=
 =?us-ascii?Q?xDRq0GgtGrJlYwZlY4vuIqDDVE8OiliH5x6Jf814S1Xfx61HMXG4M5vp1rzR?=
 =?us-ascii?Q?jERbp8Snx55V57jA33T/11IcRqwYvLrAsysIYJoXaoDbPUIpbPOfTRF0zMTL?=
 =?us-ascii?Q?o4j4IxPeb3xgS/Eb3k6J6UeLWEHfp+agwHXbC14FOb2bjMXvIbNvgV5ZTx9x?=
 =?us-ascii?Q?M/zcFA6+9FlS8sAVsHRybk2QeLvqydMJyFNbyOrjcGv8s9Cs+LybowyQWnkn?=
 =?us-ascii?Q?M2G5K3h+AaKbxBFhX5ZXnMwu63sXIlcuoWHp04uzGxDc6OEUp5SizmBOPcfC?=
 =?us-ascii?Q?tQ1IDs0mhu75cbjYETdFtDRKhqpqxMh+/a7gLhFdjc8pIw5SstSJItkckP38?=
 =?us-ascii?Q?OZUBp4mQHh1MQA3pU4hcQKx9k1M6CFllLjl6VR1tounSxjrGCzvYCUad5Hlf?=
 =?us-ascii?Q?11BJxw2QfoPK61Fhx1P8bk/DCmLa7IGdJlzK4hWE2jronkeJ+Pn/rAPAnhXv?=
 =?us-ascii?Q?j5wgfhcB/P5UiKfq0jGDCtBQVEkC71FfqoZZ/Y46RU8PpkBBalpKfy1Al9qX?=
 =?us-ascii?Q?0MIjehXEqiQP+y/ugPQvyrDYtYgxV3jpn+3S8HP6DgPt2amO8S9R/z75qRnU?=
 =?us-ascii?Q?QZfdH5BZA/9VA7Io4ifxDw598SWX5azvLcZumwRNmZXXOY43auHeT8tM8m5g?=
 =?us-ascii?Q?WZatINS2DM68Atn1rceH/9IAnkvYxIDNtTpPZgX0P66qGx37+6N0u8Vx3A2L?=
 =?us-ascii?Q?XKtyVG3kXb3PrImPTeAaq5lyK5laoJfn4dEYkXTJNDn27Mzey+xTaULNJCoz?=
 =?us-ascii?Q?9gUAGY+puDqjIksaXj1usg51alQ1sZTOl/94q9HAws3Txn04uhlRBjEiO+DB?=
 =?us-ascii?Q?akxJF98rMIP/AqRBd7oUcWjHeyL7sww1rhPT/ctmKlvQ6pxC01kTQhr85G2E?=
 =?us-ascii?Q?c/Sha6/yPskCeqUnyIY+xJ/gwhLtvIEK52Aj81c9e7XLjrCFWyry1RE74Y7r?=
 =?us-ascii?Q?TaXlAQBu1BeF0CUM/QkFM0d9IHr4bE41N+GI2MQs0yGCVpqBaRzgHTIP1pM6?=
 =?us-ascii?Q?pH7NJdITVaq+9sJp6xV9rQy8IsKJZ1M0WfToBftTsjRCpECcU0Y95uUuWsl/?=
 =?us-ascii?Q?RTwvXFQD8VK31hwKNzXGZBS47vPRQRrLtDbpQCknZmgTOUiqcXJPWibfEcfJ?=
 =?us-ascii?Q?X3/1LOmRFkiKLLkoWNZv5Km9bpWcgYbNYGsiSf16cCvnHSYRgyLYXXhir5mY?=
 =?us-ascii?Q?WccCgS+JVBLy0LjFe5FukvdCRiEFwoW+g8fz2LUa1oqrHsvE97HA1f+iQ+Tt?=
 =?us-ascii?Q?fXcfbrrqxtYpOtbohE2Gvll0Qo14MrVc2/T1ZjvATNWUWU3Vgt/A80maYEMv?=
 =?us-ascii?Q?uH94/TJvzdc/QB5Sus8ZK6gsXldUzSUAEm1pWylnbVmrXCM9SI7NSZ8vTvXC?=
 =?us-ascii?Q?tkqCHPPOxURA7QQsy9PXmOgHQYocQjnypea7nsQW7/hyvbkO6JmUPZ7bDj1N?=
 =?us-ascii?Q?oZ2OxmJxHsKV/maXt/l+CJnoq8BgNe/r1RL0?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?9nCArzaXnf1B5KPWCKz6CYChSEdQWCyrg5Rsd2xrdgwoLXHLCJNWHzPcE6UY?=
 =?us-ascii?Q?NlSyFrGdffeqtA73p3UhWlOCOi4Pi8hra2LWP9aesqC29c2fsQcWzojcY3cr?=
 =?us-ascii?Q?L1OrDaU13MLzod4TJk27XYeua9tkT1F7sE7hQ4YGf3SzE48pTw+DtOAMKQBI?=
 =?us-ascii?Q?nGYU/cwE7kNcSGkBSXkbsWy7VFG8Vm/FOj2ZwtMurA/VQ5LEe5lpTZdZkcsX?=
 =?us-ascii?Q?i0UWh01isqFBDCDH2mrmy2FsHnyFk0EHUpoMxHstKSSMFU0tMGr0DHOmt4Qb?=
 =?us-ascii?Q?tdd22k4Fh3T1W2bRS9nmjTIK8S/oev6PfnPdvC8nj3EKTBJC+EsxZog2cqlM?=
 =?us-ascii?Q?1s1Nm5iS5rl+pkD5PaNGbG/6Vof8qdtpR5jcc2uM5Fo1wXwE3Vw/BSLNs4h9?=
 =?us-ascii?Q?aiq1IX2NUqC8rjDkXk0n+Tc2tmr2WUEPQMOg2WZOEt8MWzfixWZDYetl2jUy?=
 =?us-ascii?Q?8UD1zqWLVR3vCoG1XOid2nW+KH1RBAoIq0I9ib0ioUFEmGzR0VwPkSIoKR+C?=
 =?us-ascii?Q?xOqUHOx+UspBIGTv3tposnsdm8POhdYZTs/3L/hZseio7iCTx+6AZdE3LAkN?=
 =?us-ascii?Q?6OHaZrvVuiz9dqU2NDjOKzAw0IdqzVhXK9zwH+6CdL5cGQZPp3LK3NpquvRK?=
 =?us-ascii?Q?qkXnNnE0L1d7pDfd1iah0trphQkMeSYcGKNDU/llHkhag1/rchwyIht5eZKD?=
 =?us-ascii?Q?EZWAK8X3t/2/vDcxYVIo4Zvg1OBQT5dV4CKzdGWrIZP75zCVS3T6ah2Ow+LS?=
 =?us-ascii?Q?/rafMK5Q2jQ/E7VJKouNARlrcsBC/2tJGbk4eRRjzBzRJglQfD1Yc5LZ2GvX?=
 =?us-ascii?Q?R4IChPLTqoY7iCQT0pdWPip/Y1yv6f2kVPRMY0TyQEp2IRn+FicdWcRJzDB4?=
 =?us-ascii?Q?xFjdH6vJrDYPecQ2ybAVQRTk50UUoHORyNoWmm2EFV4Z/qXfkMn0Yw46uCEW?=
 =?us-ascii?Q?7kKsBvSGDzn5BIR9d5lKWCWkhJap6saHKWu+kPqyN749NSUqcjLUxInD6c4N?=
 =?us-ascii?Q?GYaNIvpgboNgOW8L8HR3xCdPc25hX/8aY7hk8qAE47wpcdQiBFogZUup3A78?=
 =?us-ascii?Q?aTCUnt1xSwqlvVdu4Vcj7tSXWkKE2d9T5rI7ruansVYD5CwGSjmisZfNK+sg?=
 =?us-ascii?Q?l52H3dOZSkxRISrw7Yw0Y6oZJml5iEEv/KL7n+s7yCu0a1x4tDplapfMDCli?=
 =?us-ascii?Q?PgtmQ/32nRV69lUh4wcM9uIKAq3ZM74uWOpyunK568rgRiB0o5EowPEhrsQ1?=
 =?us-ascii?Q?ryiymv7W1NE194aLwP3ZF1zSi7zrNRmlTqA/GEn9j5aVof4DaTFXCLzveAYf?=
 =?us-ascii?Q?yU5Qy7g9VoezA7gxL5Hc9osFn3xDv3JpUtt9cdfcq6e0yiNZ3pxqNlt9XL8G?=
 =?us-ascii?Q?XFy3pwTeM/Qj3hzQQLmGpi0QSKjUh2RruZURakgTQiVEF9UOjXJGUWlCX96y?=
 =?us-ascii?Q?EQq/VcAhnopSjQn/LdHtrs/RtjhOlIJMg16WncYl/Ldy1TQi2t7jgrMAyO2c?=
 =?us-ascii?Q?VsGndcitln868MAh0r+DCHzJ0ffzToMoFDLDdWWlt/MbO0dbKkPl7f7wwXEO?=
 =?us-ascii?Q?qYrQHgD7PIlFsQCv750=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d2ab3a-664d-4552-e028-08de216e85d6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 22:06:11.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ugl7PZnZ5fi5JH5jbzcYsltyQVG8oXu9melcWZ2QLo19EDOuSsNZu3HEyYSGnoqI+pF/yCSA7kGzf1Fwod/VHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9982

On Tue, Nov 11, 2025 at 11:10:25PM +0200, Laurent Pinchart wrote:
> On Tue, Nov 11, 2025 at 03:47:51PM -0500, Frank Li wrote:
> > On Mon, Oct 27, 2025 at 02:05:37AM +0200, Laurent Pinchart wrote:
> > > On Thu, Oct 23, 2025 at 05:19:42PM +0800, Guoniu Zhou wrote:
> > > > From: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > >
> > > > The CSI-2 receiver in the i.MX8ULP is almost identical to the version
> > > > present in the i.MX8QXP/QM, but i.MX8ULP CSI-2 controller needs pclk
> > > > clock as the input clock for its APB interface of Control and Status
> > > > register(CSR). So add compatible string fsl,imx8ulp-mipi-csi2 and
> > > > increase maxItems of Clocks (clock-names) to 4 from 3.  And keep the
> > > > same restriction for existing compatible.
> > > >
> > > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>
> > > > ---
> > > >  .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       | 41 ++++++++++++++++++++--
> > > >  1 file changed, 39 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > index 3389bab266a9adbda313c8ad795b998641df12f3..da3978da1cab75292ada3f24837443f7f4ab6418 100644
> > > > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-mipi-csi2.yaml
> > > > @@ -20,6 +20,7 @@ properties:
> > > >        - enum:
> > > >            - fsl,imx8mq-mipi-csi2
> > > >            - fsl,imx8qxp-mipi-csi2
> > > > +          - fsl,imx8ulp-mipi-csi2
> > > >        - items:
> > > >            - const: fsl,imx8qm-mipi-csi2
> > > >            - const: fsl,imx8qxp-mipi-csi2
> > > > @@ -39,12 +40,16 @@ properties:
> > > >                       clock that the RX DPHY receives.
> > > >        - description: ui is the pixel clock (phy_ref up to 333Mhz).
> > > >                       See the reference manual for details.
> > > > +      - description: pclk is clock for csr APB interface.
> > > > +    minItems: 3
> > > >
> > > >    clock-names:
> > > >      items:
> > > >        - const: core
> > > >        - const: esc
> > > >        - const: ui
> > > > +      - const: pclk
> > > > +    minItems: 3
> > > >
> > > >    power-domains:
> > > >      maxItems: 1
> > > > @@ -130,19 +135,51 @@ allOf:
> > > >          compatible:
> > > >            contains:
> > > >              enum:
> > > > -              - fsl,imx8qxp-mipi-csi2
> > > > +              - fsl,imx8ulp-mipi-csi2
> > > > +    then:
> > > > +      properties:
> > > > +        reg:
> > > > +          minItems: 2
> > > > +        resets:
> > > > +          minItems: 2
> > > > +          maxItems: 2
> > > > +        clocks:
> > > > +          minItems: 4
> > > > +        clock-names:
> > > > +          minItems: 4
> > >
> > > Do we need the clock-names constraint ? The DT schemas will enforce that
> > > clocks and clock-names always have the same number of elements.
> >
> > clock-names list already restrict at top section
> >
> > clock-names:
> >   items:
> >     - const: core
> >     - const: esc
> >     - const: ui
> >     - const: pclk
> >   minItems: 3
> >
> > Here just restrict need 4 clocks, instead 3 clock for fsl,imx8ulp-mipi-csi2
>
> I understand that. My point was that the dt-schema will always verify
> that the number of clocks items is equal to the number of clock-names
> items. That's a constraint enforced by the core schemas. As
> clocks: minItems is set to 4, the clock-names: minItems constraint is
> redundant.

I am not sure when have such features. Previous comments from Rob require
clocks and clock-names keep the same at binding yaml.

https://lore.kernel.org/linux-devicetree/20251031000012.GA466250-robh@kernel.org/

Rob have not said that clock-names can be removed.

Do you have any thread, which inidicate we only need limit clocks at
if-else branch?

I also have not found related commit at
https://github.com/devicetree-org/dt-schema.git

Frank

>
> > > > +
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: fsl,imx8qxp-mipi-csi2
> > > >      then:
> > > >        properties:
> > > >          reg:
> > > >            minItems: 2
> > > >          resets:
> > > >            maxItems: 1
> > > > -    else:
> > > > +        clocks:
> > > > +          maxItems: 3
> > > > +        clock-names:
> > > > +          maxItems: 3
> > > > +
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            enum:
> > > > +              - fsl,imx8mq-mipi-csi2
> > > > +    then:
> > > >        properties:
> > > >          reg:
> > > >            maxItems: 1
> > > >          resets:
> > > >            minItems: 3
> > > > +        clocks:
> > > > +          maxItems: 3
> > > > +        clock-names:
> > > > +          maxItems: 3
> > > >        required:
> > > >          - fsl,mipi-phy-gpr
> > > >
> > >
> > > Could you please sort those conditional blocks by alphabetical order of
> > > the compatible strings ?
>
> --
> Regards,
>
> Laurent Pinchart

