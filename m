Return-Path: <linux-kernel+bounces-824906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2888B8A70A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C7B3A7C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA70431DD93;
	Fri, 19 Sep 2025 15:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbXuV3+/"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013048.outbound.protection.outlook.com [52.101.83.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D218314A85;
	Fri, 19 Sep 2025 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758297293; cv=fail; b=qZipIR3TgTREEbpxphDOur0fzBSKa6a49Gj6yw+tFIL6JhLjSZS7wfG1Dmh1H2BDc4bPi/17N3UbtcwZP3F8Aj6AxAFFt1H/owdvg79sE5kAbT4QuJw0oP3t5m2F5Wg+mgOfeiDyX/q/wuhFKWGTGmWDEV8KEIzcDZbo08DfopI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758297293; c=relaxed/simple;
	bh=S7KySvwAaekntIxkwW2xuNoIkWPJo70G8IOmf7P/PgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=p1oBDEYVGFSyhOTdhmuOOjNCWaJjw0Nq5MyDlH5D8y0OSLJbHc1vPCFGRYENi7xhEZO8UoG5tHIJb5tTyHYWW7ZHKi00euqOGiYG1NDxH9+HX5e4yn0vHJEOPXxiwWDu8T1k+KgzVlUqMz2Zo7RshYNsAsSOAgZ9x9qcmhgoA9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dbXuV3+/; arc=fail smtp.client-ip=52.101.83.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Duf3te67AD2Kf+u67Ng9KJrHwerUeBQV8JRU0FxXjWU7eD1XF6Bkz19PSRh2LZc7K80MeRiJ0qjourLz3plV7o+bsyHC6pkpfLzPnCFQ3n27SpJimkqtkU7Yd5jbEpQ/dcu8XFJTRkwnPCXTis3TqbQEme1Xn/1LjmSsfctQITQ4TCG+OSpSeCDpnsvRWnqBzgdGO8581vyGZVLNzpN3VmIKO9oi8xUkFjqOGaukwx2ffiEmvKO2HcFPpuuKfylOoWnWTFOkmyJszFe6vH5/sc6CG9h/l5sNC110xohUegVEvnkT+xAO2oELp2Mj/w0cfcxlBSgqsR02xB/hcycrHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BClctQFJJYquncDRNafmSTd91KtQN9dgCd0dJUDvpYw=;
 b=NKqwnTwl/LxXGM6yoF2FrbWS63jh4BpLBlfsvdZhD7oOQCGzYB1O1UF0zDc805ywlTNTfcnxiq1wsbbJSIHcZX2idDYBDNIW4UFCVQSVTRE3QGdt+AGCW46spDW2bve+9/+lTJOZqtOYpfEbmdoIeQMWZISkq1Vdh5z5DCPOVZEnaGIYsu6qwQx5D6h3XQjONHhpTXKmPOHm0rBnz7hS49Iayl1EOM+n3kgRc0363V56V/fO2OFXCz9CAQdnU//pw1rjci5SpgSG63HYhIyNB98b+ul/GO5pjwNcbHFNMlHZwVb3X/OGM9Q5ev5TDMyE1CSp4JDEACRqVEeUBkNwcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BClctQFJJYquncDRNafmSTd91KtQN9dgCd0dJUDvpYw=;
 b=dbXuV3+/XwLx25J8xRjj2oVqYDJXKwKUgYu2oqJgYM0eB9K6woQWwhaxB6sq/0/GIkDG02kRDqa2FBg75ZCvH+Aw6iSDsWL7UmVVlmOur3m7/YRHhh+lENT3pFws397Zl1OdeG/bk9zgvZzLS4nh9RlgoKCt3OpW/MLx/MUnpnWKxISXdSqAYCL11XAaH8KBh4t6rC67UCJOhmEtgAWpVZvCrm+MGPP3KXBRn5ANGcqx5y3hJ/AFe4MH2XTAHOvNYlMQ+bi+u64d5k0L+nhm/Y6acdPwE2o3Y/Zf7CPtTr9ZO6QSYJVpjMQFtPJUEucmrYb0CsXnGtYkHemZ5ZcI6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Fri, 19 Sep
 2025 15:54:49 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 15:54:49 +0000
Date: Fri, 19 Sep 2025 11:54:39 -0400
From: Frank Li <Frank.li@nxp.com>
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Li Jun <jun.li@nxp.com>,
	Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: clock: nxp,imx95-blk-ctl: add support
 for USB in HSIO Block Control
Message-ID: <aM18v1COdp2WZKAF@lizhi-Precision-Tower-5810>
References: <20250919-usb-phy-alt-clk-support-v1-0-57c2a13eea1c@nxp.com>
 <20250919-usb-phy-alt-clk-support-v1-2-57c2a13eea1c@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919-usb-phy-alt-clk-support-v1-2-57c2a13eea1c@nxp.com>
