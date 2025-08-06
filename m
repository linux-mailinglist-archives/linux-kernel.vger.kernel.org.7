Return-Path: <linux-kernel+bounces-757983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D795B1C94F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABBD516BCC2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 15:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D799294A1A;
	Wed,  6 Aug 2025 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="du8P41dR"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B028C2CA;
	Wed,  6 Aug 2025 15:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754495410; cv=fail; b=OogBaaapYRp3pe50aT3jPNOAOxBJ1rXFyzGxq2r4qd5yb5PPYSVJ/1acRHBoWKjqiwVLEMrEDaUChT4pqnmnLXSLY/hGhDsjzSkxv87jaA3MPgdHP9eJWJYUb00WqS2FdVxsNVmk+TPrHG6xDO6QVIJbWhHHB1nxoqXtR0skUeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754495410; c=relaxed/simple;
	bh=Qtd5z+IL+TIU4zAIe0h+DwYrpy5gg9WEvDgqzGAtzc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OijSgBIhrKTIzBHXZSDie9EZ5l4cCmtPyWd9MZIzgmcpvVSkYDTcjHPU64A1X3cIg/12kBESInsMq/RXkpA0KGYcs+IZtNxHo7TOJwoUvkETHcMJ6Xuu2e5e1i7hJ+Ez4NTwsQYDqF7Vn0JNm0+IHz64eWSYgqZXAUhUc3FsyzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=du8P41dR; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5Qpzn3NfN/IvAy1Em8+MhLcH6MX+8VDYm9/g86rnqTCS0GRod2R8YPxZ3wQnNoJQ+oNRv57jwoh0cNyVRnJzapBYWMIsqK6abAXVeQWB+ZHnj/OE3h8JZwaE5128QtbX1czJjt8rCUJ2EAP2NfWzstbfmW2PxP5gDNB9IMzUsmhIR/7DGTXALNcn+OJmfJEGcanJLeY54tTZGVnFbC9p3KF41m0+fisZ2t18Q541SR4gOUJvXGpepQVuOIwpb2qqyDq6LOzgBCcTvDkzaNudhVniXnyH5mJfacdV9QOczgSQsRY+SjhzVCqFidyZ+LCvRz8yWq0KCtRk7HnTLK8IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GBlh2EXE4v5Iz88YzzgipEJftzc0e6YxzaobAyF4o1g=;
 b=IYZpUqKT6jTUKIjCwEuRAD95KugiDQuH42LmVvMY9xen6tuMeAlfIGiH3mW5nODIABV6S5evCIaXcpIl/xELpen8Qr+FMjLO87VCwKgaWw/+8XEagZ80GPl4xv5SA5U80wqvH5Qf6Je90wJcXa583Tedv0QgnRNGTUXO1eRdS4yV8s68QSL0c1lUIvjdPtylaDRTNu4ASq/GxAi+c1pVypMnR6YMnyHvcHt5Z9fCg2BqanY5d0kBNc6eH6clrBnvYRGfigkTpX7Sj4rj73xUYhR5HembO0mht45SlcoVrNmNKYZ1w9HHuqg8uqsBqQeMR+Vl5JbcAthPNtnYENHbvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GBlh2EXE4v5Iz88YzzgipEJftzc0e6YxzaobAyF4o1g=;
 b=du8P41dRz2xoxUrLnv7WQLs6EUqbJXm16M5RNHJFYfSzIOJTfMoweTWUjcxTCyJ+LoNPKBqoTGx6HwmKG6achcury5kEh6lDtCEQsNmnX105aP34O3p2YDZ2WeYQwuBkN59iyEqLjfTVHtBy+wm6StEpr0VBuR3SLieH1RJ65cL9Pg+aY8MneVH1PFmD4Y+KIWJ1GUdLM/HPDEIkb+Rp84EZ01s5J7Fnexg76rehDIqnZgtvJLA3EVzF8QxlGWbZLbOLCB1O4QMRKNkbIXnGGGrt/EXQ/Bxd0VcRUTKr/j04tAE3NcsZRz4lCEGfTWwvb9W6JkB8nnAtzkdqUz61Bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7776.eurprd04.prod.outlook.com (2603:10a6:102:c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 6 Aug
 2025 15:50:06 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 15:50:06 +0000
Date: Wed, 6 Aug 2025 11:50:01 -0400
From: Frank Li <Frank.li@nxp.com>
To: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc: imx@lists.linux.dev, Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/9] dt-bindings: clock: nxp,imx95-blk-ctl: Add
 optional ldb property
Message-ID: <aJN5qZnimoucbC5V@lizhi-Precision-Tower-5810>
References: <20250806150521.2174797-1-laurentiu.palcu@oss.nxp.com>
 <20250806150521.2174797-7-laurentiu.palcu@oss.nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806150521.2174797-7-laurentiu.palcu@oss.nxp.com>
