Return-Path: <linux-kernel+bounces-790526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D76B3A9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0FA17BE92
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BB26FD8E;
	Thu, 28 Aug 2025 18:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4+6nm/q"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C429626CE26;
	Thu, 28 Aug 2025 18:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405035; cv=fail; b=XOqcV9tt7n6nggpIlBeKPp3xne7+NDDN5IJB4vTkmaUQpB/I64FB+/qenBVsQsDIOCSLzTwDjaOIpUO4rhI60O/Hpx8WNhisvIaxzilx4Wb0zknHCVzVcyonWeYkr/RgRd0W2zaG0mB0SkHCow6hzkSQxDec4I23nZCKI086IBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405035; c=relaxed/simple;
	bh=RmmCDhzw/JtT/8NcOBow6TBKoWv76GPhEK4Orz82sNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JPfZ6Swsh3tRPIZT9euhvoII2hzTWCDrU+HmJ2XPRL40iH5ih0QzZ226MLTLK7+beXWSGRwQQP17ELSOu1SBM4IAJ3kjd0ydmCcsUaK6vAQHvXrbXcHp0qDAdDtn2HM+eH61DrvHb6L6/7sjwOIqFSt58OEGSv0JFrleMpZhiPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4+6nm/q; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WdLQ2K5rE33p8B0hIWcbeHJZUiz1QhzKJue3Ity+cMRZfDO6grV3pK2M+r+49HVXELMXZyOz7RtZSyJNTxfGGGbWcRCQnAf3B4borJnjz4QsvUHUsvcGH4CyhwlyrQe8WQQPJeJPY9kO1isv3W3rXHPjKbsF5ANvZShMtGBhTntekGWlsBs7PGwO//suNNMbaVXfQfeyZHIW/DcDxgtNWzuNtYnJx7ip9Tn1tp0tji5EhRnEXyEchS+3soStapY8RbUusFcEq7dDj+7rS3FqtTLAGnOTZbnM2iwh11R3Lpq1hl5UUeNd3YLwXTqZOCw5tLP85dbWLEK0CWfBzhi3+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxtxNXLoFd9ZPSJhLfKXSXsYB3xSsobvMfwsD4z+oV8=;
 b=i390lTqusOnyNwUHY/ckcWInI0RLObqO4oJySEkT3px8CZKV+yGrZWVPZqxjso2OXFf+fICJJu8Sy/Vw7t1NTGRnXfCsFWU6nux9sEO6A5k7JhMM5k/BAOTuQgorQ5kKkriFH6TgdA6RMH2ROw94z3phsjKy0bElCTceiri/eMaAMHAxPr+wsnDyoR4Z6+E1rWbgTIUkas5+ADmApBO4E7rK7heRwZ+4bxKsU9imbHf/2xN4V4Vs8LpUo/DccPHOliQBNIXc89VHpqlruKP6Q8nZMuVkPp4mK6VPXx3SHC+wRG2mg8FMizMSSEIBD9aDIq4yfw3v5DlX95B6Vu++Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxtxNXLoFd9ZPSJhLfKXSXsYB3xSsobvMfwsD4z+oV8=;
 b=E4+6nm/qObXjpSlAqgDfYZ1pyOmpMXXcW1YM4dn4lCVU86aKWiiU8rdpaMP712qZbSi2oJJnoyP+vukafW08O3Yj5YMuFzaTx6Y8OblMLQX5Ve7XQN+/zSu+hL8/sGk1gK6NPG/b6IjHBND5yYlq3KTaAqrhW4urU6lO7ccORFyI+aYZck6VktF6nsm09xiqD1xHjy5XwlZB3i9v5Gy7NIVA2/gndBhiY+OhYtxyFMuj1s3ssuoXPd3epqyzwGndo7nIRftiXWUJuNAu24GbLLR3cZ3hR91kQT3oEtOhsbPmySAc4s1UyN6b98ArMXYw5azxviqSVFtxbHhEbHzPeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA2PR04MB10131.eurprd04.prod.outlook.com (2603:10a6:102:403::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 18:17:10 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9073.009; Thu, 28 Aug 2025
 18:17:10 +0000
Date: Thu, 28 Aug 2025 14:17:02 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: add TQMa91xxLA SOM
Message-ID: <aLCdHv0KcaJsdv6q@lizhi-Precision-Tower-5810>
References: <20250828094745.3733533-1-alexander.stein@ew.tq-group.com>
 <20250828094745.3733533-2-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828094745.3733533-2-alexander.stein@ew.tq-group.com>
X-ClientProxiedBy: SJ0PR05CA0208.namprd05.prod.outlook.com
 (2603:10b6:a03:330::33) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA2PR04MB10131:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b09c2e-d6ed-4cc3-9823-08dde65f1aa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|7416014|376014|366016|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ikV9kaoVTkxpmOYLuB4jVb/kmuKoeUpUrmgm/JIXs5wMiW8UNgCz5TD0Vjam?=
 =?us-ascii?Q?GBk9IfzfbwRhHauCCY+aDHISBpHitJFGDr+58gMSzqTjGUKkuvlB6BD5ahv/?=
 =?us-ascii?Q?91VfMggNF9cqUtgXSdYCV/l5F+MRAKg978iBZx6Wh261NGfKhnin08xyoN1z?=
 =?us-ascii?Q?vHxv5vMMTI7wc7GP0YEbSnVKY72d2HOYEbaBbtfJCEZIuspSz65knk4+n3X0?=
 =?us-ascii?Q?B3Az3Lvy0Jizp7sI8y8TU10n08Z2+ZA41C31f3nCfE8sgWMM06VTI7QjzQQp?=
 =?us-ascii?Q?KtEle2DWWLrFJ+Oj81Bg7kdW0KmCj8gpbaO1DVC2yEAFjcHgzSdLHrssitqJ?=
 =?us-ascii?Q?c7WHVVJUQzV9vwq45vDWPKLBXK/cmS2tWWpb/aqH/GOIGRhwcmHb8+BL9M9x?=
 =?us-ascii?Q?HMGfbRCpLGxTyrVEVw/LuYMo3VXs+s2tUitJ/BKQMF3ojWzU/A1AP1/Mlen9?=
 =?us-ascii?Q?kiiLPidd5KKvLFdn3Z7cg4G7FSyO9O8dvF0Fjfmx//qWIixRr429ncP7Q7s6?=
 =?us-ascii?Q?uM+zou1ap6TEJO6XluyDJZzwB+T9/4HmtSemSWS/JFRrccG8Eoirj7lat4pi?=
 =?us-ascii?Q?InReq/vYMrRcNArhYV87iDpuyFOyMgywbRKOpPMYnoBj+qbcNTpNfT4kHFls?=
 =?us-ascii?Q?98tqrKAkZWX1iR4Hui1/YX/jM/w2fnKyynBgENQi4w6D7pHUbMAPbBTf+Mpe?=
 =?us-ascii?Q?E+HM5klKPcOwH00FijomeEf8mWR1B5LKwc1P5L6KBPyln+yd9Sw42Oav9/SB?=
 =?us-ascii?Q?42iiUU5C1Kb3JtquMtITPLkn/jm56a7HERSaT4FY7WDFGwyo+40/gjMT5syk?=
 =?us-ascii?Q?J6lUDEUO1y6w+Smeafzs31pAd0xkYpYd/6OBVx5xEhfORh0QuFshctRFNnGC?=
 =?us-ascii?Q?1DZgaEXAOC1VwuTClc6k86wVpoNVM1qAth455+ZrXaTEx3qrF+IPOlVM0Ddk?=
 =?us-ascii?Q?+pmZs4hzrCcC/DYyfrpgEk4O0kYacMq76Q97qAamnk8Tg6xjyu1iQ8Vfj5o0?=
 =?us-ascii?Q?fvTJlKLfkF4jlJPYf8bOKGf+hzcej9/nGwLdKR75EiyMAl+AFsYK10/kTpmn?=
 =?us-ascii?Q?cEo5xWsqkqBqcos/tQ9BMH4e73mEgtvLr0GzpfInudjJi3nJRLBl8seORbUk?=
 =?us-ascii?Q?+wt+t6juHPF3hz7KRwfC/kP08t+f8k/PZkua1Dv7pHXV8obbr0g9YSEXOZ7D?=
 =?us-ascii?Q?bN5E7/41UbI+t3BHH/9fzozmycqxe3PCK6edVYqu9iDISA2CdRpV+4dkT2Hh?=
 =?us-ascii?Q?E6K/3Ib7SH5gktcjYf7ugzVzx+zATWtrj0PEJPraIhM5oqGjTiUk83ZWZ/uB?=
 =?us-ascii?Q?mqv4s3Rab/h4tQax4zw50rwRmjZZ7Uf0olof6sDsK9JxcXIveUA10Sm7XKad?=
 =?us-ascii?Q?bEy+2Psm7J5eEwUYm4ekQcNXdyK6YrFn8pt7z2uU56d3NtBVPgfPj/ZmCzPg?=
 =?us-ascii?Q?mC9MtyTiGD99CV1JSLU7OP2oIZb8HsvRsQlllnZ5WdRgs7Npg5dCJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(7416014)(376014)(366016)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IDzJFGsmT6e7KkEenCxLreT6RI8jgEeApLvHAgDmXMYjxLU0yOEVjKHWe+KS?=
 =?us-ascii?Q?tc8OJCgJX70np6ufzIeE15AMnxKnJngtU9Wyq9YdXrRHNoVcv1cnHCxi1H3r?=
 =?us-ascii?Q?fGXR6fo0urxUSteMBsGPnkrComeYb11dl+qX+Miy0fNcimVTxpxfaDJRRlA1?=
 =?us-ascii?Q?VXBtgTpnHT0VSZ2mdYbxWa9MVSP88PYpTMpBrqQuhpz5KYoT3HBWHvokJ4v9?=
 =?us-ascii?Q?fG9tj2IP3s4qKFSkKfvx2t4Qfjr3OTFcw+N3+VhLdspf9/3GHFFokV9KM5l/?=
 =?us-ascii?Q?Mv8OvEazMz+X0+Kx1TkkhlJhUrD60+b/9/yCIH8CyDyx3eJ39mESZJ7Q9gaK?=
 =?us-ascii?Q?qbion9XaF2s0N39CvMKyn+qvBA4ywEL1kJdOOBfLVcZyloRrlL4qIIiflrZL?=
 =?us-ascii?Q?b0k4f4c4NE8Xa9ASqkDG7h4MGTvFwu3pGnWipgWVdrOUz5YKhxycX286MarT?=
 =?us-ascii?Q?mqbs0E7GU+WHckzmU6v9o30OtF1Z0jS+ygr4w5K2hgaZEbz5kpRLaxbfs6/H?=
 =?us-ascii?Q?R6O/1gY5X2vGN5UiQm+QYBUJnWqu+JQJr2o6DxIKl8eDE0hCwQHikvpRV69n?=
 =?us-ascii?Q?B6ya0QPLSY6SGkdqRsE2V3cGiqvSIlsRbEN1udeTmEtEdp9yc2jkbCS/t5vy?=
 =?us-ascii?Q?AxIMtgQvFdmaNeIad2ZXwKh6XbKj8xRvZk7oVyNyqZxwxzFRkX70Fe1cDG7t?=
 =?us-ascii?Q?02c+w0/vPGMa2AKP8aRYI9FtArUPiYf6KmDvrBYfOZf7bR4VlzhKGfe1Vqpu?=
 =?us-ascii?Q?0cdb2cqyma0dqdBxRSoQOdKvSm86+hc/iR/XjKao8LpbHao3eiMFMIPu9FFA?=
 =?us-ascii?Q?4wAgCiQZYkPlBauax5h33+xWRT0lFxr8Kp3i0CQ5J6B9NN9Cpcq1fKcVb7KE?=
 =?us-ascii?Q?fAZnHQ/MoPz9aiINrTRgNfgs3rhnMNW0fEvEM90ecuSRK9MknUh1C5GB//8I?=
 =?us-ascii?Q?IBU1cfYGnGtAihQBvoyXqXyB9kya+X5i1IhetQw5yoJW9DA81bNo5Poo1/3u?=
 =?us-ascii?Q?1LPa7A9rOLsS2U2nCWVSgVI+rdGSq0eacZkkZ9FsxM9DZrFuT16eTBJ08y90?=
 =?us-ascii?Q?gYhSopIAL9E/w18OtcEGYY3gHKp6ShC2KbMBRFULr2Ryx9I8LaRbLmz64nyo?=
 =?us-ascii?Q?riW6XFFemue+Ic2RUDl4dGEvF13xWfnSpDjvtahzHqNGeIhkxXIoRIsrCjUf?=
 =?us-ascii?Q?+kw3O1VWpi7iZ20d2d3HKM6QoTWlEzqeMDIGZlX9wD0nlhm3w+03hXUk1jDi?=
 =?us-ascii?Q?OrWOTJPIEJUhKqeOXFeqCYm/LIZhgH4Jmpfc2IGEa/2WlYyrS3l2MRzUJJfq?=
 =?us-ascii?Q?qqWaE/ECEMG0KAZjhUhkEaDmUV0i/maOO0BAyI7R7OZ1AhJv4aKjutWcKqBr?=
 =?us-ascii?Q?aqnN1fdGInYZhnCv/YbhKMzzFXVkGaJIt/DBMUpSq3/cCTx827xax9KM7ArD?=
 =?us-ascii?Q?mxqHzNddC7JdtjvGHrTw896YYZmQc9cc80g1JUwCcbRb+cb2OtesKFMkdNF9?=
 =?us-ascii?Q?mhsR1pZjuIBE7HGPdyQt0NwF/GcOg4Hcfrdoj6CCUbO8slUXCrD8EjpOb1km?=
 =?us-ascii?Q?xVStw6ooqcZcwns4MaRZ28Yj1W0OFfNlTgSJW6gO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b09c2e-d6ed-4cc3-9823-08dde65f1aa4
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 18:17:10.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF970FlrzyGQODwR/7qGOtCBrx5EMJ/cHcotgfrBmm7KzzZn8lKrZaqgupXCoBmFn4F/LL04Rd+nLN5+4ZlU5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10131

On Thu, Aug 28, 2025 at 11:47:42AM +0200, Alexander Stein wrote:
> TQMa91xxLA is a SOM variant in the TQ-Systems GmbH TQMa91xx series using
> NXP i.MX91 CPU on an LGA type board.
> MBa91xxCA is a starterkit base board for TQMa91xxLA on an adapter board.
>
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index ebafa6ecbcb64..0843c5e9275be 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -1433,6 +1433,24 @@ properties:
>                - fsl,imxrt1170-evk         # i.MXRT1170 EVK Board
>            - const: fsl,imxrt1170
>
> +      - description:
> +          TQMa91xxLA and TQMa91xxCA are two series of feature compatible SOM
> +          using NXP i.MX91 SOC in 11x11 mm package.
> +          TQMa91xxLA is designed to be soldered on different carrier boards.
> +          TQMa91xxCA is a compatible variant using board to board connectors.
> +          All SOM and CPU variants use the same device tree hence only one
> +          compatible is needed. Bootloader disables all features not present
> +          in the assembled SOC.
> +          MBa91xxCA mainboard can be used as starterkit for the SOM
> +          soldered on an adapter board or for the connector variant
> +          MBa91xxLA mainboard is a single board computer using the solderable
> +          SOM variant
> +        items:
> +          - enum:
> +              - tq,imx91-tqma9131-mba91xxca # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM on MBa91xxCA
> +          - const: tq,imx91-tqma9131        # TQ-Systems GmbH i.MX91 TQMa91xxCA/LA SOM
> +          - const: fsl,imx91
> +
>        - description:
>            TQMa93xxLA and TQMa93xxCA are two series of feature compatible SOM
>            using NXP i.MX93 SOC in 11x11 mm package.
> --
> 2.43.0
>