X-ClientProxiedBy: BYAPR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:a03:54::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb7778a-47c4-4484-7a83-08ddf794dcfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|1800799024|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtDIkwVUG1ITLjEnG5dT4WDITf+qLb2xnJGcyYg3oEE6LgWznaVRTc8V0dXT?=
 =?us-ascii?Q?ppnkPNBiozvTYKA4o7MO7EdSMBy8SDpvt6l+1wnIUcio5XRU1/8DAZcfqPvX?=
 =?us-ascii?Q?ZXWsq82GAkkYw5hZxlttg+186IOecGy5vitH5eleJ9lJlgcI7VOnxQKEKUxf?=
 =?us-ascii?Q?oUCd0E/CeSj4wvBX2unJ+wHpfT2GNKmhdsIvlWpBMDFpP7KXDsQFiQNKOxyP?=
 =?us-ascii?Q?oUbaWdhL7Ov0HfuFN4CCIZlYE/dobj0RwKo6I52BEWBpQqlr5NK8ZK0n+Vg4?=
 =?us-ascii?Q?aFZcPV6iw82QApr37cGerA6ikqvIRr3kaAoTQ2YhgwhQs8TB4NaoPwNF/9a/?=
 =?us-ascii?Q?r2riZVtjz3BMs589qRDWJ8WI2Z80WR5QYJ2PZI2+vuRCkPIA9ug01ayB8Rax?=
 =?us-ascii?Q?2J8tdv3KgdE0ZELGRIA5KOWjoHaoeoRb2AxzIgqPv2L6xnDk3kw81IJusPbf?=
 =?us-ascii?Q?a8SSG7LtEZZshIOXiCFjzRREH97t2UiaC11ZrYAApyNPiCNoNezxwZBxjwPH?=
 =?us-ascii?Q?21blim5kZbIRvhNIByIxZdyvb6aKb+lD+3b3OiYEZr40plEYnCx+tcTFDV6G?=
 =?us-ascii?Q?1OIhqh+AYqCA8CdEZy5fg4z6NJWpXf08Dc0XQwUxAt7YYSrx88ScSd4dV5Jd?=
 =?us-ascii?Q?qNgNfHp3d0VODArcpvKFti6q9/rwgmQ429kDBX5zpupv+dn0oRHKiA/+ecAG?=
 =?us-ascii?Q?iHZ/b0OKmRfc1TDAHxWnLeAuOGJDEJWtHswAwZw1L8/YZRvXl2lnwyYnZGgz?=
 =?us-ascii?Q?5VLI8Z2FbV2RLiCQAq65udctZvdBPSdqU9FPDY3aRCl9c0MqaGAYpiY/ijf2?=
 =?us-ascii?Q?yS47YoKKoza7ZWIGywB9QzQpjRIhSpdWf7I8cErfMGjd4c5RCWEANjADWMRj?=
 =?us-ascii?Q?MZC7PBhVwXxlY1ZNaif4zA/doXERZ+ehETHECr8mKGtrMxPYE5o/C5yvPPMf?=
 =?us-ascii?Q?YnLjCYthHMYQyMqZHYRRfz2fVbtmP/D3ZYi9fKoQYf8+S8qQLQdTfVwEtDzK?=
 =?us-ascii?Q?P24gf7WbWIqUT06EDzKegrHYoF+7r4IMOtFzIQvJeMgpC00p1+I8QjKToUnR?=
 =?us-ascii?Q?NpDtVNs2Jz2q8Q5cwaD9c49LxeZnTf01SL2vz8kZ4odxj0q4MCIwczTnGKmP?=
 =?us-ascii?Q?DGU/17Xn1uXVIlCjs1QmriY2Rd3PvOwY2n2SS2pkklOM/CBdjA+Ucm8rzh4h?=
 =?us-ascii?Q?cYPh04fUs+b9zU0gCkCwf25mbwxAE5qPit8373X17uFbl3CHK3ga0hfToTKO?=
 =?us-ascii?Q?nXf3WHZGF/pEVYgCnfeXIo0O5e22cyXh0yn7OhfWiYorZZvVGVj+vkuOBbjB?=
 =?us-ascii?Q?Az7hYbWTkrp2t0bkcBV0qpcOE9UtoqNL1NuxCI+7+RISSYCi/Yrkf/5gy/ec?=
 =?us-ascii?Q?6uRq9cuW/awlXNLLetH8ocWom/Fq6LHBOMU+z/xXR7uECqqMW1IlIoa1fIQe?=
 =?us-ascii?Q?cBaNNLjn7FKui5nKFdLEG5iP5XCHVnokiY32mjiAxQgn4/UvIerFyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(1800799024)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6wtXdUtTdfWB5qvUfnqZG1kP2EALk/BSZIplJfR+zUxstCFB0KVeov7Ap2f/?=
 =?us-ascii?Q?dorxPEDZND+OfkrXgbOOf6Xjz/fFXoZbRzdTpItpIBA+BAHDbMcKZrRBI1X+?=
 =?us-ascii?Q?nESL6hxwb1wqDaijAnL7qvEtKQrooOZxBCW9tkaxKCLffwBnDrhWueZTOVvF?=
 =?us-ascii?Q?Agis7pKa+FnF2TAJ8D2ZbCyqeJxtrTINju/VmpeecbazbNGbvcMISi2xeMuU?=
 =?us-ascii?Q?y3vPii0qo/LYGsKopaKlT9CHIDXHnW4NRL14DJ2S8+mlbPYSa6UZTc4j40Cm?=
 =?us-ascii?Q?2PiUC1slQuTAi0/nmWvWTHmopfiS8w1nqglKqG+b0HEaO0Ibz1Bo9wnGZDUx?=
 =?us-ascii?Q?PoctL76bZ7ONso3/ynPJb8SzrVTFaw4nlQCCnnzCq/E9gwvavJuwUJrQsmjc?=
 =?us-ascii?Q?g6pnQSqnGsVvPrfEcLf4TwWPeWDWfeXr8XmpJ/aiPeWpBxRnQE/9XCjveXnB?=
 =?us-ascii?Q?/FW74KbYbW/bUzov5ulLGu0HntE67oUxHZW/4PJAmL5jCe7YeO9w3J098GVp?=
 =?us-ascii?Q?SIrXOE5SSCMmsyedmr5GmZCbtju2axoNH/fW0K3W5dw1t3SX8FiAcVssokaY?=
 =?us-ascii?Q?Raxb9OwPD4OojvOHVDkATPm8Q2Hv5mVbGJLLRll6weO2RuMtK0crObSYyljx?=
 =?us-ascii?Q?dRw/pqx3Pc+VLkjw7uEdILV2s9qntrde8IkWNh7dRQ+ywGp5m7SFZh1n3OFo?=
 =?us-ascii?Q?uailBKo97WSaWNCSIcwY9qBtBNfECw/oJtYpZXyOh98wuz9W2O4L1B+x7M0y?=
 =?us-ascii?Q?BvNqx6KeaPcQmnihgk/1Riyam5J/ILvHKqfAoVjq41orQRmq0s7yKCR76NCA?=
 =?us-ascii?Q?AW+9TT79PXv7T8dij4XDKpQX4iSuZH+RTHqNYlZGN3DkzdXeivV9DR0AdI+O?=
 =?us-ascii?Q?oRMnWBmcnNtv2bbWv2Qp8qS5S/GK4Fh++0rth4elALcmSFeAd1qzg7xk9ww9?=
 =?us-ascii?Q?1IoR0qG7D9xBtq96hemNZhRamOOIaPSI90Bk0gRNxWej4iBkI0by5cAz9Iqw?=
 =?us-ascii?Q?4RXIMRw6SMWCb3y4M+kJt98jUJpS0i3ncHU3ripxQvJdVM5+wjJFo3aUiivf?=
 =?us-ascii?Q?zo/HlPmBy31WmMKky/QMhOxyq2Vn0XEed2UhV5PNlCkhJHPFdnSj+1E3x+Jg?=
 =?us-ascii?Q?Qd3qppp5eTJe7XBO1pE2lSXqGbADyWID0fuWPmZEGmzPZLdtKUHnGEFLwg9p?=
 =?us-ascii?Q?/zS/ITe2iLg8CrMlxUlZ4nboVdkKMQ2+YoW9/wfwAQQ3X+HHwW0v9624Knaz?=
 =?us-ascii?Q?s9fAEzDjgqdYjFPAfqohJYXjeGWuqfRludOjsfgQ/S5mhqvX0bQikruZBfrN?=
 =?us-ascii?Q?TsvdIq8QULYegDZ4DIIdO4H3xoKv6aqX7HWdo3dqhjoy+yKCVcUqDkP76ZUr?=
 =?us-ascii?Q?w44cFIbIMFZqCA5kWt8LxN2Nt7LAI9GTsqnbN+Ds+7AalcRRnlTrOEN00yT0?=
 =?us-ascii?Q?QXStxChAwDJwnPEu29MptXN8lsGI10SazPe2ATwbdJfI2onBLc/RoW2/3WSk?=
 =?us-ascii?Q?BirThZxCYBE2B/4f3GuFtarywg56VumWIHyuNpYHwyZIbjSNZhuMBmubQn+D?=
 =?us-ascii?Q?g9kX4eWe0x/0Yl82I40=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb7778a-47c4-4484-7a83-08ddf794dcfc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 15:54:49.2462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4EmfJ+g25+euhD7g1JGT9vid0HXF5u8iLwr8SvcWdUAiIXLGGS+8SLBazNvkXQeb8BP/y5mqK8SKzEr+bdgOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

On Fri, Sep 19, 2025 at 03:02:58PM +0800, Xu Yang wrote:
> Add compatible string "nxp,imx95-hsio-usb-blk-ctl" to support USB
> setting in HSIO Block Control.
>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 27403b4c52d6219d31649d75539af93edae0f17d..aa452fb438a9cd5b9a8ad3eff6249abffe576a01 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -18,6 +18,7 @@ properties:
>            - nxp,imx95-camera-csr
>            - nxp,imx95-display-csr
>            - nxp,imx95-hsio-blk-ctl
> +          - nxp,imx95-hsio-usb-blk-ctl
>            - nxp,imx95-lvds-csr
>            - nxp,imx95-netcmix-blk-ctrl
>            - nxp,imx95-vpu-csr
>
> --
> 2.34.1
>

