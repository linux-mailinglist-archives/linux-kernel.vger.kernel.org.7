Return-Path: <linux-kernel+bounces-730384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45808B043E3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ECBA161F94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E3C266F16;
	Mon, 14 Jul 2025 15:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cDlhzaIY"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13814266F0A;
	Mon, 14 Jul 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506681; cv=fail; b=OCFUfQ+SOKfDOYuf7a1zuEc2bI+vlkoSY/knVoaP9FbZ/oT65eUApeFKDLX5w34viLwMBdEv0ncRDi9jBs8ORZG+cNnh7QdWp9fWq3VE85cqSs2u1LNrkb24l8f7F1qn52rrrnPFEzgp/JrXfhTuAPJeOAUUXtyzTBbi2j60tJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506681; c=relaxed/simple;
	bh=crRzB2vm3cq4kuVaHNKrRAxOmjNtQIIIWw6yyzE3ZnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HqGwFK+aOntDx1TELc5H92+c5VjQ1NZMMTTNWZFFymHXBSBim9cAJUoCZJYMzETmgOmSIJoGxDGnFlG8foovmQv3tXW6xS8DZC2KhToQdAPsZwHw3M1UwlUhRjWHKG7vBa8/JcnlBf/szsF2B/wgG45pu+tkzt83fB5i7Oajksg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cDlhzaIY; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgyiGcNdqi3UH9twDz6HWJFAFgReWAqIV7FOxRqjm0d+KY6tA1cCgLQjn5UBcOrz9myEwJ+nsqrOuXwWPfbZyCYjVcUxFc1tav2AgGkkJWWhd82O19V/43J9t2y9oNv8a/TIjgPv99c2hr0JBz3lebQOiwg2QO7anw/BXrvsCcf/re9Mla0k93bx2brqeAWkcFdKKxxws/TWczMr0oawjfI0K3YLjP4L2Sh/2qC4sc8YxWkIf+flzP8XIqkV88sjK8m1Nh5dHkGISr014XgM4r/OmeIcYcUyVAE/8aWv8mm6mGcaYySugNW7hLN3NU+L4St8DH4xw+bYGqMzQ8LVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6eSRS/QUfT6Wk6mhRkc7AV6Za1U32C8QQ4ncHdgzDw=;
 b=s7BfmKfkCykmatW+nYHVjsc/j9PB56fw/ImKrPsENZ4xB5+/wQyXfLGsLA9uIof5y6KhGsTXdu1IQ4QGAiYIcgvfG7TeuRhg1RaNe+Pl4s1UryyoT5kNhGUsIb5rwHjNfzl1AKvWU90zTjbXCJijpVbd879F/T/tMLewt2f0Ffy8LL0dK9WizRRtugG3tuyWhm1pD84+z29zFdAfsGNKJG0PdmnE4BfMls6ThC0qdyWKSsnONU9fFwHtEC/pDiHTJIq6rleWJ4Xvs//jZSRobtZfjoZ4yHIxTOuDcrs3jcNJ7mLlUC/U2GYWLvn7eIkcp+r350ftRj0aZ6PRzevH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6eSRS/QUfT6Wk6mhRkc7AV6Za1U32C8QQ4ncHdgzDw=;
 b=cDlhzaIYssip0idaUxvcGQlVrxlR1wiQEkKr6gSLn+gSczdRlOStcqXExUN3hN574J4jDEbCWGzeYeFRPTkn4+grJy3QaL4RqsNGKbjiSXzo0TPA4jryoqzoqOfJPTzGZvDJvl6yiNmQw8gVQ7Q8RF0T4x2blYkKujtQoeVgefj59V/W1syzMQfVNtIscR/qKOhsuG4p2pk4DHH94dXqCoU2/uH/5fhxq/izvkAD4DD8KpWj21AR7Ok4gNDmKfVOGzVuaqVnEL8Lf/9BsC9uQzfWeVLyQmnTXuyuU9v8+y0Y6YgGcMw24IWWlMjD/WyPGR0mXcFA7/e3H8umnY9NXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB10779.eurprd04.prod.outlook.com (2603:10a6:150:21c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Mon, 14 Jul
 2025 15:24:34 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:24:34 +0000
Date: Mon, 14 Jul 2025 11:24:29 -0400
From: Frank Li <Frank.li@nxp.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Animesh Agarwal <animeshagarwal28@gmail.com>,
	"open list:CLOCKSOURCE, CLOCKEVENT DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Cc: imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] dt-bindings: timer: fsl,ftm-timer: use items for
 reg
Message-ID: <aHUhLSDQ/vdrg3hX@lizhi-Precision-Tower-5810>
References: <20250523141437.533643-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523141437.533643-1-Frank.Li@nxp.com>
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB10779:EE_
X-MS-Office365-Filtering-Correlation-Id: afd22e24-b447-4d4b-1cc9-08ddc2ea895c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eiGZNhWhQg87NvbLAeTOGq1GxifHBT3AEv39QDR1Qa1RDdPLaTLJ1e0ul5xT?=
 =?us-ascii?Q?KeBX4ddGEVDAkEeOc+nVRcOPwZD1/OSBbAraY77bBQMu8nlbcfTj2iC5Ug9N?=
 =?us-ascii?Q?SKKyR92cTYqOiL6X0yDXu8NtER3nSLX3ptFWXkO3/1jc0wh8KMI2Q0ht7Zao?=
 =?us-ascii?Q?caGdLipqDmjfuUK3hryr03XRAtY1dGygUh7FkJk0pxudS6QEqVo00M+ZQaGM?=
 =?us-ascii?Q?wGMvKsqywJfrcVtNJUNGjP5gd8v38uw2QCnlDTQv1b1ufdPtk2sB0S1cD5KA?=
 =?us-ascii?Q?mAnuBdJposvJM/HY/wLcwjtiVsei/wlfGnhh3BV+YrA/cD4aHfSCqB3pHv3x?=
 =?us-ascii?Q?IS23ejkwLZNseXZTYPNXPN11RohsdK7ZVEUKSnLXCxs1upUVE3yDxDVGlHvC?=
 =?us-ascii?Q?YIl972NljgBna2KhrRLu4gpmug7zCMdmoaQSUSnTjQ2rS/TKVajLS+93Ju7O?=
 =?us-ascii?Q?B+Gv6PN+UcfohPpZoVjaEDIjZuVaFdSjuoU5wtlvR3QziTvmnGOgKEUJEI5g?=
 =?us-ascii?Q?viwkkwEV98P+w/9gtsN8ctaOFaOZJNRNf0noa4zdMCRgkga5G8OFYRYL4IC5?=
 =?us-ascii?Q?02sGz/iUf5V+59F06U43mwwDTdBUbAQJ4XXk6mRJLP3TfV7VC8yEz4afeYOG?=
 =?us-ascii?Q?elIiwl9oOuun2z42C+3Nclk7YJq3tYfCUVt9hNEi7+J0Zs7D6oFC7jMjI41R?=
 =?us-ascii?Q?/Nf47j5B8i0F/j0H3r+iAR13hV6C0hc3qLDuk8mtSObETw72umTaNDUbwcGc?=
 =?us-ascii?Q?c2HIUUM9a75xUtgg/Cy1ty7lPjthKGOThMpRUGy07Ye+eVC2NBrIUh1m7mcu?=
 =?us-ascii?Q?+dEI56GR0ECUPtrKQYeXcdxk6oHRyRxZqHlk+pwD1cxBh9uNGu09JlxZAXm8?=
 =?us-ascii?Q?uX4RnONARe7jgCgaLq6eA/nDEryn2lysAX0nLJg68vWsPbS5evvFPFJGE6mm?=
 =?us-ascii?Q?/YS8aIUXt5BfJJ5LTqrbK14czjjicPwnPUcgvolIbyVCg9GXSTv9XjCsI+nT?=
 =?us-ascii?Q?rmt+1rTqEoH1eDpgZZKMSEPN6cEZV/exFDPFxCz/5nYGI41pUtv3dokt7PmB?=
 =?us-ascii?Q?YA0pAs/BCPTU6rB+veaZRbTCKEb4VKloZKJgXCW1KkU1HXEpzdl3GRoQZn7o?=
 =?us-ascii?Q?dnmw6eNg5VyHf1qBXKkjtalQbGSif1BbLrkdLv/Mu0+cAUmMQ+FPSdI5EvKN?=
 =?us-ascii?Q?VzeEuvZd9VDVxPBGDiTKFTFU2HQa7b9xNjVPO7s4Tm8RUSB17zDw0kExfE6s?=
 =?us-ascii?Q?o7YplaDoPk/4V/EIe5sQ3EMMYPHpFNKoeJ4KGkpJpq5Pkr8AWAczKjLPg9uf?=
 =?us-ascii?Q?7B4fbZtN3YcctufbDusvAMwSz5Vbc/Sx0fORMqvLL3Q1blAeqaUpKcmDx6bv?=
 =?us-ascii?Q?iypx65f6rOHNSURgEIk0H++wLcl9Y/Yb4oTeIHnexWSa4iERBMATuX+aL3Fz?=
 =?us-ascii?Q?o44HdhmrlVSjKHaF7qWIoVVrYJZ16r7D8f3+HYxheDALL0c9gGxeLw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6KorDxYyjjkF2Yi5GG/uAkcX9WUKtSIrZYfUoxYLlUqEvjNyjCFcwFfgaoqT?=
 =?us-ascii?Q?+SOab2aM8dI1Tuw8aK4N2mIpaerNQLtmjsQ1HaG2+rdpG4RPzsSRx33Z4ukD?=
 =?us-ascii?Q?rgS1hMy+BQeok+VRXwYtrRCDzI3Rid7zGwFsWufVnXAwD4NSr1NO42CnGT64?=
 =?us-ascii?Q?acltrlGaar0mdzl8xhFVSBpeWVxSRgAtx+g60XgIoG2X7RLOyh9kCLVW28KN?=
 =?us-ascii?Q?7OtxNReftZ3z22DtVATPbAJ0nwLd3rGLqt3Mw7fBq4jHBYF+yh8gGpCcvlaZ?=
 =?us-ascii?Q?sA8H74TrfggprNwf2rNEPEim4oQQZTkCnrF/eJ3msX7L5iJd0y4xCn0LYlem?=
 =?us-ascii?Q?ptHHsT70qRXMgJYOoI0Cewq7kYbBPNqvFoWDwmu9kOEqhw8UaMcioTtdbqDC?=
 =?us-ascii?Q?RYFTzaxhu2Q5CVw/R6qxEp2pUMm8JSUrZ2U1J/1+I03gvBChwsbxOXh+PpXD?=
 =?us-ascii?Q?fF8bC7AgjCFGWXx7oUrbPnXa7/e9WRNspI3XXF+cJOb5t4SoH5risSgze2Lo?=
 =?us-ascii?Q?2QAFZRQuVjM9AEfUBrEzwRdXK91Fn06wMsy4jFWQOl6KOuW6SofRfKrWW148?=
 =?us-ascii?Q?2zcytT5Q4DPvSWvC6tPmxadiIMn0llDMS6GzmJJMf85KAm3enaHTW1kTx9J+?=
 =?us-ascii?Q?nTG7UQrGXWCFrboAVwK2drchTzNq2sC0lYMUHf1GhnH/5e2Q7MDWlYZkoxF4?=
 =?us-ascii?Q?Bd+TfehurgnEMUxDaKAUdwhhU/ilmBU0C6DHBOKOsONmg3jciM2saGY0qxYz?=
 =?us-ascii?Q?PE8j+NjcxXXsmIHtEgajDjC8/JH65nBCHdg2g+pgQxCEBhHrUSeXaZSDVgyo?=
 =?us-ascii?Q?ssUVwEUiH5cfkV7CAW9XEwaVFseOY85yv4cEwM8NpP2RryQe3IqgEukOCLtd?=
 =?us-ascii?Q?uljC9NjHlNmYPICB9+utZdrDE+WS0FekJpr43NKfFq2XJugr9i7g872dZxsx?=
 =?us-ascii?Q?8B3akEBICzVAEG6DjfHcuIwaGRy/02j2ZZq4zIs1DP1kVcSgNLsqWK70OTYY?=
 =?us-ascii?Q?14XatHLFA314FK2GXelK+GoHruXBwKJy69xDkwdXgxtnn21GvDkpQwtuU7sf?=
 =?us-ascii?Q?/leuVqd39mlzx3P3MylT66qTDsrmszO+A5OEJhxmGeHxrOoh98PPFK5/3WoM?=
 =?us-ascii?Q?85ojwplD3HUSqq8DvYcwJR272d+IZA2BX86vXRuKco2lHrjVnTTgn7YxS7LE?=
 =?us-ascii?Q?2ZNYDSi3yUbZ/u4oxyUUeHorCQ8OD9067VCMU7mqhA2yMW1LewMEJtm9ITBM?=
 =?us-ascii?Q?+bmeT6cxFw0KItPrbb/6k1SvEtRMv9fMVb7uUgV8H1QauYaSfdNSYfGXptJs?=
 =?us-ascii?Q?RVphh8pPi581Qtkyc2zA7vrkEFw4yYYbKN4644KHowhpZF5I2xnxVMqVHyhA?=
 =?us-ascii?Q?MDWCJD/LzBR9gpodmx7LZ4onn3uTbDWS0J0i51jW1n5HokrGdV5DeDiASyDZ?=
 =?us-ascii?Q?QwXrcImhFTtxYDyId0FzNnUzox6x4vY+zkdehSgnD8AUa3VtpdEobOiKYZAf?=
 =?us-ascii?Q?7SuoyMWsaiBs3QWfFO9jnajJr4INFfaASsiU5r1yHjTj+Q0MsgLyxw7CPidd?=
 =?us-ascii?Q?9vEsLmPNgnMushmt3zs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd22e24-b447-4d4b-1cc9-08ddc2ea895c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:24:34.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8WeRLTfXRZHP4jFluRXAdcYTHlkOlZjmZJP1tpNilocMEfqEe3WdCzkpYeO88VpC8iDm1uL0BKSTWZ0pDsL/fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10779

On Fri, May 23, 2025 at 10:14:37AM -0400, Frank Li wrote:
> The original txt binding doc is:
>   reg : Specifies base physical address and size of the register sets for
>         the clock event device and clock source device.
>
> And existed dts provide two reg MMIO spaces. So change to use items to
> descript reg property.
>
> Update examples.
>
> Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Daniel Lezcano Or Rob

Krzysztof Kozlowski already reviewed. Could you place pick this one?

Frank

> ---
> change in v2
> - add kk review tag
> - add missed )
> ---
>  Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
> index 0e4a8ddc3de32..e3b61b62521e8 100644
> --- a/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
> +++ b/Documentation/devicetree/bindings/timer/fsl,ftm-timer.yaml
> @@ -14,7 +14,9 @@ properties:
>      const: fsl,ftm-timer
>
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: clock event device
> +      - description: clock source device
>
>    interrupts:
>      maxItems: 1
> @@ -50,7 +52,8 @@ examples:
>
>      ftm@400b8000 {
>          compatible = "fsl,ftm-timer";
> -        reg = <0x400b8000 0x1000>;
> +        reg = <0x400b8000 0x1000>,
> +              <0x400b9000 0x1000>;
>          interrupts = <0 44 IRQ_TYPE_LEVEL_HIGH>;
>          clock-names = "ftm-evt", "ftm-src", "ftm-evt-counter-en", "ftm-src-counter-en";
>          clocks = <&clks VF610_CLK_FTM2>, <&clks VF610_CLK_FTM3>,
> --
> 2.34.1
>