X-ClientProxiedBy: AS4P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ae6292-2515-406e-ae15-08ddd500ea46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4golTJFomthCsHbBcN14tBNFcaM4Z7DGCg8GiBbFaGkpIziIkDOvsoPzc4hQ?=
 =?us-ascii?Q?vZNQ/cYoehdy9mMt0f84ybd6wJEF37GVIXcbfLJesho4+ovbPZ8xUbkWkdU0?=
 =?us-ascii?Q?hyes4jq8Mq5tkAEyo7PtFzjQ42cWaGJxlpXA5H8XOzBBznvuZ8S/u0Tb6liG?=
 =?us-ascii?Q?ttkoqRlfGxDfpWhWndLetcHdrbP0jlfyohZaQvFV5HbDAhV/SIbnIx+srR6h?=
 =?us-ascii?Q?W8IcckZh+Ar/E2YNODyr7gXkEzxEmgTscj1eacybwd1VZqTewhzXc2Aj9IXY?=
 =?us-ascii?Q?uQiahISOCIG/BXf9qoDC4eF05dRpE/ZJxhbkFLOIvNd0u9kv2402Gay5tB6O?=
 =?us-ascii?Q?I5zfM0oK8mQJ66SHB/BDNNLG6cCKHxAwv1hEMpPT2lFEiGTJFRfxEHLDhV91?=
 =?us-ascii?Q?YQrOtWm35q7wJL6ObwT686pwED1qmLTKiPApepCedFHd6Ff3A02274G7T0mF?=
 =?us-ascii?Q?LvBZp5J1/PbXglvleZjyL4TInhdD2eRmDeKh2iFaOR7N5kLJpHIUQnFvxnyR?=
 =?us-ascii?Q?Qy5c8xclis7h5rZVWS6LRd31Z/x6UTGorQ0SqdhpTE4l0/MrbafZjEp354w9?=
 =?us-ascii?Q?1YI1yXm7ibp9jfyzerC/U5odyXYaoiGrHmlGmIL4oVNY1dQzrvTzCSP9Lx2r?=
 =?us-ascii?Q?Ozt75CuOhU+RrUbqnGcovElM1PQUsUDhuG8FrWcsbFJB60MxKbz7aabzzEE/?=
 =?us-ascii?Q?z/zpn84/Ye6rv8QsPVi8yZkK/4swV+qiben81JxKBsJ+AbjIPknkMqEhpbbm?=
 =?us-ascii?Q?g4ny++qjBsiyHIIYHpBf/dy4AjxAujZu6edXO1a/3kIMDxj5QMvmEweV2PnS?=
 =?us-ascii?Q?ptyk4C0lCY6gzFv0/mIGjxXY9V8a1TEgIMxutZSQA4qr3JDz1SRWQ4Z8+BGz?=
 =?us-ascii?Q?Eo0fzKZZncr7hKvNzxO/Ts77efXnYY4+bYizRQPWdDG1NYTMkNXjwgHNC1VA?=
 =?us-ascii?Q?7AdklZ93KASPpNfA+gkfh2LriBJht7NKVzohfpq8YQyeQyDShrPeyyFU8QZQ?=
 =?us-ascii?Q?04ayc86zzP73YjwJPU43Ht4ZQsK8XKotW/EL/ahoZxvkCwiacIRwksT5Jt+d?=
 =?us-ascii?Q?EKwJd3L8y2fzrNVh6ojANXHHKTmKI/LjKgSYgbWwPqDpG0QOGaXM2jVCrnzX?=
 =?us-ascii?Q?LTpaDmIw4r9GHGPKanBmR6gyWjVNBmXxa9Sm9V6pEaXF9foBdqsfLjAt4ImA?=
 =?us-ascii?Q?hdj5LDLpL1PBnopXH0HNsSx70t6Wg6WxyndknliPaZdpiQbVaW8x5j0ZH4xT?=
 =?us-ascii?Q?A7z+8U5MWzJsRphAz+OSA4N/MmFOtkw0tODBpUVVRLxrxrng8FcHmm4aftnJ?=
 =?us-ascii?Q?mkT1uz40HHNgUv8RhmS1sUJ8qFYddOYnHaqLvaXEqRbeX3VReVq8kFD1biav?=
 =?us-ascii?Q?a0Z195MHuN5gFARkhCYLKvObtgc/9pArP3XJaEocI45peLWVtzJA+NqW8r7K?=
 =?us-ascii?Q?KoKd7ieLS6R5cr3/j0XB83LEvJm/sBcLJTe9qPmTVt2bn7P3PBQzZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h+XZX9824AiWGd63L1u6tEwYKCCSvIjPqeCIZD34vzXIXHofTtD1zxIrJjaY?=
 =?us-ascii?Q?4W/Ix1lxui2RlMyvcvZeJ6XUoNyeHL/bz6M0C4vJIJZsbpWFZ3ueErBfUMp3?=
 =?us-ascii?Q?kuhkHSAVu+u8So6H+sWFTv2TO4X01nM+NFlyNOS7zu82apG4eSujJ3VRaWpM?=
 =?us-ascii?Q?Vrw0/3pRxpYC4QFZr/29iZGZYyHbQjkOMXtNdd6EpBqgWew3QFye/TAesB69?=
 =?us-ascii?Q?a+0Ba49NJMbS0ZcaQNyDPXQXKxx5q5L/110/xmf4BHqQMWKxXEQ+TsaDEIFe?=
 =?us-ascii?Q?RkmZUrHlPT28WpxycSbCaPD4yyHlK6EHNFM0ygTBIGwMFXqQu6MIZI2mLSg0?=
 =?us-ascii?Q?yl7Kv67Z4ObnB5FfvwxBQCx31crZDNUtF8VwwuLQlnraaP6qyWrde41iJL4A?=
 =?us-ascii?Q?5VpcMihWXp9PtDlVOX2xGeLat6PWxtaICxsHOvPGxDAuAXSDPhD59MRqqRYO?=
 =?us-ascii?Q?GZieYmedrpXiXuLDfP0oW80pxWt0LTABVtB+Jn/dH1ZZs5WhIAfScrd7Vwi4?=
 =?us-ascii?Q?YZ+tFqgPkKF3CG/XNIfA8WovPOhaeU8nZh0U52CD6MHiAafdStOtIEBmuqU6?=
 =?us-ascii?Q?y4vkpz7v34VWBMsR2yceIkzkBdFUJ6hupq5l+ZgNF6OwpJx6YkHcf4gbAJoa?=
 =?us-ascii?Q?XvmKAVmTz70SkEXgFly5nyYlpsrfOQJCkhBdzX6WpOh4rfCshgtgj3rKzRmM?=
 =?us-ascii?Q?RQQZWyJfBbW5CRm/ZLmG6tOuik2A9vN9QrujUJBKap7qdp7A82MbUgrBwqP2?=
 =?us-ascii?Q?4BPddi0NYhV0i+wuP49kgJWH8sRWQjLauP+ass3+vNh1/fAV+AAz4FTc5pa1?=
 =?us-ascii?Q?wS+0A1ZY8rZM6OE9eFjS/biwp7tVgDeyK3QT63BvbT9w5+qTvoQvuPMldT+A?=
 =?us-ascii?Q?KF6hPIA+Lf0G9uJTujxD6dZNn0T/wSdUU3jQ2yfOWZvy1vB4kLxnJKrccRu0?=
 =?us-ascii?Q?TVb/IruK9NpmCR8pyyipgn0KexAt0Gq9Lie1jmN3FJAM8li9XCCviLT9lD7P?=
 =?us-ascii?Q?9s0NFOnZHu6J6aIX1FXzibk2zamNO4Ic1vgeL0rW8dVx2wU1uLov1T2CCQse?=
 =?us-ascii?Q?WHqvGzIJfsoJikYQYTcpy5irSDXi1S5JHFmaO86+cV1TIBCCUGKx6vagixHP?=
 =?us-ascii?Q?ovN69qPsSv05BB/S5MXZ8DUIocMUOmOJPtL/5aHLt8gRTHar2gA3fX2UuzYG?=
 =?us-ascii?Q?TnHHiS0IYlCYbzWRHZFHrdy4In24rS5p6NIwRgJ9W2RdPinRaAg/qmlfHczB?=
 =?us-ascii?Q?CPpivNAxLrJFw2bmBe+GsM77kyhJ8xUUgUf7swUwPqXQRumkgQBBxbVOkUc7?=
 =?us-ascii?Q?AriMmWl/OZOQKWRorpnweGoiLi7wZKIBqn6yveSm+kL/RFM8wM7SjMfXWLjx?=
 =?us-ascii?Q?X7KYaisEOqn3Fl2J8WHopVKHejQfaQeaQ4RBSI9U42MEMjUk/IjWjZFYIk2j?=
 =?us-ascii?Q?zOhvKl+J7dAz/k7NYC/uS4rseG0HsoqiQ7mi0cxnggynbEFsQqSuRY09CcKJ?=
 =?us-ascii?Q?c35ojYGMP/ms2Q3lKCVYdmBPVcmD1Pdn1cFRJp8LVqnPbHBlHHIM99WjWGBv?=
 =?us-ascii?Q?ADPE83afsz0tpAAH42/qmjw7He8b0M1NhnVx63aQ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae6292-2515-406e-ae15-08ddd500ea46
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 15:50:06.6005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mbm9cat00pXKbjHf7b5yk97NnfnevDTC0uSGKEyBlooJ2tUBWPZs4U/VvJSupOVk0/i6pVAWOm4nJMzmhmazQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7776

On Wed, Aug 06, 2025 at 06:05:13PM +0300, Laurentiu Palcu wrote:
> Since the BLK CTL registers, like the LVDS CSR, can be used to control the
> LVDS Display Bridge controllers, add optional 'ldb' property to handle
> these use cases.
>
> Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  .../devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml         | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> index 27403b4c52d62..836004de4460f 100644
> --- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> +++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
> @@ -39,6 +39,11 @@ properties:
>        ID in its "clocks" phandle cell. See
>        include/dt-bindings/clock/nxp,imx95-clock.h
>
> +patternProperties:
> +  "^ldb@[0-9a-f]+$":
> +    type: object
> +    $ref: /schemas/display/bridge/fsl,ldb.yaml#
> +
>  required:
>    - compatible
>    - reg
> --
> 2.49.0
>

